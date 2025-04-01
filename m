Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 179E1C36018
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 08:16:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzWiX-0000N0-5p; Tue, 01 Apr 2025 04:11:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzWiT-0000BQ-F4
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 04:11:25 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzWiR-00062B-L8
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 04:11:25 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43cfba466b2so52067855e9.3
 for <qemu-devel@nongnu.org>; Tue, 01 Apr 2025 01:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743495082; x=1744099882; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jp1FKYkXGpdKTDVVOvTyK7ETPKiPrk5iqOmg0nQYNOs=;
 b=ZW9uhZ7ziIzfYwcJ+G/pf/DWih9YLwDnd9OP7oy+x7RD9CPgES36pfEsVmXIY2m8YR
 0o6SehhndFoAd+TF5ANlfaoAe84k0bgH9P7XKj7M3r/X0PtUsfG+xa+3ilhxGR4tq2jE
 6XcOikHt93gxCKvxSAlUDDK7/Jdx+71IzwahrWcTvYnXq372spjY9i/d9+m0Ew2gQ9At
 cwsMSZ5ZvMXino+W3Aly+agWtV0nXLLDTUP78l8qTkldObDPu5nkAbFUh/gZtEd5ivyq
 DA5Kd927vXznRpXSyxt8He5uQnQ3Ta+QEuNA2Leq1IyTkwBl/PdAJP/AljzAr6aFNPOf
 BQ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743495082; x=1744099882;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Jp1FKYkXGpdKTDVVOvTyK7ETPKiPrk5iqOmg0nQYNOs=;
 b=o0YHNi/p4AN9F9/PSMqFGQwo25x7Iev0LD7c278zScumNE85PISQyZURX6x+qfcNcT
 aobIQ5fRT2V9YUDGtiw1v7IlFsMBEwmOhWZ0rKVKcAqtT5KPmz5BxEnPeTMZpWUURtS+
 Cy+kbS2BnZmdGJpx/X/LlJXzxQ1MlhBuPKsjSD6RcoB7X1YEEMmsnMVQLgpA5i2cU4fn
 ectuVmRXKT7LRlwf4KdVjpbxLnfac6GMwbMtoBB4BAF1+lQw4N5aztM+HCh+k3s+xOiX
 VpZaSeF6S7NCopfkQ1m8/Vvo776lM3eL0rjCBGdWCCnumFEnadZlxR+2umG1ROwKaWUZ
 dUVw==
X-Gm-Message-State: AOJu0Yx1b0986vYQakkofzdHd2+O51MSs0ILy4F7rQbWGbngKgX9T5wz
 uuXJMr9CMuKGWwl4PKM2p9zpqhkbkzoZKUpwVYQyzXCsJLCQWPpdK466IQAIWbOBMRAmGYkLT4a
 z
X-Gm-Gg: ASbGncss1h3oWmR4sQFR+hDW8LyQCyPxXkNxtLJ6Kloz2evgVVI2TQ0K9H7K+0bR8gC
 zajPjLz3r9Zv+iIv0tu4mvZQT907iCY9YDBwFBNagXo5Hn8zs5WUBBzLSv2LW6DExsJGZOPzzI8
 fsQYliIdnqPVBwIVSqaDy5E7OXHxrhitn+1etF42jaK3Gz8hCgIOpdaEg/xG607hhdMRx9qLRti
 liLtJ5Xt0VvJVxL4eE1C4orA3ucNmS61sabG3niXqPuUwSxofCtXI037miVXFvJH5mU6a89UZyG
 MdBrexilHaTHjJ/RQOXj4uKH6s9cBAwuyXFsTfaSJCpKQaoWEdB+nQa2+L48msx09XHlnzPNYpG
 NjNBHQ6ibHOcjXUaI0lGZpranjyn83Q==
X-Google-Smtp-Source: AGHT+IGcf9hp3RIJB2V9P4Oh281LfwfpbsGz/jk6Y8PVGt7bw5XKVFqH10zeU38Loj6NYRYxvmMHUQ==
X-Received: by 2002:a05:600c:4e48:b0:43d:3df:42d8 with SMTP id
 5b1f17b1804b1-43eaa03e0c4mr11417555e9.6.1743495081761; 
 Tue, 01 Apr 2025 01:11:21 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d82a041d4sm196289745e9.0.2025.04.01.01.11.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 01 Apr 2025 01:11:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 21/24] target/tricore: Restrict SoftMMU mmu_index()
 to TCG
Date: Tue,  1 Apr 2025 10:09:34 +0200
Message-ID: <20250401080938.32278-22-philmd@linaro.org>
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
 target/tricore/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/tricore/cpu.c b/target/tricore/cpu.c
index 16acc4ecb92..833a93d37af 100644
--- a/target/tricore/cpu.c
+++ b/target/tricore/cpu.c
@@ -176,6 +176,7 @@ static const TCGCPUOps tricore_tcg_ops = {
     .translate_code = tricore_translate_code,
     .synchronize_from_tb = tricore_cpu_synchronize_from_tb,
     .restore_state_to_opc = tricore_restore_state_to_opc,
+    .mmu_index = tricore_cpu_mmu_index,
     .tlb_fill = tricore_cpu_tlb_fill,
     .cpu_exec_interrupt = tricore_cpu_exec_interrupt,
     .cpu_exec_halt = tricore_cpu_has_work,
@@ -194,7 +195,6 @@ static void tricore_cpu_class_init(ObjectClass *c, void *data)
     resettable_class_set_parent_phases(rc, NULL, tricore_cpu_reset_hold, NULL,
                                        &mcc->parent_phases);
     cc->class_by_name = tricore_cpu_class_by_name;
-    cc->mmu_index = tricore_cpu_mmu_index;
 
     cc->gdb_read_register = tricore_cpu_gdb_read_register;
     cc->gdb_write_register = tricore_cpu_gdb_write_register;
-- 
2.47.1


