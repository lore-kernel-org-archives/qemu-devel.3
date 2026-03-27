Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2927010F284E
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 16:48:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w6AJs-000777-Ny; Fri, 27 Mar 2026 12:46:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w6AJ8-0006gr-Sl
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 12:45:15 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w6AJ1-0003Mb-Ru
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 12:45:14 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2ad9a9be502so14631955ad.0
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 09:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774629906; x=1775234706; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YXzIIST3xy/TAN4MvDOBAWjprHM5xgU3m+1mXtsXC14=;
 b=y++4yOigOXY8nfNzPeNsuRJKjiCLYXuCTYKQ9i3iVbHFJTZ1VdxeWJ+zkcbBlFq7mm
 NRGVxGbl45LoYl1gvJKOUm/wqzIHEJuNN8XOQhKGQqf4JcdvijTg0ZpKTIIK6wazHktf
 +Iy3pb+vAD9KMHyRarPOczUdItDwK9PlIyYM+QNRgZfB450QcpRCYrqA1iur/leRW3mM
 9Ic/DnentrKr96BAZNwDvt2hUP397dgTG7MGw1v62t9rjDYlqaCgKOOT7sK3rN8LGrMV
 Ptaththm6NgB9jX0mhTx9C0M7AKMKdlXK5D57UoTqDxhZoqAkIJwwrURyOn5FAoho7/V
 b6aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774629906; x=1775234706;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YXzIIST3xy/TAN4MvDOBAWjprHM5xgU3m+1mXtsXC14=;
 b=G791A3hyAMrC55Cuw6labmYKZ48aoMaZIPnDFjdlWrIQA9FWN4KNdabuCUF6Q+wZ6a
 rkj7EO9+CMdNiGhUOH9V21UN9BP8K3JDOaPHYi2aNbqNXQTme9IBpfGP4/dJzCDgpIir
 gTftqUIgrD3AoxVbhLKHQpbnwLcrGQ+kjXCFDFyg7HudtAFgQnNrHX6AP/9tcp2pg7vB
 dVFwm3sZufmD8sbOY+6RpeMIrmRqXrXf106IwLj6qK8xJzR4jj4nihLEdUXK6pK+L9Cd
 E76TA08atSQLnqEVRZlK6QN+4NGnoU2KJckopGetwxkQ78XEW9TZDsB5YWovQqCcpZcQ
 HPcg==
X-Gm-Message-State: AOJu0Yz2eoaa4rOPS2nzmEUkMGhkiARxJUmBV/4MSv7FIZquvEqm/ezK
 uwKl728A5iHo4yL9Gl/LiiuzJJNENXBI+KyDD5l3jLszhaLF697o4+sD0Cx67pH5ADZcr/RA5l5
 VPaKNpQ8=
X-Gm-Gg: ATEYQzzV/drXXvtsSjN4mqqNBJ9RsIIqms01xQcV1OsCCnT+b5mPdCaDtmgZR9jXB5/
 6v/0iofZSCgQq8H+wlK2UpbecFijPP4/jroaaTgsgfoX3dEP5AryJG0Jli1f66rcLOG18ld52Uo
 JpFKrjHAyHRioPj648sKTWZyovaodVUeZhdE9SYPmgS6MCEDMr5QX8kCO1wL2byDrPHVVCs//sC
 ow4pfIyBB+6w+RiIunCnQ23WKJCNvCNAbtiUQflBkbTVqLqwsujSZWn+G0XSAGw7rU97zdnZ09R
 ajNBjdL9nTb7iPLr/VMyiCebzWOkH5m6WL6y60GAYQOPmGm0ai5TdQNNchMU27I+rRZh//ERrx0
 XyPYQRvqs/YeE90eofxSL8OzUpl3/LV/iwHW4BEmxhSRrWDu+msCEg9kg5Bd70d1OcknZgMP/t0
 aBYq6CB3V4aznnOKWQJ6AanU2gu45UI7HePoX5P/8+F6gTGPDRnhQfXXu2UeUKomqpXylgXP2lx
 mVf
X-Received: by 2002:a17:903:22ca:b0:2b0:4579:adc with SMTP id
 d9443c01a7336-2b0cdcb07e2mr36594045ad.33.1774629906309; 
 Fri, 27 Mar 2026 09:45:06 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b0bc882339sm63890655ad.43.2026.03.27.09.45.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 09:45:05 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, jim.macarthur@linaro.org,
 qemu-arm@nongnu.org, philmd@linaro.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 12/12] target/arm/tcg/translate.c: replace target_ulong with
 uint32_t
Date: Fri, 27 Mar 2026 09:44:49 -0700
Message-ID: <20260327164449.596767-13-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260327164449.596767-1-pierrick.bouvier@linaro.org>
References: <20260327164449.596767-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/tcg/translate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index 4546bbeeeff..204f9657993 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -6450,7 +6450,7 @@ static void arm_tr_insn_start(DisasContextBase *dcbase, CPUState *cpu)
      * fields here.
      */
     uint32_t condexec_bits;
-    target_ulong pc_arg = dc->base.pc_next;
+    uint32_t pc_arg = dc->base.pc_next;
 
     if (tb_cflags(dcbase->tb) & CF_PCREL) {
         pc_arg &= ~TARGET_PAGE_MASK;
@@ -6612,7 +6612,7 @@ static void thumb_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
     bool is_16bit;
     /* TCG op to rewind to if this turns out to be an invalid ECI state */
     TCGOp *insn_eci_rewind = NULL;
-    target_ulong insn_eci_pc_save = -1;
+    uint32_t insn_eci_pc_save = -1;
 
     /* Misaligned thumb PC is architecturally impossible. */
     assert((dc->base.pc_next & 1) == 0);
-- 
2.47.3


