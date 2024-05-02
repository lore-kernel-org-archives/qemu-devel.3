Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7D80C4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 21:17:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2dmJ-0008Ko-G8; Thu, 02 May 2024 17:15:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1s2dmI-0008KZ-3D
 for qemu-devel@nongnu.org; Thu, 02 May 2024 17:15:42 -0400
Received: from mail-il1-x12e.google.com ([2607:f8b0:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1s2dmF-0002o2-B4
 for qemu-devel@nongnu.org; Thu, 02 May 2024 17:15:41 -0400
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-36c6f907139so6571705ab.2
 for <qemu-devel@nongnu.org>; Thu, 02 May 2024 14:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714684537; x=1715289337; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FLV/GYrIEX0gQTx5Yxot837zR7KR8Gz9r47zkNmBYYY=;
 b=jrmwyKUbaxM/vjDSBnPC5DyVRy4SQs81PIMJefKgqPcA+cQMiagjg+k0j7eAnVv875
 DgVWyuGSGRFq8KvXDm5oE5gGfhcRn+5/y+rGkMyRsp5n21LLoj7+xk9WBimCknzAdaSt
 ldVM+BwiHdeLyjJNIohnJWes8L498qN06Vl3dAGtKsD/b8QziUhkhuy834wNyun4PgUT
 mrey0zMDRwmZRJnPaKKo2+isXTilsK9Xar2bPXF/z7/sGcW0q6MYFNzrntNKhGIFTmez
 VEsuQ0CMWlnzZddkJPQE0+7EBxqdGYwt+NzJU0eYFOisE4gnNoTOz8THAD+ePYdm2Die
 CDUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714684537; x=1715289337;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FLV/GYrIEX0gQTx5Yxot837zR7KR8Gz9r47zkNmBYYY=;
 b=n5WR2OwqmhxQZSuR2N26AlZPZzK06VUsg1f37JWZY5K9TkrVccjkyeeER/tYapD3rP
 f362oai32CGyP8L46Pa+nJWw1wbQxbVSPtuRiBow43WhBhBI5wlZ4IlDp8bdCvV2fUJZ
 fKn1I6qb8u7EiN72GL6dKntxaodTdsrVWJv4LTrl/KsPBKEkbBvSfGcusk+c/2l4M1Nw
 OxVa4CsguV+gQLKEIRT23GkutAxOvb0wp4RgaWflmaRJaC2dWaZ3AKoWPV0I616jE70Z
 NFXPMFaJsTF/+Wkh7xp5R0d+tftwFIXbmJblyqcwOpS1FXSxjNxg5QxnHpGILI1zXWH4
 5IoA==
X-Gm-Message-State: AOJu0YwaVGfOuyrZWHVlsyJzHn24UOmaDymQ0CiYe/uruR7UEgD28sbo
 HaaXwN/HaAwt+TB3//ddtqgMZCwXr7z+8JtK69WtnHuCnO4pd60BAkd8kAlkib1yei15KC7PlNn
 HR1U=
X-Google-Smtp-Source: AGHT+IFXtiYpuIaDt2bBwp/Sp3/7zT5jcR+wUCnIM0Hq1eUCocPAUkmxY8nijwRHzeaksEoODqQOqA==
X-Received: by 2002:a05:6e02:1d95:b0:36c:3827:58c8 with SMTP id
 h21-20020a056e021d9500b0036c382758c8mr1296179ila.5.1714684536963; 
 Thu, 02 May 2024 14:15:36 -0700 (PDT)
Received: from linaro.vn.shawcable.net ([2604:3d08:9384:1d00::ecd0])
 by smtp.gmail.com with ESMTPSA id
 d14-20020a63f24e000000b0060063c4be3bsm1700915pgk.14.2024.05.02.14.15.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 May 2024 14:15:36 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v6 1/9] plugins: prepare introduction of new inline ops
Date: Thu,  2 May 2024 14:15:14 -0700
Message-Id: <20240502211522.346467-2-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240502211522.346467-1-pierrick.bouvier@linaro.org>
References: <20240502211522.346467-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-il1-x12e.google.com
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

Until now, only add_u64 was available, and all functions assumed this or
were named uniquely.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/qemu/plugin.h  |  2 +-
 accel/tcg/plugin-gen.c |  6 +++---
 plugins/core.c         | 14 ++++++++++++--
 3 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
index 18062528c17..bee1647cfc4 100644
--- a/include/qemu/plugin.h
+++ b/include/qemu/plugin.h
@@ -69,7 +69,7 @@ union qemu_plugin_cb_sig {
 enum plugin_dyn_cb_type {
     PLUGIN_CB_REGULAR,
     PLUGIN_CB_MEM_REGULAR,
-    PLUGIN_CB_INLINE,
+    PLUGIN_CB_INLINE_ADD_U64,
 };
 
 /*
diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index 3db74ae9bfe..8028ae76c3a 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -113,7 +113,7 @@ static void gen_udata_cb(struct qemu_plugin_dyn_cb *cb)
     tcg_temp_free_i32(cpu_index);
 }
 
-static void gen_inline_cb(struct qemu_plugin_dyn_cb *cb)
+static void gen_inline_add_u64_cb(struct qemu_plugin_dyn_cb *cb)
 {
     GArray *arr = cb->inline_insn.entry.score->data;
     size_t offset = cb->inline_insn.entry.offset;
@@ -158,8 +158,8 @@ static void inject_cb(struct qemu_plugin_dyn_cb *cb)
     case PLUGIN_CB_REGULAR:
         gen_udata_cb(cb);
         break;
-    case PLUGIN_CB_INLINE:
-        gen_inline_cb(cb);
+    case PLUGIN_CB_INLINE_ADD_U64:
+        gen_inline_add_u64_cb(cb);
         break;
     default:
         g_assert_not_reached();
diff --git a/plugins/core.c b/plugins/core.c
index 0213513ec65..a8557b54ff7 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -316,6 +316,16 @@ static struct qemu_plugin_dyn_cb *plugin_get_dyn_cb(GArray **arr)
     return &g_array_index(cbs, struct qemu_plugin_dyn_cb, cbs->len - 1);
 }
 
+static enum plugin_dyn_cb_type op_to_cb_type(enum qemu_plugin_op op)
+{
+    switch (op) {
+    case QEMU_PLUGIN_INLINE_ADD_U64:
+        return PLUGIN_CB_INLINE_ADD_U64;
+    default:
+        g_assert_not_reached();
+    }
+}
+
 void plugin_register_inline_op_on_entry(GArray **arr,
                                         enum qemu_plugin_mem_rw rw,
                                         enum qemu_plugin_op op,
@@ -326,7 +336,7 @@ void plugin_register_inline_op_on_entry(GArray **arr,
 
     dyn_cb = plugin_get_dyn_cb(arr);
     dyn_cb->userp = NULL;
-    dyn_cb->type = PLUGIN_CB_INLINE;
+    dyn_cb->type = op_to_cb_type(op);
     dyn_cb->rw = rw;
     dyn_cb->inline_insn.entry = entry;
     dyn_cb->inline_insn.op = op;
@@ -551,7 +561,7 @@ void qemu_plugin_vcpu_mem_cb(CPUState *cpu, uint64_t vaddr,
             cb->regular.f.vcpu_mem(cpu->cpu_index, make_plugin_meminfo(oi, rw),
                                    vaddr, cb->userp);
             break;
-        case PLUGIN_CB_INLINE:
+        case PLUGIN_CB_INLINE_ADD_U64:
             exec_inline_op(cb, cpu->cpu_index);
             break;
         default:
-- 
2.39.2


