Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CBE1F433D6
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 01:51:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDBsL-0008Gq-5S; Wed, 15 Apr 2026 21:50:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wDBro-0007sb-N0; Wed, 15 Apr 2026 21:50:11 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wDBrm-0007Ut-SC; Wed, 15 Apr 2026 21:50:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mb1u1C/WH5XJ0V6eSkO9q5wl6IGw1FJ0pV3xJPSxykvGP4yHeNDCx4bnnXEIMwkpbmzq/VOx4gvFFjutLwE7fo4QvOYyTrheCD7iV1ShZPg7ecmdghlePVk6AbtKXW0p8v+CAocXT7mALGYmQzWikcQLD3T+AKfBSTk5WUbFiZZfCtLq9K/Iq5CbrxqjEg4X4VaY/1w7V0/gKuJQvH5xwd3vVRMhFPa6CPEiNSiJT7Hp4Vhe4qkP3dI15sudjoW+bwJhWOdr6WFEofRIdJP1BFO4u1zrHmpllpvNGG2rBjndZKO3V2k2RVkCg6v8kBYRVWsW9x0ZGzj/mJocb7nTiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q+mmQwIDcXjYZQ7eiIgMS2IKUaumd4IMqBC+8JCwHS4=;
 b=PiFtip0vFwczYrJMfmb0HD/YAcOIQFFmECyqm2V3WehUsjfU8lLTdXFtdhMXdjPlw/cS9gvrrtuwvzGSmdgXH59JGbySITJhi2ZpjWFRWyn//XcW5rH97m9xFRKl+209q2cFZecS8qqAyIo7rejUn9RLnAffRez/l6T39lWhgclBFztXoaI32vaOyWiLXTGres5Vt4XHqW5R/gDy7vl9HJ1UY8+yLFZ1NjtWJWO6r8rIaOJ73apFakW1EgHdp7398xeib6YhH0z0tfMw230orRwALhWWkQkmseyTOIU4C1T3+XlZ8S+3PoXGdKjs+P1weYosyPAym7oL9Vz/ltWzdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q+mmQwIDcXjYZQ7eiIgMS2IKUaumd4IMqBC+8JCwHS4=;
 b=BVh2K0Wz00dcMNkfTIPiI5IUrn2x4AxDMZeVAVane4EomfrhAGqiLdFuzcgmh5N+LFpl+FkqlxXnrePfePB4aTIG/GllxTj6JooNkIx8M4/PzeRtjYk/J/5A3zlsycyzIkwe+BC46gQ94KHCUio9zAPeIOxP3lza2OZ3J/RiSNA+nyHKWimCIhv7jgZHuoGqnJEKC7caJdIHGQdbyA1Rnp1ejdVS45PsLbyCrsMIzjiBR8Ol7Jj81X5YSx51H8WyYebDa4+TpvhACyFLFDbWwCXU8ctv9X2sOLOPDOdf3f4EtxMNd3t+zh5Tw4GWs7yzpdruKeo2TraS72zQBL/tiQ==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEYPR06MB6202.apcprd06.prod.outlook.com (2603:1096:101:c7::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Thu, 16 Apr
 2026 01:49:45 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9818.017; Thu, 16 Apr 2026
 01:49:45 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "philmd@linaro.org" <philmd@linaro.org>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 "flwu@google.com" <flwu@google.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>
Subject: [PATCH v3 08/17] hw/usb/hcd-ehci: Reject CTRLDSSEGMENT writes without
 64-bit capability
Thread-Topic: [PATCH v3 08/17] hw/usb/hcd-ehci: Reject CTRLDSSEGMENT writes
 without 64-bit capability
Thread-Index: AQHczUNMTNflNW37RU+bzbw6mVnqig==
Date: Thu, 16 Apr 2026 01:49:45 +0000
Message-ID: <20260416014928.1279360-9-jamin_lin@aspeedtech.com>
References: <20260416014928.1279360-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260416014928.1279360-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SEYPR06MB6202:EE_
x-ms-office365-filtering-correlation-id: d38592a4-ce9a-4c1c-56f8-08de9b5a6f69
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|38070700021|921020|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: 7p4ksrtEbdBIEIFuTHUrUCipAe01/17kXSddnC++TJHGgySxiQEoos8uIJ6qNlFpm0NkccOxAXw9lkKyG1TYQOUTRkDA58p/nAeNNsqTuty96pgFuRRVVDeytyf3N3/ZIedS5xsO/FGXLjlcfP2HVjSJwMNTxOKUSJVWXVhpmv/V5rmAOKRsX8NATl/GYNiPu0qK9eCJbieZpsZIL+pKlSeFjeBsmB6G35YNM0aTmlGdUMyDFd6xarp1RAFQizMiDvMrqt3BeGmDTfPjbqoWNleU/otUTr2ClW4WRj/P+gDJHvv4puAGVjxUYgqoTUUqH51evx4FoE9vF49iW2UYQ7kMOgbXcQuKDv2PAEklxy6oBKNr9ry21xpT6pi4BNLSirOoV7mepXSC00DsuGJrW5uzVHfiffUMJVnD66WwFrEh6gNZXVB2wImVgAwyPhqi6i2eD7GY1S95duDihKmh2yg1spQXafFydxnB8E4Rlvct0hJ8fHx9xLNXzhnwxe2/EwduFJDhQcPvIN7u0a5P3tkeIng/jSCIt5KyrgaVRsQw/0l0ziP8Y2QHFaPYyEFBJfq4uCPKhis2X4xDBO776IPzw7QWgBX/6gKJV7+KvOuFgLpS0rH7e4ELA5FvSSKzIMC6LnwcVux2AGj5RL3tpp7VC9vPvmfoDXo5bvDlIULYMf08BDQeCENfgZhwoCU73U7jg5bZRaUfm3+yLC8oOuueqEEpnCeduz+Mq6IQk46myiVFZEMoetWVAF3uE7CuLad+Q5R+ZhAaH5P8VSiBAJKe0jDqAJzYwsLmkZ+yUQQJ4KxgQmq34+AhU8bjeyVJ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021)(921020)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?icqSRBBtUOROsLPWBDZ8d9wrzWemSZAXi/9Ki9fk5zNxWpuHt+6KGIV+J+?=
 =?iso-8859-1?Q?hJl3dCNOTLhktczL/gAREjg/wG6Fd8LczMocURM6D8ROTS6kWynet65J5n?=
 =?iso-8859-1?Q?u6jenZaJnoxjSw74lkclGk+yttbL12bHhX0Pr7spx//dLtt+bXGnsbvi6C?=
 =?iso-8859-1?Q?0OP0GAsKhf86phZPUjS5CwzWRtO1iabpC4dqDBvgw8PtHUlVwFjab+E5fS?=
 =?iso-8859-1?Q?lsYjQelPP2hTgHXPUcGbneHumZ9re2DhDWzy+6gGzerzilu4TK+a0rKGRX?=
 =?iso-8859-1?Q?34JY5xiZM7ll2aIryT0OPOFf39MhFaicTFHT/K5mm1DGSXWiFP2g8tXqC+?=
 =?iso-8859-1?Q?at7FejtnXFGeZH3QV4lxNwBFuuKAtLKWV3xmB35SltxnhpYE+4qau9KxhY?=
 =?iso-8859-1?Q?37Oyh0v6H3Rm6cEHU/alL/KZ+YpHwC/5PJVNAOckC38tUIwjDYL2KwF1PO?=
 =?iso-8859-1?Q?YpXcqMuHPBsquWzuqKqoUzwyqbLcmTrnLme9ZVTpxLDJur2jj5cxCxoV5y?=
 =?iso-8859-1?Q?b0RNDVDNZkoIJCKLhHvsX5HQEM/pGtnXRNRFuL4TTtkzzGXX4ugkOJJB1F?=
 =?iso-8859-1?Q?/PazEXoyejRPux7tMIzKx75Vpgs610LBD4VRZmjWkWtVgULHUMoTkxKT+P?=
 =?iso-8859-1?Q?OIDZwaXNQHA8uv9qjDuHUn7XtFTrg5oNRsPymrXqPTOh2GKqNKT6WYgTor?=
 =?iso-8859-1?Q?SQrrz4IhkFWsOFNnhkQQt9C35QMipDRC1eZFYJjZpj/NKlipemSuT0yVlx?=
 =?iso-8859-1?Q?k0KgVXKTCb2Jzw24HwB7ELN2TR0L3T1NFqvKcbi2Qfx0gqWKoApP+bJtA7?=
 =?iso-8859-1?Q?n5qXSzqWhZnMIVLzCkKvCVLC71ckJwsW8o1FSMZ/HqzxUXSPk07tyo+N3Y?=
 =?iso-8859-1?Q?iGa+qr+2OLwBfh0i42VAG5ibVmwvfpX1IZujLeW4oGKe+jt07QTa6jXKTX?=
 =?iso-8859-1?Q?6UFfzywx/5iZcordyyeokN2qBTzJ9/x+K5YRMuWK33OAQewyAY1bLfWDlf?=
 =?iso-8859-1?Q?3SAokWzG26NGc1uuwFl/ii8f7gqVwL8jIAoLiW6QokMvP9sHwqHVTXUHF1?=
 =?iso-8859-1?Q?muU9h4RyeamJwMklLF72X7m2Eg8yY8hLJ0ecTSKQtZPU4P0hbaRPe4C7uY?=
 =?iso-8859-1?Q?x0bV55mHbO7F15Yun/HsHJiG1Rn4+y5tVpiK8JlRGB+ZvljdMhHWPDkV9N?=
 =?iso-8859-1?Q?Srp3umLuPVOlCtRLL9473xqakYfdjyZ6uJf2M+xl9br4Obj2O0rP7euQqZ?=
 =?iso-8859-1?Q?vKyZqE4RBaNNmonJm7VXlwXQv1kVrFtY8WAVDipsfUSWcnJdkj9xIaRysY?=
 =?iso-8859-1?Q?dg8atJ5tVnbf0HXY8B/o2C37x87128pwFTSF6NCAvB9u4UV47f95a0BOhe?=
 =?iso-8859-1?Q?sbMtXINImhSsEEWvy9YRRM0Sxtz0gJJr9OiVM4zqnCyusZMLd7+TS7FdhL?=
 =?iso-8859-1?Q?kmosgPJA99EFl5CdkU1OdeSEd//L7KVyA50Udv0yCfyMIDsDc168zxZ+2h?=
 =?iso-8859-1?Q?pmK/qhC0/FZhOHIeoYkc081ZVMPJhpx9vnlms50EQhoChyaIKAwgfChSNV?=
 =?iso-8859-1?Q?9R19yTsVJUcZ7hyyPKFAqfLXU+10XnhH902Fihb/WDnFnMqvz5gfgWvRkM?=
 =?iso-8859-1?Q?NHGgASzorjQoGaLbx0sYDkfxjZj2uUXyiVJ1q5hST+mZqMpmHLXezPaY3+?=
 =?iso-8859-1?Q?zSPDSqQM9ZvKmmMsYWGbOQxR0ODp5rCFxKzwfRK22JvrP0+fr7RFMHKO23?=
 =?iso-8859-1?Q?TV8SeB+7iGTJ4UhnxA/DfwsC5S6g2K7UWWVGgbRaPzuAhQSqztFpiZI8f4?=
 =?iso-8859-1?Q?4lCZebQzEQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: pEa+2KERKAwhwbp0xteyfGDXnEtEQnu9VFYWGlkqe/o55ABgtEDJEBFqGjHS8WYQFgnxMk4HW4rmqXipewOuAg+gZItf6rlUqMRLerzAmnBpMyfrT1L1RcgRei8C3rC+T0B7kUtk+yrvyv84ek8O+8Y9Jlr2cgem/mVjInMgh82X96GKnyUVpL6/C/rEIc3ySLLCUyxTCcr42ZGb7xc7IGG1ieN4Z36/9AXpeIP8IygKNp+9NELO+OVkgfvAex1bSqRyXQnW27NytaY+TqgJhwTvhMFgYnPPhtn4rjI+kw6MLAm9N/9nFRv2JKtTTfywySGG0tT29pG1tmcNJVVEUQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d38592a4-ce9a-4c1c-56f8-08de9b5a6f69
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2026 01:49:45.1386 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V5QMx2sBXbTR4e+OkvaTOSPQWQqrfdU1iIY8VDQcWdMlzcxvwwla8qyjCKY3Iw5Uk1WQjfEkndEts2gVO+ntGRAUt6dtSEVagV7BB19fKXY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6202
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
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

The EHCI CTRLDSSEGMENT register provides the upper 32 bits [63:32] used to=
=0A=
form 64-bit addresses for EHCI control data structures. Per EHCI 1.0=0A=
spec section 2.3.5, when the HCCPARAMS 64-bit Addressing Capability bit=0A=
is zero, CTRLDSSEGMENT is not used: software cannot write it and reads=0A=
must return zero.=0A=
=0A=
Add a capability check in the operational register write handler and=0A=
reject guest writes to CTRLDSSEGMENT when 64-bit addressing is=0A=
not enabled.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/usb/hcd-ehci.c | 9 ++++++++-=0A=
 1 file changed, 8 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c=0A=
index 6409457186..b9e4251d62 100644=0A=
--- a/hw/usb/hcd-ehci.c=0A=
+++ b/hw/usb/hcd-ehci.c=0A=
@@ -1108,7 +1108,14 @@ static void ehci_opreg_write(void *ptr, hwaddr addr,=
=0A=
               "      is enabled and HC is enabled\n");=0A=
         }=0A=
         break;=0A=
-=0A=
+    case CTRLDSSEGMENT:=0A=
+        if (!s->caps_64bit_addr) {=0A=
+            qemu_log_mask(LOG_GUEST_ERROR,=0A=
+                          "ehci: write to CTRLDSSEGMENT while "=0A=
+                          "      64-bit addressing capability is disabled\=
n");=0A=
+            return;=0A=
+        }=0A=
+        break;=0A=
     case ASYNCLISTADDR:=0A=
         if (ehci_async_enabled(s)) {=0A=
             qemu_log_mask(LOG_GUEST_ERROR,=0A=
-- =0A=
2.43.0=0A=

