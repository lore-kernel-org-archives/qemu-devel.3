Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E4F0CA5FA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 10:04:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBUfY-0007oh-Uv; Tue, 29 Sep 2026 06:02:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xBUfJ-0007cv-78
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 06:02:28 -0400
Received: from mail-ej2-x0e.google.com ([2a00:1450:4864:34::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xBUfH-0008Ft-6o
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 06:02:24 -0400
Received: by mail-ej2-x0e.google.com with SMTP id
 a640c23a62f3a-c2da4eea067so351978366b.3
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 03:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790676141; x=1791280941; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=F3YgnIvFjhPZJOJvluiJoQ7sWOshmcyO01yTKvAWt0Y=;
 b=v/KVuLtlpp7MRsK5IPjyjT600I0HGaHB6yL05ZuJd8nHQiONB7S3pMQBbrnEhuws+7
 a/x2+QasvY9OXfDvLl2SUKauY1uc1gh8yruY8yOOrl69Hlcfzd3Cv5bhIIgBJ8q0sFTs
 3UVOgbQbSZNVnk4YQxEriVCKojyLsP8t0onVc6QMr4Fr2ipJrN5RNNaXLeSZ3yStubCr
 P0963y2yfk6udvJDZM88ysfl6EMlarHz/AnJB6YRrnGAq+AnhKNb5j0S/3mjMAlxC0O2
 +b995zv8cz3Xrh/N+8LXA5gjNq9RME9T8mIYTauaIpV46yfq2jn8bu9fawuwXoe2C9Tr
 m2PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790676141; x=1791280941;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=F3YgnIvFjhPZJOJvluiJoQ7sWOshmcyO01yTKvAWt0Y=;
 b=PJuz8zZ5ny7Je1+0TlYk6PdMEcQfA3KTxur4KEvw59dw+DpQ4GiheXJaSJ/tfS7vLz
 bjSPUTl1YY/+UOVwKeirwczRDkFwjfmBTPgGL5GOa7piIPX/mcKQbWktyRFPXmytxR0X
 3nqfEoQVbZJTUYEWtoqTzuJoq2UCPAYJcAZy8HynKymtdd+LnUmGvFtpsbYvJGodK7j+
 8mOB+l9p3NiTpdobFmXt9GCApUyqGpsvBMS7Ogzrlz+Zply3XwNmrccQjoDACL9vL0DO
 dSv2ou8JZE7fVITAHzekTTZ7GTPG/DA+sepkH3Hs8htN8jGA0HS+KIyQ0Xmw3fWzzmFG
 KQjQ==
X-Gm-Message-State: AFuF++mCRXu65ctd/akQYtO2rleEsmkcTdV9lXSZoC3HPG0UrUXJFNAT
 muldnKC/8IFIGlGJpskFMi++bZnj8B3Mv7jB5kK7JiT5rUaXbGvHJddrPgGpF2kHPHFYDRgKfpT
 5VIJA
X-Gm-Gg: AYBFou2Ffqlcc8PeQLvSjPiZizaU53ZCFr5esCucePH0+dnr1nF7J4c8cwzLhNWKQTX
 Ig2lqHPZ7iIv3Vl7ot61h0j8709ciGi/5ciusF2LfSww4a29SEZJ/Acp05NID87aymyfi5E26ok
 Q7s2NY0SMNjRv0WFYUHi9tP6UbN5K4QwjSLY5837easlewMWwpVI4GxMH52PsYDJLPf6auEM9jG
 CTD1tydW9pfrkSY+1J6C5dv3GRsf/26EAu7iXIuONxD0vFyIQaJ2RpzHxswSnzsqkMGXxFb25yE
 o2CRvcxw+aY37ZgXhmLKLWqLHYsfNTWvZNJCLgSIf5Lh1W9oWSwtgbPaFfIsAwWo/jVD4+PGVJM
 /bd/eU8DAY2jxalswiEt37lJ9CsRtKol9VcSgo1/Y+daeaEBreZ6XV1l0uTC836t3OGcWE5c/zN
 2oZOryEIugk8Y/bOHV7yCJFgL0erFBBrP/gnGdPvRFqtvKr7uuDNu0A4d+iOhLv5eKjdXEaG0rt
 G8UhTQaOy5yTitBsCkDtkT880ifwbizldD/TuQ3siX/PqyxFt9iccU9vUvKvBxWIbqlYC0AAtkY
 oZw=
X-Received: by 2002:a17:907:c0e:b0:c2a:fd19:8fa5 with SMTP id
 a640c23a62f3a-c2afd19cdccmr729939366b.34.1790676141408; 
 Tue, 29 Sep 2026 03:02:21 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48af4f88b37sm3091412f8f.5.2026.09.29.03.02.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 03:02:20 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 30/37] target/arm: Widen cpsr_{read,
 write}_for_spsr_elx to uint64_t
Date: Tue, 29 Sep 2026 11:01:25 +0100
Message-ID: <20260929100133.2598676-31-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929100133.2598676-1-peter.maydell@linaro.org>
References: <20260929100133.2598676-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:34::e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej2-x0e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

From: Richard Henderson <richard.henderson@linaro.org>

We will shortly need to handle bit 36: PSTATE.UINJ.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260925215004.456336-10-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c    | 6 +++---
 target/arm/internals.h | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 76956cfd97b..f843f281fcd 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -9514,9 +9514,9 @@ static int aarch64_regnum(CPUARMState *env, int aarch32_reg)
     }
 }
 
-uint32_t cpsr_read_for_spsr_elx(CPUARMState *env)
+uint64_t cpsr_read_for_spsr_elx(CPUARMState *env)
 {
-    uint32_t ret = cpsr_read(env);
+    uint64_t ret = cpsr_read(env);
 
     /* Move DIT to the correct location for SPSR_ELx */
     if (ret & CPSR_DIT) {
@@ -9529,7 +9529,7 @@ uint32_t cpsr_read_for_spsr_elx(CPUARMState *env)
     return ret;
 }
 
-void cpsr_write_from_spsr_elx(CPUARMState *env, uint32_t val)
+void cpsr_write_from_spsr_elx(CPUARMState *env, uint64_t val)
 {
     uint32_t mask;
 
diff --git a/target/arm/internals.h b/target/arm/internals.h
index 1efda543270..843e12487ec 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -2016,8 +2016,8 @@ void vfp_clear_float_status_exc_flags(CPUARMState *env);
  */
 void vfp_set_fpcr_to_host(CPUARMState *env, uint32_t val, uint32_t mask);
 bool arm_pan_enabled(CPUARMState *env);
-uint32_t cpsr_read_for_spsr_elx(CPUARMState *env);
-void cpsr_write_from_spsr_elx(CPUARMState *env, uint32_t val);
+uint64_t cpsr_read_for_spsr_elx(CPUARMState *env);
+void cpsr_write_from_spsr_elx(CPUARMState *env, uint64_t val);
 
 /* Compare uint64_t for qsort and bsearch. */
 int compare_u64(const void *a, const void *b);
-- 
2.43.0


