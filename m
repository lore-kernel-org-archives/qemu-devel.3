Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA12EC54F30
	for <qemu-devel@archiver.kernel.org>; Fri, 23 May 2025 14:47:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uITgS-0003NY-P3; Fri, 23 May 2025 10:47:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uITgJ-0003Lm-Ut
 for qemu-devel@nongnu.org; Fri, 23 May 2025 10:47:33 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uITgH-0001Pa-Cu
 for qemu-devel@nongnu.org; Fri, 23 May 2025 10:47:31 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54NEbFsu029778;
 Fri, 23 May 2025 14:47:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=PcJ8mj4vO+1YV7XNfcPTTktvh/ENV9O/cUKHK6yOfCk=; b=
 jLo/NxYZAJlQtbqQRE6XOFML20g33lvjNMnrOaJqS+Zz2yNzhTOIB8l/p2QZJBJv
 +gccElf6JP+6orR01GYas8Q71gFq5ieI8NKQ8VtKT9lDZ//peWA9x2OSzMqDBQ/7
 /Y2+QCCKcws321G6PpJFs7HWGnLM2RWmabT2PNGKiNBvvTPqZ2QBRm2bfOEVGA+h
 0/Jjw163+IwxnVZ0bWUCS+wDZO66sWCS/OJyZeHj/caeA+Eqxpv7Etr6AsyjdvH7
 UghJm+jku84YOAFEQej4ZwtAyV/13lw9A4KKWHX0NCZTDldR7ldHS99kySVD/x6E
 9cAdvURPA1ng8maD0pqBiQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46ttqqg11m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 23 May 2025 14:47:26 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54NCusIt020204; Fri, 23 May 2025 14:47:24 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com
 (mail-northcentralusazon11012011.outbound.protection.outlook.com
 [40.107.200.11])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 46rwewjfps-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 23 May 2025 14:47:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b+TLrzq7jco2GmrJ1IpmxlYA4VzE2sc73Ia0M0WgimOLPlPGnwN//w2yBaOFD2S45TebUh41yvJ3SJjp4PKKoZIZSmV7u/UoOUgN38c3twgxj7X4NxQT2Dx5FJR1efzr1WLzgfN0lKX46VN1LtGGMmMi5M5QaF1bJH9KcKNsWCUbSt0hYM+qkerHGkXIueRJs8pXWiMcewKR7VwYvl92QfCTNYdfy87IALJy6hAg4T77dGVotesd/dDOmT1OxAvb3GdEVyaU5lh2BVSUiyENR668IkkhdQtFARLKkLJkdvndoF91kxu4Dvak4BBOh6XjIBi3d2Lx5eRo+0Jcsnzs2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PcJ8mj4vO+1YV7XNfcPTTktvh/ENV9O/cUKHK6yOfCk=;
 b=Hg1/n9ezAiIHcEG0Ip2owaY4qrGaVkgsEgLVlXc39A4aJc+W7w3OUtuIvA0l3UITgrzCYkIsITAZNzVH8N+G4yG7u+U3qkemUoyiB+6mFKQplxairSgeG0xx0SsDqhbcWxLVujkUMdqeQ2oho01Fl/m5+u5Krf0OrzbglCjd6bgQw0r1GfGDA0vSVMZWNyaOZWFE+EK4nqFk5mqqrGV1AheX49DAjxYteazzeEycDZ9AAe7k5rVGqoqWdNpV5EYK15I2PLx9Ej0X9sdSGouAEOFB30aoUmEfwVvmexzvponnL3virtFZvbMTIv1XE5z9bMJ+mFZ4EAzqh1dUiRS65g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PcJ8mj4vO+1YV7XNfcPTTktvh/ENV9O/cUKHK6yOfCk=;
 b=qxtuvVFH00kipNwy0tsfXbDRyUsBE9V2Lho+wz0rhR621lKDsxlFSUhWZVQ9PRKYr1qJqNzPM2KtpWTUu2qfBEg32m03v+2VnwUd0XzQG5M39ijArJsgmvXr0tWtq/nnKnjQvkKw6cPeDLqWq42QYzQDG4Baijt+mQChMk5xuW0=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by LV8PR10MB7776.namprd10.prod.outlook.com (2603:10b6:408:1e7::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Fri, 23 May
 2025 14:47:22 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8746.031; Fri, 23 May 2025
 14:47:22 +0000
Message-ID: <b7e6a0d1-dc52-4600-9043-65b3b8674256@oracle.com>
Date: Fri, 23 May 2025 10:47:20 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio/container: pass MemoryRegion to DMA operations
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 John Levon <john.levon@nutanix.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>
References: <20250521215534.2688540-1-john.levon@nutanix.com>
 <9c08a275-79ed-4192-bc6c-53c3c9f60916@redhat.com>
 <29454dcd-2eb7-4cef-83f2-659fdddeacf4@oracle.com>
 <7570ec21-9f28-4a07-b8fc-e3775683c3be@redhat.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <7570ec21-9f28-4a07-b8fc-e3775683c3be@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL0PR02CA0114.namprd02.prod.outlook.com
 (2603:10b6:208:35::19) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|LV8PR10MB7776:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fd0b7c8-2de7-4f0d-2e34-08dd9a08b9be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T3R2WERjcmNYbVJ6WmU5dmFib0pxNSt5TTF2WC9aMlROS1h3bmJWdlFqdFhm?=
 =?utf-8?B?UlVaMk10aXhMazlRU2djSlBIUENBSTlQVVNlbmlaYUsyVUJEUUxWOWg2aFVl?=
 =?utf-8?B?dHdsNUJjRHVvV3B2ZHdXc0FKWmxGMzNnOWc1NXBRdTM2UXVUci8xNWZvbjBz?=
 =?utf-8?B?M2tlU1h5TnFUTHVNa09ZR09KdkZVUUFQVTJ6Q3loU29Jd2t5UVU1RUl6Tnlp?=
 =?utf-8?B?MjNwcmUyR1ArYVIwRzVOdVBGcFIxNTJsNmJodTlMZDVUeGJiL3NVSG5oNi9r?=
 =?utf-8?B?czF1V1ZmRHpOWEdkVTBRQlI2MGplbnBGVXBhRVQvQVBnNWZUYVhkcHo2aC93?=
 =?utf-8?B?TXlESEJsTTJtTFpTRjlyRVRVdmFSeVBJdFNGcXo2cnhzTHNJNjZZU2NCVlp1?=
 =?utf-8?B?TFMwWG5QTGY4dVdqRW5HZ1RHbVl5dFFHaVo3YitLOU5LRHhpVmVuT20xWjdJ?=
 =?utf-8?B?eEFPelR2RHBweFgyRjR1ZnNzN3FrbENTZFRXcnhuVkdyY3JsOU0rbis5TjF0?=
 =?utf-8?B?TmNabnBBVjcxU2swSjlqaXY2aXNnVkQ1TlMrMUhuSlpBSXd5ekgyQWdqL0pQ?=
 =?utf-8?B?cjJwZ3N3cnJGL0lka3R0YjRtMHVCUmFNbjVLZUpqQytNS3VmbnNsdUswa3gx?=
 =?utf-8?B?NkFhOG5lWlVkRlY3MDk3TXF4UUM3Z0RJdjlaOHFya0NMMU9nQWhmQTZKaWtS?=
 =?utf-8?B?bldBNmxpOHpqWjFzSDZNQ2RJQkUxcE5PQ3lTZy9iNkluT0R6QVR4OEFYMDJn?=
 =?utf-8?B?QmFQUUZqRk50bzIwRnNJSUxtM1FUV2tzVjJKSjhqQmRSaDhSY3hkR0ZGVmxJ?=
 =?utf-8?B?cFNHZllheUlkdjBTWGxhb0g0eUQ4TUNyaGdINUVkbVd0RVpjaHJMNXIzcFJz?=
 =?utf-8?B?QUZNYndNeGc1bUJvYXhScHlWUGxLaUtCa24vRlpiVXNvTVNVN0EydjRaNm41?=
 =?utf-8?B?azVPd1ZwM2Q1VjBrWjBuWTcwcGNQK3pEUzQyb09PTmZOS2dPWG5zbkQyYlE3?=
 =?utf-8?B?MlFIVFF1ZUhES0dvNHU5MWpYMWV4b2xPVHhLU0VvWS9kSnUrUUlzZ0NIeTgy?=
 =?utf-8?B?YzR2dlZNclA1WGEwSFZYY2dKUytBUGoyanVtNDRJNDNqV0FXdjFyZ3BGUFY0?=
 =?utf-8?B?ZkpLVk9uMGlLeXZQemk2Q2hTRW94amdGM25QckZ3cTh3dnh5bHBBU2dXQ21N?=
 =?utf-8?B?UlE3d0VtT1prNDExQkZBT1pEWUdSS0JzTkQ5Mk1GTU03ZmZxeWxYUmJldTJ5?=
 =?utf-8?B?YU5RZ0xzUEZvMDBZeEQyQVZjOEZueEkrSXAxOVZRNjEzbGUvOXg0VWVwNGxN?=
 =?utf-8?B?UGlPT0pLaGlDSG1XQzJGL3I4RUEweHlYcHpmaEM2a3J6Y3Ixb3dGenIzM2Fo?=
 =?utf-8?B?S0x0NlpjbTk2Rkc3SFNJbU5RTm9vOGxzU01wN3BiMWRkOXVOalF4cThrZVdh?=
 =?utf-8?B?VWtCUVB5NzRDdEl5Y3FSZUdsRVAwMXdHUjlIam92VlRwdGJTOEtRTks0MUIz?=
 =?utf-8?B?MXR4R0lKNXBWYUpOUTYxNnJJUkxtSDdUM2JFRlRLdENUUHVqNzJIV1JrYk93?=
 =?utf-8?B?aEtqR2I0RExXZm1xZTRGaCtqbXpKYUtPRDUrbFdhMTRDaCtiTXl6L1dqQmQ5?=
 =?utf-8?B?a2FlR0FleHZaYjlkRGt1aWZFQlVCMWVRbXcvVUtuaEVtbS9GQWF2bTRtMjFD?=
 =?utf-8?B?ZzMvUEF6R2MyMkhacW9Na2tsQitwZkIzQkVxTkZaczlLSVF5QjNrMDlPYTZE?=
 =?utf-8?B?ZXhwb1hqUXB5dHhWYzZ3ZmxVd2MxMXg3OXhyMVptcjRoTGNta0cyZ1lpQnJu?=
 =?utf-8?B?eUp0NUtHUmFQeXU0SkhhQXY3WFJOM1d1M2ltQUwxWkdSd1dJdGtBNEE2VTBK?=
 =?utf-8?B?OTRBUkhTWExrNXZPY0g5N0ZGQ0U1aC9IdkdYdEJNNW9XYjJpRkExZ25BTTVB?=
 =?utf-8?Q?7cqWfOYP7kE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SzFsSml5MUo0OHVmTXphQXYxWkxaNmZzSEFjeXhDMXp4MndRM2ZDZk84UERn?=
 =?utf-8?B?TmF5TnBlcWJuN3NvOGhEVGhHUGVGeE9DRUk3MHdFM3F6TEFqWCttOFVZTm1q?=
 =?utf-8?B?bWtzMTN3VXZsSmVNYjJodTg5MFNvaDF1em1ET3YyY3NYaVovQUt2L09QazA0?=
 =?utf-8?B?eTVEYUFtWnRNWGtEWi9SWkNZUVNPRTF4NVZUc043RTN4anU4WlduSXVJWFFW?=
 =?utf-8?B?NnVpR2hnZ1JQUjA4cVlVcVdnYU1xbHR1cmkxQkZtU0l6a2JMZ0dmaUQwd0N1?=
 =?utf-8?B?VUxneTZQT1JZbEgrditDWVNhcnpWaDdYUmkwQllMa0lxUjBlTkVubjFUVExH?=
 =?utf-8?B?bHNmbnVObTRhOHJBOXhrQzhCc0VuNWRCVTZkZXd2QVpjTlJ0OFp1Z0Q2QkdM?=
 =?utf-8?B?L1pYcDBQL3pYTWxaRGJDN0tZVFc3d3VnZzdmU3R2ZXYrb3lEZisycFlydnpJ?=
 =?utf-8?B?K3JSZWEwcllUbmc5NklBUzMveEZ4ekg2ZTFvV0FJMVRXaWU1MXVPcXMrYU5q?=
 =?utf-8?B?NDVDMlE3eW96cFNWQ2RScFhZNE5FMVo1VmlvelVHcjEyOVBUclc3dHk3Q0F1?=
 =?utf-8?B?WlFJL3FIeWpoMklvUDJNUmh5WHkvT1ByNERtS1JXWFFKbjFNSStmckhYQzU5?=
 =?utf-8?B?UXd6dkVxN3U5cktUNW9qUXFrQzNFQkpkMXBabk9LSVRHM2g5V3U5QjhoYlpo?=
 =?utf-8?B?MmVpYkZmR2thTjlaWnVHTEtINVdqNit1YStVbG5SKzY2eDFxTFYrNzFMQjRT?=
 =?utf-8?B?Z0lFWjlaOGc4NUREK0d2UlQ5MzR6S2FYL1ZhUlEwWHgzRWloSVBtd210UU5h?=
 =?utf-8?B?dXlTRjR6cHBoalM4RDVqa1QxaENlNFVJNnJVaFoxL1VvdjUxQTVHUTZHeGZK?=
 =?utf-8?B?Y0NkQmt6MCtLNkNYQmVnVDBycDl3ZjdwdmplOVBxVExrWDEvM2tseCtHV0dn?=
 =?utf-8?B?TGpwcDlIdVZtNVlob3JoTmJ6RjVxY2dlU215azZDeUJJQWZ4Q2RsTHJpcXZV?=
 =?utf-8?B?V2QwK2gvNXlVNzJjN3BVOHlzeFluejlOY3hFWU1ia1ZEaG9VK0M2UnhsM0xD?=
 =?utf-8?B?Um0rTktzQVk0WE81ZGxjclgzejBqSFRpQVFheTY2Q25LZVdrL3ptODFyaDlM?=
 =?utf-8?B?bk1sU0ZpUENYMHZFeDRjd2k5dDVYTWxmZGVEMThRbHpIMlliZ3hFemdSQkln?=
 =?utf-8?B?MFowSzdaRXFCdDRRREZvTGR5U2xjR3gvMFpTanVEd1hOd1AxUW5DaGh2Yy8r?=
 =?utf-8?B?RjBDcmc0WGdyRTR6Mzl0RHNzd1NURWZmTFJBZXUyeTdxOWZjZ0VTODZBTUYv?=
 =?utf-8?B?OHhnYUF5UGd6a0xwZ0h0VHpHRS81emNYbSt3RmdTdFBFOGFtMUFSRU1VNE9D?=
 =?utf-8?B?UWVyWmtZZUlsckMraDNmcVdJcytwS2RHY1pZWGZQRm8zL1BBTlhnaG5BWGZ1?=
 =?utf-8?B?QTVlVys5UHVTNDFUWklzSytSL1FoandtQlBJV1ZEYS9uY1o3bkdReHEwckxt?=
 =?utf-8?B?VzlSd29VRHJKVHMwRFJQYTJudUczSTB1ZmxYL3hDNWNHTjNEbEY4NGdFaWlC?=
 =?utf-8?B?S2FOTFJIRm5zMU5sK0llTTV2M2NUbHppa2VDK1h4eGtLbE1vMVNrTnl1TS9C?=
 =?utf-8?B?K21zYVZHRzZHMlBMM0l5WEpZRVJEK2wzOXFhSk9IM1hXcGFObzVKREdVbHFU?=
 =?utf-8?B?eTFadUkrMTNIQ3kvaktXeSsyTTA2VXluZ0pWYytPWUFXaE9CTW5Mc3Zwd3lv?=
 =?utf-8?B?VjBWSElNZFRHVk5rUVEvYklPaVhRTnRoQUYyQVBjc3Nyc2Y4MGJCTC9rTU9y?=
 =?utf-8?B?YlBlVTc2VkYzb1FFMTdXTnNBeWdYQk5CU3FlTVpvVkJ1U2FDVGVVV0RJK3Bj?=
 =?utf-8?B?ZjErV3d6NlNlRkNmdHI1M2dlN25peDAwVlczbHhVOGV1QzdzRFRnUDFuVVNK?=
 =?utf-8?B?akFhL05NT2dudGltdnozNytiOEVORWF4YVpheVdNUjZKS1dmK3BDVGpKZkRE?=
 =?utf-8?B?d1liWS80Vkx3cVRlVkNTTlNXcXV4VjhWS2FMRlg3Nlo1WTlJU0pJSER3NXRZ?=
 =?utf-8?B?Z2oyOGlLVFNYY0p3YmtVL2lWd2ZsT1JQd0dkeTNsQmFWcjQ5ajNvbVV0cGhr?=
 =?utf-8?B?eW1FNVJyVnJkRmw0aDlOMHZpTmZrZ2VBd2pVYy9INnNxdHNUSXZQVEFjTnBT?=
 =?utf-8?B?eWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: a62oYRtndlbT3C/XRfi4gcwiOjQk6Ygk+x8M93Mzp4FPY2p3YF4y6jN0oEg2IQgW9qd1ZGyvEeqZeF0KaL00aq7NzYTt1H2KyJTE6tAmviUEpl1Y1uFH6nneh/3B3gRFAIAxIJxOCWOdfNlxWQyEiZGpQ3j99vJ9iygQVfbNcDf1Jpc48F5VIAqMuSkRPndA/6Oagz58YrfEAZD3GXLCUKTB36l2rv+RurKr4TuZsnj89SQ3+q2dCiSgW4+YBi08ut8sDQE9cHYQQOTt8U2Z0VtKSaJymLplkAoMBytnVOBXhCXE9X55BeCxyFWs9dsCC+p/YFMB4/34o4IPKxsaQbNTbdUxJg4Qq8GALhKZgHWa1Jji5HPS3ZGDkglFuDRAqPZZ+yV1VGKAxvKSJGk2RBse5ralwNEsn8nfnVZFleD8kFTAH1tpxJBMDrA5tz4uoi3e4l7NQaa1dnX9Ok0xMuJsT7dxxhIZaQUFYIaVTztdqUbW2gwvZuqWpRLDnAHbyViRErReEz3Woc7B6MVXup1ubp/hmMHbnetQG3XasgEZHIwpewCnrLFh6YOD1Fgct8lsx+bbOLiUsUKi4/Lkzx14e5VNDJnOepPSCaVEpp4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fd0b7c8-2de7-4f0d-2e34-08dd9a08b9be
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2025 14:47:22.5357 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JVybThZhVCxaFPsgszu32uWlV+MX96ny/C2layr+BFkyQrhhip/BDrc7ErGSmOkEmH9MA5MEyxZPme+VjndsQRBo+uRK0u8srJOLw9utmlg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7776
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-23_04,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0
 phishscore=0 spamscore=0 bulkscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2505230132
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIzMDEzMiBTYWx0ZWRfXx/yBBhciy3lK
 4MpJv5AxTvjYZTCVx8lAqnnjyPHdNuXK6g2sG5WF3Nb8ZLHMC1+5pa5h7emp1VKqcCed/N7MbP9
 BNkVHy+h1VCpTWPrYR+r1230/FulbuCE4alJin27vbtYBL55J1HUC6mCD7ah+H5eKqwICzlD9jf
 ePyO+yHS3KCkNxbp6zQdaIRnPQsC5ELOQAhlNupCuo8uHeoepQLvnlVfKJQ0NOOs1kFP5H9Vd/0
 CX+a9Ht12H7ONwdF4bAYZs3OKzDvwm6v6ohbVsVb4170tbCsKvqfZYg7rCv0ZwKUov/1Sm6nqq/
 /mUFpSlEsgM3uP3j1b/cE5OqVTKbcZlFdgMFq++T/zyKhhQkqsG1XqdD2hB+FcvfMtWnFGkLZe6
 BJqD5cnJbk37iXnI4TRVHzRgyJ9vrpq5Z8jnLW6CaSWTrLHxuUg/gsh8gtV4bKc0QBwYc5F2
X-Proofpoint-GUID: r-sPEMK6LV9Nl5MqyVZ_cqpmx4jKn1dg
X-Authority-Analysis: v=2.4 cv=Za4dNtVA c=1 sm=1 tr=0 ts=68308a7e b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=64Cc0HZtAAAA:8
 a=EFhuJBg6N1aKl9N3zpgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:13207
X-Proofpoint-ORIG-GUID: r-sPEMK6LV9Nl5MqyVZ_cqpmx4jKn1dg
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 5/23/2025 2:24 AM, Cédric Le Goater wrote:
> On 5/22/25 19:30, Steven Sistare wrote:
>> On 5/22/2025 1:20 PM, Cédric Le Goater wrote:
>>> On 5/21/25 23:55, John Levon wrote:
>>>> Pass through the MemoryRegion to DMA operation handlers of vfio
>>>> containers. The vfio-user container will need this later, to translate
>>>> the vaddr into an offset for the dma map vfio-user message; CPR will
>>>> also will need this.
>>>>
>>>> Originally-by: John Johnson <john.g.johnson@oracle.com>
>>>> Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
>>>> Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
>>>> Signed-off-by: John Levon <john.levon@nutanix.com>
>>>> ---
>>>>   include/hw/vfio/vfio-container-base.h | 9 +++++----
>>>>   hw/vfio/container-base.c              | 4 ++--
>>>>   hw/vfio/container.c                   | 3 ++-
>>>>   hw/vfio/iommufd.c                     | 3 ++-
>>>>   hw/vfio/listener.c                    | 6 +++---
>>>>   5 files changed, 14 insertions(+), 11 deletions(-)
>>>
>>> Steven,
>>>
>>> Can you base the live update series on this patch ?
>>
>> Yes, its already on my todo list for V4.
> 
> Could you add your R-b ?

Reviewed-by: Steve Sistare <steven.sistare@oracle.com>

- Steve



