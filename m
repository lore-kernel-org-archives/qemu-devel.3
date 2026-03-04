Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED77DEF8FF3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 15:07:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxnoG-0000mn-H3; Wed, 04 Mar 2026 10:06:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vxnoE-0000kX-Mk
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 10:06:46 -0500
Received: from mail-dl1-x1243.google.com ([2607:f8b0:4864:20::1243])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vxnoA-0001DR-TA
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 10:06:46 -0500
Received: by mail-dl1-x1243.google.com with SMTP id
 a92af1059eb24-127380532eeso1036514c88.1
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 07:06:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772636801; x=1773241601; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=2/tksLhpXOl9ACEShRTwXMO4CphJhPfdwccR2+7zZmM=;
 b=W4p0YfwTE4jyRHD6oW/YRhB4ki6TjJCVf45NkoiwOvTamq4j95VVRzPxI8gtGRsAyR
 7Q2mA3RaIGoVL8pKk9ulCjxmFDU0NRkATlXAz1oVQQEfCMt69eG4uEYYr5juTegtBvpO
 Y51xZuSU1eRJOWqbI3uARqel6ciRBX25a8aChe/sx6pKHjac/qXLhlr8FVj8QMLKDmeg
 ZIxGhi9mM8kgthLTth9hCdBHeMidIBkKnsd0mi0nvqXskHijuQgNYzgwE/FVi8Pzo1M/
 2Q5yNd/RSfCNEPkroRRJkQopF8oIFknSGEzZBDS8idgI36SIGQ1ZCjgcTw6A36LdgKgQ
 BwLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772636801; x=1773241601;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2/tksLhpXOl9ACEShRTwXMO4CphJhPfdwccR2+7zZmM=;
 b=n4XoauUq9z8nT/H2IW4dILciq2UwwkZ1Ehz3xWEy4Qn4/16FVHGYN7STwMemWOEh97
 +NlmjHIr0rZRWoNjfEovAqacNwEFASRl1HTqIVLfIt+hL57RsiKZp1FH/U3063TPTiqK
 C8b5uBUTpjhj9iVA5INrr39tBvVO9Dx65tZBZV0fILjvbbJsDz/wLbBijsj4Q/imCnuc
 5oSC24Cu3AyVOnjTJ1KqQ8dnVe2oFiC3FGmj9v3hIvk3MrvrWkVUbUwkshKQ1EaZHe99
 FcDRa/YBOj0rgyFlpqWsw/on+TDnbV3V2Q9F+2wnt6IPY05KZsdXd22dAv2PQc+RI55D
 caCQ==
X-Gm-Message-State: AOJu0Yy+b0QsKZlsGXvxrTEUfma3ah3gavmC/O0w+uKkrfBzD9H0gkFk
 fCgPD5scArx//kT0Lyje5DtRSn7aCN7QpBNOlJn/0J8wrbrhRI+bB2Ol
X-Gm-Gg: ATEYQzzKU8Ehtz7y1y+xAbUxT0C7m/s6WexKJYCcEFZ2aowGVJT7gabige8Ast9QZD/
 59Ab+e4jI6rc+1B5TlxxD4tA6D53ZllXJSvNRsatl4yU+3s5QGQ5dWluhMHLnixSOb+Dsf8gepx
 HNBp+m13jWNHyNvokUVIokVfEshvaQ/IgdNuZksAki9Zn78K1IPOB+hzJZWR61EO1T0m0iapO70
 yGA4AtZk0jKjj5JbIrbyxWmF3kRBWf2pCz3FE//i2nsV4/+7hWeInFczLqE//UF0RapjLFZRw42
 cG9nLx6tQNuhLQmINAZY/Yl/ODtSLstVSDmWcmXOw+ig/mvB0URhUHvtpjFn6XStdDNY/Vq+88x
 Iusr9t3QtPM3mjd+YvDH9aE1Pm8vZsgDyUhcQnPiHUhCAprxoUhKJH1OGKjbxPC2mfmonC4cE/N
 P0ywgmzqt3REjvxO6ZGBOUZeloq4SqttoWFe1oVN/1PW20H/oLA2YaV7gMyFuAvC9zNAyTTdbIh
 oKxO6GuMSp0Kr7BHrw/dmduyWg7zTg=
X-Received: by 2002:a05:7300:2210:b0:2ba:a712:51e3 with SMTP id
 5a478bee46e88-2be3108e292mr1032726eec.21.1772636801137; 
 Wed, 04 Mar 2026 07:06:41 -0800 (PST)
Received: from ZEVORN-PC.localdomain ([38.95.120.198])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2be1281ff70sm7990076eec.14.2026.03.04.07.06.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 07:06:40 -0800 (PST)
Date: Wed, 4 Mar 2026 23:06:15 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Max Chou <max.chou@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH v4 07/14] target/riscv: rvv: Add vfncvt.f.f.q and
 vfncvt.sat.f.f.q instructions for Zvfofp8min extension
Message-ID: <aahKDWFSPHMyyXLg@ZEVORN-PC.localdomain>
References: <20260304134006.2908449-1-max.chou@sifive.com>
 <20260304134006.2908449-8-max.chou@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304134006.2908449-8-max.chou@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1243;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dl1-x1243.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Mar 04, 2026 at 09:39:59PM +0800, Max Chou wrote:
> The vfncvt.f.f.q and vfncvt.sat.f.f.q instructions convert a vector of
> FP32 elements to a vector of OFP8 elements. The vfncvt.sat.f.fq instruction
> converts a vector of FP32 elements to a vector of OFP8 elements with saturation.
> The VTYPE.altfmt field is used to select the OFP8 format.
> * altfmt = 0: FP32 to OFP8.e4m3
> * altfmt = 1: FP32 to OFP8.e5m2
> 
> Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
> Signed-off-by: Max Chou <max.chou@sifive.com>
> ---
>  target/riscv/insn32.decode                 |  2 +
>  target/riscv/insn_trans/trans_rvofp8.c.inc | 63 ++++++++++++++++++++++
>  target/riscv/insn_trans/trans_rvv.c.inc    | 39 ++++++++++++++
>  3 files changed, 104 insertions(+)
> 
> diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
> index 49201c0c20..f2b413c7d4 100644
> --- a/target/riscv/insn32.decode
> +++ b/target/riscv/insn32.decode
> @@ -974,6 +974,8 @@ vfwmaccbf16_vv    111011 . ..... ..... 001 ..... 1010111 @r_vm
>  vfwmaccbf16_vf    111011 . ..... ..... 101 ..... 1010111 @r_vm
>  
>  # *** Zvfofp8min Extension ***
> +vfncvt_f_f_q          010010 . ..... 11001 001 ..... 1010111 @r2_vm
> +vfncvt_sat_f_f_q      010010 . ..... 11011 001 ..... 1010111 @r2_vm
>  vfncvtbf16_sat_f_f_w  010010 . ..... 11111 001 ..... 1010111 @r2_vm
>  
>  # *** Zvbc vector crypto extension ***
> diff --git a/target/riscv/insn_trans/trans_rvofp8.c.inc b/target/riscv/insn_trans/trans_rvofp8.c.inc
> index d28f92e050..619ee4d773 100644
> --- a/target/riscv/insn_trans/trans_rvofp8.c.inc
> +++ b/target/riscv/insn_trans/trans_rvofp8.c.inc
> @@ -12,6 +12,13 @@
>      }                                       \
>  } while (0)
>  
> +static bool zvfofp8min_narrow_quad_check(DisasContext *s, arg_rmr *a)
> +{
> +    return require_rvv(s) &&
> +           vext_check_isa_ill(s) &&
> +           vext_check_sq(s, a->rd, a->rs2, a->vm) &&
> +           (s->sew == MO_8);
> +}
>  
>  static bool trans_vfncvtbf16_sat_f_f_w(DisasContext *ctx, arg_rmr *a)
>  {
> @@ -40,3 +47,59 @@ static bool trans_vfncvtbf16_sat_f_f_w(DisasContext *ctx, arg_rmr *a)
>      }
>      return false;
>  }
> +
> +static bool trans_vfncvt_f_f_q(DisasContext *ctx, arg_rmr *a)
> +{
> +    REQUIRE_FPU;
> +    REQUIRE_ZVFOFP8MIN(ctx);
> +
> +    if (zvfofp8min_narrow_quad_check(ctx, a)) {
> +        gen_helper_gvec_3_ptr *fn;
> +        uint32_t data = 0;
> +
> +        fn = ctx->altfmt ? gen_helper_vfncvt_f_f_q_ofp8e5m2 :
> +                           gen_helper_vfncvt_f_f_q_ofp8e4m3;
> +
> +        gen_set_rm_chkfrm(ctx, RISCV_FRM_DYN);
> +
> +        data = FIELD_DP32(data, VDATA, VM, a->vm);
> +        data = FIELD_DP32(data, VDATA, LMUL, ctx->lmul);
> +        data = FIELD_DP32(data, VDATA, VTA, ctx->vta);
> +        data = FIELD_DP32(data, VDATA, VMA, ctx->vma);
> +        tcg_gen_gvec_3_ptr(vreg_ofs(ctx, a->rd), vreg_ofs(ctx, 0),
> +                           vreg_ofs(ctx, a->rs2), tcg_env,
> +                           ctx->cfg_ptr->vlenb,
> +                           ctx->cfg_ptr->vlenb, data, fn);
> +        finalize_rvv_inst(ctx);
> +        return true;
> +    }
> +    return false;
> +}
> +
> +static bool trans_vfncvt_sat_f_f_q(DisasContext *ctx, arg_rmr *a)
> +{
> +    REQUIRE_FPU;
> +    REQUIRE_ZVFOFP8MIN(ctx);
> +
> +    if (zvfofp8min_narrow_quad_check(ctx, a)) {
> +        gen_helper_gvec_3_ptr *fn;
> +        uint32_t data = 0;
> +
> +        fn = ctx->altfmt ? gen_helper_vfncvt_sat_f_f_q_ofp8e5m2 :
> +                           gen_helper_vfncvt_sat_f_f_q_ofp8e4m3;
> +
> +        gen_set_rm_chkfrm(ctx, RISCV_FRM_DYN);
> +
> +        data = FIELD_DP32(data, VDATA, VM, a->vm);
> +        data = FIELD_DP32(data, VDATA, LMUL, ctx->lmul);
> +        data = FIELD_DP32(data, VDATA, VTA, ctx->vta);
> +        data = FIELD_DP32(data, VDATA, VMA, ctx->vma);
> +        tcg_gen_gvec_3_ptr(vreg_ofs(ctx, a->rd), vreg_ofs(ctx, 0),
> +                           vreg_ofs(ctx, a->rs2), tcg_env,
> +                           ctx->cfg_ptr->vlenb,
> +                           ctx->cfg_ptr->vlenb, data, fn);
> +        finalize_rvv_inst(ctx);
> +        return true;
> +    }
> +    return false;
> +}
> diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
> index 161bf94a07..bbe864dd7c 100644
> --- a/target/riscv/insn_trans/trans_rvv.c.inc
> +++ b/target/riscv/insn_trans/trans_rvv.c.inc
> @@ -621,6 +621,45 @@ static bool vext_check_sds(DisasContext *s, int vd, int vs1, int vs2, int vm)
>             require_align(vs1, s->lmul);
>  }
>  
> +/*
> + * Common check function for vector narrowing instructions
> + * of single-width result (SEW) and quad-width source (4*SEW).
> + *
> + * Rules to be checked here:
> + *   1. The largest vector register group used by an instruction
> + *      can not be greater than 8 vector registers
> + *      (Section 31.5.2)
> + *   2. Quad-width SEW cannot greater than ELEN.
> + *      (Section 31.2)
> + *   3. Source vector register number is multiples of 4 * LMUL.
> + *      (Section 31.3.4.2)
> + *   4. Destination vector register number is multiples of LMUL.
> + *      (Section 31.3.4.2)
> + *   5. Destination vector register group for a masked vector
> + *      instruction cannot overlap the source mask register (v0).
> + *      (Section 31.5.3)
> + * risc-v unprivileged spec
> + */
> +static bool vext_quad_narrow_check_common(DisasContext *s, int vd, int vs2,
> +                                          int vm)
> +{
> +    return (s->lmul <= 1) &&
> +           (s->sew < MO_32) &&
> +           ((s->sew + 2) <= (s->cfg_ptr->elen >> 4)) &&
> +           require_align(vs2, s->lmul + 2) &&
> +           require_align(vd, s->lmul) &&
> +           require_vm(vm, vd);
> +}
The quad-narrow check logic is correct:
- lmul <= 1 caps source at 8 regs (4 * LMUL = 4 * 2 = 8)
- sew < MO_32 prevents quad SEW exceeding 128 bits
- elen check verified for both ELEN = 32 and 64

Thanks,
Chao
> +
> +static bool vext_check_sq(DisasContext *s, int vd, int vs, int vm)
> +{
> +    bool ret = vext_quad_narrow_check_common(s, vd, vs, vm);
> +    if (vd != vs) {
> +        ret &= require_noover(vd, s->lmul, vs, s->lmul + 2);
> +    }
> +    return ret;
> +}
> +
>  /*
>   * Check function for vector reduction instructions.
>   *
> -- 
> 2.52.0
> 

