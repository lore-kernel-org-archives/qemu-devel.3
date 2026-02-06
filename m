Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44C5BEB28C8
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 05:35:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voETt-0003d1-45; Fri, 06 Feb 2026 00:34:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1voETr-0003c9-K1; Fri, 06 Feb 2026 00:34:11 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1voETq-0007WD-22; Fri, 06 Feb 2026 00:34:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gLPLX2IyY4Vo5u1LdINWjL9QH2iov+MGo5RyZSiEExhumQASzhWL7Vcs08xvw9K5bAmVEypzRN0+z6GVyfX3//Wtr2z126Oah7M9FwOjrMcc45qk+d5TSAzktJfvTkRkaP7t2xofk8PYSkHbhfXzFHkE4Q+aly76RYrVw8YhVs9d1ZKjUIQwTxk4VuELSyPXNpR0K/Oq3jCjm7tVPywN9LBtva4ROzyWp7lxS0OtnkX8UgaoxMiZGPkY6VYh7TKn+xDmJZnodw+xu8kisLsbxjjMDedYj2G4F/e3Wj+EfNBGiv+d7i0HOwXkrcV49V863JY7BWcFaul+alnMdnTSSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sSrsddnDBBDs7eUNKIbSDk6Fc+hnMDe2V4bO8/Yzsow=;
 b=CMaFFjv+9YijJ09hqQFix7kfKYMHkaH7Re9vGpBQCyHISbDEwJwlRstHM+IuB1ngjR3jF8nQ4LVK46+hp4moNoi6yZLq2NiQ+hH+9DCnwrPO4TAEGpCWmGZ3dtv5LKAYnwFSCeoHFNo+xYZcUI2AG/oaJY1SaHsfAgao/49JJNoApG0v9Ym+dFYG9KKAQ6yQUr5th4H2wiYwGuUzoNigbH65Ova4FlhGsCLt9cLnWM64GoW7nYeHoqksVIOZSaSCw7mm1N8E5BkIeKi4yWIXvTrxUhy2Ea5rIFz2YiOwvA+iuMJ774snKuGCjffO3ySJaGxdMNX4aqzTKfXb8MtTPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sSrsddnDBBDs7eUNKIbSDk6Fc+hnMDe2V4bO8/Yzsow=;
 b=poVnQLFnzkB5MP+Dk3Kpi/0OHcw4KmZ+4n9Tt/Og7acD6PVyFwD8MDC4Iq4EasqsNYtvutogn1nklj7DJtVrHWwYWwn0h6muH7TBCMA6L91qwnAHWynCMBNF/5fyC59mTVJrK2lAdsG/EXPLmzcDBCZxraahkX8Ee/t9+kNLgIONmSj/8rOclEa5J579paasZYkfUg83DpPaT+olw6fD60y7I/jNGm0fFqAx1umsJSXbKdBhcyA3La2HAyUNmcYVjOn0oL8EhaUzVjDIrxMRdxNbE7OV+3Q+KK17fgFxEFwcylH7DRfJXQa79C8UZ/OkyXUsTqHKpsHSShHNA2o3yg==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SI6PR06MB7165.apcprd06.prod.outlook.com (2603:1096:4:252::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Fri, 6 Feb
 2026 05:33:55 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9587.013; Fri, 6 Feb 2026
 05:33:55 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, Fabiano Rosas <farosas@suse.de>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>
Subject: [PATCH v1 10/10] tests/functional/aarch64/test_aspeed_ast2700fc: Use
 AST2700 A2 SDK image for FC tests
Thread-Topic: [PATCH v1 10/10] tests/functional/aarch64/test_aspeed_ast2700fc:
 Use AST2700 A2 SDK image for FC tests
Thread-Index: AQHclyovHwJu7RFu3kqivBNT/2eBmA==
Date: Fri, 6 Feb 2026 05:33:54 +0000
Message-ID: <20260206053340.3716041-12-jamin_lin@aspeedtech.com>
References: <20260206053340.3716041-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260206053340.3716041-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SI6PR06MB7165:EE_
x-ms-office365-filtering-correlation-id: 20c6db79-989c-4784-1111-08de6541519c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|38070700021|921020; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?epIWbZtIf7SlJVoTXZFiXqzOxPPF3+5fFPi7jDenlfPKzrEIxwdGXGk2Zz?=
 =?iso-8859-1?Q?pN3plQsiPSQV0Xl+En5wQF84ELNJjsLXovlXwUAl7GAO3tP03k8RZNJ5vI?=
 =?iso-8859-1?Q?H2bUKXC0PxV1UtkNSqVw9lU6sMbqf7SyFIEihVe1i2ryhip0sgKXDc7Z+V?=
 =?iso-8859-1?Q?czqpypCI9ABLjqDbef9cpfQv4VfUmAO7EtiUumYByOsPTIvhYghb+3pfnT?=
 =?iso-8859-1?Q?kuN1TQ423wzqQ9QyEUertxJ2LQJ6/uKHawF6IKw7dLUbj0vv5jIrn2CSIn?=
 =?iso-8859-1?Q?68MKBbyLxjBsDHMdAqNdfD9lYKIEy1IFaJPq25p132emDYhEnmEDWfUUgN?=
 =?iso-8859-1?Q?dmoTggvCVKCt6Aye8vdyolpvO36L1PBjcm2IgHRrP9rwN4ZvnYd5yAiJRm?=
 =?iso-8859-1?Q?WUWmUb8cqvDtLUAppe7lpDKjtAUTfhYbP4Q1AQOcp0u2EBo9IcwTcRc4Pz?=
 =?iso-8859-1?Q?GbV4oWXQri0BpwpCugnMEugSx6yuBppoEuCnxeLRZKVQcUCmFJr6VAvZr1?=
 =?iso-8859-1?Q?Tz4fT9t40Mh9q+vbaEDejVR1QBGbFyjrKSmsqMGdigRXox97nGiYu85K5x?=
 =?iso-8859-1?Q?usb/fJvtvCODB4nQoOhMc00rmfYuGJJsVxNRam2cEb73c19rFb/3R8SGPY?=
 =?iso-8859-1?Q?+La5yx1roP8pV15QppNUmVRk57BWRJQCzAipabJrfl0H6EoZa4t9Vie1+R?=
 =?iso-8859-1?Q?0UC0qEyfoOtVHri1o8usScWU4omKlmI2rJuF6Pcxj4M1d3cDJoO3cR5MxY?=
 =?iso-8859-1?Q?3e9IgGTiyRaX7rTtNG7AHfKCFsauy2vvdcLzpl2Oqvvfqb/YHiYa4VIo8W?=
 =?iso-8859-1?Q?y+3zp5uo2oCdwkYQoYRs20ed2Oyr5rSyjXD3xXfVR6w+004Qrh3f84aNaX?=
 =?iso-8859-1?Q?W8o1aj9ET5L+T3VXj08nmlXN+AsgT/wVcT8o8ZCKx1QuxMNPE9gH+YXYfz?=
 =?iso-8859-1?Q?EwkRIGllrJhmVyEKgYejBmhVdozSJjFBN4/e6fgcJ9tZfZC/BLNtzyOaj7?=
 =?iso-8859-1?Q?oBA/tRHnZ/8+sE5eMIpCuSbxQJSYhpcMeYMaI0jBA03MrKCl9cW3S7oKRc?=
 =?iso-8859-1?Q?BQT12aybmMoxSDZD58mhA0DYl/eZrbUR/tnc+NgEfJriv6Gi3jmyWbmYWF?=
 =?iso-8859-1?Q?jPQS+6utfEqNGxovQ8k2rCYAG7dVJPX4+xXoJyNoGF1V3WRS2TPwhQu7GZ?=
 =?iso-8859-1?Q?D8XBLTGy0WAGdp8n4il4BK9TobGQlZs6Ux79e43d+f4xneDe68eJnac5Tx?=
 =?iso-8859-1?Q?DrC6OqxpX6/ebe7fCrTf2ZjhKC5UHpTlOy0ozKD74YJ4Eq45THiV886nwZ?=
 =?iso-8859-1?Q?L8QipDFfV7TowO1+GOmHWzKgZQhEp538S3mNmLJp4wtfVZWTD6C8V4y2tM?=
 =?iso-8859-1?Q?oZ+pMVMPrD/Ebrl/VVt6FrWeYMFY60S8W+OjSm92Cd3jMOClAPQcd2Ga/o?=
 =?iso-8859-1?Q?aQ5k8n8DWmwXdVumquq6W2AAQpMklhghP7lh8ftLxrCH/faXJFixNkybow?=
 =?iso-8859-1?Q?0RguwPjE+0flBCK9Vgvy6HbuhPslBoqYj9dfK8pvRJGmNYqKD6UysZaLbV?=
 =?iso-8859-1?Q?bXn0oU3tFA/2hk+oI5RLh43DTB8j6y22/eLg6lekSEYM5eXFn9lQEO6yH0?=
 =?iso-8859-1?Q?Wdlh+W4w/BaRMgnS1YjHxqwU8wSoTuac1YxFdX7iEJ9TJjA3E9Nnf/cw?=
 =?iso-8859-1?Q?=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?BXONJO5cGrua94UR0OIdy7lzE1h2SJI215XxvXERatsSfHuBw3/ZTdNm7c?=
 =?iso-8859-1?Q?gu94RG0uoOSzFEU8D8YpZwJokWO1qwderJhTAo3bQYEYGphcPGgNwTRTlH?=
 =?iso-8859-1?Q?3DxrR1RY9eGthabiBxeirvxk7xIEmbKr5gaZgZdgvu78wjqMTJvhIr0oPG?=
 =?iso-8859-1?Q?iObP7xqrsf6TKB5rkBwNYhOMAY9SEcBBDrIjj707YigxV0rLxVSpadgKdT?=
 =?iso-8859-1?Q?MIHP7mmPLmL2kW6K1McU7EtYNGD+RHTgEKIdlfOGQXVRlmUDQiU2wHdmAN?=
 =?iso-8859-1?Q?Hn/P2z1jjrirphg0dkRFcPzeY7UCLuCQipdWD2FgbNob6pSeEWDtc49KtR?=
 =?iso-8859-1?Q?eMFe+t3D2SFtey/Mf2Ss8yA9wDNhGGr9ogF1K30YAT48ug/CK4gpEOEBIT?=
 =?iso-8859-1?Q?jIBzyLcTgY3SfndiWJ1tQfDvc1HL0SS8VHX8jWpdZmk14GI7IPaDDDWx7+?=
 =?iso-8859-1?Q?G1SY+UmIdNK9DA/xqMY2UqANAYpFUsfWW1ZjBsTw4bI9v/vVLmCc0Q6cSB?=
 =?iso-8859-1?Q?f4zazE4wZcp6KIvB1iIV1dFicGyk39AHYW9Ok9tQVbgREOg6zy6ByaW3AQ?=
 =?iso-8859-1?Q?v7aAJATxfrT/GoUd4sKzHRNmGrKofI1+ZiOIbqvBWs/I2XT1Ws4wqXrhtT?=
 =?iso-8859-1?Q?5lpXSRAIzjZEOu30AjlFC064LU7Ii5sB1EAMj+BPuxjACPtGGJzpJOeukf?=
 =?iso-8859-1?Q?7rV62tknLNmWrHtxFBXuKLbtUGaaxfMHBVanspQYLanEnvI77uf5OBMOWL?=
 =?iso-8859-1?Q?qh2IXkONxDnH4LWi2sTYg5sYmVmGduyGFVJBVzXX2cU9ksrce7Cr4x/vFn?=
 =?iso-8859-1?Q?6FdZ/LK5nVz5BMdtCcydy5JoM0gIrBvRBG6sbi9wGWPVtRqke6yFMzr779?=
 =?iso-8859-1?Q?tadJ4nZBu6ztmbwuhBpW8mGQtuHYco6NklPD4/zOOCGShGEIXsHlXVINEl?=
 =?iso-8859-1?Q?WoAIT93N9QQ/75jBG6yR5/rXkhFHAais09eeTkothnQwwUz+IaUU5Z36Td?=
 =?iso-8859-1?Q?h/FyV64J+sayG0lbYmr/UlLlWpY1eiPjGn3q7I3LDNwMOmyNTht6VWk0Tg?=
 =?iso-8859-1?Q?pJhsh5utbEkPlMOzWHViwrNACa+h65nIQD1BqtnwVovxr2R3HfWE4Gonwq?=
 =?iso-8859-1?Q?iIQUUKo3PK0yggx2RQzbAMXIHOcMEhvTh+RiWzO41gDqs+8TmZqqO4Orcz?=
 =?iso-8859-1?Q?sWDqgnIQuYwqVTSavGqayjTpWJXsVtA3yS8zXz7bj/eXQfWyc1Gc+CQo9P?=
 =?iso-8859-1?Q?hoZ5lW2P+gO4n2LqHnVuB5TsjMF/56yNQfvoKsAGdw9rm4fEyUdYWUmWAQ?=
 =?iso-8859-1?Q?mdFsxMC3wM1uPh3crOD5QykYDWSeKfDQVFTkZfWgl/u6/LGke/+aSMAGz1?=
 =?iso-8859-1?Q?bG0Dn+HFb+yL98PMqSVSLSjPr+Gjs81XL68Qg/qBkEbJs/bcAJgMzZZRZb?=
 =?iso-8859-1?Q?mpLfER66ZQbYT2KCJszNy5Nk7UA6NKWDMibpFyTEyO7/lEv+ENpG3W7X08?=
 =?iso-8859-1?Q?PmxwkXpdEDwgiEjNzdm15mZMgGTgXgh/Dd9r/AjCu9//12UE4wSBoE9c3/?=
 =?iso-8859-1?Q?Gx+235CqpLaMIMSd7t5dOJLiSiOeOYA+J4PgEgKJPdN2n1vxxoZGMTUbCq?=
 =?iso-8859-1?Q?ImwqMlkxtvpV88rBQOr5nXhZ6ujwbMVyaVbR4q0JM73fmYZ9MdGGW3QDxS?=
 =?iso-8859-1?Q?kAjstqWElTb6yGty+ipUWAWkLPCsS9+lx4vEX7rggQCZd8VMH0eCs0uEdI?=
 =?iso-8859-1?Q?XHBluDDTd1LuNUYS2fZepHolKBjGhIQ0tdxFJrwPZzQ9OZZPGXuikPjiUW?=
 =?iso-8859-1?Q?iYOjRQCDIw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20c6db79-989c-4784-1111-08de6541519c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2026 05:33:54.9632 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6IIO78pSAemqtXhQ235xtM/t00+oraYoBw71DSKAPAe1JPlDwoFg1raN+n5AIbCCvW1mw7r2PueXEZ+ys89EjMa/lT0h44XNtFN7NOZeVZs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI6PR06MB7165
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

Update AST2700 FC functional tests to use the AST2700 A2 SDK v11.00 image.=
=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 .../functional/aarch64/test_aspeed_ast2700fc.py  | 16 ++++++++--------=0A=
 1 file changed, 8 insertions(+), 8 deletions(-)=0A=
=0A=
diff --git a/tests/functional/aarch64/test_aspeed_ast2700fc.py b/tests/func=
tional/aarch64/test_aspeed_ast2700fc.py=0A=
index 47e56dcfc5..51ee8bc787 100755=0A=
--- a/tests/functional/aarch64/test_aspeed_ast2700fc.py=0A=
+++ b/tests/functional/aarch64/test_aspeed_ast2700fc.py=0A=
@@ -62,8 +62,8 @@ def load_ast2700fc_coprocessor(self, name):=0A=
                              f'loader,file=3D{file},cpu-num=3D{cpu_num}')=
=0A=
 =0A=
     ASSET_SDK_V1100_AST2700 =3D Asset(=0A=
-            'https://github.com/AspeedTech-BMC/openbmc/releases/download/v=
11.00/ast2700-a1-obmc.tar.gz',=0A=
-            'd5ceed511cd0dfefbb102fff2d731159e0472948a28066dc0d90bcd54be76=
525')=0A=
+            'https://github.com/AspeedTech-BMC/openbmc/releases/download/v=
11.00/ast2700-default-obmc.tar.gz',=0A=
+            'e2b8f043fe8063dd3b6ded93422e38bd41914dc9c3202199507652df024de=
4dc')=0A=
 =0A=
     def do_ast2700_i2c_test(self):=0A=
         exec_command_and_wait_for_pattern(self,=0A=
@@ -98,7 +98,7 @@ def do_ast2700fc_ssp_test(self):=0A=
         exec_command_and_wait_for_pattern(self, 'version',=0A=
                                           'Zephyr version 3.7.1')=0A=
         exec_command_and_wait_for_pattern(self, 'md 72c02000 1',=0A=
-                                          '[72c02000] 06010103')=0A=
+                                          '[72c02000] 06020103')=0A=
 =0A=
     def do_ast2700fc_tsp_test(self):=0A=
         self.vm.shutdown()=0A=
@@ -109,7 +109,7 @@ def do_ast2700fc_tsp_test(self):=0A=
         exec_command_and_wait_for_pattern(self, 'version',=0A=
                                           'Zephyr version 3.7.1')=0A=
         exec_command_and_wait_for_pattern(self, 'md 72c02000 1',=0A=
-                                          '[72c02000] 06010103')=0A=
+                                          '[72c02000] 06020103')=0A=
 =0A=
     def start_ast2700fc_test(self, name):=0A=
         ca35_core =3D 4=0A=
@@ -153,8 +153,8 @@ def test_aarch64_ast2700fc_sdk_v11_00(self):=0A=
         self.require_netdev('user')=0A=
 =0A=
         self.archive_extract(self.ASSET_SDK_V1100_AST2700)=0A=
-        self.start_ast2700fc_test('ast2700-a1')=0A=
-        self.verify_openbmc_boot_and_login('ast2700-a1')=0A=
+        self.start_ast2700fc_test('ast2700-default')=0A=
+        self.verify_openbmc_boot_and_login('ast2700-default')=0A=
         self.do_ast2700_i2c_test()=0A=
         self.do_ast2700_pcie_test()=0A=
         self.do_ast2700fc_ssp_test()=0A=
@@ -164,8 +164,8 @@ def test_aarch64_ast2700fc_sdk_vbootrom_v11_00(self):=
=0A=
         self.set_machine('ast2700fc')=0A=
 =0A=
         self.archive_extract(self.ASSET_SDK_V1100_AST2700)=0A=
-        self.start_ast2700fc_test_vbootrom('ast2700-a1')=0A=
-        self.verify_openbmc_boot_and_login('ast2700-a1')=0A=
+        self.start_ast2700fc_test_vbootrom('ast2700-default')=0A=
+        self.verify_openbmc_boot_and_login('ast2700-default')=0A=
         self.do_ast2700fc_ssp_test()=0A=
         self.do_ast2700fc_tsp_test()=0A=
 =0A=
-- =0A=
2.43.0=0A=

