Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E62F0C44500
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 06:10:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgz01-000355-3q; Tue, 07 Jul 2026 02:09:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wgyzz-00033E-6l; Tue, 07 Jul 2026 02:09:39 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wgyzx-00083r-Lk; Tue, 07 Jul 2026 02:09:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ECNecmsFLOxaTqC6TqX1tXQZtToG2GkEgSUjDCW/mMbASDajIFZz4a45CvnqntmQBHBKjfD8kombEVKEAQHUcjRG0fWRGJdPObxov5KPwlk/C8XJnlFcazLlwm5UNJzoiwnr+vAzU2hX3bFvN4giZplwC0lnv4uK+sYms5HpKHLtCl1PhUgNd3e+yjVXlMtlj0NHjaTQqAE1qNuW8S3BBujxNzhF50GAMYiVrq/yHK6GfLzzqIPnFslKOnSot2CQoU9zmcS8Ce1R7G6298T4uCevgqtfLEgfmvKhMbUAfwNjUU8/CtZpbdTns3ts7zcxm+QKqChPTgqzVikPkmKb0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e/qNEMlBYKXs7OanTSaDE6jputRLjrbxHIDekZMiIFM=;
 b=cpV0h62hF8lh0bBEpXfFML2j6sm5hi+ci3APT9yXJiClgT/SugfAEYZADMA6pvrEzZS1PsY9xa5a+x0P+l8FQ4BQiUw4X4aPtB7JraK9KrsQjsRSIEkHK6jEHmSYhOHYAUBcvktk61y6MVN89zh7GMnVU4clVYiq/0UPQpsVFvaFYG0+CmAtJO3Q69plaftPWzywPwV5OT3HjkdNi9iZpjUGEDhTfAef40qkAPoVI/9CKEN7Pg5XrXVE0zth3U1OepnQvOnCFl0IuHMNx6BlyGZsVQTGRnefZI0c6JPsmH5gvCBSAiU8EiBu98SBc4s1IcIOoi0YlJbjGtBB4LdAww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e/qNEMlBYKXs7OanTSaDE6jputRLjrbxHIDekZMiIFM=;
 b=giGg76PkrN/uOP5gNzoKtVa6r+JGn3+R528OC6Tm9dR1Y2+uVYM13N2iKaJfM2Z8dqKz5VH0wRfin8I9FnX5GmgnZPMhGUp3q7w7ewDbrEfAmz3iK7t8AZdOwnf2BVfe8y+RamKmltk5jMNg5RppZ6yqFbGVKAX4OD2GoJjTe3OdD5DrVPuJ9ZusC4g2A2EevpZtHZtdy/OXkDJc5LPJbkjmAzSytBMk5A0AtlWA1JPKa2HcHA6DkZKX/BqPc1seYSwzyn6eEZh/I1Fe7sEHVH2ITNc7nwSHg0Sr5f+aUAzOJ8MobrZBMlyT33Zjhc2hmN6jsCeqDslwpzu+Jk96Ww==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by SI3PR06MB8706.apcprd06.prod.outlook.com (2603:1096:4:2a3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Tue, 7 Jul 2026
 06:09:22 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0181.010; Tue, 7 Jul 2026
 06:09:22 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Alistair
 Francis <alistair@alistair23.me>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v2 1/8] hw/misc/aspeed_scu: Introduce Aspeed2700SCUState
Thread-Topic: [PATCH v2 1/8] hw/misc/aspeed_scu: Introduce Aspeed2700SCUState
Thread-Index: AQHdDdcn8tw6wRtB6UqkVyBneEDm2A==
Date: Tue, 7 Jul 2026 06:09:22 +0000
Message-ID: <20260707060919.350637-2-jamin_lin@aspeedtech.com>
References: <20260707060919.350637-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260707060919.350637-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|SI3PR06MB8706:EE_
x-ms-office365-filtering-correlation-id: 95d1646c-fa67-4ce2-8435-08dedbee49eb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|18002099003|22082099003|56012099006|38070700021|921020;
x-microsoft-antispam-message-info: oKACGqTs4EkGs1A2G/iDbp5GWmXQVJTtkqHIxNG1nxNZrTYFa8VR/tOr9VOSiHUcunhV9r677x1Zys31379iSH+kKCi66/HdMTYhFCbIB5ofR74y4AYo4pBuzMZ7LXD/Y7wgM1FdlJzHOy4iIY0KvwMskJoPNQ4hln8ditac7Wp191MNoKfsRmB8ndeXuK7MU/ho1yYfV55JBaGLnEhRvPw+ya5j8gThhuDQ4T5u7y/LHtJK9aCXaC1bWByq+4DdPd5Fym+O3c1FP3z4zCNrY9b/XcZXqfzxQPcbwnQbfyPVOFfESD5YtjYQEzLCvHVzsRe+5qUCA6ssAwNSxuyYncUgF3f7vK4A08Lui9TAtPAUzI3+yJi82zH78UEsJaQeEJ8VBhBA1EkH+dF0F88ELhhv2DklRqlMr34NZGl3OwPssBwh8UjdhgPa981KP505gdlkzRqeclN7nmfdGs7ePmEPzDADh6fX1h7nwtU99QvCbFxgiFTj3J8rh0JKOWYN2yR8cKFsw0DVmb8dbCw+0Ao7S05mge1IKsn/gv3UeEPVVjnWM4X+qMcuUkcUxQ6zePJ/5lmKWJnqbt9Yw/bVkWK6o9VRtQu400iJOKoqyDfjiVLZB+oz6MZpH4OCb5QgpsXtEHam9YJ/J0UxCKhBJYIC2Pfqpetzjuc7d57VrvHtEkzdMGq7MLccR9A2Mtw9Q0ugbAAErSNnnLoYRRwbjS+/MYT2IX39lOzX8wN9mv2pfZYqZLuzFP7ChdHvQgNr
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099006)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?deJmKrUh10Az7jXvS+zV8sJuVT5tBFkDfkC5onJfWIMdf7LwVBPtGQFBr1?=
 =?iso-8859-1?Q?y7GFHdWmOPDMzfLz8sihJmmWHolrtAPjWpSEk0pPf5RX8KgucpKVEXrWyW?=
 =?iso-8859-1?Q?ckZPKb+K5SLipxSydSrVjC7rIHnJzeFVt7EnfWbdHMVItC+585wFwu6IA/?=
 =?iso-8859-1?Q?HQJQ+gwGXs8XP/4M3oq7HhnXzv5MAongcjFA3n6uygNYA4jpMyCkimqtCQ?=
 =?iso-8859-1?Q?lXJbr09EYSO9pJ03ujU3kzgNAIRpnKq6BLgl5/luepfLVQ0Dr9gyP+LcC3?=
 =?iso-8859-1?Q?BL0z3rJXeUKWQ2M2lQc9krlPi4znwDF10uKj2LaSuW1GVif+XmHo7ARRzK?=
 =?iso-8859-1?Q?oY0hfyX5LQLM09B6yBRWh1oc2tzzq0tnXo0o00vCqU60j4LVuk5KWySl9E?=
 =?iso-8859-1?Q?aNXFBkjjDxA/4m9rg5X4AIJqtdiIrsG5+kp1zz/98nBHt9RcNdu/Z44Esj?=
 =?iso-8859-1?Q?/Egl3aHPkvWp317kxlg9CLe+bta9yA0rmCR9dMJGpLLa7hBp0b/BRGVA0Z?=
 =?iso-8859-1?Q?sq4JUv8WmJaPNPXw81GdgVa8sq+VgPZQtER/g8gULSJfRLEUsbU0DbILki?=
 =?iso-8859-1?Q?fPWkf+e72mTs+qfg9LzXcYKOuINg1NLqkrXo56NV7xv65h6UB52ZLLebwE?=
 =?iso-8859-1?Q?bA8sMjpuVFKs4jpxi5BqQzq5izphANUCbRVsqI2xQ0QZx9ojpWmY33nKOF?=
 =?iso-8859-1?Q?RJPZRPbmLqMg3vf4c3o/k2no6kVYigOjHbKmHwhcKBuMSef7d36xy4QfzM?=
 =?iso-8859-1?Q?hV4X1E6LKmRXiwPJDLqVlW58gfE/mnLlgx/DQsJvn3vCEXkYXZEZADAEas?=
 =?iso-8859-1?Q?Xpfrp063rrEnslGu31HXKLznKm+mimojBacgiB1j9Ia8IEBV5G3CepuZmp?=
 =?iso-8859-1?Q?SnZab7k+ouPqbqzlMRlgWyA4AGZRrZfNJDAms/rU6GMwgWAqxW7Hi680EM?=
 =?iso-8859-1?Q?mFIhsDAXyDRMICi6zTNL4UfH5DwDB5tBrNBK7Tt7hz4QP0y6ujBkaBgw4T?=
 =?iso-8859-1?Q?GTQ7seQvMaWpPC0aGfiwV3HrylAzwNSaytdC1lZC2xxrGujzq5D2z3mHHp?=
 =?iso-8859-1?Q?7xk0yQFtKlV63opEuttkUYbgNAJXprYa2owbpXgw0VI0YsUpGsLef+MUsU?=
 =?iso-8859-1?Q?a44FWPQmL1bH35gYNyqzm20WddpA/rnRmDpU/pTusn+TyFthC6b4yoteNt?=
 =?iso-8859-1?Q?/IJNZPvNM9srIz/8yHqVze4j6H4d0r6oFlGiU83vG8crIu+0tHN/eOrvw/?=
 =?iso-8859-1?Q?ridzmTYS2MUoZd/Wg9AllNsV3XwZOi37/FhZDL+4f21dbe6VJwmmsdsfeQ?=
 =?iso-8859-1?Q?OtgLiqiHmdGvXAF5Se6uBjiOi0RW2FpfPPndu/ztyvmJdANnpv0gOfYWUR?=
 =?iso-8859-1?Q?Td7MVAlZvOY7Tzh3TWa6pHslxgotdyI7Bm/KGdDmfR8fqroBAvMUQ3Tg7V?=
 =?iso-8859-1?Q?JGWz9vJpZ/bGe3F1ghRjzphSyrPlNLbRzxOhWo9lFiZgdKtsM73ddBO8WJ?=
 =?iso-8859-1?Q?56VRZr2xJJxnNHsfncjYAVGq0KmxqBPooBNUw1o9lblZKGEO1aJX8hPEB9?=
 =?iso-8859-1?Q?npJxGjlj7BJqZmZB1ZkjqgqMOxGkwyw32pnqj8b6SCsA5PokJbPpIDbcl1?=
 =?iso-8859-1?Q?dlg9Sq9d9C9J9geXjvpNTSFuhZWcdmRUQXhKOfAEaY1A13SpTnM9SsuwMx?=
 =?iso-8859-1?Q?/uvLQf6ZWv1KvJwQTa7efcojVHMUY4OvbkRslWNeOpGvWjdZ+y1oLrLBZl?=
 =?iso-8859-1?Q?LAVoTpO5Qn0+emLNX6HZ7T63CrMbFL96Oe+q4iZ8U8rwgv66pefiwNLIhD?=
 =?iso-8859-1?Q?TxdcOD1JCg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: MGC4zIRNJaHfBG3+5b9g+0BWeSUhNEEjkzu0QOe8gWSCQtl2V+ChIBltQs6tuTyC0bML5iAV2lFT0UhSk0zuFd3rOCQhacs/TQbshV0FKFQqxTReFJc+5aE7WsiNCVpyBAkUnHxZnCdgMwke9G9w1EfOhPhKrriC2ATrzbKOSDAVbeRldRs/lGN4xdSsxzeRL71mzRQs/4MpQ/yKLAV9+RTtEDR0s+lCjMGanJtQtFAeDEqoD1uodsq2LcT24B2Y3Vu+dGbTAU+hFy8PaaDAadf6B/+1kfQhY71/uY30GoP0UhYeABp9t6y6iVijq3VpDmIa4yNwvG7+PQiFemJxlg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95d1646c-fa67-4ce2-8435-08dedbee49eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2026 06:09:22.1779 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: geZ9ndYbh0WxAWptHEWW5cxaapFADBlUULe8YwZajWdWpgAbnCBZ+j7MoIgEH7ZH7arhqSlzF/2e/TOwxCjq7f8RIRYQO1bsZaVxREAgCPs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI3PR06MB8706
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

Introduce Aspeed2700SCUState as an AST2700-specific subclass of=0A=
AspeedSCUState.=0A=
=0A=
Currently, AST1700 and AST2700 reuse the generic AspeedSCUState.=0A=
However, AST2700 requires SCU functionality that is specific to the=0A=
platform, particularly for interactions with its coprocessors.=0A=
=0A=
Introduce a dedicated Aspeed2700SCUState to provide an extension point=0A=
for AST2700-specific functionality while keeping the generic=0A=
AspeedSCUState unchanged.=0A=
=0A=
Subsequent patches will migrate AST2700 users to the new subclass and=0A=
move AST2700-specific code into it.=0A=
=0A=
No functional change.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 include/hw/misc/aspeed_scu.h | 5 +++++=0A=
 hw/misc/aspeed_scu.c         | 8 +++++++-=0A=
 2 files changed, 12 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/include/hw/misc/aspeed_scu.h b/include/hw/misc/aspeed_scu.h=0A=
index c30940ab76..904549465f 100644=0A=
--- a/include/hw/misc/aspeed_scu.h=0A=
+++ b/include/hw/misc/aspeed_scu.h=0A=
@@ -20,6 +20,7 @@ OBJECT_DECLARE_TYPE(AspeedSCUState, AspeedSCUClass, ASPEE=
D_SCU)=0A=
 #define TYPE_ASPEED_2500_SCU TYPE_ASPEED_SCU "-ast2500"=0A=
 #define TYPE_ASPEED_2600_SCU TYPE_ASPEED_SCU "-ast2600"=0A=
 #define TYPE_ASPEED_2700_SCU TYPE_ASPEED_SCU "-ast2700"=0A=
+OBJECT_DECLARE_SIMPLE_TYPE(Aspeed2700SCUState, ASPEED_2700_SCU)=0A=
 #define TYPE_ASPEED_2700_SCUIO TYPE_ASPEED_SCU "io" "-ast2700"=0A=
 #define TYPE_ASPEED_1030_SCU TYPE_ASPEED_SCU "-ast1030"=0A=
 =0A=
@@ -41,6 +42,10 @@ struct AspeedSCUState {=0A=
     uint32_t hw_prot_key;=0A=
 };=0A=
 =0A=
+struct Aspeed2700SCUState {=0A=
+    AspeedSCUState parent_obj;=0A=
+};=0A=
+=0A=
 #define AST2400_A1_SILICON_REV   0x02010303U=0A=
 #define AST2500_A1_SILICON_REV   0x04010303U=0A=
 #define AST2600_A3_SILICON_REV   0x05030303U=0A=
diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c=0A=
index 5dbf81c0ce..efe1d6315b 100644=0A=
--- a/hw/misc/aspeed_scu.c=0A=
+++ b/hw/misc/aspeed_scu.c=0A=
@@ -930,6 +930,11 @@ static void aspeed_ast2700_scu_reset_hold(Object *obj,=
 ResetType type)=0A=
     s->regs[AST2700_HW_STRAP1] =3D s->hw_strap1;=0A=
 }=0A=
 =0A=
+static void aspeed_2700_scu_realize(DeviceState *dev, Error **errp)=0A=
+{=0A=
+    aspeed_scu_realize(dev, errp);=0A=
+}=0A=
+=0A=
 static void aspeed_2700_scu_class_init(ObjectClass *klass, const void *dat=
a)=0A=
 {=0A=
     DeviceClass *dc =3D DEVICE_CLASS(klass);=0A=
@@ -937,6 +942,7 @@ static void aspeed_2700_scu_class_init(ObjectClass *kla=
ss, const void *data)=0A=
     AspeedSCUClass *asc =3D ASPEED_SCU_CLASS(klass);=0A=
 =0A=
     dc->desc =3D "ASPEED 2700 System Control Unit";=0A=
+    dc->realize =3D aspeed_2700_scu_realize;=0A=
     rc->phases.hold =3D aspeed_ast2700_scu_reset_hold;=0A=
     asc->resets =3D ast2700_a0_resets;=0A=
     asc->calc_hpll =3D aspeed_2600_scu_calc_hpll;=0A=
@@ -1161,7 +1167,7 @@ static const TypeInfo aspeed_scu_types[] =3D {=0A=
     {=0A=
         .name =3D TYPE_ASPEED_2700_SCU,=0A=
         .parent =3D TYPE_ASPEED_SCU,=0A=
-        .instance_size =3D sizeof(AspeedSCUState),=0A=
+        .instance_size =3D sizeof(Aspeed2700SCUState),=0A=
         .class_init =3D aspeed_2700_scu_class_init,=0A=
     },=0A=
     {=0A=
-- =0A=
2.43.0=0A=

