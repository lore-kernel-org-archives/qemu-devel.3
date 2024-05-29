Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C981C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 13:00:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCItX-0002lo-5L; Wed, 29 May 2024 08:59:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sCItV-0002lR-Af
 for qemu-devel@nongnu.org; Wed, 29 May 2024 08:59:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sCItT-0000oq-1d
 for qemu-devel@nongnu.org; Wed, 29 May 2024 08:59:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716987540;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gMkPNv9OyzkFSwmKeREyA8Y+7JB9Qq8gyfH+oydj9zI=;
 b=dXKSKq+E2dHW+XAnO8TPVgDQejgbIJAhzL22DV75exN2ClKYkLmVy1PwFWdLiyey6Wd4jy
 Plw1diuBzQ4X7S77zawD1OYAEbsRXjy5j0M/qykSo+ss48raH3elVJAjv/PjSL6hgT8F1I
 Yj0zR0LRR8m7y6N4EPd49+u/JpeiRPs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-gfRJZT8HMjOHmuccVbwqgQ-1; Wed, 29 May 2024 08:58:58 -0400
X-MC-Unique: gfRJZT8HMjOHmuccVbwqgQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4206b3500f5so17487055e9.1
 for <qemu-devel@nongnu.org>; Wed, 29 May 2024 05:58:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716987537; x=1717592337;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gMkPNv9OyzkFSwmKeREyA8Y+7JB9Qq8gyfH+oydj9zI=;
 b=o8GETxlmLR/G0sQtYo1nD4h/Dhe/ZsjS+u/39gl3Yimz6cx+dlhG0DgZ6O5aNNjJ4F
 lJhig/1uZ8FQ+E6dUKKr6OwvzAhIYKqNa2sM+EXp2TrWu5xhdddWrzVovrqDMMLu+ble
 3sv8qrgP/5TUFkN0JrXDyS6/NNvFv9Of9JVbT+5Pxa3UcOsUbY937TcBmd+EHl4zVvdd
 AHVmhl0Pi6r4CiDug5Uj8kjyEPC+bOhJv6bvFp7VhT29HvygzyJRoaXIDIrkZ2avb6wu
 Ss48/jRjvps65lhAK32zNzkyv4RlEf0jVAxGQ7IIh/jfiRBMlsWqFtpcda5YLFbWpc0i
 ktsQ==
X-Gm-Message-State: AOJu0YwxEl7a35EpOHxsUYTco//pSP6pPICuqg+kyubBfxnxxcIQqOk9
 nS095poSViRUMIAQPtN4LfvgjDohWx6A5YJHSQ6+qW8oxYbLS3GOhubUAKQ2iaDjK6GkhdhGAdd
 DvPR5J7ZWeITRC2mhWBjGho+byDEO9mtocmgb/7io47gDIfMwZH+M
X-Received: by 2002:a05:600c:4f4e:b0:421:1717:2cf0 with SMTP id
 5b1f17b1804b1-42117172daemr77951715e9.24.1716987537306; 
 Wed, 29 May 2024 05:58:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEf7yL1Qquv4Yzgu+DMK+2xPJ79zMWUl5+pmp9vmWMgx06Df54B4qf7uHWUDn1LpK0DX+ZTPQ==
X-Received: by 2002:a05:600c:4f4e:b0:421:1717:2cf0 with SMTP id
 5b1f17b1804b1-42117172daemr77951485e9.24.1716987536906; 
 Wed, 29 May 2024 05:58:56 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3557dcf001esm14898812f8f.97.2024.05.29.05.58.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 May 2024 05:58:56 -0700 (PDT)
Date: Wed, 29 May 2024 14:58:54 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Daniel P .
 =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>, Zhao Liu
 <zhao1.liu@intel.com>
Subject: Re: [PATCH v5 02/23] hw/i386/pc: Remove deprecated pc-i440fx-2.0
 machine
Message-ID: <20240529145854.5c51f2c6@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240529051539.71210-3-philmd@linaro.org>
References: <20240529051539.71210-1-philmd@linaro.org>
 <20240529051539.71210-3-philmd@linaro.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
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

On Wed, 29 May 2024 07:15:18 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> wrote:

> The pc-i440fx-2.0 machine was deprecated for the 8.2
> release (see commit c7437f0ddb "docs/about: Mark the
> old pc-i440fx-2.0 - 2.3 machine types as deprecated"),
> time to remove it.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  docs/about/deprecated.rst       |  2 +-
>  docs/about/removed-features.rst |  2 +-
>  include/hw/i386/pc.h            |  3 ---
>  hw/i386/pc.c                    | 15 -------------
>  hw/i386/pc_piix.c               | 37 ---------------------------------
>  5 files changed, 2 insertions(+), 57 deletions(-)
>=20
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index 7ff52bdd8e..629f6a1566 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -228,7 +228,7 @@ deprecated; use the new name ``dtb-randomness`` inste=
ad. The new name
>  better reflects the way this property affects all random data within
>  the device tree blob, not just the ``kaslr-seed`` node.
> =20
> -``pc-i440fx-2.0`` up to ``pc-i440fx-2.3`` (since 8.2) and ``pc-i440fx-2.=
4`` up to ``pc-i440fx-2.12`` (since 9.1)
> +``pc-i440fx-2.1`` up to ``pc-i440fx-2.3`` (since 8.2) and ``pc-i440fx-2.=
4`` up to ``pc-i440fx-2.12`` (since 9.1)
>  ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''=
''''''''''''''''''''''''''''''''''''''''
> =20
>  These old machine types are quite neglected nowadays and thus might have
> diff --git a/docs/about/removed-features.rst b/docs/about/removed-feature=
s.rst
> index fba0cfb0b0..5f0c2d8ec2 100644
> --- a/docs/about/removed-features.rst
> +++ b/docs/about/removed-features.rst
> @@ -925,7 +925,7 @@ mips ``fulong2e`` machine alias (removed in 6.0)
> =20
>  This machine has been renamed ``fuloong2e``.
> =20
> -``pc-0.10`` up to ``pc-i440fx-1.7`` (removed in 4.0 up to 8.2)
> +``pc-0.10`` up to ``pc-i440fx-2.0`` (removed in 4.0 up to 9.0)
>  ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
> =20
>  These machine types were very old and likely could not be used for live
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index ad9c3d9ba8..7347636d47 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -290,9 +290,6 @@ extern const size_t pc_compat_2_2_len;
>  extern GlobalProperty pc_compat_2_1[];
>  extern const size_t pc_compat_2_1_len;
> =20
> -extern GlobalProperty pc_compat_2_0[];
> -extern const size_t pc_compat_2_0_len;
> -
>  #define DEFINE_PC_MACHINE(suffix, namestr, initfn, optsfn) \
>      static void pc_machine_##suffix##_class_init(ObjectClass *oc, void *=
data) \
>      { \
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 7b638da7aa..11182e09ce 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -319,21 +319,6 @@ GlobalProperty pc_compat_2_1[] =3D {
>  };
>  const size_t pc_compat_2_1_len =3D G_N_ELEMENTS(pc_compat_2_1);
> =20
> -GlobalProperty pc_compat_2_0[] =3D {
> -    PC_CPU_MODEL_IDS("2.0.0")
> -    { "virtio-scsi-pci", "any_layout", "off" },
> -    { "PIIX4_PM", "memory-hotplug-support", "off" },
> -    { "apic", "version", "0x11" },
> -    { "nec-usb-xhci", "superspeed-ports-first", "off" },
> -    { "nec-usb-xhci", "force-pcie-endcap", "on" },
> -    { "pci-serial", "prog_if", "0" },
> -    { "pci-serial-2x", "prog_if", "0" },
> -    { "pci-serial-4x", "prog_if", "0" },
> -    { "virtio-net-pci", "guest_announce", "off" },
> -    { "ICH9-LPC", "memory-hotplug-support", "off" },
> -};
> -const size_t pc_compat_2_0_len =3D G_N_ELEMENTS(pc_compat_2_0);
> -
>  GSIState *pc_gsi_create(qemu_irq **irqs, bool pci_enabled)
>  {
>      GSIState *s;
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index 02878060d0..a750a0e6ab 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -441,11 +441,6 @@ static void pc_compat_2_1_fn(MachineState *machine)
>      x86_cpu_change_kvm_default("svm", NULL);
>  }
> =20
> -static void pc_compat_2_0_fn(MachineState *machine)
> -{
> -    pc_compat_2_1_fn(machine);
> -}
> -
>  #ifdef CONFIG_ISAPC
>  static void pc_init_isa(MachineState *machine)
>  {
> @@ -887,38 +882,6 @@ static void pc_i440fx_2_1_machine_options(MachineCla=
ss *m)
>  DEFINE_I440FX_MACHINE(v2_1, "pc-i440fx-2.1", pc_compat_2_1_fn,
>                        pc_i440fx_2_1_machine_options);
> =20
> -static void pc_i440fx_2_0_machine_options(MachineClass *m)
> -{
> -    PCMachineClass *pcmc =3D PC_MACHINE_CLASS(m);
> -
> -    pc_i440fx_2_1_machine_options(m);
> -    m->hw_version =3D "2.0.0";
> -    compat_props_add(m->compat_props, pc_compat_2_0, pc_compat_2_0_len);
> -    pcmc->smbios_legacy_mode =3D true;
> -    pcmc->has_reserved_memory =3D false;
> -    /* This value depends on the actual DSDT and SSDT compiled into
> -     * the source QEMU; unfortunately it depends on the binary and
> -     * not on the machine type, so we cannot make pc-i440fx-1.7 work on
> -     * both QEMU 1.7 and QEMU 2.0.
> -     *
> -     * Large variations cause migration to fail for more than one
> -     * consecutive value of the "-smp" maxcpus option.
> -     *
> -     * For small variations of the kind caused by different iasl version=
s,
> -     * the 4k rounding usually leaves slack.  However, there could be st=
ill
> -     * one or two values that break.  For QEMU 1.7 and QEMU 2.0 the
> -     * slack is only ~10 bytes before one "-smp maxcpus" value breaks!
> -     *
> -     * 6652 is valid for QEMU 2.0, the right value for pc-i440fx-1.7 on
> -     * QEMU 1.7 it is 6414.  For RHEL/CentOS 7.0 it is 6418.
> -     */
> -    pcmc->legacy_acpi_table_size =3D 6652;
> -    pcmc->acpi_data_size =3D 0x10000;
> -}
> -
> -DEFINE_I440FX_MACHINE(v2_0, "pc-i440fx-2.0", pc_compat_2_0_fn,
> -                      pc_i440fx_2_0_machine_options);
> -
>  #ifdef CONFIG_ISAPC
>  static void isapc_machine_options(MachineClass *m)
>  {


