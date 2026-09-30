Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0723ECA5FBB
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 07:27:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBogu-0001rp-87; Wed, 30 Sep 2026 03:25:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xBogr-0001pn-OP; Wed, 30 Sep 2026 03:25:21 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xBogp-000289-2I; Wed, 30 Sep 2026 03:25:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yv44/Wi+d65fpulNrzjCsy74VFarzHn3QxY+4BiE+qNlIMX8LTYrqlKdzNcLlBYhzSdmMF26xiP3Ja+cmP82/zhQ5X0IBbRqLMFNMKSJus9yA8ysopz37FU6jU0MBBPev6W5hMkxaASoAjibWLrpcpZYELjzBhA0Fh2lRZ/4pr39WtJT1BFazPnVyA5UFCMdJcg1Sj0YuwwtTKr0ZaGdbEGm/MKEti/bmrfBl+HpO3SDJS6+CBjptKFX2vVx1QgmQUXA3fXuXn8CLhGJzN8K2FiMhqc2zXY6YFpBjXMgcFgx66NHylpHVsYIcuvUKvYDdbjnb33nEd/AvNuYU0tG4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vPQSgB70CZrvDQLHT/M9wtPkHdloPjhLk+ZeFz7+Gy8=;
 b=aLKTae8qV+vsAbqICnGArKRPLQrUIFiYk+BLkAAM1nkuGlXqC4/Y7AMT6Jatvx2QCFNitc1UituKfc0m1A5vkBGHmnvEhM+W5tWjLrv1e3lpP4XDdqNLHknKaHNYajggcjNDzyiYAe9lYWrV4qphu1UoTXLbWcvozy3XB61jlLgUHYvRqEJYcacHZP6rSVxaodq7Jkv0t5xmazu1ZD3DDdnnWMZMOJJcZAnmWGMWpf74ioOIehPi8BWsDCz0nwkK2+/X3b+xvwQ7SNrWZDQv+aZ62eH42+/NlyhVe0SDlImbEQe/C52Ck3ozserwTTAC4ZcBsyXGJ/5TGWjeqHsJBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vPQSgB70CZrvDQLHT/M9wtPkHdloPjhLk+ZeFz7+Gy8=;
 b=PTmcmpg4uTDVu1/ZfXz7KL4+Bli51lHwE3oZllkdn/43vuk7y5ixhkj3joJDAmXEn4VOoyEoZxRHWz6CEkwlSDXvU5LqCWmZ3Cq6jgoXlVz9JxUTtaUh0Q/X/vx0Q6/yxCTSHDtA9KUwb4r+qD61xbPxQKzjT7vcI4rnKL5sZEssyUrnZvEs95NlFcXDvh8Tcglcd6bQ5PHB3ZFskQPi0ImKkaN7DksnUZbfNJoHV+HQTrOWcdQf6/LBpIUUfa5S0wd1IhDf455dXoaa/ofmd2tqwWV8ZwgURyi4KZqwmZ5XtWy6oMc5Jy8vcNO2oSWdpbiVMnG2STYvLzCnrl4AaA==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by SEYPR06MB6616.apcprd06.prod.outlook.com (2603:1096:101:168::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Wed, 30 Sep
 2026 07:25:10 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0472.015; Wed, 30 Sep 2026
 07:25:10 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 07/11] hw/arm/aspeed_ast27x0: Use unimp array and table for
 unimplemented devices for SSP/TSP
Thread-Topic: [PATCH v1 07/11] hw/arm/aspeed_ast27x0: Use unimp array and
 table for unimplemented devices for SSP/TSP
Thread-Index: AQHdUKzT0HPfyuvLpUK2C6pbfcnGHA==
Date: Wed, 30 Sep 2026 07:25:10 +0000
Message-ID: <20260930072501.2612119-8-jamin_lin@aspeedtech.com>
References: <20260930072501.2612119-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260930072501.2612119-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|SEYPR06MB6616:EE_
x-ms-office365-filtering-correlation-id: 68a71afc-3809-4695-5cf3-08df1ec3f610
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|38070700021|10067099003|56012099006|22082099003|18002099003;
x-microsoft-antispam-message-info: nF3y4WL+6GRn794FxHrT6k9WCTPUqoD79D4avvs6NblpCvFxq28PBFHQtjBPO+XXvAJX488O+jR6zt4gbPqfIiWgxVjLUhFKkBYAFFxjUJiyQnS/Fx140X27d010b9rjJ8da3nObEgmRJec8xhzd9zCh40VUqUkA+eFq5g6X82N4WPPmN9qpuMoUn3DyGjzfjSSQIOJCA/QRQN09h00QDsC7n2qgYEKqud5MLma9NYVrkqLTYcM98isdc00J1FqUNUYhlXGbuqw+ET3xDIu8gBF8VDrPb/ie+7z52p5Jgnc3RuHVYq3/pPIjGMdKpl9wleEnjMJJmljJaopYeFaZY0LBlx3ICEtVy9oidoedaPY4H3lCuyCu0CBOkPBAe4cr/JEYyIMmObA3MizP0xh2esjjvAo2noiVLzIKXL8mG5dcvJhxUIgS2lRVigdAXQS+dcDLMB1r5ttP/kMTNYc1muh8VkvS8n/6qV/OPfMHa+hteHPCfRqpfSC3aQJM+7winRZaS9tBf5njFOFteawAjyIqcd4FSbEoctt0AS5w68Mmst7VnNVNwXS/Z6OXzbJ01NOpoWBZ6yZRfZPzY3gp0Pfc37qRj52cg4/c4lso4Z1aNNNuQHX+k9cY9MJKFvg7RfDnG1JjL1NtSg5tzOQt0O3oiOv9GcOkgwrt5Fdb+9IOv3siycGEfevwv04BLM+7T3OTNJvxi+qHyOfy9ufYF/a6xb0Ju3L8592YySKUFpE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(38070700021)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?MVbqbJMKTupp2TXPfXsH66rDjjeDhyCKg+3+CvrwLdecvCmYSXcn/x8RGV?=
 =?iso-8859-1?Q?1xMLa/t0g4P4cIS3T34PySAMgSxRCCzhEwnhZA2KgeQJ25bufvhnkABqq9?=
 =?iso-8859-1?Q?4aIyrrMPUGbCqA0MYNbHizzXeGthhDNtxQgOykyGAIbX9uKZpw9pznISuI?=
 =?iso-8859-1?Q?Q6QfmbeKUDZMTryvN84m8+6R79VCZDBKufs17gwAZwPQve4htDVKMaTYkF?=
 =?iso-8859-1?Q?hKdmJ4I0DpuBUKE8SOylrL6/JxAkl/1GQu91jFeUvjYWiWH0kCWS6yCESB?=
 =?iso-8859-1?Q?3nOsc7E3oxA8Pq3boIT7nK8lG273kV/5uMd/nP/+wg7+0xxOgETotECBmb?=
 =?iso-8859-1?Q?LcPadLjSxUDaZazJ4Vjql9oUTIsKIC+TDo45np7X/jtobkOj1MFHB4CMOY?=
 =?iso-8859-1?Q?0iiqE5j9xtjWeO+FTxCMFt8gSE6mnWkvZ96wcuD0XNCl9HgDDkYTrJfQur?=
 =?iso-8859-1?Q?jTYvLzqs9Fj60LRM2pejmQsrBVm8Ha8Pohdjnc24N87EBQkQFIcQCqkoUJ?=
 =?iso-8859-1?Q?EuYxna5L681+HWkYysL1Mijd4+nDDa4dXkWzo7TBl8s971HzDIoqkNKns4?=
 =?iso-8859-1?Q?RiMuQJQmpVx7JdoJkQmHeQUB72+uG73RilWAoB/yPDRLNwyos5mlE6SFEo?=
 =?iso-8859-1?Q?7Wd9+2SpUFZa/VqjXBD7oq0WDUAA2QRocRvdep5S0bPX8OvYLGGbxljoTI?=
 =?iso-8859-1?Q?ZJ7KQBiVv6/bDa1CHmJOqWqcv5GPYfMjUwuLEfEFWZjPym2uzv8AHn9zj8?=
 =?iso-8859-1?Q?SWwr45oUQ7s/zhL9vlN+elZxDYWNnPeSV0WZR26Zouh/ShubDxNX1QfWr+?=
 =?iso-8859-1?Q?Aq/tWNeKwQKXNAX/6egTETGijQQ4hynOl3sp4zyM3upZLxWV6BASxvShEJ?=
 =?iso-8859-1?Q?F0G2Oq2SbibfVvAiu1/wgePySyTPghzfrzeDfPZEDbkXnGpCKkvKRG6bxS?=
 =?iso-8859-1?Q?2rVmVfYnPsMBoUXDbM3xJTP9Q1H444JVkwamtwupievkCWNWCxyIMPVcCf?=
 =?iso-8859-1?Q?OXsbwpIK8h5Zrc2y3TQygPYXoPDDXaTMuJhIHn9JbYVxUN5S6Ih+Ozhy57?=
 =?iso-8859-1?Q?SkXyU8OTdSVljfcgECMrZab4eKFUeAhpXJAB/oKT0sOwR1PnwVYwvSQ/If?=
 =?iso-8859-1?Q?/0T2BTy3En205PhBrOYmpLe3b4dnuRzgbO7PfbW5JXh74tHmj7NKbYyEAk?=
 =?iso-8859-1?Q?SfS5Jnj2X+Sdcps/MgZE5PEF8F2NBCzUjOAZqD2U5P3sZb6E/M6JaUCTCT?=
 =?iso-8859-1?Q?TpvVw0SgROXWOKKPYiUPLBF1Pfh9vjZzPQwI9RbYs9h5KK7aZ5iEC2iF4V?=
 =?iso-8859-1?Q?jxTax4BGwjOR7RVyCV+mf6khLCxZu6qGM2CJiFuNlMGIECvNm5wNeBd8ln?=
 =?iso-8859-1?Q?P/MyLvVcRhM06e+Q7Ypeq+xYMofzPXO/jOyT9u0GJut5Xt2V5pCUvZXEms?=
 =?iso-8859-1?Q?/4Aul9tYl5d8I/K89Wto4R3P1/ShbqK3XjzlGIcgpQdw3qy8xHC/KRbQif?=
 =?iso-8859-1?Q?BezN1U+rNjTKYNH4vQdoY153C+46/IGsdKhQ+uaA4zeHOrF6yt3nS2dZlh?=
 =?iso-8859-1?Q?Odn7r/iKGM+iVnp8SVhM/0AuK8P1DzCj+V4cGfwC+onUhjtHnzzZJFcfgT?=
 =?iso-8859-1?Q?EXX3iJ/+EBR3zS3aAWYdv0FEqHa67/cZxXISwLb/xBi6gXB+0n++qvyyP/?=
 =?iso-8859-1?Q?gD5ZtabP4WBQ375QwXqA03HI9m/W8HHI2RMREWBxIIoxWk0VOARSLzpGa5?=
 =?iso-8859-1?Q?iBnZI7qMVF+s8TaKn2+OnEEbX0tZ47OAHlOOLcSZ0FxNVQms/3fZElhQKt?=
 =?iso-8859-1?Q?I1z3JUj1mg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: zaNH+4OZMMnjDr+6YVOaKQlqNogC5AI2TYjNmmGZcFdHr99yJc6kMi7S7nOp6QGfPtxntrFVwj/ETDPytQSBE5enpzYvD5RQyr7kjc++2jEylBo7+Bv4zxxJcnS5x8BOrMQM18b/U/I49uuBXt4koYPcLO0tDe+sP7+iaGc15rgdvNGu6PTqG6lCfI1/xAJ74BL8ztOM/auUH0mhTJE20UhfzyiUJ+XTkFHGqfUB1C78V7yFyF09F+HSt2zt6JFfmXrLQ3ikJ+r3pARsBQlWBIfQ1j9QiEbgEFlxel3j+A640qg/dwHaYohJeF1hNrob7D0OSDnUuZM5Y5sLdNpdfw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68a71afc-3809-4695-5cf3-08df1ec3f610
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2026 07:25:10.5106 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VnoiYcOrzFr0xPJGeZrxkLYGe350WvJ9acUVBoy2lYII0q5p1R/gAAcRDyqIqiNyT+0PpjOx/sk7O/o5YkHq4S3R7B162/WMXW63nRr4jiE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6616
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=jamin_lin@aspeedtech.com;
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

Before this change, each unimplemented device needed its own field in=0A=
the coprocessor state. This made the code hard to maintain.=0A=
=0A=
Add an "unimp" array in AspeedCoprocessorState for all unimplemented=0A=
devices, and use the AspeedUnimpDevice table to describe them. This=0A=
makes the code easier to maintain and read. Convert AST2700 SSP and=0A=
TSP to use them.=0A=
=0A=
This also fixes a type mismatch. SSP and TSP used the "timerctrl"=0A=
field (AspeedTimerCtrlState) to create an unimplemented device. They=0A=
now use the "unimp" array instead.=0A=
=0A=
No functional change.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 include/hw/arm/aspeed_coprocessor.h |  1 +=0A=
 hw/arm/aspeed_ast27x0-ssp.c         | 56 ++++++++++++++---------------=0A=
 hw/arm/aspeed_ast27x0-tsp.c         | 56 ++++++++++++++---------------=0A=
 3 files changed, 53 insertions(+), 60 deletions(-)=0A=
=0A=
diff --git a/include/hw/arm/aspeed_coprocessor.h b/include/hw/arm/aspeed_co=
processor.h=0A=
index acb8b06457..29b66cc810 100644=0A=
--- a/include/hw/arm/aspeed_coprocessor.h=0A=
+++ b/include/hw/arm/aspeed_coprocessor.h=0A=
@@ -23,6 +23,7 @@ struct AspeedCoprocessorState {=0A=
     Clock *sysclk;=0A=
 =0A=
     AspeedTimerCtrlState timerctrl;=0A=
+    UnimplementedDeviceState unimp[ASPEED_UNIMP_NUM];=0A=
     SerialMM *uart;=0A=
     int uart_dev;=0A=
 };=0A=
diff --git a/hw/arm/aspeed_ast27x0-ssp.c b/hw/arm/aspeed_ast27x0-ssp.c=0A=
index e03653086c..b448a29665 100644=0A=
--- a/hw/arm/aspeed_ast27x0-ssp.c=0A=
+++ b/hw/arm/aspeed_ast27x0-ssp.c=0A=
@@ -101,6 +101,17 @@ static struct nvic_intc_irq_info ast2700_ssp_intcmap[]=
 =3D {=0A=
     {169, 1, 9, NULL},=0A=
 };=0A=
 =0A=
+static const AspeedUnimpDevice aspeed_soc_ast27x0ssp_unimp_devs[] =3D {=0A=
+    { "timerctrl", "aspeed.timerctrl", ASPEED_DEV_TIMER1, 0x200 },=0A=
+    { "ipc0",      "aspeed.ipc0",      ASPEED_DEV_IPC0,   0x1000 },=0A=
+    { "ipc1",      "aspeed.ipc1",      ASPEED_DEV_IPC1,   0x1000 },=0A=
+    { "pric0",     "aspeed.pric0",     ASPEED_DEV_PRIC0,  0x1000 },=0A=
+    { "pric1",     "aspeed.pric1",     ASPEED_DEV_PRIC1,  0x1000 },=0A=
+    { "otp",       "aspeed.otp",       ASPEED_DEV_OTP,    0x800 },=0A=
+};=0A=
+QEMU_BUILD_BUG_ON(ARRAY_SIZE(aspeed_soc_ast27x0ssp_unimp_devs) >=0A=
+                  ASPEED_UNIMP_NUM);=0A=
+=0A=
 static qemu_irq aspeed_soc_ast27x0ssp_get_irq(AspeedCoprocessorState *s,=
=0A=
                                               int dev)=0A=
 {=0A=
@@ -128,6 +139,7 @@ static void aspeed_soc_ast27x0ssp_init(Object *obj)=0A=
 {=0A=
     Aspeed27x0CoprocessorState *a =3D ASPEED27X0SSP_COPROCESSOR(obj);=0A=
     AspeedCoprocessorState *s =3D ASPEED_COPROCESSOR(obj);=0A=
+    int i;=0A=
 =0A=
     object_initialize_child(obj, "armv7m", &a->armv7m, TYPE_ARMV7M);=0A=
     s->sysclk =3D qdev_init_clock_in(DEVICE(s), "sysclk", NULL, NULL, 0);=
=0A=
@@ -137,18 +149,11 @@ static void aspeed_soc_ast27x0ssp_init(Object *obj)=
=0A=
     object_initialize_child(obj, "intc1", &a->intc[1],=0A=
                             TYPE_ASPEED_2700SSP_INTCIO);=0A=
 =0A=
-    object_initialize_child(obj, "timerctrl", &s->timerctrl,=0A=
-                            TYPE_UNIMPLEMENTED_DEVICE);=0A=
-    object_initialize_child(obj, "ipc0", &a->ipc[0],=0A=
-                            TYPE_UNIMPLEMENTED_DEVICE);=0A=
-    object_initialize_child(obj, "ipc1", &a->ipc[1],=0A=
-                            TYPE_UNIMPLEMENTED_DEVICE);=0A=
-    object_initialize_child(obj, "pric0", &a->pric[0],=0A=
-                            TYPE_UNIMPLEMENTED_DEVICE);=0A=
-    object_initialize_child(obj, "pric1", &a->pric[1],=0A=
-                            TYPE_UNIMPLEMENTED_DEVICE);=0A=
-    object_initialize_child(obj, "otp", &a->otp,=0A=
-                            TYPE_UNIMPLEMENTED_DEVICE);=0A=
+    for (i =3D 0; i < ARRAY_SIZE(aspeed_soc_ast27x0ssp_unimp_devs); i++) {=
=0A=
+        object_initialize_child(obj,=0A=
+                                aspeed_soc_ast27x0ssp_unimp_devs[i].qom_na=
me,=0A=
+                                &s->unimp[i], TYPE_UNIMPLEMENTED_DEVICE);=
=0A=
+    }=0A=
 }=0A=
 =0A=
 static void aspeed_soc_ast27x0ssp_realize(DeviceState *dev_soc, Error **er=
rp)=0A=
@@ -159,6 +164,7 @@ static void aspeed_soc_ast27x0ssp_realize(DeviceState *=
dev_soc, Error **errp)=0A=
     DeviceState *armv7m;=0A=
     MemoryRegion *mr;=0A=
     g_autofree char *sdram_name =3D NULL;=0A=
+    const AspeedUnimpDevice *unimp;=0A=
     int i;=0A=
 =0A=
     if (!clock_has_source(s->sysclk)) {=0A=
@@ -283,24 +289,14 @@ static void aspeed_soc_ast27x0ssp_realize(DeviceState=
 *dev_soc, Error **errp)=0A=
     memory_region_add_subregion(s->memory, sc->memmap[ASPEED_DEV_FMC],=0A=
                                 &a->fmc_alias);=0A=
 =0A=
-    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->timerctrl)=
,=0A=
-                                  "aspeed.timerctrl",=0A=
-                                  sc->memmap[ASPEED_DEV_TIMER1], 0x200);=
=0A=
-    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&a->ipc[0]),=
=0A=
-                                  "aspeed.ipc0",=0A=
-                                  sc->memmap[ASPEED_DEV_IPC0], 0x1000);=0A=
-    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&a->ipc[1]),=
=0A=
-                                  "aspeed.ipc1",=0A=
-                                  sc->memmap[ASPEED_DEV_IPC1], 0x1000);=0A=
-    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&a->pric[0]),=
=0A=
-                                  "aspeed.pric0",=0A=
-                                  sc->memmap[ASPEED_DEV_PRIC0], 0x1000);=
=0A=
-    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&a->pric[1]),=
=0A=
-                                  "aspeed.pric1",=0A=
-                                  sc->memmap[ASPEED_DEV_PRIC1], 0x1000);=
=0A=
-    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&a->otp),=0A=
-                                  "aspeed.otp",=0A=
-                                  sc->memmap[ASPEED_DEV_OTP], 0x800);=0A=
+    /* Unimplemented devices */=0A=
+    for (i =3D 0; i < ARRAY_SIZE(aspeed_soc_ast27x0ssp_unimp_devs); i++) {=
=0A=
+        unimp =3D &aspeed_soc_ast27x0ssp_unimp_devs[i];=0A=
+        aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->unimp[=
i]),=0A=
+                                      unimp->region_name,=0A=
+                                      sc->memmap[unimp->memmap_idx],=0A=
+                                      unimp->size);=0A=
+    }=0A=
 }=0A=
 =0A=
 static const Property aspeed_27x0_coprocessor_properties[] =3D {=0A=
diff --git a/hw/arm/aspeed_ast27x0-tsp.c b/hw/arm/aspeed_ast27x0-tsp.c=0A=
index 39ba062a20..32b57f9363 100644=0A=
--- a/hw/arm/aspeed_ast27x0-tsp.c=0A=
+++ b/hw/arm/aspeed_ast27x0-tsp.c=0A=
@@ -101,6 +101,17 @@ static struct nvic_intc_irq_info ast2700_tsp_intcmap[]=
 =3D {=0A=
     {169, 1, 9, NULL},=0A=
 };=0A=
 =0A=
+static const AspeedUnimpDevice aspeed_soc_ast27x0tsp_unimp_devs[] =3D {=0A=
+    { "timerctrl", "aspeed.timerctrl", ASPEED_DEV_TIMER1, 0x200 },=0A=
+    { "ipc0",      "aspeed.ipc0",      ASPEED_DEV_IPC0,   0x1000 },=0A=
+    { "ipc1",      "aspeed.ipc1",      ASPEED_DEV_IPC1,   0x1000 },=0A=
+    { "pric0",     "aspeed.pric0",     ASPEED_DEV_PRIC0,  0x1000 },=0A=
+    { "pric1",     "aspeed.pric1",     ASPEED_DEV_PRIC1,  0x1000 },=0A=
+    { "otp",       "aspeed.otp",       ASPEED_DEV_OTP,    0x800 },=0A=
+};=0A=
+QEMU_BUILD_BUG_ON(ARRAY_SIZE(aspeed_soc_ast27x0tsp_unimp_devs) >=0A=
+                  ASPEED_UNIMP_NUM);=0A=
+=0A=
 static qemu_irq aspeed_soc_ast27x0tsp_get_irq(AspeedCoprocessorState *s,=
=0A=
                                               int dev)=0A=
 {=0A=
@@ -128,6 +139,7 @@ static void aspeed_soc_ast27x0tsp_init(Object *obj)=0A=
 {=0A=
     Aspeed27x0CoprocessorState *a =3D ASPEED27X0TSP_COPROCESSOR(obj);=0A=
     AspeedCoprocessorState *s =3D ASPEED_COPROCESSOR(obj);=0A=
+    int i;=0A=
 =0A=
     object_initialize_child(obj, "armv7m", &a->armv7m, TYPE_ARMV7M);=0A=
     s->sysclk =3D qdev_init_clock_in(DEVICE(s), "sysclk", NULL, NULL, 0);=
=0A=
@@ -137,18 +149,11 @@ static void aspeed_soc_ast27x0tsp_init(Object *obj)=
=0A=
     object_initialize_child(obj, "intc1", &a->intc[1],=0A=
                             TYPE_ASPEED_2700TSP_INTCIO);=0A=
 =0A=
-    object_initialize_child(obj, "timerctrl", &s->timerctrl,=0A=
-                            TYPE_UNIMPLEMENTED_DEVICE);=0A=
-    object_initialize_child(obj, "ipc0", &a->ipc[0],=0A=
-                            TYPE_UNIMPLEMENTED_DEVICE);=0A=
-    object_initialize_child(obj, "ipc1", &a->ipc[1],=0A=
-                            TYPE_UNIMPLEMENTED_DEVICE);=0A=
-    object_initialize_child(obj, "pric0", &a->pric[0],=0A=
-                            TYPE_UNIMPLEMENTED_DEVICE);=0A=
-    object_initialize_child(obj, "pric1", &a->pric[1],=0A=
-                            TYPE_UNIMPLEMENTED_DEVICE);=0A=
-    object_initialize_child(obj, "otp", &a->otp,=0A=
-                            TYPE_UNIMPLEMENTED_DEVICE);=0A=
+    for (i =3D 0; i < ARRAY_SIZE(aspeed_soc_ast27x0tsp_unimp_devs); i++) {=
=0A=
+        object_initialize_child(obj,=0A=
+                                aspeed_soc_ast27x0tsp_unimp_devs[i].qom_na=
me,=0A=
+                                &s->unimp[i], TYPE_UNIMPLEMENTED_DEVICE);=
=0A=
+    }=0A=
 }=0A=
 =0A=
 static void aspeed_soc_ast27x0tsp_realize(DeviceState *dev_soc, Error **er=
rp)=0A=
@@ -159,6 +164,7 @@ static void aspeed_soc_ast27x0tsp_realize(DeviceState *=
dev_soc, Error **errp)=0A=
     DeviceState *armv7m;=0A=
     MemoryRegion *mr;=0A=
     g_autofree char *sdram_name =3D NULL;=0A=
+    const AspeedUnimpDevice *unimp;=0A=
     int i;=0A=
 =0A=
     if (!clock_has_source(s->sysclk)) {=0A=
@@ -283,24 +289,14 @@ static void aspeed_soc_ast27x0tsp_realize(DeviceState=
 *dev_soc, Error **errp)=0A=
     memory_region_add_subregion(s->memory, sc->memmap[ASPEED_DEV_FMC],=0A=
                                 &a->fmc_alias);=0A=
 =0A=
-    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->timerctrl)=
,=0A=
-                                  "aspeed.timerctrl",=0A=
-                                  sc->memmap[ASPEED_DEV_TIMER1], 0x200);=
=0A=
-    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&a->ipc[0]),=
=0A=
-                                  "aspeed.ipc0",=0A=
-                                  sc->memmap[ASPEED_DEV_IPC0], 0x1000);=0A=
-    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&a->ipc[1]),=
=0A=
-                                  "aspeed.ipc1",=0A=
-                                  sc->memmap[ASPEED_DEV_IPC1], 0x1000);=0A=
-    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&a->pric[0]),=
=0A=
-                                  "aspeed.pric0",=0A=
-                                  sc->memmap[ASPEED_DEV_PRIC0], 0x1000);=
=0A=
-    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&a->pric[1]),=
=0A=
-                                  "aspeed.pric1",=0A=
-                                  sc->memmap[ASPEED_DEV_PRIC1], 0x1000);=
=0A=
-    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&a->otp),=0A=
-                                  "aspeed.otp",=0A=
-                                  sc->memmap[ASPEED_DEV_OTP], 0x800);=0A=
+    /* Unimplemented devices */=0A=
+    for (i =3D 0; i < ARRAY_SIZE(aspeed_soc_ast27x0tsp_unimp_devs); i++) {=
=0A=
+        unimp =3D &aspeed_soc_ast27x0tsp_unimp_devs[i];=0A=
+        aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->unimp[=
i]),=0A=
+                                      unimp->region_name,=0A=
+                                      sc->memmap[unimp->memmap_idx],=0A=
+                                      unimp->size);=0A=
+    }=0A=
 }=0A=
 =0A=
 static const Property aspeed_27x0_coprocessor_properties[] =3D {=0A=
-- =0A=
2.53.0=0A=

