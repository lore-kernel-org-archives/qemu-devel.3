Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C4E2CD5BD1
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 02:51:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTsjb-0003EQ-Bk; Sun, 31 May 2026 22:50:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wTsjY-0003C7-MU; Sun, 31 May 2026 22:50:32 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wTsjW-0002km-Pp; Sun, 31 May 2026 22:50:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rB/6o1UaKCkg3L/QPuQkSWIjOJIxAlHohG2vnJ+Mqtnfgv6r8T08UKm/7DMGvlO7xJRIwQeEzycsLQkg8/M6qFnUDpisrzjd2hy7lpnyNkdx/NbrNeldP7hCJRJxfCML1fC55fuM4rmI8Y0PA383Wle7fCOWg9UjbxRNrT/BMhI6Ms/9zIS/6V88GgOEEvoz+4EiBDTjyso50aCRUUAWXATkJitfOm+tj9ChSgYhEuHhEdWH++BMgwrd9ziMXi7VsqTOOpuNLREUUrKz79BAifDrRoV/7yqnVuhwrreb3Ozri+ikuHVROTYAdeMe3fv0yTbrC4+QUSKnTlWRSkEWYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I4/moiVft9qujcDU7uEKoRHQtsNJZJb8ZbNUxA83c8o=;
 b=coJ1Koa1PVunEg9kxNXR3I+dNwqKw/R1qe8XTW2RYE5ClU+neniyC9SqXA8bk8pIQXEh9VnLeiM/fAzQ7F5+ZILbuYjN7ZQ0Ie7Tl0scqfCTw3xFTo0yWD9hc98AoOM0sOSW1ftK8+tCVDGdNDaEXJXBwt3V923rVPDaPSOqHJskZVIqeqFQx9VTsbzwDh3zekkXw3JlIGydgwYe3yR4/w09ZXbZ5ZXZ5YbHNRC49ngpzDLjHHJBzPRkQx84FMUHl+/i7QLCag8vXwqClgCQ3FBXYnRoQklXGmfAuwi5nOfiSJwtzeiSxWpD+qZYvjp3tgRHbr54cU1v/VMZErttow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I4/moiVft9qujcDU7uEKoRHQtsNJZJb8ZbNUxA83c8o=;
 b=fc9EVbu+J2xICEaf40mi5N0sZPSLUHhfLLzJXlOgY0dWRXIGIaXzmi1XO+EErC2czCRVR/N0LweY4ZBtGSlhMOW2Yu6R8URaC4do46k3y6DTVirHMVpBea6/0GJAgtZeyLZldXs4xACNmbQJnKwNUTLlbey3E3bEyNLoT7sw1jLZsL3Cffvtz8PGWb9S8JSpd40vAxM49XmMe1mG8wsdARUFASa33nivZPoFBNp6+6iwtXzr0gmC/VuezAl5UIZK0Nn3eIy+KRQ5nvhHMqomJkSoHmHYUoRqhaM7oAyQOz3vA9hu6sywx1TV1JjXt8I/JZ/dbo/eO893FDMBw1nepQ==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SI4PR06MB8876.apcprd06.prod.outlook.com (2603:1096:4:2ac::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Mon, 1 Jun 2026
 02:50:25 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%2]) with mapi id 15.21.0071.014; Mon, 1 Jun 2026
 02:50:25 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Alistair Francis <alistair@alistair23.me>, Peter Maydell
 <peter.maydell@linaro.org>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@kaod.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Ninad Palsule
 <ninad@linux.ibm.com>, Jason Wang <jasowang@redhat.com>, "open
 list:STM32F205" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 16/24] hw/rtc/aspeed_rtc: Convert to DEFINE_TYPES() with
 inlined TypeInfo
Thread-Topic: [PATCH v1 16/24] hw/rtc/aspeed_rtc: Convert to DEFINE_TYPES()
 with inlined TypeInfo
Thread-Index: AQHc8XFl79Ig+J0SpEKM/I6HGGNxNA==
Date: Mon, 1 Jun 2026 02:50:25 +0000
Message-ID: <20260601024959.2347639-17-jamin_lin@aspeedtech.com>
References: <20260601024959.2347639-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260601024959.2347639-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SI4PR06MB8876:EE_
x-ms-office365-filtering-correlation-id: ade77e43-f5f3-4dee-1072-08debf88880b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|56012099006|18002099003|22082099003|38070700021|921020;
x-microsoft-antispam-message-info: DrBwK6BSg9QLgAUI6uX03RnPXg0KJRmA7dtGh93RAYImUAzBzc3Hd/KeJKeP2lhChMeUmEhp6aPANdlkCNH30JEQZtdU/+x8PREpOpOKuNXl42B+ahsgA4Hf2zw5ElR+Ncu2vk12BBDoUPIVSImr+hUVthY95Sgo3GUd8z5mRszpBFNXmXsPTsamqSr/vyN5UZH21gRFPduq8JkWjkROl/eY5Pehm7pC84qHnYbXnIUGDmS+Y7DsoqPYz1CCIp3DvAJLyeSZCH/T8pA077cu+D1PJH3bVEyGmMITIMpk489rSp873TyAw3jzTEyHPjxICAVsB/lCbTYXIaBKOQa//fUxTCPUaDl5JVLWYrGmWGOESdwI3I+yYMbE6wI8pcDXdTBrmEff4gA4fmjLVbNOn60mtG3O/bBIEz0FGBOYAlOhwdIL8sxEQDD9bxPnQouU2NGYccQJVSpQqirnZzMOjWNKNazGokJox5/nfwji5iLgLWXHMC2qRLMRAx3XEiNsBVhs6ltUJyeBU+Tdzt7Tlb7jUSU6Qrqxhj9zkXZsBFuHOtWPW6iak7LvXqjs8CLTI2y/xO0/qCq7Yw+cvDo6rY9bWPbuEuXVi1IElX5WhJAgT00TM29orAaBC84WnrJfwJ8AHxFddbh6rMVg+hobACaRxr6OXksIvoooSMnindJE+ulmjqqACeCwr0y/kDebcrv2IN51LMhpX56IyVX/lWVMyYlschNiK6gvt9I8ezwqJEQ/eSvYXGhuIHHhhPy5FxpY7EQFAyy5ssVExrddbA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(56012099006)(18002099003)(22082099003)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?5GpM69a4StufS+GESRNrsAjX+SiU2SpKQIY+sfD/qM40PspLHfunMQyegK?=
 =?iso-8859-1?Q?zibGnx2mkk0uoNUGSNDvuBihaDIYUWsSF0rRa9mra+myoqJeqvjEQcyHzK?=
 =?iso-8859-1?Q?zkMFXud0sKgdsy+kUfcZeKKBtHtE3NMCM0Wp/Hk/jG3n4zAZ6+EaP5sm8w?=
 =?iso-8859-1?Q?lM19S0tVm12hq1sZl2OTqNO+rTFcl9up03/npEijFKlA7YZmZU12VQjR13?=
 =?iso-8859-1?Q?hBHVl75yRhoIx3uls8E3Djhrs6n7XfRAH+OmXqZVwwKJlk0betstnnnlhh?=
 =?iso-8859-1?Q?mG3dtqMHADnLU4C2ZX4PbG03Qj+nrEjI1Kis85GeraZ7bIhRA7mewxEF49?=
 =?iso-8859-1?Q?48cB2pf40DlmsV1mWwcgK6PRwuUxAbuBLELFDM6kY+L0I/7Pwyu91SRu5L?=
 =?iso-8859-1?Q?rb9tkV+m/jmYxqpZHW0SqIfOI0aMXOuIe8gs0Me8Xco9pqqTLgRLBj2I/N?=
 =?iso-8859-1?Q?4Bu/mjtnEBTAXXsUGY8MqJ/5R+ex/S9e2IbMe1dFqw2AGzC3IR4MGZUoA6?=
 =?iso-8859-1?Q?TZHQdZn2lulcthJvFySgNOu+jVoL5R2+wxotfUYSfHhB0WKFpTC0YzrnXy?=
 =?iso-8859-1?Q?Q/mVwUxj12TUuJp9WfncgW8fnmuHxVWWjllgDb7jaM8irsg3eAmDD6s/g6?=
 =?iso-8859-1?Q?qooj+qPJzLAmb+AY3pK5p8fE/MYq0MFTQiM4ld5g00cutBFV1d193TA7Rg?=
 =?iso-8859-1?Q?GWzw3t4otuxUZEXi2qgPBzABOtEBXegbkJg14shhkpsdEI7/eZHryeTR8A?=
 =?iso-8859-1?Q?TDaq7Gg3djz+wRmf3H3ivK0g9F56kzT1E/YUuo2/Wq5aDnmYv209Q8+Xv1?=
 =?iso-8859-1?Q?MV/snS+17KSQ36TQLulYS/kySIryG9l5wVR1WITWfEIWI6DDK3HRSwgHkc?=
 =?iso-8859-1?Q?CL751df0/H59vztITbQa+pJjmBhQYvglzYxBZU0xrTKQQJDIzbs/JiYQIJ?=
 =?iso-8859-1?Q?G7L6kRahDwANIolWjK+AYbrUSANyaFT/fjgNxW/FS/75QnfOj5fItr600T?=
 =?iso-8859-1?Q?dzoYl87kZAJDHq0OCHnwk6yfQfVcnBc5W/1rfb3QNrDHTD7ZE/HTlblPU3?=
 =?iso-8859-1?Q?JQcW1DEign9M8524BoU8zsKu0DNgg4eepY3202DgX0l9ReKXWmVedSSMxj?=
 =?iso-8859-1?Q?k+zqiB68gl20I/y5Xlb43tKUxgMlSimS/EeEmtJ1fH+p4JWaAc6z8CwVU/?=
 =?iso-8859-1?Q?7hbX1q0kdFbR/H3gxRNPRhxCWYw3HIY/U8xcOPHK6JC7DJ7pvrvo/LnHaM?=
 =?iso-8859-1?Q?ywl6iIdI1SSZBdvjr8qa5e5Qu/wa0TpK1sRhNL/4AIyzKVRxHpp8aHv983?=
 =?iso-8859-1?Q?alZ3Vo2L8NKoyDTpGPfoThi34LnJf7NNr+Z7RyGo8J55VT5Xx520aoS6+r?=
 =?iso-8859-1?Q?PyCgFInhkGwUF7IG5aQyAaFMkuBHhrl3f+4vFcn/2I8nsgsnuVbTO/OSdr?=
 =?iso-8859-1?Q?N5LmdJ58K2HDW5+zlyDSrH4iRmOcZdxcZ9my0Zxgd58fXbGQinul7O8SQB?=
 =?iso-8859-1?Q?gKmQ2KXe/2ePh8MOaBNxzsjq6clgtWi288QwHSafTZt3aDQOe40ireS7Sr?=
 =?iso-8859-1?Q?tEEAAm0NVtNHpRj1gyFVzhcO9/XmaBU2K87vlMcxdYZKtzQZSPYnkTUAHW?=
 =?iso-8859-1?Q?q7v4Cg/EIEHyNVooCWJRKMoONaYGu2EIXEafKAmJwYEMosxAW2B/70L/v5?=
 =?iso-8859-1?Q?gQxcawOTLERndMNthzC5faenl0pNo4bakV3E99Tq3/Ru/SPHBG2ziFXIXG?=
 =?iso-8859-1?Q?OcjB56wcCf22owyjqytbaMfg/NBV7fxkXxcgiYLLg3Tl6v9HZe6V6DNgd2?=
 =?iso-8859-1?Q?Rfc3V4f62w=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: iHZZeQDbFwHsrS48zMFNuGseLuA1d/LtHyN+sC0AFf7DnOTyO8hPuHwioXPm9IWcKvQnAoRH+ch/4Kjw2OauQWAEWCapn8LJGjd6dFiZpO9RjhLfUfK/Q0rbFVeM6ipPsOAdAvnHXCBYMlzHioumVPSGagLH11HxphCDbdi2BHH5CbAbUlrJlMxdJRB37Lv5pQa24ndi1qSKH4kCgEUn1ttTt95LOvoCJXbHe5TmQvl3RBrZK8m/gKrqGDGkaFwgbW9xUqR0Qm8Br5eW8iM+34jrAkxWcBaP+86qTT57OdGOBsW+SAy8GDcIgFq5i3WsA7N3g+XkZB+JfQROFUIBYA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ade77e43-f5f3-4dee-1072-08debf88880b
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2026 02:50:25.1474 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U8yNWZDBwZ70fyMq0s2pdgdff/MSV9hmL3hnGjWjXnZ3h3Skmj04Nq3EdZDjFfNIPAFT9DTQrU3T8bYTizn4c8GooGs0JtcMV+iWniZP02k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI4PR06MB8876
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

Replace the legacy type_register_static()/type_init() registration=0A=
pattern with the modern DEFINE_TYPES() macro.=0A=
=0A=
Inline the standalone 'aspeed_rtc_info' TypeInfo variable directly=0A=
into the 'aspeed_rtc_types[]' array, removing the need for a separate=0A=
declaration.=0A=
=0A=
No functional change.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/rtc/aspeed_rtc.c | 19 ++++++++-----------=0A=
 1 file changed, 8 insertions(+), 11 deletions(-)=0A=
=0A=
diff --git a/hw/rtc/aspeed_rtc.c b/hw/rtc/aspeed_rtc.c=0A=
index 5245f3f956..34d9fcfa36 100644=0A=
--- a/hw/rtc/aspeed_rtc.c=0A=
+++ b/hw/rtc/aspeed_rtc.c=0A=
@@ -166,16 +166,13 @@ static void aspeed_rtc_class_init(ObjectClass *klass,=
 const void *data)=0A=
     rc->phases.hold =3D aspeed_rtc_reset_hold;=0A=
 }=0A=
 =0A=
-static const TypeInfo aspeed_rtc_info =3D {=0A=
-    .name          =3D TYPE_ASPEED_RTC,=0A=
-    .parent        =3D TYPE_SYS_BUS_DEVICE,=0A=
-    .instance_size =3D sizeof(AspeedRtcState),=0A=
-    .class_init    =3D aspeed_rtc_class_init,=0A=
+static const TypeInfo aspeed_rtc_types[] =3D {=0A=
+    {=0A=
+        .name          =3D TYPE_ASPEED_RTC,=0A=
+        .parent        =3D TYPE_SYS_BUS_DEVICE,=0A=
+        .instance_size =3D sizeof(AspeedRtcState),=0A=
+        .class_init    =3D aspeed_rtc_class_init,=0A=
+    }=0A=
 };=0A=
 =0A=
-static void aspeed_rtc_register_types(void)=0A=
-{=0A=
-    type_register_static(&aspeed_rtc_info);=0A=
-}=0A=
-=0A=
-type_init(aspeed_rtc_register_types)=0A=
+DEFINE_TYPES(aspeed_rtc_types)=0A=
-- =0A=
2.43.0=0A=

