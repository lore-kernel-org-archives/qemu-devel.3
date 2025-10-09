Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6E3BCCD185
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 14:12:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6rMx-0007o9-2Q; Thu, 09 Oct 2025 10:11:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1v6rMt-0007bp-0C
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 10:11:44 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1v6rMh-00005F-Vw
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 10:11:42 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 599DtxMB027721;
 Thu, 9 Oct 2025 14:11:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=N6QypbdpR6p+9uDD6bZHHq5JpkZ18vgEReC1Oxr/5io=; b=
 oKBLEHUmtz4HVzdqF+vxPz+PyF73VT2YlpPjF4U+5HQInWLBkFjdFRVMv93W9dKK
 fkjkWjMbMsBtmYDsfz1G5fZMgc8+HHExxlrC6S/5LoGWnQpbPekbPHE2loEpBVtD
 zVsMFLSjRNW4/rRDPgBjTE4PgbgYlUxygoK8XMwrE0PCXvrI5RBOEAsLhpa7HeHp
 rjkaE6Bzk8vbCwfwyvgp3AGbHjBfFuTOF+Fx76uYgeOX0sONiu0+WDHXZeyGfRUK
 ix5xOr8eP+xlQFjT1uEIGS1sNlrx+Waafvu5q4T7DCryDOiaa3/UdyeR8wgzBKX0
 CCp3UIoiJe8CSs5+u+iMQg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49nv6bsq4b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 09 Oct 2025 14:11:24 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 599DfgYI010255; Thu, 9 Oct 2025 14:11:24 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11011033.outbound.protection.outlook.com [40.107.208.33])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 49nv66y6he-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 09 Oct 2025 14:11:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q9H+sh2vxPmOvQ5LOqvmpXBrwQjsTQRbADZFnGw4oglXOyZb88RXpTzOuDa9Lzhm2h5/dHVvH29QseFYZy8SeInpsOGVV2x4CJ02kwWbTT3zUXQrsvrPydsaONLpmBL67zHHVCTeJk1XsOcZHOTLzmJDYcwHqvJ3iSLsvt2CFuAkn0pS/ILIDB0fNv8FPYO9uyzdVncR5ctVqcbPGe8P7ct/HPhB8PQ7wF54f3cDfZpdLmUjcSxfJo1Ze2lWryw+pk7gbIdCR2CMzsoMsPmLqonEwGwy5Uo4NM80eeopKAlq/Je80TA58qVByEkkUW/ZE0LOwg0Jj/584NULvvLD0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N6QypbdpR6p+9uDD6bZHHq5JpkZ18vgEReC1Oxr/5io=;
 b=kPYLFy5i/xIgV3gvf4XqflLGU8pKG2tvijLjRI9m79oMlnp0Z2SuycHKxvX8ugCNPXBFBed+0n7rN9zpPSnpmmtz6hmRn21fJRX2y0hj+PTMcxvp/uB3Cwja8RDGWGCNARw+z1ezHztu0IqU0B8O4phxvKoRFoAA+KWEAIyX+ua3Xp5jHxlZqY7jBt2HzlFz0KWHpFxiC+CKCoGTnQoeenzWw8wDo8+jrmGLVRJ4XkqTeYpu+xqGRNr5rMMdhXa2JFM6ephEN6StmtmgGUSS0rZ+9gVQTbiguqmUdUSTg4c7sbN2smTdjA7CP2da2hXrsfKHRLbhT8dzyTIECiROTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N6QypbdpR6p+9uDD6bZHHq5JpkZ18vgEReC1Oxr/5io=;
 b=IWSTyPulUxWN959gBE7CEykVTWZ49/lDQlnKWs2WoTPl5xqPi2a0KB5S6JMla4G+woCcNEY045ij8uYBSQzi6STseyTNbTuWxBJ54lhzbViRKNajCKdisDBAhbqnByDGKn16FmK4ALSwPxvT1iJbjkevhXKLKag8xIdcrzRRWB0=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by PH7PR10MB6333.namprd10.prod.outlook.com (2603:10b6:510:1b0::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Thu, 9 Oct
 2025 14:11:21 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%6]) with mapi id 15.20.9203.007; Thu, 9 Oct 2025
 14:11:21 +0000
Message-ID: <ab688cce-283d-4541-b7ca-be651085979e@oracle.com>
Date: Thu, 9 Oct 2025 10:11:17 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] accel/kvm: Fix SIGSEGV when execute
 "query-balloon" after CPR transfer
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
References: <20250928085432.40107-1-zhenzhong.duan@intel.com>
 <20250928085432.40107-7-zhenzhong.duan@intel.com>
 <1ba0dbca-08b2-4f80-ba12-01884a25ef0d@oracle.com>
 <IA3PR11MB913635F06F6522102D8FC15D921AA@IA3PR11MB9136.namprd11.prod.outlook.com>
 <78df77e2-43a6-48d6-b09e-fcc61a662b6e@oracle.com>
 <IA3PR11MB9136EF2C01DAB2C2EA261CC092E1A@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <IA3PR11MB9136EF2C01DAB2C2EA261CC092E1A@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH7P220CA0035.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:32b::30) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|PH7PR10MB6333:EE_
X-MS-Office365-Filtering-Correlation-Id: 30326baa-0165-4452-83b6-08de073db8cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aVhETWZVQWFYT2tqTC9mMmYrc1hIOUZhMWlKNEpXc25rcWJ4M0ZiaTdqbUtz?=
 =?utf-8?B?dityZ1dCbVg2QXBaSGZnY1ZuWDZIbTArbHA3Z0dxSTJVTm5JMzdnY052V1FN?=
 =?utf-8?B?WXAxdzM3UG8vdGtDSEFrN3JzRHlXQmU0NUlrbjh6OXR6dkRoZEZ1eUJLWGN1?=
 =?utf-8?B?dDU5Mk8wbm5Ic2w1eUVnNWk3N2FDdG5NOElzSUFGeGRCNTlVZms1NUFZWUNG?=
 =?utf-8?B?WXpzK3RaalgyU3FLb2cvM08xaFNGQVdmZzdiNTUvVGJhU2hQemxhemZnZ2xQ?=
 =?utf-8?B?YkxUZWtFTjR4bG5vVWw0WGdFaktZUWtDUVpvQVl1UnRrTk41emFsb0NhSWY1?=
 =?utf-8?B?TVBMNnNvckNtekJ1OVphdVkvSk1ZbDE2czhvektxUGU1VG5ZUzhqWHJYckU0?=
 =?utf-8?B?YXU3c1IwdE1DOS9KcE0rVjdUNlAzZmVqeGR4NHZhYm1OQWttWWpuTXhlKzhH?=
 =?utf-8?B?L01seFNGeENreU1vMTJwbmx2Mzd3Y1dja1F5bnltVEZHWXhPT0U0cFB0K2h4?=
 =?utf-8?B?enpjYU1jRUxRL3RBTWRpNWo5cXZGbmJHVWFnWVRWb2dLdEdlNG5lS0RmV0ZV?=
 =?utf-8?B?SEdGN0xWNUVEZUkvRlZGYzBhRHV0QWptN0ZhRUZpOHBQS28yNUNrbVBTV0w4?=
 =?utf-8?B?WFhUK2JWUW5pb0NobE1aOTJDWkZ3UGhqRWpwWDhMV25BdllUb25BSjBHNDZR?=
 =?utf-8?B?U3BUbnB4VkIraUlCVWRQZDh0QUdHTjUwMjgzNW5ndUN2N3lHblFjbHlQbWdr?=
 =?utf-8?B?akc4a3hDVGRWV1B1eDhBazVQNmRTWk11WEJXTTdSdDlUYzAxTDRqYTFzMTcv?=
 =?utf-8?B?UkFPN0xaaUhZRklhdW1EYitkUENjejEyTWJ4RVlVRUgrN09USjI1ZkNEcVYx?=
 =?utf-8?B?UDk4MmswaGl4LytKcFA4ZVlyK3hXYTFUR1VzTStPVjVqbnArVktyRjE3ZytN?=
 =?utf-8?B?NXRZU0FLRGpYamJrQ2o5Z1Q2aEU2bEs0c2s1bW14NWZKenVHSlA2amhscW9F?=
 =?utf-8?B?bmlralBnRm14a0gxL3E5V0xDWFgxd3pVdVJrUXJJVnZGZzVPQ1FuZ3FFcDcy?=
 =?utf-8?B?eUplT0tWYXN5d3RQWExXRG92UGxFR0d4TlNibHVVYWFWNDFBSmFqYUcxQmNP?=
 =?utf-8?B?QjhVQ0VXdEFYdUZNdUNIVTcwYUFrUEVqaklqZzNPQVlJUEJUV0xZejdkUVFY?=
 =?utf-8?B?TDBaTlBJTnNmU1ZVZmR0MEJheHFvbVQvbVFTUm9PSjExM1RhRFFvNnk0ZkNS?=
 =?utf-8?B?V3VmaWxqVnV0Wm8zUkZqSmNsZ2k0VVVkNytIWEZiOWZua3ZBbktmcjc2VHZE?=
 =?utf-8?B?KytFcXZwanBUZlZSL1FWM2ZlWkR0OHp2cDZFdjVudTN5V0MzSXFzOFJNOHFy?=
 =?utf-8?B?NDFwU1FKMGNJREZQdVBRcVlXRXg1Yzk5Q0NvNDJPMGNRc3daS0x1bmNoM0c0?=
 =?utf-8?B?M21Rbm9uakJyNEY5b3lHUWs5dWJGZEMwSGVPYVpFN29XT2VpMWZXZHJEUmwv?=
 =?utf-8?B?akNNRkRvNHA5Q3dycjFjRFJIMFhSYTREWTVOVTRGY2FOQWpGMHc5YVo3Slpn?=
 =?utf-8?B?bWEwcmd2WmwrY2FBNFZJcUczWHlTYmd3NkNLTUVwNXN2ZStnYmlpVHhhQjV6?=
 =?utf-8?B?cERrNGNrTEhFb29LMWVQTDhKWndKaXpiQ3lPaXp5TWlMYjZFWkEzVWY5eWdJ?=
 =?utf-8?B?Z3JpOGdhYy9tajVycTk0d2ZBTWVxYXgvcFN2L25FRkNzTFRqVHhSOFJqdnVQ?=
 =?utf-8?B?VnRIQUZzT0NzUklaKzFnMXJnSlhlcm9pNFR0eGlwVmFxYUxsanNFeTJyUGR0?=
 =?utf-8?B?cS9jTCtUa3Npb2J2alI1cndCWGJwOWhlZmxxSFNRbWsxL3grSy9aOXV0VGF3?=
 =?utf-8?B?UFNKVFgrRjFOU3hUVkNYWmV2aEkzZ0doQkVzR0JNeFlHYndFQkpkVm1CRzAr?=
 =?utf-8?Q?ipd2pm48mN1jyQEdz8Y/8oyUphnJb94V?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TnVYVUhmaERBdUdZUTRmbjZJam01SStZOTc1S0QvOGVXbzk2ZjVldVpmS0dn?=
 =?utf-8?B?TVVpK1oyY3lXK3lINm1zR0FJTmNmTmlsRVJDdSt3VVVKR2M2dWl2NmFnWmZQ?=
 =?utf-8?B?OFlFSmpxVHlySWxPVWdxNDJSaTRQNk4veHhaZjU3ZHV5bE84bzFlNGpVMzlx?=
 =?utf-8?B?ajdVVlkzMkFaWVhWQzNxQkxTb05oUjNqSjhrbkZNUFcwRVAzakFTVkVhQUlN?=
 =?utf-8?B?MVVDZGszWXdWeWZ6SFE5Y1dYQXQ1SklnUyt1YS9FQ3Q1MU51UGxHTWlxR0xy?=
 =?utf-8?B?LzU5MmtEL2J2WncweGFxc0FxN0UvZnFoV01UU3hlMndRM2FrT2NBdi9KUHhz?=
 =?utf-8?B?T3RtRVVqL3AyNC9zZkZyZ1pMQTkrbERNaVRYRExPT0pNdTVNM01ETHUrVlBo?=
 =?utf-8?B?bFVYc3ZaZE9NUVBsTHJMcGZKbjlxWFlEQ0VvbmtUOG1ZRVQzZC81MVBuK0ZV?=
 =?utf-8?B?QU1lMGRvcEZZamdlU1pOVHo1UzdMYmRqY0hXbk9IQWlNSCtHTEFGbk13SHBq?=
 =?utf-8?B?RHNmb1FPdHQvbGNFTE5ic0JrcnRuc2pyY0ZEVDNneXVQOWZNdUJqcHQzRENm?=
 =?utf-8?B?MitaOWFOR01pR0p5Kzc0cGJmd1RPcUM4MHVBNEwwTW5aQSt5Wng2SnJldlRU?=
 =?utf-8?B?dUFjTjZrWEZvNm8zdnpUSHl2WHYrZExoMkxkSjUxalZNREJOSVhocTQzMm1j?=
 =?utf-8?B?ZnVDZlpBUEdqekdtdUprZmlOTHNxazMybSsrWDZZYkh2T2E0TlRaMGlraVR4?=
 =?utf-8?B?bUxERmtNT2MrWm1Kc3NvSDNpYW8zOEtoVG9SUnM4ZVgwb0ZBdUhUTS8yd1RN?=
 =?utf-8?B?NTViVVpoNUJzczM0NjJUOE0zTVRNSFFTcFhjN3d3MStKRzVocC9uazNwTXVT?=
 =?utf-8?B?Z1RBcGRVNXdGNEVvNy9wbGtmM3VaenZIaG9lZ2FoaUVTV0V6bjFzSzdqM2Vk?=
 =?utf-8?B?L1BBY2IwNFcrR3hLa3drM0tGVWhFM05RSEdWblNvQ1BPem5QVUg2MWVXanpF?=
 =?utf-8?B?T1lmRlZwVi9xRDN5YkpyeTN6eFRvVllSbXhySURuL3UvamxVWUFQS2hZdVVR?=
 =?utf-8?B?OHg1Rm56aXpXNmNybzZVNU0ybkZkYSt2YTdPR0t1Vm9zcWJvK0ZqWTc5NitE?=
 =?utf-8?B?Q1FJR1VRYmNONHVzKzZMNnd5MWJ1eGplWEZnN25MMGQxcFFQdjBBMWdRRlZE?=
 =?utf-8?B?V2xTOVVZbmhyZHBhb1JncmdDQkdIS2RrNjhkRUtOTWc1cVVWQ0ZDZzhyVVB1?=
 =?utf-8?B?SW1DZzNPYkJyU2trWTZ0dWU2WmVZY0JaMGUwcmcrZGZXQ2wxRkxkUVptaktM?=
 =?utf-8?B?NnAxVUExMWUwMnV4RXA4YmhBdW1ibU9XZHJKUE85dUtYTUNnL2JWNmJ0dUpU?=
 =?utf-8?B?WjFmbmlkMVFTYlZkVXVQYXJwdWlXbDRRTUdtTzNKa2c4M01ZSTMxZWlLQWtw?=
 =?utf-8?B?UVJURmtXdjBwbUxwZFdtZWM4Z3FFWUJ0Sjh6TnFRM0tVZEEwUDhlMDFuR0t4?=
 =?utf-8?B?WGQyRi9ObXRYbkp5Y1U1V0xHMEx6QU9tWnhTUVJpelQ5ZEJ2Vnord3Z5RW9W?=
 =?utf-8?B?UzFMZHVCZXpGRUhCN2RMZXMrU21aOXB2ODdXZEQrTGpOaFlDYTRwcll1bTN4?=
 =?utf-8?B?dllSN3pQU0NxZ0J5Yk80WURqd3Z0ZFVGNmFqSDVLRDUwbmYxaXJha3MrZjN3?=
 =?utf-8?B?UzlDL25ZWGRuNTkvNnB3U29CbG5EcWRFWHlVYzNVUVZ5MDN4TjFJa1ZBMjJB?=
 =?utf-8?B?WG9VUU9hNEczSHNHWTJCT0ZKbFFCSmJFSzArVzJheHJkbEszVENGdXljally?=
 =?utf-8?B?ZmFBRWFEUzJlOHMzUmVicEdZdEhGVnVoekhGRUMzMms0bmsvaXpOVlJCYWsy?=
 =?utf-8?B?TXhJU1UxbitlR1Y3dUlKZ0tHYmV3U25heFhMbFlMMWNpYVJrWStUa2FOWno3?=
 =?utf-8?B?TXc2Ny9FaDNnbUtMZUJETzcrSE9URWdvc3FUQXhNR1FmeUp2dWN0aVhJZlV1?=
 =?utf-8?B?SVhmcUhRRk14anBGMno5MTV6QWg0bENpeTFZR3NCQ1hFanAzWksrMU9nZGkr?=
 =?utf-8?B?RTFOTzFpQzN2ZU5JcDZGV1BrK3lIMThscVZOQjlwVkxKK2RtMktJbldiVnUr?=
 =?utf-8?B?VlNPL2ZkOU1QVGxMT2gxRzBOWC9UVVgreG9kZUJPY2RPd1dDYXI2UUJkVHlC?=
 =?utf-8?B?WUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 1V0XMvtvhwwTxqpADx3Ht+KAefacvbovMeV7OKiG71KhbB63ApLcximi8fPx51Fzz22M1zBtcQLr8sal1ErmLHnTn2RefkyMfz9uCBtGarVicRVJo8LZGodo7dRageG8Mcf3qgkzRByOAsiStoKRQfnfEUq7qn1NN5VhUancMmfLiXKFsBlGIYhbMvdUuR7dNZmZhvBdjq3fDHXZx7BwT9OPDVpq9oxxRbPRL+JSIDya9TOexcxBsxS3V8Nfz7rPWOhhFKs2mSOVgISR9UW1Eg+K/lGvqw8M+sMBtCrWGwM7Sh8BxyZi9SBjxPpA1TJE7QtYqsrkGWF69ZikyR0OjV9BOMq2cAwcL75QwtOJ7EfD0LGo60OnUoLCAMyZqhJ1tlNeaTC2wLCjIt75uxOobUUam4oPyAdE+npwWPO+o6uK58e5HVaAZMzxtKcvJNUol79KAoBEwkw/J+1wywrZGPK7TakgiLngUwuYm0zASsRJPa9Us5KNgf/YkaG5rEx8HpioKzkRFp9h+fog7ddO1vMdZBoEw8azDvlYC+DbDE39lpKv74ip5Tw8S30qMV4DVaSNYaqDjUSTGhwyY3PQlSW3jM00deTlmzp9GQmpsbA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30326baa-0165-4452-83b6-08de073db8cb
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 14:11:21.1901 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kcYJDHytILUIbRDKmBQdk0zg861hPx+L7RLUcXrumJ5BGR2OlWcX8zo/b90yazi7kjWZH/RDGre02u3vDRtIdWCAwSSKk5t9znnpTy/5a0I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6333
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_04,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 suspectscore=0
 spamscore=0 adultscore=0 phishscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510090084
X-Authority-Analysis: v=2.4 cv=BLO+bVQG c=1 sm=1 tr=0 ts=68e7c28c cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=d_yPphG322nuGfjKXrgA:9
 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: u2B1TUYh4CFSZDQCWTL8JhHQeynvt0Pl
X-Proofpoint-GUID: u2B1TUYh4CFSZDQCWTL8JhHQeynvt0Pl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX3eTF1e7hCIxR
 UPbYdx4WP5k0QIrseIXdqzv1D1m6eCq6m1ztpU5MUGm9z38VV8ivjMKi1E3o3P8uymhvnUGIb4n
 3RXnW+GuZ+YAQ9YStkQNT+Im35GXiOzXkQKW41mx63rofecK/KHW3CfDTPnabMCsD0UZoNYv8sY
 qG1ynaFHophclXcmtm3cqDaCZDYg137dSz0scDHOPPMsNy65cD4OHMcRcp/efgAxm2OXGs9K70e
 v9yt+ZmfS0BevQUuj+oKhVRWsgkX44HzlWJBnP5kCQHT3phXvKOcxNk4TH5QPmMMxO8jTgKZnV+
 XDBD2H2E5M8vrzK763HdfWAcPUb8dPIoS54qW/LriH9TPB+6FV67w0N+wvmhdDTY0WxeiBhVlsW
 Nh/53Ap0jJEz9vl/LWHtI/sDmPUG+g==
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 10/8/2025 6:22 AM, Duan, Zhenzhong wrote:
> 
> 
>> -----Original Message-----
>> From: Steven Sistare <steven.sistare@oracle.com>
>> Subject: Re: [PATCH v2 6/6] accel/kvm: Fix SIGSEGV when execute
>> "query-balloon" after CPR transfer
>>
>> On 9/30/2025 2:00 AM, Duan, Zhenzhong wrote:
>>>> -----Original Message-----
>>>> From: Steven Sistare <steven.sistare@oracle.com>
>>>> Subject: Re: [PATCH v2 6/6] accel/kvm: Fix SIGSEGV when execute
>>>> "query-balloon" after CPR transfer
>>>>
>>>> On 9/28/2025 4:54 AM, Zhenzhong Duan wrote:
>>>>> After CPR transfer, source QEMU closes kvm fd and sets kvm_state to
>>>> NULL,
>>>>> "query-balloon" will check kvm_state->sync_mmu and trigger NULL
>> pointer
>>>>> reference.
>>>>>
>>>>> We don't need to NULL kvm_state as all states in kvm_state aren't
>> released
>>>>> actually. Just closing kvm fd is enough so we could still query states
>>>>> through "query_*" qmp command.
>>>>
>>>> IMO this does not make sense.  Much of the state in kvm_state was
>> derived
>>> >from ioctl's on the descriptors, and closing them invalidates it.  Asking
>>>> historical questions about what used to be makes no sense.
>>>
>>> You also have your valid point.
>>>
>>>>
>>>> Clearing kvm_state and setting kvm_allowed=false would be a safer fix.
>>
>> Setting kvm_allowed=false causes kvm_enabled() to return false which should
>> prevent kvm_state from being dereferenced anywhere:
>>
>>      #define kvm_enabled()           (kvm_allowed)
>>
>>    Eg for the balloon:
>>
>>      static bool have_balloon(Error **errp)
>>      {
>>          if (kvm_enabled() && !kvm_has_sync_mmu()) {
> 
> OK, will do, clearing kvm_allowed is a good idea.
> 
> Currently there are two qmp commands "query-balloon" and "query-cpu-definitions"
> causing SIGSEGV after CPR-transfer, clearing kvm_allowed helps for both.
> But clearing both kvm_allowed and kvm_state cause SIGSEGV on "query-cpu-definitions".
> 
> I'll send a patch to clearing only kvm_allowed if you are fine with it.

I still don't love the idea.  kvm_state is no longer valid.

It sounds like "query-cpu-definitions" is missing a check for kvm_enabled().

- Steve


