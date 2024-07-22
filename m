Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2339C3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 09:19:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVpCt-0004cn-Kw; Mon, 22 Jul 2024 05:19:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sVpCY-00038h-Go; Mon, 22 Jul 2024 05:19:28 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sVpCW-00074M-9j; Mon, 22 Jul 2024 05:19:26 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46M7d1dH002351;
 Mon, 22 Jul 2024 09:18:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=/a6LwxJdWeQZQo5Uyv/w8H0+8YEv2hTHIlPEPHht+Zk=; b=
 a1w6tPM/BeR/5cJbFk/DmjL10B+GiadqUnQe3QI30xAtMaapkXFnz7jowDDFYfL3
 eaFEmtKDOggih3I+q3OkY/gR7Y2Kfi0OtajbFSBHxyu9SVd8a5oHi6Rg4WPyw1R5
 gS+g/L6pVULkSTdZwqI+nofyjEzfPu2e1stOg/GYDkkHA72tuW/f42quraZHyqZV
 NaVXoLZA05xkhZdqoT93iFeJ8vdJYon0gAixqW5zO1WWRp8vLC8zeT/X5A+PhmrI
 IugM7ac6iFRZUsG+aqg6M8O7Wd7SlMZAWgbVrn3DRR8/JJQuG4/iBQfX4YpovzVa
 iBwg1jTHks/Y8xLS/Pj8oQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40hgcr8x8n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 Jul 2024 09:18:55 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 46M91iMI009050; Mon, 22 Jul 2024 09:18:53 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 40h29ypdaj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 Jul 2024 09:18:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ORBeZsRl2PuvdKmy9shUe5DnfSaUIzkX6o3U9himlQQC+4/Bq54CDk71uO6nOaibfiIK6kAfNHXfRtKgwqo5KkU2XsJovJxnjJppKO5ZHYIKBU3KEh9ookjZJVyvgxumx0ThQAbf1wIUA97D11qapRVzPX1icCLOLEj1h/lqqp8dzquCK0ATNkQD1nmY1FZtBXVoKDJwXYdxhDdrzw/sUZNK1WaR88h/E0otBz7SrmQxNY031gpjBD9Ge+SekhpyfOampJWzPMcN8Sbl4bDZ4HDyKQvfop/cHKXrHleG9/XdwpQX2PGNK81bGLThaAVya8fO78QDs4U2Clqd1fwdyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/a6LwxJdWeQZQo5Uyv/w8H0+8YEv2hTHIlPEPHht+Zk=;
 b=VTHYciEI5X8gNY8TjMl2fd0EzKsXOddHgPfXVlFddzGN/f86gEXPWXHBWQ4K0M7T+lnamuK7HCWTaJsASsbW1+CpThhrTlshPcaWGgFJ3USuse+7opuiQXf7bNLPj1KfglwRL+GXVFojoEU/Bltz5gEfrmzQ38hyP1pRu2aA+OIuhqkL9jL87xkaEF7jYBcNBwBazuCrRB5OBJVmgZ9C8MuOcgceI6alF5HEAoRjWdMv5iCSvyTIJFaPgiSCtWdHSo5LAVcU3q5wrFNkHRVaWmeJoelHDSJTYio4hU8affQbs75DgpuWupLijDdBnhKPAQGm7KwB+AOe8ZENRKFCyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/a6LwxJdWeQZQo5Uyv/w8H0+8YEv2hTHIlPEPHht+Zk=;
 b=uTzuYintx20ibEItuXaQQ7l4w4sByzwIVO4bGmhSYKyONbiVNLPx5pHVWRAvLN/VS3ZMewqK6aPPZBvHDEN/KDgWcu71houF7oO4g4T9Qibkw9uwosnR7bNUCMRG0eR9En+pSwieXiJ/LIPyx8LuC3j8T7nwvH6Le40KgRbIDpA=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by PH0PR10MB5756.namprd10.prod.outlook.com (2603:10b6:510:146::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Mon, 22 Jul
 2024 09:18:50 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%3]) with mapi id 15.20.7762.025; Mon, 22 Jul 2024
 09:18:50 +0000
Message-ID: <dc487278-afb3-4ce8-a969-4625d2b76602@oracle.com>
Date: Mon, 22 Jul 2024 10:18:34 +0100
Subject: Re: [PATCH 2/2] vfio/ccw: Don't initialize HOST_IOMMU_DEVICE with mdev
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 chao.p.peng@intel.com, Thomas Huth <thuth@redhat.com>,
 Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 "open list:S390 general arch..." <qemu-s390x@nongnu.org>
References: <20240722070713.1342711-1-zhenzhong.duan@intel.com>
 <20240722070713.1342711-3-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <20240722070713.1342711-3-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0010.APCP153.PROD.OUTLOOK.COM (2603:1096::20) To
 PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|PH0PR10MB5756:EE_
X-MS-Office365-Filtering-Correlation-Id: c3a06910-3ca6-4a37-e8d1-08dcaa2f4c73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TlZPNEdQN2dWRmNEMmUwN2VJNzFueXhGTHNxbXZtTkhmRFNFblIrZDlzdEZE?=
 =?utf-8?B?dU5yQzdaRUlZUC9Yd2JISWVGRjRZVXFPaG0rTnFDNmF2ako2RlpBUDVHWmt4?=
 =?utf-8?B?Wm5uejZMOWNjUHNVbC95RENFaldGK25PaTd1QTF3dmFFZlRITCtzcXE3NGI1?=
 =?utf-8?B?TDl1RCtjNVY5d3FZSjNOckhjTzNSTDRKWXUvdTQ1WjNEVjZRWUJFeUxQc2k5?=
 =?utf-8?B?aGVSZjZ4NVoxcFhNN2R2SGhzQ2dPS3FUWmVTRkU0M1d0NHNhc0M2RWFLc1pm?=
 =?utf-8?B?WFkvQllPZHlBakxvRDFnUXBVVlk3d1BzcVVXK1JhSlJFWEx6M2ZhbHZkQ3pY?=
 =?utf-8?B?akhLUU55bS8zTVczVFc0d3RIditNZ09GR3d0Q3RXck9vOXpZczJFQlJLeEZT?=
 =?utf-8?B?Njlja1cvaGJuZjh3OWRrSmN1bis2T1JLSTRUTzZiQW9uMVhvcGNHL1Z4SmxB?=
 =?utf-8?B?V2M1eFRxUDgrM1o5ZHhtVzYydTBTUWpTUlJzajR1N0JHZ1BpZUhjOWEraWNp?=
 =?utf-8?B?MXNXYWZDMlhodDh2YXRWaXBjTzZ3MnNoU3J0WnN4dVZWRm83K2ZKMDlJbWJw?=
 =?utf-8?B?WGFBSlQxM1ErakVDY2xBNnplYWs1c25nZFQ4ZjlIQk9NTU5xaEx2ZCtMeklw?=
 =?utf-8?B?MVlJcHE1YkNTOEhEd1R5RTBweGVwb2FZQ2t2d2RtQ1NYU25vQW1aUkd4Z0sr?=
 =?utf-8?B?cm9lQ3lieXB0VjI0ZC9mQ0pRZ1FPa0thR0NZekhReFdENzY1NnBWS2x1ay9x?=
 =?utf-8?B?ZEdYSHhmTHp0Z3BiT2xDRGFHZk9PWVlQWFBzelNHdHZKVGZOMlVlRHp1S0xs?=
 =?utf-8?B?WndWVHh6NUFxOElZcDhnTzBpam9adDRQVU85Tzlwdm1WcUJBLzhRM05VYk01?=
 =?utf-8?B?R29iODFEeS9KK01ZQStBZmJaeVVBeEtKcEsyRHo2dVdyYVR2QzAvcXVjWVMz?=
 =?utf-8?B?MlE0bG9aSFlGRzc5bUZ2dHJvd2l4YmFDL2NXdGlTSjJyaUkvRmorM1FKVkEx?=
 =?utf-8?B?MzJ1T2NoOU43OUlFN1FCU2J6VjRsbXRSUk1hZlJBUnZPV0lsSzU3K2NtSndq?=
 =?utf-8?B?MmtZV1lQckllM0N5VGp5RkFhY1huMTFqUWpqdjRXd3V6Ym42QUsxaFg5QzZU?=
 =?utf-8?B?MnVEc1FPWXRFQTF0QUFpL0J3aDBLM0NIVlYwbGwydG91MkJJc1dJK3JEME9t?=
 =?utf-8?B?ZVRUL1hxTlJXcG1RU0kxR0VvTFVVTnozbTZyZTU0RXhKOGExTDhJbGVnNzZ3?=
 =?utf-8?B?ekVXRjNCNFRnMDAwNVVkZitteUdHeHhLbW90cTZqNlB0Y2psdUtsYWh1aUps?=
 =?utf-8?B?Q0p3SUxvdTdUaSthR1ZnUmpaWEZhaGhhN3RVeW1uYkpMelhDdlRBamIzalpS?=
 =?utf-8?B?ZXRuQUwrTXEyRUVrYXNSNnFNRkpiclc3ZlNrTWhhSVV3QUxHWDFXMnlPTnhS?=
 =?utf-8?B?NDhMbjhOOHZXWEJkWk05cFNtUVlvTVdwM3p1YnZ5M1diY053OGxQcGxNTklY?=
 =?utf-8?B?UEdmOGhqR29ic1NGb2RBZ2RNMmFnUWpIbXNidTlqVmFQT3JSUkJ4Z1F3THRw?=
 =?utf-8?B?YkF2MkdhV01rUy9WQVk1cHZ2OTVEei9XcHBLNkxNTy81aGx6VGMyNE9xTlVP?=
 =?utf-8?B?Ymg2Zkdob0Y4ZWNOWkk2VVpkV3QxMEZ4WTh1TGE2dlVZODd3MkhIQ2NsSWtk?=
 =?utf-8?B?VGtROVFpWVRGaWV0Y255cVRGNXZZVlh4WWNJVmZSeHI5NXU5aDgrZW1KTzBy?=
 =?utf-8?B?TmV6SUx1cUx3Qk14eld1enJjY3k0K2FnN1JZVHFmZE9GSm90YWwzSmE0cGxV?=
 =?utf-8?B?WlNmUkNCSG5zR09JaHNtdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUpTQXhpZ1B2ZEY4b2swb2Nrc2dsQ2t5d3RsQXRlY2tTckJmNkNoT1k2RGZP?=
 =?utf-8?B?TTlpWStUNFJ1bFdTU081M0JxeUQya3B2MzV4c2I0WjdpWEI2WnNTQ3AvVXFv?=
 =?utf-8?B?bjhLTzlnd05mTTFyM3FWYjdNU2tKaVR3bEE1ZnlnUi9BQzhQb1llOHg1c3h4?=
 =?utf-8?B?TFpJdDNhQVQreVRmQk5lczFkV3gvTkh4QVkxM3lyWUxEcEtGVUpKRTNZMmIr?=
 =?utf-8?B?VXI2TWtLbjBzeWNXM0pBUGFVL0RiTTFzb3VpRFAwTlpaSVVmVHA3bFVhZmxk?=
 =?utf-8?B?cHc4Ynp3TVpKZXNVU3FMUmxYY0JFV2w3bnBkY0FiRWpvaFhtUUVFbkxVZEtz?=
 =?utf-8?B?OEZobnZ4aWVVbytBTmFCWmRGVlNmaE9yNG1qWlNPMHBPK0pxM0h0dG1IaFlY?=
 =?utf-8?B?UEFFa1JqWk1aeUlIbFhXamwrSTJpM3BWYmNxWit1Z0ltZzFGRDA0Wm1RbGJN?=
 =?utf-8?B?QndHVVZkTmtORmxwd2VFbnFXY1VkN2c5Q0pUY0U1VGlCL2pWNDkzL1hxQlhH?=
 =?utf-8?B?YkJGeDVJOGk2a1FTRHVmb2hwU0tNbGdsMi9DV0F3a21RanVnTnJiRnphdlRP?=
 =?utf-8?B?RDNaWlBucnJuZm5PSnBMSjU3RXgrV21FSmV4aWIyTXRwN1AwM1VEL1VHTEUr?=
 =?utf-8?B?Ui9wYTB1Z1NHZHdwSDEzbVovdXRQMXpiQkwveG5tV3RJRjBHOVZyWW5tYnV6?=
 =?utf-8?B?ZzkyVm5PaWJycXBvaFg3am9MOHpDSEJTNTM0eVBaTkJsNmhBZkljS2o4MzM2?=
 =?utf-8?B?d3pRemwzenB0MVNYZjRmWklJTUNVWXRvUkZkTGE5dFJCQ2E5VEFTUGRYdUxH?=
 =?utf-8?B?UEgxc2xBMk1Yem16bmZEbVZUa2YrMWl3MG8zdlRGcW5OWXZkSlRhK1V0TFNG?=
 =?utf-8?B?VGlKVGFSb3ZBbXNCc0VTRVdlbEZuWjdlSDlNWGhlcTFkZURrSVZsZGxWejBI?=
 =?utf-8?B?K0lHY0xETm9WNkw1SGFyejhEOEQ3OVNtOFR0ajd1WGpLZGtGY3FaVlF4QmJO?=
 =?utf-8?B?YXJqck8vYjU1YzVQVm1VQ0MxMld3UjFKbTIwbW9NSUVmL1JqeE0xYkcvRDdR?=
 =?utf-8?B?dHAxRmlaUk9IdXBMeUZnc1VXbGE0UVRwMnFnckgwSnBZRnFKOU1CanJobHIx?=
 =?utf-8?B?THZLQUV1M1JHbUpKcTJhdkp2NTh6OCswa1V2TWhvdi9BUWpuR1gyRzZTWFBT?=
 =?utf-8?B?VC9mNDNlbndDaElId3R3dnNITmgwSGszYlhUOFM2Y2Z4YzRoRm9BWTFQa0pV?=
 =?utf-8?B?ZHhtbjlmSzFBbjQ0RnhUZ1JFZ1JoUXNaTk9zZ2dleStrODRraG5uU1h0SGs5?=
 =?utf-8?B?MVBuS3Z6eWZUQnExMmcrV3hTZndXQ2tKKzUxUUVUWnhSdGtoaUM3NU5Gc3Fw?=
 =?utf-8?B?TlRKNlhwdFdqUG1Na3hQdThjeUlPYkFBdU9LaXRiSDljcjF4VndkOVRNaDhO?=
 =?utf-8?B?d0cyUEUzWTk4cHNBSm1jK3FzcHA5UzBhb0VsM1pkN0Zhc0pYYTc3RjhJRGIr?=
 =?utf-8?B?YlVZc0ZGMzF0K2l6b1NZNGxnemhoVXYzZTJUU0cydjMyK29wckUwdHYxYm9X?=
 =?utf-8?B?Nm1tRFM4T05lTDltWDJSbFArU0hTUTdRakl6ZUgvcFAyYnlLNjBLWWZ6UTRp?=
 =?utf-8?B?VkM4TElhUFZkTmNTZlFJUjBWdmtUYTVaV1o3S2lvUDhZMzRocHRQTU1hRVo3?=
 =?utf-8?B?K3VsSzcxR0w0YldXTnZoUXFYWndkMzJXSElPMU9xWGZUUUlPbmgzaFdyT0Vi?=
 =?utf-8?B?MUNXdTE5clNZdW5BcHhPL0VMQ3BmSmh4ZWFmUnpwTk9wQmh4WDdKSUpsS0pJ?=
 =?utf-8?B?blh1aWI0dm5NdnRlQ1R1NmxMSjYzWVovdEdKYW41VklpbGxkdStjNWM3Ynl4?=
 =?utf-8?B?cU1HQzJTekxTVldyRmoyTmMvalRONXZjcHhheWhENXpYOEk3c3VOaUF0c2dh?=
 =?utf-8?B?SXl2SDh6N1NxbGorUGhaL2RibGRRVXBING5FVUoyVGcvL1BwWHY3ck81VlNq?=
 =?utf-8?B?ZklyS051UUVXQkhOQUNnR3JpTVpScktvU2FpY0tXUU9XMDlWV0VjNWViL2to?=
 =?utf-8?B?UDBvNjM4emh6NE5UbjVqcFVuU2dyOFMvRGN4UEw1UUtXSWRVTGhFNTA4WkIr?=
 =?utf-8?B?S01XV0FVcUgyT3gyU2tHTEJ6dHVsZ0lzZ2NkWElFWFZNcmtjR1gvcTI4VjRw?=
 =?utf-8?B?aHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 5LiZk/1kYw+N/V2aIDe3O4VE0tTG3uBYaEe06zGDHagA2kbEUrtPKFgPXzlH/vUuQqJyHa8G0htVcueI/quEbAKmwPmd3ctnhUdK/mwuRLV732VBH65SjbaqpDqext0cFCP1SQgileyoWOTt7Ph5yhQ+qlQiRnaaoeYNJYtmcTOdTGAXqs52QylaA4iwHJh6F4WfcegxHhN52mtM2ONWCyq1rJYHlTU+dlCpviDsZIKiTySwOOuJtB+7+LyiTOEzLX9VxjQusnpdc15iPLxkyTBMFVVV5iKcMaxMrgGxpJx9C2uTUF0nrucmllLHA3Oo0lvL7C4Ha4x8dN9se+Y3z+CbQNpXubZ1cHUpFzLKHM8TX988Bi+BV1e0/pR9A4HjN2Z3wFyhYILaBlcYL292UXQ7dYJ3jAK37R0vpeqVaIeHg33IqEAsMdp1DxurkV8LE1GB9Znk70gg7tlvEH7jbUD/SyuUIXS05hoFFnCdIvW7xi5RCRFgcp9dTFGxd6ovjsTWLoRjhAw6OU0vTl8HuprrM4pr+4MxQ8JB8KrewG9z6kprDLFJ1n4ipixeIHOs0lz0Jgwk0llSsRx2flMRXZ6lPGhjTYehOgPSK9QZEWg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3a06910-3ca6-4a37-e8d1-08dcaa2f4c73
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2024 09:18:50.5685 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y19Oip0Qj9QHJXyKKpNEy9YFEI13vJCLNTcNr1SycZb/dYar6lJn2GWHXJ0PGKeerOa8Np3rp8zDmtdiOvlOszIjE8o75640h0TMxFWBxQU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5756
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-22_05,2024-07-18_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0 spamscore=0
 malwarescore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407220072
X-Proofpoint-GUID: gAAuQ23C0DkFFF-eAOMii6BOIHLRzk1P
X-Proofpoint-ORIG-GUID: gAAuQ23C0DkFFF-eAOMii6BOIHLRzk1P
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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

On 22/07/2024 08:07, Zhenzhong Duan wrote:
> mdevs aren't "physical" devices and when asking for backing IOMMU info,
> it fails the entire provisioning of the guest. Fix that by setting
> vbasedev->mdev true so skipping HostIOMMUDevice initialization in the
> presence of mdevs.
> 
> Fixes: 930589520128 ("vfio/iommufd: Implement HostIOMMUDeviceClass::realize() handler")
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

Reviewed-by: Joao Martins <joao.m.martins@oracle.com>

> ---
>  hw/vfio/ccw.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
> index 1f8e1272c7..70934b01d5 100644
> --- a/hw/vfio/ccw.c
> +++ b/hw/vfio/ccw.c
> @@ -675,6 +675,9 @@ static void vfio_ccw_instance_init(Object *obj)
>      VFIOCCWDevice *vcdev = VFIO_CCW(obj);
>      VFIODevice *vbasedev = &vcdev->vdev;
>  
> +    /* CCW device is mdev type device */
> +    vbasedev->mdev = true;
> +
>      /*
>       * All vfio-ccw devices are believed to operate in a way compatible with
>       * discarding of memory in RAM blocks, ie. pages pinned in the host are


