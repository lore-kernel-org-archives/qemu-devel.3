Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1B57C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 09:21:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whOSP-00047O-RN; Wed, 08 Jul 2026 05:20:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1whOSO-00046b-4P; Wed, 08 Jul 2026 05:20:40 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1whOSM-0000N4-NW; Wed, 08 Jul 2026 05:20:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jc3YlxqPUCj//UpIN/XV1v/mMrmPq75MkRAilvvA4VAVHqwyU9XWY5QqYjUA2y1GxvDrwTkOq/gJ9RteS/IUdy2nncP5040x0KMozo5UJsNPu7DazWcOW/lDf1810f7sNmPJ8B1zeKWlToU4vHwXOSLgXi97hSkfGUol1CP6JdpertJUvBGiNBqgPyhE4CxC+wUddYgfEpQEAVRYL36P6D9TfpCWyQQwJqMxMZlub2uWU0TDv5VSWhnS4hSBKQnw7FGg5VkNyDoJBO/Fdb/2RiiLg+YI5KUIV+8QJ7f7bRNPAXJt/EG5NsVJhv9tDnC41qIvnTj6Mlv/k6tfiWJtzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=phWshIajymTOiKZ0VXK6qPYeXvxldCIDTvO5+rzAxkU=;
 b=P8gNdqFSTlgH2uN30ayZ9fJ7D0TlF6IxorPusnv6RoNoNApo9uUdhiyeOc7m0PwFPDQHWwKt4XQjjLj9oxvpDcHUU8+M84jpUjB8Nv9dnygMUJ3vC65sceagm8Qg+sWbiz9znpvNPGKrey8RhwCpSD671XAczXcWM/50suUfyQarrdzCwNna/HLeIV/bbdvkmhqTYn4Mh6LoVJUKwNsWcj+eDjWsHsHQoHko5LyPaxMyVRqbG/NlmnaOyxZ7xYMjgaJyZgoe19OfoBHOyyR0sFevzoo4X2mPnPDjLyFIGHaKHKq9oqAkQyTVBAHivxAhUPDZU6SRoUcAtiV3KPPuzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=phWshIajymTOiKZ0VXK6qPYeXvxldCIDTvO5+rzAxkU=;
 b=kwFy2fkBBK5wiBtXnLS9iT5LPuYj5c7yIcc6Qn+3qoAwbjZ8I2OZSA9iBLp040DrCdH+blkFBAupqXEoOeE6JS1W5VXoiHIXmkJIyft8fAs6R+vhtr+kFUU0yE80JO+Enjv6BHhGwA7ZANu5AfB/oQPkZYoEbhI88PFzTThkxgqzeF6lD2fJrMC8rmSlzFnSE2Gh7Q/D49LG9/mAJumpF0yvKYZqOHTMSFMcUbmuuTyoRlGt2gChla+iQfS7bSrXP6rXD1ziBFqAq5EOKU1ek6GVOjZ9cupSnOj1kQ0J3qHtKoKvPi4XxDXRyykYKCYDKCDzF8QuPKDFxjj03XoW5w==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by SEYPR06MB6311.apcprd06.prod.outlook.com (2603:1096:101:13a::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Wed, 8 Jul
 2026 09:20:26 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0181.010; Wed, 8 Jul 2026
 09:20:26 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Pierrick
 Bouvier <pierrick.bouvier@oss.qualcomm.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v5 01/10] hw/arm/ast27x0: Start SSP in powered-off state to
 match hardware behavior
Thread-Topic: [PATCH v5 01/10] hw/arm/ast27x0: Start SSP in powered-off state
 to match hardware behavior
Thread-Index: AQHdDrsC6HxjhGIcgUy86gwJlJuxeA==
Date: Wed, 8 Jul 2026 09:20:26 +0000
Message-ID: <20260708092023.3826159-2-jamin_lin@aspeedtech.com>
References: <20260708092023.3826159-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260708092023.3826159-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|SEYPR06MB6311:EE_
x-ms-office365-filtering-correlation-id: 44e92a23-a28b-4c2c-b1a2-08dedcd2255d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|921020|38070700021|6133799003|22082099003|18002099003|56012099006;
x-microsoft-antispam-message-info: Qp4WZhVC+7w0k3O4Rv45xiBRoNNKEJ4TMhCRG0p7wDpElYVMO0JSG6oGtHaiozwkPwcm++C/jLOFpvWKMmuzZ37raQtVNrYLyAA05N78nbdP1/GUoOqatGyaVYgumbBS3rx4FG0XzWvTf6Do6zORB3+PGmB3y/GLv2Nehmj81HR8vcBv5jFyz/c9qpm/M4cLG/p51Id/w9AQsBEDKccBbaCQ24R402bUorAQlSLXNltgkZ76vuDnzFRtovdXkSnpsnJoffBOQoK/y0WaZKitI9ES2cfu9K0t8JYDBad564G1pZ/wybadI11Yz0HbQpfbdVehFWVSRzvUFPqpUpdH8uLm24HO9xb7/JanzAQOeiBo52e6ZXnHIkstHpMG+9oBPtVV4QZn4eEiRHLDyW6CXQ9KOvF1PFQh1qRnz9Myb8eywQ3JRd0076W2duMyhT2YV3gVxjVQzsP30O2bkSKI1b7uUqOY6lf6hw2yxsUVzzxlVhUM3iLzMjMpCE3Uhd+yxUD75Ox/qoq8jMXOLS93gaQr2hjCVdPNzc1igFd8CQPzC70Si7okhKw5QYap3uhBePy2N4/YWUVO3AHfQGf4hos2ybnW2pq/iGvFDyWz+x3Rzu7ggSYslm/K/YaiFtnVXtZAePKt8AGHAQUgwwN8LWC4fP/BhNBK8lkaNn4e5n6z4j0cLb1ElXV80EuHZQrYupismkOF8uCUnvWk/hEES8qW/l65y2JfvpykQRWNokDfY+Ex/2Oy9fnBDUkJF2g0
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(921020)(38070700021)(6133799003)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?OdMLHEuxdI6k38tesSbX2kk0HNBonvjROr0slOFD+GaP/APNsxI3Vz013L?=
 =?iso-8859-1?Q?YVPBeFjB592J3H5oeGHR0ve8qrj9FCPz/T6M9oRS+GVBU3ovAhjKMgDdSW?=
 =?iso-8859-1?Q?n0dxvepA/NCvTq03euWQntyXimEtkZJ/Gr1QBnmgGfOv41EMcGSccxGR2j?=
 =?iso-8859-1?Q?I2xpN683iDrN15uDrHpbTd2QZEi1XAlBZ5YI1QIlV1qcnVgUbPKxNzAYPs?=
 =?iso-8859-1?Q?zdspplIhGcyNEn+NWqn5KFYDHYtUIQKHFsvarQlD1wGhQUCs2qoG0Suol5?=
 =?iso-8859-1?Q?jjN2yG4h70cAIG3UsjVm1DPdHOeeKtlTqBVe0VNd5++bbDNo1Rlcuaedh4?=
 =?iso-8859-1?Q?eUsrFIu1465QIG6Ru1wdT4p8jn2P5UDJX3TqwhdfQOQbofXddNGTEG2/9Z?=
 =?iso-8859-1?Q?cCcFwarsfS31xEb8stNFrmG9JNPQYZBVLGnE8GmEifwSWRjf8gHCf69deB?=
 =?iso-8859-1?Q?QUkkfVJKpUB8eTxymJMozm8JUKlpHDxjmp2NmEfRAiSAQiolUNqWi0VmeM?=
 =?iso-8859-1?Q?BRloW6Vk+pR/MaJErkVCjickXcXuuRTRjb9sdJCyc+ed69k3XxThKiW9qA?=
 =?iso-8859-1?Q?cPkbCfUQ4kUSAkhMsNLKZWOqwlqDuGXin+xf2lOzguS9PXdT8nNO0GeDhw?=
 =?iso-8859-1?Q?TL8TSl2QUFVRS6pN/CGn5af00Ht71kzt3RHRCyFkPMeC9LDIHEsdPmYvL7?=
 =?iso-8859-1?Q?s/sA+phLmR9qb4Zee9mxsRRfDV2WIfkE4FLqtScL16IfYwI6m1tYcslKUo?=
 =?iso-8859-1?Q?lIgHYJiwP1aiPlQ9yomEBiHsO4wJrDSoywIyVnE5oX816YYN/MH4IhNkxs?=
 =?iso-8859-1?Q?HfECnXV6r+BwzroMJHCdPmqWaZOaafR1ymt93Yvvgv4L1mxdRYp7mUWnxR?=
 =?iso-8859-1?Q?dI2XOAa3Lg8JVj9HYaAU2u7n+M/x22Sgghye9L0eIj+LiN9UnWjcS6osWM?=
 =?iso-8859-1?Q?Fm7X3Q1TzVhd1dHh4z4HkFpZM1w2JqQlYEWfreX+iIxpXuiURBhjpYYVT+?=
 =?iso-8859-1?Q?5YvPW9CsDxjxy76YWPoO6ajhc8CqXpoZSPqOy2r1tRIewxhpQCcaHV73T9?=
 =?iso-8859-1?Q?e8iB0oLXv8QEmyctuLZfE2+dFtNtwhiScXyLEXkhW6cd7ap3z1GBzOPYOl?=
 =?iso-8859-1?Q?4X6cRxiO7UqzUnv/V3m9KolWSmNCbIWxCD5zSmRmcKxfi8vtz0MQn4XuMe?=
 =?iso-8859-1?Q?NxCo4bGryHEu1B7UFhN1nx7GBc6HMNbyeJ1CRzpoXJWA83XlogM99u1dZm?=
 =?iso-8859-1?Q?wJT6mVvMPrkvGESiQHbmS9FzBLoQNxNhi9SU6uq71Qp6OTI3k2SKnHmqyM?=
 =?iso-8859-1?Q?CkKXFRvpDJwQWd+F3gCClWQfNfL94HiSq0XLL5g/1JJo+oi6SFnthyNuP4?=
 =?iso-8859-1?Q?u4RFlG7zKrGt9UaGKv35UAK7rWePOt+eru4JAJPq4GU6f4MCzP3/Dhfylu?=
 =?iso-8859-1?Q?VQPkv7oxXZjs0kqVzjo3w6g0B6Tiz/0FjMsCZhtbiKPj/aI5cFOvrpekzd?=
 =?iso-8859-1?Q?LX396c3xUbOK+rZ3+a3Isv5e9w2E+QdACsXypNcyE/wbVj/FmKb11R2FUv?=
 =?iso-8859-1?Q?zRQLK3LPNTTieVLdSLT6jfEQg+Ghk9UmQggsDHjYdQD6aLLeV87DWibB0v?=
 =?iso-8859-1?Q?yI3Zzklfkolqrvp6wfMD8elxyNJy1CFxJCENFtpHmsC8ShZbZ0Ngum8kup?=
 =?iso-8859-1?Q?AptGrO5jSBRezIvtgfpvlk+Bk2IoM8NZTYXGj9DEyWdo4SfI7h71/CnFXt?=
 =?iso-8859-1?Q?am73ZNC1hhxpZuzjDqx1uC28xxPhBXvR+RVV1H248FGknAkeqtjmbHcnBF?=
 =?iso-8859-1?Q?zFn2/dEfGw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: pkjcYVKIuOFUym+xVnz7MkwEyAPwNFte1po3LcGbjAr35GOSpg3eF/ENolprqnCN1cOGdGC9upqz2ZBiU4FWC2j6gO5Ihnd8nI3/Pw0zSpb4kZWbk1dMUM37gK6RZ5+19+Q8sRMw3zvUG2pOCzLuKA1cJ7VUko6fkFp0MnzWEYsfMtewh+mJ9uJr1Ew/7D+gVYYMO0e1AMYbmUehbR13ww9wiyaf17A0l1bTRGuqOooytPUNZunLfIVW7gocuncTIVah343Ed/aQv10AU9Buie/phNS1g0FS5LXQ/YYem3thFCGk3+j+02lKi5TxPpBdAP2pQ9yCHwq52eCrXFddvw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44e92a23-a28b-4c2c-b1a2-08dedcd2255d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2026 09:20:26.0354 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /CcfpzjPRpHHHrpJaORrE/+e6tpleJ7F2vPN9/+HpTM6GtsEhwubvD0SPFgzCHzT/zirteW5/mSMYtIETxVA4LR0yctmLfXqoR12JlfbhQI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6311
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

In the previous design, both the PSP and SSP were started together during=
=0A=
SoC initialization. However, on real hardware, the SSP begins in a powered-=
off=0A=
state. The typical boot sequence involves the PSP powering up first, loadin=
g=0A=
the SSP firmware binary into shared memory via DRAM remap, and then releasi=
ng=0A=
the SSP reset and enabling it through SCU control registers.=0A=
=0A=
To more accurately model this behavior in QEMU, this commit sets the=0A=
"start-powered-off" property for the SSP's ARMv7M core. This change ensures=
=0A=
the SSP remains off until explicitly enabled via the SCU, simulating the=0A=
real-world flow where the PSP controls SSP boot through SCU interaction.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/arm/aspeed_ast27x0-ssp.c | 7 +++++++=0A=
 1 file changed, 7 insertions(+)=0A=
=0A=
diff --git a/hw/arm/aspeed_ast27x0-ssp.c b/hw/arm/aspeed_ast27x0-ssp.c=0A=
index e03653086c..9c984d23cd 100644=0A=
--- a/hw/arm/aspeed_ast27x0-ssp.c=0A=
+++ b/hw/arm/aspeed_ast27x0-ssp.c=0A=
@@ -192,6 +192,13 @@ static void aspeed_soc_ast27x0ssp_realize(DeviceState =
*dev_soc, Error **errp)=0A=
     qdev_connect_clock_in(armv7m, "cpuclk", s->sysclk);=0A=
     object_property_set_link(OBJECT(&a->armv7m), "memory",=0A=
                              OBJECT(s->memory), &error_abort);=0A=
+    /*=0A=
+     * The SSP starts in a powered-down state and can be powered up=0A=
+     * by setting the SSP Control Register through the SCU=0A=
+     * (System Control Unit)=0A=
+     */=0A=
+    object_property_set_bool(OBJECT(&a->armv7m), "start-powered-off", true=
,=0A=
+                             &error_abort);=0A=
     sysbus_realize(SYS_BUS_DEVICE(&a->armv7m), &error_abort);=0A=
 =0A=
     /* SDRAM */=0A=
-- =0A=
2.43.0=0A=

