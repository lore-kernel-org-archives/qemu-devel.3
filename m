Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5EBE606A31B
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 03:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=s/w5DUEx
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLXTU-0005fx-6q; Mon, 26 Oct 2026 23:03:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1xLXTT-0005fj-18; Mon, 26 Oct 2026 23:03:43 -0400
Received: from mail-japaneastazolkn190130003.outbound.protection.outlook.com
 ([2a01:111:f403:d405::3] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1xLXTR-0006IH-4g; Mon, 26 Oct 2026 23:03:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lYCDsa8UGvj+FTSf5/PCWUMsoRRt3ThuWUCZ2TUx8ATXDL9OVg4HCMcUGQZuFb1lbpsHuC6u8D5ihHfhnG+gpbX+VxKFwlXB4/TYBqJpRXOTV5gAYJDcs0A/V1Z0DtnshV+nCbbS2zzInz5lniEFY0UuKl115stjX/8hjeMzIyV+oXdsUnKpmvfzW2ws4Q887wk0F356fIhSeKWQFKNoogTWd1QecsT8yOwd6GbaTYoS6E5Vzr0tiYmaIWVTA2HIouzVAHxGLHINI2fPdHwYjMlLyRHzJopJbRUy6wRSzzM2pvfMbcKEeydhtXtGeXDH0seYTKUt9h7+LeAijogm1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yxJHNgOsQBB0iQbzvlSo9KbpwDWjEBLsDOzJmwpanF4=;
 b=rfB9MUFEcczS2EnI4IrH2Cmvw6072z9oxK/5ljJnTsIKGmcgfx+817LDbqVbMpHH7ZzdW+25S/2owhJhnMZHGiCMYl3yqf/ydJxM5N98GshUKOZDrKFL3mn/phifafogjtFadf7Xf6Lvn4osTRpk3XSb+XR4ewhhY4Gb8NkzaSK8iklHoO4yFypcWwZZVHLWds75uv0ZaV5flIDD4ZwcZoqmpuOxT7yLn+5eCgT+NpgCEW6TMK0ygR7a6bjSVnfdvrph24Ub1HX2TqiSwFZgceSzZIC8AInsrt+3LuIXn16BV/WgZKC0UykuJX1DGQHia32rS2/oj9ltPBgqGk/LVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yxJHNgOsQBB0iQbzvlSo9KbpwDWjEBLsDOzJmwpanF4=;
 b=s/w5DUExEjgWk4qsp0mg7rD8bnBgIs2Bfep+RMNE3xUvGmr8HskZqwxoTl3v8DOU1Xe7UguV/LLI335EYqJS5eAcCjPHkCbl9UD7IHpKHz59LRDrmLuAMvPj8dhFXH5Vgb6haxST6zysYCbVSckZBjZM8Q7fQ7uPsI0FKJR8fljKG1PF+9nQI3vpPSmoZJ/1xSnATeXn9UtMObJp9XgVQOci4if9LOooIThoOIbZvYpfyL0/oqtixe1EobjvGu0I6EHcA0JFJhUVPKY7DP8n5A+g26ZlOBd/vJlTdYedj18XOe2gRdsJLjh7/ZKjLCsZfhUAzJz1Itn7BwqNQrFqsg==
Received: from TYZPR04MB7491.apcprd04.prod.outlook.com (2603:1096:405:40::7)
 by TYZPR04MB7577.apcprd04.prod.outlook.com (2603:1096:405:3d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 03:03:32 +0000
Received: from TYZPR04MB7491.apcprd04.prod.outlook.com
 ([fe80::a450:2576:3b21:6230]) by TYZPR04MB7491.apcprd04.prod.outlook.com
 ([fe80::a450:2576:3b21:6230%3]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 03:03:30 +0000
Message-ID: <TYZPR04MB7491DC6189FB75BFF9F041EAF3602@TYZPR04MB7491.apcprd04.prod.outlook.com>
Date: Tue, 27 Oct 2026 11:03:23 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] target/riscv: Fix incorrect MMU_USER_IDX value
To: Wang Yechao <wang.yechao255@zte.com.cn>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>
Cc: Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
References: <20261027023729.680646-1-wang.yechao255@zte.com.cn>
Content-Language: en-US
From: "Nutty.Liu" <nutty.liu@hotmail.com>
In-Reply-To: <20261027023729.680646-1-wang.yechao255@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: JH0PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:990:5::18) To TYZPR04MB7491.apcprd04.prod.outlook.com
 (2603:1096:405:40::7)
X-Microsoft-Original-Message-ID: <acefea02-b79b-4f8e-80c4-4e4fade99c57@hotmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR04MB7491:EE_|TYZPR04MB7577:EE_
X-MS-Office365-Filtering-Correlation-Id: e5d42b70-1bd9-4468-a1d1-08df33d6e0d0
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|51005399006|6090799003|5072599009|19110799012|8060799015|24121999003|19101099003|23021999003|15080799012|22091999003|55001999006|4140399003|25010399006|3412199025|4302099013|440099028|10035399007|1602099012|40105399003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ejVvLzg3anhMaXQyclc5elNyUkJ2K3JOSXNRdUpVWUU4V0NQSFRpU0dicXls?=
 =?utf-8?B?VHEzdUp1NURKNmNjVUx4WlcrU0V3Z1diTHQxVnprVFFzSHFHUjdaaThFMUdX?=
 =?utf-8?B?T3A4UDVRbnBNYzl2eG8wak81VG9kQi85azVSTGF1dTVBL1g0NERJYVh6YVJo?=
 =?utf-8?B?UDF3NktCRzVyN3Y3MFRsY1lTclF6UVFnVHhXM0RucEc0b2Q5Tk80TzMrRlRx?=
 =?utf-8?B?T3h1VWZEY3E0d0VVNWpoZEsrbHdyUGt1YVBNdUxseGxEMmkwazRNSjZuL3Bx?=
 =?utf-8?B?aCtQRTZ3VlJLVXBML0hWY1FlU3cySjgvVUJNK2ZtRUVhYWY3REwzdEl6V3oz?=
 =?utf-8?B?Skd5MWVvQlBxUDJCY0hZV243SUVtM0h0VTkwL3MvaXVRZWZKNFpiR1RwcmJN?=
 =?utf-8?B?SVNveHdrNnROeCtPeXVGVmdlREVlQXVlRmowU3dieEEzVGY1aEN5RERGSGJu?=
 =?utf-8?B?U3Fna3V4cVFqRlN5dFVXbWpGeFZBWkVzRWJzWXBOWXJQYTdTaVRUNGwyMXdo?=
 =?utf-8?B?ayszTjFpV2NxM05SbndkQWpnaXY5RXN0WjkwLzVSREo5OXRZQlloZEVOUU9O?=
 =?utf-8?B?SVRLUGNpNUYxdksvZmNuaDVRWHdVMHF4MXNraDF0VkhZZ3dHdUxXZkk4MnlN?=
 =?utf-8?B?WnZPc2Z4bU1UQ3RLUnRYd0FxZENyckNZWU5EK2tlcTFZZWZHMFlPeE9XRTIy?=
 =?utf-8?B?d3ZGU3lkdDkvN0l4NzFwUlVyMk85TjkzS0MyMDNLaVV6azZ5RElHTlhTZEtU?=
 =?utf-8?B?UTlYbkdheGVUL1BreVYvd2tzdXhEWlJ6Wm5jaVpWQmxJbjZFeGtSV1JUQlE5?=
 =?utf-8?B?WWNWS3dsWHEvbW82eVhXSmR1UUtKb3I4S3hLUms3dVVENmxkclo4KzBJR3Z0?=
 =?utf-8?B?aGZkTklQTkhiZ2tqa3FBRmRYa0JsN0Z6R2gxK05lOXpUQlZCczc1TEh2YXpk?=
 =?utf-8?B?c2E5WGpkTkRBS3RMRThXazJpdEt1VkFrSVJKUnZkT1c2VXNXUUtRc2Zhbjlt?=
 =?utf-8?B?SGVSVmM0YVU3eHp3Uk9DaE95OFRtZXBuTjUwN3E4YStEUWRzejc3SUttMmdM?=
 =?utf-8?B?SE42V2ZRVkFBcno2TG5hcCtLZWFmejhLQXB3R1BpZlhGNG9WbCtMZUdlb1Zs?=
 =?utf-8?B?NFp6V3BTK29LOWRQTEpvRXdzOWJ2UVZoemFwZ2NMV2ttdHJOd25KV29iME10?=
 =?utf-8?B?bjMwZ2ZxbVRoSTA1dUYyR2pLd3RDYkE5WDJJUExKYXFtNXVTVlg5bEl5VVhZ?=
 =?utf-8?B?TWRLTE5aNVA3TnAySTJLYWdLQTBQYjgxRU1hSG9QRFRuZEJUWXNiMnJma0Nv?=
 =?utf-8?B?ZFVaU0dJRzQrTTIrMmdNUXkxWHdtNXlWU3QyZm56cmVjSXV5TThZZEp4bFda?=
 =?utf-8?B?WlBTVFRQdWFQQ1UyL3BvMXBia3VzTm9DWWJ3NEwvOE9adVlBREh2MldyN0dN?=
 =?utf-8?B?N2cxdCtjbzRTeWJUZDZWZkp5dlJXNFhTZDdkd1ZuV3dWUm5ocnMzSEpZY3FS?=
 =?utf-8?Q?W+M91k=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QzBlL2g5cGNYN3R3ckprNHpFeUhmamlSRElxS2hmR0RYeUdxV3RTYkNBMHhs?=
 =?utf-8?B?ODAyeVc0Syt6R1VXcjdsOVd4WTJEMXh3OURTWGtOMktZdGpORzhOOFNZUFJC?=
 =?utf-8?B?NTRsY2dVRTlJbDdvZXM5clVRZVJEWXU3VlYzajNRMTZvWDFXNjN6NFBXYXh0?=
 =?utf-8?B?Zm9rUEdvVUZyZ2I0bThVVlJvL3lodDNOWm4weHVnbUdxNWlXajk5UXNnZlJK?=
 =?utf-8?B?UENYbzR6OFAwVjdjaDZHWitpcDhjOHB3SkJxTkVjeTR1N25hRWdlTHBJMWow?=
 =?utf-8?B?N3V3MHl6bWdYUitTMDZicjNZUEVveW03a1llb0lxMlJvNGE2UE9vZkMyUFlD?=
 =?utf-8?B?elBib3RIYUxNeEhiK2xKbHQ1TmJ0VnF3YytDNnB6U3JnRElKaS83QmRsTTVX?=
 =?utf-8?B?Z3A3L2lOVTN2YkF1UHpySzBDNkdOK3lUN1dyUmV0R2kzdWd6Q0IzejNPUWI0?=
 =?utf-8?B?SlR4Z1E3ek5oWktDMnlhWHJEV3c3Q0kzK3pOTDFhYjdnNEdSdjdwcUZObWZC?=
 =?utf-8?B?dzFDQzhubldubDZ6VFBsQmMwVFZSZ1RaQWluN1Y1djBxMCs2eEJvZktaLzcw?=
 =?utf-8?B?SkV0RmZyOVp0K2sxNkZtbkJ4dkorN0t5ZnMwWmdmY0IwcThSMi9VQU5TMnUx?=
 =?utf-8?B?ckQ5VjcvRkErb2w2WEVqZUNUQi9NL3lGb01rM3hZMzl1S1VtYTNSTDlQUm81?=
 =?utf-8?B?QzIwNHhLajdRWGVVemgvYi9yT3YzMzNqS21SNWhqL2RHbEZOeDFKZWQwZUJZ?=
 =?utf-8?B?bGx4STJ2RGJOSWEwTC9jNDVPYUw2V1Y5eVlBSlU3L2tHK3F0MklmQkhDakty?=
 =?utf-8?B?eEI1bkZvZnd5d2xvdFZ6RlZVUldxNzZQUFZwb283UWdoN0pqcDQyTlppK3hM?=
 =?utf-8?B?R0FrV0dZNjZSRGh0OGFGWVdNK2UxUndlU2hVUkg5MEpza1Q0aVlkNGhmamhn?=
 =?utf-8?B?czIxcHZuVVc0S0t2Mm1sUlJ2ZVNTQXFzWXd2dWY4NHptYllNc1Y0d2NvWUl5?=
 =?utf-8?B?NjkydkRYNklNNkR5NWJHM0Y0U2FTRUNTOWJSQ0E1d21xakFBWEdrN3g3WHEv?=
 =?utf-8?B?dzFMbHUvVjJUZGN1T2dEQnlMTEYvOTdxN25HRUFMNEF4Qk1WRkhpU09tMUls?=
 =?utf-8?B?cDdDNU1QdUJsMWtFNy9yMmhnenhzaEtYT2phenYvbklWQ2JBK2VmbnRPUWhy?=
 =?utf-8?B?K0dZMC9aT24wSzZVdkp0UFB2WU8zYlo0UVVtR3E0WGRPdkJwWXdoRW9Fdnlm?=
 =?utf-8?B?VktJZUkyWDZRR2NVeHRIN0dRUmtOa3lMSzZhb1V6TnlQYkZXVzByWGpBRzg0?=
 =?utf-8?B?YTBhZWRnRDVSNHREa1V0azZlUXAya2twR0lYUlluQW1kQ2lqMVcveFdaL21S?=
 =?utf-8?B?S2xnYUJXMm5BOFZLb3JnSVVUTzNLZ0ZOUWZvZVU5NXpHQ1BpcTkvZXJzWmlt?=
 =?utf-8?B?dU5EeGhWbGpUTG9ZeXpFYjFiWms2TXFMbVVzWWIxSENtMGw5ZXFEVlNIakpJ?=
 =?utf-8?B?MWQ4WGVRV0NyOSs0OWJqampKYmw0VEs5L2owZmYwcE9XbmF1NjNZUy9HNXg1?=
 =?utf-8?B?WHl3cHhjWDVXQ084Ykw1MkFyR0RDWjlZZEE1elliSFB4TlgyZTc4RDgyejdu?=
 =?utf-8?B?WUlzWkNZcEJyNG8vRHJwemlLUGZzZ1BpVS92ZHRMaUZ0UXlIaWdSMmIxUVpv?=
 =?utf-8?B?VjFOZkdmZEUwclE2NlJRZlo2eitqSGtJT2JDNkJkMlpoYk91QThKTXMyVFN1?=
 =?utf-8?B?UHBXWHA0NkR6aTBIMHY5czZrc2phYTNBUUZQQWEvNUtPZGltMUtuemJtSkV1?=
 =?utf-8?B?Y3V0WWJDS2o5ZnJIVkNIZUZ4ZVRjZ1ZQNjhxTSt3UEVuNXNqYlRobEV3Nml2?=
 =?utf-8?Q?bWa0lHP7UkbAH?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-c3e7a.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: e5d42b70-1bd9-4468-a1d1-08df33d6e0d0
X-MS-Exchange-CrossTenant-AuthSource: TYZPR04MB7491.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 03:03:30.4375 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB7577
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


On 10/27/2026 10:37 AM, Wang Yechao wrote:
> MMU_USER_IDX is defined as 3, but the RISC-V user-mode MMU index
> is MMUIdx_U, which is 0. This macro is used by the generic
> cpu_mmu_index() for CONFIG_USER_ONLY builds and must match
> riscv_env_mmu_index(), so fix the value to 0.
>
> Fixes: dc5bd18fa572 ("RISC-V CPU Core Definition")
> Signed-off-by: Wang Yechao <wang.yechao255@zte.com.cn>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>

Thanks,
Nutty
> ---
> Changes in v3:
> - Keep the MMU_USER_IDX macro because cpu_mmu_index() needs it.
> - Link to v2: https://lore.kernel.org/qemu-devel/20261026031144.631964-1-wang.yechao255@zte.com.cn/
>
> Changes in v2:
> - Adjust the patch descriptions and rebased on riscv-to-apply.next.
> - Link to v1: https://lore.kernel.org/qemu-devel/20260107161336108RbvgIEJ1pww_fKZtMreFp@zte.com.cn/
>
>   target/riscv/cpu.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index b65d631994..aaf16231de 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -180,7 +180,7 @@ extern RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[];
>   
>   #define RISCV_IMPLIED_EXTS_RULE_END -1
>   
> -#define MMU_USER_IDX 3
> +#define MMU_USER_IDX 0   /* MMUIdx_U */
>   
>   #if !defined(CONFIG_USER_ONLY)
>   #include "tcg/pmp.h"

