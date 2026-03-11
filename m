Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D93FAFD064B
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 07:28:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0Dyd-0003Kr-5K; Wed, 11 Mar 2026 03:27:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1w0Dxv-00032p-9z; Wed, 11 Mar 2026 03:26:52 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1w0Dxo-00052z-A7; Wed, 11 Mar 2026 03:26:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ejmWWtbl/snev+tU9B6gyl1ocSaVDO/MGsnCXFtg+6FsNxQwVHTuZPHe5yMaIXQTIEwoExSthQLAvx8UVngX1mJ2j3IAClZICEHo8Ni+diSCkvNI6BMwECHvUHyTEqVKz8oU5QpvdSQUJ8YquVcDlZSw/Ixld+J7GW2j2EgNMWIltqGav54mZ4kmjgyYhZhOuXLuKJnAEnw4mi9HgKxy63i0qybHbH0CEqqqJupyZo4Y+a5Lr4rki35nzwzno0OUQ/im5u2GN+qSGZycT4bERwPEu22SXsdzq0xGwyVBru1qgX549qc2dZvvmfQwZ2zBFhob/qy59DChUJl4ssC7gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ygTh7ToBfZdOi8sGPc/aXWfB1/AxJP2jnWfeTJmsqNs=;
 b=tKoNdTaiRtjPac8PsG024tQY+vIpm8oDojXBi1Pii9ftB8rieEMCAz+KzeSh4FITIpX/asc0er927R1BuFYh1jzlmPUMScxE+bbmQqu8UIIa1dTFMkNMyKsP+0Bv55IiBOiYxf6NdVZ/ZtxU9VKwdnHz8tG3o1RNTOx/UPsyToVy0Bn7iQw0IyhONJ3/DKYtukWee0MrbZ336gPnhrWPGnszO4IZv4Dga9U0aJirvE8UL4KAkaqExm6rTeHreAODlda4OMs9YMFd7a53gUEVcPd7fSTvqF8AWw7nmYFhyWrjSbycTm9BY8K54PSvLvLVndMH65IxNo06J+OmMavdHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ygTh7ToBfZdOi8sGPc/aXWfB1/AxJP2jnWfeTJmsqNs=;
 b=aSeKVuBp2gGo3Ew5Qyo6pNgzDAO3XW8X9mG9K5R8EH6OzW6bzZPv6/6VNnDRLkcaLAMwF3M6xMFY2z8Kf+xVRbfugYIP+RPk6YTqzb/WPqKpf8RpvYl7nCwAv49DlbVkGDvMqNo3UfGUpnSVNHf5i3/VdHJB20SZGpUcYehUsreFlsEVd+oOsRbhZxDGC24ZcJ+T6oDaN0FJ8SOC0RJmrdwhOUiZlhQTBQut06199KAW8qLnywaLNo/rR1ZAU6u0AudE4Ova+iZXAcNf1OnTPGFaiifnfNFbn9V0LrVEnWuTQoMdRFpExDZPmvW7QuOjNjz1oZbr+UsvZUXBt23AYg==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEYPR06MB6082.apcprd06.prod.outlook.com (2603:1096:101:d7::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 07:26:31 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 07:26:31 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>, "flwu@google.com" <flwu@google.com>, 
 "nabihestefan@google.com" <nabihestefan@google.com>
Subject: [PATCH v1 13/13] hw/arm/aspeed_ast27x0: Set EHCI descriptor address
 offset
Thread-Topic: [PATCH v1 13/13] hw/arm/aspeed_ast27x0: Set EHCI descriptor
 address offset
Thread-Index: AQHcsShhN7YVfaaZwUSJzeY7mANdLw==
Date: Wed, 11 Mar 2026 07:26:31 +0000
Message-ID: <20260311072614.1095587-14-jamin_lin@aspeedtech.com>
References: <20260311072614.1095587-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260311072614.1095587-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SEYPR06MB6082:EE_
x-ms-office365-filtering-correlation-id: c2b4e2f9-a415-4d1b-a9cb-08de7f3f8463
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: FmN5KTPaGVjy8c8n427/EHwhBVKeE73XMrlQz3Rq2aVstKDXvqKIgczfbv/V7XxYbyElasKKvtGRnHKYy4eHycjnn0J4sGaMQKZodJrC/cmHq/dly1nSYEbyXmZ0dWjRIegInY8UBHTbrs0Ryb5lr87RqS7+qdWSjHG/J0y3tZ9r6lVHLdjYPgJ9ir+l52FQ3iy5Iv3GXdjFY0iXlpVRPIjJ8M69hqQQ9OTtcHS+MPGQAm90qnnTTElb5SYmMQ46ceJ0Kgc9MP20oViZ1LAM7+7YRy/wiKYk+8RHKk4RKUAcEeEnN/LjxQBcOqCkb+wvfMmD21gNaOEy6I9X1q7RCmRdUGlrc0GMZm8V06pmVCr8vPEKsDl4+BU/N0IVFNz6Y+bb2BUEhQI20ctTn9GIpEaG4jFEdvIn3ZAXM8sFQ09jShp7AQA+bU5bJ08knCsKezOw6SGjaGFbhujgKLzTPtgNC1237YH6uCyB9Z9wZY0wQgAHhsA7Sy/tj8AwEvUh2HAfxObXhLEnF6P9lAQGVe6ZwCarCPjJiGw+MZz24ZepIwvqDWNAvKxhqvCpMHrnOQwejUmzGZ/4qjeVMFZXRE4rv+9DebyrJkMmSI/1JL1jIrMZP4WItKYSiSlWFLOVEKEATvpzNSuT41s3NMFe0PkWDYBThXyinGJ/J0mB2lj2w9LVIPYiT+PxyK/MiRjiVy/RV+UjOz0AGm650jcFbgnHISVLzHW+FqhiQ91bBvN+T0B4cDKiacQXeL5ytHDxPlEn2mDG27vazZsEK2bVMjJgD6SWb+hN2LUGFOVPl/c=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?5d8C3HB3z1XYWWLvzKmAMzqnrTeK2B7jMToqfEabwkAu1gHUvgoGAwa8kv?=
 =?iso-8859-1?Q?gRYP+n/n4rRwySz36/ffMiSgJ00ORu0yeFquvE9mRFP9UKoRkv9NcGucFc?=
 =?iso-8859-1?Q?VMAyjWWATF6nZITVZdLlsfTviiQDoG31zoWpq+ykR4lkkxobpCwSXJsrFI?=
 =?iso-8859-1?Q?vzYToKGaEXfQAxw0joCc4V1MZMa3zrz0A7hlXitQT4y/jLesutYk63MUIG?=
 =?iso-8859-1?Q?0yN/bttrGVejcz3BFmMfi9LXySP/PMQ6mlxvz8gRSv48xgkC38qs+DyJED?=
 =?iso-8859-1?Q?BaGrzQLIZ3S5t4t7Q4qOa7ufKlLtYxFBtGeda7tPc4B/eoBtGe6uJbNMns?=
 =?iso-8859-1?Q?ARpqvh3GV0Sl/StX0wLtNTtH83R+2k+zze7zttBarF4FqwBtG54zmON80s?=
 =?iso-8859-1?Q?ykb0dmiu9OyPAOo5wSQSyCwcAkr/Uc7wDtCucER8AUGBkJwfZBces/65I1?=
 =?iso-8859-1?Q?M+21XwhFNyLnibaU2v4Ds+gWYoDHVGa6iw+IuxlBPyZRaAYo2JLpH930jC?=
 =?iso-8859-1?Q?j7YkzBiMGLOHSGhZQO0QeYpFG+qAwt6CDpaAXUi9MMVoXnfG/TsV7cd0iW?=
 =?iso-8859-1?Q?YUH7Jy2ISCSb2QZKHi5WewigeWY3wZWKrtKtTJQIsHeZB3AblMGkbh9f2x?=
 =?iso-8859-1?Q?kVWehW437sj2lj8fO5tz8gTkUaQUC0CucT3ZJsI0wlSb97/OmSohVhl3DV?=
 =?iso-8859-1?Q?3ElsZLx90yWr5xpzv9QWA41gaSj4mO+cuqlyLjryJy4e1YHxrHNfUBXO7u?=
 =?iso-8859-1?Q?ty4vRwaeBe1itxE+OuvczJvbgSRumA236SIpV9NwK4AnSlKeAgLELZmEFs?=
 =?iso-8859-1?Q?SIBtdLYhoFkmq3pkoOIHIu7TrBYm69WAo6MJ0/XUu4y1eMthrwkfBz3/ZR?=
 =?iso-8859-1?Q?g+kngT5ujwEl0IntUODlxlxAQJPxIjsx1rRRfe8OLbrIy0ZYUsjUr/wVLy?=
 =?iso-8859-1?Q?tnv/YEzUTtjOgtKO32IRk1lHkq/acnQ+fl6qjKdKCKA7ukNGqUAU9dtJeb?=
 =?iso-8859-1?Q?MDhp3en3QkIn7/OAZ/Vu+tmnPCvA2TeWryWpGPI2fpZqCJRJKVc/EX7czM?=
 =?iso-8859-1?Q?OyzTlu3aAb9qGBD1cqQD2xE//VykzmadGwW8IkUX/Z/hRE3NoUEs4Q0mJ0?=
 =?iso-8859-1?Q?NvOi+ISQeVbFMKdC/QCgNOyU6h6/TXDD5JaLbQT4OTHeFarlp907nunEjA?=
 =?iso-8859-1?Q?ZFD+rEdDgmmAKllWLfbwgmd4d8kaaNg2fNeE6M9s8Zf7uJsJl/WDFe9Sfg?=
 =?iso-8859-1?Q?bIRLUkD97zCLTsbbTa/CdB/BmA/hDFN7k0xRqtP0X0q/JF6qGeAsPkfeyN?=
 =?iso-8859-1?Q?b3dJtl1vbOOs4d8WWK6kCA/sQBiTimglhVQojwoS9+RSCieVFnpeVd9uqJ?=
 =?iso-8859-1?Q?pYzv8WCO8TWfTGJ0m0myFQASLNIasU4LbVjkRtp5BXzK8vlQzePNJfMX0X?=
 =?iso-8859-1?Q?V3JWYh52VJBRXEegDpG4je+z4e5ZTcJvlpoTLI/0fRpSyLOQCT5f1Elu/x?=
 =?iso-8859-1?Q?mHig2txprUihsjUyY3xnVJb+1bnKd+NbuDmw0+c7rOd2zpprt6EX4isFhN?=
 =?iso-8859-1?Q?r3wHiCZN/5CE+k7eEloIYE9azU4Nj11KleFrvo0b5SNGC6gbNdNTWL28mu?=
 =?iso-8859-1?Q?v4jZ7pDd9yDBPwgdAtueDv3Izii3I8Al1lxTDG850K8ATStwfnTvx/NBDz?=
 =?iso-8859-1?Q?i2SbEt5GEymuRy+NsbsY8GD/IddJQkcFtJpELlyBWK6q9IsOO0MfdZN617?=
 =?iso-8859-1?Q?QAVAPZtFkLykrWJXHsYCh+tYGxJLFW3NYLkjGJnQwu5elI02vPCWZbZ+hU?=
 =?iso-8859-1?Q?EyTTEtWT0g=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: fD1NbO8zH1/6W3c4D4XLoPpI3fBeR7beQPzkvZ0HZanDUBwPw2kqLFrF5Dk+BoEqNPvEiqv0kDKM9F+E/CbSfBquab21sX+jnsfw2IxYDXbmW4kYOfdhlym+w9CoUN25RtvXpbkxdAM7fKvUm8aNiR7Pmel1E1IznGobJzp0ZWX4weoKooMT2fMjoI+EzpA7jeBnAKFwh/45HAI/kspaWTgDKFPr12xchWnsb4dM5hegaHNfkHj/Tji3nMLK4wn+yHsZSCa+Ca61UHQfPxArAL3soJfYOGu8+IAKzGAWkKwm/+L9LfzjT4x1FL5SvIUfHGo1Cq86es0XNFxz2sg56g==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2b4e2f9-a415-4d1b-a9cb-08de7f3f8463
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2026 07:26:31.3593 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TgKrYhaEYdYrw/MgeIDnlf0zunC6KEhnOv4GffQVrU8fh+VMzHk1pcy8a3iHIXGmz64HoD4TFcnYAMo+hEREbPLAASN8IUkZm8IyBGiLKVY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6082
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

On AST2700 platforms, system DRAM is mapped above 4GB with the=0A=
base address at 0x400000000.=0A=
=0A=
The Linux EHCI driver programs the segment register to zero when=0A=
64-bit addressing is supported. As a result, descriptor addresses=0A=
derived from the EHCI registers do not include the DRAM base=0A=
address.=0A=
=0A=
Descriptor memory is allocated through the DMA API with a 64-bit=0A=
DMA mask, which allows descriptors to be placed in DRAM above 4GB.=0A=
When running on AST2700, this means EHCI queue heads (QH) and queue=0A=
element transfer descriptors (qTD) reside at addresses starting=0A=
from 0x400000000.=0A=
=0A=
Set the descriptor-addr-offset property to the DRAM base so the=0A=
emulated EHCI controller can construct the correct descriptor=0A=
addresses when accessing system memory.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/arm/aspeed_ast27x0.c | 3 +++=0A=
 1 file changed, 3 insertions(+)=0A=
=0A=
diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c=0A=
index 4a1f7cad73..3cdbf78ac1 100644=0A=
--- a/hw/arm/aspeed_ast27x0.c=0A=
+++ b/hw/arm/aspeed_ast27x0.c=0A=
@@ -858,6 +858,9 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev=
, Error **errp)=0A=
     for (i =3D 0; i < sc->ehcis_num; i++) {=0A=
         object_property_set_bool(OBJECT(&s->ehci[i]), "caps-64bit-addr", t=
rue,=0A=
                                  &error_abort);=0A=
+        object_property_set_int(OBJECT(&s->ehci[i]), "descriptor-addr-offs=
et",=0A=
+                                sc->memmap[ASPEED_DEV_SDRAM],=0A=
+                                &error_abort);=0A=
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->ehci[i]), errp)) {=0A=
             return;=0A=
         }=0A=
-- =0A=
2.43.0=0A=

