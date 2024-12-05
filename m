Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12C02E7716C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 14:25:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJCmP-0001l1-2F; Thu, 05 Dec 2024 09:24:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tJCmN-0001kT-DF
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 09:24:31 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tJCmL-0001pd-1h
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 09:24:31 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B5Dfkcc004592;
 Thu, 5 Dec 2024 14:24:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=tMgqfBjTi9o3Tz7bFR1EAgIF3D13Yr+Mfx+6YFLAH3s=; b=
 nNc0pWtE2EjhqoTDRI4B3HZPrbr8QzxK8b4RaQJZ2QKbw4qk55HzARWiN6gBzAcI
 IDwzcuVEMQnalMXxxemFo/uuXjLqhRVcN/OOA3W3o0L8t4CwCRXWLJptoQAyi7kE
 MH6MAQPNVvj4lvQfKoxBgSc7txk3UgD9ef2egVdUCcYQEbfQbIo/VLb4IN+655bD
 VgFaF2Sx6OJ1/6EDuWkKLUexEd5RzqOXOK/j8wLgG2Vu1JzMJC6d+8ACWWWSJ8Y6
 nMkW3/c5uBzdexB/dJSFJmWCsWzeXlIQTJp0MWem0j3uhNh8gtmwYEPrSyhuYccO
 0+WNNzPL2AV7HR4kYmLIIQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 437sa038em-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 05 Dec 2024 14:24:24 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 4B5DTrJr040014; Thu, 5 Dec 2024 14:24:24 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 43836wvyfj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 05 Dec 2024 14:24:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XPGr8HN0W040iDKxqIqQWpjhP6ZXQk6lwsNGrDsGiMaJeE9SpZ6NcPMrOVanhVUd4rQTm8+1D07oHeMNqZ/BpcH8mVMbuz6m1WUsBz32Kler7hLlEUZtnio0AToPiKjIv1a3UDvl7gcvhjAoAygOgYVnw1IYJpDHq4rtEot5Jc2TzRYl31m8dJsK0lxc6aTmbw56BtkrfiA1EN9SWkWx3NW3vpsoVCWGjIaH+JeKckc6KrG2cND2xfqekzm/kKRJ2D2VNqbOT0KZR6hNgR13mQ3xeVuxpnAnoSOgW7z0x8mi7opg4d/ajyDJbypZvZzf0kGRt9xA5/JwaO4mKa13hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tMgqfBjTi9o3Tz7bFR1EAgIF3D13Yr+Mfx+6YFLAH3s=;
 b=sC0Su0svscksxiRpFx0YsOFhhwm/laHZgszDJfFtcJzwwc6xYwNoPEJR5VRWw/bLB6SYjcR9d4x36OCIbhqfGXVjlW189pXz9ocV5Jo2R0GcagmvZii7nUqmexRtdCf9DSZAMG4PvXgLXtlvV5hALTWMcyFxxVk2hFmqLgzoeoWFlwRDwrKqz1YNAiT8+0Wv7EsW0HOfLxDiInlKKVNpSEmrlXf0dPeOklhpQhAKTOF+WehcphcMI4f2G4JuECZpB+ko8lOw3DmeyiEz4dUXQfXQGtCKnJmHAQLto5segMF7yERts0ATLiskgSdWd/xjqzBEeUNCYb1xbnG7GcaN4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tMgqfBjTi9o3Tz7bFR1EAgIF3D13Yr+Mfx+6YFLAH3s=;
 b=PCMSfu8EKuNIBGBsrHtORr/LKYNKFZNKxCqy6LyaoB3yMoyXPkKqhp32N/pFUyavxiJbX8WqbTQ3zhz9+5svBe+jRFjuql2EvDJ6bB2sJD4xF+X4T65As6v7V6jImXsrSne0CbIZie3cZSLmuy3E3CeFm9sFVDFJevQBuFnjtTw=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by CY5PR10MB5964.namprd10.prod.outlook.com (2603:10b6:930:2b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.20; Thu, 5 Dec
 2024 14:24:21 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8207.017; Thu, 5 Dec 2024
 14:24:21 +0000
Message-ID: <d185874a-0f78-47f8-9b54-147127ad3e69@oracle.com>
Date: Thu, 5 Dec 2024 09:24:18 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 04/19] machine: aux-ram-share option
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>
References: <1733145611-62315-1-git-send-email-steven.sistare@oracle.com>
 <1733145611-62315-5-git-send-email-steven.sistare@oracle.com>
 <87ikryh6yw.fsf@pond.sub.org>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <87ikryh6yw.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0281.namprd03.prod.outlook.com
 (2603:10b6:408:f5::16) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|CY5PR10MB5964:EE_
X-MS-Office365-Filtering-Correlation-Id: 77ef8979-c7c6-44dc-9674-08dd153882b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bkVZbGpTR01ZM05kaUI3ckhiVElXS2o1bERjTlhacVRTWUQ4UDg5OGt3QnE0?=
 =?utf-8?B?S0tpZFZSVWI3NWF4Mkd6QVZ1MjNoc0N5YXNDSzQvOWpobnlZelU1dTZ0NnZH?=
 =?utf-8?B?dUVLdVZRbWthYTd5R25RMmVKOC9oQ09WTXBUVzQxaVUwQXdNRnBMcktlWm1B?=
 =?utf-8?B?b0hsRk9GK1oxRStNMXFkOWR2S0swM09kbkVVQzY2Y2poV2FIS1oxM1BPZDZY?=
 =?utf-8?B?ekkyejVWeUFJTzFYK05xd0VoUXpWUC9UQk80bVZzZFNaYm1DUnR6N24yR0tB?=
 =?utf-8?B?ak9jcjhkd1NaclBUZ3BnSW44N0FNSnZvbHNRWHBkUTlsd292bEtzTFNrVXNt?=
 =?utf-8?B?SmpSNDBSWTZDdjFRTjNvdkhVb0RUKzR6NjFZRjVHdDEyQjRMUzl0Y2g1Ny9h?=
 =?utf-8?B?cjUzVVMwNVRVQU8zV0NsRFdDdmV2MW5lYUhleWdqSGY1ZVZ0cURRTTFTZzB6?=
 =?utf-8?B?NjZ5VU1FQTZqaDJJTWE2Q2lSUDJLUS9vVURmT1dydkllbDhjbmdoS2tjR2NU?=
 =?utf-8?B?OWYwT09NcndtaW9GOFd4Z3dHeVpuLzRTMGtETUVPYTU2Z3EycGNWQ1dFSWNp?=
 =?utf-8?B?VzhHWjg3Z2VqOVV6U2R1NCsvNHRMNzhycGl2cTFvS0FhSG9BbWNEUkI5bzhL?=
 =?utf-8?B?ZlJYbzg4VDNzSXp0VXZHWUxQQUI3ZUg4cGRzMkFid0c5MFNOZW51NWsxZFBv?=
 =?utf-8?B?a2JLYW1hMXdjNW9Tc1Jwek1TMUtINU8yTWZKSGtvWFk5NnNNZUNpR0I3RE9a?=
 =?utf-8?B?SmpiZ1BQd3pTQ01TSi9SbGN3K2kvaUVudmZ5TWR4dGdVWGNHNnNZTVJNVEZ4?=
 =?utf-8?B?SnprZUFlZldoZ0tWR28xWXJmdllPbytqQ3owajlJalVES2xYNS81ckxNUG4x?=
 =?utf-8?B?VEZrWEI5ZGV6N3lIYWRGM1hLZlB4M3hRUlJzdVNYYjNpaGRrcWsyS2NLWGkw?=
 =?utf-8?B?cGhoTjRXRTNySVlhdVhCa05xZDhTOXZpQm9KRGJZU05sUjhweWN4MkUvN2J3?=
 =?utf-8?B?a3B2ZEo2WnRDQXdMZDZ2d1d1UkdlOEJlZDhYVnkrK1ZoRjM3Wis0Q3BLRGRr?=
 =?utf-8?B?LytlU2pOYVJSeWxKTEhFY0QwVkpCYzBWOElsWFlQaGNKRzUxOFJlQ0pDcnlt?=
 =?utf-8?B?ZGhNMFpnWWJDdXZwSnFxWUdJZlFqN0NFN3RRRjhoZVlsa09MSlA5K2E3UVQ0?=
 =?utf-8?B?WHY0WEJrNyszZDlkVHBjOVNtV0lmVm1LNFRtcHRZRWE2bHM0OCs3dWJnbUVp?=
 =?utf-8?B?ekRvSzdmalV6eG5GZ0x1dHJrNmxJZWRSZDhpNm45S2QxWlpBSGJMZmllNFBw?=
 =?utf-8?B?NE54M1N1ZFJFa0VhdlhWZXhJUDI5MUVKclA1bXlmNjU2dnRxMVg5UnZTdHhK?=
 =?utf-8?B?NHVWOGNnMHBCSWNkNUlWMk1hR3FYa1h5dzg4TExvOTVTV2xGWWViZFJQTXQx?=
 =?utf-8?B?T3FxTm84dXQvcFVtVzN3clFqOW1VM2NyUHV4bzdwNDc0VVNzK1JZaDJnUmgv?=
 =?utf-8?B?S00xOHVjUFc0S3RjcWh6NEluQXlEM0ppTEcxeHM3TXRVWU1WblYzeDZiYUNx?=
 =?utf-8?B?RTlLOUViMFQrcWFLWG5zVEdrbWdVV2tXU0FyM1pXZFk3OU1rWnFKZFdUSjBZ?=
 =?utf-8?B?amlRV2IwcHFJSVdsR3VNU2l2ZTRJNDByZittU0pwTjdvZ3l3MXZXUGZudUR2?=
 =?utf-8?B?bVd1NjhnNXlJQ3ZGSVlmdjdXempmYXJEWXhSVWR5NnNzUm02WFdZR0RxeW15?=
 =?utf-8?B?OC9BSVNwQWowaVpIaW5NM045UWRmMVFzcnpPa0YrWEIwWTdZMnVwZlgxek5M?=
 =?utf-8?B?STZlY3VEKy9GNTVYeEFwdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dm9VWDJMd1ZVK3ByNC9uWklBemVhOW9zTnNRYUFIOVlNVG5ZVldzRWwrdDBy?=
 =?utf-8?B?blp4enozUDBEclkwQ24xSE5PL2xqb2RYb3RpVVU0bCttUDYrL29abk1pU0h6?=
 =?utf-8?B?OVVXOVlvSG5pMWFDZ25wUTA5UkdaOGpsV3A4QkJhc2FOM25CZVl0SEgrcDJL?=
 =?utf-8?B?R3ZhSDgwSmQrb2NKVGlSdkVpUzRPMnpDcUJHU0sxKzMxdDdrK2tLc2tZUnVD?=
 =?utf-8?B?NEdpeE14R1d2eERTQ2xaUjVRcWpQc2I2ZFRZeTlDd3kzZ2laaVIycW5KMU1K?=
 =?utf-8?B?UVFlSWtNRHRNSG9aamNjUGMyaWZHYzlLTHlaakY3SEdKVFBGSVc5Q1ZyektW?=
 =?utf-8?B?Y2RyS2UyUXRCYy91ekNjWHZ2Ynl1VENwemRDQ002Rk5nOEpIVlhjdzIyNis2?=
 =?utf-8?B?bGFSUThGWDFaY2xlcThMayt0aDdDQnZBMW8yUWRCaWtwdXhJTDIvY3ZVOXc0?=
 =?utf-8?B?eWw2MXhxcVVKamJIZXE0N0ZNS2xIalUzT3BySXh2VWQ0WU1kTlF2OFdCakNk?=
 =?utf-8?B?UGk2REQweVc0SXMxUVNNUFNhNUk3U1BGa1lYOHlHd2JxaDUzVi9STWFVaThQ?=
 =?utf-8?B?SXMrU1ZCM1FxMHlrbmVKaDJQRHRIUUsrVXo2WkRnT0xDOEQwZHZDQ09SZnVa?=
 =?utf-8?B?Uis1ODQ2b2dBcnBTSFpld3BVQzJQREtnYjRsS0pNYURhbEN2dWdCclJSWnhV?=
 =?utf-8?B?M0s1QnZaU3JBc0VRRFlreUZBZHB6cnZPRm54Z3NwNGNZdTMrVVJQT3pkaFJw?=
 =?utf-8?B?dUU1cUFqME82L1dLY1BFWnVwY1gwTmNJbnZVMHpneXJBUzFZYlBpRCtVV2Uv?=
 =?utf-8?B?bDkzdFZReGdzSVpiVFpnZVFJY1Ryc1UzYWZPd2VsdGRvbW9ZMk5PQ2l4N0Fw?=
 =?utf-8?B?UUlVTFFsNEVYSWRSSzJteE5tek4wRkxwanUrdHhoZnVsR0xKbllVTUhucGNP?=
 =?utf-8?B?cWpSZXQvRW1DcXBCL1l3RWJ3eERRVEpOR2RvWTRNR05FUEtHOHN4NEpQT2o0?=
 =?utf-8?B?R2ZBK3Z6dWduRGlVZXlZSXd0ajlLTnVXTEo2S2VGWUNOMWJ5QS9YOVA4a0J1?=
 =?utf-8?B?Nms2ZnhtQmVnRmd0NjBoNGNneGZCZ0UrK0hweExhb2RUejVVZ25TRGxEWTFK?=
 =?utf-8?B?N3FoWER5YXViM3YvbTlXczNaUlJYeERXQThTRnJyamh0K0xjNUxrWFR6VWZU?=
 =?utf-8?B?L2d2S3RHUmNxZmVURTFBQVE2eTlBVDdPcXk3eGlzMGgydXA3eTl1RnQ2QnF6?=
 =?utf-8?B?UzdGaGE1a3pBZk5yaU0vY3h1LzJSc0FlaTNjMks4Zmwwc2RabUdsZ2VKYTND?=
 =?utf-8?B?MUxwOW5ES0VoYW80eGpCby8zaW9TNVFEWXo0S1lBeDlRYVFHYkdpMlQ0ZUpX?=
 =?utf-8?B?Ui9UZ0RCZ3FhNG9wUzA4YkJyRzNMOTEydldkeWc4bG1FSFpxNjdxYWZ1c05w?=
 =?utf-8?B?U2pwUk0rclh3M1AxeFRlVGxvMElhWG1FcjVtVzYvYUpTMnc5VFFQUVJ5Kyt3?=
 =?utf-8?B?SDNNN1RHQ21mSnJ4dkUvd1F2Z0txMHdDaEdlNmdKUk4rU2Q1MmNhMVJVT2hm?=
 =?utf-8?B?WitlZ3JEK1ZzL2R2eTFoeTJVUG5EM2dmd3ZyRWsrQjdyUlBxS0xGbVRDTXVI?=
 =?utf-8?B?OEJZTFZ3TVJjbGpEMlNPWEZZRExFRVBwejhCKzFNMDNLUUFySU54NTBoWkVw?=
 =?utf-8?B?N3ZDNHVSTmIyeVNKU0JFb2JWQ2RObXd6REJMSUJYSHY5clc0UW96OU8xeGhq?=
 =?utf-8?B?K1NTbDNiSG9BdTBTU2d4NHhvMHhLR1dwYW55bTJvL0dvcm5jTitWb2xGdlFx?=
 =?utf-8?B?VjUydzdZRW14amVERG95VjUwVVBscHlZVGlXdlV6L2RIUk11aWhmV3k2a0hI?=
 =?utf-8?B?NEFtcDFVTy9YTlB2S1R2M2tlY2s0UXVLZzYyRVZ5bEY3VFFuZk1GT3Fqekhs?=
 =?utf-8?B?SWUraHVhK01FWWFrU1g2TnlxakpPbDREY1VOTmFOcGsyWlVyMzBLOVBWOUUv?=
 =?utf-8?B?cHQ1Y0hYV1A4L3lwTk40TXkybXAxMWM3K21MM2xpZFNBQ05QS2piS2RGYm96?=
 =?utf-8?B?Y01aZDlUL1czRE1FYUFTbktMWWpQY24wTnNxTGJyeVQvUEJYaWpDeGpDUTk2?=
 =?utf-8?B?WnFZa2dPL0NNWDVDcnY2NXpibEdNYzYxUjZzZ0tkWHNlTzRTRE43VDJkQ3lZ?=
 =?utf-8?B?TGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: i7UU8x0Rve7bIPF4j7uehzAfqlvgWF8fQpMegKFJO7jTw+3Emv6lLmw3XNiuCxksdnacgP/UjDIgRmS0kUDeXj8O6iyi1UJ93LHk9nIPsNgDhQNT3tuKHGOMA96zNujKA3hrPf8G9bp3Ipe9sxwtIuSb6+oL8UPqCJD1JNsbgGGeZJZI10rUxAEyjN4rLHvcy/jtDUDNYPLV4sZA6Ut79vOx32duK0gQ9+a/1lCPmVFRBoQK1jItT+v66/rMK5PBjsf2ZynuFyDFzQmWGkXRjhGKJkqZXzl0GPJVdl32BvttH6FQLLboaq/IhtW9t/uLQolUu370vtKccUMbYeEIrzsgUcrofwGZJyQP02yEN4rZQTDnMq90vZF/Zzwv/ZUfr2pTQ2fIeOnFrQTZu2oRfPYR7r+brklYmQ+tgZB6L79XSByS/C1dW0lrpS/f4xXvqBRFjqTEaP2Z0VqM2c+YrbwTt+9TzlTib6tVZgwDkdwDd3+9+JX3QZuJBNYhs3/Cwx3UK9tfEItVbNNHfuvryqvqar1oM+dYzVusjx7BbQx4Q+ZsI6XCkk0r25OL3K7mA3SY2d4pFB7+q1AlvOlp/FTOYq1JnseWaULM0GAMjmU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77ef8979-c7c6-44dc-9674-08dd153882b0
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 14:24:21.2643 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k0+ycyGvrG2A6viC63eQCEuEfq6dAOl6nWPslgadnPGS/XfLh8a9mUqCSw63tJnyqFzJFL0HE8uTEjhyvG7VQTaziECBkINyFVdu0Y/vk20=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB5964
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-05_12,2024-12-05_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 phishscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412050104
X-Proofpoint-GUID: -da8C9PVdLWhujxETcuNvj9DcdIYizqw
X-Proofpoint-ORIG-GUID: -da8C9PVdLWhujxETcuNvj9DcdIYizqw
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
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

On 12/5/2024 3:25 AM, Markus Armbruster wrote:
> Steve Sistare <steven.sistare@oracle.com> writes:
> 
>> Allocate auxilliary guest RAM as an anonymous file that is shareable
>> with an external process.  This option applies to memory allocated as
>> a side effect of creating various devices. It does not apply to
>> memory-backend-objects, whether explicitly specified on the command
>> line, or implicitly created by the -m command line option.
>>
>> This option is intended to support new migration modes, in which the
>> memory region can be transferred in place to a new QEMU process, by sending
>> the memfd file descriptor to the process.  Memory contents are preserved,
>> and if the mode also transfers device descriptors, then pages that are
>> locked in memory for DMA remain locked.  This behavior is a pre-requisite
>> for supporting vfio, vdpa, and iommufd devices with the new modes.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> 
> [...]
> 
>> diff --git a/qemu-options.hx b/qemu-options.hx
>> index dacc979..02b9118 100644
>> --- a/qemu-options.hx
>> +++ b/qemu-options.hx
>> @@ -38,6 +38,9 @@ DEF("machine", HAS_ARG, QEMU_OPTION_machine, \
>>       "                nvdimm=on|off controls NVDIMM support (default=off)\n"
>>       "                memory-encryption=@var{} memory encryption object to use (default=none)\n"
>>       "                hmat=on|off controls ACPI HMAT support (default=off)\n"
>> +#ifdef CONFIG_POSIX
>> +    "                aux-ram-share=on|off allocate auxiliary guest RAM as shared (default: off)\n"
>> +#endif
>>       "                memory-backend='backend-id' specifies explicitly provided backend for main RAM (default=none)\n"
>>       "                cxl-fmw.0.targets.0=firsttarget,cxl-fmw.0.targets.1=secondtarget,cxl-fmw.0.size=size[,cxl-fmw.0.interleave-granularity=granularity]\n",
>>       QEMU_ARCH_ALL)
>> @@ -101,6 +104,18 @@ SRST
>>           Enables or disables ACPI Heterogeneous Memory Attribute Table
>>           (HMAT) support. The default is off.
>>   
>> +#ifdef CONFIG_POSIX
>> +    ``aux-ram-share=on|off``
>> +        Allocate auxiliary guest RAM as an anonymous file that is
>> +        shareable with an external process.  This option applies to
>> +        memory allocated as a side effect of creating various devices.
>> +        It does not apply to memory-backend-objects, whether explicitly
>> +        specified on the command line, or implicitly created by the -m
>> +        command line option.
>> +
>> +        Some migration modes require aux-ram-share=on.
> 
> This leaves the one thing users really need to know unsaid: when exactly
> should users enable it.
> 
> "Some migration modes require aux-ram-share=on": do they enable it by
> default, or is that left to the user?  If the latter, why?
> 
> Please document the default, whatever it is.

How about:

   ``aux-ram-share=on|off`
       ...
       command line option.  The default is off.

       To use the cpr-transfer migration mode, you must set aux-ram-share=on.

cpr-transfer is a forward reference at this point in the series, so I will
move that last line to the "cpr-transfer mode" patch.

- Steve


