Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5469ED637A7
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 00:14:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBNUT-0000tU-Qn; Wed, 13 Nov 2024 19:13:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1tBNUR-0000t6-Fp
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 19:13:39 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1tBNUP-0006Kh-BI
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 19:13:39 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ADNBZiw014869;
 Thu, 14 Nov 2024 00:13:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=mS8Gwn/G6g+CPCvBXQecVcwCoyW1Gh/rwYUjMNTZ3N0=; b=
 HPmfwAnqpXKtRq2D4Jg1Pd4SEaAeWGY+3PDbCnjNvnlq7FHc0E36kBl+aRDN3b7e
 CIgpZZ3Jf/fdR1zB5cX7z3icXvSHrh9Cfn9TM8HEG6iBIRfwzL9qxs5trBGa9535
 pTqXWZ4cJ3ACwtFWj3CPAh7wifN0qTO1Eqj1yWsJ1j3CacR0HJrDlWANYf56vu0M
 TI3YLdw9SWm6kRUwrdZu27JHi9aKSgh3UhIYTf3qcuboNR772941lEONw+WBiQCo
 9v4RPKqLXAggfZId5V0bCXuBYyxTKCPNJXMDoloaUssP/fMcEwR6DuV6L0RJeR+s
 Q6AEj/R2GKC7Jlw4T5VVLQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0k5g0cf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 14 Nov 2024 00:13:28 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 4ADMDr6v000338; Thu, 14 Nov 2024 00:13:27 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2046.outbound.protection.outlook.com [104.47.70.46])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 42tbp9edyp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 14 Nov 2024 00:13:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pn9DGMn6DSxrHvFmtXFnEAi5sa3/rg5UC1tHT72o/3uBsiSXPfnmqwylv1gCx9C6Q1yopsoYRqbLrq5qxHINhDq+OeP6rtXeJbI0mxOiGHdwMasYIlnEakqaMSIEsMq360pDnIkjB6Z7d5U7mDWTAOEjF0Glr2kgjdrfvB7tQ8wpxlIGp3PrL/pTzW9qLg19LknP8iVNltI0UeUMhq+cP8WnWPBm6REUyi1vNpPT2o1Y/4DiLK6mP1dtymCNOr97sjgUIbfNdKT5ZLB7MnzzJL3J/rhMQkN0ZajpKfSD+mkJyycZgLIysaWXpoHm9vphLB8cSsIrXIFvLxUVyo59ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mS8Gwn/G6g+CPCvBXQecVcwCoyW1Gh/rwYUjMNTZ3N0=;
 b=os3uhuwsg7LOmnIstFGguYOcuFjTeyWlIBNLngrm1GV2PSwOp0aK7VVMtU2e/c926jhw3mLsC4fIjCpiq4E90Z6pGcO96cvbQXlj50k2uY5S2wMO6FXyw9mnHa/iPYzrKzTveljz0oAjQ6y0K/YeoiPm87YPQL6v5zBYddXNG9HiDGns7bxly2twoPh5uq4KWRFF/w3wERz+WM/NGifzkGzd2oVSSl1ygsqnGdVzmK5GpNb6wScMPBqWtmY+c7ZMKTkwk5Ir2dQHyry3ROpSWCbPe77EY7yacoTe9Qj/5/iFm2wVyXVBcIfMiMTPEBOcadB0ndOQSzogA4+UAa4yag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mS8Gwn/G6g+CPCvBXQecVcwCoyW1Gh/rwYUjMNTZ3N0=;
 b=w6k7g6Wi/Kwyd9KoCgtW9vPSXDnP45z48ZLKYuT11k9yeCRRlYgstpk19s3vj0uAdDL+49CvZlayfXS0jp7DDorc1dX5V2dVPoa8MTbwLlpyMi/EWWXR6QP5d+9UXOlAPhRqBzx91H8mUmttdEELwKbzgxN8t55mKkQq4hbvd/Q=
Received: from BN6PR1001MB2068.namprd10.prod.outlook.com
 (2603:10b6:405:2b::35) by PH7PR10MB7720.namprd10.prod.outlook.com
 (2603:10b6:510:2fe::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Thu, 14 Nov
 2024 00:13:24 +0000
Received: from BN6PR1001MB2068.namprd10.prod.outlook.com
 ([fe80::c9b4:7351:3a7d:942f]) by BN6PR1001MB2068.namprd10.prod.outlook.com
 ([fe80::c9b4:7351:3a7d:942f%5]) with mapi id 15.20.8158.017; Thu, 14 Nov 2024
 00:13:24 +0000
Message-ID: <adc9c836-81f2-4cdc-80b1-4e54e2762749@oracle.com>
Date: Wed, 13 Nov 2024 16:13:21 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] target/i386/kvm: introduce 'pmu-cap-disabled' to set
 KVM_PMU_CAP_DISABLE
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, pbonzini@redhat.com,
 mtosatti@redhat.com, sandipan.das@amd.com, babu.moger@amd.com,
 likexu@tencent.com, like.xu.linux@gmail.com, zhenyuw@linux.intel.com,
 groug@kaod.org, lyan@digitalocean.com, khorenko@virtuozzo.com,
 alexander.ivanov@virtuozzo.com, den@virtuozzo.com, joe.jin@oracle.com,
 davydov-max@yandex-team.ru, dapeng1.mi@linux.intel.com, zide.chen@intel.com
References: <20241104094119.4131-1-dongli.zhang@oracle.com>
 <20241104094119.4131-3-dongli.zhang@oracle.com> <ZyxxygVaufOntpZJ@intel.com>
 <57b4b74d-67d2-4fcf-aa59-c788afc93619@oracle.com>
 <ZzTenX8KOOGxZCou@intel.com>
Content-Language: en-US
From: dongli.zhang@oracle.com
In-Reply-To: <ZzTenX8KOOGxZCou@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0035.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::10) To BN6PR1001MB2068.namprd10.prod.outlook.com
 (2603:10b6:405:2b::35)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR1001MB2068:EE_|PH7PR10MB7720:EE_
X-MS-Office365-Filtering-Correlation-Id: 82117fe4-d9cf-46dc-5e0a-08dd04412781
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZDB0cmViOVRuNHdqcjFEYVJyY24rNEt4dWZpWXhlMmpyaHJ1VjdFSmVLdmhT?=
 =?utf-8?B?V2htRDZwUlp3cHJjQlBLbjl5TEJIaTdQd0IyeTd2UUpkc2lraSsxdGwwcHNS?=
 =?utf-8?B?RzBmQitoMENvUmhkY25aQ29EUTRRSTBMSW4xYTlVbHVlcFFjLzN2YVpRNzRv?=
 =?utf-8?B?VWhDSnlQTWtxNnFYanpWSFZFSkxXOFpacEtrUjkxTUtyaEdrQlg3bFROVGUv?=
 =?utf-8?B?SThoYjV4MU5Ja0JwQlFIUkluODRoNDJjZE04TUJXbFhKcEJpMWxMWGdNY045?=
 =?utf-8?B?amlISjFMWHlWZmJ6SzVQb25DY2ZMNHlDZldmS2VGbEN1d1RtYUtMRTROSXJH?=
 =?utf-8?B?eWpVR1V2bGsyRUF0dmhqNnZ2TGwyYlZBM1RuNjZSTmExeUFDYXI5a2cwenQ2?=
 =?utf-8?B?MFczaEZoSHVkdHpIVmNsMkFKYWxET3RqZWJoTTVTTTVrdDhqakkyUW10RkIr?=
 =?utf-8?B?SHpGRFNWRm42Y1NpN25CcjlxdkRyUUVKcE9xOCt3TnpoNHVmL2wxKzBEZmNQ?=
 =?utf-8?B?UklWK0NYRTlqb3RTVWFnQk9ZdVBHNlJGQjlxeU1lYnVFU1YxdmtHTkdjVTAr?=
 =?utf-8?B?d25PSk0zMzVlTm9sV1hPNmZ6RGdyRVR4ZXIyckNaZHdNdmlPbUdZSmRMWGtx?=
 =?utf-8?B?UFV0ME5zNXF4K0E5OFRINDQwNzAzTThpb25VZ1gxMDJ1R1FuYVF5OW1IMUJD?=
 =?utf-8?B?SFg2ZlYzamF5UWNLT1REQWI0VGpUZjZlTEF4bC94MWxIS1pBbXFDL014UEh5?=
 =?utf-8?B?UUNFTlJaRk9TM2ljV0pjblpJRXhnRVRXMUdJbWNnOUVxZGg5SGNaMUZMRWlE?=
 =?utf-8?B?TkNHZDA4TUovRjR0WkFtdXg2N2RvWVdFK2E0V2I3ZVFTV0ladzNZWXU3YmtV?=
 =?utf-8?B?S3FCQkNKOFMrdmtOaktmZXhyUVAramJBaVhpeFc0c0QxUnFyd3ZuT000VDYw?=
 =?utf-8?B?ZEs4QUU4eXY1dXlzOU5HUDBDdDVyRVJJODh2ZXNwNGdRelNMUVM2clpqcGdx?=
 =?utf-8?B?NHltMllobGIwTHV4Y3g1dTBTV1F3cTYycjlpNUVaNXNhN2NTU0YzbGlMcVZK?=
 =?utf-8?B?aUlvU0VMbjNyQ3J3Zm9WRlZERnBCKzRFcVhxbnYyZkJRTFBOVWltK2RBQ2xx?=
 =?utf-8?B?WVBUNkhRa1VROHRXTTkzYXBtUlFDOWEvdHBaU1o0YjdpUm1ZdlpzQlVHcWZh?=
 =?utf-8?B?WTB4NW9tem45UXVSSm1sQ0ZqSklKdTVQMzZhSDVjTGhRdS9vNEVnOEhoZ29y?=
 =?utf-8?B?OUovTENyaVBMclgwaTFnTmtrS2hxVVNBN1MyanBldmhJNEdQcUpNZmVHcnVG?=
 =?utf-8?B?Q2NIUWRDS1RHUEliQjkxZGV5NFVUQU4xQ00zWGwxRmNNMnNML1g2NDNrRlU5?=
 =?utf-8?B?VFhiVCthUVB0U0FDK0RUSmtXZXdsQmRqUlRMdk5hRE5STHNjWHF5NmRONTNG?=
 =?utf-8?B?Q05seTRBTnlKQlI0YnhQSkp1TG5KcDkrMDlYaUIxNUFNbUxuMVNremFIa2xs?=
 =?utf-8?B?c2N5WlpvZlArTW50YkxQYnQyNk9zZnNuV2hWTUJiQjA3dFkxMUxSUHZPWmhI?=
 =?utf-8?B?NFg3UHlGQkNVT2lmR3YzNHZTdVdObFRRaU1HcUdQT092K2MwM2xnWmlVWkhB?=
 =?utf-8?B?ckdBY0k2YlRmRUNmQXZYU3hidG1va2FlTTFiRGFqNHZNdkhMaU1ydkloREZm?=
 =?utf-8?B?bGpoRnQyTUY3ZlZ1NkZFOXFwNHF4Y25QQzE0SXdhWEJIZ01BNUNudmNYeFRq?=
 =?utf-8?Q?8XqihKs9cJz/QoSm7wlAe0cIc9YAKkr7cnw+seK?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR1001MB2068.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N3E5dGN6Tnc3NmZoYzdLWUpIOXYrblFCa0p3VWkvckxLMzY1aW9Ta3NtV1FQ?=
 =?utf-8?B?M3U4b3YzZDIwSWZ5WWVVUlhKQ3JBTlBxdU5yUUdCYmFCVE5RWTRXNHlYR3E1?=
 =?utf-8?B?aDdQVFJYZzFwMHgyMjBoQ0RFWGx4RXNlZnIwTEdsTHhta1pEWElBTk5CYmVr?=
 =?utf-8?B?OVBPWHpRYzQvUmQ2UFRab05EWHMreVk1Wi9RR1U1Q3pWVm9JSDZPM1Fqb3kx?=
 =?utf-8?B?U241VVFCMVlGOGtJb00xWjdkZzRXUTErVjlBN3Q5N3huQ1l1NG9JeW8xY3hq?=
 =?utf-8?B?V0Q1MmNLVmYrV04wMHdTSHJoQVJQS0hZOEF1NmVOeWdWY0JhT2F6OXJrMTUr?=
 =?utf-8?B?U01qcjROenF5Z2FiSnZtaTlJd0RNclc3d0M0STBEeGdvMFhLbk1Tc1hlRXZo?=
 =?utf-8?B?VDdYVFNOZEtOZTlRazNtMGV4ejVLU1VDcFdQelFybkFETnlWai9hTy9oSUlw?=
 =?utf-8?B?aWxIMmxyWlJIS1FPVVBnUWg4TTFmeU00OHlpcTNBbTVkVEdoZENjZC9uZThS?=
 =?utf-8?B?bUVhRENHMFNnL05zS0VSZ2wwY2wvUmNmTjV0SS9RZXcwM0xaT3M1dEZCK1Y5?=
 =?utf-8?B?MGYycWJuZ3FpM0N4ZXp6TXczbTBoTXBna3hCQytHSGhYVi92QXZ5RzE1aHhW?=
 =?utf-8?B?VUhqOW1UR2RLdGJkSEJQWWZ2SWcrbFZlL25zNktWTDk0SU1uaGhESzBGV1RG?=
 =?utf-8?B?ajNSRksxakV1ZytNRFVCZTdRemdkVk92QjZONm5rYmdVRlYvZGVycGpGRGM3?=
 =?utf-8?B?eVFCbUFabHZkdVA2bUhvUXFIQ2N3NzByNnIvVlU5MzVncnRIMFN4c25sMXNw?=
 =?utf-8?B?UXRiOXZ4UC8zb1lnbkx1T2c5amwrQ09OMjlWa3l3V05vZmEwODQ5RTczdDJF?=
 =?utf-8?B?TFplZklwenZURkhRSEJydXdSN0NmK0hlUjZsMmxsL29xdUZGcGVlaE5Mcm1G?=
 =?utf-8?B?ZzhSbFk5cEF6ZjZZRXVaa2VXRkJIcnc4OGd6Mk8vUDRROVArdzZHZVFTTGFX?=
 =?utf-8?B?ZkZOV3pNUko5M2dnNGxNOUlJbHh4VVNBajNieFB5UCtQOVEvTXp3cFdUdmcv?=
 =?utf-8?B?NmRtN3ljb1prcXZreGZyc1ZFei9MNlBTeHBxYXhnL2dnSlBJUHUvM3hMUGMv?=
 =?utf-8?B?SzV3dUx0Q2hGSkFXcDNlK1NDWkxEV3JUZTFEQkZpWDd0SnNIOFBtU0pWWGg3?=
 =?utf-8?B?ZEhvRFhaZ2NEbEZjZFI0cEsva2dTRVZmVjhLd01uOWlIY0QxdHlkVGZKZW04?=
 =?utf-8?B?RlMvbDRidk04MnZSeTNPRmptWFc1UElyZk9wWW5vUkEyTHVzS3V5MGFXY0Ev?=
 =?utf-8?B?MTFCdStoemtiZGVkYnl4SXA4a0E4UHFrU1F5aUcxQlQ0am5kbWtzWXpVWUJ4?=
 =?utf-8?B?TFdZUC9Tdm82cUdtdCt1R2Z6RzFMUnBFb1VzNWRCNWVidXJkeWw5Z1RHaVlS?=
 =?utf-8?B?NXhIMU9ua0gwaEdIM242TzlQL2ZkZ3Bmd2ZLd2dlTFFTdkhKcGd0bHlGQ2wr?=
 =?utf-8?B?VTYyTG0xdG1icVZ0ZWZYVTBidm5jZkdESGovY2cwMDRJYlAyZncyeFY0V2h5?=
 =?utf-8?B?Z0VNSEtRemsyWWZHNjhaTzI0SW1mdFd6ZjBwT3A5OGorWTQyRHFRSElrTzNr?=
 =?utf-8?B?TE8xdDJUSGpaQWhqZXlDdFdsRjRlR1M3bTFhUUViOUlwVS96ZUljc3dJZGUw?=
 =?utf-8?B?NzdKYTlQelBUTk41Ympqc1lXVVVXenl3SlE1V0pIYUFmL1lXcllXb1JwdE1x?=
 =?utf-8?B?UGRZM1E1UDdZeTBmUEVsLytOSHhxbFQwcm8vM3FQQlNoa3JvZ0wwL0FaVWE2?=
 =?utf-8?B?WlJnVXkxSkVnNTJ2ekFtKytLUTR4ZXQ3TDYvV2lIMDdqaUtUSHNuZWJNemlD?=
 =?utf-8?B?dXE0M2txQ2NkMXVic2t6a2E1QW5lS0puTUdXaEdkR0tOdkFhbUFRZVZZcmJI?=
 =?utf-8?B?aHRYVWdwRWpjNlUvSEJIQUNSSi80UHdGbnlJR3RaSUNPVFY4ejNURE02Q3Ax?=
 =?utf-8?B?cWR5a1ZmREJaWGtuV1BkU24xT2xtcmpMdnV3d0tuRDBpVzVMRkRUVExyKytS?=
 =?utf-8?B?Tm16alNWYmJCMzl4dUhpZ29tYlMxTnducXkyeTZ5aVp6eExVcDRwYzErZytK?=
 =?utf-8?B?NTEycE1MeUVrckpVdjhyTVZ6eUpyY09jcVQ2WmQ3dGMxRDNNNG4wZGdzVEJ3?=
 =?utf-8?B?MlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Iote+V6AYwOX7k0JD45PbWhXfZtEoPNrODmBA/Q2EOmdfOXb1EP7shnMtM15H/fi5hvNowRd+baRZVfu7aiR0hU2BLly3mG6YY9zF4e1dhVelxg0LcNPU8BuUMkBZe8saQNiJjVQco5GlthRTzdMQA8yej7GJDdK1ECAC7Tm5zNWQaowqyBu/qPqgbdvCitbpNThSue0MzZOrsCPOJAuVKp010thGKO1Fl/CRns9l4wNOEU5FciNzRKXzUfI7FNh5E2pnEVur9ZM4IaLXjII0iTJTvqN+2Dl596YMu2GMPenUFhETa/bhDvLrYqUjZdBpTvQwpEDi0ZeUJ6FRj1u3lSXmFCbojb0caI0gDSbo5aeU9edbbaLOhuaUNmNz/4Ju2U3Mj9WEr11mHfuWNrXEGgNJBMUJCXAjWuHZjoArwKx2YSXWYyeLXRPXssCQSTcyG7JdUkSXnE5rCraczmrX6vDVLm3W0hIFBf54w5GIfZwgnoFFEc7T4DX29vUMltJ2whiyfqms3KILSfBQiY+Ob/DQdrLpzZUJ4RmYh/lsfZwzoNzl1TxlfstjiIslNzp94MC6vuFN38ZXu68YzgFF3qK+wg3dAD/96Jml7wO9EY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82117fe4-d9cf-46dc-5e0a-08dd04412781
X-MS-Exchange-CrossTenant-AuthSource: BN6PR1001MB2068.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 00:13:24.1154 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ocb5mGPOXwQ8oHswQAOpegcMxShDllbkSWjIAxzyLLmpYR9U7hs9E2IsdlW6t2tdxPj7NlXOSDzusp39rWSLqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7720
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-13_16,2024-11-13_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxscore=0 malwarescore=0
 mlxlogscore=773 spamscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411130193
X-Proofpoint-ORIG-GUID: oHzObzj3iEwu9TxLs7ufF-co_pCBqrDv
X-Proofpoint-GUID: oHzObzj3iEwu9TxLs7ufF-co_pCBqrDv
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=dongli.zhang@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



On 11/13/24 9:15 AM, Zhao Liu wrote:
>>> Further, considering that this is currently the only case that needs to
>>> to set the VM level's capability in the CPU context, there is no need to
>>> introduce a new kvm interface (in your previous patch), which can instead
>>> be set in kvm_cpu_realizefn(), like:
>>>
> 
> Now your case is not the only user of kvm_arch_pre_create_vcpu(), and
> TDX also needs this [*]. So, this is the support for bringing back your
> previous solution (preferably with comments, as I suggested earlier,
> explaining why it's necessary to handle VM-level cap in the CPU
> context). :-)
> 
> [*]: https://urldefense.com/v3/__https://lore.kernel.org/qemu-devel/20241105062408.3533704-8-xiaoyao.li@intel.com/__;!!ACWV5N9M2RV99hQ!PGJQ9Kv-1mo_4YX1fb4N9YvZZqHInebtCNcSniRi3qJNPIfG5zZnDp1b1gVmO-DdpYxMvO1hlH9owAHV5UMT$ 
> 

Thank you very much for the reminder!

Dongli Zhang

