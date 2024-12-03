Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58AD6E74AC1
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 15:54:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIVDv-0003C9-JN; Tue, 03 Dec 2024 10:54:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tIVDq-0003AJ-FJ
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 10:53:59 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tIVDm-0002jo-Tr
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 10:53:58 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5cfa1ec3b94so6523455a12.2
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 07:53:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733241233; x=1733846033; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=z1Wtru9pvXa/IJNJN+VXW7STk8hQ+N2dJ5RSBmCeI6Y=;
 b=Xp6whZ8V0q5pFs/MyfpKSeBHVTJrakHkkPng0lR9E4hgKSFzlcbGjpfbR7+0ty8g1H
 gyATzdAXHTupFteWFSysvxZlxUfKlpo2Xcojj2XnJ5+OitpBivS84Pud9GrleUs4/VkU
 Ss1uJW2A/1MLPYrM6HFqxMsxC6+Ipzl046lVUr/bn6yrxs9XifWAb3MaWQv1g1MXZ07D
 8CtxOqLu29XstLfsEJuFThFut+ceEMKFYfJAVszMz/H25ZRswCxSo2xJPcKzifbvjMzT
 796YF9m8lT6D+nnNVWxju1lrW2MUHX7VoinRmCgRGmzW4VFzmuahruglHyMhRKBLi/s2
 jYJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733241233; x=1733846033;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=z1Wtru9pvXa/IJNJN+VXW7STk8hQ+N2dJ5RSBmCeI6Y=;
 b=C6S9Bk2794d9ZoD2JuvTy2Qbn3qvRs/R/hbI9YuG+1E3/vcRK5uY+oFD5i7pgGYR0i
 r8krNpJ/wdXCtzaysXP7u8os1RM2+7TiFN5qlyChhRuc+dylmwkAVj7Fy9WmYSdUA6j1
 XrZpSv+GfyDlDskukOnd0Pjk2RAADwq6p7ZUsxDY6zvXf/EMZtRtGHjAahGDN7kZwbvy
 jU9sc7LiiVVFKEgld5pn1yCOlKsn9F0JXCrXllIzsrLxLqpJwHv+D4pFovQG55zCpMah
 cPq1Rx4qDhYw8RPZuFsKFdDT+8HBjit6FPYBgf4vI7UKpBw+cZaJ1Mnt7DDTWUmNUHrj
 Ytew==
X-Gm-Message-State: AOJu0YwciTY7mFBSwLTYhAR5jaESOX3RN2do0tI1dJXV2tN3S9REmiPe
 Zs0+EaMFV83iHJ/HbIlabAkqyuto1+eoajlL8+gU87BTMtqrXXzbgD3/oV+nawLO5yPqFjizLe1
 X+NkTOF0DnCsJy5iRoCyRAe3BptRBo342B3M8ew==
X-Gm-Gg: ASbGncttB9D6xSiOpzQNmXUyV2fl9ueyiQyBVbDfBFs/SIGGKrNVxLYeKXHrSoc41Fx
 mNHy/PNrs8Ci5n09JVxI8Ii21Pt51iom9
X-Google-Smtp-Source: AGHT+IEpJlFNuS+qcUgTdY1jUvamA1JJNxMOHvFgkcDtdc44QY61D9O+OSRBA/xqrV1cx1GOsnf3gGGJljwpSX6OcrY=
X-Received: by 2002:a05:6402:13cc:b0:5d0:f718:17fd with SMTP id
 4fb4d7f45d1cf-5d10cb55b1cmr2208407a12.14.1733241233150; Tue, 03 Dec 2024
 07:53:53 -0800 (PST)
MIME-Version: 1.0
References: <20241118172357.475281-1-pierrick.bouvier@linaro.org>
 <20241118172357.475281-6-pierrick.bouvier@linaro.org>
In-Reply-To: <20241118172357.475281-6-pierrick.bouvier@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Dec 2024 15:53:42 +0000
Message-ID: <CAFEAcA-UkmPvyNW_6o22-WhaLxnnji55UsBp3UcPA-gYH7kvVg@mail.gmail.com>
Subject: Re: [PATCH 5/7] docs: add a codebase section
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Andrew Melnychenko <andrew@daynix.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Jason Wang <jasowang@redhat.com>, Thomas Huth <thuth@redhat.com>,
 alex.bennee@linaro.org, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Fabiano Rosas <farosas@suse.de>, 
 Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Eric Blake <eblake@redhat.com>, 
 qemu-arm@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>, 
 manos.pitsidianakis@linaro.org, qemu-block@nongnu.org, 
 Michael Roth <michael.roth@amd.com>, Konstantin Kostiuk <kkostiuk@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 gustavo.romero@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, 18 Nov 2024 at 17:24, Pierrick Bouvier
<pierrick.bouvier@linaro.org> wrote:
>
> Present the various parts of QEMU and organization of codebase.
>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

I like this; it's something I've thought for a while would
be good to have, but which I never got round to trying to
put together. Thanks for doing this!

Mostly my comments below are spelling/typo nits and
other minor stuff.

> ---
>  docs/about/emulation.rst               |   2 +
>  docs/codebase/index.rst                | 211 +++++++++++++++++++++++++
>  docs/devel/decodetree.rst              |   2 +
>  docs/devel/ebpf_rss.rst                |   2 +
>  docs/devel/index-internals.rst         |   2 +
>  docs/devel/migration/main.rst          |   2 +
>  docs/devel/qapi-code-gen.rst           |   1 +
>  docs/devel/testing/main.rst            |   9 +-
>  docs/devel/testing/qtest.rst           |   2 +
>  docs/index.rst                         |   3 +
>  docs/interop/qemu-ga.rst               |   2 +
>  docs/system/qemu-block-drivers.rst.inc |   2 +
>  docs/tools/qemu-storage-daemon.rst     |   2 +
>  docs/user/main.rst                     |   6 +
>  14 files changed, 247 insertions(+), 1 deletion(-)
>  create mode 100644 docs/codebase/index.rst
>
> diff --git a/docs/about/emulation.rst b/docs/about/emulation.rst
> index 3028d5fff7a..3bc3579434f 100644
> --- a/docs/about/emulation.rst
> +++ b/docs/about/emulation.rst
> @@ -176,6 +176,8 @@ for that architecture.
>      - System
>      - Tensilica ISS SIMCALL
>
> +.. _tcg-plugins:
> +
>  TCG Plugins
>  -----------
>
> diff --git a/docs/codebase/index.rst b/docs/codebase/index.rst
> new file mode 100644
> index 00000000000..353830ef175
> --- /dev/null
> +++ b/docs/codebase/index.rst

This is developer documentation, so I think it should
be in docs/devel/.

> @@ -0,0 +1,211 @@
> +========
> +Codebase
> +========
> +
> +This section present the various parts of QEMU and how codebase is organized.

"presents"; "how the codebase"

> +
> +Beyond giving succint descriptions, the goal is to offer links to various

"succinct"

> +parts of the documentation/codebase.
> +
> +Subsystems
> +----------
> +
> +An exhaustive list of subsystems and files associated can be found in

"associated files"

"the MAINTAINERS file"

> +`MAINTAINERS <https://gitlab.com/qemu-project/qemu/-/blob/master/MAINTAINERS>`_
> +file.
> +
> +Some of the main QEMU subsystems are:
> +
> +- `Accelerators<Accelerators>`
> +- Block devices and `disk images<disk images>` support
> +- `CI<ci>` and `Tests<testing>`
> +- `Devices<device-emulation>` & Board models
> +- `Documentation <documentation-root>`
> +- `GDB support<GDB usage>`
> +- `Migration<migration>`
> +- `Monitor<QEMU monitor>`
> +- `QOM (QEMU Object Model)<qom>`
> +- `System mode<System emulation>`
> +- `TCG (Tiny Code Generator)<tcg>`
> +- `User mode<user-mode>` (`Linux<linux-user-mode>` & `BSD<bsd-user-mode>`)
> +- User Interfaces
> +
> +More documentation on QEMU subsystems can be found on :ref:`internal-subsystem`
> +page.
> +
> +The Grand tour
> +--------------
> +
> +We present briefly here what every folder of the codebase contains. Hop on!


I think it would be helpful to mention at the top of this list something
like:

 The folder name links here will take you to that folder in our
 gitlab repository; other links will take you to more detailed
 documentation for that subsystem, where we have it. Unfortunately
 not every subsystem has documentation yet, so sometimes the
 source code is all you have.

just so readers know that if e.g. they have a local source tree
already there's no point in clicking on the 'crypto' link etc,
but that other links are going to go somewhere with more
human-written detail.

> +
> +* `accel <https://gitlab.com/qemu-project/qemu/-/tree/master/accel>`_:
> +  Infrastructure and architecture agnostic code related to the various
> +  `accelerators <Accelerators>` supported by QEMU
> +  (TCG, KVM, hvf, whpx, xen, nvmm).
> +  Contains interfaces for operations that will be implemented per
> +  `target <https://gitlab.com/qemu-project/qemu/-/tree/master/target>`_.
> +* `audio <https://gitlab.com/qemu-project/qemu/-/tree/master/audio>`_:
> +  Audio (host) support.
> +* `authz <https://gitlab.com/qemu-project/qemu/-/tree/master/authz>`_:
> +  `QEMU Authorization framework<client authorization>`.
> +* `backends <https://gitlab.com/qemu-project/qemu/-/tree/master/backends>`_:
> +  Various backends used for device emulation.
> +* `block <https://gitlab.com/qemu-project/qemu/-/tree/master/block>`_:
> +  Block devices and `image formats<disk images>` implementation.
> +* `bsd-user <https://gitlab.com/qemu-project/qemu/-/tree/master/bsd-user>`_:
> +  `BSD User mode<bsd-user-mode>`.
> +* build: Where the code built goes!

The built code doesn't have to be in 'build'. We could say:

 * build: You can tell the QEMU build system to put the built code
   anywhere you like. By default it will go into a directory named
   ``build``. Sometimes documentation will assume this default
   for convenience when describing command lines; you can always
   replace it with the path to your build tree.

?

> +* `chardev <https://gitlab.com/qemu-project/qemu/-/tree/master/chardev>`_:
> +  Various backends used by char devices.
> +* `common-user <https://gitlab.com/qemu-project/qemu/-/tree/master/common-user>`_:
> +  User-mode assembly code for dealing with signals occuring during syscalls.
> +* `configs <https://gitlab.com/qemu-project/qemu/-/tree/master/configs>`_:
> +  Makefiles defining configurations to build QEMU.
> +* `contrib <https://gitlab.com/qemu-project/qemu/-/tree/master/contrib>`_:
> +  Community contributed devices/plugins/tools.
> +* `crypto <https://gitlab.com/qemu-project/qemu/-/tree/master/crypto>`_:
> +  Cryptographic algorithms used in QEMU.
> +* `disas <https://gitlab.com/qemu-project/qemu/-/tree/master/disas>`_:
> +  Disassembly functions used by QEMU target code.
> +* `docs <https://gitlab.com/qemu-project/qemu/-/tree/master/docs>`_:
> +  QEMU Documentation.
> +* `dump <https://gitlab.com/qemu-project/qemu/-/tree/master/dump>`_:
> +  Code to dump memory of a running VM.
> +* `ebpf <https://gitlab.com/qemu-project/qemu/-/tree/master/ebpf>`_:
> +  eBPF program support in QEMU. `virtio-net RSS<ebpf-rss>` uses it.
> +* `fpu <https://gitlab.com/qemu-project/qemu/-/tree/master/fpu>`_:
> +  Floating-point software emulation.
> +* `fsdev <https://gitlab.com/qemu-project/qemu/-/tree/master/fsdev>`_:
> +  `VirtFS <https://www.linux-kvm.org/page/VirtFS>`_ support.
> +* `gdbstub <https://gitlab.com/qemu-project/qemu/-/tree/master/gdbstub>`_:
> +  `GDB <GDB usage>` support.
> +* `gdb-xml <https://gitlab.com/qemu-project/qemu/-/tree/master/gdb-xml>`_:
> +  Set of XML files describing architectures and used by `gdbstub <GDB usage>`.
> +* `host <https://gitlab.com/qemu-project/qemu/-/tree/master/host>`_:
> +  Various architecture specific header files (crypto, atomic, memory
> +  operations).
> +* `linux-headers <https://gitlab.com/qemu-project/qemu/-/tree/master/linux-headers>`_:
> +  A subset of headers imported from Linux kernel and used for implementing
> +  KVM support and user-mode.

We could add here

 Don't change the files in here by hand; instead you can use the
 ``scripts/update-linux-headers.sh`` script to update them from a
 kernel source tree.

But maybe that's starting to be a bit much info for an entry in this list.

> +* `linux-user <https://gitlab.com/qemu-project/qemu/-/tree/master/linux-user>`_:
> +  `User mode <user-mode>` implementation. Contains one folder per target
> +  architecture.
> +* `.gitlab-ci.d <https://gitlab.com/qemu-project/qemu/-/tree/master/.gitlab-ci.d>`_:
> +  `CI <ci>` yaml and scripts.
> +* `include <https://gitlab.com/qemu-project/qemu/-/tree/master/include>`_:
> +  All headers associated to different subsystems in QEMU. Hierachy used mirrors

"The hierarchy"

> +  source code organization and naming.
> +* `hw <https://gitlab.com/qemu-project/qemu/-/tree/master/hw>`_:
> +  `Devices <device-emulation>` and boards emulation. Devices are categorized by
> +  type/protocol/architecture and located in associated subfolder.
> +* `io <https://gitlab.com/qemu-project/qemu/-/tree/master/io>`_:
> +  QEMU `I/O channels <https://lists.gnu.org/archive/html/qemu-devel/2015-11/msg04208.html>`_.
> +* `libdecnumber <https://gitlab.com/qemu-project/qemu/-/tree/master/libdecnumber>`_:
> +  Import of gcc library, used to implement decimal number arithmetic.
> +* `migration <https://gitlab.com/qemu-project/qemu/-/tree/master/migration>`__:
> +  `Migration framework <migration>`.
> +* `monitor <https://gitlab.com/qemu-project/qemu/-/tree/master/monitor>`_:
> +  `Monitor <QEMU monitor>` implementation (HMP & QMP).
> +* `nbd <https://gitlab.com/qemu-project/qemu/-/tree/master/nbd>`_:
> +  QEMU `NBD (Network Block Device) <nbd>` server.
> +* `net <https://gitlab.com/qemu-project/qemu/-/tree/master/net>`_:
> +  Network (host) support.
> +* `pc-bios <https://gitlab.com/qemu-project/qemu/-/tree/master/pc-bios>`_:
> +  Contains pre-built firmware binaries and boot images, ready to use in
> +  QEMU without compilation.
> +* `plugins <https://gitlab.com/qemu-project/qemu/-/tree/master/plugins>`_:
> +  `TCG plugins <tcg-plugins>` core implementation. Plugins can be found in
> +  `tests <https://gitlab.com/qemu-project/qemu/-/tree/master/tests/tcg/plugins>`__
> +  and `contrib <https://gitlab.com/qemu-project/qemu/-/tree/master/contrib/plugins>`__
> +  folders.
> +* `po <https://gitlab.com/qemu-project/qemu/-/tree/master/po>`_:
> +  Translation files.
> +* `python <https://gitlab.com/qemu-project/qemu/-/tree/master/python>`_:
> +  Python part of our build/test system.
> +* `qapi <https://gitlab.com/qemu-project/qemu/-/tree/master/qapi>`_:
> +  `QAPI <qapi>` implementation.
> +* `qobject <https://gitlab.com/qemu-project/qemu/-/tree/master/qobject>`_:
> +  QEMU Object implementation.
> +* `qga <https://gitlab.com/qemu-project/qemu/-/tree/master/qga>`_:
> +  QEMU `Guest agent <qemu-ga>` implementation.
> +* `qom <https://gitlab.com/qemu-project/qemu/-/tree/master/qom>`_:
> +  QEMU `Object model <qom>` implementation, with monitor associated commands.
> +* `replay <https://gitlab.com/qemu-project/qemu/-/tree/master/replay>`_:
> +  QEMU `record/replay <replay>` implementation.
> +* `roms <https://gitlab.com/qemu-project/qemu/-/tree/master/roms>`_:
> +  Contains source code for various firmware and ROMs, which can be compiled if
> +  custom or updated versions are needed.
> +* `rust <https://gitlab.com/qemu-project/qemu/-/tree/master/rust>`_:
> +  Rust integration in QEMU. It contains the new interfaces defined and
> +  associated devices using it.
> +* `scripts <https://gitlab.com/qemu-project/qemu/-/tree/master/scripts>`_:
> +  Collection of scripts used in build and test systems, and various
> +  tools for QEMU codebase and execution traces.
> +* `scsi <https://gitlab.com/qemu-project/qemu/-/tree/master/scsi>`_:
> +  Code related to SCSI support, used by SCSI devices.
> +* `semihosting <https://gitlab.com/qemu-project/qemu/-/tree/master/semihosting>`_:
> +  QEMU `Semihosting <Semihosting>` implementation.
> +* `stats <https://gitlab.com/qemu-project/qemu/-/tree/master/stats>`_:
> +  `Monitor <QEMU monitor>` stats commands implementation.
> +* `storage-daemon <https://gitlab.com/qemu-project/qemu/-/tree/master/storage-daemon>`_:
> +  QEMU `Storage daemon <storage-daemon>` implementation.
> +* `stubs <https://gitlab.com/qemu-project/qemu/-/tree/master/stubs>`_:
> +  Various stubs (empty functions) used to compile QEMU with specific
> +  configurations.
> +* `subprojects <https://gitlab.com/qemu-project/qemu/-/tree/master/subprojects>`_:
> +  QEMU submodules used by QEMU build system.
> +* `system <https://gitlab.com/qemu-project/qemu/-/tree/master/system>`_:
> +  QEMU `system mode <System emulation>` implementation (cpu, mmu, boot support).
> +* `target <https://gitlab.com/qemu-project/qemu/-/tree/master/target>`_:
> +  Contains code for all target architectures supported (one subfolder
> +  per arch). For every architecture, you can find accelerator specific
> +  implementations.
> +* `tcg <https://gitlab.com/qemu-project/qemu/-/tree/master/tcg>`_:
> +  `TCG <tcg>` related code.
> +  Contains one subfolder per host supported architecture.
> +* `tests <https://gitlab.com/qemu-project/qemu/-/tree/master/tests>`_:
> +  QEMU `test <testing>` suite
> +
> +  - `avocado <https://gitlab.com/qemu-project/qemu/-/tree/master/tests/avocado>`_:
> +    Functional tests booting full VM using `Avocado framework <checkavocado-ref>`.
> +    Those tests will be transformed and moved into
> +    `tests/functional <https://gitlab.com/qemu-project/qemu/-/tree/master/tests/functional>`_
> +    in the future.
> +  - `data <https://gitlab.com/qemu-project/qemu/-/tree/master/tests/data>`_:
> +    Data for various tests.
> +  - `decode <https://gitlab.com/qemu-project/qemu/-/tree/master/tests/decode>`_:
> +    Testsuite for `decodetree <decodetree>` implementation.
> +  - `docker <https://gitlab.com/qemu-project/qemu/-/tree/master/tests/docker>`_:
> +    Code and scripts to create `containers <container-ref>` used in `CI <ci>`.
> +  - `fp <https://gitlab.com/qemu-project/qemu/-/tree/master/tests/fp>`_:
> +    QEMU testsuite for soft float implementation.
> +  - `functional <https://gitlab.com/qemu-project/qemu/-/tree/master/tests/functional>`_:
> +    `Functional tests <checkfunctional-ref>` (full VM boot).
> +  - `lcitool <https://gitlab.com/qemu-project/qemu/-/tree/master/tests/lcitool>`_:
> +    Generate dockerfiles for CI containers.
> +  - `migration <https://gitlab.com/qemu-project/qemu/-/tree/master/tests/migration>`_:
> +    Test scripts and data for `Migration framework <migration>`.
> +  - `multiboot <https://gitlab.com/qemu-project/qemu/-/tree/master/tests/multiboot>`_:
> +    Test multiboot functionality for x86_64/i386.
> +  - `qapi-schema <https://gitlab.com/qemu-project/qemu/-/tree/master/tests/qapi-schema>`_:
> +    Test scripts and data for `QAPI <qapi-tests>`.
> +  - `qemu-iotests <https://gitlab.com/qemu-project/qemu/-/tree/master/tests/qemu-iotests>`_:
> +    `Disk image and block tests <qemu-iotests>`.
> +  - `qtest <https://gitlab.com/qemu-project/qemu/-/tree/master/tests/qtest>`_:
> +    `Device emulation testing <qtest>`.
> +  - `tcg <https://gitlab.com/qemu-project/qemu/-/tree/master/tests/tcg>`__:
> +    `TCG related tests <checktcg-ref>`. Contains code per architecture
> +    (subfolder) and multiarch tests as well.
> +  - `tsan <https://gitlab.com/qemu-project/qemu/-/tree/master/tests/tsan>`_:
> +    `Suppressions <tsan-suppressions>` for thread sanitizer.
> +  - `uefi-test-tools <https://gitlab.com/qemu-project/qemu/-/tree/master/tests/uefi-test-tools>`_:
> +    Test tool for UEFI support.
> +  - `unit <https://gitlab.com/qemu-project/qemu/-/tree/master/tests/unit>`_:
> +    QEMU `Unit tests <unit-tests>`.
> +* `trace <https://gitlab.com/qemu-project/qemu/-/tree/master/trace>`_:
> +  `Tracing framework <tracing>`. Used to print information associated to various
> +  events during execution.
> +* `ui <https://gitlab.com/qemu-project/qemu/-/tree/master/ui>`_:
> +  QEMU User interfaces.
> +* `util <https://gitlab.com/qemu-project/qemu/-/tree/master/util>`_:
> +  Utility code used by other parts of QEMU.

thanks
-- PMM

