Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E44F5CD8CB2
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 05:37:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXY6H-0007XM-S3; Thu, 11 Jun 2026 01:37:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wXY5u-0007Pi-Aw
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 01:36:52 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wXY5s-00040a-5J
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 01:36:45 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-490d1e54b3bso38196105e9.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 22:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781156203; x=1781761003; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=VYriRdI8gGcARhs9G7c1L5CxCIbmb2Xycq7KfDFxQEQ=;
 b=JA1QcnZ023uuZb7eiCUt5BYLBD6ySiqmFUuDlnHb3u31QnBR5ZdYk0huqPbEokQtsC
 q583zgtcEJ1CIyuCm/4VuGfeT9GVwXEbApbpd1vf8rv7w0cDxSemmEtN3kkB7e40D7W4
 M5POD3J/BW0jpMG9uYKcCzH6azxHlejQti8y2OYOTdeW0Yb+PFRhRIE4Vrk5IvdVBR7J
 j4cx7CDrshPEMkDF7SBIGR6h3IT7I7hS0SZtYChmuI1uZID0w2WYyM8fK0qvvfUp4dC/
 174WSIampPKg00c/WG/JXFWUPviFf2oVFI+M+Bu3koRswy+CRXAoWQniQ3ljNAi6sVyd
 EjQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781156203; x=1781761003;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VYriRdI8gGcARhs9G7c1L5CxCIbmb2Xycq7KfDFxQEQ=;
 b=gHrqv4wO2tBPq5RM7OJdE6YXg40VTmcrl3IS9vAinPkaI1SPEjFBYaImGuGT9ca3Fm
 bu+V+eMghF3sNVg821zUoUwYx/oGz1AQetatR5ZyIa8F35W2NOvEm5nW9tIa3K79pqdA
 7URq3LtY6VyB5leK0x6tlZuY2z3gh3qu8xqZ8gEP27ANkHDtvkW4eKUZp3NAXyHQA1U6
 WF6gJwUYRW+rQdLO68RkG3PPPfVK67bh5kWqqG0Znf05YvXGOMJnQnE920qo1vQmqHsH
 8CNa9YyUI17XKSDP9Q6oozmLuIwa/m1fRVf+2fMBkBzrHqwWXtC3/Kh/w9By8LJePFUH
 d55w==
X-Gm-Message-State: AOJu0Yxz2m+Y60ZspQQjiIsNAIB4yBLpQOprb9lIo9m06vvcoT64URje
 CLbwBHzy2vn2mA9MXForZHek0PGYe5DbkkCVHEgjhgEf7wAW1MbItdhVPtR3zlh+iN+sUP+lkNP
 UwB/5boI=
X-Gm-Gg: Acq92OEFJoELWtjeNUk600q79VtrRDNm6qQb4ph9+pyU4PfVY4i5LEMuGIKYQQh7Ci6
 Say/PozIhMQkH/r5TBZgVtPqJiwYjvHWDyvIaBHoeE/dVG+OfdSx4bFOsbiPcV6bSnhYDggfcai
 bJorldNo/gnP6/WSJeSZKoaAuumDvWjA/hgAKTUcq1RubargjzhZDFs1ia8bm51qtkbyEpCqkAg
 dvA4nQ7iwIrNGmrivhh02n5lZA/oLxUenFOOnj5UmHK3KpcEup+wGIjUXGSAyPaM+NuVOo0C3SU
 vkrpFpxTqrDwCMEPLoX4Waq/sLm6uVywmDDUIQUlYw37vLcpZZjiFY06MDUdaAkdhQP+6fb1ERv
 UzcbJeuO19GNUpNJ5NMBlmOkyEsyYCyfq6VSJn/u6lLUnFgdpkVwuvdc/8N1Kan9IwmywYXm3fB
 bfQzXpsAV7WagO1PsJ1MtKKLGS81NkwnkKruG8iuUj75zgsxMurnugWQAzKHpx9cgQXp00tp7gO
 QuMvVyGcAEHIoM7aHCKlM3LV9KoUSUDbwCNGpLI9DYfdICIqXHLW6F2qCX6EtOS9oCnM8ve
X-Received: by 2002:a05:600c:8a0d:10b0:490:a1be:6b01 with SMTP id
 5b1f17b1804b1-490e55c9e26mr7359305e9.4.1781156202594; 
 Wed, 10 Jun 2026 22:36:42 -0700 (PDT)
Received: from meli-email.org (ppp-2-86-135-61.home.otenet.gr. [2.86.135.61])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490e2c7ea21sm35900905e9.1.2026.06.10.22.36.42
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 10 Jun 2026 22:36:42 -0700 (PDT)
Date: Thu, 11 Jun 2026 08:35:53 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: Chao Liu <chao.liu.zevorn@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 Alex Benn=?UTF-8?B?w6k=?=e <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Alexandre Iooss <erdnaxe@crans.org>
Subject: Re: [PATCH 13/25] plugins: add userdata to
 qemu_plugin_register_vcpu_discon_cb
User-Agent: meli/0.8.13
References: <20260603205152.1440291-1-pierrick.bouvier@oss.qualcomm.com>
 <20260603205152.1440291-14-pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <20260603205152.1440291-14-pierrick.bouvier@oss.qualcomm.com>
Message-ID: <tggcx5.2q9slcfxy9hlr@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x331.google.com
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

> contrib/plugins/traps.c       |  5 +++--
> include/plugins/qemu-plugin.h |  8 ++++++--
> plugins/core.c                | 12 ++++++------
> tests/tcg/plugins/discons.c   |  4 ++--
> 4 files changed, 17 insertions(+), 12 deletions(-)
>
>diff --git a/contrib/plugins/traps.c b/contrib/plugins/traps.c
>index 4b879a8212a..4d59aa3c09d 100644
>--- a/contrib/plugins/traps.c
>+++ b/contrib/plugins/traps.c
>@@ -25,7 +25,7 @@ static struct qemu_plugin_scoreboard *traps;
> 
> static void vcpu_discon(qemu_plugin_id_t id, unsigned int vcpu_index,
>                         enum qemu_plugin_discon_type type, uint64_t from_pc,
>-                        uint64_t to_pc)
>+                        uint64_t to_pc, void *userdata)
> {
>     TrapCounters *rec = qemu_plugin_scoreboard_find(traps, vcpu_index);
>     switch (type) {
>@@ -75,7 +75,8 @@ int qemu_plugin_install(qemu_plugin_id_t id, const qemu_info_t *info,
>     traps = qemu_plugin_scoreboard_new(sizeof(TrapCounters));
> 
>     qemu_plugin_register_vcpu_discon_cb(id, QEMU_PLUGIN_DISCON_ALL,
>-                                        vcpu_discon);
>+                                        vcpu_discon,
>+                                        NULL);
> 
>     qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
> 
>diff --git a/include/plugins/qemu-plugin.h b/include/plugins/qemu-plugin.h
>index cf937c60ee7..03e7b2b1fb8 100644
>--- a/include/plugins/qemu-plugin.h
>+++ b/include/plugins/qemu-plugin.h
>@@ -186,6 +186,7 @@ enum qemu_plugin_discon_type {
>  * @from_pc: the source of the discontinuity, e.g. the PC before the
>  *           transition
>  * @to_pc: the PC pointing to the next instruction to be executed
>+ * @userdata: any plugin data to pass to the @cb
>  *
>  * The exact semantics of @from_pc depends on the @type of discontinuity. For
>  * interrupts, @from_pc will point to the next instruction which would have
>@@ -198,7 +199,8 @@ enum qemu_plugin_discon_type {
> typedef void (*qemu_plugin_vcpu_discon_cb_t)(qemu_plugin_id_t id,
>                                              unsigned int vcpu_index,
>                                              enum qemu_plugin_discon_type type,
>-                                             uint64_t from_pc, uint64_t to_pc);
>+                                             uint64_t from_pc, uint64_t to_pc,
>+                                             void *userdata);
> 
> /**
>  * qemu_plugin_uninstall() - Uninstall a plugin
>@@ -293,6 +295,7 @@ void qemu_plugin_register_vcpu_resume_cb(qemu_plugin_id_t id,
>  * @id: plugin ID
>  * @type: types of discontinuities for which to call the callback
>  * @cb: callback function
>+ * @userdata: any plugin data to pass to the @cb
>  *
>  * The @cb function is called every time a vCPU receives a discontinuity event
>  * of the specified type(s), after the vCPU was prepared to handle the event.
>@@ -302,7 +305,8 @@ void qemu_plugin_register_vcpu_resume_cb(qemu_plugin_id_t id,
> QEMU_PLUGIN_API
> void qemu_plugin_register_vcpu_discon_cb(qemu_plugin_id_t id,
>                                          enum qemu_plugin_discon_type type,
>-                                         qemu_plugin_vcpu_discon_cb_t cb);
>+                                         qemu_plugin_vcpu_discon_cb_t cb,
>+                                         void *userdata);
> 
> /** struct qemu_plugin_tb - Opaque handle for a translation block */
> struct qemu_plugin_tb;
>diff --git a/plugins/core.c b/plugins/core.c
>index a5aac1062aa..54ab3bdbedc 100644
>--- a/plugins/core.c
>+++ b/plugins/core.c
>@@ -122,8 +122,7 @@ static void plugin_vcpu_cb__discon(CPUState *cpu,
>         /* iterate safely; plugins might uninstall themselves at any time */
>         QLIST_FOREACH_SAFE_RCU(cb, &plugin.cb_lists[ev], entry, next) {
>             qemu_plugin_vcpu_discon_cb_t func = cb->f.vcpu_discon;
>-
>-            func(cb->ctx->id, cpu->cpu_index, type, from, to);
>+            func(cb->ctx->id, cpu->cpu_index, type, from, to, cb->udata);
>         }
>     }
>     qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_NO_REGS);
>@@ -655,16 +654,17 @@ void qemu_plugin_register_vcpu_resume_cb(qemu_plugin_id_t id,
> 
> void qemu_plugin_register_vcpu_discon_cb(qemu_plugin_id_t id,
>                                          enum qemu_plugin_discon_type type,
>-                                         qemu_plugin_vcpu_discon_cb_t cb)
>+                                         qemu_plugin_vcpu_discon_cb_t cb,
>+                                         void *userdata)
> {
>     if (type & QEMU_PLUGIN_DISCON_INTERRUPT) {
>-        plugin_register_cb(id, QEMU_PLUGIN_EV_VCPU_INTERRUPT, cb);
>+        plugin_register_cb_udata(id, QEMU_PLUGIN_EV_VCPU_INTERRUPT, cb, userdata);
>     }
>     if (type & QEMU_PLUGIN_DISCON_EXCEPTION) {
>-        plugin_register_cb(id, QEMU_PLUGIN_EV_VCPU_EXCEPTION, cb);
>+        plugin_register_cb_udata(id, QEMU_PLUGIN_EV_VCPU_EXCEPTION, cb, userdata);
>     }
>     if (type & QEMU_PLUGIN_DISCON_HOSTCALL) {
>-        plugin_register_cb(id, QEMU_PLUGIN_EV_VCPU_HOSTCALL, cb);
>+        plugin_register_cb_udata(id, QEMU_PLUGIN_EV_VCPU_HOSTCALL, cb, userdata);
>     }
> }
> 
>diff --git a/tests/tcg/plugins/discons.c b/tests/tcg/plugins/discons.c
>index 2e0e664e823..22114830fdc 100644
>--- a/tests/tcg/plugins/discons.c
>+++ b/tests/tcg/plugins/discons.c
>@@ -98,7 +98,7 @@ static void report_mismatch(const char *pc_name, unsigned int vcpu_index,
> 
> static void vcpu_discon(qemu_plugin_id_t id, unsigned int vcpu_index,
>                         enum qemu_plugin_discon_type type, uint64_t from_pc,
>-                        uint64_t to_pc)
>+                        uint64_t to_pc, void *userdata)
> {
>     struct cpu_state *state = qemu_plugin_scoreboard_find(states, vcpu_index);
> 
>@@ -214,7 +214,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
>                                                     has_from);
> 
>     qemu_plugin_register_vcpu_discon_cb(id, QEMU_PLUGIN_DISCON_ALL,
>-                                        vcpu_discon);
>+                                        vcpu_discon, NULL);
>     qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
> 
>     return 0;
>-- 
>2.43.0
>
>

