Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04E66CAC582
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 14:49:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ux55E-00060G-8I; Fri, 12 Sep 2025 10:49:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1ux55B-0005zQ-64
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 10:49:01 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1ux558-0007at-CK
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 10:49:00 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58CEcd2n021186;
 Fri, 12 Sep 2025 14:48:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=U+A71zw7kx/WSuG+6mVggWu6mZaMVwoQFdVqWgLO1aM=; b=
 Q4nWTljZ6vVH69pLwxMFebwQdaq9tyiQRkdyJcRAW+rG331GsgvzZpFldouZUhtE
 iFdt29uuDZoKcaW4PJNlTuPUfqimGCQLCJw4Glcgzm453/tL9QcBZWGszWxjswUW
 CSy4SVq0VSQ4R3iT6hw4Q+8kYJNqOViFnIy1hhepQrNRmbQ1Ea7lbLYxxiskkJqu
 YX/p0PC4Gp/IS42MWu8btt7sGsqQL7Z1gXbdwQD3wsW1c1Y2PXz1AZLT9NK6rf7p
 pUtWinTX8Aw3Jhnfgu4V+GFqUhPMxVvMRLu5+FWsB1uiwGMypX+Ttj5jkE9kVWC2
 5ebIZSFocUY2qJ5Iad5umA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4922jh0e1f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 12 Sep 2025 14:48:50 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 58CDYdLM025922; Fri, 12 Sep 2025 14:48:49 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11013034.outbound.protection.outlook.com
 [40.93.201.34])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 490bde0rry-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 12 Sep 2025 14:48:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DHUlIZ6O/kNBFn3DOkfyfyO4ZsOtqZNgIP/WKfVi+BMpHIn43vtRNE2sIPxlsBXeqQpWwYk6S+4IBWAbm3RhlaCfJy/mAmhqQ+kudWYur5Hy6HFx48qCGYXCpvTF0Reb2wNVN03PQQ6B3p9Spy2ww2fxVQ2InemqB/lX71gq4+8LznAKropwne1oe5J6DD+jboDLD8vgA/H39n5zsbkhqcodaM2cT0J7wEDoCUJROSrQosg28YDr+kYw9b8NUXLp2apd8M92aISjTgKeKDWZ2Y2kR6VLl85/vppU1RTGMJrZ9JihAMOt37M0GzCauYEikBaj39gYJkFi1ItZpDWnyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U+A71zw7kx/WSuG+6mVggWu6mZaMVwoQFdVqWgLO1aM=;
 b=pd9gYcRw+WWE4VIjhvEbwsDzPe8KNE/W/NnZkkruK9AatT6KK3e5G3b/8+wTSOhGAHuugjOy934r8Zzd0hj8mWYd3ZFIUbqbWLwKGuXUFi73AyCzPKi8uoNGRPWbdIxAilq4hhAX8AQWkWAIsVTHHENO9fAlHrotNkhhrEB/bu5dmwhdCH9mD8E7zrrMPbSTxFNpWg+3c6HpCnSO+tiU516lswC9nVTDjSJUj7hnpRbOhBHCeuUQ0suS5rVJAeSAwARRw9Vh6wjquT3lzDevl2VvWSwv4cddv7Wa0fsBrAg+fYxWCmfmOVYQ3dZmVVJd+9ASVCKDKyBKaQeGZZbrSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U+A71zw7kx/WSuG+6mVggWu6mZaMVwoQFdVqWgLO1aM=;
 b=f9nvKvyRUZ+XbVdfGj86koyPjtjistkL81YbU+eMYMTLj6UYLfeNoJ1CDRaKO8qBHJ4YwKxZ8uR95o/XgWFAFLANhkzNWXkwzyJSDJ+uqwkkfa0Ry8mKTQaP+fTDr43pRhMpJLCh9rgxIghhgmXTCqcL1hNFNb3kr+y9Dt+5ays=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by CH2PR10MB4263.namprd10.prod.outlook.com (2603:10b6:610:a6::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Fri, 12 Sep
 2025 14:48:47 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.9094.021; Fri, 12 Sep 2025
 14:48:47 +0000
Message-ID: <7c4f2ab5-bdbb-4c28-b99e-7f9316290d66@oracle.com>
Date: Fri, 12 Sep 2025 10:48:42 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 5/9] migration: cpr-exec-command parameter
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eric Blake <eblake@redhat.com>, "Dr. David Alan Gilbert" <dave@treblig.org>
References: <1755191843-283480-1-git-send-email-steven.sistare@oracle.com>
 <1755191843-283480-6-git-send-email-steven.sistare@oracle.com>
 <87qzwddnyz.fsf@pond.sub.org>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <87qzwddnyz.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8PR15CA0003.namprd15.prod.outlook.com
 (2603:10b6:510:2d2::25) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|CH2PR10MB4263:EE_
X-MS-Office365-Filtering-Correlation-Id: e7ef8a2c-badb-4506-8dc7-08ddf20b7a78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NHplREVIa1d3dEdPR1RrNElSRkpjVEVRS0dCRitXVnJPNjM0aUpWbDZYT084?=
 =?utf-8?B?RlZSRVYyWkYzQ3lRcE9aWUpUZjBRcndwakZqaDdZVElON2dGVVc4UE91QVdP?=
 =?utf-8?B?K3hyYUg2U1lldmxGbVVyeWs4U3dQVFRSbGorWUVYK1NkTU11OU81ZFB2aytj?=
 =?utf-8?B?Y3c5dk5mTGNscE41SHo3Q2J1SmwzeEkzRnlhM0ZHVXVyK3I4M3U3VHlRZUwr?=
 =?utf-8?B?VHNmeGhoVCs4dHVEKzdBTHBMUjJXdk9SZ2VkZnRyRnJ2cmF3WXlkZFZOcnZR?=
 =?utf-8?B?bTZ0dUlZTklGZURpYUZrMzFRejdSL21wSGNQVXlyQnVSaDA3ZWVKK1N2WUNn?=
 =?utf-8?B?Y0NMT0dUVmZEeS9xNDUwK2dUZHRXb1BPbVdmdThEdkpjQkhKTXBMRXduZFpq?=
 =?utf-8?B?M0p6anJwMllNaEw1eCtOT1BFWWFjM0M1b21FN3FhcklaUkZOUDVvSDNDSjVN?=
 =?utf-8?B?TE5pZFBpaTFrSmZ5UVJCYmw5Z3Q0UWJ3OFIwL01zcnlUZ0t3UFZLajVvQ2tq?=
 =?utf-8?B?NWE3TlIwb3cydUE0Sno0N0ZuT1BqazhwUmNVM2taa1VRNVczcHk1YXJUQmpp?=
 =?utf-8?B?dGFzUWRBZHdkWjcrTVRkNmh1ZVRuUVpSUEtTVHJ6WURPWFJFSEYrSHovVXh4?=
 =?utf-8?B?SUpBRkJBZThMQUxrL0kxZE0rRHBRNkdoQlZ2Z1BKNjJieFI2SzdqS2ZBc2pC?=
 =?utf-8?B?SFdQSE9UdlhvSmJNdlh3UW9GVFBJbzg5emxFZ0pLcTlTaHZYOCtvUWRZdUow?=
 =?utf-8?B?TXVCcFZ4MERraFJaclZMdjA0YnNsTVQ0b0N1ODN6cERCV0M0YUpldElNZ0JT?=
 =?utf-8?B?VmcwZERFdklvNEJmRWVQS043R2t4eER2SnY4Qzlnbk5LanpQd0hiZE9zK1VU?=
 =?utf-8?B?VkVDbWM5NUdBeW55ZHMrUy9nZ3hBQjV0eitpR2RjMTJWR3NIRlJxTWRFaUkz?=
 =?utf-8?B?ZlQ1SEp5VFhIaEY4WWdoVFBpVmprU3NrcXMxOE5NYUF1SlhsdzRYbnAxNzdM?=
 =?utf-8?B?SGFvY1ZKbi9KbjIxdEdBU015YTkyRTlsNC9BdmhZbWpCYjZhOUZKNkZlN2Ji?=
 =?utf-8?B?c2w2VERwa2xDVmZBV2ZDMWpKRUpaTkcxcGNBTUl3L1ViVmZrdnVpdG40MFpT?=
 =?utf-8?B?OVNRWmo0dm90TUJsYWNGVWdTOXNqS1kvVm9jVlFOcFU4RTFkdkNlMkE3OEJk?=
 =?utf-8?B?c0Y2cThGbzU5YlFwRE1hVHZzMklNTmlNUEFrMTFXZ1FLSTFpcm84eVVWQms0?=
 =?utf-8?B?N2FvY05abjhqb0lSS0JabTlFQS9mMDlZRTJ5cVhhSDRmanFnY0wybkQybTR4?=
 =?utf-8?B?ekNKVDJ3WFkrTml5NDgxc3Z6RWs3UGhVc2l0QjdQY0ZlRDU1Y1F5NzljaU5w?=
 =?utf-8?B?encxekNzdVJCY0pWOVpHVHlsRUhkWmZZYlk2blRnajBmRTkwQk4yWEsxa0k3?=
 =?utf-8?B?QUd4VjR0dUdpZG1vcjZSVUMybldhREVQMUFCYVd0TnJyV2pGVlJJbWQ4U0c2?=
 =?utf-8?B?aVAzZkhjaS9yWElYS2xmOTI2b2Jac3ZadS9mTXZNOXpPWjFwSDFiVE55Tmll?=
 =?utf-8?B?bU9xWmUrcGlpdkhicytETlpvdDlITXZ6SXV3YlNudHJJZ2ZwQkdYbkJ5bHp6?=
 =?utf-8?B?aGpDdWp0citOV3h0V3RUbHAzaHRubk00bWNHSTBSb1RSVXVJbHRIY3BJMDFP?=
 =?utf-8?B?eGI0UmNlOThPM1pqUDJEL3RwYzZ6OVpHOG52NXZQbkNqWVE0UkltcTMzbEY5?=
 =?utf-8?B?dmhYTTkzYkhNZEh0c05ZNEpOR2FEanVNTTd5VFNFR0hoU2M3VUlPWGV3V1d2?=
 =?utf-8?B?SExxYVE1V2VQK094TEJxM0RxSXBWbDJMMFpoeCsxeFZQMzdnLzBJZHgyRXdQ?=
 =?utf-8?B?MTFkYWZpNzZpUlNOWmlUUU9EQ1NpMWcrOWdhZ0Eva2V4bkxramN4SUlHc2l6?=
 =?utf-8?Q?1glxc5+kceE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHFqR3FGSDNsWE56a1l3cmVGSnE3Yk1xQXpOMzY1bzNia3cyelRwV0VJbzZv?=
 =?utf-8?B?aU1QMmhuVDR6S0E4YXIxcmM2bTR5RkVwTjArODB1UDBBZ1cwNm9WSWpmRVRS?=
 =?utf-8?B?V1JXK1N4UVhyZ3h2TTdUUUhsdjRVcHgzak4wY0ZSMzIyN1VKNFp5bEI1VW5M?=
 =?utf-8?B?VkZuRXNxeU1tSGMyOWFCN01DdGVWQTltQmsvb0tBeGFPelJEaDhvQm9BTlJv?=
 =?utf-8?B?eVJBNkhLNUorQmxXWWozVk95VDdudCtHS0F5VHJESHdLbzMzamlpM2VDQTQ2?=
 =?utf-8?B?UjNXSzNTVVNiRlVud2lOY3ExcE1xaElhb0ZDS1RveE54eTRtV3lZRm1GeDBN?=
 =?utf-8?B?dE1STlJrZ1JWVDh0NXNZTjlUenE0czJjV24rdkdtVEJNTmYzWXBadXBCVE9M?=
 =?utf-8?B?NEFIZzdMSGhCWDNPU1NhTkMrbkU5SDk5SHRFZzZPazNobFo0bXgrSHFtc3dS?=
 =?utf-8?B?blAvN2k0b0ZuQzg1c1RGQmhyWW4wOGlVV2MyUktuM1h3cmdqNzMrRW1LMEJt?=
 =?utf-8?B?K25qVlF5OGNXMG5ENXBFU0FpMnlCb1ovN1FQTzVPR2hDWndmT1UxaDZucE4v?=
 =?utf-8?B?VW9BbG1iR0FFbk5ETG5kMk5aT2NBR3pVUGRQQTJNendhdS9XU2pPbEpuSG02?=
 =?utf-8?B?emprSThvSXYwd2V5OFk0UW8rRmI1V1dHblphL3hETUp1NGFyeWd4akEwSEZp?=
 =?utf-8?B?TGVhU3VyTVh4eGVCODZvWmtIaGx3QzNsRFE5Vzkyc2tKWUpJUUl5OVRZV0dy?=
 =?utf-8?B?WDFlckdQSE5HR2Rlb0ozcm00OFZGZmVXazkxamQ5TWdVRk9yUnlqU0RJeWRt?=
 =?utf-8?B?U2dDclRmbmRoMC9wZStXR3VpVjhvY25wekxpVXRGbXFNR1BNMlR6bldjcW5a?=
 =?utf-8?B?MHgrRnRQZk8zNzlpOFpPU1hLMEhkUWdIa0QzamQ4bWhldXg2SzJLQkQ2dElD?=
 =?utf-8?B?OGE0K290c3B0ZFRlNWVVdFQwTWtZTDRLZDVIc1FmcVljZnFRekpnRjZqcU5S?=
 =?utf-8?B?b1Z2K2YyS1ZLeUtOMzlmMGNKckRTdGJzcVBTTHRvSUJVMkZLWkVxTU1DRkkz?=
 =?utf-8?B?RU9DTG0rT1Azb3hYeEVsTktCODhkZnlnZjNpRTlkVDBQenZzYkhYVDZUMzRB?=
 =?utf-8?B?cUhVMU5Xd24weG9McFU2c2VoR1gwYlVuOCtkc1p5Q0dRT3RPVEYzc0h3d1F5?=
 =?utf-8?B?cGhldDZTcENUS1RJNnhISTNQSlRPRWFsR0xocnJvb3lGc0NmdURXa3ptVjR5?=
 =?utf-8?B?WDZUUXdyWlRpQjF0WUN1Q2lPUGpBZHgwbm16VDFHQ3RzdW85R2xOZDBsSHJz?=
 =?utf-8?B?YzNLV0N3enRWV0xPb1dCTVBtL2NkNGJ2SGxHVDZ2ZnZoOWJqS3N1NVlDRWlh?=
 =?utf-8?B?cGgrbGQ5Z3U1QmxDbVZ3SlZFQWdIWGgrUmpzWmQ2cGwrbDUydExNa2xtSmxx?=
 =?utf-8?B?bjd5c0pVMERMak15VkZXRnpHRDgxdXYxM0FuajJLTXg1VFM0RkdnaEw0YSt0?=
 =?utf-8?B?R0VGejBzbnhTRTVZcEhEWTNaR0Vsbzczcmovc3ZOa01qdkoya1gveEZnSytz?=
 =?utf-8?B?RDUzdW1hQ3pEM0J3TGRRM2JJblRVSU4xaEZuUjNOWi9TN0t0UnlpWU85MDhR?=
 =?utf-8?B?WFNKUlFqNjNGOFNnZUNETXRNcTM5M0hsUWFJLzI3U082a2tzZG1IQ3A1TXVz?=
 =?utf-8?B?ci8rNjFMK2xUdktYZ1psRU5VdXYvUEptOFYzSTh1dUYzUlo1YzUyYUtEYThT?=
 =?utf-8?B?Z3V4QmY0YVprQ3BJblYxajlibDdzMkp1SzZwKzhjMVltaGFEZ1VmNzB4OXhm?=
 =?utf-8?B?TjRwdm1ncmEzbUwveG1WdDBZUEFpQ1BGeUx2UVh6bGJWaUpycmxNVlZzUVEv?=
 =?utf-8?B?UFhGTFRwbDFvd3cxWDRFU1Bna2dnWVcxNlVTbzFWM2hWczlIMVAxSFpqdDhm?=
 =?utf-8?B?QndIdDZjOEpNVFl2SXdRLytkUHdadDFEbVlzNVJRdzBjaExucXlIdUViMHJZ?=
 =?utf-8?B?K09hcUVlZVJuc2JzTzhvVmwvOUtuUzlkRU9ldXZPSEVCUU5qRW5FQy9vaVly?=
 =?utf-8?B?bU13amdDOUsweVUxK2kxRGVDbGs5bmpsbHVMbUIwT0QzRk5SYXdLMllYOGdV?=
 =?utf-8?B?VmVBTG9vR0g5a2dSMFdEWGZLNnloVXRXZ1BGY1ZaVmtzdktrZXJwTlhjU1Z6?=
 =?utf-8?B?ZEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: SUVwObq5/SnFOGpsu61dJUMieGc15n+BSiBd3sZ/FUunPDMmHFpa9nFQCM+wrv2SLgbPd7kuvbDRfNpoMaN4tZowEWhYFSzHZFf5rpvxEtP3Rj+6dYNFeNNiao6T39fcYAHAhXqKuZhn7igvFC2qrderOI2+PDgRdamxc0lFQPR6RFduesC2H0K10F5xPRuYyo2MwnQIz/gSJ3XdgzJRYbtieqmV9u6TRvet5AUjDaswTi2VQzfdzUXzHepMu+Y6tJN7PieyQQ+7230PK6khGUE7tBy1KaPSWDNP4ZxT2wKd1hcO2tlelX3IJK9JBoMv/JBwuRQQYvQY+n2GyWj8hdsJhQjUHgtj66xC+zA4XA5p8uBxM43Spc+0TwjHoYjg02NUTrkDWuB0m+cSTmzc2hNk8B8V8cstjUrh2iUL52RS8zHgQx05lCXhay/a2sZd2rFAJVhEfPyw1w9kyO5EP1Rz6aO6ATxAr34r5Ro8eyBznYvrf6/YvErwHVmxA4Fv+A8g+DNMp4inywvHX4aQxsXN2Z7gAJD/LG8mMzh/G9rQZndSefO4cfcrFXO0MlVBr7ah3J9QUC5iztkrr1nCnD07G/ubYpZZNCPAVfepy48=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7ef8a2c-badb-4506-8dc7-08ddf20b7a78
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 14:48:47.2236 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VK+xVfEpBPg6VxFTOH0xE1tznaWxzo1l0Jhr2OH2+chm3ffBhWyEJA/LofsoM9Kb6lhvG/Ghw3jOKDK9m6u/QkzfT2CUCbwCpAAOxok7H5k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4263
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_05,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 suspectscore=0
 mlxscore=0 adultscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509120137
X-Proofpoint-ORIG-GUID: k4qxCv5CeJKymDUJM98_iMSoYd4viYME
X-Authority-Analysis: v=2.4 cv=PLMP+eqC c=1 sm=1 tr=0 ts=68c432d2 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117
 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8
 a=h3K6sLmc6-2jF8gSE4EA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13614
X-Proofpoint-GUID: k4qxCv5CeJKymDUJM98_iMSoYd4viYME
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE2MiBTYWx0ZWRfX1tcGIwb+0iUy
 t06KqocVbUaO+CUiRN3DSUT4lLsX4+78Tzq4SsQRdc5ydM7igQ8u0VNoDqG4+EbNf7PXUb1L8I9
 SqLPnw929nV6yDrMxD17YO3/FEPQCiMjKudy88EPdMkfMoCc763Aa7vbvVlhVAxqfdUTNFEEUYN
 +KLQiX14SCO1vdj+gNQPEu+HYAWMZX/VOAiOTu/T+xxr5yz6Dhdz48m3wo0FQsllzU7pL1Kwtiq
 YE2/MFTC0c0VbhCPV02nyqOouxHS2yu8XdNpgPWt4M+OheDuk1lmmBSFN4tAv4wQC9jGJxHoOuq
 Ot85l2eQKCFouVVsugUafxFuB+Ucn4uzxpM4Dy0rXsjjs9v9r/X8deVz5w9WJfNh3JS7qR7cH26
 cnZqlWFXlzj977XFipuGDpB77/dPDA==
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

On 9/11/2025 11:10 AM, Markus Armbruster wrote:
> Steve Sistare <steven.sistare@oracle.com> writes:
> 
>> Create the cpr-exec-command migration parameter, defined as a list of
>> strings.  It will be used for cpr-exec migration mode in a subsequent
>> patch, and contains forward references to cpr-exec mode in the qapi
>> doc.
>>
>> No functional change, except that cpr-exec-command is shown by the
>> 'info migrate' command.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>   qapi/migration.json            | 21 ++++++++++++++++++---
>>   migration/migration-hmp-cmds.c | 25 +++++++++++++++++++++++++
>>   migration/options.c            | 14 ++++++++++++++
>>   hmp-commands.hx                |  2 +-
>>   4 files changed, 58 insertions(+), 4 deletions(-)
>>
>> diff --git a/qapi/migration.json b/qapi/migration.json
>> index 2387c21..ea410fd 100644
>> --- a/qapi/migration.json
>> +++ b/qapi/migration.json
>> @@ -924,6 +924,10 @@
>>   #     only has effect if the @mapped-ram capability is enabled.
>>   #     (Since 9.1)
>>   #
>> +# @cpr-exec-command: Command to start the new QEMU process when @mode
>> +#     is @cpr-exec.  The first list element is the program's filename,
>> +#     the remainder its arguments. (Since 10.2)
> 
> Please add a second space in ". (" for all three copies.

Sure.  Thanks for reviewing.

- Steve

>> +#
>>   # Features:
>>   #
>>   # @unstable: Members @x-checkpoint-delay and
>> @@ -950,7 +954,8 @@
>>              'vcpu-dirty-limit',
>>              'mode',
>>              'zero-page-detection',
>> -           'direct-io'] }
>> +           'direct-io',
>> +           'cpr-exec-command'] }
>>   
>>   ##
>>   # @MigrateSetParameters:
>> @@ -1105,6 +1110,10 @@
>>   #     only has effect if the @mapped-ram capability is enabled.
>>   #     (Since 9.1)
>>   #
>> +# @cpr-exec-command: Command to start the new QEMU process when @mode
>> +#     is @cpr-exec.  The first list element is the program's filename,
>> +#     the remainder its arguments. (Since 10.2)
>> +#
>>   # Features:
>>   #
>>   # @unstable: Members @x-checkpoint-delay and
>> @@ -1146,7 +1155,8 @@
>>               '*vcpu-dirty-limit': 'uint64',
>>               '*mode': 'MigMode',
>>               '*zero-page-detection': 'ZeroPageDetection',
>> -            '*direct-io': 'bool' } }
>> +            '*direct-io': 'bool',
>> +            '*cpr-exec-command': [ 'str' ]} }
>>   
>>   ##
>>   # @migrate-set-parameters:
>> @@ -1315,6 +1325,10 @@
>>   #     only has effect if the @mapped-ram capability is enabled.
>>   #     (Since 9.1)
>>   #
>> +# @cpr-exec-command: Command to start the new QEMU process when @mode
>> +#     is @cpr-exec.  The first list element is the program's filename,
>> +#     the remainder its arguments. (Since 10.2)
>> +#
>>   # Features:
>>   #
>>   # @unstable: Members @x-checkpoint-delay and
>> @@ -1353,7 +1367,8 @@
>>               '*vcpu-dirty-limit': 'uint64',
>>               '*mode': 'MigMode',
>>               '*zero-page-detection': 'ZeroPageDetection',
>> -            '*direct-io': 'bool' } }
>> +            '*direct-io': 'bool',
>> +            '*cpr-exec-command': [ 'str' ]} }
>>   
>>   ##
>>   # @query-migrate-parameters:
> 
> Acked-by: Markus Armbruster <armbru@redhat.com>
> 
> 
> [...]
> 


