Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E534FC25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 15:09:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCKvM-0003f7-D7; Wed, 29 May 2024 11:09:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sCKvL-0003eZ-EK
 for qemu-devel@nongnu.org; Wed, 29 May 2024 11:09:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sCKvJ-0007m7-MQ
 for qemu-devel@nongnu.org; Wed, 29 May 2024 11:09:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716995344;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2OO/wONrd8V4PwCRc7iPXvEV0sldSe+tF3eyyyxinlg=;
 b=ghhZugTRofBX9cdDaEyuWHTFW20OmOAv+vkrOyXWB3pu/76K2DHpVplPtxxoGHwZKFcAlp
 8/wnDO18q1XbdxyvEF/AEeZAl2Sf/6s6LK41N5XGf/Ct3kXwjhuHdRSWWFl/fm1A9JBPTX
 XKqq4zoJ9ql7zZ2AtkcBMERmMO3r5ys=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-RXHTOs6BNmyGAV4_8tvX4w-1; Wed, 29 May 2024 11:09:02 -0400
X-MC-Unique: RXHTOs6BNmyGAV4_8tvX4w-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-354ddb92ad8so1329130f8f.3
 for <qemu-devel@nongnu.org>; Wed, 29 May 2024 08:09:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716995341; x=1717600141;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2OO/wONrd8V4PwCRc7iPXvEV0sldSe+tF3eyyyxinlg=;
 b=jN0d2a6ayELzClR3QINKsueB+Zlmcw/8eL0YIwsns38tx8oVzELefUuiySLgJbliK/
 86+X6mTyBwfFOOs9bwCpiYHdCqcjiszZ/sJlkz0pltCCNGKW1mgsGDEULIhhybsxSWug
 W01N8nWAS9GUSha0EqfYk2n0ReT1RN9ofCtVTkXVdqMCTvRy4tm3ZWuFFJwhdZEvPxz6
 R+9cn9Q7fFVekomU3SWEO/RCRnsqF08fCd4XxUAY3PoboC1k2h1NYIeDBd5ziSmzKagx
 B13fkktcvKn7O3ujTnmIraQZUMICdMsd+lypXcJgl4nXXd/qScGLeX1MJ5kpaXZr30aH
 cagw==
X-Gm-Message-State: AOJu0YwpcBikPKi9tKJvejxgBqhzpOC1wnhgnpxvYgtQdA/Mtyhv3ECF
 LfBEIfzvVy4xiMtR541lTv+A09g4aLY6uLDrHuO4r/AZ49theHRQHQshpz2+7NwSM9mTYzKrrv4
 +o0a1kObZnCnrQuF6ZFY8/5COD24urYIrOyPc+8NTxn1/Q4CsGzGD
X-Received: by 2002:adf:f7cb:0:b0:355:841:aeaf with SMTP id
 ffacd0b85a97d-3552fcac738mr8583764f8f.33.1716995340937; 
 Wed, 29 May 2024 08:09:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1gQotXEykwdHwsXvN2p3KXmDN7xxecLVtDABnMsPC06DUmhJitmXm+cq0oreZ29Fldj9rsw==
X-Received: by 2002:adf:f7cb:0:b0:355:841:aeaf with SMTP id
 ffacd0b85a97d-3552fcac738mr8583737f8f.33.1716995340426; 
 Wed, 29 May 2024 08:09:00 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3557a0908e4sm15153643f8f.63.2024.05.29.08.08.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 May 2024 08:09:00 -0700 (PDT)
Date: Wed, 29 May 2024 17:08:59 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Daniel P .
 =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>
Subject: Re: [PATCH v5 20/23] hw/i386/pc: Remove deprecated pc-i440fx-2.3
 machine
Message-ID: <20240529170859.5dd5ed64@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240529051539.71210-21-philmd@linaro.org>
References: <20240529051539.71210-1-philmd@linaro.org>
 <20240529051539.71210-21-philmd@linaro.org>
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

On Wed, 29 May 2024 07:15:36 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> wrote:

> The pc-i440fx-2.3 machine was deprecated for the 8.2
> release (see commit c7437f0ddb "docs/about: Mark the
> old pc-i440fx-2.0 - 2.3 machine types as deprecated"),
> time to remove it.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  docs/about/deprecated.rst       |  4 ++--
>  docs/about/removed-features.rst |  2 +-
>  hw/i386/pc.c                    | 25 -------------------------
>  hw/i386/pc_piix.c               | 19 -------------------
>  4 files changed, 3 insertions(+), 47 deletions(-)
>=20
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index 0fa45aba8b..3d004a0818 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -228,8 +228,8 @@ deprecated; use the new name ``dtb-randomness`` inste=
ad. The new name
>  better reflects the way this property affects all random data within
>  the device tree blob, not just the ``kaslr-seed`` node.
> =20
> -``pc-i440fx-2.3`` up to ``pc-i440fx-2.3`` (since 8.2) and ``pc-i440fx-2.=
4`` up to ``pc-i440fx-2.12`` (since 9.1)
> -''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''=
''''''''''''''''''''''''''''''''''''''''
> +``pc-i440fx-2.4`` up to ``pc-i440fx-2.12`` (since 9.1)
> +''''''''''''''''''''''''''''''''''''''''''''''''''''''
> =20
>  These old machine types are quite neglected nowadays and thus might have
>  various pitfalls with regards to live migration. Use a newer machine type
> diff --git a/docs/about/removed-features.rst b/docs/about/removed-feature=
s.rst
> index 5d7bb4354b..2cbbd03cfd 100644
> --- a/docs/about/removed-features.rst
> +++ b/docs/about/removed-features.rst
> @@ -925,7 +925,7 @@ mips ``fulong2e`` machine alias (removed in 6.0)
> =20
>  This machine has been renamed ``fuloong2e``.
> =20
> -``pc-0.10`` up to ``pc-i440fx-2.2`` (removed in 4.0 up to 9.0)
> +``pc-0.10`` up to ``pc-i440fx-2.3`` (removed in 4.0 up to 9.0)
>  ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
> =20
>  These machine types were very old and likely could not be used for live
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 8e51d1f1bb..b84c8ddba0 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -264,31 +264,6 @@ GlobalProperty pc_compat_2_4[] =3D {
>  };
>  const size_t pc_compat_2_4_len =3D G_N_ELEMENTS(pc_compat_2_4);
> =20
> -GlobalProperty pc_compat_2_3[] =3D {
> -    PC_CPU_MODEL_IDS("2.3.0")
> -    { TYPE_X86_CPU, "arat", "off" },
> -    { "qemu64" "-" TYPE_X86_CPU, "min-level", "4" },
> -    { "kvm64" "-" TYPE_X86_CPU, "min-level", "5" },
> -    { "pentium3" "-" TYPE_X86_CPU, "min-level", "2" },
> -    { "n270" "-" TYPE_X86_CPU, "min-level", "5" },
> -    { "Conroe" "-" TYPE_X86_CPU, "min-level", "4" },
> -    { "Penryn" "-" TYPE_X86_CPU, "min-level", "4" },
> -    { "Nehalem" "-" TYPE_X86_CPU, "min-level", "4" },
> -    { "n270" "-" TYPE_X86_CPU, "min-xlevel", "0x8000000a" },
> -    { "Penryn" "-" TYPE_X86_CPU, "min-xlevel", "0x8000000a" },
> -    { "Conroe" "-" TYPE_X86_CPU, "min-xlevel", "0x8000000a" },
> -    { "Nehalem" "-" TYPE_X86_CPU, "min-xlevel", "0x8000000a" },
> -    { "Westmere" "-" TYPE_X86_CPU, "min-xlevel", "0x8000000a" },
> -    { "SandyBridge" "-" TYPE_X86_CPU, "min-xlevel", "0x8000000a" },
> -    { "IvyBridge" "-" TYPE_X86_CPU, "min-xlevel", "0x8000000a" },
> -    { "Haswell" "-" TYPE_X86_CPU, "min-xlevel", "0x8000000a" },
> -    { "Haswell-noTSX" "-" TYPE_X86_CPU, "min-xlevel", "0x8000000a" },
> -    { "Broadwell" "-" TYPE_X86_CPU, "min-xlevel", "0x8000000a" },
> -    { "Broadwell-noTSX" "-" TYPE_X86_CPU, "min-xlevel", "0x8000000a" },
> -    { TYPE_X86_CPU, "kvm-no-smi-migration", "on" },
> -};
> -const size_t pc_compat_2_3_len =3D G_N_ELEMENTS(pc_compat_2_3);
> -
>  GSIState *pc_gsi_create(qemu_irq **irqs, bool pci_enabled)
>  {
>      GSIState *s;
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index 1343fd93e7..217c749705 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -421,14 +421,6 @@ static void pc_set_south_bridge(Object *obj, int val=
ue, Error **errp)
>   * hw_compat_*, pc_compat_*, or * pc_*_machine_options().
>   */
> =20
> -static void pc_compat_2_3_fn(MachineState *machine)
> -{
> -    X86MachineState *x86ms =3D X86_MACHINE(machine);
> -    if (kvm_enabled()) {
> -        x86ms->smm =3D ON_OFF_AUTO_OFF;
> -    }
> -}
> -
>  #ifdef CONFIG_ISAPC
>  static void pc_init_isa(MachineState *machine)
>  {
> @@ -827,17 +819,6 @@ static void pc_i440fx_2_4_machine_options(MachineCla=
ss *m)
>  DEFINE_I440FX_MACHINE(v2_4, "pc-i440fx-2.4", NULL,
>                        pc_i440fx_2_4_machine_options)
> =20
> -static void pc_i440fx_2_3_machine_options(MachineClass *m)
> -{
> -    pc_i440fx_2_4_machine_options(m);
> -    m->hw_version =3D "2.3.0";
> -    compat_props_add(m->compat_props, hw_compat_2_3, hw_compat_2_3_len);
> -    compat_props_add(m->compat_props, pc_compat_2_3, pc_compat_2_3_len);
> -}
> -
> -DEFINE_I440FX_MACHINE(v2_3, "pc-i440fx-2.3", pc_compat_2_3_fn,
> -                      pc_i440fx_2_3_machine_options);
> -
>  #ifdef CONFIG_ISAPC
>  static void isapc_machine_options(MachineClass *m)
>  {


