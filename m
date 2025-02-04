Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3161FC02193
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 16:15:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfLaU-00059Z-JX; Tue, 04 Feb 2025 11:15:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tfLaG-00050O-Tr
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 11:15:35 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tfLaE-0007J6-W4
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 11:15:32 -0500
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 514DRg1g029492;
 Tue, 4 Feb 2025 16:15:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=ZbprI8mkNUY5vd50ParQVWT01Grm4joHm9SPDLVLd1M=; b=
 jR+y1QT8L0AwLCX3zC8SQpIrtWazZ7+A/rcrha2xVTXp/F9OlXokPOrGNEMyRSiY
 nL9W6zd/9fBymtmVkR3u4qhqA1K5Jg1k8fNlJLtw8jGSWVIltZ5vSJYg0vqL2si4
 Y8igTEA7IHEqvs/kd00BEGdjMqWVm/4Gt0ASGRvaJ1s79mr6KQfCLNtjQJdVh4TX
 afonnJ2RlVITzKj9N8jjebnblyxUxzIys0tHpoFlFx6eAXBP9I7chNVoUO+nxREt
 H5tQw0WJ9LD1Es7My+k4SEu6MsYWAfvgUGRLLV/4o/XxWFzhnj5C+I+LmF/s0Utz
 856P+JlcsGTQNEc/B2RpEw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44kckxh38m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 04 Feb 2025 16:15:28 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 514FhvOZ004728; Tue, 4 Feb 2025 16:15:27 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2049.outbound.protection.outlook.com [104.47.55.49])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 44j8fp6mg5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 04 Feb 2025 16:15:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D6iI7/TTRPX8UvdzZHz8i666N/rJM+ubThy3cchTSZ9igK9ObAlubb0jGrlU8y2xBq+tla9QKQzl4lavQa8zIqNuF8YfCv1m0KjhEsfGUvE2hvyNzvAnImbJOQGqA8XCzOmv9Mc6HzDhERhUFCitl5Pz8J8qkmtmKjRxSPW1u9fiTyfhuVrWTMsf6urggidybvMSA76wRFUqD0xPKKzzuwgxjSuabjGlzgf9jSwUKPcmEcRah+wwCmMScd3tbJYWJ+V/l8pOHqlA2M2+xiJlHEeeLfAqZWta0U3IacB9MNUCzd8dWV0qjwDcibZw+LKVztg97RSOR7VpiDy7v4sjJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZbprI8mkNUY5vd50ParQVWT01Grm4joHm9SPDLVLd1M=;
 b=r/TkPObRwBDDq1a9bj7xqMBMGcyU6bu/55hncpe9rsULIKp7bOmcZWSy/g+W9JAUsDv7vKwDHR5zym6mhzCw9NTnV9VJJVZ+OhXO2uS/MGypv/eSNINPjzyFqbMvfpY7hUJAJsTPCTq7E+/xHvLzsQkSFe9vrFMT00zHc6dTPC6u6d4GJsNbn4Zmx3nLtV2eIN//9XLaOeAsI71W2aW43uV5i3brU0yueQXgPGSj996YMWVfDL/MfFAB6Ji24/rkbjYRY+0HKhlLg/8t5gH9qMMhZ/VWJoEkqzqaQhw1acLE83vAzjPP3Z7EnUf5dZ5P8eyR8hWi7oLrsR6QktTvjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZbprI8mkNUY5vd50ParQVWT01Grm4joHm9SPDLVLd1M=;
 b=DKv3afEtnklmm1PUJBS0kd7/uuise51UnD3kgieYOXe9slWu9fCsokGa1rTLcMsxFsxorEE2TddpHwnNyNHPr0IIxk4i8C+ij3qEp+/jahEEJ1cOi1x67CGBlEpOUjctgRvMnhk75ypYPhw8VPqDYnYisj2llNFbbkYUNc6AFI4=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by LV8PR10MB7846.namprd10.prod.outlook.com (2603:10b6:408:1f7::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Tue, 4 Feb
 2025 16:15:24 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%6]) with mapi id 15.20.8398.025; Tue, 4 Feb 2025
 16:15:24 +0000
Message-ID: <b7a0eac3-5084-408e-aa00-39c5f3d3739f@oracle.com>
Date: Tue, 4 Feb 2025 11:15:19 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 11/26] vfio-pci: skip reset during cpr
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <1738161802-172631-1-git-send-email-steven.sistare@oracle.com>
 <1738161802-172631-12-git-send-email-steven.sistare@oracle.com>
 <ae082d34-5c0c-449b-91dc-c8c3b147d6dc@redhat.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <ae082d34-5c0c-449b-91dc-c8c3b147d6dc@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0018.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:150::23) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|LV8PR10MB7846:EE_
X-MS-Office365-Filtering-Correlation-Id: cdb6df16-b736-4780-772b-08dd45372198
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UDJqTUlGeis4TUUrUTlZZ2pjYVNBaVdraVltVWlrQlBPdlZ4bXRpZlFoUGRR?=
 =?utf-8?B?bURiWDZpamFZbm9KY1JUMnZjZDlPcEcyTjhGMzREVzZGZVVBWlg5OExPUDdB?=
 =?utf-8?B?eCtyZzRYNkxJQ0c0bDFPclNWYXdHWGIzTzFuaEZxcHNWcjRNVDI2c2ZIOUVm?=
 =?utf-8?B?NXpEc3pLeTFUNGNocG16T2plWXJpOXhneEZyQ2xvblFlc1YrbTRTNTY4bkQr?=
 =?utf-8?B?d1VydUtWdWdYOE5zSU13MGFyVTM1R0IyVlJoU0ExbTdBRHpQUndBQUF4SkNx?=
 =?utf-8?B?bEV2SDBDblp2S1RqbzVPNVJvZEpyaithcko2dkVxYjBQUlVESEdNS25BVFhQ?=
 =?utf-8?B?MHNZK1VvZjBiNTYxUU5teWtGejdtREFVYUJYMFBVVGE0VXppQlgzRXZnWjI1?=
 =?utf-8?B?VGNJQ2xrZXNHTzZacERHbGo1TW5HaUVCNXlPRUJvSXFyRHgreE1ydWJneUo3?=
 =?utf-8?B?OFIydThLV3NsWmxNZ3FEbDJSMFpucXJUNDQ2dkFyQ0VJQWxHUUF5NGxNaXJ1?=
 =?utf-8?B?V1ZwYXk5NlpzR3NLaktPSnBnTzFDTFArWXhVUnRaZlVnQUhHS0ZTTU9zRzNl?=
 =?utf-8?B?UlFTUmJiTnp4T1B6eVZ1L2ZOa09LSkNYZjdaWmNCZ256QnUraytwYmYwNVVN?=
 =?utf-8?B?SGEya0REbEVGQlZjaUFOaGpOMHh1QmJDZ29zK0JILzdSRmF6UXJXa0JMMnRD?=
 =?utf-8?B?NmU2QkwrWGJwT2xjMFpIM1ZpVUJxeDFyMTA0UGxJdWVLQ0JjTjdrL1FyZHNX?=
 =?utf-8?B?YnZWRkRYcXRmWnJPMGt6amlRVGFvekhxRDJYaGRicVZjK2IxU3dIVkJhcFhB?=
 =?utf-8?B?WWEyMHBxNlNVT05PbzV3Y2pGWEx1Q0FHRDdHMTkvMy81dUMvemh5bEJ4ZWV5?=
 =?utf-8?B?RmtCQkE4em82cTZaNmRueHd4RDhYYms5Znk3aEFCSXNHLzlkRHRXRkpyUGdm?=
 =?utf-8?B?V0NEd1JnRjh1ZW16Y0cwL3UvVWFZb2RoNGU3Y0tsYkhmTTNmc2xXNTY4WnhU?=
 =?utf-8?B?VHg5dXhaRjFvWVA1N29Pem5ZMmd4a05uem5lRlpCd013QUJJTG9nS2tiTDZI?=
 =?utf-8?B?eDdEZitYeWMwUlhuU09RaThZTHhmbHFqc1NNekRUbERXMWFMN3RZbXoxby9l?=
 =?utf-8?B?azVwbEJ0RFdCQ1cvaWVYSjZqUnZleHFpcmhwWmxVaUpSenhVQlZ1TThkTjNv?=
 =?utf-8?B?SmJaWEY0aG16NmVWR2pNMkg3WGF2Z3BNMm1iQWVUV1dNTXZtOWJ0RHkxMVd6?=
 =?utf-8?B?bmZrN0NxK0ZjM2QvTHBPUUtnV1NkY3pLcUxweUtqaS9BaXRwYTc1SWhjY3pn?=
 =?utf-8?B?VHc3dFJtVmFxa2x5VjBZUWs1eWtpV2ZzSmZiU0tpMmhGVHk5M1EvaGszSGZX?=
 =?utf-8?B?STBsSTFJMDhtKzFiOXNvTE4wVVJvNno4UHhtMmY4cGNoLzUyK2NnaDI5S1Bn?=
 =?utf-8?B?NisrSk9SWHorQjBPVjQ3dXlaZG5jcjgvZnk2TCthWWtURFpjVUxCNjVpTjFr?=
 =?utf-8?B?bG9jbTFqWFR4YzU4emZjT3BzbVdZN2dlSXVQQ0dOWE9VbHpsYWovWkx5NjRI?=
 =?utf-8?B?VXhlcGdRYnUxVGJtTVowMGloZGE1Vm0wZExHQWVrVVN2UlV3WVkzemJFUUVS?=
 =?utf-8?B?TXFsNE5UeXJNVFJNbXNjSU9oZ2RVQlhUZFd6dEpQQWZYUFVsTzRPUDNOVytq?=
 =?utf-8?B?bitrbnZvaDJpWlVHOW5zN0RESFhJSjYySWhWZXIyWWM3cW5ZUHVqRTFFcllH?=
 =?utf-8?B?TXNCdGt2c2lwYnRnZWt3eElla25GZS9mR1EzYnlHbVROTTNnUDQySUZjbDVl?=
 =?utf-8?B?RU9ZbmhtRlBiSXQxaG1RbWltaGlVK0JCQWxnWmVWelZ2KzcxWUFxN3pCWkFs?=
 =?utf-8?Q?2i1qsTB8ZTq/Z?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q0ZXWVRjNEJkU3M5QW5iMDlzUXY5Q2tYSnpUbndqTHAxV29YMU4wUmFKRUlF?=
 =?utf-8?B?TGhyLzMydmN2SzZUTktGQXRkWkZ1VFJxM2lJK0kvNXA1ejBoWG84bUROU1Jw?=
 =?utf-8?B?YkQ2aVEwZTBXYkd6dXljcXB2QW1lUm56RzIxYmgzbEFNS1R5OHlBd2FPYmJk?=
 =?utf-8?B?dVh6dUw1c2ZsUUgxWk10QTBKQm9jRExZVmZORjFERDhvWVEybDM4d3Q5S3Ir?=
 =?utf-8?B?YjZoK3FRY21yUExhREk1YmUvak5rZXhRQjZBdmo1VzVaSUlXSWJRVUo4R291?=
 =?utf-8?B?L1B0QzI4RitFbDNLUlk0bGR4NWtaL0w5eU9HK0QrY0h4dWs4eDNobjFvZ2d6?=
 =?utf-8?B?QXRkdUNqV29uaFoyTFhleXJCNWlPZGlFdk5SWUxtVVlZZ0h4Kzc4YlVGTmxW?=
 =?utf-8?B?UnBRVDlCamFPNmpKdlliRTZoQUhTS216VFhWMlR2dHlPVjNwWEZsalJ6OE9w?=
 =?utf-8?B?VU1ZWmorQXI1OXN3SFRGckx0Q0xKRGRMUnF1ekNaQXZPcFVTWTREQjF5VlJI?=
 =?utf-8?B?UjZoOEIyWjREUzVETGlqb3pJei9jT3ZjeGhsNDA3dEdtYVpSUUNYTHZ3eEdR?=
 =?utf-8?B?WkxhV09tREdsci94dXg5K1FkcHlXdTNrWEdaOFhURUlQUFZmamVnaEo2QVU3?=
 =?utf-8?B?UjhuVjl2dlBtZ014ZnVNdTYxeHZtbEhtSll4eXFpQjVwTDFvbXZkNnlzblhY?=
 =?utf-8?B?bDNrSE82ekxwT3A1S1piVFk5ajJJc3BRY1Jna09HOTQ4TFNoRzVEUkJHWkVF?=
 =?utf-8?B?bjJhbDBjS3Mwa2RqY3lnNFczQ0dVRlhTUkxaYmV0NVl2Wlc4alNLdFpOM3FL?=
 =?utf-8?B?NlI3TXBYdXJGM1FaSnB3eE9uSXpRSkxWR3h0UjkrQlB2RnRHOExVU1pxZ0ZI?=
 =?utf-8?B?Skd0NUtvVWVMamhsOGFCV1Q0YUlTNVg0MDAxcGZETW42N09DZExwTWhDVG5X?=
 =?utf-8?B?R2FocE5XaFljVlRkUzB1eVp5ME1IWXBnQXFtNWVjRVZtSWp1dWtJWE5KdDA0?=
 =?utf-8?B?QWJ1aVFFM0dzaHVLUHpjcWpDMTI4Zm9wMTdjb3hKM1dvZEtWTUhMQUwrQklr?=
 =?utf-8?B?OHVQaGpNdWRwN1pZYnBwaUgvSnI5Z2M3Q0tuSGpmeWVpRTAvUE02c3VUUm5T?=
 =?utf-8?B?RXJIV2pYYm8vWWJhaFdnaXZyZGo1OXk0MXJ5KzE2eWl6WWtnWWV5bEVSM3pS?=
 =?utf-8?B?ellEd1JjdVNpaStKNFNLWmZZN00xZkc4eXVHcngwSGcyd0k0aWxoVm5UUEhM?=
 =?utf-8?B?WWJPTU9XcXV3SUtWemRiSEYwZFJUS1ZIWWh2cEh5bEpGSkQzbVRObXE0bzlL?=
 =?utf-8?B?Umxxb1lHTUF0U0VSQlN6andQOGlBbktIU0x0T0hYNVRGVFQrVGFURzB2M09W?=
 =?utf-8?B?a0tBc1UvMjhkS0JuTEF6dndRSFJzOTZuVmh0bE1JNW9Ncm1sZGtiSEk4WU9I?=
 =?utf-8?B?Y2w5L3kvaEZ4dnR2b2lCTkRBMTJvM0dIeFV2Rjk2NXZFWFhiaUFCcExxOEM3?=
 =?utf-8?B?UFo0R2MycG1sNEwxMHo3NTZqN016Wk9DdytPMVh4Y1FVcDdvSVhINDBuazhH?=
 =?utf-8?B?L1VlemxlTHFnSENFL01VdkVHOUtwNjNuY2oyYSsrT3VMYXoyQlNlNTR6bDFM?=
 =?utf-8?B?T3diSjVtQ3lpQXdtaDRYaVlYT0JDZ1drWTREREdGUzhadkU3ZkVzTEJSZTdU?=
 =?utf-8?B?cHMvT0hTOVFmYnh4RXdvQjloOEFsZjE2Um82SDVyQXFpT2xtOWFCR0JsYnFk?=
 =?utf-8?B?VVhJdkFHOW9wVVArNXZkVmdGZFlSUGpSQlFRQXhWZVlBQ2ZCM3ZBd3BsNXFn?=
 =?utf-8?B?TEFiSU1JZ0pJWi9UYllVQS82b004VE9acGpudlR4K2Z3Qk1nWTZjaS9vNmFN?=
 =?utf-8?B?ZGYrRTkvTGZqRGRRK3oyQUFiaEQ5emtQYTF6R21OaDZoSVc0ZVZKazk1aVBN?=
 =?utf-8?B?ckRnMzdWUjlIeG5MZFZIbUN6cC9oR3RXNk9Nd2RiaW51djY2YTIzeTdaQWdZ?=
 =?utf-8?B?cEcwZTRNWFNWR1NlalErT05SUnB3WnFLektmOS9odGhaSlVuQU94VWdwcWJT?=
 =?utf-8?B?YldYTjZPYzBCWDlTcEhwOWwwMHc1U3RqY2VxZnk0RGlHbWFma2hDbkdnK1hF?=
 =?utf-8?B?ZjM2OEVYZFMyTWpqV3M3YzZDcnJUNTBtMnNmOEVUUm5aaDIrNGl3TURSWkg1?=
 =?utf-8?B?NVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: iQwcNvTaJ/hlJNWDsXuAh6j3Jwa8ght956kFvYPzFymb1FrJ8HXnlBxgfAvSPeUwzeWl8IWrOSfcilev0Es7BpzSVV8yRYZ4iHdLs0KMf4pBaKckXflwexjvQjrS/bRSXU3DQ3uIdQV/UzHWfzgqk8By8brara4nw506rX7K/ThZxz3EO+AuDrBbo+gEiYbjKcz2Dc4YCasZjqwQPXn3yxFcZB/sFCGheZAduLj2UCK3BIDietAC463wssUdfx67Usy+alhMhVTST26Ln9EvxufYY1TrPUYDzlZwX1e3yzSe2sW7lhhjSLOTWxifUKvkvaYyIb0FQhKIrzRaAPb0/4W4vo+mSlixFlgbXa5XmtIN1zOAimZIv5ehKIqH63f8URevnmk+AHwRRxwc9tylo81O9izVMUJ5137SmMiRWTQk1NTAPTCtz6FCPjT6FG0KjguTr/dUXLJ7hmuiRLU5ltkbAG1njvczgwjK/Xf73myH4f8vCsJrE+9GwzEDHhj90nADDIaW3nHk5IU/Ry125Al8bCPeCMa4QcVywyrW050myYqL7C5kOkiA0c/s5AoUKWYtb0VHRoPGwG9+qhPLi/XbvJF3e3Ox0+1Q+C6LhMw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdb6df16-b736-4780-772b-08dd45372198
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 16:15:24.7602 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bgkLRqFi1SOoPP7LqoNuTDw+nsbHtCqsoc9XXRYrBr1Ull+ybo8FLvh2nSuMdJxIw6zkq9MPEVkh9Kb4deU3krfAvLQ3ZE/b9gt1cQV2LHc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7846
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-04_08,2025-02-04_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502040125
X-Proofpoint-GUID: Gs64p4e0Cp7Ckaqu76N13AdyrI8giRop
X-Proofpoint-ORIG-GUID: Gs64p4e0Cp7Ckaqu76N13AdyrI8giRop
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
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

On 2/4/2025 9:56 AM, Cédric Le Goater wrote:
> On 1/29/25 15:43, Steve Sistare wrote:
>> Do not reset a vfio-pci device during CPR, and do not complain if the
>> kernel's PCI config space changes for non-emulated bits between the
>> vmstate save and load, which can happen due to ongoing interrupt activity.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>   hw/vfio/pci.c | 37 +++++++++++++++++++++++++++++++++++++
>>   1 file changed, 37 insertions(+)
>>
>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>> index 24ebd69..fa77c36 100644
>> --- a/hw/vfio/pci.c
>> +++ b/hw/vfio/pci.c
>> @@ -29,6 +29,8 @@
>>   #include "hw/pci/pci_bridge.h"
>>   #include "hw/qdev-properties.h"
>>   #include "hw/qdev-properties-system.h"
>> +#include "migration/misc.h"
>> +#include "migration/cpr.h"
>>   #include "migration/vmstate.h"
>>   #include "qapi/qmp/qdict.h"
>>   #include "qemu/error-report.h"
>> @@ -3324,6 +3326,11 @@ static void vfio_pci_reset(DeviceState *dev)
>>   {
>>       VFIOPCIDevice *vdev = VFIO_PCI(dev);
>> +    /* Do not reset the device during qemu_system_reset prior to cpr load */
>> +    if (vdev->vbasedev.reused) {
>> +        return;
>> +    }
>> +
> 
> sometime we use :
> 
>      MigMode mode = migrate_mode();
>      if (mode == MIG_MODE_CPR_TRANSFER) {
>          return;
>      }
> 
> Why is this different ? This is confusing.

I try to use local state -- object's knowledge about themselves -- whenever possible.
Sometimes that is less desirable.  For example, in pci_do_device_reset I test mode, rather
than add a reused field to the generic PCIDevice, because the pci code would not use the
reused field anywhere else.

- Steve

>>       trace_vfio_pci_reset(vdev->vbasedev.name);
>>       vfio_pci_pre_reset(vdev);
>> @@ -3447,6 +3454,35 @@ static void vfio_pci_set_fd(Object *obj, const char *str, Error **errp)
>>   }
>>   #endif
>> +/*
>> + * The kernel may change non-emulated config bits.  Exclude them from the
>> + * changed-bits check in get_pci_config_device.
>> + */
>> +static int vfio_pci_pre_load(void *opaque)
>> +{
>> +    VFIOPCIDevice *vdev = opaque;
>> +    PCIDevice *pdev = &vdev->pdev;
>> +    int size = MIN(pci_config_size(pdev), vdev->config_size);
>> +    int i;
>> +
>> +    for (i = 0; i < size; i++) {
>> +        pdev->cmask[i] &= vdev->emulated_config_bits[i];
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +static const VMStateDescription vfio_pci_vmstate = {
>> +    .name = "vfio-pci",
>> +    .version_id = 0,
>> +    .minimum_version_id = 0,
>> +    .pre_load = vfio_pci_pre_load,
>> +    .needed = cpr_needed_for_reuse,
>> +    .fields = (VMStateField[]) {
>> +        VMSTATE_END_OF_LIST()
>> +    }
>> +};
>> +
>>   static void vfio_pci_dev_class_init(ObjectClass *klass, void *data)
>>   {
>>       DeviceClass *dc = DEVICE_CLASS(klass);
>> @@ -3457,6 +3493,7 @@ static void vfio_pci_dev_class_init(ObjectClass *klass, void *data)
>>   #ifdef CONFIG_IOMMUFD
>>       object_class_property_add_str(klass, "fd", NULL, vfio_pci_set_fd);
>>   #endif
>> +    dc->vmsd = &vfio_pci_vmstate;
>>       dc->desc = "VFIO-based PCI device assignment";
>>       set_bit(DEVICE_CATEGORY_MISC, dc->categories);
>>       pdc->realize = vfio_realize;
> 


