Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC669C54756
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 02:36:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHZIg-0006tz-LV; Tue, 20 May 2025 22:35:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uHZIf-0006tq-Q0
 for qemu-devel@nongnu.org; Tue, 20 May 2025 22:35:21 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uHZId-0000c2-8g
 for qemu-devel@nongnu.org; Tue, 20 May 2025 22:35:21 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54L202DX019051;
 Wed, 21 May 2025 02:35:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=SVe8EHxpUfa9VrrcUD8BH2RVIEQHrlZ5pu4GsFhGtLM=; b=
 KzDC7hXAT3+afJXF5IX3Ey//FQA9z9/WiA5MEWVlnA92JuipZNpsCv84eliwASWE
 eoZKGD4FruZ0r+/5cxFdWYPOhIhKVKVzjT7ka/BvEJ2dVdSa0prTJ9pV4KOXdYU/
 pRJQDtTs1WRmO3Lu3YJvRY/xRARoZ9aa0ZArxs6BtAy8BsdkKuMnVglAFlAz4StT
 n4MIl8ierUyBIYTqNiPe/kc3vlQQnbHHlUClJVxAz/633x4xx5ZPGGfcE0NGOLEN
 RJ3PAecYxoKUT8ZnWQolDOz/Ef2GXN0JzlCDGTS/JP3UgLaFJ6vU+yz1OrK7lZqS
 PPP97wzNym3rC0yotjfAEQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46s5nng298-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 21 May 2025 02:35:07 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54L2Dae5033539; Wed, 21 May 2025 02:35:06 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46rwemsekf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 21 May 2025 02:35:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HNTEm14a6g1FDwfK4YuMwWd3vH0XevJrwvTbp5juGfMfKvm6eAUhrkL0HrQN8f00u5lDlV1jthVwR2ltvaM/uNd2SWrG2adLsqLqbqDUhF2oY7edwmBpfLEteX9iqCfHlsOg8/0jJhyEuBwNOjwK/i6TB/Xbqa8gOnV8+afq8a8/ctmIUIx8QTaS6R++bLhYutujMqjnv9etlUnj64ilevLayob7ffa/RHRwX5F03a7B4ymzCbo0pt7xSLly5Ldql+cLpGSRUmjsqPYS8Z32yvlbD3zIU7c7PRU4t7Nve4otLglSDI7rjGORcuBQRLDfdvJRSdtjw8cCTUDMAzIaHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SVe8EHxpUfa9VrrcUD8BH2RVIEQHrlZ5pu4GsFhGtLM=;
 b=IkHyvTiSd5xPiFrwozv3plDf0a4LujCdvACn0ed08hokv6OkiMJAt+vTu/D0GgVoYduSy5gbzr0faQZcBfCh9vWypy3qcx6mgzE56r8mTXY2Ofd268UU397jj39IYlM+6bYr37ocFenUDl4vcai6eRWQJP09MFFheyW/CPNpsv7qnhSIZQmjsNliRloB/Dz6Jvcv/zq+BwGglmrqlzwV1DyAJ8K9OgG4GZvlOrJAWKjtG60XVq+szZL7g+lxljz+5tdd4o3BrXGQ+xTPlIgmmK7Ducc9zhE2DhSle71lGO/ZWhkelU9C6W1NChkpqLJ4qO08Gl69AALVsmxMAHtX+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SVe8EHxpUfa9VrrcUD8BH2RVIEQHrlZ5pu4GsFhGtLM=;
 b=cJtTAnEXIX64Gtru6y6CQDqqNVO09XM/RcZkpyjftyy9d3xS41ngpig3LNGb20yVxSqVC2et//724+7zEsCB7YiXs4XOwE/QQS1SSsiKVl0Vr3M3a3FELtEcReP0je9hzJozkMD/TT5sod3R/WAx/CPjVLGhEL9YjS4oFlBAfjY=
Received: from DS7PR10MB5280.namprd10.prod.outlook.com (2603:10b6:5:3a7::5) by
 CO6PR10MB5586.namprd10.prod.outlook.com (2603:10b6:303:145::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Wed, 21 May
 2025 02:35:04 +0000
Received: from DS7PR10MB5280.namprd10.prod.outlook.com
 ([fe80::da22:796e:d798:14da]) by DS7PR10MB5280.namprd10.prod.outlook.com
 ([fe80::da22:796e:d798:14da%3]) with mapi id 15.20.8699.022; Wed, 21 May 2025
 02:35:03 +0000
Message-ID: <a04f20f6-17f9-4001-9f44-2d41cc9ca96a@oracle.com>
Date: Tue, 20 May 2025 22:35:01 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/20] AMD vIOMMU: DMA remapping support for VFIO
 devices
To: Sairaj Kodilkar <sarunkod@amd.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 peterx@redhat.com, david@redhat.com, philmd@linaro.org, mst@redhat.com,
 marcel.apfelbaum@gmail.com, alex.williamson@redhat.com,
 vasant.hegde@amd.com, suravee.suthikulpanit@amd.com,
 santosh.shukla@amd.com, Wei.Huang2@amd.com,
 clement.mathieu--drif@eviden.com, ethan.milon@eviden.com,
 joao.m.martins@oracle.com, boris.ostrovsky@oracle.com
References: <20250502021605.1795985-1-alejandro.j.jimenez@oracle.com>
 <77942c0b-c7a4-4614-b0a7-f8d047cb47ee@amd.com>
Content-Language: en-US
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
In-Reply-To: <77942c0b-c7a4-4614-b0a7-f8d047cb47ee@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR12CA0012.namprd12.prod.outlook.com
 (2603:10b6:208:a8::25) To DS7PR10MB5280.namprd10.prod.outlook.com
 (2603:10b6:5:3a7::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5280:EE_|CO6PR10MB5586:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cdba0d3-8197-44a0-b540-08dd98101774
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K1F6aU94MWNDVXFWWU1aRDQrZy9lNzArck94VlZCYkQ2cEVZSll4RkZIV003?=
 =?utf-8?B?dXl0QUthWDFOZEthNWE3T2RGTUhzd3BNY1pjWEQ4UndxRlc0K3Jlei9jbVIw?=
 =?utf-8?B?bXRmV3pGd3ViRW45WTJocjc4R0xleXpueE91b2FOc3dvYktYc2ZtRXlsNVFD?=
 =?utf-8?B?L3pXR0VqV3RLVElOeWpEOFlZam1TV3FLYkNCNllNRDY5S0tTbEVhclpML2dO?=
 =?utf-8?B?d3lOd1lzNEc2M01UZEE2Nk9UMnoxcWY2NzF1Sy9lelExT1VHNEdtaENYL1pp?=
 =?utf-8?B?NUhZZUdyK0xrRDhKdjZVTTdaY3ovMVd6U25oNkVsNFppeW9yQ3g5NWtPNTlV?=
 =?utf-8?B?aW41SENKQzBrczg0Zk5MRmJ2TkxrSndORUJsVWJ0RGx3VW5oaTJoU0RTVklj?=
 =?utf-8?B?RDhwSXRxOGljVU9ONHpUbUEwZmJCc3ZLd2FpTGpwTitscWVEenllbElraVdE?=
 =?utf-8?B?VWxpU210d2tGY2htMldjZlB2OCtTNmw2bEdmRjN4MmhFL0JlNG03TmFra0pO?=
 =?utf-8?B?a3hZTVNodnFHSnQveWtmOEZxaCtzbWpmd01NaVNINDBGN3Y3aTdWU29ZRnBT?=
 =?utf-8?B?MFdmMzRBanRXaEJHUXprVktobHpxd3FEcnFXQ1hybnI3b3FVeVpuamxxejd3?=
 =?utf-8?B?VmdZUnpGZjdDemNQL0pJNmtGTms5ZUh5RlY1a1dSSzEyemdIZDEySjFZNWM3?=
 =?utf-8?B?L0tQS25RWExwdTVHblc5TnNBc2hVNVZxb3FpSmErSW1nRWRtR1Z5RWhvMVZu?=
 =?utf-8?B?OFc1THZpbXUxc1IzNHM1eC9TaFVXWEF0em0vdjlRTlBJWFppZE9HUXhvSEo2?=
 =?utf-8?B?UTI5SjR0WVV0UGloZHFpOUV6WW0rRWhEbTZMZmMreDlNa3FBc3NhK0FBT2VH?=
 =?utf-8?B?ZEVGbXhMeGwrbU05RmE2OVNDVnJhdVNnOU9XYWV5QnlZM0Z6Rm53LzUvQUlC?=
 =?utf-8?B?SDlFa2FvY29IbkFtcExZeVVwWkZZeGhldmRhNHBxRGhmbTFienpoZzlaWWN5?=
 =?utf-8?B?czFtdGk5NUhxb3FlelVZSGlYTHNkbzlVVWE3QXdDMGxTZi8zZUxiUlRQWTNI?=
 =?utf-8?B?VE5ZdVB4M2RHeDlCNnBmbHBYY2E5MWxXRVVGdlBkdWV5OWxHWkMzMEg4SDZy?=
 =?utf-8?B?ZUFZd1RRSDhERUkydlgyT0xmUXhvWnlFOXVUVExGVGltQ2E1MzNxYk1ISU1B?=
 =?utf-8?B?emxqcnJtdHI4bXVGa29pYUFmQXN2T1ZRUUFWeFlTdk1FWkRvSmFCTktzWG5K?=
 =?utf-8?B?Zyt0SVJWUURXc1V4Y1B6L1JIcm41ek56azMzaDNoN0NQRjVFaUdiT3lja2hH?=
 =?utf-8?B?RVFhclhoV1R6YWkwSjRlUTdXTjN5bFp3Slo5eVNDYU0vZFJqazFFZ1FkU1p1?=
 =?utf-8?B?cE5BakpzUmF3Y0taS0JIN1VScWMrd3JvSGRGa1lXKzRoOVM3Q3dERU5UMFNp?=
 =?utf-8?B?Q1JxWkdrdU5tUStWaUNkUU4rRVZSKy9KTkJGK0Y0aEdBNzJlRDZQc1kvcnJi?=
 =?utf-8?B?QVgyZFZCQzlCclBCSlA1MEdNWVBSRzIvWFNNZVpRYy9TM0Z5bHNzb0o3TVE0?=
 =?utf-8?B?dGtyNlBxejVuQXVqWFpiM3A1ZzZWZXVpaGREbk9nNUtRV1NEWTdPRkZGLy9N?=
 =?utf-8?B?Si9LUW8zL0VJRngvcGpoQlFtMXA2TGJyZk41Z1NYWjEyMXZNempPZFZUQVdw?=
 =?utf-8?B?ejhiYktjQm90OHZIS281bDBCa0FWSmlQMzFUV09zbWthaXdkbnhSWWVBbTNq?=
 =?utf-8?B?a1lrc2xMNndUWElVY1dEaUhKR1RtRzk5V0JUQ1RIeEhiOXpXbW5PSGpYSm9F?=
 =?utf-8?B?ZHdlYnZwRXQ0MzZ1em1uc2pvMTZyRWVONWNGTzdJZ0RybzBpa3FlMTR5SW03?=
 =?utf-8?B?UUNpa2dsTUt4MDd5NDVjMmkzcWNETEVHeVlWZlpWQm4zejFHejdiMjZGRTRC?=
 =?utf-8?Q?PYyXMp8SWW4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR10MB5280.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dmxpTDJrRVJpbkZXYVRWelZFT2NyQkxoMGM1SHE1YUljSjI0M0ZwRUNsT2Qy?=
 =?utf-8?B?U0E2NzFlV0ZVT2EzMzhwcVcyOGUyWkpPcWoxdzNJMXlBbTV3REpGUlIwaDFZ?=
 =?utf-8?B?MWZFZFgvN1ZnOVNPZG43UWFIT3Npc0tSUVZkTENoL09IWGoyVWZFVTBsNEd2?=
 =?utf-8?B?N1I5ZG1XZHZpVmMwV1N5UUNiK0NLc0lreDFSenBMOHBPRlZPb1BsejdqY0gz?=
 =?utf-8?B?Ulh5dmJLTGQyODFISU9IVlVEMG1OYWlyVU9CYW9LK00xcEo2TlRQaDh3YTlZ?=
 =?utf-8?B?OUhiN2Q0YWl3MzBUNHlGNzNsdCswTlVrTW9wb0toZDkvV214a09tT1FzZHp1?=
 =?utf-8?B?MDhrRktiYXphMGpSeC9nVkU1WkREbENVOEhJWjRhcmVFaWVKRHpUZDdhdGRV?=
 =?utf-8?B?YW1RbzFaTWVkTUEyRktBNlkySWtaZ0pHNjkwSmFqY2pqMGtEd0hrZXNyN3My?=
 =?utf-8?B?akc2VGczM24xK3AvT05rUThINml6QzJLdE9hN3VmQlhraE40T1VBRVJVRHZM?=
 =?utf-8?B?NEtBaVEyc1ZNUEhRZTBuNisrcnZCRU1qWWJvYW0rNXRoajNVemFEa28waFZ6?=
 =?utf-8?B?K2lhWGhIdlV0alUxaE1vS1V6NHc3cWFlZFBITFU4N0xHUTArRDdBVDNueVRO?=
 =?utf-8?B?ajd4dWl2dUVFRlBldTZpK3JZVDZlQWJTWE1lTlVQcythWE1DV2JZYWRlNnpo?=
 =?utf-8?B?YWxOZEdYQnJ3ZGNoeC9VbTlTb01KSDV1WlB3V01BUjZQYWREYmhwYmJyWEJK?=
 =?utf-8?B?Rmp2QUFuUHlGNjNOUXR0NHY0RUQwb1ZwUXJiaUd0U1MyNUZxTjhCTHFod1ly?=
 =?utf-8?B?K3FaaTI3U1hPaGg3VzZjay9Id3hEUVpkTXN0QVAwVlJUVVpvdXErdUVjOGxU?=
 =?utf-8?B?QWhDV25CbmhaUWxLZVkzeFltUDhMWHBuQ0EwTThHeUU3VEZwYWovYnRCd1U3?=
 =?utf-8?B?dWJRWkRXbGs0OWVRMXo2WlprRHpva002M3ZKV0Y4bmVDRjU2dFFyNFdmd0lo?=
 =?utf-8?B?UUVnaDdzMWhnenlLWXdCNnR5RFFodVlPMThYTk5GU1kwZjQwMWdLZnM2Zk5M?=
 =?utf-8?B?dFlYamJScy92T2xZZlVXZWhKSTN5WjdrWkNZcXNtOWZtaGxKZEhmb0xrQi8z?=
 =?utf-8?B?WDdjRnFxVkcxb0NQS0hISnNPS3JQcFRoSkVyZ1hNR1Vwdm4rbTJwRzFjYktB?=
 =?utf-8?B?OHhGMVI5bHlZSWpPMXlZandIamFiUkptYjRvZE82YnJTR0NZaml5RU1ZUklm?=
 =?utf-8?B?SHJWUGpaZllmZG10TmlTZjJqL3kzQitxL3ZFaC9XY0hxWWcyT29VWGhiUjN1?=
 =?utf-8?B?UzRyeUN2bTZaUlFmSXZVc2d2VElueENhRFJyM09ydngydU1UWXlxUUVHdGN0?=
 =?utf-8?B?SW1UVzZ4VHA0NW5HcDQ0THgzQWNNaTF6S3hxdzY2QmpCQSttNnpZejBMbEM3?=
 =?utf-8?B?SzAwVHpCeHpWMVFZdFFrSVpxS2swMlJFM1l0R09pQ3EvUFN6RFNJTHA0dkJ6?=
 =?utf-8?B?REt4bWs3a3ZFczRnSS9RM0Q4MzVDZ2tuZ0RjRkpRZlZLcG9sYWZrQzJiQzVL?=
 =?utf-8?B?dGQxaW5sVXpHN080ZE5hbDZkaDNuQnJKWFVubXNPRlJRVmdVSm1jczdzWGo1?=
 =?utf-8?B?bmYzRUtvMFpGcGFUdE84eSs3cEJCNElOa2h1aTVuMXYwSEpUZVpEUm90MUNI?=
 =?utf-8?B?aUp4WExTOUdvMWQ4alBBRVBuNi9iTWQ4QXFGNC9Sb01aeVhxNHhtLzV4cHJP?=
 =?utf-8?B?dVlEd2pjYnUzRWxUcEFNTlRBdkFUSERhV2ZvL2JrME1KY0NuOVZINndsYTln?=
 =?utf-8?B?QXpMSkg5WjRyTVJsdmlNdk1MZVh6ZmlBZ2VTRkd4OUFPNmw3eFB6V2I0aTlT?=
 =?utf-8?B?bEJ4SHJQT1NtUHVGS21ValZNenh4bzBHcWlEaWdNUzJ5Z3JabzVlN2orTDFG?=
 =?utf-8?B?bitDRStDQzZLSjMwbGhualYyZUlyb2Npby84T1FRUHlCU2NpWTVaREEydjRt?=
 =?utf-8?B?VDVmT1dvOFQ3cFFSV2R6cjRPYWF1bm5LNk8yWHBwRDhoK0ZDbGZHRzNSb1Bn?=
 =?utf-8?B?Uk8ycTcyTys1K1ArTDlzKzRZTWk1c3dyb1VUQlBlYTAyYWRjMFd2YU9lYkhY?=
 =?utf-8?B?ZWhEL0tpcDFTeEx3TlRNN3BsSTNFRGQwazhZaEtsVFdXd2g1WTBWZWZjYVpz?=
 =?utf-8?B?VUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: TCnn6+uc+pfCLFVwOg58weFU7oKRIn6AXVLES/atgNG95pD+c5kTVhaTpNnILaMZsjistU7n/LrJ+dsEVObssyHVar1hSSxotTc/zurPDssD2gnIZyWRva4Yynll8WqOq3+X6xAMVGTkp0hEMpGwBR/TM9KSFaq9LCvkqC3hdA3SXiD/BFW3BvB53ZnY5XTdHmtGHiUYnk/WgYSPBGm6TDQfpsOGFm6i23d5w4gTVqde/0bwhskYwIxsd7mbxffwN0ILlLey0JBubcprtw7npz4CkMX3FEf+A5MUxKT+LvjEVzhkX6qeKzd/4JGRqRKRf0FNSZy3fUQfn7tlapYlaVy+VNWoSDFpy8tO34ZiSSLx5dF0mGk16RKpvd+Wv/eVFgyf2fXELFMGjPWj3zESDH7POiw9t0f3XBqlqoJ0n6WPsqNbpxp8Lm39IOZpItltI4p0SEsHnoGd1UGiTIvhjYgKzGmcoW2hTtWe58KazhUuTITIv9NMMYBZt6CAbakgSLUYqY4ZpA/3qWU9HLZWODG+bPwviEkGygjQTsNJ9uK0LgtRrERmnavaTkRvFFBAWC1bZpq7tEpx5vnSzKbtjfbebSSo8mG5YV34K5Vh6yk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cdba0d3-8197-44a0-b540-08dd98101774
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5280.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 02:35:03.8715 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D1x3Z+T1+OX6/COsQH1bY4S45JBGbSoD0ZXBXKlVSQkU5R3gSAfDKA61YFVZYoJSa3LAaexeCie2oSZ0W9rcSX4y7nfgWQhjpBKP04dzE2U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5586
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_01,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxlogscore=999
 malwarescore=0 suspectscore=0 phishscore=0 spamscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2505210024
X-Authority-Analysis: v=2.4 cv=AKGD+0P9 c=1 sm=1 tr=0 ts=682d3bdb b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10
 a=KE_f00lZGvYtcec-k10A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: ScVVMlTMaui-mJZKXE2DthaA5KLXyP9t
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDAyNCBTYWx0ZWRfXwCc7qCCqR+il
 aVKu+xyYtGc95eltYlpmwuCxL0/dnpjxt2wuEi7YcUkjfv4TV+V8iLyZkd0QHL30EPkeBR8oJSo
 UtGYsaPWMdvlCQuD/3v/HlEMSwAED6dW0TlB/CHa6frrw0XJhgIidVqeoAYJXFXtXvkDHK6KwtJ
 GDD9c/swPy/6ETUGDi3liqK5nlOWlNVLPXm+mYDUTvB3kSVFQSR8PU0DA7SzRWSXGXJJXgU4Hog
 XCBjClK2K2yVBfntMRWGNpY0/VN+c3ocGheUUY2IA8U/ly78v7r1CiyjUVWoAQkGkIWunqoPJfQ
 lb9pfIzbIhKKnBt2tN71FqVM7HKmXPvogRU/X44ePT+nPJYXlzOzpPZdY+QIl4DU2NUjNfL+jzq
 Gda71NN6PIytlz1h/mZg/s0dxvDkbnQZy4qOUs48V3IEn277LZJ0QYxVTvUCanssfwbHWF/y
X-Proofpoint-GUID: ScVVMlTMaui-mJZKXE2DthaA5KLXyP9t
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi Sairaj

On 5/16/25 4:07 AM, Sairaj Kodilkar wrote:
> 
> 
> On 5/2/2025 7:45 AM, Alejandro Jimenez wrote:

> Hi Alejandro,
> 
> Tested the v2, everything looks good when I boot guest with upstream
> kernel. But I observed that NVME driver fails to load with guest kernel
> version 4.15.0-213-generic. This is the default kernel that comes with
> the ubuntu image.

Thank you for the additional testing and for the report. I wanted to 
investigate and if possible solve the issue before replying, but since 
it is taking me some time I wanted to ACK your message. Minor comments 
below...
> 
> This is what I see in the dmesg
> 
> [   26.702381] nvme nvme0: pci function 0000:00:04.0
> [   26.817847] nvme nvme0: missing or invalid SUBNQN field.

There are multiple reports of that warning which would indicate that is 
not caused by an issue with the IOMMU emulation, but it is interesting 
that you don't see it with "regular passthrough" (I assume that means 
with guest kernel in pt mode).

> 
> I am using following command qemu command line
> 
> -enable-kvm -m 10G -smp cpus=$NUM_VCPUS  \
> -device amd-iommu,dma-remap=on \
> -netdev user,id=USER0,hostfwd=tcp::3333-:22 \
> -device virtio-net-pci,id=vnet0,iommu_platform=on,disable- 
> legacy=on,romfile=,netdev=USER0 \
> -cpu EPYC-Genoa,x2apic=on,kvm-msi-ext-dest-id=on,+kvm-pv-unhalt,kvm-pv- 
> tlb-flush,kvm-pv-ipi,kvm-pv-sched-yield  \
> -name guest=my-vm,debug-threads=on \
> -machine q35,kernel_irqchip=split \
> -global kvm-pit.lost_tick_policy=discard \
> -nographic -vga none -chardev stdio,id=STDIO0,signal=off,mux=on \
> -device isa-serial,id=isa-serial0,chardev=STDIO0 \
> -smbios type=0,version=2.8 \
> -blockdev node- 
> name=drive0,driver=qcow2,file.driver=file,file.filename=$IMG \
> -device virtio-blk-pci,num-queues=8,drive=drive0 \
> -chardev socket,id=SOCKET1,server=on,wait=off,path=qemu.mon.user3333 \
> -mon chardev=SOCKET1,mode=control \
> -device vfio-pci,host=0000:44:00.0
> 
> Do you have any idea what might trigger this.

There are some parameters above that are unnecessary and perhaps 
conflicting e.g. we don't need kvm-msi-ext-dest-id=on since the vIOMMU 
provides interrupt remapping (plus you are likely not using more than 
255 vCPUs). We also don't need kvm-pit.lost_tick_policy when using split 
irqchip, since the PIT is not emulated by KVM. But to be fair I don't 
believe those are likely to be causing the problem...

My main suspicion is the guest IOMMU driver being too old and missing 
lots of fixes, so it could be missing some essential operations that the 
emulation requires to work. e.g. if the guest driver does not comply 
with the spec and fails to issue a DEVTAB_INVALIDATE after changing the 
DTE, the vIOMMU code never gets the chance to enable the IOMMU memory 
region, and it all goes wrong from that point on.
But I need to reproduce the problem and figure out where/when the 
emulation is failing. I've tested as far back as 5.15 based kernels.

I would argue that while it is something that I am definitely going to 
address if possible, this issue should not be a blocker. I'll update as 
soon as I have more data on the cause.

Thank you,
Alejandro

> 
> I see the error only when I am using emulated AMD IOMMU with passthrough
> device. Regular passthrough works fine.
> 
> Regards
> Sairaj Kodilkar
> 
> P.S. I know that the guest kernel is quite old but still wanted to make 
> you aware.
> 


