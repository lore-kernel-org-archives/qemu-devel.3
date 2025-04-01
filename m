Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AA80C3601A
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 08:12:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzWhf-0006pc-6w; Tue, 01 Apr 2025 04:10:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzWhc-0006pB-DO
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 04:10:32 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzWha-0005xV-RD
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 04:10:32 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43ce71582e9so36783475e9.1
 for <qemu-devel@nongnu.org>; Tue, 01 Apr 2025 01:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743495028; x=1744099828; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=43B0Gf644+rG+IGa27fovHaCeNyeLOk+U3XMHWBUZE8=;
 b=Z1+4tlwXWsIQNt8rP8o4Vw7zGsA79IUvZBX2e/vMyQUY/BtX99TOZ5/MmgH61PZtud
 nK8qXCqH484yHicBw7kZniFl7ei0BIM86o5lCo0wNg/9BgbnEuW6auWSAZv02gYw3rEo
 LHNIqMDgwDYqkC+uUHRwlzld/ZGOZqYT8X1fKaa8HvMXTsvKDJX/LcL+f630UVaufifi
 6CxFtl0qZcXyqI7vqb8MhQqYBWSCOxuazQWkZ/cseY9tOMj90n3nE0TYp2zzkFq69x4B
 TxEFyXq/SqE9kiFJo71AoBrn7AOrYvxgoQxcIetY8X91v/cWgXmKZ1jf0T9IhacHMZuW
 +dIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743495028; x=1744099828;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=43B0Gf644+rG+IGa27fovHaCeNyeLOk+U3XMHWBUZE8=;
 b=i1ApNtmxyTkTKdtDhvIkH8Msqcy7Lf0XPSvjw1WJUxY/0+VuhjVulfAT86HfzN6pcz
 dt3IWW/gwGdhIh0caRiOm+F6UjuBSadilOrvDmFu6QXbPE8Hv9Os69wnen9haNjedBvW
 logcr0G2ev+pNFH/+htmHARsb0KsDvs0xttaG+n3xSJtefeQ2UB8dfnBMLkNkBCMPMMX
 gXWIIgx1OCyzYmdkThzRlX/VAegJN+y86dA7VSmzdSBJKMuttJuFWgfqqmZ+uxsKEmmL
 BDB6W2CzUFqCguIBZZvYeOP7QdwNH2vLIjzH1fNh4gbFC4vqqVOA5aRpa5kx701HAUhO
 9AlA==
X-Gm-Message-State: AOJu0Yz7JvBT7D08YtDLJfr5j6nRS+O0rxQAc2rKpx6Su0RIMumMQZx2
 iKoIwQY3lbQW4oIM6t+bM97dzaSkTshr6Y5kl/Tk5hH7b4CHp3BNENagzo4mIBwudCFMcUZ4/z4
 y
X-Gm-Gg: ASbGnctlTT5vvBeVyCk+XtGzlrzK2Xxn7u6T4cpSNHmNRqCE5003ezLpQqkNtzB3teX
 ZyxUtiUDL3sfauRwk7kSyg7L+wO14PFCox0arPZaNeeAYA9jwYe91ZjV5oezat13C6mMMPJVdOK
 Gt2nTUkGHP1n7FqGxbs0MFOktly/Y54ZXu6mIQJQxJ0gqm+artFK+WaAx9fuFmY0eQoIdWzf6vA
 GFX/l7UyG1kBKpQuOZReOUJHO9rgvFD8+a+Q+S0DtLzg+0e3qdHdypUTDbTmeTD3r81m6gLVZWC
 ZWmtpccj7i/hsEZeOk7FFqzm7+ox0Ke0Bj+CQViU6bku5yhwXZ0/cjWXE3FD47bdmRYhA3CRuYr
 Tq6iUA95C7QvLbdBF70e4z05XLDl3PA==
X-Google-Smtp-Source: AGHT+IEAFhUXmqsyQzjClzPJrjWjGluzcFwpucTOLU/1Sl/qV6LIJUrqa152ipVuVxr4ZWm/5BXR9Q==
X-Received: by 2002:a05:600c:1d9b:b0:439:86fb:7340 with SMTP id
 5b1f17b1804b1-43e9dea091amr58365525e9.30.1743495028386; 
 Tue, 01 Apr 2025 01:10:28 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d8fcd774bsm147813735e9.23.2025.04.01.01.10.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 01 Apr 2025 01:10:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 10/24] target/loongarch: Restrict SoftMMU mmu_index()
 to TCG
Date: Tue,  1 Apr 2025 10:09:23 +0200
Message-ID: <20250401080938.32278-11-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250401080938.32278-1-philmd@linaro.org>
References: <20250401080938.32278-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/loongarch/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index ea1665e2705..cb96b17911a 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -868,6 +868,7 @@ static const TCGCPUOps loongarch_tcg_ops = {
     .translate_code = loongarch_translate_code,
     .synchronize_from_tb = loongarch_cpu_synchronize_from_tb,
     .restore_state_to_opc = loongarch_restore_state_to_opc,
+    .mmu_index = loongarch_cpu_mmu_index,
 
 #ifndef CONFIG_USER_ONLY
     .tlb_fill = loongarch_cpu_tlb_fill,
@@ -919,7 +920,6 @@ static void loongarch_cpu_class_init(ObjectClass *c, void *data)
                                        &lacc->parent_phases);
 
     cc->class_by_name = loongarch_cpu_class_by_name;
-    cc->mmu_index = loongarch_cpu_mmu_index;
     cc->dump_state = loongarch_cpu_dump_state;
     cc->set_pc = loongarch_cpu_set_pc;
     cc->get_pc = loongarch_cpu_get_pc;
-- 
2.47.1


