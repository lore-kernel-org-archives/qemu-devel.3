Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 392F7E77361
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 15:24:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYQil-0004Cw-Kp; Wed, 24 Dec 2025 10:24:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYQij-0003zE-5X
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 10:24:14 -0500
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYQih-0004lq-9v
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 10:24:12 -0500
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-b8018eba13cso843471166b.1
 for <qemu-devel@nongnu.org>; Wed, 24 Dec 2025 07:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766589849; x=1767194649; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8BdvIOpQD4GCG++XbetfLEXnxOBIlrzQoJl+2ljxiQk=;
 b=q9IXd44R65sdLIoofQIBPDx8xfMuxxBNaBEUZs5VQcvIXIKkL9p0h158sajlnnDC28
 UWIDnysh245FszoYYDaBWFk0vSIp9qnTl62rkxEDJB1kxsGswoy24iXzidGA5qJ+LWcy
 gUl9cOmuUrLhY8ZsdXYaJCF8IvBCj2OGzvw7oDzztWODHwhQQhXbOfDYX4sNg/aOBMol
 C3aul0fI09XWRq+SpvVIPSq8awyYVYOrQNMUj9j2TLdiWmErUhAbkU4LiolZtOrDefdP
 kvizbV8JdDgmPwrnQIF80eg3E4jTMcoW5rn56YAgALctzlEt3pWXrz9/X9tUVJiRJ1B6
 zWkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766589849; x=1767194649;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8BdvIOpQD4GCG++XbetfLEXnxOBIlrzQoJl+2ljxiQk=;
 b=M4w57uf2DkooEACkK8C1OLjNw6XisfIc8V/f9c6tlem/+6HxGZnqxz5Tx6SDezdd7o
 TiJnA4LdM+c9WyZ7Xny6Ci1HDcg0BY9oAYZ+uCCS57I5LgiY3mHMZqPGOEUpp7x2uzET
 0RclrbwGlZ7Dimbm5/t3Aqg7PcZNl4cGee3wVH4qPMb+M8fuK+hdLUg78MlTn9gKiyzi
 FAEhBpuBmPOkeaHTgbrAX7P742AAhAf277TYK0SvGWZutJy3UdSOQBEOHzeya3lvPtjp
 uPt6V0pkTNStyIV6nHD0THc0lwFtVCDrthP1ugE6iSvE8IoIY07wplAbLGN6/XsHgg/b
 qVcA==
X-Gm-Message-State: AOJu0YxjobrZr/XlazG/HaAsyvPWsUVh945yRWxCoLtTujs0eyU+hOer
 3z7bo7MKlLat+eeL3ACAn3194JmGlq1qimZBZVii3thcqYpOn69OW8U7eH3JeO847xYXv7c5vlA
 r5qi4vBU=
X-Gm-Gg: AY/fxX4RJ5fcd2twsIGyd5RD2uhdmFZuz/KSd4cFTy93Ca61DQ4FtsOVsCw6cnh98Dq
 SJ5zVQdxd4fHPYm3zPIal5d4Bq87uGeHjonjlpfx6odZV2vSGZHWuFOZmp7VO+topwTeww8olpQ
 LK966mgZlD1zNFfYNuXISAm1yBLewp2SgCBKGyazH7GJElGz53OSHeHhSR9F1lrMCoB2w9xSRIa
 F2IO2tsqbSEq5vy5uXW4w6ycn8yhWXViAdCLlA1TSljNquooviL7pViU8OpDQqhygbMxRKe4Rzd
 anoc67sZY2H9oj502J/3YCSlFD3ky3ZqfcWcljUr078Yebrtf5cfBe8Zy/IKANMhT17ACTknHSK
 C49W1XWKNaRLc4yMqdvVeuBBv/7MnviMdFaIXzzL+gQkI1SDtkyWujqQjvxg8TJnsX4Mzcjw8qs
 7qxpMl8lUV0KQrMDFyOCZhyUY+H/uCg484Sjib2MpX09DZRnFhWhJOCJQfMfchy4AIBw==
X-Google-Smtp-Source: AGHT+IGuID2xabHGmTUgpxEEyCT3Ai6chDX0O8bHnFhWcnq6EeJgacZ9W1MI1OSwoW44BY1B5UDvUQ==
X-Received: by 2002:a17:907:1c27:b0:b75:7b39:847a with SMTP id
 a640c23a62f3a-b80372228e5mr1993195966b.60.1766589849358; 
 Wed, 24 Dec 2025 07:24:09 -0800 (PST)
Received: from localhost.localdomain (188.171.88.92.rev.sfr.net.
 [92.88.171.188]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8037a5bdfesm1786300366b.10.2025.12.24.07.24.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Dec 2025 07:24:08 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@kernel.org>
Subject: [PATCH v3 12/25] system/memory: Directly call
 address_space_ldst[M]_internal() helper
Date: Wed, 24 Dec 2025 16:21:55 +0100
Message-ID: <20251224152210.87880-13-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251224152210.87880-1-philmd@linaro.org>
References: <20251224152210.87880-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x630.google.com
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

Inline internal address_space_ld/st[L,D,Q] helpers,
directly calling address_space_ldst[M]_internal().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 system/memory_ldst.c.inc        | 47 ---------------------------------
 system/memory_ldst_endian.c.inc | 12 ++++-----
 2 files changed, 6 insertions(+), 53 deletions(-)

diff --git a/system/memory_ldst.c.inc b/system/memory_ldst.c.inc
index 5c8299e0cdc..20a2784e234 100644
--- a/system/memory_ldst.c.inc
+++ b/system/memory_ldst.c.inc
@@ -63,22 +63,6 @@ uint64_t glue(address_space_ldm_internal, SUFFIX)(ARG1_DECL, MemOp mop,
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
@@ -86,14 +70,6 @@ uint8_t glue(address_space_ldub, SUFFIX)(ARG1_DECL, hwaddr addr,
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
@@ -134,14 +110,6 @@ void glue(address_space_stm_internal, SUFFIX)(ARG1_DECL, MemOp mop,
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
@@ -149,21 +117,6 @@ void glue(address_space_stb, SUFFIX)(ARG1_DECL, hwaddr addr, uint8_t val,
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


