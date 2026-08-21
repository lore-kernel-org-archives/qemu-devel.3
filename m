Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A524C5DF89
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 03:22:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxFoW-00014i-Fy; Thu, 20 Aug 2026 23:21:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wxFoU-00013u-NP; Thu, 20 Aug 2026 23:21:02 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wxFoT-0004D4-D6; Thu, 20 Aug 2026 23:21:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XSueRlG8kj1QjiJqtWrYtRXRy8fKd0q+/SXWwkQbYAWRYiKqWuXX2Gay8gN3Et8v+CaVNyKrqeTMSGj6LSQlPIugv3bSUk87njujHpE3YxvZMsHPbssCVNfjpLIEBS7LtztoCNMP+7uCkBJ2PIajEuKoEAd8bseJXYp8BXwWOW9y62PghzNaLLzMUYZM5xSSGiQzIccv/TxeALSWpdDIANtwv4I+zb/1CwTF1azjS27AOcH453vCwNctrG8muSFwLMVo4ZiIROzuCwHep6IEE/oRcf+m2fqeQh1YSwg7/nXYct8PAXY/rxZ9vQYspk88m4GhPeQo+b96zoOh8UYt4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fD+btaEiZtDBpx9qQBszmscxrzLO7OdBP3qCKtYG3HM=;
 b=uSfx2OwrrxUXlAtxJrEK1xrkgEm4yt5V4Eggzk2CkWZIRXlBfa+iTq7sFmjykLyUXhY6Z0kVLKyzZ9XUhGj8mZUC+iOAvXoTzuVSw4w/GmNt7ndLYf+hX0bSHOcY2j+igu7GQYWXTlDIgDPJqEMJIflyDurd0Hj1jsVpcMPN+ppHoak87gPHqewJW5lz9T33LGkCMDw5UumOp74goFgK+rybDfdgHbyFu8MkxoWHXUPelDsHWf+YQEs+YT6LhdMItcefw6C5acibG6L4TFvvMh9bmx8Sdl9uWqt811ougD6I08AXg/MdjoTw2iPBMf+YcBtHtr6YL+mu1r0P8049JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fD+btaEiZtDBpx9qQBszmscxrzLO7OdBP3qCKtYG3HM=;
 b=dDLWvaq4a8p1wSVDRgomj8qNnD3SwiR2o4QTz1mytCxmu7nRVibbQvruM34tWKLPIJ05DK87jBLGP+Dd/2KadPYDiHRBFKaLLFxsI9XLX6Q5U9kc3RgfQoP8pZEfsMpxi6w7QLU+oy/F3t/ChX0Rirs4e0HaxRoR23zjPCWNhvvIxPcZNG9NAwsUKsNkVzQeXXwY4nZfkx4T4Y3TOanxXgPnbO0gExNH75IfuPgi/JpNRRgN/lVfO1XOK2jaWntJah94vRBwEdYwbJktfvQImysvcpk22bofl3dSXuYPY25tseH9KNKokWFr3vSFkglOkcYOL9+dJcN58ajJ4+AlKw==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by SEYPR06MB5467.apcprd06.prod.outlook.com (2603:1096:101:b6::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Fri, 21 Aug
 2026 03:20:48 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0339.008; Fri, 21 Aug 2026
 03:20:47 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Eric Blake
 <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Fabiano Rosas
 <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v2 8/9] hw/arm/aspeed_ast10x0: Wire SEC SRAM to the SBC model
Thread-Topic: [PATCH v2 8/9] hw/arm/aspeed_ast10x0: Wire SEC SRAM to the SBC
 model
Thread-Index: AQHdMRwPYs3L/LYbiUSxE20k/pj4ug==
Date: Fri, 21 Aug 2026 03:20:47 +0000
Message-ID: <20260821032036.1829294-9-jamin_lin@aspeedtech.com>
References: <20260821032036.1829294-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260821032036.1829294-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|SEYPR06MB5467:EE_
x-ms-office365-filtering-correlation-id: a655befb-a8a8-4fb7-70ac-08deff3331d5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|23010399003|366016|1800799024|38070700021|921020|6133799003|10067099003|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info: MEpkYsEDt5McaaxthEsh9BedvFzYRknMWlJU/cK3qWuqSsU6szVwsjFU2iX81CKtkQrk9NEVbl2BpbK2tIp6m/NovalPSDr84Ah246wf3S7JM31zOtLadklMxYchkBQj0HyoNdm+UItJwjUjOyScyaDisJFszAtpzr+sWIvw02mBlbuMCNbz3/zi8Vms7fv0aFwU2E3oQNQ0hinfg1RKL1m/pwmx2xLikL08zRXIK62xL/PtaViU/Ev+AGpvU478L9+MRvQ7xkVRwHQII8WQ7AzMPbTsbnGs+AjiLH2AprFMyrhU31CibYAIXhrogV3fMln9BsrcEl7SbrHfRxfGwRH5bigIQJWm6cIOrucSb6osuFDJrBOvK4nNNcRFHyLtPlU+bycQreDiOIu7xjS7gCyrPcivc+ykioCDSLW9TEVzWt0LRjzIwLApO4bbwkF5bezn9OcT4lDwebqzaPjV2USESPTekbQZSvU6/YWOeC+8mJqAOY/Au+yk1T1oI4wUk5BHTCnj7bGrXAzvgnAfi0Rvnx1wmJ6oBVgk8D2UouiIkuZTErhZMQM2JmNjmAj8OS1nR0VyvpbMqqPfpMBedIWgFsRbi8PAAOKoQXXyvS9o7G+syATcHBZdwMKBx+ERL03CsIu7BL8OcE8nuvdxE9L81NV9888ihl3gFJmqbfjEFpbUL0g9sbmtLOwGBd0o1HveVfFjK6A08L5K8NYs8dQ2g8s3+2UZ4qPNygaZG+yg4XUz+HU1qZBEvnbZIT+2
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(38070700021)(921020)(6133799003)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?D4VerMWaslTyGfP1h4JsxOesI7ur/ohLXkeyNEYaX8uYtAERC7KIKOKntY?=
 =?iso-8859-1?Q?v9hSbeXifsLWT/CaPWXltJzXVgYHaOLn/jizn+/HmHmzl7qELbyAJYoh35?=
 =?iso-8859-1?Q?xHWrUpM3su0twzGwznZVSE+3Z6Bl8eoDzRfjcfq3EdigPqcpAGbtPGNlIQ?=
 =?iso-8859-1?Q?M09oKdfrLLDR40QK3vvTlxtbRx0irNMeNk6DZLTIWEkyUZ6X+Q+TUM73W0?=
 =?iso-8859-1?Q?j5Z5FWXKgFYrIcb/S+1Ru8eHu7Bs/gFyk0ySAWK+UIsdJhnhHw9x7E8JP4?=
 =?iso-8859-1?Q?6OizeSrMbroe8NAmDTFN18n9rRnRbYQ7hOkDq1ZCAbXefFa15nuqLffjtm?=
 =?iso-8859-1?Q?Mk45QxTwXAvFPtckQP51nOGgXYw2LCTIXvtCtj7sVnJA+cWXNg84d7Sovg?=
 =?iso-8859-1?Q?cpAqsXKHNlJMgtX+igjLr5zwkTRJCp01uk9HbUobEjyprWBWPsWy/stqug?=
 =?iso-8859-1?Q?OakKtnCN63vu/dybiHwI7BYBOX8Z3AmNa3+52Jz1j1CaJI6Ifjo/BKbq5O?=
 =?iso-8859-1?Q?2gUfyArP9yS2YP+yipHWN2qnuq8iqv8q9vEzLQDVuCxfGOCzbnKcLIxcQU?=
 =?iso-8859-1?Q?dwVIVCAlM/X+Vbd2lgpgHcrD40utLZjAmdWZ8ZO2N67a2rpJUmGxpHhIm7?=
 =?iso-8859-1?Q?IIipih7K1khnvpCdR0+zF0Yn81PsPnXkfbYzhg0r645KSxO5PRbKtO7gQJ?=
 =?iso-8859-1?Q?EHqL9JNz+s1vVvO3+DB4LqjsulLJuPMVil+TLQP/7lO/zitcaDb/NaIfij?=
 =?iso-8859-1?Q?2hYDwXE/08H+ccNI7IWSk4LFHsm1tdgJZpGgAX0PGXkl1TIEIuPYHpAHWo?=
 =?iso-8859-1?Q?Hhjx4hff8OLXLvRgPT6+gSP3jWzbZSFfTYQ1vgU5evzDf7zv6QneXAoYOr?=
 =?iso-8859-1?Q?khIsfJeamT9f4uqpuEyJ4AT/5IHvPK2FeJfVDPTqEGjw1EFc6oT+8GTLZy?=
 =?iso-8859-1?Q?hXUeBrng+EtxjykcN8qR+hzEoySP9wu8nwWoY4xAjOzxtJwhry0Q2p3zHt?=
 =?iso-8859-1?Q?rOo5g2ixgteGsGTm3wlFXLlyrjm7455svUWHt5bouLT7svkD5oT70exbdU?=
 =?iso-8859-1?Q?35SVLAcmAfEPJww551NcYcwkXeL+eLSTrIbUgMfKcKmCambfxxrhv8gsBx?=
 =?iso-8859-1?Q?MzKWS8FKZYvsmVejRmPULKPQLxgUgDNIu8IozYL/FsZ16uUA7hp3Y3oXKv?=
 =?iso-8859-1?Q?FdMPus3lBSJ1sgydqCmbEPfW+BMpMj+GJwUhjGN907DBMV694igPqkYno3?=
 =?iso-8859-1?Q?LYN0xkeLkFDPQ2U9q929+WsXsKrY/oL2g1CurD7PA+0RGk4mNOgRLBEkca?=
 =?iso-8859-1?Q?w+YN41uzVg6Y0p9KICFwA/uTQ/QXTDl5Mhz+6zIYHHekvt9j3UwjdjJeeW?=
 =?iso-8859-1?Q?JYS+rx+uf7Vw62aipfcpplseqSxkqKU6d7KTIOgfknzrEarrKKCAYmgZsJ?=
 =?iso-8859-1?Q?OQxNomTwZ7O3XNGXbS1b7br03RzPjTk7HgT6kb2ywqzFEc0OZgZGlgZlGT?=
 =?iso-8859-1?Q?Rwcq3alY69xkNj2Ug3Yp9qbQryDID+y8SP5VnlRnSPj3lMxJLrCP8iT0Vr?=
 =?iso-8859-1?Q?XiuR9yxiteN9NBfWNT9BQTnDMHKKus+c7+vbsqBeCcXY5jlnf9bju2kM2I?=
 =?iso-8859-1?Q?CWyG0mPh8iTn00/hUvIY6HyXMT8fTN3z4kgooUBJrTVSzT1xAf1wx8/I3+?=
 =?iso-8859-1?Q?gTCVjX7X2Sy08ngr91UAwzAxBM8IfQptD/aKRVB+raDB4LTmFXU646963F?=
 =?iso-8859-1?Q?qFGO6JzFJbtYm+T5CTdoDpLg/xtzz0DwUqdyu90jzmScF9YRbHH9E4oGMp?=
 =?iso-8859-1?Q?0SzeMp+T5w=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: pjTBX9odCLhzHrpHDgEIFYwAthHEknyjFBzs/aoPiDO6iX1DwJY5qrIn/ut+kVzF6X1xUXBazGv/9HdBnq7AZYe7Cq5xVFYjqVmjo6hK1MqBMczqAzFyxyZKGg6JzbXnsp2EGSPS9IcAxvf+F788bpMZKSqt6AwztJiVDjOQA60pRjIojDctbNKDnJf2jx9Ho5oLSnDmnxS1+z14yvRYTO2il1KIQoLr7DoEdXzi9yaiU+Y3P9NfzDxl/GqxAw4osoqBR3AWhIH43MNwN5vfE4LT9gKA02BBX4HXIdWnSdXgs4luo7M/ggpp6SXGh8agmfPMAd70gjn5qfj0lMjJcQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a655befb-a8a8-4fb7-70ac-08deff3331d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2026 03:20:47.7335 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HwwFFW+dgmxLeVzYz71TkB7L9U7FTO48W1sGZbptWNdXGO4/Hj+gKL8Py9BpkMhZjuKNZolpG5i7Rs3+15Ra1R2pEaes1mslxk0nvWeYpm4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5467
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

Pass the internal SEC SRAM region and its base address to the secure=0A=
boot controller (via the 'sram' link and 'sram-base' property) so its=0A=
ECDSA engine can read the public key, signature and digest that the=0A=
guest firmware stages there before triggering a verify.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/arm/aspeed_ast10x0.c | 7 ++++++-=0A=
 1 file changed, 6 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/hw/arm/aspeed_ast10x0.c b/hw/arm/aspeed_ast10x0.c=0A=
index 5165dcce59..aeb5a4423d 100644=0A=
--- a/hw/arm/aspeed_ast10x0.c=0A=
+++ b/hw/arm/aspeed_ast10x0.c=0A=
@@ -250,8 +250,11 @@ static bool aspeed_soc_ast10x0_realize(Aspeed10x0SoCSt=
ate *a, Error **errp)=0A=
         error_propagate(errp, err);=0A=
         return false;=0A=
     }=0A=
+    memory_region_init(&s->sram_container[1], OBJECT(s), "sec.sram-contain=
er",=0A=
+                       sc->sram_size[1]);=0A=
+    memory_region_add_subregion(&s->sram_container[1], 0, &s->sram[1]);=0A=
     memory_region_add_subregion(s->memory, sc->memmap[ASPEED_DEV_SRAM1],=
=0A=
-                                &s->sram[1]);=0A=
+                                &s->sram_container[1]);=0A=
 =0A=
     /* SCU */=0A=
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->scu), errp)) {=0A=
@@ -350,6 +353,8 @@ static bool aspeed_soc_ast10x0_realize(Aspeed10x0SoCSta=
te *a, Error **errp)=0A=
     }=0A=
 =0A=
     /* Secure Boot Controller */=0A=
+    object_property_set_link(OBJECT(&s->sbc), "sram", OBJECT(&s->sram[1]),=
=0A=
+                             &error_abort);=0A=
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->sbc), errp)) {=0A=
         return false;=0A=
     }=0A=
-- =0A=
2.53.0=0A=

