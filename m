Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDF84FF8855
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 14:01:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKcn1-0003TG-7D; Wed, 06 May 2026 09:59:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcmz-0003Pz-T0
 for qemu-devel@nongnu.org; Wed, 06 May 2026 09:59:50 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcmw-0000EH-HQ
 for qemu-devel@nongnu.org; Wed, 06 May 2026 09:59:48 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-488b150559bso44890855e9.1
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 06:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778075984; x=1778680784; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rnr910XkDufERe9XVu800E0bqoN1SBghJFJ3GMyOOWQ=;
 b=KNnMDfQbZO37UobELfJM659j60/UM26LalfwpOJfEWUW8kuHLlRS/5phNO772xpTiL
 /eSqSrjqDO9t0rJ9wk+f6fg6X+0xuZPsno0380mHGIb/zLQJZ6AoVWBUXmm9xDqB8uXX
 wwCMiNsu6yWSTXFT+bx6weIWS6ZJM5NZNVzYv45s1BfIS7kXm91wGI4n3JrUCsSK1iQA
 xDCwsMUOh0wDclPBhwymGWKi5IvzCaDvyuGIvoxoOO9uQMBNY9Rnhkp9QC8825l/mYVG
 x+8OtQMIEGxFFi9qoqpRz+K4Kj9AOksDMKU62o6tciOqZp/E5BKdBBQYxqaz4Lp5AJyl
 tTLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778075984; x=1778680784;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=rnr910XkDufERe9XVu800E0bqoN1SBghJFJ3GMyOOWQ=;
 b=tCi4pEEhoP+O2xXgbCwbmvpKA5ik6RVNICO7p9Hs8BonNVosUH8GcMf62dgECxKn4P
 0ekEIxnHYMwgYpONN68b0pr5B0dDLRLhwONPCMqbiXukbaYX7oW8/JPi6BiMf983MsrT
 WC5bmt1T1K4g86rixuTFnQAlaqy2h1G4RUIVukzozDDgW/aL1N3CI4WVnCOzVCBWcrPJ
 WBJsZyL8Q9BjXvAneOeNiyCbd0dTrElVRfRu1Mf5IydQhhVlCsH1Xox0Ra1kZfntnoGD
 jsdxdkOw1+tqvEsq0FLYrMkLPJp/Qz6nxiAhQz56bq6gVECgthAKXCbOBT18pdj7Gblp
 QZ1Q==
X-Gm-Message-State: AOJu0YybeX1t3Yt639M9NHZA0eqnYaybhK4oXn1bsMWU0AWtGvKDX8UP
 KCjHC6tFObAz0uJpg3AjZVcZa8Imnh8cwa6fZBSimfIt3GDk0GxU/GIwAfVoCbo231LtjL7SNj1
 2mVLOIno=
X-Gm-Gg: AeBDiescV0czt9FutXzG5hocOLiRxs2A0qurQI8t+FuyBnTGcv/M3K5vvJ35+EtPC8P
 LDZ7F/Wtv+aO0/U4hhC973Wz9pe7qVscsE+cyA9Es4r0TsnRfQK7D+VuJ+oM/XZM+vZ2Mcb6uMs
 d8mUXW3BZ1OsxH2GCPaH2RMfQ3cgas8lIf4aUibNgEvdGUlcXhi0Y8RtpsNl5ZC0JmAt3av4Aug
 Fbc2kXrY0E6lrwpQ6mU9di3Aeh3C9aX682w8fn1ApN4E+QQeIJpf8C1K2hmz59yoJp1Tzr9fdL4
 AimQerxvyp0kf+omxGgBPGaLERXkWK0kgxlO3sZrKX4/RkjnNIBInLz1+mfHGjubTedJqSD2Vzo
 7HB2wkSIq+HtjkmBCFG+NE8HNChJNN/hqkR6L5GIMpT+oiup5VXVSjlUNRcPVI/IygVbhazh+Gf
 qNxx2kBbnycJbAE95PKdUNLCr1Ec0caSKMIbeMJhJ8Pn5yhExYSJ4ilVxP3fR2bPffAaRsC2JKC
 gxE1lYvf1A=
X-Received: by 2002:a05:600c:4f92:b0:486:ff92:63e5 with SMTP id
 5b1f17b1804b1-48e51e09711mr64830865e9.6.1778075983517; 
 Wed, 06 May 2026 06:59:43 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45055f249bbsm11329939f8f.36.2026.05.06.06.59.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 06 May 2026 06:59:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 034/110] target/sparc: Replace VMSTATE_VARRAY_MULTIPLY ->
 VMSTATE_UINTTL_ARRAY
Date: Wed,  6 May 2026 15:54:06 +0200
Message-ID: <20260506135524.20617-35-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506135524.20617-1-philmd@linaro.org>
References: <20260506135524.20617-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

VMSTATE_VARRAY_MULTIPLY() seems to be an "optimized" version
of VMSTATE_UINTTL_ARRAY(), and is only used once. Prefer the
generic macro. Bump the SPARC CPU migration stream version.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20260325211728.89204-10-philmd@linaro.org>
---
 include/migration/cpu.h | 2 --
 target/sparc/machine.c  | 7 +++----
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/include/migration/cpu.h b/include/migration/cpu.h
index 8260ce0a3b7..8d15783b8c1 100644
--- a/include/migration/cpu.h
+++ b/include/migration/cpu.h
@@ -13,7 +13,6 @@
     VMSTATE_UINT64_ARRAY_V(_f, _s, _n, _v)
 #define VMSTATE_UINTTL_SUB_ARRAY(_f, _s, _start, _num)                \
     VMSTATE_UINT64_SUB_ARRAY(_f, _s, _start, _num)
-#define vmstate_info_uinttl vmstate_info_uint64
 #else
 #define VMSTATE_UINTTL_V(_f, _s, _v)                                  \
     VMSTATE_UINT32_V(_f, _s, _v)
@@ -21,7 +20,6 @@
     VMSTATE_UINT32_ARRAY_V(_f, _s, _n, _v)
 #define VMSTATE_UINTTL_SUB_ARRAY(_f, _s, _start, _num)                \
     VMSTATE_UINT32_SUB_ARRAY(_f, _s, _start, _num)
-#define vmstate_info_uinttl vmstate_info_uint32
 #endif
 
 #define VMSTATE_UINTTL(_f, _s)                                        \
diff --git a/target/sparc/machine.c b/target/sparc/machine.c
index 0a449f2f8c6..5f402e098cf 100644
--- a/target/sparc/machine.c
+++ b/target/sparc/machine.c
@@ -189,9 +189,9 @@ static int cpu_pre_save(void *opaque)
  * versions are different.
  */
 #ifndef TARGET_SPARC64
-#define SPARC_VMSTATE_VER 7
+#define SPARC_VMSTATE_VER 8
 #else
-#define SPARC_VMSTATE_VER 9
+#define SPARC_VMSTATE_VER 10
 #endif
 
 const VMStateDescription vmstate_sparc_cpu = {
@@ -202,8 +202,7 @@ const VMStateDescription vmstate_sparc_cpu = {
     .fields = (const VMStateField[]) {
         VMSTATE_UINTTL_ARRAY(env.gregs, SPARCCPU, 8),
         VMSTATE_UINT32(env.nwindows, SPARCCPU),
-        VMSTATE_VARRAY_MULTIPLY(env.regbase, SPARCCPU, env.nwindows, 16,
-                                vmstate_info_uinttl, target_ulong),
+        VMSTATE_UINTTL_ARRAY(env.regbase, SPARCCPU, MAX_NWINDOWS * 16 + 8),
         VMSTATE_CPUDOUBLE_ARRAY(env.fpr, SPARCCPU, TARGET_DPREGS),
         VMSTATE_UINTTL(env.pc, SPARCCPU),
         VMSTATE_UINTTL(env.npc, SPARCCPU),
-- 
2.53.0


