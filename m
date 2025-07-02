Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCDC0C77B7C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 14:03:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWy3k-0006OW-O0; Wed, 02 Jul 2025 10:03:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uWy3i-0006M9-5I
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 10:03:34 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uWy3b-0005C7-6q
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 10:03:32 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 562Bidsc016652;
 Wed, 2 Jul 2025 14:03:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=ciKpU+dvwntVNCWEb5cpXmpkjn0IWyZJU0AnkVcwiw0=; b=
 bHtO2TIfmI0hhZz/7DUtst3EgK6aJXKF6TRZh6b97aW5LoeX8HYrQcaA/4c5Y4mR
 uftkUZF16Qq1u0U/trp9k1wIQBI5f7Ws9rYQsgayGHv2gFlaeCYo70X6B/chJuiY
 OtuTB8DRZxs6NMGfSfCdWXk8ee2WCjdFLGVgPPlKubGCH4qzCuJ0lNBEiy9OGz1f
 qzXirCbM8jztmOJF/fVsRVTkm7G3DaAndRQh2+gi+ng/hC9QK0cSF7FnBpEUcv6v
 6fvAdBSw5IOeiBOQlNYw5b1kUL/rpaTfsbXCIEfvQCn0NIHs69OPSUCkPFcfKqA3
 eWB1eZPj6h8//md5soo9lw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j704f1yn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 02 Jul 2025 14:03:19 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 562Ce8Sc027435; Wed, 2 Jul 2025 14:03:17 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2065.outbound.protection.outlook.com [40.107.96.65])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 47j6ub8970-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 02 Jul 2025 14:03:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ijarm+cdr18YS1ay+4AMehGjFqUZ+yS2ViLaFtZz1Ws+WO4v3E1JlZtsUyRWrqBk0mqauVfje1LS+UwOrfKhFG1hOdFMC80CLXZHozOrEhkXrO/HM/aUe4WBgp3Etc0/Lkdj07KAkXSlF6le7cHmEZlGGLKDExFwu9b2D7+X3HSRT5X7BBvH9S4xgWLkxYCyiaXDgW2mr695MK5WtWJhRQbwPpRP/9+AvNURjefz6ZROg6EglsWRdyvJMNdhbL0r/ALWFIYYedfBblD37TSHLwKVa0pR15t2scb6TdFp+8w8/6WpJWip791A5IZV/wJhpR0Yl72/pM6Hsq2Xe4dcWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ciKpU+dvwntVNCWEb5cpXmpkjn0IWyZJU0AnkVcwiw0=;
 b=TqtFYpRjaVc1fgnvIS5BFIs5JCEsd2WRmApF4FlMwUVZK14rT9yHj0vhtyBYm+MOdWOhaziHD+go23hg6TG0nQFpA23tSw2wEPiiJ7VADoIuXnzfOy3IEV2IBnEPmKPI9fy1qomBk6lDVXDXU5g5ox5Mjeh4UPym1NSQHwxBYdfgAlKqqYQVxJ+jpwn2SCXiUVoXl6nhRNPPYIbLB9dthfh4dBeXCwDBHm1tQFVwHMczX98kduNg/K0PdIgOgh8JEgOsD/u0TEX7qbfzF6nPnSj/JEOsHGvlvMnN9PsFVo7hFe/verNL00KpxhBOWqlicx3lX6kc+mazrfp900wvNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ciKpU+dvwntVNCWEb5cpXmpkjn0IWyZJU0AnkVcwiw0=;
 b=nYQKsHhPsNCZniOL5YlmslgtIRqZIa6YQavbIBzzEg/hDNuCgXz9LaKSAQ33GBJxtULelaPdad0Pjf4mM2vFzMrAf3Ovzn5aJW21dC/tNE3ncbN/x1z+movpGDS0QidiArJ8zTk0V9vAAqhyO5whWktCrH6F38Vy7cxahLsrKWc=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by CY5PR10MB6072.namprd10.prod.outlook.com (2603:10b6:930:38::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.19; Wed, 2 Jul
 2025 14:03:13 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8880.027; Wed, 2 Jul 2025
 14:03:13 +0000
Message-ID: <5606f042-c37a-4e7b-8cca-be2b1e9037ad@oracle.com>
Date: Wed, 2 Jul 2025 10:03:07 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 38/38] vfio: doc changes for cpr
To: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>, Zhenzhong Duan
 <zhenzhong.duan@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <1749569991-25171-1-git-send-email-steven.sistare@oracle.com>
 <1749569991-25171-39-git-send-email-steven.sistare@oracle.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <1749569991-25171-39-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH5P222CA0003.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:34b::17) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|CY5PR10MB6072:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d60a20f-1d2d-44a1-a7ba-08ddb9712f16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RGJvS1BDZVVCVDJ5bWNSR1lHdFpTMkJnVzZCaVRDVlBieGQ0cU9zMzl3czYv?=
 =?utf-8?B?cnEvMGJIaUdkV20xRkp2aTJ0Sll1VklRUjNCUHl6WlJYTlVDYTl1a3RmZDg0?=
 =?utf-8?B?czNOZUJRbVhNK0dWTzdDRlB0OFIzdTZZYlJXTlg4dTg0VTZjYWVPZ1NJZklM?=
 =?utf-8?B?V0ErY2JEUkF2MFpZN0gzWEJHMk9JTzhBR05VTlU4cWpxNmhRMXEzNm1RWnds?=
 =?utf-8?B?Q04xYlY4UFB0VkFzRU8yNUM4anY0YUVKZTlNenZIR3J5RFNnQ3M5WXBEUE9t?=
 =?utf-8?B?a1RnMG9JYTZXMEhzQUxYaFZsZGVZTFprczVzTmdZVHMyV3ZnbkRiKzVSVXZn?=
 =?utf-8?B?OVl4NjBiaTFRREIwNXRiTFlSUnFPZGFHbFpGOUluZmM5QTExQlc1VnI0M3hC?=
 =?utf-8?B?MDdqZmlJZnptMnM1cXIxeUUrVFJRUnBiK3RhNHFzV1VRQkJPeVJqVVhGa3Jx?=
 =?utf-8?B?YzR2NU5IRndMb3d1Zzh1clJyVVlzYTczc2tsZnRSemFQVU13MXdqUGwzZ0dG?=
 =?utf-8?B?dVoxd2Q2cW84QTMwdEVjd0U5UGxlMWVhSWtvUmFYcVE1bVl0STc0ZUwrRnZS?=
 =?utf-8?B?WFJoZTJDMnBLZ0FqNmdVem9wZk5wVHQ2Nm5ETW1iampiWUxoYnRmZjc0a0Uv?=
 =?utf-8?B?bUVaUWIvMnd4UkhWTlJkY1ZkZjRxK05QZTlMZ1J1aFVkbUcrSW0yd0NSQ1lX?=
 =?utf-8?B?enh6bUFWd2hnZXpkTGtMdUtPOUQ3OFRrNC9OVDhwK0ViUHpoZmE2Sy9JSHhs?=
 =?utf-8?B?czR5b0V6N2NDNy9BMnNtS2RRVStJRCsrKzRRQ3gxZDZBRWUvOCtLQmZhekZB?=
 =?utf-8?B?V0dZT2V0OFd4UkJ1UzVUd2wvcTF1SWpKYWYwNStJY2RVbkNXTUtGWTQzczkr?=
 =?utf-8?B?Q09wTTBRR2Q5cGRoTUd4MlZFRU1ObjZzN2pvalBZQmlFeUpCSHVJanlyL3lS?=
 =?utf-8?B?bTBVMEZVWkJUcStCM0w3RDl3VHYvRzlhVlFnbGR5WjBvUjVBRllseVU0WWZS?=
 =?utf-8?B?ZEFHWSthUkE1c05sL245NXFFSDlRL3ZPeWx4djhyN3lEbmhETWdyM2RhOUM1?=
 =?utf-8?B?ZlpTS2wwUFJxVzkrWFp3ZTdORW9ZUXN6eEoxdUJaUE94dXB0UDVWY25PNnRq?=
 =?utf-8?B?cHRKNVpXbmJnSlpnZndOT1QvN1VKUi8yY1F3ZUpLZFQvaXpwaXRKYk1RRzBV?=
 =?utf-8?B?RjFBMnkzRWJXQ3hsdXRYSURsZE44ZXFVaWxpM1RCUWJwcU9LWWd0a0VqZFpB?=
 =?utf-8?B?dHllcGhJNzBCQXkrd29RaHRnM2tMZEdESGZ5Q1FUeEFNWlh6WnI0djNIclR1?=
 =?utf-8?B?Vm5ZR3RQTmppTTRvcmhZWXBoOFUyRkxSSndRWXVkT05oR1RQVXF0Z3V4NzI2?=
 =?utf-8?B?TGdRMW5zaURRRDRhVEZrWXBUR3h1Z1FlNHhjSEY3STFHVzVsdVNORjVidFBv?=
 =?utf-8?B?MG00ZVBldDlHQkkyL1MxYnIyeEdwK1dKZ1VJcndxNGNYTEc2OElyeEZKV1N3?=
 =?utf-8?B?akR3cHlJQlhVdEp4ZnJyei9OeE1yUGpEYzZnTFZDWXNwTW9qZlc0NkQ5dmMw?=
 =?utf-8?B?YUJzQlBsRytlU2lyeWJGL1M1OENoVFdoNDZuN0Z1K1huSkt1UjBaVTFsTFB0?=
 =?utf-8?B?NmVwZ0hMaDRiUk5VQ3QzM2E1bzlKdzJyOGI0UUdGNHF6MXRTTDE2ZTZYSEZL?=
 =?utf-8?B?QmlrN1BZSnhzRzB1dElSQXJOZkZ6Mk5tUTBNakh1SVFDVWRMS3lQclFuUkhy?=
 =?utf-8?B?c1Q0MFFTdnJLMnA0dWdrOHdmT3g1MTUrNFRkSFpySnNHWFRRZHZxK2ZaRzM5?=
 =?utf-8?B?YVh1a1R1c2pMdjY1Q1lyZUNJN0lkdXFXa1JtVXVYVHUvU2t5c21WZzZrYStS?=
 =?utf-8?B?bXZKZEJBSEduQTYzZjJzWU11cm14bHd0dzlpaHNaWEZpZlBFdnhPeTlxNXpq?=
 =?utf-8?Q?lIhjLu9+j0g=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VlRoSG1uS2JTT2VseW44dHBjNlZ2dUhySXZ6WjNtK2FQT0ZPSGpyVE1pSy9y?=
 =?utf-8?B?YjFZNCttOE8xaGR4eEZCbElRT3BQL20zQ0hMaDQ4RS9vZWZSbWlHbEh6clJn?=
 =?utf-8?B?d0VoT0Rpcm5Pb24vMkpZR3QrUTRzVDVDQWVod1hkMEkyNVJMb3R0SlFvRmZT?=
 =?utf-8?B?cVkzcE5UeGx6NFlWNWxqUE5IZHNyYWs2MFZOenhkT0VyM083T1ZBZ2RLb3V1?=
 =?utf-8?B?RzhVWXFoTEQvTnc3VVFiMm5KblU2VXc2R1RZdnpiZ1hGK0J6UDJyViswS24z?=
 =?utf-8?B?dmg3S2JxWTJVUVR1NnJ4Zk1IWkt2dUFhdGZQZWt6TzNsbE1xVktUNURFV25T?=
 =?utf-8?B?aGRqb0ZKazlReUhCb3F2MEZMKzJQQks5ZjhTUFI4NWNTODd5NnI2WjlkM0Y1?=
 =?utf-8?B?bWxMZUNZeUZBaldRR2FBbS8zZk1XLzJPTEFmS0hGbU83RWZWRGNxZ3BiTDVQ?=
 =?utf-8?B?TTFIcm0rWmltZGl5MGNhQk92WDF6T3BoM2ZKOGhWaG9LTERXMExwTkVSbmhn?=
 =?utf-8?B?SjVVT1FyV2MyRXcxS1gvL0hCMThKVnpYZWFyU2pFcVlYYWlJZldqdTMrY3lU?=
 =?utf-8?B?QkYvVDVHR1BjcGMzUnh5VUNTeEg5MGlJbE1MMFlVSFBHVUhKbWhxWlVjTDh2?=
 =?utf-8?B?ekRobllUR2c3eTc4RlFWRmVFQTR1NGxBeDdTN3dmNEFNOVREM0ZveE8rdEhQ?=
 =?utf-8?B?NDF2d1lFZ24zSFJzQzlRMHIvV3ovcGRWVS83RXFEcnBxRXhjOHhTMXl2dWlQ?=
 =?utf-8?B?UWNSWU5VQUtvRVJYSlB3RGJRRk5RREowdzRjQ1BpVXd3MjZkWUZROU1zZVho?=
 =?utf-8?B?UHM1aVFjMnI1ZVBTRzJtWU56d0FHbjY0eHV3VDgyZTRVZ0FIVDNkSkNFVUxG?=
 =?utf-8?B?L1JoOWdvNW5UanRrdk1JREsxZFdmWXBLVzVTeGJ2QkRHNHNjZnFxQXFwbStW?=
 =?utf-8?B?andxQlEwWnN2SEdDZFZnOXpmT2I3RGFZUzl4dHF2Y0U5TDJKWHJKZ3pUcGxx?=
 =?utf-8?B?SlNaY3RPSUJXdnVGTjFnSVlYb3d6N2ltSXZTWXRUdHhMeEpWR1MyVlNmNW83?=
 =?utf-8?B?RkFsdWhvbElPYVkySWdsTnE4d2ZlcExXSkhrUGRNQjUyYThRTXlJdjN0TzI3?=
 =?utf-8?B?NUlnTC9Hemlpck52cDBIeFVTUERRMVdsa09NKzBPcVRPSHM5cnArSGRjYjBv?=
 =?utf-8?B?YUFYeUo3NnMraWg0eWdLUkZERXVrb0xrUDA1WHNQblBYMnhOMVZ5bmZiTzNx?=
 =?utf-8?B?QUtHQ0J5OVlMMG9GR2s4bnJZYUhJMEl4NWVXbFFSd0pqS1ljMC8zTll0elpT?=
 =?utf-8?B?dnEzeVBMR3d0UUx5Mi9tYm4yN3ViZW5ORWp3SUFha0N1cHRIMjlHSlBjVWov?=
 =?utf-8?B?NUt0QTZ6V0g0bk9MZFlReGZzZndiVm9OdWJ5dUhYejc3MGFNazhhZGR3Rmlq?=
 =?utf-8?B?aEt1eEhVVk9HL09zM3VjRnNDR29BMHpMMjlxTk0wR1p4eUhUbndvRWxmRWdM?=
 =?utf-8?B?ZlBtZk1oUHNwTXBKOG9PR0pVR3lkYUxYWE1lNzh3anhlWlJWUStmeGVXMTI5?=
 =?utf-8?B?OXY4WE1Lci8zTHVvV2ZWT2syVkt0bWx5LzR4K1ZrZHpwNW0zMVIwV0d6dDNy?=
 =?utf-8?B?Q0tCNGZEaVF3TVdBWEU3elJxVTNrWEY1Sm9xZWtVazhTZllwYzJ3OVRkNTVu?=
 =?utf-8?B?SGtOeHlGRCsxQUNmZSt3dUp5b2sxWnFxcStYVTJJeGN4UWtsSVBKa21jTWlZ?=
 =?utf-8?B?Wklwd0pmbmRmVFd0Tm1hRFdtVW05djEzY2F2ZnhoYjhia1kxNWVBdEpFOVVF?=
 =?utf-8?B?eTZmQzZjK3NXbTlVQlY2cVovNnlZYk9OdXUzZnRaanlmZkM4QncwYzU0MFB0?=
 =?utf-8?B?dDFCR2lKeVF1MEJKZ283RHVHdG1vMGlId3NOWW5tNmZhVUladGxmRFdhbmEz?=
 =?utf-8?B?Tk9xSEViRENFaW1nYVhGb25JdnNXSmVZcFJ5Y01XTlExK2E5cWlkMXdZUGFP?=
 =?utf-8?B?TzlDZUhkNTJzd0Iyb0pJSks3c2lVUlJOS20xVVBTMVd0eldLQ0tzcUtCQ0N0?=
 =?utf-8?B?a0V6UnpnUEQxakx5QURhcWNQK2M1bUc0dmZpaUFmMnR5dnVsTVU5YUVPYTFz?=
 =?utf-8?B?UnlpQmZ4eThoVk5ZeXJjTkk4TDN1Y08zYnBwOTAxZVdaQ050L0FSZjBZODBV?=
 =?utf-8?B?WUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 4waVcme9vw6V+idd7dYJJhEzeq9DFtL222CuR7FTKIrNguccCWWfYE1L1r0zhn0oEmronpSb2X9ue/R2FHMNkCyVVpjmhMgNTT441eEFPb5xqLpOMxvxB1An21ab1/LgPxpghYywn+eJXBPe5iHrHjk92PPNXj5l572QAskYBTDca0E+PqV70XcbLpfJZdaqh1wKblNe1xPVFJkUvi4MgQgWyqTqYxm+K5jpwGDBTHQSQ060aLCXP1j14H6j45ZxvgVsl9effzuNxWJtwxi6tHQ+NDEAJ/C8NymtluWK+y230sAyf6+KvNobBXwAJ65Vk2IwhYawMEZwuS8z1GkbOZETLb6n+9v0AEEiBXDC3xYgqXzndXoVqVE/4cUzz8fXWIvO1chLq4FVgKVEny8+5cxv/qysDEkPybk0qdc4veheBqUUKJJkC+jLOUY1PRb6LZ7RoYmu028/CbUBrwjnCdU6EfuMEV3e0uPoo2NFwo4wa2d2jV1stMHrIWlabMtuQ0vqJSoxFkJv/B4STiG/IvjTUWvy9IWDtQDCMkM7dTtmtaX3vLvnESWEZce4jFHygeMV1r3FEw7ehtjF8ra45Lre1sXlXBzlmaZZs4QBLI8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d60a20f-1d2d-44a1-a7ba-08ddb9712f16
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 14:03:13.2353 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bkvwo4k/tCrhBr8UdHMt/2IX/+uEZI1usLYaJuKoa6CWGI7J2d/IXZRSdWJBeviXxFmX7WeI8UYYD4UvtiR4x2uSR56VICglV0MdNfJOr8I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6072
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-02_01,2025-07-02_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507020114
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAyMDExNSBTYWx0ZWRfX/7R9iwJBOByq
 pjG8AjugGBPUMvqBvnnlxRVyGFAE7laQ+kLUiW00/1AZw2hzGIParVae/NeVT+P4qpuVcC/8qeR
 L76kK23j6ejZow/8eLc7ko1pp1bkEFKgBXaG3Y0Si1XrxYI6hI6LlVjAC/v1bq4I4K25pnBpQE6
 NdxoNI9aWQESMO8Q45Us6FS8rhy4H4xkeQVhiJC7IeIP+TZq6Tabjxu1hEwxyCXWc0n/qj9qQlY
 C9vgZZv+LZsCa/bUZs492D0Ey5EWrSvChBDE5CF1MCBxhY7CRHdIBbjl5svqVeMG1YOEvKHjDWd
 isZHnOsuYz8z+jz1kutt8vzg/aIk2utEo8LzsqciTeFLlAHc4bxJ6eYjPIKEow5+o27C+0N/bbq
 A1QowXy8VMHuLFjRa+cnjyziPvr1+SOp71RHwRAtpY84GK9YMrtdU5guiA/njjtZIPR4Qgpd
X-Authority-Analysis: v=2.4 cv=LcU86ifi c=1 sm=1 tr=0 ts=68653c27 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=s6kCuQCJNGuFKrxp_bcA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: imxp7GhdGwG3iu-cMmdK9BYUgS7PwDr9
X-Proofpoint-ORIG-GUID: imxp7GhdGwG3iu-cMmdK9BYUgS7PwDr9
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Peter or Fabiano, this patch needs review.  It's trivial.

- Steve

On 6/10/2025 11:39 AM, Steve Sistare wrote:
> Update documentation to say that cpr-transfer supports vfio and iommufd.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>   docs/devel/migration/CPR.rst | 5 ++---
>   qapi/migration.json          | 6 ++++--
>   2 files changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/docs/devel/migration/CPR.rst b/docs/devel/migration/CPR.rst
> index 7897873..0a0fd4f 100644
> --- a/docs/devel/migration/CPR.rst
> +++ b/docs/devel/migration/CPR.rst
> @@ -152,8 +152,7 @@ cpr-transfer mode
>   This mode allows the user to transfer a guest to a new QEMU instance
>   on the same host with minimal guest pause time, by preserving guest
>   RAM in place, albeit with new virtual addresses in new QEMU.  Devices
> -and their pinned memory pages will also be preserved in a future QEMU
> -release.
> +and their pinned memory pages are also preserved for VFIO and IOMMUFD.
>   
>   The user starts new QEMU on the same host as old QEMU, with command-
>   line arguments to create the same machine, plus the ``-incoming``
> @@ -322,6 +321,6 @@ Futures
>   
>   cpr-transfer mode is based on a capability to transfer open file
>   descriptors from old to new QEMU.  In the future, descriptors for
> -vfio, iommufd, vhost, and char devices could be transferred,
> +vhost, and char devices could be transferred,
>   preserving those devices and their kernel state without interruption,
>   even if they do not explicitly support live migration.
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 4963f6c..e8a7d3b 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -620,8 +620,10 @@
>   #
>   # @cpr-transfer: This mode allows the user to transfer a guest to a
>   #     new QEMU instance on the same host with minimal guest pause
> -#     time by preserving guest RAM in place.  Devices and their pinned
> -#     pages will also be preserved in a future QEMU release.
> +#     time by preserving guest RAM in place.
> +#
> +#     Devices and their pinned pages are also preserved for VFIO and
> +#     IOMMUFD. (since 10.1)
>   #
>   #     The user starts new QEMU on the same host as old QEMU, with
>   #     command-line arguments to create the same machine, plus the


