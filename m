Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92674C35FFC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 08:01:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twzDg-0001Bl-U0; Tue, 25 Mar 2025 04:01:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yangjinqian1@huawei.com>)
 id 1twzDe-0001A1-3o; Tue, 25 Mar 2025 04:01:06 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yangjinqian1@huawei.com>)
 id 1twzDX-0002UQ-QZ; Tue, 25 Mar 2025 04:01:05 -0400
Received: from mail.maildlp.com (unknown [172.19.163.17])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4ZMMkW0FlHz1FNFy;
 Tue, 25 Mar 2025 15:58:59 +0800 (CST)
Received: from kwepemd500011.china.huawei.com (unknown [7.221.188.45])
 by mail.maildlp.com (Postfix) with ESMTPS id D7ABC1A0188;
 Tue, 25 Mar 2025 16:00:45 +0800 (CST)
Received: from kwepemg100001.china.huawei.com (7.202.181.18) by
 kwepemd500011.china.huawei.com (7.221.188.45) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 25 Mar 2025 16:00:45 +0800
Received: from kwepemg100001.china.huawei.com ([7.202.181.18]) by
 kwepemg100001.china.huawei.com ([7.202.181.18]) with mapi id 15.02.1544.011;
 Tue, 25 Mar 2025 16:00:45 +0800
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, lex Williamson
 <alex.williamson@redhat.com>
CC: "Wangzhou (B)" <wangzhou1@hisilicon.com>, liuyonglong
 <liuyonglong@huawei.com>, jiangkunkun <jiangkunkun@huawei.com>, "libai (G)"
 <libai12@huawei.com>, tangchengchang <tangchengchang@huawei.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
Subject: Questions about vfio-pci
Thread-Topic: Questions about vfio-pci
Thread-Index: AdudW06L4raav9tJRXuEMJF2Lkz38w==
Date: Tue, 25 Mar 2025 08:00:45 +0000
Message-ID: <f82e1e01c21e4a75a9a78315c08449ea@huawei.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.67.121.183]
Content-Type: multipart/alternative;
 boundary="_000_f82e1e01c21e4a75a9a78315c08449eahuaweicom_"
MIME-Version: 1.0
Received-SPF: pass client-ip=45.249.212.191;
 envelope-from=yangjinqian1@huawei.com; helo=szxga05-in.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  yangjinqian <yangjinqian1@huawei.com>
From:  yangjinqian via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--_000_f82e1e01c21e4a75a9a78315c08449eahuaweicom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

I'm observing intermittent failures when enabling the HNS3 network port in =
VM using
QEMU with the mainline kernel.

HNS3 drive in kernel:
static int hns3_nic_net_up(struct net_device *netdev)
{
......
       /* enable the vectors */
       for (i =3D 0; i < vector_num; i++)
{
napi_enable(napi);
             enable_irq(vector_irq);
             hns3_mask_vector_irq(tqp_vector, 1);
       }
......
}

When the VM has two vCPUs, the guest HNS3 driver performs two sequential
enable_irq operations (vector_num=3D2). The enable_irq will trap into KVM f=
or interrupt
configuration and exit to QEMU for PCI device emulation. When emulating int=
errupt
enabling in QEMU, vfio_[intx/msi/msix]_enable calls vfio_disable_interrupts=
 to disable
all interrupts on the vdev.

The questions are:

1.      Why does the vfio-pci disable all interrupts of the device before e=
nabling irqs?

2.      Is this a normal vfio-pci process or a problem?

Thanks
Jinqian


--_000_f82e1e01c21e4a75a9a78315c08449eahuaweicom_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:dt=3D"uuid:C2F41010-65B3-11d1-A29F-00AA00C14882" xmlns:m=3D"http://sc=
hemas.microsoft.com/office/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-=
html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Segoe UI";
	panose-1:2 11 5 2 4 2 4 2 2 3;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	text-align:justify;
	text-justify:inter-ideograph;
	font-size:10.5pt;
	font-family:DengXian;}
p.MsoListParagraph, li.MsoListParagraph, div.MsoListParagraph
	{mso-style-priority:34;
	margin:0cm;
	text-align:justify;
	text-justify:inter-ideograph;
	text-indent:21.0pt;
	font-size:10.5pt;
	font-family:DengXian;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:DengXian;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:DengXian;}
/* Page Definitions */
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;}
div.WordSection1
	{page:WordSection1;}
/* List Definitions */
@list l0
	{mso-list-id:1746416320;
	mso-list-type:hybrid;
	mso-list-template-ids:368977896 -2117812486 67698713 67698715 67698703 676=
98713 67698715 67698703 67698713 67698715;}
@list l0:level1
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:18.0pt;
	text-indent:-18.0pt;}
@list l0:level2
	{mso-level-number-format:alpha-lower;
	mso-level-text:"%2\)";
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:42.0pt;
	text-indent:-21.0pt;}
@list l0:level3
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	margin-left:63.0pt;
	text-indent:-21.0pt;}
@list l0:level4
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:84.0pt;
	text-indent:-21.0pt;}
@list l0:level5
	{mso-level-number-format:alpha-lower;
	mso-level-text:"%5\)";
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:105.0pt;
	text-indent:-21.0pt;}
@list l0:level6
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	margin-left:126.0pt;
	text-indent:-21.0pt;}
@list l0:level7
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:147.0pt;
	text-indent:-21.0pt;}
@list l0:level8
	{mso-level-number-format:alpha-lower;
	mso-level-text:"%8\)";
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:168.0pt;
	text-indent:-21.0pt;}
@list l0:level9
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	margin-left:189.0pt;
	text-indent:-21.0pt;}
ol
	{margin-bottom:0cm;}
ul
	{margin-bottom:0cm;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"ZH-CN" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word;text-justify-trim:punctuation">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span lang=3D"EN-US">Hi,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Sego=
e UI&quot;,sans-serif;color:black;background:#FCFCFC">I'm observing intermi=
ttent failures when enabling the HNS3 network port in VM using</span><span =
lang=3D"EN-US" style=3D"font-family:&quot;Segoe UI&quot;,sans-serif;backgro=
und:#FCFCFC"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Sego=
e UI&quot;,sans-serif;color:black;background:#FCFCFC">QEMU with the mainlin=
e kernel.</span><span lang=3D"EN-US" style=3D"font-family:&quot;Segoe UI&qu=
ot;,sans-serif;background:#FCFCFC"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">HNS3 drive in kernel:<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">static int hns3_nic_net_up(stru=
ct net_device *netdev)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">{<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-indent:21.0pt"><span lang=3D"EN-US">..=
....<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; /* enable the vectors */<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; for (i =3D 0; i &lt; vector_num; i&#43;&#43;)<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-indent:21.0pt"><span lang=3D"EN-US">{<=
o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:21.0pt;text-indent:21.0pt"><spa=
n lang=3D"EN-US">napi_enable(napi);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enable_irq(vector_irq);<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hns3_mask_vector_irq(tqp_vector, 1);<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; }<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-indent:21.0pt"><span lang=3D"EN-US">..=
....<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">}<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">When the VM has two vCPUs, the =
guest HNS3 driver performs two sequential<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">enable_irq operations (vector_n=
um=3D2). The enable_irq will trap into KVM for interrupt<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">configuration and exit to QEMU =
for PCI device emulation. When emulating interrupt<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">enabling in QEMU, vfio_[intx/ms=
i/msix]_enable calls vfio_disable_interrupts to disable<o:p></o:p></span></=
p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">all interrupts on the vdev.<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">The questions are:<o:p></o:p></=
span></p>
<p class=3D"MsoListParagraph" style=3D"margin-left:18.0pt;text-indent:-18.0=
pt;mso-list:l0 level1 lfo1">
<![if !supportLists]><span lang=3D"EN-US"><span style=3D"mso-list:Ignore">1=
.<span style=3D"font:7.0pt &quot;Times New Roman&quot;">&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;
</span></span></span><![endif]><span lang=3D"EN-US">Why does the vfio-pci d=
isable all interrupts of the device before enabling irqs?<o:p></o:p></span>=
</p>
<p class=3D"MsoListParagraph" style=3D"margin-left:18.0pt;text-indent:-18.0=
pt;mso-list:l0 level1 lfo1">
<![if !supportLists]><span lang=3D"EN-US"><span style=3D"mso-list:Ignore">2=
.<span style=3D"font:7.0pt &quot;Times New Roman&quot;">&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;
</span></span></span><![endif]><span lang=3D"EN-US">Is this a normal vfio-p=
ci process or a problem?<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Thanks<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Jinqian<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
</div>
</body>
</html>

--_000_f82e1e01c21e4a75a9a78315c08449eahuaweicom_--

