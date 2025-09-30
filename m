Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 209ABCAC5B8
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 21:16:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3hgf-0002gH-Oe; Tue, 30 Sep 2025 17:15:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1v3hgd-0002fM-SI
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 17:15:04 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1v3hgP-0008Jb-TG
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 17:15:01 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58UKMje8023847;
 Tue, 30 Sep 2025 21:14:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=gRDV+9u0H/KbxEBaAyUNeTj/OGFZ2lo65rLJmJW3sjQ=; b=
 ZRIFtlynpQXr/1XSNGIXFr21i5/1neIBmhmnQXES/ZjhmdbqqawsUTDOVgYNADRR
 aV1bVlW6Lotd3Wq8xxXQxy/Meg+rjz9Iz4LcG3Nn4df9lMfoKc2bXhDh3cPoJxsk
 QlpZPGxBY5F4N7LZRJbr9JJdr9UyZmgKoG0VAD+LcIMRHQV6LuwLizkXkayac3jb
 oy/zNrO3tAw8eQXaf/R9S3ARVQwAsayoNhJxPFmtLJgkznVGeJGAmhvSXbRTetXl
 SWf+omDOhCgzvvhoS+Utzu+zsJNcYVG6/zuSC+m3UxSBeRYgefYocn+zkW9fNBLN
 wH0zNnaU7rzhKmoULNALOA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49gkxngbm4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 Sep 2025 21:14:43 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 58UJQ1gX008130; Tue, 30 Sep 2025 21:14:42 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11010005.outbound.protection.outlook.com [52.101.201.5])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 49e6c9d9ns-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 Sep 2025 21:14:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qdyj65JpPD6EZC7o8/EGkClV2I2Di666q97CSd3LterwzTanibvIZlow0lm6TIervqKKWK0wUITDrCw2GQnZonRD6ZfrONQE08y9AEmo/pk+/wsRgasBWYt5tphJ+Dz6Jqb23dimtH0mH0xunh0TV+ok7jtBiAAee+ogkTW6B4jT6ZYQa0l4owXiQOvvQ1pFoAhsXYHuQ7AI0EWDmroNi2Cr0pCy64AVQ2oeP/hcTW5M4NbEygW2FUaQ4DsmPyEzUl2rTRgj85o0SThcXrVpZ8tSngj2wbsgYF9W90Hp/Lqr9s2f7GOpvNT5BeKvXwJyDctzggqmlbxqWviEIBrkmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gRDV+9u0H/KbxEBaAyUNeTj/OGFZ2lo65rLJmJW3sjQ=;
 b=yLbYrD6y5QYEVQSlPxMQJ/h3P8bX6IPF3IzoYBT33K6kO36TiNT4pMoT0+F4BjH9vQ5IPwKdmH9+khTLr9oqB7AMREDIueUgZUgfSHB64+rSh8IEbqxMP0c6BqHJWsB0WidtYE0hNhr+Bzz3Lmyk9z8FfX1V1BdoXRUNXS5Us9shMG2TZJEOQwDc/8qimzW5JLpAUZ+UqQJZepTrKXWXcrKv0dU89ADjkhTZuRg0IJiImve0UVc2495impshiy1kIoqI7OO9jMO4aRqIQpPGb8eIfBI0hRnBCAnMkSEZtj621DtrlZxXHTafKhk59A2l+zaevcMNOOE5oSrG2BHt7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gRDV+9u0H/KbxEBaAyUNeTj/OGFZ2lo65rLJmJW3sjQ=;
 b=ADfmO13RlFkuv0IZAH3r/UJ5OV53nxr73B4YsnfSliztlu7WRlpBhv2mOpRzJiw1f0dYsaYHYO4Gl7gAeU+lT22NUEQlk2N6zti1WzuXl5RfZEOONjR7RmnqrY/pU9a19h9Bw0iyBoYhSj4ew0o1xBMEYOujmhbFZby7jNIsJ2k=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by CH3PR10MB7356.namprd10.prod.outlook.com (2603:10b6:610:130::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.16; Tue, 30 Sep
 2025 21:14:38 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%6]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 21:14:38 +0000
Message-ID: <4e6a3f1c-8fd4-486f-bc0f-fe0673988240@oracle.com>
Date: Tue, 30 Sep 2025 17:14:36 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 09/11] migration-test: migrate_args
From: Steven Sistare <steven.sistare@oracle.com>
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Xu <peterx@redhat.com>
References: <1758291153-349744-1-git-send-email-steven.sistare@oracle.com>
 <1758291153-349744-10-git-send-email-steven.sistare@oracle.com>
 <87a52bvhw0.fsf@suse.de> <0f4caf91-4ad5-4e1e-91d0-12959f1a89a1@oracle.com>
Content-Language: en-US
In-Reply-To: <0f4caf91-4ad5-4e1e-91d0-12959f1a89a1@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR06CA0018.namprd06.prod.outlook.com
 (2603:10b6:208:23d::23) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|CH3PR10MB7356:EE_
X-MS-Office365-Filtering-Correlation-Id: c4fe0540-dbf3-429c-67f4-08de00665d58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TWpRQ0srVFJZeWVRZTVvQ2lyeFNLdGxCN0IzbnJMVW1VNFdFS2FNM2tIRnBn?=
 =?utf-8?B?SEltVm1MUVZUaDRONytjOXh3ZU5vVXFrL2FDUFN2UXBVSmF4SjJiWG4zMXZF?=
 =?utf-8?B?WDhjdEdEeGIwQjlsZzNhVGl0Wml3dUtCUW1jVmZMMDRKNlF0YUJPdGI4bk9C?=
 =?utf-8?B?dnZoOGxNVzE4TmNZaW9GK1JBNWZMZWxZNVVvV2dZV0hMaTUvZE00bHE2b3li?=
 =?utf-8?B?cDhuYTY0YjN4bTQ3aSs5MkFVTVRDWHdtVHhJNm9Ha21zckNFTmZUUkorQWR1?=
 =?utf-8?B?VHlJV21YUGQ4cE1IZGJRNzZsSzJvU3dzU2N3Umh2dWVXN1NHYUhTc3YrSGY0?=
 =?utf-8?B?Q05DV3IxaUZ3RzAvK0RyaGpoSGVaanErMFQrZ0pCcXFKQitUNVZka1FwQmc2?=
 =?utf-8?B?Y2FVUzg3SEx1N2pDaU5COVQwVmthV3o1VTFlMDA3ajMxT1pJQWRKak8vSnp5?=
 =?utf-8?B?dTd3bW1iMnBzUnBhSnJ5NXNnM2ZtQXhDbTFjSzl4TlgrTGxzVTEwVC9veFkv?=
 =?utf-8?B?OFVUNzhuYXVZOUhXQnlHOFJ2ZTFBSUg0Z3M5K2NxQ1Q5dUpVcDZERVArcGtB?=
 =?utf-8?B?cjdZRTRjUWZvSlRVVmpFUGVXeVRKY3M5UkNDcVhybjVraHpBY0lKOEZqSzJX?=
 =?utf-8?B?Q1hpc3pRaCs4My8zNVlsRnUzMGY3S3g5b1lDWlZiTUh0Vi9TWHc5d0kzOWhh?=
 =?utf-8?B?WXQwTEh5dVRRWkVkODRJNm11WS9YWjBBeXZlMDN6d0VwWVVSUmtVbXJmK1VH?=
 =?utf-8?B?ZVZPM2c4enpsb1NDQWhTYlZVV01WcXhXaDlPSXdJMDN5YVhhZE44TEVrVXps?=
 =?utf-8?B?cmpmLzc1aGdoaGNZQjZkK3VIN2ZGNThQcEhNTmRmYmF2OTJuN01Ca0pUM0Mx?=
 =?utf-8?B?OTVrQmFjNjV6RDBxRWE4UVNQMDBXMkR4YmhJR093RFFLa0xWMXIvNkFnT2Ra?=
 =?utf-8?B?cHlJcTN6aWZPTjdMV1hnL3FjbHVzNm55NFFlUVIzZHFLM3RRdUxNejlYQmdF?=
 =?utf-8?B?c1BvVHRqY1pFMmJERlRhdGVoN245K1ZFektub3U2S09zTHkyNHRFa0xqM3Fq?=
 =?utf-8?B?c1pFOENoT3pqVkxnWXA4Nm4wN3BWZDUxVmUxWXIwaFFrN29sOXBGTlJPbWE0?=
 =?utf-8?B?cTg5STB1U3RwVmJpdXk1eWowT2xGaE9acDFvOHg5ZmtYc1ZsRkFmdmN1N25I?=
 =?utf-8?B?UndqbDMyVzRWN3VkbnYrZEVJN1F1eFRHaGFJa3RWSDk3bS9jQi9PZEhyaGVL?=
 =?utf-8?B?UHlvTUdrcU5pNmlrc3BKcWNpTjBWNlM4S0h6d0FnWitOVkV1dWliSEpETWlZ?=
 =?utf-8?B?ZXVxMkFMVlZWdEw1K0pzS1RLc0NBWEZEK0kzYmkrQkNVTmgwRjY1V3pZZDV6?=
 =?utf-8?B?TktXbitjZTRudWYrcTB6ZXAvWEFHRTNGUnJvaEE1bG1qL3M2a2FGOFFjTmdk?=
 =?utf-8?B?TWliSTJsVmtPMG1ZTW9FRUluOUNMczVwK2JjR1NnRk5wUXZHSTB6elZLbHc3?=
 =?utf-8?B?YWZYb0hmM3FjRFJiTm1sTUp4cHFmQ2xpRkpnekZ5K1duM3o0Wll3VGp4MjNO?=
 =?utf-8?B?ZXd0Q1h2QXBlQnJBNm50V0JMNittWndoQkFkYzhhd1dsZ0RrTFJ1ZFpjN1Jv?=
 =?utf-8?B?SHZmRzdkK0dvdi8rZ2RVaUlKZGQvVEVjbU8wdGZsWGFNQTBrUlBKVXdGLys2?=
 =?utf-8?B?cmhMVm44TXk1QlZ1RDlrQldvZzhnajZWZER5dTlBaHp4MVFqODJxSXU4VlAv?=
 =?utf-8?B?YzBxdVkyckpFU1lmM2tpZDZjWUxYVjVCVDVwaHVFQkQvby8xcUJVejVNRmhV?=
 =?utf-8?B?bXB1M1pkWEtTalNGcE8zS3R0eE11N0ZtdDhTYng5b21Kcm1ueVRTeDEvOUFB?=
 =?utf-8?B?TWl3bzVKTFpuMW01TzYrRmFpVXFMRndkT2xzSGZNdm1wOXdGSSsveHYvaXV1?=
 =?utf-8?Q?Szzgurbf0zqR/a/jeGS0FuPlw5T3A64n?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WEZYTnRWQnJKcXNHZ0h0TS94aW1NaC9YeE8ycnJlUHMxSEFWVDRGYzZGNEQr?=
 =?utf-8?B?QXkydjROY1hjYlE4WTRTY3pDNFpJTkN2V013eTJYRS92N2ZUVVlFbkZYcVF3?=
 =?utf-8?B?WDJ2ZCtxeVFOd01FZS9Rd3AxWHN6K3J1aDVCVzdHRlhpSzdnZjYvckhCcFVm?=
 =?utf-8?B?YTZFVER0SlZFRStTTU1XMzlHODZBL2IxQm1BUWFSdzIxWTF6b2FOY1p6Ti9j?=
 =?utf-8?B?MkFuLzlpLy9BZE9uYThVQk9uQjRoT25XSVdSMzlkdHlGcytkY0N0WXB5REhs?=
 =?utf-8?B?TUdEM1pxZWJDL1hHYVRqeGU1YTRpUkhWOHVldExOU2lwTHM5aW1Ja3lBMytK?=
 =?utf-8?B?QXBHNS9JQWs0cW9BZWhCUXNJbUpXT0h6eFBEUGV2b0pHRmFEYWt1VkF4V2Zx?=
 =?utf-8?B?UHVPeTlmejI4eHpvbmQ4cEJkc3pnUVEyejU5b2JXZVdEeUR3VHB4QURHUzNm?=
 =?utf-8?B?VDNXanRHSjBpWUJ0dE52aVhabGI2MmhMN1h6S2xkZE5MRHlrWkxYT0ZTb1hk?=
 =?utf-8?B?aU5zVE9CWGxKK0FLSFhEQklsdGduaXRVK2twU3RTWGozU0RWcktxeksvVllK?=
 =?utf-8?B?MkFJeEhOZWdtK01vL2t6bjE0Nnh0aGwvK3dzYmpmT0lJek1rQXAyblV5aEpQ?=
 =?utf-8?B?SXFveUs2anVGL2NRU0ExRWQ5RDRNTG5kaC9yOTRsSWczd3JSNFFxQ1dacGFW?=
 =?utf-8?B?dU9sSDI0RHhzYmMvR0pKMU9wcU1CT0FYMUVUYzV2ZkoyajVpQk16OTZ3Y3NU?=
 =?utf-8?B?Njd2UTN5L2FJdmRqaGxQMzBrclRURlNZQ2RidEx3M3lCeW1RSVNxOHpNWWRt?=
 =?utf-8?B?cEFwamNScCtFN0NYWE55RXcvYmpUU0R5T05OT0l6UzA0YnczWndoNjVJa0Ja?=
 =?utf-8?B?eWd2aE8wYTdDT09Rb0VvcWwrYU5oc3FUS1I5L1hqMUdKdHlnRlJ1NnVYdk1l?=
 =?utf-8?B?RHRFZHNoVlR0Uk5pNWgxVnpjZWJQUWpncEplN2FEazNSYjhvbzNzZ2RhU3kw?=
 =?utf-8?B?dmlOZmRXUzhrMHpDZFREWXVkVkxmOFByaVg5TGlrRDdxVUhDMnZDUGFUY2ly?=
 =?utf-8?B?TTVsNkQvMmJrRWJYRDFST2VPUiszbVJ0TjZLWENxbFIzTmhDT200QjQvMUFS?=
 =?utf-8?B?UCszcUdGWE9MSW1KQlNmcUp0VzVkZ1ZQTTZFUVJHZHNFNW03VW84dXJGQ1Ar?=
 =?utf-8?B?RTJFVmtVUjgzNnEzWnAxeWFKZkI1QWNTaWhMTG91NE41RGNuK3VPTVZ0bXlq?=
 =?utf-8?B?ekVUcWpVR1ZlQ2tCRDJ3VFhyZnZIclFYd1hrWHJqSUE1UmtHT2U4Z2Y0NDUr?=
 =?utf-8?B?NnVQWUFLcFdrVXNYSFowK3BjR2VjUFFzb2ljWEE3dGRsZWNtNGt3QjBpckJ0?=
 =?utf-8?B?ays4ZmFSaEUwU296bEt0VWdkSEY3cGh4ZWZNUDNjRTF0cWpzVC8yam5xckRG?=
 =?utf-8?B?eThWNVJTU1BuQmVIVWdPRGV6eTlPV2F5aVVtZk10MVhzc056TmpIcTRUMmta?=
 =?utf-8?B?Ni8rQ2hqamJsS0hpSmd4Zld5WVlIQ2RpMCtBb2p4bmdCTHRsbFFGMDVqUnhJ?=
 =?utf-8?B?UGQ5VU1PVFlYbGFaZERiREZqSXVMbzZhUy9QT1E4b08vZDE1YzkvVmNNWlg5?=
 =?utf-8?B?UHdnWk9kV0twZm1KT2N4cFB2V0FvSU1qczl2M0Q3M3QxVS8yaENBa3RadWtG?=
 =?utf-8?B?RFZqcklPTitSamxsbHdKMmlZTG82elRQRU54R3pVR3o2cUpYcERaajRDRFFi?=
 =?utf-8?B?c1o3ZkxXcDRSM1JIWGVNakhYWituVHRrYytnVng1SDVNRGxSODNYcGJtN3Zt?=
 =?utf-8?B?UlJPdklzaHBFazl1V2NTQUtqWDZXazN3eG54RSt0YnZ6b3pqY3hoaHNwajRU?=
 =?utf-8?B?akdmTW9vUkRNYjc1WEo0ajBkc0Y1YUNmVmY4WGVuemxWMTU4NitEQmYxOU5O?=
 =?utf-8?B?LzcxMWI2bDZGanB5MzFYR0FBTU00UDU0bDNaOFZlcytzdGk1eE5EUXgzUVRI?=
 =?utf-8?B?eHJpZmhCdk5ySzIvaUlETWQwaHpNOGRjcVUyVEUvajRSNEJDZ0luWnpnaWpU?=
 =?utf-8?B?eExHNG8zQlo1VUV0ZVcyWHVCOC84SlZndjEyUU85ckZ3K2ZjSEtoL0t2Y29Z?=
 =?utf-8?B?emVBcDJ3S1VMenYwZmQ5N3RHbmRzMHVncndoWGM3Y1hTa1hBcWdQeWFTbE5T?=
 =?utf-8?B?cWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: yObmPBkq+ieGWYr7/ZacvAdWCGl5jLVR/7HYcZ1cGdHeW9E8yqh+Zgw/OB4be7LgXcb8/1d2nKcNDzUXrQQInMyL6Jlp+I3tFmNnlNRzdam3AChNX6m5bT1ZsMBqBjSH2DbYvEUNHJ7gwfg757WL71uz7xe4dm+RrFw1oXZ0JngcAsJf6CNwp3KN348y1UxY3Kh3w4HbnFwidRUHrv53Mt1g6xBiYybtoDlEFmvG+gw1v7n4SrR5BMTGPte5zrTs5QXG9suh2oGlq6/CjjJVLV1q6uBHktkp1Kh3/AraHTax18+xJnnMrMcf6jtCh9hIVbazOZ/tEaHLcAr4cmH2a46wBhyP8DejO+dFz8JraMJHv6R04a2JVikZg0r3FoFN4Cll+bVRCRgbPTKbT6t+H1LzGho3dmWYbbG65d6f7ivnUhjUb/FC4Uk3rgVBvi6W0O4nMWWoFpP0oNztCub6Hepas0lbZ/vlhKKXujjZFJZCpgEG8wRyIrmJuzz0VeKg0aLOHUtj1lXqQL/ITiOLq55BRxp4IQkZrt2RiYc/GjjUe/ZT+OVdVma95f+tdVuQeRB4lOs+1BnXwglP3rxTsKtG381RYucfsOHhh+F1U9I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4fe0540-dbf3-429c-67f4-08de00665d58
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 21:14:38.7519 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dbo3zejyj4dvxQ/nNba49OTdKx2wUKGm/qoEB9uweiYfUw0+z0sB0OnQbk1yZIgIeZNvAbBv53tlMwUH9vd8wdXQJi1+lZb2YvZ0bDX8Gos=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7356
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_04,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 bulkscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2509150000 definitions=main-2509300193
X-Proofpoint-GUID: nYof1TvQt6_AMN5AmuFoyXwZn4LjqSuk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTMwMDE2MSBTYWx0ZWRfX391klH6zDdSV
 NlDCRbea1DfbtlffYcVNkMbX6OLcaUyhcRPkLhVRgpPj6i7WKugHcZLFvpjP/tt4u6gLEcXoJ2b
 MdBg1zVdSBRxg0FlEd1lg0QE8aLU4cjWXwJwPfGJlRzyMTMQ0d/B7VhaUsGlxs5zn26UghAmbRS
 6QiiCMCkUQ8qYs1VTVlfSOvGAY7A7oy5BTLT1MahI/Wp34jcCi7+A2FQcvptKaWFHnNQ3MUF/7W
 4Xgc5QOlQJ6Qt2bPqxVb++MZfZzdPqGeLLAoH4pT5MJOojuVCOWjBLxfZQJto3VUajNo3bU2UL7
 E2RzyRDDWusBS/xDI7sZySuZgaDX7a7Tb5NxFDH6W9pRicZQdn3OH6GwFatME2xGVglKuSQXKjD
 jxJSUTuQ4OAJgUPh0vsTP70QC6+Osw==
X-Authority-Analysis: v=2.4 cv=RLW+3oi+ c=1 sm=1 tr=0 ts=68dc4843 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117
 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=xeX_Ua-Yu1fk1oDXwJAA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: nYof1TvQt6_AMN5AmuFoyXwZn4LjqSuk
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 9/30/2025 3:59 PM, Steven Sistare wrote:
> On 9/30/2025 3:51 PM, Fabiano Rosas wrote:
>> Steve Sistare <steven.sistare@oracle.com> writes:
>>
>>> Define the subroutine migrate_args to return the arguments that are
>>> used to exec the source or target qemu process.
>>>
>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>> ---
>>>   tests/qtest/migration/framework.h |  2 ++
>>>   tests/qtest/migration/framework.c | 64 ++++++++++++++++++++++++---------------
>>>   2 files changed, 41 insertions(+), 25 deletions(-)
>>>
>>> diff --git a/tests/qtest/migration/framework.h b/tests/qtest/migration/framework.h
>>> index 7ff3187..51a8a7e 100644
>>> --- a/tests/qtest/migration/framework.h
>>> +++ b/tests/qtest/migration/framework.h
>>> @@ -226,6 +226,8 @@ typedef struct {
>>>   void wait_for_serial(const char *side);
>>>   void migrate_prepare_for_dirty_mem(QTestState *from);
>>>   void migrate_wait_for_dirty_mem(QTestState *from, QTestState *to);
>>> +
>>> +void migrate_args(char **from, char **to, const char *uri, MigrateStart *args);
>>>   int migrate_start(QTestState **from, QTestState **to, const char *uri,
>>>                     MigrateStart *args);
>>>   void migrate_end(QTestState *from, QTestState *to, bool test_dest);
>>> diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
>>> index 8f9e359..2dfb1ee 100644
>>> --- a/tests/qtest/migration/framework.c
>>> +++ b/tests/qtest/migration/framework.c
>>> @@ -258,13 +258,12 @@ static char *test_shmem_path(void)
>>>       return g_strdup_printf("/dev/shm/qemu-%d", getpid());
>>>   }
>>> -int migrate_start(QTestState **from, QTestState **to, const char *uri,
>>> -                  MigrateStart *args)
>>> +void migrate_args(char **from, char **to, const char *uri, MigrateStart *args)
>>>   {
>>>       /* options for source and target */
>>>       g_autofree gchar *arch_opts = NULL;
>>> -    g_autofree gchar *cmd_source = NULL;
>>> -    g_autofree gchar *cmd_target = NULL;
>>> +    gchar *cmd_source = NULL;
>>> +    gchar *cmd_target = NULL;
>>>       const gchar *ignore_stderr;
>>>       g_autofree char *shmem_opts = NULL;
>>>       g_autofree char *shmem_path = NULL;
>>> @@ -273,23 +272,10 @@ int migrate_start(QTestState **from, QTestState **to, const char *uri,
>>>       const char *memory_size;
>>>       const char *machine_alias, *machine_opts = "";
>>>       g_autofree char *machine = NULL;
>>> -    const char *bootpath;
>>> -    g_autoptr(QList) capabilities = migrate_start_get_qmp_capabilities(args);
>>> +    const char *bootpath = bootfile_get();
>>>       g_autofree char *memory_backend = NULL;
>>>       const char *events;
>>> -    if (args->use_shmem) {
>>> -        if (!g_file_test("/dev/shm", G_FILE_TEST_IS_DIR)) {
>>> -            g_test_skip("/dev/shm is not supported");
>>> -            return -1;
>>> -        }
>>> -    }
>>> -
>>> -    dst_state = (QTestMigrationState) { };
>>> -    src_state = (QTestMigrationState) { };
>>> -    bootpath = bootfile_create(arch, tmpfs, args->suspend_me);
>>> -    src_state.suspend_me = args->suspend_me;
>>> -
>>>       if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
>>>           memory_size = "150M";
>>> @@ -365,7 +351,7 @@ int migrate_start(QTestState **from, QTestState **to, const char *uri,
>>>       if (!qtest_has_machine(machine_alias)) {
>>>           g_autofree char *msg = g_strdup_printf("machine %s not supported", machine_alias);
>>>           g_test_skip(msg);
>>> -        return -1;
>>> +        return;
>>
>> A common pitfall is that g_test_skip() doesn't actually ends the
>> test. The -1 needs to be propagated up, otherwise the test will proceed
>> with the unsupported machine.
> 
> Thanks.
> migrate_args() will return an error code.
> I'll send a V2 of this patch, 

Do you prefer I send a patch with just the fix, if you have already
pulled the patches into your tree?

- Steve

> and fix the call to migrate_args in patch
> "cpr-exec test".
> 
> - Steve
> 
>>
>>>       }
>>>       machine = resolve_machine_version(machine_alias, QEMU_ENV_SRC,
>>> @@ -386,12 +372,6 @@ int migrate_start(QTestState **from, QTestState **to, const char *uri,
>>>                                    shmem_opts ? shmem_opts : "",
>>>                                    args->opts_source ? args->opts_source : "",
>>>                                    ignore_stderr);
>>> -    if (!args->only_target) {
>>> -        *from = qtest_init_ext(QEMU_ENV_SRC, cmd_source, capabilities, true);
>>> -        qtest_qmp_set_event_callback(*from,
>>> -                                     migrate_watch_for_events,
>>> -                                     &src_state);
>>> -    }
>>>       /*
>>>        * If the monitor connection is deferred, enable events on the command line
>>> @@ -415,6 +395,39 @@ int migrate_start(QTestState **from, QTestState **to, const char *uri,
>>>                                    shmem_opts ? shmem_opts : "",
>>>                                    args->opts_target ? args->opts_target : "",
>>>                                    ignore_stderr);
>>> +
>>> +    *from = cmd_source;
>>> +    *to = cmd_target;
>>> +}
>>> +
>>> +int migrate_start(QTestState **from, QTestState **to, const char *uri,
>>> +                  MigrateStart *args)
>>> +{
>>> +    g_autofree gchar *cmd_source = NULL;
>>> +    g_autofree gchar *cmd_target = NULL;
>>> +    g_autoptr(QList) capabilities = migrate_start_get_qmp_capabilities(args);
>>> +
>>> +    if (args->use_shmem) {
>>> +        if (!g_file_test("/dev/shm", G_FILE_TEST_IS_DIR)) {
>>> +            g_test_skip("/dev/shm is not supported");
>>> +            return -1;
>>> +        }
>>> +    }
>>> +
>>> +    dst_state = (QTestMigrationState) { };
>>> +    src_state = (QTestMigrationState) { };
>>> +    bootfile_create(qtest_get_arch(), tmpfs, args->suspend_me);
>>> +    src_state.suspend_me = args->suspend_me;
>>> +
>>> +    migrate_args(&cmd_source, &cmd_target, uri, args);
>>> +
>>> +    if (!args->only_target) {
>>> +        *from = qtest_init_ext(QEMU_ENV_SRC, cmd_source, capabilities, true);
>>> +        qtest_qmp_set_event_callback(*from,
>>> +                                     migrate_watch_for_events,
>>> +                                     &src_state);
>>> +    }
>>> +
>>>       if (!args->only_source) {
>>>           *to = qtest_init_ext(QEMU_ENV_DST, cmd_target, capabilities,
>>>                                !args->defer_target_connect);
>>> @@ -428,6 +441,7 @@ int migrate_start(QTestState **from, QTestState **to, const char *uri,
>>>        * It's valid because QEMU has already opened this file
>>>        */
>>>       if (args->use_shmem) {
>>> +        g_autofree char *shmem_path = test_shmem_path();
>>>           unlink(shmem_path);
>>>       }
> 


