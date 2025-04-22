Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8ED5C369D3
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 14:49:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7Evj-0005RM-6C; Tue, 22 Apr 2025 10:48:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1u7Evf-0005R4-Vm
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 10:48:56 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1u7Evd-0004BS-4o
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 10:48:55 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53MCfsJG025551;
 Tue, 22 Apr 2025 14:48:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=UxHbHaCeMn5otBWGxF/Hw6RTvW9iLFj3pJiCtBj4QeU=; b=
 JJ62bNgjsjkpw9mA4drr1cAzImy8qjUrBlGQF/2Ac4OU4Jy4ehxTWWaj2KlOMW9d
 JwtrvJHIeLMmqGn4pFm/QxB/BkpQHU0qfEyrB20waz+dNbbEibicYh++KhSlEtMc
 VVe6yLk+bAXbRd8OOh6M7u8bE9hMh539+fS0ARNOal04IppjPcjZ8056Zo9Hs6QI
 fknr0zM5wkPIQieTtRhrd2FA1GFm8m+MpCBDKtBSL0pAJUGzplBl8j5MXJ4PJexI
 49EPtBdUQeA1qt4FP+PB8uDFJKRqz2ZroW/K0M9OwrHT1+j94utbyLWkISAR22r9
 C5mAwEyZw0ALlopPqwpnUA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4642racrvh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 22 Apr 2025 14:48:23 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 53MEXm8l003036; Tue, 22 Apr 2025 14:48:22 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 464299g2c5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 22 Apr 2025 14:48:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mgeNDvYxW8ZpSEe9Rhcc12yakVjUhphAN3BTjqFKz81Vb551k+UuzcO3Nf5tLDwx8NnWvmnrolVZ6h8PMZmUFpnH9WWjSXho0NsEuNKsq3yJyIpqYfjpYgWGBaLM0sLHH5FbXga1PRT1OIUfvvESEGbiqwKIWe0Rkl+u5dfOT758W1RBAf5YvZpyfSLHt2xjr+OksS5p9iyCmrFKd6/rLHzi0g5kf/FFvXHfaAOwsAZVx6an/npN5pAW3ToZ1H15fMaMgNfL2FFrStQE+oAEH6iz+Ih6og8UESH0mNea5xMRuV600W0tRrc2hml+lyCIv69rsPMRpmkDP/GutuDIdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UxHbHaCeMn5otBWGxF/Hw6RTvW9iLFj3pJiCtBj4QeU=;
 b=TBbwDNrF5ASZPWaGNhoECJa8aPEPOj7FYqZLT14KvdiLgspA1bPTwcX94kENG5GGBUH2I2s3YTABgfnT5Hzq80SR45OBm821V714+EOdTs+QSeXl/oXar9svD5b9cxR5fQeY+UnF4903tZXrhVdoZ8U4RYkdotfiuSxyJWqwIZkMVpSHdX7LiIuWe1GLECHA3vlgC4Bso719UtoAUGLiB8Vd5DoItDwyGRcL9BPjTVlG1T1STrabbzCf/HtU8qz6uhKhWU75EfzcQh7JHSjOoTqaznO4Dw6T1PVfX9yNL84B9V2zPFxug8VFJP3RkZKQ53gthUc7WbO+G5Bd0Q4i+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UxHbHaCeMn5otBWGxF/Hw6RTvW9iLFj3pJiCtBj4QeU=;
 b=te7jqYcvoYXb2asCakmCCCZf7CIVE2/63hcZvsdGrPKblrPXzeZi6W0z4gklElCSkhOyAeN1o+a32FY7Vrt/d8ZjQn0aM7le2I7ddjj/zVQNRXoamJGq5Dffx9JwgHMlA9rOCEHztrHUeMpFantteVdigkuTpSbTFCtny++qQYw=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by IA1PR10MB7312.namprd10.prod.outlook.com (2603:10b6:208:3fc::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Tue, 22 Apr
 2025 14:48:18 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%6]) with mapi id 15.20.8655.033; Tue, 22 Apr 2025
 14:48:18 +0000
Message-ID: <0dd00d13-8286-4915-ba7f-411e353e51c9@oracle.com>
Date: Tue, 22 Apr 2025 10:48:14 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/qtest: Pass down do_connect param in
 qtest_init_with_env()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
References: <20250422120420.3068159-1-xiaoyao.li@intel.com>
 <0645c51e-fb07-49ff-8a58-49b29ab59a33@linaro.org>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <0645c51e-fb07-49ff-8a58-49b29ab59a33@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0923.namprd03.prod.outlook.com
 (2603:10b6:408:107::28) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|IA1PR10MB7312:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fa4bbf2-1390-4a27-c907-08dd81acb817
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TGFML2VrblNnam84cU93RjJsZ0MxQ1dsZktMZWNsVWZsT3A3ZGlzQjJrdWkv?=
 =?utf-8?B?WHZmSkdtMldqWUQ2S1hVTVUydFpTOG1yQmwwZmwrTU92SGpkeXlUK0JTZm8y?=
 =?utf-8?B?cHVzbTlqaVNmb29Henc1NXFsL25yNmRSY3IvUkJGTnJGR091OStwdkdHcUx2?=
 =?utf-8?B?aE5OY3E0dzJ6VUpFZUp4ekJ3K1pBeVRFTVJMSlQzQ0pObHk4ejBveks3QjIy?=
 =?utf-8?B?TGpSazhPd1dkZDZUNnJmdDlZSklQUVRpc2poQ0FqN1M5VEpZbFh3Zy9UN3ZS?=
 =?utf-8?B?SmFvV2VJanNTOVpLMzZOdW5ZMWtCVHVUMjNaTW9NWlFPWXRjRDdHcDF6K0Nr?=
 =?utf-8?B?ZjkzTUtycGVxTG9xSktURTZ6NGUwdWdLU08wYmNIRUFqT2VhRGg5bGs0M3dq?=
 =?utf-8?B?NXNaQUhtazNkU3FXMTQybnlIeTZ6N2poUGtoejhCK2VIaENEUmVOYXZOVXU1?=
 =?utf-8?B?d3VKbjFyaUN4SGpjU3BLY0gzN2lnNVBLbVZNVGFBNHRQaHVCYmNDdzdSUk56?=
 =?utf-8?B?S1UzUjVpaDErU3BFWWlabmpvQnhTYUQ4NkttNFZoZFBsVEM2c0QwYWZaOWhy?=
 =?utf-8?B?Q1E0QVJ6STFKam5pYmROODRwOFlHbGYwSFZDaDlGbGEwU1NLRDEra0YyalNj?=
 =?utf-8?B?VTEzRzVmdDkrK3FzUlJkaWlwUUZsSlBWc0p3dG9IRkp3M1hFRzhTWmUvVnVw?=
 =?utf-8?B?eG5BN0I2SGxnMjVibWhVVXhpNVRRWkZIWnBydUZGcEg3RkdBQkY2S1NJY2gw?=
 =?utf-8?B?WGMxby9pM0tYSm1GMHJodjJRUjlRYlVMYkZzOHlPcmJ6QWpZZ0RHQlFWNGxk?=
 =?utf-8?B?allNa1pyeHoxQlRaUjFLSngyYUR0L2JJZncxUExtSWhmM05xZjY2ZWR3em1q?=
 =?utf-8?B?Qm1ib0dEdWY5VmNHeEorVDcrcTJCL2s1STAzeWpCVExDSHcvV1BpWUdRR1N1?=
 =?utf-8?B?Z3FUMlJyKzVldDBYMnBVdW54MWhIQVRIQTVXSDVrYnZXdkU5aWVZcC8zRmZL?=
 =?utf-8?B?WUxWbmNTR29QUkI1cDhBNFdRUzdRN2V6M2E5VElucEpFT1dUdXNLTlRwcnIz?=
 =?utf-8?B?d2thcTY4ZUtxemNYd2ZWZytkeS81VC83T2ZBellGV1ROUGsrQUhPV3lMb1lS?=
 =?utf-8?B?bS9DeGp1MlVjQTVlUTIzdVlkYVYvN3dRWGVISUtRc1ByL1VpK3lJOXF5N1Uv?=
 =?utf-8?B?Zlh6NzRSeEFXWXowUVhJSFRVNmZhNW9lc29IUDQ5MVlBVXlQT2ZNZnljS1kw?=
 =?utf-8?B?ZFpNdUtGUHpid1RPN0htK1dTaVU5WEpLM1Y3Zi95RGw1cTQwWVpFSnhVejR1?=
 =?utf-8?B?MHBwTjVLcGtzMStPREhsTC9sTThwWHVnWjlOcXJEeVdIRGlsZHBzL2J6R25u?=
 =?utf-8?B?RWtyL0hZTkNMQnRXMS9PbDQxSnJ4NW1BbXlrSFU0L0dTelBybW9NRVo4UXc3?=
 =?utf-8?B?RjRSWXNIeWFuMXJVc0ZyOTNaMUw5TERUeFFpZ04veHpLS3dvVkxLcG8zS0E3?=
 =?utf-8?B?dW0waTNGNlZ1SjRxWXc2UURTT25PaW9vMGluYy82YW0xczRKT3A3UytGN1B2?=
 =?utf-8?B?VGtRdExTcFgzNHpIRnlkaEVyd2VyT0FhOEVJeUV5U3pTNllZaEh4dno3c0tx?=
 =?utf-8?B?aTkwZ1Rac25Tbm5hY3Z2NUNkMG9sZmp3NVpPcnpjaWxiVlBKWUFodkdiWUQz?=
 =?utf-8?B?YjQxVVFVbldIVWlSMy9MSVlJNytXd3RtcDV3eDZMcVRjSG04eWNtSEtRZFRU?=
 =?utf-8?B?YkpwVDBGWXJ5bEtuVGxUR1duZE9hb0h2STRjL0dBYXVvTk1rZ282UFBWSXpt?=
 =?utf-8?B?cnRMWlFlMGZPRGRHSTdTN3E0U3RHVGt6aHNrNGRxMzdlZGt6SjhhdTUyU28x?=
 =?utf-8?B?Vk9Kbkdmd2ZpZnJ5UmRvMnRpRjVYWkgxWEcvbktvTE1ZOVZEbVRFQWw5T01o?=
 =?utf-8?Q?oVZ8k5JutCc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RHpTMnppckV0SDlubUs2VmtKdklFUm9GZ29XK1NnMjNBeGk5bUtTSzFxZHE5?=
 =?utf-8?B?b2JrVGpJaGtuVm1ITzBQd0hSc3dKTEJtY3BwYTNBdjh5bkRRQ2hHOER5Unk4?=
 =?utf-8?B?UGZqTDVTTmRRSjBGTmtSdGJyNmIrbTBoVTkxMndPWjg0TXFLM0NUanlST21V?=
 =?utf-8?B?RWhxbzcrZE04YzNEOCs4ZHpiSkpnOUxuUm5SdExkV2FCUDF5Y3hFL0hBRnlp?=
 =?utf-8?B?R3hvZ25ScW11ZHBHNXczL0loLy9CNXN1OTd6S1E4Z2gveWd2UHF0Sm9kWDlD?=
 =?utf-8?B?UktMbFpISEladUZuQTVXRVpKSGNuN21yeFhMUDBRMVl4UHNSTmZOb09Sa2Fl?=
 =?utf-8?B?OWdOeDhTUVpJMUM0UDRjSzR1R3l6aUFRZFArdEVrYzNjODI5a2k3MHBaaVQy?=
 =?utf-8?B?M0FPYTRSSjlVZXNZNTJuUFJ0NmRZMnE0eXFUUnphaEZ3b0dwMWNBNnVIQ1l0?=
 =?utf-8?B?RFA5TzkyVVh4S2cyc1BEM0Z0a1dhcVQ0MkZHYmJmTnJIem1WSitzWWVIbmxT?=
 =?utf-8?B?eW1lVWJqdGZETHg1RU1XNTI5ZFFRRFdBaWgrWWd0eHZsd1l0YzNNY0RDMHdB?=
 =?utf-8?B?MkE5dXNsV3U3M05qS1pyTm5pN0U0RTB0b1JERmhiZSt3L3NUbGhBRHNZVG53?=
 =?utf-8?B?K29zajk2NFNLMGl2U1JWajFSYVo5TUJtSE5ENHVtWCtuNGM2NGRxM3VuMFFP?=
 =?utf-8?B?Um5MQlBLaGI3VzdVN2Q3dUVTWVpPTHlYQ2VOKzVaVnE1SWIrZGdNbGNkNnI5?=
 =?utf-8?B?ZENrWnJOU2JrOXNoV0N0bUJKc243T2p3c1VXa29lZDhVQ0dCaElzcW9NemNM?=
 =?utf-8?B?UGs3cHRHQUxZdFI2MzB2RjViMEwxcmVWSFk2bE5nSWRGWERSK0F6TXdYSTZj?=
 =?utf-8?B?eEpUZi9OUzhqQWNva3JBb0NlbWptUWVPT2RVaHdYR3pwWndIRFB1T1FFUis4?=
 =?utf-8?B?OU5WZElIMlVicDY1S3Q5SzRSQW14RXJrNXJVQ25BS3gwbUdzdC9rMjQ0Tm84?=
 =?utf-8?B?Z0dnYXpXTFNXcGVaV0E4NnA3WFAzZE5TT1c1SGtWbmp5K0ZBM292OENNWDlz?=
 =?utf-8?B?VHdES2R2T3JrTWlHK0QzQ2FLSG80TE1hUGRpbTFJQUE5M2ZjdTJkTUMyMmVn?=
 =?utf-8?B?citFRXNMOEZMdkpWb3pHaEpYaWpKOERlWGZ1L0NJMUFZZ1Y2Sk5qUkNyRk13?=
 =?utf-8?B?VVJMa1ZEVExHRzc4cWM3cENJNEU4NVNCY0dDdi80TlQ5Vmt6ajhQV1h5VWM3?=
 =?utf-8?B?SzF2ckJUNVdaeEVuR3RKNE1uWVpuRWlyK2hPWkhPaTFzaURPNGY3WWJUaTZW?=
 =?utf-8?B?MGozVnI3RUE4M25keHBHbURuZml0eXB2Sm5TL2tzTmtjQldLbkhQZ1pHRE1x?=
 =?utf-8?B?ZjUrR2VTOUJBZER5OSsxWmVSMjJGWGIrK24rRElZc05ZaWhZNVFDTGdxbWNy?=
 =?utf-8?B?dXB6dzhoMGdMME9mMDBJc1UyMUdXNXJHajdZeUpQcGsyR09mWkNnNVNWQnR6?=
 =?utf-8?B?ei9mQnZ5di9SMWY4YWh6TUh3b2ZhdmF6NzZPY1g0MFJmMFpFY2t4TlRRc2JK?=
 =?utf-8?B?VktjS3oyTHNVUFNwVGdiM0hLVjlvM0FwRy9wRU1neTdGRGdLVGszOUNodk5q?=
 =?utf-8?B?cCtmQkZibXFld2dEbjJkQVY4d3l4U3AyRzlGbFVJbEk0OU8zYXRKTHZ2NzAy?=
 =?utf-8?B?UWxLUFhjU1lGSnY3b0tTMllmVi9CYzcvRVVlWDVDVGpvZEhhQVl2cWhUZzZa?=
 =?utf-8?B?N0hrZnJZQVVyWWVEVUN0dFhOMk1YY1pEY3EybmNueTJMSnN3amJnYndiMWFV?=
 =?utf-8?B?RTVuOFYyNE9ISXI0N2JIZlZyL0ZCZ3ZGY2tZU2pkTzRzZVRHdjRCZlkxSFpv?=
 =?utf-8?B?eWFFMUhCdTYxdWFLenFaRUtZdzZSbDl2dStKaTJQVnNHUnMrU1htcGg2Z2o1?=
 =?utf-8?B?d1Q3ckM5S29pY2RnQ0JUVFZIUk9idVpoT0Vib1d1SDRmeEdXM1lnaDlTem80?=
 =?utf-8?B?WGF5QkhWbU5IUU0yYXpDa21GUlBJdm9ydDNxNnZTQ2lIVGp5WGIwSUJQdjZQ?=
 =?utf-8?B?VlJiL0QvY2xSZjRNUHBTWEgwYXhUTk1GZHJFVHpwS0R2WGQxb2JmNVh1YmhG?=
 =?utf-8?B?THA0YjRtU0ttSnJyQXZSRlZKUnN6RFFBZ3F2bG5nQkNUMkxwald6cHc0OSs1?=
 =?utf-8?B?Q3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: lk7zR1xJiee3jeC8aTw8F2Cn1i7LKWb3raURAKqd6OF+1qgi+rg2KK7Q0nT2A7xsMOxLU9YhL51yybhFod14T6LyvNjIpKjNop2KFLrhNlCZPtmzALJJFeRmoshGeQI3bsUVsFAh0JJ6NF/ModXokZHS931mzmUIL9FiRe6kfViswYs5uuToivKm43ORJ0jlIGtjKPDwVAwUmKDlk1DzJHpNHvD5m3BcAcouidS2T1Hhv+dng+rjIYDHxIFayqC5YPkQ703AqzX+CgJPZHunmRJSgw8WiG7pvAuE48WSciUTc/dg2T7codRHG8ofTh2j1bGs2TUDuq9VNWpfjaha4mitaCrv2Tqd8pD23hpsjxzGOTfWTIPXkf3Jb+Ob6pVez87RGhsz0KlFtXHy35dAjEnNZxAw8OyX5x9p1E57nlPikqBWnpr7CK1uS2y2phkKKgaYwoavUvn6Lvsrtb3tE2hj029BbZNL2Zfrz+HbNkAnHvxGkCpKE0qZkzIpkznlcHxLC+hzMC5kj4zWGQEu1Hs5sZGhmgmQ5x6UYJ0PYy4m8Y7PRmzBtDOjAJgSxCP0Gwq98yRqRW5Kc6LPjdhwvT3+q4EMgbd9dLXzfLfyV3Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fa4bbf2-1390-4a27-c907-08dd81acb817
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 14:48:18.1217 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Prz0LUvME1flmINKYE2pHneWf3+UXGdoTK1EtBi4Q9FnC57QnrXSOUs57Y+KIMGYuYHKbutGfgVqtQOPf9H6RB9d9hq+wgJWqSCJW7RMw7o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7312
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-22_07,2025-04-22_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504220112
X-Proofpoint-ORIG-GUID: yDuETGKrJIyONTTC7szqfs75C3wsiRfh
X-Proofpoint-GUID: yDuETGKrJIyONTTC7szqfs75C3wsiRfh
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

On 4/22/2025 9:20 AM, Philippe Mathieu-Daudé wrote:
> On 22/4/25 14:04, Xiaoyao Li wrote:
>> The @do_connect parameter of qtest_init_with_env() is not used. Fix it
>> by passing it down to qtest_init_with_env_and_capabilities() instead of
>> hard coding a true.
>>
>> Fixes: 5357ef823a1f ("tests/qtest: defer connection")
>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>> ---
>>   tests/qtest/libqtest.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 

This is the same bug that Vladimir fixed:

https://lore.kernel.org/qemu-devel/20250410162250.329941-1-vsementsov@yandex-team.ru/

- Steve




