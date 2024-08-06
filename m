Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A98C3C3DA64
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 08:27:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbFXH-0003iy-PO; Tue, 06 Aug 2024 04:27:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1sbFXF-0003hC-18
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 04:27:13 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1sbFXD-0002no-FN
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 04:27:12 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a7aa4bf4d1eso31726366b.0
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2024 01:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1722932828; x=1723537628; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=vh5O/hZdvkOcQda85NjGErUkzKwfHFqcsPlaML2iCK0=;
 b=S0irgzHK5ZxZjkQtPC0c4VzPwyDwod2fZdyY+lnY/Xsvyo0bSy2rF0YKWabD0+/BA4
 /Xoid6n+do5QTc0uuNLvtdF2p+ZYh9hgwVHcaRk/jVn0ixPD133Q8PCuL1QFW1mMYDye
 3hN2jl1gJeN0eJABqb5udeLh82Uj4cKIDyeIZZ02h3f7erbJ8wQFPIhmATRTO6uwHFA3
 tXzljROy0iF++NFBLLAeDMR0AmY7H6KcKWekLi5/IvPyiZYUOYn0BujqwyteA5r9Ww+k
 2VFrGGA4+KfDLKV5DM4+ru+64ixYrTwDcb+MO0N9WP3QwrKnTqq5zOKXfS5acf3Us939
 ghQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722932828; x=1723537628;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vh5O/hZdvkOcQda85NjGErUkzKwfHFqcsPlaML2iCK0=;
 b=PTDHgD0+NBi0fIVpkVzXd8NUPSKoQMRR16PpxAdx/AjawF/AhrG8pgs3Lcuy/in5fx
 IcwGSK2wxIDyj+enDD/2kfWGin6wQSLePHx7lLlfxKsl+9xfX1RL1HCZzLIJvC3ISX5K
 RwhUmsLp7YtzaFhUr+vNjymWCzmu7wGIsAlfSMSDSrtazpvoPpii92vPH+1mNDBUJcHo
 y9Hb8WBHdXFuLZoUwdBVhpGb3cD6XeNiyl9GtErmUrt9An/6woH8rRXyLaNyGL6Hd0rB
 GiLp58O6qKRiUQzfaPfXeba1on5woIrt5TLyZwkHbOiq7octNqcEeGYj8hzBFjv2Y7Xe
 wRRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4tGawtxCbov+UmxWg3TJ7b/FDnqlmpk3I9kIC+eec/OApdnb5bBHuyS1EL/G1HKZpMY7HJkfsk2zmA67j9XTcEDtWIYM=
X-Gm-Message-State: AOJu0YzzN6uvKgaJfKZbFnmjmM0NAPNm46NPy3rnCXs3wFOUgcJkeCgE
 7b+g9P9/tutK6mTQTzi2SmWU1BCLD3EpIqRIMaK27F9jTlQ9UnqAYT5M2X/dMMs=
X-Google-Smtp-Source: AGHT+IHCeFwPqd4+AcKntUhKGc95w6ZXpAHQ5nq3i3VTlUSX7MCgDXUV36M0V+8gYFJ7Bhd08IyqgQ==
X-Received: by 2002:a17:906:4fcd:b0:a7a:bece:621d with SMTP id
 a640c23a62f3a-a7dc4fdf9aamr1160423666b.3.1722932827973; 
 Tue, 06 Aug 2024 01:27:07 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9d4dd32sm528450266b.120.2024.08.06.01.27.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Aug 2024 01:27:07 -0700 (PDT)
Date: Tue, 6 Aug 2024 10:27:06 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Alistair Francis <alistair23@gmail.com>
Cc: Atish Patra <atishp@rivosinc.com>, qemu-riscv@nongnu.org, 
 qemu-devel@nongnu.org, palmer@dabbelt.com, liwei1518@gmail.com, 
 zhiwei_liu@linux.alibaba.com, bin.meng@windriver.com, dbarboza@ventanamicro.com,
 alistair.francis@wdc.com
Subject: Re: [PATCH v2 10/13] target/riscv: Enable sscofpmf for bare cpu by
 default
Message-ID: <20240806-99e1599406cf00f8cfc4937c@orel>
References: <20240723-counter_delegation-v2-0-c4170a5348ca@rivosinc.com>
 <20240723-counter_delegation-v2-10-c4170a5348ca@rivosinc.com>
 <CAKmqyKPfVkiiiOTZnFfLEY527AmPqLRxAMG8SS2_X_rZ8RaBFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKmqyKPfVkiiiOTZnFfLEY527AmPqLRxAMG8SS2_X_rZ8RaBFg@mail.gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=ajones@ventanamicro.com; helo=mail-ej1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Aug 06, 2024 at 11:51:20AM GMT, Alistair Francis wrote:
> On Wed, Jul 24, 2024 at 9:33 AM Atish Patra <atishp@rivosinc.com> wrote:
> >
> > Sscofpmf has been supported on virt machine for a long time. It is
> > required to enable profiling on virt machines. Let's enable it
> > by default for ease of usage.
> >
> > Signed-off-by: Atish Patra <atishp@rivosinc.com>
> > ---
> >  target/riscv/cpu.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> > index 1731dc461376..393d1d67120e 100644
> > --- a/target/riscv/cpu.c
> > +++ b/target/riscv/cpu.c
> > @@ -494,6 +494,7 @@ static void rv64_base_cpu_init(Object *obj)
> >      env->priv_ver = PRIV_VERSION_LATEST;
> >  #ifndef CONFIG_USER_ONLY
> >      set_satp_mode_max_supported(RISCV_CPU(obj), VM_1_10_SV57);
> > +    cpu->cfg.ext_sscofpmf = true;
> 
> Unfortunately we don't want to do this, the base CPU should be bare
> bones and then users can enable extensions.

But we do want to enable stuff by default in the 'max' cpu type.

Thanks,
drew

