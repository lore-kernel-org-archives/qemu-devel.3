Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A918C48260
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 09:42:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZpIK-0001xF-Ah; Tue, 13 Feb 2024 04:41:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rZpIF-0001fp-BQ
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 04:41:35 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rZpIC-0000J0-7z
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 04:41:35 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-33ce0802f17so95049f8f.0
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 01:41:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707817290; x=1708422090; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FtKR50om3lz2f67CJh+jhse66BPOqMojGHQCZZJ40RI=;
 b=tGpsDd0XMuxcbaNyKMoFmMJZUbM+ejni7rejQ8U5i7shL/Fn+kgt78mGQYnv8oHqKy
 LYQCGQamHVJvBJqunKbQFjnY0efHGE0DVPMPlVa/jZ2bJnJvdDtB89K6t990bwG+2tDV
 JU8m7OwmvQ7o0Q84ksxaiChhahs9/7t7uDSG1OsICgHZG8LKZm1U3UjCpjeKZuU1Iq4I
 cvr7AqTye9oRNFO5DU664CJcVmMY6wBIvKENYj0ox5JBI9DfFktGguALUuwWbQPeaKfF
 qWXjwYPScSVh/I8sVxnAVCcd04YaLE9cDxwS21bI/7ZWsCZJRiADsNzSzXBEJk3bhKwP
 ea4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707817291; x=1708422091;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FtKR50om3lz2f67CJh+jhse66BPOqMojGHQCZZJ40RI=;
 b=jrKpNaA1uGOgU8Gsy3ExZKsfhequKBaOaKCBLgQn518wZeFys4NcY8E2fu7FD+1/P5
 Df4494EDuZALEuAOP6t/1RPYK4J91lDI7vWD7k7TzTOq8UelxezTBNA/vywStR4DAxtU
 jVtP5svUts23QLanvK60yWJpzqRRJgIT6x8K8zB3ae1OT7Tl8jS2+pjXm4bi3pG2DCai
 HRqNk+AzB9pqBp2odrN46jMPvpEMhcPsiIhmkCzfU9uCDjQyiP1GfG9cWMdq/5XTVYHA
 NWQrG0Q1APcKyRkbk9B5Lw1Twu706mzhC0+ROD7KhRkz8MtdbvU7Jdv6i0VvlzwOhYC3
 t1KQ==
X-Gm-Message-State: AOJu0YxV6iCWCOTUa/nTR6PIrE03YvfP43iWyvL7spcwA2PsdPKPdMjJ
 oPPpqszVDMUcUYsSASlgjqpTGJBAqd4bEPKoEtu3QoUq2b3/+n9wNTQeg4uugXQMRgZTrLcGHEE
 z
X-Google-Smtp-Source: AGHT+IF+YxYNnFyOLVS05aWWUG01lmXrCw2O/PpV5g3qDOsvR9giJ+QhQTHJF+SnPGViOGoVAQOo/w==
X-Received: by 2002:a05:6000:108a:b0:33b:25cd:ba9 with SMTP id
 y10-20020a056000108a00b0033b25cd0ba9mr5196920wrw.70.1707817290762; 
 Tue, 13 Feb 2024 01:41:30 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVIFr3bKkOm/GqsCsb4PUDcBYvPrjlC5NO1dN3lhld/63qalz/asPo9nM6+nyaJhgod3l7xp8vNWYUrFKSlT/PTxBYRvH0pi0acsfd59MhHpn2w9zcnADXwGrxd9ePwTHYvtUgStOEseUdUvHFc8fTtNtO1kUQ4t2EN4Fr/hs2vKL2eAoP1YATlIYTj72q6MS1JOyvk155kgMWoGYWMuyTrXhPL6iQqFDyi/iWsz1Bt1OWuxLwkdd+N5bYCapaoV+dhFfFwMdNUZfvST/92jP3SWM+CknjjiIYCIQDSbIk1JCAPyk9vh960zoXcPC+/7MaQnJ3//+S4Lk+WpRPPAe7fxVNWRQ==
Received: from linaro.. ([102.35.208.160]) by smtp.gmail.com with ESMTPSA id
 cc19-20020a5d5c13000000b0033b728190c1sm8550261wrb.79.2024.02.13.01.41.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Feb 2024 01:41:30 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v4 17/18] plugins: cleanup codepath for previous inline
 operation
Date: Tue, 13 Feb 2024 13:40:07 +0400
Message-ID: <20240213094009.150349-18-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213094009.150349-1-pierrick.bouvier@linaro.org>
References: <20240213094009.150349-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wr1-x42f.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 plugins/plugin.h       |  5 -----
 accel/tcg/plugin-gen.c | 13 ++++---------
 plugins/core.c         | 29 ++++-------------------------
 3 files changed, 8 insertions(+), 39 deletions(-)

diff --git a/plugins/plugin.h b/plugins/plugin.h
index c547c5c83ea..7f391329bdc 100644
--- a/plugins/plugin.h
+++ b/plugins/plugin.h
@@ -68,11 +68,6 @@ struct qemu_plugin_ctx {
 
 struct qemu_plugin_ctx *plugin_id_to_ctx_locked(qemu_plugin_id_t id);
 
-void plugin_register_inline_op(GArray **arr,
-                               enum qemu_plugin_mem_rw rw,
-                               enum qemu_plugin_op op, void *ptr,
-                               uint64_t imm);
-
 void plugin_register_inline_op_on_entry(GArray **arr,
                                         enum qemu_plugin_mem_rw rw,
                                         enum qemu_plugin_op op,
diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index 25915a93242..3d8943cef2f 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -439,15 +439,10 @@ static TCGOp *append_inline_cb(const struct qemu_plugin_dyn_cb *cb,
                                TCGOp *begin_op, TCGOp *op,
                                int *unused)
 {
-    char *ptr = cb->userp;
-    size_t elem_size = 0;
-    size_t offset = 0;
-    if (!ptr) {
-        /* use inline entry */
-        ptr = cb->inline_insn.entry.score->data->data;
-        elem_size = g_array_get_element_size(cb->inline_insn.entry.score->data);
-        offset = cb->inline_insn.entry.offset;
-    }
+    char *ptr = cb->inline_insn.entry.score->data->data;
+    size_t elem_size = g_array_get_element_size(
+        cb->inline_insn.entry.score->data);
+    size_t offset = cb->inline_insn.entry.offset;
 
     op = copy_ld_i32(&begin_op, op);
     op = copy_mul_i32(&begin_op, op, elem_size);
diff --git a/plugins/core.c b/plugins/core.c
index 10ffdf6d938..4b2b030d76e 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -310,22 +310,6 @@ static struct qemu_plugin_dyn_cb *plugin_get_dyn_cb(GArray **arr)
     return &g_array_index(cbs, struct qemu_plugin_dyn_cb, cbs->len - 1);
 }
 
-void plugin_register_inline_op(GArray **arr,
-                               enum qemu_plugin_mem_rw rw,
-                               enum qemu_plugin_op op,
-                               void *ptr,
-                               uint64_t imm)
-{
-    struct qemu_plugin_dyn_cb *dyn_cb;
-
-    dyn_cb = plugin_get_dyn_cb(arr);
-    dyn_cb->userp = ptr;
-    dyn_cb->type = PLUGIN_CB_INLINE;
-    dyn_cb->rw = rw;
-    dyn_cb->inline_insn.op = op;
-    dyn_cb->inline_insn.imm = imm;
-}
-
 void plugin_register_inline_op_on_entry(GArray **arr,
                                         enum qemu_plugin_mem_rw rw,
                                         enum qemu_plugin_op op,
@@ -488,15 +472,10 @@ void qemu_plugin_flush_cb(void)
 
 void exec_inline_op(struct qemu_plugin_dyn_cb *cb, int cpu_index)
 {
-    char *ptr = cb->userp;
-    size_t elem_size = 0;
-    size_t offset = 0;
-    if (!ptr) {
-        /* use inline entry */
-        ptr = cb->inline_insn.entry.score->data->data;
-        elem_size = g_array_get_element_size(cb->inline_insn.entry.score->data);
-        offset = cb->inline_insn.entry.offset;
-    }
+    char *ptr = cb->inline_insn.entry.score->data->data;
+    size_t elem_size = g_array_get_element_size(
+        cb->inline_insn.entry.score->data);
+    size_t offset = cb->inline_insn.entry.offset;
     uint64_t *val = (uint64_t *)(ptr + offset + cpu_index * elem_size);
 
     switch (cb->inline_insn.op) {
-- 
2.43.0


