Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355EF606A8B6
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 15:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=I3goM+e1
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRWPY-0000IL-7h; Thu, 12 Nov 2026 10:08:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xRWPV-0000CC-LA
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 10:08:21 -0500
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xRWPT-0005EM-7O
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 10:08:21 -0500
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-6b167ffd132so1612764a12.1
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 07:08:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794496097; cv=none;
 d=google.com; s=arc-20260327;
 b=RrSyJ/gMrDvujRXoiwxxgjYVnAkaI9pONJxoIkH6z0m/LGlNsFaiZX6SCCgwAB2qiY
 e4lNQsuVCUQjPX5XgX1POb0CkMAeNSDr/OhjbePFS1EwTaImiC1uO2idrnVP7AMMaJVy
 vLqy9c2kqubBnfgLCk8KRmk0GvAt3H8Su9tket9feCbGVdIYPDgOenPLBFYTJmDDXoYr
 z0l6Y+IT2/CHhK7v8hJFmo+Cwn3En7j1BhpcHn1RAl87D4BEzSlhLhQGCjbVQ0+DItf8
 LTPNUaRet+R9MdWCghJ+NDeQkJOQmUVeKDDRKpn7a10Y8upKuUuc82yH9W/IFyDy6lYJ
 SuFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=qY1oUYkhSqdfdO2ozFjGAURD9vxT7X8YzCRmRqGd3jw=;
 fh=nix4+GlRgdmrBdIsvTlJ4IdWZHfR0KZEXFDPSgynqEk=;
 b=Lj+UTbMN4NvfCM+dT5/YK7dIIKYJLGPYpvDmBxMnp2pkBZZV4g8iNtyhS570mCjYO/
 ZJ4m6TZ3jLIZx7aQMWCMMak+SeeqOaS36lUv59RIM9CiN1zhCSrvYScuHtrV6fAqd+2+
 WScKKcyW/VUxUeQmrOlhcXqeAd90erNLGR+twMoQb8J6rdhoJCHtLz+TJCg1h4et6Ib/
 yfYJJqIJdrxAi0mmTdM50Qk/Nqv5Ah2TtFEaXM032Sbd7/EynAs2rB63ujeARBRR/hNL
 +umfW2X/DR2+R3uEzgzWGqIirHRziWQJuYWKEea1Je4Vo2/pdz6Ieeg6Ijx8OUmp7B6H
 rGbg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794496097; x=1795100897; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=qY1oUYkhSqdfdO2ozFjGAURD9vxT7X8YzCRmRqGd3jw=;
 b=I3goM+e1IEREGemQaDvWvyzolJz/iLOvcAdtRybmcpr/sNUsHbF+DW+kqhZx9TEZ3V
 /CxX4KP4k9pQZ9FIxrz2eVmO+Gd3lR8RoGL9VHwEWjwGcz9TmC3wkYR2CwIOWzuJpYRk
 ISzYVr23mjrrB41ACg5+2AcYwH2vU3sDU2BVmIC+prld0x0QPc0mlrklH/wmO7uRCjzA
 kgwgrNSXtX71QFvR3GRgZc6UjFpUY9L2HqRCQKtqQpm33avf3My8t6tCUD6vAsdjancO
 tEbpTRLSs+2hcdyDylFiw1DmxHr6Sgl4l1G2ewRaqipOFbUPpavNh7vWg0rZybVQBQfs
 h0+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794496097; x=1795100897;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qY1oUYkhSqdfdO2ozFjGAURD9vxT7X8YzCRmRqGd3jw=;
 b=fxGOh4Ke52M0R8KkJG82psseu+fKWkdBjEkgV6hLo4lGXHzzoKQ73CUlmwrjLKqqpX
 /BKSVtaL0g7wA2dBtuvhrI1X9DJY1KmwBjxd681VywibC3S+zgi7/k0jmEr2f9h2X3sc
 ZHsbcXqo1uW1A3sAij791xqHmzC0ajzJiBu2K3EfNxwr2aTKRwYzz+tKlGFN7eactwvY
 c0r4QQQ53oIo4qrtCmw8OGOrnkTTFC2CN7x6tAlOVTokUs0k6UBGZpeptTmjREVFi7hV
 2Ue/EX5zY58BMMwPpH9OjDA9e97Nsl49ZQffD6YH0S8eda4OUWVmDvRlUPq4Ft6xURmW
 tW3w==
X-Gm-Message-State: APuU4Z8eEfSNkrby9RvhjU5G9q6QeqsVszIEqJ9sm17VdNacMvJJ6Cjj
 ok44H4LYp7Ug/iPLd4GamfWrb4ltQg5uSEEhkEO5g9wqwygilUzAw6ypKsHPA2dvGt00xDzM32n
 ieIcgtgdykBcNR23QbZTuT+4pG6bAXT4=
X-Gm-Gg: AYBFou1B/FWQ2k4o5SRwlTO/dcK1FMZBBzfyQ1w1c0ht2ee//03YJwA9T2K3xMsoDH7
 Qj/QqdxCiIGlgpp1bzeXIFYHsXTEc+LAzFx8om1dg3oR+AIX3wu86qwoFj8HYYXbUN6o/w7mBQM
 /OoyZ0x+04BcHydpZeEgUQQhpaWTHWYTvkppi8l3xssNOOg/JbgnBpaq0yWmL0gYZxCp1TjHDUv
 PjfPEUfbPVepjDtV3zE58yKvy1sB3WGwjeBUvDgqjunyejeaMs3F67h0wxhtj3MebKf8eOzGlND
 UEM0CNA+mHao+eQBZhoze7cev87SQu/0fgUTo6IPZhe8zmj3BZ3wxLIV02EgEi5eylzDvCeB8da
 sk9gMSzkqEnx6fBhIwQe9TYooDTdvnDJFm9VM
X-Received: by 2002:a05:6402:5642:b0:6b7:709f:852 with SMTP id
 4fb4d7f45d1cf-6b7775eb944mr3153074a12.27.1794496097050; Thu, 12 Nov 2026
 07:08:17 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261112133054.1977618-1-berrange@redhat.com>
In-Reply-To: <20261112133054.1977618-1-berrange@redhat.com>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Thu, 12 Nov 2026 23:08:02 +0800
X-Gm-Features: AclHuK_GwMe5J08AaAgsO0RRdZdlN2SmQr4ZT56DSLIesvE9NIy86LlSBZeHdIU
Message-ID: <CAE2XoE8OvtmLOx9LqmL=aOu2ptu0UpFGYwOdU5YHQ3N=9e1rpg@mail.gmail.com>
Subject: Re: [PATCH 00/48] hw: resolve QOM type conflicts in multi-target
 builds
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=luoyonggang@gmail.com; helo=mail-ed1-x52d.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: luoyonggang@gmail.com
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 12, 2026 at 9:31=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> When building a multi-target binary, QOM types from multiple targets
> will be linked together. QOM types are required to have unique names
> when registered, so linking multiple targets in turn requires QOM type
> names to be unique across the QEMU codebase.
>
> Global QOM type name uniqueness is a desirable property for QEMU
> regardless of multi-target work, so that QEMU presents a non-ambiguous
> object model to applications regardless of context.
>
> In a multi-target binary, it is desirable to applications are able to
> introspect all types linked into QEMU, when launching with '-machine
> none'. Dynamic filtering of registered classes at runtime, to resolving
> QOM naming conflicts is undesirable, as it requires introspection
> to be repeated for each available target in order to discover the full
> set of available types in a binary.
>
> Introspection is a fairly heavy weight process due to QEMU's vast size,
> so enabling introspection to be done once only for all targets will be a
> very significant benefit for management applications with a multi-target
> binary.
>
> The glaring problem is that our historical design has led to multiple
> targets all providing a 'virt' machine type, which leads to multiple QOM
> types call 'virt-machine' which are all different.
>
> Having a common short name "virt" is a useful characteristic for users,
> but this does not imply we need to use that as the basis for primary QOM
> typename. It is sufficient to have an alias called 'virt'.
>
> In terms of implementation there are two core pieces
>
>  * An 'Aliased' interface which can be implemented by QOM types which
>    want to support type aliases.
>
>  * A 'TargetSpecific' interface which can be implemented by QOM types
>    which want to declare  they can only be used with a subset of targets.
>
> With those foundational pieces
>
>  * Machine implements Aliased and TargetSpecific
>
>  * query-machines reports multiple aliases and declared supported
>    targets per machine for introspection
>
>  * All the 'virt' machines are renamed to $target-virt, and aliases
>    added for the shorter 'virt' names to retain compatibility and
>    convenience when a target is selected
>
>  * All the machines which have 'is_available' set now report their
>    targets via the TargetSpecific  interface
>
>  * Creating machines validates declared targets from TargetSpecific
>
> An apparent design mistake in TYPE_ACCEL_CPU is resolved which allows

Target independent TYPE_ACCEL_CPU  is my first choice, if the QOM name is
do not have to be kept, I think this is better.

> removal of the is_available hooks from target specific CPU impls, which
> were working around the bug.
>
> The original proposed patches to unconditionally register some object
> properties is pulled in.
>
> Overall this brings us closer to having a single unified object model
> across all targets, without having to make runtime variations of what
> is exposed/reported by a given QOM class name.


Thanks, overall looks good to me.

hw/microblaze: defer PetaLogix endianness default until init:
https://lore.kernel.org/qemu-devel/20261105194958.1117-5-luoyonggang@gmail.=
com/

is also for avoid target_info in class_init



The last gap is how to handling cpu class name conflict
target/arm: register separate max-v8 CPU types for arm and aarch64:
https://lore.kernel.org/qemu-devel/20261031164009.2048-7-luoyonggang@gmail.=
com/

>
> Daniel P. Berrang=C3=A9 (43):
>   iotests: better heuristics to find I/O tests build/source dirs
>   qom: define a TargetSpecific interface
>   qom: define an Aliased interface
>   hw: tweak approach to setting alias in machine macros
>   hw/core: implement TYPE_ALIASED interface in machines
>   qapi: report multiple aliases in MachineInfo
>   system: report multiple machine aliases in help output
>   system: increase space for machine name in '-machine help'
>   system: resolve multiple aliases when creating machines
>   qapi: deprecate 'alias' field in MachineInfo
>   hw/arm: convert machines to use AliasedClass interface
>   hw/avr: convert machines to use AliasedClass interface
>   hw/hexagon: convert machines to use AliasedClass interface
>   hw/i386: convert machines to use AliasedClass interface
>   hw/loongarch: convert machines to use AliasedClass interface
>   hw/m68k: convert machines to use AliasedClass interface
>   hw/ppc: convert machines to use AliasedClass interface
>   hw/s390x: convert machines to use AliasedClass interface
>   include/hw: convert machine docs to use AliasedClass interface
>   hw: drop 'alias' field from MachineClass
>   hw/arm: rename the 'virt' machines to 'arm-virt'
>   hw/riscv: rename the 'virt' machines to 'riscv-virt'
>   hw/hexagon: rename the 'virt' machine to 'hexagon-virt'
>   hw/loongarch: rename the 'virt' machine to 'loongarch-virt'
>   hw/m68k: rename the 'virt' machine to 'm68k-virt'
>   hw/or1k: rename the 'virt' machine to 'or1k-virt'
>   hw/xtensa: rename the 'virt' machine to 'xtensa-virt'
>   system: stop sorting machine names based on 'family'
>   system: put machine aliases in alphbetical order
>   system: filter machine type list if a target is selected
>   hw/core: filter machine type list if a target is selected
>   system: filter machines based on target during creation
>   hw/core: implement TYPE_TARGET_SPECIFIC for machine
>   qapi: report target compatibility for machine types
>   hw/arm: declare arm machine targets
>   hw/hexagon: declare hexagon machine target
>   hw/m68k: declare m68k machine target
>   hw/or1k: declare or1k machine target
>   hw/riscv: declare riscv machine target
>   accel: make TYPE_ACCEL_CPU name target independent
>   Revert "multi-target: restrict whpx-accel-*-cpu to matching target"
>   Revert "target/riscv/kvm: restrict kvm-accel-riscv-cpu to riscv
>     targets"
>   qom: drop the 'is_available' callback from TypeInfo
>
> Pierrick Bouvier (1):
>   Revert "target/riscv/tcg: restrict tcg-accel-riscv-cpu to riscv
>     targets"
>
> Yonggang Luo (4):
>   target-info: add target_mask_selected()
>   hw/pci: unconditionally expose the 'loadparm' property
>   hw/scsi: unconditionally expose the 'loadparm' property
>   hw/virtio/virtio-mem: unconditionally expose 'unplugged-inaccessible'
>
>  accel/accel-common.c             |   3 +-
>  accel/whpx/whpx-common.c         |   8 --
>  docs/about/deprecated.rst        |   7 ++
>  hw/arm/aspeed_ast27x0-fc.c       |   5 +-
>  hw/arm/aspeed_ast27x0_evb.c      |  14 ++-
>  hw/arm/raspi.c                   |   9 +-
>  hw/arm/raspi4b.c                 |   6 +-
>  hw/arm/virt.c                    |  43 +++++++--
>  hw/arm/xlnx-versal-virt.c        |   7 +-
>  hw/avr/arduino.c                 |  30 +++++-
>  hw/core/machine-qmp-cmds.c       |  52 ++++++++++-
>  hw/core/machine.c                |   5 +
>  hw/hexagon/hexagon_dsp.c         |   7 +-
>  hw/hexagon/virt.c                |  11 ++-
>  hw/i386/pc_piix.c                |  25 ++++-
>  hw/i386/pc_q35.c                 |  20 +++-
>  hw/loongarch/virt.c              |  39 ++++++--
>  hw/m68k/virt.c                   |  46 +++++++---
>  hw/or1k/virt.c                   |  14 ++-
>  hw/pci/pci.c                     |  18 ++--
>  hw/ppc/pnv.c                     |   7 +-
>  hw/ppc/spapr.c                   |  31 ++++---
>  hw/riscv/virt.c                  |  14 ++-
>  hw/s390x/s390-virtio-ccw.c       |  24 +++--
>  hw/scsi/scsi-disk.c              |  18 ++--
>  hw/virtio/virtio-mem.c           |  12 +--
>  hw/xtensa/virt.c                 |   9 +-
>  include/accel/accel-cpu-target.h |   3 +-
>  include/accel/accel-cpu.h        |   2 +
>  include/hw/arm/virt.h            |   2 +-
>  include/hw/core/boards.h         |  29 ++++--
>  include/hw/hexagon/virt.h        |   2 +-
>  include/hw/i386/pc.h             |   5 +-
>  include/hw/loongarch/virt.h      |   2 +-
>  include/hw/riscv/virt.h          |   2 +-
>  include/qemu/target-info-init.h  |  15 ++-
>  include/qemu/target-info.h       |   9 ++
>  include/qom/object.h             |   3 -
>  include/qom/object_interfaces.h  | 152 +++++++++++++++++++++++++++++++
>  meson.build                      |   1 +
>  qapi/machine.json                |  19 +++-
>  qom/object.c                     |   4 -
>  qom/object_interfaces.c          |  88 ++++++++++++++++++
>  rust/qom/src/qom.rs              |   1 -
>  stubs/meson.build                |   1 +
>  stubs/target-mask-selected.c     |  13 +++
>  system/vl.c                      | 115 ++++++++++++-----------
>  target-info-def.c                |   3 +
>  target-info-qom.c                |  10 ++
>  target/riscv/kvm/kvm-cpu.c       |   2 -
>  target/riscv/tcg/tcg-cpu.c       |   1 -
>  tests/qemu-iotests/check         |  52 ++++++++---
>  52 files changed, 804 insertions(+), 216 deletions(-)
>  create mode 100644 stubs/target-mask-selected.c
>
> --
> 2.56.1
>


--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

