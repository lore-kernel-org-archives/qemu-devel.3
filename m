Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D30A3C02194
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 21:54:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfQs8-0001by-T9; Tue, 04 Feb 2025 16:54:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tfQru-0001YI-Tm
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 16:54:07 -0500
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tfQrt-0008Td-8F
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 16:54:06 -0500
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2f833af7a09so8052897a91.2
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 13:54:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738706043; x=1739310843; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AKQNLi/LAdrzzrDV1L5+9YwVJWRO7OgsuSiBwshaaYQ=;
 b=ZTxUwRMMNqdklsl7SsO4wCrW9hCx0/A17fJtfTm/Nxrxy674MaFtGJ+eDON0dla3UP
 szeOZvQjZLoJGJgvdGcIutxH6NO23ihX1KbscXYFTDrk4r0EBOehdcIUyD5EgpVUJlSY
 4KUWJHQKxDjWIspveI/41d3TLkGZxNdSEM5L7H4404AxCagVlliG7jmWpxGlMR94VnM8
 dFgG2pkfVriymcCuXjtYHUHIiNynfRNPf0QLz4TbOKixr2Jc0F6PEZgArY3/vpf/YU1c
 Jb/Q79F97iauIDfu2nya2Nlmw9adk1WAg3tC67gkYAYZB58f1wuOa0TVMLs1af3ol2/B
 RPlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738706043; x=1739310843;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AKQNLi/LAdrzzrDV1L5+9YwVJWRO7OgsuSiBwshaaYQ=;
 b=E7nsLBtQR9Kj6OdsB22+Nc6rtuOesreSHYlt5FW3HDsJwb8koLm7nEyQZEOGXTXZiV
 yc3WcvPUI/uA7X0BitigxZ08jOhS8ZR49H2ohfZpKiONkqeUSMD8fq2EInNSc/JKA0Xp
 kJImWfFn1y/w8nMy0zh17M9gp0NjxC0USSE3Pyi7CYoATz23nVWATj3d75ccA5wbHCy2
 npRpeGDN4nfqYZu91NLGYW8D/6NJIQyHB9FCafsWKCQ0es/27m3JrrK7PRMSIB70Itdi
 QNYvM6kfatlCvZ6+liRiJ7onBHgHXsNaI4mUX73lzf3CqudOulKMIJrP7FVgR/DsHFas
 EofA==
X-Gm-Message-State: AOJu0Yy/nMFKwz4QMJc1ZqRB25UZ//jaDwmvBTiPyQmNYsxeZNNeQAxR
 e4v8IAipN39SJEyZQA4thTrmBAdVm4jFY93m7J1JqyEefQI5YueFW9YpAAb/z85NAuNWTuVYZZN
 7
X-Gm-Gg: ASbGncvxNaG+hUNHFMLfphbqcvL63qAgikL1BEPXNxRtrGj2K/EhOuTLAsvRcTR2yzQ
 9x1ndT522oX54x8vHlbFQEkIgvQWzV71e/8+FcpK5QeRlEb8Cvh/OUX/JKNZ6HO3rR7qjwFSu1V
 Qfd5zk4asBlnayIIY1wfQ5wR7J9dgf6dCLJHD1tMWolmpjhPMe8nvUUrm6X4b2MvypbGkdk8Te2
 YR8b147H5gSzvj54HotV0F0M1Eu/Z4fbXHVZX4DM/vBXeMA243YzrXyaggIXn2ZoTkd/ZCqDV5S
 TryaZGpmiUqHqkejEIcrA9N+vNLlCfKRYZS6IajNr/kkXpM=
X-Google-Smtp-Source: AGHT+IEIyNpCWoPRrSri1S3vKosYJ0Dhd9ciMIIsUpFahrNobUsgH6N1jBDgLlP5PoEjjwLX6iHLnQ==
X-Received: by 2002:a17:90b:17c8:b0:2ee:f80c:688d with SMTP id
 98e67ed59e1d1-2f9e083c5a3mr533768a91.25.1738706042927; 
 Tue, 04 Feb 2025 13:54:02 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f9e1d60b57sm33888a91.9.2025.02.04.13.54.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 13:54:02 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mark.cave-ayland@ilande.co.uk, berrange@redhat.com,
 philmd@linaro.org, thuth@redhat.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v3 03/12] plugins: Uninline qemu_plugin_add_opts
Date: Tue,  4 Feb 2025 13:53:50 -0800
Message-ID: <20250204215359.1238808-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250204215359.1238808-1-richard.henderson@linaro.org>
References: <20250204215359.1238808-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
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

No need to expand this function inline.
Unexport qemu_plugin_opts to match.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/qemu/plugin.h | 9 +--------
 plugins/loader.c      | 7 ++++++-
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
index 9726a9ebf3..3efded6a3e 100644
--- a/include/qemu/plugin.h
+++ b/include/qemu/plugin.h
@@ -11,7 +11,6 @@
 #include "qemu/qemu-plugin.h"
 #include "qemu/error-report.h"
 #include "qemu/queue.h"
-#include "qemu/option.h"
 #include "qemu/plugin-event.h"
 #include "qemu/bitmap.h"
 #include "exec/memopidx.h"
@@ -44,13 +43,7 @@ get_plugin_meminfo_rw(qemu_plugin_meminfo_t i)
 }
 
 #ifdef CONFIG_PLUGIN
-extern QemuOptsList qemu_plugin_opts;
-
-static inline void qemu_plugin_add_opts(void)
-{
-    qemu_add_opts(&qemu_plugin_opts);
-}
-
+void qemu_plugin_add_opts(void);
 void qemu_plugin_opt_parse(const char *optstr, QemuPluginList *head);
 int qemu_plugin_load_list(QemuPluginList *head, Error **errp);
 
diff --git a/plugins/loader.c b/plugins/loader.c
index ebc01da9c6..35680bfc13 100644
--- a/plugins/loader.c
+++ b/plugins/loader.c
@@ -55,7 +55,7 @@ struct qemu_plugin_parse_arg {
     struct qemu_plugin_desc *curr;
 };
 
-QemuOptsList qemu_plugin_opts = {
+static QemuOptsList qemu_plugin_opts = {
     .name = "plugin",
     .implied_opt_name = "file",
     .head = QTAILQ_HEAD_INITIALIZER(qemu_plugin_opts.head),
@@ -65,6 +65,11 @@ QemuOptsList qemu_plugin_opts = {
     },
 };
 
+void qemu_plugin_add_opts(void)
+{
+    qemu_add_opts(&qemu_plugin_opts);
+}
+
 typedef int (*qemu_plugin_install_func_t)(qemu_plugin_id_t, const qemu_info_t *, int, char **);
 
 extern struct qemu_plugin_state plugin;
-- 
2.43.0


