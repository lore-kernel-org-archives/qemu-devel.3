Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E189D16261
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 13:20:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0KzM-0001ZT-Ji; Mon, 14 Oct 2024 09:19:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ryan.ljlu@qq.com>) id 1t0Irs-0002yE-Rg
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 07:04:07 -0400
Received: from xmbghk7.mail.qq.com ([43.163.128.53])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ryan.ljlu@qq.com>) id 1t0Irl-00085R-Ll
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 07:04:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1728903829; bh=YkM9p83JHF1NVQ9NcXb8wL/fwC0sToRRtbQLby/X+go=;
 h=From:To:CC:Subject:Date;
 b=UNkBV8rpApIwHsxfsHEvK9NqYO16I/ZSGeVP+/wxoF/nsZPaRqNrfFAMzeixtBJfp
 yAyWiqjXlkCr1dlK3UxTw3iRnAK44TH9PoLKAx1CEb225TS0ly4rwSso15aaa5bhy/
 8PnItnS54a9clTDH7Rg7DZpPLrzk7sQhjfdw07XE=
Received: from TYSPR03MB7387.apcprd03.prod.outlook.com ([2603:1046:c09:46a::5])
 by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
 id CE108C36; Mon, 14 Oct 2024 18:51:33 +0800
X-QQ-mid: xmsmtpt1728903093tvdvkarsl
Message-ID: <tencent_F1E38C3E48473DDD458C9BD6C69FEE09EE06@qq.com>
X-QQ-XMAILINFO: MpO6L0LObisW5MAs//wOZ8hYxWz+suwGm8tn2UpR8rmB3JB68t1E0r8q+s9BTN
 lbZljxBie7ts90iu0++Pze4ac/kgs+RTr+1gtYmAbZXfR068Vwm42bY/WBjDkyQqwkRMxesU5HHg
 wJkMtwgCc/srudG8oEvz6E7+mq/6wyZwQchx7Nr3sjTYfR6lst26F2iz9bF5x2n6BRg1+wz53Gf1
 HzkZwjyP0Y/48ladwOXMa4x27XmU446dLPrb1lwWWckW5a8Su6S9NfI/GiXBu7wkwOkZe5PIDf6U
 XqI91j4Wadi+K6xk+tiuf8vaDJM6zI6fHHrRw6gPGDDwyu/MrAkmmpKCPS9FQ3DWTzBZ+AGcNfhL
 zkM+jfwgV+EQTqg7BrlT9iBUT19n9Ex/9fMG3LCFVkpW9npXmlenXGj3W71GbAZ0WdmeEKPb+UI5
 9ref/EX0rfNbCE27L5oBoszCGVuBVcnnBBMjumoAO5cqBWWRQUJoWvOWhXC9fUilhnrrudPqgU3Z
 seo30rgVanWBeIJfYLhmGlwEZ51oPVgAYcYfuigWopzzYA5BCWY9VJLl8nG7aTH1bRNmrTQ3phBv
 uMxVXHMCXieETBSIXA3Qo5P9jvV2zgrw11nxETvv88sSTWx+rPeu47jfPQ84sKuaTlemyFBNjnOj
 kc/SQQZ0sVHGRELDmi75cI/Y19VlEKG8tusvnt2Cz3t0EtcOT7VrK+tExB8ApiyVEThe5zZjAs40
 +Tm4a3ra8VRvXF9TXrFHcewCa1qDTMjqEISg7d6KJNjxhJXkISGmkT8BX+Y1UcyNVgbkjw+wr2vr
 37lFCjYyEBhhqDGRi6iDllX6wtzz1qoyDfCHkni8CFXd1UIUjRnK3iFS95sGqs8oEBwmaZwtrrLm
 oRkkqf+Prtps+5gq3jwCrSi9o2WQJz45AYPkcmj2tOjnzJt8JPptSZhd/rCsQ+jUExnpuyD7cSAV
 etpRuUieg=
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From: "ryan.ljlu@qq.com" <ryan.ljlu@qq.com>
To: "jintack@cs.columbia.edu" <jintack@cs.columbia.edu>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [Qemu-devel] Assigning network devices to nested VMs results in
 driver errors in nested VMs
Thread-Topic: [Qemu-devel] Assigning network devices to nested VMs results in
 driver errors in nested VMs
Thread-Index: AQHbHiWGSEjvTeOluU237sDnMjx6sg==
X-MS-Exchange-MessageSentRepresentingType: 1
Date: Mon, 14 Oct 2024 10:51:28 +0000
X-OQ-MSGID: <TYSPR03MB73873BCC482C8A70FA284178A3442@TYSPR03MB7387.apcprd03.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-Exchange-Organization-SCL: -1
X-MS-TNEF-Correlator: 
X-MS-Exchange-Organization-RecordReviewCfmType: 0
msip_labels: 
Content-Type: multipart/alternative;
 boundary="_000_TYSPR03MB73873BCC482C8A70FA284178A3442TYSPR03MB7387apcp_"
MIME-Version: 1.0
Received-SPF: pass client-ip=43.163.128.53; envelope-from=ryan.ljlu@qq.com;
 helo=xmbghk7.mail.qq.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 14 Oct 2024 09:19:53 -0400
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

--_000_TYSPR03MB73873BCC482C8A70FA284178A3442TYSPR03MB7387apcp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Jintack,

I run into the same issue as you described in https://lists.nongnu.org/arch=
ive/html/qemu-devel/2018-02/msg03876.html
I try to pass through MLNX VF and NVME to level2-vm, but both these two pci=
 device can display with lspci correctly, but have issue with driver.
My env are:
    Host Linux version : 5.15.131
    Qemu: 8.2.0

Since you reported this issue in 2018, does this have any update from there=
?

Level2 VM dmesg error logs while passing through MLNX VF are below:
[Mon Oct 14 04:12:47 2024] pci 0000:00:06.0: [15b3:101e] type 00 class 0x02=
0000
[Mon Oct 14 04:12:47 2024] pci 0000:00:06.0: reg 0x10: [mem 0x00000000-0x00=
0fffff 64bit pref]
[Mon Oct 14 04:12:47 2024] pci 0000:00:06.0: enabling Extended Tags
[Mon Oct 14 04:12:47 2024] pci 0000:00:06.0: 0.000 Gb/s available PCIe band=
width, limited by Unknown x0 link at 0000:00:06.0 (capable of 126.024 Gb/s =
with 16.0 GT/s PCIe x8 link)
[Mon Oct 14 04:12:47 2024] pci 0000:00:06.0: BAR 0: assigned [mem 0x1400000=
00-0x1400fffff 64bit pref]
[Mon Oct 14 04:12:48 2024] mlx5_core 0000:00:06.0: enabling device (0000 ->=
 0002)
[Mon Oct 14 04:12:48 2024] mlx5_core 0000:00:06.0: firmware version: 22.35.=
2000

[Mon Oct 14 04:13:50 2024] mlx5_core 0000:00:06.0: wait_func:1151:(pid 1193=
): ENABLE_HCA(0x104) timeout. Will cause a leak of a command resource
[Mon Oct 14 04:13:50 2024] mlx5_core 0000:00:06.0: mlx5_function_setup:1164=
:(pid 1193): enable hca failed
[Mon Oct 14 04:13:50 2024] mlx5_core 0000:00:06.0: probe_one:1770:(pid 1193=
): mlx5_init_one failed with error code -110
[Mon Oct 14 04:13:50 2024] mlx5_core: probe of 0000:00:06.0 failed with err=
or -110

Host dmesg error logs while passing through MLNX VF are below:
[Mon Oct 14 08:07:08 2024] DMAR: DRHD: handling fault status reg 2
[Mon Oct 14 08:07:08 2024] DMAR: [DMA Read NO_PASID] Request device [ca:08.=
2] fault addr 0x104ead000 [fault reason 0x06] PTE Read access is not set

Thanks,
Ryan

--_000_TYSPR03MB73873BCC482C8A70FA284178A3442TYSPR03MB7387apcp_
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
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Hi Jintack,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
I run into the same issue as you described in <a href=3D"https://lists.nong=
nu.org/archive/html/qemu-devel/2018-02/msg03876.html" id=3D"LPlnk932188" cl=
ass=3D"OWAAutoLink">
https://lists.nongnu.org/archive/html/qemu-devel/2018-02/msg03876.html</a><=
/div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
I try to pass through MLNX VF and NVME to level2-vm, but both these two pci=
 device can display with lspci correctly, but have issue with driver.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
My env are:</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; &nbsp; Host Linux version : 5.15.131</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; &nbsp; Qemu: 8.2.0</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Since you reported this issue in 2018, does&nbsp;this have any update from =
there?</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Level2 VM dmesg error logs while passing through MLNX VF are below:</div>
<div style=3D"line-height: 19px; white-space: pre; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);">
[Mon Oct 14 04:12:47 2024] pci 0000:00:06.0: [15b3:101e] type 00 class 0x02=
0000</div>
<div style=3D"line-height: 19px; white-space: pre; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);">
[Mon Oct 14 04:12:47 2024] pci 0000:00:06.0: reg 0x10: [mem 0x00000000-0x00=
0fffff 64bit pref]</div>
<div style=3D"line-height: 19px; white-space: pre; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);">
[Mon Oct 14 04:12:47 2024] pci 0000:00:06.0: enabling Extended Tags</div>
<div style=3D"line-height: 19px; white-space: pre; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);">
[Mon Oct 14 04:12:47 2024] pci 0000:00:06.0: 0.000 Gb/s available PCIe band=
width, limited by Unknown x0 link at 0000:00:06.0 (capable of 126.024 Gb/s =
with 16.0 GT/s PCIe x8 link)</div>
<div style=3D"line-height: 19px; white-space: pre; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);">
[Mon Oct 14 04:12:47 2024] pci 0000:00:06.0: BAR 0: assigned [mem 0x1400000=
00-0x1400fffff 64bit pref]</div>
<div style=3D"line-height: 19px; white-space: pre; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);">
[Mon Oct 14 04:12:48 2024] mlx5_core 0000:00:06.0: enabling device (0000 -&=
gt; 0002)</div>
<div style=3D"line-height: 19px; white-space: pre; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);">
[Mon Oct 14 04:12:48 2024] mlx5_core 0000:00:06.0: firmware version: 22.35.=
2000</div>
<div style=3D"line-height: 19px; white-space: pre; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"line-height: 19px; white-space: pre; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);">
[Mon Oct 14 04:13:50 2024] mlx5_core 0000:00:06.0: wait_func:1151:(pid 1193=
): ENABLE_HCA(0x104) timeout. Will cause a leak of a command resource</div>
<div style=3D"line-height: 19px; white-space: pre; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);">
[Mon Oct 14 04:13:50 2024] mlx5_core 0000:00:06.0: mlx5_function_setup:1164=
:(pid 1193): enable hca failed</div>
<div style=3D"line-height: 19px; white-space: pre; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);">
[Mon Oct 14 04:13:50 2024] mlx5_core 0000:00:06.0: probe_one:1770:(pid 1193=
): mlx5_init_one failed with error code -110</div>
<div style=3D"line-height: 19px; white-space: pre; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);">
[Mon Oct 14 04:13:50 2024] mlx5_core: probe of 0000:00:06.0 failed with err=
or -110</div>
<div style=3D"line-height: 19px; white-space: pre; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Host dmesg error logs while passing through MLNX VF&nbsp;are below:</div>
<div style=3D"line-height: 19px; white-space: pre; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);">
[Mon Oct 14 08:07:08 2024] DMAR: DRHD: handling fault status reg 2</div>
<div style=3D"line-height: 19px; white-space: pre; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);">
[Mon Oct 14 08:07:08 2024] DMAR: [DMA Read NO_PASID] Request device [ca:08.=
2] fault addr 0x104ead000 [fault reason 0x06] PTE Read access is not set</d=
iv>
<div class=3D"elementToProof" style=3D"line-height: 19px; white-space: pre;=
 font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helv=
etica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Thanks,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Ryan</div>
</body>
</html>

--_000_TYSPR03MB73873BCC482C8A70FA284178A3442TYSPR03MB7387apcp_--


