Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8F3ED172D2
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 06:20:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmnHi-0005xn-BP; Mon, 02 Feb 2026 01:19:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vmnHg-0005wZ-8b; Mon, 02 Feb 2026 01:19:40 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vmnHe-0003NC-SF; Mon, 02 Feb 2026 01:19:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D+h7dJmBoUNcIfMjZX73u9gxk94WS55Lx/OVdlIQvEf1uvjCZOfXBl9yd77Whrm35n5LBZs0O1PukT5QzdeBW1CMmR4QNfegsBBIGyjPUf+3h6G/GmqNRyrCtoOZhYj6HwL6FRjrf2tTj0lqjDoZ65oRnWtNAKpB6dZbDbq3tUHBHYcHa0BVNhHilZlueY7LYp/KVSrlB7guEOXWASJShuOaSnl6+aL0magJbK3d18uXVpt6sj26fIDqAO3mVJanz3dITFYYc3cmjSW4+8Dx5ilXc7oM5Ig4rnwKBD3lt8YqUTqhqYj8NI2q4ZjTSC0x/1BhLEQTV3MDeXETFag35A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8KDxsOwOMSt5F257cS7QZ5ekh0MpQQuEBwfrqhxukfM=;
 b=rmMvez0M5kQlAlodJGeQl3By5x90et91shsSBbcRFdRG/syPn5bpZvFqphBeVHIDCYlkX3os3i1QIxiomde+RrAkD+gl6ZwfjfZCoQVg1y33f3AdaAzQQkpimxdrrfdW8mnf9yGZGR/YRZZVOsb1CeoR17dNKWZRWII0suecWjSGbjKmEWdwt3QRZsbtbIYHftfxnvJRNu9qG6zDlm3EQ5AtZC2xQiBwDHRpsi2rUmcX/V/m68znlNUM9tXVTPH0srRD0bJYlHCIMPxZyvy2Q4wxMnNI8GwCy3ZlE94fypQdlCTCkblOhRelDFOirOnBmS3sdMljOeG0e7qbuKlhiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8KDxsOwOMSt5F257cS7QZ5ekh0MpQQuEBwfrqhxukfM=;
 b=bRBsaYgvOfz0wqUdeAU3hOTneGc36CgQ+xx/9JwIAlebZqqEoJAWX1eyFXS2+V/hTCSAfN3hLRP2EyWz0c1O6W8UvFxJJm+sTQOAG9lTnFawOZ57U3I1ehmGdTnjVe58wgfQ8EnTRLVuAT1g3DlRfRr5o/taXcFuQgYdu9SN/pKlYBe1qq6XcMIrp4AsWE1P9NrEs48YRB26mE7x5XyuncEQ99OcmQ29t1hSoD/BMQvpEhx11LDXxhUSMbtd1UQMbXvtz1s7qSPyLt3f7euv/4b6Ke7qGv/9RGmCEtBpce5afZmOUPyjKd0E3/CdyHsyKS0fgOlTCL0DWUCSyOABSg==
Received: from SE3PR06MB8199.apcprd06.prod.outlook.com (2603:1096:101:2f0::5)
 by SEZPR06MB5142.apcprd06.prod.outlook.com (2603:1096:101:40::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 06:19:23 +0000
Received: from SE3PR06MB8199.apcprd06.prod.outlook.com
 ([fe80::677:27ca:1e51:129b]) by SE3PR06MB8199.apcprd06.prod.outlook.com
 ([fe80::677:27ca:1e51:129b%6]) with mapi id 15.20.9564.016; Mon, 2 Feb 2026
 06:19:22 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "clg@kaod.org" <clg@kaod.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>,
 "leetroy@gmail.com" <leetroy@gmail.com>, Jamin Lin
 <jamin_lin@aspeedtech.com>, "andrew@codeconstruct.com.au"
 <andrew@codeconstruct.com.au>, "joel@jms.id.au" <joel@jms.id.au>,
 "pierrick.bouvier@linaro.org" <pierrick.bouvier@linaro.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>
Subject: [PATCH v1 1/8] hw/arm/aspeed_ast27x0: Fix EHCI3/4 IRQ routing to GIC
Thread-Topic: [PATCH v1 1/8] hw/arm/aspeed_ast27x0: Fix EHCI3/4 IRQ routing to
 GIC
Thread-Index: AQHclAvfbZfuNvwY/0a09W7XN5VQPg==
Date: Mon, 2 Feb 2026 06:19:22 +0000
Message-ID: <SE3PR06MB81996DD83FD1E3D3D72ED313FC9AA@SE3PR06MB8199.apcprd06.prod.outlook.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SE3PR06MB8199:EE_|SEZPR06MB5142:EE_
x-ms-office365-filtering-correlation-id: 45733253-bec5-4a66-b556-08de622301f7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|921020|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?fBFbfp1JlOhiIvz1IVbRSF0xQBl+qZmdQNmu8mGEsj0dz+P1vcCbMtQzwWoL?=
 =?us-ascii?Q?0oFbpO6GOP/yafI0tzr8WE3oZcPifzJtU1LAYqnnt+aN0v/j7eoarUgniNbe?=
 =?us-ascii?Q?3gMBvLgapBwFKgLFndyN7wg1N6DxBZqXxo/BNuKUWLkfwyINyMHXga3qTHHN?=
 =?us-ascii?Q?a/2ikaKTtEcCDRV6ioa9O8l7ct/U2p6CiJWfx0cEQ3QkjB/wVWa22Ei5rj3N?=
 =?us-ascii?Q?e9Urb60Zy4JGu1jlAjhs/hybvON3FSgoDjtkBC8O27uBwPJQ1/cRM1Qq47Hm?=
 =?us-ascii?Q?8jo9YMibt/Qa7yriIADW4jC01jfo2Cj6MtX/DtOwwlzitZXCTkklGG0jHM8V?=
 =?us-ascii?Q?IDSvYaC99nuQ0h1m5HJnAFIuh6BgmnUfTJ59oMazK88h1wsReEpEyUG/qSTB?=
 =?us-ascii?Q?W/cYDIpOGq/eEVPJC7o/j49LWH+qrVwBkvrFypZ0sIRE7+gnFRaGb72LcYr1?=
 =?us-ascii?Q?eC+CWGnqiefVx87orjD3MWnwaP/U98p+J+mRMSfbv2y5g1ehJj9hz9Umof7f?=
 =?us-ascii?Q?zVcpxRAoX2VexHElvG0nFmTjUtuAEL6+LrY7FRf/w+MQK7ofUc2EFQQCHnao?=
 =?us-ascii?Q?DHz+KZNBqOFZ4tzrYbbYbX9TvO9nUO439QBlWnVGXWMEYLjN7SoDqiMUmH8i?=
 =?us-ascii?Q?fwIXgpXscgbGmH235JDS9MkKgXHTorBSB/BYYPDfC8Qz/ySyHHs/HGKv1YVI?=
 =?us-ascii?Q?7f4rZJC3p6sYlMlC5qBst6CLQkAnbrHcE4JR792FruPPyI7DIWoD8HU1DTRb?=
 =?us-ascii?Q?JEzF8u90ZsHXJ+BtlNkdi0Y1b0p0uMhjLDteAJCwR7jL1WYUIRkIbUIFtNb/?=
 =?us-ascii?Q?7f39Bnj+jk/h3wktvfk7Jl3m3h4ATuyCoYGxpopbkhOrtn2Xwbl3vuQRhveC?=
 =?us-ascii?Q?mY1piv25rG2hSwBamZdNp2B84ZtBnoc4q6+8VA2Fn0TEmd/QhY7mCTb/hzEn?=
 =?us-ascii?Q?DAKMturdpJxPXMHfqECbj+ZC3ZFzkHvppqlYxmj0uHVQlF9u48GFYsvNmZz4?=
 =?us-ascii?Q?24FrctNwnx3C3l9w7iqJ4ok4n1kF+IRpbmvZsY2v17exiAxVKUBfv6a752kF?=
 =?us-ascii?Q?CAYQwZ0N9xE/0h8j9QREgeVnJparwjjlTPihE+CU/J5o4ZyW9AEd0dSqtjfV?=
 =?us-ascii?Q?myF0KyztjHjqkbArhomLXYcD8GhmqUpAbCmIkB5ZKnbae+w8uZ+Oeb9moRVw?=
 =?us-ascii?Q?Pylim3/UneKVE/jjCFggDZbJx6tqmw8NdijaRWmbklebAyLF7ZObtiQPWwBB?=
 =?us-ascii?Q?+8bOp3ENwQM20cKx23JgSE+666f3qix46QALeKciTWV1Pr3CDnySHzKtUMxQ?=
 =?us-ascii?Q?R0wD3owjosl6eP9gKjT4KWYu6PrYTQ/qYqr2y46uspyeiFVtYfAFBMoL8bQD?=
 =?us-ascii?Q?/CLdPPlq/oijIPqsgoRpCtvi4CWB2ZtMf0hvwDHOC7sc2Ox9VQAGezaJLsuv?=
 =?us-ascii?Q?iyqXZskf7l+bDDa2OiTl4wj7Bh1cHugFbB2Sq/9XjsDe352DzvcAS12xi1V3?=
 =?us-ascii?Q?gQ+S8w4JGPbWix29SPJ3tNt1CpAVFHkd2DyXtYWj7VE6q8Bl4fY5/K6E3RcE?=
 =?us-ascii?Q?yMdfkIhL7SYUKfy9J37PmYE/1DwXPrbDkLicgWJrqRz8Px6Z5oZi+9w5sKuJ?=
 =?us-ascii?Q?fNlnqn3xrQl25p/j7Ri4LMdDcbKhJX2sYTiiohrYElL8?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SE3PR06MB8199.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(921020)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kMxXtORF5B9xJuf3NvvqmOU5mKK3I16fWVkUsmG6amPhp+wO6F9IN63+J1kj?=
 =?us-ascii?Q?LgdRxcWyAXv90eF3vDQqP37ZKv7UHqBnH6QcZFgopYR4rtm1hDXihr9u9Usy?=
 =?us-ascii?Q?4EoMr1EHp0aID7IsLStSm4sDKkPt3RUbv8F1NV4l6ckNQxK8PB5Jm5+B5jbl?=
 =?us-ascii?Q?BlAT3h9cs+XQqUNAZYJqjhldMGmO89wgHArid2oGPwh7qVQ5mqdafJmS7brS?=
 =?us-ascii?Q?dELIYwYUocqWVr05w+nsTjBToqBEEnaGk87t+X+oRr4cCX431ptJJsmUVtVg?=
 =?us-ascii?Q?gx9ae1meMpp2kYwodZjC0weuV0CxxehsRB55ma5uh5R0WUecZZPJInoybg8o?=
 =?us-ascii?Q?g7X+814Gqbyo01aCrCx7P9mkKLqPeYNC1SKRJHIdk4SVwzw+AWl854sUqKw5?=
 =?us-ascii?Q?FmNVJa7PJ1KlFl4brDouOqRX6cEMgnwPQWDoeJYuBa/hZRtgUmHTgcZwCTTv?=
 =?us-ascii?Q?ytEqHMWkkh7G/5HaYKLKD1tl2J9eB/wPZXGEBhAMgm4Wt358oJNOwgH7GIWq?=
 =?us-ascii?Q?TwSyYS+Y+PrhsHR4eayaAUobU4PF1wlQ595Qz6+aSuC4MGoEo3FqK0WGfWWl?=
 =?us-ascii?Q?sPW9pbI5ZsZ9p3A5miVbRA4QTBnwu4GncfMEYGh4Peka/pwGwQW2O38hEJFu?=
 =?us-ascii?Q?n2RZIvwq8j6FkVFrXTiqv1zWHiLurpvzXQs1Db1evI8Yu/43+/poATQEU2O9?=
 =?us-ascii?Q?ZNWmFR64v1X9IJMcGFZ7xxKQTNhcazRqQPr1HjOCFuTUf5EWldVJXnglAlhk?=
 =?us-ascii?Q?6XRm18jtaNFPwLfLLSAu6nC3hNjOAijNK+f1hcgaFeQjOy5iBYXluQgHNu2M?=
 =?us-ascii?Q?ZehHOqW3rKRpE/+Ix97ta6HnPijUzasCtW/0vOIZe1iI2yY72ZINu4aXaX+6?=
 =?us-ascii?Q?SYe3wNY9EXbFD7LnmvQwKW0ZoQYkf0f9ANQF9sv9W/SEKdwr0nEYv2Iy8Jc5?=
 =?us-ascii?Q?t8e6vWJE2RJeFJj7JcaQKOOotX9LKn9/3pnfhrmdAmGkVldlJuAlc3EvHSfg?=
 =?us-ascii?Q?wm7kLguFRvfYwSz0YtUtMP9uX43JGdGu46vePwi76KmyAggevuCUcqtZZhIj?=
 =?us-ascii?Q?WvioUmWRvvxX9uJCPrL+VbR5MjHILUn8BNSnbZG8MR1rwc+lL4U/+yEfpUa2?=
 =?us-ascii?Q?e6nNodrcvAdH31kX9R/9YITElfxn1VO9GDH4B0KqE2B+fK0xj2mBnq6eLOmO?=
 =?us-ascii?Q?W3ZIe3ysn7n/MqASb7evkemSC7EtfUJWT8RYCqNe4BoGoe61VFLSrJ8eStRn?=
 =?us-ascii?Q?LiFQYGRW69mlzaFxoK7AH89Nog62CCeePKbjlXRK49wiktSA0QgJhk3v4UlQ?=
 =?us-ascii?Q?tlmgiaGfq3cmp62v3sWP+e0F6uYp1CtWk0EGbJ/7hWADLQEA120bsKCyq9GK?=
 =?us-ascii?Q?K29+rdgNqCgQM5Gm08o8V1bsBbbwD0MLiIfPcq3QZTTD2wZzogHm8bCArWCc?=
 =?us-ascii?Q?D9oPkLEQwJsESnBTCDsYaRQOnJFkf7E6al1u5bEB0saEv7byHjHYlQsBghkj?=
 =?us-ascii?Q?Ha7xa21ZE44TlRKHkqccy6fLL1kN8cSPYYEy3MxzrK9ytPMSkzOVn6cMNRcl?=
 =?us-ascii?Q?yAB4R8wg8iS6pB4JE+30LihnhC9iaVMisQ7m+QHOjIFoRB6AzKG7J9V4KJad?=
 =?us-ascii?Q?zhtk5Lclsf0I0SELvMVLRccBG8BEAzn+1cubU0eNkayvH7ShQPrjtnJ55ldH?=
 =?us-ascii?Q?Z9/QFz/Gc1HA/AnqzvRXmUDRDs5CVksMo7o23M/5HfpBnMm2efdHqNquWRjU?=
 =?us-ascii?Q?ts7bEYJg+w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SE3PR06MB8199.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45733253-bec5-4a66-b556-08de622301f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2026 06:19:22.8947 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hQqgmeAJhoOOG6aktLbc+lAkGIJXroMxucftoEb7qS9DBK7dA81wGBRBNSB2G5hkLJ84bee75tqdPuvm27+1pYw53Yc8PWqHeZgYgrP9hhs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5142
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

From: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
=0A=
EHCI3 and EHCI4 were missing entries in aspeed_soc_ast2700a1_irqmap,=0A=
so their source IRQs were never routed through the INTC OR-gates.=0A=
=0A=
As a result, EHCI3/4 interrupts were not propagated to the GIC,=0A=
causing incorrect interrupt behavior for these controllers.=0A=
=0A=
Add EHCI3 and EHCI4 to the IRQ map and route them to the same INTC=0A=
group as other shared peripherals, ensuring their interrupts are=0A=
properly connected to the GIC.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Fixes: ba27ba302a264117c8b8427f944ced1bed17c438 ("hw/arm: ast27x0: Wire up =
EHCI controllers")=0A=
---=0A=
 hw/arm/aspeed_ast27x0.c | 2 ++=0A=
 1 file changed, 2 insertions(+)=0A=
=0A=
diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c=0A=
index d17f446661..e16183c3b3 100644=0A=
--- a/hw/arm/aspeed_ast27x0.c=0A=
+++ b/hw/arm/aspeed_ast27x0.c=0A=
@@ -149,6 +149,8 @@ static const int aspeed_soc_ast2700a1_irqmap[] =3D {=0A=
     [ASPEED_DEV_ETH1]      =3D 196,=0A=
     [ASPEED_DEV_ETH2]      =3D 196,=0A=
     [ASPEED_DEV_ETH3]      =3D 196,=0A=
+    [ASPEED_DEV_EHCI3]     =3D 196,=0A=
+    [ASPEED_DEV_EHCI4]     =3D 196,=0A=
     [ASPEED_DEV_PECI]      =3D 197,=0A=
     [ASPEED_DEV_SDHCI]     =3D 197,=0A=
 };=0A=
-- =0A=
2.43.0=0A=
=0A=

