Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6256CD625F9
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 08:55:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viqRu-0005Dx-1d; Thu, 22 Jan 2026 03:53:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viqRn-000505-O2
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 03:53:48 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viqRl-0005t8-BM
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 03:53:47 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-47d6a1f08bbso3243585e9.2
 for <qemu-devel@nongnu.org>; Thu, 22 Jan 2026 00:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769072023; x=1769676823; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=YtOaswLEL0WXQId/j0ZBvBoij1FGZJJvzTwVz8GCPyg=;
 b=tdKRQDWGIrAjPdU6UyGPIR8uAWgTYC4sNFdBKyHOP7DUW+v7c+who9iBJLUQyO9IXr
 rOAPSd6vU18RFySqajeZ1/9TwTJjjdzxHgBEpfRyV6um9BWdITZjw4S+43oCQ2CziBQX
 dOOgCij9VKRgY8peHHuzLXrDkjbVtBzs+DFA6ZGMd2mGojJ7EBJ54r26OOHDR6LlbqOd
 PJmiqDHburLnLNLFiPJC7J2e/5MF0e26WTr9NM1oX9ZOINKsJ6GK9tBxEvC3dYWqCZVk
 NYahAW2WT3+2Sx+sKSln1F6CIQAx3UQDiBfz8u/lhjsjCPCcRU7HoPVIthoHi6mvJ2Qi
 dxBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769072023; x=1769676823;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=YtOaswLEL0WXQId/j0ZBvBoij1FGZJJvzTwVz8GCPyg=;
 b=v+Pt2PYcQ0V83RRzqhbK92kG9zMWgjRNy/Mfs+7M6Sx4Pu+pbO9ZO59ppkcKySx1Ep
 6+IC4P5ASMGr3S+JntC4BwkbMX3jxSGQYhdFV/yEOb9qqa7e82TpvnD87Peg4/21brxO
 TpBec411bnZx95q/V9xkAFAHpmDrHmJ7Las6voAkpuxqCc376C7AS6+oKDo5p9FrmHuY
 6wu+ZvB8h2mdyhff5Ke4lIvRL356XZrlavC7TQLbaMNEBqQoVfqs/o299FnTrTZxAMaA
 eZrgdNo3d3JfioCypAYPA1f7ssrvEfbmmzYkoDdaoDLukPzyD8bOo7CiE/AsPcI+71j4
 UH4g==
X-Gm-Message-State: AOJu0YwfaTHDeeQRmob9H6EU4nwkFmubA0ZymVDPm2S7kiYp68zSSH+0
 5VuzGZPOFebZ+3Blz6uFqGOdlZKKE2z7a6ajilHMFCjBXn5JmfV/ai4yBJvMdV3CdFt+vAL7mXA
 puPKqufs=
X-Gm-Gg: AZuq6aK3JMtxSwyFX+HBrXZVbWsqtahgp84xiVGXq9Bs5949m0+1zuqarMJpJ/5tGem
 sTniaMUPnX10OEYX19oAmAEEXgs3pyp9XhVpNAQ9cR2Q+uLOnvZTvlToDvwuHSKacwhuU7DIgIe
 XYYosBTEGbSDvFskKRDo/xSR3lFqqlywQ8PXIi7gB1UoJUfDfBTWr03UTQUCfSaWGlEYus7/O50
 4Wt9oKriJde73TREKe6tjmcSF2QMNumH2j8jdnuWaeiPZRtdOQpottxn6QgpnuuNuAr6a/Du3mr
 kL8eHERxDaxVMBQjnO0TKWmVn2H1o7JA3pXiPX8SzyekrPoEAaOhDnaM8d3jLjg4L6pnnKCciE3
 NH/3L1e/aKwe8C8nN7poxakI8fuqyzvnmJgdPlBw3HB/Y9Dk0cKI1y4r3QfNdMbO00eshH0O4ww
 OQjQbsc99cpshlOb9FQdteEa1tgEltaj/SYMmXH3T9+u+IV9MCg3noN+ESXHZT
X-Received: by 2002:a05:600d:644e:10b0:47f:1a8d:4f30 with SMTP id
 5b1f17b1804b1-4801eb0efbdmr240078505e9.26.1769072023258; 
 Thu, 22 Jan 2026 00:53:43 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4804704b712sm50707635e9.8.2026.01.22.00.53.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 22 Jan 2026 00:53:42 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/31] system/memory: Define address_space_ldst[Q] endian
 variants via template
Date: Thu, 22 Jan 2026 09:52:30 +0100
Message-ID: <20260122085255.95035-8-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260122085255.95035-1-philmd@linaro.org>
References: <20260122085255.95035-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

Define address_space_ldst[Q] endian variants via template.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260109165058.59144-10-philmd@linaro.org>
---
 include/system/memory_ldst.h.inc             | 17 ++------
 include/system/memory_ldst_endian.h.inc      |  4 ++
 include/system/memory_ldst_phys.h.inc        | 36 -----------------
 include/system/memory_ldst_phys_endian.h.inc | 10 +++++
 system/memory_ldst.c.inc                     | 42 --------------------
 system/memory_ldst_endian.c.inc              | 14 +++++++
 6 files changed, 31 insertions(+), 92 deletions(-)

diff --git a/include/system/memory_ldst.h.inc b/include/system/memory_ldst.h.inc
index 7ccca46f2a9..dd1fb482eac 100644
--- a/include/system/memory_ldst.h.inc
+++ b/include/system/memory_ldst.h.inc
@@ -19,22 +19,11 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
-uint64_t glue(address_space_ldq, SUFFIX)(ARG1_DECL,
-    hwaddr addr, MemTxAttrs attrs, MemTxResult *result);
-void glue(address_space_stq, SUFFIX)(ARG1_DECL,
-    hwaddr addr, uint64_t val, MemTxAttrs attrs, MemTxResult *result);
 uint8_t glue(address_space_ldub, SUFFIX)(ARG1_DECL,
-    hwaddr addr, MemTxAttrs attrs, MemTxResult *result);
-uint64_t glue(address_space_ldq_le, SUFFIX)(ARG1_DECL,
-    hwaddr addr, MemTxAttrs attrs, MemTxResult *result);
-uint64_t glue(address_space_ldq_be, SUFFIX)(ARG1_DECL,
-    hwaddr addr, MemTxAttrs attrs, MemTxResult *result);
+             hwaddr addr, MemTxAttrs attrs, MemTxResult *result);
+
 void glue(address_space_stb, SUFFIX)(ARG1_DECL,
-    hwaddr addr, uint8_t val, MemTxAttrs attrs, MemTxResult *result);
-void glue(address_space_stq_le, SUFFIX)(ARG1_DECL,
-    hwaddr addr, uint64_t val, MemTxAttrs attrs, MemTxResult *result);
-void glue(address_space_stq_be, SUFFIX)(ARG1_DECL,
-    hwaddr addr, uint64_t val, MemTxAttrs attrs, MemTxResult *result);
+          hwaddr addr, uint8_t val, MemTxAttrs attrs, MemTxResult *result);
 
 #define ENDIANNESS
 #include "system/memory_ldst_endian.h.inc"
diff --git a/include/system/memory_ldst_endian.h.inc b/include/system/memory_ldst_endian.h.inc
index 845ec3b4ad1..f5b6b496be5 100644
--- a/include/system/memory_ldst_endian.h.inc
+++ b/include/system/memory_ldst_endian.h.inc
@@ -18,10 +18,14 @@ uint16_t ADDRESS_SPACE_LD(uw)(ARG1_DECL, hwaddr addr,
                               MemTxAttrs attrs, MemTxResult *result);
 uint32_t ADDRESS_SPACE_LD(l)(ARG1_DECL, hwaddr addr,
                              MemTxAttrs attrs, MemTxResult *result);
+uint64_t ADDRESS_SPACE_LD(q)(ARG1_DECL, hwaddr addr,
+                             MemTxAttrs attrs, MemTxResult *result);
 void ADDRESS_SPACE_ST(w)(ARG1_DECL, hwaddr addr, uint16_t val,
                          MemTxAttrs attrs, MemTxResult *result);
 void ADDRESS_SPACE_ST(l)(ARG1_DECL, hwaddr addr, uint32_t val,
                          MemTxAttrs attrs, MemTxResult *result);
+void ADDRESS_SPACE_ST(q)(ARG1_DECL, hwaddr addr, uint64_t val,
+                         MemTxAttrs attrs, MemTxResult *result);
 
 #undef ADDRESS_SPACE_LD
 #undef ADDRESS_SPACE_ST
diff --git a/include/system/memory_ldst_phys.h.inc b/include/system/memory_ldst_phys.h.inc
index c3c73419e61..f4c91dc7a91 100644
--- a/include/system/memory_ldst_phys.h.inc
+++ b/include/system/memory_ldst_phys.h.inc
@@ -19,54 +19,18 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
-static inline uint64_t glue(ldq_phys, SUFFIX)(ARG1_DECL, hwaddr addr)
-{
-    return glue(address_space_ldq, SUFFIX)(ARG1, addr,
-                                           MEMTXATTRS_UNSPECIFIED, NULL);
-}
-
-static inline void glue(stq_phys, SUFFIX)(ARG1_DECL, hwaddr addr, uint64_t val)
-{
-    glue(address_space_stq, SUFFIX)(ARG1, addr, val,
-                                    MEMTXATTRS_UNSPECIFIED, NULL);
-}
-
 static inline uint8_t glue(ldub_phys, SUFFIX)(ARG1_DECL, hwaddr addr)
 {
     return glue(address_space_ldub, SUFFIX)(ARG1, addr,
                                             MEMTXATTRS_UNSPECIFIED, NULL);
 }
 
-static inline uint64_t glue(ldq_le_phys, SUFFIX)(ARG1_DECL, hwaddr addr)
-{
-    return glue(address_space_ldq_le, SUFFIX)(ARG1, addr,
-                                              MEMTXATTRS_UNSPECIFIED, NULL);
-}
-
-static inline uint64_t glue(ldq_be_phys, SUFFIX)(ARG1_DECL, hwaddr addr)
-{
-    return glue(address_space_ldq_be, SUFFIX)(ARG1, addr,
-                                              MEMTXATTRS_UNSPECIFIED, NULL);
-}
-
 static inline void glue(stb_phys, SUFFIX)(ARG1_DECL, hwaddr addr, uint8_t val)
 {
     glue(address_space_stb, SUFFIX)(ARG1, addr, val,
                                     MEMTXATTRS_UNSPECIFIED, NULL);
 }
 
-static inline void glue(stq_le_phys, SUFFIX)(ARG1_DECL, hwaddr addr, uint64_t val)
-{
-    glue(address_space_stq_le, SUFFIX)(ARG1, addr, val,
-                                       MEMTXATTRS_UNSPECIFIED, NULL);
-}
-
-static inline void glue(stq_be_phys, SUFFIX)(ARG1_DECL, hwaddr addr, uint64_t val)
-{
-    glue(address_space_stq_be, SUFFIX)(ARG1, addr, val,
-                                       MEMTXATTRS_UNSPECIFIED, NULL);
-}
-
 #define ENDIANNESS
 #include "system/memory_ldst_phys_endian.h.inc"
 
diff --git a/include/system/memory_ldst_phys_endian.h.inc b/include/system/memory_ldst_phys_endian.h.inc
index 1589f34e8e4..820e9dd1f13 100644
--- a/include/system/memory_ldst_phys_endian.h.inc
+++ b/include/system/memory_ldst_phys_endian.h.inc
@@ -29,6 +29,11 @@ static inline uint32_t LD_PHYS(l)(ARG1_DECL, hwaddr addr)
     return ADDRESS_SPACE_LD(l)(ARG1, addr, MEMTXATTRS_UNSPECIFIED, NULL);
 }
 
+static inline uint64_t LD_PHYS(q)(ARG1_DECL, hwaddr addr)
+{
+    return ADDRESS_SPACE_LD(q)(ARG1, addr, MEMTXATTRS_UNSPECIFIED, NULL);
+}
+
 static inline void ST_PHYS(w)(ARG1_DECL, hwaddr addr, uint16_t val)
 {
     ADDRESS_SPACE_ST(w)(ARG1, addr, val, MEMTXATTRS_UNSPECIFIED, NULL);
@@ -39,6 +44,11 @@ static inline void ST_PHYS(l)(ARG1_DECL, hwaddr addr, uint32_t val)
     ADDRESS_SPACE_ST(l)(ARG1, addr, val, MEMTXATTRS_UNSPECIFIED, NULL);
 }
 
+static inline void ST_PHYS(q)(ARG1_DECL, hwaddr addr, uint64_t val)
+{
+    ADDRESS_SPACE_ST(q)(ARG1, addr, val, MEMTXATTRS_UNSPECIFIED, NULL);
+}
+
 #undef LD_PHYS
 #undef ST_PHYS
 #undef ADDRESS_SPACE_LD
diff --git a/system/memory_ldst.c.inc b/system/memory_ldst.c.inc
index ab2df6e429b..823fc3a7561 100644
--- a/system/memory_ldst.c.inc
+++ b/system/memory_ldst.c.inc
@@ -115,27 +115,6 @@ static inline uint64_t glue(address_space_ldq_internal, SUFFIX)(ARG1_DECL,
     return val;
 }
 
-uint64_t glue(address_space_ldq, SUFFIX)(ARG1_DECL,
-    hwaddr addr, MemTxAttrs attrs, MemTxResult *result)
-{
-    return glue(address_space_ldq_internal, SUFFIX)(ARG1, addr, attrs, result,
-                                                    DEVICE_NATIVE_ENDIAN);
-}
-
-uint64_t glue(address_space_ldq_le, SUFFIX)(ARG1_DECL,
-    hwaddr addr, MemTxAttrs attrs, MemTxResult *result)
-{
-    return glue(address_space_ldq_internal, SUFFIX)(ARG1, addr, attrs, result,
-                                                    DEVICE_LITTLE_ENDIAN);
-}
-
-uint64_t glue(address_space_ldq_be, SUFFIX)(ARG1_DECL,
-    hwaddr addr, MemTxAttrs attrs, MemTxResult *result)
-{
-    return glue(address_space_ldq_internal, SUFFIX)(ARG1, addr, attrs, result,
-                                                    DEVICE_BIG_ENDIAN);
-}
-
 uint8_t glue(address_space_ldub, SUFFIX)(ARG1_DECL,
     hwaddr addr, MemTxAttrs attrs, MemTxResult *result)
 {
@@ -381,27 +360,6 @@ static inline void glue(address_space_stq_internal, SUFFIX)(ARG1_DECL,
     RCU_READ_UNLOCK();
 }
 
-void glue(address_space_stq, SUFFIX)(ARG1_DECL,
-    hwaddr addr, uint64_t val, MemTxAttrs attrs, MemTxResult *result)
-{
-    glue(address_space_stq_internal, SUFFIX)(ARG1, addr, val, attrs, result,
-                                             DEVICE_NATIVE_ENDIAN);
-}
-
-void glue(address_space_stq_le, SUFFIX)(ARG1_DECL,
-    hwaddr addr, uint64_t val, MemTxAttrs attrs, MemTxResult *result)
-{
-    glue(address_space_stq_internal, SUFFIX)(ARG1, addr, val, attrs, result,
-                                             DEVICE_LITTLE_ENDIAN);
-}
-
-void glue(address_space_stq_be, SUFFIX)(ARG1_DECL,
-    hwaddr addr, uint64_t val, MemTxAttrs attrs, MemTxResult *result)
-{
-    glue(address_space_stq_internal, SUFFIX)(ARG1, addr, val, attrs, result,
-                                             DEVICE_BIG_ENDIAN);
-}
-
 #define ENDIANNESS
 #define DEVICE_ENDIANNESS       DEVICE_NATIVE_ENDIAN
 #include "memory_ldst_endian.c.inc"
diff --git a/system/memory_ldst_endian.c.inc b/system/memory_ldst_endian.c.inc
index 5d46524ec4c..791d041b15d 100644
--- a/system/memory_ldst_endian.c.inc
+++ b/system/memory_ldst_endian.c.inc
@@ -33,6 +33,13 @@ uint32_t ADDRESS_SPACE_LD(l)(ARG1_DECL, hwaddr addr,
                                         DEVICE_ENDIANNESS);
 }
 
+uint64_t ADDRESS_SPACE_LD(q)(ARG1_DECL, hwaddr addr,
+                             MemTxAttrs attrs, MemTxResult *result)
+{
+    return ADDRESS_SPACE_LD_INTERNAL(q)(ARG1, addr, attrs, result,
+                                        DEVICE_ENDIANNESS);
+}
+
 void ADDRESS_SPACE_ST(w)(ARG1_DECL, hwaddr addr, uint16_t val,
                          MemTxAttrs attrs, MemTxResult *result)
 {
@@ -47,6 +54,13 @@ void ADDRESS_SPACE_ST(l)(ARG1_DECL, hwaddr addr, uint32_t val,
                                  DEVICE_ENDIANNESS);
 }
 
+void ADDRESS_SPACE_ST(q)(ARG1_DECL, hwaddr addr, uint64_t val,
+                         MemTxAttrs attrs, MemTxResult *result)
+{
+    ADDRESS_SPACE_ST_INTERNAL(q)(ARG1, addr, val, attrs, result,
+                                 DEVICE_ENDIANNESS);
+}
+
 #undef ADDRESS_SPACE_LD
 #undef ADDRESS_SPACE_LD_INTERNAL
 #undef ADDRESS_SPACE_ST
-- 
2.52.0


