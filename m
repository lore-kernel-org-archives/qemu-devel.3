Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F8F4CD8C9D
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 05:21:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXXqn-0006CK-2C; Thu, 11 Jun 2026 01:21:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wXXql-0006C8-L4
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 01:21:07 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wXXqj-0003R4-7K
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 01:21:07 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-490b8ac62baso3588555e9.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 22:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781155263; x=1781760063; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=01DAW95LvOH3genkoXdGOqFg51quu/ydwHbrTHefL7M=;
 b=jbGl6JCwu3j7g3zZ7rJoLMagY0gTB12PooyRyqv/R3UImTu5jwXELIRf5/YydGRSSE
 EeAhB4xe7E+lFfjaCCa6YpCodPQVc/9RnP3TRaXAaGihsmO5G33Ze4GuAmgpBOcB3r4u
 pgzTJlvQ/d1mQhl6R+1sYemmSuFueeDmNpswo2isdDPyVVw7lZ4UmAZ0yuRkd4GVyF4M
 LGa/i0TH832kIrVUET1sWcy7FXrr0PRvBwF0Gz7zqkFpcgGz1m2O6jcY4eUsDt6K0bJw
 U4cHDu3WSF/S06dJbEWbK4KrQy0mBYByaYWAPibuNvfv2oOpogIluIZZgKKtcgRhFOcG
 I7og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781155263; x=1781760063;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=01DAW95LvOH3genkoXdGOqFg51quu/ydwHbrTHefL7M=;
 b=LBvRSq5qGqS9SnS2CWhbvP2hFALYEbARZbnrZs7lc1k/kdfDOr940P4FDDc4h/hHzA
 NULhW8H6rhqlRmYLEOLXpIrRVIoS5+5c9zrivuTu1LzmL3Ium0i34jOq1K+sv3C6XoVK
 bxmPT1wyGvJRc9IEYA0bH9NiQUkCbgVuoFYXWs1HDMi/yxkmvr6QW742W8Qht4D2gU9S
 VKYaBtXnFQeUhtq4LcH4omwKQzXal5JvhkxH2l/7ZwMwvXMBTJR7K99X9I3rsujbdwg8
 RnxebJpF/aiPWmLDPYkc7CMoDeLcrapxZ+kE1Xoi8NuPwW3521nVnYs5/bU/n40BOGef
 Fenw==
X-Gm-Message-State: AOJu0YwdoyXPb2wY2XVqWH4N0qtOoZ6i/8IZwaSp8KUt93SMlgMGErKv
 /BYmvw41DMtBYErAmegUDjq3MzOOVW0hrZlTdJ5/KNxISafbhR/yn/c+YgapkTSHSqpe7LaN89a
 ODEaaLJI=
X-Gm-Gg: Acq92OEyXdrT6lfgBFkxSJ/w6zhJKXudfKipH/HIRXo4lu51UU/Aotypokf0OHekezt
 /jq96Gf9HJXPmWDx/HmPJg1e03eKnkHRnVdwaWBn7RuuhT09RpHFj5DmJ6iTaDAmxk35qRD6prq
 x3OogMySYz0kMzyHDrO0B4E2gj+tO85/0868qXbZvM9S+RHWldMKQbBflaBM/tENullqVdMvgJX
 we1/AUlf+3Bi0zD+NDFNZMU6/VzdLrwiMKNvDo2eW6O5RLH/5VnG+fxfDS2tndLmRpmFBP9M4DI
 0G1EtEwWgpi1fK9WTqyhjIkXDDlKCQXJSz9BmrjyGV4N5pfabpy22lKiv7rjpGY8aZef+7WpbPD
 Ca0tOQ+2PSBIRqTtDRS8PAeah7uWIaeYO0zevdU1xmZ8EDVPoncI/kr7EvXS7Ub4H9hxmxOaXfu
 a0EkMDwlA3bNVG+H+1VSFoVahQvYBXvvylU2LRdeaxFfVO6VT5MQQr/I2z1k+Fc6w4yX6BHRDCa
 LENXZLT2BD/T2lgBb0V1Iv3CWiaxKRk2xbXDSpevSayZ80i9j6LkR74lyzF3Z8rUukkPrHp
X-Received: by 2002:a05:600c:1d05:b0:490:4b89:5372 with SMTP id
 5b1f17b1804b1-490e52fd47bmr9766635e9.11.1781155263193; 
 Wed, 10 Jun 2026 22:21:03 -0700 (PDT)
Received: from meli-email.org (ppp-2-86-135-61.home.otenet.gr. [2.86.135.61])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490e52acba3sm19089155e9.6.2026.06.10.22.21.02
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 10 Jun 2026 22:21:02 -0700 (PDT)
Date: Thu, 11 Jun 2026 08:19:06 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: Chao Liu <chao.liu.zevorn@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 Alex Benn=?UTF-8?B?w6k=?=e <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Alexandre Iooss <erdnaxe@crans.org>
Subject: Re: [PATCH 07/25] plugins: add userdata to
 qemu_plugin_register_vcpu_init_cb
User-Agent: meli/0.8.13
References: <20260603205152.1440291-1-pierrick.bouvier@oss.qualcomm.com>
 <20260603205152.1440291-8-pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <20260603205152.1440291-8-pierrick.bouvier@oss.qualcomm.com>
Message-ID: <tggc72.124075qhyf1jo@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x333.google.com
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
> contrib/plugins/bbv.c         |  4 ++--
> contrib/plugins/execlog.c     |  4 ++--
> contrib/plugins/ips.c         |  4 ++--
> contrib/plugins/uftrace.c     |  4 ++--
> include/plugins/qemu-plugin.h |  4 +++-
> plugins/api.c                 |  5 +++--
> plugins/core.c                | 26 +++++++++++++++++++++++---
> tests/tcg/plugins/insn.c      |  4 ++--
> tests/tcg/plugins/registers.c |  4 ++--
> 9 files changed, 41 insertions(+), 18 deletions(-)
>
>diff --git a/contrib/plugins/bbv.c b/contrib/plugins/bbv.c
>index 72cc896a0a6..0ad1301a1de 100644
>--- a/contrib/plugins/bbv.c
>+++ b/contrib/plugins/bbv.c
>@@ -60,7 +60,7 @@ static qemu_plugin_u64 bb_count_u64(Bb *bb)
>     return qemu_plugin_scoreboard_u64(bb->count);
> }
> 
>-static void vcpu_init(unsigned int vcpu_index)
>+static void vcpu_init(unsigned int vcpu_index, void *userdata)
> {
>     g_autofree gchar *vcpu_filename = NULL;
>     Vcpu *vcpu = qemu_plugin_scoreboard_find(vcpus, vcpu_index);
>@@ -156,7 +156,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
>     bbs = g_hash_table_new_full(g_int64_hash, g_int64_equal, NULL, free_bb);
>     vcpus = qemu_plugin_scoreboard_new(sizeof(Vcpu));
>     qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
>-    qemu_plugin_register_vcpu_init_cb(id, vcpu_init);
>+    qemu_plugin_register_vcpu_init_cb(id, vcpu_init, NULL);
>     qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
> 
>     return 0;
>diff --git a/contrib/plugins/execlog.c b/contrib/plugins/execlog.c
>index 398aa4a1f3f..2d02816a184 100644
>--- a/contrib/plugins/execlog.c
>+++ b/contrib/plugins/execlog.c
>@@ -382,7 +382,7 @@ static GPtrArray *registers_init(int vcpu_index)
>  * As we could have multiple threads trying to do this we need to
>  * serialise the expansion under a lock.
>  */
>-static void vcpu_init(unsigned int vcpu_index)
>+static void vcpu_init(unsigned int vcpu_index, void *userdata)
> {
>     CPU *c;
> 
>@@ -481,7 +481,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
>     }
> 
>     /* Register init, translation block and exit callbacks */
>-    qemu_plugin_register_vcpu_init_cb(id, vcpu_init);
>+    qemu_plugin_register_vcpu_init_cb(id, vcpu_init, NULL);
>     qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
>     qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
> 
>diff --git a/contrib/plugins/ips.c b/contrib/plugins/ips.c
>index 32fd86c87ac..1290a624489 100644
>--- a/contrib/plugins/ips.c
>+++ b/contrib/plugins/ips.c
>@@ -89,7 +89,7 @@ static void update_system_time(vCPUTime *vcpu)
>     g_mutex_unlock(&global_state_lock);
> }
> 
>-static void vcpu_init(unsigned int cpu_index)
>+static void vcpu_init(unsigned int cpu_index, void *userdata)
> {
>     vCPUTime *vcpu = qemu_plugin_scoreboard_find(vcpus, cpu_index);
>     vcpu->total_insn = 0;
>@@ -207,7 +207,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
>     g_assert(time_handle);
> 
>     qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
>-    qemu_plugin_register_vcpu_init_cb(id, vcpu_init);
>+    qemu_plugin_register_vcpu_init_cb(id, vcpu_init, NULL);
>     qemu_plugin_register_vcpu_exit_cb(id, vcpu_exit);
>     qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
> 
>diff --git a/contrib/plugins/uftrace.c b/contrib/plugins/uftrace.c
>index 438cebf2831..8be8409dce2 100644
>--- a/contrib/plugins/uftrace.c
>+++ b/contrib/plugins/uftrace.c
>@@ -874,7 +874,7 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
>     }
> }
> 
>-static void vcpu_init(unsigned int vcpu_index)
>+static void vcpu_init(unsigned int vcpu_index, void *userdata)
> {
>     Cpu *cpu = qemu_plugin_scoreboard_find(score, vcpu_index);
>     cpu->ops = arch_ops;
>@@ -985,7 +985,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
>     }
> 
>     score = qemu_plugin_scoreboard_new(sizeof(Cpu));
>-    qemu_plugin_register_vcpu_init_cb(id, vcpu_init);
>+    qemu_plugin_register_vcpu_init_cb(id, vcpu_init, NULL);
>     qemu_plugin_register_atexit_cb(id, at_exit, (void *) info->system_emulation);
>     qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
> 
>diff --git a/include/plugins/qemu-plugin.h b/include/plugins/qemu-plugin.h
>index 8aaf404504b..bb4569a2291 100644
>--- a/include/plugins/qemu-plugin.h
>+++ b/include/plugins/qemu-plugin.h
>@@ -242,6 +242,7 @@ void qemu_plugin_reset(qemu_plugin_id_t id, qemu_plugin_udata_cb_t cb,
>  * qemu_plugin_register_vcpu_init_cb() - register a vCPU initialization callback
>  * @id: plugin ID
>  * @cb: callback function
>+ * @userdata: any plugin data to pass to the @cb
>  *
>  * The @cb function is called every time a vCPU is initialized.
>  *
>@@ -249,7 +250,8 @@ void qemu_plugin_reset(qemu_plugin_id_t id, qemu_plugin_udata_cb_t cb,
>  */
> QEMU_PLUGIN_API
> void qemu_plugin_register_vcpu_init_cb(qemu_plugin_id_t id,
>-                                       qemu_plugin_vcpu_simple_cb_t cb);
>+                                       qemu_plugin_vcpu_udata_cb_t cb,
>+                                       void *userdata);
> 
> /**
>  * qemu_plugin_register_vcpu_exit_cb() - register a vCPU exit callback
>diff --git a/plugins/api.c b/plugins/api.c
>index 91c9a24a6b2..68b564bb9c2 100644
>--- a/plugins/api.c
>+++ b/plugins/api.c
>@@ -71,9 +71,10 @@ void qemu_plugin_reset(qemu_plugin_id_t id, qemu_plugin_udata_cb_t cb,
>  */
> 
> void qemu_plugin_register_vcpu_init_cb(qemu_plugin_id_t id,
>-                                       qemu_plugin_vcpu_simple_cb_t cb)
>+                                       qemu_plugin_vcpu_udata_cb_t cb,
>+                                       void *userdata)
> {
>-    plugin_register_cb(id, QEMU_PLUGIN_EV_VCPU_INIT, cb);
>+    plugin_register_cb_udata(id, QEMU_PLUGIN_EV_VCPU_INIT, cb, userdata);
> }
> 
> void qemu_plugin_register_vcpu_exit_cb(qemu_plugin_id_t id,
>diff --git a/plugins/core.c b/plugins/core.c
>index 217d6608c1d..1d5692b3f41 100644
>--- a/plugins/core.c
>+++ b/plugins/core.c
>@@ -89,7 +89,6 @@ static void plugin_vcpu_cb__simple(CPUState *cpu, enum qemu_plugin_event ev)
>     struct qemu_plugin_cb *cb, *next;
> 
>     switch (ev) {
>-    case QEMU_PLUGIN_EV_VCPU_INIT:
>     case QEMU_PLUGIN_EV_VCPU_EXIT:
>     case QEMU_PLUGIN_EV_VCPU_IDLE:
>     case QEMU_PLUGIN_EV_VCPU_RESUME:
>@@ -104,6 +103,28 @@ static void plugin_vcpu_cb__simple(CPUState *cpu, enum qemu_plugin_event ev)
>     }
> }
> 
>+/*
>+ * Disable CFI checks.
>+ * The callback function has been loaded from an external library so we do not
>+ * have type information
>+ */
>+QEMU_DISABLE_CFI
>+static void plugin_vcpu_cb__udata(CPUState *cpu, enum qemu_plugin_event ev)
>+{
>+    struct qemu_plugin_cb *cb, *next;
>+
>+    switch (ev) {
>+    case QEMU_PLUGIN_EV_VCPU_INIT:
>+        QLIST_FOREACH_SAFE_RCU(cb, &plugin.cb_lists[ev], entry, next) {
>+            qemu_plugin_vcpu_udata_cb_t func = cb->f.vcpu_udata;
>+            func(cpu->cpu_index, cb->udata);
>+        }
>+        break;
>+    default:
>+        g_assert_not_reached();
>+    }
>+}
>+
> /*
>  * Disable CFI checks.
>  * The callback function has been loaded from an external library so we do not
>@@ -145,7 +166,6 @@ static void plugin_cb__udata(enum qemu_plugin_event ev)
>     case QEMU_PLUGIN_EV_FLUSH:
>         QLIST_FOREACH_SAFE_RCU(cb, &plugin.cb_lists[ev], entry, next) {
>             qemu_plugin_udata_cb_t func = cb->f.udata;
>-

Accidental or something missing?

LGTM though:

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>


>             func(cb->udata);
>         }
>         break;
>@@ -271,7 +291,7 @@ static void qemu_plugin_vcpu_init__async(CPUState *cpu, run_on_cpu_data unused)
>     qemu_rec_mutex_unlock(&plugin.lock);
> 
>     qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS);
>-    plugin_vcpu_cb__simple(cpu, QEMU_PLUGIN_EV_VCPU_INIT);
>+    plugin_vcpu_cb__udata(cpu, QEMU_PLUGIN_EV_VCPU_INIT);
>     qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_NO_REGS);
> }
> 
>diff --git a/tests/tcg/plugins/insn.c b/tests/tcg/plugins/insn.c
>index 80f7cbb2967..d9f94888d6f 100644
>--- a/tests/tcg/plugins/insn.c
>+++ b/tests/tcg/plugins/insn.c
>@@ -84,7 +84,7 @@ static Instruction * get_insn_record(const char *disas, uint64_t vaddr, Match *m
> /*
>  * Initialise a new vcpu with reading the register list
>  */
>-static void vcpu_init(unsigned int vcpu_index)
>+static void vcpu_init(unsigned int vcpu_index, void *userdata)
> {
>     g_autoptr(GArray) reg_list = qemu_plugin_get_registers();
>     g_autoptr(GByteArray) reg_value = g_byte_array_new();
>@@ -296,7 +296,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
>         qemu_plugin_scoreboard_new(sizeof(uint64_t)));
> 
>     /* Register init, translation block and exit callbacks */
>-    qemu_plugin_register_vcpu_init_cb(id, vcpu_init);
>+    qemu_plugin_register_vcpu_init_cb(id, vcpu_init, NULL);
>     qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
>     qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
>     return 0;
>diff --git a/tests/tcg/plugins/registers.c b/tests/tcg/plugins/registers.c
>index 94776d887fe..0e41734435f 100644
>--- a/tests/tcg/plugins/registers.c
>+++ b/tests/tcg/plugins/registers.c
>@@ -21,7 +21,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
>  * registers that cannot be written to, which would fail the test.
>  * See: https://lists.gnu.org/archive/html/qemu-devel/2026-02/msg07025.html
>  */
>-static void vcpu_init_cb(unsigned int vcpu_index)
>+static void vcpu_init_cb(unsigned int vcpu_index, void *userdata)
> {
>     g_autoptr(GArray) regs = qemu_plugin_get_registers();
>     g_assert(regs != NULL);
>@@ -74,6 +74,6 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
>                                            const qemu_info_t *info,
>                                            int argc, char **argv)
> {
>-    qemu_plugin_register_vcpu_init_cb(id, vcpu_init_cb);
>+    qemu_plugin_register_vcpu_init_cb(id, vcpu_init_cb, NULL);
>     return 0;
> }
>-- 
>2.43.0
>
>

