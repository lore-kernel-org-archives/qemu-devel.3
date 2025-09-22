Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02029CA100F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 15:43:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0igh-0004Wn-V7; Mon, 22 Sep 2025 11:42:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paul.buxton@codasip.com>)
 id 1v0igJ-0004R0-Km
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 11:42:28 -0400
Received: from mail-swedencentralazon11023101.outbound.protection.outlook.com
 ([52.101.83.101] helo=GVXPR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paul.buxton@codasip.com>)
 id 1v0ig9-0002pn-ER
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 11:42:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TlbiLCHmyd9xYXBKRYnhr1k17+ldCFRvEX/89VcorJsgHm+8A0tRQEwh1Lkce2T/g/KJQgfBFMykfr7SrrPRWNXM76Z1zGRhvsP5cXdNK6EOoKMO5jBPgCx2HE+dSyDHhhEPrESd1cLH/4yEFQ8LtLmGENnxiGiD5DGwnB5MRqaCMFlez/KJtqZwt0D74xqA4LhBqf0jHxzSjjRxKlfKs+BbGk4FnJkt3+OhqIvD47fVNVBmPNbuWSIKqJNYYof6VgPMYTWS3mbFVCk+zU/MQdwYvYm17T+dgJb6L0n+Dg1tVbskDYotERLJRDOySCbqGDdNLu3rfj18NWfyZIZkQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PwdaFmDSccwpnEHtp9xqnMfEKD6YjnCXc97voGAh2ig=;
 b=EAn8v56iqAtq13vOYSCAz2cxAD1WjedQ/LvBWdsgo2aCGbYlhn7+ygFJe6ma0/Ey/qh1j2fwH2W+46Pu1mlEH3TwGWkHTyQLVjCL3SRqZNu0KJa3bwLbzhBrT7aUX0aCzUX3PMCJfMBYMeZ02SK1fZ5BAWqwCTu//P/VTqBRPi+e4OIyxh99xxHtKaH+fpQDjNZsl8UfjgDIvKfhoTe73S1RokGnTI5tCta1hB2qulAq1lGckJlTZoPsVkgm2lzskmRdXLOkL68VgssJQCceCRzR6Cy6R/Om3j/SMyvPITQfT1LfcAwUJdVfK0Bda18xIbZcHjo/LC1RvSxF0UwIrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=codasip.com; dmarc=pass action=none header.from=codasip.com;
 dkim=pass header.d=codasip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codasip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PwdaFmDSccwpnEHtp9xqnMfEKD6YjnCXc97voGAh2ig=;
 b=nB+Qi1cH6AyGENAbCqQPacnM9oMrHXAFxWvzGE1sCoBlbyNOAEtH8gmMe6XjpSc76PKGr7phpGwYRXpV75HMtx+kAAs4q6khZdUNCDoSShSy4NJPdDRDC8/sInFc+yDcIcLGEg+4TbB/3fMcFqIXxYk7S8PLdfqkrC+2ShWhD8ofcf29F/x1YhjrcTmsX7i/1iUnFLmiwg91YkYzcblUAZrtq9D2AyNv4kgBhAaHeW6OZN+XSJJbAZ4wbYwrfV/kVvIPtkHLyKFBeiDCAGAWYJJxq8rcL0Y/s8JibiFykMyDv3IEyLzcoFoNX0HwtH/1gcA1AGv+Tl3IviDseMDWkA==
Received: from PR3P192MB0796.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:46::8) by
 DB9P192MB1849.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:39c::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.19; Mon, 22 Sep 2025 15:37:04 +0000
Received: from PR3P192MB0796.EURP192.PROD.OUTLOOK.COM
 ([fe80::8de8:ef51:94e2:2a53]) by PR3P192MB0796.EURP192.PROD.OUTLOOK.COM
 ([fe80::8de8:ef51:94e2:2a53%5]) with mapi id 15.20.9137.018; Mon, 22 Sep 2025
 15:37:04 +0000
From: Paul Buxton <paul.buxton@codasip.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PULL,2/2] .gitmodules: move u-boot mirrors to
 qemu-project-mirrors
Thread-Topic: [PULL,2/2] .gitmodules: move u-boot mirrors to
 qemu-project-mirrors
Thread-Index: AQHcK9Z68YHmX5NSQU6R889sTMbmYg==
Date: Mon, 22 Sep 2025 15:37:04 +0000
Message-ID: <PR3P192MB079624FFEFC75CDBFB26B653EA12A@PR3P192MB0796.EURP192.PROD.OUTLOOK.COM>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=codasip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PR3P192MB0796:EE_|DB9P192MB1849:EE_
x-ms-office365-filtering-correlation-id: d445da7f-ea82-4e56-bda9-08ddf9ede168
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021|13003099007|8096899003; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?llJb6EPURc/J69L+1YAyktbJs3PteJw5c+e6lI2b4rcgQ0VmBuplKoOAy1?=
 =?iso-8859-1?Q?RV3ugBKHInaLMtvzd55bhIPpy/UvtwCfyAjGbXgtSY2mKlOv1nUZN5IG2o?=
 =?iso-8859-1?Q?A0zQ+TTbG3cqF86OeuRjhi0ydfbSUizIfWqaKkMHg1/BfYgBWwABI46gkD?=
 =?iso-8859-1?Q?uD8+y+AbU6v726Fb/hjOiHiNNRfeJoDjtWLLDyrD0PBINfCsr6IaqwJLnf?=
 =?iso-8859-1?Q?c/E+sWK6ijTD1vMkDX7ef6iN6mcybIWf5jMN1UOY3UJd5/+AMkeq24R3js?=
 =?iso-8859-1?Q?PnGUluakWxvVExz62dbs3LxeyZG1I4mGPyOt5eE6ynyiDU5IoeLRjjYSIr?=
 =?iso-8859-1?Q?FdTgL4Ypw02NS9hZH3TGQI7dF/53M1kC+KpV1zj7XTvtLMuhqjmP0VU1Nl?=
 =?iso-8859-1?Q?y2e5Acv11iQej6EIpcfRBElBch50ZDzhTERG/0AsLwGi3WT3GnvIT/eWyL?=
 =?iso-8859-1?Q?1BZsA8s8spx/z61E5CFW1AEJB8LyUKEO8poT12HE0EgLMT0X+fIF5INwXa?=
 =?iso-8859-1?Q?j75i4sDCmjsgOD/qnEHUN6B464gW1ALwewz22f7mAzc+CUSWe/w6SkRePG?=
 =?iso-8859-1?Q?uurLcvEHzeuSWunWAGgH9P4dOT1AVzDXkLtUGztJKcvJySPcQA6le9BwPL?=
 =?iso-8859-1?Q?b5wBWq4QrJCVgphZIqkjNgqCgDqc8WnlP8z4M6+V1SPl/J2iSh8K9Z4tWX?=
 =?iso-8859-1?Q?R1Itkm9147Dl7V6R4ZphDil802x+LxRDtsjRduDL+Cr8sDwEMrl39MfXI4?=
 =?iso-8859-1?Q?9xmA9qAljkqo8QcMm364OH4DeA5MzEet6ysUxN9ZAq0aJ+IscckZdlEQrO?=
 =?iso-8859-1?Q?Et+tLRUxXwsm8zDIpZ2YM1DJ3ElDdKQnlrLsQ0ZvAsvgDYfXHZUELqCUWJ?=
 =?iso-8859-1?Q?pC/brEBm1PaT+xnU4nnoEB8fj9nz2yEkaaNl2CJ6FPmI1KVsH+oJ9VtBxc?=
 =?iso-8859-1?Q?Kd4R1JMVYEwkYD+v2AeklVbLYQOm1GsjFX9jFa08No7+2Y2kLhSA3np4A0?=
 =?iso-8859-1?Q?MqfMI7ppVWyA5Lt2xay0BG3YAwF7Gk/yQhAnlgxAFkEdjOcX1DWZ+53kGh?=
 =?iso-8859-1?Q?ptzRrdqYCNRQ3Iakg2+3uWYsKjZNOHh/YRZjy5TjsnhnE3d06mgftvO4yT?=
 =?iso-8859-1?Q?fSUVgHo3FuDj6ozUYY3adWtXfvF6Ie42sG8S0SnQz4JDRO9hGLDcyryK0O?=
 =?iso-8859-1?Q?5/7KhRY00KX9djqBaZVHgfEyTLejfzeytbFkC/VpdSqYMvmzhzz2K817b6?=
 =?iso-8859-1?Q?y8Mk6rbqUtrlCn1dK41pm0KeRY4aJVt0MWdoy33Md6YUZREdO3p1FTiMb4?=
 =?iso-8859-1?Q?Ge3E54eugPzdhSTJ3kpf10mYwvtUxNagX1y8r/bzN00lni9qIp6ed7tShE?=
 =?iso-8859-1?Q?ifti3WB/tXQlWbff7IN4rxRHCvKibJZWkRtAD1Urmv5zJvCPAhobUOnsGD?=
 =?iso-8859-1?Q?3aUFaMdQLWceUpV/ABPWbeKdSH9gPLqfP7lV87d6xts86xiiqpbxX7SI6U?=
 =?iso-8859-1?Q?Rd1vrqJJ/KKzbFEUmwhc5bJIc5zB6392+aKoAAzD6w+w=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PR3P192MB0796.EURP192.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(13003099007)(8096899003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?4Cu/SdgWBdKdJHi4dyZXnqdErN7nKDIKXnvEqWMl4NYVwZKEsxAn5to+TO?=
 =?iso-8859-1?Q?OKITvkXRcIi3J+XC57H+fKd8UGrr/xJUXfY6B9BW22CxSczsJwt/qJ7MkB?=
 =?iso-8859-1?Q?7v55LZs2sl3rZ1eRNaQU003WDb6ZK3XsfP436+EGKL1BqW9VKsWt7gln2l?=
 =?iso-8859-1?Q?Ex7wfGA/Z/TPezvDz/GzVze7B0+2HCCmX0wcNeRZzw4L9RCM1FSdD1TkPw?=
 =?iso-8859-1?Q?e4lbyJujGPpJtxpNp/ws6OqrGUrOPkERgZ2fd+OuNL9unoqW3ZsPnXmkFy?=
 =?iso-8859-1?Q?+ILz7mK1O8Z1Ov7PmB5HNzawgAPb1L8Q8RnIIgHQGnBfx5EqDvLP+wxOA5?=
 =?iso-8859-1?Q?qXcyuapx2/VFq3RzvMsD597mhuA/ieKb+03deDIJ75M03u90D5/w3CYJ2t?=
 =?iso-8859-1?Q?EuTIshIuLsO8UbDI57qbP3ZQ1Js4vVLUYFiZMYQKxKZ78EYiieEc/CZstJ?=
 =?iso-8859-1?Q?4mMfQ0QRFtU77x8CdWtgfMcvmlrEWlCqn7lDLQAuitzar3piPJojjISqrQ?=
 =?iso-8859-1?Q?gld/utY1uEYg27z98TC7t+lVN7iWdp/aZKDGW7ay+vEn1kvOQusqQ6OvGw?=
 =?iso-8859-1?Q?aUDVN4GNX72fByrz9APIfFbXoVcQbltYiqeZSEPV2TLd/LudttS04y5kOP?=
 =?iso-8859-1?Q?VEYndV0k7Y5Y/s6BC+GBlh75PwcWUXHFmobHzD7o8GH6lX1INtbCWX2KLj?=
 =?iso-8859-1?Q?KZK28+ezylqKlEObCWibhQsgsX85ov2Jt+Afei9DT7ZO/ytio+wCMge3w+?=
 =?iso-8859-1?Q?w7Pi3bEgDEswsdOv0AlDO65XbvN333AEYPl6ljG8NX42xhTrtWIN4thco7?=
 =?iso-8859-1?Q?Kj578Zde5eBNRghwTsO3TEmuH8rfmpUiZ6P8MRmvEQozHCcn7uMxQKcPWl?=
 =?iso-8859-1?Q?lb4+CKOUO03Wf2UM6PvTR+8QhRUA5ojhj46+KTQdaMToXrZVCsYKOSQMAs?=
 =?iso-8859-1?Q?kbIyZrL/G3wIuRsbXGv8EPuOkjYakSXGZ55C8pfM62p7BNhejAecyDvWKB?=
 =?iso-8859-1?Q?5oZGcpmKUX32RFDm8nOBJc/YAsJo3BtyUgTw86Nb5+ETeyVJsxvZOpEAKf?=
 =?iso-8859-1?Q?70o8sc4eMLp6Me5TPPVZT+YDOv/9mN7JKj5N4IT0y5wDkgwrf42berxxne?=
 =?iso-8859-1?Q?LuTJuHMCuy6AC0q+1d9S0uT8CJdT5TgrdK754clEW53OvyaoAYoxqki0vu?=
 =?iso-8859-1?Q?Vvi0HT2gGICOzfEXWlm6uIZuk8bw6RQ+dAXK1D4qtjk4qRMKqrDTHXn0cR?=
 =?iso-8859-1?Q?wWGmy/3oY/9HYKkuDnuaR85PdBPLU6QfoTXKfdURRlAZQYdakqCo2upRSi?=
 =?iso-8859-1?Q?xpGVU0Uz/rLB3wS9snbPKlAaeSCGsUUhdecfxeJ0ca/hYp9uAfEQaYKVLq?=
 =?iso-8859-1?Q?l6YLkIiprO8BpjLkh5aAMevKHDEJ1qwnM5SSnWS7uGh+JNQYwFTMYFSiuC?=
 =?iso-8859-1?Q?s21uoVAtmETNcujSunjjmYm5TZuZifffPoRD20fxpTrOQMOZg+u7dJ7WMy?=
 =?iso-8859-1?Q?7AQbLj9XkgE0g75gMb7orvdGMOiaxRdAxAkbhMTdgoW4pX03tm2qyg4482?=
 =?iso-8859-1?Q?oyxFx9Z6C5ploRXlhdPe49qSiAVjIuJWTxmU0N46v7KKlSsfTfLmZBo6+k?=
 =?iso-8859-1?Q?CgNhx7n3OmLaxrZeb6N4zkNuSIk/HfFoRf?=
Content-Type: multipart/alternative;
 boundary="_000_PR3P192MB079624FFEFC75CDBFB26B653EA12APR3P192MB0796EURP_"
MIME-Version: 1.0
X-OriginatorOrg: codasip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PR3P192MB0796.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: d445da7f-ea82-4e56-bda9-08ddf9ede168
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2025 15:37:04.0265 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d91ffef-bb81-4cbd-b9b8-552583685f20
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z7LvmaDy6TNt9vuTrMMOqc0zgCjFIiLDk+VThV3Nod4UB7jYv8HP6rmlyzKMIRzQW9H3Sb7x/z94r/iejlOZ8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P192MB1849
Received-SPF: pass client-ip=52.101.83.101;
 envelope-from=paul.buxton@codasip.com;
 helo=GVXPR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--_000_PR3P192MB079624FFEFC75CDBFB26B653EA12APR3P192MB0796EURP_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

It looks like the

https://gitlab.com/qemu-project/u-boot.git  repositories have now been remo=
ved. This breaks any older builds expecting those repositories to still exi=
st.

Is the expectation for users on older versions to update their submodule pa=
ths? Or is this accidental?

Thanks,
Paul


--_000_PR3P192MB079624FFEFC75CDBFB26B653EA12APR3P192MB0796EURP_
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
<div style=3D"text-align: left; text-indent: 0px; background-color: rgb(255=
, 255, 255); margin: 0px; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSF=
ontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, =
0, 0);" class=3D"elementToProof">
Hi,</div>
<div style=3D"text-align: left; text-indent: 0px; background-color: rgb(255=
, 255, 255); margin: 0px; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSF=
ontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, =
0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"text-align: left; text-indent: 0px; background-color: rgb(255=
, 255, 255); margin: 0px; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSF=
ontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, =
0, 0);" class=3D"elementToProof">
It looks like the&nbsp;</div>
<pre style=3D"background-color: rgb(255, 255, 255);" class=3D"elementToProo=
f"><div style=3D"text-align: left; text-indent: 0px; white-space: pre-wrap;=
 margin: 0px; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof"><a style=3D"margin: 0px;" data-linkindex=3D"0" title=
=3D"https://gitlab.com/qemu-project/u-boot.git" class=3D"ms-outlook-linkify=
 OWAAutoLink" id=3D"OWA2b9755f2-7108-078d-3a96-cd0ab3c0f487" target=3D"_bla=
nk" href=3D"https://gitlab.com/qemu-project/u-boot.git">https://gitlab.com/=
qemu-project/u-boot.git</a> &nbsp;repositories have now been removed. This =
breaks any older builds expecting those repositories to still exist.</div><=
/pre>
<div style=3D"text-align: left; text-indent: 0px; background-color: rgb(255=
, 255, 255); margin: 0px; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSF=
ontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, =
0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"text-align: left; text-indent: 0px; background-color: rgb(255=
, 255, 255); margin: 0px; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSF=
ontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, =
0, 0);" class=3D"elementToProof">
Is the expectation for users on older versions to update their submodule pa=
ths? Or is this accidental?</div>
<div style=3D"text-align: left; text-indent: 0px; background-color: rgb(255=
, 255, 255); margin: 0px; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSF=
ontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, =
0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"text-align: left; text-indent: 0px; background-color: rgb(255=
, 255, 255); margin: 0px; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSF=
ontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, =
0, 0);" class=3D"elementToProof">
Thanks,</div>
<div style=3D"text-align: left; text-indent: 0px; background-color: rgb(255=
, 255, 255); margin: 0px; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSF=
ontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, =
0, 0);" class=3D"elementToProof">
Paul</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
</body>
</html>

--_000_PR3P192MB079624FFEFC75CDBFB26B653EA12APR3P192MB0796EURP_--

