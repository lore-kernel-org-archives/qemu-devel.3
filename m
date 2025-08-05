Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 419E6C87FCB
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Aug 2025 12:04:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujGOJ-0004TB-2u; Tue, 05 Aug 2025 08:03:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1ujGOG-0004RX-Qk
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 08:03:36 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1ujGOE-00051H-RP
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 08:03:36 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5759H3Nf025780;
 Tue, 5 Aug 2025 12:03:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=3gulhQA7M3UmTRj0JTLsmIULQ0iOCrUA24FTwwXuMZ4=; b=
 m7UwGBlRlAEzayNWKXV7jfWAKp9/lZKahV4y3221xGvv7ey5phHp32Pjm2uDXJac
 TqxVwY/JFCUn1h0/qxb/CUHU+ngPeYihpTebmkjOaXCd55lhkVHrrCeNAJfwv/TM
 +tJFn+2ee4cM+udOP0LDBys/w98zQyUl6IAAIBObquhjC/ExSGZ+yVJyzseF4JiH
 USW8N0FLHe+csFTrsfYMNNLqyaYHO6Ecsv2GUKBkYQ099KaEcyncfNOOBU8na/1U
 EVlJg++mLborul0ISeOVuQoaGFF3eN6sLPSvLO6OHJKUkPBF4jeCHWptyghmLOMi
 buiGQgJxI3u2CC2A9uxeXA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48993fvhps-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 05 Aug 2025 12:03:32 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 575BuMLg018019; Tue, 5 Aug 2025 12:03:31 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 48a7jx4s1n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 05 Aug 2025 12:03:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E7dvs7GOXoS4ToMvwwEJlK/FN4W9V6KO/7XqafWxJs8QsAiyQkqRtwrVwyUxJFQxzFuy00uojDSZ+yA1SjigrQY77xNouc7NGNytXNpiLyz/+aqUeHRmLbne0zSpcWzf2NIgj+h9LEqZBW2NFbtKQJdykarE7hXUA7gYF5Icaw+MMv8wTc+OwxnI15eWJXoMHSFrnyxIrPxrhdqEJlVurvDExORK1nBdX+C+s+/tNQ9uOKgXclXlOMjIubWO4bTt026MsmiLb0bET2+AlMoYdrEhL0hJY+gg3vuZi5Sel05/NOAFeaFcdn8mutt2x7NC0qh9ijF+0tDEzU8tJOx4PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3gulhQA7M3UmTRj0JTLsmIULQ0iOCrUA24FTwwXuMZ4=;
 b=NuyDbcnfANFPEU75XL5QdFY0zKiET7gmYWkRYjPNyMBgDBtE2f2i7Nq2k2dyEc08QDanSmNH3pXybQ+woIPHggF8+0eCTl1b/vqB07Os8qJsSRBNdJNtH6kWk4qbthIo0a/h9pKpWnfGQk0ugaGaqya3WsC02ojAKe6ci8QJ7Zj/d2cTf75edLGYadXYAEXPyxOd1j+qmolFa50nL0ZAfOWljIHegfZUH/ooM7myBglhE/zsWoNv3pjZVKB+I8QRiBNgRA5+8jS31gYGba8M7s/NLlBYTGLSZ6LsjOaVd1teaFrzcoK70mH4/O4DoxoLn1q9SCsDIIw/bU+W7AH+zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3gulhQA7M3UmTRj0JTLsmIULQ0iOCrUA24FTwwXuMZ4=;
 b=fo/xSu3sV+MpHApaiateuq4mjGI0gD4BASxpKl6R1kldpeDIfZOuhBTJdhQdatKIfnl5HVu6AKcle6RZk8F2BVAiZja1bO7yrE+uizJ8W6t7KSbnRDWbKd1/ZnB69iddUNeXLox4kuXnfhmM3mgYbWFY7MY+2eILN7L1GWunfJc=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by SA1PR10MB7829.namprd10.prod.outlook.com (2603:10b6:806:3ab::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Tue, 5 Aug
 2025 12:03:16 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.9009.013; Tue, 5 Aug 2025
 12:03:15 +0000
Message-ID: <fcb2ab0a-25c9-4aed-b299-251c2704a8ba@oracle.com>
Date: Tue, 5 Aug 2025 08:03:11 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] qtest/qom-test: Don't bother to execute QMP command
 quit
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, berrange@redhat.com,
 eduardo@habkost.net
References: <20250725135034.2280477-1-armbru@redhat.com>
 <20250725135034.2280477-5-armbru@redhat.com>
 <6bb59bfa-8083-4823-9f15-92132e8d6783@oracle.com>
 <8734a6fgjl.fsf@pond.sub.org>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <8734a6fgjl.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0185.namprd05.prod.outlook.com
 (2603:10b6:a03:330::10) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|SA1PR10MB7829:EE_
X-MS-Office365-Filtering-Correlation-Id: 104c1bc4-3bc7-447a-6a18-08ddd4180f33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eEc1NlBKTWJ5clZLN081T0gzTnZ1d0R1TjljZ3owTHJiNjJZRU90K1o0aFV5?=
 =?utf-8?B?TXVVam1MZnNiYlpqVDA4b1hwekJzN0VGb3l1U0hzcjV3YWZ5ZkloQUNCbWh2?=
 =?utf-8?B?NS9UemV6dTQvL3NBSUZvd1VDTU5HeEx4d2tGV1B1Z0RoRUhuWEpBZThyblRq?=
 =?utf-8?B?SFNlY0wzZXdkOEJCMDZiWnB2cHVEYjYrOGd1TUZ2bHBnaDVQVDdkNTBPb2ll?=
 =?utf-8?B?SVRxMzhxZG5xQm9ONU1vYTJEc3lLZkp3L3NWcW1GT0UvNjlrUGZJVXVTSktj?=
 =?utf-8?B?NGh3RzBRdEhsQUhrVjJMMys1NnYrSUI2aG9xWlhvR3ZYWTFNRTBqRnJ0dGlL?=
 =?utf-8?B?YzdrcExWSkpPRW5HOSs4MytkL05RR3hlNitBSkhxMkdxdlhJYlFmUVBnTnJJ?=
 =?utf-8?B?ZDJwaTdvZjJvakVkR3RaR3FSZlc1a3J4Mk1hV2x2d3R1aEZDRjZuNnhtdjFW?=
 =?utf-8?B?RzNYeGgwcU80N2xlcDk2VXlJdWxTbHVBOVV3dlloaEg0VUp5VEc3c2N4eTNq?=
 =?utf-8?B?ZGdMU3MxamNsR0RnSTkzbHEvSldjT3lDajBPU0lZenl5M1NqOUZ2eHMxdm5B?=
 =?utf-8?B?aUxSTHlpaitadG5PTnZsWnU3aFp4bXc5WHlZV040UDNnNW9PbGp5Z3VmNnRN?=
 =?utf-8?B?RENLSlpmOFA2VS9iTWZyQ3RNYm5sdnNPb3BETVJHcnVSZ1VvS3J4OXJGck9u?=
 =?utf-8?B?VTg4US96NmdaMkZwQmh3MkhpT3pIVlUzWVB5bStHK3huVjcxTUthUzhmWU9r?=
 =?utf-8?B?T2RyeDhzUU1yUnhpSUZwajlBRWFLN2tqWnduK3JtMnJJVFU3U2dHdmc0WEhn?=
 =?utf-8?B?MVFaQjIzNDhtNlVsVzZBbUZ5MnNYdXVmZ3hWYUFqbTJYdGIxSGFHSys3YWRB?=
 =?utf-8?B?SXdaZzlRaHJNVHVITDErcUlhQTdxUHg0RUgzYjhVa2EwWjdjYnArdU9jdE5V?=
 =?utf-8?B?Q3h2azk1ZXp0NXNBa1Ara25rc3dQbDhVN3RWd3Y0enZKWE8xK0NqUkhNVzJ5?=
 =?utf-8?B?SENIbGRRQkdXaWRNakZFSm1Eb212eWxQeHE3SnlrdWwyZEZkcldGMTJzd3Zs?=
 =?utf-8?B?QVhYdjJnekRianI1NDROQ1c0dUNwaE1SamNrUXc4MFNxV0dLelVEWGVjTGZG?=
 =?utf-8?B?d3ZRd1puY3o2N2ZPc2p5K05iTnNibVJzWGIxRUJwemRSajlWdlFMcmlOYkdP?=
 =?utf-8?B?dFZCMHdnbm5idk1ZVzg1RUJRR01OTXovcWhpYkd6UHJJUFJJUHVUQVdacXMr?=
 =?utf-8?B?cStuSlhXT2M3aEtyeWEweUdVdExBemVIUkh5U2V6S2d3c0U2MUJYNlFYRUtH?=
 =?utf-8?B?YWtkbThXdVRMeWIwOGg0RjJUYWNDbVdwZlZPVVJLcTRPaUhlVzEvcWZxOXc0?=
 =?utf-8?B?YnRHS0Q5R3FKdWhVZzdlcFBmZ0t0WFJ1YjNJQ0NkR1hvTUUvQTJpSXFsRWlJ?=
 =?utf-8?B?SkVSZlNqS0lrWCtlT0RaMERXdGFPYVI1L2ZRNE5ZTy9RRjVFOGJnUERWWGk4?=
 =?utf-8?B?T2k0NXdDYUR6QUVUTTdndk5vczlQU1oxdHVKTWhwQy93RWtSYzFrajF4UVRo?=
 =?utf-8?B?MlEyYTR5N3VsV2xnODFEdzIyS1FVdlY4eDBlakIvVldyZjFxTkFKVmN4d3N4?=
 =?utf-8?B?WVEzOEFXUkJWQXloTmpvR2FYSGdkb1Y3aTlnWWY3TmVyMVFYRml4ZlZxTlBE?=
 =?utf-8?B?WjBPVmVzYzRhNXFkdjJtOWUyNkhwUEF3VmY4TjhodW1xbG1WMXk2VEp5K1BC?=
 =?utf-8?B?YUEwUXZFVng5a1JLRkZRQWJ3Qjc1d0xPemFJdktzY25lUENYUUVVM1RRZ0dD?=
 =?utf-8?B?NWR6WEdYdmdrczdjTjRxZXFMVnNyZUp6cTJHL3h5dG1FakYwMmJucHAzVGVU?=
 =?utf-8?B?SDh3THNqWEFEc01xNGNDVHRhaytKY2pzZEovUVVldlAxRVp0RHUydlV5RjVK?=
 =?utf-8?Q?87m9TJAKA6g=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vy8ydEdOQ2pxdy85OFF1bjhpOXhwQ1NsUUYvRlFPUm5oTEIwUk12MGNhcHBM?=
 =?utf-8?B?SXZ5UTBENzlvWnd1UFBvSm1hdWJjTDdNL0I4WVUzTlBnOWgxd294TlZNcE8y?=
 =?utf-8?B?dVBuTkpONzB3RkZ2Y0tnbHRaa3BEQ1N6OXh3UHVOSmJ6RUJwQVVmQjV5VExX?=
 =?utf-8?B?LzZZOXQ4NHRJcVJEWVNSY3BCN25STjVOTTlUeTJrelVKajE3RjladGFmbWlO?=
 =?utf-8?B?Z2Y0aGhKdzRxTml3cTNFTzNMQkkyQStEekJuazhSR1VORVlpMU1JZVdVVzBy?=
 =?utf-8?B?QktvMVJRVFV6bVI1MXhVNGwrZUNXcXhkR2ZQQnQydDRTNjlYaGxSZm9ZcVlk?=
 =?utf-8?B?dklUTUNWajd5NjZFN2FJTDdNWWxSTlBtY1NWWVMxK1FDRnJqb3F2U1NaRGc5?=
 =?utf-8?B?eVl5ejRDVWkvM2VuWUJHZUZ6cCtTamd5UVpJaHU3V1dEazliKzdCeXBTdy90?=
 =?utf-8?B?eW9tR2pTUUVQZVM1b2NOTEJWc21iTWNkR0o4OGpmajZOU09kaHUyM29YU0JS?=
 =?utf-8?B?QkNEZ3pKMEdUKzM1VUp2UDIwYVM2OTJIbkdpQ2pvRm1JVGNISEhTYmFRYzN1?=
 =?utf-8?B?WlJlU2pSZjhzNEQwNlJiTkFXWkd2TlEzRTV1UTY1OURLU3ZNaHJjakpvd3RY?=
 =?utf-8?B?blNaMXlVN1h6SWlyZ0pvSU1jOG9DK1U4MWxXR3Q1eEFmbHZLSkk0bjdPNitv?=
 =?utf-8?B?NkxUZzJ0dXE2dnlSWUhxZkJqamRGQ01lOUNseWU0Tnd6L3dRTzNZQldPMzZ0?=
 =?utf-8?B?eTR3M0loVmpzM1EyOXZJYzFvUmFVYlE3bFpvaXZKTDFkSU9yeVBNVWRvLzdy?=
 =?utf-8?B?ck9RWGFlQ29qdWxVODdBdGdWd0pmaVQzUzVzQjZ5VWNtY2hGZkZyTjFaMVlD?=
 =?utf-8?B?UWFYTDF2azZEMW9Ha05mQ2ZRck82dVdUK1lUQkwrNDJYMkFxb0dSNisxTmRP?=
 =?utf-8?B?c1NqaHJnUUVaeFFOZUI0ZCtwZW9jQUFmNWQ3RGUrdktsbHNBMTZiL0pKRmgr?=
 =?utf-8?B?WTM3WDBrK3Z2d3dZRVZYTDZQTUtmSW5JMTZzdGhROERabjVCTGt4Mnd3ZTdj?=
 =?utf-8?B?L2FFZ3I0MXhpMU8zVmNhRStLYnY4ZFJMRWlpV0d4aE5aMmdJRjlyTVhFN3Rv?=
 =?utf-8?B?R2poVzZaaE1yT0VxV1J5REg0b1FrTE4wcVFzdVZOR01aVklMbE5WdFNPOXdD?=
 =?utf-8?B?dGtXMUpTeU1mOFA1SnJnR3M2Y0puUTJCR2UwVmlYT2wvYStOVG9qNmVhRVdh?=
 =?utf-8?B?WkNnQkJiR3NsSjZ6MElGRkU3bkd6Q0N5QlFTOVluWUtFVkNMQWpRYUJlOVNW?=
 =?utf-8?B?bDh1ZGpzKzRHUHM0MnZMTHEyblFXemk1RzlaOENtMkxUdXo2UG4xRWFEb0FL?=
 =?utf-8?B?TkRkMGZkQktnM2VKWnBFVnd6elN5TTJoTHJ3OHFzdWJBUzVsMmQzMGNtRFJL?=
 =?utf-8?B?a2pRd1d5c013YmdaNy91SEV5N3NocGZ6VDJtVU5JM0Q1R1RhQjVIcUIrdUsz?=
 =?utf-8?B?NWh6a1AxQmtiQW83VHhUY0JMaEd6OGF2YVhpS2NxdGhDQTF3YkdQSEV1Q0JT?=
 =?utf-8?B?SUpSQUgxRFdzbmFqTnkwSmNZNzlqK0UwVFV4bi9wZXIwSGZuTURQSVlUS25Y?=
 =?utf-8?B?QWthVjVxSC83N0dWaWpreTdGTWQvQlljV083TTNzT1dPZDlHbjJUeWxoWkxO?=
 =?utf-8?B?OUtlMEhuVEFtTGRVbU8xRllZWXpTbjNqRExGYlFjeElubi9rTC93Q1lRdW9i?=
 =?utf-8?B?T2cxc3g4ZEZYbmY5Nkp0andkajhiYUdjQ3pRcUxQT0FLSERhcWVEZjg0cTVv?=
 =?utf-8?B?UHlqbXY1enZMSDBSMHpZYWpFVVRkRkQzZWlURVNab0RRUFNnWENSbm9JRlRx?=
 =?utf-8?B?ekZXR1F1STAxcm9OUjgzZWZEYnFMTjMwcnN4MVFuL2FydnpuNEE3SHhJQ24y?=
 =?utf-8?B?dW1WK3hpK3A2NGtLTHNybVBNYlIxbytjeEFEOEFXOHNoTnI4dW5HalBaSVc2?=
 =?utf-8?B?Q2t1c0JpMDg5MTJMNmpxek4xRWxSelozbGgzNE1IN1dVVW5Eekg0bWhWOE1x?=
 =?utf-8?B?TjhaeVROUFVRbjIvOE5memVsY2o5U2ZnelB0Q1YvQVFzNkp2eDBUZ3k0S0Rv?=
 =?utf-8?B?TDV1bTc3ZTRsajhjdTdnUk5WMHJtam1SQlNjMlNkMnhKa0JRU01QcjYrZ2lX?=
 =?utf-8?B?Qnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: EPMpoHu9Uhx6a1KVAKo/dwgENmBWFHGh5a9BCglQg4iSiJwM1792oqnMh0fHhFZb8GiUDI5hY7JEG38rRrAXY/Dtq6HlEO3F1j0085c0s/3ZH9uBygYoo1cHXfyIPm0HorD+/nqntWLnxnZdLXwPpWLb5e0Rl8qbNOWB6s0/HpR6qR0orKXQu7hFnSBmHvlaPzSAkbPTCHSDnLcRBQkBS0nm32lcm7Ta2j9fAR0qtBJ91sXuWo4sLP643Xi9RMEI62rlvH6u1q5w3Be2/ysbS+81glJyQ+ZaCv0e0v3WGNFUJgoxSgtjC9P2NhKkFCDhai96pn7E3tEph8eh9HjwX5sYDU33ornaZ9SuEUQKOErJTP1ry73kVaZVnKNbcaGCNBRBSLzS9gu17YAwqSYtYLycjn6+MtqEc8y8Z/6xFUaKZkayXimGYmvTq1sggtEprCnDn9Bkh5m08sXVYevbQlk8ugONXbnept3CfApj1UrpT5xeAWTUJbB1ZyuTZshElRimZLIYNiY1Fq856vsfg+aLKS6hrssv9cNoPLzZ8IGvNVcJrf3EEAI9EzxXTafii2Q3xS6fzY7Zjb5vRTTjBwDyqHonFBgZz3AEJxQSEeU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 104c1bc4-3bc7-447a-6a18-08ddd4180f33
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 12:03:15.8159 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s0ZnDSjj/wr9TjXpbsRrRoCrThn5A1/EPYE78hWaP1fRCfNySTSa4HjI6itSw09ed6eJz+5vsqp1+V4Xx51hKbTqRVsxKJSMGdt5PAaoHhg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7829
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_03,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0
 mlxlogscore=999 suspectscore=0 malwarescore=0 phishscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2508050088
X-Proofpoint-ORIG-GUID: XmSYrj2dgjggRmY9nQotu1-zYKKvWfpa
X-Authority-Analysis: v=2.4 cv=bYxrUPPB c=1 sm=1 tr=0 ts=6891f314 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117
 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8
 a=sjbI8lTTKFdTb8N1C5IA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12065
X-Proofpoint-GUID: XmSYrj2dgjggRmY9nQotu1-zYKKvWfpa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDA4OCBTYWx0ZWRfX1dE0oCruCps4
 09m7tHizN4c4KrpGYWhXiieUvcq8ryLVL95O8dZi5v53/L/J5y2nOm+mnhnFTczFHzDSfG2ApJP
 k6kG9yekZLv3S7zs/z8xlikUuZci3IFQ4S5+D0zVfYvRWLx7nHNYbpmzv2VVLDaRPanMd5k8AAH
 xr9RulcSFc203LC7k1z6VYAra3ujlprWGdvNcOvoyGV7TVNKdoiullqpmo++nZSCiQqM9w3gsKa
 xcakha/S9RvjWY9cxB+vDsHMgBbnB2ibkXKCzjQiABXkIlVbxhbwHWURLHca4jA8R7KoxmwNWvF
 OaH1vW6+KuB+DTTRi1h9Yg7r4pCTuBCMsuqFTGfy5+FyZ683Z2YiaGaNeAbuv1WzXswd10EP5ZP
 PeZR98q+jYHkKKHmIzOKmCREX6TUuh986zb0hPkRIhI+OfPMgljtHy17wXtxQwG3TdF7fp0A
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
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

On 8/5/2025 2:06 AM, Markus Armbruster wrote:
> Steven Sistare <steven.sistare@oracle.com> writes:
>> On 7/25/2025 9:50 AM, Markus Armbruster wrote:
>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>> ---
>>>    tests/qtest/qom-test.c | 4 ----
>>>    1 file changed, 4 deletions(-)
>>> diff --git a/tests/qtest/qom-test.c b/tests/qtest/qom-test.c
>>> index d358b69c7e..6421f2d9d9 100644
>>> --- a/tests/qtest/qom-test.c
>>> +++ b/tests/qtest/qom-test.c
>>> @@ -215,10 +215,6 @@ static void test_machine(gconstpointer data)
>>>       test_list_get(qts, paths);
>>>       test_list_get_value(qts);
>>> -    response = qtest_qmp(qts, "{ 'execute': 'quit' }");
>>> -    g_assert(qdict_haskey(response, "return"));
>>> -    qobject_unref(response);
>>> -
>>>       qtest_quit(qts);
>>>    }
>>
>> IMO the quit command improves test coverage, albeit by a small amount.
>> It guarantees that qemu did not die after returning the qom result to
>> the client.
> 
> What if it dies afte returning the quit response?
> 
> Detecting QEMU dying on us is the test harness's job.  Check out
> qtest_check_status() called by qtest_wait_qemu() called by
> qtest_kill_qemu() called by qtest_quit() called by the test.
> 
> For what it's worth, the only other qtest using the quit command is
> machine-none-test.c.
> 
> In qtests, quit races with the test harness's termination of QEMU.  The
> quit command requests immediate shutdown.  By the time the test receives
> the response, the QEMU process may be alive (still shutting down) or
> dead.  If dead, it's in zombie state.  qtest_quit() then kill()s it some
> more (does nothing for zombies), and finally reaps it with waitpid().
> Works, but the race between quit and kill give me a queasy feeling.
> 
> Can't say whether the Windows code handles this robustly.

OK.

Reviewed-by: Steve Sistare <steven.sistare@oracle.com>


