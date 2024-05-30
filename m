Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6593CC3DA40
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 17:51:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCjuX-0003rW-Hc; Thu, 30 May 2024 13:49:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sCjuV-0003qu-Gq
 for qemu-devel@nongnu.org; Thu, 30 May 2024 13:49:55 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sCjuT-0002SG-8h
 for qemu-devel@nongnu.org; Thu, 30 May 2024 13:49:55 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1f44b45d6abso8042455ad.0
 for <qemu-devel@nongnu.org>; Thu, 30 May 2024 10:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717091391; x=1717696191; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N8fpp15niTkZ3IPMy6ehe10O59rmldsghTOZNCkMcuE=;
 b=W3reaMr1N9cVY5tN/SJOoavOaYYDvJnVaHFC2zVzsrcmYgJNb/i9psC2CgYYYVgnhj
 OXCjSDBmjEpEGrBV4DTbFClZJUAmOYWvkL2Gdhxorpv21t6+SVdVgqnsPa+Xg5uPvOuK
 5XdFUUj3PH30vQvg7ZJitiW30/SLk4tJEVG7zT0Jc/92PIotwf9WSuCASq1mgttX9BBY
 KGOu/xYdQ6Es32Tseq3YtSnGP0Ll8k2MGOYbvn6aCbciX92TPAHXCgjOq52NeZolQyeh
 kjaG64oPyYYVhgkgA6uXX7a2qD9xaDODdFPkn47aitG8KyhNwOIFjUzdRBk43ZEniTj8
 rAsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717091391; x=1717696191;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N8fpp15niTkZ3IPMy6ehe10O59rmldsghTOZNCkMcuE=;
 b=QiUM71OLQ4xjrKS2daEve7ijrvLMnx7jiNHYBDsPUdR7u9V4nSTYM+vZGNqLUqDJXK
 w343Su0ly7hDZizbcOWg+jiw9HSVmBhmPe/sLx0stRl7KHUYd7zGGC4jiNpNaIoik6YL
 lMnNqXXd2RBS8nKg2ChK138a8SZVsPOINBEHkgGBeTw0a8aRfFOs+HKf1OlB0TN4G57Q
 BOyNSXw9BtR2KSwyl8t4zM2ywPwuSyxyLTtLaAyqbmYRtPRanLv8idka2RdmlN84DltX
 Dp/WaHYgDKWILYFZVd7hpJiAe7F3Yh/7xv2wXYoYh+NqCeoDd9/TP7YNZ2AUW+juJZAp
 fVFA==
X-Gm-Message-State: AOJu0YzUj58oYegDgvKKD0D3x7Nvwdjc3my3S6D+RjHdlbxmMtVTZL5G
 lDL/65xFY+t4YYeEfQjQGaqUu7tIBXlCA5TDCzngbeX528hyHyz0Juzeb1qe8ubCQ4sp1oA2hsI
 jhsA=
X-Google-Smtp-Source: AGHT+IH5YlzSC8YNw6tasuEuJt2Vl1N1ET8xo6UhJ/3oRfA/i8nZUUG1xfCq8vfFGaeLtfiw2MhbBA==
X-Received: by 2002:a17:902:c94b:b0:1f4:89e2:b47b with SMTP id
 d9443c01a7336-1f61992ee59mr33274415ad.50.1717091390928; 
 Thu, 30 May 2024 10:49:50 -0700 (PDT)
Received: from linaro.vn.shawcable.net ([2604:3d08:9384:1d00::e697])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f6323deb38sm590405ad.124.2024.05.30.10.49.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 May 2024 10:49:50 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 2/6] qtest: use cpu interface in qtest_clock_warp
Date: Thu, 30 May 2024 10:49:35 -0700
Message-Id: <20240530174939.749163-3-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240530174939.749163-1-pierrick.bouvier@linaro.org>
References: <20240530174939.749163-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62b.google.com
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

From: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Acked-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
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


