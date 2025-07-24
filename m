Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE588C83F26
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Jul 2025 14:47:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uexDT-0004cI-UH; Thu, 24 Jul 2025 10:46:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1uexCi-0004Xd-GS
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 10:45:59 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1uexCf-0000n5-BN
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 10:45:52 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56ODRSWK013384;
 Thu, 24 Jul 2025 14:45:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=hYwe7GqEp9zDcDNsE1QORztGvJZAUXF1kstJLBwD574=; b=
 B7owGKfEkEX1q85nt8qeIpwZvkjUYI6dO5xoQdr1Aqr4IcJBzvdM4x8TO9ZoWkhn
 PvQ0gEQIAcjMISIHlnjL5q++6jF9FRYMhTRirzjnJn2Vrmz3kyFEU/QVibiU+p8C
 KfrNdYdKxtWtlTHDqMDxOFugDhOIkQOYOLdZbHNJjo7EGKXPnr1iAZLma/dyXQ43
 ZLf9W6IejkUG/TKLYXKAtvU8ArKqupMvJRlOjK1H9CoATE7IUbMWIgGcl4aLGgYO
 g67WlcGo2qSifc7UV87iO7arJwpC0/ACTelELn20VFqGf6jdt9FXwwLFIYmxwdRO
 vAGo5WDJ0wxB/Z+4DUSI3Q==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48057r1wnn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Jul 2025 14:45:43 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 56OE2MGL038445; Thu, 24 Jul 2025 14:45:43 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2076.outbound.protection.outlook.com [40.107.212.76])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4801tbyvw4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Jul 2025 14:45:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zHFhPkm+PXWeGr3H4RkfBdMr6g19Kq1FrpFNYORhtEhMu55AyDl6E6iMf7N5KCI42X7fSBNU3voL6O9KIvgJp4reEipxGxLIiZ2R5R+KeF8/vRtG3q481a+iG7cK5b6K/EWQQpJlVSs0nX2IFMhn3lUOysewdAiAci13h87aPj7SvrdEcZ17GASzHh9YFJ035FGFlY07wLa9UppSJ1I5pvOBY8SXWLRDPIIhqCdiHh1R68ouKnjSc50d+StucZy6xwAQpm3hAlzbwyxTpg/UhhyBLnRkraoJneyvNLAEu19R64BcBUGLlwxrkY8y/EdBgAsz2LAIWhMkOdXMpr0Bvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hYwe7GqEp9zDcDNsE1QORztGvJZAUXF1kstJLBwD574=;
 b=gh5HQhJuCewvdXuB353bGciEvXndpvG+lwJ7zhg6jBtGjiE+v6hmBp0kaqOVTKKDoJ4OfqBERe7p30syhVmq/MT6PyMHkmlTNNq82nYeZCJqYFq0FdRH7i4ceQgVQ53U5Y8fYTWxskYCzkBKwKW1IRa9u25IB8/XfD+kX/0/HsLkfyYw0V/wdb2h6Fak02t5kgZdwkEL6sPvv6e1UHQOFnGV2lveYC55IF2d/+xaCjLd/xXxbRN2bMQ46LMmp9xcUY9637yiWw6WNldICsZhsI7Oni0Sr/l5X8aQ3Z7Jc1w66kY368JUZxNDwRRLyQ9/tF0pGDR8dn53LVV+VGwgJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hYwe7GqEp9zDcDNsE1QORztGvJZAUXF1kstJLBwD574=;
 b=VALbhW7tefzb4NjzARQ8XXFYb4Ukqc/VeTJaVqFXz3aLsflDNb08ySoqWuqjTXcVigYte9K8W3SNfeSfbRwhWw09lUQ9j/74l7nJfFWZ+FEhLwjbkdFE9OKZ0GflhHh092Mz2m3H6ohxBeCQ7H0gj4WvSXpk6+i5W9jXzaoSv6g=
Received: from DM6PR10MB4363.namprd10.prod.outlook.com (2603:10b6:5:21e::21)
 by DS7PR10MB4893.namprd10.prod.outlook.com (2603:10b6:5:3a2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Thu, 24 Jul
 2025 14:45:38 +0000
Received: from DM6PR10MB4363.namprd10.prod.outlook.com
 ([fe80::999b:18e4:cc6a:7cc6]) by DM6PR10MB4363.namprd10.prod.outlook.com
 ([fe80::999b:18e4:cc6a:7cc6%7]) with mapi id 15.20.8922.037; Thu, 24 Jul 2025
 14:45:38 +0000
Message-ID: <e6ab2cdc-5f5f-454b-9795-e8016ce16248@oracle.com>
Date: Thu, 24 Jul 2025 10:45:34 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 4/6] virtio-net: iter live migration - migrate vmstate
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, farosas@suse.de,
 eblake@redhat.com, armbru@redhat.com, jasowang@redhat.com,
 si-wei.liu@oracle.com, eperezma@redhat.com, boris.ostrovsky@oracle.com
References: <20250722124127.2497406-1-jonah.palmer@oracle.com>
 <20250722124127.2497406-5-jonah.palmer@oracle.com>
 <20250723024406-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Jonah Palmer <jonah.palmer@oracle.com>
In-Reply-To: <20250723024406-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0364.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::9) To DM6PR10MB4363.namprd10.prod.outlook.com
 (2603:10b6:5:21e::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4363:EE_|DS7PR10MB4893:EE_
X-MS-Office365-Filtering-Correlation-Id: 3762de2d-a4f4-4bb3-699b-08ddcac0c158
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d0xCR0JHTEVTNVpsZk1VaURNQ0pReHFBNy8wSDRVUGd1WkI2SE5FTlNDMkJJ?=
 =?utf-8?B?U2tGUlh1bDNiUkphOFB2U2h5dzhNdkExSXdoV1UvcWhOTzhkR0lwcEExNVNR?=
 =?utf-8?B?UlBac1A2Ty96NktSN0pQZkdBRHFQY1ZVemhOM1FXeTAwZTN3RUdhUnNPaysv?=
 =?utf-8?B?SDlHMjVXZWRJT1VoekhQc21DMi9TRmp2QVd5b3gxSTJUNlJCajQ0Nlh3dDdC?=
 =?utf-8?B?UTU2eEwyTTRWMWFKRFRVYzRuZVBBVGZnN2dkRks0NDdqd01SNFB5L2VFVGNy?=
 =?utf-8?B?dTUva1N5MVN6TGN1ek5hdWJSNmxkdkdhY0ZEdE5NZFFvYm50VEMrTjFJTTBT?=
 =?utf-8?B?cm5CUjdUaTdwbURTUVhJNk9LNXZDM0NBMTdZMUJ5c3ZtTVhmQzJBdlk3bEhq?=
 =?utf-8?B?UXc4K2J2Wk1NaC9VM1QyT3NZNEU0SkU2MWgvbzR5V0tpamZJSm1yZS9jckdM?=
 =?utf-8?B?Zy9BV21oYTVPMVE1YUo5aWNGcG9odHpReU94d1pIb0FkeTVTdm5HcHc2TjhC?=
 =?utf-8?B?Z3BpQlREQTN2RHpKdUVqWUt3a2R2QTRQSGRuZTc5MDFKandzV2VmcVFlTVlQ?=
 =?utf-8?B?Y1B6ckZhNm5hNHdnK241ZkVGdzVhaUZBNVdiejZSaERQOTlraUVaWkI5R1hV?=
 =?utf-8?B?aGg4MlhyMXdMRGlTRVlPUkx5ckFYUGNMcUVHbXZjS21oVjltaFZXamtIRzhK?=
 =?utf-8?B?UUczdWxtWHFSY2pIWERaWVBUVTA0TmFLQjdNTHpZY0lkL1ZMYUtwWG1paG9Z?=
 =?utf-8?B?UW5GVDlWTkdxaGRnanUvcm5tbDBpbDl1dWZZNzh5dnIybnV5WVBBQllNblp3?=
 =?utf-8?B?MVNBZjBVMXI4WlpxWW94WkwrVmtkYlBXVHFDKzZhNFZFSWh5OGp2d3hud2hM?=
 =?utf-8?B?T1A4bUR5dnozY1NDNnhWRUROUjYrNVhLdUp6aEZtNDNlTFNCdHNmenEzWG43?=
 =?utf-8?B?N2RJckp1ZDdiVGsyMWF3L3ZiOHJDU2xxTlFpejdJanYxNmZSVDVRa0JUZ2g4?=
 =?utf-8?B?Sk1iWFRIck9KbFVqMGVwVW8yempvS0VyT2svWFdoQWFsOTFCZGYvZjNTSW82?=
 =?utf-8?B?aUZESWVsMVlmbW5URTdyblpkRENaKytkU3V6TG45NGNjMEJQZCthOWdERVhL?=
 =?utf-8?B?L1NNTVBjMUFUTVhCY2JJMGFmblR2eTJRTHMxcWdreXc1UnZua2RzUGh1QjBp?=
 =?utf-8?B?enhkc2VIZXhENW5PVXBCWHczZ0F5UzgyczNVSWpaanRWMk1WeEFHM3orcW80?=
 =?utf-8?B?b25WM3k1Y1FCd1Y0WmV5UDdnMVZZdzVBYkJwcHBjWEpROWhFd1oxVFlabVI0?=
 =?utf-8?B?bUoxam1vSmtDdGNkNCtzaEhmVVBGOGpBb21OUXdiRkJJZnlDZXpDbElKd0lv?=
 =?utf-8?B?QXE3UjFqbElnNFhLbmY2M2hlakY1SUt5NDNYbGtISGZqRnBTWWNZeXlPT2NS?=
 =?utf-8?B?Q05kYlh1NFdZVitRWkZqcjN2NUNvSFlNS3hja2JDN0prb0cyZE5rRUN3WEpy?=
 =?utf-8?B?N1NFbUZyWFNVNm1uTmFrbnVSY1ZHeVhXOXZYV3JXdnlvR3dvQ21WdmtjcitJ?=
 =?utf-8?B?SGZiVTY4Uk1JSTFLQTVjRFA5UVpnRnFmbG9BMXdFdGlKV2VHUDRVTU9sM3B5?=
 =?utf-8?B?Tmo1a29YL1lEYVFpd0FiclVPRUM3T2VkdDJzRjlTWXhvTGFKczE3OTY4UmV1?=
 =?utf-8?B?VWo3RFNNcjhpNkMyVE1ZYWUwUS90eHNhRVNNcUZxYkV2ZVR2UE1NU0cyaVB1?=
 =?utf-8?B?Q2x6alBpWWtrK0RUUzFldlZ2N21wVE5MQlF6TnhiSXJTZmxGdHNPUVBHVUlw?=
 =?utf-8?B?elduWVJ4emZYeVBoR3VidWVFSW81bkFDWlpLajdRWVFIa0UzKzJxSTlSdXQw?=
 =?utf-8?B?VkhnamNVQ1VqSDUxVHJhdHpvU1dWV1ExUHJMVEpiSVJkM3o4ZDBrQzc0SWov?=
 =?utf-8?Q?z9/4INp5DVo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR10MB4363.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T1hNWE43Z29tbUVDajZ1V1RGaTFqV0xjSGlNOUNaMTdkWE10ZVk4V2ozbHNp?=
 =?utf-8?B?eFFiU0xrQTc4V2RrK28vSFJLVG1kN0ZPSE1vcVNNUXRqMU1wa1NHOUQ3aE5o?=
 =?utf-8?B?YlE3d3l1K1V5Nm1ZbEEzYVJDL3lrMExPeWI3YWpBazZEMldPTzMxN2R1eElG?=
 =?utf-8?B?Q3Z6SjdFcG9OMkFoY1k2NzFONXFuTGxidkgyb2hjWGJoZWgxQmtaS0E1clh6?=
 =?utf-8?B?VnRkODRXbnR3Z2N3Yk1FSGYvU2xOczZMbk5VWTJJM3hMbUtiTUpXc2d0Snlj?=
 =?utf-8?B?YUh3NjdIejcyWFVrV1dqOVlMTWNCUGNPWGFoTnVjbVdvQitzeGR3bVMvTDI0?=
 =?utf-8?B?bmwzMTRhMXNqRklRMG5Iem5vcTZ5NTJ4V0FySGpaQi9JYlFBbkl6cm5vOExV?=
 =?utf-8?B?S211S0FsMnNFSnpONUxSbWhnUVhCWUc4U2dMMnBCUzVPcldJdVB3UURRcUNW?=
 =?utf-8?B?MEhkRkM4QzZvUjN0cXY2M1VsRWY0TjBhSjNMYnNzQW5KeC82ZExPR3o1Y1pt?=
 =?utf-8?B?NWM4MVpzN0pjY3JmM0ZEYUFiRXN5aGIyTGZQSTNpd2hHRDdzakRwL1BSZjBF?=
 =?utf-8?B?bXpGMVRPZ283bUwvSU11S2NFUkJkYmY5SzJpZXZhd0ZscFdYZmdoM0FsUUl2?=
 =?utf-8?B?b21yUVN6WG5MeWJ2c0NPUFgrRnVGa0dJTVFFWWtUc3pkdGw5aHdSYlNtQjhE?=
 =?utf-8?B?VlhNbHlmeDNFYzBLYXJUV1V5cEY0RXlWeis1MDR6cUtRd3laR2VSNnBmZ0NC?=
 =?utf-8?B?bnR2MWVTWlFGemxqTVFxbGZwcWZicjlCTWFVcnVPcXJEUW9wckZYL0VyVEMw?=
 =?utf-8?B?N3dTVVAwMlNkQ2wzOW9SZ1BQZU1veGtUaDZ1SkJ2NUZqUjl5UlN5Wmp6eFgy?=
 =?utf-8?B?cTZPbG1yTnZCUFUvUDBQTTBqVDlOM1RWU1EvZktWMG5YbGNRQ0tvTE1qSVBZ?=
 =?utf-8?B?OVg4WXk0TWF6THNOYkFuWHBTeTBZcGtJK2srNlNEQk1PMkFGd3B5cHYvelFV?=
 =?utf-8?B?TW5KcFh2dlY4L1JkTW9NYVJXYURvVU1PWW1ZUExUSzBhSXlxaTlya1J6bThx?=
 =?utf-8?B?MU0wMTZSWmZNTTVxWTR5L00wcTVwM0VRNTY3dzlFSHJQa0VmcCsydHA5VFJy?=
 =?utf-8?B?d0hHYS9uU3B3Vk5aNGZsbXFPNVYxN2U4WDVoOUxFTzExelNEWnBISVpRQzQ4?=
 =?utf-8?B?YmdoZW1Kcjh0bm05QzdFY04wdC9sOTZOQWVSNTlSZjFCREh5VENSUHN5a0pM?=
 =?utf-8?B?eEE3RGdEU2JoU1BtVDdNWGNXbER2NndLZFNsMFlYeGJUUUZMcEVCcVNoSjFV?=
 =?utf-8?B?STkxWi82S1FrRGlJQU9GNlZybUV1REFEYkV0ZFpUQlB0T0V4UWdnQmNCNDE4?=
 =?utf-8?B?ZWZnOVB3WUF3VjhKc3k5a1JQZ05BaWRqYVFtSE0zbEFXMFdTdmNINmFLQjV2?=
 =?utf-8?B?SzR5cG1Kd0M3NDROZkcxeVhZeEg4eDZPbSt0Sy80VGhhcWNTNUZsS1hEaWd1?=
 =?utf-8?B?QngrUDZNZkwxc2hyblJjL2RwTS9MZVJFUGVkYnMvWGNmbUpRMTdES3VUbnRs?=
 =?utf-8?B?ZEtWZ2xFaVpIZ20yZmN3cU05Uys1TkduelNuSUdhTlJZQkNQOXZKMEdlcThH?=
 =?utf-8?B?MDVMVkc1a01GS3paaWthQS9ZeDhUZHhSSFFFRWd0QVh6Ym9mb2EybVdLY3lD?=
 =?utf-8?B?eUI2Q20rdkxKR1VyM0ZpVnVuZDhIUEEzWjh2KzEwb1hDVWt4WEcvNnV2NEFY?=
 =?utf-8?B?aVVJS2VoVnMzY1p4ZjlzNlNIWVA3bnpFSTArVkFubzZyK1ZmcUZuTzlWbTJs?=
 =?utf-8?B?MHg2M0FVdXA5MDd1SkNaRW8rc1dlcFpjZUhCdVc2aGNZaXFWRUx4RkU5T2Rk?=
 =?utf-8?B?bVFXeGpaZDE2ZEZ0WmhsRVlJUnNuL0ZNL1crajBsdkZBUXpUMUtkbi84b0gz?=
 =?utf-8?B?L01nNEU2NEZ5QW9EenoxT3BhNnJQZmVwSk1MQ2VPaWFwVnlpcUI2WUc3aU9S?=
 =?utf-8?B?N1VGRlpUTVNNZWp6TGl0UjY2TmNycS9jZkN0K2JZbGViTEJneHJBTnZGQUFr?=
 =?utf-8?B?eGduMUpnT293NDAvVWlxdWNlQWkzQzM0VHRKN1FTR0xSbkVRYkpqWWhaL0RO?=
 =?utf-8?Q?nVoeyitheRTyUPrd4kSKZyl+9?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: JvgBmuyMV6VO/QtXIMtXxu8paWo94vyJ8pd7M3erHABq3yGB6Na/saAYe0NePlrfDZwlvHE8VRUOlGarhMut3T7zh4glo9fxwGPFgIwerF2TeBoJ4BPEzsKhXgP4YiQml7admB3Q7DyA3EgxU43fpPkXblloonF2ZnCNjFnbpGq9aHzdnxZOkRuMkdJ83gHZ2OzV7ubQL0qSFdh3fH2LatuqRuPqbLdv0ENrDkll0kP0vClcup/ucfAa+JkWix43b8kfRnKfgiZKvaWr7oaKRzrm32LcF7xPHCmbcW3VRNPKtHKg1qWFTvhLUcgDU6TtGFpgDEcPZOy+mIGW0YhspXcW6MeaYeGuRY4ZVtIHV7qYdSxvscHnwDKp6ERKwJLtcJiPFWeE7ERMm/6jTCcu1jEI+IUd0QXsVO14iTdGEjcODqwvVxrMAeWWsEIOcuoEUD+hSZkjZoR+G3DW4kd/3+YofgWqgP91cA9ET2KtpPdZyOtiWa0ZNFcQ4Ky2t3Uy1XBMmzamWzSnI6Pd11FySCD/lAmNjSbBwRqjiq/mu+Fk66UeJT07RtJ58ve0JA7P/RUQXVeXHLkIK8h1/qjzyW0gAohbxqTr8IKrEyO0iKY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3762de2d-a4f4-4bb3-699b-08ddcac0c158
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4363.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 14:45:38.4681 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MQ5W0dF1pseyB65Gn+eRXKPJpXDrrpBgR9RUrsaoy8zQLoREEQmlBwC9xpP9BjyMSmJWK+A9ZnAyVjUV+Q2Qbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4893
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-24_02,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507240112
X-Authority-Analysis: v=2.4 cv=MNRgmNZl c=1 sm=1 tr=0 ts=68824717 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117
 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10
 a=yPCof4ZbAAAA:8 a=-UfEgT-F_jh3Al3Bjb0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 cc=ntf awl=host:12062
X-Proofpoint-ORIG-GUID: FusEFFURkporkcIFeMwLnENwV2hpzj0M
X-Proofpoint-GUID: FusEFFURkporkcIFeMwLnENwV2hpzj0M
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDExMiBTYWx0ZWRfXwKQjFdjXcQBz
 mAWplM+fCzPbicl7R11F14gMg2nSx5/N0mlbZNkJVIq4xOjNuqARRA6QLmLpVhV3W4FUwGIZhJ2
 ra2LImH55LyC6syk0TJ93FuDH1JhBF+aFiyTCWtH1afYRvzx9j2ArCdqfAtr7f8YQZFv1IqDQK7
 TXWRFuxWZPvVoYgHN0TfZfYpsj7fD2UjjhE0MUQLqo3c4k5vrQjvjfspf9Pcy5Dln2ROvYV5Ex8
 C2Rt/OW2FspMHQZlP3HtQhRXt/T7+s7rA6eCZbAYw62CAwJkEhFF27e1ugI7im+44RwqIklrwrS
 DPW0tIUlgBlIwHdNpKUhL+keo/1A1/S+ec3Ontv4i50v8KtheGqWPIUfJmrKcT/2E7yC+L73ubv
 t2SZBzrETXr/sXBzRzs5shykFkCThQG2GQOGzrSQMjLd3Hw6bjM1ijWrRU4TufS7WbNn75aU
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=jonah.palmer@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



On 7/23/25 2:51 AM, Michael S. Tsirkin wrote:
> On Tue, Jul 22, 2025 at 12:41:25PM +0000, Jonah Palmer wrote:
>> Lays out the initial groundwork for iteratively migrating the state of a
>> virtio-net device, starting with its vmstate (via vmstate_save_state &
>> vmstate_load_state).
>>
>> The original non-iterative vmstate framework still runs during the
>> stop-and-copy phase when the guest is paused, which is still necessary
>> to migrate over the final state of the virtqueues once the sourced has
>> been paused.
>>
>> Although the vmstate framework is used twice (once during the iterative
>> portion and once during the stop-and-copy phase), it appears that
>> there's some modest improvement in guest-visible downtime when using a
>> virtio-net device.
>>
>> When tracing the vmstate_downtime_save and vmstate_downtime_load
>> tracepoints, for a virtio-net device using iterative live migration, the
>> non-iterative downtime portion improved modestly, going from ~3.2ms to
>> ~1.4ms:
>>
>> Before:
>> -------
>> vmstate_downtime_load type=non-iterable idstr=0000:00:03.0/virtio-net
>>    instance_id=0 downtime=3594
>>
>> After:
>> ------
>> vmstate_downtime_load type=non-iterable idstr=0000:00:03.0/virtio-net
>>    instance_id=0 downtime=1607
>>
>> This improvement is likely due to the initial vmstate_load_state call
>> (while the guest is still running) "warming up" all related pages and
>> structures on the destination. In other words, by the time the final
>> stop-and-copy phase starts, the heavy allocations and page-fault
>> latencies are reduced, making the device re-loads slightly faster and
>> the guest-visible downtime window slightly smaller.
> 
> did I get it right it's just the vmstate load for this single device?
> If the theory is right, is it not possible that while the
> tracepoints are now closer together, you have pushed something
> else out of the cache, making the effect on guest visible downtime
> unpredictable? how about the total vmstate load time?
> 

Correct, the data above is just from the virtio-net device's downtime 
contribution (specifically during the stop-and-copy phase).

Theoretically, yes I believe so. To try and get a feel on this, I ran 
some slightly heavier testing for the virtio-net device: vhost-net + 4 
queue pairs (the one above was just a virtio-net device with 1 queue pair).

I traced the reported downtimes of the devices that come right before 
and after virtio-net's vmstate_load_state call with and without 
iterative migration on the virtio-net device.

The downtimes below are all from the vmstate_load_state calls that 
happen while the source has been stopped:

With iterative migration for virtio-net:
----------------------------------------
vga:             1.50ms |  1.39ms |  1.37ms |  1.50ms |  1.63ms |
virtio-console: 13.78ms | 14.24ms | 13.74ms | 13.89ms | 13.60ms |
virtio-net:	13.91ms | 13.52ms | 13.09ms | 13.59ms | 13.37ms |
virtio-scsi:	18.71ms | 13.96ms | 14.05ms | 16.55ms | 14.30ms |

vga:		Avg.  1.47ms | Var: 0.0109ms² | Std. Dev (σ): 0.104ms
virtio-console: Avg. 13.85ms | Var: 0.0583ms² | Std. Dev (σ): 0.241ms
virtio-net:	Avg. 13.49ms | Var: 0.0904ms² | Std. Dev (σ): 0.301ms
virtio-scsi:	Avg. 15.51ms | Var: 4.3299ms² | Std. Dev (σ): 2.081ms

Without iterative migration for virtio-net:
-------------------------------------------
vga:		 1.47ms |  1.28ms |  1.55ms |  1.36ms |  1.22ms |
virtio-console: 13.39ms | 13.40ms | 14.37ms | 13.93ms | 13.36ms |
virtio-net:	18.52ms | 17.77ms | 17.52ms | 15.52ms | 17.32ms |
virtio-scsi:	13.35ms | 13.94ms | 15.17ms | 16.01ms | 14.08ms |

vga:		Avg.  1.37ms | Var: 0.0182ms² | Std. Dev (σ): 0.135ms
virtio-console: Avg. 13.69ms | Var: 0.2007ms² | Std. Dev (σ): 0.448ms
virtio-net:	Avg. 17.33ms | Var: 1.2305ms² | Std. Dev (σ): 1.109ms
virtio-scsi:	Avg. 14.51ms | Var: 1.1352ms² | Std. Dev (σ): 1.065ms

The most notable difference here is the standard deviation of 
virtio-scsi's migration downtime, which comes after virtio-net's 
migration: virtio-scsi's σ rises from ~1.07ms to ~2.08ms when virtio-net 
is iteratively migrated.

However, since I only got 5 samples per device, the trend is indicative 
but not definitive.

Total vmstate load time per device ≈ downtimes reported above, unless 
you're referring to overall downtime across all devices?

----------

Having said all this, this RFC is just an initial, first-step for 
iterative migration of a virtio-net device. This second 
vmstate_load_state call during the stop-and-copy phase isn't optimal. A 
future version of this series could do away with this second call and 
only send the deltas instead of the entire state again.

>> Future patches could improve upon this by skipping the second
>> vmstate_save/load_state calls (during the stop-and-copy phase) and
>> instead only send deltas right before/after the source is stopped.
>>
>> Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
>> ---
>>   hw/net/virtio-net.c            | 37 ++++++++++++++++++++++++++++++++++
>>   include/hw/virtio/virtio-net.h |  8 ++++++++
>>   2 files changed, 45 insertions(+)
>>
>> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
>> index 19aa5b5936..86a6fe5b91 100644
>> --- a/hw/net/virtio-net.c
>> +++ b/hw/net/virtio-net.c
>> @@ -3808,16 +3808,31 @@ static bool virtio_net_is_active(void *opaque)
>>   
>>   static int virtio_net_save_setup(QEMUFile *f, void *opaque, Error **errp)
>>   {
>> +    VirtIONet *n = opaque;
>> +
>> +    qemu_put_be64(f, VNET_MIG_F_INIT_STATE);
>> +    vmstate_save_state(f, &vmstate_virtio_net, n, NULL);
>> +    qemu_put_be64(f, VNET_MIG_F_END_DATA);
>> +
>>       return 0;
>>   }
>>   
>>   static int virtio_net_save_live_iterate(QEMUFile *f, void *opaque)
>>   {
>> +    bool new_data = false;
>> +
>> +    if (!new_data) {
>> +        qemu_put_be64(f, VNET_MIG_F_NO_DATA);
>> +        return 1;
>> +    }
>> +
>> +    qemu_put_be64(f, VNET_MIG_F_END_DATA);
>>       return 1;
>>   }
>>   
>>   static int virtio_net_save_live_complete_precopy(QEMUFile *f, void *opaque)
>>   {
>> +    qemu_put_be64(f, VNET_MIG_F_NO_DATA);
>>       return 0;
>>   }
>>   
>> @@ -3833,6 +3848,28 @@ static int virtio_net_load_setup(QEMUFile *f, void *opaque, Error **errp)
>>   
>>   static int virtio_net_load_state(QEMUFile *f, void *opaque, int version_id)
>>   {
>> +    VirtIONet *n = opaque;
>> +    uint64_t flag;
>> +
>> +    flag = qemu_get_be64(f);
>> +    if (flag == VNET_MIG_F_NO_DATA) {
>> +        return 0;
>> +    }
>> +
>> +    while (flag != VNET_MIG_F_END_DATA) {
>> +        switch (flag) {
>> +        case VNET_MIG_F_INIT_STATE:
>> +        {
>> +            vmstate_load_state(f, &vmstate_virtio_net, n, VIRTIO_NET_VM_VERSION);
>> +            break;
>> +        }
>> +        default:
>> +            qemu_log_mask(LOG_GUEST_ERROR, "%s: Uknown flag 0x%"PRIx64, __func__, flag);
>> +            return -EINVAL;
>> +        }
>> +
>> +        flag = qemu_get_be64(f);
>> +    }
>>       return 0;
>>   }
>>   
>> diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.h
>> index b9ea9e824e..d6c7619053 100644
>> --- a/include/hw/virtio/virtio-net.h
>> +++ b/include/hw/virtio/virtio-net.h
>> @@ -163,6 +163,14 @@ typedef struct VirtIONetQueue {
>>       struct VirtIONet *n;
>>   } VirtIONetQueue;
>>   
>> +/*
>> + * Flags to be used as unique delimiters for virtio-net devices in the
>> + * migration stream.
>> + */
>> +#define VNET_MIG_F_INIT_STATE          (0xffffffffef200000ULL)
>> +#define VNET_MIG_F_END_DATA            (0xffffffffef200001ULL)
>> +#define VNET_MIG_F_NO_DATA             (0xffffffffef200002ULL)
>> +
>>   struct VirtIONet {
>>       VirtIODevice parent_obj;
>>       uint8_t mac[ETH_ALEN];
>> -- 
>> 2.47.1
> 


