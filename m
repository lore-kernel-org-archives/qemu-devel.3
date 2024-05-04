Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C58EC4345F
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2024 13:41:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3Fda-0007ps-60; Sat, 04 May 2024 09:41:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s3FdS-0007lB-D0
 for qemu-devel@nongnu.org; Sat, 04 May 2024 09:41:06 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s3FdP-0002oP-Ha
 for qemu-devel@nongnu.org; Sat, 04 May 2024 09:41:05 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a59a17fcc6bso108704466b.1
 for <qemu-devel@nongnu.org>; Sat, 04 May 2024 06:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714830060; x=1715434860; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Hm/autToj4DhlFSlV5COkbhV3epwF7npYCOhv4VZBBg=;
 b=igqxn5flQvq5q6XfkNo3WcFQKJJNtq+tckalyr9EhzQpLJGEZQTZYJhj6deMKXOS82
 BZ8FbR6yW1HMrUtxeoK4wlaD37yn/FmrLreMYjQEXM+qiu4Em0LS9XSj9u98o9Aesbs2
 WQy2M4nzcBhdbEfpDj98e8WGzlD8g/IGFnQaCzOhmp9q8qj7IYiNml0U9CHBVgKWpImT
 FQ3D9cRZPucaY/gQMBwQ0JySnyghbYU8P1HsnieZLYczv1l1JZWyEXrJg1YkG7trT/OV
 QPusPuUoqcSCYLGIY944WKQ5+mq+0W2Ae/Dzh1baKEn9eiv71FqsurhDw2PXEVQ1NfPM
 21nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714830060; x=1715434860;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Hm/autToj4DhlFSlV5COkbhV3epwF7npYCOhv4VZBBg=;
 b=LD7iw/x5RE47eEARZJz82vsXOinXJMjyf5k8be9hHFYCVkmoSv/YWXed1wZnZqq2TK
 NK2HEm4xmgR5ZewjkcEg3/lbOqcPTb99DsUBg+X8/t5uQWkeIHNWkHKUTpSaYELLZxQB
 ngdPzg5ze3bQ8ixwtFiT1Fiu1QsFG6qdDKrM2wFkw6KB0PlZCtL5efjO+cZ/0iYyuRWo
 oKf/Rnrl+Q2zU/a9amMPYJzYaK+PqwwVdunh6hZ24+TLoe1KiS/vsNPMsKLDzSLlwiKD
 J1tVxKurUAU0wGuI0KPOyjCGf6Fb0A6m2D0sxNz/EJMU7YvAkq8twEEUxJuza+xMI5rP
 Krhg==
X-Gm-Message-State: AOJu0Yz5BM73lxmyNpd5fg4sP40lFG7xds7s8SNudyOWoqAPJHvlulLB
 NwE/QiG4EESTFKSd2PIDpA4eoJNitFJt/5E7TZV/BWmwBy7dBDDuV9jjKX8DxztyRXDJVIyeKrE
 wu8QDmCgH2PsRbI4U+seqDamLfpKk4Ib/LzAY8Q==
X-Google-Smtp-Source: AGHT+IEHGRSWkb8y+Iieyd4mYdMdgxuplZd/DwodXE6USmERlIMhUYPIsmXcXyYHDWBL7zw7Ho22M4KJrjuTLVfxg4I=
X-Received: by 2002:a50:ab5a:0:b0:572:5f8c:42 with SMTP id
 t26-20020a50ab5a000000b005725f8c0042mr3395192edc.0.1714830059846; 
 Sat, 04 May 2024 06:40:59 -0700 (PDT)
MIME-Version: 1.0
References: <20240312020000.12992-1-salil.mehta@huawei.com>
 <20240312020000.12992-7-salil.mehta@huawei.com>
In-Reply-To: <20240312020000.12992-7-salil.mehta@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 4 May 2024 14:40:49 +0100
Message-ID: <CAFEAcA93EotG4-LXRJF034_9dWAWgZJA1VF6dB-xCsXn0T059g@mail.gmail.com>
Subject: Re: [PATCH V8 6/8] physmem: Add helper function to destroy CPU
 AddressSpace
To: Salil Mehta <salil.mehta@huawei.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, maz@kernel.org, 
 jean-philippe@linaro.org, jonathan.cameron@huawei.com, lpieralisi@kernel.org, 
 richard.henderson@linaro.org, imammedo@redhat.com, andrew.jones@linux.dev, 
 david@redhat.com, philmd@linaro.org, eric.auger@redhat.com, 
 oliver.upton@linux.dev, pbonzini@redhat.com, mst@redhat.com, will@kernel.org, 
 gshan@redhat.com, rafael@kernel.org, alex.bennee@linaro.org, 
 linux@armlinux.org.uk, darren@os.amperecomputing.com, 
 ilkka@os.amperecomputing.com, vishnu@os.amperecomputing.com, 
 karl.heubaum@oracle.com, miguel.luis@oracle.com, salil.mehta@opnsrc.net, 
 zhukeqian1@huawei.com, wangxiongfeng2@huawei.com, wangyanan55@huawei.com, 
 jiakernel2@gmail.com, maobibo@loongson.cn, lixianglai@loongson.cn, 
 linuxarm@huawei.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x632.google.com
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

On Tue, 12 Mar 2024 at 02:02, Salil Mehta <salil.mehta@huawei.com> wrote:
>
> Virtual CPU Hot-unplug leads to unrealization of a CPU object. This also
> involves destruction of the CPU AddressSpace. Add common function to help
> destroy the CPU AddressSpace.
>
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> Tested-by: Xianglai Li <lixianglai@loongson.cn>
> Tested-by: Miguel Luis <miguel.luis@oracle.com>
> Reviewed-by: Shaoqin Huang <shahuang@redhat.com>

> diff --git a/system/physmem.c b/system/physmem.c
> index 6e9ed97597..61b32ac4f2 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -761,6 +761,7 @@ void cpu_address_space_init(CPUState *cpu, int asidx,
>
>      if (!cpu->cpu_ases) {
>          cpu->cpu_ases = g_new0(CPUAddressSpace, cpu->num_ases);
> +        cpu->cpu_ases_count = cpu->num_ases;
>      }
>
>      newas = &cpu->cpu_ases[asidx];
> @@ -774,6 +775,34 @@ void cpu_address_space_init(CPUState *cpu, int asidx,
>      }
>  }
>
> +void cpu_address_space_destroy(CPUState *cpu, int asidx)
> +{
> +    CPUAddressSpace *cpuas;
> +
> +    assert(cpu->cpu_ases);
> +    assert(asidx >= 0 && asidx < cpu->num_ases);
> +    /* KVM cannot currently support multiple address spaces. */
> +    assert(asidx == 0 || !kvm_enabled());
> +
> +    cpuas = &cpu->cpu_ases[asidx];
> +    if (tcg_enabled()) {
> +        memory_listener_unregister(&cpuas->tcg_as_listener);
> +    }
> +
> +    address_space_destroy(cpuas->as);
> +    g_free_rcu(cpuas->as, rcu);
> +
> +    if (asidx == 0) {
> +        /* reset the convenience alias for address space 0 */
> +        cpu->as = NULL;
> +    }
> +
> +    if (--cpu->cpu_ases_count == 0) {
> +        g_free(cpu->cpu_ases);
> +        cpu->cpu_ases = NULL;
> +    }
> +}

When do we need to destroy a single address space in this way
that means we need to keep a count of how many ASes the CPU
currently has? The commit message talks about the case when we
unrealize the whole CPU object, but in that situation you can
just throw away all the ASes at once (eg by calling some
cpu_destroy_address_spaces() function from cpu_common_unrealizefn()).

Also, if we're leaking stuff here by failing to destroy it,
is that a problem for existing CPU types like x86 that we
can already hotplug?

thanks
-- PMM

