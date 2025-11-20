Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A82BECF8859
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 13:32:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vM4lf-0003p9-PC; Thu, 20 Nov 2025 08:32:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1vM4lR-0003dy-OC
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 08:31:59 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1vM4lN-0003V2-HY
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 08:31:56 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AKCKQIV021509;
 Thu, 20 Nov 2025 13:31:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=LZH3bzmlAHWMDZ9b3U7tbSi6H7dFI02O3X1uG4wV/Hc=; b=
 i4Xmjir00zLO/Ft0ncLk6w7w2qNeNHMp9E5+OczQOY4MfJbWQFfQYHXTQ0heJzya
 Qwf4s09+7Y8DXrIK76W5scEUvfhRsWNNwS4xq5ztiEXWNTxSxCXYHM/6hLDlNQYX
 maExS8JeSbHY8t2JMOf+qEkDCJ9C+qLO269UJ0OctJV18EkMZZJQeS3nvpaNRvA0
 eg9OlAH5IavTR+oczmhQ15W6Iay12kCRJnuQOwsW9wcZWxVUvQ0woq5VXJCYTbcl
 uEljb0Z6d7IRQ9lJ0gesU7DpHLRksmwKbzb6eo2YtIy4IEige0Macmo0Bkf4MSz5
 mN+dWXsUT/z2wpi4zSp3ZA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aej9094tb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 20 Nov 2025 13:31:48 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 5AKCXPfH002483; Thu, 20 Nov 2025 13:31:47 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com
 (mail-northcentralusazon11013008.outbound.protection.outlook.com
 [40.107.201.8])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 4aefyc2vnp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 20 Nov 2025 13:31:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dfg6Eq/knBHojStcy5Liw/HWpeNk/II+zNnny2GvFzDW6gXiIc5Sdw5M7Lv04KpoNLJmfmvaW+Ho51fVDX95F8B3lfFEhTHriPEDl34Me9wPnDI5zGWk4DSJl5vNr4TkwA7qY8osnDHCtmD/GBxuUpyGcnJ45xS3Iia5RoYN7AasY2PZ7YWVPh+w0E9j0PgOXwS3rZPocme7Jr0nzigtPMebtOsMONzkR2hPxxeCQ/7Gg0eMHuBRpv7bdLgSNlK/DLFKvn7KzNnGlJfz70jhnGV6exmHyNe04agwkuflnRR1rmA+6DN/bP1l7Az/bx9dNcgx6uvzED8eYq3jUrc25A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LZH3bzmlAHWMDZ9b3U7tbSi6H7dFI02O3X1uG4wV/Hc=;
 b=Hchywa++ScNK1yOsPP+9rt4cUF/vNlv92n+julap5bCfRKtRD5IxQdivLztDxvqUlmQ5uUr95fvkSoLzAagDY+hejU2fKyUhbhJHXoYR/J34Myz3/vDJKd+/+dGnYhhwdwT1+q7Z2EkLQXw66iz2m6H9BjzZC9klUpuBhygfaZYxI/zMXi4UnH8cOUzNmP+tAOBtWWbYiArj+fAnDBu/G+6aAdbxB1jIx3jx1hKVljzunU7uiEs+TY6C9O3ZRU0srosBDuN59MkiM/FQ5cgnxU+gz+HkXkqJG2OyNJ7ywlDnr0/O5RzX0YQmXhDqMZB0MffA2m2VuVyDl0/AUdiOHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LZH3bzmlAHWMDZ9b3U7tbSi6H7dFI02O3X1uG4wV/Hc=;
 b=U/ZM8okU+i9L/M9ljhPiPxWf1oGQo7nONVkfpWV4bLGX2raDqCur/PzsYFj/gyWrJ1SGnDVti1ISL9MK4HzXU5UiUQH/B8tsGFuvjBVCn9nH0i4n7kITOiWndYa6Le5eX8kbbvaZq3m4lE+SeTY3uPvD2xJHguWwqTUuS5AcPqI=
Received: from BLAPR10MB5041.namprd10.prod.outlook.com (2603:10b6:208:30e::6)
 by SJ0PR10MB7690.namprd10.prod.outlook.com (2603:10b6:a03:51a::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Thu, 20 Nov
 2025 13:31:43 +0000
Received: from BLAPR10MB5041.namprd10.prod.outlook.com
 ([fe80::2c19:641c:14b9:b1b4]) by BLAPR10MB5041.namprd10.prod.outlook.com
 ([fe80::2c19:641c:14b9:b1b4%4]) with mapi id 15.20.9343.009; Thu, 20 Nov 2025
 13:31:43 +0000
Message-ID: <53a08e47-a9bc-484e-b510-faa76541dbbc@oracle.com>
Date: Thu, 20 Nov 2025 08:31:40 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] amd_iommu: Use switch case to determine mmio register
 name
To: Sairaj Kodilkar <sarunkod@amd.com>, qemu-devel@nongnu.org,
 Vasant Hegde <vasant.hegde@amd.com>
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 mst@redhat.com, marcel.apfelbaum@gmail.com
References: <20251118082403.3455-1-sarunkod@amd.com>
 <20251118082403.3455-2-sarunkod@amd.com>
 <eaf49cf3-e56b-40f1-974d-207969c7371e@oracle.com>
 <c8e2ca43-c577-411a-a8de-176c5f85c15f@amd.com>
Content-Language: en-US
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
In-Reply-To: <c8e2ca43-c577-411a-a8de-176c5f85c15f@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH8P220CA0030.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:348::15) To BLAPR10MB5041.namprd10.prod.outlook.com
 (2603:10b6:208:30e::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5041:EE_|SJ0PR10MB7690:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e245aed-0be8-4aaa-a02c-08de28392527
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dlJ5OGRKMUtMNDczMmNmQ1hvUG5QTzBNaU9DZ2g2Y3RmemdjWkNaWXZOYkZW?=
 =?utf-8?B?M2Y5L2tmRTRSMnRKSXl5VWJoc0xwTHExT1VKOExqaG9QazlXNXJFQVJRTlRV?=
 =?utf-8?B?Y0ZOVGtKU3A1VlIrRC9KNlFUWWhUWXJnTEg4SDlSaG9WY2pCdzRxb3dkNXlC?=
 =?utf-8?B?NHNyaW5KWTJBYW5ZMTFWc083Q0wyQTFReGVUSVNYeGp1UmRsSElGOUVYbjF2?=
 =?utf-8?B?UG5RRGVCM3BmRzBUZE9PU1FHbmVGSUtiVFczRGhPQ3pzN1Bua1NGaDU0R0RG?=
 =?utf-8?B?VGdMbnc5NStUKzgzWUt1NVpnQmpJbXEwQUkvRjk2SHp3L2hnUiszNlBENzdi?=
 =?utf-8?B?UkJpMmJPYXpsNyt3VTJLeTdMVm10ZzJXSWlHVnZjb3NJZEU3RDQ5Q0dvTVpw?=
 =?utf-8?B?WnFKbmNyL3JCZHZWejJHVlZ1a3ROMGFkOGhhUmdPWkMwTno5eWlrTFgvYlgz?=
 =?utf-8?B?RzBlaDlCSHlpOER1ZGY1cHc5eHB6emFROVltWDFPYldSMnRrTHVZNldGZk5o?=
 =?utf-8?B?a2xaUEd5TVJEaFYxeVluNnJaY3lvNUZmVnpzMjBTRkd4bUI4anEybi8xTC9H?=
 =?utf-8?B?RVFraDRiajRNVlFxSGFvWit4a0JObkx6cUc2bHVES1g2LzhmWTlwbERyUVMr?=
 =?utf-8?B?d0VNbURTc2lHM0ZRWGRveTFmOGN1SkppMldkUWM1SzRVN0FBSElHTFZuNEI2?=
 =?utf-8?B?SUNpVEsxa0ZaM3JtbGdLMno5VEVOSC81TGhXUmtQUTJlTXZSY0pObytIR0VE?=
 =?utf-8?B?djJkR2Nhbk1wVGJCdk41dUp0SjlHcVhPeWpPM3Bja0J6S3BrS2t4cXBWL0Zs?=
 =?utf-8?B?UWhrbGVESm5IUEM3ZTlSRmFXVmtMRis0WDZXeVVRMVByOWtsalp1QTB0U3d3?=
 =?utf-8?B?MzQxNFEzMmVIdnNwT1hYRWh5bktpMkg4SzNDcXcwQUNTajdQeUtQbG1OcGVh?=
 =?utf-8?B?SnZrcWhQMnl5bE9RZ0FQS3MrdDlvM0ljdWhsanRHVDFCOElVaDhkbHJuQ3ZM?=
 =?utf-8?B?b1RSUUM5TXZKMzEvbkZIbTJFK1J3NzJhOVl0bUZJUldMVHVML1dTL1lTM0c2?=
 =?utf-8?B?OEYzT2R4YUhNWVZ5OUt1dWU1T0pJclRyRnBmdjJ1TGpDMFRQMERIaVAwUFl5?=
 =?utf-8?B?Sk5UVWtxNUVtZmFZNlprUGlqSXFKS3psRTBOZEVzTlIyTnhzMGJLMUgyL0VC?=
 =?utf-8?B?dTF5eVo5a3FwMHZJVXpCTU1RVk5qMTdaTDdJUGgvK1NGajA1L1Evc29ya05u?=
 =?utf-8?B?bEZsYWxsZ3Rhak41OHA2eUhRQkFxdW5ETW50VkR0MWY3bUp5a3JLZVNuZTJa?=
 =?utf-8?B?UmJReHBQcXg4TW9nYjZicjNyaFdlQUZXU1MrQlRPcEVuMFh5bkN0dUhpYlNx?=
 =?utf-8?B?S2dnMVdWaEZ0L3BUVC9kUFc0aW5hZVQ5bktGNURENmFCaldLMzlxYVV2am1p?=
 =?utf-8?B?UHV2L3I0NHNJY3M5WmgxYWlYckxoQnlIV2JMVi9FQkVkOFUySkVwS3B4UlFh?=
 =?utf-8?B?a2ttN2pCZlp0ajVURmlzTFRya0RHQkNWcmtYYlNpNmxkRWV0V1pUMGlHMHBF?=
 =?utf-8?B?Zk1pRDdhWUpkNFBheTlSc1RJbnB2SHhZMm0zMTIvTk5wYVkxbkl4RHhJdm9C?=
 =?utf-8?B?SGFXRFZhRjNwbDZKVlgwMlVnY3pFQkxGVjRHMHg4S2R5Mi9WZWVEWGsxTWdG?=
 =?utf-8?B?Rkl5YlcwMk5PS0JJd3dKT3oxSG5ocDIrMXpHU3lQaW9tcjVwdGF2L2FFY3pN?=
 =?utf-8?B?REhZUmlzSG1TOTRrMjJ2NGdEbDk5OGdDNGUwQ0FQU3pseEpYSHR1L3Z6Q2pE?=
 =?utf-8?B?Z080VkZXSTdGRld3d3hRQklUOHlPYU9MeGhWeXpnVS80YXJLMW9ZY2hPaHlV?=
 =?utf-8?B?WmtTbXFzcWw4K2dmUkZQQmpUblNpQ0RlOENweGRvc0QzQkE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB5041.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2IzblIvWVMrcEdBaXJmSi9RS0d3N1VCRXRPRDdMR0xyNHJVbnp6NkhqWU83?=
 =?utf-8?B?RjBTdzhkQ1hoSWRoVTBmZXBuMVJkV3kwNlhhUWdEZXhaSHBnZFRoZnVIT0kx?=
 =?utf-8?B?SGxNKzYvd1VNcEJOa0p4Nm1KT1ZYakhzTy9pSXpjamZvbTdldlhHMFM1TEdE?=
 =?utf-8?B?UVJMNklKeG1pVVV0YlV3WlBBTVA0OGl6ZVZCdC9uMXlXRnpaUk42R0kyc213?=
 =?utf-8?B?ZnlDZk9oUWdJc0l1WGpxWmNwZ2lrY3hkYkVnVEZpa0xyZDFmOXlsczcrK0ZM?=
 =?utf-8?B?alQwcjdxT09keG94SlFxNlZTM1hiRytDWTdNa0xmSWtLVjhhcHBxM3ljbjRU?=
 =?utf-8?B?aXQ4K3Mza3EybnpubnFNMXdIaUp6R1l3SUdManMvYU1mTEJ5OXBFR29oM2FY?=
 =?utf-8?B?S2Q0TDNuNTFydlhZVU4wQ05ocUo2eno4TEJYUzlPeFpZS1hSVlF0dGpabFBY?=
 =?utf-8?B?V3k5MU9POTVxZ3hPSzJmc3FwQW5KVWpCYW90cnFraUdINEVsMCtXV1plci84?=
 =?utf-8?B?emx4NjlncUtvQ0g0NFY5aE1IUWF4R0tDY2NpUVIwdmNwc25XRnBON1VnbjMx?=
 =?utf-8?B?a3kvbWJKWjBCSTQ4c0FCVGFTVHRUZitvNVdpZ3dHSDIxTzJHYU16YVJ4ZHVv?=
 =?utf-8?B?ZDhmdGZQSFlEVDd3UVF5WUtrZUFhSDVvVnVITFJwRmE5c2l6M29od1ZXcGdD?=
 =?utf-8?B?OG1VUjFlZk9BRTFsSXNEdXlYdkFEbkZVUmtKY0NTT05XTE91SG1kVkdKU2hC?=
 =?utf-8?B?SEs4L04wSnNOZnBwWURLdVhKVks1c2h4bmprRC9rUlZDQlBFUmpGczA2d090?=
 =?utf-8?B?d01wT3VCNE1aRHFCUDV5L2wrSmtMUm9oOWV3T1pLVUpnSk9wL00rL3JvT3N4?=
 =?utf-8?B?bGRXNHh3N045S25NTjFKQW5LSXltOGVMS0tqcnRmMDdSdE1iNW9OdUVsbCtO?=
 =?utf-8?B?V3NhQXF2UHRoVEVHS2ZiTXVFVytVSjBhei95S2l2QjJxQThDeEIvc2dMMlYv?=
 =?utf-8?B?a0RiYTJDUVViZXUwcGR0NGt3UTNYRTNYUGh1TVVkdGxXajdZVm1ud3RIMzda?=
 =?utf-8?B?dmkrcHRoMzBBc1JTQ0Z1NlBRWlE2UUYrcFlHZ01WUmhlL3paZGkzNUhRYzZN?=
 =?utf-8?B?bUNkdU9oeTI0c2hpejVROVl1LzBtQlRwK04wWTFBRTQ1ZTVOVUpBekd5bnV5?=
 =?utf-8?B?UHNIbGtqVkZLMGsrNktHRjBwRzlTQ2dnQmJPM2k1WnRHSWdDUzV5MGJYQ2tN?=
 =?utf-8?B?YkhxU0llUUVSZFZEKzBCczQzM0N6M2w3WUNJMnVkU1JsNHNpcFdsK2l6UEZH?=
 =?utf-8?B?ZmRGRStKVi9Ga1JUVDRSWEkxWlY3NEN0ZUI4Vy9BWSsxRVlnaGtLeFFZbHNO?=
 =?utf-8?B?Z1crQ1IvdTBOS2ZxWk9WWWh2bVdvVWprUGFqLzJCYUVpTktqMm9zajRwcUs1?=
 =?utf-8?B?MUszTnYxM214OFNHT080bkx4SVdON1E3dkFpVHhIaUhkZnU1YzZXQ01BZTBT?=
 =?utf-8?B?MDUydGI3bmV5UlQvNVBFL01RVzN4S1lodDZ1YkMwVmo5K2ZFMUdBQ3g0di9N?=
 =?utf-8?B?VWhrNFVnaXVxaWU5SGFxNjQxd01wZ3lZWTZLTnh0R2FhWDU3QWJYZVVxbm1J?=
 =?utf-8?B?dEhvU0hGTWovWVBOZHBnNE81SUoxeWs2S2UwR2lTV3ZWVTBDNjlrYzErYzJO?=
 =?utf-8?B?MzRVdzlFOWdMYUhPV1BVVjB4SXY5eVpIM3UyOU5EK0xQSjlFbTBKQWRZamlJ?=
 =?utf-8?B?SmZGdFNQU2ZRVC9LY0hLeG04MEdlN2VCY0kzOE1hbVQ5S2U3WEtFbmxIaHZB?=
 =?utf-8?B?Umh2NFFzWUU1NS9BMVp1bjlBM1IvQTNaeWNsb1VhY3luNmdSc280MzNxd0Ev?=
 =?utf-8?B?VCtQZlJTK0NEdVR5SmFkaDlZYVJlOXBRYXVpM2pLamp2aEVDOTB0NEowaGRN?=
 =?utf-8?B?bDJHdldjVERCKzZIU0NLVzlYYUJHMEV2OTVublo1WjN2OEJQZWtGcmRLVVpI?=
 =?utf-8?B?TDJUbkdOT09mbHp4VndmU3lFVUZvandNT1NjeFNodGdTWGozdUZYSmEwc1Ar?=
 =?utf-8?B?ZEN2d3djRlN3VDVVNEREUHVVZVY4bW0yWWVHNnRvdnpqYUI3cnRtR2xhZlRM?=
 =?utf-8?B?QnI1ZjRCaFFjUzVpbmZ4d1JpM294alAyUnJMbmxnd1NMWGFFQW4xVkxZaFlW?=
 =?utf-8?Q?6CYT7tBGY0LBmi013jQhPUk=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: uAz7s8Jr3t88C9L5fazd2k4L7uOOUYSXV4c6+J2IaSExNpKBVuDGOPHBr0tZEjlDQGoXI5LJr3E93uqXuO6j0wf9Zpm5zjjrSOI8BjGklvWuJ88uNat6hI9MIlkHFYuCqO3XTdZdreG/nfyccN7ijcHI3nNTZ3qU+ShgOXjPjntgjxnjYstch5gmBEohAd41VmdtHarRrZ3mGN6HfCByNT2Mhf0wbZcLBw7xb0VfGCS91h7k69IbPrkPYGNrOTmBsgKNu0/l7+0i8bjGT89wt9KOJo3PB9GsKWw2ZGEH6XQNQ2c66PSEXbsS5GFq5n3z9YCkdLmvAux/spIz3rRl+zx4c1Q50RbHi+g+AgQoYjkk8DqrJ82F/CTPSplbGHNoAcLoxb28usoR/Y0qRzHmpRWfGG8ay7h5R2K0VnQiJ7UkclrvsJYrd/ZygNC4BadMp0QJwySvTV91gJbOFQVEvbZMleyUXXz07C9tQzjjY/szRjUqglnjuuA1UsImMygRsAFD9A0az1NRY0Ea1i2k9SXJjgNardA57ef93lUt/15XVRlduqcYAcgr1kcFf/0CTmmcw0HYGMRoolW/z2FaM4exvimbRJiddok/FubGLIQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e245aed-0be8-4aaa-a02c-08de28392527
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5041.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 13:31:43.6362 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /UosdZdDywP7bu70gsOP5DkTaPOK4VnDVmB9EgB4eMDh+vfa29ovm3j6oCB9A+ZWUWrgY9no6yeZE/8TPjvOuXtK0i8m8AMJaBegaUNcWvg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB7690
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-20_05,2025-11-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511200086
X-Authority-Analysis: v=2.4 cv=OMAqHCaB c=1 sm=1 tr=0 ts=691f1845 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117
 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=NLiCwHATAAAA:8 a=zd2uoN0lAAAA:8 a=qLSr0MV3H11SCbdSKLsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=XHjirhgxjc0A:10 a=F9tHCgz3TLBaZgltkx5D:22
X-Proofpoint-ORIG-GUID: jVLrs0pmkPib2AUYFLgSf4D4LvmRY_kZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMSBTYWx0ZWRfXwhlvHHczuIsD
 o3OmtGM6RVTd4JRMT+Y/e+P9wxuc6NSifdA0Bf7jeXQOvjE7Ehe2OkerjSWQkBcSBAHh2TREuEF
 Wp0li55OtJ7Rs5wy2MpzXgbYVXXYwUGbwu6a4jVNtchAY/P8ZHtyqv0WqYRQnDNfwai21ujFGKm
 S4GUAW7dmISbRMDYzsFbfLNLuyVOICKHA6E87DoL9Mc1r6f8LoIUJVV2pfStb3SP7D2KSYsjRJo
 rdAoJldMVo6iwi5Dv3DxwN5MU06lBdy4dn4JHkx98IJhdM3QV1ZlHpmNtzRAiS+25bEXESTpuGT
 sNiqD6s04rx3O4emlmCcquGINtObL0JjwTXhW6dTVDrn0Ggy4pSMiqQi+gcqk0C2TSiGhrS4Khr
 L6we/0sbthCmL/0i/UmVlcTIxEur0A==
X-Proofpoint-GUID: jVLrs0pmkPib2AUYFLgSf4D4LvmRY_kZ
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0b-00069f02.pphosted.com
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



On 11/19/25 11:43 PM, Sairaj Kodilkar wrote:
> 
> 
> On 11/20/2025 7:06 AM, Alejandro Jimenez wrote:
>> Hi Sairaj,
>>
>> On 11/18/25 3:24 AM, Sairaj Kodilkar wrote:
>>> This makes it easier to add new MMIO registers for tracing and removes
>>> the unnecessary complexity introduced by amdvi_mmio_(low/high) array.
>>>
>>> Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
>>> ---
>>>   hw/i386/amd_iommu.c | 76 +++++++++++++++++++++++----------------------
>>>   1 file changed, 39 insertions(+), 37 deletions(-)
>>>
>>
>> [...]
>>
>>> +#define MMIO_REG_TO_STRING(mmio_reg, name) {\
>>> +    case mmio_reg: \
>>> +        name = #mmio_reg; \
>>> +        break; \
>>> +}
>>> +
>>> +#define MMIO_NAME_SIZE 50
>>>     struct AMDVIAddressSpace {
>>>       PCIBus *bus;                /* PCIBus (for bus 
>>> number)              */
>>> @@ -1484,31 +1469,48 @@ static void amdvi_cmdbuf_run(AMDVIState *s)
>>>       }
>>>   }
>>>   -static inline uint8_t amdvi_mmio_get_index(hwaddr addr)
>>> -{
>>> -    uint8_t index = (addr & ~0x2000) / 8;
>>> -
>>> -    if ((addr & 0x2000)) {
>>> -        /* high table */
>>> -        index = index >= AMDVI_MMIO_REGS_HIGH ? 
>>> AMDVI_MMIO_REGS_HIGH : index;
>>> -    } else {
>>> -        index = index >= AMDVI_MMIO_REGS_LOW ? AMDVI_MMIO_REGS_LOW : 
>>> index;
>>> +static inline void amdvi_mmio_get_name(hwaddr addr,
>>> +                                       char mmio_name[MMIO_NAME_SIZE])
>>> +{
>>> +    const char *name = NULL;
>>> +
>>> +    switch (addr) {
>>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_DEVICE_TABLE, name)
>>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_COMMAND_BASE, name)
>>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_EVENT_BASE, name)
>>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_CONTROL, name)
>>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_EXCL_BASE, name)
>>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_EXCL_LIMIT, name)
>>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_EXT_FEATURES, name)
>>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_COMMAND_HEAD, name)
>>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_COMMAND_TAIL, name)
>>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_EVENT_HEAD, name)
>>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_EVENT_TAIL, name)
>>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_STATUS, name)
>>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_PPR_BASE, name)
>>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_PPR_HEAD, name)
>>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_PPR_TAIL, name)
>>> +    default:
>>> +        name = "UNHANDLED";
>>>       }
>>>   -    return index;
>>> +    strncpy(mmio_name, name, MMIO_NAME_SIZE);
>>>   }
>>
>> While I don't believe there is a correctness issue, and it is a clever 
>> construct to reduce code repetition, I had some concerns with the 
>> implementation above, mostly on coding style and maintainability. I 
>> can go into each of the issues, but as I was trying to think of fixes 
>> it just became easier to write the code so...
>>
>> I think these changes preserve your original idea while fixing the 
>> problems and removing unnecessary code. Rather than diff from your 
>> patch, I'm sharing a diff for the full patch. I am still working 
>> through the other patches but the upcoming changes should fit in with 
>> no issues.
>> Let me know if you agree with the changes, or if there is something I 
>> missed.
>>
>> Alejandro
>>
>> ---
>> (compile tested only)
>>
>> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
>> index d689a06eca..6fd9e2670a 100644
>> --- a/hw/i386/amd_iommu.c
>> +++ b/hw/i386/amd_iommu.c
>> @@ -35,28 +35,7 @@
>>  #include "kvm/kvm_i386.h"
>>  #include "qemu/iova-tree.h"
>>
>> -/* used AMD-Vi MMIO registers */
>> -const char *amdvi_mmio_low[] = {
>> -    "AMDVI_MMIO_DEVTAB_BASE",
>> -    "AMDVI_MMIO_CMDBUF_BASE",
>> -    "AMDVI_MMIO_EVTLOG_BASE",
>> -    "AMDVI_MMIO_CONTROL",
>> -    "AMDVI_MMIO_EXCL_BASE",
>> -    "AMDVI_MMIO_EXCL_LIMIT",
>> -    "AMDVI_MMIO_EXT_FEATURES",
>> -    "AMDVI_MMIO_PPR_BASE",
>> -    "UNHANDLED"
>> -};
>> -const char *amdvi_mmio_high[] = {
>> -    "AMDVI_MMIO_COMMAND_HEAD",
>> -    "AMDVI_MMIO_COMMAND_TAIL",
>> -    "AMDVI_MMIO_EVTLOG_HEAD",
>> -    "AMDVI_MMIO_EVTLOG_TAIL",
>> -    "AMDVI_MMIO_STATUS",
>> -    "AMDVI_MMIO_PPR_HEAD",
>> -    "AMDVI_MMIO_PPR_TAIL",
>> -    "UNHANDLED"
>> -};
>> +#define MMIO_REG_TO_STRING(mmio_reg)   case mmio_reg: return #mmio_reg
>>
>>  struct AMDVIAddressSpace {
>>      PCIBus *bus;                /* PCIBus (for bus 
>> number)              */
>> @@ -1484,31 +1463,27 @@ static void amdvi_cmdbuf_run(AMDVIState *s)
>>      }
>>  }
>>
>> -static inline uint8_t amdvi_mmio_get_index(hwaddr addr)
>> -{
>> -    uint8_t index = (addr & ~0x2000) / 8;
>> -
>> -    if ((addr & 0x2000)) {
>> -        /* high table */
>> -        index = index >= AMDVI_MMIO_REGS_HIGH ? 
>> AMDVI_MMIO_REGS_HIGH : index;
>> -    } else {
>> -        index = index >= AMDVI_MMIO_REGS_LOW ? AMDVI_MMIO_REGS_LOW : 
>> index;
>> +static const char *amdvi_mmio_get_name(hwaddr addr)
>> +{
>> +    switch (addr) {
>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_DEVICE_TABLE);
>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_COMMAND_BASE);
>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_EVENT_BASE);
>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_CONTROL);
>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_EXCL_BASE);
>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_EXCL_LIMIT);
>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_EXT_FEATURES);
>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_COMMAND_HEAD);
>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_COMMAND_TAIL);
>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_EVENT_HEAD);
>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_EVENT_TAIL);
>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_STATUS);
>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_PPR_BASE);
>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_PPR_HEAD);
>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_PPR_TAIL);
>> +    default:
>> +        return "UNHANDLED";
>>      }
> 
> Hi Alejandro
> Although this approach looks good and faster (since you are
> returning a pointer without copy), it has a major flaw.
> You are returning a pointer to the "local string" 

Not quite. While you are right this could be issue in the initial 
version if you returned the local *name, it is not a problem above since 
the strings created using the macro stringification operator (#) are 
literal strings and not local i.e. they do not live in the stack frame 
that gets destroyed when the function returns. In all cases the returned 
pointer will point to a string literal that is available for the life of 
the program in the (ro)data section.
You can check it yourself by building the binary and looking at the data 
section with something like  objdump, but that would only show some 
fragments due to alignment of the output. After a bit of searching, it 
looks like readelf has an option that works best:

$ readelf -p .rodata build/qemu-system-x86_64 | grep AMDVI_MMIO
   [ a1c37]  AMDVI_MMIO_DEVICE_TABLE
   [ a1c4f]  AMDVI_MMIO_COMMAND_BASE
   [ a1c67]  AMDVI_MMIO_EVENT_BASE
   [ a1c7d]  AMDVI_MMIO_CONTROL
   [ a1c90]  AMDVI_MMIO_EXCL_BASE
   [ a1ca5]  AMDVI_MMIO_EXCL_LIMIT
   [ a1cbb]  AMDVI_MMIO_EXT_FEATURES
   [ a1cd3]  AMDVI_MMIO_COMMAND_HEAD
   [ a1ceb]  AMDVI_MMIO_COMMAND_TAIL
   [ a1d03]  AMDVI_MMIO_EVENT_HEAD
   [ a1d19]  AMDVI_MMIO_EVENT_TAIL
   [ a1d2f]  AMDVI_MMIO_STATUS
   [ a1d41]  AMDVI_MMIO_PPR_BASE
   [ a1d55]  AMDVI_MMIO_PPR_HEAD
   [ a1d69]  AMDVI_MMIO_PPR_TAIL


which can
> lead to all sorts of nasty issues. This is why I am copying
> the entire string to the destination.
> 
FYI, this copy is one of the reasons that made me look for an 
alternative implemention. Using strncpy is explicitly forbidden in the 
QEMU coding style:
https://qemu-project.gitlab.io/qemu/devel/style.html#string-manipulation
and while there are alternatives, in this case the copy is not really 
necessary.

Alejandro

> Thanks
> Sairaj
> 
>> -
>> -    return index;
>> -}
>> -
>> -static void amdvi_mmio_trace_read(hwaddr addr, unsigned size)
>> -{
>> -    uint8_t index = amdvi_mmio_get_index(addr);
>> -    trace_amdvi_mmio_read(amdvi_mmio_low[index], addr, size, addr & 
>> ~0x07);
>> -}
>> -
>> -static void amdvi_mmio_trace_write(hwaddr addr, unsigned size, 
>> uint64_t val)
>> -{
>> -    uint8_t index = amdvi_mmio_get_index(addr);
>> -    trace_amdvi_mmio_write(amdvi_mmio_low[index], addr, size, val,
>> -                           addr & ~0x07);
>>  }
>>
>>  static uint64_t amdvi_mmio_read(void *opaque, hwaddr addr, unsigned 
>> size)
>> @@ -1528,7 +1503,7 @@ static uint64_t amdvi_mmio_read(void *opaque, 
>> hwaddr addr, unsigned size)
>>      } else if (size == 8) {
>>          val = amdvi_readq(s, addr);
>>      }
>> -    amdvi_mmio_trace_read(addr, size);
>> +    trace_amdvi_mmio_read(amdvi_mmio_get_name(addr), addr, size, addr 
>> & ~0x07);
>>
>>      return val;
>>  }
>> @@ -1684,7 +1659,9 @@ static void amdvi_mmio_write(void *opaque, 
>> hwaddr addr, uint64_t val,
>>          return;
>>      }
>>
>> -    amdvi_mmio_trace_write(addr, size, val);
>> +    trace_amdvi_mmio_write(amdvi_mmio_get_name(addr), addr, size, val,
>> +                          addr & ~0x07);
>> +
>>      switch (addr & ~0x07) {
>>      case AMDVI_MMIO_CONTROL:
>>          amdvi_mmio_reg_write(s, size, val, addr);
>> diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
>> index 302ccca512..ca4ff9fffe 100644
>> --- a/hw/i386/amd_iommu.h
>> +++ b/hw/i386/amd_iommu.h
>> @@ -45,10 +45,6 @@
>>  #define AMDVI_CAPAB_FLAG_IOTLBSUP     (1 << 24)
>>  #define AMDVI_CAPAB_INIT_TYPE         (3 << 16)
>>
>> -/* No. of used MMIO registers */
>> -#define AMDVI_MMIO_REGS_HIGH  7
>> -#define AMDVI_MMIO_REGS_LOW   8
>> -
>>  /* MMIO registers */
>>  #define AMDVI_MMIO_DEVICE_TABLE       0x0000
>>  #define AMDVI_MMIO_COMMAND_BASE       0x0008
>>
> 
> 
> 


