Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7255AC27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 19:53:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHU0w-0001Vt-LH; Wed, 12 Jun 2024 15:52:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sHU0s-0001Uj-UU
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 15:52:06 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sHU0r-0001ir-7w
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 15:52:06 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-705c424ebbbso187342b3a.1
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2024 12:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718221923; x=1718826723; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8gy0JxlZS4txlKe3nUnoxbsxzsnpPJAtrjxoA7hdB8Y=;
 b=iI+Hm9JLoTd/WsBG2Hhqt1PlEoyzr0D9G55LZ1j0IqaiU2aPuJLDjceSe+GD3ySjWj
 lWVhmyk4LWHEPjoUKgE7dcYE9kJ62q248s70rWq81Mk58D4qEdQ7Z/OVfwURSC6+eNdt
 Hf2/0cnztpfLjdEoQ9F+W0jyg+Rds8Dj5RVUrrgyC77IcIlkDk64M6f/qlhSIplHx9eV
 yIjZPYfQXli9AgASScpXhSt4eaNqfXwF90WNMcjmJRdkonp87LTcIsQtTZQcVkppt9tn
 RSlyhiHdZVkzp+ObJxdV9x0fk+VHg59X/EigFRRKCclVxPIobTT4NvA6cXBhn28tUQV/
 512A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718221923; x=1718826723;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8gy0JxlZS4txlKe3nUnoxbsxzsnpPJAtrjxoA7hdB8Y=;
 b=GX/6MKFWzzgSXqrzVEmAFmzums9NDyCm1DbfpEmgT5cU6KFLMYSjkWNT0eIZqPXvDy
 mL1eopHk/pR7Zd4J4sG80MjKzBhbuRLny+IC0JtFGaE0sl3BRmYTx959KjGDN5ZNMnRd
 i+6f4ETS7Pl+C0vgHKdcPU4M57gyxU8mnhr3lznNCMSnzLQIGZS6lphfCK8qR/cSLAyY
 1PBkff61cFZuqTFHNfUisXFR/KazrPGD2szeaWGw/SfQwRfb3hDNKp68r8MIROlZ2lqb
 wTypx7ssNHdPB62OOhoDih554PVsslX14qfTEjN9mCm8cVOsXv3l+cE72VI1COwwYQkk
 fCcA==
X-Gm-Message-State: AOJu0YzgYiEu9n9a7s1HJjG9BLdvz1Ax7zH4RHPMGnjeq//t+riVZRJa
 juuPlXU5JfpW6gzz1ACZz/6zNK4eQYF+6dwz2+vVV9kmhCeCea5LOrouLq8q51B9z6KKNk1kyp/
 j
X-Google-Smtp-Source: AGHT+IGDdcINSwUlJBEf9TcaaMioP2hJISS68IxBgf2AF7xpmHq+S8QVdUndcgYr38vIu83dKlSdSw==
X-Received: by 2002:a05:6a00:21d1:b0:704:37b2:4ced with SMTP id
 d2e1a72fcca58-705bcdffe08mr3484327b3a.11.1718221922699; 
 Wed, 12 Jun 2024 12:52:02 -0700 (PDT)
Received: from linaro.vn.shawcable.net ([2604:3d08:9384:1d00::2193])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70424c7fc99sm8009927b3a.157.2024.06.12.12.52.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Jun 2024 12:52:02 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PATCH 2/2] plugins: fix inject_mem_cb rw masking
Date: Wed, 12 Jun 2024 12:51:47 -0700
Message-Id: <20240612195147.93121-3-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240612195147.93121-1-pierrick.bouvier@linaro.org>
References: <20240612195147.93121-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42c.google.com
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

These are not booleans, but masks.
Issue found by Richard Henderson.

Fixes: f86fd4d8721 ("plugins: distinct types for callbacks")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 accel/tcg/plugin-gen.c | 4 ++--
 plugins/core.c         | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index cc1634e7a6b..b6bae32b997 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -240,13 +240,13 @@ static void inject_mem_cb(struct qemu_plugin_dyn_cb *cb,
 {
     switch (cb->type) {
     case PLUGIN_CB_MEM_REGULAR:
-        if (rw && cb->regular.rw) {
+        if (rw & cb->regular.rw) {
             gen_mem_cb(&cb->regular, meminfo, addr);
         }
         break;
     case PLUGIN_CB_INLINE_ADD_U64:
     case PLUGIN_CB_INLINE_STORE_U64:
-        if (rw && cb->inline_insn.rw) {
+        if (rw & cb->inline_insn.rw) {
             inject_cb(cb);
         }
         break;
diff --git a/plugins/core.c b/plugins/core.c
index badede28cf9..9d737d82787 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -589,7 +589,7 @@ void qemu_plugin_vcpu_mem_cb(CPUState *cpu, uint64_t vaddr,
 
         switch (cb->type) {
         case PLUGIN_CB_MEM_REGULAR:
-            if (rw && cb->regular.rw) {
+            if (rw & cb->regular.rw) {
                 cb->regular.f.vcpu_mem(cpu->cpu_index,
                                        make_plugin_meminfo(oi, rw),
                                        vaddr, cb->regular.userp);
@@ -597,7 +597,7 @@ void qemu_plugin_vcpu_mem_cb(CPUState *cpu, uint64_t vaddr,
             break;
         case PLUGIN_CB_INLINE_ADD_U64:
         case PLUGIN_CB_INLINE_STORE_U64:
-            if (rw && cb->inline_insn.rw) {
+            if (rw & cb->inline_insn.rw) {
                 exec_inline_op(cb->type, &cb->inline_insn, cpu->cpu_index);
             }
             break;
-- 
2.39.2


