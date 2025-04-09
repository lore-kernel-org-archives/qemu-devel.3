Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 990A4C36002
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Apr 2025 15:15:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2X8v-0007RV-Kh; Wed, 09 Apr 2025 11:15:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1u2X8o-0007PQ-Hf
 for qemu-devel@nongnu.org; Wed, 09 Apr 2025 11:15:03 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1u2X8l-0002aP-UX
 for qemu-devel@nongnu.org; Wed, 09 Apr 2025 11:15:02 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 539F0k7Z023608;
 Wed, 9 Apr 2025 15:14:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=KIm2z6Wd90Dt5ZO+Vb9kl62KisYCLNEwlIWwKlcUOx4=; b=
 ZEHLtQDVmUzKBW0Pu3+3ay4UokIeFDOMSg0pq74XPAdJBQRLrTntIIMadFlK1IIy
 xpnpvHYNRmhxik5v+uClL3vpK+8W9a0OClotHehTH9UfM/l851paECMbXAqGMNce
 2/6lN2AMINSFvqG2HGE/se3wAqq0u+93T5vrGFU1HSwS0jiJfZNc3BDayHdscoko
 oecjmjKEbChKfP5csCJhpHCGRuZvTWo+PXHSKbO8L7HZ5nshklBbtupwJITCxJld
 Pc2opAlcyXzKnM7XHdb/k213TrKK+no4aVzbmk1afnthJ7DAR83eRIflR0m0oEIT
 JBKGog+c6pFYvX2J/lldVg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45tuebqekq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 09 Apr 2025 15:14:52 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 539DsHhJ013769; Wed, 9 Apr 2025 15:14:50 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com
 (mail-centralusazlp17010000.outbound.protection.outlook.com [40.93.13.0])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 45ttyh8hhp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 09 Apr 2025 15:14:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q3fjaIfegqX9H13wIaB5PVZjNEIQHH1eLar1pn0ju1xg7r5Ld4K85oZJ5AYUf3lBaATnUHfvcFCFsffdhNpQCRJyqQIO+6/y4dpjSxqZ5W0MAW+zDOy51g5Ct5Fp64n8bzsSblZaSu2lw+Ci1HqUntT2zhr5pb7vEecXosZPv/88mm7JA5u4e7IK36l3xYoBma+16x4Ri0/x3ADjOtLgd94h6ERCTk0KaXmfUIBXhlxJctJKoo/j1+tlkevgwKeOe2lHw0XR47Iyhs2W9wIimwQtEV59KsSz3MqIB8ltMlt98FujM8CMJrEyYhmTqvKvfiwRy4xZ00uQL3JKXz1Dnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KIm2z6Wd90Dt5ZO+Vb9kl62KisYCLNEwlIWwKlcUOx4=;
 b=YhLCRVrQMRrz0VIfgkHiWcM83RebgNSI00bQM5iCEv5NEFtlXrVVwxpP7dmoXH/JUi3wFqOyVKe1Qc/+xXHMDyjw8uwRUfV55nTFKVNcTGRhp6blW5/udnEhx48DFQOKiDchzj4RUgXi6adt48Rvcgc+4rIKKOxGmth7UiFNP1lQW1YHXj/9yXG/l2kvaieyNS88gtYc1jqxVk3dt7+lgttaFxw3AO4h5/LweO1dPt/n8TwzmaDCGeA1C5a/B1Uy3SSw9K81c/h6EoZUC/5gBSGA9uUobMeFWXptLzlnfu3eGXoHTaVckooi4nAnifUaoKJC53jlz0iyZwytkJ3oQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KIm2z6Wd90Dt5ZO+Vb9kl62KisYCLNEwlIWwKlcUOx4=;
 b=AUPycvgQY10IAeWqR33aHZ1cE5w5CaKm7niFwVhzQFoMRTjFt0XI45ttDjVojgUPliYuMH1PBmlwXJDEFp4JWTkumGnAwXGUI6mBmw6vu4/jDSEqXlKfwUCAUB1mmoqr05OVpVHmjFcgblB9EsZM/kCA9pTA0OyJeZMaj/ZMXNM=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by SA1PR10MB5782.namprd10.prod.outlook.com (2603:10b6:806:23f::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Wed, 9 Apr
 2025 15:14:47 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%5]) with mapi id 15.20.8632.021; Wed, 9 Apr 2025
 15:14:47 +0000
Message-ID: <2a1419b3-5cee-4c57-9f3b-a02d630df3b6@oracle.com>
Date: Wed, 9 Apr 2025 11:14:45 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 0/6] fast qom tree get
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Eric Blake <eblake@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, devel@lists.libvirt.org
References: <1741036202-265696-1-git-send-email-steven.sistare@oracle.com>
 <87friheqcp.fsf@pond.sub.org>
 <86bb6d0f-63a1-4643-b58a-1186a73e3b17@oracle.com>
 <87mscp8nlu.fsf@pond.sub.org>
 <507cd943-5922-44b2-a0cb-1b85f0cfd074@oracle.com>
 <87iknd75so.fsf@pond.sub.org>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <87iknd75so.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0110.namprd03.prod.outlook.com
 (2603:10b6:208:32a::25) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|SA1PR10MB5782:EE_
X-MS-Office365-Filtering-Correlation-Id: c284766e-5701-46bf-d7cf-08dd77794416
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SGsxaENNOGhUMXpSVUJHRVp0YUR4UlpVQkhZV3l4eEpmcEg5cGQwTVNpNkJj?=
 =?utf-8?B?R1EvY0l1bDl6K082RWZ0elhNckdXeXNacXVvV0RSK1Q3alYyZDBDbzlPdXhL?=
 =?utf-8?B?VXpXY2Q5RDArcE93blYwVUtIVSs4TDVOenZaT0svd2lkSVQxdXVPOVRRL2d6?=
 =?utf-8?B?bVovUkNabmM1dVBLNEFJOUJHMXpJNUROd1ZsQlo1Zm5WaXd4VERBZGUyU0d5?=
 =?utf-8?B?OWFESzIvNmtiT0VZdXB6ZEdFZ3dVL3Nra3NXS2hQemtnbmxnMWRIMkg0NFkx?=
 =?utf-8?B?ZWY1RlE5aHI0T0JKYjNmbU9TK3J6VFQvTjhNdWczeXFQUm00eTdEUG5jV3Vp?=
 =?utf-8?B?ZmZjdVpFS0VTd3FZT2trK1F4NVVhTkJPcHVHU0R6UWd3d0hnVWg0aVRSbW94?=
 =?utf-8?B?c1ZjY0lzZ2lzRXZqQ2FCQ0VXTFhBcVdjeFRHck5TanZ4TjJKZnhNYkdUQ25N?=
 =?utf-8?B?VkNncXowRWQvM1NIZmtQKzRBSEZEVXVsUXBxMnptbzI3M1dtb3E3d3FySm9q?=
 =?utf-8?B?R3VaU1AyOUYyNWtqeGlxQ1V3TUVUT3VqVTNQeFpldXorbUxrVmZ1RlRFMWZG?=
 =?utf-8?B?eVZhY09EVkJieitEc3lNcE5JdVdCVnh6MnFVNHQzaGdKUDlKSkdRMWFNYm9i?=
 =?utf-8?B?NHllY0NDOExoSVRlZDZsNXhGcjBVT3B5Nml3T2pyS3J2aE1Mbll1VjQ1NStV?=
 =?utf-8?B?MWpWYU5BYlFrZ1Bzd0xZT0d0a0ROVzFQbXVuWms3QkhzekRVSGtycTJRS1hn?=
 =?utf-8?B?QU5rYklrUUlsbEJvaVdCS3kxZmVwNkUxUnBlR2RLRnRGakFsQmlhaFEzaUJp?=
 =?utf-8?B?K2t2YmNaRHFBd2xMOWtRZEJNOXVoVTVOVVZtWjU1c29qemcvdDJqVFlxNXZC?=
 =?utf-8?B?aWNCcWUwY0thOVlhSHRMTkV3dXoyN29HL24vQTZ4a0tWSUdQYTRBNm1HRWJT?=
 =?utf-8?B?MEJIaVRmSkw1UlA4SDcxSmpPZnBEM3hTWVYrZ0UrTjVyMW1jbTJFb0RkUEZQ?=
 =?utf-8?B?UlAvNzFrUktaS05zVi9VclFwYnd1UHVSYVJaclh6SUZMTzQ0OHk4c1BSSWQ3?=
 =?utf-8?B?Nk9JSmRzUVFPYmdaeVhpZlBOZUJ1c2l5dFQxNE1tL1o1eExtRzJBdkhHTnI0?=
 =?utf-8?B?NmM2RGVEcEx2UkRpYzVOc1FqR29qZ3FvTUg3dUorS1BySHpUanFyZHd0WDdB?=
 =?utf-8?B?N29BdWN4cEV2T1cxb2ZBQktHeTE1ZTM4cjNob2UrSUNSanRVTk1RQnE4WlRT?=
 =?utf-8?B?blgvWFlYTUdFd2FTVWRuL0N1NWhiRTl4VG5LR1JDdFh3bm5WNFVkMDV0dW5L?=
 =?utf-8?B?TmNBVzFXM0hkOU1TTDIvY2VVN2d5ZGRwa2hYRHFXYlJvU1pZdHYyZW1kaURG?=
 =?utf-8?B?ZjlScEg0V0EvVllKY203T2JGUm90dHZLOXJmWHlhbG1SL1grZXZEbE9JYjFl?=
 =?utf-8?B?SWhFdE1ZZXZ1WFJvd2xkK2owU2pYVkRRaytSZUpTa3J4bXVrS3hSV2ErN3Vl?=
 =?utf-8?B?VVZnWGNuT3NpTVVLeGg1amtYa2NvdDlzcDRkTEdpamkvNDAyNWNjNWJwS0pP?=
 =?utf-8?B?Umd2cnlwQXB2TnNROWVoVWtNSUJUdTh6YkZDdmljTThQZzlwdHlWa3FxU2py?=
 =?utf-8?B?cnN4UzNGMy8yR0lSZ1hGWWFQOTlDb1d2WFV0RitHUlZNQjlvUmwvc1hvR3ho?=
 =?utf-8?B?WHBpSjN1bUxUNU10VlhpNVJZZXRTTC9CMWhRb1ZsU1dKVzdUWncxcGk3Y3Iy?=
 =?utf-8?B?Uk00djNEWGtnRGRoR2t3cVhPYStxVkMrMVVIb3JkM2N6OFZJaUxuYUZWMUk0?=
 =?utf-8?B?U0lianJ3dW54b3AzYVhXR1doOVFyMzBOaVVPM0o0RmhKQTRlMURoako3NVJu?=
 =?utf-8?B?bC9MUGNvSWpkVEJ3SHUyU2s2VHNRT1V1RU9ycnJFWHp4OXpLejkrd3VQNDVC?=
 =?utf-8?Q?ubOti6Q4igQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWpVdG1nWkR3N2VtWk4wbERYa0F1d3RuQlh5cTc2UVpsckdSZ0xubmRyN1Q0?=
 =?utf-8?B?WnRPZ1BHQi9FZWdXRWRoSS9rTDdQd3dGY0IvKzJ4ME1YV1h2dUVlajQwNGIr?=
 =?utf-8?B?aFlUNUJUR1dhZ1hyZG5wWkRqaVN1dTVoYUFPMFUrN0FMUGFuR2dFRjRvVGxn?=
 =?utf-8?B?WHpobDZLS0lmZmZOYWVocUF2UUNwMzNVaDQzQisvclF0dVpJS3R3Ulh5Z2hS?=
 =?utf-8?B?U3VIWUpiOXA4OVJtSytFcWNMS3hPSE9NQlZtNTh2VTlrTCttMDZFQXcvWVRn?=
 =?utf-8?B?eXRTZ1NCV05EeEcxUm00TzUxZXYwVDAwaFJUZlJ3YzYwNXh3ZHRhc28wbkhs?=
 =?utf-8?B?dnBiZ01TbFdxa1o0dUdZNHp4cWhTVlJhYldwRUhLL2FpRkc2ZmVTbHRmQjZ3?=
 =?utf-8?B?T2RRazBUZlNTS1hnOFBrcHUreEw2azhLcjNwaUJ4Y2FBMlVyM2E1a2JBd2ky?=
 =?utf-8?B?Q2krRUh4dXRjSWVYdVRvQlRDS2tVSk8rVnY3NHpLbFpsV3F5b1J6VXhrazEy?=
 =?utf-8?B?T2N6OFVRandtbEtzWUNMYXNpejRNQzFlSFdFWUtsT0VhbTc0TTJJemJJMHF0?=
 =?utf-8?B?MHZOTlZEY3hCRmw5SFg2UURWNnNzS01uUUowWUFMbG9LQ05HUmZNcURqdFJK?=
 =?utf-8?B?Q1RETDc3V3dsZXd6Z3RDcVQ1czNDaUJsR0oyY0JsNDhIcFpVajdsYTZRUG01?=
 =?utf-8?B?aVN4Y2tzandOcDRTTVlxM3U0VWgzWWNmV2xDSGc1MlU3Qzg5UEZObGUrSWtr?=
 =?utf-8?B?S29hdTdqUmp5eU5NRisyT3hkeGlvODN5U21ZV0dLcktzMkpxZ09MMU9FNitz?=
 =?utf-8?B?OXhkL1ZYMUZBT2Jyd0NhV3NWUXNvdXI0UkVYNFNyU1ZrMkQ4UDdPQUVrY3Zz?=
 =?utf-8?B?TDdEM2dDTHJ4NjhCcWpKZzZwQjU5bDZPMzRra2VZRDFmNi9xTTNqY3FCQzl4?=
 =?utf-8?B?eExjVVNBTDd5dURjWkJoZ0tJc3dtT2xaMTY2MzVLRXFYTzJ4RUpxRjRBMlBM?=
 =?utf-8?B?Qi9ZOEtiTEgrRHJWQlEyRzFTbUtZU0R1TkZrR1FQQ2hoUjBVOFlsS0xZVElW?=
 =?utf-8?B?d1NrakpXVXRvZDRkVW10VVRSUU5Ma2tVVGVGc1dpbThNazBuSUZpRVo4UWtx?=
 =?utf-8?B?QWF4b01CZlBhbUdES0RGbTB6b2cvaGNCamdXY1g1WXQzdEl3YXpaeGVic3c3?=
 =?utf-8?B?aTQzajEvc3NrdEVaY3ZTKzY5UTQvOFpiaXlka1FjcVBDK3g2YmRLaGJaZTY2?=
 =?utf-8?B?NkExcWpsaHc0blBydkl6ZkhidHVnc3hyNlhhaEJ2bkFhWmhGM05wQXk1bUx1?=
 =?utf-8?B?RmNxUFQ0TkwrR0d2dDhsVDFlaURmZzA5dVNMNlZOMmNsTHRjQ0tJZXVDMjAw?=
 =?utf-8?B?NjhWUVp2NEtNd3VQUysxZ2gvcllaN1pNN29GamRYRzZXNmFreFlFSjhPQklv?=
 =?utf-8?B?TFloUUNTRDZjR2I0dkQxZmE3MG5FdDFNWG00TVV4MFIwdEd0YmFLRFA0ZVl1?=
 =?utf-8?B?OWhMUUNuWDF2L1FUbzdUVnoxYU9RdnAzQnNmK05TN2RxV050bWU0M3lmUjJr?=
 =?utf-8?B?TW04VUhIbzl5eWZySXcrWlVDSERRK1ZJMkxDbGtIUjJxemdrMEdBdFFLTEVD?=
 =?utf-8?B?VVNWZWF2MVpZenk2alFCVTBzSlBSZGFvWDExN3l3WXJMME9qTHJhNk9vWFZ2?=
 =?utf-8?B?SG45N3pHQkZ6bko2K0lneGpkR2tXeFVsc0VZc2FsNXdqQmVRNVhTVmxja1Np?=
 =?utf-8?B?ejZ0cjB0NENYOGdCZGhPdnluV1IyTUg3b05YNGtiYnBmaHdhb2FUL2tJMy9J?=
 =?utf-8?B?Z2xyblYxaFFPNmNSOTVQVlNmOHVMU0VDVmRhVVpWVFdtL3ROS3dlWFRuN01D?=
 =?utf-8?B?UEpaWXpMZllhVElvS0dPdzRZR3N5WjJJamhZTkFlYXhSa3ZESU1Yd25ZK2dr?=
 =?utf-8?B?UzlVN0RUU2lycG5VVG9mbEJRZ0pqWGw0UnFBalFib0NYT1Q4WElHbGFqQUFK?=
 =?utf-8?B?NklzYkR0Sm92aHRyMU13UGNXdlY0WGVxSzNzcW1WQ0MzYy8vc0dCR2FEa1M3?=
 =?utf-8?B?TEErUUdKUDBMOXVsSXBWTGNBeTkvelQ1bmk2VXNselMwRkhuWW9hMWU5TFor?=
 =?utf-8?B?dGpuanRoWnArWXBYay8zZHJ2N0R4YmFlZnNGcUM2RDMvSjZhejdocjZKakIz?=
 =?utf-8?B?RGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: W8/2PowqRASrFDOm8/Ik7z0mqUDGqqocEe12w0v0LWq3ydlFDtwCNI1qIR7hyhHiUCyZ7zJp0aLM0AJRfu9b5XxZQsuhj/4rS+bFz1FS18a9AkFeCV5Orx1MH+/XqHkDE8Fft5FGRpq/drD92AN7QDSVaWyZ6wPAmmBrMKL5h2txyFnw4KCY5xC0/1d59FMK4kYHMdkVadmUYvlNsow4CtWsxhPD/hf3Cke9qS9v9WfS+q9fuXSpllB62vyC1HGSigV+bPjckFwK6Tguz6S/N6OHl31uqkH9txOw9zGKu1wAt9SPKtdEOLEINRfRIRN7wgr93m01i5WwC2BKcAX7LNtJYRmiD0vxAiSkzzNsEX6mDYJox7+Bc1ITMEEhHoqETlYH1gw/ueoTX0dzc5bT6mUgrTCFYUs1/n7ZOzyYgpZiGbsSDj2pRqMaUalh+bHUvcsdQSN8qBA7RqRvRFYejgk7mXeAT3+ZFbOpSOYQVe29AraHfQW7KDqboW5wGN3O9SfrG3piyzaDqPNjfRwMHW0+64lRTihcPhxMFmjHUWk+n7ElylXmEO9CH2Wz8NGrNl2jOdhEwrdYqLNHkvpEHjxVGdS4PVdgB4h1c3nyRjs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c284766e-5701-46bf-d7cf-08dd77794416
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 15:14:47.5063 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: haonTGxqKWenRuxnWzzh2jvvKW5qi6zyNniKJZhELDyQd+GPhlPQPVsmoweVSirbKLekjPKWiRK8n67Xv9dmq3fY/tj7948dreg6N0Aj388=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5782
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-09_05,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 adultscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504090096
X-Proofpoint-GUID: dh8idkfN4tWK3NcV_VDGyoXDQFx-itKY
X-Proofpoint-ORIG-GUID: dh8idkfN4tWK3NcV_VDGyoXDQFx-itKY
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 4/9/2025 10:44 AM, Markus Armbruster wrote:
> Steven Sistare <steven.sistare@oracle.com> writes:
> 
>> On 4/9/2025 9:34 AM, Markus Armbruster wrote:
>>> Steven Sistare <steven.sistare@oracle.com> writes:
>>>> On 4/9/2025 3:39 AM, Markus Armbruster wrote:
>>>>> Hi Steve, I apologize for the slow response.
>>>>>
>>>>> Steve Sistare <steven.sistare@oracle.com> writes:
>>>>>
>>>>>> Using qom-list and qom-get to get all the nodes and property values in a
>>>>>> QOM tree can take multiple seconds because it requires 1000's of individual
>>>>>> QOM requests.  Some managers fetch the entire tree or a large subset
>>>>>> of it when starting a new VM, and this cost is a substantial fraction of
>>>>>> start up time.
>>>>>
>>>>> "Some managers"... could you name one?
>>>>
>>>> My personal experience is with Oracle's OCI, but likely others could benefit.
>>>
>>> Peter Krempa tells us libvirt would benefit.
>>>
>>>>>> To reduce this cost, consider QAPI calls that fetch more information in
>>>>>> each call:
>>>>>>      * qom-list-get: given a path, return a list of properties and values.
>>>>>>      * qom-list-getv: given a list of paths, return a list of properties and
>>>>>>        values for each path.
>>>>>>      * qom-tree-get: given a path, return all descendant nodes rooted at that
>>>>>>        path, with properties and values for each.
>>>>>
>>>>> Libvirt developers, would you be interested in any of these?
>>>>>
>>>>>> In all cases, a returned property is represented by ObjectPropertyValue,
>>>>>> with fields name, type, value, and error.  If an error occurs when reading
>>>>>> a value, the value field is omitted, and the error message is returned in the
>>>>>> the error field.  Thus an error for one property will not cause a bulk fetch
>>>>>> operation to fail.
>>>>>
>>>>> Returning errors this way is highly unusual.  Observation; I'm not
>>>>> rejecting this out of hand.  Can you elaborate a bit on why it's useful?
>>>>
>>>> It is considered an error to read some properties if they are not valid for
>>>> the configuration.  And some properties are write-only and return an error
>>>> if they are read.  Examples:
>>>>
>>>>      legacy-i8042: <EXCEPTION: Property 'vmmouse.legacy-i8042' is not readable> (str)
>>>>      legacy-memory: <EXCEPTION: Property 'qemu64-x86_64-cpu.legacy-memory' is not readable> (str)
>>>>      crash-information: <EXCEPTION: No crash occurred> (GuestPanicInformation)
>>>>
>>>> With conventional error handling, if any of these poison pills falls in the
>>>> scope of a bulk get operation, the entire operation fails.
>>>
>>> I suspect many of these poison pills are design mistakes.
>>>
>>> If a property is not valid for the configuration, why does it exist?
>>> QOM is by design dynamic.  I wish it wasn't, but as long as it is
>>> dynamic, I can't see why we should create properties we know to be
>>> unusable.
>>>
>>> Why is reading crash-information an error when no crash occured?  This
>>> is the *normal* case.  Errors are for the abnormal.
>>>
>>> Anyway, asking you to fix design mistakes all over the place wouldn't be
>>> fair.  So I'm asking you something else instead: do you actually need
>>> the error information?
>>
>> I don't need the specific error message.
>>
>> I could return a boolean meaning "property not available" instead of returning
>> the exact error message, as long as folks are OK with the output of the qom-tree
>> script changing for these properties.
> 
> Let's put aside the qom-tree script for a moment.
> 
> In your patches, the queries return an object's properties as a list of
> ObjectPropertyValue, defined as
> 
>      { 'struct': 'ObjectPropertyValue',
>        'data': { 'name': 'str',
>                  'type': 'str',
>                  '*value': 'any',
>                  '*error': 'str' } }
> 
> As far as I understand, exactly one of @value and @error are present.
> 
> The list has no duplicates, i.e. no two elements have the same value of
> "name".
> 
> Say we're interested in property "foo".  Three cases:
> 
> * The list has an element with "name": "foo", and the element has member
>    "value": the property exists and "value" has its value.
> 
> * The list has an element with "name": "foo", and the element does not
>    have member "value": the property exists, but its value cannot be
>    gotten; member "error" has the error message.
> 
> * The list has no element with "name": "foo": the property does not
>    exist.
> 
> If we simply drop ObjectPropertyValue member @error, we lose 'member
> "error" has the error message'.  That's all.
> 
> If a need for more error information should arise later, we could add
> member @error.  Or something else entirely.  Or tell people to qom-get
> any properties qom-tree-get couldn't get for error information.  My
> point is: dropping @error now does not tie our hands as far as I can
> tell.

Agreed.  I forgot that I had defined value as an optional parameter,
so simply omitting it means "property not available".

> Back to qom-tree.  I believe this script is a development aid that
> exists because qom-get is painful to use for humans.  Your qom-tree
> command would completely obsolete it.  I wouldn't worry about it.
> If you think I'm wrong there, please speak up!

Regarding dropping the error messages, I agree, I was just pointing it out
in case anyone objected.

Yes, the new command plus a formatter like jq obsoletes the qom-tree script.
Just to be clear, I do not propose to delete the script, since folks are
accustomed to it being available, and are accustomed to its output.  It also
serves as a nice example for how to use the new command.

Do you want to review any code and specification now, or wait for me to send
V2 that deletes the error member?  The changes will be minor.

- Steve


