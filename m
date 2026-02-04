Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1911AE83EED
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 08:24:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnY8z-0002WJ-8u; Wed, 04 Feb 2026 03:21:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vnY8x-0002Vc-Bc; Wed, 04 Feb 2026 03:21:47 -0500
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vnY8v-0003UH-Ac; Wed, 04 Feb 2026 03:21:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R1g2WbJlYMj2ciFTbVBwjKwkqMfpt27iPnunincosID65sDQTrJ2Mi4T948olNjeA8IJho1ugkCv8uDdqDd1iDUp40DiGWSbQqfVhcGS1U3W93TJ8up6PdJj2EMDDLirgnSssqUXG4xpviatV/OjrOFQYj8lNrnTCWTspqvuo3E261QyDPmwtQk65dzT1ohVNIlZT+GqaujsgDTRT0eFqvB3pTkDLcp8aWonPgWA5k7HcJ6wOB4X1GFM2hHaPAZdb0H4dgUx3/9wKnnWxKk1aKS96B4POCm7j8r1xwRfVsMOx4KnBOiaw1zxJ47G8f9oXZWuSB5Jne48A5vvXKFqtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PyFz6C9NjgCSu7Iq6a+36uEHCmx40oD3DTtYAI9VrdE=;
 b=lh91c6S2Q323E9SRl1sA5kOFCCClNr3N9ot3k5YNUJw/7qY+CpoyH+odbnspxEDfY9/loGWlPgVUKdCgxjIc2ZeYWAAAhLWhGr0eJENGgd+m5+l7Aq1XFMiI5/EM4bMwgmH+BF5+DdyzopN4jE0ihLkor2aNLmr5Wo/SKwzQteACbnEpQlJYEWD9nX+By5ZnlDSFZEjQ79//D/fO6fyos63pH/zjPcoHmGKyKIb78CTNlLh53EhrX5uMOpT/mxBNMeo5GiSEZO3J9zBd7A2S64BPmIPPpoAUKvAOvZpFvPJoqMCYd9cEn0XZczm94s0nQlnDWFwltvLRYM7VeJnuVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PyFz6C9NjgCSu7Iq6a+36uEHCmx40oD3DTtYAI9VrdE=;
 b=oHOKrwifCWE+JgtFWhqOfrGD4DxTNXp1cSNqFxVmXryN/QtPrCIvazi+X5Fr2ath/WDYEzCetR2jbRHC4qvef8FNO0fv8+3RMhgBaC5n3eaylixbzdLfJ34ic7Hj4knIA85AJilJsyRwIEkz66pbiTOBl2s2/XJ3+s7SSQS3zf23hyYJ7ouwD+bt3o93eRY8Z7vgtJWWr674H/CzRHdlAN+z53s20USD5gZbsLQMGwUJRzjnuLlYGmMVHXIPQ4fs/Edmcl12+l2c5K/EYONRd6imgAWhPBNWp3rCU2+yQ7ZolH/bXvOUGgMg378o9TMh72Rgzu6ZzzOiXK8RIC150A==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by PUZPR06MB5586.apcprd06.prod.outlook.com (2603:1096:301:e8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Wed, 4 Feb
 2026 08:21:35 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c%4]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 08:21:35 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, "kaneluno1@gmail.com"
 <kaneluno1@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>
Subject: [PATCH v7 14/22] hw/arm/aspeed: attach I2C device to AST1700 model
Thread-Topic: [PATCH v7 14/22] hw/arm/aspeed: attach I2C device to AST1700
 model
Thread-Index: AQHcla9Gm4DX0CSzY060AW3uDHgVTg==
Date: Wed, 4 Feb 2026 08:21:35 +0000
Message-ID: <20260204082113.3955407-15-kane_chen@aspeedtech.com>
References: <20260204082113.3955407-1-kane_chen@aspeedtech.com>
In-Reply-To: <20260204082113.3955407-1-kane_chen@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|PUZPR06MB5586:EE_
x-ms-office365-filtering-correlation-id: 78ca3085-8306-4c9b-5945-08de63c66926
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?dsUBdyKF7Iqvi4uTfT7fShV1qUAKAm5CG/oaxmrXJElea3J3uXieCJD5Ay?=
 =?iso-8859-1?Q?rnHG3ZRiLr/Y9DfwsfYoQh2jHTB13Lu4uZbz6zSOZFOZBntZ3wX3IV1SMM?=
 =?iso-8859-1?Q?1X8CgV/8yIR4Zd77/ZhSYyUkE4E0XEnnyZQTF6e6lwPx35vP0Snu6iibhk?=
 =?iso-8859-1?Q?T3Shpblf+bkPexUcevjPPIvlYnA43p88pQoK8nNsb0koYgTggMoo6Ln4NW?=
 =?iso-8859-1?Q?5T5hhbZPESeGzz5OFpzO2vZVJU/J/yaRWoXYaHaubpVzhf2VIrwpZi0ACJ?=
 =?iso-8859-1?Q?x14qSIuGNTTeIZTO2ikCPO6vJ+WwLTJEX/XGIGKWVd7hWKrq/gWTCFkqoG?=
 =?iso-8859-1?Q?8vjsjKWNDIUqUXJVvv1c3zh3UPw4L11X4zyZ6Tqwl3R51aUYyHztXbJxWA?=
 =?iso-8859-1?Q?EgeStqjjYk6Xt3LaxzRl0gt+5oiCZgTAes4r1lobglREZjgljluaepLANh?=
 =?iso-8859-1?Q?At3AHFXtKwecZ85zcUEbYXveyESdB/WATb3zaSaPDTshtLDJqJjqYPsiG7?=
 =?iso-8859-1?Q?leA3GKUO+6isjR0AeMME5nddDzQbB5FNpBLYXi0TUxbTALeJ9xKwPyZjNs?=
 =?iso-8859-1?Q?wA9okE6bjswiA/hKxuEgyopxGb6e6wMi1Xv09fEHJuF4hFB5fq/kGiGjT6?=
 =?iso-8859-1?Q?MgZEdCzWM6Gp2ESFCdv5ieiP7pTx18C8asQNEmaxFws2YI17vF2cy3CyPA?=
 =?iso-8859-1?Q?+ejfyb3bKEyw7KU4C23XLGku+9QWg1i3mbRh2QJV0FNHx4RTRV1rXSuuVG?=
 =?iso-8859-1?Q?epF0eBXay4Ak7p989A7sF6Q1++b/sHp3GuP5DlPqMLN6qh3i6HYDJrm8UK?=
 =?iso-8859-1?Q?u+Ha36tOExIBs+9JPtQGpbOtHmdAAC8+FqpRsPLJMfu9Dv4d4CC7pA1zY2?=
 =?iso-8859-1?Q?fHqzIuS1O4GkX1gSS3WRjanaetnrUFQk4/e5d05VQZLChN6iYROTLyea+N?=
 =?iso-8859-1?Q?alN0oZWFwS4LxV2Tb2sqCVsF00DTypHa2dsTSRcX6CjjJvvn5Ukb16wYRP?=
 =?iso-8859-1?Q?Qu9dn5xhs7qk38FQZH2/SCTzJ0XxshS0YkNgDffJrNDOXL6R8YN/runkAu?=
 =?iso-8859-1?Q?Ejh8o3d7kX2Dr4CgIPvYE4cNEZ5KGbFALcoWKM2+oJ899bQtC3E29dwwTQ?=
 =?iso-8859-1?Q?Oq1F/iwa3eqjvX7nh6J46iQKurvJ49eQoBy3xliBUcyVggXCwE5S+uRN5i?=
 =?iso-8859-1?Q?av3kdVItdiWGAFQcW6VWedLUrsRe7VlRT9Dwpo7yGmdbJh/jqzz4UoYDb7?=
 =?iso-8859-1?Q?7AjvjK3hIk6+KCAtwbgITBIA3Hv17zuetCUFKOkPkZx7eFlrfHrqN7Ibgh?=
 =?iso-8859-1?Q?RncvW5k6wk6lDnURjUzkle8b6AVA9yO5r6kXIEtUXp9UjbNkOxjC3zhB5Z?=
 =?iso-8859-1?Q?dVtspLHKu8QhXYpLQD/j+Pbff0taARnYLJKcUkcrkJV7js6xckDC0g8wbn?=
 =?iso-8859-1?Q?28MdTXAjdKla+jCBOYlcPugmCyTkA1unY0vMNiKveCTFFXzuyrzoAXMWon?=
 =?iso-8859-1?Q?HWG6qXR7wXi48YxE301d7KwVy1D9Fx8Gfc8zrWglOkZMX/1pIkEd6pOOJI?=
 =?iso-8859-1?Q?9nCZQzQMObUAxCMyx5JbHXnaIDm6GXUaSjd09i2peiC78LpET3xn1gv5lg?=
 =?iso-8859-1?Q?NcQS6KsjVzIRBm6Ua0QuZN2DHXE2Y66qxnswx67lhrtsiyNIS38pB7HxAS?=
 =?iso-8859-1?Q?KzLlC+QzsnQPErnD1U4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?5EsASzZ9geqKaom6CwQO7zPURwYlm0V98sPoYtSZGvmjdx6V21Oy2FpZwH?=
 =?iso-8859-1?Q?nIcvgAmrZcHR33A/AyNhJFOW0vQy/DAelb7qtJCmdndTzCURT3WKV9mfJY?=
 =?iso-8859-1?Q?XxWsmSyrwaDhFETbfjCvlH0uO6EuZaWzBR4uIFkmWY7ES45A4RMjKFRbrc?=
 =?iso-8859-1?Q?y6XDWazTI3zlr9ilRw98/wzw26YAv5gBfAs0ncluxVfDSvyAd0S3wF+wKc?=
 =?iso-8859-1?Q?1WqWyyLDnaNS4NkZh+usuSxJfLo5xqs7RxxPXCWoXPnzBm2mVxBtrIdwxu?=
 =?iso-8859-1?Q?Kin7SgNWucKHvZfk8d8q51lnY/A6sxBvm9NFsuhI/gOOfuMFY0vrFQy1Fg?=
 =?iso-8859-1?Q?zMzH6tXRWTEf/NUdSKB+Wiw+MRXaAn4x3EFz1JcR4llXT+XEuxMb0nCJfB?=
 =?iso-8859-1?Q?yJHp5rYjEX8qQLtQsEyE1CLX7dYqgPncP7vZoToQrscqRlkEsild2HJ4Pl?=
 =?iso-8859-1?Q?dNUixgvmrnb2iR5m1YZaSDOpc5cs2Sb2I+KaXPE+T4O+sh4vd7dA4hgFf7?=
 =?iso-8859-1?Q?7yNeO9gy75CrNyUjOT39re0iRGXQKBSckn1H9SuHOVoIlza9PYOmkw1WK3?=
 =?iso-8859-1?Q?INKJd2h6Eu5f5+VXbq60nflwvs2X+bIqw/1uRugyrh13moWFYKFu8dMkgj?=
 =?iso-8859-1?Q?ORXfqh712e10NstU3nd+dSNI1aLTncsiINgDnSHZbkdhvD4kGdUpO38zTN?=
 =?iso-8859-1?Q?PU9uXZ1XLBQV1ifMqKJFEcIE3ojifWTppk4Zzb7LFfM9Yh0nV4ooFkFBJw?=
 =?iso-8859-1?Q?DQ1KzUpbiV+GYV0Se6kS89MccnjjmBp4tJfw1GV35jP1TBSeILpZiTNpum?=
 =?iso-8859-1?Q?rDi10SIGoE49R8MmhLBErEZg+UNgzMXqnQnIyz/af8KgYwISBgv/t0PRUg?=
 =?iso-8859-1?Q?5/Kz7D6MKor/INO5II+9q3hj3jaZx+1QyCWUT8JSQ2h7hXvLbv9kvfJqy1?=
 =?iso-8859-1?Q?YINd2tun5jNnEMzCVTh5y4emn6dqfJUHT0AABpJrEiOD6FDYDgDS4hCqEZ?=
 =?iso-8859-1?Q?lAFvVuDuRt/JT344zQB/3gc5GEQyIpS92D+uYrgA13uUnMN4cXx7OSjyJ/?=
 =?iso-8859-1?Q?YoY36pU9g0R8bg9dC3kjTIsh3WZ9Eg6OIljYqDMGj4qpGCqeWBtnsnGFKT?=
 =?iso-8859-1?Q?Nf+XYkf3G2Q59sph/SMpqL7hezj9o3nfcLZ1zGYuOl6Luujgt83DWMsxOy?=
 =?iso-8859-1?Q?NgNNEQaRjibp/V4VQM3C/S9aeQVf0vVrlLKMqN7D2LG9MCgQoRI92xmyOy?=
 =?iso-8859-1?Q?bVHhVqD1ffPFcpfcBjGLT0h8pD9zFi29Y2Bvgx6Ly7muAmEg5+x5CFTbGt?=
 =?iso-8859-1?Q?ckk6fSePYSC84zqXOo42XYLtLp8wJph4p0vbLH44WvO9+lOTHW8ZFTKV4i?=
 =?iso-8859-1?Q?ec+Su0Gart+kzOGCyTThp8PTJKpU5sQY024YKpLvuZlLb79ZtxqYbr0Xrn?=
 =?iso-8859-1?Q?4j72a5Don9a68Xz6X5GJvpDmu4+8WnC9vqNtHzANG6yheSOl5i5o6sc/PN?=
 =?iso-8859-1?Q?QY0SnVs2rpmpPzW/sSPecagFgDOhSHSZlqV7YUM2pnytrUjMgovLLCTl6U?=
 =?iso-8859-1?Q?9lDPul3zpyfArpHga+x+wUGlU67MriVWmESp4lk9iy0VFGY/yse7QpEDUQ?=
 =?iso-8859-1?Q?/dksEGLwM4wN8jr/K7l0x+lBbg2efPuf9BhV5kKtHiXPztDJNbHXV6mum5?=
 =?iso-8859-1?Q?fcsTKlHxD8TERk7H8D9yGkCEHhMEwwaFbeVW/cAdU5HVX3G33t6P9ZfPHW?=
 =?iso-8859-1?Q?5iKO3cbReEfl+2sDraczRlTIXySdg4wCn6KV2pyjCqeHTVyDyZCJU5JWIi?=
 =?iso-8859-1?Q?FdCYKNJWHQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78ca3085-8306-4c9b-5945-08de63c66926
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2026 08:21:35.1004 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OM5a0m4zSX88tYSiZMOOBowDumpGrs/xRhFeGHHuIocnAfrlClFvuAQTCvlHuDZJJuWLGGG09A2Pnc0S+4h5GqAC/DCSo1zrVmbI7jlgPdA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5586
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=kane_chen@aspeedtech.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Connect the I2C controller to the AST1700 model by mapping its MMIO=0A=
region and wiring its interrupt line.=0A=
=0A=
Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>=0A=
---=0A=
 include/hw/arm/aspeed_ast1700.h |  2 ++=0A=
 include/hw/arm/aspeed_soc.h     |  2 ++=0A=
 hw/arm/aspeed_ast1700.c         | 19 ++++++++++++=0A=
 hw/arm/aspeed_ast27x0.c         | 51 +++++++++++++++++++++++++++++++--=0A=
 4 files changed, 71 insertions(+), 3 deletions(-)=0A=
=0A=
diff --git a/include/hw/arm/aspeed_ast1700.h b/include/hw/arm/aspeed_ast170=
0.h=0A=
index 63cfcb4c24..1005ce6364 100644=0A=
--- a/include/hw/arm/aspeed_ast1700.h=0A=
+++ b/include/hw/arm/aspeed_ast1700.h=0A=
@@ -12,6 +12,7 @@=0A=
 #include "hw/misc/aspeed_scu.h"=0A=
 #include "hw/adc/aspeed_adc.h"=0A=
 #include "hw/gpio/aspeed_gpio.h"=0A=
+#include "hw/i2c/aspeed_i2c.h"=0A=
 #include "hw/misc/aspeed_ltpi.h"=0A=
 #include "hw/ssi/aspeed_smc.h"=0A=
 #include "hw/char/serial-mm.h"=0A=
@@ -35,6 +36,7 @@ struct AspeedAST1700SoCState {=0A=
     AspeedADCState adc;=0A=
     AspeedSCUState scu;=0A=
     AspeedGPIOState gpio;=0A=
+    AspeedI2CState i2c;=0A=
 };=0A=
 =0A=
 #endif /* ASPEED_AST1700_H */=0A=
diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h=0A=
index b051d0eb3a..4ea2521041 100644=0A=
--- a/include/hw/arm/aspeed_soc.h=0A=
+++ b/include/hw/arm/aspeed_soc.h=0A=
@@ -290,6 +290,8 @@ enum {=0A=
     ASPEED_DEV_LTPI_CTRL2,=0A=
     ASPEED_DEV_LTPI_IO0,=0A=
     ASPEED_DEV_LTPI_IO1,=0A=
+    ASPEED_DEV_IOEXP0_I2C,=0A=
+    ASPEED_DEV_IOEXP1_I2C,=0A=
     ASPEED_DEV_IOEXP0_INTCIO,=0A=
     ASPEED_DEV_IOEXP1_INTCIO,=0A=
 };=0A=
diff --git a/hw/arm/aspeed_ast1700.c b/hw/arm/aspeed_ast1700.c=0A=
index 7efce450f6..e264b2200b 100644=0A=
--- a/hw/arm/aspeed_ast1700.c=0A=
+++ b/hw/arm/aspeed_ast1700.c=0A=
@@ -22,6 +22,7 @@ enum {=0A=
     ASPEED_AST1700_DEV_ADC,=0A=
     ASPEED_AST1700_DEV_SCU,=0A=
     ASPEED_AST1700_DEV_GPIO,=0A=
+    ASPEED_AST1700_DEV_I2C,=0A=
     ASPEED_AST1700_DEV_UART12,=0A=
     ASPEED_AST1700_DEV_LTPI_CTRL,=0A=
     ASPEED_AST1700_DEV_SPI0_MEM,=0A=
@@ -33,6 +34,7 @@ static const hwaddr aspeed_ast1700_io_memmap[] =3D {=0A=
     [ASPEED_AST1700_DEV_ADC]       =3D  0x00C00000,=0A=
     [ASPEED_AST1700_DEV_SCU]       =3D  0x00C02000,=0A=
     [ASPEED_AST1700_DEV_GPIO]      =3D  0x00C0B000,=0A=
+    [ASPEED_AST1700_DEV_I2C]       =3D  0x00C0F000,=0A=
     [ASPEED_AST1700_DEV_UART12]    =3D  0x00C33B00,=0A=
     [ASPEED_AST1700_DEV_LTPI_CTRL] =3D  0x00C34000,=0A=
     [ASPEED_AST1700_DEV_SPI0_MEM]  =3D  0x04000000,=0A=
@@ -113,6 +115,19 @@ static void aspeed_ast1700_realize(DeviceState *dev, E=
rror **errp)=0A=
                         aspeed_ast1700_io_memmap[ASPEED_AST1700_DEV_GPIO],=
=0A=
                         sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->gpio), 0=
));=0A=
 =0A=
+    /* I2C */=0A=
+    snprintf(dev_name, sizeof(dev_name), "ioexp%d", s->board_idx);=0A=
+    qdev_prop_set_string(DEVICE(&s->i2c), "bus-label", dev_name);=0A=
+=0A=
+    object_property_set_link(OBJECT(&s->i2c), "dram",=0A=
+                             OBJECT(s->dram_mr), errp);=0A=
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->i2c), errp)) {=0A=
+        return;=0A=
+    }=0A=
+    memory_region_add_subregion(&s->iomem,=0A=
+                        aspeed_ast1700_io_memmap[ASPEED_AST1700_DEV_I2C],=
=0A=
+                        sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->i2c), 0)=
);=0A=
+=0A=
     /* LTPI controller */=0A=
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->ltpi), errp)) {=0A=
         return;=0A=
@@ -146,6 +161,10 @@ static void aspeed_ast1700_instance_init(Object *obj)=
=0A=
     object_initialize_child(obj, "ioexp-gpio", &s->gpio,=0A=
                             "aspeed.gpio-ast2700");=0A=
 =0A=
+    /* I2C */=0A=
+    object_initialize_child(obj, "ioexp-i2c", &s->i2c,=0A=
+                            "aspeed.i2c-ast2700");=0A=
+=0A=
     /* LTPI controller */=0A=
     object_initialize_child(obj, "ltpi-ctrl",=0A=
                             &s->ltpi, TYPE_ASPEED_LTPI);=0A=
diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c=0A=
index cd4028fcd4..8242258df4 100644=0A=
--- a/hw/arm/aspeed_ast27x0.c=0A=
+++ b/hw/arm/aspeed_ast27x0.c=0A=
@@ -157,6 +157,8 @@ static const int aspeed_soc_ast2700a1_irqmap[] =3D {=0A=
     [ASPEED_DEV_EHCI4]     =3D 196,=0A=
     [ASPEED_DEV_PECI]      =3D 197,=0A=
     [ASPEED_DEV_SDHCI]     =3D 197,=0A=
+    [ASPEED_DEV_IOEXP0_I2C] =3D 198,=0A=
+    [ASPEED_DEV_IOEXP1_I2C] =3D 200,=0A=
 };=0A=
 =0A=
 /* GICINT 192 */=0A=
@@ -213,6 +215,18 @@ static const int ast2700_gic197_intcmap[] =3D {=0A=
     [ASPEED_DEV_PECI]      =3D 4,=0A=
 };=0A=
 =0A=
+/* Primary AST1700 Interrupts */=0A=
+/* A1: GICINT 198 */=0A=
+static const int ast2700_gic198_intcmap[] =3D {=0A=
+    [ASPEED_DEV_IOEXP0_I2C]       =3D 0, /* 0 - 15 */=0A=
+};=0A=
+=0A=
+/* Secondary AST1700 Interrupts */=0A=
+/* A1: GINTC 200 */=0A=
+static const int ast2700_gic200_intcmap[] =3D {=0A=
+    [ASPEED_DEV_IOEXP1_I2C]       =3D 0, /* 0 - 15 */=0A=
+};=0A=
+=0A=
 /* GICINT 192 ~ 201 */=0A=
 struct gic_intc_irq_info {=0A=
     int irq;=0A=
@@ -228,9 +242,9 @@ static const struct gic_intc_irq_info ast2700_gic_intcm=
ap[] =3D {=0A=
     {195, 1, 3, ast2700_gic195_intcmap},=0A=
     {196, 1, 4, ast2700_gic196_intcmap},=0A=
     {197, 1, 5, ast2700_gic197_intcmap},=0A=
-    {198, 1, 6, NULL},=0A=
+    {198, 2, 0, ast2700_gic198_intcmap},=0A=
     {199, 1, 7, NULL},=0A=
-    {200, 1, 8, NULL},=0A=
+    {200, 3, 0, ast2700_gic200_intcmap},=0A=
     {201, 1, 9, NULL},=0A=
 };=0A=
 =0A=
@@ -263,14 +277,23 @@ static qemu_irq aspeed_soc_ast2700_get_irq_index(Aspe=
edSoCState *s, int dev,=0A=
     int or_idx;=0A=
     int idx;=0A=
     int i;=0A=
+    OrIRQState *porgates;=0A=
 =0A=
     for (i =3D 0; i < ARRAY_SIZE(ast2700_gic_intcmap); i++) {=0A=
         if (sc->irqmap[dev] =3D=3D ast2700_gic_intcmap[i].irq) {=0A=
             assert(ast2700_gic_intcmap[i].ptr);=0A=
             or_idx =3D ast2700_gic_intcmap[i].orgate_idx;=0A=
             idx =3D ast2700_gic_intcmap[i].intc_idx;=0A=
-            return qdev_get_gpio_in(DEVICE(&a->intc[idx].orgates[or_idx]),=
=0A=
+            if (idx < ASPEED_INTC_NUM) {=0A=
+                porgates =3D &a->intc[idx].orgates[or_idx];=0A=
+                return qdev_get_gpio_in(DEVICE(porgates),=0A=
+                                    ast2700_gic_intcmap[i].ptr[dev] + inde=
x);=0A=
+            } else {=0A=
+                idx -=3D ASPEED_INTC_NUM;=0A=
+                porgates =3D &a->intcioexp[idx].orgates[or_idx];=0A=
+                return qdev_get_gpio_in(DEVICE(porgates),=0A=
                                     ast2700_gic_intcmap[i].ptr[dev] + inde=
x);=0A=
+            }=0A=
         }=0A=
     }=0A=
 =0A=
@@ -1025,6 +1048,8 @@ static void aspeed_soc_ast2700_realize(DeviceState *d=
ev, Error **errp)=0A=
 =0A=
     /* IO Expander */=0A=
     for (i =3D 0; i < sc->ioexp_num; i++) {=0A=
+        AspeedI2CClass *i2c_ctl;=0A=
+=0A=
         qdev_prop_set_uint8(DEVICE(&s->ioexp[i]), "board-idx", i);=0A=
         object_property_set_link(OBJECT(&s->ioexp[i]), "dram",=0A=
                                  OBJECT(s->dram_mr), &error_abort);=0A=
@@ -1057,6 +1082,26 @@ static void aspeed_soc_ast2700_realize(DeviceState *=
dev, Error **errp)=0A=
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->ioexp[i].gpio), 0,=0A=
                            aspeed_soc_ast2700_get_irq(s, ASPEED_DEV_GPIO))=
;=0A=
 =0A=
+        /* I2C */=0A=
+        i2c_ctl =3D ASPEED_I2C_GET_CLASS(&s->ioexp[i].i2c);=0A=
+        for (int j =3D 0; j < i2c_ctl->num_busses; j++) {=0A=
+            /*=0A=
+             * For I2C on AST1700:=0A=
+             * I2C bus interrupts are connected to the OR gate from bit 0 =
to bit=0A=
+             * 15, and the OR gate output pin is connected to the input pi=
n of=0A=
+             * GICINT192 of IO expander Interrupt controller (INTC2/3). Th=
en,=0A=
+             * the output pin is connected to the INTC (CPU Die) input pin=
, and=0A=
+             * its output pin is connected to the GIC.=0A=
+             *=0A=
+             * I2C bus 0 is connected to the OR gate at bit 0.=0A=
+             * I2C bus 15 is connected to the OR gate at bit 15.=0A=
+             */=0A=
+            irq =3D aspeed_soc_ast2700_get_irq_index(s,=0A=
+                                                   ASPEED_DEV_IOEXP0_I2C +=
 i,=0A=
+                                                   j);=0A=
+            sysbus_connect_irq(SYS_BUS_DEVICE(&s->ioexp[i].i2c.busses[j]),=
=0A=
+                               0, irq);=0A=
+        }=0A=
     }=0A=
 =0A=
     aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->dpmcu),=0A=
-- =0A=
2.43.0=0A=

