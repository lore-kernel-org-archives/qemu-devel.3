Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B074C7EE39
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Jun 2025 18:05:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uVZuN-0006FH-Ov; Sat, 28 Jun 2025 14:04:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1uVZuL-0006EI-Ua
 for qemu-devel@nongnu.org; Sat, 28 Jun 2025 14:04:09 -0400
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1uVZuK-0004AO-Ao
 for qemu-devel@nongnu.org; Sat, 28 Jun 2025 14:04:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1751133848; x=1782669848;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=LCynLE3owqTuRh9HpSF+sqcZ4KC4BNMaZmYJoWmq3ms=;
 b=krobPuKo3RuAeQgx0wrglfuIYHz6FYF8lE496FuKxkkCG0TtUWtViR7o
 xAxRF4f82qYH9HqKNy+c+jL+B+wzkxd6onwEYBBcYICk3i/9NJ6au5nkZ
 tSrXhtq+GRrN3wV9laB/ATAH4J8i+9lWa3wyqxzGGkOStp3n7n/OYsP7m
 Wu/c4RJLE7fh+r7IQSumvx638sWvhyoV9NolfSy6RdMf0CmAOUT+gfMee
 z6N5GBSJCo7oNV7eDZeyopFW3KZXi1dK0IMTdc2fEbsPmMNdCHCCCG04/
 GFM12iQQqq9q9h99DZOvXOY+Be5TTxUJeBmovwYgaqC9Odzq23lGbXDLP w==;
X-CSE-ConnectionGUID: Mz8JpbNDQUSRe42HtForLg==
X-CSE-MsgGUID: A3ep635cR9yCUBjAoDS+Wg==
X-IronPort-AV: E=Sophos;i="6.16,273,1744063200"; d="scan'208";a="41619951"
X-MGA-submission: =?us-ascii?q?MDHzUGSbh505AMkqYdYicLTD8YQfjAxT+780om?=
 =?us-ascii?q?tYGRmtEQPxERJ9zUqJPYMNaEf63zFCg9KKw9iWxhDroBpBDEQYWLVvUA?=
 =?us-ascii?q?iBukKcuwyzBgMM3IlNpNq0HS3dRj/+4NSf+bAIUsEO4WDfrcDvfGnWaH?=
 =?us-ascii?q?NIZFIdd06lqbfSnwybScWBTg=3D=3D?=
Received: from mail-francesouthazon11011056.outbound.protection.outlook.com
 (HELO MRWPR03CU001.outbound.protection.outlook.com) ([40.107.130.56])
 by smarthost4.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 28 Jun 2025 20:04:00 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ndj7aREsMWqkX6L4BPh08EUJyMbEHhMh5JfHBqKO2DS8k3Y2UR7ih4w+flY2/qRRU9fVREHPfDTTW/chQ0lffqppK1LKD+KTHs1s9Gd5ZwiCDJSJSgLV2ZSkV5EUy0PsN6KYNbJ/W10+0Rdn79q2V7amw/uxoMLmRJq3zNddIaVY51N0pgyidXUKygj5yPAXZdYn1bAD7jkhUO4f9BHbfjQN0m+lw+UlxhPck9sqC9uk6Gmqx2z9jTtBDMe+cls4Z8dIYhqRGm6XMp91XrDBHEhTSEzSH+0eti5ufnbbxicrBLnn5StStIb3PM4zygGg5L55YMxGua56o90BdjSG+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SeD9JTwd4ZQYtfnIkyfg9aiIV2cZso6od3fOyuA4iys=;
 b=ypB1HKn9hUWnHMAW3t+VEyb9JQdPU4iT79EihI3Abxhjhjcys5v6uCBC/8SJWvnrtnq4VGHtp07MdtSnecDZiXUxkdYwB4xPC9e8kNqOyDLIBDZqLdRxtyfv6r6OCnuUtcvs26X4jMjtK+HTL5eJdjk3PFkcxYDBVUKOOY2WhyhZk1wYwa7wuOpKFAKBUODAed7pXj954wAO2a47oP5qpUWOj8yz84H5yr9waLKQ9Z+CumZdEZMS9Sbb7BesbU6vx0nPBZICuQoJl3udJMjMsVyNUsdOpTf/SwZ78PT258a8avqc4AXboRaKhJvxtQJE9ZlXS2CsVOmGW89Zg+iUAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SeD9JTwd4ZQYtfnIkyfg9aiIV2cZso6od3fOyuA4iys=;
 b=mndQrCGlDYdFcTj7RFPCCHoxJvuIoFRfmMXvdcw7HE8avvwbe9NMFSnHP+W+NfPxNUyiNhdZ7oyAH9aMIhdh+fqEYVWmiGfVbc/CSIKRiqhnxcyq9W92+SnObtAQZzu+g7hfBW2IR7pChYk4/ZnNxq/swiihy14ELxf7ffVPZQNJ5ESzwcqoOcDnJxxozQ7sKuXuffJVXbW5BkZt95PvdY+7UvWHvTZXJDYq5x/AIaLFx278mXMX82rIVm6XNCXqNxrDOSXkl74Y5b/vvRkGPWMuXWxpyUPUjw9wjh4epJFQCdA4tF75iT6Dr7Crm4tzWgJrTTyBJ9IlR9vMvmdglQ==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by DB5PR07MB10238.eurprd07.prod.outlook.com (2603:10a6:10:5e6::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.17; Sat, 28 Jun
 2025 18:03:58 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%6]) with mapi id 15.20.8880.021; Sat, 28 Jun 2025
 18:03:58 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "david@redhat.com" <david@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, "kevin.tian@intel.com"
 <kevin.tian@intel.com>, "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "tjeznach@rivosinc.com" <tjeznach@rivosinc.com>, "minwoo.im@samsung.com"
 <minwoo.im@samsung.com>, Ethan MILON <ethan.milon@eviden.com>, CLEMENT
 MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH 01/10] pci: Add a memory attribute for pre-translated DMA
 operations
Thread-Topic: [PATCH 01/10] pci: Add a memory attribute for pre-translated DMA
 operations
Thread-Index: AQHb6FcFsyikman720eH+d1h7wlUDw==
Date: Sat, 28 Jun 2025 18:03:58 +0000
Message-ID: <20250628180226.133285-2-clement.mathieu--drif@eviden.com>
References: <20250628180226.133285-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20250628180226.133285-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|DB5PR07MB10238:EE_
x-ms-office365-filtering-correlation-id: 0cd0bcd8-a69c-48cf-6731-08ddb66e27c6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?CkxCLohqCh6USgVkkub8f8zCWBxQwv0CZ23mdzEDmJOY9dWQEV/Pfv1rFC?=
 =?iso-8859-1?Q?4h2eD+C1ub5/Z0qvTliCmrsNSU3FpTvye5V8+Cl8zUdl6Jw1LPEvfGuPHW?=
 =?iso-8859-1?Q?cPaxDvF3salOLJyDx0lZrDGmHPMgLA1XirGqMYKKh6hILzZImJKyJNakew?=
 =?iso-8859-1?Q?Rjs/uOGZBFVYiM5wefCWqVknY/zRHZOuhlFzScwjPHslXBLmFI2Glf57Pm?=
 =?iso-8859-1?Q?1DJ6P3w0dyUSmdBqvlKhvmlDRoBVU7QT7kr0i3CigrD/9NKUw24rx0MK8Q?=
 =?iso-8859-1?Q?CUyOIgdbS8UNRxb1QTbDEo7sgUp66ryiAo64jhHphCGDI9Uhj6D2EEZbJ6?=
 =?iso-8859-1?Q?ycEkl0EEgMa7zmAvSu+O+qXWDhajyMZYYIiGQv2C0M9FwWKwL3cyztqAMq?=
 =?iso-8859-1?Q?xXlC2SN2gMM2i+CnZ60e9on7G8wkrPqA0otAA3am9S7jWmmkQeI81p608j?=
 =?iso-8859-1?Q?x2d+s/670dDwGv3GkuM4RZwXdGZuRPiU7a4v3a0+Pjq5UVTfKvvNfWfTjc?=
 =?iso-8859-1?Q?RnO5RnKrzToYGxYhrZJwK2FbCeAO753WhpivB/d373TPyKMko4J9Mp56y4?=
 =?iso-8859-1?Q?3vK8hPJrwaJZnp3crKrJx1pLE+VTh5Hl7ozXBxvEmNEHcJiq/oAW7VGLAZ?=
 =?iso-8859-1?Q?u9tB7/wbldTx95K6dgS0FGmyk65BPlLXvQ0rJ5EBJZgYxTeYd4XTxzYxtf?=
 =?iso-8859-1?Q?p8NnS9V4H9wKKePN9fQ5k5YouPO0G2yIBv8hnLtcEAfo0AfcXJAEfkVcxZ?=
 =?iso-8859-1?Q?ZdVRLqqBfhgii5ckU07P8wgMwVuumUkRdp/Tsmr4itvC9GUHABXVG4/FtJ?=
 =?iso-8859-1?Q?9CaFCYTEW8nQqrcCkt2xUxMwiPCFTwm5Hbjj/bJJ6TcL5cW2+4CGSJUvMG?=
 =?iso-8859-1?Q?f1rcf6Up2PUy7VlXZXlQ7OIExI8h8OgRqBCOFM25swkDyQciyyqz+lWKg7?=
 =?iso-8859-1?Q?0+YmbmxvLjqKNc+udRWKIgu1PTz3nvcxfsEG1UeEI/N6XTTxyHroXlq+EO?=
 =?iso-8859-1?Q?yBnnMEnU9N8gHiCg/7mT5YQAWaVzDyjwMtKecWwNeH9Pzv2NvWM1RIiwb9?=
 =?iso-8859-1?Q?tDZcvkG7BlLqo41z25e5lRL/N761p84xasBWCl440gD6t4bvcD4gMFqrA1?=
 =?iso-8859-1?Q?JCHT8L0jqDB7zoQamPEUtoAHgu9gSWfRmMXzGOLl2x3aNwb2SaZmsSBtph?=
 =?iso-8859-1?Q?920l55bgI5oVl7kYpdqTcmkrt8nTxEfl6rqBCJjwLR4SbKNIsPqX9ttjL2?=
 =?iso-8859-1?Q?4NyHJ29uIVs5VZebCb1CgQgMs9VycolgyZDco3ZWSq1UPG96uGkkChAAUs?=
 =?iso-8859-1?Q?lW7vsQK2c0bR7lKGMz7nCuzkEYC6koALyVlwTbunPbm0RgvFmuDI3u03g2?=
 =?iso-8859-1?Q?t80GOommxJQzTtpzrToQLxvPk9e4ytXCWMnlIj1a6l1sQECwZRFqQ/gCyw?=
 =?iso-8859-1?Q?pjdhRtfu0PnwbXlfpiscn+JWQYLaAU+iNHpO4pZkDVNfDhvUreTkQ4zvm5?=
 =?iso-8859-1?Q?mbCXRwp9N5K+FIhKtr8PmRqXfHDdHa07hw1+8RQVA8mQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ifqxzzOeyN9odpw4Q9Y3kCmnfTN8tpHcho5ARMZ7ptnTFAIB1FSyu7OJKX?=
 =?iso-8859-1?Q?1c/zdXQTh4CaGh6h49Grt06goeAVzl9M0TipR+X+pm/4aiOSEvY4XO67uq?=
 =?iso-8859-1?Q?728LYtzx8T/U4cCcwQrSKKj+4Apg9uEoaFG4UXKyxA/ZGubO34NdElZEcj?=
 =?iso-8859-1?Q?G08RJ6Y/Gy5lEeQ1NWyjlNUkJMvX4nsWNj9nPWeGj6aYKBQaqvXbKGeGJX?=
 =?iso-8859-1?Q?/4J2IjRnpguEENv2NQaaJ9qxwvYkDnYlCbUpw2V9gU+N5YdqLVMttx9liG?=
 =?iso-8859-1?Q?jpv6sNkT8b1BIlHKavYA/vTW+p8w9b3otXETKeKVMq0OVbJ5Iu0OsYPtwU?=
 =?iso-8859-1?Q?XKjFmegHdx2zQ0t0qkXjNFgocZxniplfCX61oqLTqQ4/N5e+GXd7BkGu3g?=
 =?iso-8859-1?Q?gcdetwWAJTTzo3No0SEgLVY6AWYp4VjwawJyLC1xBgRcQTqH6ccuCzYbtg?=
 =?iso-8859-1?Q?8EmU4oFuUXVuNb0IoXnN9yr5M97Nfbnmfjc5Gm8RTUCWkp6JiU5WRpR8aP?=
 =?iso-8859-1?Q?kPl/QSV7PuXIs0FDspVWovt8hLy8gsuYIo+mk96XDs5iNcQ2BURS+2z24A?=
 =?iso-8859-1?Q?mJBBhQ4YcG/sCBPbQOwjl1IVrGtF/9JLvSLQlBfWZmyPyhnWNfDfnP4Lv+?=
 =?iso-8859-1?Q?NU//D06/a+W95tYBv1RX7khLC+cXrHWTpUQBtFy0oZbcXBPZ8I1XfLs+VF?=
 =?iso-8859-1?Q?69Zh5uF8Up82f/V2g2kLNJXx40ldUHnLjWR6tWanfVAX42qphkBS5NObCx?=
 =?iso-8859-1?Q?bHWD8JXcGD0Heqdgl59ReDzOghO8wMtoM4hGn11AjjXY6GyUYdCNJ9gbew?=
 =?iso-8859-1?Q?CpS+bildsFsoBFpdJf4zWTP78A43HMsa0PvvXpTKHhcPCMKB87xCdrQyTZ?=
 =?iso-8859-1?Q?7XucMeEs8d62uF86+6spOBvqskafPboK/XJFdLJy1OwvuHtZoGEaHHCT6+?=
 =?iso-8859-1?Q?65y0c98n3fQmmEYw/+PwkJuL2fgI9HUGEh0ywHDlIgnkVbnSJxROYJ7ef8?=
 =?iso-8859-1?Q?Yp4Rdf/K3bAbB9PsniM3sl5V3wOFzSRvuKKeUmFwsZvGDaTktr4Td8t2yE?=
 =?iso-8859-1?Q?8pgMCXBUvOMq6idm3Ghx5vWWax7FXVl2xbUY4NglDd5sQCPJQ2q9uRbZQ/?=
 =?iso-8859-1?Q?wzVlhV8sICcpkxSfhuR/NsjTju97xZMh8v+z2q9DB7NqxfDjmyTbZMURfQ?=
 =?iso-8859-1?Q?NyO/NM7v4p+Jf0Zau6Wy/i8kbh8mlMbeTEeXkyNrGvIKqRGye5EobX3Quj?=
 =?iso-8859-1?Q?v1bh5YcSkUlplm/oOJYByxXUMsKTnRORfi2XauW3ot0Lrvtxm3bi5W5Shl?=
 =?iso-8859-1?Q?ys+8SNaes5MTApWJQx/4klLRpezl9P0G9tv6k/+YPI8hpYvd7rda1nAU5y?=
 =?iso-8859-1?Q?tp1N8sdt68PCHGiGrFr6DZAwpTh4Nkt/hpiu6GnVuNoLCqz3whNA4LmhBo?=
 =?iso-8859-1?Q?LrTkwzagdxfkBYVvPul3bfAGrPdfOO4lWyqJQ6y2bRnTHZpThAolKD+LLX?=
 =?iso-8859-1?Q?eGBG1CmcPUscX0XYU2Nhm3vdQuMD3Vm33dSo3CO62qhUcf3QsxMZdksyzY?=
 =?iso-8859-1?Q?JDBy7twLhnVdRbLBIA+8Get5zm61Trywy6fsEIdvkVOZxRLYGX9CVOrHeT?=
 =?iso-8859-1?Q?J8Dq3CQzr9S3OsKO0A3wHbv8ha8FG4KStLLjmi38SIfEGBTlIuYMEWDEms?=
 =?iso-8859-1?Q?VPhFC7x5mLJ4vMZg2y4=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cd0bcd8-a69c-48cf-6731-08ddb66e27c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2025 18:03:58.6353 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FLhltLpVOCvAw9q+YhxQFktNTAO0dnlcFxwM+Croe1F8QZ9dF/NJPPtbda91clHSWxnwNToO9YXLyC/UexxCQyqCpbVBmeLyN0UPjw5kQjubnX4tFQYr6QcGlHeKXxjW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR07MB10238
Received-SPF: pass client-ip=80.78.11.85;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost4.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The address_type bit will be set to PCI_AT_TRANSLATED by devices that
use cached addresses obtained via ATS.

Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
---
 include/exec/memattrs.h | 3 +++
 include/hw/pci/pci.h    | 9 +++++++++
 2 files changed, 12 insertions(+)

diff --git a/include/exec/memattrs.h b/include/exec/memattrs.h
index 8db1d30464..52ee955249 100644
--- a/include/exec/memattrs.h
+++ b/include/exec/memattrs.h
@@ -54,6 +54,9 @@ typedef struct MemTxAttrs {
      */
     unsigned int pid:8;
=20
+    /* PCI - IOMMU operations, see PCIAddressType */
+    unsigned int address_type:1;
+
     /*
      * Bus masters which don't specify any attributes will get this
      * (via the MEMTXATTRS_UNSPECIFIED constant), so that we can
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index df3cc7b875..6b7d3ac8a3 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -134,6 +134,15 @@ struct PCIHostDeviceAddress {
     unsigned int function;
 };
=20
+/*
+ * Represents the Address Type (AT) field in a PCI request,
+ * see MemTxAttrs.address_type
+ */
+typedef enum PCIAddressType {
+    PCI_AT_UNTRANSLATED =3D 0, /* Default when no attribute is set */
+    PCI_AT_TRANSLATED =3D 1,
+} PCIAddressType;
+
 typedef void PCIConfigWriteFunc(PCIDevice *pci_dev,
                                 uint32_t address, uint32_t data, int len);
 typedef uint32_t PCIConfigReadFunc(PCIDevice *pci_dev,
--=20
2.49.0

