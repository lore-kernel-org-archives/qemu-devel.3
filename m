Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49DD4C25B5C
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 15:34:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2YNO-0003ih-LO; Thu, 02 May 2024 11:29:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s2YNM-0003i3-Tn
 for qemu-devel@nongnu.org; Thu, 02 May 2024 11:29:36 -0400
Received: from smarthost3.eviden.com ([80.78.11.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s2YNI-00060W-KC
 for qemu-devel@nongnu.org; Thu, 02 May 2024 11:29:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1714663772; x=1746199772;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=0dyCf//UOltd40tgWVe301nYDvZlQODv3yCaC6nBVp4=;
 b=mgcBf9kQq69iZITSJAnhtndR++rG8mTIpEG1o2y8Xh1vgr0bymhmUsxT
 7CYXkMoVicutC1WTzpEydx5Qc/IhpkJkIZUYO3w9xWnvf/OWdq73hNMjD
 HMVvRmVZ5/3QN8ahnQcH9maq1qa2VvRb6ySg3UUXTC9rOIYttLD3a+A1H
 LM+t1zrXnM+YluKMOMZ9MnOKN3CJ5bvE6wXhL0ceV5+74FRYw6CREppmc
 2ZM2CDh0EoQjk86BdmhpMxipkixzIeYnh8M2okFCaWLo9vqX4EkW7EV0U
 jPpLoU3rkK50eLgjKHP3E0u8Sb2lYhvlHJXGZuqDcLk82Sl86aZR+OkmU w==;
X-IronPort-AV: E=Sophos;i="6.07,247,1708383600"; d="scan'208";a="11730622"
X-MGA-submission: =?us-ascii?q?MDGQsfRvSsSaehLIfacEuktvZvdiwWESRB9SPA?=
 =?us-ascii?q?MIjQKpH88tJ7pg50BzfPWToXVDjel8WgkrQaeV+bQNK8Pg7ZaVpwJJIA?=
 =?us-ascii?q?Hx3CQN3LU+jC3f+etr0ovbxgnNcb8YEOfKwOwpULn1OtF5YxJzWb7t1f?=
 =?us-ascii?q?a/IIIaqPy4y4ThJKwv9h4qAA=3D=3D?=
Received: from mail-am6eur05lp2105.outbound.protection.outlook.com (HELO
 EUR05-AM6-obe.outbound.protection.outlook.com) ([104.47.18.105])
 by smarthost3.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 May 2024 17:29:23 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QsA9s/DAunlOnu+yWLcQnDOm47fKNoXLLTp17WtJd0KYLayciIOHWTq2xyoorPfWKY/p3XTIQG2sxeYeJCT/cYE8xRfyobss3kvSehbCFrhQ7RAQ2eKFV0WwQ+4ZpCOapQ9RLT544eiANTBxAaxegCHrPnIYcPXAp6NB0PFo1KSrgaCTE5qxrkzNefsI9yJ/3KrFtg+UQ7CZtaNPPJD1LsyBEqUSh8yLGerxQoyMCUOPcB35KUMLDCPTdbWNqVQg6D38EQW31eBuEiFZZdIVaqpUtrPIybTAMFfXAYDZ3n6UCmPnB/cwWmBp7qXJi6+4iuxVqZdD/4UwOxsY9bPYOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0dyCf//UOltd40tgWVe301nYDvZlQODv3yCaC6nBVp4=;
 b=RORHlQwZPuqEqccJ239FVOJOCsjLsT8jig9WG4S6L06mH+UPoED5f2oreVDkVYifhJ/3hpjINTjKkJ5GfjY+WDJUBIDxnXP72Cht2bWI2lNzkrjmqmzle+aCgqeI7ktB5jSiHcrpzk1B5ME9UrWH2z6Wc3Si9YcAxurEFdHQZpgqLqnieYZeWe6e87/yZkYtB1STB6CzFOTqV5J2xStb5RjjEk4y4Gw5lx4OFqmytKGKUuJZrQ1qiUCh9t+0SZW9E2bNbuUXvtwvlc3S8e8uXJzG8mmUNGyvaUiLzqO/YZrZ7Kc/F0Mp+sNP8tZTCwVPVeMVj3YQDawKMNGCPGZZRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AS8PR07MB7768.eurprd07.prod.outlook.com (2603:10a6:20b:351::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Thu, 2 May
 2024 15:29:22 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%4]) with mapi id 15.20.7519.035; Thu, 2 May 2024
 15:29:22 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>, CLEMENT
 MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH ats_vtd v1 22/24] pci: add a pci-level API for ATS
Thread-Topic: [PATCH ats_vtd v1 22/24] pci: add a pci-level API for ATS
Thread-Index: AQHanKWBzgAlAYPHMkWgdFDysW7Q5A==
Date: Thu, 2 May 2024 15:29:21 +0000
Message-ID: <20240502152810.187492-23-clement.mathieu--drif@eviden.com>
References: <20240502152810.187492-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240502152810.187492-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AS8PR07MB7768:EE_
x-ms-office365-filtering-correlation-id: 86226a82-0315-4713-cd5c-08dc6abca441
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?a1NMSjJUVFExaW9mMXFBcDV1LzE5TEdlTTBQOHJodlJsZER3KzVXNXF3UWRa?=
 =?utf-8?B?bFQ5SzZwZG5Wa2FLcDFUVUUvbHF0aVFVZGlDVFRBVWtNWGN3UHEzVFJpTUFW?=
 =?utf-8?B?dXZqU0VGbWVXMzVvSjAra3BlaStaSVBobURPTlVERitGTElXSWZhZUh6Z2NQ?=
 =?utf-8?B?NXRHSk9HeXJLZnJnaFNMbFlmSkJsaTRtNzc4TCthdU16ZE01S2x0QWpLTHV1?=
 =?utf-8?B?QU4vYmhqaWUvWkFqcVVNTUdmbVNmRk9SQjVJeVV1N210K09xMTEzNjd6RWcx?=
 =?utf-8?B?OUdpL0t0aEJvMzNoRys0TDUwbnl4ZkVvV0ZXVHhqSW1SbzliaGgzalAyNDRq?=
 =?utf-8?B?UUR6ZzVsQ01WblNNNUVqL3hyeUtTc3pUc241dTZoU0pHWlV2TnFENkNhckla?=
 =?utf-8?B?cG9ORzhxNmk2VndHWVRJSy96bWd3VURVRXJsTzM1VCtVVysrYWJTYWN3cG1Q?=
 =?utf-8?B?OWQzZnArTTgvQUhFUWJwTHVpOFdnNDBsWktuN1ZPaWtsQjFib0czK2RtdGI4?=
 =?utf-8?B?Nm5ka1ZvdXA2WVROSU1PRFVGYUY0ak5UR0tUYUdMVDdzakdvcjRhV1ZGTXF1?=
 =?utf-8?B?M1oxTGE5OTlWbmNJc2FnekxvelVvQU4ySklGWEN5RWJLZnU3MjhZTUVQVTMz?=
 =?utf-8?B?K1pHZUJaeHBrWWpBcG95OCtVQ3RwUjFnS3hiUUJYenpsTzNjU1Z4RWxmdFRN?=
 =?utf-8?B?Y0llMFhlV1hqcGF5Rzl5TTJJTDRmbWFES3prTlM3NnZEVnYyWHprcXJBc2dB?=
 =?utf-8?B?NnBLZTRKdFAwWGw1cFk2QUVkR1kyclUwUGtnMUxJckRZSDY3clFndHhxamdV?=
 =?utf-8?B?eWZCbGhpeU1xaVFOTisrOW9Fbngwd2FrRHAxVlo2MjZqSTl0VGJocExraHlk?=
 =?utf-8?B?SWtobFAwL0x5Nkp4Q3J4L1o3eFhYQXRoalJ0cUVrajBHcFJ2WUcxY3F5Q05z?=
 =?utf-8?B?SDMwZUFvZm9kSVh5ckpsM0Z0QmRYTEIzTGFaQVBqSlY4dE82ZXE4VGlqZzY3?=
 =?utf-8?B?NkdkQU1VSlFSaExBSGVnbU9nWVlpeTA3Ujk0RFIzQkpJR2ZjR0RGV0ltOXE4?=
 =?utf-8?B?cXc1RndYdUQ1YjFVOVJIYWQrVTR4WTdEbTNFeEpKWHhBdjNZUEpQY0Vjc2Uy?=
 =?utf-8?B?b0htWGFFeU5LbFNWRDh3SWJTV2dBY2NtK2Eyenl1YTdjRUJ2K1oyNVlOS3VS?=
 =?utf-8?B?MlZWMkhCSGxpUEQrSytFaUUyQitxRGNiUHFWVHoyZHhxTkt3Uk1ud2I4QWZp?=
 =?utf-8?B?SDhzZUZtYkpDaDN4UDRBWk1UdG1BQU9JUklienVxUjVaUW53OUFvbUgvUG16?=
 =?utf-8?B?QlQ1ZCtzVEd4RlhUaWtyOFRvU1dydGo5WjVwRUljN0dCMzYwNUVHNm9HQ2tU?=
 =?utf-8?B?NkdNcFVmWXVrcmtRNkw1S2ZjODBucUVrM2hLWVRVbTUyanBkWmZUSVFpRkVu?=
 =?utf-8?B?ZXprYjJkRHgwUWNYcHk2bVRjSW1tbzF5cEN4RGZnc3kvWEtNc0szUkhyVVNt?=
 =?utf-8?B?dHFBT3RQUGhtNWRlL3FDbmxCWVUycURrVnNUSmpGcGhydWNPNFBiY2VRWkJ5?=
 =?utf-8?B?bUduZHVnTzFaRUowRUJVSGlrTUN4MTU1RWdXR0R5NTR2ZG5wN29uMGczY2NR?=
 =?utf-8?B?b1QvTjA0Zm1pbXc3dWcyc2FVdXBOazVKZmRhayt6WkR3WlBLaGdHSDVIb0Jz?=
 =?utf-8?B?eWk2ekx0eHgya2JtV0N6R1luK1VGOU9BdmlITzl4MXB0OTVONnQ5aVhqQmpo?=
 =?utf-8?B?WGRuQXNkSGJzN2lnc2F3YnNqWWdPcmF0TURVQUtNY1cxOTNiZzJUY2k5bnVK?=
 =?utf-8?B?WkxUYkN3dEdSbnRibFZTZz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WWVUazJmVkFEVWZiMFJYZC9mZ0ZmeVMvaExvbXVtdzdGMVJORm9Rd2prNmVq?=
 =?utf-8?B?d1czaGZYYmhhTlNzd0ZnV1BMWm0yYVhJQ2xwY1ozOHFmeGhTdGhzR1FNMjRU?=
 =?utf-8?B?VkdpeHUvWEF4VWVJaFFKZGZKOGpadUdDTzRFQTFoR0RuMWZPYThESk5xUm1R?=
 =?utf-8?B?OHhUT2dqSHhlTTl6cnkyejdjUHRjS2NZTWZjVnpEa2ZhWXVaeGNHS3BZR1Y5?=
 =?utf-8?B?ejlWbWZ2VVFuM25GQlBrd3FPTWRxVUFGUW4zemU2NnVkb2dWbm1yZzRNZFVS?=
 =?utf-8?B?VUR4SVVlVy80dHJ4aGMxSVk4UlR0cm8zUVl6MEo4TGJVaWRyUXpCdXlZd1J2?=
 =?utf-8?B?bm5tZWs5bENGQ2IvOTRYbzZqOG1wZkhiOVFKejJmUno3Y1BRMzVEb2RyOVdP?=
 =?utf-8?B?STloK254SFM1dTBxUUVQZk5KZnkrdUVJZFdKaFZSaFkrcGFjMytIbFZjMHFV?=
 =?utf-8?B?MjExMS9Rd093QnhpQXg3T1h4Y2VTcTFDQ2J1Nk93K0lyVDFDd0Y4b0NsalIz?=
 =?utf-8?B?T3lDUWNGbklORUZGT3Y2Y01XdCs3ZkxiNjRudTI5N1dUeGhjMXF4UHdSZlZo?=
 =?utf-8?B?elNSM0VsUDdXMmFvSitwMEM0TURGbkppUkJleUJiV2RIczRvQ2ljT0NTcFZt?=
 =?utf-8?B?azRacGdKY0szZnRsN25mUjJOQy83R1NUVzVEWWVFQk5tblN5NU03cnZ2cm9p?=
 =?utf-8?B?M3FxbVJxZVc4ZlBwbG5neGVUVUZwM0NDR1FHNU53RWpvckVGSHBIdDQraEY0?=
 =?utf-8?B?dHRJUDNucUhKT2F2LytGOHEybXAxS2EzdGp3ZzNXc3BGK3h3Y1BLMnp2SmlO?=
 =?utf-8?B?TVJCeGlOUlNoUHBBK28rSFBrVUZ6aU8yR1J2MGpyR09XNGZ4OHdqSzdJY1p0?=
 =?utf-8?B?bnV5OEVUU2JycEFXeEpxK2RhYlJQd2sreDMydm9aQzk0bWxsUG1ReEVXT0F0?=
 =?utf-8?B?QktvRWdPZ3RVT1g3SHF2YXZKNUVSMEdPMWY1dUJERDhEM2lYZHFrWkVpdU94?=
 =?utf-8?B?S3dheFNZR2w1QnNWRHZCdGRBSG5GRkNVV0RkSWVBZ3A4U0c2b0xVT1FkZUhh?=
 =?utf-8?B?T1ZTNU5TT1d6ZlpxR3lXV2VmR28rRjBiOWk5Qzlqdmh5a2R0R0NvSWpUOXFk?=
 =?utf-8?B?bThHM2N2WHRtSVUyQkVSRm94NkNmVDZMRW1adFlaRTNGSk1yeDRkS0RiS3Z0?=
 =?utf-8?B?M3d0a2Fjd0c0WW0vOGJTYy85UCsxL2hvK3oxTTBXY3o3SEZHNUQxS2o3OUky?=
 =?utf-8?B?eGdjQndCbDN5UDh1MmZsN3FyVTIrY2pEVXNROWU0WVZpelJhdlVoSUhBbkkz?=
 =?utf-8?B?ZEpYdjRRWEU1UVNZMmxDKzRaaitYbk5Lb0dDQUN3YzhLYnVtYnIzMzVuQWd6?=
 =?utf-8?B?Qjc4VkZhZVZScFpPVnA5ZmZrNmxLaXlHWVR4VS9tWXkvbFJqS2g5dDlvVVNE?=
 =?utf-8?B?ZkVUVVVBeU16eE4xZThlNVFlVGIrZW5SNC8yeEJPS0lNSTl4Z3lGd0xZUEFT?=
 =?utf-8?B?LzFENjlWelJpbUJOOHZ3UlhadHd4QWNLcTc1ZjVOZnkzZTdWVUtHVk5NTkgv?=
 =?utf-8?B?MjQxWXc5UDdYUWlEaDloMzEreVlrck1nNS8rMWZYenQ5RWFSWXVYRVNLYkJi?=
 =?utf-8?B?bERuSzRTWXp4am9kVWxEMjROZzM0SzNEbjY1ZWVhUk5PeThPcVNGNnpPNWVn?=
 =?utf-8?B?NnM2YjNMQmtZa3dsSjVBOW9kMzNoSWRDUXJ5emMrQmV5RE5IU1MraS9TK3B2?=
 =?utf-8?B?cVBWK2RpQm5jYWdyczhrWElvNzR2bVU5a3FzNzdqdCtQNDY4MjJxdndmdktu?=
 =?utf-8?B?bTlmbnpNaU1KMzROdkh2NWhEZUo1aWF4bTAyTFRTQWxCNDF6dEpDSWNuR1VK?=
 =?utf-8?B?OFp3WFZ5RlVlbzczVHM0YytPaXowTWg0bmk4clZSMWlpdytuazc2NDlyTDha?=
 =?utf-8?B?ZzNraFp2SFF1eURXaXQ5ZnVMM3JJWkh2NW1Fd1h4bUZBdXBVM004bFN1Qitl?=
 =?utf-8?B?dWtrS1hsNFBRa3NXQWl1Z3FaTTB1MUI1WkpabDlEczJtenlCdS9TS0RTN1lW?=
 =?utf-8?B?OVRncHJsUTlTcjRQKzRlR1BuS1oyYWlWV2tDSDlFRTlxYmpSZWpxSnJGdGM5?=
 =?utf-8?B?MUh3bkxUNXlLcG9vQXJGaVA1MzFiOHVKNnNDSWtHc3BIb3Y3SGYrM1hoRlpX?=
 =?utf-8?Q?xgyoW49m8yCRzEiaRxasxbk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6BF640420CC32443963EAF491B25EBC3@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86226a82-0315-4713-cd5c-08dc6abca441
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2024 15:29:21.8888 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yl/n3JGOMXxpUyLUZgx7FHFm4tIF0iBZfesjBRh17p58vUdnJHhYhagFgrDwOSQynEHvsyczPbp40iS9p5HzWLb622sJ9Onk5HfzCi10eWRZXjvV5AF+UlCYRIfWsoN2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7768
Received-SPF: pass client-ip=80.78.11.84;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost3.eviden.com
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

RGV2aWNlcyBpbXBsZW1lbnRpbmcgQVRTIGNhbiBzZW5kIHRyYW5zbGF0aW9uIHJlcXVlc3RzIHVz
aW5nDQpwY2lfYXRzX3JlcXVlc3RfdHJhbnNsYXRpb25fcGFzaWQuDQoNClRoZSBpbnZhbGlkYXRp
b24gZXZlbnRzIGFyZSBzZW50IGJhY2sgdG8gdGhlIGRldmljZSB1c2luZyB0aGUgaW9tbXUNCm5v
dGlmaWVyIG1hbmFnZWQgd2l0aCBwY2lfcmVnaXN0ZXJfaW9tbXVfdGxiX2V2ZW50X25vdGlmaWVy
IGFuZA0KcGNpX3VucmVnaXN0ZXJfaW9tbXVfdGxiX2V2ZW50X25vdGlmaWVyDQoNClNpZ25lZC1v
ZmYtYnk6IENsw6ltZW50IE1hdGhpZXUtLURyaWYgPGNsZW1lbnQubWF0aGlldS0tZHJpZkBldmlk
ZW4uY29tPg0KLS0tDQogaHcvcGNpL3BjaS5jICAgICAgICAgfCA0NCArKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrDQogaW5jbHVkZS9ody9wY2kvcGNpLmggfCA1MiArKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KIDIgZmlsZXMgY2hhbmdlZCwg
OTYgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvaHcvcGNpL3BjaS5jIGIvaHcvcGNpL3Bj
aS5jDQppbmRleCBkMTBjZGIzZDc1Li5mZWE5YjU3MDA2IDEwMDY0NA0KLS0tIGEvaHcvcGNpL3Bj
aS5jDQorKysgYi9ody9wY2kvcGNpLmMNCkBAIC0yODMzLDYgKzI4MzMsNTAgQEAgdm9pZCBwY2lf
ZGV2aWNlX3Vuc2V0X2lvbW11X2RldmljZShQQ0lEZXZpY2UgKmRldikNCiAgICAgfQ0KIH0NCiAN
Citzc2l6ZV90IHBjaV9hdHNfcmVxdWVzdF90cmFuc2xhdGlvbl9wYXNpZChQQ0lEZXZpY2UgKmRl
diwgdWludDMyX3QgcGFzaWQsDQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgYm9vbCBwcml2X3JlcSwgYm9vbCBleGVjX3JlcSwgaHdhZGRyIGFkZHIsDQorICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc2l6ZV90IGxlbmd0aCwgYm9vbCBu
b193cml0ZSwNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBJT01N
VVRMQkVudHJ5ICpyZXN1bHQsDQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgc2l6ZV90IHJlc3VsdF9sZW5ndGgsDQorICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgdWludDMyX3QgKmVycl9jb3VudCkNCit7DQorICAgIGFzc2VydChyZXN1
bHRfbGVuZ3RoKTsNCisgICAgSU9NTVVNZW1vcnlSZWdpb24gKmlvbW11X21yID0gcGNpX2Rldmlj
ZV9pb21tdV9tZW1vcnlfcmVnaW9uX3Bhc2lkKGRldiwNCisgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBwYXNpZCk7
DQorICAgIGlmICghaW9tbXVfbXIgfHwgIXBjaWVfYXRzX2VuYWJsZWQoZGV2KSkgew0KKyAgICAg
ICAgcmV0dXJuIC1FUEVSTTsNCisgICAgfQ0KKyAgICByZXR1cm4gbWVtb3J5X3JlZ2lvbl9pb21t
dV9hdHNfcmVxdWVzdF90cmFuc2xhdGlvbihpb21tdV9tciwgcHJpdl9yZXEsDQorICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGV4ZWNfcmVxLCBh
ZGRyLCBsZW5ndGgsDQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIG5vX3dyaXRlLCByZXN1bHQsDQorICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJlc3VsdF9sZW5ndGgsDQorICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGVycl9jb3VudCk7
DQorfQ0KKw0KK2ludCBwY2lfcmVnaXN0ZXJfaW9tbXVfdGxiX2V2ZW50X25vdGlmaWVyKFBDSURl
dmljZSAqZGV2LCB1aW50MzJfdCBwYXNpZCwNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBJT01NVU5vdGlmaWVyICpuKQ0KK3sNCisgICAgSU9NTVVNZW1vcnlSZWdp
b24gKmlvbW11X21yID0gcGNpX2RldmljZV9pb21tdV9tZW1vcnlfcmVnaW9uX3Bhc2lkKGRldiwN
CisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBwYXNpZCk7DQorICAgIGlmICghaW9tbXVfbXIpIHsNCisgICAgICAg
IHJldHVybiAtRVBFUk07DQorICAgIH0NCisgICAgcmV0dXJuIG1lbW9yeV9yZWdpb25fcmVnaXN0
ZXJfaW9tbXVfbm90aWZpZXIoTUVNT1JZX1JFR0lPTihpb21tdV9tciksIG4sDQorICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICZlcnJvcl9mYXRhbCk7DQor
fQ0KKw0KK2ludCBwY2lfdW5yZWdpc3Rlcl9pb21tdV90bGJfZXZlbnRfbm90aWZpZXIoUENJRGV2
aWNlICpkZXYsIHVpbnQzMl90IHBhc2lkLA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIElPTU1VTm90aWZpZXIgKm4pDQorew0KKyAgICBJT01NVU1lbW9yeVJl
Z2lvbiAqaW9tbXVfbXIgPSBwY2lfZGV2aWNlX2lvbW11X21lbW9yeV9yZWdpb25fcGFzaWQoZGV2
LA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHBhc2lkKTsNCisgICAgaWYgKCFpb21tdV9tcikgew0KKyAgICAg
ICAgcmV0dXJuIC1FUEVSTTsNCisgICAgfQ0KKyAgICBtZW1vcnlfcmVnaW9uX3VucmVnaXN0ZXJf
aW9tbXVfbm90aWZpZXIoTUVNT1JZX1JFR0lPTihpb21tdV9tciksIG4pOw0KKyAgICByZXR1cm4g
MDsNCit9DQorDQogdm9pZCBwY2lfc2V0dXBfaW9tbXUoUENJQnVzICpidXMsIGNvbnN0IFBDSUlP
TU1VT3BzICpvcHMsIHZvaWQgKm9wYXF1ZSkNCiB7DQogICAgIC8qDQpkaWZmIC0tZ2l0IGEvaW5j
bHVkZS9ody9wY2kvcGNpLmggYi9pbmNsdWRlL2h3L3BjaS9wY2kuaA0KaW5kZXggMTU4N2MxOGNk
OS4uZGMyNDdkMjRiZCAxMDA2NDQNCi0tLSBhL2luY2x1ZGUvaHcvcGNpL3BjaS5oDQorKysgYi9p
bmNsdWRlL2h3L3BjaS9wY2kuaA0KQEAgLTQ3MSw2ICs0NzEsNTggQEAgdm9pZCBwY2lfZGV2aWNl
X3Vuc2V0X2lvbW11X2RldmljZShQQ0lEZXZpY2UgKmRldik7DQogYm9vbCBwY2lfaW9tbXVfaW5p
dF9pb3RsYl9ub3RpZmllcihQQ0lEZXZpY2UgKmRldiwgdWludDMyX3QgcGFzaWQsDQogICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBJT01NVU5vdGlmaWVyICpuLCBJT01NVU5vdGlm
eSBmbik7DQogDQorLyoqDQorICogcGNpX2F0c19yZXF1ZXN0X3RyYW5zbGF0aW9uX3Bhc2lkOiBw
ZXJmb3JtIGFuIEFUUyByZXF1ZXN0DQorICoNCisgKiBSZXR1cm4gdGhlIG51bWJlciBvZiB0cmFu
c2xhdGlvbnMgc3RvcmVkIGluIEByZXN1bHQgaW4gY2FzZSBvZiBzdWNjZXNzLA0KKyAqIGEgbmVn
YXRpdmUgZXJyb3IgY29kZSBvdGhlcndpc2UuDQorICogLUVOT01FTSBpcyByZXR1cm5lZCB3aGVu
IHRoZSByZXN1bHQgYnVmZmVyIGlzIG5vdCBsYXJnZSBlbm91Z2ggdG8gc3RvcmUNCisgKiBhbGwg
dGhlIHRyYW5zbGF0aW9ucw0KKyAqDQorICogQGRldjogdGhlIEFUUy1jYXBhYmxlIFBDSSBkZXZp
Y2UNCisgKiBAcGFzaWQ6IHRoZSBwYXNpZCBvZiB0aGUgYWRkcmVzcyBzcGFjZSBpbiB3aGljaCB0
aGUgdHJhbnNsYXRpb24gd2lsbCBiZSBtYWRlDQorICogQHByaXZfcmVxOiBwcml2aWxlZ2VkIG1v
ZGUgYml0IChQQVNJRCBUTFApDQorICogQGV4ZWNfcmVxOiBleGVjdXRlIHJlcXVlc3QgYml0IChQ
QVNJRCBUTFApDQorICogQGFkZHI6IHN0YXJ0IGFkZHJlc3Mgb2YgdGhlIG1lbW9yeSByYW5nZSB0
byBiZSB0cmFuc2xhdGVkDQorICogQGxlbmd0aDogbGVuZ3RoIG9mIHRoZSBtZW1vcnkgcmFuZ2Ug
aW4gYnl0ZXMNCisgKiBAbm9fd3JpdGU6IHJlcXVlc3QgYSByZWFkLW9ubHkgYWNjZXNzIHRyYW5z
bGF0aW9uIChpZiBzdXBwb3J0ZWQgYnkgdGhlIElPTU1VKQ0KKyAqIEByZXN1bHQ6IGJ1ZmZlciBp
biB3aGljaCB0aGUgVExCIGVudHJpZXMgd2lsbCBiZSBzdG9yZWQNCisgKiBAcmVzdWx0X2xlbmd0
aDogcmVzdWx0IGJ1ZmZlciBsZW5ndGgNCisgKiBAZXJyX2NvdW50OiBudW1iZXIgb2YgdW50cmFu
c2xhdGVkIHN1YnJlZ2lvbnMNCisgKi8NCitzc2l6ZV90IHBjaV9hdHNfcmVxdWVzdF90cmFuc2xh
dGlvbl9wYXNpZChQQ0lEZXZpY2UgKmRldiwgdWludDMyX3QgcGFzaWQsDQorICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYm9vbCBwcml2X3JlcSwgYm9vbCBleGVjX3Jl
cSwgaHdhZGRyIGFkZHIsDQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgc2l6ZV90IGxlbmd0aCwgYm9vbCBub193cml0ZSwNCisgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBJT01NVVRMQkVudHJ5ICpyZXN1bHQsDQorICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc2l6ZV90IHJlc3VsdF9sZW5ndGgsDQorICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdWludDMyX3QgKmVycl9jb3Vu
dCk7DQorDQorLyoqDQorICogcGNpX3JlZ2lzdGVyX2lvbW11X3RsYl9ldmVudF9ub3RpZmllcjog
cmVnaXN0ZXIgYSBub3RpZmllciBmb3IgY2hhbmdlcyB0bw0KKyAqIElPTU1VIHRyYW5zbGF0aW9u
IGVudHJpZXMgaW4gYSBzcGVjaWZpYyBhZGRyZXNzIHNwYWNlLg0KKyAqDQorICogUmV0dXJucyAw
IG9uIHN1Y2Nlc3MsIG9yIGEgbmVnYXRpdmUgZXJybm8gb3RoZXJ3aXNlLg0KKyAqDQorICogQGRl
djogdGhlIGRldmljZSB0aGF0IHdhbnRzIHRvIGdldCBub3RpZmllZA0KKyAqIEBwYXNpZDogdGhl
IHBhc2lkIG9mIHRoZSBhZGRyZXNzIHNwYWNlIHRvIHRyYWNrDQorICogQG46IHRoZSBub3RpZmll
ciB0byByZWdpc3Rlcg0KKyAqLw0KK2ludCBwY2lfcmVnaXN0ZXJfaW9tbXVfdGxiX2V2ZW50X25v
dGlmaWVyKFBDSURldmljZSAqZGV2LCB1aW50MzJfdCBwYXNpZCwNCisgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBJT01NVU5vdGlmaWVyICpuKTsNCisNCisvKioNCisg
KiBwY2lfdW5yZWdpc3Rlcl9pb21tdV90bGJfZXZlbnRfbm90aWZpZXI6IHVucmVnaXN0ZXIgYSBu
b3RpZmllciB0aGF0IGhhcyBiZWVuDQorICogcmVnaXN0ZXJkIHdpdGggcGNpX3JlZ2lzdGVyX2lv
bW11X3RsYl9ldmVudF9ub3RpZmllcg0KKyAqDQorICogUmV0dXJucyAwIG9uIHN1Y2Nlc3MsIG9y
IGEgbmVnYXRpdmUgZXJybm8gb3RoZXJ3aXNlLg0KKyAqDQorICogQGRldjogdGhlIGRldmljZSB0
aGF0IHdhbnRzIHRvIHVuc3Vic2NyaWJlDQorICogQHBhc2lkOiB0aGUgcGFzaWQgb2YgdGhlIGFk
ZHJlc3Mgc3BhY2UgdG8gYmUgdW50cmFja2VkDQorICogQG46IHRoZSBub3RpZmllciB0byB1bnJl
Z2lzdGVyDQorICovDQoraW50IHBjaV91bnJlZ2lzdGVyX2lvbW11X3RsYl9ldmVudF9ub3RpZmll
cihQQ0lEZXZpY2UgKmRldiwgdWludDMyX3QgcGFzaWQsDQorICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBJT01NVU5vdGlmaWVyICpuKTsNCisNCiAvKioNCiAgKiBw
Y2lfc2V0dXBfaW9tbXU6IEluaXRpYWxpemUgc3BlY2lmaWMgSU9NTVUgaGFuZGxlcnMgZm9yIGEg
UENJQnVzDQogICoNCi0tIA0KMi40NC4wDQo=

