Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAAE4EF9002
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 16:23:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxp0K-0003m7-AV; Wed, 04 Mar 2026 11:23:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vxp05-0003ju-Hu
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 11:23:07 -0500
Received: from mail-dy1-x1341.google.com ([2607:f8b0:4864:20::1341])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vxp03-0004mc-MN
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 11:23:04 -0500
Received: by mail-dy1-x1341.google.com with SMTP id
 5a478bee46e88-2bded9bf7a7so5357603eec.1
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 08:23:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772641381; x=1773246181; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Wvai6nObWrt0k14mB4BR+N0ihyOurz8m0Lw0tApaKFc=;
 b=B7Wq8WAe4bsw9GCjUOphMHjM57j/kx3lTfI4ARsED1x91AaGeVreZsjyEQ74nkA7gb
 omTQJitkXFGbWYvtetR378R0oxpqJCAZzL74Lqwz1RmnNlpNDfMUqErJi9+QgYVkARPP
 UQIAmPdqJ2WrF8gH4cYcn32zW/hObo7vxEsETiP3xeuVF/TnNqW12da78nyL0qVuQUEi
 nz5DVfy+z+ZjSn7V8Wvt3Z8kItribkfCA7ayZyFMLdtYwTnuboBt37ZL2a9dSRCTPBeS
 bcri20hN/EnRVI/sZH/B0mc2UfTEDAou8G/dzcH6AigMWykbN61abUjPfQDfeUuUyMVp
 cKFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772641381; x=1773246181;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Wvai6nObWrt0k14mB4BR+N0ihyOurz8m0Lw0tApaKFc=;
 b=hIOdh+3LAuK1CZHdewoc3LkkED75GVD5QdEhb7VNt06lyYawxs/9obBnGQt3OYmrZj
 KEBnfSoWEAyypvXp6ar3ymrhiJESaIbx2efMaY1Hgsk3uw59aIijnOkSpSCLJXrAxux7
 kadv7E1hGQs5ylxzZkFYf5xjnLhyBGUTv3S0M3edTjG87uPWTY/9E0cy+tKnwYWxsO1J
 95v6KXd/+QAior7lncEFgICKhwoCgok9kWYdBlOingrNJu1iI2PfREeI6ur93d7eoKXo
 p8W3br8co1fF08ezCsew2UpjFNhZOHzq/mPscqI0XMpNUvhy9dis2fO7lWa5DRUC1jP7
 b2Jw==
X-Gm-Message-State: AOJu0YyN4pumuYDreUXqXcNSweZ04p0Zy4Kk9UCB7r2VuXIikc+tNCtm
 LB52Hvi/ucDQKlVFKwxzXe+j+tRtL3cx6KmoWM/AdmkrepS4L9Qn6DEAMVpNLGKG
X-Gm-Gg: ATEYQzwNhqPsqJ5ObOqwk64vXmjMn47rTJrrKY+HMeuzm4vhNoeBihnCvA49V9Itgvh
 /SzKB4YGkC5teg72a58LhES5usRl/MWbGZtr3QPjD4MIgmknb92D3A/l8WwpIVYI1c5+FRUjpYI
 ft3gAbwvMdK0mbcFvOl4Ec0ROXuPrkYIuo8Hv4kh9R5JORqEUmyx3J2ew9YwayyF02My0MjfVXU
 0pds7uF/mFxr4RFS/Uv+uSvegU2eFjXVlO3HOwFsb64XTo1+b8tu74X3afQozELFjFYm+5QwoJS
 7pFDMWvd0wis+jkfInDbYLz8HOPmriN7a3OQqB/srDBOYjO4Yowo0pELLTL2cpPyXC+PavXpWWV
 a5rH0fVFcgTajnnru6B1hd7FJzyTm/MaV6WhbZuq3ovS57Jn8Ai4ApguzoH7ZIa7faQKBPFx9OF
 9NvaoeNZfBX9adWGZUYyZ/5XHfrhl660L+1PQ2hIqpu3FQdkfdhG1Haa4fRytybtoemb5gFDa9F
 SCqCiFm9TWfDGkybVpc5+RE1kaKAEE=
X-Received: by 2002:a05:7300:6423:b0:2b8:4a34:6c39 with SMTP id
 5a478bee46e88-2be30fdb77amr1027610eec.16.1772641380989; 
 Wed, 04 Mar 2026 08:23:00 -0800 (PST)
Received: from ZEVORN-PC.localdomain ([38.95.120.198])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2be16992009sm7113244eec.3.2026.03.04.08.22.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 08:23:00 -0800 (PST)
Date: Thu, 5 Mar 2026 00:22:36 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Max Chou <max.chou@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH v4 6/9] target/riscv: Introduce altfmt into DisasContext
Message-ID: <aahcQyu5LpQyNFeU@ZEVORN-PC.localdomain>
References: <20260304132514.2889449-1-max.chou@sifive.com>
 <20260304132514.2889449-7-max.chou@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304132514.2889449-7-max.chou@sifive.com>
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

On Wed, Mar 04, 2026 at 09:25:10PM +0800, Max Chou wrote:
> Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Signed-off-by: Max Chou <max.chou@sifive.com>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>

Best regards,
Chao Liu
> ---
>  target/riscv/translate.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index cb4f443601..89d4f6fe67 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -101,6 +101,7 @@ typedef struct DisasContext {
>      bool cfg_vta_all_1s;
>      bool vstart_eq_zero;
>      bool vl_eq_vlmax;
> +    bool altfmt;
>      CPUState *cs;
>      TCGv zero;
>      /* actual address width */
> @@ -1307,6 +1308,7 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
>      RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(cs);
>      RISCVCPU *cpu = RISCV_CPU(cs);
>      uint32_t tb_flags = ctx->base.tb->flags;
> +    uint64_t ext_tb_flags = ctx->base.tb->cs_base;
>  
>      ctx->pc_save = ctx->base.pc_first;
>      ctx->priv = FIELD_EX32(tb_flags, TB_FLAGS, PRIV);
> @@ -1326,6 +1328,7 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
>      ctx->cfg_vta_all_1s = cpu->cfg.rvv_ta_all_1s;
>      ctx->vstart_eq_zero = FIELD_EX32(tb_flags, TB_FLAGS, VSTART_EQ_ZERO);
>      ctx->vl_eq_vlmax = FIELD_EX32(tb_flags, TB_FLAGS, VL_EQ_VLMAX);
> +    ctx->altfmt = FIELD_EX64(ext_tb_flags, EXT_TB_FLAGS, ALTFMT);
>      ctx->misa_mxl_max = mcc->def->misa_mxl_max;
>      ctx->xl = FIELD_EX32(tb_flags, TB_FLAGS, XL);
>      ctx->address_xl = FIELD_EX32(tb_flags, TB_FLAGS, AXL);
> -- 
> 2.52.0
> 

