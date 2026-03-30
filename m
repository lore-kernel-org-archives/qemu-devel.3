Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7412910D14B0
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 13:20:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7CXT-0004U5-Ox; Mon, 30 Mar 2026 09:20:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1w7CXN-0004TH-8S
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 09:20:14 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1w7CX8-0004fM-Uz
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 09:20:12 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62UDEGAN3391915; Mon, 30 Mar 2026 13:14:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=ZQ4xwUp4yVFR25h4JDHuR25cQGaFx/a5pwWglTClyfw=; b=
 VtMJHpLGwiodmJ9JVQBeXgpnvl92XzuUnjBp5jFvE+Jcl169uiELZEkVSxhVyhzl
 nUdeWvCaViArPtg1yVE1aM0bGM5SXYe2SuUubLjR9IFL3DoI+wUO0u5P3/Ug6zij
 VCoQFaJE4KIFGtEdHmK3YI7KuOjSMnfpKGk7OTxQDsUbllMOmXTy0qxvNtQABkVr
 KmcIlBZjmzlCZVJT/oVPwSDcMpw7DtKqPEbjUAfN3hKMQv3GumQyJ4cdZ0AYo4hx
 OMOYc8KmSAd0yFTz3eHkKRxUv6MJSSNBgNVrRHCLmG6sIGyzbM+PiZuE6/lVrKra
 RQqjy/zZwsSI1AEAcGDzJw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4d66kqt58c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 30 Mar 2026 13:14:47 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 62UBlmjT007552; Mon, 30 Mar 2026 13:14:46 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11012003.outbound.protection.outlook.com [40.107.209.3])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 4d65e8gaq8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 30 Mar 2026 13:14:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LlZMyfY6MoCl0rA09U27vSjpM8TrG1d6byG17LMysNUOr7H7kP7+pJMZuiZmUtu77PtiVbIKq1WmHlDIpRKpwy64dajeyZnRtkXG0ajHoxDbEJxJ4g+DGDmgWHZisoeaEo3cG9/jZhrvZyKqAN7A0SLzkVWFXjvJKLv4MnDP6ZESLuBfJCxOhDgfcjZs3ADF+Pb4h5yjWvsj36M1jT6ZfiXz4SVqEnfa19ZDq1ml381VAh97qjysjNWtC1tTMR1xqoq3b15WF2cXdENgzZyoQ+5vNww7hQyEpLYEV9QgoCHDPtSpMUxrr2Rb3wyjGLJS1lgs3bX7Vj1UKQwaY04hFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZQ4xwUp4yVFR25h4JDHuR25cQGaFx/a5pwWglTClyfw=;
 b=KCrGh3EHMhc4X7tNG9lrdJ2qFhwjk8LaDN0Gt3g69BLIu45IsGfzWfp6peDY4kLbjAB18pVAWxM9NpBwbHMKyAURwjqcmWITl5Toz+UG4zt+Udi2XQF4wDrqyuY9MzwoHutDDpizXsAIBRwM7FB0pp+Y1pMgVNlXgDWxgmSsES8YnBEfpJ40TvC+D4miKpIypb81AyrKjj7UadWcch0MhSusqijtkltkALpsJFjc4B8xnl7QxC0jGige89CBmW1zcB8WrifullIp3nBRx0VcTVxL78ILXKZsD9dIWEHywrQuSyhJj8OdH1PrG2fC79KB0T5d2a8y7+cgrYCOBdVZoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZQ4xwUp4yVFR25h4JDHuR25cQGaFx/a5pwWglTClyfw=;
 b=AcTPV5lc7ZMmH6uUfVaItRHsB5SN68LgGV9auR1LrG1pnEIDz202l7QbCRHIKrNRIkOkK/E+Hgsj/zSMYNIZYyAmhJBvIYP14/Pgysbc2paqCqWHhmdjiqkFHrUM+qNxJCAG29fURRouU4mIofNq23Hy9BuvoZtZ266Dp/c/wxc=
Received: from DM6PR10MB4363.namprd10.prod.outlook.com (2603:10b6:5:21e::21)
 by DM6PR10MB4379.namprd10.prod.outlook.com (2603:10b6:5:21e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Mon, 30 Mar
 2026 13:14:41 +0000
Received: from DM6PR10MB4363.namprd10.prod.outlook.com
 ([fe80::90f9:3960:8442:de85]) by DM6PR10MB4363.namprd10.prod.outlook.com
 ([fe80::90f9:3960:8442:de85%7]) with mapi id 15.20.9745.027; Mon, 30 Mar 2026
 13:14:40 +0000
Message-ID: <4df4b541-c26f-4d4e-b898-177718930bf4@oracle.com>
Date: Mon, 30 Mar 2026 09:14:37 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 01/14] machine,virtio-net: add early-mig property
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: qemu-devel@nongnu.org, eduardo@habkost.net, marcel.apfelbaum@gmail.com,
 philmd@linaro.org, wangyanan55@huawei.com, zhao1.liu@intel.com,
 mst@redhat.com, sgarzare@redhat.com, jasowang@redhat.com,
 leiyang@redhat.com, si-wei.liu@oracle.com, boris.ostrovsky@oracle.com,
 armbru@redhat.com
References: <20260320142015.3856652-1-jonah.palmer@oracle.com>
 <20260320142015.3856652-2-jonah.palmer@oracle.com>
 <CAJaqyWf5==jZxJErazeAea1NxpGB2SFNdpAPh7bi5tc69FytTw@mail.gmail.com>
 <cbe7eff3-179d-4bc7-8fcb-ab0ab805a46e@oracle.com>
 <CAJaqyWdR2Rrk=V2rdap16PKvHCzbPSXwakj33gxGruo03tN4Sw@mail.gmail.com>
Content-Language: en-US
From: Jonah Palmer <jonah.palmer@oracle.com>
In-Reply-To: <CAJaqyWdR2Rrk=V2rdap16PKvHCzbPSXwakj33gxGruo03tN4Sw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0213.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::8) To DM6PR10MB4363.namprd10.prod.outlook.com
 (2603:10b6:5:21e::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4363:EE_|DM6PR10MB4379:EE_
X-MS-Office365-Filtering-Correlation-Id: aaf198c9-a483-43d6-67bf-08de8e5e4cb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: weQi8ZmbMOJaAVt3SwBBJAk1vrL/EqEzwwYmc1CjInmvtkkWyvYxzG2F7UaP3HnBwBPnVHWSDWpjKFFL245r8YQZCIHzsZDMZ2knCg0ylkibzHQj94ivF3A4KSUyzVgEde538sM4KcGCSnDadIDSibzmXxMe15OAA5EpGGm3OPCgVlb5gOIM0DxgBjZvyPxmo29RKt9WhzUfcRUeEPUu6LWq+p34QNLK99sBKAN0YLqzQhWxBc3D6n4A/JDhjr24D5ICUzSEhsIC3yswtsNt+mnuXTYPrIV3Mp4v9ofb0BmaKLz6SgdtsNbLbRPRkqStsmvwSM1etnRwTVApcViZpJciwfgPAII27/a5x2UZDIRwyDbDjcN7Kf2ZeH6780eH/uI+mhkUYYsc8NF9Ew6tksr2DwT+Cx6WOfIaUV+RBbJRP+URrL+JHtp4Pd3v2lyIIJksa6FinlmSrtNOaxw2i4go6WrtVuJappuIH7ZLluYknYWbar5SJotGBax0AbvJz0vXSg0xQJHqfa9h/NxNPxZIpmxWMLgfdovh/r9HsZlN8HJYzmuBG48clt0hkc6uG+Qap/JUmUM68H8RlpmdIN+BSzB6z8rkTmKSghOhevKhq6+J5/9EXMRfsgK5xBB4H9psyUDysCAcqssApxfsDrFly9TaP6j2SeDtP0+9v8EoH17Nt7aY+gOnRyUhQ6T9FeS2etGemvsL93vGCyF25fp2vRHNW0Tl2iUA9wtZKHQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR10MB4363.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dXYyeUdLUWpiWGJWRjQxN2NIK3NPdUM5N3d6N25aZVBqTUhPVGtKYktwa3pr?=
 =?utf-8?B?YUpQRCsyZTNrVWZQMmd1QUF1bGI2UXdlaFA2YUZpT3B3NEZYTGZVcWxlbHZZ?=
 =?utf-8?B?Tmg1RjlxWmVrOUJpWmpNaEc3LzVZckdxaDk3U2JwY2V5bTU5WUVrYTFXcVRV?=
 =?utf-8?B?RVRsMzNUQ3ZSUW1vdFNFbTdXNE1Uajh2THR4MGRKZ1ZldDVvMkh2NndWVnoy?=
 =?utf-8?B?YWR2aHl1WEJEWGhBcm1DZ20weE10SXllbktyejBmOHh3S1FERnpLbVdrKzlD?=
 =?utf-8?B?NldoWFNQQTFQNW9oVWx5cnFrK1V1RUZTYmRqOWlQY2xaQnk1TFl3SG10MmZC?=
 =?utf-8?B?M1YxcGJoeHJxMzRkUUdTUmFDSHJOVGcra25id0loeEFtUVJhMFZXTlBmQWp0?=
 =?utf-8?B?NlNzUERyTWZRb01OT1FTTUdHcE91NW9Pck9NQ0lzd1dvOWZQejJyNGNzNzN5?=
 =?utf-8?B?OFdwaGkyMXhxT2lUMGhpVUFZZWF1cFJXTG9Oamh5TzdrQUpBSmxPWHZSOUxF?=
 =?utf-8?B?R29pSi81WVQ4eWQram5DZGZyMWRvWTREKzFtdUxDTjNQZldaSkNuc2dJTUwx?=
 =?utf-8?B?T0N4U090VHBiQVFDRHk0YXdybnVNVy9MSndXbDNIcGZLVTBxNjVLM0FnTC8w?=
 =?utf-8?B?MFNaNkNSek5ZaVhYajQxWGQ4d1dLMHdIaUlkRmU5Y0RtY3p6Slg5Yy8wTlhH?=
 =?utf-8?B?M2o3cE4vK0ZKZ2ViMHBpZHlPZ3R4bEdPMmV4Yll5bGh1OWdkS0d5Vk5wbWJV?=
 =?utf-8?B?VnZhemZwYVFaenFyd0JtZ0Q5dUNQOHFSQThnZnhGQnJWbHhlVm9ESUFMZDRN?=
 =?utf-8?B?OEoxRXhlNmVvMG40aVpkUGxKKzlIdStCak5jWG10YkR3K0VGMElLRjUxZjhk?=
 =?utf-8?B?RWVkTytnVndSYjRIaDc5ME9iQTB3cldyaVBUQnZUNlMraDA1RWljY1MzOWpC?=
 =?utf-8?B?ZGt4R0kxdDJ5eUxuWVFuUDdmV2R4MmhaREs0VFNRS09NY09pTnlySCtYMEpN?=
 =?utf-8?B?dkdWZ1VITGVmNzJ3OXhDSk5FM3VKWDFGZTFmcENQeWtHdTVhOTEzQzN0N2sw?=
 =?utf-8?B?SWdYV3FrbGJXWndQOVh0RVhUL3VlenJLTGN0UEMvS0V0Q1RZbWVJdStvQ1dj?=
 =?utf-8?B?ZzJCVGJYdUdsYm9RNnlCaFQ3aWdkN3NhdFBzMDFNaU83bngxOWlxMlp1VVVS?=
 =?utf-8?B?azV1VU5oQ3ZOOWkrTTVjYVBJV0ZCL3B6VWdZZWwrQ3JCSXJJVnN4dEtQYlg4?=
 =?utf-8?B?SmJSUEZkUCtpQytKdnl2UklnbnVDZXBPMFpNNVpWQUxkZ2g1dXlJcVV1d0F3?=
 =?utf-8?B?NElVK2RDbTRkL2pUNllvYjl6NUdhNi9aNmJVbDRkY3dXTGpNRGl4cDJIY0RN?=
 =?utf-8?B?dXo3MjJYRVZhY1AxWnAwNjRGTHJSRm83N09QeUdPSkJwSGVwZmlEb2c1RTlL?=
 =?utf-8?B?WXc2WWcvcmFUay9IQlg5azl2VHZ5a2hFNWcyb25vVU9pK2pVSFlVZ3h2QWlu?=
 =?utf-8?B?L2NhUVRwTjZUU0JPc2FFa2hIVFIvc1NFNUpjVDg1Y1hDc3htUXM0cWhMYnNv?=
 =?utf-8?B?MVA4Z09LY2QrVWNpUzlLTU9KN2o1aDhXdXYxUnR1WERiUTF3UjRlOHBQSDFj?=
 =?utf-8?B?OVpRZndwcEJDMElSczhlUWlqRE9rekJ1ZUNrbTgwN2xHOC9yMlJlWHNTWTdh?=
 =?utf-8?B?dmd5ZUxySXdkTm1DZUllcWN4T1hGQ1Q0eU0yN0VoellwZys5RUhFMUROOWt6?=
 =?utf-8?B?VVIrcHJRdGIwd0VZbTVBeXMzSTRZS2Q1RzZZckYrbTAyZkMxbUQ0ZzhpaWlo?=
 =?utf-8?B?S2NGdWd0elNOYTRoa2RMWFZ6VFlkS3RodHhyYWtaUzJ6ZVdhdExZL2ZNNVJJ?=
 =?utf-8?B?S25SdG5kOW9ydndFYkJKazF4ZWhNWU51YWJqU0hKL1dMblJaOXZ0UkJPS2Na?=
 =?utf-8?B?aVhScFpxcGxCcFZMc2xyTkZRbzluTDluQmJ1SSt2WHBhK1RXTldPU3RGWnJF?=
 =?utf-8?B?ZTlQWktCTHV0ckIxUTBQbHRZeVdjMGRFWEJCU1o5ZjdjcmRJWDRyb3o3aVZW?=
 =?utf-8?B?TXpGbkR5UzBRKytjRHVFMnZGelRLYXhSWHVsLzgyQWZsNFdiaWtXWW53WmdJ?=
 =?utf-8?B?bVcwK2d4T0VPRWpKbXR2UHRrdmJaU0p3Z3F3QnA0V2MvQjFNY2Zsdkh1YUUw?=
 =?utf-8?B?dmp1OXNhNFhwSis5aWtVbks1WDRjbDNuY0pDN3RBVU55RGphczFpOVhGNjg4?=
 =?utf-8?B?VmVKaEhBT2ZXYWlFUXhiUEc5cmg4UHI1ZEJmc1JaMmViZ1d4RktUcTBTTW9L?=
 =?utf-8?B?NjlJN1I2MUxzcUg3WU9Oc01uT25JanRCWXZOcTE3Q3NqSmdEbE5EQT09?=
X-Exchange-RoutingPolicyChecked: moNraIxN9NqxdCakO6czX1WAxDr61ANI/QLmqYnIHvGZ8/vx5zzZ5BDDw2cpu1Tw6X9QJcH/zWGS7jMPExx5T4p5vCCvqYupY8XIs5yMdAtecaXfwXEmgLy5Rd40MhkYIeJ+oECmrdCw7tnTxLO+CU967r5f0WZiERuTM2HVUOOrnVh4SKIY9kt/NLvCNQWK3lUKxgOugJbHCybqx17XfCDdAi37pUPNQqayAlc4LtakxxD44N5q5CIEQUbcrv6H62z3HICCbXbzKLhOOZr4Bk4TqsVytCppt9DFUCBsiEDaoWP4CinH++qZw9/diXddkGuRsK3HSX+ht8VmmgMr8g==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 1KJNHEVBhLFbMv2+elGYnzrn858zem5nLLFBQXUeQYpeSZbdNBy9UhixjZzyCFlsh1EdGhF/IxAib77BtoNQvXkBqvr/XkKC3fLRQQGjTBPr2kkJHQSABePtkcnzJM5xrrWZBv6uI033ZlDD1rVZJGnVDVj2V/Pvi8eQ790cQUXHyH3e/mSihbUjMzxsKg7StZdt4iNrbg3rP3Qq/zMC/hnYceHrtCcIwCkHutoWPvpl/PKMBPesDkHEyB7H/xdTOrBLFAPWP82KvWtYkItfAwKcem0GYm7NX5LQge1fT5/EcHp0kecqm8WGXV6icBM7ffflnQp32rgH/EQgz8GyA68i/+mbMBq/8F1WtytZ+TJs9i2bjtSIjlGWSyPM6iok247UxzHEy8r8vwXzWkOM3idOcunH78kx3W0LHfB/eH7+6EaaJ0YUaaGU3TQgHOhr29IDlL9ZudzP3ieP2bMfFSdUDD6R6rZooK96OEcFom4xz1VUWBjDGzOE9gKD50C4mwLRjM0B6MnaaGJbdwfpDWoWULIYEkQIVyuSwIRJdb+d1+EtfuwbTOqGPOvGE/JJby34cxD3ru9TbgdvUVKl64yDItd/r+GqYL7FakK7cKA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aaf198c9-a483-43d6-67bf-08de8e5e4cb7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4363.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 13:14:40.3311 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Url+HMs6cb/Wah8OcoOIMVcISAMqCiFz+DbRyatH+RlvShiT8b3gDmnChq84DYbuIY2GAngEiP0tEUiTIXdgmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4379
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_05,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 bulkscore=0 spamscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2603050001
 definitions=main-2603300103
X-Authority-Analysis: v=2.4 cv=PqaergM3 c=1 sm=1 tr=0 ts=69ca7747 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117
 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=3I1J8UUJPc9JN9BFgKH3:22 a=yPCof4ZbAAAA:8
 a=J_gzRdOAL9rF5LRi1ZIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDEwMyBTYWx0ZWRfX4NY3o7kzkD6S
 YDhbY9f7c5GMJY3OfuIXx2pilexBhdefIpDkfVaV+o126OnADIHJNKefyWpO7C2IpYp47HfLnO5
 36nXM8cc0iVvqmqUzJKUCNPdhTr/RfKUZDDgmd3hxfyJTowdE7LXGTitb1vsZIzU2yWgH+f3zPU
 3RYiEtqR/3F/3BeCSoqY1rkTct+BG+YXL3i3E8Ia7cHT6CwgwW35YShwI/ZuqMziTDT4OATrXrk
 TUSscNLUzkx2gdMWOOZ6x88kXmsA0vkKGTBj52QsVsuyqAXRIktuY9aFp5SMMspKolhsbdOU94H
 9TlOomnu9IoCuRYXblaZW2oxE/xUjAUuxOdwfIJrqh5lN+e3wGUL78xtNjK9pR8oEq9CAwojqoA
 QKfrs0U5LnJIgebGGkVqxOHMkfgdiGqBAFxUwWlWyGZ9fYDsvjyyGAzCTxptg8/mAXnzV4VeUSn
 ickhlPFRvSPl7UjSdKw==
X-Proofpoint-ORIG-GUID: 7Ke3Xg6v3D2sT9zLj2ivyRT9zz1h32H8
X-Proofpoint-GUID: 7Ke3Xg6v3D2sT9zLj2ivyRT9zz1h32H8
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=jonah.palmer@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 3/26/26 4:02 AM, Eugenio Perez Martin wrote:
> On Tue, Mar 24, 2026 at 3:07 PM Jonah Palmer <jonah.palmer@oracle.com> wrote:
>>
>>
>>
>> On 3/23/26 6:25 AM, Eugenio Perez Martin wrote:
>>> On Fri, Mar 20, 2026 at 3:20 PM Jonah Palmer <jonah.palmer@oracle.com> wrote:
>>>>
>>>> Introduce a new 'early-mig' property that enables the early migration
>>>> path for virtio-net devices on machine types >= 10.2:
>>>>
>>>>    - virtio-net-device,early-mig=on
>>>>    - virtio-net-pci,early-mig=on
>>>>    - virtio-net-pci-transitional,early-mig=on
>>>>    - virtio-net-pci-non-transitional,early-mig=on
>>>>    - virtio-net-ccw,early-mig=on
>>>>
>>>> To preserve compatibility for older machine types (<= 10.1), add compat
>>>> overrides in hw_compat_10_1 to keep the legacy default (off).
>>>>
>>>> With this, machine types 10.2 and newer enable early migration by
>>>> default while older machine types retain the previous behavior. Users
>>>> may still override explicitly via:
>>>>
>>>>    -device virtio-net-pci,early-mig=off
>>>>    or
>>>>    -global virtio-net-device.early-mig=off
>>>>
>>>> Follow-up patches will implement the actual early migration feature for
>>>> virtio-net devices.
>>>>
>>>> Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
>>>> ---
>>>>    hw/core/machine.c              | 5 +++++
>>>>    hw/net/virtio-net.c            | 1 +
>>>>    include/hw/virtio/virtio-net.h | 1 +
>>>>    3 files changed, 7 insertions(+)
>>>>
>>>> diff --git a/hw/core/machine.c b/hw/core/machine.c
>>>> index 6cf0e2f404..1b6c7db119 100644
>>>> --- a/hw/core/machine.c
>>>> +++ b/hw/core/machine.c
>>>> @@ -45,6 +45,11 @@ const size_t hw_compat_10_2_len = G_N_ELEMENTS(hw_compat_10_2);
>>>>
>>>>    GlobalProperty hw_compat_10_1[] = {
>>>>        { TYPE_ACPI_GED, "x-has-hest-addr", "false" },
>>>> +    { "virtio-net-device", "early-mig", "off" },
>>>> +    { "virtio-net-pci", "", "off" },
>>>> +    { "virtio-net-pci-transitional", "early-mig", "off" },
>>>> +    { "virtio-net-pci-non-transitional", "early-mig", "off" },
>>>> +    { "virtio-net-ccw", "early-mig", "off" },
>>>
>>> Is this needed even if we mark the VMState as optional?
>>>
>>> The source might not be able to send the device configuration in some
>>> cases. For example, if it cannot shadow CVQ. If the destination knows
>>> this field is optional, the QEMU source version is irrelevant.
>>>
>>
>> I think it is still needed, yes. This series adds new VMSDs that are
>> registered as top-level savevm sections, and, IIUC, a destination guest
>> using an older version of Qemu would not be able to ignore these
>> "unknown" sections, even if they're optional for the source to send.
>>
>> The compat property also preserves the pre-10.2 machine-type default, so
>> a 10.1 machine type doesn't silently change the migration behavior when
>> it's being run on a newer Qemu version.
>>
> 
> Ok good point. I'm tempted to propose removing the cmdline argument
> then, but I see virtio-mem "x-early-migration" also adds it. I don't
> think increasing the migration's complexity by adding command-line
> cases is worth it, but I guess there is a reason for that. What about
> setting it to true by default?
> 
> Also, maybe it is worth exploring using the same name for both
> properties. At the same time, I remember that x- prefix was
> discouraged so... I'll be happy with any option
> {x-,}early-mig{,ration}.
> 
> Again, I wouldn't object to adding the cmdline parameter, I'm just
> trying to make this as easy to maintain in the future as possible :).
> 

IIUC, for new machine types (>= 10.2), this patch turns it on by 
default. For older types (<= 10.1), it's off by default.

With regards to maintenance, you could argue that it helps us in this 
case. For example, it does keep the policy in one place (compat override 
for old machine types) plus runtime eligibility checks for cases where 
this early path isn't supported (e.g. vhost-user). Without the property, 
we'd need some special case policy path and/or more machine-type/version 
checks in device code.

The ability to explicitly override this also would allow for debugging 
issues.

>> I do agree though that being unable to shadow some state should be
>> handled as a runtime check for early migration (like we do for
>> vhost-user), but that's separate from a machine-type compat default.
>>
> 
> Yes, I missed that vhost-user and vhost-vdpa were out of the series at
> this patch. It happened with a few comments. I should have gone back
> and solved them myself; apologies! If possible, and if you see it
> makes sense, you can expand the patch descriptions with the info.
> 

No problem! I'll try to be more explicit about it in patches/CV. Next 
series version should include vhost-vdpa support.


