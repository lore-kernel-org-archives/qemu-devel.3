Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D734E9D40A
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 16:31:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnfla-0008EJ-0k; Wed, 04 Feb 2026 11:30:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vnflY-000899-9K
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 11:30:08 -0500
Received: from mail-dl1-x1242.google.com ([2607:f8b0:4864:20::1242])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vnflV-0006if-JX
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 11:30:07 -0500
Received: by mail-dl1-x1242.google.com with SMTP id
 a92af1059eb24-1248d27f2b9so71793c88.0
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 08:30:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770222604; x=1770827404; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=qto75CraU7jYbEjC8JrZ1sBMSRojzGnr8oqt7WcrLe8=;
 b=Xv5J3DPcRrGTdzIIbvdc/WdHhChCwI0KrDzoa6mLMdSWZMq4+PrjzUdSZZpBqd1GJW
 5ZN4/lDRSmcUeOJov+K8bHYOfUXbg4kMj4QIoCENOj1UWhUHcTYCAWV2H20xW3ZCxOgo
 KkyNJNRJmOueCSuIZzCRQ0IYXK2vxaL3qDoB0Je007N4sqcawE5i5Pe5mOGfY1T/XYH6
 jZ3T3OzC5N5vwmW5FIR+7F6RjZoK5a9ZXQKHObu9ashg3hg/AhUdqZyRM5CVMUNbxdtN
 I2oUd3t/eF6P4AoZ+nbp7Ahi0eDuXQDkHt+frZcyicGXtBb6hZpGtvATBgIYMxjKdU2g
 ooBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770222604; x=1770827404;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qto75CraU7jYbEjC8JrZ1sBMSRojzGnr8oqt7WcrLe8=;
 b=PhXF/Eusw/9PA22tmjTfAvHZyp9Nv0SoU4Yh63SLAtb1x6z7yJjdmpi+4tus4JHbsr
 M1NbY1JPyRQ5yynOUn90T+7ecQiy2lD5CVuf9dGjTL5vKEbNK52UDeCo18lnq26SgBqw
 wQeeahb2Himt65h3WVMaCea1voGYGTogYe0wU113M54I6xlSIRM437QLev0Vwnp93coA
 VSElhYAQLajRalbEYWHVXOawvxZcNZUWA2uj7fuooDtBfssV8mx8sgq1CH59Hz3tMh8c
 zkIBgJW6xJ1mefm4iqXMyCfq32UxowZ/I51ERqznVW+dlcK57e4+Y13kRAsYEwUdWr9p
 OYFA==
X-Gm-Message-State: AOJu0YyWlGa8O/9IB3m83lg7h0hzrDguq3zDOsxdSU68dpZGA8oLtzUH
 mXwKWp1Md3zPE1+DJu97y8juZ68nKsqMD1HwNOtBuqJcfk1sCOH9pe0O
X-Gm-Gg: AZuq6aIi+vMMTsqNnQ5UGh7D1JXG60B8tszrOJ1ZQXylErGuHYWejZHez5YgwblOHIP
 sivU76XchzIlhia0LXZ4GwxMz1HwLTgrqk4QBPtzdQOID7puBI+LnnnGfKqmlnZuh5lGKn7O8pD
 M1ZJt0M3W9cYTbbjXXu9+YFHq7hMgaRjlEtu3YGYZqod+xcNjeKH/36qE3G99ockK2erfdOVJ4J
 4LOer3Yu2uUshirsOObiz0OSv2GRAuWfXJBeV7q3UVN/GTdUffcDrEu4F/ziml1vjl/lUUptR3U
 Jhw++XNIHbckL7f5NdHhNp7fVo1zDgcGSukCZ826D5mQ1zZif4LnAaT1Yaiqhh4g9jzINLJpn++
 z8h/sY3+l+t14iaC1Jj47NXkeVJG9G5b+LF7v6UL2N2MiNUWYl6hNQYzayNkhDDgOtcWNAP1Msa
 nmTrbG6shBk9r2+SJGUEG9gh9W5gQZ41HouGl3+EfyJGlZGDhQbKZSgiMwrjQKCF3aUK9GHm/fs
 Xrl+Q6fSxuR+WnAGHs=
X-Received: by 2002:a05:7022:426:b0:123:34e8:ae9f with SMTP id
 a92af1059eb24-126f477218fmr1735496c88.9.1770222603657; 
 Wed, 04 Feb 2026 08:30:03 -0800 (PST)
Received: from ZEVORN-PC.localdomain ([38.95.120.198])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2b832f8e97bsm1650962eec.17.2026.02.04.08.29.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Feb 2026 08:30:03 -0800 (PST)
Date: Thu, 5 Feb 2026 00:29:49 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Max Chou <max.chou@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, 
 Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH v3 07/19] target/riscv: Add cfg properity for Zvfofp8min
 extension
Message-ID: <aYNy_rXbHe4jT1T5@ZEVORN-PC.localdomain>
References: <20260204051756.667397-1-max.chou@sifive.com>
 <20260204051756.667397-8-max.chou@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260204051756.667397-8-max.chou@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1242;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dl1-x1242.google.com
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

On Wed, Feb 04, 2026 at 01:17:43PM +0800, Max Chou wrote:
> According to the ISA spec of Zvfofp8min extension,
> 
> "The Zvfofp8min extension requires on the Zve32f extension."
> 
Typo in subject: "properity" should be "property".

The same typo appears in patches 13, 15, and 18.

Otherwise, the patch looks good.

Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>

Thanks,
Chao
> Signed-off-by: Max Chou <max.chou@sifive.com>
> ---
>  target/riscv/cpu.c                | 1 +
>  target/riscv/cpu_cfg_fields.h.inc | 1 +
>  target/riscv/tcg/tcg-cpu.c        | 5 +++++
>  target/riscv/vector_helper.c      | 3 ++-
>  4 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index bd17f61d7b..d6ce51ef5e 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -194,6 +194,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
>      ISA_EXT_DATA_ENTRY(zvfbfwma, PRIV_VERSION_1_12_0, ext_zvfbfwma),
>      ISA_EXT_DATA_ENTRY(zvfh, PRIV_VERSION_1_12_0, ext_zvfh),
>      ISA_EXT_DATA_ENTRY(zvfhmin, PRIV_VERSION_1_12_0, ext_zvfhmin),
> +    ISA_EXT_DATA_ENTRY(zvfofp8min, PRIV_VERSION_1_12_0, ext_zvfofp8min),
>      ISA_EXT_DATA_ENTRY(zvkb, PRIV_VERSION_1_12_0, ext_zvkb),
>      ISA_EXT_DATA_ENTRY(zvkg, PRIV_VERSION_1_12_0, ext_zvkg),
>      ISA_EXT_DATA_ENTRY(zvkn, PRIV_VERSION_1_12_0, ext_zvkn),
> diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
> index 3696f02ee0..59302894af 100644
> --- a/target/riscv/cpu_cfg_fields.h.inc
> +++ b/target/riscv/cpu_cfg_fields.h.inc
> @@ -104,6 +104,7 @@ BOOL_FIELD(ext_zvfbfmin)
>  BOOL_FIELD(ext_zvfbfwma)
>  BOOL_FIELD(ext_zvfh)
>  BOOL_FIELD(ext_zvfhmin)
> +BOOL_FIELD(ext_zvfofp8min)
>  BOOL_FIELD(ext_smaia)
>  BOOL_FIELD(ext_ssaia)
>  BOOL_FIELD(ext_smctr)
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 378b298886..ba89436f13 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -710,6 +710,11 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
>          return;
>      }
>  
> +    if (cpu->cfg.ext_zvfofp8min && !cpu->cfg.ext_zve32f) {
> +        error_setg(errp, "Zvfofp8min extension depends on Zve32f extension");
> +        return;
> +    }
> +
>      if (cpu->cfg.ext_zvfh && !cpu->cfg.ext_zfhmin) {
>          error_setg(errp, "Zvfh extensions requires Zfhmin extension");
>          return;
> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> index ec0ea4c143..ee5a1e595b 100644
> --- a/target/riscv/vector_helper.c
> +++ b/target/riscv/vector_helper.c
> @@ -38,7 +38,8 @@ static target_ulong vtype_reserved(CPURISCVState *env, target_ulong vtype)
>      int xlen = riscv_cpu_xlen(env);
>      target_ulong reserved = 0;
>  
> -    if (riscv_cpu_cfg(env)->ext_zvfbfa) {
> +    if (riscv_cpu_cfg(env)->ext_zvfbfa ||
> +        riscv_cpu_cfg(env)->ext_zvfofp8min) {
>          reserved = vtype & MAKE_64BIT_MASK(R_VTYPE_RESERVED_SHIFT,
>                                             xlen - 1 - R_VTYPE_RESERVED_SHIFT);
>      } else {
> -- 
> 2.52.0
> 
> 

