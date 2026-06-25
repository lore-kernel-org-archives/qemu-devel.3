Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89D79CDB479
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 01:08:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcYZg-0001Lz-Js; Wed, 24 Jun 2026 21:08:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1wcYZc-0001Lh-PD
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 21:08:08 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1wcYZa-0007Id-8u
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 21:08:08 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65OEaCa82556478; Thu, 25 Jun 2026 01:08:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=rIjYjQXeUNYM1QrFhV0HjwubMMr9mqIKUgWXyAPHtAs=; b=
 P8NEYy83YRH0kJJBu+QVGx2bI0KrIS7Tim0SZ27i0pf+1a40ZpRZntLZmRxIQera
 a8wnr4l+CoTsu/mNa1F6KZ07QuyXm0+PZd++P/B+LSP1AQj5iplaaPWYG89ebTJV
 HK+YhQfWaN8rELtcwiR3V8VxDzQ5MojtnmvW6hnNDioPPTr574Xl5yoHZi6sQ5SU
 75keBWJ4CgAFEaRas0d4C9TG8O6kp667WqGAFLK217OMKDghDAPR7+QNff5yyNdR
 LIF831PBfj28McDChcqQNwHPTpCU8UDM0Fv+jUNKHYM4I5536A3QfLz7HXV+71CB
 GgIrw2BceOwaiptb2d419g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ewke5petn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 25 Jun 2026 01:08:01 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7)
 with ESMTP id 65P0wk9K035504; Thu, 25 Jun 2026 01:08:00 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazon11011060.outbound.protection.outlook.com [52.101.52.60])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4ewhas1tdd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 25 Jun 2026 01:08:00 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hAspeaZo5/vZM4Z4ewcaWvEOKI2s0FKWiJwlDrQDa7CXe/lOU7pwwV6gxAS5GUg8Lc8sTT1Tmyk+H6REPWIpRSX+lzQc5nTHUfGdW7xRXflGm/x9tnL/90kSlJKovYoL1gaucUdBuT9P/uEH4nEB9rVTlYYEUiNMzZKOkeAU2ztML4/iZyo0OBow54i8bvIzieZXPteqG0nawvcQ3wZ9NVlm/p7naqHrN0iDx56koaLB2XGTMkNvx6AT1d2uqqLGHG8LP82ejhJb+llT4wWSiZnGWsi8R6iLyS+g5zBWBL7qG0FZPcppvvDhLu7DG65kNoPPQSfbsuy8/Dq9n0aGLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rIjYjQXeUNYM1QrFhV0HjwubMMr9mqIKUgWXyAPHtAs=;
 b=by09Q4QzYdzPvqvB7D45KFvSMPpVASthSPxBvOfugJZZWbDkFuFKdboHWFraqUAdwZ3rQxc6x8fQgelaBy7nlj2aquc0lGDyxkoVsAGhQC2sUSvHHwN+Y+ZK6sxSmqvPmSJqNMU9ddna8Mb7EPmHPkpVQqDZ6wBDUVi5qV2jlEDSr7sB3OWI9PWjWojCkoGFi/PlrP1iru0GjyHrhUbA10175vn4OcDdoFph7JXJ2RFP8I4tPjnvbi2zxwlCUWjAkVc5JOrXRTHXGnTA9QWGdaiddMkasKlMecIIH2+ydi5Gt5rjD+GdDxZnlQvuur796IUbtKwipP9o34DJ9rgliQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rIjYjQXeUNYM1QrFhV0HjwubMMr9mqIKUgWXyAPHtAs=;
 b=X62tWsmkN2HsCA/cwQ93NRsRpf2BPq3Won1z0IdwuIGqLeJUkfOAuI4zJ5Xe4YUiWghfjC/xxbdBdnm7pegjsoDh0GBoMhSxplhR/39nJEhSp8QvNaN8d7HPBhIqOs9nJY9IEXp8yoFZxt0Q6k+V8KKvq32yxaaC23rylXWv7no=
Received: from BN0PR10MB5109.namprd10.prod.outlook.com (2603:10b6:408:124::23)
 by PH0PR10MB4616.namprd10.prod.outlook.com (2603:10b6:510:34::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Thu, 25 Jun
 2026 01:07:58 +0000
Received: from BN0PR10MB5109.namprd10.prod.outlook.com
 ([fe80::d9fa:7ad2:804b:bb83]) by BN0PR10MB5109.namprd10.prod.outlook.com
 ([fe80::d9fa:7ad2:804b:bb83%6]) with mapi id 15.21.0159.014; Thu, 25 Jun 2026
 01:07:57 +0000
Message-ID: <f537ffc5-1f5e-4cf4-a197-6a06eff85079@oracle.com>
Date: Wed, 24 Jun 2026 18:07:54 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] migration/cpr: Add HMP support for cpr-transfer
To: "Dr. David Alan Gilbert" <dave@treblig.org>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, farosas@suse.de,
 maciej.szmigiero@oracle.com, mark.kanda@oracle.com, bchaney@akamai.com
References: <20260621072646.517545-1-dongli.zhang@oracle.com>
 <ajp7GduDZGjei3Gz@gallifrey>
Content-Language: en-US
From: Dongli Zhang <dongli.zhang@oracle.com>
In-Reply-To: <ajp7GduDZGjei3Gz@gallifrey>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0271.namprd03.prod.outlook.com
 (2603:10b6:610:e6::6) To BN0PR10MB5109.namprd10.prod.outlook.com
 (2603:10b6:408:124::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5109:EE_|PH0PR10MB4616:EE_
X-MS-Office365-Filtering-Correlation-Id: d00e33c2-6935-4bca-d8dc-08ded2563180
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|376014|1800799024|23010399003|3023799007|56012099006|22082099003|18002099003|4143699003;
X-Microsoft-Antispam-Message-Info: 2UcG/poqIA6QkXTWDLViSPnGNbC33N7iV3I0/Mi1vDwXEJTpXf1ICxL5W2FFXzfOWGf7s7Df/6uAq6wCjoc9kpn+TONOlNPgvjGYISpu+HbEpj/f5ub3SffL7+2KW7r6sNSw6fIvKQ67s4/ecT7BzMMk0ocJABuqoTvH9i1+0d7qNzxkTYnKu/KK90p9bjkfyw9XcauRQHDFp9nFEyoEbvMazrp28Br7l/JlEqP5m+PcjEzrYlo2qJnXUQAYW3TULvWAiV8Z99rW932P6x7sYNV3maHYktcAHECxm4RubL0Arjv/4GLy8mw9bd7xTU/DsBjpnSXPlqcfxHf3115WfBKnH7WMk/uX6WPEf89ZEzTCjs8Dl8+2DVv4ADyJTuPhmNUbqw+BMS7NCEhkxbKh8G6LlplpsN40oZNq9t6L+YnTa6xXptYvymh6ZbERkEzfK4psfXcdmO1Vmx25ChBmpWewXV8VaZnEh6htQn17I0GU2dn28JMfO30MdD+x3x28VN29+SOqkgFOvGcCYoXb8LXS5dcaYoqV0/4Fsxo0mtWC8SpJ3f56Yb0wV5PrX4LbHJtTgWQA67PrTO3U2UyCHYO1rQ8WCT3f36fC6yceOCxPS79qUCYKCUSc86zWT3Bj2ZFaH0Pkfp1NIsEWQDTZfzVS1AN3kj4YqOBd1dPqweU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN0PR10MB5109.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(376014)(1800799024)(23010399003)(3023799007)(56012099006)(22082099003)(18002099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?REVKcCtmNVQycGRIN1VXOEI3WEtrTHZnc0I4WXdxZHQrS1FhNGJkZmlxUUt4?=
 =?utf-8?B?RzNQSldiNVFzaS9Ya0xsZW9xRnBRelF3Q0NrQkVMYkpwMVVSRnNSdEg4VFpy?=
 =?utf-8?B?aTdsaHYrTVdkWEJBMTl3d0NNK2phR3JvOVZlNVA1cjZlbi91d2RrKzM2VkJm?=
 =?utf-8?B?bUlLcmZ0V0xqZFhMamlGTGxFbUJXYnNEVjZIRVVveTM5QmR4aGNHQi9hR0tJ?=
 =?utf-8?B?Z014ZmpBcVF2Y0NMcXMyM0o1WGIzN2NiL1B1OW40QlpyNTVEdzZjVWd5R1dx?=
 =?utf-8?B?OVduYVJJNzF4c2NFcVBNWG5jSitEazBUeGMyWWdvT2p4MklMZzRvOSs1UDl2?=
 =?utf-8?B?NlJZTzdzVk5PMGNXdndkckwxZExROGVsb0tqejRNODd5K3ZWQStvOGtZUU9v?=
 =?utf-8?B?bURIeWNJcEd6OG42eVhIM3E5NlNTOElzbGZRbTFvWHdDMHFubDk1ekVoMGVn?=
 =?utf-8?B?TThPVW9qSDNVbjV4U3RvRE5wVjQ3a0RBa2RLZkdWWUlrZHhtK1ZNdXdvNDY0?=
 =?utf-8?B?UlV1U205eDNSUTh4aVhSdVBicGkxS0V5T3NhcmRjR1JnUWVwTWZCUjY0cDJx?=
 =?utf-8?B?WUpLY1RmTEhFN2VlZHFCTnQ4K0FMeU9aSnoySkxILzBPZGZObE50TmhTcVU0?=
 =?utf-8?B?cnNIOFRsOWM1elBqamJ3VnNCWWRDa1JmWHNNcXNPMXM5VnYxZzRWZUtOMDln?=
 =?utf-8?B?NC9JVGNOSzRHd2xwczN2bU9Tdkd6WHpvcXpQdjA2V0szZXhhOG95TDVVS1Z3?=
 =?utf-8?B?MlQxamFva3gycFJzM1c5QTcraERXSllVSGVVaFkxcThiMVY4OGl5VnZ5Nnpz?=
 =?utf-8?B?S2dYWHlDc1dON0RuN0QwMlhRWFp6MXBZZHhtNVpuaG5EL3VXQ2Y4SEtmemJQ?=
 =?utf-8?B?RlV1VTAwc2RPa3orNHZWZkhlZlN1UEE2N2lyemdoanlJS0JtM01adXpaV0hz?=
 =?utf-8?B?ZTZNenozWDBJNktqVzZMWkpsY05qeUxwQ21saW1zR3c4aFA3Sko0dkNubzBk?=
 =?utf-8?B?RnpGTFlxZWhlbi9sTkNpOTBsTEJWa3FZcWhwbjVIckgxeXhPWnJkV2FxTHhB?=
 =?utf-8?B?SXh6WVpvaDlvTDdvV0Zua1QwZUcwT3hObWpxOGI1THUzMUNIZ3RJeUlTaVdQ?=
 =?utf-8?B?bXFTWUc4dlBlVU9MNk5PQmFGaTVtRXRlTUVIaVFvUG52WWhQNXJrZ1JGTm0v?=
 =?utf-8?B?bm96MUEwUEpHZUw2c2h6T2pEMTIwZ29ObkY3SWl4bTdHcmpBRDNtcEJpVnRq?=
 =?utf-8?B?SUdvNHNVZ3ZUdDlaMnlFV2FTZUR2U2tlZEZFRWgxYTlPQWNMMVYrb1NVcTFW?=
 =?utf-8?B?R0xrdTNtWGhNQVhGbGZBeTJyeld0TGMyZTJTb3Bpa3B5VHA3MEtKR05GRHI3?=
 =?utf-8?B?bmYzKzMwdE1HNXJtQkZiUmwvZzVBaDBibi9KbzN3cHAyNnpRREk1QUNDZENt?=
 =?utf-8?B?c0pQbnBzbExqZ3Q2SG55bTdJRDQxK1VoS1V5Z3ZmeSswVTkyTTRtM1dJaXB0?=
 =?utf-8?B?b0hyTXhudkpjcXpUdlJXeHdvK0NTRnJVWlRmOC9Mb1JMOEIwWkFzVVc5UVFr?=
 =?utf-8?B?azM3YTRUOVJqZHd4SHFPd3ZBbTlDNE9KanhUeW1qdHh6TWlsNE9nN3IzTStp?=
 =?utf-8?B?TXdSQWp2QW0vNDdvUHlSN0lCU2hBblNjZk94ZEJjMzlMRHA3bnh0d2hkcEQ2?=
 =?utf-8?B?Wk80REZsQ0pTMTZITHhLQ0pVWlZnaCtzc3Y0VU9icEV1THZySnJrbnU4c2FU?=
 =?utf-8?B?d2dlN3UzbXVwNWtURVd2T25LVFZNSEdYK01sRHhHaWp3OXI5dHBYSk5pdnd3?=
 =?utf-8?B?VmU2ZGtPUGhBK1RoV2VIWG5Cbkl4dUxCTmFYY25VT1I0ZVVSaXAya2kxL0d3?=
 =?utf-8?B?aUJKMnFFbUpENHFBMTdid3U2dmZDNHpwQVBlTHFVL3k0bHZLcVVGOTNlMVpK?=
 =?utf-8?B?MUZuaUpYY0tNY1BlL0JFeG56YktsaGhFeGUvZTdVNEdnUEU2R3hQZHJZQUMz?=
 =?utf-8?B?T1hFcFphNGdUNHJycFJjSkhZTTZuaVo3U0c2VjRhQllSVUM3NnRuV1VNN21q?=
 =?utf-8?B?OWppZE5GQWJOTFdFeUYxSlpWWWFxczlPYkQ3SVBOUTJNY21JRHRONEliOVFq?=
 =?utf-8?B?NkJDbGNFamk0anNpK2w4aldBcWViZVZYaGw2bHlzc2p2OUFEOTJOWFFlRmNz?=
 =?utf-8?B?ek9VMDdCT3Zzd0NTMmh5cXpkR080eGNGS3BsY2VFZDdQNDBXcEluWGdVZnFy?=
 =?utf-8?B?VTNVNEZ5OWE0ZS9UOWNYYm5iV1hjUkFKM29nZXFaM1JhemVlaWdYQzI3UGdT?=
 =?utf-8?B?SHRIS3ZWZ2xXRlBReW1HSHpxNzZPbG81eHJWbkdkM2ZaakRGV1I4RVVCa2xV?=
 =?utf-8?Q?TLF8ckFGnE01dKD2JMl4Q1CIy/VvpSoVgIqiX?=
X-Exchange-RoutingPolicyChecked: D40dms3emVOY+vvWhp2k68JidC/jVfXiS2ZNKsNQ4EIZXdDxB/K/y8685IlL4Llm8M60SJK8q3cd00qpkQj6TER1UgwdTgdfDY0Yrqg8BLhavmGwRLwTtpOcXms8iXCe8nJFnTMmJFcXeWcKAnKAMnZ6OMi0n7QZdPApAdtBYGnCI/7uOnMuuBH8aBlIdws65Y/scaXglkHFjwMxcruEmyBplkbEv2DQH2aKeC7EuaCVrO7E7dMTZmBjk6iOD10M9TjEwWDJtiimuRxRVGbg5Rmt+OE2OYmqClepCpLUfRuCKC3D5w7qI0C3i4p0n8InwAVGE292gYNXi/bg6JENxQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: s+Xj7/tVPHlw8AqkWc2nXt9AqnmLfhptx4s/jFFR4KdaSEZRecJSjOM3f0AIzulZdmJq/LckkQHmPbOaTJY8CLat3hPVzoRAtlmbl1HDJDYA2+moUDV0KDCH1JkCVaPNYnFFcKSEX9bd5fAzWmq6lLa1nHGvo7jnpnSFS754gw17MFOhFKfJC0IEUTJfNngTYkDqwPJBJV2nSk5IMk5dWvRPTlBbphf17vfniOJl7K7O6CWPnifiEzSlAzjZzCZ18dtjVY/daGlMwPC9SRcFxLfJMPDUal44ouYVNRNYVmyTYCmLy2goCVsps5oSUyw9WK2gldF8WaNe9MvIEBYP2dxAIwqplVPggl26wVzQHIP82oWOmze8j+qfr+CjWlWbIetw7SBPXrbOzjyIZd4/ErBmXCQnxYpmJ1FFujxi2gwt9Jcu5lHrWcUVHAyJxreTp6yiMhuN4H5GFx8vML5S5IZAffQ85A1MQHaha27qrhvJ5hl+IKtmimuD9UNp1SStbaScXlpzW1fephw74DRcwkMi/2TI+CeaW+LI26UMvgNDEvfmb0khUcDdTeadjIUlDoOHgd55N0Cab5aY5jAnq/aGT255gTcoZiPH0/sKfmc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d00e33c2-6935-4bca-d8dc-08ded2563180
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5109.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 01:07:57.8551 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SSye3nMpPW3ega92e2uFcuuHyp+PYggzspoM32tyH1kcqwhjZGIizX9B3kH9eKnhdkf37ZzMT5tEoY+MJ0Xadg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4616
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_04,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 phishscore=0 mlxscore=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2606250006
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDAwNyBTYWx0ZWRfX3cdIdbY39hKg
 1kyWpAr+V1tRKCQXq7hulxP5mbHn2O/5UHOkmakr8pcHzoWs4LySSVBCfbZuSF5tAJmgSx5Hhtz
 kmRFliznyfe2N3yW2TW+WBxCDyob8ronor8Sy3pqX698MUOmtKp1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDAwNyBTYWx0ZWRfXzx+eacw14Vzs
 t1X96QfasFnYquuxA7WopcZP946FT8HMecxjcddATV+vjY3EVSs6RHSJBekrqfx1S0bTOpKbW26
 pvEGj/iuVTriVUaj5cgNhaR+2Or/UGvrh6iB37vZCRyV96ksf9eL8Q0AaBa7Qyxx2YoNsk1hmpU
 aJmBBOTcl/jaB2J7rGr6oKIkynVtztN95DBGwnjVT/qLoeKUUfsz5IqwDJ/oGOMS6t8xTvkB+db
 asEzzupS9jj+n+Vs4yPtX6OoiLBIeOgUe6VWFeOnNAKjQ9dCSILLmDD7BsSdsyDqE1XDRH6tkOl
 xBp+AZeLVMDlysuM5W4JbZ5PeC0236H8taaKzymEBPedFIhv+gitTYweyhOM5Htzf08g+LIZpDJ
 LwlRWPiYqzjMi3LyviI055XzAQqGrXe+B/f136Dg5ltQ2qLSbrd622fXx7L30W8Gtl7Mgrh+vBv
 +bNbW8WomTNxlFjexQdOwDaBGNtyyUQuXoWxhStQ=
X-Authority-Analysis: v=2.4 cv=U/+iy+ru c=1 sm=1 tr=0 ts=6a3c7f72 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117
 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=7Gl3-_t3PgB9XO-mQDs3:22 a=yPCof4ZbAAAA:8
 a=Znik6m9QQneHYaKQTDsA:9 a=QEXdDO2ut3YA:10 a=5yU3S35YU4bGjq-dph-N:22
 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13723
X-Proofpoint-GUID: JtO01nk8Aed2yakeC-CBChJIojzehML8
X-Proofpoint-ORIG-GUID: JtO01nk8Aed2yakeC-CBChJIojzehML8
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=dongli.zhang@oracle.com; helo=mx0a-00069f02.pphosted.com
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



On 2026-06-23 5:24 AM, Dr. David Alan Gilbert wrote:
> * Dongli Zhang (dongli.zhang@oracle.com) wrote:
>> Currently the cpr-transfer source QEMU instance cannot be driven entirely
>> via HMP.  The source must use QMP in order to specify both the
>> main migration channel and the CPR channel.
>>
>> Extend the HMP migrate command with an optional CPR channel URI. When the
>> migration mode is cpr-transfer, HMP uses this URI to build a
>> CPR MigrationChannel in addition to the main migration channel. The new
>> argument is rejected unless the migration mode is cpr-transfer, so existing
>> HMP migrate usage is unchanged.
>>
>> For example, source QEMU HMP commands can be something like below. The
>> "unix:/tmp/cpr.sock" is for CPR URI.
>>
>> (qemu) migrate_set_parameter mode cpr-transfer
>> (qemu) migrate tcp:0:50002 unix:/tmp/cpr.sock
>>
>> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> 
> Yeh this looks OK to me; I don't see a check for if you do:
> (qemu) migrate_set_parameter mode cpr-transfer
> (qemu) migrate tcp:0:50002
> 
> Does that get caught by the qmp_migrate or should you add a check here?

I did test this before sending the patch.

With cpr-transfer mode enabled, missing the CPR channel is caught by
migrate_channels_parse().

(qemu) migrate_set_parameter mode cpr-transfer
(qemu) migrate tcp:0:50002
Error: missing 'cpr' migration channel

... including when the second uri is not a UNIX domain socket, reported by
cpr_transfer_output().

(qemu) migrate tcp:0:50002 tcp:0:50003
Error: bad cpr channel address; must be unix

> 
> I do have a slight preference for using flag optional parameters rather 
> than positional, e.g.
> 
>    migrate -c unix:/tmp/cpr.sock tcp:0:50002
> 
> but I wouldn't insist on it.

I will follow this as Peter also voted for it.

Thank you very much!

Dongli Zhang




