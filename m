Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B29DBC77B7F
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Jun 2025 13:12:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uV8s9-000876-Sw; Fri, 27 Jun 2025 09:12:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uV8s8-00086r-0N
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 09:12:04 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uV8s5-0000dN-QI
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 09:12:03 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55RAbJ6N025967;
 Fri, 27 Jun 2025 13:11:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=ZpioYTpYrEgzBmYtx1DO1zyvu8xx0wbLfULz5JOcpq0=; b=
 shb6H6ZajqxmMEeMB7Dp1BDBe9RhHwYav/bsg/IAlXOby81E66LvQuw2jamdyNFI
 1R3515hvFlx47Tzxgxd05B5au6y5PjYvOB/O1rAA9Pwe5k50SeIUXzU2tgTpHAco
 Ur+fkOcqa2BG83xnZgUYETxVzKAF8vynOVyS45co0dbpCueFK0YSugAbUyLEI2bO
 yh36hcVdOhbnkU5JD7r8hxj239JT+069fXYMEbQyFriMACSC4sWc3rNuwjnd5xNf
 u7VY0FydowzJG3AVTQknOhZszJ9h81d5ba/wylLH+9i49azWISjCSLD6FweCl3ua
 w8s/fVGR55EL5D20Uq5h/Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ds7v40n6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 27 Jun 2025 13:11:58 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 55RB9rYK034096; Fri, 27 Jun 2025 13:11:58 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 47ehpuabbp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 27 Jun 2025 13:11:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RTCsqglZMIa1N8gobeYgDKpp3zIqH6ZN23/m9AHdm9Tg2uJFlSRaGREeqi6NkwPwviZWjgDcv/0b70BWU3OMhh69F4dKKHVNhRz7MiEt5U/Q9uSiYNyxDzpHeIlzYNyeMjVEJWZbDMDScEh7A0V4DlLUBq79Pwdmuhe57uTz4oiWpuiNX8m3wCDEJBNs2H2DX/r0qzF3eW0m2zF69KpBwShJ3/j3Use/LC9gnraFUbXLMvlWkCVoHpfu0QfiIx6NlElkHAMSGNDRvcudfmIKTX2ZW+ja+qsDEUV0zIAuREdHLF9FKPMYKyFKzur475YFEOhB/YTfZ9z1/xKuRCXqPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZpioYTpYrEgzBmYtx1DO1zyvu8xx0wbLfULz5JOcpq0=;
 b=WZXzQY22xB71pdyqmnF+grszDZl4xOBgphy4ftIjqOj72UU9UODjOtTAmBp8HMVcMJdjKT0EF/abNA21ykO5bArSY1lYiv0u+vEu9dIMed9hUqYujX9qT3OHeeII25Qq2HLJ/9kxPxY4mfZQjkEflKf0epHJdQJJqMC6AgOxhXhuybhQeAZuyJVst6NEoV4bRnijep27IjdQouAwnPbJTJB9T4mUKnRMeM3HPSIJA4mf92Mo2cTpf30FtasgMyLQPuX72s5houRdMjY6ztKXEIBSoUvDYjGcBC031bpTecAULNvTNIz9ZM5eZ9R0wLNFpBqhgHzK2WHt9GaisE3yHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZpioYTpYrEgzBmYtx1DO1zyvu8xx0wbLfULz5JOcpq0=;
 b=d/PdWGAzOS/2CrYSpGulMb+qT11ixsm76u6RYrFZPASN8WaM2vb5BVHjO+aykOfb2IBwBOnPBUFN5ZDYVH6oROAU1pkDdnB8tMfZ12yan1iUNnqndsN6skSd/4YCJquZVN2H56sk86ZvD3TDgYoRInqLspkA9MKQ/p6oprqoAhE=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by CH3PR10MB7331.namprd10.prod.outlook.com (2603:10b6:610:131::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.17; Fri, 27 Jun
 2025 13:11:54 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8880.021; Fri, 27 Jun 2025
 13:11:54 +0000
Message-ID: <8e5dc35c-73ef-4bda-bfc2-acb0a324f5ae@oracle.com>
Date: Fri, 27 Jun 2025 09:11:50 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] vfio/container: Fix vfio_container_post_load()
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 chao.p.peng@intel.com
References: <20250627063332.5173-1-zhenzhong.duan@intel.com>
 <20250627063332.5173-3-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <20250627063332.5173-3-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR13CA0001.namprd13.prod.outlook.com
 (2603:10b6:a03:180::14) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|CH3PR10MB7331:EE_
X-MS-Office365-Filtering-Correlation-Id: 2855cdd6-9ef3-4d0a-ed68-08ddb57c2fcb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a2dvYkp5V1BILzJIbjdMT2pya2lTL3FudjR4VWpGY3BRUCsvSG5DRVZtNzRx?=
 =?utf-8?B?U0EzOVRneTE1RHBKc2QzSFpvSmorTkQ0Y0c4R1Q4UjllUUZJM3dDaXdkOU9r?=
 =?utf-8?B?d0xZRnJUOGZOOXpqaFM3b2tvMnhEZ2N1ZjRjeVROQmowWXRiMVU4U2hOOGZs?=
 =?utf-8?B?M1dRREdHd0ZEUVVIcG1JQVY1c0NsZEdPRnB6eUhKSUhnalRMQnlLai9Wb3pD?=
 =?utf-8?B?cFhXa21JRWhGOGdlVE0zUGw0RklXRkJhUklOclJ2eDRQd3orZXRiOXBmakVx?=
 =?utf-8?B?SXdmbzRWcmJaY0J0UEc5c3FBTHNiemlackdWTTRmNXhZTU1qK2hOdlhNWVhx?=
 =?utf-8?B?TDhjOHhoaUFuRG5nRWNsZnRncG0rQnZ2TE8xVmV6MTlsUm9EY1Jxa3dQSW8z?=
 =?utf-8?B?Q2Vzc1dUL082NDBxK3ZyajV5UzJGbGJnVmlLSnBPS25SeHZnVnpUaGpqM2VD?=
 =?utf-8?B?M2V3SWowK0RpeXVVMXpKa2pEVm9YR0E1UTNUSlEwMkdWSHYrVWo5akIySThD?=
 =?utf-8?B?M0ZQRGUvRzZoZC9abkJLdGpaUksxeVF5a05rY096bTV6VXQzOERoK1Zzc1B0?=
 =?utf-8?B?VHZWU01iQ3IxeUtJdFpnUmU3MkQyaU05OHBoTXlGcjBqdkxSSVpva1IvTDd6?=
 =?utf-8?B?bm8rOUtrdGxGODN3Z0hlWDRhL3liNHE3N1NYK2cvb0p0dWNDa0RwTFZUZ0xy?=
 =?utf-8?B?V2s2T0lBUzdSYmhZNmVFTkt4WXVKalF0WXhoMWVRL1dFVi9SUEVuREZRblVl?=
 =?utf-8?B?K0xGMFQ4NllYTStaQUtZblFqdXhvSmo1aWNuUnhsZ3VPbFk2ekNRazRRVEl1?=
 =?utf-8?B?dHZIMzlkNXF2VC9VWTIvN3hha29oNHJIQmlWd3lET1FHUnpLSlZjcHJkT2tN?=
 =?utf-8?B?Rk5nclpoSkZkL2J4ZTdXN09sVmpJZXdSc2g4bWNiRW1JMkl3dnE3NTVHb0hQ?=
 =?utf-8?B?SStaYU41M2JrMFRkQTVCeW5mS0VLeXBEWHFCWm1qQmVPY0pvRWJkY0dpQ2ow?=
 =?utf-8?B?eHVMQ1lHdDJPQ01aY3RGZDRPSTNGRDFWTjBycDQ5OFQrbVlWY0JxWDVZSHZG?=
 =?utf-8?B?ZDI5S0Q3bXBKbjZNa0dENG9PRGNZMTl1RWdhQ2wwbnRHNEI3WkphY04rcnNE?=
 =?utf-8?B?M3kwMlluV1U2MVVPTW1pOVVaaDZOYjdKeU0xNDVydkQvMDJINUhqT21KekdF?=
 =?utf-8?B?c2l2VFFILzVtWTY1SW1hSFZPRkUreHFRMWRpVEMwS0dnQmYzSjM2OEFldERl?=
 =?utf-8?B?SkM3a1dCMlMycDdOWGZ0cjA1NnZuK1FRQjhMK1hocUQ4UXVqN3N5NU1MUjNL?=
 =?utf-8?B?bEJHYlA1RUg0UUcwT2NwRG9LSUN5Zys0VVpSZ2UxNTlUSnZFTk1UWTJBYnps?=
 =?utf-8?B?UHRVNlRGVWFUSmxlY1ZjeE83dGlpV3ovbkpRdU5uZ1dnN3NJNkg0cEQ4Z0ZH?=
 =?utf-8?B?SFlBaHdDc3dDQnNOVlFEUjZNUndWYjl5dXdsbHZNQWt0eTVFLzRUODFSSmwy?=
 =?utf-8?B?WnNyQ3YrL3dycHdrUk1MTlJjdXBJVFNqZ2oyQU5mWmJNTkx1UVVPM0VaUnF5?=
 =?utf-8?B?SDhDWmFVRzN2OEhvZ0FxNExYc0pqRnhNTklPcjcwQVk5QmVOdkZnTGV3VGJa?=
 =?utf-8?B?ZzFFRi9mZHI3Rk5DWHVUTnlUZGMxMHNmVkloTnpzK2tuWE5kSTFJM1RrSFBT?=
 =?utf-8?B?dThYNmxNT0htSWE1ZnlrREx3dzlGUE5Xdm5jTFQyYTZsVVJ3N3EvM0Y0ZVN2?=
 =?utf-8?B?aGxqNlB4WjZUcmVtSExxWEhiViswSmRPcEtCSEtlYS84eU9QaGxqZ3kzOEdZ?=
 =?utf-8?B?SXcvRVNPTmlmaHQ5QWhiSHVSKzdxeDc3SXpQVEpwNWxuaWlzRWtoalllb2xJ?=
 =?utf-8?B?Y3o0aHlPdi9VdE93L3U5Nm1XYzRva1luQnNheGhmWDA3cEJwbHc0RkQ2WXN2?=
 =?utf-8?Q?riFZ4CNdCV8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bXV1WFV2RFA4VWdqZXhOMHg5a21oTXBwTXFXeHIySE82d2FOblZzcnhIcllt?=
 =?utf-8?B?NzBpMk93TGlsdEMxeTBWbzYrQ2ZBcVltS2V0VUZlNnE2Q09BeCtIZm1kTnB1?=
 =?utf-8?B?czFPVGgyZ2htUWZidWoxSWoyR3paVWxZa1BhNklZSHFQdUllcmNwUmk2eTdY?=
 =?utf-8?B?M0ZscVh5Ky9Dbno1M0tkTnZqWldMcGVQQUduaEZuRjFvSXlKZlUwVFd4T0pz?=
 =?utf-8?B?ZHlsRTc3QUNSb3V4ODFIMSt6Tm5uNWZ5Mk1rejhTd2Y4aGJ1U1hKYUZHSDIw?=
 =?utf-8?B?ZGsxRGQ1YTlWcXFidXpzSzRmalBqd3dEcWtOUVU4T3Y0NGlqUUU2V3hNYklO?=
 =?utf-8?B?anJCNWZZb2pHanFuZDdqUjU5VkY5OWtCUkoxTDJoRmUvM3lNeTVLbWpTS09z?=
 =?utf-8?B?aG1uRWhnckhLVjdtODRUQlBxSmgvdVhYMjg0SmR3T25RTmhvQWR4YXpmWUdi?=
 =?utf-8?B?UHJaOEFEWXlhRUUwaUtYQ1lHMnVhNDY2UjU5RkNsdVp6Zk5YV0lGa3RaTmVU?=
 =?utf-8?B?Uk1OQTZXVG1jNEY3bDZpQ2l3MW1OdFlHVU12WklBd0hoUkcvbkpTNzFLR1Mw?=
 =?utf-8?B?cjAwZHo5QndYTTdvNytzeUtUQmdIMzg1RUFIdEJOY2NrWUFZTUVZdVo0Vm0z?=
 =?utf-8?B?N2haclBtVXRsUlJ0cW9ZWnFOK0VEa01WUnB4TnRJdkF3VGs1YmxoTTUyVlhy?=
 =?utf-8?B?azR6VEhtRlZHSUYrT0lPMkdWVkw3OGtHYitUb1lvdXA0ME1USm1wQnh3NU1o?=
 =?utf-8?B?WEhYVndXeExsbEk2Y2k1TUp4NUgyQk1jekoydG4xR25FMVNpbFpITDJ3SU1o?=
 =?utf-8?B?d1VodmhyVm1QKytVZWZJSlpWaDl6aTBlSVRKajlyMFcvQUp2UVg0SDFQTEpj?=
 =?utf-8?B?UmFNSldubmpyb1ZZQUF2TU5ZWk94cEJhUHBiMy8zTlVCREU3ZnVFTFYvSHlG?=
 =?utf-8?B?OTh5bWt3M1I0eit4eWdqd3BUVysrRnhEQU9oNWJ1aklzZ1dzby9tU1lwd3N6?=
 =?utf-8?B?U2FRL3VLcXdkTFkzQi9vNVVDc2xCY01qKzUzVFV5S0kyd2Z4Q29tdmdZenor?=
 =?utf-8?B?MnNqbFhhQkdGSUw2aC85VXNJZVNrZDhsU25ZL1puZklsRU93OUVQVy9sejFH?=
 =?utf-8?B?b2pTMU5ES21ZanpXUzVIRHh2Njh0T2twZHFFc01MbzhCYWNteG1uQjlEM0ND?=
 =?utf-8?B?N0NIY3dVWnJvVVFnS1l5MldraDVGZUhHeHNLbVRSdEpMczhuTjRKdGs1WUhk?=
 =?utf-8?B?NUY0VEZkZFFIWE5DdFdOYi9nZWZ3VFNJWEc0c0pHazY4ZmUzc0NnRkRFT0ty?=
 =?utf-8?B?dXNlaVRWbnhITnFTZXRmWkFtYWNqdmtNWU9KVWpYQ1ZLRi9WWEtqeCtBNk9H?=
 =?utf-8?B?ZTlUVkFwWXRrZ0xXRkRnK0x5ZE90MUwyRjRQM2s1V2ZDZThhMndPR0JNTXZQ?=
 =?utf-8?B?TGNpdkVDL2pNOUxISmpITkxQK1VKWnA0RVc3V0RGRURqYm5xaWxQUWhaZVpr?=
 =?utf-8?B?Q2MvVnNDMStmUmlUbzFNb2lJNk5STjdzSCszaklIWERwM3pVcm9FREdNZklj?=
 =?utf-8?B?dUhYODN5cFlvS0xqbFp0RDhHcUJKellpZk5VR1ArTEF2SXRieEdjVTdkRXhE?=
 =?utf-8?B?WXhINHZMMHNYbVVoWnUycmVTZmIwbDdicHU5dDhTSCtET2JOTnVENGR1NWNx?=
 =?utf-8?B?QXUrZUgxSVFUZ0JydTJEelJBT3JRalJpTlpIN2c2cTM5Rk9tRzhJc3VzYTFJ?=
 =?utf-8?B?ZXZnNGpTdjJWaGZRRlRHdnZaVjVoNjlmL043dXV4L0h5VTBweWxMdkpONm1L?=
 =?utf-8?B?WlNjNFBsVCtmai9KaUtHSk53UDJ6aVNjUVJhVWQxcEl5RmFaZCt6T0JuNHZJ?=
 =?utf-8?B?c3Y0Vk4vV2VqV1Y3UTgwUiswZ1QrUHlUQ2dEWGR6MDJjZ1QrZWpJMVE4OXhq?=
 =?utf-8?B?cjg1MDRONnpkNGE0V2NGdzQ5U3FFZ0FYUDRxNGQ4SStxck5jN2xGZWFkZ2xY?=
 =?utf-8?B?Q3YrbEk1cHk0Z0I4M05XUmpuWFdtRk1GOUdHdUkyMm96N1E3eVppeVRKRUcv?=
 =?utf-8?B?dmU2SW8wRTJMK2hway9FWUtWTDR2UGxMcVU4bGlvWEhwbmNPNlV5a2s3Nkk1?=
 =?utf-8?B?Mmo1bEg4dFRIZktlRGxvTUFSTTNNaDNVTkxCRlYwcUkzZU1uQWZnTjYxckE4?=
 =?utf-8?B?UkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: SEjIzdG3cgxRn0yaAN8VmkxphO7j2+6djYOE1Tpo+Dk7wpEvQR+idIJC3IedON7cK08pFT5Xhe/WT7MKQ4DqnGHsIxCwH45zG+JJtQzPWRwIbV9DexyNsX/pQNZ7oa4lpdhCY6nYFZ1zFDpiiJdIH/5aRws8dcVzLDPbugadD0S/ScFT41tVX3F3tKthF+d3wrWxMw654v+pQK/T7wQ4+rqy2SSbkTgpD9+MMwAKYOwL+rNQcWjCing478WeBCUBzqs842Ux+Yp7FgIT9oH5K7lzBkLgTGQ/APCQh4VN583Nt692Lgxu2AD1l5gjrO1APVZdZAE9MpBhdHGFHAAtWZTwQRAOiqBc2wfaHfYjDxlV/XofK9+WWN3hHNIu0CVsUqwugepqBYoweoJlKyhUJZkgRKm4uczkaB8XlgOVqhu5JaeW5tx0p9cmNnkUwkQsVyHPljLhIUxpyCu0G/knjHQk+kTFYwhynind/phVY2F3Yjdj3cVoqJika77Nd0qcLGkZ2XXCnd25+lfaofPERtOFx+LZPRnzP1n0ihbClfBHTGFWYO2NdlFA0akf3esonmX1ABmdh/DbkVLlbUhJWr1YQblNyPTEGIZgXw1EY2E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2855cdd6-9ef3-4d0a-ed68-08ddb57c2fcb
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 13:11:54.1659 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ztwDXlovOQ1Bk7VAeSdzWeYCmD3aGA4EEcNYAf/8vmgGZgJ4PabQKR8Zr0DtYu6sN1qQ2AZgeVf/x5mkYy5NmHJgP/i8ut/WoaAjACrzRI4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7331
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-27_04,2025-06-26_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 spamscore=0 bulkscore=0
 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506270109
X-Proofpoint-GUID: eD21qRorhzNn0hzweW9wDuwJlfPT_tU6
X-Authority-Analysis: v=2.4 cv=CeII5Krl c=1 sm=1 tr=0 ts=685e989e cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=QyXUC8HyAAAA:8 a=yPCof4ZbAAAA:8
 a=IHzSJmmEOvrGel9H7AYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: eD21qRorhzNn0hzweW9wDuwJlfPT_tU6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI3MDEwOCBTYWx0ZWRfX+kBlvYFvk9Yz
 Uv5yaR1vE31gJTFt9zbVfyGjn2lqfv5QN60daZGWu9L2v4hFzK1N3V0UJK/KdJzMvzXwNGgkug9
 4xDpWiI5G7btbVw9Iy9/XKUBlEQIxFvUc0WgTLFQcia5zNkU6BQ5wm4pCUt9jAM7pTPvSXXnD1h
 vTt6Lnl2/JyH7TQRCJHQAx7b9IsQSlAcTwxmgIG36DWn49VQ9P9HZL1ZJc6QG3YqgUStQcWlT9w
 681GjKVehVrccQaNWcyBGhh9cFxO2pV2/wnVTHVLlsROF36rYW31O4aKKuDHX9/3H3Kq8deOj3f
 VZzgvDJSQQkRggLna+2K2WyaO2yPrrE9N03SnojNwEaVkQ5IvwhVfQXuxPplijCIEy8RbD/wAv1
 dajlcqjLnwpos3iQI4XgWQv5s9j9dBvJGo5pC4loKWSIRtQuMlww6jx7pGjTFeDaKK8Pfi3B
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 6/27/2025 2:33 AM, Zhenzhong Duan wrote:
> When there are multiple VFIO containers, vioc->dma_map is restored
> multiple times, this made only first container work and remaining
> containers using vioc->dma_map restored by first container.
> 
> Fix it by save and restore vioc->dma_map locally. saved_dma_map in
> VFIOContainerCPR becomes useless and is removed.
> 
> Fixes: 7e9f21411302 ("vfio/container: restore DMA vaddr")
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   include/hw/vfio/vfio-cpr.h |  7 ++++---
>   hw/vfio/cpr-legacy.c       | 23 +++++++++--------------
>   2 files changed, 13 insertions(+), 17 deletions(-)
> 
> diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
> index 8bf85b9f4e..dbb2a16b7a 100644
> --- a/include/hw/vfio/vfio-cpr.h
> +++ b/include/hw/vfio/vfio-cpr.h
> @@ -16,14 +16,15 @@ struct VFIOContainer;
>   struct VFIOContainerBase;
>   struct VFIOGroup;
>   
> +typedef int (*dma_map_fn)(const struct VFIOContainerBase *bcontainer,
> +                          hwaddr iova, ram_addr_t size, void *vaddr,
> +                          bool readonly, MemoryRegion *mr);
> +
>   typedef struct VFIOContainerCPR {
>       Error *blocker;
>       bool vaddr_unmapped;
>       NotifierWithReturn transfer_notifier;
>       MemoryListener remap_listener;
> -    int (*saved_dma_map)(const struct VFIOContainerBase *bcontainer,
> -                         hwaddr iova, ram_addr_t size,
> -                         void *vaddr, bool readonly, MemoryRegion *mr);
>   } VFIOContainerCPR;
>   
>   typedef struct VFIODeviceCPR {
> diff --git a/hw/vfio/cpr-legacy.c b/hw/vfio/cpr-legacy.c
> index 0a5d1bd480..1216717546 100644
> --- a/hw/vfio/cpr-legacy.c
> +++ b/hw/vfio/cpr-legacy.c
> @@ -99,20 +99,21 @@ static int vfio_container_post_load(void *opaque, int version_id)
>   {
>       VFIOContainer *container = opaque;
>       VFIOContainerBase *bcontainer = &container->bcontainer;
> -    VFIOGroup *group;
> +    VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
> +    dma_map_fn saved_dma_map = vioc->dma_map;
>       Error *local_err = NULL;
>   
> +    /* During incoming CPR, divert calls to dma_map. */
> +    vioc->dma_map = vfio_legacy_cpr_dma_map;
> +
>       if (!vfio_listener_register(bcontainer, &local_err)) {
>           error_report_err(local_err);
>           return -1;
>       }
>   
> -    QLIST_FOREACH(group, &container->group_list, container_next) {
> -        VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
> +    /* Restore original dma_map function */
> +    vioc->dma_map = saved_dma_map;
>   
> -        /* Restore original dma_map function */
> -        vioc->dma_map = container->cpr.saved_dma_map;
> -    }
>       return 0;
>   }
>   
> @@ -148,6 +149,7 @@ static int vfio_cpr_fail_notifier(NotifierWithReturn *notifier,
>            */
>   
>           VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
> +        dma_map_fn saved_dma_map = vioc->dma_map;
>           vioc->dma_map = vfio_legacy_cpr_dma_map;
>   
>           container->cpr.remap_listener = (MemoryListener) {
> @@ -158,7 +160,7 @@ static int vfio_cpr_fail_notifier(NotifierWithReturn *notifier,
>                                    bcontainer->space->as);
>           memory_listener_unregister(&container->cpr.remap_listener);
>           container->cpr.vaddr_unmapped = false;
> -        vioc->dma_map = container->cpr.saved_dma_map;
> +        vioc->dma_map = saved_dma_map;
>       }
>       return 0;
>   }
> @@ -179,13 +181,6 @@ bool vfio_legacy_cpr_register_container(VFIOContainer *container, Error **errp)
>   
>       vmstate_register(NULL, -1, &vfio_container_vmstate, container);
>   
> -    /* During incoming CPR, divert calls to dma_map. */
> -    VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
> -    container->cpr.saved_dma_map = vioc->dma_map;
> -    if (cpr_is_incoming()) {
> -        vioc->dma_map = vfio_legacy_cpr_dma_map;
> -    }
> -
>       migration_add_notifier_mode(&container->cpr.transfer_notifier,
>                                   vfio_cpr_fail_notifier,
>                                   MIG_MODE_CPR_TRANSFER);

Reviewed-by: Steve Sistare <steven.sistare@oracle.com>


