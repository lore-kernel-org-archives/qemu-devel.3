Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43794EF9002
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 16:18:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxove-0000Pm-LV; Wed, 04 Mar 2026 11:18:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vxovd-0000Nh-Ix
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 11:18:29 -0500
Received: from mail-dy1-x1344.google.com ([2607:f8b0:4864:20::1344])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vxova-0002ij-Tp
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 11:18:28 -0500
Received: by mail-dy1-x1344.google.com with SMTP id
 5a478bee46e88-2be27fa54feso2474741eec.0
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 08:18:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772641105; x=1773245905; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=mIJDmNpA3W5cCkow2nH/fJTSLGJ2+uOHDhPBjfIhV0c=;
 b=Dpc9+C4bMJx5Jj99ylwTsrbAceV8D5vttt99YzPDorGNBESfAT6bdWchAMheOkJAYd
 CC8+P3wjxaaLruHLrnmIPrpuWren7+K6KR1OWlCfLleMW11OPgkOPgKNpiZjgw0INb4L
 z+foTrk6XNEyuezmsm5hmZvRhCH1oZGiz4hxh5enI2/fvoTN+WLOJwyDbOKIa6/rf24W
 2YZNDFmSgzIfw/41+Q5x5z37f9I+dW5a1pac6diNM1W+Q793tgQKmgcOTUUxG158QMK+
 4k+jKPE7JnCP5AkDrTxWhiW7LNmEtfcEFzY3YdVlXiu2E0RV1x4mFPGQfon5Qk7ierdS
 Onvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772641105; x=1773245905;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mIJDmNpA3W5cCkow2nH/fJTSLGJ2+uOHDhPBjfIhV0c=;
 b=mBFSKh/cdR9pyzYAT3Miu+VG2sHjf6PFtLPx8EFiKCeufleLzyK3nVeehRB21UdUkb
 81tnfd7/sPgcLiIk1Tx9oGLc2gf+fwF9iYmYnV9CXTU4VBf/MSBcNcqvo/FOeSM1rCpV
 wS0mddHg7xA8qBPHkopcyuc0b6rIeT0Ake862Fd7FgGj7X0WnENAfaKVg7onDk/JjFm5
 aTiPLrq5P+qZJocaQ/ccOGa7vyREBYdXCrJMNmMMUWnmSkSzYEercZhsRjy1nVAdOLMK
 8R4atxFH4DhXnL4pBsbYgt4tAdIMa/eKsL1BZtDLotnI8I20gvLoB+eKpNw3WlZlpKbE
 tiwg==
X-Gm-Message-State: AOJu0YwPQ/f4JlC73rvk6a5CXz/LmSQodGHpv1fpj8V/9muxbnUSnF6B
 4z+04GwRHl4PU2ToXWlL+HNUFzaHLFe2VA/dNFDAUM9eq9Dnnka6sdVy
X-Gm-Gg: ATEYQzzTEspNelPM0ZMEyUGxs+QCl+WjqkoEwppXJNw5d5xAoT+YOajWC9Ua3ZBwHw3
 uoYvFEE8OeTwOpI8inng+43kwa70W1FpRSP16XYg7GZC0sbJjXJreCySj7J3+Ve1Jafcy/ZMJb7
 vjgr2n1JGENUEpt8BTdwEEeCtM38s3bz+H8usHXcQPPUXa73q8mLtD3B400VQ8owtG2PObqScfB
 zR2nU5FiivC8f04uMSk0w5gcRTaGCfkEAGgTiDxKnVKOy2+AoLCXMYuxmtXNDr/ZhN2hpCVSBS7
 4CxXskCbBzi8e6DU8LyIgYegHhFKkHocJEW5ugxSbjC9uyqwNLsOjEVLSNjpXumrNws1frK2C9s
 821dm/asvyI/riK8zPqh0e4Ctlln+M0AjZn0m1xrCwhvhk0dh2R0a0rbo745U37eEuXOyUwafJ/
 I0CIgzs52Vh6iR3gOrENOmNsOxlIGJ6c79DB87b9gkU+LxXOqjO7OF9vL20CT2uKoNvnkGTnFa3
 Fkbd6ZNZL/wUHYdMiIL0fKGj8q/Q5c=
X-Received: by 2002:a05:7301:1009:b0:2b7:38cf:c2fd with SMTP id
 5a478bee46e88-2be311b9a6dmr926268eec.26.1772641105359; 
 Wed, 04 Mar 2026 08:18:25 -0800 (PST)
Received: from ZEVORN-PC.localdomain ([38.95.120.198])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2be1281ff70sm8110139eec.14.2026.03.04.08.18.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 08:18:24 -0800 (PST)
Date: Thu, 5 Mar 2026 00:17:56 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Max Chou <max.chou@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Nutty Liu <nutty.liu@hotmail.com>
Subject: Re: [PATCH v4 2/9] target/riscv: Add the Zvfbfa extension implied rule
Message-ID: <aahbJ0KGJJbLquH2@ZEVORN-PC.localdomain>
References: <20260304132514.2889449-1-max.chou@sifive.com>
 <20260304132514.2889449-3-max.chou@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304132514.2889449-3-max.chou@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1344;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dy1-x1344.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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

On Wed, Mar 04, 2026 at 09:25:06PM +0800, Max Chou wrote:
> According to the Zvfbfa isa spec:
> The Zvfbfa extension requires the Zve32f and Zfbfmin extensions.
> 
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>

Best regards,
Chao Liu

> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
> Signed-off-by: Max Chou <max.chou@sifive.com>
> ---
>  target/riscv/cpu.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 2ddc26c837..376517755e 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -2619,6 +2619,15 @@ static RISCVCPUImpliedExtsRule SSCTR_IMPLIED = {
>      },
>  };
>  
> +static RISCVCPUImpliedExtsRule ZVFBFA_IMPLIED = {
> +    .ext = CPU_CFG_OFFSET(ext_zvfbfa),
> +    .implied_multi_exts = {
> +        CPU_CFG_OFFSET(ext_zve32f), CPU_CFG_OFFSET(ext_zfbfmin),
> +
> +        RISCV_IMPLIED_EXTS_RULE_END
> +    },
> +};
> +
>  RISCVCPUImpliedExtsRule *riscv_misa_ext_implied_rules[] = {
>      &RVA_IMPLIED, &RVD_IMPLIED, &RVF_IMPLIED,
>      &RVM_IMPLIED, &RVV_IMPLIED, NULL
> @@ -2632,8 +2641,8 @@ RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[] = {
>      &ZHINX_IMPLIED, &ZHINXMIN_IMPLIED, &ZICNTR_IMPLIED,
>      &ZIHPM_IMPLIED, &ZK_IMPLIED, &ZKN_IMPLIED,
>      &ZKS_IMPLIED, &ZVBB_IMPLIED, &ZVE32F_IMPLIED,
> -    &ZVE32X_IMPLIED, &ZVE64D_IMPLIED, &ZVE64F_IMPLIED,
> -    &ZVE64X_IMPLIED, &ZVFBFMIN_IMPLIED, &ZVFBFWMA_IMPLIED,
> +    &ZVE32X_IMPLIED, &ZVE64D_IMPLIED, &ZVE64F_IMPLIED, &ZVE64X_IMPLIED,
> +    &ZVFBFA_IMPLIED, &ZVFBFMIN_IMPLIED, &ZVFBFWMA_IMPLIED,
>      &ZVFH_IMPLIED, &ZVFHMIN_IMPLIED, &ZVKN_IMPLIED,
>      &ZVKNC_IMPLIED, &ZVKNG_IMPLIED, &ZVKNHB_IMPLIED,
>      &ZVKS_IMPLIED,  &ZVKSC_IMPLIED, &ZVKSG_IMPLIED, &SSCFG_IMPLIED,
> -- 
> 2.52.0
> 

