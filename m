Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C43EC87FCB
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 17:02:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiyaK-0006Ch-9l; Mon, 04 Aug 2025 13:02:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uiwp5-00035W-4V; Mon, 04 Aug 2025 11:09:59 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uiwp2-0007pm-Kx; Mon, 04 Aug 2025 11:09:58 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 574D6Wpw026244;
 Mon, 4 Aug 2025 15:09:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=Mbkx2YZGHvr4chco/NDSJXYHufPAKmsIQEw8QvvT47o=; b=
 l1FvNNuKEJnoLAt3jLF6cuajvKUVyekKt72neeQbrtOu+zdxnhJbGIwme8dVQ4+l
 frAOS2bFQv5WEQEjG7Qnk326sgkWle0XXqQRlZPYVHUjBbhOjwUd6C9MgkNZ5va9
 m0LiPmR5STzj4xUWqlWmV7Z2X2uov0/SZQk0cYYJKXGkgoDbL4XHpujzdp2y4izb
 bYGNlaLwuFwmrhVOC37rYpRRTMKiIv0XL3kEF1XIVnOI2ieOG9b8tYmDhes56Qc5
 TVx/XA5lX0EvoAQHeYtIfrssnt8if9fi5JhSYgsBDfd7gWxup8lXgDDs+udutt6G
 7Np7SpP9U4NooPQaF4imPA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 489a9vtsmn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 04 Aug 2025 15:09:52 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 574EUu6P025479; Mon, 4 Aug 2025 15:09:51 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11012060.outbound.protection.outlook.com [52.101.43.60])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 48a7jsh8m2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 04 Aug 2025 15:09:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E+PjGSWSecosdnNBMulTjKcIQ2p+bpE0BZGQEIVqxr8lfxi3Fwxim/WCCmXLnNn6PVNqXYaE7d97ZXtCWfGbwPa4ZudIec83DJ2A6D7ZY4MOdBKDKRLGqIhsHF4CtxkGJ3MvPTseIoZaAGvncvCGTnJSHNZHukgIvHcd5hsIbJUxGffBWwDn5kss7iQc9cGGR4mQcxFbrd7eGXzlb7wgjqucqUDidd9vXzS8beBi3LmfSu8xVx88bfwDp3lRmTpm9DmJNZK2T+yCxf7h1Gim07i2mTHOZZAItYEQgGWrgwJH0QNp1qtZyXtU7oDApWL1jHoJaxA0LgRd5gKZTYrmSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mbkx2YZGHvr4chco/NDSJXYHufPAKmsIQEw8QvvT47o=;
 b=Y9WjNMeaIdH5PSRlfh4KRa/4/TiR7i9U6K4F93upJuSKazTAg2YfGavTB6QOtOIXEGP4gCMGj5Q1Z2GTPSyXOcXlMUaIhXcM9K89sEExp7lAZoq2lQSBMjoc+uhF8FscqcGE4vfTJ++NNT2zqcrrS8szOlzAn0sDsppBs9EzFYCikg8A8oMGqOH3Q0ghgBbrgVnrH+20zWUXpI4KEBRG1dnlqihuwT9L/qxt1Hh/lP6lH8enbKzwI5UrsLKTsDFPK4xwcZwKJvPsCWgrrseYOscEr4FwOVODagiqdJmVh3QrpmRQ9cSDLtuync8qtodFnOFDqknJ5L9n0faQIryZwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mbkx2YZGHvr4chco/NDSJXYHufPAKmsIQEw8QvvT47o=;
 b=U4KHBiuWBDc3kBe2r4OlEIGVotHSLCxYR1yXxFqgYvMfyOMSRXBhgk0QDXUPtkySQOM+NdWnCEH4uQ+4+pU+a+EhzhVrbpAJUncSQpjBzpyxgs4Y2FqYmWLJNQjQhg7fQr+ezF3h9vPrk5qWuy/B0fjFzuIwsO52cN4Soqa9FjU=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by IA1PR10MB7288.namprd10.prod.outlook.com (2603:10b6:208:3fc::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.17; Mon, 4 Aug
 2025 15:09:48 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 15:09:47 +0000
Message-ID: <4c6c57c6-fe7d-44a4-a875-3ede9e0aba58@oracle.com>
Date: Mon, 4 Aug 2025 11:09:45 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 1/1] hw/intc/arm_gicv3_kvm: preserve pending interrupts
 during cpr
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Cedric Le Goater <clg@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>
References: <1752689274-233526-1-git-send-email-steven.sistare@oracle.com>
 <CAFEAcA8P4H7n=uXe3qredxVMwB4QtDfZtVyuuTWBLwa6enGR3g@mail.gmail.com>
 <63d52f3e-5d29-45be-986c-3827a5c0cb5c@oracle.com>
 <CAFEAcA-TsQdFt7S=qyd14gxW095t=Nx2skaxnmxtGUhR9pubtA@mail.gmail.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <CAFEAcA-TsQdFt7S=qyd14gxW095t=Nx2skaxnmxtGUhR9pubtA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAP220CA0008.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::13) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|IA1PR10MB7288:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fccc494-c2f9-4b1a-6359-08ddd368f3a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VENhRWdFT1QyTFFrdVBCOWY0MXFtUnJ5QjRXZS81SDlVaGRnNVVtbGtlU1hI?=
 =?utf-8?B?bEgySW9SYzRjWXBCbGZEb2ZITkZvZUREemNNTVd0ZzF6cHNDY1prR2Fxb2lm?=
 =?utf-8?B?SHlhUmkyTEFMUFZhN0xBb2dZNmx2SXhCSml6SzMrTVNUbUZ2bjJPNVhOSHAz?=
 =?utf-8?B?eit4ZU1jSFZraUpFeUsrK0syVm56RkNHU0ZwZDBWL1haTlFtWXFRbll2NHRO?=
 =?utf-8?B?ZERZMVdVNVlndFRpRHlHZnExalgrblNuQWFPdWY5UGY0R3J2djBuVktHQyt2?=
 =?utf-8?B?enpDYzBOajlLcVB2Y3JTamZIVXA5R0liM3JlSlllZmlLNFhKZmM4ZSs3UlRy?=
 =?utf-8?B?ZlB2VklXYWU2MTdlejdDa0RKY3pha05YSDRxWXorblVRTWdqQUw0NG0xRWds?=
 =?utf-8?B?Um9pNmpQcmVURlhtN2FlK0lHc3R3VjIvNXpPd1pTRXlVdVRndW1McnQxK2Ja?=
 =?utf-8?B?RURZL3NlblpLaWcvN2FJb3o1Ym92YU55VGw0dStJcmpHSFpVejhPUWhjRzRr?=
 =?utf-8?B?VkhnWUt1UUpmZThBUXNncE8yNUpFcklVWm53elhDN3ZLbzZ6QU0yMzVCd2tm?=
 =?utf-8?B?VGZIWGwxWnJnSW1zd0Q4WTJackVmM2hPdHFFc0U2R2dEcDRSdzJpaWFRSUJJ?=
 =?utf-8?B?dHV5RHh6dHl4elBYem1COVkydWE5aDNFbjhmUHdWN1Z3OUhpTVh4R3l5aXVO?=
 =?utf-8?B?WHhqNnFGNlVaRFpwSE9oNXlRT3BESDZiTUpkOUtIL0dyemRLVVFtbWdtZ2x6?=
 =?utf-8?B?clEvcDVjUElEeW1yb29qekNmQVVQQUNWSjAvQXRuVnhIS2k4QUswakdlRXFa?=
 =?utf-8?B?amZVMlkrNGhnRU9zOXN4djVXc0RQc2dYUTVKTXk1ai94b2g3MENuUndjS2xm?=
 =?utf-8?B?Zkh3d1ZlMU9aR3ZsUFQ0NHBxbXhGVy95UGZCSkJUOFpTZHUxMWt1UGVxTVNI?=
 =?utf-8?B?WU5NQTREYjAvUXkvUHliQlNiajBmWmxLU1VSWFpzcUdEb0JCdkFtRENhTmQv?=
 =?utf-8?B?Z1JYYXQvakVjYVdJcE5Ea1J3Ni9wRi9sbHExcVEraGg5LzhySnZBVWd6L1dK?=
 =?utf-8?B?Zy9iSTJUOTBWRTExdkRLSEV2QVZQRUlkK01PTndFam02bkVBOEI3b2tvK015?=
 =?utf-8?B?bERTSmIzTU5BcWV6L0lqc1pndmhQREZBL2J2SU9GdW1BNFI1cGt4dkpXazc3?=
 =?utf-8?B?d1NkK0tueHdCbWxVdnFrMnBITTRYcTU2REFmYUQ3UWIxSE8xWWpUaVV5bXRa?=
 =?utf-8?B?MXNybWUzWDRDSEp3bk5zay9JNmhBNHIrYUpxT0FzYWppVkV6cGZLZENhbUpk?=
 =?utf-8?B?emlmSmxBTlhLR3FzUFhTcDU1S2JWT29aTDhISmpyVmRoTVFMdG1ZYk9qZ2Vn?=
 =?utf-8?B?Sm1oS2E5aWQ4cXV5S0oyNzlGNSt3RmdaOVE3THhXcG9XQ3VtQ2J3a09wNXJB?=
 =?utf-8?B?RFQ5c1QxOEYwYTR6Wk5UTHd0K2ZkZDZVZ2V2WS9IalR1RDNFdGlHZVpLZnQ0?=
 =?utf-8?B?ZXlzTmZrOWY1U09LbW9DelczdkhLODh5c080bmEzL3dFam1JS2FVS0VxUG1S?=
 =?utf-8?B?STdMSEJEaWRsc2JPOUdlL2ZLck0rdmt6VHNkVVVGSnpKRXNsS295ZGQ4cUZS?=
 =?utf-8?B?aHZqZ0YwSzlIc1Zlb3UwdmVXS3ZLcmo5Y2dKRzczZFdFQ2FKaEVod1JMN2pU?=
 =?utf-8?B?WE9CV0twek1BQWMxYm1kL0lNMkU2eVN4NUp1NUpIRUJGMnNsTFVhUDA0RjJt?=
 =?utf-8?B?NnNCeVFMT2twUXl4MUloOUFCdlhTU1lEYnZHbVlmVjY2cWhJUHVEeEFFRVRB?=
 =?utf-8?B?aUt6Nm5qRUMycmpZS3FyTVpZYndmVk9ka2pMZk9tNkllVEgxc3RtLzZsaXhG?=
 =?utf-8?B?TU9mQys3MnkvOVFGaDhZRHNKUjN5cnNLWG0yOEV2WmttREFvUjJQS0x5ZjFo?=
 =?utf-8?Q?nJCEA/d2Ml8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1pQU3BCM2lUODI0cGl4LzRvY0oyV0NJN3RndFZlR2hBZ3NqbjF4YW5nWjVK?=
 =?utf-8?B?K0tsbk1rRFdLb0J2VHlkTmlOLzdhQXl6NGpaVDFIWkpDNDRtRzBCd3VQTGQx?=
 =?utf-8?B?azkyeFgzS2Y2d3lFQ29KN1VzTUZtNExTWTlNWGx2L1IxVTRxTHoyT01lVnBq?=
 =?utf-8?B?U1RGRjZEdXNuUGV6ZkNqQXRHWTRYV2EvczUyYW1yU0tXM0NrbEIyYUdmeURR?=
 =?utf-8?B?UThUaXgvRm4zcCt2YVJtWm9jb0VHL2tGZjBRaFg4TVp2ZFhUR3dBWEJaeUtD?=
 =?utf-8?B?b3JUWGFnMmhoUWJVM0JWRTBmZkZLUys2cmN4Z0Z1K05nZVlJUVZ0Y3ZKL2pa?=
 =?utf-8?B?ZVpXR3NBblhCNjV6K011cXpHZWoxVUJMOVNmVFA0TWZVa0Y0SUQxamtmUXha?=
 =?utf-8?B?eWx3TlorZjVKTkhqSUVMYUozWTNTUTZsL3cvamQ2cVJiUXZwR0VFU0dPZDdm?=
 =?utf-8?B?VkQvRUhiYW5Hb3g0SWl6VEh2NVJYMklGQWZiR3E3cFErT2NxL3BkZTltWkZ4?=
 =?utf-8?B?QnFmT0l6a1pRaTlOYXVSVTQxZFBkSkpaOW1mMmw4WUdUOHEyUVM0alNDOCtC?=
 =?utf-8?B?bjhIaEhpck4yQlRkY0w0OXg1SXBHVzROM2ROODVRT2orbWpmV0hkZTc0enBN?=
 =?utf-8?B?Sk8vcTdaNEprakMydy9zendySGxRdUU5Y1BwYU9iYlNYa3d3K3E0YjFtVVh5?=
 =?utf-8?B?U3B2Mm5samFtbXFvdGQ0U3NDT1NuQk83bU9aYmE5cW1UQk12TGcyaG15Rjc0?=
 =?utf-8?B?NEp1OG15elN3Skpqc2xZL2hHbWJOYVM1YVhnYzB2S0ppSzU1UEJxKzJ0dlNU?=
 =?utf-8?B?U1BjQURJdUpJTndaRktuaUtBL0l2Uk8zTi9CL0UrSThoTGs2RlBzS3RXU3hH?=
 =?utf-8?B?THdVaFNNUFpLMTVGUVBxWUNMRDVZS2FYWGlXYmVlOStLYjBrVE9IOVRpZVR2?=
 =?utf-8?B?SXRKRUhsL0ZpTkxLbndrR0tMQnlvajAyK2FvdmF6eW5QTmJSTFBRTlAwbzV5?=
 =?utf-8?B?R1dZS2Q0SHJHVDhaZ1gwV2RlYlVHcHF6TktzTWcxZVN5bzNRRGtTNnZhTHha?=
 =?utf-8?B?bjRuUzlKWU5wMG1OaDUvVFR4MDk0SUFTWCs5L2dRNjRlRUtYVUF0akZrRmFs?=
 =?utf-8?B?bDhvY09hSlpVekt0a2orYXdOS3FaL0dFZ0JZMlo0enVtWE1ZSHNBaGZHd1ZI?=
 =?utf-8?B?d2JlL3R1bndTeFN5TkFIeUpuOS8vQTMwUHQybGpjd1MxRmttZENZSGdjcUIr?=
 =?utf-8?B?ZUFEZ3U1YlR1QURBSGw2U3NCYUpGQnV5VTJqYTVFOXQrdnZ5SjVQcTVRZ3Vo?=
 =?utf-8?B?ZnVWUDBuZXkyUFBacXp3RjJOb0x1NGxGL0JOWFdqb0Z6cmkwSkJvWXVsTTFQ?=
 =?utf-8?B?YllIY21UQXZwdzdZdlFCQ2thcjJwS2d2ZlpQUjVXbGxsMTVtSkJjSXVqbzZm?=
 =?utf-8?B?cG5ZSVNUOHFsR3pFQkx2djJrVk1LeStvSVIwTjZqREVUS3lVNk1UQWVHQ1V5?=
 =?utf-8?B?WXdPQzZSeFRZSHpSNk5SNUNPbmdUWk93d2t3YXNSOXF6OUlyVUlvMnFYc0Zn?=
 =?utf-8?B?Tzc1Nkd4ZDMwQkdqWUl3TWlmTnQ2SG9EbzRKdWZaOVUvTEVGamRydUVXTHFO?=
 =?utf-8?B?Qnpicnl0T0RtUThBYnhuK2dxUGRJVk42SjZtcmE1TllSeFFENnc5d2Uya3dr?=
 =?utf-8?B?VjdrZ2p4Ym41L21VT2x3VnNKd1VRTHo5blF0WW5CbWkvYXJzRWFTUUxxVFRo?=
 =?utf-8?B?Wklzc2hGOElDUmQ2NVBRQ2FNL0p2ajNSazZXWUdKZS9DekJJVk1OMkVIQ3o1?=
 =?utf-8?B?NmZ6Q09XbTkyRGRDUjhnWnFPZ3hINGhHWFFNS2dBa2FLamlVOHJJUnBBcGhX?=
 =?utf-8?B?M2d2Z3kvblNaamlpOVJXN3JaaGlId3pWMWRtY1Y2cWdrdzlRZlIvNmdLSEdk?=
 =?utf-8?B?T2krOStYS01lZFpsaGpYRWVWVXZHUDdQb2Fqb2oxMWRQWjNEZjFjeCtWUjky?=
 =?utf-8?B?aXFFUmZxSmlFQjM4ZS9MYms5NEpyZThIUlRnemxoMnZkYjgzVTVFWXZjT3lU?=
 =?utf-8?B?OFFtRCtrR1h5ZlZNeDNqakJNbk1rQlRZcUJla005SXBVTFFLdjd0WjFwNlhz?=
 =?utf-8?B?dkRqS053VHczdDZUMFNLWndLcEhmM3JXNzRGeXlBK1JianBTai9JaDJzQjZq?=
 =?utf-8?B?aVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Kanvfagd1etyAMrhpTRkjsYd9MShj1B26FyAUuea7xjtH0SzPlEyBw4iAZA1ov1aWs8UmyPo7U0Rmqp4W2xko+OZmpfAG5VBoCGgmgEW2cIpEEY/UbYs7s9ByXWcft2cjfg9sJ5tA1gitjZUDjlX0GgKJtmx2yjBDw6ESlnNKfYUcmjhSy4cAwUiRDWLCXj3JclNbiREjXsTISS0QgdWsyykuRETNZRCYA8jTa/Gdwff3e1+/ChvXZSxdoeCl2qxsXtfmR8g6JGRZTrIJ/zRV7ALdMFy0jNKD0nrzANYjVy3VNmeUp3lVTFAP9IZ1CtkizZYJiCUWyZfr6kVZZxqLkx7KJIZc7j2/7aWzVOoCr1/TguDyvUombKit9R5o1Lr0Hz6qcgBUtneKSVe1H+o/Kc8KLpqWlNT0aks9wLJLOxfmHotxpqsZzqjAHPI0hTkCOuhZ7UBc4eVCDeoCnKuN+So2rvuhClYi49h0eQwywKGkpA6hAaMz1GQ0Ox4dM9p5dbvR4XYR4I5s8MHrhFowugWFFQH5NGiFoQW/f5Ejn0rrVnMyjM2TMR/hA/HCOKiZJrq1xr1U5CohodzuXEn3HsdtSnL3eY99i4rjVeAnfM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fccc494-c2f9-4b1a-6359-08ddd368f3a0
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 15:09:47.5652 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vtfY8SPtfTsHmzmLfJHku5ZbIE/Rv9NUUgnM/yYOVO2Hog/Zdi0xO4Gn5EwRmn7eACDNlHqlIpGSQdtYJtAAlsuOGM2sKaN/vk2yGvXWrrw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7288
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-04_06,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=0 mlxscore=0
 phishscore=0 mlxlogscore=999 malwarescore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2508040083
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDA4MyBTYWx0ZWRfX09FRPP+gx12D
 JzcS/J3OLW+SJSXy5IV7FQu+q7/XZdNj1hCnTxCxMJbtDRKrI+ArUuKQhdbEsJmHf8SJkP8I1Ze
 XGsc+thOsTTXaWtKoBZagz7eZQ21CkHcgO0NFEvrZNIC9xRwk34lhGoIl2OL8OlGWEovmtgvW0F
 tRMNkTTfkbXkBHTE3G7P0R2Liix09IZSxPmphpQONb54O6zIOj+zyT907Q/nGE2UaHFLfIX0Qni
 DXUspLNvH9G3aNgcgpU4lfLQKH8XyQJxTLARk3YYo+VZy+bF0LVDV6lUbAE10vwhszbzysrmYGR
 F/uToPtZ3/rHPAjFt5JSQwE3LM3bQYySWtpRhDUrLaaY9pEN0jgyz8R6uDz2mzQOM6HzYBuJUwN
 fnD061Tu0QBm8KSkrUG2OyHtWWol73eH7/O6dtfApb6ZZoPJfSVSZIyOlSeAyuwKfDhdJYUf
X-Authority-Analysis: v=2.4 cv=SIhCVPvH c=1 sm=1 tr=0 ts=6890cd40 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=yNDQO595jxZyqZ0Ryc0A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: LB5JBh9OutlrveJCARux1MhgKARJwBzm
X-Proofpoint-ORIG-GUID: LB5JBh9OutlrveJCARux1MhgKARJwBzm
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 8/4/2025 10:47 AM, Peter Maydell wrote:
> On Mon, 4 Aug 2025 at 15:23, Steven Sistare <steven.sistare@oracle.com> wrote:
>>
>> Fabiano, could you sanity check this patch? Thanks!
>>
>> Peter, more below:
>>
>> On 7/21/2025 6:24 AM, Peter Maydell wrote:
>>>> @@ -883,13 +895,17 @@ static void kvm_arm_gicv3_realize(DeviceState *dev, Error **errp)
>>>>                                   GICD_CTLR)) {
>>>>            error_setg(&s->migration_blocker, "This operating system kernel does "
>>>>                                              "not support vGICv3 migration");
>>>> -        if (migrate_add_blocker(&s->migration_blocker, errp) < 0) {
>>>> +        if (migrate_add_blocker_modes(&s->migration_blocker, MIG_MODE_NORMAL,
>>>> +                                      MIG_MODE_CPR_TRANSFER, errp) < 0) {
>>>
>>> Why did you change this? It's the general "if no support, can't
>>> migrate at all" check, which seems unrelated to cpr-transfer.
>>
>> "If no support", then cpr-transfer should also be blocked.
> 
> But migrate_add_blocker() is a wrapper for
> migrate_add_blocker_modes(..., MIG_MODE_ALL). So doesn't
> this change go from "block migration for normal, and cpr-transfer,
> and everything else" to "block migration for normal and
> cpr-transfer but let the rest through"?
> 
> That doesn't seem like the right thing; if it *is* the right
> thing then it should be a separate patch with a commit message
> that explains why we do it; and we would probably want to
> audit all the other uses of plain migrate_add_blocker() and/or
> change that function's name or API...

Yup, my bad. I will revert this hunk.

- Steve

