Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BF6606A325
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 01:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nebius.com header.i=@nebius.com header.a=rsa-sha256 header.s=selector1 header.b=NJWuMBlv
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUDnw-0000BG-RX; Thu, 19 Nov 2026 20:52:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <antonkuchin@nebius.com>)
 id 1xUDno-00008T-0j
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 20:52:38 -0500
Received: from mail-northeuropeazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c200::5] helo=DUZPR83CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <antonkuchin@nebius.com>)
 id 1xUDnk-0005ZT-19
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 20:52:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ThUZQ36GdwcyAo9bSgYTcJVJ4VsGXNecOWCdNjAtSihilt9FVtiKTVN0Oji8eNL0NyuarO3bRi5ZdnsWleDdNp3LEf78pqmaRVdx7Rssfnt8SIc/r2zzHhngPu4mi+C9ZhjHv2Ud5FaEzBl/b3gGCfKUCDs0TESYQQIXiq7gLiniKmCFHnLzNqCrZY5X36tHVS7tPkX8qLVulBVIcaS9UhFedww4w7kkw0ML2lbsAMxZtzdxdQ6R0Kolfw0nRmtiN3yUYTrmjyZnaNdxAJSF2jtlJhffBXFcKtsJKEIz2fBKq9D+HV1z9bqCTDxhlYw8Wpt5vazWfYOqGEchR3xoTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q1Z+4jPfXdDvX+F0m8b6WrBjBcJvHb4Mi1wWmhuoYKQ=;
 b=CeEy8qMbWOOfSG8WD8D+29hDhNpdoHte+Kh+a+3JQwb76NBeAGPCSQUrBAQzlmf5dZlbK8UEcjRfThvVcmz0l3nu7VGhQWSN+ZgvdC8RXOPdHPMhQMKM4auKTsf+cgt2Yx/CxRrPzQWZG46pW3dXAYCsxarjU+zM53Eo3ptlq4B0liLTr1UUAtXDUcLQPcH0+7LmkcJzf7AmXGyyjd+VxpjBLgJlNZxhQ0CnWGl9SYEERFWiRIVdVO9LkeQ//kq2kaOlwfkfN8faiMMX79mBg0SXk3lhNRjc3slaBlOV6ndWwRXWQ3BMgIYNY14syUQ/P3sx8X+Ocv8rgABLhTjw6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nebius.com; dmarc=pass action=none header.from=nebius.com;
 dkim=pass header.d=nebius.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nebius.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q1Z+4jPfXdDvX+F0m8b6WrBjBcJvHb4Mi1wWmhuoYKQ=;
 b=NJWuMBlvdZGoavfjmi0jSePnI7+NXefzJNCsoxtuM8TKW7hg3W/BrfsS7fHkp5eBdFCRKMNdc4/a+fJWuTr7VPdb0jvsGO4gxrWW4dfYeBfD6H71qPY9PftYyYdM9VNiw2U8wQ+Q6XoSoAskqPwvbtaEN09ivYoZJc79C6Ek9+kY8vRwfWJTvCIc2/+WCNRLiLi/EVs6TpHALV7S76sqT7W6tiZd0tDmT8HpPzibBYP6Y6UaMB6R/ylHGyaIy+fFlXu5n7DniwhHacH+aPGbkC/vNnDnAc9cgWxSJQbP0Nov2mje7LQlsY1H2FG2h9h/To4InXulEv8bXlQiyLmQGw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nebius.com;
Received: from PA3P190MB2470.EURP190.PROD.OUTLOOK.COM (2603:10a6:102:4b7::24)
 by PRAP190MB1762.EURP190.PROD.OUTLOOK.COM (2603:10a6:102:29f::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Fri, 20 Nov
 2026 01:52:25 +0000
Received: from PA3P190MB2470.EURP190.PROD.OUTLOOK.COM
 ([fe80::ab4:8b02:737e:c2e5]) by PA3P190MB2470.EURP190.PROD.OUTLOOK.COM
 ([fe80::ab4:8b02:737e:c2e5%2]) with mapi id 15.21.0639.011; Fri, 20 Nov 2026
 01:52:24 +0000
Message-ID: <9306d5eb-60cf-49ca-b644-52ff97d4b3b5@nebius.com>
Date: Fri, 20 Nov 2026 02:52:23 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] hw/acpi/aml-build: Avoid overflow when advancing the
 free_base cursor
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, NB-CoreTeam@nebius.com
References: <20261107-users-antonkuchin-to-send-fix-crs-replace-with-free-ranges-v1-0-0cede42456c4@nebius.com>
 <20261107-users-antonkuchin-to-send-fix-crs-replace-with-free-ranges-v1-2-0cede42456c4@nebius.com>
 <20261117071926-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Anton Kuchin <antonkuchin@nebius.com>
In-Reply-To: <20261117071926-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6PR10CA0096.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:209:89::32) To PA3P190MB2470.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:102:4b7::24)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3P190MB2470:EE_|PRAP190MB1762:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cf5a1f4-cf46-4fcd-ee4f-08df46a8ec7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|10070799003|376014|261026121527099003|18002099003|22082099003|261022115727099003|4143699003|11063799006|56012099006|261022113327099003|261102123227099003|261022075727099003|10067099003|261021121427099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: sSCHo008t4YxTi4D+c+ErG72KmKdriKAsesvIpv39SUbAPqC3iMDOKLGbhTGo8eTfxju7Jdkr0YO4LgfWooBbg6pWkA5y0kao4zCLVAIkBHBD5nDhL9M6C4PNC4ims3aTr/RqKhnAPVJmrt246rcCvWdtLGnmpjvN/MbJEmRDIPVZnenoCoxzECVgjzJ4Ei9OHD0/mVVoYWoSuK4GpjXUKzXRBr3piro9beRjlV1bWtKvjvwd8NbGFXSzruOcqkZ7qdLJ+h5iL7Vw5Dplxj/u+0QlSGcXBN0YJi/Ok+CA54ylQammmz0hLsqTGs2OErKB4JgOuZNc93SRK3WTh4KcdohDuQCC3F0TSjysIXGrSNVUxpdED5dubMBruY2nOGRmVMofHSx1/LWCSBGC0SODxF7Gr6P2CNjQSsUPfCFkl2evlfIx7t6h1KyHJ8ZrtuyZdXJx82d+o4ZIL9Y17k/7OqkM7H/Wewn2QQp1McskNMkujww++xhZDhIifqwSiLzr1UjMzLgEFvG38P9mN9vNOhVxl1zyszvKzCsvxElw5gcO20UrME/kK1VlzrAb09/mSxT2m/9YLjc0nkZzgCsd2AJyGghKDHZHm13ePF7299VZapsK+D9yRR9ZgPlEf4HFqZhw+vS3JCigx1gTSBuKQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3P190MB2470.EURP190.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(10070799003)(376014)(261026121527099003)(18002099003)(22082099003)(261022115727099003)(4143699003)(11063799006)(56012099006)(261022113327099003)(261102123227099003)(261022075727099003)(10067099003)(261021121427099003)(261009223027099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZkNFR21MZGxiQWg2N0VxRng1VkJaSzRmTWFRZWZJWGMzK25vV1hmaVpMcmFo?=
 =?utf-8?B?alVzRVBBY0VXMXpmNWdZdEJ4clUwUU8rNmorcVdud3pidCtXNTZDOFl0Vyta?=
 =?utf-8?B?K2RwbVhodDhFcWxOWnlpeXA3QmFscGsrMFVYUFB4YStvZ1VMVEJSVjljQTEz?=
 =?utf-8?B?bkUzZGFFemFpeWhUcEdONGdKYzBmN0VEUTlWbWRoYjZZamtNODFtcm9IblJI?=
 =?utf-8?B?SU85UHhQd3IzWVNUQXNEYjZwUFFKNnZlb2F3STVPK2c4eU5yc1BiVVRUNW5x?=
 =?utf-8?B?V3BId29yM1pFTE9XVnJNb05zVjdERC9SWDkvYmJZVUtaYXlybEVlclIyQ0dh?=
 =?utf-8?B?akpreWVZYUhkakJFZm1IUkdaZ0xKaWdJMjhsK1d0VnJ0ZmJ5VmkxanZ5TGFK?=
 =?utf-8?B?Q3BzKzlSaUNhQk1BQTE1L0p6UW1vb3pqYnpNRmRpS1pWZWpOYnJyanhmU3dM?=
 =?utf-8?B?UnBsTE9vTHMrWXVPSThYN25VRFI1dE1ISlhxYnRsaDNGc2c3c1J0WHlZbVFB?=
 =?utf-8?B?blBvYy9wMGZQQUVVU0VuL294ZTJaNkp0RU92dlNDWXpUM3NGbXFGQUtuZzB4?=
 =?utf-8?B?M2llV2kyVFpUeEJYaW9xSUJFSE5yWlptSEhoMFBUOUlXN2pPb3Fpa3lPM01G?=
 =?utf-8?B?dEh1U0wvdWg0UHIzSG5JWVVCZlZXakZLK0tKVjhxZ1YvVklTaTd2b0FRa2hn?=
 =?utf-8?B?ZGxreGpZOWJOZEpCc2pKTW1OVTQ4bHFhRGpyZmRHUDdoNUhtL3IydDZPQ3RJ?=
 =?utf-8?B?b2RQajIzU3pRZWlRbUZja2p4R0xqQW9TU1d6VVh1MU8xd1FCK2ZjbVJ2emxh?=
 =?utf-8?B?bi9FbTQ4NUtyWlhpTFhXM0ZtTFpNRURLMHNGbW53M2NtaHNNWUcvSDFpZDlQ?=
 =?utf-8?B?UGdQRFFaZmpwWUhwb3pwR0ZKZFZSMERjWmptaVJnSGJWTEtqbEJZZytoL0Rs?=
 =?utf-8?B?N1R6ZndBOS9mcyt3QjFoY3M3TWJmTUs1RHdRc3RsN2dwRDBFQWYwZVg3NjNH?=
 =?utf-8?B?NFpGbkRjOUZuVHJJc0FTeG43dHlDOUl4cmdBUk8vSjlRWk1VZXBOY1hjcEZL?=
 =?utf-8?B?eUdwa1FKc3FMZ09qWmNQVUw3Ly9xWktONTQxc0hlWWtYQWp0dkxrcU1QUTBj?=
 =?utf-8?B?cy9ZazRJTzFEa25PUHpaY0doU2g0VnAwRXRSZVdFeS9lQ3ZNclMwdHRha2ta?=
 =?utf-8?B?QWtYMG5ZcjF5eWhFS1M0TlU2MVhCUlBQbi96UWQvUitkb1dBVEtZcENFZVRl?=
 =?utf-8?B?aFkrOVd3K2JkNmIxSXNoM0ZlbDE1WFkvNHZHOGtqUllmNGpkTk5iZ2JSREZC?=
 =?utf-8?B?VGJobS8rOGIxMWg4TnhxMllvYnM1YUxmVmlLSHVkQ2hDMGpnN3dEUEpHTEdx?=
 =?utf-8?B?V25xSE5YRzVyZ0ZRRGlGYTJsYnphaDNPOXNMYUs1Yzg1cDk5clNpYWliUDBY?=
 =?utf-8?B?aHVTUGZReExhcWhYSXVuK0dWVEl3M1YzV29yQ09id2xsTERWTnZoczJlTmh3?=
 =?utf-8?B?dVByU2xjUExGM3U3ZmNkZnhIaTYzNjNoTTdiSTFuMm9TS0NGTEQva0ZqY0s5?=
 =?utf-8?B?NmJqWU1sa0V4bG5QSzN2SkRGalAvTStaT0xTWWpqOHIzbktIdWZIUFN0NEtm?=
 =?utf-8?B?MldPREVMaXJPNCtPb2NpVloyemEySHV4Y3NQLy9nKzk0MHlaNTBkeEhkTVBB?=
 =?utf-8?B?Q25mRnVWL0hla2pxV2Ivdmd6Nkk1RnRRV1FqTlNMQzg5Rnc4RDNTRlhnMjdv?=
 =?utf-8?B?dmFuak1LSFFuQ2hTWWlaZVpaVk1Vd0IrRzhDZlc5WDhYWTUwZHJmb2ZkWTlv?=
 =?utf-8?B?OEhsR3RjVk15YmlvVTNSbWRxYmZiRldkUHo2OC92TXp0b2dINmZtMDZBL2pQ?=
 =?utf-8?B?UGdQMmtaYXd0M1M4UHc0NnFUSG9QcXc5YTNZb0RQSm9yckJqVFp0empLTTl6?=
 =?utf-8?B?cnFWQjVyem03dGJONmxINkx6VW0xZVBsYksvUWEwSEtJanlLTTIzcE9xL0lJ?=
 =?utf-8?B?Vm81cTVRVmlQRFhyenVFRmxsNGs1VWkyNm16YmhrakFxRVVwcTdHa05nTUNM?=
 =?utf-8?B?bzJlSC9KWDdVMWxBOGl6Q0NSZGFZQUo0VnJJaVdNZEI5M0N0eEFWdzBLd0wz?=
 =?utf-8?B?dTRQUEdVcWZoK2xjU2hwMW9pS09nODZOTjlhc01SWU55Vk5zOEplTGhZVUI5?=
 =?utf-8?B?TmgrRVFZQk4rT3czVXZaY0VQc2NRRWRmVkVYek9GRnBwa2N4dkVYa0lBZHpB?=
 =?utf-8?B?NmpDUzFRbDhUaC92am91c2pyWC9jYk5NZEY3dXJVa1BVVk0xVHRpZFJiZ05S?=
 =?utf-8?B?cHpWWFM3UlFBZ0ZPQU1aRXYwRnZBK1JMUDdRM25EK2ZPVnhjSnhVcThlcitM?=
 =?utf-8?Q?q5YX+sQ7TeY8gcovzCztR1UwYk7soqW9MNsUizpkvFYu+?=
X-MS-Exchange-AntiSpam-MessageData-1: nNlhg6/ieRfPQw==
X-OriginatorOrg: nebius.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cf5a1f4-cf46-4fcd-ee4f-08df46a8ec7f
X-MS-Exchange-CrossTenant-AuthSource: PA3P190MB2470.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 01:52:24.8202 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4eb23c52-f3a5-49bc-b555-0b061267a984
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ngVxCfuTrflmDV5ZB/zkZfPwXc+laqZVY1eLFjsBCKXv5A0p6/LDqN1GwCqEXvDgXgtUQ93zGHevjg7JDSQ9gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PRAP190MB1762
Received-SPF: pass client-ip=2a01:111:f403:c200::5;
 envelope-from=antonkuchin@nebius.com;
 helo=DUZPR83CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 17/11/2026 13:20, Michael S. Tsirkin wrote:
> On Sat, Nov 07, 2026 at 12:59:49AM +0100, Anton Kuchin wrote:
>> crs_replace_with_free_ranges() advances its cursor past each used
>> range by adding one to the range's limit. If the limit is
>> UINT64_MAX,
> 
> when is it UINT64_MAX?
> 

I don't know. Never reproduced this specific one. Just noticed that 
theoretically it can be. And if it does it breaks the logic.

>> the cursor wraps to zero, potentially producing free
>> ranges outside the requested window or overlapping used resources.
>>
>> Adjust free_base and stop processing when a used range reaches or
>> exceeds the interval's upper bound to avoid cursor wrapping and
>> final free range insertion.
> 
> was this tested? how?
> 

This particular case with UINT64_MAX limit hasn't not been seen in 
production so I don't have a recipe to reproduce it. I just extracted 
crs_replace_with_free_ranges into a standalone executable after I fixed 
the "reserved range below the window" case and threw at it all the 
inputs I could imagine to test different corner cases.

If you are asking about the series in general these changes has been 
merged into our internal qemu branches few months ago, and now is 
running on all our hosts both arm64 and x86_64.

>>
>> Signed-off-by: Anton Kuchin <antonkuchin@nebius.com>
>> ---
>>   hw/acpi/aml-build.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
>> index 90837b513e69..b71d82b5e8a9 100644
>> --- a/hw/acpi/aml-build.c
>> +++ b/hw/acpi/aml-build.c
>> @@ -154,6 +154,12 @@ void crs_replace_with_free_ranges(GPtrArray *ranges,
>>               crs_range_insert(free_ranges, free_base, used->base - 1);
>>           }
>>   
>> +        /* avoid free_base overflow when used->limit equals UINT64_MAX */
>> +        if (used->limit >= end) {
>> +            free_base = end;
>> +            break;
>> +        }
>> +
>>           free_base = used->limit + 1;
>>       }
>>   
>>
>> -- 
>> 2.43.0
> 


