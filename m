Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7B9BC54E65
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 17:31:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uI9lD-0003Z0-GH; Thu, 22 May 2025 13:31:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uI9l5-0003YY-Lq
 for qemu-devel@nongnu.org; Thu, 22 May 2025 13:31:07 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uI9l1-0005nP-EM
 for qemu-devel@nongnu.org; Thu, 22 May 2025 13:31:07 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54MHBvbT019739;
 Thu, 22 May 2025 17:31:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=PgigzyIj/F7cxRxzqdBKGd6Z1rp90aQCKN3cwAQ+HNk=; b=
 RWl9ZVQnfTj2eLefJcsz9JRyKn0US4ELZa7vv4w2AbLdahe/nCXgqeoGUvb7zUue
 2vbyVkjknxEZTICD7zC/6x8EZeqZOfFL8Z7n1oVNqvUGHSsxHDSDQZmvSNzGCnz8
 N353qAi6s7yV+W03VEmeVAZP4udT9hghPNk5r+t8//bZfkx4QmeXzvXcUUF4egLo
 QVKG3kb/9dAanIPBnFH7OLGQozPyjoiJsxfdBSrpxJCQ+3xMWbIjspv99j2Fyijt
 rvfIiEQN11mSx33flrUxywqU6D6pFW3CDl3ivmiKk4QCe2mel44TlkmsEWM5fHRG
 gTynXgMWFK8q0QHoW6daWg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46t83tr1aq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 22 May 2025 17:31:00 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54MG7rto034614; Thu, 22 May 2025 17:30:59 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11011041.outbound.protection.outlook.com
 [40.93.194.41])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 46rwerfh60-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 22 May 2025 17:30:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LRfoWuv9MJ9/X6NaTeZ5vmwdQf5F3IXAvL0vJJdeCCJpOO2wRHEkD7FghiyNsIUCSldiXhjh12YIC4mHcmnu7tbaZ1/ggaI0+h/YTxrpIAo+iwnZ/SGxjsl4V+e2KQflwOmkjRzv+lYHf62ZR9fPPtP19N3cxFeFowU91hm0dLRLDC2HxlwGBOmevBq4jVp9RLujLEq23C2G67UYvEsGTCK46Kq8tBm6A7GpXDiPyRTsvxqq4869/4Lkto9qrXUld/W2N6DU/zV2Re6zrmrsWDUqkdVsSF5b+Q9DLn+SoObida1pPDAhvyDwp1MkTrFuXOOnA4CMzJGbWt2aDAHCvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PgigzyIj/F7cxRxzqdBKGd6Z1rp90aQCKN3cwAQ+HNk=;
 b=nM4vyOME1VHno4Mxm0dbYykdqecDQjXhCirFOh5ToI8oObFaqsOwkMz76GMmk0Ul4wwL0CM5u81sml8MhK3ZI3iYC8A3gp0sPWSqk58Bro+AF5a7191Tw5LsuHV18RlALn5JKkAc8Zx7EnP/xJwdWb5Ef9K7qaq16LLyYc2OCeovKwDGoRp++eySX5PaQqZtQ5Kcqm8c777MZcu9JXwtctcFQyj10mgXp2Qv12xHLe/JnE/gxAf363AOjhlnnFY5EpG9Dr+/m4hLskitCJgGycR7yKTwQCp/wFEs0olauLhNOXZLaHwoxeoE64EyoaTIRyDWq7ZTbwi1IFErNBAj2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PgigzyIj/F7cxRxzqdBKGd6Z1rp90aQCKN3cwAQ+HNk=;
 b=N9biljiRq1rtNbBm9ZMhz+klNXGm7N5k2Ovrt7SPCS/F6665L7edwFF4di3UfQtIboI5DOBWlIWGuUMqRnNw3uer0tnGDu9TWtxZYvUMyu6TvhSx9p1wdYEIQIX5aU2LqGHrG1if2uq40KCtheNJGz19SAr5DB4u5yJsl5AwPfM=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by BN0PR10MB5079.namprd10.prod.outlook.com (2603:10b6:408:128::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Thu, 22 May
 2025 17:30:56 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8746.031; Thu, 22 May 2025
 17:30:55 +0000
Message-ID: <29454dcd-2eb7-4cef-83f2-659fdddeacf4@oracle.com>
Date: Thu, 22 May 2025 13:30:50 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio/container: pass MemoryRegion to DMA operations
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 John Levon <john.levon@nutanix.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>
References: <20250521215534.2688540-1-john.levon@nutanix.com>
 <9c08a275-79ed-4192-bc6c-53c3c9f60916@redhat.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <9c08a275-79ed-4192-bc6c-53c3c9f60916@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0099.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:191::14) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|BN0PR10MB5079:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b3a8259-4344-4c27-2f23-08dd9956686f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YUUwSWhCS3gvSnNtTEtaLzQvMkJNZVdna3pCa1JiTTNUY3QydUtuOVZOazZF?=
 =?utf-8?B?U3Z1c0w2V3lNM1JQOXVVTkdGeFFjVVBRUG1oNWg2c3ZDWHY0VGlvZTVVVExF?=
 =?utf-8?B?RGxIZE14VXRVRkszY3RYaXJKWmhrRTRQOUw5c2pGbitQMVN0Qm04VlV5eHM0?=
 =?utf-8?B?RUl3WklKWmszS1hnMHhwb1BveDdjazVGb1lPT0pOS1Z1czBwbWZ6emlELzB4?=
 =?utf-8?B?RlBkVkRHbVFmN2cvRXhIWGowR1dreUlIY095cTAwYzloU1k1WXpNSGVxc2VD?=
 =?utf-8?B?amowcWVnZFprZHJSR2tCMW9RVkhhV015bEx5aUpDNFVXVkNxUXZBbmpuc2Vv?=
 =?utf-8?B?MVF0Zy80UWVjNFpJdVVSWUJpamF6WVJseFdEaWxvaW5hY3RpRWcwajhJUHVs?=
 =?utf-8?B?Mjl0NzluZzBnRXZHTXUrelVmNHZqU1JWVmQyWHNlMDFpOEd6SER4VnByY1Vr?=
 =?utf-8?B?VE1VK0l1YVozR01MQU9WWGU4TEdaM2Z2WDRNSjdqWEJOLzFvRWJjZTdoN3VP?=
 =?utf-8?B?UFBLVWdtcVBuQm5PKytRa09tdW5EMmdKaFJxWEw4U1c1NWFFdXJ1SVdKa1JZ?=
 =?utf-8?B?NFNTLzhZc1FtTGNWL2FrSUJLWXdkbGRxUFpPWTBIaXZtY1ZNaktoS1M1TG1h?=
 =?utf-8?B?VDAyZmtpUEx2b0t2SkpzWit0YUNUdloxWmwzN0tnalBYUVV5QW9WYVJ6bkxa?=
 =?utf-8?B?aGc3VWU5NzQ3Yk1KVDQ5M0lMMEhhNHQyejE4NmtwUjFvcFpoUlZ1WmdOMlFW?=
 =?utf-8?B?NGdyRkRZUDhKSVZXaFMvNXcwczIxeHpGOU9wTTZMTjRPTGFrZkRKT3dFZzEr?=
 =?utf-8?B?V3JoZFhIQWpmUGFVbE9vZjZISzZacUFXWEo1REJ4Yy9aZWxrZU5peDh5VVZs?=
 =?utf-8?B?Yys2Q01Pb3Z1ZHFqZEVSeUFBYW53Vk51SHFKWmg5NTdFU1JFbUo0aTVYN0FH?=
 =?utf-8?B?WGgzZFJ5dkxZYlVHemdsTW5UZjZGU3p6bDVyUS93RkUxby9ZN0cwdVR0OTZQ?=
 =?utf-8?B?SkVXTTF4VHZoZHVvZnhoL0JPNHVCMnJKWkVxT1h4RXlsb3pSMkFXLzM3Mjd6?=
 =?utf-8?B?Z2VGWk10c0xyQ3drM0Y1VVBSN0kvL1BuR01tUFlCR2ZEZDZXOUcvS254bkF4?=
 =?utf-8?B?S05STmwzWFhMWE9zQkp2RDg0czdTZVp5bXJ6TzZseXg4OWtlKzJUNjhHc1dJ?=
 =?utf-8?B?VlV1NUw5WGlyR2FhMHFMeHJQYnpEVUUwZlNqZTRoL2FpMWVzUTBmZVFONnpS?=
 =?utf-8?B?eXp3SmQzaGJpbGUxS0VpekE5VktnS0RtcjQzS3lmWW5PVFg4U212MEppc0x3?=
 =?utf-8?B?SWd3R0Q5U0ZzYTlPWW5hRHlYU2VZUVpYR2VKT2tFeTE5LzFrb0cwOStzT2Fu?=
 =?utf-8?B?VXhzTDRlQ0FhOXM2RkZjQzY2T0JqZEg5V3F3U29DSnAydFhpQ05OQmJHOC95?=
 =?utf-8?B?dDlvUlRGSDk4eW5PRm5RSTdwMS9GWFNlWG4wVk1EZytzejlYWngxTCsvcCs0?=
 =?utf-8?B?RERuT2txUlJTcm4zdDk3R2drYU13QzBoNFRCVjM3YmNKZE5aV1lwTHV3aFFV?=
 =?utf-8?B?Y1d0S3J2WEhiUlFQd3VSRHNvYU5UMHE5RGVxMjMzWStvSzkyWmJ6Rm1nZmtp?=
 =?utf-8?B?Ly9od2JWWmttaTVkVDdwUUk1R2t2SnlONk9nMHBZZm1YYk1pMHJmK1ducFlC?=
 =?utf-8?B?YkYzeUp4QWFUUFlTcFZCZ3BRZkE0MEw0RUVTcmVHUlc5VS84OHpwbmw4SGpN?=
 =?utf-8?B?SUV5L2t4V243OHd0SWVJak92YlY0T2hJUHFWbVpJMUJIaWpIWlF2ai9DWi9P?=
 =?utf-8?B?cnRjTFFxQWlrTGxqSEVMSGwyMzhqR1dNZjU0anZ6dWlJYXNMTDViQm1BWlhB?=
 =?utf-8?B?VGVvWndZMWNsc05iN055b1VXdlRma05YNXpEYk9qa0pJYTF6NU1ueUJmSjVS?=
 =?utf-8?Q?DfRZBjpm6JY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SzBYZU16VnBHbnRNT1BQY1A1RE5jYlpkbUVSUVBMaFZyQnJsY3hWaDdlTlh5?=
 =?utf-8?B?dVdKMTdqYmM3b2F0TStuZkpET2krMVVEM29NVm1GNFF1WVU3WlhOeXRlMnF3?=
 =?utf-8?B?a1NTNUlQbVRldmZMWTFwejlmVzA1bUI5Si9yUXdEd2xERFpFWXdYVGdNbWU5?=
 =?utf-8?B?QnpXWmdxaTVDZXBwYjdKeDQvZHp2OGRac2hZQmo2cElQQ05mZnNZTHEwdzhZ?=
 =?utf-8?B?NlJJdzBQM0JIeUcycG5rNHBNdWpyYSs5aGgrY1I0RzJ2ZHphOENSbzN1cFAx?=
 =?utf-8?B?akJaY253ZGRBNWtucyt6K0ZhdG1pRS8yNGpKcy9lOWc2aHBNSDR1d1B5UjRl?=
 =?utf-8?B?Z09CKzZCNndtY1F3M2ttMUJZc2p2TEFaV0hYdXg3UlExb3N4cy8xdVBZMk5n?=
 =?utf-8?B?Zkl0ZzA3RkdyL013SkF5MFJhU1BoMWYzSE5HVmV3dGtlUHhBMEQxcUxBV0tU?=
 =?utf-8?B?R2hobzBDR1ZlU0lVcW8yQkowQWpZU1FJaUJwYnZjTlFuNkl5SU9ic09TVHhx?=
 =?utf-8?B?MngrOUcyWkZZV1hZWFdvOVN6WEJMcVdobjQwaFkvVHlkcnZHbHZKeDZ1UkN6?=
 =?utf-8?B?VU9wNnF2cWc4ZHZlVHYvdDFhL09DSDFnY1ZrdTZXaTZUbFdYU3FkcUYvczg5?=
 =?utf-8?B?aGFJbXJNeCtGMTNjaDJEeDJTdTZOZ3BzN2NaZlhVUUdvWEM4cktZWWlnQVlE?=
 =?utf-8?B?aW54WTc5U3BNcWtBaDcraXRWaXU5eEF1UndTcTJzMm5ZcGsxbVpJZWVHTVUw?=
 =?utf-8?B?enZWam5lL2hYTlJMRGROQ0FHenlMekhLSUFYa2wySm9aQmlSV1VIRGg2Ni9s?=
 =?utf-8?B?aWhMbE8xbHFrZmxacU9TcnlwQ1ovMW5JVnFvWEpidU82cGJwbVU4Vmk3Smdi?=
 =?utf-8?B?dnVuZnhUOUZ3dW1EUzBUdlltcTdnUHV0WUdHWEdNbjlyV2tDVVlZM1NDcEdo?=
 =?utf-8?B?dmJubEFUa0l3b0t5OHc2MlJMNHBvaG5YTkdWSmhKaHBvSStsQVZSMzBoLzFk?=
 =?utf-8?B?ZzNvYkdmc3NYN3RkMUhjNVFiekZBSE14Rm5ZRENXdldldEkrWGRZRFVlSEQ1?=
 =?utf-8?B?L1cvQ090TnBLZlRMdnRaT3lUU2dlQVRma2UzaDU4dThJUnNrNXN3SUQrQmcy?=
 =?utf-8?B?NlcveGE1dGdYRGN5U1kvMlUzanhXbFNpNDFOaFR5cUR5cVZINzU2R3AvSkk0?=
 =?utf-8?B?NVhTZ0VVVG1icUE0YWk3RmJtUG5HTTdBanQ3c3BNNDdWTG42aHhKZlJxNFJk?=
 =?utf-8?B?dDVUYXNDWWZTOGlXVGtyb0hLblJwSjlZYm9vS2t1V1ZzdnEvSmp0dXpNNzA3?=
 =?utf-8?B?aFNpUS85RVh6N3A3QzJXaS9NYlE4UHgrcWpTanVUU2lpOEhOQ0RxL0FGa0V5?=
 =?utf-8?B?SHNkV2NXdGRheGovczBRZWdrdGFmMjNUazZpMTB4Uk5QT1V4cW1zTHdwUVdy?=
 =?utf-8?B?Tys5bk84UGxBb1BmdlZmSTEwNHBHUmQweUlrNkE1Vk9hZnozV1BrU3NGZDA5?=
 =?utf-8?B?MkJwejVmV3dhK1p3UGx3aEVxZ0JUM0xBYUtROVV3eXZCd2VTSGw5ODJrc0Uz?=
 =?utf-8?B?YUVTYnlGWFppWHRxZUtORWRvUTg5UWR0aVVWQmJLZVFUY1VZUUdFWGkzbmFW?=
 =?utf-8?B?ZjZhSE9aTC9KSkVCNVZYaFdNRVAwc2xQWk1HS2owOXFqQlFPcTVOTEVydHZu?=
 =?utf-8?B?UEZhQytRVmdiTm1VR2thK241T0ZPWTJxWWFjWFpNUFpobndpWXNwNmVBOGZx?=
 =?utf-8?B?RFJYWmd2dHZ0bUoyOEpwT2pCZE52c1ByRW5mK2x5UnNNS2pJb3dncjlCdmx1?=
 =?utf-8?B?eDJlbDNoVkFJWDJubDlxWk91aFFzblNKRS9MYUFwd2YwMG96N3AraU5TdGlh?=
 =?utf-8?B?dEYrUi8yQ0RsZ1NRZmpkOGlxdk1HUDFYVjBiOUhwSUM2ZW9vUGhxZVVVMWgx?=
 =?utf-8?B?YVVwMnEvZHJ4MWRrWkFucktOSm9iL3NCMWZ5T0ZOT3FRa1RrZzJSQnRjRFlu?=
 =?utf-8?B?Z0ZFdkxHa3Ezbk16cDY5K01ZRHJDQnRSNExNdHE5b2R5bWlWTUhkSXBkMjdy?=
 =?utf-8?B?TjB6QnNub3RHLzdhME1XQTNtbGRCVjFMcmhzajdCbWNja2VzVHVSSmZLdlVh?=
 =?utf-8?B?V0p2ME02R3JMWUNDa2lCMXBxdFB2Z3ErSGlyY2dUN0UyNjM3RmVncGdMSElj?=
 =?utf-8?B?MEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: UNJl45N89gSlgr6aj45JcwFnsIX1PzWguyXNGXGxthSLfmT9lE+G0mHCNHa6uUdNDiAALCtCCa6Nn/zGJ/xYl8bM+EWYO+JX39+4ClIZ35CtLY001BuowZWUfN1Wu51uI1bKEcIaJ/dike0KJTtx1NQCryw4OdLTMX0iCwlcuVZQDo6qvX8w8wyk72KYzAlhQaMlp5DkHPLSDMjDnPPzloaI+5qKAUeJLwugBb3IXyaPLkekbUGjLdfsWufjnWaMVxwn3X+Dlqp9pIOwWiFW+wh1LBIw+cKSPyF2xcSCPE3R4yugJSR5t3yT8WxKo66fR1u3P8x/itKSdK12yWpT6RziahwIpIlIH4Pxac26eXNZbcuLWLaboGB61Ssepe6zTwBWupxBfPU0MnyYjmBiyOE5jvbNoGcu98WoUpzUFmzqsFW0+fxRgWyDqUNzIBiYLqAOgiBt1AxH96ShHXTOOjCJp4gKMJpZ+GWfY/lUPP4RaM4kC72Wy/OWr9jbtD+SVaqNhviv7pCDruP+FRFQEkZATMwFdrKzoRY+3+uIpb9+KvG4zXJwzAf4VXF/XmI0xyZCYNrzfA/pTNf2uytC4EnEwFoJK+xsN6FQmuMTKzo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b3a8259-4344-4c27-2f23-08dd9956686f
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 17:30:55.7109 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D57AX7sVDA54ClXYhF/3yC600SOXBV+0HGkZkep8fdnOv9KHo+Ra8mHRhwtOl92wPdPhjkrZnBIbE+sv3prmULPIYHziLmKyUeofO1ofloE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5079
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-22_08,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxscore=0 spamscore=0
 suspectscore=0 adultscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505220176
X-Proofpoint-ORIG-GUID: 5wkkuRWBR7-VX6IcWcGwHmwa7Ye1vAJp
X-Proofpoint-GUID: 5wkkuRWBR7-VX6IcWcGwHmwa7Ye1vAJp
X-Authority-Analysis: v=2.4 cv=LZ086ifi c=1 sm=1 tr=0 ts=682f5f54 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10
 a=yPCof4ZbAAAA:8 a=64Cc0HZtAAAA:8 a=R-6f2J738CO-T5ZvDE4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13206
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIyMDE3NiBTYWx0ZWRfX1Egn+n6lS5Fo
 5CRKGBNIVDZBv1QT+G5/5Y9ZBBB6eqcWaN7bfSaJ79gZDEu2/PdLGffqJD387yW1JFmL30uHCCZ
 vQxtsiS69NLQi5dqrq6N627Bc1uLcqhaxvbnaBPZu/Lle0kTXhuBQqYGO1KTfGRYCascQj4d21P
 5Q0EbuqNtLP503Xl5qn6lyxBX/HmOaqbpd65vqOWiqYL1WktEWW7i2WAzxdeqvYvMaeqFp+myWX
 EhRsxrlribaky5G26zWGRzxJBCXtsTK6zbiyDXm/rUuyMvfijbesFgQzyy/+UTpx31O7l8mqeTN
 pHieEHaDBDo2x7xI7VE7JryO4zuf61YxO+wCeIrwYuXrdMEwvmTS8t0qCHk6sIycjezDdmCzaxt
 vaXA02+5mcB4695ng2hy4EG0aFF7SleNYvs0XhwyiGTdTvD1Z6PlFv5K7QatlWZHc+Qrq/nw
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
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

On 5/22/2025 1:20 PM, Cédric Le Goater wrote:
> On 5/21/25 23:55, John Levon wrote:
>> Pass through the MemoryRegion to DMA operation handlers of vfio
>> containers. The vfio-user container will need this later, to translate
>> the vaddr into an offset for the dma map vfio-user message; CPR will
>> also will need this.
>>
>> Originally-by: John Johnson <john.g.johnson@oracle.com>
>> Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
>> Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
>> Signed-off-by: John Levon <john.levon@nutanix.com>
>> ---
>>   include/hw/vfio/vfio-container-base.h | 9 +++++----
>>   hw/vfio/container-base.c              | 4 ++--
>>   hw/vfio/container.c                   | 3 ++-
>>   hw/vfio/iommufd.c                     | 3 ++-
>>   hw/vfio/listener.c                    | 6 +++---
>>   5 files changed, 14 insertions(+), 11 deletions(-)
> 
> Steven,
> 
> Can you base the live update series on this patch ?

Yes, its already on my todo list for V4.

- Steve

>> diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
>> index f9e561cb08..3feb773e5f 100644
>> --- a/include/hw/vfio/vfio-container-base.h
>> +++ b/include/hw/vfio/vfio-container-base.h
>> @@ -78,7 +78,7 @@ void vfio_address_space_insert(VFIOAddressSpace *space,
>>   int vfio_container_dma_map(VFIOContainerBase *bcontainer,
>>                              hwaddr iova, ram_addr_t size,
>> -                           void *vaddr, bool readonly);
>> +                           void *vaddr, bool readonly, MemoryRegion *mr);
>>   int vfio_container_dma_unmap(VFIOContainerBase *bcontainer,
>>                                hwaddr iova, ram_addr_t size,
>>                                IOMMUTLBEntry *iotlb, bool unmap_all);
>> @@ -151,20 +151,21 @@ struct VFIOIOMMUClass {
>>       /**
>>        * @dma_map
>>        *
>> -     * Map an address range into the container.
>> +     * Map an address range into the container. Note that the memory region is
>> +     * referenced within an RCU read lock region across this call.
>>        *
>>        * @bcontainer: #VFIOContainerBase to use
>>        * @iova: start address to map
>>        * @size: size of the range to map
>>        * @vaddr: process virtual address of mapping
>>        * @readonly: true if mapping should be readonly
>> +     * @mr: the memory region for this mapping
>>        *
>>        * Returns 0 to indicate success and -errno otherwise.
>>        */
>>       int (*dma_map)(const VFIOContainerBase *bcontainer,
>>                      hwaddr iova, ram_addr_t size,
>> -                   void *vaddr, bool readonly);
>> -
>> +                   void *vaddr, bool readonly, MemoryRegion *mr);
>>       /**
>>        * @dma_unmap
>>        *
>> diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
>> index 1c6ca94b60..d834bd4822 100644
>> --- a/hw/vfio/container-base.c
>> +++ b/hw/vfio/container-base.c
>> @@ -75,12 +75,12 @@ void vfio_address_space_insert(VFIOAddressSpace *space,
>>   int vfio_container_dma_map(VFIOContainerBase *bcontainer,
>>                              hwaddr iova, ram_addr_t size,
>> -                           void *vaddr, bool readonly)
>> +                           void *vaddr, bool readonly, MemoryRegion *mr)
>>   {
>>       VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
>>       g_assert(vioc->dma_map);
>> -    return vioc->dma_map(bcontainer, iova, size, vaddr, readonly);
>> +    return vioc->dma_map(bcontainer, iova, size, vaddr, readonly, mr);
>>   }
>>   int vfio_container_dma_unmap(VFIOContainerBase *bcontainer,
>> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
>> index a9f0dbaec4..a8c76eb481 100644
>> --- a/hw/vfio/container.c
>> +++ b/hw/vfio/container.c
>> @@ -207,7 +207,8 @@ static int vfio_legacy_dma_unmap(const VFIOContainerBase *bcontainer,
>>   }
>>   static int vfio_legacy_dma_map(const VFIOContainerBase *bcontainer, hwaddr iova,
>> -                               ram_addr_t size, void *vaddr, bool readonly)
>> +                               ram_addr_t size, void *vaddr, bool readonly,
>> +                               MemoryRegion *mr)
>>   {
>>       const VFIOContainer *container = container_of(bcontainer, VFIOContainer,
>>                                                     bcontainer);
>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>> index 6b2696793f..46a3b36301 100644
>> --- a/hw/vfio/iommufd.c
>> +++ b/hw/vfio/iommufd.c
>> @@ -34,7 +34,8 @@
>>               TYPE_HOST_IOMMU_DEVICE_IOMMUFD "-vfio"
>>   static int iommufd_cdev_map(const VFIOContainerBase *bcontainer, hwaddr iova,
>> -                            ram_addr_t size, void *vaddr, bool readonly)
>> +                            ram_addr_t size, void *vaddr, bool readonly,
>> +                            MemoryRegion *mr)
>>   {
>>       const VFIOIOMMUFDContainer *container =
>>           container_of(bcontainer, VFIOIOMMUFDContainer, bcontainer);
>> diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
>> index 38e3dc82cf..7495866123 100644
>> --- a/hw/vfio/listener.c
>> +++ b/hw/vfio/listener.c
>> @@ -170,7 +170,7 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>>            */
>>           ret = vfio_container_dma_map(bcontainer, iova,
>>                                        iotlb->addr_mask + 1, vaddr,
>> -                                     read_only);
>> +                                     read_only, mr);
>>           if (ret) {
>>               error_report("vfio_container_dma_map(%p, 0x%"HWADDR_PRIx", "
>>                            "0x%"HWADDR_PRIx", %p) = %d (%s)",
>> @@ -240,7 +240,7 @@ static int vfio_ram_discard_notify_populate(RamDiscardListener *rdl,
>>           vaddr = memory_region_get_ram_ptr(section->mr) + start;
>>           ret = vfio_container_dma_map(bcontainer, iova, next - start,
>> -                                     vaddr, section->readonly);
>> +                                     vaddr, section->readonly, section->mr);
>>           if (ret) {
>>               /* Rollback */
>>               vfio_ram_discard_notify_discard(rdl, section);
>> @@ -564,7 +564,7 @@ static void vfio_listener_region_add(MemoryListener *listener,
>>       }
>>       ret = vfio_container_dma_map(bcontainer, iova, int128_get64(llsize),
>> -                                 vaddr, section->readonly);
>> +                                 vaddr, section->readonly, section->mr);
>>       if (ret) {
>>           error_setg(&err, "vfio_container_dma_map(%p, 0x%"HWADDR_PRIx", "
>>                      "0x%"HWADDR_PRIx", %p) = %d (%s)",
> 


