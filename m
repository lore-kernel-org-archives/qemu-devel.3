Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8323DCD5BBF
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2026 04:42:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRN8M-0001bY-Da; Mon, 25 May 2026 00:41:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1wRN8K-0001bF-AF; Mon, 25 May 2026 00:41:44 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1wRN8H-0001Dc-SO; Mon, 25 May 2026 00:41:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cgCzHlVdlNLyfpw+ekldn21EnGfCZxyNKyk7UJtXHpiJ0dxDv53NUV+Phb7edxhHsSxRVaLtcYDLK8O2DlBgEgXqkBhL3G7Aa4DbW8gj3WY+os/oyBS+gb30scSYPcZvuLXyvzpyGKCrzaj5+VKutmo4RLYalcEhMgEFiahnEOl+YiJN91GHSg4hW3l9P3WTEk4wZfcZdIC1/Fbve6wYEey854OjeGAj7sM+q9jL8A64sYKZiL1o99aYPcSsL9jQyYpNs4zdt85kRtkykUkwerKnwWGrHyKXjK4wYvlfyBcmSCheOZNiqsHUnzTl02W89OolUzsrMYO8JexmQ9VjnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oteydhIQ8IOcGYKJwlgSSWrOEOvWwokscOpxLMVMa8U=;
 b=DCxEA2ZKtDsjlQ0fuiKWFq2h+rGcb/qPliK5yRvUYgFa+GaBQ2rYntXIhdSQH1R7kQM5CTTt8BkTgNbx9r5eS6ssoydR1/ft4LJxoN4Cz4n9MleIrIwIj6YuPJDvcpQzcQNENpCiZ9mm4Sam3ZFAoxK4e2cILbLWVFlyF/NVrb2Hti0WmFA/LDfqX3uGznkeGQPus2kYcW2+zXncHNV+uYWzhYvSbgeg9LdiSvRQaNxlQ6OcWSgBHwu65cQif/JnD4vm1UjbdoZdAj+/g4tYv50Cwv23u+DLwRpcMrD0EZQQwb3tqjaK8szWhrfEJu0lXB2mnwH6hXyEPiGWFO40fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oteydhIQ8IOcGYKJwlgSSWrOEOvWwokscOpxLMVMa8U=;
 b=aDOBhszNpenu8ilkysfFmvM24OJ6kUXyAZoQrQX5S3f3OcOTvCO1Su4G5DTPVc7KoE32wnT/4l0eSejh0a+4aYF+fvi3upLJnoY6Hiqv7+XHXNg9wChKIAtql/tmg5JJQ1/+bCMHhd+JDQpRJjiRKetkqx8YnCrPwB6iRf5QpwykFfRW8jm0h4bzB6K7l1OWPwJfnisUGU6oyPasuTopgZbfx53wY7TxJaCMqk4uSwmrdxuvogHtV4VByJAWcP/sxYmzSlaLB9ZhaL6/tDw3SRgbxOiDV70FoowVHlQIczTUF5XAFEh7rYpTInv8QwTyEppBbcWKfS10v18LNUfXMw==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by TYQPR06MB8085.apcprd06.prod.outlook.com (2603:1096:405:2f8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 04:41:32 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c%5]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 04:41:32 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Alistair
 Francis <alistair@alistair23.me>, Ninad Palsule <ninad@linux.ibm.com>, Joe
 Komlodi <komlodi@google.com>, Nabih Estefan <nabihestefan@google.com>, Jason
 Wang <jasowang@redhat.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>
Subject: [PATCH v1 01/23] hw/misc/aspeed_pwm: convert to use Resettable
 interface
Thread-Topic: [PATCH v1 01/23] hw/misc/aspeed_pwm: convert to use Resettable
 interface
Thread-Index: AQHc7ADC1iLD0bkP8E2EWFtrXHQNoA==
Date: Mon, 25 May 2026 04:41:31 +0000
Message-ID: <20260525044129.3133916-2-kane_chen@aspeedtech.com>
References: <20260525044129.3133916-1-kane_chen@aspeedtech.com>
In-Reply-To: <20260525044129.3133916-1-kane_chen@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|TYQPR06MB8085:EE_
x-ms-office365-filtering-correlation-id: 04db8333-fcdb-4c5b-89ff-08deba17e4ea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|18002099003|22082099003|56012099003|38070700021|921020;
x-microsoft-antispam-message-info: +1HpZ/PkO2HTh8ydNtSuIZ+2ILM9X2jUldBL16TMeOlPZWLxjyN6oi6O4pNIeeQaFQtQMoQaCGzdp9uVgA+cNJYkMNpSiwE/1LIU+fkwTPcJa/iQBqkl5ssPF38XuuXrTO3FAO9ukimql2eLA9hN0wwUn6UKPJG7gEJi0baF6FG7TSZpWvHnlufwwfRt1+lEfeabICmawzUfzNVFwNMi71lMnxHjm4wFMVZ0j0TL7O++JkwWopM2ZmmshtSNI4epCPaOB/tBBMH5bC2zwQ81rkOfuCeC7oPmQPhmZoJcp2EvuI+TpkynastZY+pqMUG/AgO+ROFGZeAq1F4QY4e3CG1a2gvPxJfO9NUYbzVNm7NS+GHj2+1JPTykl9hiZqYqINru6P8J46JTCzDkGaHg9w9wy+4nzhqzTOKhaVClHWB99p48Ly+zbnCDw0WfNkfW3d2T7yDSGGr/DhIe0tsAvL5BjOX+S90vbO4Z0ZSSWvAdZ+WyKVwGk4zQZmGN4bus/pgVjwwRC2b1GpFM0OcZI2F7wOaTlKrzWyUToXpozv8MEQauSkQS0gQWsPYIXYpabOaLW7bwWKtO0jKmu4d2OZf5l7k5mvKaHKH91I56n0zQEfaqXmZssvrz1/1wRcuwRs37610aDruNOtP1oLcI0ldpmAJnaRZxOYu9iPDeR6nIVpicQoMrNgnGMLd12/ZowySUi0DBBG6qW2WngTZ1OQ4EAspCvpWto6BhHRO57FROKbXGoJR+wgmcmbLvuEz8t3hvo/xM5onjnksfuDwafQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(18002099003)(22082099003)(56012099003)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?uJF95DfGMkwlULVdrQN+OfQ6KDUQYfK13ybSwV+6ROC+G9QZHu70i79wm+?=
 =?iso-8859-1?Q?axPEqFk789p1gcnhuAPcinx+9UJHc30pY3gXQ2yOrtR6gk0Ypdnem555Ub?=
 =?iso-8859-1?Q?Rs2rzplEaYnrIAqCj9DumPFLR7P61/jk1JpNsovue9OfIUnJZjABvR6MHu?=
 =?iso-8859-1?Q?1/vNhYTOtd82PmUAy3Iounr3qetbZyCNsZPzq18oq6BZESvP5yqa1NX0LH?=
 =?iso-8859-1?Q?QTLgbm+eR5Y5AZ7vSqSgauiDaIuirWDuqa2f6PoKymArn1dQdC3NTVedTv?=
 =?iso-8859-1?Q?0XCjdg+Ni6qV99npq0PpQueLBbfdbuW8tl576H9MtaHpAcg483LeGu9Qoq?=
 =?iso-8859-1?Q?BPKwnee2OnuTDmTO5m3BNhN53VfSaAQaRkrjzAr73p0p+98IM2t3VOD5zW?=
 =?iso-8859-1?Q?SP7LEiCPvW/V2ZzArDzmQV63M7G8Z/bsS7QyWqZMMMSd0nTW3uIENEqDQx?=
 =?iso-8859-1?Q?1cse7OjknkL8vwZ/VmBOO9Sgtgz/UMLB1SVJzpF3+S1ISIPvamUNmI9EEq?=
 =?iso-8859-1?Q?Se2esZGO6kqJsDx/1XydWVzMSSghcpJPH4gTwZxcHAoGxQqCGj+fH96tab?=
 =?iso-8859-1?Q?pRYF+utLZ1sqUeP4gyEGgZTdpFbM4mWGfVbo/2e7qdICmbha9ftZo1RXvT?=
 =?iso-8859-1?Q?E/RP3STXKW6LtSlKeeGTTJ9ZxOf2WYDpltzRATgBC0QaT/uJFDEfopcLod?=
 =?iso-8859-1?Q?JVjqfSw+TbMTl8mNa5x68JmxECmenf+UurzdjEfAg/xaa00pGGg7dn2lOv?=
 =?iso-8859-1?Q?fB7CsLiETiULoRT8dmL5O7HxgLberZK1V7dfjr21xrCvs+xbl4MNRwi6iQ?=
 =?iso-8859-1?Q?Pl82SGmqmQCnxXslQ8GVFLqRWEsq9OD6T9bHVjstO8uqEk1uhVRkCCqqDA?=
 =?iso-8859-1?Q?9XuiK+lOdzInh/hm4squTWrGTOipgqyThBrSgLyGys3mEw8rOl2WlfUlil?=
 =?iso-8859-1?Q?PFyPl78OZLYgd7DuqTsuc4HmfZOfzhxi10jcQihPW89qtxhbQ8AajkSCAT?=
 =?iso-8859-1?Q?i2aIt4trWyoNbSfK6bTN/jdt90BM+EXAVYbbK3/ExId954vK5mJ/63HCxm?=
 =?iso-8859-1?Q?jB5+uPAu/YX4ISSSRlaVM2RPrg2WGVQ58nmUd2rJ8z4sXwhXNc7dTM9mnp?=
 =?iso-8859-1?Q?2A475DTgZS7kftPbua7ta0uo6kW1NfkBM1iDNLKD0dRiB49/DYgB/YOyI1?=
 =?iso-8859-1?Q?r1+uP2tUNXYQ0dys+I/QkoYdpbGqO865P26u7SQiEzNywmTBm5yVKR/x3h?=
 =?iso-8859-1?Q?NyqYi5l+cCTD2/LXjfVhDGZUrZRs/nuvHyiTUqbZ+DCW7WiCcc2itOLM7i?=
 =?iso-8859-1?Q?9IwXoctLyWb3GusH/zswOaFLhxpO8bbQMeJCWeBTup6Cxs9PnrgxhK5wP9?=
 =?iso-8859-1?Q?coiJ1KdQeE299oGUkIR2263S2wKO+aiic37Wj99eA2Ys2HLKFaAi2evgyr?=
 =?iso-8859-1?Q?vMiAxpgD0S+UUXztb4f7dKJLUEP5sYoWaoY+gSOl4Ke0ReFsRNqoV7uN2Z?=
 =?iso-8859-1?Q?f5eqHj7o54rlX+wVT7o2az/KR64rL7bIKdV3G57ZI/8GmtNRYM3NvwpzdF?=
 =?iso-8859-1?Q?65BLnLMhqfdaJ7E6rmjVQLw0ZAvd50Py9+f9F2X2GJmK5BP5Kraf9+XdvV?=
 =?iso-8859-1?Q?LDwPMweKMQwKAl0lTbZlQgcHSlMVPXMlzc0qSrNNK9Vk9wMqr5VD2J56Au?=
 =?iso-8859-1?Q?XYnlpEL+xY+WOKNyNmimiGbjes6W7awg3PpjowZAcdwHd26EH6tr39A0Kq?=
 =?iso-8859-1?Q?VrmixcgTtTI4rlJWYNqEhaC1Ok7DUnjBG5gD7/Jq73z5l8/BHfptxz2uCr?=
 =?iso-8859-1?Q?5A11u5XLhg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: YA5YEVl9YCI+ZsyGy2i3rUeGpkVJogKB09yvpxGhoi8DBwbChrMMENht9KvjpxbOr+0eKON7Pm4/+VQkRHa7XLAGjXXdFKSp4w4hzXzRFg/nC9KsUIqHDrrGFPe1nmZzX/wPLlmsiW6lymunCjpE2zLGOvCjYTRDAYulqiYVHOQ1Q3i9Y8gz/PYqNp5wS6Cuceb560HBlcHYbZWmWO1//YlJIvq99vFq5BFr9GbNPspv433YAwsjiPKeS44tzgpjkZhu4sYoTl/YcTUH0gndv8GpMwSCF1nKBcQ2E0QDYLNUXyACoCrfMs7PNBHJh1QXXvVWaEDOQaGIGKQPj1cxpA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04db8333-fcdb-4c5b-89ff-08deba17e4ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2026 04:41:32.0427 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jdyreLLS5V6LxXGHk9fDXOr9+xmQSfiv/g2HQA4/qe7rZ/F70+FFO/i7gEzPGHHBxFdRlnkwjVhl6BMPH0Kgfrb+U3eZWgoztc82nhtyP6I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYQPR06MB8085
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

Replace the legacy reset callback registered via=0A=
device_class_set_legacy_reset() with the Resettable interface.=0A=
=0A=
Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>=0A=
---=0A=
 hw/misc/aspeed_pwm.c | 7 ++++---=0A=
 1 file changed, 4 insertions(+), 3 deletions(-)=0A=
=0A=
diff --git a/hw/misc/aspeed_pwm.c b/hw/misc/aspeed_pwm.c=0A=
index ee3d5884be..673a0f1346 100644=0A=
--- a/hw/misc/aspeed_pwm.c=0A=
+++ b/hw/misc/aspeed_pwm.c=0A=
@@ -65,9 +65,9 @@ static const MemoryRegionOps aspeed_pwm_ops =3D {=0A=
     },=0A=
 };=0A=
 =0A=
-static void aspeed_pwm_reset(DeviceState *dev)=0A=
+static void aspeed_pwm_reset_hold(Object *obj, ResetType type)=0A=
 {=0A=
-    struct AspeedPWMState *s =3D ASPEED_PWM(dev);=0A=
+    AspeedPWMState *s =3D ASPEED_PWM(obj);=0A=
 =0A=
     memset(s->regs, 0, sizeof(s->regs));=0A=
 }=0A=
@@ -98,9 +98,10 @@ static const VMStateDescription vmstate_aspeed_pwm =3D {=
=0A=
 static void aspeed_pwm_class_init(ObjectClass *klass, const void *data)=0A=
 {=0A=
     DeviceClass *dc =3D DEVICE_CLASS(klass);=0A=
+    ResettableClass *rc =3D RESETTABLE_CLASS(klass);=0A=
 =0A=
     dc->realize =3D aspeed_pwm_realize;=0A=
-    device_class_set_legacy_reset(dc, aspeed_pwm_reset);=0A=
+    rc->phases.hold =3D aspeed_pwm_reset_hold;=0A=
     dc->desc =3D "Aspeed PWM Controller";=0A=
     dc->vmsd =3D &vmstate_aspeed_pwm;=0A=
 }=0A=
-- =0A=
2.43.0=0A=

