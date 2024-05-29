Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34D85C27C44
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 14:46:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCKYN-0006XE-GB; Wed, 29 May 2024 10:45:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sCKYK-0006UO-Ln
 for qemu-devel@nongnu.org; Wed, 29 May 2024 10:45:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sCKYI-0003h8-O1
 for qemu-devel@nongnu.org; Wed, 29 May 2024 10:45:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716993917;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o5Odp+T+mRZtEDIu05Xn/N9Z+srPwdU7O3B+gRAvI3w=;
 b=FbazRL/t1gAulTk2yNyN3u7vh9NtFNE47AisMGBcjbyNRZpIqCEBqLZ5PRdo3dJENlWDAS
 4rWsm6fh5gJxBkhRyy+u4LvCZb6bpu+Yi9rqKIWW/vjoOscT2eE/dmFx45KHRTLfXh7thF
 4/ELvzj11NlNdDtMVX2gzmRFdR9o1oY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-iZ-gh1jiPKOCUAieDzLsvg-1; Wed, 29 May 2024 10:45:15 -0400
X-MC-Unique: iZ-gh1jiPKOCUAieDzLsvg-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-35507fa2570so1571241f8f.1
 for <qemu-devel@nongnu.org>; Wed, 29 May 2024 07:45:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716993914; x=1717598714;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o5Odp+T+mRZtEDIu05Xn/N9Z+srPwdU7O3B+gRAvI3w=;
 b=X4+bk7BwDEa5PRUHMy1khwOmTZMvgOrCGWaTHxDO7ki2UcFHlctUU1nF1dBuwgT5fA
 hx36UJHFuEVBzXxZ6ApeCYXEs6Hig4md4z5zwnXvqeTl3x1aSHD19ocTcPbDdxszSd9f
 oeYoY8GvcW1+O7XWixeIytr7bUU93la0ATNAypvFjgHmxdLMnr7FUa3sHe5dp0YJrGeI
 IW0pZVfj3z6z+ReyrkHMzD/NbrS3jhz1W22fQ52U5FZmKJ1n8CVM1dbm25kBmzgqd/xx
 QoxR6pW+QOyGp76IfSLOoYnneN3ag1Q85ysUInAue0QsTZAwHcFfXOezYv9gQHlWv99K
 Jwig==
X-Gm-Message-State: AOJu0Yymrm0PMnlLJdlPAVldOUs0dn1Xh7BN3Nva7J/ltFyX2mxZUXfQ
 eiETxeDRLTIzMcR6+6Jekud2ywc9gYYBXpquxJ1vLf4SSsn3fulVaM5lK61o3AcLp/BgjCK1/82
 hLvzStOzNv5NbY73P9jlA0PNlB3uavpoFx4Nh6GddnxQhv1pCIGQX
X-Received: by 2002:a5d:58f1:0:b0:34c:65ba:5d43 with SMTP id
 ffacd0b85a97d-3552fde04c5mr11117031f8f.46.1716993914282; 
 Wed, 29 May 2024 07:45:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFoOwNGtlEQNg3OuBKtcBuun/p8SpkjkSdNpZBDnbr99kjfwtZMCR/ZU3n3xpIFQs7D0hVww==
X-Received: by 2002:a5d:58f1:0:b0:34c:65ba:5d43 with SMTP id
 ffacd0b85a97d-3552fde04c5mr11117011f8f.46.1716993913792; 
 Wed, 29 May 2024 07:45:13 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3557a09091csm14931158f8f.50.2024.05.29.07.45.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 May 2024 07:45:13 -0700 (PDT)
Date: Wed, 29 May 2024 16:45:12 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Daniel P .
 =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>, Zhao Liu
 <zhao1.liu@intel.com>
Subject: Re: [PATCH v5 16/23] hw/i386/pc: Remove deprecated pc-i440fx-2.2
 machine
Message-ID: <20240529164512.72684081@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240529051539.71210-17-philmd@linaro.org>
References: <20240529051539.71210-1-philmd@linaro.org>
 <20240529051539.71210-17-philmd@linaro.org>
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

On Wed, 29 May 2024 07:15:32 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> wrote:

> The pc-i440fx-2.2 machine was deprecated for the 8.2
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
>  hw/i386/pc.c                    | 23 -----------------------
>  hw/i386/pc_piix.c               | 21 ---------------------
>  5 files changed, 2 insertions(+), 49 deletions(-)
>=20
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index 5b4753e5dc..0fa45aba8b 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -228,7 +228,7 @@ deprecated; use the new name ``dtb-randomness`` inste=
ad. The new name
>  better reflects the way this property affects all random data within
>  the device tree blob, not just the ``kaslr-seed`` node.
> =20
> -``pc-i440fx-2.2`` up to ``pc-i440fx-2.3`` (since 8.2) and ``pc-i440fx-2.=
4`` up to ``pc-i440fx-2.12`` (since 9.1)
> +``pc-i440fx-2.3`` up to ``pc-i440fx-2.3`` (since 8.2) and ``pc-i440fx-2.=
4`` up to ``pc-i440fx-2.12`` (since 9.1)
>  ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''=
''''''''''''''''''''''''''''''''''''''''
> =20
>  These old machine types are quite neglected nowadays and thus might have
> diff --git a/docs/about/removed-features.rst b/docs/about/removed-feature=
s.rst
> index 9b0e2f11de..5d7bb4354b 100644
> --- a/docs/about/removed-features.rst
> +++ b/docs/about/removed-features.rst
> @@ -925,7 +925,7 @@ mips ``fulong2e`` machine alias (removed in 6.0)
> =20
>  This machine has been renamed ``fuloong2e``.
> =20
> -``pc-0.10`` up to ``pc-i440fx-2.1`` (removed in 4.0 up to 9.0)
> +``pc-0.10`` up to ``pc-i440fx-2.2`` (removed in 4.0 up to 9.0)
>  ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
> =20
>  These machine types were very old and likely could not be used for live
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index 1351e73ee0..996495985e 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -279,9 +279,6 @@ extern const size_t pc_compat_2_4_len;
>  extern GlobalProperty pc_compat_2_3[];
>  extern const size_t pc_compat_2_3_len;
> =20
> -extern GlobalProperty pc_compat_2_2[];
> -extern const size_t pc_compat_2_2_len;
> -
>  #define DEFINE_PC_MACHINE(suffix, namestr, initfn, optsfn) \
>      static void pc_machine_##suffix##_class_init(ObjectClass *oc, void *=
data) \
>      { \
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index c7d44420a5..ccfcb92605 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -289,29 +289,6 @@ GlobalProperty pc_compat_2_3[] =3D {
>  };
>  const size_t pc_compat_2_3_len =3D G_N_ELEMENTS(pc_compat_2_3);
> =20
> -GlobalProperty pc_compat_2_2[] =3D {
> -    PC_CPU_MODEL_IDS("2.2.0")
> -    { "kvm64" "-" TYPE_X86_CPU, "vme", "off" },
> -    { "kvm32" "-" TYPE_X86_CPU, "vme", "off" },
> -    { "Conroe" "-" TYPE_X86_CPU, "vme", "off" },
> -    { "Penryn" "-" TYPE_X86_CPU, "vme", "off" },
> -    { "Nehalem" "-" TYPE_X86_CPU, "vme", "off" },
> -    { "Westmere" "-" TYPE_X86_CPU, "vme", "off" },
> -    { "SandyBridge" "-" TYPE_X86_CPU, "vme", "off" },
> -    { "Haswell" "-" TYPE_X86_CPU, "vme", "off" },
> -    { "Broadwell" "-" TYPE_X86_CPU, "vme", "off" },
> -    { "Opteron_G1" "-" TYPE_X86_CPU, "vme", "off" },
> -    { "Opteron_G2" "-" TYPE_X86_CPU, "vme", "off" },
> -    { "Opteron_G3" "-" TYPE_X86_CPU, "vme", "off" },
> -    { "Opteron_G4" "-" TYPE_X86_CPU, "vme", "off" },
> -    { "Opteron_G5" "-" TYPE_X86_CPU, "vme", "off" },
> -    { "Haswell" "-" TYPE_X86_CPU, "f16c", "off" },
> -    { "Haswell" "-" TYPE_X86_CPU, "rdrand", "off" },
> -    { "Broadwell" "-" TYPE_X86_CPU, "f16c", "off" },
> -    { "Broadwell" "-" TYPE_X86_CPU, "rdrand", "off" },
> -};
> -const size_t pc_compat_2_2_len =3D G_N_ELEMENTS(pc_compat_2_2);
> -
>  GSIState *pc_gsi_create(qemu_irq **irqs, bool pci_enabled)
>  {
>      GSIState *s;
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index e0b421dd51..1343fd93e7 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -429,11 +429,6 @@ static void pc_compat_2_3_fn(MachineState *machine)
>      }
>  }
> =20
> -static void pc_compat_2_2_fn(MachineState *machine)
> -{
> -    pc_compat_2_3_fn(machine);
> -}
> -
>  #ifdef CONFIG_ISAPC
>  static void pc_init_isa(MachineState *machine)
>  {
> @@ -843,22 +838,6 @@ static void pc_i440fx_2_3_machine_options(MachineCla=
ss *m)
>  DEFINE_I440FX_MACHINE(v2_3, "pc-i440fx-2.3", pc_compat_2_3_fn,
>                        pc_i440fx_2_3_machine_options);
> =20
> -static void pc_i440fx_2_2_machine_options(MachineClass *m)
> -{
> -    PCMachineClass *pcmc =3D PC_MACHINE_CLASS(m);
> -
> -    pc_i440fx_2_3_machine_options(m);
> -    m->hw_version =3D "2.2.0";
> -    m->default_machine_opts =3D "firmware=3Dbios-256k.bin,suppress-vmdes=
c=3Don";
> -    compat_props_add(m->compat_props, hw_compat_2_2, hw_compat_2_2_len);
> -    compat_props_add(m->compat_props, pc_compat_2_2, pc_compat_2_2_len);
> -    pcmc->rsdp_in_ram =3D false;
> -    pcmc->resizable_acpi_blob =3D false;
> -}
> -
> -DEFINE_I440FX_MACHINE(v2_2, "pc-i440fx-2.2", pc_compat_2_2_fn,
> -                      pc_i440fx_2_2_machine_options);
> -
>  #ifdef CONFIG_ISAPC
>  static void isapc_machine_options(MachineClass *m)
>  {


