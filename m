Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E422BC4829A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 15:34:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZuml-0001mD-TP; Tue, 13 Feb 2024 10:33:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1rZuml-0001lv-01
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 10:33:27 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1rZumi-0002J3-88
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 10:33:26 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-411a6ceada8so11988165e9.3
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 07:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1707838402; x=1708443202; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=bwbqkvzZStAy77BzBXccQCCkv+7bHKDBf+Owhox8aSM=;
 b=KZgXjcbQ2yw09d8dzc69bjE+bO5foocWxASTDoJ51V36KRhdzqdlruV/iQuIvdktbc
 OeZpUYpWGL6PKp33UP3qk/MTUOCklMbYROi2QVKWsaedMjlpqS0GG2t6Ul90Y7Y0af95
 K2GZwHa2mLxVXApfdGy42b2gMXhw5swIqt2idbk7zc/76KbXpFk+1wXP0nfJpeGqfx4a
 VdwgTT6GIfza43zWDzhBVJ9bQuoZFHsUIlbszNh4xHMHgwg14lcYA/I/LgjYuRJROii0
 u/ybjx0v3hInRL7KItpWkRZu7H1RU7VfHYB/yIktVwa+YTIUmsf43abxw6TRYrDOk6pu
 yfVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707838402; x=1708443202;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bwbqkvzZStAy77BzBXccQCCkv+7bHKDBf+Owhox8aSM=;
 b=QmNvzO+Xl2U6GvWrUmv3zdi0/EIUEW2jlWBLQTi72P5kwgYMHKDq21FG0LN536OCwG
 7TjMFUcIAVJYps2ElS6bqbUAiKeHVFM4xpVplq2ybGfOpQjLOkAOPJ93Y8rB4YMQny/7
 lwWzApCvXurHLMw2o2h9s5mSw750Z/+Oy/oAxjEzRKqBqbdXiz2SCCNsRSQRewyo5JyN
 chciWlGGQOEvF9I4taGrXAeauzqW1oG7TwYcPmnn9UacnMbQ55p2sWV3J0L2fKaGcl5Z
 enQW++MkQntAvh8crhDcBBXCx1rpQfaf6pSl1KCDLfxn8n11f83KezUR+8cONO4EBMeN
 LckA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFZL5tUlth5tCtIEhv0e3oRKWezwmOkTLbTR6/zEJedyAxfHySXpr7GSNno7IcjpjhiolVRzr4kiZEEHr0mDRg8gSVU9w=
X-Gm-Message-State: AOJu0YzLujDGGh0yFP4LzZQltKvJ1GuMBKHkS+tINHN/ubKdOK22Ix40
 nPOlS8A9s3mRoTqXwnsXp3ds2bd2Z4MXPUCPrdwA24iEobwggD0dKLfOCZY+/Tk=
X-Google-Smtp-Source: AGHT+IHLuessQln5KXmW90xkpC9pjyN9ysRkfmVjNOajmqQH26sKGuzogdNdv3bBaAz8kz330rA2hA==
X-Received: by 2002:a05:600c:46c9:b0:410:7980:72a3 with SMTP id
 q9-20020a05600c46c900b00410798072a3mr7698836wmo.35.1707838402293; 
 Tue, 13 Feb 2024 07:33:22 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCW8JbHnCfvISp/LNGA9ertrOUL0fa3Whq41gZJHKjREr4jetFRlKEbyjAgc+ae5KPwLIBYTxNwXRro8qxGBImY6KnrNPkWsERiTD8IUyB3PNYglv9OrMm8ZS5gRABabvArurRLVgVKzHDynKBvHqFSeHpFHMHcQaW++TBw4rQof0DFY0FRqFBMsdgstj13NLjhMvyeQQgdK4RJtUp7VHbGcxqNVWBr94kEwV8P1sho+VDEs/LoJMEc/aw/7JjfGoWBlrKSDJ+e3ZqY6MB+Nt/LKfGhhHNurSUWpBhCt
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 jr6-20020a05600c560600b0041079d336c7sm12069464wmb.39.2024.02.13.07.33.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Feb 2024 07:33:21 -0800 (PST)
Date: Tue, 13 Feb 2024 16:33:21 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bin.meng@windriver.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH RFC] target: riscv: Add Svvptc extension support
Message-ID: <20240213-87d669a3bd421a1b2bc30fc2@orel>
References: <20240213145308.869874-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213145308.869874-1-alexghiti@rivosinc.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=ajones@ventanamicro.com; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Tue, Feb 13, 2024 at 03:53:08PM +0100, Alexandre Ghiti wrote:
> The Svvptc extension describes a uarch that does not cache invalid TLB
> entries: that's the case for qemu so there is nothing particular to
> implement other than the introduction of this extension, which is done
> here.
> 
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
> 
> That's an RFC since the extension has not been ratified yet.

Hi Alex,

No need for the RFC tag. You can add not-yet-ratified extension support
to QEMU as long as the CPU property is off by default (as you've done)
and you add it to the riscv_cpu_experimental_exts[] array with an "x-"
prefix on its property name.

Thanks,
drew

> 
>  target/riscv/cpu.c     | 2 ++
>  target/riscv/cpu_cfg.h | 1 +
>  2 files changed, 3 insertions(+)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 1b8d001d23..4beb5d0350 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -178,6 +178,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
>      ISA_EXT_DATA_ENTRY(svinval, PRIV_VERSION_1_12_0, ext_svinval),
>      ISA_EXT_DATA_ENTRY(svnapot, PRIV_VERSION_1_12_0, ext_svnapot),
>      ISA_EXT_DATA_ENTRY(svpbmt, PRIV_VERSION_1_12_0, ext_svpbmt),
> +    ISA_EXT_DATA_ENTRY(svvptc, PRIV_VERSION_1_12_0, ext_svvptc),
>      ISA_EXT_DATA_ENTRY(xtheadba, PRIV_VERSION_1_11_0, ext_xtheadba),
>      ISA_EXT_DATA_ENTRY(xtheadbb, PRIV_VERSION_1_11_0, ext_xtheadbb),
>      ISA_EXT_DATA_ENTRY(xtheadbs, PRIV_VERSION_1_11_0, ext_xtheadbs),
> @@ -1467,6 +1468,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
>      MULTI_EXT_CFG_BOOL("svinval", ext_svinval, false),
>      MULTI_EXT_CFG_BOOL("svnapot", ext_svnapot, false),
>      MULTI_EXT_CFG_BOOL("svpbmt", ext_svpbmt, false),
> +    MULTI_EXT_CFG_BOOL("svvptc", ext_svvptc, false),
>  
>      MULTI_EXT_CFG_BOOL("zicntr", ext_zicntr, true),
>      MULTI_EXT_CFG_BOOL("zihpm", ext_zihpm, true),
> diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
> index 833bf58217..c973693b6e 100644
> --- a/target/riscv/cpu_cfg.h
> +++ b/target/riscv/cpu_cfg.h
> @@ -77,6 +77,7 @@ struct RISCVCPUConfig {
>      bool ext_svinval;
>      bool ext_svnapot;
>      bool ext_svpbmt;
> +    bool ext_svvptc;
>      bool ext_zdinx;
>      bool ext_zaamo;
>      bool ext_zacas;
> -- 
> 2.39.2
> 
> 

