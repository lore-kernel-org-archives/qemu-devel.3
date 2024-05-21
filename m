Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB8B1C25B74
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 07:43:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9K8f-0001Hr-5B; Tue, 21 May 2024 03:42:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1s9K8e-0001Hd-1L
 for qemu-devel@nongnu.org; Tue, 21 May 2024 03:42:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1s9K8c-0005SC-1H
 for qemu-devel@nongnu.org; Tue, 21 May 2024 03:42:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716277340;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FKkugampulA0EY3mjCBjp+2fdy4IaCG0gbiJVDm4VcI=;
 b=B6aCEanyuGQVjORp7hFmyLRRajgrT73HgjnK9vZ/Lt4r9RjoOx6Lh8V7GiFNc7P4TPFd5I
 KDoi7zTgiKyQje+pC//H1iFUszM2Vw2c4N3EW02mLy4TaTH5cH/GOLIlUd4r+ymJRrg7bz
 bJNEQR0uFC2Z5NITFPWfJGfcg/O1UEI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-133-87fRwUtOPCmeq4xUPef5MA-1; Tue, 21 May 2024 03:42:18 -0400
X-MC-Unique: 87fRwUtOPCmeq4xUPef5MA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-41fc5c5cc95so54883065e9.0
 for <qemu-devel@nongnu.org>; Tue, 21 May 2024 00:42:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716277337; x=1716882137;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FKkugampulA0EY3mjCBjp+2fdy4IaCG0gbiJVDm4VcI=;
 b=Wieo5z/VTxnQql3fxkmVEEiD1nRXz09JP0rQMUmp7qTED6NOjNLWMvlu5kXsGybwp6
 sDcsJeXAeusqZTHKm7GcZBLmCs9I0KalZiyVK6OVyE/H2/t3uEYefyvIpSGHdMNSrcq4
 n0VeLXyomnoR1Nomy7FaOXzjyyiE6KmdW2CWSC6KZiPywbyY6lRSGbuuQp++cApIzqUX
 a6PrZr4ntvgw3CeOaRSMcQ6tbhP4/8BCuVvOpdmvbr01/u6R+wgEl24VvcUHHU4Uj3FR
 4pqhykw6NDqeCVLuyVwBou895xZgXAbP5NUxnNY0Dza/z5doihcsns9ukNzL9f/Tsw+s
 DmTA==
X-Gm-Message-State: AOJu0YyGh/Mzps/dduHA6SVnC24TrjSfJGdRTsWN1VKwUrpFYRViNxi2
 AOWYT7Ujv3GqtfcyacqA/9Mhd8P4IV0ZDY7U0ZbTfbOyLrRfgUrro0wU+Dk8E5nINzBng779WYE
 huaJhS65GN4l9XoPwnc1MMhzD6w7Huk9Tb9pyoRSCNRDTFr9Rj6ms
X-Received: by 2002:a05:600c:1d9a:b0:420:2986:cce7 with SMTP id
 5b1f17b1804b1-4202986d140mr154393095e9.25.1716277337116; 
 Tue, 21 May 2024 00:42:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGjZp0f8whms2Np1PDBMSjtRwe42IisUpQeoiaEF73kxCgqQf4bcr4lP8x4TWjIhLQlXFXSzA==
X-Received: by 2002:a05:600c:1d9a:b0:420:2986:cce7 with SMTP id
 5b1f17b1804b1-4202986d140mr154392905e9.25.1716277336522; 
 Tue, 21 May 2024 00:42:16 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:240:5a20:b565:3672:6f2b:3d2d])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41fa9dbab53sm463897265e9.13.2024.05.21.00.42.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 May 2024 00:42:15 -0700 (PDT)
Date: Tue, 21 May 2024 03:42:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, Sergio Lopez <slp@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH v3 6/6] hw/i386/pc_sysfw: Alias rather than copy isa-bios
 region
Message-ID: <20240521034158-mutt-send-email-mst@kernel.org>
References: <20240508175507.22270-1-shentey@gmail.com>
 <20240508175507.22270-7-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240508175507.22270-7-shentey@gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Wed, May 08, 2024 at 07:55:07PM +0200, Bernhard Beschow wrote:
> In the -bios case the "isa-bios" memory region is an alias to the BIOS mapped
> to the top of the 4G memory boundary. Do the same in the -pflash case, but only
> for new machine versions for migration compatibility. This establishes common
> behavior and makes pflash commands work in the "isa-bios" region which some
> real-world legacy bioses rely on.
> 
> Note that in the sev_enabled() case, the "isa-bios" memory region in the -pflash
> case will now also point to encrypted memory, just like it already does in the
> -bios case.
> 
> When running `info mtree` before and after this commit with
> `qemu-system-x86_64 -S -drive \
> if=pflash,format=raw,readonly=on,file=/usr/share/qemu/bios-256k.bin` and running
> `diff -u before.mtree after.mtree` results in the following changes in the
> memory tree:
> 
>    --- before.mtree
>    +++ after.mtree
>    @@ -71,7 +71,7 @@
>         0000000000000000-ffffffffffffffff (prio -1, i/o): pci
>         00000000000a0000-00000000000bffff (prio 1, i/o): vga-lowmem
>         00000000000c0000-00000000000dffff (prio 1, rom): pc.rom
>    -      00000000000e0000-00000000000fffff (prio 1, rom): isa-bios
>    +      00000000000e0000-00000000000fffff (prio 1, romd): alias isa-bios @system.flash0 0000000000020000-000000000003ffff
>         00000000000a0000-00000000000bffff (prio 1, i/o): alias smram-region @pci 00000000000a0000-00000000000bffff
>         00000000000c0000-00000000000c3fff (prio 1, i/o): alias pam-pci @pci 00000000000c0000-00000000000c3fff
>         00000000000c4000-00000000000c7fff (prio 1, i/o): alias pam-pci @pci 00000000000c4000-00000000000c7fff
>    @@ -108,7 +108,7 @@
>         0000000000000000-ffffffffffffffff (prio -1, i/o): pci
>         00000000000a0000-00000000000bffff (prio 1, i/o): vga-lowmem
>         00000000000c0000-00000000000dffff (prio 1, rom): pc.rom
>    -      00000000000e0000-00000000000fffff (prio 1, rom): isa-bios
>    +      00000000000e0000-00000000000fffff (prio 1, romd): alias isa-bios @system.flash0 0000000000020000-000000000003ffff
>         00000000000a0000-00000000000bffff (prio 1, i/o): alias smram-region @pci 00000000000a0000-00000000000bffff
>         00000000000c0000-00000000000c3fff (prio 1, i/o): alias pam-pci @pci 00000000000c0000-00000000000c3fff
>         00000000000c4000-00000000000c7fff (prio 1, i/o): alias pam-pci @pci 00000000000c4000-00000000000c7fff
>    @@ -131,11 +131,14 @@
>    memory-region: pc.ram
>    0000000000000000-0000000007ffffff (prio 0, ram): pc.ram
> 
>    +memory-region: system.flash0
>    +  00000000fffc0000-00000000ffffffff (prio 0, romd): system.flash0
>    +
>    memory-region: pci
>    0000000000000000-ffffffffffffffff (prio -1, i/o): pci
>         00000000000a0000-00000000000bffff (prio 1, i/o): vga-lowmem
>         00000000000c0000-00000000000dffff (prio 1, rom): pc.rom
>    -    00000000000e0000-00000000000fffff (prio 1, rom): isa-bios
>    +    00000000000e0000-00000000000fffff (prio 1, romd): alias isa-bios @system.flash0 0000000000020000-000000000003ffff
> 
>    memory-region: smram
>         00000000000a0000-00000000000bffff (prio 0, ram): alias smram-low @pc.ram 00000000000a0000-00000000000bffff
> 
> Note that in both cases the "system" memory region contains the entry
> 
>   00000000fffc0000-00000000ffffffff (prio 0, romd): system.flash0
> 
> but the "system.flash0" memory region only appears standalone when "isa-bios" is
> an alias.
> 
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

feel free to queue

> ---
>  include/hw/i386/pc.h | 1 +
>  hw/i386/pc.c         | 1 +
>  hw/i386/pc_piix.c    | 3 +++
>  hw/i386/pc_q35.c     | 2 ++
>  hw/i386/pc_sysfw.c   | 8 +++++++-
>  5 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index e52290916c..ad9c3d9ba8 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -119,6 +119,7 @@ struct PCMachineClass {
>      bool enforce_aligned_dimm;
>      bool broken_reserved_end;
>      bool enforce_amd_1tb_hole;
> +    bool isa_bios_alias;
>  
>      /* generate legacy CPU hotplug AML */
>      bool legacy_cpu_hotplug;
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 46235466d7..4878705af7 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1812,6 +1812,7 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
>      pcmc->has_reserved_memory = true;
>      pcmc->enforce_aligned_dimm = true;
>      pcmc->enforce_amd_1tb_hole = true;
> +    pcmc->isa_bios_alias = true;
>      /* BIOS ACPI tables: 128K. Other BIOS datastructures: less than 4K reported
>       * to be used at the moment, 32K should be enough for a while.  */
>      pcmc->acpi_data_size = 0x20000 + 0x8000;
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index 8850c49c66..d4e9deb509 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -525,12 +525,15 @@ DEFINE_I440FX_MACHINE(v9_1, "pc-i440fx-9.1", NULL,
>  
>  static void pc_i440fx_9_0_machine_options(MachineClass *m)
>  {
> +    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
> +
>      pc_i440fx_9_1_machine_options(m);
>      m->alias = NULL;
>      m->is_default = false;
>  
>      compat_props_add(m->compat_props, hw_compat_9_0, hw_compat_9_0_len);
>      compat_props_add(m->compat_props, pc_compat_9_0, pc_compat_9_0_len);
> +    pcmc->isa_bios_alias = false;
>  }
>  
>  DEFINE_I440FX_MACHINE(v9_0, "pc-i440fx-9.0", NULL,
> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> index bb53a51ac1..bd7db4abac 100644
> --- a/hw/i386/pc_q35.c
> +++ b/hw/i386/pc_q35.c
> @@ -378,10 +378,12 @@ DEFINE_Q35_MACHINE(v9_1, "pc-q35-9.1", NULL,
>  
>  static void pc_q35_9_0_machine_options(MachineClass *m)
>  {
> +    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
>      pc_q35_9_1_machine_options(m);
>      m->alias = NULL;
>      compat_props_add(m->compat_props, hw_compat_9_0, hw_compat_9_0_len);
>      compat_props_add(m->compat_props, pc_compat_9_0, pc_compat_9_0_len);
> +    pcmc->isa_bios_alias = false;
>  }
>  
>  DEFINE_Q35_MACHINE(v9_0, "pc-q35-9.0", NULL,
> diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
> index 82d37cb376..ac88ad4eb9 100644
> --- a/hw/i386/pc_sysfw.c
> +++ b/hw/i386/pc_sysfw.c
> @@ -135,6 +135,7 @@ static void pc_system_flash_map(PCMachineState *pcms,
>                                  MemoryRegion *rom_memory)
>  {
>      X86MachineState *x86ms = X86_MACHINE(pcms);
> +    PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
>      hwaddr total_size = 0;
>      int i;
>      BlockBackend *blk;
> @@ -184,7 +185,12 @@ static void pc_system_flash_map(PCMachineState *pcms,
>  
>          if (i == 0) {
>              flash_mem = pflash_cfi01_get_memory(system_flash);
> -            pc_isa_bios_init(&x86ms->isa_bios, rom_memory, flash_mem);
> +            if (pcmc->isa_bios_alias) {
> +                x86_isa_bios_init(&x86ms->isa_bios, rom_memory, flash_mem,
> +                                  true);
> +            } else {
> +                pc_isa_bios_init(&x86ms->isa_bios, rom_memory, flash_mem);
> +            }
>  
>              /* Encrypt the pflash boot ROM */
>              if (sev_enabled()) {
> -- 
> 2.45.0


