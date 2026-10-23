Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC343606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 14:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=HmdTaM7S
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKG3L-0003JI-88; Fri, 23 Oct 2026 10:15:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xKG3G-0003Ie-1M
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 10:15:22 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xKG3E-0006Zh-7Z
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 10:15:21 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4a2072b9832so10141765e9.1
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 07:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792764918; x=1793369718; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=bHvg5vLtilEbH362SGfQ07XtLH6+Mu4m6qQdaRSRzq4=;
 b=HmdTaM7SYmjTVdNZbvMhLD8XX8Fed8uDBjoIkB8eieaSI/HQliKsqdyTnpoUoqRHjv
 DLRcoFDOyvcUbaHdHLjK1U+ZCAoPrceojHcLclqBMFWnqAWDTlOKAHoMiar908Qb8iYe
 sUF7F6zn/WRKHgRg9sxGrQnx0/A+VSoI4Tb52QK6AcMHuJ7prEYZqJoLKs9ECL96ReQW
 CniQaLGhhzbxbSZ2lsVKtrcOegBF0fs8+r9AgQmaAdAGWielAYvfdp9nSE8s5bwNQF90
 0XIHgtpNihjMmrr+RAu4p1WJVGc9QgmDzccbLNanZO1DJhMOBukU80kW4ppMKivKAEQr
 cX9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792764918; x=1793369718;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=bHvg5vLtilEbH362SGfQ07XtLH6+Mu4m6qQdaRSRzq4=;
 b=xaPjZNz5sWLKf0jtS2AYzdqLW4oTNVo8fsFdvFuFshL5NftKngHk23Hos/VzekX+ml
 +GMTm1lO8LbHwGGvvgwAbqBX9B4yNTsJqYsPXIBouIZIx701RgWdp1B9ZaBafW2olMy2
 JEqigP0EV18AA1hvTacAvKTuy6Wf8SjsP0RNmK4uN3b5Yh5C93eyyWTZzE45LzBWCLOV
 r/sh30iyPOnZRafMmotR8mImeh7XFhgpBCOgZz2CXV+75Wc8ox6wb89reCJD16PkvzFJ
 pX4j7cuD136+OqYX5aoB3nTbVmU4yj6xzOJJTGs7FOto13YlNMrytS8mInGHwYXEVnEz
 kbSQ==
X-Gm-Message-State: AFq9FYJ3sLs8uR4rA6YJ12u9ktL45TKUiKIxYFp5JELTNiMR4SWsgOy2
 7FHavQWmgOMmINWj56zYbAyYi4r+nPFP0Pl3xPIcF9o+aEeqbGZL2Ja3Aj6c0g83w9QvJFRvdIp
 5Dr5drX4=
X-Gm-Gg: AYBFou1ryYHVdo/vdgKZ1RZrUy6OQeOUvFnyfv8Vat3EYFExgmoBJUIkNg0C3REd9tT
 hbX27DmWKA1r3w7EClUryLbyk1j8gbLw/3uT74atA6xRPhUTbl+OFqFbZX4w6afI0I3x37Uq1MI
 wnjkoR5js79GvKS2stBgdGEWK8D/wtr1TS2ypWcr21eauZKcokNi0Phd3lcH8UkXfDcH8UhqxsO
 iie2wD0FofnNQrlIPmF1uTG2nnjqWZIpYicqpe5CAN1PrXZ5tSo3XkHklAiR4urzJiY9ApvVjlP
 hoxWcmEwbYhmnlNZjK4k60inOEhfK/GVG4PWKFiekKehl+PkSPATYwk8P7RcBql9E5eyGnx3C4f
 MbT3nfc3sx3sG84jCsWe8eW+1m/idFsBEgKI8dgQT44kd3lEO4fwSxiBlFsnDsAyrJn+SgdtM2F
 83lKiLtHQ+xMNq0AqFi2n3v7CWW5R2vdRurHXBwogJdOHsq3WMPcEtugZ2xapQbEqS+3hLtwsaQ
 hM1HxC59w4uGVcFIXe3PEakZQixRXs7gC5cG5fLlzXBSwJBymh5eq3sZ/KJ7Smb7TAHzzxcUVKz
 jHAu1OcAZj1CKwUpS8bfIhOBfmvD5EIDJrZftLZXNdn7oVhFcHlJljslZ8Qm
X-Received: by 2002:a05:600c:6289:b0:49e:6581:7baf with SMTP id
 5b1f17b1804b1-4a211bf040emr41131275e9.2.1792764918504; 
 Fri, 23 Oct 2026 07:15:18 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a2fe31a7a4sm1310675e9.0.2026.10.23.07.15.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 07:15:17 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/16] target/arm: Deprecate using named CPU models with KVM
Date: Fri, 23 Oct 2026 15:14:55 +0100
Message-ID: <20261023141503.1397009-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261023141503.1397009-1-peter.maydell@linaro.org>
References: <20261023141503.1397009-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Currently when using KVM on Arm, the normal thing is to use either
the 'host' or 'max' CPU types, both of which give the guest the same
CPU as the host.  We also for legacy reasons allow 'cortex-a53' and
'cortex-a57' CPU types, which will only work when the host CPU is
exactly that matching CPU.  This is because the original idea of the
KVM ABI was that userspace would request a particular CPU type by
setting the target field in the KVM_ARM_VCPU_INIT ioctl to an
appropriate KVM_ARM_TARGET_* constant.  However, it quickly became
clear that this was a bad idea, and now everything uses
KVM_ARM_TARGET_GENERIC_V8; the tiny number of existing CPU-specific
target values behave identically to GENERIC_V8 except that they will
only work if the host CPU matches them.

Future support for "show the KVM guest a CPU type that's not
identical to the host" is going to work by telling it different ID
register values.  Real Cortex-A53 and A57 CPUs are now all over a
decade old and not in widespread use.  Deprecate the ability to use
'-cpu cortex-a53' and '-cpu cortex-a57' with KVM, to get rid of this
odd legacy corner and open up the opportunity in future to support
named CPU types via ID register settings if we want that.

For any situation where the cortex-a53 and cortex-a57 CPU types
currently work with KVM, '-cpu host' or '-cpu max' will have
identical behaviour.  (Though note that if you are using "KVM, but
fall back to TCG" then the fallback under TCG will be different.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Khushit Shah <khushit.shah@nutanix.com>
Message-id: 20261013105147.1070641-1-peter.maydell@linaro.org
---
 docs/about/deprecated.rst | 13 +++++++++++++
 target/arm/kvm.c          |  7 +++++++
 2 files changed, 20 insertions(+)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index ccbc4219497..153fe118151 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -234,6 +234,19 @@ in the QEMU object model anymore. ``Sun-UltraSparc-IIIi+`` and
 but for consistency these will get removed in a future release, too.
 Use ``Sun-UltraSparc-IIIi-plus`` and ``Sun-UltraSparc-IV-plus`` instead.
 
+``cortex-a53`` and ``cortex-a57`` CPU names with KVM on Arm (since 11.2)
+''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
+
+QEMU currently allows the CPU name to be set to ``cortex-a53`` or
+``cortex-a57`` when using KVM; this is identical to using ``host`` or
+``max``, but it will only work when the host CPU is a Cortex-A53 or
+Cortex-A57.  These CPUs are now over 10 years old, and the ability to
+use the named CPU type like this is part of a legacy corner of the KVM
+API, which doesn't work with any other host CPU types. Using these CPU
+names with KVM enabled is deprecated; use ``host`` or ``max`` instead,
+which will have identical behaviour on the hosts where using
+``cortex-a53`` or ``cortex-a57`` works.
+
 System emulator machines
 ------------------------
 
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 3d905f8565d..de09d63d2e3 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -2015,6 +2015,13 @@ int kvm_arch_init_vcpu(CPUState *cs)
         return -EINVAL;
     }
 
+    if (cpu->kvm_target == QEMU_KVM_ARM_TARGET_CORTEX_A53 ||
+        cpu->kvm_target == QEMU_KVM_ARM_TARGET_CORTEX_A57) {
+        warn_report_once("Using the cortex-a53 and cortex-a57 CPU types "
+                         "with KVM is deprecated. Use the max or host CPU "
+                         "types instead.");
+    }
+
     qemu_add_vm_change_state_handler(kvm_arm_vm_state_change, cpu);
 
     /* Determine init features for this CPU */
-- 
2.43.0


