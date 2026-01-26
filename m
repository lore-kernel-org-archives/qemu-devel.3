Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 275C1C88E58
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 07:23:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkGuh-0007Gm-NL; Mon, 26 Jan 2026 02:21:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1vkGg6-0003A7-Os
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 02:06:34 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1vkGfu-0004PR-E8
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 02:06:21 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2a09d981507so27941535ad.1
 for <qemu-devel@nongnu.org>; Sun, 25 Jan 2026 23:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769411137; x=1770015937; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5xCSzQWwTJF2/7eDxsKs1AgITtRoia5ffM8pnhI5abA=;
 b=naxPWNJPr54nlrTeMkWFOYXTayh/QLY2ozsf8XjLJkShgieXzm2At46tUHzZE6vgVL
 W8XI7qhkY4ONSGidMeu44OqSh76/eY9k0d0qLQOPtm5oJ20ZEW6ZurLzKwyoaB27PA0H
 1dvNTzjyWBEJAHL7FFmS8iE/PRHpzTqqpzFYc8rkwDJ/WSGalTQIVrM3tqikyd4SlDpV
 3UdFbJ8f7w1aw64/wuDZWrLsSzZONkk/mBH1kIRh3RUnhztWZeolPJFOKSLzGcHSMVqq
 3lE+BqjFNQ4QD46TMVmCY1g8a+T4Hh7Vb9aigJST5p+mD5nGh/ZbodbYrgeMx4HY5kwZ
 8hNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769411137; x=1770015937;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5xCSzQWwTJF2/7eDxsKs1AgITtRoia5ffM8pnhI5abA=;
 b=eMZCAmVrfRxnjDzHTvu9CEa9P+oQ4sOa/X5FBprTryQKY0YapsX8ht/OhDuyqbN1VT
 8+UQvPLPD2PqCRdu1s58heKq7+9lm2VBSw4ezpDk46uzeH1tRB92N/T3YxpPyyFoTeCh
 1vueyHbhQ42hC+6Jc6TxWyvBE62oeuS2VV/mT53TJGd5E5oQuS8yhpmbRL5q98OIRYB3
 vgs4q2XCtGaGSfoer0I+ISMLkEC9/9lp4AU1AuftwEJ5XxtBy8/OOSOEFLiVYG1X7fGC
 sXbg7kUPseAljWR8r6FeGeH+5oIEKHuaCbFIDGLCJqyY6LkdcS3AVBGI1Lqz2cAf/Cca
 Hjnw==
X-Gm-Message-State: AOJu0YwfJB70ELSaZlv9oMwYjOCDObjjh31VfYc27Vzjp38ZmBjeHGI8
 toQyrBN4YauusVxfq4zyJfPVKe4WW3xWgg/BNTFpMb94GZhLbBq2XPfubCo1RQ9h
X-Gm-Gg: AZuq6aJlXUN5M6rtzOJdlZoeNMOOqLnsNXd0ADb0psV2GwV+HFKQRajnJk0uT2r0yQP
 sTt0ECJnK16DrjsAM1LKH9HUgd9k4xKQtVGZogt+H5PO81PlaPQws4N1qP/u9qEa9TyIwe9isHt
 p/V0sm9OeiIpCqmuOhMQFc6OOVSyuuTpVIced4wNTDrpBkRxY+hJqUCic7PZxjou4uhJc6deDK0
 QsQaFpKUX0jo10rQjUbp6Ei+Ohr8bjtbTXZKUzBk9ayOQRNh7FHc+R6wh1LyemFR3LkTPAU5fFm
 vOxXYiK5Y3/lTF5knbF5lM0kJ2ndthRzsOdlzzmCinZJYSYR+rOgcncZmjJIRIqMbsHxPFnM09/
 6eQQFwK7TvIV5QK6DcCQbolumQgAF+MlL0jUa3+6aI5LLvikUTrk4FP0hGB2HGnJbpt4D2gsGni
 Ez+CI6u45LC+tvZSBkDhZlj9/YIgX4mWXr1yUR67RxNg==
X-Received: by 2002:a17:902:f54b:b0:2a0:906b:db3e with SMTP id
 d9443c01a7336-2a8455b76e9mr29605695ad.27.1769411137276; 
 Sun, 25 Jan 2026 23:05:37 -0800 (PST)
Received: from brahms.. (fp93c00990.tkyc601.ap.nuro.jp. [147.192.9.144])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-823187716ebsm8661487b3a.66.2026.01.25.23.05.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Jan 2026 23:05:36 -0800 (PST)
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 WANG Xuerui <git@xen0n.name>, Aurelien Jarno <aurelien@aurel32.net>,
 Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, Stefan Weil <sw@weilnetz.de>,
 Kohei Tokunaga <ktokunaga.mail@gmail.com>, qemu-arm@nongnu.org,
 qemu-riscv@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 20/33] tcg/wasm64: Add mb instruction
Date: Mon, 26 Jan 2026 07:03:33 +0000
Message-ID: <27f082f262e67da490da8c00f35df78d13e62767.1769407033.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1769407033.git.ktokunaga.mail@gmail.com>
References: <cover.1769407033.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

This commit generates the mb operation. In Wasm, it uses the atomic.fence
instruction as the fence operator [1]. TCI instruction is also generated in
the same way as the original TCI backend using smp_mb().

[1] https://webassembly.github.io/threads/core/syntax/instructions.html#atomic-memory-instructions

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 tcg/wasm64.c                |  3 +++
 tcg/wasm64/tcg-target.c.inc | 19 +++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/tcg/wasm64.c b/tcg/wasm64.c
index bb2651c4dc..895ae062ee 100644
--- a/tcg/wasm64.c
+++ b/tcg/wasm64.c
@@ -573,6 +573,9 @@ static uintptr_t tcg_qemu_tb_exec_tci(CPUArchState *env, const void *v_tb_ptr)
             taddr = regs[r1];
             oi = regs[r2];
             tci_qemu_st(env, taddr, regs[r0], oi, tb_ptr);
+        case INDEX_op_mb:
+            /* Ensure ordering for all kinds */
+            smp_mb();
             break;
         default:
             g_assert_not_reached();
diff --git a/tcg/wasm64/tcg-target.c.inc b/tcg/wasm64/tcg-target.c.inc
index 0f51310700..d187dca970 100644
--- a/tcg/wasm64/tcg-target.c.inc
+++ b/tcg/wasm64/tcg-target.c.inc
@@ -1116,6 +1116,11 @@ static void tcg_out_op_r(TCGContext *s, TCGOpcode op, TCGReg r0)
     tcg_out32(s, insn);
 }
 
+static void tcg_out_op_v(TCGContext *s, TCGOpcode op)
+{
+    tcg_out32(s, (uint8_t)op);
+}
+
 static void tcg_out_op_ri(TCGContext *s, TCGOpcode op, TCGReg r0, int32_t i1)
 {
     tcg_insn_unit_tci insn = 0;
@@ -1941,6 +1946,20 @@ static bool tcg_out_qemu_st_slow_path(TCGContext *s, TCGLabelQemuLdst *l)
     g_assert_not_reached();
 }
 
+static void tcg_out_mb(TCGContext *s, unsigned a0)
+{
+    tcg_out_op_v(s, INDEX_op_mb);
+
+    /*
+     * Wasm's threading proposal provides atomic.fence instruction as the fence
+     * operator.
+     * https://webassembly.github.io/threads/core/syntax/instructions.html#atomic-memory-instructions
+     */
+    tcg_wasm_out8(s, 0xfe);
+    tcg_wasm_out8(s, 0x03);
+    tcg_wasm_out8(s, 0x00);
+}
+
 static void tcg_out_tb_start(TCGContext *s)
 {
     init_sub_buf();
-- 
2.43.0


