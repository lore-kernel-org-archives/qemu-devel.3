Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B57ACAC5B8
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 17:21:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4Mvw-0001Iq-9a; Thu, 02 Oct 2025 13:17:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v4Mvj-00019J-EG
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 13:17:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v4MvU-0005tX-E9
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 13:17:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759425421;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J1OH4sSKaFwfwNiZBlD0h7Ft/6d67CyiMZ16CkYbEFs=;
 b=IRodky5fw0SZSAX+XHrUFiTQHlBG+5biTKZoKKUiaJ+dSVFjlZxBnBG7/UNRMxXhl7jvcM
 60VmFupkbXe1ZAfy2tY8yOyexHsM9d5oyxh76ANhdxHfBF0zo6aVxOziaL9PshMnFAYvO6
 nykzr+rrv5DGqd3wP2RS2JaoJaOGShA=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-176-sQFvHz_qNfemfuQTnlVY9A-1; Thu, 02 Oct 2025 13:17:00 -0400
X-MC-Unique: sQFvHz_qNfemfuQTnlVY9A-1
X-Mimecast-MFC-AGG-ID: sQFvHz_qNfemfuQTnlVY9A_1759425419
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-b3d73e1ed87so165439266b.1
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 10:17:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759425417; x=1760030217;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J1OH4sSKaFwfwNiZBlD0h7Ft/6d67CyiMZ16CkYbEFs=;
 b=AAQoPng/R2nMHkuMTgV1FWkLuxRuqaBVz4lrOhm8Ey9Sosj+EkJHkUX02g5a65xJZA
 BOpNHi5heWNrIOAVS7gtQQwU9MQHLkzofK2nOQH0zhiB3gHRbh/OttmZx0gbVQs544Yf
 UT2JYGzb+jEY2Gg9jHWa5XjJWhEh+1S4+us864RqgCEaAkDQfR6nBLeQR0mBgrZ/44Vp
 X3D1qK8lM7dgIyOf3kDxw9nlW7WkGA00tJpc/ZVl0rUTwcuN23f0qgE08Y2QHQ5tOJDv
 r+xBn0zsGv7kSxYbltuQPaZlto1Jcng0iQc2dbF6kIuo9uGwaSCRyPsOKiIDmEs3MMLo
 zpUA==
X-Gm-Message-State: AOJu0Yw+/MpqbXon1yUAUgsau3HQa+G/XW49s0KSneZKrQzGjZ1C82Yo
 XRgdXJuPuZNSs+pQ78QiY/NVlDhHXX/xzjmSUjZiYuF+yFPUCW1GU3XfQuNAsEgbntBWvsM4vjW
 ESrk//1971lc+yfDoYG11PbTShSOY/jRraEymlexTK4YLyCimF5hSPjpRGGDhaLYaZSzqNIouSr
 wiGWohiYZwnFMVTsAtc2GKeBDPdXiIM5Ft2pzTGXwJ
X-Gm-Gg: ASbGncu/uDfCe3H39swO2N/FNNwZw63s7X++wH36nNbgq+FLYHbr5t5RU27cbcr8rqG
 LIRBdHNlWGdydMr9vNfC3lffkuW9oFtAj7WdgwmuzblxS3ZflfQYL1ohY8tpSkWM/0QOi2nPZJM
 hkct+mi7KWlHgIk0OJan3dsybAdg7TuiKHC2S6/gdunJX9pNx+QJtKGqm0eZugllHVjX2yF4381
 cU2wqUcQmcML6IQl9Ew6jB5a2H4YDl+t9fIzNtXGkEYRPOIzVggqCtIlfpc2x109l7qV+VQIy38
 hZT6N28E8paqQVhzJQ0EE4fm+H6mdP/MXXl5hMtH59TJgJtIKhkHfGZNt6X5m/CVmvovPbK9Ofd
 K5Mk9xLynmJMbEcDzvPFgPtROleSDLlf/Wzx4qBQQEqyvuRGp
X-Received: by 2002:a17:907:96a9:b0:b04:48b5:6ea5 with SMTP id
 a640c23a62f3a-b49c3445267mr27228266b.17.1759425417483; 
 Thu, 02 Oct 2025 10:16:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHdWJuXxbPKZ93H/cEwJfTTbysPU9vS7uhMRs/p/2oc7bMkla04eaIi0TeHibVZ2X8K3r8h1w==
X-Received: by 2002:a17:907:96a9:b0:b04:48b5:6ea5 with SMTP id
 a640c23a62f3a-b49c3445267mr27224866b.17.1759425416999; 
 Thu, 02 Oct 2025 10:16:56 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.91.106])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b48652aa035sm242383766b.15.2025.10.02.10.16.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Oct 2025 10:16:55 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, magnus.kulke@linux.microsoft.com, wei.liu@kernel.org,
 Magnus Kulke <magnuskulke@linux.microsoft.com>
Subject: [PATCH 26/27] docs: Add mshv to documentation
Date: Thu,  2 Oct 2025 19:15:35 +0200
Message-ID: <20251002171536.1460049-27-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251002171536.1460049-1-pbonzini@redhat.com>
References: <20251002171536.1460049-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

From: Magnus Kulke <magnuskulke@linux.microsoft.com>

Added mshv to the list of accelerators in doc text.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
Link: https://lore.kernel.org/r/20250916164847.77883-27-magnuskulke@linux.microsoft.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/about/build-platforms.rst |  2 +-
 docs/devel/codebase.rst        |  2 +-
 docs/glossary.rst              |  7 +++----
 docs/system/introduction.rst   |  3 +++
 qemu-options.hx                | 16 ++++++++--------
 5 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/docs/about/build-platforms.rst b/docs/about/build-platforms.rst
index 798cb4631df..fc2743658d4 100644
--- a/docs/about/build-platforms.rst
+++ b/docs/about/build-platforms.rst
@@ -53,7 +53,7 @@ Those hosts are officially supported, with various accelerators:
    * - SPARC
      - tcg
    * - x86
-     - hvf (64 bit only), kvm, nvmm, tcg, whpx (64 bit only), xen
+     - hvf (64 bit only), mshv (64 bit only), kvm, nvmm, tcg, whpx (64 bit only), xen
 
 Other host architectures are not supported. It is possible to build QEMU system
 emulation on an unsupported host architecture using the configure
diff --git a/docs/devel/codebase.rst b/docs/devel/codebase.rst
index 2a3143787a6..69d88271178 100644
--- a/docs/devel/codebase.rst
+++ b/docs/devel/codebase.rst
@@ -48,7 +48,7 @@ yet, so sometimes the source code is all you have.
 * `accel <https://gitlab.com/qemu-project/qemu/-/tree/master/accel>`_:
   Infrastructure and architecture agnostic code related to the various
   `accelerators <Accelerators>` supported by QEMU
-  (TCG, KVM, hvf, whpx, xen, nvmm).
+  (TCG, KVM, hvf, whpx, xen, nvmm, mshv).
   Contains interfaces for operations that will be implemented per
   `target <https://gitlab.com/qemu-project/qemu/-/tree/master/target>`_.
 * `audio <https://gitlab.com/qemu-project/qemu/-/tree/master/audio>`_:
diff --git a/docs/glossary.rst b/docs/glossary.rst
index 4fa044bfb6e..5c201b80369 100644
--- a/docs/glossary.rst
+++ b/docs/glossary.rst
@@ -12,7 +12,7 @@ Accelerator
 
 A specific API used to accelerate execution of guest instructions. It can be
 hardware-based, through a virtualization API provided by the host OS (kvm, hvf,
-whpx, ...), or software-based (tcg). See this description of `supported
+whpx, mshv, ...), or software-based (tcg). See this description of `supported
 accelerators<Accelerators>`.
 
 Board
@@ -101,9 +101,8 @@ manage a virtual machine. QEMU is a virtualizer, that interacts with various
 hypervisors.
 
 In the context of QEMU, an hypervisor is an API, provided by the Host OS,
-allowing to execute virtual machines. Linux implementation is KVM (and supports
-Xen as well). For MacOS, it's HVF. Windows defines WHPX. And NetBSD provides
-NVMM.
+allowing to execute virtual machines.  Linux provides a choice of KVM, Xen
+or MSHV; MacOS provides HVF; Windows provides WPHX; NetBSD provides NVMM.
 
 .. _machine:
 
diff --git a/docs/system/introduction.rst b/docs/system/introduction.rst
index 4cd46b5b8f9..9c57523b6c2 100644
--- a/docs/system/introduction.rst
+++ b/docs/system/introduction.rst
@@ -23,6 +23,9 @@ Tiny Code Generator (TCG) capable of emulating many CPUs.
   * - Xen
     - Linux (as dom0)
     - Arm, x86
+  * - MSHV
+    - Linux (as dom0)
+    - x86
   * - Hypervisor Framework (hvf)
     - MacOS
     - x86 (64 bit only), Arm (64 bit only)
diff --git a/qemu-options.hx b/qemu-options.hx
index 075f4be2e3e..56db4bf9e5e 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -28,7 +28,7 @@ DEF("machine", HAS_ARG, QEMU_OPTION_machine, \
     "-machine [type=]name[,prop[=value][,...]]\n"
     "                selects emulated machine ('-machine help' for list)\n"
     "                property accel=accel1[:accel2[:...]] selects accelerator\n"
-    "                supported accelerators are kvm, xen, hvf, nvmm, whpx or tcg (default: tcg)\n"
+    "                supported accelerators are kvm, xen, hvf, nvmm, whpx, mshv or tcg (default: tcg)\n"
     "                vmport=on|off|auto controls emulation of vmport (default: auto)\n"
     "                dump-guest-core=on|off include guest memory in a core dump (default=on)\n"
     "                mem-merge=on|off controls memory merge support (default: on)\n"
@@ -66,10 +66,10 @@ SRST
 
     ``accel=accels1[:accels2[:...]]``
         This is used to enable an accelerator. Depending on the target
-        architecture, kvm, xen, hvf, nvmm, whpx or tcg can be available.
-        By default, tcg is used. If there is more than one accelerator
-        specified, the next one is used if the previous one fails to
-        initialize.
+        architecture, kvm, xen, hvf, nvmm, whpx, mshv or tcg can be
+        available. By default, tcg is used. If there is more than one
+        accelerator specified, the next one is used if the previous one
+        fails to initialize.
 
     ``vmport=on|off|auto``
         Enables emulation of VMWare IO port, for vmmouse etc. auto says
@@ -226,7 +226,7 @@ ERST
 
 DEF("accel", HAS_ARG, QEMU_OPTION_accel,
     "-accel [accel=]accelerator[,prop[=value][,...]]\n"
-    "                select accelerator (kvm, xen, hvf, nvmm, whpx or tcg; use 'help' for a list)\n"
+    "                select accelerator (kvm, xen, hvf, nvmm, whpx, mshv or tcg; use 'help' for a list)\n"
     "                igd-passthru=on|off (enable Xen integrated Intel graphics passthrough, default=off)\n"
     "                kernel-irqchip=on|off|split controls accelerated irqchip support (default=on)\n"
     "                kvm-shadow-mem=size of KVM shadow MMU in bytes\n"
@@ -241,8 +241,8 @@ DEF("accel", HAS_ARG, QEMU_OPTION_accel,
 SRST
 ``-accel name[,prop=value[,...]]``
     This is used to enable an accelerator. Depending on the target
-    architecture, kvm, xen, hvf, nvmm, whpx or tcg can be available. By
-    default, tcg is used. If there is more than one accelerator
+    architecture, kvm, xen, hvf, nvmm, whpx, mshv or tcg can be available.
+    By default, tcg is used. If there is more than one accelerator
     specified, the next one is used if the previous one fails to
     initialize.
 
-- 
2.51.0


