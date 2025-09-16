Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82B8FCAC599
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 11:40:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyU2I-0007Bi-Vc; Tue, 16 Sep 2025 07:39:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kiszka@siemens.com>)
 id 1uyU2A-0007B4-HX; Tue, 16 Sep 2025 07:39:43 -0400
Received: from mail-francecentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20a::7] helo=PA4PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kiszka@siemens.com>)
 id 1uyU21-0002x3-KY; Tue, 16 Sep 2025 07:39:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=usL/wlVVrHxb5PvjR1TyycK6F54aLt8ooS7PQAU7eDOwqcrtEhYpxZbbw0ALyqc4ez7jRfdIw9GdFN2uA9g+pL/E/Ie0V79ESv1jhzTtl35u6V3cBsDyahBD0MBbTxhRCb4mQs1Kmd1syMQoa8tqw65c5pSXzlQFkI8nUqsI7A6jL0ZjSj08UXFQMsIe8PcntPX2fM8rKAsq2wmW3zFah2P/SH8TJW8cQQKP7sNdrj+yRMBaoxNT4mr4WW9HX1oHrtgrwu33bP3KBC8LRDFmQ9XpKI4wG9wxdU1MJlALGZnWWII4/BG1WXuo2epQyGCQop4cFqj2bgCdYcx7cqVdXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qMZHPlV1R+r/fHN9wGIub+bJfd3A9JGzox2QjC9Bh0k=;
 b=JKmRAk8hnV+Qh4ozCVDLMggInkB3+cUJj43i736J7AUAyWuvfcsFn4V1SdHpnRKR13vVLoTxSO/7gpPPBVEVkShpduS7nqq7gwuXEiNBppyKOokWHpkvG6FPWv4237F4tsSdh2lSQE36hBQNhSv9w7l40X16UmUnyEa4haXGOn4VgQBzkBM6m+/6aXoeYQsIJy+g7I5jIEJ2op/+Glt0Gh9h1b3p0iwps0tMVwL0mlUqY4fH33GJeOjTGi1M36W/6qo8bKILOPPJYK9JGFYAKRKo4Xh1KcRhphh/wt3NUMJmU+D8JqQEvgsauwT5dDyn2EkR9GJ5LOQhLmiNXCOaPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qMZHPlV1R+r/fHN9wGIub+bJfd3A9JGzox2QjC9Bh0k=;
 b=wuJwln+3wNpPmBNZ+OKRu0D0ljKSsFJeod7LO4sBbrJbNT3Yz30Sey9hQo0r1cpFElUOLwIFUGUaU1/hrx069wJTQmlCEaF43hN1tP3QafRcGegYIh1HsKGlbKI+X93Cv6EP78X8Z69YuodGoif+H8nctmKSTPYrm6xPWKlWpHA/OrVL+9mpqJRO6PTd/adW0rsb++SBpTsAyJwAKZEX8MR/Vw3bN+bTeJG2wjX3UKUHjr4wNfZESwzzqsRklLa3cSf+62Rdb0TcX2a79MxMKkMnZgD3ONwzq3OBhwH07LXNXk+iK1Hv17qR24Hbvhq0qevRNwdYi6npgnEZ7iLEHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by AM7PR10MB3528.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:13a::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Tue, 16 Sep
 2025 11:39:23 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286%6]) with mapi id 15.20.9115.018; Tue, 16 Sep 2025
 11:39:23 +0000
Message-ID: <c144202b-0d99-4507-8a57-35df1ece3cc0@siemens.com>
Date: Tue, 16 Sep 2025 13:39:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/6] hw/sd/sdcard: Fix size check for backing block
 image
From: Jan Kiszka <jan.kiszka@siemens.com>
To: qemu-devel <qemu-devel@nongnu.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Jan_L=C3=BCbbe?= <jlu@pengutronix.de>,
 Jerome Forissier <jerome.forissier@linaro.org>, Warner Losh
 <imp@bsdimp.com>, Joel Stanley <joel@jms.id.au>,
 Alistair Francis <alistair@alistair23.me>, Alexander Bulekov <alxndr@bu.edu>
References: <cover.1757854006.git.jan.kiszka@siemens.com>
 <48930c1092424d22dc2171140378de19e0814ef3.1757854006.git.jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <48930c1092424d22dc2171140378de19e0814ef3.1757854006.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0001.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::6) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|AM7PR10MB3528:EE_
X-MS-Office365-Filtering-Correlation-Id: f9bb8662-c070-4965-0f0d-08ddf515ae95
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S01CWmR3NDd2MkJkUFNTbmpnVm0zc2k2b3haR3NtaEhyUVVFWmFnSHp1Nnly?=
 =?utf-8?B?R05jbSt3dW5qSnA2QlpJZ3VjN2pYdGJzWkJsaXV2YmhWSm51SXZHbWFEVzhB?=
 =?utf-8?B?QUE3eFU1T1pXcHB6dEQxOCtpc1NUU05WenhZempVY1Y5dFFXQStIak1aaStn?=
 =?utf-8?B?K0R1WXNNMXJkdzV6eFRUR0NlOVFLZldQamZVM0gyS0FpcnJXRjdlQit6ZnRm?=
 =?utf-8?B?bmFhWm5MRHdzSnNuYlZoNG1jTERnNWtQUVc2QXYwWWlmNnNZaG1uTWF2RHF3?=
 =?utf-8?B?TGVMRnJKR0xaRzZUSytXRzFNTjBrdG5wN08wdktyODViRWJVZjkrM3NDQkd3?=
 =?utf-8?B?QkZzM3VmZ0pzZFVYSjFsWWhQM2ROb2h4REFER3BLQnc4U2VMQWFkUUtuT0Uy?=
 =?utf-8?B?UUdoZjZWbHpiVHVWNisxNW9jRGFnQmtlOTRIcVF3Y016OEFTa1dHMUh0NXdi?=
 =?utf-8?B?dVE5bXBVQ0hIbnJ5ZFJZTEE1V29tK2hRQ21rZGhVdDFYMEp6Qll3c2U1MlhG?=
 =?utf-8?B?TDdnQ0gzUExvcUNySnh1OEg3NkEwMkhGUCtZRWhBZmh6YldWU1pGQmtNaDlN?=
 =?utf-8?B?MGlKazlkM2o2ZWhMT0M4UXJ5WW9WcG8zenJWa1pva3c3V3ZVTGZJZ0g0Y2dn?=
 =?utf-8?B?Q1Q5MlJRRlozaFUxSExvL0Rna1FWaDhucm9zUG5wWWFDeGNQTnMyQUs5Y1FV?=
 =?utf-8?B?Ty9PNGptdzNqQnU2ZWpTU3JMUERFbHRDVUV4OXRRcTZZQ0RyemVjYTFOQjVY?=
 =?utf-8?B?dlkrblBHTU45bmlsRktycWIvWlNMNFp5U01tV09NWGp0ZDEwKzNOOEFkdzNz?=
 =?utf-8?B?QnNpZU1nc1cvbGJ2U1F4eWpCeVBuVk9EUVhkcE9uS2JaL1MvcXMrYUFLZG4x?=
 =?utf-8?B?bUtZVVlUYmFJeThqUFQ5dU4zMnBTNHJKalhoaTRPai9TWmpZS3VNL0RzekFN?=
 =?utf-8?B?N1UzWENkVUVBYkJxbG9adDZqZnM5QXNuWWVQa09PY3NUWDN1ZXZkNEpNb0Jk?=
 =?utf-8?B?cDlGbHRWVCt6RU9qRldnWHZnemQ1YVJZbEI2MUUyWlpIU2dTK1NzeWZ3M2pt?=
 =?utf-8?B?d1ZSWmR3ZG41SGNaek9qYWo3NkNqZ3AveTFGcU5OdS95cThOdXF2bDRmWUVu?=
 =?utf-8?B?aUZMbXJBWHlCTzZlZ082VFNRWWp5K3RiZ01SaUJJSTArVURzQW9oNDdmSlJS?=
 =?utf-8?B?dmlIclZ4a0UwY0ovL2J0dEEwbHMvVDlIcGY3QVRsUTJuWnhDYTF2NGo1QitX?=
 =?utf-8?B?U2R4QlNqd1E1Q045eTRDMG1yaXU2UkdnRFRydW5YdFFiN3BNTWF4WFQvSjFs?=
 =?utf-8?B?c3JNNUxFSUE3bnhXampsLzRsQ0djWWtwakVkUHBNM0JjOHo3U1BXclRaaXJt?=
 =?utf-8?B?NkhFY0RJVEZ6aUFMbyt2czVBajI5Qi9Td2NITzJvRERYWFVLYzJlQ2NqL3VP?=
 =?utf-8?B?Nm1XZjlVcjJZeGlCeXMrblVpMEhrWGdyWHJzMHBTMFRYbFMrWFhqMVNqd3Jt?=
 =?utf-8?B?L3lrSGJORUJhZ0pkVGFhaXV5Q0kxWnhqa2hTcUN3UHVIdzIwVlBSa1FKM3lq?=
 =?utf-8?B?TldtQUJWNElvSXl1VkFkYzYwN1VuaEtueTVrZFZxK0k3d091UG1PY093VTF3?=
 =?utf-8?B?enJJb0ZQc3g5aFBMSFdQQXNEZXg0ZVU5UmFTTHNZb09CYUJ1cGFUQWtMcTcy?=
 =?utf-8?B?b1Y2UTBJejQ1UFRrQVRWK1lMdEMwM3R2dHJCZlBhLzNuc2RQSFZycTZUMytn?=
 =?utf-8?B?ZUd1NFpkM1U4SGdpS1Yrb1R2c3hTVUNNV0RuU3Z4REoxK0sraisyenNSV01C?=
 =?utf-8?B?NUUza2xxNi9WdFhXWUNKOFQ3Z3VreUk5RVNYMzlBV2d6MStzbDhJY0M0cWFU?=
 =?utf-8?B?MGl0OFZ1L0NmbjUyeDFDdmJFQ0Z0ZHZiYkdMcno5Slk4bXoyUVYyaDFMU1dD?=
 =?utf-8?Q?UZMIctMQcAI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWxlYStLMGF6OGgwRzVIY29ESDAraDFLVzVpdWVwZGhycmVPSit0UDVDOHpT?=
 =?utf-8?B?UjFKSklTdy9oOGdxQnZ6aVQ5VU1uRXJkVzkydFFFdmNmcFZtM3lVNlVYbzlO?=
 =?utf-8?B?UXhnOEV1U2FKaUMxN2JoUThWTjJxQ1FzOTNnUW5YRnRGMUtTZ21OanlrUkw2?=
 =?utf-8?B?alc5MlMvRkZBZ0VpbGVNY2c4NEZxdGxYWjRFMVFwUi8yVHk3MDdCUENtSnpq?=
 =?utf-8?B?bmdkL2hSTytGOXMxeTlVTGx1aUdhQ1lHMzJEenRPbnUzQ3l3OHFLZlRjVTdz?=
 =?utf-8?B?a3JpckMxeFNlTzlYeGdWY0RmRmdaZWpSL3V0Tnd3K1dETUZoTjlQU201SGFU?=
 =?utf-8?B?Tmt1SnFJL1lCSVRpaWt6SllKRmNwTi9ZUzU3ODVwUkhHWS9PdDY0Z09SbitS?=
 =?utf-8?B?R3dJNW1HMW5qd25QUFFzcDZVVFdiOWUzalozMWZCNW5ZUE41ODkxN1lIV3o3?=
 =?utf-8?B?dk5XUXVuU21Ud1dqSEZDR2hab0FKb0tuUXVUMGwrN3BnazFZZlI3MXdQVDM3?=
 =?utf-8?B?WHBNNUFYTVpVaXY2azRrUXFPSk1YV01hRzhMU3R6Z3Avbmd0WUNJK3pNS0lm?=
 =?utf-8?B?dlQwNDltREJTSW9pdGI5NVlyQjNVVDFtbXVVcTViUXhPbjlYK256d1B5N2lh?=
 =?utf-8?B?bUdwSmVFbzVhNzhnTlJFWWJCbks1OUlVU2pJbmpEdVpkVHRyc1pLbWlLMEpI?=
 =?utf-8?B?a0UvL09Ub05JTWI0TmxCZWpFYThERGovTGFSTnpaejE1cm1UYU1MZXpKa2Nw?=
 =?utf-8?B?ZDk3dHc0UENsQlYrSnIvdWlwWFgxNlR3bW5FdysvZTlOanpSS2ZkT0RmYU44?=
 =?utf-8?B?ZVN6eVdyMGRRK05kV2FiYkZEMUU0cUZvaVJCb1ZZTmlrZTRWbXQ2WXoyd1Yy?=
 =?utf-8?B?ekNSTVdBVDhrb2UyNlZ1cnRuc3A1MCtvVlZiUjh0dVNmalRGVjNUdE8veHpk?=
 =?utf-8?B?REV2OW45YnhURC9ncDYyNlhKZUsrTjgwa2RXcmpoRlNwMUFIUWlZK1E3MGt1?=
 =?utf-8?B?eXd4QktKUW0zcU85T0czbkFTVE9GSEM1Wm9qWDZDaGk1a3cyOVA2Nk1kamNJ?=
 =?utf-8?B?d3dxRXBralNJTGVaUWM4cFNDT3VEOStnUHdMTVdkN2NOVDV1VUJDeER1YjlE?=
 =?utf-8?B?S0RrWEllRG9JUnNXOGNZdk92U2Ztc1I1WlptY3p3dnpTZUVJLzdHTDRLSW1w?=
 =?utf-8?B?M3k1SmdiWWhDR3BTZWowaHluc2dxTm1EcjhSMzRwbWlQaWdLc3NuWUFhVSth?=
 =?utf-8?B?a2oxUUZaQStiN280Rnp0TFFURzZLTUhYWkV4S21keGd1RVp4YUh4ZlZpQlBW?=
 =?utf-8?B?UWJWSGpGY0FxT09HMkdTOU9FUld5Tk9ib1JQdkNZTmlLQ1FvbzBsUk5iY1Vh?=
 =?utf-8?B?VG1UOGdUd3F4WFZYSEZOcDA0MFlYNHRldjdxZWZxeTA2TGY3czJBWTFjT1BI?=
 =?utf-8?B?dzNFRndzcmFaSHZkUUhBbGtrelAvRkp5NmRuMmdDdkdtK0VFcWFPV29yblFW?=
 =?utf-8?B?R3BPQUFjSXhISVF4RmtISVpXbnp3anVwdXQvd1ZyWERZbjcwZHI2Q0p3cmdq?=
 =?utf-8?B?K2FjSnJyNUJFSjgvWGdrczNhUjNTenpydXFhNmJlbzZ6anRBUkJEL0tHRGk1?=
 =?utf-8?B?aFVHYUVTKzdicTBVc1BEU3V3cWJqVWdvSmEvWlJsRGd5Vm11VDRJQjJNL0Vt?=
 =?utf-8?B?MXNaZXQ3Rk15dkRHVnVEbndvQlE5NGszN29YSFlrZXBxWDRBcm9GUzhDOFYv?=
 =?utf-8?B?TE1aSmhaQ01WcTJOZlJUYkNEQ2V4MXE2SjR2djI3MVRrTEVJRmFmdDNjYWZB?=
 =?utf-8?B?Z2llMnZJSWY3c2xheGxqQkNkUDE2WkF3dUQ5clV6TkNhVVhhUXhHYlFnRjhR?=
 =?utf-8?B?QjZJZzZWUGgxUDVPdFVqYmtDZkVoclVJTFhoQmVEYTZqdlBYNWtnMWJ5S21t?=
 =?utf-8?B?TVBYb0t3cktCbTVqK2NYaSs2eGZqcXVKVzFsbnRYZXl3VFdoVVJnYnRMYVVD?=
 =?utf-8?B?dnBKSUhMOTJOc3IvUTFHS1E1dU0vUXlpVy9OakxSWFJ2TzcxMnRjQ2wzMG9K?=
 =?utf-8?B?SnZQbUw2WFR3RlZwK25TWlNEQ0VEUDBhS1FyUndJbUw4c1lITWw1REpjanlE?=
 =?utf-8?B?QVdzRkRwSXhoTi9CeWxBdHVHeWlRTE0xNW5VVXRXMm9zVlFxbm5vQVB1VnZh?=
 =?utf-8?B?REE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9bb8662-c070-4965-0f0d-08ddf515ae95
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 11:39:23.1445 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SHuXB+drEO5zyfbyJnzt/NiaaaeneCTxTYVfwKbNth0lM8zkqHZMkfpZ/9TYaMN3XgI5w99yjaiJ3+z4RkLvqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3528
Received-SPF: pass client-ip=2a01:111:f403:c20a::7;
 envelope-from=jan.kiszka@siemens.com;
 helo=PA4PR04CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

On 14.09.25 14:46, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Alignment rules apply the the individual partitions (user, boot, later
> on also RPMB) and depend both on the size of the image and the type of
> the device. Up to and including 2GB, the power-of-2 rule applies to the
> user data area. For larger images, multiples of 512 sectors must be used
> for eMMC and multiples of 512K for SD-cards. Fix the check accordingly
> and also detect if the image is too small to even hold the boot
> partitions.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> Reviewed-by: Warner Losh <imp@bsdimp.com>
> ---
> CC: Warner Losh <imp@bsdimp.com>
> CC: Cédric Le Goater <clg@kaod.org>
> CC: Joel Stanley <joel@jms.id.au>
> CC: Alistair Francis <alistair@alistair23.me>
> CC: Alexander Bulekov <alxndr@bu.edu>
> ---
>  hw/sd/sd.c | 61 +++++++++++++++++++++++++++++++++++++-----------------
>  1 file changed, 42 insertions(+), 19 deletions(-)
> 
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index d7a496d77c..b42cd01d1f 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -2759,6 +2759,28 @@ static void sd_instance_finalize(Object *obj)
>      timer_free(sd->ocr_power_timer);
>  }
>  
> +static void sd_blk_size_error(SDState *sd, int64_t blk_size,
> +                              int64_t blk_size_aligned, const char *rule,
> +                              Error **errp)
> +{
> +    const char *dev_type = sd_is_emmc(sd) ? "eMMC" : "SD card";
> +    char *blk_size_str;
> +
> +    blk_size_str = size_to_str(blk_size);
> +    error_setg(errp, "Invalid %s size: %s", dev_type, blk_size_str);
> +    g_free(blk_size_str);
> +
> +    blk_size_str = size_to_str(blk_size_aligned);
> +    error_append_hint(errp,
> +                      "%s size has to be %s, e.g. %s.\n"
> +                      "You can resize disk images with"
> +                      " 'qemu-img resize <imagefile> <new-size>'\n"
> +                      "(note that this will lose data if you make the"
> +                      " image smaller than it currently is).\n",
> +                      dev_type, rule, blk_size_str);
> +    g_free(blk_size_str);
> +}
> +
>  static void sd_realize(DeviceState *dev, Error **errp)
>  {
>      SDState *sd = SDMMC_COMMON(dev);
> @@ -2781,25 +2803,26 @@ static void sd_realize(DeviceState *dev, Error **errp)
>              return;
>          }
>  
> -        blk_size = blk_getlength(sd->blk);
> -        if (blk_size > 0 && !is_power_of_2(blk_size)) {
> -            int64_t blk_size_aligned = pow2ceil(blk_size);
> -            char *blk_size_str;
> -
> -            blk_size_str = size_to_str(blk_size);
> -            error_setg(errp, "Invalid SD card size: %s", blk_size_str);
> -            g_free(blk_size_str);
> -
> -            blk_size_str = size_to_str(blk_size_aligned);
> -            error_append_hint(errp,
> -                              "SD card size has to be a power of 2, e.g. %s.\n"
> -                              "You can resize disk images with"
> -                              " 'qemu-img resize <imagefile> <new-size>'\n"
> -                              "(note that this will lose data if you make the"
> -                              " image smaller than it currently is).\n",
> -                              blk_size_str);
> -            g_free(blk_size_str);
> -
> +        blk_size = blk_getlength(sd->blk) - sd->boot_part_size * 2;
> +        if (blk_size > SDSC_MAX_CAPACITY) {
> +            if (sd_is_emmc(sd) && blk_size % (1 << HWBLOCK_SHIFT) != 0) {
> +                int64_t blk_size_aligned =
> +                    ((blk_size >> HWBLOCK_SHIFT) + 1) << HWBLOCK_SHIFT;
> +                sd_blk_size_error(sd, blk_size, blk_size_aligned,
> +                                  "multiples of 512", errp);
> +                return;
> +            } else if (!sd_is_emmc(sd) && blk_size % (512 * KiB)) {
> +                int64_t blk_size_aligned = ((blk_size >> 19) + 1) << 19;
> +                sd_blk_size_error(sd, blk_size, blk_size_aligned,
> +                                  "multiples of 512K", errp);
> +                return;
> +            }
> +        } else if (blk_size > 0 && !is_power_of_2(blk_size)) {
> +            sd_blk_size_error(sd, blk_size, pow2ceil(blk_size), "a power of 2",
> +                              errp);
> +            return;
> +        } else if (blk_size < 0) {
> +            error_setg(errp, "eMMC image smaller than boot partitions");

Cedric, I just played with some ast* machines and noticed that they now
trigger that error above when no eMMC disk image is specified
("qemu-system-aarch64 -M ast2700a1-evb"). Is that a valid error, i.e. we
shouldn't have tried to boot without an eMMC at all so far, or would
this be a regression?

Jan

>              return;
>          }
>  

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

