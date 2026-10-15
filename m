Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D966CC6B2F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 05:58:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHESn-0001u5-56; Thu, 15 Oct 2026 01:57:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xHESa-0001mj-2Q; Thu, 15 Oct 2026 01:57:00 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xHESY-0003Da-Gz; Thu, 15 Oct 2026 01:56:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tm7C6RqvNS1nY0vsrWMzb18WQbAAKK8B9jFqx8o2G/FfuNOPPGkWmH91xfuBZtrsaCXCCOxilKGuuiOGNe2KYbPCYKsqsYoYwBuHknenRRHOjAFZMhQD372TFs8gB8qRnAXJhiYmQ+0Jg/HmYmi/CfBYmQpjxNxAjlHW427JDFwd27Z25ycqIjlr8Mpx/1E2f5peCE9JYSyad9nExnC1sAyP/NnpMwI1r/iq3T72Ru2ynFOSzg317krGdrcA7EJ0j60pDvc1Jr3V4X70tTkNfN/ylc9mJW02ACi9PGGav4ahUOHtJmqTi/VaOA8oNf4vvkb6GxWTOoymtDIwHNpuwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aNT+bSnprLxGr9x5LR4wf5RVp1zaTnmCR7T0b6COZ+Q=;
 b=JFEQ4YXjASDzHdZysOzmJqW0Tube8GSy7X1zPtsf3lxl/5+iOxZ7NEHpCn2OwMuQc3qjcgo7OOMMSklFHU2CN+IqVgM4z1/gPBUXWbzRNtROJJUa6OwTK84ixjkO/73JhlYDQMIHC8Knm1AAdpo7CCZ1fECaW4+m19peUqcdGYIDkvpWznM/fg+G/aDcEmww6FzPXB78lyRh7XTmKg+EUDnGEq+YY9X50qr8pKo1auZW8ylJp/cgwUqBzyjeR0bUG+D9B3vPoUrJCfmXW967hgXujT20s3PDsT2GUhDvDVt5H+EzVaLUPI+WyTte+kV5ApnqxzUR0ESw8vKAIlOK8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aNT+bSnprLxGr9x5LR4wf5RVp1zaTnmCR7T0b6COZ+Q=;
 b=Mk45gevFtaHtE/K14OwND63M9rK8Y7QWEIy32mSwrJ0TgMwkeck8wkRMhcYNIXOrWpHv0oXHSiTzNPSesT7VuJhe2keK+BjyS15Yo7qoCc7vof1od5HGzL9dXzTtnI4WdOx24tLvitjKk1r0rGcA6dP+Nq9jbxajytKBPhYAaAXKfawT6g3Hs36N/IfcuPLY1i6JPdOb5tps/peAMypOrCG9h4juORv2YtC4bjoTrbGk8sYuSuLCkQ35tqEbxVCEY7ZFdHBghYAXiicwJz4Bs0r46jkbyXQ19EbO/oFaOl2rNQ12zhQGM2NLfAyc+HR4s/4DMzqR8/Cir6XOhFJSAw==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by TYZPR06MB6954.apcprd06.prod.outlook.com (2603:1096:405:43::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 05:56:51 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 05:56:47 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Alistair
 Francis <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>, Hanna Reitz
 <hreitz@redhat.com>, Fabiano Rosas <farosas@suse.de>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:Block layer core" <qemu-block@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 03/14] hw/block/m25p80: Rename w25q32dw to w25q33pw
Thread-Topic: [PATCH v1 03/14] hw/block/m25p80: Rename w25q32dw to w25q33pw
Thread-Index: AQHdXGn2L8V1TgY+PEeI7EZZXZP+LQ==
Date: Thu, 15 Oct 2026 05:56:46 +0000
Message-ID: <20261015055642.106204-4-jamin_lin@aspeedtech.com>
References: <20261015055642.106204-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261015055642.106204-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|TYZPR06MB6954:EE_
x-ms-office365-filtering-correlation-id: 4ac7400b-821c-4e7e-ab43-08df2a811968
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|23010399003|38070700021|56012099006|921020|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: uSClahPRyIhQehWn/jSQVzGxQ4pwn04P8UGBRvGAAafDYzaDg5/lm2DrndG3wBotG/n0a4f30XtuezWTsNQqsogLhSvetHyYzDRmEMNZ6rJc9ygWJisvR+f+heL2NEUXdWa7H8x5RoEszRydFdjx34cSEK9vOccJYdrh+84wLQVhHnphb3Yfw6GbA5yc6cPtcqx9Z7IAveOkksYoKYqhgIsYz9c2OgaRiiL2H1Xyjq87o/IZ6wqVRl6EXge+5VMEXKosTwRMrieHwRACZhq5ALBp8elVrBEcPj3YPXovUXtO4lkGHLgRsKh7Scu2OdLabibroowV9lZY3HaStFrs7OHHbpY5fhzQ6fBjKFQrJHLZ8OrsjDAkCfeGdSB3SD8z3s9MtIErs2nhQiWKo8zAK+Ewt+0zME6OndU/qLc2H/obbRQajlc6+//WL4BTBW5EMXegtT58JPnwYq6Irgl/P1vA/WfuXv4pMrW2kXN+FPy9cI/VguWnpdSYP1bV1oDEW2VoRjtdl4VGtDWW5wIVvVoBgzCRhqmKA6XSLv7/NQqsgLAiIQd2NhbEfUH9hsY62lEZco1lzrkH+xHJQ6DP0KRgg0JaE3fPSYQM68Pg8libZ7PNHTjxCnSc6TnMoNH8bthEJg6qbebcqb3QwbQBiyXHwKGPfTXvfQF+V6p408X6AmiS9mOrjEXLZ50DNo7EFfp7457YabZ3se7IJlweGnk8S40wNLmp5rJZIZ2UQVQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(23010399003)(38070700021)(56012099006)(921020)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?6ZkfUmMrqxPaUmgi4a5hN5GfNz1SCvLLJdStDhjavMuhvJYCeIn/KQdaCf?=
 =?iso-8859-1?Q?1KgAKP9frJ6OCxxIMzMAEyP3oLrywhiA+qWpnbFy/BUTDkG90HTkKFviCw?=
 =?iso-8859-1?Q?w8bgDGTYkH2PxAVVzUjJEAxdsM0Hmti8u1ZVWKmRGyH2IXN+9GTMl/yv0w?=
 =?iso-8859-1?Q?7LjE9IF9QImhLeH5vQFgO5K4RSM42ykpTxHmtxxNL+9BBGXKErkJMUdoYq?=
 =?iso-8859-1?Q?BVe3SGyxJYbgNEn+7d/Ze0u357Vf+sAO6rcRbcoJ4vFWQb6uiQeWg1eQFV?=
 =?iso-8859-1?Q?hubSg+LqQ3y2yLHo6mFbGJxkIx9vgX2uWyepVzV8cTS1rvRIMXnTK95imh?=
 =?iso-8859-1?Q?Cf3Zc+NoDIlN+HEeqRkZYPqNDaXD+CEtPzODdOoc3uD7Pt7KznEZp3Q67Y?=
 =?iso-8859-1?Q?13Hu1mUtmSqtJgnLAfLi/2mk9UiamBdQN4HiEZOgC3aXX9WsEjQY/KgoY9?=
 =?iso-8859-1?Q?+wwZOXlwTea3Kat32GdIhfBhQjpwuVHsMNT3ndzekoX29qK/X6xte7VO+X?=
 =?iso-8859-1?Q?qG/qRE8SjQxP4WnVNc4SHLY2W2vwKbDQoJyCLKexGArBLRiEN/PYD27xkP?=
 =?iso-8859-1?Q?bNcuXTwtj/NUHavZJZLviV6YTJpabpGX7xVevnZOR00ZzRl28uIK/lKbps?=
 =?iso-8859-1?Q?EQv5r8K+OA7+BheanxUkQE3dDgfAvPQoIAeK0Te/Dxu7Vp62QFEZ/XkzrL?=
 =?iso-8859-1?Q?5GumJMS4aiTre7nv84mvOgc7JIcpf+qviWPXX8yH1XqtHci1W/6QS950nK?=
 =?iso-8859-1?Q?/SMQAWixNrBCOrHL3l5EHpkJFW7XTK3IxPyCqJLihIoVAc4mtHTFbnr7Cr?=
 =?iso-8859-1?Q?yOx3OGtlzGnH8R1KFs3tAWZIph852+M+eTs1+EBHBc7bkUs1+k0kmTASCy?=
 =?iso-8859-1?Q?r8oknNwo1x+WyItSPa3EvLCt1CF4fncREgZDwl2mXtfXRN5RCMyLzWeF3t?=
 =?iso-8859-1?Q?jqonUNLvqB3OvbdPLzF7xrmgYnA1uB7v2lLTI2WvPZ3Fz5Nq0MhxW8W8x6?=
 =?iso-8859-1?Q?hw2Zf7XNLhMVm5YRb1ysoOKrPZSilxyU7t1GZ6ZsIO/7rPGZ9ktbdbI+5a?=
 =?iso-8859-1?Q?Acty2s2tBEB/2gkdfi+7pY0DqTvIGMaBGH/Iic86HSPdqPI1Nfzk2cFlQT?=
 =?iso-8859-1?Q?BOC1t4arkjQ0OlQlv7scTNObv3500cGeNH3d55tnP5d9pukUxbHus+nZq7?=
 =?iso-8859-1?Q?pd1403dhWFWYtVANoI3ar6wrFWJKcDSvRWYkNCiaWdt4Eu997XIJmn9if5?=
 =?iso-8859-1?Q?PpXJbW8jLyw1XG06gd7qGOSTbPB9B2C1rP0ZTyv7CxtelEAURolv1lw3Vx?=
 =?iso-8859-1?Q?8esCvwroqdyhI26TeXGerW4m5Yihfj6nmptZcKi0r+6UvPJeiCBBmXom+k?=
 =?iso-8859-1?Q?eUgqsjipC/vx7ssDZIB5t/7m6FrxuRvedgorgHQI644tmITzgEuS+mnlKx?=
 =?iso-8859-1?Q?yMx61q1NAiO+n+VbJ7APF0iTNIx8pyeYE/wHyTVP3qfM7Owy8lM7DGju7N?=
 =?iso-8859-1?Q?qPVNNqxEggjJq1pABBlcgVT5MXU/XgWb2oh1roks7gIZFicNfJZMSYIdGq?=
 =?iso-8859-1?Q?MsG5AfNGsr55QVhEsmyLu3fPh81YdQ3EkdVKm8MPizVr1Woh+JfaWTtCGY?=
 =?iso-8859-1?Q?xA+eTEWtxNffFDJZmk6OVjTOC3XrdUr7DaP91Sz3jivjoZEIDNGEyOt6oq?=
 =?iso-8859-1?Q?/zm930vgMJYKsjO7l6P6bx+otYQcJZemz2ZHRYLZG8x7+MNJeawTuA8pmn?=
 =?iso-8859-1?Q?w0ZaiXWWqnrbtBknbTGVdh7NGUHGzNBhuO4pl09p9YZrVdsoLjicBCW7LP?=
 =?iso-8859-1?Q?f6wa6pBc9w=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: n3F8F4QiI7ErvFiKVINHDeOdAjadaKZ0EiASTxbsCIoECwY+uP2SMeRiKP0q9mOjNRgxixWAhDLoBdpDYjJmdrDhIVCPnf0NXhhTd0ckN+VMlfuNmvwtDFvBX4JJxSvTJ1zGNLQyWkEY94siinWH/LG2u8Srg3PSUvaP6utgA9pQZgwPDmVOnVWtVhxELyweL4tk8PIuQtXgIpSIeo6nzQD5z1f0c8XwpbIZ4/5TNx5U6G/NlhCxN8m+nUr2/HCaH00IEzdU4yH0HBe6U1iGbVRDFvuYw7oA0PsZLfg9WgeSpSl1z40memvlIOFY6+gX1YoXR+L8uE+UnQUgb3c8Fg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ac7400b-821c-4e7e-ab43-08df2a811968
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2026 05:56:46.7933 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L+4fv6Zg79wN+TBl6kH6QELJjqvEgTWsnInXN2hYXTMc4fPcEePcDp+3/cdoVjz+DU14bD9/BapuI+1aj2TOTF+z1cIfuGGouu9XCAYW3Lc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6954
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

The W25Q32DW and W25Q33PW use the same JEDEC ID (0xef6016), but=0A=
have different part names. Since the JEDEC ID is used to uniquely=0A=
identify a flash model in QEMU, both parts cannot be added as separate=0A=
entries with the same ID.=0A=
=0A=
According to Winbond, the W25Q32DW has been end-of-life for many years=0A=
and the W25Q33PW is its next-generation replacement. The W25Q33PW is=0A=
compatible with the W25Q32DW and uses the same JEDEC ID.=0A=
=0A=
Rename the existing w25q32dw model to w25q33pw to reflect the currently=0A=
supported part.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/block/m25p80.c | 2 +-=0A=
 1 file changed, 1 insertion(+), 1 deletion(-)=0A=
=0A=
diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c=0A=
index 545e0b5728..e88efd913b 100644=0A=
--- a/hw/block/m25p80.c=0A=
+++ b/hw/block/m25p80.c=0A=
@@ -353,7 +353,7 @@ static const FlashPartInfo known_devices[] =3D {=0A=
     { INFO("w25x16",      0xef3015,      0,  64 << 10,  32, ER_4K) },=0A=
     { INFO("w25x32",      0xef3016,      0,  64 << 10,  64, ER_4K) },=0A=
     { INFO("w25q32",      0xef4016,      0,  64 << 10,  64, ER_4K) },=0A=
-    { INFO("w25q32dw",    0xef6016,      0,  64 << 10,  64, ER_4K) },=0A=
+    { INFO("w25q33pw",    0xef6016,      0,  64 << 10,  64, ER_4K) },=0A=
     { INFO("w25x64",      0xef3017,      0,  64 << 10, 128, ER_4K) },=0A=
     { INFO("w25q64",      0xef4017,      0,  64 << 10, 128, ER_4K) },=0A=
     { INFO("w25q80",      0xef5014,      0,  64 << 10,  16, ER_4K) },=0A=
-- =0A=
2.53.0=0A=

