Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40206C3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 09:25:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUNNy-0001Gg-RR; Thu, 18 Jul 2024 05:25:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sUNNw-0001FD-F4
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 05:25:12 -0400
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sUNNr-0003D1-Ic
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 05:25:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1721294707; x=1752830707;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=e0b/nx2UxhDtyTXN0c3GhfseY/WjL9DM5osmOnxw+C8=;
 b=SsTf6PKexSWVbBEdH1D9+kM5d3qAx6oJzfLOWpG49mT29iX7U2ia4qBL
 Jl4HHGWcpdjz6u5P/DKXcX2x0Vvr2bQQ+F968m+kegf8dVgkXmMU4SWB9
 GxHdf9Svl6h/Q9jAbyuaJntMGDkeqpbcjVpciV03IIEiWNCy2/E54HAeU
 lpm4JwYv+s/r+dW/J0DwmAGUMZ7vEGbEPqTYUGJnUstON/1QAAN4Z6NfI
 6zAWKlP1k3k4Ko2Td5xFMpq8lBR/qBbKfHvYFoB5bojAZPOdTNjFt/cSW
 fwcruE5WB+XcquMCg6aKl0ltnW7cULYdNQx1NR6bfPQVMOt2axrr9NHGv A==;
X-IronPort-AV: E=Sophos;i="6.09,217,1716242400"; d="scan'208";a="16865862"
X-MGA-submission: =?us-ascii?q?MDHa9SV4KGaVaAV52eWClBKrfy4ECMv5pYn8FX?=
 =?us-ascii?q?+CzNAtMSBkSQ7EGjwcEHthVxgu1seKzzEpHlymsJR4c9Yf4Axx6hDFID?=
 =?us-ascii?q?gsACLZN769fmfSamXqM2BfyAqIMXYh2MNevKWkKk5/Ex5k5z8h2tEF5d?=
 =?us-ascii?q?LOYtJ6lheZvqCy9XSbihheGg=3D=3D?=
Received: from mail-am0eur02lp2240.outbound.protection.outlook.com (HELO
 EUR02-AM0-obe.outbound.protection.outlook.com) ([104.47.11.240])
 by smarthost4.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jul 2024 11:25:03 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QPu0ABh0BJemg9rTxsQ8BLhHu4dY0mzIBaGIRx0sd4GPsiXsC6oRua7tldzyYOLMpqWioJcLPR4jB/7Xfx/hxYRYluF2pMLDPXyqIqymIR5UDZYLYUesxgvXuyoR1DlXHzVG1THXGGJGln38FP1nXLiwVwbXPiigbiiTop4KEvSm7b8a6agWEQfiw8CStjpjgOnkyYDjDRGIZudbaCHx7UHNGVyqoX7acz9pNLITIJd0wI2vJ/PYvQVJ/PuCsyX6T2HU8bstL+F3MK8YKK+bYwM/ZgEjbDhjL6tmsz1W2RZ3omNneq4LmGc6Zmaha3TeuQNI7y7xW5fXzibQMv9Ojg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e0b/nx2UxhDtyTXN0c3GhfseY/WjL9DM5osmOnxw+C8=;
 b=RLLyo51iP1OkPnAfwhrs2VB0tqcPoFB9fE7egT6JUrAF+unEEr+M+HnJSZvWY+EJ6xUC4Px2SUP2b4CzvDsBfwJrhy6QMS2mAxUXkdc2a1qgxrqJCx0xZso8orOp+1eic2rneQIEqCN+5RkMSsZvTzWetBCvPVoeWaOx6adyNS2yGZPugdY2aY5l+8s8yYL0o+GEPhJK2EMcihBLYHWM2GM6SFdc+hR31FG7JLZn3r4DXSBGfp/9PaKihI0yv+gVgsQvVx3j5yb1sVQyMGw4VlHiDmdlDJw9k+0APxhzvklTXdsUsn+cgDQol2BIdmF9S9IG8AZ3qyrtWqH6M5N+vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e0b/nx2UxhDtyTXN0c3GhfseY/WjL9DM5osmOnxw+C8=;
 b=r+nOQ3Y9H21MJL6bX7iM5z0/ix49b6dGeSwOEwKW4WohnjOUyGniCGhKOhOoe/9LDJBUCW0sbRaRD90faSsZF+GN1g93sm4z5SQIG0McaZTh+4Fr5L448bU8nyBmSsWf3jkatgxF7o31cCnPnSO/lJCfMsdRJTYOwtGHAZgCrgjWcLfyx0TGyqo/Oo4yydCSBJb7vkkdaEgKjYntw5D3jGWly7wU3MxUCqz5T2I4LUsrWcPtofJjFMh8rDhTyERIdX2AvcpSBTTP1MrcZ8HinhaJ42Rdfi700zi53lR7tDxhEh4NJmuy2LQRwpFlCcWDLMJmTZsLxqr4Y1+Cqc0HvQ==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by PAWPR07MB9323.eurprd07.prod.outlook.com (2603:10a6:102:2f1::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Thu, 18 Jul
 2024 09:25:02 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%6]) with mapi id 15.20.7784.016; Thu, 18 Jul 2024
 09:25:01 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "chao.p.peng@intel.com"
 <chao.p.peng@intel.com>, Yi Sun <yi.y.sun@linux.intel.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard
 Henderson <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>
Subject: Re: [PATCH v1 16/17] intel_iommu: Modify x-scalable-mode to be string
 option
Thread-Topic: [PATCH v1 16/17] intel_iommu: Modify x-scalable-mode to be
 string option
Thread-Index: AQHa2Otd8x/JjCr9h06CPB+8aOnt57H8NuOA
Date: Thu, 18 Jul 2024 09:25:01 +0000
Message-ID: <ce514028-3ed6-4aba-bfb1-75f52dfc0934@eviden.com>
References: <20240718081636.879544-1-zhenzhong.duan@intel.com>
 <20240718081636.879544-17-zhenzhong.duan@intel.com>
In-Reply-To: <20240718081636.879544-17-zhenzhong.duan@intel.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|PAWPR07MB9323:EE_
x-ms-office365-filtering-correlation-id: 84f5b6ed-92a7-4641-694f-08dca70b8055
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?MzhkcUFIYk5IR3dtYUQwbFA0VG5oN2xibTFIZysrOHRSbytHcmtaRVFXZ05O?=
 =?utf-8?B?MnlhbEZwaDFQUlVlNGMrSGJDaFViTHd1NlNxRDFYUjA5NFlKTUxUd1BCeVo2?=
 =?utf-8?B?WGMvQkthZ3hmRkJkajRjM1NsUWFyeEtsdEpaWlA5U0RaOThkNlFaUDRkOTdG?=
 =?utf-8?B?N0hXSFZ1L2QzamxldmNQNTlJKytiMWprcWg0bHRBZ1ZSM2FpUzlHb1B0NEpS?=
 =?utf-8?B?b3B1RENwaVZzeW9WNy9YeS9TSm5FOHF5V21lVlNla0txU3E5SHF3cTZHT09u?=
 =?utf-8?B?MlpCd1EvOE4rcVNUZ0xKS0k1T1UxNjJHK0xoZGRjVU1XdkVRWFhCOWJGM3BS?=
 =?utf-8?B?QmlqQy9nUUQxL1pVZUtsc2ZuK0tpaFJQWXBySVMxTGw0T1VRNitMOWNHYmRn?=
 =?utf-8?B?bnpkYklQTlNicFlBMmJiUWVUbTlpakxKY2ZnL1RWQnFpQTl0aWxFZ2g3cmxn?=
 =?utf-8?B?Qmd3K211MlkrakkrdDlCK1pNNnpuYUVoaS9MQWs5UWRhaGdFbVBOVXJpK0NB?=
 =?utf-8?B?RzBnU2JVd3dXblAzdWpDbklXckNvNkVYT1NpQTBYYitVNFQwVUhKYmZtSFBP?=
 =?utf-8?B?VWhHdVVpb2JIZTRQU2dpZkd5c0xXMUpwR3FzYjVnM3pxNlRFVHJpcC9sbHNQ?=
 =?utf-8?B?QzhEMGZhSldpdVdkZXAzejBiUzVVeXdvK20wNHNiRmdYSm8rVTV4ZThhOHAr?=
 =?utf-8?B?MS9qUCt2aU4yQ282WEdwVEZUMTlCSm5ObU5hQVozeWNicW1ZMVNubmtTcU8v?=
 =?utf-8?B?dWVuUFlPc1ByRjBNUTNuaTBXVnRDZVpTcFpkSnJ0WnpJRC9zV05UdGhKOHla?=
 =?utf-8?B?RGJ3MjJZcDNPVlB2SVJKREFrYmR1YzBJUWJyT1lsQWVzTWFPUm1hTFNpcUdl?=
 =?utf-8?B?NlNHNjUyNHZYcWpCSVZFN0tvVjdROGY4Yms0bUtyY3Q2bzVGNm9DWWs1d3U3?=
 =?utf-8?B?MlF2eWtZdlMrT3VpMEdxWHhYTEg4aDNtV3oyQ1BCcnBGRHhaenpZVVZ5dWNz?=
 =?utf-8?B?QmR2bnhBZnU4NzVhY1h4ekx1bk1MY1RHL0pvM0NOY3Y5cHJBT0VNMDRCeVhs?=
 =?utf-8?B?SU45cG04YkN3ZVBselRJWjFlcWFiQ0haWHhtdFlrN0dOWk5VZnBFRitjSGF5?=
 =?utf-8?B?c1A2WEdHdnoxNFJKV2ZDbXVteFZDQm40Y09IV0k3VnhnRHJML1BZMVpQa002?=
 =?utf-8?B?cnZtelR4RVpiR05wKzNvMkVzSVBVMVEzUWY5alp2ajRmRjlGWjV3eGhqdmRs?=
 =?utf-8?B?S1RyR0JFSGdDUkVvWnMxeUVJQVpXaXpCOVpLL3BMQVZxbmFLNTMvcjliTGhx?=
 =?utf-8?B?NWUyNGpveWpqSTdOT1hmSW5yN3d3dUlwOFRORUYwRVJtS3ZKeGFzeXUxWjli?=
 =?utf-8?B?dDN0TmgvdzFxdTk3NU1JeEdTaXZnaW1odjlNZGRCV2lrTEYvVFBWQUlodEpG?=
 =?utf-8?B?bk5YdTlHYzBlUXlpeHcrMHN0SnI5YWlndjNqdmdKUEp0MVM5aUZmU1djNVEx?=
 =?utf-8?B?aHZIUDlOZG9yUGpsUm9pdWU5ekoyV0RzbHV3T3gwMDZGeGFkc0hBWXFFU0dR?=
 =?utf-8?B?SUhpRVJIcFVYeXI4dXlPdW03UjYxOS83WXdNZWNpZDJMU1hKNWJPZitPTDlH?=
 =?utf-8?B?TStjcDUyYVNiMzBuNW1PUGpTaHZHakR6K0Q5OHJpUHEyMXhETHZ1UUh2WjV3?=
 =?utf-8?B?TVJkVTMvWmJVKzc4N3BZUTZhSFp2T05VOGRabnZJWUVZSDkwdlFub1hxdEN4?=
 =?utf-8?B?emNtOGdlcDlSbHlxNXpGUWJPQjRwSEVKN1YvRlhyaGVuWG9tNVdsZVJYQS9T?=
 =?utf-8?B?V3J5S3lhYW16T05PdjlhQXlOWVNITkc2NHh6VjhPdGFOUWJrYzcrWkx1OFVX?=
 =?utf-8?B?a2JPSnM3SkRZcFBRek5vRzZEN3NwaEIrWVovOCt1NEFvYVE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NWpYSFV5T1hMOHlwZXh0UXQxZFZtWFQ3aElKdWZQUmFsTTQrcUVsbFN6Q1Iv?=
 =?utf-8?B?QUNUb0o5TFFlT2FtRFcvUGMwcUNQcHl6MlNVQzdXOE92Q1ltaUptZlJJclFz?=
 =?utf-8?B?MU9JSGZwalJ5a09iUllvSE0rU05iOEp0cUVjWThKSHhvZG1tNkZkd2tkeThF?=
 =?utf-8?B?YTV0N2JkMWxQRm1TY1FmMWg4N3VQU0YzUWxhOXhPV3FMR01tOVUwaDgwdSt3?=
 =?utf-8?B?eUZ1T2s3ZlRraWRobVhmaDlyNUM0eCtRaFFjZXZETWY0QWRMOHllc3d3OTVw?=
 =?utf-8?B?K0xieVBFeFBHdytKL3dzdVBIN0NidHB4WGxwNXdyUnYxU2xVUDFpbSsxZEZp?=
 =?utf-8?B?a0hlMzdHbUlnTjRRaUJhSklrTjFmTzhPVU8vSVN3VDFyWElWSitqQjJYRHVh?=
 =?utf-8?B?aTNtZlJZZFJQN3FPS1NVOEJZa1kxcmlvRFFsUHBDWXF0N0doMFRuME13S2hJ?=
 =?utf-8?B?RVRKcjJsQ3V0bUlrN0kycVpUT2l5MFlLSzBOb1R1cFczKzJwelFsSndNa1Z6?=
 =?utf-8?B?Vm84d3ZNc1daOVV3SSszOC9mVGZSWERIR1NWQnhqNFZzdW80cGVCYkNvMUNh?=
 =?utf-8?B?VUJWd1hHRHM0Vk8yblJyVUVDWnlhU0owY25Pak42UE02WW14OG5mVTl5WU1E?=
 =?utf-8?B?dTRkVTNjVlBtUGM2eUpLdXlubENXQWk4NUN2dnlPS05zZUFlcGNVUmlrdkFF?=
 =?utf-8?B?ZzNtcXhjWTNwcURDZ25aUGNkMzdvcHJEODlETHVHeU9oTkN1TmlDelpHb0Nm?=
 =?utf-8?B?NWdTQkVRQUlmWTJvQzhOdy9URkQ1NFM2OWN5K2tJNVdEcGdidVZvY0dsNHVp?=
 =?utf-8?B?cFZ3Q0xoLzdNS1VTdjFPcHVxUUpUWlN6ZVNib1JnMDI0UGFNS2QvSlk4M2p2?=
 =?utf-8?B?bzJ5S0VCWStWNXloZExTajN0K21DeEtrWEI2OVFrSEViS09VWjVXUkVPQnZw?=
 =?utf-8?B?NWVSYUljcTYzQXdNZzZWT0t3UFlWM0tkMXFubE1EMGhFYkhCSjh0R2FyQ3N5?=
 =?utf-8?B?ZXAwUExNWFByNVFMT28zcHg1YmluZythMjdtZjFIL1gyRXh3cDNGNDhoY1BT?=
 =?utf-8?B?ZEZURldjUlNqV1k1MnZWcHFHanQ5eVFzQnpEQUJ2a3ZVclplT2tuTldjVXhz?=
 =?utf-8?B?YU0vZENOUUkvRUJOOW0zMXM1WUxndmE1Mk4rd0cyTDc1Z3JsUGtpU3BpQ1Rv?=
 =?utf-8?B?dU1ZM29ONDcvbXlCQXJjZHdSZ1VmTWxidnlTeENjSzVQdmVnVUcyZjBhRDN0?=
 =?utf-8?B?Q1VvSFNEdW5oZzBQQ2VMOGwrS0pTdWNCamUzem04T2ZRd0t5T0c0ZXFSZitk?=
 =?utf-8?B?RExNWWZlZnl3Q2VPaGpsa0R2QkRLRlltT1R4aEFQZmZXVEhVZlh2RmZzVGtt?=
 =?utf-8?B?WEJwT2JSMlhRYlBBd1ZmZFg1RTZoZ3Rvbmt1WDJWK1dBcHJnQVpCZUhPQ0Vz?=
 =?utf-8?B?OVRVYWRQa2hEbjJlWTNHVThQOW52dk01T1JyWmZYYXYwNlBUKzBSZy9TTUpP?=
 =?utf-8?B?MjROc2NBcmczUXZMaXNDekU1ckFNY0pLQjFWN283MHlOYlBDWWhmczhlRkRU?=
 =?utf-8?B?VVZZUHdqTGtZRk5UdXdFR2RFZGptWlBCOVBxK2JhazVteUZtMit1V3orK0cr?=
 =?utf-8?B?c0UrN0tQbW45bENscFliV2hCeWpZWVIwNW1nU2pST1FSLy9zZVhLNER2d2xB?=
 =?utf-8?B?T1M2cUdVSHkyclA3VW13NWZOQ0Z1ekcvVWJQc3Vpc08vU3RmaFB5SjBmWnkz?=
 =?utf-8?B?YmZLcStsRktYdlNUMnVpWEVuNjNGMENna1FkQm1zSTRwUVI5MUdJRHU1ZEMx?=
 =?utf-8?B?bGZISm05Z29kbXloVXVVRmFJYnFZdUt3cjNSMU9GVVFrT2pXWGVqVEhhL00z?=
 =?utf-8?B?Umgzd0EwSnM0OHJWYnVCeTRkdEN1R0k5eVUwdlpmS082UWZPNmRlMm9hQ0gw?=
 =?utf-8?B?cjhydVFUdHZkc2o0VitZdG1nR0N2eS9WTmhEUHhtTHlKL2NnbXhxVGJLZG0w?=
 =?utf-8?B?OWxaajdWcHduaU1XODJuSUhEOEZFTWtRdlNMWlo4U3hFQzFQc1ZiN01ETXFz?=
 =?utf-8?B?ZEhLQXhjamZRVzBMdHNQR1M0Sm9sRVVLWlhVYUNPS1puQVRWT3QxYiszWGJP?=
 =?utf-8?B?Rld1eXRLclA0SzVPWmdMVHVuNVl3UHAxa3gwcVlIWUVGbmxHUkZKSGNiRTcz?=
 =?utf-8?Q?3fPGxfVkKrz8h5zb0BLgvB4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CD0585A881FF7D47B42BC07DA25CAA55@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84f5b6ed-92a7-4641-694f-08dca70b8055
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2024 09:25:01.9116 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MQVQRno8jfsB4WmpZ/WF7TIQJ1lFS5Wo0B4Ef/TFPoU1IVvTvskncOJOv5MuujVZv5Lh5AWMy5qPB+TvoMIjNjJ9iH8j4hQoxvqqj7Vpibugi/UjTAdrk5nXFAK5Z8yp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR07MB9323
Received-SPF: pass client-ip=80.78.11.85;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost4.eviden.com
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

DQoNCk9uIDE4LzA3LzIwMjQgMTA6MTYsIFpoZW56aG9uZyBEdWFuIHdyb3RlOg0KPiBDYXV0aW9u
OiBFeHRlcm5hbCBlbWFpbC4gRG8gbm90IG9wZW4gYXR0YWNobWVudHMgb3IgY2xpY2sgbGlua3Ms
IHVubGVzcyB0aGlzIGVtYWlsIGNvbWVzIGZyb20gYSBrbm93biBzZW5kZXIgYW5kIHlvdSBrbm93
IHRoZSBjb250ZW50IGlzIHNhZmUuDQo+DQo+DQo+IEZyb206IFlpIExpdSA8eWkubC5saXVAaW50
ZWwuY29tPg0KPg0KPiBJbnRlbCBWVC1kIDMuMCBpbnRyb2R1Y2VzIHNjYWxhYmxlIG1vZGUsIGFu
ZCBpdCBoYXMgYSBidW5jaCBvZiBjYXBhYmlsaXRpZXMNCj4gcmVsYXRlZCB0byBzY2FsYWJsZSBt
b2RlIHRyYW5zbGF0aW9uLCB0aHVzIHRoZXJlIGFyZSBtdWx0aXBsZSBjb21iaW5hdGlvbnMuDQo+
IFdoaWxlIHRoaXMgdklPTU1VIGltcGxlbWVudGF0aW9uIHdhbnRzIHRvIHNpbXBsaWZ5IGl0IGZv
ciB1c2VyIGJ5IHByb3ZpZGluZw0KPiB0eXBpY2FsIGNvbWJpbmF0aW9ucy4gVXNlciBjb3VsZCBj
b25maWcgaXQgYnkgIngtc2NhbGFibGUtbW9kZSIgb3B0aW9uLiBUaGUNCj4gdXNhZ2UgaXMgYXMg
YmVsb3c6DQo+DQo+ICItZGV2aWNlIGludGVsLWlvbW11LHgtc2NhbGFibGUtbW9kZT1bImxlZ2Fj
eSJ8Im1vZGVybiJ8Im9mZiJdIg0KPg0KPiAgIC0gImxlZ2FjeSI6IGdpdmVzIHN1cHBvcnQgZm9y
IHN0YWdlLTIgcGFnZSB0YWJsZQ0KPiAgIC0gIm1vZGVybiI6IGdpdmVzIHN1cHBvcnQgZm9yIHN0
YWdlLTEgcGFnZSB0YWJsZQ0KPiAgIC0gIm9mZiI6IG5vIHNjYWxhYmxlIG1vZGUgc3VwcG9ydA0K
PiAgIC0gIGlmIG5vdCBjb25maWd1cmVkLCBtZWFucyBubyBzY2FsYWJsZSBtb2RlIHN1cHBvcnQs
IGlmIG5vdCBwcm9wZXINCj4gICAgICBjb25maWd1cmVkLCB3aWxsIHRocm93IGVycm9yDQpzL3By
b3Blci9wcm9wZXJseQ0KTWF5YmUgd2UgY291bGQgc3BsaXQgYW5kIHJlcGhyYXNlIHRoZSBsYXN0
IGJ1bGxldCBwb2ludCB0byBtYWtlIGl0IGNsZWFyIA0KdGhhdCAib2ZmIiBpcyBlcXVpdmFsZW50
IHRvIG5vdCB1c2luZyB0aGUgb3B0aW9uIGF0IGFsbA0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBZaSBM
aXUgPHlpLmwubGl1QGludGVsLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogWWkgU3VuIDx5aS55LnN1
bkBsaW51eC5pbnRlbC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IFpoZW56aG9uZyBEdWFuIDx6aGVu
emhvbmcuZHVhbkBpbnRlbC5jb20+DQo+IC0tLQ0KPiAgIGluY2x1ZGUvaHcvaTM4Ni9pbnRlbF9p
b21tdS5oIHwgIDEgKw0KPiAgIGh3L2kzODYvaW50ZWxfaW9tbXUuYyAgICAgICAgIHwgMjQgKysr
KysrKysrKysrKysrKysrKysrKystDQo+ICAgMiBmaWxlcyBjaGFuZ2VkLCAyNCBpbnNlcnRpb25z
KCspLCAxIGRlbGV0aW9uKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2h3L2kzODYvaW50
ZWxfaW9tbXUuaCBiL2luY2x1ZGUvaHcvaTM4Ni9pbnRlbF9pb21tdS5oDQo+IGluZGV4IDQ4MTM0
YmRhMTEuLjY1MDY0MTU0NGMgMTAwNjQ0DQo+IC0tLSBhL2luY2x1ZGUvaHcvaTM4Ni9pbnRlbF9p
b21tdS5oDQo+ICsrKyBiL2luY2x1ZGUvaHcvaTM4Ni9pbnRlbF9pb21tdS5oDQo+IEBAIC0yNjMs
NiArMjYzLDcgQEAgc3RydWN0IEludGVsSU9NTVVTdGF0ZSB7DQo+DQo+ICAgICAgIGJvb2wgY2Fj
aGluZ19tb2RlOyAgICAgICAgICAgICAgLyogUk8gLSBpcyBjYXAgQ00gZW5hYmxlZD8gKi8NCj4g
ICAgICAgYm9vbCBzY2FsYWJsZV9tb2RlOyAgICAgICAgICAgICAvKiBSTyAtIGlzIFNjYWxhYmxl
IE1vZGUgc3VwcG9ydGVkPyAqLw0KPiArICAgIGNoYXIgKnNjYWxhYmxlX21vZGVfc3RyOyAgICAg
ICAgLyogUk8gLSBhZG1pbidzIFNjYWxhYmxlIE1vZGUgY29uZmlnICovDQo+ICAgICAgIGJvb2wg
c2NhbGFibGVfbW9kZXJuOyAgICAgICAgICAgLyogUk8gLSBpcyBtb2Rlcm4gU00gc3VwcG9ydGVk
PyAqLw0KPiAgICAgICBib29sIHNub29wX2NvbnRyb2w7ICAgICAgICAgICAgIC8qIFJPIC0gaXMg
U05QIGZpbGVkIHN1cHBvcnRlZD8gKi8NCj4NCj4gZGlmZiAtLWdpdCBhL2h3L2kzODYvaW50ZWxf
aW9tbXUuYyBiL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KPiBpbmRleCAyODA0YzM2MjhhLi4xNGQw
NWZjZTFkIDEwMDY0NA0KPiAtLS0gYS9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4gKysrIGIvaHcv
aTM4Ni9pbnRlbF9pb21tdS5jDQo+IEBAIC0zNzcwLDcgKzM3NzAsNyBAQCBzdGF0aWMgUHJvcGVy
dHkgdnRkX3Byb3BlcnRpZXNbXSA9IHsNCj4gICAgICAgREVGSU5FX1BST1BfVUlOVDgoImF3LWJp
dHMiLCBJbnRlbElPTU1VU3RhdGUsIGF3X2JpdHMsDQo+ICAgICAgICAgICAgICAgICAgICAgICAg
IFZURF9IT1NUX0FXX0FVVE8pLA0KPiAgICAgICBERUZJTkVfUFJPUF9CT09MKCJjYWNoaW5nLW1v
ZGUiLCBJbnRlbElPTU1VU3RhdGUsIGNhY2hpbmdfbW9kZSwgRkFMU0UpLA0KPiAtICAgIERFRklO
RV9QUk9QX0JPT0woIngtc2NhbGFibGUtbW9kZSIsIEludGVsSU9NTVVTdGF0ZSwgc2NhbGFibGVf
bW9kZSwgRkFMU0UpLA0KPiArICAgIERFRklORV9QUk9QX1NUUklORygieC1zY2FsYWJsZS1tb2Rl
IiwgSW50ZWxJT01NVVN0YXRlLCBzY2FsYWJsZV9tb2RlX3N0ciksDQo+ICAgICAgIERFRklORV9Q
Uk9QX0JPT0woInNub29wLWNvbnRyb2wiLCBJbnRlbElPTU1VU3RhdGUsIHNub29wX2NvbnRyb2ws
IGZhbHNlKSwNCj4gICAgICAgREVGSU5FX1BST1BfQk9PTCgieC1wYXNpZC1tb2RlIiwgSW50ZWxJ
T01NVVN0YXRlLCBwYXNpZCwgZmFsc2UpLA0KPiAgICAgICBERUZJTkVfUFJPUF9CT09MKCJkbWEt
ZHJhaW4iLCBJbnRlbElPTU1VU3RhdGUsIGRtYV9kcmFpbiwgdHJ1ZSksDQo+IEBAIC00Njg2LDYg
KzQ2ODYsMjggQEAgc3RhdGljIGJvb2wgdnRkX2RlY2lkZV9jb25maWcoSW50ZWxJT01NVVN0YXRl
ICpzLCBFcnJvciAqKmVycnApDQo+ICAgICAgICAgICB9DQo+ICAgICAgIH0NCj4NCj4gKyAgICBp
ZiAocy0+c2NhbGFibGVfbW9kZV9zdHIgJiYNCj4gKyAgICAgICAgKHN0cmNtcChzLT5zY2FsYWJs
ZV9tb2RlX3N0ciwgIm9mZiIpICYmDQo+ICsgICAgICAgICBzdHJjbXAocy0+c2NhbGFibGVfbW9k
ZV9zdHIsICJtb2Rlcm4iKSAmJg0KPiArICAgICAgICAgc3RyY21wKHMtPnNjYWxhYmxlX21vZGVf
c3RyLCAibGVnYWN5IikpKSB7DQo+ICsgICAgICAgIGVycm9yX3NldGcoZXJycCwgIkludmFsaWQg
eC1zY2FsYWJsZS1tb2RlIGNvbmZpZywiDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgIlBs
ZWFzZSB1c2UgXCJtb2Rlcm5cIiwgXCJsZWdhY3lcIiBvciBcIm9mZlwiIik7DQo+ICsgICAgICAg
IHJldHVybiBmYWxzZTsNCj4gKyAgICB9DQo+ICsNCj4gKyAgICBpZiAocy0+c2NhbGFibGVfbW9k
ZV9zdHIgJiYNCj4gKyAgICAgICAgIXN0cmNtcChzLT5zY2FsYWJsZV9tb2RlX3N0ciwgImxlZ2Fj
eSIpKSB7DQo+ICsgICAgICAgIHMtPnNjYWxhYmxlX21vZGUgPSB0cnVlOw0KPiArICAgICAgICBz
LT5zY2FsYWJsZV9tb2Rlcm4gPSBmYWxzZTsNCj4gKyAgICB9IGVsc2UgaWYgKHMtPnNjYWxhYmxl
X21vZGVfc3RyICYmDQo+ICsgICAgICAgICFzdHJjbXAocy0+c2NhbGFibGVfbW9kZV9zdHIsICJt
b2Rlcm4iKSkgew0KPiArICAgICAgICBzLT5zY2FsYWJsZV9tb2RlID0gdHJ1ZTsNCj4gKyAgICAg
ICAgcy0+c2NhbGFibGVfbW9kZXJuID0gdHJ1ZTsNCj4gKyAgICB9IGVsc2Ugew0KPiArICAgICAg
ICBzLT5zY2FsYWJsZV9tb2RlID0gZmFsc2U7DQo+ICsgICAgICAgIHMtPnNjYWxhYmxlX21vZGVy
biA9IGZhbHNlOw0KPiArICAgIH0NCj4gKw0KPiAgICAgICBpZiAocy0+YXdfYml0cyA9PSBWVERf
SE9TVF9BV19BVVRPKSB7DQo+ICAgICAgICAgICBpZiAocy0+c2NhbGFibGVfbW9kZXJuKSB7DQo+
ICAgICAgICAgICAgICAgcy0+YXdfYml0cyA9IFZURF9IT1NUX0FXXzQ4QklUOw0KPiAtLQ0KPiAy
LjM0LjENCj4NCkxHVE0NCg==

