Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E2D0C28B30
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 11:19:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvDvA-0000BQ-3h; Thu, 20 Mar 2025 07:18:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1tvDv2-0000AT-0Z
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 07:18:36 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1tvDux-0005SI-HK
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 07:18:35 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52K8Bu3T030550;
 Thu, 20 Mar 2025 11:18:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=5YQYe0LC2Ks6pL7EPFCCbweNK4/vMJBkXOpwG2FTIh4=; b=
 gZm4s0KCNtmqGkcWFS1mWcfTGFt0I3N38qE6nzJjY2ETLneeSFrQ1PZ2f57SW26O
 Tf119mhfMU9sXwGFXLKgv2gn5dMYvwueD9KYGy45zzgCIMeVnIZm69t6b2EL+JVI
 VO982iZN/+GlpUJa4mUj/3XnyUcYFEgPQiGVPiSFZpUA4zBa44P6ff8RHGvK45OR
 C0cLLGRr0MnI2Ka6z3anoTyoHLlk9BshzacN1+av5gX6SurjHucCk5jle+FPl+bj
 qxruVLj0tRgUANa+r0Kn2FJvU8AuFMXWJfxXEn0arN8O5NuQAQWtagI4F6QkP5Pm
 REoH4xBEL1sezmrY1WmSZw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45d23s5vfx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 20 Mar 2025 11:18:28 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 52KAAU8c022501; Thu, 20 Mar 2025 11:18:27 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 45dxej64jb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 20 Mar 2025 11:18:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s9cMQ1kAungRvIifNa3A0tAjkBrcUQL02bCn7x2KGz1rCAisu8hVqemugkZM3AaVMpa9FAMkEnUha5vTAGGgWyRFCty+WivQaNuoIds9P2Nmk767cZmRGvilWQuCJMYm8oSLGmiogPPk+M8oNlS3RruMpTN4iZ/zhnF/sFp+88cRFaefSvraOgIgsKjezNY0oY/JKxx8d/Tql32fAYEpwPWhHL24TY/piaZE68KYQRLj7LA/Gd6660xWggxmhnFLHoktoAW34ivK/ZamQMlTeNu+1CRjFRnA6UXn2OCxIGgH/PWOtP+eOidyNDp14cG0ivtjzd5sKSAPnu4SLVoI2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5YQYe0LC2Ks6pL7EPFCCbweNK4/vMJBkXOpwG2FTIh4=;
 b=BPpNiNuTmtZe9heKPzRwsAe30DmZ3DN5mf98OdsrtgGVJVSqaCjsEy0miJvIAcwwPEeHSFVKNefc4qZUVePb/7O/lGznovhkDNv13Tbixnhzq7+E5h2M2ZOnuMxbXTA/8GA1kjssz9C5nsaqGxKmkUxqUHbkaQ+E3AGe1po6pyMwr31CIREijgCjHFOQjsS6oRocuxRBUFN5vyXg8BNZKBaeRUb3wLzI5GXUkdJoMUHIsDjYZDI4ujlH6OSRKm09k7PpfhxhJUMrNMipvfblmH93PBcQ6tUtkGc7xPthPxVgnFc9nmFI2RFyVT3GrozZQ0Gt/KJrs9nUtGZTWJYgBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5YQYe0LC2Ks6pL7EPFCCbweNK4/vMJBkXOpwG2FTIh4=;
 b=WmeDperLL8RrB9YXAzJXn/N/F9y1Ttqc8ozJ/shGMFyI6X68bz5jNsbBDN5aaUPWLv6buL4NTE0FLemHpSbl4O4GdOThe4kIYwp1zuTIqeAyBQvTVDpgBY4Q0a2KrNEydmrFkOatnOJYYn7gw4JFpDPVvPHZthIQjAB5hP+4voU=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by IA0PR10MB6841.namprd10.prod.outlook.com (2603:10b6:208:437::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.35; Thu, 20 Mar
 2025 11:18:23 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%5]) with mapi id 15.20.8534.036; Thu, 20 Mar 2025
 11:18:23 +0000
Message-ID: <ea1b19e8-245c-449c-a7bb-31b79c62b799@oracle.com>
Date: Thu, 20 Mar 2025 11:18:15 +0000
Subject: Re: [PATCH for-10.1 30/32] vfio: Rename VFIO dirty tracking services
To: Avihai Horon <avihaih@nvidia.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>
Cc: Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>
References: <20250318095415.670319-1-clg@redhat.com>
 <20250318095415.670319-31-clg@redhat.com>
 <a6c46117-dc83-4a42-9a5f-0fcffb69b4f2@oracle.com>
 <621d6268-ca2d-4028-814c-f4c2ddf5d567@nvidia.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <621d6268-ca2d-4028-814c-f4c2ddf5d567@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0015.apcprd02.prod.outlook.com
 (2603:1096:4:194::16) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|IA0PR10MB6841:EE_
X-MS-Office365-Filtering-Correlation-Id: fa373117-68c6-4eac-1451-08dd67a0ed46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QUZkU3pxbVZQWWxCMjRTbzBrZnFrOWpFM2RuMnkwR3hHSmtZNDFqV2dFTCth?=
 =?utf-8?B?enN1WjZXR0ZRMWIzRDh5QjBIZFVlMHJXWVc5NW5wMnljc0FNbStSdXZpS1Yw?=
 =?utf-8?B?bmZ5a3N6SmRqTEZ4Q1lYRDVJemlRb2l0K3JsdDJaOGJkY3BMS2M4NVpDZmZ2?=
 =?utf-8?B?Rms5NmhSOHlPL2dnMjN6RXlhVDlwczVxQUxleXA2bDVuaGo4R1U4Z1doRFdX?=
 =?utf-8?B?b2VIcnRTU2t6VjlQaHRvOXVBQW5QV0NDNkxtSkJSUitDb29VTFBSMVl1bDNI?=
 =?utf-8?B?bi84aDI3NTVMblljMGpIS3NIVUxzVHRYMzNFQkE5eUoxejd3NXNuOXEzMFYr?=
 =?utf-8?B?U3FhTTRxaXVwazgxNGk5cjNIMkxQY1doUmRENUJKNFJqbEpyeW9PZkdSNXJY?=
 =?utf-8?B?dW0xK0p6R2xJWXJOeitLcDJvM3UxSWdNQ1ZQKzc3MmlTZFJCV1lnTHlvUlpx?=
 =?utf-8?B?aVN2a3VKNWVwenplSGg4aCs4TGh1cTN0TTZESjVFSkhHdjN5Tkw1RlZJaHFa?=
 =?utf-8?B?RVBlbU1mZVFVSThWNFNnR1IwTTJOTHU2ZXBxcmZSdHQzYXF0RHk5R3pEY1BV?=
 =?utf-8?B?SWFmNWNJZU80L2ladzIyeURuOWNyMTBPY3dlU29Yb254VmNaRGJvaWt2czNa?=
 =?utf-8?B?bFJPWG1nNFdBRDUwMmtPLzdTWHZ1MWc5L085YWV5d0xwWHZWa2lRNUJKeDN5?=
 =?utf-8?B?Zzg5NmJQZXVockRteXFhWDUrOFhlUFErVk5vR0xTT3ZnYTNNUUl1MFFQVmt2?=
 =?utf-8?B?RkFUeFhha0d1QnkxcEFlNGZrVEk4eEFWY3JQd3dIK3dIK0Y1cmZqbCt4TENk?=
 =?utf-8?B?dXJRTjVRWWFGYWFZc2g3N0ZDVDhXbUx4dkl5Ym5nQi9RUkNKYklTVEgrOEgr?=
 =?utf-8?B?UGVIQ3dnRkNkTVZYYUwxa2hzSUVFc3hJYUJ2ZkMrRDNwWGMvZ29DUklpWlF2?=
 =?utf-8?B?V2tKQkJ0d1VCc3RTdWtoSzZBV0VYQldkV3NtdFlRQWtEeGl4cHRFQ0NoM0U2?=
 =?utf-8?B?T0pEWmpaYVpSZnF1RHlzRHJIVU9VWGVjbHg0OFZ5N0ZCRTI3V2JxNWlFRXJ5?=
 =?utf-8?B?VXFHWE0zNEZOZTVUTGFQcVdXWkhtbnpmZG5nRHlWS3NmYy8zbG43WVZmVGZq?=
 =?utf-8?B?ZHpWZ0dKR1hCalJFZnNMQktFbXRyUDVmTUFobFh0ZFJPbWx1a2JKMWxiUTNt?=
 =?utf-8?B?NU1LMjJFNkVMY0M2UVMvNGhMK28vdDBpdUxERXhqOXU1WDM1L251WXorUEs4?=
 =?utf-8?B?bGRWR212YzFDTkFIVG1SdGREb1NXVWJlZUdDeUNlOWZiMzVEU0FkMDZ3Qmpj?=
 =?utf-8?B?RVFPVFF5R3RCeDlQTnB5MVNrTXdVcFIvd3NmMXV3bTkrOGNDRk5sRzUrOGtY?=
 =?utf-8?B?OXdDSVlwM3hwcE9NZU5xWVVxTFM2VUIvSnc0WnJPajdlRksvSmJRdWM3Titk?=
 =?utf-8?B?L0xwcVNMTUdZdlo0WlJibGxwUjhLZ1MzZklhdjI1dW9BVnpZUlRZRmJCMkxU?=
 =?utf-8?B?cGNXM010MjJ0SVVFa2ZncDlEMVZrS3JlQm1XMTBUNHNsWGIzSXVTQkpqZ2dn?=
 =?utf-8?B?Mzg5dWFBTWtBSnR2a2ovaUFFMjV4VUxLaDFkOU9jMmNwTEJTU3NORGNLTUF0?=
 =?utf-8?B?VFpydEFQdnFFZFoxaDFzNWdOSWFjZnBVR3l6YU1zMXVDayt1ZDhYcDdKZk5x?=
 =?utf-8?B?RVE2QjZQcTdEMks0TFpyNjJvNEFPMU5oMGdPbVY5MEpFbDRCY2szaG9PYlRX?=
 =?utf-8?B?WWtvYndBWVo5Z0prcDk3STllM2syMWpGaTdRN3UyeDMzMUxueXlBUTRDeGFR?=
 =?utf-8?B?MGwzWjJHNVczcVlhT2hsYkhMU2k5SFFwbXFXbFJWRWZhNWdnQUl3RXFiNFlM?=
 =?utf-8?Q?SyMSNS0y4PyJN?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bHNOY2tGSkR4MVM3eXg3UE9IZ3puSzhKSTlGek04bHVuZTZlT0J0U2NRWnRP?=
 =?utf-8?B?N2tRYU91UVo4VzFlbnd3RUlnRDB4UnlDNTk4ckdBOXNSZVc3M2EvUHR1K2hI?=
 =?utf-8?B?aWdzRi94RUxkU29yeTNKY2FQaHJXRnJmZmUzaExQSmZsYkVKdEczL3hyMVRv?=
 =?utf-8?B?Z0R4YWpUTytUbnZBVTRNN083aTZWbXhmVHNvc1NJWTVRTmllSVA3THQ3V1U2?=
 =?utf-8?B?VFcyVmtNQ3RmRWJGbldzbzlOZFcxelNLRjY1TjFRQnNqQUhoQlNhRE0wMHpZ?=
 =?utf-8?B?OTFQYUg0U1RVSnJQcVNTS2ZiT1ExQngxcGtiVENoTG5JMU1USlJiQXJIS0Ju?=
 =?utf-8?B?dkVqbEdzZTh3RkVyQlQ2QXN3eG9Uc0prRi91WGZ6WDN1OHlRUkJUYndFV1Z2?=
 =?utf-8?B?RmEwUTJyWDJlUnNVWTZ3NnNFWVcxUGdRM0prbzI1eXJ0WjVGT3VkNVNsVVd1?=
 =?utf-8?B?ck9pVXhzK1ZHaEh2L3NGdm5IOGwwYmkzM1JwNzVESGtOTFNSR1o2RFpjLzlz?=
 =?utf-8?B?RnRZL1lyUGlibGlwRk5HcXNwOHhyOGRMdzVDblRwa3VGSnluanV3MXBJdTFW?=
 =?utf-8?B?OWlsVUZvK3RUVERrZ2N5dmpRU1JIWGo2VnQ1d2ZJMnJ1d2xYNE9KZ29nSWNn?=
 =?utf-8?B?emtmWE9nU0s0VEFsT1NJVEpMRFFhcFNjRUxKaUJxYjE1QVY1VmtTdk1yTjB6?=
 =?utf-8?B?cTZ3Y2hnOGE1OFJidDRaUVREcnV6WFNJSTlGVG9ockpQTEh5T2VUZmhmdHIv?=
 =?utf-8?B?RldRa3NiaE9FZFpOdW9rMmZLUEF0K1ZEdTBsVmRtaWM1eUFlTm9SQnVlUUFs?=
 =?utf-8?B?c2o2NnUvd1BnaFJJVUhRc0JVOE8rTG5CQktUcUo1NlhLeXZTTHF2SnlPdE9U?=
 =?utf-8?B?NHorUkZWY0RqRkgrQ0hRejdFZ0RBTWJjQ0FyUUJ5RGV3WFFmMHpUL3RXSHFU?=
 =?utf-8?B?Z2tQMTFVSk01bmtLUEgyZkJTSWdFbnhweTk4WVFNRFFkT0pmSWNuUVQxbXNj?=
 =?utf-8?B?alUzVUVJQzduMmlKd1habFZXOEwzeXF0eUpMOGliSlUrb3pIM0hXZlFrMmF5?=
 =?utf-8?B?MXdNcVg3a3BsbE9oS05yZXpIU21Rb29DclAzTi94TTZVMUJiODlwOHFXMkVS?=
 =?utf-8?B?YmRUdHVGeVJuRzc2K2xDaWpsQzlKVGc2ZVMxMzRpNC9obk9NZWtLRld3TUtx?=
 =?utf-8?B?emRzTXR6ekJqUGp5STk2SU1JWkxOVjFBY3AzQ0FsRW0wYlZ5aVhnTWVEL2tz?=
 =?utf-8?B?L3JBampYQVM5SE5PcFVEcjZFemZsSmU0YThqaFdhRWFxWE0vYWtGRE5IdlJo?=
 =?utf-8?B?ZnpUUnd6bUJrWjBHZks2dk91WWZzS2VsTHkrTFFQNlBrZ0FGeURxSmFqdHJD?=
 =?utf-8?B?Q0ZReHJyaE4zNXJ5NFdtaE5UdGIweTcxejAzWUVCMXNjcmtLQXFBTk9peElt?=
 =?utf-8?B?OUNyTkVmaVQ5TjYxZEdvdmNyK0g2dmZXUkt0bXVzdjJyeHArWEI3MlNJS3dm?=
 =?utf-8?B?RXBVd05vZXVleHphalRKd01rVG03SVhTTGtlcDRlc2hXS2JtZkRpa2hEaHA3?=
 =?utf-8?B?dDQxanZ6SkYzT1pGeGliRjZtQlkzcGNjRWF2VlgxQ3c0UUpoWlp3bHRSTzhz?=
 =?utf-8?B?ZGlZd01YU3dxWkJPNzRwQ1RDUGdEOXFiMExqT1d5bWNSVFhGakl4djk5QTg2?=
 =?utf-8?B?NlBDcXFvaVNremVOdFcrVitqeHRXUmtVZFA1aFEwTTN4aEo5YTBXUURFaTNX?=
 =?utf-8?B?TzRQVGgxb1FFWVBNbjQvTURDSlB1d0lMM3l2TjU3VWh4bXlRMzFQMVFoR3N5?=
 =?utf-8?B?c2RvSjJsbFYvZWticmJQakU5THNsK3ErK0VINTNKd09wV3p1STlqaFEwUjVC?=
 =?utf-8?B?Q1lnSGZyZHk3VloyWjFDcWRwcEJsQ1pvRGR5c3lPcXZXWTJSMGV1TmxNQlY0?=
 =?utf-8?B?N2k5SndnVUJEWTZsVkZVeUMybmhlOFEwRlFNQjMrZ21iSUhkRW5nYkVoUTZZ?=
 =?utf-8?B?SUtPMm5UQjZoK3RNNHpMNndVRmFoc1A3aTdoeWVMK3FGSmw1VWc4SWs1bGJa?=
 =?utf-8?B?OHdvRGtzQlNJeENXMkJnNXhkR0ljdFZpQWxkQVp6bVdKN0JlVit0Q1AybUUr?=
 =?utf-8?B?VWpLUzBtSTdwU0E3WElmK3RVWWhtZmNid2NVYkMzUjhpRFh0Zy9qYzZXUkxI?=
 =?utf-8?B?WFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: pg/myqKWMJNWh3t97aP1m7FQ7vndXnQzn+T2ssXtlmdEF3bbVkLCGcYZesHokVLRn6krAhAypHKwVw3AWu92wMOPk/iHUU/LLSuxfG+pO5AI2PPQ8GaODpgDBTuboM44bIlL9PH+7r1ByAxZ8FLGKpfOgWXdY9AcvzGx/Q5xBc3CT2xiycu58sn27I4++3AgtHDf4kMif1HXbZ9/CgIOGXd3pbX+gLlU0IMf63PillPHPSsA8knsftO4WhpSWDB7/2oJ+Qdy0Uw9AI7ZXDfDfr86nfGi5bPI83nqfgLlHOBq60HUsDqYxoRHCwKzRMn3qW7cJ3IXiyiUkH/Y4i3YM5fqeqDTkAPWfwaCzmPjhfNrDomlKf9zorjfEZRRloBPXf/waY36mBa2HONWFqGOvCS2koXvZjrPtJiLbvGd5p3lNn8chEoq8IdEGnGg0d3AImxsL+3+vLEecC821boUszbEaTb5EBRPJ88KCMS70rpSDh4SfO7jGk14ClOMo+TilBZszTlDMQ3x+tMixT4/5PJve96uE1rCp1K8HNF65Q0ySkIWs2AJN4q+U9QH1+bVnfZCB99dXMvM0Kcqn7IlJfJZQ5S/goy4VUPeHUfXIBw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa373117-68c6-4eac-1451-08dd67a0ed46
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 11:18:23.5245 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fzj1q/ShmT/rdD1nsUKQncpIOiw8oY6T0mFwL3dR5vTXyIYpCy+EUDgptYKeV4BZl4KZtFBeBKv0nJWcQEzvi0LfQVVqJddz2K1zswsoSHI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6841
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-20_03,2025-03-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 spamscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503200069
X-Proofpoint-GUID: 5AogSlg9u8ClsISRiCmL7Ezx-vCaznEm
X-Proofpoint-ORIG-GUID: 5AogSlg9u8ClsISRiCmL7Ezx-vCaznEm
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
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

On 20/03/2025 11:13, Avihai Horon wrote:
> 
> On 19/03/2025 14:21, Joao Martins wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> On 18/03/2025 09:54, Cédric Le Goater wrote:
>>> Rename these routines :
>>>
>>>    vfio_devices_all_device_dirty_tracking_started ->
>>> vfio_dirty_tracking_devices_is_started_all
>>>    vfio_devices_all_dirty_tracking_started        ->
>>> vfio_dirty_tracking_devices_is_started
>>>    vfio_devices_all_device_dirty_tracking         ->
>>> vfio_dirty_tracking_devices_is_supported
>>>    vfio_devices_dma_logging_start                 ->
>>> vfio_dirty_tracking_devices_dma_logging_start
>>>    vfio_devices_dma_logging_stop                  ->
>>> vfio_dirty_tracking_devices_dma_logging_stop
>>>    vfio_devices_query_dirty_bitmap                ->
>>> vfio_dirty_tracking_devices_query_dirty_bitmap
>>>    vfio_get_dirty_bitmap                          ->
>>> vfio_dirty_tracking_query_dirty_bitmap
>>>
>>> to better reflect the namespace they belong to.
>>>
>>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> The change itself is fine.
>>
>> But on the other hand, it looks relatively long names, no? I am bit at two minds
>> (as I generally prefer shorter code), but I can't find any alternatives if you
>> really wanna have one namespaces associated with the subsystem:file as a C
>> namespace.
>>
>> Every once and a while me and Avihai use the acronym DPT (Dirty Page Tracking)
>> when talking about this stuff, but it seems a detour from the code style to
>> abbreviate namespaces into acronyms.
>>
>> Having said that:
>>
>>          Reviewed-by: Joao Martins <joao.m.martins@oracle.com>
>>
>> P.S. We could also remove 'devices' as the prefix for VF dirty tracking after
>> namespace, and thus drop 'dma logging'. That should put 'start/stop' a little
>> shorter.
> 
> This file is not related only to dirty tracking, but to memory in general.
> Maybe a better naming would be memory.{c,h}?
> Then we can have vfio_memory_* or vfio_mem_* prefix and rename to the below:>
> vfio_devices_all_device_dirty_tracking_started -> vfio_mem_device_dpt_is_started
> vfio_devices_all_dirty_tracking_started        -> vfio_mem_dpt_is_started
> vfio_devices_all_device_dirty_tracking         -> vfio_mem_device_dpt_is_supported
> vfio_devices_dma_logging_start                 -> vfio_mem_device_dpt_start
> vfio_devices_dma_logging_stop                  -> vfio_mem_device_dpt_stop
> vfio_devices_query_dirty_bitmap                -> vfio_mem_device_dpt_query
> vfio_get_dirty_bitmap                          -> vfio_mem_dpt_query
> 
> dpt can be changed to dirty_tracking if that's clearer and not too long.
> In patch #31 we can rename to vfio_mem_{register,unregister} or
> vfio_mem_listener_{register,unregister}.
> More internal functions can be gradually renamed and added the vfio_mem_* prefix.
> 
> Will that work?
> 

I would associate to memory if we were talking about Host windows, DMA mapping
and etc. I believe that's more fundamentally related to memory handling of VFIO
to justify said prefix.

Here the code Cedric moved is really about dirty page tracking, or tracking
changes made by VFs to memory. Calling it memory.c would be a bit of a misnomer
 IMHO :(

> Thanks.
> 
>>> ---
>>>   hw/vfio/dirty-tracking.h |  6 +++---
>>>   hw/vfio/container.c      |  6 +++---
>>>   hw/vfio/dirty-tracking.c | 44 ++++++++++++++++++++--------------------
>>>   hw/vfio/trace-events     |  2 +-
>>>   4 files changed, 29 insertions(+), 29 deletions(-)
>>>
>>> diff --git a/hw/vfio/dirty-tracking.h b/hw/vfio/dirty-tracking.h
>>> index
>>> 322af30b0d5370600719594d4aed4c407f7d2295..db9494202a780108ce78b642950bfed78ba3f253 100644
>>> --- a/hw/vfio/dirty-tracking.h
>>> +++ b/hw/vfio/dirty-tracking.h
>>> @@ -11,9 +11,9 @@
>>>
>>>   extern const MemoryListener vfio_memory_listener;
>>>
>>> -bool vfio_devices_all_dirty_tracking_started(const VFIOContainerBase
>>> *bcontainer);
>>> -bool vfio_devices_all_device_dirty_tracking(const VFIOContainerBase
>>> *bcontainer);
>>> -int vfio_get_dirty_bitmap(const VFIOContainerBase *bcontainer, uint64_t iova,
>>> +bool vfio_dirty_tracking_devices_is_started(const VFIOContainerBase
>>> *bcontainer);
>>> +bool vfio_dirty_tracking_devices_is_supported(const VFIOContainerBase
>>> *bcontainer);
>>> +int vfio_dirty_tracking_query_dirty_bitmap(const VFIOContainerBase
>>> *bcontainer, uint64_t iova,
>>>                             uint64_t size, ram_addr_t ram_addr, Error **errp);
>>>
>>>   #endif /* HW_VFIO_DIRTY_TRACKING_H */
>>> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
>>> index
>>> 40d6c1fecbf9c37c22b8c19f8e9e8b6c5c381249..7b3ec798a77052b8cb0b47d3dceaca1428cb50bd 100644
>>> --- a/hw/vfio/container.c
>>> +++ b/hw/vfio/container.c
>>> @@ -138,8 +138,8 @@ static int vfio_legacy_dma_unmap(const VFIOContainerBase
>>> *bcontainer,
>>>       int ret;
>>>       Error *local_err = NULL;
>>>
>>> -    if (iotlb && vfio_devices_all_dirty_tracking_started(bcontainer)) {
>>> -        if (!vfio_devices_all_device_dirty_tracking(bcontainer) &&
>>> +    if (iotlb && vfio_dirty_tracking_devices_is_started(bcontainer)) {
>>> +        if (!vfio_dirty_tracking_devices_is_supported(bcontainer) &&
>>>               bcontainer->dirty_pages_supported) {
>>>               return vfio_dma_unmap_bitmap(container, iova, size, iotlb);
>>>           }
>>> @@ -170,7 +170,7 @@ static int vfio_legacy_dma_unmap(const VFIOContainerBase
>>> *bcontainer,
>>>       }
>>>
>>>       if (need_dirty_sync) {
>>> -        ret = vfio_get_dirty_bitmap(bcontainer, iova, size,
>>> +        ret = vfio_dirty_tracking_query_dirty_bitmap(bcontainer, iova, size,
>>>                                       iotlb->translated_addr, &local_err);
>>>           if (ret) {
>>>               error_report_err(local_err);
>>> diff --git a/hw/vfio/dirty-tracking.c b/hw/vfio/dirty-tracking.c
>>> index
>>> 9b20668a6d0df93a2cfde12d9a5cd7c223ae3ca1..8e47ccbb9aea748e57271508ddcd10e394abf16c 100644
>>> --- a/hw/vfio/dirty-tracking.c
>>> +++ b/hw/vfio/dirty-tracking.c
>>> @@ -45,7 +45,7 @@
>>>    * Device state interfaces
>>>    */
>>>
>>> -static bool vfio_devices_all_device_dirty_tracking_started(
>>> +static bool vfio_dirty_tracking_devices_is_started_all(
>>>       const VFIOContainerBase *bcontainer)
>>>   {
>>>       VFIODevice *vbasedev;
>>> @@ -59,10 +59,9 @@ static bool vfio_devices_all_device_dirty_tracking_started(
>>>       return true;
>>>   }
>>>
>>> -bool vfio_devices_all_dirty_tracking_started(
>>> -    const VFIOContainerBase *bcontainer)
>>> +bool vfio_dirty_tracking_devices_is_started(const VFIOContainerBase
>>> *bcontainer)
>>>   {
>>> -    return vfio_devices_all_device_dirty_tracking_started(bcontainer) ||
>>> +    return vfio_dirty_tracking_devices_is_started_all(bcontainer) ||
>>>              bcontainer->dirty_pages_started;
>>>   }
>>>
>>> @@ -70,7 +69,7 @@ static bool vfio_log_sync_needed(const VFIOContainerBase
>>> *bcontainer)
>>>   {
>>>       VFIODevice *vbasedev;
>>>
>>> -    if (!vfio_devices_all_dirty_tracking_started(bcontainer)) {
>>> +    if (!vfio_dirty_tracking_devices_is_started(bcontainer)) {
>>>           return false;
>>>       }
>>>
>>> @@ -90,7 +89,7 @@ static bool vfio_log_sync_needed(const VFIOContainerBase
>>> *bcontainer)
>>>       return true;
>>>   }
>>>
>>> -bool vfio_devices_all_device_dirty_tracking(const VFIOContainerBase
>>> *bcontainer)
>>> +bool vfio_dirty_tracking_devices_is_supported(const VFIOContainerBase
>>> *bcontainer)
>>>   {
>>>       VFIODevice *vbasedev;
>>>
>>> @@ -809,7 +808,7 @@ static void vfio_dirty_tracking_init(VFIOContainerBase
>>> *bcontainer,
>>>       memory_listener_unregister(&dirty.listener);
>>>   }
>>>
>>> -static void vfio_devices_dma_logging_stop(VFIOContainerBase *bcontainer)
>>> +static void vfio_dirty_tracking_devices_dma_logging_stop(VFIOContainerBase
>>> *bcontainer)
>>>   {
>>>       uint64_t buf[DIV_ROUND_UP(sizeof(struct vfio_device_feature),
>>>                                 sizeof(uint64_t))] = {};
>>> @@ -907,7 +906,7 @@ static void vfio_device_feature_dma_logging_start_destroy(
>>>       g_free(feature);
>>>   }
>>>
>>> -static bool vfio_devices_dma_logging_start(VFIOContainerBase *bcontainer,
>>> +static bool vfio_dirty_tracking_devices_dma_logging_start(VFIOContainerBase
>>> *bcontainer,
>>>                                             Error **errp)
>>>   {
>>>       struct vfio_device_feature *feature;
>>> @@ -940,7 +939,7 @@ static bool
>>> vfio_devices_dma_logging_start(VFIOContainerBase *bcontainer,
>>>
>>>   out:
>>>       if (ret) {
>>> -        vfio_devices_dma_logging_stop(bcontainer);
>>> +        vfio_dirty_tracking_devices_dma_logging_stop(bcontainer);
>>>       }
>>>
>>>       vfio_device_feature_dma_logging_start_destroy(feature);
>>> @@ -956,8 +955,8 @@ static bool vfio_listener_log_global_start(MemoryListener
>>> *listener,
>>>                                                    listener);
>>>       bool ret;
>>>
>>> -    if (vfio_devices_all_device_dirty_tracking(bcontainer)) {
>>> -        ret = vfio_devices_dma_logging_start(bcontainer, errp);
>>> +    if (vfio_dirty_tracking_devices_is_supported(bcontainer)) {
>>> +        ret = vfio_dirty_tracking_devices_dma_logging_start(bcontainer, errp);
>>>       } else {
>>>           ret = vfio_container_set_dirty_page_tracking(bcontainer, true,
>>> errp) == 0;
>>>       }
>>> @@ -975,8 +974,8 @@ static void vfio_listener_log_global_stop(MemoryListener
>>> *listener)
>>>       Error *local_err = NULL;
>>>       int ret = 0;
>>>
>>> -    if (vfio_devices_all_device_dirty_tracking(bcontainer)) {
>>> -        vfio_devices_dma_logging_stop(bcontainer);
>>> +    if (vfio_dirty_tracking_devices_is_supported(bcontainer)) {
>>> +        vfio_dirty_tracking_devices_dma_logging_stop(bcontainer);
>>>       } else {
>>>           ret = vfio_container_set_dirty_page_tracking(bcontainer, false,
>>>                                                        &local_err);
>>> @@ -1016,7 +1015,7 @@ static int vfio_device_dma_logging_report(VFIODevice
>>> *vbasedev, hwaddr iova,
>>>       return 0;
>>>   }
>>>
>>> -static int vfio_devices_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
>>> +static int vfio_dirty_tracking_devices_query_dirty_bitmap(const
>>> VFIOContainerBase *bcontainer,
>>>                    VFIOBitmap *vbmap, hwaddr iova, hwaddr size, Error **errp)
>>>   {
>>>       VFIODevice *vbasedev;
>>> @@ -1038,11 +1037,11 @@ static int vfio_devices_query_dirty_bitmap(const
>>> VFIOContainerBase *bcontainer,
>>>       return 0;
>>>   }
>>>
>>> -int vfio_get_dirty_bitmap(const VFIOContainerBase *bcontainer, uint64_t iova,
>>> +int vfio_dirty_tracking_query_dirty_bitmap(const VFIOContainerBase
>>> *bcontainer, uint64_t iova,
>>>                             uint64_t size, ram_addr_t ram_addr, Error **errp)
>>>   {
>>>       bool all_device_dirty_tracking =
>>> -        vfio_devices_all_device_dirty_tracking(bcontainer);
>>> +        vfio_dirty_tracking_devices_is_supported(bcontainer);
>>>       uint64_t dirty_pages;
>>>       VFIOBitmap vbmap;
>>>       int ret;
>>> @@ -1062,8 +1061,8 @@ int vfio_get_dirty_bitmap(const VFIOContainerBase
>>> *bcontainer, uint64_t iova,
>>>       }
>>>
>>>       if (all_device_dirty_tracking) {
>>> -        ret = vfio_devices_query_dirty_bitmap(bcontainer, &vbmap, iova, size,
>>> -                                              errp);
>>> +        ret = vfio_dirty_tracking_devices_query_dirty_bitmap(bcontainer,
>>> &vbmap,
>>> +                                                             iova, size, errp);
>>>       } else {
>>>           ret = vfio_container_query_dirty_bitmap(bcontainer, &vbmap, iova,
>>> size,
>>>                                                   errp);
>>> @@ -1076,7 +1075,8 @@ int vfio_get_dirty_bitmap(const VFIOContainerBase
>>> *bcontainer, uint64_t iova,
>>>       dirty_pages = cpu_physical_memory_set_dirty_lebitmap(vbmap.bitmap,
>>> ram_addr,
>>>                                                            vbmap.pages);
>>>
>>> -    trace_vfio_get_dirty_bitmap(iova, size, vbmap.size, ram_addr, dirty_pages);
>>> +    trace_vfio_dirty_tracking_query_dirty_bitmap(iova, size, vbmap.size,
>>> ram_addr,
>>> +                                                 dirty_pages);
>>>   out:
>>>       g_free(vbmap.bitmap);
>>>
>>> @@ -1113,7 +1113,7 @@ static void vfio_iommu_map_dirty_notify(IOMMUNotifier
>>> *n, IOMMUTLBEntry *iotlb)
>>>           goto out_unlock;
>>>       }
>>>
>>> -    ret = vfio_get_dirty_bitmap(bcontainer, iova, iotlb->addr_mask + 1,
>>> +    ret = vfio_dirty_tracking_query_dirty_bitmap(bcontainer, iova, iotlb-
>>> >addr_mask + 1,
>>>                                   translated_addr, &local_err);
>>>       if (ret) {
>>>           error_prepend(&local_err,
>>> @@ -1147,7 +1147,7 @@ static int
>>> vfio_ram_discard_get_dirty_bitmap(MemoryRegionSection *section,
>>>        * Sync the whole mapped region (spanning multiple individual mappings)
>>>        * in one go.
>>>        */
>>> -    ret = vfio_get_dirty_bitmap(vrdl->bcontainer, iova, size, ram_addr,
>>> +    ret = vfio_dirty_tracking_query_dirty_bitmap(vrdl->bcontainer, iova,
>>> size, ram_addr,
>>>                                   &local_err);
>>>       if (ret) {
>>>           error_report_err(local_err);
>>> @@ -1241,7 +1241,7 @@ static int vfio_sync_dirty_bitmap(VFIOContainerBase
>>> *bcontainer,
>>>       ram_addr = memory_region_get_ram_addr(section->mr) +
>>>                  section->offset_within_region;
>>>
>>> -    return vfio_get_dirty_bitmap(bcontainer,
>>> +    return vfio_dirty_tracking_query_dirty_bitmap(bcontainer,
>>>                      REAL_HOST_PAGE_ALIGN(section->offset_within_address_space),
>>>                                    int128_get64(section->size), ram_addr, errp);
>>>   }
>>> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
>>> index
>>> 512f4913b72d9a1e8a04df24318a4947fa361e28..6cf8ec3530c68e7528eefa80b7c8ecb401319f88 100644
>>> --- a/hw/vfio/trace-events
>>> +++ b/hw/vfio/trace-events
>>> @@ -100,7 +100,7 @@ vfio_listener_region_del(uint64_t start, uint64_t end)
>>> "region_del 0x%"PRIx64" -
>>>   vfio_device_dirty_tracking_update(uint64_t start, uint64_t end, uint64_t
>>> min, uint64_t max) "section 0x%"PRIx64" - 0x%"PRIx64" -> update [0x%"PRIx64"
>>> - 0x%"PRIx64"]"
>>>   vfio_device_dirty_tracking_start(int nr_ranges, uint64_t min32, uint64_t
>>> max32, uint64_t min64, uint64_t max64, uint64_t minpci, uint64_t maxpci)
>>> "nr_ranges %d 32:[0x%"PRIx64" - 0x%"PRIx64"], 64:[0x%"PRIx64" - 0x%"PRIx64"],
>>> pci64:[0x%"PRIx64" - 0x%"PRIx64"]"
>>>   vfio_legacy_dma_unmap_overflow_workaround(void) ""
>>> -vfio_get_dirty_bitmap(uint64_t iova, uint64_t size, uint64_t bitmap_size,
>>> uint64_t start, uint64_t dirty_pages) "iova=0x%"PRIx64" size= 0x%"PRIx64"
>>> bitmap_size=0x%"PRIx64" start=0x%"PRIx64" dirty_pages=%"PRIu64
>>> +vfio_dirty_tracking_query_dirty_bitmap(uint64_t iova, uint64_t size,
>>> uint64_t bitmap_size, uint64_t start, uint64_t dirty_pages) "iova=0x%"PRIx64"
>>> size= 0x%"PRIx64" bitmap_size=0x%"PRIx64" start=0x%"PRIx64" dirty_pages=%"PRIu64
>>>   vfio_iommu_map_dirty_notify(uint64_t iova_start, uint64_t iova_end) "iommu
>>> dirty @ 0x%"PRIx64" - 0x%"PRIx64
>>>
>>>   # region.c


