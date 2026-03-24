Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAA0FE9A755
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 09:51:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4yQG-0001oC-0U; Tue, 24 Mar 2026 05:51:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1w4yNO-0000zm-LW; Tue, 24 Mar 2026 05:48:43 -0400
Received: from mail-japanwestazolkn190120001.outbound.protection.outlook.com
 ([2a01:111:f403:d406::1] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1w4yNM-0008GZ-ND; Tue, 24 Mar 2026 05:48:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZH6zkw83z7p9sx5lLnRUqJHBxOE5N4sLPkgbqOOICb2CKEwl4vexIh9/tEmgNmnZmKYvC5GsZaeMmf851/o/8gNmvAUzhb+XsDw+tn5hgd6RkPvgzznrT1uonwfC1osy+QcTRJ75vwzd24/yTBlVfFwAZHYVqOQbJXSquY/qJiUO4fQqQsmLQ5+DpVColG2DHhu6C0BJj42hpAMfj9x0u5DVPejk2ZEn4nOT0j/OEsEnHCMNeUphyHH6e3TK52O7IQyPz6H/SOdnG8q4nPDDv3b0pqHoP486cjDN+4HDC4GIlwOxgSukRgjK38BrJXK4alNnD2O98XnkVkwHB6l0Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+N7lhMH9LapVTGSId61xIUu4kTyM54r01eAjySpm2WE=;
 b=RHAH74MSavZX6KWgUpLFqUrMOedrRJzdUjWq6Hlb3iuSqf9KCuoQzXp4fiKvvoo11374SOTt4WezgCYWAKYH9m9ewC2flVvUfhcOUtGx1AXfVSfVfdSOU5O1S3GY+LuNo/YaT7tn/M+DJrPdg0avKmO+ISAdiGP3THArjcZhaLLcE7P13XrVwCY8wU98py7n6RrZNV4g+/xGrl9EPhTGW5YniQRvV9nH65AztdL7p4tVmBpeo0+1t6GKP+BrTGHWqpY+ME6xv6eOAgtmhyE4q8BhtCSpUtKlLmnK7TiZBOIlHhyWcOsnRzOQ2mdJ4B952N5Uegn9I4pyrnMnOwzSZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+N7lhMH9LapVTGSId61xIUu4kTyM54r01eAjySpm2WE=;
 b=ZRtdjIJ+hMWYVm32PBqihgtoffhFOtVAigJLrj6QVKnMWHugfk4aNrgDOo9oWOuUR1zc8fZR4diTyxl3F4qVNK4Qxxh31vLIxdAYpZOqRUYW8/mgL4oD/uTAt9XxTSNfb+W+6+cTHn+1neZNpKn0ajhqqMH//T22SclIwLj3cll23QHWuBCGW0MyQS9STGsZFOn1/VcYIV2oPevOzN5+nya/+o9FFhwWsXSRs9MKKNbqOpWlGDqhDNKxXn4vo9uaBjP5lnGTVloC4Zcs3cDbcC9wrLzdjs/WhOx6zk6Z859CMyAsPyd0vnb9HzhzfT5mnVdZ5Q+B7CybRLyYZIOGmw==
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com (2603:1096:101:2e9::7)
 by JH0PR04MB8008.apcprd04.prod.outlook.com (2603:1096:990:96::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Tue, 24 Mar
 2026 09:48:31 +0000
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58]) by SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58%6]) with mapi id 15.20.9723.030; Tue, 24 Mar 2026
 09:48:31 +0000
Message-ID: <SE3PR04MB8922CDCC52545B65E68524A4F348A@SE3PR04MB8922.apcprd04.prod.outlook.com>
Date: Tue, 24 Mar 2026 17:48:20 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/riscv/riscv-iommu: Use standard EN_PRI bit for PRI
To: Jay Chang <jay.chang@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Frank Chang <frank.chang@sifive.com>
References: <20260324052620.36049-1-jay.chang@sifive.com>
Content-Language: en-US
From: "Nutty.Liu" <nutty.liu@hotmail.com>
In-Reply-To: <20260324052620.36049-1-jay.chang@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TPYP295CA0008.TWNP295.PROD.OUTLOOK.COM (2603:1096:7d0:9::9)
 To SE3PR04MB8922.apcprd04.prod.outlook.com
 (2603:1096:101:2e9::7)
X-Microsoft-Original-Message-ID: <f301c624-3d3c-430c-989f-ba42816a783f@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SE3PR04MB8922:EE_|JH0PR04MB8008:EE_
X-MS-Office365-Filtering-Correlation-Id: e9618d21-3bf6-48ac-3abb-08de898a817d
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|23021999003|12121999013|8060799015|461199028|15080799012|5072599009|6090799003|51005399006|7042599007|19110799012|440099028|3412199025|40105399003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?THBPVDJhT1F6WUtzeW9KQUpBclRsanlhUTZ1cXF2R3p0NjQ0VW9yTmt0Q1I0?=
 =?utf-8?B?dkltWUxhOE03Z3I4S1pwS1U0OTZjMlRRUm8xaUVuMnFMRnl2dmhycHVwUkFZ?=
 =?utf-8?B?SHVSWjNyS1QrajZ3RndMS2wzWDRFSlkrS3NTYnphRWx1UExPMDBqV012VVVw?=
 =?utf-8?B?KzNpdkd3TGJQM2FEeTNzVkl5bDlBbzhEeWlRbHNrSElOb2MxckNtNGJsaXps?=
 =?utf-8?B?YTMvRVpmOGRXam01VjdkQUNFOHg4WjVqalRKNG1UbkQ2blFSSnVTNEQrNTF2?=
 =?utf-8?B?VTZpeEljUlVhYlphNVhXYXJ3OWxPenRYK3VuMWkwcUlDQ2s2blE4YmUrMjhR?=
 =?utf-8?B?b1RSTnRRUUtZYTFJOHg4M1kxcjNBTXhmSWhPM0JZNEZzTyt6cjN2ME5ab2Zo?=
 =?utf-8?B?bmcrRFZJTUJYTEhkWU9pZlVMNy8vNmN0S1JJUlNIMUVOcXNrQk5UckNuRy9N?=
 =?utf-8?B?azZwWmQ4TFpjRzZmOFlNKzFFWW1zV1AxMEgzZ2tBSnZZK0Z1SjZEQzZ6ZDZ4?=
 =?utf-8?B?Y1dKTElFSmtXam03Wjh3VkY1blY2aVBUekx2ZzkyRU9DUXBpblYxV3JZR1Ax?=
 =?utf-8?B?RVBpNXFUc0xNYWRueWdLcDBFYTJrT0tZYUx2UEg5b2xqK1dRenZZb2xwZ29j?=
 =?utf-8?B?ZXBzRzlYMTF5VW56RW9sY2V3MXp4N0xZZ2ZGc0djTWw5TXkxT3BqTVJJbDVQ?=
 =?utf-8?B?RWdGTS92MHRZbThBSVVFWTJwdnVNS3J6dGt0RGRPWm9neWNlcFhCRUh5Tjda?=
 =?utf-8?B?OCtsU3IyQVkrdGwwRHp0eG9URktIUjR3SENzWXB4TVczVk13UG1Va1lOTVdm?=
 =?utf-8?B?ZGg1RDdUMlpNQ2dHKzZVVHRkU0wwREZpNm4rdXhaZ3BtWXpCU0UyYmdGb2E2?=
 =?utf-8?B?M25qOGYxTkdsU3RleWJwdzhIbU0zRDUrT3c4bGNiZmc4QWhxR2d1K01yZDBu?=
 =?utf-8?B?eW9CZUhHWms5Ynp5djYxaEYrS21FNExERHhrZFdXVXVKbVhVU2lLYlB5K0NW?=
 =?utf-8?B?VlpqSXZ4U2pYc2lwR2lVTkFXaHcrUWw0UzRGaDhMMVFjeUlUd0VQVVE0R3BN?=
 =?utf-8?B?NUdoMmIxWVI5T1ZpMzNRZEFWaFhxK0N5Wld6eGFub1QyclFJOTJ5MXRLK1Mw?=
 =?utf-8?B?eDc0ZWkxcFlzeWNHcG5GK0xsU1dDd0xBMEZldTI5OU5NakZmVkxYY09xWVh0?=
 =?utf-8?B?NGRXMDdxcHRESEo4emtiZXM0TEdTU1dRSWFHZTFQOWRwS0F1bStWd1RUdnhR?=
 =?utf-8?B?S3gzQnFTZEQ3MzFPRmc0NHZaTThVQlh0RWZpMEtLTnI4ZFlFTEl4aHZjMFJ4?=
 =?utf-8?Q?o0CkR1gqiccyfdeokv3tRdS3702EVq2md9?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aFlFWitpSE9tZDBRenZMZFh3dDBEYlVMdTByWjVBd3hINnh5WW5kaEZPK0xt?=
 =?utf-8?B?V3JTbXJ6K2VCejVpWTZIcUhqMzhMRGt6NG1tcGxYa0FSWVV4eUppOHVKYVhM?=
 =?utf-8?B?QTdMREgwazg4YVZZWGJxb2tkbHdlSGpKTDN0YnhSZ05QNmRZQTI5SXJhblcw?=
 =?utf-8?B?YXQ0K2xWR3VhcFpRdU5yUjRLK3pqREIrOHdRWG04OEZPeXk4OTdGNlVWVU1D?=
 =?utf-8?B?M2kyTncwSHpIdU1tVi84dVJ5K0xrVy93YS9xL1l6STNQYWF5bHFzVzBTaTJu?=
 =?utf-8?B?Y2d0c3R0S1NIb2dubkVUQ1pSN0ptMWl4dFpiRFFjNEVmMmZlSTZXc0lrb2xE?=
 =?utf-8?B?cGI1a1VkYW55bFRSRjVDTW9SVkRZZjFpZHhZcWM4YlEweDc5V21QVTVueW0r?=
 =?utf-8?B?d2hWTHZJSDhUNTdRYjVodXJ0aFR6WVpxU3pHZXdTV0pzL0plRTJiMi9sWHlr?=
 =?utf-8?B?N1Ixa1NONDk0bGQxdmFSejh0OExtVEE1RnJRb0FZanl5UE1VWG0xU1p6MGlo?=
 =?utf-8?B?TW1ybUJ5ZVRFQ2tSQlRTOFE2cEMzYkNLQktoNGs5OC9iRzdCdWZxbUtRNkVj?=
 =?utf-8?B?UkhKM0YxMUhFcjVUN2F4UEg5TXdiUy93ay9yd0xpaVJ1dHFqaWpLVDIyUWxi?=
 =?utf-8?B?WVF2a1BKTzJCOHdaWDNVMHdic1dFeUI3MTgrd0EyRXViTzRvK0xKL0ovOTV2?=
 =?utf-8?B?RTZqM0Z1ejlHMG1kSHNLKzVNWGxJeE5lNGRMRkU1WlBSaHh1MlVpcTNsSWhv?=
 =?utf-8?B?d29BN0NRYU1ZYXVMNjdERFp1c2lnUlp6bWRtVzllbmk0T1lmSXlVVnBUVmNx?=
 =?utf-8?B?dk5Qb2pUNld1YTNZS1hmeWFxMXRJeTk2d3ZYMGxKN2JocFFTSXkwT294ck5x?=
 =?utf-8?B?d0hONUFYYmY3Y2ZSRDg5dVpDSWlUN0hNYXhMYnZFUHNNeTl5djk0UDJMblVI?=
 =?utf-8?B?OTJMK2JTcmhQQ1BxVFlSVWs5eWhybEJqeWZ3NG84V25Ibm1obUZrTDhRMExT?=
 =?utf-8?B?RVg2NDhxelkySXFoME40akJ1dDFEdDQzT0FlU1pyNk9tSkRPMkNndm5VRWdH?=
 =?utf-8?B?WjJnOUhkR1dOZnpSUGU4QW1Oa3VHVVRqbnNEMXZHaXlWRGhROGJWUEtoQ1Np?=
 =?utf-8?B?WmtJZzVvK0Q3SzZoemtkTE1BdUtaQTZISE96MDV2UWEyK3ZzWExoaEgyUGFU?=
 =?utf-8?B?Q051cENQUkdUTW5LaHlWWWVUa3hzS3R4STZtSjFRN3kwRGNCaGFMRVNxUHd2?=
 =?utf-8?B?U1dHL1NaN3N0Znk4Mm1BYjFDMHBQV0lFL3NFS0RadURNMXEyVXA1VFNNbXBO?=
 =?utf-8?B?WUJNNkNrV3YzUmtpRjNUR0ZoK283TlpSSERtZENMUUlxQUw2M2tZNkRtR0FI?=
 =?utf-8?B?ZG0rRFNlaWw0RkVYa00yblArUTIwb3Jtc3AyYU5oUVFDMVhWd2dzN2cyS0tQ?=
 =?utf-8?B?b1BoekRHNk8vTHA3UVMvSGVjMzRiUjVLRDBNdGlDaXZJbjlUZ05ydkJhTDBI?=
 =?utf-8?B?Z3VMTXVwZ0RZTHNsQXRwTkhMTCtGOHdURkUyZGd1empHZkdhMHFBY2NtY1lT?=
 =?utf-8?B?cTRpU3MwUEcyd3dSbmNJZlBycHBvM0RtV3FYTmJuV3dETDd4RTdVLzV5VExH?=
 =?utf-8?B?S2RzeXM0NlVhc21qMXJsUE5oWnlLc1RER3QrYUZ4aW90TmF5Y3NnMWFwMXFh?=
 =?utf-8?B?TjNJMnd3UFloK2kvMXgrQmxybjI0MXFNR0N6T3p0T0x0RGpqWGVyWWM3N1pQ?=
 =?utf-8?B?K1plNUNnZUFHR3dMU3dvOTRjY1N6SjI5ZmgxeUt6Z1k5akxURjZGVVlXNmxl?=
 =?utf-8?B?WVVFZGNhaTZHN3JLaDMyNlc4RlBvbkptMVRXaFpab1ZFVnFkYVE1WGFUNEVR?=
 =?utf-8?Q?KggAwXYW245Hk?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-c3e7a.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: e9618d21-3bf6-48ac-3abb-08de898a817d
X-MS-Exchange-CrossTenant-AuthSource: SE3PR04MB8922.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 09:48:30.8663 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR04MB8008
Received-SPF: pass client-ip=2a01:111:f403:d406::1;
 envelope-from=nutty.liu@hotmail.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


On 3/24/2026 1:26 PM, Jay Chang wrote:
> Replace the temporary custom extension bit (TC[32]) with the
> standard EN_PRI bit defined in RISC-V IOMMU specification.
>
> Signed-off-by: Jay Chang <jay.chang@sifive.com>
> Reviewed-by: Frank Chang <frank.chang@sifive.com>
> ---
>   hw/riscv/riscv-iommu.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> index 225394ea83..7d5c8cd7f5 100644
> --- a/hw/riscv/riscv-iommu.c
> +++ b/hw/riscv/riscv-iommu.c
> @@ -1572,11 +1572,8 @@ static int riscv_iommu_translate(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
>       riscv_iommu_hpm_incr_ctr(s, ctx, RISCV_IOMMU_HPMEVENT_URQ);
>   
>       iot_cache = g_hash_table_ref(s->iot_cache);
> -    /*
> -     * TC[32] is reserved for custom extensions, used here to temporarily
> -     * enable automatic page-request generation for ATS queries.
> -     */
> -    enable_pri = (iotlb->perm == IOMMU_NONE) && (ctx->tc & BIT_ULL(32));
> +    enable_pri = (iotlb->perm == IOMMU_NONE) &&
> +        (ctx->tc & RISCV_IOMMU_DC_TC_EN_PRI);
Better to align with the first word on the right side of '='.  Like:

+    enable_pri = (iotlb->perm == IOMMU_NONE) &&
+                 (ctx->tc & RISCV_IOMMU_DC_TC_EN_PRI);

Otherwise,
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>

Thanks,
Nutty
>       enable_pid = (ctx->tc & RISCV_IOMMU_DC_TC_PDTV);
>   
>       /* Check for ATS request. */

