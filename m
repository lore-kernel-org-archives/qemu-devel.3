Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AC77CEE33B
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 18:44:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sybfJ-0000hb-AO; Wed, 09 Oct 2024 14:44:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sybfG-0000hK-L3
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 14:44:02 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sybfD-0002bv-PD
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 14:44:01 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 499IIQ0G029917;
 Wed, 9 Oct 2024 18:43:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=re+D8lKr1GItswaWUp+4EestnUkWKHF3W74FQDSwMYo=; b=
 ZYg/CwUq6w99n/AmpbXpW5gWctrWQHQs7zC+5/olDFjHusbYwpMop+JL8DW9p8RG
 N64N7gBMoM5MeJ63nT+DqmeWJ4V7rQFP9RS1C1yaYCrkynKyVDfpi7NOjnVOFXTH
 yq1nIow5N8tm7dv2Z6vWXnMocqh9Il8CKAthrmCkFKJTuNDfNCn8mDXtoFalvqxk
 T8Et4EJ0y/x4F/C09lNnt3/3oN3XkJxH2APB1aZau6SKhgLgM6JjmwSQLeqQILUq
 SLRvJVEna7KHJZxP+gAQ9hqcaNjAtpSuOIzB2BD4R/P7UZZEG/EHa8SuVh0Mgcw/
 3nFPasieM4pY/m5mort0vw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42300e16e1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 09 Oct 2024 18:43:55 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 499IOHg5011868; Wed, 9 Oct 2024 18:43:54 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 422uwfbf3w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 09 Oct 2024 18:43:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M+BnLqLe46N1ggjW8dCXIRiHrirCSXUYf8gbKpMtuNjnpYabY6rW3MQFMDWAqY3RQ6M9Sb4hiBjpC6tTEJQYelFk2aHPsstXxOhlVkaR+78Fm16a/7ryqJto9iha+bWzYuw84ZNacjEsDhOzt9Km1ewISNI7QLmy7dR8pBJHNhW7RCq2aJIt08hNHp8dQQqvsbIzSQWG8xIUlcGVKdiE3YBAKAO7hcLhVsWQ25np4lg0vmAVeJ8XJ1BeQuTyXDwai6GIj96q9UnsrBXZIadhYrrwPbs8op5WeM+dx093b+VHhEMp1FKj0cuvNA2HEbpLdAI01JCXhj8aJRweAymTYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=re+D8lKr1GItswaWUp+4EestnUkWKHF3W74FQDSwMYo=;
 b=c/bNcNSvsE3PpqvAJEHSwaC9PPn+Lr3wYuAXjj5qXs6KHQUwjJHvAy4/0o+dawG0wfbr/F3dP+JDYCDoHZgStQokfkC5YbZXJUhyUjXK9/HqM0Pw0WNzVXEmvYYxBvX57SHCrAWvU52uAwuV4Tfe+rgRYvTxOezNjBSaQBq34UAYjwOz10BzFobGgjqxcFL+rSmVk0iBKQkgdUbo2os9KYJlDMB88B7nPmywkm/iCSxFVj3O6+CwZ1cT0yVYwzUCVIeYd3SFY8hn3mM7/Unvuu+cJCDYsugisvPglo5RvFkCLtbxQJMJTUYadDCgNin3drCl1gwQec7u+rTLJAhe6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=re+D8lKr1GItswaWUp+4EestnUkWKHF3W74FQDSwMYo=;
 b=H6m31O7b4AASns37up0r1xXuZ6Exq3xpCBKXIjuJTExhIqjKwxy7z7hvprACnc9hjsnJQwMYbRoQaX9C6fsrNvuZiTUrbyL1+s7YvXAPfDfBk5VFkv/juN/tqcyz02dI1nFvyBqie4PsP0BQJBzUsTgcVaKceT2EuoU06+eAwSI=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by CY5PR10MB6096.namprd10.prod.outlook.com (2603:10b6:930:37::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Wed, 9 Oct
 2024 18:43:48 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%4]) with mapi id 15.20.8048.013; Wed, 9 Oct 2024
 18:43:48 +0000
Message-ID: <8b92a6ee-19f7-4483-9766-6b849cc04017@oracle.com>
Date: Wed, 9 Oct 2024 14:43:44 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 13/13] migration: cpr-transfer mode
To: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <1727725244-105198-1-git-send-email-steven.sistare@oracle.com>
 <1727725244-105198-14-git-send-email-steven.sistare@oracle.com>
 <ZwQ6GbVCmitlills@x1n> <eb41bce1-a776-4bb2-adb8-23fdc7cff1fb@oracle.com>
 <87ed4qtpo1.fsf@suse.de> <ZwV-NRICDNTajTRq@x1n> <877caitno5.fsf@suse.de>
 <ZwWMj4FYYpOSnPbe@x1n>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZwWMj4FYYpOSnPbe@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR19CA0063.namprd19.prod.outlook.com
 (2603:10b6:208:19b::40) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|CY5PR10MB6096:EE_
X-MS-Office365-Filtering-Correlation-Id: da49eea9-8165-473d-4753-08dce8924fad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WkZhckxBWGtadnYwWVc3Y0toSnRVMElOMVJYWDNlWUNoajlVWjhvSWhGQ0dW?=
 =?utf-8?B?blY0eTk2NjJsajZCa1Z4azc4OGFGNUI0WDNJM3hoSFdEdFhNUXhTb2hLSXBm?=
 =?utf-8?B?WC9uaWpLU2VwVndSVWFVOTY5ZlBDQnhyS214ZHRuUWY3WTZpbnBxWkVJN1o1?=
 =?utf-8?B?WjI0T2VQWnRTSmZ0eFJZK3RHbFNhalhMQXRsMFpFaVZqUjNzMCs3b1dHME5Y?=
 =?utf-8?B?dXBlcHkyekZXYmZlT3FORTQweVFOV1JBMlNmRWpnbXZLZXJ2U2hJOG1nYWtl?=
 =?utf-8?B?am50anE5N215YTNOR0g4K2svY0d2RzV0alVLUkh6WGJrNk9Dd2twZC9hZGFa?=
 =?utf-8?B?clBxcjUxSDUrZ2VxQmhtSzdLNFlGZ2lDd2pzN3VpVEJIZ1BrVlR5VVRlZ3JI?=
 =?utf-8?B?WXlLc1F4RkhGcjFkK09WSzQyOEhvaE92SGJkVllOcmFYaDhheWx4b3dJSExO?=
 =?utf-8?B?VUlib1lzWkphSU8rRTVIZlRZdHdCRXZ5MncxVlhKTlU3dHVZaExMNU4zZzJC?=
 =?utf-8?B?ZEd2dXhMOUUrdXY2SGsvZ2xMM1o5US9CMGJOYWEvZ21Xd2U3a2JLTGlHWEov?=
 =?utf-8?B?V0ZFN2dZSlZ1YnFjUEEzNUk3Zkd6WS95Q2xLLzdsQTJTVUlwQmFtcm1aNDc5?=
 =?utf-8?B?RXlaZmlyYTZWRnFMaGdoS1pQZ2kxL3BhOEdpZkVhQmdOWnMrNWltTk5lK3NR?=
 =?utf-8?B?RWZJZ3kxQmlIT3ZNY0RNUzM5RmcvcDRmK2VvVGUrM1F5WTJ5VElYSC9ER0tZ?=
 =?utf-8?B?bElWOEZxWmF4U2ZLU3Qrd0lUd05BUzhWcjlFSEt6eVRuTTl4eTQwYU5rTEJG?=
 =?utf-8?B?Y1QxcHlZWmthWEVIdHVkYkpYZ0p1NnhDWlVpbkc0djRZZ2YrMmllLzJlbjZ3?=
 =?utf-8?B?dnZmOC9SenErWTBTRm1aK09BczZ4QWNKZGFVWlNwSEtzUW9NSjRUb1dLZ1ls?=
 =?utf-8?B?dUpaMFhpeTE0djdnMU9DTU9vQmNqRjZDMXZtZDZXQXpBNkFGWGUyV3p5bWlN?=
 =?utf-8?B?NllndlBJb3Nrc2Z3dzM4cU5VRDNWMFN5alJwSUY5aHcxQmtqZXFwaVVYSDFG?=
 =?utf-8?B?dzF2QVJpN0FIN040U3cwcHRxN0lFY1NWcGxUdFB0blNETnh4MUFORTFMTVAv?=
 =?utf-8?B?ZVo1dzlqdWxwOTdvWEcvUDB0OHZnZ0J1VHVkcmhMV2s2Z0VXZ3BtV0VJQVQv?=
 =?utf-8?B?SVprS1RkTXphYUhjSGdUaCttZldzYm9jZkppZmh5cGlrd1A1cndDaXZqcXg0?=
 =?utf-8?B?T3hjMkc4dTY2RDBhc2RXckxJQ2oxTmxMNUI2LytKa08wajdIK1ZuU05IUHBO?=
 =?utf-8?B?cGpFZlM1b0dXekZqd2JxejVITDZjNno5cis4TzJzV2lqUGk2a2FabXU2UnRL?=
 =?utf-8?B?K2w0aTNGSjdzeGdBa0hkQVVJM1oyNGFNQlNLbGI5ZmF5UEdnbmRTbDlSMXUv?=
 =?utf-8?B?MGcxNzNISHdMcmMzdVpDWmM0V0x3VHYwcVhTajFxNHh2TDlvbUYyNkdHb05x?=
 =?utf-8?B?Yy9YbFJ4NjJjWEpoTkp5Ym9LYmZKSGdmb3lvUGx4RVcvNXgzazY1dUpHUENT?=
 =?utf-8?B?UC9WWGJTWFJiSENWZnhyNjQvUERzL1BONlpUVVgweDk0dGpiVVVja3pTaUlU?=
 =?utf-8?B?VG9kNFdpMUd4VVlDTWs1bnhqZktyY083MDA0WVltTVlXblJDQkVsTTVVYWw0?=
 =?utf-8?B?UDhtRXVQN2RXKzllcGxCYUdtK0MyU3NkaVFVNjV1Q3FESTMzVDdnTTlBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TmpoNFJaWUxBU2RYTFlhYU1vanYyZjVTSkRzK1FyL3JudXV4NjlvU2tiNW51?=
 =?utf-8?B?TXlabmFQY3prMVh6TmFoRGtxUld4UXhIQjM3ODFnMmg4amtLTDJSVWF1eldq?=
 =?utf-8?B?WmJwSTRvd0MzaVZMUk40ZngvdjYzUEk5Mmc0SzFYKzd0a2dZSGxGNit6cFRC?=
 =?utf-8?B?Si94MkVUL1hWVFIvQzYwZVY5VjBiT0hpT21ReVlPNFVPV2FUbW13WVR6WHgw?=
 =?utf-8?B?bGhCNlpsZU5LSzVreDRqNmlCVUtSKzhRTjkzcE5ObUgwbmdHK1ZjZ2I0MTRG?=
 =?utf-8?B?aWE2S01ZZ0dWZU1Pcm1GQnlGMEoyclJWMUFOYXhJQmxhV2tKbHRpSStybTZt?=
 =?utf-8?B?MlZ0dXdpZEJZc2ZBYTdHb1VwZURlS1psK0dsOGRiWHlTS3Y2QWVmQkh2S2tX?=
 =?utf-8?B?Y3ljdU9FMlV2UzlWNksrWnl4YkwzRHhoanVuQ0JUY1dLV1pvWmt3U1lkdDQw?=
 =?utf-8?B?WnVkQTF1WlpaTU1pQUMvSndBRHRsRGNjRjFVc2RHTkxhTXJtQUJYTml6TTNx?=
 =?utf-8?B?QWIxMFJMMVRSZUVkYnh2WCtjUGp0QmZKcXhGMklzM0YxVmp4TUZqSVNIUmMz?=
 =?utf-8?B?VDNpWG5pWjBPNTlqM1I0TFFoWWNZdTFJSjA1T2kxbWV6SFUyblMrWXdzSFQv?=
 =?utf-8?B?MXFXK01tVC9VY2dGaHZWUFhyOVBsY04yWnZTOFFzaUUzdE4yWnE4SDZLUHNt?=
 =?utf-8?B?VGhsZ09kQTdKMU9kNU9WQzNYRW5EYmVXSmgrNzd3aXlYMXpodFVJalFyRnZO?=
 =?utf-8?B?c3gzL1ZYYk9acWFwRmRHVUhGckVZQkhvd2lTSGdIM1ZRV0IwQTFWNWFqRngy?=
 =?utf-8?B?NTZNL3pzWTJOeEhCT3JrRmdCd1BlTDM5a05FNjBTWmhUN3EzcUw5MC9CMC9P?=
 =?utf-8?B?UGtuTEtaMWhxR2laZVlnaDZyZUNIc3oyMVBDMHh6eXVsZDVZdUlLaWJ0bGdj?=
 =?utf-8?B?VCtCNlU5TnphNWN6S3N0NHp0Z3dVSWQzaEhveGdMWUF0VjJ4bkhpRnpjd2FK?=
 =?utf-8?B?L0hKSEtraDBWTnlKT0VzNE5tU0taTWpuUExOT2t2NjBBVEM3Q1kxdU5BREZO?=
 =?utf-8?B?dkM0M1RZZDRFd25UWG1nMC8zMGt1TW9CZ05WMFpJMXZvWGxHajB2S3E1dVBo?=
 =?utf-8?B?N2N3UWdOVUFGU2ZodmFNenpYN2o3ajJBQUhxUTA1eFAyQXJ0K3pYL2huYkJD?=
 =?utf-8?B?SklCWkdxY3d3MDdCNW1aa3oyWHVxOTF5bWJtV09SeEpzNHNQVlNmUy9OMU1W?=
 =?utf-8?B?VGRJSXBhTWJrOERmZTkyUTFmNTJmMzZlM1VWNFZzWnRHS3AyZlJjUWdLNlpE?=
 =?utf-8?B?SlVZSGJVWFdpb2J3c0QwNUloWTZhQkNBWWdObUVsUGtmY25BUzNOZzBxcWwy?=
 =?utf-8?B?QVZOS2dPeWNIYmIvUk04eDB1RU4xM3ZaWldTV0hKS0lvQ1dXWVJFdXUrOCsr?=
 =?utf-8?B?MGlMWnI4OXdjNWw3SURwQmpzY2JVZ1BaYlRhUHJndE1sQnJBTlNNRUV3RktK?=
 =?utf-8?B?aGYxV2hxNllZNit1TWtGRnRoalZSTUR0Y1dUaFY0WEFLdUkvSFhsQUNtMHpI?=
 =?utf-8?B?UmRFS0xoRW1QaXZ2TFR1U1ZkSmF4MjJiY1ZIWEdwWXBEekVFYmpuVDFkckZq?=
 =?utf-8?B?czRhNUJJeFRKWTdiZ2g3ZDAxZlN5UVBsZ0lYQTk5d1llWERVbFBhY3d0N1Z6?=
 =?utf-8?B?OUVMb1VjL0dXSzVPUW9zT1ZPTXdOTHJGVmFJcEhjRjlCcEpBWktzd2RvMEs4?=
 =?utf-8?B?eWdUTHdCS3dEcXVzN2RQa1NScHJhUDkxcWgxY0xua0h2bStPQjRnY3g4SnJt?=
 =?utf-8?B?VVh3SEs1MkNkVkFmeWl2Y3BDWlllTVB4U3B5dE9tbzB4UnUwRXhuTVhHbHVL?=
 =?utf-8?B?RTUxSldiaHpQcmFSWnJqU2ljQVBtajVDRjNGOHJqYnhRZWxWUDlnV1BRd1Yy?=
 =?utf-8?B?dGhOU21SZjl2MUZRMUtRWWM2Rm5JOEVNN1ppc3d1aVdYNHB2bWpSUGx6REhB?=
 =?utf-8?B?clkvMDRURHA4bDRIT2pDdFd1am5sSEMrYzl6eG5VRXRVVFBMSnUybWJkMXlL?=
 =?utf-8?B?dHlKTVZSOTJSSTM0WnZ2MGxXL3oxeEwyUnpjdHRLZ0NlRjQ1TmQ2TUluY0FI?=
 =?utf-8?B?RzJtSVhuNk1QVFVqazJIaCt5Ylh5QmZCWmpFN0lsc2p1NENicHp5VVZtcnJp?=
 =?utf-8?B?ZFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: kLnybQD5xGnuZxdXKbdGGa4bL85sxrqNlV+kBA3JaugIzVG9VdeQEJ5uegA0xOQmArTFJLAQynRAz+0snNehKKE2R7V0muy8aHobaZXC3qz9DH4EzpuKAS+5Hzlxq567Y7vyOc4GEhLVHUNBoPo6L9z507+cDvvDp1EwltbMpl6CjM4ZPQq+gXia3AXPJ2HQFUm46UHJUAh0S02bsHpkkU75wVuME+E43WMZQZueAjmKtunTqhLM6TQnIcrxT4bAbKK6nP/FV+jEUwmSCzAqmpJmQgA8tursDe1tvVPS06LbfGGd/J0mJeI4A+vs7g7/5Znl898Ady+Px1ryN3hN6G6WoJrtjQCOCOn9J1wOMpnbsuheX8wpe3qwCSXnDTMazLenaRwtauDwZSUqS209Nz2t0+V5JMMdKcnTNtGgEWhGURht7kQIs6h7ylh+Ar0SKKwrmIpZoIb0eloA7hFzDLoCVwD4S7yUNbWMVmfk7Ij7mKVl4dU/VuznPYnx/Mgj9e1ztKhWqKbSMVlXsZoOLv/iNDMc3PzseG1G8iaJOX3gv4HVYmFJKcKGDM/x/LFYY6uqIlEJjLs09P3L7w4AA6B7Fzfkpp4A/3ITdLak97w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da49eea9-8165-473d-4753-08dce8924fad
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 18:43:48.0681 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k+Kmzkkh1GDSTjXW0PDfN30ZyYpubkhvZEmcsg4Fr0GOVxXJQ8E3NLU3yV5YXIYijL1n9A7hwFtFG8+Gxm8ntqtxqzI/SkV2yUSWEtzzPoM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6096
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-09_17,2024-10-09_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxlogscore=999
 spamscore=0 adultscore=0 phishscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410090117
X-Proofpoint-GUID: bCsNC-y-X8G0NJ5UR32dGoirj_op3aLD
X-Proofpoint-ORIG-GUID: bCsNC-y-X8G0NJ5UR32dGoirj_op3aLD
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

On 10/8/2024 3:48 PM, Peter Xu wrote:
> On Tue, Oct 08, 2024 at 04:11:38PM -0300, Fabiano Rosas wrote:
>> As of half an hour ago =) We could put a feature branch up and work
>> together, if you have more concrete thoughts on how this would look like
>> let me know.
> 
> [I'll hijack this thread with one more email, as this is not cpr-relevant]
> 
> I think I listed all the things I can think of in the wiki, so please go
> ahead.
> 
> One trivial suggestion is we can start from the very simple, which is the
> handshake itself, with a self-bootstrap protocol, probably feature-bit
> based or whatever you prefer.  Then we set bit 0 saying "this QEMU knows
> how to handshake".
> 
> Comparing to the rest requirement, IMHO we can make the channel
> establishment the 1st feature, then it's already good for merging, having
> feature bit 1 saying "this qemu understands named channel establishment".
> 
> Then we add new feature bits on top of the handshake feature, by adding
> more feature bits.  Both QEMUs should first handshake on the feature bits
> they support and enable only the subset that all support.
> 
> Or instead of bit, feature strings, etc. would all work which you
> prefer. Just to say we don't need to impl all the ideas there, as some of
> them might take more time (e.g. device tree check), and that list is
> probably not complete anyway.

While writing a qtest for cpr-transfer, I discovered a problem that could be
solved with an early migration handshake, prior to cpr_save_state / cpr_load_state.

There is currently no way to set migration caps on dest qemu before starting
cpr-transfer, because dest qemu blocks in cpr_state_load before creating any
devices or monitors. It is unblocked after the user sends the migrate command
to source qemu, but then the migration starts and it is too late to set migration
capabilities or parameters on the dest.

Are you OK with that restriction (for now, until a handshake is implemented)?
If not, I have a problem.

I can hack the qtest to make it work with the restriction.

- Steve


