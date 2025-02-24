Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81BA6C021A4
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 15:18:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmaDg-0004f4-Ny; Mon, 24 Feb 2025 10:18:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tmaDe-0004eu-Py
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 10:18:07 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tmaDc-0004gn-Qo
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 10:18:06 -0500
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51OBMmJ0007222;
 Mon, 24 Feb 2025 15:18:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=Epm/BWnbx/c/lIoRJnyx6KeWu8m01OeDfAgWmEQ8AC0=; b=
 hvvgpWWjc1FcflisXB1YETrxeBd0gfY5g5E9Ve7+vwG9uo/D/gYhWEzVWNJirPBu
 gwvcdAdJrMRjpIu2WAgX/iJzqImFKpjiMD7U2qhOuJCRbE4LnPAcLokL1CsRaUsj
 SYj7y8IpaYnlKNJDC2ZL9EC1ToSBKc1htkkke5KtoLAJfY4v/Dte0gwvKaugxs2v
 1eeBj9/5rvXSBDFoY+lGcr5A0f1koIjPOhKWYryUUOum+CljvUjfyCrw4CMvsTMC
 LoTcblBJ/qs/HpIe03Kv+nOVzXVrVEcAA+U7sVX68LCXzqeXsMtNa2oFo+lMcQOp
 p2uU5VmAFJ9aId+uycWrLg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44y5gajtct-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Feb 2025 15:18:00 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 51OEVFkG007473; Mon, 24 Feb 2025 15:17:59 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 44y51dsyg7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Feb 2025 15:17:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jwB36utFQ+qPB902pZPic0ts2xzY5bUoSpXzkWoryfXgV8GLTTp/Dr4tYdYYpCYQzW9LLwGddxv7w/dc1xwO6kDqoBU5S14Errq8mTzYwIJerkbD6PyxaK+7fBBsb30KQi2iKJKQ8Lh2MTR/YVlqYMHj8yPawQycWCvWVuApX1UbtcyiGn7VHO8qGwWPxGVoZYwWD0PspvNVL050nq+BAwuchfnvtKn2PDcXp0dlDr8W+OF75ayj0cZ0nyHK0xQ8hoPoSQhzRN5CsYzgeMLmDDF7L+1CIS8UTAwmlLTIGwP7qltVIVK0+EHRAFC08onUTGU1HZzD9996l1AAL+5EdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Epm/BWnbx/c/lIoRJnyx6KeWu8m01OeDfAgWmEQ8AC0=;
 b=w66SaxvmOnF2Ysj0E6kI90UP1jBU4zClkUF0/RdnbbHfV35/AvK8nwEQ9IRQr8IeSnYEEIH6ay9Uac2XPWG1/cpYMKFrYJU2DDTPRP2l10JbHluHiPja+CYwre4CWkfaC4/5eHcOC37AGAhQjjzbw639Kh31PcIkwp6DwEw1q4eKpt0OHfvjC+78NhmDC57nyAfevQUi9j8nbZ/NP4eNe7yk62YVZH452zy2Z6BEf0x05EbnwRbNRuiPHf3SEyg0u0YAXylRkAyc5UFlEdPJqOey/1Bfp0NvJiYT6bYHR6mCm7qjgCkpFP9r+4qu7Oi9n01JwmMidRsgp3+RQzUydA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Epm/BWnbx/c/lIoRJnyx6KeWu8m01OeDfAgWmEQ8AC0=;
 b=aCEyQB6C6O/wi2LvHzsXOxAsPs5C9hIJiXCIkz5q37egVf8oF3ef0n6wgANJGTJsIiqoIv6f7ALeKzI1AMZcn5WKmhlh8wOPXzKqVoVNxH44sKGOPabhXXr3kAefdQ9fYQGqyRx4j30SGiC46grSWrry5QbbaEBah30dFML+rVU=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by SJ0PR10MB4622.namprd10.prod.outlook.com (2603:10b6:a03:2d6::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 15:17:55 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 15:17:55 +0000
Message-ID: <606c2585-d241-4597-9e3a-cab7f4fea295@oracle.com>
Date: Mon, 24 Feb 2025 10:17:46 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: Live update: q35 and pc-i440fx support (vapic)
To: Fabiano Rosas <farosas@suse.de>, "Chaney, Ben" <bchaney@akamai.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "peterx@redhat.com" <peterx@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>, "Glasgall, Anna"
 <aglasgal@akamai.com>, "Hunt, Joshua" <johunt@akamai.com>,
 "Tottenham, Max" <mtottenh@akamai.com>
References: <6290683B-76B5-42E1-AA17-1F3AC58FE9D7@akamai.com>
 <87mseh8wqo.fsf@suse.de>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <87mseh8wqo.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0303.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a5::27) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|SJ0PR10MB4622:EE_
X-MS-Office365-Filtering-Correlation-Id: abcde761-2ab5-45c1-572e-08dd54e66995
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?amVRNmxERjZDWFVaMmpDcC9CM2xIWGtiM3hob0oycElaeEdHSk93UkJ6VG5i?=
 =?utf-8?B?ZW8ydU5QU3l4bExNb2FqMTVUY2lNSWQzeE5tTnJFL2VMUmJLbDlFdlJoRVBG?=
 =?utf-8?B?aVlxdC93QnhYZ1FMM1pDcG1JYjRPbWxKTWM1OWk3RnZRSUxBdGRlVjZSQjg1?=
 =?utf-8?B?dDg0ZnBQcjlkNGZ6bGFpOEhaK21xbVI3K0gwUzY2Y1gxSUlvQWlFVklSbnJL?=
 =?utf-8?B?YVJkWWNNVjJxMTFaTjlyTGVTYjVXdUpMS01jcThqOFZXbGVYOHpQb3VsWUYy?=
 =?utf-8?B?WmdvTHpmTmw1TjQvT2pXM3JXQmVXSHQrRDN3YmVOYnhGVk51K2F1YjJjSHU2?=
 =?utf-8?B?eDVRMy96TnFtSGNOSE1Kd1BtWU5KWTlpcXhwZVpzZ2txVkwrVGRlQzZjZnk0?=
 =?utf-8?B?QXBFc3BIL3Z6NWpKTmZyVlErQnVTSElIRWdkZG1EZW1jSzRWZ3N1TEFhYzA1?=
 =?utf-8?B?SEhmK3ZWblh2R1c5OEk0QkxGVnFyNHcwNGkzZlRoK2xITnRUbDVYQ2xFeFp0?=
 =?utf-8?B?d0I3V0UxcWFrQ0h1T25UTDFZUytkbUl6T2tzWUFXejcxbkRKbTdUOGltcHJq?=
 =?utf-8?B?Ym9BelVtUHdSQW1vdzRQSUtaT2d4dWlGMXpyUmcvTWs2cDhUZDdldlFrRFJ5?=
 =?utf-8?B?M2pHUlczeTVBM0FHWm82VVZId2VxalB0VXc1UkFSaitBeGZST3hzRjhqSDZC?=
 =?utf-8?B?cGhRUjZlTURUdWVXQ3phK2dsRDhqVzVGTm9BaXJqVzFOdld5R0UzZjFHOG4y?=
 =?utf-8?B?aXl3OGtRVDRndUdsWDl1dTBVemdqQmtLeDZwR29MeGJPakk4REsvVk1Pdk5U?=
 =?utf-8?B?UjlKRXVpekZLb3ZJWE9mcGRLSHZ4bFV5YlZvcTM0b0lHOXBsOW5tNXlYeEow?=
 =?utf-8?B?ZVR2a1VpcHhGN0U2TTJ1d1VhZTU4TXp6dFBtdzNOMGlrODVSejc5Syt2aWE2?=
 =?utf-8?B?U2ovTDJIQ0paTEgwbTNrU1FDVmZIRjllMkFaL3F3VC9VaUZOby9vblFBdFQw?=
 =?utf-8?B?eVdZdFNmcjlKeFE5TzN5a3JYOGpTR1VOemlSeXFER3MwNGFpcGw4NC9NbCs4?=
 =?utf-8?B?VXJ4YlRtUURGSm9JMFg5WmFvRm5UakVzTU9MMmNHUlNQRU0zaDVXYjFjakg5?=
 =?utf-8?B?NmFLWWFwamZGYlBkc2s2cVhESUhsYzhFWk1ycmdqcDRSY1gyQ1BGbUZZMjk1?=
 =?utf-8?B?UmNnaHpiVHp1ZkpDQlJOS2Y2RlZvelJvZ1BmdUU4TWhVcWdMMVR0bGJ2T2R0?=
 =?utf-8?B?eE1SeVNCTWZvQVJXNGN1VHRLdjVlLzVaNVlNblhQVndaend2TjArUDZoakpR?=
 =?utf-8?B?U3FQOVBScldUYldLdUtTUXRBRHlqbW1GWXVWN2JyMmR3Vm9BWElqU05wMDNY?=
 =?utf-8?B?MGptNm53S3JzS3BqNEgvVzRPaGF3MmUvSk9pektmYmxqUVFoUWFmTDJYdmV0?=
 =?utf-8?B?ZnZIUnVldEI0bTJWTWkzSXY1bU9RNzMyc3BFUkVEcjAvYi94dDRpMEVXa21s?=
 =?utf-8?B?ZkY3YlR5QW5OcmcwVFhoNEdWdGRvQlhqZmhyMWxEN3V0U0FWeWphbkg5ZlpX?=
 =?utf-8?B?U3M3QzFwYldmSUYzYi9URDY5WTJvSURiQzd4eForMFNqVWE2WHVYWi9wN2RO?=
 =?utf-8?B?dGlnaGlMTTU0ZjBRRE1jV1BSZG9KdSsxWmdxb0JRS1NZVHY0ZVNrTldxTDZx?=
 =?utf-8?B?UzVPUC9zang1bEhGZGtsNEh5U0VOUFhXZEZsbGJnTDFZKzhhMXA2K09xVGxo?=
 =?utf-8?B?VENqYkNpSHUvOWlsWWpMcVBUcDIzcW1mcXhCQWxYKzdiM3RpVkNRVjBMR0Nn?=
 =?utf-8?B?L3Zya3ZYdThlaDRMc3R0YjBjbUtYWUJ0TzNNVnJFTnduakxyaStGVjlGRTJx?=
 =?utf-8?Q?Wdp4B4emAdrTm?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tzdob3Jrc1BVZ3ZzUjNzUDVNZ01NYkxmVjBxNG5EUTl3VWYva0xKZTJSY2JL?=
 =?utf-8?B?OFFnejFQUW84MXhSY0haVU1FRE1RaGtkUU1OM0V5ekFjMU82czFaNzIzTE9q?=
 =?utf-8?B?bmZNZzJuNlZ4N1NhTVNxcmh6RWJsdGE1V28xbjY5UGNUUXQ1SXZWZEpvS2FV?=
 =?utf-8?B?L0F0dnB1bjZpMVhwa2c1Yis2SEtVbUtMbU1OLy9ub2t1TTRMakIxRUZlMDJR?=
 =?utf-8?B?UTEvUkVpVk10Y1hnMmc5MFRHZFFSRUN0aXZiZ3hKRG9tTlVEVmp5N1BzRzFs?=
 =?utf-8?B?NHRLWnF1K2VnYms2Y29XYXdvZGs0NzEvTEVlM3VTQndoUlBzRjFXUE85L3Zr?=
 =?utf-8?B?QmFMYTFaTzJpNEU3YnVYd2dtbno0emtiQTY3dFpJNGVscis1K004T0dlZENX?=
 =?utf-8?B?ZkxuSEdUUmIyZmtOOUdCeFFrUjRMeEFuQjhzNGxOeTRsZ2FOOUtHMHYxUlN6?=
 =?utf-8?B?YWNNdUhJTVI5WjB4NkVyV1ZxZDNmc2M4RzNPMHBUNTE0eFJJbDg2SnpML0VD?=
 =?utf-8?B?RjczMVJZaGVUeVVaNEwwRGxyTTJEbXF3QVFnL2lKbWc1dGpkVGtWaFo5Unda?=
 =?utf-8?B?NzBSOEY2T25HeWhIU3JzbGhtbHUrWGpabzJpYzl1Um0ra2ZrR3N2dVNMSERW?=
 =?utf-8?B?R0VrZDY4M2ZSam13V0RvTnRMd3Y4eThFNE9SUzBqZE1LNUQ0SkZtRUF0SmJy?=
 =?utf-8?B?anJTeFNKRzY3aFRQSzZBMm9nemFZaUIxb2paOWxXblpGU1ZleTBraGRjSE94?=
 =?utf-8?B?Y0dGZG9WeU81VFlaZ2ovK3cvbEpXc3JqeGo3bjZtaEpjVGcycjRpTEtyRUND?=
 =?utf-8?B?MEUwZ3I3eTBpbS8zV0Q1bm0rRnk3a2FlWHFEMVczd2Ezc0l4Z0RYdnBSZml4?=
 =?utf-8?B?aWJQb0UvczArWGQyR0dtVCtNdThReXpVN1JDQnZ2L3h5N0Jab3lFVFlBc3Zi?=
 =?utf-8?B?d3dPeUJoamV1YWNmOUg4OVpQMWIzN05LZTdoU3RHUndybjhlamsxdmdhL0lB?=
 =?utf-8?B?YUc5UVl6MEw0ZitkN3dybjZyYWdYZW5paXE1anlCRThSREs3a0kxeHJoekZ1?=
 =?utf-8?B?QVdVT2xRWFUxTExrQkhCZk5uUU9ZcG90QzJSZHFtMy9HZWRZVVplaDlMTEFj?=
 =?utf-8?B?RzRBY0UweGQ4cE9zeG5NRlVNZ1U4REZtaUM1SC9qSjY1MWVlZGxKVVFudllx?=
 =?utf-8?B?RzV4NVZ4K21aYXIwL2pVbkxvT05JazhKbm5MbWdTaElEZmMrQlRPWGlldkpu?=
 =?utf-8?B?Y2VMaDZMNDZ1d0xFMTZyS0RCMDJCY2hKYjFEMmtFSG56dnZuK2hVcVR0TDJL?=
 =?utf-8?B?SFZFNC9YQ1M1UUNoRXJLclU3RTd2OU51anhVZVhpSFBIQjFnU3ZRODZVYUln?=
 =?utf-8?B?Lzk4S2t5QzcrKzVpMDNxRE51RERmZlF1ejhSNGdKYXRKTnAxRHFabFpPZW9I?=
 =?utf-8?B?MXo3OGJ1b3ZDSUYzTmNQYVAxQVp0QWdFcXFuc1A0bzk1Q2JqRkFaVmpIWlVr?=
 =?utf-8?B?S0w5WUYvazFHWDlFODNldTBRWkFncWE3NHZqNzAwaVB6MldvWjgzcnhINW13?=
 =?utf-8?B?U0ZQTUhwSGJvY25TeUJPMjVFejBTRXQ5L1J1Qzlta240M0RieUwxeWJuUXR4?=
 =?utf-8?B?bzR2SEdySWRxUGpHeSsxSmUxeWlSeTdJTmkweWZiSkU4NWZZVXg1c2I5NDhm?=
 =?utf-8?B?aFE0T0txbC9hVnZYMXcxU2F6TUVEVHFCOEx2SndiVVJ3TmVlVDM0Sms4RlFa?=
 =?utf-8?B?dmN5RmhxTkp3WTNpMGlqQUx0WTFEeVUvNjQxTkVCRVZkUkpkMGNlU3JURThX?=
 =?utf-8?B?cHVKaEtJVDlCWUZqOHBCU2ZhUEZudzl5eEhMZzlxb0hwNU91N3F2ZCtLb2Nk?=
 =?utf-8?B?YUswRWJiQVBFd2U5Q1JrdWREbFhIRUZrZ1B1ZmJvMEx1UWhHZ0h1MFhnWjQy?=
 =?utf-8?B?TzF2WWlXOTNmeHJlZmxnU3NjMGNNbHdLOEo4YzhOdm9ESnh5USs3TDdPTDcx?=
 =?utf-8?B?ZzlOL3dPSXVqbW1iNHpISWJHL0JzTUF3TjQ3ODdZQXVtQm1WZUhkZ243OERK?=
 =?utf-8?B?MFdUenlMRzBUY2FnaS9rbmdOMVg0emNBSW0wcnBnb3cvVXBnc0MwaGhuNWlT?=
 =?utf-8?B?NVczSWczdFZwSHVUc3BtOTZpMG5yYTRPRWM5QVRnQmZhNUs5Q1k5aDVDNkNa?=
 =?utf-8?B?Zmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Wln4uUuUrEy2PieQ/jflfrkizU82U7F4LqBOls/oPrtwiG9NoXmzVQ0w1NZHfYQ/QcRGtqusVce6yZeeTATP9VaIIkv5sY7ait5zfFCBy3piNiwsstL00/fWNJON3wRX45i+ujLr6pytjzaPI3AzABTZwM0qdC6Pteq/Dyaq3Cs0aDK9PZK9lJQopfg0AGX93vjAKbhvwOXplbg8XLwKvBG9FOjCW26WX4V3e64rImjfSSWtxUxsVTQebfRqI06T5+ewtx3Fh7xSfdbnVVCO/zBl1exO1Uxtz/KVRpEHRC7VqhWMsC80cq5m//I6f7EcYY6isre2akaDZhjq4HDdtDDvBtrAuYAwewUSRtks/IiQVqQTpQBTMWUAEBC0quu2Ms38aXOmFmDJvRjL+agWBfVuscSNwKB5K2bmKuLr9TEC4/KSlD8ilVuzs7ISQR7K6zjvzzmMXhls74CFUsU+VDDLa3VnFQdki/ZZMZUL0z1/tLAdx5ZdCSj3jnE+3xfKQ2AcoJr31fL5xJSthKxonY6BxECTYF1u+Ax3rdCg8SVDdChQ5PLuwodMwvTUmrjaaRYPRCa+7+7YrHLXaejAK3VjzPzU/UpbhEKYW2VLQN4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abcde761-2ab5-45c1-572e-08dd54e66995
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 15:17:54.8980 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OvUBZ17Ote8sXwsTw4MGuWgVcnzULZrZZlKhoqdMP+GiDC9qz6TkSN6iyoeZKECPmpXQZLxuD1xKsHUSk2exEZERFU2dePt4A/UK/qHSrGo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4622
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_06,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=999
 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502240109
X-Proofpoint-ORIG-GUID: qngjqq0UZDCuJFu8FC_7aFzq3SjvLFXK
X-Proofpoint-GUID: qngjqq0UZDCuJFu8FC_7aFzq3SjvLFXK
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
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

On 2/19/2025 4:12 PM, Fabiano Rosas wrote:
> "Chaney, Ben" <bchaney@akamai.com> writes:
> 
>> Hello Steve,
>>
>> Thank you for posting the qemu cpr-transfer patches on qemu-devel. I am experimenting with them, and I noticed that cpr-transfer is failing on some qemu machine types. cpr-transfer is working for me on the microvm machine type but failing on q35 and pc-i440fx. When running in those configurations I get the following error on the new qemu process:
>>
>>
>>      qemu-system-x86_64: error while loading state for instance 0x0 of device 'kvm-tpr-opt'
>>      2025-02-18T14:46:52.550319Z qemu-system-x86_64: load of migration failed: Operation not permitted
>>
>> The issue occurs when initializing the vapic device in the new qemu process. In vapic_map_rom_writable, rom_size is set to zero. This causes the following condition to be triggered:
>>
>>      ram = memory_region_get_ram_ptr(section.mr);
>>      rom_size = ram[rom_paddr + 2] * ROM_BLOCK_SIZE;
>>      if (rom_size == 0) {
>>      return -1;
>>      }
> 
> Good job debugging the most opaque error message the migration code can emit.
> 
>>
>> This occurs on the qemu master branch (tested on commit 9736ee382e95ead06a838fe0b0498e0cb3845270) with the following qemu command line options:
>>
>> Terminal 1:
>>
>>      /opt/qemu-build/bin/qemu-system-x86_64 -nographic -cpu host,migratable=yes,-vmx,-svm,invpcid=off -display vnc=unix:/opt/bchaney-tmp/vnc.socket -enable-kvm -name bchaney_test1,debug-threads=on -smp 4 -object memory-backend-file,id=ram0,size=4G,mem-path=/dev/shm/ram0,share=on -m 4G -machine aux-ram-share=on -rtc clock=vm -no-user-config -nodefaults -msg timestamp=on -bios /opt/linode-seabios/roms/bios.bin -machine q35,accel=kvm -cdrom /opt/bchaney-tmp/ubuntu-24.04.1-live-server-amd64.iso -qmp stdio
> 
> You're missing an option that tells QEMU to actually make use of the
> shared memory backend:
> 
> -machine memory-backend=ram0
> 
> You might be looking at an older version of the documentation. We've
> fixed that and Steve is working on a better error message for it.

Thank-you Fabiano for replying.  I was OOTO last week.

Ben, let me know if -machine memory-backend=ram0 does not fix the problem.

- Steve

>> Terminal 2:
>>
>>      /opt/qemu-build/bin/qemu-system-x86_64 -nographic -cpu host,migratable=yes,-vmx,-svm,invpcid=off -display vnc=unix:/opt/bchaney-tmp/vnc.socket -enable-kvm -name bchaney_test1,debug-threads=on -smp 4 -object memory-backend-file,id=ram0,size=4G,mem-path=/dev/shm/ram0,share=on -m 4G -machine aux-ram-share=on -rtc clock=vm -no-user-config -nodefaults -msg timestamp=on -bios /opt/linode-seabios/roms/bios.bin -machine q35,accel=kvm -cdrom /opt/bchaney-tmp/ubuntu-24.04.1-live-server-amd64.iso -incoming '{"channel-type": "main", "addr": { "transport": "socket", "type": "unix", "path": "/opt/bchaney-tmp/main.sock"}}' -incoming '{"channel-type": "cpr", "addr": { "transport": "socket", "type": "unix", "path": "/opt/bchaney-tmp/cpr.sock"}}' -monitor stdio
>>
>> Qmp commands executed (in Terminal 1):
>>
>>      {"execute":"qmp_capabilities"}
>>      {"execute": "query-status"}
>>      {"execute":"migrate-set-parameters",
>>         "arguments":{"mode":"cpr-transfer"}}
>>      {"execute": "migrate", "arguments": { "channels": [
>>          {"channel-type": "main", "addr": { "transport": "socket", "type": "unix",
>>                     "path": "/opt/bchaney-tmp/main.sock"}},
>>      {"channel-type": "cpr",
>>           "addr": { "transport": "socket", "type": "unix",
>>                      "path": "/opt/bchaney-tmp/cpr.sock"}}]}}
>>      {"execute": "query-status"}
>>
>> Is this a hardware configuration that is currently intended to be supported? If not, will it be supported in the future?
>>
>> Thank you,
>> Ben Chaney


