Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AB2ECD1284
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Apr 2024 23:08:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsWAA-00022R-Eg; Thu, 04 Apr 2024 19:06:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rsWA6-00020U-5q
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 19:06:26 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rsWA4-0007ir-BO
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 19:06:25 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-53fbf2c42bfso1228254a12.3
 for <qemu-devel@nongnu.org>; Thu, 04 Apr 2024 16:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712271982; x=1712876782; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vf2pglGQtHQjyWIwNLhivR5j/rpAVWzFiLJardZxKs4=;
 b=jKxa3b+MAScs4AlRUaJKLI6tFY7+4GTDbRT8Ui5LPfKdjUmzdu8rlhA2ZSnusyH5Zq
 OFQDkDM2+0lP69zDUgYRvjjuP+ThQIRG5dx4h3O/7vUktIGtvms3MI+tJOg8oYg+85KJ
 UeyIW0gurAt/2AeB7zodtx1o33LBbg27ihsTN+NQEw6sdAzPx1Kxm+h7HrHFFy17ZbBu
 IWMD0eD6mnv2Tep9M+2zRhgd/2cxdg5fEpJxW7Str/wJM2sEFzaG+1oxJdZ+rFHKu0Mf
 W7XUfgM7MmZJZHtUn1LfgQXAL68k5iCOvBO5cf6h+9UInNs6kO55k8i09TWv6hEfteRp
 xcaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712271982; x=1712876782;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Vf2pglGQtHQjyWIwNLhivR5j/rpAVWzFiLJardZxKs4=;
 b=ZJiGS84TgNVKpfsDmBKQTqhypBPUKBvTlgWjpRUqYlEQ2GtqTb4FeSSxo6KsWh0Bb0
 CzdK7LOy7/+HtTjOoxZsyzA3ehc6uKeXnJRFnLda/OMMJLpj+bAMsI6oIOUvz6tX9LoP
 mWqWqxCllfwy0DkDpgSFES1VzBsJHI6oxiKc6RCz0gTKlElX950AmAGmVtLJ+Hxp0JOA
 5eKgUFVHsY36vliinyzJyUP04e16Pu3n5pPAEhEgS7Fn8b/Z6+ski4TD9dbHq36aRjVm
 NINnvgDeBDi2JEk3xXv749cs+F6h5knteBzfFwOLsRV6srQ13N16zS7xWxN1OSrqQVPm
 Nc1w==
X-Gm-Message-State: AOJu0YxoAphRWqehLHN3glE8TAXJ/408GCEGYRZyn06yg/CN4OSNINvS
 oUmXW1Et1fQ3S0l3qZ+c7uYl+SVjM50LzQ8Q7XomBjEeoEJ0c9X3uWgJZ8cR7NLffTdwzvDfPUA
 O
X-Google-Smtp-Source: AGHT+IHGAw7rgB989TL1YZdQZ8C3L1JmE0Ykw7LTkiPYnntqrwuh92MhM4+/R9aV71EHBnZo+fXNfA==
X-Received: by 2002:a17:90a:bb05:b0:2a2:f3:f52f with SMTP id
 u5-20020a17090abb0500b002a200f3f52fmr3716896pjr.43.1712271981845; 
 Thu, 04 Apr 2024 16:06:21 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 q36-20020a17090a17a700b002a2f3cfc92asm1052592pja.16.2024.04.04.16.06.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Apr 2024 16:06:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 06/21] plugins: Create TCGHelperInfo for all out-of-line
 callbacks
Date: Thu,  4 Apr 2024 13:05:56 -1000
Message-Id: <20240404230611.21231-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240404230611.21231-1-richard.henderson@linaro.org>
References: <20240404230611.21231-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52a.google.com
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

TCGHelperInfo includes the ABI for every function call.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/qemu/plugin.h |  1 +
 plugins/core.c        | 51 ++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 46 insertions(+), 6 deletions(-)

diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
index 143262dca8..793c44f1f2 100644
--- a/include/qemu/plugin.h
+++ b/include/qemu/plugin.h
@@ -92,6 +92,7 @@ struct qemu_plugin_dyn_cb {
     union {
         struct {
             union qemu_plugin_cb_sig f;
+            TCGHelperInfo *info;
         } regular;
         struct {
             qemu_plugin_u64 entry;
diff --git a/plugins/core.c b/plugins/core.c
index 837c373690..b0a2e80874 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -338,12 +338,26 @@ void plugin_register_dyn_cb__udata(GArray **arr,
                                    enum qemu_plugin_cb_flags flags,
                                    void *udata)
 {
-    struct qemu_plugin_dyn_cb *dyn_cb = plugin_get_dyn_cb(arr);
+    static TCGHelperInfo info[3] = {
+        [QEMU_PLUGIN_CB_NO_REGS].flags = TCG_CALL_NO_RWG | TCG_CALL_PLUGIN,
+        [QEMU_PLUGIN_CB_R_REGS].flags = TCG_CALL_NO_WG | TCG_CALL_PLUGIN,
+        [QEMU_PLUGIN_CB_RW_REGS].flags = TCG_CALL_PLUGIN,
+        /*
+         * Match qemu_plugin_vcpu_udata_cb_t:
+         *   void (*)(uint32_t, void *)
+         */
+        [0 ... 2].typemask = (dh_typemask(void, 0) |
+                              dh_typemask(i32, 1) |
+                              dh_typemask(ptr, 2))
+    };
 
+    struct qemu_plugin_dyn_cb *dyn_cb = plugin_get_dyn_cb(arr);
     dyn_cb->userp = udata;
-    /* Note flags are discarded as unused. */
-    dyn_cb->regular.f.vcpu_udata = cb;
     dyn_cb->type = PLUGIN_CB_REGULAR;
+    dyn_cb->regular.f.vcpu_udata = cb;
+
+    assert((unsigned)flags < ARRAY_SIZE(info));
+    dyn_cb->regular.info = &info[flags];
 }
 
 void plugin_register_vcpu_mem_cb(GArray **arr,
@@ -352,14 +366,39 @@ void plugin_register_vcpu_mem_cb(GArray **arr,
                                  enum qemu_plugin_mem_rw rw,
                                  void *udata)
 {
-    struct qemu_plugin_dyn_cb *dyn_cb;
+    /*
+     * Expect that the underlying type for enum qemu_plugin_meminfo_t
+     * is either int32_t or uint32_t, aka int or unsigned int.
+     */
+    QEMU_BUILD_BUG_ON(
+        !__builtin_types_compatible_p(qemu_plugin_meminfo_t, uint32_t) &&
+        !__builtin_types_compatible_p(qemu_plugin_meminfo_t, int32_t));
 
-    dyn_cb = plugin_get_dyn_cb(arr);
+    static TCGHelperInfo info[3] = {
+        [QEMU_PLUGIN_CB_NO_REGS].flags = TCG_CALL_NO_RWG | TCG_CALL_PLUGIN,
+        [QEMU_PLUGIN_CB_R_REGS].flags = TCG_CALL_NO_WG | TCG_CALL_PLUGIN,
+        [QEMU_PLUGIN_CB_RW_REGS].flags = TCG_CALL_PLUGIN,
+        /*
+         * Match qemu_plugin_vcpu_mem_cb_t:
+         *   void (*)(uint32_t, qemu_plugin_meminfo_t, uint64_t, void *)
+         */
+        [0 ... 2].typemask =
+            (dh_typemask(void, 0) |
+             dh_typemask(i32, 1) |
+             (__builtin_types_compatible_p(qemu_plugin_meminfo_t, uint32_t)
+              ? dh_typemask(i32, 2) : dh_typemask(s32, 2)) |
+             dh_typemask(i64, 3) |
+             dh_typemask(ptr, 4))
+    };
+
+    struct qemu_plugin_dyn_cb *dyn_cb = plugin_get_dyn_cb(arr);
     dyn_cb->userp = udata;
-    /* Note flags are discarded as unused. */
     dyn_cb->type = PLUGIN_CB_REGULAR;
     dyn_cb->rw = rw;
     dyn_cb->regular.f.vcpu_mem = cb;
+
+    assert((unsigned)flags < ARRAY_SIZE(info));
+    dyn_cb->regular.info = &info[flags];
 }
 
 /*
-- 
2.34.1


