Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6387FCD1284
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Apr 2024 23:08:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsWAX-00029F-Pe; Thu, 04 Apr 2024 19:06:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rsWAS-00027n-Dn
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 19:06:48 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rsWAH-0007ns-2o
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 19:06:45 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-29ddfada0d0so1123350a91.3
 for <qemu-devel@nongnu.org>; Thu, 04 Apr 2024 16:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712271995; x=1712876795; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RzYzU7RypP3Y+HHaxfaYXazYrOjoOSxUmTQNH2aYDBw=;
 b=YoXeEzupH6xqdljw1B/7iOAqN+hBKYCVDOuhA+nJPpF9eaCVsShQDFD3jUENwSejWo
 Ub/MXkWbUKx2qJlO1sV+skZbqA9+zefqgU2XD7VmX+a9iffzfAcwxTofB4R64wOjDtYG
 /a/N05+cOfBuwr+rbGw8hOYPMsiuNZCACGndevnkGjCeL9sdIdLDGoCYRoZ0B9mBUyCH
 Hfulo/mhke0/xY6Zd+Ovtntg9y0OzkwFkYI25+8cxmfuQtdTaPZe1Fu4CKvVXt7WsN+d
 D7PCnOb3F6/1a1LbkDIcp7AkY/wyuQr5PhTyKuAT+/64a1c3H2Dda0E/DkAMc/uAWrBT
 QwHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712271995; x=1712876795;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RzYzU7RypP3Y+HHaxfaYXazYrOjoOSxUmTQNH2aYDBw=;
 b=S+NazxclUMbOc+tsKICklz8cmVnRqrVy4JUj0Tw2L+lbbXY1SKyQ2OBwwDjx4pNAAK
 Y8mwPbZyPnZMPVCPJJOvnaWrzc7lG0NT2uMwGzDFtTvrE6hzGdIH4H5HBK+1nitgWR/F
 KYZIum5uhgb5R6NI+vV9tFwOPafA08t5wcolbCNjcZIFV9xWANmhZEBi5CzIF8iIT+4s
 cNkK0PH+cE8xjZozRhPb4Nytf9FnVMO0YCm25RewAqP2kg7hmUBwBaLK4AKkfDyVh5La
 AGjgJcCZxfJkOdYgXDWk+tC6L3cr3bXGRlLzst4YL/ttI+VZVorfAnA8RSWsmTixQorM
 N3yw==
X-Gm-Message-State: AOJu0Yztc4qK4uZNmZYuq/rvGylvibqNhlYAEHWzrQwQkNpyC1k8aj0k
 zdD3/CIF4fijh6VyugWbrH/24SSF4dglMOhVroQEi2ngdo7afNUOXg4qKZNzim/K1uOdpKE664+
 q
X-Google-Smtp-Source: AGHT+IHtCYGwuWQWsmj594b5G+VU/PZR16WniUOgh1YWHrbpkJ/Mp425hv8U8Y7/wPW1yUIbdLxg2A==
X-Received: by 2002:a17:90b:358f:b0:2a2:9f46:439 with SMTP id
 mm15-20020a17090b358f00b002a29f460439mr4249752pjb.9.1712271995698; 
 Thu, 04 Apr 2024 16:06:35 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 q36-20020a17090a17a700b002a2f3cfc92asm1052592pja.16.2024.04.04.16.06.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Apr 2024 16:06:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 16/21] plugins: Introduce PLUGIN_CB_MEM_REGULAR
Date: Thu,  4 Apr 2024 13:06:06 -1000
Message-Id: <20240404230611.21231-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240404230611.21231-1-richard.henderson@linaro.org>
References: <20240404230611.21231-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Use different enumerators for vcpu_udata and vcpu_mem callbacks.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/qemu/plugin.h  | 1 +
 accel/tcg/plugin-gen.c | 2 +-
 plugins/core.c         | 4 ++--
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
index cf9758be55..34498da717 100644
--- a/include/qemu/plugin.h
+++ b/include/qemu/plugin.h
@@ -67,6 +67,7 @@ union qemu_plugin_cb_sig {
 
 enum plugin_dyn_cb_type {
     PLUGIN_CB_REGULAR,
+    PLUGIN_CB_MEM_REGULAR,
     PLUGIN_CB_INLINE,
 };
 
diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index e77ff2a565..c545303956 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -361,7 +361,7 @@ static void plugin_gen_inject(struct qemu_plugin_tb *plugin_tb)
 
                 if (cb->rw & rw) {
                     switch (cb->type) {
-                    case PLUGIN_CB_REGULAR:
+                    case PLUGIN_CB_MEM_REGULAR:
                         gen_mem_cb(cb, meminfo, addr);
                         break;
                     case PLUGIN_CB_INLINE:
diff --git a/plugins/core.c b/plugins/core.c
index b0615f1e7f..0213513ec6 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -391,7 +391,7 @@ void plugin_register_vcpu_mem_cb(GArray **arr,
 
     struct qemu_plugin_dyn_cb *dyn_cb = plugin_get_dyn_cb(arr);
     dyn_cb->userp = udata;
-    dyn_cb->type = PLUGIN_CB_REGULAR;
+    dyn_cb->type = PLUGIN_CB_MEM_REGULAR;
     dyn_cb->rw = rw;
     dyn_cb->regular.f.vcpu_mem = cb;
 
@@ -547,7 +547,7 @@ void qemu_plugin_vcpu_mem_cb(CPUState *cpu, uint64_t vaddr,
                 break;
         }
         switch (cb->type) {
-        case PLUGIN_CB_REGULAR:
+        case PLUGIN_CB_MEM_REGULAR:
             cb->regular.f.vcpu_mem(cpu->cpu_index, make_plugin_meminfo(oi, rw),
                                    vaddr, cb->userp);
             break;
-- 
2.34.1


