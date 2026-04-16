Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9728AF433D7
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 01:52:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDBsS-0008Le-JQ; Wed, 15 Apr 2026 21:50:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wDBsI-0008Fs-Tz; Wed, 15 Apr 2026 21:50:35 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wDBsH-0007Ut-Ay; Wed, 15 Apr 2026 21:50:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kXsbnE+EQyHrDJ19/23r8KG0D4cngBqXDgk43mWsCDobUWcUTsMWh7z1Nr0496UnDmnjwPu/rGTU8CxYiCfHR9RahzAvNyMdS4UFFjNXskN0YRvg+foGn1zqqET14OE/u3a5Pmf42YY8oGkMXDSG2SACokUX2RXZBv3jErGNBqOcJ8Hae6ityeVE2WA64E9Cqc9un7Bd1ZEDOS6c7ZI7sGPJSSCS4j8utlEzN+y3wjWUIG0Al9Ivg/eMG0e5f71tIIBmTduJP7tZbWmhoiZRDF+8mKqkezyDKB59sDOY8PbCDeSt68ufE6A62zyZ0oFF+/o+AaDUG5pRUV4N9NsZhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VyCwDqxis3DBBPb6bjfJ2G4AY6nV23Q9QeGiVUfq1tM=;
 b=I9mJszb5IufFPGKJzGlIF+ZOzHvBXjaZlkVRNnPi22Q2jwAfW21N7394HFoPlbaSPklcgtb6w7Ou5mnAZlFfLbxdwPNM7cQ2RPISfLIyfnmm73dr/SdAU2399zdFviw2ve1TvqAiC40OTelpwn1Fi5gO2Lrs421Enn8j1N2vYUnGQkbAlPtZ4LxmrwDk8kAyIeDPDE551cNQT9FkBiMjBEoGZayATbP04QQ7rl/K72GF8wRx9Uty8iy2ER+nS2g26P4IpyaFpNJTIaOSMU+3vS4th5sUisJHLfqTtBxJN49Wttp3iNIjOwLMR+G91utwZ6m/BHUNl9bSGBiqpsxGow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VyCwDqxis3DBBPb6bjfJ2G4AY6nV23Q9QeGiVUfq1tM=;
 b=Qtn09AuUPm+1WwhGfHE9txZ7vwPVOmKhfV6WGo/sLF+B5rBPZVl7szCdRB9+tDERL/kwvhwN14eEl4YoeXKiwdq8hV1RXWh0H8jtwC8Zj4HWY6BUIIfQftkhog8WDZfoq0rF4nu0CQoKVCbZmLWY4l1wnfjfrK+b252HmheFaKF3WLRV0G9mXehwoEiiveo43HEVEjDYLzcpjh2eGtlxxgJxYekZ50TYTDqDRqSRFkvtl8kS27UQTyjoLKprId4ZI1ZbEtFT6Sx+oorJQhpT2VHdTndm1VbH52hQDhTlwICsDxklFcjZbosalb1O8GitevHLbrpkjuDR2h3pF0PCqQ==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEYPR06MB6202.apcprd06.prod.outlook.com (2603:1096:101:c7::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Thu, 16 Apr
 2026 01:50:01 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9818.017; Thu, 16 Apr 2026
 01:50:00 +0000
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
 <nabihestefan@google.com>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@redhat.com>
Subject: [PATCH v3 14/17] hw/arm/aspeed_ast27x0: Enable 64-bit EHCI DMA
 addressing
Thread-Topic: [PATCH v3 14/17] hw/arm/aspeed_ast27x0: Enable 64-bit EHCI DMA
 addressing
Thread-Index: AQHczUNV6D3aEL8Rv0aA8A5mw4QkZw==
Date: Thu, 16 Apr 2026 01:50:00 +0000
Message-ID: <20260416014928.1279360-15-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: 2d23d787-7f69-422f-cf73-08de9b5a7869
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|38070700021|921020|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: lJkTHeJaDUCtvZXkIIPbdTg854al2T9CzEQysXwUwvrruGHd4sOhai7Sl/tdZp5LfWvUvN9ezt2tyeKoZ5bbJ8t0oWC9LHNn25yXzkyfVul2sisKul72noWpE+ochINEgJ3QoaqFV93mStlENzgQWi3lxu7QowImbU1UeMDgSNOsy0yD0ok2KLs2mhzDgWp6uPI7KUdyUoNj82RIl8x9xKEW/qYr8Q2gkmh4gX7o1qjMJj5LqLzGAUCwri8oTE4o31p2JpRHft81vvPvFmzKDfCJ3Qxl2TX+jJHzry8NKdgp2HHbEzJGNgGoWYqdiLbplVEyweB40gqhoM6BrZMvbcVAz+uNvVK4uPek//4sOkPXszF8ABuAwkdxqyzrDBCbsazaMd//mDoBXhNor65nKu191iq4OPLCM+R/ZZPRrBDzp3B3dS121C9f77QD30ieoYpvGj2GR6pPmNOVJ6ZJK+gi/Ul4uJ/r/m+i8ZmvwL5kDk0zgtgZ5OBoxNM1+LkvDY0nz80zhFE+EgLbYOfPi27oqTEPGZo5VFFhZ9BMnXoZtsqGHPVqeE6TkK9+YZkEXRKtsdJ1W14DDZFeBaO51M8ngNku144ORMDta5pCMEIQjpX2joQlKlP8lRU/7ILLxf5Cn0DBVodpC5NGWCdNOv6J9eLAM15FnpikIpPfrPpJlunvLvL5AZhUmrBe+kyxBaYR3uJX2nzXsW5O/a1Rkdm5xakipziR7mtDVPqqimGut6m7nrF3lAbhqYCLVXkKpMq5jaa3DxlnlYAMk0wsFxgdgC0qQdEcqVjriEJ0w4HvZWW5YRtmEOIsJYEnqeP0
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021)(921020)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?bcHRZDaA4ZWOE8nt6gKxi0McnFbUjDWIDfYWdfcaO5I5B3OvR1KKsB5pHH?=
 =?iso-8859-1?Q?3fEnIs8bFQoJH4s+mGc57vYOeA+3ZIiBNJXfucQst8OsOrZGbj2f6w98IJ?=
 =?iso-8859-1?Q?8pdb9xtBMYlQ7GzeYk34Kxqkl0msly88ET8P9tkEmyamekk6x5CMG/i+Fu?=
 =?iso-8859-1?Q?ns9v9xu2xbDi+Z98ZwBdkOr703XnOCnV7eqoTd0KaqkOuqGCtgntea7yEx?=
 =?iso-8859-1?Q?hqKeAGpiQovXUCRnInzgtqR7lbn5zWcCH3FPwOHyaicWZ5SbWBujpGtSzb?=
 =?iso-8859-1?Q?50ls/TX1FpozBFDVMpGlwaiaIqj9dLzGhTNe3hGU5XI0/3HuCV+VQM1Sbn?=
 =?iso-8859-1?Q?RV1cvTUidxeE127u9YN1EPgD/S5pFDR6jCj8bcgO5Z8rgfup98G74ZKv6i?=
 =?iso-8859-1?Q?uXFCaC/t0oPdzmeXm3RMqmbjeoGncfwgEoqagalgMnf53X7veWK7N8JcwC?=
 =?iso-8859-1?Q?k/yBxY90TYlNQNx0cuainFJdwwZAvs4YOgIXjVq8H31+sc4Hqxny88vJcZ?=
 =?iso-8859-1?Q?n0vpitYViCYOG70fwg72aNSx/+AabPM8zuGfPlNIcqqh7T2HK6iJjjNoQN?=
 =?iso-8859-1?Q?scGK8fQjt4yJeFfzsoBVwbuz6wWitE0hOV5C3D9V82dk/6a6gMu10R4Kax?=
 =?iso-8859-1?Q?QtnIc5sSezZD6hJqbPIy16X4ICjO9wPNTRJ74MVUEcgDHTClogLkGVJ8PL?=
 =?iso-8859-1?Q?eX6TUU7eHmXKt2YLbLxEOqJJV+sKIVKaz4jhvwAKxbcfCf7FiCQVlOOd0M?=
 =?iso-8859-1?Q?LUMAEzTU81Z3mVPA49wZzvVxAZCUD0VDRa/Vhf2N73q1eEv7C/YjZlNu5S?=
 =?iso-8859-1?Q?1ppqvw6Iip/1nJ5j2YBOIJnvEnKHZtdF/GW9DT7TenPjAYGskbDM7EC79g?=
 =?iso-8859-1?Q?EvAFSGIctgbEa7HNvGoQp+eKD+hz1L4G03RZo8thdUEA/AiWCH7G5t1f6l?=
 =?iso-8859-1?Q?Dh2x8nTx9HmqzsrKfRiuZ7iNTZUGnEmGqp7HviqdBhONL4Xs6r55CQxV5c?=
 =?iso-8859-1?Q?LhpggPQL5m7UOGtXnj2CsIiJjPxu9KsaW0S9eiAqbk1xLhUn9Usr15oYYu?=
 =?iso-8859-1?Q?popOKk4xP67DgjYOdapF1N8okoiEvjDoCcmArdK4sB5wfo/sp0ZAgusdM4?=
 =?iso-8859-1?Q?tPr9JwBKLRdi6/yuLKSSktqjhOmVycZau1ffR600esNlducEX9K32IOK9V?=
 =?iso-8859-1?Q?9docMuqOTrkN0ntvnQ/Ejt/DLREq44Dv5xTsCcw7sLgKIC0j4hcwRYvz51?=
 =?iso-8859-1?Q?Lxui8AGrGHbt1KWfDDNjCS3CXukE4HoFJUsK4olZQ4vjKBJ1uqFEkXcMFm?=
 =?iso-8859-1?Q?VGXLDTNcbQVzhX0SFRB8DhvjRWsqFpzBfgVn9zsxJeob0yFpkTFkZaAxMf?=
 =?iso-8859-1?Q?R6Pm6IUDbqZliTtafybM2bYz/z5GD6ZHTBKOqi6k05q+0/yMO2ZJG5ljYJ?=
 =?iso-8859-1?Q?s02rLd4vnd1URfe4pkBP24FdEmilW0vg6jVvD97TRF2eAFqxI7B/tTeLzc?=
 =?iso-8859-1?Q?nUgdyGjzCsi/cfairTy7Q25rB5zojePVVsOCYpAPQwP/vu+REbx8r7hSfu?=
 =?iso-8859-1?Q?//lFma93oFeB/57voX+880ii7+4Oh1PejnEPtznu/atXMS55gd51sy5s3l?=
 =?iso-8859-1?Q?k1Ujvp9D2xLx/HQafM7d0BMPvuPXMQW8sbXDFy4ZMd7Jxe8Nhw1tr5eOAD?=
 =?iso-8859-1?Q?933/yu0iGiGhn4aGXCS6WsmP7LAEl1kc4VYIIF5t36QISqvuj8Db5VHyAy?=
 =?iso-8859-1?Q?nWeN0QhsOPGw7GfwNIH11Q2sjQcqr8ycULHbB1Ely7zIrwIEjEcwY+pufH?=
 =?iso-8859-1?Q?QdozTOoMww=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: gIHOd3L09RL1IzFlli2x8cl4S/0RhARey+clIVe66rinGjORGs+sr6yH91ruUILSA0t/vyTtJJU8XFZ4ATI+Ub6fXx3JW9qCLNImka9gd57PfpugvyPDfhGkt6Q9p6atTKQzrRiKjze1WzuMY7rEbuHCtnASF05y1Hu/2Vy31xRUF4rmYioWaRrT+IsYaw/AgkIpn3fOQLnNoOxX6ayayiDBw0LmlFuZbiQzAhenECNzhePFUf7u6VoT77N8bz4ty1YIgJwoDDv1ADHaisZFbg3XwMoCpkxy5KHIE6Ya7iKl7B6/tA5zyS9ASSqmtwHROZucGLRAavGLNZHxKrAD0w==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d23d787-7f69-422f-cf73-08de9b5a7869
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2026 01:50:00.1941 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 09VvNzrUo2v1kCzr4aVozcdh2S84XEcidW6SSv+dr+Jy4EecvuOmCqjH9vHCebVd5n4ZCiyuUCy27en9J+X+d4ZF7sPIHBmT7rqmoZyDbGI=
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

AST2700 supports a 64-bit DRAM address space. Therefore, DMA=0A=
transactions must be capable of accessing 64-bit addresses.=0A=
=0A=
Enable the "caps-64bit-addr" property for the EHCI controllers=0A=
on AST2700 so that USB DMA operations can correctly handle=0A=
64-bit memory addresses.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: C=E9dric Le Goater <clg@redhat.com>=0A=
---=0A=
 hw/arm/aspeed_ast27x0.c | 2 ++=0A=
 1 file changed, 2 insertions(+)=0A=
=0A=
diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c=0A=
index 87dcb82e1b..4a1f7cad73 100644=0A=
--- a/hw/arm/aspeed_ast27x0.c=0A=
+++ b/hw/arm/aspeed_ast27x0.c=0A=
@@ -856,6 +856,8 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev=
, Error **errp)=0A=
 =0A=
     /* EHCI */=0A=
     for (i =3D 0; i < sc->ehcis_num; i++) {=0A=
+        object_property_set_bool(OBJECT(&s->ehci[i]), "caps-64bit-addr", t=
rue,=0A=
+                                 &error_abort);=0A=
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->ehci[i]), errp)) {=0A=
             return;=0A=
         }=0A=
-- =0A=
2.43.0=0A=

