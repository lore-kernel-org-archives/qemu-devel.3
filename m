Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF568C0218E
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2025 16:09:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbiiG-0006PS-UV; Sat, 25 Jan 2025 11:08:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbihH-0005Vi-3n
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 11:07:55 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbihF-0000qU-Kt
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 11:07:46 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-438a3216fc2so31513255e9.1
 for <qemu-devel@nongnu.org>; Sat, 25 Jan 2025 08:07:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737821263; x=1738426063; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UZ8BDmUkV3T9ZQW07wpYEtUOuZG1AGKnmguq5EirG8g=;
 b=ga76srhZr+ZA4p5oAwwhLPBX0FpM9x/evZVdMKDHPokyniX5knFStBoUT8NvJADeWm
 hPJxhQ5DvExpTUSxUmN19omzyTQ2lbFnEVTP552KrLNQThtQ5w7Ga1bZlOfdb06kjq7I
 pCDOZnxV9CkFRi88JlSFqqgI/Z3k7Q5+hN5R/8SuvOVtJMIiFkzERya7I4igoPsaO5D2
 wsh7ZcOxlCLqbs+rrQAcbV3W/pXf1TMAVoV1AqxLEH4m7FD0HSG0C+sFOPI3v5otLfgs
 K0VzV+ZZ+GbIqC9GwwnKb+//qoVh1yuzjTxLmQdWoYhx22OF7uZvv3kR0EovfDyI3qPX
 iopg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737821263; x=1738426063;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UZ8BDmUkV3T9ZQW07wpYEtUOuZG1AGKnmguq5EirG8g=;
 b=dv2nw883st5Oo0+lamLhfbk6Tcxgy5JSffu4RI8+3bvE+q76OMeJ8VAcnPlsK9NubR
 Qo7mSufT++nIY7AaY4ohghPq2gZpjn7FuUW+UskWm8Z/QwDfs4HDOfUJlJBaH7Nh0WSU
 Uh5pvFni123G5gVZUNA4H1Pb/OjdFijmWYofetk9rLNLi2yKdWOZrpcfMSsISiAUJOj9
 HFmvassVFc9D8EBlB1outf/cPu2+irUG+s5VBissoE3DywoIUdBK4LV4kW2Ad/MtyWgA
 8gCwOwo+JnFSn6JjqsMPGu6oUERNkxDDqPf/Or2lMVQaYuD8M3+lp/38YKGtsCEA+/b4
 qwwQ==
X-Gm-Message-State: AOJu0YwCmpnZhnTEHUKhSqE0uOigoscsgsqQGR0YOpGv5VQE0scuGIWU
 7eXGOfXL/+92Q7Igw3T4SyqoBIZd+3uFim28/8lwPwauvhTWoe/K2OgvH3q28cFR/EoZsXyDKBB
 7lOk=
X-Gm-Gg: ASbGncsDHHqcMwqXz0szMcpLXQUHKQcGOKm89EJNNXBIG1lArgfWgj20fMWG8NNTiqf
 5XlJX7XmC8W0TIsbSWADjwxcW5dhHjjmhIF8GqoaFlvkrln7iOYXS8uxmuh62xvRfV/EUH+ATq0
 uxQXdc20s/5ogzEB2UkOKzDONJMT1WBO+EF/GmBCv0PulcfibNwLndLtK4huqTWrbW6wr8BC9tQ
 QuY65aRuyUrwH50bT54/yCTVtIB0vsSnwRpcUFyCob3/UfVgb70cazTkDK2bT08ETybIPWJKPwH
 1e0DzMD0yWT29ys67rSwa12GjeIw/kYZXFzsrscpPsXIRQPlLjk7Fvm/HG5O
X-Google-Smtp-Source: AGHT+IEXbVNtLiwLB6adkaJqninsCyPgOA8BDY4qudZlTLdvfKz70mVYvP4AdUrqu2ZLcXxpJKjkXA==
X-Received: by 2002:a05:600c:350b:b0:431:58cd:b259 with SMTP id
 5b1f17b1804b1-438914671fdmr358035835e9.31.1737821262753; 
 Sat, 25 Jan 2025 08:07:42 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd485695sm65140295e9.14.2025.01.25.08.07.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 25 Jan 2025 08:07:41 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 22/24] target/tricore: Move has_work() from CPUClass to
 SysemuCPUOps
Date: Sat, 25 Jan 2025 17:05:50 +0100
Message-ID: <20250125160552.20546-23-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250125160552.20546-1-philmd@linaro.org>
References: <20250125160552.20546-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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
 target/tricore/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/tricore/cpu.c b/target/tricore/cpu.c
index 95202fadbfd..e4f95876efd 100644
--- a/target/tricore/cpu.c
+++ b/target/tricore/cpu.c
@@ -165,6 +165,7 @@ static bool tricore_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 #include "hw/core/sysemu-cpu-ops.h"
 
 static const struct SysemuCPUOps tricore_sysemu_ops = {
+    .has_work = tricore_cpu_has_work,
     .get_phys_page_debug = tricore_cpu_get_phys_page_debug,
 };
 
@@ -193,7 +194,6 @@ static void tricore_cpu_class_init(ObjectClass *c, void *data)
     resettable_class_set_parent_phases(rc, NULL, tricore_cpu_reset_hold, NULL,
                                        &mcc->parent_phases);
     cc->class_by_name = tricore_cpu_class_by_name;
-    cc->has_work = tricore_cpu_has_work;
     cc->mmu_index = tricore_cpu_mmu_index;
 
     cc->gdb_read_register = tricore_cpu_gdb_read_register;
-- 
2.47.1


