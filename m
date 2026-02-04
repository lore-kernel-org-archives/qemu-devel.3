Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF8CAE83EE6
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 07:18:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnX8p-0005wb-SD; Wed, 04 Feb 2026 02:17:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vnWZL-0004em-KZ; Wed, 04 Feb 2026 01:40:55 -0500
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vnWZJ-0004KA-PJ; Wed, 04 Feb 2026 01:40:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IF68GVQvWTau9SOYE6Uu/wXVI8LG5oO6d0qa+nTrQIYgBZAPRjohVZaLKXUUDOwgtHpHJbZBlh303AzfDffFCEAJeBmulPhrpDgKo0iXDaJNdVkAxAlv9OTbSXkkM9aqAD25Uejpngd9bhq3ptzmDK75M1nn9gbYYeMGA9omIMv3EXh660t5I74XVHu7bWmOuc5mpP2Lx8O/APTbDrouEmv1WTr1KpDlJP7JlZ5ur6airR6WqGVrIkepwvXmmlWOU2mDHrOwcXLGthZoXbIyTczw50PAIy27e8kwDRJPT+4kohALgzmOT5PMIXvPh6LoAWoPkqIhi/kGAPEuplrU3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PyFz6C9NjgCSu7Iq6a+36uEHCmx40oD3DTtYAI9VrdE=;
 b=VFC8FH7N9s71DvIsQGM390loNSBVXgSULXZKHWk4Vh1E0I44lWWkDO1lWH8e/eoptKjTldtJr4YndVFnQ5M4G1tlI91t3+976sf6IOuKY68xHQoqZgFBkYBuhR0PzFPsHvN7tRssEWMQLvjxFXZ59hhbI6x0yl0IYQvVyZVnEBCsqqgiQPa40mFFNSxiIikWZFWjnIcT1dBQUMV8oIGF6TS1bBTwDE+Lnftka6s5HD1ue6bvdrI/SDMflbhfeqn0MyQIUgtaKo2DlIowduh7Xqv383qV+VJKFMhyUNXx5oY5gwNCs8s7LNd9MvyWDzAf5DkcU2SCfdOd2eqNRYLrIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PyFz6C9NjgCSu7Iq6a+36uEHCmx40oD3DTtYAI9VrdE=;
 b=qfZRW93tBFCbsPGuvvVPmXmrBqWNe6EoVUKKVJIi43AutTm2BJ7UqZFw0tpRliBkTjqG/lAuQ8dngoC6uwvp0kB4BIRZ2gMH2GK2XlhtZaIc2x4hKyCmryPgieNZ/zdB119QIegu8/ArpFvrfJth1ssce+eeqstFeb4g0cVN0GeXCt2dzPLCGfuMlVNtA8kYhGGYiJqGHVK8NB+FGlu2uk9ovBES07+e5UqD6j0/0ZuiJDYitliQACLfds2f3dyZ0d0W1K9p5HHcOeci6IEoyEjLAn2wgEXkFxNR1CLv5FN5iKliCEu33uP2ZMacoqQCzzmPW358mKd+9f2tEy+OwA==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by PUZPR06MB5901.apcprd06.prod.outlook.com (2603:1096:301:110::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.8; Wed, 4 Feb
 2026 06:40:37 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c%4]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 06:40:37 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>
Subject: [PATCH v6 14/22] hw/arm/aspeed: attach I2C device to AST1700 model
Thread-Topic: [PATCH v6 14/22] hw/arm/aspeed: attach I2C device to AST1700
 model
Thread-Index: AQHclaEr4FA9OZznW0me4M6l6ALy1g==
Date: Wed, 4 Feb 2026 06:40:36 +0000
Message-ID: <20260204064016.3515639-15-kane_chen@aspeedtech.com>
References: <20260204064016.3515639-1-kane_chen@aspeedtech.com>
In-Reply-To: <20260204064016.3515639-1-kane_chen@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|PUZPR06MB5901:EE_
x-ms-office365-filtering-correlation-id: a27826de-9c14-42b5-16d1-08de63b84e38
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?P/AkRNk/KSjD/S6/FaF5TAeZOWttnveEndtQvvWeP+ewSM5uBFLwfsORnb?=
 =?iso-8859-1?Q?fI6aSFztdgA2tuMi3Xs5icuoeTQUUGwXH4LrANxlDtDDosCVuFLcbsr4Fz?=
 =?iso-8859-1?Q?bymPcrRU8Zbia3ku3Rgk8ZzXoTj0dSUC3ntmcujxzfg2G7uJfI52nWTCr3?=
 =?iso-8859-1?Q?xDgIHjKPh+5XumYipqSGj7wkKf9eO6/EwxMDJVO4gU5l6En1ifTxHGWjyv?=
 =?iso-8859-1?Q?7leorYYQSI0pneSyEYHUoPkcfoyITnLLZ9N892JZqMRKy6IxpKP3cw1c+Z?=
 =?iso-8859-1?Q?gSa+btUXJUPYv3muu0wPvf2B67eyufBETqxIUNSH2xXSYWrRVNYlWPf2sf?=
 =?iso-8859-1?Q?rnz3vr056ehPzLxAnz8uMEB1vpnZ3vk57cLIz4UXXCPdHeaYAEGKikGY2X?=
 =?iso-8859-1?Q?Ah0yvih0/X6ELHV51TR9Y2hx3Bmw7e3gkVs3tdcQizQhVt3S6bnEGM+VDR?=
 =?iso-8859-1?Q?UCmYNaQSK9nTjJtm04k8ISqvEsLgHIoFgmNv6NSwOJDfMLiol7R8sBvWAF?=
 =?iso-8859-1?Q?RAiyLgpx7l2LhhK9OF9EWqBRxGs9PUPpLhPTuPKyhkfQraDuao09geew/a?=
 =?iso-8859-1?Q?IUOxutG8E5SKORIW0GYS1PUfatTQEfd2WJRePxhNI7Ba8KRzywec4ULjeG?=
 =?iso-8859-1?Q?QYgGlQZ4Q4+0vl/NIQ7MBJWAajrHwqoT2HX8EZCLTR/3WKxCiVemICc0zl?=
 =?iso-8859-1?Q?crzcdB5YGteVW+fKai6bno2fJnFAxzO8qdM3C2B0YBKPIm2tiZ1fsQ2elY?=
 =?iso-8859-1?Q?rOGRKxggT0WAB8+wYVAf+vhBZSUcWWlaK8S021jqy0UBlz+XqebEQjbxvh?=
 =?iso-8859-1?Q?PoKNHvXVlCxyNW45mjF6W3uhlJ2fh5MRQk2WXvRacERVCGWWnJQily24TV?=
 =?iso-8859-1?Q?1jaiy3xS0T0suBoFCuJI2Xcpo4V6LJfJ/h8pW1lDWoJ/4IVuL9LUD+jEdI?=
 =?iso-8859-1?Q?Rt9HgnMxARhWlLVJXAd7ICUCJisen8LK7qoVlMAt+OGDscaaXUd7t1RcUC?=
 =?iso-8859-1?Q?P2aj5qc28iE8OoLB14J96oX0NCH3f6Z7Of6H+2Qxg9OiFM/TvsdZ9y/V8R?=
 =?iso-8859-1?Q?EuVFvQhAm6SfH9UImA0mtxSunGfoUXp0ePbu0h9KktP0ZqtO3Q0/T0iJ4+?=
 =?iso-8859-1?Q?W7Ke7rGEf32fWtgcOtoJLnt97XcM4wZrkJ3foI7O2EZRXaUUWJTlnKwAk3?=
 =?iso-8859-1?Q?TUZbyHGT3IpCXoYyRVARMZCXtORLCm2ztZLYFU301XSBUR9V9ynNqaXBak?=
 =?iso-8859-1?Q?1+w/WWpW+ZrXgEMdj1udv7IcuELEsnZDNRFmybPxadYHCE7uyC/zFeK3sy?=
 =?iso-8859-1?Q?qw4cNRO0v21WFdsikHdiLOLmOv5wIfVCnffw8yIZcNMl5Up1+dgXSjliOx?=
 =?iso-8859-1?Q?raXxPqTdJPXSs6TrW1HiJxqw+PPEqcjgFXrxfTXnNFqQupzQFVwPsz/fTd?=
 =?iso-8859-1?Q?NfmGUOWcge06GyU8+1nNmrxB0fwBsKyxpUEWx9mv6Ieogj0pQ3Ull/uWke?=
 =?iso-8859-1?Q?BMJootZLktfmt5mpkxmyBH8hj4xSFZ75UuZ28bXBjhk+hMT9FbPV2RYP8V?=
 =?iso-8859-1?Q?jjJ4ONX0fQDkjsBjE5PgtTV95QxCOENEPoGVvUZNRxmiF3zNI/AMxGRM2E?=
 =?iso-8859-1?Q?uH95664oiRHCZoaT0tivdAIhVnryqiPPPjehRPxJO1JqpHEei8OH5/RDpZ?=
 =?iso-8859-1?Q?oGxV+a3C6/ZSmr1/zxg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?9+gnzivQA4dDYam6X4TJoAMehvw2ui7twwneBDyi2SHpnAvyxPo812f12I?=
 =?iso-8859-1?Q?pBbPuTQWufGcQ305yXCh6HOR7qbhAv4GBMNGAXPp1KvwLamyGRaUaYAjU4?=
 =?iso-8859-1?Q?A4FlsHm2v+Ae2HpewXokQX1Gvc0tYORAQLka/8lNIIFQLcn33ewcbIgzmk?=
 =?iso-8859-1?Q?5X4YsWubmdIhkNuaw7qlgY9PgNa6EIF/QXkZzUu3yXLCUTvXKg1+wU7pQO?=
 =?iso-8859-1?Q?E0Z/Q1FHO+hZJnAva3kEyiFfnP+M2TpXSX0OUcvK3puNq/nGTlCO2qjD65?=
 =?iso-8859-1?Q?NlRuDl3c6M6lh3N9ThPbtpBRVw5tD8fBa2fxc44yu0EoroDSFtNqCv86qV?=
 =?iso-8859-1?Q?SNVDy53/37RLru+bT1EK8zJZoISdZv0aQ7Jo4upNyu2+x8f0fBT9nXhaB1?=
 =?iso-8859-1?Q?z04kcRJjiYyzZ4cQXe1rv9H2aemKmh+sDwK5TsKgHN8ITjC8oWfn6i90O+?=
 =?iso-8859-1?Q?e9EXwwHC7CuDnlLT+wYxdqtwZUam5EIBvteMYyfKYsbdcBcnEP5OoT4XjR?=
 =?iso-8859-1?Q?r/TNMtl7+sCfnrPVMUNqAGIlfP8AYu6Gb/dlSHhMc2SlX0p6aiKgyRBU87?=
 =?iso-8859-1?Q?CW6vYE67rG9rXoBJKp+k9guTkzE/+nI4iuUrAgaxdSfRktvvGKxbCRf1+/?=
 =?iso-8859-1?Q?+TZIPVLD2eAkyjYPw4+FdHC/6aOtcSEgINg8cuu9gmhT+CFomha1k+BC3U?=
 =?iso-8859-1?Q?fYhWvuhNri4G6t0Rjwx7mtLXJXHFbbNJd1MhVBXmZ577ydETkZz82sGoI8?=
 =?iso-8859-1?Q?EjFg9RxL+Sn8ywnnxbBz8CwTCvUSoY6YFQ67o9zshV6NakV7URE4rM9yv+?=
 =?iso-8859-1?Q?gC2KbiGR4zCVeDbHhcIQbncZUEgNuE86I5Y6NPk6ZHOCjJUGad3bS3x5Hk?=
 =?iso-8859-1?Q?RL/WFJyBPFkjF1l19yGEaly64hPT6hMpuYzsozw/PJix/A1N9symJlPXDS?=
 =?iso-8859-1?Q?HeJueswR+CEAIKVd/0zLeA5vFHNN5oonPvxA/JeLl+uxlIMFsZYbENrHZ8?=
 =?iso-8859-1?Q?iW5h4VgdgVWqYY56+tmvMX0ePqaR1lLnNkPNE3eAccgvG8gwWPy7U+5/mD?=
 =?iso-8859-1?Q?nHeNuZC0jP7EX2/MHrzOrTqqcGf8ZayIP8OAhZvQtsZlV6V1FtGH8RkMOs?=
 =?iso-8859-1?Q?EmKF0OEgWGAiam8OXQx70mf3WF17ptGeUBp5U6uOFRaV27qkqpIIt86cB+?=
 =?iso-8859-1?Q?6hPIjAY55qXNb/B1p4lzvPI+PIHY8dKABI4+ucLBBaCQa/XykKL+vYgdji?=
 =?iso-8859-1?Q?CPtaW23FMv56UQ2yI/QC++92AH2ETwPPZLoiKSKTJ2V7+zrgPA4z6eRfr+?=
 =?iso-8859-1?Q?OkIX66i9PKXORp+x6t2A1GscNRJlQbtUfc0oYsvq3ya+VDK7DWv8QjxXz4?=
 =?iso-8859-1?Q?P9KKl102TO3uEl6bCjfx+Ea5Zn2p+aa31AIgXZNHpREa6fsaR2b1uGHv1p?=
 =?iso-8859-1?Q?WaU3SHkUKSSqX1GIkO8BUIyeTEZq+5viR9+rgQtKRV+Wq33At9Wn6EEWYN?=
 =?iso-8859-1?Q?6S/3Tdqh+OA1ObV9wqtqNvDABTQAV4uhy9nNkc2t/82tk5n/0EwsttS+f1?=
 =?iso-8859-1?Q?TUj23HOCiEbRuA5Taz8o/xNZ2b/6v/tSGCXRmsMBH2enGSInQCcT0QRxE5?=
 =?iso-8859-1?Q?dBo0nsx9WApngjnnK4K9hZ9ZaR2Osv92ObgU0gYamCv18IFRgW8qXiUgoX?=
 =?iso-8859-1?Q?by3oDkBAl25tWxvuA7h0HmQCDyZK39QM4+BdtHUGim6eCjZ3XtTYYhBZ9Z?=
 =?iso-8859-1?Q?juHp7f4uJqArRfjy+6W0Ceo/Ej9B9lwZtxh2ENU2r2puMjNr9ODWuWH+40?=
 =?iso-8859-1?Q?GaZe0OSauQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a27826de-9c14-42b5-16d1-08de63b84e38
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2026 06:40:37.0064 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4FCMjDG67XblnZZpcdQL1GBKz/2OKbeqBYvpROhRiq5rRfY7RP5ZtMXhGtJ+BV5YMxaNLFqOVS0z+5c0kNf9PEgAL8RzsbQAKScaPx9d2do=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5901
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=kane_chen@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 04 Feb 2026 02:17:22 -0500
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

Connect the I2C controller to the AST1700 model by mapping its MMIO=0A=
region and wiring its interrupt line.=0A=
=0A=
Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>=0A=
---=0A=
 include/hw/arm/aspeed_ast1700.h |  2 ++=0A=
 include/hw/arm/aspeed_soc.h     |  2 ++=0A=
 hw/arm/aspeed_ast1700.c         | 19 ++++++++++++=0A=
 hw/arm/aspeed_ast27x0.c         | 51 +++++++++++++++++++++++++++++++--=0A=
 4 files changed, 71 insertions(+), 3 deletions(-)=0A=
=0A=
diff --git a/include/hw/arm/aspeed_ast1700.h b/include/hw/arm/aspeed_ast170=
0.h=0A=
index 63cfcb4c24..1005ce6364 100644=0A=
--- a/include/hw/arm/aspeed_ast1700.h=0A=
+++ b/include/hw/arm/aspeed_ast1700.h=0A=
@@ -12,6 +12,7 @@=0A=
 #include "hw/misc/aspeed_scu.h"=0A=
 #include "hw/adc/aspeed_adc.h"=0A=
 #include "hw/gpio/aspeed_gpio.h"=0A=
+#include "hw/i2c/aspeed_i2c.h"=0A=
 #include "hw/misc/aspeed_ltpi.h"=0A=
 #include "hw/ssi/aspeed_smc.h"=0A=
 #include "hw/char/serial-mm.h"=0A=
@@ -35,6 +36,7 @@ struct AspeedAST1700SoCState {=0A=
     AspeedADCState adc;=0A=
     AspeedSCUState scu;=0A=
     AspeedGPIOState gpio;=0A=
+    AspeedI2CState i2c;=0A=
 };=0A=
 =0A=
 #endif /* ASPEED_AST1700_H */=0A=
diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h=0A=
index b051d0eb3a..4ea2521041 100644=0A=
--- a/include/hw/arm/aspeed_soc.h=0A=
+++ b/include/hw/arm/aspeed_soc.h=0A=
@@ -290,6 +290,8 @@ enum {=0A=
     ASPEED_DEV_LTPI_CTRL2,=0A=
     ASPEED_DEV_LTPI_IO0,=0A=
     ASPEED_DEV_LTPI_IO1,=0A=
+    ASPEED_DEV_IOEXP0_I2C,=0A=
+    ASPEED_DEV_IOEXP1_I2C,=0A=
     ASPEED_DEV_IOEXP0_INTCIO,=0A=
     ASPEED_DEV_IOEXP1_INTCIO,=0A=
 };=0A=
diff --git a/hw/arm/aspeed_ast1700.c b/hw/arm/aspeed_ast1700.c=0A=
index 7efce450f6..e264b2200b 100644=0A=
--- a/hw/arm/aspeed_ast1700.c=0A=
+++ b/hw/arm/aspeed_ast1700.c=0A=
@@ -22,6 +22,7 @@ enum {=0A=
     ASPEED_AST1700_DEV_ADC,=0A=
     ASPEED_AST1700_DEV_SCU,=0A=
     ASPEED_AST1700_DEV_GPIO,=0A=
+    ASPEED_AST1700_DEV_I2C,=0A=
     ASPEED_AST1700_DEV_UART12,=0A=
     ASPEED_AST1700_DEV_LTPI_CTRL,=0A=
     ASPEED_AST1700_DEV_SPI0_MEM,=0A=
@@ -33,6 +34,7 @@ static const hwaddr aspeed_ast1700_io_memmap[] =3D {=0A=
     [ASPEED_AST1700_DEV_ADC]       =3D  0x00C00000,=0A=
     [ASPEED_AST1700_DEV_SCU]       =3D  0x00C02000,=0A=
     [ASPEED_AST1700_DEV_GPIO]      =3D  0x00C0B000,=0A=
+    [ASPEED_AST1700_DEV_I2C]       =3D  0x00C0F000,=0A=
     [ASPEED_AST1700_DEV_UART12]    =3D  0x00C33B00,=0A=
     [ASPEED_AST1700_DEV_LTPI_CTRL] =3D  0x00C34000,=0A=
     [ASPEED_AST1700_DEV_SPI0_MEM]  =3D  0x04000000,=0A=
@@ -113,6 +115,19 @@ static void aspeed_ast1700_realize(DeviceState *dev, E=
rror **errp)=0A=
                         aspeed_ast1700_io_memmap[ASPEED_AST1700_DEV_GPIO],=
=0A=
                         sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->gpio), 0=
));=0A=
 =0A=
+    /* I2C */=0A=
+    snprintf(dev_name, sizeof(dev_name), "ioexp%d", s->board_idx);=0A=
+    qdev_prop_set_string(DEVICE(&s->i2c), "bus-label", dev_name);=0A=
+=0A=
+    object_property_set_link(OBJECT(&s->i2c), "dram",=0A=
+                             OBJECT(s->dram_mr), errp);=0A=
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->i2c), errp)) {=0A=
+        return;=0A=
+    }=0A=
+    memory_region_add_subregion(&s->iomem,=0A=
+                        aspeed_ast1700_io_memmap[ASPEED_AST1700_DEV_I2C],=
=0A=
+                        sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->i2c), 0)=
);=0A=
+=0A=
     /* LTPI controller */=0A=
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->ltpi), errp)) {=0A=
         return;=0A=
@@ -146,6 +161,10 @@ static void aspeed_ast1700_instance_init(Object *obj)=
=0A=
     object_initialize_child(obj, "ioexp-gpio", &s->gpio,=0A=
                             "aspeed.gpio-ast2700");=0A=
 =0A=
+    /* I2C */=0A=
+    object_initialize_child(obj, "ioexp-i2c", &s->i2c,=0A=
+                            "aspeed.i2c-ast2700");=0A=
+=0A=
     /* LTPI controller */=0A=
     object_initialize_child(obj, "ltpi-ctrl",=0A=
                             &s->ltpi, TYPE_ASPEED_LTPI);=0A=
diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c=0A=
index cd4028fcd4..8242258df4 100644=0A=
--- a/hw/arm/aspeed_ast27x0.c=0A=
+++ b/hw/arm/aspeed_ast27x0.c=0A=
@@ -157,6 +157,8 @@ static const int aspeed_soc_ast2700a1_irqmap[] =3D {=0A=
     [ASPEED_DEV_EHCI4]     =3D 196,=0A=
     [ASPEED_DEV_PECI]      =3D 197,=0A=
     [ASPEED_DEV_SDHCI]     =3D 197,=0A=
+    [ASPEED_DEV_IOEXP0_I2C] =3D 198,=0A=
+    [ASPEED_DEV_IOEXP1_I2C] =3D 200,=0A=
 };=0A=
 =0A=
 /* GICINT 192 */=0A=
@@ -213,6 +215,18 @@ static const int ast2700_gic197_intcmap[] =3D {=0A=
     [ASPEED_DEV_PECI]      =3D 4,=0A=
 };=0A=
 =0A=
+/* Primary AST1700 Interrupts */=0A=
+/* A1: GICINT 198 */=0A=
+static const int ast2700_gic198_intcmap[] =3D {=0A=
+    [ASPEED_DEV_IOEXP0_I2C]       =3D 0, /* 0 - 15 */=0A=
+};=0A=
+=0A=
+/* Secondary AST1700 Interrupts */=0A=
+/* A1: GINTC 200 */=0A=
+static const int ast2700_gic200_intcmap[] =3D {=0A=
+    [ASPEED_DEV_IOEXP1_I2C]       =3D 0, /* 0 - 15 */=0A=
+};=0A=
+=0A=
 /* GICINT 192 ~ 201 */=0A=
 struct gic_intc_irq_info {=0A=
     int irq;=0A=
@@ -228,9 +242,9 @@ static const struct gic_intc_irq_info ast2700_gic_intcm=
ap[] =3D {=0A=
     {195, 1, 3, ast2700_gic195_intcmap},=0A=
     {196, 1, 4, ast2700_gic196_intcmap},=0A=
     {197, 1, 5, ast2700_gic197_intcmap},=0A=
-    {198, 1, 6, NULL},=0A=
+    {198, 2, 0, ast2700_gic198_intcmap},=0A=
     {199, 1, 7, NULL},=0A=
-    {200, 1, 8, NULL},=0A=
+    {200, 3, 0, ast2700_gic200_intcmap},=0A=
     {201, 1, 9, NULL},=0A=
 };=0A=
 =0A=
@@ -263,14 +277,23 @@ static qemu_irq aspeed_soc_ast2700_get_irq_index(Aspe=
edSoCState *s, int dev,=0A=
     int or_idx;=0A=
     int idx;=0A=
     int i;=0A=
+    OrIRQState *porgates;=0A=
 =0A=
     for (i =3D 0; i < ARRAY_SIZE(ast2700_gic_intcmap); i++) {=0A=
         if (sc->irqmap[dev] =3D=3D ast2700_gic_intcmap[i].irq) {=0A=
             assert(ast2700_gic_intcmap[i].ptr);=0A=
             or_idx =3D ast2700_gic_intcmap[i].orgate_idx;=0A=
             idx =3D ast2700_gic_intcmap[i].intc_idx;=0A=
-            return qdev_get_gpio_in(DEVICE(&a->intc[idx].orgates[or_idx]),=
=0A=
+            if (idx < ASPEED_INTC_NUM) {=0A=
+                porgates =3D &a->intc[idx].orgates[or_idx];=0A=
+                return qdev_get_gpio_in(DEVICE(porgates),=0A=
+                                    ast2700_gic_intcmap[i].ptr[dev] + inde=
x);=0A=
+            } else {=0A=
+                idx -=3D ASPEED_INTC_NUM;=0A=
+                porgates =3D &a->intcioexp[idx].orgates[or_idx];=0A=
+                return qdev_get_gpio_in(DEVICE(porgates),=0A=
                                     ast2700_gic_intcmap[i].ptr[dev] + inde=
x);=0A=
+            }=0A=
         }=0A=
     }=0A=
 =0A=
@@ -1025,6 +1048,8 @@ static void aspeed_soc_ast2700_realize(DeviceState *d=
ev, Error **errp)=0A=
 =0A=
     /* IO Expander */=0A=
     for (i =3D 0; i < sc->ioexp_num; i++) {=0A=
+        AspeedI2CClass *i2c_ctl;=0A=
+=0A=
         qdev_prop_set_uint8(DEVICE(&s->ioexp[i]), "board-idx", i);=0A=
         object_property_set_link(OBJECT(&s->ioexp[i]), "dram",=0A=
                                  OBJECT(s->dram_mr), &error_abort);=0A=
@@ -1057,6 +1082,26 @@ static void aspeed_soc_ast2700_realize(DeviceState *=
dev, Error **errp)=0A=
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->ioexp[i].gpio), 0,=0A=
                            aspeed_soc_ast2700_get_irq(s, ASPEED_DEV_GPIO))=
;=0A=
 =0A=
+        /* I2C */=0A=
+        i2c_ctl =3D ASPEED_I2C_GET_CLASS(&s->ioexp[i].i2c);=0A=
+        for (int j =3D 0; j < i2c_ctl->num_busses; j++) {=0A=
+            /*=0A=
+             * For I2C on AST1700:=0A=
+             * I2C bus interrupts are connected to the OR gate from bit 0 =
to bit=0A=
+             * 15, and the OR gate output pin is connected to the input pi=
n of=0A=
+             * GICINT192 of IO expander Interrupt controller (INTC2/3). Th=
en,=0A=
+             * the output pin is connected to the INTC (CPU Die) input pin=
, and=0A=
+             * its output pin is connected to the GIC.=0A=
+             *=0A=
+             * I2C bus 0 is connected to the OR gate at bit 0.=0A=
+             * I2C bus 15 is connected to the OR gate at bit 15.=0A=
+             */=0A=
+            irq =3D aspeed_soc_ast2700_get_irq_index(s,=0A=
+                                                   ASPEED_DEV_IOEXP0_I2C +=
 i,=0A=
+                                                   j);=0A=
+            sysbus_connect_irq(SYS_BUS_DEVICE(&s->ioexp[i].i2c.busses[j]),=
=0A=
+                               0, irq);=0A=
+        }=0A=
     }=0A=
 =0A=
     aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->dpmcu),=0A=
-- =0A=
2.43.0=0A=

