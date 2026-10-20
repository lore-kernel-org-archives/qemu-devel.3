Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF59606A319
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 12:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=WN7TfbVa
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJ8wn-0008Sb-A1; Tue, 20 Oct 2026 08:28:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xJ8wl-0008SL-Rl
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 08:28:03 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xJ8wk-0004Mr-7j
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 08:28:03 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4a1df146015so19006535e9.0
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 05:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792499280; x=1793104080; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Zhp3G2DCG5w/xJJN4I2L5thmUqX44nmG1wWLXQD3W6g=;
 b=WN7TfbVa6YN/9g/VqTHJUbJSOBAb7k+HOriEPyvhTvuvzWp9F4FvHGSKgIlxX4gqLP
 MJPdyMQD8IQF5swKIvl9lNE6E41VjsO7Ey42SZCD4FJIxAh1BiTTKncYbGeFhl2O7t6r
 g4Wg5ZHVsK5jg5Es374HJd8PQUW5TnBHIVBqeWFSdiw9yL8r7Cm/WO/zkkgXcuX/Ww2p
 7CdXwsdifz5W1YMKUxuhKC+VrmbheKo0AI0Qg+zsHbFY92gq7siah8blfXfVrORWOIBz
 JsH/v8+B4Rgq65rfFZzpOvq/l1AXdmQpYsPXlE8fuSrMNd8tNe7AqiKHg8Nz0FhGSzSd
 C66Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792499280; x=1793104080;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Zhp3G2DCG5w/xJJN4I2L5thmUqX44nmG1wWLXQD3W6g=;
 b=vs2uAQ5AKzz0qkf1x9d4kq+QTH/nuV6hQ0hLdJsi+xiRhBTY7Hy2/gLnobuiO5NWWz
 Smps6E24bQttK5c+0/YD3ZeyrQBC0mWPPRnLbunwOSUEm/kQ1wq49OGZA35/xQbVYKMJ
 DPl9fUJINnYVh0eTdhgReAXx6SnERp1i30I9QrujM49Byms3TuOB+4GIfVPIhem51wUO
 n235h24H31zmVrEJKbZhdgL1vAy1Jf61jL3QcY/aAK7vCf3ZT4YZMh1qr5tGLQ1Lrru8
 rCb6+vViOY5s2tmo0zDGL3BZF+Vw2UD6OCDqnBmSIwBseoObyMduFbBL8rH2uDXxotlm
 +nSw==
X-Gm-Message-State: AFq9FYIb/b1kkqGjnXxbfoLv0wKZTzqXSBG65lJx8h1a42aMc4lf+SkY
 yb0CaBnT/G0u3SxwZftF3QMNWjhXe/HRETE0IB09z1HnNy5r4RHoiLIYwBw8rwriyEKj5lWr8+/
 jNNZmEuA=
X-Gm-Gg: AYBFou1Bp6j9MDT7EeT/BlAuSmH+7FrIyLPkP01bziJFowFDr4EjnZN/2+8UVxTBb3N
 hODJVxrD+wBYB/BDmy3dbAhX+nyHkof4pmjINSzR75LiPwx3m+cVTI/bYz+znsadavZ/LOVAjoP
 wpj3eWCf3R45Q/QxzCwB/WOLX+6GUNv5wHcb65/H7wJx6uzj3QvH8kVsWt7gnYbxqyu/dBtSbq1
 yHVaasf/LFUkonuY7xh6kvE6HHn2VxMSsh35eG2/nrt8q7c2EnLKT1q/TTTA8r+mOhShLUy4MVj
 Se0v3nO78cEPDT3CWzxVhE76ZAySlX+YHcjd6s+fHLnOwG+9OrYYERZbiyGi/bZ/nl1hs5UBXM/
 XOFdd8eWvhr0j9Z1hzYf4lsof6ciI/djJLHyKWOt/9GJobpedfrCPUiWZy0U/KRZkabsJS1dwPU
 r9XC4gvyjLNOZXDOcuzBh70/b67ZFTIwU/mkIH0U1YWHpLIIlvxehwTrjW0VpxJFAyX8MJuF+QY
 CBiqemdv6FD0gvRyUVQictMpUbkhOzDlY6sRnMOqLH+Wa7lEeBJHIZIhOBF9G+CJiuoEOXaDnDn
 /Fc=
X-Received: by 2002:a05:600c:468e:b0:4a0:12d7:4c88 with SMTP id
 5b1f17b1804b1-4a1d7625f71mr242544745e9.30.1792499279880; 
 Tue, 20 Oct 2026 05:27:59 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1f2cd482bsm68899315e9.12.2026.10.20.05.27.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 05:27:58 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Michael Rolnik <mrolnik@gmail.com>, Stafford Horne <shorne@gmail.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>
Subject: [PATCH 2/5] target/avr: Convert to translate_for_debug
Date: Tue, 20 Oct 2026 13:27:49 +0100
Message-ID: <20261020122752.3651914-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261020122752.3651914-1-peter.maydell@linaro.org>
References: <20261020122752.3651914-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Convert avr to providing the translate_for_debug method rather than
the deprecated get_phys_addr_debug method.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/avr/cpu.h    |  3 ++-
 target/avr/cpu.c    |  2 +-
 target/avr/helper.c | 11 +++++++++--
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/target/avr/cpu.h b/target/avr/cpu.h
index 1e4e839bd83..4e2372a6801 100644
--- a/target/avr/cpu.h
+++ b/target/avr/cpu.h
@@ -177,7 +177,8 @@ extern const struct VMStateDescription vms_avr_cpu;
 
 void avr_cpu_do_interrupt(CPUState *cpu);
 bool avr_cpu_exec_interrupt(CPUState *cpu, int int_req);
-hwaddr avr_cpu_get_phys_addr_debug(CPUState *cpu, vaddr addr);
+bool avr_cpu_translate_for_debug(CPUState *cpu, vaddr addr,
+                                 TranslateForDebugResult *result);
 int avr_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 int avr_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 int avr_print_insn(bfd_vma addr, disassemble_info *info);
diff --git a/target/avr/cpu.c b/target/avr/cpu.c
index f8409f32ab9..9476bd87276 100644
--- a/target/avr/cpu.c
+++ b/target/avr/cpu.c
@@ -233,7 +233,7 @@ static void avr_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 
 static const struct SysemuCPUOps avr_sysemu_ops = {
     .has_work = avr_cpu_has_work,
-    .get_phys_addr_debug = avr_cpu_get_phys_addr_debug,
+    .translate_for_debug = avr_cpu_translate_for_debug,
 };
 
 static const TCGCPUOps avr_tcg_ops = {
diff --git a/target/avr/helper.c b/target/avr/helper.c
index f452c9d9040..8f90b8d9a45 100644
--- a/target/avr/helper.c
+++ b/target/avr/helper.c
@@ -108,9 +108,16 @@ void avr_cpu_do_interrupt(CPUState *cs)
     qemu_plugin_vcpu_interrupt_cb(cs, ret);
 }
 
-hwaddr avr_cpu_get_phys_addr_debug(CPUState *cs, vaddr addr)
+bool avr_cpu_translate_for_debug(CPUState *cs, vaddr addr,
+                                 TranslateForDebugResult *result)
 {
-    return addr; /* I assume 1:1 address correspondence */
+    /* I assume 1:1 address correspondence */
+    *result = (TranslateForDebugResult) {
+        .physaddr = addr,
+        .lg_page_size = TARGET_PAGE_BITS,
+        .attrs.debug = 1,
+    };
+    return true;
 }
 
 bool avr_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
-- 
2.43.0


