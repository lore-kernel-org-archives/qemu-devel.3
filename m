Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E490AC369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 19:40:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7JPY-0006Yt-Fg; Tue, 22 Apr 2025 15:36:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JLq-000141-Ji
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:32:16 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JLm-0006fe-GE
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:32:14 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2240b4de12bso83068005ad.2
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 12:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745350329; x=1745955129; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oVGDH0zXbPh1XWGLwpF7fHPSsEZ5O5FckAiSLdeKleA=;
 b=Bpw64rgvPRezYGxH1wl9lRU97a6jvt59BdYXwJGyPIU8ZVSEgxR5XW3tFRFT88m0HD
 DTIJYw/1R8xerUeeuoBUeWZzrOrsgSp34izyZKrh7x90JvCuPGCAgp+3I2OUhT5nBXLf
 TSxBZ/qtpGD2N1PlOdFJ9eh/97t93kmmofLm+se0v6HW/y4bUU7AfS/KTQqdNqzzIjrP
 V80phF0g1N56/XHkvHsr+gBUYQv937YhjOWAmSTEn+HVP1f9zSExRIVrPD5wxNcOaXh3
 syrQUtg4N/tB9Vc3sFc6IrhZoWWwc/A6r+Jq8F1p45DxavW3rC+8lmAbDvP1GLYRl3Ek
 E9zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745350329; x=1745955129;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oVGDH0zXbPh1XWGLwpF7fHPSsEZ5O5FckAiSLdeKleA=;
 b=A6lHsBm4UtYoXXpPbHR34cLwNwYn4Rsw/CqbxLP8U9v8QUo2IN66+h2UNegzMdtb+w
 nhv8yPYeRbiUxzdKCWTdOyZQry6ZexYF2UR3XqVUKxrg/ehTOjz+gP83egPmDIDLAeXM
 HvGGDJdGnrFiR6q98SGM9DZCTMBMremDceBGVOgrUUbRq+nH752goV0HJSzs4wUwkxXD
 s9qJgFSs6SCj7U1lUhxxoX5g8n9q+sJihUzpTksSs3/8Ffb1j9p3W59Gi0JOAjw6xhOO
 kBZPPeRsBw+9TiLJNJsHZk737y80CIKzDMsWWO0EhKYjiPUhWDKGUFlQD+HwPF9jyeuq
 eA5g==
X-Gm-Message-State: AOJu0YwpzguTBa1qO5g9JHoxEcImDZV8n0JyjRqReTXc8BkBPDP7Viej
 mz6PRfKtAKG+BLPnW0u4IZMv86qA/rW2iB6RgeY25dsR42F1QseRpHZ3bUcGu3S3A+ppdoxL7A/
 k
X-Gm-Gg: ASbGnctbZfNuFHBFuCx5xOnAJDX+VaRfXjI+Itz8q3kHHvnTMrces8gqW0sZPZmDeDP
 HQQod7QaV2TogfpBfhg/3UHgQwau5zQJvZFZz15J1r1JgFMiA6EBH0ek21DBNPJXpKlxBjCji6y
 vLPAWdegbwdLEVwb7uSEN+u9t8TtR/RNYIbl7IsDiJkkXTEKAANNXPsWBuZNDAGsJQe2XK/zp+l
 zadjyisB0NAD7yVCUJplTusmk3E+JC34jQNi2pnS2H3FecFBZ1OhyUWdO6ofJGtudGbouFmT30D
 HguLwB86D4SmVmJrftqUgItdY+nRsFVjTzUy3LADabLOEvYuEY9jKyIwUmPj4CN3sDzqc9B+90k
 =
X-Google-Smtp-Source: AGHT+IGFpRX2SrUZPSft2Kfrmg72K7RJLm2oWJhskhHIG58rF9PLFcR/R6ZV7eLjrGT+zkAfpHSFEQ==
X-Received: by 2002:a17:903:3c6f:b0:21f:564:80a4 with SMTP id
 d9443c01a7336-22c536053d2mr226517035ad.33.1745350329184; 
 Tue, 22 Apr 2025 12:32:09 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50bdda3bsm89312635ad.27.2025.04.22.12.32.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 12:32:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 074/147] target/alpha: Restrict SoftMMU mmu_index() to TCG
Date: Tue, 22 Apr 2025 12:27:03 -0700
Message-ID: <20250422192819.302784-75-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422192819.302784-1-richard.henderson@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250401080938.32278-4-philmd@linaro.org>
---
 target/alpha/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
index 584c2aa76b..56c96b1c4d 100644
--- a/target/alpha/cpu.c
+++ b/target/alpha/cpu.c
@@ -238,6 +238,7 @@ static const TCGCPUOps alpha_tcg_ops = {
     .translate_code = alpha_translate_code,
     .synchronize_from_tb = alpha_cpu_synchronize_from_tb,
     .restore_state_to_opc = alpha_restore_state_to_opc,
+    .mmu_index = alpha_cpu_mmu_index,
 
 #ifdef CONFIG_USER_ONLY
     .record_sigsegv = alpha_cpu_record_sigsegv,
@@ -262,7 +263,6 @@ static void alpha_cpu_class_init(ObjectClass *oc, void *data)
                                     &acc->parent_realize);
 
     cc->class_by_name = alpha_cpu_class_by_name;
-    cc->mmu_index = alpha_cpu_mmu_index;
     cc->dump_state = alpha_cpu_dump_state;
     cc->set_pc = alpha_cpu_set_pc;
     cc->get_pc = alpha_cpu_get_pc;
-- 
2.43.0


