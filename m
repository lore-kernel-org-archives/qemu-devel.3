Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A114C4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 18:10:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2as7-0003Ia-R1; Thu, 02 May 2024 14:09:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1s2arp-0003Cq-Qc
 for qemu-devel@nongnu.org; Thu, 02 May 2024 14:09:14 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1s2arn-0003RS-3s
 for qemu-devel@nongnu.org; Thu, 02 May 2024 14:09:13 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1ec41d82b8bso33054315ad.2
 for <qemu-devel@nongnu.org>; Thu, 02 May 2024 11:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714673348; x=1715278148; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6rrkhscyYuczfAUwr3Y8eSiiztQ7d4sdBk9KEUj+ldE=;
 b=gV9HJwswEod0g/ro7cNJ7Ycc9BgoYXFVGvuY75ary0g9UBgLyT2gMyysLxnQ6XtowU
 TGe9NzTZiNQtFKxPixK+Ur5+4uK2dO0mzFPquKjyVM+InZnWHX2y8ekv+lFVnAhIu0bJ
 f87hnXUmP8mlU6gLuHtK/QpPVlfqdlth3J87+g+IRE9zAz1SIGjYGR7ThMFvMGilKeBm
 leD4/PArDZMuIyD4iym4Ke42JqDX5R1W8VIVZc7hciOU+W7+1xJ09gZnbt4dH4DDEB1I
 lN7+YAgtme7IWv1gNXrC5iUewMErnW7edixd4eDkKDVc/BU9O0W4+AaY7chKemsikWlD
 l3nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714673348; x=1715278148;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6rrkhscyYuczfAUwr3Y8eSiiztQ7d4sdBk9KEUj+ldE=;
 b=NFb23505bt7zg26Q/lQ5jeyNzywVXKxJq0zt/9PpDXFoZL3mME1i983QAZ+qEcBoRP
 fsDTLIF28QgWvWoZhl5vEBWwLyg5JWZzmR3xZz5h/tX8m7kbHVglTxs6FdYcy9KpZ4lU
 Z4cPDDutBSKYpC/DA91ogmxS/e2YgQDEnqApeMo/gRPiZ1JVcta0mVF4169DDrpLec0l
 hVuM9KeRE/rvkJLUy0eVid/g5A4VjhhNbqIVLvZ2rFeI3YxrzTZbXfUw5xeqU7C96aYq
 qZMPCtV2+IbDVfeY2rSxhmJ8n3fEE2TU+XOK6aH5dG74MxwpWDzHu2iTpU0DAB+l5A3w
 7/1Q==
X-Gm-Message-State: AOJu0YwwNKYyBQptjaMSkD5iKewYB9XvaQ5HJJ4aN3l7CraOkRVzudt2
 NCkZA5kaLfhgGH2C18be9jTI+OPPdvnBh9ELNQhcaR8TTggh/iZ6QjRRPEQlYbkr1IqPp8O2nwl
 17Ek=
X-Google-Smtp-Source: AGHT+IHB3ReSSdm6gc3QAKjkC4DAihdwJTrK8XfDXL7EhzWEo7e5ZWBk5JMlpwWPG6tqt6ogYSWFWw==
X-Received: by 2002:a17:902:ce87:b0:1e0:983c:d686 with SMTP id
 f7-20020a170902ce8700b001e0983cd686mr583932plg.20.1714673348270; 
 Thu, 02 May 2024 11:09:08 -0700 (PDT)
Received: from linaro.vn.shawcable.net ([2604:3d08:9384:1d00::ecd0])
 by smtp.gmail.com with ESMTPSA id
 c17-20020a170902d49100b001ebd73f61fcsm1615605plg.121.2024.05.02.11.09.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 May 2024 11:09:07 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v5 8/9] plugins: extract cpu_index generate
Date: Thu,  2 May 2024 11:08:46 -0700
Message-Id: <20240502180847.287673-9-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240502180847.287673-1-pierrick.bouvier@linaro.org>
References: <20240502180847.287673-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62c.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 accel/tcg/plugin-gen.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index b829a959398..7b73520e788 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -101,12 +101,17 @@ static void gen_disable_mem_helper(void)
                    offsetof(ArchCPU, env));
 }
 
+static TCGv_i32 gen_cpu_index(void)
+{
+    TCGv_i32 cpu_index = tcg_temp_ebb_new_i32();
+    tcg_gen_ld_i32(cpu_index, tcg_env,
+                   -offsetof(ArchCPU, env) + offsetof(CPUState, cpu_index));
+    return cpu_index;
+}
+
 static void gen_udata_cb(struct qemu_plugin_regular_cb *cb)
 {
-    TCGv_i32 cpu_index = tcg_temp_ebb_new_i32();
-
-    tcg_gen_ld_i32(cpu_index, tcg_env,
-                   -offsetof(ArchCPU, env) + offsetof(CPUState, cpu_index));
+    TCGv_i32 cpu_index = gen_cpu_index();
     tcg_gen_call2(cb->f.vcpu_udata, cb->info, NULL,
                   tcgv_i32_temp(cpu_index),
                   tcgv_ptr_temp(tcg_constant_ptr(cb->userp)));
@@ -121,9 +126,7 @@ static TCGv_ptr gen_plugin_u64_ptr(qemu_plugin_u64 entry)
     char *base_ptr = arr->data + entry.offset;
     size_t entry_size = g_array_get_element_size(arr);
 
-    TCGv_i32 cpu_index = tcg_temp_ebb_new_i32();
-    tcg_gen_ld_i32(cpu_index, tcg_env,
-                   -offsetof(ArchCPU, env) + offsetof(CPUState, cpu_index));
+    TCGv_i32 cpu_index = gen_cpu_index();
     tcg_gen_muli_i32(cpu_index, cpu_index, entry_size);
     tcg_gen_ext_i32_ptr(ptr, cpu_index);
     tcg_temp_free_i32(cpu_index);
@@ -156,7 +159,6 @@ static TCGCond plugin_cond_to_tcgcond(enum qemu_plugin_cond cond)
 static void gen_udata_cond_cb(struct qemu_plugin_conditional_cb *cb)
 {
     TCGv_ptr ptr = gen_plugin_u64_ptr(cb->entry);
-    TCGv_i32 cpu_index = tcg_temp_ebb_new_i32();
     TCGv_i64 val = tcg_temp_ebb_new_i64();
     TCGLabel *after_cb = gen_new_label();
 
@@ -165,15 +167,14 @@ static void gen_udata_cond_cb(struct qemu_plugin_conditional_cb *cb)
 
     tcg_gen_ld_i64(val, ptr, 0);
     tcg_gen_brcondi_i64(cond, val, cb->imm, after_cb);
-    tcg_gen_ld_i32(cpu_index, tcg_env,
-                   -offsetof(ArchCPU, env) + offsetof(CPUState, cpu_index));
+    TCGv_i32 cpu_index = gen_cpu_index();
     tcg_gen_call2(cb->f.vcpu_udata, cb->info, NULL,
                   tcgv_i32_temp(cpu_index),
                   tcgv_ptr_temp(tcg_constant_ptr(cb->userp)));
+    tcg_temp_free_i32(cpu_index);
     gen_set_label(after_cb);
 
     tcg_temp_free_i64(val);
-    tcg_temp_free_i32(cpu_index);
     tcg_temp_free_ptr(ptr);
 }
 
@@ -203,10 +204,7 @@ static void gen_inline_store_u64_cb(struct qemu_plugin_inline_cb *cb)
 static void gen_mem_cb(struct qemu_plugin_regular_cb *cb,
                        qemu_plugin_meminfo_t meminfo, TCGv_i64 addr)
 {
-    TCGv_i32 cpu_index = tcg_temp_ebb_new_i32();
-
-    tcg_gen_ld_i32(cpu_index, tcg_env,
-                   -offsetof(ArchCPU, env) + offsetof(CPUState, cpu_index));
+    TCGv_i32 cpu_index = gen_cpu_index();
     tcg_gen_call4(cb->f.vcpu_mem, cb->info, NULL,
                   tcgv_i32_temp(cpu_index),
                   tcgv_i32_temp(tcg_constant_i32(meminfo)),
-- 
2.39.2


