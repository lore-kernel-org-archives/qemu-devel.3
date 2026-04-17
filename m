Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44000F8E499
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 03:31:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDZtC-0002In-J4; Thu, 16 Apr 2026 23:29:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wDZtA-0002Hs-Rn; Thu, 16 Apr 2026 23:29:04 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wDZt9-0005oG-3J; Thu, 16 Apr 2026 23:29:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LmBNZx8jPPNGOQInpyKmgGbXYXzv7fDFILSCowZY4GAdq3Xw45gFaHgiDiYM0Zf8vuc1cGxqo/ItOpZ8Y8bhfq7F+HMGh0DI5wnHXqZoSQw58UieUBZA9l63kwUEicf9CcccCc8QQvrvTVUmSVCtUsfM1cGHQ5Tpoi3vEEmCcxc7HFGzcdCM8f2hOGphHsTNPUtWe4OIBEkWCvWhNK+gMcoOMRvmC8ujYVlNN1w3ldKSluqrBllZTNv2GkCODGwln8ZGi8kqgXPotjC2/ImMy/Bz1G0yt1ywaw+ZfsToYc006k+NDXM6LuqkDxxqm/RmL3LCwK7asQLeJX7WQ6Xxmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uyaHpbG6hh0JcTZB9avx2iqxVyV4vSDJmewhENDLklU=;
 b=gMRCAhP/FAWcJXD8ZGMfxkQE+nXEY7y2r30aNb3rgSRZ4hw2bpKdT8/7MQ3H30w0vw4Lzq68fvwkTe3jgIaXwSNOZ2SXgLyhB2Gth2m2T+vc+Ci9L2JcfRUfICHUoTwIp0B+gaUanUv7Wv+MtPmd4i6W157sdE/1ueDo8kKiDe14/5T0IwCslVjRnsq/ZdGX6IQVnYWMojI2JRsKVfEJolTZPk0cCN3jdczePa9PjfUwPIyf6zEfhSrrQ1Q3PRklCtnZFln0tlQfQN4pOjkUS1FxWAi3VYZ9xWTShSGYt5rOPGHA0wWki+OV1tP4Ckh1lAPy2emZJuNcS8yf5cmmVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uyaHpbG6hh0JcTZB9avx2iqxVyV4vSDJmewhENDLklU=;
 b=c7q3VkAhxibdCUho03EskqP//tE3XBoGkem/LU4XQHiM1HSsMxTtjl0xMIQGplYYJ3RZX0r1F8RE3hFFi6AbgYaQapIxqMkjFdYVZQwaarjbMmvT9EfizZ/0MgFmMxn/HVW9nctyQCuGT9FzS34jLmVDhlPbmpmFJhY+WA5MG2ygCXpZ7uhO9TrZiENeyH2kx4VbH/aUiIijGTNhuoQuBLkiiLzrepjcYAqgQoHDxu9imIVvGiFDRjU9ZRT858vPg21gTYd4XZ6PMw/dtnrta82LTLq9JWEycEMmmto3QeToPHcy1hz6tgkKhHGaGwlDEP0AizAQq9+sM/m1FCwfWg==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KL1PR06MB6299.apcprd06.prod.outlook.com (2603:1096:820:ce::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 03:28:49 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 03:28:49 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Pierrick
 Bouvier <pierrick.bouvier@linaro.org>, Alistair Francis
 <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>, Hanna Reitz
 <hreitz@redhat.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open
 list:All patches CC here" <qemu-devel@nongnu.org>, "open list:Block layer
 core" <qemu-block@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v4 08/21] hw/misc/aspeed_scu: Implement TSP reset and power-on
 control via SCU registers
Thread-Topic: [PATCH v4 08/21] hw/misc/aspeed_scu: Implement TSP reset and
 power-on control via SCU registers
Thread-Index: AQHczhpOZDVHLsCUQ0yoyGH5MyHKIQ==
Date: Fri, 17 Apr 2026 03:28:49 +0000
Message-ID: <20260417032837.2664122-9-jamin_lin@aspeedtech.com>
References: <20260417032837.2664122-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260417032837.2664122-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|KL1PR06MB6299:EE_
x-ms-office365-filtering-correlation-id: cb0d7bd0-ef37-4121-96ff-08de9c317104
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|921020|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: SzQGIvd1o9dJzhmZQ3j4SDqHm5cg/4ArQPzkemot/Nz9kE5QztAOYjWW1pR6X4Kf4uwId8+lQI+qb3EiPVpYuaAVtJZdsiwCEB6yru/AGUpzN40tfqjApww7OVzZAYbEuKKdcXD7ERNPpbFm8lkzQ9NmClienwSEl1o/1IX4GimZcbRJ5jfotBJoPRY1Bu6IBuKOCf1e/aozV3sw+ErNj0NmvXbj8Rz8YALEo78azxiP3lUpFr1SqGD2NBlDWdwl9D9nJQXLjtyvGS36dWcbt2Z6C2dTzbi2WDLtd9qwF2NHBCEJA4ZqfYf4axdBj5ScchDeQZi3lJLL/365nAozNqwRMKMpDSxWYo/VAJejfF/8Ua3DoTet9Z4ELgc1nhyt8t/c4Av6bPHuTJmCxoi4w30EqK3D3yaRI4ExvSII65NVPJXcEWmggj+D08TiaA6CCUId8z1+QPsYzYGCFsRucGp+NZBPOOnhrw/e0qNjg57voZGGeX6FAxgJqLWU5jBr1LlM3hb+TP/yiUTDTU4n6Ol/AjKBfKJq1gyBbTH6CL+adugm4wo6CdNTH1gKqqp5tTrEXBrDvVA1LIyInv8sapmE9aCfBRmBHsG7z6Mc+PJCrMFgFjruaoSogqnleUYXAt91LsgBgWETXgb41LtJDCmwGqxVTLC5ubUT8Q22fuWikxndh653Fn148a2GBjaw8D+Y8Lft7gVxGBd/Jt7u50+o/iFpx7adbKWwIkVJ3O8XnLcHVPF8dFxgsf7obeD0GqrsFtKSSoGatbvNDKTfPHH3LO0S81qW+RtuVCReRTuleLTJ16btYWQII+P8Jwqv
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020)(38070700021)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?IlaFGlo8NVJyzxNqL4PN7RLSeVb4xTqQeTI3sdayFoHDhMDgKdQ3dHt22n?=
 =?iso-8859-1?Q?2epjrEnX6dFSTmv4bz0gzRg60AOjqHzOXDWWUMaNN3Z261ody0v2XVPb+M?=
 =?iso-8859-1?Q?/7NA6eEVZDZ6RqYSl3+YN0cxyDCp5e+O9oMZxYpG5rI/sazvNXEddI9XnP?=
 =?iso-8859-1?Q?fUTO2EGUAVGUl+SMERfRInB28QzgcHRZ+G3h6nIbSs+coPJ0ss3hrLxeCU?=
 =?iso-8859-1?Q?scMOlwJUkaQ0cyqpToClm7VzTidlaLDX/vOp7ij5dxvmrwyNX3osMQ4pNE?=
 =?iso-8859-1?Q?FHXVZDtiNDUEBtiWAQiMy5JRfdPT6lO3ycVuUetM//TUFHR9Iu4kB4h0nr?=
 =?iso-8859-1?Q?PoZLLQaSTHgs/uroFJyZdCfPJlpUOEm87bgYGXTz6GaOLPBcfInBP/8EiR?=
 =?iso-8859-1?Q?cqnIcqz5fxZ9N6ut9ITGmGTYboG/EOeRXOMFYnYoKd9umvviQd0+9Ab0nv?=
 =?iso-8859-1?Q?/iLSLFyvLvBBx8vhyLhMqo5X75cdaUUkaUEar6R8HxBLkKJbBmZKMUkGU0?=
 =?iso-8859-1?Q?eaStaE2ls21gz2/kcQeB78+tz5jY15CRx1b2wP7cXAQGwzkAIHY80qyILX?=
 =?iso-8859-1?Q?iiegq+XZ0m1ZX36/6lbS10TPdaEf+6pEE1nKcyZYvQ01DEXmVw2VGr7OjA?=
 =?iso-8859-1?Q?ez0wLqyYkmD2aJrnNZff4rSYwG59Tg2xbqGznnpuxYVb5qMHfjQVLc7h4d?=
 =?iso-8859-1?Q?BBAH4oQKX4Q5XzTzzjyUKLov30IOmeO6pGSQl+dSPIiWoO8GDJtuvsEITf?=
 =?iso-8859-1?Q?bN3/Vug3VG1LXDWQzALr10k5QKrPsm6ki+OZDvNZJAt9fUCWoLkIPpRVp2?=
 =?iso-8859-1?Q?vjSlMpzUSIpGu3ShGAh2Ib63lO4gXwsoLMle8HZ3RAhYFU6D8ZCmaIEk1o?=
 =?iso-8859-1?Q?Oh85o3HZ3AVP19YxiHgxdRJigU+pRINzSXI4Upt8MGRlULybSFDLs9OaQM?=
 =?iso-8859-1?Q?1Igoy6desKAmRr9csPd/0lbtoKuU04vnUaozrq8qjUsOkFujLuFpKhnw1z?=
 =?iso-8859-1?Q?bP64uwixs0RNVjf77sp6/fWHzwraShoT3FLrGNOx6jPYkKnFRLzIfXZkCG?=
 =?iso-8859-1?Q?TtqDMOcJT8NkxVeNbJAq8zn/9C7jTt73L3fTO9yq4kscp6QvubEwXreQV5?=
 =?iso-8859-1?Q?bZRD2lo6oylirzlAL1MqfCwnHhAoW3t1cuA/b6dTP6inuuTZo5J7ipsS8J?=
 =?iso-8859-1?Q?z3HXwr8eaxjY3754Kq4hLD/7CbP7OKMhDXg0mjUfWSeihHmfkc3b7W1HtM?=
 =?iso-8859-1?Q?UQ4UZqC8AxzZ/tTwY4pdYZWT86l+JjD9u7sX0DKcoTy3cEKU4/yCbaY9vR?=
 =?iso-8859-1?Q?IbAfteuHaoM3udWBKFOAyA0bdDFfi3URyfX8bGPcx4NSVuX5PT2dg+oAFm?=
 =?iso-8859-1?Q?+l4t6iOEQpYi9G+Oc6exWVrwqMmI7wyLdgnFqgpoQHgPgow6DWIIdYT3rr?=
 =?iso-8859-1?Q?YDzbCQbq2rgDQixGarjEDmr59R09Lh1R/m1bjpMdkeHVb3SUPu8zzPdWfo?=
 =?iso-8859-1?Q?z3HN9MWLHzqwyUz+dggCNlaAtAQpBiM40Y1+Q279v6b5lQzMSsa7nyoUV8?=
 =?iso-8859-1?Q?pkIGJRFI/C+CHwXvcu5AMJJdfov3TCCKMcBXubNzBC7/Hrq4TL5Lr8flJ5?=
 =?iso-8859-1?Q?VWPbr+9Qe/l0RWGHtM+yWqld1MbGvXxdMA0sD2yrkYhuHzvfrMoEzzublB?=
 =?iso-8859-1?Q?cc5FmuVNbC9O2xfHdX64SdnETJrojzfOdFDJ1nBi3g3tIiKS7bD/hKb8Cv?=
 =?iso-8859-1?Q?E4NLWIlFzSar0wRaFGxlU9CHjzle0UynC52RQMOqgREds45zqJ8NN13Dxx?=
 =?iso-8859-1?Q?yZnavICJig=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: MSdDgdKmwgeMTxISMQmhVV4t3qVHdyj9AYvDf9Gk3NbPQ6w57jozZy3S9sL8h/xDl8L410J1+VtVq+MI/tG3Aqs74kqQCutfi1Bne0wAdLtr4CndghxyjrOGlnjgPLQfAtBsSk0P7+5bjXAVjs9bdYWjsbr7zDztmUz2N4femc9FLIgTKgGd4RW64ZMU1i2r3BREmRS+eLUYwNVocheZNjNcNprhtF9hN7sVZjxmF8Z9fmNj5fCy4VDGWu9lLViqPKWsAzQUO5P0LlM70S0/vuyen4eF2v2BZK0VaYkVZydrisvv9BxPuZzu07uBbXLtVIcDIK1fP+WbFHLq5OmN+A==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb0d7bd0-ef37-4121-96ff-08de9c317104
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2026 03:28:49.6430 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FWCmbl2xQU0xTUzd5T/4TVGWaJRj1tJfAVjX8AHeHgtawGsecsSmIb4rQx1V+lpvNxf7iL5jHIhiFDZSmMDzzHJlYPbDSNZzmY2XR2M/9Rw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6299
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

This patch implements TSP reset and power control logic in the SCU module=
=0A=
for AST2700. It introduces support for the following behavior:=0A=
=0A=
1. TSP Reset Trigger (via SCU 0x220):=0A=
=0A=
   - TSP reset is triggered by writing 1 to bit 9 (RW1S) of SYS_RESET_CTRL_=
2.=0A=
=0A=
2. TSP Reset State and Source Hold (via SCU 0x160):=0A=
=0A=
   - Upon reset, bit 8 (RST_RB) is set to indicate the TSP is in reset.=0A=
   - Bit 10 (RST_SRC_RB) is set to indicate the reset was triggered by an e=
xternal source.=0A=
   - Bit 1 (RST) is a software-controlled bit used to request holding TSP i=
n reset.=0A=
   - If an external reset source is present and bit 1 is set, bit 9 (RST_HO=
LD_RB)=0A=
     will also be asserted to indicate the TSP is being held in reset.=0A=
   - If bit 1 is cleared, RST_HOLD_RB will be deasserted accordingly.=0A=
=0A=
3. Hold Release and Power-on:=0A=
=0A=
   - If RST_HOLD_RB is clear (0), TSP is powered on immediately after reset=
 is deasserted.=0A=
   - If RST_HOLD_RB is set (1), the user must write ENABLE (bit 0) to TSP_C=
TRL_0 to release=0A=
     the hold and power on TSP explicitly.=0A=
   - Writing ENABLE (bit 0) is a one-shot operation and will auto-clear aft=
er execution.=0A=
=0A=
4. Reset Status Clear (via SCU 0x224):=0A=
=0A=
   - The reset status can be cleared by writing 1 to bit 9 (RW1C) of SYS_RS=
T_CLR_2,=0A=
     which will deassert RST_SRC_RB and potentially trigger power-on if no =
hold is active.=0A=
=0A=
5. TSP Power Control Logic:=0A=
=0A=
   - handle_ssp_tsp_on() clears RST_SRC_RB and RST_RB (if not held), and in=
vokes=0A=
     arm_set_cpu_on_and_reset(cpuid) to power on the TSP core (CPUID 5).=0A=
   - handle_ssp_tsp_off() sets RST_RB and RST_SRC_RB; if RST is active, als=
o asserts=0A=
     RST_HOLD_RB and invokes arm_set_cpu_off(cpuid).=0A=
=0A=
The default values are based on EVB (evaluation board) register dump observ=
ations.=0A=
TSP reset control shares the same helper functions and register bit layout =
as SSP,=0A=
with logic selected by cpuid and distinct external reset sources.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/misc/aspeed_scu.c | 37 ++++++++++++++++++++++++++++++++++++-=0A=
 1 file changed, 36 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c=0A=
index d6c60b1d34..6512b5fccd 100644=0A=
--- a/hw/misc/aspeed_scu.c=0A=
+++ b/hw/misc/aspeed_scu.c=0A=
@@ -147,6 +147,7 @@=0A=
 =0A=
 /* SSP TSP */=0A=
 #define AST2700_SCU_SSP_CTRL_0          TO_REG(0x120)=0A=
+#define AST2700_SCU_TSP_CTRL_0          TO_REG(0x160)=0A=
 #define AST2700_SSP_TSP_ENABLE          BIT(0)=0A=
 #define AST2700_SSP_TSP_RST             BIT(1)=0A=
 #define AST2700_SSP_TSP_RST_RB          BIT(8)=0A=
@@ -155,6 +156,9 @@=0A=
 #define AST2700_SCU_SYS_RST_CTRL_1      TO_REG(0x200)=0A=
 #define AST2700_SCU_SYS_RST_CLR_1       TO_REG(0x204)=0A=
 #define AST2700_SCU_SYS_RST_SSP         BIT(30)=0A=
+#define AST2700_SCU_SYS_RST_CTRL_2      TO_REG(0x220)=0A=
+#define AST2700_SCU_SYS_RST_CLR_2       TO_REG(0x224)=0A=
+#define AST2700_SCU_SYS_RST_TSP         BIT(9)=0A=
 =0A=
 #define AST2700_SCU_CLK_SEL_1       TO_REG(0x280)=0A=
 #define AST2700_SCU_HPLL_PARAM      TO_REG(0x300)=0A=
@@ -952,7 +956,10 @@ static void aspeed_ast2700_scu_write(void *opaque, hwa=
ddr offset,=0A=
 =0A=
     switch (reg) {=0A=
     case AST2700_SCU_SSP_CTRL_0:=0A=
-        cpuid =3D a->ssp_cpuid;=0A=
+    case AST2700_SCU_TSP_CTRL_0:=0A=
+        cpuid =3D (reg =3D=3D AST2700_SCU_SSP_CTRL_0) ?=0A=
+                a->ssp_cpuid : a->tsp_cpuid;=0A=
+=0A=
         if (cpuid < 0) {=0A=
             return;=0A=
         }=0A=
@@ -1008,6 +1015,28 @@ static void aspeed_ast2700_scu_write(void *opaque, h=
waddr offset,=0A=
         }=0A=
         s->regs[AST2700_SCU_SYS_RST_CTRL_1] &=3D ~active;=0A=
         return;=0A=
+    case AST2700_SCU_SYS_RST_CTRL_2:=0A=
+        if (a->tsp_cpuid < 0) {=0A=
+            return;=0A=
+        }=0A=
+        data &=3D 0x00001fff;=0A=
+        if (data & AST2700_SCU_SYS_RST_TSP) {=0A=
+            handle_2700_ssp_tsp_off(s, a->tsp_cpuid, AST2700_SCU_TSP_CTRL_=
0);=0A=
+        }=0A=
+        s->regs[reg] |=3D data;=0A=
+        return;=0A=
+    case AST2700_SCU_SYS_RST_CLR_2:=0A=
+        if (a->tsp_cpuid < 0) {=0A=
+            return;=0A=
+        }=0A=
+        data &=3D 0x00001fff;=0A=
+        oldval =3D s->regs[AST2700_SCU_SYS_RST_CTRL_2];=0A=
+        active =3D data & oldval;=0A=
+        if (active & AST2700_SCU_SYS_RST_TSP) {=0A=
+            handle_2700_ssp_tsp_on(s, a->tsp_cpuid, AST2700_SCU_TSP_CTRL_0=
);=0A=
+        }=0A=
+        s->regs[AST2700_SCU_SYS_RST_CTRL_2] &=3D ~active;=0A=
+        return;=0A=
     default:=0A=
         qemu_log_mask(LOG_GUEST_ERROR,=0A=
                       "%s: Unhandled write at offset 0x%" HWADDR_PRIx "\n"=
,=0A=
@@ -1036,7 +1065,9 @@ static const uint32_t ast2700_a0_resets[ASPEED_AST270=
0_SCU_NR_REGS] =3D {=0A=
     [AST2700_HW_STRAP1_SEC2]        =3D 0x00000000,=0A=
     [AST2700_HW_STRAP1_SEC3]        =3D 0x1000408F,=0A=
     [AST2700_SCU_SSP_CTRL_0]        =3D 0x000007FE,=0A=
+    [AST2700_SCU_TSP_CTRL_0]        =3D 0x000007FE,=0A=
     [AST2700_SCU_SYS_RST_CTRL_1]    =3D 0xFFC37FDC,=0A=
+    [AST2700_SCU_SYS_RST_CTRL_2]    =3D 0x00001FFF,=0A=
     [AST2700_SCU_HPLL_PARAM]        =3D 0x0000009f,=0A=
     [AST2700_SCU_HPLL_EXT_PARAM]    =3D 0x8000004f,=0A=
     [AST2700_SCU_DPLL_PARAM]        =3D 0x0080009f,=0A=
@@ -1067,6 +1098,10 @@ static void aspeed_ast2700_scu_reset(DeviceState *de=
v)=0A=
     if (a->ssp_cpuid > 0) {=0A=
         arm_set_cpu_off(a->ssp_cpuid);=0A=
     }=0A=
+=0A=
+    if (a->tsp_cpuid > 0) {=0A=
+        arm_set_cpu_off(a->tsp_cpuid);=0A=
+    }=0A=
 }=0A=
 =0A=
 static void aspeed_2700_scu_realize(DeviceState *dev, Error **errp)=0A=
-- =0A=
2.43.0=0A=

