Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21033D1BDD3
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 17:39:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t812I-0005da-1O; Mon, 04 Nov 2024 12:38:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1t812F-0005RU-5H
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 12:38:39 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1t812C-0001U5-8t
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 12:38:38 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A4GMciS015619;
 Mon, 4 Nov 2024 17:38:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=QFKtFjsnCcCDOKuyPORz+352lxb953VGG2KBkQeij40=; b=
 chnNQnjAt7XYpqY9pYz1532czgdxAwIAgBTrgFSz3R3x1CpNt0z/VsvUhCYKMMk6
 3NJh7L68EeGpe4O2nvicnP0dde1L9vfKfcut8wsMt9fZC3krKNzbCR+WzeeetnIS
 PCzx5o07bfx3ihVkQTfiTZpNOhc/mgZUErKMDFrNSYoKn5SzLtNwQil6wsF1CtdO
 QNthVlF6DIuOiddIXh3NQMqA1tD0P2MDR3XZdZdwTAXYgg8+xqkPWKBcdM2nQGnO
 dXv1eAav5We+UZTYppk7YqCxEbAATuXaXW8htNV55vybvbtmzg23gJXvzghGQfRB
 W+ESAM9dKiaP+mZyiT6ysQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42nby8ub93-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 04 Nov 2024 17:38:28 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 4A4GJpp2036151; Mon, 4 Nov 2024 17:38:27 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 42nahcbj2y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 04 Nov 2024 17:38:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jsra35uYj/RF2PhQ4aZffN6/nJZgk+YY2rdjF5tluC1atKQVq+2/i8Tn2/UHohn/Jfcthe02Eq9oOdkfNgH/Uqg7MDPg6x/fBdI8S3hfS53qPIb6aH/UYBo/HVNsCvMIglYyY7vq2amHgyllfo+owCglZPdKTpWER4ve0nY0G8ogh2m3xNfFr4zEf3OQdYqFAikLYr1sfOYQWLvSHN3NRjX4HgwzpS0yC9denTlIMLP5M4rRSGBLK55YTyW/OiZvAE6Rwak4FnMf94v9KoJc6aCiEhX9Obljprpms82/0hVNCg8mUw7lhBp8TyQVanKy3jNKp5+OfH4HXOLEyx9HmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QFKtFjsnCcCDOKuyPORz+352lxb953VGG2KBkQeij40=;
 b=fO7U4E2+pArNXg5h7fsy0z/mOaDFCqfRXkM9KB/5AGFspiYAwpGUdQJoKMcJMnCqfsBekWPXd7rBTX75b4q5E3ERcTLvnQxc0XY0Qitb3Gk9URVd9j7PKewCDjTG4v98mDU7WOzw2+7jf8Dx9+N6vymmwTrUpMQ3A9mFy6qekbkBz/Dd420jR7YNuBmr7uKaCh549AbO2HtfiaCrwTyr2guzmxwF0nnu7NWCmWDiQMTr3sw1G/neDL4LosLVjRWc5fC82/Tnd6UUzJcp+xcOxuGndd1ovCnQoTqV3hYzPtHZwTAauFaq/6K0KBJQifolx3N0X+YKPGmUenwhrk31+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QFKtFjsnCcCDOKuyPORz+352lxb953VGG2KBkQeij40=;
 b=bW5RDKFLGlNJnwm5DYFZRAyEpdO1SuS4WGswmIWY38wXvWQJa2Ofc5kuYXGSvdlsVE24xN58MQbpHvy7X5beU63NFi1rfb+uM6DVh2ITGFzmJkn6mjhFhCuOBxd1n1+7ZA20sMJtmilNuF8JLj0Khed+QAySrFg4LydWID+0K7s=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by CY5PR10MB5963.namprd10.prod.outlook.com (2603:10b6:930:2c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31; Mon, 4 Nov
 2024 17:38:24 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%4]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 17:38:24 +0000
Message-ID: <45ea8a8a-928d-4703-b698-d5f910e6a224@oracle.com>
Date: Mon, 4 Nov 2024 12:38:19 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 01/16] machine: anon-alloc option
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <1730468875-249970-1-git-send-email-steven.sistare@oracle.com>
 <1730468875-249970-2-git-send-email-steven.sistare@oracle.com>
 <78fa25f1-03dc-400c-a604-998c53e4fbce@redhat.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <78fa25f1-03dc-400c-a604-998c53e4fbce@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR17CA0024.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::37) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|CY5PR10MB5963:EE_
X-MS-Office365-Filtering-Correlation-Id: a9fe21ac-fde6-4a53-b8df-08dcfcf77ba0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WVY0U0I4MkJsZGwzVFhEZVFhaWE3UWQ2OW9FMzk3VW9FYjBKUjJqcFQ0emky?=
 =?utf-8?B?R1RJdFlUMXlJVzRMUDBTMW5GTFlWbFd1NnR4dGpRT2NoS2NycFlNK3JJR0F0?=
 =?utf-8?B?L0lyam84THRIQ05CdkUzb0xKV1FJSmw3MWc4K09MOUVnaXpiTFFCZVhsVWxJ?=
 =?utf-8?B?UHN3ZGlETUgzM1JXTWNyblpsblJ3SFRSY0VDbWlKQmpDUklYeHNtQTY4K2RJ?=
 =?utf-8?B?Z2EvaE1qNnpjT3J2dmR0Q2QybHJjd1R4ZklsRFFpT1c4Q3JiaGM0TFkxenpo?=
 =?utf-8?B?RityVFpYNFgvbCtpODYyMnI0dFFoNnY4bHR5WWlwMnkyNnhjNGMxaDZwdk8v?=
 =?utf-8?B?Z3VtTnlFRVpkVzE2UTIvaTZpQnNIR0FjRHhPelNhVStzUmNBVFVpNEFWNFZt?=
 =?utf-8?B?bFRnb1BHYmpYR2VHMmdWQmtSVkkxRmtOOTM3KzJ2NGVoQUUzdlUyTlBucFFB?=
 =?utf-8?B?SjlGNlZQRVpwSnJRL0JPeWszQ1VOUXIxeFRTeWdxMjVKdTgybGMvWmF0S3k0?=
 =?utf-8?B?bzhZdGRaTzhnYmkwUzBFMzdjWklIemtwSGlHUkdWQXZYRlJIMWRFK2dadThn?=
 =?utf-8?B?blIwNktvb3VtalB1VVNtUll2eFdvb0ZBTnRFS0M5UjFaR3NTMTkyZHF0eUtV?=
 =?utf-8?B?Z2J6VFVBMll5SHM5YkYzR1NtSmJKbnhIT0tvaWxVdzN4Ukd4c1ltOUpqWFFn?=
 =?utf-8?B?RnNaTjZkczNwSGNuNlpncUtoMWZaam05Tndid05lWEZrWDhqcHh5aURKUmU5?=
 =?utf-8?B?bE5OR2RSLzV6T0VOcTZ6Y2dDeEFUTUxoeWhYc1BGaE1pQUdDanFnQXRTQ2Nt?=
 =?utf-8?B?NmJZdkVPZ3FWakxGUlJjMm0rZ2l1dTZaVnNDUC85ZDZybDlMOHRwcVRra3hU?=
 =?utf-8?B?bFQ5a1dtRzcxZGhhL3Z3SWhkc0VhNWJJV2cyaEhveVEyWGQxTlZrY1B5b1JS?=
 =?utf-8?B?RUxjZUFNQmZRaG84OW9ueTl0SmNabEJsN3lGV3A1dU9qNmMvd2RBN25lbkJJ?=
 =?utf-8?B?WjNwakVjSCtuUDJZdW14dkhoQzhENzA0ckhGd21VUnRNMnl1b0trNHNaRG9P?=
 =?utf-8?B?QU02VEltbm1WUGRxT09BcjlvaHIzWU1uM2JBUWU0Nmw1MDk5Z3pIb2hlcSta?=
 =?utf-8?B?R2JxWFlQblZjazBnRzRQRVRWWVp5dXV4dTZLb0xTQjcrU0s1Nmwvc20yenF1?=
 =?utf-8?B?aWFBVld1WjkzQytqbnJJeWVMTzJBRUJ5MEVPZjZUdGRNdE1uV2k1bVlCbHFh?=
 =?utf-8?B?Zjg2TUJYY1VNdmNXbHp5ancyVmExODIvLzRBWEFwcGtwZXpSUXVnenBvYkhG?=
 =?utf-8?B?TmJpRmFLQVQxeUlIR2lMYmE5Vm5MWjIvemFKVmxndDZKT0p4M2ZNY1U1akk5?=
 =?utf-8?B?Vk1TbExvRmxJNjZIclVKU1p4UUlYSXdQZEZabUgrWHBiclFNekNqbmZsSFRC?=
 =?utf-8?B?bkhGVkZIcTBrZmMvUEFxMjU2K2t0cXpUc2tnNzlneUdmZFIrRWxVcVVSNWg2?=
 =?utf-8?B?WHhoaGdzUE5CSkVtS1ViN2ZabmNrenp1dmw0MGxQTUxieXNiYWpyY3NGSFFT?=
 =?utf-8?B?U1Vtb2V4ekIrK21IY2FKVDJYZ3NTTXMyaWRnWldrNCtaSmhJbHIySTZqSHhG?=
 =?utf-8?B?dXFOMnFQc0ZPd0c1OGRJVGtHYkI0L3M2bUllaExWYlpEZ1VvTTJTOUlDcjkr?=
 =?utf-8?B?WXZGN2ZFM3VXNHBTS1o3R2g0dFFSUmZ5WkNvVU1mVmhhR0Y4UE1IR3VHa2hQ?=
 =?utf-8?Q?QreWXQe2ICoHYB5h5Wy6zuotNv643B8ctWpBhOq?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXpNcllFWTNIVXNvcUo5WDZqWjhHbk5MZjR3Z01MRmpVeHBRcXlxMDhsQ1oz?=
 =?utf-8?B?ZGQwbmRJd2F3TXM2SCtISW9GTzVwU3lDdm1iM09sUFZqWGNYYU5OeHdZK21Q?=
 =?utf-8?B?NDNPWWw4Wm5aR1VURzQzTWkwZHhLbWFGR0VWZDZneEVxQjJCQWdvTm9OWW9o?=
 =?utf-8?B?NmJjU3dsbGVaUFg1SFBYZjNOVVBWWXRvMWpMQ21xNXVSdlJjRHhuamJTejNL?=
 =?utf-8?B?N2xRWDdRdlBEbVI1MnN2WWRhSWw4TTEvSHZ0T0dTSmJoYjk2eWlteXdsWXlB?=
 =?utf-8?B?dUZ1aERYenFwek5vMVZuQmJtcHlZRUM4aFFxV1QxVTJ3SnNIWTZCcXFnS0Vv?=
 =?utf-8?B?amFVV3dZTTNNWE5jQnlaUTBGdHhycFRXTDAyY1BGY1NzYmQ5Qk0vZWZrRmto?=
 =?utf-8?B?dVVxTEs1a3EwamZTMXVOdDdaSlFLaGN4WHYvclBJUEE1Tm9jcWR1bFE5b09t?=
 =?utf-8?B?NVkyTFhuWEFCa3JVck1rSm80UXozUGhxdWdhTWRsZUc1MUNvcXErV2hLa3lo?=
 =?utf-8?B?dzUwV0RjZ0NGc1I1WlZGS3VrckdrZlArcGJ1R0U0Qzl4N0JveFkyNHJUUVJx?=
 =?utf-8?B?YUpKM0ZlK002VUpLOEQydmo0TFZsUVA2c28rWVpFb1Q0VHFHYkJ4aTEyeTkw?=
 =?utf-8?B?SjcvdTd4MnV6aUJ0b3diNkt5b2xHdzdrRVU5RjJyRExoOEh5N2U2Vk1WaFVq?=
 =?utf-8?B?LzJ4NEUyOXVVYjdpU3A1WjBSNjF1ZUtJbUNjbCtldVZudno0RnUwMW5FeDB0?=
 =?utf-8?B?NEpJZzIvbDVWUFc5aTJQSnRueExtelAzdE5vaEZFVEdhanlYaFhJT3FKb2Mx?=
 =?utf-8?B?d2VGaUpscm15anBMZDBuUkdzd1BsT1VhK3R6WGlocURHWVRtY0d0ZGxEWUpC?=
 =?utf-8?B?b3gwbFYrTnlhS3ZwUXJvVmJwaDczZFdVZXBES1A3UWN2dDdtNVVtYmJEcjMx?=
 =?utf-8?B?ak81aFJLQ1ZncG5WbGN4d2NmNm9VejNGKzF3RUVBZnJFZlVkSkRUOTVlM0dR?=
 =?utf-8?B?ZWg0Z3R4RXNIT1JtMjdScGdCSWJEbzhZRGVPUUJNT1k5dkgzMEpLeGJERXlF?=
 =?utf-8?B?VUNWTllacmJ4UldIbVFTbUw0aEVVeDhKclZTdVA4VWJrcjRYVnJrY3hMRzB1?=
 =?utf-8?B?MllsZFAwa0FLMmhFajZPKzJjTDdqNXFQNnpSRndaa3A5RzNOK0hzSXZQUlJH?=
 =?utf-8?B?ZThrTmlUS0hSWEZpNTVGY0NhWnovdnRUaDQ2NGxtL0VlVVZqMjlGRGV5RFlG?=
 =?utf-8?B?bndKVDJMMjY0YkJLclBrbGc5Y2gzVTJKM0w3NmtMTXZPMDNVRnZ6VjEzRm1n?=
 =?utf-8?B?NllnRStmMDkzeUpnZDhXZWNsOGxyYUJyTXdNYUJOc1o0OWZCT2RVYU1yY041?=
 =?utf-8?B?eEliRmRZRlovbUpabWtvTHNSWXBVSkVlQUlCQWtoR0M0VXFOUTlxWXRZaEF6?=
 =?utf-8?B?SnlNbnhQckllR1RoZSt2YW8waGFDVWNKREd1UFBEZU5xSS9yaFlSTG9HTm1Y?=
 =?utf-8?B?a3RXb0xtWElkY3U2Y2psbGo4VHlpK050RTlGcWtaeEh5VjdKWFc3UGF5WkV4?=
 =?utf-8?B?Q2ZlZElDelJvdVkrUDBRSW5oNmlNaGswM2RKenFsL2k5QUViNEd2RkNnU0FK?=
 =?utf-8?B?Z1JjclZqWndZMmtTcEQvWGUyM1JVaHlieXZ1VFY3c1V6b1NRZi92SGl6V2lT?=
 =?utf-8?B?UTVvb1BoaUdQRUtGc2FWVmVKbkNRYWM2T29qWXRjYTdDdTRqeWM4Tno5RzRs?=
 =?utf-8?B?QU1CclVaUVZ4OWdtb2ErUVdaTVZ1MU92TXpZSE9VN283QWdXcVh6RkhwakhO?=
 =?utf-8?B?WTQ3OUNpMXdFbktOSUE4VlhNaGV6T21IVVRnWVhNaGxTREJ5UldhL1AxbEdx?=
 =?utf-8?B?UktpeXBkbE5rNGdoL053Y05KOFZMYnBPSGswdjcwL0hXWHVPc2hHL1FUYUZQ?=
 =?utf-8?B?Nk0ybXBVWWNCQ3VtN1NMQWxiZU9FV0tjejlLRk9GQW9SeFBtTnZyWkNUWk9a?=
 =?utf-8?B?Tmk2YURyZTBXczMzSGtSZ0QyaWFFazE1bXFORFErTUxycHR6SDVDeHlNcXUz?=
 =?utf-8?B?VTNSaGN2aWovTGo3RllnY0dPVWdUSjN0TjVLNThrSmdiUXA4Y2J5YkpsV21a?=
 =?utf-8?B?ak1LcEZJV1V1OE1ubkIzQWJ2TUQ2MDBXZ29UZlFzb3VYZXNTYW1jajVlQmxj?=
 =?utf-8?B?QUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: uwEk6WqjSgXzhSq2Kc8Hll4WYvq/ZMDqJIyIld8NoFu+V++AMEW+MRyxyEBM2zErSnVMEGBK/eccUr2O6j3RcQRvQZOUyq2XPlfC6OtnJJi032eZm2HhEnDRyTHf26u9kfXJez5vYCLVf8mePeaqB0jhMpYvnV02A+NzC6+VMkZCXHn6rwuDgdhZxSmxYXAEYDIpeG5TXwofMdRnEUfqgqQcIwyeLoV2J3SQtV8lj8jmrtbCmlpGhnjGU1fBOFp8/F/n9TUCa3kpUZFDqidvDw/340mbmOTICt9edUBkI5f2qoczB1DzFrsDE0SUGrvRA6fYjHkFbrqlJcLpaKMBTtF7GetYL+jMXkPyszzO0pmNmSXeGxjQAP2+w61hwbruI5k1LwyCZg5wfVjJH/p/WueuxyOcmBjfOOfuQyDTTEu2qZT18PgGB8Xi2Jyfl4MMvQb9An717hkZBCN4rpL7zpvhmmDXHS7/5402fsluG0oxmLxUQSR3N8HgMAcOH1LynuW25FpU8JnPt9mLYtUYU3YdEpJkfzaC1TtrBZOm1a9I8/COyEjcbVIj+cAiDTv2Xamt92DnpVcDAGc+Nf4vQlGxuMjlvuFMBpQyIoEQjB8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9fe21ac-fde6-4a53-b8df-08dcfcf77ba0
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 17:38:24.4362 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +6HGDVJOY+r/wo49LBzLQT6ygP6IemogEeXUaspRayDmSZw15NeTDPa7CV5iMvlbQZH1wctTvEyz0gqDMuSdSTFe57+W+74U/hRmdt4eZ+g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB5963
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-04_16,2024-11-04_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 spamscore=0 mlxlogscore=999 mlxscore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411040146
X-Proofpoint-ORIG-GUID: xgQTAE3NH77jR_gTT3Lv4X-rexmC6ZpA
X-Proofpoint-GUID: xgQTAE3NH77jR_gTT3Lv4X-rexmC6ZpA
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

On 11/4/2024 5:39 AM, David Hildenbrand wrote:
> On 01.11.24 14:47, Steve Sistare wrote:
>> Allocate anonymous memory using mmap MAP_ANON or memfd_create depending
>> on the value of the anon-alloc machine property.  This option applies to
>> memory allocated as a side effect of creating various devices. It does
>> not apply to memory-backend-objects, whether explicitly specified on
>> the command line, or implicitly created by the -m command line option.
>>
>> The memfd option is intended to support new migration modes, in which the
>> memory region can be transferred in place to a new QEMU process, by sending
>> the memfd file descriptor to the process.  Memory contents are preserved,
>> and if the mode also transfers device descriptors, then pages that are
>> locked in memory for DMA remain locked.  This behavior is a pre-requisite
>> for supporting vfio, vdpa, and iommufd devices with the new modes.
> 
> A more portable, non-Linux specific variant of this will be using shm,
> similar to backends/hostmem-shm.c.
> 
> Likely we should be using that instead of memfd, or try hiding the
> details. See below.

For this series I would prefer to use memfd and hide the details.  It's a
concise (and well tested) solution albeit linux only.  The code you supply
for posix shm would be a good follow on patch to support other unices.

We could drop
   -machine anon-alloc=mmap|memfd
and define
   -machine anon-shared

as you suggest at the end.

> [...]
> 
>> @@ -69,6 +70,8 @@
>>   #include "qemu/pmem.h"
>> +#include "qapi/qapi-types-migration.h"
>> +#include "migration/options.h"
>>   #include "migration/vmstate.h"
>>   #include "qemu/range.h"
>> @@ -1849,6 +1852,35 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
>>                   qemu_mutex_unlock_ramlist();
>>                   return;
>>               }
>> +
>> +        } else if (current_machine->anon_alloc == ANON_ALLOC_OPTION_MEMFD &&
>> +                   !object_dynamic_cast(new_block->mr->parent_obj.parent,
>> +                                        TYPE_MEMORY_BACKEND)) {
> 
> This looks a bit and hackish, 

OK. I can revert parts of the previous version which passed in RAM_SHARED from
various call sites to request anonymous shared memory:
   https://lore.kernel.org/qemu-devel/1714406135-451286-18-git-send-email-steven.sistare@oracle.com
See the various sites that do
     uint32_t flags = current_machine->memfd_alloc ? RAM_SHARED : 0;
Does that look OK to you?

> and I don't think ram_block_add() is the right
> place where this should be. It should likely happen in the caller.

I agree, but I received no feedback when I proposed to refactor allocation
vs ram_block_add, so I dropped them to simplify the live update review.
These refactor but do not change functionality.  Are you OK with something
like this?  Is this overkill?

https://lore.kernel.org/qemu-devel/1714406135-451286-1-git-send-email-steven.sistare@oracle.com/
   physmem: ram_block_create
   physmem: hoist guest_memfd creation
   physmem: hoist host memory allocation

> We already do have two ways of allocating "shared anonymous memory":
> 
> (1) memory-backend-ram,share=on
> (2) memory-backend-shm
> 
> (2) gives us an fd as it uses shm_open(), (1) doesn't give us an fd as it
> uses MAP_ANON|MAP_SHARED. (1) is really only a corner case use case [1].
> 
> [there is also Linux specific memfd, which gives us more flexibility with
> hugetlb etc, but for the purpose here shm should likely be sufficient?]
> 
> So why not make (1) behave like (2) and move that handling into
> qemu_ram_alloc_internal(), from where we can easily enable it using a
> new RMA_SHARED flag? So as a first step, something like:

I prefer that, and an earlier version did so, but only if anon-alloc==memfd.

To be clear, do you propose that memory-backend-ram,shared=on unconditionally
mmap fd-based shared memory, independently of the setting of anon-alloc?
And drop the MAP_ANON|MAP_SHARED possibility?

Or, do you propose that for memory-backend-ram,shared=on:
   if anon-shared
     mmap fd
   else
      MAP_ANON|MAP_SHARED

The former is simpler from a user documentation point of view, but either
works for me.  I could stop listing memory-backend-ram  as an exception in
the docs, which currently state:
   #     Memory-backend objects must have the share=on attribute, but
   #     memory-backend-epc and memory-backend-ram are not supported.

[...]
>
> Then, you only need a machine option to say "anon-shared", to make all
> anonymous memory sharable between processes. All it would do is setting
> the RAM_SHARED flag in qemu_ram_alloc_internal() when reasonable
> (!(ram_flags & RAM_PREALLOC)).
> 
> To handle "memory-backend-ram,share=off", can we find a way to bail out if
> memory-backend-ram,share=off was used while the machine option "anon-shared"
> would be active? 

In later patches I install migration blockers for various conditions, including
when a ram block does not support CPR.

> Or just document that the "anon-shared" will win?

IMO a blocker is sufficient.

I think you are also suggesting that an unadorned "memory-backend-ram"
specification (with implicit shared=off), plus anon-shared, should cause
shared anon to be allocated:
   "you only need a machine option to say "anon-shared", to make all anonymous
    memory sharable"

I did that previously, and Peter objected, saying the explicit anon-shared
should not override the implicit shared=off.

But perhaps I misinterpret someone.

- Steve

> Alternatives might be a RAM_PFORCE_PRIVATE flag, set by the memory backend.
> 
> 
> With above change, we could drop the "bool share" flag from,
> qemu_anon_ram_alloc(), as it would be unused.
> 
> [1] https://patchwork.kernel.org/project/qemu-devel/patch/20180201205511.19198-2-marcel@redhat.com/





