Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6981DC021B3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 08:08:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlO4S-0004W7-MR; Fri, 21 Feb 2025 03:07:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tlO4Q-0004Se-5A
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 03:07:38 -0500
Received: from smarthost3.eviden.com ([80.78.11.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tlO4O-0005id-6n
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 03:07:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1740125256; x=1771661256;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=gmC1JlYF6t5JaGSPliSMZn93aRINn/nUgSe42q/FwD0=;
 b=rYlFWMgB5qmS2WUavPp75Io+3+aMMP8YOwR3HbwtgkJmhgBbd51byZLO
 zPjkBGg/tk5S+Y8eJiGYZQaJhIv7D1ETLfBiVpMAAw2ORrhg3Ibl6JeAJ
 MUv6SNyZFgjVlOX870HJzWofClpoM+RYINl88B9CXSyF/heaJlnVBTryq
 Ekzu/D9Tzn++xTD3VmaYSu0ujYhQM7SP2Ng7NIeVDulQ2s9j0LyHNdpFL
 xecA9SRjsSiD1HevVCY2FcxwouWAXeybv7/LJxx6t2UbwFSbn4ODGfHWE
 ezD6Ev40htm7HK6feMQpoPC9+aBy5DUwNNXfhr+PGxWlib9Od0EOTJYEu Q==;
X-CSE-ConnectionGUID: 4txGmODhQx2fhcY1SnuDCA==
X-CSE-MsgGUID: 08HDXLR5TESoRorwrfQBoA==
X-IronPort-AV: E=Sophos;i="6.13,304,1732575600"; d="scan'208";a="31385158"
X-MGA-submission: =?us-ascii?q?MDFnjdA5QK4FinHT+dJ0TXDot2pZWS26yN1Is9?=
 =?us-ascii?q?VqGSpVD45+kU1tGxomAzuJkBNcf8zFA5hSR73mPYH3zkGBO7XVrvM08z?=
 =?us-ascii?q?svkZ+gnQwAp/R7AxSHhcHfl7uUXQjriv+I44b7KpTl5Bog81+mCJHl2M?=
 =?us-ascii?q?OpUx6mehZijJsy/3gPFydKxA=3D=3D?=
Received: from mail-db8eur05lp2112.outbound.protection.outlook.com (HELO
 EUR05-DB8-obe.outbound.protection.outlook.com) ([104.47.17.112])
 by smarthost3.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 21 Feb 2025 09:07:35 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bneGwJ9RRmHhrLPwfAay1AOKyo2h36Exvb3AEkolRlWw723n6A6oytniiX4BXh8lhM0kiexXt7wtdWZwX/U/GS6YchYu+rAYgaa5jcqo3xo97R9oCQTTP0i2rEde2yRkESYJwhuMHnmKHdXyqp3Vhq30fxFd9jc3LLUiKy6/FXM2atOY4CSMC4EaWloD+404YUSxtEySRB1Kodp4/KbEhsaVkfqLTME5m9vGwUsjG5rGcFfhDPioPxx2mA3VDd0EPAfJ7twApVNrDoSDsnxOsXEo79Q0k0V0FaFQ4YZEy6rCfzHbCYqeIi7s+clx6aTURNXAkvd+UDyTXEunENyw0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JC5gvyzHnNALcmu6oa0dIRG6EFpxKL5QQ5nZEiae0zI=;
 b=Y6FWNBQf/fYJYqgyWdoHAdVeRMMYj/jquJxaUNtbMQ6EztRjXnHjbyA4ai4/BkujZpJu1EaRVtxBv+5AI7l2qmV/Uv3HfrFlxnDncDJSjXwVtJejTbA50y0F5bycJaEiYhmhtU9ssuCI+9P3kkuMSo3MZ/ubmttNgJXGVaEC0d/tcNYzgq6SdccN/arSHqYsXZjKv215uZ0SQaBijb8YwrRxwiEMaY2qlnG6xdJY8oGvVWtF8/vwCd14NJQahVwrk1FaPmhnAw8ZoEAAo+jg+5xf4rYZFIOgHM9H4/T+lxDBba7MPL2+V6eSvtl4E12Pzg0TMqi30F3pfZLbybdnUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JC5gvyzHnNALcmu6oa0dIRG6EFpxKL5QQ5nZEiae0zI=;
 b=jm8s94yB95fcqQwv4usH4qL2mFz1p4eZwFpoLI61HCGyC7KfMTm/0YYzGFq+WEbnJrUfFzYbn19uxf/luuSrSAjZpv2h/pQAkg39oBtOY43ymYKlrWqmTJw5X4b9D29ym8ZG1YJWRCSdPCcRWG+gCsA0Jw2nMB2eQXv1q5dEiBYpo9sJzryNgpgQcMIQLvALzW2N0kKMyHUUTh2soRMAobObTpbG2EsezwL5DdkN1QOzHjU7gfrxMADDD28RREpzKxFBC7OqxVSEwrL2gtfsd9zmEmzCAC9H5Q6sRkvu3PmlGkz6xULLrd/CAbLKR2vMgBj4Gi6IvRFJosDsFGWwSA==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by PR3PR07MB8162.eurprd07.prod.outlook.com (2603:10a6:102:175::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Fri, 21 Feb
 2025 08:07:33 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%7]) with mapi id 15.20.8445.017; Fri, 21 Feb 2025
 08:07:33 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "tjeznach@rivosinc.com"
 <tjeznach@rivosinc.com>, "minwoo.im@samsung.com" <minwoo.im@samsung.com>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH v3 05/19] pcie: Add helper to declare PASID capability for a
 pcie device
Thread-Topic: [PATCH v3 05/19] pcie: Add helper to declare PASID capability
 for a pcie device
Thread-Index: AQHbhDeps3ab2H4yXUuuV+QovT1t3Q==
Date: Fri, 21 Feb 2025 08:07:33 +0000
Message-ID: <20250221080331.186285-6-clement.mathieu--drif@eviden.com>
References: <20250221080331.186285-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20250221080331.186285-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|PR3PR07MB8162:EE_
x-ms-office365-filtering-correlation-id: 5a642110-4bab-47a6-8a97-08dd524ecbec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?MeDtEjZ/vAf+a+6ZVlzYYUW9/5rtTv0sF/l4xBdmWA7WyT5YEqZDQTk6ih?=
 =?iso-8859-1?Q?QcSleXF6rGAQNAI5G3QbsRVlWafsLsIKj6BY2NILEV+bCudGGWLxESBzKg?=
 =?iso-8859-1?Q?zsXGPX4sJ5unYp0WJfV6E4ftM8bfup6L7S5OkmIswvsEo6QyP5p4OrQq6S?=
 =?iso-8859-1?Q?xhdfwROF6aqMqQGFj7Q1lz419a49hWHEBiW9t09eKH2klymOKmjItAl4Ln?=
 =?iso-8859-1?Q?VKsBaHJuz2Kb/gnjaxARs6I94dIE+XPdmst88fE3+Qcu3/QPQBvcpdJFXc?=
 =?iso-8859-1?Q?rltezsnPWEY0XRV0Ig4TnAjoETOrdvTstsnUDSiGpxEI9ZCp5fIqDhvehz?=
 =?iso-8859-1?Q?WACg8u9HN4H7Irx7m6o88lnVgw0Z6KvPEwxMM0IgYT8C6evxSEL46FVzFm?=
 =?iso-8859-1?Q?ieBDqhh3XQE+RSI0Xj53UohW2b2Qy5YRbqBEc8REccUnLpOITSKEmA9KLD?=
 =?iso-8859-1?Q?Pq0H6MsWZEwfD99irrX/0aq7hv008lmRvWQaOLl9eeLCOP7Owe6tRGwIMp?=
 =?iso-8859-1?Q?RgOpIOPfityGCtYO4TflkS/KXIODsNbWtMHrWRsge7PBF8kDdlBxgwwQtJ?=
 =?iso-8859-1?Q?QZCLS/Jx5+uxnLtwXP3tRrl51nVvZQl1bqiBw9tos3y623e7dC81lCEXYB?=
 =?iso-8859-1?Q?NP3vo8+ofD9c0TXa5SxZVFK8IwVtt76TWYz7kPHLkxFJLYaihyCx26yy0o?=
 =?iso-8859-1?Q?KH8uMKyRqJz7GqJcWRKhIMyZtWAEa+9OMbg2q28A2lPp9zYWAWzx9rgYTH?=
 =?iso-8859-1?Q?esahhYwClB16SWbJ9fo3x2uj6Vw/uFeXAw+8TLTmIqwkHIW0u7mM3NW8Yw?=
 =?iso-8859-1?Q?0ejdZWxcuQVOd4BQPYr/X5uvAaYo4hYEYaZr908wEE+QByaeK1o4EYi8AM?=
 =?iso-8859-1?Q?YotJdCBRN52qzWizBwv/uVw7pX97RorhUsVqYfjN3eXZ6jYCtcVw5Jg/1N?=
 =?iso-8859-1?Q?JYxKdXoiabq8/k11nrJvjjwsfEfQAzulhEEAlsoYGxgI56IbnIpVUpHJ4m?=
 =?iso-8859-1?Q?hHAXEKovEi2JMJU6vMw5054REw299cGBG74bvj2ybcIP6dFV7E8jvapk2c?=
 =?iso-8859-1?Q?o3x8/zDVybEizxDg9vcC8dIjoSV+tHKrxPX46ElqyHQbomKpQxPzlQKqIa?=
 =?iso-8859-1?Q?tKo81JheSrKgn5A1uhzPHKKSxppGHCjnGrZy8rtATpJxIBMOtRFKUPjIjW?=
 =?iso-8859-1?Q?zsQve7fzs7lFA/PCh+NIH7sloT+UKr57mKPbgL6zzdyblFEdxaOG5QisCO?=
 =?iso-8859-1?Q?MykZH0qop2DWTpgafbXoetGetWX3GXraJa3coS9TXo+sdhTZRTrTz4MUYq?=
 =?iso-8859-1?Q?YAQpEvP/UkTg78xXT+ngQZkCkLdLH3sT3IUxvPLWfpDwGugJ6Exv8f1BHu?=
 =?iso-8859-1?Q?Og7AwwZ8NWSNOpfixeWV2+QPZ38Fe+JC8Pzy4s1xJwPXXRmJfeeZD/Plbr?=
 =?iso-8859-1?Q?TWBc/IQo1TyP2c81rZV/MTGzKlv+bizwGSoa9ltg7c2Z6yHtgkOk+Y5deE?=
 =?iso-8859-1?Q?50Q7mEItdobE3I7zl9ZQtl?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?qG4JyRY+VLtSThx9kAxQRXPzQRawykubTo0E50TVILTlbJcJ57CAeZyK35?=
 =?iso-8859-1?Q?UTDanZEE2P5Z8JGPyqOFo1s/vMx1dN3XVTH2SgMLlEHyaaj6+feNYzG0mh?=
 =?iso-8859-1?Q?PJRWpPo7ezVlqt5tpvj/8guoByRjY5qkjP0ygeFB2hE8KQHgYzcUlcRS7u?=
 =?iso-8859-1?Q?8qRUV94XoxRyvSr6STY4HAHuozMOPXZ6+Jm2MTDpcZDxusLhfFEnFRKkBd?=
 =?iso-8859-1?Q?UJ0n4TWdMlmRIMwh7rRJ5Xp4pe9/tnP45Gu/WqbL7adtHOcs/8maoex2Ew?=
 =?iso-8859-1?Q?cVuFN2jZj1aAyREwoCKEjVKs465IKMR/fuwzHrhSZ3nU6IieucVWf6c3Is?=
 =?iso-8859-1?Q?D/IJwO+IouXbKsd0E54PiYCx3m20lSuyDIFtTBBmcroBNmcHcEYLVENyBD?=
 =?iso-8859-1?Q?WMAAHTi2PyNkxaIyRo5XM2vB1a+77E6Vragq/vf/3XgttRoaOvR+tYGsRD?=
 =?iso-8859-1?Q?KT8wKUUB33Y8orR1FBDQx+8RUHeFMB9VToNzie8xl66k4P4X5b3D7VzQvK?=
 =?iso-8859-1?Q?kEgw6eRaJu5JmRD89iUgwbAkMhPEB/3V/8x5ydElTvoKDNotapxtF+rvzj?=
 =?iso-8859-1?Q?LszVa3VcXn2UcN6A9ZlxvT2HmPrZ2xI3aIvMECQ16p6Ame6vc4RqwM//8Q?=
 =?iso-8859-1?Q?bsI8T2LnqQbLjkmrAMOmF3SOsm7Sfy3ePuC6laVRtS5EcWihIbIm22t61Z?=
 =?iso-8859-1?Q?9pqgXV30nseeVBBmo6d0KTG1qTelUPW8KQxhyQ/Z41cKrs0CQ89skxQQwk?=
 =?iso-8859-1?Q?+OfcRJ+/Viz3AkVwTHou1uStntYSaTgXfK2JhggAV/Pko/Y62/wsc2wLRs?=
 =?iso-8859-1?Q?wXvWWRYGuk6ktUimGbiD2HiHoUqGCu6WzGq6RjU2pCXEgWQQzQVsMggBVQ?=
 =?iso-8859-1?Q?wlz4chNtIl+hTosi3adft3GxGNQtyLAIwAmi2nlcIh4RchRWHgQ3nAAvY3?=
 =?iso-8859-1?Q?v5ZBqcqIvesQPE5qUOI0zAFlra0/liqmM57kS8BeFCwTMKBUiGYMFZCWg6?=
 =?iso-8859-1?Q?SjCr1yxncfOYk51lCGSTNLwa/2Mb7JQBllrpYoNHaWpeENsDRqMELYy/Yh?=
 =?iso-8859-1?Q?ILZ0BcF35jbUZ9rE+GYOhyIUiVpvuF3N3Q6TbzXXS3qAKZV00o8jmQKD+E?=
 =?iso-8859-1?Q?h/Sv2R28ul7hACkdmCa60OzAR/ih3i1KpznakpDoLFULqriyzx59QXXYv7?=
 =?iso-8859-1?Q?+oLDSXamKnXhmZdzTyUlImgtSF4R8b4C/sKkreug1BXiTT2L5WY0suWLjp?=
 =?iso-8859-1?Q?6EeYgkfdJ3ZO52chLpIjf/zYj2PkGj0gEG2SC8Jv6YJd5+1jPdbiLdK6wg?=
 =?iso-8859-1?Q?+y/AE/j7X6MNg4xkNuv/Rbd5iZwV/vMLFs8ZAl0dpi9XHsFL/dxucYuy0T?=
 =?iso-8859-1?Q?s/lIPm01oOlXA5lNtU7vDje4hdw+m+NmIRq22tsN1oRW7GVA/hvRI6bohr?=
 =?iso-8859-1?Q?SLAF6y1msLOmcCnBUAp2Bsgtiaki9ex5w4r1kU/ycvr+MrtLvGhjmiOvqq?=
 =?iso-8859-1?Q?e2kXOl1x6yxEvEKgS/w4+X0tC17D4D40X9vL2r2meVkQFPzwMk2k72Jbp/?=
 =?iso-8859-1?Q?SOPp7UdsZol+4GurF6x7XPVhWqxmzvU7N8IzJxnfNHopJd+uSIIEtmg8r+?=
 =?iso-8859-1?Q?aU7uKuo8pkBofU7+GX0hNr3ZFoUNogDmZAuRZjAPN0OaggPEA8hePeQQRp?=
 =?iso-8859-1?Q?GEZHHSay4HFOOwoGRqE=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a642110-4bab-47a6-8a97-08dd524ecbec
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2025 08:07:33.8607 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XIvJYK08/Tjmve8hYTvymX8hJhJ3nHVvHS6Ywy5j/XEW87YUptlAWi0owrKeXF8SdTOU292aELsE0IaPjgAiIWSYwZIsOnJQ08H4JWvcKQvUNoVseeO4PGzrI8YblTZ4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR07MB8162
Received-SPF: pass client-ip=80.78.11.84;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost3.eviden.com
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

Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
---
 hw/pci/pcie.c              | 24 ++++++++++++++++++++++++
 include/hw/pci/pcie.h      |  6 +++++-
 include/hw/pci/pcie_regs.h |  5 +++++
 3 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index 1b12db6fa2..f42a256f15 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -1214,3 +1214,27 @@ void pcie_acs_reset(PCIDevice *dev)
         pci_set_word(dev->config + dev->exp.acs_cap + PCI_ACS_CTRL, 0);
     }
 }
+
+/* PASID */
+void pcie_pasid_init(PCIDevice *dev, uint16_t offset, uint8_t pasid_width,
+                     bool exec_perm, bool priv_mod)
+{
+    assert(pasid_width <=3D PCI_EXT_CAP_PASID_MAX_WIDTH);
+    static const uint16_t control_reg_rw_mask =3D 0x07;
+    uint16_t capability_reg =3D pasid_width;
+
+    pcie_add_capability(dev, PCI_EXT_CAP_ID_PASID, PCI_PASID_VER, offset,
+                        PCI_EXT_CAP_PASID_SIZEOF);
+
+    capability_reg <<=3D PCI_PASID_CAP_WIDTH_SHIFT;
+    capability_reg |=3D exec_perm ? PCI_PASID_CAP_EXEC : 0;
+    capability_reg |=3D priv_mod  ? PCI_PASID_CAP_PRIV : 0;
+    pci_set_word(dev->config + offset + PCI_PASID_CAP, capability_reg);
+
+    /* Everything is disabled by default */
+    pci_set_word(dev->config + offset + PCI_PASID_CTRL, 0);
+
+    pci_set_word(dev->wmask + offset + PCI_PASID_CTRL, control_reg_rw_mask=
);
+
+    dev->exp.pasid_cap =3D offset;
+}
diff --git a/include/hw/pci/pcie.h b/include/hw/pci/pcie.h
index b8d59732bc..aa040c3e97 100644
--- a/include/hw/pci/pcie.h
+++ b/include/hw/pci/pcie.h
@@ -72,8 +72,9 @@ struct PCIExpressDevice {
     uint16_t aer_cap;
     PCIEAERLog aer_log;
=20
-    /* Offset of ATS capability in config space */
+    /* Offset of ATS and PASID capabilities in config space */
     uint16_t ats_cap;
+    uint16_t pasid_cap;
=20
     /* ACS */
     uint16_t acs_cap;
@@ -152,4 +153,7 @@ void pcie_cap_slot_unplug_cb(HotplugHandler *hotplug_de=
v, DeviceState *dev,
                              Error **errp);
 void pcie_cap_slot_unplug_request_cb(HotplugHandler *hotplug_dev,
                                      DeviceState *dev, Error **errp);
+
+void pcie_pasid_init(PCIDevice *dev, uint16_t offset, uint8_t pasid_width,
+                     bool exec_perm, bool priv_mod);
 #endif /* QEMU_PCIE_H */
diff --git a/include/hw/pci/pcie_regs.h b/include/hw/pci/pcie_regs.h
index 9d3b6868dc..4d9cf4a29c 100644
--- a/include/hw/pci/pcie_regs.h
+++ b/include/hw/pci/pcie_regs.h
@@ -86,6 +86,11 @@ typedef enum PCIExpLinkWidth {
 #define PCI_ARI_VER                     1
 #define PCI_ARI_SIZEOF                  8
=20
+/* PASID */
+#define PCI_PASID_VER                   1
+#define PCI_EXT_CAP_PASID_MAX_WIDTH     20
+#define PCI_PASID_CAP_WIDTH_SHIFT       8
+
 /* AER */
 #define PCI_ERR_VER                     2
 #define PCI_ERR_SIZEOF                  0x48
--=20
2.48.1

