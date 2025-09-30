Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81239CCA470
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 20:01:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3gWY-0002np-QO; Tue, 30 Sep 2025 16:00:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1v3gWF-0002mQ-Rn
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 16:00:19 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1v3gW6-0006oi-Fk
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 16:00:14 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58UHnl0e016290;
 Tue, 30 Sep 2025 20:00:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=gGp48HoEmvffmYY/I24leM5MJIAUW7cQu11Tg7FWeMc=; b=
 gN3iJFFvlr9w6gAjZZX1QdjCZnamFU/8dbFGRHC7ndLI7xib9DspA/RFC91eRUyy
 MyF5qHlxl7VvgiuP0V5kIm7ZWpaQ0mTNSDNy8NaRqhX89vbvHKcRYm/6P8aSUeqm
 864W+o6RQqvnjQV6htFEeM/EMuELAfYnI+2r9lIaEuhCuTmAuLaaBtFItGEEENUl
 kQ+a5wkhPL+YUOqsNqRukNpEsXQLRZRc+3Zt0Z/KqblAw1RgGyRJaVOQF+Jt9Xcd
 chjlAocsBOpJbuf0EB3Xw8MrFJR7OyklSJhvQFN0lvvRGCRLFNYqW+OGWy6ovin2
 /Rx2a1dum4lzckKArKXcwg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49gkxng7tj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 Sep 2025 20:00:01 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 58UJEP9T036451; Tue, 30 Sep 2025 20:00:01 GMT
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazon11010014.outbound.protection.outlook.com [52.101.85.14])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 49e6c8k0ef-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 Sep 2025 20:00:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CE1eRp6Dfe9JTnSiV1HxOKsU3gVAafAA1o0q6KdlmfyDNRuLWcEF3YSJD7uwrhSsANvpIoUaFtrFcvpmtON1xkAiIaz9XR+E8vai04//+z8WxxJsem8cny3ZyB07JURdZzDtlEEr4I89Q/xPApWfDyjRFI493egur4tK98MKZmgaBP5HxF66mp5U2c5gFMhgZarUjyKsAh4LGNkQJ9MeqBLbxhRldnnsIzr7oLzVyXhQpF4/toX/37A2Gll5evMQ+rcM7gu4a0SmEcF1eIypdYwWZYcm7ZpYRQCsBaQ8dSoYYyCLx34Jg4E7fpWEmUJHkz9r1thZWa9g+JNOpq5utA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gGp48HoEmvffmYY/I24leM5MJIAUW7cQu11Tg7FWeMc=;
 b=KGAJraVnR1ZK/mw6QYZ3AaM6fOnUSh8C1SEf7NIrThjzefnu1D/+15LRxsBVTYevnwL8P+2RJVTwvG6z/q9cU6NEHGqjQrtq5O5U0h3gkjkPao/WuYmsMhb+3JlbudbLvjCKVfT2rSx224WILkhU3zJbkoo6UVNzkO0LASZYS9Qa5uhE3aukM48cmOk8PfVrWfiIItm0LnwQJInMkrGIAlAqXxMvJyiqUU4Hk3G/LaqONvkUnbFtZj7fBA7gXnPQ6twsQI0tm18rW1Nt2PN3bysg8CeKvLmLrCT7YQxdrNM8WDQbXyFgxyHNZ1/Q8aFGmzxB9boqpxTF2lcWZHnsIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gGp48HoEmvffmYY/I24leM5MJIAUW7cQu11Tg7FWeMc=;
 b=fa6SDMo2jflK2w9YuCM9H3ereJ2dasACCQJCV/K2qVwjPf25gcG5Pdgc2jQDTTxYyFP1h1coKtzvkbnRU2YVLkA8dgd/bK7Oih6AOSOaASOllAVSalvgEzoihZKVdh516GYcp3fQp0ZFTiQCusbZ0ZQqdeO4XTTu/ZoGcGco/C0=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by CO6PR10MB5649.namprd10.prod.outlook.com (2603:10b6:303:14c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Tue, 30 Sep
 2025 19:59:58 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%6]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 19:59:58 +0000
Message-ID: <0f4caf91-4ad5-4e1e-91d0-12959f1a89a1@oracle.com>
Date: Tue, 30 Sep 2025 15:59:53 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 09/11] migration-test: migrate_args
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Xu <peterx@redhat.com>
References: <1758291153-349744-1-git-send-email-steven.sistare@oracle.com>
 <1758291153-349744-10-git-send-email-steven.sistare@oracle.com>
 <87a52bvhw0.fsf@suse.de>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <87a52bvhw0.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH7P220CA0059.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:32b::23) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|CO6PR10MB5649:EE_
X-MS-Office365-Filtering-Correlation-Id: b5d5f8cb-2a64-4a2d-5c4d-08de005bee97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OGkydXpWOFlDMzluOEJ6ck1BVlE3WElySGNqamRsRCt6dHVpMFZFemswSitW?=
 =?utf-8?B?WmhVZm1sajF4czhDQmkrNEdid0JQdTlxUEFjandFenhWZWpGK2dWRjNhNUlh?=
 =?utf-8?B?amEzbDZVd2ZCRUxVNUZYWDlXNG9HM1lOQUoxdmxXamlodXpRQTBTazl3eFFG?=
 =?utf-8?B?WGFnTjJZV0ZHWWF3dXpDMEJ2Y2htOGVJbmp6NHhKQkRlNWI0SE0renpkNGhJ?=
 =?utf-8?B?Z0E5YTZONmJHNlNwUVEvNVk0eXNkRGZ5VVJIc3E0QnRId21wbDN3WThER2hH?=
 =?utf-8?B?S2Y2QlNNd3JaNlpuUHNLUEtxMnZ2K1JxdFRvQ2M0WkUwWDQyQm5DTVN1S1hU?=
 =?utf-8?B?d2IzTWVYaWs2c3dVMnZsTUIvUlRCSVN6Q3B3bUgvWjIyK2dxK0Z1ZWpPa3N5?=
 =?utf-8?B?V1ZFb2lpdzVVYmg4dTM5R0F4clJTampRTUhIeUJITkpVRXdxQ1l4RUo0bzAx?=
 =?utf-8?B?VVduNmg0UXhrVlNnTkZRZ2dIU1l1dmhMb2ZSWnhGMExZTHhtREgrdFk4K0o5?=
 =?utf-8?B?Q01vSzQvY2JXd3ZjcURjTVAxTlZoNmt5THBnL0JmYTdnckQ0TDFmNm5NeFhM?=
 =?utf-8?B?R1plbk1oaTRzb1VLbVUxeVFzbEJjVHRJL2lTNHdERUNCNGNSeHF5ckVBc2p2?=
 =?utf-8?B?bFlTM290bCs1YUtQUXB5NjRDUEpmVGR0dmFieUs3RU80UE9DcXorNkVLTXFw?=
 =?utf-8?B?Wmx2WkRvM015UWEwWWsvNndLc0J0cU9yZVVMY2lWcUs0dXpmQjFuU0x2dzhw?=
 =?utf-8?B?d2UrWFlJMWZCSHZ5akJ4a21Kd0JMd2NGbFBuaFpoYWN3L2w0MTR1eS92T1hr?=
 =?utf-8?B?V2dlK1hJZ3Q2MmlEZi9iRVZjTURnenNkWWY1QzErTXVQVHFlTFlXQUZIdWFn?=
 =?utf-8?B?MjBSdGt4YjE0eVpXN1E2cjJXTk0renNzWUNqczRudnMzWUpqT3JldnI4eFFv?=
 =?utf-8?B?TXRtaVVSaHpEVXZnZHpQa1FlWSsxMnBGRjA0VE4rRVduTjAyNXJQUEhoTGdw?=
 =?utf-8?B?cmVqTXhIbE9NdFhUWkY5RmFwTmt1NnpNeUQ4RGdGWmZ5UkVoMnBpVUk0czVa?=
 =?utf-8?B?QklQeGM2ZDAwTnFqM2RqaUVNdVJLKy9DRzgvb0pHWXhpZExRMlAxRVQ2RUl0?=
 =?utf-8?B?TytPZWw1cWs3QnBmSG9uZlFJbXRuNHZBM1NwK2xNTzhaMnRGa2RITDZPRUdL?=
 =?utf-8?B?SHpoN0xrY2RvcGgyOTg4MDlmRzRleFdDTEFHcjRxdFNsRlBPeG02RlRPOTZt?=
 =?utf-8?B?UFI5WnZsSTNPRmRIdTVPWTdVQmRjcEJQWHp2TEIvcTZNMlF5bnRVRUw2VVA3?=
 =?utf-8?B?NlhxUUZrTEdnbTQ0K0N0T0ZyUEZrZDhoTStXclNSeEdWNTFqTER0WGJVZVQz?=
 =?utf-8?B?bVN5Z3k0MjBoU2lzaUtUZ2RUWUIrdlJKeHNCV3dZVkM0aW5lSmxFMFFXQVFF?=
 =?utf-8?B?QURDWjF5TTRhVzJzMnRHL0VlREhZZW1EeHBXUGp0eCttRy9QVG1KdGZDYmVD?=
 =?utf-8?B?SXNCNFVKTjZiMW0yeDdyR3BPZzJhQmZWTS8vOFo1TW04SGkwRWRpaFJzVXdm?=
 =?utf-8?B?OTlXdm05S3NsdE1VMy8zdXdiRmNWcXRvQ05ZbTk0Z0pkQU1FMm9mMXVCN0NE?=
 =?utf-8?B?UGczeHJ4VjJZdk9qY1RwenMvZW5oWFJ1TXFFUDEzemxLRnJiYm5LbWdCK3Np?=
 =?utf-8?B?aUhEMUs3TTlhTW9RTENKa2svR01DYWg1bFNZSDdMck5MSkNBcFFKMEdwK09q?=
 =?utf-8?B?SHpmOHZnM1F0V1BOMWtSNXZPZ2IwM3JFVk5oeHRLZjlvR1lOdXZXc01yUG1s?=
 =?utf-8?B?VmkxRjJWL2FMSkRBbGx5dHlRWXVGWTgzdXRSbWg1YnZJY1FiYXF3bEdwUVNw?=
 =?utf-8?B?cFdoVjVHTElUOFNPcG5OUHNwc09EcmtDZ0U0SGNaODh1WFJ5eUlVa0U3ajhI?=
 =?utf-8?Q?Ip0BFOkCb54cLLjve2cZV2p1szzXi/WU?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3R1QWZweWc5UWZkTlkyYjFlcEgyUWxRcmpscmIydHFTd2tGbzdBenBMQ0pq?=
 =?utf-8?B?dGZXem1UU09KeEN1VDg0Qjd5TEJ1V0lIYjdlQUFTN3dMYk5XSTQ0N1g0Nnc2?=
 =?utf-8?B?d1hvWjd3U3hEQ2laN3JZZktZNm1Pa3VoWnJyYmtISEpEeGFnZ1ZaemVGOXpR?=
 =?utf-8?B?Z0ZHYU1mc0laOUMwcTRwNjU2UWUzSnY3SVUwb0hSQVlPelZHVFdBNFVjUXM0?=
 =?utf-8?B?WHdQYjRWdGJTc2diK056bUNyMEh2WEZoTVlXd2w1RTVJUHdOTlJUb1ZHbHo2?=
 =?utf-8?B?WnQ5OWVFTjk2S2xzdUY1SXBaNm5DaE4wbDdKb09yZk5pNDY0WndUSWpCYTB1?=
 =?utf-8?B?cUx6d2hPOWM0aHdXaStTdmZLeUdsRC9JYmdJVFloU25OaFQzaU1iOXNoWXRQ?=
 =?utf-8?B?aXJZVUJmVU5ZTzlIcXNQak8wTU1CYzF4aFliUWRWWlR2YjJWcitvUHBEOW9W?=
 =?utf-8?B?V3ZHdnIvVjNDWDNEM0xpNUF0UDFVelJHUEV5K0FDMi8wcWxPVTVrbnZNTkF2?=
 =?utf-8?B?S2xYbWZ6VUlWbTFWSTdBLzNTdTV5ajJOY0dwWXl0Y1VQZW9GOVducnpQdXBP?=
 =?utf-8?B?Smt5RSt4cFd2Tlh4TWt6SnY1Mng4eXR4QlljZUprbGtjTE80Z2orNGRRcVVF?=
 =?utf-8?B?dFduTHkrUy9waTZScUttYXBCRmx6Z1JYWVRNaWFkenQyZE5HOFQ3QnMrcFlp?=
 =?utf-8?B?NGU4UFpyTTg2SlRFUHZFOTh2M242emtPYkRqV0xxWkhoOSs4YXpOS2wxRnVo?=
 =?utf-8?B?ZVBZeEpJSjRYbk5QZDdOb3JDYm1IYlpXRGRtUDQvYjNhdG9lS3grUGd4dWJF?=
 =?utf-8?B?cEozWm1tSnBvMHNQK3pQY3BJc2dGQTFRTW9aOVRadTJGQkVwclh0NUxLeURi?=
 =?utf-8?B?cnJYUEFpeXcwRTFSWUZybWpKdEJBbnE5WEttZks2MUUvUFBtaUZSaEJ6Q242?=
 =?utf-8?B?Uk0rVkpteDJabHJHdHVyM1pQaXY1NU9uaUtwbnlLUDcwZGRTbm03czBBRGFH?=
 =?utf-8?B?TS91MnF3TGxYZkZ4M1hXcWhIUkpza3ltZ0JyYlpadVNFY3FIRThGMWJvR252?=
 =?utf-8?B?OXkrVUFYYVNDQnBWanlIS2RPSG04K2toOTAvT0FrdlRTdnpKd1EzKzliQzgx?=
 =?utf-8?B?Rldzc2pCQjBtZnJGWGNiemZYUW9XNEFoS3ZFbjRuVTluL050WTBrYnJ6Z1dR?=
 =?utf-8?B?SHNtWUFpMjlZeXZ5RVlkTjB5Z0hEK0JPbkdCSjJIMEl1bVdFUGhHZ2lXOWF1?=
 =?utf-8?B?WmViZ255SXEvY1RveU1DdWlpenNuRTQxQUNaeHRaeE9QL2Z0WFQ3RFNod2Nx?=
 =?utf-8?B?alRZWEorUTlNQlQ3ckVIVjJPcU1vRmJIVnBPMC9QUGdadzhDRW5idFpiMzFS?=
 =?utf-8?B?dm10aEZCRDJSYUdieEdkTjRZK0JzYnhqa3FpNEdqMHdmR1FDTVhvUEh0S25W?=
 =?utf-8?B?WEgrOHJnSU1zajNXdUhXS1BVNnAwc1M1RFZxN1BZdjd1cVRSYzJObWFvSlR1?=
 =?utf-8?B?c0txei9sU0Mya2xSTndWNlkwdXJycVQ2QXNiTERhYTlBWVJoS0dYWVgwRkZG?=
 =?utf-8?B?aW9ZQ1RNakZVQWxKNVpsMmp6WVBlTFdSTE9rQjlsMmMzN01nb2h5d2wyNUVC?=
 =?utf-8?B?bk1nTk44bEZlRTNoVVRXMGRSMC9CQ2tnU0ZVWGhsN0xocG1ONklPMTcrTUFD?=
 =?utf-8?B?Tk84ZStQQkUxVnVaendESTgzU2FCT2pEWitsSlJnQzJnanY5ZHFHQjJFcE1i?=
 =?utf-8?B?SFdoL2VXeVdjcW8yZWZDR1hqYW1tOWg0b0hzUXdGcExEY3JwNytSS0c1SGlC?=
 =?utf-8?B?K1RIeE1LZDBqNG5TLzBwc040UFRRRDVYSmFrM2NTVE5ad1NySDZHUVBabm1z?=
 =?utf-8?B?SUVoaFZ2WFZKU09EcGxNWk1xMFF5dmE1MDVJenZ3cHNZNFdqNkdwbkZzZGRY?=
 =?utf-8?B?S3RLK0JZeDgwVjAvWmMzdjhacHc5Szh0N2RISEZvdlpDeEtNVGVwVE9vbFdm?=
 =?utf-8?B?OXJDNVBvWUF6QXhaNXdUTDI5TktKYkVLeU5uTThXeGhmTXFncGo3d2p6UnhD?=
 =?utf-8?B?RHg5UlQ5T1dzakFNUXFWSUE3MkFBWGR2VHQxVmJtc2VLejZYSkphclZlMEk5?=
 =?utf-8?B?WkFvRFNBQ1ZNWVl2a0w0LzRkZVN6VVRjSjZYaXJwOE1jY1Z4TCtiVkRVWTRx?=
 =?utf-8?B?VHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 7Y8K6So0cBCDDIrMSPM9lRIXSl6b2BVYxLPuPvkLPkbLhA2utk5r43SenN37A1V8e73Y+pemuK1cARjQc3J0lk0Tum1T6T4iypDTAAhSucY44N8UjCph2WHo2dKJ2exl+pje7gHXFnxByve4VUr641IeIPDgF43wK6zBQGp0rArVTdI03SGFpSrisSQDABtrXLGyNYRfsqf/Z+QqNan69havrQJUILxv95LJfoEwJZIMhTtvyRKMCOtauB6N3RkKINTd2awW6bgdw/TFUB86uBcc5IAzqfU2V+hyTuGn4Q0Iom/yA5yRxyAJAjfVVkzsszThEisoKFEW36ZpeBakwaI6g0LSaRMjUgnv+hfWFWc/RhcCOUf1pkEVqzq98KG+AFKLL1/d96uN9sN5OzGygye/oaL3fK1PyZHlAe+nuavM5NoEslIQPfydIAzNA8X3ZuptSX0QhtGQwdQoHm12mZ0WZfbgOloJ7n3qL3Q+SGQ3yNu9KTYsgFAz/KIxzPQuRVo9cope4vsNGtJ0WCbxdvAgcU160B/I66c6ScXqDGKik9YMdO0H/WJ9eKUFOlLOEBUg9MN5EJEtZqcKULjeneTdpCAPzdeE/B9nqeF7oQE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5d5f8cb-2a64-4a2d-5c4d-08de005bee97
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 19:59:58.0621 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0TeAsrcW/OnWfJGTs6Q1rtJX8OskT/dhpFN/c9WvYvm9ROXo/uNa+DzWLmKpVaLVbmiM7tkmXff2qnUwinpWCGN1uAGeTyiwkJnWBgf6kYI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5649
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_04,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 malwarescore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2509150000 definitions=main-2509300182
X-Proofpoint-GUID: 6X11lcno0DcwIpnjj3pjqcxMD1SAgvAa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTMwMDE2MSBTYWx0ZWRfX0prAVQmRAa6u
 ZNVBqgzfgsmR5llcKl9HDotwePO/SD79hw+c7EeqSUEIfAyuEVAUE2mXPEvntPq8Z0PYaqr3lja
 FkRfnw1gDCjEHG5CgtTC9eDkuw3zxTHc5IB1J+XyFPBpDT9yDm6i/dQ01ZedLivDvYETBiwFzKZ
 8u9b28xHSorfDql2idNCehD8f4yYcOa3JlFEfA+HDdKL1GILh7uUvOeHceqrm7pcsW1orVOykLD
 mkoho+ZUFvVvrkgOgrtVCxwD9tbtbkKR46q8/8HciUu81Un85jwIu/8DCOLL4lRvgr+xrcerCPE
 2mCHJcu4r237B9ngOJNXCktHSOolhSpdCdaHhQm65MRNzdYdsA8BqgmbIhl/Kwui2DPeLtJROgB
 O6vB4iTBk6lkeHXd/TIQlvfn7gS+JA==
X-Authority-Analysis: v=2.4 cv=RLW+3oi+ c=1 sm=1 tr=0 ts=68dc36c2 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=yj11p8XFjIVOT936HqcA:9
 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: 6X11lcno0DcwIpnjj3pjqcxMD1SAgvAa
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

On 9/30/2025 3:51 PM, Fabiano Rosas wrote:
> Steve Sistare <steven.sistare@oracle.com> writes:
> 
>> Define the subroutine migrate_args to return the arguments that are
>> used to exec the source or target qemu process.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>   tests/qtest/migration/framework.h |  2 ++
>>   tests/qtest/migration/framework.c | 64 ++++++++++++++++++++++++---------------
>>   2 files changed, 41 insertions(+), 25 deletions(-)
>>
>> diff --git a/tests/qtest/migration/framework.h b/tests/qtest/migration/framework.h
>> index 7ff3187..51a8a7e 100644
>> --- a/tests/qtest/migration/framework.h
>> +++ b/tests/qtest/migration/framework.h
>> @@ -226,6 +226,8 @@ typedef struct {
>>   void wait_for_serial(const char *side);
>>   void migrate_prepare_for_dirty_mem(QTestState *from);
>>   void migrate_wait_for_dirty_mem(QTestState *from, QTestState *to);
>> +
>> +void migrate_args(char **from, char **to, const char *uri, MigrateStart *args);
>>   int migrate_start(QTestState **from, QTestState **to, const char *uri,
>>                     MigrateStart *args);
>>   void migrate_end(QTestState *from, QTestState *to, bool test_dest);
>> diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
>> index 8f9e359..2dfb1ee 100644
>> --- a/tests/qtest/migration/framework.c
>> +++ b/tests/qtest/migration/framework.c
>> @@ -258,13 +258,12 @@ static char *test_shmem_path(void)
>>       return g_strdup_printf("/dev/shm/qemu-%d", getpid());
>>   }
>>   
>> -int migrate_start(QTestState **from, QTestState **to, const char *uri,
>> -                  MigrateStart *args)
>> +void migrate_args(char **from, char **to, const char *uri, MigrateStart *args)
>>   {
>>       /* options for source and target */
>>       g_autofree gchar *arch_opts = NULL;
>> -    g_autofree gchar *cmd_source = NULL;
>> -    g_autofree gchar *cmd_target = NULL;
>> +    gchar *cmd_source = NULL;
>> +    gchar *cmd_target = NULL;
>>       const gchar *ignore_stderr;
>>       g_autofree char *shmem_opts = NULL;
>>       g_autofree char *shmem_path = NULL;
>> @@ -273,23 +272,10 @@ int migrate_start(QTestState **from, QTestState **to, const char *uri,
>>       const char *memory_size;
>>       const char *machine_alias, *machine_opts = "";
>>       g_autofree char *machine = NULL;
>> -    const char *bootpath;
>> -    g_autoptr(QList) capabilities = migrate_start_get_qmp_capabilities(args);
>> +    const char *bootpath = bootfile_get();
>>       g_autofree char *memory_backend = NULL;
>>       const char *events;
>>   
>> -    if (args->use_shmem) {
>> -        if (!g_file_test("/dev/shm", G_FILE_TEST_IS_DIR)) {
>> -            g_test_skip("/dev/shm is not supported");
>> -            return -1;
>> -        }
>> -    }
>> -
>> -    dst_state = (QTestMigrationState) { };
>> -    src_state = (QTestMigrationState) { };
>> -    bootpath = bootfile_create(arch, tmpfs, args->suspend_me);
>> -    src_state.suspend_me = args->suspend_me;
>> -
>>       if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
>>           memory_size = "150M";
>>   
>> @@ -365,7 +351,7 @@ int migrate_start(QTestState **from, QTestState **to, const char *uri,
>>       if (!qtest_has_machine(machine_alias)) {
>>           g_autofree char *msg = g_strdup_printf("machine %s not supported", machine_alias);
>>           g_test_skip(msg);
>> -        return -1;
>> +        return;
> 
> A common pitfall is that g_test_skip() doesn't actually ends the
> test. The -1 needs to be propagated up, otherwise the test will proceed
> with the unsupported machine.

Thanks.
migrate_args() will return an error code.
I'll send a V2 of this patch, and fix the call to migrate_args in patch
"cpr-exec test".

- Steve

> 
>>       }
>>   
>>       machine = resolve_machine_version(machine_alias, QEMU_ENV_SRC,
>> @@ -386,12 +372,6 @@ int migrate_start(QTestState **from, QTestState **to, const char *uri,
>>                                    shmem_opts ? shmem_opts : "",
>>                                    args->opts_source ? args->opts_source : "",
>>                                    ignore_stderr);
>> -    if (!args->only_target) {
>> -        *from = qtest_init_ext(QEMU_ENV_SRC, cmd_source, capabilities, true);
>> -        qtest_qmp_set_event_callback(*from,
>> -                                     migrate_watch_for_events,
>> -                                     &src_state);
>> -    }
>>   
>>       /*
>>        * If the monitor connection is deferred, enable events on the command line
>> @@ -415,6 +395,39 @@ int migrate_start(QTestState **from, QTestState **to, const char *uri,
>>                                    shmem_opts ? shmem_opts : "",
>>                                    args->opts_target ? args->opts_target : "",
>>                                    ignore_stderr);
>> +
>> +    *from = cmd_source;
>> +    *to = cmd_target;
>> +}
>> +
>> +int migrate_start(QTestState **from, QTestState **to, const char *uri,
>> +                  MigrateStart *args)
>> +{
>> +    g_autofree gchar *cmd_source = NULL;
>> +    g_autofree gchar *cmd_target = NULL;
>> +    g_autoptr(QList) capabilities = migrate_start_get_qmp_capabilities(args);
>> +
>> +    if (args->use_shmem) {
>> +        if (!g_file_test("/dev/shm", G_FILE_TEST_IS_DIR)) {
>> +            g_test_skip("/dev/shm is not supported");
>> +            return -1;
>> +        }
>> +    }
>> +
>> +    dst_state = (QTestMigrationState) { };
>> +    src_state = (QTestMigrationState) { };
>> +    bootfile_create(qtest_get_arch(), tmpfs, args->suspend_me);
>> +    src_state.suspend_me = args->suspend_me;
>> +
>> +    migrate_args(&cmd_source, &cmd_target, uri, args);
>> +
>> +    if (!args->only_target) {
>> +        *from = qtest_init_ext(QEMU_ENV_SRC, cmd_source, capabilities, true);
>> +        qtest_qmp_set_event_callback(*from,
>> +                                     migrate_watch_for_events,
>> +                                     &src_state);
>> +    }
>> +
>>       if (!args->only_source) {
>>           *to = qtest_init_ext(QEMU_ENV_DST, cmd_target, capabilities,
>>                                !args->defer_target_connect);
>> @@ -428,6 +441,7 @@ int migrate_start(QTestState **from, QTestState **to, const char *uri,
>>        * It's valid because QEMU has already opened this file
>>        */
>>       if (args->use_shmem) {
>> +        g_autofree char *shmem_path = test_shmem_path();
>>           unlink(shmem_path);
>>       }


