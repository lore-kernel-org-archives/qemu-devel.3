Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FA78C3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 15:45:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUTJ5-0001J2-5v; Thu, 18 Jul 2024 11:44:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sUTJ2-0001IX-CO
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 11:44:32 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sUTIz-0005ns-EY
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 11:44:32 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46IFeJcZ032478;
 Thu, 18 Jul 2024 15:44:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=eOiAbs03t60a0Sq80ZFm1frnM7Cq2Plq9/DcZvkiTN4=; b=
 OaixzVFLFVFgitFmXwotxwVUpTpeD0FExWOCcOsHdyruarNkAHS1gAYTctNIzW1q
 z9hXEFTt0jELtU9jvwZ/YZ6YdpLhxZ54TFPrly/WaDjB9I2rO3iIm7J62q2029Q/
 Q8f/P/lSKByCEn9gTa54ioWiq3SHellPRXkDYPDEwLc2kGwjanI1qXJc8k+xAlUb
 R1T65HGHjio+G13cEHhvqUOssdPLqwZkpZENZ1MPBVKrOQMx0Wrb/Occ67SgyBK8
 mdUKYYugEH1gLgLSoR7Ts/vbHX4jj/iga/2FtmFQ4d9Pvh8hTCOJAOM7AjdMikid
 SDm2EEFuV3xCBABhBvWD1Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40f5w380yu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 18 Jul 2024 15:44:22 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 46IEX8jm039565; Thu, 18 Jul 2024 15:44:04 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 40dwewhmef-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 18 Jul 2024 15:44:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X/s4G6wfI8/Vx6lPEmE1ZgLe8WaA94YnXAVOu/Iw21HJd7yujmyxFN3i/5HDo+5PlNUsW1ZAGjNUN6Fpq96xaTyZl02tas76N5uvS0ym068Ny1IPMlAkBhqcEvnht/JOkETB6BTE5QuogwoRZZCYncC9tGLXUv14vjLNFhA6OWEDvdtvnIuN2KLhXOWel2ABRHO9evWR+uo2u4GjKEv8d0dnhMimYf2C1VuXvLzvJXC45XMvXvdIwwNj6FlzHoLevZOoqE0WC4ceGEenr8RhovvMk2V9iHLMD40toi/3eVNP3cS9i8J9+KgbdtuUjyJe9TgX350xYHtvpWNaM0QLRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eOiAbs03t60a0Sq80ZFm1frnM7Cq2Plq9/DcZvkiTN4=;
 b=goT1dRC/GNo9uITXdUBcQAaZTPTC4ZNwpbyQFW/r2N6ORooupCl7CPDCUe9pYdNJ9eoQWQKfcPyAoOb8q/NSdg8XiqWTUJfGOZ7sGfCxd2ZZIJW1Th48+4y4hlgPch4PP5S9+ZBVNTiHYCQurhUrPsphtGoEEKlPspqeGWJaGakk7eLb+8XAPnujApX+iPaddLNPnqeT94KnUNaMa0FFtGARdt3q4W9WCJeXyBu3Ijz0BLMzPb9T4BV2nMmdNXU9+KzmYQqPB7VmBKbJIl60kAlI0KlK5Q4bg3c83+1zyv6keSdfajFeAo1EDbOfLcIYow5FveSejdMQqOuYS2rSRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eOiAbs03t60a0Sq80ZFm1frnM7Cq2Plq9/DcZvkiTN4=;
 b=gt6ksd32rrqdZsvmNVUq3PNtq88sR4kJjXwUeecgzs/PPqDF0PhNtoy3NTa38/L58fyfeQZVwCFuURLMFXv++pCOTUvlRPuvlo57wG4MVjozcFOyZ2nVX9KSI1toBJPVnKKzGDoQ2nAPJ5T0+lqA83fLzHYTwONn8nmRmlhx8jw=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by SA2PR10MB4796.namprd10.prod.outlook.com (2603:10b6:806:115::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Thu, 18 Jul
 2024 15:43:58 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%6]) with mapi id 15.20.7784.016; Thu, 18 Jul 2024
 15:43:58 +0000
Message-ID: <7d37a745-6463-4b43-979f-2ac635f11d11@oracle.com>
Date: Thu, 18 Jul 2024 11:43:54 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 01/11] machine: alloc-anon option
To: Peter Xu <peterx@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <1719776434-435013-1-git-send-email-steven.sistare@oracle.com>
 <1719776434-435013-2-git-send-email-steven.sistare@oracle.com>
 <20240716111955.01d1d2b9@imammedo.users.ipa.redhat.com>
 <ZpgaZPxKzwcVAYZn@x1n>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZpgaZPxKzwcVAYZn@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0150.namprd03.prod.outlook.com
 (2603:10b6:208:32e::35) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|SA2PR10MB4796:EE_
X-MS-Office365-Filtering-Correlation-Id: 9afe7a01-f1a5-4480-7569-08dca740702e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SVN0bGZ0WlNDN29jd2ZqZVhwY055allmMmlPbEx2dzIwQWYwY0lSMzhNTHh0?=
 =?utf-8?B?YUR4cHg2VktKSVRWcFBraHJLYWJsc294TkVOcytIN05RK0VTTklDUUtXZEZS?=
 =?utf-8?B?RHgxR0M5V0dwVjdQRHBYNXZVNnkwQXUyMnY0TkhaaXNwWGdEVlFIbkcrTHl6?=
 =?utf-8?B?Ly9RWDFKdTE0M20rMDA2a2l4blA1SDk2Y2dnUVAyWm9xT2F1Y2ZTWUVLT2Fl?=
 =?utf-8?B?OGlVaytMcjZ3bE9UKzdhKytSNjV1dWIvNjF2TDJBL3BSVTAxV0Nqc1dUNjAv?=
 =?utf-8?B?cEZXS0tCWHlSMmd6a01xSTBXYVJCWnRQM2QxVmY2UEhNWlFmdHZ6OXdjaHM2?=
 =?utf-8?B?RlhnMUYwT2JUYS96aUlYc3BwYlBxWjhENDNBSEM5STlTSU9DbjFKRUhSNkFF?=
 =?utf-8?B?NEhiUnFzRUtIUDZXRU9PTlFOWkNRVlZiUXNUQ2ZaMWNtS1dxT2E3MzhXZ2l3?=
 =?utf-8?B?OEZGcXlmL3NxaWJQU1k3cmgrUzgrUDkzZlF0dERFMmFIbmhwaXlteVA0ZEJt?=
 =?utf-8?B?a3pLZWc2SjY4OHF0RlE1cFNRaEh0ODUzMWJGMi8wdlYzdzdpaktzNlkrZHZH?=
 =?utf-8?B?NVppMHlIb1lIdUE0VFpwK3hmYTlMTnpzZG5zS01FVmxlcXNDbGlqdW1pdjhL?=
 =?utf-8?B?V0ExdzYxQXBNcmNYRk1KVEdzbHpOZHdzNWpFRHpSeGZnR1NEQU11SEZtR3Jm?=
 =?utf-8?B?bzl6aGNSdzMrYnM3QWoyRFdLS0dyMXg3T2xaSC9zakRYOEFKWHo4amc1bTR4?=
 =?utf-8?B?UDRsVVhIZUNIeitGbTVNdyt1RG1QTzcrbjlzcXAyMFphTitzTkdIalVpWEdp?=
 =?utf-8?B?aWI4S21EY1orY2MwNnhCSy9XYkxCVjV1Y0tIM1hGdVhqak00M0tQZGtYUExK?=
 =?utf-8?B?TTFCd3NjL1RaeEZzQ0pBRjhGOWd6RkxhVGQzZjJXenpIZWkxQkhISHBoa2h1?=
 =?utf-8?B?NXZnaVQ2NWVmZnlMTVFHTXdEL2NpanhzeHphbWVOV2Raa1RUUWNmUmZaaDdM?=
 =?utf-8?B?b2dqZnMrVTBydUJQUFdab29oWW1jMDdtZXUxdDVOTFl4WE1FdkJCcmVjcmhU?=
 =?utf-8?B?VVhNZ3hmNlhScFN0L0Via2I4M3ZDVWFtLzhHaG1nMW5XSEJWL3hkSHpSNmxZ?=
 =?utf-8?B?L3dXbEpXYmd1QmxEY2VuNlRFV2NlK1JabC84Yll6Y21LMGYvUmI5SU9DOEdE?=
 =?utf-8?B?QW9wYnFnU2l3RXUxOFRJb0JiSXBpaERESHo3dVNSd3ovMHJDUVkycG5hWVJS?=
 =?utf-8?B?aDY0c2JJRlo3N0wwMGs5SXJGcmlOdzMwbStqK2VlUy9XajhxRkZzcVVqYVlr?=
 =?utf-8?B?QzA5M1pkcnRJeUJuTnNPNVlSem5jQzVpZk1vbm9qTTlYTVF1ckZUNXFTUXFy?=
 =?utf-8?B?V0JpakVvK2JsaUEzaEkxaFBMcGtxaVZYU1JkczcvYVFvc3A1WXlTYmlPUCsv?=
 =?utf-8?B?YnYrKzltSTkyamdqNHlFWkpvMDdvMTdTUGppSWwvWDErYzZUYlVVOWtFQ2NJ?=
 =?utf-8?B?SEJ3L2lFRS82TGd2Y1hwNks5YWtQQlBDWlJhSllJQjc5aHNFMTZJekMyd3gx?=
 =?utf-8?B?NjRtcXNSeGM5bmhGZjRISklnYzVHVjBkSUVxMjVkMFJtTVFxNDJWQjFIT2Zu?=
 =?utf-8?B?TjR5UG41UU5lUllOVGNSZjZlclc2LzZEM0xGc2F4SDdrMFlZdGJldFByRjk4?=
 =?utf-8?B?UnFyZXFPTkFSSE83NUdMbjBwL2g4UGgvdFg1d0NEUnZaYXRBVmtFU1Fyb3pa?=
 =?utf-8?B?SXM4U1l4M3dQUmhXZWtLdDllbVAyRTJsVm1sZ3dNa09JWHhYd0tUWiszOXM0?=
 =?utf-8?B?Qlp0TXdmNHlHK3BjakdIdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VVpOSTB4Z1E3MzlaSnZ2alA4eEVHK2RlZ2RSZ05SdFRIRUJSRTBVMmtEQlRw?=
 =?utf-8?B?cm1WNW9ONTc4cEI3LzRoQkV0Vlo4MzdtUkU1YXpmWG5EL0xkNnR5OGpHZGNn?=
 =?utf-8?B?L054a2dUSEZZOTNzWnVwWjZaSHJEQXdpQUNaQ2pSK3N1VkVXSmx0ZmF3cFo3?=
 =?utf-8?B?d3Q5RzBoVW5McmRuaXV3U2hiRHBhZkNGWndyMDl3MVZQSFZxTythZHY4MUc1?=
 =?utf-8?B?Wk0zYU9wd1Nwd2E3d3FCb1F1SDF2WWlXN01ESHNrdk56UU9lY0FMWGltb3A2?=
 =?utf-8?B?U05oWDZzSnl0V2ZWOTIwU09KMGlidW8xZ3VucGVzbTh2ejlNWmdVemRkOWE1?=
 =?utf-8?B?VGVvUGZtWnkzZnN1QjJtMmZ4SXdrK05TYUdneVdobkphcnlCRW5SeGFGUm1l?=
 =?utf-8?B?MzZYREpjSHlnaEtGWnVPWnMxaGtNNlo2NC8wQkJ0QTI0b09MTlVYMmtZRU1y?=
 =?utf-8?B?eDBSRVg4V0EvcVdmYzRrcHc3K240aUNoWm15YjBoRWRwOGpHYmlVT2JLN2Fz?=
 =?utf-8?B?Q3RFOXBycHNqSkdIbUt6R2E2N1RjRUk2ckNSTy9USFFka1NFQnh4cjI4V056?=
 =?utf-8?B?RHFkUUVLM1YxZkFpWnBocW9EVS8ra0E2WUtYeHBEM2hhWVBJZkt6MmVISjU3?=
 =?utf-8?B?RTFHZEQvVk95bHhkMVNpdXJocGhBR3E0N3YwWjFVdE5NWDRJbVBHV0k3NW1j?=
 =?utf-8?B?cTFlS0tueFRrZldudk1nTUZBM3BZMUdOTENVdURNcVZTWVFvZjBWWkZGYWRT?=
 =?utf-8?B?dVdoU2dOY09ORENGTytza0xPSlJKRXJhZVNUNktleTB4SHlVOGpVOGtCbll6?=
 =?utf-8?B?blhtOUpsUkxXMEIrWExSLzU1bGROekJtaU10ZG5rbzNLYlFDOEdKR2hWWWJK?=
 =?utf-8?B?ZkkvYUhYWHJZUGxSVjBjOUNTYnJSK21XL0ZzZXNyYkVubGhwZ0QwMWJqNmdF?=
 =?utf-8?B?b2xwcXh6YTBaendwSXRpdWVEaFEvNFVqdWdXeHdXOVBXVENpZVBQeGYwSTFv?=
 =?utf-8?B?Z20yVmcyZGZEMDBSVmxNZHc0bkFNS1FCVU1CYVJJcnlQbU41WDNpT2gxdlpT?=
 =?utf-8?B?bVNiL21JdHVxM0JwMXFEWUx2Q1pUaWZHLzlzcXB4QUx2bTYrdEtab2ZHTDEx?=
 =?utf-8?B?SFNaRXFtU0VXNmhZODZ6RGRqeWRYSWRVaDdQMFNNMHZPa0s0aGt3dFFDeExW?=
 =?utf-8?B?YVBLK3A4b2Nwd0dZZSthL3RJcVJHRUlDYzFPQkdlWHp5akJ6R2Ezb2hUQ084?=
 =?utf-8?B?eVkzeDd1d1ExV2JxVk41UGNIU2RqM0J4NkgwWU80MGRnYm5PMEpCVUMrNzFh?=
 =?utf-8?B?UXpYbEVMK29aaTBPYzRRSU43SXFUWEVrdlpDQnc2ZFhMdVdVMkFNRGdOZFRt?=
 =?utf-8?B?SEpQbnJmcEpyWDM5alBUQ3k5a1RUOXVJSDgrUjNhYytLL0YxbllrdldieFVo?=
 =?utf-8?B?aFE3bW1yWlFsZXZLQXA5Y3BGdUYwOTVZdXd4elI2MVNaY0tES1VmbitpS0Rs?=
 =?utf-8?B?TGxtUmtzQnlJanZObnplSWsrQytVcW83aUpSVGVwTHNBazBSRlhnMHVvZHJj?=
 =?utf-8?B?Rjk0NDJsdG5ZVDRnenZvOXord2E5N0FIa1gzQ2dvWkhDcTZRc0Y5ZFBNUkYz?=
 =?utf-8?B?WCtJMFlDN1dFMVE4MG0vRWNVRnF3ZUhWOGxjRVVhVE5pWkFSM3Y3YUJQcDZh?=
 =?utf-8?B?TlA5K1REL3UzREpkVzV2aXFkdS8rT21CT2UvRUQxNnFadW1HSFVseFk4SnBX?=
 =?utf-8?B?Sko1L1luNVFsWEhtS0wxV1BQQjlwNTVienBLbGpJVVZmcDdtaUM1N0VxRGh0?=
 =?utf-8?B?aG1mam9seC8wblpLRi9qN0NrZFFaaU5OWng0OFlZd1AzL0M2VTVlOFlKc3k4?=
 =?utf-8?B?TWJJTmVoSXNSLytaR1hlWkNnUXdQMTZjQTJsNVpXRENDMEhSNGlUcU5LVGtl?=
 =?utf-8?B?bEgxTmc2RWpLWWVpOUU5bCtjYnpNY2hzMFNSM21LQ2hZcERVekk1a3ViOW5C?=
 =?utf-8?B?MnZndEYxd3dPL1FpYVc5RjVHQkVaNTJ5TzlhVEp1VUNBQUxZTUV0d1NDQ3RX?=
 =?utf-8?B?ZUVqRHJZaWRqTUI0QlVDcmY4OUVxZytndG5pQjBQZCtzeTArYVQ2NGVzMk1I?=
 =?utf-8?B?eFJVNGJqTU9XUGIyRGFTNGUyTSttMnBsUndBUGRwZXpHZmcycWNMRFRseXgw?=
 =?utf-8?B?Q3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Lz8qiMrxr4QKFfS+/VG7zONb+R14XMXy3PLP6OuOhSgPaZAmzPcD/V9MQvUHCpc+se52Jv3QJ/bzvAR9luZln//yDgpZmM3fUQm3qvGCK4FpaiKje4MR+WUT6Lo4602SvQVVzlcFD+KWWGCb9IBOMUDLncHNuG9Wi2TEW8A5jPLMl2QH198wxDjzpnnt+VdQhZMx7jxLaT6uuHI80yNcGMDWZr/nECWM8jgy0rWU4bqmMqyxyVosRPFc+R5WZG0BJ1nKr5fQbjqkhZ/TJqYJn9MfYif5iMwNg+k1OcEjIVbvv69Vx0H7S0RirpbdXs/MMC5tX8ktZH8g0THXYf3eKRyk00miohl258l47KQibSju+pVp9FH06lAL11LfXRkrTqMUAAinQe7jv5kxqdjr7i5pcaVHj9+5yzE6wk/hSkaIQJGDa+j+WIouklxylV+uITUeqqxJsknr48OGceEMhANLIvs7Q0aixoZ7wiNHK6leypdyqwsiazjmkHVkFFymbgpcTIXK5rYipnR0R79cI3j/lbua/vfyq9R8k1n3hJU+OXo+cDa5fVs5U/Faq0ygsKIuktKIBHpMYBG2jknJQSyV20N+rJmSu3EmZUinwSw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9afe7a01-f1a5-4480-7569-08dca740702e
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2024 15:43:58.2501 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5rh857RJNyCDcKGwo5pJbNeo00hwbLubeb16oUqdpjCm8gLwliRSSSaVi9X9RF73lUh5O2icMbf8zu4hIvS11Ppz4jhsaVwG08Urt2xgc78=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4796
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-18_10,2024-07-18_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 malwarescore=0
 suspectscore=0 spamscore=0 bulkscore=0 mlxscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2407180101
X-Proofpoint-GUID: bf7sIKavboG9C3lTWBUnUx13S-n3Jevc
X-Proofpoint-ORIG-GUID: bf7sIKavboG9C3lTWBUnUx13S-n3Jevc
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
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

On 7/17/2024 3:24 PM, Peter Xu wrote:
[...]
> 
> PS to Steve: and I think I left tons of other comments in previous version
> outside this patch too, but I don't think they're fully discussed when this
> series was sent.  I can re-read the series again, but I don't think it'll
> work out if we keep skipping discussions..

Hi Peter, let me address this part first, because I don't want you to think
that I ignored your questions and concerns.  This V2 series tries to address
them.  The change log was intended to be my response, rather than responding
to each open question individually, but let me try again here with more detail.
I apologize if I don't summarize your concerns correctly or completely.

issue: discomfort with exec. why is it needed?
response: exec is just a transport mechanism to send fd's to new qemu.
   I refactored to separate core patches from exec-specific patches, submitted
   cpr-transfer patches to illustrate a non-exec method, and provided reasons
   why one vs the other would be desirable in the commit messages and cover
   letter.

issue: why do we need to preserve the ramblock fields and make them available
   prior to object creation?
response.  we don't need to preserve all of them, and we only need fd prior
   to object creation, so I deleted the precreate, factory, and named object
   patches, and added CprState to preserve fd's. used_length arrives in the
   normal migration stream.  max_length is recovered from the mfd using lseek.

issue: the series is too large, with too much change.
response: in addition to the deletions mentioned above, I simplified the
   functionality and tossed out style patches and nice-to-haves, so we can
   focus on core functionality.  V2 is much smaller.

issue: memfd_create option is oddly expressed and hard to understand.
response: I redefined the option, deleted all the stylistic ramblock patches
   to lay its workings bare, and explicitly documented its affect on all types
   of memory in the commit messages and qapi documentation.

issue: no need to preserve blocks like ROM for DMA (with memfd_create).
   Blocks that must be preserved should be surfaced to the user as objects.
response: I disagree, and will continue that conversation in this email thread.

issue: how will vfio be handled?
response: I submitted the vfio patches (non-trivial, because first I had to
   rework them without using precreate vmstate).

issue: how will fd's be preserved for chardevs?
response: via cpr_save_fd, CprState, and cpr_load_fd at device creation time,
   in each device's creation function, just like vfio.  Those primitives are
   defined in this V2 series.

- Steve

