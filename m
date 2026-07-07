Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C20CC43602
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 06:09:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgyzx-00030y-Rp; Tue, 07 Jul 2026 02:09:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wgyzv-0002wp-AN; Tue, 07 Jul 2026 02:09:35 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wgyzs-00083P-EM; Tue, 07 Jul 2026 02:09:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Znnsk7l9VGBGf93fvnxCOMSUqtgJH5kdCbzid9WWso/K3onlHeNn7xLqcTy16oJeasVjRj4Th2HARJi6DeVFLCA8iwXwrqmhJ8BIgXeXNQqvzmfL/ipOMjrfiFiOaIjmlmrm2ekpdhCPl/G36zszObctRdW8NMNnPC1QQCDyGW9vL+c1OeZ5gdGD2W7S/vZINre5R1PQNGHxoLhXHACRfVPmxNJuPAcH7L9SPXlhiWCt6UP480i9buoPhxGgOlefOV96yvv1SXRSm6iPvDjQzdpSo5fKPYIGnHHEX0BVAy3KtQEo+TvL4JeqcuCk8CxjlFcesZADMqM2MnxWR3qdRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yGtIBZAIuiQf6vyleesK3LmjTHoKyKL8sunqyIKs5vQ=;
 b=F0HkYUXfAhEeYoXDIJITadMgJbfG77swA5a250jN/szWLs2T/Rs9dVjgFtOZEmWgHTGjJB260vH3E1869aRC3xghAU1GaIKjOj45rfPrsEjHNVE1bSKSq6CSfr4INnFRtYyjZd8qnIcVJAk5e93tOdukUnqRtLfVpBBmceeIcH35S9VKmkn7mKVq1BovmMoy64QKp5Ssk/q+x302GIErDH7RWSkAsuVcMcQv9xUZ8f3a7i9YhZ4zvXfMKfb1aFX+gG0DINYwwjr+LPsfN67/U7k0Y+crToV0U/2O6+BoR/T6PXi1aNKttRqr3dvWYitPX0q3+YkFKM7kyfkx9R4Shg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yGtIBZAIuiQf6vyleesK3LmjTHoKyKL8sunqyIKs5vQ=;
 b=Pa53kd/s4OTjCiNwBF6sRgKlvQcy3CQcrjBVVMlpvxXNlpdrqCr6wyZttnzLnJAIYrzvOgJIMe0tm3aFCyjzrei/ogFOW7SQpceb75wglCRFCED+3zRalSd0lqDdSsRA4ljcuyFRDGS5DKa/bGv+sH8mtUXGglkZqdjYBuwNvAGjJFO7m+ZLuAuj+b8SsgW7Ffwv4AGlPrbNO3qeq9sQ9yP6hPNK58A1v5RXXpR6xGv9vTBDD0q2xEfUoO/hWHrq/Ip/ncyQyS2Ax2nmmjPgiIdczezGTpFFqy6gr7Z2GrPtLcmrwd7rrpWdm8PWUwXXl7V33J3F4jadUJgpvJJinw==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by SI3PR06MB8706.apcprd06.prod.outlook.com (2603:1096:4:2a3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Tue, 7 Jul 2026
 06:09:21 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0181.010; Tue, 7 Jul 2026
 06:09:21 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Alistair
 Francis <alistair@alistair23.me>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v2 0/8] Refactor AST2700 SCU preparation for coprocessors
Thread-Topic: [PATCH v2 0/8] Refactor AST2700 SCU preparation for coprocessors
Thread-Index: AQHdDdcml+cou2jcSUWFO44hUF9C3w==
Date: Tue, 7 Jul 2026 06:09:20 +0000
Message-ID: <20260707060919.350637-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|SI3PR06MB8706:EE_
x-ms-office365-filtering-correlation-id: 148d0d56-a82a-437c-2f10-08dedbee4921
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|6133799003|18002099003|56012099006|38070700021|921020;
x-microsoft-antispam-message-info: MR+wXBi7Dtq4Uw5D831S/WrYIw5t4qwoPaWd3k0KTDBOML+xTcsy7ZpHT8POAhLEV/2kdTiB/T/oI712vrVpLiyqB9ZSbl+xQjlSgdDZe/EJ/DIIT9sT5KPz8Hs2iz2DEf01peBOQo1cIQ10w3O8K/5734MDlLGeoUlguQTb24SPz1pw15A5GxRPmtIGK7K/+7jwvX95Y5ldM4xDiMkbbpU5g8yRLajPFLxX1YAypZ7/IXk1GEVkRvrBBwhzmbofsqPl3RZ/ubZeZD3uOoF/FhjLdeH4XYDTcdSUMVOndyyzurv97LectCGxJrvPCyaTN7eE/9LXIUiOcZBGrkz14zbt7bMdEHfC5nq8kd2sPeWLykdGlI/PWzUh7KI1vV4MKMk/Tsw9cOzDXSnzM9/fG6B6YoQMoMjIw2cS5AaPKX0p3SyqNip03OjJdubtDLMEv6PdXBFN3ZSy7dAip1ORYw6Op+tFvl28G66d4Kd/MCrROcsDGPzaEZRVn3+by1piICQG3JH48LNkjv6GLUT0ofii2/GK/e9k57m4xSE8wKXklyTlULpnDKuTrcE1OEOizL+jkCN03VXr6rHTPlflPp17wdIRUb6tjbLAAhawqsfLnGIJwWVIEz8+lc3JfLSoYGjdy+aQl9PpOJMC7sQn/W/YO+dt2/gGBOfkSm1r23sl7CEGcg9M+cMegKFRCG8EN8pbYOVcZHqzGaDhagnW64GUru9jL0wJeXuhYlhIM7Y/+wRPoA/l6o5kTWS8cs3z
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(6133799003)(18002099003)(56012099006)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?AWm365tLLzngoqhlQY28KdJn0NFISsz2Phq17kmf+mLJCr8zo1dZvalsR+?=
 =?iso-8859-1?Q?YwrRQnVcqd6INUIqYFZ03AfARaNaB+XJ41WlExvj52HSL+laZEw8NAN8MF?=
 =?iso-8859-1?Q?SiS8fdAkygm4kD9AnIv4P2EFlCDeVllX65iMKasUuOEg34+Qx22eyFAYGs?=
 =?iso-8859-1?Q?bWiYP/OLmQVPLLjEyEOKEZWsReK87ZREnM2clAZYRg720/Ov9sVGIKTz3h?=
 =?iso-8859-1?Q?BVoA7lHOb6/PEvCkzMlwRnt1r/dXNBb5FM9rD2qoIzlZvHFAJVpmWpA4we?=
 =?iso-8859-1?Q?Of0jTMUmgWDWJma/O9RHuV9jlaFsWsFr7zHW6jnxfd+7h/39gTbKXEHqVG?=
 =?iso-8859-1?Q?V4whOw2lLLC4uT2xpbdjL5Fxmu1s5Pk0JQuGjtqnbCHmQEZwun7xbvOI1k?=
 =?iso-8859-1?Q?4MYnDhCJyeGIVkPLZsTHGkyHl0nAKQnOw9vKP9VV7f7KGvdq/GRS/+KVGS?=
 =?iso-8859-1?Q?QZlLAScXrr3/ld9iM2OIBbghXqSN7JAB3++bl61DOlEmEvj77cICZM8lXW?=
 =?iso-8859-1?Q?r1bgf+t87D5iFPGjxx24dgVp1QTdSsbynuLMNet7B17BVMhE2y0nFeCJ28?=
 =?iso-8859-1?Q?f/X3+DC+IuoqnEjLqPUMTUTzTPGpnlg7W0QxOehpeFU7vQK3Wi17XlEwV7?=
 =?iso-8859-1?Q?DViH8/r6X4flki4rql11dv4l0pi4ex+TUI9LYw6ASJk7LGExVungvtC8/r?=
 =?iso-8859-1?Q?ZbHbLwVabKXZNo9odmrOWYoiotESjWc6KkfPwKGeVE0yBDzguqEqwqRWXn?=
 =?iso-8859-1?Q?bF9OVwbVa+YvEi80oWJ9f4Xux1ojLD+H5Q0hJ1SrN8CpCOUuMdv2+ceIQH?=
 =?iso-8859-1?Q?NJ7SamNM7prDP41kRh0qsSPrKEQ4qbLkoW0qYiXr/gbmqDtV+5Z80k0iMC?=
 =?iso-8859-1?Q?710wuScJ4XkDmBXcE/qu0iQx1kdvhzokUkhj5Vk33tnbxBgz5n3amo6OG4?=
 =?iso-8859-1?Q?3pLGu+IOXy7gRV03sex1oaYQQzzsHCh+K7pnFGkZfGxULCAb8xi8mnk2Oz?=
 =?iso-8859-1?Q?BE2jE763ZD4dWQPqBfD6wMgBd1tisD+l9o2P+6DJ47hgkJ/hXE27qrqzPg?=
 =?iso-8859-1?Q?p7vrUDq9VqAA2WF2HexEcx6XcDEjtNhp8wFjPO6egmwoBu3WKIQ2yXDJtZ?=
 =?iso-8859-1?Q?i6oSDYLlNoWRsFi0itACwWOiB+gmap3i1sbWC83VO7zpLG6uvP9jGKyorv?=
 =?iso-8859-1?Q?W7KcfYC3qbNQGKz3ApRfs4NoX63HJtZI3uSoPlYaZBssaWQJYlw5/swi7F?=
 =?iso-8859-1?Q?WGIywb1wvhDNi2UAC6hVk9wrvc6icGfDxwc54uIaGNB7B3CjWzzTpVecvR?=
 =?iso-8859-1?Q?nVT3w3MyOx3eCrx1lpFUEIOAdgULwE+/zZrJd4qV5ut+bXardRSYa5477F?=
 =?iso-8859-1?Q?/UX4PVUf3P0RWpTkGzoCrgxFKMlhxhrQu6CLkovkSOw00FTeqZ6cCisI5d?=
 =?iso-8859-1?Q?dmc1uXVgkcWsCq1dI5UAHPp7gxawHrbtTCoad/zdsx4vd09Blomk4BYnUm?=
 =?iso-8859-1?Q?6Og5cUZ4PY/CdsQrOkyF/mPoiGyU3OtWxh8osnHnZUfC9KMSUdgAMdZTtA?=
 =?iso-8859-1?Q?8AUVaAc5HUJPnOlAXNn6rKpOtQwqYZ2MoL0OtJ3gmccpFBqgi6aiMx4F84?=
 =?iso-8859-1?Q?yy2ySawf7GD0GXOOsfMIBiiSjdaXWnAc9jYZ0fI1S0PVRr1DpZhXB4+89x?=
 =?iso-8859-1?Q?IQBbjBdFe0i1zUyzhHjsZBLDb/slqsVNzJLjHwpvSpbNtNdDdvuw5ufpLj?=
 =?iso-8859-1?Q?LccVyMdTe5aJfO1N9HEsdjXaxuZcMAsG2oq24+/Lv/fXVpo+8zJx/PP064?=
 =?iso-8859-1?Q?whoc9DSOaw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ZhbigYY6rI8pBjNM5RlvZ+WxSoryMasR2mgC8xvtAUXQw5ZHmHAZmGg8Bj6tQISOrw7ERO3aeRKUJwGRX8kfPj9C9KlK00EKMHuxYGixIkQ82a8KgbSRvJXs5Pos66K09SNm+KodlLChUjNI+uDNavdJEfrfbI1b3pBgY8tHhIj1gRR2Mm13jm2zF3gYvbidR3k6C69QBW7p+g79pNJgh95DJdnBFT37n6RC31M6syqRmSX1KguC07nG2KEr8qDvM28D5D4WXAS5Zt8i8qyNFxgieHpKZjYekPsK2KvBnuD98uCE8t9Tn2BPD9jbcVL/m/JOwyeGaRCsfA2VrJwYQg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 148d0d56-a82a-437c-2f10-08dedbee4921
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2026 06:09:20.8334 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 62ja1ZuS+3y+zbc5iProwIFoBK07bnCek6Wc24lPFFRMzSHTIgzN5Y7421SbwGk6SiQ35Y4yuJlIe1A/6yNC+7BCKyih3gLoTjqpM+NftDc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI3PR06MB8706
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

The original AST2700 FC support series [1] is fairly large, making it=0A=
difficult to review all changes together.=0A=
=0A=
To help speed up the review process, this series extracts the SCU/FMC-relat=
ed=0A=
refactoring into a standalone prerequisite series.=0A=
=0A=
v1:=0A=
Compared with the original series, the SCU preparation patch has been=0A=
split into three smaller patches:=0A=
=0A=
Introduce Aspeed2700SCUState.=0A=
Convert AST1700/AST27x0 users to the new SCU subclass.=0A=
Move the SCU link property into the AST27x0-specific coprocessor=0A=
implementation.=0A=
=0A=
In addition, the SCUIO reset handling has been separated into an=0A=
independent patch.=0A=
=0A=
This series contains no functional changes. It is purely a refactoring=0A=
to isolate AST2700-specific SCU support from the generic implementation=0A=
and prepare for the subsequent AST2700 FC support.=0A=
=0A=
v2:=0A=
 1. Pass realized PSP SoC to SSP/TSP initialization=0A=
 2. Share single SCUIO instance across PSP, SSP, and TSP=0A=
 3. Share FMC controller with SSP and TSP=0A=
 4. Add Data FIFO-based flash access support for=0A=
=0A=
This series depends on:=0A=
=0A=
https://patchwork.ozlabs.org/project/qemu-devel/cover/20260706052701.114174=
0-1-jamin_lin@aspeedtech.com/=0A=
=0A=
Supersedes the following patches from the original FC support series [1]:=
=0A=
=0A=
Patch 1:=0A=
https://patchwork.kernel.org/project/qemu-devel/patch/20260417032837.266412=
2-2-jamin_lin@aspeedtech.com/=0A=
=0A=
Patch 2:=0A=
https://patchwork.kernel.org/project/qemu-devel/patch/20260417032837.266412=
2-3-jamin_lin@aspeedtech.com/=0A=
=0A=
Patch 4:=0A=
https://patchwork.kernel.org/project/qemu-devel/patch/20260417032837.266412=
2-12-jamin_lin@aspeedtech.com/=0A=
=0A=
Patch 15:=0A=
https://patchwork.kernel.org/project/qemu-devel/patch/20260417032837.266412=
2-16-jamin_lin@aspeedtech.com/=0A=
=0A=
Patch 18:=0A=
https://patchwork.kernel.org/project/qemu-devel/patch/20260417032837.266412=
2-19-jamin_lin@aspeedtech.com/=0A=
=0A=
Patch =0A=
[1] Original AST2700 FC support series:=0A=
https://patchwork.kernel.org/project/qemu-devel/cover/20260417032837.266412=
2-1-jamin_lin@aspeedtech.com/=0A=
=0A=
Jamin Lin (8):=0A=
  hw/misc/aspeed_scu: Introduce Aspeed2700SCUState=0A=
  hw/arm/aspeed: Use Aspeed2700SCUState for AST2700 users=0A=
  hw/arm/aspeed_ast27x0: Move SCU link into AST27x0 coprocessors=0A=
  hw/misc/aspeed_scu: Add separate reset handler for AST2700 SCUIO=0A=
  hw/arm/aspeed_ast27x0: Pass realized PSP SoC to SSP/TSP initialization=0A=
  hw/arm/ast27x0: Share single SCUIO instance across PSP, SSP, and TSP=0A=
  hw/arm/ast27x0: Share FMC controller with SSP and TSP=0A=
  hw/ssi/aspeed_smc: Add Data FIFO-based flash access support for=0A=
    AST2700=0A=
=0A=
 include/hw/arm/aspeed_ast1700.h     |   2 +-=0A=
 include/hw/arm/aspeed_coprocessor.h |  11 ++-=0A=
 include/hw/arm/aspeed_soc.h         |   1 +=0A=
 include/hw/misc/aspeed_scu.h        |   5 ++=0A=
 include/hw/ssi/aspeed_smc.h         |   3 +-=0A=
 hw/arm/aspeed_ast27x0-fc.c          |  38 +++++++---=0A=
 hw/arm/aspeed_ast27x0-ssp.c         |  56 +++++++++++---=0A=
 hw/arm/aspeed_ast27x0-tsp.c         |  56 +++++++++++---=0A=
 hw/arm/aspeed_ast27x0.c             |  16 ++--=0A=
 hw/arm/aspeed_coprocessor_common.c  |   2 -=0A=
 hw/misc/aspeed_scu.c                |  20 ++++-=0A=
 hw/ssi/aspeed_smc.c                 | 113 ++++++++++++++++++++++++++--=0A=
 12 files changed, 267 insertions(+), 56 deletions(-)=0A=
=0A=
-- =0A=
2.43.0=0A=

