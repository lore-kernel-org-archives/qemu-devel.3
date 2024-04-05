Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52511CD1296
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2024 10:26:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsglB-000608-Qk; Fri, 05 Apr 2024 06:25:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rsgl9-0005zc-B9
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 06:25:23 -0400
Received: from mail-oa1-x2d.google.com ([2001:4860:4864:20::2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rsgl7-0004k8-4r
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 06:25:22 -0400
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-22edec341c2so90064fac.0
 for <qemu-devel@nongnu.org>; Fri, 05 Apr 2024 03:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712312720; x=1712917520; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=bO7B6oUNG3jW/PSuoPnzK0oY+ojFYCsg6W4mPRZ3c4k=;
 b=Q7V1F0+JGJD+pR/8/qfqzKpVF1C9sZmbWp6eMtJ+Y9buIo7/vL3XbNvWSm9Jb3Ic2w
 O2mteVmNKfLfb5FYDUj8H8kuy4zCRiTzgDy6dViYeRYgdz6ZC4jjlVm3OBPNobJOIhWN
 d85yyVazuIcvqCwDDbGW3xTILhiuhrUS5HP3C9tKN0IhOiLussUdqMCf5hqj42IEFRS+
 XGPPf1lpN6L3l/hLmP+5lpZ/JXHHp/FmXlPvAqZ4zPq5Nh4f6sWlRhTvnqulZgsQICx/
 t7Q+pEStV5TlFt7HQ9H5ji/UUu4+rYQKTTg/elz8ey5wsI7DGz/O472b327mj/Ipo8a3
 4x7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712312720; x=1712917520;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bO7B6oUNG3jW/PSuoPnzK0oY+ojFYCsg6W4mPRZ3c4k=;
 b=FJs7VYQ67PHA3hF4eg9BLThoDkjbZeVMVFTRkGF8ZNCWkZeXXdXXq4Zl7Emh/VjLtl
 st+NYOWCo1VKSoz71AiZunjQF2+GfT4SueHHilBtsC7XTJcQqQ5WbojZ5SbnS+dFKuji
 dl7zmN9Yep28o8O1V+txyqu407XJq/7oI9tH0J9kajvwjfG+I3h1dR/uhSZUpyeHkI6x
 XYUCTZnA8d4NXA61+B0aeOUTQYwHZZu8OoshOkPIOPe1d2sOYA/El8x/YcdtnbI55jhl
 liMDzEkNAWJikAB3TFQ3g7wJExS6F2Dz/hmLJrH4ZtyM2Cnr2USqNQfUIzP7gDP4/X08
 vJTg==
X-Gm-Message-State: AOJu0Yzy3Wt5WFp3m/Ewe5ZTN0ZZzsSx6ATS9vkyZ2IIZ3EzYAjvA/98
 9ZiWa13kgOqMWqNsptoy2TlUZ7XEqd6qpJnEWny5K+iF8bzP0VSXF3TifhC+KvM6ZYJBbij1swN
 u
X-Google-Smtp-Source: AGHT+IEP+Z0idPpxfQT3hc8s2bSAJl1tpeflvOvaNx/uzIXEhZElPIfcMpgT3EJndCsA+daipxETlg==
X-Received: by 2002:a05:6870:4d0a:b0:22e:a0f7:8c36 with SMTP id
 pn10-20020a0568704d0a00b0022ea0f78c36mr976278oab.16.1712312719818; 
 Fri, 05 Apr 2024 03:25:19 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 h10-20020a63f90a000000b005e438fe702dsm1104304pgi.65.2024.04.05.03.25.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Apr 2024 03:25:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 14/32] plugins: Use DisasContextBase for qemu_plugin_tb_vaddr
Date: Fri,  5 Apr 2024 00:24:41 -1000
Message-Id: <20240405102459.462551-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240405102459.462551-1-richard.henderson@linaro.org>
References: <20240405102459.462551-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2d.google.com
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

We do not need to separately record the start of the TB.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/qemu/plugin.h  | 1 -
 accel/tcg/plugin-gen.c | 3 +--
 plugins/api.c          | 3 ++-
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
index 3db0e75d16..340e10ef12 100644
--- a/include/qemu/plugin.h
+++ b/include/qemu/plugin.h
@@ -117,7 +117,6 @@ struct qemu_plugin_scoreboard {
 struct qemu_plugin_tb {
     GPtrArray *insns;
     size_t n;
-    uint64_t vaddr;
 
     /* if set, the TB calls helpers that might access guest memory */
     bool mem_helper;
diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index b036773d3c..2c52306f80 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -188,7 +188,7 @@ static void plugin_gen_inject(struct qemu_plugin_tb *plugin_tb)
     int insn_idx = -1;
 
     if (unlikely(qemu_loglevel_mask(LOG_TB_OP_PLUGIN)
-                 && qemu_log_in_addr_range(plugin_tb->vaddr))) {
+                 && qemu_log_in_addr_range(tcg_ctx->plugin_db->pc_first))) {
         FILE *logfile = qemu_log_trylock();
         if (logfile) {
             fprintf(logfile, "OP before plugin injection:\n");
@@ -318,7 +318,6 @@ bool plugin_gen_tb_start(CPUState *cpu, const DisasContextBase *db)
 
         ret = true;
 
-        ptb->vaddr = db->pc_first;
         ptb->mem_helper = false;
 
         tcg_gen_plugin_cb(PLUGIN_GEN_FROM_TB);
diff --git a/plugins/api.c b/plugins/api.c
index 4b6690c7d6..36ab47cdae 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -200,7 +200,8 @@ size_t qemu_plugin_tb_n_insns(const struct qemu_plugin_tb *tb)
 
 uint64_t qemu_plugin_tb_vaddr(const struct qemu_plugin_tb *tb)
 {
-    return tb->vaddr;
+    const DisasContextBase *db = tcg_ctx->plugin_db;
+    return db->pc_first;
 }
 
 struct qemu_plugin_insn *
-- 
2.34.1


