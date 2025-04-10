Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B475C3601E
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Apr 2025 21:21:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2zKS-00066q-BG; Thu, 10 Apr 2025 17:20:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1u2zKP-00065n-K0; Thu, 10 Apr 2025 17:20:53 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1u2zKM-00055W-WA; Thu, 10 Apr 2025 17:20:53 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53AL7R2h011013;
 Thu, 10 Apr 2025 21:20:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=N2n3BCLvdlrIC2S21rEq8DkkWCctiGUO+CZA4v9fuzI=; b=
 W2T5IQ+HW6LZNSZyP30g0nVyBpgVD0NAdKxKPSPxCSU7H/7f/d1ld8TLI/a0b1ez
 oMsLcddzjcC1Khz73vV9v0klr20F0MlDq4wEKUNH+2eJKG3RC1GBCM7B+psecRk9
 UCMdeEUZtetgYnkeEkeNQo2wMfBfQ4mtAhU9gw5KVKztFYlL7KV9PKCTlxEt3GRB
 c9tiiCWzw6PZScwRDMorgR++KodFNjs3ZjV0VnTfo8zXsHTXmKKwLFSzx5iapVIV
 /zv1RXMgaUhM5vw22Z+MJJ2UVIxPcRLDL05jb2gBRfs5Lxog81QkMhYDLg3DzBOM
 DMYSPM9ba2cDuqIXHMYfAA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45xnm8g0ub-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 10 Apr 2025 21:20:09 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 53AKj6Vu001435; Thu, 10 Apr 2025 21:20:08 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam04lp2049.outbound.protection.outlook.com [104.47.73.49])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 45ttyctajp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 10 Apr 2025 21:20:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q/26bO5XvMZRE8fCbzjrIf/EjTN8+6b31ssB3LCKlO0LoHqBF1GIAWnQdvocjGmBVQ3/hrjpBYKBi7AbjKsJXFnTnIxwYzUJC4S1Gau/zsK1Gj1J9kR/Fmvd7HkTIpiIt0wXocRMdNQCWYupNFdhgHF2ZOvb7VrTGDpEwVBs+Hd4PvfmgBHRHf5LU8hIYG2ErnUxr1p3LHfBEHQ9jovN+5TwsiPo+VskROgImwGTvq7zCWFYXUz6YJqO3HDR3GCLFhA5sAn7IUGBsmML1UOUIIxgQeZhEpfeu5Zc+h0dwFmD2Fe47tbSH+DZoOVWk8KA9iPdIgK5fS52/508qVIHNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N2n3BCLvdlrIC2S21rEq8DkkWCctiGUO+CZA4v9fuzI=;
 b=M4U6pVULBAR9oWQe5PGeHHggkKp4s3rISu0WoNUJ+bndn+R65GsgeKMMu7Am7/13nxz99St12bbuc046iHPWVb7gHPxpzek0u1tb+7YPQ7YLc/HDRh3L7VMSd57Hq2HeNg9/+zgVEWogzXDGgdz7Q+ZdwyoQSyIF8DbrVTgcUPy9zbQs/sPffJIZ7wkU1THllgytrDFUiFNnN25rW1EXVUZCsNiseNUGaOroE++pAzVFKQBqL04U3O8ejUFCoJKJCpkVJ/0OGMNsaR7I0LZPzh84RrpnUsEctrWokPWBNiUR7Nh0UgAorXdoND7oWOLGTmXbEygr83CH01H7LjsylA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N2n3BCLvdlrIC2S21rEq8DkkWCctiGUO+CZA4v9fuzI=;
 b=hXuZKLsW3d/0wb149+GJWvAoQXCoZdWVPsfnu5/jLAVfnQEq7dhPmsxtwDRYTYfu2cUF2om5r/E3rvkL2zfeoZ5Yyl8hTIneDmMsfKQCcZCO9kqIQj2w4MUvEIdRdWN7yQiH11jbByjNZUOY4tvgzigqkogUzh635BfYJlejLhU=
Received: from DS7PR10MB7129.namprd10.prod.outlook.com (2603:10b6:8:e6::5) by
 CY8PR10MB7338.namprd10.prod.outlook.com (2603:10b6:930:7e::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8606.32; Thu, 10 Apr 2025 21:20:04 +0000
Received: from DS7PR10MB7129.namprd10.prod.outlook.com
 ([fe80::721c:7e49:d8c5:799c]) by DS7PR10MB7129.namprd10.prod.outlook.com
 ([fe80::721c:7e49:d8c5:799c%5]) with mapi id 15.20.8632.021; Thu, 10 Apr 2025
 21:20:04 +0000
Message-ID: <ecc2d76c-9c91-4bdb-8308-b93b516635a6@oracle.com>
Date: Thu, 10 Apr 2025 14:19:59 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/10] target/i386/kvm: support perfmon-v2 for reset
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 pbonzini@redhat.com, mtosatti@redhat.com, sandipan.das@amd.com,
 babu.moger@amd.com, likexu@tencent.com, like.xu.linux@gmail.com,
 groug@kaod.org, khorenko@virtuozzo.com, alexander.ivanov@virtuozzo.com,
 den@virtuozzo.com, davydov-max@yandex-team.ru, xiaoyao.li@intel.com,
 dapeng1.mi@linux.intel.com, joe.jin@oracle.com,
 peter.maydell@linaro.org, gaosong@loongson.cn, chenhuacai@kernel.org,
 philmd@linaro.org, aurelien@aurel32.net, jiaxun.yang@flygoat.com,
 arikalo@gmail.com, npiggin@gmail.com, danielhb413@gmail.com,
 palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, richard.henderson@linaro.org,
 david@redhat.com, iii@linux.ibm.com, thuth@redhat.com,
 flavra@baylibre.com, ewanhai-oc@zhaoxin.com, ewanhai@zhaoxin.com,
 cobechen@zhaoxin.com, louisqi@zhaoxin.com, liamni@zhaoxin.com,
 frankzhu@zhaoxin.com, silviazhao@zhaoxin.com
References: <20250331013307.11937-1-dongli.zhang@oracle.com>
 <20250331013307.11937-10-dongli.zhang@oracle.com>
 <Z/d/ft0CufA8prwl@intel.com>
Content-Language: en-US
From: Dongli Zhang <dongli.zhang@oracle.com>
In-Reply-To: <Z/d/ft0CufA8prwl@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0024.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::37) To DS7PR10MB7129.namprd10.prod.outlook.com
 (2603:10b6:8:e6::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB7129:EE_|CY8PR10MB7338:EE_
X-MS-Office365-Filtering-Correlation-Id: cb74e5a3-691b-4476-30b6-08dd787575ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cGN5RDNFcnhXSEhadkNLUmRSeGMrUHZyNVhWYjFDWlRqbjF2SUJoSys3VVJP?=
 =?utf-8?B?TkJqLzBQK0ZsTFJqVDVXdXNNaERGcC8vY0dTYjRDVHhETTNjNEVNd0UyUnFG?=
 =?utf-8?B?M1FqNWFoV1duOEh3OGJ2dXpEdHpyYTFtMFhFS1BXa0RQQTNRTUN4aldjYlpZ?=
 =?utf-8?B?UWtLZTV6WVhrV2N1NDg5S3MvNWtUVjFKalVFM1ZCVU04Qll3bVh2ajdtT3ZT?=
 =?utf-8?B?UjBwZkM2T1VvSzdPWnVXbk12QWRPSHJtQ0tucWN4UERYNlBkSk93bjFPdnAz?=
 =?utf-8?B?Tm1UQkFvdkdsYWQ3SmZEREFHUGkvaDlBT1hldzFwNHRDOE5KU3U5WERnNjRi?=
 =?utf-8?B?SjQ5WlMvWWpnVGpNTndzN253bGxRdnJBWE95VHpvejI3L2ZrSDRpZEFiLzEv?=
 =?utf-8?B?ZmVvVEhVY1VZRDNSbzVMUXE3S0R2YWtTVTczMmk5S1dNclJaVzl2cFNzWHFj?=
 =?utf-8?B?c0dTUjBjL1IrY29zV3oycUpIRG5rVTR1aXhmcSsxTnBrWkxpVUtXTXZDYkRU?=
 =?utf-8?B?ZE56cTRQRVVkcVU5NWtXclJhZDN1OG9zRk9VcnYxdHlJQlk1MWZldEZyczNJ?=
 =?utf-8?B?ZkhXa1NFRDlDKzhnZUxWcllqM0k5RUs4a3Z0M2ZuWUNZVkd6VkVEOEhNSWhu?=
 =?utf-8?B?L2tpL3pVWUFvdm8zNGpOVWhocnFtZDE1NEFGR25EYVRIV1RpWHVOalVqOW1C?=
 =?utf-8?B?K3pZcGFOSHFwZDBSQVF6L1RadjBrZTdUL0JBNUh6bG41VFJENVVzcFg2bloz?=
 =?utf-8?B?WlpDbVI0U3NEcnVnRGFuMjV6N1VnektGU3l3d3VIRUJEUWE2OU91NjVwOXZ5?=
 =?utf-8?B?VlJSN3lTcmE5dEZsZEUwYWx0L2tPMEVFNkRjalRJNTh4eEt4ZnFZRmdXL1Z4?=
 =?utf-8?B?SGNlcFFGRDgyenZhbDU2ejZHcWtITWo2RzM2RndPVVYwNUt5VzV5RzZHOWtn?=
 =?utf-8?B?eGRMdDdyeS9ITVovWXhLaFBJQy80cjlQd2hsenBrVW1NNzRhQ25aTDcxZE93?=
 =?utf-8?B?ZmRXdmhwdHBDaXEzazVzWjRUeHcyOTlkT3BKV0lvQUk1VGNCRytHMmxTNm5M?=
 =?utf-8?B?NVNlUU5sN1ZOcEsyMzBTY01VOUFxVHNpa3ZnVXlkQVhjRFpTbFhmSUFhVEgz?=
 =?utf-8?B?QWNNTUw2UUJhSFhqeE45MWFjRi9NNmQ0dGJ3bHFhNGwwQnJVbnlTbFEyL2lW?=
 =?utf-8?B?QVlEOVZpZERzaWJmd09MV1p0UytUSG0wekRMcG92UzlyREhOdUtFT245NVF0?=
 =?utf-8?B?RE45dkhWNmlDUCttOTN5RVJIUDloMmJ3bUFtdVRqb2ZGMmhySWFudFVwY3Vh?=
 =?utf-8?B?bTlEc3JrWE5YMllzYklNQXhSdStPaHRnN1E2ZVRHZnkvanZGOUR6Y2ZPTFZU?=
 =?utf-8?B?NWZ2T3h6akRpMnZNSmg5WW9xTDdrd2YrZ2ZZWjZpWjZOYzM1WGpQZFRhU0hn?=
 =?utf-8?B?UVpYeVRyRFRQUmpMV2JlMk1XZlRNU1h6UVQ1cFUyV2dCK21Za0JsZ3RJWkhC?=
 =?utf-8?B?Q3FaSUtGTUlPSjE5OUFpbXY2MTU1cmZsUW1EajlLVHVtbm96S2dEalFDSnhU?=
 =?utf-8?B?N21peDdsdFZ5b0pWZDcreHBSY0tVbG1HS05pV0xnYWJJU3lnZkVaQ2J6d0pl?=
 =?utf-8?B?WlBlemk2MUZrYmMyaFd1dG55NTJHMGUxRFJVYjdhb0N2MWRhNDR3ZFFHZllp?=
 =?utf-8?B?aFFIR1BMTzBZbUpmSk9zdTNCU01HaGp1RDU3eDBHNHR4THVCZ3BYUERLUXU1?=
 =?utf-8?B?Smo2aEh4eFdaWEVCR0RnanRvQjVQTUFtTjRldHhIdmp4OHZ6MkdXNHp2ME4x?=
 =?utf-8?B?VWdGem9tNkIyWjBOMUpnUjFQb1ZudHFVOHB5NnR3QnhEdDlCU3hCSjVHVGZ2?=
 =?utf-8?Q?iibneTnXSbFla?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR10MB7129.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SkRWTHU0dWlPeURRNjFVSFVGOFhGaEczd28vTjFKT3NVNlZrZVFscEsxVVEw?=
 =?utf-8?B?Z09EbzBMSlkzbnNJVmhkc0pCem4rSzkwT2pUS3RXSWhGcXc2aTc5ZXZucHpt?=
 =?utf-8?B?OS9jMS93QlR3NDlGRkoyd2liMXNkaWZ1cFVlRTkyTXdSRk53UnozYWtFQk5n?=
 =?utf-8?B?V1J3UlU5WE5iSHBLQkFnNzdHdGRmUjhSWFUxVEJnTG02RXNub1VZM0EveE9V?=
 =?utf-8?B?d25qUENQUlZudEJYMm03bElMZmNsK3Y1dTVYV3dCc21QRXNQOXRPUW02Ynl3?=
 =?utf-8?B?SS80VjY1NitwTDhqYW9oeFJUTHRrN1lDNUtCUXVyc0xHVklheWdydTJiRGJx?=
 =?utf-8?B?c3NjNWExaXZxdy9NNHRtOHdHZG9DcEozV2JieDRUcGdPVGVMUWZJazF0bTdn?=
 =?utf-8?B?K1FCVElnNGpVMmhON2lRUjBWTThjRXhEMFlSS0FTV2JFelVkcmdzSERvQjZR?=
 =?utf-8?B?VmRVbVVnay9qZkljVzdwK3hLZ2NtQ0dRUWVmY1BVcGJvdzlXeWVtcVRQdDJB?=
 =?utf-8?B?dkRuanF6MU5GUktvSDBIUnhzMmpGU0crdG9xWVo3ck9HbkdPak5md3JLb1Fu?=
 =?utf-8?B?WllncE1ueExoWTRzUytOVVlRYkloUFVlaVpsSVZIRFQ5ZnZVS3p6aVBKYkQ0?=
 =?utf-8?B?MFFRUktiQzU4c1NGTUtKaGFRcG9SbkxwT0FkSStjOTNMano4MXZYUzREZVh5?=
 =?utf-8?B?OXJUVENEUk04QTIrVEpzSFMzRXlFWm9kbE5xUE5SZHNyYWNjM3M5aVBYcCsy?=
 =?utf-8?B?dnhoUU0xaytUanZiNFpxam10RkxwR3pGaThRUHIveGN6eDFTRjVWNk9wYlJa?=
 =?utf-8?B?NVVyRnQyZ2M2dno3eXZIVXJuazFRekdOdmVmQUhQSkcraXV4S2lvV1Q4MHEx?=
 =?utf-8?B?aENUK083NThDdGJsdjJSVkVZdEx0V0NVVVZYSkppSXRVRzA3R0hVL0Z3RVRH?=
 =?utf-8?B?Um8vU25EdjJHQytaTi82bkMxeXEybDFOUUhoR2tPZzBPcTVNSnJjaW1yWFNu?=
 =?utf-8?B?RHcrU1daZ1FYZTM2L0ZobjBQU2k4b1F3RlJHTEtJSzVFVGdjVGN6WjFwZjAv?=
 =?utf-8?B?UmQxSi9zdlpCMVlabURleHJibi9nanFjNC9CZWRoMGh1QndjQUpKTXVjWWw5?=
 =?utf-8?B?c1ZweGpPenRZZ0ZYUWloRFpIU0dCd3QrdUp2Nm40c1o5UmpCUUw0QnNiNnBQ?=
 =?utf-8?B?SkwzYXhlNWFJbUxGbnZ0UGFwcW03UTArV1FKNDFadWI4eEE0UXlpTUdqNUd2?=
 =?utf-8?B?Zzh1L2ozUzg0M2h0OW1vbW9JYXRYeXl6K1VIbm9kZFRHWkJFeDA1cjNjdzd5?=
 =?utf-8?B?MVV2T1B0QTBqZHh5UkxJV3Y4MGtkQlFMZyszT2M3bzZ1eVNaWmNxejBxTTds?=
 =?utf-8?B?THI5ODh1Y0JUVjdSMHJqYzNmMWlYdmxzbVBWd29rOVVab3oxRkRXVUJ0bHBl?=
 =?utf-8?B?WG5lb0UrM0htbDVBdXl6dG9tSllQL3JhTDYzQWVLR1cyZE1kZ29kZ0xHb2la?=
 =?utf-8?B?THpMTWRBZ2lRTDV2RWhYaTkwNitMSGpoR3JBTXZNOE9tVWRoT0xnVWFmQ3lH?=
 =?utf-8?B?NzRlNCtDa3hPNlBobjl6V1pCa0VQVXUyUTJlbkhkM05Jc3lzSXRXVW8vYVpr?=
 =?utf-8?B?T0dINHAvQUZSVk5EeWpCaUVqR0ZNTHZ3bEEvVVMyRlZZcURTb1NGUWlFc290?=
 =?utf-8?B?V21PNmw5WjNqQWVSM2FtaEhLdktsUVBSc1pwOXJPUDBPZHd4bjhPejVDS3E3?=
 =?utf-8?B?NFpERVROdXhNeGRBd05Md0ZTR3NVUGJmNjBGdCtvRVBJd2dFWXE5Z0VpeUY4?=
 =?utf-8?B?dUNJaE9WN2NrWUFZbzgxcHo2QUVNVE5KRFZWQlpDbkw1bFNONldyYUZUdGYz?=
 =?utf-8?B?R0N6c1NLcStCWEhXUUNEc3lwVHpOVzlqRVJKOWlnWHBQckFJbHNuY3JqTnVh?=
 =?utf-8?B?dUhML3RKMjZqcnNtYm9xVndTYTQxSG1lNVE2MmtsdlhUdHN4eFJBUzVzR0tn?=
 =?utf-8?B?QWFmLzhnZ09GRGhxYUxjcEp0Qm4wUjVHR3Izb2o4MkpLT0twaS9la29VOHM4?=
 =?utf-8?B?UVlHcEpobDY5ajBCQW5sdTRNQ2lwOFFWcDdYREFIQWxGdUpTcS9WYkxYOGp5?=
 =?utf-8?Q?5x5syKVjjHzgbAQU1NRpExRB2?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: v+rcw8eMO34kUMsQVZ0RF6ro7LeMcfL4uzi6kGdfySHfApPVExQdu5uUzhh+Nw6TNfkQDWu2cy0FexzUlPF9VvyG0/F9KACO/BbOjl5boaBQhxH/dzBOUMzp26hRJyfIEFEIFr6NJrng7SHac3lJk605tSh+8HYBtt4jJIKyVFsxqBaoma0/aP3xRnkgSvhUgkvrUyyD76vb7D5WdgmHH6IJ66FK9emTIFYPZxrJAUAOMdTd2NGwuAZs44z9EVhUa30hcTzIUT/G+NLUJNbJ5jClXgpB/iGKF0Fm7cVUx2nJtp5JIhKOzg9ofcTsH0cFOinjH6QnMgEjvx94kbB2qgUnm4eAEHtqfVhVcal1AxbfOW83xXT4jKTN4LSuivbmsI07+cF2MIsDonSUGrIqnJrzAh7nDlD4wiaFMV3dOmqNxAf7LEoenansHcF9u4H5quHZl7WgnYOmt+4AvA0sW8YPdkTefBfJQiLmT6bS9//b+YdDojJsN0pMircgQ+ThyoU9Z/gZe6dy61PGhIdAGWi+BRMlWTZTisTTmSP299h3jto6nr8/RD1Jq97mh1hzgWgK4UwYZJxDNzLHZmPGDWZ9O23kwszsGW5pXx+8VWc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb74e5a3-691b-4476-30b6-08dd787575ca
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB7129.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 21:20:04.1056 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 59tyiI+SOC7oS7peo8S100IXz7hJvXMkcPri8Ej5SLZ7o6nISgE6jUzOlRYQPFnoVKYyIpjezMbqSbJKcYgVCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7338
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-10_06,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=999
 suspectscore=0 adultscore=0 bulkscore=0 mlxscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504100155
X-Proofpoint-GUID: X0rna8BzvnM1G_VPKbOredBzvotxhtHN
X-Proofpoint-ORIG-GUID: X0rna8BzvnM1G_VPKbOredBzvotxhtHN
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=dongli.zhang@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Zhao,

On 4/10/25 1:21 AM, Zhao Liu wrote:
> On Sun, Mar 30, 2025 at 06:32:28PM -0700, Dongli Zhang wrote:
>> Date: Sun, 30 Mar 2025 18:32:28 -0700
>> From: Dongli Zhang <dongli.zhang@oracle.com>
>> Subject: [PATCH v3 09/10] target/i386/kvm: support perfmon-v2 for reset
>> X-Mailer: git-send-email 2.43.5
>>
>> Since perfmon-v2, the AMD PMU supports additional registers. This update
>> includes get/put functionality for these extra registers.
>>
>> Similar to the implementation in KVM:
>>
>> - MSR_CORE_PERF_GLOBAL_STATUS and MSR_AMD64_PERF_CNTR_GLOBAL_STATUS both
>> use env->msr_global_status.
>> - MSR_CORE_PERF_GLOBAL_CTRL and MSR_AMD64_PERF_CNTR_GLOBAL_CTL both use
>> env->msr_global_ctrl.
>> - MSR_CORE_PERF_GLOBAL_OVF_CTRL and MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR
>> both use env->msr_global_ovf_ctrl.
>>
>> No changes are needed for vmstate_msr_architectural_pmu or
>> pmu_enable_needed().
>>
>> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
>> ---
> 
> ...
> 
>> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
>> index 3a35fd741d..f4532e6f2a 100644
>> --- a/target/i386/kvm/kvm.c
>> +++ b/target/i386/kvm/kvm.c
>> @@ -2149,6 +2149,16 @@ static void kvm_init_pmu_info_amd(struct kvm_cpuid2 *cpuid, X86CPU *cpu)
>>      }
>>  
>>      num_pmu_gp_counters = AMD64_NUM_COUNTERS_CORE;
>> +
>> +    c = cpuid_find_entry(cpuid, 0x80000022, 0);
>> +    if (c && (c->eax & CPUID_8000_0022_EAX_PERFMON_V2)) {
>> +        pmu_version = 2;
>> +        num_pmu_gp_counters = c->ebx & 0xf;
>> +
>> +        if (num_pmu_gp_counters > MAX_GP_COUNTERS) {
>> +            num_pmu_gp_counters = MAX_GP_COUNTERS;
> 
> OK! KVM now supports 6 GP counters (KVM_MAX_NR_AMD_GP_COUNTERS).

Thank you very much for the Reviewed-by. I assume MAX_GP_COUNTERS is still good
to you here in the patch. It is to just do an upper-bound check.

Dongli Zhang

> 
>> +        }
>> +    }
>>  }
> 
> Fine for me,
> 
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
> 


