Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0439ACAC5B0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 13:42:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3E8Q-0003Oe-Jh; Mon, 29 Sep 2025 09:41:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1v3E7G-0002l0-Sz
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 09:40:39 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1v3E6x-0003Op-Ne
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 09:40:34 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58TCYtrc029274;
 Mon, 29 Sep 2025 13:40:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=dOnhcQklxyfkmxH5Jimqkzjvk/BVaKGs5H+JKlz3hvw=; b=
 FA6DBixYS1SWaBCgxaOzZcitiagEtKgqJ82O5OGpGpbjBA+FYpWgbWQrvUppUcMR
 bcewkZ3YHYjhgsol4yJL8QGqUHJLwCXma7rE0U4G8SQOiYzFICkRzN06pDTlQkmQ
 HaxNh2VkJneXDBkFd5OKu9gGIQ9soCgraFijK6/E69ZuMLVTDn33a9ssZ/dKXHC5
 AwrfXdbxZ//eoyZlQDsA83FTUSo82Pgp9kyEaR9DEDchLK6u6Du5Je9FmDHtvtI7
 ppA2upXH5qVu194W8bbAIsIwxZzHI7p3XLM7W+b2o9bilefeLRibadv+QFWfIHdw
 M5YsunPPnqYzJnA5u0HlEQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49ft7cr4x6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 29 Sep 2025 13:40:00 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 58TD7uJp011545; Mon, 29 Sep 2025 13:35:00 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com
 (mail-northcentralusazon11013066.outbound.protection.outlook.com
 [40.107.201.66])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 49e6c6y6mx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 29 Sep 2025 13:35:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AZEloSW1wdhsJWezT9azKGQKRJUeZr2ri95N8yWHv4Zu2zJsbG1mSqvO4YSuPhy10DJhtSMYhtCqNAQHKGWz7uZjfXjrAYq4ABabbquwFWG6VWinEoKctV65whBjdfO7eTLQeRcF04jHTE9GmztbAyJs999d7RmDaKI83TASuA4ejwI+S5mieS7YcDBFSZsuXtRlx/IlP94KInYdE2pZKzYIJc6tuLEHIivxaU90NTtpQuwxLMwtsw4roa2OfkJhZl2IXRkhkNuGK6bc6Q0K33AU/Im0UDR4ylhqVvxETWLYDzVQ5tW1qmc7BF7k9NuX7tzkv1yiOBWcQLW3AGuoRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dOnhcQklxyfkmxH5Jimqkzjvk/BVaKGs5H+JKlz3hvw=;
 b=hkC7AdjFM418HqNzwzCvFp6zBgIGRc4+v05sLt7K5lKj/CdKFk4HnCAcs4Ojwl1QHlhsRGdYu43PmxUA2JhK+aWb8f7Vx28MfPLQpJBIg/JpUlTjvj1uDXIhGY67moYQUo+8sQZGAbwYea6yP3AcbNtMbwIzfq2752djc0EgKChS2tPt0oQU+zrWXqE34gQpwrCdtbX2HX0zJyIuleHXMbMJwF0IUGVJ9cneTmnEKKBj9vEALDVRTKmVIgNe32HFprIWJCsLi2Eeo/Am5er+IxP/WS7mV06TE2GJvdgZE4IGoa8ymvtKTNzC5534YnTrvv6p3hIi1cWgtcOKvA+S4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dOnhcQklxyfkmxH5Jimqkzjvk/BVaKGs5H+JKlz3hvw=;
 b=XjPQ8Oo5MsOT18LffoM+vfFGONt7BhSN3SZGLJawjbb9nELxrWX2RgPb/v+tJjeWA1qTwQuLMT/CzxoOUCyXZbhHbM+64oKdpIgAQ4ij0ac55OLXieoTw34+1IDs0DkWkRKg+V8TVYN35nCvoLoyM6y/XudJpr8Shrlul2zmJ8c=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by PH7PR10MB7085.namprd10.prod.outlook.com (2603:10b6:510:279::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Mon, 29 Sep
 2025 13:34:57 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%6]) with mapi id 15.20.9160.015; Mon, 29 Sep 2025
 13:34:56 +0000
Message-ID: <011cdcf9-f918-4ceb-8ef0-acfc20d15c11@oracle.com>
Date: Mon, 29 Sep 2025 09:34:53 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] accel/kvm: Fix an erroneous check on
 coalesced_mmio_ring
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 Markus Armbruster <armbru@redhat.com>
References: <20250928085432.40107-1-zhenzhong.duan@intel.com>
 <20250928085432.40107-6-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <20250928085432.40107-6-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8P220CA0036.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:348::16) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|PH7PR10MB7085:EE_
X-MS-Office365-Filtering-Correlation-Id: 12a0bc88-09a3-4622-0f69-08ddff5cfac3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UmRpaEYxUjhVVXpVSzREblcrUjlDR2VUTldBVE1kSi9QZWVOUVErTzMvZE1H?=
 =?utf-8?B?alJTeGRmQnlHWjZtUUpkUDNveUNIbkFSMXkrUFR0Rm50RjRxaytkd2xrTFJs?=
 =?utf-8?B?elpzQTZPZ3EyV3Ryd05GSFE4TFlNdlJCZnM4ckRMR1BFQ0hJaDRJLzBhdUY5?=
 =?utf-8?B?d0ZheWpEeXFycUhOZmRkM2VxN1VNdEZNQ3Fja3haMGxLbTlzV05ZL2JaM2t4?=
 =?utf-8?B?WmthUU5yWFc0SCtHdWladDNsNTZmZWEwRTJZeEQ1VmdFU3FvRWhmVXdGcjg3?=
 =?utf-8?B?MlgvYXkrYzZpSHg5MEJLdkZ0NXhmRGx6UnZheEk3M3p0TWY0SDI4b3NVanJy?=
 =?utf-8?B?UmlMRW9PUWZEUko5OUQyMFR3alJiUC80cE12TUt0RzBQWHU4L0pPdGFZaDhS?=
 =?utf-8?B?Vk1hYWVOMGNGbi9LOFcyNE5DYmx2elgzSEdlUzY3dmlDNFV4U29qZFFraVNL?=
 =?utf-8?B?Y0VIZndGa2s2TytEMDNsQlBFRjhUT1B1R25qS3VRRk5jeUM4RWdMcVlmMi9T?=
 =?utf-8?B?TUdlZmJUM1hOU0VHWUNmQjR6czRGMGw5TEIzS0VrL25FMnoyL1hGWmVtenFR?=
 =?utf-8?B?Skx5azBTWHJxYnVhWkxzZjBxMUFjYTMvcWFLMHdIYVdoUjBnZjFERVg5SU5O?=
 =?utf-8?B?YWZDSW1GVElyVjNpQ2E4YzhtWXUxK294RCtKanc0a0FlOFEvaCtuYUcvVWpB?=
 =?utf-8?B?TGJvWDVybUtLQVNRNFd3Y2pSRjdOZm40eExlR01GeDBxZ3RabDZ0M0l3Zjdn?=
 =?utf-8?B?aWcrcEl4cVdtTG01UU41R3JnMWdma25GNmVFMTlNc2NQMHdpTkdoU1h6NjBG?=
 =?utf-8?B?b05Da3dSYWlRMWF1Ylk3WXZ6UHRxRTMrSnhLOVE5TWVLeXFUTU03WnR2akE5?=
 =?utf-8?B?L0dxWmFBUzZNcEl2UnNVUXllQUpGQXpQRWxQNTJBK2N0ZWZhNTZjN1NXYWpw?=
 =?utf-8?B?UlVhZFRNcktTcVVIc29kMVRRNHdqYVl6WlZCb3hTQmlIWDdmOExBWEdKbXk2?=
 =?utf-8?B?dWZKdHBKYVBZank1VWF3QXNGN1hWbGZyRnI3L2hzY0JqOHZvUVROdGdOaTQ1?=
 =?utf-8?B?NFVzL29wV29VTit3RjhwZDdlMGZsdnZobDAzdzNIbzRQdkhFQ3daNVo3SEQz?=
 =?utf-8?B?M2xIZmZlZkVMS04yN2tYcEl5dWZOQS8wQSs3b2RPRCtBeTM2N1YxOEFGODh6?=
 =?utf-8?B?dTVTejZjUk9PZmwwVGUrTmxZUWtROGFRM2lSNmxmekNibXF0bVE5N1VLUDZ6?=
 =?utf-8?B?a0duWVBnaTBpcDdOSURTbVZudlo0RTZZNGg2WW5QL1FLTjIzcExDaGRUMTZP?=
 =?utf-8?B?ZzVjSmE2ZGJxRUxkbXRJQTlIYlRMQ3Rtd1JzUkpRUlhSY0ozUVJwSmVqNmEy?=
 =?utf-8?B?T3hHMXFPNkpyNk8zcmJKdFBHN0NFL2VKeWZXN2dBdFJyMU4yalF1WmYwdy9X?=
 =?utf-8?B?NCtnQzBEdDg4MUxsdE1MY1B1TzRZb1ZvcmZCZDNWemhGcHRpc3I1d1JXcXNn?=
 =?utf-8?B?eUp4MWV2ZWNKUm1xYm1mdlpDMEwxZFNtTjNmRDFSYUM2d1UyRlFkOXVPM1NX?=
 =?utf-8?B?dXRhZTIvUExyLzFRZGJ3MHhyOVJVRUJuZUM4c2Q1WVdKbXM5WS9lOGU1SlBi?=
 =?utf-8?B?Ty9KdTI2RnFBSk0zMnRDRkFtVmRDUHRsYVgxRnc5T2syNTl1U1pHT3JLV3cy?=
 =?utf-8?B?L1NueVh2MUc0Y01VTVJkZ2VCTzlnSmkxZS84RlBFOC9MR0QwSFNuUHFUOVpW?=
 =?utf-8?B?WFhjQjBSRWNCU1pNY0Y3VFk5Q2kwWjdxYllYNEpzM0N5Z2NRU3BKMGkyeUxv?=
 =?utf-8?B?blAwVTBPdjBiWGYwTEphTWU3dTFsQjZSV1JIb1h2TFMwTzRrYmVEM3R0MkxM?=
 =?utf-8?B?YXNZYkJZS3VZb0VsZ1lZWGRZQUordkc3d0hjNUVINU1NWHlqa2VEb1E1MFJG?=
 =?utf-8?Q?QEG/tO7or7V9yHSz6DR59vD+GwNfWaUJ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cDlsWlpnVHNaVTd1amxvTHVwUFB6T1NoRVhQdDFsYVZzbFBHelN5dDFFNUc1?=
 =?utf-8?B?eGdEVlhuSWhFQUtxcS93djdPOStRREVMZU9MRmg3Y01MV2xNcmE1R1lFd2kx?=
 =?utf-8?B?eFR3d0NmcHBQdHZCcElWVDMwamc1TGNxTGtMdTlRbVErZFlQaXhhdTJpSktC?=
 =?utf-8?B?bHFkZFgyZFp4N2VwWlVBeCtpeDRRT1hFQ1I4aXhuVjFLM010a1dQd3BiY3o5?=
 =?utf-8?B?ZW5uWHBxeUlkT3U2Wkp6WGN1Q0l2cXJrU1NPY0xIdUxHMmVZVjZkS3RYaWJ6?=
 =?utf-8?B?QTNJUTdtblVqczkwc1d1dWxzTDRmWWgwZDhtSzY5Y1k1UTRLYU16UU1PQUZ6?=
 =?utf-8?B?c0dDcGo2L3htOHhTVVpmcUIvd1FSSFhudUVGaDZZUGlBaFR4OHJxRFQyTUJ6?=
 =?utf-8?B?Z3BZeTNXY1AxK1V2eU1xRWZYR2FJYUM4eERMVWhsWDJoUThHWkNRR0VSdkpy?=
 =?utf-8?B?OUh1dzFibVhVTHRJWVJhRVJqVW95M3o5aURnMFRhc2JzMUhyQUhRTUhnSXMx?=
 =?utf-8?B?UUxoZm41U2ZSd0lZbGF6ajczSFlqN1ZHbnlFZnpYZXlKUzJMZE1KQ0g0bTVn?=
 =?utf-8?B?dkFPOXpia1pyZTBSWGxlT253Vkk4cmxnUlBoVXFTaUQ4SVArYXUyUjRCUng2?=
 =?utf-8?B?R2UzakxOVGhrR1dISEtxNU1OdGZqRmtyWVB2U0Z2Y1ZJU0FJdXJscDdYWXNo?=
 =?utf-8?B?bWx2alNtU3pIKzE5NW9FZUFTcERseDV6VC9uOFY0dUZITXVSaGxoUlNJSU1H?=
 =?utf-8?B?ekI2RGQxdCtTUDBjYzhXbS8vL0Qxc1lmYzNoVjRTMGdxYmg2WW56UjQ1MllZ?=
 =?utf-8?B?bEdySG8wRXRnTk16VXIxVU5QQXJPZE1laDlldXFaTkZHN3dNTW1pY0krYlli?=
 =?utf-8?B?RVJXTTRzek5uUFUraVpXaWh3bFBPWGdxSDBVY3Y3VWFYaTlBMW8zYUc2eFN5?=
 =?utf-8?B?ckZBYTkxK0RnTVF1bFJRK1hudjFJMFRrS2FmbCtBSUZMdmZZS3lrbVFiWE5m?=
 =?utf-8?B?bFkvZVJuZVMrdEFxNTkvdXN1OXp5STFpdi9vbkZOMzFRc0psYk90dzVVa3FV?=
 =?utf-8?B?YmdXdU1OeFA0U0dzQ2V5am5SUFd3eDltalBhRFpqdzQ5N3ZsbjAyTi96Smtv?=
 =?utf-8?B?QlVNaW4vTjJ2bE5SNWFRUFNlSHRvQld5Q3JpWHREK1JCa1QwbkJyWDB1MnQ1?=
 =?utf-8?B?eWdMY3orZE1GZUk3QUJ4N0NONUdtRTJHb285Zm1xdmRaTFk5UWNsTEg3RmV6?=
 =?utf-8?B?TTVESmRTc08rR0cwNkxuakxhRS9pb1JtMmJSdE5SK0p5NVFHNnU4UDErOTVh?=
 =?utf-8?B?d3hId0ppWjVrM2JQdXN5L1N0NzlGeEJ5citFMUJhdEpFdEpWUm5OeWhLenFM?=
 =?utf-8?B?R1d0a2hob0tRL1duRG9ON1piVSthV2QrQUhpSVpaREVUV0ZaeFZUUWViclpn?=
 =?utf-8?B?WFJsTkI4Zmt1VktRWURTdXc4ckVqMm92c2J3Z1kyaExSTnJDWlZlVStBS3VN?=
 =?utf-8?B?cTFWcUxFaG5jODNyYlJYSHhjZWpLS3Nrbzd1VUMxMGwxcWM2NWV5N2VkQVd1?=
 =?utf-8?B?Qm03eXhSeEc3aVBBRjlwaXlHNnRuTnFsNWdDL2pFRmVwWndJNEsydDc0UW5m?=
 =?utf-8?B?RXRGMCtmbmM3VXptSWFQdm5qZWtTbGM2K1JJOWU2M0JZL1RxeElSZEhsQk9h?=
 =?utf-8?B?WDUvdEhVTWF1UlJHaXMxRFVibTdHS2J6SU8yRDZnbTNZbGZvUXBIRFlSeWt5?=
 =?utf-8?B?cU1ZWmIyNTUydG1FNEIvb1JuWVFZVmhMZDQ5cjQveTBJdU5XYkx3QTFCaWxo?=
 =?utf-8?B?NU1sK1MwL0IzM0E2bkt1a3Y5dFlIb0pHUE1uSkFQQTFTSGs3RFZSYk9PbkhN?=
 =?utf-8?B?aWlDNGpHejVqY3JNQUhCRndKY2JDU0t0a0J5S0JKNDVuRnpOL2RIQ0E0Sncw?=
 =?utf-8?B?TCt3Y0FXWVoyOVBsQXo2YkxNNXE3eW9jOEJJeFdEQTlHS1pIbnNhMUlsdHFK?=
 =?utf-8?B?b2JEdVkrTFp1K1QvOUY3SWlmWWxiYkJqT1JJU0hDYXVxdUJUNFUxWENNM2xn?=
 =?utf-8?B?UXVPcHUzWkhFRnhla0gwTVkvR1pGZGN1SlBzSks1aEpWem5jTGk1MmlpWUc2?=
 =?utf-8?B?c3I2Rm5kYlFCUFNFdGluRzNJMDFROVpzTlhiU1g2c0Eyekc3MUNDWlRobUc1?=
 =?utf-8?B?ZUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: QJYRXGbuhaPWpOitkhdGBPTGQlO6KC1KW2p3h9Z50e/mhfPPE75c9CoQDru6U0JxUBPNYOLaqH0Yp3PPsP2lJ9iygQHcGSo26O9TrQwtpu1Oz59Lv18DrqKj+AwdwVFXWMb6Ck+zFGcfuFfCi6LR1yCWV0BSWC2H68vnea0tZ5n5zKo+YgNdDZEIr4g5EFNKvxPLEk0+8kuDuSVXTLykaZXYCAEbEz01XwiztXci3kmHAMvKSAj8XLQdsqYseXjHl6/31DaK3dVqIa/KqBGrKec4C3vC3GYBhCGr9z1y4L1TU4kT81jWhA3cDHWDc3et0QizvzFYnFD+bqi6i8sy1pdAwtSrqhCeCVC/lqiPN+hd03yf6fYh5cltgDEopCRWaphQQb/nYbmqIjEJqkShS7zLxhESQDMSBDOiExIRTEafdEl5yOojtAWcFhEM18SEFf0hDYISfH7cp0z0s7w5hX3ced3kteE+Zl9AnDSfCY8N1FQWIrDd12k/kwA7Mu4Chna1t8vXLQP4NiThhelb9QEeNKcf56/dICNZ675hNrUnITSKzFArXhjITW4GDtH8BVnDNec8XZD3nK3vZ9EJ4aY4ZIcvFD8HDHOp35/hhVk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12a0bc88-09a3-4622-0f69-08ddff5cfac3
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 13:34:56.8101 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Fj7fQFAg5aDbSJK3LdrBgucbW39+d+IbyEi0mk3BVM0WY3XEf+YIaefQKDv+2KSuAcw/pU0qDtQ3fBunu8YiSbtPnk3EpR2EZfSOT9wcYo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7085
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-29_04,2025-09-29_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 bulkscore=0
 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2509150000 definitions=main-2509290128
X-Authority-Analysis: v=2.4 cv=cruWUl4i c=1 sm=1 tr=0 ts=68da8c31 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117
 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=20KFwNOVAAAA:8 a=QyXUC8HyAAAA:8
 a=yPCof4ZbAAAA:8 a=c-vfriJzW8-EUOynajAA:9 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:13622
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI5MDEyMSBTYWx0ZWRfXy6rdqq/oskcw
 2DgKkBiKzpcSWXEGxzZhnthd58yplckGmb4GB925piznzlK7IhmVArxYqijNOrs1XZ4uEDIdwRC
 opBqBmiPWCHiJCyNDxHoTIV0FsWz+R9S68fZV+eZIRs97FVurQ1AGxnPQd7w2Dq3GWPei18eJZG
 /b6pAbr3GZissFlnVgREbRyZgfwCapqP9MrcdJHWc5QDo7rnBjktGQCzHjU4eOctN/BFS3wMdWA
 roD/XrTQCo6ZNSi4hhF1muMJRkBlzGWIHKhl1lIt2g6ALrHmOW1NYqcFpcvkvGpAKWul4FujRRC
 1bzJ/1iqLg0s2tQ9E36U/LRvtIuzZ0Tkqqkd0AbQMTKJA3naxqeZTDJJsJ439k/FagB+wgdX4A4
 Xh2RsVDKmB8/herpy1hxcA9ydPwnlyxY3iwHAXyP2+q76yysWeQ=
X-Proofpoint-GUID: _gpc4iWIdSyLgV-3O81vmMR2ckdbYJa5
X-Proofpoint-ORIG-GUID: _gpc4iWIdSyLgV-3O81vmMR2ckdbYJa5
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 9/28/2025 4:54 AM, Zhenzhong Duan wrote:
> According to KVM uAPI, coalesced mmio page is KVM_COALESCED_MMIO_PAGE_OFFSET
> offset from kvm_run pages. For x86 it's 2 pages offset, for arm it's 1 page
> offset currently. We shouldn't presume it's hardcoded 1 page or else
> coalesced_mmio_ring will not be cleared in do_kvm_destroy_vcpu() in x86.
> 
> Fixes: 7ed0919119b0 ("migration: close kvm after cpr")
> Cc: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

Reviewed-by: Steve Sistare <steven.sistare@oracle.com>

> ---
>   accel/kvm/kvm-all.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 9060599cd7..23fd491441 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -523,7 +523,8 @@ static int do_kvm_destroy_vcpu(CPUState *cpu)
>       }
>   
>       /* If I am the CPU that created coalesced_mmio_ring, then discard it */
> -    if (s->coalesced_mmio_ring == (void *)cpu->kvm_run + PAGE_SIZE) {
> +    if (s->coalesced_mmio_ring ==
> +           (void *)cpu->kvm_run + s->coalesced_mmio * PAGE_SIZE) {
>           s->coalesced_mmio_ring = NULL;
>       }
>   


