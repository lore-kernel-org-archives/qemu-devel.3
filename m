Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CBF2C87FCB
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Aug 2025 19:54:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujNiv-00034e-KV; Tue, 05 Aug 2025 15:53:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1ujNiu-00034M-0J
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 15:53:24 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1ujNir-0000fj-RB
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 15:53:23 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 575IuJjd022884;
 Tue, 5 Aug 2025 19:53:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=DyZ2lm4glAZqI0lU9V6hNb8WkPwBkT6ajFWCoLVXYPE=; b=
 XAvlDUa6mZDAWEfTwGGpxVxNLP1JAHGjhOJW/H1fuqHUETINSAFU+8xgF0BMzxc9
 LbBTx5O/GbxKn8rBDMfbJRjPPHBI8nd4CpOlvF8huWuySiftPyTmOCDNEI101KJc
 h3v6vb0yd2WrrYte2x7d0FxpLpJst90J2hD+2jCg71Nb+jYVuZ4B0RB32XaebUoo
 Cn3PTmIzHG5Jd38CTxotpR6FOwVzP0+yVeYli7AE2cm1uEmt+myMFxG9L4yXdMXz
 uYbSlwupZ3SjH1sy276bcLzh8QSmelO5Bd8n9Uxg0Orz6mq5jssPhDVgwEdOhzus
 2izbKtL+cKenwkUmP9N/Sg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48bpvgr6x4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 05 Aug 2025 19:53:17 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 575JpjBO001561; Tue, 5 Aug 2025 19:53:15 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2057.outbound.protection.outlook.com [40.107.236.57])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 48bpww3ymp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 05 Aug 2025 19:53:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HamjbXvS0xVw5lV0sSn/Ru2ytHkULv81X3wu32lMQQF+l4NhaT+/GbWjrd9chx952aSJ6cr+uliIzlVfT7WjDw2jRfiZKWeQw7cYGfnabbq0vhXnJdfY2p2erjb9+EwPMswcBFreSLb1u1A6sqeYhlnt7hGSeoGGWSpSltxWoWKIDQ8Xg3e1tw13EYdl06HG8r++t9xWUpCJhpWUuhJU5PCzoRJc3PYlGEDAvjL2T2frADLeBlZxhEo6ckw1rnPrsrckbgbwpTtKoPJN0xaDuKPqsI+6WsdeO5g8ZKuoON++tfQKUc63XaqZXfJ8rcWEo7R1eX7TZicAX3zx6936hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DyZ2lm4glAZqI0lU9V6hNb8WkPwBkT6ajFWCoLVXYPE=;
 b=CJ7MZYu4207GPC8rXxo9dPpcPESDQSDgPT39HYSKAQSIJcS+ocuk2988NrLT1vmo7i7GLKE50H/g7Mjv3tpHIjyZWAHxgOslnLKljozLxtMiQVlQ57aX7pWn5HHFMlnILelskcd2YiTozi9d+5izodVdqD/YLbOGa0852e0fVobB7VKSbZbPZgTPeasJyl71hWa/1DmnwUNeneGSXrh3Bvi8NPwVpogAB7wW2856Ov9h/oKiGXmwzywDifuZRWSxuGVOhRwUauxtmscL5ceIfTSl3qvBJ5VOELom0WtjZ4MLUJD160mg2Kh3NSzCPrLWrX96fPlOFUwQvLzQEy1IfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DyZ2lm4glAZqI0lU9V6hNb8WkPwBkT6ajFWCoLVXYPE=;
 b=FlHOwrDTcmUtD9u22JyVbGduJ+sF8/x0VJ4hzwZL/fa5fxhtW/ws2pxsh8PAJjVa+bPMvxdL9mktWLL8UkbGmJWKZckUnOPHJw+VB4Ws4Sa0qlZRRuSHg2bMuNZRkNoZZF4d68AhvZ1x6UbFvFWgHPtb16SF6zxXEYPgVZjm4ek=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by PH8PR10MB6386.namprd10.prod.outlook.com (2603:10b6:510:1c1::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Tue, 5 Aug
 2025 19:53:13 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.9009.013; Tue, 5 Aug 2025
 19:53:12 +0000
Message-ID: <a01be1bc-8604-4ed1-9c22-9fe4b45de595@oracle.com>
Date: Tue, 5 Aug 2025 15:53:09 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V2 0/8] Live update: tap and vhost
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Peter Xu <peterx@redhat.com>,
 Hamza Khan <hamza.khan@nutanix.com>
References: <1752777568-236368-1-git-send-email-steven.sistare@oracle.com>
 <87cy993mdi.fsf@suse.de>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <87cy993mdi.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH7PR17CA0004.namprd17.prod.outlook.com
 (2603:10b6:510:324::15) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|PH8PR10MB6386:EE_
X-MS-Office365-Filtering-Correlation-Id: f1965b59-9ba5-44f8-e681-08ddd459b5e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?azlLUzBzdVhrM3ZJNExNMFhVY2V1R0d1SVc4Y2tSYnlUSENLazhwakVaL2ZP?=
 =?utf-8?B?WVM3a2o4dEN0eVg1SSszcjFHS1ZMaFNaejBleTZBeWQ2TXRNRm9nMlVBMXBT?=
 =?utf-8?B?YVd2dCtUdHA1SWxMYitCVU9wdlpQZVpPOHdFNVA3SUxNdHNBNkdwcFBZdHBW?=
 =?utf-8?B?ZVlVQlpIVFErTkd6aEF0OE5SS0Z4RjRabU93K0dQMzJlNVFWTUhBYUlGNVhu?=
 =?utf-8?B?RXVOQmxxb0J0Y0NGYTZ2TWlQWFE1L2VETHJpVm4vQm9MYnJBNFRJOFYxTzZT?=
 =?utf-8?B?TXo0R1BYR283NHFVOEVBZ0RuQlZSMFZ2ZksrbkhBczJmUGRtWkxhWENQWEVE?=
 =?utf-8?B?Yys0K3l0SnMyUW5IVVlWTEExaXRXV1pMVU4xWjF0N01ZS0FRZkRvRGlpVVR4?=
 =?utf-8?B?Zk1ndytyUEtpNnpnemtJVGhjWHdEZ3M1TDJzZXFVSCtZUkl1UndHM2Y1S1ZR?=
 =?utf-8?B?Yld2ck9RN3FYR1VHY0Y5cFZPckVwN1BWOVVMTUFtem1SbS9VdUJGcWJmR1NY?=
 =?utf-8?B?THBCdUd6cDMrNk1PSHZBdHZMTW82eWo2S1hicTZUbG9OaWpQcjJJcm9DeWpC?=
 =?utf-8?B?Y3FaVVk1eXc3c0dDclhPSWpFaGFKemZLcnVud0dpeEhvNG5kSlFXWjJTS1c1?=
 =?utf-8?B?d1B1ZkJrdTk1Y1BrVFFJbzJVeVF1V1RrYlA0TmE5bm1mY29OQ2lObzhJK29M?=
 =?utf-8?B?Wm5ETTd6V1NQbU9WSjRlN0s3QkVCanBuRkEzMkhaR00vWG0rVXRWYlhMSjdD?=
 =?utf-8?B?NVhiRWExVEpEdHlzY1FkazllV1JsNE5zbm5pMWhRTlkwcXkzQXV1K3FiTm00?=
 =?utf-8?B?TVg4dWFmMEk5YURUSzJENzA5MWVGTVZ0ZElxVWhOMk1CeDQ2R01LZGRrNnhU?=
 =?utf-8?B?WUtodjJwNEZ3Z0E1cEdEbDJDOUk3WndUVDZ3Y3dOTExsWTNpaTRKcFJtRkVP?=
 =?utf-8?B?NUFsTTVMVWxFYWVFZ0hMaDJsVFppa1lsekM4ZjI2K0VxbSt0RVVEUHZPNCti?=
 =?utf-8?B?YTFrYVZGc0FHbGVOa3EreldudkZnWFBXaDI1Skc1c2FkWkdJYk4xVVI3dnBw?=
 =?utf-8?B?R3doTHdWd0VBQ3JacGhJUnB2SjhZY3JWeVpJZEw3bHFRMkpxeUZWSjVwem05?=
 =?utf-8?B?Z0g3RVA0UldVV3krZjBFbm1LcDVmZnVoMUh6ekhvOHFTSXNtZ3BTN0RndjRh?=
 =?utf-8?B?dUxmeWJqa2xkaTJRdFNSeHFoNDIvWWZreDZBaWhxeDQvajY3a2Jldk5WZkI0?=
 =?utf-8?B?bkEwZkVWMjhYeFZTT2djTmRhU1BTZk85Yms3N21oUjVPT1Y5ZytRYW52VzAv?=
 =?utf-8?B?Sm5ja2hxUm5UaExYNllWMkpmQk8zeU95VHBUUWNPNEdteXRITVVFcmZrZlRo?=
 =?utf-8?B?eG1kbExsN09hdGoyWWdCb2dMaGVsVWtyTm45SGJISzdXdzZMeWFKT2t5MFI2?=
 =?utf-8?B?OW8vek5ubVQ2UGxFLzJXV0lXbjRKVUpad3hycmZHdGRhRzIzQnlZMlo0c2NW?=
 =?utf-8?B?M3R3YVFPTGdqL3EvcEpKTnNMbGF5OTJXeGg1ZXc5bVZ5b0tvQVozdU8vdlpu?=
 =?utf-8?B?MU9LU3Nwc3NhQytKVWp4ZXpGSk4vTnNpNXBqTHVLSVk0MjZrdUFqQXZaU0Mz?=
 =?utf-8?B?d2s4bUkvQXRLU0o0RzFNekpnN2pQclRYNWRxWEZpSUhzbjIrNGdES2cwMWNu?=
 =?utf-8?B?TXJ0QmxCdytNWk9QZzloejdEdnVVb3NFRm9KTFczVGdLRHFLbTRoSDVRc0lW?=
 =?utf-8?B?RnhlL0xaRkpaZGVzd1lhM3c4YVE5WFdTNnk0ODBCMFpvL0Fia2ZteUhSeEFz?=
 =?utf-8?B?d2xwakNPYS96K3J5RDB6Ym02SGpHL1BaSUlvaUxuR1dsdlNLYXluSWFURmF1?=
 =?utf-8?B?QmJHbTlzNFhQMmtyTWM1OUhoZVllbXczWlJpRWQ3b0YxbVpJdjlpKzhWNTUx?=
 =?utf-8?Q?eAi1QD833Qg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?am4wU1VVK2lrSlUvNUFjSnVQeW5JTWZwMXBuWDdYR2xXNDY3WDREZVNaRkFx?=
 =?utf-8?B?bUN3YmwybW9GNVlJTkNELzFuczdxUmZyN2wva244cUxWMTM3d2RwamY2KzlG?=
 =?utf-8?B?WmVLN1FwMDdVMWc3ejg3UnMrbHZoYnZjdUpuN2Zpb2M3YkFyVVB5b3hlZGpM?=
 =?utf-8?B?cHk2OEpIVHNJVEwyeVBxTEl2QlBIdWJnNjBiNWNQNitGRjVjSVRPdC9ubHFJ?=
 =?utf-8?B?R1RIeUhjbkdzTHlaalNrd0o1ckVLaDZycmtvRkhOelMxajhuNmxkQzJSYWM1?=
 =?utf-8?B?TXNHTks3T1p3VVBnamo4cVB4NStwMjdZRzlSWURaUkExdUdmM25PczZ3Y0gy?=
 =?utf-8?B?SGxCVVN1bWxFVUZQVEFlMDI2dzZIa2JWRWFRMjEzSFVVWkJtZmlNTGNHclRN?=
 =?utf-8?B?dEltaW93SjIrZ3o2eFoxOEJPcnJXaW9sbXVoRVd5MjE2bGZyanBQRVNNTEth?=
 =?utf-8?B?aXk0VFJWNkx2K0hUNllTK3VpbjVnblFTSE5oT1VyMFJaOVJFUkM4SHZJSkV3?=
 =?utf-8?B?b1lwcE9scVJybGNDMVRoK2Zrb1NVT2RNU29RRXI2aEoxZk1OaFpoc1l5Q3BH?=
 =?utf-8?B?WmJpNmNSTWp1MXcwUlRObVRZb1RmRWxQelNYT3hKVVhIa3JHVTNoeHdxWXp6?=
 =?utf-8?B?eUxLSmJVTGIxc0p5Ky9IOUlKSjY2dmVYUjA4ZWVQNGliakRWeGw2cTZPMS9m?=
 =?utf-8?B?QVFKUUhNMldyK3ZtazZZbTIzV3U4Z21XYlc0NVVsVDFEUlA4NXhFLzRkQktY?=
 =?utf-8?B?cCtNWmQvNDd1WHB2UE5OSnVITDd3aWtLVTA4bmNqbW1qVmljWTg0U2Z3UFBl?=
 =?utf-8?B?OVAybG4vQ3VkSVpJNjdBUXV3eE9MODluL3h1cmZUNUdKOXFuOGtyQ21zZXBW?=
 =?utf-8?B?MC9iSnVhdE9uSUE5YTNDS1ZaK3RWcU1ldHgvU0ZYaHE0SjRuWWJHWFFDRVcx?=
 =?utf-8?B?V24rek1HWDM5ZTRKR1hhYnI4dGRQVzhrVThKRnJpZDJkZ1BaRkp0azl4K1Uw?=
 =?utf-8?B?VTJueHFZNEgzOGluOWpVY2htWEVnYzYzZ3ViSlBxbmdWTENmRllUUzBEcVRT?=
 =?utf-8?B?UXdqNVhEcWJ0enU1bGxZaGx0NWVmMFJvWnBoM1ZvcTdKY1pqTjBUK0QzZ2pW?=
 =?utf-8?B?citFUDI4L1kxMXhJd2I3aWdFK2RVeHJ4ay9RbjlPSkZjaEtOd0Y1cVBjemxh?=
 =?utf-8?B?c1I3Q3NwMGRLVm9vS2M2RmxvbGw1ZEdmVHdhOHBwNDYwRk8rcm5FbytUeENP?=
 =?utf-8?B?UnA0VVg4clBydllUR05KY3czeHdQSzk4R2JQRzdjZU44eEs2bGgzQnBqSE5U?=
 =?utf-8?B?SzNxNUNLTzg4Mm1xT3g0b1lGd3FuYTB1RDZndEpYRGdiN0pTTFJCOStVZ0JH?=
 =?utf-8?B?Zi9FYVNTU1cwT3ZodzJpakV5UUVtVGNoZWZJeldXMnV5cWJpWkZLOFV6bXlD?=
 =?utf-8?B?eHJvTWJITHRQbWI0UWNlcVRHWW0wK3ByaDVmQUlxbG9naXhFY2NqS09nSW5I?=
 =?utf-8?B?OUkxTUZmN2JNN0xFS3VoRTQ0c0s1WCtaNFU1QmdxVlZQT3pOa2txZnkzUGNN?=
 =?utf-8?B?TCs4VzIyc0Q5OWxXa3A3RFRSOE1uZ2lqaVlaSU1qK09IVkRTSmsrMXhEVU50?=
 =?utf-8?B?ZXQvVE0xMjhIOWZWYTA1Rzl6UEZ1bG9Fd1ZZMXczUnh1RVVCdTNDZlAzSzNR?=
 =?utf-8?B?VHBUV3J4VVhhNGx3bTJvWFVoSWYzTHZYZzZaVkY0dUxKMGE3ZmJFTEo3MjVH?=
 =?utf-8?B?eFRiVzA3NnNTZWpvMndGS01jV3Z1TlZYOHhmSGcwSnBMODlobThkZkdpczVX?=
 =?utf-8?B?WEFtNTZQZHUwUmtWdUp1WmhRYWRGOVZnYkVBZ3JSTktZc0s4enlWcGEzckIz?=
 =?utf-8?B?VVBDdHNJMVoyVi9Ib053RXl1OG5RU3VwL0cxcDRoYlROK2dHRjE1ci9ZY01K?=
 =?utf-8?B?Wnp5bm1kR0ZMelIzZWYySkQ2NFZYeGpaYnIyZlVXZFpWc0kzWk5oaUNZUlMz?=
 =?utf-8?B?UTc5YnF3cE5nSzJHRHF3TDJiUEM1aWRaSDRUVmtnbWo1WHIwbk93Z3h5MXdq?=
 =?utf-8?B?VTJacHpzT0hDbjBVSlZzUmFPeDc2NnUyRUJ1cmJnV1RVcEpoVmI1akl2N1Ns?=
 =?utf-8?B?QU9XeHliS1U0M0h3ZXJBYnNzc1dqc3FvQmVaMkJBMVRZT3pldzZnSDBmWWRs?=
 =?utf-8?B?MEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: QMc7N92PRQX0szdA3GnjOxGg4QpHlhrTu03xwR891Wl6S5n1xwTc9MF1HE+w4acr29/HyIckJJWg8Sa7/ca2vgfB7N8mPbUeArdMDRjOrZrUvsmL3xPgMl7Zi5d2DHtHHGwSQdjh+VC5iDOFDib56/9/ParRENISr7BXOFNereXffr+pWDny6M4kROBcsxkQL9KXa087gIleC3oIfsg7wF66ANZJhQP0ufG19n1rBcM8WwOn0po5bbXoKPQVpLbA4x3gC5rwRdO80aP1wHl6QbWu+eFYiPgHv5fuy83Meq2cNzmZVbSz9KhKDlFxCl1TDYJ0RTjcOAIf7E5j8CUXWk5/uGpLLnBWKZY5PGprjh2uMNG4HUyNDbLwX0Bh1Xx1zUS/VrfaH9Yt3n108aIPUw/BOwSGPwCeqz5SJ8BETwzhsU9b7a7lbkiSG1jPUlJY7JidrjvD29prqvvp349AR/NVfbxNh2FDAsiwAgZPSIQm43vZsyB2C1dC2JHCGg2MV87gToAuzRgx2D0flAA4iF5ftzliyZ0sbnKWAmQ1To14ih8dDjjG73oMlg5oJsxPFoU7rXC8xZGa+wCy2UUE3Qt+BbKfoy/JuS47vspvB6M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1965b59-9ba5-44f8-e681-08ddd459b5e0
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 19:53:12.7706 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LTNKnUXIJaZNdF4/j0lU4AfjuePygoeysew+ehuhqRKNqAKyEaJiM6g39izp2OeoSNqFn06dW5LV/xfD3pfwE8IoqaS7nkwbfZyKHluRDXA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6386
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_04,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 suspectscore=0
 spamscore=0 adultscore=0 phishscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508050140
X-Authority-Analysis: v=2.4 cv=WMp/XmsR c=1 sm=1 tr=0 ts=6892612d b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117
 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=Q8Z_2Nv_ekKI9ZEhf08A:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12065
X-Proofpoint-GUID: PmqNbv9RhwbWCpPC0TcVlVtdad00wdPd
X-Proofpoint-ORIG-GUID: PmqNbv9RhwbWCpPC0TcVlVtdad00wdPd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDE0MCBTYWx0ZWRfXwqoKHZWHyK+j
 59NHwsyS0aQ+PPLac7qFSOx2RfZBmmO2GY/XhB0wDZ+ee6CKw7kxoG0wKlD7/eMjyC4CnaCuRkc
 /Q/sJcGX1KjqBRSOcI4iZrHCBurCSJUVIbTJAe8pLOkrxi4q4ZQ9hK1NVZ7CI12aiOavZprdGr9
 pOBpr9uAy+N/uhXHn55aSjzJ7W2OELLwVu8bZC4GoHziuxFMvIpCxQm4ClG8jQHjErzn89GSP11
 x/2fIvtrcZwnKUOBEzfyfZqcE6a2QrTBSY45KNxgvO0kR8cSE3CAtny4/bJmIu9/bwM79aX3H6p
 zwcQnyctJ16EUIadn4IzNMjWnUijRZ4npem01oEDw0cS/aSm7njX7jVipMQphgz91d84/F3DHly
 QTUhd3azSg0F0Ya4p5WjW0zcxVLNlKgLREelXT7+P0CkLsDOR9PptOuvPuQEKRZcGxOh5xOr
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
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

On 8/5/2025 9:54 AM, Fabiano Rosas wrote:
> Steve Sistare <steven.sistare@oracle.com> writes:
> 
>> Tap and vhost devices can be preserved during cpr-transfer using
>> traditional live migration methods, wherein the management layer
>> creates new interfaces for the target and fiddles with 'ip link'
>> to deactivate the old interface and activate the new.
>>
>> However, CPR can simply send the file descriptors to new QEMU,
>> with no special management actions required.  The user enables
>> this behavior by specifing '-netdev tap,cpr=on'.  The default
>> is cpr=off.
>>
>> Steve Sistare (8):
>>    migration: stop vm earlier for cpr
>>    migration: cpr setup notifier
>>    vhost: reset vhost devices for cpr
>>    cpr: delete all fds
>>    Revert "vhost-backend: remove vhost_kernel_reset_device()"
>>    tap: common return label
>>    tap: cpr support
>>    tap: postload fix for cpr
>>
>>   qapi/net.json             |   5 +-
>>   include/hw/virtio/vhost.h |   1 +
>>   include/migration/cpr.h   |   3 +-
>>   include/net/tap.h         |   1 +
>>   hw/net/virtio-net.c       |  20 +++++++
>>   hw/vfio/device.c          |   2 +-
>>   hw/virtio/vhost-backend.c |   6 ++
>>   hw/virtio/vhost.c         |  32 +++++++++++
>>   migration/cpr.c           |  24 ++++++--
>>   migration/migration.c     |  38 ++++++++-----
>>   net/tap-win32.c           |   5 ++
>>   net/tap.c                 | 141 +++++++++++++++++++++++++++++++++++-----------
>>   12 files changed, 223 insertions(+), 55 deletions(-)
> 
> Hi Steve,
> 
> Patches 1-2 seem to potentially interact with your arm pending
> interrupts fix. Do we want them together?

Good observation, thanks!.  I may need patches 1-2 to completely close
the dropped interrupt race.  I will do more testing to verify that.

- Steve


