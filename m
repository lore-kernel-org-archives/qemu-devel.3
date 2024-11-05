Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 146E2D3E77D
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 22:55:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8SSR-00049l-8W; Tue, 05 Nov 2024 17:55:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1t8SRw-0003px-4F; Tue, 05 Nov 2024 17:55:00 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1t8SRu-0005uG-Fx; Tue, 05 Nov 2024 17:54:59 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43193678216so51492675e9.0; 
 Tue, 05 Nov 2024 14:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730847296; x=1731452096; darn=nongnu.org;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JtorxFxi8QafuwEeSohCjGPr73xJUw13HrFaS46b8SY=;
 b=TZjUzZpv6Lpeowy0t4DBPwqYTa8ik2c/jW9SOsLPQ2IhghD3h/X18GaTyJbzilTXYM
 LUV6F/xPd72fkkGsjAgFqNeg+jfVNTUYYviEe+Jvq0Xy1fj/Lf1ibl4Y8MGn3Kf5sVtA
 xDL6WC0/3jRq2MXem1bqkQyAd2DHBsHYPV/Im+K2F39RisfFHdabMui23wKhbHNClihL
 CmRg8kiEtRdxeGuttmtac8/mymIHtoJLRWjU9UMllu6cesAaiAohNv/z5xy15ZNB2uZu
 Qw7gB9VExMzevi8G+5gstz72E75Kq76RqrwpXiu3KiChGVBZuCJhewtWrjBHw1Lh3f+h
 tKUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730847296; x=1731452096;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:message-id:subject:cc
 :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JtorxFxi8QafuwEeSohCjGPr73xJUw13HrFaS46b8SY=;
 b=i8NTVZM/jK+pcgMdSCdw/cdMbXYH+J/jUYx4GJyzibexK+1UhRl4Fhja95/mo1ZYmS
 Ao0hgDmy9gR2HIWkighF90gZ+iNos4RbQ6jcG/XMq9wkFu+sUMFJ9ZCFlk6j+ZyJanKj
 ox+GkNJxcb7QWGbCo3LRx7sNgodJhFcsy3zZ8bs3vRN6BGXnYES3Pg05aEHmkT6XPJQk
 xCsztIbq1+7fzaHlog9cRVZmAs89QMJGwJqGn2txYkmA8Cb6uPjrSaQ0riFNYETKgOMX
 bMtRhHxXsNZs5XJ9GJu1PCSe+7k4gpfVvxyUUmgWD/IIKwz1djsv0ebthJvu1ISH9jaT
 iV4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjSxDRX3tJ0XeYQ4lN9yopKn9c9jB7xBu1G4D9lVxMoNaOy5p6QUA7E/qoeLhOfsyrGA3OdvlpvQ==@nongnu.org
X-Gm-Message-State: AOJu0YzUYH/5m91ykN69KF38Tmmy08CLKANvYAGl4OMGIDAGusgTGKUg
 I3WKplyOg3LgClB9wktksYQqo/A4EWrKZbEe3yWThrrvt2CmnuliZ1N5rgwUV1I=
X-Google-Smtp-Source: AGHT+IE9knTGbwa76qg1fPyMtT8vHHrgHPwY7cIgO3CGZjxKnw8yFpMJWyP/tdMXv3raoLj0y3biCg==
X-Received: by 2002:a05:600c:cc5:b0:432:a36b:d896 with SMTP id
 5b1f17b1804b1-432a36bd911mr35433335e9.26.1730847295694; 
 Tue, 05 Nov 2024 14:54:55 -0800 (PST)
Received: from gmail.com ([89.101.60.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432a267dfadsm33940665e9.0.2024.11.05.14.54.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2024 14:54:54 -0800 (PST)
Date: Tue, 5 Nov 2024 23:54:54 +0100
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Anton Johansson <anjo@rev.ng>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 devel@lists.libvirt.org,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 01/19] target/microblaze: Rename CPU endianness property
 as 'little-endian'
Message-ID: <ZyqiPrf2wjP1yAPz@zapote>
References: <20241105130431.22564-1-philmd@linaro.org>
 <20241105130431.22564-2-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241105130431.22564-2-philmd@linaro.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-wm1-x32e.google.com
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

On Tue, Nov 05, 2024 at 02:04:13PM +0100, Philippe Mathieu-Daudé wrote:
> Rename the 'endian' property as 'little-endian' because the 'ENDI'
> bit is set when the endianness is in little order, and unset in
> big order.

Hi Phil,

Unfortunately, these properties are not only QEMU internal these got named
from the bindings Xilinx choose way back in time.

This will likely break many of the Xilinx flows with automatic dts to
qemu property conversions so I don't think it's a good idea to rename it.
If you like to clarify things perhaps we could keep an alias for the old
one?

For example:
https://github.com/torvalds/linux/blob/master/arch/microblaze/boot/dts/system.dts#L73

Cheers,
Edgar


> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  hw/microblaze/petalogix_ml605_mmu.c | 2 +-
>  hw/microblaze/xlnx-zynqmp-pmu.c     | 2 +-
>  target/microblaze/cpu.c             | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/microblaze/petalogix_ml605_mmu.c b/hw/microblaze/petalogix_ml605_mmu.c
> index b4183c5267d..df808ac323e 100644
> --- a/hw/microblaze/petalogix_ml605_mmu.c
> +++ b/hw/microblaze/petalogix_ml605_mmu.c
> @@ -90,7 +90,7 @@ petalogix_ml605_init(MachineState *machine)
>      object_property_set_int(OBJECT(cpu), "use-fpu", 1, &error_abort);
>      object_property_set_bool(OBJECT(cpu), "dcache-writeback", true,
>                               &error_abort);
> -    object_property_set_bool(OBJECT(cpu), "endianness", true, &error_abort);
> +    object_property_set_bool(OBJECT(cpu), "little-endian", true, &error_abort);
>      qdev_realize(DEVICE(cpu), NULL, &error_abort);
>  
>      /* Attach emulated BRAM through the LMB.  */
> diff --git a/hw/microblaze/xlnx-zynqmp-pmu.c b/hw/microblaze/xlnx-zynqmp-pmu.c
> index 1bfc9641d29..43608c2dca4 100644
> --- a/hw/microblaze/xlnx-zynqmp-pmu.c
> +++ b/hw/microblaze/xlnx-zynqmp-pmu.c
> @@ -90,7 +90,7 @@ static void xlnx_zynqmp_pmu_soc_realize(DeviceState *dev, Error **errp)
>      object_property_set_bool(OBJECT(&s->cpu), "use-pcmp-instr", true,
>                               &error_abort);
>      object_property_set_bool(OBJECT(&s->cpu), "use-mmu", false, &error_abort);
> -    object_property_set_bool(OBJECT(&s->cpu), "endianness", true,
> +    object_property_set_bool(OBJECT(&s->cpu), "little-endian", true,
>                               &error_abort);
>      object_property_set_str(OBJECT(&s->cpu), "version", "8.40.b",
>                              &error_abort);
> diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
> index 135947ee800..e9f98806274 100644
> --- a/target/microblaze/cpu.c
> +++ b/target/microblaze/cpu.c
> @@ -368,7 +368,7 @@ static Property mb_properties[] = {
>      DEFINE_PROP_UINT8("use-non-secure", MicroBlazeCPU, cfg.use_non_secure, 0),
>      DEFINE_PROP_BOOL("dcache-writeback", MicroBlazeCPU, cfg.dcache_writeback,
>                       false),
> -    DEFINE_PROP_BOOL("endianness", MicroBlazeCPU, cfg.endi, false),
> +    DEFINE_PROP_BOOL("little-endian", MicroBlazeCPU, cfg.endi, false),
>      /* Enables bus exceptions on failed data accesses (load/stores).  */
>      DEFINE_PROP_BOOL("dopb-bus-exception", MicroBlazeCPU,
>                       cfg.dopb_bus_exception, false),
> -- 
> 2.45.2
> 

