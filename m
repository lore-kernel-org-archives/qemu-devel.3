Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ADA4D1624B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 11:45:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0JUn-0006hB-Bc; Mon, 14 Oct 2024 07:44:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1t0JUY-0006dD-31
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 07:44:02 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1t0JUU-00057Y-Qi
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 07:44:01 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5c94dd7e1c0so3907004a12.0
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2024 04:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728906232; x=1729511032; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Twyv6YldhETnLvxZDkBVahrdEIkG4B6Hw1qzwu/nBjU=;
 b=Vz3CAVBo8BxFALYD/1nC0nE1F9RJqR3UuIgO8lZOfs50tld28l46K4Z8GKKr5eyMdU
 t2qe8Vzp3FlHaBH3/qh17xndMN/D0KVwEVL6y1Za/+Cpx1cQnRdd+VbAgspnn/8LEkX+
 pVSJs4IqsNXd8B5ZmJ/zHsDCQzUMUn5VYxggKC3+u/4yOyPhGHC/8U+6WS1V08E5qOLO
 7XdBYw2D1zxHpNqbiigelPEpavo0ZilQWGIqWyv16orGzyYIqewsEtDay1pWIHTWs7B1
 Fie4BRrMVPkEfOEKUPqPdqbA/MhRZGp5fv1UrjKKQYvGxQOop4ikR4zyhVge9pfMwgWD
 E9YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728906232; x=1729511032;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Twyv6YldhETnLvxZDkBVahrdEIkG4B6Hw1qzwu/nBjU=;
 b=XW6lLcOsrw57cvW5wSvfvDxsUE2QDJ4bG33KdbL2VkKX6zBpVkM7m4MZfciS5jm/Gi
 RQADF1IXwAN96vFN/GBl4EapdiwKZhf25a9p1o6k+0IgbrhMPo6a9/w4aLbIiV4XI4GG
 jyJ8+6ik8Rgp8HCvxBSUSNBdm4bm+BwXOZ65gzRuoLv58A1p5/NTrUtZN+i924P/ZJ9o
 9jQNzvU7OZdyn5pSmY5SgvTUfxontiUG9slgWEDcIHoNW8HKzEjDg+tkw5px0rYDdvmM
 yST5FcLfq6Be3xT6EpiJgrlsv2S6UogjktE06AFhOYo/+rHVOTEiChGejGfhZKSDonP7
 tHsg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV6yWibw/BQgvmUlpDD7umwNzkSLXa4LmrtHtxpl+zLVN+fEHb7IbyJi3QSXcJPrMsax8Vst8TBOMxb@nongnu.org
X-Gm-Message-State: AOJu0YyKMQVzociLNEAun7W6VSewniGh7fRj8uHpR1J7UCGPgfho+Xi4
 lhUDVdKt8JqlmLwjDVALlLkBbFlQkXyI4K5UWE8Uf38dddQy+j7S
X-Google-Smtp-Source: AGHT+IHMxOLYo5Hs9T1CLmrtnrsaqrE3a+Ue2Oc6y0E0YO1QVi6rszYnCN5rzQYiizMBrwPjjJxjZA==
X-Received: by 2002:a17:907:e6cc:b0:a86:94e2:2a47 with SMTP id
 a640c23a62f3a-a99e3b5a86dmr683236066b.15.1728906231750; 
 Mon, 14 Oct 2024 04:43:51 -0700 (PDT)
Received: from finn.fritz.box ([2a02:8109:8384:1400:eb7f:8fd0:f96c:766b])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a99fcb2765asm247764666b.64.2024.10.14.04.43.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2024 04:43:51 -0700 (PDT)
From: Roman Penyaev <r.peniaev@gmail.com>
To: 
Cc: Roman Penyaev <r.peniaev@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Subject: [PATCH 8/8] tests/unit/test-char: implement a few mux remove test
 cases
Date: Mon, 14 Oct 2024 13:41:35 +0200
Message-Id: <20241014114135.389766-9-r.peniaev@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241014114135.389766-1-r.peniaev@gmail.com>
References: <20241014114135.389766-1-r.peniaev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=r.peniaev@gmail.com; helo=mail-ed1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

This patch tests:

1. feasibility of removing mux which does not have frontends attached
   or frontends were prior detached.
2. inability to remove mux which has frontends attached (mux is "busy")

Signed-off-by: Roman Penyaev <r.peniaev@gmail.com>
Cc: "Marc-André Lureau" <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org
---
 tests/unit/test-char.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/tests/unit/test-char.c b/tests/unit/test-char.c
index f273ce522612..2837dbb863a8 100644
--- a/tests/unit/test-char.c
+++ b/tests/unit/test-char.c
@@ -1,6 +1,7 @@
 #include "qemu/osdep.h"
 #include <glib/gstdio.h>
 
+#include "qapi/error.h"
 #include "qemu/config-file.h"
 #include "qemu/module.h"
 #include "qemu/option.h"
@@ -184,6 +185,21 @@ static void char_mux_test(void)
     char *data;
     FeHandler h1 = { 0, false, 0, false, }, h2 = { 0, false, 0, false, };
     CharBackend chr_be1, chr_be2;
+    Error *error = NULL;
+
+    /* Create mux and chardev to be immediately removed */
+    opts = qemu_opts_create(qemu_find_opts("chardev"), "mux-label",
+                            1, &error_abort);
+    qemu_opt_set(opts, "backend", "ringbuf", &error_abort);
+    qemu_opt_set(opts, "size", "128", &error_abort);
+    qemu_opt_set(opts, "mux", "on", &error_abort);
+    chr = qemu_chr_new_from_opts(opts, NULL, &error_abort);
+    g_assert_nonnull(chr);
+    qemu_opts_del(opts);
+
+    /* Remove just created mux and chardev */
+    qmp_chardev_remove("mux-label", &error_abort);
+    qmp_chardev_remove("mux-label-base", &error_abort);
 
     opts = qemu_opts_create(qemu_find_opts("chardev"), "mux-label",
                             1, &error_abort);
@@ -334,7 +350,13 @@ static void char_mux_test(void)
     g_free(data);
 
     qemu_chr_fe_deinit(&chr_be1, false);
-    qemu_chr_fe_deinit(&chr_be2, true);
+
+    error = NULL;
+    qmp_chardev_remove("mux-label", &error);
+    g_assert_cmpstr(error_get_pretty(error), ==, "Chardev 'mux-label' is busy");
+
+    qemu_chr_fe_deinit(&chr_be2, false);
+    qmp_chardev_remove("mux-label", &error_abort);
 }
 
 
-- 
2.34.1


