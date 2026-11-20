Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A70606A320
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 01:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nebius.com header.i=@nebius.com header.a=rsa-sha256 header.s=selector1 header.b=oDhoOKyq
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUDKC-0006ho-Pe; Thu, 19 Nov 2026 20:22:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <antonkuchin@nebius.com>)
 id 1xUDK7-0006hP-52
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 20:21:55 -0500
Received: from mail-westeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c201::1] helo=AM0PR83CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <antonkuchin@nebius.com>)
 id 1xUDK1-0007Ok-6Y
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 20:21:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=moDuCKJcaTOlbZ1cpf8JDqHhPiVZHbXeHfqvBNE99tfcPcy1Zsccf5oGkyQqgnmMB72hBgCRAdVE+AKGUjUGkaVLiRFUlBom1QAtG9KyyHZY7YxgdL1lCwKuDvCw7yAXsza1jfMc8H9H1BNiRzpP00ncxAvyeyx7yA8FI/1asPZ87GqnIZOd9gfziJ77K3tujIWjpksu6wUtKzgdwNhcIDj2r/w0uWUxKPoCTAqyvOso8tMeWyC9PuMzn+oGWHpoVvEJvOkEx3UX3oe1bwAC+myRQb18auQoXtp4iauV0Rps1Gi1fDYoG9RAp6lsCaPElmB7rKceIdRLk9H0iK9ZKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=92eOcai5Jjird9hYkLPXJIdJneLAHyszTohBPHs3BpA=;
 b=FoiDfSlSUVEVNjfzFFpubruHudhuSr5DtBYTOzjVGFLQ9iySVHJ7LsCPGZ01mNgQyhoWWc8gw/DVjpduXNPQm6vHyhcv4VWMfuL9B2hs+WbDi+dl9qv6IOi5AzpFHpL/mhkBs2hvUdAS8n3DtF9OYpjWcXCeAJNcV0fWPBqTJM4TauFAu04xZZrt+i+JjlbU/zGO22zpS4cCLdEfWj4kDEfCzdwfkCkzb2U+3CGwZNJx4p5LpWSnBBDBrrwsiP3SYbqCwY8qJO5efWxoXKgU2PcDsXfkRGgHEezfRySjpPXgQMXO+qPsWJBTL4tAAnrre2TZn4WO+3UTimL3iMu11w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nebius.com; dmarc=pass action=none header.from=nebius.com;
 dkim=pass header.d=nebius.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nebius.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=92eOcai5Jjird9hYkLPXJIdJneLAHyszTohBPHs3BpA=;
 b=oDhoOKyqNGr8yZd+BWfiMR3yRuZ5hZOv0fmb1Qtb5g5PTd6p+ONiEjtMXbDXvBtKaAjxyl5GHbfH7pTgZwdfxYxawtanFZeoeknIHcrYobz9Rn5Ikxz4QXC8IRl8h5PXtVIPRMsPM44c+/HFs8gIG4Lt4Xb5vPWpXcKE1CNLkDaCBt8bq7xNB/x+aqLwEcaXBbTMy8giqVK98+HppowHVWN3jjZDDPPS5zsBzXVGcPcSr9WIpgBYkBwqFWty0nTJryLLITgBmyBrRaWZfr1W8vhKCNGUr3FT/rBHHh8xVLZPAd+Ld02YqkdYM/hzJlisF9ijNrDSmoRyE0MdKWVFMQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nebius.com;
Received: from PA3P190MB2470.EURP190.PROD.OUTLOOK.COM (2603:10a6:102:4b7::24)
 by AM9P190MB1265.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:26c::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 01:21:42 +0000
Received: from PA3P190MB2470.EURP190.PROD.OUTLOOK.COM
 ([fe80::ab4:8b02:737e:c2e5]) by PA3P190MB2470.EURP190.PROD.OUTLOOK.COM
 ([fe80::ab4:8b02:737e:c2e5%2]) with mapi id 15.21.0639.011; Fri, 20 Nov 2026
 01:21:42 +0000
Message-ID: <130b9a84-756c-41c2-af85-9369710f0046@nebius.com>
Date: Fri, 20 Nov 2026 02:21:41 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] hw/acpi/aml-build: Ignore used ranges outside the
 requested window
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, NB-CoreTeam@nebius.com
References: <20261107-users-antonkuchin-to-send-fix-crs-replace-with-free-ranges-v1-0-0cede42456c4@nebius.com>
 <20261107-users-antonkuchin-to-send-fix-crs-replace-with-free-ranges-v1-1-0cede42456c4@nebius.com>
 <20261117071727-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Anton Kuchin <antonkuchin@nebius.com>
In-Reply-To: <20261117071727-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6P192CA0092.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:209:8f::25) To PA3P190MB2470.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:102:4b7::24)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3P190MB2470:EE_|AM9P190MB1265:EE_
X-MS-Office365-Filtering-Correlation-Id: b4b98468-012f-4d37-bcbe-08df46a4a298
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|10070799003|366016|18002099003|22082099003|261009223027099003|11063799006|56012099006|10067099003|4143699003|261102123227099003|261028144727099003|261022105027099003|261026140227099003|261026121527099003|261022075727099003|261021121427099003|261021123027099003|5023799004;
X-Microsoft-Antispam-Message-Info: ZiQeXA1UYVUKTK1+5wla5S2IMzIv827em7JXgQZUwKuLESAel5E1W5ELJzOqlZEckBNqCr/c4jSIBQqKhb/XdSxmA4qKxhA3mt5eJ6BE/VJMMpBFnhuB82y2efeV2FATFsIiaommDkCZR6u+DUGH8DHy5z3c3jfnQowSqIyuhXylEPGPyZtAWMN8Clz9QCXgAeAgsifkHd+5qE5YH3kYC7XWD62hsj5eRkFUt5YgkGLd4ndK4skWEUPQNQlglpicMTrqbhR/SYcrUdAildkLfdNpbxthKXBPQGEY64g5J0yTqnmzqis5Qtc9StPOnrhxMlAo306J5pgv2E680N3UiauF+TTuPEiwc1BaelsvUptL+A07Ab3Jax7HK3+BGcJJkzxJhsGSrC/hbxzNybLRdBBgHhdtwB4yyFNzB1YRTITcYprKZxBLeNv1VTYmcTBP+hKuSrMqRqA+HKXrwAqnaWDfaqS58Zwfepl2CXBFu4/Djh9QY7lKDDdmrRnmcrsNpaIirYi6Zjbwu+CoKIFNJuGJDziADscc5m5F1+5lQYsKVmampDZ4kasKnTNbKyH0wEG3qqty0D6f58x4KXUTzWer8wp/CLu0kwYtWsXdROTSkvLzSYANFpD9p4w4RjMRGH7y3XVrTkbJogrZgeouQfRvwYplnX5Etm14ABxQT2A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3P190MB2470.EURP190.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(10070799003)(366016)(18002099003)(22082099003)(261009223027099003)(11063799006)(56012099006)(10067099003)(4143699003)(261102123227099003)(261028144727099003)(261022105027099003)(261026140227099003)(261026121527099003)(261022075727099003)(261021121427099003)(261021123027099003)(5023799004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cEs2ZmRXakNaTUdOd0pyMmpObFNoK1FBK2diZ3ZsOWx1T3NrRlEvZjB3WWhx?=
 =?utf-8?B?S3JmWjRuYXRBRXRFUERrL2RQOVhhZ0NoeFU0OG9tWGFjSVlpeXhWOWErVXlE?=
 =?utf-8?B?RjllQ1ZJSFUyTHd1a0RMbHR3aDFyRzNqbzdJOS96TWF4a3N4K1F1REF3OFN1?=
 =?utf-8?B?MG5VckF1QnExQ1NLN213MHJYOUxSdndaVGhZOWdTWUpqZisxYytYanJKR0x6?=
 =?utf-8?B?VTZzcS80RUZ4UUdTb3FnMGh1VmFuWXoyd2FDM2NkSXpSUWRlLzFtZFlHK212?=
 =?utf-8?B?cFlKTHozU3cxakJBUm5hVnF0TGRxR081UjJseS9ReUpMOGplNjlib2JUWUVq?=
 =?utf-8?B?ZHpGbnV0TVhVSWFOTzYycjFDa3hOWE1TUWdKc0ZEeUFqR2JwWHVnK0JmTC9G?=
 =?utf-8?B?RFYvVUFmTFhZUHJJd2VZVWQvWk16SUp5VGNGL0hiaXNMUnJOd3kzRGliZjUz?=
 =?utf-8?B?UkJvcytES0VxSktxNjNNMXlkU2FGdlNuN0NiV1JvM3Uyd3lhVHJOck5IU1Va?=
 =?utf-8?B?YzJlSHd1UWRBaTR5REpIUitCVWoyclZzeWFNT3MvU2VHU1ZYSkhrem51clhz?=
 =?utf-8?B?THprUVg0NjZyRlhpQ3FoSXd3MlU4KzhwaXU3M1djVE5za1htbDJmZElsYlFV?=
 =?utf-8?B?Y3pQS003eHZmZUdvMVRsL1cvSjhUTkUveTZkcTRGL1Bsa0Rrb2tFTTdweWJi?=
 =?utf-8?B?UllXTWRsQWpYSEd4cTM1RnJYa2ZTMUJBdmNicjZWVGlqeDNEZEpabG5ZYVNz?=
 =?utf-8?B?SXZ0ZTl4cVlFTitDbnVZdXJlMVhLODJMaEJtaTEwRHBzRWVOdnBKUFEyNFBq?=
 =?utf-8?B?aUlSdE5qelBMQXZyS3cwTTdzRU55MWhlNVZ2M2Q5UEZBd2hpa2NCKzBJcjVl?=
 =?utf-8?B?UExyUTZNQ0lMT2FXS1Y0WHJxR0c4TEYzT1FEU0JUeDR3ZUJzZmJKMHZmWkJy?=
 =?utf-8?B?b20wUmpWSzRiK2xOcUJ6MURqSy9aZHFVRVgwR1dLM0hQdWg5MUx3VGJYUVVQ?=
 =?utf-8?B?M0J0OUJkUzhGZ0VOdm0vRUR4VFpKT2lQZG9WNTJ6ZHlBTWVlNVExYXkyNGZK?=
 =?utf-8?B?anlFREdlMGIrMWpuVklxTXl2Y3AvS0FFVHdha1ZqMUNBZEpHRElDMk1teDhQ?=
 =?utf-8?B?ZnBzV21ORHNrekE5UkQxOUFuZE5KbVRaQlIzYXRTRHBtbEQrbWVOWVc0UnZv?=
 =?utf-8?B?cHNPRitXamE3Q3luOTMwcmlSanVhblZScW0zSHVEWXB3dEhpdlFMMEFUSXJM?=
 =?utf-8?B?NEM0ZmV1ZVh4MmFibHRYWndZamxpVytBYmRZN0Q2dEVXTnhzTlFnWStzSzRz?=
 =?utf-8?B?UUZDTzZuZytIdVhwd3RDWmRkM3V5clR0dEc5anR0YkpkVU9kT2lCYVozc2ZN?=
 =?utf-8?B?RzJ1OW9EVllvNmNzamVZb3dEM25uREdidlZabERWMWZNQnpGUC82L3lvWjV6?=
 =?utf-8?B?L0h4NmVpQkZhbDRrRjM1dzV2dE5QclZUdU9lOHpIcmFLeHZFcHVoQlFjT0tn?=
 =?utf-8?B?SmRBU3N6cEpkYWlESW5mV2pLV09YcVNRVkgzcFVOcWtjTjcrSVNiWUFKeXhk?=
 =?utf-8?B?SXJnSlhHRnpMbVAxblFNWnBHTkw0dTNIS2hqa1JsT0lBQVRvdDBnL0k0YVZw?=
 =?utf-8?B?STZsTDNNeHkrK0VJNmZvVy91Nld1Ukx2dzRIUmw1VFRBWURCQzQ1S0JrR3JC?=
 =?utf-8?B?T29pTjg3NGxYMkg2N2t5YXNEVjgzZEcremQwRDhMRmFCdlQveTFyS0hIUGxw?=
 =?utf-8?B?Nk01VXlhb1ZFTlIwOEJESi96Y3RUS1BWU0ZFSHpDaUZRZGtjRG8rNnhkTmRW?=
 =?utf-8?B?TWlLUWl3VXIrSENhRm10S1RWWXRscmFhSWgyTS9hM3QyT0l0SWp5RGhZTE80?=
 =?utf-8?B?dkJIcEgzKzFYREt6aytmbUNzZmgwUEpWb3NXZEZ5amxuV3FEekNqY0JhUWxO?=
 =?utf-8?B?dWVxOS9UUmhJV2o4alhIMHNyRk9kWk05MmdONHA4d1RKVlNKNTRGbXFKbCtQ?=
 =?utf-8?B?R0MyR3BCaE9WOHpTem1ZVDhnUGhLSE9qUks0V2FDZG8zbFRlMkhzWG01MVhz?=
 =?utf-8?B?cDFBQUxLbU1KMFFIQVZMYmRha3RwU29NcEZadjd3RlgzZFVZWkwzTU9pSFhE?=
 =?utf-8?B?K05RUG1xL0tvZEhQTmpqc1dKTmFVSnppd3R1djRKWldUcm1Bc2NMRlFsTkwx?=
 =?utf-8?B?Y25aMkI5U2tBU0lUSVhZSEpLcHp4VUVFeXdvNUhyUW9oWXdxMnozMHd1VFpP?=
 =?utf-8?B?Tm1qeUl1ZTczV1RLanJCVXRSZEhsVmxDY1F2TG56WUVmSFVlaEVYTTFMK0Z3?=
 =?utf-8?B?cllLc1FsZ3M1Ky9pQyttWFRrL21lSTZoL3YyNGhvUmNxazJTeVVoU3pBb1lH?=
 =?utf-8?Q?3DD0a7EzXZlskJ1mh3vOeXWI9+68WSqJBxP5JkmQJacwu?=
X-MS-Exchange-AntiSpam-MessageData-1: dyToI5BA7gCL6w==
X-OriginatorOrg: nebius.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4b98468-012f-4d37-bcbe-08df46a4a298
X-MS-Exchange-CrossTenant-AuthSource: PA3P190MB2470.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 01:21:42.7798 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4eb23c52-f3a5-49bc-b555-0b061267a984
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dnoqv0jSTnXZhHo5VvktMfJZ1yqgM518xwqokG8dNAxZfpZ0Z287Oa1gZyot1Gy8I0qpK20k1Als6RiEzXeRhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P190MB1265
Received-SPF: pass client-ip=2a01:111:f403:c201::1;
 envelope-from=antonkuchin@nebius.com;
 helo=AM0PR83CU005.outbound.protection.outlook.com
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

On 17/11/2026 13:19, Michael S. Tsirkin wrote:
> [Some people who received this message don't often get email from mst@redhat.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> On Sat, Nov 07, 2026 at 12:59:48AM +0100, Anton Kuchin wrote:
>> build_crs() collects used resources without any information about
>> valid address windows. These resources can therefore lie outside
>> the interval passed to crs_replace_with_free_ranges().
>>
>> crs_replace_with_free_ranges() assumed all used ranges lie within
>> the interval.
> 
> you mean assumes?
> 

I suppose. Not sure now if this is a typo or I wanted to indicate that 
before this patch function "assumed", but after this patch it no longer 
has this assumption and is ready to handle any crazy list of regions 
(that are aligned correctly, I didn't change the alignment assumption).

>> Ranges outside it could therefore produce free ranges
>> extending below or above its bounds.
> 
> could in what sense? does it produce them?
> in what configuratoons?
> 

It definetely does. With limits [0x10000000-0x1fffffff] for range 
[0x00000000-0x00000fff] which is below the window it will return 
[0x00001000-0x1fffffff] instead of [0x10000000-0x1fffffff].

And for region [0x30000000-0x30000fff] which is above the window it will 
return [0x10000000-0x2fffffff] instead of [0x10000000-0x1fffffff].

> 
>> As a result, the guest kernel
>> may assign a device an invalid address range.
> 
> And does it? what guest?
> 

It does. Guest treats resulting free ranges as resources that can be 
allocated for device BARs. So with enough devices some of them get BARs 
in this invalid region.

>>
>> Skip ranges with limit below the interval start or with base above
>> the interval's end.
> 
> and then what happens?
> 

If device's BAR happens to be in invalid portion of region device 
doesn't work.

If we skip such irrelevant regions resulting free ranges fully belong to 
MMIO window and work correctly.

>>
>> Signed-off-by: Anton Kuchin <antonkuchin@nebius.com>
>> ---
>>   hw/acpi/aml-build.c | 12 +++++++++++-
>>   1 file changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
>> index 990abc64cd8b..90837b513e69 100644
>> --- a/hw/acpi/aml-build.c
>> +++ b/hw/acpi/aml-build.c
>> @@ -124,7 +124,7 @@ static gint crs_range_compare(gconstpointer a, gconstpointer b)
>>   }
>>
>>   /*
>> - * crs_replace_with_free_ranges - given the 'used' ranges within [start - end]
>> + * crs_replace_with_free_ranges - given the 'used' ranges and [start - end]
>>    * interval, computes the 'free' ranges from the same interval.
>>    * Example: If the input array is { [a1 - a2],[b1 - b2] }, the function
>>    * will return { [base - a1], [a2 - b1], [b2 - limit] }.
>> @@ -140,6 +140,16 @@ void crs_replace_with_free_ranges(GPtrArray *ranges,
>>       for (i = 0; i < ranges->len; i++) {
>>           CrsRangeEntry *used = g_ptr_array_index(ranges, i);
>>
>> +        /* skip ranges below the window */
>> +        if (used->limit < free_base) {
>> +            continue;
>> +        }
>> +
>> +        /* skip ranges above the window */
>> +        if (used->base > end) {
>> +            break;
>> +        }
>> +
>>           if (free_base < used->base) {
>>               crs_range_insert(free_ranges, free_base, used->base - 1);
>>           }
>>
>> --
>> 2.43.0
> 


