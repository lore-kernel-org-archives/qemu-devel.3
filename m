Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 882CFC36002
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Apr 2025 17:49:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2ZXU-0006Am-R0; Wed, 09 Apr 2025 13:48:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1u2ZXO-0006AQ-Ao
 for qemu-devel@nongnu.org; Wed, 09 Apr 2025 13:48:34 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1u2ZXL-0004l5-Ex
 for qemu-devel@nongnu.org; Wed, 09 Apr 2025 13:48:34 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 539Gu2dh012048;
 Wed, 9 Apr 2025 17:48:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=TMnVd9WXch0x7O7tAgjFZJ1UkJUBNxe09UtNX59FAL8=; b=
 nTwCzqUF5IxFJC4AsHi8zpCxN7HU6KUlM+C7zU3lPob7s21eVEIPQFu+t6c7eE7q
 mieo+rNLg7AdpbTR/m0A4rKfmQIXo1FLnYPkh0AbJsFSsi3nYXEQA5gQatgRSNt2
 T+MFiQYCdnPNPql+w+29Kv95QUjxUc8/BvGPNKpDJlfD9X5stN1dkC/QINM+B7Ol
 FiI0XJDlQvGisr9g5hxJS/u0BdIp/iEEb78248oyOmPXzqq7LZZbFZOVXC6V2EfV
 B0NSUWAWLqB9htoHtXX/SGG+re2aeNeEvtiomPNUaEWG9+fk5hnKTyKSJQTv3vEc
 j75UuTE5vlH8TZ7SiOZzrQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45tw2tqt54-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 09 Apr 2025 17:48:23 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 539GjYKM021200; Wed, 9 Apr 2025 17:48:22 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 45ttyheyg3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 09 Apr 2025 17:48:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qdVoArALE/Z0RG6CM0atzHLgScml1Td5Od7MpsClKDPihd2oOz8HMAc2GlkDuxj93tBn9/MWT/TuWa8QFKs+nwahOKby+9iUaTcMwqxVX5yRq5Q9NI5Fkm5JXe9LwS63t8Gzn1qgy3J4Y7PzbB7ARsE6FeAyECJhThuPk4knoI+V1PZi0orosiBR6BzGrh2pZZkaL00WH7F2PJ0wWSxRrDBX2ihqMankG9fmhKdLR0Itdc9NQ1uRLoEzOwh0nWbdM7d/l9rutysi6tlZC+OR+R6P17Ww42FA+U7Sshrnl4EaPLcRE2dvJRzMrumK+cX4Ba1DnWKkkTaYXu0kodKc/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TMnVd9WXch0x7O7tAgjFZJ1UkJUBNxe09UtNX59FAL8=;
 b=wnjkF93kFoeVxqLsB/Gb4/qUR6xnxVw3jE7rUWgG1wktyUq8bGpde2yfORIW/rZ7JXGRye9gz2jU7k1DNBHVe47chGrhCC0N62Dla9Y2roD1C3Rs3fxSwVqE9+6/gxY4kAGqSUGRJvj8UPYZzrUxK6tCIqMBEfNiFV3kzk225OMaun3REzIFJMVD4uIQWpaLPthfBgZlicG9RoMhTUeEOMvJAuaXsMs8K3FbiP7JTqAYODWc+Yt7+347LMldf8euvDpZA6cSrST42Lu3AdAM2i/PG0JS1aN0enUARcl/wObSRNMPaZQ7OxfzyEKA+4zcts/kTsinFe4m52m+oHDpQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TMnVd9WXch0x7O7tAgjFZJ1UkJUBNxe09UtNX59FAL8=;
 b=tH4fig3DFElk7ftrcb5i5rp8BV5jigtkkWi1f6twfwhsryYvQNKAyklx4i32ayXjhCLO3u/HMC1oeTA6cQExtcO4j4i1Bpxi2M7PIxipqdUq3oAoqr9QVsm4krIXxlatSypFekIH9KSt3H7e503lDd8Bk946UUdDoiQUmCSRiFw=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by DS7PR10MB4863.namprd10.prod.outlook.com (2603:10b6:5:297::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.23; Wed, 9 Apr
 2025 17:48:19 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%5]) with mapi id 15.20.8632.021; Wed, 9 Apr 2025
 17:48:19 +0000
Message-ID: <024c7687-42a2-4d90-a91b-f1ff27dc34bb@oracle.com>
Date: Wed, 9 Apr 2025 13:48:13 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V7 00/24] Live update: cpr-transfer
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <1736967650-129648-1-git-send-email-steven.sistare@oracle.com>
 <631d25f6-b37a-480e-a178-06f66033018b@yandex-team.ru>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <631d25f6-b37a-480e-a178-06f66033018b@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0205.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::30) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|DS7PR10MB4863:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b938361-7e59-4cf5-dbc5-08dd778eb6ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dDY2cmMyRDM5d01ZTkZyZmU4SGR6cDlmUUpiOENtcndITGdLc3REeExxaDA1?=
 =?utf-8?B?Uk9LaWVXbmdLeTJWNXQ2a2hTYjRXTVFRQkdGSFNncnhsa1RpRUh6OEtzb3pX?=
 =?utf-8?B?ZnI5dUZhSm00eGNtWW56M2R5QTQ0Rm1oc1lUN1Y1VGNVWStnenpzQVZ5SmxT?=
 =?utf-8?B?ejYzRVkyK3g5Z2h3Wmxyd2lDZ2hLTUlURHEzVUFrQityMUtibzhaVmI0alJo?=
 =?utf-8?B?OEJJMVI1WHNLUHdib0NRZ1Z4UnZJVTg1WTEyWUd4ZW5VTnFVcllDdFhDd08x?=
 =?utf-8?B?QjVZa3pBYTQvc0o4ZmRxTUFTWDQ2eENGV1EzQlVSUGhvSnFzeURGZnh1eEMv?=
 =?utf-8?B?QWZrcGxTQjNLa04zY0Z0S0h1VEc4TjJSeEN6eUp6SEVYRlplQVp5eDE2QnZT?=
 =?utf-8?B?VzkxbXRsT2d3MERHS3pUaHNoOTYwa1Jta2JOM1VzcGlpeXMzLzBtUldiSzdY?=
 =?utf-8?B?azdNSUkwclk2VlVUTnNDeVZBOTUzVGswQmU2YTlTcE03SmNiTXZXTVQxbDlq?=
 =?utf-8?B?YzIvblpBa3RWK0J5UjhqNi9KaWhSb0VLaVlzWSt3QVFiaU5kaUphcUNlakNo?=
 =?utf-8?B?dE9CQnFwd29CU1ZoKzd3bnVtNXhNNytlclV4QTBXSVI4SFZLb0NCQUZBQ0VC?=
 =?utf-8?B?dk1wT2tUM1NIVUpJbnB0YmlOU00yYVpkTWxWdkhuaUdVM3BwSjRBOGZJQnhE?=
 =?utf-8?B?VitnU0xOeXZHTU9RbHN3SnAybk4vTitHOXkzVG1IQVB1QVBHYnZTdTlFc0FG?=
 =?utf-8?B?N0N2VXVFLzRweVByd05BZkxtMnZianJsYm1wRWlTcDFGVE1JMk5HRjNZVU12?=
 =?utf-8?B?L1R2MnppYkV6dm1rYkJTcHdjUTB5QlJBWWdCejVkdDIzV3h1Y2hXeGZrYkZW?=
 =?utf-8?B?WlZwZ0tlemxFNVpWYldzNWErV0VxaTRKMHA5WFFwT2ZmSzl3dndYbW5lcUNS?=
 =?utf-8?B?a2VMY1E3dnhTREVlWTVUYnpJdnRjSStMSldBaktONkY5ZG1WRzRqM1NzbmdP?=
 =?utf-8?B?dVpjcitpRGRMWW9GMmR2WExjVFhLdnVIaCt3UUQ1dUFtSWNUTkFkU25MN1BK?=
 =?utf-8?B?Y21ocC9mRWNWUGsxbk85Ulp6dTFpRTFURFVNT0pvMHE1WFd3WEtpY2RxZ2JX?=
 =?utf-8?B?c3RkSHhnNWVtUHdEaUVES2dIUDBBakhLREFqL1NwMHdYM3RocFFJdmV2aExa?=
 =?utf-8?B?bWdyUWZUNGR1VmpZWTloMi9XcHB2aEo3cWNqRDI1TFdqUk9pZEgrUmFwTmRT?=
 =?utf-8?B?WllxbDhWc2sxNUd5WHQ2dUs3dmQyankzL1U5Ky9mTlh5U2wrUGxDY29ZODJk?=
 =?utf-8?B?K3p0d3ZtNHNEdHBnUFFObUgvQUhYRHQ5ZTE3UmNEMmJIUkxBS0RCQXI5dnhB?=
 =?utf-8?B?cnV2ejRHNCtlY0RtaHFxMDVkZkNXR3hiUDFZTVA2MklHMGdRdFlucGduUHRk?=
 =?utf-8?B?MjRKV0hWYy9TWXRVZHc3bHpVeDJZSk8vSXFyMkJQb0ZVaFZyVTZuTituK3l4?=
 =?utf-8?B?N2xqUng5b2paUHB1NDJXTTFWOEFHS1V0TzJDTW4yL0t0N0E5Zjhxd3NFcmpC?=
 =?utf-8?B?Y1YzS3cxdGZXS0tYY244SVdOTnoySU52bE0vZnZLamsxRUhQcSt1QzZnV2ZZ?=
 =?utf-8?B?YXROSnIwR3Rva1JiRTNMYTN5M3JISExPUkpLQkJsd0lxVFRTN2oyb0RSa3Rk?=
 =?utf-8?B?WnhjUXF4RzdSdEVPMElLTUhuTFI0bHRYMmZSVld5dU4wWDYxdkU3RnJNaWZO?=
 =?utf-8?B?TzRENE9FQzF3ZXRFM1J6a21waEhzNldGaWw5STZ2YWpRQW1QeEtLVzZBRUpV?=
 =?utf-8?B?Q3p6a1Myc09uVkkvTEZGeFgzMHhyZXJXaU1TTWpHYnJuU3VuYzB4aUlXN0tX?=
 =?utf-8?B?TGMyTjhqbEpZby9YdUFnelh3VjFDVVdENVppcUhIek53czFxVWg2WVNIZzhS?=
 =?utf-8?Q?RKrU5K3KjzQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cXlFL2g0UTkrSDFLRDk0MktsRW45b053SklKcUJWS3M4OU9GU29EbUlJeWRR?=
 =?utf-8?B?OTZXclRldUlKQ3RxQzFORmRSc3JZRXpWVVNZanpoMnlrR0JWZ0c1RkxIQkZ5?=
 =?utf-8?B?U2hyNG5yRS8zMEVwSlVuUEFiWWlPakpuSjFNa2VrNDJxZDJVUXdHYXd1ejZz?=
 =?utf-8?B?cWV6N04vMGtoTlVCSTk1NE5zSzY1eVpZcktaNUx2UE5BRTd3azMwTzNQWGtn?=
 =?utf-8?B?clRleUwwcHNHejJyZkVZY2N6Y1AxNUpJS0NFQmpGZXQvQS9HL1pLTmZUdHd5?=
 =?utf-8?B?dVV4S0thWVlYMFBRTU9FTzREVmV6Um1ZZGlha0FQUXowU1FkMzU2eXRKdG13?=
 =?utf-8?B?Zy8wRHBHbmp1dHBJQ3g3Zk9BQnBOOVlEakxxMzkzNFBnTTlLcHV2SXV0WUk0?=
 =?utf-8?B?Ky9aVTFuWlVtcC82RmF6S0VWdmlaZ0JhTEoxWU5jK2JLUGJ3STVyQzhuWjFj?=
 =?utf-8?B?WlBFd21uaHFIZFZqTjF5VDBla3NrazhENXAwNmE0VENNeHE2OEV2TnRWT1ha?=
 =?utf-8?B?MFdJVmQvRTdxNU1WUTVFQUF4NWo2ZmI5Mnd0bmpoSmU5QlJJc0hpTUVCYmpv?=
 =?utf-8?B?VFptbERTVWR1ZXNXbUVYZ3FaWUlpck9aWk54V01oSW92Y0NqU29GOEg1UVF5?=
 =?utf-8?B?YUxoM09jTWNCdjdGSEl4ZDJKZk9YTUl4N2w2QXpoUHhWaTZNUlpaM1JhUDVw?=
 =?utf-8?B?ZUJ4UGRDS1gyeGhybWVmUll4OWdJMk9ycTloWGdWeHc4ZEJVbmRhSHgzVE5j?=
 =?utf-8?B?Z3ZtTFhkUHJtRE1rc2dBY2YzVkFhSDJ1QllsdVhuRTJidUxlMHhKZDBDM0Er?=
 =?utf-8?B?RVR0Zm5YL041TlNoWVlWZnVHRW9xUjBLMlVlZFc5UjIzZXg0d1lBUzkyZzUw?=
 =?utf-8?B?M0lMaVN5bW5jOG9kY0RUQ3FXK2lFTEVENCtieUNGNXY1T2NoRnFTbTlBVUF1?=
 =?utf-8?B?eUQyNUQySmNJbWtTYkdWUkt0VnNEMEFGS1lleGhFS3hpbDVzMlJSMHdhVkF1?=
 =?utf-8?B?S2wyblFsTHBJNHZENkg4Wk1JOXlMNHJMV2ppbVBOUGEzVkdaRVRJMXVvU3Mw?=
 =?utf-8?B?UWp6S1RCaGRXczlUeDlCcm5XYXVieXhFakFKdXZNcGxYbWVDNlM4TlJsTUp1?=
 =?utf-8?B?dG90TTBFSXp2YXBMWjdrSTZUbUZOZW5KZVRjb3g5RmhCSjFZUlozbVBPL251?=
 =?utf-8?B?U25JMzVyZ3B5K2pLeUxBeUhSQ0U2RWtCdXNpMitHQzI2SldmSHZrWXF6dzhX?=
 =?utf-8?B?ZGhDM1BvNGo4SmJGQXZHV2RpQVUvais5d2RjOU1VTWtPaWxhcWJVdUd5RXdN?=
 =?utf-8?B?WEFWaUhPMjhYSmtWZExTcXA0N2R0TVd4c3B3WXpsSU1zSW1NZUxUZ1NKckVy?=
 =?utf-8?B?RHNRRDNRSmU5cVJsUis5djF4NkZ3YjVwb0d5UkUyK2hXZkdrakJSbFg0Qkpl?=
 =?utf-8?B?QU5ZVXFTMFdHb2UwOGJGTDJycS8wQzFTYTUveitmRVB5NlhBayt4YUFTZzRq?=
 =?utf-8?B?ck9WaVdGSDh6Kzh1UzEzSmxrRUtSMVVmaDhCQm9tWUd3TlFnWTErRURDRE9L?=
 =?utf-8?B?YXB0Wmx3N3JMKytNZDM4WHJiamhQeWdPNjNQMmhhYWdDcThYUFhsTis3TVo4?=
 =?utf-8?B?M1JkM09sTzNpQlpwczg4VG1FWW83Y25wcnZnWVNFSndXdzRmb2tqcW9DVFNv?=
 =?utf-8?B?Y3VnTVFESlRDK05GcG9MTHhRM2RUZ0dpZVZhTWg4UnE4MkpEcHVlNk1uY2pL?=
 =?utf-8?B?UlFPQlFkM25ZUVNuTzBZK3dUQ05VbUNPOVp1WUNNVzZHN05uL2s2cXhKYW1y?=
 =?utf-8?B?OXZQNGMwbHkvSEc4MzUrdEFuMm1MSjVhMlV6QkFqcytOdzZPS1BoZWd6WHJa?=
 =?utf-8?B?RVhjOEpvV3FmMWNxa0dJWnptQ1MySFNselRWcUZuTy9CelE4UkdhZHl0bnpM?=
 =?utf-8?B?bXltY1d6L201YjNHWjZiZmZ4ZWluSm92c1pqQXA1d0I0RVUxQTlmYTFKb2x5?=
 =?utf-8?B?Q3kzS0w5Q1gxeU1XZzE2RHZ3WjdzaU81UFR5WjZzeEhQK2RUdHh5cCtGSXg3?=
 =?utf-8?B?OWFJZzNSR2k2SzlJNW1zV1NWSUVmL1IyLy90ZE1PMmJGU3Rjb0NFVzd6S2ZG?=
 =?utf-8?B?YnBTck81a1lNNTFzWEpyUlBWZEIvckF1RHhSYkVCVndWSjd2WXozdkMzUWNm?=
 =?utf-8?B?dGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Q6tN/gnDP9fij8I9v0yifswLkoqyxgfLPQzQnHPbbLuNGPFgJYsTDPUuX+a8dISbiUQWpXl4aEtXW8NgKGSKRbg8Fl7knYuDFtq4qOa0Sd147SGpIxGdwgAJJ8vWupbAY2L7X3rk8fzslham1idnqORvX32QAaiOu2DmThvkK7IKAwM8tWg0qxPqW5Kmhs0QlT0sp1QjKNvFY/lqLMEph+BtoSlXCQhJcvP0X2gz+f7Lbw0uL5U6q6RLUZim2XlbvXrQNm+0wXqlhAD0XhW0dgScSmqJjd1qYfPmP6t0dJ0KeGZnSczO1WEl9VBrzw6K91ma++H4h/8abvBKWWsMppS3MA4Jcb+cHKWrJYiq7VnBJ4NwMVq/M/WdUZxfJAs4u1v12L9G31+JT8kOVY5hZs8IfOzcDr+ElDTyZoIUs/LoYC9wd8fbcBzoqoD3JoqZ520YPLmnAR+Nbte0o/5qeeigo2I510UNlPDDvWG14QL0D+t7A5BLe0Rmx6jvNaz4FPEgX+S+KOOYSXRRmuDQ+XF7zrndUeolwI7syJMzDDdlfqA9apsTv+CdVveUm0Svg8VZLDsQxoDkM8i88iFJq2kq2D6hA1X5G0O5nK4zk1w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b938361-7e59-4cf5-dbc5-08dd778eb6ce
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 17:48:19.4617 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1xaJx4K7Qah1k7zwNgsuFzQJiAJ+y7++2Hk3iqMTb4sJRUK538mz1mBeOkk8VZiAc1CUr6p9sc0EoO/hYzBWihTobNuiKy8gRfzIDMzF3Xg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4863
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-09_06,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 spamscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 adultscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504090115
X-Proofpoint-ORIG-GUID: rE3B_AVEvVKFBklU5Jw5YuNLAQSUaNQj
X-Proofpoint-GUID: rE3B_AVEvVKFBklU5Jw5YuNLAQSUaNQj
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

On 4/9/2025 12:22 PM, Vladimir Sementsov-Ogievskiy wrote:
> 
> On 15.01.25 22:00, Steve Sistare wrote:
>> This patch series implements a minimal version of cpr-transfer.  Additional
>> series are ready to be posted to deliver the complete vision described
>> above, including
>>    * vfio
>>    * chardev
>>    * vhost and tap
>>    * blockers
>>    * cpr-exec mode
> 
> Hi Steve. First, great congratulations with finally landed cpr-transfer! I saw the history of Live Update series was started overly five years ago.

Thanks!  It's been a marathon, not a sprint.

> I've some questions, hope it's not much trouble for you.
> 
> 1. We consider porting cpr-transver + vfio part of your "Live update: vfio and iommufd" to our downstream QEMU, based on v7.2. What do you think? I mean, may be you may quickly answer "don't try, you'll have to bring more than 100 commits from different series", or visa-versa "we have downstream based on 7.2 too, so it's possible" (OK, seems the latter answer is not possible, as iommufd code just absent in v7.2).

I have not tried it, but I think this is feasible if you omit the iommufd patches.
You will also need some of the cpr-reboot patches (like mode-specific migration
blockers) which did not appear until qemu 8.2.

> 2. About cpr-exec. Do you plan resending it in future? The solution is interesting for us, as it simplifies management a lot. 

I agree!  I made that argument when I submitted it.  Perhaps your +1 will add
enough critical mass to get it accepted next time.  I do plan to resubmit it later.

> I read the discussion on cpr-exec, seems the main problem was the security constraint, that we don't want to allow exec call in seccomp profile. Didn't you consider a variant with loding the library instead of exec?
> 
> I mean:
> 
> - turn the whole QEMU into library, which may be dynamically loaded. Recently there was a question how to do it, and the answer contained an example patch: https://github.com/pbo-linaro/qemu/commit/fbb39cc64f77d4bf1e5e50795c75b62735bf5c5f
> 
> - and make a simple wrapper process for that library, which also is a container for migration state (including file descriptors), during live update.
> 
> Benefits:
> 
> - no execve, and we just need to add pattern for "qemu library" paths to apparmor profile
> 
> - probably, we can load new library _before_ starting the migration, reducing freeze-time of migration - more like migration with two processes

I have not considered that.  A colleague suggested something similar -- loading the
new qemu binary in memory and implementing exec in userland.   No doubt either
method would be a non-trivial amount of work, versus cpr-exec which already works :)

Personally I don't think that requiring exec is a show stopper. If qemu is deployed in
a container environment, then the potential targets of an exec can be limited by the
container walls.

- Steve


