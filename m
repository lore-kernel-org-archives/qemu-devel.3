Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11185CA5FBB
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 07:25:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBogq-0001pG-Dh; Wed, 30 Sep 2026 03:25:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xBogn-0001oB-Sk; Wed, 30 Sep 2026 03:25:17 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xBogm-00027z-3k; Wed, 30 Sep 2026 03:25:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bs6NieGo4D6Cn6kBW8GbkwiBAU9LGjUZRgt1kOifRL4f9APgNkFbqSWcvI5Yv4jQphuAkQ5RyrrCxnPfWdWxTo2bqEHfJbgh2T8ww3kV3BT9fiLNMtPfHf5W1PzOBSLQ7lXqcoBcWYLAxxam+zSmvzrgrs3MhGDxEuW+TGXhQQzAEGLiacySp5175XldIPhPMG19JeDGOeLWj0R5Vp9PrfYRNpSqAF3TTaVfaOYHC60DhSvbeR7gfYCyPhuKRUiOoCvd6+r5yMcY8E5tB0PaCrJ2J6KVdZoW0eg2lonycqD2LptCCdv28Q9dn6iV7hUQPyyhSAvvZYVDbX3gYyj8xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bs062OhoI72q4icTGupzEMsL5GuXsWMUVlfeXyATzn4=;
 b=tnT6ndBJ7doXC7fvQCtNNIQ2vElaWPRil3gZqaU+T12l/SMZGP41LBY6a+fXY9ojB3S3zb5leODXGis8B8u3W/h1zTmEMqybeAu1U6cE/iRWRi00cIPQj90VLH+XAapB/mZcemIYLdZkY+GXZACH9KrimUgTlDIdMFIop42ges/jxOXKUqaguqEvp8MryIX1ZWtTzcvDH7zLDG9FL/toWts5DHGyBAUg9DSg7VzkIKHclcxGaTSEmUNTLsHaxtrNVxOWDzBjRWFdJ5jYwlfLjcJr6ALR51psXDVIhv8t9RktD/wWXlm3jWnAYk0n226Z5cukF3o/BCcSGrS901LXzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bs062OhoI72q4icTGupzEMsL5GuXsWMUVlfeXyATzn4=;
 b=StPi9ET6bYAb8Fok2m7KmsNFGL7gzMkonL+PIr/VTg4y51alPfIEy+FQC7+qCdDH3SpX92BPdidzcHJrxL6hhEqfc2CUwHrC6SaXB++w9p0vOKAlGuhIZG9Ljp+WrO5iqdMClvzh5ZaQE7FQYxADJku2qQ9yxXndg6SNNjAMw+xgCmoZmdLiUQOAGoXHqKnPVZ7tSAhZuf41Xpmvu6gJuYce+W+rs4dZazSFb1rq12kIQTi9lDaVhxO3YuLRzC6phFVVIDdYoA5p1csnJ1JGAgc7CqGswv0NWuTcRIR8dLLKKFFfoTQ8OhAyn/F2zVJ5MBE24chddN4oakE0YFRYYw==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by TY1PPFF90486440.apcprd06.prod.outlook.com (2603:1096:408::932)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Wed, 30 Sep
 2026 07:25:08 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0472.015; Wed, 30 Sep 2026
 07:25:08 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 05/11] hw/arm/aspeed_ast1040: Use unimp array and table for
 unimplemented devices
Thread-Topic: [PATCH v1 05/11] hw/arm/aspeed_ast1040: Use unimp array and
 table for unimplemented devices
Thread-Index: AQHdUKzSRsgt21xvIUCXrT/SgGEaYg==
Date: Wed, 30 Sep 2026 07:25:08 +0000
Message-ID: <20260930072501.2612119-6-jamin_lin@aspeedtech.com>
References: <20260930072501.2612119-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260930072501.2612119-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|TY1PPFF90486440:EE_
x-ms-office365-filtering-correlation-id: 3c5bdada-ead0-4a33-187f-08df1ec3f4b8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|56012099006|10067099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: gng6nYZpyeLHwwuRf+sA9YhRuXKGwJTeRbHOaDOpRhQ8v5703DTMyQy0MDVKOBqpL+GV2k8pdPBlDGY5IB8eQubPUuWzLq8+m1/QpxLYRU1V1e78iAKeaO0W09raKu6Wk4Di5NQazeZxRH7E+9KNQ1PDtYxHM5VdW5E6ihr4RNfC8qc0YoJxO8TNWx/gQS+gcq5RKofVzYkHEuiV4xcbAIJ8pLq0px1usrjbWU6qZ0PV1Cs6PcFRZCPElgljqr/JiRYl5qn8FyIo/1Ab1FGUEA0kEdvQXADXgv1mMCzwIrj4oJ9thKpWama6yZh/ZtAytQH2g46dVdkHCUaoj7cFDblTdTkzuq4aJT3PpVeE3Q9fazS/qpxBBFrvs1u5/qJJe/jKeQb4a4QY88aTN3OrHxHN/blyBcMPv4tUvTb41rxhLiaPnFF6Xv0/Ch6K4wnYHfzIJBcjFuaw6j7VI28nK1UiT88zr8do20USaCDWYOEN9AFxx9OQ39Xiw5hYOS1TKDczWTCvhs+MS4FAsUwf6opwLkjEmrsz9OGJ5ES4/qkZgMx6x6dz1RL8SqB1oN5+r0g3KWWx4pbPvg08btoth9zs2fDw3PpXh+ieXmUnrUhe1gyFLKmOBLTeTjbiYsQwvvkoD3VM33NVudvMu09HZTvigu/VeLLJnDFnZ/stWkZz1/Pp1wTQ0OiNrmz6yOea4pEPZc3Er+ntM4JNKKttsdfggQDgDL0S8/9SBGTLlUo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(56012099006)(10067099003)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?HnngI36gcc3xnR00Jla85AiS7ezKrEi0YfRQqct01+RhLLPX+TGRtanaYN?=
 =?iso-8859-1?Q?WiRWDEjtX7JfksBuhPZo4Qu8hZ66Mlh37qpWBYnIggosuzSjAsw4fcWRKY?=
 =?iso-8859-1?Q?K+dI2m1xIUXhSwT4ZhglAepyqCr+fPkSG/ru0dmZljYab2MyUaY7IOFRJN?=
 =?iso-8859-1?Q?XOXvpEHwFfyBiIaADG6RGZoO5kXAefkW5gtntAo4BvoYeM1HbmfAeFWQS0?=
 =?iso-8859-1?Q?GyG6zEwRPtqQgQxLArRXKCKPkeHfM4mTPQfROgMXKi8969KYNGr0xF7wUh?=
 =?iso-8859-1?Q?mT/OHgJZ9krda47khaYR5Z2xSMptKB3flFJum3fnEEG/bz/e8TGX3DpCrR?=
 =?iso-8859-1?Q?74cK+ZyMKYlOgvAjZOazm/DaiF8Pz+a8/Y/a8VA4f+nMP0f9DXSl4kUhBy?=
 =?iso-8859-1?Q?ovMdjkqUX9tb3RQsXJ5FjHcFenM7re0jTaLynYM2JAQEgxxEFEODjBK0me?=
 =?iso-8859-1?Q?a7cEHpKM7kK+V3vxCSgakguX0dz30cjkKDnn1ITALf32fe+Of0yMs7JQtB?=
 =?iso-8859-1?Q?sltu8kf2prGkwSKEYWAhuYEge6Z+VEkrv3N2G/nFCuo55p7199m25Am5sH?=
 =?iso-8859-1?Q?0Au944A/XTCYNseyHpi5Wwc0wMZUp7eUWcATe2TbyeB9qsUO4o3vtNwvRw?=
 =?iso-8859-1?Q?nC3VGXA95Ms6IEIE9B6JUxyasolP+JZdkqbqjrFcuKhoNT4SzwyJaL4e1h?=
 =?iso-8859-1?Q?BF21xU1EKYyFri1ovOicHGN79FpsLqPNumK/z1HtPNzG5QuNYmnYoWH6He?=
 =?iso-8859-1?Q?ScFBLPgCFC5n4R07WlxXrladF3vMQLN+wApfiVKqkK/4YqNuJouqLl5VzQ?=
 =?iso-8859-1?Q?YreJ66t2acK0uakNLJm/ui9/PBSjXO1sI5MJL2EwX+b5BTf5dNptoQOyZk?=
 =?iso-8859-1?Q?LqZInj24umqrOx/Yr56e6wDtp0DrJvGRQyxI+4l2ce7/RmCFRAftA1SJg/?=
 =?iso-8859-1?Q?hoY1IUQicNZcSYxPJOH3PBhF10lXSz1j9XIUnwZpyvvQTRAy3E9rBByqjC?=
 =?iso-8859-1?Q?H5+eO8/3aSPZUyJptSchhkR3yWNYjIkZdO5ulXZEmdbeA/vebfI6EFnMEf?=
 =?iso-8859-1?Q?76qawlBnQBgW8tjoxZH1b31OEZHh1SAVJL+hCDU9U0ikX+PDSMj/gxuK+m?=
 =?iso-8859-1?Q?LBnPM0EQuDE2U/qKoVfzrIt9x3zB7SFFUj8TYn4+jxvfJjtKiAd914nksF?=
 =?iso-8859-1?Q?xFep27hZTR8KuHGsFh+SFBxs7hK1lX7+LT03BOYsR3IqhOLQXQ/cLaksfA?=
 =?iso-8859-1?Q?K+I40nAofHgmlYU3IidK72m7tinU3oIpVH0pviQulhhOKiyvIYozzPWTiB?=
 =?iso-8859-1?Q?/mjjlo23QlbPxi4Jl5fmI029EPCkEW9/E9d9RXhhRZsxb86x5LtDZukHDu?=
 =?iso-8859-1?Q?sw/EmLdENOL/v2s3MykkvJDIe08rSRrGpWuODsJX+wfvkC1U9avBKLLq3K?=
 =?iso-8859-1?Q?DLVI6AYW/y7Q6Th7qAUCFx8ncTVtnDcnmwSxXz3k1giiFiYS3JaB34Q33k?=
 =?iso-8859-1?Q?MXSiUM0JaKuFF6xKYhtuMXO4XZFsDexdrDh6Hcuw5SpUP3R4/J89Upoxyf?=
 =?iso-8859-1?Q?Td9fAC01bLFbRdzn5XSJjdwxOY4CaPkY3e01yAarn2NgshkDmkjojI40kP?=
 =?iso-8859-1?Q?vGXb9xvM2Z8UBjJAz5+rwMMQSGka+2WNHLUYZEzlx8So/5JgkHzGMvAyVa?=
 =?iso-8859-1?Q?V6WKvRAn1WDfhYY32zNhHMTtiBr7eStgwbemSuRtQxJehstdT7e7k9dC6N?=
 =?iso-8859-1?Q?yUZ9BnZQvCBFH0PoIPFHnvmm68hRswgROfWywyFPYBD3vRQyKew41qswP9?=
 =?iso-8859-1?Q?Tg0vQxQA8Q=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: fb40i28w4dwj8w6vUAGYUHfMv6BwGjors8ybU2pi2RpbFswxN5taZ8UQK2jF/ooiJcNf/x/ve14fHGRpwvbCxsZwPJVT6IpE09Y/uHmX0oCX1akppnse6QzFSfurB7cvVLrfivAkcyIIdKZR/AGOoO4JtGdgQJFUtEKsOEJz2b7w1qle8om2cKM9wUGUAb8VN95FfQLm2xEY4rQTKvD3LJLN/C1w2AqP75iWNWKTb5dv9wFWwIEymz5VAF2wZyraalp51wZJEFAqHu9+FSMzYRyNwolJ+CdAg1Svl8yoqrjacJziuMTb0wdTM+tD2Vw2rQfpACF3cAuQkdS6exwOBQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c5bdada-ead0-4a33-187f-08df1ec3f4b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2026 07:25:08.2442 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GVwJAClaE7v6V1ZFmvRfnQM2lX6E214NEqIVqaEQCdmYy+lMrardC0JlWLtYatBUiZ0sbsX8GRDZG1npidYMnxDNRTzq89+5hOvobCUWBh8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PPFF90486440
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

Before this change, each unimplemented device needed its own field in=0A=
AspeedSoCState. This made the variable names confusing. For example,=0A=
AspeedSoCState has "udc" as an unimplemented device, but=0A=
Aspeed2600SoCState also has "udc" as the real UDC model.=0A=
=0A=
Use the "unimp" array in AspeedSoCState for all unimplemented devices,=0A=
and use the AspeedUnimpDevice table to describe them. This makes the=0A=
code easier to maintain and read. Convert AST1040 to use them.=0A=
=0A=
This also fixes a type mismatch. AST1040 used the "pwm" field=0A=
(AspeedPWMState) to create an unimplemented device. It now uses the=0A=
"unimp" array instead.=0A=
=0A=
No functional change.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/arm/aspeed_ast1040.c | 49 ++++++++++++++++++-----------------------=0A=
 1 file changed, 22 insertions(+), 27 deletions(-)=0A=
=0A=
diff --git a/hw/arm/aspeed_ast1040.c b/hw/arm/aspeed_ast1040.c=0A=
index 57ffc0807a..f7d94bc671 100644=0A=
--- a/hw/arm/aspeed_ast1040.c=0A=
+++ b/hw/arm/aspeed_ast1040.c=0A=
@@ -81,6 +81,15 @@ static const int aspeed_soc_ast1040_irqmap[] =3D {=0A=
     [ASPEED_DEV_PECI]      =3D 164,=0A=
 };=0A=
 =0A=
+static const AspeedUnimpDevice aspeed_soc_ast1040_unimp_devs[] =3D {=0A=
+    { "pwm",     "aspeed.pwm",   ASPEED_DEV_PWM,   0x10000 },=0A=
+    { "espi",    "aspeed.espi",  ASPEED_DEV_ESPI,  0x1000 },=0A=
+    { "udc",     "aspeed.udc",   ASPEED_DEV_UDC,   0x4000 },=0A=
+    { "jtag[0]", "aspeed.jtag0", ASPEED_DEV_JTAG0, 0x100 },=0A=
+    { "jtag[1]", "aspeed.jtag1", ASPEED_DEV_JTAG1, 0x100 },=0A=
+};=0A=
+QEMU_BUILD_BUG_ON(ARRAY_SIZE(aspeed_soc_ast1040_unimp_devs) > ASPEED_UNIMP=
_NUM);=0A=
+=0A=
 static qemu_irq aspeed_soc_ast1040_get_irq(AspeedSoCState *s, int dev)=0A=
 {=0A=
     Aspeed10x0SoCState *a =3D ASPEED10X0_SOC(s);=0A=
@@ -124,13 +133,10 @@ static void aspeed_soc_ast1040_init(Object *obj)=0A=
                                 "aspeed.wdt-ast2700");=0A=
     }=0A=
 =0A=
-    object_initialize_child(obj, "pwm", &s->pwm, TYPE_UNIMPLEMENTED_DEVICE=
);=0A=
-    object_initialize_child(obj, "espi", &s->espi, TYPE_UNIMPLEMENTED_DEVI=
CE);=0A=
-    object_initialize_child(obj, "udc", &s->udc, TYPE_UNIMPLEMENTED_DEVICE=
);=0A=
-    object_initialize_child(obj, "jtag[0]", &s->jtag[0],=0A=
-                            TYPE_UNIMPLEMENTED_DEVICE);=0A=
-    object_initialize_child(obj, "jtag[1]", &s->jtag[1],=0A=
-                            TYPE_UNIMPLEMENTED_DEVICE);=0A=
+    for (i =3D 0; i < ARRAY_SIZE(aspeed_soc_ast1040_unimp_devs); i++) {=0A=
+        object_initialize_child(obj, aspeed_soc_ast1040_unimp_devs[i].qom_=
name,=0A=
+                                &s->unimp[i], TYPE_UNIMPLEMENTED_DEVICE);=
=0A=
+    }=0A=
 }=0A=
 =0A=
 static void aspeed_soc_ast1040_realize(DeviceState *dev_soc, Error **errp)=
=0A=
@@ -140,6 +146,7 @@ static void aspeed_soc_ast1040_realize(DeviceState *dev=
_soc, Error **errp)=0A=
     AspeedSoCClass *sc =3D ASPEED_SOC_GET_CLASS(s);=0A=
     g_autofree char *hyperram_name =3D NULL;=0A=
     g_autofree char *sram_name =3D NULL;=0A=
+    const AspeedUnimpDevice *unimp;=0A=
     DeviceState *armv7m;=0A=
     Error *err =3D NULL;=0A=
     int uart;=0A=
@@ -267,26 +274,14 @@ static void aspeed_soc_ast1040_realize(DeviceState *d=
ev_soc, Error **errp)=0A=
         aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->wdt[i]), 0, wdt_offs=
et);=0A=
     }=0A=
 =0A=
-    /* Unimplemented peripherals */=0A=
-    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->pwm),=0A=
-                                  "aspeed.pwm",=0A=
-                                  sc->memmap[ASPEED_DEV_PWM], 0x10000);=0A=
-=0A=
-    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->espi),=0A=
-                                  "aspeed.espi",=0A=
-                                  sc->memmap[ASPEED_DEV_ESPI], 0x1000);=0A=
-=0A=
-    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->udc),=0A=
-                                  "aspeed.udc",=0A=
-                                  sc->memmap[ASPEED_DEV_UDC], 0x4000);=0A=
-=0A=
-    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->jtag[0]),=
=0A=
-                                  "aspeed.jtag0",=0A=
-                                  sc->memmap[ASPEED_DEV_JTAG0], 0x100);=0A=
-=0A=
-    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->jtag[1]),=
=0A=
-                                  "aspeed.jtag1",=0A=
-                                  sc->memmap[ASPEED_DEV_JTAG1], 0x100);=0A=
+    /* Unimplemented devices */=0A=
+    for (i =3D 0; i < ARRAY_SIZE(aspeed_soc_ast1040_unimp_devs); i++) {=0A=
+        unimp =3D &aspeed_soc_ast1040_unimp_devs[i];=0A=
+        aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->unimp[=
i]),=0A=
+                                      unimp->region_name,=0A=
+                                      sc->memmap[unimp->memmap_idx],=0A=
+                                      unimp->size);=0A=
+    }=0A=
 }=0A=
 =0A=
 static void aspeed_soc_ast1040_class_init(ObjectClass *klass, const void *=
data)=0A=
-- =0A=
2.53.0=0A=

