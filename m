Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DF8606A33D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 07:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=XjvZtIo4
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOV3M-0003Sa-P7; Wed, 04 Nov 2026 02:05:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1xOV3H-0003Ru-GB
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 02:04:57 -0500
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1xOV3E-0003s4-S6
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 02:04:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793775893; x=1825311893;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=94vBGW2eOQMkT1JQcfD2EwBmZMM5wa3GskmdgJOXYFI=;
 b=XjvZtIo4AyUAW2ruELRhowtP8ZogmjwauqWE6P+Nl+zCK6g6JOQpljyX
 YV+k0I1nx2KsxLo+FOCUl72A+j1afPqa8qyEOiCr7E2vcTM3mDY1yC27A
 DRDcN7KROmrdeW0SZftUArrbamXMmd/pwkv+Lk02Tbo1D4yxKi0di9e6v
 74aB8lO9pRw1QQrQOXlQz2wEUtdzVsk1McYBGUjz2aHnzloMgFkDyStwJ
 UDtNwK45BcUfsahDyLq5fF4rG2GvB9rUJPXzHGK5mXFH6FduxPhOyN2/5
 kD9LWu0Jb7J2cqQJRZMy8n62qVlh1RgnGM7AIwgT2rxln7mHmWgbwXb8k A==;
X-CSE-ConnectionGUID: HMonbuWaRaGHspQFHXdbeQ==
X-CSE-MsgGUID: +lglvUQiQrCDBlhtBZuOJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2415576"
X-IronPort-AV: E=Sophos;i="6.27,194,1787036400"; 
   d="scan'208";a="2415576"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2026 23:04:46 -0800
X-CSE-ConnectionGUID: v96G+x0tR120eynMJ2rqcQ==
X-CSE-MsgGUID: s815wDC3S/qB5vs3OhnzOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,194,1787036400"; 
   d="scan'208";a="6960517"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2026 23:04:45 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 3 Nov 2026 23:04:44 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Tue, 3 Nov 2026 23:04:44 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.3) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 3 Nov 2026 23:04:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hcMqZ495L/j9xTy4zDFY2ZpfwndFOZ3GwRNroZByHMOEszjR6qLqi2oumQ+XqlRmnP3sf3kitxdbiWtafeJ3Ng7strBlyD0w4heDyhq6ylWfdTaBJu8Be/QhwIbTwkf2I+xWouyZRxA6Uwuq570gbLwbW1JBkE6/D8wzeO9DUIqz0oizsV84iWxMj0LbJ7crhvT1+OoRSknjs5HcgMEJdHK48S5mgwRr/P/TnbtSJylQVRpP48vMxWurJhOIr2Jzv/LyUw6gudND/cWrmdAopbKzq/stMdJkBZfPecyFC3BIrdf572YUJ5jBF33s20f8mFqLO5NSMaC+K8vPMVhopg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=94vBGW2eOQMkT1JQcfD2EwBmZMM5wa3GskmdgJOXYFI=;
 b=QdKFeAq3xycK9hGenahYs6jUdK7bT+7kBW4sy3odfqQcljvNyDmXynkwECQzjI3QYAqIGpWRhMk47WQS86aCn2HhOIyp69lixj3RZeiCsXPhqJo7xzfsTiIFY/3o9S23F1YjhyoEpk9oUwhAA/tuJa0z7zooNKJehVxhHU2xdjpqlBdiSDiveZ7BpXz8H1OGMkbr9eU5rfjU5mRu9U2oJBH5/s8Y/4zL4GcE0tPj4sosc55Dyr5oYvkQyO8cV5WpCbZrY8kqCet2rvHzw/Eif61+K2vteHWK6SziMmhAxhnTzH0Phm31hGHKi4DFjHJruDnpz06fTYsvMSNshp+zBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by MW4PR11MB6911.namprd11.prod.outlook.com (2603:10b6:303:22d::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Wed, 4 Nov
 2026 07:04:42 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b%5]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 07:04:41 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q2zDqW1lbnQgTUFUSElFVS0tRFJJRg==?=
 <clement.mathieu--drif@bull.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "mst@redhat.com" <mst@redhat.com>, "jasowangio@gmail.com"
 <jasowangio@gmail.com>, "Liu, Yi L" <yi.l.liu@intel.com>
Subject: RE: [PATCH] intel_iommu: Keep PASID cache consistent with PT fast path
Thread-Topic: [PATCH] intel_iommu: Keep PASID cache consistent with PT fast
 path
Thread-Index: AQHda3lx2WzNaS4QqkS2yEpAVWK9+bccTP2AgAEw7/A=
Date: Wed, 4 Nov 2026 07:04:41 +0000
Message-ID: <IA3PR11MB91360200F2A3C8A9E445151C92682@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20261103095444.1218225-1-zhenzhong.duan@intel.com>
 <e6061c6db1f093ba9f8acb6e9f0b129ee659944b.camel@bull.com>
In-Reply-To: <e6061c6db1f093ba9f8acb6e9f0b129ee659944b.camel@bull.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|MW4PR11MB6911:EE_
x-ms-office365-filtering-correlation-id: 03554846-dfac-41b6-4c3a-08df3a41e618
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|38070700021|4143699003|11063799006|261026121527099003|56012099006|261009223027099003|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: Qrni5qBVCh5WrLyu5uaRl7zgRQMd+D8HiH872yf5/ZDPgqmiCPHtyHBKut+b1hfr7lIHXu5+kpTT61bnu6OwpEPvPXGwX42ex+tbom9Ilz+qn9WZk62Ix4aWgSt18+KUyojy2wtyIZ9m5yfVJ3ad+7jw1wB7J1QlvJo19zBjLLWTdNvgXL971oQIGMBbxbWWC3GbVrV3/UDFwFOEdAnNijTKbeRqFqTm+16YaQ0waAMFrwLDlprDvNDhQJyOv1n4IYj8hNmOKLAEKJJ9gvOQuRO39K4ZeZG+nC6SidHI6UueAy+JsqyT6ZByZkTIhfVWl4/g6vY4gtX4hB5nlr5f2qT2sIaF06uyrEgXYUwQebk08gDwBsMrSCtPMrFCrVNfHH/FO+3bQ25vEb4DpHRdkey7NkmE6NQ5EWcDDArJzlocMHWxuz5mLzxiPfr0wEJIJ+zzGjxHrM4oJpc8azXI5jSE4Lc3nj5WO2436fnlUXh952Z+gNZ5BICAPSxNRP5MQZKDKoD2wFTaSWVC5nZWr2JiiwNCvYx5HKptrtYRAy/p2TIlDg1Ekpr3sEQeYQMWlPKp232/FWTVG7uhkHVz9hE69LZC50COwM+USeok3JTR4optl/YSsG0j9jj+04q22yZF4JeLsoYgAxIkly0+xzcOUU2U/8FR+6nE36OUk8loU42Jfv6ttD5BPbE/aFEoQhW4HTFLuXVFmvT/kGmr0w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(38070700021)(4143699003)(11063799006)(261026121527099003)(56012099006)(261009223027099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VW80NE1LREVVVGhURVpKTmpDZVYrR1Z2WXA0cUErUjlFcldPMlUwRDRzZldq?=
 =?utf-8?B?YlVjZ0ZFMVZUajNLVE1mZkxMMjZZZ0dWS21peTVLWGxpRDhPWHF4QjVaaWp1?=
 =?utf-8?B?aURETFNyRzdORktFZ1c0T2VqY1JEM05CRUtwREdaaFE0OUxISnFGTk9GTnZj?=
 =?utf-8?B?cjFSUkpVMG5wVnJIRmdzOFMzZmtkd2duNnhSb21iL05iVUlXN21ZSnB0V2hv?=
 =?utf-8?B?c0lVKzMrU0NDaWt4d2tCS2I0dHQzOFJ4YXBXTnExQlE0d0FkRjN5MmZlWEZr?=
 =?utf-8?B?ZkpGMkpsVEVDL0lPMW10bmxWSjFwTG5Ccy9DM1d0Vzl5TGdva0hkOElWR0FR?=
 =?utf-8?B?UCtJaitRTWcyU3VJbFBCOHFHN0dnUHE0ZGI0aUNScnp0eGJ3ZG1KZmN2Q3hx?=
 =?utf-8?B?Y3RTZW16M1gyYis1eGVUVzBsRThiczRZSHFtM2V4a1dyejVlSnZJWThlOGJQ?=
 =?utf-8?B?QzI5Z0o4RTVEQjd4RmxVdUFORnYzd04wb1RBd0NGbGY1eHNPc3owMHR0Wm44?=
 =?utf-8?B?dWlxaEw2YTV4Y0lSNEJTcVZSd2NxeTdqY2haYmFjV01WNVkwYit1bllnanI0?=
 =?utf-8?B?TGFnR2lhbTVBV1k1UW42NkRwTEdnaFZubHRMWjlPRkx6Q0tGczNQTm5YaUdX?=
 =?utf-8?B?U3VrL0Q5QnFjUmVMVTIyQU1taGd3blQzWGNKYVJjMFJsVnZ0dmVRd3YvcVpT?=
 =?utf-8?B?b0V0L3N2QXd3L251OEVXQ1hMOUxWMkFobVhEYjgwOGFkOGV3Q0Y3dUJwbVJL?=
 =?utf-8?B?dUJIVUxjazBucHB5eXUyT29wbXp6T0w0dmY4aFpKeHVKVzVhNjhYazIyV0FS?=
 =?utf-8?B?UlpVS0xBWHBNd2lzd0tsaUtRR21FdHRWakFxSEJKRS8wUHBld1g5Y09Mdzg3?=
 =?utf-8?B?a3oxTnczT2V1ZGtIQmRuU2RMeEhNL0JZdkwxMnIwRXkwRzFqWmdWdjQrVjJq?=
 =?utf-8?B?bzU4ZDV2U2JRNWpsNXVwVDVJQ2owRjRLcGI1emdJU1kxZE9VbEw1MTRHRDJa?=
 =?utf-8?B?bTgxY05GL3JQc1BUbG1ycktFcm9uSTM2THJDNnBSMWF3TU8weTVtV3EyK1Q5?=
 =?utf-8?B?T2FFL3E2OW41aEE2cGpSQ1pCaHZEa2cvVENqN3QralU5ME94UWhpT3A2ZmJp?=
 =?utf-8?B?MGJFZXMrSzNSNEltRGN3QWxYNWFZS2lXR3RuNjhRcG1mWTdobDN5TDgzQW1j?=
 =?utf-8?B?SUl5Q2hUN3U2VFRKbngrTHlJaTN4MUsrTUg4aWRHc1dzU0sybytTL3l0K3hs?=
 =?utf-8?B?b2FJNjBvcnFhUVk5MTVVcThiRmQxWEwra1FHNHVrTE9sVlEvL2M4UllHV3Y4?=
 =?utf-8?B?dWZjR1hwMU52NTI2dU43cDJyYk9RY2VQR2ZDZzVvTG4vSkwrVXhIZkdZNDV1?=
 =?utf-8?B?dlY0TUhvb2x2YmNaeXVhTHExWTF0UHE3REVkOURpRmJCRG5hdDlPb2pveUFQ?=
 =?utf-8?B?cmZnblk0V3RQNWYvQUV4OVU2UDk1aERIaTNYaDVGdXliV1c4MHhVTmtvVjln?=
 =?utf-8?B?THFsUDdha2JYNUpGdXpOUmVEcWF4RDArNW9IU0Q3dlZ2UDVQSmQzUmw3L01u?=
 =?utf-8?B?YWZDZ0JMWHhIUGRYRjJubFZKWm1hQms1ZXNHZVBZWWxLU3ZOMCtpK2taa2RJ?=
 =?utf-8?B?dlErK0dVNFlpSWt5QXRad0Y0R2RyQmxXalVJRlY2dk83STNHUVc2RVZnbG5W?=
 =?utf-8?B?WmRvWk02YjBpVTZBQzE5RXc3MGc4ZjdXVWZyUzM3TDlNT2ZlWEFJbDZ6bkdt?=
 =?utf-8?B?UVRhaHpnVlpnZnY4NVY0eXNUL09xL1ZoQjV4ZGtOMDBXMmdva05wZlRTMkMz?=
 =?utf-8?B?Y3JRYVBzL092SVltOFlmeFZaSXdaM0lSdnlicWFZQitGMWJ2cmFuMUlqL25x?=
 =?utf-8?B?ZlJmT3JUNzdJUmJrZmEyS1FMQlF4ejZQV01oWjJkc0dPUmJxREE5aUM2bEcz?=
 =?utf-8?B?dHFsT1VveFNCYW5lWWh3aEQwbGloL0FudE1FMHN4M05QYjFKOVRJemZEQy9R?=
 =?utf-8?B?SHBmaWZnVjJpR25lMHJhZ3E3VTRkcDNEUGpmSWNaVUM0YXV5Q0UrcDJpdUV2?=
 =?utf-8?B?Wis1d01TMG5NRmNmUEtnb2hXREd5c2pXOUFHMXBWWHd3TnJ2MTBRMUhrMU8w?=
 =?utf-8?B?Mmk4WVI1dDFNclJVL29BSmRVSVA2VklOU09JQXppVThvT1FhK0ZFbXJLMmEr?=
 =?utf-8?B?S0FDeXlXbjQ4MFZwSmo3Y2VPS0s1Vm9PTmNmVXFraFFKbFo2WStFQUNYMC8r?=
 =?utf-8?B?ZktRanN4RGZndHFFWEVsbnEzTEJlNG15YTJ3QjErN2FycURoTE5SaVNYU0NX?=
 =?utf-8?B?VWovRUI1aXRoRDhsWkN0azZ4LzNEdmpacytvSjd0YVNSVkRhenBNUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: dylVuZgoOnjAez/XVFnU3QM/V8o6QBZVgKymBGI0hoq7GgH7oXDD4HHPZTtJ8Ba85dzKBTrS406bcRfluoQAYV2PFJA5phVHJrsjFGlc3EmYx/7gOxna+crDPaY3uEnjs0hGBbUgIkHpGe7cHmed91sRlH/hX/FeTZfQ1Fl78/rlM8edfACb9GUh3WtZeVxLLrH+ErRsSXcfez4NCA09fcTiIO6fTOl6ZcBkf/Q51xHSAO86WPjQ80dTGWl9VX9mNSmPsn4IgN0ovUJtR8t6sdP1or7Pxn9u2wsgcstabQ9N/oMbYnbRot6ZRqW+MgiVzfegBw3ESxXwgivgcBwZpg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03554846-dfac-41b6-4c3a-08df3a41e618
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2026 07:04:41.7004 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b/AZBH09ushlPxJ2hPm18pQpLkh6F4BlcoSvpnXd69hex7IW8sPRDmZCEP1UHguOheMQ+I6QzZ5zh7ArRgdPmK8w5kSdNG9Rk5dWyHF5ido=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6911
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.12;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

PnZ0ZF9wdF9lbmFibGVfZmFzdF9wYXRoKEludGVsSU9NTVVTdGF0ZSAqcywgdWludDE2X3Qgc291
cmNlX2lkKQ0KPj4gwqDCoMKgwqAgfQ0KPj4NCj4+IMKgwqDCoMKgIGlmICh2dGRfc3dpdGNoX2Fk
ZHJlc3Nfc3BhY2UodnRkX2FzKSA9PSBmYWxzZSkgew0KPj4gK8KgwqDCoMKgwqDCoMKgIFZURFBB
U0lEQ2FjaGVFbnRyeSAqcGNfZW50cnkgPSAmdnRkX2FzLT5wYXNpZF9jYWNoZV9lbnRyeTsNCj4N
Cj5JcyB0aGVyZSBhIHJlYXNvbiB3aHkgeW91IGRvbid0IGRlY2xhcmUgdGhpcyBpbiB0aGUgc2Vj
b25kIGlmPw0KPklmIG5vdCBhdCB0aGUgdG9wIG9mIHRoZSBmdW5jdGlvbiwgd2h5IHRoaXMgaW50
ZXJtZWRpYXJ5IGxldmVsPw0KDQpBaC4gVGhhbmtzLCBJIGp1c3QgbWlzc2VkIHRoYXQsIEknbGwg
c2VuZCBhIHYyLg0KDQo+DQo+UmVwb3J0ZWQtYnk6IENsZW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xl
bWVudC5tYXRoaWV1LS1kcmlmQGJ1bGwuY29tPg0KPlRlc3RlZC1ieTogQ2xlbWVudCBNYXRoaWV1
LS1EcmlmIDxjbGVtZW50Lm1hdGhpZXUtLWRyaWZAYnVsbC5jb20+DQo+DQo+PiArDQo+PiDCoMKg
wqDCoMKgwqDCoMKgIC8qIFdlIHN3aXRjaGVkIG9mZiBJT01NVSByZWdpb24gc3VjY2Vzc2Z1bGx5
LiAqLw0KPj4gwqDCoMKgwqDCoMKgwqDCoCBzdWNjZXNzID0gdHJ1ZTsNCj4+ICsNCj4+ICvCoMKg
wqDCoMKgwqDCoCBpZiAocy0+cm9vdF9zY2FsYWJsZSkgew0KPj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgcGNfZW50cnktPnBhc2lkX2VudHJ5ID0gKnBlOw0KPj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgcGNfZW50cnktPnZhbGlkID0gdHJ1ZTsNCj4+ICvCoMKgwqDCoMKgwqDCoCB9DQo+PiDC
oMKgwqDCoCB9DQo+Pg0KDQo=

