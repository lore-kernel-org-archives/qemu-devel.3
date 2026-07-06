Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78166C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 08:06:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgeL4-0006rN-Tw; Mon, 06 Jul 2026 04:06:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wgeL0-0006pE-Qs
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 04:05:58 -0400
Received: from mail-centralusazon11011005.outbound.protection.outlook.com
 ([52.101.62.5] helo=DM5PR21CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wgeKy-0001mL-Dk
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 04:05:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=De1BuORZxT0gkQv7kUqx5NV7bAKW9b0ep3tZzyJXj9+Jr2dkq2n2kWZsfBD+ieyUzXILLIvN/U9uMzPUVDnlurhqJXt4Impc9lcLIdG8ud4g/ryKVVv6KXEPlSMJEmQ+rBh94o10XBNhk4USqjuG28Ke69SR7MlJ4rhnlZOKOqScZlJsmwiiNbvM+aDOgEV/NnFjaV8qZKRfVrhIBHXRDUJMr/nIo35iJsMdrL+i9IauYzoIq2Oq22NJ55NWCDUHjpQMPHams2kouVQe65W7AEkm3iRkEQBzAMfzwkPT6NILfdVL8fLwsSZ50Ls/10zIImSX7saTBtMwfht+79lpTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MPoy6mfNs5atxOii/qX+3/j//pz8PCNgwj6d/7ndG8w=;
 b=FxXL7dqYXYI1dSbhY9tEkF2RJ4s6/EoUI8oHF4EXxpQvCmTAtiiNw/zJgtOmJTq7LkZKASMTK0hIcm1DyR12RE029vkzQOGuM1B1mAqFIlvizc+DsXqyjq18o9uKbwUCGJEjO13oeTpsXgP7jX6GGIVNq0SkmbxY/BP32Yx3+ngn8znXAOZlmitzbgdJvSRvrKHz4hJU8K7VllBHk4VJtXGc10bkWwmea8/2Cv6LrUKNAkqKImjD3BkCw64Z+36foO3vqekk/N8llOCvHjViSBtjrZ+CX/cwFrJLfVO8nRuy2urK5KrVSvQbPx8KsB+E1UgqfeLS/QYrqVCDL4H5nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MPoy6mfNs5atxOii/qX+3/j//pz8PCNgwj6d/7ndG8w=;
 b=XaZJJZ1pI0v0VkyhsEEmwVtD67JVqaBKB47KuHo14jqS7PGxj7TOPb/W1WgMjUkNM6IZgOcUvkglDF5blESLBotImMJTdXrMe6gnNiNp1u4SR3JA2JOHRGtc7ZWb4UIgNyGT9wqbaPmDZIPX7CTfFls+a0cVe56Tjyy98mElXmmMeLlQYpbhsmb7qzuIXd2tJmSJ2nGqTTO8xZgX/6dok3xSbq1o4tG+UulxrbBhMel7OiAL2Wfx2dkj5MGm4AuCp15G50HJ1vglD4/U8En8P1iAgfyri8i6JLkt1e4tAjuhB6C9vZfcR5kbspaof4nvAswYrPFe24im21ZWjggPBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5119.namprd12.prod.outlook.com (2603:10b6:5:392::10)
 by MW6PR12MB8834.namprd12.prod.outlook.com (2603:10b6:303:23c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Mon, 6 Jul 2026
 08:00:48 +0000
Received: from DM4PR12MB5119.namprd12.prod.outlook.com
 ([fe80::261:eff5:d149:2d56]) by DM4PR12MB5119.namprd12.prod.outlook.com
 ([fe80::261:eff5:d149:2d56%6]) with mapi id 15.21.0181.012; Mon, 6 Jul 2026
 08:00:47 +0000
Message-ID: <da6a564e-8fa8-41fe-b818-99582e246f1f@nvidia.com>
Date: Mon, 6 Jul 2026 11:00:40 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 08/23] migration: Run final save_query_pending at switchover
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@gmail.com>
Cc: Peter Xu <peterx@redhat.com>, "Jason J. Herne" <jjhern@linux.ibm.com>,
 Lukas Straub <lukasstraub2@web.de>, Fabiano Rosas <farosas@suse.de>
References: <20260630043107.1511076-1-clg@redhat.com>
 <20260630043107.1511076-9-clg@redhat.com>
 <a82ece02-d9fd-4ea4-b934-a9bc5abde663@nvidia.com>
 <df58c2d0-cc0c-43c2-9dd3-ea0614de7d72@redhat.com>
 <e7bd3ab2-2eca-44d6-8a18-29cdbcb57768@nvidia.com>
 <9ea28269-924d-4996-a886-73f14cd31bee@redhat.com>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <9ea28269-924d-4996-a886-73f14cd31bee@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0162.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::12) To DM4PR12MB5119.namprd12.prod.outlook.com
 (2603:10b6:5:392::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5119:EE_|MW6PR12MB8834:EE_
X-MS-Office365-Filtering-Correlation-Id: 280f224d-8081-42fd-660d-08dedb34b01d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|4143699003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: xbsZ6QGSOzYQVqiipXvII166WkKoAXATf/lip2NYW8OVhKWAP7FVzwgTSKAnHL3DyHfPdlhrP+AaQdlgTG9SJkoTA2Wp8WrZ8k+GfRlM48agnkkgXSB2g/vTnWynw0Mq/8KAVvM1eWT6fB/F8I1oiNnmkQa3ju8e/oDmAKNDDrIQRJs1kvJtMhJ4LnLlJWe7SeMZJlVR6lV9+CH1Re+GGTwYtvVKWvbEYOkrLDfyfc7us+0BKegH4mGGn/6K4iQ4vPhJAUZFnnJvWQuO8c+uE/0DMz0novEBEHcWhGqBKQgKf2xMKkWErDrBNwIzk8Z4kj2vQhoZpCcLnM46zVi7AYbKaMgoohaolEcjLgvNe1F4BLquwtqF8IXzDbcL59qRXpQHi9TORrxyzBm11ME0YUenvsMZDSelGmZXiVLNFWqpn4NNvLaZCjNj9f17HmeO5TO2PCCJTywLZrKEkKZfLBHeeAPbw2R1WuLA8z6tmyRvgFete1ifVAx1eAkhThJwuBcXBLoiMTza59NfhhZjee0iOCzuRzvyuKISeEObl4cvA4TQ1wTZca3HjA9HaIEVP9NG01fz+LuRJSpOv+f87t+zQNNz9yxsAjH2aU+hrw/tMHRnus7UJOCmwR76faToYmIAEzVXmjzpKi9EwuXlJcX5b1GzTIcx78kuQIq7pys=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5119.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGQ4VGxGcElmMnA2M2dsenlhY3ZqTkZHTkxkbnFoZjNDN2VYWXFzMmZGSnJs?=
 =?utf-8?B?R1Btdk8vUmdJQzcxMU9Ud21Qc2Zzb1JuV09yZjQ4Q0hwVmRqQ2hOTHJxQzdR?=
 =?utf-8?B?dTllZjBhZWY4K3dDUSs5SmdTSlNtMkxwdVQ0aldCZVlXeVFUcG5qWXk4VXBr?=
 =?utf-8?B?bUU2Q3hSY0REWjZwaVE0UlduNEQ0V3pCdUdaMHNrNmtYRlljd29RZVJJcExz?=
 =?utf-8?B?aDRNdjBidDVCdDBtb0RoelduMG5SM1l0cnZZWG1xblZ3OVdhaDkyRzQvSUJL?=
 =?utf-8?B?MmQzYXdhd1VkR0UyUEtxcU9mUElFSWpFazR4akdkR1hrcElWZjBuSzk1VlU5?=
 =?utf-8?B?OE9qRWRyN25JQkV3L2pyNkMrZGgxdVdKOHUyclNkVWJsYXcvQTBMbG1HN29D?=
 =?utf-8?B?amNQR0pSOEZMTlJnTllxY25PZzZ6cmZNU3hQOXFadkduUjFYK2tjQTRxNkF1?=
 =?utf-8?B?b0NwK0k5TEFQQ05MMEZ5UWRFS2pSK2hsQkFvbG00amh4S3d1eGRENlZ4WDFZ?=
 =?utf-8?B?bTQ3N0RpMTVYK0E5ZjYrbWZzMkxRMERBY1Y3NXZ0VjN0WFZvbVo0bTIybURH?=
 =?utf-8?B?M0xzVTU5bjV2azJIUHA1bTU1U24wOFRPd252ZEtwVjloNFhOWndjL205b2Js?=
 =?utf-8?B?QWZTZWt0eHdZSmxKTUJNRmtiTVhkYXJHUkxNU3owSlE3aUY4SzM4dTZkaHZG?=
 =?utf-8?B?OVdiWWRFN3BlWWxiYmlSak1jeWVWUkR2bVl0THNFcFRScm9Ddlk5YWFpYVEr?=
 =?utf-8?B?aGt2RGRVbzdsalRQYW56L050ditXMFB2alh1UVlFTHZxb0lUekJyV0FlNjZv?=
 =?utf-8?B?UXUyYWxhZE9pSUFjK0ZxK3dsZ01RSXl5TzlJME52bUhYRDdmNkU0RCtIUUpY?=
 =?utf-8?B?MjBpdUU2VWl1NS9vY01JWDltTjBnUjVEc04yaXNKdFNLYlBzU2NrZXJiMno1?=
 =?utf-8?B?QVRLQ01aVEp3T201Rkl4dXFEU2IwcWtUV2Eya3h4dTBzb3E2d1Zwc0MzbW5z?=
 =?utf-8?B?Y3NmdW1rdFVGdUNWR2FaZlkyK1paUGV4ckFKek5ydGxOSWFIQXdTTHVzdlRp?=
 =?utf-8?B?Nmg1Mlc4aTVRaGVkT0NMZ082YXZYQzM1aU5RS2p5OTNFeUJTajRtQUJ1bkR4?=
 =?utf-8?B?MGl1cDkyZG82dkE0RTUxK1dHNzdZQms4Z2lBd2RTRnh2ckM4UmlMTlpZOFly?=
 =?utf-8?B?VzRiV0xGSEJZU3VraEhHMlVwUnV6UzBJQVk5aFhRbGJjSjZUL2pLOGJJSFoz?=
 =?utf-8?B?WXZPMWNuekxXaEVRb2lqNUpXRE9iWlY3SkNpTmNmdjc1WXNzcm9VL05XMUJ6?=
 =?utf-8?B?RE1pWlVtTWdsMDZUZ0pGVzBJNWVHek5tUlBySVRNN01MOXQ0ZGd1M1JTRTVv?=
 =?utf-8?B?djM3NzI0WURMQVFuTFB6eUhsR2JlbnY5dEZNQ1hZRlNLV1VWTFVvZkdpeXZs?=
 =?utf-8?B?MGkyL3U3dWJWcW9Td3hOdmVRazJkbkRYSDVDcXZoTHg2Z3FVU2VJc2I2YnpS?=
 =?utf-8?B?VWw0VHc5Y0EyZjhVTDdhUTFpS1E5MUJLMDVXZWZZWjFkbFZwVWRuNWV5aU5r?=
 =?utf-8?B?dlZPdDVNZW10ZDdLaHJlS0ZIWm9DV1QyQzlUeUsvYnpjNkJLV3FyM1g2WW5z?=
 =?utf-8?B?VVdKTmdUa3AydVZsVzlPb3cxcWxGMTBQczhEeURNeFZnNVFBUTlhdWk5ZGgx?=
 =?utf-8?B?dDhtMkJHOVNtNEtPY2hnNU5QLzZGVWx6TEhTQlVzSUdZR3ZIODg3QjZOYWdO?=
 =?utf-8?B?V3BMbGVLVDR2RzczaEtKMElsMmc3OC9QZWpvOTFLN3R2YVprdW5XT1lZckFS?=
 =?utf-8?B?YTZzMmg3WGhGa2xSZlNGSmFBbnFHbktUbDBRUUVCMUhqR2NhNlVEcHIzV2xC?=
 =?utf-8?B?OHZGcTVhV29qMWNsUWhJaFVwZGh3M2F1ZlpsNDVmQTBnNUdGTDNIZ3F2TjI5?=
 =?utf-8?B?TXQ2bTRZckphM2FHcjlzcndlUmhITEh4bGMvUkNIMEtrU2xEaUdpMFljdlBX?=
 =?utf-8?B?ZldBS3VqUTNvNHQ2RjZvaEl0Tmw0WWcxUitKZXYzZFBYSWdKMG9wTkRCRXJV?=
 =?utf-8?B?SE1YT1ZTMTNIWUdCOS8xam84MEg2MjJMdklIMjI0WUhMVXFyR2FqRGt4QjIr?=
 =?utf-8?B?TmYzbXhPejZ2YkFLbFlBNDR1MGw4MGNCdHdQczU5VkNRSFk5bTdyTDY1R1Zz?=
 =?utf-8?B?OTU3SUROb2RVbUdWUFpGMjdMaWVpZHd6RjliMnhiYmFUM0RtNnpyRDNoL1V2?=
 =?utf-8?B?ZjgyQkZCUHpjalpmOWc4NzhLN3oxTlJ5TXNOL0xOWEN5RXhWMUM3RTdpUmRG?=
 =?utf-8?B?a2hxRFRxSldGVTkxZVJ4ME4vOEE3RFNZS2JxcTZtYlYzK0xweUd6dz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 280f224d-8081-42fd-660d-08dedb34b01d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5119.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 08:00:47.5339 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aY0TlvzWx4j8XHzvJ2N6tV9fBErA0OEqBy+vbaYz4TAg2IdBhdXOxi3lbOG8EVLVXW219lZl21bREs9zcEUiqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8834
Received-SPF: permerror client-ip=52.101.62.5; envelope-from=avihaih@nvidia.com;
 helo=DM5PR21CU001.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


On 7/3/2026 5:01 PM, Cédric Le Goater wrote:
> External email: Use caution opening links or attachments
>
>
>>> The culprit appears to be patch 3:
>>>
>>>   migration: Run final save_query_pending at switchover
>>>
>>> I can reproduce the issue consistently with:
>>>
>>> while [ 1 ]; do
>>>     QTEST_QEMU_BINARY=./build/qemu-system-s390x \
>>>         ./build/tests/qtest/migration-test \
>>>         --full -p 
>>> /s390x/migration/colo/plain/secondary_failover_checkpoint || break
>>> done
>>>
>>> The patch you proposed seems to fix the issue.
>>>
>>> Could you send it as a follow-up patch?
>>
>> To make sure I get it straight, you suggest to merge your pull request
>
> The merge request won't be merged as is. It's broken and I will
> have to resend with a fix or without this series.
>
>> and then send a separate fix patch for that with a proper Fixes tag, 
>> right?
>
> We either handle the breakage with an extra patch like you proposed,
> which has to be sent and reviewed, or :
>
>>> if Peter, Fabiano, Lukas
>>> would prefer it to be integrated in the appropriate place, it
>>> could be included in v5.
> We can address this in a v5 respin of the series by fixing it
> where it belongs: in patch 3. I think that's the right place,
> since bisect breaks at that point.
>
> Let's see what Peter and Fabiano think.

Hi Cedric,

I got the v5 ready to submit (it has the COLO fix + two new patches on 
top: one to refactor migration_completion_precopy to return bool and 
another to fix switchover typos).

Would you like me to send it?

Thanks.


