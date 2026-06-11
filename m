Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5940ACD8CB2
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 05:57:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXYPh-0005ex-SG; Thu, 11 Jun 2026 01:57:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wXYPW-0005eY-Gw
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 01:57:02 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wXYPT-0004HJ-SX
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 01:57:02 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-490b3e03939so4050905e9.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 22:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781157418; x=1781762218; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=xLqQqMRD2/bSeNrGESUubzPc12bOU3WwBnXrT9eV7OM=;
 b=BHd4QWUnv7Iqg3zvLJdpeBvtgA55Ao9tgkaHPAzl1MMHJXoi/8kOOYzo0Jpax3TKfR
 EnnpB81J4h/W0GA4bXwqC9YVliDMZrZBOuq5dISn/iyAnWb8Q6qCoZpJXB0NA/0Xn5Lb
 fxHjUMtFhUIXyv4YY2Jo5D3m5DGCuqWeSItKiv7c4Ui1Am5lUHAUVnfRSXig5sXcj9/6
 Z/OR5quLyHGvVUWHKkyDCHiPboq86MbLbkZQ69ego+WqeNj9nRIpPRSuiqrIMVWL1+la
 nzsmARsyv89LUeuWx/ilWBkRJgtEJZLmFdOm8ddl3g4+OLdp8hktJffSD4iHUx4lkUNh
 hqBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781157418; x=1781762218;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xLqQqMRD2/bSeNrGESUubzPc12bOU3WwBnXrT9eV7OM=;
 b=iGBEN7ANmmenU9tEximH/b7RZ3husjE63RxhFwTWQyOCcY0gI9laO8E/tu52xQyxW7
 kIs2HnPCmjNpxcLG3azqn4UrbrhtlYt11CL4LrPy2QrRXe0b3woJBXuA9d1Fn81HBkP0
 NDrqQzRrCLsHAJh0H6nTyu3b/ovKmRfUZmqsgVP6lGRuSAKe8CJtHSE4iuUuG5VXQ8jx
 OccLUsxL4mPxfA757f8/4CvmtmsMsS0ha+pZzqXbujgsU218FxzRtTbpJeeQmXMRKAh8
 P4KkImo05YDeg7mMDSjrLbeT/5IPt5n56u5LSoQYjcz4f1AhZfdl3MQbynx5tOwUkgen
 8X5A==
X-Gm-Message-State: AOJu0Yx2WXGThDSP70cjSqrKCAup5kPAgnoAfpVyyo+YtHHiG+3yQveA
 aJDNfS+wE13O5BHXl4pQgi0DF/F809ZjMc6iq/fDlS325fGNlmNSdBzhGLKNPIPevoXprc6rcAz
 TbEIj1KI=
X-Gm-Gg: Acq92OGeJwHJxkwmRnPvGGjNPQ5CSHXEp9lbm89CdT9ytnoeV1Mbfn0+PXJXXdfIMKh
 /bsPGnB7LSY+JpFR4Km92RfZmdpuX7oT+ALqFxHkg+D6G1Luy82BQ2nLO17Bdes+eWhDJWA4PQH
 GFfQQM5b0yhI7gr5qm1Pt/Xbeo7dWSwxl7W+kpfmebmoXXpgS4JBxypJQPF3aPIDgA00CTxbI5V
 ypWyUpndivIEj7fZo+6tJfHmzNNnFQ+N0g4sCtww4v/Vo4r/W8Or6KIoeEH9IcR7WkWNwZytpjc
 V6Y+n6noOrxyL1myQtyEH3hvnWa6tT0dBJZZ6Ymf9QnsYe+Nl8fXSMecv7kJPKz/YJ7Gf81ol9d
 W3JtFdfPtLQippU2Tw4EtkMnjduSOmhw1qmyIdxLkeoKH+hKBRnruapBH4yPdlVooHlws5siXnu
 IQ00zRUxLgm1QhOGs3+qbwFC2NLh4pfBILmVOCozoHVXwJzGAX5kIEqz5rwTi7Mu4gLJmumap3p
 sEC5XKJxID/wNOReMl58kvisR6IxNWK/iMo5HQRnUeL9Ivs+Up9MUATurTQ7LkRCfIFzBD6
X-Received: by 2002:a05:600c:c490:b0:490:3cf0:8d81 with SMTP id
 5b1f17b1804b1-490e5302fb2mr11166845e9.13.1781157417895; 
 Wed, 10 Jun 2026 22:56:57 -0700 (PDT)
Received: from meli-email.org (ppp-2-86-135-61.home.otenet.gr. [2.86.135.61])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490e2ca21f4sm36778155e9.7.2026.06.10.22.56.57
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 10 Jun 2026 22:56:57 -0700 (PDT)
Date: Thu, 11 Jun 2026 08:55:47 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: Chao Liu <chao.liu.zevorn@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 Alex Benn=?UTF-8?B?w6k=?=e <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Alexandre Iooss <erdnaxe@crans.org>
Subject: Re: [PATCH 15/25] plugins: remove qemu_plugin_id from
 qemu_plugin_vcpu_tb_trans_cb_t
User-Agent: meli/0.8.13
References: <20260603205152.1440291-1-pierrick.bouvier@oss.qualcomm.com>
 <20260603205152.1440291-16-pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <20260603205152.1440291-16-pierrick.bouvier@oss.qualcomm.com>
Message-ID: <tggduw.1izhhvc1x07sz@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x330.google.com
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

> contrib/plugins/bbv.c         | 2 +-
> contrib/plugins/cache.c       | 2 +-
> contrib/plugins/cflow.c       | 2 +-
> contrib/plugins/cpp.cpp       | 2 +-
> contrib/plugins/drcov.c       | 2 +-
> contrib/plugins/execlog.c     | 2 +-
> contrib/plugins/hotblocks.c   | 2 +-
> contrib/plugins/hotpages.c    | 2 +-
> contrib/plugins/howvec.c      | 2 +-
> contrib/plugins/hwprofile.c   | 2 +-
> contrib/plugins/ips.c         | 2 +-
> contrib/plugins/lockstep.c    | 2 +-
> contrib/plugins/stoptrigger.c | 2 +-
> contrib/plugins/uftrace.c     | 2 +-
> include/plugins/qemu-plugin.h | 4 +---
> plugins/core.c                | 2 +-
> tests/tcg/plugins/bb.c        | 2 +-
> tests/tcg/plugins/discons.c   | 2 +-
> tests/tcg/plugins/empty.c     | 2 +-
> tests/tcg/plugins/inline.c    | 2 +-
> tests/tcg/plugins/insn.c      | 2 +-
> tests/tcg/plugins/mem.c       | 2 +-
> tests/tcg/plugins/patch.c     | 2 +-
> tests/tcg/plugins/reset.c     | 4 ++--
> tests/tcg/plugins/setpc.c     | 2 +-
> 25 files changed, 26 insertions(+), 28 deletions(-)
>
>diff --git a/contrib/plugins/bbv.c b/contrib/plugins/bbv.c
>index 0ad1301a1de..7e9e72477d7 100644
>--- a/contrib/plugins/bbv.c
>+++ b/contrib/plugins/bbv.c
>@@ -102,7 +102,7 @@ static void vcpu_interval_exec(unsigned int vcpu_index, void *udata)
>     fputc('\n', vcpu->file);
> }
> 
>-static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
>+static void vcpu_tb_trans(struct qemu_plugin_tb *tb)
> {
>     uint64_t n_insns = qemu_plugin_tb_n_insns(tb);
>     uint64_t vaddr = qemu_plugin_tb_vaddr(tb);
>diff --git a/contrib/plugins/cache.c b/contrib/plugins/cache.c
>index f41ddb0aa43..c9d61de26c9 100644
>--- a/contrib/plugins/cache.c
>+++ b/contrib/plugins/cache.c
>@@ -462,7 +462,7 @@ static void vcpu_insn_exec(unsigned int vcpu_index, void *userdata)
>     g_mutex_unlock(&l2_ucache_locks[cache_idx]);
> }
> 
>-static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
>+static void vcpu_tb_trans(struct qemu_plugin_tb *tb)
> {
>     size_t n_insns;
>     size_t i;
>diff --git a/contrib/plugins/cflow.c b/contrib/plugins/cflow.c
>index 4d00879ccad..9a850c8c0cc 100644
>--- a/contrib/plugins/cflow.c
>+++ b/contrib/plugins/cflow.c
>@@ -297,7 +297,7 @@ static void vcpu_tb_branched_exec(unsigned int cpu_index, void *udata)
>  * instructions for their execution.
>  *
>  */
>-static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
>+static void vcpu_tb_trans(struct qemu_plugin_tb *tb)
> {
>     uint64_t pc = qemu_plugin_tb_vaddr(tb);
>     size_t insns = qemu_plugin_tb_n_insns(tb);
>diff --git a/contrib/plugins/cpp.cpp b/contrib/plugins/cpp.cpp
>index 0673c4f074d..34243cc922f 100644
>--- a/contrib/plugins/cpp.cpp
>+++ b/contrib/plugins/cpp.cpp
>@@ -363,7 +363,7 @@
> 
> QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
> 
>-static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
>+static void vcpu_tb_trans(struct qemu_plugin_tb *tb)
> {
> }
> 
>diff --git a/contrib/plugins/drcov.c b/contrib/plugins/drcov.c
>index 458c0d2084d..2dc08512d44 100644
>--- a/contrib/plugins/drcov.c
>+++ b/contrib/plugins/drcov.c
>@@ -119,7 +119,7 @@ static void vcpu_tb_exec(unsigned int cpu_index, void *udata)
>     g_mutex_unlock(&lock);
> }
> 
>-static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
>+static void vcpu_tb_trans(struct qemu_plugin_tb *tb)
> {
>     uint64_t pc = qemu_plugin_tb_vaddr(tb);
>     size_t n = qemu_plugin_tb_n_insns(tb);
>diff --git a/contrib/plugins/execlog.c b/contrib/plugins/execlog.c
>index 2d02816a184..8329112305c 100644
>--- a/contrib/plugins/execlog.c
>+++ b/contrib/plugins/execlog.c
>@@ -177,7 +177,7 @@ static void vcpu_insn_exec(unsigned int cpu_index, void *udata)
>  * QEMU convert code by translation block (TB). By hooking here we can then hook
>  * a callback on each instruction and memory access.
>  */
>-static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
>+static void vcpu_tb_trans(struct qemu_plugin_tb *tb)
> {
>     struct qemu_plugin_insn *insn;
>     bool skip = (imatches || amatches);
>diff --git a/contrib/plugins/hotblocks.c b/contrib/plugins/hotblocks.c
>index 92859872ac9..682b160019a 100644
>--- a/contrib/plugins/hotblocks.c
>+++ b/contrib/plugins/hotblocks.c
>@@ -121,7 +121,7 @@ static void vcpu_tb_exec(unsigned int cpu_index, void *udata)
>  * Otherwise a helper is inserted which calls the vcpu_tb_exec
>  * callback.
>  */
>-static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
>+static void vcpu_tb_trans(struct qemu_plugin_tb *tb)
> {
>     ExecCount *cnt;
>     uint64_t pc = qemu_plugin_tb_vaddr(tb);
>diff --git a/contrib/plugins/hotpages.c b/contrib/plugins/hotpages.c
>index a6d83b06c75..d8321a73303 100644
>--- a/contrib/plugins/hotpages.c
>+++ b/contrib/plugins/hotpages.c
>@@ -148,7 +148,7 @@ static void vcpu_haddr(unsigned int cpu_index, qemu_plugin_meminfo_t meminfo,
>     g_mutex_unlock(&lock);
> }
> 
>-static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
>+static void vcpu_tb_trans(struct qemu_plugin_tb *tb)
> {
>     size_t n = qemu_plugin_tb_n_insns(tb);
>     size_t i;
>diff --git a/contrib/plugins/howvec.c b/contrib/plugins/howvec.c
>index 75728896198..feabc10bf44 100644
>--- a/contrib/plugins/howvec.c
>+++ b/contrib/plugins/howvec.c
>@@ -310,7 +310,7 @@ static struct qemu_plugin_scoreboard *find_counter(
>     return NULL;
> }
> 
>-static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
>+static void vcpu_tb_trans(struct qemu_plugin_tb *tb)
> {
>     size_t n = qemu_plugin_tb_n_insns(tb);
>     size_t i;
>diff --git a/contrib/plugins/hwprofile.c b/contrib/plugins/hwprofile.c
>index b7f96117e94..fcc993015d7 100644
>--- a/contrib/plugins/hwprofile.c
>+++ b/contrib/plugins/hwprofile.c
>@@ -242,7 +242,7 @@ static void vcpu_haddr(unsigned int cpu_index, qemu_plugin_meminfo_t meminfo,
>     }
> }
> 
>-static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
>+static void vcpu_tb_trans(struct qemu_plugin_tb *tb)
> {
>     size_t n = qemu_plugin_tb_n_insns(tb);
>     size_t i;
>diff --git a/contrib/plugins/ips.c b/contrib/plugins/ips.c
>index 2c110906731..a1fcba7c5d6 100644
>--- a/contrib/plugins/ips.c
>+++ b/contrib/plugins/ips.c
>@@ -110,7 +110,7 @@ static void every_quantum_insn(unsigned int cpu_index, void *udata)
>     update_system_time(vcpu);
> }
> 
>-static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
>+static void vcpu_tb_trans(struct qemu_plugin_tb *tb)
> {
>     size_t n_insns = qemu_plugin_tb_n_insns(tb);
>     qemu_plugin_u64 quantum_insn =
>diff --git a/contrib/plugins/lockstep.c b/contrib/plugins/lockstep.c
>index c1c2b0aca8e..dc527ad56e2 100644
>--- a/contrib/plugins/lockstep.c
>+++ b/contrib/plugins/lockstep.c
>@@ -249,7 +249,7 @@ static void vcpu_tb_exec(unsigned int cpu_index, void *udata)
>     log = g_slist_prepend(log, exec);
> }
> 
>-static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
>+static void vcpu_tb_trans(struct qemu_plugin_tb *tb)
> {
>     BlockInfo *bi = g_new0(BlockInfo, 1);
>     bi->pc = qemu_plugin_tb_vaddr(tb);
>diff --git a/contrib/plugins/stoptrigger.c b/contrib/plugins/stoptrigger.c
>index 40f8fd313d7..222a3f92ae0 100644
>--- a/contrib/plugins/stoptrigger.c
>+++ b/contrib/plugins/stoptrigger.c
>@@ -64,7 +64,7 @@ static void exit_address_reached(unsigned int cpu_index, void *udata)
>     exit_emulation(ei->exit_code, msg);
> }
> 
>-static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
>+static void vcpu_tb_trans(struct qemu_plugin_tb *tb)
> {
>     size_t tb_n = qemu_plugin_tb_n_insns(tb);
>     for (size_t i = 0; i < tb_n; i++) {
>diff --git a/contrib/plugins/uftrace.c b/contrib/plugins/uftrace.c
>index 8be8409dce2..a1b10f9cf59 100644
>--- a/contrib/plugins/uftrace.c
>+++ b/contrib/plugins/uftrace.c
>@@ -838,7 +838,7 @@ static void track_callstack(unsigned int cpu_index, void *udata)
>     trace_enter_stack(t, cs, timestamp);
> }
> 
>-static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
>+static void vcpu_tb_trans(struct qemu_plugin_tb *tb)
> {
>     size_t n_insns = qemu_plugin_tb_n_insns(tb);
>     uintptr_t tb_pc = qemu_plugin_tb_vaddr(tb);
>diff --git a/include/plugins/qemu-plugin.h b/include/plugins/qemu-plugin.h
>index 60d27d8d9c1..8242e054054 100644
>--- a/include/plugins/qemu-plugin.h
>+++ b/include/plugins/qemu-plugin.h
>@@ -417,11 +417,9 @@ enum qemu_plugin_cond {
> 
> /**
>  * typedef qemu_plugin_vcpu_tb_trans_cb_t - translation callback
>- * @id: unique plugin id
>  * @tb: opaque handle used for querying and instrumenting a block.
>  */
>-typedef void (*qemu_plugin_vcpu_tb_trans_cb_t)(qemu_plugin_id_t id,
>-                                               struct qemu_plugin_tb *tb);
>+typedef void (*qemu_plugin_vcpu_tb_trans_cb_t)(struct qemu_plugin_tb *tb);
> 
> /**
>  * qemu_plugin_register_vcpu_tb_trans_cb() - register a translate cb
>diff --git a/plugins/core.c b/plugins/core.c
>index 3c3212aedda..c77da4d36fd 100644
>--- a/plugins/core.c
>+++ b/plugins/core.c
>@@ -487,7 +487,7 @@ void qemu_plugin_tb_trans_cb(CPUState *cpu, struct qemu_plugin_tb *tb)
>         qemu_plugin_vcpu_tb_trans_cb_t func = cb->f.vcpu_tb_trans;
> 
>         qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS);
>-        func(cb->ctx->id, tb);
>+        func(tb);
>         qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_NO_REGS);
>     }
> }
>diff --git a/tests/tcg/plugins/bb.c b/tests/tcg/plugins/bb.c
>index ba605246eb0..713063f4945 100644
>--- a/tests/tcg/plugins/bb.c
>+++ b/tests/tcg/plugins/bb.c
>@@ -77,7 +77,7 @@ static void vcpu_tb_exec(unsigned int cpu_index, void *udata)
>     count->bb_count++;
> }
> 
>-static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
>+static void vcpu_tb_trans(struct qemu_plugin_tb *tb)
> {
>     size_t n_insns = qemu_plugin_tb_n_insns(tb);
> 
>diff --git a/tests/tcg/plugins/discons.c b/tests/tcg/plugins/discons.c
>index 5ab645705e3..d2a163a5714 100644
>--- a/tests/tcg/plugins/discons.c
>+++ b/tests/tcg/plugins/discons.c
>@@ -147,7 +147,7 @@ static void insn_exec(unsigned int vcpu_index, void *userdata)
>     }
> }
> 
>-static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
>+static void vcpu_tb_trans(struct qemu_plugin_tb *tb)
> {
>     size_t n_insns = qemu_plugin_tb_n_insns(tb);
>     for (size_t i = 0; i < n_insns; i++) {
>diff --git a/tests/tcg/plugins/empty.c b/tests/tcg/plugins/empty.c
>index 8fa6bacd93d..5927507c18e 100644
>--- a/tests/tcg/plugins/empty.c
>+++ b/tests/tcg/plugins/empty.c
>@@ -20,7 +20,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
>  * This allows us to measure the overhead of injecting and then
>  * removing empty instrumentation.
>  */
>-static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
>+static void vcpu_tb_trans(struct qemu_plugin_tb *tb)
> { }
> 
> QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
>diff --git a/tests/tcg/plugins/inline.c b/tests/tcg/plugins/inline.c
>index 1d17884b40b..3f5c49f5ede 100644
>--- a/tests/tcg/plugins/inline.c
>+++ b/tests/tcg/plugins/inline.c
>@@ -223,7 +223,7 @@ static void vcpu_mem_access(unsigned int cpu_index,
>     g_mutex_unlock(&mem_lock);
> }
> 
>-static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
>+static void vcpu_tb_trans(struct qemu_plugin_tb *tb)
> {
>     void *tb_store = tb;
>     qemu_plugin_register_vcpu_tb_exec_inline_per_vcpu(
>diff --git a/tests/tcg/plugins/insn.c b/tests/tcg/plugins/insn.c
>index d9f94888d6f..a303275ea1b 100644
>--- a/tests/tcg/plugins/insn.c
>+++ b/tests/tcg/plugins/insn.c
>@@ -138,7 +138,7 @@ static void vcpu_insn_matched_exec_before(unsigned int cpu_index, void *udata)
>     }
> }
> 
>-static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
>+static void vcpu_tb_trans(struct qemu_plugin_tb *tb)
> {
>     size_t n = qemu_plugin_tb_n_insns(tb);
>     size_t i;
>diff --git a/tests/tcg/plugins/mem.c b/tests/tcg/plugins/mem.c
>index 5cdf71c7e49..24a3bce0bfd 100644
>--- a/tests/tcg/plugins/mem.c
>+++ b/tests/tcg/plugins/mem.c
>@@ -266,7 +266,7 @@ static void print_access(unsigned int cpu_index, qemu_plugin_meminfo_t meminfo,
>     qemu_plugin_outs(out->str);
> }
> 
>-static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
>+static void vcpu_tb_trans(struct qemu_plugin_tb *tb)
> {
>     size_t n = qemu_plugin_tb_n_insns(tb);
>     size_t i;
>diff --git a/tests/tcg/plugins/patch.c b/tests/tcg/plugins/patch.c
>index eba2f8b8d6c..8fcf0bd409b 100644
>--- a/tests/tcg/plugins/patch.c
>+++ b/tests/tcg/plugins/patch.c
>@@ -130,7 +130,7 @@ static void patch_vaddr(unsigned int vcpu_index, void *userdata)
> /*
>  * Callback on translation of a translation block.
>  */
>-static void vcpu_tb_trans_cb(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
>+static void vcpu_tb_trans_cb(struct qemu_plugin_tb *tb)
> {
>     g_autoptr(GByteArray) insn_data = g_byte_array_new();
>     uintptr_t addr = 0;
>diff --git a/tests/tcg/plugins/reset.c b/tests/tcg/plugins/reset.c
>index ef5a32781b2..1fdf114e5e0 100644
>--- a/tests/tcg/plugins/reset.c
>+++ b/tests/tcg/plugins/reset.c
>@@ -27,7 +27,7 @@ static void tb_exec_after_reset(unsigned int vcpu_index, void *userdata)
>     qemu_plugin_uninstall(plugin_id, after_uninstall, NULL);
> }
> 
>-static void tb_trans_after_reset(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
>+static void tb_trans_after_reset(struct qemu_plugin_tb *tb)
> {
>     g_assert(was_reset && !was_uninstalled);
>     qemu_plugin_register_vcpu_tb_exec_cb(tb, tb_exec_after_reset,
>@@ -49,7 +49,7 @@ static void tb_exec_before_reset(unsigned int vcpu_index, void *userdata)
>     qemu_plugin_reset(plugin_id, after_reset, (void *) plugin_id);
> }
> 
>-static void tb_trans_before_reset(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
>+static void tb_trans_before_reset(struct qemu_plugin_tb *tb)
> {
>     g_assert(!was_reset && !was_uninstalled);
>     qemu_plugin_register_vcpu_tb_exec_cb(tb, tb_exec_before_reset,
>diff --git a/tests/tcg/plugins/setpc.c b/tests/tcg/plugins/setpc.c
>index 8f2d025e245..44cea064783 100644
>--- a/tests/tcg/plugins/setpc.c
>+++ b/tests/tcg/plugins/setpc.c
>@@ -73,7 +73,7 @@ static void vcpu_mem_access(unsigned int vcpu_index,
>     }
> }
> 
>-static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
>+static void vcpu_tb_trans(struct qemu_plugin_tb *tb)
> {
>     size_t insns = qemu_plugin_tb_n_insns(tb);
>     for (size_t i = 0; i < insns; i++) {
>-- 
>2.43.0
>
>

