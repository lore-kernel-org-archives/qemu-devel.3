Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFC53FD0644
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 07:29:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0DyX-0003Jt-Dz; Wed, 11 Mar 2026 03:27:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1w0Dy1-00035v-59; Wed, 11 Mar 2026 03:26:54 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1w0Dxz-00052E-9a; Wed, 11 Mar 2026 03:26:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y744Agrm5ByZxNYMXVgS16QHKLhRHLZyCEYfLN5NzgSNaqQmOPTf/SReZcOGsHWiwefWEad4xiqlVz4Vqd2onZnM/kvqupzXDO3Fy7Ua1duQLwmbLsVLOvpXWZlRpH7WIe/V9rN1xCugCKoBdzh5YtVcDXk6ARmnp92hP4pDLe7R6RuqRaG07ngexuXN4HAZCtUsdS4CFE6evn1olnF7UNOziXwhQmamjt6zCT0Duny+RHLS81ndO40Lmp2VkQhLrxB+535MUTPHh0H3V+Pn7pKLpAlDuVZTgBzWYtaDEL1z2gPOlXq9fS78rbzZwxHLF+EnCkqC9ftOOHL2wtCiWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D44Uj+iFK++1h56DD7O5nhKoVQTojM2qNdFPYRPYfm4=;
 b=DMG9Df6Rp70OV08QMV3E8GHcpg68ST0vSKfeHlEQhwLtdCHIAHeRfSwl2bQrlGMhJiLTjSpquzAvqP10B/4JrMZLCjuO5s3wXjOZcLQTTq10sCbo+NMP9Iv13iX8kKz/yr/LDrm7ckD0ZXJWRbGaal9FMUXg55qS115NuhbIdRH50Camx2vvP0VhUljA2YQSMV9AKin9Sheh/PH5EIe8/rZgJ1EIj+OjzQYxZ2lFv2g0agtnDA4x8X/rHls18+uc9CoYOzGST16IblsNy+3dHLtHlIivvgrgDl4JGhpx9FKqjHPy1rla1LmnCaRr2pM/jWh8hZSmbxpqmCvmAxSw4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D44Uj+iFK++1h56DD7O5nhKoVQTojM2qNdFPYRPYfm4=;
 b=g0wpp1NrrquhsOjtlTAJ7Jvchb2jobdKHCiKSa0nv+moQx/jhsjcWXG76jFXCr+HTbwZgagcJeDEFXg7SBd/10f+e+EJwqDXFJqGuir0RZLWCAYYsIvgDNv/RUTLfOOij+wXx9VcRQzumNgJTFlMMIj1x0FgzSswAlxxpmSpGREa82z3AS6KA47oJDXWjzlO7sjR6IQQvhWWnn1daeVcZ2FNAMK+uEtKfaIB5NYV7YQmZLfm0PpUWuaaYuOoD1JmEbvWvb1mtrHRO6oLralKONQwydZI0MjyHvR/Cd/vRPTZBUiZm1fMBxJnEd+nGvGfgkIwc6ods0iMfgsTlx+GYg==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SE2PPFD6A65AC07.apcprd06.prod.outlook.com (2603:1096:108:1::7ee)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.20; Wed, 11 Mar
 2026 07:26:29 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 07:26:29 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>, "flwu@google.com" <flwu@google.com>, 
 "nabihestefan@google.com" <nabihestefan@google.com>
Subject: [PATCH v1 11/13] hw/usb/hcd-ehci: Add descriptor address offset
 property
Thread-Topic: [PATCH v1 11/13] hw/usb/hcd-ehci: Add descriptor address offset
 property
Thread-Index: AQHcsShgVVvWfyMXxk6VQwvYNluV1g==
Date: Wed, 11 Mar 2026 07:26:29 +0000
Message-ID: <20260311072614.1095587-12-jamin_lin@aspeedtech.com>
References: <20260311072614.1095587-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260311072614.1095587-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SE2PPFD6A65AC07:EE_
x-ms-office365-filtering-correlation-id: 51ffbb4d-e107-439e-c5df-08de7f3f8303
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: 4B3IQyfthbg2xotoRIOYwGW5CoP3UPWiTyMaZUEZnz0blXG8z00WeFR/Vt6Lzm+cSpaMriobZIjpsrAIxlBrVFHXwPiONrEcmRIDrnVi4TzDZ6hoZFF6ZN5gy2Co72SkG4LhLPqpGjam/yIkKxVnvDcUiKSm5u0tV10TLqX1Gb9hnmYd8/vMFtnVZS6R3QTgKNqnr3K/ks8ZKaVgOCRPFEdL3eI+y5hkaNG8AGhZminb2238/mtYqkfGRyLJCoDHmFzc7wGtZGWhwTSgscyDRDB8o+fXOfJMdD1QUrIxZmf3e4u8BerpdJiASOQ102HJvOtmdM+Gtu9bMCIKX1GjsED0iDT1ywU0BuJlKGOzDLqY7JjdJN7SEYuJcwSLUcr0ZMrO4Nry/n6pXpfczi6RvRY1ki8km6LrLSdRwWa0+jyGa3nzHvIz1nmva6KMLlE31Y8BOpv4mvQOJP1z3EhaX+HAVOrKak6knc0qsyTZsqfqF5eumrFUtYz7iZW4z+Du+aRJyK6+Nbzs99E6r8v90+kha1JhAplCwY+X90kmFrJwSwO82FiPCTecZ/Pzm7NfAOla1a07NXEKcBZZ39dB2OP79PZgbDzItZy8Lyx+916ws+gOITAv0gtfnHJcR6k2xOhAYevINMzhdJIfO7MVBBxa1kRDHDZ+nwxhheB6LdqIqE2Rna5UOwogPwZ1BrJPTAV/rLmz/i08QF+VXwX5c4PXzqFQfWuweyHjYrYMgjS+V3GQ8/nUwWKox/okYW1R
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?PccI92+KcbqZ8AZ4UowPFdMVrtD6A/IO2KGoUNuYllCupH5+FpfEa0X/PN?=
 =?iso-8859-1?Q?nOB/ytd7mWyb0z3rI3xvtcFR0dQnztGpVZO5NVT0a8LcTQnGKaeb5IKatf?=
 =?iso-8859-1?Q?CWD3EkxIt4yc0bpeQNVY+q4i1BDM1Z6wNx8nBmUZ/rE6ND46APEIw871p2?=
 =?iso-8859-1?Q?T2ek6FQunZTtNu1Tmewwc312X9eMCbmqcU2j5rDIknGi3PH7WovPbRcbBx?=
 =?iso-8859-1?Q?bFFduwQhxmCnZenPunY/P3jR+qWcYnLRLNaMzTn4piMWi5xObYXlHSY7Ou?=
 =?iso-8859-1?Q?w8K2J+XXKWWaY5BKTugSl8pGo4Ic/5rsLGsRb4duhGASi3X72QpZ2hXXAE?=
 =?iso-8859-1?Q?38TUXgAGtrSs22aVT+Ebn1fBLh0EkvXPkEY9r3LGt/7U7trcYWdQ46EbeO?=
 =?iso-8859-1?Q?vzWwmnbaIeIfEfyWS9CGxtE6XWn16fWKUnQ870wkfEaf1Py9wCbfZJIVHu?=
 =?iso-8859-1?Q?++oPCLXKac27jvfnghJMg3kCcfj5pDPPMugfdXEMsH5eL7646fjqkewvaY?=
 =?iso-8859-1?Q?GsyW+xLGuTpaLt8HJnoJO4782S9QUsfFMdwkOrSI7ZStbq/bQgiwdBwgJV?=
 =?iso-8859-1?Q?oq8vFOWG7N4C0z+j5lkVOZJscPyH4kAaPom2TIB68PZDv9I4NOhxKivNRj?=
 =?iso-8859-1?Q?L1cKiSKkGA9e3OCMNG7cnDyfbx4gWfQNBj5CKAEeYesVpOvDc1b/vNxvcA?=
 =?iso-8859-1?Q?3KX0ZB8VDmNlF1p2e5FGa9bBwdXeuh2nag845GdDjSdONebfus6U+pn8Jx?=
 =?iso-8859-1?Q?5W8ZiGtpbF/4VUqOfiXkjAEB7hxfQizKH50NRDVdRy6Dqw/EmB3F5awrTJ?=
 =?iso-8859-1?Q?X2U/ios72DoyBE5Ickwr1tXIsDsW8uwyiRv5pNXX1X97w1RYgYPt8nfW5u?=
 =?iso-8859-1?Q?vZEyCTuMSQKX+8KaZHomLlajatmBYFXPdxDvoxN00j0kvcWUS2Fqzp34RN?=
 =?iso-8859-1?Q?fS/OrIuj9XJ31NoIZW2zuQo2EzzEeL7Q1/S0HQdGDxksuEcUKZvh+014gH?=
 =?iso-8859-1?Q?SqaaBGw5AYWM4FwbrjWZ8SnkdP2YRqMLzf2DNpWCURuIr3QHzTmh74t51I?=
 =?iso-8859-1?Q?lWgSGpOZoYfeD2JE0/Oso5+cbqoqP5NgFlTStRZforbADP6fcsH0SFZrAf?=
 =?iso-8859-1?Q?jWqkUWKGgkeQZpcr3F4LvGdRrJQWZ0As9ZfKmlgQpYV6zdY9i1aTJS3R1p?=
 =?iso-8859-1?Q?LGkywI2B2m/4KiyfQuyKGNNaMlmo1G/Ab9KYZ0yVF7wgAGAzc3DGvPffvn?=
 =?iso-8859-1?Q?eHWzPnorvTJf8qvRUgkCO3XZrA9NWPhtLFfMrzC4WFAHhj7CiGiEF2z6Zn?=
 =?iso-8859-1?Q?oJiIH77pQyO2vNhgiVinaReCShtdqXzXEB/M24gPCKJQYPSXBUSstV7dIp?=
 =?iso-8859-1?Q?1S84sVYvE1tvCWE2vd+NYuM1Q/mmIWnJVp/YFsuePw/OapjxON4eTxlLWg?=
 =?iso-8859-1?Q?rNhX/ts53huU/7yMLPTkV1UrtV+EvwovyG77lZdy+YC5K1f1rjwK9HMO2Q?=
 =?iso-8859-1?Q?VTbWz9KJd+t3nzOd8IKhEFBLmllmNdcHQ4TphNuyKvQ/sAWL5WEZoL3QUP?=
 =?iso-8859-1?Q?FJiH+XorvTDN1fviHPsTMkB/g19DJO/Rec3MzGLYwtWfi3wojBJ9NW2A+s?=
 =?iso-8859-1?Q?xP7f9/YhfOL8vuMF7w31c+25bU0qDNbFUwiTYj2a/xy+QdhLnKXFe8VM/p?=
 =?iso-8859-1?Q?1+pABJ5sm9P2/y20Y0ZgIgDlZY+rDdRsxYYVLmNoVoQwbfgMERnMP3zBjq?=
 =?iso-8859-1?Q?WKJeIKefLBtGqwRk4fsYfFuXo45PUpiIh2NAD3bCQz1rD5n2pJMhei6Mbx?=
 =?iso-8859-1?Q?QXvigCxaOw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: pfecHUYWTZF45CbKKZHYR0JwR5n6A/9ZjzEVcx9BUnjLDmQwBFTx91UDn0dMu3rrEx/lqpT1qap2D6YfU5zcFk4frewfqOn7iQVARH7cJRF8uKyl8fYZlcq01hIsX2+mwFwBG9A/ijtnGy6Nhm3tYVe/FN/jEJ92VC/YguYXFF5fb6wppJhNBS313F1APesI4vINxm0O03dVnYqJHZSVrZLTccpmNG0i1QrQ1lmmQq8iNHm0hyZygShCTQrknh3B/tw7yMmq9AGkR74CWnOEd2CkcXNyV1pLiSVVWxbfg3aorb9JWZuxWBwTrwaQccdnHS61kmhWHGWaAeHW4BMlEQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51ffbb4d-e107-439e-c5df-08de7f3f8303
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2026 07:26:29.0555 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GCC5ivcqM+2RzFX0au/LSUvAWDta61BcamC+IggEMmTh6Xn6K2xHrFhl7j3l2AirWu5Migk+rW+NbXJ+dIrTEXoVuofoclGVzxXR9akESaI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE2PPFD6A65AC07
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
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

When 64-bit addressing is supported, the Linux EHCI driver programs the=0A=
segment register to zero. See ehci_run function:=0A=
https://github.com/torvalds/linux/blob/master/drivers/usb/host/ehci-hcd.c=
=0A=
=0A=
The driver comment also notes that descriptor structures allocated from=0A=
the DMA pool use segment zero semantics.=0A=
=0A=
Descriptor memory is allocated using the DMA API. The platform driver=0A=
configures a 64-bit DMA mask so memory can be allocated above 4GB.=0A=
See ehci_platform_probe function:=0A=
https://github.com/torvalds/linux/blob/master/drivers/usb/host/ehci-platfor=
m.c=0A=
=0A=
On AST2700 platforms, system DRAM is mapped above 4GB at 0x400000000.=0A=
As a result, descriptor addresses constructed directly from the guest=0A=
EHCI registers do not match the actual system address used by the=0A=
controller when fetching queue heads (QH) and queue element transfer=0A=
descriptors (qTD).=0A=
=0A=
Introduce a descriptor-addr-offset property so platforms can provide an=0A=
address offset applied when constructing descriptor addresses. This=0A=
allows systems where DRAM resides above 4GB to correctly access EHCI=0A=
descriptors while keeping the default behavior unchanged for existing=0A=
machines.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/usb/hcd-ehci.h        | 1 +=0A=
 hw/usb/hcd-ehci-pci.c    | 2 ++=0A=
 hw/usb/hcd-ehci-sysbus.c | 2 ++=0A=
 hw/usb/hcd-ehci.c        | 1 +=0A=
 4 files changed, 6 insertions(+)=0A=
=0A=
diff --git a/hw/usb/hcd-ehci.h b/hw/usb/hcd-ehci.h=0A=
index a11d4179cd..6593480028 100644=0A=
--- a/hw/usb/hcd-ehci.h=0A=
+++ b/hw/usb/hcd-ehci.h=0A=
@@ -279,6 +279,7 @@ struct EHCIState {=0A=
     /* properties */=0A=
     uint32_t maxframes;=0A=
     bool caps_64bit_addr;=0A=
+    uint64_t descriptor_addr_offset;=0A=
 =0A=
     /*=0A=
      *  EHCI spec version 1.0 Section 2.3=0A=
diff --git a/hw/usb/hcd-ehci-pci.c b/hw/usb/hcd-ehci-pci.c=0A=
index 2ea8549db9..115d05ede0 100644=0A=
--- a/hw/usb/hcd-ehci-pci.c=0A=
+++ b/hw/usb/hcd-ehci-pci.c=0A=
@@ -139,6 +139,8 @@ static const Property ehci_pci_properties[] =3D {=0A=
     DEFINE_PROP_UINT32("maxframes", EHCIPCIState, ehci.maxframes, 128),=0A=
     DEFINE_PROP_BOOL("caps-64bit-addr", EHCIPCIState, ehci.caps_64bit_addr=
,=0A=
                      false),=0A=
+    DEFINE_PROP_UINT64("descriptor-addr-offset", EHCIPCIState,=0A=
+                       ehci.descriptor_addr_offset, 0),=0A=
 };=0A=
 =0A=
 static const VMStateDescription vmstate_ehci_pci =3D {=0A=
diff --git a/hw/usb/hcd-ehci-sysbus.c b/hw/usb/hcd-ehci-sysbus.c=0A=
index 61215e9f3d..df138fb339 100644=0A=
--- a/hw/usb/hcd-ehci-sysbus.c=0A=
+++ b/hw/usb/hcd-ehci-sysbus.c=0A=
@@ -36,6 +36,8 @@ static const Property ehci_sysbus_properties[] =3D {=0A=
                      false),=0A=
     DEFINE_PROP_BOOL("caps-64bit-addr", EHCISysBusState, ehci.caps_64bit_a=
ddr,=0A=
                      false),=0A=
+    DEFINE_PROP_UINT64("descriptor-addr-offset", EHCISysBusState,=0A=
+                       ehci.descriptor_addr_offset, 0),=0A=
 };=0A=
 =0A=
 static void usb_ehci_sysbus_realize(DeviceState *dev, Error **errp)=0A=
diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c=0A=
index d9d1ac2d28..cdb53be4ae 100644=0A=
--- a/hw/usb/hcd-ehci.c=0A=
+++ b/hw/usb/hcd-ehci.c=0A=
@@ -155,6 +155,7 @@ static uint64_t ehci_get_desc_addr(EHCIState *s, uint32=
_t low)=0A=
         addr |=3D (uint64_t)s->ctrldssegment << 32;=0A=
     }=0A=
 =0A=
+    addr +=3D s->descriptor_addr_offset;=0A=
     return addr;=0A=
 }=0A=
 =0A=
-- =0A=
2.43.0=0A=

