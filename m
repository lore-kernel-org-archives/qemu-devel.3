Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DCF5C48BC3
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 16:29:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcpTG-0002V0-3b; Wed, 21 Feb 2024 11:29:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rcpTE-0002UV-LX
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 11:29:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rcpTC-0000yi-2b
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 11:29:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708532955;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=2FUR5ACAYE7AoZwFKF5eHjz0RAbRxzO8XmgoE6ZZ/AI=;
 b=MPWHe5IFIXmGpcTMApTsIRO7mBJdb0cMUXVcKiJXCMUSLuP3G9+mXu/Q61G5Ahf3m6L0oy
 DVeQdyDLbGuhvmvLjX2ImcUEWKR3TFH2TXns7AVDBAR16pdYc8LzG3xSRD+u5fEqPKr9Gk
 4LTcYWKdoseOCuKH4BmvBKGvrRsIFzc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-210-L6KLWiKnNHOlCgBlmv8GTw-1; Wed, 21 Feb 2024 11:29:13 -0500
X-MC-Unique: L6KLWiKnNHOlCgBlmv8GTw-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-410d0660929so34025075e9.0
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 08:29:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708532951; x=1709137751;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2FUR5ACAYE7AoZwFKF5eHjz0RAbRxzO8XmgoE6ZZ/AI=;
 b=DufjsbCZbepwcRNYRrDKtmngID3ja4lJSr36Z2vEqcC83T7DyNsNPuAw1B/1TJVMSn
 edyoW8Cqto0cfQrAG6y/UTw8gbx3PdGugoyOyD5ZGm/yP35jicNaKMAe2fcjT3DvpVbl
 YHVnoZT6UlVpNOksQvoUnL3t79qTy93BSZKfi5LdIBxsLUIDhgJtKCpySXJrg0BRd7Qi
 vAKEOg8AolyZt6S0VYNoz21lvCokcvflvIRXm9OOWZMYCmQ6UmXOCrqLwEOfxUBYPfp+
 LuTKsP12XZz2kqnPLSCDQBFmBnop8Ziufvoj8GxJDCWPi1RIDKgAn0xBgor7OBH3ns26
 1RBQ==
X-Gm-Message-State: AOJu0YxFZA0HllIdFrWjr9B/huRb6ZNgl00326td4Mwhqu6vMfCreRWF
 g+RwMkKVr3LcZd/5oMHgm02DpOIJRTd8SBNZs67HTui7wvPKCNLyQlJEN3C/G+ufeCCI/yWhbgv
 CsFMiUui2oVrlD4ypGIyvA2qGCyxDbTrC0PwbqiYrIZjITQU0XpcS2RYiH4WZlyFoTl+mXW5xg6
 iyy08fjvnqKna2x/kgaYYZtcev2EIwCuE9ekGi
X-Received: by 2002:a05:600c:1e25:b0:412:77b5:da2c with SMTP id
 ay37-20020a05600c1e2500b0041277b5da2cmr5228wmb.6.1708532951810; 
 Wed, 21 Feb 2024 08:29:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHtx2C7SSpmMQ13EGHWkopdbQLmvOjlJeGO8n/kWtxYGWBuNesZYrtDyfYNDqHoEDFeZC27oA==
X-Received: by 2002:a05:600c:1e25:b0:412:77b5:da2c with SMTP id
 ay37-20020a05600c1e2500b0041277b5da2cmr5204wmb.6.1708532951405; 
 Wed, 21 Feb 2024 08:29:11 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 jj2-20020a05600c6a0200b004126732390asm2982740wmb.37.2024.02.21.08.29.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Feb 2024 08:29:11 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH] target/i386: do not filter processor tracing features except
 on KVM
Date: Wed, 21 Feb 2024 17:29:10 +0100
Message-ID: <20240221162910.101327-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.05,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

The processor tracing features in cpu_x86_cpuid() are hardcoded to a set
that should be safe on all processor that support PT virtualization.
But as an additional check, x86_cpu_filter_features() also checks
that the accelerator supports that safe subset, and if not it marks
CPUID_7_0_EBX_INTEL_PT as unavailable.

This check fails on accelerators other than KVM, but it is actually
unnecessary to do it because KVM is the only accelerator that uses the
safe subset.  Everything else just provides nonzero values for CPUID
leaf 0x14 (TCG/HVF because processor tracing is not supported; qtest
because nothing is able to read CPUID anyway).  Restricting the check
to KVM fixes a warning with the qtest accelerator:

    $ qemu-system-x86_64 -display none -cpu max,mmx=off -accel qtest
    qemu-system-x86_64: warning: TCG doesn't support requested feature: CPUID.07H:EBX.intel-pt [bit 25]

The warning also happens in the test-x86-cpuid-compat qtest.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2096
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index bca776e1fe9..7f908236767 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6412,6 +6412,10 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
             break;
         }
 
+        /*
+         * If these are changed, they should stay in sync with
+         * x86_cpu_filter_features().
+         */
         if (count == 0) {
             *eax = INTEL_PT_MAX_SUBLEAF;
             *ebx = INTEL_PT_MINIMAL_EBX;
@@ -7156,7 +7160,12 @@ static void x86_cpu_filter_features(X86CPU *cpu, bool verbose)
         mark_unavailable_features(cpu, w, unavailable_features, prefix);
     }
 
-    if (env->features[FEAT_7_0_EBX] & CPUID_7_0_EBX_INTEL_PT) {
+    /*
+     * Check that KVM actually allows the processor tracing features that
+     * are advertised by cpu_x86_cpuid().  Keep these two in sync.
+     */
+    if ((env->features[FEAT_7_0_EBX] & CPUID_7_0_EBX_INTEL_PT) &&
+        kvm_enabled()) {
         uint32_t eax_0, ebx_0, ecx_0, edx_0_unused;
         uint32_t eax_1, ebx_1, ecx_1_unused, edx_1_unused;
 
-- 
2.43.0


