Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD9F2EE208C
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 12:05:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voKZl-0006ln-4S; Fri, 06 Feb 2026 07:04:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1voKZj-0006lT-5n
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 07:04:39 -0500
Received: from mail-dl1-x1241.google.com ([2607:f8b0:4864:20::1241])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1voKZh-0005tG-NF
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 07:04:38 -0500
Received: by mail-dl1-x1241.google.com with SMTP id
 a92af1059eb24-124a95e592fso790038c88.0
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 04:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770379476; x=1770984276; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=JJrultBLuzMSJOQ1itBCUr5d2IfXbGD9P5qoy68FoCI=;
 b=ayoYpCmsGx3tqWbXuJMfPBxh0V7ZrpsaEHmZTmOQLT/t4NVGMzc5o1WdMugxs2Idak
 GX/92Ij/Gg38HnGb3dlOHdU+YHbwXAbcZGGJO/Sq0WNoaGaY8Ol+3yNi9+XcOYkXv8wT
 4EiV+WIM2Vbqgc5yDr4WS3zMLkrLkKP0JP+iHbvGmfuVFH1G9ZKiSb0r0fkmIDrGONap
 qT0vP8F/yeoxkdTAjNsPWnnGPEA6wY1IyFyuufxg+ZQOtRb2p+ter+ikrLCi00zMi/aZ
 pRZUxV9/dQoDR//Feg8hQQn9U3mRK0z1QgyrHuHOf9UtlWz0HvcKPTXPLWKFDUI3NxPn
 c+nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770379476; x=1770984276;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JJrultBLuzMSJOQ1itBCUr5d2IfXbGD9P5qoy68FoCI=;
 b=Vi7I6t3AN0ifiwMqErKUuiOY2OKNuLm4rexcTlj3Tm2BY4NaCwDQUHUzXBKNuBHJey
 SdNJr1LJnNu0StHh66DUkbVnHsBWu+y5r/Lq34LHj1tdqjdUzMkG365+H+QMLIlZ6Q2z
 7RKBljS1s5FsQsmkhtQd5c4y6eZAdDEKYSS1FNUoMglZBRqIDxUGv68W6iMv2IYvcq8a
 NXSsFSvk0L9Gwi4/vWSDEq7VfmAbHiSYpcmkBTLArPM7Df9Aj4tXsdWJzSv8Wd8TZAU+
 qalo554gvYBW9pdfGxseBjtV4wPtIlhOlP7oOBGzyUfF4Wba7tREfS7iQ+3Rx3xb8iZx
 4SAQ==
X-Gm-Message-State: AOJu0Yx66ZTA0tfCgg/61KykX43+wzT/vLu1z8/YsntXwKgMCUSrDJK6
 wcTPh7JpP2oQdIX353Fv5e60UytXpclwEB2ePad15RirWtYEuRCTb+Ar
X-Gm-Gg: AZuq6aI4IXB3fCX1AGQItWvNeBdxQPTTk8jIqDHX1aBBQP5TxrBU4oh1xiJlhK9IO86
 Wk/mSsH83w5Tbkx2AyETuEMolhT/wggw82R5KGTGildxwzVA63DmCwPJaWNjbYin9xrZjOSkxgN
 /RwrOTQEpbcLAxSr7jD7emmVy1dlnyVbF45E5Rt3FwMi+HwVyoLgCHWlhfXCdyTahMY4acwnKiq
 Rw9VFJLR73Ug96I53+ZFSR5khHLKCngW4hEM2WB9I6Rn8kffok+TZXAVvnRRqJjat2wQGMyzcFW
 Fe1HG0sBU0FpaHRROk7NOqCBhZHzAzcg6QZvv4YcHTTHDhlCdLZr0elAY5kIg0MsFgLg1qMl5zT
 Yl/FJ4hW1oRHpKtMB4w7X+uKhxzopVvxpb28BevdLeH36rXsZn/K9WY3FPvUp9XhD0R6cBGXzYQ
 RZlOOO85EnYM/VhqhrNKolDjD6myMz78CURlT6kYhdnZN3PMyT2vtVk6t7OMjnx/FZIoHBB+f+V
 4usZgs5S1hBQq4Am44=
X-Received: by 2002:a05:7022:6ba6:b0:11b:9386:a3c8 with SMTP id
 a92af1059eb24-127041868c5mr1440735c88.41.1770379475998; 
 Fri, 06 Feb 2026 04:04:35 -0800 (PST)
Received: from ZEVORN-PC.localdomain ([38.95.120.198])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1270433ae42sm1468370c88.10.2026.02.06.04.04.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Feb 2026 04:04:35 -0800 (PST)
Date: Fri, 6 Feb 2026 20:04:14 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: =?utf-8?Q?S=C3=A9bastien?= Michelland <sebastien.michelland@inria.fr>
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Max Chou <max.chou@sifive.com>, qemu-riscv@nongnu.org, 
 Jean-Michel Gorius <jean-michel.gorius@irisa.fr>
Subject: Re: [PATCH v3] target/riscv: fix require_rvv passing on non-RVV CPUs
Message-ID: <aYXXpPCZ0atIRcPX@ZEVORN-PC.localdomain>
References: <20260206100256.1360597-1-sebastien.michelland@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260206100256.1360597-1-sebastien.michelland@inria.fr>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1241;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dl1-x1241.google.com
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

Hi Sébastien,

On Fri, Feb 06, 2026 at 11:01:23AM +0100, Sébastien Michelland wrote:
> trans_rvv.c.inc checks for the RVV extension through the function
> require_rvv. However, at least under CONFIG_USER_ONLY, the RVV extension
> status in DisasContex->mstatus_vs is always set to DIRTY, therefore
> treating RVV instructions as legal even when the extension is not
> present, e.g. with -cpu=rv32,v=false.
> 
> This bug manifests rarely because vset{i}vl{i} perform extra checks that
> do fail without RVV, thus raising SIGILL, and with no vtype set nearly
> all other RVV instructions still pass require_rvv but fail the vill check.
> Only instructions that don't depend on type (whole-register load/stores,
> such as vs*r.v) would show the bug by being executed when v=false.
> 
> This patch sets mstatus_vs to DISABLED when RVV is not present (checked
> with the minimalistic Zve32x), meaning require_rvv now fails as intended.
> 
> Signed-off-by: Sébastien Michelland <sebastien.michelland@inria.fr>
> ---
> Thanks Max for your patience with this patch.
> 
>  target/riscv/tcg/tcg-cpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 988b2d905f..9c2c3ac278 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -153,7 +153,7 @@ static TCGTBCPUState riscv_get_tb_cpu_state(CPUState *cs)
>  
>  #ifdef CONFIG_USER_ONLY
>      fs = EXT_STATUS_DIRTY;
> -    vs = EXT_STATUS_DIRTY;
> +    vs = cpu->cfg.ext_zve32x ? EXT_STATUS_DIRTY : EXT_STATUS_DISABLED;
This change looks good and perfect to me. Thanks for your contribution!

Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>

Thanks,
Chao
>  #else
>      flags = FIELD_DP32(flags, TB_FLAGS, PRIV, env->priv);
>  
> -- 
> 2.52.0
> 
> 

