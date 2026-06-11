Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72960CD98CF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 05:36:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXY3Y-0002oM-2W; Thu, 11 Jun 2026 01:34:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wXY3O-0002XS-MS
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 01:34:13 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wXY3N-0002zj-0G
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 01:34:10 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-490cdae130cso27089025e9.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 22:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781156046; x=1781760846; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=dOQ9Io+5rRVFfhQ6TTxM9xsHGMZl1mSwb8+LNpNYYvw=;
 b=ZIhJ0iI1C0bsRXvN84tFyKg1U6nvI4gnO6gW3CRJVe9GWbHWZaACLHbcAAuB6LNKLe
 uc+bIvvFPKQHHDkWTM7RoH3k10icVVl08T45fEI5tMLDtmaxjflpuL2WiFwvybgzwbm2
 PwveaGkGKY7wnkW6CfJnLp27Q/8zeMmqjoyAIIExaoUsxrP1oF868W2q7iLpETtAIjmO
 /dLUdaTmmK1LOx7SgWZ4rWzxokMD08VolOJfeDLWK3Tqm0d8akybNFN+y8BjpvvlfHOC
 DBH64ft95xQHhPXeDVirfLoTiHdc8i66cKl/bWqYrtlnUYHaejkepHmvh8UZbufBhDwP
 tKCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781156046; x=1781760846;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dOQ9Io+5rRVFfhQ6TTxM9xsHGMZl1mSwb8+LNpNYYvw=;
 b=N9YeBQgXI2z6vMloLoh1Xuq5WTwM8hhSfbhNUbrvcC8gMzXVhvSk+tJ1Uc40F+MUWc
 c7cSRx6JJEnfle+ftWJbmB+5o2LNr/Wrol5uPT2OKq5XAYCQWJpz9TqETQKlojPRvJFb
 RVXFOb3wcf+O9bBWsKvZeCy9JGsy42hWlfw6nmIaEPf3Z817wixwWvmusSeGBMeIhfJa
 vNlEDjoBb7ydgyfmUll33J18u93CAqyhVpWscj19V+lTMZad/GMAJzE0bf242XycUMj3
 Td/8razXhaxAJ57jzDLJYXXBS1Ci445pyd+eLkzn4SUt7W/DpLVRt4O86p609ibaX05A
 +umg==
X-Gm-Message-State: AOJu0YwW3SqL+HJ0GMavv65i4PD85S3q1LLz8c9JzvHDNI+tuaekeUK+
 ZRzvIWRzox+/ssCksNJ/JTseXXLAWCBsTxGiQBvRhSYVrv/Ksz46NIqQ8C4/OoRJx4fZK1LW7pG
 J1RcRkjs=
X-Gm-Gg: Acq92OGvfUm7LMA8TdGaKefY53SWGS4diHS4yxcgLRFt7PAumptTBZyyNFDmrhZEnyr
 oHuIuzJiGrRzPbfD8esntNBCEBetwcQ2gA1l2sXWM/hMOBiTjxOudg3kSltiF9FDQqwFqo3dQt7
 rL7rL6fIwaf7TCoh+AeVDi/m3D78pknpZ9k3qxvZKa/O+rxxugvA4FmmCREqD5ojkpgqheaucfv
 jSu4bzC1ePqLG5l6vJfXShg02rS8HMX/GfQfT5xYLzhdn+Fvm1mR/y1a1OvBXdCwGT4/gtK89ol
 2XXXId+268dKLypoQwm/RaJT2canPLaGKQORDmg/wJXnG3fryMFP8H1V7sCh2nKhk95NsR2yWH0
 8MxFzDAxn+KVlp98W7ilnc4Vz02mOf5r0eLgcpx3X1hMBOeJp+fme1zahPCyQm+9FnPA1I77aZv
 juVR5UXcv+AGO88Tvl8HXj+H+GU0WUEPpViX4WgxxxD7XRWMJDCyqXg1Kg/UeIGXyC6y39zMw85
 HoUnlfXe3QPM+Gq037amoL807dyX5RfZ2PvnEA5EIxa0saHf6WfI3jSfpkDPA==
X-Received: by 2002:a05:600c:1f90:b0:48a:75b9:b0bc with SMTP id
 5b1f17b1804b1-490e561b747mr10653125e9.29.1781156046526; 
 Wed, 10 Jun 2026 22:34:06 -0700 (PDT)
Received: from meli-email.org (ppp-2-86-135-61.home.otenet.gr. [2.86.135.61])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490e47b35ffsm18437795e9.2.2026.06.10.22.34.06
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 10 Jun 2026 22:34:06 -0700 (PDT)
Date: Thu, 11 Jun 2026 08:33:20 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: Chao Liu <chao.liu.zevorn@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 Alex Benn=?UTF-8?B?w6k=?=e <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Alexandre Iooss <erdnaxe@crans.org>
Subject: Re: [PATCH 10/25] plugins: add userdata to
 qemu_plugin_register_vcpu_resume_cb
User-Agent: meli/0.8.13
References: <20260603205152.1440291-1-pierrick.bouvier@oss.qualcomm.com>
 <20260603205152.1440291-11-pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <20260603205152.1440291-11-pierrick.bouvier@oss.qualcomm.com>
Message-ID: <tggcst.2jv53sm0l1vc6@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x334.google.com
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

> include/plugins/qemu-plugin.h |  4 +++-
> plugins/core.c                | 31 +++++--------------------------
> 2 files changed, 8 insertions(+), 27 deletions(-)
>
>diff --git a/include/plugins/qemu-plugin.h b/include/plugins/qemu-plugin.h
>index 75d2a69a3bd..8c146ea49c2 100644
>--- a/include/plugins/qemu-plugin.h
>+++ b/include/plugins/qemu-plugin.h
>@@ -285,12 +285,14 @@ void qemu_plugin_register_vcpu_idle_cb(qemu_plugin_id_t id,
>  * qemu_plugin_register_vcpu_resume_cb() - register a vCPU resume callback
>  * @id: plugin ID
>  * @cb: callback function
>+ * @userdata: any plugin data to pass to the @cb
>  *
>  * The @cb function is called every time a vCPU resumes execution.
>  */
> QEMU_PLUGIN_API
> void qemu_plugin_register_vcpu_resume_cb(qemu_plugin_id_t id,
>-                                         qemu_plugin_vcpu_simple_cb_t cb);
>+                                         qemu_plugin_vcpu_udata_cb_t cb,
>+                                         void *userdata);
> 
> /**
>  * qemu_plugin_register_vcpu_discon_cb() - register a discontinuity callback
>diff --git a/plugins/core.c b/plugins/core.c
>index 111ceeea285..aa9240fe21a 100644
>--- a/plugins/core.c
>+++ b/plugins/core.c
>@@ -78,29 +78,6 @@ void plugin_unregister_cb__locked(struct qemu_plugin_ctx *ctx,
>     }
> }
> 
>-/*
>- * Disable CFI checks.
>- * The callback function has been loaded from an external library so we do not
>- * have type information
>- */
>-QEMU_DISABLE_CFI
>-static void plugin_vcpu_cb__simple(CPUState *cpu, enum qemu_plugin_event ev)
>-{
>-    struct qemu_plugin_cb *cb, *next;
>-
>-    switch (ev) {
>-    case QEMU_PLUGIN_EV_VCPU_RESUME:
>-        /* iterate safely; plugins might uninstall themselves at any time */
>-        QLIST_FOREACH_SAFE_RCU(cb, &plugin.cb_lists[ev], entry, next) {
>-            qemu_plugin_vcpu_simple_cb_t func = cb->f.vcpu_simple;
>-            func(cpu->cpu_index);
>-        }
>-        break;
>-    default:
>-        g_assert_not_reached();
>-    }
>-}
>-
> /*
>  * Disable CFI checks.
>  * The callback function has been loaded from an external library so we do not
>@@ -114,6 +91,7 @@ static void plugin_vcpu_cb__udata(CPUState *cpu, enum qemu_plugin_event ev)
>     switch (ev) {
>     case QEMU_PLUGIN_EV_VCPU_INIT:
>     case QEMU_PLUGIN_EV_VCPU_IDLE:
>+    case QEMU_PLUGIN_EV_VCPU_RESUME:
>     case QEMU_PLUGIN_EV_VCPU_EXIT:
>         QLIST_FOREACH_SAFE_RCU(cb, &plugin.cb_lists[ev], entry, next) {
>             qemu_plugin_vcpu_udata_cb_t func = cb->f.vcpu_udata;
>@@ -635,7 +613,7 @@ void qemu_plugin_vcpu_resume_cb(CPUState *cpu)
> {
>     if (cpu->cpu_index < plugin.num_vcpus) {
>         qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS_PC);
>-        plugin_vcpu_cb__simple(cpu, QEMU_PLUGIN_EV_VCPU_RESUME);
>+        plugin_vcpu_cb__udata(cpu, QEMU_PLUGIN_EV_VCPU_RESUME);
>         qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_NO_REGS);
>     }
> }
>@@ -666,9 +644,10 @@ void qemu_plugin_register_vcpu_idle_cb(qemu_plugin_id_t id,
> }
> 
> void qemu_plugin_register_vcpu_resume_cb(qemu_plugin_id_t id,
>-                                         qemu_plugin_vcpu_simple_cb_t cb)
>+                                         qemu_plugin_vcpu_udata_cb_t cb,
>+                                         void *userdata)
> {
>-    plugin_register_cb(id, QEMU_PLUGIN_EV_VCPU_RESUME, cb);
>+    plugin_register_cb_udata(id, QEMU_PLUGIN_EV_VCPU_RESUME, cb, userdata);
> }
> 
> void qemu_plugin_register_vcpu_discon_cb(qemu_plugin_id_t id,
>-- 
>2.43.0
>
>

