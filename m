Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87917C5B555
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 15:13:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNYkH-0006wS-GS; Fri, 06 Jun 2025 11:12:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uNYkF-0006wH-F0
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 11:12:35 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uNYkC-0006rZ-OF
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 11:12:35 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5565MeCI028086;
 Fri, 6 Jun 2025 15:12:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=YstE4sztUSA0zdH22YPcm86CZh2ANMe39t07gl1zxEw=; b=
 sLqiBdA17R4xdBgwy4E2Hd2loyem35nASrFrzZNKxXgBELbJMzpHqZF0FZRMfXW3
 jEDnGXyiOqLKppsooKdyGEYFchBFwAziBSksKTV0tKbmRKPWmexoAVtoz5hhVDh6
 YZP6S8k+LDBjTyaJRlwhE3Pd6wjDbKSFw0LBc+6KTbLWdLp40UhZG26gNBG816jJ
 o8cBuDELDwIW+cruhOhJZZ83wtL/fMaOCT7f4pf7EA92fOwEeDze0GnO/bgrrnaN
 BC9+L/iQpqroaS9GGbRGqMQuWoKX8C2FYmrha9aJC82F9xriPQU/JorSEbpEqPCF
 sq5rGlyCoKn77OcIajSU2A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 471g8gg2xe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 06 Jun 2025 15:12:28 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 556DN7Pb034970; Fri, 6 Jun 2025 15:12:28 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2086.outbound.protection.outlook.com [40.107.92.86])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46yr7dn37w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 06 Jun 2025 15:12:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ci5WlYprY0etl7OZZenQHMqlVrXMzRldPqWyo8fMCLjM/dbG6zBXuRXlSqYhk5PqHgl191JjRUNt8oqbJwACkzX6sKO6VqqAEUMg9vPYCbw4PK2IWvznRgtcrKu6nOp5BKgeUJXxjz+8rCSWWmoR16PomgDBtCJUIq7tMzvM+sxSsc0h6SDI0egKe0CTu0bByn+Zov4ueXMojANAHp0L3f+WvhNgfjz5n41QVwD0YGlzxiYyeI8mo+sFBajNe0QorlwnQMKZaPE0G5nLaAVykLlkNA6aM90Qm404jdGUVtJGO6eKlO+XYD0zkmeR3LftIvVlFSOd05psBl7GsEENnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YstE4sztUSA0zdH22YPcm86CZh2ANMe39t07gl1zxEw=;
 b=jg9sAcqSrq/U4Lta8E8i3CaPD/5G5vegj3kiEKjxdGCoK+a1D/pOSf1tLA+SpkyXh7ZZhwpyH2SQztI4hzV+hzw9oxHdvmoADUES2vaNeGTNWkOTFUXRq6kA5upXQDzMOJoCzul5yoBmQKY788az68vQBFuGJKWpUb9+YokK1k+vdslOsDLROwY4qDG+MqgGt5FzrniVCj7U1tRcwJWIBCiiZ6T630IZxMAAhOdccWyqgZEjTJ3fT/bXn5AFQSSU8MdlnH7H6s8WKrqroM/gLaVVVNDhipt7ke2JfMdhhXMDksQVgPlW1KvTOA3/NH5lAhFlHsglI+QBeaINQ+XbjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YstE4sztUSA0zdH22YPcm86CZh2ANMe39t07gl1zxEw=;
 b=sVfnurCw1duP0aFiw366cOHehhNUwbxExQ6qH0Iug6i/lxZqL3xUXoAdMWXlD4dKl9D5Go+7UFk1n8urIR1oMAKXO8vrpF1IFspJgImVPeHjB6O2DyLaLFyxN5sPJM65Nucc8mh1J8jQG4DFQJWWMSzhe28qC09a9HeHXjmlhQs=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by IA3PR10MB8138.namprd10.prod.outlook.com (2603:10b6:208:515::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.21; Fri, 6 Jun
 2025 15:12:24 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8813.018; Fri, 6 Jun 2025
 15:12:24 +0000
Message-ID: <3004c91e-d515-4e22-902c-42cea83ce64b@oracle.com>
Date: Fri, 6 Jun 2025 11:12:22 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] migration: Wait for cpr.sock file to appear before
 connecting
To: JAEHOON KIM <jhkim@linux.ibm.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, jjherne@linux.ibm.com, peterx@redhat.com,
 farosas@suse.de
References: <20250605230808.1278840-1-jhkim@linux.ibm.com>
 <aELy8_1ssb1jTSTa@redhat.com>
 <2f36bf89-9664-4552-86c0-646db01b7f1f@oracle.com>
 <2c8d3cb2-b3ee-4738-871a-0dea2bff0e84@linux.ibm.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <2c8d3cb2-b3ee-4738-871a-0dea2bff0e84@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN0PR02CA0030.namprd02.prod.outlook.com
 (2603:10b6:208:530::20) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|IA3PR10MB8138:EE_
X-MS-Office365-Filtering-Correlation-Id: 56a833bd-f44f-4b87-27d9-08dda50c8aad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WktJVDNwdGRSaU9HQnhpRkZSTnFWZ3BJSWovemdIZG8rQzVQRjRpVWRwcmxM?=
 =?utf-8?B?YTIrT2N1Y2xCQ2pMRldlYUw2eEJwbVRabHFLclBBRytjNk53QU8zTmVYYUFF?=
 =?utf-8?B?M0w5R2wxcytlVXR0RlpGbkhmekNJMW9kUE1oRE5xVEw4UGRTV1JmQ0U2YnJa?=
 =?utf-8?B?NUhrY0svNCtCRXErd1dKYlBiUjcwNE1OT2tJZnZhbGdLb0o4ZXBvSmpZcGFX?=
 =?utf-8?B?dFdrbHRBcC9STWRUL2ZYcVRTd1d1Tk1FYm1TdnFqWDNEelhsZEJlc3ZtWDBT?=
 =?utf-8?B?QzNERGIxR2dnVklGTWEySm0xajB5bUEzaXRBSC9NdDc0YW1haW5KTFFyQkNE?=
 =?utf-8?B?eDB1SUNxWWJRQTBlY1NGWGpKR2QvK0NOQlVwd3JzVWdiclJMVzlMVmxnaFBJ?=
 =?utf-8?B?TzZHVXgwT2x5Z0l1dmpQNG12YnB4UGRyR3VycGpKTFJxcEpza1IxNGVidHFt?=
 =?utf-8?B?eGFhalB1VjJXQ3ZIK2IvSmZSZk1XNWxPTXYrMU0vOHVaOEgxNmJlelFrc0ll?=
 =?utf-8?B?ZDd4UUVXZWlIYlZiUjN3RFJ0cmJrYlN5aUcvZjRrSG1OUzEyVGlqRzluZkxi?=
 =?utf-8?B?cjV2eU56U1RaNXl5U3hkZXZXSy9TelFoQk1Xc0VmWHlxL3FyZk9CZW5OTWFX?=
 =?utf-8?B?eVZQSmcwTnJKSzJoWHZoV0pteXRzVCt6cFQxQVByejRtbjNGajVPdjR5WGlz?=
 =?utf-8?B?SzJFOEFYS0ZsRVQ5ZWo3R3ZRaFRUWVdCd2Vod05rUHZsZTE4MzdFRXRwdlRy?=
 =?utf-8?B?djVxRXlxTzV6NlRad3VOZ0pWbHRSMEFPVlB3bFA0azF5UXNiRWtFVGtYMW5E?=
 =?utf-8?B?UWtUaXVIT3ZydjdpbzNJYmtwOFFBcEQ0UVhoVkhLUkJJVmVxNENoOUc3aEY5?=
 =?utf-8?B?UDVXRWh0bW96SFVqbWJiSU9tSzUxZUQ5R2FHWE1HY1VXVEROejBLUFltVjFQ?=
 =?utf-8?B?VGQ5UHRxT1ZPcnJUcXNMTG9WWGp0dkcxZkh4TmRCYjZncGdlNXdZdmxsOTlN?=
 =?utf-8?B?UVk0V3ROS05NTHpHY0pQOXNkT2tyL1BJbjlTWFlxaXprdTdGS2R2aUEwcXRC?=
 =?utf-8?B?d29FS1IvdjVZaDE2bHhtSEpKcUlGbHppMWNWb0ZjVHpIQzVxS0wvK2Njck9i?=
 =?utf-8?B?eGszT25rTEI5bk1sekUwRHNFb2Q5VjFvR0pjeVVRZjR3N1FmTm1IQll5WC90?=
 =?utf-8?B?VzcwUWZFYmtkS3BjNmd3UmczbGlia0VnNHFqWXVXRU03RnUwTGV0aXlNWWJ3?=
 =?utf-8?B?ZjVZRzVURlVIQndEcU1pQjVka29lc29JVW0xeVVyNnZCbWNoTWkrWjBHZWdj?=
 =?utf-8?B?YVZFRDI3WXdyUlhjSkhlOXZja2lXTVJaUzVVK241aTZXK2ZmbDA5NEFvMlZx?=
 =?utf-8?B?dlBPdG9aOG1xZ3J0SXY2dEhvMlpuQ0l5WGo0b1Y3WFRYTXFyUHR1MzNTMlVz?=
 =?utf-8?B?VGpieGV3UEkyUXFHTlRJd3ljdENQV1N6d2ttWlhsak5rbVJ4MHludys5Ym5T?=
 =?utf-8?B?K3RHOUlxYVFFM3Y4NWpLakxDZHFOZjFDMDZRUndvNUJaTHdCNmJxazB4eE1n?=
 =?utf-8?B?R20rVkttYlpZOXhOWVBxSVFhajJJcHVPQjE1RGZFQU5tbTFJSmVNM1h2U3Z4?=
 =?utf-8?B?WWg2VjFqTldMQ1h0eXBHbURHTDJWOGdLOVZxV0dORllGK0VoaGlTb2FtNCtk?=
 =?utf-8?B?YmNSTTRJMkNKZWhrdDVSTCtkVXZVcjFOUmE4NWJFQnZDZWducVVwTFhOOVJU?=
 =?utf-8?B?SWlLMnJQU0VLTDRsVDNWTkhSRWRKRDlzczUxSENIWTVzN0ZYTVVUTk5xWGRC?=
 =?utf-8?B?Ylh0NFdJSUZkeEhBTEJHdVkrVjl2MVJiamJOckdGbFVXeXhyOXZYd3hnNDIv?=
 =?utf-8?B?bVVSY21YaXBpV0FkYlB1V3o2TUhZdkRlWmk5KzZNcTNLWEg2YzkxNm5tc2JR?=
 =?utf-8?Q?DtPHzCYxxYA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2lTazk5L1VQbG9hUWZBUlYvZnhPN2FXZE9abm56T2pReGN3OXRTL1pwczA5?=
 =?utf-8?B?N2wrdHlIV01xWjIvZEc5UXp1ZDduTzc4V2ptVk5lK2JoelprNkFlK3FsLzVV?=
 =?utf-8?B?N1FQLzNtTnZLWGZISzNlTEdqTU10T2RoRTg2YTl2d1BPOFZwajRFYmQxWGRU?=
 =?utf-8?B?MmluSnhyVGRGWGVGVzJBOE1XSnhhTC9hY3F4aUdTZk9CdXJnY09qVThpMXZw?=
 =?utf-8?B?cG5iT3hEaS82b1FTVEsrVWFBdENDREZKWXo4VUpnZjFkZ0dQY3FEbW9IMk1n?=
 =?utf-8?B?R0tBQk5zV2JRRTlKZnhBcFB0ckxyOGFwT2tRam1ZR093V1lVT0JZVDJ3S2xG?=
 =?utf-8?B?NDhhS050Qm1hdGZpOW9heVBRNTFTRkJQdEc0RFF0RE54bDJodGNDdHJnc21U?=
 =?utf-8?B?a0JWV1R4WHNLWWlzT2ErU1NhSmhxMktNb2tMd2JaLzVnbDMrbDBXVDQ1MmxF?=
 =?utf-8?B?Tml6U3pySFlEbDJCcit3UmtBVTJIbmJ0Q2tmdFFzV1FGeVZ6SEF4ZGhuNEhT?=
 =?utf-8?B?djVIdUs5aCtuNHdOQXJCaThEV01oUmZyUjlUYjZNWDVwOXhoa2JFelh3Qlpt?=
 =?utf-8?B?eTJTSDZEMDV4eTNrZzJBeXV2eE40dSsyRkliTnh3dnhSVlBsdjhNRFE4ZVNv?=
 =?utf-8?B?Zkc5aFo4SW8zc3krYWdVMlMzVC9CZ2hPa2hpNkFjNXBEUGtYd2ptdFF6cEtt?=
 =?utf-8?B?Z0NnY01Jd3FuOXF3U3NtclNBeHVYZ0ZlOVMwZXFjMW1qUnJOb1BHeEpPM012?=
 =?utf-8?B?aVg1cktCeGNhVmZrUEdhY0wxTXRINllhbjFKcjJDbFJJemZpT1kyYk0rQXZI?=
 =?utf-8?B?UUIydEs5elArUUpEbW5JZzZoUWFxYTJiTEEzRVp1VWkwYTdqa0l3SlNvZ2Ez?=
 =?utf-8?B?ZWpSUVNiVkdvaUhiOEJtY1dISEtWOEN6cVphT2l0NmdiSWlvNmRvRjYwS1lt?=
 =?utf-8?B?WUJaV1JQL2NCSTEyekFSWTMzN1VYd2VuYXhlTTgya0lXbzRCTGZPaUNlVUpk?=
 =?utf-8?B?djhHbW5kME16WDBPanIvaS9rMGEzZXF0ektLV3FuZ2x1TkpWaXNGdk5OUi9a?=
 =?utf-8?B?bUJhMTlJVWlqeXE0bHRiNG51Q2JoT0xuQkcwMFhXNmNXL1ErTVhkMkFDYzln?=
 =?utf-8?B?bExpWU9KbTU4OFJzUkR2Z1ZwblF0NkJnbXYrOU5Kb2VOdk8rWi9qd29sUTlN?=
 =?utf-8?B?WGNnQmFKUEgrNXY0RFlkSmJPN2J2dEdiQXZtVjNvKzZnTmhXMk1ucEVmbVNa?=
 =?utf-8?B?MDNqL3hUT2tyZ2R0OU45eXF6Q1JBSEcwcXVhaWhTM0FaS3JFR3BZcDQycXQy?=
 =?utf-8?B?OUtRTkVKYU1mR0R5ZG4weGlDNFpyKzRXb3NuTTJPUTVldDVWVnJOWGR4d2dk?=
 =?utf-8?B?KzBwZ1FXbnJxbTA2OGVicnJXWTFOeXBjUnZvY29pUG5INXpEVlFnTXBOcUQ4?=
 =?utf-8?B?L1ZlelppT1lhTVZUdmZmbVFaSE5OTVlkM0xFSjI0b1BCdmEyTXhZbjUyL2VC?=
 =?utf-8?B?andLTUoweTE3QXg5TWJTcXlxeFhHd3FMZ3RJNEtVV1k5YjdyN3M3ZFRRUFY2?=
 =?utf-8?B?V3JHZGN4R1ZNb0MzU2Noc3M0MFFwSkVoQUVHZXAxbTdjcUJJc1R5OVpEK2Zo?=
 =?utf-8?B?S0FTMFU5OXppY0FZaGR1ZWJSSnhVODBHNi9BVHM3ckNUZXE0anJXcnZ5eUxk?=
 =?utf-8?B?NEFIRWZ3R0M5T2ZONXJSZ3Qvc21EUXVjaWxFcTlHUmJGL0NCZjJ3ZmkxNDQy?=
 =?utf-8?B?TThVd1BCeXAwMFpibGg0UmJGVmZ3Vml1UUdkZEpGczdZVkx0ZUkrcWpjZmVz?=
 =?utf-8?B?VWVBSlZINjdjNUNhTXV5RGJZN2FyblYvMW1Rd2JlSVgyYUI2L3dqUC9lUzlR?=
 =?utf-8?B?bG9Kc3VnT01ublRZZldockhlTGcrRlR4SWhSWDloc0QwRVhRSHBFZE5xcVEw?=
 =?utf-8?B?KzBRQzk5Sk9DVThDTnBDb3JQbGpWUGlsV1dtZWo3NFlmdC94VFdKRnFIL3NG?=
 =?utf-8?B?djg0S1FRYXJaWXdOSHJTdkhreHRTWi9ncGFmWlU3ak5zK2tReDB3MGtrK1dp?=
 =?utf-8?B?eTlsM3dvUFlKanZTdllBR1JqSmxEVW4wQVRmYVREakpxR251amxIRTNUZVFJ?=
 =?utf-8?B?VEUycFlENU1iZ3NqbmRpUWZJYSt0MTg2SmVkUzd6eGFLUDg0TGdoU2grOFlR?=
 =?utf-8?B?VFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: EczOtDnDIiZT3qR+co3fLYmRsdqDexSNl5imFY1kFKiqF/eNT8iJoFsjq143bTYsu4cTgWENcueC4oFx8WrkrFxMvVWvREFmHqZz6bm7qo0iJtWr090Y/GV/dBJ6z/usIDUwRmtPeMueAld9ket3gS8pYiHmLVJRMnVGoVjeaijVx9MjsX5nl3nrO8OPDzI/XT42TqtZXpyqhjuRZq/MyTUcyhsYmNb/cpIYXUo7cbKCZfGWN88Mxq3hyG+DAX6v4TUsAhrTqqk5hgEYWa1Xvxfp+UzX5yUU985xcINXI//TfZkN2blFNWxZ8XVtWq818aBPlzn4Trft19q0K675nwVPeTCdGu/Rqk2p9HTiJXuV5cmuh1P96rrQ/a4HoIYXPK9XxRYjtRN64y7YaDAJg+/qRmCC1m8OD5pv+ucbPcOJfMovb3n5DotjTTOW3TtUSvkoII1bfqTmI048rQmP6viBec3jPjmvQU16qD7Zc7rZercX9hvUyDh8ecPB2mS6GD+YsPyieAnBHLh8VgTjDutThKHRA4XDgWpjeCnZO7rr8OSMuwj8JkQx2+Y2Ins/jec8YKFAZv3uhyA1xL1bRVxlyTPyyk09XYbLzaAYt6A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56a833bd-f44f-4b87-27d9-08dda50c8aad
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 15:12:24.3217 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u9oZfcVhZ1IwnkZqpI1g0BVml3BFO2Aoz15iubyVd/2fxpstWz8/XPBOjqL2PiLcdR6TgMhKEOeTi0qq9GQq8B4724RVRzvIiRBEWj2b248=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8138
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-06_05,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxlogscore=999
 bulkscore=0 spamscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506060133
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA2MDEzMyBTYWx0ZWRfX9ix3QQQsuJ7q
 eejnb4ny5VIJaI0i/B2Rhf5CDQp/uo60bTcy30MRYf3ht/r2q9ocY9CSPvbEhTuPAiIqiRWz3uw
 2vkiEmO1rgr6HbRx1SOoXiMTDkd88Aacq0kCZujrvLhPQhwUl1+QHX2nCuEINiaNPSCcZcQQ9up
 s1uZ+umPVD1VtGPl0gSo6xp9FLQoL5932cEkKIKvxEh0cJdck+jr0PTHZcR98NsvF1UZ36e+4Sq
 VsVerapExOaJUL1UjbVyt4qVTiH+FCj+3BWjbjH5KQSM6XgInm7w3n1ufcNMEAAzliKaK1ZOs02
 htB/FVowOQRoJUC9u88MFqMLGT6GuEMGoRkNl6pd9ua8H2g2ZQykTtcSf0li+wYtG2S6wNDqwKQ
 /sxuFG24Hjpk1Rrui61OIJJPQg+37u/k+AuGDKo4oe98LO09VphWRpho1GwAZizavjShcGZP
X-Proofpoint-GUID: -wuiO5a_09ELVwS8cOERA5qLVACxiIot
X-Proofpoint-ORIG-GUID: -wuiO5a_09ELVwS8cOERA5qLVACxiIot
X-Authority-Analysis: v=2.4 cv=H5Tbw/Yi c=1 sm=1 tr=0 ts=6843055d b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=VnNF1IyMAAAA:8 a=8XNxQw8gZmnOTqHf15QA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
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

On 6/6/2025 11:06 AM, JAEHOON KIM wrote:
> On 6/6/2025 9:14 AM, Steven Sistare wrote:
>> On 6/6/2025 9:53 AM, Daniel P. Berrangé wrote:
>>> On Thu, Jun 05, 2025 at 06:08:08PM -0500, Jaehoon Kim wrote:
>>>> When the source VM attempts to connect to the destination VM's Unix
>>>> domain socket(cpr.sock) during CPR transfer, the socket file might not
>>>> yet be exist if the destination side hasn't completed the bind
>>>> operation. This can lead to connection failures when running tests with
>>>> the qtest framework.
>>>
>>> This sounds like a flawed test impl to me - whatever is initiating
>>> the cpr operation on the source has done so prematurely - it should
>>> ensure the dest is ready before starting the operation.
>>>
>>>> To address this, add cpr_validate_socket_path(), which wait for the
>>>> socket file to appear. This avoids intermittent qtest failures caused by
>>>> early connection attempts.
>>>
>>> IMHO it is dubious to special case cpr in this way.
>>
>> I agree with Daniel, and unfortunately it is not just a test issue;
>> every management framework that supports cpr-transfer must add logic to
>> wait for the cpr socket to appear in the target before proceeding.
>>
>> This is analogous to waiting for the monitor socket to appear before
>> connecting to it.
>>
>> - Steve
> 
> Thank you very much for your valuable review and feedback.
> 
> Just to clarify, the added cpr_validate_socket_path() function is not limited to the test framework.
> It is part of the actual CPR implementation and is intended to ensure correct behavior in all cases, including outside of tests.
> 
> I mentioned the qtest failure simply as an example where this issue became apparent.

Yes, I understand that you understand :)
Are you willing to move your fix to the qtest?

- Steve

>>>> Signed-off-by: Jaehoon Kim <jhkim@linux.ibm.com>
>>>> Reviewed-by: Jason J. Herne <jjherne@linux.ibm.com>
>>>> ---
>>>>   include/migration/cpr.h  |  1 +
>>>>   migration/cpr-transfer.c | 35 +++++++++++++++++++++++++++++++++++
>>>>   2 files changed, 36 insertions(+)
>>>>
>>>> diff --git a/include/migration/cpr.h b/include/migration/cpr.h
>>>> index 7561fc75ad..cc9384b4f9 100644
>>>> --- a/include/migration/cpr.h
>>>> +++ b/include/migration/cpr.h
>>>> @@ -23,6 +23,7 @@ MigMode cpr_get_incoming_mode(void);
>>>>   void cpr_set_incoming_mode(MigMode mode);
>>>>   bool cpr_is_incoming(void);
>>>>   +bool cpr_validate_socket_path(const char *path, Error **errp);
>>>>   int cpr_state_save(MigrationChannel *channel, Error **errp);
>>>>   int cpr_state_load(MigrationChannel *channel, Error **errp);
>>>>   void cpr_state_close(void);
>>>> diff --git a/migration/cpr-transfer.c b/migration/cpr-transfer.c
>>>> index e1f140359c..3088ed323f 100644
>>>> --- a/migration/cpr-transfer.c
>>>> +++ b/migration/cpr-transfer.c
>>>> @@ -17,6 +17,33 @@
>>>>   #include "migration/vmstate.h"
>>>>   #include "trace.h"
>>>>   +#define CPR_MAX_RETRIES     50     /* Retry for up to 5 seconds */
>>>> +#define CPR_RETRY_DELAY_US  100000 /* 100 ms per retry */
>>>> +
>>>> +bool cpr_validate_socket_path(const char *path, Error **errp)
>>>> +{
>>>> +    struct stat st;
>>>> +    int retries = CPR_MAX_RETRIES;
>>>> +
>>>> +    do {
>>>> +        if (!stat(path, &st) && S_ISSOCK(st.st_mode)) {
>>>> +            return true;
>>>> +        }
>>>> +
>>>> +        if (errno == ENOENT) {
>>>> +            usleep(CPR_RETRY_DELAY_US);
>>>> +        } else {
>>>> +            error_setg_errno(errp, errno,
>>>> +                "Unable to check status of socket path '%s'", path);
>>>> +            return false;
>>>> +        }
>>>> +    } while (--retries > 0);
>>>> +
>>>> +    error_setg(errp, "Socket path '%s' not found after %d retries",
>>>> +                                            path, CPR_MAX_RETRIES);
>>>> +    return false;
>>>> +}
>>>> +
>>>>   QEMUFile *cpr_transfer_output(MigrationChannel *channel, Error **errp)
>>>>   {
>>>>       MigrationAddress *addr = channel->addr;
>>>> @@ -28,6 +55,14 @@ QEMUFile *cpr_transfer_output(MigrationChannel *channel, Error **errp)
>>>>           QIOChannel *ioc = QIO_CHANNEL(sioc);
>>>>           SocketAddress *saddr = &addr->u.socket;
>>>>   +        /*
>>>> +         * Verify that the cpr.sock Unix domain socket file exists and is ready
>>>> +         * before proceeding with the connection.
>>>> +         */
>>>> +        if (!cpr_validate_socket_path(addr->u.socket.u.q_unix.path, errp)) {
>>>> +            return NULL;
>>>> +        }
>>>> +
>>>>           if (qio_channel_socket_connect_sync(sioc, saddr, errp) < 0) {
>>>>               return NULL;
>>>>           }
>>>> -- 
>>>> 2.49.0
>>>>
>>>>
>>>
>>> With regards,
>>> Daniel
>>
>>


