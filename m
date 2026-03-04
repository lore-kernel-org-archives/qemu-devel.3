Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBDFFEF9002
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 16:23:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxozn-0003d5-8p; Wed, 04 Mar 2026 11:22:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vxozm-0003cZ-8a
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 11:22:46 -0500
Received: from mail-dy1-x1341.google.com ([2607:f8b0:4864:20::1341])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vxozk-0004ii-LJ
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 11:22:46 -0500
Received: by mail-dy1-x1341.google.com with SMTP id
 5a478bee46e88-2bdd40d3c61so5751994eec.1
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 08:22:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772641363; x=1773246163; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=4yNY4cJ3BCQYHHUP9kxjaqJsM3SYq28BKZCWz/DTJ6g=;
 b=PPDndnYGrHEZg9nsZPqmE0730/gc/cT5/S3FJAqc0iX5XN0rk+v8D2LYIGO6kR8/BR
 X6wwJ3ZHFW46xBiKzvW0LeksXKC242rGHm12F3IJ71dHshuMFmV98NC2DbWRQ1w7K4sG
 AWb/ie3m1Crge22H42qWyj7OjHs6cAzySt8k+SOenQSXlJQOLwKdBcKYxMAhVSp6t6ae
 VswA8ywhc+OTXUk99X+xxkXINgPg4YIweXtuVv9HL6jwa3ZqR3/yp2w4PVwcBkqmhE1v
 cDRPfWl1QBS4Gdm7G6WC1RasgDXJR2csca8CXn4w97p/RON9ALYC7Kllh/cSstx8ayn0
 O80w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772641363; x=1773246163;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4yNY4cJ3BCQYHHUP9kxjaqJsM3SYq28BKZCWz/DTJ6g=;
 b=iX3lVL7mTVtWRM39ixKWIYZ3rY4aSpHl9UXpJY1BE7AgY8M8W2q2zu/0ogC2zRk/2N
 +oXo8U+gI29nqx4agBoMV6QIyYayuGr0T8hYw8ntV67rlGB7LMBQvdp8qgauhhO8wP5u
 jdCjP5i0hwRtWMV1/l2mr/3MVo2qvN4pxga168lBO9FqXpfkfdEyTsj90UWY9t/eE++N
 yZCCVpuh3FB7wmIj/FwQl9pDxRrA3aUWkE8dU5UZlh6S6Hr753odXqCm+sG3xsftCrup
 XFtiq91jacuamCaUSIgHPWtf97LmVl8RjdjI+SrN2isZUOlLrDJEG9+funL0SIBqZwxM
 Mtdw==
X-Gm-Message-State: AOJu0Yy/AAVRxSobO/bRiaD5Lw1o8NyirvhwxTYkwJ/K2Fx5Alt2eTyK
 fD6YMTmXvUi3X4OUTSPLSlrMcGJOG6rWrHzQ/Z1TIOoRBGee4/c6SWdX
X-Gm-Gg: ATEYQzzPHZvs6/NGeaLDk7OBtxGGE5LKdfy+Iw8+UmAqp+wyu/bEjww2QIsbOGHlxex
 pqU2UFbY7EpzeHIqRO1V0CRNEwHs8dbcu6Lv8h8ZtGNLxiVcvmudN8VIX2uyC/H5Y4QiDlqfUIQ
 NyCvtugWaBAB35eX7R1/b3tX4y9nKJkSGUP7Y90Gk6JdZ/WEx3r7smm5upUqRTSXHdxFzNuco1b
 ClEoqTrhP1b98CZ1ff/4PgR4gVECpoWPJ7QV7YtRP0Xjcy7NAOJ8yn1Kgn0Iqm0we/5cIYcfyZ1
 tCd8t4N6Js5r3H1u1GlR2+h/eRtJUGRAsJ5xXOlHXKmUV4Op27x+VRdZdmcWbOB9WyDuOncAAvt
 q0NRoQHgrlnZ/4wKRmCyY0FI3SoMGHhnw7t4KRGKwNoKc8i7e1wf80i742g3y8d+DtAJy8Qi19m
 NxZ3PabzLTDgiGHOVoSflqGYuhqLu5JtqltZ7l1g1by1ZkqTHUsqmWKGeDd/frt0qnqaF3dzVLa
 IS0eyQFofQGv6PWNZTRCU8CIcq//ckpphVCrbu9Pg==
X-Received: by 2002:a05:7300:cd93:b0:2be:e4b:60ca with SMTP id
 5a478bee46e88-2be30fcfebemr1012870eec.4.1772641362731; 
 Wed, 04 Mar 2026 08:22:42 -0800 (PST)
Received: from ZEVORN-PC.localdomain ([38.95.120.198])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2be2056acd1sm4167867eec.22.2026.03.04.08.22.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 08:22:42 -0800 (PST)
Date: Thu, 5 Mar 2026 00:22:17 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Max Chou <max.chou@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH v4 5/9] target/riscv: Use the tb->cs_base as the extend
 tb flags.
Message-ID: <aahbh2OFUNIsMtN2@ZEVORN-PC.localdomain>
References: <20260304132514.2889449-1-max.chou@sifive.com>
 <20260304132514.2889449-6-max.chou@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304132514.2889449-6-max.chou@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1341;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dy1-x1341.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Wed, Mar 04, 2026 at 09:25:09PM +0800, Max Chou wrote:
> We have more than 32-bits worth of state per TB, so use the
> tb->cs_base, which is otherwise unused for RISC-V, as the extend flag.
> 
> Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Signed-off-by: Max Chou <max.chou@sifive.com>
Nit: trailing period in the commit subject is unconventional.

please remove it.

> ---
>  include/exec/translation-block.h | 1 +
>  target/riscv/cpu.h               | 3 +++
>  target/riscv/tcg/tcg-cpu.c       | 7 ++++++-
>  3 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/include/exec/translation-block.h b/include/exec/translation-block.h
> index 4f83d5bec9..40cc699031 100644
> --- a/include/exec/translation-block.h
> +++ b/include/exec/translation-block.h
> @@ -65,6 +65,7 @@ struct TranslationBlock {
>       * arm: an extension of tb->flags,
>       * s390x: instruction data for EXECUTE,
>       * sparc: the next pc of the instruction queue (for delay slots).
> +     * riscv: an extension of tb->flags,
>       */
>      uint64_t cs_base;
>  
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 962cc45073..4c0676ed53 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -703,6 +703,9 @@ FIELD(TB_FLAGS, BCFI_ENABLED, 28, 1)
>  FIELD(TB_FLAGS, PM_PMM, 29, 2)
>  FIELD(TB_FLAGS, PM_SIGNEXTEND, 31, 1)
>  
> +FIELD(EXT_TB_FLAGS, MISA_EXT, 0, 32)
> +FIELD(EXT_TB_FLAGS, ALTFMT, 32, 1)
The layout is sensible -- misa_ext in low 32 bits,
altfmt at bit 32. Good use of the previously wasted
cs_base field.

I also adopted this design in my debug spec series,
thanks for the idea.

Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>

Best regards,
Chao Liu
> +
>  #ifdef TARGET_RISCV32
>  #define riscv_cpu_mxl(env)  ((void)(env), MXL_RV32)
>  #else
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 720ff0c2a3..378b298886 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -104,6 +104,7 @@ static TCGTBCPUState riscv_get_tb_cpu_state(CPUState *cs)
>      RISCVCPU *cpu = env_archcpu(env);
>      RISCVExtStatus fs, vs;
>      uint32_t flags = 0;
> +    uint64_t ext_flags = 0;
>      bool pm_signext = riscv_cpu_virt_mem_enabled(env);
>  
>      if (cpu->cfg.ext_zve32x) {
> @@ -118,6 +119,7 @@ static TCGTBCPUState riscv_get_tb_cpu_state(CPUState *cs)
>  
>          /* lmul encoded as in DisasContext::lmul */
>          int8_t lmul = sextract32(FIELD_EX64(env->vtype, VTYPE, VLMUL), 0, 3);
> +        uint8_t altfmt = FIELD_EX64(env->vtype, VTYPE, ALTFMT);
>          uint32_t vsew = FIELD_EX64(env->vtype, VTYPE, VSEW);
>          uint32_t vlmax = vext_get_vlmax(cpu->cfg.vlenb, vsew, lmul);
>          uint32_t maxsz = vlmax << vsew;
> @@ -133,6 +135,7 @@ static TCGTBCPUState riscv_get_tb_cpu_state(CPUState *cs)
>          flags = FIELD_DP32(flags, TB_FLAGS, VMA,
>                             FIELD_EX64(env->vtype, VTYPE, VMA));
>          flags = FIELD_DP32(flags, TB_FLAGS, VSTART_EQ_ZERO, env->vstart == 0);
> +        ext_flags = FIELD_DP64(ext_flags, EXT_TB_FLAGS, ALTFMT, altfmt);
>      } else {
>          flags = FIELD_DP32(flags, TB_FLAGS, VILL, 1);
>      }
> @@ -189,10 +192,12 @@ static TCGTBCPUState riscv_get_tb_cpu_state(CPUState *cs)
>      flags = FIELD_DP32(flags, TB_FLAGS, PM_PMM, riscv_pm_get_pmm(env));
>      flags = FIELD_DP32(flags, TB_FLAGS, PM_SIGNEXTEND, pm_signext);
>  
> +    ext_flags = FIELD_DP64(ext_flags, EXT_TB_FLAGS, MISA_EXT, env->misa_ext);
> +
>      return (TCGTBCPUState){
>          .pc = env->xl == MXL_RV32 ? env->pc & UINT32_MAX : env->pc,
>          .flags = flags,
> -        .cs_base = env->misa_ext,
> +        .cs_base = ext_flags,
>      };
>  }
>  
> -- 
> 2.52.0
> 

