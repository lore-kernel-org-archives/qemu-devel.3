Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68FA1C0218C
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2025 17:03:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbjYT-0008RR-9X; Sat, 25 Jan 2025 12:02:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbjYN-00089I-5M
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 12:02:39 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbjYL-0000Xc-Ee
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 12:02:38 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4361b0ec57aso32544395e9.0
 for <qemu-devel@nongnu.org>; Sat, 25 Jan 2025 09:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737824555; x=1738429355; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XVxLloB16KKQ3LatAF3/z7GPltBurV7JlIRTNmwrSfY=;
 b=pF6NQVrEjmJWMYhLYO/5CTEhhS9dbHjw7hdsZ/jK5GIrSLgYrm41cKcJ5oy6fDIq/g
 7txYtRYYVplilf8Z8JIAgWvPcW8SZPwKzWiaHnXCRkudxyh9XVyUcK55rAJCBjDDnM+n
 Xq8ghcnqDZAFrazWT2VAG2otGBVqA3HZaivsMKCrCV11LbCpovN0XMmejUkP8gNiSOsu
 NklL/EkobxLHdrxmF4bOPMWbQy0AZyl7BoyWHm7N4rEE4ng2w0qMMpSpY9IQItec9zOy
 YSRPn29TIuvvoaSogYaRhpEAJ+xYYhuvQ+sLEVxyFbAstg4gM3GMBm0dx4VRygC6VPHv
 n7zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737824555; x=1738429355;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XVxLloB16KKQ3LatAF3/z7GPltBurV7JlIRTNmwrSfY=;
 b=Dhq771lJs/lOncsqzgJSKz6eacEJ/OUsY6WdrL8kIcLhMMq4l0xkmTGp/2rkD+XUqC
 QMh4efo9zHZsJJWZU6Auek3blM7r5BqyYKISiOY8J3fqsz1tkgWlsknJ9vflv+3miTlt
 ckA1z94FVrK+MxsmC+GVH1HyMbYEiMqjyfcAW5Wbn3+HRKjJH6O324xRWvv59J3hA7Md
 pCgP+bW5APmWScE6uuf8GMW105iXDyxDXu3m6rR5Fx98I9bJ7wyRa1kJxBmMhSTV10VN
 k8hk87YFDjTWrxUA/PU68Xfrc50NCVUM4p3mXgFodMYcT916qszWuKcPlT7r/fsyz3+J
 shoQ==
X-Gm-Message-State: AOJu0YzyEgnUKNC0H6R1TLGVVt6HTb/5vw5gtwMw3NcKDjZtU/NIgTIe
 GWaD4QSm8vxnq02G0gE8/MYISFWVxlEnmYA1sWMfw14c1SK4ZsWdoMZcFsP8wSLHPrVdBHwPcp+
 i04k=
X-Gm-Gg: ASbGncte9nMsHqBSscGq47nUbiqvrdnqsxPUtsCohG9V9axZyYcGlLkbvioW+dGR/pX
 zR0hyrCR3khuGBubK5eXD2YCKJZ8tzjlrLjvCZnKHRRt1fBsUQTc1ln2IMKVxvm1diBL6W3EZ3Q
 ODybMb4WunCXbVTZXfU+J9PUZsKULnYqOfrh4UPPByxO6c0wdlhJPL1x5GmRFCuSzaitA2iZRFi
 IbkyJT8sptNKmI9+363allI3uqa1n9jlk+JqkfSQ5QL8k+iz9URlxc7kDhCvf/9Usl83/nH+XrG
 WuUrVqSrBNp15w5z8pldTTmiYYpESZiJDd+4IWCGw3wrdIDie4a1vs0=
X-Google-Smtp-Source: AGHT+IFHv9P+hZykbbF3UVucvoWmc7m5hFjlui6LVmFOyARfCuo1p4Bc3l3SVA0TfrHfkFB8AKEurA==
X-Received: by 2002:a05:600c:468e:b0:436:5165:f1ec with SMTP id
 5b1f17b1804b1-4389143145bmr337588915e9.30.1737824555606; 
 Sat, 25 Jan 2025 09:02:35 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd47f120sm68574425e9.2.2025.01.25.09.02.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 25 Jan 2025 09:02:34 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 14/24] target/openrisc: Move has_work() from CPUClass to
 SysemuCPUOps
Date: Sat, 25 Jan 2025 18:01:15 +0100
Message-ID: <20250125170125.32855-15-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250125170125.32855-1-philmd@linaro.org>
References: <20250125170125.32855-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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
 target/openrisc/cpu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
index b7bab0d7abf..5d80c4aa9ac 100644
--- a/target/openrisc/cpu.c
+++ b/target/openrisc/cpu.c
@@ -63,11 +63,13 @@ static void openrisc_restore_state_to_opc(CPUState *cs,
     }
 }
 
+#ifndef CONFIG_USER_ONLY
 static bool openrisc_cpu_has_work(CPUState *cs)
 {
     return cs->interrupt_request & (CPU_INTERRUPT_HARD |
                                     CPU_INTERRUPT_TIMER);
 }
+#endif /* !CONFIG_USER_ONLY */
 
 static int openrisc_cpu_mmu_index(CPUState *cs, bool ifetch)
 {
@@ -228,6 +230,7 @@ static void openrisc_any_initfn(Object *obj)
 #include "hw/core/sysemu-cpu-ops.h"
 
 static const struct SysemuCPUOps openrisc_sysemu_ops = {
+    .has_work = openrisc_cpu_has_work,
     .get_phys_page_debug = openrisc_cpu_get_phys_page_debug,
 };
 #endif
@@ -261,7 +264,6 @@ static void openrisc_cpu_class_init(ObjectClass *oc, void *data)
                                        &occ->parent_phases);
 
     cc->class_by_name = openrisc_cpu_class_by_name;
-    cc->has_work = openrisc_cpu_has_work;
     cc->mmu_index = openrisc_cpu_mmu_index;
     cc->dump_state = openrisc_cpu_dump_state;
     cc->set_pc = openrisc_cpu_set_pc;
-- 
2.47.1


