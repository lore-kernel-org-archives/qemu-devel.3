Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 075D4EB1076
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 15:55:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzzPx-0004aP-Tb; Tue, 10 Mar 2026 11:54:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzzPw-0004X6-VV
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 11:54:44 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzzPv-0006fe-8o
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 11:54:44 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4852ff06541so33502495e9.2
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 08:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773158081; x=1773762881; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9C2vZcOnycahYVmKRiW0cgrjpEH0GI7TXcNCfNbnBP4=;
 b=bOy1DeJomN4sKs9/v6KnpoRhIjEqC5N5pnueB2T1VhUc/f7TUSlWJcauCHwhJkw6qN
 T7y4VEUxD9yFpXDEvDcJ+ySuzsCBgOpptntmPepl3YLDtADGICuX6C7QlxDe7rkD6TNW
 ELLaymfNct+x/FHmB+XU2ZfqPTzzUl8YXWivXJIyF0wdShXQbkX4LskDzKn9RscGOo9w
 QAqzDxmKo7Ty+7RLhahAixtbJGvFAqZqXSf9ritTH92vsgvR906dAysJ4inZFp18aDsE
 nPbIxxHI/gPrNrprkPH0CSXLJo0IjSWGkkJLUsqjXthqKOayiDQp3+1eYYCRZFTV40Ne
 DVoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773158081; x=1773762881;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9C2vZcOnycahYVmKRiW0cgrjpEH0GI7TXcNCfNbnBP4=;
 b=kL9TiGfOLa0xbmNmxLD2hDo/rqS3dBDP4xxbgVfCvCnyH3ywyjZzWylctsF9HrHpY4
 Y9438/RHV51eQBoaX8DgddNbT+x6r3nl4rKQJ3pBut2Vk94h2R1jwh35BkS4Y0DZYgiK
 Kj+ju3Bvy4xAUibIrzYOMrTyf0ZP7yWWpwO3DfwS7sbeqCYYedVi5oBt1rJ34GLX6IiH
 CBGN0aTIOMj6uairbjUR5wy1XIyHUPkziDmv7qFY13cXelkxYiQRZ4EFEduE96oC0LZ0
 dumC49pS+ssta+ZBaQ8UQtzQRAHzemEAruOjWEjMfHkIVpeXXlGxK6QQWxadWOPICjoG
 pNDg==
X-Gm-Message-State: AOJu0YxgABGwyYJcv183pp+bZnMOUVT1O4MqnfZNBKRi2uLZZkCrLx/T
 +wcg/oYzOmKhsSC+39VCwRXqXNWvRIVdASWXm4a0kUDiJ1N0NBCPj7f8c+o0vjlhDm9fO/MUuTZ
 kT7TBqlk=
X-Gm-Gg: ATEYQzzPlKT3FdRn0aowYSRfztozbdZTtIQ8Kmr69LYLLMPg1L0pDI80X534fLjpN5k
 nfwK+lqv/h25HEe1D5bUl0YUYNzUOO7B1nGbA4jprvDQBTcCGSPZBkfp2Vx12fFeq/ZTxIs73QK
 IFsNDp6eQET5+xknMy7BUGIAkaZtn1Ss1As2clo7wThYAv9R5pkw8ZPBlvdnlsL5gP3Oc3IJ29v
 5C8Pyba2gRoDh6rBaHXd7O+nUJkGF1FPq4GQnKXZL+RwfgCfsDMIlFouPcgDj4v0FLXt2euXZIO
 KBNm1lLOlJq7qEDAftL0uHOBpu2l1nAnFCZIzXQi8r5zbSeQQrn8bZwhC+K1eVaAfKvuqwmswdq
 KWx5pb4eBsOIno7VcAzU0xSkJA54q7Bce3rgqAtMI7RUjOEiFREi9fwEGCtsuAq94wcPF4uLtyF
 Md/Lz0X5aVTumneVt69Tel6kyjr6Fota0tp5QWTnRaKLh8pjqxpAX/tk6i5Z7Q4TwqTdG+feoc
X-Received: by 2002:a05:600c:1c25:b0:485:3e6c:aacb with SMTP id
 5b1f17b1804b1-4853e6cae44mr116714075e9.4.1773158081290; 
 Tue, 10 Mar 2026 08:54:41 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4853927825csm66749545e9.9.2026.03.10.08.54.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 10 Mar 2026 08:54:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Florian Hofhammer <florian.hofhammer@fhofhammer.de>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-ppc@nongnu.org
Subject: [PATCH v2 10/13] gdbstub: Remove GDBRegisterState::base_reg
Date: Tue, 10 Mar 2026 16:53:26 +0100
Message-ID: <20260310155329.48772-11-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310155329.48772-1-philmd@linaro.org>
References: <20260310155329.48772-1-philmd@linaro.org>
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

@base_reg is always provided by GDBFeature, which
is referenced by GDBRegisterState. Deref and remove
GDBRegisterState::base_reg field.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 gdbstub/gdbstub.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 6976f31933f..6abc8a85eb3 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -50,7 +50,6 @@
 #include "internals.h"
 
 typedef struct GDBRegisterState {
-    int base_reg;
     gdb_get_reg_cb get_reg;
     gdb_set_reg_cb set_reg;
     const GDBFeature *feature;
@@ -511,7 +510,7 @@ GArray *gdb_get_register_list(CPUState *cpu)
         for (int i = 0; i < r->feature->num_regs; i++) {
             const char *name = r->feature->regs[i];
             GDBRegDesc desc = {
-                r->base_reg + i,
+                r->feature->base_reg + i,
                 name,
                 r->feature->name
             };
@@ -524,7 +523,8 @@ GArray *gdb_get_register_list(CPUState *cpu)
 
 int gdb_read_register(CPUState *cpu, GByteArray *buf, int reg)
 {
-    GDBRegisterState *r;
+    const GDBRegisterState *r;
+    unsigned base_reg;
 
     if (reg < cpu->cc->gdb_num_core_regs) {
         return cpu->cc->gdb_read_register(cpu, buf, reg);
@@ -532,8 +532,9 @@ int gdb_read_register(CPUState *cpu, GByteArray *buf, int reg)
 
     for (guint i = 0; i < cpu->gdb_regs->len; i++) {
         r = &g_array_index(cpu->gdb_regs, GDBRegisterState, i);
-        if (r->base_reg <= reg && reg < r->base_reg + r->feature->num_regs) {
-            return r->get_reg(cpu, buf, reg - r->base_reg);
+        base_reg = r->feature->base_reg;
+        if (base_reg <= reg && reg < base_reg + r->feature->num_regs) {
+            return r->get_reg(cpu, buf, reg - base_reg);
         }
     }
     return 0;
@@ -541,7 +542,8 @@ int gdb_read_register(CPUState *cpu, GByteArray *buf, int reg)
 
 int gdb_write_register(CPUState *cpu, uint8_t *mem_buf, int reg)
 {
-    GDBRegisterState *r;
+    const GDBRegisterState *r;
+    unsigned base_reg;
 
     if (reg < cpu->cc->gdb_num_core_regs) {
         return cpu->cc->gdb_write_register(cpu, mem_buf, reg);
@@ -549,8 +551,9 @@ int gdb_write_register(CPUState *cpu, uint8_t *mem_buf, int reg)
 
     for (guint i = 0; i < cpu->gdb_regs->len; i++) {
         r =  &g_array_index(cpu->gdb_regs, GDBRegisterState, i);
-        if (r->base_reg <= reg && reg < r->base_reg + r->feature->num_regs) {
-            return r->set_reg(cpu, mem_buf, reg - r->base_reg);
+        base_reg = r->feature->base_reg;
+        if (base_reg <= reg && reg < base_reg + r->feature->num_regs) {
+            return r->set_reg(cpu, mem_buf, reg - base_reg);
         }
     }
     return 0;
@@ -561,7 +564,6 @@ static void gdb_register_feature(CPUState *cpu,
                                  const GDBFeature *feature)
 {
     GDBRegisterState s = {
-        .base_reg = feature->base_reg,
         .get_reg = get_reg,
         .set_reg = set_reg,
         .feature = feature
-- 
2.53.0


