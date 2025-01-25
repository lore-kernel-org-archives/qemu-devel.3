Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11740C0218C
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2025 16:10:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbiiZ-00072O-ML; Sat, 25 Jan 2025 11:09:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbihA-0005SD-T7
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 11:07:49 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbih9-0000pz-8U
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 11:07:40 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4362f61757fso32018825e9.2
 for <qemu-devel@nongnu.org>; Sat, 25 Jan 2025 08:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737821257; x=1738426057; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wNzeIykutuJ1S2XsFr1DnQpgi/RVEgAeGStb8yeCtY8=;
 b=eHF14ornHs2nMOinBWJFnNjxCMfPJCFlUC3OK5+Tsj9m+AQv2JgcXsQeTKweJDj8oU
 rjCu5AszUoV9Y6Hymc6WwnuIYpK5EgVPLTnjF8D9PvOvZaBv7G0dX2C0Xn0PIv2uORrI
 o/hYL6EEUVDlKNfPt2MHebDrzLjj7qbQy3yEHdM8qAUp8w1sikjijB43u4M6eq9em8Cr
 dclIwXP8c3CXRTbKPP7DqU+vFcE2zJthyp2dlRInUa7NMMFVtdNVyoXS/xtJRJ/VjMss
 yabBhlhu6o4XmPCqcW+VGexgZSlEhsLbDghw62WsVFowpchFT1S4aNQo4qmvhqkFoJ1c
 /iXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737821257; x=1738426057;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wNzeIykutuJ1S2XsFr1DnQpgi/RVEgAeGStb8yeCtY8=;
 b=nendCJTbhyp4TdD2yT6qr+Q0xHS8bTuY9Vbf/KzxmOkF6F6LCeDiHGA1c1DgGrQ/2r
 BJyeKPg5+ycmMoRm5wuHFwh+WSkxKBZdHWrFfPDGBBxSSC+d16Kj6R5IX8zfBEl0lz/0
 tJ/1NczQTK+FrR5Zg4GTZMc70ggXTZiGTeZsaf9TZIeRFYBzSJhCQne4TtBhrEiVl17M
 insgdz7ouNVWLnbdivTY5UJ8/FrllQq9NzwzZT622h4XOmhbMKg+8PEiKzJzmYz35fpw
 FD3I1fXpbw9x3jY0EsVZPHrhbEMXp/g9Z/9VOMdVUgT9B0GHcLzZbsJNH+ZNcCKWCHNX
 I7ag==
X-Gm-Message-State: AOJu0YxGWCYAM92fwN+RmJdbfxRFKGIP4U1mv0mwANIHg6f3X/xzFyjP
 i8DbxZhBxCVRVfc0vNUCJvWsOveCZalUk/Qq+3MxUZxGhb4IEld0JQoL8S+IZyb4TMo9NrlTDUh
 +rDM=
X-Gm-Gg: ASbGncuqQ3p1Jdkf7OfUltCq4kALTiFosbg/yC+hB05KK/MmMPMokS25XIjSGLovNQJ
 oU3y5Loa5k3u2E7YIk/qZL8/usLRur1E1ichlOWNifOzTg+io2rlGQ9ddUbpeQO3g83+4HZ8qMi
 jRspWsZTowiKlXCiQ83g6ReCSIE4g4lsAkldyNJyO3TA+dT7EcSejIqjLz8cAfIgYiAC/iKswn5
 hTuYb/DWllpypk3BFeDt/Sz/eQD1djAgxfmGQrPtNmlzoNmwME1II4Gm3bMEIkkl7dAM9qs0765
 PkvvjyPhC4utiNbvjrPH8yMP/4NOoJeR/QtbLn5bLwFZsXYOMVGUS3nItwhF
X-Google-Smtp-Source: AGHT+IFU2gyeJX3+XVjXok1Ck2wPdw2IeWdIPDp36nxxSUxe+irMyg6OxfHmN/7/P/I6fUsBWoo+Aw==
X-Received: by 2002:a05:600c:4713:b0:436:9227:915 with SMTP id
 5b1f17b1804b1-438913caa3cmr273402185e9.9.1737821257390; 
 Sat, 25 Jan 2025 08:07:37 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd4d3dbcsm66717135e9.40.2025.01.25.08.07.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 25 Jan 2025 08:07:36 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 21/24] target/sparc: Move has_work() from CPUClass to
 SysemuCPUOps
Date: Sat, 25 Jan 2025 17:05:49 +0100
Message-ID: <20250125160552.20546-22-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250125160552.20546-1-philmd@linaro.org>
References: <20250125160552.20546-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/cpu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index fbd38ec334a..94e807f9f84 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -776,11 +776,13 @@ static void sparc_restore_state_to_opc(CPUState *cs,
     }
 }
 
+#ifndef CONFIG_USER_ONLY
 static bool sparc_cpu_has_work(CPUState *cs)
 {
     return (cs->interrupt_request & CPU_INTERRUPT_HARD) &&
            cpu_interrupts_enabled(cpu_env(cs));
 }
+#endif /* !CONFIG_USER_ONLY */
 
 static int sparc_cpu_mmu_index(CPUState *cs, bool ifetch)
 {
@@ -986,6 +988,7 @@ static const Property sparc_cpu_properties[] = {
 #include "hw/core/sysemu-cpu-ops.h"
 
 static const struct SysemuCPUOps sparc_sysemu_ops = {
+    .has_work = sparc_cpu_has_work,
     .get_phys_page_debug = sparc_cpu_get_phys_page_debug,
     .legacy_vmsd = &vmstate_sparc_cpu,
 };
@@ -1027,7 +1030,6 @@ static void sparc_cpu_class_init(ObjectClass *oc, void *data)
 
     cc->class_by_name = sparc_cpu_class_by_name;
     cc->parse_features = sparc_cpu_parse_features;
-    cc->has_work = sparc_cpu_has_work;
     cc->mmu_index = sparc_cpu_mmu_index;
     cc->dump_state = sparc_cpu_dump_state;
 #if !defined(TARGET_SPARC64) && !defined(CONFIG_USER_ONLY)
-- 
2.47.1


