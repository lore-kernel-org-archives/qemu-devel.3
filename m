Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD165C02181
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2025 17:45:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZvmn-0004xr-3Y; Mon, 20 Jan 2025 12:42:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tZvmh-0004lo-Kr
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 12:42:00 -0500
Received: from smarthost1.eviden.com ([80.78.11.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tZvmf-0000ZN-Lw
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 12:41:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1737394917; x=1768930917;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=VkUj+54NCtH5EiY7JotF/jxihud84WCF7QG782cfgdo=;
 b=HyfUA3CEpB7VQu0JOGNS1/xIYiaanu+DDx7I1NVzjI/t19UvWzgB9PB8
 Fi3GeO+GQwllQ2ZXXr0SefZ50om5iW6fgwwPMjVWzD1vXaYmJL5P1sfVf
 L4Gs/0R/oSPPBt0mWr5OKDJU6jdNgv1VNqnvExsaaLRWq5qpYdPKHvK5r
 cc4mDy43KpQBJHU6XihDgQEzBx8J1h1vJQexBeiEFor6SDIypF0d65GrO
 g7CKAuWg6Ab/mZKpje9HHoAWqHVqA00rYT/V+e52diQ2HvQ+QlR3fxntg
 AprVEFGGkyd1t1ldjC4I5FnTp4hPymlSCovPcixe3LT2QV9iiEpmaGuKk Q==;
X-CSE-ConnectionGUID: rIhI/FHjR6aOsH01S5wdmw==
X-CSE-MsgGUID: ex30K8CyS5WpqYfYgjANfg==
X-IronPort-AV: E=Sophos;i="6.13,219,1732575600"; d="scan'208";a="29133405"
X-MGA-submission: =?us-ascii?q?MDGq8vuSmi7KJJX7wW65eeqoURloQ9jl4fbRL9?=
 =?us-ascii?q?CsNVOx5VTkBGHGXVwKKb+PdDNfcN+UXv+wTcZuhJNnBQ6CFbUylX46q5?=
 =?us-ascii?q?zKHNV4CLMwor9w7vwPROg3ogXtmXGiRxT6xZ9hXSrvieveNWfghZ4MCy?=
 =?us-ascii?q?TS+vcXBWY4JylEGP+3wdpUtA=3D=3D?=
Received: from mail-am6eur05lp2106.outbound.protection.outlook.com (HELO
 EUR05-AM6-obe.outbound.protection.outlook.com) ([104.47.18.106])
 by smarthost1.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 20 Jan 2025 18:41:56 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HKc/QEoEICjENmypBuAt92szpqHj4O3zUdLmhIcILAQXyE1s9jl3Ro4g4bs4vn0ycwXxN1ilNYAeHFQuRQlKMbOcT7FV+uXVc/PFQh2BLWvALsXmL2ncsJnJAuzoq04CCyBV4vT++4UaKzH1Q6/xVDD9AD5lzhrYwojgZEpVdtRa2bbJDEPoM4w5JrfQ42VQgADudF/RDaVPz5PQyI1bY5+yxW/PM/XobuC7840TNwxdMGHROQme+2Jvodxpa7fcVY7EzKJB6sLv0wJtBuxzBiztD01tgVTLX6Ho21HMYexAf8xY8fJzI6ZBPWehNqqbeEKZs7aOuLPM6CenEUQkOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4EcxnBTXM+1uBGS5IiYSPs5giNM7LLxywy9NilbCkXw=;
 b=A07019xee6maZbH6/hDbVMnmoALtMd537Zr5GK2kh0/oZHMG3fVYy2PVey5o19fp/+/MhVCcj6CGXuGS914w1BWvoNj5GhNTmb7LddTYaleKy4yrLkcdkBHj3B1/LZXcgP43FimSEyISsqNN7V8NZDR/PY5cUUelsBi9kBLcYJiPO35GiUZRi97Dn4V6ozlMlPT9aktMuOkAFcaNIdgXYuSwww1AbLKXNPvg60eOkR60JpBEjSnlQr7k4iPvY3ppaBqPdZjPaq/P9LgXKoDu38xmYw/GG/kHxBChcXtQmZVptGol+c0EpjZPJ45QtepXYb/ZsBmYi2H9h7fRc+DPOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4EcxnBTXM+1uBGS5IiYSPs5giNM7LLxywy9NilbCkXw=;
 b=aJpwMjzSQOIMWIgjtjvbBDde8aNl92GezXbzYXMbnXH/pt1HkWs4tQXf8PDH0Hqvmo9APpULmrDvJN+fWu2zsSjmzx97MpA1x3Y93ZRJ/fbpKjzLdEffgdYU8Jdho3Rt5IgkwQ+v5Qyvxr4zynYYRLvcmVt8/8eUI64jWLQMdadT+INhSkzKTjoGr5fQNotMOi7Rp8RAImxQ74YbxoiQI1r+WmlnP584zQD66BNHcMmswTYGq97XFkrvGqAi/bSWqS9zVkaxjM69qZbXsuSQtOD0ZMV7DnYtKQKCg1OumT0ZXCJCT7DcUnkXaoO6zRc8s1Dx2GNVv/cZ46sJebTwbA==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by DBBPR07MB7548.eurprd07.prod.outlook.com (2603:10a6:10:1eb::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Mon, 20 Jan
 2025 17:41:55 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.8356.020; Mon, 20 Jan 2025
 17:41:55 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "tjeznach@rivosinc.com"
 <tjeznach@rivosinc.com>, "minwoo.im@samsung.com" <minwoo.im@samsung.com>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH v2 16/19] pci: Add a pci-level API for ATS
Thread-Topic: [PATCH v2 16/19] pci: Add a pci-level API for ATS
Thread-Index: AQHba2KYPBDhY4wr0ECnIp+z7u6fAQ==
Date: Mon, 20 Jan 2025 17:41:54 +0000
Message-ID: <20250120174033.308518-17-clement.mathieu--drif@eviden.com>
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
x-ms-office365-filtering-correlation-id: 82870b5d-a64e-42d8-4f0d-08dd3979bb26
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|4022899009|1800799024|366016|7416014|376014|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?3izouj+kcvlpG9O7o4oHDo9063nM4TirdwysTJfss122GPHYmX9dkL3BFT?=
 =?iso-8859-1?Q?ynb/BlnW/r4nWdcLrsW2AEhJFBTWMcYY0uIOrEHPvqlvvuTUp7yHzoCL6H?=
 =?iso-8859-1?Q?Q9wCi21Ztk9Shp6V/HZP55DMB4JBBnju98sCsR6OFB/uNJ/S9jLk1tOEbb?=
 =?iso-8859-1?Q?mKWO4PevyWZEl4WMX0w/nFdctAPf5GS+ohbNubya/Q1OpGro9hIBjcLwVH?=
 =?iso-8859-1?Q?kA1LimLMI+UvmUF3b45QbFl2ZdWADBC8gn39ZPkcNAmjRrGgDf3YSg/zgH?=
 =?iso-8859-1?Q?UTMg0pRgX0E40yYNab2H0OJIWTV+NuOarxqCwX38v8be7ixmf29bU+NDVS?=
 =?iso-8859-1?Q?uYHbjGRxJ3LwphMJB30JycD5JpEHPjLyhMu8NNpz9YYMKlVEpBVphfmHNs?=
 =?iso-8859-1?Q?TPMuhpHWp4oRMj8Wtgn+XnIqG7v4DZMBOY+sXcKEm8azsoLgPQaYZ3LSNg?=
 =?iso-8859-1?Q?0QdsKj7UJR2L+ZbPw4nNZfWLOOWQdfnQI/qK2fPQkqESVdKpMCAYrL90Xq?=
 =?iso-8859-1?Q?6HsKR7pcpJBGu/38E5JecmJcrtULqY0WXXCa8sCZaA4vXPopLt5VfCZBv3?=
 =?iso-8859-1?Q?rtHPzzeobF98i7010YZNXs4NoDYKUjmNxWgMRxvJa29maN30dZ+TUPI8SG?=
 =?iso-8859-1?Q?Afc+kRU956vCYyyS6ZlHUROZr/52vop8i3zqK8V5RN/XowUOO+RWt5qGem?=
 =?iso-8859-1?Q?iv12jOH947CmJNpQ3FJRQrgUl2xDP9r721eZPY5RSBf+rR/mqlvM3eqZwe?=
 =?iso-8859-1?Q?cou7OaALquNqINAs32A487c23Wm8A8VLdqna05VNLKLHlOACmhHNGQMYye?=
 =?iso-8859-1?Q?ZjKelxoGndyP0zDGA28kW+tt6qfelBOFxa/iT4PAFnF05PZzu5pZgNNdYP?=
 =?iso-8859-1?Q?JZHe/8JLPf/h405rLeK0bV4EnlZyHZlMfxa8CJGaJMVTM7nYgV23qAe5Ui?=
 =?iso-8859-1?Q?sGCDB7bHmh8Pl6fFQOF+NdTr8tYyYM+Kkd9iNFPRCbBV/8fJf3K2kZn7Ly?=
 =?iso-8859-1?Q?IDMpFFz/Wq6yaWZ7deZGy7dVaVUdmv9jeMYhLEv0JLOsUFTh7Q+U77SNPL?=
 =?iso-8859-1?Q?j2zijTqZq3mHCpIC0qEX73XcbLSuywlcj1K6bhrnz+RxL7b2CFGiFESopX?=
 =?iso-8859-1?Q?7ZmkVjn6rVIOWuOwmwUk0KAR9S6IVpQ7fXBT8gYr2+zrP2d2i+EJO0ncsY?=
 =?iso-8859-1?Q?VuV9uj1imyAMSttiuygkx/nYCDeIvYxLldEsCmkwAPGx4UrklN2uydRMib?=
 =?iso-8859-1?Q?xVXEBp+sM4HgdQ6bNMpApJy2gPwB3UucRVO/lDq5x3LQs35zli9IRUkGQx?=
 =?iso-8859-1?Q?fT/0W9carOdOSYp+1V3KZvwnjXSB+u37rfhcSjXWyHMrlBwAD8Z/aCSCja?=
 =?iso-8859-1?Q?9CtDNMUSuc7mPwm1l28vTB93GC+MhERmOthOeXV+QqG0rTKpe5TK1Y3J2Z?=
 =?iso-8859-1?Q?uHPRfxoWeKMb3j8e8S0+oOfrfYhFER1c9UtjYd+GDiTdjr3MLYE/4twmfr?=
 =?iso-8859-1?Q?AyvgKp99rZCD07gH2vmENg?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(4022899009)(1800799024)(366016)(7416014)(376014)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Clb8Msjfb9jJfKGzczeZh5R2XPUqqqrSCK6C3CpVnTsIJ2NYJBoFrTk908?=
 =?iso-8859-1?Q?RiAkXTXU+AG12CXDUrilGW5qFzi5IgplMOwLfPX42gezEuPvNdYHFiBYdZ?=
 =?iso-8859-1?Q?biLc+aXZeDB4LTEEGl/fKthJ6I+SU9a2qSvB89JkmlMHb8wztPO8NOYa0V?=
 =?iso-8859-1?Q?dzyK+Ml7CptlNG3sh2WGFiwgKEdFYtUhrRPz/5VkA/9kxczimYy9IA0VcE?=
 =?iso-8859-1?Q?+rDldIZP8+PU/6R4Se8UCZCzAiIApyGsmuXDSGXKo06k8YZjT1plML4793?=
 =?iso-8859-1?Q?MI68LNNopQfsi8kOrK3JeHFJVWlJAjWt4Zb8hXPC/LOoso3dgFkLSnfgOv?=
 =?iso-8859-1?Q?4wixy+9OviWi6xi7U1nBbE5e7iIEvFgW/0xcD57ZvziaMLDpvf0WwuhiFE?=
 =?iso-8859-1?Q?ONjF/yx7SaoXVD8gWdETuvevJaycbXCLXfTPFSYAjUzqec70qQJ8U5I8ur?=
 =?iso-8859-1?Q?Yy8hcl7/Qgmj0+gFwRqInE+DkfgjVSmXqrvkhCh8psk+ay7psK1MGsSG7X?=
 =?iso-8859-1?Q?c+JA9qFY497HcJXCC3gkrwqqJBWWdUYgTXaviTh2wdh+rZEIaQHOJMDm6P?=
 =?iso-8859-1?Q?5HSYrxqenEE8UsfsF9rkGwOTUHesGaKinuL154jAA/E14nOM5t86mqFkXp?=
 =?iso-8859-1?Q?Qy4kTelMF50LcMDkDejkxd4/g6d09deQFIJgfdCZCHoGyjUZzN36uEFksJ?=
 =?iso-8859-1?Q?PwRjcPeVGOUbU342dZHRZ1JPRnX93k1oFwHqyuiE9ZN9rzj7Wxar6RdVxR?=
 =?iso-8859-1?Q?EkHyHrPw4cPmn2YCIOkucNcwFo9ub0C1eoBbLv1ceWMX2z6BMfduE4UsA8?=
 =?iso-8859-1?Q?xEax3QSkSUd4vcZ8pxvzNZw8xIfbCjIpsUtNQAIJKGBBRhTxHra/NaFQq/?=
 =?iso-8859-1?Q?JEQ65GjvWcj/pCjc8S41+ilWv+aSLFmPRrO6+Ow94/sE2qX65Hn1YJtf3c?=
 =?iso-8859-1?Q?UsEFQSBqsJqKaxWyBtwbSEkzKVlOK2NZni0/SLPch7YLzzjyS3J4t1sGpN?=
 =?iso-8859-1?Q?7qGXf/RZa5HfIZxyM1F7jXnkpG28Th1O3J8cPqcU9i1wG5ncFWDec7UPRY?=
 =?iso-8859-1?Q?v7pU5HPmEIFv7PI5XmF0zVrJe+7ruzMcskokpl4Yz3cJfZDYUkoUdVYzAC?=
 =?iso-8859-1?Q?D2Vf65096ubMER2mt9bLK20d+CFFUy4U8znayVb9YxOXuKiHhpJGnnP/TZ?=
 =?iso-8859-1?Q?jaG6PhPG5HPM75vdNAInQmb/l7r4wVFco6AwRmyRF9nC+d5Iaej2v91Bnv?=
 =?iso-8859-1?Q?FRK+U8X+SC8guNuRnx2RoPAj23bpwgMtyNoeAbikxBYZLoT/CPLbN89MuJ?=
 =?iso-8859-1?Q?0EGx2NEFzzpRoCI/IyVpNxDpfdH7nNmN2SI1dYR2Vi/PkppCb7sdiuEa9s?=
 =?iso-8859-1?Q?yisoMwm2FC5+1BjJl6mDwTsh6IhmRNeGwCxQPWiwM0gaxO68BswAGLmsb8?=
 =?iso-8859-1?Q?1LNYzDQ7tq616AKu9xF2N2WK1i3TIWKSNUBcIgzujKnkphH4bsXvBup4mJ?=
 =?iso-8859-1?Q?iWHpkK8/rvfPqwDCxpHbiGRf4AiYyaCBlCkMyM4k0YQO53Ru7zGgV4vo7n?=
 =?iso-8859-1?Q?KrvduCZIwOFDJ2VZvLtjaZXIgnx0IF1vZnTTvaNUKP+sg8EGvbWoDKzWnw?=
 =?iso-8859-1?Q?9fTAMK9VzCrWCwQzbQCaw418mwcX9QiZfBfaanCfw7ZvpgDPEWMxjvRNcb?=
 =?iso-8859-1?Q?Jyq4FdNhqrb09LdMn0k=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82870b5d-a64e-42d8-4f0d-08dd3979bb26
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2025 17:41:54.9728 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Sd4a6kcKL88CeG5/Rr6UokqVBBaZLQ5RT0CW2aDsluMnHhmi+V4fM5UaG9XSTuf+vEWx7E/TG2S2TgJ4vUDZRftCA+kJxmiht6WVtXHjdhsst9+Rr4n1K0PkkkC4iu9R
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR07MB7548
Received-SPF: pass client-ip=80.78.11.82;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost1.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-0.036, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Devices implementing ATS can send translation requests using
pci_ats_request_translation_pasid.

The invalidation events are sent back to the device using the iommu
notifier managed with pci_register_iommu_tlb_event_notifier and
pci_unregister_iommu_tlb_event_notifier

Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
---
 hw/pci/pci.c         | 46 +++++++++++++++++++++++++++++++++++++++
 include/hw/pci/pci.h | 52 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 98 insertions(+)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index be29c0375f..0ccd0656b7 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2896,6 +2896,52 @@ void pci_device_unset_iommu_device(PCIDevice *dev)
     }
 }
=20
+ssize_t pci_ats_request_translation_pasid(PCIDevice *dev, uint32_t pasid,
+                                          bool priv_req, bool exec_req,
+                                          hwaddr addr, size_t length,
+                                          bool no_write, IOMMUTLBEntry *re=
sult,
+                                          size_t result_length,
+                                          uint32_t *err_count)
+{
+    IOMMUMemoryRegion *iommu_mr =3D pci_device_iommu_memory_region_pasid(d=
ev,
+                                                                        pa=
sid);
+
+    assert(result_length);
+
+    if (!iommu_mr || !pcie_ats_enabled(dev)) {
+        return -EPERM;
+    }
+    return memory_region_iommu_ats_request_translation(iommu_mr, priv_req,
+                                                       exec_req, addr, len=
gth,
+                                                       no_write, result,
+                                                       result_length,
+                                                       err_count);
+}
+
+int pci_register_iommu_tlb_event_notifier(PCIDevice *dev, uint32_t pasid,
+                                          IOMMUNotifier *n)
+{
+    IOMMUMemoryRegion *iommu_mr =3D pci_device_iommu_memory_region_pasid(d=
ev,
+                                                                        pa=
sid);
+    if (!iommu_mr) {
+        return -EPERM;
+    }
+    return memory_region_register_iommu_notifier(MEMORY_REGION(iommu_mr), =
n,
+                                                 &error_fatal);
+}
+
+int pci_unregister_iommu_tlb_event_notifier(PCIDevice *dev, uint32_t pasid=
,
+                                             IOMMUNotifier *n)
+{
+    IOMMUMemoryRegion *iommu_mr =3D pci_device_iommu_memory_region_pasid(d=
ev,
+                                                                        pa=
sid);
+    if (!iommu_mr) {
+        return -EPERM;
+    }
+    memory_region_unregister_iommu_notifier(MEMORY_REGION(iommu_mr), n);
+    return 0;
+}
+
 void pci_setup_iommu(PCIBus *bus, const PCIIOMMUOps *ops, void *opaque)
 {
     /*
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index a11366e08d..592e72aee9 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -461,6 +461,58 @@ bool pci_iommu_init_iotlb_notifier(PCIDevice *dev, uin=
t32_t pasid,
                                    IOMMUNotifier *n, IOMMUNotify fn,
                                    void *opaque);
=20
+/**
+ * pci_ats_request_translation_pasid: perform an ATS request
+ *
+ * Return the number of translations stored in @result in case of success,
+ * a negative error code otherwise.
+ * -ENOMEM is returned when the result buffer is not large enough to store
+ * all the translations
+ *
+ * @dev: the ATS-capable PCI device
+ * @pasid: the pasid of the address space in which the translation will be=
 made
+ * @priv_req: privileged mode bit (PASID TLP)
+ * @exec_req: execute request bit (PASID TLP)
+ * @addr: start address of the memory range to be translated
+ * @length: length of the memory range in bytes
+ * @no_write: request a read-only access translation (if supported by the =
IOMMU)
+ * @result: buffer in which the TLB entries will be stored
+ * @result_length: result buffer length
+ * @err_count: number of untranslated subregions
+ */
+ssize_t pci_ats_request_translation_pasid(PCIDevice *dev, uint32_t pasid,
+                                          bool priv_req, bool exec_req,
+                                          hwaddr addr, size_t length,
+                                          bool no_write, IOMMUTLBEntry *re=
sult,
+                                          size_t result_length,
+                                          uint32_t *err_count);
+
+/**
+ * pci_register_iommu_tlb_event_notifier: register a notifier for changes =
to
+ * IOMMU translation entries in a specific address space.
+ *
+ * Returns 0 on success, or a negative errno otherwise.
+ *
+ * @dev: the device that wants to get notified
+ * @pasid: the pasid of the address space to track
+ * @n: the notifier to register
+ */
+int pci_register_iommu_tlb_event_notifier(PCIDevice *dev, uint32_t pasid,
+                                          IOMMUNotifier *n);
+
+/**
+ * pci_unregister_iommu_tlb_event_notifier: unregister a notifier that has=
 been
+ * registerd with pci_register_iommu_tlb_event_notifier
+ *
+ * Returns 0 on success, or a negative errno otherwise.
+ *
+ * @dev: the device that wants to unsubscribe
+ * @pasid: the pasid of the address space to be untracked
+ * @n: the notifier to unregister
+ */
+int pci_unregister_iommu_tlb_event_notifier(PCIDevice *dev, uint32_t pasid=
,
+                                            IOMMUNotifier *n);
+
 /**
  * pci_setup_iommu: Initialize specific IOMMU handlers for a PCIBus
  *
--=20
2.47.1

