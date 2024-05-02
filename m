Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC899C4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 16:14:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2Z3s-0006f6-M6; Thu, 02 May 2024 12:13:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1s2Z3q-0006et-Rc
 for qemu-devel@nongnu.org; Thu, 02 May 2024 12:13:30 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1s2Z3o-00067k-CT
 for qemu-devel@nongnu.org; Thu, 02 May 2024 12:13:30 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 442Fi15C002154; Thu, 2 May 2024 16:13:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=UNCImYrURW9kyGaazvVZlT0xEzRhacm1XPdh9dh67r0=;
 b=Ysnl43iXT9iBZbR/Q0EI0OXed2/nI9ieTHylhMOx5lJYEQ6KXsiZJvsgnT81uIG81RPR
 kLZ4TYObRD78x+KCP7cImpGrK/35frQhWslK2r+QtBcA7vBx5BTawX7n8xL6DGUSDvMD
 DFG5Sj9ELF+jvtkbl8EN9bc/x3xWiZkdinEiwWY71pYhKXGluZHZjzkIWATPjaos6Bi+
 oswa3ix8+y3WLnsBiD3WkFjOSwIrj6II3VHws0SqeQKjRVQ1Tb211xcKFKoTCDhAvcG3
 e6jsD3BAQSMDZhwFzKTxOyfAg+fzdvgJa7nwJ4GuwHBRx+4QunKYGad/kYc3VZuuTzPX 1Q== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrqsf614t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 02 May 2024 16:13:23 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 442Fi0at002240; Thu, 2 May 2024 16:13:23 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3xrqth5ks3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 02 May 2024 16:13:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iSu1DF5Cx9YR6VLZAcyybJpnhllTzjQOnPrw/SpBrfPAJ6tdcZU9FRIXYNGAVaV8P0novmCpgHFf72REA+jBLvsW3OeU3b7ECGIu2uXL7WcIRFdSdXSmabSwJq4alC9iNtVCqp9T/VI9rLWhoSootNHqw7zsExvLLM8V4B6xasgMk9GqY2Mz8QwSvMsLRhPNwChdpTW8MgrJUL8JU0b/i9S3srPlaEdYxObN1xWk7juuiifvR08KrVcPNu0sayvCBgZ8kCmcPeN7xFk/2RUVsOI6UTA5fjsA388mpstFBkZpsvaro4/WJfjth+dwAlhbjpjxY4q+pnMCywrDwvxqBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UNCImYrURW9kyGaazvVZlT0xEzRhacm1XPdh9dh67r0=;
 b=KGSR+XUb5WnkAQiwaLxciMbWrBH78oYnIWvdGrBLzIuC0gF6HXtMu3abldPxr6/fUnj6Z0zOFakVNSXTTw7h+18b3ypj0k8T634OvxGUa7n8r81lxmErVBkJFDOnx/BTq9j48pr8lvCW6NzBL+hvvnPoyqGyNI9TbjXwJuzv7fcvuvsa0UPInE9nR69uSNGVxhvFi6p4zeoUgTSqBVKMtLEyIUpIwX6gElnSIfOc3cwoDAu3pSncMvqpbywfpQ10BTB5IRYE6QPdV40MAClOpUgRYYSWtwfNxkvyA3ZYx542QTvl4yiDf0dKXq8/v9V4b2QyFU/R4hr/mSimo+iF8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UNCImYrURW9kyGaazvVZlT0xEzRhacm1XPdh9dh67r0=;
 b=Yx+erLn0K5GMdok70rUarkV0MWGwvM3T/AZ/CDCQO4fIu1/HBVqA+lohnLFlCsOsUYcSuyzFLq0pK7oj6moPqZiBVIKkfYhgSCHZXJzzNK5X/lclgLAoAQGCcqiZ+BJdFpkMMyDPe+36RcRN4gGSbDxrT5q4+pd07QF7txxUmao=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by DS0PR10MB7294.namprd10.prod.outlook.com (2603:10b6:8:f6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Thu, 2 May
 2024 16:13:20 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::e06f:6709:57b4:91a2]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::e06f:6709:57b4:91a2%4]) with mapi id 15.20.7544.029; Thu, 2 May 2024
 16:13:20 +0000
Message-ID: <19796c1c-4832-47f2-a221-106ae456b264@oracle.com>
Date: Thu, 2 May 2024 12:13:17 -0400
User-Agent: Mozilla Thunderbird
Subject: cpr-exec doc (was Re: [PATCH V1 00/26] Live update: cpr-exec)
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <1714406135-451286-1-git-send-email-steven.sistare@oracle.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <1714406135-451286-1-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR22CA0011.namprd22.prod.outlook.com
 (2603:10b6:208:238::16) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|DS0PR10MB7294:EE_
X-MS-Office365-Filtering-Correlation-Id: c7a699b1-1746-4b8c-f7a2-08dc6ac2c8b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|7416005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VkRBODdKNjBxQno2TCsrU243dXZmeHE4ZmZNbEloeVh3UFVUbVhvdldmcG5h?=
 =?utf-8?B?UXREUVI1TGFpc3V2NU1xQWZyaHV5V1V5cjhISEdwVk13dGZUV0NidlRpTEQ4?=
 =?utf-8?B?ZExpU1haMVVjZ1RkeklLcVRpREdRR3JXS0VVS1NockVucldNMUpYclEzcURz?=
 =?utf-8?B?Tks4bGZEUnlCSjl4dDhESnFTQUptTGVrSnVoQmtIYnplUnQ3TTh4Yjd1TnVz?=
 =?utf-8?B?U3N0YXdFTW1GVHhwN1BxWlpkMTVnZW1uNkZJUUhldTdGeDhtaFZBRTloL0hz?=
 =?utf-8?B?c0M0NG9MNGtxL1NGR2xQZGdRRnlnLzZra3FEYkJaQUtkVzdxTFM4SVhqRmZV?=
 =?utf-8?B?aStpQnVON2R3UTRUQmI3MTNLcXRBUk9SZnVHSk1heU1STDVwUjU2bHIzVTE3?=
 =?utf-8?B?UWFwb2ZrS0liamxESnlhb1JLSXVNaTJ3WXorcGRXUTMvTjJuOU1WWXBEdkRt?=
 =?utf-8?B?TG92OEMwRi91V09PY0lkblM5aXkxdDEvZE0ybDYzWHZycTAwbDdzWnNhN3ov?=
 =?utf-8?B?R2hySG1Tb0Y5Vnl6WWdsMlZ6NnR4Nlh1aGh6RStMWG9TVG81T1NqMzNwZzFG?=
 =?utf-8?B?MkZ5TER6VERMOFpaRnFlZSsrNkZpTGV0OXdTbHFNQUdxSFQ1ck1VQzRiMW9T?=
 =?utf-8?B?WUxURGFQc1NpU2pTcHIwc2dVMzNWVWhHK0lyRjIxaXNpK1l3QTlXMzV3MFQ4?=
 =?utf-8?B?Z2NaOWRWVXRXcEtvNmNDdUlIR291cWNXak5LWU16SFNrNEhjY3UwdkVZcDFX?=
 =?utf-8?B?WXRPZVRzSWJZbEtiblFDc1phaGtBL0NxYlVFMVFzaUs3R3BBWHVRN01wNkN4?=
 =?utf-8?B?QUlWbjFyc1hSWTUvMmZHUU9pMTRHTjV6bEtiQTlPM0g2TG5STm9GOGluOCs5?=
 =?utf-8?B?eEFTUTVkUms2RGVwZkIrcXhUci9WMHRRVnIyc1JqOWtja0hXbEFlSU1JQ1hJ?=
 =?utf-8?B?NTNoc0xFNTNYS2lkNEF6ak5OQmZKTFcxZjFTSWNaZXhkcW9qOWd0djQremtp?=
 =?utf-8?B?a2RmUEpwQzBCODZrTHhyZXo2UElBQWZOZFVsNDdURmJ6amlIOFByM1BrVks5?=
 =?utf-8?B?b25FQlY0RmE5Mi9QbzJKVnBySjA1Y1l3Y291U09SREhmbDhtaVBSbUNoZkNz?=
 =?utf-8?B?cFlXQ0w3bDNyb2JuUVFrM2ozL2s4RUR5U0R0YXBkR0VBdkhFbDhzS0dzbjNN?=
 =?utf-8?B?NzVZUUlicGxUbEZsMldHbHJ2UGJwUnBVN01xQVlHdWRQWVh5N0xkOTNKbmtv?=
 =?utf-8?B?ZEU1YzdPUkJDWG5LZWVDMFpYbVVIdnpQQ29FVmU4ZHRpUHQ3a0plS0FBa0o4?=
 =?utf-8?B?WlEyOERHaHZhR2hlZDV6YW1oWDBBQ0h5UUdFRjZ3WHByM05HKzJVdkhLbTgv?=
 =?utf-8?B?K2JWSXNMY05yQVhzZXlXSFh5WlhYQUtkd1cwN01DVStmdG5EVExFdVNkaVFj?=
 =?utf-8?B?Q05iU2p2VkFZSE9HQkQzc2FxOFlIeU5TaHhkMGRZeWFqL0lsb0ZsdTdxdm1M?=
 =?utf-8?B?d1hwWjlZK0ZQZWgyYWVLWGwzRWQ5RWZnTGthTHVJNFpzaWIyTjRBVWpreUJw?=
 =?utf-8?B?NmNPTkp2NjkwSjFoR203N0JXdVFTWm1leWpqNDl1TTR6SUJRbUppMWhuNnVs?=
 =?utf-8?B?bDVqdXJOZlB1b0wxdmNXcVNGcUIyL2RxQ2JURlVFUjdYdWs2ZTZrZlZwUitJ?=
 =?utf-8?B?aHo3bm9wdVpwSzMzSWFjVmhaaEg0RldwOWxsQVZ5WFZuSm1XMThKblF3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(7416005)(1800799015)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dHJSZDJGb040ajlndTN6RWlVYW9ObHZCalprN3VpUFFCaHVnZElaMGtJbVA2?=
 =?utf-8?B?T0F3VFViMWVEUDdtc2FRQ3hxckpJUzlnSUovUXhEM0swQ1hvODBUYXlqeVZX?=
 =?utf-8?B?NmxFOGFiNmFEMVR2VzVtN3B5MHZDRjE0Q05jcVJTcUNzRFdSS0R3UTRQdFhN?=
 =?utf-8?B?NzhLSi9SMkZLdjNiQmQ1UGUxYk5HOWJ1S0dlbVQwSFFKckVqWjF3anBGNUtw?=
 =?utf-8?B?MEhJVE5ndkdwK0JQYjRMK3RWNzJzMjYxQXN1SkIzUysvSjF0ZkJ5UVZWVHVi?=
 =?utf-8?B?V0ZiNWN5aEV4THpJcHYrM3ZiZEM3VlpCQWdoWkZqQ3VaYVdQNTBNR2tuZ1pN?=
 =?utf-8?B?ckNNNWk5OXU4VW55NngxTHpoei9NU1BQOGtiSi80Q0FySFk4SmpYYVZYQjJa?=
 =?utf-8?B?YzFlU0JMMndIU2owMjk3UC9FMlFseG50U3Vmb3g0UGwreEJ1M0UwSHpXL25H?=
 =?utf-8?B?a1pjZzB0RFhhOFNROG40dVUzR1pONkxKM3JHdlZMLzFsL1V1Vk0rYkJoOWhS?=
 =?utf-8?B?QllzcFVmSUovc20yVnZlM1B2R1FpVUdIN1hoMFZXc1JtWTQ0VFNuWUNhTnp6?=
 =?utf-8?B?RitVS3h4OS9yNXB2UWZ0eEloYVJ2dU5VM0hWMnB5angzVUFDNWs5Mkgrd0pP?=
 =?utf-8?B?eEw4SlB3SGovU0x6NHZxLzlieXpOWXJ4K0tPazZEcytVWnZUUjFLbnVGMWwv?=
 =?utf-8?B?ZXhsTC9iMXo3ZHpMVVdGUC9pUnlpcXA5U0F5VDRDNmVjNE9DRmh2RkV2UjlE?=
 =?utf-8?B?V0JOTWJlVmNyelRkM2wwQzhveU1JdC9yN1QyTEpKbEVNZUFQRExRWitab2NX?=
 =?utf-8?B?RlpCYUxDdzZ3L2hKY2U2UDcrQ2lIODNEbXR3dmxURW1yZ1ZNR0ZyWjdQTEw3?=
 =?utf-8?B?dFNUV3UraWxsaXd1ZTRRN2c2MGVBeHZ5OHZGZHMxdGxHM3Jqa2FSbmJxY2Nx?=
 =?utf-8?B?SnZ6a2NoaUkxaFR3MnEyTjh3MzlqUVE0Z3B2RzJwR2V3TnRFdmlzSEZTVDkz?=
 =?utf-8?B?c0xoR29TNTVVTllwYjVlOUl6UE1jMEhDaVk4ZTRIUkYreVVrcGJkTk50V0FM?=
 =?utf-8?B?eGZyMUhzbWdPNTZVWG1CbFFyZzlqNXY1QVRHbEpJZGZFQm1DY2hOSDVPS2t4?=
 =?utf-8?B?b2sxdTM3NmhVTDltVE1EeURuMmVDQjdWOXBuS0VzU1dKazgzL0dEVnNaU1NZ?=
 =?utf-8?B?cVc3bWtZU2pBNXdHSHVDWmp4UFhUbmhOK2sxZ1p1b0pqVXdybDlBTzdzclZh?=
 =?utf-8?B?b1BJbVZ4Q0JsSDlkQmVQNVhON1lPd2g3WEphN3hoTXYvY2lzYXU3QlliSTlv?=
 =?utf-8?B?VjNTcThoS2MzL2o1aG9zZm4vMkNKY0RpY3JWZE9rWm1NdkpFUGRwV1JyUlF0?=
 =?utf-8?B?QmZHUUVEM05GcHNLQmVESUw3ZjY0UFVFN05xV0ttbmJ3WEZMK3pBTFhwb0Ru?=
 =?utf-8?B?Q3VQMFlJS2ZRWHk0OWtFMFRVZk54R3pzOUJwNnBGdTlZWks3bFpQaVdBNTNF?=
 =?utf-8?B?Rm54UkRnclFwNWVGNnMzRjlicmQ4T3VMZ2FmYkZIdndsTmV4OHpDY0ZYcEFO?=
 =?utf-8?B?UWZjcERVYUZUYTBEbFFmM2FmSElkWkJ3eVNEYkltaFpsRnd2MmxmQnd0LzRm?=
 =?utf-8?B?bG5tamZhaTkreUlUN1hzREQ4RmhZc0YyV1JxbzdwTkt3ZzI1Mzh6N1FvalMy?=
 =?utf-8?B?WS95blBHci9LNHpvVTlzU3I4TkJOZ2pGMURWTllaWFJEc0U5RmtNcU5aTUo4?=
 =?utf-8?B?K0w2ZGp0RXFBSnRJQWtzbmlVR1JXU1pWKzJBM21zMENuUHNwZkJad1grNXFB?=
 =?utf-8?B?WVNlL1dkdWUwalpCcFM3enRSS2t0bUJMM2ZUUDQ2Ti9vZnBXSHJnWlk2dFY2?=
 =?utf-8?B?T0JhZjh6WWt5Wm5LNDh1RmxwN0ZCTUhKclNIdER2MmdoYU40aStZajZNYk1W?=
 =?utf-8?B?bkV2VGlnMmhRK1FOaEhaakdQNlFJcnB5ZCthM0daTVdYNXNzQ2RFRmhzcHF2?=
 =?utf-8?B?QVJ4SnVKcWVZUFkzMmdGdkVEOXl5YndlYjNzZ3NESkhnVXpjVW5ITmFzMVZ0?=
 =?utf-8?B?NUY1S0I1SXJPMzd4cDFWeUJ1VXpwc016YTBLU1dPWHlWYUIzOXpjeGFDTHJy?=
 =?utf-8?B?U0dGQWpjUWJYbnlvbXB5cTE4VXRqV2NZTXBzZnZXTGpkTlJyeFA0VlJ1YWRu?=
 =?utf-8?B?TFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 8fni77qqPo5gpxUzw8CHMHvCB5hWXiNVtKyxXeu6czIZ3XhXVTsiK0Xz6HiE2A6wiOla4HRnw7+RTLrxWktIONSoXVXTUUdJq6sYSaxeiAAC6SzopGiaVcpEtYQ8GQoEGPll8LlNb+YGIGt87+zHJy4a3gSNpho0dP/gX6VDTEEfSVGHeF0MW4zewgRGiWM9GugSDs4uLOqvCfoP9L1r8S7qwMOnphIytUL9jO7i99UR+pe0S5D1j5ZkrPSWg7KI1PwKWVEXgmqHUOcv9cj4nlMSszZLltuHS2T6GodWNlz/LjxXjqX5NV7Xz1e5+Tq1b3oc61O5LrSQiHAJnNmDW6JQIbOpzNeQ2vgWZsqhxsv3ElsV2sauJxSgRqlY1jxOn5Ol64vKuZWCod8DSYwgVWWzWNuwwrKQEqRdHw9u44NjcdbN2qdUpxWZYCCZpGxYOSr0nzdik31EVCilPH38HoJcAcrpBMDsSji+zzPD7Cvi3ikOi+WjUDMJga/NM66UEozigugxhbM19EPQsterUylGjTrVd2A85HkgUM1R5k3WzsvPpIROD6g/1m2wOJHO7To7Z9Gpc1veL3JHuAGNrCsvnwh9ZDtiEVYcUE1Uzsw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7a699b1-1746-4b8c-f7a2-08dc6ac2c8b7
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 16:13:20.4933 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T4sh4/a/i/eOdmpwcoC3Gb1GaCf3s4UuWt85ubY6f/fwr6q8cbNdxPs6wXutqX/8xNCWbLN3tRYyZmA/p9cxYtydf6RB5LiY/CF9csxFMN0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7294
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-02_05,2024-05-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 malwarescore=0
 phishscore=0 spamscore=0 bulkscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2405020106
X-Proofpoint-ORIG-GUID: 9ULnwxb_IM9gQooRgzlRdFID8jBGdySx
X-Proofpoint-GUID: 9ULnwxb_IM9gQooRgzlRdFID8jBGdySx
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
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

On 4/29/2024 11:55 AM, Steve Sistare wrote:
> This patch series adds the live migration cpr-exec mode.

Here is the text I plan to add to docs/devel/migration/CPR.rst.  It is
premature for me to submit this as a patch, because it includes all
the functionality I plan to add in this and future series, but it may
help you while reviewing this series.

- Steve

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

cpr-exec mode
---------------

In this mode, QEMU stops the VM, writes VM state to the migration
URI, and directly exec's a new version of QEMU on the same host,
replacing the original process while retaining its PID.  Guest RAM is
preserved in place, albeit with new virtual addresses.  The user
completes the migration by specifying the ``-incoming`` option, and
by issuing the ``migrate-incoming`` command if necessary; see details
below.

This mode supports vfio devices by preserving device descriptors and
hence kernel state across the exec, even for devices that do not
support live migration, and preserves tap and vhost descriptors.

cpr-exec also preserves descriptors for a subset of chardevs,
including socket, file, parallel, pipe, serial, pty, stdio, and null.
chardevs that support cpr-exec have the QEMU_CHAR_FEATURE_CPR set in
the Chardev object.  The client side of a preserved chardev sees no
loss of connectivity during cpr-exec.  More chardevs could be
preserved with additional developement.

All chardevs have a ``reopen-on-cpr`` option which causes the chardev
to be closed and reopened during cpr-exec.  This can be set to allow
cpr-exec when the configuration includes a chardev (such as vc) that
does not have QEMU_CHAR_FEATURE_CPR.

Because the old and new QEMU instances are not active concurrently,
the URI cannot be a type that streams data from one instance to the
other.

Usage
^^^^^

Arguments for the new QEMU process are taken from the
@cpr-exec-args parameter.  The first argument should be the
path of a new QEMU binary, or a prefix command that exec's the
new QEMU binary, and the arguments should include the ''-incoming''
option.

Memory backend objects must have the ``share=on`` attribute, and
must be mmap'able in the new QEMU process.  For example,
memory-backend-file is acceptable, but memory-backend-ram is
not.

The VM must be started with the ``-machine memfd-alloc=on``
option.  This causes implicit RAM blocks (those not explicitly
described by a memory-backend object) to be allocated by
mmap'ing a memfd.  Examples include VGA, ROM, and even guest
RAM when it is specified without without reference to a
memory-backend object.

Add the ``-only-migratable-modes cpr-exec`` option to guarantee that
the configuration supports cpr-exec.  QEMU will exit at start time
if not.

Outgoing:
   * Set the migration mode parameter to ``cpr-exec``.
   * Set the ``cpr-exec-args`` parameter.
   * Issue the ``migrate`` command.  It is recommended the the URI be
     a ``file`` type, but one can use other types such as ``exec``,
     provided the command captures all the data from the outgoing side,
     and provides all the data to the incoming side.

Incoming:
   * You do not need to explicitly start new QEMU.  It is started as
     a side effect of the migrate command above.
   * If the VM was running when the outgoing ``migrate`` command was
     issued, then QEMU automatically resumes VM execution.

Example 1: incoming URI
^^^^^^^^^^^^^^^^^^^^^^^

In these examples, we simply restart the same version of QEMU, but in
a real scenario one would set a new QEMU binary path in cpr-exec-args.

::

   # qemu-kvm -monitor stdio
   -object 
memory-backend-file,id=ram0,size=4G,mem-path=/dev/shm/ram0,share=on -m 4G
   -machine memfd-alloc=on
   ...

   QEMU 9.1.50 monitor - type 'help' for more information
   (qemu) info status
   VM status: running
   (qemu) migrate_set_parameter mode cpr-exec
   (qemu) migrate_set_parameter cpr-exec-args qemu-kvm ... -incoming 
file:vm.state
   (qemu) migrate -d file:vm.state
   (qemu) QEMU 9.1.50 monitor - type 'help' for more information
   (qemu) info status
   VM status: running

Example 2: incoming defer
^^^^^^^^^^^^^^^^^^^^^^^^^
::

   # qemu-kvm -monitor stdio
   -object 
memory-backend-file,id=ram0,size=4G,mem-path=/dev/shm/ram0,share=on -m 4G
   -machine memfd-alloc=on
   ...

   QEMU 9.1.50 monitor - type 'help' for more information
   (qemu) info status
   VM status: running
   (qemu) migrate_set_parameter mode cpr-exec
   (qemu) migrate_set_parameter cpr-exec-args qemu-kvm ... -incoming defer
   (qemu) migrate -d file:vm.state
   (qemu) QEMU 9.1.50 monitor - type 'help' for more information
   (qemu) info status
   status: paused (inmigrate)
   (qemu) migrate_incoming file:vm.state
   (qemu) info status
   VM status: running


Caveats
^^^^^^^

cpr-exec mode may not be used with postcopy, background-snapshot,
or COLO.

cpr-exec mode requires permission to use the exec system call, which
is denied by certain sandbox options, such as spawn.  Use finer
grained controls to allow exec, eg:
``-sandbox on,fork=deny,ns=deny,exec=allow``

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

