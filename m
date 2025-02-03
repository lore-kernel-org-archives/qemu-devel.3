Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA0C6C02193
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 22:27:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tf4uI-0000Ys-Ay; Mon, 03 Feb 2025 17:27:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tf4uG-0000YQ-EZ
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 17:27:04 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tf4uC-0002HF-Mf
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 17:27:03 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 513JMrYt009081;
 Mon, 3 Feb 2025 22:26:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=E5OQCchw5W8uLivcHwd2bY4edNgz4MtmEiJu5iUpZmo=; b=
 mRusmPejTXh/Fm7AeI1SCTa7lrsSbp7DCfXji1nnYZxfORt9UBW6biXU50e8WhMi
 j/NzS4nilBfmK2hsBptHYLt59Z6JqsWAxD3RY0eQSQPwqFUUw3gd7aZrFYo8MOgW
 vzw8C9Ox43FSuDZectEOiPxRq5lP2XT0PCjXiEotvSjhPTa5/XBOgY3hgA4JlATh
 YJJL+9A9R0xABoWPW+2R9JNbRf/41tGbHCh9Qz+csfKwaK3tWY3hIvBm8VaUz4h0
 YYIKHxoav4F0BYTrPYGKWHpBrjRusnr+Ishi9rftdz8+SSPtBbWiM6ITkaV/VEMa
 oDNefN0lh2mQotPLGO+BVw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44hhbtbrue-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 03 Feb 2025 22:26:58 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 513LjTON039099; Mon, 3 Feb 2025 22:26:57 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 44j8e6ynjn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 03 Feb 2025 22:26:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d3B5IPKGGLTh5R3OL9IlSwkmzANkPP2LafCfLQODbtvhXIzfPcO1LMPxZ7dllQJZUC2vdrwy6SGHW2//O353ykn8r1ZfEkJaHkb7S1fJ4LB5GaUxffKZKJ2FYifU66u7YCZSGbtCqFVMwud/q6dMydFxD+twjyMOJuvme9QKOH5bzHuNVO5CTHZPUm2+EV00CJgXmBZqprVltvRwAo37S4Q/cir/ZLKphSFQ0m8AO8iwZEP8/GQkSg5MbSLQwf3z4u6d/a6uwmVnxSLmh+Zh4CmJNGS1Me4mykWBbOTefmQuEbNqAYbGDqVcyAuj8ELgikzkIJqXrNQR4RnRED1fIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E5OQCchw5W8uLivcHwd2bY4edNgz4MtmEiJu5iUpZmo=;
 b=OpL7YyxxxgN3QdZ9uZ2ByIymFITz+gb4G2YKgwpSc1uXcGZr2MzTIJzJs2MeAQD33PiJ8zAuZgG+/oimH63oUDUqKrNdGCr4n0rJSbPbwx7ZZ73PbR+yEIqr6suNn8XpWoY4WHUg7ZLOmScd10D61lxEjcwAoYe8wHiN/ENk38mMaCS4DviYc0Rh0SZfL0fscLrKIOrCvtxX9FyOGr8IubX/Qrb4KNiBGTkay+LL+vFc4zRaG5Em+WlqubSZv1vSHNpEsRwAPviM7SJR2JZaMM0yYCrVW93AyFf0iPK327QaYAbrQccbtJSDxAJ1eSyIR1mTOZC8u05Gi3JdGmXS0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E5OQCchw5W8uLivcHwd2bY4edNgz4MtmEiJu5iUpZmo=;
 b=GGubBkmephLkmexM60SjsasOBqNvPOVMI+aIdSqVmqK9J6onLk49QTOWyvIhXFMhaDHOGzgHag6ZNzUKTuWXB+nKoP8p+jxhvup4Arib4VHVHVPYpHmGUz1YPI5kQ0n1tidXg9FXExLernKWWMOTqUkWygmxQld7nCA9lNFMhtM=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by PH7PR10MB6312.namprd10.prod.outlook.com (2603:10b6:510:1b3::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Mon, 3 Feb
 2025 22:26:55 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%6]) with mapi id 15.20.8398.025; Mon, 3 Feb 2025
 22:26:54 +0000
Message-ID: <73b2d2c0-1494-4ce0-9e52-391a137afdb1@oracle.com>
Date: Mon, 3 Feb 2025 17:26:50 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 04/26] vfio/container: register container for cpr
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <1738161802-172631-1-git-send-email-steven.sistare@oracle.com>
 <1738161802-172631-5-git-send-email-steven.sistare@oracle.com>
 <bbec2516-883b-4da4-bcff-d67628f09ef4@redhat.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <bbec2516-883b-4da4-bcff-d67628f09ef4@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0128.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::13) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|PH7PR10MB6312:EE_
X-MS-Office365-Filtering-Correlation-Id: d93328a8-d52c-43b6-59b7-08dd44a1dd1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZTVDT2NNOWpKR2VNdGxKNzNuZVRad2Frd3Q5cEFEbjFMUGk2Nzc1d3lRT0hz?=
 =?utf-8?B?VFI4cEF2TWdjUTByOFE1NHo0TTdrN0RrWUJOWEV1eXJKWVNEQkVQREF0dllC?=
 =?utf-8?B?ODlzL1AraFVLS3BnYzQ5SzJ5RkJBWkZ5YWRmcWMvM3l1MU1MQUNUZFZWRDZQ?=
 =?utf-8?B?bGpvRncvT3AydFdneUVBTSt1ZVB5ZVVDRlFJbm1EVDdMQnFBVlB4a3VLOTh5?=
 =?utf-8?B?SE80cVNZbHV3WjRxTkVycithanlCYTN3WnVjTmV2OU9QOXg0M2pwZVZnVmhC?=
 =?utf-8?B?VXBLVm1GSGZKTHRib2hFWFVXUEJ2SnNxdjdVTDZhM1lSdlFoaVZ4TGgzMVZQ?=
 =?utf-8?B?eHhqOXQyRVJPTno4Zm1SNzcycjR5ZkVZT2dRQXhIbzRGS0xYcHE3eVZYUlhr?=
 =?utf-8?B?N1k1QWszVXR5Z3Z2V0tBckl4TzlZTUV6V3huQnhnTndwdEpLZ1lla0J5L29M?=
 =?utf-8?B?b0ljQkV4WmEzdW5KRC9HeC9NN2hhTXBDNzQ2MjJGK0VtSEVtVU5PMVp3NjdL?=
 =?utf-8?B?Qnk1a0Rzb2lHS0NzNGxlVTFYVmJkWG5pZFZ4Vjh6WnNDZ3A5dkRTRUtFNUVk?=
 =?utf-8?B?YVdOdm1DMzRRQ3FrVzg1SXRRMjgxOEE5QnYvamtsbzNXc21ON2pXU3R6ejlz?=
 =?utf-8?B?U3kzNEJOVE0yL2lhUG9acXBVRGhjZXU0bmZuUU85WTZudmJlVHpVMUJZeGg4?=
 =?utf-8?B?YnRRSEZhZ016OUY1eGN2ZjdkTkI2OU9HKzJrbE9wNldZd0UrLzdVSXdJR1JE?=
 =?utf-8?B?MEtSc1JNbzVJSzc4U2NMV2xsVWlCMkFINUNNUFplTjlxZVJ3VUtaelFPWFhH?=
 =?utf-8?B?NWVIbFZhWWtRS1A5dUIwOEZYYS9GN2Nlc2hvOXROenpXckRCa0pRWnE2MlJC?=
 =?utf-8?B?TVFnMFhoWWhWK2FCdFhFODcxTncvbWx6NVpkdUxsdEl1dmdOSnlkS21CZlpR?=
 =?utf-8?B?RnZ5NUR3dG9oa2tqYzJzbUFVU09MRVJTM2pQc0FLZEdwSWU1SkdhdEhrUkR5?=
 =?utf-8?B?ZWpTVEw4UitjbmZBUndUR3VzUks3WjVEbExkWkRmZ2pWUTBHcjUyOWtBQVpq?=
 =?utf-8?B?c1pvSlVNeW5YSTF0MFR5STlXTXIxdlkza09Jeng4bSt4Vk9nc2lFN3BDSWJp?=
 =?utf-8?B?aEU5QlJ2aGZRSENNdVkvbUdaRDl4VlJXMFJNYy9IeXFRUktIa3ZDMXVhZUl3?=
 =?utf-8?B?dmx5QlJFZlduRHVpamZDMXViakJYNVNrb01mL2FnR2d1eUlHWVhWRkE3R2RE?=
 =?utf-8?B?UnEwK1pnUXE2NXhBcmdFQUN2MURRWXcyeVJFVFlJVXZOS2lncnczS1NacWNU?=
 =?utf-8?B?TXRXVmYvR2pFSEJtVnYvS0pTckxBOU5vREdya3ozRnBnU0FOdVZxdHdxaTBB?=
 =?utf-8?B?dG1HMUVKMVcrbnM3MjV1UzVpUWwyQnZPWXFyeFh5OThQdEZicGdFZ2Q5MlhL?=
 =?utf-8?B?cGhTVG1XMkFvTGhhdkllQllDUXdyNkswMUlVTS9iZERXcEhVNHY2d3g2S3BX?=
 =?utf-8?B?c3BJQ1VCZ1RPV0xOeU1XVk9EODRmZ0ZWUkxmUDZZcm1ESDZoSDU5LytqQ2E5?=
 =?utf-8?B?dFg3WXlFUTR2WUU5cnI3MVVHZVFOQUh0N3liekUzLy9aS2R3aEJGQTlrVWph?=
 =?utf-8?B?WVl1b0o1UzNUQVVwQkZ3SDhlbHQyZC9ITTZNSTZBZDhuTFZFeFErYXlhbnUx?=
 =?utf-8?B?MW4xT2FpMVVUMkdNV0U4Zko2UXBQLy9TbE5qWFp1VnF5N0hoK2ZMaHY3U3h3?=
 =?utf-8?B?Y3RtWitVQVhLdjRoRTJRb0tYMU4wczI4ZGovWlQ3c2NvWVhNZkk1YVlBR0Nk?=
 =?utf-8?B?UEN5VlhuQWNzSnBqL0VmQllBYnFRcmE4YXFQWnFHdS9hQk1rOEFtSVRzdHQ0?=
 =?utf-8?Q?MVWMvan4AQDsz?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TkJZZTZyMlROU2hHU2R6SjRVeGM4cVIxb3NZYmpIOFNFMnhuRW5ON25PekZx?=
 =?utf-8?B?a2NHeVZoMjJraFdQKzBVNitQd2JOWFU2OGVmUWVqY0NiektXcTVNdWpuL1Jj?=
 =?utf-8?B?U0NFbnk5RW16K3hJczVacjZ2anY2ZkpmcktFT2VoTTNiQUhpUzUzaVZYS3VE?=
 =?utf-8?B?Njd5YmRXODRHR1A2cE8zMkNNTFBuY2tyaEszdWFod25sZDZkVkJ1b2lDSEdj?=
 =?utf-8?B?MlFWeWp5NFZRQ1RhVzNUZTExZ1p3SHpNQ1FYbEQzbi9keFlkdUMyU29Eb1Fo?=
 =?utf-8?B?VlJFM2I0c3dKZW1Feis0UCsxWk12YmZveHRKMzIrOU91NVVxVkdsNHZLTGhp?=
 =?utf-8?B?cmc4aFErZ1IxbkNvSEN6WTF6enNZazdZVXhKcVdOQmZBdXBCaHkyOTFEVXd0?=
 =?utf-8?B?UkNmcUo5SnJPeTV4YzAvOURMTXZiaElNb1pIanFyd2RZTXY2K3JTeTNBL2RC?=
 =?utf-8?B?NnNjR0t4QnJPOXdkSG5oYVBSSURYMDNyMjh4T1NYbnJpU0JRUWZOOWJzTkl0?=
 =?utf-8?B?YytmVHBtZ0UzSE1OaS9ZRHQ5WllZSklWY3FseExvaUREMWtuQy9oMFNRcWNM?=
 =?utf-8?B?a0hrdmRualFvSS92aytOeFBxWkhwOW5ac2ZCeERoWGp1S3RDZ0V1VXI0Y1Aw?=
 =?utf-8?B?UnlqU3RMeXozVS82ck12ZEVNODNGTEUxbmUyaVNzVnplU1c2V1hOTlQ3cGpm?=
 =?utf-8?B?V3Q4ODZydEdRdTFGY2ZQNWoxNlVjV0dxTHpoQWRrYjRIWFdCc21sQkw1Ukxw?=
 =?utf-8?B?WHd6QzVuUGlNVUZNQk56Q3hGQjVUaHVUUWZVMmdnV0x3UkwwNk1Fa1lranhl?=
 =?utf-8?B?L0thWjhXcSs4Q1FleVQvSWVBbjdURldGTzZTa1FSYU9qT3BEZVYzWDV5dm1H?=
 =?utf-8?B?SFNUWHlGVzdrWVpFc1BPc3luYUdiRkQxaS9NVkpqc08rNWNabGo1eDl0TENh?=
 =?utf-8?B?ZTZCUUVJV25pYlM0bDlhaUEvYTEzYWM5S3VnRXF5RHBEUGJDRzdRY1VqcXRm?=
 =?utf-8?B?bDdNbDlZTGZvVElnVDVCZzNPeGVSeHY3dEJrc3VvSCtxMkpDb1RDa1VXZFFu?=
 =?utf-8?B?V3pBQm94Wm9aKzZabUgxbmxBaHRzWFF1K2R6MHlOUkI3TnBNd1dabUtjKzlt?=
 =?utf-8?B?dkpmc2RaNFdTamNrK3NZelRoR0RyaE5BdmVQaEtKT0dDdXAzeUw5RFVtT25M?=
 =?utf-8?B?U0RKeE5XQ2lYOEdEVE5ITjFWejhZcExtZW1nWmd6Zk5YTGpwNlJvNWV3TEZX?=
 =?utf-8?B?MmxKR213UnQvdk1ZakU2VXR5enJ2dUw5a0RUOS9iTFdSUkxZZUVMZzRQdUFW?=
 =?utf-8?B?dDVqUDg4MjJVclY5Qk9oRHY4UVJiaWE4NVJmUFZJd0dWUm5ZSDM0djkwaDZp?=
 =?utf-8?B?ckNjeWREYmpHSWNSV1luL3J1OGQzVTZLRlhCYk42SkpXWkxCUXZGZlArUnNu?=
 =?utf-8?B?QXR4bjJKcXNja1QyT295ZTlnYng3dExUNWtEM0xmSWZOay95M2VSMG1jL0h3?=
 =?utf-8?B?MUtkc3VyK0Q5VE1TMHc0UnN0YWw5aGVtV0o4U0Zta0tSUXR4MDVZdndkNmkv?=
 =?utf-8?B?OVZIK3lDT1FCbUhYK015VlFKbm9QSkUyZlQ4UnFkeFhicG44R2hsZlhVNnlM?=
 =?utf-8?B?a09rcTBEaWNQaUJ6eGJIYldIZWhVSnVwQ0tUMkNVaTVlR1AxSFRvano0Z0lW?=
 =?utf-8?B?cnZDNG1qZnlldERqYXBNaVE2bHhuWUl2QmNiR3VWVkdkZTEwZTNQVmVSbERy?=
 =?utf-8?B?eXgxY3ViQk1rZVBEYnBsMURHYVR4NkdUUWUrL3J2M21TNUNzSFQ2NlBuQ0tZ?=
 =?utf-8?B?STA4L0dzSDdBRHZLOWVLZVFQMkQxQW9hRi9CL3R5TlhIZGtlZFkxWlBQTGJp?=
 =?utf-8?B?QnpoQjBIZUxNalIxc2xKeDg1M0RqMWFWTitkeHQ1VDZnbUhSQTlXQTZkTFJJ?=
 =?utf-8?B?Qm43cm1TMGM3UnRUWHZhajVyNWdIYnowWlFPTzRFTVNYQUtSK3BzaXpFSGFG?=
 =?utf-8?B?M1pyVDZ0WGFBZ3NYMFc5YW4wSWk1dGJRa1FPUlJmT25ndFV1Tmd0TUFvcmVJ?=
 =?utf-8?B?dHhRNjJrL0FxSG8yWmYyK2pWRkR6MnQ3eHNNeTBlUWt3V1crZGI3ZU9WOVJ0?=
 =?utf-8?B?eW1Oam9jRlVHZWRMK0tkNnFIRW93UXZZTmdoT0o3czc4V2FSWksvVUJBZ2J3?=
 =?utf-8?B?TXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 0he704AwbPb7Q9bo9YoG6sOiFhAU9JN14b451Pm7M8/k+49Dqqg9y9EGaJFaOfmgWXGASU7Pnvs1u7finBDWR/kSQn/TnpyJ4J717PBai6RG0NlBP4y4Q5cE1LS7ziYW7f3xPdQ4ulgD7WttnbuaN2fOYEJYOgTsKRg7a8RM3qNYfuJXwNHlmV6E8hWkgdCC1KIjJi+J2J8enX/qfJBiwk8D/mpPzTI2z+ObxJjuxmy+F4WNjvYWl9vzk/UJ3RMLHrWhX/reYdihTv9NX1iJ8HwmNuIOZXhV8xZ6dtYR5FVu7PDFBCc4EXLlAymlB4mti1uNpS4fBtg9EoJIFtC7dAFhR3+zJfhQ8qHWUmr6al0K3+fFnpFi208Iii4eaGIIZtrNJgs26G1vb6IeUTAbqiE5n/TfWzxq+Nni21pU9SIhp1YecgC+udOJVFaYKq7Pi9b1w1vo+4/MktBz46oObvc7DgxW6+BABbCFeGO8DWh9w1y55tggKar9DDzRP+riolK84juDU2YSkqPBbp5rnxeb09UG5EWhxpBgmngdIBpU+QFkeizVTN0gPP8EL6ZRPUyBOYgbkFzLzbqkfUsRLvTnFtnVgZj7KjTb7le1FYc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d93328a8-d52c-43b6-59b7-08dd44a1dd1f
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2025 22:26:54.8813 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: le0iWmYng+EG/f/blvYsMMM+hEBUAZa6qcZZuJS6hnq9qeGjsHj0KqG4H5NTg+g8yksl5vEHWFJhgtsNkMgzsxBQGRc2/klojbxAOJk2tyk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6312
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-03_09,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=999
 phishscore=0 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502030163
X-Proofpoint-GUID: juIecV0H5P-AyTMEzqYCd_97O0YCvPvf
X-Proofpoint-ORIG-GUID: juIecV0H5P-AyTMEzqYCd_97O0YCvPvf
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
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

On 2/3/2025 12:01 PM, Cédric Le Goater wrote:
> On 1/29/25 15:43, Steve Sistare wrote:
>> Register a legacy container for cpr-transfer.  Add a blocker if the kernel
>> does not support VFIO_UPDATE_VADDR or VFIO_UNMAP_ALL.
>>
>> This is mostly boiler plate.  The fields to to saved and restored are added
>> in subsequent patches.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>   hw/vfio/container.c           |  6 ++--
>>   hw/vfio/cpr-legacy.c          | 68 +++++++++++++++++++++++++++++++++++++++++++
>>   hw/vfio/meson.build           |  3 +-
>>   include/hw/vfio/vfio-common.h |  3 ++
>>   4 files changed, 76 insertions(+), 4 deletions(-)
>>   create mode 100644 hw/vfio/cpr-legacy.c
>>
>> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
>> index 4ebb526..a90ce6c 100644
>> --- a/hw/vfio/container.c
>> +++ b/hw/vfio/container.c
>> @@ -618,7 +618,7 @@ static bool vfio_connect_container(VFIOGroup *group, AddressSpace *as,
>>       }
>>       bcontainer = &container->bcontainer;
>> -    if (!vfio_cpr_register_container(bcontainer, errp)) {
>> +    if (!vfio_legacy_cpr_register_container(container, errp)) {
>>           goto free_container_exit;
>>       }
>> @@ -666,7 +666,7 @@ enable_discards_exit:
>>       vfio_ram_block_discard_disable(container, false);
>>   unregister_container_exit:
>> -    vfio_cpr_unregister_container(bcontainer);
>> +    vfio_legacy_cpr_unregister_container(container);
>>   free_container_exit:
>>       object_unref(container);
>> @@ -710,7 +710,7 @@ static void vfio_disconnect_container(VFIOGroup *group)
>>           VFIOAddressSpace *space = bcontainer->space;
>>           trace_vfio_disconnect_container(container->fd);
>> -        vfio_cpr_unregister_container(bcontainer);
>> +        vfio_legacy_cpr_unregister_container(container);
>>           close(container->fd);
>>           object_unref(container);
>> diff --git a/hw/vfio/cpr-legacy.c b/hw/vfio/cpr-legacy.c
>> new file mode 100644
>> index 0000000..d3bbc05
>> --- /dev/null
>> +++ b/hw/vfio/cpr-legacy.c
>> @@ -0,0 +1,68 @@
>> +/*
>> + * Copyright (c) 2021-2025 Oracle and/or its affiliates.
>> + *
>> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
>> + * See the COPYING file in the top-level directory.
>> + */
>> +
>> +#include <sys/ioctl.h>
>> +#include "qemu/osdep.h"
>> +#include "hw/vfio/vfio-common.h"
>> +#include "migration/blocker.h"
>> +#include "migration/cpr.h"
>> +#include "migration/migration.h"
>> +#include "migration/vmstate.h"
>> +#include "qapi/error.h"
>> +
>> +static bool vfio_cpr_supported(VFIOContainer *container, Error **errp)
>> +{
>> +    if (!ioctl(container->fd, VFIO_CHECK_EXTENSION, VFIO_UPDATE_VADDR)) {
>> +        error_setg(errp, "VFIO container does not support VFIO_UPDATE_VADDR");
>> +        return false;
>> +
>> +    } else if (!ioctl(container->fd, VFIO_CHECK_EXTENSION, VFIO_UNMAP_ALL)) {
>> +        error_setg(errp, "VFIO container does not support VFIO_UNMAP_ALL");
>> +        return false;
>> +
>> +    } else {
>> +        return true;
>> +    }
>> +}
>> +
>> +static const VMStateDescription vfio_container_vmstate = {
>> +    .name = "vfio-container",
>> +    .version_id = 0,
>> +    .minimum_version_id = 0,
>> +    .needed = cpr_needed_for_reuse,
>> +    .fields = (VMStateField[]) {
>> +        VMSTATE_END_OF_LIST()
>> +    }
>> +};
>> +
>> +bool vfio_legacy_cpr_register_container(VFIOContainer *container, Error **errp)
>> +{
>> +    VFIOContainerBase *bcontainer = &container->bcontainer;
>> +    Error **cpr_blocker = &container->cpr_blocker;
>> +
>> +    if (!vfio_cpr_register_container(bcontainer, errp)) {
>> +        return false;
>> +    }
>> +
>> +    if (!vfio_cpr_supported(container, cpr_blocker)) {
>> +        return migrate_add_blocker_modes(cpr_blocker, errp,
>> +                                         MIG_MODE_CPR_TRANSFER, -1) == 0;
>> +    }
>> +
>> +    vmstate_register(NULL, -1, &vfio_container_vmstate, container);
>> +
>> +    return true;
>> +}
>> +
>> +void vfio_legacy_cpr_unregister_container(VFIOContainer *container)
>> +{
>> +    VFIOContainerBase *bcontainer = &container->bcontainer;
>> +
>> +    vfio_cpr_unregister_container(bcontainer);
>> +    migrate_del_blocker(&container->cpr_blocker);
>> +    vmstate_unregister(NULL, &vfio_container_vmstate, container);
>> +}
>> diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
>> index bba776f..5487815 100644
>> --- a/hw/vfio/meson.build
>> +++ b/hw/vfio/meson.build
>> @@ -5,13 +5,14 @@ vfio_ss.add(files(
>>     'container-base.c',
>>     'container.c',
>>     'migration.c',
>> -  'cpr.c',
>>   ))
>>   vfio_ss.add(when: 'CONFIG_PSERIES', if_true: files('spapr.c'))
>>   vfio_ss.add(when: 'CONFIG_IOMMUFD', if_true: files(
>>     'iommufd.c',
>>   ))
>>   vfio_ss.add(when: 'CONFIG_VFIO_PCI', if_true: files(
>> +  'cpr.c',
>> +  'cpr-legacy.c',
>>     'display.c',
>>     'pci-quirks.c',
>>     'pci.c',
>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
>> index 0c60be5..53e554f 100644
>> --- a/include/hw/vfio/vfio-common.h
>> +++ b/include/hw/vfio/vfio-common.h
>> @@ -84,6 +84,7 @@ typedef struct VFIOContainer {
>>       VFIOContainerBase bcontainer;
>>       int fd; /* /dev/vfio/vfio, empowered by the attached groups */
>>       unsigned iommu_type;
>> +    Error *cpr_blocker;
>>       QLIST_HEAD(, VFIOGroup) group_list;
>>   } VFIOContainer;
>> @@ -258,6 +259,8 @@ int vfio_kvm_device_del_fd(int fd, Error **errp);
>>   bool vfio_cpr_register_container(VFIOContainerBase *bcontainer, Error **errp);
>>   void vfio_cpr_unregister_container(VFIOContainerBase *bcontainer);
> 
> I think we should now rename the above routines to reflect what they do :
> add/remove a notifier.

Agreed, they do little.  Before the container types split, I thought this function
would be extended to support cpr-transfer, but now the container-specific functions
do that.

I'll just squash vfio_cpr_register_container and vfio_cpr_unregister_container into
their call sites.

- Steve

>> +bool vfio_legacy_cpr_register_container(VFIOContainer *container, Error **errp);
>> +void vfio_legacy_cpr_unregister_container(VFIOContainer *container);
> 
> Thanks,
> 
> C.
> 
>>   extern const MemoryRegionOps vfio_region_ops;
>>   typedef QLIST_HEAD(VFIOGroupList, VFIOGroup) VFIOGroupList;
> 


