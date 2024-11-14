Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D059D6A224
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 18:32:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBed8-00046I-Ie; Thu, 14 Nov 2024 13:31:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tBed4-00045v-VB
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 13:31:44 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tBed2-0001TF-8c
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 13:31:42 -0500
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AED1Yk8018624;
 Thu, 14 Nov 2024 18:31:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=gly65dMljzkOYKTDbjPaMOoZOqjeJqVvUyhrXwHvQes=; b=
 JyblI7f+zmJGjIHHnNjBC9RSjuP63S+0Y1+bQG4SxrpwOyS64TiowyzFmONj1w5z
 ztqNYCCNl0IffztE1qyBjAyOFDAoaXfgfiMjChfSwAy+VyeukhvFMhs0WjbfMfhI
 izdHUMvBQjR62mFJYVP7CDl8leO9RFXONW6in4MaJ03KbGFfePWMKbYkRsLfhWMO
 270PMIuj3A7xAJHLwoXBceZdnS7gCgB1jkRjH5JBQqrNHPxXEMS4lEAKPqcHPPV7
 mt8qJFcvy9q/5dPeMzGaJ391F6jPHElB5DOIfbi20zs2q9OmxAGOIGO4q4E5x76h
 ZDUuqrOmVN3lNQ8IUsZ2kA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0kc20t5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 14 Nov 2024 18:31:32 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 4AEIMc0R000592; Thu, 14 Nov 2024 18:31:30 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2044.outbound.protection.outlook.com [104.47.58.44])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 42tbpakg0j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 14 Nov 2024 18:31:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EcFgkh9miDzdo5fjPrsJHxUS8YilBTLXQoJiGQjNw8GTRjPBbHwU+zA0GtjqPtbo4JlBavim9JW60MI+zowiI7guFb0Z7n/lgDhuGvpJ8kKE6DkBBy5n9GA7cF6jG6ZpObPjpBJfDX7a2akY8CTOQKT9l0+OM+5WRqt5D9G77ffzIAVMoJ8ezSLfE6w3lQwwlb8hw35ICZIpKTFPvoWThI5egDALq4mhCHsZZVSAy+cFSI7yCjB5N4WChGYXxFsiyHFfrdUL7DE9c54KUchjSn+Y5EfpvLsWlr8PD6P4FqsNIFn9lMsrf3moXhVuO231dD/RUyE2gWwFEZfu2ikFAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gly65dMljzkOYKTDbjPaMOoZOqjeJqVvUyhrXwHvQes=;
 b=FndYNt0GCVkcIOe/e2+NiuYkCOXmn5Ic6caZav7zF0jGDApldX/isFJ7MrzFEeOFebIxuQPk0Y0emNsRDCQlkjklylg/+IU7ogG9DrRhzTUN1XuZ+NGlkn2DZyJg4PFpfwQ5LLm1lf8L/IlwC4OY6oG62IcdGr02bgDogslLacvH0k4XgtzVqz4QvD/KUk1tLTFGOMciuhexK8pInrltu/TLvmvjTQx+eH949MnuYhiC/FaE7hvWOMEH9mbV8B+Wmy3j9u5O+Yo0rsyD9gfnMAs4ie+ubDU70wB6N28OMlL9XPzS5RjSb1BoySYVh8XnBUhqzLTBN1VD9jC57p+Inw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gly65dMljzkOYKTDbjPaMOoZOqjeJqVvUyhrXwHvQes=;
 b=Oo6uyBmXPQGj3QkPeVhGZ4yelxp/k4EMPGmHfAyxPPH2OWI/Z/bT98fPlCWYRnYtJkyqeZnnj+VzKeNSqx1PIZAIbTx2SRud5m6umQzkgCXfcM6pr8992sKt01kDpveVZ8WKvVWvpouxb2Z10pWZm1Yvmp5WuU3XiNJLDm3vNd4=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by SA1PR10MB5822.namprd10.prod.outlook.com (2603:10b6:806:231::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Thu, 14 Nov
 2024 18:31:26 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%4]) with mapi id 15.20.8158.013; Thu, 14 Nov 2024
 18:31:26 +0000
Message-ID: <4e1fb923-d936-4874-877c-aed1e46fe8f1@oracle.com>
Date: Thu, 14 Nov 2024 13:31:18 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 16/16] migration: cpr-transfer documentation
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <1730468875-249970-1-git-send-email-steven.sistare@oracle.com>
 <1730468875-249970-17-git-send-email-steven.sistare@oracle.com>
 <ZzUiCOCYEaaF0cWE@x1n>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <ZzUiCOCYEaaF0cWE@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0323.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:197::22) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|SA1PR10MB5822:EE_
X-MS-Office365-Filtering-Correlation-Id: 168426d8-8995-40aa-b99d-08dd04da8c61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eE1zZy9RU3BEczFGU3BpaFRXSDdoL2RmWFFXMWgzTXZrd0xHeGtPVG85VGYr?=
 =?utf-8?B?R2JoRTdnM2h3WVZRa2ZuTXI0RytCNDIxUmRPWVQvRFZMTi9qTlovbXh6NUZK?=
 =?utf-8?B?eUlmUnkyZ1pLamhJK201Y2RraXFiaGY4YVNBbTczQWcvblVIaEhFRS9wdlFl?=
 =?utf-8?B?VHdXNVdxekt0c2VsTi8wSDVzQklHZWxTUVN5S1ViVUJ1bmtyL3l5SlFLL0Rp?=
 =?utf-8?B?aDhHR3V3SkQzVGdPVnpQTDAzKzdxWWNyZTFTNVkvUzZCeExER0hVWTlWak16?=
 =?utf-8?B?WFJaQjNSZk9vVzNNcXNWa05JcG5NMzM5SHdSanVWdk9Nb0YrUE1oVEo3YVhY?=
 =?utf-8?B?YzFMV1NxZmZUdEdLR2ZnQlYzTkVtbFFrQlV4QkdhMFZ4NTV1ZDFMLzJ1SXlB?=
 =?utf-8?B?Vkd6YnNibzdJbG50WEJYdzh1YmFmKzQvK0NUWjRIMU0xbE1vbnltaUJuenhu?=
 =?utf-8?B?dlVoT1hyZEkrK09EaFR4RitvNHVQMEwya2tQalB6QWtoVzkyU2dPWjloYWta?=
 =?utf-8?B?NUc3dW1YSExnYXRnbThhbXo1V1dvTTM5ZGY3RjlRc3lFdW1USzRYaFpMb24y?=
 =?utf-8?B?QnJiQVozUU9Oc3c2NEJ0SE1RZitvV2htRFZSWHM5Q2o0eHdRbngyUkJCeWJY?=
 =?utf-8?B?VG5BQlNjU1Z0ME9Sa0FrZGtGY2tMZlZxNkYxS3dTV1pNVGJNRzNxK3FOOXRo?=
 =?utf-8?B?UGlzVSt4VW1MeXFUTURrcEcvQVVoeFJ0OGtZeDd1WFdNZS94dkUvSlZOcHdl?=
 =?utf-8?B?M2lVWk5RWG5tTk45NUlhTzdjZk91UStIOHEyNVJ6WFl4M0s2NkFRbHRmTUw2?=
 =?utf-8?B?djJBUWg2TXRwOFVWQXRNTUFrb3ZNc2c3dXA4RzZJNUVpazFZZEpJTExSc1BJ?=
 =?utf-8?B?NWQ3K2JzTnZiWjNoNVlMdWh6WGxybW1QU3g2SGpHdXBnQk9jT1Bsb281NHU5?=
 =?utf-8?B?NXN2NXBkaDZOK3Nocmd3WmtMK0FYK2swbkdnSTIvRUxGQ1pwcWxidm1HN2hL?=
 =?utf-8?B?SWZsaEVuZzZIbWduQkJtcTVIR2ZkSzBWWG9tbkYxNDYveDdTaWdQUStMMURh?=
 =?utf-8?B?a0lOUkhqa1BxWjlXZ3VYTmpqVnAvOU9xM1JKeUhqekk4Y2pHNHB6TlZiTFpG?=
 =?utf-8?B?cXFQcm5oeDN1QzZUOGEvYTN3QVJOMjVYdEFZQVhiSFU4ZmkwR0VzY2dPbEFq?=
 =?utf-8?B?b2duTGRMamdaMGhvblBkTWVUTm5aSCsxVUQzR21pT0dITXF4cXNiUlR2Qkx2?=
 =?utf-8?B?MUZrbVpieUZESzZRUUFYUGtyYTB2WTRaT2FsOXA4Q2FSY0JXdG9RNW9nNEVi?=
 =?utf-8?B?YzQxOGxxc3QvY3YvSWJiaUorNFBDWURLOFY5N0FIL0NnLzUyTE5HNjNHUDR5?=
 =?utf-8?B?WmZXWndXUkxmZC8zT1RuUmZiYnc1U0FBMitsUzdubWpnMDV4c2ltaXR1aHo0?=
 =?utf-8?B?K05Obll2RE5xVkR3L3hjTTlOeGlEZGRtaUc5QXRFcmFlL2VKRkl3QXRyQ2JL?=
 =?utf-8?B?Qmt6NVVPVGhkbXhlR3A3cXVaMWRGcHhuN2RxazVEMG5FRGgrcTI2WDZ0bjVL?=
 =?utf-8?B?L2ZtZkJhdEZDdkI4a1JsZlQ1cUlUUDNBN0IrMXh5K0tZVGpmMFpyaEZYOFI2?=
 =?utf-8?B?RkxOQ0lsR25DRG5aTHpKRm8xbnpLb3d0MmJFUnNWb0VjaFRKdUh5TWZIR1dC?=
 =?utf-8?B?NHd5cit4ZEp3Vk5iQkVUVi8wWHkxNTJvdGo1bG1QUHl3bUh6OU1OVHRoamV5?=
 =?utf-8?Q?yAIHvZXHDBTReWVvY43GID/Vwo63NRsOnd+7t71?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NitXWmhPTEZ5ZXowRlZvek9MUHE5eFNnS0xHZjZoTm9IZjNGY052MVo2czBT?=
 =?utf-8?B?eUVlS1gxRFY3aWo2c2VjZ21nUFQ4QnFpYktMaHZvQlkrUjV0bUlXUVoyWmVG?=
 =?utf-8?B?TW5RcDVFb1J3a0ZheHNnT3hUY0JLVXBHdXVqWjBqNDRpcU1Pd0JIaDlsRldy?=
 =?utf-8?B?NEtLaVlwYlViajJEdTl5dVJjUUYzU0RnbkN2MVVDTHd3VHpKWGliSk91ZDZN?=
 =?utf-8?B?N2FxWm9pOUJFWVhDOTl2ak1sS3p2SzZyZEI1bUdpb2VjcXcxOVhHcGNwV1FE?=
 =?utf-8?B?OUFUeVFoVFA5V1ZOKzR3NThTZjlmUU9QOHdvbExzZngzQm9WWjZDQm1tT0Fj?=
 =?utf-8?B?QW1KZkZ0RVhSUmZ3KzZwTE5ON255TXZtZ3RvdHpSSktzOXgrUGJRRFRjcGh1?=
 =?utf-8?B?Y2dydkJtaGV2emU2ek4xVkxUOG40TnlxS0NIMURPWjlsdW9ENFZrMDVBU1pp?=
 =?utf-8?B?YzFsdjV0azFyZjhNTTlWS2tJMFl6TmJ6NVJHS1Q2aTBVSXVjcTZJelBBSHVV?=
 =?utf-8?B?ZTErTExPOU1oeHJOeWtDUGpPUE50SDF6ajNzdWVnT05HMXhDbVo1dWdaTnFq?=
 =?utf-8?B?VnFCRXJRUW93eDZ6QlRwRnB6YUNmcWJCNDN2UUFLVXkrZXVDOXJOSmFrRC80?=
 =?utf-8?B?eEdoRTFPWC8ybmtvanRZTUpBZHN0dXRnT0RZYUpCMzl5RzlaOVVZMU5MaUN0?=
 =?utf-8?B?S1hmeExELy81cXVmUVdRMGt6NjlkV2tmQUNFNm85YmRYdmQ4OC9oMjllTXp2?=
 =?utf-8?B?eGxBQ012RCtTSEZGQUtiMWdNMElQZDU5aEZiOWExQU8veUdEQkhHci9FZUVl?=
 =?utf-8?B?TGVWeThxcHdGM1ZCckxsZVY1YVVGM2Z4ZUhyak1SM0FIQWErNXJJV3dnOFo0?=
 =?utf-8?B?OXRIVHg1Yk9YQTdFSnlwZDh1MFlxUUVQbHltak1pN2JrT3p4OXRPcGNUQ3R4?=
 =?utf-8?B?ZXdtZ0o2SDVRb21CemJmYjFmMmFmcHpzWTZ3SUJzcVA1WkpnUmpPTkxWWVFY?=
 =?utf-8?B?K0lOU0ZpUTIwYXVIYmtRZFlTWXVzWFhMSDJuS2ttNnlONjVsN1dXZFdtcHky?=
 =?utf-8?B?VzdCNnpyWHBKa0hPSUZDZCtvQWcrZk91eVZ2M1R3bDh6TGFGamdyeDdLZTRB?=
 =?utf-8?B?TFo4RWovRUdUR1lRNjByVTVnV1B1U1FwTURZbURWOHI0d3FEMmRzRUpTN25N?=
 =?utf-8?B?V0pZbVNEUjBVd0MvZ3hMdFZnbWZCOGJNRmFzN294NDM5SVFBZmZQODhONzRW?=
 =?utf-8?B?RjJUQzcyS1FuUmRncE1ObHhhbDExUW5KTUJadEs1clFrbTFxUU5MMDdRNWFp?=
 =?utf-8?B?OGhPRTc2N0FkL01VZGU1SUZZd0FZUE9YSGdGcXhmeHkyOFhmdmhoZUFhTmVi?=
 =?utf-8?B?TzRyV2tia3hMV1lwS1FMVUc2ck9xVGJmV1pmS0V3c25PcXAxMVNZUTMrZTQ1?=
 =?utf-8?B?NE0rM2xXWHFCUE9Hc2djZGw3bkJ5aFdRRU1hdEdkb3dJWTJXdlFIWXM4OStR?=
 =?utf-8?B?Z1FkbU9FVFdoZzR6VzU3QzAyRWF2Y2xiQ3RKQXlJZHVxdG9MMFpqV3dqZU9S?=
 =?utf-8?B?Mlo5ZUZZaWczZU1mcUNhaDFXdHR2NVpWZWNweFU3OUlVVnBad2hRd2J0NlR5?=
 =?utf-8?B?b09VYkNiLzd3NjVyZzlyMEt6bHpnWHFZRVRHV2dhWWVnKzZDQzVUTW9SYk5o?=
 =?utf-8?B?a1RRanQzc29tSVZVN3FYMkZGTkFUblh2eXdhK1p5dHM2T3VZKzFoenNTYy9s?=
 =?utf-8?B?VVJIQXlvUVU3TkNQWlVqRm5SOTd1RDh6dW9JdGIwTEJndnk3bE5RZ09DN3JR?=
 =?utf-8?B?QjYwS003a1BxdEhOQnF3TXFlUFk3TGJXV3I5NlphdXEvcWwrQ3RjOFFoUTZH?=
 =?utf-8?B?YmcvNXltNW9YUGRLSk9jZHJ1Z0hSOHNaaUFPSkVZRkg3YWVGQS9ldUI1cXV6?=
 =?utf-8?B?M2d4YnpmTmRrOTFXMU9aL3RrTFcrZWtkbk92MHlhRXFaRGdqYjR6dW1PT0lM?=
 =?utf-8?B?b2hybG0yMlVjUUowTENrbUZOTVNRWWxOcXZFYzlXSDJWVXpRWFlNL1dqRzlo?=
 =?utf-8?B?b3k0U09nVGkzd1NES292eHFTcG9JRE5NbXpSL0gyR0xoaDFqK2NlRFloUnNZ?=
 =?utf-8?B?aWVMK1RZbkFtK0JmM0p6bkU5WHFQL3cyVFdXbkV0VkhmV3JsVS9QSlpXWWYv?=
 =?utf-8?B?Ymc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: jsSHPLu4PplTR6P6g32VWd/qJ5aaU4c62R/7loPbZYOBsQqQam103uWdxBgzn0ldblghLJ10SBQl4krof9IO3MqNThoZ0jvriggdVyfmPT1rFJGOuFqUIV5F6HzjguRe1v0fQhP4ZCoMmn2KLVEESyYhvhPQfE/j6vkb5C2/aYWR9HZNY/RMu+kgm5oleRJiT+/LMOP68IuY6a3cfVFiyT1ThE3OnCXlB1jTkuEwUpX0aXYnIFQMZ31ep3NlTHXJkqYShHV+s0/+Fpd3eIwGW3WBhT1bGKT5eAUqF5ecYLKrNncl2X6Z2v/dH+ZGyBvNSX3tF2RbSefcY68Jh2z9sns84+XTAAYSWckuTpTSxJ8gGvHlrDJ3nh7Whu0JXsEHB6YNVx5/1CqVUw5Rq9yEDrgwI3oWsh08GuI9pwSgK4luN3xffg4izfuztg76tHScWJRiz3vkZNuz+uu2e4LnWLshN+Z5GsmCeItNDKzQlTBVPpDIdsg40uo8ycR6MiUkSJgN8Md8JjUVC6zXn5a4mroL3A1Hi2ULhHaZe1uEEZ4QnhQhuBCbqTvLAeRkYI+dG6dWBhSK34/Id6HvqDBbFrecVGhqxSQKnEt20vqQFoc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 168426d8-8995-40aa-b99d-08dd04da8c61
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 18:31:26.3394 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /M4zZHYE9b0Vhm5wH/5O3OVLY/n4R5/jUq+0N58KhVLV4sgpTZNW5x7duC1S5RkZgN8VaXhc2BDoSLEpPVDDEuwnjOjba04yqGh32QjImws=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5822
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-14_05,2024-11-13_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxscore=0 malwarescore=0
 mlxlogscore=997 spamscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411140145
X-Proofpoint-GUID: iYsPJrYW8I9K_mgaBduF3alJxF72KhkU
X-Proofpoint-ORIG-GUID: iYsPJrYW8I9K_mgaBduF3alJxF72KhkU
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 11/13/2024 5:02 PM, Peter Xu wrote:
> On Fri, Nov 01, 2024 at 06:47:55AM -0700, Steve Sistare wrote:
>> +Caveats
>> +^^^^^^^
>> +
>> +cpr-transfer mode may not be used with postcopy, background-snapshot,
>> +or COLO.
>> +
>> +memory-backend-epc and memory-backend-ram are not supported.
> 
> Just to double check: now the plan is to allow memory-backend-ram,share=on
> to work too, right?  If so, here needs a touchup.

Yes.  I will edit here, and in qapi/migration.json.

- Steve

