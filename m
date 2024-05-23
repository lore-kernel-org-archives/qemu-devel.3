Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BBE3C25B7C
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 16:17:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAB7I-0005D7-K6; Thu, 23 May 2024 12:16:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sAB6t-00051i-7f
 for qemu-devel@nongnu.org; Thu, 23 May 2024 12:16:12 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sAB6n-0002Yz-DT
 for qemu-devel@nongnu.org; Thu, 23 May 2024 12:16:06 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6f472d550cbso3351670b3a.1
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 09:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716480959; x=1717085759; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/mQMS7XHQY6TkE4rdOTcxfDvk4JYb50U7z9A8FwVzKY=;
 b=zYKQvNWm/QzWXYRaFtgvS7MEYRGCDkLhNzVPNazCFMZ+iD5CIeZeo8sP7mdnZa6/FG
 +ogwUeoVeO2fpFoPCEd7nN08bJfCdiNwVtkp2r+Vf35VtZWdil6ulYHkJntWrIWEUvI2
 JpWlW7NuoFtLLb/o3dAYHXQn++j6XiweOHLOBmOe85G+4fd/Iv/8Xdi/E4n+txy4xC+b
 +L98KKdCp4ORGC/TwDvB0nwxrFvRc6OGbVh+pQjFndK51q8h7FiC1z37Tg9XfmAqPh9U
 z+tJsapP4EQWqDYSehMK4xq6lh//SiyOsbh7k37FwG9G09cbi7nPmqzUO1aOpNCxuV7u
 8PZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716480959; x=1717085759;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/mQMS7XHQY6TkE4rdOTcxfDvk4JYb50U7z9A8FwVzKY=;
 b=a466tvrYAXf7pBnmhGDG5RnV0MtBPRb9/dm+xCv8+OkTS0QCTfYW+uDVBpu0A+0pBm
 8OFCkCtoVtzacm16rl+WS/96nsD6op9h8X9cAPcdou2KMWXxbjdmh8wLqisIsLuZZRMt
 oIAm9LHweQ/NLQN/jt3OoM0BW2+vbdhCdYK+bAKKLPCZMNYSqVZIBIpLGUBpA1qr4nvU
 JUutckbuAGm2Lj+6JlwjzKD/0b7obbA3+pIQhbiIahCcpSsLBPkNocD7osrhv+Fgu1Gm
 PtXbsA8E8t9jQdGlaqLODEA+ZztUto322JC0ksFuH4bIIvjptxGfQplFdSLlUe5U0E33
 h5SQ==
X-Gm-Message-State: AOJu0Yx4KU+PTpbNkS9VPHhgzQed+tlkWMVLgAlcnEIIgVC4O1hKrp2Q
 7yPyGIBCJ37Dl/QjCsfRitUoO3xd/cAxepvinhADob2e89vYTCfBx5iwfMqxh10mn5YGWP7QGNs
 e
X-Google-Smtp-Source: AGHT+IEANUO/RWrdXFS9mu/zO2w9sUzRUQcRYEQR/kd46eFJEB+PJq6eoKMadBKppeEVh47srn3SAQ==
X-Received: by 2002:a05:6a00:1382:b0:6ed:cd4c:cc1a with SMTP id
 d2e1a72fcca58-6f6d60300b2mr7251615b3a.8.1716480959466; 
 Thu, 23 May 2024 09:15:59 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f4d2a9d9acsm24890255b3a.90.2024.05.23.09.15.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 09:15:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 5/5] accel/tcg: Init tb size and icount before plugin_gen_tb_end
Date: Thu, 23 May 2024 09:15:53 -0700
Message-Id: <20240523161553.774673-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240523161553.774673-1-richard.henderson@linaro.org>
References: <20240523161553.774673-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

When passing disassembly data to plugin callbacks,
translator_st_len relies on db->tb->size having been set.

Fixes: 4c833c60e047 ("disas: Use translator_st to get disassembly data")
Reported-by: Bernhard Beschow <shentey@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 accel/tcg/translator.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index c56967eecd..113edcffe3 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -214,14 +214,14 @@ void translator_loop(CPUState *cpu, TranslationBlock *tb, int *max_insns,
     set_can_do_io(db, true);
     tcg_ctx->emit_before_op = NULL;
 
+    /* May be used by disas_log or plugin callbacks. */
+    tb->size = db->pc_next - db->pc_first;
+    tb->icount = db->num_insns;
+
     if (plugin_enabled) {
         plugin_gen_tb_end(cpu, db->num_insns);
     }
 
-    /* The disas_log hook may use these values rather than recompute.  */
-    tb->size = db->pc_next - db->pc_first;
-    tb->icount = db->num_insns;
-
     if (qemu_loglevel_mask(CPU_LOG_TB_IN_ASM)
         && qemu_log_in_addr_range(db->pc_first)) {
         FILE *logfile = qemu_log_trylock();
-- 
2.34.1


