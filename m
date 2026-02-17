Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 790F2E68159
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 09:52:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsHkd-0002sk-41; Tue, 17 Feb 2026 04:52:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vsHkR-0002au-1Y
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 04:52:03 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vsHkO-0006Bg-B8
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 04:52:02 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2a962230847so33781885ad.3
 for <qemu-devel@nongnu.org>; Tue, 17 Feb 2026 01:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771321889; x=1771926689; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MqKGZs0n4DofZPkoSFoT/fTZEG3Fs+4rNgilmKZe4Ic=;
 b=Fko+t9JjwwcBIfCOSpOnIracX+dE2cjLKC3kUzZFQAZT36rbZrQExvdQgXnap8p9ea
 TyiAixdjAzM0Nt9h+MWR26ShnwYH63P5WwEzO302MrCm5+5kwQy2mSTaHtQ1Wp449iaE
 d7hx+74vNxwnDokY1Uox5r0AXjP8xhOTv+DeHDDMWLG8PaFQKq5ZUusZR5A++8cFC4uY
 JYzMAr2FSrD77WrvfmXcT24s06O4ttU6y2HkvfOtkWH+863WqVmCmheDXuIbjus6rJmS
 5l0p3q0KkdKVcQWgHqC9l6I0UHsDE9VqXRa24yYSzTDVfEZI6/8K/c8fz+OGN9JP3nLf
 aBoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771321889; x=1771926689;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MqKGZs0n4DofZPkoSFoT/fTZEG3Fs+4rNgilmKZe4Ic=;
 b=S3Cwv3dt7RHtZc92igYNi9iwX46JWxsDYw/Tu4CuQxP00dBSD0/dFIit/Dc2p74jEw
 lnTpxzjubt0Lr7ktc4LSLZmSopnpfFe8CNDrOzLGlDlDNhkkdFzuJ4MUwJxR1rarDSUM
 J1S8EHdfddLLQkxIb+U4pv/CuwugMvltVQ4JBfoZ1hDnca8adkiS9w2rl5pnmaWW/c/s
 lSPWFZbJzb3x0FOYITdy9RuV0giR8nqZxF033VF2o7F5Tv4HVzvpu+ZXc4nEvnrNbBTp
 7Hmg5rfMiNNY+tTCgYhZOwRasaCKC6OBxa7uPjzwKSMeH/D8gSmf7VdZq2M9G0j+15tI
 EewA==
X-Gm-Message-State: AOJu0YykyyoVwgiBvJTNXlONhTG4JdgTr4YhL3DKn0k2R7YLfAd16nE9
 B1NXB2opeZKLSGUuZLGYV7pRCgW1k8xPL4Vfo+PsSQ18P2sGhMuCZEi36P8Y1PUJvOBJpf0xYCH
 TGzv27kA=
X-Gm-Gg: AZuq6aLHc4Sq9acEswjIu+F36c2R2s0QgDkqWmvhBSHvlsdqOCpVmL6YUtD0midWmVl
 8/SvtzrQ5N3WltohtrsT6TO183bsgo+M1XoaoU/Zw0z9ReQUWiJPN0zUapv1l+JXuJ14iY88AhX
 njJZrwE5q5oPo43wknXUcK4utmnyarZieHO7kPxJ355dNES0KvPCKYwHww3mRH4Tp7nTMf9TZa+
 wbwL+wNrZHXD0DWXmUQiHq+qM56wzPZHQZremUdsM/wwpqEV1QWQ39qMHgumgRIOxmNmPpC9tae
 1kv8C7ZxRXen5WSt5AM7FC8qOU6OQWh18flr+TbpXIOYUJkuEhmIBQf46XeUkFSPREpW5V5qQ68
 X9IPyQM73oe579cvD+JCZve2pWRkdgXk/iQjfx4hABaBho8cqU1iXTJSPv4unudsMlmZ4gJxGby
 lr3JKdEqdxgbwitotoKLXVXDDDbqg7pcRsNk4XT8fm7+TJ7yJbcSw8POPSfPqxox6yOG6JDsg+X
 GWgjjYuOWDeH3ctd/2TsrGqezMJaqHihwcEVCnMd4m01thjGw==
X-Received: by 2002:a17:903:1a44:b0:2a9:5e25:4708 with SMTP id
 d9443c01a7336-2ab504e89fbmr139591365ad.3.1771321888706; 
 Tue, 17 Feb 2026 01:51:28 -0800 (PST)
Received: from localhost.localdomain
 (2403-580b-742d-0-10a2-dce1-aa4a-dd32.ip6.aussiebb.net.
 [2403:580b:742d:0:10a2:dce1:aa4a:dd32])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ad1a6fa33esm99108675ad.13.2026.02.17.01.51.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Feb 2026 01:51:28 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH v2 7/7] target-info: Eliminate TARGET_PAGE_BITS_LEGACY
Date: Tue, 17 Feb 2026 19:51:06 +1000
Message-ID: <20260217095106.598486-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260217095106.598486-1-richard.henderson@linaro.org>
References: <20260217095106.598486-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

Expand TARGET_PAGE_BITS_LEGACY directly within the two Arm
TargetInfo structures; remove it from target/arm/cpu-param.h.
Do not allow new uses with target-info-stub.c.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/qemu/target-info-impl.h   |  2 +-
 target/arm/cpu-param.h            |  1 -
 configs/targets/aarch64-softmmu.c |  3 +--
 configs/targets/arm-softmmu.c     |  3 +--
 target-info-stub.c                | 12 ++++++------
 5 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/include/qemu/target-info-impl.h b/include/qemu/target-info-impl.h
index c917d546ea..a7c519cd0b 100644
--- a/include/qemu/target-info-impl.h
+++ b/include/qemu/target-info-impl.h
@@ -27,7 +27,7 @@ typedef struct TargetInfo {
     EndianMode endianness;
     /*
      * runtime equivalent of
-     *   TARGET_PAGE_BITS_VARY ? TARGET_PAGE_BITS_LEGACY : TARGET_PAGE_BITS
+     *   TARGET_PAGE_BITS_VARY ? minimum for the target : TARGET_PAGE_BITS
      */
     unsigned page_bits_init;
     /* runtime equivalent of TARGET_PAGE_BITS_VARY definition */
diff --git a/target/arm/cpu-param.h b/target/arm/cpu-param.h
index 8b46c7c570..07af31aa3e 100644
--- a/target/arm/cpu-param.h
+++ b/target/arm/cpu-param.h
@@ -29,7 +29,6 @@
  * have to support 1K tiny pages.
  */
 # define TARGET_PAGE_BITS_VARY
-# define TARGET_PAGE_BITS_LEGACY 10
 #endif /* !CONFIG_USER_ONLY */
 
 /*
diff --git a/configs/targets/aarch64-softmmu.c b/configs/targets/aarch64-softmmu.c
index 82ccb57575..561af56e1a 100644
--- a/configs/targets/aarch64-softmmu.c
+++ b/configs/targets/aarch64-softmmu.c
@@ -10,7 +10,6 @@
 #include "qemu/target-info-impl.h"
 #include "hw/arm/machines-qom.h"
 #include "target/arm/cpu-qom.h"
-#include "target/arm/cpu-param.h"
 
 static const TargetInfo target_info_aarch64_system = {
     .target_name = "aarch64",
@@ -20,7 +19,7 @@ static const TargetInfo target_info_aarch64_system = {
     .machine_typename = TYPE_TARGET_AARCH64_MACHINE,
     .endianness = ENDIAN_MODE_LITTLE,
     .page_bits_vary = true,
-    .page_bits_init = TARGET_PAGE_BITS_LEGACY,
+    .page_bits_init = 10,
 };
 
 const TargetInfo *target_info(void)
diff --git a/configs/targets/arm-softmmu.c b/configs/targets/arm-softmmu.c
index 18940e51e5..488217c7a0 100644
--- a/configs/targets/arm-softmmu.c
+++ b/configs/targets/arm-softmmu.c
@@ -10,7 +10,6 @@
 #include "qemu/target-info-impl.h"
 #include "hw/arm/machines-qom.h"
 #include "target/arm/cpu-qom.h"
-#include "target/arm/cpu-param.h"
 
 static const TargetInfo target_info_arm_system = {
     .target_name = "arm",
@@ -20,7 +19,7 @@ static const TargetInfo target_info_arm_system = {
     .machine_typename = TYPE_TARGET_ARM_MACHINE,
     .endianness = ENDIAN_MODE_LITTLE,
     .page_bits_vary = true,
-    .page_bits_init = TARGET_PAGE_BITS_LEGACY,
+    .page_bits_init = 10,
 };
 
 const TargetInfo *target_info(void)
diff --git a/target-info-stub.c b/target-info-stub.c
index f5896a7262..d948ebef5f 100644
--- a/target-info-stub.c
+++ b/target-info-stub.c
@@ -29,14 +29,14 @@ static const TargetInfo target_info_stub = {
     .cpu_type = CPU_RESOLVING_TYPE,
     .machine_typename = TYPE_MACHINE,
     .endianness = TARGET_BIG_ENDIAN ? ENDIAN_MODE_BIG : ENDIAN_MODE_LITTLE,
-#ifdef TARGET_PAGE_BITS_VARY
-    .page_bits_vary = true,
-# ifdef TARGET_PAGE_BITS_LEGACY
-    .page_bits_init = TARGET_PAGE_BITS_LEGACY,
-# endif
-#else
+#ifndef TARGET_PAGE_BITS_VARY
     .page_bits_vary = false,
     .page_bits_init = TARGET_PAGE_BITS,
+#elif defined(CONFIG_USER_ONLY)
+    .page_bits_vary = true,
+    /* page_bits_init is unused; page size always set by main */
+#else
+# error "page_bits_init must be set in configs/target"
 #endif
 };
 
-- 
2.43.0


