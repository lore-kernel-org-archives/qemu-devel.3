Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D14DE77188
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 18:36:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTQ2U-0001ce-Ii; Thu, 02 Jan 2025 13:35:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tTQ2T-0001bz-3U
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:35:21 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tTQ2Q-0001Jd-HH
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:35:20 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 502HXrGg029969;
 Thu, 2 Jan 2025 18:35:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=b96FTKRJ0/tg0w3/rW69qw5TBSauZZeF/uZrnUtHLUg=; b=
 lDj56Dch7SwCAKOicDNpaKjgPg8exzWmuZ5PpUiQmPkAdxbbnT2EtU1HNwOQZlRb
 YaHJ38unuan7MLmMz0GsRdZIOmj9MW649ETxlx1Lg/hI8SOID8amm9cuKI0aDjlj
 YrOZt/AC9KZpHYnmk/lFFTQjqjIw6julqDJb4VKL0c2i/xe00Dg0CKZ0aIpeu3fg
 3G9hg7Ls7PPYBUMXoMV/VOpbNCi0FLWoYqXU7eIgfveN5W/mKp1xDFs+Y1eOzxyP
 c4DvdOlyK28P7EKFabFdSvcMfODV7UQLYR/KXSWqNeuYxxWiA12gywz7DjtD58hs
 Sjep/ljBB7viHXgO4GAxyg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43t9vt6cm7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 02 Jan 2025 18:35:13 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 502IXwIF012897; Thu, 2 Jan 2025 18:35:13 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 43t7s8vkdn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 02 Jan 2025 18:35:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=smGfMuQHMdOk0CRGXm2WTHZrdPn+00/GHFnzZAVoBs78JrTesF/+73eansgUxDxmY7UyNr60faxBq/KoN6u6YlIN7pdxMaj8wzKMEg8wUtArRaqSTR5dbc8jnXziGLm44zrf6YNZyWU4Dgf7oTmkOnN5p/q9PZHedBN9Cg3t4lOtFwPp0Qj9Pa/b1FlIGK1ea2vCBMxDY783Oz+6tP3n7K6/7jsvrP/BwPis/c4TulvDSXOgVtgQqZE1+4KxhAk3Eq/b01zghevhbM751rDT0UesDcMtMvQntbJ5csR4mDh80TPFAA56dFEwl3vHHTCB8BE43omwXXtzYYAuqOJxyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b96FTKRJ0/tg0w3/rW69qw5TBSauZZeF/uZrnUtHLUg=;
 b=jOOHhTJesiTn86AYRJEzdxA0I1TQmkLdGt07SAwco+iRU8roJMKq8Uhp4h/6BAW+d/AlvLod68/X6+hPxnvxUKwWeQhZPe0tUQ7h/swYKOMN7abbP9ywAJfkKObC2PmWEJfWWX2REkfNy3iGIzUhkEqUz8+bTm8P3O5yNEYo9Re+DXnCnGFU173jefNIQa55AhunJ+3q9HWGwBjAVse5raoAUIWzXVg4vGA+3LYO0yfjhQQgYhcZKnC3rPLauyEOqut5KOKFl8nhLlbplx5QignwmtPkCF2wIOQd5u/efqx27A7lFRQ1/WvYqqCxOxBEur+pZWEacgELVK7b0T0RBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b96FTKRJ0/tg0w3/rW69qw5TBSauZZeF/uZrnUtHLUg=;
 b=jyUJYhVsxgvwNXHnOH4l7odrvEN4lXVhSB3nBEbqmfFZyn+7RThvj/zO7muy2ZUBpyEIDOEuNctrMLM+9RTwAqGGAQGj4pn41IUw4KE8Z7rR0n1zUCV0IQzqHuCFWUFxMGaeVnX5WVSgqbiBHGERFcxSMs+RRU8j6GjVFTtBllg=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by SJ0PR10MB6301.namprd10.prod.outlook.com (2603:10b6:a03:44d::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.19; Thu, 2 Jan
 2025 18:35:06 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8314.012; Thu, 2 Jan 2025
 18:35:06 +0000
Message-ID: <4becdc50-7f43-4683-9c76-cb75105ee998@oracle.com>
Date: Thu, 2 Jan 2025 13:35:01 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 22/23] migration-test: cpr-transfer
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <1735057028-308595-1-git-send-email-steven.sistare@oracle.com>
 <1735057028-308595-23-git-send-email-steven.sistare@oracle.com>
 <Z2sTHg-t0wB4g3Mh@x1n>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <Z2sTHg-t0wB4g3Mh@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ2PR07CA0010.namprd07.prod.outlook.com
 (2603:10b6:a03:505::27) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|SJ0PR10MB6301:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e9ea3c8-06a5-47a5-5f67-08dd2b5c2da1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YmdrM3VQNkxUU0grdDAxSFFiZjJGdGNRQVlqYktIU3I1RTI0SVBQcXczblRi?=
 =?utf-8?B?WXQ1a3FEa0ZtaGdwVkVLdlA1NVJBTE9pMzNpLzNkRml3U2NYMkFYUHIwRklt?=
 =?utf-8?B?WG9QQnpSTVEydEpmRVM5Wk9OOThudjc5UXlpdmdZSmIrL29mN3pqL1lKL1FI?=
 =?utf-8?B?QzZBS3RGR0R1UHZkNWlUTWg3aGQ3TnpwK3NjTGVkK1ZGVHh1aW96QUFzdlpK?=
 =?utf-8?B?UFJXUjhBeTdmVlNpbTRLdUhqTlVEY1FJb3ZmdzhrMmNGUlVsR1hwbEpsS3pt?=
 =?utf-8?B?ZE1CVWl1ZG43NVhnL3g1Mngzc2Y4Y01GU2l0N0tqT01aNGF2cWdTOEVXWmdn?=
 =?utf-8?B?R0dIVmR2UmhCdTY0NEVab1dGK1BTUCt6dEFnSTQ0QnVFcTY0MitpbGVvQUM4?=
 =?utf-8?B?Qk1PaUpub3MvTm9sYmluaGxhSlV4bWVJUmlNcE9iSlFDY2pGVDd3VldWdW9Y?=
 =?utf-8?B?RVFRUXBGaEhCdlJhbU8xb3daSHRSYlRQQXFqRE5XYzhMb3ZJRFA4SW9GSS8w?=
 =?utf-8?B?WjZhRXk1aENBa2xCOWFjQkhWYnVrLzNFWnNWRUVpeFhWTGNZci8zdVhQcjN6?=
 =?utf-8?B?WitPZkcyYkJoZXlpYU1ud1hxQzdVNEpRb0s5VG84cVJJdWNBT2x6MDZic1BC?=
 =?utf-8?B?ZFFaZ2JBVitiT3V5TWxDVmNvVXRnRDYzZzhCbVJERnNEcVRvUURzOTN4Lyta?=
 =?utf-8?B?TnhsK2xMeG5CQlFySmJsN1owaWwrems2ekgwMmtOaU9PTytRQ2Y2Q0VVZzVT?=
 =?utf-8?B?ZmhlNFd4RFNjOWhUQ3ErRExsRk01RUY3MmxBOENzRExJdFJhUE4xejJBeXJN?=
 =?utf-8?B?QWRTbEVESXlxeFFWZlVwa1JObWNKNkFMWldzdGwxZUZ5eWR3TWpJbDl6UUtJ?=
 =?utf-8?B?RnBuZnNsN3hJV0RKQlpORExzL1RDaVArcjd6enB1NGgwRjlSUENibmFVR2NL?=
 =?utf-8?B?VXlkbzI3MVIya3JvcTRXb01hUnVuRGpUcVRZMitwRit5Qmt3ZlBUc3AyU2NQ?=
 =?utf-8?B?WS9iU2hPYm55OXBXQnJCOXFlNUN1YnhEalI5ekZZVnJqbkJjSEc1SkxCRmtF?=
 =?utf-8?B?SEF3bFRNM0xIUGZKTlhwdytIUXhNWXhxTDVpVHc4NnJtSFFVK1hUcjdTOWNV?=
 =?utf-8?B?bzY0cHJNaDVOQ3ZvN1Q3a211YUlLckUxOCtJVmtDOVQxMjhMRUhmZUkvK0cw?=
 =?utf-8?B?RjVIS3RpZ2pxdy96ZElBRjRTMnlZTEhxR3d5ZmtiTEgvbnMrRkt3Wm40ZjVD?=
 =?utf-8?B?dDJnaHRwc0t3ekRpUzB5WHJrNW1pSm56MldoVDJBalovVFd5MXlMRGpvTXUx?=
 =?utf-8?B?bTU3UGhCVTdsbmJFcUEyT2lZOVpWa2lDYTFKQzNlaWJaMFg1dlFsVlJzLzRu?=
 =?utf-8?B?Y1ZYbFIxc3ZOb3pieDdJZks3UUttTVRhZlNXK1hOczA3RnplL1l3TEVURmRW?=
 =?utf-8?B?U1lKQzh6MGJyVTEyOFgxUC92TVVoTmIxbHd6SUZVbnFzWWp2WnVudnBzeUx5?=
 =?utf-8?B?eFJVeTBuZno0RXl0ZXpEbnR5ZEE1UStwTzVzTTFDTm9XaEhDTXNpZ0tNdFVL?=
 =?utf-8?B?NFBSOWNOWTFzMDRUbXJzM1FoeDFBL0FjV3FLcWlycG1TNHNMUGIrTTNVU3Ux?=
 =?utf-8?B?MGYvUVAxM0hpSi9KY3g4RXpCaWFKQWxtNXRzZEIyUlZMR0tRbDloS3luZ3NC?=
 =?utf-8?B?b2NjYUhWNi90ZUJzNjgzSmRJbmlQS254MlhrWklZWGJaeDZEQW1NV3BKZThu?=
 =?utf-8?B?d0JYN2xEc0RYNU5FVkxTZzhoNDVCa3NSSEdabzlUTEpNWXJHN2JzZmVmemRI?=
 =?utf-8?B?N2EzaDZuSFBOZUF6eUQ3RmRuNnpRZ1lPNHEwSkxJZXJiVVhkZnhqTi83WUlh?=
 =?utf-8?Q?1O5Wb6d6/cu7L?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dmx5b0dpTXU5WlVkaUdHejk4OStMejUyYmVpcTROd3VnTGdTNDRYbVR5NmFx?=
 =?utf-8?B?QWNlaTdRdCsxa09IMFFlNHphdWw4RWZIaVNoem5UNVptMEdoRzBTbFJUZVRh?=
 =?utf-8?B?c1lVMzJhLy9nTXU2ODNCbGdDbE9CTHZxOWp6QlZBUXlnWHJGRVFkREw1NDBR?=
 =?utf-8?B?L3dER2xKQkcwUG50WTMyRU1GWE5WWDIrUnlZUmswSGJ6RHIxMXlMYityTzMz?=
 =?utf-8?B?cUFkQkRVTDA4MUIzQi9SMFNlOFNsQUZhUVo2Sm9INTVLMDUwM0xWNGtFOU02?=
 =?utf-8?B?MSt0aDhTR1V4aUtXVmVDV21ISVNHbXVuci9PR1NHbUtiaGhTaVVsWDRjNnZK?=
 =?utf-8?B?MDJNeXFZdjROcTlCcHlidlJ4RWJGdFBPblVQNko3ckpMYk0vMTVOMTRoeXJY?=
 =?utf-8?B?MWs3VWhlakQvZ2c1cWtxdTlJYWIrSHIvMTBwZXN3dGsrVTFoOTBGS3BzVHFP?=
 =?utf-8?B?RGdBOUF1dVlTYzNwM1FSSjhVQzczeEJoNFN1NzhBREV1L1UxbEs0NHpTNE9r?=
 =?utf-8?B?OFUxdEZPTFFnOEZlVlg4UGFPdCtBWmovZkNYWU1pbGtYdTBsMXRIRVJ6Y3pU?=
 =?utf-8?B?aUlMTzVBeEZ3RDdXU0haZnBLR3FSb0s5RXFDMVNDVXdEV25oMnU0NEJVYm9Y?=
 =?utf-8?B?TXpTZVpjaVE4ZmVRKzFnOU9yTTRjeHREc3hpbHIyZVp1b0d6T3dGc1dVUTBP?=
 =?utf-8?B?dFJCOFp5NkhRQjN6U1pNUk1WZXBtaEZIQ0Uyb3lwcVp6TW51UkhNSUJGdUhy?=
 =?utf-8?B?WXY5ekRQNExTMDFSckhDcWMycHVudVJZczBtUE92MGhVakpKUTdCaDJuanJl?=
 =?utf-8?B?eU5IN1psU1hwYlIrUi9Ra2xWZWlLaE9xekFYOE1nNWFRZ3JvdjEvZmtXUHNa?=
 =?utf-8?B?MzQ4TU8xZ05pY3RqNW4rZktFeXBFKzhYN3pqaVhwdWM2WjJiWDBieHBrdWI5?=
 =?utf-8?B?d0Y5aHd3VFk2UE5TamIrTmlSbUl4WnhjTGtwR09ySmFzblZjVDJUODd2RnMy?=
 =?utf-8?B?VkptQUtPOHJrcGxBejhXZGdiVHBPdmVBVDhUWjkxLzZTUW5zUDJoWUxhTHRR?=
 =?utf-8?B?NlFrRVpSVlNTeUYwNnRnTW9zRjd4M3o2L3E3djFUc2tsZ3FyQXU0UkhNVTR0?=
 =?utf-8?B?YnY5VE5kQXVsWnVETXc1ZmRwcHg5VFlJTDM4Rnp4M2V3VHUzMk9HRzBkZ3lh?=
 =?utf-8?B?aWJISmlPcTFEUlJ0MkpEWG10S3huZkRTUjhINDMyNytYekU5Q2FDa2s4WDVp?=
 =?utf-8?B?ZEhMMk13NkZkTzQ2WnNIZEtGRThJV2JZS1htcm1acnVHZzhYR2RiVklCU0JX?=
 =?utf-8?B?VTZNUTZiaXZFUEY1akplN0JrVm5RdVJ1V3h0Y3pGQmZFdmloTHUxQy9OOXNC?=
 =?utf-8?B?dVFiZ21yT2lpYXdnaVhmZ3RWWTNzdUFudHJZcVJzZFNHY1U5RXBGWVVRd1d3?=
 =?utf-8?B?NU1vUGFrU2xZdXNrS2I3Z2JmYjRYWG13cVc1aHpkSHpOS2IwUFZ1ZG1YWFJo?=
 =?utf-8?B?WHA3dlVVL2dYRzg2TThaOXhpZjlvbENsWUJqbjJWOUplYjhLdGZwWEVOL1hs?=
 =?utf-8?B?WGgydmxWd2VqQ05RUHEvV0JvRHBOWDZWUkY3ZTY1T1B4Z2JMT25BR0JUcmNR?=
 =?utf-8?B?MmRYMENqYklJWVNYR3pkNFlxS2JEYVI4d3Yrbm1BNHNGWFIvbXhHci85Y0VC?=
 =?utf-8?B?di9QeFUrNnozd0xnd3lDYzJtcHlpaFQ3a3crSVBhWmdWVlErVmYrbW1BakIw?=
 =?utf-8?B?b2JabVVwNk9ncVRlNDJ6TlpxaFpZMEdpdURnS25hWVUvZzJ1ZFFaRWJROElC?=
 =?utf-8?B?dEZ3Nm44Q2VPdWRVZzY3b0xmT2hwVVVkTzRlN0VCWFBLSlZrMkRUbkJXYUky?=
 =?utf-8?B?SElEdEx6MXg1Wm9HQ0dwYVAzZExDbndweDVXMmsrV1lISkJickpIVmJhc3lH?=
 =?utf-8?B?b3NlMTRZQWE3d3pUeVhyVFk5RkdmS1hxckF5cWpUREcvclFRS0g2ZU5LRm1H?=
 =?utf-8?B?c3h5cmdsYWpuVkFqLzBNbU40V29odHNtWjd6bkFmZXVjM1o5WC95WFVVZDk3?=
 =?utf-8?B?UEhlbWllVXdPcGhGZjRHdjVncVpGZWQzUTEvRk5ENDRwUnZNdXh4OGZiRnRV?=
 =?utf-8?B?MlA1YWpXR09QR0RPeEhhc3U0QmI1b25rVlZlYWVjV2ZpdGxaaERKdXVPNlVj?=
 =?utf-8?B?dkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: +SVEKIuYb54cqG6rDxFGaWjU/JAHl0mofJ0MI/5xCPdq6DyvIw4zq1S9sw2QUnmxdcxBkLYTcMQswFZLM7C5y+hziIAjRjfnPIwPKKZ1ldLk0iPSgpmp8Yz59STXpc4CYN54fRzafhjm+tMi5u5AbK+CvtQEWaXtjAOTmvM6pAtz16qHNRNFvN/ymvlmCgrR62m+rJYhKkuwoaStY3Au6uqkgJuNXlnD+b46yMDpyArlBl/24AAr0ykisvxXo9ZoAsTTV0LAL/FZ7Swx/MRBTDjrqQhVR1IadM3syVqvmQprHRw/IeSpA0uG1jJaP6E9fnGEQDma6JlFeDK91rBpRRrEr5YTJalduQcwSZXAuHkSfRjR+qbeJ8kHz8iy967ihi1BC/m6U8YMlV6tf4u6W57sIXiAFXZGjyqgBAfJBtFVX89LFQ1IplRAQ7qtPj9oDz56Re65pFUvfvd2trUDunPw9ntvLPVN7YCxYX/8ANiCWE1J2l0pRJFEttzgCQJPhUZX1GEwwV8dmDt6O66nSYp+xFJU9xDHpHsgmHSk2tNi++5uS0TP5Ef2uGxbAQgIosYBYOtJ1XMR9KwoEBb+CSEh7B7FVk0ctfz9NPh7dR0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e9ea3c8-06a5-47a5-5f67-08dd2b5c2da1
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2025 18:35:06.0755 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2hJdrJb2Fe5/P0nt7hdtSKaDFVzpXc+O+0leeDuiula1sJEtyvYES+Fw/m+x5O6dnDtyXzwcjN+6/GVD5rBLtHnx76h8P9q1YcdDlBGHtXI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6301
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-02_03,2025-01-02_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 bulkscore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501020163
X-Proofpoint-GUID: dULAhVfQrgzI1pn0Z53AWjwugCpFoOj6
X-Proofpoint-ORIG-GUID: dULAhVfQrgzI1pn0Z53AWjwugCpFoOj6
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

On 12/24/2024 3:01 PM, Peter Xu wrote:
> On Tue, Dec 24, 2024 at 08:17:07AM -0800, Steve Sistare wrote:
>> Add a migration test for cpr-transfer mode.  Defer the connection to the
>> target monitor, else the test hangs because in cpr-transfer mode QEMU does
>> not listen for monitor connections until we send the migrate command to
>> source QEMU.
>>
>> To test -incoming defer, send a migrate incoming command to the target,
>> after sending the migrate command to the source, as required by
>> cpr-transfer mode.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>   tests/qtest/migration/cpr-tests.c | 60 +++++++++++++++++++++++++++++++++++++++
>>   tests/qtest/migration/framework.c | 19 +++++++++++++
>>   tests/qtest/migration/framework.h |  3 ++
>>   3 files changed, 82 insertions(+)
>>
>> diff --git a/tests/qtest/migration/cpr-tests.c b/tests/qtest/migration/cpr-tests.c
>> index 44ce89a..b221980 100644
>> --- a/tests/qtest/migration/cpr-tests.c
>> +++ b/tests/qtest/migration/cpr-tests.c
>> @@ -44,6 +44,62 @@ static void test_mode_reboot(void)
>>       test_file_common(&args, true);
>>   }
>>   
>> +static void *test_mode_transfer_start(QTestState *from, QTestState *to)
>> +{
>> +    migrate_set_parameter_str(from, "mode", "cpr-transfer");
>> +    return NULL;
>> +}
>> +
>> +/*
>> + * cpr-transfer mode cannot use the target monitor prior to starting the
>> + * migration, and cannot connect synchronously to the monitor, so defer
>> + * the target connection.
>> + */
>> +static void test_mode_transfer_common(bool incoming_defer)
>> +{
>> +    g_autofree char *cpr_path = g_strdup_printf("%s/cpr.sock", tmpfs);
>> +    g_autofree char *mig_path = g_strdup_printf("%s/migsocket", tmpfs);
>> +    g_autofree char *uri = g_strdup_printf("unix:%s", mig_path);
>> +
>> +    const char *opts = "-machine aux-ram-share=on -nodefaults";
>> +    g_autofree const char *cpr_channel = g_strdup_printf(
>> +        "cpr,addr.transport=socket,addr.type=unix,addr.path=%s",
>> +        cpr_path);
>> +    g_autofree char *opts_target = g_strdup_printf("-incoming %s %s",
>> +                                                   cpr_channel, opts);
>> +
>> +    g_autofree char *connect_channels = g_strdup_printf(
>> +        "[ { 'channel-type': 'main',"
>> +        "    'addr': { 'transport': 'socket',"
>> +        "              'type': 'unix',"
>> +        "              'path': '%s' } } ]",
>> +        mig_path);
> 
> So this test already uses json-format channels, IMHO we probably don't need
> MigrateCommon.cpr_channel anymore?  We could put them all here. Then..

The previous version of this patch did that, and did not define cpr_channel,
but you did not like how, in addition to using args->connect_channels, I
defined the main uri in args->connect_uri and passed it to migrate_incoming_qmp.

The constraint I must satisfy is that main + cpr channels must be passed to
migrate_qmp, but only the main channel can be passed to migrate_incoming_qmp.

I could instead define an optional args->incoming_channels, passed to
migrate_incoming_qmp, and only set by cpr.  Then the channel parsing extensions
could be eliminated.

This current patch with its channel parsing support does make
test_mode_transfer_common nicer in one way: the cpr channel is only described
once, in dotted keys format.  A V6 that defines args->incoming_channels will
need to define it once using dotted keys, to be embedded in startup args, and
again in json in args->connect_uri.

I don't feel strongly either way: keep V5, or define incoming_channels.

- Steve

>> +
>> +    MigrateCommon args = {
>> +        .start.opts_source = opts,
>> +        .start.opts_target = opts_target,
>> +        .start.defer_target_connect = true,
>> +        .start.memory_backend = "-object memory-backend-memfd,id=pc.ram,size=%s"
>> +                                " -machine memory-backend=pc.ram",
>> +        .listen_uri = incoming_defer ? "defer" : uri,
>> +        .connect_channels = connect_channels,
>> +        .cpr_channel = cpr_channel,
>> +        .start_hook = test_mode_transfer_start,
>> +    };
>> +
>> +    test_precopy_common(&args);
>> +}
>> +
>> +static void test_mode_transfer(void)
>> +{
>> +    test_mode_transfer_common(NULL);
>> +}
>> +
>> +static void test_mode_transfer_defer(void)
>> +{
>> +    test_mode_transfer_common(true);
>> +}
>> +
>>   void migration_test_add_cpr(MigrationTestEnv *env)
>>   {
>>       tmpfs = env->tmpfs;
>> @@ -55,4 +111,8 @@ void migration_test_add_cpr(MigrationTestEnv *env)
>>       if (getenv("QEMU_TEST_FLAKY_TESTS")) {
>>           migration_test_add("/migration/mode/reboot", test_mode_reboot);
>>       }
>> +
>> +    migration_test_add("/migration/mode/transfer", test_mode_transfer);
>> +    migration_test_add("/migration/mode/transfer/defer",
>> +                       test_mode_transfer_defer);
>>   }
>> diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
>> index c6ea3e1..f6175de 100644
>> --- a/tests/qtest/migration/framework.c
>> +++ b/tests/qtest/migration/framework.c
>> @@ -411,6 +411,7 @@ void migrate_end(QTestState *from, QTestState *to, bool test_dest)
>>       qtest_quit(to);
>>   
>>       cleanup("migsocket");
>> +    cleanup("cpr.sock");
>>       cleanup("src_serial");
>>       cleanup("dest_serial");
>>       cleanup(FILE_TEST_FILENAME);
>> @@ -692,8 +693,11 @@ void test_precopy_common(MigrateCommon *args)
>>   {
>>       QTestState *from, *to;
>>       void *data_hook = NULL;
>> +    QObject *in_channels = NULL;
>>       QObject *out_channels = NULL;
>>   
>> +    g_assert(!args->cpr_channel || args->connect_channels);
>> +
>>       if (migrate_start(&from, &to, args->listen_uri, &args->start)) {
>>           return;
>>       }
>> @@ -725,8 +729,20 @@ void test_precopy_common(MigrateCommon *args)
>>           }
>>       }
>>   
>> +    /*
>> +     * The cpr channel must be included in outgoing channels, but not in
>> +     * migrate-incoming channels.
>> +     */
>>       if (args->connect_channels) {
>> +        in_channels = qobject_from_json(args->connect_channels, &error_abort);
>>           out_channels = qobject_from_json(args->connect_channels, &error_abort);
>> +
>> +        if (args->cpr_channel) {
>> +            QList *channels_list = qobject_to(QList, out_channels);
>> +            QObject *obj = migrate_str_to_channel(args->cpr_channel);
>> +
>> +            qlist_append(channels_list, obj);
>> +        }
> 
> ... here IIUC we don't need this trick to manipulate the qlist anymore?
> 
> Looks like if with that (convert the current cpr_connect string to JSON
> format, attach it with connect_channels), then we also don't need the
> pre-requisite patch to make connect_channels manipulate-able. Not sure.
>
>>       }
>>   
>>       if (args->result == MIG_TEST_QMP_ERROR) {
>> @@ -739,6 +755,9 @@ void test_precopy_common(MigrateCommon *args)
>>       if (args->start.defer_target_connect) {
>>           qtest_connect(to);
>>           qtest_qmp_handshake(to);
>> +        if (!strcmp(args->listen_uri, "defer")) {
>> +            migrate_incoming_qmp(to, args->connect_uri, in_channels, "{}");
>> +        }
>>       }
>>   
>>       if (args->result != MIG_TEST_SUCCEED) {
>> diff --git a/tests/qtest/migration/framework.h b/tests/qtest/migration/framework.h
>> index 1341368..4678e2a 100644
>> --- a/tests/qtest/migration/framework.h
>> +++ b/tests/qtest/migration/framework.h
>> @@ -152,6 +152,9 @@ typedef struct {
>>        */
>>       const char *connect_channels;
>>   
>> +    /* Optional: the cpr migration channel, in JSON or dotted keys format */
>> +    const char *cpr_channel;
>> +
>>       /* Optional: callback to run at start to set migration parameters */
>>       TestMigrateStartHook start_hook;
>>       /* Optional: callback to run at finish to cleanup */
>> -- 
>> 1.8.3.1
>>
> 


