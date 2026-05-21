Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5BD5CD5BAC
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 12:54:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ2u0-0006dV-Mx; Thu, 21 May 2026 08:53:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fritchleybohrer@gmail.com>)
 id 1wQ22g-00060j-Oj
 for qemu-devel@nongnu.org; Thu, 21 May 2026 07:58:22 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fritchleybohrer@gmail.com>)
 id 1wQ22e-00049N-To
 for qemu-devel@nongnu.org; Thu, 21 May 2026 07:58:22 -0400
Received: by mail-pl1-x643.google.com with SMTP id
 d9443c01a7336-2b9ea536877so36664975ad.1
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 04:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779364698; x=1779969498; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=W2FeeLOoVdXBR2Rb1YkjqQG7mEPD3tMK8j89UuIwh40=;
 b=LSJbwRO/q9UXcJxZG6ncff1N+kFXcMI/25B4JA8V6jyPXe7UmlPkM3PvzM/waeD19U
 Pb1XMLK6ZrY9mCPsZdfAqaEQ159R9OD9LeNtBCI8iMwZxTRAKDVIDXd+B113tcmVaP56
 zSH12S/T/Jn5v/OPF2Qc5g0zcUZNEWRR47fBk9bPWZjYAu3LWlqqxbCBd6RmXYIWNm7R
 2VdnyyHag1JrT5bQ6YKQ9zVteJHpgDXcQfED4rY6QasV77BnbXuHsGFl/6gL0J32Ch0l
 pmtAPBZyh5xvBbrrlxn7T0DljE4c4wcNRDifofCP5ExJ3JSdmAGzfyR/2zbAJICoeYeo
 Dw8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779364698; x=1779969498;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W2FeeLOoVdXBR2Rb1YkjqQG7mEPD3tMK8j89UuIwh40=;
 b=q1lTyCrUEg0YTl8Ov2lMzWmaP2sJdF1lykta43KF82zwtMlhyb2MainCjbtZNDvIcT
 nns2n2VphbJaGQdeLdV5vkpYEWY7GjMj5nkHDdd+T67Z3rp3EoxUVkk5G5toYoUkEXjI
 FuaVAXuLZ9s+NRS7kfI0J6vAbWVL4J89zwfbnEdzCh7poZNsAMfr4GobXWjpAfOjwRpY
 eQYGqz2+wnIOzYdYUZoW6+doYQ1Q+SFiAJNzUktjNHoB3XWtvhtqX2AJePk5P2aqoTq+
 UCo7I4JwVXVJQwyhFnyZtJ8bx/OSKg/mWgG0etnkPFTH0Mulm96FPN+sUctr3TmGx6cc
 u68A==
X-Gm-Message-State: AOJu0YzKfMgBx3wZBdaqcJtTnKa3WzBbiomlrlDHB07iC6iDuwa9zcYN
 ZrH1hupog/odgc4SDotdgNyAALh1IXpc8IqyTcBIHKrTNHBtmkxLf+bp8BqTHhM9+QFbnnnd
X-Gm-Gg: Acq92OGttEftiwjEmxLv52w3kEsnQaLmii6jLBlyEoSmlQWIbftP10cl4dduDFVRoSB
 L+kbGLYShMr6o27yjTtioOKg/gZD7IOccHnmdq+/giAp+MzqalVZ2hgyYWhKRFlJsS6i+2zFoc3
 wPSodagJvkFlY8wMDRGbqEdjfEf5M38Lhvt7Qa9Y7cqTNrkrK0EFojC6o+wkw2X0GXSAwsHGEIx
 I97TMPyKHt0Kf3BWjPpbHT0q0J/Swb2WZevgu/yzTf0m1aR4YIIJBkkGJnuQG6BnR5snnbSfWsK
 5aWZyn3r7aPnTOeY0YQgsbZUZU4jRWKQRUhVcRzq7EWHxAg1Ea/PvKHSpa/YnrTCEd3nwCQJF6Y
 srN/2mAxp7top3MhKYlFCVlx7D5HOMahs9eeuOJepwpbkkYs+nzQqpneJU0sxIRO73dviKLiYvd
 uioocH49Gsn6DjDwOSEOJMIvfpobMYSfQYrHSFMKD3wv8+qnswyQCJS6REvrRlhOIvQB/qStfXQ
 Fy2et+AC4ngw6x7Y0ZGsV2cwQs=
X-Received: by 2002:a17:902:ce8f:b0:2bd:5ae4:26d1 with SMTP id
 d9443c01a7336-2bea229cbc2mr24423665ad.17.1779364698397; 
 Thu, 21 May 2026 04:58:18 -0700 (PDT)
Received: from openkylin-pc.lan
 (ec2-52-74-255-244.ap-southeast-1.compute.amazonaws.com. [52.74.255.244])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bea9a3c89csm8279415ad.83.2026.05.21.04.58.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 04:58:17 -0700 (PDT)
From: Zephyr Li <fritchleybohrer@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, daniel.barbosa@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com
Subject: [PATCH] target/riscv: Raise illegal instruction for Svinval in U-mode
Date: Thu, 21 May 2026 19:57:49 +0800
Message-ID: <20260521115749.28774-1-fritchleybohrer@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=fritchleybohrer@gmail.com; helo=mail-pl1-x643.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 21 May 2026 08:53:24 -0400
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

The RISC-V privileged specification requires SFENCE.W.INVAL and
SFENCE.INVAL.IR to raise an illegal instruction exception when executed
in U-mode. Check the current privilege mode during translation and reject these
instructions in U-mode, so they are reported as illegal instructions.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3493

Signed-off-by: Zephyr Li <fritchleybohrer@gmail.com>
---
 target/riscv/insn_trans/trans_svinval.c.inc | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/riscv/insn_trans/trans_svinval.c.inc b/target/riscv/insn_trans/trans_svinval.c.inc
index a06c3b214f..a9bf75c7e9 100644
--- a/target/riscv/insn_trans/trans_svinval.c.inc
+++ b/target/riscv/insn_trans/trans_svinval.c.inc
@@ -39,6 +39,10 @@ static bool trans_sfence_w_inval(DisasContext *ctx, arg_sfence_w_inval *a)
 {
     REQUIRE_SVINVAL(ctx);
     REQUIRE_EXT(ctx, RVS);
+
+    if (ctx->priv == PRV_U) {
+        return false;
+    }
     /* Do nothing currently */
     return true;
 }
@@ -47,6 +51,10 @@ static bool trans_sfence_inval_ir(DisasContext *ctx, arg_sfence_inval_ir *a)
 {
     REQUIRE_SVINVAL(ctx);
     REQUIRE_EXT(ctx, RVS);
+
+    if (ctx->priv == PRV_U) {
+        return false;
+    }
     /* Do nothing currently */
     return true;
 }
-- 
2.43.0


