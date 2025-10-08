Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D34ECAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 22:15:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6cEy-00033Z-Ka; Wed, 08 Oct 2025 18:02:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6cDX-0001Ru-Hg
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 18:01:10 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6cCZ-0007Qm-NF
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 18:01:01 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-780fc3b181aso183473b3a.2
 for <qemu-devel@nongnu.org>; Wed, 08 Oct 2025 15:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759960799; x=1760565599; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o4IFYSpPWlkanvTR9M2Vxqoi6bNBaOs+Vl8SdKAnnaI=;
 b=oLOYSWhEB9NQMWpO09EA46jhWeUz4PwMyvAFUwqqsDnqRwNVJDBHdsJSSuBx3OyMO8
 M33nYs5/qII4WTiePvvU+D8W5gBVtLz6aV0rDK9kOWik0CjLGIgC+0bRecX4GjtmP3Mu
 V1c9E50sFWKFd4fBcphPp2gkyYtLaXpPlGZWUdGTxpuHdyyiW1wobvTsXEVBRZ4a/YmX
 piDiZuZ0g+dLHN7KAMRvwJCjtVgbSZqsG+V5oS9Vh33N4ctIMyZrj7YZhP+fOsRdIR74
 P3uLrQkTnR8lErl4BPNpo2cE1LuDJkdhEto6xux9bfhbfrB+OIjYD4tbrd18de5JXkZy
 WyHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759960799; x=1760565599;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o4IFYSpPWlkanvTR9M2Vxqoi6bNBaOs+Vl8SdKAnnaI=;
 b=CWEyQAK3FVgJSzNj4O9S8aj2INd8+jyVNr2GCrggEfO/zQjrv9oB10Lr5qDLOrvHrq
 naoPM9nYklUjpdK5rTJqgAj+rt2c31crZbMhhkuIEJliVtAL7U9S5EpMQz2O4LpU0oPj
 XSdNlnkanHvAqLYtoEHZK+m/S5PYtwUM30/V5huUgsaifaly+P/QH8wJ2c5xj1ttlE+Z
 ZvuZPRi5Yw0P6ECmYmaBZTmTduVMy3AS5dIudE+fGFTzb9RkwRcFXtVJEAYxQY1+U3xW
 Ch8g93HOxN683TPK/rfhaWMk9S7ydoKl+0mM9WzY5/RwloDbUZrRVKDHGR1luB2+X8cv
 rE4w==
X-Gm-Message-State: AOJu0YzWO3Mw3GRdqBBupnaQWghrQy8eMGMUHBnyeQn2ISKLCT3NRgHf
 gfUW//wilNxiuNBwFBlLaqBn2H9Pu2Bt1DTEItRTjOaOpU7VdU+v26ssqXcqzrNuXxgeCNWcCqt
 vHFbVW6U=
X-Gm-Gg: ASbGncuVlRxX0HhzXz8NtqKw1nRYNaHoGG2PM64H4LCHxZY9gFF8V+OVrC21PXEazpK
 IRTN38sRIxJ0bxpj23hcLPSWK+oumfjp/Bkg9daB13U2h+VOTzzrRqhJt4F46xYxVYXHm+K1dHP
 Zpn8MHLWxCwQC0giEGGI4GTOH1U5pjaLhasgJq0J01j5bPe832L1CIipEVLC5F3YIpJQpTh2Hoy
 pdpJ//R2zM9Nkd+mndWyv9idWhX8fa6sb0gaoAL8d030FrMxlKJlZkpI9aG/HWbxvhOKIgotL4q
 Er6Zr2Aq38MHafQNY8Sd863n/hmMYKc5oDmJkGVfNZXn1UgLILdPmWqSpCphR5fuIVHtk93i4Dl
 WcN4UrfSnQMUoCat9u2S8J2+KeXBEV4duZPh89OpEnWc3VZbMI0+/BFlr
X-Google-Smtp-Source: AGHT+IFLyAHi+sQro0M8V2tTBsNFCwcjpYwN31nbcmlRFL1/y38t04Rub5dj3FL2MM+wr+OU7rX38w==
X-Received: by 2002:a05:6a00:3911:b0:77f:3a99:77b1 with SMTP id
 d2e1a72fcca58-79385703346mr5002224b3a.9.1759960798590; 
 Wed, 08 Oct 2025 14:59:58 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-794e1fc9db6sm740724b3a.66.2025.10.08.14.59.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Oct 2025 14:59:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v7 66/73] linux-user/aarch64: Implement map_shadow_stack
 syscall
Date: Wed,  8 Oct 2025 14:56:06 -0700
Message-ID: <20251008215613.300150-67-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251008215613.300150-1-richard.henderson@linaro.org>
References: <20251008215613.300150-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 59 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 47a6b58cf5..8546f48a05 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -6358,6 +6358,12 @@ abi_long do_arch_prctl(CPUX86State *env, int code, abi_ulong addr)
 # define PR_SET_SHADOW_STACK_STATUS  75
 # define PR_LOCK_SHADOW_STACK_STATUS 76
 #endif
+#ifndef SHADOW_STACK_SET_TOKEN
+# define SHADOW_STACK_SET_TOKEN  (1u << 0)
+#endif
+#ifndef SHADOW_STACK_SET_MARKER
+# define SHADOW_STACK_SET_MARKER (1u << 1)
+#endif
 
 #include "target_prctl.h"
 
@@ -6605,6 +6611,54 @@ static abi_long do_prctl(CPUArchState *env, abi_long option, abi_long arg2,
     }
 }
 
+#ifdef TARGET_AARCH64
+static abi_long do_map_shadow_stack(CPUArchState *env, abi_ulong addr,
+                                    abi_ulong size, abi_int flags)
+{
+    ARMCPU *cpu = env_archcpu(env);
+    abi_ulong alloc_size;
+
+    if (!cpu_isar_feature(aa64_gcs, cpu)) {
+        return -TARGET_EOPNOTSUPP;
+    }
+    if (flags & ~(SHADOW_STACK_SET_TOKEN | SHADOW_STACK_SET_MARKER)) {
+        return -TARGET_EINVAL;
+    }
+    if (addr & ~TARGET_PAGE_MASK) {
+        return -TARGET_EINVAL;
+    }
+    if (size == 8 || !QEMU_IS_ALIGNED(size, 8)) {
+        return -TARGET_EINVAL;
+    }
+
+    alloc_size = TARGET_PAGE_ALIGN(size);
+    if (alloc_size < size) {
+        return -TARGET_EOVERFLOW;
+    }
+
+    mmap_lock();
+    addr = gcs_alloc(addr, alloc_size);
+    if (addr != -1) {
+        if (flags & SHADOW_STACK_SET_TOKEN) {
+            abi_ptr cap_ptr = addr + size - 8;
+            uint64_t cap_val;
+
+            if (flags & SHADOW_STACK_SET_MARKER) {
+                /* Leave an extra empty frame at top-of-stack. */
+                cap_ptr -= 8;
+            }
+            cap_val = (cap_ptr & TARGET_PAGE_MASK) | 1;
+            if (put_user_u64(cap_val, cap_ptr)) {
+                /* Allocation succeeded above. */
+                g_assert_not_reached();
+            }
+        }
+    }
+    mmap_unlock();
+    return get_errno(addr);
+}
+#endif
+
 #define NEW_STACK_SIZE 0x40000
 
 
@@ -14065,6 +14119,11 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
         return do_riscv_hwprobe(cpu_env, arg1, arg2, arg3, arg4, arg5);
 #endif
 
+#ifdef TARGET_AARCH64
+    case TARGET_NR_map_shadow_stack:
+        return do_map_shadow_stack(cpu_env, arg1, arg2, arg3);
+#endif
+
     default:
         qemu_log_mask(LOG_UNIMP, "Unsupported syscall: %d\n", num);
         return -TARGET_ENOSYS;
-- 
2.43.0


