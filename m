Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEC2DC3ABDD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 15:52:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uH2mh-00061B-AW; Mon, 19 May 2025 11:52:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uH2md-00060z-FZ
 for qemu-devel@nongnu.org; Mon, 19 May 2025 11:52:07 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uH2ma-0000UT-Ey
 for qemu-devel@nongnu.org; Mon, 19 May 2025 11:52:06 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54JEgxtD002138;
 Mon, 19 May 2025 15:51:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=6R8DCYwW9Y2khruHjSqq4OHjQoytl7Lb9Z9GJgKXBxg=; b=
 kx79vAkfV68u32XQ6XEsr2PlBCDYvXMx74v9lhaHrzI/IuHlrn4FB/hifC0mDFNZ
 DRvgl6PHUDW+I5MFLTA/pX6B7xC0N4LhE/X/ddU43ZiWLV/rP2dLmQWQJT4cHY+N
 xqIsoJQHCKwVNSq1AL9ka/aMzK7l5HKDj+JE9FR/MHhjEp4HJH3NrlU0RAKlJAX4
 8HU7yrGfMqsRAVe4wYSk82RUaNrWYil1yFtTxFdWk/VJqLyrCqbMB3yfJwGWynn5
 6YX0hKDuF2jt6QEVtrKd4f0UcRZQVEDsimZXyht0QzjcmjGK18P8O21NB/kJmClg
 80UEoJNgDv6AEMdfXLRscg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46pjbcuapf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 19 May 2025 15:51:59 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54JFBRsp000817; Mon, 19 May 2025 15:51:58 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 46pgw6vv1x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 19 May 2025 15:51:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u6uFsV/tcd0vJM3imqoTU/+qYL0H+8+oBiWYLdkHEd/STsB3STXnxu+5676GiQwccmX9kFfhS2hKpwRPbZ4gSYWBThg260ME2lFLUeKDQp5Bw7vksvFWOgGLUy/km8HMSmHRxRnsWbufQ8yjM4R/10K9BmAzNFQHuYPY4GP/iBUaic94SRwm/o5kI7/JiVODH/9V6KauwkI/TLX4mhhwnjV8UNr67/pK0VLTV3RyB3ZQPySvfQnqwRq4SwH8R1pFg2PpdjJchUYpeUhF63k7Coa2XGjfy2GQGWz96eHIm6gyDq/zMjpVcIG4JDw2MmrT7xJ7rzj4TV/W1qs9YgGAvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6R8DCYwW9Y2khruHjSqq4OHjQoytl7Lb9Z9GJgKXBxg=;
 b=vlOtC6SODq5l8xebiQkEoN9DdsfiVJEciUY8Wa5L4voTZACHK3UwWJT7CONaKDGrw/Db4PoaSNTUefbN8fjuJ6XHLUoPUZkGmRXNCC9Vho8kiLsUfFQkwhXlakHPvK+WvkyVQGbjWsM0X/c9xQrFblxtgjQkbR5uVvQ1hf3lIVBTrwfBRn9dzLiQQ2jKTQ0fkGi7QsWvU1c1J+1wO1BbUD6IvmCCOVUhNWxpkpsupajkmQbyZ+eaqiqycGlUSc9uAVSgQK7y9Nx5LwVzeYrr9vt+NNNUr2HB5/7v5ym1vJE3tUwF1Otdu5N+Aakdf7U1/B4RnRkV5+Nb6WTH9utYbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6R8DCYwW9Y2khruHjSqq4OHjQoytl7Lb9Z9GJgKXBxg=;
 b=N7WlSEwuNgPoj2sjIi48/CbOY2+tjOnNdS7/thlRG5JG5SkkG2GOczcW+ikdd46eQCoS7L8h1TTxrlbpsJkBP04QiOSbDJXoiU3rryrQXobXWB0HeNdQc0DrPfby5jkK8St7SRPpsHaUfisiyvILAv9S/oJy0LNKXlJQP/DHlP0=
Received: from CH3PR10MB7436.namprd10.prod.outlook.com (2603:10b6:610:158::7)
 by PH7PR10MB5816.namprd10.prod.outlook.com (2603:10b6:510:127::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Mon, 19 May
 2025 15:51:56 +0000
Received: from CH3PR10MB7436.namprd10.prod.outlook.com
 ([fe80::dfba:d89:d13d:cd54]) by CH3PR10MB7436.namprd10.prod.outlook.com
 ([fe80::dfba:d89:d13d:cd54%5]) with mapi id 15.20.8746.030; Mon, 19 May 2025
 15:51:56 +0000
Message-ID: <7aa3c76f-a171-47b1-a56b-5fa16e38f4a5@oracle.com>
Date: Mon, 19 May 2025 11:51:53 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 29/42] backends/iommufd: change process ioctl
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
 <1747063973-124548-30-git-send-email-steven.sistare@oracle.com>
 <SJ0PR11MB6744C9B04AE39DE76904CAEE9293A@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <SJ0PR11MB6744C9B04AE39DE76904CAEE9293A@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN0P222CA0007.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:531::15) To CH3PR10MB7436.namprd10.prod.outlook.com
 (2603:10b6:610:158::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7436:EE_|PH7PR10MB5816:EE_
X-MS-Office365-Filtering-Correlation-Id: bf2ddaae-5f14-4583-ed5e-08dd96ed14f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q1BwQUR1L21ZM1EwaDJhd25nTWVKUG14WWJLOUZUaisrZktTaEdQNTRMQ0xO?=
 =?utf-8?B?OHc4bnU5ZGFnZklwa01TMWU4ZTlKT0I1UmM1ZzV2T2lNOFRNWmdOeHJxNlc4?=
 =?utf-8?B?eWlScTQ3dDIyUGxGeWJwdE5CYWRaeWNFaFphRGNWZTN4WWZSbWNCZnZ3M2Fx?=
 =?utf-8?B?NTUzbms1WEg5blNsaVBVd1VnaXo4VnpFT2J4Y0dOSjZkc3VKemdCeEdNUFBW?=
 =?utf-8?B?THdsL0ZVR2hIZVdrcTY2RHZGaWo5WDI0Mnp1R2IxeU40dzZLdFFPQ2NzT0Uw?=
 =?utf-8?B?UDF0QkthTVVFbXNzdnUvWitMcmxhU0V4Z0E4UFRMSkIrWHg0b3ZxN1Bpbk9m?=
 =?utf-8?B?NzBINjVuR3pUTU8vYmtBWDcrYktUcFFpSHFSNnVoV3VVbGp4UXF3UGRRMTZN?=
 =?utf-8?B?YzdGVmpjcGVsU2w0NGZLMzcrK0RQNXFuWnhEdE1Oa3llcTlkcUZIcm9oa2ta?=
 =?utf-8?B?bEt3S0RWTDJXVlFPM2JEY0dmckw0UVkwV0VWYnpnMmdxMEl2T2hRNERHTkRV?=
 =?utf-8?B?VlRkdWJscnFUaTRjMWdxQUE1NDVDdFJVQTdDeFNZSUJFRFlMaHhHdTZFdXdw?=
 =?utf-8?B?NllyWTBROFU4bHBWYkxCRVZQdjBBdGx6Z0hUckZic0J5WUZ0dkQwMVBXUms4?=
 =?utf-8?B?Sk1RTWRjaUY3dW9zVk1MTmpnRkMvSlQwVUFSTkZ2ejJ3VFJiY3hEMWZGOEJB?=
 =?utf-8?B?MElKQWF6TTRKU00zMktURkVqR3l6Z1E5VE9iTGRka25LTkx2SGkxd2t2blhX?=
 =?utf-8?B?RW5ha0NxQUl2dVU5bnE3WW1oK21xd2JoWGJXUW5vQk1qOTB1K3k1ejUxQlBs?=
 =?utf-8?B?VHA1MnFCOHdRSHViZVNjSm5OanltbEhNcDd0R3NsQlV3NFZTZnpsbE9aQ01Q?=
 =?utf-8?B?elI2d0FqK1NzN2lsODVQbGRlcldLdHVSNjRWdnNhQWVZL1hYRWxqQWorcVU4?=
 =?utf-8?B?VGxZcG91NW5BV2M2OEQxZDFkMTUrQ01KWm9VTmxMT0NEU0tiRmtmQTlDVlg1?=
 =?utf-8?B?YkZaMFMrbVFya1dnUkNBWHBtdEh6TmlSb0VPN0pydkJKcDZIajJGWldUSGhL?=
 =?utf-8?B?djFoeE5zSXM5amNCc0xmM3h0bkxmSnJmWE42bnROOHd6Y3daUUEvRXBFSlIx?=
 =?utf-8?B?bzBDNHRWQVorR0ZmcVYvM01ULzI0bUJYRDJ2MXAycmJ3V0ZMdzc1d05GbEIz?=
 =?utf-8?B?Q09UVVdIMm1uSmg2ZzBVMGRZOENKSjJrVUVVNkpiTGhaYUUyME8vVHhWa0xp?=
 =?utf-8?B?cnBBbUFQSW9oZ1R0QnFXcllFZy9qVDN0eWtEMkxZaFdDV0o3dE15Zk55end2?=
 =?utf-8?B?MWtrZUlFTzBteDV4cWlJK3MxbUhoNk1wYTR5S0IzdzVVbi9MY3ptaWlYazJ2?=
 =?utf-8?B?SnZvVDBtNWgrVDVXelBIMVdOZWUzN3ZiY3hxQk5zeWlzVTU4SWVPZ3RxQkcw?=
 =?utf-8?B?bVYwYmp0WlNvZllvRjhJWnpXTGl1WVZ6SlhqcDFJRUdidk9WcmRpSHhxY1cx?=
 =?utf-8?B?MkhpU0RzQTU3N3A0MTl2ZEZ4MFRFSThHMGYwRG5kQjgrRHBZK3dhZ05ZOHhk?=
 =?utf-8?B?RzJibHpYaUtKMnliRmVJVjN1UFhXL1orNU9jbWF1T3ZFZEUrWHIyMklSMk11?=
 =?utf-8?B?RVBxOTdSMlZwOXVwM001d0ZBNUo0ZmN1b3hQRVIwUE10a2JMM2ZMbTg3U3N4?=
 =?utf-8?B?dzFtZURpMVBRblpQd1BMUyt3NnBjU3R0KzJJQkQyWEkvV1JFdFZSN0hKbVdT?=
 =?utf-8?B?Nm5GVEJ4YThrdDF4UW1sQ081NTh3OUF3OHYyZVFCZ25MeWc2VmkxMDNUU3F5?=
 =?utf-8?B?RFJNZmhJdC94cU5MakVnVHdnWHJaN0YvMnRRd3VUWnArSU82TERlenRYQi8v?=
 =?utf-8?B?Qk9Kd0wweGMwNU5hVENnRlhIdlNGZHpLbUNMbjhIY3FHejk5TmFHNml2b3Rx?=
 =?utf-8?Q?cVEMCtgKLvk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR10MB7436.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eDN6OGdIekxlWVF3QmVDY0ZHbFZndVJXYTlHaU5NQmtnZW1uUG9lQzY4aWs3?=
 =?utf-8?B?VkJiVVVmOGhLbUpBUFVSaWpwNmlLcW5XenpJeDdhRU5vdjR2WFc4K2d0NE5Z?=
 =?utf-8?B?NDN0TGtzdm5oSXliTFozS2I1UVA4aHJISEJYbkQrbnV6VndjY29lYjJkRVVn?=
 =?utf-8?B?ZmJuanBKQURFZzFMd0NqVUYrTTBkUXZVdS8vZU5mM00rMVR2RE5uUXRtRVhk?=
 =?utf-8?B?aWRWbm00MVpGa1oyYXJpMEpiSm9EL1RKMDJWQlpyMjdVb2ZwTGd6TGpCMWN1?=
 =?utf-8?B?WU55d0ZwUjhUazFUSks0aWdHZ2pXQmVsQmNGazdvWk5uQTRyMk93c1ZOMFlX?=
 =?utf-8?B?d0tiYlo4WkRxSU94a2RFTlVodWFFa2w0d2JHKzZnV0s4N2NXTjl2M3BsRGxG?=
 =?utf-8?B?VFdrRlZpQVBaMDZaRlFFSU1rN204V29XMkdWV3lJZGhEdW4zdy91N0hsVkNh?=
 =?utf-8?B?aERXek5Od1NRemV2ekk2QW5TM0lnZWVqcEIvMytaaURCQWJGVlBINk1RWE5p?=
 =?utf-8?B?ZU1vQytNS2RoNXVpcXlpMFFUdGp5ZlJYTnM0S3Fja1BJYUdIc0JsclFKMC9K?=
 =?utf-8?B?MXFwVG0xMWtvV3ZRYVp3QzNSazA5a3UvZWxuVTJIQzFnYXA3SHVhOER0a3VG?=
 =?utf-8?B?UnFGaUthcHJHS2d1UGpleWtKY2dxdTRnN3EvcW9Ob3NqQmtLR1U3aWtkR3BK?=
 =?utf-8?B?ZWZ6a010dkNOcDNJREkyODd3bk12OXBCUkZLNktnYUJWY3pMa2pGNG53TURq?=
 =?utf-8?B?ZG5WYVRlOHdtSTYzRXo4YnMrZStqYngwTFhiVlp2VTlZNWVaWWNobWNVQVpF?=
 =?utf-8?B?Q1paeEc4WWtHeURjcGtuaUtBNldLazh3eDFXcnpxcCtjV2Y0LzlDREtiRXFW?=
 =?utf-8?B?U0dld1h2c2dBK05LR1BTa3Q0WmJNb25jd1lmS21DWVlwRU5NYm5xRDk4cVFx?=
 =?utf-8?B?ZGpXS1llMmU3Tk9lMzZTOEI3L09XaVUxMXdwYlkzbXBTWUt3T2RwODE1N2RM?=
 =?utf-8?B?MU81S0dZK2FxaXBEVjV4REQwS0Nxc3NqS08rSytmV1ZIcHFDTFA1SytTSjJ0?=
 =?utf-8?B?YmJBRm5GbVhDdGJ1U3pGMi9Ob0pTTFZhQ3U3ckViSk44TnZSNEd3eVhFMFZy?=
 =?utf-8?B?RGt5R0RueFU2akZaL2R0VFhibjFHUytlZHMzOTg5NURnU2NzY3BzSURVdVlM?=
 =?utf-8?B?eHRLY0dBbncwUlUwRVVFdHhOTUdRWHhMazcyM0djRVpYakdjcGZmaTJPRFZl?=
 =?utf-8?B?elBtSlRTanliQy9tYTJFNnE3NVVEZHdzNXBaQndyalR6eHI5UVEyVlMzTXNI?=
 =?utf-8?B?ODdjSDlDamsrSENQMTJCSVc2dVExQi9kVURnSjVmT0VWeWVRWjh5TUEyazI5?=
 =?utf-8?B?bGFpdnVJN2M3WXBhOE9YVklTY3F0VE1jK0plTWxaUGRyNnN2WnpsUWs4aEZL?=
 =?utf-8?B?c01LMmlqSTVPNlZhaUtQZnJFS0VKbUNQaFVwTnM4Y3RwOW93VnVjR3FoUFND?=
 =?utf-8?B?aGpvc2FSd0ZSRURkTU5DTEt2RHI3RmJSVW9jNlF2dWdTRzJ0RzdWMXdXRkQ1?=
 =?utf-8?B?UWZaV3FlaGMwa3luNi9VdnRrdlVRc1dqSFZLZEtZdENkNHdlNEgzLzNNM2g5?=
 =?utf-8?B?R0ZXL0p3N2U1VmtQdDZRWWZsUzYwQ09wYjJHMnl0M0JuYjJUaHNQeUtPU1lh?=
 =?utf-8?B?ZjhieFNKZjV4VWlNbDVMNG53Y284QVV2TGJMbit4cDJCczNLZG5ybkFFeFpS?=
 =?utf-8?B?eFNZc3RJK3krWmU1RWpFNHFVUnJSZWMvVUJUVlV2N0x2bFVrdElUWitadmVR?=
 =?utf-8?B?ZDhqVXd5YjFoQlBmYnVZeFh6WmZKUmpxVnZ3WFlvYVJ2VXQ3ZFhWUnpUaXJF?=
 =?utf-8?B?ZURvdDA2a1Z4VmFTOXljVVlCV0xRaXNzTXJvSlE5bmwyRm5XdGV4dkRIVmo5?=
 =?utf-8?B?dEZ2M1NmTmh3TndTNjZtVFpsTHZhV3R5dS9ISXRYOGhhK3ZVLysvKzAvcnU5?=
 =?utf-8?B?enJ6bGNPbmVMYVdkOGI2NldUMjFqUjVDc2hIdUVQekkxSlBtMUdPV0ZuekZl?=
 =?utf-8?B?Y1g3RTlQdFNXVThPMTZRSWg0Tis3VXdKY0svcnQ5azB5RDQzWVAwakdaY0w4?=
 =?utf-8?B?dlJud2FtR3NvekJoeWcva0ZFeGNXZGd6WGU0MFJ5NkU2OXhadlFValhuTFdh?=
 =?utf-8?B?aHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: krzLJpMBWXc6EH2MH1TTZui/DUKgDA6LFpo0ihsitQ6/nDtnGJqCA5KsOLUjk4yxIuT+jeNk5ADP444Pv97U6NoltsRP9GmpJDw8jspK4e7k9gJ+QAJPXrOGLlJ7/8Nv3aHKQDOHtiE/aS0PCcVPjCUppktHudR6snwy5KxPmNxNMypeyYOnY1WmwzwYANlzhYNAgPXAVvrHjjYQb54RbpD1HpIuLNoOXDJ9MLsiXhP3kz0XNUSJijCi7JYCBFiW+VTLYtHoUBkdFEzaFgcK5JIIlzC/s3yMyBhtfWPPJCw8LDfe3cpCMu0a1zFTkA2RyGT2yFR1p1KLENlhbBW7c9q3sulokjadjKF9wuFz2zpkhnAX0i5k9+rC0KTeUbMQCCooVxddCeQXk+D1b5gHk8XeXQ6p6v+Je/Xn57nROCKgWl16BD4hFShN9UYZuB1VVlPBf/bWHR9Wk9Q8ZTWggulOeQfG3NHnFT3ThXp/ZtllvEqyrCTxX+gKg0QnUWU9xQtcbpVDbVX9cDXFrX+adAWg72ipRtLJkCp5yRNNYhw5bZovnbvmiv/cfTq92re/J0kaCbfLc2auc7UsocHt6XiHhvE6g5EYnaUhSft0goE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf2ddaae-5f14-4583-ed5e-08dd96ed14f2
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7436.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 15:51:56.0923 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pSrBus025kJzBj+jfm5odqFZeT0/T5QSU8s5uv603s5k7sq0GMLQZM+8HXAL1vdF2rrhdeI9TMbq/YjG4WzvNix7PMN+Zq6V9dWdxQGYtrE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5816
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-19_06,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0 phishscore=0
 bulkscore=0 adultscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505070000
 definitions=main-2505190147
X-Authority-Analysis: v=2.4 cv=ec09f6EH c=1 sm=1 tr=0 ts=682b539f b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10
 a=yPCof4ZbAAAA:8 a=5jn8VuT6XzJ4X7xnUvoA:9 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:14694
X-Proofpoint-GUID: jTCUyBC_mY5E3ibDt6DpC401C4r9endD
X-Proofpoint-ORIG-GUID: jTCUyBC_mY5E3ibDt6DpC401C4r9endD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE5MDE0OCBTYWx0ZWRfX1jbEtUtKmAO9
 SNs0rbfty6DgqO27XMPbp3ki9E0VbIF5ezx10Tok3w5yimAszf9qVEIZIVLx5X5cnMh41cuDhhp
 CvKhBjzVoISZ6fr77Qg1jaia+qmRmZC4Tt8+LFGlPAkibUrAlqTBBK7STgNniWFAjBj37w6QY+N
 QpeIsMJtEtksXHwxZewYTYLEvQdhuqHs2APIR+QG6atN653o7QfVoEZO6rsyjp+W/Mzxxv+xeGX
 4YI1T/jst78Tx8PAU6OcAuLd//ktVww6mxjhEKKkP49mccFnKXV6qO7S0trGegqyel+lHj9gNlM
 ZVVHYXd6yztK8ubc9qAD/2KkE4smnUMbHZnLc/TeBel0VMIrMgoPfwGPnprKzebzB0oaFZmJeWj
 y/rTDCHDDPWYwbMk7WS/aDrFbjtwS9EQ6bAmQpqz82xHjepe260IpB29G1pDIA2W3RW7jEFY
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On 5/16/2025 4:42 AM, Duan, Zhenzhong wrote:
>> -----Original Message-----
>> From: Steve Sistare <steven.sistare@oracle.com>
>> Subject: [PATCH V3 29/42] backends/iommufd: change process ioctl
>>
>> Define the change process ioctl
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>> backends/iommufd.c       | 20 ++++++++++++++++++++
>> backends/trace-events    |  1 +
>> include/system/iommufd.h |  2 ++
>> 3 files changed, 23 insertions(+)
>>
>> diff --git a/backends/iommufd.c b/backends/iommufd.c
>> index 5c1958f..6fed1c1 100644
>> --- a/backends/iommufd.c
>> +++ b/backends/iommufd.c
>> @@ -73,6 +73,26 @@ static void iommufd_backend_class_init(ObjectClass *oc,
>> const void *data)
>>      object_class_property_add_str(oc, "fd", NULL, iommufd_backend_set_fd);
>> }
>>
>> +bool iommufd_change_process_capable(IOMMUFDBackend *be)
>> +{
>> +    struct iommu_ioas_change_process args = {.size = sizeof(args)};
>> +
>> +    return !ioctl(be->fd, IOMMU_IOAS_CHANGE_PROCESS, &args);
>> +}
>> +
>> +bool iommufd_change_process(IOMMUFDBackend *be, Error **errp)
>> +{
>> +    struct iommu_ioas_change_process args = {.size = sizeof(args)};
>> +    bool ret = !ioctl(be->fd, IOMMU_IOAS_CHANGE_PROCESS, &args);
> 
> This is same ioctl as above check, could it be called more than once for same process?

Yes, and it is a no-op if the process has not changed since the last time DMA
was mapped.

- Steve

>> +
>> +    if (!ret) {
>> +        error_setg_errno(errp, errno, "IOMMU_IOAS_CHANGE_PROCESS fd %d
>> failed",
>> +                         be->fd);
>> +    }
>> +    trace_iommufd_change_process(be->fd, ret);
>> +    return ret;
>> +}
>> +
>> bool iommufd_backend_connect(IOMMUFDBackend *be, Error **errp)
>> {
>>      int fd;
>> diff --git a/backends/trace-events b/backends/trace-events
>> index f478e18..5ccdf90 100644
>> --- a/backends/trace-events
>> +++ b/backends/trace-events
>> @@ -7,6 +7,7 @@ dbus_vmstate_loading(const char *id) "id: %s"
>> dbus_vmstate_saving(const char *id) "id: %s"
>>
>> # iommufd.c
>> +iommufd_change_process(int fd, bool ret) "fd=%d (%d)"
>> iommufd_backend_connect(int fd, bool owned, uint32_t users) "fd=%d
>> owned=%d users=%d"
>> iommufd_backend_disconnect(int fd, uint32_t users) "fd=%d users=%d"
>> iommu_backend_set_fd(int fd) "pre-opened /dev/iommu fd=%d"
>> diff --git a/include/system/iommufd.h b/include/system/iommufd.h
>> index ac700b8..db9ed53 100644
>> --- a/include/system/iommufd.h
>> +++ b/include/system/iommufd.h
>> @@ -64,6 +64,8 @@ bool
>> iommufd_backend_get_dirty_bitmap(IOMMUFDBackend *be, uint32_t hwpt_id,
>>                                        uint64_t iova, ram_addr_t size,
>>                                        uint64_t page_size, uint64_t *data,
>>                                        Error **errp);
>> +bool iommufd_change_process_capable(IOMMUFDBackend *be);
>> +bool iommufd_change_process(IOMMUFDBackend *be, Error **errp);
>>
>> #define TYPE_HOST_IOMMU_DEVICE_IOMMUFD TYPE_HOST_IOMMU_DEVICE
>> "-iommufd"
>> #endif
>> --
>> 1.8.3.1
> 


