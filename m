Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C886DC02181
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2025 17:45:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZvmi-0004ly-3J; Mon, 20 Jan 2025 12:42:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tZvmd-0004eS-6b
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 12:41:55 -0500
Received: from smarthost3.eviden.com ([80.78.11.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tZvma-0000Zj-Jk
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 12:41:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1737394912; x=1768930912;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=hQh6FTIQrfprwK9v9FBxCrr3B0CdVveiPcxr0eYnTMo=;
 b=J0HAyxI+OCGQF5bAxFyi+UICBIJlZZ1XV0ofHtSDDQrgrPphTZKciMes
 8Rbi4qMpMKKciq6xGNtm+1XttkmSNd+2gWeVi+nltrtdl9ig727B8IkiA
 HTPQ3V1meI/ni9yS8m/jJivSgU+hzHkYaOZiy/jg16vf701tYbwuETvyC
 8DTeQN+6P13ujxld/mDyizyp+KnzY/6VRjTILgC2uECl1Nm5Z5fhiFwo/
 TeL9lpeO6AvSmRQ1NxbIUZC76UmyyHLA2DKqFxrF9yo0XRroaBxeJOLpH
 AD+2Bk+mfbNO+7fwWAdYHH5XuvTcSv6ZXtMi+65rpMwrk7uYd3lB2dMmJ Q==;
X-CSE-ConnectionGUID: +e/PN2NpT3WdgcW6o0A1nQ==
X-CSE-MsgGUID: jdSn6SkAQ2aFZgmMGJkqrw==
X-IronPort-AV: E=Sophos;i="6.13,219,1732575600"; d="scan'208";a="29125398"
X-MGA-submission: =?us-ascii?q?MDHETIQ0OR06QgH1OdvMEK/9PDR6gHrflINlhF?=
 =?us-ascii?q?iiLlI8ZeLcVB6VFVJplMy6xMITbgWIqJHCPRJy8EK7mdIkxgSfdr1TAM?=
 =?us-ascii?q?/5pGVif0uau9fdtO9TE8fNfS/1zz3uvk0/+HrPsK696Pl2Y/q3IMAMPc?=
 =?us-ascii?q?rQ4m/rV3cBqoZkRWQHz1uOOQ=3D=3D?=
Received: from mail-db8eur05lp2109.outbound.protection.outlook.com (HELO
 EUR05-DB8-obe.outbound.protection.outlook.com) ([104.47.17.109])
 by smarthost3.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 20 Jan 2025 18:41:51 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZeJfSZeQOxGRIHA2got6yPUET/YL2mdQGUkzjqLelPi5PJljV2fS0pkRysUwFBDo3athzbNHdl/W+kgUYWkP9K73WdqPhxkfZoDKvmKsQlT3UkJ8DesW5/+RAT6uHv5uzw5EA+0vZ9RqcPjjsMksU5gkSPByWimiCPPAQyM5+XLsJ0/mcs0VQ1g5wLmWAbtKdWFd7h9Rt7mezSZx+ZbcPdlw7Z1f5nKCL7seTZxotX601+1+zDKTezVi6i+lkwQeSal6Urw775rOAHMSM7cosOr+koAADsInRHGuMYO0Erb+Nv9vJg3juU4RmcAX0Z9zJnELC7BnsT0KYM41n6MqIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DRkmyg8DSSLCXELD3gKcIdGkG14Pzetncm4+Qq9hxLE=;
 b=xE3bYw2w364jxlWfu8qzwx5OK4bdWUQ8/cuwSaMDHPhIurMvMPvN0+EwTcHNG9X5GeYruMtTgu7twnjNREX5BIAPLt2qvCJ8lGc7Bdq2gFTEg5/p9MSbmnHVYFdRZgyCL7bOFJSwaK0pDzSTvWy3u0f8gUFYHVtYvqcax38NEkLRkAQQX3AoiK2m30ldX4obnpwhnt9VyUpT4s9kZZ19D8nzPCnhksn9okUTIwAbgM6Rvw+rpJm0BzuIvfjqH0KuPbrlfkNsivSgQVqw+vdTKQu+3UpUBvLRR8w1GxbvF7fpUnV7etqkWpqbvrRzk5mdWEyPQWqNBybHwUEr2mz5cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DRkmyg8DSSLCXELD3gKcIdGkG14Pzetncm4+Qq9hxLE=;
 b=SJ75eVdktmFSFUlrE0P9KNo2HfTfCEVFzwVTFQCXYV7m+DWCK8Is1AHUKQVszXb4PW1vGMegYGqtuiADKKLDsXM+wk47JcOIZIjgEnCLIEn9Ny9TE1OTY2J6eKgcjwXlPr9QmXRUeu5Z243hR0rQ0e95iRily7QGKXEKrbfq77ytY5zgKg9bxTz+zoaPg8GnC3rhPdWPS4XUJPpMsQSAx3NUOnrpJXQPPotdK1PSEuoWX1+GL2Za94/3q9hCHxFjt5mKBYDkCDOZV9lHE4P1ilwrifPf0UI0TNBvD0N1Gdu9ISer/0o+hUkXcmLkMogbykOSZli7z1vW+Gf5U0qOLg==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by DBBPR07MB7548.eurprd07.prod.outlook.com (2603:10a6:10:1eb::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Mon, 20 Jan
 2025 17:41:50 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.8356.020; Mon, 20 Jan 2025
 17:41:50 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "tjeznach@rivosinc.com"
 <tjeznach@rivosinc.com>, "minwoo.im@samsung.com" <minwoo.im@samsung.com>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH v2 11/19] memory: Store user data pointer in the IOMMU
 notifiers
Thread-Topic: [PATCH v2 11/19] memory: Store user data pointer in the IOMMU
 notifiers
Thread-Index: AQHba2KVqTIM+q5C8EuMszYWE7oOGw==
Date: Mon, 20 Jan 2025 17:41:50 +0000
Message-ID: <20250120174033.308518-12-clement.mathieu--drif@eviden.com>
References: <20250120174033.308518-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20250120174033.308518-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|DBBPR07MB7548:EE_
x-ms-office365-filtering-correlation-id: 62a08ffa-e805-4657-9bfb-08dd3979b839
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?1+pDqtT8ocVl7dJqW5xgkqsncqLnWqpo6oketGveOyioepbcGiZmO0RW3W?=
 =?iso-8859-1?Q?iOZEDyAR3K0eJhOFzDGQm0GcBR7mWHdKhD92E0mkKqlRpfNDJ5dcAUq9e7?=
 =?iso-8859-1?Q?bKUym7OtdiRy+FREkK06E9UC+KwmUdNM0gfUHIyRrrezUrgG9hDjpeCvK+?=
 =?iso-8859-1?Q?ndRxwC1FRYVabTibFqoK22xJSH7Kjma/PxO3DB7wMKpTb3VwumvbucWqEJ?=
 =?iso-8859-1?Q?4UfjNkm2+rSQ97P8ZgR24CQ9KuGA/gdwX5UsIlCGVEQ8xq7WrIhscEZ2CX?=
 =?iso-8859-1?Q?7C3WnwtyEBrqPGBqVbvBBVxDH3Lzp/lzGdVm0VPjdRwaQ4O0OmJUvXFU/9?=
 =?iso-8859-1?Q?vb6JCu954CJidAV0YdiAFPdHt6vNFYnyq+aAYzzAvVncH4XnZf1YHLeCOp?=
 =?iso-8859-1?Q?dR84FKJcU6/2Un+pZEy6v+DEaHtUowGrefXoUvALuMZudUlseXdo7LsUOE?=
 =?iso-8859-1?Q?G1VeGywUL2U/Qh+mo0bmBZtzP1Wqu++hPotlsE6HATz/7hZfs6p7ESGRjJ?=
 =?iso-8859-1?Q?g1F0cjaQ8qyzREXCvIbj3E8DFvjw7QmoSx30RJWEj729wHdycomLQHtirN?=
 =?iso-8859-1?Q?3kpJcwGA2WZ3EvMLExovl9MTjeSr2ESrEDo8o1SWyCR3O8KNypkwrtVsTC?=
 =?iso-8859-1?Q?VtRNsZKnakh3dp9chHoQfV8jeUJHHrYYPHPZ9CUcZxqgzeoKqWfuCdtpUc?=
 =?iso-8859-1?Q?N78fjJ4CFyE9YDUFu2PwAKWTk4NsqCvnhz5H6VX5jDEEfaroFIS76K1zu3?=
 =?iso-8859-1?Q?FxSXnQVYDLq88Ix/j6OqSLpFzyhS6Tqz/6HeLEqbteoFkTwGsKg2hbMKte?=
 =?iso-8859-1?Q?ZSQgUKQv7tC13XydnpL+N5jo1ooTiTer2XBPxiaDbLgKwGhLEBnzUgK5/P?=
 =?iso-8859-1?Q?/lnMQGw9edCBnPfKVt1boRmis9jeUCOd7s95/xG03npz8edxkdHLoLZ0tx?=
 =?iso-8859-1?Q?bcZRBIOXcw9c+jax7rLjgCqYClPth3E2m3Mv8bE+Y0NxheCfY2rP7Clx9e?=
 =?iso-8859-1?Q?QIm1ig8vJWh8nrBOBgg70cjMO4wVq5eNPwTGB9woJAuEsAsfVBCwDy92z1?=
 =?iso-8859-1?Q?Upy9RVri8x5RRDbYXjs7oQemIWhX1ngXXV5vqD5Pk7vnY6KOLeTK3UKzA4?=
 =?iso-8859-1?Q?C0gyk7HsWgjEZZJgRUyqL929tajcA8gR9YEff4t7GAhZy9YukGG5LxjXFG?=
 =?iso-8859-1?Q?Ytir3d0tOYfDYmlNGFmzzTFd9uGaQCjh9A8eqWeAi2Oho30MWNlt7AyYC8?=
 =?iso-8859-1?Q?se6kIoPAyyqSHwmluKEYNnptefqO4uEMU7iBjXbz2HbCldKn83eqr/XrsQ?=
 =?iso-8859-1?Q?68D1ftFW8tjOcdtaK46HLnICrg/pUuTJDhrFJB+YPV7ASvW6NPdEJYXjc5?=
 =?iso-8859-1?Q?E20qoAXuDbhEdDYZ/ISF5yEZ8f1/a9GGsIMYGinfj0ceZwssDv+OUMsrF6?=
 =?iso-8859-1?Q?Y2WSHtJNNgY6eMj3eF0Jbk2Lol/xFjT1obc0HDvMG2+Sx1PORcOwWPLkSb?=
 =?iso-8859-1?Q?xzNzbQ0rDs4C8FdfIbbzsm?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?uLKfCXTZ3Udm8s9EaPm1JQUVqdiJM47UtngT2dke8XB0Vxjwap5s0O05oq?=
 =?iso-8859-1?Q?q4C4VgO4F7k1WGDOcWAGKZ0CHKm/230pT4GmagKxY+LNlHhkGVD8oZJchK?=
 =?iso-8859-1?Q?IYHaMikxkstlOyzb5TDn+ruG8VTOAppqC92zDmtWUPbksxf4uD5XWKTP9W?=
 =?iso-8859-1?Q?AwiyyYpxtEKXqHef8XBC8x59ypplEaKbAotZO2/QXmOlmfz1ayyQxLfT0m?=
 =?iso-8859-1?Q?21hkVzlCukFUn6xqhVWetBvlAt23AB5Smh/D8kCltiumPJRx6pYgxpvKV8?=
 =?iso-8859-1?Q?bM6ctuhB+BjOxr+XAxJxRbSVewcQYgAZlyrYGSWQ4AUdE3nX0qQRbhib6s?=
 =?iso-8859-1?Q?kDwev+ciRNnNhA0ZSIXUIK0tPhgytmiB5AVrKIX82nv+uP68S+puW/tGdb?=
 =?iso-8859-1?Q?xvE7bqizLyDaH0hvB/6dU619lmL390TATq2lv6oxpaUtFK6f8Y5eQ+n/tu?=
 =?iso-8859-1?Q?UpgijOC3EsW8ITlhkstvepUupsCN21ou1S+sHQZXG9GQU4LAWKDweQVpFd?=
 =?iso-8859-1?Q?AgG36Lgcyp2LOaVym7VJpEaODQBHfojFnazB/pUdvMcBRbxFoaaoTLChMh?=
 =?iso-8859-1?Q?gkLvbLboZXCbGCUIh3NB86XjmimpcFRbDxQkyjWbTMra972QjkFlpzmL9v?=
 =?iso-8859-1?Q?rPOJrOJO0gOaY3rsKsJvqWFLPt0+I9MvgQUTbe2CyKL7nHPaK/gBt8fskl?=
 =?iso-8859-1?Q?FHm33ateJzAGSzy93PCGfY2bsvlbL1uzROK5GbGnGdn5jrv/+LnMI3qE7y?=
 =?iso-8859-1?Q?Qc5ZRVXCgtwIGd3TVYepv5cX4TzvBdD3bAp8erIoLsn9ub1p6MFpkCr8rE?=
 =?iso-8859-1?Q?knOa1FgW2gXquMEPlxzDvRK0RSl7ae1Acqe6mGj2HvUvJtLrBCIj4wdG45?=
 =?iso-8859-1?Q?CgzgV3Uve1X8UQc4u1UnyKZOjS60+Yy4cA4aX2CDqX9wn67rJ8TnH08f+q?=
 =?iso-8859-1?Q?ri+5WTeWd/2smFyksEy8K71BlPgLrjPadAIIAFo6P2KopEd118VCnWnmO4?=
 =?iso-8859-1?Q?/GeKZwariDOHMb6INxn/B52wVNokVmQGSh73qlWsnE/T2Dxvf7bImChoxa?=
 =?iso-8859-1?Q?G1zX3yApx6ynCrPoZ0DpVvkrS2B7I2wQ51BitXugN9YSlpYTtCnuQLiYLi?=
 =?iso-8859-1?Q?MJK05Gg3B41e77XuNzyuFuSCSHqRjn5TzKpMhl8IqJURqYEub1ScyCNDNK?=
 =?iso-8859-1?Q?k0WLvggKfnHQrSSSoTV9opoOUjw8dxOcM3vqqa9Rxok8XA7BVRzuLPUJLV?=
 =?iso-8859-1?Q?pKLcyIeq28ye0my5fiB8gzvVO4twPW2k1fgr17obnLpzgcWGaT+LafG9fV?=
 =?iso-8859-1?Q?3HA8gJCoe4esuVLgkve38ODbS1+QdfkiGINUrPzZ3ZjzY5J4F+ExAZQGu2?=
 =?iso-8859-1?Q?Jua0g3J+szPMkgQAqC6Pn3YaKSkEB6RgwKkrS4GiK5nDeFnzTnskMfqenP?=
 =?iso-8859-1?Q?1bm2WGpt8C9tL1qP6St48cUWPP+mMB/yivMQLEd5YhYV00QovY4pKrm8jJ?=
 =?iso-8859-1?Q?8g1bxv7INVQB54UZaEOApw3y51giDCGq0QNG/FANsOPc5aX+Db1Kxuo4AO?=
 =?iso-8859-1?Q?+yIbKXihGXO8sBifG/3wiyEV/xA8SprcxEKfSjZj2Ta2K83nPBlgMjt39n?=
 =?iso-8859-1?Q?qegFEIWNqB95rlj1GupzYheluEeaRz1AVQnI/Pv275VdD0gPhZR6DH0q0a?=
 =?iso-8859-1?Q?pWtXjxDo7btKivbFSIQ=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62a08ffa-e805-4657-9bfb-08dd3979b839
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2025 17:41:50.0695 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: geo03uJhatMbehW1UZhchI2heV3y9qJVv1+YTkTffbUdlol3kN2hCO3+F3K6XADkCHmqAvAfFHiGJ8qnaKAYiIdA3xeBQzrKXJ3jLxgdNG5Q3QU14q06kOx+1fFAy1ft
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR07MB7548
Received-SPF: pass client-ip=80.78.11.84;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost3.eviden.com
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

From: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>

This will help developers of svm devices to track a state

Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
---
 include/exec/memory.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 9889b97abb..468b003bf1 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -204,6 +204,7 @@ struct IOMMUNotifier {
     hwaddr start;
     hwaddr end;
     int iommu_idx;
+    void *opaque;
     QLIST_ENTRY(IOMMUNotifier) node;
 };
 typedef struct IOMMUNotifier IOMMUNotifier;
--=20
2.47.1

