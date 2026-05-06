Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A858CD342F
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 03:27:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKSud-0007pg-J6; Tue, 05 May 2026 23:27:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wKSuc-0007pT-34; Tue, 05 May 2026 23:27:02 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wKSuZ-00052y-M9; Tue, 05 May 2026 23:27:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BRTsmBMPJZ4dEY/vRv2mE1GJj17I4Vi7ueUl1BI8o36/r6XRRucRhruh9KH/fYz83K8MurL0nstfU3dICjUjO3jsXvBPxuG4Cuqn6qtYgbvSRom6HLp6RN4A/4QdyGllDM5TPMqRZtxZfbnFtPif8m+kFC0UAQU4HaEYGkuJxtlQ3KwbVld/vFIP5U98IXj8UVqPRA2r8B03RbK3FFSQ6nafzIrKN1P1hNotmmksbHu7UDsJ06e+eipjoR1cyX6a95v0wCUNkEiZYDBFEjNVotYvZ47tZL1EpSnIab1I+yE3eSsO7/B+Zp2RPsxCuOLUXlS7hvRrmalQOaidJyZRyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7i3YzYGoCDFNANobA1O5weyk1InX22deCeDRyPf91Rw=;
 b=rlwDB3Amnr7C2lx5mzV4aEZzWI6Tkiaonapf9LT4JuL7xiE4slJ0Z62Fq2EIa5cHZ8JKhbsqDTtlm6MiyYhW5KvnuwZAKnNvu/D7JyRzKYxIq9YB0lO+LhxF8zRTrPlV4r82VvZrTlZdyJ6VmCk8qZNuqUS0WrF0DKusmCz3qMwKbMvkLULOer+6Y+N7WAgqU6p7Dz+vLYaHUj9YdfFz6yS+nK8z7B2snpIXYEr97/R2tNnu9mkH4XH8Kq37Mp0ivR8vtDnpVP9tB2s1wtUoRyZA1gDQyNzjE+RcRkxAuP4q0SHkfDw0/lro01236FSuvNaygVDRdVS2o92pKwMQ3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7i3YzYGoCDFNANobA1O5weyk1InX22deCeDRyPf91Rw=;
 b=PmXCTQV9loG5P67vjRHZgl9WZQT+QWeAu5PpWAQl7S3suTBuoKSJl3RGmLQhEIWOgCo+3Q7vJa/KOKqdUgI7Z6YRlauDUY3gqYdK44hkBgrNFxKa7rW1AjysTAx3aaHwrrIGWD8n/6l53Wz0XUeaIhooEOfGuuOcnHJmggAjQ6sZEDUjVmjTvdCwUYioJOeMq/N484ZrAuEdIRKMClA+HJEDmfL1vCt+INf884M7usi2M5VEYIauORnSI/7BRe/TXmn3UpoIP4XPtpWHYDI6iDUxRpeI9MFVSXAONqvpAOUszuoCTZATCqwINX4vpMSCSJcnCFpiCwXQSPEjAepU5g==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by JH0PR06MB7325.apcprd06.prod.outlook.com (2603:1096:990:a1::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 03:26:45 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%2]) with mapi id 15.20.9870.023; Wed, 6 May 2026
 03:26:45 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "philmd@linaro.org" <philmd@linaro.org>, "peterx@redhat.com"
 <peterx@redhat.com>, =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Kane Chen
 <kane_chen@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 "farosas@suse.de" <farosas@suse.de>, "flwu@google.com" <flwu@google.com>, 
 "nabihestefan@google.com" <nabihestefan@google.com>
Subject: [PATCH v1 2/2] hw/usb/hcd-ehci: Rename CTRLDSSEGMENT default property
Thread-Topic: [PATCH v1 2/2] hw/usb/hcd-ehci: Rename CTRLDSSEGMENT default
 property
Thread-Index: AQHc3QgqzNLaW74uAEm3Jq1rhXKk0w==
Date: Wed, 6 May 2026 03:26:45 +0000
Message-ID: <20260506032643.2510575-3-jamin_lin@aspeedtech.com>
References: <20260506032643.2510575-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260506032643.2510575-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|JH0PR06MB7325:EE_
x-ms-office365-filtering-correlation-id: 4ef2f64c-3846-45f3-d124-08deab1f4d10
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|921020|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: 7GT4Dm26sYBToPTEmNPTr48uprQStuSDJCST/1RqgtpAYoWKz1kB2TSjzNpbT/D5fADaJZcW1M87CzQ7POeQ29IZFh8eaOwxgU7zR0QaDbBd6lwrni/cDc6bPF11GqOWIf9UrfbW8f9sbVphiq1fte/RmL3p7vkgP4fQ6xSr6iiaKnM7BntnMbEJ9ql5OZ5zCO6xOO9F5DfVMcltLWBfRcLRJKoKcWRSzvgs9Ni4niD1PjbOZb9SG3w11gXXA4uoHjWgqCsGGCWc2qLNCHmHN1Fj+EOik3pMqzCGci4QV1uLNXLfCuvuwNMnLyQ5eDf6WsBQaq7jPegRTjfuEmUoMa5bN6evRQxvv/nQnrpbqtgm/PXAP5ps1aRRSFZBWMPalcg+7uIE/g5OwlZXbE0cE8rDuTAzdM3yqOtR/XmZqW6Jt3rFC6vd2SBi9yfEXb2ozlDc5Q0XZdRQ96/CASZJj6+csBIfZDU7pvuZJHNpAKy1PMzMaNYXo6akmXKYvwPmRDBJe+hqaEkKqAyAUtEDb0bd6FXpD+VTdJb9Bbm1tGau59zeohw4s6SyrQCDPAbTlDc/L14LxNGSN/gE6O+QKBQ/+I2+u1vtqMqceuREAQhDwO39F3ogMvxVM38KCElYRBd/F9y+ycHFVhNiCLhA2X1XrnEVzm6iOul3m80YSLRu+TiFSL7HZANtLSxBZHxTyTxqgP9tLQkE20uInSJPz0yQY6pFH3LFaKFmbQvoTsmIUB4shK0qR6S9QVXkJheQH0ZZke4udrJbOTgitQ+KYg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020)(38070700021)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?dBvqAil+VvV/QCqYfpQ6U5+CpJ8JycmZCdjWv/M8CY7RhA5ofFHk8OJa59?=
 =?iso-8859-1?Q?BiAyvdk5eIZZ2a9iGLKstIwR35367vCt64I3QJwyTMDeX74Fp4PVdfqPcf?=
 =?iso-8859-1?Q?btFcSYpMGm75GzJmFHWQYEXLt5VsNreBO1vMex+ggsm5/ySrc5ms5nt/Ku?=
 =?iso-8859-1?Q?kSK6GrTpTOmRRPe5Bx6lmGYXXG/sJ3JAcsNZ4DuqTIJvAhpJQnHWPbpCB5?=
 =?iso-8859-1?Q?QOfSLx1O+BA7h6znGoxMkU3tITDEo4RlJf8zrOATolTVybEj0u7sDXL01W?=
 =?iso-8859-1?Q?LO4BOu4qo4RPm1y2p8dgm/WnMHedMdYNanNHwI7dzSpBCF+++zO9aKd7L9?=
 =?iso-8859-1?Q?jwZbdnjmSm4gZfJ4U+WcJqd9npyNirIBg/dw9m6DbKVXMnVjh6IOJTCX/u?=
 =?iso-8859-1?Q?t8GQyg3rlMhSIF6UW/K9II6iQH20x8ebJBiQSnc1waGrVS0Tr4r2IZDxG0?=
 =?iso-8859-1?Q?4lgCtyf9bcKdifNtoXKuVh/toZwWZMYzmZOqnQ0pwUdlDB7EXlGLFJSPg8?=
 =?iso-8859-1?Q?IfWlyd+xb50Cvu/9lwnC5sbHEibscEl1Sox8Tc4TjEQViu1kGe67Cbm6Kv?=
 =?iso-8859-1?Q?peK6EUhkxzPXESIkB1RNsAH2ijpvW1Wh3glI87LFYb2szcfZDVP8n1e/ek?=
 =?iso-8859-1?Q?7yvTKimW2HwQhBezK5lPPrWbQjV6y8AU3J0mxCqEmJGJBQ9mZuJj/5cNji?=
 =?iso-8859-1?Q?Tx6gfEg3gxokWUwi5F6TahRSWBI7zDVK4OmPORd4oNGuBVTDg17/YPR0/o?=
 =?iso-8859-1?Q?+PyfaGUFPUGdPHNtiCEpzAaO2mm/kC1ng3bXxTwBu1MQRxPbKk6SRPuSQT?=
 =?iso-8859-1?Q?7b2QObtlv72XHPzSCFPMW8u2gZqIEX8eX/K1QprM1j+FeLJpVK35Eotbtr?=
 =?iso-8859-1?Q?0kO39l21x1+JTDxwNsxShUm8Cb0W84YNN0wv4mLV6uPM2+uWDsK74d2DkA?=
 =?iso-8859-1?Q?ou67Sq2MhpL5OoCQ2NoMzWjBLVtTLyam9HJ+v3gPd9DNiuOR/Zq4qNz5X0?=
 =?iso-8859-1?Q?z9oK6xXcvXtqxFvWA3pfDlu/uuR1+yW9Rkwq1MY4co2JTbaYk16ilTAKMn?=
 =?iso-8859-1?Q?3qlUqPl+WxO9Qv9H3JlFkUMZZEMsGbTNk4y6NrqwijC+OfwaAxjqAArdGm?=
 =?iso-8859-1?Q?Ic5yae0Cpn+vm+0AJQUSZOoORQv3QFj5c68Hb2RyLwu62bJr6Ti0Wcy39X?=
 =?iso-8859-1?Q?DUaiABqOe6WByqouj5DaUO5v+SH7y5c5B9JWoDZmXHabZAxnybxHbtQPLj?=
 =?iso-8859-1?Q?r6Gbb9oTZvTZ2c4YJPmycH9SWcF2czzm5C6uxY/hArnT2B7glwecvdl8Sp?=
 =?iso-8859-1?Q?xoPzQaDkzebjVQ6duwMMU9lQoS/V7NbErKEh4zpO/aIsxNkMyCxgPfGdmj?=
 =?iso-8859-1?Q?ksT6RWCWlK7p3zgxu6vC4WaVLG9pB0r8MRdp9w0jY+Ll8LvhuC5XZHHOPe?=
 =?iso-8859-1?Q?tDUrBvsbu+Wlxy0g1pH8Z/B9WR1M/Xj6QhdDuq420wi5eGAAD/TtSpBCRW?=
 =?iso-8859-1?Q?ulyvMUaXa3E7W00c+w1nOG6cNCCs2qNL+Fi4epRfMqFA46SBeWXUh9SXDO?=
 =?iso-8859-1?Q?Xvlhf45sjxx5SmiEuHk2v4Inj8xD+ClnGyJwcns3C1rwhQZk67f46kifyw?=
 =?iso-8859-1?Q?4eNr+0fl8ezxGU/JD1OW2KvET+IsIm2bmU2Vr3C/X7ULxkfOOqoluq/Mi6?=
 =?iso-8859-1?Q?xc2oUCT/QDqP4CnUZRVJJ6zkUGzcYafGZsegWbK7nNZcnumOM2W+4iei90?=
 =?iso-8859-1?Q?HWvxlcjhkmaQmBo7C438hvlvQu7zTb8xehDzx+bnndtOlYLk7ZikvhbH9g?=
 =?iso-8859-1?Q?gB4ezop+UA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: fxiV3CBfA0C2R5C/Qk0O0W7XVuPqwBsA5pT2quUc9PZOFTwlh+iCBbv+7ph90e/ZyUe4EI3IYQikrbqARphZWWpFxmT+UKXo1fssryrEAD5g81qZUbv35EmuEKPSkKNg7rh4t4xfhU6Ilk2kSCXI704Flkiw11ziqjqw8O/iioy2/2de2aXIUUpClClxpfkEpwNEy19KVQnKLPo8wamASH/NI69AxSNgOJ1vLNFcw59QxVoHyreaUZfTLVDbA7aDqCTmabO2QbVm8oR6KKoh1sGRjq3Aq+hhgv+bhwOSlAanH/RTsDwl6mezG7b9nT/O7CMGA8JM9ath8TCxXuJrRQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ef2f64c-3846-45f3-d124-08deab1f4d10
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2026 03:26:45.8451 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W7A6zs0TVJouGhtq5xUmBwKISXLAhVk8Kkq5YgOAg6k7ggrlxywzj/eDJNdSzasPqlRWJLo30anAyU6kBLCHzVc4QG6c1PVMqoaEBHN2leQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB7325
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

Rename the EHCI CTRLDSSEGMENT default property and=0A=
internal field to improve readability.=0A=
=0A=
No functional change.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/usb/hcd-ehci.h       | 6 +++---=0A=
 hw/arm/aspeed_ast27x0.c | 2 +-=0A=
 hw/usb/hcd-ehci.c       | 2 +-=0A=
 3 files changed, 5 insertions(+), 5 deletions(-)=0A=
=0A=
diff --git a/hw/usb/hcd-ehci.h b/hw/usb/hcd-ehci.h=0A=
index b5ac9c8670..b739c81870 100644=0A=
--- a/hw/usb/hcd-ehci.h=0A=
+++ b/hw/usb/hcd-ehci.h=0A=
@@ -268,7 +268,7 @@ struct EHCIState {=0A=
      */=0A=
     bool migrate_fetch_addr_64bit;=0A=
     bool caps_64bit_addr;=0A=
-    uint32_t ctrldssegment_default;=0A=
+    uint32_t ctrl_ds_segment_default;=0A=
 =0A=
     /*=0A=
      *  EHCI spec version 1.0 Section 2.3=0A=
@@ -335,8 +335,8 @@ struct EHCIState {=0A=
                      ehci.migrate_fetch_addr_64bit, true), \=0A=
     DEFINE_PROP_BOOL("caps-64bit-addr", _state, \=0A=
                      ehci.caps_64bit_addr, false), \=0A=
-    DEFINE_PROP_UINT32("ctrldssegment-default", _state, \=0A=
-                       ehci.ctrldssegment_default, 0)=0A=
+    DEFINE_PROP_UINT32("ctrl-ds-segment-default", _state, \=0A=
+                       ehci.ctrl_ds_segment_default, 0)=0A=
 =0A=
 extern const VMStateDescription vmstate_ehci;=0A=
 =0A=
diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c=0A=
index a8f0bc389c..5865894658 100644=0A=
--- a/hw/arm/aspeed_ast27x0.c=0A=
+++ b/hw/arm/aspeed_ast27x0.c=0A=
@@ -856,7 +856,7 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev=
, Error **errp)=0A=
 =0A=
     /* EHCI */=0A=
     for (i =3D 0; i < sc->ehcis_num; i++) {=0A=
-        object_property_set_int(OBJECT(&s->ehci[i]), "ctrldssegment-defaul=
t",=0A=
+        object_property_set_int(OBJECT(&s->ehci[i]), "ctrl-ds-segment-defa=
ult",=0A=
                                 sc->memmap[ASPEED_DEV_SDRAM] >> 32,=0A=
                                 &error_abort);=0A=
         object_property_set_bool(OBJECT(&s->ehci[i]), "caps-64bit-addr", t=
rue,=0A=
diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c=0A=
index 56ac8f6ae5..133501b0f4 100644=0A=
--- a/hw/usb/hcd-ehci.c=0A=
+++ b/hw/usb/hcd-ehci.c=0A=
@@ -1134,7 +1134,7 @@ static void ehci_opreg_write(void *ptr, hwaddr addr,=
=0A=
                           "64-bit addressing capability is disabled\n");=
=0A=
             return;=0A=
         }=0A=
-        val |=3D s->ctrldssegment_default;=0A=
+        val |=3D s->ctrl_ds_segment_default;=0A=
         break;=0A=
 =0A=
     case ASYNCLISTADDR:=0A=
-- =0A=
2.43.0=0A=

