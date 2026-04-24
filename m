Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A4EFFB44C9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 08:08:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGBZd-0006YB-Rb; Fri, 24 Apr 2026 04:07:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wGBYW-0005db-8S; Fri, 24 Apr 2026 04:06:35 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wGBYU-0001GV-0l; Fri, 24 Apr 2026 04:06:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oh3LKLSY3BR4ED7l3IUxb9xRNUYfqdoCq19FIlDCeDMUyWpcanjHo0gSvN3BC4nP3ZZGqxchoiozpmoAY4HYeBMxFWRYfPExbqIG7YPNqSx7jkrApJIL/DBLn6GY0q7T3ODsAYCABwa3T5F6Ge6NPEDwjGhvJC91v96XBMAEwc3UlyvSk3GAb9Xkx4ggvx37LBhPQ6IxDgW6nUuEe5q4pZ0RVpeizxrveNK8wvz5tqaOxzQzVIY7yfByHchqtuSfTw0AqsGPJZYi1BjvF9F79K3UYoi1XI9kcMwj26El0z3BZCmlKCBVPZvSwDOFoTcIC6f2C//e6a3DIbsi3Nltyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ch/HK59BYChT4j5YapXptCNxmOgN6FefWpz+IZFXBdI=;
 b=uJLkqzgQkzUF7nkSBh6G4nTwi6fcg9CEz1ZvBPxj7pCD/qh42rNCC9GOeyc2d9GAJ5WY3XRePsCkfhFi/2PWYOIAdVfUGeyAV3LpFgR7R2HH6G+vvk2fu8wxGErI82sKdyQHERco5JXBIzGXHR8j8j5cIVPPeDf7imF1lZ4iCRp+4snfNcHamD+LyQaVIhpalnk90RvYALe9KkGVvOcdR7eT2dy8dqEB2UjwGjR8YkcPHaHXLuJBQYXmsH7cpey+dFKceJHEI/qKFVvB2yQ3lIAo6+wPjPWT0F601OSGNOwsAx7135EYsaVoLgTR/Psus9sWMIQ+MzVgxnvNMhXoNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ch/HK59BYChT4j5YapXptCNxmOgN6FefWpz+IZFXBdI=;
 b=JNhjROhTtai8cDqc0gFsBj7bNTzVB1sZYwet7EKyEcXkZJx04Bee0jlu6DxKb2kCeNDfiltYTpgw+m2fnTFSmm2et8oJQOnsG5qaL0jUvb/SUj+95bXx8gwCSLzXCWUXRecEUqsWviFhiwuaJnTZ0qXuW18PuWqBpJHe+OMjhUkbQzcDg52yuz/Q75/rQ+Uy5lSKpdy7YMsIaIq5GxzmIuJWBfrkELv/LbQoSmIe2lPTPqp6nlKxDCaab5dtxDXKspGnsRgKycB7LCyssgs9JAkkwYDxo0rV30l6xKloNYmbHAqiCZWg0yEIEr+9tgcdkix/IL6DYF0O0gO9K5UFzA==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEZPR06MB5856.apcprd06.prod.outlook.com (2603:1096:101:9e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.18; Fri, 24 Apr
 2026 08:05:31 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9846.021; Fri, 24 Apr 2026
 08:05:31 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "peterx@redhat.com" <peterx@redhat.com>, "philmd@linaro.org"
 <philmd@linaro.org>, =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Kane Chen
 <kane_chen@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, "Michael
 S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard
 Henderson <richard.henderson@linaro.org>, Laurent Vivier <laurent@vivier.eu>, 
 Nicholas Piggin <npiggin@gmail.com>, Harsh Prateek Bora
 <harshpb@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>, David
 Hildenbrand <david@kernel.org>, Cornelia Huck <cohuck@redhat.com>, Eric
 Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>, Halil
 Pasic <pasic@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>, "open list:sPAPR
 pseries" <qemu-ppc@nongnu.org>, "open list:S390 TCG CPUs"
 <qemu-s390x@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 "farosas@suse.de" <farosas@suse.de>, "flwu@google.com" <flwu@google.com>, 
 "nabihestefan@google.com" <nabihestefan@google.com>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>
Subject: [PATCH v5 16/18] hw/arm/aspeed_ast27x0: Set EHCI ctrldssegment-default
Thread-Topic: [PATCH v5 16/18] hw/arm/aspeed_ast27x0: Set EHCI
 ctrldssegment-default
Thread-Index: AQHc08Ee1FwzCW5lQ0ucM0evTZPreg==
Date: Fri, 24 Apr 2026 08:05:31 +0000
Message-ID: <20260424080508.53992-17-jamin_lin@aspeedtech.com>
References: <20260424080508.53992-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260424080508.53992-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SEZPR06MB5856:EE_
x-ms-office365-filtering-correlation-id: c6816363-7800-4262-70cb-08dea1d8412c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|38070700021|921020|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: SXvP/oewvawj1ikqf9mYNV2bEnXgslu3UY22rW6Hx2YYnSbtU5gKtLA8Ch9VQ2a6WnP00rkCkHbMrwW2R5iEF9vBG/3M9Fs7WGqJKLp2J2jqP2DDE14wPhkv0YkG1E9zENoMgTu8UZ+LASpwO1eRPT1pe8BPuZ+4/51zIMhkSBeYMjZQL7kLf/Zn8AxgTAVA04S1QhkMzZkRzq0m9O80sYm0PJ9PMVsk/o5l2YNVNQQ+Opw6n9jhqONhQ1abam/LhMpRfd6RNt0UQIDXxCCmh0CiZz5beqx3UEBG5qYq+YBU3YL2Ws0HCWLj6ycrngi7whsVXTQCv4m5hmWHkrhQjOh05bwYSMuW85mPw5uBjPacQghLx0OfkQpry/fJswT968KrtEh975PFhu5AG1uNp3KEJ6sJ0n3qv5qMQ+40Tlgc1AIMHdjHm2MKygCA2QAIm7uJeVZ9ltr5AmPUEafZXs8sI4g/NGjRkU4eBJ5VSv8H/6GNd0n4/4zk/STJBjjzst7P0dN8CKsDJbcKgcpSRL4JdIe4nMCRlZ4qXO2saRkVor6q5Qwmg8lGWm69ZBw0g8412DmtYQqvBUQw003OIrMaTgphwos7i3Sqbgrvh8v86TCek4E4+PCuOZ4yg7cFh4A3c/mAl+ojryi/pdkXzNgEk0zik083A/hr1sAkleaKfF6x513wHbqM4b26cvqNGtKI47eExtmxwkVpQ655oaIURUKTDvRPkx/lBzTRo4ywuR8gktXKGfqo5t3yDOmFO2sSw79nEbXOWpPaQF5TBINirjVyRjl0F9bA/4U23oM35ze3TBpOL6nMB/Squd9X
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021)(921020)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?S1jdtIHmbtWW1xGHId88bqMRhve3S5Arbi51zvEJbmyiuigiYkZA75YkGo?=
 =?iso-8859-1?Q?r96f0Zsqiz2lIXnNrm2WW0aX9rPh5Ps1xYkuwwMxzBOOUCvsTzr7pBCow3?=
 =?iso-8859-1?Q?M+PB3/xifsGAdX60gkFZSXZ7pHkfeC/nD8RzH9jmENAhBenHJ8nQu2HeuA?=
 =?iso-8859-1?Q?ECr2r711L9wUVELjFiP/YJg1xhZNgKJX636R1RyVrv/poP4JGzw6acCqcT?=
 =?iso-8859-1?Q?tIOTK0nBCzYN6nayWaMNvTVnFMZdFlvymhOgDWWoIXsDGSbVwxQOhyoEtT?=
 =?iso-8859-1?Q?FQYZSQHsn5EtmGQgGnfzmbdTHbRmOkQ1WNvHba88SRI1JBlQRB1MIL9CRa?=
 =?iso-8859-1?Q?5tv1PF84W+x+hGmGNWSBgvCJtVaKm5RYn3cDn8yoRrjghOIDaB/9RvRsrh?=
 =?iso-8859-1?Q?ntY3f5Eq8q/rRUvlxNm0O2BqBaHp0Vh3WSKvQJJfzPsswwjDpsyZtuvK/k?=
 =?iso-8859-1?Q?URaH6e7VeFCJtpGIncJ/YTx9+rSZl5z2RYe0DnBzE2gwIFs9LFkVo6PLUp?=
 =?iso-8859-1?Q?z3vTrbEEabYWvHUUAqWtyTaz1lRz1UVOdD9wyFzf6HD/UoSQFKaP+n9mgc?=
 =?iso-8859-1?Q?BHzimxt/nV3cNVU/pMbbCOfuQ9m8DHI5CrmUZmtFbizd+sAoMrwaOEXlij?=
 =?iso-8859-1?Q?mp0bC7UNB8e/7om4Hu63DVRlUHm7IbSQTvo0xOKMJjsMHKQloH4pz+m35+?=
 =?iso-8859-1?Q?s32xLbGofVhZ/X2ryEgJpC64iLYQdfMlHrzODYd53v+4lp6sv5tYejlGDE?=
 =?iso-8859-1?Q?BfgZRYqtp4XLA85SHNc7EWYBY3KrpNTou5rFeb+csvXxhqfbRSw2wdn0Sz?=
 =?iso-8859-1?Q?A+Hed8sEWLCAcWB7/e8vdPGtY+Dt4uFYwxcG3xtr7wBlxTl/w+5nwZrDVo?=
 =?iso-8859-1?Q?mcIEkGOij23JMBtfPYGZ7gsADoxaaIWFWz6g3w85ML5E75TJ7ZOzvR+oZ8?=
 =?iso-8859-1?Q?etkXkPi8FztHrfdpF/I0gYqY2IChs5mAJvbTR2MMKK2M4sM5hJtBQxrAtz?=
 =?iso-8859-1?Q?QogxiON3Ud03LUS6lD//mpwfuxzv2U8W/Eolqy+u0Ygpvd5XvS6TNlJXHN?=
 =?iso-8859-1?Q?YuxBjs7H2JZy5sT/dqPmhi2iGaEjtJUGzY94xpehmsu4HY3yxxJ5tD5DNP?=
 =?iso-8859-1?Q?rEzrI59wEpBPqwuYkSNW1viZFiX/hD6rcRV8WyZCahi991Z9GIaVR/wV5d?=
 =?iso-8859-1?Q?AWBWRqmTvD2hJZQclUbWhuAd4Tq7EQ+bJFR3tzoqU2jRiqvw3pn31Yw3J+?=
 =?iso-8859-1?Q?Gj/wxklwUNjyuwXuOxrF9Sbatr4Lt7J3olDfnRN1Y9EPSP6KNGLfYaUqpW?=
 =?iso-8859-1?Q?k+bbrqDNfJVCkMzvmBFq2aPdhlU3hPKOPz4eTeCO7NnyokSpMbYNP+0MBQ?=
 =?iso-8859-1?Q?3SgRkTvLRpizWlv96INsyfwjyhchqJlJOoNzV1K+c7+80RXXxaR8Gf49MH?=
 =?iso-8859-1?Q?TUeP9Xj2HLYL/LWPxnx982OyPIosLOnpBCXtKk5jyFlws1Fi9oQvQEIk18?=
 =?iso-8859-1?Q?zHQd5jr1gx1DH/y8Bx95ndC9EVowBqwry8vHoyfvbWx16f4miBTqc8O0gH?=
 =?iso-8859-1?Q?ux0IoKUcbtQM8CqXlFxz3+5qXQgfszLGmct+bQXjoXrnCIaMMmu2UN9/WM?=
 =?iso-8859-1?Q?V72YFBzq2x1cQVs2DZcCH0Nhm0fpF1eYcQmsf1UMFzY1Gsm2h/NU/Lf3W2?=
 =?iso-8859-1?Q?PmPVMptL1k0NKbiYXngEGULMZNRYT3k74GhKFe1P/wofiZnJuSSTBrl7QH?=
 =?iso-8859-1?Q?sUbIp8bJmpep320x9fL7HkIBlIbzff76F6WVJAKqLhCTELfVUnXBTqpWQo?=
 =?iso-8859-1?Q?cacEedsq0Q=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: a1KDb2IOqc3SXOasUjwmI50hPqbsOdFRlbpvUsHgq+bzWujhbVD0vnA162EUozmpZ78pT4YPYzZtutsvWsW2udOJ/tqfpqeXtHFsy/a4fUl/+zp6yVjaSLUj42EjEYNVMqkpoe6mdKT1JGK2uNnCDGWZJ/Lzy6CJKQk5HjrVTCWaidawol1WT5HA31rlvrC172N215/1nJovq+sQ/82nkW7QdoeLPyW85btvH14SDqQ34BwPaXOUDp9Y73G+dI+ZgoMBGJb6ODqFDNAYQ5RCjq/WrXpopQ9eM0q0Bwo/19jdHbd+HhgyxCx9fVX6MfwilNHSjRY5E8OsVHpR8Wnwpg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6816363-7800-4262-70cb-08dea1d8412c
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2026 08:05:31.1254 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2TNEVs7yGUkdZcfFNqVmi0U1hzLtMerbHNpvJp2rkYf0Joz8w0uZQquLz7sW9D6J19LhGbO8addfzotRaaTyTCaTY4Y4+LNoET1gNIrOneQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5856
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

On AST2700 platforms, system DRAM is mapped above 4GB with a base=0A=
address at 0x400000000.=0A=
=0A=
The Linux EHCI driver programs the segment register to zero when=0A=
64-bit addressing is supported. As a result, descriptor addresses=0A=
derived from the EHCI registers do not include the DRAM base=0A=
address.=0A=
=0A=
Descriptor memory is allocated through the DMA API with a 64-bit=0A=
DMA mask, allowing descriptors to reside in DRAM above 4GB. On=0A=
AST2700, EHCI queue heads (QH) and queue element transfer=0A=
descriptors (qTD) are therefore placed at addresses starting from=0A=
0x400000000.=0A=
=0A=
Set the ctrldssegment-default property to 0x4 so the upper=0A=
32 bits of descriptor addresses are adjusted accordingly. This=0A=
allows the emulated EHCI controller to construct correct system=0A=
addresses when accessing descriptors in DRAM above 4GB.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: C=E9dric Le Goater <clg@redhat.com>=0A=
---=0A=
 hw/arm/aspeed_ast27x0.c | 2 ++=0A=
 1 file changed, 2 insertions(+)=0A=
=0A=
diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c=0A=
index 87dcb82e1b..0cb39dc191 100644=0A=
--- a/hw/arm/aspeed_ast27x0.c=0A=
+++ b/hw/arm/aspeed_ast27x0.c=0A=
@@ -856,6 +856,8 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev=
, Error **errp)=0A=
 =0A=
     /* EHCI */=0A=
     for (i =3D 0; i < sc->ehcis_num; i++) {=0A=
+        object_property_set_int(OBJECT(&s->ehci[i]), "ctrldssegment-defaul=
t",=0A=
+                                0x4, &error_abort);=0A=
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->ehci[i]), errp)) {=0A=
             return;=0A=
         }=0A=
-- =0A=
2.43.0=0A=

