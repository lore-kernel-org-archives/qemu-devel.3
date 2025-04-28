Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96686C369D5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 21:17:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9VqM-0002U9-FE; Mon, 28 Apr 2025 17:16:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1u9VqF-0002Tg-Gc
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 17:16:43 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1u9VqD-0001ag-9z
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 17:16:43 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53SL8xJN024602;
 Mon, 28 Apr 2025 21:16:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=BGwoc/jzC7bjHR/UR3Qx4bBNgzcbmvxFSANYxG8zCJo=; b=
 mt3gNGc40kH6gzvIWF010UDt9XVesXhBE0Ucby7wWz9PmIAXGjH81u2vTPiiGKUq
 gU69uKqIHl5cmi/DQZUjOhPKSmKPFzORJ5cs1QOknPXB4ewxQV19F5AQiVQnYn00
 RocqDiQwhGg3dVZNpP7jonkbvIrIS1MWbd3TbCNM0m+1C5X1+m9+j+x8YkMLuV+c
 P9eliMzfzXthRD21hbs2/rvTW7QFC+D4HK8sgnb3ywdlEADQ24Xb2HrvPFbWWcSN
 P+iqDdjGB9MCsyxsbjOcfDx3xd93r7ctDMU3mYMZ3Fu+CYpzzh/3iLyiNHC/4Zka
 fZKZWQgvdsxytGLsstd/zA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46agsug2hq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 28 Apr 2025 21:16:34 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 53SKMXtv033478; Mon, 28 Apr 2025 21:16:19 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com
 (mail-centralusazlp17011031.outbound.protection.outlook.com [40.93.13.31])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 468nx8yvet-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 28 Apr 2025 21:16:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LF+1HEfmOsTeKtIR8o/5OqwfRN14pA1seJ2b1Vd0/kGkEns65ij3aJItwmJeAptOeqdERrkxvfMkYpUyeO5Oxzxqr4PP1Kdgl4ZngI38JgUyXO3JbUwo2bnanU9MhFQu/sjrp+NOFKOuu6wybX6+rDKBGDhxD/MAKMbMkIFdHIf6pLElDDYm/1a+VU3hun3dVpIHkfP7qciWH5uLvUVUwSoGLkj8StdKIFtsnjOH9hsJ+pUnDIWRlcUTzaYHRsjEb8DRRqxW7eu1D+fpVJnTd//69x0vBzQQX3WsrQLzZ26JfitYozat9QU8yny5LVrbrR9qjBMJ1XCZOyYtIiVbtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BGwoc/jzC7bjHR/UR3Qx4bBNgzcbmvxFSANYxG8zCJo=;
 b=eAptDlwbO1yPfJ66KdBU7Yxhkdzfu6XAMjyUZ3i5Z2kMq91CHyFohqzymg6Yo/ViaJ5tXiDHmyW0fsOUbuWA6uA4oG/Fo2cfayuV4U2U+A5UA9ytDWVIZ0zYFSwclyhcQfI0/Trtes+KESZnh0wzenqM8LGMjWUE6Q8FJuldeoQzPqwwKZc11l99+fY5LVfjRDsYHXDTzm+q20S7O+VA7fG8tnThajroWHGjNBcCyfG6T6QPlEEMGQBeyYgr8Colwaelj9WN1RMjCGAnq3Z0tANJQVaDc7i2yO/4+SaQBusQd53GzgjHaDKvNVSa/b0ad+iSuUadIfEQpOyB/tTQww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BGwoc/jzC7bjHR/UR3Qx4bBNgzcbmvxFSANYxG8zCJo=;
 b=v9u2zIO8P/GFSG2BSfogKSJDPfRVTsThfv9poHtmYZyhW9iDVioKXpg81SoCUAuZk2JSt7kbn6cTG07QvetQ3L6kw9IOzOX2P4S29DtJPxVnny1PZZbc0FizxMDlieKiLIZOP9xbvLdSD++MkTBkjhhRSnxRpd9P1tDnl8GmJ6g=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by IA0PR10MB7643.namprd10.prod.outlook.com (2603:10b6:208:48a::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Mon, 28 Apr
 2025 21:16:16 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%4]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 21:16:16 +0000
Message-ID: <366f3a0c-60a6-47be-8981-5c8d8be55d60@oracle.com>
Date: Mon, 28 Apr 2025 17:16:10 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/18] amd_iommu: Helper to decode size of page
 invalidation command
To: Sairaj Kodilkar <sarunkod@amd.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 peterx@redhat.com, david@redhat.com, philmd@linaro.org, mst@redhat.com,
 marcel.apfelbaum@gmail.com, alex.williamson@redhat.com,
 vasant.hegde@amd.com, suravee.suthikulpanit@amd.com,
 santosh.shukla@amd.com, Wei.Huang2@amd.com, joao.m.martins@oracle.com,
 boris.ostrovsky@oracle.com
References: <20250414020253.443831-1-alejandro.j.jimenez@oracle.com>
 <20250414020253.443831-9-alejandro.j.jimenez@oracle.com>
 <36a69911-ff85-47e4-a34d-cf5e934d85da@amd.com>
Content-Language: en-US
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
In-Reply-To: <36a69911-ff85-47e4-a34d-cf5e934d85da@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR11CA0074.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::15) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|IA0PR10MB7643:EE_
X-MS-Office365-Filtering-Correlation-Id: f695511d-9f62-4a2a-3c3a-08dd8699e91b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cFdwWHJkREU0NUNLbkpqdGFWeWE4VWxFNjQ5YnNBeE1kemJKeWh2YTQyWXN0?=
 =?utf-8?B?RldsZDhzVVhXQXYrZjM2UVBIZ1krOXM1bnBpcVAreExkUklVRXR1c211MFIx?=
 =?utf-8?B?enRFbkZ0ZFRUWnhvSWlTRGxiRmp2Z0dIVkJsaVRwQlZDTUlwb1BxbE03Q3VZ?=
 =?utf-8?B?eWJqNHhDYkhQTWMrNDRUOGR2TmNiNUMwQTltT0x4aGd1R2xtWldzOHA0czVs?=
 =?utf-8?B?QkU0N2twUFhBNmdETUxvZjZrQnJLaUxOamx6UHJjQ2UvK2VwZFlHQWZrNjc5?=
 =?utf-8?B?QkhFaVV5cW1HaFVaeEFkNG9maENnSTkreDRpQXVCaDJqQSs0eUpiNWVJQTFL?=
 =?utf-8?B?MjlmWG5QVm5YZWVRdk1tWHpySE1ZakhxVllkWUZYWkdPSDlIdSsvRnpGN2xw?=
 =?utf-8?B?R1dkOWx2a1htR0Rsa2tiZk56RDJWU1hiUEl2RkFXdXlDTEEwVnBUTzRBaTNz?=
 =?utf-8?B?dW1CMG5Hd1dTS29WSkVrS25ocU1wQzJaUGp6NVgvUXRnZm1oTHNsUkFXMzBO?=
 =?utf-8?B?RzNqcnUyNEpEU2tKcHBhczVhQW5GbHcxdmNtbUhXSWVRUjNXSVpkNjhJWGUy?=
 =?utf-8?B?T1BUV2xCa3VpbFhVV20zazd0QTRGU0M1T3FNT1I3WmNLWkZYMUJrbUw5cC9n?=
 =?utf-8?B?NlNuNm9UM0FWd3VVSlBMMnpQa25MVk53dngxUnJUWWhMNDUrWkpXQ3dpMmtN?=
 =?utf-8?B?M08wUkFwOXhMK1RxbmpuY0NZbEh6SmVWRjhGdklMMVEwUWszU0tTTTlmckUv?=
 =?utf-8?B?eG03UC9VQnd1VVRBd1E1T0dJc3ZUbk1RV2RkQ1hvdHBVeGZ5UHNGUDZtUzJr?=
 =?utf-8?B?bEpXdkJPVzUvclRvUjhCZGptUjhrRGs4UksxZG5vSnRvS2Z6WDhoeFpoZWZ2?=
 =?utf-8?B?alJSZzNnWFN1cTFjWkdRamR1WFJDcDRUeWVGRldkVlp3QnZBd3VVRmJ1YmJv?=
 =?utf-8?B?bUJhZ3pwUmdXbnlERTU2VG5VK2poMi9iS0k4djNYMTN4MC9EcVdDM1U0ZWNL?=
 =?utf-8?B?UGpjUStnU1RjTUg5NzU2Q2d0U3lLUmZDdGpSWmdiZklGSktySGFuL0gvRXlk?=
 =?utf-8?B?aUs2MXFjcGZPd1pqWkkxOTZZVUJpQkVxWktFY3NreWZWdHNSaW1jVzIwWm4r?=
 =?utf-8?B?M2JFTTQ0dGxEY05mRG56ZncxenB2TVRiNDc5RThRako1ZFNDVktRZ1pKa3lJ?=
 =?utf-8?B?bEtXbEFMSWU0dFVUUnA2cG0zdm9yQ1BLSVpSYjRuOGVGaHRVR05hamtsZVBB?=
 =?utf-8?B?dXFiNXRVVGlDRUIxVVF4WnJKaGdDSkh5NS95YklYd2JIQ1dOcURkZ1MxS3BZ?=
 =?utf-8?B?V0xyaHUxaXhTdTcyaWFDeXlBSW05L1JlcTA3ZGo0ajlPdVNNa05lZy9BOGxR?=
 =?utf-8?B?RElFcFpVVG1lbFZDYk00M3BvSUovSDE5UzdXc1haN2pjNHFqUG1XSWRnNU14?=
 =?utf-8?B?enh6VzRSZHFaY3JNYXlZSmpta3RaNGVVdGp1dGtDNldDeEpFMXBzYlNEL0t4?=
 =?utf-8?B?Sm9qQlc1cmxwampmWXVBaFg2dWlsZU85U1F0Z0toZFZrNmE2NGJ2ZnlSV3d2?=
 =?utf-8?B?aC9OQ3BiSlJMb0lOT3lCN2dHV04vUzNabGlWT3lWOEJaRHZvUENwTEVrZHc1?=
 =?utf-8?B?aEVBdjIxcHdVdEVqb044dnhsdTJHQ0FFalJVeXZUY01ZZVhJRGZRYXFTbndO?=
 =?utf-8?B?UDlWN1J3aC9adHNNVTFvZmdab2lTNlpSTUg3bHIwbUhnZnZZZGRTdXlJT3FJ?=
 =?utf-8?B?VFNoQVd1Tjd5ajcwVVpzQ3paZFpuQ1AzVnA3dGpwY3pVTkNIdk1zbDFxcmcy?=
 =?utf-8?B?d1lsNFhIRmhNQndPVTJMaTdablJZbWZjZTFSUmlxQ3ErWERaU3VhMFhpcnNT?=
 =?utf-8?B?cVRTa3RQaWNDMUNFUE1LczdocXNsR3FvN2FDK3NnUjJhWVhuZWxFS0g2bzg2?=
 =?utf-8?Q?DgSQx+jZoz8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB5267.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0hHZTdwTTdmZm92NndZNUN3Vk5nM1hHNjhmY3ZPVmRjQ2FidHprcFAzaG8w?=
 =?utf-8?B?ellhc2g4UXpNNDFiOTh1Y2FrQnRtSXJRM0wwUWQyUDlUM0xoTkdRVjk4YjNp?=
 =?utf-8?B?T29OSGNZYzlJdkk0OGttdGNkNnpIUnFoZVFRS3BpWm55TmVwZ2c1bVRPQUF3?=
 =?utf-8?B?dFdPSEdBOWFLVFNwejVFMjhEY0xURzlROVlnTHV3RXd4allGT3pzN2d3NlA1?=
 =?utf-8?B?cmtHOUtsVE5oc24rTVpVVG9pTENYYXBMdTZpRFpKUVBCTk94eEpoME90a0Mr?=
 =?utf-8?B?K2V3OE1qY01qeXI2OVhPc2o3MjJNaFVlMHY4VmJxNG8yekRDRXBiUzJxZjlo?=
 =?utf-8?B?cklRNjlNK01HYVhoT3h3M1gwZnpjNXg0S2UxVys0cXBaWGpQdUo5aHM1VitE?=
 =?utf-8?B?Tm9Cc1djM1BIOFBERGRxN3RJa3VqUnB2KzBqMVFXcXhGYzdGWFVRSDZzZEVa?=
 =?utf-8?B?SUlQZkthLy95Q3FpWWNTTlRhU21PR2dBZjZpR0kycW05bmpqQ3BzVldFTTZD?=
 =?utf-8?B?bExHcUhkV2VBSWxPR3RldVA3QUphazVFNGdqSmxEUFZ0alVSZUJrWm1lY2xw?=
 =?utf-8?B?ZmN6ZnZvbjFoQlluZ0M5Vi9wdXRQY2RsUjU5UzA5cUZxckVHYnArL3kwN3hS?=
 =?utf-8?B?OXFmTEEvcUxreUlkWndYK2p6T0x6UTBBdmQrbzdsZHZGSVV4a1NOME1uMXFh?=
 =?utf-8?B?WDNyb3ZPK21PRUNJSXZYdDlwWEp4a3d3ekd1aWRPTzhUUFozVEI4WXUvSUpp?=
 =?utf-8?B?Sk92c0xjRVBMNTBKZHlnWElkNlgzNEw0TjBQclpyK1Q2S0IyazgvUlYvR1h4?=
 =?utf-8?B?aytQUEl0V1lKeWNFci8rRnlkK1hMVG56YnVnRndXeFVEUlM3WDdhZWVMaWdG?=
 =?utf-8?B?WjVqVHQ3YjIyMTBXVS9pUHNwUjlqUXIvZWdsVjZBQUVIV2VJdzYrajlTMU10?=
 =?utf-8?B?eXBGUjA4OE0wa042akhkd2JBVGs0TEpXQ3FhcEpRSVJsbjg1Z2VOOFpuaFdt?=
 =?utf-8?B?ZnpyQTFPeWdiZmhEUm8vWVdMSEJZU1lxTmV6aEFGUzRTSGRwbVpKZTh0UDNC?=
 =?utf-8?B?NkQ1OE14cUhhazN1YXJSd0JaNzVSZ2x5TGQ2SXpuRDNJWkN1dlFYRWNCL0Zu?=
 =?utf-8?B?YlFMemFQeVJOdmE3NnJ0ZTBOME0xbGlHeW5FR243WjdaRjA0UjIwY0ZPM2Iy?=
 =?utf-8?B?b0ZRRHJIRXFteUpvU2p6OG5FLzc2MlFXaUo1VXkzY3hITjAyaVdXR1AwQWZw?=
 =?utf-8?B?M3hIMlY3YkVSY0hRVWJ1UVNKRVJyM0IrNkJhdFZKdEYycmIyMUZCWFluRU9s?=
 =?utf-8?B?ZHkrWU1nbWEwcDlOcFNkMzM3aWhzRDhZREVrSmFvSXZiTFIwKzZPZWRIWHZx?=
 =?utf-8?B?RlM3K0w0OG54M1E4UHFKUkt2dU5WcDlialJMUHBhZTFVcGhNVGRkTlRyOUQ1?=
 =?utf-8?B?dENIclVKeHVjNEFVU0NVenQ5aTR2eHJzVG1zaDg5ZVRtRE9UaTluYUZJVXAr?=
 =?utf-8?B?NnFmcWFXdExDUkhOSFhOLzRocUZPL2hFbVdpWWNYT3BVTnd0RmlMQXEvaEhY?=
 =?utf-8?B?cElwbHV2V1Q2ZGYzQ2dTVDlYRmF0ZFFCdFEvNGIyVi9IRVptaWsyMlBURjlm?=
 =?utf-8?B?blhpWGZQc0xaak03NU5HVjc4OWRGY0M1Q3BoSjdoYnpDQ2l1dzZURzQrQnpU?=
 =?utf-8?B?NFhiVXN1MEpVL3V2MEgyc3k1eUQ5VTFmZU5VZXc3Uk02dDhISjRuVUpHTHA1?=
 =?utf-8?B?VzBRK2FvVnZQRXhhTU1wZmgxcWVrbVhmWS9MN1lEMWJTRElhNU9LekNmOVVB?=
 =?utf-8?B?cmpNN2lXRGl5RDArcXYvcE9IYVlTMTdjeVR0K1dlZG9nNk5rYmtRQSsvd1VC?=
 =?utf-8?B?cXlPa1ZVa2FDM3lvaHZ5Mzdhb0J4NTErTlppRXg3T0RtU2dMNmh4QXdwaVBu?=
 =?utf-8?B?TlA2Mko0MHhCcys3SGNTZkszSkpJK3NUcE9OYWNjcDl2Ujd5UmpUM1JRS01J?=
 =?utf-8?B?S1RUZ3FnZkZ4c3RodDF1Y2pCeFg2WXRtcGY3dnRYYVc1RW0vUXRtMm9SWWwz?=
 =?utf-8?B?UHU3WDFmb3JZOTRZdjBoUU9OSXJJcldtcUFnV3pIS1RnZHRGV25yNTFJUnk4?=
 =?utf-8?B?cFNTQlJXcUFsNlViWENwUTQreitVUXFHN09MTHY3MEJhV0RRTjJNN1NnL25W?=
 =?utf-8?B?K2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Gzw57s6lVcYEd5XSbDRBT45bjlsu8bPWUtVbnfu37QqE6n6dNssaWbhtp+tbT6AVhwU03AQ0CMJPXWKwqNJqjFaesLtuN5hQB2E0oC8plN9Ie5jAp57hDoXKKKdPDIp35Dbjg9xeKktEsvUf/58TXRthQxcmEnV0lLFD1SW1/bigX1r+VY/N/m8mO8WQ+is6W1q64BT1eX6ND0gQoYJ1A+KUvhhrdfUMwtWBsxLtLv7fW2JSAAZvQ8VB9CQNZH0hVBaME3HfgYCd+zfeXelIrqzbDgBwKEVm2bjjJqT9f44q7modzSFiywQIxz1TkmKMEp/p7SWEDEwiJWCr9wZh50N+l5xzdw7XET3+PcEuqFd1ISFuK/hN0Np//7w7miE3eAUJIWBUF256qUHAHeLMZfhr7d6YnCPbjo8aL9TbQZ0tBV69HP1VxIBnkwF75MZCgZ2qAfAstUgDIBu0p5tpQAfQnlYKjplVZU1VdEt3J0RQrsMALcszaMfW1vCt4YWYDPINpY3UbUimF/6sB4XQ2SuxrKi46nvTZRHtBdi/PshPen0tmGzfnPassKfbMd926g6MteFDClqhP9WAtt83EfE6bcCxWSzcPYV1diFcito=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f695511d-9f62-4a2a-3c3a-08dd8699e91b
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 21:16:15.9431 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jKMBOW/jH3Ljmv1TBbzbtn0+vYVY6212aN28XVQtXNZlEaBbR7upRR2colppl1YGUaqvTNGXuM2CiL8DEZ960n7zz5ChkSXZRCTVDOqDxJs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7643
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-28_08,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0
 malwarescore=0 mlxscore=0 bulkscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2504280170
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI4MDE3MSBTYWx0ZWRfX1wk3LFhRTiW7
 n51S9EWsyyw6EPqtNDPno4odckkerD0Mwv6Ed+mMj2K/P01E/ZqTzT+HR3pEqdn0vC+JA0AfF0e
 qZmCdxiQyuP90kMvqYcMFX5Hr1bR582y3y0mRGQLYtLKlITCPVee77zR5t63mND7tarfP0mYyBh
 J/UvbYFCaEH7jzB/Ets9w1UtSnC1hxLEixVvWCThP3gWZfzMXlp0NcrzSomWJf2C7jH0zPf1jws
 n1krmbeBrFyk79b+BYG4KuOq2e2iyaeQvsP48AQw8nnIkrLKgIpCVWVhMMn3h/hR4L/iKG0Irjk
 Bqpz0OUniOwyguBg+XUCsMMT7UbvSu/m0mPpLTep9rksnzQUodHDrygu/yoowyvmI1z6qF+CzrH
 cAZd0CF7
X-Proofpoint-GUID: p5DI7tkKq0w6LPpMG4N6IxErkXbr4DMD
X-Proofpoint-ORIG-GUID: p5DI7tkKq0w6LPpMG4N6IxErkXbr4DMD
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



On 4/22/25 8:26 AM, Sairaj Kodilkar wrote:
> 
> 
> On 4/14/2025 7:32 AM, Alejandro Jimenez wrote:
>> The size of the region to invalidate depends on the S bit and address
>> encoded in the command. Add a helper to extract this information, which
>> will be used to sync shadow page tables in upcoming changes.
>>
>> Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
>> ---
>>   hw/i386/amd_iommu.c | 34 ++++++++++++++++++++++++++++++++++
>>   hw/i386/amd_iommu.h |  4 ++++
>>   2 files changed, 38 insertions(+)
>>
>> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
>> index 5f55be1f4d36..0af873b66a31 100644
>> --- a/hw/i386/amd_iommu.c
>> +++ b/hw/i386/amd_iommu.c


>> +static uint64_t __attribute__((unused))
>> +amdvi_decode_invalidation_size(hwaddr addr, uint16_t flags)
>> +{
>> +    uint64_t size = AMDVI_PAGE_SIZE;
>> +    uint8_t fzbit = 0;
>> +
>> +    if (flags & AMDVI_CMD_INVAL_IOMMU_PAGES_S) {
>> +        fzbit = cto64(addr | 0xFFF);
>> +
>> +        if (fzbit >= 51 || !addr) {
> 
> I am skeptical about the condition addr == 0 (!addr)
> 
> Consider the case where user wants to invalidate 8K size page, starting
> from address 0. It'll cause address field to be 0, right ? If so, then
> we should invalidate only 8K page not the entire address range.

You are right, I'll fix the issue (i.e. remove the !addr special case) 
in v2.
This was a remnant of an earlier prototype where I was decoding the 
address with a different method, but as you point out this special case 
is not needed anymore and would result in sub-optimal behavior.

Thank you!
Alejandro

> 
> Am I missing something here ?
> 
> Regards
> Sairaj



