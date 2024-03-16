Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36FD0C54E67
	for <qemu-devel@archiver.kernel.org>; Sat, 16 Mar 2024 02:01:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rlJJO-00031O-7Q; Fri, 15 Mar 2024 21:58:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rlJJI-0002z3-FN
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 21:58:10 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rlJJH-0000o3-0u
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 21:58:08 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1dff837d674so1596025ad.3
 for <qemu-devel@nongnu.org>; Fri, 15 Mar 2024 18:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710554284; x=1711159084; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aoP+WuNen9axGI0bTk0+2XzD9h5L/3eLseZfJNUB13M=;
 b=EODOK4hMrfPN5q/pJAqlu3gQO1Hzc5cFSnd5KSkihaFh+AJUxZSMTi/JGBlna4mdOA
 Vis8cPk109Ad1uosVluDyGwTb/92z6cuQU2+uSkmR6K8e8TBbqTDYtvuqAMI5/+/fUxa
 nETIw5ZtApx1onlzPwGgB9JdqJEUALNedMB69ow0ZUdk3t+fUrcrq1cyYKcZpBhTp5Wa
 T3WpPoWe3jnEXsPpcqvZDoAg49H4QGQjrEsm2Zq2r1JMOyylcjUiktayfwX76m29W14E
 awzbc6EYptDNpzcv65yqy2cR0u/fZhnfjo7vsV3FickoUjrLQXuEEZK24F8w86VbEWJK
 hLPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710554284; x=1711159084;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aoP+WuNen9axGI0bTk0+2XzD9h5L/3eLseZfJNUB13M=;
 b=mSC5Vmh4wHTnJwon8dofe24W6/LDB3szaWAf3za/zbCXhD2KoVdMN3UBNh799/0Dk5
 SdfH/X7Y0iy6QllFqJI0ZA+u2w8bKyJMTW/cKZsBGdcqZvojdA4lLEgny/tO20KzTGaK
 gJJ+J5xY16TuhM8dcdlvCIeFHDqFF3MN/G9N9X20DpROx+QXPCyUNYKmiMSGMP5IvEpG
 3g2JCMWUIZzu74/Xn44KvN6EUN2qFlPcoRl6B2FkGGS2skEP465pYjBRnpgbXkx5W56U
 +NymMc8yHN3bi7dccjOWUfrTLEu4M+NK86qQ24OdFxpxqfaCplG8eD+AOkCvrdOLuTeH
 2FZg==
X-Gm-Message-State: AOJu0YyuF+BZ7QPu+ElspUfChCoyZT0JipC4/S4HdHUXUcIb1zRPJRWH
 djyfPwAIzsY+FEe4M0zpoxZUoLHEmqw1SVazQWmYvOWJhAIAGXd2ZVwlCHoB3FtFMzsP3FsysBL
 2
X-Google-Smtp-Source: AGHT+IGYMjuZuIyeDaBsIFtW7O135KYz2nHzxHPaFq7/YWP3Nu+jqxHxYwR+Xnjwhbkbpk8ZvfaBZg==
X-Received: by 2002:a17:902:e5c1:b0:1dd:96cc:b5d1 with SMTP id
 u1-20020a170902e5c100b001dd96ccb5d1mr7773742plf.60.1710554284431; 
 Fri, 15 Mar 2024 18:58:04 -0700 (PDT)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 b3-20020a170903228300b001dd42bbb08asm4592985plh.253.2024.03.15.18.58.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Mar 2024 18:58:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	alex.bennee@linaro.org
Subject: [PATCH 20/22] plugins: Move qemu_plugin_insn_cleanup_fn to tcg.c
Date: Fri, 15 Mar 2024 15:57:18 -1000
Message-Id: <20240316015720.3661236-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240316015720.3661236-1-richard.henderson@linaro.org>
References: <20240316015720.3661236-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

This is only used in one place, and usage requires an
out-of-line function.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/qemu/plugin.h | 12 ------------
 tcg/tcg.c             | 12 ++++++++++++
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
index 07b1755990..201889cbee 100644
--- a/include/qemu/plugin.h
+++ b/include/qemu/plugin.h
@@ -116,18 +116,6 @@ struct qemu_plugin_scoreboard {
     QLIST_ENTRY(qemu_plugin_scoreboard) entry;
 };
 
-/*
- * qemu_plugin_insn allocate and cleanup functions. We don't expect to
- * cleanup many of these structures. They are reused for each fresh
- * translation.
- */
-
-static inline void qemu_plugin_insn_cleanup_fn(gpointer data)
-{
-    struct qemu_plugin_insn *insn = (struct qemu_plugin_insn *) data;
-    g_byte_array_free(insn->data, true);
-}
-
 /* Internal context for this TranslationBlock */
 struct qemu_plugin_tb {
     GPtrArray *insns;
diff --git a/tcg/tcg.c b/tcg/tcg.c
index d248c52e96..d7abc514c4 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -761,6 +761,18 @@ QEMU_BUILD_BUG_ON((int)(offsetof(CPUNegativeOffsetState, tlb.f[0]) -
                   < MIN_TLB_MASK_TABLE_OFS);
 #endif
 
+#ifdef CONFIG_PLUGIN
+/*
+ * We don't expect to cleanup many of these structures.
+ * They are reused for each fresh translation.
+ */
+static void qemu_plugin_insn_cleanup_fn(gpointer data)
+{
+    struct qemu_plugin_insn *insn = (struct qemu_plugin_insn *) data;
+    g_byte_array_free(insn->data, true);
+}
+#endif
+
 static void alloc_tcg_plugin_context(TCGContext *s)
 {
 #ifdef CONFIG_PLUGIN
-- 
2.34.1


