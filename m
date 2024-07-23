Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ED24C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 08:42:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWB6Q-0007rs-HU; Tue, 23 Jul 2024 04:42:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sWB6O-0007kB-Op
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 04:42:32 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sWB6M-00043w-7h
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 04:42:32 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46N6BWJ4031787;
 Tue, 23 Jul 2024 08:42:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=0O7sq+zYj9iZ6yEf1NO09LTljyjKP9Q4zMHhG7eb1Ok=; b=
 AHEuvzaYU3GTiPQJwaVDdO6hLMnGAR8++P2ODtiRlPexEiE+Xh25VtQty0cAwafx
 YDMmjDYZ8AfXIV45roc4kMztdZlfKql5L4MJDA96PYe5vPhdWTq8Npl06fG2UYzn
 rjNgdBdmqbndv6i66c2AdP8YhD77Jv26faaMhMaADqN9EzE7R5nxHTlZCEuDQBfs
 VNoLswEIQzO6/KeDvCvwijZlTmzW0ddNot+uUsJSR2U32hpsLOtWajh0dkIp4bIl
 MRZbdPDzlQtHN457KdDCkEtv8xVZGaTQA4pdYlEn2GR4M2LACA8rvZEYTyfZC6jZ
 53MTALD7R51nJrezJAft7A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40hg10wj3n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Jul 2024 08:42:27 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 46N6fXsB033649; Tue, 23 Jul 2024 08:42:26 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 40h2693pnp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Jul 2024 08:42:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MalVrOpyqrAnCQNtN7DscQiQXwWhoEo2M0PxZI8ycvSIzsXNiHi2lBiOpDmPA8L5Ur7NyuvTYF23oLFRS2qDR4kPwyfHXggsqd2Ok/43/T5AEHEeaxSBNEi1MzmbNe8MHYric5wIgzdUcyTdGKG++sJmUnMBgm3hCU5hQQUpfNY0Z+PA7IAvRTtCEGqbaw+0rQ9NXS3k4XoOUamui67Kng/+k/flIxK9Lr1M/12FQ25OugxQXegZO6i060T9ReMvInH8C61BGS/Stid9Li36kL/VZvsZoC8Fcv522Bflr+VqTG7ReLKTmXm6PUhxPzxmDWq4rocFiCvkVjP28w82jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0O7sq+zYj9iZ6yEf1NO09LTljyjKP9Q4zMHhG7eb1Ok=;
 b=G5YY7ub4PuTd9wTtsALrtQTyFBtkTap/IRidOelZnV30UkRxYOwnx9KYFWEdMto8lPFNP6Dd3uP5cMpbGhiv4jzMYmYMxb5n3Xm4EHHEAxVSMh3w7HOj9Iz96MoKzZcfhDcJ3FNZOO2BQLF3Edt0xSymiiUunSQ6DI64fVmW/IazHbC2HSbdc/XQwkqd6SkZWgP9fnXJ6Rk0+a2YdCNOJ3Ipd9mmYE7UHEEg3vQHBHGlWOghIrja+dMPOWzhkoIcp9GXHn8RQ1WR1gXTAw2Fs7rTliYPL458gMYlwZr93LGYYAo0c9LnPeUzFlAyJcP8nerZoSEDHfeLZ2Mdoxak+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0O7sq+zYj9iZ6yEf1NO09LTljyjKP9Q4zMHhG7eb1Ok=;
 b=OQUmexAnvDh/8pUcgaWzcoZPKKGh27pAvjl/8zev6kZcb2lUdIrt9gdl3ZxbnqKF6MGaHPj79jnXgdwkZz3VxAfF+0yrCCju3kqUySa69Eo6jfc7N/wu7+p8HmIVwLywESbAQj/mxuVSieyqkWOicVGsehJjqABj970gsBa5lHU=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by DM4PR10MB6694.namprd10.prod.outlook.com (2603:10b6:8:112::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.18; Tue, 23 Jul
 2024 08:42:24 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%3]) with mapi id 15.20.7762.025; Tue, 23 Jul 2024
 08:42:23 +0000
Message-ID: <e24b17fe-d1c1-44a2-b6b0-64e7ddccb9b9@oracle.com>
Date: Tue, 23 Jul 2024 09:42:13 +0100
Subject: Re: [PATCH v6 9/9] vfio/common: Allow disabling device dirty page
 tracking
To: eric.auger@redhat.com, qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Avihai Horon <avihaih@nvidia.com>
References: <20240722211326.70162-1-joao.m.martins@oracle.com>
 <20240722211326.70162-10-joao.m.martins@oracle.com>
 <787e5d32-652c-4663-8a03-ce9b6f1a66ce@redhat.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <787e5d32-652c-4663-8a03-ce9b6f1a66ce@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0666.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:316::17) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|DM4PR10MB6694:EE_
X-MS-Office365-Filtering-Correlation-Id: 12a30a94-ab6d-4d8e-329d-08dcaaf35f93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bUhtOEgxdFlXd0llbElRajJ4L0Q3VkpjaVIwWk1UdnVacnNSZFYwaC94eFdM?=
 =?utf-8?B?MFFPeEtmYjRoR1BGTzJLOTZwVlZJbVZQNDN0QXVPRWlkL01DaGhlWTR5ZmVq?=
 =?utf-8?B?cHFRUmhGTi92QTkrVkc5a0Y5WTk0ZmdGYkdZVkZqZ2RGcXNIUXd4Q0VYV0ha?=
 =?utf-8?B?MmtYbmI2L1BEV1J4dzBVbmkweWNjZHlnYjFNcW95cWYxeGd2TGwxK3Vxcitl?=
 =?utf-8?B?YStWc0dRTXhGc1hvYjJtU2wzL0FtTWx4aTBCMzBIY3hlZmYwMnJrNjhZaDRr?=
 =?utf-8?B?eXJJZ08ySDhGMEMvRmVTVHlkRk5CZVNHMlhobWxHYXVySHJCVTI4VW9OR1R3?=
 =?utf-8?B?UWVtS2tzYklZazRnK2laeWxzVUVhajRrV2wxN1VFaTNBZ1o1WDJFQXp1VzZT?=
 =?utf-8?B?cHFKa2VZSDNBRFZnT1U3YmxSbzl6WUl1OWdHWVNSZFRUTkRtQkt4ME1JWXZ6?=
 =?utf-8?B?eStRWHlkVDRmZDVWNklSckxIbHBJVDFWV1V5WkhqN25IVEcwdFBoejEzVzd5?=
 =?utf-8?B?bjJsRVdicG5aMFBKM1ljcUhQa0JseHpjZkNkcDRmQ1NnK0p5REYzak5mYWU5?=
 =?utf-8?B?RllTc0xMd0xsRFN4SXdWQytFRTh5VHUwU1hlblRWYm0yVHhPcWs0T0hLeEtX?=
 =?utf-8?B?TjRlVWh3OGhMT0g0MjczL2lVdVQvOFBMWkFDVUR5a2prZDhTdVdGbjk4WWZB?=
 =?utf-8?B?UDZHZHRhMGdrR1JJWXJBZ1AxR21GSVRDQ3ZxbUlqVEJ3MVNpdnIxcFE3QXEr?=
 =?utf-8?B?dDRhRGNyTkFrNVBOWTBuVkVvRW1oRVJJRGFXTzE4ZFdxdmZaNUZ3anpOZ29Y?=
 =?utf-8?B?ME13MXN1TlAwYVI1MkozckFIV1ZnQkVJdlFpcUttWFlRZ1VMTXlzUURlYXZa?=
 =?utf-8?B?dVo4VkN2QXFML0ZjUzZrcFRRVzBvYTl0UVB5VkdJTlQ1MVJnUVFld2JSQXcy?=
 =?utf-8?B?ZHB4MDBtb2F0eUlwaWUxTVk2VUdRNXZobU9sMmh2a3pXa2Fod0NkMUhHTzlM?=
 =?utf-8?B?ZzhJWHpZRFVRdUk4L1l1WkFGOVZUZVJUSnZFekc3UEJEUWp6Z2FhWmZ3QXBX?=
 =?utf-8?B?dnovN0h4blBVL2lWL0ZYZ0F2dmQzb29Sbk5oVmtmYWxnRERHWE5LODI5ckE4?=
 =?utf-8?B?VENoL1VyQnRKdXJWSWdyQ2owSkpKWGF0Tm5qTjIyTTlrbVVLWUdtdTYzTnJ0?=
 =?utf-8?B?blZhNk9KcnhZM0VFSXpTeVJ1QjM4UXpiRjZBU0Y5a0FudXlmVk43R0tZU3JL?=
 =?utf-8?B?WmRTdEVGYnFYNUpGejh2U1BBMUVteDhyM29oc1Vtb2dTUFBHOFByWkoxckxJ?=
 =?utf-8?B?VmsxWFdqSXVjMXV5b1VyRFRRZzhEZWFJRjg5Mmp3NUFXa2I4TksyTGxCODNT?=
 =?utf-8?B?OWk2S2RXcUtXVisxZHBUK3dNT3NyWmxTSWkyN0Z2KzhmT05PdVk5Z0JybnRk?=
 =?utf-8?B?ckM3YU1SemJ1WXBXQzVSUFI2dEMrVlZuVkZXU2Jid3I5MkRHRHJzMmN4ajJk?=
 =?utf-8?B?SFN1TVU2ay9mODdIQzRQMGk1K2VLcUVDVHN6NTU0K1lmUGQyZXVMT0tIelhk?=
 =?utf-8?B?RmtrQzZxVk1zN2xFTmYwV3EzR0ZTdlRvLzlEMHdqREVGMzVjZmh2M3g0cE5q?=
 =?utf-8?B?eVQyMGJuRGhJdmU2SjRPdDJocmt2R0JNZ2tUMzg3dW4rZEdqMGV4bUpPZ0Zt?=
 =?utf-8?B?TWhDVGg4TTBBeDFVbmFiRzdrYWJ0SVQybkxkR01WQ1l2ZVcydzFFaFJxZ0xt?=
 =?utf-8?B?bDY1cDBGOVFQaDZOZlVKaVd4bnlUbXQvaDZPQWNxa1hYeDE4MTVVZ0xXMHkv?=
 =?utf-8?B?MXQrK1FXRjFCcFdtZUJUQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eVN2U2pYT3UvdGNGS0VHQVJieW9GakgyZmFQZkdJSE5xNmpUeXdFN2VKSDBB?=
 =?utf-8?B?TTBmT2lVWXg4ekRyRVdNV0tzTkEzOEJjMFNCSEJCL1lXRmNxSGhsUi8zdWJK?=
 =?utf-8?B?R2pFZURXZFdWQnp0bHdsTW1TeGVjb0RUK0VXWHRsejE3anRKSnJ0aExYRzFu?=
 =?utf-8?B?aVpVaU9XUmxHNG5NWmZDYnF4QmQ0SmZmc3Mwak9MM0pZOHBNTzhzOTMxTWIx?=
 =?utf-8?B?N2p5aVVMRXNENjNoU1VaMGNUNzNhbFVkSEVlTGh2MVk1Y1FqeTdWSzFlbkFz?=
 =?utf-8?B?L2ZkbS91UVZmemRidTlZOUlORHJLVEpXNGF1ejJHMXhpRW00VEY3THVlSzM2?=
 =?utf-8?B?RlQ1MzZKSm96ZFV2c3RVcXRXd0V1dk1Bd3pCQWw5cjRvRlBjUGx6YXBWQlhh?=
 =?utf-8?B?SUdjMDhrSDhsNU1YcU41NUtjeCtZaEdTdkdsM2hnZm5pcHFiVXdKZGRNcGZU?=
 =?utf-8?B?T3k1VzJ5d2dteCthTmhsZmZRSi9ET1c1cmhFaWFKMlQ0dEsrd1poM3cwQ1V2?=
 =?utf-8?B?eVdYb25MeE5CdVNDdUVVejZ4Mk11T0tlbnhXdFpTZ01nR1V2ZXFrWG1CWHNr?=
 =?utf-8?B?Y2ROaC91bXlUcWZ5TnR4T0pvZGtxYUtYdnZ1N1FXOHhKNVVwNjRIc0tkSkd1?=
 =?utf-8?B?eFYzSzExYmp3cDBTSVM0K2RqaVNhLzJJMi9JbnBmOUcvSGxIVFk4Y1E1NXFL?=
 =?utf-8?B?Mys4SE5QNHlUVGJKdGZwWUNKOGQwT1FERGZtUmtBMmEvWjBXNTUvV056QkNq?=
 =?utf-8?B?akhaSnlVQ1hsaWpIeFNOUXZwVHhaWFQ5eEtBLzNDa1NDNVNZR2RNbnZ3MEV2?=
 =?utf-8?B?c2ZSb01WYllMV3BmQjlJZy90VGRmMXRuNk1va1p0bytsbkRlWmRNaVVaYlFT?=
 =?utf-8?B?MEN6TmRjY25XZFprSVl0ZjdvQ1ZKQ2tCbFl5aVAvUm83SjZVbVJVYlRsdlFX?=
 =?utf-8?B?VlZ0U09aUzlPeFcrcWhxcWdvR1phWnN3VUIzaFliYTNTdVVjZXdDaXZIVlJo?=
 =?utf-8?B?VTFEK0dZbFgrb3ZhQ09tN01LUmhMTXhqanZOelRYYnh1VTA2anVsek4xblpS?=
 =?utf-8?B?MFNJeWxySU1YSnhISHRDTzVoZHNmbTRFZzRPdTNqTS9icmlDSFdRQXNTU0tN?=
 =?utf-8?B?aXNZdHFPN28vWnYzTW5iR0lNK1NONHZjcWp3dlJNNWp1NXlWSURjUzFENkk1?=
 =?utf-8?B?dnlDNDRDY0t1b01wd3NKU253eGFEVVR2d04zdzB2Q2dwZi9PRHJJdEdZSlZp?=
 =?utf-8?B?MXVxaERiUWJRaEF6cHdWdFk3MXY3U2tBYTZ2YVhNY0dDd0w1dnh6d2VDbXZo?=
 =?utf-8?B?Y0l0b24zbVk3YTlQUWRiR1FZU2c1b0tHSjVNc2FaOFpqR0FBUGlxM0R2VkNC?=
 =?utf-8?B?VWY5enpCNHd1N1FGK3dSMTQ0dmNmb2JQTWhIVVNLSzF1MTJXUGcxamcxNm9F?=
 =?utf-8?B?b0hkNStyMjlwRWlIc2tqSXl4ZHRHUTdTUGtlUHJuOVo0cnI5Q1BTMUU5elIz?=
 =?utf-8?B?K2JzOU51SStBblRqVWE3UE9kcXpyWmswa1JTTXJ5eHhodkk2anBTSjlNbW5t?=
 =?utf-8?B?V1FVL1ZhKzF5TFBoVmVJYWJ1Uk1ZWmU5M2J5dVkxaXBiTGsxYmFxU2R3Z1c1?=
 =?utf-8?B?RW9NRHA4WDhldTlOSWFCSU55YTR4aWp2TjlFY0VJSXlBV3ZJUVd4SWVSVGdq?=
 =?utf-8?B?aWs1cDVaYjVCQUV2ZmxYbER4RG8wVk0wcFVEYzU1eUk4c1BBb3F4VlBIUXha?=
 =?utf-8?B?Q1ArazhrTkU5MCtRcGtwUWxMSHdiOUtUdU54bExERDVCajB1ZFdQcHR4ZEIy?=
 =?utf-8?B?Uk5YNmoxWUNoQXRsVGxwL0owK3ovVHg2aHg1dytnTUEyUElCbFpTcU16RzNZ?=
 =?utf-8?B?eVh0OTB5NUZ1aVdjWnFIdmdHUW0zbWxYL3JjVWF4akVvT3dmQjE4cGEva2ZQ?=
 =?utf-8?B?Z3U4cFFLUVc0bXJhQWY5V04xS2VQN2NxS3RGRk5EOW1sT1hWbmdBL3BoSi9w?=
 =?utf-8?B?M082dUJvdHlRMXZEN0VwVnh3cm10VU1HbGI4K1ErOEFQbXpBNXB6MGUzcE5i?=
 =?utf-8?B?amM0aE9xYkNLam84VlZJUDFJWVJMMCtibU1CazQ3QjlXQk0yVmRpenVna05V?=
 =?utf-8?B?WWdOdWxnZzdtOWxXTUxHTWNoa1d1a1U4RDdTZ2d0NDhtU2krTm9RT0FMMFM3?=
 =?utf-8?B?NlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: BBpr3m3BSXJRJzc56uHN0tHQKv+LmCfZZqrID/na4QEQVkha1aW1uZlDRzwEBl2Dkvaxb0ZWjWjcMxr8/28FtuXHW6NI8LdzSCKwZ25a2g6/Le5jv2OUytJmbaIYx9L1ULQpCkFuFgY+3EhG0jcX7/iZX4z/b2qUXsvlfS9gG8ErGzGiCCi5pNk9P3XYFn8X335RUlk/cR37KF6fa1SbrPM7VNAc+j3eR4k23NYdyRhygyeUWrJFeRZNJS3Tz7LMfZNkq+p+GFjdSvCmH1u/+NlUWvK6yPQEVYRzzVXT0IE5kw6pim4ZOQhsl/NJpHPyJz0kuTptbOBmEsh/BuOvOzSyybLWL23V2cQ17Z79HO4yzWeHh/Z0uKteQEydiPgMBmJ8VPWsbDhixod3K5KlKRHb+vdCWDfEeCkQHqNRwh1pwIWwWi++oaS2L/pG3pic9adi0DYFqcDlF7UdrrjG6Vi55FifgWgp71rSq6W5xDctf4XywMa93TJ6k2uGjzYJux10RrmA21VIVebpBACoiWuCP1lkjzD/DG+O15skLuyYoW7MNOib+yRqPY5W55yWI0tppUdCysGLAyaB+5Yw5b9+PWw/FE8WieoEYr+xObY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12a30a94-ab6d-4d8e-329d-08dcaaf35f93
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2024 08:42:23.9240 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6iyIuURbbiCQr5zMhGFl5TFhJZ7A/9BazvxQbpx5jKoBMtyLNCYmpwLTlYsxCthXyb9IwNT++++cWh1OHCtqMwTPtm4VZE1825p1dk39WfA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6694
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-22_18,2024-07-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxscore=0 suspectscore=0
 spamscore=0 bulkscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407230063
X-Proofpoint-ORIG-GUID: FsBPDLt4OkmUmpfD4yMUC2unuYA7Q52P
X-Proofpoint-GUID: FsBPDLt4OkmUmpfD4yMUC2unuYA7Q52P
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 23/07/2024 09:31, Eric Auger wrote:
> 
> 
> On 7/22/24 23:13, Joao Martins wrote:
>> The property 'x-pre-copy-dirty-page-tracking' allows disabling the whole
>> tracking of VF pre-copy phase of dirty page tracking, though it means
>> that it will only be used at the start of the switchover phase.
>>
>> Add an option that disables the VF dirty page tracking, and fall
>> back into container-based dirty page tracking. This also allows to
>> use IOMMU dirty tracking even on VFs with their own dirty
>> tracker scheme.
> 
> Forced ON value isn't really meaningful though. I mean only valid values
> are AUTO and OFF, correct?
> 

It's more like 'on' if supported.

You could argue that AUTO_AUTO is the right value considering that device may or
may not support. But really both AUTO/ON are the same as the property that
outlines device dirty tracking is ::dirty_tracking for the VF which is
eventually seeded from VFIO pci feature. So this is mostly to override the
default and hence AUTO_OFF is the only thing that it's tested against in the
various places.

Me picking AUTO_ON just mirrored how it's already done for
x-pre-copy-dirty-page-tracking (and I see used e.g. kernel_irqchip and others)

> Eric
>>
>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>> ---
>>  include/hw/vfio/vfio-common.h | 1 +
>>  hw/vfio/common.c              | 3 +++
>>  hw/vfio/migration.c           | 4 +++-
>>  hw/vfio/pci.c                 | 3 +++
>>  4 files changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
>> index 1e02c98b09ba..fed499b199f0 100644
>> --- a/include/hw/vfio/vfio-common.h
>> +++ b/include/hw/vfio/vfio-common.h
>> @@ -138,6 +138,7 @@ typedef struct VFIODevice {
>>      VFIOMigration *migration;
>>      Error *migration_blocker;
>>      OnOffAuto pre_copy_dirty_page_tracking;
>> +    OnOffAuto device_dirty_page_tracking;
>>      bool dirty_pages_supported;
>>      bool dirty_tracking;
>>      bool iommu_dirty_tracking;
>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>> index da12cbd56408..36d0cf6585b2 100644
>> --- a/hw/vfio/common.c
>> +++ b/hw/vfio/common.c
>> @@ -199,6 +199,9 @@ bool vfio_devices_all_device_dirty_tracking(const VFIOContainerBase *bcontainer)
>>      VFIODevice *vbasedev;
>>  
>>      QLIST_FOREACH(vbasedev, &bcontainer->device_list, container_next) {
>> +        if (vbasedev->device_dirty_page_tracking == ON_OFF_AUTO_OFF) {
>> +            return false;
>> +        }
>>          if (!vbasedev->dirty_pages_supported) {
>>              return false;
>>          }
>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>> index cbfaef7afffe..262d42a46e58 100644
>> --- a/hw/vfio/migration.c
>> +++ b/hw/vfio/migration.c
>> @@ -1036,7 +1036,9 @@ bool vfio_migration_realize(VFIODevice *vbasedev, Error **errp)
>>          return !vfio_block_migration(vbasedev, err, errp);
>>      }
>>  
>> -    if (!vbasedev->dirty_pages_supported && !vbasedev->iommu_dirty_tracking) {
>> +    if ((!vbasedev->dirty_pages_supported ||
>> +         vbasedev->device_dirty_page_tracking == ON_OFF_AUTO_OFF) &&
>> +        !vbasedev->iommu_dirty_tracking) {
>>          if (vbasedev->enable_migration == ON_OFF_AUTO_AUTO) {
>>              error_setg(&err,
>>                         "%s: VFIO device doesn't support device and "
>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>> index 8c0f212a163e..a0767de54b8d 100644
>> --- a/hw/vfio/pci.c
>> +++ b/hw/vfio/pci.c
>> @@ -3364,6 +3364,9 @@ static Property vfio_pci_dev_properties[] = {
>>      DEFINE_PROP_ON_OFF_AUTO("x-pre-copy-dirty-page-tracking", VFIOPCIDevice,
>>                              vbasedev.pre_copy_dirty_page_tracking,
>>                              ON_OFF_AUTO_ON),
>> +    DEFINE_PROP_ON_OFF_AUTO("x-device-dirty-page-tracking", VFIOPCIDevice,
>> +                            vbasedev.device_dirty_page_tracking,
>> +                            ON_OFF_AUTO_ON),
>>      DEFINE_PROP_ON_OFF_AUTO("display", VFIOPCIDevice,
>>                              display, ON_OFF_AUTO_OFF),
>>      DEFINE_PROP_UINT32("xres", VFIOPCIDevice, display_xres, 0),
> 


