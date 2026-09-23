Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22884C9830B
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 13:23:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9MwC-0004tr-OL; Wed, 23 Sep 2026 09:23:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x9MsS-0000iV-Jp
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 09:19:21 -0400
Received: from mail-dl2-x0f.google.com ([2607:f8b0:4864:38::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x9MsI-00070b-MU
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 09:19:05 -0400
Received: by mail-dl2-x0f.google.com with SMTP id
 a92af1059eb24-144f9160b81so327265c88.0
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 06:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790169540; x=1790774340; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/Pnb4009fcr63720pQihUF6v8EokAjQS6rcfppqNlzc=;
 b=Qf380Vfr2w4rMB7+dY2+twG5ws1iWd4bY4AaRN+xIOmdX+dBGxwMDDMOpx6W5j0dbZ
 JyyOZbVPjEj0+uff1JeeZgMMgTuduP3ZBflrKdz7XGJ+lBRO6drcoPcug3lsxBrk89NF
 bUrSa+Vt97BWmH+KKVcPh+QyuoZ5nNWh0zfC0fm5cqCYf6p/TmCkmhJb6b9+CefITJPs
 04W23XzdvAn3EZWUVXkjFcU7BM39HKebR5iClDjSxHr1ZPYBMUuwf83/RIWJA+hZa9cA
 okb6FNXsYU5dhwaT2iVLZTIPFTY8xy5KQtVpPvcr6Tb9hrMmQdSPVRsalU9A9FPykzjB
 xypQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790169540; x=1790774340;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/Pnb4009fcr63720pQihUF6v8EokAjQS6rcfppqNlzc=;
 b=WpwzKSJwIt57CqtlToqjiKUuKkwGIrbsvTjV7m9iJc8GSbRovxJuyThmTUlQb61vC/
 tWkVOx5HTkpA1HvqfR8Dg7PU8mmqmbnoMAgwWdDeiGaR4yT9E1poKJxlo2uHbMyDDH/e
 qwRJQtTIifFiK2jY5fJGlgVTk5eLc6AHw+dh6WXhcHRAWS7aUVQ/jUsQQV2qnORjGutD
 W2pDkIrReHAX1450ywZ0bPHATHZhtmlPLOFNSmmHH7QG5VTyGOfZAGg/m3kUu6kPCuxj
 HtkuICwR4YUJC6xn6kSFj14huQGGJK2IwOKyxA9jwMdTK9lHMNrO75ItTkYDvDXP0RDk
 FAMQ==
X-Gm-Message-State: AFuF++k1oAFrcuFIqNS0pEqU3bJYdBIfLGnMK4sQA/RzLktldMIduvSV
 AwpIJdBDTVO0GCHBYkPNBWUKqSY803fO7Wso4Vt5WF0kjFBq3gF/pEahEsXmywUIRP4=
X-Gm-Gg: AYBFou2qR7JMfYOBCz1kt9T/KBTR++z1WR8FbdrIdRgXFiH5CEhOfygfsOnnPRy3caA
 nQvv9jQsQUEi6ccCaTRSVCMH40wRJvnyCKWMR9f3hs3d81r4LXYfi4NjgJxzNxNgR1Phft7NcJB
 Yc7vbkvZjgq22lzflO25+XgK6RyxdG4vE4d3kAyabDBrss3TuaHxmhtVkFD58JC3R7TlIMeQ63j
 uln5LqHC8UaSAimyjfu3j9z75Lg6yt3eH3bdx257aNIld1ySIMjp7DGoLiizFfIGeXZwrDOU1Ka
 +gbnEA4aabX95MSYMcbO0hFWmnXrN05O/BvcKeyv8hZuY91gePJUc7krypFb6HFGqI3SHVAZqft
 D0trrnt3mmyO0EGWNjisUX3YyHJ8YxCR2XgmZqhKZNq0eQpNO9Wne0VEb8KOpn98ZXvPEvvtJL5
 sj/j5qD87kzizLG2xmcrk5G16ZjBbpXY71Akr310KJqoiwKDz7pwzo48ahg0Esvs9L+zAqSlcGn
 OFitYHCWgAvApDASrvCZzzNTkzwRZw=
X-Received: by 2002:a05:7022:fa9:b0:143:2973:3240 with SMTP id
 a92af1059eb24-144f91551e9mr4241198c88.29.1790169539996; 
 Wed, 23 Sep 2026 06:18:59 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-33e97236754sm5553695eec.29.2026.09.23.06.18.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 06:18:58 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, xen-devel@lists.xenproject.org,
 Chao Liu <chao.liu@processmission.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Peter Xu <peterx@redhat.com>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Sunil V L <sunilvl@ventanamicro.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Fabiano Rosas <farosas@suse.de>, Xianglai Li <lixianglai@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 qemu-ppc@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Bibo Mao <maobibo@loongson.cn>,
 "Michael S. Tsirkin" <mst@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 David Hildenbrand <david@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-riscv@nongnu.org,
 kvm@vger.kernel.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stafford Horne <shorne@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 Song Gao <17746591750@163.com>, qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH v3 013/114] target-info: add target_is_* helpers for each
 architecture
Date: Wed, 23 Sep 2026 21:14:47 +0800
Message-ID: <20260923131635.1894-14-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260923131635.1894-1-luoyonggang@gmail.com>
References: <20260923131635.1894-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:38::f;
 envelope-from=luoyonggang@gmail.com; helo=mail-dl2-x0f.google.com
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


