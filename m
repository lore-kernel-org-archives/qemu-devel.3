Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45F6606A31C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 09:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=proofpoint20171006 header.b=g82lztDj;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=selector1 header.b=G1xHmv0S
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQLHw-0001Kv-8S; Mon, 09 Nov 2026 04:03:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xQLHo-00019N-9H; Mon, 09 Nov 2026 04:03:32 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xQLHm-0002Qc-DL; Mon, 09 Nov 2026 04:03:31 -0500
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A96Cm16870442; Mon, 9 Nov 2026 01:03:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=Yx6m98+lX/7wIibNjWydumpqLLVx03YPHKTmPAPqd
 s0=; b=g82lztDjvQ/WofdAJvv2LTz3w1W+vfs0TK+NN2vCk5RVSd4F1Igsp6MzU
 95ADO/B9HxoX++XHjs29JDPE827yQtMBSVaXH9UFFlyZXpMgBB6z28p/O5I9q9Zi
 X2LBi0TCQ4T7a/YhEGZ2ARQ4dZsuZ2hpSV1iwFYVaM60Ra2ItyFlo6mPp0TEOp8C
 aLTq6HKylh76r6ODje1ZHDj8imhrXp0TXmULQM7wQ7ZVHq1aZGMzu3pnVvyUvS9j
 mh/O5wA4MBBmqbSUwD0GiRWPe9zZLzq6JeIluuZME2TtTT15IbfUTFAuiCQIY6vm
 wU1EHLb0CcdyTEsSlQQNK1TLZ04ig==
Received: from mw6pr02cu001.outbound.protection.outlook.com
 (mail-westus2azon11022081.outbound.protection.outlook.com [52.101.48.81])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4ht0sb2hw9-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 09 Nov 2026 01:03:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BmgoyaV9va2d7ONk0YL/h8ust6TeAqlaTdYN+q+XsvYx+VPJSbc6CHA9tMU0d+ipZh55nvbNrMvQwtc2w1uCgB0alJuiG/8dUVPblb5FWaYJRSn2HNK9irg2PMpkpSSkJ3oL7TeMvsgLbxkp5L5Q3SS+FTQS98QCtbMOkqYV4b19EtiFEWM5t1CeGO09iBmH66SSmDA0EtsiH3999tDBJpfZLyIy0YzVTwsU0GItFxDGWI/HENcRnHTUxXwhkmRkyXsgF+w3vLFnf78U6DvuabA2cMB4eyNnHs0dzXBUHN+oRs5cu/6XBPhXW5mK9CEIlqEerT6tu5UN82bWrk6wVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yx6m98+lX/7wIibNjWydumpqLLVx03YPHKTmPAPqds0=;
 b=HgdW8oeE7QDLImusJgp2yCrZm4hBSNVStl6WpfKURW9wfIHcpu2AK+J6dRmjbKvHHFOz/nQU68lOAYsXYodRtUBTYJXDNFdWgMcnkEgo/0X9ff0reIwoq9QrQeZgPhDvwhIdYsxrVVLW7ODqLbkROEgm39PLJKU3JHCU6nmahPu33noGgXSOInx/LncgGJa7UGkcJLayVvxwcTFnjKJ8Nb3ZYqlCCsSc65qllLo36d2p2ElJYN24kpW6XNsr0Mt1BrOmAWI1KwVt3Vp6eR9mx26OkqFVddC6P6xgDN4c8RuuchdEHYCH1A/dX//9Y9Y8BiLXvUCaxO8kIt9NhX37Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yx6m98+lX/7wIibNjWydumpqLLVx03YPHKTmPAPqds0=;
 b=G1xHmv0SXtJAty/iliQhVWe6c06TWEgojcG+nR2xABij65YVjS+YIUfHe9TFdCLMnFVBI5KV3KsLFjINuggsKD4FwX7/rs+mw7/eQFGtf/8TLo8lz5MYLdZiaRKggRvfqDl6qtGe2uDxgmql7DbUnntqRWhdix+rMbDCU7S/91VPYtfKvNoadxd4uXMlpDPtw1nutyov7daBQiUs2RmaPAQVMifhv0g82k1ArpxVXQdgOoRQ+OEPhQVtKSh7RIPL4WFK11N30W38+SP1gOvIT0G16kH9hlwKXee2Yi7sDPIhBDumiVXk2+huTtv+tfbudqnUJ3633vVBADxHBa8YZg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from MW4PR02MB7153.namprd02.prod.outlook.com (2603:10b6:303:65::11)
 by DM6PR02MB6480.namprd02.prod.outlook.com (2603:10b6:5:208::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 09:03:24 +0000
Received: from MW4PR02MB7153.namprd02.prod.outlook.com
 ([fe80::2d8:c73a:b2f9:f1dd]) by MW4PR02MB7153.namprd02.prod.outlook.com
 ([fe80::2d8:c73a:b2f9:f1dd%2]) with mapi id 15.21.0592.012; Mon, 9 Nov 2026
 09:03:24 +0000
Message-ID: <eb5c0a35-a5a9-4986-9999-1a0917c0c01d@nutanix.com>
Date: Mon, 9 Nov 2026 09:03:19 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] hw/gpio/pca9554: Convert pin properties to class
 properties
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, milesg@linux.ibm.com, qemu-ppc@nongnu.org,
 qemu-arm@nongnu.org
References: <20261106110440.3552588-1-armbru@redhat.com>
 <20261106110440.3552588-6-armbru@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20261106110440.3552588-6-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0006.namprd05.prod.outlook.com
 (2603:10b6:a03:254::11) To MW4PR02MB7153.namprd02.prod.outlook.com
 (2603:10b6:303:65::11)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR02MB7153:EE_|DM6PR02MB6480:EE_
X-MS-Office365-Filtering-Correlation-Id: b72175f5-08d6-4e15-e27a-08df3e404fb6
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|22082099003|18002099003|10067099003|4143699003|261102123227099003|261022075727099003|56012099006|261021121427099003|261021123027099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: DTE4Tus39M/V5EyVZBIZCFejxTsaoSr8dhhvm+JgVQAfnLNrll2CWZa6D7nazBQzjdgFS3l8ZicsU5AdBMaYVqKmY0Z63MX7LvA4Y2iZZfywAD2nQ0gxMvSgY2p/vZmkra0PKDdt6hf0sV12BHOzoEtEgd8nAqQHqeQGlwVoTD3iybeyWo6FdNSrmRHnNSaNV1/TtYMcZt7ASklLCWZ58IEpX4JqKeOsd5vHQC3dPEpzREigQW9Qln0dvuAWSnnp2vjq4hn5sYxGyDMptHfJ1+rftjNoBm8kDVhP0GRMxBzmL7Fr1/HWueYEXl3lrRV4JX9Trp6Y8/OO2G/XxEbAWN5TA7uA76VSZu7BFmjwP1F6pBnxqeu0IRaKAG0iuC2KVVXWB2adcmwj2T71Evtjwj1V3jVwwXINXC5TkkifvlBR1vgVOvbr4nLpYZQTRVCX7hs7RjgnGj6jwApOZSzowUJ7OVTnwFtNzhwwxsy3cjbgblk1Zhfd6jNf2tP63eNJGwSr1do+CfzO+MB0Am2O7AAEBfcqN+EhwphwCJ1Cgc0HhA/xrHK5mlzUwVosLyvzKUn861nIAmNyfTvk+1tih8jLPcII6LPzF7/1REIWgkz5Y38RL+52kI72CdjvjmcCoq8DTRsrqLCh+oR9GG3WbQq9mUb7CI2ubfO8VG8QaH0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR02MB7153.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(22082099003)(18002099003)(10067099003)(4143699003)(261102123227099003)(261022075727099003)(56012099006)(261021121427099003)(261021123027099003)(261009223027099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TklZaWtvUklPY2YxeWFYd1ZXc2ROQTdqUWpxTDJFeXJRRVl3YnNjQ2Z2OFFB?=
 =?utf-8?B?U2ZQeW5aSzU2OUVhU1BDWUxQUXBhdVhPMmpVSkZHZnNTYVorSzVnK044TGJE?=
 =?utf-8?B?akZ4eWkyNXp6cGF2a0QzRzMwc21aTGZ6cnl6L0l0NFRVUDVkdFFXdG56SXhx?=
 =?utf-8?B?WGxFdHFLSXdzd0YwZWdQOCs4ZFhSM3JNMWNHbElkaXQ3c3kyWHJRejVRakNX?=
 =?utf-8?B?UUNpdk44OW56aXBWSkZRWk1MZGt0UE1pMGo4a1Rla1BsMzVVWnBDdWFpL2FG?=
 =?utf-8?B?Wm13Ly9RZHEzWkFZZ2NqcG5VVmpRd1docFlZOURZb2p6dWJ4OTYyK0VPZW13?=
 =?utf-8?B?ckQwcmR2T2VSYk1uZWc5MzZMbHFlTUdOTGZKZEMvYlprMVNNYnNFQWY3Yjdz?=
 =?utf-8?B?bkNkVmh2M0E5UnF3T1VKdUVtd2RFaFZCK3NlK3d4UjFHa1B6WndWcE0rTFhp?=
 =?utf-8?B?QzI3ZmY2UlZsZ3ZIaW9kMWNZK1lUbllXekg4QndJSVVlV050TEtXYWlmYUxY?=
 =?utf-8?B?Y0M0Q2t3SzhNZ01lcEN1SmtLeTVTZ0RHM0VyT1FISVhYUTZ0NWZKejEwMWM4?=
 =?utf-8?B?bkN1RmZMbWJkUlpqMGd4eTI3czJWbGtQUWZjeFpqT1hKUTgvRHhhVXZTY3ZE?=
 =?utf-8?B?ZnhDU09xRjFDS3IxT2VWYlZCYVZKZXBPM2EwblI0K0dsbE84ZkNpV045RFZt?=
 =?utf-8?B?M2x5cTRWUmtNV3p5dUxmMWtXSWY5ZjZraDlxZXdGQW9FL0JkUEpVekJ4UE1z?=
 =?utf-8?B?SUU3SmZyZEhJdW1GKzk5VVY3UUN5N1ZIOFI0NUk3YktPM3JoMndJMFZlTWk2?=
 =?utf-8?B?QmVoZTVsRXpkMEJrT2JScHd3REVERmVzRm5XVk1yUDlVaXlWNVgzTzBoYkl6?=
 =?utf-8?B?T3dYdHRmYjA3anpLNjBIci9zOHRad3lRdnVxYXo4VklycWp0VlhqcjJyMWVM?=
 =?utf-8?B?ZVdKdC9jcFVJVjBlRFVzMTNPK0JqNDdzKzhJVzg5MlNFYmtjdnJHOTJKcmE5?=
 =?utf-8?B?YmFSU0d5K3NjL2RpY1lKUExnVkZqSzdqZ3pMYUdPc2pVQk5YL3hiaGk3aHF2?=
 =?utf-8?B?S08zL2RHaWtrWFZKWnVEaGJRViswc1dQUmg2K0Jta0dueERqMEt6UnJkemtE?=
 =?utf-8?B?QURqZG93UmFtTlI3S2hwbXQ0Y1YrRXU3SXc0RWZwVW5ObjlWOWt5ak14cTJ3?=
 =?utf-8?B?NnJxdDlBOEZSbkZiRk5sdER4Mm5JMmxSLzJMTE5waXhySHkvNUozL0hzSyts?=
 =?utf-8?B?NWgvYzNXSVRHRVU1MGJ4bTJ4d2ZmUXRjSlRKWUtwbDFuM1RyclpNd20vckZY?=
 =?utf-8?B?QW9XbDYvcWZsK2JkdGVCOHhGQnV2ZWZVUTdEMGE1ZU9UMVR4UEVzamd6Qk1L?=
 =?utf-8?B?eGVnR3o1MFdTOVJPSXUxV2ppZzlQbXc4NEUzSU0vMElSMUF2OU0wU1ptanl3?=
 =?utf-8?B?YVV1Q3pIWWRFaTAwU3dmZ0VMVTQ4aGVNSDdMWEN6THA4MjlRMUZsMjhBb3JN?=
 =?utf-8?B?YjlxSXJGR3JsVWxsd1pHMTdrTVVCTDNUTEtqd05qbFdNaXpZMnJEV1RoS2hG?=
 =?utf-8?B?NkRjcWFkNUVWUjFRU2czeUhacXpXbFNkNm9QV2Y2SDZhZ1pZK01XMENuTEpr?=
 =?utf-8?B?Njd3K3BIKytEdWFWQkF5a3o2aVZWaFNITFdWbjJiOTVhOTZBOTQ0ZXltMHcy?=
 =?utf-8?B?ZEF3VTJsNkNHbzBtdVM1VVcrTHJHTEJkL0RLU2s3a3I4bmRhNlc1MTZocm1o?=
 =?utf-8?B?ckJDeG96Z25aV0ZiN0ZpcldKdEhSQVZtN3R2YTN0c1lxaTdVRldzT2VBNVRh?=
 =?utf-8?B?RnltM1J2R0pHT3g2eHgvSlUvRDlUSG9TQTNhd0hDTWJ0eWZ4NG5lU1NUYjU1?=
 =?utf-8?B?T0lNSk1xZlo0V21UeW0vazk0SXc0ZHV4clc4U3pjN2drR2J0bkFWN0hPV2R5?=
 =?utf-8?B?ZWdNSXlWWlRxVHA2OHp2VWp2ZmpMeCtvVHp2Qk5JbkRRdlE4aElWZmZEZ1Yy?=
 =?utf-8?B?K1crQllXT2pJeWtDeXFWMHdUTEhvc0phMDQ4dFBWd2FUZzFzdmtFU1dLM3g2?=
 =?utf-8?B?NVg2M1ZUUGNadGx3dERXLzh2Z3BPUXptWUVEREpGeXoyekdQRlcxNGFMOGI2?=
 =?utf-8?B?cU1SSHllZDF1STcwUDZpVE1KaHcrSHdscC9qOXVkQ0hSSWhkUitqMTI2b2hS?=
 =?utf-8?B?R3BKektqZGhNRFJXTUNBUDZhNXNEWEJ1bjFWR3czVXFqRDNrNm5FNVY0RWx6?=
 =?utf-8?B?RXU3Y0VxVmE1TDgzQXhtLzY5RDdmYjk4YXNrcWNwd3piWVpPeVRtVjQ4Ykk3?=
 =?utf-8?B?NXNXWVBTSXBZcytzVlh5R0R2YUdJd2hEWlpzbXBPeWxlQytGUlI2RWRwZXpL?=
 =?utf-8?Q?6jJOZxjbQF6WnmTw=3D?=
X-Exchange-RoutingPolicyChecked: Liyoi5wlbinZvgM1EqvnsYU5rzPhkS0TRnI1W+rtYof/aoGtDE01SnujZJonAXzLPaIUamNcEa5XkCDCE0XU6NazigzamUhQrt6/hw36j6iu4YviBmCBlS3pW1B8wB7bbYi8E/PJl6bgEwUVInty+JzWzj4uMTwFeESJKTN8Wqitnq7Z/xtGV6tWuCb7N73K7/3hBgRql3BBA3/OnQSbKWmc1kkHLh9qNTt8uqETuNIW7JZjf1ktdu5muxzOOXVtLFakYmzINPcyrzVqJXUil+oRVZCdloz5zrCzJcHHMHe0Us2TBEh7YSb/Y6NNSlOKTMKIV3qUTF4pdsZV8pfEIA==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b72175f5-08d6-4e15-e27a-08df3e404fb6
X-MS-Exchange-CrossTenant-AuthSource: MW4PR02MB7153.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 09:03:24.7602 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CkkoBaxjD5+KhV4QRMfYQGWcYkiayMuEQfia31j6xSgt5QoBucZNyuLs1MMOuTWZoX1aRntyK3sWIdcnWQf15LxvrzGebbHdFAzLrvTOjzg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6480
X-Proofpoint-ORIG-GUID: 9V1IJiDMJTo4ORUyCxSxYJhVhQSSJw1C
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDAzNSBTYWx0ZWRfXx4y6JSyR/MFn
 EP5R9dOeq/yC48XwCscALB59QWMB8GnzULqMyv9gGE82MQAG464wjz/NAzigU3/JieBoTgNf6G6
 6laVtQCpNWf2/ie34ER3UmJQEwvUGPjKkLJGCYmASinRC9veGZo3Qnj5epf3TyKKtsHed741fgv
 d311ItWSvdWQJFPYaeVEmycYtCFQ9YzCcEySOiibCjliVg39S9zv8uQ65BfC3PJnDPSMYbZF+bX
 q9hnIIxZvx42an1s+WQCmHhUdgaGTVmf6bvr4Fmr5Qb9YCXQCgHkTSsdJBagkrcadfS17b36/NJ
 p1LPg/0blFYug7kZEkbZxBeZEGgEMKNZbUJBvv+U7eKjJbIwJKkmVV8KlRabWGN/PbKnpQxiaPO
 vOQy0rp6caGPsw7jYvNVMQGDfGg/7IIJcYEo4r7QiJMZot512arDSCSsa5uHuu3gZWfaifbZgoa
 J2TdCS+KI5ZC1ghPwPA==
X-Proofpoint-GUID: 9V1IJiDMJTo4ORUyCxSxYJhVhQSSJw1C
X-Authority-Analysis: v=2.4 cv=R++WitRX c=1 sm=1 tr=0 ts=6af18c5e cx=c_pps
 a=OvjpmfG2phmKxcO1Hl3QmQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=Ap8k9tRZuQ82DLYWQqG7:22
 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8 a=PEI-9Z2BaHhFn6PDOIIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDAzNSBTYWx0ZWRfX4jv9tJW2uZsk
 /XcCbGO42NgC7PAnflWrnptnKbgcRW+4Gk55D99/M/GQxwxUExLkeoYOsEioi1kP7swvLwnAh5h
 14IgxGMLJaqyrJQuEmr59n0Lrn4eGcs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_03,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 06/11/2026 11:04, Markus Armbruster wrote:

> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   hw/gpio/pca9554.c | 15 ++++++++-------
>   1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/gpio/pca9554.c b/hw/gpio/pca9554.c
> index 1362b605c2..ed304e4639 100644
> --- a/hw/gpio/pca9554.c
> +++ b/hw/gpio/pca9554.c
> @@ -290,18 +290,18 @@ static void pca9554_reset(DeviceState *dev)
>       s->len = 0;
>   }
>   
> -static void pca9554_initfn(Object *obj)
> +static void pca9554_pin_init(PCA9554Class *pc)
>   {
> -    PCA9554Class *pc = PCA9554_BASE_GET_CLASS(obj);
>       int pin;
>   
>       for (pin = 0; pin < pc->pin_count; pin++) {
>           char *name;
>   
>           name = g_strdup_printf("pin%d", pin);
> -        object_property_add(obj, name, "str", &str_type_info,
> -                            pca9554_get_pin, pca9554_set_pin,
> -                            NULL, NULL);
> +        object_class_property_add(OBJECT_CLASS(pc), name,
> +                                  "str", &str_type_info,
> +                                  pca9554_get_pin, pca9554_set_pin,
> +                                  NULL, NULL);
>           g_free(name);
>       }
>   }
> @@ -352,6 +352,7 @@ static void pca9554_class_init(ObjectClass *klass, const void *data)
>       PCA9554Class *pc = PCA9554_BASE_CLASS(klass);
>   
>       pc->pin_count = PCA9554_PIN_COUNT;
> +    pca9554_pin_init(pc);
>   }
>   
>   static void pca9536_class_init(ObjectClass *klass, const void *data)
> @@ -359,13 +360,13 @@ static void pca9536_class_init(ObjectClass *klass, const void *data)
>       PCA9554Class *pc = PCA9554_BASE_CLASS(klass);
>   
>       pc->pin_count = PCA9536_PIN_COUNT;
> +    pca9554_pin_init(pc);
>   }
>   
>   static const TypeInfo pca9554_types[] = {
>       {
>           .name          = TYPE_PCA9554_BASE,
>           .parent        = TYPE_I2C_SLAVE,
> -        .instance_init = pca9554_initfn,
>           .instance_size = sizeof(PCA9554State),
>           .class_init    = pca9554_base_class_init,
>           .class_size    = sizeof(PCA9554Class),
> @@ -378,7 +379,7 @@ static const TypeInfo pca9554_types[] = {
>       },
>       {
>           .name          = TYPE_PCA9536,
> -        .parent        = TYPE_PCA9554,
> +        .parent        = TYPE_PCA9554_BASE,
>           .class_init    = pca9536_class_init,
>       }
>   };

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


