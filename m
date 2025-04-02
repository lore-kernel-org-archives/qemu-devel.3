Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8120C36017
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 13:44:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzyOO-0004tR-3E; Wed, 02 Apr 2025 09:44:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1tzyOF-0004t0-Hi
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 09:44:26 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1tzyOD-0000jN-BH
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 09:44:23 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 532DN1JV017814;
 Wed, 2 Apr 2025 13:44:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=/x/Joz5MmBlqgZcuPL/e8wBpVoZw7cfBjB/E0gY5INE=; b=
 CddKSNKWusBpQQZ36BmKgN2+cuidzo1IYmrw4/y8OTh3ro/cYxv/1Nht5O8Tf62z
 AslXrvdDOL5jMS9HhaKMvddbp9Z82v+bbf1Di2lz3NIh5+fsHVu7bKe7LVwt9hBR
 hA8GTu3cRZ7CyKWA3v4Wy1JgsKPEoy9QN6OiIId8aDHZ+kapnBegtA0CEY1Zqv4u
 97FfP4cMX3vlWsc7JxGAREXnIgLfnOFViZF2hIVYCaccKNLhNHqkE6evowfa9djU
 ORsnSza9mf59Yk+shWvLUVQX1vE90bObtJA5oKqbnMxNB5w88dlxszMfJlevpbe0
 x/SXxQpXRHzJVQxrpYxsEg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45p8fsasb1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 02 Apr 2025 13:44:17 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 532Cm95H004236; Wed, 2 Apr 2025 13:44:17 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 45p7aaxnvw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 02 Apr 2025 13:44:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O2bO7jGO2JuhtsvUerTlOS7gqaj/cg3Xk6eaHng1smbIjXUT5YwZC4nrcaaNpYM5xyPvb1g+j1kX49e5P6gHUJJ2XGZbP64/yPLeC6emWXclfOuSw44v6FAdp9dAdBT+iuZE8GcRbtFwTz1F9nWqrSrglPKzFU3k7DIQt4b3wAd2S+8SQt/wfzflft6Ky4yTqJx/DrROJpPXaVNLG1S0FfN4dWWCYJM18A7vSn3Vc/5LN43VciRUQLuh/5kageqvAiSKMsLx2/uwJx1zANhObGFdLktVLRMJuJe+vejp+5y7DJiclBJ0mKI6Pd+K2OSPhfwEDMpGr0/uKdcuUkCvZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/x/Joz5MmBlqgZcuPL/e8wBpVoZw7cfBjB/E0gY5INE=;
 b=q2mY1VhR8Ztkq7wPAXRkVj6kRHLaTflDUqR6skG1qoXaLzORPfcM1xB75CdgR5JtTlv8v7uBG2O8BBJsjtjnkZcFkNZIAZUEULmaYonWG4Tq4S+H7Ebj/6RnoOfDualPd3kFOrEWDzWxq/QUm1pEUF40RRavBavkXWZUR3Tg/HfUDj176LXePgB4mkbJ5g1gKFE3CoShz+OjC4CKUahb4vaErwvCRMJvhOlD2/LdbV2NoJjNLr6b7j1q4+i0S0Vc+mlGjBtr+AoBTcphN8Z0iISQpVSBiIz0NA5BNNJkystZ1uRhBDm2dTaqXYXttnIXsafRDQzbHvFvY72PTHUwfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/x/Joz5MmBlqgZcuPL/e8wBpVoZw7cfBjB/E0gY5INE=;
 b=JAmXXBY+cTAnj7V9AoMel3xLjkP+g8H5QRZGFLOFxd0ZwXInjwzs5B883Nr+2hGEZrClymmyGMe5o+Fy6xjI+v5dxuLFtmIx5zv3OpHw2NmontChpDmBWwRmEZye8vlkMtxBBKLcrSy5pIH9OeESjS1MJF8YGr2YnCUHoBZV5Ew=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by CO1PR10MB4642.namprd10.prod.outlook.com (2603:10b6:303:6f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.42; Wed, 2 Apr
 2025 13:44:14 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%5]) with mapi id 15.20.8583.033; Wed, 2 Apr 2025
 13:44:14 +0000
Message-ID: <fbb99023-3f46-46ae-b5b1-7a8b5f5f2e11@oracle.com>
Date: Wed, 2 Apr 2025 14:44:09 +0100
Subject: Re: [PATCH for-10.1 v2 31/37] vfio: Rename vfio_get_dirty_bitmap()
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org, 
 Alex Williamson <alex.williamson@redhat.com>
Cc: Avihai Horon <avihaih@nvidia.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 John Levon <john.levon@nutanix.com>
References: <20250326075122.1299361-1-clg@redhat.com>
 <20250326075122.1299361-32-clg@redhat.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <20250326075122.1299361-32-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0208.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9e::28) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|CO1PR10MB4642:EE_
X-MS-Office365-Filtering-Correlation-Id: f7558ccf-a83d-43c7-1ee4-08dd71ec74eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NGpaMktkSVc3ZUQ0eGR2b3FqZFJSTHVjWEVHRmhuMk91VTdBMWxCZkJYTkUv?=
 =?utf-8?B?U1REVVIyZDJWL2FEOUpGSWo5U3BUdHVxMThET1d1b0M4cUxKeWY3Y2NsL1VU?=
 =?utf-8?B?eHZCNDFaSnFEQzBCQWR6elErQWZxcTJ0a3B3NHFZek0yK3RyWjVuc1NBOUZH?=
 =?utf-8?B?UzE3dGt3Ym9FdzJnWi8ycHA5MkVwOFBYZFV5WlUrRjQxbzdhaU9qZFVKSUJL?=
 =?utf-8?B?bis0ckdwQXg4YlhhWkhGNnlLMFJ3dzVHVTd2U2RVd2cyVS9wVm5OQ0VvWmZS?=
 =?utf-8?B?OVlRV0U4eFBEVjI0UmROSitVYmtwY3JCdE1QNGV5bFVrM1VKamJXQmt2Um8v?=
 =?utf-8?B?Qm0wMW52dWtCYXVucVJ1R00veFlNTitHaFI2RHpKckNIaXRrbi9qUkV4aHRa?=
 =?utf-8?B?ZDV4TVB6SG9JZm1UZ1RrRHRPSnRuOW9TaTU3OFA5YmwvQkw3QzRZV01Tdm9l?=
 =?utf-8?B?Z0h4QmtmdmNHeGNwUk1rYldlZFlhbEx6MFNZZnl4Y016Y1Q3VFZkeGNjNUFC?=
 =?utf-8?B?SGtsUGpXcWxuT1IwbnZucDUrM0xINVlSZmRpaDErMHZ1bGtqRHVWalNMU0VG?=
 =?utf-8?B?Uy80ZlFpb1FNL295VlVRR2dJMVBTRmZRTGJtS3c2VnFRYWY4SWV4NFlRNG5Z?=
 =?utf-8?B?MmpaV2czRzNOUlFzMGxHQ3g4M3d4dEhTY2VGYUdHSTBvZ1JYdWVWY1ZJSFlD?=
 =?utf-8?B?VFQ5MU8zV2QzTEVRK21hYVlqb0VDdmlHU01IWVRNYnYxdzd6RjR3OTZFbWFv?=
 =?utf-8?B?dXVrUURqY01hOU5USE0zMW1uMmdsZ3BsZ1JySUU5UlgxSlFGdXp0WTNCa1Bn?=
 =?utf-8?B?ZjgyK1hsTmcxTHh5ekMvYVdod0hZTWdIbklIczJkUGMxU2RtREJLdzcvUHZ0?=
 =?utf-8?B?OTVERlhjakxnd1J5RW1tbitLQ2M3NHpONncrN01RbTRBdDROZjEwdWk1a0Q0?=
 =?utf-8?B?MTFBczN5U3JkS1FLMjU0YzRuZ1RMUWRmelRnaGVuc1dOUDhodjlCUm5RYUZF?=
 =?utf-8?B?ajh6WEwvWWxuR0FQOG80dkJldzdGSC82Zm45eTdFcGw0c2NBM3F0bG54Q3ZN?=
 =?utf-8?B?dnU0aU13cHNPTm5PYWNVbjlxOEw3ejB3cDBIVUw0eUZYbGFYQzFHcGFJckpu?=
 =?utf-8?B?UkdVcFNEV1l0TnVQVGxVZ0wxR2lrRGhsc3pwUXYwdXZUTXBvQklhK1pKQ3hE?=
 =?utf-8?B?ZEo4ZGxRaTdmcnptbmJkLzZUUy9TZG5UOFJCQXAvd2RnYkxZclFIMmI0bEF6?=
 =?utf-8?B?bTlDS3o2a1A4cFdFQ1JlUy96WWtTbjdWYld1UlI2YysxZWcwRWgvUHNUakFo?=
 =?utf-8?B?dVB3TytESVplVFg0MVJnSnVsWkNOZ29TNzhpR2c5ZWRwSDdqa0M1NW40dG9q?=
 =?utf-8?B?T2NWZnk5WjYxM0Y5dU5hVnlGWWM5Q0EwN3c1cFJKWTVKVVo1bEw4Q0kwc1lm?=
 =?utf-8?B?dThTU3IrUjY3OTZOMlpNWUo4TmVSb2ZENUJkVEVTc1IyWUNjWHdwQkt0bUh1?=
 =?utf-8?B?dWNvbVN6RVd5eExpODhwK083OGMzakRlMk16M01TS2xFK0NZV3AxSHhRVzND?=
 =?utf-8?B?R1pjaFlWVnFJUWU5aEdXMHlQWVh3ZmREQWkyT0YwSkFJVy9tcXdsMU9zSWNR?=
 =?utf-8?B?c2tDUlVLRS9XM0psY0VJRTY3V0NFcEpLMWJhdWdyTUc0R3dFVjlxS2c1YzUz?=
 =?utf-8?B?QmQ2TzdvdjI5c2tFZElVWWpEY3lrWUJVOUY5NU5meTB1a3phSEFIRlF6aGFl?=
 =?utf-8?B?SFFjajQ1REhLMGpiMzNSb0t5VEwrMllwWXJHeFphQ1pHcG5zd2VRclVqczdw?=
 =?utf-8?B?NlIrM3NaU2x1eGtQMk9rUVIrQ1k2SVZaOG1mS1RibW1oYm5HNzlFODE3aXdH?=
 =?utf-8?Q?ewQxUdSwAWW/E?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UjV5NmdzWHRyS2F5VzBZbW9aYzRtMW5LVytOdlZ0RG00Ykd4ckdjcllGTnVQ?=
 =?utf-8?B?dFcrOFpHbm9RWlc2SVRVVTVUdE9wYTJablovNi9Vd084bXZoSnpjSUNNY3lu?=
 =?utf-8?B?UkdqYUlKYy9hQUlNUDhJanNtcjlXcTV4WmdQV2lFOVZyT1BRQzJiRUNoUWdK?=
 =?utf-8?B?V1ladW50Yi9TM1I1QmhyMHV2bzZYRDBXWTlZclYwaFo5aUpYekFQTDIzNENJ?=
 =?utf-8?B?dk05VDM1QVhaQjFtaVNkWG5GRUpBQzZKV0N4c3VkRVNQYTlvdmdVNmR6VUo1?=
 =?utf-8?B?VnFPZkxtSHo4YjhsNmxkU0NZWEZKSjRvbUJHd0xBUDRMbHVJdFZBOTI0aGUr?=
 =?utf-8?B?a1hjS0NQc0RaNVhBeDJ0ckQ5cVpRYlcyN2NDTDR0OG8yOEQ1b25SVzRGUzcr?=
 =?utf-8?B?eFJyRTN2bS9EY2dvMk1UNmJOMU9MQlRLd1UzemlVYXVXNVFXUS8yQlE1Z0hq?=
 =?utf-8?B?dHJtWExwYTdzRHhuUWVwOXN3YkZBdEJsbHRRekdNaUxvK1hURThDYVBLL1Zl?=
 =?utf-8?B?WkxhZWJSeE5McmJZL3dNVWdFSVlmNW1oRWdpdERGdlFCY2t5QnFOZ3ZKbW1l?=
 =?utf-8?B?bmlER1plb2VmcVExcUxmcjZzaEFBNDI0cUc3elpWZHVFN3E4dFJmTEVSSWJn?=
 =?utf-8?B?d25WcE1ZQnlNT3NsbFRMaTFXZXE1UlhOL3R4VWt2b1NVTEZnQ1QvbXk2UmFK?=
 =?utf-8?B?OGtCSlNRaTJIa1BBZW50SDRqWVhPU1dQYldwT3JtU2xEMDA5a1pjSFBFVUxq?=
 =?utf-8?B?aU5DWUhvVzE0blNXcEEycjRiVllWbUU3SXduV24vdy9UVk1paXh3WU4yc2Iz?=
 =?utf-8?B?R1VvVHVTN1ErRmMrYXFmZXBQNmZiMllhVkh1WmV5TlZhK0p1eDIzbjNKTG5a?=
 =?utf-8?B?eFRkMnV5WTE5Y3VGNkRMKy91Mks1SC81ZjZzWk44RGE3SDNzMG9JTkhZZFd4?=
 =?utf-8?B?SXp6VUFwaDl5NktzYVZWTlg1SmRUVGtzMERzQU1xRWgzejNhUUVGNWRSaWUv?=
 =?utf-8?B?Snc3ckkrK0M5ZEZxTUROaE12S0pOVzROUUNxSitQb1ZoVllQZmhwbmd6QTdn?=
 =?utf-8?B?emRnNXVnKzNHNlBJTkJXNG9RdE9ic2hOZ0kyQmFnT1B0QWJYWG5RMHNVTDhj?=
 =?utf-8?B?RG9SdTNabmI2WEdmZHpwWE1LOVIwS1BHUHh2Tm9sZ1J3aDJCQklwaHowZGtR?=
 =?utf-8?B?eHhpWVBZek8xY1VvVlBBUkQvcFlZYWRkSDhhdHBTamZ1dnBQZnFOTFRNYVRO?=
 =?utf-8?B?T3NTb2VPRlRKRHVaNzZubmNlZzJOSkZiY2JXS09TMEVuNGRpT3phVUdnN29B?=
 =?utf-8?B?cm5QYkpJeG5waWVUeHQ1YzdmbjJiQ2xXbDI5UDJBWEN4N3A3TG5mSVdOSGZ4?=
 =?utf-8?B?ak1zUUt5dlFUdStCNG1Dd0ZTTm1WdGUzeGdSMnJSamFSZlpYRUpNWWxROFhp?=
 =?utf-8?B?dklwTGxJc1gwNG5teVorWklCTUtTakIyOUEvMWM3OWJlK1ZGN043bWtBM0th?=
 =?utf-8?B?bVJhbjBvb09BUTV3eWZ5Tml0NjBoUjFEeU5GZjRXN09ibHl3Z0REeVJlek9i?=
 =?utf-8?B?MndKRW9pam56RmtFNExJL2tocmp3RVA3ZHZFNVBaQWY2VVR2ckRuYWRkZHlr?=
 =?utf-8?B?ZkhIMEpoOEJXSlZZWnBNWXZramNDb3FHN2xMcnJrQ0FnRHdVRmpRUnR4Sld2?=
 =?utf-8?B?cXpnUndWWmp5YjcxQXQ3TDlhSFBCeXVpZDVJWFVFcU12TTNrM0tKcnAvdkhK?=
 =?utf-8?B?NDNIcGZTOWhHQkw2V0F5R21lUE9yY3hSbFFKOUFVS0I2NHRES2NpTkwwVjhz?=
 =?utf-8?B?MlBmQWw0dlQyY1pocDhVK1BxejBldkxkV0RCYXNoV3RCWE5lMWMzZ01iTlo5?=
 =?utf-8?B?R1ErTmZrYW54U0dRM01KbExSWWpaTmlMRHFtREZGaFp5UjlYMFVQaWtRdTNo?=
 =?utf-8?B?VVhweG1OWThhQUM0eEdWNFJzR1V1em5ZNnZHeVoyUFF0NWRYR0Nld1lnMVlW?=
 =?utf-8?B?anB3eG9KdXRuL0Q5b3hFUHZWN1BZeHk0T2MvZXZIOCtkY0RlYjB2NE5iRjAw?=
 =?utf-8?B?cjNXWjMwTUdUcUxGYm5SWXJUQ3drcjhkcEdCYzVxbnBnME1nbytTRGt6c0FE?=
 =?utf-8?B?aWNLdkJvayt2SE4zaTZGbFFqK1RzZWZOMlNSMlcxT2NyOGhKSHBpL25qNnBy?=
 =?utf-8?B?cHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: EMMyjrkXv9KkvdCdmej25FR+rLN2q6yBSL+SBcmSzyEMUIGuwHXfkZ5fhONS5Wd64UxPe3d++iTVJGPcsWqoFZ3VW7vJWp1km9Y2MnAZITdb6Cy9Lm/rIiWuGIdoNPe37m1z5mz58cRMjWHiZ7HSyRxzT9PKYzmw5HGucJ24mLEvHWyd7WhzFYuH0dBIN0i09qgJzFf9wKnKn7+ngfHHzTR58j4xNS1GUQ0sAry+yw3nCOT6xiWpdEerD3EzVlGRw7waC7GUO4WlDAcMBvBl9B2lMLjyLk7y8NM/elMs3oTxV9vJvEQ1jupX9df4Fr0dc7DCbYFIqne87QwCw6QPUM8GhMqkpJWhCPqMAn/NVbVT5EISiR3K4nnaU3rhbj+sE/ftN6OkZ3B0BnVxm32pcI9zwArqgVDkuTJVD8fLPqnJp654YpkCAkwppkKv7rZ0JC2kuVTx8VbWXLohSWJt+fA47Kgc0UH/YwhwpV3AC3bpIsUDn+RHy9xTEVsMcUXxg3cR0/ScJE+YIyzUwEXer5+njgWpTlslkyE+5xvJJNTr6gXRbe/XGuzXmH8Uw8WhSjqACs5vfeRPXhe8kMKo/6MWToGmKzH95hQwVoqzzO8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7558ccf-a83d-43c7-1ee4-08dd71ec74eb
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2025 13:44:14.6878 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /essgbOqLY+ROt6ldhauZn8UJ2Sg4Xla6mvvGNiJP/yDHQaYak7e0504j43TIBzP+BJTMmvEqTSEz0iNI8iRT9tHZkilqIa4ZMNYKkS5ISk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4642
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-02_05,2025-04-02_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0 spamscore=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504020087
X-Proofpoint-ORIG-GUID: 5PeUZ0zXHOJPta9izrXEpkVIi6BqScaG
X-Proofpoint-GUID: 5PeUZ0zXHOJPta9izrXEpkVIi6BqScaG
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0b-00069f02.pphosted.com
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

On 26/03/2025 07:51, Cédric Le Goater wrote:
> vfio_container_query_dirty_bitmap() is consistent the VFIO container
> routine naming scheme and is now free to use.
> 
> Signed-off-by: Cédric Le Goater <clg@redhat.com>

Reviewed-by: Joao Martins <joao.m.martins@oracle.com>

> ---
>  include/hw/vfio/vfio-container-base.h | 4 ++--
>  hw/vfio/common.c                      | 6 +++---
>  hw/vfio/container-base.c              | 5 +++--
>  hw/vfio/container.c                   | 2 +-
>  hw/vfio/trace-events                  | 2 +-
>  5 files changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
> index 163d9b3c30b3093d2f40bb3d3ffc0314519ac285..a441932be779e5c6740da78f005ed2c8320e7cb2 100644
> --- a/include/hw/vfio/vfio-container-base.h
> +++ b/include/hw/vfio/vfio-container-base.h
> @@ -93,8 +93,8 @@ bool vfio_container_dirty_tracking_is_started(
>      const VFIOContainerBase *bcontainer);
>  bool vfio_container_devices_dirty_tracking_is_supported(
>      const VFIOContainerBase *bcontainer);
> -int vfio_get_dirty_bitmap(const VFIOContainerBase *bcontainer, uint64_t iova,
> -                          uint64_t size, ram_addr_t ram_addr, Error **errp);
> +int vfio_container_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
> +    uint64_t iova, uint64_t size, ram_addr_t ram_addr, Error **errp);
>  
>  GList *vfio_container_get_iova_ranges(const VFIOContainerBase *bcontainer);
>  
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index d063ea03c1cb4f475d421e626c703875fecd97a8..26ced6d4fb04b0dedf399686db40acaca5d85552 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -1003,7 +1003,7 @@ static void vfio_iommu_map_dirty_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>          goto out_unlock;
>      }
>  
> -    ret = vfio_get_dirty_bitmap(bcontainer, iova, iotlb->addr_mask + 1,
> +    ret = vfio_container_query_dirty_bitmap(bcontainer, iova, iotlb->addr_mask + 1,
>                                  translated_addr, &local_err);
>      if (ret) {
>          error_prepend(&local_err,
> @@ -1040,7 +1040,7 @@ static int vfio_ram_discard_get_dirty_bitmap(MemoryRegionSection *section,
>       * Sync the whole mapped region (spanning multiple individual mappings)
>       * in one go.
>       */
> -    ret = vfio_get_dirty_bitmap(vrdl->bcontainer, iova, size, ram_addr,
> +    ret = vfio_container_query_dirty_bitmap(vrdl->bcontainer, iova, size, ram_addr,
>                                  &local_err);
>      if (ret) {
>          error_report_err(local_err);
> @@ -1134,7 +1134,7 @@ static int vfio_sync_dirty_bitmap(VFIOContainerBase *bcontainer,
>      ram_addr = memory_region_get_ram_addr(section->mr) +
>                 section->offset_within_region;
>  
> -    return vfio_get_dirty_bitmap(bcontainer,
> +    return vfio_container_query_dirty_bitmap(bcontainer,
>                     REAL_HOST_PAGE_ALIGN(section->offset_within_address_space),
>                                   int128_get64(section->size), ram_addr, errp);
>  }
> diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
> index 648dd25676e5b25a7c414109888b2796f890deac..a2e7a3b2e747d422f7a681fb09b1182e119c6d20 100644
> --- a/hw/vfio/container-base.c
> +++ b/hw/vfio/container-base.c
> @@ -237,7 +237,7 @@ static int vfio_container_devices_query_dirty_bitmap(const VFIOContainerBase *bc
>      return 0;
>  }
>  
> -int vfio_get_dirty_bitmap(const VFIOContainerBase *bcontainer, uint64_t iova,
> +int vfio_container_query_dirty_bitmap(const VFIOContainerBase *bcontainer, uint64_t iova,
>                            uint64_t size, ram_addr_t ram_addr, Error **errp)
>  {
>      bool all_device_dirty_tracking =
> @@ -275,7 +275,8 @@ int vfio_get_dirty_bitmap(const VFIOContainerBase *bcontainer, uint64_t iova,
>      dirty_pages = cpu_physical_memory_set_dirty_lebitmap(vbmap.bitmap, ram_addr,
>                                                           vbmap.pages);
>  
> -    trace_vfio_get_dirty_bitmap(iova, size, vbmap.size, ram_addr, dirty_pages);
> +    trace_vfio_container_query_dirty_bitmap(iova, size, vbmap.size, ram_addr,
> +                                            dirty_pages);
>  out:
>      g_free(vbmap.bitmap);
>  
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index 9ea03ed618f6aefe35f966c644cbbc127ce7bf06..c74e08e531a501313cab27c57728a8c940d975be 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -169,7 +169,7 @@ static int vfio_legacy_dma_unmap(const VFIOContainerBase *bcontainer,
>      }
>  
>      if (need_dirty_sync) {
> -        ret = vfio_get_dirty_bitmap(bcontainer, iova, size,
> +        ret = vfio_container_query_dirty_bitmap(bcontainer, iova, size,
>                                      iotlb->translated_addr, &local_err);
>          if (ret) {
>              error_report_err(local_err);
> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> index d4cd09cb0f93485fe06984346f6ac927603c5745..aa0ba695fa38f7767bf506ec604046101186e7d4 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -109,7 +109,7 @@ vfio_legacy_dma_unmap_overflow_workaround(void) ""
>  vfio_iommu_map_dirty_notify(uint64_t iova_start, uint64_t iova_end) "iommu dirty @ 0x%"PRIx64" - 0x%"PRIx64
>  
>  # container-base.c
> -vfio_get_dirty_bitmap(uint64_t iova, uint64_t size, uint64_t bitmap_size, uint64_t start, uint64_t dirty_pages) "iova=0x%"PRIx64" size= 0x%"PRIx64" bitmap_size=0x%"PRIx64" start=0x%"PRIx64" dirty_pages=%"PRIu64
> +vfio_container_query_dirty_bitmap(uint64_t iova, uint64_t size, uint64_t bitmap_size, uint64_t start, uint64_t dirty_pages) "iova=0x%"PRIx64" size= 0x%"PRIx64" bitmap_size=0x%"PRIx64" start=0x%"PRIx64" dirty_pages=%"PRIu64
> 
>  # region.c>  vfio_region_write(const char *name, int index, uint64_t addr,
uint64_t data, unsigned size) " (%s:region%d+0x%"PRIx64", 0x%"PRIx64 ", %d)"


