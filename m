Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7732CC369D7
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 05:30:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u76CI-0001xb-J4; Tue, 22 Apr 2025 01:29:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u76Bk-0001W0-9P; Tue, 22 Apr 2025 01:29:00 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u76Bg-0007qf-Lh; Tue, 22 Apr 2025 01:28:56 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-224100e9a5cso54450415ad.2; 
 Mon, 21 Apr 2025 22:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745299730; x=1745904530; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N77jI1TJkHkxuSuEB7FQGv9pn4PKhNEGgbsGxqAnoxA=;
 b=jkIjgHsAOjWmjWIUYS6VKOJP2doN8/JWc7z005nZ4lbpiY7T1HIh4SAdmtG9RtfQsV
 HuJv063WSvIS3wUN/t5C4nNj0InWKskT52JCnQ07AMH5OiZcPowZlefsFsu/TERvN1KB
 y+3h3xaViy4oC1uwk/TVKF+CRaMMO7/D4n+FE5DTw0Z5hHWeJSwWZ2eUMr+QzkLHaZ8N
 eLpgesaafCbKHgx+KAtGwBbpLTSw8T5KHAWJQfigrPopVdg/NyildkJW6mEqTxTEZg62
 kBMy4nfhoG9U1XebORPBOgFmx5z3QLBm3tY15RyUP1cCuwYPA6gnIV+De/OjleqesJEP
 QJlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745299730; x=1745904530;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N77jI1TJkHkxuSuEB7FQGv9pn4PKhNEGgbsGxqAnoxA=;
 b=HapRo3h/qqG44IC+Ch+oXR5qvn/xH9xvwNw3013HTMHJHtrJDYyMrBomEPV8EyUxtz
 AdOrPGt9z2E7f+oV70TKP4llHvPj34AnJ8hBu3IltsfDWfmkhbypCS/ev0Kwrv6wWNmv
 j4tmEuMuwVsQtgX6PaIGMJmKgkdIqLx5jcxTX1FQNJweKN2YXpJi178F2DTAFTJJ9HhG
 xgHYudUscHEaGC9Dzb7XrS5qs1Z+EehXVYIScKr80HM1SwG1ProEzVM1dw/c99NSIATV
 J+0NGYejSUH6rdB1TAHgRjgzmIVMK3uIm5TOZNR3AuZ79f6au89FknhdeSTiHo5MNZah
 jKmg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVb007KKTHLNBQ8rn5thVnvPngkdPorBqXMLPI6pqUuoBkerDgWl1wntxFT7BHQX2RI+6kAm1Vz/uE8QA==@nongnu.org,
 AJvYcCW7LIDmGb15xW6G2gRa18JM32pt8OMe6Vy3r3ynivWtih2CLUNuKukv9Kk8NIk+IGgo6MV3OAUVBiFK1w==@nongnu.org,
 AJvYcCWM/t/dKgLHvVcVhZsa9RraLs3WX0fc8I5/qXDbmvoVZ/6QNuH+3RKy8PgSsn13rtPF8DctBe/JPw==@nongnu.org,
 AJvYcCXwII/y43dgL17ZtEqJGJXYKjetibdzgbuM+zB9catB5JYv/diGybDhQNn2JtRRwQe3JCGqJJf1trE=@nongnu.org
X-Gm-Message-State: AOJu0YyJl1rjLLthZv1z8YyvtUt1Ready0jUUO5WrPvTUUvEsM4OI3dr
 O81jpbc+ptCexOALqGic+xKCVi8FEAqYJ/xOzIln8xJA3OQ1SC3u2VGS0iUK
X-Gm-Gg: ASbGncunqg9hBBgblum5s6XglQwsq1g5uBdN+G+oTsVvQrK+FgmCR0c/MqvaqhSBuzT
 GjMDoh28AIa1ROEpiM1VuxeCgfARbdLPhbVG3iItP20XYmA1xODh9UnXLiS2cbcoe2MU+9xlQca
 bCjNSMcUKLa5b5S6k0ePPGA/94xjEH1yZkFPT61Yn/vwHjV4QPlymWDG6sA9KEmrY1O+AL+uIuf
 TGtP8oeyyr36sXK/haSm7w1c8BaHkdFIaDxkg+ArBf95tQTtocPWxv1lCvpLhZvj9O70vHJkhLG
 MosiFt8cr/h2a6Ja1dNBNbFASyoekJUqPkpyNrEe53naNzBH9A0QhaTGbppRuodCV5nSTg==
X-Google-Smtp-Source: AGHT+IEzO/OjrHgYHWrum/0TCfoaM8O8Mfn1Scpmvq5a7CT1HGi/VbS6op7C4w92p+94XfsgeUi2hQ==
X-Received: by 2002:a17:902:e808:b0:220:c34c:5760 with SMTP id
 d9443c01a7336-22c5361b398mr186284245ad.51.1745299730025; 
 Mon, 21 Apr 2025 22:28:50 -0700 (PDT)
Received: from localhost.localdomain ([240d:1a:3b6:8b00:e142:4a4f:1ebb:3ca4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50eb4483sm75692085ad.118.2025.04.21.22.28.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Apr 2025 22:28:49 -0700 (PDT)
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Vikram Garhwal <vikram.garhwal@bytedance.com>,
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org
Subject: [PATCH v2 06/20] contrib/plugins: Fix type conflict of GLib function
 pointers
Date: Tue, 22 Apr 2025 14:27:10 +0900
Message-Id: <0fcddfca16ca8da2bdaa7b2c114476f5b73d032b.1745295397.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1745295397.git.ktokunaga.mail@gmail.com>
References: <cover.1745295397.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Emscripten, function pointer casts can result in runtime failures due to
strict function signature checks. This affects the use of g_list_sort and
g_slist_sort, which internally perform function pointer casts that are not
supported by Emscripten. To avoid these issues, g_list_sort_with_data and
g_slist_sort_with_data should be used instead, as they do not rely on
function pointer casting.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 contrib/plugins/cache.c     | 12 ++++++------
 contrib/plugins/cflow.c     | 10 +++++-----
 contrib/plugins/hotblocks.c |  4 ++--
 contrib/plugins/hotpages.c  |  4 ++--
 contrib/plugins/howvec.c    |  4 ++--
 contrib/plugins/hwprofile.c |  8 ++++----
 tests/tcg/plugins/mem.c     |  4 ++--
 tests/tcg/plugins/syscall.c |  4 ++--
 8 files changed, 25 insertions(+), 25 deletions(-)

V2:
- Updated the commit message to explicitly explain that function pointer
  casts are performed internally by GLib.

diff --git a/contrib/plugins/cache.c b/contrib/plugins/cache.c
index 7cfd3df249..56508587d3 100644
--- a/contrib/plugins/cache.c
+++ b/contrib/plugins/cache.c
@@ -576,7 +576,7 @@ static void sum_stats(void)
     }
 }
 
-static int dcmp(gconstpointer a, gconstpointer b)
+static int dcmp(gconstpointer a, gconstpointer b, gpointer d)
 {
     InsnData *insn_a = (InsnData *) a;
     InsnData *insn_b = (InsnData *) b;
@@ -584,7 +584,7 @@ static int dcmp(gconstpointer a, gconstpointer b)
     return insn_a->l1_dmisses < insn_b->l1_dmisses ? 1 : -1;
 }
 
-static int icmp(gconstpointer a, gconstpointer b)
+static int icmp(gconstpointer a, gconstpointer b, gpointer d)
 {
     InsnData *insn_a = (InsnData *) a;
     InsnData *insn_b = (InsnData *) b;
@@ -592,7 +592,7 @@ static int icmp(gconstpointer a, gconstpointer b)
     return insn_a->l1_imisses < insn_b->l1_imisses ? 1 : -1;
 }
 
-static int l2_cmp(gconstpointer a, gconstpointer b)
+static int l2_cmp(gconstpointer a, gconstpointer b, gpointer d)
 {
     InsnData *insn_a = (InsnData *) a;
     InsnData *insn_b = (InsnData *) b;
@@ -645,7 +645,7 @@ static void log_top_insns(void)
     InsnData *insn;
 
     miss_insns = g_hash_table_get_values(miss_ht);
-    miss_insns = g_list_sort(miss_insns, dcmp);
+    miss_insns = g_list_sort_with_data(miss_insns, dcmp, NULL);
     g_autoptr(GString) rep = g_string_new("");
     g_string_append_printf(rep, "%s", "address, data misses, instruction\n");
 
@@ -659,7 +659,7 @@ static void log_top_insns(void)
                                insn->l1_dmisses, insn->disas_str);
     }
 
-    miss_insns = g_list_sort(miss_insns, icmp);
+    miss_insns = g_list_sort_with_data(miss_insns, icmp, NULL);
     g_string_append_printf(rep, "%s", "\naddress, fetch misses, instruction\n");
 
     for (curr = miss_insns, i = 0; curr && i < limit; i++, curr = curr->next) {
@@ -676,7 +676,7 @@ static void log_top_insns(void)
         goto finish;
     }
 
-    miss_insns = g_list_sort(miss_insns, l2_cmp);
+    miss_insns = g_list_sort_with_data(miss_insns, l2_cmp, NULL);
     g_string_append_printf(rep, "%s", "\naddress, L2 misses, instruction\n");
 
     for (curr = miss_insns, i = 0; curr && i < limit; i++, curr = curr->next) {
diff --git a/contrib/plugins/cflow.c b/contrib/plugins/cflow.c
index 930ecb46fc..b5e33f25f9 100644
--- a/contrib/plugins/cflow.c
+++ b/contrib/plugins/cflow.c
@@ -98,7 +98,7 @@ static GHashTable *nodes;
 struct qemu_plugin_scoreboard *state;
 
 /* SORT_HOTTEST */
-static gint hottest(gconstpointer a, gconstpointer b)
+static gint hottest(gconstpointer a, gconstpointer b, gpointer d)
 {
     NodeData *na = (NodeData *) a;
     NodeData *nb = (NodeData *) b;
@@ -107,7 +107,7 @@ static gint hottest(gconstpointer a, gconstpointer b)
         na->dest_count == nb->dest_count ? 0 : 1;
 }
 
-static gint exception(gconstpointer a, gconstpointer b)
+static gint exception(gconstpointer a, gconstpointer b, gpointer d)
 {
     NodeData *na = (NodeData *) a;
     NodeData *nb = (NodeData *) b;
@@ -116,7 +116,7 @@ static gint exception(gconstpointer a, gconstpointer b)
         na->early_exit == nb->early_exit ? 0 : 1;
 }
 
-static gint popular(gconstpointer a, gconstpointer b)
+static gint popular(gconstpointer a, gconstpointer b, gpointer d)
 {
     NodeData *na = (NodeData *) a;
     NodeData *nb = (NodeData *) b;
@@ -138,7 +138,7 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
 {
     g_autoptr(GString) result = g_string_new("collected ");
     GList *data;
-    GCompareFunc sort = &hottest;
+    GCompareDataFunc sort = &hottest;
     int i = 0;
 
     g_mutex_lock(&node_lock);
@@ -162,7 +162,7 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
         break;
     }
 
-    data = g_list_sort(data, sort);
+    data = g_list_sort_with_data(data, sort, NULL);
 
     for (GList *l = data;
          l != NULL && i < topn;
diff --git a/contrib/plugins/hotblocks.c b/contrib/plugins/hotblocks.c
index f12bfb7a26..98404b6885 100644
--- a/contrib/plugins/hotblocks.c
+++ b/contrib/plugins/hotblocks.c
@@ -39,7 +39,7 @@ typedef struct {
     unsigned long insns;
 } ExecCount;
 
-static gint cmp_exec_count(gconstpointer a, gconstpointer b)
+static gint cmp_exec_count(gconstpointer a, gconstpointer b, gpointer d)
 {
     ExecCount *ea = (ExecCount *) a;
     ExecCount *eb = (ExecCount *) b;
@@ -79,7 +79,7 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
     g_string_append_printf(report, "%d entries in the hash table\n",
                            g_hash_table_size(hotblocks));
     counts = g_hash_table_get_values(hotblocks);
-    it = g_list_sort(counts, cmp_exec_count);
+    it = g_list_sort_with_data(counts, cmp_exec_count, NULL);
 
     if (it) {
         g_string_append_printf(report, "pc, tcount, icount, ecount\n");
diff --git a/contrib/plugins/hotpages.c b/contrib/plugins/hotpages.c
index c6e6493719..9d48ac969e 100644
--- a/contrib/plugins/hotpages.c
+++ b/contrib/plugins/hotpages.c
@@ -48,7 +48,7 @@ typedef struct {
 static GMutex lock;
 static GHashTable *pages;
 
-static gint cmp_access_count(gconstpointer a, gconstpointer b)
+static gint cmp_access_count(gconstpointer a, gconstpointer b, gpointer d)
 {
     PageCounters *ea = (PageCounters *) a;
     PageCounters *eb = (PageCounters *) b;
@@ -83,7 +83,7 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
     if (counts && g_list_next(counts)) {
         GList *it;
 
-        it = g_list_sort(counts, cmp_access_count);
+        it = g_list_sort_with_data(counts, cmp_access_count, NULL);
 
         for (i = 0; i < limit && it->next; i++, it = it->next) {
             PageCounters *rec = (PageCounters *) it->data;
diff --git a/contrib/plugins/howvec.c b/contrib/plugins/howvec.c
index 2aa9029c3f..42bddb6566 100644
--- a/contrib/plugins/howvec.c
+++ b/contrib/plugins/howvec.c
@@ -155,7 +155,7 @@ static ClassSelector class_tables[] = {
 static InsnClassExecCount *class_table;
 static int class_table_sz;
 
-static gint cmp_exec_count(gconstpointer a, gconstpointer b)
+static gint cmp_exec_count(gconstpointer a, gconstpointer b, gpointer d)
 {
     InsnExecCount *ea = (InsnExecCount *) a;
     InsnExecCount *eb = (InsnExecCount *) b;
@@ -208,7 +208,7 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
     counts = g_hash_table_get_values(insns);
     if (counts && g_list_next(counts)) {
         g_string_append_printf(report, "Individual Instructions:\n");
-        counts = g_list_sort(counts, cmp_exec_count);
+        counts = g_list_sort_with_data(counts, cmp_exec_count, NULL);
 
         for (i = 0; i < limit && g_list_next(counts);
              i++, counts = g_list_next(counts)) {
diff --git a/contrib/plugins/hwprofile.c b/contrib/plugins/hwprofile.c
index 2a4cbc47d4..a9838ccc87 100644
--- a/contrib/plugins/hwprofile.c
+++ b/contrib/plugins/hwprofile.c
@@ -71,7 +71,7 @@ static void plugin_init(void)
     devices = g_hash_table_new(NULL, NULL);
 }
 
-static gint sort_cmp(gconstpointer a, gconstpointer b)
+static gint sort_cmp(gconstpointer a, gconstpointer b, gpointer d)
 {
     DeviceCounts *ea = (DeviceCounts *) a;
     DeviceCounts *eb = (DeviceCounts *) b;
@@ -79,7 +79,7 @@ static gint sort_cmp(gconstpointer a, gconstpointer b)
            eb->totals.reads + eb->totals.writes ? -1 : 1;
 }
 
-static gint sort_loc(gconstpointer a, gconstpointer b)
+static gint sort_loc(gconstpointer a, gconstpointer b, gpointer d)
 {
     IOLocationCounts *ea = (IOLocationCounts *) a;
     IOLocationCounts *eb = (IOLocationCounts *) b;
@@ -126,13 +126,13 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
     if (counts && g_list_next(counts)) {
         GList *it;
 
-        it = g_list_sort(counts, sort_cmp);
+        it = g_list_sort_with_data(counts, sort_cmp, NULL);
 
         while (it) {
             DeviceCounts *rec = (DeviceCounts *) it->data;
             if (rec->detail) {
                 GList *accesses = g_hash_table_get_values(rec->detail);
-                GList *io_it = g_list_sort(accesses, sort_loc);
+                GList *io_it = g_list_sort_with_data(accesses, sort_loc, NULL);
                 const char *prefix = pattern ? "off" : "pc";
                 g_string_append_printf(report, "%s @ 0x%"PRIx64"\n",
                                        rec->name, rec->base);
diff --git a/tests/tcg/plugins/mem.c b/tests/tcg/plugins/mem.c
index d87d6628e0..ca4e8883dd 100644
--- a/tests/tcg/plugins/mem.c
+++ b/tests/tcg/plugins/mem.c
@@ -67,7 +67,7 @@ static enum qemu_plugin_mem_rw rw = QEMU_PLUGIN_MEM_RW;
 static GMutex lock;
 static GHashTable *regions;
 
-static gint addr_order(gconstpointer a, gconstpointer b)
+static gint addr_order(gconstpointer a, gconstpointer b, gpointer d)
 {
     RegionInfo *na = (RegionInfo *) a;
     RegionInfo *nb = (RegionInfo *) b;
@@ -94,7 +94,7 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
     if (do_region_summary) {
         GList *counts = g_hash_table_get_values(regions);
 
-        counts = g_list_sort(counts, addr_order);
+        counts = g_list_sort_with_data(counts, addr_order, NULL);
 
         g_string_printf(out, "Region Base, Reads, Writes, Seen all\n");
 
diff --git a/tests/tcg/plugins/syscall.c b/tests/tcg/plugins/syscall.c
index 47aad55fc1..42801f5c86 100644
--- a/tests/tcg/plugins/syscall.c
+++ b/tests/tcg/plugins/syscall.c
@@ -180,7 +180,7 @@ static void print_entry(gpointer val, gpointer user_data)
     qemu_plugin_outs(out);
 }
 
-static gint comp_func(gconstpointer ea, gconstpointer eb)
+static gint comp_func(gconstpointer ea, gconstpointer eb, gpointer d)
 {
     SyscallStats *ent_a = (SyscallStats *) ea;
     SyscallStats *ent_b = (SyscallStats *) eb;
@@ -197,7 +197,7 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
 
     g_mutex_lock(&lock);
     GList *entries = g_hash_table_get_values(statistics);
-    entries = g_list_sort(entries, comp_func);
+    entries = g_list_sort_with_data(entries, comp_func, NULL);
     qemu_plugin_outs("syscall no.  calls  errors\n");
 
     g_list_foreach(entries, print_entry, NULL);
-- 
2.25.1


