Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F548C4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 18:11:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2arv-0003Fl-Jz; Thu, 02 May 2024 14:09:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1s2arh-0003Aa-LC
 for qemu-devel@nongnu.org; Thu, 02 May 2024 14:09:06 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1s2arf-0003QK-DJ
 for qemu-devel@nongnu.org; Thu, 02 May 2024 14:09:05 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1ec69e3dbe5so25861135ad.0
 for <qemu-devel@nongnu.org>; Thu, 02 May 2024 11:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714673341; x=1715278141; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j20AZdNFWHjX41h0cwLDI6PFJ1ubsLWLFf3xDhC/IKc=;
 b=bzHDvijUtTnmbArzAkBJAIOrP7TO1m8aZicC4WYrfT8IC79Nh7YkkNJ5jJEaIq4q+F
 eXG9PBZELJQl3j5z8wKT2ymATgZMGq1L/gDOZLQuyK1Y5Rr2CR6kw/Fls7b9tt023E7g
 M5hcV+DaSwfSs8EUQIcrWXioCDBtk8WMpn9Y1BHes1MIOq+P4Yf1pLUW1U/wJom6dHRO
 hs5cacK3UhbNqB/lK787N+IGmqWQ/jnp46ERMyMLPOH1dbcuA3+N0TJcsbtzgv9ybfWN
 ClfV8qYRJG4us0ymE6/Uc4TjG/bNZaCB1SF5KVtWpGV7AtYakQ5SYuv6jNPobLZ+QsIB
 k82A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714673341; x=1715278141;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j20AZdNFWHjX41h0cwLDI6PFJ1ubsLWLFf3xDhC/IKc=;
 b=I3kiWXKo/4x0NxrX5q0+leQKTaoO7f8fqHG6NchLzItgRP9MJBAbQ8wBVEX6m8Vdm2
 ppCsayzImduH9bkR6RG5X1n9OUNmL/7NZHypIv3sEcHs+T/16LgDQVvUFNhzHmr3OUj2
 95jRnqY7CL8dr8lixkIsse8n50OYmIP67mxUM2cobJK7RrOzPZSEY7PHTZrmtA8tKzgw
 2wR+i5RRQU+nxQHoVO/mzWzxCnboqcdl+OxK+u8bvYskaYJRccMXZAqEXuH8licqvsCw
 tJG474inft1OIMMmu0C0hVF8bchelu9uNknYTkLxbeBZKQmdjIWArCrzMQungLU08UWl
 IyCQ==
X-Gm-Message-State: AOJu0Yz6p0HHl/sfD0tbfRF17XUcvpsL037/ZeUr0AfGh3eq5FYFUOzC
 WVptEFQDTPmTT+el4sFydyt1KNfCPyqoRSmkSY6HYxm6hoojKB/qZ9+OquvBClDML21PI8OAgvk
 EnFg=
X-Google-Smtp-Source: AGHT+IGbXOPaxNtb6Z/mt5e6vHUjFW/hf3TSv5a2elWCTR+A7Yp8CKiq9Jrh9xMqO8CfvoDxqbQDdQ==
X-Received: by 2002:a17:902:d482:b0:1e2:d4da:6c72 with SMTP id
 c2-20020a170902d48200b001e2d4da6c72mr739015plg.0.1714673341310; 
 Thu, 02 May 2024 11:09:01 -0700 (PDT)
Received: from linaro.vn.shawcable.net ([2604:3d08:9384:1d00::ecd0])
 by smtp.gmail.com with ESMTPSA id
 c17-20020a170902d49100b001ebd73f61fcsm1615605plg.121.2024.05.02.11.09.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 May 2024 11:09:00 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v5 2/9] plugins: extract generate ptr for qemu_plugin_u64
Date: Thu,  2 May 2024 11:08:40 -0700
Message-Id: <20240502180847.287673-3-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240502180847.287673-1-pierrick.bouvier@linaro.org>
References: <20240502180847.287673-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62d.google.com
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
 accel/tcg/plugin-gen.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index 8028ae76c3a..8e2c3ef94f6 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -113,24 +113,33 @@ static void gen_udata_cb(struct qemu_plugin_dyn_cb *cb)
     tcg_temp_free_i32(cpu_index);
 }
 
-static void gen_inline_add_u64_cb(struct qemu_plugin_dyn_cb *cb)
+static TCGv_ptr gen_plugin_u64_ptr(qemu_plugin_u64 entry)
 {
-    GArray *arr = cb->inline_insn.entry.score->data;
-    size_t offset = cb->inline_insn.entry.offset;
-    TCGv_i32 cpu_index = tcg_temp_ebb_new_i32();
-    TCGv_i64 val = tcg_temp_ebb_new_i64();
     TCGv_ptr ptr = tcg_temp_ebb_new_ptr();
 
+    GArray *arr = entry.score->data;
+    char *base_ptr = arr->data + entry.offset;
+    size_t entry_size = g_array_get_element_size(arr);
+
+    TCGv_i32 cpu_index = tcg_temp_ebb_new_i32();
     tcg_gen_ld_i32(cpu_index, tcg_env,
                    -offsetof(ArchCPU, env) + offsetof(CPUState, cpu_index));
-    tcg_gen_muli_i32(cpu_index, cpu_index, g_array_get_element_size(arr));
+    tcg_gen_muli_i32(cpu_index, cpu_index, entry_size);
     tcg_gen_ext_i32_ptr(ptr, cpu_index);
     tcg_temp_free_i32(cpu_index);
+    tcg_gen_addi_ptr(ptr, ptr, (intptr_t) base_ptr);
 
-    tcg_gen_addi_ptr(ptr, ptr, (intptr_t)arr->data);
-    tcg_gen_ld_i64(val, ptr, offset);
+    return ptr;
+}
+
+static void gen_inline_add_u64_cb(struct qemu_plugin_dyn_cb *cb)
+{
+    TCGv_ptr ptr = gen_plugin_u64_ptr(cb->inline_insn.entry);
+    TCGv_i64 val = tcg_temp_ebb_new_i64();
+
+    tcg_gen_ld_i64(val, ptr, 0);
     tcg_gen_addi_i64(val, val, cb->inline_insn.imm);
-    tcg_gen_st_i64(val, ptr, offset);
+    tcg_gen_st_i64(val, ptr, 0);
 
     tcg_temp_free_i64(val);
     tcg_temp_free_ptr(ptr);
-- 
2.39.2


