Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0A6DC54E41
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 14:12:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rebhk-0003Cu-Ha; Mon, 26 Feb 2024 09:11:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rebhj-0003Ca-9V
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 09:11:39 -0500
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rebhh-00026Z-IO
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 09:11:39 -0500
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-51197ca63f5so4704273e87.1
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 06:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708956696; x=1709561496; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WqJvgmD2xSxG0JQjLIcAdWT5nW/VU/NqNnXte/SlaSQ=;
 b=fDCz4KaVpB+M2bdcQdv/WbPRVXaODcE/twaxehBDIPvMpuobHDplE7ofy9iwdwQb4g
 2Jere7GIvGEtBH+JZas/e1G8U6reHsQY8V48QTm6zOpHmONj1AqtllxL/WixjMQo0D7H
 UY98DUE/hFxN2x6bMqTH/y32p9m7LFHOvBrr6vQ/lmkof4ndRPEkrFyyxc7pwVKQHAB+
 fgisbkZ/lIRJI1XAvYhJnFB6eEAVEiZgszvsZ81p3F6QxEPGU0/Of1wMZPeyGBR4oh7O
 WhXha1CVHPuVYnimM4olkmRdP0fXn2fCWHNzw5YDZrZc2BC0sFwNcvesJq/GQBNqatXX
 DOMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708956696; x=1709561496;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WqJvgmD2xSxG0JQjLIcAdWT5nW/VU/NqNnXte/SlaSQ=;
 b=NCVT9q+2/plKAkG8LEnyULGMkNcqFHXrseumUwspyi3xy9Gdrch17rjieT7Cl9hH/r
 obt0JxZpcV+KXafW7EkX/a36JHLvKXATe8WQODbOWEcT5tmvKObJ+OUFEZ4EH8mQ7LZY
 fsJMmjiU0tgoX0aKBrzLq5lWcyyjcMW5xaurP9zMwc+vVyxUDv0dbya+NYcbbiFTsbFi
 iKyLH/iaxuKvokX/pe1SJcLZpRf6hoKB3F77u+C0Qzu/NI2lsQJosZ7C0WUjR88t+XaD
 5P7QIkeRFQ3FAnCGlxN0/JbvmwNrPtxECXTUf0reiJqnET/VkrM1ZaDJgOeh+nCoRzCM
 Qr8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxVX0BJQ+9GMYYIF0yDT8b50n96uy3YPQOe8DaVOZqLWqI0PFF5rHsx8Cn+Imkai/J1lfphla2Kivx/BGo/CfhoTtW5kU=
X-Gm-Message-State: AOJu0YyG/A3ZZF4xvrAq35QifDjfIhHTnNbaGF4OPRnALfWgaX+DYWe0
 NuYU8WU8/MH1uuGrlWXjQiNwYufs4cVbiwV6SAybuY+tGO+2IhQzEPht0tTE1yg=
X-Google-Smtp-Source: AGHT+IFy7Kz8UxGVoTYHzdHFYMQ5Kogk9oFyxnqGzEnLlbDRElYDdUN1yJ05h9Ebt3hS6L+tibMPRw==
X-Received: by 2002:ac2:4344:0:b0:512:bebf:1a with SMTP id
 o4-20020ac24344000000b00512bebf001amr4798235lfl.57.1708956695939; 
 Mon, 26 Feb 2024 06:11:35 -0800 (PST)
Received: from m1x-phil.lan ([176.187.223.153])
 by smtp.gmail.com with ESMTPSA id
 vo9-20020a170907a80900b00a4136d18988sm2452797ejc.36.2024.02.26.06.11.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 26 Feb 2024 06:11:35 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Steve Sistare <steven.sistare@oracle.com>
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Jason Wang <jasowang@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v6 4/5] util: strList unit tests
Date: Mon, 26 Feb 2024 15:11:06 +0100
Message-ID: <20240226141108.73664-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240226141108.73664-1-philmd@linaro.org>
References: <20240226141108.73664-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12f.google.com
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

From: Steve Sistare <steven.sistare@oracle.com>

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <1708638470-114846-5-git-send-email-steven.sistare@oracle.com>
---
 tests/unit/test-strList.c | 80 +++++++++++++++++++++++++++++++++++++++
 tests/unit/meson.build    |  1 +
 2 files changed, 81 insertions(+)
 create mode 100644 tests/unit/test-strList.c

diff --git a/tests/unit/test-strList.c b/tests/unit/test-strList.c
new file mode 100644
index 0000000000..40af6b2ad1
--- /dev/null
+++ b/tests/unit/test-strList.c
@@ -0,0 +1,80 @@
+/*
+ * Copyright (c) 2022 - 2024 Oracle and/or its affiliates.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/strList.h"
+
+static strList *make_list(int length)
+{
+    strList *head = 0, *list, **prev = &head;
+
+    while (length--) {
+        list = *prev = g_new0(strList, 1);
+        list->value = g_strdup("aaa");
+        prev = &list->next;
+    }
+    return head;
+}
+
+static void test_length(void)
+{
+    strList *list;
+    int i;
+
+    for (i = 0; i < 5; i++) {
+        list = make_list(i);
+        g_assert_cmpint(i, ==, QAPI_LIST_LENGTH(list));
+        qapi_free_strList(list);
+    }
+}
+
+struct {
+    const char *string;
+    const char *delim;
+    const char *argv[5];
+} list_data[] = {
+    { NULL, ",", { NULL } },
+    { "", ",", { NULL } },
+    { "a", ",", { "a", NULL } },
+    { "a,b", ",", { "a", "b", NULL } },
+    { "a,b,c", ",", { "a", "b", "c", NULL } },
+    { "first last", " ", { "first", "last", NULL } },
+    { "a:", ":", { "a", "", NULL } },
+    { "a::b", ":", { "a", "", "b", NULL } },
+    { ":", ":", { "", "", NULL } },
+    { ":a", ":", { "", "a", NULL } },
+    { "::a", ":", { "", "", "a", NULL } },
+};
+
+static void test_strv(void)
+{
+    int i, j;
+    const char **expect;
+    strList *list;
+    char **argv;
+
+    for (i = 0; i < ARRAY_SIZE(list_data); i++) {
+        expect = list_data[i].argv;
+        list = str_split(list_data[i].string, list_data[i].delim);
+        argv = strv_from_strList(list);
+        qapi_free_strList(list);
+        for (j = 0; expect[j] && argv[j]; j++) {
+            g_assert_cmpstr(expect[j], ==, argv[j]);
+        }
+        g_assert_null(expect[j]);
+        g_assert_null(argv[j]);
+        g_strfreev(argv);
+    }
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+    g_test_add_func("/test-string/length", test_length);
+    g_test_add_func("/test-string/strv", test_strv);
+    return g_test_run();
+}
diff --git a/tests/unit/meson.build b/tests/unit/meson.build
index cae925c132..9984860f0f 100644
--- a/tests/unit/meson.build
+++ b/tests/unit/meson.build
@@ -35,6 +35,7 @@ tests = {
   'test-rcu-simpleq': [],
   'test-rcu-tailq': [],
   'test-rcu-slist': [],
+  'test-strList': [],
   'test-qdist': [],
   'test-qht': [],
   'test-qtree': [],
-- 
2.41.0


