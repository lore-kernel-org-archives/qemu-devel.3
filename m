Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451B4606A321
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 05:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=PukO59JK
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVjUu-0003tF-EB; Tue, 24 Nov 2026 00:55:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xVjUp-0003rS-6U; Tue, 24 Nov 2026 00:55:15 -0500
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xVjUg-00011I-VF; Tue, 24 Nov 2026 00:55:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=usgqF7UoIHl3u5RpyM6VNFd4KBznpQePOsFbKhhlvAopu2Sd1Hjt2aUbDFWK9/hYni6zt4373eBTslAA2FRXPlanqq6wRZ9pgfUANYzzu+6xghjsfwn94ng9Z/GmDmhFo/tbSWKZQ7PiYdGXPcdyhw3HqVNmFVfOazVCdWr0Z2kDXKtAcixjtXxF3dzqtbX3P6T72Ya0h1qGml7yWLkpIR2THWbRaPuIbnAmxB+bBJnEDoFHYx8TVDKIk5u4gflLThXnaxh4q1aqfLXqW90lH/eDAAk5E9+M4mbMy7qseD7nzfT5k3WthVWDSAsc80FGxVcT/2VO3F3cKHB4tkALig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DGr+yNmGu6fKlE8RFJU/i4Dmw03UafxPS0WpmW1H/ZI=;
 b=I0k8S6idHbRY+oXmPytouOUTvllwcy6O3h2gisrLWe+D0Qlpp7D8/4kgKZI2CdmNuuZDvy6SIkjjGogcCrd03Tejp9dKPqPPFUpI9AXEiI3cTUtizIsK8TZ0f8NQnkqg2HrG8amt74M+4mPvdA5HYYYZJEjKwi2dhzbj+8OEUqErQmpff08xtjGiYo6qFANiov14bwnsUdgbZZADCxw9QTdg8JwnZgU7PsIa8nJVFCxPET2nA8dbUxLNRqVK+F3bvOxE+/9cmsNTbT80Xs12a0vh1+yITMvZgAFzEfxh2evQWOzxRF/K7UNVB2nHtTeBpxQnkLta5noE3QYJNGWYnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DGr+yNmGu6fKlE8RFJU/i4Dmw03UafxPS0WpmW1H/ZI=;
 b=PukO59JK4hqoirILyzGTJ5WaEbeApDCuCpznqMNbM1oO5n9jFgH5PobSga9kxcOOyFeDzqufBQr6/l7yrr5DYYr/w5AtI0wQY6aHJvL7AWSp8TSa10/WHToCocUIzmbY6iUNcQZDdbBKx/7Jjw6tHEjRlBeAZXZxgxFypLTtb18j6geb5cZ/smj/w2COygRLC4FaePePXyku9WdgodJcOiiXwQuwJ0Ap3hhDsz0V9D1B59WaHgzp2qElM34hy1aCHXnkt+eF1ZQ5y4YC6Omk5qx51M0YgYd8Gm4A09OzBwkOGwu7WT4A30SkqapO9kYPRtR783UV1anM32mfqC3k7w==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by SE3PR06MB8456.apcprd06.prod.outlook.com with HTTP via P2P;
 Tue, 24 Nov 2026 05:52:00 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0662.001; Tue, 24 Nov 2026
 05:52:00 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Kane Chen <kane_chen@aspeedtech.com>, Pierrick
 Bouvier <pierrick.bouvier@oss.qualcomm.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v7 08/11] hw/misc/aspeed_scu: Add SCU support for SSP SDRAM
 remap
Thread-Topic: [PATCH v7 08/11] hw/misc/aspeed_scu: Add SCU support for SSP
 SDRAM remap
Thread-Index: AQHde9fsGH1Jxf+EuUu2U7M8uL1TBg==
Date: Tue, 24 Nov 2026 05:52:00 +0000
Message-ID: <20261124055150.1328856-9-jamin_lin@aspeedtech.com>
References: <20261124055150.1328856-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261124055150.1328856-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|SE3PR06MB8456:EE_
x-ms-publictraffictype: Email
client-request-id: 4943aa62-f446-4a18-884c-9e62c70bcbf4
request-id: e2d17d47-ce56-4d2e-0bcb-08df49ef0e9f
x-ms-office365-filtering-correlation-id: e2d17d47-ce56-4d2e-0bcb-08df49ef0e9f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|18002099003|22082099003|6133799003|56012099006|261102123227099003|261009223027099003|261009221227099003|261021121427099003|261022075727099003|261021135927099003|261009221727099003|261009220027099003|261026121527099003|38070700021|261009223327099003|10067099003;
x-microsoft-antispam-message-info: EP0cEFH+awkbl+HpjyDsNMyGBRN3Q+481RGWu36+S7aBpJN6xjUyhIbglGAydHIDsjb/BtTfVV5KhXRpfPiXKb9Pj2w3gJ54x4iKyvCeDVzL20k4EDdjd+NPOK5GCvHb4ZCrjTFa49FhKU+nH153qt1xnUN7oaZpRGedAMr//teVgb9jxN6s04Me03egLGmj10YC4g3P/p5melUs7LkIAaUkiz3Mge+51hviPr6wO0kf/zb5KUfo+FKLO2RIjGennTzDhAZ7NmVHdZnfV4GE8wUDFdlguoFq0auRDiTjlDjjMq3kGHnCoEgWNkKzU265z7qzjxGRO83kxNg1wPAOunxIB2zXA2QdmpifqClM4lw5c/qQIWZRKQyzc1uXuaAwxCBmkmXMyt8XD13h1xbiYL9JnZrAEyfwYnwEChb7beLB2b75vIUZNWe5WS/WPihrcDara7qEgThDAGh272RLG5yugiQ2jEriV+0m2fF9/io1R06laaDh1pBbZQWDjznv23LKzvADlZyJz5/+wZV05Npny5ES2sHrOvzt/fzkKMZRVKpdMJDboZaVL5CILfSGad+5rZVyhka+jP0tob8eNOuiiFrDmAnvln5O+TuPDKHkpSqdma66YNOjSWpfRpcOfb5zoJE5vNTxYDoGKsDyF4GIH8O4SGiDVLVZ8xkyjIEXFNPwRxpYP9G1OxwgRzGZrzceO8z2cVYpV8vf9GGkCFQLTxcFJ/Dls17LjoPo9PQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(18002099003)(22082099003)(6133799003)(56012099006)(261102123227099003)(261009223027099003)(261009221227099003)(261021121427099003)(261022075727099003)(261021135927099003)(261009221727099003)(261009220027099003)(261026121527099003)(38070700021)(261009223327099003)(10067099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?3EmTK/mPsunxBGQfZa46WNKcV1iIiubGl80R0PL9I9erSfYI6YL5qsUaU4?=
 =?iso-8859-1?Q?3FmPVbfH8UgFPZy5UPg4mtv3+QuQL+AN+nnfStjfZs5QSHRYwt69loJGnX?=
 =?iso-8859-1?Q?bLwtpTCPLgwPqeO1Wf5dEe1MTBiOgVpRutKJIITPBYqa9X1L5FNJzMHd6B?=
 =?iso-8859-1?Q?DzsPZp+FZI8lzGMYMadkOa0hJxSdBHA4TB+Ok7GSKu5mAM56thIh2xbQmC?=
 =?iso-8859-1?Q?GOqYW6DTWF/uxDSnB5ZD+Fj2FWdBxxMfL0YHCdwmP8ut7nB4Fd25s8tL1T?=
 =?iso-8859-1?Q?iEuopgvCbl6GJtcs/MN0qj1pAmiHs4kIh4Wkq6vWSy1HaGUC7zPg9v+59y?=
 =?iso-8859-1?Q?TTISdVduMyyZ4PDLptANKCV4JGLb98/Mkpbq3EIC/cM8k1t3gkBNSHYssS?=
 =?iso-8859-1?Q?MxQpKi46lfKFb4kCTdh+jFt9VEeOJ9Tds2zm/HdVv15YMfzXk1r+ARopGS?=
 =?iso-8859-1?Q?ZqqXX5Sn/wUaol9eRfB1jMhQOqFJqWXNIv/ViizG9voqLlPbqDf4opBVLB?=
 =?iso-8859-1?Q?xHRzb3LgbnrfhYnPXnWCWt0NPDIyAkZpWFMNZAvPuJylt6ewjY+hSwCpkR?=
 =?iso-8859-1?Q?+LEWZMrmVBJg/H4A3dHawrETqvXZDjY+Doqu/h0LDxf1Rs6Tn3ZKkApyMv?=
 =?iso-8859-1?Q?ggxzMhBdIEnU+HhBQJIOyUMCzyNn9rUj6Cj+1JbLYQIzvo2/UikXfsBW+Y?=
 =?iso-8859-1?Q?Paz6U0ejJPoLj3CwVGOcwh1IC0KENbmkAHRtJ9/OoLr96W/rz0u4+k6m+z?=
 =?iso-8859-1?Q?GIfZX/vNSpfSihe/zlIP/GTrfKZCslCekgVlqRAFwRlw9XF8nsQnHEnLQj?=
 =?iso-8859-1?Q?7PeNE8ysrkezuh08LuOg2SYLgWE8tZmZ+YAxBec6gNLUHOGjTyO1Z0op8/?=
 =?iso-8859-1?Q?Mo6OeGnwJRGFKAaMlSpIRDnmG/e2zfQELy+od4nB00qUUt2sb8dkrVQGTO?=
 =?iso-8859-1?Q?w8xY7AWAx4B/nC1zNhheLjboWodH+tFNqGS5L8xsdUIzE9ofH7xGOF7Ngf?=
 =?iso-8859-1?Q?0LDpivUrNc9plGZH+qxt2CXJscQHutrRzANgyvSpe7RIsP/5w/GqOxip49?=
 =?iso-8859-1?Q?bmCGPsiI7NhvyA3dsGYhsB8v1jbinbIq1/O4xpc86veSbPXgZwlSy0ULZf?=
 =?iso-8859-1?Q?WFI8YjwTX/gz70VaTbp4QiTTgMysUt3PTUrdyTKrev5nvTsgmlNPteU1wW?=
 =?iso-8859-1?Q?uQkIdnbFuiVm/miVoujfEAFgQFUmlWQE+yaXVCXQx2L2kjdsDAUHL8NDZV?=
 =?iso-8859-1?Q?R2ZbMwL4zBYQ6oshc9yhf21bjc7/w3dHEk6o564W5DAfnribdpLK7FD29f?=
 =?iso-8859-1?Q?ec0sP0cVYraZGocoDVL+uqm2Y+5/kOkdX40cY1O84bqB9O6dLvY+x8PiUV?=
 =?iso-8859-1?Q?XhZ5dy91Bjsnd708uEYECFtpLDgAANPXZUnrNWNoRZr2oT5clVCTAXIVV8?=
 =?iso-8859-1?Q?zL+DHkfUWHyLfb6AO05v1CNRYG9Z2Wt9iiRmxcWAq9tOytrv5qoV0lRde3?=
 =?iso-8859-1?Q?yWUPe1+3v9UltMUfNdJQxaBDDi2mWOFZZYg20NRN6dfDA5hRXqnmcAPB43?=
 =?iso-8859-1?Q?ybmo5tJsH6NNRlhDRwvd0MZG4fmf/u/w6tVAY56J/PPOxRuX0i1Jb5rgPu?=
 =?iso-8859-1?Q?Fxxcn/YlAuSve4sr8pf5noXtnTvfV4T1HrxSVFRGTfHekiufPon75okqf/?=
 =?iso-8859-1?Q?YF8W+u0qZQ2H/CYa4qQYb5LnCBjBi2MYvLLx3OtDVoMNoLT1ez8PvndErI?=
 =?iso-8859-1?Q?l1pxKJY7KXJj1/C9Vl6DPiqk1L7DCOTPnlYPYMlJglKAa9TB/iQQAB7TZp?=
 =?iso-8859-1?Q?YmD7ILPPWw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2d17d47-ce56-4d2e-0bcb-08df49ef0e9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2026 05:52:00.0656 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2AgpW/A5Q4A1Mi3BUMdmDeVO2cl9bRILjrymqTFI+SMbcemvSCrfBJjFmKrnFFishDpddlj/aARiWV0HwUOYCEliX4/GpW35QksBu2ar0SY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE3PR06MB8456
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This commit adds SCU register support for SSP SDRAM remap control and runti=
me=0A=
activation. It introduces logic for the PSP to dynamically configure the ma=
pping=0A=
of its own DRAM windows into SSP-visible SDRAM space, enabling shared memor=
y=0A=
communication via memory region aliases.=0A=
=0A=
- coprocessor_sdram_remap[0]: maps PSP DRAM offset 0x400000000 (size: 0x1A7=
7E000) to SSP SDRAM=0A=
    offset 0x5880000=0A=
- coprocessor_sdram_remap[1]: maps PSP DRAM offset 0x42C000000 (size: 0x058=
80000) to SSP SDRAM=0A=
    offset 0x0=0A=
=0A=
The SCU registers AST2700_SCU_SSP_CTRL_1/2 and=0A=
AST2700_SCU_SSP_REMAP_ADDR_{1,2} / REMAP_SIZE_{1,2} allow runtime reconfigu=
ration=0A=
of alias offset, base, and size.=0A=
=0A=
|------------------------------------------|         |---------------------=
-------|=0A=
|               PSP DRAM                   |         |        SSP SDRAM    =
       |=0A=
|------------------------------------------|         |---------------------=
-------|=0A=
| 0x4_0000_0000 (SCU_124 << 4)             |     --> | 0x0000_0000         =
       |=0A=
|   remap1 base                            |---| |   |  - SCU_150: target a=
ddr    |=0A=
|   size: 0x1A77E000 (SCU_14C)             |   | |   |    remap2           =
       |=0A=
|------------------------------------------|   | |   |---------------------=
-------|=0A=
|                                          |   | |   |                     =
       |=0A=
| 0x4_2C00_0000 (SCU_128 << 4)             |-----|   | 0x5880000           =
       |=0A=
|   remap2 base                            |   |     |  - SCU_148: target a=
ddr    |=0A=
|   size: 0x05880000 (SCU_154)             |   |---> |    remap1           =
       |=0A=
|------------------------------------------|         |---------------------=
-------|=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Tested-by: Philippe Mathieu-Daud=E9 <philmd@oss.qualcomm.com>=0A=
---=0A=
 hw/misc/aspeed_scu.c | 64 ++++++++++++++++++++++++++++++++++++++++++++=0A=
 1 file changed, 64 insertions(+)=0A=
=0A=
diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c=0A=
index f8935b3412..a9c5c9bacd 100644=0A=
--- a/hw/misc/aspeed_scu.c=0A=
+++ b/hw/misc/aspeed_scu.c=0A=
@@ -150,6 +150,14 @@=0A=
 =0A=
 /* SSP TSP */=0A=
 #define AST2700_SCU_SSP_CTRL_0          TO_REG(0x120)=0A=
+#define AST2700_SCU_SSP_CTRL_1          TO_REG(0x124)=0A=
+#define AST2700_SCU_SSP_CTRL_2          TO_REG(0x128)=0A=
+#define AST2700_SCU_SSP_REMAP_ADDR_0    TO_REG(0x140)=0A=
+#define AST2700_SCU_SSP_REMAP_SIZE_0    TO_REG(0x144)=0A=
+#define AST2700_SCU_SSP_REMAP_ADDR_1    TO_REG(0x148)=0A=
+#define AST2700_SCU_SSP_REMAP_SIZE_1    TO_REG(0x14C)=0A=
+#define AST2700_SCU_SSP_REMAP_ADDR_2    TO_REG(0x150)=0A=
+#define AST2700_SCU_SSP_REMAP_SIZE_2    TO_REG(0x154)=0A=
 #define AST2700_SCU_TSP_CTRL_0          TO_REG(0x160)=0A=
 #define AST2700_SSP_TSP_ENABLE          BIT(0)=0A=
 #define AST2700_SSP_TSP_RST             BIT(1)=0A=
@@ -925,6 +933,7 @@ static void aspeed_ast2700_scu_write(void *opaque, hwad=
dr offset,=0A=
 {=0A=
     Aspeed2700SCUState *a =3D ASPEED_2700_SCU(opaque);=0A=
     AspeedSCUState *s =3D ASPEED_SCU(opaque);=0A=
+    MemoryRegion *mr =3D NULL;=0A=
     int reg =3D TO_REG(offset);=0A=
     /* Truncate here so bitwise operations below behave as expected */=0A=
     uint32_t data =3D data64;=0A=
@@ -982,6 +991,43 @@ static void aspeed_ast2700_scu_write(void *opaque, hwa=
ddr offset,=0A=
         data &=3D ~AST2700_SSP_TSP_ENABLE;=0A=
         s->regs[reg] =3D (s->regs[reg] & ~0xff) | (data & 0xff);=0A=
         return;=0A=
+    case AST2700_SCU_SSP_CTRL_1:=0A=
+    case AST2700_SCU_SSP_CTRL_2:=0A=
+        mr =3D (reg =3D=3D AST2700_SCU_SSP_CTRL_1) ?=0A=
+             a->ssp_remap[0] : a->ssp_remap[1];=0A=
+        if (a->ssp_cpuid < 0 || mr =3D=3D NULL) {=0A=
+            return;=0A=
+        }=0A=
+        data &=3D 0x7fffffff;=0A=
+        memory_region_transaction_begin();=0A=
+        memory_region_set_alias_offset(mr,=0A=
+                                       ((uint64_t) data << 4) & 0x3fffffff=
f);=0A=
+        memory_region_transaction_commit();=0A=
+        break;=0A=
+    case AST2700_SCU_SSP_REMAP_ADDR_1:=0A=
+    case AST2700_SCU_SSP_REMAP_ADDR_2:=0A=
+        mr =3D (reg =3D=3D AST2700_SCU_SSP_REMAP_ADDR_1) ?=0A=
+             a->ssp_remap[0] : a->ssp_remap[1];=0A=
+        if (a->ssp_cpuid < 0 || mr =3D=3D NULL) {=0A=
+            return;=0A=
+        }=0A=
+        data &=3D 0x3fffffff;=0A=
+        memory_region_transaction_begin();=0A=
+        memory_region_set_address(mr, data);=0A=
+        memory_region_transaction_commit();=0A=
+        break;=0A=
+    case AST2700_SCU_SSP_REMAP_SIZE_1:=0A=
+    case AST2700_SCU_SSP_REMAP_SIZE_2:=0A=
+        mr =3D (reg =3D=3D AST2700_SCU_SSP_REMAP_SIZE_1) ?=0A=
+             a->ssp_remap[0] : a->ssp_remap[1];=0A=
+        if (a->ssp_cpuid < 0 || mr =3D=3D NULL) {=0A=
+            return;=0A=
+        }=0A=
+        data &=3D 0x3fffffff;=0A=
+        memory_region_transaction_begin();=0A=
+        memory_region_set_size(mr, data);=0A=
+        memory_region_transaction_commit();=0A=
+        break;=0A=
     case AST2700_SCU_SYS_RST_CTRL_1:=0A=
         if (a->ssp_cpuid < 0) {=0A=
             return;=0A=
@@ -1052,6 +1098,14 @@ static const uint32_t ast2700_a0_resets[ASPEED_AST27=
00_SCU_NR_REGS] =3D {=0A=
     [AST2700_HW_STRAP1_SEC2]        =3D 0x00000000,=0A=
     [AST2700_HW_STRAP1_SEC3]        =3D 0x1000408F,=0A=
     [AST2700_SCU_SSP_CTRL_0]        =3D 0x000007FE,=0A=
+    [AST2700_SCU_SSP_CTRL_1]        =3D 0x40000000,=0A=
+    [AST2700_SCU_SSP_CTRL_2]        =3D 0x42C00000,=0A=
+    [AST2700_SCU_SSP_REMAP_ADDR_0]  =3D 0x1FFFE000,=0A=
+    [AST2700_SCU_SSP_REMAP_SIZE_0]  =3D 0x00002000,=0A=
+    [AST2700_SCU_SSP_REMAP_ADDR_1]  =3D 0x05880000,=0A=
+    [AST2700_SCU_SSP_REMAP_SIZE_1]  =3D 0x1A77E000,=0A=
+    [AST2700_SCU_SSP_REMAP_ADDR_2]  =3D 0x00000000,=0A=
+    [AST2700_SCU_SSP_REMAP_SIZE_2]  =3D 0x05880000,=0A=
     [AST2700_SCU_TSP_CTRL_0]        =3D 0x000007FE,=0A=
     [AST2700_SCU_SYS_RST_CTRL_1]    =3D 0xFFC37FDC,=0A=
     [AST2700_SCU_SYS_RST_CTRL_2]    =3D 0x00001FFF,=0A=
@@ -1084,6 +1138,16 @@ static void aspeed_ast2700_scu_reset_hold(Object *ob=
j, ResetType type)=0A=
 =0A=
     if (a->ssp_cpuid >=3D 0) {=0A=
         arm_set_cpu_off(a->ssp_cpuid);=0A=
+        if (a->ssp_remap[0] && a->ssp_remap[1]) {=0A=
+            memory_region_transaction_begin();=0A=
+            memory_region_set_address(a->ssp_remap[0], 0x5880000);=0A=
+            memory_region_set_alias_offset(a->ssp_remap[0], 0);=0A=
+            memory_region_set_size(a->ssp_remap[0], 0x1a77e000);=0A=
+            memory_region_set_address(a->ssp_remap[1], 0);=0A=
+            memory_region_set_alias_offset(a->ssp_remap[1], 0x2c000000);=
=0A=
+            memory_region_set_size(a->ssp_remap[1], 0x5880000);=0A=
+            memory_region_transaction_commit();=0A=
+        }=0A=
     }=0A=
 =0A=
     if (a->tsp_cpuid >=3D 0) {=0A=
-- =0A=
2.53.0=0A=

