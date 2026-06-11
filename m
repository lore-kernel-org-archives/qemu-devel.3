Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85B8DCD8CB2
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 05:58:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXYQy-000658-Ux; Thu, 11 Jun 2026 01:58:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wXYQx-00064z-Gl
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 01:58:31 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wXYQt-0004kG-Rm
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 01:58:31 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-45ef189aa1cso5543786f8f.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 22:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781157506; x=1781762306; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=6Tjdy6dlmyDWdlff3235c98sDRmsj9Vnka1uRXEr6VM=;
 b=Pzg+G5dDBoQqXzbfnXfZqxvx5z95GG1kVsdRQn3CwNsLUePboknsX7dz2b0GNoZy3c
 Iz7kQ5G5bK8mfAa71ofk1gDDQKw6sIZTn20EF+5ts5dB4uVN03DMe278O9hUTEtVEI1k
 r5su7ihxl4a6YYuzvnIDcn+F5Ngxhdw531n2hAAajIiUzOUHQcHzRsVykGUJN/o3ePih
 vmpGTf5p9e/C1BMyHKM7QNfAFt0mMCgze5ex8zGH4K+CAyYWhMuU0kBF41BP2knu6/Nq
 wVQFrHfCwnenCwqng1f7sWCZnGNcT3+DM0aPfIPtt62JulxDSo8YDtdQN03o5KAGxOgJ
 WYyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781157506; x=1781762306;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6Tjdy6dlmyDWdlff3235c98sDRmsj9Vnka1uRXEr6VM=;
 b=FG/7cBWxv7psBeMif+aa+EoqwCBmDC6VuoHDxXiQxInTpj0ZaJ22uUu7oUWRRuxe72
 gv0OuwAOgfMCVVqB2ObhENkukcjEz/TZdfIUzlagflZVrXDxVMVNEAndiBxFvxpybbV+
 /bN0ZzSF+48anZcFrNccGNNFWwaz0zL6rwzHKvMlF2XsD7OQRDREBFtAm4CHuGTmCker
 49KyFoiqybRXnVqZ5AqpM2gPRg6NnKwvZlguDT6/Ofge1VjU8tLCCP8ewWqzMznn3dyV
 53210LZaAV6wXGIs3hPlOyPLNSXaOpYpaqYttLEEVrAUrCupKn0+rF9XJjAv1A7RcHPj
 4gfQ==
X-Gm-Message-State: AOJu0YyD5Cu3bRXgkj+chP7lNeATSH1ik+oXdOv16ZEpDLi8iKFSiewV
 rPKqwc7unMo+2m+OUBNYw/1Nc5GxnHe5oGkW+BiiueGU8J4LAb4mx+Gh7Awo2be8C2/NITi5Orm
 WCv45qyw=
X-Gm-Gg: Acq92OHePpVahh6DfZqf8Pnzn0vN8gySF5Krtlr2OJHAqRjpEwXiohUO1694u2pIwiY
 odoI3k3+1Uv+tpiQeLiWsSThHEE2WNQ2ndjqaX2/h2RV0fXf+Fra/m/UH7sxpKtBZYAtkBUxoIw
 YWfSyWju36U3nfY4i/ZCxSwENhdgayu4k2myeZ8e45vNskZUtuB94pITkLL5yEONmOBjjcL7+wd
 /nKjU5HZrt9HD06UWN2iNlBwMGOvtBfNgNAIgu5GAzLSY0Ni7zH6OXwB0+BAFI7yhyvpQ34L5vV
 yW632YOnoJ3AE4j8eduSJQN8dRAErD6UBuVgPt4mG4DeP/altEQB0d5RZtYchNquORglzbtSHHR
 tfscgsW+Ef4ZEA9seEqqkOFO1iFD+pUnUnknoBpr9mu1s+/y9YbIhJQj/uTLZaOReKqcwfk3W7o
 Z2yjCSzh0YfYfKHz9xmjdfi0D3ZugGG6THHoDS8jNVea0oDxxdP7pXBl8tBfzZRm2v2blWvpXzX
 LSBnJWoR48lp4Il6h+jAOoneZRr5FV4nLUfHHI4AMZDcLrfMrfgNR1YPIziTw==
X-Received: by 2002:a5d:5d86:0:b0:460:67e0:563c with SMTP id
 ffacd0b85a97d-46067e0570fmr1540875f8f.38.1781157505931; 
 Wed, 10 Jun 2026 22:58:25 -0700 (PDT)
Received: from meli-email.org (ppp-2-86-135-61.home.otenet.gr. [2.86.135.61])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f34413csm76691739f8f.21.2026.06.10.22.58.25
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 10 Jun 2026 22:58:25 -0700 (PDT)
Date: Thu, 11 Jun 2026 08:57:33 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: Chao Liu <chao.liu.zevorn@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 Alex Benn=?UTF-8?B?w6k=?=e <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Alexandre Iooss <erdnaxe@crans.org>
Subject: Re: [PATCH 16/25] plugins: add userdata to
 qemu_plugin_vcpu_tb_trans_cb_t
User-Agent: meli/0.8.13
References: <20260603205152.1440291-1-pierrick.bouvier@oss.qualcomm.com>
 <20260603205152.1440291-17-pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <20260603205152.1440291-17-pierrick.bouvier@oss.qualcomm.com>
Message-ID: <tggdxc.1dpccfc9pplai@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x42d.google.com
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

On Wed, 03 Jun 2026 23:51, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> wrote:
>Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

> contrib/plugins/bbv.c         | 4 ++--
> contrib/plugins/cache.c       | 4 ++--
> contrib/plugins/cflow.c       | 4 ++--
> contrib/plugins/cpp.cpp       | 4 ++--
> contrib/plugins/drcov.c       | 4 ++--
> contrib/plugins/execlog.c     | 4 ++--
> contrib/plugins/hotblocks.c   | 4 ++--
> contrib/plugins/hotpages.c    | 4 ++--
> contrib/plugins/howvec.c      | 4 ++--
> contrib/plugins/hwprofile.c   | 4 ++--
> contrib/plugins/ips.c         | 4 ++--
> contrib/plugins/lockstep.c    | 4 ++--
> contrib/plugins/stoptrigger.c | 4 ++--
> contrib/plugins/uftrace.c     | 4 ++--
> include/plugins/qemu-plugin.h | 8 ++++++--
> plugins/api.c                 | 5 +++--
> plugins/core.c                | 2 +-
> tests/tcg/plugins/bb.c        | 4 ++--
> tests/tcg/plugins/discons.c   | 4 ++--
> tests/tcg/plugins/empty.c     | 4 ++--
> tests/tcg/plugins/inline.c    | 4 ++--
> tests/tcg/plugins/insn.c      | 4 ++--
> tests/tcg/plugins/mem.c       | 4 ++--
> tests/tcg/plugins/patch.c     | 4 ++--
> tests/tcg/plugins/reset.c     | 8 ++++----
> tests/tcg/plugins/setpc.c     | 4 ++--
> 26 files changed, 58 insertions(+), 53 deletions(-)
>
>diff --git a/contrib/plugins/bbv.c b/contrib/plugins/bbv.c
>index 7e9e72477d7..0e6ec673d97 100644
>--- a/contrib/plugins/bbv.c
>+++ b/contrib/plugins/bbv.c
>@@ -102,7 +102,7 @@ static void vcpu_interval_exec(unsigned int vcpu_index, void *udata)
>     fputc('\n', vcpu->file);
> }
> 
>-static void vcpu_tb_trans(struct qemu_plugin_tb *tb)
>+static void vcpu_tb_trans(struct qemu_plugin_tb *tb, void *userdata)
> {
>     uint64_t n_insns = qemu_plugin_tb_n_insns(tb);
>     uint64_t vaddr = qemu_plugin_tb_vaddr(tb);
>@@ -157,7 +157,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
>     vcpus = qemu_plugin_scoreboard_new(sizeof(Vcpu));
>     qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
>     qemu_plugin_register_vcpu_init_cb(id, vcpu_init, NULL);
>-    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
>+    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans, NULL);
> 
>     return 0;
> }
>diff --git a/contrib/plugins/cache.c b/contrib/plugins/cache.c
>index c9d61de26c9..0a5349f131e 100644
>--- a/contrib/plugins/cache.c
>+++ b/contrib/plugins/cache.c
>@@ -462,7 +462,7 @@ static void vcpu_insn_exec(unsigned int vcpu_index, void *userdata)
>     g_mutex_unlock(&l2_ucache_locks[cache_idx]);
> }
> 
>-static void vcpu_tb_trans(struct qemu_plugin_tb *tb)
>+static void vcpu_tb_trans(struct qemu_plugin_tb *tb, void *userdata)
> {
>     size_t n_insns;
>     size_t i;
>@@ -844,7 +844,7 @@ int qemu_plugin_install(qemu_plugin_id_t id, const qemu_info_t *info,
>     l1_icache_locks = g_new0(GMutex, cores);
>     l2_ucache_locks = use_l2 ? g_new0(GMutex, cores) : NULL;
> 
>-    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
>+    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans, NULL);
>     qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
> 
>     miss_ht = g_hash_table_new_full(g_int64_hash, g_int64_equal, NULL, insn_free);
>diff --git a/contrib/plugins/cflow.c b/contrib/plugins/cflow.c
>index 9a850c8c0cc..319a7a7fc07 100644
>--- a/contrib/plugins/cflow.c
>+++ b/contrib/plugins/cflow.c
>@@ -297,7 +297,7 @@ static void vcpu_tb_branched_exec(unsigned int cpu_index, void *udata)
>  * instructions for their execution.
>  *
>  */
>-static void vcpu_tb_trans(struct qemu_plugin_tb *tb)
>+static void vcpu_tb_trans(struct qemu_plugin_tb *tb, void *userdata)
> {
>     uint64_t pc = qemu_plugin_tb_vaddr(tb);
>     size_t insns = qemu_plugin_tb_n_insns(tb);
>@@ -387,7 +387,7 @@ int qemu_plugin_install(qemu_plugin_id_t id, const qemu_info_t *info,
> 
>     plugin_init();
> 
>-    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
>+    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans, NULL);
>     qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
>     return 0;
> }
>diff --git a/contrib/plugins/cpp.cpp b/contrib/plugins/cpp.cpp
>index 34243cc922f..a0bb261fbe8 100644
>--- a/contrib/plugins/cpp.cpp
>+++ b/contrib/plugins/cpp.cpp
>@@ -363,7 +363,7 @@
> 
> QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
> 
>-static void vcpu_tb_trans(struct qemu_plugin_tb *tb)
>+static void vcpu_tb_trans(struct qemu_plugin_tb *tb, void *userdata)
> {
> }
> 
>@@ -371,6 +371,6 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
>                                            const qemu_info_t *info,
>                                            int argc, char **argv)
> {
>-    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
>+    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans, NULL);
>     return 0;
> }
>diff --git a/contrib/plugins/drcov.c b/contrib/plugins/drcov.c
>index 2dc08512d44..5a18a8f48b4 100644
>--- a/contrib/plugins/drcov.c
>+++ b/contrib/plugins/drcov.c
>@@ -119,7 +119,7 @@ static void vcpu_tb_exec(unsigned int cpu_index, void *udata)
>     g_mutex_unlock(&lock);
> }
> 
>-static void vcpu_tb_trans(struct qemu_plugin_tb *tb)
>+static void vcpu_tb_trans(struct qemu_plugin_tb *tb, void *userdata)
> {
>     uint64_t pc = qemu_plugin_tb_vaddr(tb);
>     size_t n = qemu_plugin_tb_n_insns(tb);
>@@ -156,7 +156,7 @@ int qemu_plugin_install(qemu_plugin_id_t id, const qemu_info_t *info,
> 
>     plugin_init();
> 
>-    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
>+    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans, NULL);
>     qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
> 
>     return 0;
>diff --git a/contrib/plugins/execlog.c b/contrib/plugins/execlog.c
>index 8329112305c..74325495cce 100644
>--- a/contrib/plugins/execlog.c
>+++ b/contrib/plugins/execlog.c
>@@ -177,7 +177,7 @@ static void vcpu_insn_exec(unsigned int cpu_index, void *udata)
>  * QEMU convert code by translation block (TB). By hooking here we can then hook
>  * a callback on each instruction and memory access.
>  */
>-static void vcpu_tb_trans(struct qemu_plugin_tb *tb)
>+static void vcpu_tb_trans(struct qemu_plugin_tb *tb, void *userdata)
> {
>     struct qemu_plugin_insn *insn;
>     bool skip = (imatches || amatches);
>@@ -482,7 +482,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
> 
>     /* Register init, translation block and exit callbacks */
>     qemu_plugin_register_vcpu_init_cb(id, vcpu_init, NULL);
>-    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
>+    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans, NULL);
>     qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
> 
>     return 0;
>diff --git a/contrib/plugins/hotblocks.c b/contrib/plugins/hotblocks.c
>index 682b160019a..ea746b513a1 100644
>--- a/contrib/plugins/hotblocks.c
>+++ b/contrib/plugins/hotblocks.c
>@@ -121,7 +121,7 @@ static void vcpu_tb_exec(unsigned int cpu_index, void *udata)
>  * Otherwise a helper is inserted which calls the vcpu_tb_exec
>  * callback.
>  */
>-static void vcpu_tb_trans(struct qemu_plugin_tb *tb)
>+static void vcpu_tb_trans(struct qemu_plugin_tb *tb, void *userdata)
> {
>     ExecCount *cnt;
>     uint64_t pc = qemu_plugin_tb_vaddr(tb);
>@@ -186,7 +186,7 @@ int qemu_plugin_install(qemu_plugin_id_t id, const qemu_info_t *info,
> 
>     plugin_init();
> 
>-    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
>+    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans, NULL);
>     qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
>     return 0;
> }
>diff --git a/contrib/plugins/hotpages.c b/contrib/plugins/hotpages.c
>index d8321a73303..56e5698ce1d 100644
>--- a/contrib/plugins/hotpages.c
>+++ b/contrib/plugins/hotpages.c
>@@ -148,7 +148,7 @@ static void vcpu_haddr(unsigned int cpu_index, qemu_plugin_meminfo_t meminfo,
>     g_mutex_unlock(&lock);
> }
> 
>-static void vcpu_tb_trans(struct qemu_plugin_tb *tb)
>+static void vcpu_tb_trans(struct qemu_plugin_tb *tb, void *userdata)
> {
>     size_t n = qemu_plugin_tb_n_insns(tb);
>     size_t i;
>@@ -197,7 +197,7 @@ int qemu_plugin_install(qemu_plugin_id_t id, const qemu_info_t *info,
> 
>     plugin_init();
> 
>-    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
>+    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans, NULL);
>     qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
>     return 0;
> }
>diff --git a/contrib/plugins/howvec.c b/contrib/plugins/howvec.c
>index feabc10bf44..55db9ff8028 100644
>--- a/contrib/plugins/howvec.c
>+++ b/contrib/plugins/howvec.c
>@@ -310,7 +310,7 @@ static struct qemu_plugin_scoreboard *find_counter(
>     return NULL;
> }
> 
>-static void vcpu_tb_trans(struct qemu_plugin_tb *tb)
>+static void vcpu_tb_trans(struct qemu_plugin_tb *tb, void *userdata)
> {
>     size_t n = qemu_plugin_tb_n_insns(tb);
>     size_t i;
>@@ -392,7 +392,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
> 
>     plugin_init();
> 
>-    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
>+    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans, NULL);
>     qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
>     return 0;
> }
>diff --git a/contrib/plugins/hwprofile.c b/contrib/plugins/hwprofile.c
>index fcc993015d7..87b0267ffe3 100644
>--- a/contrib/plugins/hwprofile.c
>+++ b/contrib/plugins/hwprofile.c
>@@ -242,7 +242,7 @@ static void vcpu_haddr(unsigned int cpu_index, qemu_plugin_meminfo_t meminfo,
>     }
> }
> 
>-static void vcpu_tb_trans(struct qemu_plugin_tb *tb)
>+static void vcpu_tb_trans(struct qemu_plugin_tb *tb, void *userdata)
> {
>     size_t n = qemu_plugin_tb_n_insns(tb);
>     size_t i;
>@@ -319,7 +319,7 @@ int qemu_plugin_install(qemu_plugin_id_t id, const qemu_info_t *info,
> 
>     plugin_init();
> 
>-    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
>+    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans, NULL);
>     qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
>     return 0;
> }
>diff --git a/contrib/plugins/ips.c b/contrib/plugins/ips.c
>index a1fcba7c5d6..6f7ac1587ec 100644
>--- a/contrib/plugins/ips.c
>+++ b/contrib/plugins/ips.c
>@@ -110,7 +110,7 @@ static void every_quantum_insn(unsigned int cpu_index, void *udata)
>     update_system_time(vcpu);
> }
> 
>-static void vcpu_tb_trans(struct qemu_plugin_tb *tb)
>+static void vcpu_tb_trans(struct qemu_plugin_tb *tb, void *userdata)
> {
>     size_t n_insns = qemu_plugin_tb_n_insns(tb);
>     qemu_plugin_u64 quantum_insn =
>@@ -206,7 +206,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
>     time_handle = qemu_plugin_request_time_control();
>     g_assert(time_handle);
> 
>-    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
>+    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans, NULL);
>     qemu_plugin_register_vcpu_init_cb(id, vcpu_init, NULL);
>     qemu_plugin_register_vcpu_exit_cb(id, vcpu_exit, NULL);
>     qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
>diff --git a/contrib/plugins/lockstep.c b/contrib/plugins/lockstep.c
>index dc527ad56e2..ed9d18460fe 100644
>--- a/contrib/plugins/lockstep.c
>+++ b/contrib/plugins/lockstep.c
>@@ -249,7 +249,7 @@ static void vcpu_tb_exec(unsigned int cpu_index, void *udata)
>     log = g_slist_prepend(log, exec);
> }
> 
>-static void vcpu_tb_trans(struct qemu_plugin_tb *tb)
>+static void vcpu_tb_trans(struct qemu_plugin_tb *tb, void *userdata)
> {
>     BlockInfo *bi = g_new0(BlockInfo, 1);
>     bi->pc = qemu_plugin_tb_vaddr(tb);
>@@ -392,7 +392,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
> 
>     our_id = id;
> 
>-    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
>+    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans, NULL);
>     qemu_plugin_register_atexit_cb(id, plugin_exit, (void *)id);
>     return 0;
> }
>diff --git a/contrib/plugins/stoptrigger.c b/contrib/plugins/stoptrigger.c
>index 222a3f92ae0..3babd014171 100644
>--- a/contrib/plugins/stoptrigger.c
>+++ b/contrib/plugins/stoptrigger.c
>@@ -64,7 +64,7 @@ static void exit_address_reached(unsigned int cpu_index, void *udata)
>     exit_emulation(ei->exit_code, msg);
> }
> 
>-static void vcpu_tb_trans(struct qemu_plugin_tb *tb)
>+static void vcpu_tb_trans(struct qemu_plugin_tb *tb, void *userdata)
> {
>     size_t tb_n = qemu_plugin_tb_n_insns(tb);
>     for (size_t i = 0; i < tb_n; i++) {
>@@ -150,7 +150,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
>     }
> 
>     /* Register translation block and exit callbacks */
>-    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
>+    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans, NULL);
>     qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
> 
>     return 0;
>diff --git a/contrib/plugins/uftrace.c b/contrib/plugins/uftrace.c
>index a1b10f9cf59..9b0a4963aee 100644
>--- a/contrib/plugins/uftrace.c
>+++ b/contrib/plugins/uftrace.c
>@@ -838,7 +838,7 @@ static void track_callstack(unsigned int cpu_index, void *udata)
>     trace_enter_stack(t, cs, timestamp);
> }
> 
>-static void vcpu_tb_trans(struct qemu_plugin_tb *tb)
>+static void vcpu_tb_trans(struct qemu_plugin_tb *tb, void *userdata)
> {
>     size_t n_insns = qemu_plugin_tb_n_insns(tb);
>     uintptr_t tb_pc = qemu_plugin_tb_vaddr(tb);
>@@ -987,7 +987,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
>     score = qemu_plugin_scoreboard_new(sizeof(Cpu));
>     qemu_plugin_register_vcpu_init_cb(id, vcpu_init, NULL);
>     qemu_plugin_register_atexit_cb(id, at_exit, (void *) info->system_emulation);
>-    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
>+    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans, NULL);
> 
>     return 0;
> }
>diff --git a/include/plugins/qemu-plugin.h b/include/plugins/qemu-plugin.h
>index 8242e054054..53daa09fc72 100644
>--- a/include/plugins/qemu-plugin.h
>+++ b/include/plugins/qemu-plugin.h
>@@ -418,13 +418,16 @@ enum qemu_plugin_cond {
> /**
>  * typedef qemu_plugin_vcpu_tb_trans_cb_t - translation callback
>  * @tb: opaque handle used for querying and instrumenting a block.
>+ * @userdata: any plugin data to pass to the @cb
>  */
>-typedef void (*qemu_plugin_vcpu_tb_trans_cb_t)(struct qemu_plugin_tb *tb);
>+typedef void (*qemu_plugin_vcpu_tb_trans_cb_t)(struct qemu_plugin_tb *tb,
>+                                               void *userdata);
> 
> /**
>  * qemu_plugin_register_vcpu_tb_trans_cb() - register a translate cb
>  * @id: plugin ID
>  * @cb: callback function
>+ * @userdata: any plugin data to pass to the @cb
>  *
>  * The @cb function is called every time a translation occurs. The @cb
>  * function is passed an opaque qemu_plugin_type which it can query
>@@ -435,7 +438,8 @@ typedef void (*qemu_plugin_vcpu_tb_trans_cb_t)(struct qemu_plugin_tb *tb);
>  */
> QEMU_PLUGIN_API
> void qemu_plugin_register_vcpu_tb_trans_cb(qemu_plugin_id_t id,
>-                                           qemu_plugin_vcpu_tb_trans_cb_t cb);
>+                                           qemu_plugin_vcpu_tb_trans_cb_t cb,
>+                                           void *userdata);
> 
> /**
>  * qemu_plugin_register_vcpu_tb_exec_cb() - register execution callback
>diff --git a/plugins/api.c b/plugins/api.c
>index 849790fe13b..774b1b80214 100644
>--- a/plugins/api.c
>+++ b/plugins/api.c
>@@ -195,9 +195,10 @@ void qemu_plugin_register_vcpu_mem_inline_per_vcpu(
> }
> 
> void qemu_plugin_register_vcpu_tb_trans_cb(qemu_plugin_id_t id,
>-                                           qemu_plugin_vcpu_tb_trans_cb_t cb)
>+                                           qemu_plugin_vcpu_tb_trans_cb_t cb,
>+                                           void *userdata)
> {
>-    plugin_register_cb(id, QEMU_PLUGIN_EV_VCPU_TB_TRANS, cb);
>+    plugin_register_cb_udata(id, QEMU_PLUGIN_EV_VCPU_TB_TRANS, cb, userdata);
> }
> 
> void qemu_plugin_register_vcpu_syscall_cb(qemu_plugin_id_t id,
>diff --git a/plugins/core.c b/plugins/core.c
>index c77da4d36fd..d891da93040 100644
>--- a/plugins/core.c
>+++ b/plugins/core.c
>@@ -487,7 +487,7 @@ void qemu_plugin_tb_trans_cb(CPUState *cpu, struct qemu_plugin_tb *tb)
>         qemu_plugin_vcpu_tb_trans_cb_t func = cb->f.vcpu_tb_trans;
> 
>         qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS);
>-        func(tb);
>+        func(tb, cb->udata);
>         qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_NO_REGS);
>     }
> }
>diff --git a/tests/tcg/plugins/bb.c b/tests/tcg/plugins/bb.c
>index 713063f4945..90adb3ebd97 100644
>--- a/tests/tcg/plugins/bb.c
>+++ b/tests/tcg/plugins/bb.c
>@@ -77,7 +77,7 @@ static void vcpu_tb_exec(unsigned int cpu_index, void *udata)
>     count->bb_count++;
> }
> 
>-static void vcpu_tb_trans(struct qemu_plugin_tb *tb)
>+static void vcpu_tb_trans(struct qemu_plugin_tb *tb, void *userdata)
> {
>     size_t n_insns = qemu_plugin_tb_n_insns(tb);
> 
>@@ -127,7 +127,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
>         qemu_plugin_register_vcpu_idle_cb(id, vcpu_idle, NULL);
>     }
> 
>-    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
>+    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans, NULL);
>     qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
>     return 0;
> }
>diff --git a/tests/tcg/plugins/discons.c b/tests/tcg/plugins/discons.c
>index d2a163a5714..45f24397047 100644
>--- a/tests/tcg/plugins/discons.c
>+++ b/tests/tcg/plugins/discons.c
>@@ -147,7 +147,7 @@ static void insn_exec(unsigned int vcpu_index, void *userdata)
>     }
> }
> 
>-static void vcpu_tb_trans(struct qemu_plugin_tb *tb)
>+static void vcpu_tb_trans(struct qemu_plugin_tb *tb, void *userdata)
> {
>     size_t n_insns = qemu_plugin_tb_n_insns(tb);
>     for (size_t i = 0; i < n_insns; i++) {
>@@ -215,7 +215,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
> 
>     qemu_plugin_register_vcpu_discon_cb(id, QEMU_PLUGIN_DISCON_ALL,
>                                         vcpu_discon, NULL);
>-    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
>+    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans, NULL);
> 
>     return 0;
> }
>diff --git a/tests/tcg/plugins/empty.c b/tests/tcg/plugins/empty.c
>index 5927507c18e..286b3035e61 100644
>--- a/tests/tcg/plugins/empty.c
>+++ b/tests/tcg/plugins/empty.c
>@@ -20,13 +20,13 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
>  * This allows us to measure the overhead of injecting and then
>  * removing empty instrumentation.
>  */
>-static void vcpu_tb_trans(struct qemu_plugin_tb *tb)
>+static void vcpu_tb_trans(struct qemu_plugin_tb *tb, void *userdata)
> { }
> 
> QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
>                                            const qemu_info_t *info,
>                                            int argc, char **argv)
> {
>-    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
>+    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans, NULL);
>     return 0;
> }
>diff --git a/tests/tcg/plugins/inline.c b/tests/tcg/plugins/inline.c
>index 3f5c49f5ede..436223db0e6 100644
>--- a/tests/tcg/plugins/inline.c
>+++ b/tests/tcg/plugins/inline.c
>@@ -223,7 +223,7 @@ static void vcpu_mem_access(unsigned int cpu_index,
>     g_mutex_unlock(&mem_lock);
> }
> 
>-static void vcpu_tb_trans(struct qemu_plugin_tb *tb)
>+static void vcpu_tb_trans(struct qemu_plugin_tb *tb, void *userdata)
> {
>     void *tb_store = tb;
>     qemu_plugin_register_vcpu_tb_exec_inline_per_vcpu(
>@@ -303,7 +303,7 @@ int qemu_plugin_install(qemu_plugin_id_t id, const qemu_info_t *info,
>     data_tb = qemu_plugin_scoreboard_u64_in_struct(data, CPUData, data_tb);
>     data_mem = qemu_plugin_scoreboard_u64_in_struct(data, CPUData, data_mem);
> 
>-    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
>+    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans, NULL);
>     qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
> 
>     return 0;
>diff --git a/tests/tcg/plugins/insn.c b/tests/tcg/plugins/insn.c
>index a303275ea1b..4ab30d6df8c 100644
>--- a/tests/tcg/plugins/insn.c
>+++ b/tests/tcg/plugins/insn.c
>@@ -138,7 +138,7 @@ static void vcpu_insn_matched_exec_before(unsigned int cpu_index, void *udata)
>     }
> }
> 
>-static void vcpu_tb_trans(struct qemu_plugin_tb *tb)
>+static void vcpu_tb_trans(struct qemu_plugin_tb *tb, void *userdata)
> {
>     size_t n = qemu_plugin_tb_n_insns(tb);
>     size_t i;
>@@ -297,7 +297,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
> 
>     /* Register init, translation block and exit callbacks */
>     qemu_plugin_register_vcpu_init_cb(id, vcpu_init, NULL);
>-    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
>+    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans, NULL);
>     qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
>     return 0;
> }
>diff --git a/tests/tcg/plugins/mem.c b/tests/tcg/plugins/mem.c
>index 24a3bce0bfd..e56d10574bd 100644
>--- a/tests/tcg/plugins/mem.c
>+++ b/tests/tcg/plugins/mem.c
>@@ -266,7 +266,7 @@ static void print_access(unsigned int cpu_index, qemu_plugin_meminfo_t meminfo,
>     qemu_plugin_outs(out->str);
> }
> 
>-static void vcpu_tb_trans(struct qemu_plugin_tb *tb)
>+static void vcpu_tb_trans(struct qemu_plugin_tb *tb, void *userdata)
> {
>     size_t n = qemu_plugin_tb_n_insns(tb);
>     size_t i;
>@@ -374,7 +374,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
>     mem_count = qemu_plugin_scoreboard_u64_in_struct(
>         counts, CPUCount, mem_count);
>     io_count = qemu_plugin_scoreboard_u64_in_struct(counts, CPUCount, io_count);
>-    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
>+    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans, NULL);
>     qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
>     return 0;
> }
>diff --git a/tests/tcg/plugins/patch.c b/tests/tcg/plugins/patch.c
>index 8fcf0bd409b..59215f8546e 100644
>--- a/tests/tcg/plugins/patch.c
>+++ b/tests/tcg/plugins/patch.c
>@@ -130,7 +130,7 @@ static void patch_vaddr(unsigned int vcpu_index, void *userdata)
> /*
>  * Callback on translation of a translation block.
>  */
>-static void vcpu_tb_trans_cb(struct qemu_plugin_tb *tb)
>+static void vcpu_tb_trans_cb(struct qemu_plugin_tb *tb, void *userdata)
> {
>     g_autoptr(GByteArray) insn_data = g_byte_array_new();
>     uintptr_t addr = 0;
>@@ -245,7 +245,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
>         return -1;
>     }
> 
>-    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans_cb);
>+    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans_cb, NULL);
> 
>     return 0;
> }
>diff --git a/tests/tcg/plugins/reset.c b/tests/tcg/plugins/reset.c
>index 1fdf114e5e0..949f2d6160a 100644
>--- a/tests/tcg/plugins/reset.c
>+++ b/tests/tcg/plugins/reset.c
>@@ -27,7 +27,7 @@ static void tb_exec_after_reset(unsigned int vcpu_index, void *userdata)
>     qemu_plugin_uninstall(plugin_id, after_uninstall, NULL);
> }
> 
>-static void tb_trans_after_reset(struct qemu_plugin_tb *tb)
>+static void tb_trans_after_reset(struct qemu_plugin_tb *tb, void *userdata)
> {
>     g_assert(was_reset && !was_uninstalled);
>     qemu_plugin_register_vcpu_tb_exec_cb(tb, tb_exec_after_reset,
>@@ -40,7 +40,7 @@ static void after_reset(void *userdata)
>     g_assert(!was_reset && !was_uninstalled);
>     qemu_plugin_outs("reset done\n");
>     was_reset = true;
>-    qemu_plugin_register_vcpu_tb_trans_cb(id, tb_trans_after_reset);
>+    qemu_plugin_register_vcpu_tb_trans_cb(id, tb_trans_after_reset, NULL);
> }
> 
> static void tb_exec_before_reset(unsigned int vcpu_index, void *userdata)
>@@ -49,7 +49,7 @@ static void tb_exec_before_reset(unsigned int vcpu_index, void *userdata)
>     qemu_plugin_reset(plugin_id, after_reset, (void *) plugin_id);
> }
> 
>-static void tb_trans_before_reset(struct qemu_plugin_tb *tb)
>+static void tb_trans_before_reset(struct qemu_plugin_tb *tb, void *userdata)
> {
>     g_assert(!was_reset && !was_uninstalled);
>     qemu_plugin_register_vcpu_tb_exec_cb(tb, tb_exec_before_reset,
>@@ -61,7 +61,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
>                                            int argc, char **argv)
> {
>     plugin_id = id;
>-    qemu_plugin_register_vcpu_tb_trans_cb(id, tb_trans_before_reset);
>+    qemu_plugin_register_vcpu_tb_trans_cb(id, tb_trans_before_reset, NULL);
>     return 0;
> }
> 
>diff --git a/tests/tcg/plugins/setpc.c b/tests/tcg/plugins/setpc.c
>index 44cea064783..595571cdfd9 100644
>--- a/tests/tcg/plugins/setpc.c
>+++ b/tests/tcg/plugins/setpc.c
>@@ -73,7 +73,7 @@ static void vcpu_mem_access(unsigned int vcpu_index,
>     }
> }
> 
>-static void vcpu_tb_trans(struct qemu_plugin_tb *tb)
>+static void vcpu_tb_trans(struct qemu_plugin_tb *tb, void *userdata)
> {
>     size_t insns = qemu_plugin_tb_n_insns(tb);
>     for (size_t i = 0; i < insns; i++) {
>@@ -100,6 +100,6 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
> {
> 
>     qemu_plugin_register_vcpu_syscall_filter_cb(id, vcpu_syscall_filter);
>-    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
>+    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans, NULL);
>     return 0;
> }
>-- 
>2.43.0
>
>

