Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCE41C54E58
	for <qemu-devel@archiver.kernel.org>; Sat, 16 Mar 2024 02:01:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rlJIt-0002nD-R3; Fri, 15 Mar 2024 21:57:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rlJIs-0002lf-3t
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 21:57:42 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rlJIq-0000ia-Eg
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 21:57:41 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-5ce6b5e3c4eso1787639a12.2
 for <qemu-devel@nongnu.org>; Fri, 15 Mar 2024 18:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710554258; x=1711159058; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tejnOfEGCIS6beGjus6J1qxofDOH1tfJTZA704n4hj8=;
 b=ktHZiDj/SgCjaWxtBrbGmpge3WJ4L/3f9rxbjrEROvynoCl2vpQS76Y7IujQihJbwo
 YHQgDjJ4tH+lv+z6BSCS6XWD9KeHtLwBbCayfwdl5uQvYkk/7Yh9t7k1kHxSwQyvZeXI
 Qx1L7Zi9WpZwbm1RRW++FxcslC4RjM/8Mm0/Mfq5D5obUQ+B756aMlzOLeGdfN+psCqo
 ZnTF7l2EzyHL0a1pLLI+YCb4/Ur2CgnYXgNdk8ThAKmo0arWIgx2kzhDpvtLt9LrR8qm
 qlLTOo63i/D/cd7mOocOvdelAMEXicaZDy2AEiyLbA1eUR3g6/qG49NVFixm2vNjwJ/6
 w68g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710554258; x=1711159058;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tejnOfEGCIS6beGjus6J1qxofDOH1tfJTZA704n4hj8=;
 b=iOcgidQyVGKldAZq6QUlNA+iLfAUMf/tFtmeTyaVD4kL+DZRGCRJoaIrkyp+aXAbUe
 J/Fg9T1ep49gOzE/ZwR+2a4uQH1n6q283iHzEkMKn9FHhqPk+2ZcWCH7pjJIE0BgkQFo
 te/YU+GCvbKtmG8vQXnUDCWEmeK6T/cw/fC1f26ZFfT90DL6jyVjsumc40+Jh0jGc12z
 +gFfbdQOpGAoYdqavySzFg5Zi6cjdSMDXhzzO7/wGgYMzDt4zZ6W9yRtl7vZmGpb9DdI
 E4Jl8tsu1GNYHgtzxuuWP28iZbF9EjQhx5rBytUkWUxGfVfv3QNdmAnZ3P1A+3tVAl/Q
 YxjQ==
X-Gm-Message-State: AOJu0YwFW/0kbrcMUvallSW81OIl27AGzn1nbygUuJPHA1NTm4IK2DsY
 qk2v1Lmhg+ED2kx/sYdY0g78B7k2JH8frmcUB1FMq7q/lojCiUSj4G7zAFYNuNXeSAK7GyVFiee
 4
X-Google-Smtp-Source: AGHT+IFv0TAY6MwF53Hmvf7/T8L1/Zj27hHGDaVxQxEfz0b5zOgtKy65aWhDztK5f3FPx7C9gvkpoQ==
X-Received: by 2002:a17:902:ce86:b0:1dd:c7ea:81f3 with SMTP id
 f6-20020a170902ce8600b001ddc7ea81f3mr5679327plg.1.1710554258139; 
 Fri, 15 Mar 2024 18:57:38 -0700 (PDT)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 b3-20020a170903228300b001dd42bbb08asm4592985plh.253.2024.03.15.18.57.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Mar 2024 18:57:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	alex.bennee@linaro.org
Subject: [PATCH 06/22] plugins: Create TCGHelperInfo for all out-of-line
 callbacks
Date: Fri, 15 Mar 2024 15:57:04 -1000
Message-Id: <20240316015720.3661236-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240316015720.3661236-1-richard.henderson@linaro.org>
References: <20240316015720.3661236-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
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

TCGHelperInfo includes the ABI for every function call.

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


