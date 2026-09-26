Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BFAAC98328
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2026 07:02:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAMQ3-0002c5-LM; Sat, 26 Sep 2026 03:02:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xAMQ1-0002Vi-C1
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 03:01:57 -0400
Received: from mail-dy2-x0f.google.com ([2607:f8b0:4864:36::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xAMPy-0000Sy-Os
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 03:01:56 -0400
Received: by mail-dy2-x0f.google.com with SMTP id
 5a478bee46e88-33e46a15703so1348013eec.0
 for <qemu-devel@nongnu.org>; Sat, 26 Sep 2026 00:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790406113; x=1791010913; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/Pnb4009fcr63720pQihUF6v8EokAjQS6rcfppqNlzc=;
 b=ZNntrcBwj1hwW3xIaSR8PHR1cw4NKI0O0d/JtoQHdY7lzO7m0N5VC3bINqr544To5a
 LASeGKhXDiFfHpm3nANHyxAqxgReMGchxWjWxYE0/9HT3Std0W91tX+Fex2eaxQenPcp
 fRGDqepLy80HRfKmHCYJ6MXwd6iVloCIb4eC/8/wy7DY3ppjidzCAhTcH8NlaMWcv6L/
 xucv8GL1TQizmIPWDMWPxFpCpFG53sCu+r392YIbNtU2Jms54BHS6F440F0zH5wlT7Cv
 izAol2F9fZWua0hJgRtNvsLv4Bytc5D4/AS114HTXbt14LcchvyCoAYgE0NJPSxHhpeO
 VTaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790406113; x=1791010913;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/Pnb4009fcr63720pQihUF6v8EokAjQS6rcfppqNlzc=;
 b=OFBqsJPWiDDffhfAd2q4nFBmbN9TRPoYDTJ6aJPnu9lyoBjXdm4g6RqLSU4sxfpotS
 HRn9vP/xZso0CC0ZuFLmzqD1DOpXx3keGhLt/LG1tKEzLi1lnvu5+V0DzBUf6ezrs8Xa
 UvMONgjMEFvXGLUu8FlAuECsYbUJcuWYf5gdmJCHKMFXL02pZhk4FvG1chh+ldWGr9xb
 HJa/BtcoPtDQLbMlgezCMOf2Uf/xiGa3tqZyg3xC/ixSqBGwMX3Z8qCX5wMqC08Vyk0N
 oMz8DvoQWxS92WJS/GKcutgBrIKmthIF8QL0HWTUrXkCacUhckIKlb+zOg5p2ZKPGOJL
 HBOQ==
X-Gm-Message-State: AFuF++nKJJn43Ppug/W6Htgej6k7IuSIfCHC9doAw29PwfhgMk9UzIlC
 ALAGbM2Hu59de3PF7W75D1KSK/IKLa3XJQ7fQhXR93YRwqqndlyiq8nGXn99Fx8R
X-Gm-Gg: AYBFou2929iAGYvaX5alSfWW7p5C9QsDDteAbFxkQk5U5C76LOr195VPm1+htU33Ddv
 cmPVcLgtARTD4RRUz+BJookOGg6q4k35+a+BIuarFXAjAS9DmWrR3tS1Mb1KzRrYPiKAY6NtGsE
 9c+4cP0rsbnWk7UFQrV05QEuT2IiH2VHi8krTLdS0Fhc08s4TzwJptYB6uDh75sWatzpJGVIGOp
 aplkEBxHyN0D3R+DXIcrBG4ZLKTEPir5wMuT77NmLtD6QeRqpLawxM/SsrnUWTqAyLMHuTxQvgh
 99CUYVbx1yE5+D+pFeMP1f8RbvOPs/lTCiWNLwTCN8gCkOlH45//jYhFQ8p/jY7CanYfOLYSZ69
 JSfCDvaglN9AkGsKut/0rYxO5evcUQdv/lwDDb28dxjJz6dMGL6ug0+Iv5rKSAn6sbAdC1NZDq0
 Q9ioNf3Mf880QN3neK4/DZ2ZsnfSz8arowSDfb6y2k0eLXSXput52Oqtz1ab7X7/6IYB+x9SQ/p
 C4r7iXvtcBGDTtyRsZD03YLiK6gCOw=
X-Received: by 2002:a05:7301:712:b0:33c:3134:f45 with SMTP id
 5a478bee46e88-3426fccb01cmr1967524eec.5.1790406108596; 
 Sat, 26 Sep 2026 00:01:48 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-34145c166cfsm10615141eec.28.2026.09.26.00.01.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Sep 2026 00:01:47 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org, kvm@vger.kernel.org
Subject: [PATCH v4 11/55] target-info: add target_is_* helpers for each
 architecture
Date: Sat, 26 Sep 2026 15:00:10 +0800
Message-ID: <20260926070057.1234-12-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260926070057.1234-1-luoyonggang@gmail.com>
References: <20260926070057.1234-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:36::f;
 envelope-from=luoyonggang@gmail.com; helo=mail-dy2-x0f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This is added for latter use with is_available.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 include/qemu/target-info.h | 91 +++++++++++++++++++++++++++++++++++++-
 target-info.c              | 83 +++++++++++++++++++++++++++++-----
 2 files changed, 161 insertions(+), 13 deletions(-)

diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
index c48973f20be..89656da1ca4 100644
--- a/include/qemu/target-info.h
+++ b/include/qemu/target-info.h
@@ -53,6 +53,14 @@ const char *target_cpu_type(void);
  */
 bool target_big_endian(void);
 
+/**
+ * target_is_base_arm:
+ * @ti: TargetInfo to inspect
+ *
+ * Returns whether @ti is ARM or Aarch64.
+ */
+bool target_is_base_arm(const TargetInfo *ti);
+
 /**
  * target_base_arm:
  *
@@ -60,6 +68,14 @@ bool target_big_endian(void);
  */
 bool target_base_arm(void);
 
+/**
+ * target_is_arm:
+ * @ti: TargetInfo to inspect
+ *
+ * Returns whether @ti is ARM (32-bit, not Aarch64).
+ */
+bool target_is_arm(const TargetInfo *ti);
+
 /**
  * target_arm:
  *
@@ -67,6 +83,14 @@ bool target_base_arm(void);
  */
 bool target_arm(void);
 
+/**
+ * target_is_aarch64:
+ * @ti: TargetInfo to inspect
+ *
+ * Returns whether @ti is Aarch64.
+ */
+bool target_is_aarch64(const TargetInfo *ti);
+
 /**
  * target_aarch64:
  *
@@ -74,6 +98,14 @@ bool target_arm(void);
  */
 bool target_aarch64(void);
 
+/**
+ * target_is_base_ppc:
+ * @ti: TargetInfo to inspect
+ *
+ * Returns whether @ti is PowerPC 32-bit or 64-bit.
+ */
+bool target_is_base_ppc(const TargetInfo *ti);
+
 /**
  * target_base_ppc:
  *
@@ -81,6 +113,14 @@ bool target_aarch64(void);
  */
 bool target_base_ppc(void);
 
+/**
+ * target_is_ppc:
+ * @ti: TargetInfo to inspect
+ *
+ * Returns whether @ti is PowerPC 32-bit.
+ */
+bool target_is_ppc(const TargetInfo *ti);
+
 /**
  * target_ppc:
  *
@@ -88,6 +128,14 @@ bool target_base_ppc(void);
  */
 bool target_ppc(void);
 
+/**
+ * target_is_ppc64:
+ * @ti: TargetInfo to inspect
+ *
+ * Returns whether @ti is PowerPC 64-bit.
+ */
+bool target_is_ppc64(const TargetInfo *ti);
+
 /**
  * target_ppc64:
  *
@@ -95,6 +143,14 @@ bool target_ppc(void);
  */
 bool target_ppc64(void);
 
+/**
+ * target_is_s390x:
+ * @ti: TargetInfo to inspect
+ *
+ * Returns whether @ti is S390x.
+ */
+bool target_is_s390x(const TargetInfo *ti);
+
 /**
  * target_s390x:
  *
@@ -102,17 +158,48 @@ bool target_ppc64(void);
  */
 bool target_s390x(void);
 
+/**
+ * target_is_base_riscv:
+ * @ti: TargetInfo to inspect
+ *
+ * Returns whether @ti is RISC-V 32-bit or 64-bit.
+ */
+bool target_is_base_riscv(const TargetInfo *ti);
+
+/**
+ * target_base_riscv:
+ *
+ * Returns whether the target architecture is RISC-V 32-bit or 64-bit.
+ */
+bool target_base_riscv(void);
+
+/**
+ * target_is_riscv32:
+ * @ti: TargetInfo to inspect
+ *
+ * Returns whether @ti is RISC-V 32-bit.
+ */
+bool target_is_riscv32(const TargetInfo *ti);
+
 /**
  * target_riscv32:
  *
- * Returns whether the target architecture is riscv32
+ * Returns whether the target architecture is RISC-V 32-bit.
  */
 bool target_riscv32(void);
 
+/**
+ * target_is_riscv64:
+ * @ti: TargetInfo to inspect
+ *
+ * Returns whether @ti is RISC-V 64-bit.
+ */
+bool target_is_riscv64(const TargetInfo *ti);
+
 /**
  * target_riscv64:
  *
- * Returns whether the target architecture is riscv64
+ * Returns whether the target architecture is RISC-V 64-bit.
  */
 bool target_riscv64(void);
 
diff --git a/target-info.c b/target-info.c
index 6e66f48e1ff..6d57cad5d33 100644
--- a/target-info.c
+++ b/target-info.c
@@ -96,9 +96,9 @@ bool target_big_endian(void)
     return target_endian_mode() == ENDIAN_MODE_BIG;
 }
 
-bool target_base_arm(void)
+bool target_is_base_arm(const TargetInfo *ti)
 {
-    switch (target_arch()) {
+    switch (ti->target_arch) {
     case SYS_EMU_TARGET_ARM:
     case SYS_EMU_TARGET_AARCH64:
         return true;
@@ -107,19 +107,34 @@ bool target_base_arm(void)
     }
 }
 
+bool target_base_arm(void)
+{
+    return target_is_base_arm(target_info());
+}
+
+bool target_is_arm(const TargetInfo *ti)
+{
+    return ti->target_arch == SYS_EMU_TARGET_ARM;
+}
+
 bool target_arm(void)
 {
-    return target_arch() == SYS_EMU_TARGET_ARM;
+    return target_is_arm(target_info());
+}
+
+bool target_is_aarch64(const TargetInfo *ti)
+{
+    return ti->target_arch == SYS_EMU_TARGET_AARCH64;
 }
 
 bool target_aarch64(void)
 {
-    return target_arch() == SYS_EMU_TARGET_AARCH64;
+    return target_is_aarch64(target_info());
 }
 
-bool target_base_ppc(void)
+bool target_is_base_ppc(const TargetInfo *ti)
 {
-    switch (target_arch()) {
+    switch (ti->target_arch) {
     case SYS_EMU_TARGET_PPC:
     case SYS_EMU_TARGET_PPC64:
         return true;
@@ -128,27 +143,73 @@ bool target_base_ppc(void)
     }
 }
 
+bool target_base_ppc(void)
+{
+    return target_is_base_ppc(target_info());
+}
+
+bool target_is_ppc(const TargetInfo *ti)
+{
+    return ti->target_arch == SYS_EMU_TARGET_PPC;
+}
+
 bool target_ppc(void)
 {
-    return target_arch() == SYS_EMU_TARGET_PPC;
+    return target_is_ppc(target_info());
+}
+
+bool target_is_ppc64(const TargetInfo *ti)
+{
+    return ti->target_arch == SYS_EMU_TARGET_PPC64;
 }
 
 bool target_ppc64(void)
 {
-    return target_arch() == SYS_EMU_TARGET_PPC64;
+    return target_is_ppc64(target_info());
+}
+
+bool target_is_s390x(const TargetInfo *ti)
+{
+    return ti->target_arch == SYS_EMU_TARGET_S390X;
 }
 
 bool target_s390x(void)
 {
-    return target_arch() == SYS_EMU_TARGET_S390X;
+    return target_is_s390x(target_info());
+}
+
+bool target_is_base_riscv(const TargetInfo *ti)
+{
+    switch (ti->target_arch) {
+    case SYS_EMU_TARGET_RISCV32:
+    case SYS_EMU_TARGET_RISCV64:
+        return true;
+    default:
+        return false;
+    }
+}
+
+bool target_base_riscv(void)
+{
+    return target_is_base_riscv(target_info());
+}
+
+bool target_is_riscv32(const TargetInfo *ti)
+{
+    return ti->target_arch == SYS_EMU_TARGET_RISCV32;
 }
 
 bool target_riscv32(void)
 {
-    return target_arch() == SYS_EMU_TARGET_RISCV32;
+    return target_is_riscv32(target_info());
+}
+
+bool target_is_riscv64(const TargetInfo *ti)
+{
+    return ti->target_arch == SYS_EMU_TARGET_RISCV64;
 }
 
 bool target_riscv64(void)
 {
-    return target_arch() == SYS_EMU_TARGET_RISCV64;
+    return target_is_riscv64(target_info());
 }
-- 
2.52.0.windows.1


