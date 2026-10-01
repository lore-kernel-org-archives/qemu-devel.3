Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD927CA5FCE
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 20:20:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCNFe-00038x-N6; Thu, 01 Oct 2026 16:19:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>) id 1xCNFa-00038Q-19
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 16:19:31 -0400
Received: from mail-northeuropeazon11021102.outbound.protection.outlook.com
 ([52.101.65.102] helo=DU2PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>) id 1xCNFY-0008B6-1g
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 16:19:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QTdCnsVw1ktZZsRgbCEn/F73GkYSfX6MycHnNh1X82cpTV6HtpHrc6TKvvh8OhTk7WTky40Vod1i17q19TXVHWnSp/ooGb63c9FCZPZGwYKUYJIcBoyAQYBvtylmMxrbu7hiZJ7ahbgka3Vfp19HXr4fZaMOURj7/OShGCqXdcMe7Tk9wzV1rkE+D0p05DAhKkqzomjEfN0oicn+eOkgPYgSHoswjqFLPaZEbLpn4knnUL1P+2+Kmtb09bow5d3oRePapv2cU/dACK+UdUgoC4c9Ptg9tJtDxXSHP9sL+OptgNHPRVa5b/A328jSd3jynC2Sm892acRtAFs4f9xHIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y0NdD+WGuwTeiWq6mDxeJIvitsls6ZxSa3nPwr5vEcY=;
 b=IjESxNM6+K9eB4Wb+Lh1UbdH3gnEo67U/BsVdQDA2fYg+8YTKcBE96cv9dCjtAKE8VdnuV7j5gu96qLe7OTIR4ce5KgvMoIJqgTYU6FgPHxXdsJbUKwbXc1S4BSzbsv7F1J5XFs0zLXZ4pbSMwU8BtSxWqM2XNts68vBmnqLSENgiPq1k3Wj1bfuvpDWqaAYmLKL8RZ2M/R/7JE+QgQuAIlLaF+fZrEOp2bA5lWCUmFSuRRgV93EYBtmpS8EDy3nuoZBdqfWydiPdnyJVEfHfs1rl4Jn8jIx7hdfkWpf4qh47N6o1XRKt0JFqw3+SxpN81CU5XTVgYcUloE1tDWaTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y0NdD+WGuwTeiWq6mDxeJIvitsls6ZxSa3nPwr5vEcY=;
 b=QAOk3TFwhU8D4LIIMQSc2jZz+lmaXc0+2Varn0neXe9aYy5ZqOgRM8My0jC7Lwo6OdLUSl2Wq1zQvzPiMW/31+eIpNE045XG2JpoEptjmyxh7Lz2iQmagzA9vPP8MCv0JBvuKDFRrmSLd4tahZyXdV6C1BFHhkjBNIEDsw06nLid5GX571caHau8LNjmlcEjHuml79nugf8MVLjVpirKvE03Fn6gpMy6SRThbCd5a2BrI5osiA3Ct8U3MkQbZyffyBElaIouCJaILn8TwG0RSUXnwXXw7Gl3000/hNqDsIWbUCkgU1NSu0zZZjwZiXg9+aH5kAyGZ/30Knbxi4xFSg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by AS2PR08MB10084.eurprd08.prod.outlook.com (2603:10a6:20b:648::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Thu, 1 Oct
 2026 20:14:21 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%6]) with mapi id 15.21.0472.016; Thu, 1 Oct 2026
 20:14:21 +0000
Message-ID: <52ae1c53-5c97-45eb-b183-7dfea81e8ecb@virtuozzo.com>
Date: Thu, 1 Oct 2026 22:14:20 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] migration: defer a post_load which only rearranges
 memory
To: Peter Xu <peterx@redhat.com>, "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
References: <20260911142345.3999518-1-den@openvz.org>
 <ar64sJucQdmgu7mB@zhexu-thinkpadt14gen5.rmtcaon.csb>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <ar64sJucQdmgu7mB@zhexu-thinkpadt14gen5.rmtcaon.csb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI4PEPF00000153.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::86f) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|AS2PR08MB10084:EE_
X-MS-Office365-Filtering-Correlation-Id: 67df9e76-cd6b-41c9-d3ba-08df1ff8947a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|10070799003|366016|1800799024|376014|10067099003|56012099006|5023799004|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 9TVB8VygijmnhpPVxkUtHpwg24jbdE82G9/Nrs01gAp5pijaFkgsMu88owQT69KowDFChFG6o4kPpS4a6P8au8QeJ7/MO/qOxmmqFQKuAbSpAgO2Spz6Hht8E0O4cmWzQBJOTrQO1ch5R8zOG7biS1z7x9o9aEjN/pkpB1ktRCIv1kF12LYsuSfGOnePyZDLfE/XPHpk+d8PAxousb5rzWGX4eMVpvREQme/GKagqcx20+i3As1bB318EYDSnfgQBXlJlHSsu7NeUltaMH6BVQtj8rRu0lbxkM+FF1aewj6apzk6ccpubJ8aeALXvnlv9FuIAVDCTdPueVkFTtMVsD8cg0bNRxkMx8yXoi4u0SIbv2REGwj4zWDl1t7zF7JaiiW/JyjEKtfqf91u1TmZKE9yTwvttJsetGZYuEGEiji4zDYdbIGiiMwr4AJEsShFlxUPJAVCHQcDOzUvBl0wIKkhg8AwshSg09SITnqVmPb7ZR7egLW139tyWschd2V0lKU/H681VNaIC7xQRGu6MB+gne1B9yZ7PGTIRL5pjQ6BCdSpfPX9WrCLc5XLzYlNpEgNKnQWAjjneOKkAweNtWTkyDK9j6sjGRTAvZytKY4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(10070799003)(366016)(1800799024)(376014)(10067099003)(56012099006)(5023799004)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NjBYOEVEQUlyNzFDekQwZE5mL1RoeWVUcGJpVjdZRWFWV0thRlBnNzdQeWQv?=
 =?utf-8?B?bWJ0VXhxZTJKLzZkQWdHaUJsb2Jid1JqYVg1N2l4U0dBcmZxMGtYRk1ZVGov?=
 =?utf-8?B?a0NhMUxpNmN4Mm1tSVlGY296UE1BUDMrSWxxS1lYdjdVejNtZW9hRmF5azJV?=
 =?utf-8?B?aHFGdXJrcDdTZFczTWFuRU82SHE2bDFHRitqeVo1VzMzR3FLOUxxVzZ0VXBj?=
 =?utf-8?B?M2JvbXJEQU5XYWFLNUsxSVVlNzVobEJ2NzNUajg1NHJBSkFyemFjVWlKSUc1?=
 =?utf-8?B?aHFpQ3dwYWgvV1dFY05aeUJDakxFVHJCMTJReGo5VTFIRXgxaXRQTk5acUlM?=
 =?utf-8?B?TGl4dnBjNVVUQUFIMW5SYU1zWWtOOHA2K0J6d0t0U2dHUkp6MDhHSEpnb3BL?=
 =?utf-8?B?YzlNMmtlTEswYjh6YitmZGd4VWNFYTFvb01qemlTSDhGOFpRZHRUK3pHWDl4?=
 =?utf-8?B?bHhhL0g5UVY2Y0QwZFlsSzRYNkVFSnZlRy9LUlE3QmtmV3ErWkU2a3BLWFFp?=
 =?utf-8?B?Mll6Yys3YUoza0tQZ3FNWVlQZWd4ZncxSEthaVVHMDF1NGxXajZITWZYSzJv?=
 =?utf-8?B?YVlaQi9XSGpBTW1RTXBDRVM5TkREdlJ6WklFN1BtNDJJZ2crc01kR29VQm8w?=
 =?utf-8?B?Y2RjdzY1K2ZSOWVtOHF4Ty9WSmg3M3ppMEpKSUtxTURZWG9kcWx2TTNCSEZZ?=
 =?utf-8?B?dFF1SWRhaVFXOER3WkFwNkRDVVBadzFpZHZpMDJweXU1TXhlR3RrbS9ObzdJ?=
 =?utf-8?B?dnkyTjFIeUVqRzlGVWRIeURnT3ZwVTVEcGdNOFU5d2hLSENqb3ZjZ2FSVVZD?=
 =?utf-8?B?Q0s5N0xiTXJvRkliNWVJMTNUU05zVW1VNlhpMVhGMUxYNEhESXlxV3hTZVV5?=
 =?utf-8?B?WXlsWHFuZk1RUGFmL0toZ2hRR3VZZ0ZpTVAxK0c0SU5wYzlVRGk0c295eGEz?=
 =?utf-8?B?UDI3UWw2QUNRWjZxaWNFNVJyZmZ1QkpURmJ0WUVReWRkb1J5MllYMjBwY0c3?=
 =?utf-8?B?c0Nsem5WWEdmTFFUeFdGa3htTXk5Wks2QlFIOUJ0TGRYaERSUGQ4RldHM0E4?=
 =?utf-8?B?K2JQTTg5cTkxak96Z090Y0ZNUmcrdGtrNnU3WG9tdFZlWUhOUHc1amNrZjlI?=
 =?utf-8?B?YlVqbVJpWkQyTkFhOXo3UXA5ZjhZTzZ5eGxLbzFlM2pCMGc4QWREL1pGZ2FE?=
 =?utf-8?B?TktWYjFSb3JuTm9QeWVDRkhwUkxTT2tRcUpPaFJFOFVQWnJ3U1dOb2R5QW5Q?=
 =?utf-8?B?dG1GZGJyWFhnNzZwRzdMQlJtYUVKaVE1TTdWMjV3WVEyWFJNR0tiN2JZbVRq?=
 =?utf-8?B?OU10SEViZVZHbTJqSHVDeXpLOG5xTndJQTVVMGJIZlFwd0d1ano4NHlWUFJr?=
 =?utf-8?B?K2pENEw3eFlxWDdBdFhkbDB2L1pWN0JzZDh4SDJpa2wybmYyMzdPZjdNY3dZ?=
 =?utf-8?B?OVp4dXpsRGQyK2JkdUhnaEdKVWZIcW5MQUVvWFFmTkNYek5SN1ZIeWZ5MUc0?=
 =?utf-8?B?R2o0T2RsZEZZUTNYZUdrZWN1eWhORWM0K0Y5REtvWHg2NVVGSDVzY09udUNK?=
 =?utf-8?B?cWFYUElNc1NBR0VMZVkxMUVOVzJrVmRCL2F6OGozUVBFTnBMR0d0b01WWEJN?=
 =?utf-8?B?QkM2SmJUajBxeERhY2kvTjltOGRDYXBTaHdqMUl6QjBvS1FsdUxhcytKbHh1?=
 =?utf-8?B?bVVuaks3MVFaQlNTVXg2VFhaU21GWHl0TjZMMjRJRldrdmRJWEU3YkVaSjJP?=
 =?utf-8?B?SEF5TzJicHgvUUtLQ2N4MGM5R3hXQ0FpOUJxUmVvSTE3bVBmc2tURUJCZ3ZE?=
 =?utf-8?B?VktOdzZLY2J5TE5FdWNwc3Q3ckZRR2t3TVp2QXRmL0NpQVJaVzFSenNoYlVz?=
 =?utf-8?B?K1V5Z3hZcmdDeHNiMyt3OHI1eGFmMFJrbXRELzI1RzJEcFEzK0dvemcwNjJa?=
 =?utf-8?B?UXdxanoxNFVQTld4dFBwbGN1Yk5IQy8wc0ZWSEl5SWVtOXJ4THNtc04rT3l3?=
 =?utf-8?B?SmtGN1dzZ3VBTENHaGg1bk9oaXlLdGRuRDd0TDNjOThsQWtPNTdJVzVYWXF1?=
 =?utf-8?B?L1pwN24xZ0JpUzk3Y3hjVFhVNEFTc20xUnIwN2lGQ0dwckc0ZmlNVnMyWlh2?=
 =?utf-8?B?UDBwdTc0Nm5GdkJjUVVWMmNNc1hDMENzNmErTmM4bWE3VlE0UW5hQnJRYUU5?=
 =?utf-8?B?d2hnK1U3ZzNQcDZ6YXdreEsrSXpYSjRHS2lTTXEvenBHQ1BCRUUxMHI1RXlv?=
 =?utf-8?B?TVZoM0dlU1ZKOU9SYVpUMmhDamRtUExOditMaHdyZW8rSFVQeXVNTzlDaFJn?=
 =?utf-8?B?dE15aHVjMFdTd211dWszU3FBenNTdWxvcWJpYWdjOVV3ejRYVDdtL3pRNzB2?=
 =?utf-8?Q?Kw9JYl6bM5PDAJin4dMSlRNdbWvHDFCXKxX51wwy18GH4?=
X-MS-Exchange-AntiSpam-MessageData-1: 2EQQ7nFue3pgsQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67df9e76-cd6b-41c9-d3ba-08df1ff8947a
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 20:14:21.4711 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KC5rjKrwoUIWnxVC6UTJVAAD6EBVsgTPAdduKE9JR4/8KZMaHovIyVof1H1/TluPhHJW40OefYTvKdCs6v2WYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB10084
Received-SPF: pass client-ip=52.101.65.102; envelope-from=den@virtuozzo.com;
 helo=DU2PR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/1/26 21:46, Peter Xu wrote:
> On Fri, Sep 11, 2026 at 04:23:43PM +0200, Denis V. Lunev wrote:
>> Restoring a big Windows guest spends most of its destination-side time in
>> post_load hooks which do nothing but move memory regions around. Each one
>> ends a memory transaction, and a transaction commit re-renders every
>> flatview it touches at a cost which grows with the number of regions in
>> the machine. A hook which runs once per vCPU therefore pays that render
>> once per vCPU, and the machine gets slower to migrate the bigger it is.
>>
>> The Hyper-V SynIC is the case that hurts: restoring the synthetic
>> interrupt controller maps a message page and an event page per vCPU, so a
>> 64-vCPU guest forces 128 remaps, each with its own rebuild, while the rest
>> of the stream is still being read.
> This is partly a known issue, not from Hyper-V, but from virtio mmio
> regions.. please see:
>
> https://wiki.qemu.org/ToDo/LiveMigration#Optimize_memory_updates_for_non-iterative_vmstates
> https://lore.kernel.org/r/20230317081904.24389-1-xuchuangxclwt@bytedance.com
>
> I believe we also thought about do MR update per-device, so batching but
> smaller scale, easier to make sure no illegal access to a stale flatview.
>
> So in general, I agree this approach might be the right way to do, which is
> to shrink the transaction to be smaller than "batch everything".. as what
> Chuang used to do.  I still have some pure questions inline.
>
>> Patch 1 adds post_load_deferrable. A vmsd which sets it has its hook
> Nit, IMHO if so it needs to be called "deferred", as "deferrable" implies
> the defer is optional.
>
>> queued during the load and run once the stream has been consumed, in the
>> order the hooks would have fired, with the whole drain sharing one memory
>> transaction. Patch 2 sets it on the SynIC subsection.
>>
>> It is opt-in rather than automatic, and the three preconditions are
>> spelled out on the field: the hook must not fail, nothing later in the
> Actually, I _think_ maybe it can still fail.. IIUC source QEMU only dies if
> it receives shut from migrate_send_rp_shut(), which is after the deferred
> loads at least with the current change.  Worth check..
>
>> load may depend on what it does, and it must not read guest memory or
>> resolve an address space.
> Yes, but I think this is partial of the whole picture: IIUC if this
> deferred hook may inject some MRs that may be accessed by other VMSD
> loaders, or anything (including hard-coded loading process), I think it's
> an issue too.
>
> So personally I don't like this API very much yet on how it was defined;
> it'll be very hard to be used right unless we fully understand what will
> happen..
>
> I wonder if there's better way to define the API to be clearer.
>
> Since all the known issues about this is about MR updates: virtio MMIO
> regions, hyper-v, pci bar/bridge (mentioned below), I wonder if this can be
> something dedicated to MR updates, and maybe it doesn't need to be
> "deferred", just grouped together properly into one transaction, which can
> happen in the middle too or maybe it doesn't matter much. Then it applies
> some form of limitation to what can be split out from normal VMSD flow. The
> current API relies on allowing to defer anything, which is fine but very
> hard to control, and we may face tricky bugs if users grows but when
> they're not used right..
>
>> A hook which breaks the first is fatal rather
>> than silently reported, because by drain time the source may already have
>> been told the migration succeeded.
>>
>> Deferring is not free in general, which is the other reason it is opt-in.
>> Deferring the APIC post_load, whose cost is a synchronous run_on_cpu per
>> vCPU rather than a memory remap, moves 3 ms out of the section walk and
>> pays about 9 ms of drain for it. Deferral helps a hook which repeats
> I'm just curious: why something will take 9ms if deferred, even if it used
> to take 3ms?  I think I misread something, but I can't tell myself.
>
>> topology work; it makes a hook which does cross-thread work worse.
>>
>> Measurements
>> ------------
>>
>> Destination-side non-iterable load, ie. the sum of vmstate_downtime_load
>> over non-iterable sections, on a guest which has actually programmed its
>> Hyper-V state. Five interleaved rounds per point on an otherwise idle
>> host, twice; medians, with the spread across all ten rounds.
>>
>>   upstream                          377 ms   (363-400)
>>   + pci mapping transactions        247 ms   (242-255)
>>   + this series                      96 ms   (86-97)
> Definitely a great improvement.  I think we need this, just one way or
> another. I may have some other trivial comments later in the patch.  Thanks
> for working on it.

Right now I have series staying at 32 ms with boost to ordinary
QEMU startup, that is why I have said that I'll send follow up.
This patch will be included along as flatview rebuild on startup.

Anyway, right now I need to understand and eat your notes to
send v2. This just intersects with upcoming release of downstream,
but this change is in my priority list and I hope to finish
v2 early next week.

Thank you for you time,
    Den

