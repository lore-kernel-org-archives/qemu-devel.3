Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21B71C02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 19:11:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYrju-00055E-9j; Fri, 17 Jan 2025 14:10:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tYrjg-00054k-UP
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 14:10:29 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tYrje-0006cK-Bc
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 14:10:28 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50HIBtDs001084;
 Fri, 17 Jan 2025 19:10:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=9gAczQ+GBsBbk5pOySwt8WBHue+bLVit/R4geFvOyfU=; b=
 lhhotYZPOMD7J4YZUjR4uCeWGg8SaodZInAvSNqPherE3MqRoqKxbJyUcRciHCcs
 T5fvrrRe1V1Zdv5Mt6yeMrzZvILEgkBfO5X5o/U6E5VV2cybWaS9eFLCM0drAZIi
 MIh3q5BS5flIXtzso2nN1f79A4HL7/mZ03ltzrIO+9U1OMLts5nnnaSc+EJt97js
 CYtsjGETWcqCRPv1KfkVFwFyF16ZFJQHOWCESkCgtihr6e+2yi+nfyvcIikuqHFO
 AskqXMXA1k/YgozuuWdboyUBeB++QJLe1FN01lg+KPsZ40UxLOENy//QBCyV6n+R
 Ql12Cq1bItEwpA4YrrgLGQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 443f7yd69g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 17 Jan 2025 19:10:22 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 50HIlw92020355; Fri, 17 Jan 2025 19:10:21 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com
 (mail-bn1nam02lp2048.outbound.protection.outlook.com [104.47.51.48])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 443f3jw1np-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 17 Jan 2025 19:10:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bPInyLK0d1tpxC7fqzJIF9+yhKBhDr12gZrqqvy3m4EoEXD6zjxnj7vnmx8U2fkRS84WLuSVUB4CoRqNtb75lwb5g256gMzXTEgfmTdaZtsRAzcYaosFe8ujrh4HcbuOI2e4uY74ZyU5Rxlp7SAZs3Wd2t7q7N/wQvZsWFWqpodVv2zRlvHBRSXDQDnmJDGJpIt+egMOpGLfs9tg8AVi1cH/Kul+jRnThBReLY0yG5/IH/bHE3yiq1owXAL6xgng2rctFS5XDg14u5xpFsbP+hGtwhMbXpbH7ns6lwjeYo/7m7ooh9R32+7yLXE8K5boIevhe8h5mmLzyuWILZ9kuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9gAczQ+GBsBbk5pOySwt8WBHue+bLVit/R4geFvOyfU=;
 b=Q0/C87yUs5FZfkdA0A7OAdiWULAaHvR3kYU75zz2S2j8U7BFi+8cZcAPt08dakn9Cg/XTbYjyil5lDmG9KajEIuzVsn/l9ZxJeb3Vv0M9MTdCVitMprY9swefPEQcomrVIMDBA5CkvXkrKSjVmyY4T/SFOx7ayOi3d6J/m4zMqpWctW46F152lEqF+WDfW7xBZUWxM5qXBNAkpYYMEDa8FuyVKlv2E7S6pBlpTaJk/BwX2I9H8JVsIs1CUwZAyxwsO4vAuDO/TkZjK/IDTfY6T232w3pIE0hHPlNQDl6rghKaBsFgEP5ZzvCwrpa4loimNUQNuQjyymlACZGWKEuxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9gAczQ+GBsBbk5pOySwt8WBHue+bLVit/R4geFvOyfU=;
 b=oVjSGsuHRCZB6xcEtAwape2ibQ89E4ETVmNplvhk7tEkvdUjLuitsRmOz2xYIJDCxGA9+IC+CC4f0thCjtbqiKGdwN8EeqxasZbscB+B0j0htHmHCrngdx7O2zJcbvmhgyogcCtsOGW1s+GjH/uNyeHSkIG2WTHwTl06exszbBI=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by CH0PR10MB7483.namprd10.prod.outlook.com (2603:10b6:610:18e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Fri, 17 Jan
 2025 19:10:20 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8356.014; Fri, 17 Jan 2025
 19:10:20 +0000
Message-ID: <814d9205-8ba5-48a8-9940-6f16bbb097eb@oracle.com>
Date: Fri, 17 Jan 2025 14:10:14 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] migration: ram block cpr blockers
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <1737135971-132839-1-git-send-email-steven.sistare@oracle.com>
 <Z4qelNxnBcgO87go@x1n>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <Z4qelNxnBcgO87go@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR01CA0034.prod.exchangelabs.com (2603:10b6:a02:80::47)
 To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|CH0PR10MB7483:EE_
X-MS-Office365-Filtering-Correlation-Id: 24aa9ad5-6715-4b43-823f-08dd372a95d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SkF0T1lPejFwTWlCb2dRaXRLVjcreHowNWFneHZidkJjMzg5a3pNNnQyVVFV?=
 =?utf-8?B?ZUhPZTE5UlhlZDNEeEVTbDJ5MXNEb1FlbTJLRkpnWGlGZzJzYllKMjFhYkp2?=
 =?utf-8?B?aVNocVQveFNIUHhYMnlGYzVsalRhcUh6V2pGRW5UNm5qODVZendBRG04cVJC?=
 =?utf-8?B?WFRLMGI3ODRuY0xxcWxQR3dhRUgxeXROdFFaMlhpeVVDUW80RERzMUVZQ2I0?=
 =?utf-8?B?Q2Y3NUdudStCVXJ5V0Q4Q2o3UU11SHdVdlViRnZUcjlVYy9nTjFZNDc4OVdo?=
 =?utf-8?B?cHRCM1hPMTB0dldOQUNHYndvZkhKNEVrRk93UXlCRnVQQTFHQ1JiOWVCOWp0?=
 =?utf-8?B?SklzV0c4N3hNTVl1cWJ6Q2JlNk5SeGRSemVZT0hNSDBjb2ZsMU9mZEt6elpC?=
 =?utf-8?B?ZmZXNE84aFhtNVNseHVMdkpYYlNqRTRRNHhGd3JXN2tEYWFEUjJqQ3dCMGw3?=
 =?utf-8?B?c1JJcmQwQkRrQ3hQV1hqYkNtSnJKS04yYWNnNTJpbDJ5U3E1aGNhRWY4Y0s0?=
 =?utf-8?B?UjNyNnlVb0E5OCszWTlLNC8vdWZNekMxZk50MlBxQkRReG1mcXJOb2daQTdr?=
 =?utf-8?B?dmpVTHR2WmJoYlAzY2dMYU9uelJSS1FLRzNMNk0wV2lNaGhJM0g5RVNtdGgz?=
 =?utf-8?B?ODNHYXh5Nm15TEE5SG45RXdkZWtiYUVVajg1OTdqcGNDSzc2b0VJano0eWU3?=
 =?utf-8?B?WkFZL0ljcXdGWnJ3blYxYURMZVVWam1uQjNwR1M0SlFaTGFiUytkSkxuSyts?=
 =?utf-8?B?OWduZ3haamxYWUdOZUdEVkhJKzA0S2w1VXhyT3BYeG5EVllHdXR3Mjdpdk1P?=
 =?utf-8?B?ZitJa0U1TFVUSC9MS2t1Q1k3QW5NSlZKVjJCUG1EVHdHcHZRbmtvOTRjbith?=
 =?utf-8?B?bVNDQWVUVTNDOXpTeHZFMjl0eUtjTEJQb2dWREpZeUxRbFlGZHhGMHdxbEFq?=
 =?utf-8?B?MkhheEJyVnFOSlkwYVhTdGZNNTRqR2txdEhCMk8rTzZMcENJRE1YYWlKQnpx?=
 =?utf-8?B?ZTc3L2hUUllWRVVRL2k3RSt2blkxUyttb0RwUHVGZ09TTHJhaUwyOXpjUmRC?=
 =?utf-8?B?MFk1VFZuNmVUNGJORVpGM2tRNCtmSmdHS2ZPQWwwOEt3MytPSEFFZ3ljMDlD?=
 =?utf-8?B?K04rMDd4SW9Pa1J4cG5OMnJDVkFrczJWRHUzN2R1dlBDSkxRdjJrbnlOT0hk?=
 =?utf-8?B?emdpTDRxU2RXbU5UeEcyM3J2Ym1FK2lHNlVLQUNReDFlczZ6d216RHNVZHh3?=
 =?utf-8?B?RFJ6bWhnRUR1WVY2UW5MYUtNQUQwVGt5eFB6QzN1OFpUNm9WV3FISUFUWkdI?=
 =?utf-8?B?QkdUZWtNd0ZkRzFjUFdXSkUzQVk1RVc5MTlWa3kwNXUwQVI0bnJyTU5XSGkx?=
 =?utf-8?B?RGU1NnFEZDlKZlUzSlcyZ0xld3dBd0t2SlljOE1oZ1VwTnZDcTNhWURCZU9S?=
 =?utf-8?B?bVVKQXpNbkl1UEo1RVk4K3NYbEQzb0JRVENHaDNCS2sxT25MdmlaVUpnKzdK?=
 =?utf-8?B?dFRRVzRYTktCeUdVZUFkUnFiUHZ0MG9lZWN4bTZ4RUZXcndJVDg2U29nWFhH?=
 =?utf-8?B?RmRKNHU4Wnpzb0lOazhVdTZJY25xYTVzMCs0WFRDcDcyRWdtZ2tWWjI2RC9M?=
 =?utf-8?B?ZEdlNDk4TE4xYkplajk5NlVZT2dmazJJcXRIODV2UDdHZXMzTjBBeW5YY1Rk?=
 =?utf-8?B?c1l0WDltUmhGODFOZkpaUUtuWmN4SGtMUUNPTnlOYy9saVFvZFdEZ3QrekFG?=
 =?utf-8?B?cWtiMUlLclJRYlc1UEppbVdsb1dWaXljbjgweHF6NW5HMGgyLzBsZkIxZEpw?=
 =?utf-8?B?MWFhbHEyTzljaXBQTFVGblBkQkN3bmhPNHdhTzVtV3lydjQzaC80OG53UEZw?=
 =?utf-8?Q?WxulLlaxTHbhZ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eDJsOWdHT2FQemRqakRtNlIrTFB1TzFnZVEycHFTMVlEMTdqQXVxY2djelY3?=
 =?utf-8?B?ZHpmd3N1NDU2K1ZUdkxmb3BFakZSSCtVazBhS0ZkY2tLYmI0SmRzVE9OU2tF?=
 =?utf-8?B?SmhpTGl1TmdNejRobmhxY082Z3pKcVRQeG1CdmcrcDVrQUk2MmxiaVlHaE1Y?=
 =?utf-8?B?aEhKdi83Q0ZqY21kTzY5KzRHR0dXMC9qRVpVSzNkRDZBdHpMY1d1V3ZoYVhr?=
 =?utf-8?B?STBSZ2VmeVBrcU5oSXhGWXlLMzE5cEd4YXQ1ZDRVQlBvUi9aTGFCUU1DT3d0?=
 =?utf-8?B?REkxSEpkbDB6eHpBRk9tbHdyMWVPdXhNNGEwV0V2N1BIVW1UcVlMV3pBalBG?=
 =?utf-8?B?SHRmdkQ3M1lLM3B2Sk00VlVmcnZNcjNCa2VOQzVjUk1hZHVubnI3N29jWmxJ?=
 =?utf-8?B?Nzl6ZGl0WVlWaGVhTkNjWFZxQTBXNkxKQVp5cHMwSTJZRVdyUk9DTFJ3TTlE?=
 =?utf-8?B?RmxOOUxlbURvQ2VKMFlPSEdLVlpHRFBYSlV2TENtMmY4RFA1OVhWbURiTGdz?=
 =?utf-8?B?bU5nZ2V5anJyZ2Q3a1pSREdVKzFCZ0psRE05QlhmTkVjSGtDcHhRNjBLYjFP?=
 =?utf-8?B?VXlnejhUNVMrSnlMY3dRN2MycFBYKzZxRTU3ejZ0QkdrcU90TUtFTEIyc3Ry?=
 =?utf-8?B?dzJhTjRoYXluNzJwd2pmK2lhRUFRSE52cU9BVFExZ215ZTRpTE9rRVZhTkhr?=
 =?utf-8?B?S0pHNkM5dytEV0dRdVZvQ0s2aHh3TWROR1oyK1BPdFFNZWdXamIyMlJhcUts?=
 =?utf-8?B?NHkvTmhkQ1l6V3ZXeXVZZ2ZtT3QrelhtTmVXUldjbFJySWNZT2ZHdk8rRDlq?=
 =?utf-8?B?bjZxR0Q1MWlIZ0J6TmJ6a0R5b3hPcjYrM2xubzFYSks3Yk83Wm1SSzliakhV?=
 =?utf-8?B?VllibDMzN0E2dlVxMk5XSjlWUElud0dkTThDSVBtU3h5OHdPcGxzaGMyb3Fj?=
 =?utf-8?B?d3JndXJJSjg3WFZydzNERU5yd1NjTXNjemxUdkFkTElCek5nWjlkWVZFQ05M?=
 =?utf-8?B?VlZzMkFtSTF5TTRiV285VzNESEpQQTF6OU9ObUZoeVk5YytQNjhaaThiQ0NM?=
 =?utf-8?B?MDA1S240VHJMTGxqWEtGc2Qwa1dlWTV2bzNhU2VLRjhuWlhob0VzWFpVbWto?=
 =?utf-8?B?NmhmSDc1Q0tnaXpHMDQ3Mzd6Q04zSnBPNlhnMnFQNlYvdE1LTmRqSmcrWUtl?=
 =?utf-8?B?cnBnSDlPay9veVJOZ3NSMmh6eVZOWlFBQXJneGRxTXVpSmt5QzU2MnI1d0hH?=
 =?utf-8?B?b1U2ejNZK1JGZ0NIcStKSFlBdDA2a2syK1FnZlAvanlTb2hKZVlzOHMxZDZZ?=
 =?utf-8?B?c0ptM1ZaK2pYSkY5TU12bHJvc28xdkVGYmN4ZVpBU3AzQUV3djR3M2VxU0NN?=
 =?utf-8?B?SlZ4WE9QNFp3bytkWnZCNTlWWm1BbjJIc3RWN0tlZys3RVJoL1V3aGdFYjBr?=
 =?utf-8?B?aHRzTFdQTkZvdnpVRHd6S1hXMkhYVHhtL29lVUZrVmdjM2g5TURtUnVRL2ty?=
 =?utf-8?B?bFVLbVk3V3BYeDc1UlpneVBNNmkwWktJSytKbnZabi9XbXArazJiQVVTazJo?=
 =?utf-8?B?K1lCQVR4bmFSdTM2dFZJdXR0TVFPUml6OGlqRmYydVhyMGhOWlZmc3UyYVZZ?=
 =?utf-8?B?eWZVZ2p5SkNnVnZENlF1R1M0M3FyMmFmaHFJU3dwZUFwaWI1YTJNMDA1QkMx?=
 =?utf-8?B?OFN2MVBvajZjUWFON2F5UGRaUnpoL2w3UGNQcWdlNjl4NzR0UnptY3BvaUd1?=
 =?utf-8?B?SWY5RnFYTmlha1hQK1ZOMlhxU1ZjYnNyNUVzNG9laE9mSEd2SmloNXRLc2M3?=
 =?utf-8?B?Wnc2TnpBb1djRzZpa1JralU3alZUcVpJS0F0Yyt3TjZjVUlTK2xsd0x1Qkxu?=
 =?utf-8?B?OUxjTVlwb01vNkg1ekprc0xyNzlFaUNiZjFRa0lEajFiVHM0T3V3QXZNQ2cv?=
 =?utf-8?B?a1RjK1I1L2RQMkRYTlhXTG96azBnS0ZmS1RSWG5DZmlBSGMxOXBET1lhaEg5?=
 =?utf-8?B?RWs3T2w2dkYxZ29FdlJ5aTY5QVRkMVR6dDkrV3lNa3pRcy83K1JpdHIwUStm?=
 =?utf-8?B?Uld5TEJxM1VkYkxkRTFmU29IN1NDUTkrMWVVSFZKbExiekRkMXl6cG9tcVda?=
 =?utf-8?B?NG1waGZQU25XYUJrVzhMZkRDVTFQMHdNOVNEN2JSQi82Tk5ydGJWSGpWOTJL?=
 =?utf-8?B?a2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 1O+N1YOB9gSQUhmglSmv3H57SZJa2EFVCmzCgQZDkRLAbTXSfspW0q0OUTdNSg+s9ll7rdfSUtxvRROKNBdyiWwadGkU73HBy4JdTa3A7GfB4JSsQcwBpWv3HWRXdtap0yKCE2w8B0DkdN0varHZm/1XYgXgNah7sh3Li/p7gn1xGGz4TGQQHcDzsRLtpCZzgSTYUkFLFjkNpywqvYJsPLtB+pWI5hNfk1+gh85L6wBSvGPUfvq6jPn/sor/JKNGZ21upMVjNfgv5IPpCZ/ISJywuiuMfyjhnFTcS7p8B3bEyh1h6P+PYJlDkAccEDbxTwUTopdWfpzYOOZRkS79jPTFkXHMPWlfwuHaPFW2vuD7t/LHeYYGpMwUU2JZv/WkaYMGFNnAOG271LqyUtqDEPUVdG56N3/sRP8WkipIZbgEUq0sjq0nXfpP8sXU/jztbqJl8jJRXJKzjOJN85/aMLPUnkoXxRloMcubU0zO+gHH4NGiNCPhWp60LI7X0V3fmDBUQ6tdluFgQ6S9TyNhT4m/yvRoM18+1LgqlxtSdhx+oX68qo+Yd1wvwxwb7Y8KfxstGowuFSVNplHV+UN0ci6sK8fj5Iu4+g+G5L6UsUU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24aa9ad5-6715-4b43-823f-08dd372a95d2
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 19:10:20.0485 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a7r96vMYx8GdmHtJcua1VeOmtJ3qjX5N2AUoCO2sISe2Hrc0JCJyS6z6dW5TgfcuiZjyEKY2JJFiKLsAufoqfujNMjLzywN5IddCXO2mg9Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7483
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-17_06,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 adultscore=0 spamscore=0
 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501170150
X-Proofpoint-ORIG-GUID: 8rvO2bKfDpPokhst2kp6UY5GVYuWmaex
X-Proofpoint-GUID: 8rvO2bKfDpPokhst2kp6UY5GVYuWmaex
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1.79,
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

On 1/17/2025 1:16 PM, Peter Xu wrote:
> On Fri, Jan 17, 2025 at 09:46:11AM -0800, Steve Sistare wrote:
>> +/*
>> + * Return true if ram contents would be lost during CPR.
>> + * Return false for ram_device because it is remapped in new QEMU.  Do not
>> + * exclude rom, even though it is readonly, because the rom file could change
>> + * in new QEMU.  Return false for non-migratable blocks.  They are either
>> + * re-created in new QEMU, or are handled specially, or are covered by a
>> + * device-level CPR blocker.  Return false for an fd, because it is visible and
>> + * can be remapped in new QEMU.
>> + */
>> +static bool ram_is_volatile(RAMBlock *rb)
>> +{
>> +    MemoryRegion *mr = rb->mr;
>> +
>> +    return mr &&
>> +        memory_region_is_ram(mr) &&
>> +        !memory_region_is_ram_device(mr) &&
>> +        (!qemu_ram_is_shared(rb) || !qemu_ram_is_named_file(rb)) &&
>> +        qemu_ram_is_migratable(rb) &&
>> +        rb->fd < 0;
>> +}
> 
> Blocking guest_memfd looks ok, but comparing to add one more block
> notifier, can we check all ramblocks once in migrate_prepare(), and fail
> that command directly if it fails the check?

In an upcoming patch, I will be adding an option analogous to only-migratable which
prevents QEMU from starting if anything would block cpr-transfer.  That option
will be checked when blockers are added, like for only-migratable. migrate_prepare
is too late.

> OTOH, is there any simpler way to simplify the check conditions?  It'll be
> at least nice to break these checks into smaller if conditions for
> readability..

I thought the function header comments made it clear, but I could move each
comment next to each condition:

     ...
     /*
      * Return false for an fd, because it is visible and can be remapped in
      * new QEMU.
      */
     if (rb->fd >= 0) {
         return false;
     }
     ...

> I wonder if we could stick with looping over all ramblocks, then make sure
> each of them is on the cpr saved fd list.  It may need to make
> cpr_save_fd() always register with the name of ramblock to do such lookup,
> or maybe we could also cache the ramblock pointer in CprFd, then the lookup
> will be a pointer match check.

Some ramblocks are not on the list, such as named files.  Plus looping in
migrate_prepare is too late as noted above.

IMO what I have already implemented using blockers is clean and elegant.

- Steve


