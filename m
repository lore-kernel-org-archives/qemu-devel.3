Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6594C369D1
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 20:01:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7JRI-0001eY-BE; Tue, 22 Apr 2025 15:37:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JOu-00056b-9J
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:35:29 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JOr-00072X-Ua
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:35:23 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-22401f4d35aso62182095ad.2
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 12:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745350520; x=1745955320; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yL9Lx/EDFze6tE4WbhZDruyf3oGDShcQ9b5DcTeuWRg=;
 b=rNPYVbbLdAFkVaGOyc3yHf6RBZ8RSi4sfqTCHma6hCzws6VktvjIDKroODJesOFgUb
 Xmyj1x3KU6BflyiMWslGA2Z64RR7V6ADpQynFB4zSE0DFZ6GtZ3+MkW+1AumAbbazdWo
 MTyPjZWGeTZESegWrSgo5lzw11I7ziNVgszWSgSW+oGHGxHD/svWktIgBD+hjkYsDAzW
 T7Tx0q6z7LIxZ7F0kqsJz21KixduPZfXxwO+7TmB6BNqW7wRJ+iSC+FB+xW+AXVGWn6J
 Tb6pv44Qsua1RV1U+jweblhSacL93exrSGCuFP0oYs7/8mRRdAGil+3xfQHu+hMjz+nq
 WR0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745350520; x=1745955320;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yL9Lx/EDFze6tE4WbhZDruyf3oGDShcQ9b5DcTeuWRg=;
 b=jqXb0GgBU1oDNWNurDRc+bDWeZDw8Whc4lkBCp+vYDuxe/CFJ0qgslqhU18ebVSVee
 8L7xDJRh7ex22LhgvQZ2sQzU32FYBnS9ZYYlZygNuoyZlq3Ep6WNO8NsL4LlAPOccIuX
 XEBAcYNDljfJQ1s2yb4dQDNRP+RhL8x0HqcYfmLu+l11HtMnlaE290egq7PUGUM6YObK
 fk2UzHbU7MBf9otzA41N6c1DC9TlSOCH8Nk7GnPaPjoLjfFQZ7ps3sPDl11XoDdkSFbx
 FJ/GP7MjQRDEyb8OJBGCdlw+tmtV2M9uh9802urjRG/gCyTvDhWPEjRLDH09z5hCtlEv
 4P0A==
X-Gm-Message-State: AOJu0YzDpgn6yyRqzSFc+Rn4sNV6ubGzOon1LOSTIQnOJlqrs8VDhy/T
 DZthwVhB8wdAidiqAYoSHtt+LsH+uN7k8ovDo2rylIwfdsF0Y8tkPb4X0k8SpKbRAQ6DbYOVWp1
 +
X-Gm-Gg: ASbGncs1agMbCTmxOjCM3RuVV7sqEdphZ4N2VUXlfYAPY9SH5qCO7lHrzPK2CyKtQMD
 D5MjizQ0M/ks3SnJWbeSYjPxBYptgwpayhS+BFAWb2BpDT6DO65oQqfgJCAMwm4roa2Z+cTsq6t
 g9vPgmXINy2zjQhBm/grVtgeyj2XuIVew8JgYQMU5FDlkTz5tZHIStoYPLy5wEXMSpT8zbBMn9Q
 T29d3XpxalUUbgRJQIt14JMyEeMICfbngZdv6HgX08N7aQpPGajG7WqRg9r6RCSzs0rk+/b12BU
 V6nW68f/GH8q1sbIxWaemxawmVyVMHgwQyfh7QqB8NafrKc6u0yiMOAcAhBISCs+874jLN/m52A
 =
X-Google-Smtp-Source: AGHT+IFMYchXVttFPD9PT0HbsQ+IEg/Mk+9b0XGF+vd6tJ3e4ozKwWkUFYncfEdDUEoaMlcNjj+IjQ==
X-Received: by 2002:a17:903:250:b0:224:1ec0:8a0c with SMTP id
 d9443c01a7336-22c535acd5cmr254107075ad.29.1745350520342; 
 Tue, 22 Apr 2025 12:35:20 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50fdf1f1sm88996795ad.237.2025.04.22.12.35.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 12:35:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 091/147] target/sparc: Restrict SoftMMU mmu_index() to TCG
Date: Tue, 22 Apr 2025 12:27:20 -0700
Message-ID: <20250422192819.302784-92-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422192819.302784-1-richard.henderson@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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
Message-ID: <20250401080938.32278-21-philmd@linaro.org>
---
 target/sparc/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 57fbf16ad2..af3cec43e7 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -1005,6 +1005,7 @@ static const TCGCPUOps sparc_tcg_ops = {
     .translate_code = sparc_translate_code,
     .synchronize_from_tb = sparc_cpu_synchronize_from_tb,
     .restore_state_to_opc = sparc_restore_state_to_opc,
+    .mmu_index = sparc_cpu_mmu_index,
 
 #ifndef CONFIG_USER_ONLY
     .tlb_fill = sparc_cpu_tlb_fill,
@@ -1033,7 +1034,6 @@ static void sparc_cpu_class_init(ObjectClass *oc, void *data)
 
     cc->class_by_name = sparc_cpu_class_by_name;
     cc->parse_features = sparc_cpu_parse_features;
-    cc->mmu_index = sparc_cpu_mmu_index;
     cc->dump_state = sparc_cpu_dump_state;
 #if !defined(TARGET_SPARC64) && !defined(CONFIG_USER_ONLY)
     cc->memory_rw_debug = sparc_cpu_memory_rw_debug;
-- 
2.43.0


