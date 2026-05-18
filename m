Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10923CD4F50
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 05:30:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOqY2-0006to-Rh; Mon, 18 May 2026 01:29:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wOqXm-0006s2-T2
 for qemu-devel@nongnu.org; Mon, 18 May 2026 01:29:37 -0400
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wOqXd-0003Qy-Us
 for qemu-devel@nongnu.org; Mon, 18 May 2026 01:29:29 -0400
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-47c941f6bdcso1185496b6e.3
 for <qemu-devel@nongnu.org>; Sun, 17 May 2026 22:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779082163; x=1779686963; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=khVlB/iuHBqSxDf1ci1EMIV9f0Ywmy6N/0aX6cS55HM=;
 b=syqA0jfgd8dIyoTd64EK1mMmDuT/FM9addibi8yaEdgwp3yqlGhNkCPq1fvEZOEI3b
 8TLShxdhql8yKpaeb8ev4cGhaEi3IO+rOQtZ70jmEgsRazy2c3wzoLAe04fcPMNUPCFt
 MpqQykR2ppvY9odd+DVc6hn0isaYJbLZ4Bun95t6ZrNl3QxDuR8IpZnb2INO4VoLyQ+j
 cCbimyjXqMT00V45/8GoHv5kg5yLIOnTKhb8gSlYdZuJm4ss4cOHx+ZMKP6eB20MBmwV
 OVIbUgIvmFvRP3r05OJBMyey7dD0IkjrtVVjKwwc3OGhi83zdcgJ7yTiPQs2vuRbwlBF
 kDAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779082163; x=1779686963;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=khVlB/iuHBqSxDf1ci1EMIV9f0Ywmy6N/0aX6cS55HM=;
 b=hfJfKQoFX3o5Pjw0TgTWISaNqK1ZMUdwPDrc+5j20J7Zemqx/DL98OvOGDrb1gITu/
 rlQjZiJR+qgbIxpaFQhMaIqt4rVrS4w6XB0SlLFHYpOjetGKddvZzP6lrkdyp/U67pPy
 R657Kfn7vrHm7ziXCypgA3Ih3zI35j1kZ6FCmZaGbwg5gJtPmht5NBLIAnsCPhOEhJR4
 iOMELt4hxVV3fW2KdwpzJXFMHsahj3QXImJm3Bs4FwXrC/4dbbANcxGZNdMNM1kqzEhW
 nuiBpG+3g1ACiFp+XQJVbNazRPofsCE8FUqrdJonJtjuiq95DENtIgGuQtL2qelugX/f
 kGUw==
X-Gm-Message-State: AOJu0YxBq3W30wEqDoRptp1R6Hv3XJ5v9pIZRMW/3bs8hK8BYaltDCkW
 +wdr7CbnpmtkFjW1QbftE8ua5wtv3RCaVrrzmBmGlFYPt0LD+ZgHssHl
X-Gm-Gg: Acq92OGPVny+qDrwwV6/roZ6OTzbK2npPoNDy0RKeNRTNh5eEX4H7WBgG/AlOjLUiCl
 hxucvegyDMr8s5hRAK0rakl3DFqLyJdTNZ4RrWdxdC+IYiRE1S9oZokp6SHHZtTjZUkir3MkqoG
 xbDwFxfpW+vbQYYFZzT52PKUn5/jqrEFDMpUw59APlShdVoJ7F9+fdRFNOkYFBFW2UdyoENUOUA
 PkBvv2HR0LsAb4hPhZyJTw8vvy51gnxlzH5Snis3FwFastMb6eNaq61tCJuwZOfGqGiWNn0ftu5
 8UOFvATFjF7Pb7IB4eg0fX3K1fgLtynYn9H4R7P+gdtl8j6yAguutjDA5ZQ9K40NphwkAKTIYxd
 +DVGrFZ3pf+kj4XEDjsACQ26409UL7Ukqdy1OZ/dKX2niwcMAL6Uxg8O80Zgme47uQPVnsoQHd2
 lfTpU2wmgLRLfpg1SRovHy5wQblakcYzcZuFm+qypdniRnWALcmT8pcnAYrs+KcelpbtueZ3yxA
 AlkPNNkDyh4aB7HDIO/Oe62PxGUL4x/PXcqvvBVXTSzeQZ9xorPeNVov1qoYhjr34beSHg=
X-Received: by 2002:a05:6808:f90:b0:482:4df3:91c3 with SMTP id
 5614622812f47-482e57b6ad9mr8826458b6e.42.1779082163138; 
 Sun, 17 May 2026 22:29:23 -0700 (PDT)
Received: from mac.localdomain (71-218-255-245.hlrn.qwest.net.
 [71.218.255.245]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-482ee5349a5sm4628357b6e.15.2026.05.17.22.29.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 May 2026 22:29:22 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 17 May 2026 23:28:59 -0600
Subject: [PATCH v8 02/35] linux-user/mips: implement sysmips(MIPS_ATOMIC_SET)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260517-mips-octeon-missing-insns-v2-v8-2-206151ee77ec@gmail.com>
References: <20260517-mips-octeon-missing-insns-v2-v8-0-206151ee77ec@gmail.com>
In-Reply-To: <20260517-mips-octeon-missing-insns-v2-v8-0-206151ee77ec@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::230;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oi1-x230.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Implement the MIPS_ATOMIC_SET sysmips command as an aligned 32-bit atomic
exchange in target memory.

MIPS reports syscall errors through a separate register, so successful old
values can overlap the errno range.  Write the return value and error flag
directly and return -QEMU_ESIGRETURN so the common syscall path leaves the
registers unchanged.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v2 -> v3:
  - Split MIPS_ATOMIC_SET out of the combined sysmips/MIPS_FIXADE patch.
    (suggested by Richard Henderson)
  - Always use the explicit MIPS return-register path for successful
    atomic_set results.  (suggested by Richard Henderson)
---
 linux-user/mips/target_syscall.h   |  1 +
 linux-user/mips64/target_syscall.h |  1 +
 linux-user/syscall.c               | 31 +++++++++++++++++++++++++++++++
 3 files changed, 33 insertions(+)

diff --git a/linux-user/mips/target_syscall.h b/linux-user/mips/target_syscall.h
index 3f36c1695a..9206694f4f 100644
--- a/linux-user/mips/target_syscall.h
+++ b/linux-user/mips/target_syscall.h
@@ -11,6 +11,7 @@
 
 #define TARGET_FORCE_SHMLBA
 #define TARGET_SYSMIPS_FLUSH_CACHE     3
+#define TARGET_SYSMIPS_ATOMIC_SET   2001
 
 static inline abi_ulong target_shmlba(CPUMIPSState *env)
 {
diff --git a/linux-user/mips64/target_syscall.h b/linux-user/mips64/target_syscall.h
index 20ea7c6ab9..e07687f8ac 100644
--- a/linux-user/mips64/target_syscall.h
+++ b/linux-user/mips64/target_syscall.h
@@ -11,6 +11,7 @@
 
 #define TARGET_FORCE_SHMLBA
 #define TARGET_SYSMIPS_FLUSH_CACHE     3
+#define TARGET_SYSMIPS_ATOMIC_SET   2001
 
 static inline abi_ulong target_shmlba(CPUMIPSState *env)
 {
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 73f09bb775..3786a34041 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -6631,10 +6631,41 @@ static abi_long do_prctl_syscall_user_dispatch(CPUArchState *env,
 }
 
 #ifdef TARGET_NR_sysmips
+static abi_long do_sysmips_atomic_set(CPUArchState *env, abi_ulong addr,
+                                      abi_long value)
+{
+    uint32_t *ptr;
+    abi_long old;
+
+    if (addr & 3) {
+        return -TARGET_EINVAL;
+    }
+
+    ptr = lock_user(VERIFY_WRITE, addr, sizeof(*ptr), true);
+    if (!ptr) {
+        return -TARGET_EINVAL;
+    }
+
+    old = tswap32(qatomic_xchg(ptr, tswap32((uint32_t)value)));
+    unlock_user(ptr, addr, sizeof(*ptr));
+
+    /*
+     * MIPS uses a separate error flag, but the common linux-user syscall
+     * path infers that flag from the return value.  Successful atomic_set
+     * results can overlap the target errno range, so write the result
+     * registers here and ask the CPU loop to leave them alone.
+     */
+    env->active_tc.gpr[2] = old;
+    env->active_tc.gpr[7] = 0;
+    return -QEMU_ESIGRETURN;
+}
+
 static abi_long do_sysmips(CPUArchState *env, abi_long cmd, abi_long arg1,
                            abi_long arg2)
 {
     switch (cmd) {
+    case TARGET_SYSMIPS_ATOMIC_SET:
+        return do_sysmips_atomic_set(env, arg1, arg2);
     case TARGET_SYSMIPS_FLUSH_CACHE:
         return 0;
     default:

-- 
2.54.0


