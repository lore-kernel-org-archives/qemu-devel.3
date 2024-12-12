Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BA16E7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 20:39:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLpxF-0006XH-81; Thu, 12 Dec 2024 15:38:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tLpxB-0006Wn-BH
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 15:38:34 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tLpx9-0006dl-2n
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 15:38:33 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BCJfqWO022000;
 Thu, 12 Dec 2024 20:38:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=XyBRpMatvHtwhNun1Oq1TOHEdX7ghhM6Auqdjqlk6Dc=; b=
 nd9b0+Xsoi/oJYu6yjkKXbuK1+536rs5AL4jRhEZjLjnbiRyibfX96A9V9VQIXWQ
 X9LJIrdmnoz6USXe0Ff0ZGJB2cygN97eKaNq0DixY0acOQxer1ch7Zey4flgMzL7
 Jn44fYx7pOwtv1aX8dN5leJDJwSNQiVKq8+hOeJnn46bu+4RUpXL4yraWMZgsIUE
 XT2S3fv+nV9xHywVkSmty7dbuWkGw1iONlBzaZEiqJXrLjracefPXQiAgF4j0S+A
 87ZvvjammvnIMUoKCf18dA9DLuVR21WyJcnmnsArHS2629nOOJ217C8crEv4Wn7q
 gClxSa6TWk+jN+yV4T203Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43ccy0c97m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Dec 2024 20:38:23 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 4BCJcehZ038087; Thu, 12 Dec 2024 20:38:22 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com
 (mail-sn1nam02lp2044.outbound.protection.outlook.com [104.47.57.44])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 43cctj98dp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Dec 2024 20:38:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TQ0/qlcTRQdt1rNmY6aTQ2sYdctMRtOtw0cTeqbpylQZe25C1XBMWPg9ROdziJuZKJi8FLBzk/TyQH/UHK7v52fHcfYOChWxL6v0MhFm7BitUE5bGeO93OMoGWg9LHZcXnZFoMi5w40QSSdJF6w7AzNHEFBa90g5yJV1IHjzHwr5cQzjEcr8ZuJjWYWo/bGZ1EVlcemQIR7+z8DhjRT9UoA11QbNIzALwnTpMRt+cbToWmzrWmJllwxMQlsdmS2XyKKxnUCm5JpQ8R/lEFennwG15wbez/44WJDKz/Yi/WrJ7czmt1nY9cQ35CE193oI8mZdAZLCFf1iVYobX8zKdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XyBRpMatvHtwhNun1Oq1TOHEdX7ghhM6Auqdjqlk6Dc=;
 b=OHJYzs/Hl9f2Lkagadz7Mc9vrkxBNU/9NkZ56TAlRNVVkFzfMLxargmiWZJb08GaWR9xCOtZ9mFPpTvbgZwf5MH1E/b7jfqSLqJV3lmlWLWldhZExNJOY/rscbIAZmudujdki9VjsOuWQQeliGwNNCip7Esycu7w030fwL2h6TO1HsNLh2A+DFgeE7BS1B3yA53aSLZQkyD73eQOlVkFpPw3i/GHuFu4G3A80t3d6P5u4QA+tb4iipFarLu/0kOUW///eGhyl4Ws46eO8gHT+HSzpy8yNBSIdpR0KHG6QzJDbQ9LqNBk39r0X9Jize06jwRkpWSmkic5EaTPuDbQYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XyBRpMatvHtwhNun1Oq1TOHEdX7ghhM6Auqdjqlk6Dc=;
 b=sLhZfllprh7hTqOQw43poZODBtyr5yiHAbwYyqIARvywR+hG3PqRUyb8zUVSc7cA/pJwCitg+ZejhFvxwwtsWYr2jouwGIC1mnMrAqO3NVTLZADN6b7pbMF6qDnRrhuDeK0YUC4N7fqUVElHlr9FXO33Z9p2eOzPbvephS5jLEM=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by SJ1PR10MB5931.namprd10.prod.outlook.com (2603:10b6:a03:48a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Thu, 12 Dec
 2024 20:38:10 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8230.016; Thu, 12 Dec 2024
 20:38:09 +0000
Message-ID: <57501760-df02-4a39-86fc-8001952bb458@oracle.com>
Date: Thu, 12 Dec 2024 15:38:07 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 04/19] machine: aux-ram-share option
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <1733145611-62315-1-git-send-email-steven.sistare@oracle.com>
 <1733145611-62315-5-git-send-email-steven.sistare@oracle.com>
 <Z1dLECXaEv4Q0BO6@x1n>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <Z1dLECXaEv4Q0BO6@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN7PR06CA0068.namprd06.prod.outlook.com
 (2603:10b6:408:34::45) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|SJ1PR10MB5931:EE_
X-MS-Office365-Filtering-Correlation-Id: 296bbede-99d1-4529-a5b0-08dd1aece3f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q3RoZkljeXVmR015dEdzTGd6YjBWVXZOWXd1U2tsNG5HdE0vakVjdUJDeVA2?=
 =?utf-8?B?WE12UjFLeHc5OW9NZ1pqSWNUNTlqOUM5UmVZUUxmaGhVL3hSYkhvcTAxM1pz?=
 =?utf-8?B?Z1ZlK2pkTEpnUmpGaTZXTVdRd3NwbXh3ZCtjaHY4OVNlUlEzYzN5T2YyaHNC?=
 =?utf-8?B?aVFaY3pqdEVNT3RKdlUzMC85N285TzRTSUlBZkJBSi85VXFNaGdmWmlHSDM4?=
 =?utf-8?B?bVQvZXYxcTB0b3JYbjNybXVncE9JQ2ZkR2ZyenZJZHlmVy9wSkwrdXNxWGNy?=
 =?utf-8?B?WTI2S2ZNS2o3NEROMkhsWjd3ODloQm05VWxRTVJwZEhxSUptUVVBYWNNRlJY?=
 =?utf-8?B?RUlzMnU1cWlXdDhJcHE2bEhBWmQ2TXZXYjZCbmlNUklYZ05iQ3V0L010bmRl?=
 =?utf-8?B?OE92V3c1d3ZRK0N4YjM1SE9hNysyY0FHM2RiS3A4aUszOTlRcTB4UWw3ZW5F?=
 =?utf-8?B?cU9lRElSN0ZRZkJBMDA0OXNoUTZ0UDVRcnR0MForYWZOekVTZ3UvQ0hKRXFV?=
 =?utf-8?B?QVhQeWZJcjAwaFdqOWg5ODNKV0htTEU2VC9zRHVwMDg4eU5RYlE2ekdYdUtq?=
 =?utf-8?B?QXIvcUpCZDZJME9yYktIeDhXVjdSR1h0QVVwZDlzRXBwU29vb1U5SEVITExu?=
 =?utf-8?B?T2VHc1kxYnBZSzRSYlBpNVA0WEhDNHp1UVpSVlBMVnc3RjU0YVpRWlNLNnZt?=
 =?utf-8?B?RERhR3VTRmFjdWNQL3lVVWxxMVlETlF4bjlpRUNJZ2N1QzFRblkvelp2UTJR?=
 =?utf-8?B?ZmUxckZrdDQ5RmdrbmxOZTRkUVhBbFRsQWxray82YjJMZnhQV2VpLzRxbjU5?=
 =?utf-8?B?UHhodUR2V3k1VkVqUkNqd3VMOVN0by9mWmdUdFlXL1ZVZml2eTdjTWZpMStX?=
 =?utf-8?B?MUlHZDRFMHA0SWg4SmhWWlJCUUt3S3RxVi9Nb2Q5TDdHcmJJYUd2aHcrMVpk?=
 =?utf-8?B?b2JYdFgrNUFVUlhMS2c0ODJWZ0RFRGszSVNPcFJEWGJZUzJXQUtjelVwOU1m?=
 =?utf-8?B?MnhZdmRvZi9NWjFwREZtY0FodDVkK3dNNWxGRGRTYTN0RXBtVDV3eXJrSjgz?=
 =?utf-8?B?ZWRTbXV4WmMxdk12S2NKUTNSTENxaGxJZkFhZlcvNVh0WFFmYjA4aStWWWhw?=
 =?utf-8?B?d2dkVEEwVXV5RjRxeWZiRU5WVDFJQWtMTGd0OEpEaFRmTmlGUzBHSzlyaU5h?=
 =?utf-8?B?SThySHBlMk1MT2ExTmRJamRqM3hpSzRkUnMyQlVYUFVLYVplM1FrWkZ1M0lz?=
 =?utf-8?B?ZDJkbjgrcHRLcklFU3REc00zZElSSlEyekk3WmdaRGYxdStqcFgzRTVnU3JS?=
 =?utf-8?B?N1llOFJ0MURzazRtcHo1VEVINzV6eTlldmxPVWZZUjZsVHFXU1RTdGk1RTBL?=
 =?utf-8?B?YmRUWmFjaXRZRHdTYW5naU9DSjFYSzRXMktUdFRaYWp2MEllMStLN1UvTlVG?=
 =?utf-8?B?V3R1N3dCeUJhTEZDTzEyLzdoWkVyM2NxamFQNGJxcXVOemVFTlFDTE03QlNO?=
 =?utf-8?B?TUFYczQ4S3JxdW1yb3ZhS0F2SVJKOHhVbFVJYUVjY1dBZmtqN1lpQUQ4bmFN?=
 =?utf-8?B?Yko4QjFRYk9NdERvN01ERFpzbkxIeUtPeS96T1pRSWREYktycldidTNzVWNJ?=
 =?utf-8?B?M3ZWVUZmRXRSV25uZEkwTjRBS0ZOaE1pOVM4R2FwR05FQjFMMnd6eHVOSE9i?=
 =?utf-8?B?WDJzMWdhQnpPZm1Vbyt4d3V2NEZnZ2tOckkyNkZxV2JmZk9oVVV0ZnJsdmZZ?=
 =?utf-8?B?QXQ4S0lIU3RyRTRNVUZMb0NtWnNZYWZOR3l5OFVyeFlRRjNOOGkrTGlCQm1z?=
 =?utf-8?B?VS8wenZlZVI0bks5TDFhUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OXNQbTlHWUFIbCs4Wm9RQlRIa2E4dFlZY2t4aTZUWlcweEVBTWE0aDdiQjJE?=
 =?utf-8?B?UUhSamNFeVFiMDltUUdwR3lYbkRnbEowVTlzMjk2T2ZpWDhiQ3NVcnZxbmhp?=
 =?utf-8?B?V2s1dFkybzVmcVFyVkhUcUFETDdBaXZ1Vmc1WTgxdFhFR1VLWHlGYkFhL2lH?=
 =?utf-8?B?VUdVL3FxMWdKK2p5cm5kMFI5ajEwYUp5Tm1uWkZHUjhyTzVIWDdXelZaUkZy?=
 =?utf-8?B?Ymw1RHV0UHNQM09ITzJBRk02aEYxSUREN3ZvbWhMV0hlMk1nYXZUcGJrZk1N?=
 =?utf-8?B?NzJ4SFFDU2t6REg3OFo4QlA3a0RPdjBOMHQ2NGFsd2R2ODF1c1dqNGJwOXY4?=
 =?utf-8?B?bHJTL0FDT3MvMUJ1MHA3VWRpQnE4aGJMNDVQZ2hjMnJod2x2dUhaMDJlYXI0?=
 =?utf-8?B?WjlQZWlFQkx3dkU1Q0lpbVBUNk5oV2x6Vkg0UUgzUnlNdXI5YkNZenZFRXJZ?=
 =?utf-8?B?NFo3VE9RWHZqT3VxYzZCUS92cklFWjBPUjlwWVdBbU9HUW4yRVhweldxdjRl?=
 =?utf-8?B?K3JVMjI0bVhheWJveG1jQjhxeVM5aHpTejNJNlZycTg2WGFPTjdpUElxV1N1?=
 =?utf-8?B?czY5RStEdkNwdzdxQ3pCanpzYW9sNkJJejYxSXJUYW45Ui9hMkE0S3JLQlkw?=
 =?utf-8?B?K3p2K25OTDdaeWxuNHRMNk1sVzc1MU1YU2t0Y25rMXp4VGdPWFN1b0g1U28v?=
 =?utf-8?B?S0hwOWdNcVV3OGJLd1Z0STdhbTAvaUtKWStVcklSVzdIS3BRY3U4L3NxZjFQ?=
 =?utf-8?B?Um5rdXlVZW95Mzl3MXdqd2swOGdTNlNqbkk3SFZjYTQ4VHlaU2lRd0RydzFK?=
 =?utf-8?B?NmZFaVRVUDBpdU9ydnFzckh5aTJhbnQyUklLMDljQklUeXVhUHlOZFcxTDgx?=
 =?utf-8?B?YnVJZ1B0bnYzMUZYeVZyREJ5MmNycXhYa1U1R1Z5aXFTRlN1UFArT1I3QXRM?=
 =?utf-8?B?cGJPcWJwVFZCeGpJaW1mdlk5Tm5FN3YzendxUGpUemhha2RLeU1yTDRONEVF?=
 =?utf-8?B?UE1KZDNVVVltcDBjOFFWTHhUVkxxQURRNGRxV1NLMDY0QWRZaVBBS0pJMjlH?=
 =?utf-8?B?SE11ZHdWSjAveE1Yd0xuY1NFb2NYOW1MUUdGT2FyR0dEdFBWSmI0aUFYVVNR?=
 =?utf-8?B?VUJIY2FEWGV6TTE1aDkzb0ZGdnQyd21DZUtmZWVONDJDRlJ6MUNSdEFacnln?=
 =?utf-8?B?ZkdjV1dIOEp3bjNGWjRJTkdVdllueVJuUW1zZ1NSSlNrMHlBeHNaNVI1blR4?=
 =?utf-8?B?U0NZdkRYVzlMTzluVXpHZ0dSa3FXYUZvc0JZUkVqU0pxUWRHNkpVTkJCZE0y?=
 =?utf-8?B?a1h4cW1oUUNRMlpiRzN2c0FkeUV0azlFaGY4Y0lBb2xDOGJGcVgrY2FUeXV1?=
 =?utf-8?B?RXFJZ0ZJOUV6WmhzUmxYYXBTT3lWRG1sVG9WeVQ0UWxmR1N0YmRJSG5wTmM1?=
 =?utf-8?B?REVGZ2Z1bkR6UjVZNzRRWjlSdTlJaForMDMzT3g4TGhrK0E1emVJM1BMT0tU?=
 =?utf-8?B?WCtuc1VzTHZCbVpyOXZLdzYvakpyREVlL0szanJnSWJvY2puZmkzWDVsMUo4?=
 =?utf-8?B?R0REZ1FZOGVKYlVqTi9taWRMV3lpZ1Nlai85V0o3MEhURzNUMTBkNzcxckpu?=
 =?utf-8?B?Y0ROYWlOVk01UytYdG12UzVoUnpucXhzZ0MxaHo3N3B0L291R2NXaVQyNjVQ?=
 =?utf-8?B?cFo4NzNUOW5TVGdzaTlOT0ZXREViVDJiWkNMd3dSUGltKy9TZmNUaXdhQ2RU?=
 =?utf-8?B?M0xyS2t3cmxjZGNLUmVXMXRDWG56T0tsTUZxeStiZTFlTW1xeFhJK0tadlRa?=
 =?utf-8?B?YTI2a2h2S1FqS0pQTVFUZWJvcGxXNDh1bldiN1VLenExNVRWS3d6Unc5QjVq?=
 =?utf-8?B?OUVEb1ZVYmU4Mko3OW5IZXE5M3RKSGhOYlFMZ2FMSFNtZmorU2tEd2hvV2U3?=
 =?utf-8?B?VVdLTnFDejZFazVGL3Q2eURNblJSLzMwcFBxOU9pNGRFVXJTckJleTNPTHBz?=
 =?utf-8?B?RVpkZVAxckhCUzZ2dGU2ZVZES2F6dEZxdk82ajJRK0NyMklic0tpSGNIalVZ?=
 =?utf-8?B?b0FkRFVmbEhEd2JVOVNkaml2dGxsbjdvNVBXVDh3NS84S3RZZ01LTHUvOThI?=
 =?utf-8?B?MmVpaFAvc0lJNFdtenNsSkxvY3ZnMHN4TU50YkRkY1FsS2JtMkFTb3ZaWkFX?=
 =?utf-8?B?S2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: M6YRDq00WrL5p97I/SUrbzCt7SFPpwlbpto6naDYyVHd+h3WKo4UYcPOo7cERWrPMQt1WNzWsIn+UM/K8/ni4S/a1Ao1pm5ffGlDYCR2vhdqtGVRovuRb7MTgKad8QI4jWyXZCttAUKtYLRzPOyV7xDqNMrQQ9MKGHgFKamGRl3U90L26gELwuEB6JIZBeZ6mSHel4VoZxEBRIxcSgPLVeMZ+xELLj3grcl9mm9IQaDC0ZU0oFNWyyqjATdiXNcgNm54q3JUMe7jSvPoK/p8BiA+bAxE6u9GntS7THaeOuGdw80udxgGL58x44IOpOR9z9Wk8kLotLASkHa3umSighUCxFuF6eEa93Q7baRIeBkDK7w2LO6EEoBZjNt68P5khdv/R0i6t8NhrTyN19qG0fol6g1h64ezW3pSCZExi4dfhN7tZCcKI+kaKJZWQyKflGAXKpGgf+vS5kLq/VU5RgzLiXz+KjU04bBTyR1VjNdkCXUJ5qDfkcRBtcJ9/hfYvA66OzogUKB0ZfI6SYZ336WbouD2vDYoOmXsRgojtqPvjIf/VPQZE/zWDMUTCn/n3kD27pCf7AsuBTh6sQYR5dJWE7X7mVGVMCJRTJARRkU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 296bbede-99d1-4529-a5b0-08dd1aece3f0
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 20:38:09.6682 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GnIYz3TQ8DJr3Qz7hdQ/5fGO1oZio6rrFN38gkOGZxGCz73Zx7EhmVKe5SHPKAoHDrMYVViETyyBKqQ4WCKI3F38DIHYJat8OTj058Pmtt8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB5931
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-12_10,2024-12-12_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 mlxscore=0 adultscore=0
 phishscore=0 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412120150
X-Proofpoint-GUID: inH9bZdL0DHX89Fbd_am2iTToFKPPb3-
X-Proofpoint-ORIG-GUID: inH9bZdL0DHX89Fbd_am2iTToFKPPb3-
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 12/9/2024 2:54 PM, Peter Xu wrote:
> On Mon, Dec 02, 2024 at 05:19:56AM -0800, Steve Sistare wrote:
>> diff --git a/system/physmem.c b/system/physmem.c
>> index 36f0811..0bcb2cc 100644
>> --- a/system/physmem.c
>> +++ b/system/physmem.c
>> @@ -2164,6 +2164,9 @@ RAMBlock *qemu_ram_alloc_internal(ram_addr_t size, ram_addr_t max_size,
>>       new_block->flags = ram_flags;
>>   
>>       if (!host && !xen_enabled()) {
>> +        if (!share_flags && current_machine->aux_ram_share) {
>> +            new_block->flags |= RAM_SHARED;
>> +        }
> 
> Just to mention that if you agree with what I said in patch 2, here it will
> need some trivial rebase change.  IOW, IMO we shouldn't special case xen
> either here, so it should also apply to xen if one chose to, changing aux
> alloc to RAM_SHARED.

OK.

So, if this only requires a trivial change, do I get your RB?

- Steve
> 
> Frankly I don't know whether xen respects RAM_SHARED at all for anonymous,
> but it's a separate question to ask..
> 
> Basically what will happen later is in cpr-transfer migrate cmd, it'll fail
> for xen properly seeing fd==-1.  That'll be fine, IMHO.
> 
>>           if ((new_block->flags & RAM_SHARED) &&
>>               !qemu_ram_alloc_shared(new_block, &local_err)) {
>>               goto err;
> 
> 
> 


