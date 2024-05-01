Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 119B4C10F1A
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2024 14:39:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2B5v-0002io-HW; Wed, 01 May 2024 10:38:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s2B5h-0002fC-Lv
 for qemu-devel@nongnu.org; Wed, 01 May 2024 10:37:50 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s2B5f-00027D-Oz
 for qemu-devel@nongnu.org; Wed, 01 May 2024 10:37:49 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1e3ff14f249so6734715ad.1
 for <qemu-devel@nongnu.org>; Wed, 01 May 2024 07:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714574265; x=1715179065; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/mvFgQ07uq/6Zxz3YFl1o78VrbR/mo0c+cULSy+Rk10=;
 b=EwjoVwFSu9jfsHy+CqztVHWyH1ZeYYwbupbWBiWem9Mm+8WNhzhbRElgoeRCt12d2s
 6Bor6Ed0j6Fgr4kGEF6ladCk437DCBO1VzRYAHXqKWhtSSJJoFOy4D224RcFKx9mTzKr
 zArymvBcSz2p8Bu0nmCLN0n67JbMsoFhT4xs3iZel9AR55fICfSAVp3IYZjn92k+Mefp
 Bh0I/cyVDNSWSeD/KZuAI5c6gXbW3YICOL4c9i7Fy2iNMnZnPuj0gkJtoaKK9qYINnyC
 JLzgxXLLELqEfrdbhNVv2h0Am+SF791y/gndnX2R7zQr6oGk9/NEC1d+NJlun4R+kScz
 AWlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714574265; x=1715179065;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/mvFgQ07uq/6Zxz3YFl1o78VrbR/mo0c+cULSy+Rk10=;
 b=aKcBxJ9ZR+4Dr+KFLmAKN4RKYrIkWhX+gIkFNpwtHDiIt0KbXQiKJ7b66nrewe5FZO
 H63I+ErPO+NhwgEpig1W29RRzmqpQ1mXHwbrwCz2pLtK8JgD/AFWPfAiN/kpk92NVqje
 7+Un2OzLjwZhWCfY4KX2w+D6scaP6+qlymsWGRiHZMDY6tI89t5FjuS5CkgSWhTktZlN
 49Kue75zCF77WpQywneQ3fsLy74EW/rKUOYTp/eK1nYWrOV8NMfVPiqAAfNkeeTWyIa9
 rmfWWLbf/eSSDLg4/szvdn/NuLxn/iPtW+as5FL/0C2LwlyFEboTte3EQXeaIa/0vCTv
 eg7Q==
X-Gm-Message-State: AOJu0YwJPcTLMazZjiqFR9ZMNmOHHDmwpFvA+xfgilgdwmt5AmY+llbo
 05D7uax0hMgyfGZUrchUzeJ3K5lsx2tQqVA+GZzAXeDkYmGnm0i7QGbu18LfBw9Qrj67iynSYXj
 p
X-Google-Smtp-Source: AGHT+IG3jqMerkYk8wAuggrmDNnIUatle76IkFxNkTKAdsP5Oihdglgx2ppk/HC0s4poY/LIbn01fA==
X-Received: by 2002:a17:903:1105:b0:1e2:58f:7ed4 with SMTP id
 n5-20020a170903110500b001e2058f7ed4mr4736772plh.5.1714574265288; 
 Wed, 01 May 2024 07:37:45 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 h12-20020a170902f54c00b001ebd73f61fcsm5751573plf.121.2024.05.01.07.37.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 May 2024 07:37:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 04/20] plugins: Move function pointer in qemu_plugin_dyn_cb
Date: Wed,  1 May 2024 07:37:23 -0700
Message-Id: <20240501143739.10541-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240501143739.10541-1-richard.henderson@linaro.org>
References: <20240501143739.10541-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

The out-of-line function pointer is mutually exclusive
with inline expansion, so move it into the union.
Wrap the pointer in a structure named 'regular' to match
PLUGIN_CB_REGULAR.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/qemu/plugin.h  | 4 +++-
 accel/tcg/plugin-gen.c | 4 ++--
 plugins/core.c         | 8 ++++----
 3 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
index 41db748eda..5676ab5ef2 100644
--- a/include/qemu/plugin.h
+++ b/include/qemu/plugin.h
@@ -85,13 +85,15 @@ enum plugin_dyn_cb_subtype {
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
index cd78ef94a1..4b488943ff 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -425,7 +425,7 @@ static TCGOp *append_udata_cb(const struct qemu_plugin_dyn_cb *cb,
     }
 
     /* call */
-    op = copy_call(&begin_op, op, cb->f.vcpu_udata, cb_idx);
+    op = copy_call(&begin_op, op, cb->regular.f.vcpu_udata, cb_idx);
 
     return op;
 }
@@ -473,7 +473,7 @@ static TCGOp *append_mem_cb(const struct qemu_plugin_dyn_cb *cb,
 
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


