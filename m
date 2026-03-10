Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB4F3EB107C
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 15:55:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzzPr-00040T-C2; Tue, 10 Mar 2026 11:54:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzzPp-0003tR-UI
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 11:54:37 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzzPo-0006eP-4A
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 11:54:37 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-485445e80bdso7372655e9.0
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 08:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773158074; x=1773762874; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YW+XYGQCeSgcIjfg8jHdlieGTiidwq557ZHdo7cIdpE=;
 b=IuNqx570Uj1/iRPc7C4fEdxLXTSSErrj7x3Dlh0J0h8QhU/HND9CWe+sKbexNxRTZZ
 I4LHTRLnyEHhSgtcybPo1HPJlOq35b5Mufp/sPC73uGjPxPPs4IUWHH2OQj//hP4htpc
 annxaP8hQmrclsunBcnK/S1rVZMgJaKpcPpMiHX2S9Db6MAfXrspsixVSLXdIWWeBM+W
 V9vxyjgrAdJJy6vomWWEZR1V3/EFpz0Zf8sTEwIMWicWGVX+67x7OKOYUIzDkBaLQwJl
 YgA/kSrwmfrPBZsPH8SmZ6H+kvsq6i5lVRhDGCtKSehLesu9YaEv6qiRdIVcFcYAGnHJ
 CoLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773158074; x=1773762874;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YW+XYGQCeSgcIjfg8jHdlieGTiidwq557ZHdo7cIdpE=;
 b=v6iTMhkb6idpbioMNGNQN8H5DtPoPpWyMybGYkFg93PmAnEF4BM9zBxCU1b/bInPsz
 IXPAAxvJ+gOkBwDKZWqkLLKFAnJ74mx5TLUyb0YxlCah8OMdjJ0gXY7bBl13E0naR5gP
 ebIa5/RCYWaCgyqPRRK3Wu6M12IIiYpflism6gyGWKHaNGWiTo9j07WK1HDGCOXJ6ciY
 JBKy7m5F6EIkgrcDScwMzBG0DJYYvfmiHezJ9gh3Dhh9PL/TBCCwt33KJvti5XJpI9Z6
 dAYtJFDNUQ9sz1F/+EVKkFno9lFvMCAtxzjrf86sVrQ38OtbsYSCRHowM3t7On40np+Q
 JiPQ==
X-Gm-Message-State: AOJu0Ywe2fYSR3K72pks+vla4d/zNmuEYtWOG2FrEh6T1w9aSr6cblnF
 HEEHQZ4PzdTOUKAWHRl2Hk9Xx7miJOUpJIA4O+JoTt8PmGYW/zEe24GcRI+SyJvlmJS3WRwsReo
 YE3JOeA8=
X-Gm-Gg: ATEYQzxYoxWsVrwpiPm31O4Ii/MIx9DQW+gX8jl/6/DjBHEt05qjUerRxTTuIG9i+u4
 vFltACeN2U8LSYi1UPNnihzd1e7wsh6FMDe3DrwyYm5s0ZSsLrJbzrU1wrK++xQmlgx1Ln7LQTt
 wjGFJ7x+swXlm8fxZeobScKjFL9j3IX2cEO3PBnuyfmZ7M2FPDPHIqHTDSXwrkWgsZcPKpVxgDO
 Aa0RHlUm0gmqVzZJKEU+5DXbwSNaQM9VL6IO4nsHDiuj5veSJkOXN25p6NQbbJQvjGYa7oavxPT
 Ea0bP5qmXgybIpUjDUOs9kKb7KaiVUsXdRBr+zUQ6XpL14JHdfG/LzvySj3awcc7rrYBFsOXqJw
 dCZGjDr347CIATPIGrfDIwv/zel5nb4sniQ4Kk9MLo0WXdKaUuw5FQvCTfFMrkYKipO8jtiZfdb
 XUAW+5CdZq7VMF/GDalw2fYWyDO0TKd+gOa/yqUdIJF0J+HO35an5XiLZqI06mvw9RqMuSJcxm
X-Received: by 2002:a05:600c:4e8f:b0:485:3f65:94a1 with SMTP id
 5b1f17b1804b1-4853f6596b4mr102730635e9.18.1773158074142; 
 Tue, 10 Mar 2026 08:54:34 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48541aa73easm81204435e9.3.2026.03.10.08.54.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 10 Mar 2026 08:54:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Florian Hofhammer <florian.hofhammer@fhofhammer.de>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-ppc@nongnu.org
Subject: [PATCH v2 09/13] gdbstub: Use GDBFeature::base_reg in
 gdb_register_feature()
Date: Tue, 10 Mar 2026 16:53:25 +0100
Message-ID: <20260310155329.48772-10-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310155329.48772-1-philmd@linaro.org>
References: <20260310155329.48772-1-philmd@linaro.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

When a feature XML file provides a "regnum=" tag to indicate
the registers base index, respect it, as it might not be the
same as our current number of registered entries, in particular
when there are gaps.

This fixes a bug with the "power-fpu.xml" file [*] which was
loaded at index 70 while the base register is 71. This latent
bug was exposed by commit 1ec0fbe2dda ("target/ppc: Fix
CPUClass::gdb_num_core_regs value").

[*] https://lore.kernel.org/qemu-devel/e44df309-d40d-46f0-88a8-7ac55f9a3634@fhofhammer.de/

Reported-by: Florian Hofhammer <florian.hofhammer@fhofhammer.de>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 gdbstub/gdbstub.c    | 16 ++++++++++------
 gdbstub/trace-events |  1 +
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index ad4bdc0623d..6976f31933f 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -556,19 +556,19 @@ int gdb_write_register(CPUState *cpu, uint8_t *mem_buf, int reg)
     return 0;
 }
 
-static void gdb_register_feature(CPUState *cpu, int base_reg,
+static void gdb_register_feature(CPUState *cpu,
                                  gdb_get_reg_cb get_reg, gdb_set_reg_cb set_reg,
                                  const GDBFeature *feature)
 {
     GDBRegisterState s = {
-        .base_reg = base_reg,
+        .base_reg = feature->base_reg,
         .get_reg = get_reg,
         .set_reg = set_reg,
         .feature = feature
     };
 
     trace_gdbxml_register_feature(feature->name, feature->xmlname,
-                                  base_reg, feature->num_regs);
+                                  feature->base_reg, feature->num_regs);
     g_array_append_val(cpu->gdb_regs, s);
 }
 
@@ -597,7 +597,8 @@ void gdb_init_cpu(CPUState *cpu)
     if (xmlfile) {
         assert(!cc->gdb_num_core_regs);
         feature = gdb_find_static_feature(xmlfile);
-        gdb_register_feature(cpu, 0,
+        assert(feature->base_reg == 0);
+        gdb_register_feature(cpu,
                              cc->gdb_read_register, cc->gdb_write_register,
                              feature);
         cpu->gdb_num_regs = cpu->gdb_num_g_regs = feature->num_regs;
@@ -617,7 +618,6 @@ void gdb_register_coprocessor(CPUState *cpu,
 {
     GDBRegisterState *s;
     guint i;
-    int base_reg = cpu->gdb_num_regs;
 
     for (i = 0; i < cpu->gdb_regs->len; i++) {
         /* Check for duplicates.  */
@@ -627,7 +627,11 @@ void gdb_register_coprocessor(CPUState *cpu,
         }
     }
 
-    gdb_register_feature(cpu, base_reg, get_reg, set_reg, feature);
+    if (cpu->gdb_num_regs < feature->base_reg) {
+        trace_gdbxml_register_coprocessor_gap(cpu->gdb_num_regs,
+                                              feature->base_reg);
+    }
+    gdb_register_feature(cpu, get_reg, set_reg, feature);
 
     /* Add to end of list.  */
     cpu->gdb_num_regs += feature->num_regs;
diff --git a/gdbstub/trace-events b/gdbstub/trace-events
index 44ef3339934..7036818a387 100644
--- a/gdbstub/trace-events
+++ b/gdbstub/trace-events
@@ -29,6 +29,7 @@ gdbstub_err_checksum_incorrect(uint8_t expected, uint8_t got) "got command packe
 gdbstub_err_unexpected_runpkt(uint8_t ch) "unexpected packet (0x%02x) while target running"
 
 gdbxml_init_cpu(const char *typename, unsigned id, unsigned gdb_num_regs, unsigned gdb_num_g_regs, unsigned gdb_num_core_regs) "%s:%d regs:%u g_regs:%u core_regs:%u"
+gdbxml_register_coprocessor_gap(unsigned gdb_num_regs, unsigned base_reg) "regs %u -> %u"
 gdbxml_register_feature(const char *featname, const char *xmlname, unsigned base_reg, unsigned num_regs) "%s (%s) @%u +%u"
 gdbxml_feature_builder_header(const char *name, const char *xmlname, int num_regs) "%s (%s) regs:%d"
 gdbxml_feature_builder_content(const char *xml) "%s"
-- 
2.53.0


