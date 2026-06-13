Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DC15CD98D2
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2026 06:02:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYHQs-0001A4-64; Sat, 13 Jun 2026 02:01:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1wYHQq-00019d-8N; Sat, 13 Jun 2026 02:01:24 -0400
Received: from mail-japaneastazolkn190120002.outbound.protection.outlook.com
 ([2a01:111:f403:d405::2] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1wYHQl-0003oU-WF; Sat, 13 Jun 2026 02:01:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h5OrggSjLy5qPqtSoOJIba6AVyLtpe39+wmPXMuNLZeakoQNNZWLBaxVlOtMGGdeNuXvbYd4nw2zSL/EYNre7Knthyv29cpRMPxvm1uZfRK5Jc6ay2ApWtFU0f2hwnkz4dPlRHnMVGKcf4F/JGDZJFWq7nJoKkn5AdM7AqgqwGS4enxm6aVuaQBc9MWeMxaeFwkzHD+6xmCU/kNlLuPAcKRvVClNwGSkYK2u8EB8ZNPl70Yq2sXZb339o5c081biOmMa2PfqShR/8iBWODbmFXnZnHz4m3oQWhrMpNorMb/wI8m5J+4iTB6V+BSP+VtJdwZL8cBOsjiMtEHn48qnpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PmagRrx8mpI685jW3lSedJUlRZ7rk+5hNKGT+jMJJds=;
 b=eTPUq0dfi4cy+tstt/13NWL8sULwy1YhHqETrlkJZi8flmkTHRNrhk8MljCv+FsNqKt+uQzkw/Wkxwqq4n54r4rMR3BbBJSoHZ7z5td73ZjXE4FcY1IVJSURFFjtBJzEJEchXN0JvCqIursYdDqfhIgfUgedzniVLE4yCf6+HyRylMhH4/ISccJcT+knnlUTtyfm7HoOpqd/ja1vJAISMeDowHjUNY4K+EKJdkNQzkPlzYoCkocDTMgnnWM5NzalSmNKG/0M7RMWPseZsiZK5tBeYYkW/m0toF7uAgwTTNCbby0bxhfr+0Y2an03Qdwgny263F7ghVC4TVbpUZLvVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PmagRrx8mpI685jW3lSedJUlRZ7rk+5hNKGT+jMJJds=;
 b=LNVdi6AVkgKPEfpQQsPfDg5oQ5hkqtJER10s8R05lsdrI7xeXPrab5R/XRl0694CnP6BFCkn/Meq+ysup5Ed9T8ym43bh3IFngM5igFaMbYceFR7AcSmGBPwMxBY05aPKnkB43X/2cMgxMVOSWfIgI0JYbeFOfhBcZG8qbLdooLcTrtoFd2HevpYEg1+/DknGAKtFCD+ux+ALe/IA1AamVg1cvauFa2U2tSuQDre8ZeNqtovO4ez2sDEqC6cqYfMJkq9vZXpeiv2RvFhFKpSGqPlrAPLF9DTbIODQnrsU8ytHr9Jc5FnsK0NYR/wmc7h9xUR/FojdEhmrWxKhBP6uQ==
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com (2603:1096:101:2e9::7)
 by OSNPR04MB9742.apcprd04.prod.outlook.com (2603:1096:604:484::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.15; Sat, 13 Jun
 2026 06:01:13 +0000
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58]) by SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58%6]) with mapi id 15.21.0113.014; Sat, 13 Jun 2026
 06:01:13 +0000
Message-ID: <SE3PR04MB8922EBFEB18948A8C272137CF3192@SE3PR04MB8922.apcprd04.prod.outlook.com>
Date: Sat, 13 Jun 2026 14:01:06 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/5] hw/riscv: add k230 board initial support
To: Chao Liu <chao.liu@processmission.com>,
 Alistair Francis <alistair.francis@wdc.com>
Cc: Chao Liu <chao.liu.zevorn@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Christoph Muellner <christoph.muellner@vrull.eu>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Peng Jiang <3160104094@zju.edu.cn>
References: <cover.1781246408.git.chao.liu@processmission.com>
 <a161697a249b896e44e2748435f6c0caec12c9f4.1781246408.git.chao.liu@processmission.com>
Content-Language: en-US
From: "Nutty.Liu" <nutty.liu@hotmail.com>
In-Reply-To: <a161697a249b896e44e2748435f6c0caec12c9f4.1781246408.git.chao.liu@processmission.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0034.apcprd02.prod.outlook.com
 (2603:1096:4:195::9) To SE3PR04MB8922.apcprd04.prod.outlook.com
 (2603:1096:101:2e9::7)
X-Microsoft-Original-Message-ID: <495467df-37f9-4763-8dfb-47fc6f2d7d9f@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SE3PR04MB8922:EE_|OSNPR04MB9742:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b1c9189-3625-47cf-351b-08dec9112c2d
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|23021999003|19101099003|41001999006|19110799012|12121999013|6090799003|15080799012|5072599009|8060799015|51005399006|10035399007|3412199025|4302099013|440099028|12091999003|40105399003|1602099012;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ckRTWk9FODdWeG9Hbkl4VUExWnU3NmhzaXpJS0FoV0xzbDY2OGRFaE5FV2ZU?=
 =?utf-8?B?M3VLUFlVUlduS3c3K0UrZXhSUzlaL0p6NlllUkgvK2VMcUhKcEhXRnRTKzRP?=
 =?utf-8?B?eG9aWEV5eGV5L21NV0Uwalo5MERYUVhTV0lubFgvODNrSTBtYmoxaldCUHh3?=
 =?utf-8?B?WXpLRGpzOVBVUXF6ajE5Sm1TK2VTT2hpSDU0RXhTellDK0dCME1GOEtHcjdR?=
 =?utf-8?B?UjQ2emhZdnVnRWlhMFppdUdVK2l4aGZuSWJGeDMwRk40ajhMY2FabXBHSHdq?=
 =?utf-8?B?MGhpdFk1bHBSYTdBSHo5Y0I0WVN1eEd1OE42Qm40WkpQazZsN3c4UFRKVGw0?=
 =?utf-8?B?c1NqUTV6VlVDN05ud0FjWFZSMkNjcUkzVkVCajluNE1NRUlPbURLd2txUlJo?=
 =?utf-8?B?UFkxZWVMeHdnL2d6c1dGbTNBOWlYTElwSzM0YzNEenRBNFJqdXA3ZUorY3BT?=
 =?utf-8?B?LytXNklvL296cXZ4OVlsNjNqRncrY21oVTVNbm5ZdXZidjZZTkZubFloZUhF?=
 =?utf-8?B?ajQ2Q24wc3JIbWt0bENDL09haSsxV1JjNWJVMGM5UjdlbW9penBmZmZFR2NI?=
 =?utf-8?B?WklZTnhQWitWYzNZUWFXTnlaZHBma291czBvN3lKc1JPL3h2YWZ0eWhUTVRD?=
 =?utf-8?B?ZVErUno2V01RMGtsVWFqSEZubUlYZzVYUGR5RGQwSEtGQk92emFCRFNHUmdJ?=
 =?utf-8?B?dmZ2VUo1SHFEdHpna29ValdiNTlSeEd0MjdzcU51L0RIL3NueGlMRzBOMWhr?=
 =?utf-8?B?ZEFRUEZVaDYxTkVtZDNJallyYVZrTEdycWtiRmRYV2lJNDNjY3VSU2s1MzA2?=
 =?utf-8?B?QWNsNEptTUkzNkUrakc5WVl1a003bFlZY3JZZmNaaEl2d2kzb2lqUzR3UDlj?=
 =?utf-8?B?RWtKUXlMcWRaNWtseDdPdTMxaGJvK1lHSzZSL2FJUTRxR3VOTm1hRDlJVklV?=
 =?utf-8?B?VU5scUFrS1IvVy9TcStZT2FPbkpYQUFGeHZJbDI3eWkvdTJtNStJeTZqVmlZ?=
 =?utf-8?B?eCs4T0ZTZk9iQ0duS0t4VldRWkpXMGZmTHdMeW5iS252dW01S3k3ZWFaV2xQ?=
 =?utf-8?B?VkVzZlJrR045SlZxUmdHN3VjUzdDaERrakdzT2oxWXRpWDZ2WWh5b0FVNTEr?=
 =?utf-8?B?c1R5NlVxN25CVGd4eXVmcE95VUtQUTVrdWRENTk0QlV1NkZVTC82bWFZM1Rs?=
 =?utf-8?B?Yk1sNktQdURCbTJhaEVSTm9jVE5oT1ZPeUlUalhLZi9rQWxZWmxzWkFhOHZ0?=
 =?utf-8?B?V215citvSTBJbVRMdi92K0Y0K1lIbjQ0WVBwTThpZDRsZHd5TmJsMVluOWtZ?=
 =?utf-8?B?YTRYTnVQaUVFNnNsd1JpL0RsOXhEWTRla0VLMFRBS0Z4VFhmN1BqZ3YxS0R6?=
 =?utf-8?B?NTNFaE16WFM3Q2JnWnlmNzJoK2tCZ1FubGNwaTlPZGVrTk90cVNtRCt6dEs4?=
 =?utf-8?B?RHVBUVIyOUdKZjhSYUlOSmVwS2U2c2I0Tnd5SnUvajZucHNWQzQzaFlOSDVu?=
 =?utf-8?Q?FI7JHA=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cnBQM3MyUmt6bWp0SU9xaUxiZFJwWFdyLzVpb1owRituKzlKM1VHVksxTWE4?=
 =?utf-8?B?UHo4TjNiNzFFMENjNDJlNnFDMGdta283ZmZaUmM2V29SMjk2emJOTXRJcUVi?=
 =?utf-8?B?Qy9USXYxWU5zT21iRmYybXdkSVlpRVhwVDl6NnlOeVRJMW9xMTNYQjhFN29J?=
 =?utf-8?B?d2s0WmNuZHVkblpENjE3R1lmMi9na2xOYVNLano5NlJHQWk2M0c0c2M5MC9L?=
 =?utf-8?B?OTRyMFFtQ2twN3JrMDA3VGRHZG5jTy93UlZuZzhqbDlZZUhVdTh5V3E4Z0ZB?=
 =?utf-8?B?WkZjMEU0OVE1bHhIM0RRTDVidWdiVWtlSVZ6VU9MVm9hN280VnEyVlQvMmQ2?=
 =?utf-8?B?cmo3azhMNVNSNU9DelFSaHpxNVdDN1dIK3BGb21qcGRKZjVldWIxellKY1Bt?=
 =?utf-8?B?OHdSeENYN3ZpcUl3Wk0rTmFNTGdqNTUvbE5ZUGJsSDVYZGMreXMwdllJUUNs?=
 =?utf-8?B?VHFwNUdNUnluNVZHbE1yZ1VJSzNMa2dZOGVNVHRJUDJCMTZDUGlwcEtMUUVx?=
 =?utf-8?B?THVRSmtxVG5SNDhtVFZCaHR4ajlzdHo1RElSRk9PK1p4Q0tWTGxGMDh0ZG5W?=
 =?utf-8?B?aEZYSzFqcFFpcHJZVWFuOXk2amRZaHVqbDNDSFI4emViMTNPK1VCZm52SEhz?=
 =?utf-8?B?ZFRIN0lkdWFsSEJER2JUWnc4YVZLYklRV1VZd0UrM2xMWEhFNWxBY05LV3Z6?=
 =?utf-8?B?djlsS0NaSHpZNjRITDRVZU1IY2Z0NGpPWTB5QStaTFVKQjBib0w1eUNwUkpi?=
 =?utf-8?B?bXdaTDQrZTBWNTllWWVtZlZaUUZlWHBVZE8zWmlBNGFNdC9QVXlneEFpQkE2?=
 =?utf-8?B?VEVhalEwbDlCL2NmcUl4QmhCWnNXaUJOSk5BK09RcnUrRGhpN0E2NUx3NkxF?=
 =?utf-8?B?ejZ4elJrMnZsTmZVOGFVamF5aWN2b3pUNDVQWUZObVpGOTZQNEpqdGhRemNU?=
 =?utf-8?B?MXpVdTFkTUU1YnJsem1NcjFuQzZXaFRmZ3NIdG5ONDhvYzVCYWFnWTdUM0Y5?=
 =?utf-8?B?ZitYUXNFMUhodklkem1zczJWeTRabjZHVHg3VU16UlBmWnhJTnlUaFQ1TTFa?=
 =?utf-8?B?ek9ObkN6SlBQRGNNNTlFajE3NTF3QnpwVlZaOUZIVkJTWjlvL0dvUGJabXRl?=
 =?utf-8?B?dDh1UkRlVUlRN1p2T2k0NnAra0N5bHhZeFZXUm5DRDdST2xqWVhBaXBPVTR0?=
 =?utf-8?B?d2tpQlpEblV4N2xvaDBjcGxOT1JmSHN3emJybklSNzFYanBPMC92OUxlMHR1?=
 =?utf-8?B?bXVRMWpSNEpHa3RPcFU1ZWhQNVRoZjY5WkdmdXduM3pSQ0NPaXFMclhVeFNm?=
 =?utf-8?B?eXUzTmJIMjdubCt0MTJsVEVRT2xGZ3ZGeENGZ1grWWhtWkZGMHMyZEUzZ2R3?=
 =?utf-8?B?bi9kM1Y2dTJueVJuMXY1Zm5icVBHWVpkOEFGQ0J4SnZwRm9aM3h5aEhRaUI2?=
 =?utf-8?B?UUhuVGdLb2kwUjdhY1F1eHhDU01xOXVnT1p3M05LTm14L2FYdjlWbWZvVHBW?=
 =?utf-8?B?TUtuQk90R2xPVUlnbEJpdk0wTmZhQnpabjZZMVRpSDRNUDE2dHVBWDJOd2ZD?=
 =?utf-8?B?eGUreURremlMVUNONEhVd1FJMWN6MDFkd3pxd3RaZEFmN3h2OXFMZ0VjUWV4?=
 =?utf-8?B?aWlraVh0T3EzQ2NOYThXNzBTOTBZc0FpcVowNFZjNUVOWVp0ODhadkFzYW5u?=
 =?utf-8?B?ZlFXdzZpSkJHd1Z3RDhOQ21PVW5XeUp5TGd3M2pETHRNU09EMXo4SmFuZ3hB?=
 =?utf-8?B?OVZtUGxpNGxNaTJaMmdFR0tpQy9uMFVrMUJqYlkxejZ3R1FpaStnUUkvQTdK?=
 =?utf-8?B?ZmZmN21EZmdnWlBDazk1NkVWdFlXY3dYQ3VUcWdVQ1NqR1E5U3FsRExJYVl1?=
 =?utf-8?Q?R2sWlhzGOi24w?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-c3e7a.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b1c9189-3625-47cf-351b-08dec9112c2d
X-MS-Exchange-CrossTenant-AuthSource: SE3PR04MB8922.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2026 06:01:12.9379 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSNPR04MB9742
Received-SPF: pass client-ip=2a01:111:f403:d405::2;
 envelope-from=nutty.liu@hotmail.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


On 6/12/2026 3:04 PM, Chao Liu wrote:
> From: Chao Liu <chao.liu.zevorn@gmail.com>
>
> K230 Board compatible with Kendryte K230 SDK.
>
> Preliminarily supports the C908 small core, which can run U-Boot and
> Linux kernels compiled by the K230 SDK.
>
> The K230 boot flow provides its device tree from firmware or software.
> QEMU does not generate a K230 DTB; users can pass one with -dtb for
> direct Linux boot, or rely on firmware/kernel built-in DTB for other
> payloads.
>
> Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
> Tested-by: Peng Jiang <3160104094@zju.edu.cn>
> Acked-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>

Thanks,
Nutty
> ---
>   MAINTAINERS             |   7 +
>   hw/riscv/Kconfig        |  10 +
>   hw/riscv/k230.c         | 508 ++++++++++++++++++++++++++++++++++++++++
>   hw/riscv/meson.build    |   2 +-
>   include/hw/riscv/k230.h | 145 ++++++++++++
>   5 files changed, 671 insertions(+), 1 deletion(-)
>   create mode 100644 hw/riscv/k230.c
>   create mode 100644 include/hw/riscv/k230.h
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2b5b581e17..a21796ac6f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1786,6 +1786,13 @@ F: docs/system/riscv/xiangshan-kunminghu.rst
>   F: hw/riscv/xiangshan_kmh.c
>   F: include/hw/riscv/xiangshan_kmh.h
>   
> +K230 Machines
> +M: Chao Liu <chao.liu.zevorn@gmail.com>
> +L: qemu-riscv@nongnu.org
> +S: Maintained
> +F: hw/riscv/k230.c
> +F: include/hw/riscv/k230.h
> +
>   RX Machines
>   -----------
>   rx-gdbsim
> diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
> index 2518b04175..f512ed65ac 100644
> --- a/hw/riscv/Kconfig
> +++ b/hw/riscv/Kconfig
> @@ -138,3 +138,13 @@ config MIPS_BOSTON_AIA
>       select RISCV_MIPS_CMGCR
>       select RISCV_MIPS_CPC
>       select RISCV_MIPS_CPS
> +
> +config K230
> +    bool
> +    default y
> +    depends on RISCV64
> +    select RISCV_ACLINT
> +    select RISCV_APLIC
> +    select RISCV_IMSIC
> +    select SERIAL_MM
> +    select UNIMP
> diff --git a/hw/riscv/k230.c b/hw/riscv/k230.c
> new file mode 100644
> index 0000000000..26d1e20c99
> --- /dev/null
> +++ b/hw/riscv/k230.c
> @@ -0,0 +1,508 @@
> +/*
> + * QEMU RISC-V Virt Board Compatible with Kendryte K230 SDK
> + *
> + * Copyright (c) 2025 Chao Liu <chao.liu.zevorn@gmail.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * Provides a board compatible with the Kendryte K230 SDK
> + *
> + * K230 Technical Reference Manual V0.3.1 (2024-11-18):
> + * https://github.com/revyos/external-docs/blob/master/K230/en-us/K230_Technical_Reference_Manual_V0.3.1_20241118.pdf
> + *
> + * For more information, see <https://www.kendryte.com/en/proDetail/230>
> + */
> +
> +#include "qemu/osdep.h"
> +#include "cpu-qom.h"
> +#include "qemu/cutils.h"
> +#include "qemu/error-report.h"
> +#include "qapi/error.h"
> +#include "system/device_tree.h"
> +#include "system/system.h"
> +#include "system/memory.h"
> +#include "target/riscv/cpu.h"
> +#include "hw/core/loader.h"
> +#include "hw/core/sysbus.h"
> +#include "hw/riscv/k230.h"
> +#include "hw/riscv/boot.h"
> +#include "hw/riscv/machines-qom.h"
> +#include "hw/intc/riscv_aclint.h"
> +#include "hw/intc/sifive_plic.h"
> +#include "hw/char/serial-mm.h"
> +#include "hw/misc/unimp.h"
> +
> +/* Align K230_SDK k230_canmv_defconfig */
> +#define K230_DIRECT_OPENSBI_ADDR 0x8000000
> +#define K230_DIRECT_KERNEL_ADDR  0x8200000
> +#define K230_DIRECT_DTB_ADDR     0xa000000
> +
> +static const MemMapEntry memmap[] = {
> +    [K230_DEV_DDRC] =         { 0x00000000,  0x80000000 },
> +    [K230_DEV_KPU_L2_CACHE] = { 0x80000000,  0x00200000 },
> +    [K230_DEV_SRAM] =         { 0x80200000,  0x00200000 },
> +    [K230_DEV_KPU_CFG] =      { 0x80400000,  0x00000800 },
> +    [K230_DEV_FFT] =          { 0x80400800,  0x00000400 },
> +    [K230_DEV_AI_2D_ENGINE] = { 0x80400C00,  0x00000800 },
> +    [K230_DEV_GSDMA] =        { 0x80800000,  0x00004000 },
> +    [K230_DEV_DMA] =          { 0x80804000,  0x00004000 },
> +    [K230_DEV_DECOMP_GZIP] =  { 0x80808000,  0x00004000 },
> +    [K230_DEV_NON_AI_2D] =    { 0x8080C000,  0x00004000 },
> +    [K230_DEV_ISP] =          { 0x90000000,  0x00008000 },
> +    [K230_DEV_DEWARP] =       { 0x90008000,  0x00001000 },
> +    [K230_DEV_RX_CSI] =       { 0x90009000,  0x00002000 },
> +    [K230_DEV_H264] =         { 0x90400000,  0x00010000 },
> +    [K230_DEV_2P5D] =         { 0x90800000,  0x00040000 },
> +    [K230_DEV_VO] =           { 0x90840000,  0x00010000 },
> +    [K230_DEV_VO_CFG] =       { 0x90850000,  0x00001000 },
> +    [K230_DEV_3D_ENGINE] =    { 0x90A00000,  0x00000800 },
> +    [K230_DEV_PMU] =          { 0x91000000,  0x00000C00 },
> +    [K230_DEV_RTC] =          { 0x91000C00,  0x00000400 },
> +    [K230_DEV_CMU] =          { 0x91100000,  0x00001000 },
> +    [K230_DEV_RMU] =          { 0x91101000,  0x00001000 },
> +    [K230_DEV_BOOT] =         { 0x91102000,  0x00001000 },
> +    [K230_DEV_PWR] =          { 0x91103000,  0x00001000 },
> +    [K230_DEV_MAILBOX] =      { 0x91104000,  0x00001000 },
> +    [K230_DEV_IOMUX] =        { 0x91105000,  0x00000800 },
> +    [K230_DEV_TIMER] =        { 0x91105800,  0x00000800 },
> +    [K230_DEV_WDT0] =         { 0x91106000,  0x00000800 },
> +    [K230_DEV_WDT1] =         { 0x91106800,  0x00000800 },
> +    [K230_DEV_TS] =           { 0x91107000,  0x00000800 },
> +    [K230_DEV_HDI] =          { 0x91107800,  0x00000800 },
> +    [K230_DEV_STC] =          { 0x91108000,  0x00000800 },
> +    [K230_DEV_BOOTROM] =      { 0x91200000,  0x00010000 },
> +    [K230_DEV_SECURITY] =     { 0x91210000,  0x00008000 },
> +    [K230_DEV_UART0] =        { 0x91400000,  0x00001000 },
> +    [K230_DEV_UART1] =        { 0x91401000,  0x00001000 },
> +    [K230_DEV_UART2] =        { 0x91402000,  0x00001000 },
> +    [K230_DEV_UART3] =        { 0x91403000,  0x00001000 },
> +    [K230_DEV_UART4] =        { 0x91404000,  0x00001000 },
> +    [K230_DEV_I2C0] =         { 0x91405000,  0x00001000 },
> +    [K230_DEV_I2C1] =         { 0x91406000,  0x00001000 },
> +    [K230_DEV_I2C2] =         { 0x91407000,  0x00001000 },
> +    [K230_DEV_I2C3] =         { 0x91408000,  0x00001000 },
> +    [K230_DEV_I2C4] =         { 0x91409000,  0x00001000 },
> +    [K230_DEV_PWM] =          { 0x9140A000,  0x00001000 },
> +    [K230_DEV_GPIO0] =        { 0x9140B000,  0x00001000 },
> +    [K230_DEV_GPIO1] =        { 0x9140C000,  0x00001000 },
> +    [K230_DEV_ADC] =          { 0x9140D000,  0x00001000 },
> +    [K230_DEV_CODEC] =        { 0x9140E000,  0x00001000 },
> +    [K230_DEV_I2S] =          { 0x9140F000,  0x00001000 },
> +    [K230_DEV_USB0] =         { 0x91500000,  0x00010000 },
> +    [K230_DEV_USB1] =         { 0x91540000,  0x00010000 },
> +    [K230_DEV_SD0] =          { 0x91580000,  0x00001000 },
> +    [K230_DEV_SD1] =          { 0x91581000,  0x00001000 },
> +    [K230_DEV_QSPI0] =        { 0x91582000,  0x00001000 },
> +    [K230_DEV_QSPI1] =        { 0x91583000,  0x00001000 },
> +    [K230_DEV_SPI] =          { 0x91584000,  0x00001000 },
> +    [K230_DEV_HI_SYS_CFG] =   { 0x91585000,  0x00000400 },
> +    [K230_DEV_DDRC_CFG] =     { 0x98000000,  0x02000000 },
> +    [K230_DEV_FLASH] =        { 0xC0000000,  0x08000000 },
> +    [K230_DEV_PLIC] =         { 0xF00000000, 0x00400000 },
> +    [K230_DEV_CLINT] =        { 0xF04000000, 0x00400000 },
> +};
> +
> +static void k230_soc_init(Object *obj)
> +{
> +    K230SoCState *s = RISCV_K230_SOC(obj);
> +    RISCVHartArrayState *cpu0 = &s->c908_cpu;
> +
> +    object_initialize_child(obj, "c908-cpu", cpu0, TYPE_RISCV_HART_ARRAY);
> +    qdev_prop_set_uint32(DEVICE(cpu0), "hartid-base", 0);
> +    qdev_prop_set_string(DEVICE(cpu0), "cpu-type", TYPE_RISCV_CPU_THEAD_C908);
> +    qdev_prop_set_uint64(DEVICE(cpu0), "resetvec",
> +                         memmap[K230_DEV_BOOTROM].base);
> +}
> +
> +static DeviceState *k230_create_plic(int base_hartid, int hartid_count)
> +{
> +    g_autofree char *plic_hart_config = NULL;
> +
> +    /* Per-socket PLIC hart topology configuration string */
> +    plic_hart_config = riscv_plic_hart_config_string(hartid_count);
> +
> +    /* Per-socket PLIC */
> +    return sifive_plic_create(memmap[K230_DEV_PLIC].base,
> +                              plic_hart_config, hartid_count, base_hartid,
> +                              K230_PLIC_NUM_SOURCES,
> +                              K230_PLIC_NUM_PRIORITIES,
> +                              K230_PLIC_PRIORITY_BASE, K230_PLIC_PENDING_BASE,
> +                              K230_PLIC_ENABLE_BASE, K230_PLIC_ENABLE_STRIDE,
> +                              K230_PLIC_CONTEXT_BASE,
> +                              K230_PLIC_CONTEXT_STRIDE,
> +                              memmap[K230_DEV_PLIC].size);
> +}
> +
> +static void k230_create_uart(MemoryRegion *sys_mem, DeviceState *plic,
> +                             int index)
> +{
> +    int uart_dev = K230_DEV_UART0 + index;
> +    g_autofree char *name = g_strdup_printf("uart%d", index);
> +
> +    /* Cover the non-16550 part of the SDK's 0x1000 UART window. */
> +    create_unimplemented_device(name, memmap[uart_dev].base,
> +                                memmap[uart_dev].size);
> +
> +    serial_mm_init(sys_mem, memmap[uart_dev].base, 2,
> +                   qdev_get_gpio_in(plic, K230_UART0_IRQ + index),
> +                   399193, serial_hd(index), DEVICE_LITTLE_ENDIAN);
> +}
> +
> +static void k230_soc_realize(DeviceState *dev, Error **errp)
> +{
> +    K230SoCState *s = RISCV_K230_SOC(dev);
> +    MemoryRegion *sys_mem = get_system_memory();
> +    int c908_cpus;
> +
> +    sysbus_realize(SYS_BUS_DEVICE(&s->c908_cpu), &error_fatal);
> +
> +    c908_cpus = s->c908_cpu.num_harts;
> +
> +    /* SRAM */
> +    memory_region_init_ram(&s->sram, OBJECT(dev), "sram",
> +                           memmap[K230_DEV_SRAM].size, &error_fatal);
> +    memory_region_add_subregion(sys_mem, memmap[K230_DEV_SRAM].base,
> +                                &s->sram);
> +
> +    /* BootROM */
> +    memory_region_init_rom(&s->bootrom, OBJECT(dev), "bootrom",
> +                           memmap[K230_DEV_BOOTROM].size, &error_fatal);
> +    memory_region_add_subregion(sys_mem, memmap[K230_DEV_BOOTROM].base,
> +                                &s->bootrom);
> +
> +    /* PLIC */
> +    s->c908_plic = k230_create_plic(C908_CPU_HARTID, c908_cpus);
> +
> +    /* CLINT */
> +    riscv_aclint_swi_create(memmap[K230_DEV_CLINT].base,
> +                            C908_CPU_HARTID, c908_cpus, false);
> +    riscv_aclint_mtimer_create(memmap[K230_DEV_CLINT].base + 0x4000,
> +                               RISCV_ACLINT_DEFAULT_MTIMER_SIZE,
> +                               C908_CPU_HARTID, c908_cpus,
> +                               RISCV_ACLINT_DEFAULT_MTIMECMP,
> +                               RISCV_ACLINT_DEFAULT_MTIME,
> +                               RISCV_ACLINT_DEFAULT_TIMEBASE_FREQ, true);
> +
> +    /* UART */
> +    for (int i = 0; i < K230_UART_COUNT; i++) {
> +        k230_create_uart(sys_mem, DEVICE(s->c908_plic), i);
> +    }
> +
> +    /* unimplemented devices */
> +    create_unimplemented_device("kpu.l2-cache",
> +                                memmap[K230_DEV_KPU_L2_CACHE].base,
> +                                memmap[K230_DEV_KPU_L2_CACHE].size);
> +
> +    create_unimplemented_device("kpu_cfg", memmap[K230_DEV_KPU_CFG].base,
> +                                memmap[K230_DEV_KPU_CFG].size);
> +
> +    create_unimplemented_device("fft", memmap[K230_DEV_FFT].base,
> +                                memmap[K230_DEV_FFT].size);
> +
> +    create_unimplemented_device("2d-engine.ai",
> +                                memmap[K230_DEV_AI_2D_ENGINE].base,
> +                                memmap[K230_DEV_AI_2D_ENGINE].size);
> +
> +    create_unimplemented_device("gsdma", memmap[K230_DEV_GSDMA].base,
> +                                memmap[K230_DEV_GSDMA].size);
> +
> +    create_unimplemented_device("dma", memmap[K230_DEV_DMA].base,
> +                                memmap[K230_DEV_DMA].size);
> +
> +    create_unimplemented_device("decomp-gzip",
> +                                memmap[K230_DEV_DECOMP_GZIP].base,
> +                                memmap[K230_DEV_DECOMP_GZIP].size);
> +
> +    create_unimplemented_device("2d-engine.non-ai",
> +                                memmap[K230_DEV_NON_AI_2D].base,
> +                                memmap[K230_DEV_NON_AI_2D].size);
> +
> +    create_unimplemented_device("isp", memmap[K230_DEV_ISP].base,
> +                                memmap[K230_DEV_ISP].size);
> +
> +    create_unimplemented_device("dewarp", memmap[K230_DEV_DEWARP].base,
> +                                memmap[K230_DEV_DEWARP].size);
> +
> +    create_unimplemented_device("rx-csi", memmap[K230_DEV_RX_CSI].base,
> +                                memmap[K230_DEV_RX_CSI].size);
> +
> +    create_unimplemented_device("vpu", memmap[K230_DEV_H264].base,
> +                                memmap[K230_DEV_H264].size);
> +
> +    create_unimplemented_device("gpu", memmap[K230_DEV_2P5D].base,
> +                                memmap[K230_DEV_2P5D].size);
> +
> +    create_unimplemented_device("vo", memmap[K230_DEV_VO].base,
> +                                memmap[K230_DEV_VO].size);
> +
> +    create_unimplemented_device("vo_cfg", memmap[K230_DEV_VO_CFG].base,
> +                                memmap[K230_DEV_VO_CFG].size);
> +
> +    create_unimplemented_device("3d-engine", memmap[K230_DEV_3D_ENGINE].base,
> +                                memmap[K230_DEV_3D_ENGINE].size);
> +
> +    create_unimplemented_device("pmu", memmap[K230_DEV_PMU].base,
> +                                memmap[K230_DEV_PMU].size);
> +
> +    create_unimplemented_device("rtc", memmap[K230_DEV_RTC].base,
> +                                memmap[K230_DEV_RTC].size);
> +
> +    create_unimplemented_device("cmu", memmap[K230_DEV_CMU].base,
> +                                memmap[K230_DEV_CMU].size);
> +
> +    create_unimplemented_device("rmu", memmap[K230_DEV_RMU].base,
> +                                memmap[K230_DEV_RMU].size);
> +
> +    create_unimplemented_device("boot", memmap[K230_DEV_BOOT].base,
> +                                memmap[K230_DEV_BOOT].size);
> +
> +    create_unimplemented_device("pwr", memmap[K230_DEV_PWR].base,
> +                                memmap[K230_DEV_PWR].size);
> +
> +    create_unimplemented_device("ipcm", memmap[K230_DEV_MAILBOX].base,
> +                                memmap[K230_DEV_MAILBOX].size);
> +
> +    create_unimplemented_device("iomux", memmap[K230_DEV_IOMUX].base,
> +                                memmap[K230_DEV_IOMUX].size);
> +
> +    create_unimplemented_device("timer", memmap[K230_DEV_TIMER].base,
> +                                memmap[K230_DEV_TIMER].size);
> +
> +    create_unimplemented_device("wdt0", memmap[K230_DEV_WDT0].base,
> +                                memmap[K230_DEV_WDT0].size);
> +
> +    create_unimplemented_device("wdt1", memmap[K230_DEV_WDT1].base,
> +                                memmap[K230_DEV_WDT1].size);
> +
> +    create_unimplemented_device("ts", memmap[K230_DEV_TS].base,
> +                                memmap[K230_DEV_TS].size);
> +
> +    create_unimplemented_device("hdi", memmap[K230_DEV_HDI].base,
> +                                memmap[K230_DEV_HDI].size);
> +
> +    create_unimplemented_device("stc", memmap[K230_DEV_STC].base,
> +                                memmap[K230_DEV_STC].size);
> +
> +    create_unimplemented_device("security", memmap[K230_DEV_SECURITY].base,
> +                                memmap[K230_DEV_SECURITY].size);
> +
> +    create_unimplemented_device("i2c0", memmap[K230_DEV_I2C0].base,
> +                                memmap[K230_DEV_I2C0].size);
> +
> +    create_unimplemented_device("i2c1", memmap[K230_DEV_I2C1].base,
> +                                memmap[K230_DEV_I2C1].size);
> +
> +    create_unimplemented_device("i2c2", memmap[K230_DEV_I2C2].base,
> +                                memmap[K230_DEV_I2C2].size);
> +
> +    create_unimplemented_device("i2c3", memmap[K230_DEV_I2C3].base,
> +                                memmap[K230_DEV_I2C3].size);
> +
> +    create_unimplemented_device("i2c4", memmap[K230_DEV_I2C4].base,
> +                                memmap[K230_DEV_I2C4].size);
> +
> +    create_unimplemented_device("pwm", memmap[K230_DEV_PWM].base,
> +                                memmap[K230_DEV_PWM].size);
> +
> +    create_unimplemented_device("gpio0", memmap[K230_DEV_GPIO0].base,
> +                                memmap[K230_DEV_GPIO0].size);
> +
> +    create_unimplemented_device("gpio1", memmap[K230_DEV_GPIO1].base,
> +                                memmap[K230_DEV_GPIO1].size);
> +
> +    create_unimplemented_device("adc", memmap[K230_DEV_ADC].base,
> +                                memmap[K230_DEV_ADC].size);
> +
> +    create_unimplemented_device("codec", memmap[K230_DEV_CODEC].base,
> +                                memmap[K230_DEV_CODEC].size);
> +
> +    create_unimplemented_device("i2s", memmap[K230_DEV_I2S].base,
> +                                memmap[K230_DEV_I2S].size);
> +
> +    create_unimplemented_device("usb0", memmap[K230_DEV_USB0].base,
> +                                memmap[K230_DEV_USB0].size);
> +
> +    create_unimplemented_device("usb1", memmap[K230_DEV_USB1].base,
> +                                memmap[K230_DEV_USB1].size);
> +
> +    create_unimplemented_device("sd0", memmap[K230_DEV_SD0].base,
> +                                memmap[K230_DEV_SD0].size);
> +
> +    create_unimplemented_device("sd1", memmap[K230_DEV_SD1].base,
> +                                memmap[K230_DEV_SD1].size);
> +
> +    create_unimplemented_device("qspi0", memmap[K230_DEV_QSPI0].base,
> +                                memmap[K230_DEV_QSPI0].size);
> +
> +    create_unimplemented_device("qspi1", memmap[K230_DEV_QSPI1].base,
> +                                memmap[K230_DEV_QSPI1].size);
> +
> +    create_unimplemented_device("spi", memmap[K230_DEV_SPI].base,
> +                                memmap[K230_DEV_SPI].size);
> +
> +    create_unimplemented_device("hi_sys_cfg", memmap[K230_DEV_HI_SYS_CFG].base,
> +                                memmap[K230_DEV_HI_SYS_CFG].size);
> +
> +    create_unimplemented_device("ddrc_cfg", memmap[K230_DEV_DDRC_CFG].base,
> +                                memmap[K230_DEV_DDRC_CFG].size);
> +
> +    create_unimplemented_device("flash", memmap[K230_DEV_FLASH].base,
> +                                memmap[K230_DEV_FLASH].size);
> +}
> +
> +static void k230_soc_class_init(ObjectClass *oc, const void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(oc);
> +
> +    dc->realize = k230_soc_realize;
> +}
> +
> +static const TypeInfo k230_soc_type_info = {
> +    .name = TYPE_RISCV_K230_SOC,
> +    .parent = TYPE_DEVICE,
> +    .instance_size = sizeof(K230SoCState),
> +    .instance_init = k230_soc_init,
> +    .class_init = k230_soc_class_init,
> +};
> +
> +static void k230_soc_register_types(void)
> +{
> +    type_register_static(&k230_soc_type_info);
> +}
> +
> +type_init(k230_soc_register_types)
> +
> +static void k230_direct_boot(K230MachineState *s, MachineState *machine)
> +{
> +    const char *firmware_name = riscv_default_firmware_name(&s->soc.c908_cpu);
> +    RISCVBootInfo boot_info = {0};
> +    hwaddr start_addr = K230_DIRECT_OPENSBI_ADDR;
> +    hwaddr firmware_end_addr = 0;
> +    hwaddr kernel_entry = 0;
> +    int fdt_size = 0;
> +
> +    if (machine->firmware && !strcmp(machine->firmware, "none")) {
> +        error_report("K230 direct boot requires OpenSBI firmware; omit "
> +                     "-bios none or pass OpenSBI with -bios");
> +        exit(EXIT_FAILURE);
> +    }
> +
> +    if (!machine->dtb) {
> +        error_report("K230 direct boot requires -dtb");
> +        exit(EXIT_FAILURE);
> +    }
> +
> +    machine->fdt = load_device_tree(machine->dtb, &fdt_size);
> +    if (!machine->fdt) {
> +        error_report("load_device_tree() failed");
> +        exit(EXIT_FAILURE);
> +    }
> +
> +    qemu_fdt_add_path(machine->fdt, "/chosen");
> +
> +    riscv_boot_info_init(&boot_info, &s->soc.c908_cpu);
> +    riscv_load_kernel(machine, &boot_info, K230_DIRECT_KERNEL_ADDR, true, NULL);
> +    kernel_entry = boot_info.image_low_addr;
> +
> +    riscv_load_fdt(K230_DIRECT_DTB_ADDR, machine->fdt);
> +
> +    firmware_end_addr = riscv_find_and_load_firmware(machine, firmware_name,
> +                                                     &start_addr, NULL);
> +    if (firmware_end_addr > K230_DIRECT_KERNEL_ADDR) {
> +        error_report("K230 firmware overlaps kernel address 0x%x",
> +                     K230_DIRECT_KERNEL_ADDR);
> +        exit(EXIT_FAILURE);
> +    }
> +
> +    riscv_setup_rom_reset_vec(machine, &s->soc.c908_cpu, start_addr,
> +                              memmap[K230_DEV_BOOTROM].base,
> +                              memmap[K230_DEV_BOOTROM].size, kernel_entry,
> +                              K230_DIRECT_DTB_ADDR);
> +}
> +
> +static void k230_firmware_boot(K230MachineState *s, MachineState *machine)
> +{
> +    const char *firmware_name = riscv_default_firmware_name(&s->soc.c908_cpu);
> +    hwaddr start_addr = memmap[K230_DEV_DDRC].base;
> +
> +    if (machine->dtb || (machine->kernel_cmdline && *machine->kernel_cmdline)) {
> +        error_report("K230 firmware boot does not support -dtb or -append");
> +        exit(EXIT_FAILURE);
> +    }
> +
> +    riscv_find_and_load_firmware(machine, firmware_name, &start_addr, NULL);
> +
> +    riscv_setup_rom_reset_vec(machine, &s->soc.c908_cpu, start_addr,
> +                              memmap[K230_DEV_BOOTROM].base,
> +                              memmap[K230_DEV_BOOTROM].size, 0, 0);
> +}
> +
> +static void k230_machine_done(Notifier *notifier, void *data)
> +{
> +    K230MachineState *s = container_of(notifier, K230MachineState,
> +                                       machine_done);
> +    MachineState *machine = MACHINE(s);
> +
> +    if (machine->kernel_filename) {
> +        k230_direct_boot(s, machine);
> +    } else {
> +        k230_firmware_boot(s, machine);
> +    }
> +}
> +
> +static void k230_machine_init(MachineState *machine)
> +{
> +    MachineClass *mc = MACHINE_GET_CLASS(machine);
> +    K230MachineState *s = RISCV_K230_MACHINE(machine);
> +    MemoryRegion *sys_mem = get_system_memory();
> +
> +    if (machine->ram_size < mc->default_ram_size) {
> +        char *sz = size_to_str(mc->default_ram_size);
> +        error_report("Invalid RAM size, should be %s", sz);
> +        g_free(sz);
> +        exit(EXIT_FAILURE);
> +    }
> +
> +    /* Initialize SoC */
> +    object_initialize_child(OBJECT(machine), "soc", &s->soc,
> +                            TYPE_RISCV_K230_SOC);
> +    qdev_realize(DEVICE(&s->soc), NULL, &error_fatal);
> +
> +    /* Data Memory */
> +    memory_region_add_subregion(sys_mem, memmap[K230_DEV_DDRC].base,
> +                                machine->ram);
> +
> +    s->machine_done.notify = k230_machine_done;
> +    qemu_add_machine_init_done_notifier(&s->machine_done);
> +}
> +
> +static void k230_machine_instance_init(Object *obj)
> +{
> +}
> +
> +static void k230_machine_class_init(ObjectClass *oc, const void *data)
> +{
> +    MachineClass *mc = MACHINE_CLASS(oc);
> +
> +    mc->desc = "RISC-V Board compatible with Kendryte K230 SDK";
> +    mc->init = k230_machine_init;
> +    mc->default_cpus = 1;
> +    mc->default_ram_id = "riscv.K230.ram"; /* DDR */
> +    mc->default_ram_size = memmap[K230_DEV_DDRC].size;
> +}
> +
> +static const TypeInfo k230_machine_typeinfo = {
> +    .name       = TYPE_RISCV_K230_MACHINE,
> +    .parent     = TYPE_MACHINE,
> +    .class_init = k230_machine_class_init,
> +    .instance_init = k230_machine_instance_init,
> +    .instance_size = sizeof(K230MachineState),
> +    .interfaces = riscv64_machine_interfaces,
> +};
> +
> +static void k230_machine_init_register_types(void)
> +{
> +    type_register_static(&k230_machine_typeinfo);
> +}
> +
> +type_init(k230_machine_init_register_types)
> diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
> index 533472e22a..09cf855984 100644
> --- a/hw/riscv/meson.build
> +++ b/hw/riscv/meson.build
> @@ -14,8 +14,8 @@ riscv_ss.add(when: 'CONFIG_RISCV_IOMMU', if_true: files(
>   	'riscv-iommu.c', 'riscv-iommu-pci.c', 'riscv-iommu-sys.c', 'riscv-iommu-hpm.c'))
>   riscv_ss.add(when: 'CONFIG_MICROBLAZE_V', if_true: files('microblaze-v-generic.c'))
>   riscv_ss.add(when: 'CONFIG_XIANGSHAN_KUNMINGHU', if_true: files('xiangshan_kmh.c'))
> -
>   riscv_ss.add(when: 'CONFIG_RISCV_MIPS_CPS', if_true: files('cps.c'))
>   riscv_ss.add(when: 'CONFIG_MIPS_BOSTON_AIA', if_true: files('boston-aia.c'))
> +riscv_ss.add(when: 'CONFIG_K230', if_true: files('k230.c'))
>   
>   hw_arch += {'riscv': riscv_ss}
> diff --git a/include/hw/riscv/k230.h b/include/hw/riscv/k230.h
> new file mode 100644
> index 0000000000..dcfde39096
> --- /dev/null
> +++ b/include/hw/riscv/k230.h
> @@ -0,0 +1,145 @@
> +/*
> + * QEMU RISC-V Virt Board Compatible with kendryte K230 SDK
> + *
> + * Copyright (c) 2025 Chao Liu <chao.liu.zevorn@gmail.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * Provides a board compatible with the kendryte K230 SDK
> + *
> + * K230 Technical Reference Manual V0.3.1 (2024-11-18):
> + * https://github.com/revyos/external-docs/blob/master/K230/en-us/K230_Technical_Reference_Manual_V0.3.1_20241118.pdf
> + *
> + * For more information, see <https://www.kendryte.com/en/proDetail/230>
> + */
> +#ifndef HW_K230_H
> +#define HW_K230_H
> +
> +#include "hw/core/boards.h"
> +#include "hw/riscv/riscv_hart.h"
> +
> +#define C908_CPU_HARTID   (0)
> +
> +#define TYPE_RISCV_K230_SOC "riscv.k230.soc"
> +#define RISCV_K230_SOC(obj) \
> +    OBJECT_CHECK(K230SoCState, (obj), TYPE_RISCV_K230_SOC)
> +
> +typedef struct K230SoCState {
> +    /*< private >*/
> +    DeviceState parent_obj;
> +
> +    /*< public >*/
> +    RISCVHartArrayState c908_cpu; /* Small core */
> +
> +    MemoryRegion sram;
> +    MemoryRegion bootrom;
> +
> +    DeviceState *c908_plic;
> +} K230SoCState;
> +
> +#define TYPE_RISCV_K230_MACHINE MACHINE_TYPE_NAME("k230")
> +#define RISCV_K230_MACHINE(obj) \
> +    OBJECT_CHECK(K230MachineState, (obj), TYPE_RISCV_K230_MACHINE)
> +
> +typedef struct K230MachineState {
> +    /*< private >*/
> +    MachineState parent_obj;
> +
> +    /*< public >*/
> +    K230SoCState soc;
> +    Notifier machine_done;
> +} K230MachineState;
> +
> +enum {
> +    K230_DEV_DDRC,
> +    K230_DEV_KPU_L2_CACHE,
> +    K230_DEV_SRAM,
> +    K230_DEV_KPU_CFG,
> +    K230_DEV_FFT,
> +    K230_DEV_AI_2D_ENGINE,
> +    K230_DEV_GSDMA,
> +    K230_DEV_DMA,
> +    K230_DEV_DECOMP_GZIP,
> +    K230_DEV_NON_AI_2D,
> +    K230_DEV_ISP,
> +    K230_DEV_DEWARP,
> +    K230_DEV_RX_CSI,
> +    K230_DEV_H264,
> +    K230_DEV_2P5D,
> +    K230_DEV_VO,
> +    K230_DEV_VO_CFG,
> +    K230_DEV_3D_ENGINE,
> +    K230_DEV_PMU,
> +    K230_DEV_RTC,
> +    K230_DEV_CMU,
> +    K230_DEV_RMU,
> +    K230_DEV_BOOT,
> +    K230_DEV_PWR,
> +    K230_DEV_MAILBOX,
> +    K230_DEV_IOMUX,
> +    K230_DEV_TIMER,
> +    K230_DEV_WDT0,
> +    K230_DEV_WDT1,
> +    K230_DEV_TS,
> +    K230_DEV_HDI,
> +    K230_DEV_STC,
> +    K230_DEV_BOOTROM,
> +    K230_DEV_SECURITY,
> +    K230_DEV_UART0,
> +    K230_DEV_UART1,
> +    K230_DEV_UART2,
> +    K230_DEV_UART3,
> +    K230_DEV_UART4,
> +    K230_DEV_I2C0,
> +    K230_DEV_I2C1,
> +    K230_DEV_I2C2,
> +    K230_DEV_I2C3,
> +    K230_DEV_I2C4,
> +    K230_DEV_PWM,
> +    K230_DEV_GPIO0,
> +    K230_DEV_GPIO1,
> +    K230_DEV_ADC,
> +    K230_DEV_CODEC,
> +    K230_DEV_I2S,
> +    K230_DEV_USB0,
> +    K230_DEV_USB1,
> +    K230_DEV_SD0,
> +    K230_DEV_SD1,
> +    K230_DEV_QSPI0,
> +    K230_DEV_QSPI1,
> +    K230_DEV_SPI,
> +    K230_DEV_HI_SYS_CFG,
> +    K230_DEV_DDRC_CFG,
> +    K230_DEV_FLASH,
> +    K230_DEV_PLIC,
> +    K230_DEV_CLINT,
> +};
> +
> +enum {
> +    /*
> +     * K230 TRM v0.3.1 section 2.4 lists peripheral interrupt bits; SDK
> +     * DTBs expose the corresponding PLIC IDs as bit + 16.
> +     */
> +    K230_UART0_IRQ  = 16,
> +    K230_UART1_IRQ  = 17,
> +    K230_UART2_IRQ  = 18,
> +    K230_UART3_IRQ  = 19,
> +    K230_UART4_IRQ  = 20,
> +};
> +
> +#define K230_UART_COUNT 5
> +
> +/*
> + * Integrates with the interrupt controller (PLIC),
> + * which can process 208 interrupt external sources
> + */
> +#define K230_PLIC_NUM_SOURCES 208
> +#define K230_PLIC_NUM_PRIORITIES 7
> +#define K230_PLIC_PRIORITY_BASE 0x00
> +#define K230_PLIC_PENDING_BASE 0x1000
> +#define K230_PLIC_ENABLE_BASE 0x2000
> +#define K230_PLIC_ENABLE_STRIDE 0x80
> +#define K230_PLIC_CONTEXT_BASE 0x200000
> +#define K230_PLIC_CONTEXT_STRIDE 0x1000
> +
> +#endif

