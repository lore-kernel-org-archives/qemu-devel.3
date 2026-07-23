Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8FD9C531C7
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 07:51:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmoCv-0007kC-IO; Thu, 23 Jul 2026 03:51:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1wmoCo-0007iC-L6
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 03:50:59 -0400
Received: from mail-southcentralusazon11011026.outbound.protection.outlook.com
 ([40.93.194.26] helo=SN4PR0501CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1wmoCl-00024O-Um
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 03:50:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xSLBGg+PX//SkSMmKfg4Qd4YT0HxmBZXOZirtdc3Q6nsGDZ1DwFGYQaJl8J6jOdFl0cOkixADKScmGbs9d+rm65UGmV4/Q0qPFjHnzGvoA505uIPX1+Lhmfrruka9kA0eLS/J8u1X2JKC2qCMpHK3pDk4S1RLjE4HGAOl6jab405tV9SJjFAMeD6+8WD9HdAyIFpEVaUCqfhwBTeTstDfP8hUiSr5EfnbIA+CIu/ceGyTlNS10QF8IgS8p3o+75OGem7A06rrueIExpsHgRz1HLOI2UGWGF34cQTCv3s55BE5GhuqBjAVtOZiOj0KhA/8rgjQpdCsZISqTTaiG8c8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vt5wlm82HXtDQBMYQexmwGJVfMBwDRr1qjA2LsIxG8o=;
 b=ey5YMpx/ezfOrazq3tggNITERvm45MLEyNFwDuDa6MqbMGQJngpaih6oX03kHsV53km/SHg+Pp+1I9hldPIFS5k2c1v/4bHunN495ZfjbZQKO9pPkh2NVjTU1R3ehmHyEU3qEKJ8ZtXyaV1hITJxY01JFCfQ3gMT4ZZ91oY7ukZtDxi4znW4xr3AU0zU1ANGmu3solL0tvcM8+t+LjURS+PdynPH3CGbRlrgfn2NFeHI/oLI/gnhjvlwWUzM/FCDc5X/ln+g/Aim0joQswErwwPSeCw0m4rB2Izx9xBDTBFQgU4vJ9er4qv3HtfX8tqieStVz1LHNPFMqvR1OnZGJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=oss.qualcomm.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vt5wlm82HXtDQBMYQexmwGJVfMBwDRr1qjA2LsIxG8o=;
 b=UDvny2f5PTvpLNXfUI8agGIGFZsy7bj5uyTG/DstOYeQS6xAobvohbb+Rt7g5JFEj6OYSYVlDHimz1TG4JEOrKw8IAYxXKSS5RKyo78/pRulTu2Cyo5ZwBIKxfYOxlkabH36ktp8EWfCulsSM48vV1tLt3WDinAxnBZKNqiaVQ4=
Received: from SA0PR11CA0073.namprd11.prod.outlook.com (2603:10b6:806:d2::18)
 by BL1PR12MB5730.namprd12.prod.outlook.com (2603:10b6:208:385::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Thu, 23 Jul
 2026 07:45:43 +0000
Received: from SN1PEPF00026367.namprd02.prod.outlook.com
 (2603:10b6:806:d2:cafe::47) by SA0PR11CA0073.outlook.office365.com
 (2603:10b6:806:d2::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.11 via Frontend Transport; Thu,
 23 Jul 2026 07:45:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF00026367.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Thu, 23 Jul 2026 07:45:42 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 23 Jul
 2026 02:45:41 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 23 Jul
 2026 02:45:41 -0500
Received: from XFR-LUMICHEL-L2.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Thu, 23 Jul 2026 02:45:40 -0500
Date: Thu, 23 Jul 2026 09:45:40 +0200
From: Luc Michel <luc.michel@amd.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
CC: <qemu-devel@nongnu.org>, "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: Re: [PATCH v2 1/7] target/microblaze: Set MO_BSWAP in
 do_load/do_store callers
Message-ID: <amHGeLNByMOItHEe@XFR-LUMICHEL-L2.amd.com>
References: <20260722160807.24031-1-philmd@oss.qualcomm.com>
 <20260722160807.24031-2-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260722160807.24031-2-philmd@oss.qualcomm.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026367:EE_|BL1PR12MB5730:EE_
X-MS-Office365-Filtering-Correlation-Id: bf3915bd-4d57-4ad6-fbf2-08dee88e6613
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|82310400026|376014|1800799024|10067099003|4143699003|11063799006|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: 7UeUmLkcikUns1hWBNHekzDT2HLwgugi9KkRApp70NjW+lIVCkkSt3PMztUYKwJz1wM5pwYsZpT7Yi1UFGQfps69qbDznoP5tFmgzFBNXAlG/kthw2tSOOoJscRLrr7pi/xt8bkZyfshS5MhRULqoLS6HrTo9tFw0l8ZoWLfxG52X3M2GoXiyYn4P6x88BeEfSjcKGFE7qG5pvOtWL1RybI+s+x1gpY3W3DUyD568ezWSj0GrtNQ9wVFbSDtfii6x/BtDMO9vrG5bKjIUihrYt8vgVWlvDov3Ck3X7eXIgb5KvlsQEX3oUmHNzHxmF5T3Ri2O4QPiMG6askLck5LbhjJLi/RnifH/RG1H4tjpFram9UWaxfY6Xr6phltzbvlyT+nCvMKaK/FTmFJV3IeRg0soJZ4SFtNTxE0jXa6CuTbnm9r4lUgcsa+lLQspsJZUXp1udE32LQNbgxxrLtOJAXlHRxYxkDFrLSdCXONMUxLE25LvurGoW4zx10433RrfZGIF3FrpCQiK8cpx5xMrmEsu5C6cKDjLmpd/FiruvHoVYT/VpdGz6DsKuHQwHo2DlvmyKKBnW9avKjLUAAK84T7t1x9TuH4aDaXJ96l0ijGh2H+EyDXBkBqh3AT5tV+ssDLjqab2tmTY9L/sJGFEXS7oWkcX65dl45aPVCpfC+SF+NBrchvomc8Na3WRJRtDInJOl/GxfbxsA0Qokcpnw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(82310400026)(376014)(1800799024)(10067099003)(4143699003)(11063799006)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: OXxSxAfB4Blox/6kv+91u3jc87dwNkSHjHOo7JwY72UV7183W33IN/BBZP6SEt9PQh2G4nJCScwyPY6YnL+02Rs96JXREeWr00hnv2Ssb96OKnn+afbOznEfqIv3+lwD01PrnI8pm+FQC6Hmye1abBVjDPjHakRouiD3ydtcI5yLmVCs/vlBu+bHCCmpNxMmmR76/4TZWC/yIgKAMTH+UTu9fYLvI4m9jv8AnhIyAiKLa2fn+ygCy94s9CIGWC/X4Lly10/a1v4x2Itr6JhX4MTjJIzKOFP9T6sOSIl9Rll1eID5JEzfrlz3SLCDmfsB7+nAcs4GQ5ejZp0GUIp+CzWjaVFf9BMbqggkzDYIdhy+ccXWTG0PrIGwZ1iTqPO3F87JgQ/Wa6sAg/NemdieYx/d2kx/Qb6g6qyDBNFW/QROVBE4hwxUKe1dPqlYOO8m
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 07:45:42.8125 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf3915bd-4d57-4ad6-fbf2-08dee88e6613
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026367.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5730
Received-SPF: permerror client-ip=40.93.194.26;
 envelope-from=Luc.Michel@amd.com;
 helo=SN4PR0501CU005.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_NONE=0.001,
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

Hi Phil,

On 18:08 Wed 22 Jul     , Philippe Mathieu-Daudé wrote:
> Instead of setting the MO_BSWAP bit in the do_load/do_store
> helpers depending on a @rev boolean argument, set it on the
> callers in the MemOp argument. The repeated caller pattern
> will allow further simplifications in the next commit.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>  target/microblaze/translate.c | 62 +++++++++++++++--------------------
>  1 file changed, 26 insertions(+), 36 deletions(-)
> 
> diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
> index 8b219afb5dd..623980d0af5 100644
> --- a/target/microblaze/translate.c
> +++ b/target/microblaze/translate.c
> @@ -704,22 +704,17 @@ static inline MemOp mo_endian(DisasContext *dc)
>  }
>  
>  static bool do_load(DisasContext *dc, int rd, TCGv_i32 addr, MemOp mop,
> -                    int mem_index, bool rev)
> +                    int mem_index)
>  {
>      MemOp size = mop & MO_SIZE;
>  
>      mop |= mo_endian(dc);
>  
>      /*
> -     * When doing reverse accesses we need to do two things.
> -     *
> -     * 1. Reverse the address wrt endianness.
> -     * 2. Byteswap the data lanes on the way back into the CPU core.
> +     * When doing reverse accesses we need to byteswap the data
> +     * lanes on the way back into the CPU core.

You are dropping the wrong part of the comment here. You should keep 1.

>       */
> -    if (rev) {
> -        if (size > MO_8) {
> -            mop ^= MO_BSWAP;
> -        }
> +    if (mop & MO_BSWAP) {

Unfortunately in the current state of the refactoring we can't really
get rid of the `rev' argument and rely on `mop' flags here. The MO_BSWAP
flag means "Host reverse endian". So e.g., for a regular big-endian
target access on a little-endian host the MO_BSWAP flag is set. Hence
the 'xor' to flip the bit.  ...

>          if (size < MO_32) {
>              tcg_gen_xori_i32(addr, addr, 3 - size);
>          }
> @@ -746,13 +741,13 @@ static bool do_load(DisasContext *dc, int rd, TCGv_i32 addr, MemOp mop,
>  static bool trans_lbu(DisasContext *dc, arg_typea *arg)
>  {
>      TCGv_i32 addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
> -    return do_load(dc, arg->rd, addr, MO_UB, dc->mem_index, false);
> +    return do_load(dc, arg->rd, addr, MO_UB, dc->mem_index);
>  }
>  
>  static bool trans_lbur(DisasContext *dc, arg_typea *arg)
>  {
>      TCGv_i32 addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
> -    return do_load(dc, arg->rd, addr, MO_UB, dc->mem_index, true);
> +    return do_load(dc, arg->rd, addr, MO_UB ^ MO_BSWAP, dc->mem_index);

... Here you are xor'ing MO_UB and MO_BSWAP, which will result in the
MO_BSWAP bit to always be set. What you want is to xor MO_BSWAP with
mo_endian(dc).

So what you can do instead, is to set it unconditionally:

    return do_load(dc, arg->rd, addr, MO_UB | MO_BSWAP, dc->mem_index);

And in `do_load'/`do_store', xor it with mo_endian(dc):

     mop ^= mo_endian(dc);

That works but needs a good comment explaining what's going on :)

Thanks

-- 
Luc

>  }
>  
>  static bool trans_lbuea(DisasContext *dc, arg_typea *arg)
> @@ -772,19 +767,19 @@ static bool trans_lbuea(DisasContext *dc, arg_typea *arg)
>  static bool trans_lbui(DisasContext *dc, arg_typeb *arg)
>  {
>      TCGv_i32 addr = compute_ldst_addr_typeb(dc, arg->ra, arg->imm);
> -    return do_load(dc, arg->rd, addr, MO_UB, dc->mem_index, false);
> +    return do_load(dc, arg->rd, addr, MO_UB, dc->mem_index);
>  }
>  
>  static bool trans_lhu(DisasContext *dc, arg_typea *arg)
>  {
>      TCGv_i32 addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
> -    return do_load(dc, arg->rd, addr, MO_UW, dc->mem_index, false);
> +    return do_load(dc, arg->rd, addr, MO_UW, dc->mem_index);
>  }
>  
>  static bool trans_lhur(DisasContext *dc, arg_typea *arg)
>  {
>      TCGv_i32 addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
> -    return do_load(dc, arg->rd, addr, MO_UW, dc->mem_index, true);
> +    return do_load(dc, arg->rd, addr, MO_UW ^ MO_BSWAP, dc->mem_index);
>  }
>  
>  static bool trans_lhuea(DisasContext *dc, arg_typea *arg)
> @@ -806,19 +801,19 @@ static bool trans_lhuea(DisasContext *dc, arg_typea *arg)
>  static bool trans_lhui(DisasContext *dc, arg_typeb *arg)
>  {
>      TCGv_i32 addr = compute_ldst_addr_typeb(dc, arg->ra, arg->imm);
> -    return do_load(dc, arg->rd, addr, MO_UW, dc->mem_index, false);
> +    return do_load(dc, arg->rd, addr, MO_UW, dc->mem_index);
>  }
>  
>  static bool trans_lw(DisasContext *dc, arg_typea *arg)
>  {
>      TCGv_i32 addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
> -    return do_load(dc, arg->rd, addr, MO_UL, dc->mem_index, false);
> +    return do_load(dc, arg->rd, addr, MO_UL, dc->mem_index);
>  }
>  
>  static bool trans_lwr(DisasContext *dc, arg_typea *arg)
>  {
>      TCGv_i32 addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
> -    return do_load(dc, arg->rd, addr, MO_UL, dc->mem_index, true);
> +    return do_load(dc, arg->rd, addr, MO_UL ^ MO_BSWAP, dc->mem_index);
>  }
>  
>  static bool trans_lwea(DisasContext *dc, arg_typea *arg)
> @@ -840,7 +835,7 @@ static bool trans_lwea(DisasContext *dc, arg_typea *arg)
>  static bool trans_lwi(DisasContext *dc, arg_typeb *arg)
>  {
>      TCGv_i32 addr = compute_ldst_addr_typeb(dc, arg->ra, arg->imm);
> -    return do_load(dc, arg->rd, addr, MO_UL, dc->mem_index, false);
> +    return do_load(dc, arg->rd, addr, MO_UL, dc->mem_index);
>  }
>  
>  static bool trans_lwx(DisasContext *dc, arg_typea *arg)
> @@ -864,22 +859,17 @@ static bool trans_lwx(DisasContext *dc, arg_typea *arg)
>  }
>  
>  static bool do_store(DisasContext *dc, int rd, TCGv_i32 addr, MemOp mop,
> -                     int mem_index, bool rev)
> +                     int mem_index)
>  {
>      MemOp size = mop & MO_SIZE;
>  
>      mop |= mo_endian(dc);
>  
>      /*
> -     * When doing reverse accesses we need to do two things.
> -     *
> -     * 1. Reverse the address wrt endianness.
> -     * 2. Byteswap the data lanes on the way back into the CPU core.
> +     * When doing reverse accesses we need to byteswap the data
> +     * lanes on the way back into the CPU core.
>       */
> -    if (rev) {
> -        if (size > MO_8) {
> -            mop ^= MO_BSWAP;
> -        }
> +    if (mop & MO_BSWAP) {
>          if (size < MO_32) {
>              tcg_gen_xori_i32(addr, addr, 3 - size);
>          }
> @@ -906,13 +896,13 @@ static bool do_store(DisasContext *dc, int rd, TCGv_i32 addr, MemOp mop,
>  static bool trans_sb(DisasContext *dc, arg_typea *arg)
>  {
>      TCGv_i32 addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
> -    return do_store(dc, arg->rd, addr, MO_UB, dc->mem_index, false);
> +    return do_store(dc, arg->rd, addr, MO_UB, dc->mem_index);
>  }
>  
>  static bool trans_sbr(DisasContext *dc, arg_typea *arg)
>  {
>      TCGv_i32 addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
> -    return do_store(dc, arg->rd, addr, MO_UB, dc->mem_index, true);
> +    return do_store(dc, arg->rd, addr, MO_UB ^ MO_BSWAP, dc->mem_index);
>  }
>  
>  static bool trans_sbea(DisasContext *dc, arg_typea *arg)
> @@ -932,19 +922,19 @@ static bool trans_sbea(DisasContext *dc, arg_typea *arg)
>  static bool trans_sbi(DisasContext *dc, arg_typeb *arg)
>  {
>      TCGv_i32 addr = compute_ldst_addr_typeb(dc, arg->ra, arg->imm);
> -    return do_store(dc, arg->rd, addr, MO_UB, dc->mem_index, false);
> +    return do_store(dc, arg->rd, addr, MO_UB, dc->mem_index);
>  }
>  
>  static bool trans_sh(DisasContext *dc, arg_typea *arg)
>  {
>      TCGv_i32 addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
> -    return do_store(dc, arg->rd, addr, MO_UW, dc->mem_index, false);
> +    return do_store(dc, arg->rd, addr, MO_UW, dc->mem_index);
>  }
>  
>  static bool trans_shr(DisasContext *dc, arg_typea *arg)
>  {
>      TCGv_i32 addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
> -    return do_store(dc, arg->rd, addr, MO_UW, dc->mem_index, true);
> +    return do_store(dc, arg->rd, addr, MO_UW ^ MO_BSWAP, dc->mem_index);
>  }
>  
>  static bool trans_shea(DisasContext *dc, arg_typea *arg)
> @@ -966,19 +956,19 @@ static bool trans_shea(DisasContext *dc, arg_typea *arg)
>  static bool trans_shi(DisasContext *dc, arg_typeb *arg)
>  {
>      TCGv_i32 addr = compute_ldst_addr_typeb(dc, arg->ra, arg->imm);
> -    return do_store(dc, arg->rd, addr, MO_UW, dc->mem_index, false);
> +    return do_store(dc, arg->rd, addr, MO_UW, dc->mem_index);
>  }
>  
>  static bool trans_sw(DisasContext *dc, arg_typea *arg)
>  {
>      TCGv_i32 addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
> -    return do_store(dc, arg->rd, addr, MO_UL, dc->mem_index, false);
> +    return do_store(dc, arg->rd, addr, MO_UL, dc->mem_index);
>  }
>  
>  static bool trans_swr(DisasContext *dc, arg_typea *arg)
>  {
>      TCGv_i32 addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
> -    return do_store(dc, arg->rd, addr, MO_UL, dc->mem_index, true);
> +    return do_store(dc, arg->rd, addr, MO_UL ^ MO_BSWAP, dc->mem_index);
>  }
>  
>  static bool trans_swea(DisasContext *dc, arg_typea *arg)
> @@ -1000,7 +990,7 @@ static bool trans_swea(DisasContext *dc, arg_typea *arg)
>  static bool trans_swi(DisasContext *dc, arg_typeb *arg)
>  {
>      TCGv_i32 addr = compute_ldst_addr_typeb(dc, arg->ra, arg->imm);
> -    return do_store(dc, arg->rd, addr, MO_UL, dc->mem_index, false);
> +    return do_store(dc, arg->rd, addr, MO_UL, dc->mem_index);
>  }
>  
>  static bool trans_swx(DisasContext *dc, arg_typea *arg)
> -- 
> 2.53.0
> 

-- 

