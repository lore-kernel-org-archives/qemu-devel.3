Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCB46C54E67
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 11:26:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rl5hP-000695-WB; Fri, 15 Mar 2024 07:26:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1rl5hD-000642-3E
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 07:25:56 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1rl5hA-0000xC-07
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 07:25:54 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1def89f0cfdso1420445ad.0
 for <qemu-devel@nongnu.org>; Fri, 15 Mar 2024 04:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1710501948; x=1711106748; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9D1A+47M8HZ4rgmE3RGvdpACQZfP2AsPr6UkrnISCPc=;
 b=JE2coyS5PoQSzw5BTvIrWX7s5W1QCBp0+VZ9F5/H1/xrJfc7NH+67MfJfHOe55rev+
 Am+6i1UCoox24XfG//8gzXZXWr082BMLaPSIdNhMKxtCEDj5y+5dx6vwUuED+TCoatN+
 FNBOoojBrhpiN3C8iI97vsRDRrAA8UkYv5HxI+UvuzQdNy4Vwa/35b8+l2lUgH0RI5mB
 vko2O2jmroGR/K+8540E0NRd48rxpFe7iVeaZbtO25MUwoaxuWvE9IQwfqgtlGXqNY8t
 soKSYs2MtWZA0Zti+UmtWXDfhT9S7VlPpNvQt/nB5J6SkH1KcQvpto3PkyxnnvJCufE8
 SkHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710501948; x=1711106748;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9D1A+47M8HZ4rgmE3RGvdpACQZfP2AsPr6UkrnISCPc=;
 b=KxUGOp7BaAAwLw5w2gaDBo6gX5sHEwGbDyRxkvcmYZ2uUFprnBpRUG4x8SsIhZqf3l
 2n0W2eLpladivfQgNgi9stpL/CLxKd+xD8NenAVhIg7YOAsIKaKu8uTFVmjL3yT3tg6w
 zrv3pwRsiOgdhTZlRojljIpNSX/fR4gdkrUTabxnANZqCeV5qxjVyRz3vk8oeYOOjhqP
 XuIuAT0DuXzgB7uO81eJb43B8wIJDRFsu1IiNZ7GoeEiwIsNQskmvYThV7JIW8ECDXE7
 +nk+6WgkKX1bMune39sVyiv7N//91jLf/g8gN7hRhe1X0tvKpb38fNGpn0IV258P6Yhr
 2Xwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXM5H0GHJ5JvWanZeyj+vx+iWyHIZjo9w5GeAJU2LieqQ9N6pFgas0zqVJ5kW1ndIZOSshU7bW9UtOMQZbMOazGu/kK6xI=
X-Gm-Message-State: AOJu0YzkY8CQsOXqduu3vB1JKvzCliwa7x0NatYqM24ndl16LVJm7Snb
 bkfFLSuyn4KkVqLRtcL8fYGXmITfeuftIXkxeZ3wHqNkALX/6IsW9wvnf9y8WHc=
X-Google-Smtp-Source: AGHT+IFoyHnXZ6rKqjRtFi46/zItbJ8LBZKtMVFyiTTAVKACSwiC06Dmm0D0Vw/7eMdfEbJ5Tf6WyQ==
X-Received: by 2002:a17:902:bcc2:b0:1dd:8ed0:59d0 with SMTP id
 o2-20020a170902bcc200b001dd8ed059d0mr5274111pls.17.1710501948340; 
 Fri, 15 Mar 2024 04:25:48 -0700 (PDT)
Received: from [100.64.0.1] ([136.226.240.163])
 by smtp.gmail.com with ESMTPSA id
 j1-20020a170902c3c100b001ddb57a4dffsm3555571plj.132.2024.03.15.04.25.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Mar 2024 04:25:47 -0700 (PDT)
Message-ID: <41084cbb-bb01-4dbc-9334-01067eb8550a@sifive.com>
Date: Fri, 15 Mar 2024 19:25:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for 9.0 v15 05/10] target/riscv: always clear vstart for
 ldst_whole insns
Content-Language: en-US
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 richard.henderson@linaro.org
References: <20240314175704.478276-1-dbarboza@ventanamicro.com>
 <20240314175704.478276-6-dbarboza@ventanamicro.com>
From: Max Chou <max.chou@sifive.com>
In-Reply-To: <20240314175704.478276-6-dbarboza@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=max.chou@sifive.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Reviewed-by: Max Chou <max.chou@sifive.com>

On 2024/3/15 1:56 AM, Daniel Henrique Barboza wrote:
> Commit 8ff8ac6329 added a conditional to guard the vext_ldst_whole()
> helper if vstart >= evl. But by skipping the helper we're also not
> setting vstart = 0 at the end of the insns, which is incorrect.
>
> We'll move the conditional to vext_ldst_whole(), following in line with
> the removal of all brconds vstart >= vl that the next patch will do. The
> idea is to make the helpers responsible for their own vstart management.
>
> Fix ldst_whole isns by:
>
> - remove the brcond that skips the helper if vstart is >= evl;
>
> - vext_ldst_whole() now does an early exit with the same check, where
>    evl = (vlenb * nf) >> log2_esz, but the early exit will also clear
>    vstart.
>
> The 'width' param is now unneeded in ldst_whole_trans() and is also
> removed. It was used for the evl calculation for the brcond and has no
> other use now.  The 'width' is reflected in vext_ldst_whole() via
> log2_esz, which is encoded by GEN_VEXT_LD_WHOLE() as
> "ctzl(sizeof(ETYPE))".
>
> Suggested-by: Max Chou <max.chou@sifive.com>
> Fixes: 8ff8ac6329 ("target/riscv: rvv: Add missing early exit condition for whole register load/store")
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>   target/riscv/insn_trans/trans_rvv.c.inc | 52 +++++++++++--------------
>   target/riscv/vector_helper.c            |  5 +++
>   2 files changed, 28 insertions(+), 29 deletions(-)
>
> diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
> index 52c26a7834..1366445e1f 100644
> --- a/target/riscv/insn_trans/trans_rvv.c.inc
> +++ b/target/riscv/insn_trans/trans_rvv.c.inc
> @@ -1097,13 +1097,9 @@ GEN_VEXT_TRANS(vle64ff_v, MO_64, r2nfvm, ldff_op, ld_us_check)
>   typedef void gen_helper_ldst_whole(TCGv_ptr, TCGv, TCGv_env, TCGv_i32);
>   
>   static bool ldst_whole_trans(uint32_t vd, uint32_t rs1, uint32_t nf,
> -                             uint32_t width, gen_helper_ldst_whole *fn,
> +                             gen_helper_ldst_whole *fn,
>                                DisasContext *s)
>   {
> -    uint32_t evl = s->cfg_ptr->vlenb * nf / width;
> -    TCGLabel *over = gen_new_label();
> -    tcg_gen_brcondi_tl(TCG_COND_GEU, cpu_vstart, evl, over);
> -
>       TCGv_ptr dest;
>       TCGv base;
>       TCGv_i32 desc;
> @@ -1120,8 +1116,6 @@ static bool ldst_whole_trans(uint32_t vd, uint32_t rs1, uint32_t nf,
>   
>       fn(dest, base, tcg_env, desc);
>   
> -    gen_set_label(over);
> -
>       return true;
>   }
>   
> @@ -1129,42 +1123,42 @@ static bool ldst_whole_trans(uint32_t vd, uint32_t rs1, uint32_t nf,
>    * load and store whole register instructions ignore vtype and vl setting.
>    * Thus, we don't need to check vill bit. (Section 7.9)
>    */
> -#define GEN_LDST_WHOLE_TRANS(NAME, ARG_NF, WIDTH)               \
> +#define GEN_LDST_WHOLE_TRANS(NAME, ARG_NF)                                \
>   static bool trans_##NAME(DisasContext *s, arg_##NAME * a)                 \
>   {                                                                         \
>       if (require_rvv(s) &&                                                 \
>           QEMU_IS_ALIGNED(a->rd, ARG_NF)) {                                 \
> -        return ldst_whole_trans(a->rd, a->rs1, ARG_NF, WIDTH,             \
> +        return ldst_whole_trans(a->rd, a->rs1, ARG_NF,                    \
>                                   gen_helper_##NAME, s);                    \
>       }                                                                     \
>       return false;                                                         \
>   }
>   
> -GEN_LDST_WHOLE_TRANS(vl1re8_v,  1, 1)
> -GEN_LDST_WHOLE_TRANS(vl1re16_v, 1, 2)
> -GEN_LDST_WHOLE_TRANS(vl1re32_v, 1, 4)
> -GEN_LDST_WHOLE_TRANS(vl1re64_v, 1, 8)
> -GEN_LDST_WHOLE_TRANS(vl2re8_v,  2, 1)
> -GEN_LDST_WHOLE_TRANS(vl2re16_v, 2, 2)
> -GEN_LDST_WHOLE_TRANS(vl2re32_v, 2, 4)
> -GEN_LDST_WHOLE_TRANS(vl2re64_v, 2, 8)
> -GEN_LDST_WHOLE_TRANS(vl4re8_v,  4, 1)
> -GEN_LDST_WHOLE_TRANS(vl4re16_v, 4, 2)
> -GEN_LDST_WHOLE_TRANS(vl4re32_v, 4, 4)
> -GEN_LDST_WHOLE_TRANS(vl4re64_v, 4, 8)
> -GEN_LDST_WHOLE_TRANS(vl8re8_v,  8, 1)
> -GEN_LDST_WHOLE_TRANS(vl8re16_v, 8, 2)
> -GEN_LDST_WHOLE_TRANS(vl8re32_v, 8, 4)
> -GEN_LDST_WHOLE_TRANS(vl8re64_v, 8, 8)
> +GEN_LDST_WHOLE_TRANS(vl1re8_v,  1)
> +GEN_LDST_WHOLE_TRANS(vl1re16_v, 1)
> +GEN_LDST_WHOLE_TRANS(vl1re32_v, 1)
> +GEN_LDST_WHOLE_TRANS(vl1re64_v, 1)
> +GEN_LDST_WHOLE_TRANS(vl2re8_v,  2)
> +GEN_LDST_WHOLE_TRANS(vl2re16_v, 2)
> +GEN_LDST_WHOLE_TRANS(vl2re32_v, 2)
> +GEN_LDST_WHOLE_TRANS(vl2re64_v, 2)
> +GEN_LDST_WHOLE_TRANS(vl4re8_v,  4)
> +GEN_LDST_WHOLE_TRANS(vl4re16_v, 4)
> +GEN_LDST_WHOLE_TRANS(vl4re32_v, 4)
> +GEN_LDST_WHOLE_TRANS(vl4re64_v, 4)
> +GEN_LDST_WHOLE_TRANS(vl8re8_v,  8)
> +GEN_LDST_WHOLE_TRANS(vl8re16_v, 8)
> +GEN_LDST_WHOLE_TRANS(vl8re32_v, 8)
> +GEN_LDST_WHOLE_TRANS(vl8re64_v, 8)
>   
>   /*
>    * The vector whole register store instructions are encoded similar to
>    * unmasked unit-stride store of elements with EEW=8.
>    */
> -GEN_LDST_WHOLE_TRANS(vs1r_v, 1, 1)
> -GEN_LDST_WHOLE_TRANS(vs2r_v, 2, 1)
> -GEN_LDST_WHOLE_TRANS(vs4r_v, 4, 1)
> -GEN_LDST_WHOLE_TRANS(vs8r_v, 8, 1)
> +GEN_LDST_WHOLE_TRANS(vs1r_v, 1)
> +GEN_LDST_WHOLE_TRANS(vs2r_v, 2)
> +GEN_LDST_WHOLE_TRANS(vs4r_v, 4)
> +GEN_LDST_WHOLE_TRANS(vs8r_v, 8)
>   
>   /*
>    *** Vector Integer Arithmetic Instructions
> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> index bcc553c0e2..1f4c276b21 100644
> --- a/target/riscv/vector_helper.c
> +++ b/target/riscv/vector_helper.c
> @@ -572,6 +572,11 @@ vext_ldst_whole(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
>       uint32_t vlenb = riscv_cpu_cfg(env)->vlenb;
>       uint32_t max_elems = vlenb >> log2_esz;
>   
> +    if (env->vstart >= ((vlenb * nf) >> log2_esz)) {
> +        env->vstart = 0;
> +        return;
> +    }
> +
>       k = env->vstart / max_elems;
>       off = env->vstart % max_elems;
>   

