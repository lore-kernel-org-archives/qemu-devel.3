Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F61D606A611
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 01:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nebius.com header.i=@nebius.com header.a=rsa-sha256 header.s=selector1 header.b=Ze2eEXvM
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUD7G-00050k-GU; Thu, 19 Nov 2026 20:08:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <antonkuchin@nebius.com>)
 id 1xUD7B-00050R-Te
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 20:08:34 -0500
Received: from mail-northeuropeazon11021115.outbound.protection.outlook.com
 ([52.101.65.115] helo=DU2PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <antonkuchin@nebius.com>)
 id 1xUD79-0007Lb-HR
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 20:08:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CieACk7BukthASvu0iCczT+TUrw41GBTOXjh+Ni/PCq1QKhQ8MlNZy+RKX7Ky7YrYWhNsVk/8WImF7WNKeS0IFY30ojhR4I5VU9VIVmHo24jViQyD4oA1jPkzzkubJo8KcPFcI0NFqUSt3Jwk4eQiUFPiHGnk2FJw0zW62L2ccvueLKyghdkJXYuaYNQQu5JL9msd/yCmhBzh2boKMxbch5f6B1asYh+UBubm7SqwkVQ8wvQZbwZ9QNC/BxzdJIZ+cpxQh4/nolQT4J47wlOE3YCw3tMIMZq5nMO1rjMdQDqUBpZZrCjFWJ/Fkte6v3T4Ve3tR5om1+Z/jLElVwWtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G7G245m077bDzZSmpoKzIm2qMm4xuf9Dn2m9F6g2R6k=;
 b=Fq1kGcWJFGkSPY3QVQza4ojRp0jZceFvrFD34pzZXFaPI2dLN5QpfxQNl+7Pal7/kHLSb1gKZmE2Sge188aY+385NcabOU+AjmMNvV/MS7PMRuAOtGimsVDG9JSAcFh3YWBKT/fZIDKWHh9MZNkqDgS60oK2ZgCrWLJQ/ce01i9vGqIO1Fe4fgusgeSs+gfatsi2CgHORuFSWLonN1Y9TOvTVsXZbCg4iOBqfRH6N+5Jx2QGCPXIhIXBRxMqDjO8wr3oTSj1udGsauY4YfKOaMgCdYDm5PmLb5nyuXVhIZ2P68EuMcKRcQwzUDau6KyK/wfJGJsfiWBDME80xs81JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nebius.com; dmarc=pass action=none header.from=nebius.com;
 dkim=pass header.d=nebius.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nebius.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G7G245m077bDzZSmpoKzIm2qMm4xuf9Dn2m9F6g2R6k=;
 b=Ze2eEXvMqoP5/EfziW3tnZVkF2IkEpVP5XprZRQrs91v2okfOLzEfGwNDNj1Yhh37DT7LDXwa3xeDvroGId3MNC9bDni5IhCgKcq1byEP3NOs2mLnwa5tt42O0YVCKYdWea/+32/GdkCqKHdNzKF/fq8zOmpTxHlDUtPn6lry9gaXxlOhZgIDVIP7b/s8wdZB0Asc9CXfcVT+CnZDa4hNE2aGskIqJnGIdZ5DcO4rsayHVZXb+9tDvjmyS/UHS226XQcCxZGAYj5Jf7wxrMO1oGASePeoepxY0Ihq5hx6zlWy4wQ1J73ZzBWAzWxDvaj/RX1jHBZWF4tzRq3+Lr0Sg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nebius.com;
Received: from PA3P190MB2470.EURP190.PROD.OUTLOOK.COM (2603:10a6:102:4b7::24)
 by VE1P190MB0990.EURP190.PROD.OUTLOOK.COM (2603:10a6:800:1a1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 01:03:26 +0000
Received: from PA3P190MB2470.EURP190.PROD.OUTLOOK.COM
 ([fe80::ab4:8b02:737e:c2e5]) by PA3P190MB2470.EURP190.PROD.OUTLOOK.COM
 ([fe80::ab4:8b02:737e:c2e5%2]) with mapi id 15.21.0639.011; Fri, 20 Nov 2026
 01:03:20 +0000
Message-ID: <509149d1-e33e-459e-aa53-03a352a48af5@nebius.com>
Date: Fri, 20 Nov 2026 02:03:18 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] hw/acpi/aml-build: Fix free ranges calculation in
 crs_replace_with_free_ranges()
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, NB-CoreTeam@nebius.com
References: <20261107-users-antonkuchin-to-send-fix-crs-replace-with-free-ranges-v1-0-0cede42456c4@nebius.com>
 <20261117072016-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Anton Kuchin <antonkuchin@nebius.com>
In-Reply-To: <20261117072016-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6PR04CA0048.eurprd04.prod.outlook.com
 (2603:10a6:20b:f0::16) To PA3P190MB2470.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:102:4b7::24)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3P190MB2470:EE_|VE1P190MB0990:EE_
X-MS-Office365-Filtering-Correlation-Id: 32f2dab1-dd80-414e-95f2-08df46a2119f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|10070799003|366016|18002099003|22082099003|6133799003|261009223027099003|5023799004|11063799006|56012099006|10067099003|4143699003|261102123227099003|261028144727099003|261022105027099003|261026140227099003|261022075727099003|261026121527099003|261021121427099003|261021135927099003|261021123027099003;
X-Microsoft-Antispam-Message-Info: FVEpAJadVBqPLPozXAOz9CS7diiJ1mxtEgynIuOSkEvj2A82q2MQbL9k4wfyPXNugZQgYNolIJesUaLrcRrGnK/Xes5uJmx8AlNedNEanNa0PTX20qgwam+lE/8PsCY2cM8HsOWT+5OXTfssixkM2N0Cmzz8BeEdic9jj0zbyO0sTQ3TBazkX+xWkp27q7MpIIAS88imd6OLYd4zwtfRcYnNrUtE6RTyXZrrbiGQAQI9afCp0298wYIkXgoaO6f4Tiuu52FNUYcmOFmMENdVip2fi25Aj7SyI4SJW53GAnjYO/kpL2JTA+d6A2TaIb66EiRakG+1uokYmwhVGVGV0vounfsGS1VBHd1NvGXv6kqf11+DSU90eIhwEJt9bgQfzgHcBE6i824S0+hGWlhMsgsFPh1urthvWOXO1xKN3t6mZyvlNYnQoPxIZqc6ub5Qi0KvGizP8rWgGgTklFkeswOExi9e1J6F9iqT9t6+l/goPZ+Upj0RfahKcKIv8aX47+BpNSjt6JSdBm6TuhAWdZD+yPs6FhgD93Pn94XP9IXIGv0qdXp5MtCCOOOs0i9ESaSBxcqXkWuScvz0Z/C7vAelqP3MkKwUk9yPXvKwSL5BoJ0Iiv672pxh7qiaHSdOmigIg8hsxXgBLIZJHRFI0cnVOWbBB+4nob2+1nJCV5E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3P190MB2470.EURP190.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(10070799003)(366016)(18002099003)(22082099003)(6133799003)(261009223027099003)(5023799004)(11063799006)(56012099006)(10067099003)(4143699003)(261102123227099003)(261028144727099003)(261022105027099003)(261026140227099003)(261022075727099003)(261026121527099003)(261021121427099003)(261021135927099003)(261021123027099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WmJRTkN1WmtKNjRoN0Z5S1hWMGZsZXhFaE9kZWt1ZGM5TnZYZmtDLzA3S2pC?=
 =?utf-8?B?a25MSko4OHFWMFd3ditpeUx1K0REUTFSdW1ZK3JUUklrR0txRmpNRGdpRzRp?=
 =?utf-8?B?M2F2b2Jpd253Ym8rdUNQMXJFQ3FnUUxXa0pLQkwxcHBFcTlVQ3lyRmRwcEwz?=
 =?utf-8?B?U0JHZEF6YU9aSGtDczhLM2lwdmJWRG13L01nM2pvd2NLVEE2YlNXVzlYckt0?=
 =?utf-8?B?c21DdXpGcWVBaEh0Qk1DOWNmeXdTcUdnZkkraGNoRCtUNStCS3UwbHFvTk9M?=
 =?utf-8?B?Um9nQ0RyQlBJamFpdnNMeDFuandMYTUwNklsVEpmMkhLZW5HTG9xVGJqM0Zs?=
 =?utf-8?B?Vk9rQmJQOGhsa25JQUN1Zm0vYjZLdHdoRy9YbDRzS2JNSmdSMkFONmd6L3BL?=
 =?utf-8?B?THM1djNXT3RMWnh4OE5zOGIxbzJoT2laNXhVL01ZZ3haRUdSTmdwR1M2UTlY?=
 =?utf-8?B?eTV5eFhDUDVmbkxlbDdzS3BNRWVrYUd6VlNTQzRGN25haUw5dG9HRldqZTla?=
 =?utf-8?B?UUFiSk43UmpaZlZUNG5IVEZtSEJQTXpva1hvZDlGQXRKZU9rTkY0TVhoL3FB?=
 =?utf-8?B?TW01ZHBDNFppRHR2ZHVaWEUxdjFmdlVyQjFWRXVNQ08reGI0aXZ6Vy9zYnpQ?=
 =?utf-8?B?ZUJJaEY0enFIS0g5dkdxTzEwcitJV29jeXdBZGlIRGlSSkY5ck1WcHZva1I4?=
 =?utf-8?B?eHgyWDE5VjgrcktrcHRiY0VEUlFZYmVzbDAwSFpZYUY4QUgvWjEwbXJyc3lq?=
 =?utf-8?B?TFpjUDQxN0t1UnNZM3VmWkRKWlhXTWFzdHNmM0ZxUW1JQ3ducy96K05FYjJO?=
 =?utf-8?B?eDhucnovVTk1QWZ0dyszMHJMUmM5bzNmcWdTWDkxUzRxVzJNOWtwUDZkbXZ4?=
 =?utf-8?B?amVob2MzK3JoYkdkZ2o4eUJDVGVMWlRmbUdWYm9RelJIVjYzTnpMM0N2OWxV?=
 =?utf-8?B?UGZHNFAwbkl0WXJTYkRyM2wxYVo5cktnWXJFOVBNOWx0WFd5ZjV2UEoyN1B1?=
 =?utf-8?B?RkR1eWVSc2p3Z1ljTUN1eUE2M2VzcUFuVzF0c1R5TjFSRFl0M0N6T0labHEy?=
 =?utf-8?B?SXo4YStmUFlCTXJyRGFxNWdjWmJsWTlMZTdyMUFJbDNKTTlOLzF0V2NZOVlm?=
 =?utf-8?B?NlBzUysyemVJUkY1eU81d3lkc2VpRnNCbDdEZFNPYldFK1hiWE92RVByTmhV?=
 =?utf-8?B?ckZYVEY2S1FXQ2l5ZDh3ckF3NWxVTEFOMlBMbko5dE5LTUE3L1lCRlN4bzlM?=
 =?utf-8?B?WXRhK2lMWHdLN2RHR0JFSWZPTE1hOVZyTEVTSXdSOTBnQmVvMWExOUk2RnhO?=
 =?utf-8?B?Sy8xSWhDNUtFNkU3ckNLL2xxeC9iUmgrZHJmV0xnWWZyMFkrMFh4L0F3YXB4?=
 =?utf-8?B?MEdGaUEvdFJMSk5pY2czWEdxQjFZb3pkY2tZemZ6N0FZeElHWFBPMGJsdTUx?=
 =?utf-8?B?NDV5WVpNblJhMFR5WFUvNkZHZWFjMEVGd2N0Umh6b2NneS8vUmt2NVZJSm1I?=
 =?utf-8?B?ckVaTkt2UzY4SFRhT2o5TlRxLzJ5d3NOSTdScVVMTzV0aHZSbXFBMHRvNWhR?=
 =?utf-8?B?MUd3WnlnaTIvVWxtWGJXQzFiYnJJM0p4eWtBVVFyeVg4WFJJa3NpSlJFWUVn?=
 =?utf-8?B?NEhETlBiekZVSFFSUU1Qd1lxUFh0Tkt3S1dxOHNXTjZycTBJb2I1UmJ2N2ZR?=
 =?utf-8?B?SjkwUFpyRzdPY09iaTFjVEo2elQvc1hOdUkyTW5IMjlvaTlQdS9MeHdCSE01?=
 =?utf-8?B?LytZYlZUZkw0ZWFTcytySFN5YUlTV1pkeUZVaU5sSEwvQmhmMGR3bGFtU0dF?=
 =?utf-8?B?bXF5K0NJakVYeXNzTnlTMS9BTTUzM0dkZ3ZyZ29YdzIrQnJmWWdHa0hhYVdU?=
 =?utf-8?B?UGN0TXpTK2p5alN4UXB2NlB0UlJEVE8rRFZRcC9yNmx5Qm02OTI5R0xsWUpV?=
 =?utf-8?B?aWw3WFQ4STNHZkRTNEszbGZaMytNVm9BaHVoUmxRcnJ2N0dqNHh6K3NhTHY1?=
 =?utf-8?B?TllVNytlc0pRbFQ4Q3JpSkJYUGJ3QTJLT1BNV2E1cEhLZHBBVk1RMjZUQjJV?=
 =?utf-8?B?cGYxUGRQSzE1YmlCQW14YlFWdmY5cFMwRU9jWmRkbTZ6NHNweDQ0WXJZZ3hh?=
 =?utf-8?B?VkYzMWFEYnRTTVUzR3FuZ0wwSVE3Z0NYTUlHNXRzaXZucWQrZHIxYU83dDA3?=
 =?utf-8?B?WXpVL2lGVVJBS2NackhTSGRuNDdRTWtCM1VDZEpGVjJldEgrVUxBQ1VHblhI?=
 =?utf-8?B?ZG5sZW93a2tRazN4c3YzRlNTOExnc1JBanlGWk1kVjBtZ2xCZm1jZ2xqS0NH?=
 =?utf-8?B?VXV3YytqLzM0eXNJOUwvTE9HNzAyNitqSXMwWXFoUDd3MDhxUmRRd1pOSVVP?=
 =?utf-8?Q?YvLaCB4+zbSGRd3bnOsih2kB4oyxDkwMFV8CJrhpDJAh/?=
X-MS-Exchange-AntiSpam-MessageData-1: 8UXHFHontrwfAQ==
X-OriginatorOrg: nebius.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32f2dab1-dd80-414e-95f2-08df46a2119f
X-MS-Exchange-CrossTenant-AuthSource: PA3P190MB2470.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 01:03:20.6033 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4eb23c52-f3a5-49bc-b555-0b061267a984
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CxdLkrXJcFTOc0CkMqJl1C7/A4jRMJ33efflmNAL1fhoowDHJOrSGqE1rpP/8l1AFbjsfhcA1S5p5I+mJftVgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1P190MB0990
Received-SPF: pass client-ip=52.101.65.115;
 envelope-from=antonkuchin@nebius.com;
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

On 17/11/2026 13:21, Michael S. Tsirkin wrote:
> On Sat, Nov 07, 2026 at 12:59:47AM +0100, Anton Kuchin wrote:
>> The assumption that all used ranges lie within the provided window
>> bounds resulted in generation of free ranges beyond the limits and
>> incorrect address assignment in guest. As used regions are collected
>> without any knowledge about which limits will be applied later, some
>> non-standard topologies with multiple expanders and devices break free
>> ranges calculation. Skipping such used regions fixes the problem.
> 
 > Was an issue observed?
 >

Yes, the issue was observed. Found it at the bottom of the rabbit hole 
while figuring out why guest panic detection wasn't working in some VM 
configurations.

 >
 > With which guests?
 >

Reproduced with regular ubuntu guest on 6.11 kernel and I also tested 
with 6.17 when it was the latest stable, didn't retest since then, 
though I believe that problem is not in the guest but in qemu ACPI 
generation logic.

 >
 > In which configurations?
 >

Unfortunately I didn't preserve the exact commandline, only guest log 
snippets and troubleshooting notes. It was GB300 VM with with 8 vSMMUs, 
9 PCI expanders, 21 vfio-pci devices plugged into them, plus some 
auxiliary PCI devices. I can try to reproduce the commandline if it 
turns out to be necessary but it will take time.

 >
 > Could you be more specific please?
 >

I discovered it on arm64 so the example will be for arm64, but x86_64 is 
affected too (and probably other platforms that use this code to build 
ACPI tables).

Arm virt machine has VIRT_PCIE_MMIO range [0x10000000-0x3efeffff] for 
PCIe MMIO, that gets assigned to GPEX config mmio32 base and ends up 
being used in acpi_dsdt_add_gpex() as limit to get free ranges by 
crs_replace_with_free_ranges().

Reserved ranges are collected by build_crs() which doesn't know about 
the windows and just sorts all regions into 3 buckets: IO, MMIO32 and 
MMIO64. In my case there was a reserved region [0x00100000-0x001fffff] 
way below mmio32 window that ended up in crs_range_set.mem_ranges bucket 
for MMIO32, I didn't dig what exactly reserved it.

Before the patch the first iteration of the loop starts with free_base = 
0x10000000, used->base = 0x00100000, so the range is not added but at 
the end of iteration free_base is set to used->limit+1
and suddenly jumps back from 0x10000000 to 0x00200000.

Then the second iteration takes next reserved region that belongs to 
mmio32 window [0x11400000-0x...], it passes the check free_base < 
used->base and the range [0x00200000-0x113fffff] is added as free mmio32 
region instead of [0x10000000-0x113fffff], with the 
[0x00200000-0x0fffffff] portion not backed by anything.

Guest kernel trusts ACPI and marks the region as available resource

[    1.194101] pci_bus 0000:00: resource 4 [mem 0x00200000-0x113fffff 
window]

Then unlucky device gets BAR assigned to it

[    1.810094] pci 0000:00:0b.0: BAR 0 [mem 0x00200000-0x0020000f]: assigned

... and doesn't work. In my case this happened to pvpanic-pci, but there 
is nothing specific about it and any pci device can fall into this trap.


After the patch the cursed region is gone and same qemu commandline 
resulted in correct assignment and working device

[    1.831232] pci 0000:00:0b.0: BAR 0 [mem 0x10001000-0x1000100f]: assigned



Similar thing can happen with reserved region above the limits, I've 
never saw it, just analyzed what can happen if the function receives 
some unexpected inputs.

Let's take same [0x10000000-0x3efeffff] limits for PCIe MMIO and 
reserved region above it [0x50000000-0x50000fff].

Without the patch such region is processed, and with free_base = 
0x10000000, used->base = 0x50000000 code

         if (free_base < used->base) {
             crs_range_insert(free_ranges, free_base, used->base - 1);
         }

adds region [0x10000000-0x4fffffff] instead of [0x10000000-0x3efeffff].



These cases can be handled by using MIN(used->base - 1, end) and 
MAX(used->limit, free_base) instead. Skipping obviously irrelevant 
regions just looks cleaner in my opinion.

> 
> 
>> While at this fix potential uint64 wrap around if range->limit is
>> equal to UINT64_MAX that can add extra free range at the beginning
>> of the address space. Not sure this can really happen with some
>> combination of virtual topology and firmware version, but this
>> check doesn't look expensive and it's better to handle it now than
>> spend hours debugging this strange case later.
> 
> maybe but it should be documented better.
> 

You are right, it should.

This one I didn't reproduce. But if we ever encounter the reserved 
region with limit equal to UINT64_MAX the lime

         free_base = used->limit + 1;

wraps free_base to become 0.

Then the code that handles the remaining free chunk after the loop

     if (free_base < end) {
         crs_range_insert(free_ranges, free_base, end);
     }

will insert invalid range [0x0-end].

I was thinking about adding check free_base != 0 at the tail insertion 
instead of checking inside the loop, but it will break the "valid" case 
when window starts at 0 and the ranges list is empty.

To be honest I find this extremely unlikely, that's one of the reasons 
why this part is a separate patch that can be dropped. There must be 
something really unusual that reserves a range ending at the limit of 
the address space, but with the variety of architectures, devices and 
firmwares it's hard to be 100% sure.

> 
>> Signed-off-by: Anton Kuchin <antonkuchin@nebius.com>
>> ---
>> Anton Kuchin (2):
>>        hw/acpi/aml-build: Ignore used ranges outside the requested window
>>        hw/acpi/aml-build: Avoid overflow when advancing the free_base cursor
>>
>>   hw/acpi/aml-build.c | 18 +++++++++++++++++-
>>   1 file changed, 17 insertions(+), 1 deletion(-)
>> ---
>> base-commit: ddb42c53b4d91d12511f49ee4428d9594eb5eb49
>> change-id: 20261106-users-antonkuchin-to-send-fix-crs-replace-with-free-ranges-761219313073
>>
>> Best regards,
>> --
>> Anton Kuchin <antonkuchin@nebius.com>
> 


