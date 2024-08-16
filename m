Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72098C531DC
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 15:20:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seykC-0000W5-MP; Fri, 16 Aug 2024 11:20:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1seykB-0000Vb-2E
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 11:19:59 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1seyk8-00088j-T4
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 11:19:58 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47GC8tEN020972;
 Fri, 16 Aug 2024 15:19:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=v0aIuRIdrIN/n2ZPhfgkcgX2KxYbZ0HPMn7jMTT6ocw=; b=
 j+M8NMCdNWhO168cWuyRXjLoiSiF5mK+DwS/MZU1h4QQKr72SPCXpuOnM9B1d5Ma
 dbHanM+snJv5sy95QlLCQGsJ0VSdsbZKuJT/wqn6wfEYcp7BX6lxFrdIw76UTNJd
 M1/aIAfOJsoXpasMWNgEheyPPUGkpm0bqoFqhXYiVCT9B+7NWx745sHhc9SrEpaU
 Y+K0TdDu20qxBIHQzxTwxoISba951JbXRJkuDF9GSj+KaG5s3yrLIvygDilXmVzy
 HbMfNZH9IeH1w7nDekntS2KLTHny/rWBBtwVjV/3vPiKnl+0KU85ezdsFZTQ8DXN
 8eTeYuJNsiyYDSn+TJEfNg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40x039cj5n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 16 Aug 2024 15:19:52 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 47GEU5sU000759; Fri, 16 Aug 2024 15:19:51 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com
 (mail-dm3nam02lp2049.outbound.protection.outlook.com [104.47.56.49])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 40wxncdend-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 16 Aug 2024 15:19:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y3SGPfIGqUo+JcB5WfFQpi3uBEiQspSIOVVBjVU55uB6QrtXkrRzabaQscKSXMMKt8/NDbmtSjUgPBBmofZKEIH7euSxd/BdHKXRCbD9acnG9wA6foLuFBLfh7CNn9Ro5hGoWckR3bOBPPcTQs9Ye1no4J0pOqhY0sq/iimM616U+MxfdjEg0Tv5Ry8fa+0vg7HSDjjLvzTymF/Yxkw10rtEl+wmrpyHFIxeUsjmHKiB17y8tzMryO9K7QdpT+rkaz+u0u+eHbuRX1xVODioTst5YOISxfpdvHyE+irg51WV4Hxi6sKY5OLBIkMeeJjY5om45d75CE73ppr+064MgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v0aIuRIdrIN/n2ZPhfgkcgX2KxYbZ0HPMn7jMTT6ocw=;
 b=l64Shlhbj3mnu6E14DKPcQedPhSDs89fEAPBWHtb+Kq3yN+AZe9AdnTiP1Sg/q5BbuP9Y25sE/9gFF8Jc41cziGlFmHSBrNVqzlFmJDBfYIOXKeDuHvIpe1VQ3yi/xWMo5zRnm/2qs0PiO8ISFOSNX8RelGUleyx3uUr7kOVsV0yfxRJjp8uy55NXeyqbq99C4CGx8pZkg7NSvSbx0a8Wo9LxWKkEPWzMxfoN9D/MSjK+Zqp2AO9pk72v8gXuXblsvs6Kj6Bjz3LPwJIUrr7MyJSd9c8FdjlYbT6xYBTTVTKzRyQrFnPUL0lKQ+4M0NQSNwOC+5qQ4HlMXF+/sOOqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v0aIuRIdrIN/n2ZPhfgkcgX2KxYbZ0HPMn7jMTT6ocw=;
 b=fGiNkxskMFBM0dzj59gMr4Z9bo8dIrXKxWFVoaUEWGrmNfSVNRdF8xEPpddVh3Y90jz3qX0frhaj1+K3AHcXa8du9IIfDn6dmfcKLtDESD9m/e7NPeOkr/okksQL5hNQY7hjXoYkAp55e11TTonjjphK2hanpXCkH4eRk1FKp4s=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by IA1PR10MB7388.namprd10.prod.outlook.com (2603:10b6:208:42c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.10; Fri, 16 Aug
 2024 15:19:48 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.7875.016; Fri, 16 Aug 2024
 15:19:48 +0000
Message-ID: <588cd3f3-629a-451e-bc21-f255b5e0690c@oracle.com>
Date: Fri, 16 Aug 2024 11:19:46 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 00/11] Live update: cpr-exec
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <1719776434-435013-1-git-send-email-steven.sistare@oracle.com>
 <Zpk7Mf2c7LiNV2xC@x1n> <ZrCi8DWCKFiBHQAQ@redhat.com>
 <5776f6b4-c55f-4e56-aac5-bee7e441ad15@oracle.com> <Zru4AaTmBIAGnyDr@x1n>
 <46b63356-9602-4fa2-9d31-186f5f85151f@oracle.com> <Zr9q4muKZmYCf9mv@x1n>
 <Zr9tYsmy8j2t8fq0@redhat.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <Zr9tYsmy8j2t8fq0@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0302.namprd03.prod.outlook.com
 (2603:10b6:408:112::7) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|IA1PR10MB7388:EE_
X-MS-Office365-Filtering-Correlation-Id: 0938f3f1-93e0-49f5-1c53-08dcbe06de1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dlIrUEQ1RWdPWjlLWE53NTJGVEV1S2E2MTFTSCtJenBHSkQ1ZUxrejFhTjI0?=
 =?utf-8?B?Tlh2Z1ZhZURXM1NkSDRYUmxWQ1ppaG02WmcwQVpFREhrR1RLb3hyemVjZVNX?=
 =?utf-8?B?bGdvbDcwT2lCK1VqWHJCNUZVRjJpTGZHeTE0VFJBa3NDVWE0WDJ1WCtSQVFS?=
 =?utf-8?B?dTFjdVZtYXgva2I4K2Z1ajlVeTNjbjRacXZWL1JzYUEySzlsbzlmWHlWc2ZF?=
 =?utf-8?B?blVWcjhweVowSTVMTXp4Q0Vad3hKejdoY0xzQzJPYzk1ZWdSblYwdUEwYVJu?=
 =?utf-8?B?Skw2UWp0NG9tNHpPQktJMFdidUdKK0IrNkRYOEpQVXE5c2tQRWxhQm5PdC9R?=
 =?utf-8?B?SVpnT1FrVG1IZzJaWVh1VTZnUTFUTjZNV3hhdnRUWUJSakpGQ0J3TndaZnlz?=
 =?utf-8?B?MjNpQ2kzOXh0dVVNVFhuMTdWTHkxNDhTb2V6MDZpek5FOXpGWDdzd0txWHY5?=
 =?utf-8?B?alZCZjl6elhkeWlWaXFVTGdVTDE5OGdudklOVkdqd3pWSnlTTStPRXpNcmxM?=
 =?utf-8?B?OWl5VEdWbjN0ZUVsVmd1TkNrYzd3bXBlL2oxN2RWYXM2cTJKK3B1N25ZUm5B?=
 =?utf-8?B?VWJUMmtHZk1LUEtVRE9XNFBXTG0yUCt3Y0VVVFpHWXlLakdYYWV5NW9yMHQ3?=
 =?utf-8?B?YlYxV0xJd2V5UjVMTUoyY0xPSDRVblhDOFh0cnp6bUlkb0VDWGh4RVcxUEVR?=
 =?utf-8?B?Z0lDTHN3UlRWeW1ZNHJTY0M0bXpWeCtJT0NHTnpVd1NBUVp3UGhkS2xYQ1BU?=
 =?utf-8?B?VDVvZWp4VksydEIzeXdNYWJJQU9RSFJ2K0VHZ1lXeVIzdFJYQ2UrREdHRkhn?=
 =?utf-8?B?c0U5KzRMSWxFckM5azlPbnhHK1hKVmNXcnF1cjZqVWR4dFF2RWxQcWZVYlJ6?=
 =?utf-8?B?akxiaUNqVjRCcFB6OE9xcXp0ckZGVVpxOVM4czNSOGwyNXV2MlBxTGxGcVJP?=
 =?utf-8?B?aTViOGE4MVZuRDFvZ3hwRXZVaEgvU2FHaUREdmt0LzRIeXMrOUNleWFQb2tN?=
 =?utf-8?B?aFZSN1djL2tIaG5RRUc3c0ZPUncxVUthKy94S016U0IyLzN5TS9HZE5YS2xq?=
 =?utf-8?B?UXh6aFVIZ2crNXlMUVBRTis1OThLSkZxbGVEaUJzUjl6SVJCY20reXBtNkRw?=
 =?utf-8?B?N2JyTzAxOCtxeWJTaFZFVHhSWjQwOFZTb2NDaURGRVYrUy9vVk9EQktubmx1?=
 =?utf-8?B?YlEreUUyV0hDbSt5d3V5YjJHeU5KK2pRT3Q1V0xQZjhoc05xT1EwRStreDFR?=
 =?utf-8?B?N2hlaXVUMFpaNjc4T3o1M1BQVUJyUVBORDhjWGdLQm1ucllUOVFwV2hpSFZm?=
 =?utf-8?B?QTZTdS9vRHNuOGFsYUsyT0p6SWw5cWRGZkx6T0paNWVHS1JnQlZnYlBZS3Fy?=
 =?utf-8?B?bnZreStZbnh2bUNTQVVFdVNDZkoraUh3dkVLRkVzK3YrUGlYYndYN0xYTk0v?=
 =?utf-8?B?Y1Y3UlREYXBMNHBRakpDZ1YzTi9DeW1DTEsrZlcyTHpHaTVhMjZLRm9tUDNF?=
 =?utf-8?B?ZWVTa3VaOXVwZEJQTDcrK1c4anRENFppbnZhaVRjUWtVOWhtR21Sa0V4aFox?=
 =?utf-8?B?MWRoak8zaGFGeXZucjYvQmxOMGhkOGI4NDRrSm5jdVV2MWEvdUtZZVZCeEsr?=
 =?utf-8?B?dUVMaGpzT2d6Nis0cEdscTVPbGtadWdjWnlReE5uYUJvNjltWUNjZ2JxYy9x?=
 =?utf-8?B?aXgwUVdoNlJNVURDVW5Sc0dUWXlYWjhnQnFsdERmYXZtYTE4VlNDenFaSzJj?=
 =?utf-8?B?c0hXMVhNdStsR2pkbTJvaDJxeUhzWUpsL0NBeFc0aEN4cUE3R0IxR2wyOUtF?=
 =?utf-8?B?b2ovYVRVTnFzd2E5V0lMUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UEtBeHFsZlhicTJCYmhQM1R5c3RKYTZGV2tRRFlnYXJjOWFCdGpEQUF1K3Bv?=
 =?utf-8?B?cFp1NTZWOVNyTU9jbEZ6MG5sL0NMbVQ4cmlNVEpDVG9yVE9OaG9uVUE5NHla?=
 =?utf-8?B?TlgxSnFUVXpqdFF6eVhISlpsNFNVRDF4Q0FFVTN5NFk1RlhVcit5SnNsQ01K?=
 =?utf-8?B?a3ZPZkprZWdLcWgzcG9neVpZdjZsS0NZblVxZWt6eDFLdElBV0pXQjhiT2dU?=
 =?utf-8?B?RVFvdUpzZytMUGtHaHZ0N01jUWtJVDUrVEkxSW1EM3FUVGNJcEJ1K1JHbUc5?=
 =?utf-8?B?VEdRODRsK284VmJwNGRZcWFpVEdDdTlVR1BydVJWSUJQYXhpdW9ESjRoNGtR?=
 =?utf-8?B?QU4xT3Zyd3RET3EyUkZIMm90U3RyNkhtSFFMSlNKaUlSREZhajlqMXFiRW9K?=
 =?utf-8?B?TzBxK2NzZGpyU2FMUlRvci95MExGaTVYMmIrZmRxbzVxK3hhTkcvdjFJQ3hh?=
 =?utf-8?B?YWRMOFlxcWc3a2FlTXYyZXVNM3huZHlESVJidlVjeHVxbjlyL2UxVFFGV3F0?=
 =?utf-8?B?aFNOWFlCQnd1TUhma2JPeFdNUzl2dFJQbStVbkhiWklOalRpOTFVM3hqNFNq?=
 =?utf-8?B?OWFwc1pTN2xSZlJkcWpIbWRaVUhKTkNnTXZSWDlaZVVoeCtQODEvaGhJRE5F?=
 =?utf-8?B?TGtoNm9PMXdrb0ZpTkNJRFNTL0xnV3pkaHl4L3VaS3NaZ01CR01WeFdUYUQ1?=
 =?utf-8?B?eWNIb3Fvc0p5UDNidnpIRmNyRFZTV1o0YU9vek1UQ1NrS1BrVmoxQ2pBeUxE?=
 =?utf-8?B?VGdUZm5MVnR1RjNhaGl1MVFmdEcxUHJsWnFhaTgzdmpwMmRBN2x1MHdHOGxZ?=
 =?utf-8?B?QlEzcWJFMUtoTWhHQWtzaEtHd2RlUXczZDlabDIreXVLelR5TEhlVkxieUJ0?=
 =?utf-8?B?RFFSWUJtOE1ISWkveXgvcGN1TlRKNXhDQmFwOGN1dm91aVpzaXJCNmJORlRV?=
 =?utf-8?B?ZS9wN0M3MERkYjV6QlN3K2tyeTZ4K3hXaEx1cnFSVnZ1djMxSko5M296SWRH?=
 =?utf-8?B?d2xWMm5IYnhUK1o1QUZ3VzZpVWgzYmRvdjR6MFJaSTNvSVJTUW9WLzNrT2cr?=
 =?utf-8?B?VXJNUmpBalZhU0h0NXpJUm5OaTkxWVVuVEIva25QV1psVlNJNEkwMVkzSisx?=
 =?utf-8?B?OGV1bVZZZUFhSHJweURDdDFYLzR2Z3RMRDdvU1pydkJZaXc4dXUzeWdENExT?=
 =?utf-8?B?c0ZQTjVaQUFuY09EcjU4QytOalJYU3dUUW9sTU9jY2wwSURKQ1BmZW9vbEUz?=
 =?utf-8?B?M0oxa2RsUjVsUHNUWkFoSEhlamtvVUYyazFLdFp1b21wb1FHcXVLeE55R0tJ?=
 =?utf-8?B?YWNaTHQrVnZZN0hudFVRRUNlTEZTRmZEWWlHL283Q3JrVUpWMkJHc3UzcE44?=
 =?utf-8?B?bnB2Wml1THZ3Y0VqbWZkbGVOREVSZ08wQlNnLy91dUJ3L1NMcmtpQUNuWW1r?=
 =?utf-8?B?VXgrZFBGSVFPRE9aK0NZd1BKVmlkZ2g2TUtKRTlWNmIrTFFtY3hyS201b2R4?=
 =?utf-8?B?V1RhY0dYYUdZRjNNOTIxNUIvMFJhLzJ2bzIrTUMxS0RrTE9HOVB4eDJabkhU?=
 =?utf-8?B?dFd0RUZPa0JYV2hBN1lPb2RiMnNWa0N2K1RXNU1MdnlOMzRzQlhqUUlLd3pz?=
 =?utf-8?B?RGZJdFl2OHRkcFB6NkI1ZkdNVmRtMFNvb2pPT1QzYXIrTEg0ZVBSV3N5OTg5?=
 =?utf-8?B?RnVXR2NpbHVGa1RHL0VoQ2hKdi80YVVRTGI3MjFFVjNpRTRTQmNqWHVQYW5j?=
 =?utf-8?B?UndpWWwxL0xMSjBTOXJCdUhvQnhYMFBJK3JWdTNOanVKV3prV0g0NUF6SWQr?=
 =?utf-8?B?bUN6dm8yakhDTFFsTXlWb1hlL3JKRG5sN2ZmR1FrUE9yNTVBVzBCYzJqeWNG?=
 =?utf-8?B?Z3lNcjNZV3ZYQmgxNUxwT0ZTemlEd2ZscVlTWklKVXg3MjBnVmY2c1RCSkE4?=
 =?utf-8?B?aVhoaE5iWUtnaDl3RkMzb29ja0l2UC9VUXlEUmZZcEYrSkxyejRPUU5wTUdS?=
 =?utf-8?B?L21EcUlLdjZKUG1aeDlEQ3NhM1hQY1daeWNjZEpXemlicys0UlhSUm9TUy9B?=
 =?utf-8?B?S3JnVU1HK01keHJjMGNEcmpjWGxNNVFpTzh4SFlCcVAvYWdnalp3MzNBaUJm?=
 =?utf-8?B?eDZwVmc5aG9KUWkyUXFCZmNXYWlSZTNwb0hEVkQzbi9JSDQvUEF1VFkzTUti?=
 =?utf-8?B?L0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: T1L2He3V1Trkh0Lx/aplJ5Z3usc1WtiOfc7HuRC12bhEuLGulPnNHELG0yV0VJvoLIleCsf3162gy+zo/1nBSoizGgwKk/LxxsySQJjgw8UACinAhvgVvuIPYyQal4kCXwW/Nq/N8hZUwXJ7fR93ateB93o9sorZH6eveDOAmx8D3GhA50jq1LqVxO/WfhEgT/I9H1F31zhAum0zV0BdZucP+ve1p2anQYF3dY2JOy/Z2Ujz/gH7tsAbmiVLFEG8quXRnkZp7QoFGyIsVROHScMu6SdZQIYecKM1iEohcdOc1i7pC1clC6VcRyIhcnG6LEMRPFK9oaVwT8fpEtf+ls1FThDPdkIK+EcyV9GkzjaFQJ5NmNdqATEms+F5SFbb2+8gTa2ln5uPvEEqZRpS48QcYv3utW1OkSCCPCmo0G+rf8XgtmnbOqTZjFSTQH8PRnUE/xbWdF+2KoHP5wG+la4RCTaGey6AcOiTFlV8nGNxC+5mDg/hHTBy1rRvbkjv1j6JC/V1zYOqETiGwoOc7nVOqes8neSHmguJ4ITikvuqnO6CSkpuaZAANOBWvTb2dme9lPjv/+joC+pULCxtx16Lg/T35SnEbg0UUmJCNJE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0938f3f1-93e0-49f5-1c53-08dcbe06de1e
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 15:19:48.7151 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aBnF7+rejh3FnUjH20/NFs9i4S75cji5d+8NthgLrmlTa8va1nDgrlNf88kDWBvoAziKPnZ0GTxTMCjfP8zr8keEpLj1iNmPoNCSmNUSjLk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7388
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-16_09,2024-08-16_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 malwarescore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 mlxscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408160110
X-Proofpoint-ORIG-GUID: eniq6BNMKiA22Fd_fi4TdxmFmZezjoWi
X-Proofpoint-GUID: eniq6BNMKiA22Fd_fi4TdxmFmZezjoWi
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 8/16/2024 11:16 AM, Daniel P. Berrangé wrote:
> On Fri, Aug 16, 2024 at 11:06:10AM -0400, Peter Xu wrote:
>> On Thu, Aug 15, 2024 at 04:55:20PM -0400, Steven Sistare wrote:
>>> On 8/13/2024 3:46 PM, Peter Xu wrote:
>>>> On Tue, Aug 06, 2024 at 04:56:18PM -0400, Steven Sistare wrote:
>>>>>> The flipside, however, is that localhost migration via 2 separate QEMU
>>>>>> processes has issues where both QEMUs want to be opening the very same
>>>>>> file, and only 1 of them can ever have them open.
>>>>
>>>> I thought we used to have similar issue with block devices, but I assume
>>>> it's solved for years (and whoever owns it will take proper file lock,
>>>> IIRC, and QEMU migration should properly serialize the time window on who's
>>>> going to take the file lock).
>>>>
>>>> Maybe this is about something else?
>>>
>>> I don't have an example where this fails.
>>>
>>> I can cause "Failed to get "write" lock" errors if two qemu instances open
>>> the same block device, but the error is suppressed if you add the -incoming
>>> argument, due to this code:
>>>
>>>    blk_attach_dev()
>>>      if (runstate_check(RUN_STATE_INMIGRATE))
>>>        blk->disable_perm = true;
>>
>> Yep, this one is pretty much expected.
>>
>>>
>>>>> Indeed, and "files" includes unix domain sockets.
>>>
>>> More on this -- the second qemu to bind a unix domain socket for listening
>>> wins, and the first qemu loses it (because second qemu unlinks and recreates
>>> the socket path before binding on the assumption that it is stale).
>>>
>>> One must use a different name for the socket for second qemu, and clients
>>> that wish to connect must be aware of the new port.
>>>
>>>>> Network ports also conflict.
>>>>> cpr-exec avoids such problems, and is one of the advantages of the method that
>>>>> I forgot to promote.
>>>>
>>>> I was thinking that's fine, as the host ports should be the backend of the
>>>> VM ports only anyway so they don't need to be identical on both sides?
>>>>
>>>> IOW, my understanding is it's the guest IP/ports/... which should still be
>>>> stable across migrations, where the host ports can be different as long as
>>>> the host ports can forward guest port messages correctly?
>>>
>>> Yes, one must use a different host port number for the second qemu, and clients
>>> that wish to connect must be aware of the new port.
>>>
>>> That is my point -- cpr-transfer requires fiddling with such things.
>>> cpr-exec does not.
>>
>> Right, and my understanding is all these facilities are already there, so
>> no new code should be needed on reconnect issues if to support cpr-transfer
>> in Libvirt or similar management layers that supports migrations.
> 
> Note Libvirt explicitly blocks localhost migration today because
> solving all these clashing resource problems is a huge can of worms
> and it can't be made invisible to the user of libvirt in any practical
> way.

Thank you!  This is what I suspected but could not prove due to my lack of
experience with libvirt.

- Steve

