Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8070BC369C2
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 03:40:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBmgO-0003qi-Mz; Sun, 04 May 2025 23:39:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <KFTING@nuvoton.com>)
 id 1uBmgJ-0003pq-ML; Sun, 04 May 2025 23:39:51 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <KFTING@nuvoton.com>)
 id 1uBmgA-0006KS-Dy; Sun, 04 May 2025 23:39:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TAXgd+fa/lUSiPnUbmqFLUpavgahQ+7aiAeVgRyuSNx8nYFsR6XVhBndExgiDWB7rhdwS6HcOdN+vRwwk5TDyWo7hkWn/TmZauTWjwKH78tM+v//bW0SlWUcA3Kxrf2m3WPKkwQ7NtV7KgUMtiZ9XhDXdWNr3BwpOhPLX02zT+ScOKZqo6WVS9LyNugW/W9IiynsZ/uslS/QpgDaJKkUeLfGt4TO3TfpfUdboZcnxdcCuH5pVG+4RJjTQHvQCqlyurRJ6Y/Nl8mvnY34yWIJZaqjmqe7SgYXXzzMy5Sm7l6mw56RiqLjG7MSc2vUp9RvjaQX9KiKNBZxWFlCCzUTIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BXt/o9IP41YQiaCvv6A8J30JEPUFdtsku3caogB793E=;
 b=rdVCAo+VMSlc7VMyVo14fsSsY2MMQErKA69fy5gZApDUh7dKJEVhea4a7cFiAnliMFSb0XPVCbEjHQuDh2mzIpiOvkJdXuwCFrKEXC/XUY2956UAY9WV1vUHEWt0vk2Gx7kCHaDPticL51GZmtRwSPfPpG4VlNrzW82Ah82I4pnPvwbnzSOaa7tl1C3wAv/dSbsbIJKrlqd3GQhdAlaNY3eWK2G2Eryy0GZLYJQgxZxk+lH+Mm6maUx1J7jB7DVvP0s17u/Zsdcvaf9C8PkvejVjQAgJU7Jd6+n7gTNKoiIa43gb76zwsB3nzLKz9MN17/WrrGKpe//TshwXFzj59A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nuvoton.com; dmarc=pass action=none header.from=nuvoton.com;
 dkim=pass header.d=nuvoton.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuvoton.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BXt/o9IP41YQiaCvv6A8J30JEPUFdtsku3caogB793E=;
 b=EEV0YbsQ0VyPqEX+88HXesmB+/3PjYGe6PZDITYGN0znvHbmS0LLlXV5bNsZL7ST8qaSNsZjzmo9xHZgZ4Vsco5I+CcADtoOVD+hqfdslmRS90MG4jse/2R1J4vSf7S2ADY2J0ESKVD982BzqDB3wwNAZj2CXCZRw+cEqUhifRI=
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
 by SEZPR03MB8383.apcprd03.prod.outlook.com (2603:1096:101:220::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Mon, 5 May
 2025 03:39:30 +0000
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::ac4e:718:3b03:3123]) by TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::ac4e:718:3b03:3123%6]) with mapi id 15.20.8699.026; Mon, 5 May 2025
 03:39:30 +0000
From: "KFTING@nuvoton.com" <KFTING@nuvoton.com>
To: Tim Lee <timlee660101@gmail.com>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "wuhaotsh@google.com" <wuhaotsh@google.com>,
 "CHLI30@nuvoton.com" <CHLI30@nuvoton.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [PATCH] hw/arm/npcm8xx_boards: Correct valid_cpu_types setting of
 NPCM8XX SoC
Thread-Topic: [PATCH] hw/arm/npcm8xx_boards: Correct valid_cpu_types setting
 of NPCM8XX SoC
Thread-Index: AQHbt+VrVNsfb/vq8UKpTP0t832AFbPDbmjg
Date: Mon, 5 May 2025 03:39:30 +0000
Message-ID: <TYZPR03MB6896AAA2696D5422D0E1CFC2DB8E2@TYZPR03MB6896.apcprd03.prod.outlook.com>
References: <20250428022934.3081139-1-timlee660101@gmail.com>
In-Reply-To: <20250428022934.3081139-1-timlee660101@gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nuvoton.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6896:EE_|SEZPR03MB8383:EE_
x-ms-office365-filtering-correlation-id: b9e01cf0-b0c4-4a0a-39a1-08dd8b8671b8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?3np0RKMiGLLVNm5KUjJKuTIQMNFpqL+YRfa9/H32cXemWomSFAJcHgunfBQg?=
 =?us-ascii?Q?bteTvumse7NTyGh9S7nQgRWHsdL0gGFTg+46LlNg4ac6b0Zx53JRw1PM1Lft?=
 =?us-ascii?Q?9B5UOXZ/0JT5UhR8pCNsZ3f/jw6Tvd0whV+Ps62jeu7l2iTM21UXH+zirmiS?=
 =?us-ascii?Q?yd1zuA7M1fJbzolAQbQ21ceoNfe2Bs7mTHJFDm84fjC2zKC+MGyZ2tPgjamj?=
 =?us-ascii?Q?268qmOGCPrSSKUkWoXhSQ6vh/bx6OXlFM91dwhYR0r5meb92FaPsXpTMdVnT?=
 =?us-ascii?Q?PGusmnWE/xv3m/pKeBaQHDXyAQI0PjRf3U16vZWJqD3M/MN/jQk2fLs4Mm++?=
 =?us-ascii?Q?alJVBATbHbYABR5hXQmpHuNBGBwBYkj88dZiUy4sYosy8MV7GnK2kr7/QSvX?=
 =?us-ascii?Q?WAWnzY/M+bHXZ0ApUqAa/qacnDvd9n0iwDpn6aMAN6lA5PHA/h0rRignZOiE?=
 =?us-ascii?Q?3meqkKjbgpgrALyzDPSAIjNN5Byq7qk+FFFkrvK1hRBw2R9rCymcuMcKsFwo?=
 =?us-ascii?Q?knIks5/2LSRdeXPhgLC86SmJckfDfGOiXzcgiSlwYbohvR9wSdZQFIM7eEBM?=
 =?us-ascii?Q?9m763Ew1dClZK/EYH4S4S0hSIL2+gT0QQH3qkk62nJOtXjuOn2egbYIWB/VX?=
 =?us-ascii?Q?bBxL0E6icb1McfSg0mfgcpMB7paRqAXIbqdWkpKVCjtmtfOxSRg8ij+JL6oh?=
 =?us-ascii?Q?ktAVYsjPGV8fgPjfIkXRS6Xhz5ehf1BetmhYh/WWpHIBgTJqtdXvD05PT/v8?=
 =?us-ascii?Q?awwX0arUT5wMX2Ze8ioWFuuwlOf5BI2geHi+4dJ8gBWzhypbp3jNEZ/jCJx+?=
 =?us-ascii?Q?VCzTgPuZOgXnzm64mY4LfglsauaYmrUCVQ3zbx/ep6jVZBMKLIAXkgD0mvPz?=
 =?us-ascii?Q?c4cAKElWs0dBX6YAVXDLyHY9EjNXVxx0VdJveWBtkVBF9d8Ed/JCctVnyZDT?=
 =?us-ascii?Q?E4rRJ7BHw9UTF/v4fblWH0Pljp6sFEyV8nxpSb+fetSywXrvXG3TooRR0UbN?=
 =?us-ascii?Q?g9mLZxuqTonK7gLjPADyyvASZmEvLcWtR8yfkmEOr1pY5tFu/HXvIXivIsu/?=
 =?us-ascii?Q?vN+WszXm5N2oyRrNP4t6U7uU0T+M39c/KwEbpZ8rXS9im5GTSungveyYDKq9?=
 =?us-ascii?Q?i2fRF+3joEAW5imbDszT4SpHFC1cC6hE4pcAg+wABJlcF6rdtAAQ6eILXBLm?=
 =?us-ascii?Q?3QaglMsIp/xv0sYH8g6y0zlSXUfR1+DbW1tVEhMiNULpJ5fnhCbnfGKuzOuP?=
 =?us-ascii?Q?PxhisSHnN5g//mgre1qFazrlvzTrpBvAsZuZG5XbgJkLGhESLh5wACEf9/O5?=
 =?us-ascii?Q?lAORUCKDcbYMa7FWnTdM7rUE+DGTgRXhYlHJlgyzu/cQAh0SY1FYMoF/TaAh?=
 =?us-ascii?Q?kbQwEchqyyztaAwe5Kn53HnxeBj4oMZYtsYIraO88w0pqcBkLosS+vcBaHTS?=
 =?us-ascii?Q?+040wOSFTvxPHeFJ9SqN0PpxSFe5aCX33Umz/FBdlpjOszwXOE0j/A=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR03MB6896.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?S0ix+wN5AbDcNyYfcUjkcarB7CrXwQtLuaa31/AHt1i/K6aj7/Ar+cDBZQnm?=
 =?us-ascii?Q?WHHBsFaqbQaVVkhPUdMAGF/BIhPzlG9nk0oxhLHzdF3U4ZI2K+EdTFviWxOh?=
 =?us-ascii?Q?5fdWCJHvF97r6rh7clIY4MVd5J4YXmdHEZk+ulPdNU3wohdiZ3UiqyxKS6xa?=
 =?us-ascii?Q?MwBjK0hGtX5IAiSbGA1dJze4vSCH00xUyXQZAbyZOfSDLZT0WQZEwlWgtod/?=
 =?us-ascii?Q?c0wEAU9Q0MPRzFZqMIt/dfaanDi8PfkupR25dWEZkjbgfmG3FCfNSD4QC1oA?=
 =?us-ascii?Q?MZrETYjM0ZcV5b4cEgx+5PGqyORGD/FylLBcrG9VN1YB+7dRafwM0afJVYZ1?=
 =?us-ascii?Q?wbUMz2xj61QKoXd+sKRmbsSwbo+5Q2Ut9II/FJBm35gvsj9M9p/PcU9N9ged?=
 =?us-ascii?Q?6b94yaeTbKVh5PiI7oXMF2OOPFOF0MZ199UclJsaSV7fMEmwKzWVStgaGY2v?=
 =?us-ascii?Q?VlThXxE9ze+DNHg0KcAIrBtxsoTRyYaQ9V6ZEzik8TTXE60UGWOPZu43jNQk?=
 =?us-ascii?Q?3TQEJ6irkn6T0WEA9KeNqHuc/o4dZqnHTtOaaqME4D7p0ss7lFTmiRolZu/x?=
 =?us-ascii?Q?2HeoTwkJc8h0wK9hyk9PhlMfBYgCV3ZhgognvHyRMuh4A1sXTgfKzYrpQf4Y?=
 =?us-ascii?Q?L1CZ4EvnUnfr4oNIQFzPG42nMOdmZIvugiW0k+gWFBWwus4S/IM9q+BBXJU0?=
 =?us-ascii?Q?oyx8UdaNcoCIVvK/HFjIKbV6e18juRlvWblKjbcbyJVveBOT1EqwtohsSBk8?=
 =?us-ascii?Q?WtQmDCBxRiUtbgUE2xN3/1zivglie+lm8X7U5DSxWns3Fa754AXyXa7arBcj?=
 =?us-ascii?Q?sqDLfKwMlHGz8+MqCQl/g5H07zKS5IMSrvzWuDaE0T9iaXvt5HrCx6ZeLArJ?=
 =?us-ascii?Q?RbaxHZYaFhWkbTOWcQz6V37zpEAqnVMnBAMcybuB0dlY+hqpYoUEQkuAur7F?=
 =?us-ascii?Q?w8lP/oQLbgnARSl/ZANHf6jXAzhMRTxfu7Fkhd79zcteRxt9OdmQUs+MlMae?=
 =?us-ascii?Q?E+ugcyz6jyf/7JKytEuN0wA5kXuev+a1P4JJ2RxjY874/cmfVJEeaN0fJE04?=
 =?us-ascii?Q?7Hl9B5HUPybnkeamY0J+RGYPwQOZb/LiHAwXN4Kj2chlPk3TBQMrr9enw9Eb?=
 =?us-ascii?Q?K5eA7HzaUQgMffO0rPx//TI/Q6/U5gn3Pep9MiD/WlomvGa2XSij8PmOdgd5?=
 =?us-ascii?Q?25YtKWxvbn70ljKXzT7PV+KSWfo/lfHziP0virtThdgA+h/WpaVS7SmG87+h?=
 =?us-ascii?Q?sS9MQD2C+BaElFUzIdQvLjF89xKo/ryDXrLsAgF10lRaQpNnRfk2SykwGkKo?=
 =?us-ascii?Q?4s3HIoyLxVRADDSJOITBR3/WdJkoKRdOr1MgvlcIqXXaxEzbQJIcXu1Icdgu?=
 =?us-ascii?Q?ZQFfUEAI9C9Oh4LrhyEn0CK7aNWJUE2XhzKwq0d9oGiKjGZENjzNla+EQjSD?=
 =?us-ascii?Q?s7npyJ2JDJla6l6jcXbtxA0IyRuuxYnAedhno42NEu/acqM/Wko8K7Pf8+Wn?=
 =?us-ascii?Q?+dE45D56asEaRaWTPfLkeMTPjx5tKnZuNElWPg4heyuFO7gW6GfU7sNUNnHm?=
 =?us-ascii?Q?fibxz2I9zxSq5jtWTD1vK8k7gr87XSgoxQ2bVgGc?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6896.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9e01cf0-b0c4-4a0a-39a1-08dd8b8671b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2025 03:39:30.5988 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d5CHisASP5HIsrbdCzWS74njHhNy8yRX5DYbQa56BQ6csIRkKvTOwXotts6LZQVxsfLHASRokqieTxYNy1SNfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB8383
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=KFTING@nuvoton.com;
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



From: Tim Lee <timlee660101@gmail.com>
Sent: Monday, April 28, 2025 10:30 AM
To: peter.maydell@linaro.org; wuhaotsh@google.com; CS20 KFTing <KFTING@nuvo=
ton.com>; CS20 CHLi30 <CHLI30@nuvoton.com>
Cc: qemu-arm@nongnu.org; qemu-devel@nongnu.org; Tim Lee <timlee660101@gmail=
.com>
Subject: [PATCH] hw/arm/npcm8xx_boards: Correct valid_cpu_types setting of =
NPCM8XX SoC


NPCM8XX SoC is the successor of the NPCM7XX. It features quad-core
Cortex-A35 (Armv8, 64-bit) CPUs and some additional peripherals.
Correct the `valid_cpu_types` setting to match the NPCM8XX SoC.

Signed-off-by: Tim Lee <timlee660101@gmail.com>
---
 hw/arm/npcm8xx_boards.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/npcm8xx_boards.c b/hw/arm/npcm8xx_boards.c index 3fb847=
8e72..6d3e59f6b9 100644
--- a/hw/arm/npcm8xx_boards.c
+++ b/hw/arm/npcm8xx_boards.c
@@ -213,7 +213,7 @@ static void npcm8xx_machine_class_init(ObjectClass *oc,=
 void *data)  {
     MachineClass *mc =3D MACHINE_CLASS(oc);
     static const char * const valid_cpu_types[] =3D {
-        ARM_CPU_TYPE_NAME("cortex-a9"),
+        ARM_CPU_TYPE_NAME("cortex-a35"),
         NULL
     };

--
2.34.1

Reviewed-by: Tyrone Ting <kfting@nuvoton.com>
________________________________
________________________________
 The privileged confidential information contained in this email is intende=
d for use only by the addressees as indicated by the original sender of thi=
s email. If you are not the addressee indicated in this email or are not re=
sponsible for delivery of the email to such a person, please kindly reply t=
o the sender indicating this fact and delete all copies of it from your com=
puter and network server immediately. Your cooperation is highly appreciate=
d. It is advised that any unauthorized use of confidential information of N=
uvoton is strictly prohibited; and any information in this email irrelevant=
 to the official business of Nuvoton shall be deemed as neither given nor e=
ndorsed by Nuvoton.

