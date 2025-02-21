Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0055C021AA
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 08:08:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlO4a-0004a9-Op; Fri, 21 Feb 2025 03:07:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tlO4Z-0004Zq-Lq
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 03:07:47 -0500
Received: from smarthost1.eviden.com ([80.78.11.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tlO4W-0005j1-8g
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 03:07:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1740125264; x=1771661264;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=jQBJo+yodEbohtpqnyWk2sHs6jgPdWVxFPw+yZeCewM=;
 b=DHM7chZ5JfqoXHNaBX4SXgBf+KBEfIJaHX3lZGRtY0Kqw+Iim5ELF0dy
 iqY0fp94qK4t7MDLe7mpRmrSJoBwd9exqGJ6wK+KeFTWcDL81AOKhAWi0
 Em4VKES4Fcj00sgUeHCxCZE6G+szn04Ef0DszZtMKHaO8kR1czZVF4/XP
 SyogS5o8BRxtsvH/KA/szFD9WPoxY5erHjSbzSQx+3qL280C0YiR57GJk
 B3XO/iwxJTMXvgNPPUMhKoVhPGKmwG7+nkl7luxYngrbLYfmWzDMfP/d1
 X0q5Yf6PPWL3ORFKBeSkJoQkZVycXP6WOQbXYFN6bFbYvI9ILQSFlVEvm A==;
X-CSE-ConnectionGUID: dgkE/Qh0R7OR9c1FMiCtUQ==
X-CSE-MsgGUID: zytwl0OpTE6oCBD05NxAQQ==
X-IronPort-AV: E=Sophos;i="6.13,304,1732575600"; d="scan'208";a="31394138"
X-MGA-submission: =?us-ascii?q?MDEFDkH2bT6SarVQZ+WBcdNP97hKHLrditVSx4?=
 =?us-ascii?q?H6/J2ZcdeIiQJ8DnDl08M+ds4X0xNvg3E365DzJfWPdvBYw8IlT9m1Hk?=
 =?us-ascii?q?8IwzJoSkHZcSS+DHauiEftGvftV0sn63gTnw8MGUFTNNpXR0EdDQBan9?=
 =?us-ascii?q?3JpBTl3au/1uKl3ivS1UqorQ=3D=3D?=
Received: from mail-vi1eur05lp2170.outbound.protection.outlook.com (HELO
 EUR05-VI1-obe.outbound.protection.outlook.com) ([104.47.17.170])
 by smarthost1.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 21 Feb 2025 09:07:43 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RjvQD4lKerZxMPLZFw1FF2a634B4bZy13kA0kT/wmm0ZBJJ0H3pislgW3/2uFRCFcgpzDZ0LuHT6XuSBnXoz5nzn6v4uc2x5Mx4cO6RpjwedwwFYvjSKfVUv2DkQcktWX3As3jj166mWGwgxmhmoLzZAvfbKHGqcOsyYfrPUEtL6ENPzaT1hkNcwEU6cuRlbSe9QQBfEPlbPAkPWb5V4jfYSvCEdKWE6S6GYTt6Ecq9Ff8rJgvS8wwRFpL2odootWvubBQmZ9VaUbPBsI9a4QRVwiVvT1OkfMJBj1HTd7yn1KKm50wpTZZSanjvfPZAASDUIHbiSoQ6rk4P5H5Wmwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tEwTGR66dPbEcMAYnzlzJKlqMePdzrFYyuhV0CQRePs=;
 b=imXAl70k4qXKyzgoLFf5H8xsvxv7FnFn2ukXwKZQnKg2jxmYaGUKVD2EiytaA5Zb7AbUMQ80hZmACEIupiXe+ilra5hqTQWKJv+iZ3m0GWy1JTYsdPHCCZzKWqXSQCg/Nztu+DCAirH3pRykTLfljy1pfG4Jy5/lNzYYYo5jnY/cZ21mGbUT+BjUXZvrp7pbsAHQaMDnEtbPb/y0agCQcW4WCbbR0KYj6EdVTNhBdJpqeZn98VK4lzZWafmlN2O2XvDfE/Ff4fwEt1RtH5RUR+ofQeLvAHTAkHuH4uXXg1kQARcAVQssvoE2nPY2E0eMLzXVd97GfsrmZAWKKBqFPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tEwTGR66dPbEcMAYnzlzJKlqMePdzrFYyuhV0CQRePs=;
 b=H5lqou58CEkFWEGC/sVE/I1f72O4+kMC8tBG2oIEYJ+Kwr1GEyuYAzOgaP/PyEwQCIRUX6ukBYgb6VnUqfIrnUA5RbjN6yH2K0Arys8NIXCB4I/aUbRAZ7ZPUhjTzyYt0FN9e9EVz45BpN/wPJQSuu18LucbWt5bWwGQKclRajl1jeQVI+d1HQ4BEFTUG9fusi68Dxe1mh7p+Pw+oVQRAd+Z3Wk2a34awwTmNc9p7MfAzWyfHHd4kPvTF4U6+t4kdmyxq06L30baRKrahsBfUwGnUvzFYBQciU3k6PzNORfvWuQKDA6g7btiYMNmBwIf1R9GAb7wHpaLtpbOUeUDnQ==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by DB8PR07MB6459.eurprd07.prod.outlook.com (2603:10a6:10:142::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Fri, 21 Feb
 2025 08:07:41 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%7]) with mapi id 15.20.8445.017; Fri, 21 Feb 2025
 08:07:39 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "tjeznach@rivosinc.com"
 <tjeznach@rivosinc.com>, "minwoo.im@samsung.com" <minwoo.im@samsung.com>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH v3 13/19] atc: Generic ATC that can be used by PCIe devices
 that support SVM
Thread-Topic: [PATCH v3 13/19] atc: Generic ATC that can be used by PCIe
 devices that support SVM
Thread-Index: AQHbhDetZKXTRy7Vike9FBTg/yfIrw==
Date: Fri, 21 Feb 2025 08:07:39 +0000
Message-ID: <20250221080331.186285-14-clement.mathieu--drif@eviden.com>
References: <20250221080331.186285-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20250221080331.186285-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|DB8PR07MB6459:EE_
x-ms-office365-filtering-correlation-id: b7e971e6-edeb-4ecc-ae1a-08dd524ecf89
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|38070700018|13003099007; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?giXOulIDIkhiWb1TO7h5XMSGS5xgT77DwMKokM/vZ4pvIj5KYqx+HtRoc2?=
 =?iso-8859-1?Q?Po+W59L8CZKzMU3TxgPLfxJVgOPWaCYQuekB0xYMc/3S/mQBGSve1jqaDs?=
 =?iso-8859-1?Q?HjnyzZe7Q+SBMJF0JBtTCRnQefPNoeogb2Ey/PhJuFemUaHZgqkXkji/HP?=
 =?iso-8859-1?Q?Hj9DMOvEalCZ+dwKB52mrtxjOVxVaQfZX3QcgLZ5yX8yc9vGwV9Okcsycz?=
 =?iso-8859-1?Q?K4/FmWo/3CVK41pWZElB/Gk4N45iDBZKjk6PyEi9xXmfnRms0136soBJzS?=
 =?iso-8859-1?Q?7i40NwTJj4Q0q8joX9lcn7MEQIBawOaRmuid461QhsBD2Gk6IZ2MkTNwBA?=
 =?iso-8859-1?Q?qn9T+9EY2RxX7uWWffZXzTD4mAYNx6Ti1R4KVZ1WaI8AcTmvPz0C0vU1Rt?=
 =?iso-8859-1?Q?bjkD5PWFhD3MdEzlySNARtbB2WjRZqNEslTMdDzgkMoxWPW+2KfGcRxq9g?=
 =?iso-8859-1?Q?7Iuos9qEfLQ159sEGhRgIF3lAogziBUbnjbQwTkG1wdI7ZszxfanR5JKd2?=
 =?iso-8859-1?Q?kbybzo1H2pgLEid28CQ9NQA8KzLaNRRXgXso2lz5byEJjb77jvql1Yt5Jw?=
 =?iso-8859-1?Q?DYkLSA2OtEJRpIZu0sQki5rYxpf8gz9RifJLClrE0AfXAYua0kVbkN/252?=
 =?iso-8859-1?Q?ABXlhhGswfl4WnnhTbTIDNCaKT2CdE0lFU0WCHR89SdSPebmjsfYEPdx9H?=
 =?iso-8859-1?Q?BHABqju27TSoP8oUuIHvYBi5Jyi2SfqFZFdmJk1Wa1R+/mB+RYqC9l/0uJ?=
 =?iso-8859-1?Q?7AZssLl416I8GGeunTqAjCH/9/VSr9q2TABFOUBtTOhY0bO/YyrnGnyPKq?=
 =?iso-8859-1?Q?6jc6GFPkPimN/X8R7if9pK7d+JmUtoWwQdjOhFtmYsYRtP9Ba2VIFWxFFv?=
 =?iso-8859-1?Q?PllBMzW/jfsoWfE68ZTj/1bMCzWa+5U2hsG9Tnge2AONNmIQ8AGJZgo8GM?=
 =?iso-8859-1?Q?EMVD9x0TGZWv8Leymz73fXbDoSooFMxj69Y01O5FgfMwaQHI1LTdDdP3+X?=
 =?iso-8859-1?Q?Uv2SVFACm6gbZRLcboP6/qwRhphyj9jHn9ZZzNNVmzJoKV/f5vFtcCWrp+?=
 =?iso-8859-1?Q?Hf3jcZev3EMHzkLUrZXW5Wga/VaxmWa1iyukshPDnoWPxdDoXiDUqkIoJn?=
 =?iso-8859-1?Q?NALytA3KDtH6yEKOZ4ujOkAAWHSb6jx8B7Xfc5NkErsa6wyr4HmWq4dQ0W?=
 =?iso-8859-1?Q?ytcWBOmU8VkqGlIZtgUfOjeKGQdiWpu+oXx6iQnaxhnOvAZNcV6ARCcD0f?=
 =?iso-8859-1?Q?QH90TATr9QVU8+76hNCPDFhB7Le7w/W6WR39LrCKaz6AoHHIA+82O3DL1r?=
 =?iso-8859-1?Q?fMW9vZR9F5UFeB5ZtQ9Xv01/3AaFLevcEuIt9/TdhaUzQ4MgMr3WPKqdKF?=
 =?iso-8859-1?Q?HxRmqrbDgbVF+n019DT94dQo+pansxdCGRDoRELTPqOOdFkSsAblcIMwqF?=
 =?iso-8859-1?Q?+OS6WIByX3kOFLBLhKs7NEQR/tFhCvsaK/IXCQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018)(13003099007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?0Ppy/qKlNch6pqmppkEpbHIRehHUUthYAzmJXMtipEg1XhlST11/3Ikmgd?=
 =?iso-8859-1?Q?Oc6IssP7GhYQX8i4nwUl/gb4vu11WnqtEy/d0tpG38vMM0UhSfyN19419W?=
 =?iso-8859-1?Q?4PcBdFZIB2ZRVirdLwDGn9R30yz80pcPY0KXEzCZFQ7TUgZb4PcneW5Z0X?=
 =?iso-8859-1?Q?x09pNFuqg51wgYfoOty9WqMHYHvJiv8EvYS5lpZZPtiNRQlRUJNaXfkfnc?=
 =?iso-8859-1?Q?muczN9PIYwYTl4F/S0OyVzo3hOPXjW9kVQm3Vp6blaAtcybBIYyuTzk7Un?=
 =?iso-8859-1?Q?WR9iq/WmQEpyAqaZrmVtO30p7A79z7/5XaAXwDwPloLYre0b9AM2b1UNnF?=
 =?iso-8859-1?Q?1bEPMrpujcV4D/4KeZp8mmxL0qVG5ELFiHo6Q86V/PawT7cXr8KoECoFlD?=
 =?iso-8859-1?Q?RAXyZpvDltbq1YKcmGp64eYpDuZZSvcZer8QFDjKKzb1yIfcJbB8jd9c+4?=
 =?iso-8859-1?Q?PyqsGnAZ7qQEWJaN6+Bs2t7kB8KRslc97CHeS8/6Tpi3G4iX/bkC0cp6VK?=
 =?iso-8859-1?Q?Eya7rP5kZ9DtR5rvTOYaDUwzjZhYgd5eM3gqK6GNxnmle+nBY3pXBrA0K0?=
 =?iso-8859-1?Q?wyucfunsDlg6brZBAB5nkL3iASJmrD3Oi1vggmQoyzxo2fAYIVljo/xE+q?=
 =?iso-8859-1?Q?pkUAmsWhaGH/m0BKf9U+lop0pP1yxrfZFhkHpSZgBoQ1lPIfVu6GXMkEWH?=
 =?iso-8859-1?Q?sSQR+UC2ZyOKeTkjQkLKYOwIqaxDR9G4BzKoopqesG14ihZm4hAlqggdoq?=
 =?iso-8859-1?Q?eLN5HEiNtqDVOvgSW7lCHaHX/b0ELkUwmuLJc0nmlO1pMONCK2GHmVXD9t?=
 =?iso-8859-1?Q?41d8pVjawZLcExfIAZNMtDmBBGzQgOGKhF8TUk0xFTL8cpB6tReNdL965k?=
 =?iso-8859-1?Q?625JJ9TQkKpR7nkKNcFw3BC641cqlU00J4tJ6K7o9KBTnO15YkQAoWeUl0?=
 =?iso-8859-1?Q?u+di0V6S7317DHaQ5peCI1PZYst4B98gpPvX5nmNthMxWOnpbmd5FPSIS3?=
 =?iso-8859-1?Q?4IOaXj6Lg4hZxqO/DBMhMaB3GQ8BIuWxVLy8tUgTdV+c80OeFv7bDi/q1G?=
 =?iso-8859-1?Q?Tbc624a2fZDLNoZoiYdoyiIOzLfewvZsrhazWJzz2fFwSRAfd2gqJbo65k?=
 =?iso-8859-1?Q?Z1OhE168lHwda4XkNi6Kk99AqW6foBAvFISNTrZBLBPgiRa8sKo0BWHBEm?=
 =?iso-8859-1?Q?4fZKTmyIAQ+NbS2A2TEdqWQ11/Xe0MG3bpSskQLOUh7pg69oHwf0A7jDoj?=
 =?iso-8859-1?Q?B0BTdzBwf5O8Gp5fWfeBURisJGfGEETLoKQ1XNh3by28ZLiV9KGpM2jPRC?=
 =?iso-8859-1?Q?sZAjv+20wmpNuCITD2uV2Bic9a1o05v4yyJqrRGxNkenx6hY9HMm3umsVH?=
 =?iso-8859-1?Q?wR/Pv/orP07D+5GUStSgQjSTP/wnC0vMD/LmoLxVt5g1Xa5KJaRb+guFBo?=
 =?iso-8859-1?Q?bZPV04fJT+ABCd6o/ecPjI66M/DfLcl0RRcygN3879qXWi2UJK2JlPdkB0?=
 =?iso-8859-1?Q?zp3evpLaIujLhKfCziHb4yNRowEvkOJ5ShReQNBy7RLpAEji067mSRrnC6?=
 =?iso-8859-1?Q?2uwjRc3QcqhGeGM2v0BMAJDX7bpavFfl2meXcn/CXxNyXFLt0GWY2Zaypa?=
 =?iso-8859-1?Q?DKeXtBtNnYsqK8RuLaHMPRvrGX1sXbvm636XcQv2mmAFxIneMilKMf1CQm?=
 =?iso-8859-1?Q?/W9ttDRV09d6aZ9EA+A=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7e971e6-edeb-4ecc-ae1a-08dd524ecf89
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2025 08:07:39.8773 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YD2wsi/mprUdWiv8+o24Rh8cJQS1dQLI6EfMhwv+Ti0zcVhaJvqeR5c5pm50KnJBQq8+yrTjwUJmxS1dfRet71Bl4ydZ30ZC4lIfEaIKuicNDd1X8u4AoepHD7vKZbwU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR07MB6459
Received-SPF: pass client-ip=80.78.11.82;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost1.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>

As the SVM-capable devices will need to cache translations, we provide
an first implementation.

This cache uses a two-level design based on hash tables.
The first level is indexed by a PASID and the second by a virtual addresse.

Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
---
 util/atc.c       | 211 +++++++++++++++++++++++++++++++++++++++++++++++
 util/atc.h       | 117 ++++++++++++++++++++++++++
 util/meson.build |   1 +
 3 files changed, 329 insertions(+)
 create mode 100644 util/atc.c
 create mode 100644 util/atc.h

diff --git a/util/atc.c b/util/atc.c
new file mode 100644
index 0000000000..584ce045db
--- /dev/null
+++ b/util/atc.c
@@ -0,0 +1,211 @@
+/*
+ * QEMU emulation of an ATC
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "util/atc.h"
+
+
+#define PAGE_TABLE_ENTRY_SIZE 8
+
+/* a pasid is hashed using the identity function */
+static guint atc_pasid_key_hash(gconstpointer v)
+{
+    return (guint)(uintptr_t)v; /* pasid */
+}
+
+/* pasid equality */
+static gboolean atc_pasid_key_equal(gconstpointer v1, gconstpointer v2)
+{
+    return v1 =3D=3D v2;
+}
+
+/* Hash function for IOTLB entries */
+static guint atc_addr_key_hash(gconstpointer v)
+{
+    hwaddr addr =3D (hwaddr)v;
+    return (guint)((addr >> 32) ^ (addr & 0xffffffffU));
+}
+
+/* Equality test for IOTLB entries */
+static gboolean atc_addr_key_equal(gconstpointer v1, gconstpointer v2)
+{
+    return (hwaddr)v1 =3D=3D (hwaddr)v2;
+}
+
+static void atc_address_space_free(void *as)
+{
+    g_hash_table_unref(as);
+}
+
+/* return log2(val), or UINT8_MAX if val is not a power of 2 */
+static uint8_t ilog2(uint64_t val)
+{
+    uint8_t result =3D 0;
+    while (val !=3D 1) {
+        if (val & 1) {
+            return UINT8_MAX;
+        }
+
+        val >>=3D 1;
+        result +=3D 1;
+    }
+    return result;
+}
+
+ATC *atc_new(uint64_t page_size, uint8_t address_width)
+{
+    ATC *atc;
+    uint8_t log_page_size =3D ilog2(page_size);
+    /* number of bits each used to store all the intermediate indexes */
+    uint64_t addr_lookup_indexes_size;
+
+    if (log_page_size =3D=3D UINT8_MAX) {
+        return NULL;
+    }
+    /*
+     * We only support page table entries of 8 (PAGE_TABLE_ENTRY_SIZE) byt=
es
+     * log2(page_size / 8) =3D log2(page_size) - 3
+     * is the level offset
+     */
+    if (log_page_size <=3D 3) {
+        return NULL;
+    }
+
+    atc =3D g_new0(ATC, 1);
+    atc->address_spaces =3D g_hash_table_new_full(atc_pasid_key_hash,
+                                                atc_pasid_key_equal,
+                                                NULL, atc_address_space_fr=
ee);
+    atc->level_offset =3D log_page_size - 3;
+    /* at this point, we know that page_size is a power of 2 */
+    atc->min_addr_mask =3D page_size - 1;
+    addr_lookup_indexes_size =3D address_width - log_page_size;
+    if ((addr_lookup_indexes_size % atc->level_offset) !=3D 0) {
+        goto error;
+    }
+    atc->levels =3D addr_lookup_indexes_size / atc->level_offset;
+    atc->page_size =3D page_size;
+    return atc;
+
+error:
+    g_free(atc);
+    return NULL;
+}
+
+static inline GHashTable *atc_get_address_space_cache(ATC *atc, uint32_t p=
asid)
+{
+    return g_hash_table_lookup(atc->address_spaces,
+                               (gconstpointer)(uintptr_t)pasid);
+}
+
+void atc_create_address_space_cache(ATC *atc, uint32_t pasid)
+{
+    GHashTable *as_cache;
+
+    as_cache =3D atc_get_address_space_cache(atc, pasid);
+    if (!as_cache) {
+        as_cache =3D g_hash_table_new_full(atc_addr_key_hash,
+                                         atc_addr_key_equal,
+                                         NULL, g_free);
+        g_hash_table_replace(atc->address_spaces,
+                             (gpointer)(uintptr_t)pasid, as_cache);
+    }
+}
+
+void atc_delete_address_space_cache(ATC *atc, uint32_t pasid)
+{
+    g_hash_table_remove(atc->address_spaces, (gpointer)(uintptr_t)pasid);
+}
+
+int atc_update(ATC *atc, IOMMUTLBEntry *entry)
+{
+    IOMMUTLBEntry *value;
+    GHashTable *as_cache =3D atc_get_address_space_cache(atc, entry->pasid=
);
+    if (!as_cache) {
+        return -ENODEV;
+    }
+    value =3D g_memdup2(entry, sizeof(*value));
+    g_hash_table_replace(as_cache, (gpointer)(entry->iova), value);
+    return 0;
+}
+
+IOMMUTLBEntry *atc_lookup(ATC *atc, uint32_t pasid, hwaddr addr)
+{
+    IOMMUTLBEntry *entry;
+    hwaddr mask =3D atc->min_addr_mask;
+    hwaddr key =3D addr & (~mask);
+    GHashTable *as_cache =3D atc_get_address_space_cache(atc, pasid);
+
+    if (!as_cache) {
+        return NULL;
+    }
+
+    /*
+     * Iterate over the possible page sizes and try to find a hit
+     */
+    for (uint8_t level =3D 0; level < atc->levels; ++level) {
+        entry =3D g_hash_table_lookup(as_cache, (gconstpointer)key);
+        if (entry && (mask =3D=3D entry->addr_mask)) {
+            return entry;
+        }
+        mask =3D (mask << atc->level_offset) | ((1 << atc->level_offset) -=
 1);
+        key =3D addr & (~mask);
+    }
+
+    return NULL;
+}
+
+static gboolean atc_invalidate_entry_predicate(gpointer key, gpointer valu=
e,
+                                               gpointer user_data)
+{
+    IOMMUTLBEntry *entry =3D (IOMMUTLBEntry *)value;
+    IOMMUTLBEntry *target =3D (IOMMUTLBEntry *)user_data;
+    hwaddr target_mask =3D ~target->addr_mask;
+    hwaddr entry_mask =3D ~entry->addr_mask;
+    return ((target->iova & target_mask) =3D=3D (entry->iova & target_mask=
)) ||
+           ((target->iova & entry_mask) =3D=3D (entry->iova & entry_mask))=
;
+}
+
+void atc_invalidate(ATC *atc, IOMMUTLBEntry *entry)
+{
+    GHashTable *as_cache =3D atc_get_address_space_cache(atc, entry->pasid=
);
+    if (!as_cache) {
+        return;
+    }
+    g_hash_table_foreach_remove(as_cache,
+                                atc_invalidate_entry_predicate,
+                                entry);
+}
+
+void atc_destroy(ATC *atc)
+{
+    g_hash_table_unref(atc->address_spaces);
+}
+
+size_t atc_get_max_number_of_pages(ATC *atc, hwaddr addr, size_t length)
+{
+    hwaddr page_mask =3D ~(atc->min_addr_mask);
+    size_t result =3D (length / atc->page_size);
+    if ((((addr & page_mask) + length - 1) & page_mask) !=3D
+        ((addr + length - 1) & page_mask)) {
+        result +=3D 1;
+    }
+    return result + (length % atc->page_size !=3D 0 ? 1 : 0);
+}
+
+void atc_reset(ATC *atc)
+{
+    g_hash_table_remove_all(atc->address_spaces);
+}
diff --git a/util/atc.h b/util/atc.h
new file mode 100644
index 0000000000..8be95f5cca
--- /dev/null
+++ b/util/atc.h
@@ -0,0 +1,117 @@
+/*
+ * QEMU emulation of an ATC
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef UTIL_ATC_H
+#define UTIL_ATC_H
+
+#include "qemu/osdep.h"
+#include "exec/memory.h"
+
+typedef struct ATC {
+    GHashTable *address_spaces; /* Key : pasid, value : GHashTable */
+    hwaddr min_addr_mask;
+    uint64_t page_size;
+    uint8_t levels;
+    uint8_t level_offset;
+} ATC;
+
+/*
+ * atc_new: Create an ATC.
+ *
+ * Return an ATC or NULL if the creation failed
+ *
+ * @page_size: #PCIDevice doing the memory access
+ * @address_width: width of the virtual addresses used by the IOMMU (in bi=
ts)
+ */
+ATC *atc_new(uint64_t page_size, uint8_t address_width);
+
+/*
+ * atc_update: Insert or update an entry in the cache
+ *
+ * Return 0 if the operation succeeds, a negative error code otherwise
+ *
+ * The insertion will fail if the address space associated with this pasid
+ * has not been created with atc_create_address_space_cache
+ *
+ * @atc: the ATC to update
+ * @entry: the tlb entry to insert into the cache
+ */
+int atc_update(ATC *atc, IOMMUTLBEntry *entry);
+
+/*
+ * atc_create_address_space_cache: delare a new address space
+ * identified by a PASID
+ *
+ * @atc: the ATC to update
+ * @pasid: the pasid of the address space to be created
+ */
+void atc_create_address_space_cache(ATC *atc, uint32_t pasid);
+
+/*
+ * atc_delete_address_space_cache: delete an address space
+ * identified by a PASID
+ *
+ * @atc: the ATC to update
+ * @pasid: the pasid of the address space to be deleted
+ */
+void atc_delete_address_space_cache(ATC *atc, uint32_t pasid);
+
+/*
+ * atc_lookup: query the cache in a given address space
+ *
+ * @atc: the ATC to query
+ * @pasid: the pasid of the address space to query
+ * @addr: the virtual address to translate
+ */
+IOMMUTLBEntry *atc_lookup(ATC *atc, uint32_t pasid, hwaddr addr);
+
+/*
+ * atc_invalidate: invalidate an entry in the cache
+ *
+ * @atc: the ATC to update
+ * @entry: the entry to invalidate
+ */
+void atc_invalidate(ATC *atc, IOMMUTLBEntry *entry);
+
+/*
+ * atc_destroy: delete an ATC
+ *
+ * @atc: the cache to be deleted
+ */
+void atc_destroy(ATC *atc);
+
+/*
+ * atc_get_max_number_of_pages: get the number of pages a memory operation
+ * will access if all the pages concerned have the minimum size.
+ *
+ * This function can be used to determine the size of the result array to =
be
+ * allocated when issuing an ATS request.
+ *
+ * @atc: the cache
+ * @addr: start address
+ * @length: number of bytes accessed from addr
+ */
+size_t atc_get_max_number_of_pages(ATC *atc, hwaddr addr, size_t length);
+
+/*
+ * atc_reset: invalidates all the entries stored in the ATC
+ *
+ * @atc: the cache
+ */
+void atc_reset(ATC *atc);
+
+#endif
diff --git a/util/meson.build b/util/meson.build
index 780b5977a8..5e175ca665 100644
--- a/util/meson.build
+++ b/util/meson.build
@@ -95,6 +95,7 @@ if have_block
   util_ss.add(files('hbitmap.c'))
   util_ss.add(files('hexdump.c'))
   util_ss.add(files('iova-tree.c'))
+  util_ss.add(files('atc.c'))
   util_ss.add(files('iov.c'))
   util_ss.add(files('nvdimm-utils.c'))
   util_ss.add(files('block-helpers.c'))
--=20
2.48.1

