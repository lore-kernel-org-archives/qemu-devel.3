Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0512FC25B77
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 07:17:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s78qa-0004bf-I9; Wed, 15 May 2024 03:14:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s78qK-0004Xk-14
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:14:29 -0400
Received: from smarthost1.eviden.com ([80.78.11.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s78qF-0000pL-Uc
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:14:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1715757264; x=1747293264;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=RCojRL0EejAMJ9/fcfk7FzAhNuHzVs08KnMU7NdYJV0=;
 b=ps1CYm3UDwIh8vWcHoLvNA7MNWDibBiSTL0iv5hknYmj6nijL4PKCNab
 e8UkJ34zK1WW1yhX+W8cYA7fzhNtyyeKbpEd7FKLAp+qFJjcinXSakiA6
 c52YidwA05BgbDM2eBxGaakeS8nyL3R/FXyMvpZMF6xfnKe9C4i4b+fmg
 aVoj9TGwYKen4XthjN59UryQOSM06NIM4oq4NZdrwn95pW8l2JIvz7rzR
 L3Dxwz4iRlpuXyr/O+hdv8WY/Ls0RwQnHIG/OtV15nbQZAzUPP+xZGojq
 4zN7xj/ASSyZaOV5mxGx3OAs4/i/1+a/tiQXEgqfPOoWss+BHpgQbhtRW w==;
X-IronPort-AV: E=Sophos;i="6.08,161,1712613600"; d="scan'208";a="12580202"
X-MGA-submission: =?us-ascii?q?MDHUVgm7ZeognavAQFZ7F/aIbJ7lQew7Z5DCRA?=
 =?us-ascii?q?cm57q5cN1D2UJPLtWB6uOkRIqISFImQl5Bi7cOjh8EUMPqGgFcCBZ+k9?=
 =?us-ascii?q?iZnx3GE36rGSAtpHbpAsUBZ7MqxANtc5JGAIoww58UkynohpN28Hjts4?=
 =?us-ascii?q?Y39OYYW2IYcWV2iXVucI7zWQ=3D=3D?=
Received: from mail-db8eur05lp2104.outbound.protection.outlook.com (HELO
 EUR05-DB8-obe.outbound.protection.outlook.com) ([104.47.17.104])
 by smarthost1.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2024 09:14:19 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d5O66+J9G1xfWzOaOHIsOVCprHXtfmMxNO/f4pJBcNeiU+xRVuFJ550VlIK54zB8wfVE+6YPNKxuH+Fh7STen+/b6ohT6o/2zckz7UX/4L8h1/TBJlL2noueGZtL2tSzkz1eTsrkZPodPWhluRXaFTkCXqj0gj9uulmfTMv1stThZMDOeWZyrB9PfseAtKpYpkKjRDlrz2bOSkfxLDiWjYwAjGvEFzJeMVcXA/ilB0KGWMhLZX06otrJKTLxEJ/0eCrIRbBAsvZCLe+GZIu9S2g68qTdMsHRchYkcncLVY05KAobFfA+nLYYg19ygUAoATKsw+/Nh5PmUFQVETHaJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RCojRL0EejAMJ9/fcfk7FzAhNuHzVs08KnMU7NdYJV0=;
 b=JoADzLKZi4vHku5Y/+zetgkgGqvtQDGDwdzNH1RlkAFmfPXrxCu/mDfLRTMbg4ipFzyeSnR7A1WDMPgmFNrGjyeu5qDyEdUI7DSmPskcm7S/nNNxZC5Y38tkf+xUlEealjtH1EkepDAUPPi4VHyh4mUxnKLokaj2HlY6FxRzb7TlefPfkK0CdEOH0+qFzYOrzRzwpLmc7izmzqifCP6o+AgoX0slpCKR9uHDw3gyL+UpIdfAsEVPfK0bIVfrUZ3MNzZgr/lvdiUxAGOs46lZa6XwpUM3KP+EOivySeeARVckZvhFaIHldsA0ymulCJVKEvqU87ND35yMueizJxMFYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AS5PR07MB9896.eurprd07.prod.outlook.com (2603:10a6:20b:676::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Wed, 15 May
 2024 07:14:16 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.7544.056; Wed, 15 May 2024
 07:14:16 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>, CLEMENT
 MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH ats_vtd v2 10/25] pcie: helper functions to check if PASID and
 ATS are enabled
Thread-Topic: [PATCH ats_vtd v2 10/25] pcie: helper functions to check if
 PASID and ATS are enabled
Thread-Index: AQHappd/ggmcqc5wPk6vSoBAbpA6Gg==
Date: Wed, 15 May 2024 07:14:16 +0000
Message-ID: <20240515071057.33990-11-clement.mathieu--drif@eviden.com>
References: <20240515071057.33990-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240515071057.33990-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AS5PR07MB9896:EE_
x-ms-office365-filtering-correlation-id: 1450162d-34c5-4d5c-260b-08dc74aea1ae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?ZzU2cHhhUEVNeU5UeC82ZHFIYnZ4NWo0Q0N4ZWxEYnU3NEVTUnNJU0RGYk9t?=
 =?utf-8?B?VUdtYWhoaUV0b09EdDF2dExkZUVYSjU4b2lLUzRZUlpYeElhYTBwSGVnb2tl?=
 =?utf-8?B?cWtyYk45bFRrR1V5RGtuV0RkNGdabGZxdzdHT2U2OUM1UlZGMGkzNnAxOUdX?=
 =?utf-8?B?M2JxWVJ1MG1GTHNoemxJb0FXcndaS1B1bHUweGZlcEtiaHNnbUlESzkxRGta?=
 =?utf-8?B?TEFPa3UyNVc3Ly9RQUVvZHVSclZRSHpqVE0yNVByalJtZ1phRU9HeUd3M3lS?=
 =?utf-8?B?dWRWM2FXd1doOVdHa3NEcFBCMGU3Wm5MbGRDTytOTkt3dlZaQ01hcVJQbVZM?=
 =?utf-8?B?L01YL1ZBeENxanVjQ3U5bVhMMUYrd3NJZnB0VWgxcUZ1QVE0OEtjOUhZcGtw?=
 =?utf-8?B?ZUFBUVRKTFRaak8razZxb05UdndHVFc2S1B4RW5kUTBGc1FjMWVBTjk3VnVk?=
 =?utf-8?B?VmtXTUdJb3YyYmk0RXNJQVFRMTQ0aW50SXkzTkw4UmdnK29XeTdNakpySVZ5?=
 =?utf-8?B?YkRaZnBzMDVwVFZHT3NGWlhoWmJsdGlXVTUxbno4MEVZaERRWCs0bSttV0Rk?=
 =?utf-8?B?RTQrZlltVExKVHRDemwxeEZjS3RHMVl4WEh3UW0xck5pVlQ1UDlqcDlVRWJY?=
 =?utf-8?B?UDN6NklSUTg1d2VNVkVxLzR3ZmdEMWNNVE9xTmxjekRnU2Q1RWp1aDVqM0FV?=
 =?utf-8?B?bDFPdlJDbkF0TkVmeEcvWDB0MCtyUFJZTm0vQ0ptdzdXM2tiY0pvZGx1TDNF?=
 =?utf-8?B?aWRLYk5NUVduaEVVU01aUHFPZ0RydlZsbFBQV2ExN2hIZnNuM2tySmlRRzYr?=
 =?utf-8?B?TWJ2dWJYR2E2WE84MU9QU1k3SE8rdGRRSGlsRGpSNjNvZkFEcnlzVDNJaCto?=
 =?utf-8?B?VUtkQ1dZcytBUTFNdjRtVnNBY0ZVVVRoMmNPa0lTMGpaS0FCNXN2eHJQYzBD?=
 =?utf-8?B?aFMzWUZhdWFUUjJFQ3A5OCt2elpjVC94MEJRY1c0STRobXJIbmxYRUh3YzBS?=
 =?utf-8?B?cEVTUU95bFZzK09seHhabS91enIzK0l4T2FkaTNsQ3g1VnlRM2ticjFPSGNJ?=
 =?utf-8?B?N2pGRmVkazA5bk9iS3phM21NMVlFQlcvM0g3TVp2eVFzMUFtaFNQSDFQcnV0?=
 =?utf-8?B?UkJ2STE1VXVxNXIvZEhyYWRHRnR0Sy9mYkgzUC9sQ0l2bXN4d21aOW1WbkZ4?=
 =?utf-8?B?a1pWTHRjeVZJYlV2YzVCWUdqb0taaTA0UjV0dGRyZGdYVFhhZUlEQ3ZPNGRn?=
 =?utf-8?B?Rk1iRUZxZVBHSWxoaHAydnhCYU9FekhLQTdmeFpvT0NrZWY1VVRyYnlGakJY?=
 =?utf-8?B?bGV2Q2xORjkrR1hDUS81ejhCRDJmRnRvbjNnQy9wbVhTMUJHZGpUMFlXZUtw?=
 =?utf-8?B?NXhPczVROEsyNVNNa3JwVE4ycm9PUWZERGJSN1ZTbnFLK0twZE9zWU10SG94?=
 =?utf-8?B?WGx4SjFvbUVZdjkxSnNtS3hMSVl1Mm9GcGtDTUVIZERFVy9mWjkxZ1pTMzE0?=
 =?utf-8?B?OGh3THBBQysxaUYxVU4vYzQvZmZiYi9qTzQ5M1pLVEUzZ1NkeCtYekljOGtp?=
 =?utf-8?B?ZnNlMysycjVLclVXQ3NyV2dSVjRMUmM2eEo1dWVMeTRELzhoVy9RK1QyZmVq?=
 =?utf-8?B?U1pIUmxlSlIrWGtIMEFIN25JUmhQR1p4U3FIRWZUdWtacjNid3AyaXBlMWlW?=
 =?utf-8?B?KzhLN2VqM01rMFJvWFdoaWZkSlduSnNRSlpNd2l5ZUJwTElOaEFXMkJMUDBD?=
 =?utf-8?B?eHBlL2lHbXZsNklEQ0Z2Q2RBc1gxYWNnL1hEb3JLQjRZZ0k4S2lZZHBxeDBS?=
 =?utf-8?B?b1lYVldjd2xLcndYMUxHUT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OGYvKzNLbm1DaWVhOTA2RVNHSVlYWEUyVFZoQlN6S05qeXhKQWl6UWZJdmpQ?=
 =?utf-8?B?YjBZR1JWSG1xbmpjU1Q3QlU2LzQ2R3hNUm5RVk95MllZRlgzbVdBL2Zsa20w?=
 =?utf-8?B?d0pRbWY1S2p1M2gyLy96Z2VPdmI2ekt6TDFJdHFDb2J4UVk4UXdrc3p5Zmww?=
 =?utf-8?B?TzBtSzM4R3JVZnlBK09yeUh5bXlkeHR3Yk1IVEhNQ0JjbWpWNlJYNXNrdnJR?=
 =?utf-8?B?NlpXV3dSbzN6aUJYdmY0N01Wa0NmSWh5djJHRzhNSGNKbVpXcW1YQVh6Nms1?=
 =?utf-8?B?NUNZbnFRbjJySk1adGpUNERHa3pVK2p5S1hwekFvbXZqODhMSFEzS1YzaGFE?=
 =?utf-8?B?VVhydHRSVHZqVkp1eDVkSUFoL2t6YTd5MUdEM2Q4dlZYeDRrbDVrYWZ6ZHlX?=
 =?utf-8?B?ZHhUM2Y5TFFDUkoxM3JkYXpXM2xpK1pRZkV3MHhaT0RVeGkrYXVVM3VvYjlh?=
 =?utf-8?B?am5LTU9zRThkYU5iV0R5WEpYTDN6bkttQ0M0WmJMUUxORGNtMmFrcWwwb3hz?=
 =?utf-8?B?ZFg4RlFHTmhEaCtNNG95VndUWXVvb1JzdFo3TU1hajk1KzVjNEUyd1FOUHRK?=
 =?utf-8?B?U3VDRTZYR1FscU56RkpCRTA5dHRZcno2S3E2aEIxZWJWL20rS2EzOUlzWFUy?=
 =?utf-8?B?R2V0R21hbjYybUp4YzV2b3dPcHRsM1pxRmcvRkYyakNMZzJNaU9iUjNhNVhD?=
 =?utf-8?B?dURRclpBcWN2Z0lIdi9rWVEzN2VJYTdNNUg2QXg4Tk94RHFPbGVONGtXb2hX?=
 =?utf-8?B?bEI1VWEybkhkUHZ4djl1dlVla0QxUmw4czBkWWdOb1VxdjFMVStXQUptdThj?=
 =?utf-8?B?eFdKcU9ydTBpVFI3cGsyK2YyWlFsOHZ2d0pCVHRqaTFQOFJBbzZIdXpvVm94?=
 =?utf-8?B?NVZDeTk1ZjR6R0Zya2tXSEVydGNncG1Pb0hwYVpCWlN1SGRuaFdGTTRwemo5?=
 =?utf-8?B?ZWxPRmduTDRJZUNVMFBVeFlPOHM1OFNYYmRod1JnSVRGZzFMQjRoT2ZEQ2Mw?=
 =?utf-8?B?djNab08yMk5INjd0bS9VWm1sYzEvNkpDQVYxclJEVDFmcklxMWxBbzlIdGRh?=
 =?utf-8?B?d01CK1VFQWtlbU1tOHVXWVM3VUNCMG4vVGE0b0YwN2tLWGVuL0tENkMzMXlW?=
 =?utf-8?B?MG40YVU4NFV1eExidHhqbzduRDBzaTdwRjZ4Q0ZZL2s1ZWZFNmN4Z2xIc2Rr?=
 =?utf-8?B?T1Q1YjNvNXlXSDRKaDNtTWhlUnBmMmRBa3duaFArL09KMHlGbEd4REljQmZm?=
 =?utf-8?B?RkF4NEF1ZndqcFlVdFF5VUV1bHpjckFLTlVyQlZGK2RoU3ZMc2hjYWJxRVRu?=
 =?utf-8?B?VUlvT28vQlF5L3p6bU9VTnJNRHcyZTVvSXFBb0VrN0lLaTlxRGJiT1hNVXNN?=
 =?utf-8?B?REdibVVJTlpFaWM3ZlJ0eFlkMVp1b1V0RDNwY2x0T3h0QXd6VC9hMm05RFBG?=
 =?utf-8?B?bW5IZkJMYktUZ0JkODRHS0Roa2U2WmhMMzIrWmEvY2d1RVNwUXAzNDd1OGdH?=
 =?utf-8?B?MURORDcwV2ROVmNBa3VpS01udVQrdzVKenNBQXExZ0hZeVpIWXBkazgzZEZi?=
 =?utf-8?B?bkZKM0FkOFN1MmYwN2xrSTVTM0RxU09xanJwK0E4T0s0MmcxR05LZ2QzS2N3?=
 =?utf-8?B?bi8yZkpHR2sxZ3RHb0l0dHVGa3hTcmoxRXNvUUJHdFlPWTlRVCtsSkhxL0py?=
 =?utf-8?B?MERhM0x3ZzNUZTU2eUtnQzlmOHpibU1xL21DVDU1Z1BYd2M2cDdabG9XRzVQ?=
 =?utf-8?B?WXJpbkZmUS9wT2IvNkNJdXVxc0xuUmFnVUt4Z1djRFVzQlMwMnBPWmQxNFNz?=
 =?utf-8?B?dWdVMy9iVmVkTFBqN0xIdkZpZ3VTdHd2bHF1YzBxbXZLUzU5eGpJL2orb3NG?=
 =?utf-8?B?am1CdE1RamNuQ1A0Mzl5Zm1TSklxYzV1Z090SHZJdEtWejlRbEF0MjhRdE9M?=
 =?utf-8?B?VUxVU2RKNi94MnA1Wlp6YVAzMFd5TUhiUXA5Wk1CL2FCL3IzZWl5RFdmRUl3?=
 =?utf-8?B?blFzYVdhenFUdXF4TG9BcGdLbjlJVXRPeWhSeHNXZ2ZXdWtVSGNHQ0hueU5l?=
 =?utf-8?B?Q2FaUzBQbmUvUEx4cXp1Z1hUWHpNYXZoZi9BTkgzL2pCQ0tYN0tvcHBmME1R?=
 =?utf-8?B?YkVrdEVNSWRVYm81cTMxZVo5L2w0U1pCWEdHREdVeVowVEZkZXVmaUZSTS9Q?=
 =?utf-8?Q?vNaTDgAvGVeRhGHNG/fGw6Q=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7FFF1DC0F7EF6D47BC36A075EA511FCA@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1450162d-34c5-4d5c-260b-08dc74aea1ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2024 07:14:16.5324 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iAn2PXiGXd84WyUPQf7WlgLxnHHX4keek2kaYMdo9qZnObMb3rTMk6dhvzkvaMDpoHP3jcO4G/ClRBAG8D9/s8+JTyMdO/uZekwaacaDQRbuK8FmTvH5/Odlcqjaaoj2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR07MB9896
Received-SPF: pass client-ip=80.78.11.82;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost1.eviden.com
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

YXRzX2VuYWJsZWQgYW5kIHBhc2lkX2VuYWJsZWQgY2hlY2sgd2hldGhlciB0aGUgY2FwYWJpbGl0
aWVzIGFyZQ0KcHJlc2VudCBvciBub3QuIElmIHNvLCB3ZSByZWFkIHRoZSBjb25maWd1cmF0aW9u
IHNwYWNlIHRvIGdldA0KdGhlIHN0YXR1cyBvZiB0aGUgZmVhdHVyZSAoZW5hYmxlZCBvciBub3Qp
Lg0KDQpTaWduZWQtb2ZmLWJ5OiBDbMOpbWVudCBNYXRoaWV1LS1EcmlmIDxjbGVtZW50Lm1hdGhp
ZXUtLWRyaWZAZXZpZGVuLmNvbT4NCi0tLQ0KIGh3L3BjaS9wY2llLmMgICAgICAgICB8IDE4ICsr
KysrKysrKysrKysrKysrKw0KIGluY2x1ZGUvaHcvcGNpL3BjaWUuaCB8ICAzICsrKw0KIDIgZmls
ZXMgY2hhbmdlZCwgMjEgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvaHcvcGNpL3BjaWUu
YyBiL2h3L3BjaS9wY2llLmMNCmluZGV4IGQ2YTA1MmI2MTYuLjRlZmQ4NGZlZDUgMTAwNjQ0DQot
LS0gYS9ody9wY2kvcGNpZS5jDQorKysgYi9ody9wY2kvcGNpZS5jDQpAQCAtMTIwMSwzICsxMjAx
LDIxIEBAIHZvaWQgcGNpZV9wYXNpZF9pbml0KFBDSURldmljZSAqZGV2LCB1aW50MTZfdCBvZmZz
ZXQsIHVpbnQ4X3QgcGFzaWRfd2lkdGgsDQogDQogICAgIGRldi0+ZXhwLnBhc2lkX2NhcCA9IG9m
ZnNldDsNCiB9DQorDQorYm9vbCBwY2llX3Bhc2lkX2VuYWJsZWQoY29uc3QgUENJRGV2aWNlICpk
ZXYpDQorew0KKyAgICBpZiAoIXBjaV9pc19leHByZXNzKGRldikgfHwgIWRldi0+ZXhwLnBhc2lk
X2NhcCkgew0KKyAgICAgICAgcmV0dXJuIGZhbHNlOw0KKyAgICB9DQorICAgIHJldHVybiAocGNp
X2dldF93b3JkKGRldi0+Y29uZmlnICsgZGV2LT5leHAucGFzaWRfY2FwICsgUENJX1BBU0lEX0NU
UkwpICYNCisgICAgICAgICAgICAgICAgUENJX1BBU0lEX0NUUkxfRU5BQkxFKSAhPSAwOw0KK30N
CisNCitib29sIHBjaWVfYXRzX2VuYWJsZWQoY29uc3QgUENJRGV2aWNlICpkZXYpDQorew0KKyAg
ICBpZiAoIXBjaV9pc19leHByZXNzKGRldikgfHwgIWRldi0+ZXhwLmF0c19jYXApIHsNCisgICAg
ICAgIHJldHVybiBmYWxzZTsNCisgICAgfQ0KKyAgICByZXR1cm4gKHBjaV9nZXRfd29yZChkZXYt
PmNvbmZpZyArIGRldi0+ZXhwLmF0c19jYXAgKyBQQ0lfQVRTX0NUUkwpICYNCisgICAgICAgICAg
ICAgICAgUENJX0FUU19DVFJMX0VOQUJMRSkgIT0gMDsNCit9DQpkaWZmIC0tZ2l0IGEvaW5jbHVk
ZS9ody9wY2kvcGNpZS5oIGIvaW5jbHVkZS9ody9wY2kvcGNpZS5oDQppbmRleCBjNTk2MjdkNTU2
Li44YzIyMmYwOWRhIDEwMDY0NA0KLS0tIGEvaW5jbHVkZS9ody9wY2kvcGNpZS5oDQorKysgYi9p
bmNsdWRlL2h3L3BjaS9wY2llLmgNCkBAIC0xNTEsNCArMTUxLDcgQEAgdm9pZCBwY2llX2NhcF9z
bG90X3VucGx1Z19yZXF1ZXN0X2NiKEhvdHBsdWdIYW5kbGVyICpob3RwbHVnX2RldiwNCiANCiB2
b2lkIHBjaWVfcGFzaWRfaW5pdChQQ0lEZXZpY2UgKmRldiwgdWludDE2X3Qgb2Zmc2V0LCB1aW50
OF90IHBhc2lkX3dpZHRoLA0KICAgICAgICAgICAgICAgICAgICAgIGJvb2wgZXhlY19wZXJtLCBi
b29sIHByaXZfbW9kKTsNCisNCitib29sIHBjaWVfcGFzaWRfZW5hYmxlZChjb25zdCBQQ0lEZXZp
Y2UgKmRldik7DQorYm9vbCBwY2llX2F0c19lbmFibGVkKGNvbnN0IFBDSURldmljZSAqZGV2KTsN
CiAjZW5kaWYgLyogUUVNVV9QQ0lFX0ggKi8NCi0tIA0KMi40NC4wDQo=

