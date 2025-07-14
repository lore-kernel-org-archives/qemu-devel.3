Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86966C83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 15:55:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubLW9-0003o3-EG; Mon, 14 Jul 2025 11:55:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1ubKX8-0001Fy-OO; Mon, 14 Jul 2025 10:51:59 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1ubKX0-0006lm-Tq; Mon, 14 Jul 2025 10:51:57 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56E9Z5hV031144;
 Mon, 14 Jul 2025 14:51:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=HudqvddzFE/3m5KR0CcGKvJkWt5kftHLXxPvMkDuw5k=; b=
 QYc4u/IBwnbH059sGDD9AS8mT4B0mpp8bnb+2zDTcxhqco7rV4sogisBn8V7O4sM
 X7EQXbnszj4IJQ9sVFmk82Q+fUqZ0z3EVOcFMmOIzEwXPJgUQOOQoWv5bSTXPhM1
 8uBlvguk8hLi4+OVssFCEnaXH4raCdDG+JhuN5I+Sdi7gCFq2h2cbZzJJXe/0tWJ
 IcmOsY3M4LyHAewQ+5ZAuKRILk7PqsWKYWPVIqsNjJAhfni9AIlw0BiryYZCpos8
 ev9ErG210I8fNtl64QvJF32Kgh+Yf/fSRvNHTu4yF3et6oiDmr7TZ891ZjDlZpO2
 NTr/nwhYG4kiPb7qe/pzKQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ujr0va36-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Jul 2025 14:51:05 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 56ED9Ieu023941; Mon, 14 Jul 2025 14:51:03 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2069.outbound.protection.outlook.com [40.107.92.69])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 47ue58mf61-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Jul 2025 14:51:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M/dviZ0q6wfZdsj4SavtrXsD/SKcUdDuRjgdPNSiR3tK6DCA/I5+kn4EnToUpjkf1W9pyI0xvY0p/vAbL7a5L8bXxAj+i+iOjpEf2KEhuAMyvLJhWfzb9BKWqQBwPliPFXut+ZWKhHmJbhJOSZ8/p065Ogto4l1X4thgpXkl8QTtUxetHzCfccBBVakNtPUyUq1XcP/UgBOYhwPds6v8Taxrf3KsFIiJnllfAQEX6teX4Ivi52bgX1XHi0DMHsARG8giquxmSwlstTCLNgjrX6GjCrBTy87LoJ4Xs3Z5VjQ7xuImdRsdmns3DV+S3VZaKlLeGC18hhkAQgPq7mrOfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HudqvddzFE/3m5KR0CcGKvJkWt5kftHLXxPvMkDuw5k=;
 b=ndFpdzelhwR8HOT0L7NmBOJ8sp2p42cfV7s5+zd2fB8JOpIgwb3e0ot44hCkxOFiYX7zHVZ2UazsQEFl6NdwTklVLsnMp8fTMm0wpmso14Pis+UTXW1/QCqCR1bwQYS67JAzNIZxzwpivCLbWt1k1kQPz/Cj1JwV/YoJRFV1M/S33FfYUzuNhELM56YMyLdo8bowZmpqDYDK1AvVjYz+5U2OFF91oKWABRDXqSFbwWXvnzT1JpXsLUJGAuUD2MMEWcGTfNNk4vTIoZ+eKGGg/HJV158Nm+APKdGmAyLB6uI6EN2YeTVps7pNmqDuZNe0N9ChD1TbgfVczOm+bd/Jkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HudqvddzFE/3m5KR0CcGKvJkWt5kftHLXxPvMkDuw5k=;
 b=uykqsmef+LlAnzrKZPQG7Iv236Mgt1Q9dKoKs4Lhv4Q3fTfDMG1Z7MQgZte1J0KHxgD62ktt18B4oHCIGkLUv7qhJRS36hi3ROf0RFZMu24ZPmPWdcthW/ZUHiJAeAPs74HhdnOD3HcniZTnKeWci8E88vP6BxnX9QWM+j4fwFE=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by MW4PR10MB6297.namprd10.prod.outlook.com (2603:10b6:303:1e1::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.19; Mon, 14 Jul
 2025 14:51:01 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8901.028; Mon, 14 Jul 2025
 14:51:01 +0000
Message-ID: <b86946a3-14e4-4c0b-a4dd-d42c4f592adb@oracle.com>
Date: Mon, 14 Jul 2025 10:51:02 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 2/2] hw/intc/arm_gicv3_kvm: preserve pending interrupts
 during cpr
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Cedric Le Goater <clg@redhat.com>, Zhenzhong Duan
 <zhenzhong.duan@intel.com>, Alex Williamson <alex.williamson@redhat.com>
References: <1752503239-222714-1-git-send-email-steven.sistare@oracle.com>
 <1752503239-222714-3-git-send-email-steven.sistare@oracle.com>
 <CAFEAcA8yg19zB=xWqcywe+bj57bHjfRaZ5+TBy6GhKwoeJBV-Q@mail.gmail.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <CAFEAcA8yg19zB=xWqcywe+bj57bHjfRaZ5+TBy6GhKwoeJBV-Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0122.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::7) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|MW4PR10MB6297:EE_
X-MS-Office365-Filtering-Correlation-Id: 659c40f7-323d-4315-b803-08ddc2e5d974
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Wk00cWx2VnFEdTVOVGFSdHlBWGxCd0RVNUxGbjZTRW4yRzNDRGc3YjZIeDBK?=
 =?utf-8?B?dmVuTGhWeFFxQ3MvTTRCUmxlVUVOTlo5R0FjSnpmY25PYU10NGN4aU5EdnIw?=
 =?utf-8?B?VUlWMGg2UkZqZWRUYjV4Rkw3K0FTWXVOOGZUM3FpS1BpUEIzSDJZSmlHU0N1?=
 =?utf-8?B?NHZSTmZmeVFJdkV1KzUrZU1JNWVlYTRiY0tLU2xKVUhrSFFYR3dHMmp1S2x0?=
 =?utf-8?B?TE5QbFprUnhOeDFaWlNrMkoyRkVpWmUzQ3RTWnNTZmhub3MzbDhlZm1RMXZ4?=
 =?utf-8?B?QXh1ZWJrWmxmQ3lHTEFETXkwQUJIelNKMHNUSjBBaHdBaXU0TnRWTHIrTGVl?=
 =?utf-8?B?U3dWNVk5dVYyV3FEUC9qb2huL3BEY0R6TlVBUVVMV2FDMVpUaXhydjdGa2JC?=
 =?utf-8?B?bXBYTHkvNkNlb2cxaktoVjN5TjV3eU5NRG9sMjkwZEZLRnpWeWxBK0FsT2p6?=
 =?utf-8?B?TDBCUkhxK2o4d3lNZ3pXMGFubnRnNHJXQkUzSFZnOTd1M3hldzRaZDRESlFl?=
 =?utf-8?B?dUZNeE5Fd092WFBMajgySGZJdHVTMGM1cm1EK3U4d3BkbWQ0RDl1NzR5TC9P?=
 =?utf-8?B?MU5CblQ2cXRKSTNUODNKZDRiZVRuN3lIVlZpVkRGRUszT2VlbFU4QnFTMWdU?=
 =?utf-8?B?MVNqcnlwbk13WlEvNm9UVjRQOW00WFZva1liRE9wVDBSSW5OWXdxT2kyV1Bi?=
 =?utf-8?B?TlJRQnZxMkdXRVI2UmhXRm1WSG03OEI4NTBvOWRsYUV5RXpBNElTK0VGMWZ4?=
 =?utf-8?B?dGlkdGQ1TThrdWJYNWcraWhqajZxZmYrUVFtR0dPS3JGallxQmNBQlptY3JS?=
 =?utf-8?B?RVdMTjNIb25PbTJQVlUyTnhPdG03TGUzb212Q0lSWU5mMERhbHQyMzl3bERL?=
 =?utf-8?B?MnE2T0NLQ1Q3eUVzUnY5dnlDb0NSUnlnRzdEKzJkdnBXaTFJRW1uVzIrdzdp?=
 =?utf-8?B?R2s4eDZhaXBubjdJWHFUUmloNzNDbWZaaENUbVVxT0dnREhtaU83U1YrTFZ2?=
 =?utf-8?B?YkFHWHR5a3NsVXRROGF1QW5mSTJQcUxWMUFPbjJJY3p5UDhrYVJSWjgrM0hu?=
 =?utf-8?B?YW5jalFhMjk5QmhUS1RmMWt0dnR0R0hMNnZFWFdzazRJVW14S0lzN3ZXaFlB?=
 =?utf-8?B?SmRNTnJmcnhXdmwxN1daL1lhd0c4VERCSkx2OEwvdksxMDBNTjV1SHlUSXB6?=
 =?utf-8?B?cU9TaitLWS9wZ3Jpa2JFOWhPVjBTMjJ5b2tUWm1DQklRTEJNWmJYWTNiVVlW?=
 =?utf-8?B?YTdZUW8rVmU0VGtDSW9pMWxocElvSnRiV2RuZFRvN1R4bzZWQWpabU5jQktK?=
 =?utf-8?B?Lys1UXo2amIzY1NKS2VWK2VBUHR2QTBMdjdPUDExdTJPelNVdHFIRnczalF6?=
 =?utf-8?B?R2pjbUxIK2pyeXBvc3ZzM0xLR3JEc0NwTFl0a2d3L3AzMHlHZUxLN01LNGtx?=
 =?utf-8?B?c01SZDh1WlNZcFRPMHRnMko4eGNvN1JnTjRiNmVWRGdYZ0lUSXhxYllINWhi?=
 =?utf-8?B?a1AxUXNBMVdhZEVxcGtpMUthWEZnL3lXOG5MVm9idndyQUZPelRoZzdVdnVi?=
 =?utf-8?B?WWM1QmoyOFZubklYbVViK1pLdSt6MjlDcnVDWXhhZW1RT3FWSzYzeHRQVjU0?=
 =?utf-8?B?S0hrZWdNZXVOZ0hGcVFjRkRRSGdSdkZVVkZnSHIxR3ByazFKZkpNMGYxK0M2?=
 =?utf-8?B?MW41NlZ4WHAzRWZLVCtCYUN2WGRvY2xPUkhuTTlCb3RRVWkvbHUvNHpTRFVQ?=
 =?utf-8?B?TU0xNFZ1VEdXNkEyY2dRM3M3SlJKSVB3bForb1N0eHcvM0ovT00rR3NVRWpS?=
 =?utf-8?B?a0NTY0toQ29EUFBNZENkelJmMGp5dWVOMFlZMDdsdzltZVNSTDlvMnRMVXBm?=
 =?utf-8?B?TThJT3A4RWhrNmtuN0gvQ2JrV0piZ2lsV2hzLzlYOUJFRXhmTnphcEhwcmYw?=
 =?utf-8?Q?ogLDrwPQX+E=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bk5Wb0hVakVQQjFSSUkydnhrQlRudTAzd0hhUkw4MVROejMxOWxPT1RtS2V0?=
 =?utf-8?B?ZG9ZQ0JLVzBiYUdSY0ZUUkdYb25nK3BVNGFJYWlLZHJ1MitrUkd1QThtbGVx?=
 =?utf-8?B?UWk3U1A2R3hsbDNDbmNSNzFETE84TVpvaU5xYzVKWVI0OXdkQnhySjRrVkFG?=
 =?utf-8?B?cTNvMFQxN24ybmY3a2Z4N0NLcXFWUldIZlVVTk5VQUxOOTJPR1FHNFZiOHVM?=
 =?utf-8?B?UnR0eXZwL25HaVFsek1VeGJNeExyL3IyaGdnS0x6d1lseFRpcWxRV3o3U0Q1?=
 =?utf-8?B?VnhYU1phWERhNVlxUzRUbkxqTmkwbGk3M1d0Q1UyL3d0bTUyQnptVCtLZU5m?=
 =?utf-8?B?M2pnVUpEcThUamJFTnlrL3B1ZVA2RWZIT3BCTEFMMzBwa1pEc1BhREF2cTIz?=
 =?utf-8?B?SFkyUll5MHp6b2RIMnhnWGMySUdBRkZ4Mnh3ODVBL0hrNi9OSkNzZVVsTXV0?=
 =?utf-8?B?YWtrUXZzK1c2aUMyLzNNQXBpbWtLQmVZT3FOZW9LM0VQTnZVVjJ4bURJUDFz?=
 =?utf-8?B?Sy9IemtkSDFmWGJVc1Fib3hVOHhGRXNYY2xHQTI5eEprRVJxQmlTOVl3VlVk?=
 =?utf-8?B?WU8zZUVYTHdvNHdESG1ScVhiKzZxUDkwUnVoTk1VbDlxZ1I1M25aUzA0Wndr?=
 =?utf-8?B?cXMyNkV3cmtIdVh0NjUwaDhqaXZXVzBJOGpOVS9tWXlOWHBiNFNyU0prSk5H?=
 =?utf-8?B?NFFsamk1L1lpbnpKMjh3d0VjR25qQ0JGWW1MYVhVUjV4SEQraU1sRXhJL3Yy?=
 =?utf-8?B?ZkxTRUkwN3Fza2tRdTlsVVBXajdGSzY4VmIza2xsRHNUUVpHZmFkemVBY2pm?=
 =?utf-8?B?djh2Qi93b2hMeFhWWUtIMlRNMWhRWjg3bzZReEwzejdwSnBjaEwramZvbklS?=
 =?utf-8?B?RTNMNHVYbXl2dlFOUkcvRUd1SmdNVFVaWE5wSkRwcHNXdWg4SWUzTURQNXEy?=
 =?utf-8?B?dDUveWxNWmtGV1FITGx5MGMyeVZvaWlBanJaeXR2bWZlU1pkVUtyWWZVZ0lm?=
 =?utf-8?B?UXRZdlgyWlNXUjFWMElDbjZaYnZoSU5KTXZYWDE3TUxGZnVLZThKWXR4b3Ji?=
 =?utf-8?B?d3FkMDlMU1ZkN1A0UDdGeGNyUlNoVHpaMWFLYXF2Rm1TaEtXVmxacndtOExD?=
 =?utf-8?B?YkQxWUg3bnVWOFF1UDR3TTJtVFlYQVVsU0RXZ1F3OTV5QWNsRXFBdHBaaU9w?=
 =?utf-8?B?MWNOQnNLcytoZGJwSmlSeGp0UW5aNGFTdFQyaGQ5WWQvK3cxWC9CUi9WMEV0?=
 =?utf-8?B?RWs1UHBLMStCcE1jc29HQWNZNFNNL2J5ZnkzQ2ZsT2hqZjN3elhSSkNaYkM0?=
 =?utf-8?B?emR0RDQvMzdzWWlvTTM5bkM3WEVITEVsOEw2YUlyVHdCajd1aG9paTQ3clRo?=
 =?utf-8?B?U3V6T3BSVGtiVk1pZmhRQ1QwL1RvOFRBMGJuM1ltTmhpQ3E5b3JjWXpOL29q?=
 =?utf-8?B?WnVUYnhCakEyRUU1OEdtdlQyNGswWjNKaHp2Qk9GQjdPeFBYcVBMckpzSkZO?=
 =?utf-8?B?NllWR3dQc1RMUjZoU3kyaEF0R2J4a0hUYnllUytGTlVDMzNPV1I4ZExFWDVM?=
 =?utf-8?B?a3RhK0l5N0RJOGN3SmlOekhxUVppb0dmL0c4QTUyT1huWjFYY2Uyam13OGFN?=
 =?utf-8?B?Q1l3SGthOXF2RFNIV0dQV0hkNkpFam9OamFObzFBcmkyQmNnclJVZWpoRE12?=
 =?utf-8?B?MnRyQ25oK2NWdUhoblI3bCtZdXFkbmxGRjBnWFd0Vm9aQmRpTjduNENUL0lj?=
 =?utf-8?B?SmlWUU0veHNOTEhKYVpvdXhwQnlXbHJwcEdiQ0hTWlp2dk55V1JFK2FkYjVw?=
 =?utf-8?B?eWJpM1dwTkNDajcyUlFUMHRXckRJaHhqdW5hRjVnb2VzRDJxd2o3YVN3Y3N5?=
 =?utf-8?B?bmtHeXRpazhJZ0FJKy9YLzAyZExUMjU2K3FGd1BHU1pmQ1JWNUJHMnI1angy?=
 =?utf-8?B?a2NqdE5MUWhwZktwMFFqRFBsVjFKY0lZd0tZUk9lNW9sM3BvQmcwWkpxV1N4?=
 =?utf-8?B?WEhWOFBJMWRCb2JmRnkvSFN5d2tYQmtDSE44b0pValdlQW1PNzMxM0ZJQnNh?=
 =?utf-8?B?MC8xVGp2TmRsUnp0ajhBdWpyaSt4WC9PTndQc2Y1OEh3UUw5L1o1OEtLYldt?=
 =?utf-8?B?VVhEZi92cXJPOTlsTGdsSGdsVmJKUGQzQzNTNE9KQkordk8zZ1ZvNlFpZlJr?=
 =?utf-8?B?UXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 5aMYjz2EDgh/5a2g+XtzR2euKUZRQvbbb6Gfebav0vIJr8I7crBJq5yJBOjJEnGIF9JhmKxL5c/OUJV5vKGZeKy1fPScdQaTqc69Q8kw4wL57Y/fqfkV+r5WoLflus7XvIAYnX8twHV10cEQzpNcnkITzO1cmcpH6XKmQdtuNdL0YJQVBfPMp9Xf2MFYL4FQiXvc9uqgGxBIstNc0/knjlngVRwmXv3waKQ49uBcDR56buiD9Bz7YqFgoU2LPmPecHfg9bO2CEHpyyeb1I9qYjLY0/vUMsCYJJCFYQtdjhhXmJqZDJk4iKVqy01dZp9UgSRcokX2sAi0ksoz/v6/yIuPeW7tiZMXKyzFFzGJYhI+28INkcPTweXHnY8uMnt7Hrp0r1VZufh7zbZo8h4Vt/gTtMduJqnH/z1Tuj51eT7UA7MNSItuJfAKheRRLQ48HdChAoYxH1jsd3ONV4IrbvFvNw0nLsMWeQMRYlZaTpV/u364+6Jy4y+viiSmfdNm/DO4HQfMoKPbJx9BTu7hEqDvaEhYbb/XObt3ntUKyla0mvYAUETW4Rt2KLCsl6XxBDG2tLqVRFs+zHD5Q+OCAlNtjJEaW9sqlMWeexdeORk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 659c40f7-323d-4315-b803-08ddc2e5d974
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 14:51:01.0417 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L9IVJdMjmPUHALopQh1QRPqnlMNUWIT1cFGyTXDN/VYzvSkMfoMl+WtG+nyYGM4z3C0CBRXyG1S2W4iWvboOn0e03tBEETPFIfcD8CZnTa4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6297
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507140087
X-Authority-Analysis: v=2.4 cv=d9T1yQjE c=1 sm=1 tr=0 ts=68751959 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=qlf9CAmBZY7DiXGcdvAA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: wAAhm4qiF5tkkpxzVEw8v4vkhbxoRo47
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDA4NyBTYWx0ZWRfX3kyE16Op0DEb
 4rKOlM1Oec8rPl73lAXz7a0lFQLtrOkQZ7SdWhs/tcoNclQJr/lRwFAtocfDQENBZSekHinGvf/
 dDNfmoxVif0uCb4/O3OJJZ2VzNTgBiQNmbQOiO/UMJ4mAKsPURBax5r3Q9KQlcQitdoBYLpNdIm
 /BbyNqFxjefLN6iGe5n2+FHR3K724q8BlEFagUOm/QJKNjbEfRQYmAQTegTBXPB1OHCfeJlqho8
 ptfOO5mvi2JEhejKcZnfJnjrFQcCvUK0mGoPBeqAZborRcS3puDWk3RdriFrwWM0b7BJjIfJsc0
 vOp+uFuiWHgpREEjycjb7WqDrSr352UzSN6agG3rDRB6+Yt1H0u7Z8kVYu+pset+rCbQlc4Yr55
 Ga+/oOZjNr40T7P+Z3+PtdFxvJQb/sPfihNwwH5uVJr5h4E/L0MDn2BrmyTtNKpjLm6qjPXG
X-Proofpoint-GUID: wAAhm4qiF5tkkpxzVEw8v4vkhbxoRo47
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 7/14/2025 10:32 AM, Peter Maydell wrote:
> On Mon, 14 Jul 2025 at 15:29, Steve Sistare <steven.sistare@oracle.com> wrote:
>>
>> Close a race condition that causes cpr-transfer to lose VFIO
>> interrupts on ARM.
>>
>> CPR stops VCPUs but does not disable VFIO interrupts, which may continue
>> to arrive throughout the transition to new QEMU.
>>
>> CPR calls kvm_irqchip_remove_irqfd_notifier_gsi in old QEMU to force
>> future interrupts to the producer eventfd, where they are preserved.
>> Old QEMU then destroys the old KVM instance.  However, interrupts may
>> already be pended in KVM state.  To preserve them, call ioctl
>> KVM_DEV_ARM_VGIC_SAVE_PENDING_TABLES to flush them to guest RAM, where
>> they will be picked up when the new KVM+VCPU instance is created.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>   hw/intc/arm_gicv3_kvm.c            | 16 +++++++++++++++-
>>   include/hw/intc/arm_gicv3_common.h |  3 +++
>>   2 files changed, 18 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c
>> index 43cba6e3f1..15245af2fd 100644
>> --- a/hw/intc/arm_gicv3_kvm.c
>> +++ b/hw/intc/arm_gicv3_kvm.c
>> @@ -30,6 +30,7 @@
>>   #include "gicv3_internal.h"
>>   #include "vgic_common.h"
>>   #include "migration/blocker.h"
>> +#include "migration/misc.h"
>>   #include "qom/object.h"
>>   #include "target/arm/cpregs.h"
>>
>> @@ -783,6 +784,15 @@ static void vm_change_state_handler(void *opaque, bool running,
>>       }
>>   }
>>
>> +static int kvm_arm_gicv3_notifier(NotifierWithReturn *notifier,
>> +                                  MigrationEvent *e, Error **errp)
>> +{
>> +    if (e->type == MIG_EVENT_PRECOPY_DONE) {
>> +        GICv3State *s = container_of(notifier, GICv3State, cpr_notifier);
>> +        kvm_arm_save_pending_tables(s);
> 
> This kvm_arm_gicv3_notifier() function reports an error via
> an Error pointer, and the function we call inside
> kvm_arm_save_pending_tables() can report errors via an
> Error pointer. So I think kvm_arm_save_pending_tables()
> should propagate the Error up, not ignore it.
> 
> (Or if there's a good reason we should silently ignore
> the error here, we should have a comment saying why.)

No good reason, I was just mirroring the behavior of vm_change_state_handler.
I'll propagate the error.

- Steve



