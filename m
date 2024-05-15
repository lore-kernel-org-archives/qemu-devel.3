Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8467CC25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 07:16:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s78qe-0004c8-46; Wed, 15 May 2024 03:14:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s78qM-0004Yr-Ik
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:14:31 -0400
Received: from smarthost3.eviden.com ([80.78.11.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s78qJ-0000oW-Lv
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:14:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1715757267; x=1747293267;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=mWrNNAaJaIPTkry3BhmfpwvoRGFU2OPTQ+DvsncCn3U=;
 b=C2EUs9hPTmMNBNxS1b0pSM6JPSjpL8XkfexAsuNzyG4hAFUyCBTn7rw9
 rhElGGvLGDiUElLgHZvkmjUD2fFpQ3HU8/6zRyY06S0YTvqvayTzHyiEX
 xm1D4BwnNMOxGX9iQEOLOEZ8qtUYSLNgJGg2BRzwKXS42PULy15j/BsMc
 oVCTaVaPKeAV1HY+0eVuRrjcq6vxdd8dxVV+193MZouLYK46PVNVjJBpX
 U8TOvdFPAjMvvK1Bm7AOLVHB0ylxcyws5R73fG6hBqYcnHbhD4uA9BBZU
 TznYdPdonKilaQI/37ngkHauBoje7TDplsFqfxjXt2W5zF7Ng1VsfozBq g==;
X-IronPort-AV: E=Sophos;i="6.08,161,1712613600"; d="scan'208";a="12581802"
X-MGA-submission: =?us-ascii?q?MDFvjhHg6qsZitBI+5IywTdK9eursV928Nv+//?=
 =?us-ascii?q?b1YdeGCQmczQCVeYlh5Njkgt1p5MohSiecv5wcV+xKci0NKGLUfsJJF5?=
 =?us-ascii?q?SzBIKnz2FP3P1p8hxenLcBZL0/EprF+FvJPpngwp9l361YLI5+h42U05?=
 =?us-ascii?q?reqfP8Zz/yS5shCnFlAjyw2Q=3D=3D?=
Received: from mail-vi1eur04lp2050.outbound.protection.outlook.com (HELO
 outbound.mail.protection.outlook.com) ([104.47.14.50])
 by smarthost3.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2024 09:14:19 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j6PTvIrfW9ZydZPrNE/ofGAMwrieRyp2uxOx0kTjVvz815AoSOJMRmj4L1I9a9hIZ8qHdlsgC2WXEoHX59kBEz4LkkUxbwg17463xb0wdz0/Fb7Fhkdie2yo64AOMJzUC3DeSR8FgOCIDSU6n9omArbPmiUMu+uP9mHk/UD9OOCGH84ATzB4F2UzV4ArhmkhGK4bWU4o5QEB1piiQKpk6gLayNlIvr+DdiW8DFcBtHOs7a5UygaFmKZ9Ue8b6dvC5ins5Lq6w1rNSmqhQjFBqNPpC8jfWPa/8Loy1tnKr0PIh7XwV3C4homGwti9xP7zW2o2G3TLusePIJcZIx40mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mWrNNAaJaIPTkry3BhmfpwvoRGFU2OPTQ+DvsncCn3U=;
 b=mpd5tyAEltd3W5I0ldwwF42A4E5e9ex/R0aSQDR7NaGzcmnw1ndmQoOudj4f4i/35F4yWJl7y0FHVLhdwQQV0QwD+ItjedaKPfPea7423Iq79YeyxtJHxs94re4Kvkx/ZYl3qCxaFgjGHUv4s59gut4yw4fSVTj5ilu0Qq60Y/nzr0vJkCiB8f0qUO3IOFwVNe4IHEPGneu6F+5H4NLk0yxHH1wGdL3A5OaOFFEczX+kyP79c2dz2oKsSkrwqTc9e+Ea7erk9fWcb8kiuMOY43phPyr1Ac7XOyK9KLny9nXAfSOuFDmixxule6myOJ6QJ4M2XETV71H/+XmG1YXeNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by VI1PR07MB6718.eurprd07.prod.outlook.com (2603:10a6:800:18f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.27; Wed, 15 May
 2024 07:14:17 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.7544.056; Wed, 15 May 2024
 07:14:17 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>, CLEMENT
 MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH ats_vtd v2 13/25] intel_iommu: add support for PASID-based
 device IOTLB invalidation
Thread-Topic: [PATCH ats_vtd v2 13/25] intel_iommu: add support for
 PASID-based device IOTLB invalidation
Thread-Index: AQHappd/Mn4U7rZK2kaAPkj64rXn9w==
Date: Wed, 15 May 2024 07:14:17 +0000
Message-ID: <20240515071057.33990-14-clement.mathieu--drif@eviden.com>
References: <20240515071057.33990-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240515071057.33990-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|VI1PR07MB6718:EE_
x-ms-office365-filtering-correlation-id: 0a08e020-04fe-498a-e046-08dc74aea21a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?LzRma3h4ZmdiTWl5amtyUXl2M0E2dmt4WVBwUVdjOFZ0b0hpV0tmdUo4U1Vs?=
 =?utf-8?B?cDNWUy95alUxdWhPSHRGeGdHb2hRNHMycUpFL0pXKy9pNm11cVV3K2xTY01B?=
 =?utf-8?B?RHp1Q0o5Q3MrRnRTQ0pObTNjbVV3SmJoek1FK25vVDdHQnlPd1grV25NOUVG?=
 =?utf-8?B?RnJGWXAvRll5TXNrb0RhdnpZRVVWNEdSblNHdWlWZHUrN1l1OG5sL3RuTWo5?=
 =?utf-8?B?STk1YTBUamZWTlFTL1JWSHkvcmZ2aFFZUFFvN1V0YnZYMzVWU1Zsbm1Rb3Az?=
 =?utf-8?B?d2xhN2xqa2lkM1JURThqV2Q3NXdFM0hISzVuOFdsNFpiS0VHSm9uZk16WFZM?=
 =?utf-8?B?bm83eGlrZXMzNERLbE5qNjQrdGU0VW1zZStFR2R4U1JuUDU4cUZCYlFESStJ?=
 =?utf-8?B?cXdwNDg5Rmc4emxvRXI3NktraEFXZnRINUFmUmJkUHQvMVFkZW9ha2Q5by9w?=
 =?utf-8?B?anJkRlkvM3ZjQUhhODg3elJoTmJpYStyRlF3cUo1UmJLcERpOTYwaWgyMWtJ?=
 =?utf-8?B?QVl6NG5UVHI4S2NnZkJlYkFSMHZEcnpGalVKdFFCT3lWTDNuVXFWTXMvOVU4?=
 =?utf-8?B?KzdKeC9LeVRSYXpqSlFJY0ZqMUh5MDl5U3krck11R0Y1Y1IydWljVEFDZm10?=
 =?utf-8?B?LzM0aWtPR1ExdzhYYXptNmErS3ZEcnFEWkluNGFQSVJLeHk4MTRCZmdFTkxp?=
 =?utf-8?B?NHBEOU40Z3hSTHE2KzVON0hpblZtMGpJVlhVcTRuOS8vVjJ1eGVVdDV6dlVX?=
 =?utf-8?B?TlpzR3NsVXFPSkFMNVJQc241K0FidkJSN2kyNU95WTlhWlZyVUJub2xZcWdU?=
 =?utf-8?B?a00wTkFpdFZpWGQ3bDJ5WE93RFpFbGk3aHZKTzZLWjl5dXg4a2VsNlZNbkFI?=
 =?utf-8?B?bXBWZWdBMkdkZm0ycjhvK2xrbG1RTXdIVkJ2YTdRcVc0cEV0bG0xV3o2LzFH?=
 =?utf-8?B?SkFXendBb254NFU5YUNianViM3BWWUNabWFJUUVycXltcTlzaTg4NmpZUGQ2?=
 =?utf-8?B?bUVWbzBnSERzSHdQME9XbFdEbXF0QzRMdGhhQTJ3OUsrVVZQUmE3akQ1Ny9v?=
 =?utf-8?B?bkIzam5YWEpjMFB2OEZESUVWV0lLbVR3aFZtazd3dFEzYXdEU2xYVENMeHlQ?=
 =?utf-8?B?OHJ3ZEtVWnlTRk5qYXpPVDRtQkw1R0ZkTy9UTXluQlFZY2JGcldNL0RKMTEr?=
 =?utf-8?B?bjFBME1LeGxTN2RYcVRCM3FBd2pwWTJ5YUhpVXlkbWdBSVB0RExjVXpGaEt5?=
 =?utf-8?B?VVRsUWh0Rk1ycTJNK2xMOWJNNzlJK3QvMzRNS3oyeFo1VDJ5ZWlwTGdsK3F2?=
 =?utf-8?B?S0FxSVNQREhRZFppRGw2YmMzNlJxYkZRa3VzS1V6cXM4djhsN1ZSRzlXaU5K?=
 =?utf-8?B?NllJdlJLQ00vL2MxNml0R29PRE11L2FEbHp5T1k4NG1wZG14NWxPUERZZTh6?=
 =?utf-8?B?RmxxZWN3S3BPWFN1K0ZrQ1hRRjExcDNzUHZzL25NZFpPbUpCdzlITm1Hejk4?=
 =?utf-8?B?WDVIMDBBWUJHVnVERTkwaHZabGl3SlBVRGVhbE5EUWxFTVpxaVVrcml3Zmp2?=
 =?utf-8?B?VlV2K3IrOUVXNitmcklKeGN6bTJrcDl5ZmV5WXZjY0txeVNHYXJmT1RNOThF?=
 =?utf-8?B?bTJZanpCMWN4ZHBDdVhpOFBmMWgrdkVscTNqdnJoTG9wcWx3M3ViRlpxSUZo?=
 =?utf-8?B?ZllGNndyVFBCM0JGdEFEbWJ2amJ0V3ZwREFsWE5ZTnE1MGIxam0wQkUvZTBh?=
 =?utf-8?B?a0c1eENGN2J0RGMwVnR3V1lBRFZSQXNYSmxjVWxBaWVUZnRET1NUNjZ1TmNU?=
 =?utf-8?B?cFBnczFXZzBjQzBTVm8xdz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dVFMbmF4UEcrbHJvbzVNWG9PNkRqQVF1SzNJWTJaSUkzb0x5WTVHOFY4b3dV?=
 =?utf-8?B?ZXNkVUVUUUpEa1JOZlc0TlZicGVrOXdUNGdiSi9nbjlQTTA3WDcrYWJaSVZY?=
 =?utf-8?B?T2Q4QzVpYnM0ZEJuanpDZE5GTUpHbzd0eTZOYUJBbXUwNVhwYy9CdG5RTnRT?=
 =?utf-8?B?Q2tqemtkOGVUcmJOWUpSOUJITmhqV0JkWXJHQU8vWlpLU0UrK1NnVjJPb1Fm?=
 =?utf-8?B?MGZGdGMxVzNZdUtOazNLU1Z1Zit2eTdqOFRxd21DeWxuT2pWWWhGREpHVzlH?=
 =?utf-8?B?c0J0dFBPTEV6aFdoYXV0KzlFUHNKOHdxdjNSazRuSzhFQVRZeHI2djZoTW9v?=
 =?utf-8?B?RkpHOVRyUXQwRHNoNlNZMXNwYkxIZ1NPZjJHUnliQUJXSWx5NFgxVkNwSHJL?=
 =?utf-8?B?MTlYb2I2UTBlSTFqS2NPcUNhZjg5MUdyNmFieXF0ZEY2Z2RzM2lWbmU5a2Nn?=
 =?utf-8?B?V01iM2NKWTRHWmx4RjFPc1NmN0lTY3A1MjMyaHFpMTJOZHVWVlJ3TVF0N1FZ?=
 =?utf-8?B?UUNJY3M4QVRraElLUjQycGp3ckZtR2dIZUVQUDdlNWkwTUpBV1I1VElRZmR1?=
 =?utf-8?B?YXlEK2QrelpTS1RDOGVycHJtbVhLcHNMeFhMWmNSK3p1NEF3L3ZYaWlBSmtn?=
 =?utf-8?B?R1NTbDkyVDFNWlQ5cURLT0lQbnZMaFdVWUgrOVoyRDdHU1paYmRZamFlWjdF?=
 =?utf-8?B?MEVvdUZJKzVwQllLN09odzgwaFNmZTBBcHIwVjFEbXhiTjdneElSU2RGZUNC?=
 =?utf-8?B?SHprRHJwcm5ScXJERDFDL2N4eW16R2FzY1BsUDhmZVdOQlRGa0RERXZyVXUz?=
 =?utf-8?B?dElGQWNiYVo0MmQyTVJFbXBBQ29PbFFubzZLaGxweGpLVTR5YUxEbjJqTGJu?=
 =?utf-8?B?Qnd2eDN2QmI4V09PVjZXWWhJa2tFQmk1R3BHU2JScjFlaEZKQXoxY2VIbXl2?=
 =?utf-8?B?N0FjWm1yRWJxU1VzbUhHdDVOYlNqdXhobTh3UUEvQ240QlVIdi9wRkUwdXFV?=
 =?utf-8?B?ek5tbFYwazBxeTIyOUF1WnBCMXJCV2tMYk9hWWhBV01qVHNnbUtXUXRUdmVZ?=
 =?utf-8?B?RzUvYzM0c3NOWTVIL0Z5UEF3L1h6VlF6VTZHc1dRSVYrajVSZWFrOU9xN2RV?=
 =?utf-8?B?V0ptd200ZUhEanpreXZYTnJWS1AvMk5zZElwZ2t5N3BRd3JuMEZsYVVyRkh3?=
 =?utf-8?B?Uk5uZTBmcFNnMGlkbFE0b29LWVYvcjFxMkpuTkVKOTR3cWV1aXZNUWZWSHRa?=
 =?utf-8?B?dng1c0tvcXBWYlQxNmIwSjM5c245QUZtbUEwK3R3cVpwK3ZPNGVudUFmbWlC?=
 =?utf-8?B?VFlJL1V3clVqNHkxeTlWMUFMWUxmcjAvOW8zQ2M1cU04dGkrVGZlbytJNHBB?=
 =?utf-8?B?Z1dCbm96bXc0ZXFFR3JpOVNKangyWFJyTzVuQXYxa2FPQnQ2SE1TZEVpVU1r?=
 =?utf-8?B?UHgwd1VOOE5mL0lwVk8xYlU4clFDUlNrK0FUUk4yQ2tNSk9wNGZRbU1XODUv?=
 =?utf-8?B?MUVTVjRPTkd4MVkwaU93MVlpZ0ovVFBhSXpSb3Z3NVgwd1hPUEE5bjlyUi9a?=
 =?utf-8?B?ejNlQzdlUTczckgyNjMxMUU4REE5eks4a0RlNm5QOFFUN1lzVHh2NVhtK2tY?=
 =?utf-8?B?aU9rcHRUeUR4TjhTbUxnL1lENk5rL0lTUzVqazd1NURxMlhXcGlndkJNdTls?=
 =?utf-8?B?bmt0ZnZqUDZvZ1ByZ0czak5lMVpzbkhQdUczTDg3YmdlOGFxaC9mQThUejZT?=
 =?utf-8?B?SFBpU1lkWFVueFozZTdBRzhzSE8zbHVDcTJSZ0NNVjZiS2UxcGd0bU5vRWdO?=
 =?utf-8?B?MnNrbCtNVms3OGN5Y211ZTFqeE5pOThKTEhFdXc4SktReUh4YWtCOTFuUEVo?=
 =?utf-8?B?U3dxcjBjN3ZIY2pkaUJndmtxMmpzQzhSVTg3UGJleGh4eUxZSDFmMTlDaExG?=
 =?utf-8?B?QzVWVmxaTmU0Zlc4SVhsaVE3YXJaTVF0d21UeExkR1F2SGdBaVkra0xtL2VO?=
 =?utf-8?B?RURIcmFjbk1UYktXS09id2p4eGhnSTVTb0lFRklMZG5qOEx4UkYxK1NOOGQw?=
 =?utf-8?B?V3hTYTZFZlFWZ1hRTHhPNzVVVVNmNkJmdlFsc3JoTjYrcElPNXJ0NHB2QmdN?=
 =?utf-8?B?WWRIdWQzTlpxNWNqbGd0S0xWM1lFS1ozajZ0TG1ZcWwxNENSSk9BSXFaVlM1?=
 =?utf-8?Q?MxexGMxeGzJGDR9kiSVaYNo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AA7F31BFC97CB246859F5922475FFFD6@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a08e020-04fe-498a-e046-08dc74aea21a
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2024 07:14:17.2084 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BVu02JEEbSkBG141tPbXlYQgoygAgbwdc+7gXTkX2BIxZqYe20gBv8Ch2lUUrMpyFIvwOawRJG8pl7lMDPNxdkJaR89b/u04ijAYCmI5LUR/d9aWUif+hGuyHRYsKLIG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB6718
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

U2lnbmVkLW9mZi1ieTogQ2zDqW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xlbWVudC5tYXRoaWV1LS1k
cmlmQGV2aWRlbi5jb20+DQotLS0NCiBody9pMzg2L2ludGVsX2lvbW11LmMgICAgICAgICAgfCA0
MiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tDQogaHcvaTM4Ni9pbnRlbF9pb21t
dV9pbnRlcm5hbC5oIHwgMTAgKysrKysrKysNCiAyIGZpbGVzIGNoYW5nZWQsIDQ3IGluc2VydGlv
bnMoKyksIDUgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9ody9pMzg2L2ludGVsX2lvbW11
LmMgYi9ody9pMzg2L2ludGVsX2lvbW11LmMNCmluZGV4IDE2NjEwMzUxMGUuLmZkNDcxMGJhMjgg
MTAwNjQ0DQotLS0gYS9ody9pMzg2L2ludGVsX2lvbW11LmMNCisrKyBiL2h3L2kzODYvaW50ZWxf
aW9tbXUuYw0KQEAgLTQzNDEsMTEgKzQzNDEsNDMgQEAgc3RhdGljIHZvaWQgZG9faW52YWxpZGF0
ZV9kZXZpY2VfdGxiKFZUREFkZHJlc3NTcGFjZSAqdnRkX2Rldl9hcywNCiBzdGF0aWMgYm9vbCB2
dGRfcHJvY2Vzc19kZXZpY2VfcGlvdGxiX2Rlc2MoSW50ZWxJT01NVVN0YXRlICpzLA0KICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBWVERJbnZEZXNjICppbnZfZGVz
YykNCiB7DQotICAgIC8qDQotICAgICAqIG5vIG5lZWQgdG8gaGFuZGxlIGl0IGZvciBwYXNzdGhy
dSBkZXZpY2UsIGZvciBlbXVsYXRlZA0KLSAgICAgKiBkZXZpY2VzIHdpdGggZGV2aWNlIHRsYiwg
aXQgbWF5IGJlIHJlcXVpcmVkLCBidXQgZm9yIG5vdywNCi0gICAgICogcmV0dXJuIGlzIGVub3Vn
aA0KLSAgICAgKi8NCisgICAgdWludDE2X3Qgc2lkOw0KKyAgICBWVERBZGRyZXNzU3BhY2UgKnZ0
ZF9kZXZfYXM7DQorICAgIGJvb2wgc2l6ZTsNCisgICAgYm9vbCBnbG9iYWw7DQorICAgIGh3YWRk
ciBhZGRyOw0KKyAgICB1aW50MzJfdCBwYXNpZDsNCisNCisgICAgaWYgKChpbnZfZGVzYy0+aGkg
JiBWVERfSU5WX0RFU0NfUEFTSURfREVWSUNFX0lPVExCX1JTVkRfSEkpIHx8DQorICAgICAgICAg
KGludl9kZXNjLT5sbyAmIFZURF9JTlZfREVTQ19QQVNJRF9ERVZJQ0VfSU9UTEJfUlNWRF9MTykp
IHsNCisgICAgICAgIGVycm9yX3JlcG9ydF9vbmNlKCIlczogaW52YWxpZCBwYXNpZC1iYXNlZCBk
ZXYgaW90bGIgaW52IGRlc2M6Ig0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgImhpPSUiUFJJ
eDY0ICIocmVzZXJ2ZWQgbm9uemVybykiLA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgX19m
dW5jX18sIGludl9kZXNjLT5oaSk7DQorICAgICAgICByZXR1cm4gZmFsc2U7DQorICAgIH0NCisN
CisgICAgZ2xvYmFsID0gVlREX0lOVl9ERVNDX1BBU0lEX0RFVklDRV9JT1RMQl9HTE9CQUwoaW52
X2Rlc2MtPmhpKTsNCisgICAgc2l6ZSA9IFZURF9JTlZfREVTQ19QQVNJRF9ERVZJQ0VfSU9UTEJf
U0laRShpbnZfZGVzYy0+aGkpOw0KKyAgICBhZGRyID0gVlREX0lOVl9ERVNDX1BBU0lEX0RFVklD
RV9JT1RMQl9BRERSKGludl9kZXNjLT5oaSk7DQorICAgIHNpZCA9IFZURF9JTlZfREVTQ19QQVNJ
RF9ERVZJQ0VfSU9UTEJfU0lEKGludl9kZXNjLT5sbyk7DQorICAgIGlmIChnbG9iYWwpIHsNCisg
ICAgICAgIFFMSVNUX0ZPUkVBQ0godnRkX2Rldl9hcywgJnMtPnZ0ZF9hc193aXRoX25vdGlmaWVy
cywgbmV4dCkgew0KKyAgICAgICAgICAgIGlmICgodnRkX2Rldl9hcy0+cGFzaWQgIT0gUENJX05P
X1BBU0lEKSAmJg0KKyAgICAgICAgICAgICAgICAoUENJX0JVSUxEX0JERihwY2lfYnVzX251bSh2
dGRfZGV2X2FzLT5idXMpLA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICB2dGRfZGV2X2FzLT5kZXZmbikgPT0gc2lkKSkgew0KKyAgICAgICAgICAgICAgICBkb19p
bnZhbGlkYXRlX2RldmljZV90bGIodnRkX2Rldl9hcywgc2l6ZSwgYWRkcik7DQorICAgICAgICAg
ICAgfQ0KKyAgICAgICAgfQ0KKyAgICB9IGVsc2Ugew0KKyAgICAgICAgcGFzaWQgPSBWVERfSU5W
X0RFU0NfUEFTSURfREVWSUNFX0lPVExCX1BBU0lEKGludl9kZXNjLT5sbyk7DQorICAgICAgICB2
dGRfZGV2X2FzID0gdnRkX2dldF9hc19ieV9zaWRfYW5kX3Bhc2lkKHMsIHNpZCwgcGFzaWQpOw0K
KyAgICAgICAgaWYgKCF2dGRfZGV2X2FzKSB7DQorICAgICAgICAgICAgcmV0dXJuIHRydWU7DQor
ICAgICAgICB9DQorDQorICAgICAgICBkb19pbnZhbGlkYXRlX2RldmljZV90bGIodnRkX2Rldl9h
cywgc2l6ZSwgYWRkcik7DQorICAgIH0NCisNCiAgICAgcmV0dXJuIHRydWU7DQogfQ0KIA0KZGlm
ZiAtLWdpdCBhL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaCBiL2h3L2kzODYvaW50ZWxf
aW9tbXVfaW50ZXJuYWwuaA0KaW5kZXggZDYzZmYwNDlhNy4uM2Q1OWUxMDQ4OCAxMDA2NDQNCi0t
LSBhL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaA0KKysrIGIvaHcvaTM4Ni9pbnRlbF9p
b21tdV9pbnRlcm5hbC5oDQpAQCAtNDI0LDYgKzQyNCwxNiBAQCB0eXBlZGVmIHVuaW9uIFZURElu
dkRlc2MgVlRESW52RGVzYzsNCiAjZGVmaW5lIFZURF9JTlZfREVTQ19ERVZJQ0VfSU9UTEJfUlNW
RF9ISSAweGZmZVVMTA0KICNkZWZpbmUgVlREX0lOVl9ERVNDX0RFVklDRV9JT1RMQl9SU1ZEX0xP
IDB4ZmZmZjAwMDBmZmUwZmZmOA0KIA0KKy8qIE1hc2sgZm9yIFBBU0lEIERldmljZSBJT1RMQiBJ
bnZhbGlkYXRlIERlc2NyaXB0b3IgKi8NCisjZGVmaW5lIFZURF9JTlZfREVTQ19QQVNJRF9ERVZJ
Q0VfSU9UTEJfQUREUih2YWwpICgodmFsKSAmIFwNCisgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAweGZmZmZmZmZmZmZmZmYwMDBVTEwpDQorI2RlZmlu
ZSBWVERfSU5WX0RFU0NfUEFTSURfREVWSUNFX0lPVExCX1NJWkUodmFsKSAoKHZhbCA+PiAxMSkg
JiAweDEpDQorI2RlZmluZSBWVERfSU5WX0RFU0NfUEFTSURfREVWSUNFX0lPVExCX0dMT0JBTCh2
YWwpICgodmFsKSAmIDB4MSkNCisjZGVmaW5lIFZURF9JTlZfREVTQ19QQVNJRF9ERVZJQ0VfSU9U
TEJfU0lEKHZhbCkgKCgodmFsKSA+PiAxNikgJiAweGZmZmZVTEwpDQorI2RlZmluZSBWVERfSU5W
X0RFU0NfUEFTSURfREVWSUNFX0lPVExCX1BBU0lEKHZhbCkgKCh2YWwgPj4gMzIpICYgMHhmZmZm
ZlVMTCkNCisjZGVmaW5lIFZURF9JTlZfREVTQ19QQVNJRF9ERVZJQ0VfSU9UTEJfUlNWRF9ISSAw
eDdmZVVMTA0KKyNkZWZpbmUgVlREX0lOVl9ERVNDX1BBU0lEX0RFVklDRV9JT1RMQl9SU1ZEX0xP
IDB4ZmZmMDAwMDAwMDAwZjAwMFVMTA0KKw0KIC8qIFJzdmQgZmllbGQgbWFza3MgZm9yIHNwdGUg
Ki8NCiAjZGVmaW5lIFZURF9TUFRFX1NOUCAweDgwMFVMTA0KIA0KLS0gDQoyLjQ0LjANCg==

