Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B3160A5BD7
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 11:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=ofafmyHl
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQkLr-0003p3-Ck; Tue, 10 Nov 2026 06:49:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1xQkLm-0003kB-Nr; Tue, 10 Nov 2026 06:49:18 -0500
Received: from mail-japaneastazolkn190130003.outbound.protection.outlook.com
 ([2a01:111:f403:d405::3] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1xQkLk-0000oA-Fe; Tue, 10 Nov 2026 06:49:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YF7OiurCn566r+wwJa6vOfE+MjUxSBfzwd0127wHrCJnxlIEK4/LAsfWZ6k8u/AdvZqvx+UYf+sFtyoH7bDIB6MUfbhgb1ViZ8fdxnFiG9mpVBfMlzYrvhvU3/K0eaQqnjtncymyjTKJaAjpTqXU1+x7l2lCx4LUmNkIJGpI07Sw8UkXsd0BDXt8Amsk14MiDcMf++45W3aFf6kC3ph0HlqXUXyW81ZQz/70roMeegMAHV8HB4rOI8HsJBJJwRbA+2/rRHrc+4K/jTLaeOZb9YTPPjncoRsnnFT0EMmrEKRoDuwrYqKSxhH1rulPidptJ9WdiuoVck3xyE1UgNicpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rMKFWoEqJvntjYqI+6QNrwr49TyrJ4o2ImGJQYXALgU=;
 b=EWh4AaL9o4UhIa28w9k3sBOrtKVN39qSM5VUd9HNsmq6TigpD+LMEvcECaKxZB/RF9hl+DioPdhIYHrAeMO8x/02KzxK3hdhH0rG9x/3niSh1aZ3Xbvh8OEbwZWj9qVGjkOKGv0fO1zd5jz5zPgHPgGg9bX3jbUAuRYTkEw6psNYUazxPwx7g3iA0Git6J6V2XB63mWUpdJT8n5jpn13D4wFkP1qIFlHIYWKoGVBNF+lpEEkR9iOZ3BTQP+nCHUG1ezjr+3rJEYqyWKXF11jgh9je1tdiujNmiPpmmA4FQM8fFqAYc6FwcOD0SHA7uWtu4ZRYYnCjl4qEU0LuQNOiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rMKFWoEqJvntjYqI+6QNrwr49TyrJ4o2ImGJQYXALgU=;
 b=ofafmyHl8fRmL+e6iebstx+VeWHo1PpVbAq0t62J2tzaRRWTclMr41x1sP4+6rAEeIw7JHexeGLQfy45fB9utncFfhh5+KVuN6bD5NMB0LQ/23jAmheGpqNqcbWhMtX9qMao7z4xjLldI39CWYTkyPN/iLKwhByPEvlLPGEBfRxFZNJDCD01rlymV2yyR6xbOSwXyQg7CKqDT1psy0gkf9VdQkGHAa/vJx4NtCgLXLVLSPf62WG2EedIXzfK0/z3OBV2r8aEDmIbj93YU3ghfIRdVSc7IQMZKWL8+2DLkL6r50npJfxE8y3Jhabq5jCjIPn2/hgDDeXcUhx5I7gqkg==
Received: from TYZPR04MB7491.apcprd04.prod.outlook.com (2603:1096:405:40::7)
 by TYZPR04MB5927.apcprd04.prod.outlook.com (2603:1096:400:201::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Tue, 10 Nov
 2026 11:49:08 +0000
Received: from TYZPR04MB7491.apcprd04.prod.outlook.com
 ([fe80::a450:2576:3b21:6230]) by TYZPR04MB7491.apcprd04.prod.outlook.com
 ([fe80::a450:2576:3b21:6230%3]) with mapi id 15.21.0592.012; Tue, 10 Nov 2026
 11:49:08 +0000
Message-ID: <TYZPR04MB74919088016737D2EB0B05BAF3722@TYZPR04MB7491.apcprd04.prod.outlook.com>
Date: Tue, 10 Nov 2026 19:49:00 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/intc/aplic: Fix msicfgaddrH in split mode
To: BillXiang <xiangwencheng@lanxincomputing.com>, palmer@dabbelt.com
Cc: alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com, qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 anup@brainfault.org
References: <20261104025308.1920474-1-xiangwencheng@lanxincomputing.com>
Content-Language: en-US
From: "Nutty.Liu" <nutty.liu@hotmail.com>
In-Reply-To: <20261104025308.1920474-1-xiangwencheng@lanxincomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TPYP295CA0055.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:8::15) To TYZPR04MB7491.apcprd04.prod.outlook.com
 (2603:1096:405:40::7)
X-Microsoft-Original-Message-ID: <a3f70207-2a1e-49b0-95c8-aeef43bf8ebd@hotmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR04MB7491:EE_|TYZPR04MB5927:EE_
X-MS-Office365-Filtering-Correlation-Id: 00a4ae4d-b75d-423c-91d7-08df3f20a088
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|23021999003|19101099003|55001999006|5072599009|22091999003|15080799012|24121999003|51005399006|6090799003|41001999006|19110799012|8060799015|25010399006|4140399003|3412199025|440099028|40105399003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VnpNSFBucElmYjd2Y3NzYUlFajBaeC9EUVh4MUFxSVRaRkMvcEZVRThZTUZ6?=
 =?utf-8?B?SmRSSGJEQW8wbVUzdWs0VllDTHowTUtEWWQvTEs1Z0I3TklUTzEwQ0YvOHJq?=
 =?utf-8?B?c09OR2JqUTNTdVU5WC9jTWFua3N4K2Q0bDdhbk9YbmJud1BoUHYzVUhscHBn?=
 =?utf-8?B?TEtreU0rMUY0dGRsN2h1S2hrUm9Wd3BhRmRIMkd3bXdsdHMvaElSM1NNM0Iy?=
 =?utf-8?B?Zld1YWE4UTVqbkpJc2YzRmw4T0VJUTYwWjlJRmRHNENGUnR3Y0s3UFdMTlVa?=
 =?utf-8?B?Y2k4ekNSTlV5dnJtQnZDZG5oQ1puL0NmTEZhRkU4SXNMd25TYi8xdytRU3Nk?=
 =?utf-8?B?VUVWTGU0aFI0UHppbG1EVDBhRis0SzV3citXZGJDcVlrM3FKWlFKd1lLMXpj?=
 =?utf-8?B?NitMdkJVUlBqSm5mUzR5QStsYUNOTmNzNG1hT2xwVll0VUtJVFA4djZidkpG?=
 =?utf-8?B?NW8yb05mb3hNSlMwRHFYSHNXSzQ1YVBleUdzdGNXZHFMT04yWWJ5M1V4a0ta?=
 =?utf-8?B?VWdtMFBoZ05pQnoxem5kZEtYZmdIcGZ0K0EzejIvazdiQVRtN3d5amZIOGd4?=
 =?utf-8?B?UlFZZUpjTGdqVjVGS3RoVGdoajdqV1Y0OUhNSUhDcXZCdkxlb3ZhWEpocE8x?=
 =?utf-8?B?eW54c0ZGeVVrMXBkWnFTbWxEZEErWHVEUXN5elgxdnBkQTR0WGlBWFdLQjFh?=
 =?utf-8?B?d1ZvbWU3dDVaL2FsZzllNkRTOFdKcTVSaU5acnROOSs0K1A1MnlNU3d0VEtY?=
 =?utf-8?B?aWVObmRqZUN1aHpvZkpyaVllMmFvOWd3aWhDRDJFSDI1b003ZnVoWUIvTURU?=
 =?utf-8?B?cm9VUVVPWUN2blMweWV6Z05MR0Y3RDBLSEsrOEVpSEZmVG1CdjQyWndkcEMr?=
 =?utf-8?B?czVKSnJYeGFlaXRjVVNWWDBTZ3dkZnJSaEUwT3o0QVZ3U1ZzenlHV0xlNTlj?=
 =?utf-8?B?VEY4VFpMd2lYWjVRY3FPQlg5MXBhMHNjRWFibTdwWi9xQ1kySm1PcW1QaFhC?=
 =?utf-8?B?UGhhTXlreFpCZHhhbGgxeTB0MEwvdkRGY3FxQmU1MHpaNDV0UWxmN3JZeVha?=
 =?utf-8?B?YmN2b1JPaTQ4aTdMWkozWXp4VFQ4anhYa3l4d015REZhdG9ra0Q3TUFHMENi?=
 =?utf-8?B?ZzZPSHBVN3pmTVdPOUI5UklYYVJaQk1jeGVxTFIyU2F4cDlBVi82dUU4UEpB?=
 =?utf-8?B?TzA0TTgrSmxnYkkwclp0djZRS3VueER5U0NCS0NjTVNKcWx6alQ4RVkvVGFq?=
 =?utf-8?B?QUdsREtUQVN0M054T2ozOWtuZ01HcEVWcWsyMkkxQTJ6eVFOMjY4TmRUM3RZ?=
 =?utf-8?B?VkNMV1JUT2ZCMnBUZFBERzRiT3prdStVQXRNSExndXlQcFVQT2NZdHczWFA5?=
 =?utf-8?B?UUc1MU5KTVlJbzNwTTZ1b2VnU2hZRjFhcDRzUUszU3VwazgzVSsyNDgxVzc0?=
 =?utf-8?B?NjRuc2Q0ay9zVmN3KzkvVGlVMFRnTTgzTlNPaDBRPT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmFEeHFlakdWbytobnIrQVhTeWRCaC9pYTFGYTNieVJyUG5FVVNjaTVIcEFG?=
 =?utf-8?B?aDBaQ2Nha3ZxcXdnd3o3Vno4M0NpaXI0RDN0ZWJQaVlJSzVWck5OMWdXc25X?=
 =?utf-8?B?WS9XZWpWYW1nbndiNlZ4dTBSdnhEZU5WSEJRREFRUFRvcGxmY2RwSld3WmlC?=
 =?utf-8?B?QUtkWEJObElXV2N2cE9BZHlwU0lKdzhiMHhVUHVyOXpRYTVGSzVVcTVHNjVS?=
 =?utf-8?B?enZlNjUvZWN5MnNid2JWZnV6SUYvOHcxYlJVd1dlWDA0ZW5SNUFvMEdveGNh?=
 =?utf-8?B?RWJaWWlFalZXR3FXbUVWZXhYQ0tLTkcxeWJlNTVHWEVGSkFwQU5iVG1tRER5?=
 =?utf-8?B?R0dlTkV3RDNwV0FEOHA2T0JyRmJ0Ymp5TVB3YXdEZWJiMWJVR0lpRi9Ua1Q2?=
 =?utf-8?B?NFE3dG5KK2x6anNhTFNDd2dYUmJkMXdXZ29ITWdiT1dhTGEzZ3NEZm5YbmVv?=
 =?utf-8?B?Y1Vod1FlaC85V0tJeWRQcy9KMTNtU25qQU1GdlJRVTE4Z2R3eU1YdzR2RUdv?=
 =?utf-8?B?NTVJVGlSbndhR0haZmZtNStXdEZqVERGUzhTODZPdXNPWGUyalBVR0ZGOGNB?=
 =?utf-8?B?cWc1NDAxREYydzh4WDdwTjcraktSVGRValAwdGpaKy9oZnVWWWxhUENnRHpl?=
 =?utf-8?B?Q25WTTBXemhneEZaMjZCNDlISnd1QjlTQkFidDZtbVZzOHVsSmlKQWpiMVF4?=
 =?utf-8?B?azFuR1E1bW50a2NqOVZjVEFtUUxEQkYraEl1aFBoTkFqb2xHZkNvRWNGWlhy?=
 =?utf-8?B?UDd1NUZqdkJ2N1lqTGhRbmtvK3REeExKdXRnU0NaWVQwUEFMSGxoMzFRWUxw?=
 =?utf-8?B?V0ZQM1dsRDZNWHNnZGlYUFgzQlhUdGR3clJoK0Yzdnp5Q1o0ZExBemVRdjZS?=
 =?utf-8?B?UFM2UTlnUHQzRFhacC9Mbm1iRHVMZWRqd1h4T0JGaVIxQzd6Y1lRenJ1RGl0?=
 =?utf-8?B?WkpUcm5ZdXpmRGZWbkc5SGlYWEtDM2hnUEtDRVArMk4rVnN1d0NkU0c1NkJp?=
 =?utf-8?B?RENNMGVWT3F3S203cWVDM1crM1RKRnRLYVp3YU1HVVVENWViL0hDOURpRi94?=
 =?utf-8?B?RU9ENGg0ZmsxM3pmei9EYUwzMFVmVnJZeFZMVVlrSUJzQ2RvZGdtc1JtRG96?=
 =?utf-8?B?K05xaVFqQUtIOXM1MmdMRUdGYm8yRlVVb1hjRmI5ZUtQM09IejlRVmFjM1ls?=
 =?utf-8?B?NlZneGU0dUU0NlB4YU9WNE9lamo1UGIxZU9uL3BGSWttcWhTZHYvSXRkb21L?=
 =?utf-8?B?cXV6RDBxcFZuTUR4a2JlOVpXaVA3MXJFYXIrZ0ZrQVR6aG5IcXlIRVpyWVE3?=
 =?utf-8?B?eXd2Ym5HVlVMVGNlYzdhMEZ0dmZxbmlqZ1g2Q2k3RFhXL1dheWprbHRRTGtr?=
 =?utf-8?B?QW42c1h1cEg5b3ZlZTlLbDQyTjZKbVRuenRZV3BER2owRzBwbHhDREdPV21C?=
 =?utf-8?B?Sml4TU9oUEN6YitKZXBLZUtTcGpqOWZybE45bFJkWXIybVM2L2RCUFd5bkF4?=
 =?utf-8?B?L3hldWJsRDZHMlpBOFdIcHpxK2wrUGV2UWNFVDVrRWU0enFxME9uU2Rod01o?=
 =?utf-8?B?dWRsT3RLQzB0RzNQYmlMZHBXRlpuNFFteEVEUEVNVndGL3haSEZ4cU10UXlL?=
 =?utf-8?B?RGZhTHk0L2pjaVcyb05VNTJBVmRVYTRSbW9DMTF3RVRVbDJjejBGSDQrUE4x?=
 =?utf-8?B?OVpuTDRDdzJldWhvZDhhQzJUVjE4ZGpkaGdwRzZ0Z1JrN0xPMFBBbXFUOFUx?=
 =?utf-8?B?NVY0Uzh5V0lpNlNKR2NKUjV6blBzWFltaHBVUnRBMmRHUGc2UW5GVDRVUlhu?=
 =?utf-8?B?NWJHVlNjYlJGbUE3U1l2cmtxRHV1OWpUaHBkVXNjZ0lxelBKbWUxblZjaUJ2?=
 =?utf-8?Q?qv23uMgW0koe9?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-c3e7a.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 00a4ae4d-b75d-423c-91d7-08df3f20a088
X-MS-Exchange-CrossTenant-AuthSource: TYZPR04MB7491.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 11:49:08.3566 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB5927
Received-SPF: pass client-ip=2a01:111:f403:d405::3;
 envelope-from=nutty.liu@hotmail.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 11/4/2026 10:53 AM, BillXiang wrote:
> Add hart_bits and guest_bits to msicfgaddrH in KVM irqchip
> split mode.
> Also remove the redundant left shift when loading
> kvm_msicfgaddrH in riscv_aplic_msi_send().
>
> Rationale:
> static void riscv_aplic_msi_send(RISCVAPLICState *aplic,
>                                    uint32_t hart_idx, uint32_t guest_idx,
>                                    uint32_t eiid)
> {
>       uint64_t addr;
>       MemTxResult result;
>       RISCVAPLICState *aplic_m;
>       uint32_t lhxs, lhxw, hhxs, hhxw, group_idx, msicfgaddr, msicfgaddrH;
>
>       ...
>
>       if (aplic->kvm_splitmode) {
>           msicfgaddr = aplic->kvm_msicfgaddr;
> 1.        msicfgaddrH = ((uint64_t)aplic->kvm_msicfgaddrH << 32);
>       }
>       ...
>
>       lhxs = (msicfgaddrH >> APLIC_xMSICFGADDRH_LHXS_SHIFT) &
>               APLIC_xMSICFGADDRH_LHXS_MASK;
>       lhxw = (msicfgaddrH >> APLIC_xMSICFGADDRH_LHXW_SHIFT) &
>               APLIC_xMSICFGADDRH_LHXW_MASK;
>       hhxs = (msicfgaddrH >> APLIC_xMSICFGADDRH_HHXS_SHIFT) &
>               APLIC_xMSICFGADDRH_HHXS_MASK;
>       hhxw = (msicfgaddrH >> APLIC_xMSICFGADDRH_HHXW_SHIFT) &
>               APLIC_xMSICFGADDRH_HHXW_MASK;
>       ...
>
>       group_idx = hart_idx >> lhxw;
>
>       addr = msicfgaddr;
> 2.    addr |= ((uint64_t)(msicfgaddrH & APLIC_xMSICFGADDRH_BAPPN_MASK))
> << 32;
>       addr |= ((uint64_t)(group_idx &
> APLIC_xMSICFGADDR_PPN_HHX_MASK(hhxw))) <<
>                APLIC_xMSICFGADDR_PPN_HHX_SHIFT(hhxs);
> 3.    addr |= ((uint64_t)(hart_idx &
> APLIC_xMSICFGADDR_PPN_LHX_MASK(lhxw))) <<
>                APLIC_xMSICFGADDR_PPN_LHX_SHIFT(lhxs);
> 4.    addr |= (uint64_t)(guest_idx & APLIC_xMSICFGADDR_PPN_HART(lhxs));
>       addr <<= APLIC_xMSICFGADDR_PPN_SHIFT;
>       ...
> }
>
> Since msicfgaddrH is left-shifted at (2), the left shift at (1) is
> redundant.
>
> At (3) and (4), hart_idx and guest_idx are masked/shifted using lhxw and
> lhxs, which are extracted from the LHXW/LHXS fields of msicfgaddrH.
> However, riscv_aplic_set_kvm_msicfgaddr() did not program the LHXW/LHXS
> fields into kvm_msicfgaddrH, so lhxs/lhxw always read as zero, and the
> hart/guest idxs were never encoded into the MSI address. Fix this by
> programming hart_bits (LHXW) and guest_bits (LHXS) into kvm_msicfgaddrH
> in riscv_aplic_set_kvm_msicfgaddr().
>
> Signed-off-by: BillXiang <xiangwencheng@lanxincomputing.com>
> ---
> Changes in v2:
> - Add rationale.
> ---
>   hw/intc/riscv_aplic.c         | 13 +++++++++----
>   hw/riscv/aia.c                |  6 +++++-
>   include/hw/intc/riscv_aplic.h |  3 ++-
>   3 files changed, 16 insertions(+), 6 deletions(-)
>
> diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
> index 03a0852b8b..2b618e73df 100644
> --- a/hw/intc/riscv_aplic.c
> +++ b/hw/intc/riscv_aplic.c
> @@ -182,7 +182,8 @@ bool riscv_use_emulated_aplic(bool msimode)
>       return kvm_kernel_irqchip_split();
>   }
>   
> -void riscv_aplic_set_kvm_msicfgaddr(RISCVAPLICState *aplic, hwaddr addr)
> +void riscv_aplic_set_kvm_msicfgaddr(RISCVAPLICState *aplic, hwaddr addr,
> +                                    uint32_t hart_bits, uint32_t guest_bits)
>   {
>       if (!kvm_enabled()) {
>           return;
> @@ -191,8 +192,12 @@ void riscv_aplic_set_kvm_msicfgaddr(RISCVAPLICState *aplic, hwaddr addr)
>       if (riscv_use_emulated_aplic(aplic->msimode)) {
>           addr >>= APLIC_xMSICFGADDR_PPN_SHIFT;
>           aplic->kvm_msicfgaddr = extract64(addr, 0, 32);
> -        aplic->kvm_msicfgaddrH = extract64(addr, 32, 32) &
> -                                 APLIC_MMSICFGADDRH_VALID_MASK;
Is it necessary to perform boundary checks on hart_bits/guest_bits ?
Just like:
+    assert(hart_bits  <= APLIC_xMSICFGADDRH_LHXW_MASK);
+    assert(guest_bits <= APLIC_xMSICFGADDRH_LHXS_MASK);

Otherwise,
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>

Thanks,
Nutty
> +        aplic->kvm_msicfgaddrH =
> +            ((hart_bits & APLIC_xMSICFGADDRH_LHXW_MASK) <<
> +             APLIC_xMSICFGADDRH_LHXW_SHIFT) |
> +            ((guest_bits & APLIC_xMSICFGADDRH_LHXS_MASK) <<
> +             APLIC_xMSICFGADDRH_LHXS_SHIFT) |
> +            (extract64(addr, 32, 32) & APLIC_xMSICFGADDRH_BAPPN_MASK);
>       }
>   }
>   
> @@ -404,7 +409,7 @@ static void riscv_aplic_msi_send(RISCVAPLICState *aplic,
>   
>       if (aplic->kvm_splitmode) {
>           msicfgaddr = aplic->kvm_msicfgaddr;
> -        msicfgaddrH = ((uint64_t)aplic->kvm_msicfgaddrH << 32);
> +        msicfgaddrH = aplic->kvm_msicfgaddrH;
>       } else {
>           msicfgaddr = aplic_m->mmsicfgaddr;
>           msicfgaddrH = aplic_m->mmsicfgaddrH;
> diff --git a/hw/riscv/aia.c b/hw/riscv/aia.c
> index 56fc064533..bd608bd7a6 100644
> --- a/hw/riscv/aia.c
> +++ b/hw/riscv/aia.c
> @@ -38,6 +38,7 @@ DeviceState *riscv_create_aia(MemoryRegion *container,
>   {
>       int i;
>       hwaddr addr = 0;
> +    uint32_t hart_bits, guest_bits;
>       DeviceState *aplic_s_dev = NULL;
>       DeviceState *aplic_m_dev = NULL;
>   
> @@ -93,7 +94,10 @@ DeviceState *riscv_create_aia(MemoryRegion *container,
>                                    msimode, false, aplic_m_dev);
>   
>       if (kvm_enabled() && msimode) {
> -        riscv_aplic_set_kvm_msicfgaddr(RISCV_APLIC(aplic_s_dev), addr);
> +        hart_bits = imsic_num_bits(hart_count);
> +        guest_bits = imsic_num_bits(aia_guests + 1);
> +        riscv_aplic_set_kvm_msicfgaddr(RISCV_APLIC(aplic_s_dev), addr,
> +                                    hart_bits, guest_bits);
>       }
>   
>       return kvm_enabled() ? aplic_s_dev : aplic_m_dev;
> diff --git a/include/hw/intc/riscv_aplic.h b/include/hw/intc/riscv_aplic.h
> index 62d2b33ade..d3ee2e537a 100644
> --- a/include/hw/intc/riscv_aplic.h
> +++ b/include/hw/intc/riscv_aplic.h
> @@ -78,7 +78,8 @@ struct RISCVAPLICState {
>   void riscv_aplic_add_child(DeviceState *parent, DeviceState *child);
>   bool riscv_is_kvm_aia_aplic_imsic(bool msimode);
>   bool riscv_use_emulated_aplic(bool msimode);
> -void riscv_aplic_set_kvm_msicfgaddr(RISCVAPLICState *aplic, hwaddr addr);
> +void riscv_aplic_set_kvm_msicfgaddr(RISCVAPLICState *aplic, hwaddr addr,
> +                                    uint32_t hart_bits, uint32_t guest_bits);
>   
>   DeviceState *riscv_aplic_create(MemoryRegion *container,
>       hwaddr addr, hwaddr size, uint32_t hartid_base, uint32_t num_harts,

