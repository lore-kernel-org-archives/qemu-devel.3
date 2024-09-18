Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 521DACDD553
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 19:30:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sr0Gn-0004n0-LB; Wed, 18 Sep 2024 15:23:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3kyjrZgUKCs4DuF2908805y.w86Ay6E-xyFy578707E.8B0@flex--tavip.bounces.google.com>)
 id 1sr0GV-0004S6-V3
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 15:23:04 -0400
Received: from mail-yb1-xb4a.google.com ([2607:f8b0:4864:20::b4a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3kyjrZgUKCs4DuF2908805y.w86Ay6E-xyFy578707E.8B0@flex--tavip.bounces.google.com>)
 id 1sr0GU-0007II-B4
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 15:23:03 -0400
Received: by mail-yb1-xb4a.google.com with SMTP id
 3f1490d57ef6-e02b5792baaso167264276.2
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2024 12:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1726687381; x=1727292181; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=Is1Pe9Ut7+FUOXRSBGio99L8BWy9EslIqrLBu7QfCA8=;
 b=2IwRO8Kja88wJ94RMDtGQzxOQLop42HhVFpqZsYDsHz+/hQxj3KRb8UQJt0qJhjQKN
 0c5I8ObRYQNGAgt76qSQbKBpO3pnluugcnOUOtLdTzKwNVKJR4ikfCJwQTBaX644Aku8
 TLJ/nc9I0VIODmcsFbTTLCn/yhWbGjralwu1UsXuSr08ZxvBYrA87RVI46rkYHLf658l
 u7nhV8PrZBSPSdgomG3eTguzZNgbzbwQbCcoNOVO9tHqOvT2RoOQLLKXzkB2/1A7ES+H
 HACbYAANpr4ZKXU8jtUho//9XyL2C5s1ydQ0m+owmKB5qDMvibVqRKsAbievR3xe2C9b
 7ENA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726687381; x=1727292181;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Is1Pe9Ut7+FUOXRSBGio99L8BWy9EslIqrLBu7QfCA8=;
 b=K5UsYYWpLAhd8SNUYbQc1cAz7MUfW79Cmgn3PIp1iA2JZnYt8fixPJCPViIPoLx100
 8qN6sTQ56US2KZWuaaCTI1Gr2St2e8+OAgO6AsnXv4GV7v+3VVTxLO6IY03mSuzx/dAH
 bJlDD7LySjsptD55AK5H3/68eeaNuIGRuCA7fzLsYqszCeVhpoCqDHI3FsOdFCuL6o7y
 qTgg1XgtiCuG1qfjJudzcpyHmwKCuCuj/fOGqZX7MIg3iB1vGVtUIY72pyPP6JJ1HGh7
 xz6EnXiIKzFwcvNFaAklNpu8IaOrT1XMa3/vNodLsuvxnpW2r1oKY2Isrxvz0YZ91Via
 tEqg==
X-Gm-Message-State: AOJu0YzB+r5IoZ2trHjQUieJdVpUffBRfxmlw7WAVklfKHOOVTByJEkB
 42gNpZeJo0B+izeg36QYpSjsB8HMzPfJXk98tEkAd92UjIlCGUX5yj2Rr1kXE6B6o8kbMZVfLsC
 mLLlB1OGRHZ6QAPgXub2MwcZxFv3Le+lwuGWKD28rzvqtFsnM27hNCgPtk1VBn6BfPpbB+GmBun
 2X/wY7ehb8s7BOn5A0htPMtMEOeQ==
X-Google-Smtp-Source: AGHT+IHkySxgEZYLi4WMd7ZmcuN6KJFEPSj3FgsG3HRJR+GWFLkWhXgxPgIOftl6XFM+Gn5BP1pwrnQ1cQ==
X-Received: from warp10.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:750])
 (user=tavip job=sendgmr) by 2002:a25:e090:0:b0:e11:584f:c2ca with
 SMTP id
 3f1490d57ef6-e1d9dc3c15bmr55129276.6.1726687379366; Wed, 18 Sep 2024 12:22:59
 -0700 (PDT)
Date: Wed, 18 Sep 2024 12:22:30 -0700
In-Reply-To: <20240918192254.3136903-1-tavip@google.com>
Mime-Version: 1.0
References: <20240918192254.3136903-1-tavip@google.com>
X-Mailer: git-send-email 2.46.0.662.g92d0881bb0-goog
Message-ID: <20240918192254.3136903-3-tavip@google.com>
Subject: [PATCH 02/25] tests/unit: add fifo32 tests
From: Octavian Purdila <tavip@google.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, stefanst@google.com, pbonzini@redhat.com, 
 peter.maydell@linaro.org, marcandre.lureau@redhat.com, berrange@redhat.com, 
 eduardo@habkost.net, luc@lmichel.fr, damien.hedde@dahe.fr, 
 alistair@alistair23.me, thuth@redhat.com, philmd@linaro.org, jsnow@redhat.com, 
 crosa@redhat.com, lvivier@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b4a;
 envelope-from=3kyjrZgUKCs4DuF2908805y.w86Ay6E-xyFy578707E.8B0@flex--tavip.bounces.google.com;
 helo=mail-yb1-xb4a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

Add push/pop and peek tests for fifo32.

Signed-off-by: Octavian Purdila <tavip@google.com>
---
 tests/unit/test-fifo.c | 50 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/tests/unit/test-fifo.c b/tests/unit/test-fifo.c
index 14153c41fa..d0e05ba95c 100644
--- a/tests/unit/test-fifo.c
+++ b/tests/unit/test-fifo.c
@@ -13,6 +13,7 @@
 #include "qemu/osdep.h"
 #include "migration/vmstate.h"
 #include "qemu/fifo8.h"
+#include "qemu/fifo32.h"
 
 const VMStateInfo vmstate_info_uint32;
 const VMStateInfo vmstate_info_buffer;
@@ -432,6 +433,53 @@ static void test_fifo8_pushpop(void)
     fifo8_destroy(&fifo);
 }
 
+static void test_fifo32_pushpop(void)
+{
+    Fifo32 fifo;
+    uint32_t e;
+
+    fifo32_create(&fifo, 2);
+    fifo32_push(&fifo, 0x11121314);
+    fifo32_push(&fifo, 0x21222324);
+    g_assert(fifo32_num_used(&fifo) == 2);
+
+    e = fifo32_pop(&fifo);
+    g_assert(e == 0x11121314);
+    g_assert(fifo32_num_used(&fifo) == 1);
+
+    e = fifo32_peek(&fifo);
+    g_assert(e == 0x21222324);
+
+    g_assert(fifo32_num_used(&fifo) == 1);
+    fifo32_destroy(&fifo);
+}
+
+static void test_fifo32_peek(void)
+{
+    Fifo32 fifo;
+    uint32_t e;
+
+    fifo32_create(&fifo, 2);
+    fifo32_push(&fifo, 0x11121314);
+    fifo32_push(&fifo, 0x21222324);
+    g_assert(fifo32_num_used(&fifo) == 2);
+
+    e = fifo32_peek(&fifo);
+    g_assert(e == 0x11121314);
+    g_assert(fifo32_num_used(&fifo) == 2);
+
+    e = fifo32_pop(&fifo);
+    g_assert(e == 0x11121314);
+    g_assert(fifo32_num_used(&fifo) == 1);
+
+    e = fifo32_peek(&fifo);
+    g_assert(e == 0x21222324);
+    g_assert(fifo32_num_used(&fifo) == 1);
+
+    fifo32_destroy(&fifo);
+}
+
+
 int main(int argc, char *argv[])
 {
     g_test_init(&argc, &argv, NULL);
@@ -445,5 +493,7 @@ int main(int argc, char *argv[])
     g_test_add_func("/fifo8/peek_bufptr_wrap", test_fifo8_peek_bufptr_wrap);
     g_test_add_func("/fifo8/pop_bufptr", test_fifo8_pop_bufptr);
     g_test_add_func("/fifo8/pop_bufptr_wrap", test_fifo8_pop_bufptr_wrap);
+    g_test_add_func("/fifo32/pushpop", test_fifo32_pushpop);
+    g_test_add_func("/fifo32/peek", test_fifo32_peek);
     return g_test_run();
 }
-- 
2.46.0.662.g92d0881bb0-goog


