Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B8C0C54791
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 10:56:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkMH1-0005Nc-A4; Wed, 13 Mar 2024 06:55:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rkMGs-0005Fy-Id
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 06:55:46 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rkMGe-00079b-5L
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 06:55:40 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-413e7b96403so3864095e9.3
 for <qemu-devel@nongnu.org>; Wed, 13 Mar 2024 03:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710327324; x=1710932124; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2A4y2sEoIfQRif0BIyFTxg0vj8eN3cypCY900sTp17U=;
 b=HTXeTRGSsRV0o18Homys9BVeMWwuwI0EZrS+bEb85KxUCpdOOHI679UVO8YRyL/g2h
 O1Rz8z0h5UsWZvuN+QNNtPeW67lARBSEE4/zWOK7NPj/1/tjy5ZFUJzBwZZdSfor8Pf6
 dwn6WM3NkTZus9Gl0Sda9KQVa/hzutd27+vY++uAB1e909AqtKd2SonDwuHt/kTOVVxH
 RuovVmpvLda/356V2NIt2StY+zcU+DfiM1l8HONOo+BKZWGzdzL9VtJFE/fg0InroX+E
 fGGMAA3BPW6LMKnA9lU2jBuzTNndh91RUvE7QVtCmehX5JAN/dAPFu2rpt9S298/tDtR
 C+rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710327324; x=1710932124;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2A4y2sEoIfQRif0BIyFTxg0vj8eN3cypCY900sTp17U=;
 b=RRt2fWTxx+8We8ip9rf2o9q2v1GI8FKJBWHZ86pvKdjtrCjOOv5t773Z+Iw/1QPmkJ
 boHw9m1Oa4+paS6K42KijG4BK+k9/7EvPAuDR2SIud3eIrMztJdkRq6zZOIlC+YWms8a
 Bfa++5s/kQv4jTD1hGfMYuItyOAr0cZE1PPJofaUbsT8dVWPNh2tMaC4stkRqN9/uLZ7
 cbtUPgdXYOKZxJjEYpgGigBv0kTpv+N4f8aABo1tuTGPP9WBDCD3DhHXQLuIat+B5b+P
 YaFLzICyEh6DGihF73g/6oFd+UKutga+ASFv8Dbw9hTUkC10BD69BWWbD1Fek/GiP2Zw
 WvYw==
X-Gm-Message-State: AOJu0Yz0kDG3YK+uCxRKTLeNDld/WG37rYl15l0j/I8AIUiLjCPcIKqo
 AJU/wO4xvEzkLs8SbVbiQFiOTPF8rUur1XktvshD8UzZ1xrh3a8PzYVosJ2vVYqBXGG7hg+BCrx
 n22M=
X-Google-Smtp-Source: AGHT+IHWbcikkOy6DyWYKzBQVWyxJ2s+IxR2kYvfFzttjpuxWMJgBjxWJDhLrWcvjdsMGYQB/+i4Eg==
X-Received: by 2002:a05:600c:1e29:b0:413:32ff:2000 with SMTP id
 ay41-20020a05600c1e2900b0041332ff2000mr3764796wmb.36.1710327324258; 
 Wed, 13 Mar 2024 03:55:24 -0700 (PDT)
Received: from linaro.. ([102.35.208.160]) by smtp.gmail.com with ESMTPSA id
 w17-20020adfee51000000b0033e1be7f3d8sm11390338wro.70.2024.03.13.03.55.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Mar 2024 03:55:24 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [RFC PATCH 2/5] qtest: use cpu interface in qtest_clock_warp
Date: Wed, 13 Mar 2024 14:55:01 +0400
Message-Id: <20240313105504.341875-3-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240313105504.341875-1-pierrick.bouvier@linaro.org>
References: <20240313105504.341875-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wm1-x32a.google.com
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

From: Alex Bennée <alex.bennee@linaro.org>

This generalises the qtest_clock_warp code to use the AccelOps
handlers for updating its own sense of time. This will make the next
patch which moves the warp code closer to pure code motion.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Acked-by: Thomas Huth <thuth@redhat.com>
---
 include/sysemu/qtest.h | 1 +
 accel/qtest/qtest.c    | 1 +
 system/qtest.c         | 6 +++---
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/sysemu/qtest.h b/include/sysemu/qtest.h
index b5d5fd34637..45f3b7e1df5 100644
--- a/include/sysemu/qtest.h
+++ b/include/sysemu/qtest.h
@@ -36,6 +36,7 @@ void qtest_server_set_send_handler(void (*send)(void *, const char *),
 void qtest_server_inproc_recv(void *opaque, const char *buf);
 
 int64_t qtest_get_virtual_clock(void);
+void qtest_set_virtual_clock(int64_t count);
 #endif
 
 #endif
diff --git a/accel/qtest/qtest.c b/accel/qtest/qtest.c
index f6056ac8361..53182e6c2ae 100644
--- a/accel/qtest/qtest.c
+++ b/accel/qtest/qtest.c
@@ -52,6 +52,7 @@ static void qtest_accel_ops_class_init(ObjectClass *oc, void *data)
 
     ops->create_vcpu_thread = dummy_start_vcpu_thread;
     ops->get_virtual_clock = qtest_get_virtual_clock;
+    ops->set_virtual_clock = qtest_set_virtual_clock;
 };
 
 static const TypeInfo qtest_accel_ops_type = {
diff --git a/system/qtest.c b/system/qtest.c
index 6da58b3874e..ee8b139e982 100644
--- a/system/qtest.c
+++ b/system/qtest.c
@@ -332,14 +332,14 @@ int64_t qtest_get_virtual_clock(void)
     return qatomic_read_i64(&qtest_clock_counter);
 }
 
-static void qtest_set_virtual_clock(int64_t count)
+void qtest_set_virtual_clock(int64_t count)
 {
     qatomic_set_i64(&qtest_clock_counter, count);
 }
 
 static void qtest_clock_warp(int64_t dest)
 {
-    int64_t clock = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+    int64_t clock = cpus_get_virtual_clock();
     AioContext *aio_context;
     assert(qtest_enabled());
     aio_context = qemu_get_aio_context();
@@ -348,7 +348,7 @@ static void qtest_clock_warp(int64_t dest)
                                                       QEMU_TIMER_ATTR_ALL);
         int64_t warp = qemu_soonest_timeout(dest - clock, deadline);
 
-        qtest_set_virtual_clock(qtest_get_virtual_clock() + warp);
+        cpus_set_virtual_clock(cpus_get_virtual_clock() + warp);
 
         qemu_clock_run_timers(QEMU_CLOCK_VIRTUAL);
         timerlist_run_timers(aio_context->tlg.tl[QEMU_CLOCK_VIRTUAL]);
-- 
2.39.2


