Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B630C3ABDD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 19:09:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uH5qU-0007RP-K0; Mon, 19 May 2025 15:08:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uH5qS-0007Qy-I4
 for qemu-devel@nongnu.org; Mon, 19 May 2025 15:08:16 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uH5qK-0005xb-TG
 for qemu-devel@nongnu.org; Mon, 19 May 2025 15:08:11 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54JGMpDI026238;
 Mon, 19 May 2025 19:08:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=x9gfKi9s6JhRGNcD6sFQMAHSTD2LPWSQvvkmIEKDNwk=; b=
 Bh5riqZSuhqA5RybkLyJE8rA1UI+fLUmWNcVo5cdga1AqHWXY9A6X0cDOayrB2Hd
 Q4vfTmQ2FvcQQIPBFgMahef85LtfVfzpPtGsqbyz1ZxhhdfsnBaEx1qlwAudZDAy
 az6rLiZMvyVrczJMY6oLy98XuZOnYh14luRkPjYMp6NWfanh4U3isEnq9WEw0Im0
 aMEeuaDq8w2+OXXBjdmTHbUQCTUB2Tpi+ZQSDjMjL4xMsSS/l4IdpIW6AwPZLRYj
 wYenKfYRhAu4AY2KTFWUk04262QPFda65ZgkOuPgP/VX6n8jVriNDFOOncjEIIIu
 p2hLQfDpbKJKMPU/EgMw6Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46ph84kshn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 19 May 2025 19:08:04 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54JImKDZ015622; Mon, 19 May 2025 19:08:03 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46pgw6u9nx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 19 May 2025 19:08:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LO6JgdyA0rLR2Pt2wrif2pXX/D8Sxzo8mGbFMKZnRbWVXGrEx6W4y9CyeytWiSOwFrF8DU3QFjKAlMEoG4MAkiG3CuyvBgY6xl9Kd728UhejUrs4B6Lf49UK/1rsnTgqtai1Nzkj+dHI7B1NO0lG7Mg256yU1Lmixw4rrhpwtoE45ea/UzaCDunJw+O28gaA66XexqYsC1MyQg+kCPzfk7ui5P0MOABYVso6sIZSsAU+eTXrO7rlr3LChExKfWNG/19xjT0hYXXqPFzrz8wZEURgOUOBHLfvXDEiNfTv4gKspaFORD9LOscKfnQ0QsiCk5WWH7wXGsXjj9jj5WTeOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x9gfKi9s6JhRGNcD6sFQMAHSTD2LPWSQvvkmIEKDNwk=;
 b=iLKSswz28RFaZtFDDDLSzFTTVAI0LzSvPGfZv9VLSpfSnE8ArIavMZGqKQP+7fPFpGHTVG51UXJNi2NFzn46TqffhMANM8O65RQrw27cw9c4nA1j1+kOHMtMzHFjT2lLpH3lt5eoczFy5u2A76gyRnTt0mEVWlvKIzX9rbeXfA68k1+Vx9bGQgQZBa08+iBAlcNZPDbW800jMx5CHlEe0PFpKKYY5i4a4XnUtKfHYbYrRsNXtUfrDxMfhsOA0tBU/mdNIz3Rtq/riRh/J728qPjjg75GapERBREPZCEHrWJEObYjUo6EeUF2fGsekyeSEDKhg1CTpmxclXLxvj5jjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x9gfKi9s6JhRGNcD6sFQMAHSTD2LPWSQvvkmIEKDNwk=;
 b=R+VLssqr4dlTgerPjsIa9akPD46zPpe3mNbblIyOPoKojH4ckKEtRFBNFEl4yqDkdEJahnQkhoCnZbWUkVhe+rdUeWK1ky9JWKXM/aHhALdgSp248zWWqcYcp6yguK9kEq49xh2107+O9BtegEpuSeISz17N6XxJfFbLPpyla8I=
Received: from CH3PR10MB7436.namprd10.prod.outlook.com (2603:10b6:610:158::7)
 by CH2PR10MB4117.namprd10.prod.outlook.com (2603:10b6:610:ac::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Mon, 19 May
 2025 19:08:00 +0000
Received: from CH3PR10MB7436.namprd10.prod.outlook.com
 ([fe80::dfba:d89:d13d:cd54]) by CH3PR10MB7436.namprd10.prod.outlook.com
 ([fe80::dfba:d89:d13d:cd54%5]) with mapi id 15.20.8746.030; Mon, 19 May 2025
 19:08:00 +0000
Message-ID: <8617760d-04cc-47c6-86e3-cf9878e4b348@oracle.com>
Date: Mon, 19 May 2025 15:07:57 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 24/42] migration: close kvm after cpr
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
 <1747063973-124548-25-git-send-email-steven.sistare@oracle.com>
 <9a664228-9a00-4387-b2d0-f7a428b52c75@redhat.com>
 <fb047fe4-1a8d-42c5-98c2-28adfee0f23a@oracle.com>
 <ae7710bc-2877-44bb-b122-7df7ed564b22@redhat.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <ae7710bc-2877-44bb-b122-7df7ed564b22@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0415.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::30) To CH3PR10MB7436.namprd10.prod.outlook.com
 (2603:10b6:610:158::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7436:EE_|CH2PR10MB4117:EE_
X-MS-Office365-Filtering-Correlation-Id: eff8d0fd-9f57-4414-e910-08dd97087908
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eDdxaEYxVTlOYXEwRytHR05LOG96eHpXWjdDcEpqTFZtdVZVckF3MzE3MGsx?=
 =?utf-8?B?SzZ3TTZMYkEwKzlLa0tqcnM3bGgyRmJOaHplTTFYTzlGc0ZhZ0Zub3NJZk1O?=
 =?utf-8?B?TW9XZS9SVHhCdjlPQnhBcnRwVFhENDFlSVhFR2FWTWlkQVNOQlZJWlF1bTJY?=
 =?utf-8?B?bjFlKzdhNU85RnpUNDQyN0IwRlVPellnZGI5a2ZDR3BGOFg2TWplRFNsWW1E?=
 =?utf-8?B?bDQ2U09QNnF2OC9tWnhSTzRwVXVabkNoMGxyb2dLaGxnZnMzaTdsdFh4ZjZJ?=
 =?utf-8?B?TGlMbU0xMzdMeVJUZ3lQc1lOQ0pzZGlzZGs2dTk1SXZIbGNkUU1lZmNLUHV1?=
 =?utf-8?B?ckk0WTRwVEsxNzFBb01sdnJ2Q3dSZ2FuTlBhOE1HTmY3TXpITElmZ2wvZXJy?=
 =?utf-8?B?TmErbkRlUFFqWlp2ZHlVd0htV01sczhlNzcvR29nckkyWjZtT3QwWGRZNmc1?=
 =?utf-8?B?OHhPbUVtRnYzL2sybDJVRi9IcUZxQUtDckJyS3FIWEhnQlRXN0xRcHZpcThT?=
 =?utf-8?B?WEhESHQrbkt2RnNGcXIrZnVzYWhaZS96RmFwbXJmZUkwN0VxVVUxRmM3cnZh?=
 =?utf-8?B?QTEwVzdIMlBNZHBvNHdob3hwRFZFSXQxYVhILzdOZzZ6MDdpRDE3RlF6ajRU?=
 =?utf-8?B?dk1XSXd6RW51MFNCblNnODhVZXRhOUp1WVZPL0N2U0prZUJLb0lNcm9xOUtI?=
 =?utf-8?B?TTFWSmVlNUtDOXRHTldLS1RLTERBOGZsVW1hTXNCTjkzUGRoa1dVa0VPekZH?=
 =?utf-8?B?ZElyRVZlbFk0R3dreWJpeS93NVFyZWQvRFl6Y1dIWlhnTXVQcEczK3NzUlZq?=
 =?utf-8?B?bElNc0tMNVQ0ekZFWDhITmpWdnpnVmJ4d2xFYmYxdHZ1V3ljNEVUREcyb0xm?=
 =?utf-8?B?bksrbGlOR0ZmdVR6bVVIUXo1WmMwWnEvbEt0V2E4cXpEVkVxeGRhVTFqZ2JE?=
 =?utf-8?B?UHg2TFF3OUlzeFIwcm1GSS85OHY3V1Qzc21nUXFTMmYzdkxtYWUvc2ROZmJO?=
 =?utf-8?B?a0lHVnVUazZnSTcyNEVMS3lOT3dHS2EweFZidXNGV1pKck5DTFZseW9HVWda?=
 =?utf-8?B?Vno5blZLWHM1K1VYVDhUMVFMYnRuWGI4dzJ2UW4rM2JxSHB6UVNWQXhHUW5n?=
 =?utf-8?B?SWZFUE11Uzg1U25YQ3drbm9YcUNQODB3ZEJGQWNvZWJUZ054NWxNWU16ZWN2?=
 =?utf-8?B?SnFucDVpSVF4cGpNU3F5eGMwTE0zRFNJcDFTQ2lPeVV3N25pbEhpcUtBejM0?=
 =?utf-8?B?ajFFbXBNV1RBTm9yZTYxTmJQWXhxWllHZ2FwSVVYalNnbFVtUS9SeXNTRDVG?=
 =?utf-8?B?QXJybXVod3U3WU15VURJY09jVk1uSmRLZjVQek81ZHlSUEFIaWNuaHRad3Jv?=
 =?utf-8?B?K2NTRVlxMUNTTkpzVFpVd3NSTGFKWmJZQm85ZFVHcjVUQlVJUkd5cllvZk5J?=
 =?utf-8?B?ekdYNVNpK3VtWGNyQ0ozTzllbXlXbXlYbm44MmV3ODNRKzk2aUdYWXR6OEhB?=
 =?utf-8?B?RjU3SjF5YzdPVFQyd21YWDV3SVlVQ0Vna0tjS004QjhhZE5teFJISHdudHRa?=
 =?utf-8?B?RmI3ZU1nbStub3ljTkd0THBKKytHT1Q1Q3FuVU45cUpuUTNjdEpwVTU5QXFJ?=
 =?utf-8?B?NmxwdVo4TnJCVU15NmZsUkhpQ2dnTlFuSXJtRjdHR1crTVNwc3pHMmVNSU92?=
 =?utf-8?B?N0ZTZ1dmTkJzUmZaMEQ3djl6RllGdFJ1SjM0YjlTMStPV25ucFVKbnRWT1k4?=
 =?utf-8?B?YlJOZ2swZlFxbU84MVMvUzJVZ3NMOFMrVVZWZVFHYUZ2RlljY3p1QUptTFFi?=
 =?utf-8?B?LzZqOVpCNm50K042OXlOVlFYNFRGM0FMRVpQMkY0VWRjTW80SjdhUmUrNlEw?=
 =?utf-8?B?TklQQ1J4RUdtS01SOGZLRGhaWDY0TCsvQ1JJTUxwMlFseU93ZmZoaTBLQnlB?=
 =?utf-8?Q?rjxe+31fn+A=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR10MB7436.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U2F0amVlbWFSV0J5MVhXKzhuVDdUYjVnUkExeU1leS9oK0NGYis0MWdOVTIv?=
 =?utf-8?B?R3NZU25mMXpaM203S3NWRlI5OUJXb0ZHRmIvMlVMY0NsZ0N5WW44N3hnRm0y?=
 =?utf-8?B?UFAxOFUzMzdaZ2s1cm9scnVDdFhYUHhNODEreUhlcmZRZVZZeCt0TWxiYnpF?=
 =?utf-8?B?b1dVZGx4dlRqODA4YnlFUTVEaGFzcEFqRVdlc1VtMFp0Q3IrSnFmQWRuTVVx?=
 =?utf-8?B?U1YraENUWHlJcWQzVmJvaFJoWWFnL1k3LzdoM29BRVFNMTB4aEhqWGlmWXAr?=
 =?utf-8?B?ZWNVSW9rUk5OcVBjTDVGdmNGazFLQWNmeDVoa0crWUgvS3M5aFhjMW5wOFY3?=
 =?utf-8?B?c0dSVWhDK1d3Q2hkY3lnZUloUWxjQ1ZSQlpyYkQ2TmhEWWdTNVgrYjFtdGZY?=
 =?utf-8?B?WFVyR2VDbzM2dGdBRmlycS80SE9oUzhPQkJRNTVRbW1RUTJqMmF0TXhGTE5L?=
 =?utf-8?B?WjJkcFZqWjV0eGZxTUVLLzI3TnU5QUkraXg0MGJZQWhFdCtnbjQrdnN6QlZ4?=
 =?utf-8?B?UHZDdzhwL1lXdXI4WDBTdDBFWmpCRlZtK25sMFc0OVhXVklRZGMrQUhMaHZN?=
 =?utf-8?B?ZEJ5R25rMjU0MGk1by94VHlwUERqa1BFbU50bW9tS0ZSNjhhRjMwaUhPUjYz?=
 =?utf-8?B?V2pPcElzRStWbkprQXNueVZCT2hXK3B2aTdzNUplYkVQM0xYQ2JWMkxaN1lp?=
 =?utf-8?B?Z0NuZVBIWkhZOXBMTXpYaVBTaFUwWlEyY1YraTBuZ3VHbjdJZEV1NzJNaXl3?=
 =?utf-8?B?TG8zbWlLanlRRDAycjN4d3Y4WDFKeWt2QjFYcjhVQmZvWndaeUpxVVMrSVAx?=
 =?utf-8?B?b1o3U3JEbWk0cC9MZklsbFRWeVJBMVRjYXFpWTgzMTFJMnh5aXkzZjFCNmVN?=
 =?utf-8?B?L0NwWVNTRllWcHBPYlBOaDRpbExSM3I5Qy93UzRLSTNZQk9kdlRpU2d0WTVa?=
 =?utf-8?B?anlMZ1pXTnZIUTRFbkpjc29WWklGVVFSUjI2bno3b1B5a1Nub1pNYmJSbjlh?=
 =?utf-8?B?ckxjKyszNjkzNmM0bjZKRnVRKzk0UVBmNThqeDV1a2MyQzZRZGVqbjJ3YXl3?=
 =?utf-8?B?TDBDZ1QvdWZqeUVLUldJOXRMRC9MbCs2ZmJZeTJCQS9DcGVUYWxaczJTNktj?=
 =?utf-8?B?cm9JUWI0bWtYTkphemJTa3RZUWVDU2Z6d0MyTnltRHg1K1pnY21kUWFFUno1?=
 =?utf-8?B?cWJ6ZXBwb01FZlBsN0dhbmMxYVVqQmlrSmEwdmJEbStVNEFseHdXT3R6YlJM?=
 =?utf-8?B?OC9Dd1g2WVdxWHQyYVpvditvb25aMGwwaVpUWENIaWszMFUvN0pydytFdVNE?=
 =?utf-8?B?NTJncEJSZHpZZnlDcHVKdDlkM2N4YVNsY2JPZmdEakpFOWNDR2tMV0d0N3Bh?=
 =?utf-8?B?c2JOcmVMVzFmSVRCTnU0OGNUTnlqbStmbDdOYlRKWmorbC9GZTFWeXgvamFU?=
 =?utf-8?B?WHhmckdIVFlkMWZrNDFhbHlkRmFaQWhXU0I5aEJzOFAwU2dLR1Mxd1RxZ3RE?=
 =?utf-8?B?MENGWEtaQlcvbHQyM1hWbWVWMEZvdlppeTNVTkJwZW1oSkUzbnFMajdKY1BZ?=
 =?utf-8?B?Wkh2aldTNHVYUmNTekhVcUw3VTZaUWNBaEozK3dGTXRHMWx2WitBemRkY0sw?=
 =?utf-8?B?VTZObktGNy9FQ1BsYS82U2RNZzU5Q2pBTlNHUkdaOUVFTkpMdWREVEl1QSs5?=
 =?utf-8?B?b3I5ZHNpQmtwRkwwcFMvQ0l5cEt1OTU3WlNUSU9Ic0R5Z1N0S3AyR09zWUpD?=
 =?utf-8?B?Nk9WN21IZ1lNbmZ2d3grYXZTU0Z3QlRyZHpvRkI2QlEwNElsSTlSa3YyRlYw?=
 =?utf-8?B?elQ5cStubXF2SjF6LzhkUGZBbG9XbURXcmxkMm14NnllL1E5MnJrU3QzaG5H?=
 =?utf-8?B?YUlzSUlsR3ZSYThCN0xvNCtRZHF5d2NkbFpDR0RVREROUzJJTzJ3cHQzN0xy?=
 =?utf-8?B?aXhpRU83bWxya3JZUWlEdWFCVTg0NGlqcCtrSFhiZVBnQmlTL0g3V2xUQ0g5?=
 =?utf-8?B?QWwzd2ZUVHRSSVhQWUtrSEl0WUlsQVdDejZNUVhDKy9LZTFwRzg4MUxucXEx?=
 =?utf-8?B?cHZxQklReVVXanFlRWhsN0ZrMS9JRTc2ZEdWUldKQ25EWTN6ZE1yWEN1Tkpz?=
 =?utf-8?B?bnU0MlliTjl5OHN4S2FCWHk4VS9YUzEvSDFqTElvZjVzc1ZQODJiajEvb3Qv?=
 =?utf-8?B?a1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: EAwsC0bMRvAljhEHRIr7703RliY8UlcJABXhHJ65SfAp1hXgOh/2R+BWWMMyj+74Br9aHpfaL3H9J6g73ZSdtqkc1BLwlYP+zpiGrfUI65a34asg6GZtDuBsfeyrqpWD3KuVmnXGfcFtCWXELQj+2RLMzi9tH7tXHUKJ+kUJxRMFilEprGrwSpC5A+HtkyF1s1NHB5FD5X5YarARKGxj2b5NM/8Q3JlGw4R5hkNRMLXsUPW0pNTv6yNmtQhBWXat8XWBQJEfEE3z3Az4rVcsUuUTbtnib5VUcaGwtd/Vvx/pqTDyEW1X4cqwOS4NAlE3AbrcN1IYhC8VqUjkdaeah8yayAL7hKGvrCOYaj5ZyN4F+rgd4LSa7MLpZIeTT7Buw54V0z0YyZL0Z/Nm/6x74hD6NBVoLDvBBeaNVOP463O3F64OpkwQZJpi+U4+4io9vUNGd6EmwWvIgsd+KvAGEBeCYdtdD8L/Xco7WFb3lQiOFxR+UHiX+q30da9upExnVpB0niU5uKbF6zCRYFvS6Wk3x4eYNHYlI3zdQ3FrvB4oqLaxrnjz8fbEzR48uTTgWzJWcGsY9utYhHv3HEcS8hEaXx7R/fO0iiyKQUNqIOM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eff8d0fd-9f57-4414-e910-08dd97087908
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7436.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 19:08:00.4895 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3svoQ1nmeaq8XYDFUjtJvxudKWtP7LSDi+WeWAclWSNU25Iqber4nuZtnDFU1BE+NI2Rn632Zu8SP4MX52f6l5r9Kg/1Bm+or8PmM3SA+kU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4117
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-19_07,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 suspectscore=0
 bulkscore=0 mlxscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505070000 definitions=main-2505190178
X-Proofpoint-GUID: FoI7FNAwB2MNIczX8IhF7DFyENj-4-Kl
X-Authority-Analysis: v=2.4 cv=YPSfyQGx c=1 sm=1 tr=0 ts=682b8194 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8
 a=DR8wvm7e1ded8gbxCVoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: FoI7FNAwB2MNIczX8IhF7DFyENj-4-Kl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE5MDE3OCBTYWx0ZWRfX1FkEuYCrAUoL
 OtBstG4xwhmME94uFLAJXaflQ3ubUZBG/rtckNl6pDjwCb+eJlUdMBhmzZuOT8R0d4ZKZUHoXWc
 K1OVdKSM4B79lOzCmZWi7XUlcNolWXEZSPpdogNc6i05tfmb/PmqKMDWNSntIwdHpNsmSEEnZqo
 av1gfVy1rfLj1ieT3TiYmhntSFE39fxMga6gRkZ33O2+VBQnwHtLlHBUrX/TLEp+SCFQo6jscAJ
 iyKuZMUtl0Zi9mhT2ypGLkAbtgk8hmO5VXjB4yXJmQDpWGyjaZahLsTAZJ7eYrPd1foQp50fOHj
 OxNWFpT39E7KtunOU6hxiXBJk6HMYt2CLRO1JRMTQ1KyGwgsrWrVanMyu88LEOEFS4grjLE/735
 5QMGUEdvBvJ/GxmaslE956I/e7Uz0vAbbbhFxP/4CSSusgpcwW3IoXpgcAQM7A+YEaj+Dl0S
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On 5/19/2025 4:51 AM, Cédric Le Goater wrote:
> On 5/16/25 20:18, Steven Sistare wrote:
>> On 5/16/2025 4:35 AM, Cédric Le Goater wrote:
>>> On 5/12/25 17:32, Steve Sistare wrote:
>>>> cpr-transfer breaks vfio network connectivity to and from the guest, and
>>>> the host system log shows:
>>>>    irq bypass consumer (token 00000000a03c32e5) registration fails: -16
>>>> which is EBUSY.  This occurs because KVM descriptors are still open in
>>>> the old QEMU process.  Close them.
>>>>
>>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>>
>>> This patch doesn't build.
>>>
>>> /usr/bin/ld: libcommon.a.p/migration_cpr.c.o: in function `cpr_kvm_close':
>>> ./build/../migration/cpr.c:260: undefined reference to `kvm_close'
>>
>> My build works.
>> For what binary does this ld command fail?
> 
> 
> FAILED: qemu-system-s390x
> FAILED: qemu-system-ppc
> FAILED: qemu-system-ppc64
> FAILED: qemu-system-arm
> FAILED: qemu-system-aarch64

OK, I finally reproduced this using configure --disable-kvm.

I will add the necessary CONFIG_KVM conditionals.

- Steve

>> Could you send the complete ld command with make V=1?
>>
>> - Steve
>>
>>>> ---
>>>>   accel/kvm/kvm-all.c           | 28 ++++++++++++++++++++++++++++
>>>>   hw/vfio/helpers.c             | 10 ++++++++++
>>>>   include/hw/vfio/vfio-device.h |  2 ++
>>>>   include/migration/cpr.h       |  2 ++
>>>>   include/qemu/vfio-helpers.h   |  1 -
>>>>   include/system/kvm.h          |  1 +
>>>>   migration/cpr-transfer.c      | 18 ++++++++++++++++++
>>>>   migration/cpr.c               |  8 ++++++++
>>>>   migration/migration.c         |  1 +
>>>>   9 files changed, 70 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
>>>> index 278a506..d619448 100644
>>>> --- a/accel/kvm/kvm-all.c
>>>> +++ b/accel/kvm/kvm-all.c
>>>> @@ -512,16 +512,23 @@ static int do_kvm_destroy_vcpu(CPUState *cpu)
>>>>           goto err;
>>>>       }
>>>> +    /* If I am the CPU that created coalesced_mmio_ring, then discard it */
>>>> +    if (s->coalesced_mmio_ring == (void *)cpu->kvm_run + PAGE_SIZE) {
>>>> +        s->coalesced_mmio_ring = NULL;
>>>> +    }
>>>> +
>>>>       ret = munmap(cpu->kvm_run, mmap_size);
>>>>       if (ret < 0) {
>>>>           goto err;
>>>>       }
>>>> +    cpu->kvm_run = NULL;
>>>>       if (cpu->kvm_dirty_gfns) {
>>>>           ret = munmap(cpu->kvm_dirty_gfns, s->kvm_dirty_ring_bytes);
>>>>           if (ret < 0) {
>>>>               goto err;
>>>>           }
>>>> +        cpu->kvm_dirty_gfns = NULL;
>>>>       }
>>>>       kvm_park_vcpu(cpu);
>>>> @@ -600,6 +607,27 @@ err:
>>>>       return ret;
>>>>   }
>>>> +void kvm_close(void)
>>>> +{
>>>> +    CPUState *cpu;
>>>> +
>>>> +    CPU_FOREACH(cpu) {
>>>> +        cpu_remove_sync(cpu);
>>>> +        close(cpu->kvm_fd);
>>>> +        cpu->kvm_fd = -1;
>>>> +        close(cpu->kvm_vcpu_stats_fd);
>>>> +        cpu->kvm_vcpu_stats_fd = -1;
>>>> +    }
>>>> +
>>>> +    if (kvm_state && kvm_state->fd != -1) {
>>>> +        close(kvm_state->vmfd);
>>>> +        kvm_state->vmfd = -1;
>>>> +        close(kvm_state->fd);
>>>> +        kvm_state->fd = -1;
>>>> +    }
>>>> +    kvm_state = NULL;
>>>> +}
>>>> +
>>>>   /*
>>>>    * dirty pages logging control
>>>>    */
>>>> diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
>>>> index d0dbab1..af1db2f 100644
>>>> --- a/hw/vfio/helpers.c
>>>> +++ b/hw/vfio/helpers.c
>>>> @@ -117,6 +117,16 @@ bool vfio_get_info_dma_avail(struct vfio_iommu_type1_info *info,
>>>>   int vfio_kvm_device_fd = -1;
>>>>   #endif
>>>> +void vfio_kvm_device_close(void)
>>>> +{
>>>> +#ifdef CONFIG_KVM
>>>> +    if (vfio_kvm_device_fd != -1) {
>>>> +        close(vfio_kvm_device_fd);
>>>> +        vfio_kvm_device_fd = -1;
>>>> +    }
>>>> +#endif
>>>> +}
>>>> +
>>>>   int vfio_kvm_device_add_fd(int fd, Error **errp)
>>>>   {
>>>>   #ifdef CONFIG_KVM
>>>> diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
>>>> index 4e4d0b6..6eb6f21 100644
>>>> --- a/include/hw/vfio/vfio-device.h
>>>> +++ b/include/hw/vfio/vfio-device.h
>>>> @@ -231,4 +231,6 @@ void vfio_device_set_fd(VFIODevice *vbasedev, const char *str, Error **errp);
>>>>   void vfio_device_init(VFIODevice *vbasedev, int type, VFIODeviceOps *ops,
>>>>                         DeviceState *dev, bool ram_discard);
>>>>   int vfio_device_get_aw_bits(VFIODevice *vdev);
>>>> +
>>>> +void vfio_kvm_device_close(void);
>>>>   #endif /* HW_VFIO_VFIO_COMMON_H */
>>>> diff --git a/include/migration/cpr.h b/include/migration/cpr.h
>>>> index fc6aa33..5f1ff10 100644
>>>> --- a/include/migration/cpr.h
>>>> +++ b/include/migration/cpr.h
>>>> @@ -31,7 +31,9 @@ void cpr_state_close(void);
>>>>   struct QIOChannel *cpr_state_ioc(void);
>>>>   bool cpr_needed_for_reuse(void *opaque);
>>>> +void cpr_kvm_close(void);
>>>> +void cpr_transfer_init(void);
>>>>   QEMUFile *cpr_transfer_output(MigrationChannel *channel, Error **errp);
>>>>   QEMUFile *cpr_transfer_input(MigrationChannel *channel, Error **errp);
>>>> diff --git a/include/qemu/vfio-helpers.h b/include/qemu/vfio-helpers.h
>>>> index bde9495..a029036 100644
>>>> --- a/include/qemu/vfio-helpers.h
>>>> +++ b/include/qemu/vfio-helpers.h
>>>> @@ -28,5 +28,4 @@ void qemu_vfio_pci_unmap_bar(QEMUVFIOState *s, int index, void *bar,
>>>>                                uint64_t offset, uint64_t size);
>>>>   int qemu_vfio_pci_init_irq(QEMUVFIOState *s, EventNotifier *e,
>>>>                              int irq_type, Error **errp);
>>>> -
>>>>   #endif
>>>> diff --git a/include/system/kvm.h b/include/system/kvm.h
>>>> index b690dda..cfaa94c 100644
>>>> --- a/include/system/kvm.h
>>>> +++ b/include/system/kvm.h
>>>> @@ -194,6 +194,7 @@ bool kvm_has_sync_mmu(void);
>>>>   int kvm_has_vcpu_events(void);
>>>>   int kvm_max_nested_state_length(void);
>>>>   int kvm_has_gsi_routing(void);
>>>> +void kvm_close(void);
>>>>   /**
>>>>    * kvm_arm_supports_user_irq
>>>> diff --git a/migration/cpr-transfer.c b/migration/cpr-transfer.c
>>>> index e1f1403..396558f 100644
>>>> --- a/migration/cpr-transfer.c
>>>> +++ b/migration/cpr-transfer.c
>>>> @@ -17,6 +17,24 @@
>>>>   #include "migration/vmstate.h"
>>>>   #include "trace.h"
>>>> +static int cpr_transfer_notifier(NotifierWithReturn *notifier,
>>>> +                                 MigrationEvent *e,
>>>> +                                 Error **errp)
>>>> +{
>>>> +    if (e->type == MIG_EVENT_PRECOPY_DONE) {
>>>> +        cpr_kvm_close();
>>>> +    }
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +void cpr_transfer_init(void)
>>>> +{
>>>> +    static NotifierWithReturn notifier;
>>>> +
>>>> +    migration_add_notifier_mode(&notifier, cpr_transfer_notifier,
>>>> +                                MIG_MODE_CPR_TRANSFER);
>>>> +}
>>>> +
>>>>   QEMUFile *cpr_transfer_output(MigrationChannel *channel, Error **errp)
>>>>   {
>>>>       MigrationAddress *addr = channel->addr;
>>>> diff --git a/migration/cpr.c b/migration/cpr.c
>>>> index 0b01e25..6102d04 100644
>>>> --- a/migration/cpr.c
>>>> +++ b/migration/cpr.c
>>>> @@ -7,12 +7,14 @@
>>>>   #include "qemu/osdep.h"
>>>>   #include "qapi/error.h"
>>>> +#include "hw/vfio/vfio-device.h"
>>>>   #include "migration/cpr.h"
>>>>   #include "migration/misc.h"
>>>>   #include "migration/options.h"
>>>>   #include "migration/qemu-file.h"
>>>>   #include "migration/savevm.h"
>>>>   #include "migration/vmstate.h"
>>>> +#include "system/kvm.h"
>>>>   #include "system/runstate.h"
>>>>   #include "trace.h"
>>>> @@ -252,3 +254,9 @@ bool cpr_needed_for_reuse(void *opaque)
>>>>       MigMode mode = migrate_mode();
>>>>       return mode == MIG_MODE_CPR_TRANSFER;
>>>>   }
>>>> +
>>>> +void cpr_kvm_close(void)
>>>> +{
>>>> +    kvm_close();
>>>> +    vfio_kvm_device_close();
>>>> +}
>>>> diff --git a/migration/migration.c b/migration/migration.c
>>>> index 4697732..89e2026 100644
>>>> --- a/migration/migration.c
>>>> +++ b/migration/migration.c
>>>> @@ -337,6 +337,7 @@ void migration_object_init(void)
>>>>       ram_mig_init();
>>>>       dirty_bitmap_mig_init();
>>>> +    cpr_transfer_init();
>>>>       /* Initialize cpu throttle timers */
>>>>       cpu_throttle_init();
>>>
>>
> 


