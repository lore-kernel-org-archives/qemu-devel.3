Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8608CD37BE
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 18:23:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMVHY-0004it-3M; Mon, 11 May 2026 14:23:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wMVHO-0004gk-6J
 for qemu-devel@nongnu.org; Mon, 11 May 2026 14:22:58 -0400
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wMVHL-0002fP-LE
 for qemu-devel@nongnu.org; Mon, 11 May 2026 14:22:57 -0400
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7de4a9cb8eeso3989374a34.0
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 11:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778523773; x=1779128573; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=khVlB/iuHBqSxDf1ci1EMIV9f0Ywmy6N/0aX6cS55HM=;
 b=pKxHWaCxuwU1AKM8OWlfSZdcNFMyTarc0Flfdgg/KY6oBneDRRaDnTae3Db0ijHtmx
 uaXgeXcxx/BHjpKbMZNtkq7N8PAUyxKhVuZcKZ++DYn+mnVdLFtTAXHvU8lZgyjQenhb
 tD4DYrHYv6YDR7xL13UFl38Ghacfjjl+HI7pk4DuxNGi+cAON+PsaUqhx4zxZGqxX1//
 L90U+pI2QffKvgNnwRMDD9pte+4W7RKh2wp6OMDi7UgkoARfGbz5QGdry/yMqE5bNhI3
 nCxkLqjzvzUNhIA85qNa8ISSgtBYijgSch4x+I2XyGFpk98tXthNTh/1oX3Gf3XmeK9O
 oSJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778523773; x=1779128573;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=khVlB/iuHBqSxDf1ci1EMIV9f0Ywmy6N/0aX6cS55HM=;
 b=NWM9U/LC3Pv0l69mr7vCfRz2juBNELqmVc/9gDgkuZyIgX26cqHE2bBpdQPEEqP/Qg
 PtXIC5YYtH5Q3lwWHGJhoD5JuogizCyehACKYnS2RAo0LKCA65BRTGgHkTYhNALVD/KJ
 bKXzIFY9UWR091mvJX4shDfCKaZh86V63Rnt18lyV+ufwj492tuTPoeB07ToHbUvfNia
 Xpn8Um88sFTnVUUz/gHvPJ+aMDCsJAj9uf4kTShSOdrvRSpPk4ULilKAhwqJElMTowNM
 Q7mI0cr+WmMOTpcxIxHSPcCAyJumVqgNgP4YqC+BPfblwoCcZiS8KLm2MNX7SyIDQ8Um
 Y4/g==
X-Gm-Message-State: AOJu0YweM7s0i1Pv+XOwB48lDV9milf+aTp8bE+2jxtNmiLoOhrsMEtH
 jW33uQB7Bvi8HxfqymVUHesiI9v31UNQfpLqHLxVZVpAMGE6wtfcsN4p
X-Gm-Gg: Acq92OH0pTVzJwkcYDmyG/Du/Q9wJg8c1WyKFd9RBcqvxsr93NMXZMAUmSt3xdGWxr6
 nTdkSKOuXOKLgpoVkg/gZCkUaZ6UKgD1uX17tlUiI4cl2H8YLTJsTo46DPZkQiKRluvx6ooU4gA
 UweiIHN33ggV639CrdPRN+uetQLVByWXXoKr5y/Vi2WDpqRP/QxWFO7FU8xMMH6h5osksVg9fwL
 nTtUuiGgw0G/uk0QYdAgwZVnEHIFWGsOIT2Root2xl1H3BQEVorziSU1xtiNTtUUcj5vipnAiLf
 rI4gLolYvJnP0noxE9b00zvt2US3J43LN2nlQ0zS+/9Tb46T7KNzlvpPLUhe6B2BmE+weZS7J5J
 BroSVZqmm3Tt+szWEomfI4qOSfiubnJpRwkMBFrNXJfWM+GX61LmB1U59lKALl6x3UVWi/gYlqp
 F2Q4fWx1vsYABghVVYUpTOsbx4HZCmTaGdPYdo4zqmmZt1wMkIvrytrjRbGehlYPaynyAvKpLWx
 4RyOetVnPOAvXIgv/FfgeYzeSBEYvzaOZvk/WAsquhR9+Uy4Korf0uAyxrJ0lYkZElWpwKDquUO
 F0g=
X-Received: by 2002:a05:6830:378e:b0:7dc:cbaa:d730 with SMTP id
 46e09a7af769-7e1def3deabmr15233129a34.8.1778523773326; 
 Mon, 11 May 2026 11:22:53 -0700 (PDT)
Received: from mac.localdomain (71-218-106-55.hlrn.qwest.net. [71.218.106.55])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e367d90148sm7504871a34.20.2026.05.11.11.22.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 11:22:52 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 11 May 2026 12:22:33 -0600
Subject: [PATCH v6 02/35] linux-user/mips: implement sysmips(MIPS_ATOMIC_SET)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260511-mips-octeon-missing-insns-v2-v6-2-5062889c4d3c@gmail.com>
References: <20260511-mips-octeon-missing-insns-v2-v6-0-5062889c4d3c@gmail.com>
In-Reply-To: <20260511-mips-octeon-missing-insns-v2-v6-0-5062889c4d3c@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::32d;
 envelope-from=james.hilliard1@gmail.com; helo=mail-ot1-x32d.google.com
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


