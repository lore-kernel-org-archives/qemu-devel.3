Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3691ECD98DA
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 14:10:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZUUG-0000Hp-Co; Tue, 16 Jun 2026 10:09:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wZUUC-0000HY-5w
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 10:09:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wZUUA-0001dl-Bc
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 10:09:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781618987;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=rjqMW9jV/8yfhxu2R8LuZ7K+b0pKmnIUvNVcEn3qZ+E=;
 b=RNwrYx1Z5urSvE/jO/Q7TpHq68WmX/F23ytapvLbzg4xNn/wRyb5ltT00ALHYsCw3xmyf9
 AqavbYv+g8KS94JP2ssRlmLC180VYHzxxV5/gzXLOUjuwufFlolYWycZhC3IbTXVX8nJVT
 lyVc21YmOvR8GauLVntfKf9XX9lBu24=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-355-AP7jvXMBOfG4S5gWRwCeiQ-1; Tue,
 16 Jun 2026 10:09:44 -0400
X-MC-Unique: AP7jvXMBOfG4S5gWRwCeiQ-1
X-Mimecast-MFC-AGG-ID: AP7jvXMBOfG4S5gWRwCeiQ_1781618983
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DAAB71805C23; Tue, 16 Jun 2026 14:09:42 +0000 (UTC)
Received: from redhat.com (unknown [10.44.49.111])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 20D6B1800594; Tue, 16 Jun 2026 14:09:38 +0000 (UTC)
Date: Tue, 16 Jun 2026 15:09:35 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alexander Gryanko <xpahos@gmail.com>
Cc: qemu-devel@nongnu.org, imammedo@redhat.com, mst@redhat.com,
 philmd@linaro.org, anisinha@redhat.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, zhao1.liu@intel.com
Subject: Re: [PATCH v2 1/3] hw/i386/pc: Introduce 11.2 machine type for
 SMBIOS type 8 base migration
Message-ID: <ajFZHxYkETZk6SON@redhat.com>
References: <20260616135904.44930-1-xpahos@gmail.com>
 <20260616135904.44930-2-xpahos@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260616135904.44930-2-xpahos@gmail.com>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Jun 16, 2026 at 04:59:02PM +0300, Alexander Gryanko wrote:
> SMBIOS Type 8 (Port Connector) tables have been using T0_BASE (0x0) for
> handle allocation, which can collide with handles assigned to other
> SMBIOS types. Types 2, 3, 4, 9, and 11 already use dedicated ranges
> (T2_BASE=0x200, T3_BASE=0x300, etc.).
> Introduce pc-q35-11.2 and pc-i440fx-11.2 with smbios_type8_handle_t8_base
> enabled, so Type 8 handles start at 0x800. The 11.1 machine types retain
> T0_BASE for migration compatibility.

This should not be adding a new 11.2 machine type, as we have
not even released 11.1 yet.

Machine types are added as standalone commits immediately after
each release, so no other commits should be adding machine
types.

Changes should be going into current 11.1 machines.

> Other platforms (ARM, LoongArch, RISC-V) are not changed by this patch.
> 
> Signed-off-by: Alexander Gryanko <xpahos@gmail.com>
> ---
>  hw/core/machine.c        |  3 +++
>  hw/i386/pc.c             |  3 +++
>  hw/i386/pc_piix.c        | 16 ++++++++++++++--
>  hw/i386/pc_q35.c         | 16 ++++++++++++++--
>  include/hw/core/boards.h |  3 +++
>  include/hw/i386/pc.h     |  4 ++++
>  6 files changed, 41 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 63baff859f..96de2d20f0 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -39,6 +39,9 @@
>  #include "hw/acpi/generic_event_device.h"
>  #include "qemu/audio.h"
>  
> +GlobalProperty hw_compat_11_1[] = {};
> +const size_t hw_compat_11_1_len = G_N_ELEMENTS(hw_compat_11_1);
> +
>  GlobalProperty hw_compat_11_0[] = {
>      { "chardev-vc", "encoding", "cp437" },
>  };
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 2ecad3c503..17ad8b6489 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -73,6 +73,9 @@
>  #include "hw/xen/xen-bus.h"
>  #endif
>  
> +GlobalProperty pc_compat_11_1[] = {};
> +const size_t pc_compat_11_1_len = G_N_ELEMENTS(pc_compat_11_1);
> +
>  GlobalProperty pc_compat_11_0[] = {};
>  const size_t pc_compat_11_0_len = G_N_ELEMENTS(pc_compat_11_0);
>  
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index 82457bdb16..27e1d552f6 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -406,6 +406,7 @@ static void pc_i440fx_machine_options(MachineClass *m)
>      pcmc->default_south_bridge = TYPE_PIIX3_DEVICE;
>      pcmc->pci_root_uid = 0;
>      pcmc->default_cpu_version = 1;
> +    pcmc->smbios_type8_handle_t8_base = true;
>  
>      m->family = "pc_piix";
>      m->desc = "Standard PC (i440FX + PIIX, 1996)";
> @@ -428,12 +429,23 @@ static void pc_i440fx_machine_options(MachineClass *m)
>                       pc_piix_compat_defaults, pc_piix_compat_defaults_len);
>  }
>  
> -static void pc_i440fx_machine_11_1_options(MachineClass *m)
> +static void pc_i440fx_machine_11_2_options(MachineClass *m)
>  {
>      pc_i440fx_machine_options(m);
>  }
>  
> -DEFINE_I440FX_MACHINE_AS_LATEST(11, 1);
> +DEFINE_I440FX_MACHINE_AS_LATEST(11, 2);
> +
> +static void pc_i440fx_machine_11_1_options(MachineClass *m)
> +{
> +    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
> +    pc_i440fx_machine_11_2_options(m);
> +    pcmc->smbios_type8_handle_t8_base = false;
> +    compat_props_add(m->compat_props, hw_compat_11_1, hw_compat_11_1_len);
> +    compat_props_add(m->compat_props, pc_compat_11_1, pc_compat_11_1_len);
> +}
> +
> +DEFINE_I440FX_MACHINE(11, 1);
>  
>  static void pc_i440fx_machine_11_0_options(MachineClass *m)
>  {
> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> index d8fed698c7..cf1ae9b78b 100644
> --- a/hw/i386/pc_q35.c
> +++ b/hw/i386/pc_q35.c
> @@ -345,6 +345,7 @@ static void pc_q35_machine_options(MachineClass *m)
>      PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
>      pcmc->pci_root_uid = 0;
>      pcmc->default_cpu_version = 1;
> +    pcmc->smbios_type8_handle_t8_base = true;
>  
>      m->family = "pc_q35";
>      m->desc = "Standard PC (Q35 + ICH9, 2009)";
> @@ -365,12 +366,23 @@ static void pc_q35_machine_options(MachineClass *m)
>                       pc_q35_compat_defaults, pc_q35_compat_defaults_len);
>  }
>  
> -static void pc_q35_machine_11_1_options(MachineClass *m)
> +static void pc_q35_machine_11_2_options(MachineClass *m)
>  {
>      pc_q35_machine_options(m);
>  }
>  
> -DEFINE_Q35_MACHINE_AS_LATEST(11, 1);
> +DEFINE_Q35_MACHINE_AS_LATEST(11, 2);
> +
> +static void pc_q35_machine_11_1_options(MachineClass *m)
> +{
> +    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
> +    pc_q35_machine_11_2_options(m);
> +    pcmc->smbios_type8_handle_t8_base = false;
> +    compat_props_add(m->compat_props, hw_compat_11_1, hw_compat_11_1_len);
> +    compat_props_add(m->compat_props, pc_compat_11_1, pc_compat_11_1_len);
> +}
> +
> +DEFINE_Q35_MACHINE(11, 1);
>  
>  static void pc_q35_machine_11_0_options(MachineClass *m)
>  {
> diff --git a/include/hw/core/boards.h b/include/hw/core/boards.h
> index 29c68931d8..a436d48c8e 100644
> --- a/include/hw/core/boards.h
> +++ b/include/hw/core/boards.h
> @@ -815,6 +815,9 @@ compat_props_add(GPtrArray *arr,
>      }
>  }
>  
> +extern GlobalProperty hw_compat_11_1[];
> +extern const size_t hw_compat_11_1_len;
> +
>  extern GlobalProperty hw_compat_11_0[];
>  extern const size_t hw_compat_11_0_len;
>  
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index 85a74363b5..b7d21fb96e 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -102,6 +102,7 @@ struct PCMachineClass {
>      /* SMBIOS compat: */
>      bool smbios_defaults;
>      bool smbios_legacy_mode;
> +    bool smbios_type8_handle_t8_base;
>      SmbiosEntryPointType default_smbios_ep_type;
>  
>      /* RAM / address space compat: */
> @@ -208,6 +209,9 @@ void pc_system_parse_ovmf_flash(uint8_t *flash_ptr, size_t flash_size);
>  /* sgx.c */
>  void pc_machine_init_sgx_epc(PCMachineState *pcms);
>  
> +extern GlobalProperty pc_compat_11_1[];
> +extern const size_t pc_compat_11_1_len;
> +
>  extern GlobalProperty pc_compat_11_0[];
>  extern const size_t pc_compat_11_0_len;
>  
> -- 
> 2.39.5 (Apple Git-154)
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


