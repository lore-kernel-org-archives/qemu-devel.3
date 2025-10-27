Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C3D7CCF9EC
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 12:58:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDMmN-0002HL-Lw; Mon, 27 Oct 2025 08:56:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaoguohan_salmon@163.com>)
 id 1vDCIw-0001AV-HN
 for qemu-devel@nongnu.org; Sun, 26 Oct 2025 21:45:50 -0400
Received: from m16.mail.163.com ([117.135.210.3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaoguohan_salmon@163.com>)
 id 1vDCIt-0004bF-EA
 for qemu-devel@nongnu.org; Sun, 26 Oct 2025 21:45:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:Content-Type:
 MIME-Version; bh=74vbux3O9aOpjh2GDNxVJNluH5LBz4mgBHYS71a33wc=;
 b=hNHtpcnvxjKBCfGpeUFRGV0gZHd0t3nfDUZ650PWk6YbaRFLCctCVtXCux8W51
 7lL20OjYQFp3R69X+JamQ96LcesmXcm5uKAy/QkRqSxgyqQ7Q5T4sudcLLIp5wgF
 B+m3Cx3p3JgsNyDObCp4ikYE2pBMdPGOl5L+5JPD/eM3w=
Received: from SEZPR03MB6714.apcprd03.prod.outlook.com (unknown [])
 by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wB3v7G2zv5oi1OfBA--.165S2;
 Mon, 27 Oct 2025 09:45:28 +0800 (CST)
From: "zhaoguohan_salmon@163.com" <zhaoguohan_salmon@163.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Subject: Request for QEMU Wiki account
Thread-Topic: Subject: Request for QEMU Wiki account
Thread-Index: AQHcRuNbNAo9tAO4ikasUjTtyuTMrA==
X-MS-Exchange-MessageSentRepresentingType: 1
Date: Mon, 27 Oct 2025 01:45:22 +0000
Message-ID: <SEZPR03MB671446308755C442896589ABFDFCA@SEZPR03MB6714.apcprd03.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-Exchange-Organization-SCL: -1
X-MS-TNEF-Correlator: 
X-MS-Exchange-Organization-RecordReviewCfmType: 0
msip_labels: 
Content-Type: multipart/alternative;
 boundary="_000_SEZPR03MB671446308755C442896589ABFDFCASEZPR03MB6714apcp_"
MIME-Version: 1.0
X-CM-TRANSID: _____wB3v7G2zv5oi1OfBA--.165S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
 VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjTRQVy4UUUUU
X-Originating-IP: [2603:1046:101:4e::5]
X-CM-SenderInfo: 52kd0wpxrkt0xbvdzzlrq6il2tof0z/1tbiFA-vEGj5wuS8iQACsk
Received-SPF: pass client-ip=117.135.210.3;
 envelope-from=zhaoguohan_salmon@163.com; helo=m16.mail.163.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1,
 RCVD_IN_MSPIKE_WL=-0.01, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 27 Oct 2025 08:56:53 -0400
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--_000_SEZPR03MB671446308755C442896589ABFDFCASEZPR03MB6714apcp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello,

My patch has been merged and I was asked to update the ChangeLog page
on the QEMU wiki (https://wiki.qemu.org/ChangeLog/10.2).

Could you please help create a wiki account for me?
Preferred username: zhaoguohan

Thank you!
Best regards,
Guohan Zhao

--_000_SEZPR03MB671446308755C442896589ABFDFCASEZPR03MB6714apcp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Hello,</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
My patch has been merged and I was asked to update the ChangeLog page</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
on the QEMU wiki (https://wiki.qemu.org/ChangeLog/10.2).</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Could you please help create a wiki account for me?</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Preferred username: zhaoguohan</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Thank you!</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Best regards,</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Guohan Zhao</div>
</body>
</html>

--_000_SEZPR03MB671446308755C442896589ABFDFCASEZPR03MB6714apcp_--


