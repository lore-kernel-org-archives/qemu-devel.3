Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AFD5C54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 08:57:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkKQ7-0006ld-7h; Wed, 13 Mar 2024 04:57:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1rkKQ6-0006lF-0m
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 04:57:06 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1rkKQ3-0001wN-W7
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 04:57:05 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-33d90dfe73cso324124f8f.0
 for <qemu-devel@nongnu.org>; Wed, 13 Mar 2024 01:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1710320219; x=1710925019; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zzeXVOwj4j/YDqEdvW6/fBZnpKw/FuA6FRyIKZNEoVw=;
 b=W0U38b8kM2/8/20439EwSh0IsKOi5FyeI5E3EVMvUyhJoi2iWO+31kBKi188LFm5/m
 6CO5VOM7MsduOw6EQKEErTO+g+pa+51BSbr+6v6CAxJgMnOJQpng150HomEQI7Y4tblg
 4Tvu+/MxDACSyrCIAHmYfJJJCzKNQCYa2XfbmVU8S2lCdVaYBSgsE1LGxI/ewX+akqoH
 FMnf7IgI5XpRbGnhqhHu8Cbcwm1Xf81FKvLB5bH8OCjzfQB/AqO3RQsP9KMydVH2LkPS
 QOcyLvKi8nGx0XmeVTiGS/964/XUtCM9c/dRsuKutgDNcDCG+2vvO7H/7s/+2rriGhJ/
 NZzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710320219; x=1710925019;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zzeXVOwj4j/YDqEdvW6/fBZnpKw/FuA6FRyIKZNEoVw=;
 b=TBfkYLSR6eqPGSp54MPSq3JG9QkRjYqEfY5HnE1pesEYqjU/CLuKkmtR7r6i3lhXVo
 yRF7UahpFcgy0IJtQEnNagZ2ueGaYLhM1gycfvTuSCDkhUMck3sHUTpiQwDkCi759muE
 8WQig4afRRCf8uyNG4U5ItVVrvJ48IEPgdus9T8x5iN07UkLdp4pRrW9LkfP15YEqyC4
 p8dT0x5mBpP1ffuX1MnTP375ZYTIcdLBd4ZnPu//itCF7++itqCqfE3gHE8Uqafu2ZHY
 5J0JvuBGy870s5bzSoQ3Vp02I9Kig0tUKmryIlEXpTXP/6VybRs6TF9r7J/piPDrVcaL
 7/2Q==
X-Gm-Message-State: AOJu0Yyi/YaJq/R4RuRVSALSPWrVhjZoz9kaHKxJfHdHr1X7Vern8QYU
 9tjr62lV967KdfVNyZ1GCrwo9tva03OLI3D8iuIRP/UBHxlNzj7gmlkn9CzCuF8=
X-Google-Smtp-Source: AGHT+IFsTPMYvibcG3IfeN0KXC3CUkO5eaGAhCqPOBPryOwWsAcS2CKxby7Yl3sOI3T/ShHm9e7Kyg==
X-Received: by 2002:adf:cb92:0:b0:33d:61c7:9b2c with SMTP id
 q18-20020adfcb92000000b0033d61c79b2cmr1411915wrh.34.1710320219272; 
 Wed, 13 Mar 2024 01:56:59 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
 by smtp.gmail.com with ESMTPSA id
 n20-20020a05600c4f9400b00412f8bf2d82sm1636864wmq.28.2024.03.13.01.56.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Mar 2024 01:56:58 -0700 (PDT)
Date: Wed, 13 Mar 2024 09:56:52 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, greentime.hu@sifive.com, 
 vincent.chen@sifive.com, frank.chang@sifive.com, jim.shu@sifive.com, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH 1/1] target/riscv/kvm: fix timebase-frequency when using
 KVM acceleration
Message-ID: <20240313-d11a0490609909bd354f01b2@orel>
References: <20240313081359.20845-1-yongxuan.wang@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240313081359.20845-1-yongxuan.wang@sifive.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=ajones@ventanamicro.com; helo=mail-wr1-x42d.google.com
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

On Wed, Mar 13, 2024 at 04:13:57PM +0800, Yong-Xuan Wang wrote:
> The timebase-frequency of guest OS should be the same with host
> machine. The timebase-frequency value in DTS should be got from
> hypervisor when using KVM acceleration.
> 
> Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
> ---
>  hw/riscv/virt.c              | 11 +++++++++--
>  target/riscv/kvm/kvm-cpu.c   |  9 +++++++++
>  target/riscv/kvm/kvm_riscv.h | 13 +++++++++++++
>  3 files changed, 31 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index a094af97c32a..a7ed7fa13010 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -710,8 +710,15 @@ static void create_fdt_sockets(RISCVVirtState *s, const MemMapEntry *memmap,
>      int socket_count = riscv_socket_count(ms);
>  
>      qemu_fdt_add_subnode(ms->fdt, "/cpus");
> -    qemu_fdt_setprop_cell(ms->fdt, "/cpus", "timebase-frequency",
> -                          RISCV_ACLINT_DEFAULT_TIMEBASE_FREQ);
> +
> +    if (kvm_enabled()) {
> +        qemu_fdt_setprop_cell(ms->fdt, "/cpus", "timebase-frequency",
> +                              kvm_riscv_get_timebase_frequency(first_cpu));
> +    } else {
> +        qemu_fdt_setprop_cell(ms->fdt, "/cpus", "timebase-frequency",
> +                              RISCV_ACLINT_DEFAULT_TIMEBASE_FREQ);
> +    }
> +
>      qemu_fdt_setprop_cell(ms->fdt, "/cpus", "#size-cells", 0x0);
>      qemu_fdt_setprop_cell(ms->fdt, "/cpus", "#address-cells", 0x1);
>      qemu_fdt_add_subnode(ms->fdt, "/cpus/cpu-map");
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index c7afdb1e81b7..bbb115eaa867 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -739,6 +739,15 @@ static void kvm_riscv_put_regs_timer(CPUState *cs)
>      env->kvm_timer_dirty = false;
>  }
>  
> +uint64_t kvm_riscv_get_timebase_frequency(CPUState *cs)
> +{
> +    uint64_t reg;
> +
> +    KVM_RISCV_GET_TIMER(cs, frequency, reg);
> +
> +    return reg;
> +}
> +
>  static int kvm_riscv_get_regs_vector(CPUState *cs)
>  {
>      RISCVCPU *cpu = RISCV_CPU(cs);
> diff --git a/target/riscv/kvm/kvm_riscv.h b/target/riscv/kvm/kvm_riscv.h
> index 4bd98fddc776..130a4bde0480 100644
> --- a/target/riscv/kvm/kvm_riscv.h
> +++ b/target/riscv/kvm/kvm_riscv.h
> @@ -29,4 +29,17 @@ void riscv_kvm_aplic_request(void *opaque, int irq, int level);
>  int kvm_riscv_sync_mpstate_to_kvm(RISCVCPU *cpu, int state);
>  void riscv_kvm_cpu_finalize_features(RISCVCPU *cpu, Error **errp);
>  
> +#ifdef CONFIG_KVM
> +
> +uint64_t kvm_riscv_get_timebase_frequency(CPUState *cs);
> +
> +#else
> +
> +static inline uint64_t kvm_riscv_get_timebase_frequency(CPUState *cs)
> +{
> +    g_assert_not_reached();
> +}
> +
> +#endif
> +

I think we've decided we don't need stubs like these since kvm_riscv_*
functions should always be called within 'if (kvm_enabled())' blocks (as
you have above), and then we leave it to the compile testing to point
out kvm function calls without kvm_enabled().

>  #endif
> -- 
> 2.17.1
>

Besides dropping the stubs,

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Thanks,
drew

