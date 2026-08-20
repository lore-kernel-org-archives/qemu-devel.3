Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D16AC5DF82
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 06:14:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1www2V-00028b-C8; Thu, 20 Aug 2026 02:14:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fre3dm4n@gmail.com>)
 id 1www2S-00027b-Vk
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 02:14:08 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fre3dm4n@gmail.com>)
 id 1www2R-0002aY-Eb
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 02:14:08 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-84e3007a2b7so1485810b3a.0
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 23:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787206446; x=1787811246; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ge48iWvqQuweSPFBnOAGMpJHsKcBn/Ek99Lc6vdvC7E=;
 b=EIq5z9KIDiQ31yUUfdvhLL4yxJpk0Bp6v8kp4NVqSZhXhyczl96+UtNg9HoLGdRzjj
 8BXp7NRfAeC6WGSMyuI1WnUMmt38z2/fLRxbaea9epfKbtgB520vVJHiCCCkhXZv6v2c
 5MwsKn4zopqFxzH0BxWw2nmf8n11+MZ4xAF8BP3HqwvRCeCe7heYO/kgt1Vs3CeIP0hw
 LqQIP4uO/fCsBPsuEbb0D8i/86BKic0Z+NguG+R80QVHAdvHorp2GTW5tlniQC6FjBe6
 uW/OuPuOV93UoCO3uLg0fOH/VPSx9ebNu1j4nbfEebnxsQp6w+J6bk08DWphT59Z8sn+
 rWPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787206446; x=1787811246;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ge48iWvqQuweSPFBnOAGMpJHsKcBn/Ek99Lc6vdvC7E=;
 b=AjPMsr6ED8gLsUKwL+eAs6/kpEWLQziyIE/sjj3wlUKSdXmJR7DLN0MI3oIWUQQW9f
 eXpsK7pzkO4NSDM0lRwROVXj1l2JZmnqwYL31k52i5a0y7u2mqzVV3gmmPPp5X9Qh0XA
 TntAlO2h6zcpZn80c7WnAtPevQ+B2i2yEmBWHn3ncwz3MMC9C4NLTykpHuNqDcSU/Ur9
 DTV/1FSfQntVQ0d+Qa1w43kdCPm4pxDIjkFdi4vrLzAdzbiM92y/LfLBN6QZc7D0tmTs
 afwa9EZpPevqJmwAQ72XvKTz/kSXNGYdJ+NmdUJzeXkEVKOIhO/yRToe7wydU/ZyfN0O
 Y6Og==
X-Gm-Message-State: AOJu0YxBH4/HBUVTbdbdK0dOROY5IAcObs+h8Iwi0kDyocn1nJ8GatQS
 gd0/vdeVYHohyoB9bSQXuEwuHvQKu14FPKvH+jTZuZwPLOnShoxXSmudgbMefMqLLCLaHw==
X-Gm-Gg: AR+sD12XUDTYrc9CEirfvDzRDF8y0TOH/Q0oAfC+otPJAq5l5B/ClQAHTy2UmLREVck
 f4FpIKA6EYp0P+8n7bqA5ZOwGeF6x2MNw9t8nRn+Tb2zu0Uk93MYB/A0avPW/TqZfzNFsBuNuZL
 05HSLhEXgYv60zPXEiqrVBpaocQlsKSykOu/jTTcbIcaM6OjS7vRpSKtE6dl0uClKmVZcY1pzlD
 WZNFe+8trbvxfcTuwXVwvwj5edACHPMMoRt4nQdMuTz9vhMz0P7FTONRONBe2zB2Ks294wpr8hJ
 0KG8uGhgLByfejxodesm7/zABO6xyiv3P4nc2nQGTvUc+e93Sty93lZSWTWOygAic8NMtQrU24n
 SqgSAdUyUrRaVQ9pNMhRa88yxE/TK1Z4Xq501fl0BZpwxqBEdV9kMZRoJxo/B4fupBz7tdEWMbv
 HmgB7abJ+EeLpsJjKTRlt6NbVw6HyE+4QRB4tzlNvJ4a9jyfpz6ycNIvdZ0LaDI4E=
X-Received: by 2002:a05:6a00:189c:b0:84f:b01d:3693 with SMTP id
 d2e1a72fcca58-851d39419a7mr16069430b3a.15.1787206446026; 
 Wed, 19 Aug 2026 23:14:06 -0700 (PDT)
Received: from 6a8281486e01 ([183.241.215.198])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-851d3640dd4sm1260483b3a.41.2026.08.19.23.14.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 23:14:05 -0700 (PDT)
From: Saul Freedman <fre3dm4n@gmail.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mtosatti@redhat.com, kvm@vger.kernel.org,
 Saul Freedman <fre3dm4n@gmail.com>
Subject: [PATCH RFC 1/1] target/i386: skip ICEBP before reinjecting #DB
Date: Thu, 20 Aug 2026 06:13:55 +0000
Message-ID: <20260820061355.196465-2-fre3dm4n@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260820061355.196465-1-fre3dm4n@gmail.com>
References: <20260820061355.196465-1-fre3dm4n@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=fre3dm4n@gmail.com; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

KVM handles an ICEBP trap itself when userspace debugging is disabled:
it advances RIP and queues #DB for delivery to the guest.  When hardware
breakpoints are enabled, KVM instead reports the #DB to userspace before
advancing RIP.

QEMU currently reinjects that event without advancing RIP, so the guest
returns to ICEBP and traps again indefinitely.  KVM_EXIT_DEBUG does not
preserve KVM's exact ICEBP classification, but ICEBP has no mutable DR6
cause bits and is a one-byte opcode that may be preceded by instruction
prefixes.  Use those properties to recognize the instruction, advance RIP
past its complete encoding, and reinject the trap-like #DB.

Also convert the DR6 value reported by KVM_EXIT_DEBUG to the exception
payload form expected by KVM_SET_VCPU_EVENTS.  Clearing the active-low
bits leaves breakpoint, single-step, task-switch and RTM payload bits
unchanged.

The fix was tested on Intel VT-x with a real Linux guest executing a
kernel-mode ICEBP instruction while an unrelated hardware breakpoint was
installed through QEMU's GDB stub.

Signed-off-by: Saul Freedman <fre3dm4n@gmail.com>
---
 target/i386/kvm/kvm.c | 62 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 61 insertions(+), 1 deletion(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 644c45f..c02a155 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -6240,6 +6240,48 @@ void kvm_arch_remove_all_gdbstub_hw_breakpoints(void)
 
 static CPUWatchpoint hw_watchpoint;
 
+static int kvm_debug_exit_icebp_len(CPUState *cs, CPUX86State *env,
+                                    const struct kvm_debug_exit_arch *arch_info)
+{
+    int offset;
+
+    if (arch_info->exception != EXCP01_DB ||
+        arch_info->dr6 & ~DR6_FIXED_1) {
+        return 0;
+    }
+
+    /* An x86 instruction is at most fifteen bytes, including prefixes. */
+    for (offset = 0; offset < 15; offset++) {
+        uint8_t opcode;
+
+        if (cpu_memory_rw_debug(cs, arch_info->pc + offset,
+                                &opcode, sizeof(opcode), false) != 0) {
+            break;
+        }
+
+        if (opcode == 0xf1) {
+            return offset + 1;
+        }
+
+        switch (opcode) {
+        case 0x26: case 0x2e: case 0x36: case 0x3e:
+        case 0x64: case 0x65: case 0x66: case 0x67:
+        case 0xf0: case 0xf2: case 0xf3:
+            continue;
+        default:
+            if ((env->hflags & HF_CS64_MASK) &&
+                opcode >= 0x40 && opcode <= 0x4f) {
+                continue;
+            }
+            break;
+        }
+
+        break;
+    }
+
+    return 0;
+}
+
 static int kvm_handle_debug(X86CPU *cpu,
                             struct kvm_debug_exit_arch *arch_info)
 {
@@ -6280,13 +6322,31 @@ static int kvm_handle_debug(X86CPU *cpu,
         ret = EXCP_DEBUG;
     }
     if (ret == 0) {
+        uint64_t exception_payload = arch_info->dr6;
+
         cpu_synchronize_state(cs);
+
+        if (arch_info->exception == EXCP01_DB) {
+            int icebp_len;
+
+            icebp_len = kvm_debug_exit_icebp_len(cs, env, arch_info);
+            if (icebp_len != 0) {
+                env->eip += icebp_len;
+            }
+
+            /*
+             * KVM_EXIT_DEBUG reports an architectural DR6 image, while
+             * exception payloads use the VMX pending-debug format.
+             */
+            exception_payload &= ~DR6_FIXED_1;
+        }
+
         assert(env->exception_nr == -1);
 
         /* pass to guest */
         kvm_queue_exception(env, arch_info->exception,
                             arch_info->exception == EXCP01_DB,
-                            arch_info->dr6);
+                            exception_payload);
         env->has_error_code = 0;
     }
 
-- 
2.55.0

