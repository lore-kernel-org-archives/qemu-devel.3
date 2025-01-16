Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AE17C02187
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 16:13:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYSUU-0004X2-Si; Thu, 16 Jan 2025 11:13:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYSTj-0003Wg-7Z
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 11:12:19 -0500
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYSTd-0004S7-E4
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 11:12:18 -0500
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-aaf6b1a5f2bso440642866b.1
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 08:12:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737043931; x=1737648731; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VHZaaybMQXo6bZA71gPVErDeDk+1E6DxFZkUrlRcO18=;
 b=siXUytSIYmpujlSQoqhCUjlYPCaSmYArGECmUn918NsFlDy/3+mhoLqjBukY0Xoex1
 91nzy87De+tvjIYkeEzyEiopYeHJao4Zyj2eDnxBhpNF6INwJb/LewpWsZDMGL5mokDz
 1V/TARid800AIRr6/v219kygP87SPloQvt6EAnLrV5j04+ydNdR0oL0dmmpZQiXyeWmf
 WowEZ3HIaWnvqppq0GpFf4sPtKrLKl1Q56fSmeh9X+ya0AoUxxn8WO4UcX0c9bCVer7v
 +dckM0FWLZ5VFqbxLwmg7qOp6LmIfRyAE90hGKIgR6fJmGUpNacNBnE8NiTxdX+g6QbO
 LA7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737043931; x=1737648731;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VHZaaybMQXo6bZA71gPVErDeDk+1E6DxFZkUrlRcO18=;
 b=C9i8ln+LvWFSNpaRwKDCjSpC5vqWBpOcuCWHBwfCFrZLBlkMchDEks+QxY809TsIO8
 ArLZr1P85VckJhPfGfoj3J/MHkh9Dcp4NB0CjIJBPHGQfFgdpj4Auhp1N3f1mSNVOZAe
 2pWxoKueqkzL97QpzlXPa8ezKsoF74G3yU/zqgaEHWS6yoxZFxAPeWConR8K+lkzeA60
 RRfH5ZCuI1Nbxj+AMIbC8lreMWyqAheVMF2ne+PvHeYqM8Zrzcg7VsS3wWH4HLw4WGrP
 t+ABnxwDOSttilmNZpsUeFIbOdszibsOZ9l96KsGAn/6uzUEWDJQgpYJZDMGIfUwqN+E
 Y7mQ==
X-Gm-Message-State: AOJu0Yz/dr6OK2NtB5vPxOaWAmp5FYLriu7tobjTT0dLb4ed3SIdCnyi
 m9pDd7MXI5Cy8xcRG0VDOtteG1H5G13QC550Rww13q1DwPfhoGMc1NVPJs+lXUg=
X-Gm-Gg: ASbGnctGdaL5vAfLZGKbUZkhaOxsDXIZJaVxMzBL5HDzl4WWEApsxg2FXlIHUOmxCks
 kfWE3kFC5TMMufWes/xsEzBoxoJt+iSr3ABjc7ODghsg6q4P+syfDsvFJQgfGrVyxP3PD6j45fk
 HQ28aRBOa+CcVDJ8DeY/6U+2Haa3rtd1wjPnZB9Blmj6nJLef5A0RKTkfE2qtlbJwA3Fw+1UCmU
 zTPWU5UCbvjWrUPGwqE1aeCtZ0WRpJtwsN6anP2AlaKEwLjBhIDeyM=
X-Google-Smtp-Source: AGHT+IGPSifwAL11M+D+I5Ugf5mJrwCi1kwvNX34UIfgAM1sJ8DRTzLWH8/lK69QQC5T54GlwYuOSA==
X-Received: by 2002:a17:906:35c5:b0:aa6:88be:729d with SMTP id
 a640c23a62f3a-ab36e4001a1mr278158766b.21.1737043931347; 
 Thu, 16 Jan 2025 08:12:11 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab384f86265sm14529166b.130.2025.01.16.08.12.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 08:12:09 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 272EF608F4;
 Thu, 16 Jan 2025 16:03:10 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Jason Wang <jasowang@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Weil <sw@weilnetz.de>, Stefano Garzarella <sgarzare@redhat.com>,
 qemu-arm@nongnu.org, Michael Roth <michael.roth@amd.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>, Kyle Evans <kevans@freebsd.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, David Hildenbrand <david@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Alexandre Iooss <erdnaxe@crans.org>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 36/37] docs: add a glossary
Date: Thu, 16 Jan 2025 16:03:05 +0000
Message-Id: <20250116160306.1709518-37-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250116160306.1709518-1-alex.bennee@linaro.org>
References: <20250116160306.1709518-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62a.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_SBL_A=0.1 autolearn=unavailable autolearn_force=no
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20241209183104.365796-7-pierrick.bouvier@linaro.org>
[AJB: update MAINTAINERS]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v3
  - update MAINTAINERS
---
 MAINTAINERS                           |   1 +
 docs/devel/control-flow-integrity.rst |   2 +
 docs/devel/multi-thread-tcg.rst       |   2 +
 docs/glossary.rst                     | 280 ++++++++++++++++++++++++++
 docs/index.rst                        |   1 +
 docs/system/arm/virt.rst              |   2 +
 docs/system/images.rst                |   2 +
 docs/tools/qemu-nbd.rst               |   2 +
 8 files changed, 292 insertions(+)
 create mode 100644 docs/glossary.rst

diff --git a/MAINTAINERS b/MAINTAINERS
index 480902493a..6709a2ea65 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -79,6 +79,7 @@ F: docs/devel/conflict-resolution.rst
 F: docs/devel/style.rst
 F: docs/devel/submitting-a-patch.rst
 F: docs/devel/submitting-a-pull-request.rst
+F: docs/glossary.rst
 
 Responsible Disclosure, Reporting Security Issues
 -------------------------------------------------
diff --git a/docs/devel/control-flow-integrity.rst b/docs/devel/control-flow-integrity.rst
index e6b73a4fe1..3d5702fa4c 100644
--- a/docs/devel/control-flow-integrity.rst
+++ b/docs/devel/control-flow-integrity.rst
@@ -1,3 +1,5 @@
+.. _cfi:
+
 ============================
 Control-Flow Integrity (CFI)
 ============================
diff --git a/docs/devel/multi-thread-tcg.rst b/docs/devel/multi-thread-tcg.rst
index d706c27ea7..7fd0a07633 100644
--- a/docs/devel/multi-thread-tcg.rst
+++ b/docs/devel/multi-thread-tcg.rst
@@ -4,6 +4,8 @@
   This work is licensed under the terms of the GNU GPL, version 2 or
   later. See the COPYING file in the top-level directory.
 
+.. _mttcg:
+
 ==================
 Multi-threaded TCG
 ==================
diff --git a/docs/glossary.rst b/docs/glossary.rst
new file mode 100644
index 0000000000..693d9855dd
--- /dev/null
+++ b/docs/glossary.rst
@@ -0,0 +1,280 @@
+.. _Glossary:
+
+--------
+Glossary
+--------
+
+This section of the manual presents brief definitions of acronyms and terms used
+by QEMU developers.
+
+Accelerator
+-----------
+
+A specific API used to accelerate execution of guest instructions. It can be
+hardware-based, through a virtualization API provided by the host OS (kvm, hvf,
+whpx, ...), or software-based (tcg). See this description of `supported
+accelerators<Accelerators>`.
+
+Board
+-----
+
+Another name for :ref:`machine`.
+
+Block
+-----
+
+Block drivers are the available `disk formats and front-ends
+<block-drivers>` available, and block devices `(see Block device section on
+options page)<sec_005finvocation>` are using them to implement disks for a
+virtual machine.
+
+CFI
+---
+
+Control Flow Integrity is a hardening technique used to prevent exploits
+targeting QEMU by detecting unexpected branches during execution. QEMU `actively
+supports<cfi>` being compiled with CFI enabled.
+
+Device
+------
+
+In QEMU, a device is a piece of hardware visible to the guest. Examples include
+UARTs, PCI controllers, PCI cards, VGA controllers, and many more.
+
+QEMU is able to emulate a CPU, and all the hardware interacting with it,
+including `many devices<device-emulation>`. When QEMU runs a virtual machine
+using a hardware-based accelerator, it is responsible for emulating, using
+software, all devices.
+
+EDK2
+----
+
+EDK2, as known as `TianoCore <https://www.tianocore.org/>`_, is an open source
+implementation of UEFI standard. QEMU virtual machines that boot a UEFI firmware
+usually use EDK2.
+
+gdbstub
+-------
+
+QEMU implements a `gdb server <GDB usage>`, allowing gdb to attach to it and
+debug a running virtual machine, or a program in user-mode. This allows
+debugging the guest code that is running inside QEMU.
+
+glib2
+-----
+
+`GLib2 <https://docs.gtk.org/glib/>`_ is one of the most important libraries we
+are using through the codebase. It provides many data structures, macros, string
+and thread utilities and portable functions across different OS. It's required
+to build QEMU.
+
+Guest agent
+-----------
+
+The `QEMU Guest Agent <qemu-ga>` is a daemon intended to be run within virtual
+machines. It provides various services to help QEMU to interact with it.
+
+.. _guest:
+
+Guest
+-----
+
+Guest is the architecture of the virtual machine, which is emulated.
+See also :ref:`host`.
+
+Sometimes this is called the :ref:`target` architecture, but that term
+can be ambiguous.
+
+.. _host:
+
+Host
+----
+
+Host is the architecture on which QEMU is running on, which is native.
+See also :ref:`guest`.
+
+Hypervisor
+----------
+
+The formal definition of an hypervisor is a program or API than can be used to
+manage a virtual machine. QEMU is a virtualizer, that interacts with various
+hypervisors.
+
+In the context of QEMU, an hypervisor is an API, provided by the Host OS,
+allowing to execute virtual machines. Linux implementation is KVM (and supports
+Xen as well). For MacOS, it's HVF. Windows defines WHPX. And NetBSD provides
+NVMM.
+
+.. _machine:
+
+Machine
+-------
+
+QEMU's system emulation models many different types of hardware. A machine model
+(sometimes called a board model) is the model of a complete virtual system with
+RAM, one or more CPUs, and various devices. It can be selected with the option
+``-machine`` of qemu-system. Our machine models can be found on this `page
+<system-targets-ref>`.
+
+Migration
+---------
+
+QEMU can save and restore the execution of a virtual machine between different
+host systems. This is provided by the `Migration framework<migration>`.
+
+NBD
+---
+
+The `QEMU Network Block Device server <qemu-nbd>` is a tool that can be used to
+mount and access QEMU images, providing functionality similar to a loop device.
+
+Mailing List
+------------
+
+This is `where <https://wiki.qemu.org/Contribute/MailingLists>`_ all the
+development happens! Changes are posted as series, that all developers can
+review and share feedback for.
+
+For reporting issues, our `GitLab
+<https://gitlab.com/qemu-project/qemu/-/issues>`_ tracker is the best place.
+
+.. _softmmu:
+
+MMU / softmmu
+-------------
+
+The Memory Management Unit is responsible for translating virtual addresses to
+physical addresses and managing memory protection. QEMU system mode is named
+"softmmu" precisely because it implements this in software, including a TLB
+(Translation lookaside buffer), for the guest virtual machine.
+
+QEMU user-mode does not implement a full software MMU, but "simply" translates
+virtual addresses by adding a specific offset, and relying on host MMU/OS
+instead.
+
+Monitor / QMP / HMP
+-------------------
+
+The `QEMU Monitor <QEMU monitor>` is a text interface which can be used to interact
+with a running virtual machine.
+
+QMP stands for QEMU Monitor Protocol and is a json based interface.
+HMP stands for Human Monitor Protocol and is a set of text commands available
+for users who prefer natural language to json.
+
+MTTCG
+-----
+
+Multiple CPU support was first implemented using a round-robin algorithm
+running on a single thread. Later on, `Multi-threaded TCG <mttcg>` was developed
+to benefit from multiple cores to speed up execution.
+
+Plugins
+-------
+
+`TCG Plugins <TCG Plugins>` is an API used to instrument guest code, in system
+and user mode. The end goal is to have a similar set of functionality compared
+to `DynamoRIO <https://dynamorio.org/>`_ or `valgrind <https://valgrind.org/>`_.
+
+One key advantage of QEMU plugins is that they can be used to perform
+architecture agnostic instrumentation.
+
+Patchew
+-------
+
+`Patchew <https://patchew.org/QEMU/>`_ is a website that tracks patches on the
+Mailing List.
+
+PR
+--
+
+Once a series is reviewed and accepted by a subsystem maintainer, it will be
+included in a PR (Pull Request) that the project maintainer will merge into QEMU
+main branch, after running tests.
+
+The QEMU project doesn't currently expect most developers to directly submit
+pull requests.
+
+QCOW2
+-----
+
+QEMU Copy On Write is a disk format developed by QEMU. It provides transparent
+compression, automatic extension, and many other advantages over a raw image.
+
+qcow2 is the recommended format to use.
+
+QEMU
+----
+
+`QEMU (Quick Emulator) <https://www.qemu.org/>`_ is a generic and open source
+machine emulator and virtualizer.
+
+QOM
+---
+
+`QEMU Object Model <qom>` is an object oriented API used to define various
+devices and hardware in the QEMU codebase.
+
+Record/replay
+-------------
+
+`Record/replay <replay>` is a feature of QEMU allowing to have a deterministic
+and reproducible execution of a virtual machine.
+
+Rust
+----
+
+`A new programming language <https://www.rust-lang.org/>`_, memory safe by
+default. There is a work in progress to integrate it in QEMU codebase for
+various subsystems.
+
+System mode
+-----------
+
+QEMU System mode provides a virtual model of an entire machine (CPU, memory and
+emulated devices) to run a guest OS. In this mode the CPU may be fully emulated,
+or it may work with a hypervisor such as KVM, Xen or Hypervisor.Framework to
+allow the guest to run directly on the host CPU.
+
+QEMU System mode is called :ref:`softmmu <softmmu>` as well.
+
+.. _target:
+
+Target
+------
+
+The term "target" can be ambiguous. In most places in QEMU it is used as a
+synonym for :ref:`guest`. For example the code for emulating Arm CPUs is in
+``target/arm/``. However in the :ref:`TCG subsystem <tcg>` "target" refers to the
+architecture which QEMU is running on, i.e. the :ref:`host`.
+
+TCG
+---
+
+TCG is the QEMU `Tiny Code Generator <tcg>`. It is the JIT (just-in-time)
+compiler we use to emulate a guest CPU in software.
+
+It is one of the accelerators supported by QEMU, and supports a lot of
+guest/host architectures.
+
+User mode
+---------
+
+QEMU User mode can launch processes compiled for one CPU on another CPU. In this
+mode the CPU is always emulated. In this mode, QEMU translate system calls from
+guest to host kernel. It is available for Linux and BSD.
+
+VirtIO
+------
+
+VirtIO is an open standard used to define and implement virtual devices with a
+minimal overhead, defining a set of data structures and hypercalls (similar to
+system calls, but targeting an hypervisor, which happens to be QEMU in our
+case). It's designed to be more efficient than emulating a real device, by
+minimizing the amount of interactions between a guest VM and its hypervisor.
+
+vhost-user
+----------
+
+`Vhost-user <vhost_user>` is an interface used to implement VirtIO devices
+outside of QEMU itself.
diff --git a/docs/index.rst b/docs/index.rst
index 78285ebd6a..5665de85ca 100644
--- a/docs/index.rst
+++ b/docs/index.rst
@@ -20,3 +20,4 @@ Welcome to QEMU's documentation!
    interop/index
    specs/index
    devel/index
+   glossary
diff --git a/docs/system/arm/virt.rst b/docs/system/arm/virt.rst
index 766a7455f0..0c9c2ce035 100644
--- a/docs/system/arm/virt.rst
+++ b/docs/system/arm/virt.rst
@@ -1,3 +1,5 @@
+.. _arm-virt:
+
 'virt' generic virtual platform (``virt``)
 ==========================================
 
diff --git a/docs/system/images.rst b/docs/system/images.rst
index d000bd6b6f..a5551173c9 100644
--- a/docs/system/images.rst
+++ b/docs/system/images.rst
@@ -82,4 +82,6 @@ VM snapshots currently have the following known limitations:
 -  A few device drivers still have incomplete snapshot support so their
    state is not saved or restored properly (in particular USB).
 
+.. _block-drivers:
+
 .. include:: qemu-block-drivers.rst.inc
diff --git a/docs/tools/qemu-nbd.rst b/docs/tools/qemu-nbd.rst
index 329f44d989..4f21b7904a 100644
--- a/docs/tools/qemu-nbd.rst
+++ b/docs/tools/qemu-nbd.rst
@@ -1,3 +1,5 @@
+.. _qemu-nbd:
+
 =====================================
 QEMU Disk Network Block Device Server
 =====================================
-- 
2.39.5


