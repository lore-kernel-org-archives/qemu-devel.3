Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20DC7D24470
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2024 17:15:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1szJ4Y-0001DV-Mt; Fri, 11 Oct 2024 13:05:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1szJ4Q-0000hD-9F
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 13:04:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1szHeL-0007Hj-Lv
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 11:33:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728660832;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k/34HEPxRiOlQhIJ2aUohMKJaHMgtsEfmqX+JGgRPwc=;
 b=IaIOByxs1qNAEFQPGVN1MqW6C9Q7aPk0GZYLcEUze4NuSp/qWGJ+oemXEqmNyuJH/XdZE0
 bjxHhNfV2d/+E0HeLFm95B5HCWasH1Fpwo+Mr1m20X6e0WU9d/2w+DV2Lr1bm0zrG6aLkF
 cbj3ZTC2xggU5GM8xDRuJMfgPAwkWLU=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-232-FuhM2pG5OG6Y9spN36Rntg-1; Fri, 11 Oct 2024 11:33:51 -0400
X-MC-Unique: FuhM2pG5OG6Y9spN36Rntg-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a994cd8089aso159198666b.2
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2024 08:33:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728660829; x=1729265629;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k/34HEPxRiOlQhIJ2aUohMKJaHMgtsEfmqX+JGgRPwc=;
 b=UfWmTlCy99pys0+21Do/qr+nkYwUehrAU2MTMiLtS80qUEowveMi27LZ6nzDbgDfCb
 695YxiZAeyLAc57JwdLD+KbctICx+wZOam92je1ZKR0npqSCCM99Qqfn1+y2emsdYO0Z
 phak1aT4YwgjOZ4Glsl6Dx2XpaNBrx9X/0WXARKgW9Qob/cVeCqe0qkN0t8CVFBT4C+H
 +iQwrniActGM1G8Q8VdYNFyPG1RG0ksjxIZOuDEzQT47SXsVWNNVFORRJSQjw3ZSWV/7
 DF5NYF73LJZqrq2GKzgnuv9PZ9i0px4zEkb3FTv8dqOuRyr0CUnUiN5Gc5a6gatBARHM
 uo5g==
X-Gm-Message-State: AOJu0Yy7YH+PZ98SwQhdqKDcqYEmOmNerDDuR1d6cfE137LYXsyGh/OG
 I/umxQKnMX6sW+HO4Jcp2L8W6bcoFqfQjSQmPod17ZbtsDZTAy+SaKrAKTTb94Mgnj9cUQTPqic
 55dzhLaHhev0busPxVzn8Hq0z70h7NCU+XJ+16uU7w4OUMxulQ4ZSRTCmYaKgzL+/c14hX8xux8
 WkmDDDAyhndwfoKO2RHJMdERSDPKgYF13P5sCgqO0=
X-Received: by 2002:a17:907:7b8a:b0:a99:415b:7d1e with SMTP id
 a640c23a62f3a-a99e3e4c265mr6101566b.41.1728660828027; 
 Fri, 11 Oct 2024 08:33:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdDmioOmse+Xksu5s4PMLuk62BtLgB+dqxrylnVy6ltU08L233gZPW0uj02qZfoUtC4Zv2RQ==
X-Received: by 2002:a17:907:7b8a:b0:a99:415b:7d1e with SMTP id
 a640c23a62f3a-a99e3e4c265mr6098366b.41.1728660827500; 
 Fri, 11 Oct 2024 08:33:47 -0700 (PDT)
Received: from avogadro.local ([151.81.124.37])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a99a80c02b9sm223146666b.138.2024.10.11.08.33.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2024 08:33:46 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL v3 18/18] docs: use consistent markup for footnotes
Date: Fri, 11 Oct 2024 17:32:26 +0200
Message-ID: <20241011153227.81770-19-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241011153227.81770-1-pbonzini@redhat.com>
References: <20241011153227.81770-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.15,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Unfortunately, the definition of the footnote syntax requires
the author to use the awkward escaped space "\ " in the really common
case of "footnote marker at end of word or sentence"; and in fact the rST
documentation's examples of footnote syntax contain only artificial
examples that do *not* use the syntax.  This resulted in ugly rendering
of footnotes throughout QEMU's documentation.  Ensure the space is escaped
whenever the footnote must attach to the preceding word, and also use
a named reference for clarity.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/devel/atomics.rst              | 6 +++---
 docs/devel/build-system.rst         | 2 +-
 docs/devel/loads-stores.rst         | 2 +-
 docs/devel/maintainers.rst          | 4 ++--
 docs/devel/migration/mapped-ram.rst | 4 ++--
 docs/specs/fw_cfg.rst               | 4 ++--
 6 files changed, 11 insertions(+), 11 deletions(-)

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
index 5ad47a901c9..31ae31576b1 100644
--- a/docs/specs/fw_cfg.rst
+++ b/docs/specs/fw_cfg.rst
@@ -54,11 +54,11 @@ Data Register
 -------------
 
 * Read/Write (writes ignored as of QEMU v2.4, but see the DMA interface)
-* Location: platform dependent (IOport [#]_ or MMIO)
+* Location: platform dependent (IOport\ [#placement]_ or MMIO)
 * Width: 8-bit (if IOport), 8/16/32/64-bit (if MMIO)
 * Endianness: string-preserving
 
-.. [#]
+.. [#placement]
     On platforms where the data register is exposed as an IOport, its
     port number will always be one greater than the port number of the
     selector register. In other words, the two ports overlap, and can not
-- 
2.46.2


