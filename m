Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7672CFC515
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 02:30:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMcnY-0003hG-Kg; Fri, 21 Nov 2025 20:52:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paul.buxton@codasip.com>)
 id 1vMbWw-0000FC-Au
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 19:31:10 -0500
Received: from mail-northeuropeazon11020076.outbound.protection.outlook.com
 ([52.101.84.76] helo=DB3PR0202CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paul.buxton@codasip.com>)
 id 1vMbWk-0004bR-Tj
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 19:31:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q4+BQ37RhI04VB2jaI6xcqM8pCurr/2I84GcHrnqEfeuc73EL7PuHJTN7ADQ6IEE78pKmmkSfVIA1Fvj8DMVqDFag6keRC4l2dXuJ0GoFZ4KqYSQmDG2eu/Qwr8dDaPpGYeeZE8VM7UZcNH+xDxrgxnlUmvdAdRCfMf8JlFajbSbEidBlaXY7gJ1/hxsTdFXk8z6dI92Ki0K1Fz9LwugTFFvC9+LrvCxsLuvTPcnJ5i1zDJXBJmMkpq/tabDr1ZescaDtH7XtzFvYHl73oo3OpM+z9krKkeDwT8lWspEg7Eq4w9AY6RoWeXG3ygHtTzSc1xwd65EbNKwcMCLenUxtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7xuXG9otHN4mF1mp0sXEn511y8RTfvd49JazEHOidTM=;
 b=riJPit5hUhN9YL1ofuQmljc762cE38R3x5dvoepASpS+Qk+BQBIwkgDbJdfJU8k4Qa/vDgU7K4hiRSKNerJBZxQdObEslf1iRN+DyloiC3bNFy6zSExDsuj0DxXz+Ak/l12qRLVvLfnLsL/zO7JWWUr2WK0e0eSduktcNGn13RDn0SQif5kHNQxOUSx+LKwUn+Sv899aDZi8yakZ2MAaCQKWnEIo4peztKhFAy2bPZhWV5146rh8jXoFve1Yjgmb3lor51xLH1PbqBc5LV23yjtplnlJJukTkVFALeu8b9VeVMtRxsdAXUHhlkuRPZia5H4nAb3ZU59cQGR+K6ISlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=codasip.com; dmarc=pass action=none header.from=codasip.com;
 dkim=pass header.d=codasip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codasip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7xuXG9otHN4mF1mp0sXEn511y8RTfvd49JazEHOidTM=;
 b=WvabE5YkTyyjh4WeYp6kqaYA/rGEl+LaeiaHUQEZj3wa7yhIC/NtMTSEjI7jrFUHovp2Y71yghXBsR3HLOMNEJF00QyXQ2LBB1gvJRD/hzWALo7/n0w4PRH5qadZXqS/gAlbACKRXlAtNfsvtNTSOJSr5RVULXzpqNmVvfwnsyHg/Wtv5ZeQz4mbCpm4kNQ3OiBuAwFexOpx25RHYSnMEobzuvptCb8wBl1sehaIflXQoDnZrbNvW+2oKfu/iARSSDwfjGddJwngTQQA1seuYBH5BrExxWKV4m+Ogn2pUYrrEf0CSDq8wicDOjWYxNcfi8ySeYi6DjLhjQs8YUCvUA==
Received: from AM7P192MB0785.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:172::18)
 by PAXP192MB1488.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:287::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Fri, 21 Nov
 2025 13:22:16 +0000
Received: from AM7P192MB0785.EURP192.PROD.OUTLOOK.COM
 ([fe80::71c1:8961:df69:a8db]) by AM7P192MB0785.EURP192.PROD.OUTLOOK.COM
 ([fe80::71c1:8961:df69:a8db%4]) with mapi id 15.20.9343.011; Fri, 21 Nov 2025
 13:22:16 +0000
From: Paul Buxton <paul.buxton@codasip.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RiscV CLIC support
Thread-Topic: RiscV CLIC support
Thread-Index: AQHcWueDoxq2y2svYkG63frA30g3oA==
Date: Fri, 21 Nov 2025 13:22:16 +0000
Message-ID: <AM7P192MB078502920AC2253C73B54DBFEAD5A@AM7P192MB0785.EURP192.PROD.OUTLOOK.COM>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=codasip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7P192MB0785:EE_|PAXP192MB1488:EE_
x-ms-office365-filtering-correlation-id: d8dc2d4f-3978-48ce-c962-08de2900fd90
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|8096899003|13003099007|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?Hf145X+3HQA/b5v4JRunxczp4rOeX87MlmoivQsRhOxBu8MCvO+LXdCJO1?=
 =?iso-8859-1?Q?FTeMyBkpsYcrnCQZh1Om817WRVtL2xzaTHmlKMmctZGLjTHuCdgflcK4fI?=
 =?iso-8859-1?Q?yL63Xnjd2wyGeWK8koX0u7pZwhc4KZdHkLCIvs+KQEgSywPhgHqvgTvF6r?=
 =?iso-8859-1?Q?eM9UGHV8o13IALEsufFsdIsCprDxewYHZOh2hrJ5CUcnYwER8cgt304bsM?=
 =?iso-8859-1?Q?soQ32o2m8USR7NRsDWWJSZbVAbo8GK/PkQ5TXOrTBg6OqlWnulEYwcfLXU?=
 =?iso-8859-1?Q?P5qMuv9yAnVl0/jplYWQv9nJOWJZRgA7i4ycWEUSediGitcAqdj7N4IrTI?=
 =?iso-8859-1?Q?Ec7SWha3H9Gq0WEcbinLiSoHlALay3C4UZ1KoZhAD/ePzqpyEgSEQC8Vt7?=
 =?iso-8859-1?Q?JUxq+uroMIzhbqlQmzq6ZljsRQnjjoPwK7t38lLoyJixb6XZsucuCjDl3E?=
 =?iso-8859-1?Q?uVyptOvPEGQFbTuirGH9Ad3X+ystl5MsiXZmHyL/+0up+1BFQgenfQBoOM?=
 =?iso-8859-1?Q?DMVz5Cl5imNz9ulUI1wmHZlGljhPdFTzB48JTGcD8XW0Qi1gRM3Yikqs9c?=
 =?iso-8859-1?Q?TR5b84EeWv8MYuEqayZdWUSNk8KNG48U9dkynTh/HvVRLUmXnRRFTW6Tdk?=
 =?iso-8859-1?Q?O16cvd8oXSor2hE3BUmb0kxXaIdyoXZZK9tM06GFnFNyKshBJBElF6oRwI?=
 =?iso-8859-1?Q?zKakLF1VdNUJMTHMcrPnuJeSi3p6E+9nAv5P+g+YJpiO/SAVs5hb3Eh2FW?=
 =?iso-8859-1?Q?+EpMZ6DEIK9DyXtQzZuRim0sNRL4OIKlpLkHcryv8W2CSE3qoIL5AEddu5?=
 =?iso-8859-1?Q?J3o/Hb1TQj1rsUEUl6ygcMCctQUuDCuNI8cCaO7/HZNRx0Pl7p7p4IBvDS?=
 =?iso-8859-1?Q?cR2oacachvEdXR4Sv8xeWa4/b3JUzGKXtG6P6/kSRccDQPNqMO7lAxk63B?=
 =?iso-8859-1?Q?foFGkDaeFpWFHV86BoQRRsa5hQ0Fb6Zh6HnwVvjldRXlxa5V0KA6uMaYve?=
 =?iso-8859-1?Q?hMaphcDzN2BI0RKVlolVUkB17LBbAZC2/Tlp6cZUf8XTT2fCSzhasKLDyB?=
 =?iso-8859-1?Q?xYlliBUkoDtdrXmuc4xBvVkzlLfip8KYHm43iXuYZqjml+gC3BFWuuU0kM?=
 =?iso-8859-1?Q?P5N1epa8fPckrf5E9M7YD+qmsdApuYFGQNim8NKCNDUCPH7q78/oT63hV1?=
 =?iso-8859-1?Q?4Pj3XDvUUgqdCdNx8VfCYtalusMilNBRZ6F0xTBPPoJQYH2AJnM2G2idyb?=
 =?iso-8859-1?Q?r/e5vrgnp3HE9Ctcz9ctFT3TvywNofgx5P2EMvmERyMaVMkcnh82bHOLYV?=
 =?iso-8859-1?Q?VAWOPoY/ssYSfhBCa3unWc0jBZ+9b7hXhXKxph5mpuyYfOvCK5Gne8n6Dj?=
 =?iso-8859-1?Q?QhDK6JKsq4d2ZQ0yRBdz0vUcv3ElHmRoBm5neU1tQ4O+TdDdL5yKhn5Wpi?=
 =?iso-8859-1?Q?tmhpwctLP13XwiA2X5VxvvaRvHHljOdOKMmGVCYCr6d1+vmL3+LkMK97Dd?=
 =?iso-8859-1?Q?Hgo/AULphVTRsHjGdPkwzs45nT8lf9ibUiO8DX62jvGYJY5CMETrBOzd8+?=
 =?iso-8859-1?Q?CX1ewYazHwJ7Ehh2foNYuMTaoIIX?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7P192MB0785.EURP192.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(8096899003)(13003099007)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?0nmTGB7Qw4l2XlqiJ0gM5IKkoSph38Qmw0upMdJJUshjEJLkyae8AsDyh5?=
 =?iso-8859-1?Q?CBf83VlSO24QymBlRlgRa16YWxIeOMdKXU+jUMwbhN6tqYSmecterI7m4d?=
 =?iso-8859-1?Q?U5aJKIdhsKKSgInVQtLx8Jbj5caDR5CXwq4dlkKYdk37X8aQg+fa2TmlMi?=
 =?iso-8859-1?Q?zNEF40ysXnhtFFYBNB9mskxRKWLl9rvIf3seaBP5hTDnOE7GojM9aAAOLF?=
 =?iso-8859-1?Q?keyc+6is3JeUqkj3nY1SvfI+Vl0Bpr+nGkYwb2AXKEeS5+TmTqP1g4f6Jw?=
 =?iso-8859-1?Q?gqctN8sZdpTVvUdQy0B9y1ut2J0uB5kAQZ5Ef09W9XUSLv+8Ko3C6iLLnt?=
 =?iso-8859-1?Q?f7BUj76WmELy0BVttvXUbqkNEZuunplAN1hMxQElgTylaIcc03mOpRFc1H?=
 =?iso-8859-1?Q?7MRxp6UYNvorF+YBtx1JlDGf0gKxuiMR7sQykvr5WzhqoBA28dH//x50P2?=
 =?iso-8859-1?Q?sSSgagV33IXMfDOGzKJtV0QaAEztAewVaVvjwl074MNC4CKuzE3oN8cXbs?=
 =?iso-8859-1?Q?uWCCfQUOWUYr9C0QV2QGHUKlBwGjPSXvjL331aZzYb6XAFKQwRiM1GJ7Xp?=
 =?iso-8859-1?Q?E7pAhF8Iyh8JukhTh5ZjKOIeUgNx5bi+T4U0sqM2aGTAWU7Wcr/FgoFY6S?=
 =?iso-8859-1?Q?g86qWeJ6ywvxQxZFlVOu7yvvM+SFKkx8wwF2xsugwttmaAS2zF8Kr1sxdE?=
 =?iso-8859-1?Q?3OzKUIvcAafRGHqjpTttm/zWJXGxgPP2YciTvkwpkKpWuWNKkuooEw5jtO?=
 =?iso-8859-1?Q?9MAXHUIakfL4nSKBqhlE1/jAM7HAbhNTnX1tde//+R7vhslTBGyHQXQIxj?=
 =?iso-8859-1?Q?5Y/RndRlz7y29ghOyTOyTlL6U/paG2VKNftAmknfRUtrn/HUkoRjUcK2MT?=
 =?iso-8859-1?Q?OilwCv7EFJ62VsQ0ClClLxehvH/gVatTgk3GVLX2p0tk1Si6sEOssveE8N?=
 =?iso-8859-1?Q?WwlTi1elxSi2tGmei4VxMUtxEuyGz8aIN11SYgQJ+WyIIcP4xKnI32NbAp?=
 =?iso-8859-1?Q?b15CV9BfczCUrWpMzAo+9R3iave+Cy90sLxYPo/YCQZmfzJOIpxVXIJcT3?=
 =?iso-8859-1?Q?6pSILf207MLCj+UUGQ+1m+NLGtmrYdiAJ3ZhhZRIpdfEmjLfO5FDRXvOVy?=
 =?iso-8859-1?Q?acAmdlh+Wc7NwvMuC8a8qlhYctLbttQKHr+wpL+vPHmxa39LCx9/i0KCzr?=
 =?iso-8859-1?Q?OzzHEWXoNWvgRXcW06r4uT16Fq/PGPEff9WeKv0P4mfbxZz4umz/OBkKb/?=
 =?iso-8859-1?Q?XSNBoOCBMLeJ5WlwDdcwcvxwqenB3EtViafz/KLSVWxt/fMmEQ/kjA0caA?=
 =?iso-8859-1?Q?6Y4TIR7i3YFRqEsM0BzzIpaAB9VFLRVKA4NVS01XJBMGxBtC8A6Sh5+WVY?=
 =?iso-8859-1?Q?ax4KkDVMfMGyuJWOBn94Xa44kV/7KTt/lMRZxf+LEqOJl9426XQxvCfUZD?=
 =?iso-8859-1?Q?NSq4EnS0/WjBz4UzzL/sJOeGkm8Xy6nUaQX9x8YK/+4ygSE1xHTh2MPYP0?=
 =?iso-8859-1?Q?soXA6qQFVRy5rvbCIi7/bjsHz4nCG5elsvSecMq032eS8WMEAvTg9mhbSQ?=
 =?iso-8859-1?Q?H+jUCLPVl+D8NTi6QP3O53ojILviSjMEeZuDwTQasWHjS4YuQQwOo2QNaj?=
 =?iso-8859-1?Q?mXx+Az0EfZHy7ZHi0VENzvIVEfrsBKiXNh?=
Content-Type: multipart/alternative;
 boundary="_000_AM7P192MB078502920AC2253C73B54DBFEAD5AAM7P192MB0785EURP_"
MIME-Version: 1.0
X-OriginatorOrg: codasip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7P192MB0785.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: d8dc2d4f-3978-48ce-c962-08de2900fd90
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2025 13:22:16.3831 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d91ffef-bb81-4cbd-b9b8-552583685f20
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WvwYvmpVEEZTH9+dAjQ4YFzxEhHEcxuoGi25ogPzinO64WxxV1cq677XlQgko+7/xfQtydkTRZ6Lo6e8S2I/iQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP192MB1488
Received-SPF: pass client-ip=52.101.84.76;
 envelope-from=paul.buxton@codasip.com;
 helo=DB3PR0202CU003.outbound.protection.outlook.com
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

--_000_AM7P192MB078502920AC2253C73B54DBFEAD5AAM7P192MB0785EURP_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

I was looking for CLIC support and came across the patch-set https://lists.=
nongnu.org/archive/html/qemu-devel/2024-08/msg02791.html
But I do not see any merges with CLIC functionality. Is this because the sp=
ec is still not ratified or is there a functional issue?

Regards,
Paul

--_000_AM7P192MB078502920AC2253C73B54DBFEAD5AAM7P192MB0785EURP_
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
Hi,</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
I was looking for CLIC support and came across the patch-set <a class=3D"OW=
AAutoLink" id=3D"OWA86427c49-4a8e-a4f5-0876-03c20e7ddf3f" href=3D"https://l=
ists.nongnu.org/archive/html/qemu-devel/2024-08/msg02791.html">
https://lists.nongnu.org/archive/html/qemu-devel/2024-08/msg02791.html</a><=
/div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
But I do not see any merges with CLIC functionality. Is this because the sp=
ec is still not ratified or is there a functional issue?</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Regards,</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Paul</div>
</body>
</html>

--_000_AM7P192MB078502920AC2253C73B54DBFEAD5AAM7P192MB0785EURP_--

