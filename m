Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DCF606A31E
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 11:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nongnu.org header.i=@nongnu.org header.a=rsa-sha256 header.s=lists1p-gnu-org header.b=B/X7NvVX;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=rev.ng header.i=@rev.ng header.a=rsa-sha256 header.s=dkim header.b=cYUeSzmM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nongnu.org;
	 s=lists1p-gnu-org; h=From:In-Reply-To:MIME-Version:References:Subject:To:
	Date; bh=yUcEQVcir+I8jhCcp94l7XAIvWirrkMYvtH0CuUjA80=; b=B/X7NvVXWlvBD6TWwq3d
	VNsxC9cd7/gSLQ1sOVIvODXQE3j4gk+MbB0xMoiB18X8ozswKKPz+NcPtuVBdYGutDj1HwwKhZP1G
	SRVwrTX4L2+gU8GN9ugYGOnDdg4u4gu9AiwnjpPjfeVs5RFSl/EldI1N2u2jj5ejFHUeEQmMef3yk
	x4Q68R51HI3e/eECiMHJIHbS2b5kft/y0DAB3XI7Bc3tK5yQlGf57Ows8o0ooUNFWuzzsbGbDXS52
	ma5IP07FkQb0FJqvxQrhEV/XPW9LwX5FdGavDmRmUWlbTxySkKWebF3XMqgfv6CA/CZg4QhEybEcN
	b4UCWGYQFeD8dw==;
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWu7V-0001mG-2D; Fri, 27 Nov 2026 06:28:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1xWu7P-0001jt-A3; Fri, 27 Nov 2026 06:27:56 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1xWu7N-0007fP-7T; Fri, 27 Nov 2026 06:27:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=yUcEQVcir+I8jhCcp94l7XAIvWirrkMYvtH0CuUjA80=; b=cYUeSzmMc3zYTd/
 /1zHBWglcGak8OtJIkdqtRfwrMaBbzs71904oxHmjqlNqgvCRlWdkuFVggqmRLZ84Tq6QpoT7qrC+
 NxgkbXDeHwjwY/xfy3HFEPNNoEisdmrZ/xEGkDqdtrheMymvROy3w3IWSM48J3TEAhE028z57RShS
 xs=;
Date: Fri, 27 Nov 2026 12:34:17 +0100
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: Re: [PATCH 24/24] accel/tcg: Update TranslationBlock::cs_base
 description
Message-ID: <awlqjrCTtvwibM9f@hive.localdomain>
References: <20261126233604.67722-1-philmd@oss.qualcomm.com>
 <20261126233604.67722-25-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261126233604.67722-25-philmd@oss.qualcomm.com>
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via qemu development <qemu-devel@nongnu.org>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 27/11/26, Philippe Mathieu-Daudé wrote:
> Describe the current TranslationBlock::cs_base users.
> 
> Commits that introduced target use of cs_base:
>   arm:        a378206a205a target/arm: Move mode specific TB flags to tb->cs_base
>   hppa:       c301f34e798e target/hppa: Implement IASQ
>               ebd0e151149a target/hppa: Include priv level in user-only iaoq
>   microblaze: d7ecb757d199 target/microblaze: Ensure imm constant is always available
>   riscv:      55b490b58fbf target/riscv: Record misa_ext in TCGTBCPUState.cs_base
>               1c88ab9e77bd target/riscv: Use the tb->cs_base as the extend tb flags
>   s390x:      303c681a8f50 target/s390x: Implement EXECUTE via new TranslationBlock
>   sh4:        4bfa602bc222 target/sh4: Handle user-space atomics
>   sparc:      b453b70bd8e6 sparc fixes (first commit matching cs_base = env->npc)
>   xtensa:     5d630cef4f91 target/xtensa: rework zero overhead loops implementation
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>  include/exec/translation-block.h | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/include/exec/translation-block.h b/include/exec/translation-block.h
> index 491de24d71b9..8fca1bd92267 100644
> --- a/include/exec/translation-block.h
> +++ b/include/exec/translation-block.h
> @@ -60,12 +60,19 @@ struct TranslationBlock {
>      vaddr pc;
>  
>      /*
> -     * Target-specific data associated with the TranslationBlock, e.g.:
> -     * x86: the original user, the Code Segment virtual base,
> -     * arm: an extension of tb->flags,
> +     * cs_base: target-specific data associated with the TranslationBlock,
> +     * as returned by cpu_get_tb_cpu_state() and part of the lookup key.
> +     *
> +     * Targets using it:
> +     * x86: the Code Segment virtual base (0 in 64-bit mode),
> +     * arm: an extension of tb->flags (CPUARMTBFlags::flags2),
> +     * hppa: the CS_BASE_DIFF* bits and the IAOQ_B page offset,
> +     * microblaze: the IMM prefix value,
> +     * riscv: misa_ext (lookup key only, not read by the translator),
>       * s390x: instruction data for EXECUTE,
> +     * sh4: r0 (gUSA region end) when in a gUSA sequence (user-only),
>       * sparc: the next pc of the instruction queue (for delay slots),
> -     * riscv: misa_ext.
> +     * xtensa: zero-overhead loop end distance and loop begin offset.
>       */
>      uint64_t cs_base;
>  
> -- 
> 2.55.0
> 

Reviewed-by: Anton Johansson <anjo@rev.ng>

