Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4EE1C83F04
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 11:03:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXHgF-0007c9-CV; Thu, 03 Jul 2025 07:00:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHdf-0005DS-6j
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 06:58:01 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHdd-0002NC-Cm
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 06:57:58 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3a54700a463so483805f8f.1
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 03:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751540275; x=1752145075; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KA0b8Mx/diMOpz5eVRAgzHisGcdWtT3pud+mD+Gv0yw=;
 b=o8Fw9KwicQtATPbEsTCXNo7BVmn8d7YIIe3iYXk+1ja4ac1cG0cNQ/D+rBJ6kej6EQ
 d70rX6Ecvpi98jQDkSB1xqPBxxv8k6zsKe8j+FuDmPRaPwcmOR35eQKnwd+KPf7wcJDR
 TrIfzE5RaEkiVrXoahOHMSoaszaA8PbyKwp2LgFJ+1AWZHjWsAHFuYhTiJLqziHDWAo+
 QAZqTIaYDX690TnHdlARVaQf6BibRxTlfyBIaN/cAhJUooCpRURbdso5BgY162MZjOa9
 SEbfLFMaLPdXdLhss0ZUWdBQKkKI9LkvpaY1EIk+E+x4bQ2JAuJ4sug4UDxChua2jRHQ
 h7Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751540275; x=1752145075;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KA0b8Mx/diMOpz5eVRAgzHisGcdWtT3pud+mD+Gv0yw=;
 b=QYh7zwIjKbt3sV9qxHryA90dSSP3dYNsGYpzlOLzmY7itsgc272QGiUv8eEJI3Z3lM
 vRGFUj4scXQ/xq+T0rXIkCCvMam0VC8YVtQyoezdi5xN3aiA6osYUERlycPO8cxvWqkZ
 T6C4QlX8KPZKa3IZH+ivov2vBd5jPIkQ7DVQphD2E5cSyK5ziC3qp25tVyyJJ7ZAcZC+
 Ij9U1ki0o6p35mAoekeTBPsOZn5dgrqSnxa8iLvlxGBm/590K4VNhN/slMG+OV44SqBV
 J73Lyjbuapexn2W0g5VvqQm8219g9jS3AmkmXfBz50KNczACZ+RRKq9U7Hkc+g5/5IUH
 +Diw==
X-Gm-Message-State: AOJu0YxfuZtCknmbGdRjILQM4kSggBNHkz3MnSinZpG/5sGMvH8H04j+
 W5zWzF63TJyBku/oI0f7ti7dICxd4UaxRcLLN4lPIZEy4vlHVM3dtMtlHR+y6BiqBTJYK11fCM/
 mMS8APNA=
X-Gm-Gg: ASbGncvTqi8Cqeq8IhydNMEZVuDKc4+ECbAeUfgMLteaVEZzEg7ZgehWFqdTxTAvlck
 Xj31X/hEPbUcEzqfL4id+B9c7ILae+IV/n5G9xHVuQNZgRuRlAqhrDVRUf7i1OYJlFdMCyiwFL5
 VjQ/JpQpmWPhD0ylLj1vknIWIIjANBAdA7hXamN2uu35rq1OEh2Nk9F9M2CVvYj96s48qzzTWz0
 DvPMLxalaoJsBvyI7KBktx5ovfi/2B7HwxgPyX9aFQlu69c/Xbsb3e/dvAznjG3bTQoA2p4wBa7
 7iFzV5oADkUrgRLQ3+gcdU99oCO2/cYT7478KlDqWleDyWdzTmkzLzNoL2AbzsXoCIffrWsJgq2
 FDPqNDrAkXSU=
X-Google-Smtp-Source: AGHT+IF1BqFbX6Smxb354kb502BZiBNMi8R4AvGG4ddbQJ0e2Zfnpsx8TFJQRhgqCASJoYZJnBu/tA==
X-Received: by 2002:a05:6000:40dd:b0:3a4:e1f5:41f4 with SMTP id
 ffacd0b85a97d-3b344322977mr2374295f8f.17.1751540275136; 
 Thu, 03 Jul 2025 03:57:55 -0700 (PDT)
Received: from localhost.localdomain ([83.247.137.20])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454a997b492sm23522235e9.13.2025.07.03.03.57.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Jul 2025 03:57:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, kvm@vger.kernel.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 25/69] accel/tcg: Factor tcg_dump_flush_info() out
Date: Thu,  3 Jul 2025 12:54:51 +0200
Message-ID: <20250703105540.67664-26-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250703105540.67664-1-philmd@linaro.org>
References: <20250703105540.67664-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/monitor.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/accel/tcg/monitor.c b/accel/tcg/monitor.c
index 344ec500473..6d9cc11d94c 100644
--- a/accel/tcg/monitor.c
+++ b/accel/tcg/monitor.c
@@ -141,11 +141,26 @@ static void tlb_flush_counts(size_t *pfull, size_t *ppart, size_t *pelide)
     *pelide = elide;
 }
 
+static void tcg_dump_flush_info(GString *buf)
+{
+    size_t flush_full, flush_part, flush_elide;
+
+    g_string_append_printf(buf, "TB flush count      %u\n",
+                           qatomic_read(&tb_ctx.tb_flush_count));
+    g_string_append_printf(buf, "TB invalidate count %u\n",
+                           qatomic_read(&tb_ctx.tb_phys_invalidate_count));
+
+    tlb_flush_counts(&flush_full, &flush_part, &flush_elide);
+    g_string_append_printf(buf, "TLB full flushes    %zu\n", flush_full);
+    g_string_append_printf(buf, "TLB partial flushes %zu\n", flush_part);
+    g_string_append_printf(buf, "TLB elided flushes  %zu\n", flush_elide);
+}
+
 static void dump_exec_info(GString *buf)
 {
     struct tb_tree_stats tst = {};
     struct qht_stats hst;
-    size_t nb_tbs, flush_full, flush_part, flush_elide;
+    size_t nb_tbs;
 
     tcg_tb_foreach(tb_tree_stats_iter, &tst);
     nb_tbs = tst.nb_tbs;
@@ -182,15 +197,7 @@ static void dump_exec_info(GString *buf)
     qht_statistics_destroy(&hst);
 
     g_string_append_printf(buf, "\nStatistics:\n");
-    g_string_append_printf(buf, "TB flush count      %u\n",
-                           qatomic_read(&tb_ctx.tb_flush_count));
-    g_string_append_printf(buf, "TB invalidate count %u\n",
-                           qatomic_read(&tb_ctx.tb_phys_invalidate_count));
-
-    tlb_flush_counts(&flush_full, &flush_part, &flush_elide);
-    g_string_append_printf(buf, "TLB full flushes    %zu\n", flush_full);
-    g_string_append_printf(buf, "TLB partial flushes %zu\n", flush_part);
-    g_string_append_printf(buf, "TLB elided flushes  %zu\n", flush_elide);
+    tcg_dump_flush_info(buf);
 }
 
 HumanReadableText *qmp_x_query_jit(Error **errp)
-- 
2.49.0


