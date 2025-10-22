Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 824A6CCD1AB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 19:26:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBeTh-0002tL-Sw; Wed, 22 Oct 2025 15:26:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vBeTc-0002sR-At
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 15:26:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vBeTV-0001QT-Pr
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 15:26:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761161179;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dmxRfIQ+sqvYYFl9da01pUfgcatf1F566P8Ys2epb/o=;
 b=Erk8cCFxvIIW/vi1RWNmBmT/6z5eFfXYr3Vn5Xk8C69nlP9+/6c7Vejkkuxwc5ziAOfKU5
 v/Z6q15SoItpHW0aGzVbLJGPw9U5Sr4zumxiuPz9PIpqvaW/KCTkKfcW0ADIGlChlmR/EL
 8gs3/TXNQ3lUXIqiSJDjFjgJfbMlgEQ=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-vrTuVHpUOButF8jZzEE1ZA-1; Wed, 22 Oct 2025 15:26:18 -0400
X-MC-Unique: vrTuVHpUOButF8jZzEE1ZA-1
X-Mimecast-MFC-AGG-ID: vrTuVHpUOButF8jZzEE1ZA_1761161178
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-4e895a6ca73so15858051cf.2
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 12:26:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761161177; x=1761765977;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dmxRfIQ+sqvYYFl9da01pUfgcatf1F566P8Ys2epb/o=;
 b=dyfdrN1kD346M0Hh5TTtq/yt3Bc1IiUeIrbvGnG/utrDKrT2gjJ+7/4HG7vxyVL/4N
 lbWn7qjZgal5B9HAI95DlG0a6/JAj6cEXc4Ti/c+pilPoD1cbCc2khlQLnbNE0OVGb/r
 MVZTVF6tCjwg0NP06/y3A8IU8ZG42YKn5B9ao/jznIKWVXcW1nYpZ8wkdCT63h9KA5sX
 lVSEAMfNXguZ+ml/LlVGRvxQOKrMp23EEZxU8spd8l/Ob2Uv4F9gIz3xDv1hZIcWHNEe
 2npBYLKR31Z0jt50QFJubMuKe50mGqtkA1+Y8y118Byd4kZBSoVAwFk2h1dZHi1wmRLB
 latg==
X-Gm-Message-State: AOJu0YzDJxwYkhei2FUiOTpmRiT03mqUGkUsEFS2g4T6vTjntFxcpnLh
 OtID5Htzr45ZjSqHIgXb4aNVN3tNZaYUSG6FDowGbX9HZqBNjLdFLywV36cevhuGE9LP69CBEsC
 2Y5FnVVQGSISdkMpRy71gXBgkzeTnzw1workdcD9XTSiU7Eo4yVaTE6ZM5GdRALkvk2moigwqGx
 caqbgTCeLsxFbIevGetTGgYTUkSo+Xm7x+3i04pA==
X-Gm-Gg: ASbGncuHd9FAM0rdgn0C2yPMvxuUpRs4o5YItiMcwihe6ZfEOxVJMy+syeo6XMdR5Ga
 MYVCTvYEiKacb/Vi+ua9HvPUgZqXKEgi3G5AYCn/wqcsc1EXUWgWP2QHypSuiVbjAyGknYQRHAy
 J7OqBrYAZMoNq1Y0QMh0v+G0ErK29QZK3UK0bkP4SULZVlCvJhJ6HwZXw3C82MZ+zQGJGE4sP+o
 qxNrDCisl+BR10veW/yTWB3g1Gg/XefPz1+FwBdqvJuuuDCkRwknqxALwAAu8/IpG/yVILjzArc
 4LdxuwzSWcc6TOEiZkj4kRYvyYkClnZZfqNxIPtYer+fTgZoNCFA35Z2EGQcik3T
X-Received: by 2002:a05:622a:11c4:b0:4e5:8352:9db2 with SMTP id
 d75a77b69052e-4e89d3f3eb9mr266588191cf.74.1761161177345; 
 Wed, 22 Oct 2025 12:26:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRioOfkw7DIT0mYQwuJiZgOJNMQAWRhYH4cDScwSXfN/lL1J4Ga6snRnj0nxPIwKo2v4AX0w==
X-Received: by 2002:a05:622a:11c4:b0:4e5:8352:9db2 with SMTP id
 d75a77b69052e-4e89d3f3eb9mr266587681cf.74.1761161176698; 
 Wed, 22 Oct 2025 12:26:16 -0700 (PDT)
Received: from x1.com ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4e8aaf34307sm99748561cf.1.2025.10.22.12.26.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Oct 2025 12:26:16 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Li Zhijian <lizhijian@fujitsu.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>, Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 peterx@redhat.com,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Zhang Chen <zhangckid@gmail.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Prasad Pandit <ppandit@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Yury Kotov <yury-kotov@yandex-team.ru>, Juraj Marcin <jmarcin@redhat.com>
Subject: [PATCH 01/13] io: Add qio_channel_wait_cond() helper
Date: Wed, 22 Oct 2025 15:26:00 -0400
Message-ID: <20251022192612.2737648-2-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251022192612.2737648-1-peterx@redhat.com>
References: <20251022192612.2737648-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add the helper to wait for QIO channel's IO availability in any
context (coroutine, or non-coroutine).  Use it tree-wide for three
occurences.

Cc: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/io/channel.h  | 15 +++++++++++++++
 io/channel.c          | 21 +++++++++++----------
 migration/qemu-file.c |  6 +-----
 3 files changed, 27 insertions(+), 15 deletions(-)

diff --git a/include/io/channel.h b/include/io/channel.h
index 0f25ae0069..d6d5bf2b5f 100644
--- a/include/io/channel.h
+++ b/include/io/channel.h
@@ -871,6 +871,21 @@ void qio_channel_wake_read(QIOChannel *ioc);
 void qio_channel_wait(QIOChannel *ioc,
                       GIOCondition condition);
 
+/**
+ * qio_channel_wait_cond:
+ * @ioc: the channel object
+ * @condition: the I/O condition to wait for
+ *
+ * Block execution from the current thread until
+ * the condition indicated by @condition becomes
+ * available.
+ *
+ * This will work with/without a coroutine context, by automatically select
+ * the proper API to wait.
+ */
+void qio_channel_wait_cond(QIOChannel *ioc,
+                           GIOCondition condition);
+
 /**
  * qio_channel_set_aio_fd_handler:
  * @ioc: the channel object
diff --git a/io/channel.c b/io/channel.c
index 852e684938..b18fc346ff 100644
--- a/io/channel.c
+++ b/io/channel.c
@@ -159,11 +159,7 @@ int coroutine_mixed_fn qio_channel_readv_full_all_eof(QIOChannel *ioc,
         len = qio_channel_readv_full(ioc, local_iov, nlocal_iov, local_fds,
                                      local_nfds, flags, errp);
         if (len == QIO_CHANNEL_ERR_BLOCK) {
-            if (qemu_in_coroutine()) {
-                qio_channel_yield(ioc, G_IO_IN);
-            } else {
-                qio_channel_wait(ioc, G_IO_IN);
-            }
+            qio_channel_wait_cond(ioc, G_IO_IN);
             continue;
         }
 
@@ -268,11 +264,7 @@ int coroutine_mixed_fn qio_channel_writev_full_all(QIOChannel *ioc,
                                             nfds, flags, errp);
 
         if (len == QIO_CHANNEL_ERR_BLOCK) {
-            if (qemu_in_coroutine()) {
-                qio_channel_yield(ioc, G_IO_OUT);
-            } else {
-                qio_channel_wait(ioc, G_IO_OUT);
-            }
+            qio_channel_wait_cond(ioc, G_IO_OUT);
             continue;
         }
         if (len < 0) {
@@ -774,6 +766,15 @@ void qio_channel_wait(QIOChannel *ioc,
     g_main_context_unref(ctxt);
 }
 
+void qio_channel_wait_cond(QIOChannel *ioc,
+                           GIOCondition condition)
+{
+    if (qemu_in_coroutine()) {
+        qio_channel_yield(ioc, condition);
+    } else {
+        qio_channel_wait(ioc, condition);
+    }
+}
 
 static void qio_channel_finalize(Object *obj)
 {
diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index 2d4ce174a5..4b5a409a80 100644
--- a/migration/qemu-file.c
+++ b/migration/qemu-file.c
@@ -343,11 +343,7 @@ static ssize_t coroutine_mixed_fn qemu_fill_buffer(QEMUFile *f)
                                      QIO_CHANNEL_READ_FLAG_FD_PRESERVE_BLOCKING,
                                      &local_error);
         if (len == QIO_CHANNEL_ERR_BLOCK) {
-            if (qemu_in_coroutine()) {
-                qio_channel_yield(f->ioc, G_IO_IN);
-            } else {
-                qio_channel_wait(f->ioc, G_IO_IN);
-            }
+            qio_channel_wait_cond(f->ioc, G_IO_IN);
         }
     } while (len == QIO_CHANNEL_ERR_BLOCK);
 
-- 
2.50.1


