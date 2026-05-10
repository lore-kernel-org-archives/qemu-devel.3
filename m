Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FB60CD37AF
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2026 02:17:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLtg4-00065U-VT; Sat, 09 May 2026 22:13:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wLtg3-00065C-Dp
 for qemu-devel@nongnu.org; Sat, 09 May 2026 22:13:55 -0400
Received: from mail-oo1-xc30.google.com ([2607:f8b0:4864:20::c30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wLtg0-0002sb-Hl
 for qemu-devel@nongnu.org; Sat, 09 May 2026 22:13:55 -0400
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-6966e1a0b91so2061574eaf.3
 for <qemu-devel@nongnu.org>; Sat, 09 May 2026 19:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778379230; x=1778984030; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7jM1jwUY6doQWw7cNzzrKAiwqt9SLepu9Iq35gPFd94=;
 b=JBT2gl4NiNRT00SxOws/1l8v5zZcah/n6miYoroMu0+v8VC8/u1qok3OtF+5UUzqHE
 +qEkgvevAeshe4/l7ptSEGygRka9nFZYZpFRl+lT20eRU5lRoM46+T4syNV91qRf/aPj
 fU90zyTw+fu4bueVGV2adRV1Kj4CXSpJXFQx7gdJ/96hVIfUqjI4RTOu0XF1/bG4vQs3
 fK6C96/mFcT8+tsCxT3XTteaEFEdcx4E5mmGsQS2ixaHWQcc2UO5zE/K2wbXfBCUjlgS
 6z6YoppDZPjJboziukG7pwODNRPboSr4Iv9d79HmGMIZBtcUWEbEcaDPLIA/GjWbdJw+
 VTxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778379230; x=1778984030;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=7jM1jwUY6doQWw7cNzzrKAiwqt9SLepu9Iq35gPFd94=;
 b=NNvUnnbEzX+g/i4ZIqBRjFflOxGfzNinDPLLMRkWJn8QiYTAU65nQeM3m/wY0WTg/k
 N50yCbK8/t3+8WbL8ZHNm1iaXsiW7+HNjHwjSpgC9uFIwYtGjeWHyk+sUwM3pCUypoIa
 8CKaWyi0QfUlV3/MgJnSn2rFnJL+BD7ldIfx44rFXMFkW+t9059yZHsjHQ4DyYPIDDN9
 DjkDfsx/mI51W5bhtYKJK+DVQnIdr78tpvaV4wgIYnVgbbRBQr1/fVda+0EHLw7tr3kB
 93vn6NdNrqpxbIaQePNpRbR0CCycnaCFwORsf9zB+Afq9mMnwwSZNHHIF9yLdpGrh3Q6
 l4NA==
X-Gm-Message-State: AOJu0YytCbUnBV/zbZ7tBI/st2vv+9dlM5nLiVdV5f1IUSBoi+BpnVuw
 wavnqwP5JTu0PPdnWNKJx6rNxPlv8f5cRYUU4JKMZwV4H7pWfs7IKR5wceCXVpHS
X-Gm-Gg: Acq92OGHWB/u/1SLsZvCJlyA9SWy0zdpKnGgYLLlh4h/gMncHWocBzpcgqctokAq9qv
 C3+pUgauVCEdmGRIXX6vA9/lNq/JRTUniFgeXB+mmgPA4pkwdebjmo8NK52BsWbmDN5/Zjr7Mho
 K/tcxpGN1nLVL/ovD7QzKuIY1NKnI6e1uAm5q3p5UzrRIBNkmhLpcou/SGbX08YeFB0A8MqCBHP
 i3FqbsJW1jvtbelj8jXvu22Wx3QGYXKlGjNYjTwQteA3j80i0opGZbk66pOJTOeBf1cSAVgvTsR
 EJsyZA1WRKJQwhRe+36i+FiFcS8acle0XRVYd8SAqngoH51ro3xVIZU7QtkzUW+YItv9iLO59Lr
 K/Qm10DN4hkrbdCLqQuLiOhztEik2u/szKq72pdeIqn6u1z/8eRe5GrN2H/fiyUK0Xk5RmKi83k
 rBtTGWUk1lkrDN0hU4RD7HFizddH2YKQ7OGckv0gum2AkMGaVkVnDaYalLRyBFzkrmc0M7O5xnM
 viMRwxeCzR1vePGxA7frqwQB6sAU+C6HdcZFYF9Bfi2y5ADaCiY2MwiqxNkGuTw3x9T
X-Received: by 2002:a05:6820:992:b0:67d:e505:cf57 with SMTP id
 006d021491bc7-69998d4662fmr10768507eaf.50.1778379230228; 
 Sat, 09 May 2026 19:13:50 -0700 (PDT)
Received: from mac.localdomain (71-218-106-55.hlrn.qwest.net. [71.218.106.55])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69b25dbffdbsm3645643eaf.9.2026.05.09.19.13.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 May 2026 19:13:49 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sat, 09 May 2026 20:13:24 -0600
Subject: [PATCH v4 01/32] linux-user/mips: implement sysmips(MIPS_FLUSH_CACHE)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260509-mips-octeon-missing-insns-v2-v4-1-d669dcd05c2f@gmail.com>
References: <20260509-mips-octeon-missing-insns-v2-v4-0-d669dcd05c2f@gmail.com>
In-Reply-To: <20260509-mips-octeon-missing-insns-v2-v4-0-d669dcd05c2f@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Richard Henderson <richard.henderson@linaro.org>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::c30;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oo1-xc30.google.com
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

Add the target sysmips dispatcher and implement MIPS_FLUSH_CACHE as a
successful no-op for linux-user.

Self-modifying code is handled by QEMU's normal user-mode translation
invalidation machinery, so the target ABI only needs the syscall command
to be accepted.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v2 -> v3:
  - Split MIPS_FLUSH_CACHE out of the combined sysmips/MIPS_FIXADE patch.
    (suggested by Richard Henderson)
---
 linux-user/mips/target_syscall.h   |  1 +
 linux-user/mips64/target_syscall.h |  1 +
 linux-user/syscall.c               | 17 +++++++++++++++++
 3 files changed, 19 insertions(+)

diff --git a/linux-user/mips/target_syscall.h b/linux-user/mips/target_syscall.h
index dfcdf320b7..3f36c1695a 100644
--- a/linux-user/mips/target_syscall.h
+++ b/linux-user/mips/target_syscall.h
@@ -10,6 +10,7 @@
 #define TARGET_MCL_ONFAULT 4
 
 #define TARGET_FORCE_SHMLBA
+#define TARGET_SYSMIPS_FLUSH_CACHE     3
 
 static inline abi_ulong target_shmlba(CPUMIPSState *env)
 {
diff --git a/linux-user/mips64/target_syscall.h b/linux-user/mips64/target_syscall.h
index 9135bf5e8b..20ea7c6ab9 100644
--- a/linux-user/mips64/target_syscall.h
+++ b/linux-user/mips64/target_syscall.h
@@ -10,6 +10,7 @@
 #define TARGET_MCL_ONFAULT 4
 
 #define TARGET_FORCE_SHMLBA
+#define TARGET_SYSMIPS_FLUSH_CACHE     3
 
 static inline abi_ulong target_shmlba(CPUMIPSState *env)
 {
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index d3d9fffb54..73f09bb775 100644
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
@@ -12102,6 +12115,10 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
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
2.54.0


