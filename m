Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1469FF8860
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 12:51:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHLQB-0001wY-HF; Mon, 27 Apr 2026 08:50:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHLNj-00083k-1U
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 08:48:22 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHLNa-0005eP-Kw
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 08:48:05 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-488e1a8ac40so126643325e9.2
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 05:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777294080; x=1777898880; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pOHNk9yafmXiW9sEhbBQa9qsO6sZzBVD7jAny8l8sdY=;
 b=b6rvi5RaRSPyKKy17Eux2v8LUUZkPhYsuSH+CIsqku1NIyO1C+VJK9xxfnVTkgs2su
 eljZt/+sBg6I7x0w0SqqAOnKvJDGxqHypBPAF39gLCZ5OWJB8kc77e/mjH11GlnXAyVS
 UHJyNln1OJyZ/mO6TiAV3nxP2av2luxm5sEQXcnCpT7y3g5D6JdNZP289CF1yaPqnXS6
 HwiJpsX11LlvpQCGtYAT5iQH7Q8H/TQQkxxT62iij1OAy9dZSMpgMczE/HnBSNt+hWvR
 0dv0dR9LdUYg3TUAU5T8TVV6dcQmnDd8Il43th3y8/1nF10vfG3Pgwg1IP/JAKYJQs/v
 kmSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777294080; x=1777898880;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=pOHNk9yafmXiW9sEhbBQa9qsO6sZzBVD7jAny8l8sdY=;
 b=YU/iXRFg/b05aPWCKxqqb1xZDstNUgRtJYE7ZewEEsb1x/BDXOVIvaL0Zh5pBsY3ni
 cUsPI2EwPKc02B/oWmNjxa5zWvGnqFs04Ij4wu3eY1okmuODmoHZ/5hgtmNwMkbb1lfn
 ohULpsMrxLMiGnwaonemCUov+pvdLtnI9CyqH5YoCsuO2o073+Kej6l3fAw7mq3IHw88
 EaJm0U5z7/yMXvqaEmR/UOmCJro6D1FFD/tXaK93t2LPoIdzb7+FYe1kohWZLoSfdAnn
 c219SAHIDoNkhCQchV1wkaQF4G/IGVbRC3ohxLBFoXwpobA6FBGccT/L9WIdCTWV5QP4
 OJCQ==
X-Gm-Message-State: AOJu0Yy2sitY2CzGEZpwCUL/ap9LXjEu64JP8s2s7nL/BRJxHGpBsLls
 cm6Xrz3BkvTcTOe1hncv6T11VHHWcJ/lJ57ClWS9qGXoe82cCXqmqIUnyP1YhRxAOCc2+vggc3D
 0zNLI
X-Gm-Gg: AeBDiesudeuVS6mgU1PijRCv2tXkYURVVGFfWyfpR0xjcU3DpOAeoabg90w1hW5z4Tz
 XlC89pV076VCundT+QpcUdE7Pa4QyWQ70o6yK0VAftX/nQ0rhVcu1JTkZED2jL+RFytoh0Gl5lv
 4KsS4Cy/CnoOBIrpYScnESxbwUXm2k1d7MYDiDYhGQmg8IjEAa3fJJJzFd5UvjTQ9Fnoa8/fYAv
 jLk66zMwFvKMZ+TJsPU2n9gCIYDRoyGaHRgltXbT8v72ORn0OsbDgVPu4dSPLxBr5T9vwem9B8G
 vts72uxJ3mnFDm0FdGWqipZfGdy0ehmxKUmkcqzlt+TjEbgeHrtggAQprcc08tOi1a2JN0AXk8g
 3YMagxIyndtidUEG+qKSyfv8Q3uNIUvXJhzrGZw/9ZRYjJXVktdyrKrY2SX7u1PqVCiryZdwd07
 DWBAYPEPFWMJXY66WcObFjUAr/krUkWYU36L9t/vCVm+5qmET6mtPzIEO9dTgY/F90++fV7xpJ4
 bWRohR5JrY77Vxy7NxHsZZJtMk+8hKXP/wCcE3lIg==
X-Received: by 2002:a05:600c:5246:b0:488:a639:b787 with SMTP id
 5b1f17b1804b1-488fb74fc0dmr614571115e9.11.1777294080314; 
 Mon, 27 Apr 2026 05:48:00 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488ffc5e3f4sm448974115e9.2.2026.04.27.05.47.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 05:47:59 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 24/63] target/arm: Replace MO_TE -> mo_endian() for Cortex-M
 helpers
Date: Mon, 27 Apr 2026 13:46:58 +0100
Message-ID: <20260427124738.966578-25-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427124738.966578-1-peter.maydell@linaro.org>
References: <20260427124738.966578-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260414005348.4767-9-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/m_helper.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/arm/tcg/m_helper.c b/target/arm/tcg/m_helper.c
index f5954ce9bf..1bec8e9aea 100644
--- a/target/arm/tcg/m_helper.c
+++ b/target/arm/tcg/m_helper.c
@@ -634,7 +634,7 @@ void HELPER(v7m_blxns)(CPUARMState *env, uint32_t dest)
 
     /* Note that these stores can throw exceptions on MPU faults */
     ARMMMUIdx mmu_idx = arm_mmu_idx(env);
-    MemOpIdx oi = make_memop_idx(MO_TE | MO_UL | MO_ALIGN,
+    MemOpIdx oi = make_memop_idx(mo_endian(env) | MO_UL | MO_ALIGN,
                                  arm_to_core_mmu_idx(mmu_idx));
     cpu_stl_mmu(env, sp, nextinst, oi, GETPC());
     cpu_stl_mmu(env, sp + 4, saved_psr, oi, GETPC());
@@ -1055,7 +1055,7 @@ void HELPER(v7m_vlstm)(CPUARMState *env, uint32_t fptr)
     bool lspact = env->v7m.fpccr[s] & R_V7M_FPCCR_LSPACT_MASK;
     uintptr_t ra = GETPC();
     ARMMMUIdx mmu_idx = arm_mmu_idx(env);
-    MemOpIdx oi = make_memop_idx(MO_TE | MO_UL | MO_ALIGN,
+    MemOpIdx oi = make_memop_idx(mo_endian(env) | MO_UL | MO_ALIGN,
                                  arm_to_core_mmu_idx(mmu_idx));
 
     assert(env->v7m.secure);
@@ -1131,7 +1131,7 @@ void HELPER(v7m_vlldm)(CPUARMState *env, uint32_t fptr)
     ARMCPU *cpu = env_archcpu(env);
     uintptr_t ra = GETPC();
     ARMMMUIdx mmu_idx = arm_mmu_idx(env);
-    MemOpIdx oi = make_memop_idx(MO_TE | MO_UL | MO_ALIGN,
+    MemOpIdx oi = make_memop_idx(mo_endian(env) | MO_UL | MO_ALIGN,
                                  arm_to_core_mmu_idx(mmu_idx));
 
     /* fptr is the value of Rn, the frame pointer we load the FP regs from */
-- 
2.43.0


