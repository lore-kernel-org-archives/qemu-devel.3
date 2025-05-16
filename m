Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E507C3ABC9
	for <qemu-devel@archiver.kernel.org>; Fri, 16 May 2025 19:10:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uG0Rc-0004Tz-IQ; Fri, 16 May 2025 15:10:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1uG0RZ-0004ON-0i
 for qemu-devel@nongnu.org; Fri, 16 May 2025 15:10:05 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1uG0RU-0007wQ-Dt
 for qemu-devel@nongnu.org; Fri, 16 May 2025 15:10:04 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54GGgXV8024572;
 Fri, 16 May 2025 19:09:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=Eu0hxyF9Ki/iiBrbaJJF+s3Svk8bAh51otTWolntONA=; b=
 SvK+Gv8AQoGtLQCIRvm/npz56DqzHXdIEFfvmlKCUqoPUN6mtHcnsu/METF/ozvS
 57MgPiWDJAzEIPo5CDxRlmb4wV+tY+Rf1uWXCQn6s0aYBHeTpo+Pc/mWZw1OGAZy
 XlKIVEK91EEkLYEtdBEoKgk7uqV9WI0j4oIk/YG7AwmDqKMmnyqkLxqxY1Ankb62
 hk/Qe4TQyuS41mo0wraVZh4R/qA5ukBwDRoxRLl5ld/d2QwFUru7JNUFmP9cxdts
 NUdzKeKIB3lVhuuUoBQhhTs1WxxQj84JotUiIi7XiplYsQvKcE+PQzC6f4XL+mFv
 hDB1EXa9OSAUm0jnYn8nEg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46nrbf211j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 16 May 2025 19:09:51 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54GJ5wga026648; Fri, 16 May 2025 19:09:51 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam04lp2172.outbound.protection.outlook.com [104.47.73.172])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 46mbtaxrf8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 16 May 2025 19:09:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UasmQWVDcVsZ4HK657ZK2HOS4mbTPT1I5o931a3OEyrQMYJEHSsHQIcW+mtO7e3fVChvUeA/iQIXYkgV+kX2tAkkMpKr7DMuAqXBVxd4gmVKA6Mo5zYW2GJCGhoClP4n6d0i5t4X24B28Il94rjhyGIPFlUcCD6EnTOWEeuHuQXp8BNaq9UfTc2r1HMw7ci1Y7wY/q+jei1L0GgJcXQKz0C+OZIxUUsKqm48SBiiAScAx5ZkjFtC+0GX0a0Fj/SOy6SFUPc8Vn4f5HaivT8prZ5QWy4Bbm4UHgqDKaCfCdwKT3Q0ZQWc0R+UQ8Ci2f+vDmd+uAQgCCRyzqHEcUNaNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eu0hxyF9Ki/iiBrbaJJF+s3Svk8bAh51otTWolntONA=;
 b=QX7GSpZKfMKjD0WaIykY7vCrx3zlNYc9WseqOFEnRuwArP/99whLbFS40BUcEJ/WNx7ILegb0tK8Rsrc8JXKRMoAHEf0Uww0LM+3MBu8w++JO71wbknYJnM9lfYBcbiCehiqiYzzB/DZMha9Cm7di8AA/83sHhK/rLP/ZPgqm8MDfh/zJq8oGZdDT7nKbvU+PfbaWc04K3rfRRtYFehZdJli1meNGxchR+ER102kRa6a7IZA+fKErVjRw0P2upwc2nEC9LX17giROsr4h3e5Y/NqlGaSA+9dhVkkPR6gkRYxQgEDfbdiH/CS9LruOTkqzx18MA9zw4gQqx1w7U2Pnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eu0hxyF9Ki/iiBrbaJJF+s3Svk8bAh51otTWolntONA=;
 b=GDytDH+yckMSyvhD1bd2jGadRJkopyvVtvUFh35V/svBUEAD5AZAsJWAPHVrRiswNkGO4/XnQTu8IRChew94vg68BsE9F59c+07hL8iam3OKiRWsmzb6YoFFRttrJcIkGsCCYBvmMcK6lXhhSjH1rKgN4ZmiINRMviFOGdIBe58=
Received: from DS4PPF18D5A7206.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d0d) by CH3PR10MB7457.namprd10.prod.outlook.com
 (2603:10b6:610:159::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Fri, 16 May
 2025 19:09:48 +0000
Received: from DS4PPF18D5A7206.namprd10.prod.outlook.com
 ([fe80::f77e:d409:2c52:ecd]) by DS4PPF18D5A7206.namprd10.prod.outlook.com
 ([fe80::f77e:d409:2c52:ecd%4]) with mapi id 15.20.8722.031; Fri, 16 May 2025
 19:09:48 +0000
Message-ID: <50a648fa-76ab-47bf-9f6e-c07da913cb52@oracle.com>
Date: Fri, 16 May 2025 12:09:42 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/7] Move memory listener register to vhost_vdpa_init
To: Markus Armbruster <armbru@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: Jonah Palmer <jonah.palmer@oracle.com>, qemu-devel@nongnu.org,
 eperezma@redhat.com, peterx@redhat.com, mst@redhat.com,
 lvivier@redhat.com, dtatulea@nvidia.com, leiyang@redhat.com,
 parav@mellanox.com, sgarzare@redhat.com, lingshan.zhu@intel.com,
 boris.ostrovsky@oracle.com
References: <20250507184647.15580-1-jonah.palmer@oracle.com>
 <CACGkMEuD7n8QVpgBvHSXJv7kN-hn4cpXX9J8UO8GUCzB0Ssqaw@mail.gmail.com>
 <87plg9ukgq.fsf@pond.sub.org>
Content-Language: en-US
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <87plg9ukgq.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN7PR02CA0014.namprd02.prod.outlook.com
 (2603:10b6:408:20::27) To DS4PPF18D5A7206.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d0d)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF18D5A7206:EE_|CH3PR10MB7457:EE_
X-MS-Office365-Filtering-Correlation-Id: d98eef3e-4744-4350-7c8b-08dd94ad3a34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RnNiSFpxL0orV3JpQ01QUGNxZ25RMDdJaUNxV2tiVnErMjJYa3BBS0RkdWdM?=
 =?utf-8?B?RTBXV0dhUUNuNnFsdGpJNzBKOVRNV3I4N2svdlJSdVFXcHVPUDFWM1cycTZL?=
 =?utf-8?B?M2xQWk9rVFhQbnFlc0IzTXZ4M0VHVzhjdEUyZG9GQy8vRnpSeFJNVytjbWF5?=
 =?utf-8?B?ZWpnbnpaN2R4YXVneTJITWh5cE9odEVjeW5FeWVRM3VoNmVLVjViR2Z4K2ta?=
 =?utf-8?B?WkMwK01tL05kU3dnS3FQcFJuRWcxVlZCNG0xb0wrUXloQ0g0VTRWT1FycC9t?=
 =?utf-8?B?S1BnUno5TlBYRmpxVjF3TlRsd01CSHVIaVRGL0QrRi9rU2RFbFhkSVRzeGxW?=
 =?utf-8?B?ZVlUODZ6NU9mTWZUMG5ZMkFacEgxY0hvV2RpT3p1dUtReDJROUVhUXM3U09a?=
 =?utf-8?B?UEswRGhHVko2dzlmTGN3bXFtSlBJbHBaYzFHMXI4MVdRTEx5YmtqOFp2eE1u?=
 =?utf-8?B?dm03NXlqT3FwZC9WVE1DNmNpWVgvdm5iajhWOWxxZzNJYjdzeVhYOWgwZEk0?=
 =?utf-8?B?TFdaTUkyYkcvQ0pSdFhyM0EyZG9tQjVHNG5ST2syRERyc25reU5tVE1CaFpp?=
 =?utf-8?B?RUw1MVd5NHlBdHhFa2F0ZFE4TFZPWUtkSEhoWnpmdlZzWWU5aUprZEN6WDR1?=
 =?utf-8?B?bTVKbW9pY1RPNm1tM1FhaUo3SHNTSVl3eEtmdkU0cVFIZ29taDQwYlplQ3k2?=
 =?utf-8?B?MzREZ0p0L2UyL0RJYndLaFdtaUFZZFBZOHdxL3Q4YVVYQ0VsODF5MkdrazdB?=
 =?utf-8?B?ZmRQSTRYT29NNzRYeDdzU0E3WG1YUU8weEJoelVOWSsvRGFJTkR5UzZ3dERn?=
 =?utf-8?B?VXBEZUZPb0FZdXBIWitPWVlvSGYxVTd5RHAyaXBNOWRFU0VSaldtWGdWOHpB?=
 =?utf-8?B?LzF3dkpuMkVUNkEyelJnVlNSMkluL1dMMU5yMGJ0aGNPbXUzdjZPcUF0bm5z?=
 =?utf-8?B?bWxNRGUwZWs0N0pHdGxHUWROQmoxSE4yTks2YjZQcVpQNXc5RTVyeGdaNUdM?=
 =?utf-8?B?MEVwK3J2VWhuZFBEK2tnNHBiZnhWRHorOGt0QkhRcG00WE5LWlh3SGVlVFpt?=
 =?utf-8?B?TTlpMCtHWkxab3lXaHBiYjY3clhhTFA3Q1J0WW1SV3phMUsrRFdTcDBrbm1D?=
 =?utf-8?B?bnl6ZXlZdkcwaW9URVhQbCtPSDNJZ1psZHJoTnIxMUxzUDhtV2ZDT3duK3B1?=
 =?utf-8?B?RnpCaVpJb2QrTFJoVnBuSGMvMjFzUTBuaXlTY2ViTXdtVmd2NS96QmJXbWVo?=
 =?utf-8?B?Vm45MWJQRFRjcCsraTVmZno3VStXblQvRjA2VlYrMHVnTGtLUnJwaDU3bEN0?=
 =?utf-8?B?M0FWYnBQalozOXJjRjZZOCtSUUlxa1RaOHFkUzVjMGQ4LzRtanVMWW4yRHRh?=
 =?utf-8?B?Qnh3U1k4K01JTzdnNkQ3cVg1TlRqTG5xR2hUYXJBcUp1U29WMGJMMWFQREhx?=
 =?utf-8?B?TGRRcUVaWXVaSStaaURydHFjUzR5eVd5V0VHWHpGWVdkdjN4N25xU2hadkFv?=
 =?utf-8?B?TEh3N3R0ZUxYeXdtN1k5ajRISUFiV0tTTkFKWWRTUjVmbHhXYVVQS1g5UXh4?=
 =?utf-8?B?bGNUWW01WVp2dWo3dGUzWHg4Ym5kOWZJV1BVekZmN2k3c25rY2Z5aHA0QjUw?=
 =?utf-8?B?Rml1YU5PWGU5UXlwendHU2FGKzZ0TWNKcGt6U0hjU1paR054Q0o4Y002Rk9w?=
 =?utf-8?B?TXZnbmZoQURNRW1Hc0JadnNWYUoyZmxIa2lQU0JjKzVNUm5JU2lkM0pKV1Jt?=
 =?utf-8?B?TnZXV25OQzNtM3dmNGNTV2xaNklxS0RGR2E5bWdwZ2cvUXJKRS9jMnIveDd0?=
 =?utf-8?B?VGhFamNGYURBdUNhVE1WWXR5bnlhcWVZWWFGbGk1eFhUb3pFYStxYnNVVzRh?=
 =?utf-8?B?TE1DQzJLekROYzJQU2V2NjdKTHNkK2FGdy81Vkl3cjBUclE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS4PPF18D5A7206.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0RsZUoxQ1FpenpSWDZ5UCtQeW1odi96N2FkSnZxYUFtUVNkbjRsR3IydzAr?=
 =?utf-8?B?WUtHV2hTQ3lGa08rZUZBRDBlYUd6ZWZmN2RGKy8zOWNKaHFSSE9jTEdvZWtQ?=
 =?utf-8?B?WGJneEZndXhzZXpJWjhwRU1TaTBuTzVOREMyTWFjVHdYVi9CZU5uVWNORjZp?=
 =?utf-8?B?THkrY0x5bFRUdUpLLzc1Nis3T2RkaUgyZG00eFhvZzZkSUt3dmRKdDVZZUUr?=
 =?utf-8?B?clIrS3BvRnNCNHhDdGRFdy9kNngwS1I4MzlWZDhtaFdtUGszM1NxVWs0TUl5?=
 =?utf-8?B?TzlvRVhxdzQ3L3ZwdTd6ci94MnB6d1NGbnE3TmR1VkRyQ1BuM1JHc3AwV0Y0?=
 =?utf-8?B?dzkzUFlHVTVqaDJET0d6TDB3Q3dUZ3BWOHVrc2JPdkxKNGtRYVI3SVQ4Qmho?=
 =?utf-8?B?U1NvaXZsZ2g1VkRJZ3NtVGhCK1o2UjE5eGQvOEYvTndyWU5BeG5NWC81WHU4?=
 =?utf-8?B?UTN5a29TMlRNR3FUajNNVmtKR2JjMkRDa3dXN3JjcGpSL0NsbVhtckhhZEZT?=
 =?utf-8?B?ektueTVsYXlJZkhwMXhuR0hKM3lKcnFJVHZYK3B3NTdOOG83dGhCeHNaWlBm?=
 =?utf-8?B?UUl1ZnNUOCszOGMwY1ora1krNWNXN1E2OTZFS3lnbnpFYllSZUlCZXU1bUFl?=
 =?utf-8?B?RlB0NFJUWGRxeThKalVtRkxhNmEvUFFCYnA4cjVhb0lTaTVRbUhzRUdoTVU0?=
 =?utf-8?B?TFNiNXFNV2s0MElTeUJMWlBFZ0gzQmIwbVh3bktKR3FidEhYbGdwVXRRUndk?=
 =?utf-8?B?eEV3am9YZzZFa2I1dE9KeDR5TW9yS2dzM1hQZmd2NzZSeHVKNW53NjZ1UFZl?=
 =?utf-8?B?MUZQMkVsZTNtZ1FtMWFOeGZGVVdrakkwcHdaeFVtaTV0WmtWaCtZMU44R3ov?=
 =?utf-8?B?ZG5IL25jZk1makE0TitZVjZOMVVxaGZITnQ1d0tLSk1jMTQ2S0pkTVBKdHhK?=
 =?utf-8?B?a3RsbGgxZlJGdWlLUmo2WCtoQlU0STY0a0JzcnFkczhqYVgyUjV4ZlBUa3hE?=
 =?utf-8?B?SXFTYURQUHBlTjVCd0NOTU1DSnZvTHYrdDk1NXp2T1NXV3h0MXRmREJ2VTFm?=
 =?utf-8?B?ckJrV3JFQ3NvUlRJanBjY2c5UWxKbVVPQ2ZPMk9HL3hDWjhmR1dJa1pWYkk0?=
 =?utf-8?B?ckhaRThmOHYrd0JRdzNSMXBxQ2xwRE0xWDRJZytndVRLenFZcXNVN3VtcTZz?=
 =?utf-8?B?bmZVVW1BWTRyZWJOZzE4eTdwamhBWVkwQ1h1VEVvQWpwL2UyM29IREdQU1ox?=
 =?utf-8?B?Y1FiTHkxU1EvODNCaVljNzNPTm1saVlCckJ1UjlFTXFvaGRxSnFHQktDZmF1?=
 =?utf-8?B?Nnc1MnEraXZZQzgrQ0xLaUdxZjhsWGxIZWxGRHpGV2lUSlQvM3dmUE5BYmRH?=
 =?utf-8?B?VU84QTBjT0xrMDZ5ZVBqMjBPNFRTb3lMeW5GRmxDcmRTckVJTG5RRnR2R1Vm?=
 =?utf-8?B?Um9kYnI1RTZPN1NPUVYrVENKTzI0ckVqNENEc0c0VlRUTmUwaCtCOCtjUm5T?=
 =?utf-8?B?Y2s4YUJJQzc5ODRXajZ1MHQrejJjVHdpVXQ4TjdyY0JKVGhhUE1xN210NEhr?=
 =?utf-8?B?SjIyY1BNaHlNZVYrNFpCaGxFRnJRYW9oVXVtMGQzSUtyRll1RVNNR3ZHUkEr?=
 =?utf-8?B?cGZVYlgwM24rZjNmaG1pVUVFcEJWMzVUZzIwWi9UekY5UXJ2eEFJZnFMMzFM?=
 =?utf-8?B?eEN2SVh0bFdtWDlXMGh6OWRKNU1JVmtxTlJsbHBQOEJkWGRJcnFnOU80dHBr?=
 =?utf-8?B?alVHVlZuUEFFdXVxVVlWZEl4UG1xN2EvZUkvcW1JN0IwWTBXWTdxU0orTDFB?=
 =?utf-8?B?akVNdDBNc0hkNWUvU2dXNjdCY01KcWdwVXliWm1rSDFhdE8wNkYxTE1qUmNJ?=
 =?utf-8?B?NG4xZ1JyU1ppWTJKZmJYMjN4QWtFemJRc2RVNlNpOXFQYUpjbHAyQ0NFYnNT?=
 =?utf-8?B?TlhFYWJnY1huOFRFOHY5TDc2OTF1WGRtWGx4ZFJ4azdSZ3BRKzN3clhmRkRL?=
 =?utf-8?B?Uk5ZQWszWVJvU0hFR0FuTlB6Um4yY2YzNzVOOXBZQW5ZVG1wLzFacEtRcjRM?=
 =?utf-8?B?NkYvb2dMVEV1L2xBWFdjM21lOWV6WGxUZUk1cDFPNGZ6V2RTTXc5QWRLbEpM?=
 =?utf-8?Q?bDgjCXdl2X5lakm4TYpLVSrEX?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: GgU0tXPzrcPfRB2+PRzKFApjUwpd8FokjMeuZevcA+O8N0j4na0vStTgiXQC/az9drv6TpteB8aYCT0dOlHGqupVn9uUtD5Gl72JRgbaB9kCNXEdKG6VEQgSalbKY2xdusNMY7zFoeRt66KNzTEMcnbdjk7fwOeO12V/n5/7HTdzOYUy9w8PBj3hbVMTjW5DNvp0qy7irqjCaM/Lr+cgK3gz87x6TRVDfjT2ZLKL+LlWyXFr1ZAujGL3Yt5JEozwRu4frxoEjYFCmq/weqC781nrFTPz/cSTmdb44te2lxpVRA2BqobJzed9sM0BYmgESePeMKSbHtvVeY7QV/fGtiZP036egM5qnhOUew63tGZe3gZj3poSPQX9ywew9LJs3SalVnJBMX87w54XqNnRUFn1HYCEWECzaetbymb0h9j6qc6Lm0+dsyMCHMgdpKijl+Y/afczeuQdfjTlg84A3piTVWrTWFJksZeKdg7ZMpm+6TC/4uWZjAlDGB4HviYGGlIl85vBjQC4o0hWVlr/QfDasCedTcSnwPqrKJNDjQp9FV5KXIWH7w9GX+1HuADQTvF+XICSVhftETnHFuJih8s5SNsv8MSjahD6QdHc4oQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d98eef3e-4744-4350-7c8b-08dd94ad3a34
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF18D5A7206.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 19:09:48.5199 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w44ev+eZJOLhU8bCuw6slHF6dNtReTSnYbEgkIYkIuG2Pr3RfDkV/oPbf2e+tm8l8KaPrw9psBVOWZCwpY0oFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7457
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-16_06,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 malwarescore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 mlxscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505070000 definitions=main-2505160188
X-Authority-Analysis: v=2.4 cv=Xc2JzJ55 c=1 sm=1 tr=0 ts=68278d80 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10
 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=xl2_EiIQh6CXOsAojwcA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:14694
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE2MDE4OCBTYWx0ZWRfX2TwhAcf7fNV0
 N4yaAc/poIeE9P6WSfjcDOaxzRaXKVw/ruDcmBeL+ru5tk9oqfA3NsmwGlxAo7nMBCY0Rok/gdJ
 hvNPeRtzab9RfWLBDyH7t3A4tpGak/iiiImo6SN34B3bfF34zRYEBjVL7hk5b2CecdjINKdGalX
 d5ApgY2IsM1lh4CWa6AjgElVdkCT0UPW87k0doG14/xcwHq4IOM/dYIMUVL5/ePrZ4bDAmhLOpr
 5WsYX7pJW1jvnZFotPuu7cIC4PtciI+57kBRQFhE/3O6ptBqqfsC5GQVp2MPBWTS8PfTW7yh6Oa
 sPvvEaD+0VqpOsQynFMqEY1clTZQTQDn5gNSTjntpC5d/gdmHDTsoIJ6LuCD3XGEvmHyx+saSDm
 M96wLvXA031KDwK2R/+oIAx8L8r5iJ+tLQNd10brd1JuqiZLIL6y375AQ3Idlvb18JMscxBf
X-Proofpoint-GUID: IMKA9lo8g3rbPwGDeDIvAV7Idc6__qO0
X-Proofpoint-ORIG-GUID: IMKA9lo8g3rbPwGDeDIvAV7Idc6__qO0
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=si-wei.liu@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 5/15/2025 11:40 PM, Markus Armbruster wrote:
> Jason Wang <jasowang@redhat.com> writes:
>
>> On Thu, May 8, 2025 at 2:47 AM Jonah Palmer <jonah.palmer@oracle.com> wrote:
>>> Current memory operations like pinning may take a lot of time at the
>>> destination.  Currently they are done after the source of the migration is
>>> stopped, and before the workload is resumed at the destination.  This is a
>>> period where neigher traffic can flow, nor the VM workload can continue
>>> (downtime).
>>>
>>> We can do better as we know the memory layout of the guest RAM at the
>>> destination from the moment that all devices are initializaed.  So
>>> moving that operation allows QEMU to communicate the kernel the maps
>>> while the workload is still running in the source, so Linux can start
>>> mapping them.
>>>
>>> As a small drawback, there is a time in the initialization where QEMU
>>> cannot respond to QMP etc.  By some testing, this time is about
>>> 0.2seconds.
>> Adding Markus to see if this is a real problem or not.
> I guess the answer is "depends", and to get a more useful one, we need
> more information.
>
> When all you care is time from executing qemu-system-FOO to guest
> finish booting, and the guest takes 10s to boot, then an extra 0.2s
> won't matter much.
There's no such delay of an extra 0.2s or higher per se, it's just 
shifting around the page pinning hiccup, no matter it is 0.2s or 
something else, from the time of guest booting up to before guest is 
booted. This saves back guest boot time or start up delay, but in turn 
the same delay effectively will be charged to VM launch time. We follow 
the same model with VFIO, which would see the same hiccup during launch 
(at an early stage where no real mgmt software would care about).

>
> When a management application runs qemu-system-FOO several times to
> probe its capabilities via QMP, then even milliseconds can hurt.
Not something like that, this page pinning hiccup is one time only that 
occurs in the very early stage when launching QEMU, i.e. there's no 
consistent delay every time when QMP is called. The delay in QMP 
response at that very point depends on how much memory the VM has, but 
this is just specif to VM with VFIO or vDPA devices that have to pin 
memory for DMA. Having said, there's no extra delay at all if QEMU args 
has no vDPA device assignment, on the other hand, there's same delay or 
QMP hiccup when VFIO is around in QEMU args.
> In what scenarios exactly is QMP delayed?
Having said, this is not a new problem to QEMU in particular, this QMP 
delay is not peculiar, it's existent on VFIO as well.

Thanks,
-Siwei

>
> You told us an absolute delay you observed.  What's the relative delay,
> i.e. what's the delay with and without these patches?
>
> We need QMP to become available earlier in the startup sequence for
> other reasons.  Could we bypass the delay that way?  Please understand
> that this would likely be quite difficult: we know from experience that
> messing with the startup sequence is prone to introduce subtle
> compatility breaks and even bugs.
>
>> (I remember VFIO has some optimization in the speed of the pinning,
>> could vDPA do the same?)
> That's well outside my bailiwick :)
>
> [...]
>


