Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73AF2CF9C6F
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2024 13:25:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1st5Wi-00035J-FV; Tue, 24 Sep 2024 09:24:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1st5WX-0002io-Fx
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 09:24:13 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1st5WV-0002rq-LJ
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 09:24:13 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-42cb2191107so45580335e9.1
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2024 06:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1727184250; x=1727789050; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=hygWiGR1dFzAlDfX23cZESU/Xew9gCSHl1aDomvzy8o=;
 b=c6wt0NUzyaVsqatiM3ZR9bbRijnf6EnbXm56/+Wi709ratUEPtoRRVt5/8CirTuRcJ
 aXaFUVK+GSH49mZKP5Jn2vjCxbw6EpTsxtLA9FiTpZRlq/rXymkZRM+kAZZODMZeWuzA
 sLU0OR1lda+ayzE5s5OY5cRfPANsDm/fSa6u1F5bqOyp9m/EcSa0/CLhJGeMXtNtyC1k
 9SrwZj5rgpvcSrcMcJpDzlobv50F1j6BnQXEAfc+WPA+2JjT1Q9iyEcOphsglV+wEJIl
 YBg1299Prp7Vp+mWFZBuE/veDOVPqIVEZB+lpKyq9n9YrRBEFoStmcj8OZYBNiDXjs5k
 F2RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727184250; x=1727789050;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hygWiGR1dFzAlDfX23cZESU/Xew9gCSHl1aDomvzy8o=;
 b=UD/qebjlaLlbTdnxCzfdckErI5r5OdAxKYo1ha8Sv5InO3AT1gT3hOqAMu7z/y+6Xk
 e0TmWTKCVU8yAbUvRRtMkwd8HqmJF1J9VFbGlRvk6A9AwotI7kRjfuFd5VlqC3NtoJ+K
 Ih6C2+rFN5ZyHWRkSgim0tMeryCxNxgICLGHQRiuUqgUgtc++3K3OEHeMFGVtJPeAZei
 68jEnFh6JiA/1c7bGgncFGBSKqJLyO5ee1yjwtgAIIy6TUFUXVESXg584Qkn5XXx/YLn
 Vf/sGibRBGJvA3y6aqXFnTXd9lvBVrZaBwHTxjVG44sigAzVDGx4RQpepxQr8+8CgVrr
 OEpg==
X-Gm-Message-State: AOJu0YzQLU8XUuxWu8S+ZN02R64Cbc4x4YU2b5r85GelL0V9Kfy7BBS2
 bV9kVDXMPLPLlXPHFxK8NcturMdXSFTxzH1YiXGKcFNeDg6K8LoZUFyK9FUJR5c=
X-Google-Smtp-Source: AGHT+IEeAQDAZXWlUT3vg4QMpdCJRHUrMsBCVuqgzdN+F7vE9JSTF6hLqBrkBnDUKTf437i2ThyHmA==
X-Received: by 2002:a05:600c:1f10:b0:427:ff3b:7a20 with SMTP id
 5b1f17b1804b1-42e7c1949fdmr90847415e9.27.1727184249894; 
 Tue, 24 Sep 2024 06:24:09 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e9025c517sm19897285e9.0.2024.09.24.06.24.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Sep 2024 06:24:09 -0700 (PDT)
Date: Tue, 24 Sep 2024 15:24:08 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: zhouquan@iscas.ac.cn
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, dbarboza@ventanamicro.com
Subject: Re: [PATCH 2/2] target/riscv/kvm: Update kvm exts to Linux v6.11
Message-ID: <20240924-4ed57d7311448f6bc23f7cdf@orel>
References: <cover.1727164986.git.zhouquan@iscas.ac.cn>
 <ada40759a79c0728652ace59579aa843cb7bf53f.1727164986.git.zhouquan@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ada40759a79c0728652ace59579aa843cb7bf53f.1727164986.git.zhouquan@iscas.ac.cn>
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=ajones@ventanamicro.com; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Tue, Sep 24, 2024 at 04:30:01PM GMT, zhouquan@iscas.ac.cn wrote:
> From: Quan Zhou <zhouquan@iscas.ac.cn>
> 
> Add support for a few Zc* extensions, Zimop, Zcmop and Zawrs.
> 
> Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
> ---
>  target/riscv/kvm/kvm-cpu.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index f6e3156b8d..428aaee552 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -281,7 +281,10 @@ static KVMCPUConfig kvm_multi_ext_cfgs[] = {
>      KVM_EXT_CFG("zihintntl", ext_zihintntl, KVM_RISCV_ISA_EXT_ZIHINTNTL),
>      KVM_EXT_CFG("zihintpause", ext_zihintpause, KVM_RISCV_ISA_EXT_ZIHINTPAUSE),
>      KVM_EXT_CFG("zihpm", ext_zihpm, KVM_RISCV_ISA_EXT_ZIHPM),
> +    KVM_EXT_CFG("zimop", ext_zimop, KVM_RISCV_ISA_EXT_ZIMOP),
> +    KVM_EXT_CFG("zcmop", ext_zcmop, KVM_RISCV_ISA_EXT_ZCMOP),
>      KVM_EXT_CFG("zacas", ext_zacas, KVM_RISCV_ISA_EXT_ZACAS),
> +    KVM_EXT_CFG("zawrs", ext_zawrs, KVM_RISCV_ISA_EXT_ZAWRS),
>      KVM_EXT_CFG("zfa", ext_zfa, KVM_RISCV_ISA_EXT_ZFA),
>      KVM_EXT_CFG("zfh", ext_zfh, KVM_RISCV_ISA_EXT_ZFH),
>      KVM_EXT_CFG("zfhmin", ext_zfhmin, KVM_RISCV_ISA_EXT_ZFHMIN),
> @@ -292,6 +295,10 @@ static KVMCPUConfig kvm_multi_ext_cfgs[] = {
>      KVM_EXT_CFG("zbkc", ext_zbkc, KVM_RISCV_ISA_EXT_ZBKC),
>      KVM_EXT_CFG("zbkx", ext_zbkx, KVM_RISCV_ISA_EXT_ZBKX),
>      KVM_EXT_CFG("zbs", ext_zbs, KVM_RISCV_ISA_EXT_ZBS),
> +    KVM_EXT_CFG("zca", ext_zca, KVM_RISCV_ISA_EXT_ZCA),
> +    KVM_EXT_CFG("zcb", ext_zcb, KVM_RISCV_ISA_EXT_ZCB),
> +    KVM_EXT_CFG("zcd", ext_zcd, KVM_RISCV_ISA_EXT_ZCD),
> +    KVM_EXT_CFG("zcf", ext_zcf, KVM_RISCV_ISA_EXT_ZCF),
>      KVM_EXT_CFG("zknd", ext_zknd, KVM_RISCV_ISA_EXT_ZKND),
>      KVM_EXT_CFG("zkne", ext_zkne, KVM_RISCV_ISA_EXT_ZKNE),
>      KVM_EXT_CFG("zknh", ext_zknh, KVM_RISCV_ISA_EXT_ZKNH),
> -- 
> 2.34.1
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

