Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED131CD5BA6
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 06:53:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPxH6-0003OD-9l; Thu, 21 May 2026 02:52:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wPxGf-0003HI-SM; Thu, 21 May 2026 02:52:35 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wPxGd-00083B-Ii; Thu, 21 May 2026 02:52:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MQyC125rWkatPWwi4422+Uzy6DdnlTeriHgJfmnM1lfVx4svzC3tQAYswO71J1BLEQXEMe3YzJTYZTHx6oN+tcEhjtrsqI9rOjnfnXyf6bOPaMPAI112HC2MJkV2qfWhfpNQF868hRHXUzY9QmTa2vCpy1GxtSa4uZ9WvEhXiZ/W/yRyzspg1NJOLzfyafETbYzYwvbLi2DIFmqXvAlE3wBlBHeudocnaaO69HMfT+SgK19+GBpxQPVnb2sbDQuRyGfP5k6SINg7AWcAR3MonhNV3icqf0Qbs6NbfiUnTa0T96dcKOz10dTuZqn/es6w/v6bkq6MIFMubiG9ZqV91g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dyji6zUuLhjj3oN3jyYhLIvSoOzi42zwmUBqnJ7Qj+c=;
 b=Nuyh4exIw6kJZZzlVTaE6PkxRPQWX2fM7oGpgNFUjC4OBYmKMeskUTkXlG8awqLi/wKKjHLh+vm9RsrKxptHQJCkVzPArWRQrS9Avgzov8c/FXVd0+c6yFL2DUxgxqgbgb4qwmZNUajEM1XBmuNTe73UgA7WggsVwdPLrKHg0a09VJVFjiuLp6riljEKPwFA0vO6hqgbkbHNoIFLi9V25YnZ1Q7r/1wVu4W/gfb0ush4OPxEwdGlVl1c0tWIyWRwWh8LXcsxFabzM+4VKKHVfUqM2GYUxC7yAgoDMU7UoWhGhDCNVzT+WP+/x97TSyKRP9F2RgbnhI7xcaalc4X3Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dyji6zUuLhjj3oN3jyYhLIvSoOzi42zwmUBqnJ7Qj+c=;
 b=BF64KZrkKy13VtRd/U9dCC0Ie7cM2CJFT1BmZbjhtwLkfDGhf89eA8DxFw8PlVmVof7dnRCVeoFfmKH9Kuxs05zMjUE0VABO4VBBQC2Y+2T0iFpe4zQa1jD/71yV1d/ejt7phnI2g51gk7BoeJ4AOXIhrf7K3U91a60HrYpaC6yOWmW3Hg1DmTquFinYsaIEQZtHsh1ngHNinOoPeodoKwvxBm27IuNmWY31fyiS8FWqqJf91OOBC02JcHJu+leez0BfG/MyWxuOrRicVsD87txNZeATigD8sgsDn75rNzeosLxJi70XkiTnDy8XTVkyTrvnKGLiueLNXLLPOlGIBw==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KL1PR06MB6044.apcprd06.prod.outlook.com (2603:1096:820:d2::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Thu, 21 May
 2026 06:52:07 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%2]) with mapi id 15.21.0048.013; Thu, 21 May 2026
 06:52:06 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 2/4] hw/arm/aspeed: Introduce SDRAM memory region support
Thread-Topic: [PATCH v1 2/4] hw/arm/aspeed: Introduce SDRAM memory region
 support
Thread-Index: AQHc6O5WnnYEuz4P4kaqZWNoUKtWlg==
Date: Thu, 21 May 2026 06:52:06 +0000
Message-ID: <20260521065203.3713466-3-jamin_lin@aspeedtech.com>
References: <20260521065203.3713466-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260521065203.3713466-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|KL1PR06MB6044:EE_
x-ms-office365-filtering-correlation-id: 75c81afd-92ed-4fd1-298b-08deb7057927
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|56012099003|38070700021|22082099003|6133799003;
x-microsoft-antispam-message-info: Z4SyUmGRb5BxjyAmbdXI9oN23SPYTF0g91Q4O8u8RKoRdVJxpkwyje8AqrZ6jbB0TRpFANOVWHhfam4o/AimrN9DKlOLXv/HXXpQTiAKUBVWG5sb7Bqp1tLRFU2o+hFI34nflj26gJehsvYRLUEqFpHOYwn3tUOUfjOESLWPBBDZ959uFoxHK1ulF4j02MqmgAslKOrXBdt6KJLP2DaOyh4uL9b5oBsjsUlaxwdtMNYYBov02VnmUuvHnZM112fO3sNdDaNdR8QyIaua7WCTUWrVVcKTiKDh30eTGDROnv5jFSMmQaM/A4zYgr0xr0Ex3ICEWQQ9INVvLiDznpK/dXSrEJRTVD7LAfYGju+wiX5krDqlELi9kR0iQMin6f+bmskT40pWJQv9Hg9PiG6wUvjWyHwzmBSfHHmKzcJR8VhQXJmTpEbVIGFYq9n9PnN7NNwyaJ32eXKMptEWDXeZ69FaQ2g6CFUL36Oo0Q+8eB4vKbiTnifS/iRAcHAuZaMB9pJpRlV2rd0i2MxTVZFAyQ1NdVfQsJbv6ByV9He3iB1ObBnTZJ0NVmi4G3AnimUaQDbMDcTwfxuxH1Dym7sTzWEh2sBVyNe8+hr8Tkfeko0vhAEgz0NMRc25nEAbLTJvU3ZgJ0ZaYsWBAYz7aaCOhy8RrGy4Ir/sGA6FjRThPUhfItB1WDH2Q6QAwVJQ/Sikaka9K7JUrsqSaNO4nddA+FK8Oq94OBOf7sJ4xJKmRK6FL5dpy+x4O95/uWnGad6E
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(56012099003)(38070700021)(22082099003)(6133799003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?RWukCterWzwTadunImjf8SJulIAuRIscd5ytGedgmd+llzk1c15Jc0c3s3?=
 =?iso-8859-1?Q?TKH62oy5S4Qgqhgonq//dYCDpHtFfz2XKBu9Rsgn38W7bm6OTZyKANbxs0?=
 =?iso-8859-1?Q?z2LQcGuC2wZb2Plu7zKtg9tR2WMRG65ZjSXVeawGTlwHemBJ6Ooad+gh0e?=
 =?iso-8859-1?Q?tzAAlwHUFgtO904XDsF02QI49S7fakxnpGngFREN4cc68yKvFfPaM3NpX3?=
 =?iso-8859-1?Q?YTQDZpRcsAxglJWXDj7AqdgK5IIM0m3dhHXM3HlknpmRusL+SBPsCdH9P6?=
 =?iso-8859-1?Q?bkQtPyswJXC9xaEOv7SQ9G9sA8ogUiWETFNwn4rU+L+Afh0fQ98qq8vp6v?=
 =?iso-8859-1?Q?tthI6l9bt7rXFrpsCcAxOh6tkuALleAQhGDJMku3DhAm8/Rsi6Z1se+llB?=
 =?iso-8859-1?Q?Mr2Uj8o4VHcCw1H712vQ7Yq0KVF5lYuRkP80p1Air1woENywxOLV+YWnBP?=
 =?iso-8859-1?Q?b65P3S87Dt2A+xGoW5D8as76moNW4jMH5imc2ae+h0RDxJ6qDJ4iymZAl3?=
 =?iso-8859-1?Q?5xXCmQbBFj21yDgnXBfk+EuwKZpX27dAzLXwKtUuv70cnwCe7zx+YQ6WGa?=
 =?iso-8859-1?Q?YFbXMUp6COQOQaL7IhurFiGMW5umNzgj0b7lO7fkS88iCab3dQ8SRheE/a?=
 =?iso-8859-1?Q?UCvq63g+TWCpxZRYTt1SN4OC0iBIIgolNGeAOiQ0RiQ6RB+lqwUgWfmUXD?=
 =?iso-8859-1?Q?9L5gLMZaFE7zQJF1KpxNDmVB0mKCUX6zixyQIHT/Fd3Vn4tD9hxO5zlmzt?=
 =?iso-8859-1?Q?tuW9JrZ1I3N99ltcmRNfzaSRglYE4aO/8BImpBNx8gV8kmXR/W6QQxrkf0?=
 =?iso-8859-1?Q?VIuJeIRLW9KuYk0+MAg85f2JKXO1Oobo8o3PS5M1t1Ak98q/mpMx+IKvSO?=
 =?iso-8859-1?Q?ExYM6B/3m9HLRqRd2R+2kZoyH88Z7mLECHPsSwW3yqWw794Jv3ql3O7tui?=
 =?iso-8859-1?Q?aiNQbhblCxLxLM8y3homiw35yKYh6dzPngam93o+MGEbeNzQh6DoM3joCD?=
 =?iso-8859-1?Q?BHoGIZqamxEMbG5x05DPqpouD3rDUMmTyBE5nxd/84xE81MrOwwYlKmgYb?=
 =?iso-8859-1?Q?Qy8JR6owJ/4COT9uJhMq5PiQfafhxgfoJKjJmIeN0xT3kxQGTvAkwcTIOt?=
 =?iso-8859-1?Q?26pyHFJlU6QHJatHFRuLB4a/56AM6gAdUgtoa68ri1yAHYauuvSDA7NTYG?=
 =?iso-8859-1?Q?AgZRVx8LI17HlabD0n9ZwFzJN8cfIvGMbe08zQOOkxyUXdqVavBLf19mrO?=
 =?iso-8859-1?Q?Cj6a6nQfh481JHF9+9matVb9xHZAb0Z7UpiNnmdcMzvVHwWYAf6q2ovjPx?=
 =?iso-8859-1?Q?vTVDkOrSSJY+Z6jXTLeYOTNCq/5Xo+BZojky6f8SUOruwrHCTUlpEm1fev?=
 =?iso-8859-1?Q?ybsGs+lucQOFBcUFySZJ0cPK7MD1RXHRNfk2hJcFiy+vf3Ym68w66jfEX0?=
 =?iso-8859-1?Q?QE87cjntJyfK16yhjB5k7KlR1FrfXcubRs2ByKspSjN2rUapFZGbzdUdm9?=
 =?iso-8859-1?Q?scoAZ6PTshlab9zOVbbBifRI71kn022T0koOaiCtLUSFHaDZZZ7WzknDRf?=
 =?iso-8859-1?Q?ArDlDD6//B2hXXGbtdyc7Za7Gj3T8t+Ra5xnQSFC5QlQIR7kC8ZqTv7Dsq?=
 =?iso-8859-1?Q?0gGE05E6k0Vf734N8vJEtqv2/S12pTovHP0dt6OXPlC671yl01Z2lGrbAH?=
 =?iso-8859-1?Q?qn2Y9qsM+wbCCt8VM2KISQRgZc/ZymHLHxWUoKeB8v7uzvmPnydZsAcViu?=
 =?iso-8859-1?Q?fmX8ygvnRELlbEkPDoxBGl1u+MsLrGNhYkLpKRcL6CkTRek77tA4pf/XJ2?=
 =?iso-8859-1?Q?8t2oQVekFg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: aJoVusz2qd1ebtIbAf2W3qC2LpyXGRKPkbrJOZ32plnC4WtnLXhtNqoorhDQgZNyDjkgM7IYkYrGgYyGqEYJUy02PddLKue/FZ1rllJLB4AE8MB3LuVAqGEc52fakJ+E21OWiStdZxO65j8C0j2bO+wqgII1XPURqqXD74AyCE+adzphwMe+oGTv14mXWfubnNjzZQ0ZJ1OS5U7d9Wew6LpwgCueB+rAXq8fV4N3HvPsBujF4/7iZnJW+ZP7Y8L99dZbmKaN9UH2wyAcV34jQ8CG1YHyQpUzE4gxuuOJS94P1A+baCOZfArPkxQad8g4GOMOTsswS3lHOyRJKr0ZoQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75c81afd-92ed-4fd1-298b-08deb7057927
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2026 06:52:06.8041 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3lUezlrZ5rco32KbIDfLxalYqb7BfEB59pMq2JTqhCMYWI8jsdMD16eAsRyQWwjyGejPnQDhI4dIit0gOzx37/1Wne7IgSq14lMFfmGekIY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6044
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

AST1040 platforms require dedicated SDRAM handling in addition to=0A=
the existing SRAM support. Add an SDRAM MemoryRegion to=0A=
AspeedSoCState and introduce an sdram_size field in=0A=
AspeedSoCClass for SoC-specific SDRAM configuration.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 include/hw/arm/aspeed_soc.h | 2 ++=0A=
 1 file changed, 2 insertions(+)=0A=
=0A=
diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h=0A=
index d7b3647ca1..ce431be940 100644=0A=
--- a/include/hw/arm/aspeed_soc.h=0A=
+++ b/include/hw/arm/aspeed_soc.h=0A=
@@ -67,6 +67,7 @@ struct AspeedSoCState {=0A=
     MemoryRegion *memory;=0A=
     MemoryRegion *dram_mr;=0A=
     MemoryRegion dram_container;=0A=
+    MemoryRegion sdram;=0A=
     MemoryRegion sram;=0A=
     MemoryRegion spi_boot_container;=0A=
     MemoryRegion spi_boot;=0A=
@@ -171,6 +172,7 @@ struct AspeedSoCClass {=0A=
     /** valid_cpu_types: NULL terminated array of a single CPU type. */=0A=
     const char * const *valid_cpu_types;=0A=
     uint32_t silicon_rev;=0A=
+    uint64_t sdram_size;=0A=
     uint64_t sram_size;=0A=
     uint64_t secsram_size;=0A=
     int pcie_num;=0A=
-- =0A=
2.43.0=0A=

