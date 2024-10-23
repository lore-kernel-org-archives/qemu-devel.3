Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31284CFA44E
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 16:03:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3doG-0006f5-Jv; Wed, 23 Oct 2024 12:02:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1t3dns-0006SQ-8X
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 12:01:47 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1t3dnp-0002c6-VL
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 12:01:43 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49NFfaf6004637;
 Wed, 23 Oct 2024 16:01:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=UTn0K0YlEG0SfU8E6ABM993E3TWLdC2Wk7w5wyWRvUE=; b=
 fvTmskzDMVRTtBYIQiuIEqFP3BNFA1Fg/wMOC6+akP6+z+CHyQBOUShlekT2lOtK
 cdSTNHs5rUe3LLc/bxS5xyTqrjgCdPeo+SYSm4G1DHbH40eyCoWns9SX/X9Kz68s
 jRlrc+gVQlENYo4lGv+Kr5VB7q9ESx74fgalCg8Kp0mioEAqGXns0U9gz4klTmLr
 vFdjr60xBg+HfUXJHhEoT+85qy+yQ3vre1XT/VYc70bYXs5jbGCh7j5wzqf3lRKk
 IgMyzkZ09GynXhdmM3giVNmEZnVFiCLvmU0LYYGo+UzDaisLjzsDc/ip2g22W+08
 rOKhToPPnumxCv+ouOn8NA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c5458msu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 23 Oct 2024 16:01:34 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 49NFsPaA035982; Wed, 23 Oct 2024 16:01:33 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com
 (mail-sn1nam02lp2046.outbound.protection.outlook.com [104.47.57.46])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 42emh2qdbb-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 23 Oct 2024 16:01:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q66MjyHVYiYrCBeQw1n2te+JHznsG33ZHQNSX8kod70XbFkQVLI+6jXdoInQjiaBNXs6nIDEIX3w1jmBHfn7fdjKRXqa9xAfAzRsxaUc69HMpJo+KubR8IFQmKKRqkOEB0cL4JPhha+FpozdX5N98IyBrZMKha8lvZXpn2XOqBWGw1IzhbTwo7rjjM23Ztdzebt2VSSPaDDCQNwiRTM/hGEqSekm4J0BaZ/hPRTJEUXAboMvEo+euWtCqzkr+cz1u46li7jpnm39Oq6mm5WXGFmAOmyD1fZa3GqAKCB557eiKX067I0c1tYapPC1jl5jKxm/E6wTvZda4qf4lB5qTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UTn0K0YlEG0SfU8E6ABM993E3TWLdC2Wk7w5wyWRvUE=;
 b=Gr8YQRLJ5WY2a7aCqxTp9dly2WTgo2D5lltqpVqksu50VX+iG2KxYxZYPB6P5XrbFvcEY0w6yGxdPqkAgSGOs/PIB+XVJytvu6i0AiNUnzrL8L9lE8pNNT2OEXip1h8AQJ491AsCjpvbieYucfDkWmqAwwfEbwFLTwg/L5P0xAgY2ajDRspywfFw/P1wljmYLw0Fe7uAlpsaKI/X4I8qsGf1tiFuY04/nGMwXIGCv5JYVC71Wh/LjLP02FY9xIatJ9FyqWmdtWfpQ267RH2vknMuTnkJwlNFe+v+FmzAp7Kwv/5mwPK7F/Wdw1Zjwhsn2TTPR/w3BxqgorJkKF8AXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UTn0K0YlEG0SfU8E6ABM993E3TWLdC2Wk7w5wyWRvUE=;
 b=loscabFdeJX3nr49SgV87OUtf3Y61EYpLE07f0mSr8zjCb1+N+Rdyjr9a4PfXIhaeR3XOzZGFCLBuQtpxBF2xHHjb7HuNGeWd3iuHzwaBFMgjmHD+jJCUj4lRQOdfIv5wLcGUcI6hRa55gBhB1BTwJxF5dXFxGESv95YPZTE6C8=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by CY5PR10MB6070.namprd10.prod.outlook.com (2603:10b6:930:3a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Wed, 23 Oct
 2024 16:01:30 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%4]) with mapi id 15.20.8069.027; Wed, 23 Oct 2024
 16:01:30 +0000
Message-ID: <4d38c0ed-ae2e-4fd3-ae6f-84cc8e2acb66@oracle.com>
Date: Wed, 23 Oct 2024 12:01:27 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V1 05/14] migration: init and listen during precreate
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <1729178055-207271-1-git-send-email-steven.sistare@oracle.com>
 <1729178055-207271-6-git-send-email-steven.sistare@oracle.com>
 <871q09dv4p.fsf@suse.de>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <871q09dv4p.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0378.namprd03.prod.outlook.com
 (2603:10b6:408:f7::23) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|CY5PR10MB6070:EE_
X-MS-Office365-Filtering-Correlation-Id: e9995881-09cb-4007-ce71-08dcf37bf524
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UGJmdkdDd2EzVHA0cUpuOHJiN3I5SVdSbERpd2hDcCsyTXVpR3ZPajhrUzNi?=
 =?utf-8?B?ME1Xc2swMzZxZ3BSZng5SnlpbjllWVN2NllSblNpN2hUOFFac3lDQWcvL1V1?=
 =?utf-8?B?ZkdHS0xPdlppUnZWTWYrUzkzRDBwbUhSRC9xV2Q3NHFUNyt2NmV6UkgzTWRE?=
 =?utf-8?B?Sm9LbnFhUkZyQ1FCR2hyQXlKMjQvZkpCZzR1clFzajgxL0FxSUFMWStvQmQ0?=
 =?utf-8?B?TDB3TVJBUjlCQUpMMWxrWm05TVNsYW9WT3lSY3VnTU8ycktRYU85Wnpmd2Nl?=
 =?utf-8?B?K2pvSXVldEFlT1lxS0pSOEtiajhFdGQ2OVd3ZWl4UnI2VUpKTjRFWmNaZXRl?=
 =?utf-8?B?NklpR0ZsUkVVdHc0dGN4a2ZPcGJNdG9ibzdLYmY3UlJqVyt4VUJQVGtsVVpI?=
 =?utf-8?B?UW1VZDNpVzBQcEhOcndoOTR3Z0VqS3JDemRrYU9OalB4UEh3TW9SdXRlQ1dY?=
 =?utf-8?B?ZFJDL0NtSEZYZVM1RnpuK1dmZVZPZjdPRDZXL3ZRaDhWUHFQK29rcnFvaUM0?=
 =?utf-8?B?aUdFb1E2Zi93SVZoeHMrNjN2VUpQYWNJcitvVTNtNi9rTENUVXNMYVhlUVQ5?=
 =?utf-8?B?cGFscEZJOXYwUkRJR3B4NUp0S2dVS1JCWkw5SG96V2xFeXE4alNRd1ZzaUJY?=
 =?utf-8?B?QTRBL0N0UXZwa2s0djFReWNxOHBGMlRXVk1MR1VwL1QvNi9sNEl1Y1p4YmdR?=
 =?utf-8?B?cGJzdTd5R1BCWVllS0lLRXlqQzA1RFMxbS83UTFBRE5GM0xmZUp5NTI3aVF1?=
 =?utf-8?B?a1kxVTJBVHNzTFZ0dkRUMDZ0bTNCUVphK3BUSkFhSldrY1BHRWdMcEc0Vjd5?=
 =?utf-8?B?TGpMakdCMzkxNkZSWkJXSUlPR2JLbVhFMjdsRTl4ZENIaWVQdnJYYlZIaEpz?=
 =?utf-8?B?Q2pwQ2FBNERlNUlUckU4Tlk4d0lhZmZ3NkVvbUtMV201ZU9JbGVXcGV1TW5F?=
 =?utf-8?B?TzdjelY3ampvOU85WlM5YUpMeUxTR21CQkNKUndCVER6ZkFRTmZYbnFNZmdO?=
 =?utf-8?B?djFKU3lLbytBWm0zSzFHempVaWo2TnhDazRPVmE1U2wwUCthNGpBQjI4YmlQ?=
 =?utf-8?B?c1dmaWVZUittdmNmVU1jb1ZXSGNmcnh5VGwzUXlwQ1piQTVLMmRwM2NVZlhJ?=
 =?utf-8?B?VmhLcHhXK1N4aXhacVRNdzZLZnRYQXpBdFY0T29UMkxscWFmWktXUWhLd3dW?=
 =?utf-8?B?c3l0VG01NGl0WXRpaG9JQ2krVHdnbThUMm5tZ0N3N3JFOUNTc0crOHdxeXcx?=
 =?utf-8?B?cStTd0NHL1M1c2dhbmo4QWpLNTNKaDRwSi9mYWU0ZStycnhtWGlZNzB6MmNi?=
 =?utf-8?B?aU1KYzNseVBKUzNsS0hyTzZJSURhZzRkeHl6Mm9CMmFoQzhhZkFoVkNDUHNE?=
 =?utf-8?B?VTBTd0Rub3I5MTVjTWJjalNkV0RITzgwNW5LSHdrdzQwaU5SYk04Sm9DOUZM?=
 =?utf-8?B?OG8ySnJQcmVSQ2lGd1cxNHdMczA2REh4dkllS0RMRGVuSWZKRkwrblJOSDNJ?=
 =?utf-8?B?RjU4bHhSK1ZQKytxNXlkMGRQNi9IL2FyZVpvQjc3eEVlQXBXNTNXMVgxaEtm?=
 =?utf-8?B?bC9PVFdtK0xaV0tGcU5mYmdUSHhGZVpKeWhCZDNGaGRLc2plYzhDWm1DRTM2?=
 =?utf-8?B?UnhmV1ZTSC9pMXBXUGNhSmh1ekR5aTFJVk8vT3cvb1NkejFEMHRHY05Rck54?=
 =?utf-8?B?M2JlSnBEaktYUis5OUtCL2t1cEdoM3VmcUd6SDcySU5UazdHZnlvZWRvcTVn?=
 =?utf-8?Q?C+YXKv+59iwxQKsRgp2UYSP19H1YGXSeH5TPFgY?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(7416014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWFNNXdLWDhTcGlsSEFBL25pV1FqNHphNS95bnZCMnBIeW9VOGNJMUpTTDh5?=
 =?utf-8?B?UndQV1VkUGc1U0RoUThKb0lScUpGbGtQaDFnQy9sN2RDUkhhaW1xcTlIdXFY?=
 =?utf-8?B?Qi9ISy9qN1E1QndnUWd6OGFaa1lKZW9MZEZGNnIvcS9TeDdiQnR6RndscnlF?=
 =?utf-8?B?WmxubVd5UWhsRXNsT0U2bU45bzA5VjZnTkRZVElIS2JSdTJVbXQ1Q0Zaa3pt?=
 =?utf-8?B?eEVEbTJUUzg0RGZrWTR5NUU2V2JyeFBxdDNxQTVWZzBaRVlzc2E2T3c0b1Az?=
 =?utf-8?B?NWt6SEdweHZhbG1hTGFNRFRpOGYyS1ljYms5ZXNoMVlYcW1WdUg1TDBGeVlE?=
 =?utf-8?B?eCt1WVM3aC9uQndEZVBhaGxTVzU0ZGRWZWRJd0d3Um52MmwwSWlYa0lhaUVx?=
 =?utf-8?B?YTkraU5uTzFCSWdqMmNNNUZXVVE0d1FQMG5iYzI4UEl6KzFpUDNsM3FsNURD?=
 =?utf-8?B?MnlKdUU1eHhBREJLRldNeDNvUWc5QVBpdHI4QVBEZ0tEM2lrZ21CeDVRWC8v?=
 =?utf-8?B?MXNCTElQUy9vMWQ1aXZReldIeEgyRGxOdkUwOCsyL0RQc2R4YXhJcDhTQ3JY?=
 =?utf-8?B?Y3d0SDhvY2EwR1ZrMzJJeUprL2hhVnZJanNIMkhhdVJQVlVtLzRaTHE1Wlp0?=
 =?utf-8?B?RWROQkVHWGovbkZXK2kzZE5TbDJoRW5QbkMwbVZ2MVNUN1RoZjBlbk1haWlC?=
 =?utf-8?B?VFQ0VTdtY01VdkdvdkdiWnN1MDZ3MUV5VXRuZXlBRFAzSGxaY3FTU2ZaUGd6?=
 =?utf-8?B?eVlNYkZ4emdNenp0ZXo0WWpkSEMzVWZjekNFUTJkVmhLdytZMGVmTmpNamJy?=
 =?utf-8?B?MEwvb0RCTnZ6Uk9aRUFtTjBLNm1NbmdQdVZVNk8zS3F5SGRRVE5MTXRyOFVC?=
 =?utf-8?B?R1dpYWFvVEpNaWdVQmlQcDk3cTZMS0I5OCt2bDNMTlp6TXlQZ2duQUdxYkRU?=
 =?utf-8?B?a2VxZ1dvOHlQNXJzV2tCZFBIVmVjenh4NDNQaG1qRUluajhXMXpoaFF1RkJp?=
 =?utf-8?B?aW1oUmpKakFPbEx3WERJYU43SU1DaE9MbFJubTBmNWFSTFhmMThnbkovVFNv?=
 =?utf-8?B?Q01FYjQyVlZxT2ROdE1aYWVYR1p2ME9rcFNxNzRIeHJLQUpQbGlBM2ZtZ3RG?=
 =?utf-8?B?ZzdScUJyczJIOGxwQnYvWlBEdmY2UEsvN1FNOVE1VzdPQkdDeUI2QmlnWDRs?=
 =?utf-8?B?ai9pTE1FV2FNRHdqODBENVVkTmVvdnNvQjliY0tPaTd6Lzl3ME43TTNXU0hk?=
 =?utf-8?B?YmdMcUkzZUpGc09Ic1c2NkR1akZxVmVyNGhWcnIreWFJeSt1R0hpejVFQW41?=
 =?utf-8?B?OXFtZmhoSG5NeEduSGFPMGtwS0hRTEI2dFR1V0kyUVZzWmNac2p0QzBtUXFh?=
 =?utf-8?B?OXN5Z3ZLNHFaL0ZxR0NEWitubCtFZjQ5bmdXS2xuMkt0bU9xU2hzbWo1YXFY?=
 =?utf-8?B?VXdVM3FGelRWbHVvT0w0TDVyQkU0ZjJWY2w3V09hVFlkY1hwWi9RN1FiMEFT?=
 =?utf-8?B?Z0ZRVzVTdThGNE9pYWtkV1FSOVlVK0JuVDJFTmN4THpBdTYrN0laRW5GS2h4?=
 =?utf-8?B?dFFaV1E2dEtwUXVhTW51Yk1MY2l1WGlIVWIxcERCWUwvVWhiV3ZYZmF6YktG?=
 =?utf-8?B?bGxTT0kvZXVrNE1TdXZQQlRmaGwzMWFJMERIOTA5WEFPZHIxdEQ4ajlncVdQ?=
 =?utf-8?B?dkxYcktzcHF0aTZwOTZmbFc3NEtvc3V0QU9acTA4S3ZoNUp1elFhYmIrSXov?=
 =?utf-8?B?MUJiRU9YNFNLRHJwbGhpNlJrNkc4QXZWd1pPN0lsRnludnZnRWNJdEZvbC9D?=
 =?utf-8?B?Sm00dDBOdml0MWJ5TDhFQ0w2YmhKeStCRVJBL1RsYzlPeFpSVVo5eHlKb2Jn?=
 =?utf-8?B?emJJNEpYR0pqMlRCSmM1TE45WHpjK1BIandJUzFRQjFMWDlXNHd5THRKTXhI?=
 =?utf-8?B?VmdUWkRZVGkzT1lNZkxncnVMdmRsY3kzcjlMc2VsaWRaeTYrNlZzRTUwUUpy?=
 =?utf-8?B?UmNzVkxNZXYwWUppRFlVanlnc0hUSTh1RVJMRkJIR1RqQjhOUkord2dVQzNB?=
 =?utf-8?B?MHlWQ1VrNWUwUldQTUxQcUdVcU9NQ0tWU2FUd1U1UUQwOVkvd3JSZEROc3Bh?=
 =?utf-8?B?QXgwTzd6TjJlYVUrZ3lQUHNRWm9rZFo4MkZuYzQvQVYybm9ETHZuc0h2U1lN?=
 =?utf-8?B?eHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: RMppL67wg2vD3KqRh1YcDeyrTK7vKqavleJamIhSmJ2gjp+yujv/z2hSIXcLaUeqZPQ2cIlBb4+M24hyVFkAQkWBLM7ZgtqvOhpf3Yo4PeHnhYkOTXHQ7uAKtNDpMB4nM8BFakg6IRDnD2hzehXHN0dGNCwUXwO2QxDhI/6AbNrjSdKSQb7ObXUZaIQuEbectj6KvQ18NKzYa5aqwcCTXrhOOC9paLRP7+STmWJq7DLuJEqMEc71X7ASw9N38HTY9TlzJUrqZAcDcqjqIWfkxJdepMIToGXMHTWDLCD3fSFgP2YLdW6yFznASsN0+oizYli53h4hveVAciDr0ki8J/nub/nHnF/6aKSu14m2gl4ngDWQXKZk9hKed77n6bbqVi4ePEv5mHrhnxje4ttstryTx9k+tWapkIOgzxUKcfErJm8+ksIiJ+DmFA21B81X0AkouApvOuF4NNOTzVD4+wzOk2++L46j2Bx0zmWaAXf5Nfk673O8mtOwrTUC5Xy1IuacTGV46lw8NNOqg6m6ykhTECWEMEw89nt4unSr0SbaNgv/S+acuKotRg10PNG5O0aF6GZuCv27PirCuTG7qOBv+6Fq40+1Escd4PEWKlI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9995881-09cb-4007-ce71-08dcf37bf524
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 16:01:30.1278 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DMZsJT1N+aBtidtPyzrgYjoPyW3sajVhs4xWJWJyOQmjyJRF9FejwkO5AmQoA6V3y9rq7ZiNlnlHiu43kWWGEMevduFp8KWKEpFSqC4nElI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6070
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-23_13,2024-10-23_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 adultscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 spamscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410230095
X-Proofpoint-ORIG-GUID: S6EZ8iCnLxT9xer5rE6OLb7uynzamDk6
X-Proofpoint-GUID: S6EZ8iCnLxT9xer5rE6OLb7uynzamDk6
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 10/21/2024 5:05 PM, Fabiano Rosas wrote:
> Steve Sistare <steven.sistare@oracle.com> writes:
> 
>> Initialize the migration object as early as possible so that migration
>> configuration commands may be sent during the precreate phase.  Also,
>> start listening for the incoming migration connection during precreate,
>> so that the listen port number is assigned (if dynamic), and the user
>> can discover it during precreate via query-migrate.  The precreate phase
>> will be delineated in a subsequent patch.
>>
>> The code previously called migration_object_init after memory backends
>> were created so that a subsequent migrate-set-capabilities call to set
>> MIGRATION_CAPABILITY_POSTCOPY_RAM would verify all backends support
>> postcopy.  See migrate_caps_check and postcopy_ram_supported_by_host.
>> The new code calls migration_object_init before backends are created.
>> However, migrate-set-capabilities will only be received during the
>> precreate phase for CPR, and CPR does not support postcopy.  If the
>> precreate phase is generalized in the future, then the ram compatibility
>> check must be deferred to the start of migration.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>   system/vl.c | 35 +++++++++++++----------------------
>>   1 file changed, 13 insertions(+), 22 deletions(-)
>>
>> diff --git a/system/vl.c b/system/vl.c
>> index bca2292..d32203c 100644
>> --- a/system/vl.c
>> +++ b/system/vl.c
>> @@ -2753,17 +2753,7 @@ void qmp_x_exit_preconfig(Error **errp)
>>           replay_vmstate_init();
>>       }
>>   
>> -    if (incoming) {
>> -        Error *local_err = NULL;
>> -        if (strcmp(incoming, "defer") != 0) {
>> -            qmp_migrate_incoming(incoming, false, NULL, true, true,
>> -                                 &local_err);
>> -            if (local_err) {
>> -                error_reportf_err(local_err, "-incoming %s: ", incoming);
>> -                exit(1);
>> -            }
>> -        }
>> -    } else if (autostart) {
>> +    if (!incoming && autostart) {
>>           qmp_cont(NULL);
>>       }
>>   }
>> @@ -3751,6 +3741,18 @@ void qemu_init(int argc, char **argv)
>>        * called from do_configure_accelerator().
>>        */
>>   
>> +    /* Creates a QOM object */
>> +    migration_object_init();
>> +
>> +    if (incoming && !g_str_equal(incoming, "defer")) {
>> +        Error *local_err = NULL;
>> +        qmp_migrate_incoming(incoming, false, NULL, true, true, &local_err);
>> +        if (local_err) {
>> +            error_reportf_err(local_err, "-incoming %s: ", incoming);
>> +            exit(1);
>> +        }
>> +    }
> 
> Doesn't this break preconfig? Now migrate_incoming happens without user
> input so there's no time to set migration options before incoming code
> starts using them.

This branch is never taken for preconfig, because preconfig requires defer:

qemu_validate_options()
     if (incoming && preconfig_requested && strcmp(incoming, "defer") != 0) {
         error_report("'preconfig' supports '-incoming defer' only");

- Steve

>> +
>>       suspend_mux_open();
>>   
>>       qemu_disable_default_devices();
>> @@ -3773,20 +3775,9 @@ void qemu_init(int argc, char **argv)
>>                        machine_class->name, machine_class->deprecation_reason);
>>       }
>>   
>> -    /*
>> -     * Create backends before creating migration objects, so that it can
>> -     * check against compatibilities on the backend memories (e.g. postcopy
>> -     * over memory-backend-file objects).
>> -     */
>>       qemu_create_late_backends();
>>       phase_advance(PHASE_LATE_BACKENDS_CREATED);
>>   
>> -    /*
>> -     * Note: creates a QOM object, must run only after global and
>> -     * compat properties have been set up.
>> -     */
>> -    migration_object_init();
>> -
>>       /* parse features once if machine provides default cpu_type */
>>       current_machine->cpu_type = machine_class_default_cpu_type(machine_class);
>>       if (cpu_option) {


