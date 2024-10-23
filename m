Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C016CFA45D
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 18:30:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3g71-0001Zx-GB; Wed, 23 Oct 2024 14:29:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t3g6y-0001Zk-Mn
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 14:29:36 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t3g6x-00085i-1E
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 14:29:36 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-71e93d551a3so97152b3a.1
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2024 11:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729708173; x=1730312973; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=EyPHkszPEEqFmMxvX7LJ+5qG1a8+TksRJHfyo/cOntU=;
 b=rO7K6x7+9q9Sn//PE0yY31ch2EhM3g+V8S3Y2hyjsOPL/bE3lYkF67zLH02s13iVab
 GOUeQqCaZWSIYIcw5iYoeWDSmwlPw5yeyDZWEj4pxxQsLA99uk5ILiINIQZ7AcLd2GEX
 /9LgGAzpI341Zgw/tKyCuQxxYAc9Sj0BkiMeXot+3GQwa0PTWNSazyInfEZV8ltnxkck
 ph6/ILZeRI/jVToJF24Kag2uBJKt6S/NuIrUbrrI2OwgHy3b9ZpAnB5lEjU7htaVYONF
 Me9dyP1HSyh5hGNYnF3xk+hXNGJDHj38lLFK1qS2OKgIm1bnmL8kn8aBBMV4qZQxdGIu
 ET8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729708173; x=1730312973;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EyPHkszPEEqFmMxvX7LJ+5qG1a8+TksRJHfyo/cOntU=;
 b=wN6DLF9GaSA6aSn4CzsXP9/i9pqIfy+mr7vQtRcfDAcw+0YcLYHZXxd9CwzqE115oF
 Ix6//gffYtXuE9qVG6jIeiYzgJ+LfibyPoqYEbUVtfpTen1Ww/dXDBZ+5xph93Utin9z
 dBncuhTEM8HAvEL0M47h8y/brHLSYcNwNLJLFND3Jit1bAoZQUS28AOq0WATA3Lk3ujt
 wxKxROy9to7Xa9v8MpUxTVlonLtpgsAdvVcYE/uijy1dKYyZIaQHdmU8CTKDhH441o8I
 SvGQ5Y9Fw9lN459cdsXZvzzGLriYctF57DehoHa5b4IYwA0VrHZD+Z55LGoilHQ4gtti
 IzPw==
X-Gm-Message-State: AOJu0YxUXPhLpL5LxQLSWq/puP0gK9st/pZIGWs79EkH5Mh7QWRafnXm
 cvCqpTQnGV3en9fb3ei+8U8ZqgtmrTesAnwS6SWCyEygRKFMPRZrKCUCmFAWt9WoPY8YYmqF1lV
 pGFax6Q==
X-Google-Smtp-Source: AGHT+IHX+lBIinduWGoZve4ocFEEhtMfqBGF6fZ1hEx2M8LUSx5QoCU5GVspihQTHNclLCO2exwo0w==
X-Received: by 2002:a05:6a00:9297:b0:71e:98a:b6b4 with SMTP id
 d2e1a72fcca58-72030babd9fmr3658223b3a.11.1729708173350; 
 Wed, 23 Oct 2024 11:29:33 -0700 (PDT)
Received: from linaro.. (216-180-64-156.dyn.novuscom.net. [216.180.64.156])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71ec14088fesm6596177b3a.200.2024.10.23.11.29.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Oct 2024 11:29:32 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 alex.bennee@linaro.org, Roman Bolshakov <rbolshakov@ddn.com>,
 Cameron Esfahani <dirty@apple.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH] hvf: remove unused but set variable
Date: Wed, 23 Oct 2024 11:29:22 -0700
Message-Id: <20241023182922.1040964-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x432.google.com
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

fixes associated warning when building on MacOS.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/i386/hvf/x86_task.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/i386/hvf/x86_task.c b/target/i386/hvf/x86_task.c
index f09bfbdda5b..cdea2ea69d9 100644
--- a/target/i386/hvf/x86_task.c
+++ b/target/i386/hvf/x86_task.c
@@ -122,7 +122,6 @@ void vmx_handle_task_switch(CPUState *cpu, x68_segment_selector tss_sel, int rea
     load_regs(cpu);
 
     struct x86_segment_descriptor curr_tss_desc, next_tss_desc;
-    int ret;
     x68_segment_selector old_tss_sel = vmx_read_segment_selector(cpu, R_TR);
     uint64_t old_tss_base = vmx_read_segment_base(cpu, R_TR);
     uint32_t desc_limit;
@@ -138,7 +137,7 @@ void vmx_handle_task_switch(CPUState *cpu, x68_segment_selector tss_sel, int rea
     if (reason == TSR_IDT_GATE && gate_valid) {
         int dpl;
 
-        ret = x86_read_call_gate(cpu, &task_gate_desc, gate);
+        x86_read_call_gate(cpu, &task_gate_desc, gate);
 
         dpl = task_gate_desc.dpl;
         x68_segment_selector cs = vmx_read_segment_selector(cpu, R_CS);
@@ -167,11 +166,12 @@ void vmx_handle_task_switch(CPUState *cpu, x68_segment_selector tss_sel, int rea
         x86_write_segment_descriptor(cpu, &next_tss_desc, tss_sel);
     }
 
-    if (next_tss_desc.type & 8)
-        ret = task_switch_32(cpu, tss_sel, old_tss_sel, old_tss_base, &next_tss_desc);
-    else
+    if (next_tss_desc.type & 8) {
+        task_switch_32(cpu, tss_sel, old_tss_sel, old_tss_base, &next_tss_desc);
+    } else {
         //ret = task_switch_16(cpu, tss_sel, old_tss_sel, old_tss_base, &next_tss_desc);
         VM_PANIC("task_switch_16");
+    }
 
     macvm_set_cr0(cpu->accel->fd, rvmcs(cpu->accel->fd, VMCS_GUEST_CR0) |
                                 CR0_TS_MASK);
-- 
2.39.5


