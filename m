Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83041FF8875
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 10:46:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIOt6-0008LS-FE; Thu, 30 Apr 2026 06:44:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wIOsz-0008Gn-2A
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 06:44:49 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wIOsu-0005Kc-FP
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 06:44:48 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4891f625344so8408665e9.0
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 03:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777545880; x=1778150680; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SJ3nvH0CdgnQGuiZq72mX6EJh1rauF0iDM3crLBhnzQ=;
 b=opQ0Qhr8U7i0zeF5HOBl/YX5tgVYLyyzcu4C0IZMkx9KSFP3VI90sHq53DxOXIFbmC
 MGkeuF8o3q29iYKyVQo/feoznCkuKyKspX2OIowe+GvgyY5wAPELSFjAF8fG1rep8szO
 CaeHTwmA8Pu1Qs+BmCaqbIEjTJbVFR+HIx/XUMCKogaDfMoar0PoIF94/zv7tQmeR6FU
 mZWe0lEQSD3XF4c6Bo9Dyd6Jl4l9QovAf48BSXg3VchXK+w5H1edBG75K0nklRPZMrhF
 4+88nekxPbaw2ugnUHI2qR5GdHA9m6fyf+jxK1blsV/NfpRcK6KhUpDweGyhL6MpUj7h
 qViQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777545880; x=1778150680;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SJ3nvH0CdgnQGuiZq72mX6EJh1rauF0iDM3crLBhnzQ=;
 b=VoseQZlPkZM9VXFjXzHdl5xwG+m89ng3JM6nXRlpWG79CRhvv0f6KJD1g/zOmXKtWJ
 kSox80YHs7FroKR7EXUSzazzpUXxCsYCCJ6wGKiQN/dZ+OUQm1bqwGAJcXdv08r/orsf
 1vJgVmdk1VDwQSbHgaSbz9OML+TJODVCQ1qjq2Jki2U9316xQ/7Hv3NVBeURTiPFC7HE
 hVq3zzGziWltJ0vvOvMw7qtECq/YmptulNlBE5tIghz8ePg8xmTqFebkt5FYayULa9Sx
 tsQ3zAPW3ohOyfW2yViFqW5lkFBP1g9r2ZLpL6HIUarAsJbiC69mEJc/uNy7ELUEvNk+
 kp+g==
X-Gm-Message-State: AOJu0YwGRp3yBLm01pajG9Z0BS6D9G2xtJUeot+DFwOI2xXDiaEVw3bC
 9NNoiw5k3v55e+79+Eb9RXDp6Rf5qPRivM662cVSZ0JACQ/gsbUUDiNdz382lnereKo=
X-Gm-Gg: AeBDieuzFalv2xzrh9uO1hlWBNVMfTT7hyR/s7qk2YviZzEu4cVFN7QMFCRgEMV+3gO
 jhIjXmxmSZrzH3GID1rtEoyabKBBVuanPQMCF8tMj/LNJFZrypAvbN/TCmiEiX40Xf4Cj2AXkK1
 065FCfB4NOMsHFVc1V8q6vauTltrr4kRTGod8JNRl1ww2Dhn6H/lt5FKw5Hv3FP8+0kfjlyTlkO
 WdyyrRFR7/YEETRTHauxmg6npqhgK9+ma5e+lOB22dStU+zAUWydopicP60tOBdZBO9wMfx/Llx
 N6YV7t+nbhKcdSPCMEmvvNPl0Z5RJEgEMQyslNUeHlk65tWM72fluu+vE1Yky9a6GNEqh4cFZZH
 DklY/2Xje5HkyGxQUXGTCnkb/SNcJVaomhwsC65Sth/HaRpcaKBBhMUI2msnIlzqgBZOLQuMC0w
 HkcokRuvKf2RdzLhxPS/asNY4Vs8IhnHtLng==
X-Received: by 2002:a05:600c:8707:b0:489:1baf:8c03 with SMTP id
 5b1f17b1804b1-48a86084573mr36555495e9.11.1777545879496; 
 Thu, 30 Apr 2026 03:44:39 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a7c32afb0sm38448105e9.35.2026.04.30.03.44.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 03:44:37 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 127B05F936;
 Thu, 30 Apr 2026 11:44:35 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-arm@nongnu.org,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v4 3/7] target/arm: ensure aarch64 DISAS_WFE will exit
Date: Thu, 30 Apr 2026 11:44:30 +0100
Message-ID: <20260430104434.1482407-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260430104434.1482407-1-alex.bennee@linaro.org>
References: <20260430104434.1482407-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
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

This mirrors the logic for DISAS_WFE in 32 bit world. As the WFE/WFI
have similar behaviours shuffle the case statements around a little
and update the commentary to cover both.

Fixes: 252ec405768 (target-arm: implement WFE/YIELD as a yield for AArch64)
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v4
  - shuffle case statements, unify the comments.
---
 target/arm/tcg/translate-a64.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 9a27c4c6ec7..25f0a806512 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -10916,25 +10916,25 @@ static void aarch64_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
         case DISAS_NORETURN:
         case DISAS_SWI:
             break;
-        case DISAS_WFE:
-            gen_a64_update_pc(dc, 4);
-            gen_helper_wfe(tcg_env);
-            break;
         case DISAS_YIELD:
             gen_a64_update_pc(dc, 4);
             gen_helper_yield(tcg_env);
             break;
+        /*
+         * Both WFE/WFI can cause exceptions or exit the loop to
+         * halt so we have to make sure we have rectified the PC.
+         * However they can also return directly if they don't
+         * enter a wait state so we must add an exit block so we exit
+         * the loop and check for interrupts.
+         */
+        case DISAS_WFE:
+            gen_a64_update_pc(dc, 4);
+            gen_helper_wfe(tcg_env);
+            tcg_gen_exit_tb(NULL, 0);
+            break;
         case DISAS_WFI:
-            /*
-             * This is a special case because we don't want to just halt
-             * the CPU if trying to debug across a WFI.
-             */
             gen_a64_update_pc(dc, 4);
             gen_helper_wfi(tcg_env, tcg_constant_i32(4));
-            /*
-             * The helper doesn't necessarily throw an exception, but we
-             * must go back to the main loop to check for interrupts anyway.
-             */
             tcg_gen_exit_tb(NULL, 0);
             break;
         }
-- 
2.47.3


