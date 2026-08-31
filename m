Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1C5FC61DF0
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 03:42:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0suY-000676-MW; Sun, 30 Aug 2026 23:42:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x0suT-00065E-4w; Sun, 30 Aug 2026 23:42:14 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x0suR-0006yv-KY; Sun, 30 Aug 2026 23:42:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ye62yaQgSIqMGHGlRc/Fu9Dl2lZoXBs+GZCp0ix6XuJjzkTORo4ozQSk4Ef4KWUzh8gGFfi4ajd2Swo7cQirJVmH3ClZkl6saWUzuIxHdppACh8wM5cfgdK01r6Ozw4wNGkcxbs/e21I4XLtZ1kxeQyjMZuzpDsOVdC7HW5pwgRQr0QOxZhSrqEzBowyPelQq1EmVLnvXpGHce+Z3lclCF0MCjuu9VnQEEsc+1ox/NMoOozP3atEd7dc0u26e117uXkmeEQi6H7BbvFKWkM6bLhyX4tzY+4qRvQ6FJ5EXZc5sFzwboLDwFYmIh/Hi07VtP73NM99pqWEedKOuQdukw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fD+btaEiZtDBpx9qQBszmscxrzLO7OdBP3qCKtYG3HM=;
 b=KblG563Iy8efp2NB3h9xTZHZI0XSmdqkvBX2KwEZRjf8T4Y3eLmG9c/o1FpMZNUdPgRWSJXdvTtm6NY9oeZOXx97HIHuZNbfY5wWp8q6TXemsUx9JOPBrgp6p461AGlyjyeVAEbO9/6a/8X9W3ViGHrpOtiYNcjDdTQWVuYzolPnykkSqNFsICpb6UIqeXaQoDOm/I1MGMLtmyClbH1oHvsADqSS69LPZRTV4VbfgnIZ06r23iE9zg+3pkEOV4T2cmE0Qw3PtSTRz5AGv4kbxfRStBFcJ9LfJNv85IPUQ1YQ4ZziylY/mwjOjQ0FHDO/vEwUBRjZH3IDIpHN6IEpoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fD+btaEiZtDBpx9qQBszmscxrzLO7OdBP3qCKtYG3HM=;
 b=V4+UdS1tNRMMvvoyDKPXBw58LWQ3MJ5luuDK1Cn4aYjm9AC4CdYv+naiArl/jpUhAmz/SCg77WWGcBZIUsVJUsZkNbg9taRq3IeTiseEtXl3ys4qUaS0c++Ggv1Z6V9S9HMTaTcgsmUm9DCiaGVvgNJUr0pKHlicMTOryuIuHKrTyFmSBIoyft5OxnXds98c9+xrvsGhzTtRJ1g1hqX2onczR6XxqctdhC7raZybDssdh3YjotnGEBId3EFu89V0vP4AZeLJq5EvdHEHGEjok9fy+Jg+6Dz+zGC1sqJxQzW7OmVv6LkMPzPrCg7t+dAO8MgaFsAFp67DvHvHzFH9yQ==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by SE3PR06MB8096.apcprd06.prod.outlook.com (2603:1096:101:2e3::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 03:42:04 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 03:42:04 +0000
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
Subject: [PATCH v3 8/9] hw/arm/aspeed_ast10x0: Wire SEC SRAM to the SBC model
Thread-Topic: [PATCH v3 8/9] hw/arm/aspeed_ast10x0: Wire SEC SRAM to the SBC
 model
Thread-Index: AQHdOPqwR+45tqTcpkyQLAkyQNmjaw==
Date: Mon, 31 Aug 2026 03:42:04 +0000
Message-ID: <20260831034153.192916-9-jamin_lin@aspeedtech.com>
References: <20260831034153.192916-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260831034153.192916-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|SE3PR06MB8096:EE_
x-ms-office365-filtering-correlation-id: 89ba830d-e288-4116-d29c-08df0711d2d2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|7416014|921020|38070700021|6133799003|10067099003|56012099006|22082099003|18002099003;
x-microsoft-antispam-message-info: Zu2sbDNfvQqXB1G+7Kv+kcyICi3qTT6aci4Kg1LBd708RxqNOGzCNttlzWAAMtoXZUfWBPEO7k5PWG7ZFBGf74oauhZXNM21OawVPntR5A5EBHyQX1vQYdzHlMCLqJMGwTvlP61ZQEsqbZ3quvOkvnv9y+2yz2mGHUvDhGYGwqnw8VFnHTNE9S6B7cM/nZ4Yo/RGq2H9jwZAnmeK0KS0kZAdI0lZ/Hn7+ylHWosfFYaHKeDfEyTBYC9ZL7Gle8ckGqjcLpP/SUzMCqJ/yaL30JvlVq3wK97lmGOx6LYQyFyjqppJQ6enlqi5ptHUcQDE4/4l8Pea1FOEaVyRtadKzXLlMjL9MZ/65ipur4o00O6pbVllKFAM7LuI2s9bkivifbTX49xUDUk+YQFEBDhdrCZorj7XFVl/w82M4cM+TlLFQOr9iTRe9Ps68v1rSZ/KWO6QpOfFIrRBhklhRKfzaLrRX7kqzZS2+i9jfu5mmEyMEMOS01jGWgi6DBkjNH2dWop3YpW/+Q4KG/DGO/r5pktJvOf9E7LlxZr6pR+wWCfpBuLP+ia8MjS0ZcQ77YvEKh9SB+KixPoQqU/jnWAYfn527chvAySlL+KWIZ7tYMdi5kdeksjQ+EEizR0TDlNw4TMCgHEJRiEzJwXWyEb0vRRuik5YQ6hTMVBAVKKn+4mhN7HDDAJ00mOHhU3iMjUQ+OfltU+tgujjA6njCxWE7RGrxlm2ZvFRSjE4A5uZR4sB0D4e9uj/rXUwzPFB041A
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(7416014)(921020)(38070700021)(6133799003)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?3d8UQc8fpwv/DTru5QXvNE+8P5c5cm0OJG/uHfFIPc1BiKa+5Zgwdg83jq?=
 =?iso-8859-1?Q?QXo4uqFWnq7lWdtvotXrt1T7nGlZYiuo1m1DUXOT1fw6IC/456U5JHt5Cv?=
 =?iso-8859-1?Q?/yvyHHaHq5BC//c94Z6/o9OGmUN3AmOcA11F/urkeaza0JbQ2yIc5i0iDY?=
 =?iso-8859-1?Q?0S0BwpUoYHRnMqOzrC5cu5nXWg5Yt7VyV5QStpCwFFe4ahCBmMqaesTujw?=
 =?iso-8859-1?Q?I6JTS8xz5Xd9sYtPDemPhXrjIgPFcscihYXxJar21jQXHJVkMPqX9vw6l7?=
 =?iso-8859-1?Q?kKPnNL55iL+kmgLEERRgpk4g4FTzdYSxJwSXEfrFz5URhTwh+DkKvzthX7?=
 =?iso-8859-1?Q?ZBB+ccnSycgVs+325dOACgaIue7gSz/gXgaTx6L8gH4kUXGz4oXbzqf23I?=
 =?iso-8859-1?Q?vo8bR/r4NalB2Oe7xtpVK8okUZud3xRT6L6NvFliWFgcxNGitMvBydMKcz?=
 =?iso-8859-1?Q?ikwQ/U55K6QPYq2Ub6qW/D4WrslHyC/GatqUxRJle7gIlMm/LuFusIyUjA?=
 =?iso-8859-1?Q?SSXXKrz+FGiq21DnaLRfatXDXxCqFPFE4K4gLcyOSVUVly7A73k1/aoJbE?=
 =?iso-8859-1?Q?ol0iAl5257+RhjJFcRpMF+X3UsZuB0jgyI6gLRaaPGt51z9DHgx2AaMM3U?=
 =?iso-8859-1?Q?Ahiodhm/ZSik27jWamLNV1PrJEU+b2q6XrZjwbPXDpM5S7VFmG5xdSjv4S?=
 =?iso-8859-1?Q?W8mwgDz35AY7CZPBZ9OnOTHkoYJk5KqeLiA1/QM0mM4oZrLYdQ5VF7tAkg?=
 =?iso-8859-1?Q?tR83YeYI/2BfE7hTZ9GDbLtuB7qzfzWRn/JVG/zy2sf0vQkDcFiSMZ/VOb?=
 =?iso-8859-1?Q?NuYL2zhm+JOGc1yQhWV7MlWdwIirdJHsq91uVM42uzWUBSVqKFmiMb8b4P?=
 =?iso-8859-1?Q?+I7Fl2D99XI7dMIWOJlwCtBsmOfCh5HUDhpGtZXLh7U8UB3GcMub4jwF8r?=
 =?iso-8859-1?Q?RE5KCW/bi4bFtwu4nwpe4kgnEhZe9xkZ6qVWQzH7TSnZpNm+M0pL0peD3d?=
 =?iso-8859-1?Q?TSzyUHKhAQwpQiDE6p1P2v+u0rBxzohvPJJE4DQqUSrehwebEWgUqlEJjK?=
 =?iso-8859-1?Q?irOPAvU0ONqSZqcau1c6D2FfOlsuNS018hk81akXwHVF/62hFQDtwkzDHt?=
 =?iso-8859-1?Q?BpwODiB9dnzxU5BChV7/g8l4PoiQHFjVkeUnZSnxqjwbcggqQtUPMx6iBv?=
 =?iso-8859-1?Q?Qg7khN9nl3vTqAp+r2A79NV6hLrJEufQKVKpwThzMz69MKUFILALJdgdRY?=
 =?iso-8859-1?Q?ZtpKG8y9q5jOcY1iUjcCvZ2KR/yu5unZwATHBW8ISG5cxSevE9ir5J8Tb3?=
 =?iso-8859-1?Q?9ZD6BDx82wQyOymWBk2VEHHoPIyKfzxF/g8BC2yIiKt7iwXDIjq0AUUyVi?=
 =?iso-8859-1?Q?LbCsg+h6xtsHNFRsP7FsibgPskZzT/Eg9AU4ieA3KKMGV88E1j4NSDaWbk?=
 =?iso-8859-1?Q?Ow0vbnzy3sSBSOWVTbqBkcNyZWWouldO3bX+0zkGiCPoqR58g2A65mr6Tm?=
 =?iso-8859-1?Q?09En1uU1LsDIzxaIRWk9vH3rU4imeStbwtVmnIZNlWI8eSefO49JNHcnSL?=
 =?iso-8859-1?Q?riprANvmwuCleIQ5HHo0HoUhak98FMalrVIXrxPUHgLn9sHLY3A3qmh5vf?=
 =?iso-8859-1?Q?N/97fEoPZ9OZm5uTf+S9s5QYW6jeRx5dHN4lRHuRkpTZyQtRPdZZPbkiKk?=
 =?iso-8859-1?Q?5Xlvh++ShMAbCJl1fxSRy/r9FcVJrMoU6K2ThzWDQNpTNRJG/4tGPMzlG/?=
 =?iso-8859-1?Q?bKQe2YXYYhx31gDHEoHr6YT0g9HwItkA7erHJeplX1BPY9trqFsWqXNPCi?=
 =?iso-8859-1?Q?Y1n6xoYciw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: qsn0TW+9Cpxl2gOgoDPXYHbgPOZo1338UtP2sRa0dNbkFzfYsIHO8gdXN7Sh0B+c3G5lncaSNSluEzw0Lfw6Rmng7JqiAiUgDU8AxgONSNX6ZDY/cCzoWWZeatNV117uNSZgWNDbD9TIk2bp6h4nB2mmBbFfpDC446ONE2+BHEHka60vMH68SqtElB55LUxAc0yoBEFdvqTvQ7Vmk5hStpVDw/lCT5+u9796vM2/2sjMazJtf2H/EBkEo0uWjk+5C63lcUFF6MawpF2FHuZI0QYolncVttTQifQTz+kGFNz6yaH2KDCMP0fjAmaRQpdwaYvVD8Waytqh7sdBIElOJw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89ba830d-e288-4116-d29c-08df0711d2d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2026 03:42:04.2140 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gRTDRfP5VeWQ38uzwJ6dv79dRBf1x6UU/AnIFYBq9yf2QgNPAKS/J7OibVXVLR86Td0FftoDcZ50ooDgj8NpcSD1FpvSvPiXpSitemFazSw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE3PR06MB8096
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

