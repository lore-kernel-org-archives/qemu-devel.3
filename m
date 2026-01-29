Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05FEFD73E87
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 21:50:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlZuO-0000Fl-Gp; Thu, 29 Jan 2026 16:50:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1vlZuM-0000Cl-6b
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 16:50:34 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1vlZuJ-0003tp-Qu
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 16:50:33 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 60TDgE1t676624; Thu, 29 Jan 2026 21:50:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=iBynS1Wn5eTpZrFAmOUWrBxOetlS0DeXknMxzZi1j5Q=; b=
 i9+kRbTdfjCn2GBSUJsxweObENf/COSV7gBEB5fkdyZXS1h+GpXzhKsCD+lqa1Ie
 r0XXHDTlLukgZiVk5tkcJQkAt2jmWfbZsVim3IGlv3EwNUDO/x8yWHzgDMTGs+sl
 HhH5PY/PbETZC3BeJf0+Un4/0eGlr8bwO/dhU5dAdHhN64SVtCxZFaSD/8AoSbFZ
 NGtLmZ/nd4VxmP75ChYT4Yfc2aSbfIdiOLdr3/V6GAgo2ebXWkUD9t5Xymo9U5wa
 xtcym8arPJG53oYvMzBrig0itK4CiuGWEB5Jq/Gc3KwxmHCXyM3EQDuN8N3EQE66
 kmB0FsNxWuz3WO9a3fFGqA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4by2vgm7nx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 Jan 2026 21:50:26 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 60TL9I2S035094; Thu, 29 Jan 2026 21:50:25 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11012009.outbound.protection.outlook.com [40.107.209.9])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 4bvmhcvfub-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 Jan 2026 21:50:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rflJ5nDfKi9TeA2GRFKoG1wTkVaaQFrFlMJvOz23aymDEppq4vrd6CR6tyCn5YpjB/gpZJuXxM5x8I9aFLgb4zoaY913GDorRL+biWUDCtC75bLTRn3F4tPShb0WWNi9kbyy14dkzjzZXUbB7k0NOmVAe6UfhT+yZS+sH+cjUZjVMkPh3JToZXAhXUj8xyhfPq0RhdFwE1Co70tF7Wn9gfF2jFU2VR1/cD1p1r/N/828HMszgpPNni2ZdHHK9/IQQIXbGJ9uXz+dOqboGi2iH/dD0pZf+w57m/y6G7TderQscgJ1X/30kcGqQ3PEKZgQ33uio9hAk5lHqLfFg6zvPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iBynS1Wn5eTpZrFAmOUWrBxOetlS0DeXknMxzZi1j5Q=;
 b=VAVxbKmEPSPK+MIqn57nBzeG5ABBzDTqsI5xYJ3XPZkuPtBlyWsb7d2wsaUxgHNG+lGueWYzUzDrWUfGu/BSgXJa55//xWErDFSJP2GMy5jgaSp58ns8kLQcf44NAU4ScB/KL/+UEJr0SoSQMHw8/IBIT+4/8hI50ntzqFlmq9yGmZSe/eoeGuXsfaa8K2GSgvbFIn3zErjmqjFHIoLA6EveY2fK8ViDmdRTq/KRFQVcxsc0h6/NdZFunGit+OIyfAWrPLcjBjrlGchKu6zZeO4d6USneI0uCr7S5opMw5BK/IPhWwddR7LxAV22SpdpBTunrX7CH+VEEcWjWpPUpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iBynS1Wn5eTpZrFAmOUWrBxOetlS0DeXknMxzZi1j5Q=;
 b=G2NvwH88IafNjtINU18FMVN3q38sBQumRngQNIo9n0DnOzKraLcOfKnI4l0UqML1Sh7TWqe/PL4Ws1RjQWsYcTmmQcUq0G/Ximg/8SSyFCWbDoPjJjjTXBSnoT463iTFJwcIWm0DAMyJXri8PNPY/fycru2Txzu5R95U6srFWdM=
Received: from DS7PR10MB5056.namprd10.prod.outlook.com (2603:10b6:5:3aa::8) by
 BLAPR10MB4820.namprd10.prod.outlook.com (2603:10b6:208:30c::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.8; Thu, 29 Jan 2026 21:50:21 +0000
Received: from DS7PR10MB5056.namprd10.prod.outlook.com
 ([fe80::b2f3:4d8a:2820:7082]) by DS7PR10MB5056.namprd10.prod.outlook.com
 ([fe80::b2f3:4d8a:2820:7082%5]) with mapi id 15.20.9564.008; Thu, 29 Jan 2026
 21:50:21 +0000
Message-ID: <08862b0d-5d27-41de-beb7-da26c1d894e6@oracle.com>
Date: Thu, 29 Jan 2026 16:50:17 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] amd_iommu: Use switch case to determine mmio
 register name
To: Sairaj Kodilkar <sarunkod@amd.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 mst@redhat.com, marcel.apfelbaum@gmail.com, vasant.hegde@amd.com
References: <20260129102814.4488-1-sarunkod@amd.com>
 <20260129102814.4488-2-sarunkod@amd.com>
Content-Language: en-US
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
In-Reply-To: <20260129102814.4488-2-sarunkod@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH7P221CA0085.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:328::19) To DS7PR10MB5056.namprd10.prod.outlook.com
 (2603:10b6:5:3aa::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5056:EE_|BLAPR10MB4820:EE_
X-MS-Office365-Filtering-Correlation-Id: da942451-d4f3-4efe-7f2e-08de5f806657
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZjRmU0pVWmcyeE9oS0VDQVA3Z1VLbm4yelBhSitxWDRzY3F0VEVOcGdZaHFH?=
 =?utf-8?B?Q0h5UjNkUnEvTG14MnZNcGM0QVdkTWZTdGNKOFRkVWIxZGFZc3IvN3RXQUFL?=
 =?utf-8?B?UGY0UHpRYWs0Ym5QV25oOFNRcExRS0dZRGd4TUlkcy9pankwMG1hakZ4SzNz?=
 =?utf-8?B?R2FMUC9GZEFwVGJCNXJFc3p5aGhsODlSemd1SWdya1EyR2Yva0EvWlhSOERm?=
 =?utf-8?B?eVh6TnZudm8reWE5NjlyTmcwK2Z5SkY4QU1zMkFDbDZ4VlI3cDZJWXV1a1d5?=
 =?utf-8?B?ZGdRNFBlblM5MGxzb2k4dkQ2UGN6VlN1NkM3Umt6a2ovOW9TdFA3T2IveFps?=
 =?utf-8?B?aTQyNE10RjFqb1M5M0huYmZ3MFFvbDQwY2hTNFdaRGxuazkySzBHZXB3N3hP?=
 =?utf-8?B?cnRJUkRVVlo2R1hZY0dUcW9KZDMyaXpWc2hXNEU2bGtZaXhwSEQyU2dVaUpP?=
 =?utf-8?B?WElHSnVPSjE1QXRmU1V3b3VpY1FEa1duRW1lREw0M0hiemlXZ0lQdGNSTTdV?=
 =?utf-8?B?VGhVTHBzTjVSTkgrc0VsVmY4QkFkSUdYeUxCM1Bacm8yRHlnTDh5OElOTU5R?=
 =?utf-8?B?eU9FLzNMNm1ZYkxZYlZOb3JYclRrK2ljRExzNkJYa3pHdkdZRGxJR3FJcUlT?=
 =?utf-8?B?a05NNTJiczBsY05Va1JCaVJ1T3BZVkFSL2FxbjZLeDdpT2RRTTVyOHlqWE0v?=
 =?utf-8?B?WGdsbnRNMHF0OUFiTFFSMUxRalRqYWRRUkE2MVRVTnNNMEU3QVkwSmJrTG80?=
 =?utf-8?B?OVFia3dKa0xHZmUybE4ydmxPM1BtUGZWK2FOZm9qakZXQTRLbXlMeUtqaVMr?=
 =?utf-8?B?bWR0UEhhT0FVSUdyeFVMUXBHSHRiaGNHelZEUGNvU3VRaDBPWEpNNThzZndC?=
 =?utf-8?B?dEt5WnVXbTdLR1pSa3VmYjZBU1N0OXJLQWR6M1ZxSG1ZNXVESUJhYUxYSThV?=
 =?utf-8?B?QzZBU1k0MVQ4Mmw0SFVKU25JMWxTK3BwalBmOVJOQ2hta2hyQzdWajd0VkpD?=
 =?utf-8?B?MGVKSHJiQ2NEejhPTU1hK3lMQUtxUmdTMzlsb2RxMzFFKzB1RzNhWjN0bFI5?=
 =?utf-8?B?Tko0MktlcytzTGUyZkExQ1BqaFd1TDVTdG9BekJjN2VjdVBINVFzQzdlczFM?=
 =?utf-8?B?NzBQVzRjeERYOFJWbjdscXN6eDE2T00zMVJOTXo1YlF0TFExcVZHOGZ2TEZ0?=
 =?utf-8?B?YlN0VkI5eEc3R09kK1VlRk53NkIzRjhRODNKV3RhQVUrditDSjlacFNzcTBS?=
 =?utf-8?B?SzZsTnliU0R0TVgwaGdFU2x2dkRiL2lOOUdPUnZTR3VIcnpoVGIycHBrS2JI?=
 =?utf-8?B?SFRsWURNdUY4ZmNRSW90Q3pMWUlMZG9sQUdqaTVRV2REODU3clh6WGprQnVq?=
 =?utf-8?B?RXMvaWRIUm5rTHYraG5NV0ZZdlFYN2JKSWJoK1ltdm5FTFp5ZFZBVStMbHdk?=
 =?utf-8?B?dzlCWXlLMHhKMWRDVkVxYkxWNk80aGR1elY0MnhhNEd0YlZNSHZ3cnRtQkhR?=
 =?utf-8?B?MjQ3OTI5eW5oRjdLSXN0L25OMld6dkRvZTloaGZlUERWNnMwWHVaUXRSNWIv?=
 =?utf-8?B?YW05VXZjZjRDS0RSNlRNciswMnA5TnlidW5pYlFSU09DL1JTeWN2MjV5Ui9G?=
 =?utf-8?B?d1NXTGlFcXRBV2tadERSeExrR0I4amR4ZVdDTndUYjhCQmdiQWxNVGRaTWpW?=
 =?utf-8?B?cy9UVTBzc2FKUXFTejNYYTFSY09IM3EycExUVXBjU1FWQ2xtWXdlTG1veFpP?=
 =?utf-8?B?VGQ4N3dvTW01NUVzVHZSVy9DKzVod29qQkp1RHFGYkxUZnlseVRTdXJ4SmFL?=
 =?utf-8?B?Mi9YZkhOUlZ2M1pwQmpkNWd2TGo5bmIxZGVGS3Znb2V1Y3NJZGtzaHJoeE4z?=
 =?utf-8?B?TG5aRmswcGNiNVdReHVyQWNXbUJMYjlOQk5HcmtkeUp3YUY3OEF1eENaYTVx?=
 =?utf-8?B?dXdseCtzV2Q5T2g5b2dneFZBOTA0dWN4dFZOak5vY0d6ZE5KNmFJNGxmWTdR?=
 =?utf-8?B?WDZwNGZtZzhTYmpkbm5lS1BDT013dWhBOFlKTjJvY0FYTTByYkJia1FSOFc4?=
 =?utf-8?B?aDIzQnp0SWY1bmdka1BJNGY4N2RiSCtxVC8xZEYvYXNtU1hkaEV1clg2ZE10?=
 =?utf-8?Q?jpMAaXsMSyN1o4/ozVru+TOGp?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR10MB5056.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2U3NXlKbHJVNytNWkVoU1JzaStBdUhDNEZ1VDVadENlVDd4emlBRitqRmNo?=
 =?utf-8?B?bkdpNjRrc21zMnpWOFpXS094WDZzZUVqOEtzVHE0d1lnN2c4dHJSSGt0bDdF?=
 =?utf-8?B?NnJLNlBSWWdOeEd0endXOFJ3ZG9QM0hVTjErQkFpUlJCWjVzc2hJRnpOT1Nr?=
 =?utf-8?B?MkxCL2EwMnpheThybGtHQVRPM0hVNjMxcTJjRkpQcVBoQ0VvdldwNWovUFBZ?=
 =?utf-8?B?ekowbGJwWFVsNTQ1Z1V2WlZjczZLeE85TElld3pNUml4MTdpdTVlcFg4bmF5?=
 =?utf-8?B?eWlhR0xlOGIrYVBqUE15cHdMOThUOW5BdE15RndpbWdTQThJRWliakxMMDM3?=
 =?utf-8?B?OUpWWnJJRUdkcHFyZmh1R1Z3Y0tSSHdiTWNjOUZuZWJmb1JJSGJHRjc3T0Zs?=
 =?utf-8?B?dlA3NlNneWd3cS9UVFhydmVwM2VvRmRpMlBoUjhMTUdTM056K09XRklHdXhT?=
 =?utf-8?B?bGxPajVsWHpvdWNkZVI4T1NCdzlmSURkWnZxSHplM1hpWlRKZlkrZi95UXFt?=
 =?utf-8?B?elcvMzZqaEhYbjRGZ2o1RDJPVkhyZy9wSldwWnZHTndvZVIzYUQwem1RejJF?=
 =?utf-8?B?VXJHN0hhUG9XTDdsWGxCV0NVcDZncFZlUG5VTjNYRXNpaWcxeXJYZVZpR29Y?=
 =?utf-8?B?Tmo4WjlCK0dFcGplclQ1YUs5OU5NYTg3UUt0OGR1NmZJeVpBbjBoYi9oaXJ5?=
 =?utf-8?B?VzMzVWxFWE5TNWgvcEN4dWI0SVMweGpSRUM4RHBvMm1mYTRZbmZQVVhsSGRG?=
 =?utf-8?B?OGNrVFp3aSsrNEM1c3RtV2k1bjhPN3U3TG5TcXJoaXV2ZTl5cytTMkpRRzlH?=
 =?utf-8?B?YW9LdCtVa2JsTFU1aDhuTTlpcFMzUS9iL2Zwb3hrdnA5U2N1cjZlV2ZGd2Nq?=
 =?utf-8?B?WDlzdE83K2wvYzVsdDNiZ05kaU4xa3E3MjNMMTl0SkFaMHAyUlNBUFEzV3kv?=
 =?utf-8?B?OGJUMThoVEZsc3h1dTBvc09tTUR1RnVwdkQwY1V5U0dTV2NhQndsNW1xRVNJ?=
 =?utf-8?B?dmJOR3NTRkpZK2NJcEpmcG05LzJkNXZWMU1YS2x0aWNBd1Focko4cHJjN3pn?=
 =?utf-8?B?QnppbEdtVEp3R2ljM2NWOUtlQ3k2Z2F4aVlDUElzUjRiZjNCa2hBbEcrUHVP?=
 =?utf-8?B?ZElsODYwTEwrSGpIZENyaUQwYnhWbXdnMURPd08xOG9yZDJ5d0dVNVFOMEcx?=
 =?utf-8?B?azNST3F4R2hlU0VnS3FwR1lOY3hJd2pTdzNneGR6UVdPZ0IzN0hobGtBNUs1?=
 =?utf-8?B?bXBNQUhkTkFNdUpiS1RWdDBTOUpna252ZElrRDRaOHN1YXR2Y3BTMUE2ejVw?=
 =?utf-8?B?cVVDT21neVhkRjRVREpEZ2N1Z205U2JqanpWbkppTEc4R2dYOEJFVmdPUVIr?=
 =?utf-8?B?TnFxSGd2VDFuRkd5OHQzUFVXbHBhbnJsVTFJTVh2Tk9LVXMzT1BveHhyMEJS?=
 =?utf-8?B?cTV4aXphbVFZNXpDaUpOQVpEWVh5RkozUC9ra1cxR0dJYXNQbDFVNDE3TEhv?=
 =?utf-8?B?TmhUMzcwaWlUOGZoMjVXSDI4dUNqNFA1Q005enBVU1lCWllNMlhCNU9NMkdo?=
 =?utf-8?B?Y3UrZjJhbFNVc1NYc3RWMklhQVNNQ1JQSnFFQTN2Rks1MlgzSVFnWDYxSURO?=
 =?utf-8?B?d2tTbFhqM3BmTHVQdmNCNmcyZ0JIa3hFS3c5NTJ3SWpmVlJxZUR5bDhqeE00?=
 =?utf-8?B?M3BaVmlRallxQm5rcU9yZUNhd3ZQRXFXZ0tUbXNncHpJWHc4eVNoY1BHVHQr?=
 =?utf-8?B?TE9vbHVldTAxNGM4WWs4bkVSM1ZkVWxzaVR3RkVJU1FEV2FrY0JMMWdTYkR5?=
 =?utf-8?B?bHpCdFpKaE44OFkxZzltNWJuSTlMOXJTL0doWHVaa3dMVEg1cld2cnJQSlJu?=
 =?utf-8?B?eEVtV1NJRW9WZkkrekJrS2dEOUt2QlNnWGpnZkJHK0poZGhxUlF3ZHdjYnNP?=
 =?utf-8?B?Mzk3STROb09YVFZEZ3QxQ25JeENpajViYWs1amtFSWx2MXc1Zkhhb2VITVIw?=
 =?utf-8?B?WEdzMW9RVlcrdm50UmRobXdXcWVqNkh4NWVpY1ZZMGF4ZHBVN3BJR1RXWVp4?=
 =?utf-8?B?YUVMbjJaR1dBTHd6ZVZJQUl1dDNlOEowTnBZQm1Dd1RzZi9ZeDZLM3hLMEFH?=
 =?utf-8?B?b3dFaXo1czY2WUxsTGV5Rzd6TWp5Q09YWFhGSlJKQmlyS25zSVliVWVOMnhV?=
 =?utf-8?B?eUVENUFiQk0yeTZpb3ZPVGthbnlyWWhpUWFJN0JrdEJFdEQvYXpDTlVJRG9z?=
 =?utf-8?B?S3BFVU01YVd5V09HTEc0ci9sWExZQmhHZFF4bHk1VTJIQWc5M3JnK1RqTy9v?=
 =?utf-8?B?WVdUUkdxUDk5YmZQS1FxLy9wQ2lWdDRnU2FsY1gzWGtMZE9jY0NTaDdDd3Bt?=
 =?utf-8?Q?/Kt6J8hpr4SopW4Q=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: wNQ6gHQqJw/vNb45iFFaQ6FE3Y032hnU+WyMKhDLBiAoaNKfSeah5hFZ0hNmQkGCqfq8BXzuZlr//D5/vqIVsbEfsgCvRD9qMYed43ctjtdG0krlXjOxfAS1p1yH6oBavkyjNgvm/jrse3NrfGymruW9zvyiAKp/9da//5zkt/10H3Usgxug/oUvlPX6kWm+AoCm+5jzoXv5HPnXdoC+PkpbBErz2OhX+wNEphe1n/lsHxwxJBLh60Cz9y6C9k+KWIUQgK+uNneYAL9Fr936ijkM7/wwmIx0C9L2+srtz06LkED4L2a7eivI4TSjfG4VVce/PTeIFI15FNT7CkYqMED8hTQXTzLZdcKijHzIbxecC1DxwF4yHCA6iwfv1sGUakLopzFNgxggQbr8F2r0qYCkcnfgk8fmVu5hrwOAixDaxKyn613Wg3aLFRoAcwaQCLgGxk/lHfswDAlg6uVr+IYR0kOzHKMPMErbAKVq6O6dj5rsXlME/YzOESOdvyMGt7YoNpLvWE3NXZbYi3phR2ZcNKX0HWSqZJ8fSmTQf8RUcb0doqWdDZnt+gzmaInu7fu7iqTrRc7WNgFC+o9J10gi1A+H0Q+MNrMnoFoCRQI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da942451-d4f3-4efe-7f2e-08de5f806657
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5056.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 21:50:21.3063 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TSQUznRlckmTsQJ3lH3fhouYm62L5BzO/kh4Abh6mBdHugILSraWGXYSsUJVt1M3YJ9pqodyxp1brEm58cjIdFm6wRldss4VeNLUohVXfnc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4820
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_03,2026-01-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 bulkscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601290159
X-Proofpoint-GUID: sGItCxJ62330lRVpBhlwrWuY28YDIany
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDE2MCBTYWx0ZWRfXwRJ0H1oCbZyY
 xKdAQiFhZ0iYbfJj1UdSvI/lF/nIbGsW1SrtDNUlocOSiw8nwXhXPbdjrWK9nWDwFwYun3yaZzB
 lNruWS/sOHMna6ElB4KdKHNzAtQVEAKLiGTfjyd0a/Fc0mxt2EsujNGGUTBQWaTMjP+V+gIiraU
 bL1xGeWVqQ30w/Hu4mQTTBtySliwEyimre8hHgDUp4dcu4s18vt0a9mNwtC6aFemPraddPFKTtJ
 3FAQiOQdEPXSNVptnEamsMDP6a+u0TOzYP++BPHDC+8j24vX2WXfNVh+UACor7joavTCLdcD3+H
 K13aQ+2gZN77ewUZ5tz0CKrKpPJaq2XFMS76hvt11j9hGOA7QwUlRWiKeL3xzpOqUzRs8pO2AVB
 mf4MqGgjXtdaRYt+OXvITDark3HUc4On+/vy5hHQ2K+WoSscBrZcdABjOFDpMTJeBnXzHVfZZo6
 76g285m0rHNxyhFvopg==
X-Proofpoint-ORIG-GUID: sGItCxJ62330lRVpBhlwrWuY28YDIany
X-Authority-Analysis: v=2.4 cv=a7s9NESF c=1 sm=1 tr=0 ts=697bd622 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117
 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=zd2uoN0lAAAA:8 a=Z16Uqo1bXYm27cccAF8A:9
 a=QEXdDO2ut3YA:10
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0b-00069f02.pphosted.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 1/29/26 5:28 AM, Sairaj Kodilkar wrote:
> This makes it easier to add new MMIO registers for tracing and removes
> the unnecessary complexity introduced by amdvi_mmio_(low/high) array.
> 
> Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
> Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  hw/i386/amd_iommu.c | 65 +++++++++++++++++++--------------------------
>  1 file changed, 27 insertions(+), 38 deletions(-)
> 

I'd like to also remove the unused AMDVI_MMIO_REGS_{LOW,HIGH} definitions
and amdvi_mmio_trace_{read,write} helpers as I did on the example diff in:

https://lore.kernel.org/qemu-devel/eaf49cf3-e56b-40f1-974d-207969c7371e@oracle.com/

assuming you agree with it, no need to send a new revision, I can add those
changes to the current patch.

Otherwise:
Reviewed-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>

> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
> index 789e09d6f2bc..62175cc366ac 100644
> --- a/hw/i386/amd_iommu.c
> +++ b/hw/i386/amd_iommu.c
> @@ -35,28 +35,7 @@
>  #include "kvm/kvm_i386.h"
>  #include "qemu/iova-tree.h"
>  
> -/* used AMD-Vi MMIO registers */
> -const char *amdvi_mmio_low[] = {
> -    "AMDVI_MMIO_DEVTAB_BASE",
> -    "AMDVI_MMIO_CMDBUF_BASE",
> -    "AMDVI_MMIO_EVTLOG_BASE",
> -    "AMDVI_MMIO_CONTROL",
> -    "AMDVI_MMIO_EXCL_BASE",
> -    "AMDVI_MMIO_EXCL_LIMIT",
> -    "AMDVI_MMIO_EXT_FEATURES",
> -    "AMDVI_MMIO_PPR_BASE",
> -    "UNHANDLED"
> -};
> -const char *amdvi_mmio_high[] = {
> -    "AMDVI_MMIO_COMMAND_HEAD",
> -    "AMDVI_MMIO_COMMAND_TAIL",
> -    "AMDVI_MMIO_EVTLOG_HEAD",
> -    "AMDVI_MMIO_EVTLOG_TAIL",
> -    "AMDVI_MMIO_STATUS",
> -    "AMDVI_MMIO_PPR_HEAD",
> -    "AMDVI_MMIO_PPR_TAIL",
> -    "UNHANDLED"
> -};
> +#define MMIO_REG_TO_STRING(mmio_reg) case mmio_reg: return #mmio_reg
>  
>  struct AMDVIAddressSpace {
>      PCIBus *bus;                /* PCIBus (for bus number)              */
> @@ -1484,31 +1463,41 @@ static void amdvi_cmdbuf_run(AMDVIState *s)
>      }
>  }
>  
> -static inline uint8_t amdvi_mmio_get_index(hwaddr addr)
> -{
> -    uint8_t index = (addr & ~0x2000) / 8;
> -
> -    if ((addr & 0x2000)) {
> -        /* high table */
> -        index = index >= AMDVI_MMIO_REGS_HIGH ? AMDVI_MMIO_REGS_HIGH : index;
> -    } else {
> -        index = index >= AMDVI_MMIO_REGS_LOW ? AMDVI_MMIO_REGS_LOW : index;
> +static inline
> +const char *amdvi_mmio_get_name(hwaddr addr)
> +{
> +    /* Return MMIO names as string literals */
> +    switch (addr) {
> +    MMIO_REG_TO_STRING(AMDVI_MMIO_DEVICE_TABLE);
> +    MMIO_REG_TO_STRING(AMDVI_MMIO_COMMAND_BASE);
> +    MMIO_REG_TO_STRING(AMDVI_MMIO_EVENT_BASE);
> +    MMIO_REG_TO_STRING(AMDVI_MMIO_CONTROL);
> +    MMIO_REG_TO_STRING(AMDVI_MMIO_EXCL_BASE);
> +    MMIO_REG_TO_STRING(AMDVI_MMIO_EXCL_LIMIT);
> +    MMIO_REG_TO_STRING(AMDVI_MMIO_EXT_FEATURES);
> +    MMIO_REG_TO_STRING(AMDVI_MMIO_COMMAND_HEAD);
> +    MMIO_REG_TO_STRING(AMDVI_MMIO_COMMAND_TAIL);
> +    MMIO_REG_TO_STRING(AMDVI_MMIO_EVENT_HEAD);
> +    MMIO_REG_TO_STRING(AMDVI_MMIO_EVENT_TAIL);
> +    MMIO_REG_TO_STRING(AMDVI_MMIO_STATUS);
> +    MMIO_REG_TO_STRING(AMDVI_MMIO_PPR_BASE);
> +    MMIO_REG_TO_STRING(AMDVI_MMIO_PPR_HEAD);
> +    MMIO_REG_TO_STRING(AMDVI_MMIO_PPR_TAIL);
> +    default:
> +        return "UNHANDLED";
>      }
> -
> -    return index;
>  }
>  
>  static void amdvi_mmio_trace_read(hwaddr addr, unsigned size)
>  {
> -    uint8_t index = amdvi_mmio_get_index(addr);
> -    trace_amdvi_mmio_read(amdvi_mmio_low[index], addr, size, addr & ~0x07);
> +    const char *mmio_name = amdvi_mmio_get_name(addr);
> +    trace_amdvi_mmio_read(mmio_name, addr, size, addr & ~0x07);
>  }
>  
>  static void amdvi_mmio_trace_write(hwaddr addr, unsigned size, uint64_t val)
>  {
> -    uint8_t index = amdvi_mmio_get_index(addr);
> -    trace_amdvi_mmio_write(amdvi_mmio_low[index], addr, size, val,
> -                           addr & ~0x07);
> +    const char *mmio_name = amdvi_mmio_get_name(addr);
> +    trace_amdvi_mmio_write(mmio_name, addr, size, val, addr & ~0x07);
>  }
>  
>  static uint64_t amdvi_mmio_read(void *opaque, hwaddr addr, unsigned size)


