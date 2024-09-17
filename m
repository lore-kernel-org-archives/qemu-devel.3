Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63929C35FFF
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 12:14:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqX5o-0000Ea-HM; Tue, 17 Sep 2024 08:14:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1sqX5i-0000Cq-R9
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 08:14:00 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1sqX5g-0006rJ-Vt
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 08:13:58 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-374cacf18b1so3301434f8f.2
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2024 05:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1726575235; x=1727180035; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=MC7n5cuZfeSytA1WhfmxSyFOkG4NsKzOjqRAv+n83No=;
 b=g1wEqOq3t6L0JWoJ+rZFUl0YfxwPOjeAAm0aMn0PSDRVkFGAXuOqeSonY9lpl8GU6h
 9q45ZavtxHBxI9iUEkNZJX73T847YCTV7iK4WpxkUZBq7CJmI0XJUuqOLsDcMCBx7m3p
 1+HV+XIZxEHI/rZowubS9oMHn0bFaHM6QEf4nB57v3uSIw955ebQI+MHaAB2uL0fcpn+
 YUkOXvhp0tI/EquFatHmDhHGigtjKsEUPzA1Zrsd3IXNnfw6UbeYaVtJjn3Yc+wsEfU2
 grFyLd+V0wQmFz90NhrTr1cZC2qXsEMexfzedMB3HaMrr22FHusPewhhkrXz1d/1t+JF
 /nWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726575235; x=1727180035;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MC7n5cuZfeSytA1WhfmxSyFOkG4NsKzOjqRAv+n83No=;
 b=eaHNb9B0E5sbbWzfp91ITmnz8DhUnYj4hEha/tdBIVfm8KISK3i91Rnhm4FF1OuNSc
 sAGNS2jrJKpck+Ay9KF3ZR0St5xIxq9Z38Y/s9281sloc4Z25/YKDMr9pSNHUEyYnYlj
 fZko32nY8Yoqb6M7Dm9pv6p2SrhgVHVZNl9Uu124o3DNFPu6v5B2uawvxQ4YKXPgSkhZ
 u8xNjiSyT4psozLrHzY8cRXPTkktxjrVj/PZLKvbpvLl/Y6+fo30ahCVvofxvrrs3ub2
 XW/9lhOqXA5H1dyWfCBAg55D79mwEKOKaRP/vLlKx3ciqLu2z3dRFzOfBTwZKZbJthcT
 qC/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUY3SRJo5SExYs7z+I3CW0F3CCWI/Cd3MF8RV2ZUgY+pW/QPXfb6N0p/QYzCbxdf3wATDf5IywdBFOB@nongnu.org
X-Gm-Message-State: AOJu0YwQGfTHYSqm8JfWEMjIUOIGvTMG797/dYoQTcb/ZzDcxGuW/uV8
 X37QzoIWHBV99WIxE3WeUK9K16//hVIPsLKZAQ8SiwoTCAeDXKEGbwkz4CuH6Ag=
X-Google-Smtp-Source: AGHT+IE5pOk6khKzpywNQbacL3gukULELrLhmknBhWl5mLFjzgvroDkQg/8ig4VVqGPm5QgSfLtP2Q==
X-Received: by 2002:a5d:5f52:0:b0:374:c949:836d with SMTP id
 ffacd0b85a97d-378c2d4d80fmr11539368f8f.37.1726575234136; 
 Tue, 17 Sep 2024 05:13:54 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378e72e4abfsm9452724f8f.16.2024.09.17.05.13.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Sep 2024 05:13:53 -0700 (PDT)
Date: Tue, 17 Sep 2024 14:13:52 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org, 
 qemu-devel@nongnu.org
Subject: Re: [PATCH 1/1] target/riscv: enable floating point unit
Message-ID: <20240917-f45624310204491aede04703@orel>
References: <20240916181633.366449-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240916181633.366449-1-heinrich.schuchardt@canonical.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=ajones@ventanamicro.com; helo=mail-wr1-x42a.google.com
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

On Mon, Sep 16, 2024 at 08:16:33PM GMT, Heinrich Schuchardt wrote:
> OpenSBI enables the floating point in mstatus. For consistency QEMU/KVM
> should do the same.
> 
> Without this patch EDK II with TLS enabled crashes when hitting the first
> floating point instruction while running QEMU with --accel kvm and runs
> fine with --accel tcg.
> 
> Additionally to this patch EDK II should be changed to make no assumptions
> about the state of the floating point unit.
> 
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  target/riscv/cpu.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 4bda754b01..c32e2721d4 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -923,6 +923,13 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
>      if (mcc->parent_phases.hold) {
>          mcc->parent_phases.hold(obj, type);
>      }
> +    if (riscv_has_ext(env, RVF) || riscv_has_ext(env, RVD)) {
> +        env->mstatus = set_field(env->mstatus, MSTATUS_FS, env->misa_mxl);
> +        for (int regnr = 0; regnr < 32; ++regnr) {
> +            env->fpr[regnr] = 0;
> +        }
> +        riscv_csrrw(env, CSR_FCSR, NULL, 0, -1);
> +    }

If this is only fixing KVM, then I think it belongs in
kvm_riscv_reset_vcpu(). But, I feel like we're working around an issue
with KVM synchronization with this, as well as with the "clear CSR values"
part of commit 8633951530cc ("target/riscv: Clear CSR values at reset and
sync MPSTATE with host"). KVM knows how to reset VCPUs. It does so on
VCPU creation and for any secondaries started with SBI HSM start. KVM's
reset would set sstatus.FS to 1 ("Initial") and zero out all the fp
registers and fcsr. So it seems like we're either synchronizing prior to
KVM resetting the boot VCPU, not synchronizing at all, or KVM isn't doing
the reset of the boot VCPU.

Thanks,
drew

