Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 456B3C021BE
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 10:58:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnbXa-0004as-5E; Thu, 27 Feb 2025 05:54:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tnbXX-0004UT-5B
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 05:54:51 -0500
Received: from smarthost3.eviden.com ([80.78.11.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tnbXV-0005or-AH
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 05:54:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1740653689; x=1772189689;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=tTPC7x09d/JU2UNVzXQW4tNA/ojv9FQmKpl+PJhHHRY=;
 b=ptSFEQ0GPjSkx/NmQyfdMlVanWkK/mPDZEHmDbiwgMgY0lgAOhldoDen
 rJTu2cVZJsSHQhhJvwS0QphSee8SD/jXmvWUwQZM2RqjnnrDkQAr68lHp
 74tMkyRB20I7zv69VmPShYI4NrXyLNh/J+bsLtqSUm0r4kW3zqqPUkHjg
 xhTeFHpXzuRGrPfvWP/rJ4zs4fiZl6HOv6ndGIBqoYFZ8/ybn8zEbS01y
 um3mMNe3leLRprf1qUh3LtNZwsDqoYoS2ya/RwoalBkQ1ErdkRNE5ngD3
 OlD3F2JMb6ptdp91+Bf2P6nTr3bKrhVl4afLzEQYUrkRV0MiA7KN7PtBp w==;
X-CSE-ConnectionGUID: OsIcCckPQAyZHjz2F1V6Lg==
X-CSE-MsgGUID: qvHSI/rQTfuM0gHQBAzXrw==
X-IronPort-AV: E=Sophos;i="6.13,319,1732575600"; d="scan'208";a="31822962"
X-MGA-submission: =?us-ascii?q?MDEgvUb7++44MnjbT7aOvMHra4kxKZiLDeoaS+?=
 =?us-ascii?q?VSq/fCp5vBHfjEDUHK8u3NT5gXTrrDoSx0cIN8XWvImJXUDXkFpE7nBH?=
 =?us-ascii?q?c/oAEceRLEQ2kmM8dk9nYLqeuIq5J61+impYlpex9Z7KdDbdPFm/eJS2?=
 =?us-ascii?q?COQ4SgLbHEYGWtYTiqzX10yA=3D=3D?=
Received: from mail-db5eur02lp2106.outbound.protection.outlook.com (HELO
 EUR02-DB5-obe.outbound.protection.outlook.com) ([104.47.11.106])
 by smarthost3.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 27 Feb 2025 11:54:44 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DgNF4vI5k49AoYdS3k0pipkFMhUetZ6zV+bmMSiZGns0mA2mImE3nwGsXZXxEeXcHDWrP3D+gESG9Ds2kSnke5PxbYDvLTJQcZsnT+bdPQlGiVNNl3W3PC2WnQXvqAbl/vPNie/JANqCXZYixeJt0NJgOyx9g6H5lyWCRo7sO3H/LpmamLkzNq//ue527i5fR7oDbeTyrOtou/Zni1/DALEDFjpmaKhN04HRQRz6z1Wj5l+f3Hp9wXwg+XY90CFuBbqLJ1rCQ8eNZAj4+Ukpdcd+d9f6KocOR/En3Awicz1gnBboNGneogbhw+YKrGdlm+e8s+KA9V3BcPSDeeLxWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=86uCvdGZzOooKIlDZ2DFXfgs7JqKRdpzpFrzYIXH/p0=;
 b=XeYeEmUnxmrB94jhMP3CL3NVndeqDkwH+xW5QgKVnO4VSshG+vP/1XgyGRR67bFR8dqoiKiD1dKC0qAxbC0zCsYboYFqIhvJ0zO73ANkpRaThfHE8/vo5xUWKBwFTrztZ3/kDFVi3885gwvw+U4ue74qUKIBu/B+txPyi/24O6eafAZnVzbxcl++1qipNirob2z5QlCBtCbp3Qq/IOXS1YullScexf9V5HMlK3W3IAqFURflMo3q8zu/mQp8XbUzXu/0aq3vH1liemEiRpvgqgnIjtUQm50VglQaoQ6l0exKaR6oKxQOBcTe8ITSchL2r72rXAWvMcnIzhaB4xaJwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=86uCvdGZzOooKIlDZ2DFXfgs7JqKRdpzpFrzYIXH/p0=;
 b=PkCQvNRv3tNj2NZhDB1et1bwIhorHPOiuqVURmWR+yp20enMKB212EJ+hmmuE5wtqJY0b4291GrPZuhhMIKvgnA5WzmgTtdNhPfKx9DmDin6p8W9nxkhMkTskUUsq7oS6WnXZfxKpDBAmKuSkPFo2qVSYwlvXK7z7alJHaXc9aojNKI5Wsv5Hb3QY38pHUD5cSbKQuLBLAzfZDsvqmpuetpU7xv2nCfdcGPRX0AM+src3Jl4dD9zeumJRwdbxPcB0taRAfe7MfZKPEpA7DLDNcU14R3XKfiHv9VsgEsAg5fRXXx90Uzyx1vSqvCh5vlGdb9V+n4ywcVKybmrCL3WcQ==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by VI1PR07MB9421.eurprd07.prod.outlook.com (2603:10a6:800:1c0::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Thu, 27 Feb
 2025 10:54:42 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%7]) with mapi id 15.20.8445.017; Thu, 27 Feb 2025
 10:54:42 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "tjeznach@rivosinc.com"
 <tjeznach@rivosinc.com>, "minwoo.im@samsung.com" <minwoo.im@samsung.com>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH v4 06/19] pcie: Helper functions to check if PASID is enabled
Thread-Topic: [PATCH v4 06/19] pcie: Helper functions to check if PASID is
 enabled
Thread-Index: AQHbiQYBznvzjmx4OkaRgAtUXIWv/A==
Date: Thu, 27 Feb 2025 10:54:42 +0000
Message-ID: <20250227105339.388598-7-clement.mathieu--drif@eviden.com>
References: <20250227105339.388598-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20250227105339.388598-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|VI1PR07MB9421:EE_
x-ms-office365-filtering-correlation-id: ffa7242e-6b72-4260-dce4-08dd571d2402
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?g5ec7PXYveSFPa7B8nb3dta0zYqGXaScleZcflhdS6Cu8++4XwRBkoVU0b?=
 =?iso-8859-1?Q?9IJTBgrbZctexqKVOmauyP5taMJhws0O7PrJDSTIiNmN4ny57gxMMYpI1E?=
 =?iso-8859-1?Q?Y+58HjElVfa80bUxzR/+h3uSz4AZE6iOv9VhlfZTYRq6+hfVRGNyHNkKGt?=
 =?iso-8859-1?Q?sS/jQxV1bX/TX8Nz5J4Fx18HyOwQtZobzQ/Tu4/pb1h3TzCqCmQBBh0XyR?=
 =?iso-8859-1?Q?ATuxRZFrc+iJUwBsPcXCw6jk+9PmsGNB5OT9OzE6jGNr76kLSKAsGN8Vbl?=
 =?iso-8859-1?Q?dQa/Yoxrm6WUqtCk5E9uQjfQor8wWJV5jeFWvLZk8pGJlwJFNlgvAn+zrp?=
 =?iso-8859-1?Q?le2iX39GnhSXnH8DWAH63ZNHDjlMj7PpAvfSsjuUqDrgUL5CWvc0vjmKcV?=
 =?iso-8859-1?Q?pSluWXStDmjfOZU3C0Eum+5NAbZRb99R6YYx8/c3dnrh41YxwqdHD3jZY9?=
 =?iso-8859-1?Q?lMlaj/qatrbaoih0n5dnRyIVFaNP80ymFdY8JLAKT/vilNolKoYvsGayAO?=
 =?iso-8859-1?Q?z+xlDjtsma7B2jIRP+xnVDAq2eGXzjr4c5a7rEoRF82D65tv3+OOCrxF2d?=
 =?iso-8859-1?Q?jnU6JMU3Ia5vaCXT47A6wff5ldfBZ9ABlY+OFCXEVdhGOXLoLbhS+4Q/L3?=
 =?iso-8859-1?Q?hi3kRS10s8F64w7ZOvBp2wJrXdjQTQmRoBVvMsm/wlGsvpVGwpFMNTPqZ+?=
 =?iso-8859-1?Q?thML2Sp18TDnQ57Ngk041YnFnolGa754kObIowxlsXWBXTFyI/mpU81Mmm?=
 =?iso-8859-1?Q?YJmlT9bYIpCCNT2AMzeT1X/8YCfwFr27xBLIvau7rEFFng/0vQGPK3LqCg?=
 =?iso-8859-1?Q?YkjamXOB6tVv8N/9/I0hKE9nqucijsgcakZ6MHaSbQurRuvk0XMjwSnUmV?=
 =?iso-8859-1?Q?77+O1i/gzWs6WsmzbYeQTGz88KW0/ukiBZeqbK3RrjmsV69awX2FNQvnMB?=
 =?iso-8859-1?Q?zRMHggYGv+DWwaCqecD5hc72gVeQhnxAXosTyHoOMAge4q+UMgMe7MSy16?=
 =?iso-8859-1?Q?00m+pDdKrJcSPyeUkjOM+O5oLl8GlEMahYYLxH2dT219nBJTFFCiJXTek4?=
 =?iso-8859-1?Q?hRJSJFxwPkxb8WuzDvsjYXQm+U6ctPakjZOX5TmMFDHs3y8WBrgkA3Sk6D?=
 =?iso-8859-1?Q?4AW6QsYnumwWTGR5+igXS6b3YoPM0mIWslhKTie+ra4YrEAMyo0gv1p4rk?=
 =?iso-8859-1?Q?XwJRQNZNHiDxXwqRiN6jCYLgk7VAztX8Bww7TG4mI3hXPJzQycQYuX7Zsr?=
 =?iso-8859-1?Q?BZ/2poHXRc3Ea45LBn6d58FN4UGH5KfuX8WDIXpE/t5wo/nbyLz0uZbN7B?=
 =?iso-8859-1?Q?1PCXB+wZy+EQT8w1922rh1Rut79bh9M0tt6JnVQedHSkhcrufdfbOnAfZQ?=
 =?iso-8859-1?Q?nVsPSOFDRYiPZvyajI3y358apPkgU3GiDBlW+JuytKw2r9rPHJb8G5iTSf?=
 =?iso-8859-1?Q?CNNJmPJgdopXFE8CPfur2IbHWDrJ235xnZvQN24HKdb8FJ1UMyGHb8EqN4?=
 =?iso-8859-1?Q?QU2kIHaFEzPmWYrryE+Pp0?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?btlsUVujJMbUDuS4NMeA4/GXUHKWgXZdx5bGi0cA61O3zBTZJNPiir4g8f?=
 =?iso-8859-1?Q?YTZIgP4aR8dYwh31KHUs7H6v+07dLg62v4OigU54SU/r3L95yqfZAMGYz3?=
 =?iso-8859-1?Q?nb5YlF6NUFToIRScwwvWfI4JDJ1K0mg1rMTJD2fTYbTAPkG4LXdHI9OC7T?=
 =?iso-8859-1?Q?pP3edpqf4Drt+1gJLvuadTt9y9afY7Lurs6hR8vUqNJJjtRtTFfPk6ogK0?=
 =?iso-8859-1?Q?puN/3B01I5jsNr8AefAWBKpX2ZkSCLiBX03U9gz+c9/m8O+PIYOl7DfnBI?=
 =?iso-8859-1?Q?zyW29L7ow3Q0h9unTyvbXlWr55y91orvR4m1BRo4OyaR7iLYv6Eyoadnc+?=
 =?iso-8859-1?Q?F8xPC3zMZ9/7bk04RuYojcjKErjVfbhPvV5fCs71JKjVDuJ9DN5SBNE0wQ?=
 =?iso-8859-1?Q?cLQuiHefcKQhM1kD0Ljo1uzev6Rn+PPS8Y4rK4bshUNVC4Vq03embKN6q3?=
 =?iso-8859-1?Q?AJEb+5aNfBsURVK8heFlwtXj1XMxWv2qwB0MrTHrXwnxrZiEee1MrFcg7k?=
 =?iso-8859-1?Q?mtgsK9RpJybIoQ8PUsg6v04tc1ltwkFu2BtVpqS9p4f8dnOE9Sx3oyhD+E?=
 =?iso-8859-1?Q?V5hqvIkbvBP6vUckS1R+X9b65LqROJWZM+nACaQ1sXMFvfMQITiqEaz0Pn?=
 =?iso-8859-1?Q?CCXlOuQO2ggP7QUrHycmiANQBUvlQW65w+zdJk7UMmTfD82xCvKgIg08so?=
 =?iso-8859-1?Q?a8A7INpeeOaNV3wJ6roemKEuAu2u6XI6poQfX44JU/9yf9xwjBE1T6Cif+?=
 =?iso-8859-1?Q?cFEDtA9S9ypC+8QMFFcSfHxtY7y2gaJCNG3PgxLd9W+Og4E/GV2L/aBPBo?=
 =?iso-8859-1?Q?qAo8gP88vlK5WHcVROHe2ukoCh1vY+qTM9/TcsYb5nTrtDjbiNXP3s9Jz6?=
 =?iso-8859-1?Q?aPycjtoviiPUf3Dw69yfm2WkwGr1xeN1YkyavtrviP+ooU+4SXvnKtJkFC?=
 =?iso-8859-1?Q?uPmcp+YiTv4dJUbjzYFtNE2bK0HTLpZYfh4U0Bl+AuCj5cQpkV70xCEP5P?=
 =?iso-8859-1?Q?GF6L5RhuVJrQV+vYKXSp9PtRBsSP6rwGTfI/3eYQiuCGbeyLKIjf6MimSP?=
 =?iso-8859-1?Q?fBRFj4eLgi6Ss/XAgEweRjnWBWdNg6F4HgArmVWnrFWNwDxJEvKgGXiFaA?=
 =?iso-8859-1?Q?jqM6YY2XC0c8gPztBiSu7Pm4BmcIpckQKcby0fUAb+Oi26kvIJ8T/87NDJ?=
 =?iso-8859-1?Q?VwHDGF3kcGmD3NzEuql+7WTs6OF5t5lKfL6kMbFLdk2GOHRC/Peh3kcrhJ?=
 =?iso-8859-1?Q?ykLO07U2IhMDy73WgaS9bdUmXCnnHCcbTNWLBh/aFRNKV6PcoQD9kl5Aea?=
 =?iso-8859-1?Q?Mcio+9PIZaUtBTDlVOjmsyK/EiOI0LKhUi5U0g0RrEsofk3YOyAGw/QKQJ?=
 =?iso-8859-1?Q?scN3Wl76a9C3snZIu69zUNUXf4tWkPT6qGa1Y0Jz7v2mNa/KJDa63lgM8B?=
 =?iso-8859-1?Q?e2/G4csgc+rl4iXliWo+fNIs7c7T8LpjCqE0gd6Fn6B/4pv/K5KaTlsuin?=
 =?iso-8859-1?Q?LsDBztCzm7cTbIJnp6eG48AXmZLYSgIyjubfHyATbBnehV9gUWi/8DgE+d?=
 =?iso-8859-1?Q?0NXRxcaOPwXbrYd410sfErNQkl4oQKLWnZ3YRV66uG5aAhjDzrWG0+E5Tv?=
 =?iso-8859-1?Q?RwYhOyYVBI70UI5eozpKEdjeRCzxqPRoBBd2GFLZdIRrNzdrwUofJI3APJ?=
 =?iso-8859-1?Q?EE3F/PwPbZGrPQlb3sA=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffa7242e-6b72-4260-dce4-08dd571d2402
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2025 10:54:42.0688 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hiSo8tVJjFa1Wj2xCjOxSKkQxh+Nugvn2IVddUreQXgtCznxf0cHAh/bPtYL4YQ+MpuqiMZd4TtLm88cT9yQfvEjhmZTvkg4cuEEIj9dNiLSugSI5iQvMWolWykJI8XL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB9421
Received-SPF: pass client-ip=80.78.11.84;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost3.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

pasid_enabled checks whether the capability is
present or not. If so, we read the configuration space to get
the status of the feature (enabled or not).

Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
---
 hw/pci/pcie.c         | 9 +++++++++
 include/hw/pci/pcie.h | 2 ++
 2 files changed, 11 insertions(+)

diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index f42a256f15..8186d64234 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -1238,3 +1238,12 @@ void pcie_pasid_init(PCIDevice *dev, uint16_t offset=
, uint8_t pasid_width,
=20
     dev->exp.pasid_cap =3D offset;
 }
+
+bool pcie_pasid_enabled(const PCIDevice *dev)
+{
+    if (!pci_is_express(dev) || !dev->exp.pasid_cap) {
+        return false;
+    }
+    return (pci_get_word(dev->config + dev->exp.pasid_cap + PCI_PASID_CTRL=
) &
+                PCI_PASID_CTRL_ENABLE) !=3D 0;
+}
diff --git a/include/hw/pci/pcie.h b/include/hw/pci/pcie.h
index aa040c3e97..63604ccc6e 100644
--- a/include/hw/pci/pcie.h
+++ b/include/hw/pci/pcie.h
@@ -156,4 +156,6 @@ void pcie_cap_slot_unplug_request_cb(HotplugHandler *ho=
tplug_dev,
=20
 void pcie_pasid_init(PCIDevice *dev, uint16_t offset, uint8_t pasid_width,
                      bool exec_perm, bool priv_mod);
+
+bool pcie_pasid_enabled(const PCIDevice *dev);
 #endif /* QEMU_PCIE_H */
--=20
2.48.1

