Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F81FD6ACF1
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 12:46:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWDO2-0006cH-Kf; Thu, 18 Dec 2025 07:45:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vWDNy-0006bl-H6
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 07:45:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vWDNu-0004Ye-K6
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 07:45:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766061930;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type;
 bh=BpHWr68Py/stOPrBW9EYz0zfxUhZB7mg03z3ogaRdrw=;
 b=az5HHcO2LTbVd7V8+yAVutYRtraIKHWOFKBJWOAijN8KqAzLFly23arF2/gy2SwXIhkKsK
 7rSVn1YWosTx9Qb5cYxhYAJgtTOgoktb0qXvKTKeaCN7HiVyh6Bsd53veWfPX7X7FLUJHW
 kTaO0RB0kJvPHczJ6zKLIY9nSIy0wFA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-458-cvYrUkO2PRy2bInSwUiKeQ-1; Thu,
 18 Dec 2025 07:45:28 -0500
X-MC-Unique: cvYrUkO2PRy2bInSwUiKeQ-1
X-Mimecast-MFC-AGG-ID: cvYrUkO2PRy2bInSwUiKeQ_1766061927
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B2CF618005AE
 for <qemu-devel@nongnu.org>; Thu, 18 Dec 2025 12:45:27 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.7])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 323FB1956056
 for <qemu-devel@nongnu.org>; Thu, 18 Dec 2025 12:45:27 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9A98C21E6A27; Thu, 18 Dec 2025 13:45:24 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: Report on MAINTAINERS coverage
Date: Thu, 18 Dec 2025 13:45:24 +0100
Message-ID: <87h5toc61n.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Back in 2014 (time flies), I posted

    Subject: MAINTAINERS leaves too many files uncovered
    Message-ID: <87mw8rumhb.fsf@blackfin.pond.sub.org>
    https://lore.kernel.org/qemu-devel/87mw8rumhb.fsf@blackfin.pond.sub.org/

I updated my findings in 2015, 2016 (at commit e00da552a0d), 2018 (at
v3.1.0-rc2), and 2023 (at commit 36e9aab3c56, close to v8.2.0).  This is
another update, at v10.2.0-rc4.

Unsurprisingly, the number of files in the tree

    $ git-ls-files | wc -l

grows over time:

    year  2014   2015   2016   2018   2023   2025
    #     3746   4387   4921   6461   9788  10921

Looks exponential to me, doubling every seven years or so.

The number of .c files has grown more slowly:

    year  2014   2015   2016   2018   2023   2025
    #     1836   1945   2132   2633   3588   3920
            49%    44%    43%    40%    37%    36%

The number of .c files not covered by MAINTAINERS

    $ for i in `git-ls-files`; do [ "`scripts/get_maintainer.pl -f --no-git-fallback $i | grep -v '^qemu-devel@nongnu\.org'`" ] || echo $i; done >unmaintained-files
    $ grep -c '\.c$' unmaintained-files

went down a lot after my first post, but has since flatlined:

    year  2014   2015   2016   2018   2023   2025
    #     1066    461    402    259    246    244

We're still adding unmaintained .c files (despite checkpatch.pl
warning), but only a few:

    $ git-diff --diff-filter=A --name-only v9.2.0 v10.2.0-rc4 | grep '\.c$' | join unmaintained-files -
    accel/stubs/mshv-stub.c
    hw/misc/max78000_aes.c
    hw/misc/max78000_gcr.c
    hw/misc/max78000_icc.c
    hw/misc/max78000_trng.c
    hw/misc/pvpanic-mmio.c
    hw/virtio/iothread-vq-mapping.c
    system/exit-with-parent.c
    system/globals-target.c
    util/event.c
    util/s390x_pci_mmio.c


Currently unmaintained files by extension, with a long tail that doesn't
add up to anything interesting omitted:

                #files                percent
    ext     unmaintained  total     unmaintained
    h               269    2731         10%
    c               244    3920          6%
    rst             111     313         35%
    <none>           92     760         12%
    build            87     287         30%
    mak              39      99         39%
    inc              29     187         16%
    wrap             23      23        100%
    bin              19      30         63%
    cocci            14      25         64%
    rom              14      15         93%
    txt              11      35         40%

Observations:

1. More unmaintained .h than .c.  Suggests sloppy accounting in
   MAINTAINERS.  Low-hanging fruit?  The difference has shrunk some.

2. The number of unmaintained .rst and .txt suggests we're less
   interested in maintaining documentation.

3. The number of unmaintained .build and .mak suggests we're less
   interested in maintaining the build system.


Where are the remaining unmaintained files now?  Top-scoring
directories, files in sub-directories not counted:

    $ sed 's,/[^/]*$,/,;s,^[^/]*$,./,' unmaintained-files | sort | uniq -c | sort -nr

      # directory
     86 include/qemu/
     57 hw/usb/
     54 util/
     48 tests/unit/
     42 pc-bios/
     35 pc-bios/keymaps/
     34 docs/system/
     28 docs/devel/
     26 ./
     24 subprojects/
     24 include/exec/
     23 roms/
     21 scripts/
     21 configs/targets/
     17 hw/display/
     17 hw/core/
     16 scripts/coccinelle/
     16 include/system/
     16 hw/misc/
     14 tests/multiboot/
     13 include/hw/
     13 docs/
     12 system/
     12 po/
     11 pc-bios/optionrom/

hw/usb/ is due to USB being orphaned in MAINTAINERS.  The remainder are
all pretty much unchanged since last time, less a few that improved
enough to fall off this list.


Which unmaintained files are we still changing?  Unmaintained files
sorted by number of commits in the past year (since v9.2.0):

    $ for i in `cat unmaintained-files`; do echo -n "$i "; git-rev-list v9.2.0.. $i | wc -l; done | awk '{ printf "%7d %s\n", $2, $1 }' | sort -rn

    274 MAINTAINERS
    107 tests/functional/meson.build
     34 docs/devel/rust.rst
     32 qemu-options.hx
     27 docs/about/removed-features.rst
     20 scripts/checkpatch.pl
     19 hw/core/loader.c
     19 VERSION
     15 docs/system/arm/emulation.rst
     12 include/system/mshv_int.h
     11 hw/usb/hcd-uhci.c
     10 tests/unit/test-bdrv-drain.c
     10 include/qemu/osdep.h
     10 include/exec/poison.h
     10 hw/misc/trace-events
     10 hw/misc/meson.build
     10 docs/about/build-platforms.rst
    [475 more with fewer than 10 changes]

Several of these we clearly need to cover in MAINTAINERS.


Full list of unmaintained files:

.b4-config
.dir-locals.el
.editorconfig
.exrc
.gdbinit
.git-blame-ignore-revs
.gitattributes
.gitignore
.gitlab/issue_templates/bug.md
.gitlab/issue_templates/feature_request.md
.gitmodules
.gitpublish
.mailmap
.patchew.yml
.readthedocs.yml
COPYING
COPYING.LIB
LICENSE
MAINTAINERS
README.rst
VERSION
accel/meson.build
accel/stubs/meson.build
accel/stubs/mshv-stub.c
accel/stubs/xen-stub.c
audio/spiceaudio.c
backends/confidential-guest-support.c
backends/dbus-vmstate1.xml
backends/meson.build
backends/trace-events
backends/trace.h
clippy.toml
configs/devices/aarch64-softmmu/default.mak
configs/devices/aarch64-softmmu/minimal.mak
configs/devices/alpha-softmmu/default.mak
configs/devices/arm-softmmu/default.mak
configs/devices/m68k-softmmu/default.mak
configs/devices/microblaze-softmmu/default.mak
configs/devices/microblazeel-softmmu/default.mak
configs/devices/or1k-softmmu/default.mak
configs/devices/ppc-softmmu/default.mak
configs/devices/ppc64-softmmu/default.mak
configs/devices/riscv32-softmmu/default.mak
configs/devices/riscv64-softmmu/default.mak
configs/devices/rx-softmmu/default.mak
configs/devices/sh4-softmmu/default.mak
configs/devices/sh4eb-softmmu/default.mak
configs/devices/sparc-softmmu/default.mak
configs/devices/sparc64-softmmu/default.mak
configs/devices/tricore-softmmu/default.mak
configs/devices/x86_64-softmmu/default.mak
configs/meson/windows.txt
configs/targets/aarch64-softmmu.mak
configs/targets/alpha-softmmu.mak
configs/targets/arm-softmmu.mak
configs/targets/avr-softmmu.mak
configs/targets/hppa-softmmu.mak
configs/targets/m68k-softmmu.mak
configs/targets/meson.build
configs/targets/microblaze-softmmu.mak
configs/targets/microblazeel-softmmu.mak
configs/targets/or1k-softmmu.mak
configs/targets/ppc-softmmu.mak
configs/targets/ppc64-softmmu.mak
configs/targets/rx-softmmu.mak
configs/targets/s390x-softmmu.mak
configs/targets/sh4-softmmu.mak
configs/targets/sh4eb-softmmu.mak
configs/targets/sparc-softmmu.mak
configs/targets/sparc64-softmmu.mak
configs/targets/tricore-softmmu.mak
configs/targets/xtensa-softmmu.mak
configs/targets/xtensaeb-softmmu.mak
contrib/ivshmem-client/ivshmem-client.c
contrib/ivshmem-client/ivshmem-client.h
contrib/ivshmem-client/main.c
contrib/ivshmem-client/meson.build
contrib/ivshmem-server/ivshmem-server.c
contrib/ivshmem-server/ivshmem-server.h
contrib/ivshmem-server/main.c
contrib/ivshmem-server/meson.build
contrib/systemd/qemu-pr-helper.service
contrib/systemd/qemu-pr-helper.socket
contrib/systemd/qemu-vmsr-helper.service
contrib/systemd/qemu-vmsr-helper.socket
contrib/vmapple/uuid.sh
disas/capstone.c
disas/disas-common.c
disas/disas-host.c
disas/disas-internal.h
disas/disas-mon.c
disas/disas-target.c
disas/meson.build
disas/objdump.c
docs/about/build-platforms.rst
docs/about/emulation.rst
docs/about/index.rst
docs/about/license.rst
docs/about/removed-features.rst
docs/bypass-iommu.txt
docs/config/ich9-ehci-uhci.cfg
docs/config/mach-virt-graphical.cfg
docs/config/mach-virt-serial.cfg
docs/config/q35-emulated.cfg
docs/config/q35-virtio-graphical.cfg
docs/config/q35-virtio-serial.cfg
docs/defs.rst.inc
docs/devel/atomics.rst
docs/devel/bitops.rst
docs/devel/block-coroutine-wrapper.rst
docs/devel/code-provenance.rst
docs/devel/control-flow-integrity.rst
docs/devel/crypto.rst
docs/devel/index-api.rst
docs/devel/index-build.rst
docs/devel/index-internals.rst
docs/devel/index-process.rst
docs/devel/index-tcg.rst
docs/devel/index.rst
docs/devel/loads-stores.rst
docs/devel/maintainers.rst
docs/devel/memory.rst
docs/devel/modules.rst
docs/devel/multi-thread-tcg.rst
docs/devel/multiple-iothreads.rst
docs/devel/pci.rst
docs/devel/qdev-api.rst
docs/devel/qom-api.rst
docs/devel/reset.rst
docs/devel/rust.rst
docs/devel/secure-coding-practices.rst
docs/devel/stable-process.rst
docs/devel/testing/index.rst
docs/devel/uefi-vars.rst
docs/devel/writing-monitor-commands.rst
docs/devel/zoned-storage.rst
docs/image-fuzzer.txt
docs/index.rst
docs/interop/barrier.rst
docs/interop/index.rst
docs/interop/live-block-operations.rst
docs/interop/pr-helper.rst
docs/interop/vhost-vdpa.rst
docs/interop/vnc-ledstate-pseudo-encoding.rst
docs/memory-hotplug.txt
docs/meson.build
docs/multi-thread-compression.txt
docs/multiseat.txt
docs/qcow2-cache.txt
docs/qemupciserial.inf
docs/rdma.txt
docs/specs/acpi_erst.rst
docs/specs/aspeed-intc.rst
docs/specs/index.rst
docs/specs/ivshmem-spec.rst
docs/specs/pvpanic.rst
docs/specs/rapl-msr.rst
docs/specs/riscv-aia.rst
docs/specs/sev-guest-firmware.rst
docs/specs/spdm.rst
docs/sphinx-static/custom.js
docs/sphinx-static/theme_overrides.css
docs/spice-port-fqdn.txt
docs/spin/aio_notify.promela
docs/spin/aio_notify_accept.promela
docs/spin/aio_notify_bug.promela
docs/spin/tcg-exclusive.promela
docs/spin/win32-qemu-event.promela
docs/system/arm/b-l475e-iot01a.rst
docs/system/arm/emulation.rst
docs/system/arm/max78000.rst
docs/system/authz.rst
docs/system/barrier.rst
docs/system/bootindex.rst
docs/system/confidential-guest-support.rst
docs/system/cpu-hotplug.rst
docs/system/device-emulation.rst
docs/system/device-url-syntax.rst.inc
docs/system/devices/ccid.rst
docs/system/devices/cxl.rst
docs/system/devices/emmc.rst
docs/system/devices/ivshmem.rst
docs/system/devices/keyboard.rst
docs/system/devices/net.rst
docs/system/devices/usb-u2f.rst
docs/system/devices/usb.rst
docs/system/devices/virtio/index.rst
docs/system/devices/virtio/vhost-user-contrib.rst
docs/system/devices/virtio/vhost-user.rst
docs/system/devices/virtio/virtio-gpu.rst
docs/system/devices/virtio/virtio-pmem.rst
docs/system/devices/virtio/virtio-snd.rst
docs/system/i386/hyperv.rst
docs/system/i386/kvm-pv.rst
docs/system/i386/pc.rst
docs/system/i386/tdx.rst
docs/system/i386/xen.rst
docs/system/images.rst
docs/system/index.rst
docs/system/introduction.rst
docs/system/invocation.rst
docs/system/keys.rst
docs/system/keys.rst.inc
docs/system/linuxboot.rst
docs/system/managed-startup.rst
docs/system/monitor.rst
docs/system/mux-chardev.rst
docs/system/mux-chardev.rst.inc
docs/system/openrisc/emulation.rst
docs/system/openrisc/virt.rst
docs/system/pr-manager.rst
docs/system/qemu-block-drivers.rst
docs/system/qemu-block-drivers.rst.inc
docs/system/qemu-cpu-models.rst
docs/system/qemu-manpage.rst
docs/system/riscv/virt.rst
docs/system/secrets.rst
docs/system/security.rst
docs/system/target-loongarch.rst
docs/system/target-m68k.rst
docs/system/target-openrisc.rst
docs/system/target-sparc.rst
docs/system/target-sparc64.rst
docs/system/target-xtensa.rst
docs/system/targets.rst
docs/system/tls.rst
docs/system/vnc-security.rst
docs/tools/index.rst
docs/tools/qemu-pr-helper.rst
docs/tools/qemu-vmsr-helper.rst
docs/user/index.rst
docs/user/main.rst
docs/xbzrle.txt
event-loop-base.c
host/include/aarch64/host/atomic128-cas.h.inc
host/include/aarch64/host/atomic128-ldst.h.inc
host/include/aarch64/host/bufferiszero.c.inc
host/include/aarch64/host/load-extract-al16-al8.h.inc
host/include/aarch64/host/store-insert-al16.h.inc
host/include/generic/host/atomic128-cas.h.inc
host/include/generic/host/atomic128-ldst.h.inc
host/include/generic/host/bufferiszero.c.inc
host/include/generic/host/load-extract-al16-al8.h.inc
host/include/generic/host/store-insert-al16.h.inc
host/include/i386/host/bufferiszero.c.inc
host/include/loongarch64/host/atomic128-ldst.h.inc
host/include/loongarch64/host/bufferiszero.c.inc
host/include/loongarch64/host/load-extract-al16-al8.h.inc
host/include/loongarch64/host/store-insert-al16.h.inc
host/include/x86_64/host/atomic128-ldst.h.inc
host/include/x86_64/host/bufferiszero.c.inc
host/include/x86_64/host/load-extract-al16-al8.h.inc
hw/core/fw-path-provider.c
hw/core/gpio.c
hw/core/guest-loader.h
hw/core/hotplug.c
hw/core/irq.c
hw/core/loader.c
hw/core/machine-hmp-cmds.c
hw/core/meson.build
hw/core/nmi.c
hw/core/or-irq.c
hw/core/platform-bus.c
hw/core/ptimer.c
hw/core/split-irq.c
hw/core/sysbus-fdt.c
hw/core/trace-events
hw/core/trace.h
hw/core/vm-change-state-handler.c
hw/cpu/core.c
hw/cpu/meson.build
hw/display/acpi-vga-stub.c
hw/display/acpi-vga.c
hw/display/ati.c
hw/display/ati_2d.c
hw/display/ati_dbg.c
hw/display/ati_int.h
hw/display/ati_regs.h
hw/display/framebuffer.c
hw/display/framebuffer.h
hw/display/i2c-ddc.c
hw/display/meson.build
hw/display/qxl-logger.c
hw/display/qxl-render.c
hw/display/qxl.c
hw/display/qxl.h
hw/display/trace-events
hw/display/trace.h
hw/dma/meson.build
hw/dma/soc_dma.c
hw/dma/trace-events
hw/dma/trace.h
hw/gpio/gpio_key.c
hw/gpio/gpio_pwr.c
hw/gpio/meson.build
hw/gpio/pcf8574.c
hw/gpio/trace-events
hw/gpio/trace.h
hw/hyperv/hyperv.c
hw/hyperv/hyperv_testdev.c
hw/hyperv/meson.build
hw/hyperv/syndbg.c
hw/hyperv/trace-events
hw/hyperv/trace.h
hw/i2c/bitbang_i2c.c
hw/i2c/meson.build
hw/i2c/trace-events
hw/i2c/trace.h
hw/input/hid.c
hw/input/meson.build
hw/input/ps2.c
hw/input/trace-events
hw/input/trace.h
hw/intc/intc.c
hw/intc/meson.build
hw/intc/trace-events
hw/intc/trace.h
hw/intc/vgic_common.h
hw/isa/isa-bus.c
hw/isa/meson.build
hw/isa/trace-events
hw/isa/trace.h
hw/m68k/meson.build
hw/mem/cxl_type3_stubs.c
hw/mem/meson.build
hw/mem/trace-events
hw/mem/trace.h
hw/meson.build
hw/misc/applesmc.c
hw/misc/auxbus.c
hw/misc/axp2xx.c
hw/misc/i2c-echo.c
hw/misc/ivshmem-pci.c
hw/misc/max78000_aes.c
hw/misc/max78000_gcr.c
hw/misc/max78000_icc.c
hw/misc/max78000_trng.c
hw/misc/meson.build
hw/misc/pvpanic-isa.c
hw/misc/pvpanic-mmio.c
hw/misc/pvpanic-pci.c
hw/misc/pvpanic.c
hw/misc/trace-events
hw/misc/trace.h
hw/nvram/eeprom93xx.c
hw/nvram/eeprom_at24c.c
hw/nvram/meson.build
hw/nvram/trace-events
hw/nvram/trace.h
hw/pci-host/gpex-acpi.c
hw/pci-host/gpex.c
hw/pci-host/meson.build
hw/pci-host/trace-events
hw/pci-host/trace.h
hw/remote/meson.build
hw/remote/trace-events
hw/remote/trace.h
hw/remote/vfio-user-obj-stub.c
hw/rtc/ds1338.c
hw/rtc/m48t59-internal.h
hw/rtc/m48t59.c
hw/rtc/meson.build
hw/rtc/trace-events
hw/rtc/trace.h
hw/sd/meson.build
hw/sd/trace-events
hw/sd/trace.h
hw/timer/meson.build
hw/timer/pxa2xx_timer.c
hw/timer/trace-events
hw/timer/trace.h
hw/usb/bus-stub.c
hw/usb/bus.c
hw/usb/ccid-card-emulated.c
hw/usb/ccid-card-passthru.c
hw/usb/ccid.h
hw/usb/chipidea.c
hw/usb/combined-packet.c
hw/usb/core.c
hw/usb/desc-msos.c
hw/usb/desc.c
hw/usb/desc.h
hw/usb/dev-audio.c
hw/usb/dev-hid.c
hw/usb/dev-hub.c
hw/usb/dev-mtp.c
hw/usb/dev-network.c
hw/usb/dev-smartcard-reader.c
hw/usb/dev-storage-bot.c
hw/usb/dev-storage-classic.c
hw/usb/dev-storage.c
hw/usb/dev-uas.c
hw/usb/dev-wacom.c
hw/usb/hcd-dwc2.c
hw/usb/hcd-dwc2.h
hw/usb/hcd-dwc3.c
hw/usb/hcd-ehci-pci.c
hw/usb/hcd-ehci-sysbus.c
hw/usb/hcd-ehci.c
hw/usb/hcd-ehci.h
hw/usb/hcd-ohci-pci.c
hw/usb/hcd-ohci-sysbus.c
hw/usb/hcd-ohci.c
hw/usb/hcd-ohci.h
hw/usb/hcd-uhci.c
hw/usb/hcd-uhci.h
hw/usb/hcd-xhci-nec.c
hw/usb/hcd-xhci-pci.c
hw/usb/hcd-xhci-pci.h
hw/usb/hcd-xhci-sysbus.c
hw/usb/hcd-xhci-sysbus.h
hw/usb/hcd-xhci.c
hw/usb/hcd-xhci.h
hw/usb/host-libusb.c
hw/usb/libhw.c
hw/usb/meson.build
hw/usb/pcap.c
hw/usb/quirks-ftdi-ids.h
hw/usb/quirks-pl2303-ids.h
hw/usb/quirks.c
hw/usb/quirks.h
hw/usb/redirect.c
hw/usb/trace-events
hw/usb/trace.h
hw/usb/u2f-emulated.c
hw/usb/u2f-passthru.c
hw/usb/u2f.c
hw/usb/u2f.h
hw/virtio/iothread-vq-mapping.c
hw/virtio/meson.build
hw/virtio/trace.h
hw/virtio/vdpa-dev-pci.c
hw/virtio/vdpa-dev.c
hw/watchdog/meson.build
hw/watchdog/trace-events
hw/watchdog/trace.h
hw/watchdog/watchdog.c
include/disas/capstone.h
include/disas/dis-asm.h
include/disas/disas.h
include/elf.h
include/exec/abi_ptr.h
include/exec/breakpoint.h
include/exec/hwaddr.h
include/exec/icount.h
include/exec/log.h
include/exec/memattrs.h
include/exec/memopidx.h
include/exec/memory_ldst.h.inc
include/exec/memory_ldst_cached.h.inc
include/exec/memory_ldst_phys.h.inc
include/exec/mmap-lock.h
include/exec/mmu-access-type.h
include/exec/page-vary.h
include/exec/plugin-gen.h
include/exec/poison.h
include/exec/ramlist.h
include/exec/target_page.h
include/exec/tlb-common.h
include/exec/tlb-flags.h
include/exec/translation-block.h
include/exec/translator.h
include/exec/tswap.h
include/exec/vaddr.h
include/exec/watchpoint.h
include/glib-compat.h
include/hw/arm/boot.h
include/hw/arm/bsa.h
include/hw/arm/fdt.h
include/hw/arm/linux-boot-if.h
include/hw/arm/machines-qom.h
include/hw/arm/max78000_soc.h
include/hw/arm/soc_dma.h
include/hw/block/block.h
include/hw/core/split-irq.h
include/hw/core/sysbus-fdt.h
include/hw/core/sysemu-cpu-ops.h
include/hw/cpu/core.h
include/hw/display/dm163.h
include/hw/display/i2c-ddc.h
include/hw/elf_ops.h.inc
include/hw/fw-path-provider.h
include/hw/gpio/pcf8574.h
include/hw/hotplug.h
include/hw/hw.h
include/hw/hyperv/hyperv-proto.h
include/hw/hyperv/hyperv.h
include/hw/i2c/bitbang_i2c.h
include/hw/i2c/pnv_i2c_regs.h
include/hw/input/hid.h
include/hw/input/ps2.h
include/hw/intc/intc.h
include/hw/intc/kvm_irqcount.h
include/hw/intc/riscv_aclint.h
include/hw/intc/riscv_aplic.h
include/hw/intc/riscv_imsic.h
include/hw/ipack/ipack.h
include/hw/irq.h
include/hw/isa/isa.h
include/hw/loader-fit.h
include/hw/loader.h
include/hw/loongarch/boot.h
include/hw/mem/sparse-mem.h
include/hw/misc/auxbus.h
include/hw/misc/ivshmem.h
include/hw/misc/max78000_aes.h
include/hw/misc/max78000_gcr.h
include/hw/misc/max78000_icc.h
include/hw/misc/max78000_trng.h
include/hw/misc/pvpanic.h
include/hw/nmi.h
include/hw/nvram/eeprom93xx.h
include/hw/nvram/eeprom_at24c.h
include/hw/nvram/fw_cfg_acpi.h
include/hw/or-irq.h
include/hw/pci-bridge/cxl_upstream_port.h
include/hw/pci-bridge/pci_expander_bridge.h
include/hw/pci-bridge/xio3130_downstream.h
include/hw/pci-host/gpex.h
include/hw/pci-host/ls7a.h
include/hw/platform-bus.h
include/hw/ptimer.h
include/hw/sd/cadence_sdhci.h
include/hw/sysbus.h
include/hw/timer/cadence_ttc.h
include/hw/usb.h
include/hw/usb/chipidea.h
include/hw/usb/dwc2-regs.h
include/hw/usb/ehci-regs.h
include/hw/usb/hcd-dwc3.h
include/hw/usb/hid.h
include/hw/usb/msd.h
include/hw/usb/uhci-regs.h
include/hw/usb/xhci.h
include/libdecnumber/dconfig.h
include/libdecnumber/decContext.h
include/libdecnumber/decDPD.h
include/libdecnumber/decNumber.h
include/libdecnumber/decNumberLocal.h
include/libdecnumber/dpd/decimal128.h
include/libdecnumber/dpd/decimal128Local.h
include/libdecnumber/dpd/decimal32.h
include/libdecnumber/dpd/decimal64.h
include/monitor/hmp.h
include/monitor/monitor.h
include/monitor/qmp-helpers.h
include/qemu-io.h
include/qemu-main.h
include/qemu/async-teardown.h
include/qemu/atomic.h
include/qemu/atomic128.h
include/qemu/base64.h
include/qemu/bcd.h
include/qemu/bitmap.h
include/qemu/bitops.h
include/qemu/bswap.h
include/qemu/cacheflush.h
include/qemu/cacheinfo.h
include/qemu/compiler.h
include/qemu/config-file.h
include/qemu/cpu-float.h
include/qemu/cpuid.h
include/qemu/crc-ccitt.h
include/qemu/crc32c.h
include/qemu/ctype.h
include/qemu/cutils.h
include/qemu/datadir.h
include/qemu/drm.h
include/qemu/envlist.h
include/qemu/event_notifier.h
include/qemu/exit-with-parent.h
include/qemu/fifo32.h
include/qemu/fifo8.h
include/qemu/futex.h
include/qemu/guest-random.h
include/qemu/help-texts.h
include/qemu/help_option.h
include/qemu/host-pci-mmio.h
include/qemu/host-utils.h
include/qemu/hw-version.h
include/qemu/id.h
include/qemu/int128.h
include/qemu/interval-tree.h
include/qemu/iov.h
include/qemu/jhash.h
include/qemu/keyval.h
include/qemu/lockable.h
include/qemu/log-for-trace.h
include/qemu/log.h
include/qemu/madvise.h
include/qemu/memalign.h
include/qemu/memfd.h
include/qemu/mmap-alloc.h
include/qemu/module.h
include/qemu/mprotect.h
include/qemu/notify.h
include/qemu/nvdimm-utils.h
include/qemu/option_int.h
include/qemu/osdep.h
include/qemu/path.h
include/qemu/plugin-event.h
include/qemu/plugin-memory.h
include/qemu/plugin.h
include/qemu/pmem.h
include/qemu/processor.h
include/qemu/progress_meter.h
include/qemu/qdist.h
include/qemu/qemu-plugin.h
include/qemu/qemu-progress.h
include/qemu/qht.h
include/qemu/qsp.h
include/qemu/qtree.h
include/qemu/queue.h
include/qemu/range.h
include/qemu/ratelimit.h
include/qemu/readline.h
include/qemu/reserved-region.h
include/qemu/s390x_pci_mmio.h
include/qemu/selfmap.h
include/qemu/seqlock.h
include/qemu/stats64.h
include/qemu/sys_membarrier.h
include/qemu/systemd.h
include/qemu/thread-context.h
include/qemu/thread.h
include/qemu/timed-average.h
include/qemu/timer.h
include/qemu/tsan.h
include/qemu/typedefs.h
include/qemu/unicode.h
include/qemu/units.h
include/qemu/vfio-helpers.h
include/qemu/xattr.h
include/qemu/xxhash.h
include/system/address-spaces.h
include/system/arch_init.h
include/system/blockdev.h
include/system/confidential-guest-support.h
include/system/cpu-throttle.h
include/system/cpu-timers-internal.h
include/system/cpu-timers.h
include/system/dma.h
include/system/event-loop-base.h
include/system/hw_accel.h
include/system/iothread.h
include/system/mshv_int.h
include/system/rtc.h
include/system/stats.h
include/system/system.h
include/system/watchdog.h
iothread.c
libdecnumber/decContext.c
libdecnumber/decNumber.c
libdecnumber/dpd/decimal128.c
libdecnumber/dpd/decimal32.c
libdecnumber/dpd/decimal64.c
libdecnumber/meson.build
module-common.c
monitor/fds.c
monitor/meson.build
monitor/qemu-config-qmp.c
monitor/trace-events
monitor/trace.h
pc-bios/QEMU,cgthree.bin
pc-bios/QEMU,tcx.bin
pc-bios/README
pc-bios/bios-256k.bin
pc-bios/bios.bin
pc-bios/descriptors/meson.build
pc-bios/dtb/bamboo.dtb
pc-bios/dtb/bamboo.dts
pc-bios/dtb/meson.build
pc-bios/dtb/petalogix-ml605.dtb
pc-bios/dtb/petalogix-ml605.dts
pc-bios/dtb/petalogix-s3adsp1800.dtb
pc-bios/dtb/petalogix-s3adsp1800.dts
pc-bios/efi-e1000.rom
pc-bios/efi-e1000e.rom
pc-bios/efi-eepro100.rom
pc-bios/efi-ne2k_pci.rom
pc-bios/efi-pcnet.rom
pc-bios/efi-rtl8139.rom
pc-bios/efi-virtio.rom
pc-bios/hppa-firmware64.img
pc-bios/keymaps/ar
pc-bios/keymaps/bepo
pc-bios/keymaps/cz
pc-bios/keymaps/da
pc-bios/keymaps/de
pc-bios/keymaps/de-ch
pc-bios/keymaps/en-gb
pc-bios/keymaps/en-us
pc-bios/keymaps/es
pc-bios/keymaps/et
pc-bios/keymaps/fi
pc-bios/keymaps/fo
pc-bios/keymaps/fr
pc-bios/keymaps/fr-be
pc-bios/keymaps/fr-ca
pc-bios/keymaps/fr-ch
pc-bios/keymaps/hr
pc-bios/keymaps/hu
pc-bios/keymaps/is
pc-bios/keymaps/it
pc-bios/keymaps/ja
pc-bios/keymaps/lt
pc-bios/keymaps/lv
pc-bios/keymaps/meson.build
pc-bios/keymaps/mk
pc-bios/keymaps/nl
pc-bios/keymaps/no
pc-bios/keymaps/pl
pc-bios/keymaps/pt
pc-bios/keymaps/pt-br
pc-bios/keymaps/ru
pc-bios/keymaps/sl
pc-bios/keymaps/sv
pc-bios/keymaps/th
pc-bios/keymaps/tr
pc-bios/kvmvapic.bin
pc-bios/linuxboot.bin
pc-bios/linuxboot_dma.bin
pc-bios/meson.build
pc-bios/multiboot.bin
pc-bios/multiboot_dma.bin
pc-bios/openbios-ppc
pc-bios/optionrom/Makefile
pc-bios/optionrom/flat.lds
pc-bios/optionrom/linuxboot.S
pc-bios/optionrom/linuxboot_dma.c
pc-bios/optionrom/multiboot.S
pc-bios/optionrom/multiboot_dma.S
pc-bios/optionrom/optionrom.h
pc-bios/optionrom/optrom.h
pc-bios/optionrom/optrom_fw_cfg.h
pc-bios/optionrom/pvh.S
pc-bios/optionrom/pvh_main.c
pc-bios/palcode-clipper
pc-bios/pvh.bin
pc-bios/pxe-e1000.rom
pc-bios/pxe-eepro100.rom
pc-bios/pxe-ne2k_pci.rom
pc-bios/pxe-pcnet.rom
pc-bios/pxe-rtl8139.rom
pc-bios/pxe-virtio.rom
pc-bios/qboot.rom
pc-bios/qemu-nsis.bmp
pc-bios/qemu-nsis.ico
pc-bios/qemu.rsrc
pc-bios/qemu_logo.svg
pc-bios/u-boot-sam460.bin
pc-bios/vgabios-ati.bin
pc-bios/vgabios-bochs-display.bin
pc-bios/vgabios-cirrus.bin
pc-bios/vgabios-qxl.bin
pc-bios/vgabios-ramfb.bin
pc-bios/vgabios-stdvga.bin
pc-bios/vgabios-virtio.bin
pc-bios/vgabios.bin
po/LINGUAS
po/POTFILES
po/bg.po
po/de_DE.po
po/fr_FR.po
po/hu.po
po/it.po
po/meson.build
po/sv.po
po/tr.po
po/uk.po
po/zh_CN.po
qemu-keymap.c
qemu-options.hx
roms/Makefile
roms/QemuMacDrivers
roms/SLOF
roms/config.seabios-128k
roms/config.seabios-256k
roms/config.seabios-microvm
roms/config.vga-ati
roms/config.vga-bochs-display
roms/config.vga-cirrus
roms/config.vga-isavga
roms/config.vga-qxl
roms/config.vga-ramfb
roms/config.vga-stdvga
roms/config.vga-virtio
roms/configure-seabios.sh
roms/ipxe
roms/openbios
roms/opensbi
roms/qboot
roms/qemu-palcode
roms/seabios
roms/skiboot
roms/u-boot
scripts/analyze-inclusions
scripts/checkpatch.pl
scripts/clean-header-guards.pl
scripts/clean-includes
scripts/cleanup-trace-events.pl
scripts/cocci-macro-file.h
scripts/coccinelle/cpu-reset.cocci
scripts/coccinelle/cpu_restore_state.cocci
scripts/coccinelle/device-reset.cocci
scripts/coccinelle/exec_rw_const.cocci
scripts/coccinelle/inplace-byteswaps.cocci
scripts/coccinelle/overflow_muldiv64.cocci
scripts/coccinelle/remove_muldiv64.cocci
scripts/coccinelle/reset-type.cocci
scripts/coccinelle/return_directly.cocci
scripts/coccinelle/round.cocci
scripts/coccinelle/simplify_muldiv64.cocci
scripts/coccinelle/swap_muldiv64.cocci
scripts/coccinelle/tcg_gen_extract.cocci
scripts/coccinelle/timer-del-timer-free.cocci
scripts/coccinelle/typecast.cocci
scripts/coccinelle/use-g_new-etc.cocci
scripts/device-crash-test
scripts/disas-objdump.pl
scripts/extract-vsssdk-headers
scripts/fix-multiline-comments.sh
scripts/get_maintainer.pl
scripts/git.orderfile
scripts/hxtool
scripts/make-config-poison.sh
scripts/make-release
scripts/meson.build
scripts/mkemmc.sh
scripts/modules/module_block.py
scripts/qemu-version.sh
scripts/qemugdb/__init__.py
scripts/qemugdb/coroutine.py
scripts/qemugdb/mtree.py
scripts/qemugdb/tcg.py
scripts/qemugdb/timers.py
scripts/refresh-pxe-roms.sh
scripts/rust-to-clang-target-test.sh
scripts/rust-to-clang-target.sh
stats/meson.build
stats/stats-hmp-cmds.c
stats/stats-qmp-cmds.c
subprojects/.gitignore
subprojects/anyhow-1-rs.wrap
subprojects/arbitrary-int-1-rs.wrap
subprojects/attrs-0.2-rs.wrap
subprojects/berkeley-softfloat-3.wrap
subprojects/berkeley-testfloat-3.wrap
subprojects/bilge-0.2-rs.wrap
subprojects/bilge-impl-0.2-rs.wrap
subprojects/dtc.wrap
subprojects/either-1-rs.wrap
subprojects/foreign-0.3-rs.wrap
subprojects/glib-sys-0.21-rs.wrap
subprojects/itertools-0.11-rs.wrap
subprojects/keycodemapdb.wrap
subprojects/libblkio.wrap
subprojects/libc-0.2-rs.wrap
subprojects/libvfio-user.wrap
subprojects/packagefiles/anyhow-1-rs/meson.build
subprojects/packagefiles/arbitrary-int-1-rs/meson.build
subprojects/packagefiles/attrs-0.2-rs/meson.build
subprojects/packagefiles/berkeley-softfloat-3/meson.build
subprojects/packagefiles/berkeley-softfloat-3/meson_options.txt
subprojects/packagefiles/berkeley-testfloat-3/meson.build
subprojects/packagefiles/berkeley-testfloat-3/meson_options.txt
subprojects/packagefiles/bilge-0.2-rs/meson.build
subprojects/packagefiles/bilge-impl-0.2-rs/meson.build
subprojects/packagefiles/either-1-rs/meson.build
subprojects/packagefiles/foreign-0.3-rs/meson.build
subprojects/packagefiles/glib-sys-0.21-rs/meson.build
subprojects/packagefiles/itertools-0.11-rs/meson.build
subprojects/packagefiles/libc-0.2-rs/meson.build
subprojects/packagefiles/proc-macro-error-1-rs/meson.build
subprojects/packagefiles/proc-macro-error-attr-1-rs/meson.build
subprojects/packagefiles/proc-macro2-1-rs/meson.build
subprojects/packagefiles/quote-1-rs/meson.build
subprojects/packagefiles/syn-2-rs/meson.build
subprojects/packagefiles/unicode-ident-1-rs/meson.build
subprojects/proc-macro-error-1-rs.wrap
subprojects/proc-macro-error-attr-1-rs.wrap
subprojects/proc-macro2-1-rs.wrap
subprojects/quote-1-rs.wrap
subprojects/slirp.wrap
subprojects/syn-2-rs.wrap
subprojects/unicode-ident-1-rs.wrap
system/arch_init.c
system/async-teardown.c
system/datadir.c
system/device_tree-stub.c
system/exit-with-parent.c
system/globals-target.c
system/globals.c
system/memory_ldst.c.inc
system/meson.build
system/rtc.c
system/trace-events
system/trace.h
target/i386/trace-events
target/meson.build
tests/bench/atomic64-bench.c
tests/bench/atomic_add-bench.c
tests/bench/bufferiszero-bench.c
tests/bench/meson.build
tests/bench/qht-bench.c
tests/bench/qtree-bench.c
tests/bench/test_akcipher_keys.c.inc
tests/data/smbios/type11_blob
tests/data/smbios/type11_blob.legacy
tests/dbus-vmstate-daemon.sh
tests/functional/aarch64/meson.build
tests/functional/acpi-bits/bits-config/bits-cfg.txt
tests/functional/acpi-bits/bits-tests/smbios.py2
tests/functional/acpi-bits/bits-tests/smilatency.py2
tests/functional/acpi-bits/bits-tests/testacpi.py2
tests/functional/acpi-bits/bits-tests/testcpuid.py2
tests/functional/arm/meson.build
tests/functional/arm/test_max78000fthr.py
tests/functional/generic/meson.build
tests/functional/loongarch64/meson.build
tests/functional/m68k/meson.build
tests/functional/meson.build
tests/functional/microblaze/meson.build
tests/functional/microblazeel/meson.build
tests/functional/mips/meson.build
tests/functional/mips64/meson.build
tests/functional/mips64el/meson.build
tests/functional/mipsel/meson.build
tests/functional/or1k/meson.build
tests/functional/ppc/meson.build
tests/functional/ppc64/meson.build
tests/functional/rx/meson.build
tests/functional/sh4/meson.build
tests/functional/sh4eb/meson.build
tests/functional/sparc/meson.build
tests/functional/sparc64/meson.build
tests/functional/xtensa/meson.build
tests/guest-debug/run-test.py
tests/guest-debug/test_gdbstub.py
tests/include/meson.build
tests/keys/README
tests/keys/id_rsa
tests/keys/id_rsa.pub
tests/keys/vagrant
tests/keys/vagrant.pub
tests/meson.build
tests/multiboot/Makefile
tests/multiboot/aout_kludge.S
tests/multiboot/aout_kludge.out
tests/multiboot/libc.c
tests/multiboot/libc.h
tests/multiboot/link.ld
tests/multiboot/mmap.c
tests/multiboot/mmap.out
tests/multiboot/module.txt
tests/multiboot/modules.c
tests/multiboot/modules.out
tests/multiboot/multiboot.h
tests/multiboot/run_test.sh
tests/multiboot/start.S
tests/perf/block/qcow2/convert-blockstatus
tests/tcg/README
tests/tcg/aarch64_be/Makefile.target
tests/tcg/aarch64_be/hello.c
tests/tcg/minilib/Makefile.target
tests/tcg/minilib/minilib.h
tests/tcg/minilib/printf.c
tests/test-qht-par.c
tests/tsan/ignore.tsan
tests/tsan/suppressions.tsan
tests/unit/io-channel-helpers.c
tests/unit/io-channel-helpers.h
tests/unit/iothread.c
tests/unit/iothread.h
tests/unit/meson.build
tests/unit/ptimer-test-stubs.c
tests/unit/ptimer-test.c
tests/unit/ptimer-test.h
tests/unit/socket-helpers.c
tests/unit/socket-helpers.h
tests/unit/test-aio-multithread.c
tests/unit/test-aio.c
tests/unit/test-base64.c
tests/unit/test-bdrv-drain.c
tests/unit/test-bdrv-graph-mod.c
tests/unit/test-bitcnt.c
tests/unit/test-bitmap.c
tests/unit/test-bitops.c
tests/unit/test-block-backend.c
tests/unit/test-block-iothread.c
tests/unit/test-blockjob-txn.c
tests/unit/test-blockjob.c
tests/unit/test-bufferiszero.c
tests/unit/test-char.c
tests/unit/test-cutils.c
tests/unit/test-div128.c
tests/unit/test-error-report.c
tests/unit/test-fifo.c
tests/unit/test-image-locking.c
tests/unit/test-int128.c
tests/unit/test-interval-tree.c
tests/unit/test-iov.c
tests/unit/test-logging.c
tests/unit/test-mul64.c
tests/unit/test-nested-aio-poll.c
tests/unit/test-qdist.c
tests/unit/test-qgraph.c
tests/unit/test-qht.c
tests/unit/test-qtree.c
tests/unit/test-resv-mem.c
tests/unit/test-shift128.c
tests/unit/test-thread-pool.c
tests/unit/test-timed-average.c
tests/unit/test-util-sockets.c
tests/unit/test-vmstate.c
tests/unit/test-write-threshold.c
tests/unit/test-xbzrle.c
tests/unit/test-xs-node.c
tests/vhost-user-bridge.c
tools/meson.build
util/aiocb.c
util/atomic64.c
util/base64.c
util/bitmap.c
util/bitops.c
util/block-helpers.c
util/block-helpers.h
util/bufferiszero.c
util/compatfd.c
util/crc-ccitt.c
util/crc32c.c
util/cutils.c
util/envlist.c
util/event.c
util/fifo8.c
util/getauxval.c
util/guest-random.c
util/hexdump.c
util/host-utils.c
util/id.c
util/int128.c
util/interval-tree.c
util/iov.c
util/log.c
util/memalign.c
util/memfd.c
util/meson.build
util/mmap-alloc.c
util/module.c
util/notify.c
util/nvdimm-utils.c
util/osdep.c
util/path.c
util/qdist.c
util/qemu-co-timeout.c
util/qemu-config.c
util/qemu-thread-common.h
util/qht.c
util/qsp.c
util/qtree.c
util/range.c
util/readline.c
util/reserved-region.c
util/s390x_pci_mmio.c
util/selfmap.c
util/stats64.c
util/sys_membarrier.c
util/systemd.c
util/thread-context.c
util/thread-pool.c
util/timed-average.c
util/trace-events
util/trace.h
util/unicode.c
version.rc


