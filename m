Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 504DDC2BBCA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 11:24:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN9hk-0007n8-9x; Fri, 28 Jun 2024 07:23:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sN9hf-0007ly-Px
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 07:23:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sN9hd-0007Qx-A8
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 07:23:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719573819;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KNt7eLtY7ecstqNxk78TJ+szfD2wbEdl29MARsU7D2Y=;
 b=jNUDcFragScJC+WhMzIC6pcpsKZJiw6DpcFazyAdRx0Ins8ZOgbinWfz9rqqgJ9TEmU2ma
 aogWW0FsyY87rnxLUKvq5I+BtlwxjUAiVVwWfawQDl7l6WwBDt3HejQJGJWsA4JG03jojd
 ri3BO3/cgqFwiJLcHFL6FCVvyx26vZI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-wkKnxqUhMzyf60BawSEPSA-1; Fri, 28 Jun 2024 07:23:38 -0400
X-MC-Unique: wkKnxqUhMzyf60BawSEPSA-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-367380659a3so372714f8f.2
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 04:23:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719573816; x=1720178616;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KNt7eLtY7ecstqNxk78TJ+szfD2wbEdl29MARsU7D2Y=;
 b=BjdQURhdJ9jd+LtCEljTlaT8fU1+5aIU0CJAdQFI1TzUO3ZFEc3krZ9O4Z05UFcs1S
 3wYqR+PSoNpE5gDN8FvIbdtR6+vjwCtEdLbm/EnzSKpuOWyQO5KiC067j45OO8Q51yOC
 yztmoiTfzkXujwjmlO+0L8DB7zyhSh14jPk58nw0x/40r9mhvxkIN3UK306wBfXRklfx
 t9clPevvsKKwWSbC+KqFJQWn/V+V5w7pt36rPLO4xc3J02LjZj1RjkXDpfNmzrxiJ2G1
 2qrSVjhLmyiwjvH+ziZSpPMehDGMlHYAv6o7BzL8bzbYxeUKSppn/qzDHv7Ueerv41wW
 Kz5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUTyEY95SirE57XjJ2oV8vHmmmOou/ltQhlX6fe/8jBPlX6IduDhcw924h/HpOx7z2RO3MSIt6bzwVbeZAjU8uRucOgOEQ=
X-Gm-Message-State: AOJu0YyoUhKukWE/gsHdrQ930UMC3KZHMqtjagJr2eEQI1rAYy9MdjeI
 k+9fVvYpTCkNzE5wlbMtRam349sotYdXta4t7ijIVFR1dLj3HRwMMh/i0mL01cPBqYVWhsCOWnc
 idcs1EnDY0wyzkSDoFUIR61XEVM8Yj0g+eb7z7C/wlGNyElrW/MEYlmLFchj4
X-Received: by 2002:a5d:64c6:0:b0:366:e935:61cb with SMTP id
 ffacd0b85a97d-366e93562ebmr14060245f8f.56.1719573816118; 
 Fri, 28 Jun 2024 04:23:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcynFjWrEl/13pzpDRG7vF7iJWLS/5dKYZUZyXyr3ZTvZxuEabvjN9q6kO4NZkLQU0AtiQ+Q==
X-Received: by 2002:a5d:64c6:0:b0:366:e935:61cb with SMTP id
 ffacd0b85a97d-366e93562ebmr14060226f8f.56.1719573815756; 
 Fri, 28 Jun 2024 04:23:35 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0fb836sm2002980f8f.81.2024.06.28.04.23.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jun 2024 04:23:34 -0700 (PDT)
Date: Fri, 28 Jun 2024 13:23:34 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-devel@nongnu.org, Andrea Righi
 <andrea.righi@canonical.com>
Subject: Re: [PATCH v3 2/3] hw/i386/acpi-build: Return a pre-computed _PRT
 table
Message-ID: <20240628132334.50d14f85@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240607141809.1637137-3-ribalda@chromium.org>
References: <20240607141809.1637137-1-ribalda@chromium.org>
 <20240607141809.1637137-3-ribalda@chromium.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.206,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri,  7 Jun 2024 14:17:25 +0000
Ricardo Ribalda <ribalda@chromium.org> wrote:

> When qemu runs without kvm acceleration the ACPI executions take a great
> amount of time. If they take more than the default time (30sec), the
> ACPI calls fail and the system might not behave correctly.
> 
> Now the _PRT table is computed on the fly. We can drastically reduce the
> execution of the _PRT method if we return a pre-computed table.
> 
> Without this patch:
> [   51.343484] ACPI Error: Aborting method \_SB.PCI0._PRT due to previous error (AE_AML_LOOP_TIMEOUT) (20230628/psparse-529)
> [   51.527032] ACPI Error: Method execution failed \_SB.PCI0._PRT due to previous error (AE_AML_LOOP_TIMEOUT) (20230628/uteval-68)
> [   51.530049] virtio-pci 0000:00:02.0: can't derive routing for PCI INT A
> [   51.530797] virtio-pci 0000:00:02.0: PCI INT A: no GSI
> [   81.922901] ACPI Error: Aborting method \_SB.PCI0._PRT due to previous error (AE_AML_LOOP_TIMEOUT) (20230628/psparse-529)
> [   82.103534] ACPI Error: Method execution failed \_SB.PCI0._PRT due to previous error (AE_AML_LOOP_TIMEOUT) (20230628/uteval-68)
> [   82.106088] virtio-pci 0000:00:04.0: can't derive routing for PCI INT A
> [   82.106761] virtio-pci 0000:00:04.0: PCI INT A: no GSI
> [  112.192568] ACPI Error: Aborting method \_SB.PCI0._PRT due to previous error (AE_AML_LOOP_TIMEOUT) (20230628/psparse-529)
> [  112.486687] ACPI Error: Method execution failed \_SB.PCI0._PRT due to previous error (AE_AML_LOOP_TIMEOUT) (20230628/uteval-68)
> [  112.489554] virtio-pci 0000:00:05.0: can't derive routing for PCI INT A
> [  112.490027] virtio-pci 0000:00:05.0: PCI INT A: no GSI
> [  142.559448] ACPI Error: Aborting method \_SB.PCI0._PRT due to previous error (AE_AML_LOOP_TIMEOUT) (20230628/psparse-529)
> [  142.718596] ACPI Error: Method execution failed \_SB.PCI0._PRT due to previous error (AE_AML_LOOP_TIMEOUT) (20230628/uteval-68)
> [  142.722889] virtio-pci 0000:00:06.0: can't derive routing for PCI INT A
> [  142.724578] virtio-pci 0000:00:06.0: PCI INT A: no GSI
> 
> With this patch:
> [   22.938076] ACPI: \_SB_.LNKB: Enabled at IRQ 10
> [   24.214002] ACPI: \_SB_.LNKD: Enabled at IRQ 11
> [   25.465170] ACPI: \_SB_.LNKA: Enabled at IRQ 10
> [   27.944920] ACPI: \_SB_.LNKC: Enabled at IRQ 11
> 
> ACPI disassembly:
>         Scope (PCI0)
>         {
>             Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
>             {
>                 Return (Package (0x80)
>                 {
>                     Package (0x04)
>                     {
>                         0xFFFF,
>                         Zero,
>                         LNKD,
>                         Zero
>                     },
> 
>                     Package (0x04)
>                     {
>                         0xFFFF,
>                         One,
>                         LNKA,
>                         Zero
>                     },
> 
>                     Package (0x04)
>                     {
>                         0xFFFF,
>                         0x02,
>                         LNKB,
>                         Zero
>                     },
> 
>                     Package (0x04)
>                     {
>                         0xFFFF,
>                         0x03,
>                         LNKC,
>                         Zero
>                     },
> 
>                     Package (0x04)
>                     {
>                         0x0001FFFF,
>                         Zero,
>                         LNKS,
>                         Zero
>                     },
> Context: https://lore.kernel.org/virtualization/20240417145544.38d7b482@imammedo.users.ipa.redhat.com/T/#t
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/i386/acpi-build.c | 120 ++++++++-----------------------------------
>  1 file changed, 22 insertions(+), 98 deletions(-)
> 
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 53f804ac16..03216a6f29 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -725,120 +725,44 @@ static Aml *aml_pci_pdsm(void)
>      return method;
>  }
>  
> -/**
> - * build_prt_entry:
> - * @link_name: link name for PCI route entry
> - *
> - * build AML package containing a PCI route entry for @link_name
> - */
> -static Aml *build_prt_entry(const char *link_name)
> -{
> -    Aml *a_zero = aml_int(0);
> -    Aml *pkg = aml_package(4);
> -    aml_append(pkg, a_zero);
> -    aml_append(pkg, a_zero);
> -    aml_append(pkg, aml_name("%s", link_name));
> -    aml_append(pkg, a_zero);
> -    return pkg;
> -}
> -
>  /*
> - * initialize_route - Initialize the interrupt routing rule
> - * through a specific LINK:
> - *  if (lnk_idx == idx)
> - *      route using link 'link_name'
> - */
> -static Aml *initialize_route(Aml *route, const char *link_name,
> -                             Aml *lnk_idx, int idx)
> -{
> -    Aml *if_ctx = aml_if(aml_equal(lnk_idx, aml_int(idx)));
> -    Aml *pkg = build_prt_entry(link_name);
> -
> -    aml_append(if_ctx, aml_store(pkg, route));
> -
> -    return if_ctx;
> -}
> -
> -/*
> - * build_prt - Define interrupt rounting rules
> + * build_prt - Define interrupt routing rules
>   *
>   * Returns an array of 128 routes, one for each device,
>   * based on device location.
>   * The main goal is to equally distribute the interrupts
>   * over the 4 existing ACPI links (works only for i440fx).
> - * The hash function is  (slot + pin) & 3 -> "LNK[D|A|B|C]".
> + * The hash function is: (slot + pin) & 3 -> "LNK[D|A|B|C]".
>   *
>   */
>  static Aml *build_prt(bool is_pci0_prt)
>  {
> -    Aml *method, *while_ctx, *pin, *res;
> +    const int nroutes = 128;
> +    Aml *rt_pkg, *method;
> +    int pin;
>  
>      method = aml_method("_PRT", 0, AML_NOTSERIALIZED);
> -    res = aml_local(0);
> -    pin = aml_local(1);
> -    aml_append(method, aml_store(aml_package(128), res));
> -    aml_append(method, aml_store(aml_int(0), pin));
> +    rt_pkg = aml_varpackage(nroutes);
>  
> -    /* while (pin < 128) */
> -    while_ctx = aml_while(aml_lless(pin, aml_int(128)));
> -    {
> -        Aml *slot = aml_local(2);
> -        Aml *lnk_idx = aml_local(3);
> -        Aml *route = aml_local(4);
> -
> -        /* slot = pin >> 2 */
> -        aml_append(while_ctx,
> -                   aml_store(aml_shiftright(pin, aml_int(2), NULL), slot));
> -        /* lnk_idx = (slot + pin) & 3 */
> -        aml_append(while_ctx,
> -            aml_store(aml_and(aml_add(pin, slot, NULL), aml_int(3), NULL),
> -                      lnk_idx));
> -
> -        /* route[2] = "LNK[D|A|B|C]", selection based on pin % 3  */
> -        aml_append(while_ctx, initialize_route(route, "LNKD", lnk_idx, 0));
> -        if (is_pci0_prt) {
> -            Aml *if_device_1, *if_pin_4, *else_pin_4;
> -
> -            /* device 1 is the power-management device, needs SCI */
> -            if_device_1 = aml_if(aml_equal(lnk_idx, aml_int(1)));
> -            {
> -                if_pin_4 = aml_if(aml_equal(pin, aml_int(4)));
> -                {
> -                    aml_append(if_pin_4,
> -                        aml_store(build_prt_entry("LNKS"), route));
> -                }
> -                aml_append(if_device_1, if_pin_4);
> -                else_pin_4 = aml_else();
> -                {
> -                    aml_append(else_pin_4,
> -                        aml_store(build_prt_entry("LNKA"), route));
> -                }
> -                aml_append(if_device_1, else_pin_4);
> -            }
> -            aml_append(while_ctx, if_device_1);
> +    for (pin = 0; pin < nroutes; pin++) {
> +        Aml *pkg = aml_package(4);
> +        int slot = pin >> 2;
> +
> +        aml_append(pkg, aml_int((slot << 16) | 0xFFFF));
> +        aml_append(pkg, aml_int(pin & 3));
> +        /* device 1 is the power-management device, needs SCI */
> +        if (is_pci0_prt && pin == 4) {
> +            aml_append(pkg, aml_name("%s", "LNKS"));
>          } else {
> -            aml_append(while_ctx, initialize_route(route, "LNKA", lnk_idx, 1));
> +            const char link_name[][5] = {"LNKD", "LNKA", "LNKB", "LNKC"};
> +            int hash = (slot + pin) & 3;
> +            aml_append(pkg, aml_name("%s", link_name[hash]));
>          }
> -        aml_append(while_ctx, initialize_route(route, "LNKB", lnk_idx, 2));
> -        aml_append(while_ctx, initialize_route(route, "LNKC", lnk_idx, 3));
> -
> -        /* route[0] = 0x[slot]FFFF */
> -        aml_append(while_ctx,
> -            aml_store(aml_or(aml_shiftleft(slot, aml_int(16)), aml_int(0xFFFF),
> -                             NULL),
> -                      aml_index(route, aml_int(0))));
> -        /* route[1] = pin & 3 */
> -        aml_append(while_ctx,
> -            aml_store(aml_and(pin, aml_int(3), NULL),
> -                      aml_index(route, aml_int(1))));
> -        /* res[pin] = route */
> -        aml_append(while_ctx, aml_store(route, aml_index(res, pin)));
> -        /* pin++ */
> -        aml_append(while_ctx, aml_increment(pin));
> +        aml_append(pkg, aml_int(0));
> +        aml_append(rt_pkg, pkg);
>      }
> -    aml_append(method, while_ctx);
> -    /* return res*/
> -    aml_append(method, aml_return(res));
> +
> +    aml_append(method, aml_return(rt_pkg));
>  
>      return method;
>  }


