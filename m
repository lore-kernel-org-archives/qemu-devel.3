Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ACCBC44500
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 08:47:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgeym-0004Of-Cr; Mon, 06 Jul 2026 04:47:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wgexe-0004GX-5k; Mon, 06 Jul 2026 04:45:56 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wgexb-0004bJ-KP; Mon, 06 Jul 2026 04:45:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SfvViue0fC6fRBSxNnSgnmavRLbry++gFvB2U9WE3Agp4GVs9AXj7OCjCEoIzONaF5R0I4LDt2MmvDOz40Z64TULPvoYfuJAz6YcFfzdgtsvMfolZJ4Jqm/HybRjOpDhlN/0+Xyl77X74+pk+gYnaXUKoY2yYzxF9F8enCB/Sz2cH2N4b/eNBO+ntrxOcuqUE7cFZ9TWLAa9OZ8r2CCHrvi9WXspnOnRjMNIr0wRY3ZxleQnuGVRqJy6G7fTRo5WODEKQM5Xk/KIUFjkVkBwdmKFmz8F6xuapkNn7oKvYKJ2FQPyEwT64imFwoCg7nGNTIF8PGB0wW2jtvVRNSB9Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e/qNEMlBYKXs7OanTSaDE6jputRLjrbxHIDekZMiIFM=;
 b=FRe1DmiB1magLBqX8FjX22oNCXKiM30a0k4uskiIhxmC+IfXQ/Ue8TKg0+3gWGLUY6STvHwp32dwTAtTKUBhEiLapIGjk5oBRPUdJ2IeclnlAlfS3SoJ6+gzvZU3hGGN4JJuUE4zM33PVJqmTjN6QW2AwkxINCvvu83Dd6TDq1QBNwA9755uGFiJKk4hruTiqN8WdLnbcP0qz2fXUQdIfI8BAgbCaTVN+tVLHj0fjG6RuMFFE5ZX7EjLtjozGtcrz6Wp9DQI8RBSM4QYribVjDvE1R7oRpYf7W4kHW2SCXsPtJq1CCe3CSBXFEMxGk+rM4YScHJJ3ArjRcPNni5WEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e/qNEMlBYKXs7OanTSaDE6jputRLjrbxHIDekZMiIFM=;
 b=kWmQJuLyEAi1UuydCKKKz7kgDB5SZQN/cU+8kA1QW/BwuUNQwZ7Z7KVfh3s4RW6WDcgRbL5pnaggCY6HlP43COXXPlEfODObmLhnmTakIg6gsWe3Q+HSGtCSybv1PnMYctm3X0HpRGuUT/jsfU1g1WOZ/OO++W8gvi3sWFUdAxNqr7l/zQ96RpIfZRr3/5CRW1l/WkWaJ1JWjHH26QGWLp4dEjciLwVW2zaFWKu6rBiDEfugIdqiBqvxWd2trwKsMraEjM7zbSXdcpAMU4bA2Mxb7Hr2wK/P62MCMhHqJGM2Ny39IXJtcXwQoWttJ06hFm2+HGhnPeZhAAPoVh28hw==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by TYZPR06MB6639.apcprd06.prod.outlook.com (2603:1096:400:45b::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Mon, 6 Jul
 2026 08:45:42 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0181.010; Mon, 6 Jul 2026
 08:45:42 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 1/4] hw/misc/aspeed_scu: Introduce Aspeed2700SCUState
Thread-Topic: [PATCH v1 1/4] hw/misc/aspeed_scu: Introduce Aspeed2700SCUState
Thread-Index: AQHdDSPU2o+Kih7LyU+8uniP79/Tcg==
Date: Mon, 6 Jul 2026 08:45:42 +0000
Message-ID: <20260706084540.1988785-2-jamin_lin@aspeedtech.com>
References: <20260706084540.1988785-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260706084540.1988785-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|TYZPR06MB6639:EE_
x-ms-office365-filtering-correlation-id: 5be41f14-70c0-4783-756f-08dedb3af6af
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|38070700021|18002099003|22082099003|56012099006;
x-microsoft-antispam-message-info: mWxh53b+2ggsO2RgdSt2iC7wGMqQi2b8kjPvXunzk5L++UExg8837rV/A5B3DLyLeT4CIuFmZa/FXcXoS5IzmBQYaVMhMSQqpCFrSUI4pbt7I+xj1Aun6TBco5RHxUMwjDheA5RxivGXOujyWgtznfzPZ84ugsEh2VEd31Ae/WWhDoSGqql8z/3MlsqUzZpGaUD4qNoWiWA8Tb4lA6eRUOH4WeFLR9F50Ar/VwIcx9MwcQTRtdXY5Eow87ocXKAIcfpAS3/16IxO9ufyY+RNlDkH+Pn3TeoxX35CmdZlFWqWAbXkeztmyzZrQPTg7cz5+ZTCqwQrsVCm9Yy8AgFxDeVdp/5PdFB56U5MLzroDWlvI8tvUXjijoFf27H6E1muEN1JgYQB6tBZt/o6EizN/SqTgDHsyXwBV09ckUANjAk3DQUw0jEiu6EbZkGwOQTnbwf7QQuCbZmeXXlMfo4aF9/YQSCN3NVECk2IXfdtMk0zH1hnxIsVg1uFg5G4jjJmbP0a9GY/1H+MI/pchLwl2vKaB4S2Ir5pc2dkfVMGFBYl53CBqp7XS+K1na7YmWC2gRm9ZY47cQ/R0fPDj2kRfi3XveRBK89DsPCbaS4e/gWT5F0Rg6f1Kq7BvsZMiLFbdRxYwiF6qzXQMsUdK2XSPGAmWR8Tot2bfciiV7apGPH19KOrf16xK0djr7AIlJOvt5zwW8tz6ekK1pzrIKvzwyZEpvnnrl2hVtYMsRdifhw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(38070700021)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?IRcWcW9fYBJsPeDRQVcYPFD1bmiNSN274hZgeyYa0tIjXsucr95Zlyeq9Q?=
 =?iso-8859-1?Q?4XQdxmHL4FQQCJFObo/xWVnXB3e06ti58VoPGmTBBkw3Sppe2DWLNXWkYi?=
 =?iso-8859-1?Q?aNqn0LxlopPM0bUaA2B/ilx92uJJdHRvCBBejVLb5NilFkZelOUaJF9NyT?=
 =?iso-8859-1?Q?/E9r19GBSqwVfK9PsPrDfWtQA+0ZhduscEzgExNPmdsnGoudSdgoJayZcS?=
 =?iso-8859-1?Q?Mw/+T731Xc+6bxbocjFm7UO4R2THLjE1PV6a5663ieJVG5Vl6VmSI97p36?=
 =?iso-8859-1?Q?EbohXqejWNKODfrpLA0TLcW1QIaXFKOk3i2kFm5DobZiEf+L7EVxHSgMJA?=
 =?iso-8859-1?Q?j9dMQ9v2TIXWMh8zNwJgCzlsMsCwEyQoBpBzAOBFnkQNiJW9U30LG4wzWH?=
 =?iso-8859-1?Q?T4CRlbvD73bU2nQjvWF2HAXlfBr7OvGRb6CEcPNlVCsPmufo80at9BWoL+?=
 =?iso-8859-1?Q?psHEO4DWhJ6cdcLIP0AkUFqO5PPNqsmeUDyY0DYH4y8I1jHMXqmPEMxN69?=
 =?iso-8859-1?Q?+ufqbAQgAc6IL6efBgQHxwyz7fRY6zXEh+J1535k2ytxTbDk10/HUDAvaJ?=
 =?iso-8859-1?Q?LPEHBeHwny5C8eQRl48YnJvXski6uA60hbwsTyrxHCyz+PobSBS6gGl4Jx?=
 =?iso-8859-1?Q?sgb9cR7R3H4q9GSHp5eXuIjW+ggw9KFtXhgSwNxdNssjVWAloB76OHxPOc?=
 =?iso-8859-1?Q?wLqzh7s1//UGQxv47+ga+FSWoIU9ynuSelNLBvvM2m2jr4mBB+t//bV8vX?=
 =?iso-8859-1?Q?XSwCxvOsWhY0IeG8MUAA7gp/DkT7ogj3xVgMgMopuHm5+10uztVkKwkbiF?=
 =?iso-8859-1?Q?T6+LDZI7wgY70d1pj+yT0UsEztSjnqYGZjRs8Dq1q9B0jtTMkZuVD7JYm0?=
 =?iso-8859-1?Q?BXY/YEYxCJW/5cgB4ne9YL+tqEMEx9xk9bxEXSNbpmybgv/oMyMhwBQoKI?=
 =?iso-8859-1?Q?XyQl9OpGZq58WyEQMypjX4njPvsaM0rPyfBpvA889S7y8mxqzkuwfARYZB?=
 =?iso-8859-1?Q?bQ+3QWN7aIaCaeFvJV1AX1YMJo2wvMH3NK7rwguxzCSa2JKOubGRJVffaD?=
 =?iso-8859-1?Q?O7LzKlfYq9poJlq105xWvJK+pIRtmnqOJ2J5wL6HLfXciPzbfTx0b3nJEt?=
 =?iso-8859-1?Q?I5b0BSchEPtyBOxqfxho5qoOtllRw9JSl2CGx9g/8cVrG3qOsaKUbzRslA?=
 =?iso-8859-1?Q?OQS/8WxGjIysdHgiwB3Qf1BbP1RF5+ySnzs/1Mriyh2pfz7vaVPYF3xaYA?=
 =?iso-8859-1?Q?Z9BHtRZIvZ7Kuj8yAGUk9qB2iiiiIvC7gJkkFfMjmDtAYvEi3+9ubf8nDV?=
 =?iso-8859-1?Q?0eQmUgnhbOMKlJsYBa/7dV1KfWUlnLZAsl8qS+dpjnmm5/0CcX6KxL7hOc?=
 =?iso-8859-1?Q?D1a20vQhR8r/ahgra6yW4PMTw9Lb7TSebXRSY2djkwIFi7N2bOm+2H3Awu?=
 =?iso-8859-1?Q?PYM0tmVMfVksBUZkMRUxjgKU+BfeV0GPZ0RFZKAXLZ+iOQi2AEPgmZBeio?=
 =?iso-8859-1?Q?kMQfeSTYTZ+mHWvhQNdDRhmv1MaYv1fFvWuCHqJjK9fAenirhGMvXrxL8x?=
 =?iso-8859-1?Q?0OBB8MMGlpJ9mfk72Ud34GMC0nq8K9pGP51QJaeSXE3BGIoFLx9ha+ZSSn?=
 =?iso-8859-1?Q?xu8zI7U0E4r6Tt5ZNOuJvoiSUjKvbkjJLv+g8gWyPyYYhE3RQuX+QU03X6?=
 =?iso-8859-1?Q?OtfMPdUoED9KVFJJGhiRk9a8bTN9DL5xIw3RXyrt/W/KM5KDo+fCQ4R4T9?=
 =?iso-8859-1?Q?qPeL5AVJuALE9EbpFSndOVgJvc3UDUtFXpPhZ5ml8AhtA+qylgUdYj/XwY?=
 =?iso-8859-1?Q?rMPpjZbB5w=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Ee81nytw8jUCDugy49dMZc11dvirHfMMFi6iyjwtJrLhvpG3YO0AMkbRQP79JfqXvYef2QKIoV/k/H/IoS8VjWjn3dGk+fa7Kf9hnsI2VM/pydX/VzHhUGUq0SRTx+bpl+TQ8y4bLN0sW8sbgFIz25XdH2U+40+yQlotLN2+hPazNLx3SQUW5owTy2/vnqsQ3ap60V3ATnBrcUPouELMlbSdNqXrlGINSgTnvvKSCdv9zdejPvaQ4DlGf8hAxrN6yH6DgLZNzhIde7IHp3f1EasFAUuh/HaQ2JgRMK6dutCg5FFal6xtTzH7utmYMV9DLYjGPcb+Ywa5crm3cUw1zQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5be41f14-70c0-4783-756f-08dedb3af6af
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2026 08:45:42.6356 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NE6D7EnjDgGS23jdLwJo3GyyoOGh17QpHs++NGFs/RsovLDL0uc95gPNrqodbuNt0jWCV0O940zXBeBAHPyKg+oN4vdK4iOweRmOMwX5etA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6639
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

