Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE460CFB456
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 19:32:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxtS6-00030r-S2; Mon, 07 Oct 2024 15:31:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sxtS0-00030G-Rl
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 15:31:25 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sxtRy-0006Hn-Qw
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 15:31:24 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 497FMeR4022963;
 Mon, 7 Oct 2024 19:31:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=eV8J6Spdy6YgawTWjar4ex5oIk18k8IizjNmks2mQUs=; b=
 hHnyDl+4OYHo10ifp3AgC+vGg3OPzmAfH1iYpDCY39lWeXoRnlLf+0X8LW2Ry3GP
 L0sBev01pgv3pYD0ZrQSsJ5XR9UE63Y85F8fRwd4atOoH3EbXz0FbNvPN7bkV2rn
 GZHnsSs3Ul2y/VXk5Pvz2RJUFkKXEWv9acYW15EAZw3UYfO/8b+kvnOmipk61H31
 VxlVeZLM4vfD3pixIuGH6DYczDDJ2WipjP7gLTmX4sR3Hev2Ia4VuTx3cPRPDOYY
 SIEIvzGE99SKnMTICWI4yNLaVryk/La61uGLCJ6+PlFBZ5TfSbu+dBg04c38eOjX
 DGnvzjopmSl6RKvsimRfUg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42303yc7q9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 07 Oct 2024 19:31:15 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 497J4W8J011401; Mon, 7 Oct 2024 19:31:14 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com
 (mail-dm3nam02lp2048.outbound.protection.outlook.com [104.47.56.48])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 422uw67gem-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 07 Oct 2024 19:31:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LOaUh2WOoQ27jStAmRTwJMBEP/ng2rG8/wBl2uFb2nHfs4jgyrY/vXQrKLJFj2yoQjWArahH5jc4y8+shUhU2jhzJGCwvDPT3HjEJ905eCb1ipzKqB5g2ehe9RA16oYBdQ7/crNz/AElCzQj47dWzKlysPAIVEyRu6M9DFKQzOjBOggiwX+fXwKdVjy1ymfnMijsElUCfCAEqojzHOT2klcICBnLfvEa/NSSY2eSO77Cp1EcVo7S8hWOG/uICgZ/N1ptDWlH3VoTKmrqnrsOmvU6W7dptYT1IjZzGAjylb/lCT7H0fqZlfocPtH7S1SFMi1l+N/wDL9wvfgv4UpsVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eV8J6Spdy6YgawTWjar4ex5oIk18k8IizjNmks2mQUs=;
 b=SPyoRE7GNWQUfdC+mEytIkmR/1dNOF2YUH9xCoRk+NM8nIV85Wkkg/Mw+vw6nqvsvYO2fq/N3FuhvXW9E5bSCXChHnfpkj4ouJcFUrUUG4ee5vIF9rnf6TztSJkCdD70HLo3G0Cp0j21pCYuveEgYmo7MmnTPRUOvsrnuRyua1rOZ3jIs3qyk3Web3rxX4oL7F6IfMSPr5FBAbI3tLPj5D80Y8ZEAG76uY8uiBugwu9XAHjQfiClKzD5CMBYVyAiXfOpl+lWK2tRrhHJ46KqPG92IKwFbPtVXwHL6XtVc6IyGs3LHaeoS/I7SUAaGFjL6dooC4kdYhzMPVpgQJEbhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eV8J6Spdy6YgawTWjar4ex5oIk18k8IizjNmks2mQUs=;
 b=z73G4YICSLoLpHTcnVdDZZC7xYrKX7segw4ypI1MY1ZGlPXCJdNMibaFXeVURs3Y9HH1drGLfnRhXgHi+KxRmdsoHUbAtqwhuXLytv73t7N9TsA3OO0nZxIIafRp6xr9sQmhJI200+kFMkUsS/PV7LvfLV9wfynQBJfBE/jqsYQ=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by DS7PR10MB4912.namprd10.prod.outlook.com (2603:10b6:5:3a1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Mon, 7 Oct
 2024 19:31:12 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.8026.020; Mon, 7 Oct 2024
 19:31:12 +0000
Message-ID: <68f5b27f-a06c-44f6-ab4d-3d0a32195b70@oracle.com>
Date: Mon, 7 Oct 2024 15:31:09 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 03/13] migration: save cpr mode
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <1727725244-105198-1-git-send-email-steven.sistare@oracle.com>
 <1727725244-105198-4-git-send-email-steven.sistare@oracle.com>
 <ZwP7v5pZNsMuXPgW@x1n>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZwP7v5pZNsMuXPgW@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0255.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::20) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|DS7PR10MB4912:EE_
X-MS-Office365-Filtering-Correlation-Id: 1283122d-43be-4fb0-a580-08dce70699f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WSs0QUF1OCtJR2JRU0lJMHhSRzlvanBpNnpXRGZsZUFFUFhETld1MzJXL3Zy?=
 =?utf-8?B?czNTSDkrK05pVDA4cXNWVmU3c2hsb3gxclBQdjBXM3pPUjY5MW1kMEtvWURZ?=
 =?utf-8?B?eVc2dVlXbWs3ajBwRzIyNmZkeUwvaElQNy9ZTXIrZUVNamhIdFFOVHZXM1VC?=
 =?utf-8?B?eWJoTC9tNk9qTCtLcWE2Nkxuci9ZeTh6ZW5sVFRuWGkxRHdnRi85SW5zZ1Rr?=
 =?utf-8?B?VnNQVGFIbDR6UmFnMFFxL2dpd0o3N2REY3U0bTROWTZDTHpCVmk5eVFkTnFO?=
 =?utf-8?B?ME5VTHBPQzB1L3pFQlBwUHlzUDFzYnFiYU9MMzVUb2FKRXg1WEQ0cWdDKzZm?=
 =?utf-8?B?RE4xMlRQZVVKbkpuMkpWWTd4Q2x2elZHUXozc3RqQXFFM2pZYWZXSTd2YkJV?=
 =?utf-8?B?WGR4aEEyL216ZHN0SFZhL3ZIWWpXYUtoSXdkNUNuQVJiTXlkNW1pVTlzQVF1?=
 =?utf-8?B?UjdSdWpoL25LdXlKdTFOLzBCVllNMzQxV1FDNXFnMFhLSzVwTkE3WXRaVzdH?=
 =?utf-8?B?Y202S1Fsb2hOVmlxb1V5bm1FRlpaeko2TFdsdXY2NlN4amxFV0dFVi9EdklF?=
 =?utf-8?B?aGhhR0tkMXhIRVpCQWo5K1J5SVFoNGJ2clJYdDFvYkV3d3lDN2tOLzRsREJu?=
 =?utf-8?B?Q253WDB4MlEwQWlvRVU1Z2xnUFVrVkZSOXltWjRxU3RScW5UQkorS0RjTXBN?=
 =?utf-8?B?ZWZxcUJ6NWxYRVpUTGlPRHpST0JldXU5emlsUW5Db0d6MS9yck5vdzB6VCtn?=
 =?utf-8?B?Vmw2amdVbTlKYnE2aWZNbUdGU1VZL2tESjFwZVBXMStGWVUyell0cjBsRGxt?=
 =?utf-8?B?a3lKRDJrT0xWV2R1ZGpMY3dEVXFYcURFVDQyeW1RMEo1WWNpOHNFbFlGRVNJ?=
 =?utf-8?B?MkpDLzM5RFN0MEk5bnVWT0ZmRUFqTHMrYmZ5bmhjWE9rYk9Mc3dsdW8zeW94?=
 =?utf-8?B?MlJIUlhMZElEMjRET1ZyUndVNUFXdHVGUXY2SGU1dk5ET2N6UlhIY21yalJC?=
 =?utf-8?B?bm9PWnljaTJXay85cWd4ZTFNZm95S0hISGxoRG0yQzJCRGFzOFdNbm1PQ2ts?=
 =?utf-8?B?aGRuOG8yQ1B3bTQ2bStlVkFtOHZjOXcyTG9uWFZ2YVhiWFRWZkhKTkUzQm5v?=
 =?utf-8?B?M2krRkZKQm8xMjF2ZkRiUjF2UXdnZGQ2TXpkaUVrNDN5T0FPL1VUdGs5QTda?=
 =?utf-8?B?NWdmc1ZsQjZYMTY3bmZaM3VyaXB2Mzc5bVkxVlJwcHdXM21rOVk3b1ZLa3ZM?=
 =?utf-8?B?K0tsNlZFMlg4eUVwUWZ1ZEp3Zno2Y29RdHJYVk9mditCbURQR3BGS2RmSGRi?=
 =?utf-8?B?UFZCRnJZaExzb01nRFdBaDFPajN3R1B2U3BUQzlUVStRYlNWcnhyUU9PRGtD?=
 =?utf-8?B?L1BkMmE2djJOZUt3M0czZXRBaWxQSFVPNytod0xyaWhGRmdKVFpBUVFWb0hr?=
 =?utf-8?B?SkFsd1NtMVlVdmFJeVRqSjdhempLcTRTS2psbTFLUzVpRnFCVW1ieDJCRVlR?=
 =?utf-8?B?U0x1R2FCZUQ5L00vaVRaaFAyZjJ6SjJnNkZsaDAwcFM4RHljdXVvbGs0U0d3?=
 =?utf-8?B?YklVM0N1ZWNhSlEwUEQ3R29qeTJDN3RZd1VRUWV6NDhaTU5VditqRis4RWd0?=
 =?utf-8?B?V0NpQ0lzT1RPRS8rai9QNnBkdXM3YWY4aEVzQ1c4OVo1aUxnazAyQi90cS9j?=
 =?utf-8?B?ZGpGeDJGSEFHUlQ2ZXJRZDQ2RVkrb3h1TGZIaTZVVnpML2preGkzRUJRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cC9UZkdhU1pHMW5vbFFZbldqMWRFa3N1TVdwMWQ1UlU0TEZTU0lFM2pxcGN3?=
 =?utf-8?B?M1BLWnMvUWZLZlpXOUJpdlJURTRhNXBxZ3hNZ0J4cE91cWRPWkREMWIxZGtJ?=
 =?utf-8?B?L1ROaUFBM3d0aXdxYVVEdzQ2V0ZsaGdNQmEybXhiUGE3b2llVVNRN25YczNt?=
 =?utf-8?B?akVMeG9hVVRBQlI0M2JjNE5ENHhGbG5taStvV1lUb0x5dVJMdVZ1dHpnK0dW?=
 =?utf-8?B?c3dvVWJVVExYNXNoaWxpUlZ4WHd0WXNsdjVHY3Zxc2JEck1EWjlhMTVNZDZt?=
 =?utf-8?B?RlozQUNvMXdrLzJWSGI1YWkwS0xMMy9oRDVFbUVaR0pDaDdzRjVuZ3VjM3gx?=
 =?utf-8?B?TzhVZ0k1SW1QVFQrN1FGR2JwWXNqeTIrcEFKR0lpbHVJSlU1NzFxWDNPWWc5?=
 =?utf-8?B?TkNqMWxDNTVlazJKQlFaODQyUmF5Y3RkYWtNMjMrQlZ5NFdoUzEvbzgya1pv?=
 =?utf-8?B?NWJ0WFNBaWQxTTAvU0llOG5DenhqT0w4c0VvT0tRZzFkUG1PNUNzbUM0Q2Z0?=
 =?utf-8?B?SmxCb08xVlp5Vk41MXNLS1c0My9vYTdtbm81Y0N2cmUwWVFra3FtMzN2VEUw?=
 =?utf-8?B?N3dMUElWbk5qanJ1MnpFaExpNTQzSm44M2RIaDFBVGYzTzJxZkIxSmo0azJI?=
 =?utf-8?B?bzgvb28vUnNmRWN4ZFFSdWdXWGtKUFJvZTZodTRYUzRXd3N4NkwxaGhXVDdK?=
 =?utf-8?B?RU9LTjVLWjFuVDBJZ1Q3em13Q2JCR09HVGVPd2d1SkQ1TVdoSkk5K2ZxMjRi?=
 =?utf-8?B?d0ZFWDNyWlJ0QzlGV2VIeTBERlRPRTkvUWxOUWwzcWVDMnNxNU1uSUtBUGkv?=
 =?utf-8?B?NVcvd3BqK3o5TTJ0c2VhRmtCQkpTRjNFRjJOVXVyemJyRUEvVjZxOFVHN0xF?=
 =?utf-8?B?T1pPTUdsOE16NWwyRjU4SDNEY0ZERG11VFNPS2ZuTlZ0UG8zTkJEVW5mY3lp?=
 =?utf-8?B?U2E0N3RudTFYRUoxMGpQM09Xd3JTaGplLzZ4NmJGOWVaSWIrTkYwNVFsdkpu?=
 =?utf-8?B?YmpFckI4blBkTDNDL29wN0MwblFoNEQ0RGR2OVFNa0FFV1Uzc08yY3h6cDdC?=
 =?utf-8?B?Mk1EU0ZMdDh3d05GMEV0aW9veTVWVHhwa21kVEhqWkVhSU0rcFFvVzlkT0hO?=
 =?utf-8?B?ZVo3OU9VbHBnb09sV3NlTFBEcGF0S0J3NDJvMUs1Zzl1cm1RbUJkNEhXUHhn?=
 =?utf-8?B?SDdHZGtZZm1KdldjWGdYUDdScHJOcEJZMm1FUnNGUW5pSlpVRkxHc0FrdDll?=
 =?utf-8?B?SkZsclJMaGFwdjQwUDFKYzh5aVhuUjV6QUxkT01YV3JJa1M2R01iVGNhZjdF?=
 =?utf-8?B?Ni8yVmtjZ1FxV1JRa1hWNzdxY3ZJRzNmSk5Fc0tpS1hKck1nc2RncHZ4d0h6?=
 =?utf-8?B?WUFqQlE4YTJuTjBmS0dnSGo5bitIVzF5bHZRb1JxUEFXeUpObVFHK1ltSTN0?=
 =?utf-8?B?L3prSUJKbUtVMlYyUG9PanM5WVYxU1FKakd4cm1WZEoyc21kRk51RUJBOTI2?=
 =?utf-8?B?SlBJNE1QbGZVNy9FelRUQmkyeFltMzBUZnMwcCtTeWNGTUN4QnRBL21EOXpv?=
 =?utf-8?B?dUFQRjE2VURYUEk4eTA5NjdqMG8yT3NVODBOWm10bHRoN1JQZmhRaEw5M3dJ?=
 =?utf-8?B?N254NS9LMG1rUkFLek5ReHRCWjhsaDIxaVVkTGlPUlYxOEtIQm16V0cyUW8z?=
 =?utf-8?B?YTRBdnMrUU5UeVhzaldkM2Nkamo5aENaK2xQRk9VZGQyVTd5dDlLQ295bjVR?=
 =?utf-8?B?MzJ2UkRoWXJPUmphNGFYNXNCTm1WOTJnSTZGY3NVdWFvUnNMeEhnTDl4RWlD?=
 =?utf-8?B?cEUvU0RocklmMWExblp5RHVKdlEzTlViR3ZMK1pOQ2JXY2REK2pUMEM1ZXlk?=
 =?utf-8?B?Wmx4TUN1OG44NjhUQ2xFbmhsSUdWTFV5d2dvMXJMVHVNWEEzb2ttanRnMFFB?=
 =?utf-8?B?akhZeWtOTTdNR2ZBS0dJQUNheEErYkF3a1A5ZFB2cHB1dHF0QWdlWGtwS3lo?=
 =?utf-8?B?RFpBVFNSYTJKbHVzOXRjL2xZQWxyL2QyQmwxTlpOWlBIYlJEcG9vcUZzVnlG?=
 =?utf-8?B?MGVFNXhFOVFrY0lNZUhXNlcvWXl4UlNNVG5RVGc5a1Z3ZVo0b3JvbGgzKzd4?=
 =?utf-8?B?QWlVY0dCbmlzWjNhd0RmOC93WU15TC9aUUpWaGNNSjhmdjBkbHFpaWh0MG96?=
 =?utf-8?B?Mnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: HO6Nm8H76ydqyYkNnJYimLbZY2qOnRVHSvt3R4Slb99RIb+zgtmx+892gWYgB5QhDcC5/aN7T4tUfdUOXZWZqbmTuRU6M2SCDkRpgDgCYGjnOB7wA6bVGfa7ok9aGTkEapu4gUk8J50pq3Vz7H48wD2R67V6OkV2isM+c/EnfdwYkcZDeSfBfhgmgCsnSEx1yeTTgTCGq5vs3EQTfVKYin4m31uWGLT9Y0BkaeqY+gAI8egIV5E7R446rZHbo2+1/hWBU4sn0OcLk8up9GGAVJlaPTH0rHxqjk/4IUckaHHbFQPYUP3aEfAUvdozHbyQwVefdNeviXfuPmiOwkNKLTyc2HOqeDyS+F0Lq0xCFjQAOEW0XYDAODBtOekyzMfxem569Za7yd+s2NPfMkDAu0tSRKUuHIVVxFpLE0MXEmrbq1YDtRzeUVn+OP/FskG2Ej5vfiz8JaDRf5FBN0FTISq265xwD7E7b2hyelLjXAmj9YeCdH08QU0Czf8OpvFawHNLMAniDdYOal2/DApQzuzEUYSVPfpO7tnqLGWPICDu1NUhqMu4TlNGx7bKGwLLFBoywzjEkZdgUIoV6WZ+ZB2HZ0sd1vzjXpk0nmgpBt4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1283122d-43be-4fb0-a580-08dce70699f7
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 19:31:12.0723 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1X4U5+wuwG1Lq1LPIhdIPmoV01rdG4Kl0U6/z66Lr3ALiJkSLpiQWX2ByI7F1uWaeBlP7OtsyIun5eQx0NTKQxUtvxglRp6TgdaZzK9SGsw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4912
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-07_12,2024-10-07_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 adultscore=0 mlxscore=0
 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410070134
X-Proofpoint-ORIG-GUID: uBOdGUD1UQODc9hZ_uN7Mx_wZibhVIUi
X-Proofpoint-GUID: uBOdGUD1UQODc9hZ_uN7Mx_wZibhVIUi
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
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

On 10/7/2024 11:18 AM, Peter Xu wrote:
> On Mon, Sep 30, 2024 at 12:40:34PM -0700, Steve Sistare wrote:
>> Save the mode in CPR state, so the user does not need to explicitly specify
>> it for the target.  Modify migrate_mode() so it returns the incoming mode on
>> the target.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>   include/migration/cpr.h |  7 +++++++
>>   migration/cpr.c         | 23 ++++++++++++++++++++++-
>>   migration/migration.c   |  1 +
>>   migration/options.c     |  9 +++++++--
>>   4 files changed, 37 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/migration/cpr.h b/include/migration/cpr.h
>> index e7b898b..ac7a63e 100644
>> --- a/include/migration/cpr.h
>> +++ b/include/migration/cpr.h
>> @@ -8,9 +8,16 @@
>>   #ifndef MIGRATION_CPR_H
>>   #define MIGRATION_CPR_H
>>   
>> +#include "qapi/qapi-types-migration.h"
>> +
>> +#define MIG_MODE_NONE           -1
>> +
>>   #define QEMU_CPR_FILE_MAGIC     0x51435052
>>   #define QEMU_CPR_FILE_VERSION   0x00000001
>>   
>> +MigMode cpr_get_incoming_mode(void);
>> +void cpr_set_incoming_mode(MigMode mode);
>> +
>>   typedef int (*cpr_walk_fd_cb)(int fd);
>>   void cpr_save_fd(const char *name, int id, int fd);
>>   void cpr_delete_fd(const char *name, int id);
>> diff --git a/migration/cpr.c b/migration/cpr.c
>> index e50fc75..7514c4e 100644
>> --- a/migration/cpr.c
>> +++ b/migration/cpr.c
>> @@ -21,10 +21,23 @@
>>   typedef QLIST_HEAD(CprFdList, CprFd) CprFdList;
>>   
>>   typedef struct CprState {
>> +    MigMode mode;
>>       CprFdList fds;
>>   } CprState;
>>   
>> -static CprState cpr_state;
>> +static CprState cpr_state = {
>> +    .mode = MIG_MODE_NONE,
>> +};
>> +
>> +MigMode cpr_get_incoming_mode(void)
>> +{
>> +    return cpr_state.mode;
>> +}
>> +
>> +void cpr_set_incoming_mode(MigMode mode)
>> +{
>> +    cpr_state.mode = mode;
>> +}
>>   
>>   /****************************************************************************/
>>   
>> @@ -124,11 +137,19 @@ void cpr_resave_fd(const char *name, int id, int fd)
>>   /*************************************************************************/
>>   #define CPR_STATE "CprState"
>>   
>> +static int cpr_state_presave(void *opaque)
>> +{
>> +    cpr_state.mode = migrate_mode();
>> +    return 0;
>> +}
>> +
>>   static const VMStateDescription vmstate_cpr_state = {
>>       .name = CPR_STATE,
>>       .version_id = 1,
>>       .minimum_version_id = 1,
>> +    .pre_save = cpr_state_presave,
>>       .fields = (VMStateField[]) {
>> +        VMSTATE_UINT32(mode, CprState),
>>           VMSTATE_QLIST_V(fds, CprState, 1, vmstate_cpr_fd, CprFd, next),
>>           VMSTATE_END_OF_LIST()
>>       }
>> diff --git a/migration/migration.c b/migration/migration.c
>> index 834b0a2..df00e5c 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -416,6 +416,7 @@ void migration_incoming_state_destroy(void)
>>           mis->postcopy_qemufile_dst = NULL;
>>       }
>>   
>> +    cpr_set_incoming_mode(MIG_MODE_NONE);
>>       yank_unregister_instance(MIGRATION_YANK_INSTANCE);
>>   }
>>   
>> diff --git a/migration/options.c b/migration/options.c
>> index 147cd2b..cc85a84 100644
>> --- a/migration/options.c
>> +++ b/migration/options.c
>> @@ -22,6 +22,7 @@
>>   #include "qapi/qmp/qnull.h"
>>   #include "sysemu/runstate.h"
>>   #include "migration/colo.h"
>> +#include "migration/cpr.h"
>>   #include "migration/misc.h"
>>   #include "migration.h"
>>   #include "migration-stats.h"
>> @@ -768,8 +769,12 @@ uint64_t migrate_max_postcopy_bandwidth(void)
>>   
>>   MigMode migrate_mode(void)
>>   {
>> -    MigrationState *s = migrate_get_current();
>> -    MigMode mode = s->parameters.mode;
>> +    MigMode mode = cpr_get_incoming_mode();
>> +
>> +    if (mode == MIG_MODE_NONE) {
>> +        MigrationState *s = migrate_get_current();
>> +        mode = s->parameters.mode;
>> +    }
> 
> Is this trying to avoid interfering with what user specified?

No.

> I can kind of get the point of it, but it'll also look pretty werid in this
> case that user can set the mode but then when query before cpr-transfer
> incoming completes it won't read what was set previously, but what was
> migrated via the cpr channel.
> 
> And IIUC it is needed to migrate this mode in cpr stream so as to avoid
> another new qemu cmdline on dest qemu.  If true this needs to be mentioned
> in the commit message; so far it reads like it's optional, then it's not
> clear why only cpr-mode needs to be migrated not other migration parameters.

The mode is needed on the incoming side early -- before migration_object_init,
and before the monitor is started.  Thus the user cannot set it as a normal
migration parameter.

> If that won't get right easily, I wonder whether we could just overwrite
> parameters.mode directly by the cpr stream.  

I considered that, but parameters.mode cannot be set before migration_object_init,
and some code needs to know mode before that.

- Steve

>After all IIUC that's before
> QMP is available, so there's no legal way to set it, then no legal way that
> it overwrites an user input?
> 
>>   
>>       assert(mode >= 0 && mode < MIG_MODE__MAX);
>>       return mode;
>> -- 
>> 1.8.3.1
>>
> 


