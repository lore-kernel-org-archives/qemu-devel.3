Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6159C54E4A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 22:25:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdHUN-0002ZF-Qs; Thu, 22 Feb 2024 17:24:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1rdHUM-0002Ye-7a
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 17:24:22 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1rdHUK-00039q-99
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 17:24:21 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6e46dcd8feaso82084b3a.2
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 14:24:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708640657; x=1709245457; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=odmBrfxrVJqhwVA+IUSN99OoFSVOcM+f5audJj2ZfrI=;
 b=VEQ+znI2BWIiKGlbPj4tzznIs7UcihYSmQ57YTFNIEKTpejtNZBmd9Yr9bAXZd8Av3
 OXvFO9L88Smub88NUR2AaGMKi12DllJ/n7m32NGLfd3HCuv/lMRPYmCVueHTlywnbR/u
 Zz2ZAas0TPwHEaIBn44EJ0JsZ9N7EXUhhXy+U4j6ZE3mwvbzAHJ8WuFcZwH6GKdzOPBF
 Ol2CApcyzPMsq5QCOGcDsdxxsrak8sIqfs4pOAGh5QQD00wSSUoQ3ppTx/E/EB8LGAvp
 B2AUmyuvbt9DdfWaSyv0DeEZGJmqDEfhaRx7qPB4GTbKy1L8em5NocAd16BCm6Zm5ZkS
 iO0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708640657; x=1709245457;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=odmBrfxrVJqhwVA+IUSN99OoFSVOcM+f5audJj2ZfrI=;
 b=XRRNJqEKRzgSvX2G97exvQRB7FnKZDO2JPuhl8NVqvU0vMgy3F5/IlkTDIUafxG9em
 4lhNWj02gSHlTxPsvb1cJz+GrfX4Qd/Z7HBuMOT5dj9qdC44IcwwNTpSJWEMMGMD/tWg
 LVA0Y1IsCyZjTo4PQ1yr/wpICFoVQAZQKhvhnk5pDkyLEDnPGQrKSlqmTx6Oq/7tf8BC
 OKloDxbk8mVDUwCGMpJFVMTt35ffTeYRPWZB5MNrHdlLlflPNXEaxAfU3lWyzgFz4R9e
 dcmH37lVWR8bxa9PMg6fArwhzunyzysl4P/w6pHiCv8/Lr52btSVdghoH70uNYZNKnjM
 CQSA==
X-Gm-Message-State: AOJu0YyaCtP/gghCXRKODJua8fJi3aBPxRMS8BUh8m3vVQQNbc7Z/5C9
 wLRb43+r1rui0cn6w+p/W0gCaZ7ZQ1GjGONsWFrc4w8brXkyww9ZUPS5ul0X1SF9k0xvq1zD8zZ
 qrS0=
X-Google-Smtp-Source: AGHT+IHFqLrcw/KANkMAQvECqMQhVS7dpdsPVJlM2RLEIlbDAoquX2rq27vi8H8SzxBqVZJ7wpykAg==
X-Received: by 2002:a17:902:6548:b0:1d5:f36c:8737 with SMTP id
 d8-20020a170902654800b001d5f36c8737mr168930pln.68.1708640657196; 
 Thu, 22 Feb 2024 14:24:17 -0800 (PST)
Received: from amd.. ([2804:7f0:b400:285a:3e7c:3fff:fe7a:e83b])
 by smtp.gmail.com with ESMTPSA id
 ji7-20020a170903324700b001d7057c2fbasm10457210plb.100.2024.02.22.14.24.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Feb 2024 14:24:16 -0800 (PST)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org,
	philmd@linaro.org
Cc: thuth@redhat.com, lvivier@redhat.com, qemu-arm@nongnu.org,
 alex.bennee@linaro.org, pbonzini@redhat.com, anton.kochkov@proton.me,
 richard.henderson@linaro.org, peter.maydell@linaro.org,
 gustavo.romero@linaro.org
Subject: [PATCH 0/6] Add ivshmem-flat device
Date: Thu, 22 Feb 2024 22:22:12 +0000
Message-Id: <20240222222218.2261956-1-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pf1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Since v1:
- Correct code style
- Correct trace event format strings
- Include minimum headers in ivshmem-flat.h
- Allow ivshmem_flat_recv_msg() take NULL
- Factored ivshmem_flat_connect_server() out
- Split sysbus-auto-wire controversial code in different patch
- Document QDev interface

Since v2:
- Addressed all comments from Thomas Huth about qtest:
  1) Use of g_usleep + number of attemps for timeout
  2) Use of g_get_tmp_dir instead of hard-coded /tmp
  3) Test if machine lm3s6965evb is available, if not skip test
- Use of qemu_irq_pulse instead of 2x qemu_set_irq
- Fixed all tests for new device options and IRQ name change
- Updated doc and commit messages regarding new/deleted device options
- Turned device options 'x-bus-address-iomem' and 'x-bus-address-shmem' mandatory

--

This patchset introduces a new device, ivshmem-flat, which is similar to the
current ivshmem device but does not require a PCI bus. It implements the ivshmem
status and control registers as MMRs and the shared memory as a directly
accessible memory region in the VM memory layout. It's meant to be used on
machines like those with Cortex-M MCUs, which usually lack a PCI bus, e.g.,
lm3s6965evb and mps2-an385. Additionally, it has the benefit of requiring a tiny
'device driver,' which is helpful on some RTOSes, like Zephyr, that run on
memory-constrained resource targets.

The patchset includes a QTest for the ivshmem-flat device, however, it's also
possible to experiment with it in two ways:

(a) using two Cortex-M VMs running Zephyr; or
(b) using one aarch64 VM running Linux with the ivshmem PCI device and another
    arm (Cortex-M) VM running Zephyr with the new ivshmem-flat device.

Please note that for running the ivshmem-flat QTests the following patch, which
is not committed to the tree yet, must be applied:

https://lists.nongnu.org/archive/html/qemu-devel/2023-11/msg03176.html

--

To experiment with (a), clone this Zephyr repo [0], set the Zephyr build
environment [1], and follow the instructions in the 'ivshmem' sample main.c [2].

[0] https://github.com/gromero/zephyr/tree/ivshmem
[1] https://docs.zephyrproject.org/latest/develop/getting_started/index.html
[2] https://github.com/gromero/zephyr/commit/73fbd481e352b25ae5483ba5048a2182b90b7f00#diff-16fa1f481a49b995d0d1a62da37b9f33033f5ee477035e73465e7208521ddbe0R9-R70
[3] https://lore.kernel.org/qemu-devel/20231127052024.435743-1-gustavo.romero@linaro.org/

To experiment with (b):

$ git clone -b uio_ivshmem --single-branch https://github.com/gromero/linux.git
$ cd linux
$ wget https://people.linaro.org/~gustavo.romero/ivshmem/arm64_uio_ivshmem.config -O .config

If in an x86_64 machine, cross compile the kernel, for instance:

$ make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j 36

Install image in some directory, let's say, in ~/linux:

$ mkdir ~/linux
$ export INSTALL_PATH=~/linux
$ make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j 36 install

or, if you prefer, download the compiled image from:

$ wget https://people.linaro.org/~gustavo.romero/ivshmem/vmlinuz-6.6.0-rc1-g28f3f88ee261

... and then the rootfs:

$ wget https://people.linaro.org/~gustavo.romero/ivshmem/rootfs.qcow2

Now, build QEMU with this patchset applied:

$ mkdir build && cd build
$ ../configure --target-list=arm-softmmu,aarch64-softmmu
$ make -j 36

Start the ivshmem server:

$ contrib/ivshmem-server/ivshmem-server -F

Start the aarch64 VM + Linux + ivshmem PCI device:

$ ./qemu-system-aarch64 -kernel ~/linux/vmlinuz-6.6.0-rc1-g28f3f88ee261 -append "root=/dev/vda initrd=/bin/bash console=ttyAMA0,115200" -drive file=~/linux/rootfs.qcow2,media=disk,if=virtio -machine virt-6.2 -nographic -accel tcg -cpu cortex-a57 -m 8192 -netdev bridge,id=hostnet0,br=virbr0,helper=/usr/lib/qemu/qemu-bridge-helper -device pcie-root-port,port=8,chassis=1,id=pci.1,bus=pcie.0,multifunction=on,addr=0x1 -device virtio-net-pci,netdev=hostnet0,id=net0,mac=52:54:00:d9:d1:12,bus=pci.1,addr=0x0 -device ivshmem-doorbell,vectors=2,chardev=ivshmem -chardev socket,path=/tmp/ivshmem_socket,id=ivshmem

Log into the VM with user/pass: root/abc123

should show:

[    2.656367] uio_ivshmem 0000:00:02.0: ivshmem-mmr at 0x0000000010203000, size 0x0000000000001000
[    2.656931] uio_ivshmem 0000:00:02.0: ivshmem-shmem at 0x0000008000000000, size 0x0000000000400000
[    2.662554] uio_ivshmem 0000:00:02.0: module successfully loaded

In another console, clone and build Zephyr image from 'uio_ivhsmem' branch:

$ git clone -b uio_ivshmem --single-branch https://github.com/gromero/zephyr
$ west -v --verbose build -p always -b qemu_cortex_m3 ./samples/uio_ivshmem/

... and then start the arm VM + Zephyr image + ivshmem-flat device:

$ ./qemu-system-arm -machine lm3s6965evb -nographic -net none -chardev socket,path=/tmp/ivshmem_socket,id=ivshmem_flat -device ivshmem-flat,chardev=ivshmem_flat,x-irq-qompath='/machine/unattached/device[1]/nvic/unnamed-gpio-in[0]',x-bus-qompath='/sysbus' -kernel ~/zephyrproject/zephyr/build/qemu_cortex_m3/uio_ivshmem/zephyr/zephyr.elf

You should see something like:

*** Booting Zephyr OS build zephyr-v3.3.0-8350-gfb003e583600 ***
*** Board: qemu_cortex_m3
*** Installing direct IRQ handler for external IRQ0 (Exception #16)...
*** Enabling IRQ0 in the NVIC logic...
*** Received IVSHMEM PEER ID: 7
*** Waiting notification from peers to start...

Now, from the Linux terminal, notify the arm VM (use the "IVSHMEM PEER ID"
reported by Zephyr as the third arg, in this example: 7):

MMRs mapped at 0xffff8fb28000 in VMA.
shmem mapped at 0xffff8f728000 in VMA.
mmr0: 0 0
mmr1: 0 0
mmr2: 6 6
mmr3: 0 0
Data ok. 4194304 byte(s) checked.

The arm VM should report something like:

*** Got interrupt at vector 0!
*** Writting constant 0xb5b5b5b5 to shmem... done!
*** Notifying back peer ID 6 at vector 0...

Cheers,
Gustavo

Gustavo Romero (6):
  hw/misc/ivshmem: Add ivshmem-flat device
  hw/misc/ivshmem-flat: Allow device to wire itself on sysbus
  hw/arm: Allow some machines to use the ivshmem-flat device
  hw/misc/ivshmem: Rename ivshmem to ivshmem-pci
  tests/qtest: Reorganize common code in ivshmem-test
  tests/qtest: Add ivshmem-flat test

 docs/system/devices/ivshmem-flat.rst |  90 +++++
 hw/arm/mps2.c                        |   3 +
 hw/arm/stellaris.c                   |   3 +
 hw/arm/virt.c                        |   2 +
 hw/core/sysbus-fdt.c                 |   2 +
 hw/misc/Kconfig                      |   5 +
 hw/misc/ivshmem-flat.c               | 531 +++++++++++++++++++++++++++
 hw/misc/{ivshmem.c => ivshmem-pci.c} |   0
 hw/misc/meson.build                  |   4 +-
 hw/misc/trace-events                 |  17 +
 include/hw/misc/ivshmem-flat.h       |  94 +++++
 tests/qtest/ivshmem-flat-test.c      | 338 +++++++++++++++++
 tests/qtest/ivshmem-test.c           | 113 +-----
 tests/qtest/ivshmem-utils.c          | 156 ++++++++
 tests/qtest/ivshmem-utils.h          |  56 +++
 tests/qtest/meson.build              |   8 +-
 16 files changed, 1312 insertions(+), 110 deletions(-)
 create mode 100644 docs/system/devices/ivshmem-flat.rst
 create mode 100644 hw/misc/ivshmem-flat.c
 rename hw/misc/{ivshmem.c => ivshmem-pci.c} (100%)
 create mode 100644 include/hw/misc/ivshmem-flat.h
 create mode 100644 tests/qtest/ivshmem-flat-test.c
 create mode 100644 tests/qtest/ivshmem-utils.c
 create mode 100644 tests/qtest/ivshmem-utils.h

-- 
2.34.1


