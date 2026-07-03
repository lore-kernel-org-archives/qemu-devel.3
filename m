Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 153D7C43602
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 06:47:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfXeQ-0007XQ-PO; Fri, 03 Jul 2026 02:45:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wfXeO-0007VU-8S; Fri, 03 Jul 2026 02:45:24 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wfXeM-0003xE-I9; Fri, 03 Jul 2026 02:45:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jhLXrddz/ifHdsr0v7MjDQ8GvDgPwN2FWu1am2UP37B7BJNZV51ZHPOm7DRXaSrw3vgBbX9qL263+k/lBZ+MMU9XcqShDHKdgZVh+LqmwKCHdJ2XPuXLFDTYrH2yfoKF18oLr5wDhSLcZ4hXMwbJAY7oz3ARa4PomgutD97ndvulivhl2WiMHasYnyvb5WH8G99OhaIsoEFPJrMXbRHTG01K3pDnA5BsFImyk9zWNTZbBL6kQXvl5DlQVAvYpL0rI6XW1jN7hAsrSB72LQpgoS5CcEVWQw8xZ8A5JWGJ7kF5Q9TOuerzLa8bsmizB+bydCm5o6799J9EamsR5s4Bvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D1HMJEBSvdS6SCGRZSot9VKofyMMshO8h3XZXzOd6OE=;
 b=BbFQ9VqgBpMzsx+CZZ2i9zjnnfZ2JAviDI//9hkj7yQ5lKt0uhUSycUXCkSHy/BXpVOraaNK3Z1w3ha2Z9In1prdp0jV/mAFSb26ndVlf0NiJ67Ix+KREaHjakq6IAi4M4zqE/Dry8lCicqGoQ0DzhOGAa/z1XkMeeJgYMjt00EOebQgndra8bGBXzdmNoUHNNDz/8x9A8P27hlVqbJtkunnQPwa2zqtPKgUjRL+vWvjXcUlWL5dmJou7DMQZVcrZM8s3jK1gmOXnDvoIOkH5qTgmUWKLK8WCI1AClbwTf6VSDthUkQMgL1HZ0pSngUC6LoqBkgWiTXN8TiaiREvOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D1HMJEBSvdS6SCGRZSot9VKofyMMshO8h3XZXzOd6OE=;
 b=IRJoFLiAmEkD6t5YG8SGK1/WMK045TjCFb7KRPVudSRJugH29ETvKSXkARuSRmZfd1S0b/IbPUYm9FECDrbm1ryA7aTenR1e8lcPXRzvWdL6BG05nVr3zYnjf2gan5pe4wIhFbbMb3y3PUg1YhFxYyOIfUmkntPbpZ5XylMZ6HKVZkPCqmpymPz1VJWil4/rL5eT1CGQ5TLPr+BEHBTZLAgXzHgno5kYyq+M1v1RpY1ffY3Cx9EXP1qyeQvaeBwSf478UvM4tW4l4bBLcwMwNo/JRNBi/kjyViADzhaJ5lxXemCHgFeP2nOGF3L9sX6/Dn6MZSGa2qjcbFjbjsTM0Q==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by PUZPR06MB5499.apcprd06.prod.outlook.com (2603:1096:301:100::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Fri, 3 Jul
 2026 06:45:11 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0181.010; Fri, 3 Jul 2026
 06:45:11 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 4/5] hw/arm/aspeed_ast27x0: Add unimplemented Privilege
 Controller MMIO regions for SSP/TSP
Thread-Topic: [PATCH v1 4/5] hw/arm/aspeed_ast27x0: Add unimplemented
 Privilege Controller MMIO regions for SSP/TSP
Thread-Index: AQHdCrd+ZtN6L3PHxEuFNmiVsOOweg==
Date: Fri, 3 Jul 2026 06:45:11 +0000
Message-ID: <20260703064506.937904-5-jamin_lin@aspeedtech.com>
References: <20260703064506.937904-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260703064506.937904-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|PUZPR06MB5499:EE_
x-ms-office365-filtering-correlation-id: fa2ac227-f48a-4fb2-d792-08ded8cea170
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|18002099003|22082099003|38070700021|56012099006;
x-microsoft-antispam-message-info: bEAtoyxPrEU/NyHw0YGW7ON/oFmXyytacrnwZ+Xa7lsJjgIhRb0DjfeS9chBCBSEGn5KlSahjOgIRYQYBom+E5ABobXkAy5yk0JuRzuad/OTkqwS1ofG1P1VIEd/R0NE7LmZMgt58/jPeCtKrxnAdwwpmu9U6LhZXyWeEpcxsPi4rs1t0jWdN25VVohlj8WT0QbXqUYdRiTJrRhv10TUIvSvezD4jLwzyg/3zvOyKrLRrOkG5jDTPddHtRhVZKdrMFxhAmNVsPE3gayFMxFkw+MZfoyEC/dYspe+lWNkyrfnDFzzgGyVFwJGU1FHLGa9W9qKifl8DOwC+8HUt5AETEQdgnm2zw7aQAG97D5jsaNiLcnFUSB6PvpnFW+vI+aUhRyBQ6zYIqc7VWPFGv6z0b5YAJCL+weMCqfw2oDrywfhdwk6JE+me3LwjdGf28DbFL5Glbj6ql0exMjg4xgZiCr5Rj3y2knHRkW/aasiLYuUC5hAydb/byEuVx2ReBLOohOYN2JdFO65ZlEXE+gbP0uCCVZGrKd9gCLgQCa7Iz1WJ5FSfsVc0Jdd+2TdWksS8AOCX772GY1vFm0yOs86+eceSiPZ/RVGvxF6CrOdrf7O9NgoSpkyheRV+h7IMGDNZo+GN1yNJWAsLa3CI0IQ38AVeLvS0ZRvB98b2kqja76YcdtRjLmXjuo0uPcmBLN/ANWNgg9G6t9g8b8Jv/wVk1rLXr/3Uxz8k4MucYXtK28=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(18002099003)(22082099003)(38070700021)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?gsBRZIQbOdLf8G03zF+PU8rve9EffQtho44fvqZ9+E6fY42uLecuWWRSi0?=
 =?iso-8859-1?Q?UnSz/PiSHLc3vVI2d5zXhfFYBcMDnvFZMo67kiijfj+CTEwqOrtHF+U3UU?=
 =?iso-8859-1?Q?oWmyPuHHJHUJl0INXRB3/zrDs2Yz85Amuy7cuBvCYk11Ho7e2JSWaAdnsa?=
 =?iso-8859-1?Q?oX7McaTvepayWEnjvll18VbiNYrElGzDCDoPkQwWklN0YddTokaEgYAHEE?=
 =?iso-8859-1?Q?AReZ2ei8lJBu4Ea1inTSS3C9MKs0tC9SeSg5DNRqwQpAJkyQ7YL8+JD0ey?=
 =?iso-8859-1?Q?E2exlNtfeCBXo5tHlYQHBSGZmXJbuRU3MFp8mCOhNwBDI7kTIeDr7fuCaZ?=
 =?iso-8859-1?Q?VRPqhd2EbNNNtpittdnIcglHoojVnMGKhc1V/wWB/WXTuv0ow46PLxWaNU?=
 =?iso-8859-1?Q?3895TVru7xtHXqyFX85ZzIVZF93MtgfB/WgtXuBRtwUya6pUrfL4i5oYPU?=
 =?iso-8859-1?Q?lCyJ8miO7aqduVAldghcKsKnb575xLFpWRt3Aasw31Noa0PWbIpw+EdX0s?=
 =?iso-8859-1?Q?t3TIDuCECfc272yD29ijn+udNzaSmVobiazUNl+HuRvKz7KC2jl0QeBUDN?=
 =?iso-8859-1?Q?p9gbXvRCntx6BI2gdSZzueFDex0oM/Ej/Zjbt9O9Ls2tOkk7UHsmy/YIVV?=
 =?iso-8859-1?Q?KsSllQ9xmWcA53SQbXRIqEo32bYtB57gA1xjLDoMOFotqopXGZIHkEpQq4?=
 =?iso-8859-1?Q?aYyVHnlv7LXtoel9UHJiP5NgYeEd0xUGqxaYLIqTVf0ceNQ4C57kjFWHgf?=
 =?iso-8859-1?Q?csQVB6nmxXAIpF0JqUhlwVNjrBaTTmu2VkW8HCEgQvjlShIJHf0YBcKeOU?=
 =?iso-8859-1?Q?US93KxZbIe7L5wOcktbfTKTFVqduCX36SUIO/Zr4tCp47wgq5xPkSiktMN?=
 =?iso-8859-1?Q?8Gb7SHBEWYgvRj6Dm8FQDxHp7fja5PW/GO0uAAV4wgZw7tXWOlCEJ8IRt3?=
 =?iso-8859-1?Q?rMM3HAs3vekjINDhn6CC1KKasMNZp4D0m9Z/07R9IyKTlNl9GcK2fWDpWd?=
 =?iso-8859-1?Q?U8/s8Irw/QnzN0EMyOuSSC061Dthmfq9cYX8BIDaNDqyf74+haGhzoe8YT?=
 =?iso-8859-1?Q?SBdQgrXfozqYcvNHsu+Rt+/UDZMxmE61lQSxLp+jxQehOIdWjecgcMY7pM?=
 =?iso-8859-1?Q?KdqV6LRYFCoF0m21Doc5U/f2uXM/qQ9EoKf1UE43Kjwg5Wi44WvDbj/DJH?=
 =?iso-8859-1?Q?IkSo+44A/KMHLBqbgV7BIBU4nXUf7rF7aYSoF97humXSMCSo5Rmb0M7cov?=
 =?iso-8859-1?Q?Ce1dhSJPaXbRP2g3CaO1ZDzg1c5F5iaJ+TXo9BIYEhXT8crGGYTU91uAbq?=
 =?iso-8859-1?Q?XAr2igh8GVUwXgcGqtDjKMZRDYaC+McdvfIzQcXkF6qqcyHZZ7v5xtniYm?=
 =?iso-8859-1?Q?Bbda/kzrDVU8mlysCt9+YXq1S5rmIn1cTifbyDK1KOjcRwGmVsyPaYNS3X?=
 =?iso-8859-1?Q?guHWQHPvp8A/nrph6s8bMb83Hh1b2i/nz8JmVSlBRokUMbNih9X23dtyVX?=
 =?iso-8859-1?Q?D2x0TK75lN0CFjw1xXqSeULmNUNMYRNUCF77QXdg9xIxktQ8IQH/bIXtzs?=
 =?iso-8859-1?Q?GlYpurlDxDQ7X6zZaafbo6qcP3iA5QSd6V7EwByFQuvrGl17RdBVKGc6Ew?=
 =?iso-8859-1?Q?LM4VWgQyDUYCmzNs+qdvssrEb66LNrouEWwKmkJSmS5x3WhwRmhjIIRlS0?=
 =?iso-8859-1?Q?rWNFpSsdw6WS6O/u9qOJMmiQ65zQVDJVwkcWd2qkQtsDjXnx+eD/n42FwY?=
 =?iso-8859-1?Q?NxZW+YQqmLR82xds+rVZdfOilfypG0keLsfJnC2QOJL2ACAlpS8KDDs66h?=
 =?iso-8859-1?Q?ExP88g5L1A=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: s9uY0GixjQDo6LauTG/E0ZihCEahpZWD0prropA8JIdATdZ/qZuoJpR1+kAN2zx2GMPWpLpoNG/PhTXUWrzAPfao57paS8U/oZZl1pRuN/AQi0xwHhUnLpcZoeegOOFaUFHEu6UfqJM7OZ0pmCxzCvpvuVEkGwG4EkyMS0TltPKbCfh06UhBfApl563x5n5Wp12KxldPehAggHwCKqF2POQX74PZP3hWYnVyV5jMJos6D+Vqqv8WIDEQ6FfR0zJ8D++SnGhG1HTE6wPRN74vrAAdjZt5Cz5FD9bNGew+EpaCuuut7U8QK0Tsxwto0+0BRnPGHtOsAna4Ks5FPJ6itQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa2ac227-f48a-4fb2-d792-08ded8cea170
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2026 06:45:11.6298 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sZPBwdTLlsvS6T8dydqUzrmmRA/9YrvZJMWu2fdJ+CKJOXhU7ESN8lBi5sOKD93ceMV67NOebWDw5ujh1K8kgiyoQscBHVX6tJ/cIZQf+fg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5499
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

The AST2700 SSP/TSP firmware accesses Privilege Controller MMIO regions tha=
t=0A=
are not yet implemented in QEMU.=0A=
=0A=
This change adds unimplemented MMIO devices for the Privilege Controller=0A=
blocks and maps them to their corresponding physical addresses in the SSP/T=
SP=0A=
address space. These stub devices allow QEMU to safely handle firmware=0A=
accesses and prevent spurious exceptions, while accurately reflecting=0A=
the hardware memory map.=0A=
=0A=
No functional changes.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 include/hw/arm/aspeed_coprocessor.h |  1 +=0A=
 include/hw/arm/aspeed_soc.h         |  2 ++=0A=
 hw/arm/aspeed_ast27x0-ssp.c         | 13 +++++++++++++=0A=
 hw/arm/aspeed_ast27x0-tsp.c         | 13 +++++++++++++=0A=
 4 files changed, 29 insertions(+)=0A=
=0A=
diff --git a/include/hw/arm/aspeed_coprocessor.h b/include/hw/arm/aspeed_co=
processor.h=0A=
index 4a50f688ec..700cbfb4bb 100644=0A=
--- a/include/hw/arm/aspeed_coprocessor.h=0A=
+++ b/include/hw/arm/aspeed_coprocessor.h=0A=
@@ -48,6 +48,7 @@ struct Aspeed27x0CoprocessorState {=0A=
     AspeedINTCState intc[2];=0A=
     UnimplementedDeviceState ipc[2];=0A=
     UnimplementedDeviceState scuio;=0A=
+    UnimplementedDeviceState pric[2];=0A=
 =0A=
     ARMv7MState armv7m;=0A=
 };=0A=
diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h=0A=
index 3aac144cd4..a0d2432620 100644=0A=
--- a/include/hw/arm/aspeed_soc.h=0A=
+++ b/include/hw/arm/aspeed_soc.h=0A=
@@ -295,6 +295,8 @@ enum {=0A=
     ASPEED_DEV_IOEXP1_INTCIO,=0A=
     ASPEED_DEV_IOEXP0_I3C,=0A=
     ASPEED_DEV_IOEXP1_I3C,=0A=
+    ASPEED_DEV_PRIC0,=0A=
+    ASPEED_DEV_PRIC1,=0A=
 };=0A=
 =0A=
 const char *aspeed_soc_cpu_type(const char * const *valid_cpu_types);=0A=
diff --git a/hw/arm/aspeed_ast27x0-ssp.c b/hw/arm/aspeed_ast27x0-ssp.c=0A=
index b3c4eb1915..1b68e4eb5f 100644=0A=
--- a/hw/arm/aspeed_ast27x0-ssp.c=0A=
+++ b/hw/arm/aspeed_ast27x0-ssp.c=0A=
@@ -22,10 +22,13 @@ static const hwaddr aspeed_soc_ast27x0ssp_memmap[] =3D =
{=0A=
     [ASPEED_DEV_SDRAM]     =3D  0x00000000,=0A=
     [ASPEED_DEV_SRAM0]     =3D  0x70000000,=0A=
     [ASPEED_DEV_INTC]      =3D  0x72100000,=0A=
+    [ASPEED_DEV_PRIC0]     =3D  0x72140000,=0A=
     [ASPEED_DEV_SCU]       =3D  0x72C02000,=0A=
     [ASPEED_DEV_TIMER1]    =3D  0x72C10000,=0A=
     [ASPEED_DEV_UART4]     =3D  0x72C1A000,=0A=
     [ASPEED_DEV_IPC0]      =3D  0x72C1C000,=0A=
+    [ASPEED_DEV_FMC]       =3D  0x74000000,=0A=
+    [ASPEED_DEV_PRIC1]     =3D  0x74100000,=0A=
     [ASPEED_DEV_SCUIO]     =3D  0x74C02000,=0A=
     [ASPEED_DEV_INTCIO]    =3D  0x74C18000,=0A=
     [ASPEED_DEV_UART0]     =3D  0x74C33000,=0A=
@@ -141,6 +144,10 @@ static void aspeed_soc_ast27x0ssp_init(Object *obj)=0A=
                             TYPE_UNIMPLEMENTED_DEVICE);=0A=
     object_initialize_child(obj, "scuio", &a->scuio,=0A=
                             TYPE_UNIMPLEMENTED_DEVICE);=0A=
+    object_initialize_child(obj, "pric0", &a->pric[0],=0A=
+                            TYPE_UNIMPLEMENTED_DEVICE);=0A=
+    object_initialize_child(obj, "pric1", &a->pric[1],=0A=
+                            TYPE_UNIMPLEMENTED_DEVICE);=0A=
 }=0A=
 =0A=
 static void aspeed_soc_ast27x0ssp_realize(DeviceState *dev_soc, Error **er=
rp)=0A=
@@ -255,6 +262,12 @@ static void aspeed_soc_ast27x0ssp_realize(DeviceState =
*dev_soc, Error **errp)=0A=
     aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&a->scuio),=0A=
                                   "aspeed.scuio",=0A=
                                   sc->memmap[ASPEED_DEV_SCUIO], 0x1000);=
=0A=
+    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&a->pric[0]),=
=0A=
+                                  "aspeed.pric0",=0A=
+                                  sc->memmap[ASPEED_DEV_PRIC0], 0x1000);=
=0A=
+    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&a->pric[1]),=
=0A=
+                                  "aspeed.pric1",=0A=
+                                  sc->memmap[ASPEED_DEV_PRIC1], 0x1000);=
=0A=
 }=0A=
 =0A=
 static void aspeed_soc_ast27x0ssp_class_init(ObjectClass *klass,=0A=
diff --git a/hw/arm/aspeed_ast27x0-tsp.c b/hw/arm/aspeed_ast27x0-tsp.c=0A=
index 6098d1aae3..59dcccd511 100644=0A=
--- a/hw/arm/aspeed_ast27x0-tsp.c=0A=
+++ b/hw/arm/aspeed_ast27x0-tsp.c=0A=
@@ -22,10 +22,13 @@ static const hwaddr aspeed_soc_ast27x0tsp_memmap[] =3D =
{=0A=
     [ASPEED_DEV_SDRAM]     =3D  0x00000000,=0A=
     [ASPEED_DEV_SRAM0]     =3D  0x70000000,=0A=
     [ASPEED_DEV_INTC]      =3D  0x72100000,=0A=
+    [ASPEED_DEV_PRIC0]     =3D  0x72140000,=0A=
     [ASPEED_DEV_SCU]       =3D  0x72C02000,=0A=
     [ASPEED_DEV_TIMER1]    =3D  0x72C10000,=0A=
     [ASPEED_DEV_UART4]     =3D  0x72C1A000,=0A=
     [ASPEED_DEV_IPC0]      =3D  0x72C1C000,=0A=
+    [ASPEED_DEV_FMC]       =3D  0x74000000,=0A=
+    [ASPEED_DEV_PRIC1]     =3D  0x74100000,=0A=
     [ASPEED_DEV_SCUIO]     =3D  0x74C02000,=0A=
     [ASPEED_DEV_INTCIO]    =3D  0x74C18000,=0A=
     [ASPEED_DEV_UART0]     =3D  0x74C33000,=0A=
@@ -141,6 +144,10 @@ static void aspeed_soc_ast27x0tsp_init(Object *obj)=0A=
                             TYPE_UNIMPLEMENTED_DEVICE);=0A=
     object_initialize_child(obj, "scuio", &a->scuio,=0A=
                             TYPE_UNIMPLEMENTED_DEVICE);=0A=
+    object_initialize_child(obj, "pric0", &a->pric[0],=0A=
+                            TYPE_UNIMPLEMENTED_DEVICE);=0A=
+    object_initialize_child(obj, "pric1", &a->pric[1],=0A=
+                            TYPE_UNIMPLEMENTED_DEVICE);=0A=
 }=0A=
 =0A=
 static void aspeed_soc_ast27x0tsp_realize(DeviceState *dev_soc, Error **er=
rp)=0A=
@@ -255,6 +262,12 @@ static void aspeed_soc_ast27x0tsp_realize(DeviceState =
*dev_soc, Error **errp)=0A=
     aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&a->scuio),=0A=
                                   "aspeed.scuio",=0A=
                                   sc->memmap[ASPEED_DEV_SCUIO], 0x1000);=
=0A=
+    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&a->pric[0]),=
=0A=
+                                  "aspeed.pric0",=0A=
+                                  sc->memmap[ASPEED_DEV_PRIC0], 0x1000);=
=0A=
+    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&a->pric[1]),=
=0A=
+                                  "aspeed.pric1",=0A=
+                                  sc->memmap[ASPEED_DEV_PRIC1], 0x1000);=
=0A=
 }=0A=
 =0A=
 static void aspeed_soc_ast27x0tsp_class_init(ObjectClass *klass,=0A=
-- =0A=
2.43.0=0A=

