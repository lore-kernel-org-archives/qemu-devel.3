Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EACDD26D71
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 16:52:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veFj7-0007AW-Lh; Fri, 09 Jan 2026 11:52:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1veFix-0006vu-Tf
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 11:52:33 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1veFiv-0007VT-VR
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 11:52:31 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4779adb38d3so31523895e9.2
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 08:52:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767977548; x=1768582348; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y4SqeZxl5HqhEizpE5MaSMKz3/wkRaflVH0M8Y28zmg=;
 b=uKqqUjTjcpjPhML/lUAb2oJSKjcpVT5D6+Sae82L4J3AQWdNvs1T13BzBajY2UvItC
 kcPz0Nu9urkgPTuIuICTEumS+RlvNrVpchL1/CYADyWNewKphm+DwIgyI5JvgA0HNmHQ
 Ub3DEkwkT6GSyXgHuYaEYcApPIpPxPcWUguNJaMrVXlzQtfAUN+xqH6Gy9t7jtFU4mLJ
 hA5EnQd+yzxnPJnCueSNN5gGOWj/HzMLw/zngeiOwKjZtNBlNo2iIQioscBU+myyUNw2
 4rpWSxPR1lrN5Xpst+v6G45kFfA4DzR5B2spVAKWnGs2BBWWHpmgzcybNKZbv4r9IPn8
 7QJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767977548; x=1768582348;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=y4SqeZxl5HqhEizpE5MaSMKz3/wkRaflVH0M8Y28zmg=;
 b=KlLVSSn1AxA8+0HZYeVbzO8swIYz9nPo8+dKjEMwSW3XteBfwq77Jd6uqI9mCoR6Q6
 wmKd1b3TZMoGYl9kcHjsluXfCBA51gHwouUs80MnQPsmiU81y/YP2Xqs3wG3PljVftXk
 yDAg+c7gZsL2XhlUSrWtuVyosoLqPJlYtc/0VRITq4KKVHC+70aWv4W4k/9OXKE+aDLS
 4sh3QU6VgcR+m7+rkcHyoKwPX+UITWcWfOvnlP1qgHSBNj5mOlXuXamggEbAM9kc4RDx
 SrioYtL3M6Ed1l1wbhZ9GZGsSUC8xmdNgLjfGjQvB3h89x/2pYM1WzloFgWKmQS9qCTJ
 7Ayg==
X-Gm-Message-State: AOJu0YzB3CVanq+Ey/x7dph11/77dWk2DmvCZAIBkqXF5yO06h232YAr
 0VaAcTEzslbEvGveXkJabJ5hHSZ4upjNhMsNgooS6mcoSWN/XpReTPv8y8YYNMLoN7Vmb143eXe
 ds06ZLpM=
X-Gm-Gg: AY/fxX54J1YzcOCoA0DM/UF5wuEgO/P79274SPh/0YPw0n8afif0A9O4qrZRR9X1mo9
 8RKxHVga5am6OBgJs3Z4ft5E5sHfZur8MDBBhsKc1Wwn6y3pAl8CiW5lutIad2z6m20LgCYlKRe
 7XVQA1zEBKDXrsNc1EZXfKjzUNSPRdQhlyYxo/GYnAzf9y4/VnnaUHO/u4aPPJWxVZ93ifg1CBB
 cCNvO5qmMaCSjLGT/Vht2AuoGG6qDuQ6mkjDNRP71HNZ9s7tQ+bHtNe4iqVNNuvSTWQ69eu5QkM
 dFjM+pF+8kv5+WnsB1K9UTLpYNCnzacx57OWMkH6LxbWvp51YkuMsaIGIiyK2IEH/CPkPTG4EUk
 PyGoArgMIk9d+nOhC+9HQw5tJBkiWv5txPBCtiNewvOV91/5+qweEj+q3Bkk5QK9ll9MMxGAE6w
 TqWkzU7MjPM1UDebo6YNxXrRCZb2xhxeg+6OQ40ToUracw9E2ZmjVkOERjuRNB
X-Google-Smtp-Source: AGHT+IHIlRVLMKFrRR3rQWuv7g5WDYLiKkuKYDcmCYuce50xfn2cnHgfH6nQGC76EX+toxyMyRMfKA==
X-Received: by 2002:a5d:5c8a:0:b0:431:7a0:dbc2 with SMTP id
 ffacd0b85a97d-432c379dc0dmr12901166f8f.31.1767977548040; 
 Fri, 09 Jan 2026 08:52:28 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd0dacdcsm23311646f8f.1.2026.01.09.08.52.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 09 Jan 2026 08:52:27 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Anton Johansson <anjo@rev.ng>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v5 13/22] system/memory: Directly call
 address_space_ldst[M]_internal() helper
Date: Fri,  9 Jan 2026 17:50:49 +0100
Message-ID: <20260109165058.59144-14-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260109165058.59144-1-philmd@linaro.org>
References: <20260109165058.59144-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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


