Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21D14C25B74
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 21:07:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9WgX-0001hW-4d; Tue, 21 May 2024 17:06:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s9WgV-0001fg-Ho
 for qemu-devel@nongnu.org; Tue, 21 May 2024 17:06:12 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s9WgT-0008Qg-1W
 for qemu-devel@nongnu.org; Tue, 21 May 2024 17:06:11 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2b9fe8fc695so1625874a91.1
 for <qemu-devel@nongnu.org>; Tue, 21 May 2024 14:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716325567; x=1716930367; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=tVtyFTBG+iw77EA6qlS0AHGWtWsOsqyovWMI4nng/iQ=;
 b=Zk6vXuqUw8NLg5zoo2tdt7EOlzyqPwJ2j8HYo+CSEDLjx+LCthS4J24iRDa/+7KBDt
 zIJ50dPuV2r4y+nocJ6FlmwASGYd2cJqe3sCeXz/Zgtk+xnqtCb3mNnk1wU/ypQNAzWj
 qMfMh4+ziD+bL3dwnfi40A8QLiGncf6myEOlTzcfjcFOS//7M5XyT7RLl40igsoHJz1s
 c4A2ec8yavKWNwDnWZWzN2+qDOYdVuPdmQqSScEIroNkpj4ZmRNyYQERm+DXwQdF0W2P
 qaMq1nj2VQJlDONGuiqLoi3X94TcuWH/LE+NWp+yEi+0671t7eP4arK0Z9g2REn+ymtG
 BRwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716325567; x=1716930367;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tVtyFTBG+iw77EA6qlS0AHGWtWsOsqyovWMI4nng/iQ=;
 b=VnlmQHdvk9lML8zi4uY2iB6C1YXSvq6jo8GrOUyqUv16QBFbIv68O5+0CadW0LslT0
 +IpnPYB4eBp/foXOrZQpE7mIA3ARlocp5Zm3sfmkWKiOuDBmC8tVzlvfrfEur6JgDHOH
 WrzzRv3OE/MDCnq3pezDdCR93oHDWAAkBxn39O1TmqZUOONqMU8iqdMpezLC3akby3UH
 xLBaat2En7gxdMTnk3l6jXouuEz20ZduyNWOmTQCTbRc/0TKFemn1bSUk99BGxvVdcHP
 8uHetqCjV06j4qC0+MYQ5FJRlm51647oKDkVmdF6O07GYDcJ1/1hdr0R+CHExSIUtT+5
 YVQQ==
X-Gm-Message-State: AOJu0YyDWmK/r3kKOl0fIqHeREZ4oxCiu4wgR82Ub9Y67mUGzwFDI+pe
 GyHscVbtg2gUuOA/RrdvZBy4EMWChAndLWDONTAKJ2BqcH3UTQDw8hAl/v2xTlkYqvbJQbLOLTp
 t
X-Google-Smtp-Source: AGHT+IELy95ztyxe44lOsIweXkJt36Z+gvkD1Touu36RVKjPvPkLVKt+5HghuFSZTff+51MgDTXeIw==
X-Received: by 2002:a17:90a:fa10:b0:2b5:af07:1cde with SMTP id
 98e67ed59e1d1-2bd9f5b8ab6mr301614a91.34.1716325567246; 
 Tue, 21 May 2024 14:06:07 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2bd70b57953sm5200808a91.30.2024.05.21.14.06.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 May 2024 14:06:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH] accel/tcg: Init tb size and icount before plugin_gen_tb_end
Date: Tue, 21 May 2024 14:06:04 -0700
Message-Id: <20240521210604.130837-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
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


