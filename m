Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77980C3ABAC
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 01:56:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBl0X-0003ph-Uj; Sun, 04 May 2025 21:52:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBl0X-0003pC-4c
 for qemu-devel@nongnu.org; Sun, 04 May 2025 21:52:37 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBl0P-0002TU-5S
 for qemu-devel@nongnu.org; Sun, 04 May 2025 21:52:36 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-736aaeed234so3388599b3a.0
 for <qemu-devel@nongnu.org>; Sun, 04 May 2025 18:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746409948; x=1747014748; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v1JmSJqnxYquNU/v4UOEtwOcqbxnEb6aDiKyyBWqJ6s=;
 b=PvV61gttBEt9KLNkVapC7/cLVo62EqS7t0Q4TH86BH02CeFTMYn+wH9Qe8PZ+OHTj8
 L3R5hQ/ptb2/0i8lCt2nYBRmGj9z1U4xFtQZO/Bet5mF39i8fpTXPAfN7nA7UuubPcYt
 kPHg1ti09cMJ/npjsyazHQTEfqWqFL3UsTcXnbx54Yi9klcvsKU9vnNvx9yoNxxzFmwH
 L+fTQo6koMLnnfzuBf1NsqAAvlY9EjzT3ZzQR35Ik8qTRHq96359eFMbJkNcFXlZ2AZb
 LYSwu3ID7QsVlSNmHA9Tz3QWjcssbeB7VUJNYvVwGpsAVr5NRO0tG9PtVl/obos8Ppaa
 TWzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746409948; x=1747014748;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v1JmSJqnxYquNU/v4UOEtwOcqbxnEb6aDiKyyBWqJ6s=;
 b=gr6juMZYB81JY2bfUMkLYClgpWRMPaHWc95JbxZdeEPg7wzJDr0vfWSdhys8RHQ59f
 ZB66/4kOVq7gZNvvnnKolXavQCNaYIpe7CWcellVhx3Nvk0vuPrY86CBqelFaKkckkz7
 4nXffi3WqWTJC3tO/w8e+VUrbyGLc/D0R5G8qfwfg8E4tdhMV2QzNrYknL7MdYLfaIhM
 /gPABsKvzhLdObEqCtnZfyeCaHY5xne7e9GXJSTA7BqAE1XjZLdQ3OmlZ1mG6cwozoNh
 y+KEAo6vuIfvDr7b8oAHRrW8LPpiXw1nGGNMIIwOz8Ax0LWg+fIDeBf4fIY2s62lYvoT
 RY8Q==
X-Gm-Message-State: AOJu0YxfV1bbz+JoyEXYSqIAW2az5IlNvSNNzeBsfUmbTs7PYsmaYaqf
 L1PgVGUxYq8Nr4wO+uneI5PLW7LyehRUPAnTKEcYC4YVbm2K33K7+gKxkU3zsDbWCc2Pug/e5nT
 C+3M=
X-Gm-Gg: ASbGnctXVdnRTayWkyGo3wWfzam1s1pfDNyg3lGMKJgp0w43piSn2W1dYQcLTsPqI4b
 GG6uA7duO5hb8Kqg5qSu4SmndFbM8dveCf+XPibV6rN1XIrKE36bQZmhFRsd7G/NJJt2Jl/U+vR
 FEURtQ3l1Ok9HR8PlI0kMfJJOnkHfbGF3RU+y5286IXTfFSzx5dX4vJd6vhWeOGb9WfUR0/sozo
 RteVCoB1rKxdJDCBg6UzShcFuqFjERQ2BtiaTj228TvktMjbjxiiPHkfkUuLplHLmxuruKzez/u
 xNNkgH/sZDQ2V5YkEVys15/6XjWUzwp3QlLGAAlC
X-Google-Smtp-Source: AGHT+IEDP5xBT51rFDO+YlfBvJJOZbgRutYKb7K1dO6mttF7lFJCwcmKCu2Cndsi3ubcw0yBzewrTg==
X-Received: by 2002:a05:6a21:8dca:b0:1fb:e271:82e2 with SMTP id
 adf61e73a8af0-20e96605502mr7410585637.11.1746409947932; 
 Sun, 04 May 2025 18:52:27 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b1fb3920074sm4462101a12.11.2025.05.04.18.52.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 May 2025 18:52:27 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org, kvm@vger.kernel.org,
 Peter Maydell <peter.maydell@linaro.org>, anjo@rev.ng,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v5 01/48] target/arm: Replace target_ulong -> uint64_t for
 HWBreakpoint
Date: Sun,  4 May 2025 18:51:36 -0700
Message-ID: <20250505015223.3895275-2-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250505015223.3895275-1-pierrick.bouvier@linaro.org>
References: <20250505015223.3895275-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x434.google.com
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

CPUARMState::pc is of type uint64_t.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/internals.h   | 6 +++---
 target/arm/hyp_gdbstub.c | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 4d3d84ffebd..c30689c9fcd 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1949,9 +1949,9 @@ extern GArray *hw_breakpoints, *hw_watchpoints;
 #define get_hw_bp(i)    (&g_array_index(hw_breakpoints, HWBreakpoint, i))
 #define get_hw_wp(i)    (&g_array_index(hw_watchpoints, HWWatchpoint, i))
 
-bool find_hw_breakpoint(CPUState *cpu, target_ulong pc);
-int insert_hw_breakpoint(target_ulong pc);
-int delete_hw_breakpoint(target_ulong pc);
+bool find_hw_breakpoint(CPUState *cpu, uint64_t pc);
+int insert_hw_breakpoint(uint64_t pc);
+int delete_hw_breakpoint(uint64_t pc);
 
 bool check_watchpoint_in_range(int i, vaddr addr);
 CPUWatchpoint *find_hw_watchpoint(CPUState *cpu, vaddr addr);
diff --git a/target/arm/hyp_gdbstub.c b/target/arm/hyp_gdbstub.c
index 0512d67f8cf..4d8fd933868 100644
--- a/target/arm/hyp_gdbstub.c
+++ b/target/arm/hyp_gdbstub.c
@@ -54,7 +54,7 @@ GArray *hw_breakpoints, *hw_watchpoints;
  * here so future PC comparisons will work properly.
  */
 
-int insert_hw_breakpoint(target_ulong addr)
+int insert_hw_breakpoint(uint64_t addr)
 {
     HWBreakpoint brk = {
         .bcr = 0x1,                             /* BCR E=1, enable */
@@ -80,7 +80,7 @@ int insert_hw_breakpoint(target_ulong addr)
  * Delete a breakpoint and shuffle any above down
  */
 
-int delete_hw_breakpoint(target_ulong pc)
+int delete_hw_breakpoint(uint64_t pc)
 {
     int i;
     for (i = 0; i < hw_breakpoints->len; i++) {
@@ -226,7 +226,7 @@ int delete_hw_watchpoint(vaddr addr, vaddr len, int type)
     return -ENOENT;
 }
 
-bool find_hw_breakpoint(CPUState *cpu, target_ulong pc)
+bool find_hw_breakpoint(CPUState *cpu, uint64_t pc)
 {
     int i;
 
-- 
2.47.2


