Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BC0ACA5FE4
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Jan 2026 19:37:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhYZS-00068e-CF; Sun, 18 Jan 2026 14:36:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vhYZ3-0005vU-L4
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 14:36:01 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vhYZ1-0006fj-GB
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 14:35:57 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-432755545fcso1960485f8f.1
 for <qemu-devel@nongnu.org>; Sun, 18 Jan 2026 11:35:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768764953; x=1769369753; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=igCseaXkituHRUHlgN3vHTspEqy2I4p8ueKPXus93fI=;
 b=SlIHHQ+GCv2Zmrlqq3QCwiy8x6YYDIsLcp+7I+kz8cv18jclxeSOD++16i9CA0EFOy
 Mlw16HcrGHxuxXcB0XDdkEK9XpVm9um4aE2R/o9QJTalDzrCcZmuzO+U2NL8SJZAn/+H
 pbdo0wmQHmETRBAiP1hhpSk6JI9okqxuUWijBDt4Cn+e9Ru/D0cHdptJYhPU5mdNf/JH
 o9ENyE/i1JJ6qMiekLITVScjNaPJf2wCYTC7zQI28QXRZxt7PjlEX+Nj3zywHmDlBGCd
 H6OU91Ky+bg3cmBe2hxgsXVFcScJ8cTIxPvYxdwsOcqQg0bl9v7aeYO9IOcIulJg7dg3
 Q9/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768764953; x=1769369753;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=igCseaXkituHRUHlgN3vHTspEqy2I4p8ueKPXus93fI=;
 b=QaMth10H3VLpsvtDnXMAIetcjTJECkJOvd7OcRym4LSjnCTwKXYMedHyASmeP1W2pA
 yGhxVKTNE6eDLZgncnnJHdNjZkR8Oa67rzLZI23IubyGmtTRZxTytmFupMHErh0/CNkm
 6riHekX8wre3fA0MCQbIVOM5E07K/9WfZdUJiZZ7Q31ElRJQD1t24iROSAFBiL4Imiof
 BGaeFPHG8FNTzChJwaxkKiLF7O7ydpvqwsIUiZa0G1iCW8iG4L76TP72AhL7BX+xkjIc
 0nnhu7Uow7mylZj46uB/tnNE+MQgDJwD6XXth5Ld1z6IwdmtfG0XJbeaD0QMWJVxn355
 t4oQ==
X-Gm-Message-State: AOJu0Yx49+RSZbcdfF7XcSkwCoseHd3wC+gThn2yGqmm5w3pfrp4OH/G
 xADz2CrY93hPngYWrjhkBr4rnnVXOJ3mLxkkVneQ6Mx3bj5iEoSB1ocQT5gytKFtCj4x+9Z7V9o
 fherewCY=
X-Gm-Gg: AY/fxX5MzQ8ugLjs5YAAPDpfy1Y2uPoMIq68KnrRgjqWjujvzftvJn9w2dO7c2drs/H
 yKSTQ9PoxOUj3JeFG1teFKIlaCnZJLcZYTIe2dISXCnt3mpPMrXpcwFGtivnluM7+p+kClCDosx
 G+7D3Qya1iDVLPl0cAY+iSsRrvF8aIMKKQ+nkgXsZiDLEMkpFKGAmMA3Dn5iTK4fQC6XlQibl0k
 nNL4MqhS5ukhLxsmBCHhFgD36C9DSii4eBLSruKhnyHrUXORkFA7lSpD3GgbZAdNDm8ZT5xNbQy
 gTeaSzJrBudtCyhRZO9ElDG5kG7lIpwUUSdxgvM+rBsXNoCf7DnsSXQChEFBjq+0yzOlJhuqyBw
 wzMSs9a2cA5FnsjNp++bvYjAJEQQEbGSZNP1GU5TOMaWRV0prpmJpIHxfU9H6MTc2l4hgMtAHgr
 0hV0UYnWDHjb3h5msy3MKEh6bo7EumBybFsggjyMxQHZRrOKatcBQxeBJG1GmHI3jwOa1LSbk=
X-Received: by 2002:a05:6000:1845:b0:431:491:7e8c with SMTP id
 ffacd0b85a97d-43569bd30cbmr11067498f8f.63.1768764952967; 
 Sun, 18 Jan 2026 11:35:52 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356992c6f2sm18425785f8f.19.2026.01.18.11.35.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 18 Jan 2026 11:35:52 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 06/18] system/memory: Define address_space_ldst[L] endian
 variants via template
Date: Sun, 18 Jan 2026 20:34:56 +0100
Message-ID: <20260118193509.42923-7-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260118193509.42923-1-philmd@linaro.org>
References: <20260118193509.42923-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

Define address_space_ldst[L] endian variants via template.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/system/memory_ldst.h.inc             | 12 ------
 include/system/memory_ldst_endian.h.inc      |  4 ++
 include/system/memory_ldst_phys.h.inc        | 36 -----------------
 include/system/memory_ldst_phys_endian.h.inc | 10 +++++
 system/memory_ldst.c.inc                     | 42 --------------------
 system/memory_ldst_endian.c.inc              | 14 +++++++
 6 files changed, 28 insertions(+), 90 deletions(-)

diff --git a/include/system/memory_ldst.h.inc b/include/system/memory_ldst.h.inc
index 73c0366a247..7ccca46f2a9 100644
--- a/include/system/memory_ldst.h.inc
+++ b/include/system/memory_ldst.h.inc
@@ -19,30 +19,18 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
-uint32_t glue(address_space_ldl, SUFFIX)(ARG1_DECL,
-    hwaddr addr, MemTxAttrs attrs, MemTxResult *result);
 uint64_t glue(address_space_ldq, SUFFIX)(ARG1_DECL,
     hwaddr addr, MemTxAttrs attrs, MemTxResult *result);
-void glue(address_space_stl, SUFFIX)(ARG1_DECL,
-    hwaddr addr, uint32_t val, MemTxAttrs attrs, MemTxResult *result);
 void glue(address_space_stq, SUFFIX)(ARG1_DECL,
     hwaddr addr, uint64_t val, MemTxAttrs attrs, MemTxResult *result);
 uint8_t glue(address_space_ldub, SUFFIX)(ARG1_DECL,
     hwaddr addr, MemTxAttrs attrs, MemTxResult *result);
-uint32_t glue(address_space_ldl_le, SUFFIX)(ARG1_DECL,
-    hwaddr addr, MemTxAttrs attrs, MemTxResult *result);
-uint32_t glue(address_space_ldl_be, SUFFIX)(ARG1_DECL,
-    hwaddr addr, MemTxAttrs attrs, MemTxResult *result);
 uint64_t glue(address_space_ldq_le, SUFFIX)(ARG1_DECL,
     hwaddr addr, MemTxAttrs attrs, MemTxResult *result);
 uint64_t glue(address_space_ldq_be, SUFFIX)(ARG1_DECL,
     hwaddr addr, MemTxAttrs attrs, MemTxResult *result);
 void glue(address_space_stb, SUFFIX)(ARG1_DECL,
     hwaddr addr, uint8_t val, MemTxAttrs attrs, MemTxResult *result);
-void glue(address_space_stl_le, SUFFIX)(ARG1_DECL,
-    hwaddr addr, uint32_t val, MemTxAttrs attrs, MemTxResult *result);
-void glue(address_space_stl_be, SUFFIX)(ARG1_DECL,
-    hwaddr addr, uint32_t val, MemTxAttrs attrs, MemTxResult *result);
 void glue(address_space_stq_le, SUFFIX)(ARG1_DECL,
     hwaddr addr, uint64_t val, MemTxAttrs attrs, MemTxResult *result);
 void glue(address_space_stq_be, SUFFIX)(ARG1_DECL,
diff --git a/include/system/memory_ldst_endian.h.inc b/include/system/memory_ldst_endian.h.inc
index 3f216197663..845ec3b4ad1 100644
--- a/include/system/memory_ldst_endian.h.inc
+++ b/include/system/memory_ldst_endian.h.inc
@@ -16,8 +16,12 @@
 
 uint16_t ADDRESS_SPACE_LD(uw)(ARG1_DECL, hwaddr addr,
                               MemTxAttrs attrs, MemTxResult *result);
+uint32_t ADDRESS_SPACE_LD(l)(ARG1_DECL, hwaddr addr,
+                             MemTxAttrs attrs, MemTxResult *result);
 void ADDRESS_SPACE_ST(w)(ARG1_DECL, hwaddr addr, uint16_t val,
                          MemTxAttrs attrs, MemTxResult *result);
+void ADDRESS_SPACE_ST(l)(ARG1_DECL, hwaddr addr, uint32_t val,
+                         MemTxAttrs attrs, MemTxResult *result);
 
 #undef ADDRESS_SPACE_LD
 #undef ADDRESS_SPACE_ST
diff --git a/include/system/memory_ldst_phys.h.inc b/include/system/memory_ldst_phys.h.inc
index 71c2e64ff0f..c3c73419e61 100644
--- a/include/system/memory_ldst_phys.h.inc
+++ b/include/system/memory_ldst_phys.h.inc
@@ -19,24 +19,12 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
-static inline uint32_t glue(ldl_phys, SUFFIX)(ARG1_DECL, hwaddr addr)
-{
-    return glue(address_space_ldl, SUFFIX)(ARG1, addr,
-                                           MEMTXATTRS_UNSPECIFIED, NULL);
-}
-
 static inline uint64_t glue(ldq_phys, SUFFIX)(ARG1_DECL, hwaddr addr)
 {
     return glue(address_space_ldq, SUFFIX)(ARG1, addr,
                                            MEMTXATTRS_UNSPECIFIED, NULL);
 }
 
-static inline void glue(stl_phys, SUFFIX)(ARG1_DECL, hwaddr addr, uint32_t val)
-{
-    glue(address_space_stl, SUFFIX)(ARG1, addr, val,
-                                    MEMTXATTRS_UNSPECIFIED, NULL);
-}
-
 static inline void glue(stq_phys, SUFFIX)(ARG1_DECL, hwaddr addr, uint64_t val)
 {
     glue(address_space_stq, SUFFIX)(ARG1, addr, val,
@@ -49,18 +37,6 @@ static inline uint8_t glue(ldub_phys, SUFFIX)(ARG1_DECL, hwaddr addr)
                                             MEMTXATTRS_UNSPECIFIED, NULL);
 }
 
-static inline uint32_t glue(ldl_le_phys, SUFFIX)(ARG1_DECL, hwaddr addr)
-{
-    return glue(address_space_ldl_le, SUFFIX)(ARG1, addr,
-                                              MEMTXATTRS_UNSPECIFIED, NULL);
-}
-
-static inline uint32_t glue(ldl_be_phys, SUFFIX)(ARG1_DECL, hwaddr addr)
-{
-    return glue(address_space_ldl_be, SUFFIX)(ARG1, addr,
-                                              MEMTXATTRS_UNSPECIFIED, NULL);
-}
-
 static inline uint64_t glue(ldq_le_phys, SUFFIX)(ARG1_DECL, hwaddr addr)
 {
     return glue(address_space_ldq_le, SUFFIX)(ARG1, addr,
@@ -79,18 +55,6 @@ static inline void glue(stb_phys, SUFFIX)(ARG1_DECL, hwaddr addr, uint8_t val)
                                     MEMTXATTRS_UNSPECIFIED, NULL);
 }
 
-static inline void glue(stl_le_phys, SUFFIX)(ARG1_DECL, hwaddr addr, uint32_t val)
-{
-    glue(address_space_stl_le, SUFFIX)(ARG1, addr, val,
-                                       MEMTXATTRS_UNSPECIFIED, NULL);
-}
-
-static inline void glue(stl_be_phys, SUFFIX)(ARG1_DECL, hwaddr addr, uint32_t val)
-{
-    glue(address_space_stl_be, SUFFIX)(ARG1, addr, val,
-                                       MEMTXATTRS_UNSPECIFIED, NULL);
-}
-
 static inline void glue(stq_le_phys, SUFFIX)(ARG1_DECL, hwaddr addr, uint64_t val)
 {
     glue(address_space_stq_le, SUFFIX)(ARG1, addr, val,
diff --git a/include/system/memory_ldst_phys_endian.h.inc b/include/system/memory_ldst_phys_endian.h.inc
index 25ab52a88d9..1589f34e8e4 100644
--- a/include/system/memory_ldst_phys_endian.h.inc
+++ b/include/system/memory_ldst_phys_endian.h.inc
@@ -24,11 +24,21 @@ static inline uint16_t LD_PHYS(uw)(ARG1_DECL, hwaddr addr)
     return ADDRESS_SPACE_LD(uw)(ARG1, addr, MEMTXATTRS_UNSPECIFIED, NULL);
 }
 
+static inline uint32_t LD_PHYS(l)(ARG1_DECL, hwaddr addr)
+{
+    return ADDRESS_SPACE_LD(l)(ARG1, addr, MEMTXATTRS_UNSPECIFIED, NULL);
+}
+
 static inline void ST_PHYS(w)(ARG1_DECL, hwaddr addr, uint16_t val)
 {
     ADDRESS_SPACE_ST(w)(ARG1, addr, val, MEMTXATTRS_UNSPECIFIED, NULL);
 }
 
+static inline void ST_PHYS(l)(ARG1_DECL, hwaddr addr, uint32_t val)
+{
+    ADDRESS_SPACE_ST(l)(ARG1, addr, val, MEMTXATTRS_UNSPECIFIED, NULL);
+}
+
 #undef LD_PHYS
 #undef ST_PHYS
 #undef ADDRESS_SPACE_LD
diff --git a/system/memory_ldst.c.inc b/system/memory_ldst.c.inc
index c37a07b4f4a..ab2df6e429b 100644
--- a/system/memory_ldst.c.inc
+++ b/system/memory_ldst.c.inc
@@ -67,27 +67,6 @@ static inline uint32_t glue(address_space_ldl_internal, SUFFIX)(ARG1_DECL,
     return val;
 }
 
-uint32_t glue(address_space_ldl, SUFFIX)(ARG1_DECL,
-    hwaddr addr, MemTxAttrs attrs, MemTxResult *result)
-{
-    return glue(address_space_ldl_internal, SUFFIX)(ARG1, addr, attrs, result,
-                                                    DEVICE_NATIVE_ENDIAN);
-}
-
-uint32_t glue(address_space_ldl_le, SUFFIX)(ARG1_DECL,
-    hwaddr addr, MemTxAttrs attrs, MemTxResult *result)
-{
-    return glue(address_space_ldl_internal, SUFFIX)(ARG1, addr, attrs, result,
-                                                    DEVICE_LITTLE_ENDIAN);
-}
-
-uint32_t glue(address_space_ldl_be, SUFFIX)(ARG1_DECL,
-    hwaddr addr, MemTxAttrs attrs, MemTxResult *result)
-{
-    return glue(address_space_ldl_internal, SUFFIX)(ARG1, addr, attrs, result,
-                                                    DEVICE_BIG_ENDIAN);
-}
-
 /* warning: addr must be aligned */
 static inline uint64_t glue(address_space_ldq_internal, SUFFIX)(ARG1_DECL,
     hwaddr addr, MemTxAttrs attrs, MemTxResult *result,
@@ -284,27 +263,6 @@ static inline void glue(address_space_stl_internal, SUFFIX)(ARG1_DECL,
     RCU_READ_UNLOCK();
 }
 
-void glue(address_space_stl, SUFFIX)(ARG1_DECL,
-    hwaddr addr, uint32_t val, MemTxAttrs attrs, MemTxResult *result)
-{
-    glue(address_space_stl_internal, SUFFIX)(ARG1, addr, val, attrs,
-                                             result, DEVICE_NATIVE_ENDIAN);
-}
-
-void glue(address_space_stl_le, SUFFIX)(ARG1_DECL,
-    hwaddr addr, uint32_t val, MemTxAttrs attrs, MemTxResult *result)
-{
-    glue(address_space_stl_internal, SUFFIX)(ARG1, addr, val, attrs,
-                                             result, DEVICE_LITTLE_ENDIAN);
-}
-
-void glue(address_space_stl_be, SUFFIX)(ARG1_DECL,
-    hwaddr addr, uint32_t val, MemTxAttrs attrs, MemTxResult *result)
-{
-    glue(address_space_stl_internal, SUFFIX)(ARG1, addr, val, attrs,
-                                             result, DEVICE_BIG_ENDIAN);
-}
-
 void glue(address_space_stb, SUFFIX)(ARG1_DECL,
     hwaddr addr, uint8_t val, MemTxAttrs attrs, MemTxResult *result)
 {
diff --git a/system/memory_ldst_endian.c.inc b/system/memory_ldst_endian.c.inc
index e1ae44ca232..5d46524ec4c 100644
--- a/system/memory_ldst_endian.c.inc
+++ b/system/memory_ldst_endian.c.inc
@@ -26,6 +26,13 @@ uint16_t ADDRESS_SPACE_LD(uw)(ARG1_DECL, hwaddr addr,
                                          DEVICE_ENDIANNESS);
 }
 
+uint32_t ADDRESS_SPACE_LD(l)(ARG1_DECL, hwaddr addr,
+                             MemTxAttrs attrs, MemTxResult *result)
+{
+    return ADDRESS_SPACE_LD_INTERNAL(l)(ARG1, addr, attrs, result,
+                                        DEVICE_ENDIANNESS);
+}
+
 void ADDRESS_SPACE_ST(w)(ARG1_DECL, hwaddr addr, uint16_t val,
                          MemTxAttrs attrs, MemTxResult *result)
 {
@@ -33,6 +40,13 @@ void ADDRESS_SPACE_ST(w)(ARG1_DECL, hwaddr addr, uint16_t val,
                                  DEVICE_ENDIANNESS);
 }
 
+void ADDRESS_SPACE_ST(l)(ARG1_DECL, hwaddr addr, uint32_t val,
+                         MemTxAttrs attrs, MemTxResult *result)
+{
+    ADDRESS_SPACE_ST_INTERNAL(l)(ARG1, addr, val, attrs, result,
+                                 DEVICE_ENDIANNESS);
+}
+
 #undef ADDRESS_SPACE_LD
 #undef ADDRESS_SPACE_LD_INTERNAL
 #undef ADDRESS_SPACE_ST
-- 
2.52.0


