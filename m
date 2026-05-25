Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8615BCD5BD1
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2026 04:47:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRN9E-000263-GM; Mon, 25 May 2026 00:42:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1wRN8j-0001kN-SL; Mon, 25 May 2026 00:42:09 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1wRN8g-0001Gh-BO; Mon, 25 May 2026 00:42:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q884PfDgdA20HrDuRgks/7UDsL6uROKIi9GS6kHTKrDqB+kGarHcGiyze65RVjPfLPBUGM/+UjzgENtHZkf8Myu6W/Jhs6VBjO1H7v9O243Jo33Vjmvab1OTbw2+WF74EJB6m+jl4e2dcAqfcOotx6nBOxmpDEvT9QNw41ivFBMDnpZdOUWFZ3gJYrc1JJ78sSLVm1d7rvuT3VTewa0ckG9E/+qoshfEC34MPnxLGd3KZAhSOBe48vUDjzRKg+m/HefCowmMzOeF6hHtjlU88/IY6X76smqRB+ACUY/Bj9iZ1oqGvlp1N3mER4p1Xay3C+XKyc3cHXpV6LNchL2BZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nZvmepM9tMKpRh45zXM+7iKCRP/WaMcD0Ba0ZR0GhZU=;
 b=LljjaP3nWAtqhy1LS1ZZcE0p1vZOKqjiYryq6ivFcyrSEFza4I34B44j1xIzp7aP8swOw565vv0qWud/2U72rXnCKi70S5XLG72HSbBZPQOFb9L7l4MgNI6aKe/xSTVNN039SuYfFNFwKLanEXEzJwjTtTywMmT0srj2NxCjlVaniZitUF1BIMwm4VK28cSrl/QTuJvM5P7b2T2G4SbHmJtCwbdDbsm3C0zx/Nf02ZrWuWAY8y/LLrpKi5V/C+8DV8/Ge94nI5CqNBfcvYcugkjtDVTc2BTPpcsdR9NnqQ9NegqK7jVsVjTgFcnf2q7sC9ocxTSqugDnE6Ug0NwAlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nZvmepM9tMKpRh45zXM+7iKCRP/WaMcD0Ba0ZR0GhZU=;
 b=lDEep/fhNwI6I5o+NHf2tOhJKgzt31Xd4Ps2xqabkz/NwVbqUwHm4C1PZmAUrH/ZzBb1remx15ikr5UwWJA8mRQzbiFsa8vgVAyZAah8E2jJkhAjLlY0C+SsqDMm4nhqjQRhGu9XqXzHUne9DCxssngVjR/PZlJYz9dau7MY8ziXpgs5h09bJ1EIjllbR/XhW5afmBCzF5SFuhSVClRlCZ40M+JNtAjjiJwUsfCGfB7C97nhBJpwnB8I36MoQtkeSA0pryV51RKRrRJi4GhTWU/UTsrkztXdlO2hopCtT2la6R46/hbDLQ5MdpxoaY/vBiH6x8SIoLZok3AUIh2FZw==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by TYZPR06MB6593.apcprd06.prod.outlook.com (2603:1096:400:458::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 04:41:52 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c%5]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 04:41:52 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: Alistair Francis <alistair@alistair23.me>, Peter Maydell
 <peter.maydell@linaro.org>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@kaod.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Ninad Palsule
 <ninad@linux.ibm.com>, Joe Komlodi <komlodi@google.com>, Nabih Estefan
 <nabihestefan@google.com>, Jason Wang <jasowang@redhat.com>, "open
 list:STM32F205" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>
Subject: [PATCH v1 15/23] hw/intc/aspeed_vic: convert to use Resettable
 interface
Thread-Topic: [PATCH v1 15/23] hw/intc/aspeed_vic: convert to use Resettable
 interface
Thread-Index: AQHc7ADOW3mBmN4NrkuuaQZaC6ItBA==
Date: Mon, 25 May 2026 04:41:52 +0000
Message-ID: <20260525044129.3133916-16-kane_chen@aspeedtech.com>
References: <20260525044129.3133916-1-kane_chen@aspeedtech.com>
In-Reply-To: <20260525044129.3133916-1-kane_chen@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|TYZPR06MB6593:EE_
x-ms-office365-filtering-correlation-id: 7c704fd7-82ff-4279-6a3d-08deba17f14a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|22082099003|18002099003|56012099003|38070700021|921020;
x-microsoft-antispam-message-info: +icLWJ5y2oouK9PxwqT3I3EAfkh+SXWP084aOu4Tr8d0PnJjSc0QQKFbONuUhgQ5ExwYeASwbvGuX6np5QXVTdW9be+bNgAStoCuArcyTjJ6QIvl8L+nTuVWf1r5pBAr8WcVYdX/4fEAaDrhjkjb3TqlMqNbcTE0hi1j2Zbm0H8ULM+IB31RsL41iBq7krFuPzaCsnjDETUcnAJLOFOAuhqEFXHi+9vyyPzW3FM7cD+bBWC1q8XDlry0IMTmDeTT1TncdXXclMe8lvFRgo3rpAglWEPKnk65nJY/3JwjbXD4k6FSYsPL+9YFZhVRA0MsO1mfPqHFpKwByLIsrRrD/+53gETHAXxH7fiz5y50SlhWPp4jXMmHZVW0Jiso9/+JyYiicyaXhyWEQ9PO4+JDyiIGNoieckiB5KQrGMMxcf1wsrPgWahWujv2qIqzgCsR1m+pZMq2L19YiJDyEtjHWzYDvPeu1wAJAst6ek5/oC2F4CUVDT6BEgdoz9V1UdQMwtnbND/mo7ThZDG9HKJy5NMbAdQQb/Otu351r4vDF/oKyRWIlH/qCQw3b+XuxhHrIwM00uhxJGLUqOxDgf8fV2gju5hlRGJUngvYAc0K5A6g/sDzufm0vuS7BAA3UoNZlD3o4gC+LJPCpQWqYi+tmbHDL2Yr7uIAOuQK1zWHlHldTSRIoyZHuaf8TL5yCIuVAAfJHm6iNqy82RFRJ66jgg6ABAN09jb0LdwOp44ZLqq/F1OSZZmeD8O2bn/52o6WuDUb3qPd4Ml21oz/aA17iw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(22082099003)(18002099003)(56012099003)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Q/APCayBtjyZzR4NIWJzoidHo1f7fGC4M38F0CGQsKx0+9N7cmmYR7yKLL?=
 =?iso-8859-1?Q?8GGw45Km+Jfm9JZBoTIIITLmumshnoYP3p5qkLcMoWVIwxjt0ElViaF++p?=
 =?iso-8859-1?Q?LubpTF2a4Q1n50btxkWILZqkNSLv6O7p/l22ZIWnfSHwj6gPvT1OoGprI0?=
 =?iso-8859-1?Q?BRnf/3fuzQbL/lFhNVJ0ILi8tmKTzf/XOwxCWwZhi8MRq+Js+T/Ha4m6S6?=
 =?iso-8859-1?Q?E3lGPx4K3ZiifDjLY4AwHT3mnwBm2MWPidRllLfmb1sIuU/38wf+JiBvl8?=
 =?iso-8859-1?Q?04PslZKWgPThu0tExOWQKnLb5Z6n2Awtjf+dddXzxyeP/5aiByJaXrlcVg?=
 =?iso-8859-1?Q?KnrSGwQUhWtpgfKlT/OR3TvdIu2eGsWW/HMctxMz3fP/wuQcQmo1l818G1?=
 =?iso-8859-1?Q?8TsjkEtKD5wUBegI4/JOPJeuduiGdIKZ1ud5RKifR6WidajyzrCMEQkHOo?=
 =?iso-8859-1?Q?6OO+R9IcUaLLLtwWcUKLxlP1tc7Hhv4KIKwUTQ2LId+kpok4mzfApfRvMd?=
 =?iso-8859-1?Q?R7gL96upBSqi9eg+I9iuoU+tlhjrkssgN+f+IInC4rMjFcRjJxDEatDcSL?=
 =?iso-8859-1?Q?0sdrxK+jQmldnj9joN8i7BJ58u6R9/aF5q2G62TDVWwNusq85lnlxmp57R?=
 =?iso-8859-1?Q?XUDERF+TAveZLqEudFWAi4svFkMl3vWRHwNdXL3XM4V8pbs/+LjVBoQ5DD?=
 =?iso-8859-1?Q?9v/ndulukQLYKU91ZrU1LuAO2ZsC9K82XpH16jp4j4FjIzhDy6nyiNDLYk?=
 =?iso-8859-1?Q?WQj9CXPYeSS0RN+zaP1q2DCu436Q4tMe7mJTLUtrYwy7awiKLJqiRTqmHn?=
 =?iso-8859-1?Q?AHRbYGjOEqyZme9McOJsupr2Ywz5/In8Nndorl8QZn6RyzyYsnhXK52vCv?=
 =?iso-8859-1?Q?a9oRxbSeKlbLvhnX14Iu7UuH9NxJaPd8MiSXb1VnXWAFpZUMPnHkvEadoK?=
 =?iso-8859-1?Q?BO8zIEV6XRC/TJF8a4B1URuQLPj4AEdI4RZ2/LHXZ8TX9HYXiu1fd3YIT1?=
 =?iso-8859-1?Q?jnW7fzGNf23mM7idmcFP7onGlKALtE0ba2KQGBAfQMZfM+Zv98CvhmUkph?=
 =?iso-8859-1?Q?YAKy6Cxonr8INmALS+OI3TAExGPjiRiSsWIhc24Tw5XXr9nQbHGWOhkPaD?=
 =?iso-8859-1?Q?ox3aN7lVU8Tiwe71oMoR/sn5C0B8hbe1U3saMwSAwzfVXDwOT+0vhw+wzZ?=
 =?iso-8859-1?Q?W8ExK4GPxCl3oGZAtpzuOYyYLnQb+Hewj14NiKoat5++cys4N8d3Ul6GPX?=
 =?iso-8859-1?Q?ARo9yY9PCjpXeG1xy94Y6PUSteTnCJPPmOn6Yk+9+LfoduqoCSP67utuyQ?=
 =?iso-8859-1?Q?9DrSkJHFNsvrGOT3CuFnN+mOIPvLg0ehEQ5U1HWrWuppisefbesk4yLUeu?=
 =?iso-8859-1?Q?aqaJnUCyjHovv7Nrvipsi0EzolZAbN+7wf8k6fYr6G8kneKm9Y3Oj24GGv?=
 =?iso-8859-1?Q?Hhd2f8RLIxUMxdakOSJYLrhYLL0oIFUwWRs4lSHKvPMdjhD6tlmvYmFMFE?=
 =?iso-8859-1?Q?h2D2+liCrkuuj0F5/83d/Ts2MCb7X6JpCE/HzKOAYwH7lppxOTFY3bijrw?=
 =?iso-8859-1?Q?tkkxMS1XgK9YpyczI2Ha5oKFFZAeuFNiQmiQeZycn3/E7ibm+rXiqmlBot?=
 =?iso-8859-1?Q?P8Fz3ulinNV2Lb3lAhKOnX/YtcMALDCi4w451CirTqB5BN9IChrPO/WOaK?=
 =?iso-8859-1?Q?RGsGxK23co9qAPN16XotY6bP5ys6UUD4zldK7YATfUEmPBGmBsueyAL/7j?=
 =?iso-8859-1?Q?bVCf1HooORQnXKIcN7a1smT++i/PorPGd+VmnRAyiN1w8uq2wDRyN3xLr7?=
 =?iso-8859-1?Q?3Go6zmPXaw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Eu99Ts4P18QieAaB8G6llbtTZmMD748dkCPdFiDywmdN1P+8dTEcOmto2lxoN6FmmBgn8B+phn5GjG+UslxF/HlNFRIjKofEYn7efFzeoAq+FZ7k/7zW0AFlOugpVGkPuq03BFY8oCh5Nc7oeQM2+Iqfs7GLKCwy69Ot2rwwn3k+3ajW88tJERBAhQMB+/1v+hYLVLG9CtQqgY9Lo1xkQkWWvmUo25U5yEX1xF9P2RgurlYVPZJLGyqWozURI7shUIziE7NGBrhYA+IiIXGZ1gTAVy/8JeLLzdJwdsbYHX31/sv0ojr0YWMgdk0U5H32LcKasBl5/Ixn79yalic0kw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c704fd7-82ff-4279-6a3d-08deba17f14a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2026 04:41:52.8066 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OdzWWsaMwJVDgJz5gzAeGZ0wnGbkK/oB8UGC1MkoynwIieim3Fy/mnrqWJKbUHYceF4xu9eQeqU6xqQJZ1Nbvi0mffWIhRkffzkMZXQzWTo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6593
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=kane_chen@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Replace the legacy reset callback registered via=0A=
device_class_set_legacy_reset() with the Resettable interface.=0A=
=0A=
Signed-off-by: Kane Chen <kane_chen@aspeedtech.com>=0A=
---=0A=
 hw/intc/aspeed_vic.c | 7 ++++---=0A=
 1 file changed, 4 insertions(+), 3 deletions(-)=0A=
=0A=
diff --git a/hw/intc/aspeed_vic.c b/hw/intc/aspeed_vic.c=0A=
index b0a9a39705..13d8423d83 100644=0A=
--- a/hw/intc/aspeed_vic.c=0A=
+++ b/hw/intc/aspeed_vic.c=0A=
@@ -291,9 +291,9 @@ static const MemoryRegionOps aspeed_vic_ops =3D {=0A=
     .valid.unaligned =3D false,=0A=
 };=0A=
 =0A=
-static void aspeed_vic_reset(DeviceState *dev)=0A=
+static void aspeed_vic_reset_hold(Object *obj, ResetType type)=0A=
 {=0A=
-    AspeedVICState *s =3D ASPEED_VIC(dev);=0A=
+    AspeedVICState *s =3D ASPEED_VIC(obj);=0A=
 =0A=
     s->level =3D 0;=0A=
     s->raw =3D 0;=0A=
@@ -342,8 +342,9 @@ static const VMStateDescription vmstate_aspeed_vic =3D =
{=0A=
 static void aspeed_vic_class_init(ObjectClass *klass, const void *data)=0A=
 {=0A=
     DeviceClass *dc =3D DEVICE_CLASS(klass);=0A=
+    ResettableClass *rc =3D RESETTABLE_CLASS(klass);=0A=
     dc->realize =3D aspeed_vic_realize;=0A=
-    device_class_set_legacy_reset(dc, aspeed_vic_reset);=0A=
+    rc->phases.hold =3D aspeed_vic_reset_hold;=0A=
     dc->desc =3D "ASPEED Interrupt Controller (New)";=0A=
     dc->vmsd =3D &vmstate_aspeed_vic;=0A=
 }=0A=
-- =0A=
2.43.0=0A=

