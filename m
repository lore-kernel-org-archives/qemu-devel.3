Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E6CACDB479
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 00:25:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcXu5-0002Dv-Kl; Wed, 24 Jun 2026 20:25:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1wcXu2-00029z-QE
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 20:25:10 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1wcXu0-0000kH-5m
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 20:25:10 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65OEUxD12561944; Thu, 25 Jun 2026 00:25:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=gP4NXJAOT3mGc0LmgUqk5mVwLBStSGHTrbTOsQq8QK8=; b=
 BBtbxbM8XVZQV3gVwLFJ0te/1SQx0w8UOqG/kThAej50iatriWzaefU54+Qozthd
 8x/8Khb2vpiDJhO9CWYOP7Vy0Wjd/stguAWJfjYo2oWrjd6PUbMl03FlBpqZjIio
 ZzqvFu3SloXnVdVykUMc4UOATazyCQ3qpOQF4V12VkXgoJGG+9IZo7otmu5w7Nab
 KRNzEK6KCfTkRZnNescIE3TOUfbITpCVnhNNHsjN9AbyCFubnr8to06vc1DLCQsb
 BYp2ZN31Cs0/zOpO5McdW7/a2cCixKbZr2Mls4sKrCqNfeRhy8dI2d/Vc+qG3svg
 sIoB6Bk4jF32McscPW1igg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ewjfueasv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 25 Jun 2026 00:25:04 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7)
 with ESMTP id 65P0NksE008122; Thu, 25 Jun 2026 00:25:03 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11011046.outbound.protection.outlook.com [40.107.208.46])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 4ewhae5by8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 25 Jun 2026 00:25:03 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NgJvJ9aggYTuhq7MCKdI3eXXaoJTdyP4HPZ4tc9VuaPnPNg6Y7a8TomAcUvKFmucxmImFcZrcbhIrXPe/HIGXAOraG13owQ5draOFjTovFo3CItzKA+z63iTUBFvcB77dH4L8HMKymmpjaIE0qcRWou+JcjkXSih61aPBUmRZC79kcrPH5dwCk7MdqOq6IvHvbc+8roFjR6lA2GfkRVunrgrp4gJkV+JeqX8E2tauBBpzGvoFLv+sEBsmWfcsdPQ76wJHNJtBD6aOtDQnsMrKcXoNk+8smMEHt2eDm2noWZ5UbCh4Tw0dC81ndI5icJCsUiGfBX+X8Slq1DMv1LwMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gP4NXJAOT3mGc0LmgUqk5mVwLBStSGHTrbTOsQq8QK8=;
 b=rMz/5NPmUiRhJRkCskYe4NumuzAmhCMgppxFbulziT9b2F7WDV2Fsmqx6LibD/gOd8E8wCRcDgzbA+qDE7Y7Mr1KM6aBX7EyeQLzPv8T8nEsxqnfgdpltAyhTrcCmSdgef4Ec0jfOmVbyMpN+kTSTZxSxL6o/flJulIvchgp8WT0Aof3yQn/BVl1rhvTA2dqyO0A5NisBnrM9An3vkJThNjDmdmJS4TPI6zCvxf0eYQpxk3gCGNZ2rxkcvOl+fMneFTQhnKW+U2eIc1HCnOkC//NXHVglPbXqEdZngSsvRcQGh/pyGkvOYsR/VXmnalRXS/STFL0EHBdQdg77RSAUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gP4NXJAOT3mGc0LmgUqk5mVwLBStSGHTrbTOsQq8QK8=;
 b=U8799cTbQoqqFIA4s9kS4U/v1up+Q47qsh91+SVdBF6T+orBx6kOtJiiSDiLlCS4hm97djptWdTzOPcM9vOBkIl/pkGVwtRZOl7hQNzSfYQsYpZHJOkvCgYGNRjxSbX4D6d63XigFbenPccJLrgdsAwmKU2Gg93G651hgj/mCHQ=
Received: from BN0PR10MB5109.namprd10.prod.outlook.com (2603:10b6:408:124::23)
 by IA1PR10MB6781.namprd10.prod.outlook.com (2603:10b6:208:42b::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Thu, 25 Jun
 2026 00:24:58 +0000
Received: from BN0PR10MB5109.namprd10.prod.outlook.com
 ([fe80::d9fa:7ad2:804b:bb83]) by BN0PR10MB5109.namprd10.prod.outlook.com
 ([fe80::d9fa:7ad2:804b:bb83%6]) with mapi id 15.21.0159.014; Thu, 25 Jun 2026
 00:24:58 +0000
Message-ID: <bd24f7bf-26c8-4bc8-9604-f4dca980be53@oracle.com>
Date: Wed, 24 Jun 2026 17:24:55 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] vhost-vsock: preserve vhost FD during CPR
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, sgarzare@redhat.com, farosas@suse.de, peterx@redhat.com,
 maciej.szmigiero@oracle.com, bchaney@akamai.com, mark.kanda@oracle.com,
 den@openvz.org
References: <20260619105514.128812-1-andrey.drobyshev@virtuozzo.com>
 <20260619105514.128812-5-andrey.drobyshev@virtuozzo.com>
Content-Language: en-US
From: Dongli Zhang <dongli.zhang@oracle.com>
In-Reply-To: <20260619105514.128812-5-andrey.drobyshev@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY1P220CA0025.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::12) To BN0PR10MB5109.namprd10.prod.outlook.com
 (2603:10b6:408:124::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5109:EE_|IA1PR10MB6781:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d1a14e8-6e3f-4720-e952-08ded250301a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|10070799003|366016|1800799024|376014|18002099003|22082099003|56012099006|6133799003|4143699003;
X-Microsoft-Antispam-Message-Info: 2txbmo3UMfEdCbzPbzyvN5Odp6ldW6uG/BcvwmwzSThpLxM+mPYo1cXCRAUamWT9f27WjsZX9LCkgDhCcs/mk/CGd4WUnevvpvx6ZWJL8M418g63gbxu1B+WeI9i1WgBRpX+dVkrfsBcKgsX6KxClQ1punO/cHX51waWZHd5pUyKobKBhsDH2bNqe9xc6aywpTbtHPOn1huq7o8bmhH2Juiw1Q6S2a5jB7mJcdKuyKIbGikE+/uxS6f2nRAj41iZ4LVLnMFaSeWKx122liazxswo9T8o2mjt4LxTMfn+YO2U/+mFYN9ynWaMlL7GSnOgumqHkLBtSVtUg7g1o/pqSy5WZo9I5Ubu9zOC7ySOOLWYGlSDJcOXPsoUpQxnVlGARCGXX8bqiMhKe3mQnRX+Dj8nlJuZwURPRYpRI0f08sgc8nthb6aWYFPLHnhNI+7NISF3UhhwCmb7pBcPAtod5iuxAjgj7zxzy7ABnA8EPgT8rGYvxUuI0NNsC6p/6kqZzOOrFFnOtXrFjyff+Yc2WxN+tjYXrmewGqYfWGg4pQAtqvTfqHY+W042TPjWFPbMhLeiolFwauIC4qHNsBuDRCDTjbwlUfoXtHiS32GoqsWXadWNC9qO4T63VOlqTjryNUFQkYamvGm3n1RchnIc1aZkYrv5X8i1SG9gkXQ4InA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN0PR10MB5109.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(10070799003)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099006)(6133799003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RkNyUXU3c2FDR05EQUR1YldJZW9GOUFQSEtSaDI3VGRpL2YxZU5nWklwUThV?=
 =?utf-8?B?ZjlOQk5zQlNQOXBIL2REaUsraXdPUndDNWFIUGtjV1FjT1hYU2tjU1N3RjhX?=
 =?utf-8?B?SllsTXhhM1lSODlUanRxKzNkb2pwRFFGaDQ4ZmxaQ1B1czAwOW9BSmd3MStI?=
 =?utf-8?B?WjUxKzQvMEdUK1dzalNjR0JER2pjYWV6dUFaQ1J0a1FSYTlzQUxtVGE1WkRM?=
 =?utf-8?B?MEVLdGtYV2o0QVRDNDRuT1NZZjJyNWFYYWNUYm1qNzltNVVkcm5kL3FzQ1ls?=
 =?utf-8?B?SHhiVjZIcG5jMWIyU0FjTVRLdWZON2tTblorclRFRk9PQ2FQVUg1VFllanJk?=
 =?utf-8?B?dzhYbWY3WWJnQUdUWE4yc0h1T1dhbXdFenZGNWZvWjhuSkxCcmJLQk5FUXo2?=
 =?utf-8?B?NzdRRnloRkFCWDNwRWNPcGhzVDR1QjN6ci8vdk9QTjZKOGxEQXJtNi85blRv?=
 =?utf-8?B?YVBoa0NDSEhFMXhXWUFJOWp3OGlhOE1VV3pDTzhiL29ITEh1Qm9hVk1QQ3Rm?=
 =?utf-8?B?ZHJ0TnNlMDNQeVRZV2RmaG9lMjlOQlF6d0xEbFFVOC9YZmZUaFpJVmJGa1RQ?=
 =?utf-8?B?Vi9sNVFQNFNoZWN2WFU5UzNYZ09MRkp6dFZWSVBTeHdUUFo5MERzcFZpY1dV?=
 =?utf-8?B?MUJ5UlhIV1U1cmViWmY4RjVBUE1TRjB1V0dIbUhzSXZpVDl2VjEyeU41RTVU?=
 =?utf-8?B?NlJUdTl5ejdjcEhoOFdBSlo5aEJPYkhRTFlrTUtLS3BaRHVka25hUHBEN0s4?=
 =?utf-8?B?ak5iRjRIZ0tLK1ROZDYxajl1UExhZ2VHUnRkUzNhalVqYThkZitETWRIcnJs?=
 =?utf-8?B?cGtBSnN6TzZZRlBuMWZvVjdSYjlKbUlMb3Fydk1GRGhYTUluWmRmNnptMWMz?=
 =?utf-8?B?eXFya0lLWUhuSjl4NUl5YjJVV1AvZ0JyQVdnM3hoaHZxYjRldlpkb1hOQ3cy?=
 =?utf-8?B?WnpPR2ljdzkwYlc0dWd6a3RPNHFxOTZuOFlTM0JKcFprby9SSU9qdVQydXFW?=
 =?utf-8?B?Q25ycEZ2QTVWc2NZZU50aXU5aktKUFBadklaMkhpK21Hd1Jza3ZjdVFKdmQ5?=
 =?utf-8?B?RWREOURYWWs1NktGT2tHN3hTZHlmNHVMcmdvdVBMV2hlZVNOQnFZa2NyQVps?=
 =?utf-8?B?VU5qbFFtSTFia1NBYXBtc2hLNmpKN0I2angrZmtOU1REOTlhTmxyOUdpN1E0?=
 =?utf-8?B?Q0dsWXhlK3MvREl5ZEZaTlBLU1Jtd3BCZjNDNFhJYlFqQzNwWHd6NmlrZG9o?=
 =?utf-8?B?YU55akpTd2xNbXU3VEZlejlUbE4yQWlwQXhCVnpISzlHSXBwdWF0c2toZ3N6?=
 =?utf-8?B?aDRiTGlLNTI2VWo4anU4V3FqM2l1U25PL3Z5eUZucjZOTTBPdXZJbC9xd2d6?=
 =?utf-8?B?SmVCZzhtdHVLT1dIL3UvZ1hzMGxPWXNkZzZydE81RklGU0d6T2gxNllNSE9u?=
 =?utf-8?B?OUt1b2dUZGROR3hsN04wTXhvMmNqNXNxcVp2U2p3eGhkMXFCbWFYak9yWG1m?=
 =?utf-8?B?c2RLZVY0amhkZjBtT1hqMVRBYmNsSVRTVkltTXpDYXVobUtPUEhuNDIzcWhl?=
 =?utf-8?B?aEdhMjFORjN4TEdjL29DeDA2dUNLdElzWGFiWVU4VkxOKzBqWVZaZkIyMGpH?=
 =?utf-8?B?UDFnNkpqcHZpejFOL0ZnaExtTUdqWmxWdFhlcjVjdk1Jazh3NGpPV29lMTdT?=
 =?utf-8?B?bzllNVlERVdDVGE2aVF5VGs5NnNXRmgwRXF0V1U1RHdKaW1FK3ZFWXFPckF2?=
 =?utf-8?B?RGsweWJPSGRSbCtlSUhCSnZncWhUa3FHd1Y5dG5PTEhEZXpPTzJDc0VlelJP?=
 =?utf-8?B?czJuYXI0dTdxM2grK1d1dytpSVN5R25BTXcxMmdNNUZjV2pHSUpPYzVHMGoy?=
 =?utf-8?B?dE9OM1hQd0x3cHNvQ200MVhaYVQwaE5xN1dYSmZPaVhnTVpLRXRUNGRpNlpL?=
 =?utf-8?B?Qk1UV3VZK3F1VGVvbStQU0dEdnBnUGZlVWVNNHY5RHM1RkovdTVRYTl3R3I3?=
 =?utf-8?B?ZXZRVUE2TjhzRVQ1MnB2VGdXNTFJaW9DU0tCeFE0SWtobE5hZ0FHd0RLNDdt?=
 =?utf-8?B?Um9DVzFGd3hzTWZMcXNrSDJFbEtlWURUa0JxY0lYcWY2NWM2cXpjaGNpdUp2?=
 =?utf-8?B?aUNrM0t2RExEekZFVlpXb0pZQk1zQU1KOXhoQ0xQNEJ3akpZSmZuc1ZQMisr?=
 =?utf-8?B?QXpxNFlOWm03ek1FTW14UGhCZUxaT1loenQ0aU1OVEQ2RHRtMktRNno4V2N4?=
 =?utf-8?B?UVFvKzU1RkdOaHE4anNiQUV5UkhacVBsTzVPQVdZb0JkWllOVmRsUGhhWVBp?=
 =?utf-8?B?U3hTRENHdm5hQW91YnFtc0tiTG5FYzd4VzhodFdBMndsbk5UYzIxckpVS01Y?=
 =?utf-8?Q?igjlmD7O+jmWmLFgmdk/dk4hDgjIJ9BpQ+Dnt?=
X-Exchange-RoutingPolicyChecked: PB23OjJ/d1AoxAV3vDK0hlmkg0Os5XkxV+Opa/VQKOXmLwNVigDSkMq6FUQNuNWOsy9PLyVF2qeP7doJoobdUuf5WKkgO/gBmrgvgm2YhW0hW6I0qJix5R1dKIdjZZ1t1xPH+d/GH1YMisB1jCrjO5mXmBPQyU1Ky3kPntiMBthkEqpsC8tyL9vk/Ps56/71c3PeFwj0HmVD/lJeH4VSg97iYvbYVwNJgzMs+mDmtpv/vrxD0c+U8FFVXuivwxz9iOnNocdvSm8LY/YfAf0LkE3BPYSwWcjNO26jVb7P6DqxH3LcUz097Xw/FbwLx9/Yuj91zm3lq8RfBifMQZdczA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: lafXJQfahdq2E3epez89CJGVBfWVPf+GSdsEPGukvYsTPWXtoDgIH4q06F1ZOVkroANJB2/7rMxf/0QbSYoqjiesP8NA3UGr4WnUG7EqrhORy20ddIHdvKjrwTm8ibfKGSW9sTHS1b7fMAOoDDDqqa91xXdUICjidkKQZZCSE+w9doHWlX0laF+rU4veseC1/g2gYHevpdyVEn9g6zpBnXw16CtPLynR9BOWnwyXwL3i7oU90ahjg193zBXtGSUiV10C9sqKx9CiS/V+9NET+74lZTYqfnJRM04GAiqXyWRtTG2+eWQN1lF0jZoFPFvjsixleZQ2sFVpS6cFU34S4fH5eMBcmURL49MKhCsXHjeiMm3mUJ5Mj0xF1a7oQrcJtqs11zvFKVYCowzo9RllQSoGBxHV89Gob0ERuc8dprYSCn/27uM7u/JGz7R+KXhxV8sCW7Qp3UVPf1OfeGUYKGFRwbK3CnLFDlFYfTzDsw+daShuZqe1wffwTv3eQGfFqBKeZXV5bVHtKnuCQIr0OWLHHRxZpJ+C9+fymscBxHnYB1/js8ySvlYTbB2BN1b7TBkUwSJzt/EIGszeZRcuuOqFYiCSz8zJFW641lg8jqE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d1a14e8-6e3f-4720-e952-08ded250301a
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5109.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 00:24:58.1518 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3NmMPh7dkoE0C3GAEAJ521J41JGsnc4Wkp4YT42MXLRL9KJWJviWj+ftp+UwoqoO0Pr2VTAAcn/jcc7YR+wJsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6781
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_04,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 spamscore=0 malwarescore=0 mlxlogscore=999 adultscore=0 lowpriorityscore=0
 suspectscore=0 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2606250002
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDAwMSBTYWx0ZWRfX8+hZnFC1C1y8
 avktxPpyaonfKBCPrtBr9NbP4ADLIg0v4o0+XHgN+MpUKuTi96bBKIQ6HyQ3bfdx6zqGWgiCh3g
 aNn3MdurOyG12yp9dRW3USoznB7Jo3x9hTwenC+Oty+YCO7JrIrC
X-Authority-Analysis: v=2.4 cv=FtI1OWrq c=1 sm=1 tr=0 ts=6a3c7560 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=3I1J8UUJPc9JN9BFgKH3:22 a=TYBLyS7eAAAA:8
 a=VvNpsZfJnh5ydAt0AtAA:9 a=QEXdDO2ut3YA:10 a=zvYvwCWiE4KgVXXeO06c:22
X-Proofpoint-ORIG-GUID: P2hXW_9uVN2xo3IfHkx1p1-YvwfO1RsY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDAwMSBTYWx0ZWRfX9Vh3n2T/7R/b
 d9Nh8CvOQQdh2sxRwkHQcxRf2r+cXMe0oYoSTvrMlrG2mr4jwUjZijsu+V/FRnixecMLQ9hm6G+
 8w0pGYWKCmkugj2If63d1PXonC20Ke59wQSepO81KKd6xMW3+H++ej6lQb8JQTfLofRaCQ4HjDM
 zhc3hevSNAWehBnfH+EeZDMZ1aN2Q3F1v+Ws30RHhHpvXndgDsUf9DSk538tPOHbLmzbEHbBpQ6
 JpJk/7clt0jnpAsdNkbVjUUy9c1DDmYdTvC+x4PtMCM18VcXM6b7R1wE/lYxh/FfYDRE9zV83LX
 8bxOyqcc6buIU65V7fGBoMT8iNjAnobPckmNw7zttQWZic0/UC+9PSuxziq4E8XglKcZGmt1jl+
 Ggqv+ZdyZuRfekKQy8Eig6aq1S2F5NE0z51LtTq0nAjiICM6OBuaa4W7qHUa3OBem7zFxdn4cEg
 2jhBOalEfBqznlsRIag==
X-Proofpoint-GUID: P2hXW_9uVN2xo3IfHkx1p1-YvwfO1RsY
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=dongli.zhang@oracle.com; helo=mx0b-00069f02.pphosted.com
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



On 2026-06-19 3:55 AM, Andrey Drobyshev wrote:
> During CPR migration, instead of reopening /dev/vhost-vsock device on
> each initialization, let's make sure the already open FD is preserved and
> properly reused on a subsequent initialization.
> 
> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> ---
>  hw/virtio/vhost-vsock.c | 25 ++++++++++++++++++++-----
>  1 file changed, 20 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/virtio/vhost-vsock.c b/hw/virtio/vhost-vsock.c
> index da244eb1657..ea9a7d2149d 100644
> --- a/hw/virtio/vhost-vsock.c
> +++ b/hw/virtio/vhost-vsock.c
> @@ -20,6 +20,7 @@
>  #include "hw/core/qdev-properties.h"
>  #include "hw/virtio/vhost-vsock.h"
>  #include "monitor/monitor.h"
> +#include "migration/cpr.h"
>  
>  static void vhost_vsock_get_config(VirtIODevice *vdev, uint8_t *config)
>  {
> @@ -126,6 +127,7 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
>      VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(dev);
>      VirtIODevice *vdev = VIRTIO_DEVICE(dev);
>      VHostVSock *vsock = VHOST_VSOCK(dev);
> +    DeviceState *proxy = qdev_get_parent_bus(DEVICE(vsock))->parent;
>      int vhostfd;
>      int ret;
>  
> @@ -141,7 +143,8 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
>      }
>  
>      if (vsock->conf.vhostfd) {
> -        vhostfd = monitor_fd_param(monitor_cur(), vsock->conf.vhostfd, errp);
> +        vhostfd = cpr_get_fd_param(proxy->id, vsock->conf.vhostfd, 0,
> +                                   errp);
>          if (vhostfd == -1) {
>              error_prepend(errp, "vhost-vsock: unable to parse vhostfd: ");
>              return;
> @@ -151,10 +154,20 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
>              return;
>          }
>      } else {
> -        vhostfd = open("/dev/vhost-vsock", O_RDWR);

I think this patchset also implicitly fixes the duplicate vhost thread issue
noticed when testing vhost-scsi.

With vhost-scsi, I noticed that if QEMU opens the vhost device fd without
O_CLOEXEC, the fd may survive cpr-exec unexpectedly. Then the new QEMU opens
another vhost fd, and we can end up with duplicate vhost threads.

I did not see the same issue when the fd was opened outside QEMU and passed in
via QMP getfd, probably because QEMU sets close-on-exec on fds received that way.

With this patchset, vhost-vsock no longer opens a new fd on the incoming side.
It restores the fd from CPR state, so the "duplicate vhost threads" issue should
not happen for this path.

I am still thinking about whether it is worth sending a temporary patch to add
O_CLOEXEC to these vhost device opens, or whether we should enhance vhost-scsi
in the same way as this patchset instead.

Thank you very much!

Dongli Zhang

> -        if (vhostfd < 0) {
> -            error_setg_file_open(errp, errno, "/dev/vhost-vsock");
> -            return;
> +        if (cpr_is_incoming()) {
> +            vhostfd = cpr_find_fd(proxy->id, 0);
> +            if (vhostfd < 0) {
> +                error_setg(errp, "vhost-vsock: could not restore vhost FD "
> +                           "for %s", proxy->id);
> +                return;
> +            }
> +        } else {
> +            vhostfd = open("/dev/vhost-vsock", O_RDWR);
> +            if (vhostfd < 0) {
> +                error_setg_file_open(errp, errno, "/dev/vhost-vsock");
> +                return;
> +            }
> +            cpr_save_fd(proxy->id, 0, vhostfd);
>          }
>  
>          if (!qemu_set_blocking(vhostfd, false, errp)) {
> @@ -193,10 +206,12 @@ static void vhost_vsock_device_unrealize(DeviceState *dev)
>  {
>      VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(dev);
>      VirtIODevice *vdev = VIRTIO_DEVICE(dev);
> +    DeviceState *proxy = qdev_get_parent_bus(dev)->parent;
>  
>      /* This will stop vhost backend if appropriate. */
>      vhost_vsock_set_status(vdev, 0);
>  
> +    cpr_delete_fd(proxy->id, 0);
>      vhost_dev_cleanup(&vvc->vhost_dev);
>      vhost_vsock_common_unrealize(vdev);
>  }


