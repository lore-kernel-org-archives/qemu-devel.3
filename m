Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E616BCD3424
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2026 13:25:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wInrO-0004AM-UN; Fri, 01 May 2026 09:24:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wInrK-000456-61
 for qemu-devel@nongnu.org; Fri, 01 May 2026 09:24:46 -0400
Received: from mail-qt1-x841.google.com ([2607:f8b0:4864:20::841])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wInrI-0001Mx-OO
 for qemu-devel@nongnu.org; Fri, 01 May 2026 09:24:45 -0400
Received: by mail-qt1-x841.google.com with SMTP id
 d75a77b69052e-50fb18c55beso17621081cf.2
 for <qemu-devel@nongnu.org>; Fri, 01 May 2026 06:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777641883; x=1778246683; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ZonLlDZO/mZLjHys+JH5MZ+cwvKtUlwAPZVv2qziirc=;
 b=JrRHCmLmCBp61XYukw5SIwaaHz1qKSc0CcBUiAF+GrYGAJTqmgS9Rg4I7yiDJX/vBy
 VKHdGfgTdc65hLldYForGL0MyYaRakDzErdS+tiFvbfCJwu4N0vR+siWpbBdnUokY+NJ
 GGxi16oFKOUpigJQtuwhAZv1y2wsUkGxBjNv9MkUE4RB237gMkUxouIilKFSeM+ed/sV
 75Fns0M1brRCCsfNpORfks/DeyvMyIjfmWOTxh129Vq+qUefkj0KsMXb+LeetRUcrzy+
 r++j3HVFMh0JCIskR5DEZ8tTIGbboTaorZwvBoLWc7tM9OQqHdbcco0xCi/GXJ9T8ms0
 23wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777641883; x=1778246683;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZonLlDZO/mZLjHys+JH5MZ+cwvKtUlwAPZVv2qziirc=;
 b=d/4S/NwCISyZQNrKLTf/3OTdEIqG2aC9Z2fb2lMkBXycEq33+mtswclJOGrva/ZxRS
 HaPQMDMxrOJ6AScH8egtiKv66He4V7xKhnfgSbPl8GlgZa4muRp2L76yPkI00ndMa1/I
 uOKLo3iFF/WQDVCT45IQ6oSn9qlxL2Cpihal2DxHigijMAPIDYPoybjK2alOGRbl+GAe
 d4oRwfybvUrCEU/TQEeGpKa7nNfVOW1DnGEknbVUBC268jLMHP91KnPxzxMOc68UowGt
 EApoitmba7bgRGZtA8Na+smPGEWVOON4+Hq0iLRzYJnyLR8irBbKfvG4020Kw1OLMtCj
 qRkQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/eqfn5maCA8m9JolXi+MNc9lzo+fSAKo1I+Zd32I/329emNFC3nHyQ+C4owgiZqbKh6zr9xL0OWa1p@nongnu.org
X-Gm-Message-State: AOJu0YzJnp3QzcoqcHq4tu+1so+ObuNUtoO20oVSLsuNY3Nl83c5TT/9
 7olMrJRBNKSx7NJhEIW+I4N2RsOodnumAcWQ8KLnisSQ3swJgyFpTy/e
X-Gm-Gg: AeBDiesjKZ87r2dYqRFtekQ0emxMZawDbPc/NwVmGe6txF15Hony+4CKd/C8I4D9ltF
 aVBIELy5kp4jMrxvxjxq9yrAkmu/PspYtrWPdERfIT5hG5JXDVPCV5B9j/E3ulMe6yNHTQxhWaL
 CYZ/ilZkss38RbwUmYdbb56ezXhf1bl9vA1CrPTciqNICD/xGtZ4m13fFkVa+jVfM0aGjDvNuU8
 nduQlDoIv5YMFUuJdfCn9ePOEKMVOhUE5/4Zj6t5Q4PmrvAv9T2Rjdfec1gJ/YIqW3EUSaFVBzT
 b98zUJE3VzdnL0cefll5sNt71Jrmeyp+QuLgMRPjtJB2QYVjMB8r9o6IPZKrifN5diYEtpALlL4
 gAzjrdPLj90NsgsiVfNXgDNcefPn3/ToDLQPh99kQqiYz3hFRRULYFrJRgqxBxmzNc43/wmB32b
 LIps8ChgK/iUxY/jbnQKQRKl6KywnmnQIQC0Zv87Ji+WBKCTwtiZkVCqMTA9EEsvakwuiDnJePK
 F11u/9bSpo=
X-Received: by 2002:ac8:5712:0:b0:50f:817c:2fe6 with SMTP id
 d75a77b69052e-5102aad85e6mr109376771cf.2.1777641883506; 
 Fri, 01 May 2026 06:24:43 -0700 (PDT)
Received: from ZEVORN-PC.localdomain ([162.244.208.119])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51040b8174csm15688521cf.25.2026.05.01.06.24.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 May 2026 06:24:43 -0700 (PDT)
Date: Fri, 1 May 2026 21:24:32 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: alistair23@gmail.com
Cc: palmer@dabbelt.com, liwei1518@gmail.com, 
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 qemu-riscv@nongnu.org, 
 qemu-devel@nongnu.org, Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH 2/2] target/riscv: Deprecate the shakti_c machine
Message-ID: <afSpgYXsIdFCfT-v@ZEVORN-PC.localdomain>
References: <20260430052218.771358-1-alistair.francis@wdc.com>
 <20260430052218.771358-3-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260430052218.771358-3-alistair.francis@wdc.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::841;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-qt1-x841.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, Apr 30, 2026 at 03:22:18PM +1000, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
> 
> The RISC-V shakti_c machine hasn't had meaningful contributions since 2021
> and is currently unmaintained. The machine is scheduled to be removed as it
> appears to have no users.
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>

> ---
>  docs/about/deprecated.rst | 8 ++++++++
>  hw/riscv/shakti_c.c       | 1 +
>  2 files changed, 9 insertions(+)
> 
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index f3622dcf93..041f71c5bf 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -282,6 +282,14 @@ firmware is available to boot it. It can be replaced by the
>  ``ast2700fc``, another multi-SoC machine based on the newer AST2700
>  SoCs which are excepted to receive better support in the future.
>  
> +
> +RISC-V Shakti machine (since 11.1)
> +''''''''''''''''''''''''''''''''''''''''''
> +
> +The RISC-V ``shakti_c`` machine hasn't had meaningful contributions since 2021
> +and is currently unmaintained. The machine is scheduled to be removed as it
> +appears to have no users.
> +
>  Backend options
>  ---------------
>  
> diff --git a/hw/riscv/shakti_c.c b/hw/riscv/shakti_c.c
> index 49a39b3021..852d5b9797 100644
> --- a/hw/riscv/shakti_c.c
> +++ b/hw/riscv/shakti_c.c
> @@ -83,6 +83,7 @@ static void shakti_c_machine_class_init(ObjectClass *klass, const void *data)
>      mc->init = shakti_c_machine_state_init;
>      mc->default_cpu_type = TYPE_RISCV_CPU_SHAKTI_C;
>      mc->valid_cpu_types = valid_cpu_types;
> +    mc->deprecation_reason = "Currently unmaintained with no known users";
>      mc->default_ram_id = "riscv.shakti.c.ram";
>  }
>  
> -- 
> 2.53.0
> 

