Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E0EFC54E67
	for <qemu-devel@archiver.kernel.org>; Sat, 16 Mar 2024 02:00:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rlJIt-0002mP-9d; Fri, 15 Mar 2024 21:57:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rlJIr-0002lc-Tf
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 21:57:42 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rlJIo-0000iM-BF
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 21:57:41 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1dddb160a37so19824145ad.2
 for <qemu-devel@nongnu.org>; Fri, 15 Mar 2024 18:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710554256; x=1711159056; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LBMQW30MaUGTTlpQEoDn37zgtsJ/Rvfav+1wxxZ/gso=;
 b=Q70sISkVt5KfkVxbDCtCbSN2g25bWCAvb4ZjAXLuDplFImEoHcRr55Xsaoyaro3w6X
 dc31ABX8n/eNPg+oZ4+hJ3/DYG61wIDSwdVOHWcRYhL8KVNXuvQIEVeOakoWq1aaeX+i
 wUIpiWP6bxjTselLqnFhiTu0/PkDPIxwk3Qq9AKPhOLen/bswqqL6jwfKRsVmZ+jS1JE
 kjOss8hM5/b0Q3vJNj5G2sPA5jjVJ9AwHzB+0T4Ma60CAB8ekndSdsJOby8t8KVCHKOu
 OaDj1cAS6pO2QPtyMgBWr/TzFENXg+n3+j2GyxqV/sWWgmtnHHPLmEjx8a+0UH/juioZ
 J4GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710554256; x=1711159056;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LBMQW30MaUGTTlpQEoDn37zgtsJ/Rvfav+1wxxZ/gso=;
 b=XWvlwpsHlhzV4/lf/T+5pTl5z3w1Ov625s1/AaTXEIECHIARFVk6n16Db6P4wU3ozp
 kQelFXB4gB1zOSrYqjgpuAbuYlKqoT0+u8AQtS1XaZpm0s8hUGlJBQSfGse5IYKaDh5I
 VH4hUHnfwdVvJrhIJfKfxfNUYhSDvz2ycGWNmtUR37plPmSL/O9vL9mMk3JF5nadL1Sz
 2RZJNOcmE6UiCHDCsCv/gizRXWYxBYc3bLW5jD5EzmjI5FmrFaJR6dhXv/ybYI7j0C9h
 Xzi+SwsXTmaajjBeVotfh9+ZrLsyX6gMibJ5PoSPRMh3f2DB5Cwo8R94Sz7QLdi+GAyP
 M2qw==
X-Gm-Message-State: AOJu0Yx5l4RpZq9WhBiL71Uz+Q+KYkjF/SdR9lnQPlqnMoOhJrBUcAoj
 V2OAcZZO3kA4LnpxcdQ7n3hFQnNTpHdVkhejNfCoHTUX0echaGvbz4OMBl3QTYL/RW7L96AxUs6
 5
X-Google-Smtp-Source: AGHT+IE3eU6MX5U8dF4gpdE37cVWnNHjMh3meMjTA3I4YSgEkQoqpUPJMVguWxXuXZRLaqOFbX2lrQ==
X-Received: by 2002:a17:903:2289:b0:1dd:eba:e744 with SMTP id
 b9-20020a170903228900b001dd0ebae744mr9258058plh.53.1710554256213; 
 Fri, 15 Mar 2024 18:57:36 -0700 (PDT)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 b3-20020a170903228300b001dd42bbb08asm4592985plh.253.2024.03.15.18.57.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Mar 2024 18:57:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	alex.bennee@linaro.org
Subject: [PATCH 05/22] plugins: Move function pointer in qemu_plugin_dyn_cb
Date: Fri, 15 Mar 2024 15:57:03 -1000
Message-Id: <20240316015720.3661236-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240316015720.3661236-1-richard.henderson@linaro.org>
References: <20240316015720.3661236-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

The out-of-line function pointer is mutually exclusive
with inline expansion, so move it into the union.
Wrap the pointer in a structure named 'regular' to match
PLUGIN_CB_REGULAR.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/qemu/plugin.h  | 4 +++-
 accel/tcg/plugin-gen.c | 4 ++--
 plugins/core.c         | 8 ++++----
 3 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
index 12a96cea2a..143262dca8 100644
--- a/include/qemu/plugin.h
+++ b/include/qemu/plugin.h
@@ -84,13 +84,15 @@ enum plugin_dyn_cb_subtype {
  * instance of a callback to be called upon the execution of a particular TB.
  */
 struct qemu_plugin_dyn_cb {
-    union qemu_plugin_cb_sig f;
     void *userp;
     enum plugin_dyn_cb_subtype type;
     /* @rw applies to mem callbacks only (both regular and inline) */
     enum qemu_plugin_mem_rw rw;
     /* fields specific to each dyn_cb type go here */
     union {
+        struct {
+            union qemu_plugin_cb_sig f;
+        } regular;
         struct {
             qemu_plugin_u64 entry;
             enum qemu_plugin_op op;
diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index 8028786c7b..c56f104aee 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -431,7 +431,7 @@ static TCGOp *append_udata_cb(const struct qemu_plugin_dyn_cb *cb,
     }
 
     /* call */
-    op = copy_call(&begin_op, op, cb->f.vcpu_udata, cb_idx);
+    op = copy_call(&begin_op, op, cb->regular.f.vcpu_udata, cb_idx);
 
     return op;
 }
@@ -479,7 +479,7 @@ static TCGOp *append_mem_cb(const struct qemu_plugin_dyn_cb *cb,
 
     if (type == PLUGIN_GEN_CB_MEM) {
         /* call */
-        op = copy_call(&begin_op, op, cb->f.vcpu_udata, cb_idx);
+        op = copy_call(&begin_op, op, cb->regular.f.vcpu_udata, cb_idx);
     }
 
     return op;
diff --git a/plugins/core.c b/plugins/core.c
index 4487cb7c48..837c373690 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -342,7 +342,7 @@ void plugin_register_dyn_cb__udata(GArray **arr,
 
     dyn_cb->userp = udata;
     /* Note flags are discarded as unused. */
-    dyn_cb->f.vcpu_udata = cb;
+    dyn_cb->regular.f.vcpu_udata = cb;
     dyn_cb->type = PLUGIN_CB_REGULAR;
 }
 
@@ -359,7 +359,7 @@ void plugin_register_vcpu_mem_cb(GArray **arr,
     /* Note flags are discarded as unused. */
     dyn_cb->type = PLUGIN_CB_REGULAR;
     dyn_cb->rw = rw;
-    dyn_cb->f.generic = cb;
+    dyn_cb->regular.f.vcpu_mem = cb;
 }
 
 /*
@@ -511,8 +511,8 @@ void qemu_plugin_vcpu_mem_cb(CPUState *cpu, uint64_t vaddr,
         }
         switch (cb->type) {
         case PLUGIN_CB_REGULAR:
-            cb->f.vcpu_mem(cpu->cpu_index, make_plugin_meminfo(oi, rw),
-                           vaddr, cb->userp);
+            cb->regular.f.vcpu_mem(cpu->cpu_index, make_plugin_meminfo(oi, rw),
+                                   vaddr, cb->userp);
             break;
         case PLUGIN_CB_INLINE:
             exec_inline_op(cb, cpu->cpu_index);
-- 
2.34.1


