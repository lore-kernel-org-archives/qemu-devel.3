Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AF3DD30019
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 15:33:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1oyX-0008DY-Uw; Fri, 18 Oct 2024 11:33:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1t1oyV-0008DF-Db
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 11:33:11 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1t1oyT-0008O6-7B
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 11:33:11 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49IEBhsK014120;
 Fri, 18 Oct 2024 15:33:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=/Gy8vqSN9N/QGbNsah+cW8EEJ025ybE8QIKkFdBu/Vs=; b=
 QqoBx8YAp2vkGU61IcFOYnZVK8PWlf4vR+SE70Peb+TxrUCW664bflk+BcWJE3Bz
 2mnWnDhgT0DOhcvdjfY8r9ItIaI7LKaUu7H8R6MTVRyR9kK5I8Qu273sVUOAdXXZ
 WhMm/rUaW7imwyQER6B1wDb3wwIk00gMUC4ocKBeT2uFM9MDpRwUoNP4aoVXa6pp
 nlJP6GAE+U9M4ZRunxjoaxhGWRZ0M1SXDQ3E/DRxa/UopiWGvEYY6rYgLRInP/Y3
 iC1q2igLXmPWUNYC6RkFffy17Z1OwE7YnxJWAYRZjmWU8Nc5Y5h4Zox0uLRA0nOA
 hSAsTO2baNTzfv2Caqe6Aw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427g1arvbg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 18 Oct 2024 15:33:00 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 49IFHf1s036115; Fri, 18 Oct 2024 15:32:59 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2041.outbound.protection.outlook.com [104.47.58.41])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 427fjj9ra9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 18 Oct 2024 15:32:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xoy8ixX9SCqboccAIytGYnAPOR5oldQ+pO4ATA/DxbkFKA+6b/ncrHoPsYu9r4aQsa209wEInkkrOwBCM9XlAfpsgCIcmAMjphKt9u2POfPQpqrpJy6tY2W4SOdscHu9vmUaUqa1UNRv17dRCAbj41YFntfAPzz9z1gnOElyi46F9oXZUcVfYxUrQCvdV312xLmFwJ1aiFEU8j52bet70Xh4oOUkTsB5sNxTr2jsd5t8iBybmit+hd5AzmjfvtSTpDuhC42o9svyZn0xzs+0Jb5fsrx4DvfkE2mnVcBRq1Ly2mkqHy1hTCguAIPN2InXYMBPrupKGdJmlf1NqA2o5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Gy8vqSN9N/QGbNsah+cW8EEJ025ybE8QIKkFdBu/Vs=;
 b=sG9WKdtUuTeuF1N3y7wnTDdIBMN40saM9bGz9PGaXXMUqhStzUxOENkL494p5agudANdNLvJQ+b+pA+RakSnz1JvTlX6E79OWeJoSbTPSbsxLRjyoCK1sHY0crTfrlibKziWAD8t/o1RfqFz3dDTFx7hB+kjLEvF4qK5i8PKQyZ9sGp0DAEKXcP2/FDXK4Y4+V69GMBqHBvotH/vblK+72vXrUJ/ImNC0+xJKqZEUdRmMtPE92JffcNQDVi6z1PSTQySCyf5xm3MobKxm9CxXUhN5Dzh6R7qHSKGRy4TjeDKCWaDJ0kuZwIuIsxLUnC+Eefu9j95eTIH2O3b7Af/IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Gy8vqSN9N/QGbNsah+cW8EEJ025ybE8QIKkFdBu/Vs=;
 b=DmwnODmLJawLg60goXrgDpaNAo0YmxhaajC0Sr4TSQlUWSiqJdPOkVFWWhV5uASJqqJxcyGNm6u8Iz6upEm3JdibcJTd8SFEA7KsDx9ZRa7uAmS+loOkPaEUlhll8BY5NbFjyyhBSoMbyYkFB+7e1hFNREHW46hEjnncWx2NEKk=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by CH2PR10MB4136.namprd10.prod.outlook.com (2603:10b6:610:7f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.20; Fri, 18 Oct
 2024 15:32:56 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%4]) with mapi id 15.20.8069.016; Fri, 18 Oct 2024
 15:32:56 +0000
Message-ID: <628ceba7-9cf4-4ad2-b3e5-6af4037a0bc1@oracle.com>
Date: Fri, 18 Oct 2024 11:32:54 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V1 04/14] accel: set accelerator and machine props earlier
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <1729178055-207271-1-git-send-email-steven.sistare@oracle.com>
 <1729178055-207271-5-git-send-email-steven.sistare@oracle.com>
 <87ldyl1mah.fsf@suse.de>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <87ldyl1mah.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN1PR12CA0017.namprd12.prod.outlook.com
 (2603:10b6:408:e1::22) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|CH2PR10MB4136:EE_
X-MS-Office365-Filtering-Correlation-Id: f310d8c3-0c5d-4bff-4da4-08dcef8a2336
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cFh3WmtqVXRZYmtKd3pGOFoxOXJQUXFZVThiN2NXMUdlQU5WelhGZElzL2p2?=
 =?utf-8?B?Wmxzbi8xMElZNDczSS9zUHAvaDh3R1Q0NWY3eVNQaHZXYmVrYlFZSk0zTlhh?=
 =?utf-8?B?TUlHRW5IallyV2tvSDNpVVpkQmpKUDJMN1JvZURob0Urc2ZwZFovb2hoMGpn?=
 =?utf-8?B?aUtxWGt3UDJGUG12WjhLeWh5L1BTYUZGTU9vMVVQUS9WaVdEUTlheEYzMXhi?=
 =?utf-8?B?NVk0ZG1sWUo1QzV1eGFISEJwcXVJbVBXYVFma1BNSTNsNFdjV0QwZStOZWZE?=
 =?utf-8?B?cWNna1BKVUY5N0xVZW45RW5lM2ZyeU9tZXMzWXQzb0JaTENDOGZIQ3pGQjlI?=
 =?utf-8?B?WHJueDRwNzlEUDFDQ21YbTN0enEzRHJEV2gxQ3VTcmgvcmZvQmxRM2c3TGVX?=
 =?utf-8?B?WG1mb2k1UERyaHNuQ1dEc2RncFZ4OTZRSVF5WkU3Y1J5TnRQMzBwYllSLzRs?=
 =?utf-8?B?aFF2QW1NcEFTS1R3UmxUWE1mOWI1RTNXZ20wQlArbXpIKzdJYlFHOThqWDNj?=
 =?utf-8?B?M0Z5QW9pR2JKRkdCTW52UTJwMitkbTNiVm9tZWU1WERFb2VWTGl2bzA5cS9w?=
 =?utf-8?B?aFBWakpmazAzVDFOZ1VZU0J0SXhVQkEzMzRIZXRKZE8wV0FmWDZQMGozTERu?=
 =?utf-8?B?VHJBRG1wYUlCbTFqU3ZQc1BPRFo1eVFVMStLMDg3M3E3MVVVYlJiMVorQjd0?=
 =?utf-8?B?anh6ZTJWUG5VTTBMQVFVSUxUV1ZpZUZpanF5d0IzbFdtTEtSQUZwbng5SFYr?=
 =?utf-8?B?SnZJbnFOdG8rTnIwTjVDSnhsYnhoQkc2WU9rdUpJc2ZCS0s4VGNoWjI0cmVX?=
 =?utf-8?B?OTM1a0pzcnNwNGlLSVIyZ2htTnNoTGRhQ3NPMnEzRXEzWm96OWpTWWJlb2tN?=
 =?utf-8?B?MlNHbWdqRUNjR3hEQU1pZnE0U0I0M0VKM3d0S0Y3MXNEU3NOZHdEeHBGdmhB?=
 =?utf-8?B?bG8wOXFQd1J3VEliTjVxVXFqWDdYQjJCYlZoWlpqRVNJdzNzZlQzUjdwUDBU?=
 =?utf-8?B?ZTRsdmxocW5QTVplOFEwY0F0Tkp2MXFJd2ZtdGxML1d3bkhNTnA0a0thV1cw?=
 =?utf-8?B?MnVoWWN4MUE4ejlzVGd0U1NCeEdDUVhURXJ4QXgzNVVlYWJpSm1ZY0JRVml5?=
 =?utf-8?B?NTNEVHFOSDVQUEp3REY0cUk5YVlVbDVycEN6T2lSQU1vaVNQbkFwbkh2UDNu?=
 =?utf-8?B?MzBiQWhWVGpwMHIvM1R6Y0FuNDFiSXlmMGg1a1NsbStNVnpGb1RtOU9GWlBY?=
 =?utf-8?B?eFFKZ1hOdmlhZFplMUxpaVJXTFpNNnZrdER4c0FSTGQyKzdDcmFXRlExMm4w?=
 =?utf-8?B?d09TNzlNR3pGdytEV1FEWUNtYk42MnRoNDdwSVlOdHk1RmhVYWJSajh2NE1F?=
 =?utf-8?B?L0xvSmNGUmZvOEJoeWJpNHRxc1dVRnc2ZTZmQ3gxb29pNXdSRUtNTmsrVldO?=
 =?utf-8?B?Yjk0WHB0dGhTb3J2clJnN3FEbzFwd00yUmZkSHhCWk5EazlKbms2SnA4M2tV?=
 =?utf-8?B?N2tKak53UFZLODBoWDg1a1VaMzB6eGpGQUxFZkdQQTd2bHBoZmhPNEV3ZE42?=
 =?utf-8?B?MkFzMmxIZGQ2ZHdUcjVqSmhUL2tMcHkvQTdNaVJwdE1CNWY2c0RGLzY1SjVF?=
 =?utf-8?B?MjRYYW94NU14K0VEeG94a0ozMUpobTlUT3M4QVdNWitvM08vcmdyUm9iUkZr?=
 =?utf-8?B?QmpOKzArUWx4YXZteUIrWUJ4Nkx5OTRZM09TOWJqdHFXMWMxeWNsVWVXcUtY?=
 =?utf-8?Q?SBC880q0j7qIgaW7ZRubyTtAmEflqAKYSx43thY?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1FHMWFqRE5XNUJxT29iaTZjQ29GRVZQc0F1VG5JRWUxSE5naEg3b2JzZjZr?=
 =?utf-8?B?TlhFZnh4eDhxb28xV0tCbEtHLzdmQVJYclEyYk5HM2FBQlAySVJwTVpSSzMy?=
 =?utf-8?B?NHVIYU1jeEJ0RlNZNzhxSGxVZzhieGlkbVlrRnBQbnlUZ0prTU5nU0swREth?=
 =?utf-8?B?aVFhUkRxWlJIYWhoc3IxNHNHc3lxMmdCRDhHeVJqT1VWOG9naVV1T3F4UmxQ?=
 =?utf-8?B?cUZyYVg4d3pEWmhpTy9tN3Y3UzQ1YUNLS0dyQWpLZmpqTTZ0MEwzazQ1WFls?=
 =?utf-8?B?R3hyOC9VenVwQ21hR0tseWxvN2NDY0Q0dzlFY1BJL0xBRzVySUI0cEc3M3lm?=
 =?utf-8?B?Y1MyWEY5SkgycjJicW5nMUJRZnFsM2o0TjQ0ZDdMa0ZmMGRjczl3S3U3R1Zk?=
 =?utf-8?B?MnpnbmIzK0R4RkljenpGSVQrZWpOT2NUQURvSGdzTUJ4Z0IzRkllR21nM3No?=
 =?utf-8?B?aVo4a3RFSnNteFZRUXNTTlA1UXBhY0hibnRnYlFsUnRZdFdiZW9pWjMzb2pt?=
 =?utf-8?B?QTJINXJWQW5Na2FmcFJNNjNsUTFkcTBIYlNLTDF3Mm1rSHgxUXN0dUExRjF6?=
 =?utf-8?B?WkFXdjlaTTlBbFZ2Y1pUUzhuY0lxaXUyaU50ayswdlB2MmJpSUc5ZHBubnpk?=
 =?utf-8?B?aDRQblJBT0dzcGZNMW5TTGlJcnYweDRhWEt1VEJ4akZ6TlZ5czdwWnhZNnh3?=
 =?utf-8?B?ZDhzMi9UbU9IcGpLZmFMTDA0VGVRNGNTWDNwLzYxWGt5Y084b28yc201U05Q?=
 =?utf-8?B?QitXRXFMTFBweGZyZmVkdXEvaXYycUloUUpNWTlYZHNpU3B5dTJMbmJQSlNi?=
 =?utf-8?B?aFFJSnpRQXlFZUhKK2laUE5sYzJsRzFMd0d3Z1hoeE4rVWhMc2NkdllYUGgy?=
 =?utf-8?B?TmJONktsVGxRTDhEZ3Z1T2NKaEpMUVVZRjNwaEdMaEN5OThzR3FJalFCY282?=
 =?utf-8?B?dUhLNVdPOG5ybFc4TVdXNXFkeVpNQnRubnpmVWZzTm1oclplRGF4NGd2ZDlV?=
 =?utf-8?B?MG5CenBMQTlXMkFpQnl1bzl3RE5oRGlDTk0vTXpsQXRFZEZRSDUxTXBjclNC?=
 =?utf-8?B?aWVWeUg1bGdJRXU2cnU2YnZaczMvMnRQYUVSdFhjSmxtclEvM2xIRzFlMjlF?=
 =?utf-8?B?Ujl0Q3JjdzNmV2FjVXpNZEV6YUhuR0psMXhsN1owbTZXUlRmdGhYaDlaRCtP?=
 =?utf-8?B?SlJvZXhWblNmN2tSMWx6dGh3L3lheXkrcGhjeWtRbHRDbUVKS21LbFB3RElJ?=
 =?utf-8?B?YzZ6cnFuaW12YjI3ODNGeXVsTHlValVQeHc2bXZiYmFWNUcwSXZoeTJHYW5k?=
 =?utf-8?B?T0RROFNoNEpRUy9RNzNSems4SGtiUkRlTS9Lek9IMU1VMUxuOU9kNFBub01h?=
 =?utf-8?B?VjNheUV0WFRVNVIxTWszS2UvQlYrYlVCNHRpT2VzODNqS3dnVml4S1NzV0tZ?=
 =?utf-8?B?cDdvT1ltU2g1MVhGZFNHTS9GeEc2Zit0aWU3UjFBRjhCdXA0MHlxTUwvNytV?=
 =?utf-8?B?YU1MQ3ozOUdDalYyeEljQVpuTWxUWFRpY3NKaWpLM2tPR1VtTnJMOWhuWk9v?=
 =?utf-8?B?ME9uTW5aSkpTRndWODhpbmdJUXZCbmVvS0hrdURpSkFPcXJuTG5GaURRejZR?=
 =?utf-8?B?N3ljRVVkUnFNOTFQcDd0V0t1bTZrUUdPcEJIQ3VEd3dkVDNnVHBQQkZSZ0Jr?=
 =?utf-8?B?T2FVK01JNWhCQ1BIZHpDSkRHNWgrMzdxd2VEUGcyNzZYTlZYdlFWRGhnSHZi?=
 =?utf-8?B?a0xGODJCUzJHT1loQ043RFU2WXVUdWU4NDd5b3JhSER0SHBibGNIakFkUTBQ?=
 =?utf-8?B?TXNUYmZkN3IwZzJBSnpmRlIvRmZrenVyYVQ1MzJ4V05IWUVjT3pYVXVGZEFo?=
 =?utf-8?B?Z2RQZCsrTExtQ24yUWZ5UEUyVEZ5ME1CYTJJRW5xSG1tWmJQYTRMbm16YmhQ?=
 =?utf-8?B?S3BMQnNDWXBkYjFjdUhJNzdCQ25BOXFvc0JDRS9HTU1sSHdKUVVhM0lzMGhJ?=
 =?utf-8?B?WGZxcGx4VVVnKzg0aCtXcm9ieWhBRXA2eDBPNHoramVNSmxoOFE4NUp1VEZ3?=
 =?utf-8?B?UWJIOHdJS0MxbVNSZWV0SmI1UHpsZ3Q1ZUdrWkVRYXNuNGNjZkRTMnRncVFY?=
 =?utf-8?B?c2M2L3RiZUFGM3J6WS9CZHFib05uU0xxRHVFZ1docXEzdE5oK3Y5a0djQnFM?=
 =?utf-8?B?TXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 22edbG8NReGop0xLlCNYKIXFhNjLmj17BuF2x/Xt7s4lXu+9U+nRSiBdsc5tHm8/7C0xsv1HnL/xtEVnXCLxvwoHWWejpJ7eRW7d5hgpsmlCj5pJJ82u3HD2PWw3E2O4EKLaemajWRm6aYWsamK8JYeYLVzyFICW7bs+IF5RQoeymhmBsPaq+Nrzk73xdfMy9h0HeOzobaUHdjCLrSIZrk4HQ9pbsjhgOETV31iu2o4Dr+1p4kz/ABQeJM+aN8ee1EHzzhW3B4QAYJbyuS0xoxvWAFHiC/I/w7T0eoe3JRuDAmkItykpHAopcruR0xYItS80mbYtwrzy+5sqLVH/fB9YEljjT9rWytengruSfhYSnPwDjA6h7AAIX4jS8iHjILOLWDoubVA8yRw23C9qZiUOp6IxwGXNsJazeXSKJSsHGhM8lByoS2XK+v3IxgUMhCAMPwKEsCKKgl0qNqnBLCYboqTynq5qU8NwvVwWG3A8ZvKz3k374lzTII91C7yEF/Chrj1qcgY3ZGgdZ9gVft9dOlfQTWbMVJLRtuCoCtIVb5l8YnpcIj/0Yu8vy85HvpYqWA9/lTy6C/tucTdJyhgjHO0oUfrmneC/wU5GBQo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f310d8c3-0c5d-4bff-4da4-08dcef8a2336
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 15:32:56.0297 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7uvAH1NuZcrpCkAuW8lYnC8XJul9nxrvF0sGQhlATpUMnMiIQq05jFbTVFovqy819T9Cl9cMqm3bAiACASHxwA1dDsbaUU33mKwD3kIdx5I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4136
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-18_10,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxscore=0 bulkscore=0
 spamscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410180099
X-Proofpoint-GUID: GQIUsUTIaTw2LO7_fu-G52t0fHbX7mDL
X-Proofpoint-ORIG-GUID: GQIUsUTIaTw2LO7_fu-G52t0fHbX7mDL
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
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

On 10/18/2024 11:08 AM, Fabiano Rosas wrote:
> Steve Sistare <steven.sistare@oracle.com> writes:
> 
>> Make all global and compat properties available before the first objects
>> are created.  Set accelerator compatibility properties in
>> configure_accelerators, when the accelerator is chosen, and call
>> configure_accelerators earlier.  Set machine options earlier.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>   accel/accel-system.c |  2 --
>>   system/vl.c          | 34 ++++++++++++++++++----------------
>>   2 files changed, 18 insertions(+), 18 deletions(-)
>>
>> diff --git a/accel/accel-system.c b/accel/accel-system.c
>> index f6c947d..c8aeae4 100644
>> --- a/accel/accel-system.c
>> +++ b/accel/accel-system.c
>> @@ -41,8 +41,6 @@ int accel_init_machine(AccelState *accel, MachineState *ms)
>>           ms->accelerator = NULL;
>>           *(acc->allowed) = false;
>>           object_unref(OBJECT(accel));
>> -    } else {
>> -        object_set_accelerator_compat_props(acc->compat_props);
>>       }
>>       return ret;
>>   }
>> diff --git a/system/vl.c b/system/vl.c
>> index b94a6b9..bca2292 100644
>> --- a/system/vl.c
>> +++ b/system/vl.c
>> @@ -2346,6 +2346,7 @@ static int do_configure_accelerator(void *opaque, QemuOpts *opts, Error **errp)
>>           goto bad;
>>       }
>>   
>> +    object_set_accelerator_compat_props(ac->compat_props);
>>       acs->accel = accel;
>>       return 1;
>>   
>> @@ -3728,29 +3729,14 @@ void qemu_init(int argc, char **argv)
>>       parse_memory_options();
>>   
>>       qemu_create_machine(machine_opts_dict);
>> -
>> -    suspend_mux_open();
>> -
>> -    qemu_disable_default_devices();
>> -    qemu_setup_display();
>> -    qemu_create_default_devices();
>> -    qemu_create_early_backends();
>> -
>>       qemu_apply_legacy_machine_options(machine_opts_dict);
>>       qemu_apply_machine_options(machine_opts_dict);
>>       qobject_unref(machine_opts_dict);
>> -    phase_advance(PHASE_MACHINE_CREATED);
>>   
>> -    /*
>> -     * Note: uses machine properties such as kernel-irqchip, must run
>> -     * after qemu_apply_machine_options.
>> -     */
>>       accel = configure_accelerators(argv[0]);
>> -    create_accelerator(accel);
>> -    phase_advance(PHASE_ACCEL_CREATED);
>>   
>>       /*
>> -     * Beware, QOM objects created before this point miss global and
>> +     * QOM objects created after this point see all global and
>>        * compat properties.
>>        *
>>        * Global properties get set up by qdev_prop_register_global(),
>> @@ -3765,6 +3751,22 @@ void qemu_init(int argc, char **argv)
>>        * called from do_configure_accelerator().
>>        */
>>   
>> +    suspend_mux_open();
>> +
>> +    qemu_disable_default_devices();
>> +    qemu_setup_display();
>> +    qemu_create_default_devices();
>> +    qemu_create_early_backends();
>> +
>> +    phase_advance(PHASE_MACHINE_CREATED);
>> +
>> +    /*
>> +     * Note: uses machine properties such as kernel-irqchip, must run
>> +     * after qemu_apply_machine_options.
>> +     */
>> +    create_accelerator(accel);
>> +    phase_advance(PHASE_ACCEL_CREATED);
>> +
>>       machine_class = MACHINE_GET_CLASS(current_machine);
>>       if (!qtest_enabled() && machine_class->deprecation_reason) {
>>           warn_report("Machine type '%s' is deprecated: %s",
> 
> Hi Steve,
> 
> after this commit:
> 
> $ QTEST_QEMU_BINARY=./qemu-system-aarch64 ./tests/qtest/xlnx-can-test
> # random seed: R02Saf9b44f2d88dd417052905692ee79981
> 1..5
> # Start of aarch64 tests
> # Start of net tests
> # Start of can tests
> # starting QEMU: exec ./qemu-system-aarch64 -qtest unix:/tmp/qtest-2396.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-2396.qmp,id=char0 -mon chardev=char0,mode=control -display none -audio none -machine xlnx-zcu102 -object can-bus,id=canbus -machine canbus0=canbus -machine canbus1=canbus -accel qtest
> qemu-system-aarch64: Device 'canbus' not found
> 
> I tried briefly to figure out what the issue is, but I don't really
> understand the dependencies involved. Hope you can tell us.

Thanks! I forgot to define the preinit method for the qtest accelerator in patch 1.
I'll verify that fixes the problem and send you a one-off patch if you want to continue
testing.

- Steve


