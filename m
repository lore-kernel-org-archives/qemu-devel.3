Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD59FC021B8
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 13:30:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnHTn-0007Fz-1T; Wed, 26 Feb 2025 08:29:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tnHTj-0007FD-Iz
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 08:29:35 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tnHTg-0001qD-JU
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 08:29:35 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51QAcZY9009577;
 Wed, 26 Feb 2025 13:29:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=Ab1TEitD9mIljrG+hh53ydTrikfk/F96yDeJcuzToWo=; b=
 J4Hw4Bgs7hQ8CZcB8iq+djURgmMBYpNPBN1v9hlrXrdWjjYf+QxleQ1A6acXqm9g
 v3A3rN7IOT9Joxm542lltAbhAUf/kQ9dWRmXs3G0uV/IdRk7VpokpbaBPanpPnUc
 fTxO0NmwAhurMca5u5SUcRucIbfP3hHaEyrSNJodCvVdZcyUqNzsN9QEXshV1fuh
 r9mBsrr14uGUBzBt5TJ4HalrrBvY7Rl77Perl4zEV9dYo8J0jvFC2cMj0FSyeC0q
 MOrd2gNrxOl0xGBqNiecIwKMy8Yv9JAHajEOQxCjPaqpvv1Iu3LIu84ajS4VAPWj
 RhQk6KcESr1RXwCCW8N+Xg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 451psf12y1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Feb 2025 13:29:28 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 51QDA8n1002726; Wed, 26 Feb 2025 13:29:14 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2042.outbound.protection.outlook.com [104.47.70.42])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 44y51awcvr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Feb 2025 13:29:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xfBdX84BD+yq/zLrb51ORqLtPVHh39FwHJti81ln2pNZu0i00uAZFJkSmDJxk009Slz30WeeeGsnX2dZGGOAWcp9N6CX0Tzo844+W/G0K8YvAanDlyAJ64NTfGDCRvP3KzbxOjiYRtBT6UfWD0CwnLHhIzQkae2AY8EUIyawVm9dCjc1i+nh/tbBJNdJDleW9FkRC9ZwKWRdCf4cmUt8B7nzCk9ao9AYbR1mjeGzS/P5m4vsbDNMw2N8SNViYLzbseOlOwsYHA2aPjoAlXdmLYEdZeJmLAWwR257LCs3iY3bpF/XSIBMoZRYEl6hBFW/nNJMdTazXHn4KMa7yIMa6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ab1TEitD9mIljrG+hh53ydTrikfk/F96yDeJcuzToWo=;
 b=tZoemGVej/4pwW3zAElwFUwEm749PPsdjnna4SOpSKp6mGCYRdsFpnyGxYkSTcpRLme0XdFGnmSs7WLcue4cpuXJbIxrlkIv/UAuELjs23qvCj6AcPh5vLG2KqBgOvy8jczFz32iHY/+H2y8S86+MzFQ/j2sBJ/9jeJjDi6l1vG1jnCCWwXGJQb05l79K/TLzcacSIksXuRRXM22E5DUKSF8Y8bQFjglo07UXtkamkRA8QKyPYy2lavwoLcM+m8VgQG06Q7W1tlB4kAL7R3eN48Xf0r9+o/T/wyaeeLP+BjU/p4yCmcxB570Ncz6f0h2+IWtyY9VjFFZ/XrcjhX7Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ab1TEitD9mIljrG+hh53ydTrikfk/F96yDeJcuzToWo=;
 b=kURRbJJNeYh0g1WSmzVh0s1bCKY6vZn9nIUvXqJaNdzG/978NGlmdpk1n/rYEwYbfReh2S6m8krY4uswU/3+6FOXsUxZp9N3v4IF0+yxo2Im6Ks+rXJbiFuuHC2xc3PTYZMGYCVimiRx1fGoV6qeeKzZxiYxbujWB0W5GEtZ+EU=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by LV8PR10MB7728.namprd10.prod.outlook.com (2603:10b6:408:1e7::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Wed, 26 Feb
 2025 13:29:12 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.8466.016; Wed, 26 Feb 2025
 13:29:12 +0000
Message-ID: <fa6bd2bc-aef8-474d-b055-772ccc669b0c@oracle.com>
Date: Wed, 26 Feb 2025 08:29:08 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4] migration: ram block cpr blockers
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <1740517563-245516-1-git-send-email-steven.sistare@oracle.com>
 <28175337-552e-45c3-b6db-86c8f06fbce8@redhat.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <28175337-552e-45c3-b6db-86c8f06fbce8@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO6P123CA0009.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:338::12) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|LV8PR10MB7728:EE_
X-MS-Office365-Filtering-Correlation-Id: 7575380b-43b4-4c3c-0350-08dd56698ebe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RkJobndSVUtrNHZ3anRNOW1YZkluOU43T2NQY1F0RVNvU05BOG5yaytJcDJq?=
 =?utf-8?B?MGl4cmRiQkl1bkFtQWlFZDltTHN0OXdLR1llWmo0cFRHeGxRWnR1bmVuUE5Q?=
 =?utf-8?B?ZXRibHBBRmFxYkxZZmFXcFlHczk3Uk1zM01LUlVkSnNvOGxuY1B5cDRzdnNs?=
 =?utf-8?B?eDJJQzZlQkFKR3BiK0JkQWJRT2xpMWhMOVEyM1IzS0dISHBUNUltTm9yY0kx?=
 =?utf-8?B?eSsvUmV3a3BZRU5uRCs2TWR2SWpoZ0JIejhYMlA4TkRkc0dORnFnM2RkazZo?=
 =?utf-8?B?clB5NEJrQUgxUW9zTW9rOTdZaEc5SjdIL2d0c1RQRG90cERyOUJzZVEyajV0?=
 =?utf-8?B?ZTJ5eGtvWFozVU42Z05nRDhjS05GNXZ0OVVqM05jUXhmQjlZRWZhWXYrdDd0?=
 =?utf-8?B?Z0tUNWx6a1lLOTZvaFJYSnVOZHloUDZacE9lSnNoU3U3Tzc1WXp2ZDVLSHdE?=
 =?utf-8?B?QW5oQnVNOUpjcS80a3NVeEZhYloxTVV3L3BySkxkWUtpUFJkUDJNcUV2UWlR?=
 =?utf-8?B?N3lJTWQrdFM2dlZVNUVDa3UrSFpjYk11ZVBXd0QvTmh4YkVwMnY5S080TVNL?=
 =?utf-8?B?a2ZSaTRxUjEwcWd5Y1RmQThDbFhaN1pnNk9qdE55ZitQUzg0Mm05VG1iaDhU?=
 =?utf-8?B?UytYM2VmNnVQdnZHa3NlSThYSUhCT0JIcEtjcGhpZUo1TnlIb3F4YTNSZXFZ?=
 =?utf-8?B?ZTd1WmNxVlBWTGhCTGFscjJvVzNuTDhtRWx4bkNUM3I5T01qbGFudXFxYXBC?=
 =?utf-8?B?SmV4Yi9FK3J4UEFrM29NQWlrVlcxaDRpNml4RmZUY1NkZXJieDFaMmxXUDJS?=
 =?utf-8?B?TzgyUTZYMThSYXk3NWJ2ZURhR2w4UGRMelJMQTU2YWtjUUhaL1V3QUhTdWhi?=
 =?utf-8?B?SE8xeCtjQ2NLWUJYRzdVdUpPL2lmSDNqS3hYTzlCVW9vNDk5L1lhVWZETCts?=
 =?utf-8?B?QWs3TWllemtCVk9qSTJkZHJJOUpEenlGVU1ZaVJZYTFBbzQ4cjhRLy82dWZq?=
 =?utf-8?B?OWt6Um1WWC9XQWdySmJoNGowaFBWdERUMzRCNjlMYmVycGhURG13NFh4UHBD?=
 =?utf-8?B?VWNIUGNlUlZEWCtYellTZVRHYnhLKzBwVnIzb1F4MW9LZ2w4K0c4cGRmSFhQ?=
 =?utf-8?B?azdTdDZURENJUm1YNGljakFWMEJYdi8reTF3bkw4eGNWTUlUUUhvWUYra1BB?=
 =?utf-8?B?N0d5Qll3Vk9SaW9Ua1orOGxNdWdFdmRRNjdab2p0cEkrcnJmTzRZTU5tWHpO?=
 =?utf-8?B?RFFjQzhBd3l0a0xsbHBybTFCTWluNUFyUkVvT1Y0SW95T0pUTGFvNml2ZzVP?=
 =?utf-8?B?ZTFFbVZOQjBnL1BoSVl5cHNLdFJER0ZIcEh4UFN4c2tMTThpeDVmczVjeXoz?=
 =?utf-8?B?T29vUmJna0IvdkVJbUwwaStjUnpPLzFqNm1VQmpnclJNYmFRTXlnbHRGR1N6?=
 =?utf-8?B?elUzUkttMG5TVnQ5WUgyd1k5YXBaSG4yd2lIem1hbFJMLzkzdmhuR3h3cldh?=
 =?utf-8?B?NWo2ME9HeEdFTUZuUTdTd0VmYWtaRXZwVUdoK1ArbFV0ZU9nTlJTTHZ3WE1B?=
 =?utf-8?B?Z0d6TDUyMFluKzc5ekJBaHhtcHlQRUNDcVRNc1FLMkMzd0YyZGgyTzNORkcy?=
 =?utf-8?B?QmNFc3FOUkhlWXNYbm1HeFNLVUFQM2hoM0wvYnhCK2N2YTZ2Q2tBYVdwRHZE?=
 =?utf-8?B?TzNiclVHV3RQY3lQTVVCbVBRK25oSjU3WEZHYlM2dkkwQ0x3QThtTFJHVDJh?=
 =?utf-8?B?QU1JdEtmdG5sRkM1a1dNSDhJbTVodm03S3lpeWNQWFBFSFh5ak9jbFBjLzJj?=
 =?utf-8?B?ekl6N0hiblExdzV6dWhLRWl0VktOclFwQm1PQ3FxaXhnQU9UM1dydDZrV1ZQ?=
 =?utf-8?Q?nAJe+XA8SNWU5?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZjhiOGpkVFdOM3BHbTZ5YThQQVB6RWdoa2hwRURQMVJ2V2NKYllOZVpZOG5Y?=
 =?utf-8?B?eGl5MmdFMGoxV094MHZUYi9nNmd6anB1ZEhDTGlNZ1Y2UU9MbXdSK1lqYkdw?=
 =?utf-8?B?eEN2TDF4TEpySDVPL1ZGa0tuZkxid2xHMFlqakZMYTB2UDYvQW55YmgyRXBr?=
 =?utf-8?B?Snk5K1dVMnNzWHU4VnRWVS9DaXJVS040cGFJb0FxV0MyQVl5cEVDVmgrYmFB?=
 =?utf-8?B?Q09aM1V5M3kzSE9OVGQrdEQyMjBSUWNIQUhlL01Tb2dYU3VDckJQMlJTZlJN?=
 =?utf-8?B?MGlPczEyQXhDSU9Sd3dhU0IrVFZsM3Y5QWg1c2ZxOFR4cXJUOFJHSzNTeFhK?=
 =?utf-8?B?MVBmWXVYL0JyNFE4K2hxRU9BbDhOUVdtT0tOY2NCS1lkcmQ2TjljV2tzaXRq?=
 =?utf-8?B?MGhmZjBvejJicjA5RTh5Z2szK1ZiMlBLVHYrbE55anBGV214SnVoaTlqMjl0?=
 =?utf-8?B?VGR0SVc3RmxMa1BldVNqWnVwRUJHMHZGRTdwTW5iNUNEc1ZJREFNVGJUTkxR?=
 =?utf-8?B?QWw4TFYyZVVoOGxqZllUR2ZwVERWVVloeFVQZkhmR2hQWVN5UTJ2dFp2TDNJ?=
 =?utf-8?B?c2lxdEcyS01CWjBBME5GdjFYdXhmUSttMUNJYlFkaExQZEhpRDlaNFF6ZmZm?=
 =?utf-8?B?cVpCNkpGdnNpa1dFS2NnZU9GT1R5bEs2L0NNOVBrRnQvUyt6MHhWQjZVU0x4?=
 =?utf-8?B?YUxldmdWL2RGUmt0YXpxbk9pcy8rVGRSU29uMnFIaDVxdE03TDJwWFdWb1F1?=
 =?utf-8?B?eWZ1cVJWQXNIZ0JheHdoT2xVMkxId25XTFZ2Um1OVFR2SlFSbDdTdU1WZXVL?=
 =?utf-8?B?RTdLYytFdS9sN3YveVc3TURpVjBrZWJlMUxLZU9hODBiaDJHdGhtdWZDaVJn?=
 =?utf-8?B?ZHI1em11TTh2dElGVFg3bWkxVVZodVFscEh3czFscmF5SFh2bFNqTTBlMXhZ?=
 =?utf-8?B?T3JIL2s0R2d0VHkrb0tNb3RBejJDZlNRWmhlcWdCSG1GN09uSlBwOGJxMXov?=
 =?utf-8?B?dy9TTE93WWtld3Qvek9ueExoRUttaS9sZjlyaytFZlpORFdJT056NzkvbW5J?=
 =?utf-8?B?bjl3RmdyMVZBemRwRnFkei9JV3owY3M1TjJMc0FqS3BLU1lDVCtQVVg4aGEz?=
 =?utf-8?B?WEJWL05JVU9McXhzYVVBRTYrWnl4aGlzWWZkUWlkQUswZUVmWGkyak9ESVFE?=
 =?utf-8?B?Nk9Jd0tzSnVXaWJUTDlDS2VNenR3MFpxOFJ6V1NWWGFKbmZsaFZmbVhEVWVK?=
 =?utf-8?B?WGtrODBhV1Nab3FTKzJiQ2p0RENVaE9aZFVjZm9DYVNMRno0RzlxU0NIZkx0?=
 =?utf-8?B?dkNocG5QSTczM0NFNDlHT3BTdFU0ajFEM3cveCtsd2cxMkIxMFRGeDBlb3g0?=
 =?utf-8?B?Vk1GZEwySDYrKy9RRDJ3Y04wY1FvaGtwQW1hc0laSHB6ZS9QeDJMNkNMeUI0?=
 =?utf-8?B?dmwva3IweDFpNjVUU2l1bml4SERzdllxbEx4aS9DVThqWm45bS83MGpEM1dC?=
 =?utf-8?B?b2lHUWtJK0E0OERPUm1oOG83d3AzRlBLRWVqakJTNFNiNDd5cjBKdlQ1UHlT?=
 =?utf-8?B?N1Fod3ovM0NETll6d2x4UU1VaXhIQThOUlEwRE9tNkNsYmthRzgyL0pmd0lT?=
 =?utf-8?B?U2pLaEJ3eEt4RXgvOUlpKzBiSUNnb2pkeERPM0tDaFRHMHBleUR3RnhPTTU1?=
 =?utf-8?B?Tldlak5wYjRMNHRwZDA3QXM4YlBpeFkvNlJBdzFSNXlkUmRSL0ZQWHJlUlc5?=
 =?utf-8?B?MXFaUHVCWDl1YVkrbmk1cFRkMjhPay9DcU1yMExpQnhXY2V4amdtbDlqRC9q?=
 =?utf-8?B?RURvR2p4d3F3dGY1eU5vMU5zM3daNVc3R3RtNjU0dEhaYVFCejhPZGNsSERm?=
 =?utf-8?B?OEoyVzFrZmh4bnE1cXJwZEdFcTBwaDZZbHcrZVMrUWJSWVB3dDVvdFE2YnJj?=
 =?utf-8?B?Uko1WTFhaU1vODRYQzM0MnFqemRYNmNYUzlKVUdIU0pvSHlEVGtTVGtsQXBQ?=
 =?utf-8?B?MkdEaHdvWUZ1a2x0NTVUd2NOQTIyRlg2WHk1SkF1TFBHTi9selNlQWhOQld1?=
 =?utf-8?B?V1FWc1k4Tm5WemdLNkVORmt6Yk1CcThvbk52OGtqdGVReDQ4TDhWT3RwOXB2?=
 =?utf-8?B?QWVuNzBQaUxHYlF2YmtVRUhOQWhaMU1hR0hMNzJOaGNnU2xWdi9UZlZBcDk5?=
 =?utf-8?B?K2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: sLYsOV/H88lciAULRZ9CwIEpc9VkDyLsqHJ1py3NnatVbAUmLHLeeyaTrW6b7NM0h47DQXKlo2DCMDpI0xMgd0pNGNlIC+t+SniZcA6V/g5+VmDzoMNjvXBcX5dueFheHGThY17qUG/0JcPVyi/2gDh7PyU/KdPRsEsCXkw9QLSRfOwQZqQn9EBWG2cKFqQsB4XkJjoQLQPFr0IaFOMjcmBXVUqwTKEKvNODZebugy9JJIf2W8/4nGwpYG33zogvdOhHZGU0yQIu/C3bOGmFnDtFV1UEA++7uiWABTO7wXZVwzPo3zST7Z6D61hCtWofc+jClHvKsgwUB4GV6UXfNBZN7n5I9XBabYzvRKiwtCFmUcN75Oxi4QcZDu4Uzk/Z2a+gUsekqPqpb/x7Tmj31BDUcDYh3RszeRB8s3uEFPuKvepLuiWBOB/Ix/UBPZKQD0EDreJQHQNOZESGm5AV/zBtXQIDYmIRSvuZpp4mf2fR5tWtILU2pScgtR2U6GehPO3kSrZQ+qJenaJcuqrCGgFq3JCAru7jP6MZkzA2EmpBT/UHTjiWbsSjhD/zPR0FSN+Z+tZfb9Qnz9Zo6iQddd/QO7oL+/xII1gOfdSw3H8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7575380b-43b4-4c3c-0350-08dd56698ebe
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 13:29:12.5155 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1rNOzOWwNSbjo7rX8vb+oNR1DWPfpSYNBX2xh/MpHyezol7+lOdvTuWrzYrL3dw49AeePsdeRHGh0WwJXRON+hCw8BJPbgbKpDjr5sE5VKI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7728
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-26_03,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 mlxscore=0 adultscore=0 bulkscore=0 phishscore=0 spamscore=0
 mlxlogscore=828 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502260108
X-Proofpoint-ORIG-GUID: YdwQtaVVFkXlTh28zJUrRoSWak6tMnLq
X-Proofpoint-GUID: YdwQtaVVFkXlTh28zJUrRoSWak6tMnLq
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
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

On 2/25/2025 4:10 PM, David Hildenbrand wrote:
>> +    /* Ram device is remapped in new QEMU */
>> +    if (memory_region_is_ram_device(mr)) {
>> +        return true;
>> +    }
>> +
>> +    /* Named files are remapped in new QEMU, same contents if shared (no COW) */
>> +    if (qemu_ram_is_shared(rb) && qemu_ram_is_named_file(rb)) {
>> +        return true;
>> +    }
>> +
>> +    /* A file descriptor is remapped in new QEMU */
>> +    if (rb->fd >= 0 && qemu_ram_is_shared(rb)) {
>> +        return true;
>> +    }
> 
> 
> Sorry, I was not fast enough to reply to your v3 reply.
> 
> This is now essentially:
> 
> if (qemu_ram_is_shared(rb) &&
>      (qemu_ram_is_named_file(rb) || rb->fd >= 0)) {
>      return true;
> }
> 
> But what is the purpose of the "name file" check then, if rb->fd essentially allows for any files?
> 
> So either the "fd >= 0" check is insufficient or the qemu_ram_is_named_file() check us superfluous.

Yup, qemu_ram_is_named_file always has an fd at this point, so that check is gratuitous.
The preservation mechanism is different, which is why I thought of it as a different
case, but that is just a commenting issue.

V5 will be:

static bool ram_is_cpr_compatible(RAMBlock *rb)
{
     MemoryRegion *mr = rb->mr;

     if (!mr || !memory_region_is_ram(mr)) {
         return true;
     }

     /* Ram device is remapped in new QEMU */
     if (memory_region_is_ram_device(mr)) {
         return true;
     }

     /*
      * A file descriptor is passed to new QEMU and remapped, or its backing
      * file is reopened and mapped.  It must be shared to avoid COW.
      */
     if (rb->fd >= 0 && qemu_ram_is_shared(rb)) {
         return true;
     }

     return false;
}

- Steve


