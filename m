Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F31DC4345F
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2024 11:51:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s28U3-0007Z7-6k; Wed, 01 May 2024 07:50:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1s28U1-0007Yj-24
 for qemu-devel@nongnu.org; Wed, 01 May 2024 07:50:45 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1s28Ty-0001Lc-SG
 for qemu-devel@nongnu.org; Wed, 01 May 2024 07:50:44 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 441ARouD030601; Wed, 1 May 2024 11:50:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=bUVhRVrdcnANhe1batkEwR7M/kD0bkL/4uO+VWVYw98=;
 b=U6OElBh4ziyJJtJOJ1/qiQVHLJiZTPFnZJuGyNffN4RlbmpWJOR94Fro7qd8dpyONpS/
 jt7QLJNV/q6huvm414e4MhH3LEyu7zFemd8kkiYjQLKzR6yTSOU6bUwD8M+JorkNqsw3
 trUGorXDXUofX3razbFv253QIwL89wbwQnhkY1plaZeEkdnYd1lMbyAIEU0JShQIRrfX
 LeX/3sKiRK3ADaZHMA0K11T17EhdCGRMZzoYMlNqxvTTNWc782Pe9v+9OICWbx79Zmjm
 473iqHEnzNFw7NywtT3jrBK9lW36pc0pL6zQ6N5GQBDqDG/nDQyXfnB5WQjJDk8Cw8UL sA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrqy2y4ss-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 01 May 2024 11:50:34 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 441A7fHS005116; Wed, 1 May 2024 11:50:34 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3xrqt8qm2g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 01 May 2024 11:50:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nk8F80QmGIBA6UbDN8/Z/Rvuvd0ECFoV0JRfDPKM1h/VoeUh/srw7CoC4s9U3h5JOHFtXKTJ34HMhCWj6ipUbUuoGnosOUl1AP0qvocV3loVMET/Q9Iaf9eUXIc+jSOejKn9FSReqvtmH/NqbjjROElQ9EvvvUEVoWBlrQsKgla99acAXlM5I54llvVA3oa0WoqI6HPt+XNz3oJsc0itmljxNeM6zV+mg2GG7TiFv2ScWrIgjuagLFuiWNhMslLnlWEGX9TEoFnbbuIfpcJOB+gFUx35EHt1mIFWkk8KYtdQ/MZkEPwqWhcncyg0VhwzxLeEsVY/hpJihb9owQaYhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bUVhRVrdcnANhe1batkEwR7M/kD0bkL/4uO+VWVYw98=;
 b=QaeuHwq6xZUqqe7bgFRaK0Fwtl11UxwhybRXsBeN30bVEvY75/wUqfV9vAJx/0aCTlJBxQd3RO4/ASeQYIASfw3Sijpy6KgNAa+4ujr9e9/zIODifInjsuwBqHhhGexmUztWBkBkH+4AwAo4GFNudRzniM4ZbkMIZW0zqHlyJbMtgo1AOIFPtd+pKwfcj2d1XC9Du6FuI+wa1wSLMk8Em0z34dpR8KFfodXQKPGN+Vu68klSB3u1mdO/5ShcsGKcjfNJaymrx2kR3B0jsgy+AjDdteghGHkk9whvmXqa8rIcX20EvXEwHEN99fDBGTh2sl68mcDIiIxKoYj6LDpdYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bUVhRVrdcnANhe1batkEwR7M/kD0bkL/4uO+VWVYw98=;
 b=fYLlmCgtAy9QKZYga3SgGlGnMELxPS07Q1xgtyGjw9wvIIF25flKMFHRrZT8v7xtNbZ7Nk7wkCdL+MxBB41xy3RG8YLVLtH3kXZSaNZd9mAwOL6BrIVC4BnFe/zAn016PiOeFsoIuZ3xaaN9DO1FnhTI5IJnmknGFfeP337wB5Q=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by DM4PR10MB6816.namprd10.prod.outlook.com (2603:10b6:8:108::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Wed, 1 May
 2024 11:50:31 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::de7c:2c87:8c7f:e14e]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::de7c:2c87:8c7f:e14e%5]) with mapi id 15.20.7519.035; Wed, 1 May 2024
 11:50:31 +0000
Message-ID: <fd972eee-068e-489e-ab45-e1985115a128@oracle.com>
Date: Wed, 1 May 2024 12:50:24 +0100
Subject: Re: [PATCH 1/3] qapi/vfio: Add VFIO device migration state change
 QAPI event
To: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Eric Blake <eblake@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Maor Gottlieb <maorg@nvidia.com>
References: <20240430051621.19597-1-avihaih@nvidia.com>
 <20240430051621.19597-2-avihaih@nvidia.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <20240430051621.19597-2-avihaih@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PAZP264CA0100.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1fb::9) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|DM4PR10MB6816:EE_
X-MS-Office365-Filtering-Correlation-Id: bb721c9a-cc96-4d37-7c78-08dc69d4e713
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|7416005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bGhFaEpOU3lRcHRVRmoyVkllbUUrZjlzQ1YxMmVyM2VmcVJKWGQvbkUrVXhp?=
 =?utf-8?B?YWllZ0N3bkEvSExCQTVVUWxzc3B1eDAxdldPTWEzdS9FODJYWWVXQ3Y0UHBH?=
 =?utf-8?B?UEx0R1BoaUowL2FoWUpZaGEwV3pVRnc1YXl1QU10MmVqdkVkRlpuQUhmTG9n?=
 =?utf-8?B?SUJMRmhvUzdyaThpL1kyTlVHUXcrUVdDWERzUUNkTWwyYTRUK2NLcUR4cWVo?=
 =?utf-8?B?MHNTM2Q3czFRa2J2ZzRYUUpJL2RXYmdRWDdSaWEwRWhFRkNHNDQzVjJ4K3Nk?=
 =?utf-8?B?WXpISXNqcUQ2cnU1dEIwOEFqd3pWY3JsVDFONzBYL3A2WUVHQm9pbjRaTStL?=
 =?utf-8?B?TXFSZE55WVRzTUZDenp5M3oxc2NwclMyTDg3OTViT1JXWHFkOFRQK204Wlov?=
 =?utf-8?B?OVdQeFBsaWVRb2NMNHNMUERwVkt6Z01xNXNGTkpaSzZlTGJaUk45M2RubGNY?=
 =?utf-8?B?TGdGekNEUnBTY1hYa3hMWHVNa3pWcVVnbXUwK3hybHMvSHhSd3JkZG1UaWds?=
 =?utf-8?B?cW5EZ0locER3c2xYdVZ6aHVPSTlzeVJOTEFyYWFYL0JQbVFtUnNEejVreksz?=
 =?utf-8?B?KzNKbUIzQ2ZvZnZFR0pLQjQxVm1nNGtrM3o2Q0dWaDlJN25RQS9WUHhrOEo3?=
 =?utf-8?B?YzVLZnh5Rml6MzRYU2N5TDkzc3YxQnpGMUgwU2xxUmlqS2E3TlNkRGhib0lv?=
 =?utf-8?B?S2tZRHEwSUJXdDJYMkFoQjR6NVJDaEhGMlJsSXJSVWszRkNqd0dEdkJmTGox?=
 =?utf-8?B?aUZEdHp2R3hTQTdldzFJam5IWWEwQ0dvZ2lEM0dacFhVNmpxaUUzV082aS8z?=
 =?utf-8?B?bVBVK3pwa3pzb3M3UXozYnAybjI0RFlBMnBmRkNXOEJaRk1EcFliOS9aVE8x?=
 =?utf-8?B?YmhFRldva3lCUEtwT2Z3QlJoRVJUb21ibVVzRU9TYTVzSHE0Q3BvSW9rRjBp?=
 =?utf-8?B?aGc5YnpESWlWVmxxQU44dVBpeitTeTF5eSt6eURMLzNOejh4cDNuaTdJc0Y3?=
 =?utf-8?B?MlFibFVNb3h6djBxakZVSXNCa0VHbmczWFN3UjJqazlEZ05hdzBEamtZbEhq?=
 =?utf-8?B?Q1VOK3B2ak1SVDRweWtZRHBTekFSZXltN01SeW5aQ09pN1B3NGQwYWM3cGli?=
 =?utf-8?B?aHllUTY3cHJIZ2l6dHBkVFE3VnhEdTc3bGZKOFA1S0JGS3pUZkxROXlma1lX?=
 =?utf-8?B?WmxrcjE3TWlUVHJuYitYcHJESmltdXFGbWlyVHBZbng0a0VqazZrZ2ZWalkr?=
 =?utf-8?B?OXV1UCtSWGY2M2FFdk1sZHpUMHlDblhWOHVETzkyNWJvTEtGeit5NHp1STRE?=
 =?utf-8?B?YlRoRklVNUhqWHVEeGxaV2tKZElKS3NlZWEwVXJ6NmFkQk5zUE9uNE44L1g2?=
 =?utf-8?B?ejZ6bUs2d3ljVVBiMTQ2SUN4Wnd6T3lobWpQcHdvUjFib3ZYWGMzYjNCQnJD?=
 =?utf-8?B?cHFSMm1wcXg3cEZhaHVDT3Zra2Y3cG9CdzVscGxDREhpZnRaSDFFNDBSZDRz?=
 =?utf-8?B?WER5MEM3ZVB1dlY3L1lZZGlWeEdXZnRVTGR4VDZaV3VLVVJYc28xR2RQbEtW?=
 =?utf-8?B?bVRCcjZKY2UyR3BFL1l1K1B5RXVVblVsak42aC8xOWdNcmRvQXVQTzFobWVh?=
 =?utf-8?B?TEsyS3lieGl0T0NLb3FubUQyZXc5NjE4UlJhdWN1QTZHckdXMHBXeFhST01X?=
 =?utf-8?B?V09BZGhxOWtpT0I3UTZwei95TzN0N3RjTUQvWHJQaVMreGlUL2FPdnRRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(7416005)(1800799015)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cUNKZlJSL1EvejR1TFF5RTRBTEc0SHZuaFl3UjQvZUI1UnlCUE1JYTFMd1J6?=
 =?utf-8?B?ZWpvUjU3U1k5N2luVnZBMVlKbzJBNVZUY1hvK3kxQjUxb0tEMFJVa09rQ2xm?=
 =?utf-8?B?Z1NONGdyWjVPZmNheXQyenk2QklNUnN1ZkhQRHpBMVcyMDVhdGxuaDY5UGJU?=
 =?utf-8?B?VDNhN01QbzMxdndaWTJuRWlxTjZZTktIbTdUcERXMXllRGFnSjBjSWtCSUI3?=
 =?utf-8?B?WVh6aHJUT1BIc0IyNWhQOFhGb2x0WmdnTXBHMDMxQlhxU1J6YWdpYml0STN5?=
 =?utf-8?B?QWxva25sbDVvNGY2LzR2c2RSNktaQVNQYjc0ajlPRGo3cm5mcWFVQkpmQzVP?=
 =?utf-8?B?SllNYnM2cXZqS0hQdGZvOXZSdldBbVNiN1JmajVVeG83cUo3cmtLUmNUTjZH?=
 =?utf-8?B?VkpGNDVLOG9EN2hHWGEzalorWWpaRkpIK3RQK2FDdUR0c1E5ZU91WFJqRnVy?=
 =?utf-8?B?Sjg0dFNjaW43Y1FxWXNDUDNTaHl4VENzd2tzUXREeUszQndIb0FpV1JYNHhu?=
 =?utf-8?B?eVhaYXl6SnhaSWNTNFFBaWY2WmJXWVVQdTM4a3p6QXNlUjBOb3V5UTlDVHUr?=
 =?utf-8?B?WVhyR1VwMExpK0F4akhXcGJ2UXhSczVCUVZaUTZTMkY5V3FJdStMazFIWjRQ?=
 =?utf-8?B?eklTeFllOS9pZStSSE5nRGxwU1BYUjhFOWlPZ0V2WWxUbW9FOUtwTkRITXY3?=
 =?utf-8?B?dDBXTnBHZEdEdVRmWUxLaEIrK1hEbkIwVFdBR3hIYjZON1JQT1IyQldJMzlJ?=
 =?utf-8?B?WElEMm5jQ2RzUEM5dENTc0dYRTYzOWNoMDdHalZFMXFIcndtV1didUpkVlpy?=
 =?utf-8?B?Rzhkd0Fsa0dmMkdZS0hzUHVHa3drSkRndVlnTk9ocW5XazhxRmRrWGE5UmRK?=
 =?utf-8?B?Kys2cmI0SDh6ZHY4dHBNSjJlaUFaM29EN2FwaFQ5K1lGVUYyc1ZPWk1uSC81?=
 =?utf-8?B?WkorZ2hVNmVJTnBJVEowanc1WlpGU2dQcjFlSHhaMjR5aG11Z215TFNMdmdR?=
 =?utf-8?B?OGpSbVRzcGFvcklxSU5SZHhWcmdhN0pVNXlxZFF2TUxZMW54aFMrK1MzNEsy?=
 =?utf-8?B?bU1UWWdwMEVGNVVhR2xMdldmUTEzSUtOY1N5MlU4S1pRQnVoNXlwcU9ZTWdD?=
 =?utf-8?B?aWRIN09sL1NCM2RIeWh2Nzc1dHlodDBCRXdZT241RXFQd09vY3RSN1pkU0Fh?=
 =?utf-8?B?RHlra3o2SXRIeDhHd1drblZVT0VSU0xKZlNFUXhGbnp6M3hXUG5lNER1VGpW?=
 =?utf-8?B?UURZWE9US1FrVUV2bTNhd2g3dDF5MEVGMkY5SFprS3BVd1h6dEVNSFhwTmZK?=
 =?utf-8?B?RWZtd0VlaksvSFVheXFUM3FyWVFVUTlNLzZVeU1iYmZjZ3k5NVN4aW92Q21u?=
 =?utf-8?B?OU4wbmJXRVFsbVBZZFV6SEwzYXZ6d3NFbjFjYWZLWk5aaWZaNXFST2locmpV?=
 =?utf-8?B?QWl2MGNvOHZGb09DVE9mN0Vhck5NSHlRQVVtdnNmdlQ3RUJpckk2R25HUHFE?=
 =?utf-8?B?Ni9SMGlOeC9rdjZnblpUdSsxQUtzZURYWGxvK2RCQzJIUUhmM0Jxb0pWYVIz?=
 =?utf-8?B?MS9GU003VzgyWUYrOTBQWHplRDQxU2dFTU9SM2orOFYza0dOcXl1N1dudGFS?=
 =?utf-8?B?aUoxMXA3NlBUd0VOTldQeCtFbkMyTHMrNmF3dmVJVlFvd214TFgrWklzYkpx?=
 =?utf-8?B?Z0U0d3hhTzdnUXRSWlJ4cDIwUGJiMjJBWFRwSEtjS052SHV0ajZTMUVoTUNh?=
 =?utf-8?B?UWhtUlRWL291OWJHUFc5NHR2cmRoS3Jkd29ZS3cxdFl3c2x1K3d0OFA1M29U?=
 =?utf-8?B?anduQkpsTXdsa21OQ2NTendpZGM3MnNYVEhXZ1FkQUN3c2JlWHcvbm5yWUV0?=
 =?utf-8?B?djlqVlFDVmJPeEFxVlc4eE80YXdMOEtoMkJVditrOVI1NGJLdUFjR2VZSlcy?=
 =?utf-8?B?eVlVemgvV1crb1dUWUs5bjVFV0QxZTVUZFV0dnFSd05WdXk0K3VoNHArenFs?=
 =?utf-8?B?RGxDK3hpODFicWxTQjB6YmlNZkdsRGtRV0ZkVHpBK2dCc2VTbjA0Qk5pN3Zy?=
 =?utf-8?B?cThNc212R3YvWlRwT1lONzFqUFBLWUJSK2thY2RTaU5qdWhGcTdYUGFobnhO?=
 =?utf-8?B?N0k0K24xOVJEUi95TjRZLzR1Q3NoSzNCNVJxNklaMC9Qd0hRN3M5eEJ0VjRT?=
 =?utf-8?B?a1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: wnOE+1wN4kW3z+pQMtEQ1V1wBj7HBXR1j77isuGu1gaMWH4MV2vpJCVeWiGnZHN5JtdVFs0MkQKR8Aleq+/DqDWDkgr6DjVxf/wI2SGwq2J8h+VdndzpRTLs2HiyTjLHiCSI72ep35p0cEub43lTkc81pkd7dHm0OX5jk1ebUrnaSLs8VFOcNbPbMR7FUQdxWki1SjI8wGo7e5OXrCeValztta1iUCsI2Ro7KLqvNaRtIWZ0rNR4SKw2V+yyqa+UWyhbi/lPyOsxncdoWu3YZpmPcxJW3hPoRfO1INLDrJlbeArat3GNg9IZ9gj6V7DGzMfwsVHWKUMk0sVPpOKCeOt2F3XO853WQ6VM5rx8h9S9fHPWUum/jVLSDokV0P9LxNWDbr9GzNADPTzxGDI5VaDH7lDOqBM8cPx9rO9xCP+V8p7lRJ5QPTdRSuL+kfqk42tLsb9fClLybY1X8TZtzj7Ij3uisBtLmDU2CofISxAeWydBeVCTTiiYK2EW0hsT+NEQkZwgb2j9N5dAViTu5WgCafvWm7bx5h5i1tm1+t8Zb1eXFZmd3jTs/kwooTwyEA101xXO2yvIxtyjcj6sT85MROv0+jGHj8kT8LtAn7c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb721c9a-cc96-4d37-7c78-08dc69d4e713
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 11:50:31.3360 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MiQEPvyTze1EaXfC+2NLrpkdNDtkQseiFfDycM/+XwB4li/+r1EdcJAXjt7ig1lrp0X8xNheomgW3BCYrHEFaYjAyBha7BhFBBpTVQ0+FLg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6816
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-01_11,2024-04-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 bulkscore=0 adultscore=0
 phishscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2405010083
X-Proofpoint-ORIG-GUID: TycbXPM2UyGbuJsGuDlasOnIVQmdUsE6
X-Proofpoint-GUID: TycbXPM2UyGbuJsGuDlasOnIVQmdUsE6
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 30/04/2024 06:16, Avihai Horon wrote:
> Add a new QAPI event for VFIO device migration state change. This event
> will be emitted when a VFIO device changes its migration state, for
> example, during migration or when stopping/starting the guest.
> 
> This event can be used by management applications to get updates on the
> current state of the VFIO device for their own purposes.
> 
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
> ---
>  MAINTAINERS           |  1 +
>  qapi/qapi-schema.json |  1 +
>  qapi/vfio.json        | 61 +++++++++++++++++++++++++++++++++++++++++++
>  qapi/meson.build      |  1 +
>  4 files changed, 64 insertions(+)
>  create mode 100644 qapi/vfio.json
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 302b6fd00c..ef58a39d36 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2159,6 +2159,7 @@ F: hw/vfio/*
>  F: include/hw/vfio/
>  F: docs/igd-assign.txt
>  F: docs/devel/migration/vfio.rst
> +F: qapi/vfio.json
>  
>  vfio-ccw
>  M: Eric Farman <farman@linux.ibm.com>
> diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
> index 5e33da7228..b1581988e4 100644
> --- a/qapi/qapi-schema.json
> +++ b/qapi/qapi-schema.json
> @@ -78,5 +78,6 @@
>  { 'include': 'pci.json' }
>  { 'include': 'stats.json' }
>  { 'include': 'virtio.json' }
> +{ 'include': 'vfio.json' }
>  { 'include': 'cryptodev.json' }
>  { 'include': 'cxl.json' }
> diff --git a/qapi/vfio.json b/qapi/vfio.json
> new file mode 100644
> index 0000000000..a38f26bccd
> --- /dev/null
> +++ b/qapi/vfio.json
> @@ -0,0 +1,61 @@
> +# -*- Mode: Python -*-
> +# vim: filetype=python
> +#
> +
> +##
> +# = VFIO devices
> +##
> +
> +##
> +# @VFIODeviceMigState:
> +#
> +# An enumeration of the VFIO device migration states.
> +#
> +# @stop: The device is stopped.
> +#
> +# @running: The device is running.
> +#
> +# @stop-copy: The device is stopped and its internal state is available
> +#     for reading.
> +#
> +# @resuming: The device is stopped and its internal state is available
> +#     for writing.
> +#
> +# @running-p2p: The device is running in the P2P quiescent state.
> +#
> +# @pre-copy: The device is running, tracking its internal state and its
> +#     internal state is available for reading.
> +#
> +# @pre-copy-p2p: The device is running in the P2P quiescent state,
> +#     tracking its internal state and its internal state is available
> +#     for reading.
> +#
> +# Since: 9.1
> +##
> +{ 'enum': 'VFIODeviceMigState',
> +  'data': [ 'stop', 'running', 'stop-copy', 'resuming', 'running-p2p',
> +            'pre-copy', 'pre-copy-p2p' ],
> +  'prefix': 'QAPI_VFIO_DEVICE_MIG_STATE' }
> +

Considering MIG can also be interpreted as Multi Instance GPU elsewhere
unrelated to this shouldn't we be explicit here? i.e.

	VFIO_DEVICE_MIGRATION_STATE

... to avoid ambiguiosity.

> +##
> +# @VFIO_DEVICE_MIG_STATE_CHANGED:
> +#
> +# This event is emitted when a VFIO device migration state is changed.
> +#
> +# @device-id: The id of the VFIO device (final component of QOM path).
> +#
> +# @device-state: The new changed device migration state.
> +#
> +# Since: 9.1
> +#
> +# Example:
> +#
> +#     <- {"timestamp": {"seconds": 1713771323, "microseconds": 212268},
> +#         "event": "VFIO_DEVICE_MIG_STATE_CHANGED",
> +#         "data": {"device-id": "vfio_dev1", "device-state": "stop"} }
> +##
> +{ 'event': 'VFIO_DEVICE_MIG_STATE_CHANGED',
> +  'data': {
> +      'device-id': 'str',
> +      'device-state': 'VFIODeviceMigState'
> +  } }
> diff --git a/qapi/meson.build b/qapi/meson.build
> index c92af6e063..e7bc54e5d0 100644
> --- a/qapi/meson.build
> +++ b/qapi/meson.build
> @@ -52,6 +52,7 @@ qapi_all_modules = [
>    'stats',
>    'trace',
>    'transaction',
> +  'vfio',
>    'virtio',
>    'yank',
>  ]


