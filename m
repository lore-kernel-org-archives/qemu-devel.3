Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13AE0C02192
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2025 21:53:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfnK3-0008CX-JC; Wed, 05 Feb 2025 16:52:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tfnJx-0008Aq-Sy
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 16:52:34 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tfnJv-0005YR-7x
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 16:52:33 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 515Gfj4Z000989;
 Wed, 5 Feb 2025 21:52:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=HWF6yrz3VVjMrUHVV5k3tIWZx+B6l80G3a5KwEjm/20=; b=
 YBgy9FExsRS1192QNc7qOx2y9ksX61Zxi+BIsncbOc00ofANEr1QGdBn+6oaIP29
 ROGrDObczO3zxgQ9MojDAVINL6kaIeNdX/ed8rhlk0csZj27NmUUuVztav4N2rtJ
 d0jkZHkptlsQcMB2WTz8/yvYnAl0ixsiKUcwzso8bwyod2N72nAHGTAq8tryLwAv
 TjUm0OjQPznhtmxFj/s2JCfBr/NxRjwJ0zhRS1z9j1nVY4o+rW/RgblMzTGwgbpW
 7rI1Zwox/dNI3zs4gXx+8gLFbZBTBvVBhyPGNbh5BQ6QD6RDkSNEkxMaF6lWMZ9/
 kgcPvYccLEy9K+CpSQb4mw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44hfy8815y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 05 Feb 2025 21:52:26 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 515K1iTi027958; Wed, 5 Feb 2025 21:52:25 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2043.outbound.protection.outlook.com [104.47.70.43])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 44j8dp8rtw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 05 Feb 2025 21:52:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iPSer1Zxcvv/WZ8bP5hc/oliHNlDAyQqZXPbAjyl5K9COG9QZExFMaR1ydAC7NuBQB2oZ5ERRP8r6D0Bcyh8Cjwsi2Y+TgeV06l0iDshWyuc1sj3amovsfywBPe9DZMpcoYsM2XTiu7UANm3YjHNl9TiZrhR4DDHFovUhxvPWjfLlHZrHRg/N6A5wyfYiXa3puV0xq69MZkzTTgE7z6PLPrPVKBcFuS7i8rtwzRjgXZ/jpb/w2MWWsImKxKgmadxMJ9uHTbIJvz9JrAavfpBF6mskieXEgk49i3fazGpoSZyC8kxJsm/GeCOboQxd28FBoldtsJIJG4ctCObcqcyVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HWF6yrz3VVjMrUHVV5k3tIWZx+B6l80G3a5KwEjm/20=;
 b=Wdkm9LSewr9p1uJPDbFpA/jtyv1y+rldnTLDVyGYr11PabbpvWce8A9lN2P/Kuiy/bmwJnAucGc2LTx+8duMTww0MhiXgUj4i6KYSiqR9GKI8sDYz2N4Qe7BowGv4WZhD6FZxHcdO3VpavfMi2hp9NgicMfF9Mq23ivhJomANRsIPparnyMtHdz2k7oDxmjJwwENkR08k59F8Mc/6TSH3kQEosaar0uYZtljhjW5egVSl7Sqt9xGFO8hcj/dStXbVglkyMz/rMOOSt5AyvcvErJ8gvLQaHJXjVjDAx+gDJLVpRmLyYuA5yNfO0q+qyyX1xHnCYzJC4c5QYOTYxgPWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HWF6yrz3VVjMrUHVV5k3tIWZx+B6l80G3a5KwEjm/20=;
 b=kX6sHsCTJ8/Dmj5zKDB7UthjMftpxqVLsEATlStfZMjkBzoDp6LSOcJsGBiVVMZ4WoybRE+Go9utO47rujD8vBDs9QqWBngNZS1jtYXY+UGU65TRrFwWNCjhiWU4wVkLuYybr+f/cFuH9glmoKA6NbF1GuJoE58qV+m0Q5fzaAw=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by DM4PR10MB6205.namprd10.prod.outlook.com (2603:10b6:8:88::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.21; Wed, 5 Feb 2025 21:52:23 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%6]) with mapi id 15.20.8398.025; Wed, 5 Feb 2025
 21:52:23 +0000
Message-ID: <b30ab9b0-2ca2-4bfa-ab11-a09d73bd85b4@oracle.com>
Date: Wed, 5 Feb 2025 16:52:19 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] migration: use parameters.mode in cpr_state_save
To: Peter Xu <peterx@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>
References: <1738788841-211843-1-git-send-email-steven.sistare@oracle.com>
 <Z6PX-Shf7UREfLD7@x1.local>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <Z6PX-Shf7UREfLD7@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P123CA0043.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2fe::17) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|DM4PR10MB6205:EE_
X-MS-Office365-Filtering-Correlation-Id: 4577621e-cab7-4d51-67c1-08dd462f5f4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SHE0cVR4d0xpZGhxODF5ZXRuUzNUbi9xQVBjaEpaeklFS1loNUlpSUFTYURI?=
 =?utf-8?B?eE92eDUydDFOUGY4MDcxNk50a1FObkRWOVFKOVhHelJ0MmNIc0hqNWlYbGhy?=
 =?utf-8?B?T1VNSHhXdHUzaGlUYys3Vi80dUJ5ZUpQc2EvYnpxVVRGaSt4R2UvbEd2ZVcx?=
 =?utf-8?B?R0lKbVdQbTdtdHJFZWlXTHRqWUNCMEFLK1FiQVVVM1UrWjVyRXNVbFd4TTdw?=
 =?utf-8?B?VWpaZFBTYnpQRUc0K2o4UWhxQzZnZkdZbmt4S0JKOUcvLzBNU1BLdGhCWkow?=
 =?utf-8?B?NzRrWjBqaGNhSHBTdUhwbG5xOTlhSTd1L3ZvTkZ3bExQZzZ1YTlqcHFLbW90?=
 =?utf-8?B?ajNSeEgwSDJSeVE4eU5pVEFVNDMyNkIvOWEwWHdPSWc5S0pqcE0zUzQ4ZjFI?=
 =?utf-8?B?bml2UWIwQm5STy9aRGFUdHBDUWljdldrT1NVcHFydG9MMll5VEI0eVVMdTA0?=
 =?utf-8?B?QkdwaDVUQk5xU3owZ1RBdVpGODcxb2xtdkwyWmZvWll0UmxOSkY0dkN3VGRS?=
 =?utf-8?B?d2dyNXdWSVd6NUVsNEFNbndYMVp4d1dsUFRMcGlMZ3VhaVVZM2JTbW1mMjBG?=
 =?utf-8?B?aUg2S3BVdjNWcHlUTGJUTnFuMDhNSGs0Mmx2L2hkNnVQajdyRnpQeVFFd3ZG?=
 =?utf-8?B?bFhvb0czQkhEUzF4a05YYlN0bzNXdllkRTJJV3lPZzVuYm02MlpiTVhGZG94?=
 =?utf-8?B?WWlNQ0hrdVVRZEdUTGppMU81cEh0NE92SjVhZ0VHNHY5MmVCb2d2TG84bDlN?=
 =?utf-8?B?T1RwNU9EcDhPWDVXaU9jVEJsdDRydjk3SmJZd1g5VDRQdHlJbm9tR3IyUGVL?=
 =?utf-8?B?YlRKQ3hNeXd2dWxnaUlLQ1ptUlE3M012U0xWWjVnUXYxMUg5alhtMGJVV0Ft?=
 =?utf-8?B?cjViSWtEWEoweGlmYnlJRXdJNEsxNk5iRUhBTFQ4eWZnK3lLU2JYd3VGZTJY?=
 =?utf-8?B?U2xrK25pT1kwd1dmUkJhVzhhcFFpU1RWT3RMZWdyMzVRbkhEaTlvSm43L2w4?=
 =?utf-8?B?WDlvMnhOeFRnM3F6S0MzOXFieU5XTnEzWFpEZldneC9wck5ISGI4ZDdVSHJK?=
 =?utf-8?B?TDkzRk9ITkNlaWpRQ0llYVlpTVpsb1Z5RkVpcWhTKytCRVc2SXpvd203ak1k?=
 =?utf-8?B?cjFUOTNGNHRkT3lYcWdXaHcyejZSL094Q21vYSttbWRRZXFYR0NOT1ZIekts?=
 =?utf-8?B?cXY0T2M2aE9MTDRjcnpYcjdnZExERFhEWHhDMVVJV2FoVDd4M2NlNlpXQVcx?=
 =?utf-8?B?bUhrMElVemJIUmZnN1RNOTFZN1A3QWhnMzVmYnFyL1BDMmFYYnFyM3VmakpN?=
 =?utf-8?B?cENWRTJ0TE9zSTFiWjZKWVJnbC93M1VPSnB0dngyb256d01VQVpOK1dTYVQz?=
 =?utf-8?B?Ny9qQTBRbmdYZUV2S1BHN1RzdURwbWZXZXpLR3NPQVlvaUtIL2NWUit4UE14?=
 =?utf-8?B?U2puMjRjdWRWQy9QaElBdVJvbWJzeFMwOFRJT1RXRWd1blB1Z2gzQzhSTHBK?=
 =?utf-8?B?azJjcWcvbTgxU0taUzlWTGlaV2VhNGNab0o3WWpiaWs0Tnh0QVdvcUM5N3FN?=
 =?utf-8?B?eWw4ZTgva2xZcUhpbC9HMkkzMGRibm9KNm9nOXVta1RaWit6cSttZGVqWE1x?=
 =?utf-8?B?MjdFblZxdFBGNEVpSmZjcldsdVV5SGdPcXlLcU5ZaEFjWUp4ZUNWaXpZYnNm?=
 =?utf-8?B?VFNEMGFQb0J0SHhaUktHSk4zT0M4dWJHcCtsVjFUWkRCOXlYWmVueDFPdWpR?=
 =?utf-8?B?MFdjQnJZb1N0MWo1eUVDNG5CaS8zN1c4MCszRDJsdVhESnY1azZLYWVPR2Jn?=
 =?utf-8?B?OW45SFNVNDRvY0VQUjBWeWREc2U4WjBreGUvOS80ZTNjTkU2NGZPRlJlSkNN?=
 =?utf-8?Q?Vppf9zzcdbxBs?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aVhxblJGalpma2dFM29FMHp1UkZ3bzZJcWRBZUdUeGY2T1M5WW9PdGpXQk5J?=
 =?utf-8?B?amErSkdnMlpudWlHSW52NFVMazV6bjZKaEI4Wi9WZExOZWJTeUt6eVhUbk51?=
 =?utf-8?B?ZERjR1BleHJ5Zkd0dDhUUlJaanNuNTdpekJvYjZFRlhKOVdhR0VKTmJrVSti?=
 =?utf-8?B?cE1sSTVJNzBWb2RKM1VyMGhhc2NJK3pEY2NmMkdUbk1XdG84K3RSa1M4KzB3?=
 =?utf-8?B?TUkyTitpcTBHOHd5eVFHUkpZdmJqUWR3WnU4aVR2aHdhelcvTjlIU0hiUWJa?=
 =?utf-8?B?cVhtVEd1U0ZiUGF3TExMN3VwamxXVkFmeTcrc0Rzc09DUTRwQ3QrWnpZdVVw?=
 =?utf-8?B?RjZ2aE56aGpySnRLVUNxc3NvWktpUnM1QTIybkV6NHBMcFY0dGhkZkpXRGpG?=
 =?utf-8?B?RUhoNHZEQ0Q3bkxHMkpUQ3FBcXIxUXJvSkQ5YlMrWmgwKzNrZ0t1bWdFd0NV?=
 =?utf-8?B?NWduSHVzdzBaQmJ5S0ExTmM1Y2JRcDZjU2ZyY1p1Si9zaEwwaGw5eHRxRVJH?=
 =?utf-8?B?MzcvRDJLaEY5Y2xFWGFMQzFGclgxbFZjcjljck1ObnpMdFdFZWZpc200UGV3?=
 =?utf-8?B?Y2VFQXJ1SnBxK3I5cEsrRFN4WXhDMUc1KzZ2TW5uWVNPbENkWDRRQWRKUHBG?=
 =?utf-8?B?R0tvRm92bHRSemdVbjdRWFJkYWxiVzNDUnJlemVRcVUrM1EwdFBVblYvTVR0?=
 =?utf-8?B?ZzN5R3pUbUJwL0xXTENueVlCY3ZjWngvRGRaYllVS2ZENGxiSk1wSFl4TS9y?=
 =?utf-8?B?UThCa01IQUxvZGhGTkVsSHhaTlZSaFdVeU9NQUZwUzFBOHZieUNxazh2Smll?=
 =?utf-8?B?dDl3Rk5vaWViZk1OOWhPSHJQOE5DWmdoL1VndU1sRklNU0dqdUVNVUo1R3Z5?=
 =?utf-8?B?aEg0NkFDdTJHMEJBZk1vdTIySmNtNStvTTVaQkVnU2FMdU5WRHcwOWdRNCtK?=
 =?utf-8?B?SnVmNU5DeG43RHo5SVZCelI4L0FSQlJvNzJFRWJ2NW9zKzErTGI2RjFMcjFu?=
 =?utf-8?B?UVNhTm8vVlRRd25mRDc0aHgyZHhPKzd1TDZQdEkrVCtTd00reTVtQnpoQ1Z6?=
 =?utf-8?B?NVNjOHNaQ01hM1Q0bURYQ1dXVGkrOWtKaGlmKy9Qc0ZFYmVTbEdhVjBxaE5N?=
 =?utf-8?B?dy9jOWFUekhHdXIrMkRUOUhlSkNXN281TkNXMWJpY0NuOGZqcE5pSnVWSkE5?=
 =?utf-8?B?YjdsMDZ1V2ZLU2tkUFJwNnZJd3FYSVlDU2lwQTJsRm5BR05iRWVFZnI3bnAv?=
 =?utf-8?B?RFZzUmRJYkpTNmx0VGNXeGVoRENYdTNrbm5YVWhaa0RaSXRxY0JSSTJsVGlw?=
 =?utf-8?B?SVFtajhxUVNUaVZack9hVDRUbW9YcGU3REw0UEFFSktpeUFMazhTdUZiVC90?=
 =?utf-8?B?QjVaU1Q3dG9TQnJWWElmYnNGYkxJd0x5ZTk0UlNnTnF0RkpHM3J1NVVkSmc2?=
 =?utf-8?B?M1hFSkZ5VHFVdXhWV044Y2RqKzIrelV6R00rQTRRcGIrVVVyaERmd0oxUzQz?=
 =?utf-8?B?cnpFNVplVUJXZy80QTFyQnlMZHlQTFdxbWVNZ2Q2NVRaQ25DSVhSMVQwL2FJ?=
 =?utf-8?B?M2ZmVXg0UzM2TWJIWmRMREVCNzNkSjZtd1BwU0RRVTkvRnl0eVRVaHI1QUdC?=
 =?utf-8?B?S200TVNRTS84d1NyWWJQd1oyWFhmd3llcWZjdk5ZRHhUSVQ2WG56VVNTZ05V?=
 =?utf-8?B?eWsvN2w4SEhTM1M0cWZwNDNWN0hyRUZLNldYK3hJbW9VMTRXZzZWRDBOL2o0?=
 =?utf-8?B?Q0tSY3dQbU9iMXdncnBhUFYwS2duTjhEa2NIdkRZVWhhVGg5NnIzUjVoZmQr?=
 =?utf-8?B?WEdlZG0zamQwbWxlVzhTa0lMbXR4cUtlSVdHMFJMTUtiNk1DQysydWdRWHpv?=
 =?utf-8?B?RnUzVlJaUTYxV2Q2L29PbHd4QUZ1aVdNaHVPRHowclQ2MWNiZTl3L2Jva1JI?=
 =?utf-8?B?YU9vcVlURXkraWZqclplWDRUN1JIZjBnMXNwcXJFZ3o3UFNRUEpkblA3MEM1?=
 =?utf-8?B?QUd2TmtXNzZjTlRaME83YUdXTFIzeU9aV1pRd1JwaEk4c2ZDcUt4SFdKWVpW?=
 =?utf-8?B?aFExS0k0YmY4d29FanczQm8yQTh3ZTN0VVVQVHZNUmhESzJoRDdrTG4xdkwv?=
 =?utf-8?B?aDZaTlY0RTUzQ3E3UlcxNDdtamZRazUwdnh0NmdUSnllUmhFVWlpVzZWTzFL?=
 =?utf-8?B?blE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: vTbxcQ7ciz0vC7Xofsd9D0QFHKUwIHyUavFshJFUDTfrF4M9AAmp3ayAL2O6/kfIK6kC4RdFndPP2fJApfefLQyO1g1iYiAN/AL7lfH76FU9FDdQxPWYuEeHYW+K+YVkLQv+XO/5Ml0b+NhrjbFoJ1apU80FOnN3DpiHZ3dpXflJAyZK2yJUJIUcMOuglfgwEjJfQJ86X7SQn/706hqFrQValrBX2j2TlvDNiH3/0tmPbOh38bgGDihTsw3MuSbo6LUUEURySQFdrIvah6DgBfc15/bYMhhWkvfowK9/oKUGvLILGYyhihFgyzjOwfrbgXXSrfswHhs3ZafZlEWgXEsP5pmP0s7XZ04mB0n2bpR0WjjKq8CEDypjyebi6n5UFqfyonEVAFSAs4bl1XLAgq6eW4vsVzqkSLF25tMatA70w6RnIJNEdq+gUZTrcVRvCYRnD06xJlK4TR+feKMOMo93NN1YQ+nKfAKa378t6dz47vOb39wG4wSCn5YtlEzoelLtaT7Qe7KDfpyJlwjyoDy0DLDFNbi1+LI/ECh+h3H3fsvC8Bcy9ievW1f+J7rQk7/CfKuaIwDN1vSckETOkiHX/iLhd4MXXLDErUD/FgM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4577621e-cab7-4d51-67c1-08dd462f5f4f
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 21:52:23.5017 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VlrsrVroTiilZ6u2O5gFXCX1+TcjKtaGNdUM00EpmvoD5zD0CX9v5ndMGbKoDFY+sjquAVq1fS3D3Fm2YkDZkT0eL8/KtOx3rggzj9Mg1aM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6205
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-05_07,2025-02-05_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 phishscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502050166
X-Proofpoint-GUID: vH48AumqpAL3PNvuxe_iBS8drQzuLamc
X-Proofpoint-ORIG-GUID: vH48AumqpAL3PNvuxe_iBS8drQzuLamc
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

On 2/5/2025 4:28 PM, Peter Xu wrote:
> On Wed, Feb 05, 2025 at 12:54:01PM -0800, Steve Sistare wrote:
>> qmp_migrate guarantees that cpr_channel is not null for
>> MIG_MODE_CPR_TRANSFER when cpr_state_save is called:
>>
>>      qmp_migrate()
>>          if (s->parameters.mode == MIG_MODE_CPR_TRANSFER && !cpr_channel) {
>>              return;
>>          }
>>          cpr_state_save(cpr_channel)
>>
>> but cpr_state_save checks for mode differently before using channel,
>> and Coverity cannot infer that they are equivalent in outgoing QEMU,
>> and warns that channel may be NULL:
>>
>>      cpr_state_save(channel)
>>          MigMode mode = migrate_mode();
>>          if (mode == MIG_MODE_CPR_TRANSFER) {
>>              f = cpr_transfer_output(channel, errp);
>>
>> To make Coverity happy, use parameters.mode in cpr_state_save.
>>
>> Resolves: Coverity CID 1590980
>> Reported-by: Peter Maydell <peter.maydell@linaro.org>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>   migration/cpr.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/migration/cpr.c b/migration/cpr.c
>> index 584b0b9..7f20bd5 100644
>> --- a/migration/cpr.c
>> +++ b/migration/cpr.c
>> @@ -8,6 +8,7 @@
>>   #include "qemu/osdep.h"
>>   #include "qapi/error.h"
>>   #include "migration/cpr.h"
>> +#include "migration/migration.h"
>>   #include "migration/misc.h"
>>   #include "migration/options.h"
>>   #include "migration/qemu-file.h"
>> @@ -132,7 +133,7 @@ int cpr_state_save(MigrationChannel *channel, Error **errp)
>>   {
>>       int ret;
>>       QEMUFile *f;
>> -    MigMode mode = migrate_mode();
>> +    MigMode mode = migrate_get_current()->parameters.mode;
> 
> Are we sure this can make coverity happy?

It should, based on Peter Maydell's analysis, but I would appreciate
if he could apply and test the fix.

> Another more straightforward change is caching migrate mode in
> qmp_migrate() and also check that before invoking cpr_state_save().

Surely anyone would consider my one-line change to be straight forward.

- Steve

>>       trace_cpr_state_save(MigMode_str(mode));
>>   
>> -- 
>> 1.8.3.1
>>
> 


