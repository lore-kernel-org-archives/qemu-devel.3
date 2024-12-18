Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EE14E77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 21:04:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tO1Cg-0006d5-9M; Wed, 18 Dec 2024 16:03:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tO1Ce-0006cQ-By
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 16:03:32 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tO1CZ-0004PA-VZ
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 16:03:32 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BIKIbc1018155;
 Wed, 18 Dec 2024 21:03:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=UKqHLH9+3ca3fbaN8GF9upzycHdPmNMmtidXoH8sUss=; b=
 dyPHFaPq4JUMLGPWotNvP6hMbgcl3nDY+cGba8JR0b2nOMjMTbw18NL0v8me0X7W
 ntXVqd7uIWzpYyVXctOWm2F6DGGxRujmsWsbfAu0Z1h03vaKvfpN+ZcQA7gCepsT
 2wiy78moSGLdDFyyYsvgY5ila3qll3MarKhkmNUGF0M3q7HGtkA8BTCoO5DL4Fi9
 fX1rodb/WcD1mEZsAkoNBUKPAbBdNwttTjF/y62Yb3a9ntNPqUd5gnu4vd7kWxS6
 1qAwwera/XABcXctoqfT5xe2R/q9qu+dxS3q35lv2meL2K316hP9O564Vya5kEac
 i63KU+3y4yupRCuYnu4lEg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43h0ec9kby-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 18 Dec 2024 21:03:24 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 4BIKAY2V010969; Wed, 18 Dec 2024 21:03:23 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 43h0fa7bve-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 18 Dec 2024 21:03:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EVbjXCGxlIt/cv+kPi4ACZxQ3spdAvRLVzL38Fp++6E0KZSHUL0PKLMsfgYl6fNLGq+Ig/hfEeUiAhm2ivys/9geIn9/0QAQWE4zgoKkQpVAhhoRcT9/e4LVEz4s+CQtSS13fs2y2FU+75fwDFVH0JNcQj5nyHReW56JV/XUBS/Xk5cJZwyXIDeuO5y8pFGi1XRsGfBM7T+YjDFZMZD7I3XtjDWvxiebilS1xRMVqMXTgbXe8HeW1yc5IPd5bsPKDwQdR64COLbNmCNbzBCf6THPurucbk/6fW5F3R28K5vPIBX4IJ9H57uq/HeUL+lBoLAJTG5pVTP9o27ipDib4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UKqHLH9+3ca3fbaN8GF9upzycHdPmNMmtidXoH8sUss=;
 b=Ir/SrEdDHtY+qHD/9UzgC5l+MsppK5qUF/HQ6ajb3c0MqbW7cVGrAiKp31pOd9Ne4GM2Y6bwk3M4QCBFqfrfEQ/mNLwLbiDXIi31Qqd5Par71wj7EztnjuGuMxXJc2yM8veSuAB+Fvwd2ZKoKEf3WTHQCOX/QtUx/Ovx1pyAPZR+xkTuLULIJbGn+1M4gU/pBhmN6rcgEaXB76Tn1GJi4b2SXH8dhBzNPdVkBe5oqT+UrxxRVoqDdB3yXCxQw66BoRAeUg+CESqQI5ldhceoYpTaDBcTK1qkTUDGIhT/sjoHXqMfXgPGTXiE7kudImHh5wXcy29dyXZosn7a//QHtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UKqHLH9+3ca3fbaN8GF9upzycHdPmNMmtidXoH8sUss=;
 b=gm1QlfX/Gu5rv+2q3dDHMmoAc2kDUBd2MPKYcmwzCKI72S+4005zVH9cVgvWyAD0AHbyo0GOVyj7mzaUmFN7VVM5gz7x586PLRn8iljrMcYQ6kuy5K9Ik2IDZNxiL3kEcqd3Ndwy62ovBcwsxAGfCRtAExzxhjB+PNSm9rQZxJc=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by CH3PR10MB6763.namprd10.prod.outlook.com (2603:10b6:610:147::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.18; Wed, 18 Dec
 2024 21:03:07 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8251.015; Wed, 18 Dec 2024
 21:03:07 +0000
Message-ID: <f5e19435-b9eb-48b1-a87b-9d3149eef329@oracle.com>
Date: Wed, 18 Dec 2024 16:02:59 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 16/19] tests/qtest: defer connection
To: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <1733145611-62315-1-git-send-email-steven.sistare@oracle.com>
 <1733145611-62315-17-git-send-email-steven.sistare@oracle.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <1733145611-62315-17-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO3P265CA0030.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:387::12) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|CH3PR10MB6763:EE_
X-MS-Office365-Filtering-Correlation-Id: d89673ca-b4f8-43a8-1f6a-08dd1fa75efc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Zy9yS2ZMbGFqUE0yeURxZ3U3SFFhYWhQZUhqM283MERaUEsxWmdjYzJWY05y?=
 =?utf-8?B?dTFRaEdnRENlcXlNK3FTcXRDY2lNLzFOUXlQK1lxczFHWHdDQU5RbnE0Rm1Y?=
 =?utf-8?B?WjFPUkZRYUpVd2xYUWFBN05Ma1ZVbXBodk1XcmhiR2x0dTlaVW1KL3lPcDRJ?=
 =?utf-8?B?ekFtbzJTaTVZVURVWE5FeHZMaU5mUUUxOUd4V1N3cXBOZG9DeUF5ZElIWUxX?=
 =?utf-8?B?ZXBtNnZsd0IwdlFuL1hmU3NjZlZNTHYrRU5icW1DR0RMUE84SXIvUEZiK0Jh?=
 =?utf-8?B?Slh5VGprd0JjSFBENnpQQVFialMwQ0VqUVdvVkFXMXUva3dPcTI0b1c2YzZL?=
 =?utf-8?B?R05DakJDVXNQZ3Z6Q09odUp6clBsOXRBUU1FS0E4NWRHY1NQQ3FTb2w1cGxN?=
 =?utf-8?B?SEtoMFpJVDJ5V1VCZXptK2hSeGpMR0JlcWt6S1RaWFZTdzNaQ1FZWGpaekpM?=
 =?utf-8?B?QWs0L3VabFlNWFZnL1dEcElBZU5maFlIbTcvZ0x6dGJkTjdqSkJYVTVFNkMy?=
 =?utf-8?B?WFhxWHNuTEhZYlVWYWFHajZwSzY1OStLRXVQRms1anhESDAxS0xnKzhjN2h5?=
 =?utf-8?B?blJ2SDFiRHh1cmJxbWRkRDVFbThjSm9Nckx5Vjk3VE0zd3poOG83dzNJc0tQ?=
 =?utf-8?B?YnhMYVp4WEMvZVNWekRkSHBEZDBvNHlkb3ZMSmlvVWFTUk1ZRHI4aXpuUmxj?=
 =?utf-8?B?K2tySmhUNE5EODEzenAvRTJ3WjlHMHRlQ1hmZHBPbTh2SHNPZm54NEVlT2gw?=
 =?utf-8?B?T0xQakZFZi9RWS9veEJEbVNHSjdPRHB6bHNGVXJ6VXBpWGhXL1ZvU0RoZ3dD?=
 =?utf-8?B?OEpZUWRzYkFPeFdseGFsSm9aclAyRjlENVFqRkl3aS9nVXExTzNiQTJscHBB?=
 =?utf-8?B?Q0JsSnowNVpXY0xjTTcrQ2RPMkk3ZjBWYXJFU0R2Tm9pUkNwbEFLbkFkdFJi?=
 =?utf-8?B?Y1lPMjVldzZrSVRad0hCQ3BqWTZwWHFvQTdmbzIzMjMycUNoTFptbXIxT1NQ?=
 =?utf-8?B?SVVxK1VEaXVzQkxZbFpNNjhmUWZaVDFYb0cwK2I2MW1oQXVNOXlGbFIvZXd1?=
 =?utf-8?B?YVBnT3VQVUlxck9Qa3BMYmhsclpaQnJGMTg3RUQ5em5KNmtOZFdEa2VLZ3dD?=
 =?utf-8?B?SlR6Skd4N0pDS0IrcWZCbmdKTTlyVVBUWVhwT2tyUEFES1BOai90Qmpjbzdk?=
 =?utf-8?B?YTF1TVAwUVBmb2xITDhUMEhmV0lDTWdWNVkxdHBpMUZCb2N2d2phRjFobk9L?=
 =?utf-8?B?KytFUnY5NkhGanQwUDZJVW11WktXS1lrbk5jUysrN2puV1E1amZqMG80WXo3?=
 =?utf-8?B?aUtkYTRONEk0eUhKT2g5NUNEbHpHUm9FTjBGZW9sVjZodkVKSFpzNCtLN01I?=
 =?utf-8?B?Ri9GVml0eUtEaGczWWhSckkzOHBRSFVkelFWMzhlSkdVZkVmL0RCUFk0UlJm?=
 =?utf-8?B?Ukh1akZBVGhPRU5SUkR3ZnN3UlZIaUgwcGJjSkNqcnh6V0tlUWV3OVN4NEU0?=
 =?utf-8?B?aDhoRTlHK3pqY3dheWtXYko1dzBDYUhxaGRpOW50SERXN3lhRHNJNmp2ejlY?=
 =?utf-8?B?cnF6Tzl1Y0JNT2pPRUtjNjE2d210YVVZZmpSNUY3Q3FvNFVIaytNTStnWmhR?=
 =?utf-8?B?YSsxcUVBNUhlWERJdHcrV1FIZWhnSGFPVHd6eXdaZ25OR3ZWYmR4NXI3c0h5?=
 =?utf-8?B?aEc4WTltTVd4L2VKcGpqeHZFSHcvdWdVdnhQZ2xLa0JBTUpicWpacVg3WStT?=
 =?utf-8?B?Wk1XZjByS0N3N09RSmNoaXVKVFRwdkN4aWlqbjc5NXpRaTFEZ01vZlQvRnFs?=
 =?utf-8?B?d0V1a2k5ZHZCcmVyNkR5Mi9LLzNKeHhCbG5UOGhvdWRnMnIwVWlya2NYcWp4?=
 =?utf-8?Q?m5gPAxamJ/EXn?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RkxoM1pPTUhiK1htNkJzTXRhdnE4R0dUZnpUUEIwU2FsWnJQTXdKNkhuWnYv?=
 =?utf-8?B?WnIvMGIyUnNIRXhKZ2J1cWVxM05OSE5kbDBqTkpoYjlTeU9XdHdMK2tQWk1q?=
 =?utf-8?B?ZVYwM0QxckplUSt4VVpMU3g1Y2ttYVJ1RGRSNGFWWFVvdjJvbFpGVWlqd01T?=
 =?utf-8?B?cFk3dU55OHlTazJBRW5nT0Z0dU9HNG5OOWtVMVo0ODEvL3YrUWpXSzFRbkNZ?=
 =?utf-8?B?MUJlVXRxRGsyZUZ1VkVZY3N1ZEFiOXFlSlZ1eDdYYXdNMGYzU2p5aDUrbi9U?=
 =?utf-8?B?VVp3d0puTTZnSlA3Sjl3TWhVTWhxYkNQb1VDRjBIZnJJRFAvdmhhUDJTYzhF?=
 =?utf-8?B?bmtIKzFpdm0xanFkc09IMHppcS9kMjFlTThJR09jWVBpSXB3ZHhheURBWmU2?=
 =?utf-8?B?cWd5RWdzWUNlQ1JUT0FsSjdyUmlUL2M2c3BJWnJ3Z0xKSlpGaGUxcUtybnNu?=
 =?utf-8?B?ZUdIelhKSWRJNG9keG1jMEVXNm9jdWxwaUwvZ2lRZGFKM1dub2t5TUQzTGN4?=
 =?utf-8?B?UGRaZ2tneHVFTEIvQmxSR25jZi8rL0NFOFhCSVVEbDlNdnhVNlVJQlZ5WEh0?=
 =?utf-8?B?VTRDQnBSSklNbGNpVlVpYkNkc2pUUlZtV3N1MHFjd013OXJOU1BBM3p1TDBE?=
 =?utf-8?B?MmtVMW5OVUdRSnJjcXF5ckhPdmpLUHNqMlk3aVE0UUM1Sy9WbExvYzRsUzhp?=
 =?utf-8?B?Unlpc00zNy9MTWtDSkNHZTBNb3diTi9CR2drcTFTTy8xbEpYSm1SZEJTZUdi?=
 =?utf-8?B?MEkzdEIweCtHSWpFZ3cvcU8vNWJJd1pnbm5qTGJZQ3R4K3kzMy9tYU9FeWhx?=
 =?utf-8?B?YVVyL25jL0xoeVNhRFB3RnhWYlQzbXgxVXhHUFVKMDZLNGRmeFZMZm5iUDdj?=
 =?utf-8?B?MDlEaFVvdkpSVkZ2d1ZEbFQ4WmZtUmNzSnJLZ3B0TkJ2SmZMQlRUVmlMajRJ?=
 =?utf-8?B?WUdkRW1JVXE3dDdqdFNjNUgrR2N1ZXk3ZWZOWHZhaFMrMmVFdnZMSU5OMFFW?=
 =?utf-8?B?YklFS21lYTEwbGVyVHIyYnhJT04zaDZTL2dJbUpYbm1vV2FNR1NBS3I2Q3k3?=
 =?utf-8?B?U3RYMld6UXdzQlJOUzJjemYrckNIWlV3ZjNLT0kvYmV3L3ZDV0czUTBHS0kz?=
 =?utf-8?B?NEZvYjNYL1UvRDA0U3Y4N1QrYWpXbDJOZFkvRFJXWVRwRS9jSURJWFZERHBC?=
 =?utf-8?B?MFZtdS9IMm1rVU5YejNzb00ydEczcHprRkNLeVdkZWlTSVVJWmNJcklMYXJX?=
 =?utf-8?B?aXhacnMrcGlTQUF1TVplS0FZUDY2dDd0UCtFRlB0aldnQ3l3REExc2t5VHpC?=
 =?utf-8?B?b1BtQW1nUTFvWjljVmNMYStYUnozMHVZaDM3YjdaQzBnVWhtYnFxWFo1ajg5?=
 =?utf-8?B?Q1ZiYWhDUWZtVnYrdHFQU3FraVZLU3VJMGVWNDlYZU52bFkyRU5RZkVNZ0oz?=
 =?utf-8?B?a2IwRFNrc1NMckUxMTdGbGxmSEJ2Ly95OC9JVEFjSkU3aDE1WTJpeEgrbGM0?=
 =?utf-8?B?c0dlZjhjM1lEcUhTQ2tnRTB1elFzVndFMXRVT3ZaK3pUTkpqMGRkUkNScHFW?=
 =?utf-8?B?RUFiaVJJekpWdkNmZlZ2TjFQbXFCK2VBb1haOEEybGRweXRqVzJKYngvTm9N?=
 =?utf-8?B?TTVicW1NYy9EYUIxM01IU0FaQktYME9ZSDVvRTVUTXo4UnNndWZkcXJ3UVln?=
 =?utf-8?B?dFZENEE1MzR0bjd6eUtCRVJSbGp6Q2l4bXVjRmJEODhVT24vTDlyMmFXVXRX?=
 =?utf-8?B?b1RLcHQ5Z2ZiNVVpeWZnK1ZSZTRIRWRadi94ZmI3N1ptNkNXay9Ub1NDY2F6?=
 =?utf-8?B?bmlhMjF2MWRjcnpqUFMxWkZ0dFhuM3owcThlc1JuOTcyOWtyUWIyQmU5dUdz?=
 =?utf-8?B?bjZaQ3hPUVdzbWhoMVJhcUZIWm1iSEZxNDBoVmZFYTBEdFNNQllkSFFpMGhr?=
 =?utf-8?B?MXROYWRZWlFUZ2d2K3BHcS9OdVFQbXJOQ3pSekl4Y2Y2TmRwREhRMWZDMTdP?=
 =?utf-8?B?dlBJdmk4V2dITUdFbWUxVWtaWUFHZEZaaStZRStaRUJ5ZmdsVnA5T2VBTThN?=
 =?utf-8?B?UjREa25lOXJQcXRqdFNhaTcxekQ2czBFVE5UTVg4azJoa3RGRnB5aTdOMmQ4?=
 =?utf-8?B?Y3U4bFpSM0o4aUxxRy9UTXExblBIaDYrTlBpa0xnMkFLcWNldWpmeEZ4UzFP?=
 =?utf-8?B?MEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Z6LCAzOqiUO72HADlqqbFdWMXKp37L2uKKOrPYrnoj6jIF4b1sHI8DIgLlNU+xGXisequXpobpxL+Vj9vDE2E3KkKUAIopb6GLoc1VeH7pTE5ykYcT6Olyxb1aqKjbhgOV9Y9DgaBeBmcL1Cykjj4cB4W/kC5nrkX2TW+OSlCUrQAfD0FMSLeOeXzZ1EvLrG92dPf3bypE0aplBnMGz+bAD4S5mpQ3CQwRrjCU4C1fSes3NylBZOP/NSHhhXNJfZrHAc4xBtadLhMlZv9dp3tm7um6WX5aOmrtne5eijBTRRNUJgzy0UsRuXMPoZn4uAHWkvVoAheuleaYNPPENZOxpuG6hhVprzbZkTFxipX+z2ASJmEnWQ39ZSbSfF6PQ/Nt3u3br/+sNa0fATndzCsldLAylk+ZJs7hHP2ku8iVpQf7ZlH7kZcauqvTOLgSd4/NUXSf2yiLGSEB7aSUT8q7DSuNIMHrDsb9oU4moRQBanTo2ERacvF7VfFuL2DBp0GU2MtxDaQ6J3WveQnXjYQFOKm4Tvdnb3/Ygsej7gNV0xBUDDPyY2GgpNp0baYBy8XyRgps8EibgfejA7lXq1MgyIVFzfH/yyqNtjIz3Psqk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d89673ca-b4f8-43a8-1f6a-08dd1fa75efc
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 21:03:07.2416 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VxtM8liI2GX3wS2EIetLulsqubCYypNq+id2c3TB/z/pnX7J0aheT9iJw+QcM5F5ZHJ8IWaarKpuiuuPHW0NoL32tX3cd91s1Dqf6TRAqGo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6763
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-18_07,2024-12-18_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412180164
X-Proofpoint-GUID: oNPK4Pqq_cwR9wyo8yqhMPjMaTjqc1rS
X-Proofpoint-ORIG-GUID: oNPK4Pqq_cwR9wyo8yqhMPjMaTjqc1rS
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

If someone is bored, this needs review, else let it ride until V5.

- Steve

On 12/2/2024 8:20 AM, Steve Sistare wrote:
> Add an option to defer making the connecting to the monitor and qtest
> sockets when calling qtest_init_with_env.  The client makes the connection
> later by calling qtest_connect_deferred and qtest_qmp_handshake.
> 
> A test cannot specify port=0 for a deferred connection, because qmp_migrate
> cannot query for the assigned port, because the monitor is not connected
> yet.  However, even if the test does not specify port=0, qmp_migrate ->
> migrate_set_ports unconditionally queries connection parameters.
> Modify migrate_set_ports to only query when port=0.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>   tests/qtest/libqtest.c          | 80 +++++++++++++++++++++++++----------------
>   tests/qtest/libqtest.h          | 19 +++++++++-
>   tests/qtest/migration-helpers.c | 19 +++++-----
>   tests/qtest/migration-test.c    |  4 +--
>   4 files changed, 80 insertions(+), 42 deletions(-)
> 
> diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
> index 817fd7a..31c4032 100644
> --- a/tests/qtest/libqtest.c
> +++ b/tests/qtest/libqtest.c
> @@ -75,6 +75,8 @@ struct QTestState
>   {
>       int fd;
>       int qmp_fd;
> +    int sock;
> +    int qmpsock;
>       pid_t qemu_pid;  /* our child QEMU process */
>       int wstatus;
>   #ifdef _WIN32
> @@ -442,18 +444,19 @@ static QTestState *G_GNUC_PRINTF(2, 3) qtest_spawn_qemu(const char *qemu_bin,
>       return s;
>   }
>   
> +static char *qtest_socket_path(const char *suffix)
> +{
> +    return g_strdup_printf("%s/qtest-%d.%s", g_get_tmp_dir(), getpid(), suffix);
> +}
> +
>   static QTestState *qtest_init_internal(const char *qemu_bin,
> -                                       const char *extra_args)
> +                                       const char *extra_args,
> +                                       bool defer_connect)
>   {
>       QTestState *s;
>       int sock, qmpsock, i;
> -    gchar *socket_path;
> -    gchar *qmp_socket_path;
> -
> -    socket_path = g_strdup_printf("%s/qtest-%d.sock",
> -                                  g_get_tmp_dir(), getpid());
> -    qmp_socket_path = g_strdup_printf("%s/qtest-%d.qmp",
> -                                      g_get_tmp_dir(), getpid());
> +    g_autofree gchar *socket_path = qtest_socket_path("sock");
> +    g_autofree gchar *qmp_socket_path = qtest_socket_path("qmp");
>   
>       /*
>        * It's possible that if an earlier test run crashed it might
> @@ -485,22 +488,17 @@ static QTestState *qtest_init_internal(const char *qemu_bin,
>       qtest_client_set_rx_handler(s, qtest_client_socket_recv_line);
>       qtest_client_set_tx_handler(s, qtest_client_socket_send);
>   
> -    s->fd = socket_accept(sock);
> -    if (s->fd >= 0) {
> -        s->qmp_fd = socket_accept(qmpsock);
> -    }
> -    unlink(socket_path);
> -    unlink(qmp_socket_path);
> -    g_free(socket_path);
> -    g_free(qmp_socket_path);
> -
> -    g_assert(s->fd >= 0 && s->qmp_fd >= 0);
> -
>       s->rx = g_string_new("");
>       for (i = 0; i < MAX_IRQ; i++) {
>           s->irq_level[i] = false;
>       }
>   
> +    s->sock = sock;
> +    s->qmpsock = qmpsock;
> +    if (!defer_connect) {
> +        qtest_connect_deferred(s);
> +    }
> +
>       /*
>        * Stopping QEMU for debugging is not supported on Windows.
>        *
> @@ -515,34 +513,54 @@ static QTestState *qtest_init_internal(const char *qemu_bin,
>       }
>   #endif
>   
> +   return s;
> +}
> +
> +void qtest_connect_deferred(QTestState *s)
> +{
> +    g_autofree gchar *socket_path = qtest_socket_path("sock");
> +    g_autofree gchar *qmp_socket_path = qtest_socket_path("qmp");
> +
> +    g_assert(s->sock >= 0 && s->qmpsock >= 0);
> +    s->fd = socket_accept(s->sock);
> +    if (s->fd >= 0) {
> +        s->qmp_fd = socket_accept(s->qmpsock);
> +    }
> +    unlink(socket_path);
> +    unlink(qmp_socket_path);
> +    g_assert(s->fd >= 0 && s->qmp_fd >= 0);
> +    s->sock = s->qmpsock = -1;
>       /* ask endianness of the target */
> -
>       s->big_endian = qtest_query_target_endianness(s);
> -
> -   return s;
>   }
>   
>   QTestState *qtest_init_without_qmp_handshake(const char *extra_args)
>   {
> -    return qtest_init_internal(qtest_qemu_binary(NULL), extra_args);
> +    return qtest_init_internal(qtest_qemu_binary(NULL), extra_args, false);
>   }
>   
> -QTestState *qtest_init_with_env(const char *var, const char *extra_args)
> +void qtest_qmp_handshake(QTestState *s)
>   {
> -    QTestState *s = qtest_init_internal(qtest_qemu_binary(var), extra_args);
> -    QDict *greeting;
> -
>       /* Read the QMP greeting and then do the handshake */
> -    greeting = qtest_qmp_receive(s);
> +    QDict *greeting = qtest_qmp_receive(s);
>       qobject_unref(greeting);
>       qobject_unref(qtest_qmp(s, "{ 'execute': 'qmp_capabilities' }"));
> +}
>   
> +QTestState *qtest_init_with_env(const char *var, const char *extra_args,
> +                                bool defer_connect)
> +{
> +    QTestState *s = qtest_init_internal(qtest_qemu_binary(var), extra_args,
> +                                        defer_connect);
> +    if (!defer_connect) {
> +        qtest_qmp_handshake(s);
> +    }
>       return s;
>   }
>   
>   QTestState *qtest_init(const char *extra_args)
>   {
> -    return qtest_init_with_env(NULL, extra_args);
> +    return qtest_init_with_env(NULL, extra_args, false);
>   }
>   
>   QTestState *qtest_vinitf(const char *fmt, va_list ap)
> @@ -1523,7 +1541,7 @@ static struct MachInfo *qtest_get_machines(const char *var)
>   
>       silence_spawn_log = !g_test_verbose();
>   
> -    qts = qtest_init_with_env(qemu_var, "-machine none");
> +    qts = qtest_init_with_env(qemu_var, "-machine none", false);
>       response = qtest_qmp(qts, "{ 'execute': 'query-machines' }");
>       g_assert(response);
>       list = qdict_get_qlist(response, "return");
> @@ -1578,7 +1596,7 @@ static struct CpuModel *qtest_get_cpu_models(void)
>   
>       silence_spawn_log = !g_test_verbose();
>   
> -    qts = qtest_init_with_env(NULL, "-machine none");
> +    qts = qtest_init_with_env(NULL, "-machine none", false);
>       response = qtest_qmp(qts, "{ 'execute': 'query-cpu-definitions' }");
>       g_assert(response);
>       list = qdict_get_qlist(response, "return");
> diff --git a/tests/qtest/libqtest.h b/tests/qtest/libqtest.h
> index beb96b1..db76f2c 100644
> --- a/tests/qtest/libqtest.h
> +++ b/tests/qtest/libqtest.h
> @@ -60,13 +60,15 @@ QTestState *qtest_init(const char *extra_args);
>    * @var: Environment variable from where to take the QEMU binary
>    * @extra_args: Other arguments to pass to QEMU.  CAUTION: these
>    * arguments are subject to word splitting and shell evaluation.
> + * @defer_connect: do not connect to qemu monitor and qtest socket.
>    *
>    * Like qtest_init(), but use a different environment variable for the
>    * QEMU binary.
>    *
>    * Returns: #QTestState instance.
>    */
> -QTestState *qtest_init_with_env(const char *var, const char *extra_args);
> +QTestState *qtest_init_with_env(const char *var, const char *extra_args,
> +                                bool defer_connect);
>   
>   /**
>    * qtest_init_without_qmp_handshake:
> @@ -78,6 +80,21 @@ QTestState *qtest_init_with_env(const char *var, const char *extra_args);
>   QTestState *qtest_init_without_qmp_handshake(const char *extra_args);
>   
>   /**
> + * qtest_connect_deferred:
> + * @s: #QTestState instance to connect
> + * Connect to qemu monitor and qtest socket, after deferring them in
> + * qtest_init_with_env.  Does not handshake with the monitor.
> + */
> +void qtest_connect_deferred(QTestState *s);
> +
> +/**
> + * qtest_qmp_handshake:
> + * @s: #QTestState instance to operate on.
> + * Perform handshake after connecting to qemu monitor.
> + */
> +void qtest_qmp_handshake(QTestState *s);
> +
> +/**
>    * qtest_init_with_serial:
>    * @extra_args: other arguments to pass to QEMU.  CAUTION: these
>    * arguments are subject to word splitting and shell evaluation.
> diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
> index 3f8ba7f..9f39401 100644
> --- a/tests/qtest/migration-helpers.c
> +++ b/tests/qtest/migration-helpers.c
> @@ -127,25 +127,28 @@ migrate_get_connect_qdict(QTestState *who)
>   
>   static void migrate_set_ports(QTestState *to, QList *channel_list)
>   {
> -    QDict *addr;
> +    g_autoptr(QDict) addr = NULL;
>       QListEntry *entry;
>       const char *addr_port = NULL;
>   
> -    addr = migrate_get_connect_qdict(to);
> -
>       QLIST_FOREACH_ENTRY(channel_list, entry) {
>           QDict *channel = qobject_to(QDict, qlist_entry_obj(entry));
>           QDict *addrdict = qdict_get_qdict(channel, "addr");
>   
> -        if (qdict_haskey(addrdict, "port") &&
> -            qdict_haskey(addr, "port") &&
> -            (strcmp(qdict_get_str(addrdict, "port"), "0") == 0)) {
> +        if (!qdict_haskey(addrdict, "port") ||
> +            strcmp(qdict_get_str(addrdict, "port"), "0")) {
> +            continue;
> +        }
> +
> +        if (!addr) {
> +            addr = migrate_get_connect_qdict(to);
> +        }
> +
> +        if (qdict_haskey(addr, "port")) {
>               addr_port = qdict_get_str(addr, "port");
>               qdict_put_str(addrdict, "port", addr_port);
>           }
>       }
> -
> -    qobject_unref(addr);
>   }
>   
>   bool migrate_watch_for_events(QTestState *who, const char *name,
> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> index 64e1c50..b7001b0 100644
> --- a/tests/qtest/migration-test.c
> +++ b/tests/qtest/migration-test.c
> @@ -844,7 +844,7 @@ static int test_migrate_start(QTestState **from, QTestState **to,
>                                    args->opts_source ? args->opts_source : "",
>                                    ignore_stderr);
>       if (!args->only_target) {
> -        *from = qtest_init_with_env(QEMU_ENV_SRC, cmd_source);
> +        *from = qtest_init_with_env(QEMU_ENV_SRC, cmd_source, false);
>           qtest_qmp_set_event_callback(*from,
>                                        migrate_watch_for_events,
>                                        &src_state);
> @@ -865,7 +865,7 @@ static int test_migrate_start(QTestState **from, QTestState **to,
>                                    shmem_opts ? shmem_opts : "",
>                                    args->opts_target ? args->opts_target : "",
>                                    ignore_stderr);
> -    *to = qtest_init_with_env(QEMU_ENV_DST, cmd_target);
> +    *to = qtest_init_with_env(QEMU_ENV_DST, cmd_target, false);
>       qtest_qmp_set_event_callback(*to,
>                                    migrate_watch_for_events,
>                                    &dst_state);


