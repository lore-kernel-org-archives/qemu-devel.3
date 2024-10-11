Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A8D1CFD30C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2024 09:50:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1szCHl-0000UC-7s; Fri, 11 Oct 2024 05:50:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1szCHj-0000SD-12
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 05:50:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1szCHh-0005ma-1i
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 05:50:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728640208;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sOo5rGwuEsLIsT0z0mvwLuo2d2iR44ZOAqKO0cUGjYk=;
 b=JPsUKNYHCb5wgocOs2D4oZ6+FGGI4fbQ5Xp9fprnqtFqWxipMht/axQC5V70dvGghTdCze
 d+K/F38mnZYi9iCKEQtuf8YG60PSQpJxioavpVqUjriBEX2GoyIeSRq251CbXFRd3xuJHh
 aFN0jmfDXjhp2SZQW1RR5MDDjK5G6X8=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-lKKSPT9uOPmK0PUGRQjVkw-1; Fri, 11 Oct 2024 05:50:06 -0400
X-MC-Unique: lKKSPT9uOPmK0PUGRQjVkw-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a996c29ee23so120784566b.0
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2024 02:50:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728640204; x=1729245004;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sOo5rGwuEsLIsT0z0mvwLuo2d2iR44ZOAqKO0cUGjYk=;
 b=lnOP/EgkoJf//Jmqo7REt3aFmAuNsjmHPK1h02rmfRaTOF2k91qX6g3h2rOv80KCaK
 1I5MiiOsjt1Rof41CG8a03VHq4ZkT+z7p17jJp7M7Npkc2MyP0L4W9WbJCRGAeqnEAi4
 VSJZF+Giko+ZsXPfaq3o5z6GQC38UTOhg576loaxAysKijivm107QDro6wd+tV2DwQvb
 OqMvIX2zY2MQ4zH8yZ57a1E9mqRyn3GJu3al2ECOZPzqSAusjk1/eQEgBoA+84L2SX2C
 RzQGSevH4Ahq/f13JmDF0LV/jNs3NLbKzKEr7MKndZOEYsAQg3OvfPEItMHLQ7qiR76o
 MPCA==
X-Gm-Message-State: AOJu0YyqwL2pswlgEmp2l6JbX8TeTb/xeTIQFDKlPL3TvK9Hq+rGuun8
 IqHqxowD1XCx+5d3/bVBizO9L0mTPlkABprUXuSXZX30ghKPpF/DlkANI7blXHmqqJn4KriC46L
 TLUlwR1CWvaxEP1NTKFcns2hZ9QJYS/3zp3SpQARa3Q/MA2ilr02vmzwLEHPHSjotSX8JjFbpUk
 4fcTo4h4z96GT6YaLqpUwte4ruTSHIFMCDzNpfKtI=
X-Received: by 2002:a17:907:2cc5:b0:a99:4ce4:27eb with SMTP id
 a640c23a62f3a-a99b95a7640mr150617466b.46.1728640204055; 
 Fri, 11 Oct 2024 02:50:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGjnvYrzObElx8zPxorBj7WPgkQkiJ+vW3/lPxrN8JMOlPwB8v3JpYRhzQT2epRDurRqM8qeA==
X-Received: by 2002:a17:907:2cc5:b0:a99:4ce4:27eb with SMTP id
 a640c23a62f3a-a99b95a7640mr150615366b.46.1728640203530; 
 Fri, 11 Oct 2024 02:50:03 -0700 (PDT)
Received: from avogadro.local ([151.81.124.37])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a99a7f2c1f4sm194059566b.87.2024.10.11.02.50.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2024 02:50:02 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH 3/3] docs: use consistent markup for footnotes
Date: Fri, 11 Oct 2024 11:49:48 +0200
Message-ID: <20241011094948.34550-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241011094948.34550-1-pbonzini@redhat.com>
References: <20241011094948.34550-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.149,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Always use a named reference for clarity, and ensure the space is escaped if the
footnote must attach to the preceding word.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/devel/atomics.rst              | 6 +++---
 docs/devel/build-system.rst         | 2 +-
 docs/devel/loads-stores.rst         | 2 +-
 docs/devel/maintainers.rst          | 4 ++--
 docs/devel/migration/mapped-ram.rst | 4 ++--
 docs/specs/fw_cfg.rst               | 4 ++--
 docs/specs/rapl-msr.rst             | 4 ++--
 7 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/docs/devel/atomics.rst b/docs/devel/atomics.rst
index 6bf032f9005..95c7b77c01e 100644
--- a/docs/devel/atomics.rst
+++ b/docs/devel/atomics.rst
@@ -204,7 +204,7 @@ They come in six kinds:
   before the second with respect to the other components of the system.
   Therefore, unlike ``smp_rmb()`` or ``qatomic_load_acquire()``,
   ``smp_read_barrier_depends()`` can be just a compiler barrier on
-  weakly-ordered architectures such as Arm or PPC\ [#]_.
+  weakly-ordered architectures such as Arm or PPC\ [#alpha]_.
 
   Note that the first load really has to have a _data_ dependency and not
   a control dependency.  If the address for the second load is dependent
@@ -212,7 +212,7 @@ They come in six kinds:
   than actually loading the address itself, then it's a _control_
   dependency and a full read barrier or better is required.
 
-.. [#] The DEC Alpha is an exception, because ``smp_read_barrier_depends()``
+.. [#alpha] The DEC Alpha is an exception, because ``smp_read_barrier_depends()``
    needs a processor barrier.  On strongly-ordered architectures such
    as x86 or s390, ``smp_rmb()`` and ``qatomic_load_acquire()`` can
    also be compiler barriers only.
@@ -295,7 +295,7 @@ Acquire/release pairing and the *synchronizes-with* relation
 ------------------------------------------------------------
 
 Atomic operations other than ``qatomic_set()`` and ``qatomic_read()`` have
-either *acquire* or *release* semantics [#rmw]_.  This has two effects:
+either *acquire* or *release* semantics\ [#rmw]_.  This has two effects:
 
 .. [#rmw] Read-modify-write operations can have both---acquire applies to the
           read part, and release to the write.
diff --git a/docs/devel/build-system.rst b/docs/devel/build-system.rst
index fa1c59d9fd8..d42045a2325 100644
--- a/docs/devel/build-system.rst
+++ b/docs/devel/build-system.rst
@@ -333,7 +333,7 @@ into each emulator:
 
 ``default-configs/targets/*.mak``
   These files mostly define symbols that appear in the ``*-config-target.h``
-  file for each emulator [#cfgtarget]_.  However, the ``TARGET_ARCH``
+  file for each emulator\ [#cfgtarget]_.  However, the ``TARGET_ARCH``
   and ``TARGET_BASE_ARCH`` will also be used to select the ``hw/`` and
   ``target/`` subdirectories that are compiled into each target.
 
diff --git a/docs/devel/loads-stores.rst b/docs/devel/loads-stores.rst
index ec627aa9c06..9471bac8599 100644
--- a/docs/devel/loads-stores.rst
+++ b/docs/devel/loads-stores.rst
@@ -95,7 +95,7 @@ guest CPU state in case of a guest CPU exception.  This is passed
 to ``cpu_restore_state()``.  Therefore the value should either be 0,
 to indicate that the guest CPU state is already synchronized, or
 the result of ``GETPC()`` from the top level ``HELPER(foo)``
-function, which is a return address into the generated code [#gpc]_.
+function, which is a return address into the generated code\ [#gpc]_.
 
 .. [#gpc] Note that ``GETPC()`` should be used with great care: calling
           it in other functions that are *not* the top level
diff --git a/docs/devel/maintainers.rst b/docs/devel/maintainers.rst
index 5c907d901cd..88a613ed74f 100644
--- a/docs/devel/maintainers.rst
+++ b/docs/devel/maintainers.rst
@@ -99,9 +99,9 @@ members of the QEMU community, you should make arrangements to attend
 a `KeySigningParty <https://wiki.qemu.org/KeySigningParty>`__ (for
 example at KVM Forum) or make alternative arrangements to have your
 key signed by an attendee. Key signing requires meeting another
-community member **in person** [#]_ so please make appropriate
+community member **in person**\ [#2020]_ so please make appropriate
 arrangements.
 
-.. [#] In recent pandemic times we have had to exercise some
+.. [#2020] In recent pandemic times we have had to exercise some
        flexibility here. Maintainers still need to sign their pull
        requests though.
diff --git a/docs/devel/migration/mapped-ram.rst b/docs/devel/migration/mapped-ram.rst
index d352b546e96..b08c2b433c4 100644
--- a/docs/devel/migration/mapped-ram.rst
+++ b/docs/devel/migration/mapped-ram.rst
@@ -44,7 +44,7 @@ Use-cases
 
 The mapped-ram feature was designed for use cases where the migration
 stream will be directed to a file in the filesystem and not
-immediately restored on the destination VM [#]_. These could be
+immediately restored on the destination VM\ [#alternatives]_. These could be
 thought of as snapshots. We can further categorize them into live and
 non-live.
 
@@ -70,7 +70,7 @@ mapped-ram in this scenario is portability since background-snapshot
 depends on async dirty tracking (KVM_GET_DIRTY_LOG) which is not
 supported outside of Linux.
 
-.. [#] While this same effect could be obtained with the usage of
+.. [#alternatives] While this same effect could be obtained with the usage of
        snapshots or the ``file:`` migration alone, mapped-ram provides
        a performance increase for VMs with larger RAM sizes (10s to
        100s of GiBs), specially if the VM has been stopped beforehand.
diff --git a/docs/specs/fw_cfg.rst b/docs/specs/fw_cfg.rst
index 5ad47a901c9..c353957e1d3 100644
--- a/docs/specs/fw_cfg.rst
+++ b/docs/specs/fw_cfg.rst
@@ -54,11 +54,11 @@ Data Register
 -------------
 
 * Read/Write (writes ignored as of QEMU v2.4, but see the DMA interface)
-* Location: platform dependent (IOport [#]_ or MMIO)
+* Location: platform dependent (IOport [#placement]_ or MMIO)
 * Width: 8-bit (if IOport), 8/16/32/64-bit (if MMIO)
 * Endianness: string-preserving
 
-.. [#]
+.. [#placement]
     On platforms where the data register is exposed as an IOport, its
     port number will always be one greater than the port number of the
     selector register. In other words, the two ports overlap, and can not
diff --git a/docs/specs/rapl-msr.rst b/docs/specs/rapl-msr.rst
index 1202ee89bee..901ce83bfa8 100644
--- a/docs/specs/rapl-msr.rst
+++ b/docs/specs/rapl-msr.rst
@@ -9,7 +9,7 @@ The consumption is reported via MSRs (model specific registers) like
 MSR_PKG_ENERGY_STATUS for the CPU package power domain. These MSRs are 64 bits
 registers that represent the accumulated energy consumption in micro Joules.
 
-Thanks to the MSR Filtering patch [#a]_ not all MSRs are handled by KVM. Some
+Thanks to the MSR Filtering patch\ [#a]_ not all MSRs are handled by KVM. Some
 of them can now be handled by the userspace (QEMU). It uses a mechanism called
 "MSR filtering" where a list of MSRs is given at init time of a VM to KVM so
 that a callback is put in place. The design of this patch uses only this
@@ -92,7 +92,7 @@ found by the sysconf system call. A typical value of clock ticks per second is
 package has 4 cores, 400 ticks maximum can be scheduled on all the cores
 of the package for a period of 1 second.
 
-The /proc/[pid]/stat [#b]_ is a sysfs file that can give the executed time of a
+The /proc/[pid]/stat\ [#b]_ is a sysfs file that can give the executed time of a
 process with the [pid] as the process ID. It gives the amount of ticks the
 process has been scheduled in userspace (utime) and kernel space (stime).
 
-- 
2.46.2


