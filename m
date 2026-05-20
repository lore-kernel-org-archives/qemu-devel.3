Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC6C8CD5BA4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 19:25:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPmXG-0008Ii-Ir; Wed, 20 May 2026 15:24:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPmXD-0007y7-9H
 for qemu-devel@nongnu.org; Wed, 20 May 2026 15:24:51 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPmX9-0001xA-MX
 for qemu-devel@nongnu.org; Wed, 20 May 2026 15:24:50 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-48d146705b4so58516005e9.3
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 12:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779305085; x=1779909885; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NTJTBJGiKTAtbk2+yacFXD/H2Zy4Qt8gbCv1PqATx/Q=;
 b=K1FFlNdddFqMVgD+N9m8NFkpH0cSTlQlNch206FAVmqsFhQjqePSzPjGeuK+5VtBaE
 86JmFMWgofKBHXJxcwopW7/iYKCaV0Vt3JZ2iuGZoxuj3khsyF2bH00hD5MDEWxXkUsy
 JkA9UY61EGh8N0KIE42Gj+AZdkWnlJglYl2fvHRtBLhH6JBpuRFvQmFJlMFz1ouL/2C5
 gLx3geVV+z16by4+2ZKj4wiJIjFWzozEiH1FCez/LxjTRb/zfYnsJCWgXEoUycmnBQCx
 30+2tm4FHK6lug1OIQowGy+mJQxc8qOkGRpltiE6xAcKML9ZE9i/dfxZnEI44EVfLAXl
 kcCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779305085; x=1779909885;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=NTJTBJGiKTAtbk2+yacFXD/H2Zy4Qt8gbCv1PqATx/Q=;
 b=UmIhk6fdMhQOB5il/+1Fq8QpDq9mE15NmEgEzs6TE+NVsm2pBVM7KjmHwANgXkL2BW
 dlEQe9+m1tMqtBZ1X/JProAikZA7Cp0HYzxelLE54rdYtiRZi43LtxAjnj4fWDmn0so/
 c3qdckI3lQLPYarDZ/Y5WvnccjayHEP6714JQiBD48JGpQZpOi8ByYqLAWvHfXuYL77w
 rhGHRS0zUByp2ckdjcvB+Sivt9BWuzeznoZ0rgqZwUH/DXDcKqEGkCXCh6p6Rqx4+3+J
 jMj7oiBC3eFZNOdD8jXCs8fN39PzIwrgIYxlsa25YRbPeF1JdTEVVQo4T9K9Wcn9A7zU
 EcaQ==
X-Gm-Message-State: AOJu0YzjEIbf0fY7ckbnQaz/8Gfo+5qiSAXe9etiYRhNlnv8H5pvidbX
 UNGguEqp9pvW1fcqyKgDNNefCPSsKSnLSIdkXrRBeS+LjiihLtZoVPnKk4se8LSmpdqH0IT1VMe
 2tMpVLYs=
X-Gm-Gg: Acq92OE4LWSHKVm28PyNeEkVlY82N+JDC3fdDUko2lawuOXHvwKQMidvcZI6TdRmsIs
 DCkHPUX1D+hSxA36xfE8wMb0IB94jsF+yZUXKVdATwLzSraxwYTAgkazc5gh6c8wlTc0aTdd5Qh
 P0N3PtrwnizyfjxI+3r3mjSMwfvvu8JqluiHT/VIvPSGVyFPsp0CdNdiTroRxplRF0WsCLsi/tE
 5ENie9b1fPJ3Qqz+Ncsx6HsHjeVN22dqa3OoyDukHQnr/xr+5x58xwrd13lCycD/hta432IywdF
 9C9Ga1p08z7MCkQvncWPqUnlcxngOwQXW/CBpLapBK+SrXS/EHOhabh/Hl7PYVyUKRE5EpXpMJG
 xi+P+XYJRrp8/3ikfdw3Px1vYX7QsDoLzI0JMZaPgSxjrf+3UE7qvqr2u2kw7rYeia+bMgy8j7M
 ftPk8FQ85l+PjSCYncmU4sxnW6N7CqlyOSMZ8DWkeum3ua5VS3r8eb4XYnJOi6P3xMZ6z3VTjh
X-Received: by 2002:a05:600c:a406:b0:487:1fb4:7e1 with SMTP id
 5b1f17b1804b1-48fe632a02fmr323196125e9.22.1779305085441; 
 Wed, 20 May 2026 12:24:45 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49033d5f21dsm12793425e9.13.2026.05.20.12.24.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 20 May 2026 12:24:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/33] linux-user/mips: implement sysmips(MIPS_FLUSH_CACHE)
Date: Wed, 20 May 2026 21:23:14 +0200
Message-ID: <20260520192338.40036-10-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520192338.40036-1-philmd@linaro.org>
References: <20260520192338.40036-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: James Hilliard <james.hilliard1@gmail.com>

Add the target sysmips dispatcher and implement MIPS_FLUSH_CACHE as a
successful no-op for linux-user.

Self-modifying code is handled by QEMU's normal user-mode translation
invalidation machinery, so the target ABI only needs the syscall command
to be accepted.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20260520172313.23777-2-philmd@linaro.org>
---
 linux-user/mips/target_syscall.h   |  1 +
 linux-user/mips64/target_syscall.h |  1 +
 linux-user/syscall.c               | 17 +++++++++++++++++
 3 files changed, 19 insertions(+)

diff --git a/linux-user/mips/target_syscall.h b/linux-user/mips/target_syscall.h
index dfcdf320b7c..3f36c1695a5 100644
--- a/linux-user/mips/target_syscall.h
+++ b/linux-user/mips/target_syscall.h
@@ -10,6 +10,7 @@
 #define TARGET_MCL_ONFAULT 4
 
 #define TARGET_FORCE_SHMLBA
+#define TARGET_SYSMIPS_FLUSH_CACHE     3
 
 static inline abi_ulong target_shmlba(CPUMIPSState *env)
 {
diff --git a/linux-user/mips64/target_syscall.h b/linux-user/mips64/target_syscall.h
index 9135bf5e8b6..20ea7c6ab9b 100644
--- a/linux-user/mips64/target_syscall.h
+++ b/linux-user/mips64/target_syscall.h
@@ -10,6 +10,7 @@
 #define TARGET_MCL_ONFAULT 4
 
 #define TARGET_FORCE_SHMLBA
+#define TARGET_SYSMIPS_FLUSH_CACHE     3
 
 static inline abi_ulong target_shmlba(CPUMIPSState *env)
 {
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 2d4a8aa182b..5a8e00337a0 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -6630,6 +6630,19 @@ static abi_long do_prctl_syscall_user_dispatch(CPUArchState *env,
     }
 }
 
+#ifdef TARGET_NR_sysmips
+static abi_long do_sysmips(CPUArchState *env, abi_long cmd, abi_long arg1,
+                           abi_long arg2)
+{
+    switch (cmd) {
+    case TARGET_SYSMIPS_FLUSH_CACHE:
+        return 0;
+    default:
+        return -TARGET_EINVAL;
+    }
+}
+#endif
+
 static abi_long do_prctl(CPUArchState *env, abi_long option, abi_long arg2,
                          abi_long arg3, abi_long arg4, abi_long arg5)
 {
@@ -12110,6 +12123,10 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
     case TARGET_NR_prctl:
         return do_prctl(cpu_env, arg1, arg2, arg3, arg4, arg5);
         break;
+#ifdef TARGET_NR_sysmips
+    case TARGET_NR_sysmips:
+        return do_sysmips(cpu_env, arg1, arg2, arg3);
+#endif
 #ifdef TARGET_NR_arch_prctl
     case TARGET_NR_arch_prctl:
         return do_arch_prctl(cpu_env, arg1, arg2);
-- 
2.53.0


