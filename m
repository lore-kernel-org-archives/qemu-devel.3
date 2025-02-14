Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0065C021A6
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2025 01:37:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tj758-0004LZ-5T; Fri, 14 Feb 2025 20:34:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tj3US-00011m-Rb
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 16:44:53 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tj3UQ-00024H-HU
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 16:44:52 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51ELChji021334;
 Fri, 14 Feb 2025 21:44:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=MOlvJFvoVlYT/LX8+rYYbJQa4+igTxDXOuXuSStkptM=; b=
 CedcK1JFjf0snRLNEzMPvO2k8AyAi+KACKjaIGBbhP8ZVWKz2Saoq3Xv4WbBjsZ9
 BUUgqHmzNRWwdiY2JSupAaL7YJyJA4Hx2glOMTtlkwjYvcMtjoMDSWzJIzuHKajp
 htvhkkqBPGnrN9TqOYaL2fLlc8DV85PJGqo+ayPQxEDOG9OFki1aJKQuLqe/7+yI
 WPf4bha3+njMZLHqttak4tR4TpI2Vm3MMi2mXBow3CCNt4oMQfxuYTAqbFRXpf2q
 qN9ZiuYdh3ibRgV6SE9NtC91OKx1018DGSgpG3nBKIMq2G32vw0xj7/+/YkoV1RE
 CVmBfuHXxUFDXlPCsUGt4Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0qyvnbm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Feb 2025 21:44:47 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 51ELOSQU006667; Fri, 14 Feb 2025 21:44:44 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2045.outbound.protection.outlook.com [104.47.70.45])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 44nwqdp1vx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Feb 2025 21:44:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iQHjlvcBewykgTX19kjPmyhlHRaN2kmZyv7zATxiIMxm/ZwiMSP8enfNqCi1oDCAeUflEINFGxl3xSA5z7ohqGw0SNkpRaCb/KVdl5rO9p5dI4SZqqxSp3icxlCumq0WvlodMPsZlhnb9hY8B6q2Lq/4pL7XUL54p6QUEFp+Wfr/ow8ruQQMHzhDcREtsRm9h26oRHXujM6+vqyrh/x834r0YZBIfdsHhfYm3IX30Ao9W3VqJzempXlawXpnf48PfGRpgWnZ/G0jp4NRbwoUkjGy5xSGJ2vkTdgsBmej0ox4Ybu6buVKWFdEXU3EUS0j6ASxVNdXT8TWdvZEUBastQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MOlvJFvoVlYT/LX8+rYYbJQa4+igTxDXOuXuSStkptM=;
 b=hyB1wvuEe2LO4YFYKYxfU92Ci6Ko2hH2Me/lBnxQ2uVJ6+HTOHTZblwqKejjQ0UVaxbetM3pmDK+V8kNZhJMs8RuTXb7JskBYexCIJpfSUlqDJqozeQlDdcxow7OOvbMxp2iB5XoEcOm12nbASHVsmVvS0Hgt6fNmTK9sJaqdNRAkbyv+A6E47GQ9HH6BEIqVV4M9BgQOV37iIq8CsQn6Sg0lwCTXoPyzXtvIOo3L6zMrq6qQJYzv4yNfKN0WyYK3ECQmd8GpRxNdLoxHtpnfEypQrQlk9p+KiV2bvaj98CemczrjtrovecDutWtzL7FcHfc/pGNIjNcgGakbVUFRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MOlvJFvoVlYT/LX8+rYYbJQa4+igTxDXOuXuSStkptM=;
 b=QXKbRNv+f59Lb+nAKy3o8dQi+oQXgV9FH8Gnx8HL1gm9Jd/xjU0sloMqYAyhEOo6hKG0KlHPlbNJrz4Uw9SX4RiMTQ1G7yBdvx/ZFo9kG5sDR1onC+zfarnxLe8678VHA5a3oD8lKmDF38opqh0kiyxmbuF4xc0vYtYbwJLSV1A=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by DS7PR10MB7178.namprd10.prod.outlook.com (2603:10b6:8:e1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.14; Fri, 14 Feb
 2025 21:44:41 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.8445.008; Fri, 14 Feb 2025
 21:44:41 +0000
Message-ID: <49c83982-46bf-4ab3-a683-776d4c342b27@oracle.com>
Date: Fri, 14 Feb 2025 16:44:40 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] migration: ram block cpr blockers
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <1739563953-227207-1-git-send-email-steven.sistare@oracle.com>
 <7e781592-ea91-4a3a-9855-8e5479e0b61e@redhat.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <7e781592-ea91-4a3a-9855-8e5479e0b61e@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR18CA0008.namprd18.prod.outlook.com
 (2603:10b6:208:23c::13) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|DS7PR10MB7178:EE_
X-MS-Office365-Filtering-Correlation-Id: b23be48d-380a-4eb0-c767-08dd4d40c9ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?anJrcTQ5MHBNRHhnTWVnRnBWbmNFYXZlZHVqVDB5V2E0SHNGWDJ3ajhSRGtM?=
 =?utf-8?B?SlFRUnRDdnJHQ3lKQ0k5MU9WVlEzYzFOYnRNRExITlBjQmVMaUtCM3FOKzRv?=
 =?utf-8?B?SkZwMm1rUlFDeDh1ZDlRSis2bGtpUnZqakpobkxNNFhIbyt1bmlkR0VFNzlw?=
 =?utf-8?B?N2ZzRG0rdzdVNGZ5M0VJYkhRbEsvMXhrNWRJc1lib3AreENLSW1BL2czaFg0?=
 =?utf-8?B?ZURsRXFYNUVSTkNZRFZIRHBOVy9nTlVLMitOTW9yUEJ3dGJ3SWxFcG1IVm9x?=
 =?utf-8?B?am9CczUvcjBhZXMzK2drVEU0YmsxQTJKODVWWGFvdCtRNXRoU2NBblh2MlZY?=
 =?utf-8?B?eXhIVFAwdmVkKytjcHdiV2FOU3I5azkvVEw2MXMrTVZORXZ4MEJpTFlXdXhF?=
 =?utf-8?B?QXVudzZqeWZhQXZxbFM3VHB5YkY0RTJLUTVvYkZQNlR2VEJEZGtYM2pIdk1x?=
 =?utf-8?B?UjFkVlg5cDYzMHlnQmNMRVhqclp3OUJGZDhkS3NWYmtRQzliZHZqK3ZGS0N4?=
 =?utf-8?B?cC8rTFpKQTNyTmh4VFc4OVpGREdSeFM4R01xQUlWUnNqZmpsaDRVYjJ6S0pz?=
 =?utf-8?B?QVMzT2ZZVDQ5cHBqRFdEejF1RUtyMW5MUzNXUnFFWTZEd2tMWWsxeWRIVHlL?=
 =?utf-8?B?SFVjV2NsQjkrSnJqQTBubStBeEZsc1FCUStNYk1KN3NNNm1sd2xqdWY4TXZO?=
 =?utf-8?B?VHV3TS9iOHFRbitmcFZQajRra1hoWW8vTUdmVkZBd1J2dFZkU205NzQrN0dP?=
 =?utf-8?B?a3hsT240alNUUWF3dWVhZFlXemtTbWZUUnZrOVYxaDcvSU5PeEFuVzAzaHIw?=
 =?utf-8?B?OUkzNG9uVXB0VzE3cXEzQ2VKN3I3SVhZb3hPYUMxMjNDM0o4dlp1L2tHRjBs?=
 =?utf-8?B?a2Y0UjEyN2R6a09LcXN6RzlQOGpjV2V1a2pDcWlyTlQ3WFdGQjNHd1JTNita?=
 =?utf-8?B?YVAwOVhKQ0lZN1BHWjk0a1oxbVYxQ2ErWlJpTVdqKzVYRmttWmh3bnpJWVZj?=
 =?utf-8?B?a0hHZ2pkK0ZhS2NPUk5OSWo2Y3pKTDVpZFd2QUkxZXMrTGQrTlhuMnUyYS9T?=
 =?utf-8?B?SER1Q2ZubUc5aFFQVXZBUDFaaWF1TXRLMWdzSy9ha0dBMWJIcWxOWmtNbjdS?=
 =?utf-8?B?bVUrODhTMzA5STI0M0htTzNLMUNtSU1zaU5YMVZjTDBKTXErWGNPNkNNdDJp?=
 =?utf-8?B?Nm9CWHIrcnNrYjEyeTBLU2Z4RTc3Q1lZd05XS3JWcjJPQlV4VzVYaWJDSDVy?=
 =?utf-8?B?d0xxY2tMTysvdDF4N1ZTeStjU3lDaG4zaWFmVEt0UDNGOG9jQzU2U2U1Nk5w?=
 =?utf-8?B?SkN2QlpuekhYVVc4UEF3UFZZV29YRnBHaEdydkp0MVpMd3FpRVpjWThxQVVG?=
 =?utf-8?B?QzVONWc3clRUdktkcVlsRHVPYUd5NVJLWTVLL2xUT2RjSjFxdFBZTGxaZXZn?=
 =?utf-8?B?RXl2cHhJQ05TYU1ndFo4US94d1l5M0lkV0w5elBCUnVxUUI5em9qV3NaV0pC?=
 =?utf-8?B?dnhlUGRHQi9ISEdLaHBvT3BoYXpKa1ZBUVdmbXlQcUJIU3AzQk5zU0p5Ykg5?=
 =?utf-8?B?Q0lzMG9VZEl1TFgybW5hRGpPanRLM3c0MDhXQ291cG90aDEvWWltN29LM2xz?=
 =?utf-8?B?SG5DS2lVbVlxL2dLSWc5R0hZRHpRaEJ0cUFIZzdQQXpoTmFrYnp3bUNxN3ZR?=
 =?utf-8?B?L2t6em94K0tWQm0xSFRUWnBNVndyQnJiY2dBNllKcUU5K09oQlJCenBpYkxy?=
 =?utf-8?B?LzRYam9QODQwZ1V2ckxYK21FcHdVaGs1Vi9BRDE1NWg1ODExK3BhTkNvamZI?=
 =?utf-8?B?KzU0UEJzM0YwemYyMFIxV0h0VWdDR0ZicDk5QTRvUmRDeVpORDVOUk56MUhs?=
 =?utf-8?Q?Plf3g2iu3Z6u4?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVUyTmowVmVlMGY0ejZKUXVseXhyTFhSbUxPdXFTYlZMZUVpZnJ0NWROdWtw?=
 =?utf-8?B?TnhyM0F6S0lhRHRTTTF6OTlyaTRuV0F3WWkzQjg0ZFV4aUE1ZHE3K1ZFUjda?=
 =?utf-8?B?aVp2aisxOG10ZjVzcTJSTU92d1VVU1EzV0ZIK0ExSUwyVkpYb3VUdm5XNExx?=
 =?utf-8?B?VXhRNEthWUVlaFBtNUZOVjJQRGJyYmMxWjZJa3FwWkNtVnJIRE9uNDJFcnZJ?=
 =?utf-8?B?eWNTa0hHUW9Sc1pqdmRlak9lWCtZcFZZZEZEdnA3K2IyMzFQYU9FTXMxYWtV?=
 =?utf-8?B?V1JGT0ozWDhVc3IzUkJvaVYxeWhQb0Q4LzZkYVdFdTc5NDZkREUwdjd5MDht?=
 =?utf-8?B?c3lMYVU5UkdMdW02anRNV0RrY3h5dVc2OWJ2ZjhkbFFiK2I0VGZRTTJpZDVS?=
 =?utf-8?B?MlFmY25RbEFVLzUrbS9LM2ZFMXFhMFlQaVhYTit1V3M0MGprSUpCNWNZaFoy?=
 =?utf-8?B?a2lVdHkzZGJ6QzdwUks0aU5BbHlKTzEzcEU1ZEpuUVdhWkxHQlJTcjM0YnZF?=
 =?utf-8?B?eW1jNDJDVG55eGREZ21MNU85bjJ1bDVFbGdxL0RlYWd4YmhnTlNDaVZhOFNQ?=
 =?utf-8?B?LzhHSzhUM1RGUDRscTRWZVgxVzN5ellIcDJqZVRCb2k4MDYyWkg5WENxZVRN?=
 =?utf-8?B?SFkzcVRyM3I4L0dydmdxMGtlZGx5bks0TjMzbUlmTVpGNWgrdDVWaGxTTFMr?=
 =?utf-8?B?Z3JyQWh1T3pxdzBzeUx4MEdaVXRUTEdJRytSN012bTdHbm1rNjg4elduSFpi?=
 =?utf-8?B?K1ZCNzVRQzEyTi81VjhaZkxoQjlBUXg2QUV0MzFNVURoMUNIdmNHTjZNVlRj?=
 =?utf-8?B?WUhuMlRGdEd3Rmw3SzVWMHlobnJnVjV6dmhQSkNiVkZ3K0c2akV3TysvUTZS?=
 =?utf-8?B?c3ZXbGJjMUNuOUR1OHBoNnN3ekMvVG52RmJlODBwVFhndCtiQTE1QUJYR1JG?=
 =?utf-8?B?aUE2cmVuc2FmVlo5WXpmUUthaWZCd0lSZTFUWUxQZWJicTBhZG4vaXVWNmps?=
 =?utf-8?B?S3VZTWlWTyszcVJZOWk1MkJyRUxEcTQ2cFJxWmtEb05RUzkrNW5abVN2ZVBM?=
 =?utf-8?B?bHlUU0M2TFZsRFNZSjNGRnBVN1FVcWc0RW1JTmszbzFOTVphb3dOYVBCSm9w?=
 =?utf-8?B?dU9EQWtRNzREVWFjVHYvOEtMMWhwWUVtVVlTaDJJb0Fka2RSQUU1Ty81RmN1?=
 =?utf-8?B?Q05kdW51dWpxNGFMMG1pL2FGZzVlOHk0cHhIWU9lR0VUOHozamNIeGdZbE5p?=
 =?utf-8?B?cy9xYXFxdi9OZDRSL0YvU3l5TENhSy9LL3VLTUpPZWRNOGRJRmZJY3doYVN4?=
 =?utf-8?B?eENxOWRQS1NxMHIwQ3I3ejRrZTY4WVpiVDhMZENqdERDellzZW9SQlBQZVZk?=
 =?utf-8?B?STdGZit4ZGpHaHBJZjhMRkozZmF4YXlRVDlMOHNsMHRBdGtsQU9FUnVIOTdL?=
 =?utf-8?B?VEV6V1oxSU1YZzJLUG12Vk4wRWZidFNKUnFWUkZrdUREaVU2eUEwcFljcm9v?=
 =?utf-8?B?SXVUbytWQWtqY3UvSXg5S0FhcU5ITVNqVHNvQzY3Rzl2aklrbnNoTWIzMzZk?=
 =?utf-8?B?L0x5TWZ1WHlkdVA2blUxdDdLN0orVzNoSGVQUTIxeERDdk56dmY2VyttdGsw?=
 =?utf-8?B?V09ONEFBOC9YTWdxOFpWOExEa1pIbWJud2tZVGYrZncvZlc5c29JUjkxOXcz?=
 =?utf-8?B?aHoxdWN0emlOaW5LcUpYeFJzblB2SzFybTl2VnZRQXpCemw0dU9pb3FGL3k2?=
 =?utf-8?B?ZTE0aDkxVGNXR0JwT3YvWjNORHpVZTZkbmprVElWbDREdjkwNWM5OUxINjA1?=
 =?utf-8?B?ZzN2Nk1Cd0Z0eGZqMUpDOGJuVzU0eDJGZEdNaUw2MGhvY1FBQkt3eGc2RVNO?=
 =?utf-8?B?NHlMSkNLKzJEY0NlbVpJT1U0azQ5aFhaVkRvWjNKYVFFSk0vN2lnT1VYNWtD?=
 =?utf-8?B?b3lrdEZXNStBVHpMSjg0b25Pb1NLa2RFTU0vRVNQK0JBeFhnMUp5UEJqaEF5?=
 =?utf-8?B?SUlqdEkxcU5Tb09jQmtKTDRXUmw4NU1NeDBiZGtqZWlKZFVmSS9VOHBnYTYy?=
 =?utf-8?B?MUtLeThyWXlQeUNBNldabS9yamMrQ1huN2RWMjBTOTRiNnQxdDNmRy94N0lB?=
 =?utf-8?B?S1lvRzdzSUtIeEFEVFByclhBMWlWNWFidWJMK3BKS1pYVDZ4MmVJMlgra3Uw?=
 =?utf-8?B?VlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: DOn83u+iNH0o1ay23IPeRMYtCN0P5tZcHYDym3VS4M5GZF+UMyT4ZnVIs8w8zZ97r04D41j+Ed8tctisLtBSF0Xy2+QL/q46fzhRDdOKQ3HA0PGNaer/wTZ5YAUpXUFDc5eDP7K9nboztarr4BP+mfT+CqGecLfp5UNAK07Y6HMZ5rvnUBfnO2hKIoT5K7rP/700a2MygpfT9lhOaqqQHMuKsFhT8gI1tq4yeahhpXQOp+rpZH7NykTQavIMi8t8OSB5eqwQL+1RKPosLUJpK3A6jNJoiVoIBJVyR57Vq553gnfUQ7d4+JDKnc1UEbeAIZ9wcnj4cEpAMZp4gr3KZVjXQKjqku4rDOnHySUOyPxMOFT3QT//PVJRKXQebN+YH07oCGXlZ6nADA8Ys4PsefWxAhXdU7wc5IM1S4hjHwouMutP298OwHOsKek8ie+7wyNwSLsFgsAicaBAwvQsM5SivV/PASZOGqcCM/M/QcBmbsBfE8Jne8uYdqqTwRphfCx15dwC7Gg+3SQWwwj0sM8CtzNP+LwQSFaB2PdrgEQR+12Yt6revAO7o3Y6OBKRPiqsM2G7VNuuFGfeVlDRjZilfj4IQHJXCwbxGkYZQpM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b23be48d-380a-4eb0-c767-08dd4d40c9ae
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 21:44:41.4699 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +EVeGZKPMwvH7QxxzNF1dK2ZCk5jwL1XbPn8tdnIy+k2VO6k8cB088StI5qLKDD9HLuPf+AKspxViGdTXG+hJvnrCamvyY6B8xsP43xjwgw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7178
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-14_09,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 malwarescore=0
 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502140148
X-Proofpoint-ORIG-GUID: XWNSlPVo6T-whklbJqGPa0g_SUlmTeqJ
X-Proofpoint-GUID: XWNSlPVo6T-whklbJqGPa0g_SUlmTeqJ
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 2/14/2025 4:21 PM, David Hildenbrand wrote:
> On 14.02.25 21:12, Steve Sistare wrote:
>> Unlike cpr-reboot mode, cpr-transfer mode cannot save volatile ram blocks
>> in the migration stream file and recreate them later, because the physical
>> memory for the blocks is pinned and registered for vfio.  Add a blocker
>> for volatile ram blocks.
>>
>> Also add a blocker for RAM_GUEST_MEMFD.  Preserving guest_memfd may be
>> sufficient for CPR, but it has not been tested yet.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> Reviewed-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>   include/exec/memory.h   |  3 +++
>>   include/exec/ramblock.h |  1 +
>>   migration/savevm.c      |  2 ++
>>   system/physmem.c        | 68 +++++++++++++++++++++++++++++++++++++++++++++++++
>>   4 files changed, 74 insertions(+)
>>
>> diff --git a/include/exec/memory.h b/include/exec/memory.h
>> index 9f73b59..ea5d33a 100644
>> --- a/include/exec/memory.h
>> +++ b/include/exec/memory.h
>> @@ -3184,6 +3184,9 @@ bool ram_block_discard_is_disabled(void);
>>    */
>>   bool ram_block_discard_is_required(void);
>> +void ram_block_add_cpr_blocker(RAMBlock *rb, Error **errp);
>> +void ram_block_del_cpr_blocker(RAMBlock *rb);
>> +
>>   #endif
>>   #endif
>> diff --git a/include/exec/ramblock.h b/include/exec/ramblock.h
>> index 0babd10..64484cd 100644
>> --- a/include/exec/ramblock.h
>> +++ b/include/exec/ramblock.h
>> @@ -39,6 +39,7 @@ struct RAMBlock {
>>       /* RCU-enabled, writes protected by the ramlist lock */
>>       QLIST_ENTRY(RAMBlock) next;
>>       QLIST_HEAD(, RAMBlockNotifier) ramblock_notifiers;
>> +    Error *cpr_blocker;
>>       int fd;
>>       uint64_t fd_offset;
>>       int guest_memfd;
>> diff --git a/migration/savevm.c b/migration/savevm.c
>> index bc375db..85a3559 100644
>> --- a/migration/savevm.c
>> +++ b/migration/savevm.c
>> @@ -3315,12 +3315,14 @@ void vmstate_register_ram(MemoryRegion *mr, DeviceState *dev)
>>       qemu_ram_set_idstr(mr->ram_block,
>>                          memory_region_name(mr), dev);
>>       qemu_ram_set_migratable(mr->ram_block);
>> +    ram_block_add_cpr_blocker(mr->ram_block, &error_fatal);
>>   }
>>   void vmstate_unregister_ram(MemoryRegion *mr, DeviceState *dev)
>>   {
>>       qemu_ram_unset_idstr(mr->ram_block);
>>       qemu_ram_unset_migratable(mr->ram_block);
>> +    ram_block_del_cpr_blocker(mr->ram_block);
>>   }
>>   void vmstate_register_ram_global(MemoryRegion *mr)
>> diff --git a/system/physmem.c b/system/physmem.c
>> index 67c9db9..c416068 100644
>> --- a/system/physmem.c
>> +++ b/system/physmem.c
>> @@ -70,7 +70,10 @@
>>   #include "qemu/pmem.h"
>> +#include "qapi/qapi-types-migration.h"
>> +#include "migration/blocker.h"
>>   #include "migration/cpr.h"
>> +#include "migration/options.h"
>>   #include "migration/vmstate.h"
>>   #include "qemu/range.h"
>> @@ -1899,6 +1902,14 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
>>               qemu_mutex_unlock_ramlist();
>>               goto out_free;
>>           }
>> +
>> +        error_setg(&new_block->cpr_blocker,
>> +                   "Memory region %s uses guest_memfd, "
>> +                   "which is not supported with CPR.",
>> +                   memory_region_name(new_block->mr));
>> +        migrate_add_blocker_modes(&new_block->cpr_blocker, errp,
>> +                                  MIG_MODE_CPR_TRANSFER,
>> +                                  -1);
>>       }
>>       ram_size = (new_block->offset + new_block->max_length) >> TARGET_PAGE_BITS;
>> @@ -4059,3 +4070,60 @@ bool ram_block_discard_is_required(void)
>>       return qatomic_read(&ram_block_discard_required_cnt) ||
>>              qatomic_read(&ram_block_coordinated_discard_required_cnt);
>>   }
>> +
>> +/*
>> + * Return true if ram contents would be lost during CPR.  Do not exclude rom,
>> + * because the rom file could change in new QEMU.
>> + */
>> +static bool ram_is_volatile(RAMBlock *rb)
> 
> Can we call this
> 
> ram_is_cpr_compatible() / ram_is_cpr_incompatible() or sth. instead?
> 
> Talking about RAM and "volatile" is misleading, and the function is specific to CPR already (e.g., comment :) ).

Will do, thanks - steve



