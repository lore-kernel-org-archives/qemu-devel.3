Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70CFCC25B4F
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 11:40:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4JAp-0000jM-Nf; Tue, 07 May 2024 07:39:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s4JAk-0000hx-W3
 for qemu-devel@nongnu.org; Tue, 07 May 2024 07:39:52 -0400
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s4JAh-0008MK-Dk
 for qemu-devel@nongnu.org; Tue, 07 May 2024 07:39:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1715081987; x=1746617987;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:mime-version;
 bh=cDAWfRKLm2qR7K5vEQaicsUV3BaitQR/HROEbCfJw1k=;
 b=GoDNQ/IWbRok/2J8HjNsk63xA+AsFKMTDoPQY9BeqAwtqBnA28WfZ+/Y
 xk1MVkGwtt78G7E91hZRHn3h0D+sXF4HWyvrKDLLua7BfUfBRVamKRlHl
 PFMV2cRHei2noF3B/L5WsdVxl1ciMAZFJXdPWiZ8KLwsNjn108WLQPcC2
 qSe7Njdd/W5cS2SScpx2MpVgzrz6PLhT0vsUDdJsaZHD425/1X1Nvl6Ax
 QQq31F+uj45khX+UiZFvc8zbpfeomLKOGqu3/zYh76DdbvwVRLnPHcW5P
 E4K6jjKqMbUkNwLFrFNEMHDVpEHQntHt7rvZucaOUjWmtlgIUuiuw5WN9 A==;
X-IronPort-AV: E=Sophos;i="6.08,261,1712613600"; d="scan'208,217";a="12086593"
X-MGA-submission: =?us-ascii?q?MDFhHil3BlD8Q93dpQm2/R/P90X6xtg6zDdzYk?=
 =?us-ascii?q?cDZvlEDWTAMp51+TMbao5VSncLRiL1+MOLuGulyv2fuTHvEOYNeoLLVe?=
 =?us-ascii?q?o6XK78NIsSbhiIGxJhFmRH/SCdmpSwwIbLun5y2I4GX0At9s3dnkk2T3?=
 =?us-ascii?q?CnN1xm0pfvlK+a3krJXY/iGw=3D=3D?=
Received: from mail-am7eur03lp2233.outbound.protection.outlook.com (HELO
 EUR03-AM7-obe.outbound.protection.outlook.com) ([104.47.51.233])
 by smarthost4.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2024 13:39:40 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AEjIMdL93664WSwM6qTPu9StqdYwetulcO3UM99kr5vMiKR4naq3fbXgWTms3NFPoIsbFctg4+zfHsJj73nPetXlNI9PGUPRcIAZeQQJDdmNCrpYY/l7QDL2wSTP/9Ek4pGLwaBhzpXHkC85WTEqOND/ilwQ/VXoEXlQYXyWMJtI1hfjyjpry+5xu9VY7B8d1kiphTfUFnwjIvgTW/CzlvGmoty9rZSFiPM2/FlLZMmPe4oM5VqI2Q5JobvCWnCeGi25JijulSpNrLNjyt71S+cGONKElF9Ddc3ArhMmMEwfvmMMf6O8zEV5xLDV4MTIC2zyZhnkUqkA1HJdBVhN8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cDAWfRKLm2qR7K5vEQaicsUV3BaitQR/HROEbCfJw1k=;
 b=XaJ8rJq82hZGDhPM5LlYGn6hdQicojM+7zLXBhR9OcNLXS6Kd0a8EPRur4vthxglhX4AQFnKufWljKZNeyju1+nc6HN4xi3S7cMlmhtZB5ydXLMCjDn+UTwd9RQhsiwDr7nYrUL0k2+RGEM9GkFlo5G/7pcIQOUKiiFQkkvwKTQDcLjB8kXMsqm9taHTvefpAA4d1RUXBVDcoMEaeI3sHdMoigaSY7jUzVUuFj3A3bcOLaGGRhj9bbZlESmIK9GWJtJJGQ2R+t+xcq0UwZNe0VjuSmzrRE7uLpszPM9tHqm5AcCZpsPGbxWwEzGQMEPzBOlWRXKNl4t2WkZ13qBNKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by VI1PR0701MB6926.eurprd07.prod.outlook.com (2603:10a6:800:19a::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Tue, 7 May
 2024 11:39:39 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%4]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 11:39:39 +0000
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
 <chao.p.peng@intel.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH v4 19/19] intel_iommu: Check compatibility with host IOMMU
 capabilities
Thread-Topic: [PATCH v4 19/19] intel_iommu: Check compatibility with host
 IOMMU capabilities
Thread-Index: AQHaoGBZHA4yxbQU40uR2coQMri8SbGLpbCA
Date: Tue, 7 May 2024 11:39:39 +0000
Message-ID: <fcd43b9f-f598-47b4-b7df-d0f0f7c3b704@eviden.com>
References: <20240507092043.1172717-1-zhenzhong.duan@intel.com>
 <20240507092043.1172717-20-zhenzhong.duan@intel.com>
In-Reply-To: <20240507092043.1172717-20-zhenzhong.duan@intel.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|VI1PR0701MB6926:EE_
x-ms-office365-filtering-correlation-id: 7c482813-2f88-46df-553f-08dc6e8a6109
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230031|1800799015|366007|7416005|376005|38070700009; 
x-microsoft-antispam-message-info: =?utf-8?B?SUhMS09PamxVa1VZZ015ZUNMUnh1aGhOalRhSDdKU0VEU0hMaHJ5alJzaGp4?=
 =?utf-8?B?YXVSVTF2N3A5RjBVeGlFdFFGQXNsM2JWcW9ZMmtWc0lJdWZEbHJQSHM0aGFq?=
 =?utf-8?B?SHdlak0zdmRua1NhTkVrNmpqdHF5eG5STXJrWUhNYmZRU0w0b0pPaWsrRlda?=
 =?utf-8?B?ZjJmNUlacHNERmpsanAzSkp3Qml3Z0x1SU1xUXZvejZWalUyQkVrUGp1UVgz?=
 =?utf-8?B?Y3RzTFgyVDFNWDNxbVlUMnNxTlNOSlZyc0JIZU4zMUpjY2FNTEgyVDUrNmZz?=
 =?utf-8?B?WkNSVWNsQkdtdW1ETkdlc2lTM0FnMVQ1ODNSY2VlMVhjaXhaUlNqdjNzbXhz?=
 =?utf-8?B?eVE4K0dQeGhDeDVUUExyY3N3STg4QUJmSTdvVFFnVnNlNEYrRGloK3Z4T2cw?=
 =?utf-8?B?dzNhZ2hadTBuT1d4R0hZdXQ1TnN6OWdrRjlqeVpVNlRScHlQb0tmTGV5MW9S?=
 =?utf-8?B?KzN5bEs2WVk3cWdRQlgvTGJRWis4V1o2U29BS2JtQTRUek85VnhpQjk0dzBG?=
 =?utf-8?B?cDcwaHBLV0JtTWIwTlNJdXRDMWJ0OU5PUXEzN1lXVDVDa2YxeFltMlJ2bDVD?=
 =?utf-8?B?NnhVdjZBUUZ4ei9kNkNORmFjbTRySDVyZHhmVjRob3M4NmxDMEhSR2VHZE1B?=
 =?utf-8?B?NElzbTZmS0h3UmkvSnY3WmxSVDVRWUpYQXE4dHFTenV4aWlXRHU0SEZSZ2FG?=
 =?utf-8?B?S3FlTUJNV1VyMWQ3QTlVdXVKMGM0Q2hDUlR0Q2NJd1YxcGtscFNieG1DWWR6?=
 =?utf-8?B?WmJmMXZwcm81MVhDdFpBaVdNQnQ5Zy8veWdOMmIvSkx2eTBrWWdVSWp4eUE2?=
 =?utf-8?B?YjRoQ2RaWXFlazRKc092c0k5Qm5DVElZbmwvTEl4WmFKWktKVlU4SUlXT1pC?=
 =?utf-8?B?aXk2b2VGS2g1Qi95ME9qbkZ5TG1TdzJmV0Z0NlJsR1plRnpKdWNrMlZZWnRv?=
 =?utf-8?B?NmFxckoxdU4wcE5YajNnZHllK2ljR24zc1hmK01xS1RDeUJDWVQwQjJZS3hQ?=
 =?utf-8?B?Rm05TnUzTk4xNFQ2eWorUzQ3U2FhSENIRGV1dnBuUnM2d3MxbmVOU3NySE81?=
 =?utf-8?B?ek1aRE5uRlV3Q0tRaWtZQ243ZUJxU3BpQWxzOTNMdVpmZUhOVTZOQUlSc2M2?=
 =?utf-8?B?aG1wT2V1NDE4TnI0eDJLYUUvRnp5RFBoVGtOUHlpODFUdDZxN001UWdVSEJC?=
 =?utf-8?B?RzcxQ1M0STFnZEJuZWV5b0J5elgzUncxMXV4cFRaTUpieHlpcUVTSWNNeWgy?=
 =?utf-8?B?YVFsMU1vbXN3Z1NFVENQMVVjMDRDMFhZUmI0MTFveTVwYVVmTjhOUkptbWFo?=
 =?utf-8?B?YUx1QlJuK0RMWHhkZmQ1MzEyYU42RVh1UEdIT2svL0xBUVBpVDlsZjNIWW5s?=
 =?utf-8?B?S2JDc084TE5OWC9GQ2xucG94Qm5YREtidllWcmF1dWRMVCtqTVI0clNBRVY1?=
 =?utf-8?B?Vi9tb3hJSHVpc1RDUi9Jc0wvTzVZRFp3R3RxR1hjOFNpQm11QkN6T3J6RkZh?=
 =?utf-8?B?b0NNZnJ0Qk5wRkpsc0VIV213UEhiWWpCTlJSWEF6YTVBL2JKQzA2NVJXcDkw?=
 =?utf-8?B?djBrdm9pLzY4QUUwclQvVmJkSVVNS2FNc3ZFZ3ByVXdnb0dQR0xnQUt6UVRn?=
 =?utf-8?B?NVEvTXI0OWVSaDNab1NCWVNMdWtFTkJ2Q3hrMzFIcEpYcnFjYkdMS3NaWWpS?=
 =?utf-8?B?bWlaSWh5RDFuMFdBZTN6NXh2bEV2TnR5NHZGdTZCMmIvZXFSNkk0L3BHajYx?=
 =?utf-8?B?L2RZbDc1VDZlOGZBY1Z6Q0l1dUlTd3h6SE9YQWxiSHdrNTM5NmZ6NWU3ZW9q?=
 =?utf-8?B?OUZEVjRSRTZsdGhiTzRHQT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(7416005)(376005)(38070700009); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?anFZREp5SDQydUZPSjVqVmdNQ1pDWWxZT2JRMFRINmwzNERJcXZlY09INm1Q?=
 =?utf-8?B?MzM4RWYwVXcvZUc3ckkxWUsyWnRTTWxlRTkrVTl6OWMvcm1YdXlFaTdUa3BM?=
 =?utf-8?B?dktXSzd4RDd6a1RKSG1jRm1telZJeHpPaVdRbDFQNlJveWdMNWUxV3pCUCtp?=
 =?utf-8?B?dlpzTjl6cFU1RCtHRHM2M3BQd1pGQjBoSkpQdit2NzNqUTdpQm00MUxqRm0w?=
 =?utf-8?B?M2xMZjVqcTRjbTBCOGc2b043Ri9BLzB1Um5CY1FTdDZPU1pNcnlzMkFLUXJL?=
 =?utf-8?B?NmJZTEV6cGR2Q0RiM2c4RFd1czM0R1hIYUNvR0YxZWJyYmZqNWpLbmxMRDdM?=
 =?utf-8?B?Z2x2UE5zQmYwc2MyZVhYK0VxSkp4L1lSYVRTMFNBdldIS0cvckV2S2RjUjI2?=
 =?utf-8?B?WjAwMnpxRDhMdVByU0haTUpvVmpqRklSRWQrcTg5OWVuQWd2Y0pnUE1KUlQr?=
 =?utf-8?B?RnNHVmMwVGRONEE2VjFwN2QwRGJGWlZjWUFlaS9HNnBBNi9IRzVzWWJxWEJF?=
 =?utf-8?B?OXlsN2xxZmR2ZXRuVlVCL3VEU0pkeERod1FPeEVISnIrS1F4eWhNUW94MCtH?=
 =?utf-8?B?L3hIVm1kd3FzN1Jmc3hqTFdjUVc4cUUzMXpLanBqS2YySXNmOHR1ZkluU3cv?=
 =?utf-8?B?cE1jcC94SVBDM0pLQ3p2ZzBkMnoxdHlSdE9mdmliQ1dDOHVZaEVyS3FWTEIx?=
 =?utf-8?B?OGRNMHV3T2FVTXZXVWV0amYvK2tHNkxwTHd6QmNyaG9sYnpLcFR2UGhqTVMw?=
 =?utf-8?B?ZG1nQ2xkSnhIZGZyTjRHWHZON09RbzFUbTUwVXJtYzlodGpXMGNLUmd3QXhD?=
 =?utf-8?B?S2lHUGpwMnJIakRQTWh4TWw4ODJQdTBWKzRQczRreEZKTXdqQVh5RWY4T3J0?=
 =?utf-8?B?VFVDSzBvOGxNOHF6SVRWRmJONmZZWVVjbEdrT2M3RVBobzh6OTRNK3VVdXVI?=
 =?utf-8?B?dk4zdGNHb2lKcWQyUDlUa2FSOFpabHBXaEJkR0NDcGgxMlVxa0ZKUnRuTjR2?=
 =?utf-8?B?OThWeXhuOVFwV3JqTWtVZDJTdi94NjJoVTRUMW5SZmpPdWMwQ2dENkhYTXdI?=
 =?utf-8?B?cC8vMlY0NzBJclRKWXhPVzBjZGtTWGpYYUlmYk9pWkVMQ0FRd1lwMEowUlcw?=
 =?utf-8?B?UVdhYmpqTTNyMlNTNlZjcnNDWDd1NUxlMVg2NXFBYTRrSktEN1NPblBUY2Za?=
 =?utf-8?B?MVBLdzVTUzFqMTgrNHRzMHhOd05YQ3lydEZRVWM0eGlGTUlFVWVKaDNXN3FK?=
 =?utf-8?B?TjJUSG9STG9qZTZUWm9qMG5uaitUdUZJUEZHbHZZeHRLSG1DaGhYRFAwQ3ll?=
 =?utf-8?B?aFM3ckpVd1BGMU4vd3NOVk0zbHphWUNIUDQyVUVoT0lMS2J0ME1ZK2NYQW1r?=
 =?utf-8?B?Y1FNbkFiRHNOZ1c1UVAwdmFhTUR3b21HZWNYK3RCV2xVdDdTWmRhaDQxcjBo?=
 =?utf-8?B?MWZob00rZ2VzZVFNeUx3MmsxbTFHd1dURmw4VWRydmlTcTdmVHlFM0RYcDFj?=
 =?utf-8?B?Z1pjNWpYVUVpaE84TTArYlloSzlWdWlyUVJUNlMyb1Q5Snc4aFlHVTVRZzFB?=
 =?utf-8?B?TUZudHNoeEdlamgxSDdYbUJsa2lJQU1HRHlTQ05xbmpsenpUVWM5Zys3MDhY?=
 =?utf-8?B?blVhOEZJa2ovMkZGb0dMWWFxRkxtZXo0WEdhOXZYcVVtN0d5ZzdZWFVjcGFF?=
 =?utf-8?B?bGxEK0VNemJPZThpVnlOVm9Ua3FWb09JUk8rc2NtM1YzS3lMT2JZMHNRL1l2?=
 =?utf-8?B?TzI5UzJEb3phcTc1aks3dnFpYUwxK2NIN1FCcVdzM25VYmpkdGpncHpPREpZ?=
 =?utf-8?B?UTJZcEtxTzljam9hZGdXVUhqT2lCcjZuSTVnUWVXTEJTTHVNUXV0cnQxOGl2?=
 =?utf-8?B?UWgzemtTbm5jWkZ3TmhKZk54NWNleVBIN0ZlbXJGcnpTTjZncXMwR2FuMXNa?=
 =?utf-8?B?aURkaHZmNHhvUEZzV0lyeWY5MjQ4bkJMN1dyVUpjckYxUll4azJYZzUwWjdZ?=
 =?utf-8?B?OXkzZHA0cXhDRDc3TVRHOWhQTnNhWkJQMXFHL3dJeG80TFkzYkw0ZTRRM3lz?=
 =?utf-8?B?MlliOGxoVXArbldrU1JVY3JPVktNNzdJclBpZVdxeUc5M01PK3pEUzNuTXk3?=
 =?utf-8?B?a1B3RG9PaVEyNTlWZ1czWHE4akQzYUVnTzVmbTVSMFdZM1NwNnY1ZWhVSTFh?=
 =?utf-8?Q?+IOV0TWIy8gzzYG459+bagQ=3D?=
Content-Type: multipart/alternative;
 boundary="_000_fcd43b9ff59847b4b7dfd0f0f7c3b704evidencom_"
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c482813-2f88-46df-553f-08dc6e8a6109
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2024 11:39:39.1808 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8GCkY4alf8bfM1U8ujqp4ZylW2Ai3XX5iEZ3HxvHSeGh3zFMnH1FPO0IS+HpW/flPNWiyiFNZ8Pmenen/TFwAutAMEQgbvjnd1gnQNvb9pU/OPS5p6BmNi+2E4zeICo6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0701MB6926
Received-SPF: pass client-ip=80.78.11.85;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost4.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
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

--_000_fcd43b9ff59847b4b7dfd0f0f7c3b704evidencom_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGkgWmhlbnpob25nLA0KDQpPbiAwNy8wNS8yMDI0IDExOjIwLCBaaGVuemhvbmcgRHVhbiB3cm90
ZToNCg0KQ2F1dGlvbjogRXh0ZXJuYWwgZW1haWwuIERvIG5vdCBvcGVuIGF0dGFjaG1lbnRzIG9y
IGNsaWNrIGxpbmtzLCB1bmxlc3MgdGhpcyBlbWFpbCBjb21lcyBmcm9tIGEga25vd24gc2VuZGVy
IGFuZCB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlLg0KDQoNCklmIGNoZWNrIGZhaWxzLCBo
b3N0IGRldmljZSAoZWl0aGVyIFZGSU8gb3IgVkRQQSBkZXZpY2UpIGlzIG5vdA0KY29tcGF0aWJs
ZSB3aXRoIGN1cnJlbnQgdklPTU1VIGNvbmZpZyBhbmQgc2hvdWxkIG5vdCBiZSBwYXNzZWQgdG8N
Cmd1ZXN0Lg0KDQpPbmx5IGF3X2JpdHMgaXMgY2hlY2tlZCBmb3Igbm93LCB3ZSBkb24ndCBjYXJl
IG90aGVyIGNhcGFiaWxpdGllcw0KYmVmb3JlIHNjYWxhYmxlIG1vZGVybiBtb2RlIGlzIGludHJv
ZHVjZWQuDQoNClNpZ25lZC1vZmYtYnk6IFlpIExpdSA8eWkubC5saXVAaW50ZWwuY29tPjxtYWls
dG86eWkubC5saXVAaW50ZWwuY29tPg0KU2lnbmVkLW9mZi1ieTogWmhlbnpob25nIER1YW4gPHpo
ZW56aG9uZy5kdWFuQGludGVsLmNvbT48bWFpbHRvOnpoZW56aG9uZy5kdWFuQGludGVsLmNvbT4N
Ci0tLQ0KIGh3L2kzODYvaW50ZWxfaW9tbXUuYyB8IDI2ICsrKysrKysrKysrKysrKysrKysrKysr
KysrDQogMSBmaWxlIGNoYW5nZWQsIDI2IGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2h3
L2kzODYvaW50ZWxfaW9tbXUuYyBiL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KaW5kZXggNzQ3Yzk4
OGJjNC4uMTQ2ZmRlMjNmYyAxMDA2NDQNCi0tLSBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KKysr
IGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQpAQCAtMzUsNiArMzUsNyBAQA0KICNpbmNsdWRlICJz
eXNlbXUva3ZtLmgiDQogI2luY2x1ZGUgInN5c2VtdS9kbWEuaCINCiAjaW5jbHVkZSAic3lzZW11
L3N5c2VtdS5oIg0KKyNpbmNsdWRlICJzeXNlbXUvaG9zdF9pb21tdV9kZXZpY2UuaCINCiAjaW5j
bHVkZSAiaHcvaTM4Ni9hcGljX2ludGVybmFsLmgiDQogI2luY2x1ZGUgImt2bS9rdm1faTM4Ni5o
Ig0KICNpbmNsdWRlICJtaWdyYXRpb24vdm1zdGF0ZS5oIg0KQEAgLTM4MTksNiArMzgyMCwyNSBA
QCBWVERBZGRyZXNzU3BhY2UgKnZ0ZF9maW5kX2FkZF9hcyhJbnRlbElPTU1VU3RhdGUgKnMsIFBD
SUJ1cyAqYnVzLA0KICAgICByZXR1cm4gdnRkX2Rldl9hczsNCiB9DQoNCitzdGF0aWMgYm9vbCB2
dGRfY2hlY2tfaGRldihJbnRlbElPTU1VU3RhdGUgKnMsIFZUREhvc3RJT01NVURldmljZSAqdnRk
X2hkZXYsDQorICAgICAgICAgICAgICAgICAgICAgICAgICAgRXJyb3IgKiplcnJwKQ0KK3sNCisg
ICAgSG9zdElPTU1VRGV2aWNlICpoaW9kID0gdnRkX2hkZXYtPmRldjsNCg0KV2h5IG5vdCBwYXNz
aW5nIHRoZSBoaW9kIHBvaW50ZXIgYXMgcGFyYW1ldGVyIGRpcmVjdGx5PyBNYXliZSB5b3UgaGF2
ZSBzb21ldGhpbmcgaW4gbWluZCBmb3IgYSBmdXR1cmUgcGF0Y2g/DQoNCkl0IHdvdWxkIGFsbG93
IHVzIHRvIGFsbG9jYXRlIHRoZSBWVERIb3N0SU9NTVVEZXZpY2UgbGF0ZXIgaW4gdnRkX2Rldl9z
ZXRfaW9tbXVfZGV2aWNlLg0KDQoNCisgICAgaW50IHJldDsNCisNCisgICAgLyogQ29tbW9uIGNo
ZWNrcyAqLw0KKyAgICByZXQgPSBob3N0X2lvbW11X2RldmljZV9nZXRfY2FwKGhpb2QsIEhPU1Rf
SU9NTVVfREVWSUNFX0NBUF9BV19CSVRTLCBlcnJwKTsNCisgICAgaWYgKHJldCA8IDApIHsNCisg
ICAgICAgIHJldHVybiBmYWxzZTsNCisgICAgfQ0KKyAgICBpZiAocy0+YXdfYml0cyA+IHJldCkg
ew0KKyAgICAgICAgZXJyb3Jfc2V0ZyhlcnJwLCAiYXctYml0cyAlZCA+IGhvc3QgYXctYml0cyAl
ZCIsIHMtPmF3X2JpdHMsIHJldCk7DQorICAgICAgICByZXR1cm4gZmFsc2U7DQorICAgIH0NCisN
CisgICAgcmV0dXJuIHRydWU7DQorfQ0KKw0KIHN0YXRpYyBib29sIHZ0ZF9kZXZfc2V0X2lvbW11
X2RldmljZShQQ0lCdXMgKmJ1cywgdm9pZCAqb3BhcXVlLCBpbnQgZGV2Zm4sDQogICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIEhvc3RJT01NVURldmljZSAqaGlvZCwgRXJyb3Ig
KiplcnJwKQ0KIHsNCkBAIC0zODQ4LDYgKzM4NjgsMTIgQEAgc3RhdGljIGJvb2wgdnRkX2Rldl9z
ZXRfaW9tbXVfZGV2aWNlKFBDSUJ1cyAqYnVzLCB2b2lkICpvcGFxdWUsIGludCBkZXZmbiwNCiAg
ICAgdnRkX2hkZXYtPmlvbW11X3N0YXRlID0gczsNCiAgICAgdnRkX2hkZXYtPmRldiA9IGhpb2Q7
DQoNCisgICAgaWYgKCF2dGRfY2hlY2tfaGRldihzLCB2dGRfaGRldiwgZXJycCkpIHsNCisgICAg
ICAgIGdfZnJlZSh2dGRfaGRldik7DQorICAgICAgICB2dGRfaW9tbXVfdW5sb2NrKHMpOw0KKyAg
ICAgICAgcmV0dXJuIGZhbHNlOw0KKyAgICB9DQorDQogICAgIG5ld19rZXkgPSBnX21hbGxvYyhz
aXplb2YoKm5ld19rZXkpKTsNCiAgICAgbmV3X2tleS0+YnVzID0gYnVzOw0KICAgICBuZXdfa2V5
LT5kZXZmbiA9IGRldmZuOw0KLS0NCjIuMzQuMQ0KDQoNCg==

--_000_fcd43b9ff59847b4b7dfd0f0f7c3b704evidencom_
Content-Type: text/html; charset="utf-8"
Content-ID: <1FD7B05F1A09484394A22D9CDA9275F3@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64

PCFET0NUWVBFIGh0bWw+DQo8aHRtbD4NCjxoZWFkPg0KPG1ldGEgaHR0cC1lcXVpdj0iQ29udGVu
dC1UeXBlIiBjb250ZW50PSJ0ZXh0L2h0bWw7IGNoYXJzZXQ9dXRmLTgiPg0KPC9oZWFkPg0KPGJv
ZHk+DQo8cD5IaSBaaGVuemhvbmcsPGJyPg0KPC9wPg0KPGRpdiBjbGFzcz0ibW96LWNpdGUtcHJl
Zml4Ij5PbiAwNy8wNS8yMDI0IDExOjIwLCBaaGVuemhvbmcgRHVhbiB3cm90ZTo8YnI+DQo8L2Rp
dj4NCjxibG9ja3F1b3RlIHR5cGU9ImNpdGUiIGNpdGU9Im1pZDoyMDI0MDUwNzA5MjA0My4xMTcy
NzE3LTIwLXpoZW56aG9uZy5kdWFuQGludGVsLmNvbSI+DQo8cHJlIGNsYXNzPSJtb3otcXVvdGUt
cHJlIiB3cmFwPSIiPkNhdXRpb246IEV4dGVybmFsIGVtYWlsLiBEbyBub3Qgb3BlbiBhdHRhY2ht
ZW50cyBvciBjbGljayBsaW5rcywgdW5sZXNzIHRoaXMgZW1haWwgY29tZXMgZnJvbSBhIGtub3du
IHNlbmRlciBhbmQgeW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZS4NCg0KDQpJZiBjaGVjayBm
YWlscywgaG9zdCBkZXZpY2UgKGVpdGhlciBWRklPIG9yIFZEUEEgZGV2aWNlKSBpcyBub3QNCmNv
bXBhdGlibGUgd2l0aCBjdXJyZW50IHZJT01NVSBjb25maWcgYW5kIHNob3VsZCBub3QgYmUgcGFz
c2VkIHRvDQpndWVzdC4NCg0KT25seSBhd19iaXRzIGlzIGNoZWNrZWQgZm9yIG5vdywgd2UgZG9u
J3QgY2FyZSBvdGhlciBjYXBhYmlsaXRpZXMNCmJlZm9yZSBzY2FsYWJsZSBtb2Rlcm4gbW9kZSBp
cyBpbnRyb2R1Y2VkLg0KDQpTaWduZWQtb2ZmLWJ5OiBZaSBMaXUgPGEgY2xhc3M9Im1vei10eHQt
bGluay1yZmMyMzk2RSIgaHJlZj0ibWFpbHRvOnlpLmwubGl1QGludGVsLmNvbSI+Jmx0O3lpLmwu
bGl1QGludGVsLmNvbSZndDs8L2E+DQpTaWduZWQtb2ZmLWJ5OiBaaGVuemhvbmcgRHVhbiA8YSBj
bGFzcz0ibW96LXR4dC1saW5rLXJmYzIzOTZFIiBocmVmPSJtYWlsdG86emhlbnpob25nLmR1YW5A
aW50ZWwuY29tIj4mbHQ7emhlbnpob25nLmR1YW5AaW50ZWwuY29tJmd0OzwvYT4NCi0tLQ0KIGh3
L2kzODYvaW50ZWxfaW9tbXUuYyB8IDI2ICsrKysrKysrKysrKysrKysrKysrKysrKysrDQogMSBm
aWxlIGNoYW5nZWQsIDI2IGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2h3L2kzODYvaW50
ZWxfaW9tbXUuYyBiL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KaW5kZXggNzQ3Yzk4OGJjNC4uMTQ2
ZmRlMjNmYyAxMDA2NDQNCi0tLSBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KKysrIGIvaHcvaTM4
Ni9pbnRlbF9pb21tdS5jDQpAQCAtMzUsNiArMzUsNyBAQA0KICNpbmNsdWRlICZxdW90O3N5c2Vt
dS9rdm0uaCZxdW90Ow0KICNpbmNsdWRlICZxdW90O3N5c2VtdS9kbWEuaCZxdW90Ow0KICNpbmNs
dWRlICZxdW90O3N5c2VtdS9zeXNlbXUuaCZxdW90Ow0KKyNpbmNsdWRlICZxdW90O3N5c2VtdS9o
b3N0X2lvbW11X2RldmljZS5oJnF1b3Q7DQogI2luY2x1ZGUgJnF1b3Q7aHcvaTM4Ni9hcGljX2lu
dGVybmFsLmgmcXVvdDsNCiAjaW5jbHVkZSAmcXVvdDtrdm0va3ZtX2kzODYuaCZxdW90Ow0KICNp
bmNsdWRlICZxdW90O21pZ3JhdGlvbi92bXN0YXRlLmgmcXVvdDsNCkBAIC0zODE5LDYgKzM4MjAs
MjUgQEAgVlREQWRkcmVzc1NwYWNlICp2dGRfZmluZF9hZGRfYXMoSW50ZWxJT01NVVN0YXRlICpz
LCBQQ0lCdXMgKmJ1cywNCiAgICAgcmV0dXJuIHZ0ZF9kZXZfYXM7DQogfQ0KDQorc3RhdGljIGJv
b2wgdnRkX2NoZWNrX2hkZXYoSW50ZWxJT01NVVN0YXRlICpzLCBWVERIb3N0SU9NTVVEZXZpY2Ug
KnZ0ZF9oZGV2LA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgIEVycm9yICoqZXJycCkNCit7
DQorICAgIEhvc3RJT01NVURldmljZSAqaGlvZCA9IHZ0ZF9oZGV2LSZndDtkZXY7PC9wcmU+DQo8
L2Jsb2NrcXVvdGU+DQo8cD48Zm9udCBzaXplPSIyIj5XaHkgbm90IHBhc3NpbmcgdGhlIGhpb2Qg
cG9pbnRlciBhcyBwYXJhbWV0ZXIgZGlyZWN0bHk/IE1heWJlIHlvdSBoYXZlIHNvbWV0aGluZyBp
biBtaW5kIGZvciBhIGZ1dHVyZSBwYXRjaD88YnI+DQo8L2ZvbnQ+PC9wPg0KPHA+PGZvbnQgc2l6
ZT0iMiI+SXQgd291bGQgYWxsb3cgdXMgdG8gYWxsb2NhdGUgdGhlIFZUREhvc3RJT01NVURldmlj
ZSBsYXRlciBpbiB2dGRfZGV2X3NldF9pb21tdV9kZXZpY2UuPC9mb250Pjxicj4NCjwvcD4NCjxi
bG9ja3F1b3RlIHR5cGU9ImNpdGUiIGNpdGU9Im1pZDoyMDI0MDUwNzA5MjA0My4xMTcyNzE3LTIw
LXpoZW56aG9uZy5kdWFuQGludGVsLmNvbSI+DQo8cHJlIGNsYXNzPSJtb3otcXVvdGUtcHJlIiB3
cmFwPSIiPg0KKyAgICBpbnQgcmV0Ow0KKw0KKyAgICAvKiBDb21tb24gY2hlY2tzICovDQorICAg
IHJldCA9IGhvc3RfaW9tbXVfZGV2aWNlX2dldF9jYXAoaGlvZCwgSE9TVF9JT01NVV9ERVZJQ0Vf
Q0FQX0FXX0JJVFMsIGVycnApOw0KKyAgICBpZiAocmV0ICZsdDsgMCkgew0KKyAgICAgICAgcmV0
dXJuIGZhbHNlOw0KKyAgICB9DQorICAgIGlmIChzLSZndDthd19iaXRzICZndDsgcmV0KSB7DQor
ICAgICAgICBlcnJvcl9zZXRnKGVycnAsICZxdW90O2F3LWJpdHMgJWQgJmd0OyBob3N0IGF3LWJp
dHMgJWQmcXVvdDssIHMtJmd0O2F3X2JpdHMsIHJldCk7DQorICAgICAgICByZXR1cm4gZmFsc2U7
DQorICAgIH0NCisNCisgICAgcmV0dXJuIHRydWU7DQorfQ0KKw0KIHN0YXRpYyBib29sIHZ0ZF9k
ZXZfc2V0X2lvbW11X2RldmljZShQQ0lCdXMgKmJ1cywgdm9pZCAqb3BhcXVlLCBpbnQgZGV2Zm4s
DQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEhvc3RJT01NVURldmljZSAq
aGlvZCwgRXJyb3IgKiplcnJwKQ0KIHsNCkBAIC0zODQ4LDYgKzM4NjgsMTIgQEAgc3RhdGljIGJv
b2wgdnRkX2Rldl9zZXRfaW9tbXVfZGV2aWNlKFBDSUJ1cyAqYnVzLCB2b2lkICpvcGFxdWUsIGlu
dCBkZXZmbiwNCiAgICAgdnRkX2hkZXYtJmd0O2lvbW11X3N0YXRlID0gczsNCiAgICAgdnRkX2hk
ZXYtJmd0O2RldiA9IGhpb2Q7DQoNCisgICAgaWYgKCF2dGRfY2hlY2tfaGRldihzLCB2dGRfaGRl
diwgZXJycCkpIHsNCisgICAgICAgIGdfZnJlZSh2dGRfaGRldik7DQorICAgICAgICB2dGRfaW9t
bXVfdW5sb2NrKHMpOw0KKyAgICAgICAgcmV0dXJuIGZhbHNlOw0KKyAgICB9DQorDQogICAgIG5l
d19rZXkgPSBnX21hbGxvYyhzaXplb2YoKm5ld19rZXkpKTsNCiAgICAgbmV3X2tleS0mZ3Q7YnVz
ID0gYnVzOw0KICAgICBuZXdfa2V5LSZndDtkZXZmbiA9IGRldmZuOw0KLS0NCjIuMzQuMQ0KDQo8
L3ByZT4NCjwvYmxvY2txdW90ZT4NCjwvYm9keT4NCjwvaHRtbD4NCg==

--_000_fcd43b9ff59847b4b7dfd0f0f7c3b704evidencom_--

