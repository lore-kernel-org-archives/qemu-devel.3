Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FE93E7718B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2024 17:44:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPmTn-0003Ap-Bs; Mon, 23 Dec 2024 12:44:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1tPmTk-00035M-GC
 for qemu-devel@nongnu.org; Mon, 23 Dec 2024 12:44:29 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1tPmTg-00051I-UY
 for qemu-devel@nongnu.org; Mon, 23 Dec 2024 12:44:26 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BNGulZv030929;
 Mon, 23 Dec 2024 17:44:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=NS0Pw8vE0Ne5fZiIo74wwe33J4J9Rfok4OcGy2ud67Q=; b=
 i1yfqqRnEgyqpinXR7Pdv/lIveLaieTp+ggqfgbzumrKhPXpVicnHtuFNthOSgu8
 0ZJEmbIdup4HjVEZcGdB5TkciecEyUMNP3/P0lVSfsiNoz52gnqQnALBnVJBnu95
 rGHvSsStLrfNS1nRnmIVcB2GDIaOvMPJLr1aN/t8wgTjU5NRJ446a626dv3M9B+1
 w82TCS20sf800NLqZvY39v8I4kk8QbwKNnfdLCm0GE90HijperAjZpylwxJxdO/T
 UpNtJvtY59ATIZBrCZCqy670NS0+X/fISW51WDlDl9Ke3BILl8XFfUBeFRbAqf+y
 bYtGqDVKT29QjGedGKInrQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43nq56tyaj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 23 Dec 2024 17:44:21 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 4BNG69Pg015947; Mon, 23 Dec 2024 17:44:21 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2044.outbound.protection.outlook.com [104.47.55.44])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 43nm4dex2y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 23 Dec 2024 17:44:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S6dI4plNCu1yS2pTsOLA7dvwI4OeofA4Vm4/qG3YF2iLOS8bjBEdbM382P986S2HiIjWytd8UTMGGKzr/jX90LoDuX9veFemXSrkUcrm7TlB21EOImeehW9MKbKfvzEzwtGF3fMQ8YMVkvu/gMgVOlkq68PES7Tl1PbgZncpKIGMSNWi/KcnVWRYJxZdSnKKS4GZt1xSsok8srEzjWhA4wuqjU4bzLJ9KP4l8kQvsOLLr/fCK2qvs3qyxVEQP36ImC7/4RBpcUdVnIHIah/8tY70f2kQWPqbMdLvrB+i8k4Q6W82lx51qG6+cQ/f/BHMlj/JeMiICAn4qQ6W15zD1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NS0Pw8vE0Ne5fZiIo74wwe33J4J9Rfok4OcGy2ud67Q=;
 b=CakZeZZh8UkMSFcE50yUDsEtCVZhRiT6ZuEW5yUqfo2PygRIxONtuxtGwH49G6NZQMpB+3gHKVVjMZv+hGyltgUCjbW9li5dLJgGrw2G6zlT6hcJppspVs50yzBfCttm1rwgZCsFg3rNgRTapQsHTi7SO9ZLRUUq8yccpURIJekr7zbOMynfk4yL4d9zLFTE+92QFvSLYOs6uKIDsEG3PHWtn7tWaZxVQj5zp2xx7ojiRqGGrDOwcwX9PMA0iFU1QXy4+yn1jbRcnWs6m876DPiYlO3hKkjliSjcCr1+TN7Ow6ikptR43wUGSYfP4sEOhENPBE7wag5jHXpaQkWNxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NS0Pw8vE0Ne5fZiIo74wwe33J4J9Rfok4OcGy2ud67Q=;
 b=zjj46IcWmThAv9lnHC1SN9i6kup4qz0UcDVM2hr3+FL+bL9Ed962euNgP7y/BWrMun6Ob8vJh03iNgr1jLqvlA8r/FKQzuY87ZSXa6EWChixDnK6njQ5MPN9BGpx4h8GTwJjCTDYnLmzEkbIct533u+dfndW5QqyIGHufno043A=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by PH7PR10MB6604.namprd10.prod.outlook.com (2603:10b6:510:208::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.21; Mon, 23 Dec
 2024 17:44:15 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%6]) with mapi id 15.20.8272.013; Mon, 23 Dec 2024
 17:44:15 +0000
Message-ID: <61725257-208e-4821-a794-2ed7d0abebb7@oracle.com>
Date: Mon, 23 Dec 2024 17:44:06 +0000
Subject: Re: [PATCH v2 3/7] vfio/migration: Refactor
 vfio_devices_all_running_and_mig_active() logic
To: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Hyman Huang <yong.huang@smartx.com>, Maor Gottlieb <maorg@nvidia.com>
References: <20241218134022.21264-1-avihaih@nvidia.com>
 <20241218134022.21264-4-avihaih@nvidia.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <20241218134022.21264-4-avihaih@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0112.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:192::9) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|PH7PR10MB6604:EE_
X-MS-Office365-Filtering-Correlation-Id: b2a07083-480e-4936-4588-08dd23796ae6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RkVQUHQ3Nk1sWjFreVBwbjRwaHNXVXFwUG9pQ1p3ZG1qbFZ4Q200aEcrVnAx?=
 =?utf-8?B?R003akhFQW1jVlp3a1JzVk1OWHFJbGJTZks0cVJiZk5NMWUvZmRyTGNZNHNr?=
 =?utf-8?B?OWtjQk04eXlxR1RiR29LWkUyWTVXbkRmbTlCaDRKc1hiOHBIbzdrRzJaelF2?=
 =?utf-8?B?ai9zTWVGNTFYNDZhZlJIKzhpaThVNytwSGo3emxhd3lNcUF5UXBQUHQ3SVMy?=
 =?utf-8?B?YXZheGdPUTlUeE9MV0hWSVRrN20vWForK1d2WmZtcjgxZUZnbUpkd2FVL0hE?=
 =?utf-8?B?K1pVYVI3T0xSSWkxVHRZU2ZmcWVpSjJCL1hHVU9PcjZyMXorS2V1U25BOGJN?=
 =?utf-8?B?SnlOQktHbEF2VHdkbHpXM2N6NEhZQUYyOXI0Tmk4Q3I0a3RFWDhCQno0K2lT?=
 =?utf-8?B?bVlGSE1ONlhUeEJRV3pZRVhIUHhINkVId0krVTVSdklsZFVYOVkvZVU5aW4x?=
 =?utf-8?B?VkxXL2FqK1BJTFNsM0hIemRhY2c5THA4cVQ2RjdTWXVnQkF5WnZiTktOM0Mr?=
 =?utf-8?B?VkI4WnZIN0QyU0Jxb3orLzBXZDJjakZJR0RWLytzdmxTdlo4bjV0d1lsaXk1?=
 =?utf-8?B?OWxobTZ0Z01EZUdlWnY3UitNb1lXVmF4WlNnMVA5TGJtU2lkMDFMbktJelN2?=
 =?utf-8?B?RjE1b1pEZWFLMEhGY1BNLzR6dE9QbTNBR0VIZVYrUEtxZWluNWZtRW1WWFdm?=
 =?utf-8?B?Yi9qcTBkeFRWTzMxbG9KQXkvRmowYXVvTGEzdkw5RTRxWjJvbXpWOXZhZ3hw?=
 =?utf-8?B?UXp2cUhiZTNQbWk2eGloMUtZOCtIYU5XSmt0OGJoVHM5UTBIZkVFbnVkYzdw?=
 =?utf-8?B?OVVZMHJsZnlVVVBacnQwb3ZjMENoTG9yS0Q4VTR3VE1kVExxQXRRM2x6NXdK?=
 =?utf-8?B?MHdQODZHY0lMa3A2QS9zOGd5SlNGNHp6ZmltMW5tbm1NQy8zRzZnRS8yTXlP?=
 =?utf-8?B?UlFZci9IenpBalRxb3ZpZXBOQ3BqWmw1d2NRWEhzR29vOEJnSDJjK2duOVRI?=
 =?utf-8?B?eG9EQW5QNTJjNHl0WitiK3VDS3grN1JSYlo5WDVNWVB2QVhsM1htTStVa0NG?=
 =?utf-8?B?MlVyb1VuYUFHOFRQYk1qdGtrd09JS01TV3QxLytqTkhZTU0xM25adlVoOWdq?=
 =?utf-8?B?ak1YTzhZRDAxaUJadzVaeTVJTlgwOUNSbFJva0QydXBJdDI5c1cwT1l2UGpu?=
 =?utf-8?B?cXIrQUIwOVpxcFVsSlNORENSQnZETmg1VXZYN21rZnNla1lobUhoMkxjWEls?=
 =?utf-8?B?aEdjR1dEVWdtME5sSDJTdFd0VlBtTlBxM0w5T3plMmNsaTJvV1NHYU4yVEtt?=
 =?utf-8?B?eVRKRDdDeFhVWU0xeGNtMC9haWRFZ3lHM1hLdWNRUUFhbzBEYnhlV1gvZitG?=
 =?utf-8?B?M1FOaFIrOW9GclBUclRZcEFpQlFoZkZxUzEycktxZnk3TWtMOUQzOXBySVpE?=
 =?utf-8?B?dktHOThVRmFXM2gzWnJiYVZsUkdqRm5aeEFvOFJBTno3WHJ5WU9tY2NReVZm?=
 =?utf-8?B?U2REUFc3clJ4QkxpVFl1bDlxbDFZQUNTdUgvVjF0SFN4QjVHa0R5c04vQUVF?=
 =?utf-8?B?QTFwRGNwNTd2MFAxY21nQTFFQ2l0NzJQK3M2SkZ3Wmxjeno0M0FwbHNpZXdX?=
 =?utf-8?B?emJGZ1N2UUE2RkZ0b2s2R3VRMzJhb1BxWlUrdS9lZWRQdjJyVzBEQnloVUxY?=
 =?utf-8?B?RVpXNTRCQUFGYlhMenV4d2lCWS9rb3J2VEhFYmhvcUs3M1pYZjlOSzdHaFkw?=
 =?utf-8?B?dkhrbmdDeHVnVy9HNWxxanpObmt3ck11cHpjR2kyZ3JzYnczaHJQQ3VCUlEz?=
 =?utf-8?B?aXV4OEdDYWpkRi9NYUZOQmtEdEg2VjRIaloyS0NZaXQ3eVpWMjNJQ3d4MnFQ?=
 =?utf-8?Q?CIh64AsfPPGtC?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cXVrNytabWYvTlI1eU16YlpETzA0b2s3RDMrek02R3BpYkxwWTJONSt0REtO?=
 =?utf-8?B?MGF6NHlSZTZkSUZZMFhUTkkrbzR3bGF5UytPTlNnU1p1MU1RRkd6a25wTGNU?=
 =?utf-8?B?V0lybjVkVFZTa3hpQnNEc1NHWDhEMXhBMjBtTmpsZlpFNmdUNFluUnN1Rzk2?=
 =?utf-8?B?UnNFaks1TUxOOGppbXNkQ2JrKzNDRXYvN1V6RUtmR1NidFBSK04vTS9EeG1l?=
 =?utf-8?B?NmJIQ0ROK3dpdmE5VDM0MmM4bEplUmtlK2k0ajZQdTRHejA0SWoxMFZvMG1K?=
 =?utf-8?B?S0Q1UzU5WVRzLzRHK1ZUbVdOWkx5MGpzQlRncFdZa1FaV3d0RVdwaENuYndi?=
 =?utf-8?B?SWdsVndFY05Ob1JLNEN4T0RxQ1NXSUVNRE1wV2R5NkxFNGdMQkR4VmFvelpi?=
 =?utf-8?B?dU12VDF4VUpQV3RqMWNpbDZCV2RMRmNLTzBwd0RpOGtWTnpQSlRDWjBHS0Va?=
 =?utf-8?B?RUYwYllyK1Z2WUhTUTYrK2Ywa3UzU2NNS2FhWkp4UzBxYzdZUTA5OXhaYndD?=
 =?utf-8?B?RDRvTzQvMG5uSFNYYnJXMG5FNWZoZ3luNHlhZWR1UzdDZjMrMUZvVUVpTmtz?=
 =?utf-8?B?cjlPVnZNWktLNGlaMWxUdGcrbHpvOHhHdlVVUGhYUm0yczdCYmpLNE1VUC9l?=
 =?utf-8?B?M1hNVEt2cHlPYVVsOXMzUnJpSnFLMEpqUWdTTi80aTZtcW9ialBrWnl2N1Zp?=
 =?utf-8?B?UHhXTkhVck1WMnhhWE9VYUtPZTMzbVZpYnJ0clpiQ3JOWGcrN0ZxWkFYSllJ?=
 =?utf-8?B?SjFYbURZV1NramtLWDVKN3dKdUFaclRjWUJDYzNxTzdVV2JQZlh4cGhxcGV6?=
 =?utf-8?B?TkFyamh3YWFYc0ozRGN5ZnBBeW0vb2lwUThjU0tSb3lXNTlqZGphaUt2Ykc1?=
 =?utf-8?B?K0ZqdWYzSzZQMHJ2K2dmQnhlM2dMMUZRRThEMllOMm1RdkZFbnNtNFhmYWlU?=
 =?utf-8?B?V0hzZVRMQnUyUTkvdHFDR1NDMTV6Z0JsdUFtT1VObDVaTE9hNVBXYVNtNW92?=
 =?utf-8?B?SzFSdnRuU1M3T1g5WDhxa3Vmb0ZBQlpoVXpnOUV1MVlYTFVBVWo0Z1B5ZUtC?=
 =?utf-8?B?UkFOS2RTRGQ5ckdxdHRWZ3RBUUJtVUh5MllOZ2NmcGkzUmZDTmNrNkd1a3dD?=
 =?utf-8?B?cEx0MmRQbmwxNzJLMzE1aGpzdkxiaTE3dzNMOXpKbGFqMWNJSGZMd1lBSDg0?=
 =?utf-8?B?K2FQUEhJRCthZDNpb0IweGRFZDYyU1B3Q1RHZG90WnlYWHl5Z05DT0Q0ZWVy?=
 =?utf-8?B?ckpHRElVd0NTVzRvMktlQlpWMWl5OThhYk5aOUZ6T3FHZk5nelpJMEdLU0ty?=
 =?utf-8?B?Mnl4ZXpLV3lRd1RLU1dXTis2alJHZmx6UWpkVnBRWnM2VXBGUWxHUVRSdk92?=
 =?utf-8?B?R2RKN2JoTi80NVBMMWhGWnJIUjVoWXpYQysyZUd5aU55eGdjQXJBU0lTWlAz?=
 =?utf-8?B?aHdYMGpBRFdYaXpmdFlKVzJnMk9NYWFQK1VFTTVUbEpVWHBBU3VjTDVkZVlh?=
 =?utf-8?B?Zk9LbVp6ejAzMjdyOWEzSnZpM1c4WG5QaTlBUHVpL2wwakF3ajhNYjVXaWRm?=
 =?utf-8?B?RllQWW1HQW9HVHJ2aWZRNHJNTUFNc0lHUWhZK1hORWVaOHRwV2JFWTR3dlJm?=
 =?utf-8?B?WTAvVG92R0lVMUE3VElrUDBETE4zYldqYmE0M3N3dHdBaURzYXhtZllkb0w5?=
 =?utf-8?B?ZzdEZFBhVlY5aG5Sd0UvV1EzTTF6OGxtUDVPSkE1aUMxMjBnY0dhVWV2ZDQ2?=
 =?utf-8?B?aTZFcndpcjVVMVZycnRsSENvbGdVMElsVXo2RkhnbXc1dU51SWtTOENOTmVZ?=
 =?utf-8?B?bWVHSFdrdmR2eGVIWGF3RWRvVDNPMkIzc1VDUGRNUWN5OElsaUFFYkFJazBW?=
 =?utf-8?B?eFBFSmRQOGhpcGdEM2l5eDlUMVBlSFNodWM3RzZGOE1DYVd6SGJZSm92U3pu?=
 =?utf-8?B?Y1h6ekh3Tk9QaDJKREdMUXRpbURNcVhzcnJDZ0lqTi9zWjRrK0w0aGpkM3pG?=
 =?utf-8?B?U3NSbk1GUlNIRGQxeTV3VmlZM1czTmcwYVgzeldEUDVoUDdtV0NaYUFlNlpw?=
 =?utf-8?B?QUZ6ZDV3Q040VktmVWI5SHB4YVhxcTB1aktDUWQ2VFNWNENSUFdnRlFQN2JX?=
 =?utf-8?B?SnZIdzEwS0V2bHRkZHFYUXZENXVSaW5MdWhmMDNFNDRQSjBTUTdsTVhiNVF2?=
 =?utf-8?B?OVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ciAkAR4CXpZPsraRhMgxqjNAD/yU3CSdZiaU0SPzRjgB+/gu8Se4gpGsj7LzIJQkJLFosr9P7/E+R2SNcmknSMov14X7M0N2y+Lppx1R/Ip25sgRfUJZgUYZh5PaAicNaQ/GPTyIq53QBuJ5oyHcOapfnsteDKnHThlq6IXLvsMatjKOlz9SMiqsd8UR/b8u8FdcaeUIlj6RldBXaakwQgDr6y5fkT5oeXpMfATUhEd8fa9A/vccV8lDYLxeOUskFDsIdQS6T0aeRjM6pczy9VkTDRs6PQhkqJwlviZmYmlboUStPkmV5mijeTV7rnw2TFAy6ScWlibYJHddsfy4Uo7LqbJgsuZ4/hgOwVy3+IqcFlyPtT2lACUZl9x8p+l5kDPvNy1bTm9YnME+PbJ7c6he6JJJ+rNV0r+StmE9EoSnpRzMl9bl7bUW5g8ZlUoaGS4UMn8/M08TmXPmpHSTPPEsaKcPL4T78VjIpSUmWUbPFTtUg0eXjZCyBkZuzIWE7fsL1/dLuVa3UIIJZ3J+6q8G4gUgMhPWtI9C1HVJw/PiHrUc2BBPtw4ILtkmoVHIDR5NB1uGiHWC+fHrPMHAISyQ9bAPZfwtemVhXsKHtME=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2a07083-480e-4936-4588-08dd23796ae6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2024 17:44:15.0211 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rFxGMhUv3ICDWozsnPLH3TE3rxB10OQl1uSpyiA/fVyHT63mluNtoSg7QQ/0oOiidFujwlrM08ObTxTw3NkdLgXNDmDFsmteFaS53O4o8OY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6604
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-23_07,2024-12-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 adultscore=0 bulkscore=0
 mlxscore=0 phishscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412230157
X-Proofpoint-GUID: 2e92YwQGePyGZEQL3GwOhO0DFpuGfwjl
X-Proofpoint-ORIG-GUID: 2e92YwQGePyGZEQL3GwOhO0DFpuGfwjl
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0b-00069f02.pphosted.com
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

On 18/12/2024 13:40, Avihai Horon wrote:
> During DMA unmap with vIOMMU, vfio_devices_all_running_and_mig_active()
> is used to check whether a dirty page log sync of the unmapped pages is
> required. Such log sync is needed during migration pre-copy phase, and
> the current logic detects it by checking if migration is active and if
> the VFIO devices are running.
> 
> However, recently there has been an effort to simplify the migration
> status API and reduce it to a single migration_is_running() function.
> 
> To accommodate this, refactor vfio_devices_all_running_and_mig_active()
> logic so it won't use migration_is_active(). Do it by simply checking if
> dirty tracking has been started using internal VFIO flags.
> 
> This should be equivalent to the previous logic as during migration
> dirty tracking is active and when the guest is stopped there shouldn't
> be DMA unmaps coming from it.
> 
> As a side effect, now that migration status is no longer used, DMA unmap
> log syncs are untied from migration. This will make calc-dirty-rate more
> accurate as now it will also include VFIO dirty pages that were DMA
> unmapped.
> 
> Also rename the function to properly reflect its new logic and extract
> common code from vfio_devices_all_dirty_tracking().
> 
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>

Reviewed-by: Joao Martins <joao.m.martins@oracle.com>

> ---
>  include/hw/vfio/vfio-common.h |  4 ++--
>  hw/vfio/common.c              | 40 +++++++----------------------------
>  hw/vfio/container.c           |  2 +-
>  3 files changed, 11 insertions(+), 35 deletions(-)
> 
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index 6c999be398..d5f542beab 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -296,8 +296,8 @@ bool vfio_migration_realize(VFIODevice *vbasedev, Error **errp);
>  void vfio_migration_exit(VFIODevice *vbasedev);
>  
>  int vfio_bitmap_alloc(VFIOBitmap *vbmap, hwaddr size);
> -bool
> -vfio_devices_all_running_and_mig_active(const VFIOContainerBase *bcontainer);
> +bool vfio_devices_all_dirty_tracking_started(
> +    const VFIOContainerBase *bcontainer);
>  bool
>  vfio_devices_all_device_dirty_tracking(const VFIOContainerBase *bcontainer);
>  int vfio_devices_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index e032ce1b6f..2831f674ff 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -184,12 +184,18 @@ static bool vfio_devices_all_device_dirty_tracking_started(
>      return true;
>  }
>  
> +bool vfio_devices_all_dirty_tracking_started(
> +    const VFIOContainerBase *bcontainer)
> +{
> +    return vfio_devices_all_device_dirty_tracking_started(bcontainer) ||
> +           bcontainer->dirty_pages_started;
> +}
> +
>  static bool vfio_devices_all_dirty_tracking(VFIOContainerBase *bcontainer)
>  {
>      VFIODevice *vbasedev;
>  
> -    if (!(vfio_devices_all_device_dirty_tracking_started(bcontainer) ||
> -          bcontainer->dirty_pages_started)) {
> +    if (!vfio_devices_all_dirty_tracking_started(bcontainer)) {
>          return false;
>      }
>  
> @@ -225,36 +231,6 @@ bool vfio_devices_all_device_dirty_tracking(const VFIOContainerBase *bcontainer)
>      return true;
>  }
>  
> -/*
> - * Check if all VFIO devices are running and migration is active, which is
> - * essentially equivalent to the migration being in pre-copy phase.
> - */
> -bool
> -vfio_devices_all_running_and_mig_active(const VFIOContainerBase *bcontainer)
> -{
> -    VFIODevice *vbasedev;
> -
> -    if (!migration_is_active()) {
> -        return false;
> -    }
> -
> -    QLIST_FOREACH(vbasedev, &bcontainer->device_list, container_next) {
> -        VFIOMigration *migration = vbasedev->migration;
> -
> -        if (!migration) {
> -            return false;
> -        }
> -
> -        if (vfio_device_state_is_running(vbasedev) ||
> -            vfio_device_state_is_precopy(vbasedev)) {
> -            continue;
> -        } else {
> -            return false;
> -        }
> -    }
> -    return true;
> -}
> -
>  static bool vfio_listener_skipped_section(MemoryRegionSection *section)
>  {
>      return (!memory_region_is_ram(section->mr) &&
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index 9ccdb639ac..15deffe3e4 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -131,7 +131,7 @@ static int vfio_legacy_dma_unmap(const VFIOContainerBase *bcontainer,
>      int ret;
>      Error *local_err = NULL;
>  
> -    if (iotlb && vfio_devices_all_running_and_mig_active(bcontainer)) {
> +    if (iotlb && vfio_devices_all_dirty_tracking_started(bcontainer)) {
>          if (!vfio_devices_all_device_dirty_tracking(bcontainer) &&
>              bcontainer->dirty_pages_supported) {
>              return vfio_dma_unmap_bitmap(container, iova, size, iotlb);


