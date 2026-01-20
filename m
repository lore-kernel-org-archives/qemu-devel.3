Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7437D26289
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 18:40:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viGdg-0008AZ-VP; Tue, 20 Jan 2026 13:39:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viGdR-0007md-5N
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 13:39:26 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viGdP-0005w4-2J
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 13:39:24 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-47edd9024b1so37173965e9.3
 for <qemu-devel@nongnu.org>; Tue, 20 Jan 2026 10:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768934360; x=1769539160; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lqWKXNkS+lhK9R8ZxTdq4h0qwdmbqs5rj8DgsXUvGtM=;
 b=gjmSbzg8a5NYPL+iP2dy1GtSbKjmDqu0gzr4KydXvQYYBG/XF68NJZAh36s/XEQXMK
 /fZUDRKLzGEAQ5x9+taJnilmYNTsaxueWR55FwTtV53o+lk9EG7zEt5nQPs/cNyEPwiD
 9US5aZ02sRDb6uZSKGVwJCD0pYso/HlZ0QJUdEfpeFoEAjGs+8+eWCG+erCTiwId8liw
 UP3kkUneL720DgfY8oG+YtJOnrPblULT1eguzXf2k8rTnf/UKIaZjMXA5YywJpv5xk16
 r7ieeUxmhrvoR4bYK8eqpImHR590agdM6r4ivo1QvRbhbgWg6V8+g6iktPKzuHGGNbT8
 CExQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768934360; x=1769539160;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=lqWKXNkS+lhK9R8ZxTdq4h0qwdmbqs5rj8DgsXUvGtM=;
 b=vbvR/cTDT902uhXfRqsfvEplq4U+mY3hCxDy2b7jyoTDTC8QpIIU4r4HOzlwt9msRC
 ZmSFZQGP5ScPAcegwK8uLi+Va/A41FfNWIkdBe0Xn+dRz+7Puf3NTB1fnCZyRAjb1Vde
 44gr6UpaSldPwRBDBo1rfKbyklewzi+qDvfO3lUNuQtg5CEByTdSu6dZKQQy5h9DP+K7
 9cI29rjEN0bHR/icZ1pu0pJPzXKtJU0GItUxbZhNbuoJt9bys6L4q/+HkxQ9D4hIbvDD
 XLPHLv+8QukxOXL6Nn4lKI/D1TMv2um/kXyL677IjTJRVOUm+10FmoufzXggbUNw567U
 FA2w==
X-Gm-Message-State: AOJu0Ywi9sJPEELjZ+kMPnJSmhvz/Rd+WtvIfoi9isAOyFi4dR+eVsYB
 TBOnUDsUxqjUi7dISGTMlrTdv1/0ev2fh206CuvAi7hJWpn+7f2QNJs5IkofR0362HzlEeHZ45T
 Ssja1EBY=
X-Gm-Gg: AY/fxX57AuQE54fmEnGTGlW7n3ezxdH55Uck6FmwDAG8E4b70vCdg3WDRZR2uy+1rjP
 /AnUOXjt+S5WcUBY+TGk5pAGzACniLbXTHRCgyCGV3wUNGiuQBCnrK4PJBketlM27CdypFaVvJP
 qeQq4Bt0vbdElURG77xNpuKrgjEN74cMvPJPufL/TnEcUJHhPTSkq+rC2V/pIt1y8InWt7mTgBd
 X4AMDVV7Ig1oPcEJkcl8iXP5KXYY9aKKXJpTJuDMgcyzPlI8rLNO/kYGtOQVYho0EHWtjGUSG3D
 OH39xwWTfmoOJb6zLmvW8ezb2NU8pV4XvUX3Ff8AINj1XNZep04tf5Rqvo03NPWkyBv/ajkuv3a
 PpfmZNxpSH5cxnzbaKwhF/leXLiUy5EA/gg1pwuE8YMCX+5qhrlNtRSM0/qTqq13UsTGm5mkDNi
 TOBzCWR0/0gj55wXJcV68h4PBtVeRSWJhTZXiV0yyiSGMZltq8i7iMQcNLveIG
X-Received: by 2002:a05:600c:35c2:b0:46e:4586:57e4 with SMTP id
 5b1f17b1804b1-4801eb09296mr215599455e9.24.1768934359979; 
 Tue, 20 Jan 2026 10:39:19 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47f4289b789sm317442675e9.1.2026.01.20.10.39.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 20 Jan 2026 10:39:19 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/29] hw/arm/smmuv3-common: Define STE/CD fields via
 registerfields
Date: Tue, 20 Jan 2026 19:38:35 +0100
Message-ID: <20260120183902.73845-3-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260120183902.73845-1-philmd@linaro.org>
References: <20260120183902.73845-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

From: Tao Tang <tangtao1634@phytium.com.cn>

Switch STE/CD bitfield definitions and accessors to the
'registerfields.h' REG/FIELD API.

Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Message-ID: <20260119161112.3841386-3-tangtao1634@phytium.com.cn>
[PMD: Updated STE_1::CTXPTR_HI and STE_7::S2TTB_HI length 16 -> 24]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/arm/smmuv3-common.h | 167 +++++++++++++++++++++++----------
 1 file changed, 119 insertions(+), 48 deletions(-)

diff --git a/include/hw/arm/smmuv3-common.h b/include/hw/arm/smmuv3-common.h
index 9da817f41ae..f0e1dd85715 100644
--- a/include/hw/arm/smmuv3-common.h
+++ b/include/hw/arm/smmuv3-common.h
@@ -11,6 +11,8 @@
 #ifndef HW_ARM_SMMUV3_COMMON_H
 #define HW_ARM_SMMUV3_COMMON_H
 
+#include "hw/core/registerfields.h"
+
 /* Configuration Data */
 
 /* STE Level 1 Descriptor */
@@ -35,63 +37,132 @@ typedef struct CD {
 
 /* STE fields */
 
-#define STE_VALID(x)   extract32((x)->word[0], 0, 1)
+REG32(STE_0, 0)
+    FIELD(STE_0, VALID, 0, 1)
+    FIELD(STE_0, CONFIG, 1, 3)
+    FIELD(STE_0, S1FMT, 4, 2)
+    FIELD(STE_0, CTXPTR_LO, 6, 26)
+REG32(STE_1, 4)
+    FIELD(STE_1, CTXPTR_HI, 0, 24)
+    FIELD(STE_1, S1CDMAX, 27, 5)
+REG32(STE_2, 8)
+    FIELD(STE_2, S1STALLD, 27, 1)
+    FIELD(STE_2, EATS, 28, 2)
+    FIELD(STE_2, STRW, 30, 2)
+REG32(STE_4, 16)
+    FIELD(STE_4, S2VMID, 0, 16)
+REG32(STE_5, 20)
+    FIELD(STE_5, S2T0SZ, 0, 6)
+    FIELD(STE_5, S2SL0, 6, 2)
+    FIELD(STE_5, S2TG, 14, 2)
+    FIELD(STE_5, S2PS, 16, 3)
+    FIELD(STE_5, S2AA64, 19, 1)
+    FIELD(STE_5, S2ENDI, 20, 1)
+    FIELD(STE_5, S2AFFD, 21, 1)
+    FIELD(STE_5, S2HD, 23, 1)
+    FIELD(STE_5, S2HA, 24, 1)
+    FIELD(STE_5, S2S, 25, 1)
+    FIELD(STE_5, S2R, 26, 1)
+REG32(STE_6, 24)
+    FIELD(STE_6, S2TTB_LO, 4, 28)
+REG32(STE_7, 28)
+    FIELD(STE_7, S2TTB_HI, 0, 20)
+
+/* Get STE fields */
+#define STE_VALID(x)      FIELD_EX32((x)->word[0], STE_0, VALID)
+#define STE_CONFIG(x)     FIELD_EX32((x)->word[0], STE_0, CONFIG)
+#define STE_S1FMT(x)      FIELD_EX32((x)->word[0], STE_0, S1FMT)
+#define STE_CTXPTR(x)                                               \
+    (((uint64_t)FIELD_EX32((x)->word[0], STE_0, CTXPTR_LO) << 6) |  \
+     ((uint64_t)FIELD_EX32((x)->word[1], STE_1, CTXPTR_HI) << 32))
+#define STE_S1CDMAX(x)    FIELD_EX32((x)->word[1], STE_1, S1CDMAX)
+#define STE_S1STALLD(x)   FIELD_EX32((x)->word[2], STE_2, S1STALLD)
+#define STE_EATS(x)       FIELD_EX32((x)->word[2], STE_2, EATS)
+#define STE_STRW(x)       FIELD_EX32((x)->word[2], STE_2, STRW)
+#define STE_S2VMID(x)     FIELD_EX32((x)->word[4], STE_4, S2VMID)
+#define STE_S2T0SZ(x)     FIELD_EX32((x)->word[5], STE_5, S2T0SZ)
+#define STE_S2SL0(x)      FIELD_EX32((x)->word[5], STE_5, S2SL0)
+#define STE_S2TG(x)       FIELD_EX32((x)->word[5], STE_5, S2TG)
+#define STE_S2PS(x)       FIELD_EX32((x)->word[5], STE_5, S2PS)
+#define STE_S2AA64(x)     FIELD_EX32((x)->word[5], STE_5, S2AA64)
+#define STE_S2ENDI(x)     FIELD_EX32((x)->word[5], STE_5, S2ENDI)
+#define STE_S2AFFD(x)     FIELD_EX32((x)->word[5], STE_5, S2AFFD)
+#define STE_S2HD(x)       FIELD_EX32((x)->word[5], STE_5, S2HD)
+#define STE_S2HA(x)       FIELD_EX32((x)->word[5], STE_5, S2HA)
+#define STE_S2S(x)        FIELD_EX32((x)->word[5], STE_5, S2S)
+#define STE_S2R(x)        FIELD_EX32((x)->word[5], STE_5, S2R)
+#define STE_S2TTB(x)                                                \
+    (((uint64_t)FIELD_EX32((x)->word[6], STE_6, S2TTB_LO) << 4) |   \
+     ((uint64_t)FIELD_EX32((x)->word[7], STE_7, S2TTB_HI) << 32))
 
-#define STE_CONFIG(x)  extract32((x)->word[0], 1, 3)
 #define STE_CFG_S1_ENABLED(config) (config & 0x1)
 #define STE_CFG_S2_ENABLED(config) (config & 0x2)
 #define STE_CFG_ABORT(config)      (!(config & 0x4))
 #define STE_CFG_BYPASS(config)     (config == 0x4)
 
-#define STE_S1FMT(x)       extract32((x)->word[0], 4 , 2)
-#define STE_S1CDMAX(x)     extract32((x)->word[1], 27, 5)
-#define STE_S1STALLD(x)    extract32((x)->word[2], 27, 1)
-#define STE_EATS(x)        extract32((x)->word[2], 28, 2)
-#define STE_STRW(x)        extract32((x)->word[2], 30, 2)
-#define STE_S2VMID(x)      extract32((x)->word[4], 0 , 16)
-#define STE_S2T0SZ(x)      extract32((x)->word[5], 0 , 6)
-#define STE_S2SL0(x)       extract32((x)->word[5], 6 , 2)
-#define STE_S2TG(x)        extract32((x)->word[5], 14, 2)
-#define STE_S2PS(x)        extract32((x)->word[5], 16, 3)
-#define STE_S2AA64(x)      extract32((x)->word[5], 19, 1)
-#define STE_S2ENDI(x)      extract32((x)->word[5], 20, 1)
-#define STE_S2AFFD(x)      extract32((x)->word[5], 21, 1)
-#define STE_S2HD(x)        extract32((x)->word[5], 23, 1)
-#define STE_S2HA(x)        extract32((x)->word[5], 24, 1)
-#define STE_S2S(x)         extract32((x)->word[5], 25, 1)
-#define STE_S2R(x)         extract32((x)->word[5], 26, 1)
-
-#define STE_CTXPTR(x)                                   \
-    ((extract64((x)->word[1], 0, 16) << 32) |           \
-     ((x)->word[0] & 0xffffffc0))
-
-#define STE_S2TTB(x)                                    \
-    ((extract64((x)->word[7], 0, 16) << 32) |           \
-     ((x)->word[6] & 0xfffffff0))
-
 /* CD fields */
 
-#define CD_VALID(x)   extract32((x)->word[0], 31, 1)
-#define CD_ASID(x)    extract32((x)->word[1], 16, 16)
-#define CD_TTB(x, sel)                                          \
-    ((extract64((x)->word[(sel) * 2 + 3], 0, 19) << 32) |       \
-     ((x)->word[(sel) * 2 + 2] & ~0xfULL))
+REG32(CD_0, 0)
+    FIELD(CD_0, TSZ0, 0, 6)
+    FIELD(CD_0, TG0, 6, 2)
+    FIELD(CD_0, EPD0, 14, 1)
+    FIELD(CD_0, ENDI, 15, 1)
+    FIELD(CD_0, TSZ1, 16, 6)
+    FIELD(CD_0, TG1, 22, 2)
+    FIELD(CD_0, EPD1, 30, 1)
+    FIELD(CD_0, VALID, 31, 1)
+REG32(CD_1, 4)
+    FIELD(CD_1, IPS, 0, 3)
+    FIELD(CD_1, AFFD, 3, 1)
+    FIELD(CD_1, TBI, 6, 2)
+    FIELD(CD_1, AARCH64, 9, 1)
+    FIELD(CD_1, HD, 10, 1)
+    FIELD(CD_1, HA, 11, 1)
+    FIELD(CD_1, S, 12, 1)
+    FIELD(CD_1, R, 13, 1)
+    FIELD(CD_1, A, 14, 1)
+    FIELD(CD_1, ASID, 16, 16)
+REG32(CD_2, 8)
+    FIELD(CD_2, HAD0, 1, 1)
+    FIELD(CD_2, TTB0_LO, 4, 28)
+REG32(CD_3, 12)
+    FIELD(CD_3, TTB0_HI, 0, 20)
+REG32(CD_4, 16)
+    FIELD(CD_4, HAD1, 1, 1)
+    FIELD(CD_4, TTB1_LO, 4, 28)
+REG32(CD_5, 20)
+    FIELD(CD_5, TTB1_HI, 0, 20)
 
-#define CD_HAD(x, sel)   extract32((x)->word[(sel) * 2 + 2], 1, 1)
-
-#define CD_TSZ(x, sel)   extract32((x)->word[0], (16 * (sel)) + 0, 6)
-#define CD_TG(x, sel)    extract32((x)->word[0], (16 * (sel)) + 6, 2)
-#define CD_EPD(x, sel)   extract32((x)->word[0], (16 * (sel)) + 14, 1)
-#define CD_ENDI(x)       extract32((x)->word[0], 15, 1)
-#define CD_IPS(x)        extract32((x)->word[1], 0 , 3)
-#define CD_AFFD(x)       extract32((x)->word[1], 3 , 1)
-#define CD_TBI(x)        extract32((x)->word[1], 6 , 2)
-#define CD_HD(x)         extract32((x)->word[1], 10 , 1)
-#define CD_HA(x)         extract32((x)->word[1], 11 , 1)
-#define CD_S(x)          extract32((x)->word[1], 12, 1)
-#define CD_R(x)          extract32((x)->word[1], 13, 1)
-#define CD_A(x)          extract32((x)->word[1], 14, 1)
-#define CD_AARCH64(x)    extract32((x)->word[1], 9 , 1)
+/* Get CD fields */
+#define CD_TSZ(x, sel)   ((sel) ?          \
+    FIELD_EX32((x)->word[0], CD_0, TSZ1) : \
+    FIELD_EX32((x)->word[0], CD_0, TSZ0))
+#define CD_TG(x, sel)    ((sel) ?          \
+    FIELD_EX32((x)->word[0], CD_0, TG1) :  \
+    FIELD_EX32((x)->word[0], CD_0, TG0))
+#define CD_EPD(x, sel)   ((sel) ?          \
+    FIELD_EX32((x)->word[0], CD_0, EPD1) : \
+    FIELD_EX32((x)->word[0], CD_0, EPD0))
+#define CD_ENDI(x)       FIELD_EX32((x)->word[0], CD_0, ENDI)
+#define CD_VALID(x)      FIELD_EX32((x)->word[0], CD_0, VALID)
+#define CD_IPS(x)        FIELD_EX32((x)->word[1], CD_1, IPS)
+#define CD_AFFD(x)       FIELD_EX32((x)->word[1], CD_1, AFFD)
+#define CD_TBI(x)        FIELD_EX32((x)->word[1], CD_1, TBI)
+#define CD_AARCH64(x)    FIELD_EX32((x)->word[1], CD_1, AARCH64)
+#define CD_HD(x)         FIELD_EX32((x)->word[1], CD_1, HD)
+#define CD_HA(x)         FIELD_EX32((x)->word[1], CD_1, HA)
+#define CD_S(x)          FIELD_EX32((x)->word[1], CD_1, S)
+#define CD_R(x)          FIELD_EX32((x)->word[1], CD_1, R)
+#define CD_A(x)          FIELD_EX32((x)->word[1], CD_1, A)
+#define CD_ASID(x)       FIELD_EX32((x)->word[1], CD_1, ASID)
+#define CD_HAD(x, sel)   ((sel) ?                                         \
+    FIELD_EX32((x)->word[4], CD_4, HAD1) :                                \
+    FIELD_EX32((x)->word[2], CD_2, HAD0))
+#define CD_TTB(x, sel)                                                    \
+    ((sel) ? (((uint64_t)FIELD_EX32((x)->word[5], CD_5, TTB1_HI) << 32) | \
+              ((uint64_t)FIELD_EX32((x)->word[4], CD_4, TTB1_LO) << 4)) : \
+             (((uint64_t)FIELD_EX32((x)->word[3], CD_3, TTB0_HI) << 32) | \
+              ((uint64_t)FIELD_EX32((x)->word[2], CD_2, TTB0_LO) << 4)))
 
 /* MMIO Registers */
 
-- 
2.52.0


