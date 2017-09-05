<?xml version="1.0" encoding="utf-8" ?>
<xsl:stylesheet version="1.0" xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
 <xsl:output method="html" version="5" doctype-system="about:legacy-compat" encoding="utf-8" indent="yes"/>
 <xsl:strip-space elements="*"/>

  <!--  Law =================================================================== -->
 <xsl:template match="Law">
  <html><xsl:apply-templates select="LawBody"/></html>
 </xsl:template>

  <!--  LawBody =============================================================== -->
 <xsl:template match="LawBody | NewProvision">
  <head>
   <title><xsl:value-of select="LawTitle"/></title>
  </head>
  <xsl:text>&#10;</xsl:text>
  <body data-type="book">
   <xsl:text>&#10;</xsl:text>
   <section data-type="titlepage">
    <h1><xsl:value-of select="LawTitle"/></h1>
    <div><xsl:apply-templates select="EnactStatement"/></div>
   </section>
   <xsl:text>&#10;</xsl:text>
   <xsl:apply-templates select="*[not(name()='LawTitle') and not(name()='EnactStatement')]"/>
   <xsl:text>&#10;</xsl:text>
   <section role="doc-index" data-type="index"/>
  </body>
 </xsl:template>

 <xsl:template match="EnactStatement"><xsl:apply-templates/><br/></xsl:template>

  <!--  TOC ==================================================================== -->
 <xsl:template match="TOC">
  <nav data-type="toc">
   <h1><xsl:value-of select="TOCLabel"/></h1>
   <ol>
    <xsl:text>&#10;</xsl:text>
    <xsl:apply-templates select="*[not(name()='TOCLabel')]"/>
   </ol>
  </nav>
  <xsl:text>&#10;</xsl:text>
 </xsl:template>

 <xsl:template match="TOCPreambleLabel">
  <li><a href="#Preamble"><xsl:apply-templates/></a></li><xsl:text>&#10;</xsl:text>
 </xsl:template>

 <xsl:template match="TOCPart">
  <li>
   <a>
    <xsl:attribute name="href">#p<xsl:value-of select="@Num"/></xsl:attribute>
    <xsl:apply-templates select="*[contains(name(), 'Title')]"/><xsl:apply-templates select="ArticleRange"/>
   </a>
   <xsl:text>&#10;</xsl:text>
   <ol><xsl:apply-templates select="*[starts-with(name(), 'TOC')]"/></ol>
  </li>
  <xsl:text>&#10;</xsl:text>
 </xsl:template>

 <xsl:template match="TOCChapter | TOCSection | TOCSubsection | TOCDivision">
  <li>
   <a>
   <xsl:attribute name="href">
    <xsl:choose>
     <xsl:when test="name()='TOCChapter'">#p<xsl:value-of select="../@Num"/>c<xsl:value-of select="@Num"/></xsl:when>
     <xsl:when test="name()='TOCSection'">#p<xsl:value-of select="../../@Num"/>c<xsl:value-of select="../@Num"/>s<xsl:value-of select="@Num"/></xsl:when>
     <xsl:when test="name()='TOCSubsection'">#p<xsl:value-of select="../../../@Num"/>c<xsl:value-of select="../../@Num"/>s<xsl:value-of select="../@Num"/>ss<xsl:value-of select="@Num"/></xsl:when>
     <xsl:when test="name()='TOCDivision'">#p<xsl:value-of select="../../../../@Num"/>c<xsl:value-of select="../../../@Num"/>s<xsl:value-of select="../../@Num"/>ss<xsl:value-of select="../@Num"/>d<xsl:value-of select="@Num"/></xsl:when>
    </xsl:choose>
   </xsl:attribute>
    <xsl:apply-templates select="*[contains(name(), 'Title')]"/><xsl:apply-templates select="ArticleRange"/>
   </a>
   <xsl:if test="*[starts-with(name(), 'TOC')]">
    <xsl:text>&#10;</xsl:text>
    <ol><xsl:apply-templates select="*[starts-with(name(), 'TOC')]"/></ol>
   </xsl:if>
  </li>
  <xsl:text>&#10;</xsl:text>
 </xsl:template>

 <xsl:template match="TOCArticle">
  <li>
   <a>
    <xsl:attribute name="href">#a<xsl:value-of select="@Num"/></xsl:attribute>
    <xsl:apply-templates select="ArticleTitle"/><xsl:apply-templates select="ArticleCaption"/>
   </a>
  </li>
  <xsl:text>&#10;</xsl:text>
 </xsl:template>

 <xsl:template match="TOCSupplProvision">
  <li>
   <a href="#sp1"><xsl:apply-templates select="SupplProvisionLabel"/></a>
   <ol><xsl:apply-templates select="*[starts-with(name(), 'TOC')]"/></ol>
  </li>
  <xsl:text>&#10;</xsl:text>
 </xsl:template>

 <xsl:template match="TOCAppdxTableLabel">
  <li><a href="#AppdxTable"><xsl:apply-templates/></a></li>
  <xsl:text>&#10;</xsl:text>
 </xsl:template>

 <xsl:template match="ArticleRange"><xsl:apply-templates/></xsl:template>

  <!--  Preamble ============================================================== -->
 <xsl:template match="Preamble">
  <section role="doc-preface" data-type="preface" id="Preamble">
   <h1>前文</h1>
   <xsl:apply-templates/>
  </section>
 </xsl:template>

  <!--  MainProvision ========================================================= -->
 <xsl:template match="MainProvision">
  <xsl:choose>
   <xsl:when test="count(Part)=0 and count(Chapter)=0"><section role="doc-chapter" data-type="chapter"><xsl:apply-templates/></section></xsl:when>
   <xsl:otherwise><xsl:apply-templates/></xsl:otherwise>
  </xsl:choose>
 </xsl:template>

  <!--  Part ================================================================== -->
 <xsl:template match="Part">
  <div role="doc-part" data-type="part">
   <xsl:attribute name="id">p<xsl:value-of select="@Num"/></xsl:attribute>
   <h1><xsl:apply-templates select="*[contains(name(), 'Title')]"/></h1>
   <xsl:text>&#10;</xsl:text>
   <xsl:apply-templates select="*[not(contains(name(), 'Title'))]"/>
  </div>
  <xsl:text>&#10;</xsl:text>
 </xsl:template>

  <!--  Chapter =============================================================== -->
 <xsl:template match="Chapter">
  <section role="doc-chapter" data-type="chapter">
   <xsl:attribute name="id">p<xsl:value-of select="../@Num"/>c<xsl:value-of select="@Num"/></xsl:attribute>
   <h1><xsl:apply-templates select="*[contains(name(), 'Title')]"/></h1>
   <xsl:text>&#10;</xsl:text>
   <xsl:apply-templates select="*[not(contains(name(), 'Title'))]"/>
  </section>
  <xsl:text>&#10;</xsl:text>
 </xsl:template>

  <!--  Section =============================================================== -->
  <!--  Subsection ============================================================ -->
  <!--  Division ============================================================== -->
 <xsl:template match="Section | Subsection | Division">
  <xsl:variable name="level">
   <xsl:choose>
    <xsl:when test="name()='Section'">1</xsl:when>
    <xsl:when test="name()='Subsection'">2</xsl:when>
    <xsl:when test="name()='Division'">3</xsl:when>
   </xsl:choose>
  </xsl:variable>
  <section>
   <xsl:attribute name="data-type">sect<xsl:value-of select="$level"/></xsl:attribute>
   <xsl:attribute name="id">
    <xsl:choose>
     <xsl:when test="$level=1">p<xsl:value-of select="../../@Num"/>c<xsl:value-of select="../@Num"/>s<xsl:value-of select="@Num"/></xsl:when>
     <xsl:when test="$level=2">p<xsl:value-of select="../../../@Num"/>c<xsl:value-of select="../../@Num"/>s<xsl:value-of select="../@Num"/>ss<xsl:value-of select="@Num"/></xsl:when>
     <xsl:when test="$level=3">p<xsl:value-of select="../../../../@Num"/>c<xsl:value-of select="../../../@Num"/>s<xsl:value-of select="../../@Num"/>ss<xsl:value-of select="../@Num"/>d<xsl:value-of select="@Num"/></xsl:when>
    </xsl:choose>
   </xsl:attribute>
   <xsl:element name="h{$level}"><xsl:apply-templates select="*[contains(name(), 'Title')]"/></xsl:element>
   <xsl:text>&#10;</xsl:text>
   <xsl:apply-templates select="*[not(contains(name(), 'Title'))]"/>
  </section>
  <xsl:text>&#10;</xsl:text>
 </xsl:template>

  <!--  Article =============================================================== -->
 <xsl:template match="Article">
  <section data-type="sect4">
   <xsl:if test="../@AmendLawNum=''">
    <xsl:attribute name="id"><xsl:text>a</xsl:text><xsl:value-of select="@Num"/></xsl:attribute>
   </xsl:if>
   <h4><xsl:apply-templates select="ArticleTitle"/><xsl:apply-templates select="ArticleCaption"/></h4>
   <xsl:text>&#10;</xsl:text>
   <xsl:apply-templates select="*[not(starts-with(name(), 'Article'))]"/>
  </section>
  <xsl:text>&#10;</xsl:text>
 </xsl:template>
 <xsl:template match="ArticleCaption"><xsl:apply-templates/></xsl:template>

  <!--  Paragraph ============================================================= -->
 <xsl:template match="Paragraph">
  <section data-type="sect5">
   <xsl:if test="ParagraphNum/text()!=''"><h5><xsl:apply-templates select="ParagraphNum"/><xsl:apply-templates select="ParagraphCaption"/></h5></xsl:if>
   <p><xsl:apply-templates select="ParagraphSentence"/></p>
   <xsl:apply-templates select="*[not(starts-with(name(), 'Paragraph'))]"/>
  </section>
  <xsl:text>&#10;</xsl:text>
 </xsl:template>
 <xsl:template match="ParagraphSentence"><xsl:apply-templates/></xsl:template>

  <!--  SupplNote ============================================================= -->
 <xsl:template match="SupplNote"><div><xsl:apply-templates/></div></xsl:template>

  <!--  AmendProvision ======================================================== -->
 <xsl:template match="AmendProvision"><div><xsl:apply-templates/></div></xsl:template>
 <xsl:template match="AmendProvisionSentence"><p><xsl:apply-templates/></p></xsl:template>

  <!--  Class ================================================================= -->
 <xsl:template match="Class"><div><xsl:apply-templates/></div></xsl:template>
 <xsl:template match="ClassTitle"><span><xsl:apply-templates/></span></xsl:template>
 <xsl:template match="ClassSentence"><div><xsl:apply-templates/></div></xsl:template>

  <!--  Item ================================================================== -->
 <xsl:template match="Item | Subitem1 | Subitem2 | Subitem3 | Subitem4 | Subitem5 | Subitem6 | Subitem7 | Subitem8 | Subitem9 | Subitem10">
  <ul>
   <li>
    <b><xsl:apply-templates select="*[contains(name(), 'Title')]"/></b><xsl:text>&#160;</xsl:text>
    <xsl:apply-templates select="*[contains(name(), 'Sentence')]"/>
    <xsl:apply-templates select="*[not(contains(name(), 'Title')) and not(contains(name(), 'Sentence'))]"/>
   </li>
  </ul>
  <xsl:text>&#10;</xsl:text>
 </xsl:template>

  <!--  Sentence ============================================================== -->
 <xsl:template match="Sentence"><xsl:apply-templates/></xsl:template>

  <!--  Column ================================================================ -->
 <xsl:template match="Column">
  <span>
   <xsl:if test="@Align"><xsl:attribute name="style">text-align: <xsl:value-of select="@Align"/>;</xsl:attribute></xsl:if>
   <xsl:apply-templates/>
  </span>
  <xsl:text>&#160;</xsl:text>
 </xsl:template>

  <!--  SupplProvision ======================================================== -->
 <xsl:template match="SupplProvision">
  <section role="doc-appendix" data-type="appendix">
   <xsl:attribute name="id">sp<xsl:number/></xsl:attribute>
   <h1><xsl:apply-templates select="SupplProvisionLabel"/><xsl:if test="@AmendLawNum"><small class="AmendLawNum">(<xsl:value-of select="@AmendLawNum"/>)</small></xsl:if></h1>
   <xsl:text>&#10;</xsl:text>
   <xsl:choose>
    <xsl:when test="Paragraph"><xsl:apply-templates select="*[name()!='SupplProvisionLabel']"/></xsl:when>
    <xsl:otherwise><xsl:apply-templates select="*[name()!='SupplProvisionLabel']"/></xsl:otherwise>
   </xsl:choose>
  </section>
  <xsl:text>&#10;</xsl:text>
 </xsl:template>

  <!--  AppdxTable ============================================================ -->
  <!--  AppdxNote ============================================================= -->
  <!--  AppdxStyle ============================================================ -->
  <!--  AppdxFormat =========================================================== -->
  <!--  Appdx ================================================================= -->
  <!--  AppdxFig ============================================================== -->
 <xsl:template match="SupplProvisionAppdxTable | SupplProvisionAppdxStyle | SupplProvisionAppdx | AppdxTable | AppdxNote | AppdxNote | AppdxFormat | Appdx | AppdxFig">
  <section role="doc-appendix" data-type="appendix"><xsl:apply-templates/></section>
 </xsl:template>

 <xsl:template match="SupplProvisionAppdxTableTitle | SupplProvisionAppdxStyleTitle | AppdxTableTitle | AppdxNoteTitle | AppdxNoteTitle | AppdxFormatTitle | AppdxFigTitle">
  <h5><xsl:apply-templates/></h5>
 </xsl:template>

 <xsl:template match="ArithFormulaNum"><span><xsl:apply-templates/></span></xsl:template>
 <xsl:template match="ArithFormula"><span><xsl:apply-templates/></span></xsl:template>

  <!--  Table ================================================================= -->
  <!--  Fig =================================================================== -->
 <xsl:template match="TableStruct | FigStruct">
  <figure><xsl:apply-templates/></figure>
 </xsl:template>

 <xsl:template match="TableStructTitle | FigStructTitle">
  <figcaption><xsl:apply-templates/></figcaption>
 </xsl:template>

 <xsl:template match="Table">            <table><xsl:apply-templates/></table></xsl:template>
 <xsl:template match="TableHeaderColumn">   <th><xsl:apply-templates/></th></xsl:template>
 <xsl:template match="TableHeaderRow">      <tr><xsl:apply-templates/></tr></xsl:template>
 <xsl:template match="TableRow">            <tr><xsl:apply-templates/></tr></xsl:template>
 <xsl:template match="TableColumn">
  <td>
   <xsl:if test="@BorderTop or @BorderBottom or @BorderLeft or @BorderRight or @Align or @Valign">
    <xsl:attribute name="style">
     <xsl:if test="@BorderTop">border-top-style: <xsl:value-of select="@BorderTop"/>;</xsl:if>
     <xsl:if test="@BorderBottom">border-bottom-style: <xsl:value-of select="@BorderTop"/>;</xsl:if>
     <xsl:if test="@BorderLeft">border-left-style: <xsl:value-of select="@BorderLeft"/>;</xsl:if>
     <xsl:if test="@BorderRight">border-right-style: <xsl:value-of select="@BorderRight"/>;</xsl:if>
     <xsl:if test="@Align">text-align: <xsl:value-of select="@Align"/>;</xsl:if>
     <xsl:if test="@Valign">vertical-align: <xsl:value-of select="@Valign"/>;</xsl:if>
    </xsl:attribute>
   </xsl:if>
   <xsl:if test="@rowspan"><xsl:attribute name="rowspan"><xsl:value-of select="@rowspan"/></xsl:attribute></xsl:if>
   <xsl:if test="@colspan"><xsl:attribute name="colspan"><xsl:value-of select="@colspan"/></xsl:attribute></xsl:if>
   <xsl:apply-templates/>
  </td>
 </xsl:template>

 <xsl:template match="Fig">
  <img>
   <xsl:attribute name="src"><xsl:value-of select="@src"/></xsl:attribute>
  </img>
 </xsl:template>

  <!--  Note ================================================================== -->
 <xsl:template match="NoteStruct"><div data-type="note"><xsl:apply-templates/></div></xsl:template>
 <xsl:template match="NoteStructTitle"><h6><xsl:apply-templates/></h6></xsl:template>
 <xsl:template match="Note"><div><xsl:apply-templates/></div></xsl:template>
  <!--  Style ================================================================= -->
 <xsl:template match="StyleStruct"><div><xsl:apply-templates/></div></xsl:template>
 <xsl:template match="StyleStructTitle"><h6><xsl:apply-templates/></h6></xsl:template>
 <xsl:template match="Style"><div><xsl:apply-templates/></div></xsl:template>
  <!--  Format ================================================================ -->
 <xsl:template match="FormatStruct"><div><xsl:apply-templates/></div></xsl:template>
 <xsl:template match="FormatStructTitle"><h6><xsl:apply-templates/></h6></xsl:template>
 <xsl:template match="Format"><div><xsl:apply-templates/></div> </xsl:template>
  <!--  Common ================================================================ -->
 <xsl:template match="RelatedArticleNum"><span><xsl:apply-templates/></span></xsl:template>
  <!--  Remarks =============================================================== -->
 <xsl:template match="Remarks"><div><xsl:apply-templates/></div></xsl:template>
 <xsl:template match="RemarksLabel"><h6><xsl:apply-templates/></h6></xsl:template>

  <!--  List ================================================================== -->
 <xsl:template match="List | Sublist1 | Sublist2 | Sublist3">
  <ul><xsl:apply-templates/></ul>
 </xsl:template>

 <xsl:template match="ListSentence | Sublist1Sentence | Sublist2Sentence | Sublist3Sentence">
  <li><xsl:apply-templates/></li>
 </xsl:template>

  <!--  QuoteStruct =========================================================== -->
 <xsl:template match="QuoteStruct">
  <blockquote><xsl:apply-templates/></blockquote>
 </xsl:template>

  <!--  Ruby ================================================================== -->
  <!--  Sup =================================================================== -->
  <!--  Sub =================================================================== -->
 <xsl:template match="Ruby | Rt | Sup | Sub">
  <xsl:element name="{translate(name(), 'RS', 'rs')}"><xsl:apply-templates/></xsl:element>
 </xsl:template>

  <!--  Line ================================================================== -->
 <xsl:template match="Line">
  <div>
   <xsl:if test="@Style"><xsl:attribute name="style">border-style: <xsl:value-of select="@Style"/>;</xsl:attribute></xsl:if>
   <xsl:apply-templates/>
  </div>
 </xsl:template>
</xsl:stylesheet>
