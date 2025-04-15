Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F0D6C369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 20:35:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4mz9-0005BI-Mw; Tue, 15 Apr 2025 16:34:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4myz-0004yL-DH
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 16:34:14 -0400
Received: from mail-qt1-x835.google.com ([2607:f8b0:4864:20::835])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4myL-0002HR-1H
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 16:34:12 -0400
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-4767e969b94so21092571cf.2
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 13:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744749211; x=1745354011; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/75beKJVbQPAqYNdfZxdiKIeNjarDa2uAUSltqMchs8=;
 b=jVfUv4BPgVaDMt3fJUDTJs1b3nSwlqyOYC2Xq7ky57BR++IRYzEYghPXc28mLRQ7Fl
 G5wCQ1M24YPr1ZaO3Cwxcf+JTMHL6JyWy9V98PRHwRRK2ImL/i4Flb4pFilzujlHb0YP
 ro0qhwp9TLx0iwx6CFOXEjzT3hpA2mXd367FiPVqwJAaAymqpOdzPog7J4VtkHNkldFK
 P3jasiOcpUd1No3RzOkjR+HcUfV0ZSk2g3ruGXcNrJrEf5cvUX5R+FkSmMZ0tToxng9o
 qkhPEptW+5jgYLQK2gT5oJLyK/wNJDWvOLdiEu0uXRXOLw0Ipx6IqlQFMbUGuJk//9ea
 cS3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744749211; x=1745354011;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/75beKJVbQPAqYNdfZxdiKIeNjarDa2uAUSltqMchs8=;
 b=qdjNvfPs7NtD2jEbA+QwXdwKKRDILr4CjstjebT+XHP6WAK+iSQU9gJnDclBJhuIgR
 IPEpt/gsgOdgniQ2vodGAuRGAwr1vMzMZMxkmSyY/I9KtiH5nMf6rROhPSqUvL5sB0rA
 au6KwvPT0WM19LLED8VuiXS9zCize+6NAbZWqvXqWR+5O+lnM5jlutDKsFUETQTwPqB+
 mMNAMO6wGcWijtAu0qOKYKMqYwX1leOwrnwv+RZ6DzlXfzikyAQUhP3lSzUWBKH4IEpo
 rJeFfu34sNYniFE8GAbZZuSa1ZR2Okt+3LaaX3a1reGC88an/WIZJMBPLzOPx9QqYSQw
 de1A==
X-Gm-Message-State: AOJu0YxaxqN12haxGbVG77vqziKa0yimGdXNjE1OWIthiygFjIL5Fye9
 A2K3yGbweBMGAWVPeK2f0dM+LnuX+nJexMlJ682TxsFHCcWtAm5pv4IwjLveZBuOpfdskImL565
 R
X-Gm-Gg: ASbGncuBypLwS9rpCX1itpeN/uWzB6boIyNHvX5dJM3rSaI79rj37lsNnIcBLVlC+KO
 2SRzHuIBtpQdlqQ+Rj7cKfLJv8cky5sqXu77pv2o7mlp1mOAflEHkj1KfJUqGo3EJPst9tuF0//
 tseHZC6hHxFFjJNYFiW35Qhiv8n2H9B0trA+8Mv4rY7xS6/1+vTcTXjuW0PbPn199PBe1vxhhpp
 n2CFQm8nFBsLShyOV5IOkF7pf9xlchTy8hmFCGgQtFPBG5JhU1r7zsGCm/4yqPVyw4VARrYq8sR
 WdtJTZWG6Dlx01vud5bPiPnRyVqjDSc8MzbjMgGw86iN8pd7rJeZNWRQtvAGJa8L3Wnb4tsBkjW
 fkIS7llrCXQ==
X-Google-Smtp-Source: AGHT+IFvKS74kPG48MrcTMlUp4JpYWLK2lSkJPT+NCooozeuj5fnf1Nv5ir1kDY9HpxyOBWmjtfJLQ==
X-Received: by 2002:a05:6a00:4c08:b0:736:476b:fccf with SMTP id
 d2e1a72fcca58-73c1faef15cmr1141741b3a.18.1744745774809; 
 Tue, 15 Apr 2025 12:36:14 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd230e34asm9155603b3a.137.2025.04.15.12.36.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 12:36:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 142/163] tcg/s390x: Use ADD LOGICAL WITH SIGNED IMMEDIATE
Date: Tue, 15 Apr 2025 12:24:53 -0700
Message-ID: <20250415192515.232910-143-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415192515.232910-1-richard.henderson@linaro.org>
References: <20250415192515.232910-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::835;
 envelope-from=richard.henderson@linaro.org; helo=mail-qt1-x835.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/s390x/tcg-target.c.inc | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index 2b31ea1c3e..36293d0f42 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -135,6 +135,9 @@ typedef enum S390Opcode {
     RIEc_CLGIJ   = 0xec7d,
     RIEc_CLIJ    = 0xec7f,
 
+    RIEd_ALHSIK  = 0xecda,
+    RIEd_ALGHSIK = 0xecdb,
+
     RIEf_RISBG   = 0xec55,
 
     RIEg_LOCGHI  = 0xec46,
@@ -682,8 +685,16 @@ static void tcg_out_insn_RI(TCGContext *s, S390Opcode op, TCGReg r1, int i2)
     tcg_out32(s, (op << 16) | (r1 << 20) | (i2 & 0xffff));
 }
 
+static void tcg_out_insn_RIEd(TCGContext *s, S390Opcode op,
+                              TCGReg r1, TCGReg r3, int i2)
+{
+    tcg_out16(s, (op & 0xff00) | (r1 << 4) | r3);
+    tcg_out16(s, i2);
+    tcg_out16(s, op & 0xff);
+}
+
 static void tcg_out_insn_RIEg(TCGContext *s, S390Opcode op, TCGReg r1,
-                             int i2, int m3)
+                              int i2, int m3)
 {
     tcg_out16(s, (op & 0xff00) | (r1 << 4) | m3);
     tcg_out32(s, (i2 << 16) | (op & 0xff));
@@ -2276,6 +2287,15 @@ static void tgen_addco_rrr(TCGContext *s, TCGType type,
 static void tgen_addco_rri(TCGContext *s, TCGType type,
                            TCGReg a0, TCGReg a1, tcg_target_long a2)
 {
+    if (a2 == (int16_t)a2) {
+        if (type == TCG_TYPE_I32) {
+            tcg_out_insn(s, RIEd, ALHSIK, a0, a1, a2);
+        } else {
+            tcg_out_insn(s, RIEd, ALGHSIK, a0, a1, a2);
+        }
+        return;
+    }
+
     tcg_out_mov(s, type, a0, a1);
     if (type == TCG_TYPE_I32) {
         tcg_out_insn(s, RIL, ALFI, a0, a2);
-- 
2.43.0


