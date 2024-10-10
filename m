Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C3A9D2444B
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 20:06:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syzQe-00049L-0W; Thu, 10 Oct 2024 16:06:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1syzQa-00048l-If
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 16:06:29 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1syzQY-00032U-GL
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 16:06:28 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49AJtaLA018029;
 Thu, 10 Oct 2024 20:06:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=ZMlx/7qgpPy5qjkh/6jH7dE3r94vK1u74iHrr96nc4c=; b=
 oQbl3e7lgDe89/EubJILRCJd82r1+DzpfKgC9l14zK7GiQXX6bRW2htcM2Cw6DHU
 ZDv9GTeWBwTMb0dPSjhJ6GAwcRsKfNI2GGPd7CS3mESpUhy59mqVjtlrJoOffBLW
 5YOGXh2uVZ7EazG7a958hrbyfaTMtYUfVQWIPlY7I6J/eB5SNGN3PKyAavNpeoMJ
 EbS+nnsqQhMJDVmUrCD8ucIFtiog9mcihvMs5okEMiItxDCJrvgQjec2pUKv/XO8
 EMTbX1Vg6ceETsHA41L2a2Fkha4wOKBTXTaQOl+Al/SbczgtvBCg3QIu8/EPT7vB
 8wdmHFThJE/N2FQ8/dgRbg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 422yyvbp8e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 10 Oct 2024 20:06:23 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 49AIi89Z034397; Thu, 10 Oct 2024 20:06:22 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 422uwahpyw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 10 Oct 2024 20:06:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p6+H1CHbuunN4PyDlNPVis4r5MuOJ+JxaNyZlaSPeWvvaG50iebUyfzBGYw/TYOA6snxiAzRfREj4vXvXPbCMfG2noaO7srcg3PEyHtGIU90Ld5J7w2xokENIQF8qYDoiPPNBhyuZAi73Du1X0LtPktvyuPqPJdup4h6vOxQfjzVzdHCg9Z6kTgCXWnMXjsqIPXnv2AZflKOgvtJcO96AOAYDieoThghwBkpKCikF9tgKIXCB8ZiUt6zvf9721d+F4r3TqcoflcJDlFLdKUJHZ8dHs0TEU78tM3z2GPbdI0Gt1TJSdkPa9LbBhlNtVDJhrYOoAXebDergNVN1B5xxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZMlx/7qgpPy5qjkh/6jH7dE3r94vK1u74iHrr96nc4c=;
 b=JjxbCDy1CviAl8cV9HFMtsE5ZLP05zzVXngh6Yb9lUnSrNSt+1DqftdQw2oCTybn8Lekncl09uH/vmHwKip+PICjWjfnQe3Xl2t4lvAz2yFkpigQ7KniyoPDwuP9pEcCGGrwCkkOXhUzl8J+C40thBnBfjLA7UpOvidiKPXb3uSVwx3sdA14mVuLTtXhN8RMf5ovw3OKUyb5FipSkP6DT6AegmRTpJ+LFs88uyiJO/CT6QflEYd4shAgUdex4pNMNErMyh96IKVnrvMp4iqg+EeoiU+lFEHC8CNJnlSRG/nC/21jzLkXRIJnrfOrkr2LNW9WO2JOqsVEoz0czveIcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZMlx/7qgpPy5qjkh/6jH7dE3r94vK1u74iHrr96nc4c=;
 b=gZYjBcLevn+v/rluHUfabSvsSyNvcqwkazWRibYzYzzJqMttSfgMo0/oMoXDuoNXA94Hly8xbFLAqHX3h6zZe4+hiAEceSnqrJRXsGCsWpIL0DQUChk5rgb9wRfz4V6wjEfHsTXYe3FirMkbbeXLEeoi/lK73F06LzXZxF05+OQ=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by SA1PR10MB7814.namprd10.prod.outlook.com (2603:10b6:806:3a7::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Thu, 10 Oct
 2024 20:06:19 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%4]) with mapi id 15.20.8048.013; Thu, 10 Oct 2024
 20:06:19 +0000
Message-ID: <198913f5-32de-4771-98dc-02e73c4f0754@oracle.com>
Date: Thu, 10 Oct 2024 16:06:13 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 13/13] migration: cpr-transfer mode
To: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <1727725244-105198-14-git-send-email-steven.sistare@oracle.com>
 <ZwQ6GbVCmitlills@x1n> <eb41bce1-a776-4bb2-adb8-23fdc7cff1fb@oracle.com>
 <87ed4qtpo1.fsf@suse.de> <ZwV-NRICDNTajTRq@x1n> <877caitno5.fsf@suse.de>
 <ZwWMj4FYYpOSnPbe@x1n> <8b92a6ee-19f7-4483-9766-6b849cc04017@oracle.com>
 <ZwbUTXCxxl4heZYV@x1n> <95bfa06f-de5a-42cc-8078-c49fd617a73b@oracle.com>
 <ZwbpQiK7YWKpqHTk@x1n>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZwbpQiK7YWKpqHTk@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0061.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::6) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|SA1PR10MB7814:EE_
X-MS-Office365-Filtering-Correlation-Id: 1eb7cce0-b3f4-4a0c-cb04-08dce9670155
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q25ZNjU5TWhoY3R3VjRhSVE5NDJzY3d0Y0dIQzh5elU4QjlJWndweTRyTnVV?=
 =?utf-8?B?OFNPMVJaMk5PaU4yTnZXZkp2bXRwaktzZDQ2bm4rT3RwNGFkRFQ1dTFIU3V2?=
 =?utf-8?B?UmVvSE5QVTQyNVorU2RXOE9DaS9WYWxVQUlaaWRRL1RoTE1VMGhRMGtGWGls?=
 =?utf-8?B?c2drMTMzTEhwcXIrS05hUGFLWlJTMnhpVVFCRHhDR3E0UEM3OVhXRVczN0sy?=
 =?utf-8?B?UjlLN1plSVZISWdZdWtPQS96RjhNMVgxVWZYYURyWHNvQkQ1ODNFakI4VFZY?=
 =?utf-8?B?WWh2SCtXSm41RFp0TDQzakhMbzRJWmpSd05pUjRnaitZUytIM1lacHdJcE9Z?=
 =?utf-8?B?eHpBTlo3VkVhZ1dBdjR6YTV1cjYwV0dEWng1MmtyalpzcmRGZDFPRTF1SHRk?=
 =?utf-8?B?c05sMHg0UW9ub09ERkNrUXZDNjdOTjRCR0NDSkZZNFVpeE1KNXZpb0ZSWXZz?=
 =?utf-8?B?cWFOa1BJbkJLSTBzWkhjZ0g4OHpOSngzT1MxRWp6dXlFZkFYMG5uMmpreDIv?=
 =?utf-8?B?enlaMEtMOTFaY3FTeTI0MVJ1aE40QktXODJOdnpKT2ZtQzMrNUM2eDE2NzNH?=
 =?utf-8?B?WW9URjJFTGZhUDBnbTJXVEdZUzJRT1czTTkxMFkwVk5ScGVtaG5yNVM3Q2RI?=
 =?utf-8?B?VEZKN2U3elV5Y1pUMzRrYXcrOVoxS0RjOExiNmkyWE83ZzlocTN1dUd3MnRt?=
 =?utf-8?B?MzhxUG1QbFRyUExGN1MyYm1xZzd4VCtHMkU5QnhMbWVpYW9BNk9JdFZwMHg1?=
 =?utf-8?B?RU5hMEYzMUtDSGZQLzYySWJJYWI0LzBKVmMvV3U5OTlWS2U5SWNneFc2WUlZ?=
 =?utf-8?B?cUp0MGlVd1d4cDFZeVl0YW1Jb2dHSytPYXV2WjlNc0wzMXZaeUtKaFF5ZnVU?=
 =?utf-8?B?QnVYWmNsNmZLREsvR0FBN3dvZFRPalFjSFdLWXlDZ0JLY3pTdzRGa0FqOVNU?=
 =?utf-8?B?ZDcvc1ZJVnJ5NDU2N1ptdGhRTXFZT01iWS9TY1hJQmZyRG43c2ZybTRxUjFm?=
 =?utf-8?B?ZkxnYm5aaVpOMGplUk1DTk1RelRBL3RZbmNPNkVXRWlHUVdFd0prbVZtVWpX?=
 =?utf-8?B?U1k5eE1ZQ1crNUdZUU5oRE9Fc2w2ZGtPODZQV2MxSFRSWDE4NnJRdFBqSFFC?=
 =?utf-8?B?RkhjSVQzWHl5NHZWT3VPQWdMaEl0TVduT210VW5kY0VjSDMxQ1BmbmtoelJM?=
 =?utf-8?B?QVIwSUIxenEvamkyVmZTaGRHdWhTT3Qxc2NzakFXN0dpRzNaYk41WDFvc3RL?=
 =?utf-8?B?NWt3cVNQOGNmQkFTUU00UUVMcFl5d1pqU0lwOXcwdnAzMVRzRDF1d0FoOUs1?=
 =?utf-8?B?SnB3THVDNEdRL2RueUFlM0xPZFBaQmJUTkt5OUg5VUN5cHdobGNuN3hUNEE3?=
 =?utf-8?B?VW5XM1ZEVndkVGZKRGVDSU56QWdXaGdVQml2ZDZlQlRxZlI4K0hOTGtxZ3lo?=
 =?utf-8?B?eFBVN1FKNXNFcmp4bE1CMGRuUnN2cVBrZC9EYStWdHJyTmFxTW9CeWRLVHdZ?=
 =?utf-8?B?cmJ0d3orREJwa1kvUXY2QkhXSFpqQUs5N3VWMTkyaFBLQm5WeWNrWVNxUVFQ?=
 =?utf-8?B?MHBiMVhCWDFwMy9WdmllQTVhbDUrL2VlNi95Zm5naCtrZmIyK0x1N2EvSFRX?=
 =?utf-8?B?a01EbHoyemxVem9QS25WMHJmcEJiMmxEMHlQNXJZQURDTGR4NVYvN1l1ZXdw?=
 =?utf-8?B?ZWNVTmNNTTZJOGtxbFJmdFNYOHVZSEdJYlhQMHRxbXlnVUlrcDc3c0pBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3RXS1FDcHdJZ3JpcjZKTjd6UXpXaXhRZjZQNlIwSmsxTlBMLy9ZYlpvSEs4?=
 =?utf-8?B?QlFnTDJNakk3RHc3U0hkd28rMDRLSCtPZmpmK3l5Smo5U25OQS82TGNYSVpF?=
 =?utf-8?B?aS9BaFJTRTNVTDVJUG9qM0VkTXJ2SUZvL0JqRStaRXJDNXE4R3EyN1VVUDlu?=
 =?utf-8?B?WEFEK2tMTmhHV2JOdXNFQTFJMjVyWk1oeU8rMVhBWm9Rek9EcFBxNlZYUy9E?=
 =?utf-8?B?b2pEejlQZVljZnJ3bHdXdEVuNy9iWjFidFlTaTVrN0dOOUJjeWdKSDlEaCts?=
 =?utf-8?B?KzFvSHM1SG0yT3RKZWxLSjY1b2Q2QmI5VmI4bk9mdU1keXE3UTNmRFlHbXpW?=
 =?utf-8?B?OFRCcnRiNlJaWGhJL3JDeDU3VFdoNGxaK2VUbmNBc29rdUpzbWlKQUdHSDdY?=
 =?utf-8?B?Q1U1VFNBSEZMRUlWRmY0SklucmFmcmRJS0tpMjJKOGVxZlZHU2Q5R1ZvWGxI?=
 =?utf-8?B?ZzBGUmlVSTN0QU5MSUZJMnIzMFdMaGdPLzJKYTM5bjVFeTArREtqZWZOc2FF?=
 =?utf-8?B?aXNZMWZhU09XTlhNcFBVWHlsZDJDeHN6dDJ3eWZrWW05NGpkVm9OS0pkaE81?=
 =?utf-8?B?dGdvSkxCMWJLQzIxZGJkYi9NbGE2YVE5V3BtZlhGOTZyWFJ6Y0tTdmk4N0Rs?=
 =?utf-8?B?U0hWd21Nb2tlK1hHbGZ0Z0w5aTRqTnhNb0RienhyaEVvTURJZGlMUjBVMDlF?=
 =?utf-8?B?NjNQVEp6SzZYdVVsTlk2VURPZk1lMmtPYVpxQ0FLV3N1VE42dENYRjFZbnFx?=
 =?utf-8?B?ZlEwNTJpYWJWT0NJWjc5K040U3R5cnlGTEpxdXpRZHJoY2ZzZllBbFlOOUVE?=
 =?utf-8?B?NmpoRUVtL3ptWnJ6bzhBb0hEeVZVYWhmOEZWYTRIWmt2RkpIeTY4bDB5V1pS?=
 =?utf-8?B?Q0VXTmZBMy85RFFmWlh3YUNYbjRJNlgxaTc1N29UeWVhVCtQb2dTTUJPQ0cr?=
 =?utf-8?B?emh6cWFqdjJlNG84LzFLaEpYcldwTnVjWlZkME0xMndueDNvM1l5U2RQUHov?=
 =?utf-8?B?K2FkQ2YzUXQzVmdKdFBldCtwVnI5NWRta2RvTkxob1hPQUJXTkMvT0l4UWxH?=
 =?utf-8?B?aXZVMnVuWEFOZFY0dU5VcDRiVnFOeXpkaFE0UjdDaHloLzBXZ2dGSHdXNWU1?=
 =?utf-8?B?bnMyUXEveUkwOGdsaXlDc1lGLzVpZ3FmNUljWVJxRVArL05WcDdDaUxvL1d0?=
 =?utf-8?B?bVZSajd5SXdVWjFQK0JKZnhwNDF3ckpwWTRHdzlLclc4VXBHMTBsazlSbkp3?=
 =?utf-8?B?UVIrUVowM1pjZ2NyMzR5cTQvK3lzZTl4MCsyUURJNDkwQklidWRNR2UwbVZI?=
 =?utf-8?B?UFcrU0swdE9uNXJQQ05MZFI2R1ZKbk1FZ24ydTZzaGVEbm1RNEYxaGM0eGNx?=
 =?utf-8?B?TFA3NktNSEZmRDVDdUxIOWlmYU56SXlXWmZZMTNFNTQ2TmFVWHlXNXNjMlpS?=
 =?utf-8?B?TTFZdGRHSnNtbjArcDhzSEE0RGVycWtla1prRCtOeGo2WjNSbnJRNmpKWGE0?=
 =?utf-8?B?VmFObXQ3enZnczRGR09xRHY2TVJ2amZ0VW03MWJpN00vbUcwN0Y4T2xFejFQ?=
 =?utf-8?B?dHR5YnhrNVpqVVhNSDR4UHdVdXNvL2tVN25BRTgydGVuWC9oZ2ZUbWt2L3Fz?=
 =?utf-8?B?NmdrZDJHUkIxemlQdXZXNTlQbDhwOHdwL3NZOTU4MS9lZHV2bWY5ZmVEQ3FE?=
 =?utf-8?B?OUZuZXpTdUhRQXZodW0zWGhDUmJHakNWQTZZT2RpWVZSRFBGWlR4TWxJVTJi?=
 =?utf-8?B?a09ieTlpQXFTdTkwZmtqd25qY0gyd3RIWWhNWjBZNlFaazVRT0JhdDMrTUJ3?=
 =?utf-8?B?alc1REVRTXZ0ci9jSURCdHpocFlqUkVENXNPLzZ6Z2ZIL1BiOEl1dzErMmFU?=
 =?utf-8?B?MG9vUFVsNjRZSklpNGwrdkdEY2U4cDE5MURCS3JYNGtIZXluTkloVWgzMzRG?=
 =?utf-8?B?VjljOE96UGJKTnJJRFdGcjErd3VsdVZxeVpBNENyUTM0RjdTUGZ4bUZ2eWd0?=
 =?utf-8?B?SHBubFNHY0Q0Ny9XeHlSYzl4Z0dwZE1Uc2tSczdDZmdRbHRmNnNWRWNpT0ZP?=
 =?utf-8?B?WUtPbW1MWEwvMDB2YUpCS09xN0RCUDZEcHZGcU9NeHplRXg3anBUNUF4TlI5?=
 =?utf-8?B?YldlN0FtNTVZVENVK3Q5RWRzbURKZmFIUDM4OUVpeGkvRDhveDdtREtZdXQz?=
 =?utf-8?B?Qnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: sZs4dFDWhLWXU20a/nGE3PTJcfRKlNmFlvERjg1YPtD2+2M/bQBwRI4qRNWIjY2FEsR6BAbW/AEtT5+7etzJpff6RwMv4LSJM84G81d5585AFs23eu3JYpBSCrqF/vYd+IsIqrtghMilrlSyxv3rYPEIO4W97aWtRxaXI6UsGhSnzU+ZWS/h2Wqz2L23m/OOeGiRtK5+Ga0xXvKpYl2NjFA1yK/+UAep4UhjoAnFg0ulJw/NIhoa/eqzPPgxLkCJmrcdi9TZnYbWoKyZzTZ5FBlDZE7JUpfpWOq1Y6caFEKI+As+CTHxIMD/J8pgZnjTuR9mpCYUOVuXRhJqV2oGXax4zo1O6p8mcnVq1p/N3eXSL5IFo85MlZOq7ghyfU/zDo/MWF96JPUe9cg4gCOl4Mpa6INh86N+lHLLD/rWBnqVu/m98o3CPHs3SnP1Bdj+vBX3x7ZjccL0AyFh88Gm5Mz9DcUmEuhUrG9H7sNE3chV4G4qRvdhuU48OfDjQGcG5coqF5ZhgDUrYouYAvU522VDMnp/bJq7tqQXwe7pU9MgreKbLYK9YDDELmMAkR9GQmjDIWbjC0+Hyz3d2ribW5IwDZKjuxWc/IbmwhVeDRo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1eb7cce0-b3f4-4a0c-cb04-08dce9670155
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 20:06:19.4615 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KoyepQc0oZyiL8mjrlNWA8h2W+2dJOzqmcnFWr4Gzku4puSmGJV4bmgSEg4bn69R/WcQdc82SFxpHgU7amrcuWZddREpqa/hTO67bj3NZp0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7814
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-10_14,2024-10-10_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0
 phishscore=0 mlxscore=0 suspectscore=0 bulkscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410100131
X-Proofpoint-GUID: eKxbCpG9D1q3PAxRLZa6W0WqKQR90-B4
X-Proofpoint-ORIG-GUID: eKxbCpG9D1q3PAxRLZa6W0WqKQR90-B4
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 10/9/2024 4:36 PM, Peter Xu wrote:
> On Wed, Oct 09, 2024 at 04:09:45PM -0400, Steven Sistare wrote:
>> On 10/9/2024 3:06 PM, Peter Xu wrote:
>>> On Wed, Oct 09, 2024 at 02:43:44PM -0400, Steven Sistare wrote:
>>>> On 10/8/2024 3:48 PM, Peter Xu wrote:
>>>>> On Tue, Oct 08, 2024 at 04:11:38PM -0300, Fabiano Rosas wrote:
>>>>>> As of half an hour ago =) We could put a feature branch up and work
>>>>>> together, if you have more concrete thoughts on how this would look like
>>>>>> let me know.
>>>>>
>>>>> [I'll hijack this thread with one more email, as this is not cpr-relevant]
>>>>>
>>>>> I think I listed all the things I can think of in the wiki, so please go
>>>>> ahead.
>>>>>
>>>>> One trivial suggestion is we can start from the very simple, which is the
>>>>> handshake itself, with a self-bootstrap protocol, probably feature-bit
>>>>> based or whatever you prefer.  Then we set bit 0 saying "this QEMU knows
>>>>> how to handshake".
>>>>>
>>>>> Comparing to the rest requirement, IMHO we can make the channel
>>>>> establishment the 1st feature, then it's already good for merging, having
>>>>> feature bit 1 saying "this qemu understands named channel establishment".
>>>>>
>>>>> Then we add new feature bits on top of the handshake feature, by adding
>>>>> more feature bits.  Both QEMUs should first handshake on the feature bits
>>>>> they support and enable only the subset that all support.
>>>>>
>>>>> Or instead of bit, feature strings, etc. would all work which you
>>>>> prefer. Just to say we don't need to impl all the ideas there, as some of
>>>>> them might take more time (e.g. device tree check), and that list is
>>>>> probably not complete anyway.
>>>>
>>>> While writing a qtest for cpr-transfer, I discovered a problem that could be
>>>> solved with an early migration handshake, prior to cpr_save_state / cpr_load_state.
>>>>
>>>> There is currently no way to set migration caps on dest qemu before starting
>>>> cpr-transfer, because dest qemu blocks in cpr_state_load before creating any
>>>> devices or monitors. It is unblocked after the user sends the migrate command
>>>> to source qemu, but then the migration starts and it is too late to set migration
>>>> capabilities or parameters on the dest.
>>>>
>>>> Are you OK with that restriction (for now, until a handshake is implemented)?
>>>> If not, I have a problem.
>>>>
>>>> I can hack the qtest to make it work with the restriction.
>>>
>>> Hmm, the test case is one thing, but if it's a problem, then.. how in real
>>> life one could set migration capabilities on dest qemu for cpr-transfer?
>>
>> You will allow it via the migration handshake!
>> But right now, one can enable capabilities by adding -global migration.xxx=yyy
>> on the target command line.
> 
> Those are for debugging only, so we shouldn't suggest them to be used in
> production.. at least not the plan.
> 
> Yeah, handshake would make it work.  But it's not yet there.. :(
> 
>>
>>> Now a similar question, and also what I overlooked previously, is how
>>> cpr-transfer should support "-incoming defer".  We need that because that's
>>> what Libvirt uses.. with an upcoming migrate_incoming QMP command.
>>
>> Defer works.  Start dest qemu, issue the migrate command to source qemu.
>> Dest qemu finishes cpr_load_state and enters the main loop, listening for
>> montitor commands.
> 
> Ahh yes, the HUP works with this case too, that's OK.

Defer works, but it is backwards.  I believe the managers would typically send
monitor configuration commands to the dest first, then send the migrate command
to the source.  Backwards is weird.

My new proposal addresses this.

> What's your thoughts in the other email I wrote?  That'll make QMP
> available in general on dest, if I read it right.  But yeah I think this
> issue is not a blocker now at least, so I'm just curious whether that's
> still useful.
> 
> We may still want to understand one question I raised elsewhere on whether
> cpr state save/load must be done during vm stopped.  If so, then it means
> Libvirt will only go with "defer", and QMP set-capabilities might be
> accounted as downtime there which can be unfortunate.. Basically, it means
> if we can still drop patch 4 completely (while the vhost notifiers can
> exist in the future, but hopefully not dependent on patch 4).

vhost requires us to stop the vm early:
   qmp_migrate
     stop vm
     migration_call_notifiers MIG_EVENT_PRECOPY_CPR_SETUP
       vhost_cpr_notifier
         vhost_reset_device - must be after stop vm
                            - and before new qemu inits devices
       cpr_state_save
         unblocks new qemu which inits devices and calls vhost_set_owner

Thus config commands must be sent to the target during the guest pause interval :(

My new proposal addresses this.

- Steve


