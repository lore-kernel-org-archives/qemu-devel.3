Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16B06C71136
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Jun 2025 21:52:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uQCJA-0006F4-4s; Fri, 13 Jun 2025 17:51:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uQCJ2-0006Ej-TZ
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 17:51:24 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uQCIz-0005No-4j
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 17:51:23 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55DCtd9A023692;
 Fri, 13 Jun 2025 21:51:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=hJno+/LbiF4t/Zldpl7NGVqz0rljFxzjXb7cxcLyU8g=; b=
 hn8ukwMD5lMyfMUEpilxJOnMeU4sWMcWcw7IHtHwLodlHYiL0JrEK+kv8iDlP9xC
 lYMwzCXsSIyVpvsDcUhv7yJN4HF+uf4KzxPnZKs734LA1/lOuoroSWxjhwNeYGEG
 2kZls6MXnMk2NTvE/hpgusqVxb3x320S9E6w9lDihEqsSXDfaw1AWTAduOIiOV7u
 Bu3LNG1lIZzj4pdbWAcV0P22ic4D7H42BFDyzxQbvVc2c/A9k9Tffenbvgz0d2nY
 oAABeW0jmjIDYJegQsQ6cbebYKWWrkChLoC+IbVSrmdFB2UaS4WZHPOkjRR46xIy
 h4ZyaW+uh+EOyZFNh2u3kQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474dadc88r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Jun 2025 21:51:05 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 55DKovVv040803; Fri, 13 Jun 2025 21:51:04 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2075.outbound.protection.outlook.com [40.107.100.75])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 474bvecbac-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Jun 2025 21:51:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pGNM4SB6d+M6GlCiCNMigWfqBzq2wnUYPufBfjeLy3vYHrpguIabtTczHLG229FXoeWxNq/aKpkaG/kMUpEd66MNSwKadi+RU/IIZZUfh3/yWp8AHPSBV/g//Q2F9Yd/9sUJmZtXp5khD81vwGpSA7eVNYAcFWswjmeFuDlb3pGFYrl+syBJ6qKc8HDl0x56/RpakQ0ZLaQVzRj9hFUFAI8y9nUoXm/1HM4WBJ4XLPgPKsQ+vH/yH2U3uMIzKarzwLujC2H8U1sPxReNOk8bqJwP/WPVcieQriTEFVNl6RV6yh1t1gKhD5BbEiMqN6QhFHlIgJQk2wyyiErXT6rDhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hJno+/LbiF4t/Zldpl7NGVqz0rljFxzjXb7cxcLyU8g=;
 b=lGuu9qnLWtsOQAMR5tDuDUT5IiveNXVDU3/yv+0p/RcwGypcBhFo7ZDMujauXZenR7a+4CVcRaciT+Hqf/9SypxlENSGTbRiqT5SaNKjBTpcs40dQZ2/yHI4+htixftzXucxFuF7aZd+mgXGNxZl6y6oW66d5y0kOEmy3t5sQuTaSYuPpiqXjYhq0FU6CyTRhNEiHeHpCMiizDxij1/0smnIJpovO+pIUsFownQCYfQYqNLpb5hflT7wshsBWQNlO8MMpz7bwG3J55T7SP2qB/x6PKgEaFtS++X3wHB+tHw++eqKnTn38ydBVwhATzzdlvDZDLpWBhi1qWL6AYKsBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hJno+/LbiF4t/Zldpl7NGVqz0rljFxzjXb7cxcLyU8g=;
 b=kVFDurH8PiA0/b44GUrdjZH1NsUFWSK66PVELYkf8bt5GfJyZE9y3aXl3bloWyodSVFBXof/xewXs7+U3+VON2oxlVigmOS4vzi45ailukesUQRifr000yUt/NhQnhKOfPzVGcAO6KtNoS81yGEjesCA0qcwhxVBTVOF3CEBh5s=
Received: from DS7PR10MB5280.namprd10.prod.outlook.com (2603:10b6:5:3a7::5) by
 DS4PPF80E5E852F.namprd10.prod.outlook.com (2603:10b6:f:fc00::d2e)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.26; Fri, 13 Jun
 2025 21:51:01 +0000
Received: from DS7PR10MB5280.namprd10.prod.outlook.com
 ([fe80::da22:796e:d798:14da]) by DS7PR10MB5280.namprd10.prod.outlook.com
 ([fe80::da22:796e:d798:14da%7]) with mapi id 15.20.8835.023; Fri, 13 Jun 2025
 21:51:01 +0000
Message-ID: <9a9ed7c1-b6a8-42ca-8e33-f30d507173fa@oracle.com>
Date: Fri, 13 Jun 2025 17:50:58 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/20] amd_iommu: Use iova_tree records to determine
 large page size on UNMAP
To: Sairaj Kodilkar <sarunkod@amd.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 peterx@redhat.com, david@redhat.com, philmd@linaro.org, mst@redhat.com,
 marcel.apfelbaum@gmail.com, alex.williamson@redhat.com,
 vasant.hegde@amd.com, suravee.suthikulpanit@amd.com,
 santosh.shukla@amd.com, Wei.Huang2@amd.com,
 clement.mathieu--drif@eviden.com, ethan.milon@eviden.com,
 joao.m.martins@oracle.com, boris.ostrovsky@oracle.com
References: <20250502021605.1795985-1-alejandro.j.jimenez@oracle.com>
 <20250502021605.1795985-12-alejandro.j.jimenez@oracle.com>
 <ed8ac2ac-02eb-4f91-9a78-59401e64fdb8@amd.com>
Content-Language: en-US
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
In-Reply-To: <ed8ac2ac-02eb-4f91-9a78-59401e64fdb8@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS7PR03CA0229.namprd03.prod.outlook.com
 (2603:10b6:5:3ba::24) To DS7PR10MB5280.namprd10.prod.outlook.com
 (2603:10b6:5:3a7::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5280:EE_|DS4PPF80E5E852F:EE_
X-MS-Office365-Filtering-Correlation-Id: b3b52da4-6588-4467-94f2-08ddaac4635e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U2xKSHpqaUZHMUNxN2MyYVdyVS8xdWZUd0tlS2hlZUkrSDZic3pTaFBaaXFk?=
 =?utf-8?B?eU5ISDZPa3kxdWJpd3pqZHpMS29FVW9hRlRZTEtHd2lDOVlrSnlCTWRGdSs5?=
 =?utf-8?B?dG91Mm5vZjFNVlNjenBSNWFhWUc5RXVKV3BmY1pEZVpWNXFjM0FSWFJQZEhK?=
 =?utf-8?B?blM2aG16NGdTQmxRTGZXMEk0TnFxZDdLSDNjV1kvZEUxOUVpUmRITllwU1BR?=
 =?utf-8?B?OUFqNlVERW9BUm13WEVVWHJWRzIvcTBZRWN5UlN6MVBOaXpkV0RUdm52SUVl?=
 =?utf-8?B?bnZDOHd1WE9Uc0N0UDRZdG1UeUJuODdiS3ZzbmdBOHl3dEV6WTJLVkpXNi80?=
 =?utf-8?B?dEpEcFBZVldWQmNCNllyTlRhd2Y1NldiSyt1cWFjUWpTV1hGS2dLN0RnQlpk?=
 =?utf-8?B?LzhrbTh2YjhTdERocGtZSDE1bGd3N1daVm5VMVpOcC9LTkZVb0IzbXl6Qi9n?=
 =?utf-8?B?VUxCSTFBOHJQbXI4bTB6UjJYdjQ2Q0FDWHJ5K0FxT2VWdDh5TEpGZDRscy9D?=
 =?utf-8?B?NU9YL1JiUTZld0pGL0w3UVZ5ZzhhSnRzZjRMQ3IxMjF4dkxBOXV2dVd6NHZK?=
 =?utf-8?B?ZnNQaFZsUkNHMUQzOVo1d09zalkvWi80dnNjVzVjZEFOUzI5cXJmVVk1OGlX?=
 =?utf-8?B?MXBsRGJOZmluZE9RcUkweGNwcEQ1dlpwTTNmQUtvRnNZejlXNDlRNm9nSi9E?=
 =?utf-8?B?U3hpRWt6Vy94NmpXdGwzcWVXNDZ4VERIQ0lobFhRSmJVNkdQbFp0SHBWNEhV?=
 =?utf-8?B?S3ByeWF2a1dKS1FMeDVJbmQ0Qno3L0FEdzRMOHF0RnhGdEUxaXI1TDhZRldE?=
 =?utf-8?B?NndLZGF2d2ZqbTdjY3lYZnlqRVVYZ0R5blQ1WmdCTVpGdHpUOU1Bb1JTWW13?=
 =?utf-8?B?Skpaa0VZakFMTVgreDV1UXdPSDZ1NzVlTm83c1ZWbVhrUHUxcVBQNHFWUGdT?=
 =?utf-8?B?Sll5bFVnc0JHS2YwTW9LZjlXSDczOUhPUmpYa1ZGWjlVZERSdm5xQWR3K2ZM?=
 =?utf-8?B?bjYzSCtPNUpNbjNuZmZoc3dTRWlSTlBNci9RaVdrUjVpbkVheUpnUzZXQnBG?=
 =?utf-8?B?NkJ2MXE3VXJkWWRLakhjYjM1QjhBTkRDSHdJQXZVM0pSc2JuQW9mZUp0L3Vt?=
 =?utf-8?B?OXBaZi9uVjBRaTdmUFBHL0tDWXZYeHN4U3RORzZZTWU3TmFLa3ZtYTMyR0pn?=
 =?utf-8?B?SS9yTzNyelpyazFPVVhhcXNWWG5YTWU3N2Y2a1BObzVBYlNvOWZoVmdRTnV1?=
 =?utf-8?B?bEg4NmlSRGlpQ1E3TXJFNG9CSFdvVERSbDJ6c011QlBHMVhreDI4d3psNUl6?=
 =?utf-8?B?WkVTazY4UmF5czNweXBXMTZkZFAxMHJreHJ0OTJjTC9nSkhMNFNVTTBDbG1N?=
 =?utf-8?B?KzVRcXRwOUU2RnI0NnVGZHNlYmNKbUZFb0RwUVBZcEJOVzB5Mk9xZG16R0x6?=
 =?utf-8?B?cWR3Z2RzMUYyS1d0bXNqbE1SMVExYlpYcERESVNrNHlMR0VkVEZNdUxlTGdo?=
 =?utf-8?B?TEJINGVkTGRkZmRNcC9YdXdIcTBtWXltZ2NVUU0wa0Z1djN0cGt0Q1hSZi9D?=
 =?utf-8?B?djNJZ3F5MENMbU5mVVE5V05LZytWQlJSUWtYa1RXLzB6WEN0bWFTTERIb3or?=
 =?utf-8?B?YmF5d09WVFhBWFFmWUxjc1oyL0tvTjZBZEFza0l6OGNQbUNnU0c3WE5odXpK?=
 =?utf-8?B?dHA1akFsemhneFBXdWZsK2xCcTBObzI2UnZ6cmpvMThvU3A2bHZIdWowOVhG?=
 =?utf-8?B?MWtPUUJra0lJNVE5MDAyUXdzZ3NRMzNkLzBVcmRnNjBBWlVzcWN3eHo2K3lU?=
 =?utf-8?B?WTh3WUdLd3RaenFMbExZaXJ5aE1CSmdPMkx2TUJDK0lpU0dKSFYzMWpaazRF?=
 =?utf-8?B?TUJTS0dRUDFZblpzRkdZakY1OUl1eUJIdlFhMUxLK2ROSFJGUjE0djJwNW03?=
 =?utf-8?Q?uLE3MDfkSXU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR10MB5280.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2EybjdHSCsrVUVHSUtDZGVHV090VFZuWlV3VEx5SUh2SGFBSGdNaytTQ2dj?=
 =?utf-8?B?MUpnQUxHV1RweXJ5Wjljc1VtOWZwMVdJQXVYUm9GWWFKRktOZXRUNFp3UFNP?=
 =?utf-8?B?YkpMZk4vU21iY1JXdGUvSGZuUzJaV0M1RFQrdnNtOGlPOW83dmduR3ZaU1dP?=
 =?utf-8?B?TTd5ZUpiZFM0OVN5QkllNmd6bkJMeitPZTExaGdXTFBFZ1d0MjJ6NXlNYjBa?=
 =?utf-8?B?OEtkUHVUM0FJUTY2Ky9EVzhYSFVCWFdDUzUrcE9nalE0N1R1MEVRUm4yeGFC?=
 =?utf-8?B?WWdMeXFVVFltZ2k2UFM4OEdSN1ZaOXU3Rm1VcW9lVVVEOVEzdnYzdVNJdk5u?=
 =?utf-8?B?ZElxZDBBWXdMc2ZRY21SZGpyOWM5bHJsNDgxblZpTFh1VW5wQUM1UW54RzE2?=
 =?utf-8?B?SVkxZmNqb2s3L0NDaTQxaFlQendPZ1NKMUlPMWNsaVNRSlFvSU10K2Z3M0R0?=
 =?utf-8?B?aTY5VDhOeXJVMGZYcnliWmd1RThhOGx4Qk96K1VWMWs2Y2dlbkxIaUVNcHZr?=
 =?utf-8?B?c1QwaEliMEI2ZUNXcFBuSDU5OXdXa3NWeVZwQWJGcll0cmZ5MzdNSTZzOUtw?=
 =?utf-8?B?QlM5MVVKTkEzRWVRUWZqL0U5TlpuUUF0TjBwbGhNakM3MkYrZmlHVGtqVmpm?=
 =?utf-8?B?L2E5bjRmSnRwWTRIaGhndC94UXFhL2c1YkVSVlJOb1A3c1I3KzVIeDIwVkY4?=
 =?utf-8?B?UFdIUTk3UjVYUmdmb2lnalhIaWtGblFkS25GeElqa1p0bmFHOTRYTEo3Y2JB?=
 =?utf-8?B?eStvR2JXZnc0eWlWNHIzUnByeHl1ODJVWUZ0NFJQdnl3NHVXQnBvSTVJT0Iw?=
 =?utf-8?B?SmQxVnVWb3JBdHNlZ0Fhb1E3NHZ4Q1pHQkZyRk81RXFMNE5pcWcxSEhVVUZX?=
 =?utf-8?B?NDM1ZFN5RFljN2d0OXp5MTNrU1JRKzZUUXJESnV0bnJMMGVhMVRHN01XQzB6?=
 =?utf-8?B?L2pUcHZtMGpic25oNVJRQkRzTWFuY3Z1YkFxMFh3Zmt6dmZUQWdZQW56bysv?=
 =?utf-8?B?RHdqOGN6ZVMzTW45VUIxL09XKzV3eHRFTklGdSs0M3BDazZOL1psZnhrNllw?=
 =?utf-8?B?bGs5N0VuWEdzT1RmSGxuL24rSHk3RGlXQVVtcTBxOS8zMDNZaGNNcUt4Q1h6?=
 =?utf-8?B?elJ1WmRRNFNmc29XbEQxMVc0d2hMR1M2MFA5NVBJVVAyMm5rVm9UL3o2akxn?=
 =?utf-8?B?TFJHY2phV1MwS3JZZXNpZWVhRDZKSmJ1dkU5T2ZoQS84ZmNQM2hWU2NUSkJW?=
 =?utf-8?B?ZjhCczFYNENjMzVuYjZpZDczUDVERllsVVpwUmJZYUdBZEdOeS9SaUFTdUQ1?=
 =?utf-8?B?cTNOdE5VMTg3Y3liRFVjOTlvSU5jWFdGWjYxbE1oL1NJcVdPOVJNbTlUeGwz?=
 =?utf-8?B?SjFmR0RRZ2JGd1hhVVBRdkpRWmp0a0RSYnZvL05UaFpqeHJvVWtVejRFN0Js?=
 =?utf-8?B?NExwQURaeG82WTJQSGFnaUpxQU1mTjZJdkpNdjdVMHBTSmwxb2ZmdVpjb3o5?=
 =?utf-8?B?OTdlRlNvUjNGVS9taHhRL0R6ZVY4MUs1ZFdIVExITk4wUHBOQ092eGQ5eDhY?=
 =?utf-8?B?N0orUUVvYnNpcUdxdVRmRFZtV2w3cWJiSXR4Uk9lalREcVBqclp5dnhRdFNl?=
 =?utf-8?B?VlRKVVJEQStZSk9SQlV2c2cvRVFUWjVOYVAvQUo3VFcxcE9DRXVKcC9NdGZL?=
 =?utf-8?B?WDZCVmVsQWxwd0VTWnpOdHJpaFdHY1AwY3Vqb3VYNEYybzB2all2TFdaWUM3?=
 =?utf-8?B?UkVaaHlKbjVaQ1drTHRtMmdFWHZ2R2VpVlEwZFhUZVAwQ3U1K1NaVG5vbnkx?=
 =?utf-8?B?Y3Y4eFFrcXh0TXI3ay9Rc1VvRjhOYktkWnFtUDB1RmFpZzJCaFdPbmx6RjJp?=
 =?utf-8?B?TTkxbWExRmcwRlNWYWFSK2xGdkpIaU92Y2huWFZ2MTdFSHBqN3lCc1lpdnhl?=
 =?utf-8?B?NXZNU1Z3Wm90SFBNTnFBejFDQ3NqdVRyNWNlb2VTTGFoYUg1QVFPQlY4dUhz?=
 =?utf-8?B?ODJKMFdBTmI0QTlGcDZLQS84T0dKQ2lEUTNRSVp1TXBYTTYxS0wzOWZUaVBT?=
 =?utf-8?B?RkJvZFdYeUhib2VjZUN5SVhJZlVjenlnSEpCQWptMGkzaXU3N3hTRWQ2V0lK?=
 =?utf-8?B?c2hPVGkydUZDVGlGcHNPUngyTUYzeXB5eGQzSjcwckZqUm5BM0NJRWM3VjM4?=
 =?utf-8?B?V3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Xo/4D8HppAZ8y3N8/Pu/m1xa+lDwfSgrVSYMcoPvbqi5Z932IN4hnKM2aMpTb3oPxY5kNjiKDLqH/0dXm+wUY6NVy82c1aAXA+PFldCkDEbv4Z/akWd/EWsyj+g5ZKFsOyBvOlc1l+u+FzxyJ5nt2W1aShs9KLzxC7eNeJEwveOoedpWriET4EXZWX0mFSZZgcwU+lG2H4zOKA6m3Zvo02wHl973RIZhL/3YzyFiHbTe7D+iQ4CS6G1nS4s6/TcbK71cutEdEtdYWEPEWDmaVqPupMPvElD2MIoowgtlLPDf+UPOIF8j9r343ODoxAGadUI3Dr8JYtL69wFzAyOm/D30lFfUcVwUXOXt3ZwwrRHWCK90ECK6/nLBVYOUAOpOqHEsPxss0yB3SakNuE1JMtB/RkyqBLBVen5HiQL8OcPEq07KIoLT2xQdRNpVak1v1836fZfk0NZuJ2q5mbJbgEneGRIDtqy25faCkM3JbUvJ1NVskq8QuRRWSn5SjgJwj6jp+1lujI8VwmOa9Ge3gK5lxck20ItKTPvMohirtvGblBSYcJIT33RMEHrJyGNMvRsqzqlEoIMPfqxF+hxeFzgvjCI5dxS8KQ25YLXcOwE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3b52da4-6588-4467-94f2-08ddaac4635e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5280.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 21:51:01.7741 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0lKnD9de44iwXzpwYyzxddIKpm+v5a2Ux60VZ5B/CbmQ6JJ1Po8IPaMbJjfBMGkwuLuo17aw20VniJUnPo8BjjECVY83j/lr+5t4rZ5E2jU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF80E5E852F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-13_03,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 adultscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506130156
X-Proofpoint-ORIG-GUID: W3I7ZI7IlQ9nZcSUaX0zT9ImsnsP2Hsq
X-Authority-Analysis: v=2.4 cv=EJwG00ZC c=1 sm=1 tr=0 ts=684c9d49 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=pSBqwU8xm1H7UWPwP54A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEzMDE1NiBTYWx0ZWRfX/uqPw+DsNc3/
 hY354GP/G1TCmkAI3suPPyBK0DYoHM6yO+5+UDTgqw4knE3pMYDStMf3Q1esLgDp1RS8AF+2b9G
 ff++l7mnZpNTO9/iCZ5uHhu0uonz6Wq18DAY6hDm5ulVvT8Yh/2V5lD7dyZcK7+bMHgdCc3/duJ
 e5QsB/5y/N2ck3KlcZMlltB6Z+xtIb+P5Yx4GhO2SjcwDXLa8INN3jVoXAkmifI/O6vyQ70K24e
 BUCvJRNt61n8rrAH+LSv9RYAYNBP7+rZ9kpcl/ESBn7enhd7F5EZBpNI6u/TA61pEegaNPyM/Fl
 2UhMUSueDCt7hYGBQP9aojBlpz2g9fH/I0wzKjtw6xdU1bgoSMuCx49vqJsvyFhwaKK+pi5arHB
 QEi6WBzbf9Xc36dAkZxEMxy2LFoETUJMBL//mMkHXStHcrxiDSJe5PYmUDY+y/WOpXMv5wVs
X-Proofpoint-GUID: W3I7ZI7IlQ9nZcSUaX0zT9ImsnsP2Hsq
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0a-00069f02.pphosted.com
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



On 6/11/25 4:29 AM, Sairaj Kodilkar wrote:
> 
> 
> On 5/2/2025 7:45 AM, Alejandro Jimenez wrote:

>>   next:
>> -        iova = iova_next;
>> +        iova = (iova & ~(pagesize - 1)) + pagesize;
> 
> Hi Alejandro,
> While experimenting with iommu.forcedac=1, I found that above line 
> causes unsigned integer overflow for 64 bit IOVAs. This results in an 
> infinite loop.
> 
> Please add a overflow check here.
> 

Good catch. Reproduced it and tested the fix; will include it in next 
revision.

Thank you,
Alejandro

> Thanks
> Sairaj Kodilkar
> 


