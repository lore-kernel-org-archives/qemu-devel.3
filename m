Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E7B9E77188
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 16:36:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNx0V-0002FJ-M0; Wed, 18 Dec 2024 11:34:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tNx0S-0002Db-GO
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 11:34:41 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tNx0K-0002gj-5m
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 11:34:40 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BIFtrbb010466;
 Wed, 18 Dec 2024 16:34:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=T2KrkAp/6tCeUG8Evel9wTF0UELjsBArOvguBKG6lMI=; b=
 l87j9B99ZqwYj+ittZ1fmQmdHshYF2wrtQmjqh7aVNNZytoTqwV8QiWf0f9RBlie
 Twa4MMGDmarUsD0XSBCYs3L3DJiorET0703Cdo3oOfYFRUnwjQiKtjWIs3OC2Age
 9Qk//LhdMAs878JnAq6EtZ6yUcgOoeWTA16H7q/aa3BjdLmspdsNJJ+jsIxoQbNA
 660ShTdSOqcHRLH0zj27ADLSxRgBqQHwGdQYlGYevK1erSSy4gpw+0PRqtNTHWtw
 NT7UAal2vh2qWOfx3DkoHD7I7eW6BlgGLKuTmIROVmeJcM9zxOz0JBeS2p6B9JJ9
 eimN3YYrWBiLPO9xi9rCuQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43h2jt96aj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 18 Dec 2024 16:34:25 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 4BIFogBr006433; Wed, 18 Dec 2024 16:34:24 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 43h0faxfue-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 18 Dec 2024 16:34:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nTCqLmtrG7kv1vbYA55+2HndxYjItxMNTI7ZV+b+/e/MlRvHoW1Q/Ea3aXqmVlvhvRDyl7taovv5cV1Q9pRBNzOaIL52OC4RTzt9UGNcqUXfFppF/GQ3KIFwxq9/UTSkK1bi5OtxMth3lW3GEz6O2Kedcuo/jCTbTBob1BjCT4cM4XnjAYxsMtKzvDhhdkwU/SAR4EK1tTksnwG2YOwQmSdREEBqWnL1T02FcoAySllMnfUIMIV0bShby0ZKj80SWNN2OFZUNqdvG/rjKeb4IKpvBmpu0iCyDS9yR0yDVSbQcE5OdSKXbGFf5assuTDCdL9oJgo5hxn0SnsD4O/5/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T2KrkAp/6tCeUG8Evel9wTF0UELjsBArOvguBKG6lMI=;
 b=ANlnBCLczM295eKF1WrdJvWrNg/jqhsxbx3CBwFV0lByV6gU5si7guVj0lSaiwViEORT++yUM8dS+FiDHehvEAG8524+i3K7S2YFfolySZb1ef2f78+19fuGP85gngjUc9tCOINO3cpz/WrNYvzUzwavJNEqjF795cY9LwL5bZD6Y02LjEqlGfxOMblozrS33TQCN799R0RbmMkaPFPHqVK7uBCTXAaclwQStu7Crab7UkhsrnyvHuybx1qu52cIx+UT4WNGv/zeoKKda0ye/FTzSKSk1dgYEMwibMt6WzJvPFAxfAgTzJfRMtbcnsWGRvqlQWIsZl6jbmLf1me8aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T2KrkAp/6tCeUG8Evel9wTF0UELjsBArOvguBKG6lMI=;
 b=m9ZXO7AWT3nnMx/KyqL9yTJ5GVU0CJ8feXXnN9SiU6awih1ofb1RTzGw+BKfTXNAFSfENcXlsAaU5cH66bWT+j/TAZVZ0pVVWxRDR1gS1S/HoUxmzMBgt8o5uhcv3fEos2BlTkhQt1vKOlWU60vp78/iCF/948HnVXPhv0qSSsU=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by SJ0PR10MB5743.namprd10.prod.outlook.com (2603:10b6:a03:3ee::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Wed, 18 Dec
 2024 16:34:21 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8251.015; Wed, 18 Dec 2024
 16:34:21 +0000
Message-ID: <82b5e440-1ad8-474a-8622-7a8b26b82520@oracle.com>
Date: Wed, 18 Dec 2024 11:34:13 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 02/19] physmem: fd-based shared memory
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <1733145611-62315-1-git-send-email-steven.sistare@oracle.com>
 <1733145611-62315-3-git-send-email-steven.sistare@oracle.com>
 <Z1dIEUcSrI1aROSp@x1n> <ecbae03f-a8b2-4a41-89bc-5a671a4c3c7e@oracle.com>
 <Z1tUBUcpf1XcVRhG@x1n> <bf0e7550-54a0-42ff-a281-6a65cb1ba7b5@oracle.com>
 <Z2BvNs1zTz42Tpqx@x1n> <7acde39b-9448-408d-894c-6fd96eb2324e@oracle.com>
 <Z2H_QTcgyHeONq9P@x1n>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <Z2H_QTcgyHeONq9P@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0206.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::31) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|SJ0PR10MB5743:EE_
X-MS-Office365-Filtering-Correlation-Id: e68582a5-1856-4d4c-d2a3-08dd1f81d317
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QkdxeVFZYmNQODRPdUNUMU5Udm1UZElHRzR4Q0kzNVh4VWNOQW1qQW5vejVp?=
 =?utf-8?B?eW1Lc1owUXgxY0xCQitIL2c4WEZBOWg1aU9PaWtUbFVaOGZyYTVGN1lUNjlR?=
 =?utf-8?B?dVc2cHJhQ0s4YkdvTVUxQUJzMDl5aGZQWmEydXhGWXJkdWsyOSs3RENVRys3?=
 =?utf-8?B?cDZxeEFrSDA0ZW03Z1RUZjhQbVo0eU5zTTRvUC9XWklwMFRvNzVvLyt5WWRH?=
 =?utf-8?B?N21DL3h1TmxMMEF6WTM5T1gxS0dVanBmZGFxd2xVaURLbWFWYTQ2SnN3UGpq?=
 =?utf-8?B?U3hJazRMUFNNdjc5YWJCcm9xOFZnYk1zOUZEZXpGYmVPZEp4SHhLaExQRVls?=
 =?utf-8?B?VFpnK0Jvak1pZjA1L0xpK0FCbEl5S0tCRUtGNnc2Y0NEZ2FoUU9OZ3BOZ2Vh?=
 =?utf-8?B?cnZoaC91OFk2QUdoYVpPbmV5SFNKc1p0RnpjRko2aHhDVFlJaGU4M1NtVk85?=
 =?utf-8?B?ZjZydG4xRDZNeTVKcW1PTUZzanBDdDdyMWwwUDU4Y2hWK1hqOVAvQTBZdzBZ?=
 =?utf-8?B?TXBMeUkvSEovN2RTMExrWE5UclpvOThkcHZabDdzclBOVEorWERoUG4xMlFR?=
 =?utf-8?B?dDVRY29QdXVJOEFGMlJRRnFld1VkR1k2SXdZWlkvdXNpd08yNVpYQnFxRzlM?=
 =?utf-8?B?ZDFTR0pXYVRIaXVpWnhvVHg2ZkgyZ0VZN0dVV0FZTFRrL0RvbkZ2UURBazk0?=
 =?utf-8?B?MWlnV1ZaN2RZWWRscDEvSXNqbGppQ2xGaExFaWxCOUtZWUpaNkRUeCtVMnVj?=
 =?utf-8?B?YmJkZ0w4UTkydGZFYU5kWEhoTzR6UE5MYnZGUStwdjNRZWR0Z1NndXlXTEh5?=
 =?utf-8?B?aFpYb3R5SzFycU9TNnZXODVTTWx0VUU3T29zVERET3pEMHBxaXFaZnc0bUto?=
 =?utf-8?B?dkdKMlBMa05ERXNMaE1EVmFEd1lmRzE1WjMzbDFFbzFMczBkTjB0dmF2RXNR?=
 =?utf-8?B?NWlOR0FWNi95RVdLaDBwNldQU2ovOFJRK1E1VFlYb2Q4V3M4aHcvR1FWR3kz?=
 =?utf-8?B?TWNTVFdkSnBRVkVWcWtLd3VXcTJiSWFZejc4a2hKVjFQM2JvdDlUNXhiV05k?=
 =?utf-8?B?bDJKbEZ6NzdzaHIwdXMrOGdpaWlvLzkwWUE3a1hmYm5GN3NMSDlpM0xGYVhW?=
 =?utf-8?B?Rm5TSTQ0alVMTlhtRjB3M3BoOHFOKzdJcC9aQVdWMS8xbWN1dnhQYXJBWE9H?=
 =?utf-8?B?ZFZCclhEd2VFMUM3NSs1R3NjVEdsbFE4WEpTWmZ5eU05d2c4aURoelVrNjlV?=
 =?utf-8?B?ZmVCTTJjeFEwOEJaWFFQWEkyc2k4SmRkcTlYc2hqMXUreTJiaGZxcUFyYWdK?=
 =?utf-8?B?QzdBL0RBQkg5QVJjTmdPRXNsVkhmSHFoN1lROU1FZUFUODhBQW5GdFVEdzll?=
 =?utf-8?B?WVRwamc0SmlwRUsvMm40T2t6L0oyK0c2YS93REJ3NU5HS2V0RjQ3MDBvZWo3?=
 =?utf-8?B?Q1ZQWE5UV1VtY1BHa3VOMzBEU3o2bW9FSXJkNzJZV01ROWpLN1d3d1FORUlr?=
 =?utf-8?B?aFJ3c3JOaXNLM0Q1SFJCSXFaNTlNanBIVFhCTGxhbFVVOGdDd1lzb1B0MzVL?=
 =?utf-8?B?cFJVRkc4ZWpQdFJkc1d1dG1raVNSd0xhYzBBUTkxVnMyVkxGTDBodkY0eGt6?=
 =?utf-8?B?RVdNVnRvWmJFWGo4TlJIWGZBSzdqT2loUGh6NDcwb0JxaFhQV0xFcmY3UFBp?=
 =?utf-8?B?M2NnWE8wQ21lWFJvV0ljTVFuRDYxZWo1eExNTlVnemFWNy9weVFBN3FvVEVD?=
 =?utf-8?B?VW1TWFlKTWVOZlZHbE5aZE12UmtTS2R4NmE5SVV1YzdkcDZsdDhJWVgxK2VS?=
 =?utf-8?B?UXhFS2JqenZ1VGVzMmt1ZUg0dnRTTkZWbkVjZStnYVZFR2xIY2JBekxua1NT?=
 =?utf-8?Q?sn0cZe3jUgcyH?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWw3T0dwWnBTanRFenVBMlpzeFJ6ZVVwQWdXMzRtdVQvcGFpZHRIYTU5Zm45?=
 =?utf-8?B?TVd5YytLTytuYm43YlVPY0pOSGFYbTliTGtrejkzbEdickwvaTVaUnB2ZVR6?=
 =?utf-8?B?Z2gyNzZTbzgvaHZGS2Q3Y1lMUUZMSnp6dmtiSm13N2FKT3VSdGhMUmlhZWNV?=
 =?utf-8?B?V1ZoRjkxWForcEJQNU5tMlZNSjhxd3Zad2lremFtOFp4U2xyWmRLbHJpSThL?=
 =?utf-8?B?Q2ovUVFGZ2pFLzRTY21ucTRtTU10b0lmZGNESkw1SHZoTDhpNjBUR1ExSlp3?=
 =?utf-8?B?ZlhyVHFBWG5TUEljMzFFVUxEeFBFSERheThwYW9GZHNaWnhUMU1EdjlTbDVW?=
 =?utf-8?B?TGhxUWRHOXphL09TRzFOa0FQcXVRTGlweXJwR2lySkRodVJXMFo4RTZHd1kx?=
 =?utf-8?B?b3M4VjY4RGk3V3IxY1RtVHIxc3hKN3lQRDNUN1JJMlhsU1U5RDJkNCszUmov?=
 =?utf-8?B?TUFKQTRuWmdBY2w2YkFua3RMcWNxdXVwOWppZmNzMG1CSnpJTlJkMGNoaVZz?=
 =?utf-8?B?dEhraGRicGlTR2VmVDc0ZFZpK1lFWUg4YytBc2psN2VSdDNVSHluT3JZZjZh?=
 =?utf-8?B?SHQyV3g1MVRGSWVwdHdsWVZNT1FqNWQ1Tkw3WFBlNjcwNU84WXFpYUNualZk?=
 =?utf-8?B?Rjc4cE01V1RFdE1sbXZ2eXduWHpUU1JCTXZZb2Z6UGtZalFqVXNqemdHQVVO?=
 =?utf-8?B?LzZHY01kb3h0dC9oNzB1dVZKRWlwUHlYeDN6ZkVVWXZxVWllNFBzejlHelRN?=
 =?utf-8?B?MTZMV3c1Y2NMZUFNdnBuM2JTNWFFbytSMjZiaEJMdDV2a1dpeHBHU0Z6Sldu?=
 =?utf-8?B?dnhYSkZTdXFzQW9naE5zNEhUdkJDd2orOElDWGJoZjdicHFIYVFLNmkyeFl4?=
 =?utf-8?B?SnEzcXdqbFhVdEtpOGUweEQ2U1V0czN1VjdDUW5Xb2JsUnFBOENpSVdxTE96?=
 =?utf-8?B?YTQ2Znhkdmg4bUhSWTluVVYxQkV0UHJQZkhsSGwwZkVIWGxNQXk4cjJNQ3FK?=
 =?utf-8?B?V1o1VXVCemQ4MkhId2ZiWi9ScXowRW1ZVysydlBCT3pFUEVhWTRMZDZGeXU4?=
 =?utf-8?B?MHRxZ3VaR2VxcGVrcSsxQnFaaEljOWdJQWtWdExPUUk4YkY5NUMyeTB4akQ0?=
 =?utf-8?B?cWNIak9TWTRPczhyN3MzK2xZS3Jid3NzUFpVN0hpWmVNYXZYaWN0SFlnYjNz?=
 =?utf-8?B?Z2w0MWlPTHdLRTNVSWdIT1JtNVFUeC9DaGo2N1RoUXVyZlYzL01vZHpzMHRp?=
 =?utf-8?B?c25NbUxqWnhLL2hNVVlGL1EyNENXSVRpM0xlSUVtZFliRnM4WElKaC9BeVgx?=
 =?utf-8?B?dGY2ZXd1NGszVkFWZGY5dlZRSkRqNG4zWWVmeXZ0d0d1UVkySjNYaDJFUFdK?=
 =?utf-8?B?Mkhsb0x4VnFjbnpubkxDNCt4V3Rub2ROU2hhc2t5UlpqRFVKSkpMSy9vYmNa?=
 =?utf-8?B?SUxVVHRLRlJFMU1reUVra3FDZms3Y25IMU1NSmNsRUNxNGVXV2dMRXNUUFBq?=
 =?utf-8?B?RWQrM1VSRHJBNmVSRzg0dllUZTNIN3dBUzBUWnV2eDh0QTZKZWRLVjUrcThH?=
 =?utf-8?B?eE4wdVlVaHVBeTl5N2hQaVBibmRyR295aSsvQzJ2L0xzRmlzU2h1M2R2Mkts?=
 =?utf-8?B?WTR3TStNT2VGODVldUlKS3pRWUQrNmF5WUxaa1pYbGlIUEdBbjU2TXRXMnl6?=
 =?utf-8?B?UzJZbDhMVWxrVlVWc2wxVVpnTVdGR0RRMWxRSTdCVTlOZ05OQ09VQkRVbC90?=
 =?utf-8?B?RjB4K2dNaDVqdmYrTEMrUkVaSmJDcFhadEVWNENaTVUzMS8vM3dOQzY3YVdO?=
 =?utf-8?B?dmhhT0RienNwZjhDeFlRVTFZUHhndmNmV1NPb28zT3FOQzNoNStSUndYcms0?=
 =?utf-8?B?QjRvRGloS3cwTjdhekltT0NuRWlnYlVHZ2Q2ZDQ3ODE4RHdNbCtlVUpTeE9J?=
 =?utf-8?B?Smg2Q09TVmVlNFZwM1dhWnduK3U1b0FydzkzblQxVnplb1BSbFRKRGRZMmtE?=
 =?utf-8?B?MUVQWWJvQVpJM1daNUVtT0RVUXJmU05MWGxhWGJZQy9QQzFyQzdUMVlDOTlX?=
 =?utf-8?B?Q1NJVE5JNC9QNmVhR2o0RUdYSlovbTQ2bG1SSFZsNlNobVVpVTZ3RDNFbHRn?=
 =?utf-8?B?ajUvenZzSmxPdWhjNVdLQmMvRHh1TlhGQ1EweGI5T0c4U1hJd3VlY0puYkh5?=
 =?utf-8?B?a2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 27ODd48oHGYjZXvxylUJw3IDSTGwSdzsMs3EH46xBGWOhFriXbfTHStQAyhjp6ZDbK8cHSTCQDk5j13j7kVL4Pkpi4K6BO6G+wvxYJUdLiMjeaszQs3AQBagJXv84AsB64SOE72pd7/jCAEVM2rY82MrabP8THBIzzyKuKq1o+pZWzx1id24s9lBtlFW+0eemvxUOSGP1TqdprCpvPqIY9UwNK+CHR5h8iCMNgXlPDGi8dD2ordH4ursGKcS8XXv8B3QfPpPxsQrq3rvp7+zLVXTUWsl2dJ2eMC63YCIgOJs8XXvbTecA4JpiWyxtlj+Gvwvc7gYxxsFVrg9bpnvbPU82vwiWg3OiW1anfsm7GYxupQzREPkMVnhVWCshmRuXLFZW0IABJW12KworaT3v40c6c4Rm+S2NjFPCbRVZCKEr22auGat08kzOvjIoqzlxKV7o25UxCSLFaLcZfG3v6TpkDqHL/8+pg7x3JNOwvN48wBT+vlfxnnR2GeEt8yawZYIpR81W5/TPXLMnkby1b2k221ERzJzmIxPJnynjC0pFCGbMmag8PZba7m/rp2MRFh+pYJGdZQwa27H8z5jmAaytApbOSaIcKuPqH3Lojc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e68582a5-1856-4d4c-d2a3-08dd1f81d317
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 16:34:21.1531 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YsXVDTKjDAQ4BBzUpcRWAFigZhUKkS1wQuwFZ+sXGHDJZn+9pzNSAS77YDbKaFgnqsa9H8V9x3WUIFw4bdfB2tj/Or2Hfcy9xJNILCW1qgA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5743
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-18_06,2024-12-18_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0
 malwarescore=0 bulkscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412180129
X-Proofpoint-GUID: tbsWe87lyMaEJAqd1CGdvhiqNkaF2zc0
X-Proofpoint-ORIG-GUID: tbsWe87lyMaEJAqd1CGdvhiqNkaF2zc0
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1.116,
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

On 12/17/2024 5:46 PM, Peter Xu wrote:
> On Tue, Dec 17, 2024 at 04:54:43PM -0500, Steven Sistare wrote:
>> On 12/16/2024 1:19 PM, Peter Xu wrote:
>>> On Fri, Dec 13, 2024 at 11:41:45AM -0500, Steven Sistare wrote:
>>>> On 12/12/2024 4:22 PM, Peter Xu wrote:
>>>>> On Thu, Dec 12, 2024 at 03:38:00PM -0500, Steven Sistare wrote:
>>>>>> On 12/9/2024 2:42 PM, Peter Xu wrote:
>>>>>>> On Mon, Dec 02, 2024 at 05:19:54AM -0800, Steve Sistare wrote:
>>>>>>>> @@ -2089,13 +2154,23 @@ RAMBlock *qemu_ram_alloc_internal(ram_addr_t size, ram_addr_t max_size,
>>>>>>>>          new_block->page_size = qemu_real_host_page_size();
>>>>>>>>          new_block->host = host;
>>>>>>>>          new_block->flags = ram_flags;
>>>>>>>> +
>>>>>>>> +    if (!host && !xen_enabled()) {
>>>>>>>
>>>>>>> Adding one more xen check is unnecessary.  This patch needed it could mean
>>>>>>> that the patch can be refactored.. because we have xen checks in both
>>>>>>> ram_block_add() and also in the fd allocation path.
>>>>>>>
>>>>>>> At the meantime, see:
>>>>>>>
>>>>>>> qemu_ram_alloc_from_fd():
>>>>>>>         if (kvm_enabled() && !kvm_has_sync_mmu()) {
>>>>>>>             error_setg(errp,
>>>>>>>                        "host lacks kvm mmu notifiers, -mem-path unsupported");
>>>>>>>             return NULL;
>>>>>>>         }
>>>>>>>
>>>>>>> I don't think any decent kernel could hit this, but that could be another
>>>>>>> sign that this patch duplicated some file allocations.
>>>>>>>
>>>>>>>> +        if ((new_block->flags & RAM_SHARED) &&
>>>>>>>> +            !qemu_ram_alloc_shared(new_block, &local_err)) {
>>>>>>>> +            goto err;
>>>>>>>> +        }
>>>>>>>> +    }
>>>>>>>> +
>>>>>>>>          ram_block_add(new_block, &local_err);
>>>>>>>> -    if (local_err) {
>>>>>>>> -        g_free(new_block);
>>>>>>>> -        error_propagate(errp, local_err);
>>>>>>>> -        return NULL;
>>>>>>>> +    if (!local_err) {
>>>>>>>> +        return new_block;
>>>>>>>>          }
>>>>>>>> -    return new_block;
>>>>>>>> +
>>>>>>>> +err:
>>>>>>>> +    g_free(new_block);
>>>>>>>> +    error_propagate(errp, local_err);
>>>>>>>> +    return NULL;
>>>>>>>>      }
>>>>>>>
>>>>>>> IIUC we only need to conditionally convert an anon-allocation into an
>>>>>>> fd-allocation, and then we don't need to mostly duplicate
>>>>>>> qemu_ram_alloc_from_fd(), instead we reuse it.
>>>>>>>
>>>>>>> I do have a few other comments elsewhere, but when I was trying to comment.
>>>>>>> E.g., we either shouldn't need to bother caching qemu_memfd_check()
>>>>>>> results, or do it in qemu_memfd_check() directly.. and some more.
>>>>>>
>>>>>> Someone thought it a good idea to cache the result of qemu_memfd_alloc_check,
>>>>>> and qemu_memfd_check will be called more often.  I'll cache the result inside
>>>>>> qemu_memfd_check for the special case of flags=0.
>>>>>
>>>>> OK.
>>>>>
>>>>>>
>>>>>>> Then I think it's easier I provide a patch, and also show that it can be
>>>>>>> also smaller changes to do the same thing, with everything fixed up
>>>>>>> (e.g. addressing above mmu notifier missing issue).  What do you think as
>>>>>>> below?
>>>>>>
>>>>>> The key change you make is calling qemu_ram_alloc_from_fd instead of file_ram_alloc,
>>>>>> which buys the xen and kvm checks for free.  Sounds good, I will do that in the
>>>>>> context of my patch.
>>>>>>
>>>>>> Here are some other changes in your patch, and my responses:
>>>>>>
>>>>>> I will drop the "Retrying using MAP_ANON|MAP_SHARED" message, as you did.
>>>>>>
>>>>>> However, I am keeping QEMU_VMALLOC_ALIGN, qemu_set_cloexec, and trace_qemu_ram_alloc_shared.
>>>>>
>>>>> I guess no huge deal on these, however since we're talking..  Is that
>>>>> QEMU_VMALLOC_ALIGN from qemu_anon_ram_alloc()?
>>>>>
>>>>> A quick dig tells me that it was used to be for anon THPs..
>>>>>
>>>>>        commit 36b586284e678da28df3af9fd0907d2b16f9311c
>>>>>        Author: Avi Kivity <avi@redhat.com>
>>>>>        Date:   Mon Sep 5 11:07:05 2011 +0300
>>>>>
>>>>>        qemu_vmalloc: align properly for transparent hugepages and KVM
>>>>>
>>>>> And I'm guessing if at that time was also majorly for guest ram.
>>>>>
>>>>> Considering that this path won't make an effect until the new aux mem
>>>>> option is on, I'd think it better to stick without anything special like
>>>>> QEMU_VMALLOC_ALIGN, until it's justified to be worthwhile.  E.g., Avi used
>>>>> to explicitly mention this in that commit message:
>>>>>
>>>>>        Adjust qemu_vmalloc() to honor that requirement.  Ignore it for small regions
>>>>>        to avoid fragmentation.
>>>>>
>>>>> And this is exactly mostly small regions when it's AUX.. probably except
>>>>> VGA, but it'll be SHARED on top of shmem not PRIVATE on anon anyway... so
>>>>> it'll be totally different things.
>>>>>
>>>>> So I won't worry on that 2M alignment, and I will try to not carry over
>>>>> that, because then trying to remove it will be harder.. even when we want.
>>>>
>>>> Yes, currently the aux allocations get QEMU_VMALLOC_ALIGN alignment in
>>>> qemu_anon_ram_alloc.  I do the same for the shared fd mappings to guarantee
>>>> no performance regression,
>>>
>>> I don't know how we could guarantee that at all - anon and shmem uses
>>> different knobs to enable/disable THPs after all.. For example:
>>>
>>>     $ ls /sys/kernel/mm/transparent_hugepage/*enabled
>>>     /sys/kernel/mm/transparent_hugepage/enabled
>>>     /sys/kernel/mm/transparent_hugepage/shmem_enabled
>>
>> Yes, but at least shmem_enabled is something the end user can fix.  If
>> we bake a poor alignment into qemu, the user has no recourse.  By setting
>> it to QEMU_VMALLOC_ALIGN, I eliminate alignment as a potential performance
>> issue. There is no practical downside.  We should just do it, especially if
>> you believe "no huge deal on these" as written above :)
> 
> I'd wager nobody will be able to notice the anon/shmem difference at all,
> so if it really regressed nobody will be able fix it. :)
> 
> Not to mention it's a global knob, and IMHO it doesn't make a lot of sense
> to change it for an aux mem not aligned.. while changing a global knob
> could OTOH break other things.
> 
> But sure, if you do prefer having that I'm ok. Please still consider adding
> a comment then explaining where it came from..
> 
>>
>>> And their default values normally differ too... it means after switching to
>>> fd based we do face the possibility that thp can be gone at least on the
>>> 1st 2mb.
>>>
>>> When I was suggesting it, I was hoping thp doesn't really matter that lot
>>> on aux mem, even for VGA.
>>>
>>> Btw, I don't even think the alignment will affect THP allocations for the
>>> whole vma, anyway?  I mean, it's only about the initial 2MB portion.. IOW,
>>> when not aligned, I think the worst case is we have <2MB at start address
>>> that is not using THP, but later on when it starts to align with 2MB, THPs
>>> will be allocated again.
>>
>> It depends on the kernel version/implementation.  In 6.13, it is not that
>> clever for memfd_create + mmap.  An unaligned start means no huge pages anywhere
>> in the allocation, as shown by the page-types utility.  Add QEMU_VMALLOC_ALIGN,
>> and I get huge pages.
>>
>>> The challenge is more on the "fd-based" side, where shmem on most distros
>>> will disable THP completely.
>>>
>>>> as some of them are larger than 2M and would
>>>> benefit from using huge pages.  The VA fragmentation is trivial for this small
>>>> number of aux blocks in a 64-bit address space, and is no different than it was
>>>> for qemu_anon_ram_alloc.
>>>>
>>>>> For the 2nd.. Any quick answer on why explicit qemu_set_cloexec() needed?
>>>>
>>>> qemu sets cloexec for all descriptors it opens to prevent them from accidentally
>>>> being leaked to another process via fork+exec.
>>>
>>> But my question is why this is special?  For example, we don't do that for
>>> "-object memory-backend-memfd", am I right?
>>
>> We should, the backends also need to set cloexec when they use a cpr fd.
>> I'll delete the call here and push it into cpr_find_fd.
> 
> Maybe we already have that?  As CPR receives fds from iochannels.  I am
> looking at qio_channel_socket_copy_fds(), where we have:
> 
> #ifndef MSG_CMSG_CLOEXEC
>              qemu_set_cloexec(fd);
> #endif

Oh, interesting.  qio_channel_socket_readv sets MSG_CMSG_CLOEXEC, and this
is the fallback if MSG_CMSG_CLOEXEC is not defined.  QEMU does a good job of
setting cloexec everywhere.  I'll remove my extra call.

>>>>> For 3rd, tracepoint would definitely be fine whenever you feel necessary.
>>>>>
>>>>>> Also, when qemu_memfd_create + qemu_ram_alloc_from_fd fails, qemu should fail and exit,
>>>>>> and not fall back, because something unexpected went wrong.  David said the same.
>>>>>
>>>>> Why?  I was trying to rely on such fallback to make it work on e.g. Xen.
>>>>> In that case, Xen fails there and fallback to xen_ram_alloc() inside the
>>>>> later call to ram_block_add(), no?
>>>>
>>>> Why -- because something went wrong that should have worked, and we should report the
>>>> first fault so its cause can be fixed and cpr can be used.
>>>
>>> Ahh so it's only about the corner cases where CPR could raise an error?
>>> Can we rely on the failure later on "migrate" command to tell which
>>> ramblock doesn't support it, so the user could be aware as well?
>>
>> The ramblock migration blocker will indeed tell us which block is a problem.
>>
>> But, we are throwing away potentially useful information by dropping the
>> first error message on the floor. We should only fall back for expected
>> failures.  Unexpected failures mean there is something to fix.
>>
>> I can compromise and fail on errors from these:
>>    qemu_memfd_create(name, 0, 0, 0, 0, errp);
>>    qemu_shm_alloc(0, errp);
> 
> How are we going to be sure all existing systems using RAM_SHARED ramblocks
> will always succeed on either memfd or sysv shm?  IOW, what if there's a
> system that can only support mmap(MAP_SHARED) but none of the two?

Non-POSIX will still quietly use mmap(MAP_SHARED) via ifdefs.
I'll post V5 soon and we can further refine if necessary.

- Steve

> That's my major concern, on start failing some systems where it used to
> work, even if they're corner cases.
> 
>>
>> but ignore errors from the subsequent call to qemu_ram_alloc_from_fd,
>> and fall back. That keeps the code simple.
>>
>>>> However, to do the above, but still quietly fallback if qemu_ram_alloc_from_fd
>>>> fails because of xen or kvm, I would need to return different error codes from
>>>> qemu_ram_alloc_from_fd.  Doable, but requires tweaks to all occurrences of
>>>> qemu_ram_alloc_from_fd.
>>>>
>>>> And BTW, qemu_ram_alloc_from_fd is defined for CONFIG_POSIX only.  I need
>>>> to modify the call site in the patch accordingly.
>>>
>>> Yep, I was thinking maybe qemu_ram_alloc_from_fd() had a stub function,
>>> indeed looks not..  "allocating the fd" part definitely has, which I
>>> remember I checked..
>>>
>>>> Overall, I am not convinced that using qemu_ram_alloc_from_fd in this patch
>>>> is better/simpler than my V4 patch using file_ram_alloc, plus adding xen and
>>>> kvm_has_sync_mmu checks in qemu_ram_alloc_internal.
>>>
>>> As long as you don't need to duplicate these two checks (or duplicate any
>>> such check..) I'm ok.
>>>
>>> Reusing qemu_ram_alloc_from_fd() still sounds like the easiest to go.  Yes
>>> we'll need to teach it about resize(), used_length etc. to it, but they all
>>> look sane to me.  We didn't have those simply because we don't have use of
>>> them, now we want to have resizable fd-based mem, that's the right thing to
>>> do to support that on fd allocations.
>>>
>>> OTOH, duplicating xen/mmu checks isn't sane to me.. :( It will make the
>>> code harder to maintain because the 3rd qemu_ram_alloc_from_fd() in the
>>> future will need to duplicate it once more (or worse, forget it again until
>>> xen / old kernels reports a failure)..
>>
>> I'll make the necessary changes to use qemu_ram_alloc_from_fd.
> 
> Thanks.
> 


