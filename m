Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D19BC25B75
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 11:22:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD0L9-0002dh-Jm; Fri, 31 May 2024 07:22:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sD0L4-0002bc-Vd
 for qemu-devel@nongnu.org; Fri, 31 May 2024 07:22:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sD0L3-0003ZI-8H
 for qemu-devel@nongnu.org; Fri, 31 May 2024 07:22:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717154544;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UAWheUW+czVmcKYjV8Dp8vDbyjXbz/6UcUqunqJ3kC0=;
 b=V5AJnZtMUN5yWwC6cL41jdmkNdGcfvxVSJkiIldyyPhDUQ+O2/1VRTHQhdPdAY/2eD4fxh
 B607xhGIhIQwPvhw7ccG2YMyjJ3RvXirAHyfCqIbdE7BnV1URNHt+DAvZhdCOtYXWhrDHk
 KUPldWWRnB5h6LG+fONcNn7cYjN+3IE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-qG1_Ksi_Oi290rZj8NIW9w-1; Fri, 31 May 2024 07:22:23 -0400
X-MC-Unique: qG1_Ksi_Oi290rZj8NIW9w-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-35dcd39c6ebso865842f8f.1
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 04:22:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717154542; x=1717759342;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UAWheUW+czVmcKYjV8Dp8vDbyjXbz/6UcUqunqJ3kC0=;
 b=DmXATFyt8orAZkS9fvy+0aYKRxPcJly3PCwPEIF6zfg1UxOBUvPjtqYkHKmKhe0R0p
 StciHBu0f9Ygg+noZM8NBpSA7D0IIccpR6W+0BQPTqXUBLC2mH1KtS70MEDcq3u1EBIb
 DKbK93YdM0TuWMcKKbyoxn6HcdpeyUu8uzrNbnPOxAPt1PYaAcXq1APbKv/5fnVzMSQy
 0j1xgLZ/g4RnPMcu9ACoBF6p67Z7nQkrWX9piVaRfL+Ta8pLot0nfoKU8VGXxUblZhIb
 RIkU+5/KcOm1BeGL1UzPbGXhpMwwKI3DVL7ok/76SC9I76wFTkO08cyiHuqy/O6dHfzo
 hLnQ==
X-Gm-Message-State: AOJu0YwBfXjLoKCijo0D9Dft9JG69GSHY/pCYvwq0b7iAhtTZEOfiSeY
 oCCKACptTT8x2kkvnaxSxnrdeFOYLJ9xEgWi4E/l8c+WuzCd/ow6gnAUk3y1yoNlY299oW7N8+0
 xQgyJCP94SgU2VzWmqrrycBQPqJn4xzRCy0awusDZCNRm9HOxAHUHyWDDV8rjsh+BCOrKW7RSbD
 DBeyW9htM+dZezzx1r5I3YaCgxPRo=
X-Received: by 2002:adf:ce8f:0:b0:357:398a:b94f with SMTP id
 ffacd0b85a97d-35e0e5e9e79mr1552601f8f.26.1717154541830; 
 Fri, 31 May 2024 04:22:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSL8UFosZjFoJQhMVi4zx3TgAUecWQ0sZg7JltbVgqW+uJqoAfCMK7BTXpCXQcig6JubLXzlyW6iTGM3Zd9j8=
X-Received: by 2002:adf:ce8f:0:b0:357:398a:b94f with SMTP id
 ffacd0b85a97d-35e0e5e9e79mr1552581f8f.26.1717154541470; Fri, 31 May 2024
 04:22:21 -0700 (PDT)
MIME-Version: 1.0
References: <20240530111643.1091816-1-pankaj.gupta@amd.com>
 <20240530111643.1091816-29-pankaj.gupta@amd.com>
In-Reply-To: <20240530111643.1091816-29-pankaj.gupta@amd.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 31 May 2024 13:22:10 +0200
Message-ID: <CABgObfYoO1kpgWrjo9=n6Q6nf9qtRfd1rwdHU81d6UMMkPSewQ@mail.gmail.com>
Subject: Re: [PATCH v4 28/31] hw/i386: Add support for loading BIOS using
 guest_memfd
To: Pankaj Gupta <pankaj.gupta@amd.com>
Cc: qemu-devel@nongnu.org, brijesh.singh@amd.com, dovmurik@linux.ibm.com, 
 armbru@redhat.com, michael.roth@amd.com, xiaoyao.li@intel.com, 
 thomas.lendacky@amd.com, isaku.yamahata@intel.com, berrange@redhat.com, 
 kvm@vger.kernel.org, anisinha@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.085,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, May 30, 2024 at 1:17=E2=80=AFPM Pankaj Gupta <pankaj.gupta@amd.com>=
 wrote:
>      if (bios_size <=3D 0 ||
>          (bios_size % 65536) !=3D 0) {
> -        goto bios_error;
> +        if (!machine_require_guest_memfd(MACHINE(x86ms))) {
> +                g_warning("%s: Unaligned BIOS size %d", __func__, bios_s=
ize);
> +                goto bios_error;
> +        }

Why is this not needed for SEV-SNP? (The bios_size <=3D 0 case
definitely should be an error).

I'll just drop this change.

> +    }
> +    if (machine_require_guest_memfd(MACHINE(x86ms))) {
> +        memory_region_init_ram_guest_memfd(&x86ms->bios, NULL, "pc.bios"=
,
> +                                           bios_size, &error_fatal);
> +    } else {
> +        memory_region_init_ram(&x86ms->bios, NULL, "pc.bios",
> +                               bios_size, &error_fatal);
>      }
> -    memory_region_init_ram(&x86ms->bios, NULL, "pc.bios", bios_size,
> -                           &error_fatal);
>      if (sev_enabled()) {
>          /*
>           * The concept of a "reset" simply doesn't exist for
> @@ -1023,9 +1031,11 @@ void x86_bios_rom_init(X86MachineState *x86ms, con=
st char *default_firmware,
>      }
>      g_free(filename);
>
> -    /* map the last 128KB of the BIOS in ISA space */
> -    x86_isa_bios_init(&x86ms->isa_bios, rom_memory, &x86ms->bios,
> -                      !isapc_ram_fw);

> +    if (!machine_require_guest_memfd(MACHINE(x86ms))) {
> +        /* map the last 128KB of the BIOS in ISA space */
> +        x86_isa_bios_init(&x86ms->isa_bios, rom_memory, &x86ms->bios,
> +                          !isapc_ram_fw);
> +    }
>
>      /* map all the bios at the top of memory */
>      memory_region_add_subregion(rom_memory,
> --
> 2.34.1
>

On Thu, May 30, 2024 at 1:17=E2=80=AFPM Pankaj Gupta <pankaj.gupta@amd.com>=
 wrote:
>
> From: Michael Roth <michael.roth@amd.com>
>
> When guest_memfd is enabled, the BIOS is generally part of the initial
> encrypted guest image and will be accessed as private guest memory. Add
> the necessary changes to set up the associated RAM region with a
> guest_memfd backend to allow for this.
>
> Current support centers around using -bios to load the BIOS data.
> Support for loading the BIOS via pflash requires additional enablement
> since those interfaces rely on the use of ROM memory regions which make
> use of the KVM_MEM_READONLY memslot flag, which is not supported for
> guest_memfd-backed memslots.
>
> Signed-off-by: Michael Roth <michael.roth@amd.com>
> Signed-off-by: Pankaj Gupta <pankaj.gupta@amd.com>
> ---
>  hw/i386/x86-common.c | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)
>
> diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
> index f41cb0a6a8..059de65f36 100644
> --- a/hw/i386/x86-common.c
> +++ b/hw/i386/x86-common.c
> @@ -999,10 +999,18 @@ void x86_bios_rom_init(X86MachineState *x86ms, cons=
t char *default_firmware,
>      }
>      if (bios_size <=3D 0 ||
>          (bios_size % 65536) !=3D 0) {
> -        goto bios_error;
> +        if (!machine_require_guest_memfd(MACHINE(x86ms))) {
> +                g_warning("%s: Unaligned BIOS size %d", __func__, bios_s=
ize);
> +                goto bios_error;
> +        }
> +    }
> +    if (machine_require_guest_memfd(MACHINE(x86ms))) {
> +        memory_region_init_ram_guest_memfd(&x86ms->bios, NULL, "pc.bios"=
,
> +                                           bios_size, &error_fatal);
> +    } else {
> +        memory_region_init_ram(&x86ms->bios, NULL, "pc.bios",
> +                               bios_size, &error_fatal);
>      }
> -    memory_region_init_ram(&x86ms->bios, NULL, "pc.bios", bios_size,
> -                           &error_fatal);
>      if (sev_enabled()) {
>          /*
>           * The concept of a "reset" simply doesn't exist for
> @@ -1023,9 +1031,11 @@ void x86_bios_rom_init(X86MachineState *x86ms, con=
st char *default_firmware,
>      }
>      g_free(filename);
>
> -    /* map the last 128KB of the BIOS in ISA space */
> -    x86_isa_bios_init(&x86ms->isa_bios, rom_memory, &x86ms->bios,
> -                      !isapc_ram_fw);
> +    if (!machine_require_guest_memfd(MACHINE(x86ms))) {
> +        /* map the last 128KB of the BIOS in ISA space */
> +        x86_isa_bios_init(&x86ms->isa_bios, rom_memory, &x86ms->bios,
> +                          !isapc_ram_fw);
> +    }
>
>      /* map all the bios at the top of memory */
>      memory_region_add_subregion(rom_memory,
> --
> 2.34.1
>


