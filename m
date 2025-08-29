Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21D7DCA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:24:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNkO-000259-VM; Sat, 30 Aug 2025 11:44:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7Xn-0003K9-BE
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:26:03 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7Xg-00034S-Vc
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:26:02 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-7704799d798so2203686b3a.3
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 15:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756506355; x=1757111155; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nTd/CMDn/bEFaBpaiDSBMhnHX1YzDFeRbUC6vLpJVLI=;
 b=tKzv+uKtlDrZXrouYazlvCIkP91KY0JFcfxQdm2doISH98zH8N+mU5kGXWq+NlCEc5
 KmOgs1czWlMrvl8601+Uzkah+wPhuNZ6ToaFO1iF81DKAU5sFKrzbl17rVbVpyTTUGo6
 +9ll84pq4AH5lTeeHkl0EPWYNInaFYIOL8/s2HcHI99/tazI2vK8w8ELxf0zZg6aYYae
 uWHJxNmuETIhIGpaxYKuZIQOF2lUAF8ppVNcvfeBj0XAltbDeV9TR8/KhqK5IIecaufZ
 NkRb5ZWpTnbvPi1cRk7G5r79SfpJ+IlwTDlgojVQhkNFDmb5PUwbGvP8m+KaDK01yrP9
 bYiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756506355; x=1757111155;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nTd/CMDn/bEFaBpaiDSBMhnHX1YzDFeRbUC6vLpJVLI=;
 b=n/IC6YG9Xf0VfGqouBMRTUlqBvhDVwEtP8mG5Q1jyB9cRn8T4E4MK0/HwrAZ2NwwJ2
 GwKcnvtqzvSiUDwqiGTTQkrQ5iqCSQ58ymEAl/UfYUw7BIlVR711Qob2EYkx+pImsPsg
 Z3SE+5E2WsZFmDdr+6l8Xc1lkRAzIepP5hQk43hrpr7IQrmSRo/vdX6ldgFgILSuph6r
 2UKF2kDCH2C5ZVH44Vb7fRn0VdTtY2VfclOgeeIbBpYNWgDvLLgYyIBek0J45A/Lcqw2
 PQU084o0Hwk2v8chNcVu7/pFL+VZi/ktG7WFHw2ganFABYxUpxKIsUszA9WOor+egj5D
 zodQ==
X-Gm-Message-State: AOJu0Yz9PRzO/gFELBgfrkLajRTZT3cWkEaJUs+8kwITfNItNcy0Qm+2
 iIKN3ONW3FaJ1QTciCWrKEZWVi44eNytqsURz06tefwJVR++kZIo1RhphjCeP6Xx0ZTbSBs+kmO
 bAroUn2g=
X-Gm-Gg: ASbGncv9fT/42sMpjIidOkyaTc/AtS3sCbry3kff0Nm83RA4e1IYsOR5ThpW0ij0nPd
 xc1xLFEvumAt+Fp1L7MtZsqVt6CIXpupAwc+pU32zeSSpcPGBlIdTGuCEZbwpD0MXqWLpoUh0HF
 q4k1PoAP4+jkUS8+e7/sli/fVVuUpIzWW/zMZbfBUXy+mM5fKAVHalPsYWYA7g+2yl8LVxM1Cff
 OIFR+mnSBufDnul1JNmA+9P4G47RU6QhPa3xso1eKKIMcqRAsiCP4joe1/5/P7dDKFX/wDJwSTF
 JLLzrICF5CdR93B/d0uJg3hpl6v0xLc4/1CjQ9IIWMEH99GTIuaYL2I6ik6LbD/kzJkzJVUF3Ml
 +1E1ZzrGgwJwxIJffot+02GqvkLUuPSfLRBVQBBik4Wo3hd17oPHVlP3PzUWL
X-Google-Smtp-Source: AGHT+IH7IHz58A81Dl+/dl5kGV83sXo1S00A1BsqHIErLEfT5T2QBB2L2lrEDPz4U4rNoGMSoy/9sA==
X-Received: by 2002:a05:6a00:3d14:b0:76e:7ae9:e86b with SMTP id
 d2e1a72fcca58-7723e3f372bmr244909b3a.27.1756506355096; 
 Fri, 29 Aug 2025 15:25:55 -0700 (PDT)
Received: from stoup.. (122-150-204-12.dyn.ip.vocus.au. [122.150.204.12])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7722a71c60bsm3302493b3a.103.2025.08.29.15.25.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 15:25:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 34/91] linux-user/i386: Create target_ptrace.h
Date: Sat, 30 Aug 2025 08:23:30 +1000
Message-ID: <20250829222427.289668-35-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250829222427.289668-1-richard.henderson@linaro.org>
References: <20250829222427.289668-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

Remove the target_pt_regs structure from target_syscall.h.
Add target_user_regs_struct to target_ptrace.h, which is
what is actually used by ELF_CORE_COPY_REGS; the layout
of the two structure definitions is identical.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/i386/target_ptrace.h  | 32 ++++++++++++++++++++++++++++++++
 linux-user/i386/target_syscall.h | 18 ------------------
 2 files changed, 32 insertions(+), 18 deletions(-)
 create mode 100644 linux-user/i386/target_ptrace.h

diff --git a/linux-user/i386/target_ptrace.h b/linux-user/i386/target_ptrace.h
new file mode 100644
index 0000000000..bc57926f25
--- /dev/null
+++ b/linux-user/i386/target_ptrace.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef I386_TARGET_PTRACE_H
+#define I386_TARGET_PTRACE_H
+
+/*
+ * Note that arch/x86/include/uapi/asm/ptrace.h (struct pt_regs) and
+ * arch/x86/include/asm/user_32.h (struct user_regs_struct) have the
+ * same layout, though the exact types differ (int vs long vs unsigned).
+ * Define user_regs_struct because that's what's actually used.
+ */
+struct target_user_regs_struct {
+    abi_ulong bx;
+    abi_ulong cx;
+    abi_ulong dx;
+    abi_ulong si;
+    abi_ulong di;
+    abi_ulong bp;
+    abi_ulong ax;
+    abi_ulong ds;
+    abi_ulong es;
+    abi_ulong fs;
+    abi_ulong gs;
+    abi_ulong orig_ax;
+    abi_ulong ip;
+    abi_ulong cs;
+    abi_ulong flags;
+    abi_ulong sp;
+    abi_ulong ss;
+};
+
+#endif /* I386_TARGET_PTRACE_H */
diff --git a/linux-user/i386/target_syscall.h b/linux-user/i386/target_syscall.h
index aaade06b13..c214a909a6 100644
--- a/linux-user/i386/target_syscall.h
+++ b/linux-user/i386/target_syscall.h
@@ -5,24 +5,6 @@
 #define __USER_CS	(0x23)
 #define __USER_DS	(0x2B)
 
-struct target_pt_regs {
-	long ebx;
-	long ecx;
-	long edx;
-	long esi;
-	long edi;
-	long ebp;
-	long eax;
-	int  xds;
-	int  xes;
-	long orig_eax;
-	long eip;
-	int  xcs;
-	long eflags;
-	long esp;
-	int  xss;
-};
-
 /* ioctls */
 
 #define TARGET_LDT_ENTRIES      8192
-- 
2.43.0


