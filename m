Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD598C10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 10:26:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4I0w-0005j2-Fw; Tue, 07 May 2024 06:25:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s4I0u-0005Yx-4W
 for qemu-devel@nongnu.org; Tue, 07 May 2024 06:25:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s4I0n-0005PM-85
 for qemu-devel@nongnu.org; Tue, 07 May 2024 06:25:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715077522;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N3RXN8ix4uYhIoxR9CrWaV+79qB0ZqSj9DDEjl5UtMc=;
 b=PpIotjJX6HCGczHujV6NzT9QTm7UtVHwr4sxmRCvEa9vPyhaw/uQpHemG8HoT6mYiNjyOt
 A56BBPJAfaQLmVo9QDZYrOZXemaPulUPc8ALCX368XVmzGO2I0RaZ/2DYzRsGaWQ4huNgr
 3y2Rjjz3UsI+0fmu7BNJ1M2RIGGbovw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-19-pc2TMzQyMC6U4dvVyYZM4A-1; Tue, 07 May 2024 06:25:20 -0400
X-MC-Unique: pc2TMzQyMC6U4dvVyYZM4A-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-34d8ccf34f8so2231982f8f.2
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 03:25:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715077519; x=1715682319;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N3RXN8ix4uYhIoxR9CrWaV+79qB0ZqSj9DDEjl5UtMc=;
 b=CfxZn6qvIoH4eITBy9WnzgaafJUsl1lmWtRy7INrwLME7bxckhngX6nJu/goMEPokq
 DJwUY805xaSb8Lz4zAqQbywID9LWBvu6kcP5BaqqHTeB3pbehc0xnYlRw29gph2FQ4tF
 EfOzAZ4RQXMUYNeNe7LfyfyEA7qcQoOnM5z5NlI/GfQHsoqHAVC0znSMKqEpZ+Nbhcc7
 dhcS8IvSM6mYZ/ZfDcU2A4k+YFEvxI2vzHvmgBnnJ7tJx0iowh/UNPj8ywkf232/yG9R
 95k1OQA+0kJjK2c8X6LpFWahp1hyo5IHOiwK0h9CJpNrtirDOzctQooqfKEsUPCsvBzf
 KA8g==
X-Gm-Message-State: AOJu0Yy+dEYt9hzdxo5X1s5f/yoCJpbY1mG+1bc7ABH0LgU+45c8Warm
 JvJfQVTZdi0D8fXyAkC0ptDVVZLrwfQP0Knsz2Mx547m0sSCENp9cRdUuV2QUqg7N0QcnuoU/0T
 WfbQK/w5t1+mMxf+s5cUmjddSk76KOqgmOkSKIThBBTiTJ8zi3iUYBXcArGYYCI0NVl9R05EveT
 5Ww2uSnE9ffce3x6rt+zhJQzQqFVyXMANDtn29uQ==
X-Received: by 2002:a5d:674f:0:b0:34c:5f3a:f44e with SMTP id
 l15-20020a5d674f000000b0034c5f3af44emr7239700wrw.45.1715077518873; 
 Tue, 07 May 2024 03:25:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEuaQNK+9v0QurQIYL4RtwmusEUptIRtqWTIrEx9GxgClc8JD9qPbUEwpoG7TGuEj7uLnnpz69plvhdnjsgNtk=
X-Received: by 2002:a5d:674f:0:b0:34c:5f3a:f44e with SMTP id
 l15-20020a5d674f000000b0034c5f3af44emr7239695wrw.45.1715077518502; Tue, 07
 May 2024 03:25:18 -0700 (PDT)
MIME-Version: 1.0
References: <20240507071948.105022-1-pbonzini@redhat.com>
 <20240507071948.105022-3-pbonzini@redhat.com>
 <db5af536-718b-48d8-9f82-57dc0ff9e74d@linaro.org>
In-Reply-To: <db5af536-718b-48d8-9f82-57dc0ff9e74d@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 7 May 2024 12:25:06 +0200
Message-ID: <CABgObfYBuUj6fzSEf5XbvY99EVrCMUmPziafwQUNE6t4cpqndg@mail.gmail.com>
Subject: Re: [PATCH 2/4] kconfig: express dependency of individual boards on
 libfdt
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Tue, May 7, 2024 at 9:48=E2=80=AFAM Philippe Mathieu-Daud=C3=A9 <philmd@=
linaro.org> wrote:
>
> On 7/5/24 09:19, Paolo Bonzini wrote:
> > Now that boards are enabled by default and the "CONFIG_FOO=3Dy"
> > entries are gone from configs/devices/, there cannot be any more
> > a conflicts between the default contents of configs/devices/
> > and a failed "depends on" clause.
> >
> > With this change, each individual board or target can express
> > whether it needs FDT.  It can also include it in the
> > build via "select DEVICE_TREE", instead of having each hw/*/meson.build
> > file do it by hand, and this will bring in more components
> > such as CONFIG_GUEST_LOADER.
> >
> > This allows building non-microvm x86 emulators without having
> > libfdt available.
> >
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> >   meson.build               |  1 +
> >   Kconfig.host              |  3 +++
> >   hw/arm/Kconfig            |  5 +++++
> >   hw/arm/meson.build        |  2 +-
> >   hw/core/Kconfig           |  9 ++++++++-
> >   hw/core/meson.build       |  2 +-
> >   hw/i386/Kconfig           |  3 ++-
> >   hw/loongarch/Kconfig      |  3 ++-
> >   hw/loongarch/meson.build  |  2 +-
> >   hw/mips/Kconfig           |  1 +
> >   hw/mips/meson.build       |  2 +-
> >   hw/openrisc/Kconfig       |  2 ++
> >   hw/openrisc/meson.build   |  4 ++--
> >   hw/ppc/Kconfig            | 15 ++++++++-------
> >   hw/ppc/meson.build        |  4 +---
> >   hw/riscv/Kconfig          |  4 ++++
> >   hw/riscv/meson.build      |  2 +-
> >   hw/rx/Kconfig             |  3 ++-
> >   hw/xtensa/Kconfig         |  1 +
> >   system/meson.build        |  2 +-
> >   target/arm/Kconfig        |  2 ++
> >   target/microblaze/Kconfig |  1 +
> >   target/openrisc/Kconfig   |  1 +
> >   target/riscv/Kconfig      |  2 ++
> >   24 files changed, 54 insertions(+), 22 deletions(-)
>
>
> > diff --git a/hw/arm/meson.build b/hw/arm/meson.build
> > index 6808135c1f7..aefde0c69a3 100644
> > --- a/hw/arm/meson.build
> > +++ b/hw/arm/meson.build
> > @@ -1,5 +1,5 @@
> >   arm_ss =3D ss.source_set()
> > -arm_ss.add(files('boot.c'), fdt)
> > +arm_ss.add(files('boot.c'))
>
> Don't we need to add fdt includes path to CPPFLAGS?

Good catch! I thought it'd be done automatically for all dependencies
included in common_ss (system_ss is included in common_ss and lists
fdt as a dependency), but actually it needs a small tweak:

diff --git a/meson.build b/meson.build
index 24502f4ff6a..342df23269d 100644
--- a/meson.build
+++ b/meson.build
@@ -3898,7 +3898,7 @@ foreach target : target_dirs

   target_common =3D common_ss.apply(config_target, strict: false)
   objects =3D common_all.extract_objects(target_common.sources())
-  deps =3D target_common.dependencies()
+  arch_deps +=3D target_common.dependencies()

   target_specific =3D specific_ss.apply(config_target, strict: false)
   arch_srcs +=3D target_specific.sources()
@@ -3954,7 +3954,7 @@ foreach target : target_dirs
     emulator =3D executable(exe_name, exe['sources'],
                install: true,
                c_args: c_args,
-               dependencies: arch_deps + deps + exe['dependencies'],
+               dependencies: arch_deps + exe['dependencies'],
                objects: lib.extract_all_objects(recursive: true),
                link_depends: [block_syms, qemu_syms],
                link_args: link_args,

I'll include it in a v2 once I test it more fully.

Paolo


