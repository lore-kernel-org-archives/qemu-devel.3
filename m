Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 405A3CD5BBF
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2026 05:33:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRNu2-0001ac-AR; Mon, 25 May 2026 01:31:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wRNtx-0001Oj-O0; Mon, 25 May 2026 01:30:57 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wRNtv-000381-No; Mon, 25 May 2026 01:30:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gi0pH62izBLqXHdWg1Fs6tElGh+lbMLm1FOsPFvZPHdco9IWVPyNM5K84LyNtHvq0tKggdUFUWPm7vVZCEXyBqD/qP1va/GhY4tP3X6jVrKmr65wwwOd3TNVDaMYDJOymwzmxsIgQSItkXdWemGWtj1YQV6i3cacMKAs3xmR/3bsqoduY1ky4aSC3+z5ZFyoeksdZpJYjWVK+ItKnSuEc/XXXn02n45c4S+smFLi+yz2Eo3qYK48N7h1OM1wO7B39GY3HUMUdsOMHAfepMssmYvu7Og+Kdqi7xKAWanIpeVIvvXnaI+TaSC6GQANH7suox6qMNEl629KN1Xwt3DS+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QtwvMoqNdphKi+JxJdLc1QIN5bNOhklz6pswKj54Wps=;
 b=M8NM4QUhI9PD0E7zZ9W0HjVZHoD5AlvhHHhG8Pc1phiyWhxtv275GtJF1vcPsaGiKTruyf/K6l48hKVgR3xkZWwtRItEDtQC1rI6kvl5rVSEZez58m9JWX0YdH8gJSwWxSK5zTrqyciW8/R97lB2X6dZn0aMdj4bBgN8cJVHN+w3NkpHibzin7qBtlI7+/fxe6t6OQeAZWzmpNcj/ZFk06RBw6Kf1AIX1e0sM2qbW7c9aTz4IAgsCnQnIIZJZfovf5MDQ2moiCCi0IqsvoDSY+dMSYxRNdvraOj5hjRSM8IctmEc2hSnfoqxmP4nD66alb9X7cxJXzGVIhKTafcPsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QtwvMoqNdphKi+JxJdLc1QIN5bNOhklz6pswKj54Wps=;
 b=QXdTi/J3b0ukDUnAS4gt/QK4O/mzxCaHcDmAPc9jkBJg2YlaoiN626kuyk8liQw+2jO49BQPx0YvduJ8regrBp1JhRTweLrZnNE28qS4IsBTqy9h9LZR8QHbo0WiMy2VlyQbYZodut/4BqEmXEbrE7PN5Ie/phxSyudao0a2kd0kT4WbAEmijvPXQicpdDtyASjeR7QiK+p31kp2rLR2pGB1n63rQP7xaGR79DzKmSSP4qD3VBt7KAiu+N+qI2rV3M97rfTAdUijmk1N5dMpR06g1qJ2SQ96NAJYAWyXmLDGUnXI+sYE1pbAQ4SG/1P89AoR5fWVG9IS+1qVSlnlLg==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KL1PR0601MB5653.apcprd06.prod.outlook.com (2603:1096:820:bd::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 05:30:47 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%2]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 05:30:46 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Pierrick
 Bouvier <pierrick.bouvier@oss.qualcomm.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v2 7/9] hw/arm/aspeed: Add AST1040 EVB machine model
Thread-Topic: [PATCH v2 7/9] hw/arm/aspeed: Add AST1040 EVB machine model
Thread-Index: AQHc7Aej1u1xZpR6/06E0XpkpSIgjQ==
Date: Mon, 25 May 2026 05:30:46 +0000
Message-ID: <20260525053036.3305181-8-jamin_lin@aspeedtech.com>
References: <20260525053036.3305181-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260525053036.3305181-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|KL1PR0601MB5653:EE_
x-ms-office365-filtering-correlation-id: da3454ea-516b-40a8-2617-08deba1ec628
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|22082099003|18002099003|56012099003|38070700021|921020|6133799003;
x-microsoft-antispam-message-info: Uwq99gUHq4DiXT8INab6U6fhc33IhrmeygMYh10VuMlsjN3t6dKDnW25yba623O6v1Wd0X0GlXt42LCdFPosPyp39ega8qirhRrJ8Ht3LugDx42NzeT8avD9kmTtqjOKj0yXlZjSVjXCiP+HFoKc5ThuMc6jXNDym7ow8LFnlJFhjLZ5j889LjE9XZ0zmGIaxAlvvn9F77dZu2FAtR3FoIOML4F5u+oxh+acRudufv733BvzanFhIUzQVnchzjLY4SYdy1rtlcU3ASX8nhMWwSblQsFh3c3P57KEUW+B1FXnfesUJnnjzrEvFYYQQqtUdnHmrKsCbZgppIyLbBNTbYb8J1HpQCKGXcyGOZYYQ6JpX0zv7S32DrvMC2VfLZb2Kbv7enJdp0YvI2s7QnUywsxEELSlMiejx2yAgAdEHK0paW/Sc/b9lmp1Y9MEOnoj3E1apPjvr7S+WSqaoI9dkBkiZyGM0XijmTYed9mK7s7u+g+0aei1SgGcs73fhePLeJS+sXDVN/Heukmzi6arVk7ou2xN5TQW5go/TJNAE6iZv4Oo/oT7A/vzkKT2C9ESNB6DWKQSjNAwlIvIyD86gPWjlG5EayLuSUndxjDCk1F2KsyA1moE4KPpCpNpoPATE5K5b3sqNRUojGW1u/AXjRRFbAVH1fGxdI9GbsYCQbW/nGBzDV9yaqTnm2tZpHD6zhtXhTWfGyPcE4t5rI5L4rp0ACHxc1Eytw6hqr7fbjHlmnrfTsPd+yUkYpuy2miAaGwxg9TVzAm+nIqVXlZx+A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(18002099003)(56012099003)(38070700021)(921020)(6133799003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?XITxDpVSjfCvwmdZzKUzfTQvtEsLwQuJF/V/Vqmo8/qc1qPwTvCL3kc3Fp?=
 =?iso-8859-1?Q?bw9iXKN8KlJlZxOXM5g394lOXBY+o36sIe7C+VwY4VWf74ghKI7Zim+/pf?=
 =?iso-8859-1?Q?92WLA0qolHmfV/9GlYAMk6T4k+eCSWmtqhSa106erIaHNsfeOAo4meYApx?=
 =?iso-8859-1?Q?OyUFQ6FJ86CfMdjIV0DHcqv8d5FSXiQrG6LioxHD5cMmf9AnqpSXHmYm58?=
 =?iso-8859-1?Q?HqpcrIfhsFVpHRJwSRfbakbD1ABpvMFsCTCI/o+371Rh6IR1KctqrncmJJ?=
 =?iso-8859-1?Q?InqwacoUE8oVQKcX9g77CTV4yLeo3NJ5rFXArMPkrdl9Lo7pMs7SbMHN0P?=
 =?iso-8859-1?Q?oDtPm7iMcKDJ8tM7LZeo80H0iLh1W62WmogAh1jECgg4Dgfm2ki4aZgyYI?=
 =?iso-8859-1?Q?mG5rbg8lanfkh2DdMJBDXC5nl/Jn4MrEUokYeclAbdSV17OLIH4UaAP45U?=
 =?iso-8859-1?Q?hPJx9kaLHKChwTtrK5yI+dzZWsUwsas3p4eXRoDQbPPT46Mxs8tJWNro1P?=
 =?iso-8859-1?Q?96jjvm7f7sqLuKIGRl+FgezvFmu+X2e55Raph0J/CTwyf2J8nhrYQZxaSl?=
 =?iso-8859-1?Q?CYQ5Ip2uoLUEEvHMSFYhZVtLfvYzOHjNjFxAlVJTVcwl0CdzIZZqTQKc2R?=
 =?iso-8859-1?Q?INX9v6UIG9KkrWtTiyA7NbJ3CuezgUUZfNRCJBgNPtr5vql7QSx5pIZmMY?=
 =?iso-8859-1?Q?xGZ1lHvTmwtongIMNlGVRoKrZf/7PajcGrYQfM4AUi3+Jlqya1k5V6scaI?=
 =?iso-8859-1?Q?kbex1XBC24qtsrGMAwd/hKsE46XyxXW3/Ehw5152PukDBdfoKFpAU6dGQ0?=
 =?iso-8859-1?Q?CGI2I5FQ8v3kdHYBU44YnV42QekS7LcGZp1wYgT7t9iQbLEi45J7+QlZ3W?=
 =?iso-8859-1?Q?BMXz5xqDo5KK6BOV++LrYO41vqOIFtM8AVAKoB9pNNCl5v7b+50EeMTd9C?=
 =?iso-8859-1?Q?2slBZizLwfKBvpQU4hv5NcpQMgDtDTDdxE2Cb3Gt7CakjVCifxLPsOCzmW?=
 =?iso-8859-1?Q?oc2744e6AE3as3QtNq+SPLYLA6/jnZJtkhsBsWuDe4tOr6j4X3QYAfkYaV?=
 =?iso-8859-1?Q?hsfbHg8Yj6/zLi0MDIhrcUk/wnbI2QZTkqiXGNgae1b5v3DW9zX/n5poET?=
 =?iso-8859-1?Q?0fxvpCCmGOI0doKiWO5eA8nZ4TnJX3yx64U6f2HRnElfv1aGnmlCGxCN3z?=
 =?iso-8859-1?Q?NhEH+lT9nNlM/ILnCrQTgHENe20dEjCkW7AVBRU/kpxrYFcKibhuZYw9vQ?=
 =?iso-8859-1?Q?axY2/e0LEehrukxOwDTiB7gHArBgjQ2697OXmh0467iuM0TM6yqIqDwESo?=
 =?iso-8859-1?Q?ni8pXoh4grdko3EDrceNddNURXSPuZcDZZjLA3hYodV2XF4maHoJ2H51iq?=
 =?iso-8859-1?Q?s3Z3imUY75CdlmSLwF36xH705yKMAavJkMJg33HGhqJRxC1FnKm5TeCx3r?=
 =?iso-8859-1?Q?VA1SpLEpPV0TYWtl/5UPH8pFCQ2YTVX3c32pjLjQcBCabGCaWTQcUipDQN?=
 =?iso-8859-1?Q?IHKmRuyOxlhF8/lLFzzlDW9kQsDi5W8ofyGsNTxXh1KxCgZkPSajqEOnOV?=
 =?iso-8859-1?Q?qeeufKBCsA3ThUetkk+PPcvqpzfxopmuWu6bXgqCeDMt2fV9zHXbeaMye3?=
 =?iso-8859-1?Q?bdAUbbvhWGDs8yhlpD+rJqO8vXCOrOPUi+0mY83OUuE+7lWxkOe4XmtiB9?=
 =?iso-8859-1?Q?2h7zVP/0e23tnVOJgMpCN5AaHL/XVT1gPo9O6McoZPTfoUDjZznTU/zNkF?=
 =?iso-8859-1?Q?l6i0DD2tF5TSRRft6phne98sxg2Y+OezF/yNLu/uRwcbJjlXy+D2RaCRoi?=
 =?iso-8859-1?Q?u8BasH3vOA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Uv/dyNoQjkfxGkc6MmZJ7PlPb4MCsqGJsxoIchYZM7myDR1ISqqJ7cKWeFHTPtJmku23z2ABw/4oqtPiSYy/h9eTuzZemZDTrwicohEICNRAbBY8Z2HNfSFn7pQxeZpC7h14oB3iCUxbxBaMp/u2vIXCnJkwWYwlrB+q+Mt1MEZud8hy8v9NuWUfaCsWK4hxvfmZ2aaZd68dWVRJ5uaVLrRJOg2ZV84UKhGYKGjd5RPbZdj2F7zhO7gbacPR6JSwPO42XQnyCTOzOYqui/5hPMEQuiB47E+4W8FCKbT9rJ5MpCCu7rQqU9P9uu32waM9A7BbBhw1QufbdQi3H2ABfA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da3454ea-516b-40a8-2617-08deba1ec628
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2026 05:30:46.9278 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b5/UmsumtrtEzP4uc3ivWVaeCdrZgkCXRTY7MZRHsvQaKHkS8028iVp1vpZeyWkRzNLWFFHW18Fs5idU9EKznFc9tQPSfDWBpCk9YvVvPM0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5653
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

AST1040 is the next-generation device following AST1030 and is=0A=
primarily designed as a bridge/BIC controller platform. Introduce=0A=
a dedicated AST1040 EVB machine implementation for firmware=0A=
development and validation.=0A=
=0A=
Although the existing ast10x0 EVB machine code already provides=0A=
a reusable minibmc initialization flow, AST1040 requires=0A=
different platform settings, including:=0A=
=0A=
  - Different SYSCLK frequency=0A=
  - Different internal flash size=0A=
=0A=
To avoid overloading the existing AST1030-specific helper,=0A=
introduce a separate aspeed_bic_machine_init() implementation in=0A=
a dedicated source file.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/arm/aspeed_ast1040_evb.c | 73 +++++++++++++++++++++++++++++++++++++=0A=
 hw/arm/meson.build          |  3 +-=0A=
 2 files changed, 75 insertions(+), 1 deletion(-)=0A=
 create mode 100644 hw/arm/aspeed_ast1040_evb.c=0A=
=0A=
diff --git a/hw/arm/aspeed_ast1040_evb.c b/hw/arm/aspeed_ast1040_evb.c=0A=
new file mode 100644=0A=
index 0000000000..1d9b55247f=0A=
--- /dev/null=0A=
+++ b/hw/arm/aspeed_ast1040_evb.c=0A=
@@ -0,0 +1,73 @@=0A=
+/*=0A=
+ * ASPEED AST1040 EVB=0A=
+ *=0A=
+ * Copyright (C) 2026 ASPEED Technology Inc.=0A=
+ *=0A=
+ * SPDX-License-Identifier: GPL-2.0-or-later=0A=
+ */=0A=
+=0A=
+#include "qemu/osdep.h"=0A=
+#include "qapi/error.h"=0A=
+#include "hw/arm/boot.h"=0A=
+#include "hw/arm/machines-qom.h"=0A=
+#include "hw/arm/aspeed.h"=0A=
+#include "hw/arm/aspeed_soc.h"=0A=
+#include "hw/core/qdev-clock.h"=0A=
+#include "system/system.h"=0A=
+=0A=
+#define AST1040_INTERNAL_FLASH_SIZE (4 * MiB)=0A=
+/* Main SYSCLK frequency in Hz (400MHz) */=0A=
+#define SYSCLK_FRQ 400000000ULL=0A=
+=0A=
+static void aspeed_bic_machine_init(MachineState *machine)=0A=
+{=0A=
+    AspeedMachineState *bmc =3D ASPEED_MACHINE(machine);=0A=
+    AspeedMachineClass *amc =3D ASPEED_MACHINE_GET_CLASS(machine);=0A=
+    Clock *sysclk;=0A=
+=0A=
+    sysclk =3D clock_new(OBJECT(machine), "SYSCLK");=0A=
+    clock_set_hz(sysclk, SYSCLK_FRQ);=0A=
+=0A=
+    bmc->soc =3D ASPEED_SOC(object_new(amc->soc_name));=0A=
+    object_property_add_child(OBJECT(machine), "soc", OBJECT(bmc->soc));=
=0A=
+    object_unref(OBJECT(bmc->soc));=0A=
+    qdev_connect_clock_in(DEVICE(bmc->soc), "sysclk", sysclk);=0A=
+=0A=
+    object_property_set_link(OBJECT(bmc->soc), "memory",=0A=
+                             OBJECT(get_system_memory()), &error_abort);=
=0A=
+    aspeed_connect_serial_hds_to_uarts(bmc);=0A=
+    qdev_realize(DEVICE(bmc->soc), NULL, &error_abort);=0A=
+=0A=
+    armv7m_load_kernel(ARM_CPU(first_cpu),=0A=
+                       machine->kernel_filename,=0A=
+                       0,=0A=
+                       AST1040_INTERNAL_FLASH_SIZE);=0A=
+}=0A=
+=0A=
+static void aspeed_machine_ast1040_evb_class_init(ObjectClass *oc,=0A=
+                                                  const void *data)=0A=
+{=0A=
+    MachineClass *mc =3D MACHINE_CLASS(oc);=0A=
+    AspeedMachineClass *amc =3D ASPEED_MACHINE_CLASS(oc);=0A=
+=0A=
+    mc->desc =3D "Aspeed AST1040 BIC EVB (Cortex-M4F)";=0A=
+    amc->soc_name =3D "ast1040-a0";=0A=
+    amc->hw_strap1 =3D 0;=0A=
+    amc->hw_strap2 =3D 0;=0A=
+    mc->init =3D aspeed_bic_machine_init;=0A=
+    mc->default_ram_size =3D 0;=0A=
+    amc->macs_mask =3D 0;=0A=
+    amc->uart_default =3D ASPEED_DEV_UART12;=0A=
+    aspeed_machine_class_init_cpus_defaults(mc);=0A=
+}=0A=
+=0A=
+static const TypeInfo aspeed_ast1040_evb_types[] =3D {=0A=
+    {=0A=
+        .name           =3D MACHINE_TYPE_NAME("ast1040-evb"),=0A=
+        .parent         =3D TYPE_ASPEED_MACHINE,=0A=
+        .class_init     =3D aspeed_machine_ast1040_evb_class_init,=0A=
+        .interfaces     =3D arm_machine_interfaces,=0A=
+    }=0A=
+};=0A=
+=0A=
+DEFINE_TYPES(aspeed_ast1040_evb_types)=0A=
diff --git a/hw/arm/meson.build b/hw/arm/meson.build=0A=
index fa3a848492..9b75cc7fb1 100644=0A=
--- a/hw/arm/meson.build=0A=
+++ b/hw/arm/meson.build=0A=
@@ -63,7 +63,8 @@ arm_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(=0A=
   'aspeed_ast2600_rainier.c',=0A=
   'aspeed_ast10x0.c',=0A=
   'aspeed_ast10x0_evb.c',=0A=
-  'aspeed_ast1040.c'))=0A=
+  'aspeed_ast1040.c',=0A=
+  'aspeed_ast1040_evb.c'))=0A=
 arm_common_ss.add(when: ['CONFIG_ASPEED_SOC', 'TARGET_AARCH64'], if_true: =
files(=0A=
   'aspeed_ast1700.c',=0A=
   'aspeed_ast27x0.c',=0A=
-- =0A=
2.43.0=0A=

