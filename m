Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4365ECED24D
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 01:23:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxysy-0008Cd-Kj; Mon, 07 Oct 2024 21:19:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3gYgEZwUKCuIXEZMTKSSKPI.GSQUIQY-HIZIPRSRKRY.SVK@flex--tavip.bounces.google.com>)
 id 1sxysQ-0007br-5l
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 21:19:03 -0400
Received: from mail-yw1-x114a.google.com ([2607:f8b0:4864:20::114a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3gYgEZwUKCuIXEZMTKSSKPI.GSQUIQY-HIZIPRSRKRY.SVK@flex--tavip.bounces.google.com>)
 id 1sxysO-00006w-FD
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 21:19:01 -0400
Received: by mail-yw1-x114a.google.com with SMTP id
 00721157ae682-6e30cf0cf1bso16065357b3.0
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 18:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1728350338; x=1728955138; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=wyZg7kxpkNCds2EZflCHxHMwXfcdXxrO/ZcaHcLL39s=;
 b=sUmZs6x50LQ/pe4Gez4ZK7t8kjzZvn/cx2qAoJC/7Y4F68dzQ2xvg5k45/wjdGXgo3
 hFQf/wA/gJMDCEmbwjZvVkLT1pCF9CcYNQz50G99FM2uXCZx57Db8ZQLDjWvdLu9qFQT
 ovBzXs1neqv3tzxBZce9oLOY7tmfUHv2RgCc3RbJlZH4rsWqQLF/aT7ccrIFGNrnYufX
 jIMQ9zzLKMsc57TWkNSR/qvyorhy+F9gQ3Jj93KlQJzgiVw2qwdwNDlQzNIpd1ps0MaM
 ZfsQsRSiBCoTu1ogZkiFizMVw9hIB36Ew55tHEq013wHhq03py+2Mj/uno8nxwVXKBIa
 ueKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728350338; x=1728955138;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wyZg7kxpkNCds2EZflCHxHMwXfcdXxrO/ZcaHcLL39s=;
 b=oiE3LkJ3p75jGNwaF01xmFwjh718Hq5GsvpSZnLxLlwlLE0xCEt/7nbKSJSAA1IiiV
 EArxJDTWfmJKQ76KHEXLGw4awBb62z0T+94EYgwyQKhOR8IIEVMUIlkKjmcYSKeH4U9M
 gc9M30CMyq+HrPVAATxUw/hp8cIZ7Alqo51EjjW++W6jKy7BKzUKAUCwylfZlspmGEBZ
 JbI6XtKkXZJgi2CGR+BcvuimcswVN40kHl8pRtwMxU5PD3fHFVaoEs7P6OfSVigj/EP9
 nYUgCB7W/1TG1cCJSKO0qD2ILJFN6TkE0IpCoCuoquNRaYkUVjKCPWeYPXzCBVk/m4EG
 gOTw==
X-Gm-Message-State: AOJu0YymgggF4pwxu9UxSNvjHATwKkv4aLitwurhwsJ3lQluZN1sZrDd
 8RjrgHoiWQ/LUmNnwiAWr70n4jx/VODidx0RG+iprZCM+GQnsn3Skfbx9rjfleLKVlk9RBZ/jbI
 vlMzmxV+xkRBItm+BxTJ4ITe/bb4X8liu5qsGB+cDgcsku26pGwK3Qav+55vnLT8ZgEQs1xwbNI
 T3tBHS28fJpxNz9cX8PL7cjwuIKw==
X-Google-Smtp-Source: AGHT+IE3/W9CgSMU393ZW56+VU+vEEAMQd6ttBYHzgtNP0gr2mWHRr9OJi2xXWSJjWwG7FxSWygOJf1nyg==
X-Received: from warp10.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:750])
 (user=tavip job=sendgmr) by 2002:a81:b513:0:b0:6e3:eab:18b1 with
 SMTP id
 00721157ae682-6e30eab1934mr52557b3.1.1728350337999; Mon, 07 Oct 2024 18:18:57
 -0700 (PDT)
Date: Mon,  7 Oct 2024 18:18:28 -0700
In-Reply-To: <20241008011852.1439154-1-tavip@google.com>
Mime-Version: 1.0
References: <20241008011852.1439154-1-tavip@google.com>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <20241008011852.1439154-3-tavip@google.com>
Subject: [PATCH v2 02/25] tests/unit: add fifo32 tests
From: Octavian Purdila <tavip@google.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, stefanst@google.com, pbonzini@redhat.com, 
 peter.maydell@linaro.org, marcandre.lureau@redhat.com, berrange@redhat.com, 
 eduardo@habkost.net, luc@lmichel.fr, damien.hedde@dahe.fr, 
 alistair@alistair23.me, thuth@redhat.com, philmd@linaro.org, jsnow@redhat.com, 
 crosa@redhat.com, lvivier@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::114a;
 envelope-from=3gYgEZwUKCuIXEZMTKSSKPI.GSQUIQY-HIZIPRSRKRY.SVK@flex--tavip.bounces.google.com;
 helo=mail-yw1-x114a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.024,
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
2.47.0.rc0.187.ge670bccf7e-goog


