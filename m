Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AF0DC3ABB2
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 19:32:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKMV9-00051x-Ia; Wed, 28 May 2025 15:31:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uKMUa-0004uO-Pb
 for qemu-devel@nongnu.org; Wed, 28 May 2025 15:31:20 -0400
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uKMUX-0000Km-0T
 for qemu-devel@nongnu.org; Wed, 28 May 2025 15:31:12 -0400
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-30c416cdcc0so1226561fa.2
 for <qemu-devel@nongnu.org>; Wed, 28 May 2025 12:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748460665; x=1749065465; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UpvrXpN0+NwTHtjJO5yVwQsq0C8NFRdRmA8sN90e7gg=;
 b=Vdy1q3byvA9zaEt90AqpeoCFVExoJDq1evXadGPSlptDw9iBi6YomsKnG/hUHhArAV
 WFTjiKVs8kCWmJTld+/Km7rBQ1h83khewpvpit0f2QeniFkl775BrUS4rjN8ix32zkvZ
 u5s/6wtj8rKScLfha0tOLVkKPHDj91l00owfYypQsGCQJiGup1LvvpBQMBvSabwqTY2G
 EE/AJcb/aAT4mxxZeg5h+VSRWqRAOKS+aR/e4WNKKvHqnqKPUl1TveBFKCEpmhwlLiUf
 3mDHriuZoo9+llMzeswHbHEw11aSTo1Ay42fsCZ+0vV07LStTD2J7WrxLouajrhJrvIa
 +MtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748460665; x=1749065465;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UpvrXpN0+NwTHtjJO5yVwQsq0C8NFRdRmA8sN90e7gg=;
 b=fwkIWw5/UB6ueYnNV0dwHlyG+cT2v0E8XN3Impmcy/or822yHE1wB6N018lktniMvg
 9ZWpQt+Ootf6izPU8TAraFpzEQw/ok5a/czOzYQq4Bu7CFz9uOJB1LC3gI7Zhkpu7szP
 S4lBVZEnOB/XwI8KALP0a16S5/p4wUVsMATHSyBrwl93MTB3JDqhskr68WrrY0nqgpjI
 XOPVFoCuvYCd+6MggjbtDtG2r7+N9NxddUXqikkazUacnMGcCWCLSljZWShCPje8ZXlw
 7rj9gxw1s67zQFiimeiFAkpDZvPXPRa6LZgLx3TLsra7UUfMhWm0Zgu6Fpt1bcA3/iDf
 65HQ==
X-Gm-Message-State: AOJu0Ywgnhq3JYA5MfjBUcprpze5bZRrT0R7xROprYANO2AkW844Gm7E
 SdtgF5eZ1wzG+GHy8jGJ+q5BZiy6JxYf6s0ybsFD/MB4Y1oXUGPEf3IW2yGREq+x/NgNgmehOlr
 JLqZ9BbrFkZu27wooSRhg0VznOHHZqZicXmqxUeM=
X-Gm-Gg: ASbGnctmyBiz4cWRkwMPisAdyRnS7IwxZ8bGm2pe0YUeen4nMMFgijch7vPE5SfEg8O
 z6nzeNWwURzUzcIVuiK4pOcgQcR9WZfHZw9jgvjgXCWUA8EAp/y9g+BFqvH2BYoGtJed2wRpPe4
 GB12Uu6M9gJGBAMNnzlG+5ytm5Dbdq4MYmLX74Dbi42Q==
X-Google-Smtp-Source: AGHT+IEXI9dx9B7S8oT7/DPBOBF8gUl4RuRVYpd6a53los4UVhz3uESm6ido57gdKuXVf/90Gk1IH22wAp0E65mK0oc=
X-Received: by 2002:a05:6402:2713:b0:5f8:e6e5:54ac with SMTP id
 4fb4d7f45d1cf-602d934d18fmr14139288a12.14.1748460240211; Wed, 28 May 2025
 12:24:00 -0700 (PDT)
MIME-Version: 1.0
References: <20250528100507.313906-1-thuth@redhat.com>
In-Reply-To: <20250528100507.313906-1-thuth@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 28 May 2025 15:23:46 -0400
X-Gm-Features: AX0GCFvc0cuD6iJWDtbyOyYpgqe5Zxk9xmLEaWkQyCJaGPM5W6zVirsw_weGarA
Message-ID: <CAJSP0QUpxsVEMEDT8opTZrhs6oFfFJk+jUqdR-dZL=TzQcYbWg@mail.gmail.com>
Subject: Re: [PULL 00/27] Functional tests,
 Microblaze endianness & pc/q35 cleanups
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=stefanha@gmail.com; helo=mail-lj1-x235.google.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Wed, May 28, 2025 at 6:12=E2=80=AFAM Thomas Huth <thuth@redhat.com> wrot=
e:
>
>  Hi!
>
> The following changes since commit 80db93b2b88f9b3ed8927ae7ac74ca30e643a8=
3e:
>
>   Merge tag 'pull-aspeed-20250526' of https://github.com/legoater/qemu in=
to staging (2025-05-26 10:16:59 -0400)
>
> are available in the Git repository at:
>
>   https://gitlab.com/thuth/qemu.git tags/pull-request-2025-05-28
>
> for you to fetch changes up to 9c2da02e184fddfa7cd7d7813455c2306daae99a:
>
>   tests/unit/test-util-sockets: fix mem-leak on error object (2025-05-28 =
11:59:47 +0200)
>
> ----------------------------------------------------------------
> * Functional tests improvements
> * Endianness improvements/clean-ups for the Microblaze machines
> * Remove obsolete -2.4 and -2.5 i440fx and q35 machine types and related =
code
>
> ----------------------------------------------------------------
> Alexandr Moshkov (2):
>       tests/functional: add skipLockedMemoryTest decorator
>       tests/functional: add memlock tests

Hi Thomas and Alexandr,
The memlock tests are failing:
https://gitlab.com/qemu-project/qemu/-/jobs/10181084830#L5421
https://gitlab.com/qemu-project/qemu/-/jobs/10181084865#L5476

Please take a look and send a new pull request. Thanks!

Stefan

>
> Matheus Tavares Bernardino (1):
>       tests/unit/test-util-sockets: fix mem-leak on error object
>
> Philippe Mathieu-Daud=C3=A9 (17):
>       hw/i386/pc: Remove deprecated pc-q35-2.4 and pc-i440fx-2.4 machines
>       hw/i386/pc: Remove PCMachineClass::broken_reserved_end field
>       hw/i386/pc: Remove pc_compat_2_4[] array
>       hw/core/machine: Remove hw_compat_2_4[] array
>       hw/net/e1000: Remove unused E1000_FLAG_MAC flag
>       hw/virtio/virtio-pci: Remove VIRTIO_PCI_FLAG_MIGRATE_EXTRA definiti=
on
>       hw/virtio/virtio-pci: Remove VIRTIO_PCI_FLAG_DISABLE_PCIE definitio=
n
>       hw/i386/pc: Remove deprecated pc-q35-2.5 and pc-i440fx-2.5 machines
>       hw/i386/x86: Remove X86MachineClass::save_tsc_khz field
>       hw/nvram/fw_cfg: Remove legacy FW_CFG_ORDER_OVERRIDE
>       hw/core/machine: Remove hw_compat_2_5[] array
>       hw/scsi/vmw_pvscsi: Remove PVSCSI_COMPAT_OLD_PCI_CONFIGURATION defi=
nition
>       hw/scsi/vmw_pvscsi: Remove PVSCSI_COMPAT_DISABLE_PCIE_BIT definitio=
n
>       hw/scsi/vmw_pvscsi: Convert DeviceRealize -> InstanceInit
>       hw/net/vmxnet3: Remove VMXNET3_COMPAT_FLAG_OLD_MSI_OFFSETS definiti=
on
>       hw/net/vmxnet3: Remove VMXNET3_COMPAT_FLAG_DISABLE_PCIE definition
>       hw/net/vmxnet3: Merge DeviceRealize in InstanceInit
>
> Thomas Huth (7):
>       tests/functional/test_sparc64_tuxrun: Explicitly set the 'sun4u' ma=
chine
>       tests/functional/test_mips_malta: Re-enable the check for the PCI h=
ost bridge
>       tests/functional/test_mem_addr_space: Use set_machine() to select t=
he machine
>       hw/microblaze: Add endianness property to the petalogix_s3adsp1800 =
machine
>       tests/functional: Test both microblaze s3adsp1800 endianness varian=
ts
>       hw/microblaze: Remove the big-endian variants of ml605 and xlnx-zyn=
qmp-pmu
>       docs: Deprecate the qemu-system-microblazeel binary
>
>  docs/about/deprecated.rst                        |  19 ++--
>  docs/about/removed-features.rst                  |   9 ++
>  include/hw/boards.h                              |   9 +-
>  include/hw/i386/pc.h                             |   7 --
>  include/hw/i386/x86.h                            |   5 --
>  include/hw/loader.h                              |   2 -
>  include/hw/nvram/fw_cfg.h                        |  10 ---
>  include/hw/virtio/virtio-pci.h                   |   8 --
>  hw/core/loader.c                                 |  14 ---
>  hw/core/machine.c                                |  18 ----
>  hw/i386/pc.c                                     |  42 ++-------
>  hw/i386/pc_piix.c                                |  26 ------
>  hw/i386/pc_q35.c                                 |  26 ------
>  hw/i386/x86.c                                    |   1 -
>  hw/microblaze/petalogix_ml605_mmu.c              |  15 +---
>  hw/microblaze/petalogix_s3adsp1800_mmu.c         |  41 +++++++--
>  hw/microblaze/xlnx-zynqmp-pmu.c                  |   7 +-
>  hw/net/e1000.c                                   |  95 +++++++++--------=
---
>  hw/net/vmxnet3.c                                 |  44 ++-------
>  hw/nvram/fw_cfg.c                                | 110 ++---------------=
------
>  hw/scsi/vmw_pvscsi.c                             |  67 +++-----------
>  hw/virtio/virtio-pci.c                           |  11 +--
>  system/vl.c                                      |   5 --
>  target/i386/machine.c                            |   5 +-
>  tests/qtest/test-x86-cpuid-compat.c              |  14 ---
>  tests/unit/test-util-sockets.c                   |   4 +
>  tests/functional/meson.build                     |   1 +
>  tests/functional/qemu_test/__init__.py           |   2 +-
>  tests/functional/qemu_test/decorators.py         |  18 ++++
>  tests/functional/test_mem_addr_space.py          |  63 ++++++-------
>  tests/functional/test_memlock.py                 |  79 ++++++++++++++++
>  tests/functional/test_microblaze_s3adsp1800.py   |  18 ++--
>  tests/functional/test_microblazeel_s3adsp1800.py |   6 +-
>  tests/functional/test_mips_malta.py              |   6 +-
>  tests/functional/test_sparc64_tuxrun.py          |   1 +
>  35 files changed, 296 insertions(+), 512 deletions(-)
>  create mode 100755 tests/functional/test_memlock.py
>
>

