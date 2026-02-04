Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8B23E9539A
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 13:13:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vncgx-00063y-5i; Wed, 04 Feb 2026 08:13:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1vncgv-00063q-O2
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 08:13:09 -0500
Received: from mail-southcentralusazlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::1] helo=SN4PR2101CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1vncgt-0000Os-Oz
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 08:13:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zJU/4awMz/XkHgw48sSmp0VuaK//RmKt+Ko2aivXwaMme5nkmgpb6ymaLvrqmtCOw3oagORNZQlfNjYB3VvW900kyZ/ustnxbh8MWzn0I7/gwlj5drbVFIEMsqbmAwHvsR9/T0/gdqZ/tmBPNWLwR6K2ceGaUhyo/+mtKFNlbgnSdSf2drm4KUS8bq/nkH1UzPAOfEKK6V0CGe7DZuh0FgzNVBvSVwxEQvwoSrjQAJYglY6hmgKtBL3S/MGUT0yG5kmvB1t0ODDKlZcFBLeGYx/4WUdmIkixHuNJnMuVb5mhLgO7PRcNJa+b9ihsogQvuYjI67frMhugrJ0UXt6pPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m6v1vmlnzXIylW6hWitik9CDYvBegYgsmxWHLc+DPQE=;
 b=wu9nDFZKU/+aJ6VzFs5JWmcWa3gx13FKVjN7n/3R5ZoJ1QN2J2J+jvwLGLC0dIk4sznoJP5MS5J3qtKWgst9sS0lP7of7GrD+cGDVRXVxS3oUrLJc2vtBZJOaMMIgy08g+/kBgRuacs0i5dij3Vf2AgGxfKxfeBpwGX2ECcnh+wAnntEgv/1garh+wZN5qw4TH06/tL+1DW0eJXEjcrBDsnirqzJi215DDFpwllbBgwAVdWMKRFa0Aw0ViUEClHTsJ6LeCMz1QQ1dE6aheBmUFJimB0I4Kxf6rCkljXrDeL0ggVcSu1NzgOrPgEX49mtwZJcCh1eD/4xxW7DPW1bRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m6v1vmlnzXIylW6hWitik9CDYvBegYgsmxWHLc+DPQE=;
 b=RYZezjVXq9Y9EmFanhJ8dNf6TUthgnj8oAhmWy5TwBvrwWo+LVbeYHSI/wjtfwY4MTkBbUrcOjCmyhK804/pKXIxBBuLhhA7mm1l0UUTRYgcUlReSEltfyGq3APYk/x/gr3tBfFn1NzCN1vjf1epU1jLABFB2w9FnDhhOJAJexVOMJmhAaRzyT/BVNELsgJ9qd0O3JzAdRyfM58a3JzMLYrVHzFTml96kjxywDVyCcyvUCzHHw0ynrCDesFySAjHVl5avFk2RvzaQklq1xea+/O/bKZMfrHcrDToNul0H/zqg+VFLO1hvvnSIBMhv+OIs1PkgCmDdM17S40yn8Mwrw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5063.namprd12.prod.outlook.com (2603:10b6:208:31a::11)
 by SJ5PPF5D591B24D.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::994) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.14; Wed, 4 Feb
 2026 13:13:00 +0000
Received: from BL1PR12MB5063.namprd12.prod.outlook.com
 ([fe80::a0c2:5681:4aca:90da]) by BL1PR12MB5063.namprd12.prod.outlook.com
 ([fe80::a0c2:5681:4aca:90da%5]) with mapi id 15.20.9564.007; Wed, 4 Feb 2026
 13:13:00 +0000
Message-ID: <afaeb40a-f0fd-4bfd-9a5e-f63bc270b872@nvidia.com>
Date: Wed, 4 Feb 2026 15:12:55 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio/migration: Send migration event before device state
 transition
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex@shazbot.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>
References: <20260128105159.10282-1-avihaih@nvidia.com>
 <87343gy82w.fsf@pond.sub.org>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <87343gy82w.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0024.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:3::8)
 To BL1PR12MB5063.namprd12.prod.outlook.com
 (2603:10b6:208:31a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5063:EE_|SJ5PPF5D591B24D:EE_
X-MS-Office365-Filtering-Correlation-Id: b7903512-b0c2-41f4-2f5d-08de63ef1ed4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a0VGbWxXZnBUVTdRM1F6dXhvLzNyTjZXRW85dkZTT3hmbWpHcVpBZE9LZWcr?=
 =?utf-8?B?aHlwRjltZUc4bUN3N21LWnBvOEdaQVh1MjFYZW96ams0UDE4emV4VTBLejhB?=
 =?utf-8?B?VmMwdE1GSnFpWEtTUWpBaXZlWDlQeWNMdnRjSHBXTEIzY29aMlMvZ3g4eXBt?=
 =?utf-8?B?QzBWYy9DaHlMbjhnT3lNSnpDcUdleVdlMHJKZE9Zamw0b0FtVkpsMDVaWU1r?=
 =?utf-8?B?ZW5kS254L0pPMTQ1WGdlY3ViMkhUQzB2SUJjaVh4bU9CWDB4WVRiOUtnR1Ja?=
 =?utf-8?B?R2R1RlpHRVBuK3RzbXg0M1hUbzhmNkhBTkY2dUdhQVpiQnB4RGlZN2xOOFUv?=
 =?utf-8?B?d0pIZW9sZjVya2lESUdLdGdYSXlpdWUrOFNqWVlGdGk5c3FjNGo4RzVURUhL?=
 =?utf-8?B?eGRCeHF3NlpLTUV4bzZMQnRHWS9JUnBmMEpPVmJtUUpCLzdWaGFCWEU3cnJh?=
 =?utf-8?B?QUFuR2xPNXl1azJ0aDNHZmRqMEZ5SzN6VDFxOTV6THNPYzV3QnJ2czRxejBF?=
 =?utf-8?B?UytlMWZGVENZdmhWb2RKZ3NKY0pBbnlBZFlJa3c4d0l0dkQvN0VCQ0tock05?=
 =?utf-8?B?WFY3Q0tTem0vUWRRUW5meUM3aVZsSC9UN2tKVk0wOUFkVHViOXhmdkxIaVJl?=
 =?utf-8?B?ODR2NDRFazJucFdRMmdlUk5HVnRLcXJOYWZnM1VTNlNzRC94ZXZJdnBKZUxO?=
 =?utf-8?B?NUw1Qm5WN2NSWS85OGZZNVJPcFQvTXZxWnFjUVp0clVDdGgrb1U0OHR5NWsy?=
 =?utf-8?B?WjRkSVNhZFlEdkJJWlVPMHpKbUFBNkRrVlVTUUpUWDlOY3lzcThPYnhJMlIv?=
 =?utf-8?B?R1M4SllFblB1NGpTS05uVk5XQ3FnZ1VFcWU1V05TNlFpczVBTzNQL1o5Y0lo?=
 =?utf-8?B?T2JWTlUwUFdMaWQyVUJMaVhjV085cVQ0UEZlVzFQTVU3a2VkVEhITTczNkRp?=
 =?utf-8?B?aG10cnExTStlT1NOek9uMUF5ZTdIYWx3RTJvc25nZlF3MnJKTTlwdW8wYzFG?=
 =?utf-8?B?dTR4U2JSQ1llZEFHV2p5ZlhLREdnNmlRRmF0NnRvUCtZV0d6TUE0OGlFN2Ji?=
 =?utf-8?B?ZjVGQ2RISStiaDNGUzV5RTVLczdHWVZsc01LQnJFODgrNUU0cGJubElMaE5i?=
 =?utf-8?B?eUQ1eC9wLy8wVnNIR0NHcVlJSmplSmtpTmpPb09kdDlNajA3N1c3RzQ2eHJ1?=
 =?utf-8?B?MFNNYTNPL2JoYjBLdUM1V2RoS2V0U1haeHJja3laNGQzUWxsbG5MUGFFU1lX?=
 =?utf-8?B?QVloVHlMUTlxUE1Sck96ckhZa3NySFlTTVdRSDhXdnZ6SjBlVDkxRGI1T3JJ?=
 =?utf-8?B?TURHSFRuTHAzN2dFNUx2eHNZc0REemVQaGhWS25HQ2t2WUNtbDlqUERuSmZz?=
 =?utf-8?B?cFFielN4NGtrM0ZQWWZEaUp2VVlJSEtpaXVGZ0lCOERyWXVjVC9HQSt2UnB0?=
 =?utf-8?B?eGNRc2xNWmFadUlhRGhCVktlVFBBdlEvb2JvekRIUjJOa0hPRVRXTGlpSFgy?=
 =?utf-8?B?ZjVYVVdSczNuMXBPSE5qLzdDN0EwOHBLYWk1RmRmNUJ6M2kwcFg0OEFhREtm?=
 =?utf-8?B?anA1b2VNbDNzRlZHMWFpL2Y3VVhTek4zZnhKVW10U29sRnhmRmN4cGpNaU5p?=
 =?utf-8?B?c1UwYlhCR3g0b2YxZU9wNmZSeHEzYXdEeFRvV1o1Z2NucFdURnhtMVNUWFZL?=
 =?utf-8?B?c1VTWmtXYW9KVk8xVnZMMjByaXZ5bWtPQStYZDhoSTRtVjFCUEdoRE80M2FX?=
 =?utf-8?B?SUJXdTZXek5kd25aazAxUm9xcXRHV25xdXRGbExzRHp1Q3MxakFqY2NwTHZE?=
 =?utf-8?B?SnpjYW1OaEYrZHJRNGRJWkZRUUo0Nld1QzhrNVdVRFA3QVZlZ0I0U0I3UmpJ?=
 =?utf-8?B?Ym1oY0U2bFFZNDNiUnVXckc5MmtQU21BaE5CSHdjZTZGc0ErMjdhY2tlVi9u?=
 =?utf-8?B?Y0NsMUlxUUdsdmdaZGRBR045c08rZDFtQlArMnNhS0tOajk1aWd5Q09xdEVu?=
 =?utf-8?B?ekMxeGtlYmtub0o4aHRuamJOb1JUYy9FdWttdlRXNHpvbmI4YlkvK1NDdmla?=
 =?utf-8?B?YmJsRyszV3lOU2lXZ1FFT2E5bFBVQmpkTG9LdGNOU0RTQ29BT28vOXcrRmU2?=
 =?utf-8?Q?skhHxYag4nWz/j0E3OGwaDZs9?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5063.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDdNVnIxeFoyclJqUEFyZ1VWMzczdytRR1ZGemdVNmhKK00yL0ZIOWF4RU42?=
 =?utf-8?B?bTN3V0t6cDBpRDlRTGNmQTJETnh6QzN0SUhUS1FSaUpnRTFKZVoyN1VHUXl2?=
 =?utf-8?B?OVV3cllqakJCbDJjM3ZBb3ZTZkY0dWx1VGYyb3dFeWw1YnRVNUc0Nnc3NE12?=
 =?utf-8?B?QUpuSkx0cmdIb3hkWmVEcHNhNEpnbHQrOUtIYW5idUF2UENkaEZFcmJETHph?=
 =?utf-8?B?dDRGY1g1YmFIcDR6bFloUk05RVRlckFRcTZ0Q3NZcHlYSXlwcUdDYnY5V0Vv?=
 =?utf-8?B?VnVwbVBzNFNsVlhPVGFuVXZYUG1qVmpaZjNKaG8zK3R0bVE0dzBUL3BsckJj?=
 =?utf-8?B?SmNLNDN3TTJUL1A4Q1YzZ0N1UDhaQmRUckMxVCs0T3ZPNEw3T2ViZlBYMVlK?=
 =?utf-8?B?dEhOZkd1Q1EybkVUSTg3eGFIaFFwT3lIaG04bVdkYnRKU1hjSDZCQktOQjdF?=
 =?utf-8?B?NlZLN2haalkzMmthSXh3MFRrZXdYWEdYTERkMUdiM2R6emxPLy9CODUvNUdP?=
 =?utf-8?B?SS9rUWswU1U3UmhLWEF6RGdsMExPZWRXNlRjdTVMUkJiSjVIVE1wWThMczV1?=
 =?utf-8?B?OWVydUN0dnp6NUFuczg5YTd0NjM0Y0RyL1U5SFpvVkdHRkdqTGNqUXhDYkRY?=
 =?utf-8?B?a2ZFb1JNREFsbXlUUkRXQzVGaCs1Z1Y3a1pDaTFQbnNwektGY2c2czFFZGxq?=
 =?utf-8?B?ZmNTcXkwK3pjSFhRa3FRU2Z4QkFUNHJhS0FlQmhXeUJnYnRrcmZuOFdlU1RJ?=
 =?utf-8?B?K1BDZlhINlFpeC95cmNtN2w5aDBIaTVjMHdMdnZyaDVZZkYxaGxUUlZaZzlm?=
 =?utf-8?B?MXBUajV4UFUxcXJVVm14bkFYOHY2clUzLzg1R1BSQmgxNTVCb0w3ZHhidTZt?=
 =?utf-8?B?MTVvUjFkRUNtb1VQbUlpc2lOc3ZnaVczejJhUDdiaWF4MDF6cEJVSzFPTlBW?=
 =?utf-8?B?WjVQbm1JdlNpQS9NQXhhUFJZQlNpU1BJUUs1cHNoTHc2Y0pTKzFyNkk3VVgx?=
 =?utf-8?B?RHgwdHBHZnV3bmhuQXA0dG1lTWo5czFDRCtkTEFYRHVwVk4vb2NHOHZlSDFt?=
 =?utf-8?B?aVVRa3BsTndCR3h5bVNQdUN0ek9BTkJaWFJJTnRNek5jdzRDUUVKdmoxZ1Bl?=
 =?utf-8?B?V2tKT052b0NsM3ZENFJQN1RKcDFvbDZkVkFtakhqNG12N0UzNzU1dktIV0Yx?=
 =?utf-8?B?V3hVbkFNQWVPNWtVbHMwN2tGQ0YwQUhJRTBLSW9CN1QzSGdWT29NZGFCb2Y2?=
 =?utf-8?B?bklFamhYVEhTOW1pVFd6cFF5UkNiSW9XQk1iYVNCdUV0dEJvSzllb0twREs5?=
 =?utf-8?B?YTNTR3djM29EbGVPOUNCakZ3NEVmWS9SVEpmT1dLenJFbSsyWURZMHpTZlhB?=
 =?utf-8?B?dTJJVFg4Lzk4YUpGQnowNy9DaGMxM3ZvcTg4RDFyaWYyREUyeERaclVYa1o4?=
 =?utf-8?B?aWZGbW10SnUvcFYycnNaakhQR1kvYzNCdXhZcXRvQlk2aHprNC9ZVXhrU2xZ?=
 =?utf-8?B?ZHZjYTZvQzM5NjMySnJZT25lU3YwM2Y1Y1diU1hRSUpid3Fwd2JnREc1OTk4?=
 =?utf-8?B?UytXbVgwTWprazQwa2dya3YrL0NjeUd1dXhWeUpxZ2tUZm5uQlE3M0FmMW5U?=
 =?utf-8?B?N09QeVpLaUlKc0Foa1ZIazQ1TzhkOHFlcHFXeG4vQ0IvaVRaeEliUUUwUytB?=
 =?utf-8?B?bmp6ZnFzeGJ6aThoZmFaUS9pNHI4NVBSbUdpOHhselVoZkErMmh4M2I1TFRD?=
 =?utf-8?B?UXBjd1hBZitjb3ZKeWZ0Vy9kVk5DNWF1TzhmWjJQZFlzZHhqdVl1UHpRZExI?=
 =?utf-8?B?VGZScVFqcysrcjllNkFhMFJlL0ZDT1IydnlRSDVFYXc4T3VoWGVENmpSK09a?=
 =?utf-8?B?M3Fya2hWWGd1Q2pTTXZTZ3FsUk4yWm9yYkxOcGllM0FVQ3JKcGdkdlAxUmRX?=
 =?utf-8?B?VXAwdHFCRUpSNG5Ia2VtOWJhWE9FVTc2UWhOVnhQRXNxYm50VUk5Z3R3VWlG?=
 =?utf-8?B?UGdUOGVPZHdrVEwvZTVxVGIvNjM0eWV1Mk1LUFAweFdIRWd5ZGVXaU1JVGUy?=
 =?utf-8?B?bjRMUDZnZG5qTkgzRHM1TXVNK21GUStvTnhxSXRLVFFlN0hYeno4d3ZKZXU1?=
 =?utf-8?B?Y2pheHMvM3BYMVBieUE4Z0dETlpYbmtpaXdsWDh5cUVGS1NXVTZkUkJNVGNo?=
 =?utf-8?B?TTE2STM3UUVUbjRvRTBMUDRxQVF2UHQ3aE5OOWxyZEVrZ0ZRWkhoK1VFbzdr?=
 =?utf-8?B?eVRiVUhMMndYWkxjbWlPdDJOY3daUkZkNlZXcDd2d0JzWHh1QkQvWVlhK2lJ?=
 =?utf-8?B?d3pRc0RlZXIwNjlDaFMyR2pLa0pOaWllSDY0K3VPcmVrVFBxZGRwdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7903512-b0c2-41f4-2f5d-08de63ef1ed4
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5063.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 13:13:00.5518 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YUSxTRFF5/vn4q53vDi+jr3x8uzFSaBi4RAbConTm+w2m91f4HQTSYBv3VW2rmFfmSQ+zOCAOEwRpX5qTElNtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF5D591B24D
Received-SPF: permerror client-ip=2a01:111:f403:c10d::1;
 envelope-from=avihaih@nvidia.com;
 helo=SN4PR2101CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


On 2/4/2026 3:03 PM, Markus Armbruster wrote:
> External email: Use caution opening links or attachments
>
>
> Avihai Horon <avihaih@nvidia.com> writes:
>
>> Currently, VFIO device migration event is sent after the device state
>> transition has been completed. However, it may be useful to additionally
>> send a "prepare" event before the state transition, to notify users that
>> it's about to happen.
>>
>> For example, in some cases with heavy resource utilization, stopping the
>> VFIO device may take a long time. In time-sensitive scenarios, the
>> management application that consumes the event may be notified about the
>> state transition too late.
>>
>> To overcome this issue, send an additional "prepare" migration event
>> before the device state transition.
>>
>> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
>> ---
>>   qapi/vfio.json      | 33 +++++++++++++++++++++++++++++++++
>>   hw/vfio/migration.c | 18 +++++++++++++-----
>>   2 files changed, 46 insertions(+), 5 deletions(-)
>>
>> diff --git a/qapi/vfio.json b/qapi/vfio.json
>> index a1a9c5b673..de41211f1d 100644
>> --- a/qapi/vfio.json
>> +++ b/qapi/vfio.json
>> @@ -66,3 +66,36 @@
>>         'qom-path': 'str',
>>         'device-state': 'QapiVfioMigrationState'
>>     } }
>> +
>> +##
>> +# @VFIO_MIGRATION_PREPARE:
>> +#
>> +# This event is emitted when a VFIO device migration state is about to
>> +# be changed.  Note that even if this event is received for state X,
>> +# the VFIO device may transition to a different state if the original
>> +# state transition to X failed.
>> +#
>> +# @device-id: The device's id, if it has one.
>> +#
>> +# @qom-path: The device's QOM path.
>> +#
>> +# @device-state: The new device migration state that is about to be
>> +#     changed.
>> +#
>> +# Since: 11.0
>> +#
>> +# .. qmp-example::
>> +#
>> +#     <- { "timestamp": { "seconds": 1713771323, "microseconds": 212268 },
>> +#          "event": "VFIO_MIGRATION_PREPARE",
>> +#          "data": {
>> +#              "device-id": "vfio_dev1",
>> +#              "qom-path": "/machine/peripheral/vfio_dev1",
>> +#              "device-state": "stop" } }
>> +##
>> +{ 'event': 'VFIO_MIGRATION_PREPARE',
>> +  'data': {
>> +      'device-id': 'str',
>> +      'qom-path': 'str',
>> +      'device-state': 'QapiVfioMigrationState'
>> +  } }
> The QAPI schema is fine, so
>
> Acked-by: Markus Armbruster <armbru@redhat.com>

Thanks, Markus!

However, in later version [1] we replaced this new event with a new 
state in QapiVfioMigrationState.

[1] 
https://lore.kernel.org/qemu-devel/20260202173406.13979-1-avihaih@nvidia.com/

> Whether the event makes sense I have no idea.  I'm leaving that
> judgement to the migration and VFIO maintainers.
>

