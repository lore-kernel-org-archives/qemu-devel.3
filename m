Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9EFBE77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 21:04:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tO1Cd-0006cM-LP; Wed, 18 Dec 2024 16:03:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tO1Cc-0006c6-Lr
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 16:03:30 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tO1Ca-0004PC-3h
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 16:03:30 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BIKIYRV011072;
 Wed, 18 Dec 2024 21:03:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=0TWVtxDEK2015y6lmXiezm2L1MzoMJbQgblVOexMo28=; b=
 Q4c4xuml5iD7+WITSaA+/3seNqc0rALASNZlTq8WtX1jzDcwE13qYbk5z4R64uXv
 waAHBNBBfCiPXR6IKh6+MTPUVFhsQE9KZ5w5tlxBoabcO1a6jM6B+99a6jn5udPB
 Bf+GCQVGZpGNEqIBVB2KRq+3hT9SlcxiyCz9vvB8cpYMAT42oWmxjDVJugJR6odh
 GjzD9JscYeJjR4Gt9DE2FhlbMLmeJt7RqukhwGEev96xMddCY6fyyT4fConBAIJz
 ata4HAbXn5ybGluateL65uMi6ng1NAcnM69Yo8RJL8xzokrLuQx7ho2M5lcfgfYT
 5IvwdipXv631eagSf3VS6g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43h0t2hmac-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 18 Dec 2024 21:03:25 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 4BIKAY2W010969; Wed, 18 Dec 2024 21:03:24 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 43h0fa7bve-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 18 Dec 2024 21:03:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aVX6IRspKbBlZ1CBws9+hqJTSP6Fe6FALl4ivIL6dEC74D2kaF6JhKppyQozmnz9n1BcV78Yw7QmH8nGeAGTiaxELqS8fw4CxRfPoAwjPofRizqH/MVWjVI7MW6odilnRtXWckwA2ubEr0Ua6cu7GVj6jdAuOganszuFn63zAMk5mNluyDjfEwhX/9Bj8QyaM3KJlXRdv5Si/JzGTfvAnLs3yNyXxaL7o8OHKqiAodPPVIlhknCuCvIe8tGCHYm/5/HcW+HV5rQ01vqEPpUruYtqMNGr3kKaAW0XbT9k0NDN7iDPQwIUIsG8VjOedV4Lj+10cSGZZwwzEf40MdD6Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0TWVtxDEK2015y6lmXiezm2L1MzoMJbQgblVOexMo28=;
 b=eIKpUP90xR+RDSdOezo/NP5SpDZ2plVjvfyVZLKhhzG2yS+FyxawZ0GNFBsJ1pyP6ThAyX/qkggHFphGtRcDxYpXTlkd7PviEAN59uU/5gTBLXQq4jWFfJimHmvn3w8kwGNkynbOaNJOi5xpTo+kXVYOXFAC7RhSNN/Bcl734EUOQ8Fvqd+Vq6NdSOCpooW4SNwBZOJIE1XKv6J2zcfgCQvI/DowU9LE4tv9uB15TX3myocuEpvg7lT82pIAmTKzr0jJ+/BbfoByoRF+ksL8Ob2zLObb+JLozIF0zymx7tIx8LTeyLumLbG54WdRderKCcta9VePC08qUfMaiKAQew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0TWVtxDEK2015y6lmXiezm2L1MzoMJbQgblVOexMo28=;
 b=DmJ59i7Wjckli6UHK53a7y0zQh+hh9vILRlvcncSV+Os5OjmqVewYElkySY/f1ukiSfwsa09viibE2L3ZIJfmVX/mQc1Ru/JwBwsDZzjUlxs67Ods+JIJxShSnWLtWUz3r+zCGPhx5U8FtY4NA8y8Lk5ErWx8bZQd62wv+40zNQ=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by CH3PR10MB6763.namprd10.prod.outlook.com (2603:10b6:610:147::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.18; Wed, 18 Dec
 2024 21:03:12 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8251.015; Wed, 18 Dec 2024
 21:03:12 +0000
Message-ID: <6edb8e64-1cd8-4450-a8f8-59450bff78d0@oracle.com>
Date: Wed, 18 Dec 2024 16:03:07 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 19/19] migration: cpr-transfer documentation
To: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Markus Armbruster <armbru@redhat.com>
Cc: David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, qemu-devel@nongnu.org
References: <1733145611-62315-1-git-send-email-steven.sistare@oracle.com>
 <1733145611-62315-20-git-send-email-steven.sistare@oracle.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <1733145611-62315-20-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO3P265CA0030.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:387::12) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|CH3PR10MB6763:EE_
X-MS-Office365-Filtering-Correlation-Id: 114c923e-62cc-4fc1-f10d-08dd1fa76220
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cWVCc1Nxend6em0zN2NtdlRRWTRldjZmd3FQUzJuWU0xdldPZHVUOHEvZjg2?=
 =?utf-8?B?RDN2VS9xd0RLa0tJOEY4QjhvRU9MTFZGdGlUZ0taeTY0SDdxNkRoV0k1ZGht?=
 =?utf-8?B?TVBDempoZ1owK3ZwZjhqY3c5QmUwSERMdWZCczVhNW96VndCbG5KYytnbDU0?=
 =?utf-8?B?NC9ucFh6OWVZWjNva2dTNnh1QjdJRkVoSVFlSUpqYWZNYVVsTnk3elZ0NVpz?=
 =?utf-8?B?dWRzcXZaRVM3MDZsWXI4dWErVGZUb1lKRHVTMmpwTndRMEwzbWU2c0FaaVJL?=
 =?utf-8?B?eGVuKzYvVUJzQ0h5MUlhRWV0Vkpma2NocEIzZHZLRjQ2NFFCRG9xNkRYbkFH?=
 =?utf-8?B?S0wycGU4eWphc2ZGaFQ3dnFZUG81aTJpYWVJYlBJNTc4VlBZemYzZFlkM0lz?=
 =?utf-8?B?cDZsakZPeDBUUEtIM3E0TVIwVTQ5dktyM0pZZUpmUXdIaHhPVHcxQ2N5TTd0?=
 =?utf-8?B?ZHM1YVU4SjVDWERxK2lYK3dqOHhXS0NheC96L3ZDWHBlUnpWay9JR0pmQWZ5?=
 =?utf-8?B?YWFpa0EvT2h6RzRVYk9RNFo1YmQzZjFKNndEUzBTdUFuTENQVjZjZlJ6bDk5?=
 =?utf-8?B?RFpJSGxIWlVMNmRIV0lXOUlhSjFYeXZWajcwUHRmL3JQelIvZVVFTnYxNnVi?=
 =?utf-8?B?N1JsRXY2Rm5LNXE4eUkxbnhrdlhWcVZDNk1QT2pCYjJBTEhxa0FkT0tNaTNu?=
 =?utf-8?B?ZHZkY0w2ZlgrTW1VY1VFK2lzeE1PNjgvNDVDcGZkMVNudTdwRkFLZXdTTytz?=
 =?utf-8?B?L1JkRGZUdnBhK3ovampYKytSemE2RmhZOEt1ejRjeGIwWFlMRnFjWUxIMllE?=
 =?utf-8?B?akkxb09xdDNvS1pMNXpKdFI0K0hVclFDSXB2YWUwVWpFaVFJZXpuWnpIbXBY?=
 =?utf-8?B?SFd6L3JjblV1UDBELzlkbXZacTN4WHRJUGhKckUya3diQitJTnh3V2V0QVpy?=
 =?utf-8?B?SVErajA0cVdaZUZ0RllmNzI1UnhpMnhDUVFRNVlmMHYxODRURnhubnhuL1RF?=
 =?utf-8?B?OElEejFBRmpWQXQySy9ZM1BuVHpvQ1M5T1MySHNyKy9JVGhBeTBUbW02NXVw?=
 =?utf-8?B?V0paSGRxVUtUcWkxbThFUTBkV2FKRlhxUmFxSUhoVTlyM1A2MFFvNWMxYnll?=
 =?utf-8?B?WHFaa0ZFYkJZZXA1Tk1ZQ1JPbzJyVmRERlJlamo1WHBnK1h2L0F2cnhUdURV?=
 =?utf-8?B?L2MxRUN3dnJsWm0wa0l2VzVIMjZoa1hnd0ZCUjY2eHZma3dwTlcwSmFXUnRt?=
 =?utf-8?B?eENYdDE0ZktlQmt6Uk9hVVVKUkVrYURCL0NLamRJRStIdGlrWElrOXRDcVpQ?=
 =?utf-8?B?VExHZzN1bGN4UzlQQ2dIMWd5bHFiSnNYN1pDNE5FU29WRlFWckxYZ3VrRjll?=
 =?utf-8?B?WjVBNWVIRzlvSUJOUnVpaHZCa1FzNGY0NHFMeHluWUpmQlBTbFVuL0p2WEMw?=
 =?utf-8?B?M1ZsKzdvczdkY0piaW84TXJZLzdLYmJ1RDhZcFlRcVJpQitqYXZUeXZ4Q1FU?=
 =?utf-8?B?YUR5eU5seTlHZ2pvQWU2S09wNDk0YXIvd3hZUWc5M3p3c3Y4N01lVWQ1Rjdz?=
 =?utf-8?B?Y3lTNlA3M3JqUmtqblgwNDZUSy93L2F5dE5NWlJUek5RUmtzcG1oSWVpWG9P?=
 =?utf-8?B?cE1helZSclRpaWo2VjRGUGk4TWdKSmJpZU8wVjEyMXlldlZwQk5HM3dGRDZl?=
 =?utf-8?B?NU14REdxUCtxVFl2eURDNXorTWlySUNWUUdzTVVrOGpTeGZZcERUN1ZxS2RU?=
 =?utf-8?B?bG1oZmNmRE8yRVptNG8rU0YyMFJDR1Zyam5COFVmck9zK3ZBRmpHNXNkMy9y?=
 =?utf-8?B?WkR6OWJrRW8rNWJrTUVxS0JZTlhIeHdxdUNDd2hmajB5RUNHaUkyWDdhNDR5?=
 =?utf-8?Q?wsyT7yXgyU649?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWI2eEtiVXplZE01dUV5bktXd2l1NlpiL0tsbFM3T3BjaTEwenpJOGYrcGg1?=
 =?utf-8?B?bjFHeXk5UjZyZ3VrMG1sWjhCZmxkS3NZZk5la1o1MUV4aVVBRGdZWFU4eWFm?=
 =?utf-8?B?L1ZyalFVbEl4TThQYmhEbWtORmloaFc0SitueDQ1d05Sdm91ejJYS0tqZ1Rp?=
 =?utf-8?B?UHBKYXBPcXZVSDZmek1Ia01raTB4dkZ1dGJTU0dGNXVLaUZKOUFZcm4yMkZ5?=
 =?utf-8?B?MlVtRVRzSjFGNHFPRnFES1JMemx3L2lZMWRXbmhSM0cxdWI1U1F1SUlxejJY?=
 =?utf-8?B?djc1M1gyZ295QXFscGRNUE01QWlDRHpUSmY5VzR0YlBaQWgzSmRwVk8zNFJ3?=
 =?utf-8?B?S29EYjFPUzcxOFVKL2dnWTIrdFhCVEc4UXdpQnVudjJGMEk5ek5QYTc5SlRD?=
 =?utf-8?B?Q0ZLRUdiUlpZNGpaK0t1UlZBK0NYK3pJb2t6Vmx1eXRFUzhtbkxVSGwzUHhG?=
 =?utf-8?B?amcvaUhjVUI2QWRMenBlaFd5dVFjTmsrMnh1U3JUdjY0cFJOeGZjZDQ0R2pI?=
 =?utf-8?B?dU5KcEF0cERFWHpTU1liRlo4TmZCa3VnSWpUZEY2U1B1QkUzMUQrZ0xFQXNM?=
 =?utf-8?B?VHFySDVUR0VzeklzdUtKVGpuOWFrR1F5MXkySFJVVVpUd012a0pPUkdzcEhl?=
 =?utf-8?B?bGJlTWo1R203ZUNBR2VFSmhtUEJZVFpabTRhZkdBUHc4SUY1MDB3YU83eitB?=
 =?utf-8?B?OWdaanVqQVEwcENoN0NjQUlNeE41TVJhVnFaWGw4QjdzSXY5MlJqWXZMSjht?=
 =?utf-8?B?T3RUNHUvOExUQit1YWpnRWlmMDZ4QnMxakRjZTdtZnZDcEZnUm5aZ3RWRjRK?=
 =?utf-8?B?VmNueXRHK0o1UnJsZ0VMN1JuUTZUSHNEKzRnZHVEUmdBTkdBZGoxYWRWYlR1?=
 =?utf-8?B?ZEdFblMyVWVXUjgyMDAzRmxMbEhhVC9kUExMc2d5MDdQOERZZ2NMM084d2N2?=
 =?utf-8?B?SDNmdTVFQm9XUVdManZUajV0YnlTblhSMVdueXRqVWRuRDQxRUo1T3JLSUxl?=
 =?utf-8?B?eE9HeDA4bWc4d2FiN2VwK2Q4MjN5SWlNL1dUNHZwZjB1VEZNM0h2YVB0MmtN?=
 =?utf-8?B?SkhoVW9wdFVHaGhiSC8xUzFOZk5lOXNHRkhxK0E5UmtaL0Q4Q3FwTjFmY2dR?=
 =?utf-8?B?ZGZmMU9VQ1ZKYnVZcTFxbHhCaXNGaFYwVWNoMnIzMXdEOGtrQW1pMGFVdnVq?=
 =?utf-8?B?dGcwRytNdmZQU1hpbzg1RTdYQlRtYUVJSDU2ZGpzc2dCd0dyU0Rra2JDdkpH?=
 =?utf-8?B?MlUxYUJhMncrS3pzYk5LZmx6RjRkSFpSYjgvTW14Y1RLUXYzbHN2S2FFS3NM?=
 =?utf-8?B?a1JlSFFKakd6Ylk2VU8yc2htSUc0V2tXWDBxamVzSlZ4TlRCOElaY202S3lx?=
 =?utf-8?B?UzFxTWdpRExNbDZwQlRTTHBqNWkwQk5RNnpUOTJMMUFyNmd0bVFEb01sRG0v?=
 =?utf-8?B?T2Q0ZXB6UnozNktzM21oVG1YWkI1cEp0cUlUcVl4MG14cUo2cmU5UzZ4UUw5?=
 =?utf-8?B?VjhqNk0wcmUyUkVZMDQzRFVxcHA4SVZGckZZUDB3V0YyYlFkYU9lWDNrMkh3?=
 =?utf-8?B?Y2xNbVBGd0dOeDRjV2hQazdFUWZUMXpRTHNSS3hEaHJWY0hlWEJ1UU96Y1h3?=
 =?utf-8?B?Sk1yL2ZlVHdHVDRHVi9yc09neHBUdkxNMUpmRDRZOHFnbTM1alVmdmF4U3Yv?=
 =?utf-8?B?SCtEZUdBL0ZJZUZGWjJqRHU5dzRtdGpRa2U4QXhmcm5JRTRXd1ZwVmZhdXIz?=
 =?utf-8?B?RUhjUjVYcWxaNnhRaTFhVGhrNWNPM1RKUk0yVGRWbTQyV1czN2FlVC9GZzZ1?=
 =?utf-8?B?YklidmZtcjFTUE50cHBhdkVXZnVVcWxvWlpjR0ZvRzdXQTBoN2NyMCsvMi80?=
 =?utf-8?B?MCs4UVJYZXEvKzVBUk1aaTRNZ1NPNEN2ZGFXZHdudk1YT0lUMC81NElzQUxE?=
 =?utf-8?B?OTJ3S2FNZ0tvcjNsTHNIUkhPZk92SUQweDJETk5JS3l6am95dW13RGF5VDJo?=
 =?utf-8?B?SUs3OUFQVzgvNjNkdGRZN3RRMFBaeHg5Mi95SE5od050VXBOVld2cnFmRDdP?=
 =?utf-8?B?K2ZjRmc0QkZlVERvaGRHM0dPdWduVFpwVi9LdXBjQWpjMzVxY1FmQ3RNK1FE?=
 =?utf-8?B?UjdKaVJtaWlYTG95ZGlzRmROZ0VYYkNVMWI0Q2ZpR0pVbEZjbXlWY2pZOHI5?=
 =?utf-8?B?OFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Lm+L0HoJKWUz0ic0vguZbObyl3Z8c3vpSShJbDFwUXVyhPpx6k3PqCwn62NDWbjCZRIx3C2OpShf9FhNSgpJ4LKDIdw+ov4MJoW6Cxhq2bIb+3bqbbOnrP+cprmAmLbSlUbt/NnjhkFQ8P3A+PC6Y2Zrr+54mBW64k80vCNXfipXKDPBmsDgzZb4LwMaGkBt7+ei9Nfj3Ri/4Jzxcf24VJ5gBDQ2eypE/wQtEEQg4/2a06AXjN1fb6XHYTqYV69MrHDpgE9sdnSIXJ2/34N7Eonnm7j9xCbmEgnV4n/78VQqkOOBuglw5Ujwz/CrRrwog+IpUy1ZxahMm2PNrFn8jtnY8/+W3c2QfnuvuhyRlkQT7/gksQMPAngTGofuSgMyISHAP4MiHp912oU0Z1KPeJ/31P1KDa8AxZmxkE3HmzHJSdHBa9Ih0W+G9L5x8ALdFrZOaywHqbMDegJAylCtR2fxSs+rfqwQMqa0nGC8JSUIba9UVn2ps26Fe4KiMEGKOphA0Gi1f0JPuF4bofOTDOIvkESQY14vvFgskgSfVh25VtO8VtW8xbE1Wyu4emwTsajWzuR0bY4TS4BHJSlwAbmNYvS61n5G3imagKsdASA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 114c923e-62cc-4fc1-f10d-08dd1fa76220
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 21:03:12.4689 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MCw7CaacKVyi7n+pS8Dt7Bu9d9zTgWcYq7LraEtG/aOJeJj5o+4sxmTzhFDFBwGz/uoKmyjE/1B7zb8hYnCn46xYr5Y7P1OMRAT4Q1QrT/4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6763
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-18_07,2024-12-18_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412180164
X-Proofpoint-ORIG-GUID: -k3c0iEPB7UhsHtmD9geHfQ4alMYwCYa
X-Proofpoint-GUID: -k3c0iEPB7UhsHtmD9geHfQ4alMYwCYa
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

If someone is bored, this needs review, else let it ride until V5.

- Steve

On 12/2/2024 8:20 AM, Steve Sistare wrote:
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>   docs/devel/migration/CPR.rst | 176 ++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 174 insertions(+), 2 deletions(-)
> 
> diff --git a/docs/devel/migration/CPR.rst b/docs/devel/migration/CPR.rst
> index 63c3647..a8a57c0 100644
> --- a/docs/devel/migration/CPR.rst
> +++ b/docs/devel/migration/CPR.rst
> @@ -5,7 +5,7 @@ CPR is the umbrella name for a set of migration modes in which the
>   VM is migrated to a new QEMU instance on the same host.  It is
>   intended for use when the goal is to update host software components
>   that run the VM, such as QEMU or even the host kernel.  At this time,
> -cpr-reboot is the only available mode.
> +the cpr-reboot and cpr-transfer modes are available.
>   
>   Because QEMU is restarted on the same host, with access to the same
>   local devices, CPR is allowed in certain cases where normal migration
> @@ -53,7 +53,7 @@ RAM is copied to the migration URI.
>   Outgoing:
>     * Set the migration mode parameter to ``cpr-reboot``.
>     * Set the ``x-ignore-shared`` capability if desired.
> -  * Issue the ``migrate`` command.  It is recommended the the URI be a
> +  * Issue the ``migrate`` command.  It is recommended the URI be a
>       ``file`` type, but one can use other types such as ``exec``,
>       provided the command captures all the data from the outgoing side,
>       and provides all the data to the incoming side.
> @@ -145,3 +145,175 @@ Caveats
>   
>   cpr-reboot mode may not be used with postcopy, background-snapshot,
>   or COLO.
> +
> +cpr-transfer mode
> +-----------------
> +
> +This mode allows the user to transfer a guest to a new QEMU instance
> +on the same host with minimal guest pause time, by preserving guest
> +RAM in place, albeit with new virtual addresses in new QEMU.
> +
> +The user starts new QEMU on the same host as old QEMU, with the
> +same arguments as old QEMU, plus the ``-incoming option``.  The user
> +issues the migrate command to old QEMU, which stops the VM, saves
> +state to the migration channels, and enters the postmigrate state.
> +Execution resumes in new QEMU.
> +
> +This mode requires a second migration channel type "cpr" in the
> +channel arguments on the outgoing side.  The channel must be a type,
> +such as unix socket, that supports SCM_RIGHTS.  However, the cpr
> +channel cannot be added to the list of channels for a migrate-incoming
> +command, because it must be read before new QEMU opens a monitor.
> +Instead, the user passes the channel as a second -incoming
> +command-line argument to new QEMU using JSON syntax.
> +
> +Usage
> +^^^^^
> +
> +Memory backend objects must have the ``share=on`` attribute.
> +
> +The VM must be started with the ``-machine aux-ram-share=on``
> +option.  This causes implicit RAM blocks (those not described by
> +a memory-backend object) to be allocated by mmap'ing a memfd.
> +Examples include VGA and ROM.
> +
> +Outgoing:
> +  * Set the migration mode parameter to ``cpr-transfer``.
> +  * Issue the ``migrate`` command, containing a main channel and
> +    a cpr channel.
> +
> +Incoming:
> +  * Start new QEMU with two ``-incoming`` options.
> +  * If the VM was running when the outgoing ``migrate`` command was
> +    issued, then QEMU automatically resumes VM execution.
> +
> +Caveats
> +^^^^^^^
> +
> +cpr-transfer mode may not be used with postcopy, background-snapshot,
> +or COLO.
> +
> +memory-backend-epc is not supported.
> +
> +The main incoming migration channel cannot be a file type.
> +
> +If the main incoming migration channel is a tcp type, then the port
> +cannot be 0 (meaning dynamically choose a port).
> +
> +When using ``-incoming defer``, you must issue the migrate command to
> +old QEMU before issuing any monitor commands to new QEMU, because new
> +QEMU blocks waiting to read from the cpr channel before starting its
> +monitor, and old QEMU does not write to the channel until the migrate
> +command is issued.  However, new QEMU does not open and read the
> +main migration channel until you issue the migrate incoming command.
> +
> +Example 1: incoming channel
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +In these examples, we simply restart the same version of QEMU, but
> +in a real scenario one would start new QEMU on the incoming side.
> +Note that new QEMU does not print the monitor prompt until old QEMU
> +has issued the migrate command.  The outgoing side uses QMP because
> +HMP cannot specify a CPR channel.  Some QMP responses are omitted for
> +brevity.
> +
> +::
> +
> +  Outgoing:                             Incoming:
> +
> +  # qemu-kvm -qmp stdio
> +  -object memory-backend-file,id=ram0,size=4G,
> +  mem-path=/dev/shm/ram0,share=on -m 4G
> +  -machine aux-ram-share=on
> +  ...
> +                                        # qemu-kvm -monitor stdio
> +                                        -incoming tcp:0:44444
> +                                        -incoming '{"channel-type": "cpr",
> +                                          "addr": { "transport": "socket",
> +                                          "type": "unix", "path": "cpr.sock"}}'
> +                                        ...
> +  {"execute":"qmp_capabilities"}
> +
> +  {"execute": "query-status"}
> +  {"return": {"status": "running",
> +              "running": true}}
> +
> +  {"execute":"migrate-set-parameters",
> +   "arguments":{"mode":"cpr-transfer"}}
> +
> +  {"execute": "migrate", "arguments": { "channels": [
> +    {"channel-type": "main",
> +     "addr": { "transport": "socket", "type": "inet",
> +               "host": "0", "port": "44444" }},
> +    {"channel-type": "cpr",
> +     "addr": { "transport": "socket", "type": "unix",
> +               "path": "cpr.sock" }}]}}
> +
> +                                        QEMU 10.0.50 monitor
> +                                        (qemu) info status
> +                                        VM status: running
> +
> +  {"execute": "query-status"}
> +  {"return": {"status": "postmigrate",
> +              "running": false}}
> +
> +Example 2: incoming defer
> +^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +This example uses ``-incoming defer`` to hot plug a device before
> +accepting the main migration channel.  Again note you must issue the
> +migrate command to old QEMU before you can issue any monitor
> +commands to new QEMU.
> +
> +
> +::
> +
> +  Outgoing:                             Incoming:
> +
> +  # qemu-kvm -monitor stdio
> +  -object memory-backend-file,id=ram0,size=4G,
> +  mem-path=/dev/shm/ram0,share=on -m 4G
> +  -machine aux-ram-share=on
> +  ...
> +                                        # qemu-kvm -monitor stdio
> +                                        -incoming defer
> +                                        -incoming '{"channel-type": "cpr",
> +                                          "addr": { "transport": "socket",
> +                                          "type": "unix", "path": "cpr.sock"}}'
> +                                        ...
> +  {"execute":"qmp_capabilities"}
> +
> +  {"execute": "device_add",
> +   "arguments": {"driver": "pcie-root-port"}}
> +
> +  {"execute":"migrate-set-parameters",
> +   "arguments":{"mode":"cpr-transfer"}}
> +
> +  {"execute": "migrate", "arguments": { "channels": [
> +    {"channel-type": "main",
> +     "addr": { "transport": "socket", "type": "inet",
> +               "host": "0", "port": "44444" }},
> +    {"channel-type": "cpr",
> +     "addr": { "transport": "socket", "type": "unix",
> +               "path": "cpr.sock" }}]}}
> +
> +                                        QEMU 10.0.50 monitor
> +                                        (qemu) info status
> +                                        VM status: paused (inmigrate)
> +                                        (qemu) device_add pcie-root-port
> +                                        (qemu) migrate_incoming tcp:0:44444
> +                                        (qemu) info status
> +                                        VM status: running
> +
> +  {"execute": "query-status"}
> +  {"return": {"status": "postmigrate",
> +              "running": false}}
> +
> +Futures
> +^^^^^^^
> +
> +cpr-transfer mode is based on a capability to transfer open file
> +descriptors from old to new QEMU.  In the future, descriptors for
> +vfio, iommufd, vhost, and char devices could be transferred,
> +preserving those devices and their kernel state without interruption,
> +even if they do not explicitly support live migration.


