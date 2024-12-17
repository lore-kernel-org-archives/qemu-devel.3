Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E999E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 22:39:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNgDD-0005O6-73; Tue, 17 Dec 2024 17:38:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNgDA-0005MP-GD
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 17:38:40 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNgD8-0008R6-2z
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 17:38:40 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-21670dce0a7so64801355ad.1
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 14:38:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734475117; x=1735079917; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gSO3SqC3k3PD4UDj10nreaVmTIRbnjLL+fnwPXL6Pds=;
 b=iAQ1m3xRzzMpmce7MRQ7weAI8b57xQxUdzDK95p4N9LsL/QgHdqn4KfsaBHx6RwzvJ
 J3C1d7n+dBkB1NQiTac+ZB2pge1cgsoLzPGbeDMpqlPMzh2mcGeX7UsnH/PwxRTF7+Vg
 r7W0O1mYGNwHvAnJ11doYZRsujy/QdRi/uDu14HVKfuOgu0cvMIXGDKTamv7zVfLC9i5
 5dGWxOF04lx6wX0wa7jl65EASga47r124xzijPXH025p5H63cNmbecaE3l35kvsrfAtV
 8xyxmXuwROnqdoduHN6QDtgRl4X8wL6z/FVtD8BvHKetihHw+clMMyLfRzXKGblT8iiU
 +j/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734475117; x=1735079917;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gSO3SqC3k3PD4UDj10nreaVmTIRbnjLL+fnwPXL6Pds=;
 b=AU+Olr7LNm8RvXN8rRBAbLl7Cp/HCAnOQA244UKcHYxTKFsD/0i800Xi3HcsfJF1Ie
 Hj7+2NN1sHAyyn3G5DA5AZkxSnSjqn3Csi5nHwvz4zue2rIZcRXzTIAsQEpc+zDz7JpV
 e6F+6jcJCirnXuFY4nNyx9UgbaPSDgpeTtgFwKTOW1HV72Uj+dleLCvcP5OHqerjMKVf
 f4tV5IqqaeunvQfrwnl9Skp8HD6SCmQtNdV04h8uIADODF9rBi6aaIGZSoP/xm+JTLXt
 IxLwmkEaiKKe3dYQjvBrkHOgFyEGrs6FU4tTPlAZT1DH7OMzKlKqcB1Cy0GoQAa5jvS4
 UxGg==
X-Gm-Message-State: AOJu0Yyd16nVj00qXLA8m9VTes3uXIPMSPJFnp7IM/noZxH5vwLWaBkX
 fNbY40Wh2nQ3AYBEixa0WRjXclulckNfqiuDrIgMBP1uE44Cd/1VPkPNEPz+bQmSMsZm3S5lMYk
 S3b0=
X-Gm-Gg: ASbGncsZtbSUu2Sj322O1mdfsUiQZjf4MCDSL0bsIjz1REJjcCFGOGVKPZOMYBIe5v1
 Gv8EvcnexdvvRn4Z3JNM2sjqhBtAQghJO5bxzx2tgs7zcmX2+2pVA19mKgCoIC1l3N0O8aCJG3k
 1oHBdPRXzjJlK6S0HDsoIS3Khwjy/CSru2c/G3J6Fu4W5Xk4vrpJA+E5qxRc6iFWXBJstRfMDQh
 Q5g+aN2XOpfGE+6RJ6uyCtwfobwCg866Vzh4Qd7l+8el9elS+2zRWgq
X-Google-Smtp-Source: AGHT+IH9pbWAfPDyCtRInCw3rSBYtCOvAf+l0p+T5wAPbz50//UgnZ0BcAtq6xyEjGUNzU6Xo3XBww==
X-Received: by 2002:a17:902:fc47:b0:215:853d:38 with SMTP id
 d9443c01a7336-218d70f6e34mr8595865ad.25.1734475116839; 
 Tue, 17 Dec 2024 14:38:36 -0800 (PST)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-218a1dccb03sm64869465ad.98.2024.12.17.14.38.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2024 14:38:36 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, philmd@linaro.org,
 Mahmoud Mandour <ma.mandourr@gmail.com>, richard.henderson@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH v2 07/11] contrib/plugins/hotblocks: fix 32-bit build
Date: Tue, 17 Dec 2024 14:38:21 -0800
Message-Id: <20241217223825.2895749-8-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241217223825.2895749-1-pierrick.bouvier@linaro.org>
References: <20241217223825.2895749-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x630.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 contrib/plugins/hotblocks.c | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/contrib/plugins/hotblocks.c b/contrib/plugins/hotblocks.c
index 02bc5078bdd..f12bfb7a267 100644
--- a/contrib/plugins/hotblocks.c
+++ b/contrib/plugins/hotblocks.c
@@ -29,7 +29,7 @@ static guint64 limit = 20;
  *
  * The internals of the TCG are not exposed to plugins so we can only
  * get the starting PC for each block. We cheat this slightly by
- * xor'ing the number of instructions to the hash to help
+ * checking the number of instructions as well to help
  * differentiate.
  */
 typedef struct {
@@ -50,6 +50,20 @@ static gint cmp_exec_count(gconstpointer a, gconstpointer b)
     return count_a > count_b ? -1 : 1;
 }
 
+static guint exec_count_hash(gconstpointer v)
+{
+    const ExecCount *e = v;
+    return e->start_addr ^ e->insns;
+}
+
+static gboolean exec_count_equal(gconstpointer v1, gconstpointer v2)
+{
+    const ExecCount *ea = v1;
+    const ExecCount *eb = v2;
+    return (ea->start_addr == eb->start_addr) &&
+           (ea->insns == eb->insns);
+}
+
 static void exec_count_free(gpointer key, gpointer value, gpointer user_data)
 {
     ExecCount *cnt = value;
@@ -91,7 +105,7 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
 
 static void plugin_init(void)
 {
-    hotblocks = g_hash_table_new(NULL, g_direct_equal);
+    hotblocks = g_hash_table_new(exec_count_hash, exec_count_equal);
 }
 
 static void vcpu_tb_exec(unsigned int cpu_index, void *udata)
@@ -111,10 +125,15 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
     ExecCount *cnt;
     uint64_t pc = qemu_plugin_tb_vaddr(tb);
     size_t insns = qemu_plugin_tb_n_insns(tb);
-    uint64_t hash = pc ^ insns;
 
     g_mutex_lock(&lock);
-    cnt = (ExecCount *) g_hash_table_lookup(hotblocks, (gconstpointer) hash);
+    {
+        ExecCount e;
+        e.start_addr = pc;
+        e.insns = insns;
+        cnt = (ExecCount *) g_hash_table_lookup(hotblocks, &e);
+    }
+
     if (cnt) {
         cnt->trans_count++;
     } else {
@@ -123,7 +142,7 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
         cnt->trans_count = 1;
         cnt->insns = insns;
         cnt->exec_count = qemu_plugin_scoreboard_new(sizeof(uint64_t));
-        g_hash_table_insert(hotblocks, (gpointer) hash, (gpointer) cnt);
+        g_hash_table_insert(hotblocks, cnt, cnt);
     }
 
     g_mutex_unlock(&lock);
-- 
2.39.5


