Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EA59C52D7B
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 06:47:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdlJ9-00066P-JS; Tue, 13 Aug 2024 02:47:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sdlJ8-00061l-Ay
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 02:47:02 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sdlJ6-0007rf-9S
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 02:47:02 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2cb4b7fef4aso4013274a91.0
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2024 23:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1723531618; x=1724136418;
 darn=nongnu.org; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=bzIAcgqKzO04aMMGR0TLXMYoHzPXpE5sSEkC9JZnbBE=;
 b=bFX+ws6yCVIOLYdvf7hAP5tj4v2FTGIlG8ptspWkfkbt0tFkcqJcSAc5h/0d2mMrCr
 F54kk4n1Ur+yiqrTSHvLAWBW6Pp223TB9et49OteBMPCn3U7kNV1OA1urxAnnfMYWx05
 aBzUXu3JNrdKiES/12yXMyRPiH8+rm1DCb853W7KBRghxU/ZOxnr5pfjkedXXqCdS9MP
 hHcXaN/Nw0gh20yAtdAnYSXBlee1yEKM+42tT0y4wcF0k63Z4cXxIHK29RGDmw2BpEtc
 E+AsUKglOwvm+zUEuSIYBLFPokpyyRYFe6HKpX+xlrSaG1sVSUFqTEI+Mbvj59Brlodz
 tLfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723531618; x=1724136418;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bzIAcgqKzO04aMMGR0TLXMYoHzPXpE5sSEkC9JZnbBE=;
 b=DiRnXeaVXFNT6JhfPt8KI5y6gdSZaO10NgOa8YXzezWZnRMai1c2HQx8zYfpsrYQ+/
 jptqPD8zfLg4TmeXjRnNqrH94O3Icfy9p1wmBAG/QJ1UbsvnQAWLLQWM65kiAeB3wsO8
 eZMSTXb250v85KPVcGbSRn7uzO3oXZxgMI95x7RVKyO6LtEI1TELqM0x/LRsp3Svwqi3
 gABiV+InhBZCDI2hFz8N3mP249JgTKUk0LTHaqt2ZKBR2mg1mz/0kKTsD3pn6Gzbdss4
 T1QZ2qbIcpuf13BDTQ0/T0Xf0vQVZPN59c5gv5+HLVpc+TxYVy8DnRf2OKuPDiKHdWlW
 cWhA==
X-Gm-Message-State: AOJu0YyDgM1fedlyg54QrHx7FK6nQ6iGaC87/7d4qQhN35wNk/OT8MGt
 lWzIUoIDLR51h6idHPI4o5UFgO0JyTpS0GgBz3wdMuxe53S5Bz4fK+nQluCdWsw=
X-Google-Smtp-Source: AGHT+IGc46IyiYANFDkyfpZkpg/wT1CN6aYcxRuR3ZfNOJBtsNyTwrqB42PwmPzVYMvOj88oQBpu4Q==
X-Received: by 2002:a17:90a:b30c:b0:2c9:5a8b:ff7e with SMTP id
 98e67ed59e1d1-2d39254e9f0mr3133225a91.25.1723531618488; 
 Mon, 12 Aug 2024 23:46:58 -0700 (PDT)
Received: from localhost ([157.82.202.230])
 by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-2d1c9db74absm9557342a91.42.2024.08.12.23.46.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Aug 2024 23:46:58 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Tue, 13 Aug 2024 15:46:33 +0900
Subject: [PATCH] contrib/plugins: Add a plugin to generate basic block vectors
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240813-bb-v1-1-effbb77daebf@daynix.com>
X-B4-Tracking: v=1; b=H4sIAEgBu2YC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDM0ML3aQkXUtjYwvzlJQ0czPTJCWgwoKi1LTMCrAh0bG1tQA3yjmOVAA
 AAA==
To: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Alexandre Iooss <erdnaxe@crans.org>, 
 Mahmoud Mandour <ma.mandourr@gmail.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>, 
 Beraldo Leal <bleal@redhat.com>
Cc: qemu-devel@nongnu.org, Yotaro Nada <yotaro.nada@gmail.com>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::102f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x102f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

SimPoint is a widely used tool to find the ideal microarchitecture
simulation points so Valgrind[2] and Pin[3] support generating basic
block vectors for use with them. Let's add a corresponding plugin to
QEMU too.

Note that this plugin has a different goal with tests/plugin/bb.c.

This plugin creates a vector for each constant interval instead of
counting the execution of basic blocks for the entire run and able to
describe the change of execution behavior. Its output is also
syntactically simple and better suited for parsing, while the output of
tests/plugin/bb.c is more human-readable.

[1] https://cseweb.ucsd.edu/~calder/simpoint/
[2] https://valgrind.org/docs/manual/bbv-manual.html
[3] https://www.intel.com/content/www/us/en/developer/articles/tool/pin-a-dynamic-binary-instrumentation-tool.html

Signed-off-by: Yotaro Nada <yotaro.nada@gmail.com>
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 docs/devel/tcg-plugins.rst |  20 ++++++
 contrib/plugins/bb.c       | 153 +++++++++++++++++++++++++++++++++++++++++++++
 contrib/plugins/Makefile   |   1 +
 3 files changed, 174 insertions(+)

diff --git a/docs/devel/tcg-plugins.rst b/docs/devel/tcg-plugins.rst
index 9cc09d8c3da1..2859eecc13b9 100644
--- a/docs/devel/tcg-plugins.rst
+++ b/docs/devel/tcg-plugins.rst
@@ -332,6 +332,26 @@ run::
   160          1      0
   135          1      0
 
+- contrib/plugins/bb.c
+
+The bb plugin allows you to generates basic block vectors for use with the
+`SimPoint <https://cseweb.ucsd.edu/~calder/simpoint/>`__ analysis tool.
+
+It has two options, ``interval`` and ``outfile``. ``interval`` specifies the
+interval to generate a basic block vector by the number of instructions. It is
+optional, and its default value is 100000000. ``outfile`` is the path to
+output files, and it will be suffixed with ``.N.bb`` where ``N`` is a vCPU
+index.
+
+Example::
+
+  $ qemu-aarch64 \
+    -plugin contrib/plugins/libb.so,interval=100,outfile=sha1 \
+    tests/tcg/aarch64-linux-user/sha1
+  SHA1=15dd99a1991e0b3826fede3deffc1feba42278e6
+  $ du sha1.0.bb
+  23128   sha1.0.bb
+
 - contrib/plugins/hotblocks.c
 
 The hotblocks plugin allows you to examine the where hot paths of
diff --git a/contrib/plugins/bb.c b/contrib/plugins/bb.c
new file mode 100644
index 000000000000..4f1266d07ff5
--- /dev/null
+++ b/contrib/plugins/bb.c
@@ -0,0 +1,153 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include <stdio.h>
+#include <glib.h>
+
+#include <qemu-plugin.h>
+
+typedef struct Bb {
+    struct qemu_plugin_scoreboard *count;
+    unsigned int index;
+} Bb;
+
+QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
+static GHashTable *bbs;
+static GPtrArray *files;
+static char *filename;
+static struct qemu_plugin_scoreboard *count;
+static uint64_t interval = 100000000;
+
+static void plugin_exit(qemu_plugin_id_t id, void *p)
+{
+    g_hash_table_unref(bbs);
+    g_ptr_array_unref(files);
+    g_free(filename);
+    qemu_plugin_scoreboard_free(count);
+}
+
+static void free_bb(void *data)
+{
+    qemu_plugin_scoreboard_free(((Bb *)data)->count);
+    g_free(data);
+}
+
+static void free_file(void *data)
+{
+    fclose(data);
+}
+
+static qemu_plugin_u64 count_u64(void)
+{
+    return qemu_plugin_scoreboard_u64(count);
+}
+
+static qemu_plugin_u64 bb_count_u64(Bb *bb)
+{
+    return qemu_plugin_scoreboard_u64(bb->count);
+}
+
+static void vcpu_init(qemu_plugin_id_t id, unsigned int vcpu_index)
+{
+    g_autofree gchar *vcpu_filename = NULL;
+
+    if (vcpu_index >= files->len) {
+        g_ptr_array_set_size(files, vcpu_index + 1);
+    } else if (g_ptr_array_index(files, vcpu_index)) {
+        return;
+    }
+
+    vcpu_filename = g_strdup_printf("%s.%u.bb", filename, vcpu_index);
+    g_ptr_array_index(files, vcpu_index) = fopen(vcpu_filename, "w");
+}
+
+static void vcpu_tb_exec(unsigned int vcpu_index, void *udata)
+{
+    FILE *file = g_ptr_array_index(files, vcpu_index);
+    uint64_t count = qemu_plugin_u64_get(count_u64(), vcpu_index) - interval;
+    GHashTableIter iter;
+    void *value;
+
+    if (!file) {
+        return;
+    }
+
+    qemu_plugin_u64_set(count_u64(), vcpu_index, count);
+
+    fputc('T', file);
+
+    g_hash_table_iter_init(&iter, bbs);
+
+    while (g_hash_table_iter_next(&iter, NULL, &value)) {
+        Bb *bb = value;
+        uint64_t bb_count = qemu_plugin_u64_get(bb_count_u64(bb), vcpu_index);
+
+        if (!bb_count) {
+            continue;
+        }
+
+        fprintf(file, ":%u:%" PRIu64 " ", bb->index, bb_count);
+        qemu_plugin_u64_set(bb_count_u64(bb), vcpu_index, 0);
+    }
+
+    fputc('\n', file);
+}
+
+static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
+{
+    uint64_t n_insns = qemu_plugin_tb_n_insns(tb);
+    uint64_t vaddr = qemu_plugin_tb_vaddr(tb);
+    Bb *bb = g_hash_table_lookup(bbs, &vaddr);
+
+    if (!bb) {
+        uint64_t *key = g_new(uint64_t, 1);
+
+        *key = vaddr;
+        bb = g_new(Bb, 1);
+        g_hash_table_insert(bbs, key, bb);
+        bb->count = qemu_plugin_scoreboard_new(sizeof(uint64_t));
+        bb->index = g_hash_table_size(bbs);
+    }
+
+    qemu_plugin_register_vcpu_tb_exec_inline_per_vcpu(
+        tb, QEMU_PLUGIN_INLINE_ADD_U64, count_u64(), n_insns);
+
+    qemu_plugin_register_vcpu_tb_exec_inline_per_vcpu(
+        tb, QEMU_PLUGIN_INLINE_ADD_U64, bb_count_u64(bb), n_insns);
+
+    qemu_plugin_register_vcpu_tb_exec_cond_cb(
+        tb, vcpu_tb_exec, QEMU_PLUGIN_CB_NO_REGS,
+        QEMU_PLUGIN_COND_GE, count_u64(), interval, NULL);
+}
+
+QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
+                                           const qemu_info_t *info,
+                                           int argc, char **argv)
+{
+    for (int i = 0; i < argc; i++) {
+        char *opt = argv[i];
+        g_auto(GStrv) tokens = g_strsplit(opt, "=", 2);
+        if (g_strcmp0(tokens[0], "interval") == 0) {
+            interval = g_ascii_strtoull(tokens[1], NULL, 10);
+        } else if (g_strcmp0(tokens[0], "outfile") == 0) {
+            filename = tokens[1];
+            tokens[1] = NULL;
+        } else {
+            fprintf(stderr, "option parsing failed: %s\n", opt);
+            return -1;
+        }
+    }
+
+    if (!filename) {
+        fputs("outfile unspecified\n", stderr);
+        return -1;
+    }
+
+    bbs = g_hash_table_new_full(g_int64_hash, g_int64_equal, g_free, free_bb);
+    files = g_ptr_array_new_with_free_func(free_file);
+    count = qemu_plugin_scoreboard_new(sizeof(uint64_t));
+    qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
+    qemu_plugin_register_vcpu_init_cb(id, vcpu_init);
+    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
+
+    return 0;
+}
diff --git a/contrib/plugins/Makefile b/contrib/plugins/Makefile
index 0b64d2c1e3a9..14bc88bb4f86 100644
--- a/contrib/plugins/Makefile
+++ b/contrib/plugins/Makefile
@@ -13,6 +13,7 @@ TOP_SRC_PATH = $(SRC_PATH)/../..
 VPATH += $(SRC_PATH)
 
 NAMES :=
+NAMES += bb
 NAMES += execlog
 NAMES += hotblocks
 NAMES += hotpages

---
base-commit: 74abb45dac6979e7ff76172b7f0a24e869405184
change-id: 20240618-bb-93387ddf765b

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


