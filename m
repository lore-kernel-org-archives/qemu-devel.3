Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DD9AE7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 01:09:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNM3b-0008Gx-VJ; Mon, 16 Dec 2024 20:07:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNM3Z-0008Fr-Fa
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 20:07:25 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNM3Y-0004xW-0G
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 20:07:25 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-7265c18d79bso5066940b3a.3
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2024 17:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734397642; x=1735002442; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rYQneB+NKqjuG7StTn0XWLjAkA1JJLLeS7nr+5pDNNk=;
 b=PeDFltRJ3DikVQle28iHRpeg0QWuJO+QAxGeP4Bwz8Bs5KWsK1DdPDjcmFyqvsnAk4
 4kpN5mjBpjJeANQxu42KjHrDch5kbJl59KHoIPMSmf5kmWNigyTiXAddTaQtDCqUEI9I
 L9rPRBZ/b0DzkhDtoM58oYorWHlga7lEYbls8SAHZs3/JzeykAdMulVM1RaaRDf8YJSY
 vetS0OTREaK8UtrkVWnwTXqyfVM/0ocWiXeB0lfDeQCb99w8Z248b/KG5hL4EQPnH2AN
 ZlHBq5td+g4W8RyAcvF2ws0fi6dQQRLU9LyOGJEtXfeYc+SorpEmiBU47+JDGLNPdK52
 Slmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734397642; x=1735002442;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rYQneB+NKqjuG7StTn0XWLjAkA1JJLLeS7nr+5pDNNk=;
 b=j3Hjs0VUyZ0gPq1QJFnSDhc+hPBFl0V0e6Pk3FgjJXaaJ957u881ZH1HpnfVrLhyiK
 SKfvH2/WdTKHsvPiXUifLxjRj0XPLA32AFiwa9DtIRtywGbx2EM5VXNpAi14U/DbWte6
 9Qz+S+8Ji/Y3HsH1ORIIf23Vq3bEeEkEiIWmcnVF0T8nYo7HKIKkJt25zNsLCQgjst6V
 jSu99FCasUF0eGA+UUFEJNIWZ4WiJ+ZaCqX10ZNovi7FwVcDHLOqArJv0O1J97Veolp9
 cF/ziC6hmbqFAEoE6K19pbZ96/Y3hZXeqOMC59PmYf/DyPtIF2t3mE5sNbKexIEaiF+G
 JPRw==
X-Gm-Message-State: AOJu0YyQXXNtG5Ecp9TF+iK9nx++Aa4g9pTwR555uPR8peZtOUcPubzS
 /14KeQ+t5WBkhHjQfESLNf3GsQxwZQcJsNsWqHms5OdA3HSpKo+rCHlLGK0l/MruyzCr+ZozD/Q
 KLcc=
X-Gm-Gg: ASbGnctLy0GR5pxbm6Mis75yPUdaXYqWFtT7h4TZuSGQT3I0C9m35+KtudkYw7C/sT4
 a3zs7T3shzxfQ7N7d/ugzZpPyqLn56L5r98nV3H6ZF/FBjKPO7xW5/cJUZCQSH17nt6MZLUFmqq
 VL6dW1aZ3ZrJF51w5CE47tmhnelXxJ1TuSjEaGPRud/qADxH/SNf5UZH6ser9cxXNnTVhUe48te
 EJPVRtiowh/e9Z5yqGTPtvvvPWqytiNTzkIMIzPtWQneHrj9tqauvKGxvM0jEHhXfEqJGnQZ1dA
 3hJa8yxfrn0kEYk=
X-Google-Smtp-Source: AGHT+IHHhWBktdPc0/W9AHm1B62sprWwGNknIE0haQLl8riUEV3OKlyjqsDMoSzaD72OmHyVy2S+uQ==
X-Received: by 2002:a17:902:da84:b0:216:7761:cc48 with SMTP id
 d9443c01a7336-21892a5d762mr250070425ad.40.1734397642580; 
 Mon, 16 Dec 2024 17:07:22 -0800 (PST)
Received: from pc.. (216-180-64-156.dyn.novuscom.net. [216.180.64.156])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-218a1e6d0e4sm48746595ad.261.2024.12.16.17.07.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2024 17:07:22 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Thomas Huth <thuth@redhat.com>,
 philmd@linaro.org
Subject: [PATCH 05/13] tests/tcg/plugins/syscall: fix 32-bit build
Date: Mon, 16 Dec 2024 17:06:59 -0800
Message-Id: <20241217010707.2557258-6-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241217010707.2557258-1-pierrick.bouvier@linaro.org>
References: <20241217010707.2557258-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x435.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 tests/tcg/plugins/syscall.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/tcg/plugins/syscall.c b/tests/tcg/plugins/syscall.c
index ff452178b18..47aad55fc1b 100644
--- a/tests/tcg/plugins/syscall.c
+++ b/tests/tcg/plugins/syscall.c
@@ -76,12 +76,12 @@ static int64_t write_sysno = -1;
 static SyscallStats *get_or_create_entry(int64_t num)
 {
     SyscallStats *entry =
-        (SyscallStats *) g_hash_table_lookup(statistics, GINT_TO_POINTER(num));
+        (SyscallStats *) g_hash_table_lookup(statistics, &num);
 
     if (!entry) {
         entry = g_new0(SyscallStats, 1);
         entry->num = num;
-        g_hash_table_insert(statistics, GINT_TO_POINTER(num), (gpointer) entry);
+        g_hash_table_insert(statistics, &entry->num, entry);
     }
 
     return entry;
@@ -232,7 +232,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
     }
 
     if (!do_print) {
-        statistics = g_hash_table_new_full(NULL, g_direct_equal, NULL, g_free);
+        statistics = g_hash_table_new_full(g_int64_hash, g_int64_equal, NULL, g_free);
     }
 
     if (do_log_writes) {
-- 
2.39.5


