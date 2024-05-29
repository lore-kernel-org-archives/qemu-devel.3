Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF745C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 14:31:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCKKE-0005v9-Bz; Wed, 29 May 2024 10:30:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sCKKB-0005ti-4x
 for qemu-devel@nongnu.org; Wed, 29 May 2024 10:30:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sCKK9-0001HR-62
 for qemu-devel@nongnu.org; Wed, 29 May 2024 10:30:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716993040;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gp5iEjwpy33SSZuuayc/60glQplR2j5O8TKRomDxAhY=;
 b=LJgKsndCrRBZNmpuAV47oTHJ+QjeLh7h3oIwyaebszQh4kaCv1IFmnDJvobp9kkG5Bxvym
 KFbZFyyL6u5egRuTSrVkxA8K6xMqQmfz86k0sP/pCZ1FSr5xm4UpMsK40AA6suZAwpUl6x
 xskrUsC9wnXZI57c/epI6wmEx9nz688=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-a0aQLgSZOcaKjxkh2Qc_iw-1; Wed, 29 May 2024 10:30:39 -0400
X-MC-Unique: a0aQLgSZOcaKjxkh2Qc_iw-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-354f34e0ab0so1358928f8f.3
 for <qemu-devel@nongnu.org>; Wed, 29 May 2024 07:30:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716993038; x=1717597838;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gp5iEjwpy33SSZuuayc/60glQplR2j5O8TKRomDxAhY=;
 b=VV5eas2ZxtaVyyTPC3QYqDupixXmnYaZL5UZzQeaBMzE2fnr9xxj1hjo36OtOavb93
 sYlqdhQyLY0GUtJQ/NiVoJJfGWiH5rrCmsDB3b1Bej7X66Hnpj2EwgR6w7LiTOPQztqB
 2fKfy3DB4iUckjzhoUigE0nM1eIXC0Dr2VKqSFz4nV0hXBkW0yeBpp0u48uFVJ958iTG
 0fSQ/bwUtVMd4KGDZCmSyQAIaAv4roMaH/jU4ktMWrpZrJthqeHqDOEVQcwh7nFs7qo8
 lANCYFKNDv5jzWgZzkIRstygVCm1A+lsxXQWZAAPN8bUDy5peUm4w8LjjbEsdz9TkNuX
 7bag==
X-Gm-Message-State: AOJu0YxdtvuZfApDVqkmvaJF14XeLbQBjvM7atWJJe/z6qN+B+E3CIeV
 U+dw12190BgIMEbdSXid/YLnG4KZ/SxnaiAlhWy39f4nwuRgqLCSXPSGq5xjtxGFGD17i/psqXa
 Y0+kvqHyufsKHvfAmkta9FqJAdGxPudMtQQ9P8sggkCKX7MtVNgKr
X-Received: by 2002:a05:6000:118c:b0:354:fbc8:17d1 with SMTP id
 ffacd0b85a97d-3552fe021ebmr10568156f8f.61.1716993037938; 
 Wed, 29 May 2024 07:30:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0u1X15ke+STFcLEOJ6ZYA6L9lLLD9NYldWrTmW/Q+/f597ypkVF8122dj2QpyYFX+9NdWcw==
X-Received: by 2002:a05:6000:118c:b0:354:fbc8:17d1 with SMTP id
 ffacd0b85a97d-3552fe021ebmr10568135f8f.61.1716993037470; 
 Wed, 29 May 2024 07:30:37 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3557a08cc1bsm15070410f8f.45.2024.05.29.07.30.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 May 2024 07:30:37 -0700 (PDT)
Date: Wed, 29 May 2024 16:30:36 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Daniel P .
 =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>, Zhao Liu
 <zhao1.liu@intel.com>
Subject: Re: [PATCH v5 13/23] hw/i386/pc: Remove
 PCMachineClass::enforce_aligned_dimm
Message-ID: <20240529163036.05dacea0@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240529051539.71210-14-philmd@linaro.org>
References: <20240529051539.71210-1-philmd@linaro.org>
 <20240529051539.71210-14-philmd@linaro.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.036,
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

On Wed, 29 May 2024 07:15:29 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> wrote:

> PCMachineClass::enforce_aligned_dimm was only used by the
> pc-i440fx-2.1 machine, which got removed. It is now always
> true. Remove it, simplifying pc_get_device_memory_range().
> Update the comment in Avocado test_phybits_low_pse36().
>=20
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  include/hw/i386/pc.h                  |  3 ---
>  hw/i386/pc.c                          | 14 +++-----------
>  tests/avocado/mem-addr-space-check.py |  9 ++++-----
>  3 files changed, 7 insertions(+), 19 deletions(-)
>=20
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index bbbf58bd42..1351e73ee0 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -74,8 +74,6 @@ typedef struct PCMachineState {
>   *
>   * Compat fields:
>   *
> - * @enforce_aligned_dimm: check that DIMM's address/size is aligned by
> - *                        backend's alignment value if provided
>   * @acpi_data_size: Size of the chunk of memory at the top of RAM
>   *                  for the BIOS ACPI tables and other BIOS
>   *                  datastructures.
> @@ -114,7 +112,6 @@ struct PCMachineClass {
>      /* RAM / address space compat: */
>      bool gigabyte_align;
>      bool has_reserved_memory;
> -    bool enforce_aligned_dimm;
>      bool broken_reserved_end;
>      bool enforce_amd_1tb_hole;
>      bool isa_bios_alias;
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 4b2a29bf08..9cb5083f8f 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -727,7 +727,6 @@ static void pc_get_device_memory_range(PCMachineState=
 *pcms,
>                                         hwaddr *base,
>                                         ram_addr_t *device_mem_size)
>  {
> -    PCMachineClass *pcmc =3D PC_MACHINE_GET_CLASS(pcms);
>      MachineState *machine =3D MACHINE(pcms);
>      ram_addr_t size;
>      hwaddr addr;
> @@ -735,10 +734,8 @@ static void pc_get_device_memory_range(PCMachineStat=
e *pcms,
>      size =3D machine->maxram_size - machine->ram_size;
>      addr =3D ROUND_UP(pc_above_4g_end(pcms), 1 * GiB);
> =20
> -    if (pcmc->enforce_aligned_dimm) {
> -        /* size device region assuming 1G page max alignment per slot */
> -        size +=3D (1 * GiB) * machine->ram_slots;
> -    }
> +    /* size device region assuming 1G page max alignment per slot */
> +    size +=3D (1 * GiB) * machine->ram_slots;
> =20
>      *base =3D addr;
>      *device_mem_size =3D size;
> @@ -1297,12 +1294,9 @@ void pc_i8259_create(ISABus *isa_bus, qemu_irq *i8=
259_irqs)
>  static void pc_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState =
*dev,
>                                 Error **errp)
>  {
> -    const PCMachineState *pcms =3D PC_MACHINE(hotplug_dev);
>      const X86MachineState *x86ms =3D X86_MACHINE(hotplug_dev);
> -    const PCMachineClass *pcmc =3D PC_MACHINE_GET_CLASS(pcms);
>      const MachineState *ms =3D MACHINE(hotplug_dev);
>      const bool is_nvdimm =3D object_dynamic_cast(OBJECT(dev), TYPE_NVDIM=
M);
> -    const uint64_t legacy_align =3D TARGET_PAGE_SIZE;
>      Error *local_err =3D NULL;
> =20
>      /*
> @@ -1327,8 +1321,7 @@ static void pc_memory_pre_plug(HotplugHandler *hotp=
lug_dev, DeviceState *dev,
>          return;
>      }
> =20
> -    pc_dimm_pre_plug(PC_DIMM(dev), MACHINE(hotplug_dev),
> -                     pcmc->enforce_aligned_dimm ? NULL : &legacy_align, =
errp);
> +    pc_dimm_pre_plug(PC_DIMM(dev), MACHINE(hotplug_dev), NULL, errp);
>  }
> =20
>  static void pc_memory_plug(HotplugHandler *hotplug_dev,
> @@ -1792,7 +1785,6 @@ static void pc_machine_class_init(ObjectClass *oc, =
void *data)
>      pcmc->smbios_defaults =3D true;
>      pcmc->gigabyte_align =3D true;
>      pcmc->has_reserved_memory =3D true;
> -    pcmc->enforce_aligned_dimm =3D true;
>      pcmc->enforce_amd_1tb_hole =3D true;
>      pcmc->isa_bios_alias =3D true;
>      /* BIOS ACPI tables: 128K. Other BIOS datastructures: less than 4K r=
eported
> diff --git a/tests/avocado/mem-addr-space-check.py b/tests/avocado/mem-ad=
dr-space-check.py
> index af019969c0..85541ea051 100644
> --- a/tests/avocado/mem-addr-space-check.py
> +++ b/tests/avocado/mem-addr-space-check.py
> @@ -31,11 +31,10 @@ def test_phybits_low_pse36(self):
>          at 4 GiB boundary when "above_4g_mem_size" is 0 (this would be t=
rue when
>          we have 0.5 GiB of VM memory, see pc_q35_init()). This means tot=
al
>          hotpluggable memory size is 60 GiB. Per slot, we reserve 1 GiB o=
f memory
> -        for dimm alignment for all newer machines (see enforce_aligned_d=
imm
> -        property for pc machines and pc_get_device_memory_range()). That=
 leaves
> -        total hotpluggable actual memory size of 59 GiB. If the VM is st=
arted
> -        with 0.5 GiB of memory, maxmem should be set to a maximum value =
of
> -        59.5 GiB to ensure that the processor can address all memory dir=
ectly.
> +        for dimm alignment for all machines. That leaves total hotplugga=
ble
> +        actual memory size of 59 GiB. If the VM is started with 0.5 GiB =
of
> +        memory, maxmem should be set to a maximum value of 59.5 GiB to e=
nsure
> +        that the processor can address all memory directly.
>          Note that 64-bit pci hole size is 0 in this case. If maxmem is s=
et to
>          59.6G, QEMU should fail to start with a message "phy-bits are to=
o low".
>          If maxmem is set to 59.5G with all other QEMU parameters identic=
al, QEMU


