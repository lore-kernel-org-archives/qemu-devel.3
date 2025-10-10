Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BB6ACCA476
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 13:26:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7Cqa-0007WM-Rs; Fri, 10 Oct 2025 09:07:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7CqT-0007NI-4H
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:07:41 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7CpU-00040f-9q
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:07:39 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3fa528f127fso1526853f8f.1
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 06:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760101593; x=1760706393; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LDlat83cBbQCFEDv1JneA5+7VZZAldZZfXJ7NWv4Wp4=;
 b=M9nfbAS6Rn2t/ZkGEIS418oOgNIFdFnZ0ez7z7rw8eRzlnKapJ47qr+zI+xMgnRyMb
 nNQx7941fha5XTuXIt1U5kwG2nQChrxTIe27mY/6j1XnaotHxcGEAmsscudzIqnxpaTT
 l5VKOJ02F+O5a4rPrN4KAY7z8tcjiD83dbm8OuE+q6x6vxC+zp0T7PWFp94ZBWCMjThN
 B9Mo/y7RUUlzQiZLMhalX5S+ptoAAHeV9YleT4oX9WRDnBlD4y6ehu4wHLDMMgPbRR/m
 BmE8Cmwti+URbEAQnz8bf+qVK6d/h4uLvG2HfgFjgsfQcGup40K7wC1jVkwsBcMhrYP2
 Y6Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760101593; x=1760706393;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LDlat83cBbQCFEDv1JneA5+7VZZAldZZfXJ7NWv4Wp4=;
 b=b4IFF4vQPzbstj+duPeDxCvNMQvFc0z7q23mJ4va4TJQLfW+UegGwiNlwMz1O6lFMK
 UKOdcWVFeRzwVepXobkTyNqGZ2goIbOrZ9dS5WVb5k8fHeiz7fxzE20g53QOmz+oPHMG
 /MAmih6m+pOjV44/QS2ue1yzYef7cPr1TmiqBZ6T0LA73tYHPDERVBJr6coM34dYfQ4Z
 pCPaqNUVXuQibG6ZtR8iB+Ok3Rzk+4c98AG4kVEwsEs2tyT1iJk2vVuE6j4mCq+7TKO/
 1itHxr3GxTc/vXEBgFVnLw1nmfTILDwagpNAfex6ZKSpJrVU0wkd/OwJrhCupoqTVz/e
 CUZg==
X-Gm-Message-State: AOJu0YzuWsfsrby+Ow121UdbWL52VMlCCGO0ZgRl6SOS9Cra3lpj9/Di
 s/Q0EcQYVykdx9Dg1YIMFoI5v7HKOeOhytmCkaLIuEcuCv5YsWg76VbO2u8fU6PCc69/DMcfNIV
 0xSAr
X-Gm-Gg: ASbGncuAOOZ8YMcbCVC5gyLqo6WI6Dt0YKqwBX/WmE2lmyQenIv6LAGu9pBrdpqSzPD
 DAbGy+yc0NsvefxU5YPglYc/QN2yfeDo2T9eNTBc+Lf/0lwsMaBe/q0pjtlVtQMf1tC/Br/XD+l
 o2jtoTrNcMzHHK7GX+XZPMa25WAupkWGSjJjgOqYkAAoYwQGREe7TDG31+hVYvbYbXAUBupFSe6
 fd+SjVWz6HSW4gDWZR9SAMBL9NEHs3s+9yByakc3w3hHhDYBxNRHCgqI75RANYROGXePF8E50V1
 wLWjgWZF6a67W5Kn7Gk0EIsc6tyF+lKTo17RIxR+CUGu+v2uLHo8+HhZFLMFcgyrSaUhgpzTtLF
 TARMSdmAWAo53+b+tC/BQak0rWE/8Nkt9QHN4p0U5+pLxzznKYPxfXWrNXtkOVA==
X-Google-Smtp-Source: AGHT+IGorCukm1vBd1Hun7JWdIeF83Dldvg7fAt1Rox22ISzMzI+QoOKwRXBwmM40cN+uJrKZBgG9A==
X-Received: by 2002:a05:6000:2483:b0:425:70cb:9ba8 with SMTP id
 ffacd0b85a97d-42666a9f3aemr7755094f8f.1.1760101593338; 
 Fri, 10 Oct 2025 06:06:33 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce583316sm4221657f8f.20.2025.10.10.06.06.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 06:06:32 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 57/76] target/arm: Add gcs record for BLR with PAuth
Date: Fri, 10 Oct 2025 14:05:08 +0100
Message-ID: <20251010130527.3921602-58-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251010130527.3921602-1-peter.maydell@linaro.org>
References: <20251010130527.3921602-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20251008215613.300150-58-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate-a64.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index fcfa4223f5c..9c3de0cf717 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -1842,21 +1842,21 @@ static bool trans_BRAZ(DisasContext *s, arg_braz *a)
 
 static bool trans_BLRAZ(DisasContext *s, arg_braz *a)
 {
-    TCGv_i64 dst, lr;
+    TCGv_i64 dst, link;
 
     if (!dc_isar_feature(aa64_pauth, s)) {
         return false;
     }
-
     dst = auth_branch_target(s, cpu_reg(s, a->rn), tcg_constant_i64(0), !a->m);
-    lr = cpu_reg(s, 30);
-    if (dst == lr) {
-        TCGv_i64 tmp = tcg_temp_new_i64();
-        tcg_gen_mov_i64(tmp, dst);
-        dst = tmp;
+
+    link = tcg_temp_new_i64();
+    gen_pc_plus_diff(s, link, 4);
+    if (s->gcs_en) {
+        gen_add_gcs_record(s, link);
     }
-    gen_pc_plus_diff(s, lr, curr_insn_len(s));
     gen_a64_set_pc(s, dst);
+    tcg_gen_mov_i64(cpu_reg(s, 30), link);
+
     set_btype_for_blr(s);
     s->base.is_jmp = DISAS_JUMP;
     return true;
@@ -1892,20 +1892,21 @@ static bool trans_BRA(DisasContext *s, arg_bra *a)
 
 static bool trans_BLRA(DisasContext *s, arg_bra *a)
 {
-    TCGv_i64 dst, lr;
+    TCGv_i64 dst, link;
 
     if (!dc_isar_feature(aa64_pauth, s)) {
         return false;
     }
     dst = auth_branch_target(s, cpu_reg(s, a->rn), cpu_reg_sp(s, a->rm), !a->m);
-    lr = cpu_reg(s, 30);
-    if (dst == lr) {
-        TCGv_i64 tmp = tcg_temp_new_i64();
-        tcg_gen_mov_i64(tmp, dst);
-        dst = tmp;
+
+    link = tcg_temp_new_i64();
+    gen_pc_plus_diff(s, link, 4);
+    if (s->gcs_en) {
+        gen_add_gcs_record(s, link);
     }
-    gen_pc_plus_diff(s, lr, curr_insn_len(s));
     gen_a64_set_pc(s, dst);
+    tcg_gen_mov_i64(cpu_reg(s, 30), link);
+
     set_btype_for_blr(s);
     s->base.is_jmp = DISAS_JUMP;
     return true;
-- 
2.43.0


