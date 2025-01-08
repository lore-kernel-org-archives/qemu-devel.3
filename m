Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4747EE77188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 11:19:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVU4l-00076e-0c; Wed, 08 Jan 2025 06:18:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tVU4i-00075m-Mr; Wed, 08 Jan 2025 06:18:12 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tVU4g-00083f-4p; Wed, 08 Jan 2025 06:18:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=jm4+L9nVoWYDXiBGIMkfj9QHnDXMeFoYLh5iFm5uAd8=; b=iRugOAMJ1vEcRaku+Np5Xs2U2O
 EMVnTJklYqWJv7E3u6h7mLNKvrCNU448t9jU2koTfHXsKLuyxvdFvr9Yu6VTFxuWzB2GznZWGVM+R
 sTQJXWttwcahFdNPNB9BdB7dp0K1zNsnY+NZMfK4DGe7dsdGmCXqrol5h8bjHU926O4rvOTOsIzun
 ZhDDfyGqbrxZzKnm4A4rbCThwg8ECGbRi2hA+ZTfIpvs63mcQfPCQEs5ma3gHJWFiZua36dHBcs4h
 m2BhJKy3JRen9BPls7IJL7wxwrpoOYi36NZIwgwwzwkUNA5EGvPfBQ/v0F8U2MhPt2CdfzfL2VuUO
 iD9F4nNkERFZ2AjcwTYuvElFok8C65k+OGcfYo2GfIJllXj6qiyNuKMOl1rv2CfZCHOhipCt2Us66
 AVCag+8gnTZZWKJnYx6ZGTgwFQnOt1FLi2+3z3GuyW2Go2VuV4xhla96zFtOnVzx2aSpE8TTmIT4U
 0GI6eWLUHcUkWmBlxruFBY9mToNgHPtTEBedcmfLCWvhdeEmThvLln9wzWzdcI1aOdSxZ//nJHtC3
 BZvFy/AegQVa031Y7eTe2s2G6z+05ww+zNKxQYFSU4f3OSRs5CSBfYmgQDV+7/0lUvC6A3w72z3PV
 tc44wC7yQDJWTH7pJ88+qvhhHmcJQd9+fUP41KWAc=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tVU3u-0000ht-CW; Wed, 08 Jan 2025 11:17:26 +0000
Message-ID: <571ab9f2-e8cd-4371-88c0-ae4bb385d284@ilande.co.uk>
Date: Wed, 8 Jan 2025 11:17:58 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Chinmay Rath <rathc@linux.ibm.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, npiggin@gmail.com, danielhb413@gmail.com,
 richard.henderson@linaro.org, harshpb@linux.ibm.com
References: <20240618085831.546883-1-rathc@linux.ibm.com>
 <20240618085831.546883-4-rathc@linux.ibm.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Autocrypt: addr=mark.cave-ayland@ilande.co.uk; keydata=
 xsBNBFQJuzwBCADAYvxrwUh1p/PvUlNFwKosVtVHHplgWi5p29t58QlOUkceZG0DBYSNqk93
 3JzBTbtd4JfFcSupo6MNNOrCzdCbCjZ64ik8ycaUOSzK2tKbeQLEXzXoaDL1Y7vuVO7nL9bG
 E5Ru3wkhCFc7SkoypIoAUqz8EtiB6T89/D9TDEyjdXUacc53R5gu8wEWiMg5MQQuGwzbQy9n
 PFI+mXC7AaEUqBVc2lBQVpAYXkN0EyqNNT12UfDLdxaxaFpUAE2pCa2LTyo5vn5hEW+i3VdN
 PkmjyPvL6DdY03fvC01PyY8zaw+UI94QqjlrDisHpUH40IUPpC/NB0LwzL2aQOMkzT2NABEB
 AAHNME1hcmsgQ2F2ZS1BeWxhbmQgPG1hcmsuY2F2ZS1heWxhbmRAaWxhbmRlLmNvLnVrPsLA
 eAQTAQIAIgUCVAm7PAIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQW8LFb64PMh9f
 NAgAuc3ObOEY8NbZko72AGrg2tWKdybcMVITxmcor4hb9155o/OWcA4IDbeATR6cfiDL/oxU
 mcmtXVgPqOwtW3NYAKr5g/FrZZ3uluQ2mtNYAyTFeALy8YF7N3yhs7LOcpbFP7tEbkSzoXNG
 z8iYMiYtKwttt40WaheWuRs0ZOLbs6yoczZBDhna3Nj0LA3GpeJKlaV03O4umjKJgACP1c/q
 T2Pkg+FCBHHFP454+waqojHp4OCBo6HyK+8I4wJRa9Z0EFqXIu8lTDYoggeX0Xd6bWeCFHK3
 DhD0/Xi/kegSW33unsp8oVcM4kcFxTkpBgj39dB4KwAUznhTJR0zUHf63M7ATQRUCbs8AQgA
 y7kyevA4bpetM/EjtuqQX4U05MBhEz/2SFkX6IaGtTG2NNw5wbcAfhOIuNNBYbw6ExuaJ3um
 2uLseHnudmvN4VSJ5Hfbd8rhqoMmmO71szgT/ZD9MEe2KHzBdmhmhxJdp+zQNivy215j6H27
 14mbC2dia7ktwP1rxPIX1OOfQwPuqlkmYPuVwZP19S4EYnCELOrnJ0m56tZLn5Zj+1jZX9Co
 YbNLMa28qsktYJ4oU4jtn6V79H+/zpERZAHmH40IRXdR3hA+Ye7iC/ZpWzT2VSDlPbGY9Yja
 Sp7w2347L5G+LLbAfaVoejHlfy/msPeehUcuKjAdBLoEhSPYzzdvEQARAQABwsBfBBgBAgAJ
 BQJUCbs8AhsMAAoJEFvCxW+uDzIfabYIAJXmBepHJpvCPiMNEQJNJ2ZSzSjhic84LTMWMbJ+
 opQgr5cb8SPQyyb508fc8b4uD8ejlF/cdbbBNktp3BXsHlO5BrmcABgxSP8HYYNsX0n9kERv
 NMToU0oiBuAaX7O/0K9+BW+3+PGMwiu5ml0cwDqljxfVN0dUBZnQ8kZpLsY+WDrIHmQWjtH+
 Ir6VauZs5Gp25XLrL6bh/SL8aK0BX6y79m5nhfKI1/6qtzHAjtMAjqy8ChPvOqVVVqmGUzFg
 KPsrrIoklWcYHXPyMLj9afispPVR8e0tMKvxzFBWzrWX1mzljbBlnV2n8BIwVXWNbgwpHSsj
 imgcU9TTGC5qd9g=
In-Reply-To: <20240618085831.546883-4-rathc@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v3 3/4] target/ppc: Move VSX vector storage access insns
 to decodetree.
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 18/06/2024 09:58, Chinmay Rath wrote:

(resend due to qemu list outage during December)

> Moving the following instructions to decodetree specification:
> 
>    lxv{b16, d2, h8, w4, ds, ws}x   : X-form
>    stxv{b16, d2, h8, w4}x          : X-form
> 
> The changes were verified by validating that the tcg-ops generated for those
> instructions remain the same, which were captured using the '-d in_asm,op' flag.
> 
> Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/ppc/insn32.decode            |  10 ++
>   target/ppc/translate/vsx-impl.c.inc | 199 ++++++++++++----------------
>   target/ppc/translate/vsx-ops.c.inc  |  12 --
>   3 files changed, 97 insertions(+), 124 deletions(-)
> 
> diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
> index 445fdb341f..3d31ef52f8 100644
> --- a/target/ppc/insn32.decode
> +++ b/target/ppc/insn32.decode
> @@ -805,9 +805,19 @@ STXSIHX         011111 ..... ..... ..... 1110101101 .   @X_TSX
>   STXSIWX         011111 ..... ..... ..... 0010001100 .   @X_TSX
>   STXSSPX         011111 ..... ..... ..... 1010001100 .   @X_TSX
>   
> +LXVB16X         011111 ..... ..... ..... 1101101100 .   @X_TSX
> +LXVD2X          011111 ..... ..... ..... 1101001100 .   @X_TSX
> +LXVH8X          011111 ..... ..... ..... 1100101100 .   @X_TSX
> +LXVW4X          011111 ..... ..... ..... 1100001100 .   @X_TSX
> +LXVDSX          011111 ..... ..... ..... 0101001100 .   @X_TSX
> +LXVWSX          011111 ..... ..... ..... 0101101100 .   @X_TSX
>   LXVL            011111 ..... ..... ..... 0100001101 .   @X_TSX
>   LXVLL           011111 ..... ..... ..... 0100101101 .   @X_TSX
>   
> +STXVB16X        011111 ..... ..... ..... 1111101100 .   @X_TSX
> +STXVD2X         011111 ..... ..... ..... 1111001100 .   @X_TSX
> +STXVH8X         011111 ..... ..... ..... 1110101100 .   @X_TSX
> +STXVW4X         011111 ..... ..... ..... 1110001100 .   @X_TSX
>   STXVL           011111 ..... ..... ..... 0110001101 .   @X_TSX
>   STXVLL          011111 ..... ..... ..... 0110101101 .   @X_TSX
>   
> diff --git a/target/ppc/translate/vsx-impl.c.inc b/target/ppc/translate/vsx-impl.c.inc
> index 46bab49215..e0fb4bad92 100644
> --- a/target/ppc/translate/vsx-impl.c.inc
> +++ b/target/ppc/translate/vsx-impl.c.inc
> @@ -46,41 +46,37 @@ TRANS_FLAGS2(ISA300, LXSIHZX, do_lxs, gen_qemu_ld16u_i64);
>   TRANS_FLAGS2(VSX207, LXSIWZX, do_lxs, gen_qemu_ld32u_i64);
>   TRANS_FLAGS2(VSX207, LXSSPX, do_lxs, gen_qemu_ld32fs);
>   
> -static void gen_lxvd2x(DisasContext *ctx)
> +static bool trans_LXVD2X(DisasContext *ctx, arg_LXVD2X *a)
>   {
>       TCGv EA;
>       TCGv_i64 t0;
> -    if (unlikely(!ctx->vsx_enabled)) {
> -        gen_exception(ctx, POWERPC_EXCP_VSXU);
> -        return;
> -    }
> +
> +    REQUIRE_VSX(ctx);
> +    REQUIRE_INSNS_FLAGS2(ctx, VSX);
> +
>       t0 = tcg_temp_new_i64();
>       gen_set_access_type(ctx, ACCESS_INT);
> -    EA = tcg_temp_new();
> -    gen_addr_reg_index(ctx, EA);
> +    EA = do_ea_calc(ctx, a->ra, cpu_gpr[a->rb]);
>       gen_qemu_ld64_i64(ctx, t0, EA);
> -    set_cpu_vsr(xT(ctx->opcode), t0, true);
> +    set_cpu_vsr(a->rt, t0, true);
>       tcg_gen_addi_tl(EA, EA, 8);
>       gen_qemu_ld64_i64(ctx, t0, EA);
> -    set_cpu_vsr(xT(ctx->opcode), t0, false);
> +    set_cpu_vsr(a->rt, t0, false);
> +    return true;
>   }
>   
> -static void gen_lxvw4x(DisasContext *ctx)
> +static bool trans_LXVW4X(DisasContext *ctx, arg_LXVW4X *a)
>   {
>       TCGv EA;
> -    TCGv_i64 xth;
> -    TCGv_i64 xtl;
> -    if (unlikely(!ctx->vsx_enabled)) {
> -        gen_exception(ctx, POWERPC_EXCP_VSXU);
> -        return;
> -    }
> +    TCGv_i64 xth, xtl;
> +
> +    REQUIRE_VSX(ctx);
> +    REQUIRE_INSNS_FLAGS2(ctx, VSX);
> +
>       xth = tcg_temp_new_i64();
>       xtl = tcg_temp_new_i64();
> -
>       gen_set_access_type(ctx, ACCESS_INT);
> -    EA = tcg_temp_new();
> -
> -    gen_addr_reg_index(ctx, EA);
> +    EA = do_ea_calc(ctx, a->ra, cpu_gpr[a->rb]);
>       if (ctx->le_mode) {
>           TCGv_i64 t0 = tcg_temp_new_i64();
>           TCGv_i64 t1 = tcg_temp_new_i64();
> @@ -97,55 +93,45 @@ static void gen_lxvw4x(DisasContext *ctx)
>           tcg_gen_addi_tl(EA, EA, 8);
>           tcg_gen_qemu_ld_i64(xtl, EA, ctx->mem_idx, MO_BEUQ);
>       }
> -    set_cpu_vsr(xT(ctx->opcode), xth, true);
> -    set_cpu_vsr(xT(ctx->opcode), xtl, false);
> +    set_cpu_vsr(a->rt, xth, true);
> +    set_cpu_vsr(a->rt, xtl, false);
> +    return true;
>   }
>   
> -static void gen_lxvwsx(DisasContext *ctx)
> +static bool trans_LXVWSX(DisasContext *ctx, arg_LXVWSX *a)
>   {
>       TCGv EA;
>       TCGv_i32 data;
>   
> -    if (xT(ctx->opcode) < 32) {
> -        if (unlikely(!ctx->vsx_enabled)) {
> -            gen_exception(ctx, POWERPC_EXCP_VSXU);
> -            return;
> -        }
> +    if (a->rt < 32) {
> +        REQUIRE_VSX(ctx);
>       } else {
> -        if (unlikely(!ctx->altivec_enabled)) {
> -            gen_exception(ctx, POWERPC_EXCP_VPU);
> -            return;
> -        }
> +        REQUIRE_VECTOR(ctx);
>       }
> +    REQUIRE_INSNS_FLAGS2(ctx, ISA300);
>   
>       gen_set_access_type(ctx, ACCESS_INT);
> -    EA = tcg_temp_new();
> -
> -    gen_addr_reg_index(ctx, EA);
> -
> +    EA = do_ea_calc(ctx, a->ra, cpu_gpr[a->rb]);
>       data = tcg_temp_new_i32();
>       tcg_gen_qemu_ld_i32(data, EA, ctx->mem_idx, DEF_MEMOP(MO_UL));
> -    tcg_gen_gvec_dup_i32(MO_UL, vsr_full_offset(xT(ctx->opcode)), 16, 16, data);
> +    tcg_gen_gvec_dup_i32(MO_UL, vsr_full_offset(a->rt), 16, 16, data);
> +    return true;
>   }
>   
> -static void gen_lxvdsx(DisasContext *ctx)
> +static bool trans_LXVDSX(DisasContext *ctx, arg_LXVDSX *a)
>   {
>       TCGv EA;
>       TCGv_i64 data;
>   
> -    if (unlikely(!ctx->vsx_enabled)) {
> -        gen_exception(ctx, POWERPC_EXCP_VSXU);
> -        return;
> -    }
> +    REQUIRE_VSX(ctx);
> +    REQUIRE_INSNS_FLAGS2(ctx, VSX);
>   
>       gen_set_access_type(ctx, ACCESS_INT);
> -    EA = tcg_temp_new();
> -
> -    gen_addr_reg_index(ctx, EA);
> -
> +    EA = do_ea_calc(ctx, a->ra, cpu_gpr[a->rb]);
>       data = tcg_temp_new_i64();
>       tcg_gen_qemu_ld_i64(data, EA, ctx->mem_idx, DEF_MEMOP(MO_UQ));
> -    tcg_gen_gvec_dup_i64(MO_UQ, vsr_full_offset(xT(ctx->opcode)), 16, 16, data);
> +    tcg_gen_gvec_dup_i64(MO_UQ, vsr_full_offset(a->rt), 16, 16, data);
> +    return true;
>   }
>   
>   static void gen_bswap16x8(TCGv_i64 outh, TCGv_i64 outl,
> @@ -184,52 +170,47 @@ static void gen_bswap32x4(TCGv_i64 outh, TCGv_i64 outl,
>       tcg_gen_deposit_i64(outl, outl, lo, 32, 32);
>   }
>   
> -static void gen_lxvh8x(DisasContext *ctx)
> +static bool trans_LXVH8X(DisasContext *ctx, arg_LXVH8X *a)
>   {
>       TCGv EA;
> -    TCGv_i64 xth;
> -    TCGv_i64 xtl;
> +    TCGv_i64 xth, xtl;
> +
> +    REQUIRE_VSX(ctx);
> +    REQUIRE_INSNS_FLAGS2(ctx, ISA300);
>   
> -    if (unlikely(!ctx->vsx_enabled)) {
> -        gen_exception(ctx, POWERPC_EXCP_VSXU);
> -        return;
> -    }
>       xth = tcg_temp_new_i64();
>       xtl = tcg_temp_new_i64();
>       gen_set_access_type(ctx, ACCESS_INT);
> -
> -    EA = tcg_temp_new();
> -    gen_addr_reg_index(ctx, EA);
> +    EA = do_ea_calc(ctx, a->ra, cpu_gpr[a->rb]);
>       tcg_gen_qemu_ld_i64(xth, EA, ctx->mem_idx, MO_BEUQ);
>       tcg_gen_addi_tl(EA, EA, 8);
>       tcg_gen_qemu_ld_i64(xtl, EA, ctx->mem_idx, MO_BEUQ);
>       if (ctx->le_mode) {
>           gen_bswap16x8(xth, xtl, xth, xtl);
>       }
> -    set_cpu_vsr(xT(ctx->opcode), xth, true);
> -    set_cpu_vsr(xT(ctx->opcode), xtl, false);
> +    set_cpu_vsr(a->rt, xth, true);
> +    set_cpu_vsr(a->rt, xtl, false);
> +    return true;
>   }
>   
> -static void gen_lxvb16x(DisasContext *ctx)
> +static bool trans_LXVB16X(DisasContext *ctx, arg_LXVB16X *a)
>   {
>       TCGv EA;
> -    TCGv_i64 xth;
> -    TCGv_i64 xtl;
> +    TCGv_i64 xth, xtl;
> +
> +    REQUIRE_VSX(ctx);
> +    REQUIRE_INSNS_FLAGS2(ctx, ISA300);
>   
> -    if (unlikely(!ctx->vsx_enabled)) {
> -        gen_exception(ctx, POWERPC_EXCP_VSXU);
> -        return;
> -    }
>       xth = tcg_temp_new_i64();
>       xtl = tcg_temp_new_i64();
>       gen_set_access_type(ctx, ACCESS_INT);
> -    EA = tcg_temp_new();
> -    gen_addr_reg_index(ctx, EA);
> +    EA = do_ea_calc(ctx, a->ra, cpu_gpr[a->rb]);
>       tcg_gen_qemu_ld_i64(xth, EA, ctx->mem_idx, MO_BEUQ);
>       tcg_gen_addi_tl(EA, EA, 8);
>       tcg_gen_qemu_ld_i64(xtl, EA, ctx->mem_idx, MO_BEUQ);
> -    set_cpu_vsr(xT(ctx->opcode), xth, true);
> -    set_cpu_vsr(xT(ctx->opcode), xtl, false);
> +    set_cpu_vsr(a->rt, xth, true);
> +    set_cpu_vsr(a->rt, xtl, false);
> +    return true;
>   }
>   
>   #if defined(TARGET_PPC64)
> @@ -319,42 +300,39 @@ TRANS_FLAGS2(ISA300, STXSIHX, do_stxs, gen_qemu_st16_i64);
>   TRANS_FLAGS2(VSX207, STXSIWX, do_stxs, gen_qemu_st32_i64);
>   TRANS_FLAGS2(VSX207, STXSSPX, do_stxs, gen_qemu_st32fs);
>   
> -static void gen_stxvd2x(DisasContext *ctx)
> +static bool trans_STXVD2X(DisasContext *ctx, arg_STXVD2X *a)
>   {
>       TCGv EA;
>       TCGv_i64 t0;
> -    if (unlikely(!ctx->vsx_enabled)) {
> -        gen_exception(ctx, POWERPC_EXCP_VSXU);
> -        return;
> -    }
> +
> +    REQUIRE_VSX(ctx);
> +    REQUIRE_INSNS_FLAGS2(ctx, VSX);
> +
>       t0 = tcg_temp_new_i64();
>       gen_set_access_type(ctx, ACCESS_INT);
> -    EA = tcg_temp_new();
> -    gen_addr_reg_index(ctx, EA);
> -    get_cpu_vsr(t0, xS(ctx->opcode), true);
> +    EA = do_ea_calc(ctx, a->ra, cpu_gpr[a->rb]);
> +    get_cpu_vsr(t0, a->rt, true);
>       gen_qemu_st64_i64(ctx, t0, EA);
>       tcg_gen_addi_tl(EA, EA, 8);
> -    get_cpu_vsr(t0, xS(ctx->opcode), false);
> +    get_cpu_vsr(t0, a->rt, false);
>       gen_qemu_st64_i64(ctx, t0, EA);
> +    return true;
>   }
>   
> -static void gen_stxvw4x(DisasContext *ctx)
> +static bool trans_STXVW4X(DisasContext *ctx, arg_STXVW4X *a)
>   {
>       TCGv EA;
> -    TCGv_i64 xsh;
> -    TCGv_i64 xsl;
> +    TCGv_i64 xsh, xsl;
> +
> +    REQUIRE_VSX(ctx);
> +    REQUIRE_INSNS_FLAGS2(ctx, VSX);
>   
> -    if (unlikely(!ctx->vsx_enabled)) {
> -        gen_exception(ctx, POWERPC_EXCP_VSXU);
> -        return;
> -    }
>       xsh = tcg_temp_new_i64();
>       xsl = tcg_temp_new_i64();
> -    get_cpu_vsr(xsh, xS(ctx->opcode), true);
> -    get_cpu_vsr(xsl, xS(ctx->opcode), false);
> +    get_cpu_vsr(xsh, a->rt, true);
> +    get_cpu_vsr(xsl, a->rt, false);
>       gen_set_access_type(ctx, ACCESS_INT);
> -    EA = tcg_temp_new();
> -    gen_addr_reg_index(ctx, EA);
> +    EA = do_ea_calc(ctx, a->ra, cpu_gpr[a->rb]);
>       if (ctx->le_mode) {
>           TCGv_i64 t0 = tcg_temp_new_i64();
>           TCGv_i64 t1 = tcg_temp_new_i64();
> @@ -371,25 +349,23 @@ static void gen_stxvw4x(DisasContext *ctx)
>           tcg_gen_addi_tl(EA, EA, 8);
>           tcg_gen_qemu_st_i64(xsl, EA, ctx->mem_idx, MO_BEUQ);
>       }
> +    return true;
>   }
>   
> -static void gen_stxvh8x(DisasContext *ctx)
> +static bool trans_STXVH8X(DisasContext *ctx, arg_STXVH8X *a)
>   {
>       TCGv EA;
> -    TCGv_i64 xsh;
> -    TCGv_i64 xsl;
> +    TCGv_i64 xsh, xsl;
> +
> +    REQUIRE_VSX(ctx);
> +    REQUIRE_INSNS_FLAGS2(ctx, ISA300);
>   
> -    if (unlikely(!ctx->vsx_enabled)) {
> -        gen_exception(ctx, POWERPC_EXCP_VSXU);
> -        return;
> -    }
>       xsh = tcg_temp_new_i64();
>       xsl = tcg_temp_new_i64();
> -    get_cpu_vsr(xsh, xS(ctx->opcode), true);
> -    get_cpu_vsr(xsl, xS(ctx->opcode), false);
> +    get_cpu_vsr(xsh, a->rt, true);
> +    get_cpu_vsr(xsl, a->rt, false);
>       gen_set_access_type(ctx, ACCESS_INT);
> -    EA = tcg_temp_new();
> -    gen_addr_reg_index(ctx, EA);
> +    EA = do_ea_calc(ctx, a->ra, cpu_gpr[a->rb]);
>       if (ctx->le_mode) {
>           TCGv_i64 outh = tcg_temp_new_i64();
>           TCGv_i64 outl = tcg_temp_new_i64();
> @@ -403,28 +379,27 @@ static void gen_stxvh8x(DisasContext *ctx)
>           tcg_gen_addi_tl(EA, EA, 8);
>           tcg_gen_qemu_st_i64(xsl, EA, ctx->mem_idx, MO_BEUQ);
>       }
> +    return true;
>   }
>   
> -static void gen_stxvb16x(DisasContext *ctx)
> +static bool trans_STXVB16X(DisasContext *ctx, arg_STXVB16X *a)
>   {
>       TCGv EA;
> -    TCGv_i64 xsh;
> -    TCGv_i64 xsl;
> +    TCGv_i64 xsh, xsl;
> +
> +    REQUIRE_VSX(ctx);
> +    REQUIRE_INSNS_FLAGS2(ctx, ISA300);
>   
> -    if (unlikely(!ctx->vsx_enabled)) {
> -        gen_exception(ctx, POWERPC_EXCP_VSXU);
> -        return;
> -    }
>       xsh = tcg_temp_new_i64();
>       xsl = tcg_temp_new_i64();
> -    get_cpu_vsr(xsh, xS(ctx->opcode), true);
> -    get_cpu_vsr(xsl, xS(ctx->opcode), false);
> +    get_cpu_vsr(xsh, a->rt, true);
> +    get_cpu_vsr(xsl, a->rt, false);
>       gen_set_access_type(ctx, ACCESS_INT);
> -    EA = tcg_temp_new();
> -    gen_addr_reg_index(ctx, EA);
> +    EA = do_ea_calc(ctx, a->ra, cpu_gpr[a->rb]);
>       tcg_gen_qemu_st_i64(xsh, EA, ctx->mem_idx, MO_BEUQ);
>       tcg_gen_addi_tl(EA, EA, 8);
>       tcg_gen_qemu_st_i64(xsl, EA, ctx->mem_idx, MO_BEUQ);
> +    return true;
>   }
>   
>   static void gen_mfvsrwz(DisasContext *ctx)
> diff --git a/target/ppc/translate/vsx-ops.c.inc b/target/ppc/translate/vsx-ops.c.inc
> index 7f4326c974..91cde088bc 100644
> --- a/target/ppc/translate/vsx-ops.c.inc
> +++ b/target/ppc/translate/vsx-ops.c.inc
> @@ -1,15 +1,3 @@
> -GEN_HANDLER_E(lxvd2x, 0x1F, 0x0C, 0x1A, 0, PPC_NONE, PPC2_VSX),
> -GEN_HANDLER_E(lxvwsx, 0x1F, 0x0C, 0x0B, 0, PPC_NONE, PPC2_ISA300),
> -GEN_HANDLER_E(lxvdsx, 0x1F, 0x0C, 0x0A, 0, PPC_NONE, PPC2_VSX),
> -GEN_HANDLER_E(lxvw4x, 0x1F, 0x0C, 0x18, 0, PPC_NONE, PPC2_VSX),
> -GEN_HANDLER_E(lxvh8x, 0x1F, 0x0C, 0x19, 0, PPC_NONE,  PPC2_ISA300),
> -GEN_HANDLER_E(lxvb16x, 0x1F, 0x0C, 0x1B, 0, PPC_NONE, PPC2_ISA300),
> -
> -GEN_HANDLER_E(stxvd2x, 0x1F, 0xC, 0x1E, 0, PPC_NONE, PPC2_VSX),
> -GEN_HANDLER_E(stxvw4x, 0x1F, 0xC, 0x1C, 0, PPC_NONE, PPC2_VSX),
> -GEN_HANDLER_E(stxvh8x, 0x1F, 0x0C, 0x1D, 0, PPC_NONE,  PPC2_ISA300),
> -GEN_HANDLER_E(stxvb16x, 0x1F, 0x0C, 0x1F, 0, PPC_NONE, PPC2_ISA300),
> -
>   GEN_HANDLER_E(mfvsrwz, 0x1F, 0x13, 0x03, 0x0000F800, PPC_NONE, PPC2_VSX207),
>   GEN_HANDLER_E(mtvsrwa, 0x1F, 0x13, 0x06, 0x0000F800, PPC_NONE, PPC2_VSX207),
>   GEN_HANDLER_E(mtvsrwz, 0x1F, 0x13, 0x07, 0x0000F800, PPC_NONE, PPC2_VSX207),

Hi Chinmay,

Someone has reported that this patch (commit 7419dc5b in git) breaks booting 
NetBSD/macppc on the qemu-system-ppc mac99 machine: 
https://gitlab.com/qemu-project/qemu/-/issues/2741.

Please can you take a look using the reproducer provided?


ATB,

Mark.


