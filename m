Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E4A0C27C53
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 13:12:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE7Tv-0000Dz-SZ; Mon, 03 Jun 2024 09:12:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sE7Tu-0000DH-CC
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 09:12:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sE7Tp-0005mL-IX
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 09:12:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717420324;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bAbTQiE2UullwqM571jhJ789C54wVSiU4cOvdft1ch8=;
 b=DuE+ZV1wvv/6iu+YYdeVjPLhXF6vCzprK7DLs2qnIUJ6tCr1DOcnAtBvX63LUXT713lqY+
 79J2tHcSZYSyY5pU2eiUptOWs/T3+iSNdFPDGlPe4uvmjLOQljYe7ZKAnlwDmW2jInkXul
 gKn4zTdEde0VnuP4ORo94JD1ERtK3uY=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-452-qChUGvWBMHqB6xO4IPviiQ-1; Mon, 03 Jun 2024 09:11:57 -0400
X-MC-Unique: qChUGvWBMHqB6xO4IPviiQ-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a68ea01c455so63924366b.0
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 06:11:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717420316; x=1718025116;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bAbTQiE2UullwqM571jhJ789C54wVSiU4cOvdft1ch8=;
 b=oYMGBs24wfdOa4Tme2dX4W8swjRKXef/c1lV0yJ1iKqwal0K8SwlhHCNNToKuLccdj
 yk9ExfbMmkc4MMjQRtyYCF2qxOI/tpPsfMhzHLM93tKMIRFOltXSfoQh4EK/TRM7264V
 JpnXE/L9ir0sX/gjAsUWRED7gLKyvn+SnKa4PnFG3+F9TjdoAqn5izWf6w4P13HOUzJh
 ZfVBfH3MtKA0wxSCHyJzZSeuOLSzn6gPfu/p4vfcryQPzl/EFSAwL5JRocSIJQb0L0wW
 t8IjxwpvyhKDMg3CAeIrpY613DSYPFh5HINXb9U2Ez6yXwXbhYduMYEkd266/8ll8LUU
 ZT9w==
X-Gm-Message-State: AOJu0YyK1J+Wf1k7NJRWCNxkpxnSWol2ylECxpAx+goDaUVdq6L3cM4l
 UCpA38yQIHgO65So+YCOPa8Ki4fBy859HrpEvtxI+htpGTSm5/vI8lfwqbo5mj+FGfOlV6hj2aJ
 4hdJe23KTbm0WmIFNEWKNsxEG1Ockc+67p3xwKZ58hkww1dfK8P7dw2qUu1yrPlJ6tpHpb88in9
 Ier0pIqC2usMikDLfzOGvG9tfYYN+P3uwuKUih
X-Received: by 2002:a17:907:6d1d:b0:a68:c721:1c7a with SMTP id
 a640c23a62f3a-a68c7212bc9mr456252366b.22.1717420316158; 
 Mon, 03 Jun 2024 06:11:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLkjYtdrxqgKd/MdJGvlIQxm30fXy+bSIuDybsGqCFgGfPUnG4wqgotyeFM6KqlIRI+xVN5Q==
X-Received: by 2002:a17:907:6d1d:b0:a68:c721:1c7a with SMTP id
 a640c23a62f3a-a68c7212bc9mr456248366b.22.1717420315446; 
 Mon, 03 Jun 2024 06:11:55 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a68e007620csm288532066b.91.2024.06.03.06.11.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 06:11:54 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com,
	cohuck@redhat.com
Subject: [PATCH 4/4] update-linux-headers: import linux/kvm_para.h header
Date: Mon,  3 Jun 2024 15:11:41 +0200
Message-ID: <20240603131141.834241-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240603131141.834241-1-pbonzini@redhat.com>
References: <20240603131141.834241-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Right now QEMU is importing arch/x86/include/uapi/asm/kvm_para.h
because it includes definitions for kvmclock and for KVM CPUID
bits.  However, other definitions for KVM hypercall values and return
codes are included in include/uapi/linux/kvm_para.h and they will be
used by SEV-SNP.

To ensure that it is possible to include both <linux/kvm_para.h> and
"standard-headers/asm-x86/kvm_para.h" without conflicts, include
linux/kvm_para.h as a portable header too, and forward linux-headers/
files to those in include/standard-headers.  Note that <linux/kvm_para.h>
will include architecture-specific definitions as well, but
"standard-headers/linux/kvm_para.h" will not because it can be used in
architecture-independent files.

This could easily be extended to other architectures, but right now
they do not need any symbol in their specific kvm_para.h files.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/standard-headers/linux/kvm_para.h | 38 +++++++++++++++++++++++
 linux-headers/asm-x86/kvm_para.h          |  1 +
 linux-headers/linux/kvm_para.h            |  2 ++
 scripts/update-linux-headers.sh           | 22 ++++++++++++-
 4 files changed, 62 insertions(+), 1 deletion(-)
 create mode 100644 include/standard-headers/linux/kvm_para.h
 create mode 100644 linux-headers/asm-x86/kvm_para.h
 create mode 100644 linux-headers/linux/kvm_para.h

diff --git a/include/standard-headers/linux/kvm_para.h b/include/standard-headers/linux/kvm_para.h
new file mode 100644
index 00000000000..015c1663021
--- /dev/null
+++ b/include/standard-headers/linux/kvm_para.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef __LINUX_KVM_PARA_H
+#define __LINUX_KVM_PARA_H
+
+/*
+ * This header file provides a method for making a hypercall to the host
+ * Architectures should define:
+ * - kvm_hypercall0, kvm_hypercall1...
+ * - kvm_arch_para_features
+ * - kvm_para_available
+ */
+
+/* Return values for hypercalls */
+#define KVM_ENOSYS		1000
+#define KVM_EFAULT		EFAULT
+#define KVM_EINVAL		EINVAL
+#define KVM_E2BIG		E2BIG
+#define KVM_EPERM		EPERM
+#define KVM_EOPNOTSUPP		95
+
+#define KVM_HC_VAPIC_POLL_IRQ		1
+#define KVM_HC_MMU_OP			2
+#define KVM_HC_FEATURES			3
+#define KVM_HC_PPC_MAP_MAGIC_PAGE	4
+#define KVM_HC_KICK_CPU			5
+#define KVM_HC_MIPS_GET_CLOCK_FREQ	6
+#define KVM_HC_MIPS_EXIT_VM		7
+#define KVM_HC_MIPS_CONSOLE_OUTPUT	8
+#define KVM_HC_CLOCK_PAIRING		9
+#define KVM_HC_SEND_IPI		10
+#define KVM_HC_SCHED_YIELD		11
+#define KVM_HC_MAP_GPA_RANGE		12
+
+/*
+ * hypercalls use architecture specific
+ */
+
+#endif /* __LINUX_KVM_PARA_H */
diff --git a/linux-headers/asm-x86/kvm_para.h b/linux-headers/asm-x86/kvm_para.h
new file mode 100644
index 00000000000..1d3e0e0b07a
--- /dev/null
+++ b/linux-headers/asm-x86/kvm_para.h
@@ -0,0 +1 @@
+#include "standard-headers/asm-x86/kvm_para.h"
diff --git a/linux-headers/linux/kvm_para.h b/linux-headers/linux/kvm_para.h
new file mode 100644
index 00000000000..6a1e672259c
--- /dev/null
+++ b/linux-headers/linux/kvm_para.h
@@ -0,0 +1,2 @@
+#include "standard-headers/linux/kvm_para.h"
+#include <asm/kvm_para.h>
diff --git a/scripts/update-linux-headers.sh b/scripts/update-linux-headers.sh
index 7b39cc426e0..e579c348959 100755
--- a/scripts/update-linux-headers.sh
+++ b/scripts/update-linux-headers.sh
@@ -63,6 +63,7 @@ cp_portable() {
                                      -e 'linux/kernel' \
                                      -e 'linux/sysinfo' \
                                      -e 'asm/setup_data.h' \
+                                     -e 'asm/kvm_para.h' \
                                      > /dev/null
     then
         echo "Unexpected #include in input file $f".
@@ -70,6 +71,15 @@ cp_portable() {
     fi
 
     header=$(basename "$f");
+
+    if test -z "$arch"; then
+        # Let users of include/standard-headers/linux/ headers pick the
+        # asm-* header that they care about
+        arch_cmd='/<asm\/\([^>]*\)>/d'
+    else
+        arch_cmd='s/<asm\/\([^>]*\)>/"standard-headers\/asm-'$arch'\/\1"/'
+    fi
+
     sed -e 's/__aligned_u64/__u64 __attribute__((aligned(8)))/g' \
         -e 's/__u\([0-9][0-9]*\)/uint\1_t/g' \
         -e 's/u\([0-9][0-9]*\)/uint\1_t/g' \
@@ -78,7 +88,7 @@ cp_portable() {
         -e 's/__be\([0-9][0-9]*\)/uint\1_t/g' \
         -e 's/"\(input-event-codes\.h\)"/"standard-headers\/linux\/\1"/' \
         -e 's/<linux\/\([^>]*\)>/"standard-headers\/linux\/\1"/' \
-        -e 's/<asm\/\([^>]*\)>/"standard-headers\/asm-'$arch'\/\1"/' \
+        -e "$arch_cmd" \
         -e 's/__bitwise//' \
         -e 's/__attribute__((packed))/QEMU_PACKED/' \
         -e 's/__inline__/inline/' \
@@ -158,7 +168,12 @@ EOF
         cp "$hdrdir/include/asm/unistd_32.h" "$output/linux-headers/asm-x86/"
         cp "$hdrdir/include/asm/unistd_x32.h" "$output/linux-headers/asm-x86/"
         cp "$hdrdir/include/asm/unistd_64.h" "$output/linux-headers/asm-x86/"
+
         cp_portable "$hdrdir/include/asm/kvm_para.h" "$output/include/standard-headers/asm-$arch"
+        cat <<EOF >$output/linux-headers/asm-$arch/kvm_para.h
+#include "standard-headers/asm-$arch/kvm_para.h"
+EOF
+
         # Remove everything except the macros from bootparam.h avoiding the
         # unnecessary import of several video/ist/etc headers
         sed -e '/__ASSEMBLY__/,/__ASSEMBLY__/d' \
@@ -208,6 +223,10 @@ if [ -d "$linux/LICENSES" ]; then
     done
 fi
 
+cat <<EOF >$output/linux-headers/linux/kvm_para.h
+#include "standard-headers/linux/kvm_para.h"
+#include <asm/kvm_para.h>
+EOF
 cat <<EOF >$output/linux-headers/linux/virtio_config.h
 #include "standard-headers/linux/virtio_config.h"
 EOF
@@ -230,6 +249,7 @@ for i in "$hdrdir"/include/linux/*virtio*.h \
          "$hdrdir/include/linux/ethtool.h" \
          "$hdrdir/include/linux/const.h" \
          "$hdrdir/include/linux/kernel.h" \
+         "$hdrdir/include/linux/kvm_para.h" \
          "$hdrdir/include/linux/vhost_types.h" \
          "$hdrdir/include/linux/sysinfo.h"; do
     cp_portable "$i" "$output/include/standard-headers/linux"
-- 
2.45.1


