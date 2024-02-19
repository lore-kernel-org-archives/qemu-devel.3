Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86B53C48BC3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 14:10:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rc4LR-0006qy-Nh; Mon, 19 Feb 2024 09:10:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jakob.breu@mercedes-benz.com>)
 id 1rc3WK-0002r4-V3
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 08:17:21 -0500
Received: from mail-out.emea.daimler.com ([141.113.1.132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jakob.breu@mercedes-benz.com>)
 id 1rc3WF-00053P-5N
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 08:17:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=mercedes-benz.com; i=@mercedes-benz.com; q=dns/txt;
 s=s1-20210420-DAI; t=1708348635;
 h=from:to:subject:date:message-id:content-type: mime-version;
 bh=Chf4FIlIiTHTSWeJFRLy7YZumkVhwuCmH+Y7Wg6LKMo=;
 b=q+U0+AJgjXgosGK71pAsbKI8LFagSDmxU7qMFf6GUXzH3cYpA4qE7NcM
 sbKNuK45dALO8+Fg4rPbNkSSIfME1SJZEiqDh/leKI2cU+4jx9Y7RgcQ3
 e25DmhydgcCwc+83si0R1JIXdYAYVCewZcQaCcrUqxfzlEjex94hPtdUs
 cAZm+bHJE2alfJJNeEVxZ0C5G66L0T1LGfTiuanFWpJrzneL6bHa+DT71
 5lLg5+8AfA5lhkxcOuvVzj38qlfBLYSBrrmHB01Jd+wf9h7YzrFGIX30P
 zudTTjm+dIWGlADTO+HFDAeNpkiu34b5tfjniqs/08/xxKxCruHIRQmBz w==;
From: <jakob.breu@mercedes-benz.com>
To: <qemu-devel@nongnu.org>
Subject: Sponsorship via Github
Thread-Topic: Sponsorship via Github
Thread-Index: AdpjNTls9OoVtLKOR9SBkKQyuY7Ftg==
Date: Mon, 19 Feb 2024 13:16:56 +0000
Message-ID: <DB9PR07MB92726E235941C78516CE617EC6512@DB9PR07MB9272.eurprd07.prod.outlook.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mercedes-benz.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR07MB9272:EE_|DBBPR07MB7611:EE_
x-ms-office365-filtering-correlation-id: 710f56db-b3bd-4d47-7d70-08dc314d0c56
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r4y9B2cwRbLLZgQDaeUY54Y5LvN454t/B/nM22rf40Z9NPKA8iicLxzL4TFvLksEgpk7zR/Y3APkQYw+yQPGXMNIY41g6FWzW3ndbXcvPv8G57lAac2p826z7fkULXg7BEd7DRbgoosNAUwXr2nb8yYCYQa8VlmQW9iwpI8iEbvY+OQ8XbWwaMLOIubi+tog3DNl5Sj5ik9fwNUEgAOFm0mA0poq4camLsqiEnTIKOnGDzYqn70NVX0IYjTnW24hWESQGAQefTzOP+1bziawX6ClD2bFppIAl/tgmgKEMXeHjzQVgh51zHV+cwo7DKmh6EaJwmQwplK7G6l8ke3Zozw1a7M0kGA45hhc2cOP10lVt8ST7LTn7pKlQxpd13fjTgaaUGF3nhqxcSjTKGIuXa74f2dY8o2ENutyLstREw1EivDlfv+9KUiZxkyRn32jtT/qpzaKhAP5SUVvUVUvJ3Ad9bqDTVKwNOr7TL7BKNC0olZeGMuCrxVufoDnEK0EVHIlSsm7AFygHh4uh4C6S2dAOW6/uc9ue683EJWknXyQBwgjhhmIZwiVtxbSjluuGppXHpJhReoG2dO/xBOWD9VjLb2kHe2gXaufZ2JOlsb32te3BEuzZnJpNzLdkRNv
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR07MB9272.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?4BGKQbTxAjG9j7WjRR5uM97n14zPqnws16tIciAnTe4mMH0zvSDygQAI+m?=
 =?iso-8859-1?Q?I71lSb5vyULbKdqNmy9fFoXO3R3npF3A412H9VQ2nLfSDgRwVxHb9Jiy6n?=
 =?iso-8859-1?Q?OuNM/MKchKCebm56cToc+OZOGjfndyjryaXpocLW7EFZHepck88K24cni3?=
 =?iso-8859-1?Q?v6QswF5uTIsw0S8aoiKaI8723jSYcvHLfbydhJdcJoNySlA07CotvQZ7dr?=
 =?iso-8859-1?Q?hfLeFx1f7qT0viUBInKee+K3CQg0rHLZYRSzS++wgf5d+GQEltsDFCgf2h?=
 =?iso-8859-1?Q?HNVyeQCAfazqiCMSU1JOVGzBzUNMbDV2alm9Ftq2J8yvPqX/pihmjbncXL?=
 =?iso-8859-1?Q?yQMkIiCR0doaaig2KHFbVxyVxovwYJ3+ByqFpK7RG59yz+b0Z9AdMzicHJ?=
 =?iso-8859-1?Q?rX/8krRBV7kNYwi5HIwUzykrQYxjxKmHpX+IQLaf5HZCqPVQk8x84U1YAW?=
 =?iso-8859-1?Q?lDB/zAe6Ue93kYBSoc597ctzBTAKyVgMXa9MNqcuijJFN7jQSy4IzSiZT2?=
 =?iso-8859-1?Q?yBIsPt30IejkvGaOavR0UWnnHVm6bCOVRe6RZQjTComzkdlNI9RoELxSRl?=
 =?iso-8859-1?Q?+LIS0S0Sku3qJryZ5NmBznvIHgMeQj1pes5bIZPXFN3sjQpSWpTzXIK3EN?=
 =?iso-8859-1?Q?cNOMTRzYVa/kIdhw3tqpsoF6Tl5qsvNNyvYiBGsDb8cQOS663eQZTkxKLb?=
 =?iso-8859-1?Q?P8SJT5oHM//q7q/dVjP3eb5yt5tGIa4jV2PY77FDXkZbVBbkX+JmC1qorW?=
 =?iso-8859-1?Q?bRjGcg8jIIrB0tqnq6Ux0DmZUxVO/BL93MZsKUwCA/pBojaIOn+JutJ2rG?=
 =?iso-8859-1?Q?ES0zUSgcHw2HPz2t72haGCmr+VhOGgNG2uFKz/c5oA4ohCa0opNzirODwz?=
 =?iso-8859-1?Q?8poVZ6+yl15THC9FZcsGea/JXjS/kufn1BDokuBzmz+Mm+AY/L5jn2sjZ6?=
 =?iso-8859-1?Q?UWIT2+x19Iwx6emFRbUIHrAS9btV5RgoOY7Q4q5w70yoL4NUpFW4JnlPji?=
 =?iso-8859-1?Q?UH0bZx4wR6p1r5rW4rXQ9JWUkDb6S2uPCMWBM5E88s0GuJM46SHQ/Iuh6T?=
 =?iso-8859-1?Q?rB7uSZaPUBFV62NoUAlvFBlqzX4koT+VyChePhBCP/5W85FNzrnIrrf+17?=
 =?iso-8859-1?Q?fimISdzJ+39cd6QkPv2zLgzSgfpxotsu6UxvAH4CeUH3xRu3JquTF9WOoR?=
 =?iso-8859-1?Q?suZd6L2ZvKS7PNH+/ZZwtH9vosB1zPev0Wg1tVqn9Li91c6dvVtsADmyCk?=
 =?iso-8859-1?Q?2eZniH5MX4LSRjR0CkBU+u0RD7YlwqvmMPH9ThPp5VHTLoryQOeR5iwbge?=
 =?iso-8859-1?Q?tXvGfuyjMZDI1j35UvJQh2hOYVKwl9Bdnkx8WWyhULrJDOEAzaNt5k28sW?=
 =?iso-8859-1?Q?BZDWFBpC45tIv6e8tOwxZHGg3sHC+0daEFUCjfU5lCT1GS3FGDqJxT5cR4?=
 =?iso-8859-1?Q?Z5v8//3a5tH3mL7mbg+tH+HiNsO9C//2qhST5bqfAvQCXnCaX63lNVOqb3?=
 =?iso-8859-1?Q?dSSnRl3LyFquGG88CSq7AxVAVstsXmfgTIGfrLshPW5QNT3/+YzMiF3rOm?=
 =?iso-8859-1?Q?AWq5iCmVmlQ6qhC2imq3J63MKAXPBalxAHGdrdZiIeq92KKgk9St91euTn?=
 =?iso-8859-1?Q?0qv8rg3q+cPSJwDgQUV2p5V21JoOItg8US5jnSX60gN73W36Rv7Pt1iS9V?=
 =?iso-8859-1?Q?PiT1zG1CSyimwNjtc+nFXgy4HD63zi+Th5rR5mo5qD4omXYQiSxBZhN5U+?=
 =?iso-8859-1?Q?8X9w=3D=3D?=
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UXYzLU6fn+xrAZzc6rxR8b4MaoFem3lglJQ51Cjc1SNITNLFOpXDq5PTN/Er5V0IIDNcSxncD697hnaskT7C19hFmGsgRGv3gq59kkyMbet1uc3UV/5RgYGzUEBq0ofgc/Q3jA5b9prH/KMaHjXV+Lj2ErVBRRk/B5oKbn6EVUpuKvJUmTjXQtTc9vf/kUSxhSprBoGgqGVPX2eLKAS04LX2h0oK+7rrITYlpChjuFCMbKbZJ6FBE2humnAL3Qaq1q0qA1M+rGdLXpKl0VHpBzdkLINqzmOmipSZTCQ9JgJ07AO8+rdmld1CQ20bsIA5ZV9dztN+NhxJW6FGqmK89g==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VPQhfY+53c6Bm0s3FMdTOXeVEqtfTmkSxST96OHt3o8=;
 b=iGZw/o/aQoG72qXNhIP6efaUpzkPp9RN4O9HbWBigKCd4Jk9+koNUFd6CYUZQHujMHvvzu0Iao803TrPHM9Vo0iomomHPiOWkxLIpyamxhPI+L9zWn05zi14EwIj2FT194Umq3LcRt7Zp/cif6AcMO9cRcZ9YImvbPHm6tw9FaPNFFnu2/ZnrHRdG523y4WhvfljEfP3lJUDGYmJV4/3ifS5TfnyYmgBwGu2kVAZ6kQ2AnQuYPqzPTpu+vlqScWqOxGBvKS+mKTGa27qkdeDSJIaKJH93+HAWY92c0d873UifBQhMzuRohykcZNbytPUodaiIyBf9XTBMxc9UVLFPg==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mercedes-benz.com; dmarc=pass action=none
 header.from=mercedes-benz.com; dkim=pass header.d=mercedes-benz.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corpdir.onmicrosoft.com; s=selector2-corpdir-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VPQhfY+53c6Bm0s3FMdTOXeVEqtfTmkSxST96OHt3o8=;
 b=P2ZWay1/m9lfTnLMAYztzvY31X5lXrULscsIlg8g+tHQYfS/TWnjS3cNzyObiAWLRBGBiDsnozFQsI8tWUQ2NR1lXbOSDnQUyRc+81wmWVXlc2hRArDZRO0646CTgb6Tyw54dlqcO+lsQ7jKdbiGwIhVHGJTSzQCTvbDgLKJamU=
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: DB9PR07MB9272.eurprd07.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: 710f56db-b3bd-4d47-7d70-08dc314d0c56
x-ms-exchange-crosstenant-originalarrivaltime: 19 Feb 2024 13:16:56.8464 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 9652d7c2-1ccf-4940-8151-4a92bd474ed0
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: qCZV8g761nyKxzOghwHNu7V7yeGKHIY6A4tOL+z/qLuSW84bZ5xtCY5rfb+TKf+zYLSzDhKaS94DL2jWMAGhtKcvnUsiaQiU9HpgfKdQwyI=
x-ms-exchange-transport-crosstenantheadersstamped: DBBPR07MB7611
x-originatororg: mercedes-benz.com
Content-Type: multipart/alternative;
 boundary="_000_DB9PR07MB92726E235941C78516CE617EC6512DB9PR07MB9272eurp_"
MIME-Version: 1.0
Received-SPF: pass client-ip=141.113.1.132;
 envelope-from=jakob.breu@mercedes-benz.com; helo=mail-out.emea.daimler.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.072,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 19 Feb 2024 09:10:00 -0500
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

--_000_DB9PR07MB92726E235941C78516CE617EC6512DB9PR07MB9272eurp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hallo qemu developers,

my company, Mercedes-Benz, has a FOSS sponsorship program for which employe=
es can suggest projects. As we are using qemu pretty widely I proposed to s=
ponsor qemu. Unfortunately, our program is only supporting Github sponsors =
due to organizational restrictions. So I wondered, if there is any possibil=
ity that the qemu project adopts the Github sponsors program anytime soon. =
My colleagues from the sponsorship program told me that our ask already let=
 to some projects adopt Github sponsors, which also led to some other peopl=
e giving money.

Best regards,

Jakob


Dr. Jakob Breu | Manager ADAS Platform Software Integration & CI/CD | RD/AS=
A | Mercedes-Benz AG

Mercedes-Benz Group AG, Stuttgart, Germany | Sitz und Registergericht/Domic=
ile and Court of Registry: Stuttgart, HRB - Nr./Commercial Register No.: 76=
2873 | Vorstand/Board of Management: Ola K=E4llenius, Vorsitzender/Chairman=
; J=F6rg Burzer, Renata Jungo Br=FCngger, Sabine Kohleisen, Harald Wilhelm,=
 Markus Sch=E4fer, Britta Seeger


If you are not the addressee, please inform us immediately that you have re=
ceived this e-mail by mistake, and delete it. We thank you for your support=
.


--_000_DB9PR07MB92726E235941C78516CE617EC6512DB9PR07MB9272eurp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	mso-fareast-language:EN-US;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;
	mso-fareast-language:EN-US;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:70.85pt 70.85pt 2.0cm 70.85pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"DE" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:bre=
ak-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hallo qemu developers,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">my company, Mercedes-Benz, has =
a FOSS sponsorship program for which employees can suggest projects. As we =
are using qemu pretty widely I proposed to sponsor qemu. Unfortunately, our=
 program is only supporting Github sponsors
 due to organizational restrictions. So I wondered, if there is any possibi=
lity that the qemu project adopts the Github sponsors program anytime soon.=
 My colleagues from the sponsorship program told me that our ask already le=
t to some projects adopt Github
 sponsors, which also led to some other people giving money.<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Best regards,<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Jakob<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;color:#002060;mso-far=
east-language:DE">Dr. Jakob Breu | Manager ADAS Platform Software Integrati=
on &amp; CI/CD | RD/ASA | Mercedes-Benz AG</span><span style=3D"font-size:8=
.0pt;color:black;mso-fareast-language:DE"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:4.0pt;color:black;mso-farea=
st-language:DE"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"FR" style=3D"font-size:5.0pt;color:#00=
2060;mso-fareast-language:DE">Mercedes-Benz Group AG, Stuttgart, Germany | =
Sitz und Registergericht/Domicile and Court of Registry: Stuttgart, HRB - N=
r./Commercial Register No.: 762873 | Vorstand/Board
 of Management: Ola K=E4llenius, Vorsitzender/Chairman; J=F6rg Burzer, Rena=
ta Jungo Br=FCngger, Sabine Kohleisen, Harald Wilhelm, Markus Sch=E4fer, Br=
itta Seeger</span><span lang=3D"EN-US" style=3D"font-size:5.0pt;color:#0020=
60;mso-fareast-language:DE"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//DE">
<table cellpadding=3D"0" cellspacing=3D"0" border=3D"0">
<font face=3D"sans-serif, Arial, Helvetica" size=3D"-1" color=3D"#808080"><=
br>
If you are not the addressee, please inform us immediately that you have re=
ceived this e-mail by mistake, and delete it. We thank you for your support=
.<br>
<br>
</font>
</table>
</body>
</html>

--_000_DB9PR07MB92726E235941C78516CE617EC6512DB9PR07MB9272eurp_--

