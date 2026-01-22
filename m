Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13498C44500
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 08:56:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viqT0-0006WU-7S; Thu, 22 Jan 2026 03:55:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viqSE-0005RA-WE
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 03:54:24 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viqSB-0005v6-LI
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 03:54:13 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-42fbc305914so596637f8f.0
 for <qemu-devel@nongnu.org>; Thu, 22 Jan 2026 00:54:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769072050; x=1769676850; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=J3ImZqKAxXQfXZh2R+QhWoGeV+YfwlonfOq/Eg7p398=;
 b=kjrSFQd+8YCrxUNoSAaY9WekI4ZEpCQJzFS+ZONpwAEUw5SLoHpGsW4NzYz1pc/abZ
 IZy59P/+0XT3+cS5CkbahS7IlDR4Pkl2CrTf77DlG5nRtnYyHmz/iNtEGnU5kQYzAcFF
 808DL05v1Zyh+kPuTUqctmb+PFUvbLpLaeF185T44RitMiNvw/Da11yuigBvhWzXN5eL
 MZMKxy3h4YkjbI9irwJMxVhj3LU8kQ098E/3V7TU28lGRJ8vnOTKXvU+k1BKmvvKKKVB
 5TkTFhaNU7Hw4jsopLITGa1H1kN+mIVS8pOHL5PEAZebb6MPDEKoebnqJ0xhpAtN5VaM
 W6Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769072050; x=1769676850;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=J3ImZqKAxXQfXZh2R+QhWoGeV+YfwlonfOq/Eg7p398=;
 b=dYsSSwRQhsnhA9oEVx9VDpYHLUcVtzjWUMR0h+i5sASCTqn+Jfz7++0xM5yEDLYxih
 8HsTpHnPy3Zmr/PRyr+9OFQbXEKLUiadoIciMRj7YEYJrtaxXf7K+t3Bc4JRbC/RVbkP
 laYQzwieq8coNQ6+3yjNObQzHEpc1cmFOaO9hHR+vMU8yyfQIGJsO9nkEDf4WwKyydPf
 Y7r5nrQWy9Tr+gjNZQnmxU8EunfLzhZkEkQbKju5M+Bs1acZaZW6c5EtevcWM/PS8Set
 6wJRzKbD3btr01YfdO1nIGcWBGn+YHQkPYOhZwO3vIXEKs30N8m9F8v6ize9rPLYo4Az
 E13Q==
X-Gm-Message-State: AOJu0YwC3oljnV6k5BY2n7GFyYBxJnfXLZUBcGWDw3QMCpC8asSwAw5f
 uF0fwk0+pCeZiYTo51u53qyVhTNorRYolw5Vb/A4sgMyxrR6DViuIfNjRs/P0iKhiC5mf8cw2NH
 zhW6RrB4=
X-Gm-Gg: AZuq6aKf0spRpGQq6bOC906ABuYPMWw7cJGRCrat1INTlzeDZZRWVfCOuOtFzqzuSo1
 4w/k7IClv4n8fdoKL84NN4tSmEYFrzo3KXkg5NXTlAGatbY1GD7Tda75Oq7CzQZkS19Mb6V7qbf
 AocrHI8Z0wdDVB27AAif4rwdk1FPXTdYp8sGJSfvuKlEURz6mGzMuW/q0Nx3N7Xqv2Z74pd1zIj
 aQGObZuREuT8b3suqTsktzJ188Z6osV+LX/a7szklQvOU2O+NUdr9E2iZKnUslJV+C6Kj4252I5
 EQ7t+o9tx4yOjmlwnV9mLy3466mHBIdrug71frMiVp+PPlWcPHlPU2a+aZvCGSYZxTp2PpSp7Hl
 QHlzeN+iPF6nT4SzLOiNsEpuWDZXu02I3vkKw8JhDtkvON4Jn0D1OZx0DxKpQlnt9775H+BUhfg
 pjU49S9hUiNmKQdME/KrQQ5HoQBjRt6/Snu5oiJMzdtmHUdaNpzpFfuiq/iI92
X-Received: by 2002:a05:6000:4383:b0:433:24c7:880e with SMTP id
 ffacd0b85a97d-4358ff26a86mr14159359f8f.33.1769072049572; 
 Thu, 22 Jan 2026 00:54:09 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356997ed8bsm44071485f8f.36.2026.01.22.00.54.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 22 Jan 2026 00:54:09 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/31] system/memory: Directly call
 address_space_ldst[M]_internal() helper
Date: Thu, 22 Jan 2026 09:52:34 +0100
Message-ID: <20260122085255.95035-12-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260122085255.95035-1-philmd@linaro.org>
References: <20260122085255.95035-1-philmd@linaro.org>
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

Inline internal address_space_ld/st[L,D,Q] helpers,
directly calling address_space_ldst[M]_internal().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260109165058.59144-14-philmd@linaro.org>
---
 system/memory_ldst.c.inc        | 47 ---------------------------------
 system/memory_ldst_endian.c.inc | 12 ++++-----
 2 files changed, 6 insertions(+), 53 deletions(-)

diff --git a/system/memory_ldst.c.inc b/system/memory_ldst.c.inc
index d51c5feddf7..ebb441f1a66 100644
--- a/system/memory_ldst.c.inc
+++ b/system/memory_ldst.c.inc
@@ -57,22 +57,6 @@ uint64_t glue(address_space_ldm_internal, SUFFIX)(ARG1_DECL, MemOp mop,
     return val;
 }
 
-/* warning: addr must be aligned */
-static inline uint32_t glue(address_space_ldl_internal, SUFFIX)(ARG1_DECL,
-    MemOp mop, hwaddr addr, MemTxAttrs attrs, MemTxResult *result)
-{
-    return glue(address_space_ldm_internal, SUFFIX)(ARG1, mop | MO_32, addr,
-                                                    attrs, result);
-}
-
-/* warning: addr must be aligned */
-static inline uint64_t glue(address_space_ldq_internal, SUFFIX)(ARG1_DECL,
-    MemOp mop, hwaddr addr, MemTxAttrs attrs, MemTxResult *result)
-{
-    return glue(address_space_ldm_internal, SUFFIX)(ARG1, mop | MO_64, addr,
-                                                    attrs, result);
-}
-
 uint8_t glue(address_space_ldub, SUFFIX)(ARG1_DECL, hwaddr addr,
                                          MemTxAttrs attrs, MemTxResult *result)
 {
@@ -80,14 +64,6 @@ uint8_t glue(address_space_ldub, SUFFIX)(ARG1_DECL, hwaddr addr,
                                                     attrs, result);
 }
 
-/* warning: addr must be aligned */
-static inline uint16_t glue(address_space_lduw_internal, SUFFIX)(ARG1_DECL,
-    MemOp mop, hwaddr addr, MemTxAttrs attrs, MemTxResult *result)
-{
-    return glue(address_space_ldm_internal, SUFFIX)(ARG1, mop | MO_16, addr,
-                                                    attrs, result);
-}
-
 /* warning: addr must be aligned */
 static inline
 void glue(address_space_stm_internal, SUFFIX)(ARG1_DECL, MemOp mop,
@@ -122,14 +98,6 @@ void glue(address_space_stm_internal, SUFFIX)(ARG1_DECL, MemOp mop,
     RCU_READ_UNLOCK();
 }
 
-/* warning: addr must be aligned */
-static inline void glue(address_space_stl_internal, SUFFIX)(ARG1_DECL,
-    MemOp mop, hwaddr addr, uint32_t val, MemTxAttrs attrs, MemTxResult *result)
-{
-    glue(address_space_stm_internal, SUFFIX)(ARG1, mop | MO_32, addr, val,
-                                             attrs, result);
-}
-
 void glue(address_space_stb, SUFFIX)(ARG1_DECL, hwaddr addr, uint8_t val,
                                      MemTxAttrs attrs, MemTxResult *result)
 {
@@ -137,21 +105,6 @@ void glue(address_space_stb, SUFFIX)(ARG1_DECL, hwaddr addr, uint8_t val,
                                              attrs, result);
 }
 
-/* warning: addr must be aligned */
-static inline void glue(address_space_stw_internal, SUFFIX)(ARG1_DECL,
-    MemOp mop, hwaddr addr, uint16_t val, MemTxAttrs attrs, MemTxResult *result)
-{
-    glue(address_space_stm_internal, SUFFIX)(ARG1, mop | MO_16, addr, val,
-                                             attrs, result);
-}
-
-static inline void glue(address_space_stq_internal, SUFFIX)(ARG1_DECL,
-    MemOp mop, hwaddr addr, uint64_t val, MemTxAttrs attrs, MemTxResult *result)
-{
-    glue(address_space_stm_internal, SUFFIX)(ARG1, mop | MO_64, addr, val,
-                                             attrs, result);
-}
-
 #define ENDIANNESS
 #define MO_ENDIAN               (target_big_endian() ? MO_BE : MO_LE)
 #include "memory_ldst_endian.c.inc"
diff --git a/system/memory_ldst_endian.c.inc b/system/memory_ldst_endian.c.inc
index 9cf36017135..fb933de11f8 100644
--- a/system/memory_ldst_endian.c.inc
+++ b/system/memory_ldst_endian.c.inc
@@ -22,42 +22,42 @@
 uint16_t ADDRESS_SPACE_LD(uw)(ARG1_DECL, hwaddr addr,
                               MemTxAttrs attrs, MemTxResult *result)
 {
-    return ADDRESS_SPACE_LD_INTERNAL(uw)(ARG1, MO_ENDIAN,
+    return ADDRESS_SPACE_LD_INTERNAL(m)(ARG1, MO_ENDIAN | MO_16,
                                         addr, attrs, result);
 }
 
 uint32_t ADDRESS_SPACE_LD(l)(ARG1_DECL, hwaddr addr,
                              MemTxAttrs attrs, MemTxResult *result)
 {
-    return ADDRESS_SPACE_LD_INTERNAL(l)(ARG1, MO_ENDIAN,
+    return ADDRESS_SPACE_LD_INTERNAL(m)(ARG1, MO_ENDIAN | MO_32,
                                         addr, attrs, result);
 }
 
 uint64_t ADDRESS_SPACE_LD(q)(ARG1_DECL, hwaddr addr,
                              MemTxAttrs attrs, MemTxResult *result)
 {
-    return ADDRESS_SPACE_LD_INTERNAL(q)(ARG1, MO_ENDIAN,
+    return ADDRESS_SPACE_LD_INTERNAL(m)(ARG1, MO_ENDIAN | MO_64,
                                         addr, attrs, result);
 }
 
 void ADDRESS_SPACE_ST(w)(ARG1_DECL, hwaddr addr, uint16_t val,
                          MemTxAttrs attrs, MemTxResult *result)
 {
-    ADDRESS_SPACE_ST_INTERNAL(w)(ARG1, MO_ENDIAN,
+    ADDRESS_SPACE_ST_INTERNAL(m)(ARG1, MO_ENDIAN | MO_16,
                                  addr, val, attrs, result);
 }
 
 void ADDRESS_SPACE_ST(l)(ARG1_DECL, hwaddr addr, uint32_t val,
                          MemTxAttrs attrs, MemTxResult *result)
 {
-    ADDRESS_SPACE_ST_INTERNAL(l)(ARG1, MO_ENDIAN,
+    ADDRESS_SPACE_ST_INTERNAL(m)(ARG1, MO_ENDIAN | MO_32,
                                  addr, val, attrs, result);
 }
 
 void ADDRESS_SPACE_ST(q)(ARG1_DECL, hwaddr addr, uint64_t val,
                          MemTxAttrs attrs, MemTxResult *result)
 {
-    ADDRESS_SPACE_ST_INTERNAL(q)(ARG1, MO_ENDIAN,
+    ADDRESS_SPACE_ST_INTERNAL(m)(ARG1, MO_ENDIAN | MO_64,
                                  addr, val, attrs, result);
 }
 
-- 
2.52.0


