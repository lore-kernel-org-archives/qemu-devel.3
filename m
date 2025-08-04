Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 366A2C87FCF
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 18:44:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uj0AW-0007bM-N6; Mon, 04 Aug 2025 14:44:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uiyiX-0004WI-Py
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 13:11:22 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uiyiV-0001SS-9y
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 13:11:21 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 574D7QNk015845;
 Mon, 4 Aug 2025 17:11:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=umvZzV5T/Mpd6vkhYA6T+YCERsrWXwRq1UluUynAXRw=; b=
 KcT6ZqtMB5ihD+n4G7Z9sPdNwjc4U2ZEzpJoKl42UkB8S5qEka22qhr5Cu681hEX
 tpXsanKMG7GatVWqUTTtIrCcZ+FhQVm/qm0SpVC/y38RpskGvjoHF8HJpOWfCShK
 GshRyI8sAppOYC2keVX2wZmMtx4Y3ZC0sceJBom1viwX50DsIOhv39q5JadpCRkv
 Pi6yGk7/cDQ+2p7Z+PvCRE6Tsmak2n4/SO3r0pbdkN9YEhi1oaL5CzTdP/1ytKSj
 LHjpGIMWYuX8whcvIFY8qL33XiFp3EOpmtI8sr7KxQ2v5o20Nho28/e8SMVzo8ie
 EmmpdVVgdDGrX65Jie+ZMA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 489994k4gx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 04 Aug 2025 17:11:15 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 574Fl1do025548; Mon, 4 Aug 2025 17:11:12 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 48a7jspd46-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 04 Aug 2025 17:11:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DX2YFeVVivfGjv07Fm8FNn15LlTPFm/ar2FJqcE/R2T3w9Z0CLsj9n5XMy8ej3dbXByFXfn1XhAaKUzdlOv4BPBwTFCJPlEv6ppYU4Xx/4WIuAd7qt7Ro8mXm4m9xy7YizNrOR+dMA3UUFpR9zOvsHxppcUaZ5rgepkdye57i3i9b5zch3g8xHrjVQXCMlz6OWl1vPzt5FMcsncrnJsAXYl7nxg/ckt2PPo5IsKV4fsyApouY97dPbhfzGgwisJSQfGP9gQsC5aHyVzDK7S/dfsnPNt/j+H4qx6Mbd1sYAqmHduCCfSKtrs4yNWBy1P5dqNrvxn5iqQXFkKkuInX7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=umvZzV5T/Mpd6vkhYA6T+YCERsrWXwRq1UluUynAXRw=;
 b=t27bsUg3fGTuNiQhWM8hoYRr/j1l8po9998bjsVb+Y/+IGIYMfkPII4hQGdARgpGwHPPo46auNJWKmKaJg7Waplx5gr1+T7Dx4nVTZaeP+/KoeokCpyxtXGrOtMP5R7QJSxec+31jHS+i197XOAnWz1NymEb5+u9pgV9IslHyVYgZ/8YXCyh5M500lYRP8BGrEQAF3UboBUZyHMgDsn1VXAydxxkwp/1PByWrZjoPiJtKUlOjauq5NN2sQgpHv2ODrdlQvqWXEBEJ+trsPqgw9dGFLRd/Nu/nKdl4blEp+FabOh7ab3fQlapHpupLogHlKUVauhNLWzAL2RwZTgy0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=umvZzV5T/Mpd6vkhYA6T+YCERsrWXwRq1UluUynAXRw=;
 b=zedcrmD60pTHM5j8EOTVxHyGY4p6ScJUYrPXB3Iqns54au2R+1fVBlaLTzt/6LHIV1CGTCJeAJozHRufU+tirXnANaxk2AUTbXmS1TwMHEALyJrOX4hsW61IMmlIo6kavD8Cz0/A7fQtDKVsZAR1zV2FgYKHMkvU3n4AiS9VwuU=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by PH0PR10MB5578.namprd10.prod.outlook.com (2603:10b6:510:f1::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.16; Mon, 4 Aug
 2025 17:11:09 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 17:11:09 +0000
Message-ID: <a7a3ba56-680a-4256-b6e1-ff78f131fdf0@oracle.com>
Date: Mon, 4 Aug 2025 13:11:04 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] qtest/qom-test: Plug memory leak with -p
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net
References: <20250725135034.2280477-1-armbru@redhat.com>
 <20250725135034.2280477-2-armbru@redhat.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <20250725135034.2280477-2-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0023.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::28) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|PH0PR10MB5578:EE_
X-MS-Office365-Filtering-Correlation-Id: 194f5012-981b-40c3-9180-08ddd379e7cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ekZTODJDOEt2aGhOTllST2NCVkk4WWRmcHQ4N0ZrQ1BkdDErU1FLaEt5QUZz?=
 =?utf-8?B?U3BwSFpmL0hpK3JTU3h4dXEvbW0vZGJMb2hhTG1UWjJlVlZzOTZuWG5mZXEy?=
 =?utf-8?B?cUkvTkd0eFdBOHo5RGZTT20raGtyR3VLYWxvcXRSdlRjd2o2OEhlRUxMNUN5?=
 =?utf-8?B?V05NbncxcnZZbG9CVHFVSTBVMm13ZjVpN0ZrQmFwWnd3MmFYMzlHYWc3bk9R?=
 =?utf-8?B?bDhtU1dqejBYeExGbElJRndMS1VRelNaQnJQWDJ4OUVUaXRYbldZbm8rWFVH?=
 =?utf-8?B?VlpCQ0V2QXF0b2JkNE9OUGdFdnlBQjg4dEFJSi82emJCOENoY1FsWTJiVHBI?=
 =?utf-8?B?RklGUFlNblZoc21xb0hqUnNjL0MzWG1RK0YxaVFnV1RLZFJSSFVhZ2FaMFBq?=
 =?utf-8?B?YlFMMzgvQzJDUDZhU09jbVBIb1lSaWZBSjdxVjJIK0RNRXFLVlM4UlZxMXpO?=
 =?utf-8?B?OUNjR0sxWHkwdTFsTXJXM2NVdWhIeGpFWTFnRmwrTkMwcEJvS2R1MzRCS2Rx?=
 =?utf-8?B?UkliVHFHdjJIanBFWUlsOWRZUyszemkzU0t0emdyenZ2YWR5TmFzRi82NUJY?=
 =?utf-8?B?djFCY2k4eG1ablJrdWJlZWlBcjBSVDgxdm9rSEJoK1g5TWVHTGFXTVNPdlFP?=
 =?utf-8?B?WTZyZDVOYXlPM0xJSG1XVG1KeVJJNE5TamJOZzNtdVVrMDhIajNYWFhqd2Fa?=
 =?utf-8?B?QU45dGpHY1FrR1VIV1N3K3J6VHA2N0FYdndTcFVrQ1A1OG5OSGVKamlLWXRs?=
 =?utf-8?B?RmRsT1hqbTdhalVEUTNQZU9SM01YbXNiTld4UTRvdjRhSGcwRGtYTTZ1SHov?=
 =?utf-8?B?Z3hZaU4zV2pmdUJEQUpMbG5NVHJUMVRYY1ZNUTYvUWFCV0FJNktMcFNaRzM4?=
 =?utf-8?B?VFJqYSs2VE1oMm5OQ1hUamY2NStBYlBoT3ptNGNzVUJpbnQvZUZJT256UnlM?=
 =?utf-8?B?RmVkNWNjWnhDYk5JVm40OWhjSFJJZXVlYVhBdkpBaVJiV2crcjhpallZMzR5?=
 =?utf-8?B?Q1h2QWIyK2F6Ym5GQVNzck5Henc1dnJrNDlaNEZESDJGMUUxRjcwYm5SanVv?=
 =?utf-8?B?ek11ZWlUVmxqTDUyWmN0QzNwWndDV0greHAwM283eFFkcXRBSXlFSFNsVmNa?=
 =?utf-8?B?eVRIem5BRkJ1NUpZUGVDQkNsa0h0WHgrRUZ6UGZyUzZpWkxaZXppbWtGQ2ZE?=
 =?utf-8?B?emo5VjR0OE9nWG5Wb005Yi9xZzByWmRGeFZ6Z2dVZkYwVkZ2Zk43WjdzZnFS?=
 =?utf-8?B?UDBqQ1I3eWVhSC8xR1liejBnOENpNW8vQ0x4YVVneUpxV3k1a3dGQjhLOXN0?=
 =?utf-8?B?MFFKN1VsbEgvRStjQXhQMGZuY200WG9haXgrTUtZZ2diSzhqTlJnNWgybFo4?=
 =?utf-8?B?YzczenFoKzFDNEFOeHdBSXZuNFc0NVZKRnNNQUNkOWJMSzFXSmkyR0UvSWgy?=
 =?utf-8?B?NEZqL2JuWVJ3THF6NHJDei8wY0xyUVZLTVdTQXZCSTlLbDhzNmNWMWRDOERZ?=
 =?utf-8?B?WkhIOGo3TWduSkp0MTljU29abEpvNFdjelAxdVFtMzhsOGtrRDdTeW1oMGhH?=
 =?utf-8?B?UE00QkptTVEzM2MzNTQ4V1FwVENnTmFqUDltYVdHSlRreFZNcDlDVFU0dW1z?=
 =?utf-8?B?TUowUFZjbEt3MzRsK1RvSjdzdmw3eFZoUUpOYXlFZDZJeUJJUUZEOGlsVzdy?=
 =?utf-8?B?aXd3Q1lFM0tuZmZLRjcrdHBRNkd2T2VST05pWEc4ZXR2RmxJK3M5R3laOEk0?=
 =?utf-8?B?bXMvTXMxdktWUngxTXlTWGI1SHl6V1k5a1JCWnhXbDdzRUxNZVBHdzB2bm96?=
 =?utf-8?B?UjJQMWVuRkVQS1dQUmVKWXZId2Z2QWg0aWFYZ3RFMkdSTVFOc3d5QVFVUGNZ?=
 =?utf-8?B?SXZYZzQwTnVqd0VZVUdvMWUxSEo0YzFKdDJpSm1udnlaY2RZY05XU2dZMDhK?=
 =?utf-8?Q?9G94yXgMK0s=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVZGSmNQbnVnbnRGeGlibHNJQmhqL2pBd2JXdHdaRkRhdXgyOFVEZk5UZndZ?=
 =?utf-8?B?OVNNcmNIeFA3MEJ6ZWs1Z2o3dU9DYmsrVVcrZjZhU052a1Q5ZGpmYWZDT08w?=
 =?utf-8?B?ZVVZendsa2h6TWZLYk4wdmpNeDJ0akdERTltU2FMNjVrOEw4dlNpOHNFNnFY?=
 =?utf-8?B?VDR1YkFIdFpUdW9hQ1RyM0FlOWZkZXV4SDFCTHBxYm5SVHhQaHY5VHcxQWVM?=
 =?utf-8?B?SmJtZFE0WEZublZ1WjJvOWZ0VTdLeU10dXlPTnkvZG9nZzZac2FCNW5xK2U4?=
 =?utf-8?B?eHhqMS9TTitPY2tXakIrblQzOXBxWC94RlZEME9kcnhXU2doclJnMWhjOFZ6?=
 =?utf-8?B?dWpzb3dGcDhRTUFVWEZVRTQ2OGcyZUQ4S21MRnkrdUgrSStEcTMxS1dab3lQ?=
 =?utf-8?B?RldJNWcvQXBKQisrMjZQcGNVb1ltN1BQbXM5OElKUlZCNHhaSVQwVzJYV2o5?=
 =?utf-8?B?WVpTMlZLTER6S0VuQi9NbVFVaStTUFVVK0RtNWdpM2dBTmQvNkdtVWRIbEpE?=
 =?utf-8?B?bjd3Mi9GUDRpLzhlQkRVbkdKaFdSd2xQY29XbFliaFhWM3RBK0VBQUJWK1RW?=
 =?utf-8?B?aHhmdWJhb2J2MFhqWUNxc3ArZHlmN3V4czdxdnRMeU9EcXIvQnlPMWFpMDI1?=
 =?utf-8?B?NFUyTE91dmUrdTJNMnRLWm1LdEh0QkU5eDJ4QzJ0N1VmcDVMTWdqYXNWQUtF?=
 =?utf-8?B?K1BSTmtjUFViaUFqNXhHWHBpTXdzV29ZdkRrTkdDUzVWbGdsWkRDMElTbDBY?=
 =?utf-8?B?V1pReVhBbUtmaDhmeStQenVTUU5DT21yS2N1SElGVEhCSGM3c2dtS3pkRmV4?=
 =?utf-8?B?VkdKYnJQcllWMm8yVWRiUk9TMFFnZ3lBYy8rYTNPaE8vTkhBRXlRNk1Zd3FP?=
 =?utf-8?B?VjB4d2xhL042OGxISzlzYWNDa1F6aVh6UmdHenBvb3hOM1pwZnQ4Y2NsbEsy?=
 =?utf-8?B?bW9Rajd4OE9uSGRqVXVrL0pDOVllWmpzbG9ab2JLNUZVMnJ1RUhkN21iaXZ5?=
 =?utf-8?B?SVdvR3BDdURnN2ROalJUZkpvTWM4K08xWGdodW1WaE05aDRTYW1pcmdXWkY2?=
 =?utf-8?B?ZVZSSkVnYU93Z255SlVwZXJkYi90UnVOMXI0SVpxVVBMUXpsU3VVMmgyKzla?=
 =?utf-8?B?akZPQ1Y3WDgwcG5Sb2h4OTRveXE3UldDY1FyWDZyMlBWVkJ4VFFUSmpTNHpt?=
 =?utf-8?B?WW9Wbk9HcXJZa2ltTUpZcVhaOGtMZXdPYzUvcU1FcFhSWll6TmV1SU40TDhS?=
 =?utf-8?B?MzR1eUtUTGVxbk9waUNLTzg0Vy9BZjBMQ002S3FUdCsxbTI5VTZPVlFlR0Ji?=
 =?utf-8?B?ZEJkNFNKcnFlWlQ5SWZ5Q205YlQxWCtXTFhDYnBiYlZsNXJwcThlOTZuTXlS?=
 =?utf-8?B?N2tiUndQeGVJejk5T2phMnI0dTN3NUdBdEFSVU5oWW02UmtQaTAwNnhJdk9i?=
 =?utf-8?B?MGwwaUIrZ1dOcGhwNmpLbHZSTmIwYXB3dkQvWDdOK2s4bUFGa0VEUGtTek84?=
 =?utf-8?B?L1lWbWltUnhKUFdUK2xSOENrL0M2L3JuY1lkRno1WGxVMXM3MVNsM0NGMXdL?=
 =?utf-8?B?dWx5a0lhRmw0bFoxNlNmeEpRQUk4TS9Rc2FMaVRpejJWMkdIcGFIRXhZTkcz?=
 =?utf-8?B?SkFMeS81NnRnM3FTTkxsVnJHVzdLSWFmYUhlcGFjR2hZMFJXYVVmclVPU1Qy?=
 =?utf-8?B?YjF1NVlkSFlOY3VaTDZ6b3VwcFYxenlPVUpoOXZCbjgrUnJxa24yZTQyVzFr?=
 =?utf-8?B?d1VYTVE3S0EwcGtqY0dFdXI5clBIeEM1eDFtbEgxdE9XUHhrc2RzTDVtZGFv?=
 =?utf-8?B?SlhaLzVpRVBkWHRsc1NPNitxOXlPYU0rM2g5RE9lWkg0L1g4TzlLaVltbDNS?=
 =?utf-8?B?RCtJV1V5VlNwQkFRV2FiSktxcldjWXVUWmM5Mld5bXBwOXNLcStFTTFlSEI1?=
 =?utf-8?B?SGpaVmJmMkNJWi8zSjNGdTNsUHVsNENJWEFMaXRMU3IvR2hxZW9Sa2x4bUZh?=
 =?utf-8?B?ZUxYdkppMUJ2eW5SbVJLc1BPK1pFeGtYZVBLbHlYNkhkdGRjREM0aDRLYWdS?=
 =?utf-8?B?ZTFuUUlseVltYlA2dXVxWmI2QUZ1eWw0Z3VCN2p2TVBvS0hKYzJSYWMrY2dp?=
 =?utf-8?B?Q091ZzdyS1NaUlNLWmNLMDBMakM2dFpZNkMzdlh0OHlsRVIyRWV3RnJrVzg4?=
 =?utf-8?B?WGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ARnS1fLZGGCrKnptIM9RDhY3MxjsSupImDInLJcQQed3p+IGVHJhSJfsFnLKPxRUHXJIwVBAlTkvI4RDEZMyEfPJK91FT8QaDrY01TPgAfoxc4aUJ3UVBE2Yj1DNF59HIAUb5aT08vIjJDWYoJ06pEg3t7gvGfGQ110/OUJX5FOZXjmAj+o4GriY1XgFK588M8DcV3PlCdnU7T7ipgePbF/YJ+gto0jvRq/WKy7+Sh+K/v35ySLmnhyeXiZUU/DJjxJmqcw+FOFStdWQbHxD9GKkBu0Yw77PXOTEB896/y4lWxmnTp3ZvirQc0qN2oaKflSPlhzKEzCy9GyDCP0u79xV2IuHtTmyCn+5pvn4nP05jOgkY4o9aHpYEvBjeuOzOuONi6a9MSdTWNQ+T6zUlL8E6sPAsXCtbGQckmqBWTW373hx8s8qqTgGGbluUYzkPk+LAsgqw7p4mpkQgtXoPQRdWrPoiUIlluHlLh4S29F5DDNfvDmQR4Ve7ztkZJoNjI1Xj6xYD4Dh/NjRmqqj7sp0aC32Y6+47ze+qNrweDt4DCUk3L2OZyJd8cC8zlT1326ODcSKJMb51/9C2W1F7WbdA/3N43JHDclskg93EXE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 194f5012-981b-40c3-9180-08ddd379e7cf
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 17:11:09.2078 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dK/DKhryJegMuCQJmWq/ooPY6mio/WptdN8e5DCRSGo9eY9Z/yiz8J5dtTPnVfstm3f+/Ie2AazmJ2+K6UOqVRLDuT/F+JfIULE9TXG2GQU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5578
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-04_07,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=0 mlxscore=0
 phishscore=0 mlxlogscore=999 malwarescore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2508040096
X-Proofpoint-ORIG-GUID: t3Rz0y9th763OnAmnE7RaeOwgNeQZU4Y
X-Authority-Analysis: v=2.4 cv=HY4UTjE8 c=1 sm=1 tr=0 ts=6890e9b3 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=20KFwNOVAAAA:8 a=gHQfgHl9_j3LcBHVHVEA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDA5NyBTYWx0ZWRfXwHkd/NC1E2nq
 K2P+X3lsZrkKbZEaPlzBHNv1DuIYswBYMnu65y5qUIhf/loURaTi61UIQVcSTu0rHThQDvXLmge
 xP7ntQLcEs5Upl82PU0zMkZopX15DXu4PgIZ1WHFQoFZ8oCLF+4NwHboDOAcL2/fdtdIOZl4OAT
 37szhoA7FCcWGOmMXI4K/QyaWiF/hSRpa+jpGWw0H6hzReOIimxGoK0LTvR7ws7X4qYUwULLdGh
 KD0pkzPerh+1vtV5tjXwt9EcLM4/Bn31f4kQP0A8UwgTPEaJBWyGo+6OnS7MG7fKqap6yL+mNYU
 hyTx/pIdpr40jHU3RDy9iTERLU5Q5sBchLbD8GXCJIwxrcvFhSi1d1qjSKGEsMk5ur+M+r3mRJh
 iDNdIkv/nQYZ1eODSY7IZ2ILv9K6IAhGf5g9EhMKkar2hpWZGSkJFlxlTnRtbq1BEXlE8Med
X-Proofpoint-GUID: t3Rz0y9th763OnAmnE7RaeOwgNeQZU4Y
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
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

On 7/25/2025 9:50 AM, Markus Armbruster wrote:
> The machine name g_strdup()ed by add_machine_test_case() is freed by
> test_machine().  Since the former runs for all machines, whereas the
> latter runs only for the selected test case's machines, this leaks the
> names of machines not selected, if any.  Harmless, but fix it anyway:
> there is no need to dup in the first place, so don't.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   tests/qtest/qom-test.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/tests/qtest/qom-test.c b/tests/qtest/qom-test.c
> index 4ade1c728c..cb5dbfe329 100644
> --- a/tests/qtest/qom-test.c
> +++ b/tests/qtest/qom-test.c
> @@ -220,7 +220,6 @@ static void test_machine(gconstpointer data)
>       qobject_unref(response);
>   
>       qtest_quit(qts);
> -    g_free((void *)machine);
>   }
>   
>   static void add_machine_test_case(const char *mname)
> @@ -228,7 +227,7 @@ static void add_machine_test_case(const char *mname)
>       char *path;
>   
>       path = g_strdup_printf("qom/%s", mname);
> -    qtest_add_data_func(path, g_strdup(mname), test_machine);
> +    qtest_add_data_func(path, mname, test_machine);
>       g_free(path);
>   }

This will break if qtest_cb_for_every_machine ever composes a machine name on the
stack and passes that to add_machine_test_case.  Unlikely, but the strdup makes it
future proof.

Also, mname is not the only leak.  path is also leaked when only a subset of
tests are run:

   qtest_add_data_func(path, ...)
     gchar *path = g_strdup_printf(...)
     g_test_add_data_func(path, ...)

Leaking seems to be par for this course.  Maybe not worth fixing.

- Steve


