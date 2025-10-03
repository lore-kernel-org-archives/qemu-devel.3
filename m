Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B911CCD183
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 15:49:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4hur-0005Pp-3H; Fri, 03 Oct 2025 11:41:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v4huE-0004vc-Sk
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 11:41:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v4htg-0007hD-K4
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 11:41:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759506034;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T0/nyFBaVoJPZRe55G/WrZ5P44oPqX5j/lZDFrvMLQQ=;
 b=PTQNgpG0Bg1v2DMlfCz2i4WoKV3M33hcnyCB7lcbO8QP7mRXCrjTIB2g5X/+0GdQ0UQGpe
 n9dzN+m1Ig1MvxclAadTtN9jd9VFD4QhgxEqYBXOUEna6kPFI0Oy5xCDsdTvgE1u6Nc5P3
 9v3E2rr8/fGorwczyD0ZrC94iedCA2U=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-187-eZ7CGX59OoCKihsiIYuiPQ-1; Fri, 03 Oct 2025 11:40:32 -0400
X-MC-Unique: eZ7CGX59OoCKihsiIYuiPQ-1
X-Mimecast-MFC-AGG-ID: eZ7CGX59OoCKihsiIYuiPQ_1759506032
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-78efb3e2738so3650076d6.3
 for <qemu-devel@nongnu.org>; Fri, 03 Oct 2025 08:40:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759506032; x=1760110832;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T0/nyFBaVoJPZRe55G/WrZ5P44oPqX5j/lZDFrvMLQQ=;
 b=EeOgd37NJ4jCVyPM45Tf4UsDvyoZitfE7OSDWmn4LtE1OQedS5ga1rYDyDup6gcbqx
 5aIRmcsHpBhfSRZke9R6imjohGPJuho4ZkK1x4+eqvJVKC3JP90z3d8lRI/kVvWXZ17v
 ZFAvSEVMQSGNwoQA/2jlgt8qq0cApH0WfwIAt2BYfyVGtJZfyzo13gSdJBWeU40i4MaD
 F05LL8LSoIMq/Fi+fRgyo3207OznRKzlrPHIZc3fmxrF90wT6gTfFigiuEDPt0FmBFnl
 klimsmuCW7wTdB2GiXASoFS6dpeZTk2+4SbW1rF0+29o4ue/VCBWXQSokQPA9jPS7jnx
 8sig==
X-Forwarded-Encrypted: i=1;
 AJvYcCVK4D8C8evrju3a8Rh7bN8UlGepCisyXo3D4GInqq5VMCD2Wt2shoWa+V+TgdjNPqIe++TL8jlHnQ/a@nongnu.org
X-Gm-Message-State: AOJu0Yx/66ps7OooYmi6R7ECFFckZA40uKLzbv3LtfpvQeycperVa3FU
 aMqb6Mqvo52B1eDh87Sj8heGUWGfhdOwF9W2DBWA0yrDuOFcfKjZ5Ft6CBWKsn6Sa2/OYSsNNNz
 hZNd15HGuvLPPNrz0Z+yz1pmLDLRNMrUkGGW7Vucv09MVJ9MmNm8Pzl4WKXjsAwHP
X-Gm-Gg: ASbGncvKERiqC8SDrkpPixX+YBTpyQLiDDn/Oq5AiHMJQaEdmY0JNYMFxm0VX2OT6iu
 ZMrNYYEMaUD8TZ6k1Br74ZLxTwP+J3lyGpac1Yl2DKcKwV5z9yQXvVUdGdsTpcIpm/maqNuIGVs
 FOJ0Fe0EtcaU1VW8MMxPZjOouWmsRbbiVgcJEzH6LymQxj0m25N/2PCnbdKgMB1UdyW+oPPJhbK
 wI/gHz64DWCaC1vPAC/wzEwvtQK2ZLpa0Vq/rI+3B24Dq2hQiQdHHFfrK1rbGHc9WmMOOkW4ZNI
 T0MqRIGI3iierQbCFjgrNttlwJGJ99CDATuOVw==
X-Received: by 2002:a05:6214:3319:20b0:879:defa:a6f2 with SMTP id
 6a1803df08f44-879defaa90emr29172996d6.18.1759506031608; 
 Fri, 03 Oct 2025 08:40:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRfdOJVesO7v5AxA4+gcYoIZavZi9MKvuDld3bEypJkFJUsdUWrpt1Yie+vhNSOtdv1/s2gQ==
X-Received: by 2002:a05:6214:3319:20b0:879:defa:a6f2 with SMTP id
 6a1803df08f44-879defaa90emr29172526d6.18.1759506031046; 
 Fri, 03 Oct 2025 08:40:31 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-878bb53d91fsm40656746d6.23.2025.10.03.08.40.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 08:40:30 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, peterx@redhat.com,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: [PULL 27/45] io/crypto: Move tls premature termination handling into
 QIO layer
Date: Fri,  3 Oct 2025 11:39:30 -0400
Message-ID: <20251003153948.1304776-28-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251003153948.1304776-1-peterx@redhat.com>
References: <20251003153948.1304776-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.467,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

QCryptoTLSSession allows TLS premature termination in two cases, one of the
case is when the channel shutdown() is invoked on READ side.

It's possible the shutdown() happened after the read thread blocked at
gnutls_record_recv().  In this case, we should allow the premature
termination to happen.

The problem is by the time qcrypto_tls_session_read() was invoked,
tioc->shutdown may not have been set, so this may instead be treated as an
error if there is concurrent shutdown() calls.

To allow the flag to reflect the latest status of tioc->shutdown, move the
check upper into the QIOChannel level, so as to read the flag only after
QEMU gets an GNUTLS_E_PREMATURE_TERMINATION.

When at it, introduce qio_channel_tls_allow_premature_termination() helper
to make the condition checks easier to read.  When doing so, change the
qatomic_load_acquire() to qatomic_read(): here we don't need any ordering
of memory accesses, but reading a flag.  qatomic_read() would suffice
because it guarantees fetching from memory.  Nothing else we should need to
order on memory access.

This patch will fix a qemu qtest warning when running the preempt tls test,
reporting premature termination:

QTEST_QEMU_BINARY=./qemu-system-x86_64 ./tests/qtest/migration-test --full -r /x86_64/migration/postcopy/preempt/tls/psk
...
qemu-kvm: Cannot read from TLS channel: The TLS connection was non-properly terminated.
...

In this specific case, the error was set by postcopy_preempt_thread, which
normally will be concurrently shutdown()ed by the main thread.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Juraj Marcin <jmarcin@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20250918203937.200833-2-peterx@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/crypto/tlssession.h | 10 +++-------
 crypto/tlssession.c         |  7 ++-----
 io/channel-tls.c            | 21 +++++++++++++++++++--
 3 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/include/crypto/tlssession.h b/include/crypto/tlssession.h
index 2f62ce2d67..2e9fe11cf6 100644
--- a/include/crypto/tlssession.h
+++ b/include/crypto/tlssession.h
@@ -110,6 +110,7 @@
 typedef struct QCryptoTLSSession QCryptoTLSSession;
 
 #define QCRYPTO_TLS_SESSION_ERR_BLOCK -2
+#define QCRYPTO_TLS_SESSION_PREMATURE_TERMINATION -3
 
 /**
  * qcrypto_tls_session_new:
@@ -259,7 +260,6 @@ ssize_t qcrypto_tls_session_write(QCryptoTLSSession *sess,
  * @sess: the TLS session object
  * @buf: to fill with plain text received
  * @len: the length of @buf
- * @gracefulTermination: treat premature termination as graceful EOF
  * @errp: pointer to hold returned error object
  *
  * Receive up to @len bytes of data from the remote peer
@@ -267,22 +267,18 @@ ssize_t qcrypto_tls_session_write(QCryptoTLSSession *sess,
  * qcrypto_tls_session_set_callbacks(), decrypt it and
  * store it in @buf.
  *
- * If @gracefulTermination is true, then a premature termination
- * of the TLS session will be treated as indicating EOF, as
- * opposed to an error.
- *
  * It is an error to call this before
  * qcrypto_tls_session_handshake() returns
  * QCRYPTO_TLS_HANDSHAKE_COMPLETE
  *
  * Returns: the number of bytes received,
  * or QCRYPTO_TLS_SESSION_ERR_BLOCK if the receive would block,
- * or -1 on error.
+ * or QCRYPTO_TLS_SESSION_PREMATURE_TERMINATION if a premature termination
+ * is detected, or -1 on error.
  */
 ssize_t qcrypto_tls_session_read(QCryptoTLSSession *sess,
                                  char *buf,
                                  size_t len,
-                                 bool gracefulTermination,
                                  Error **errp);
 
 /**
diff --git a/crypto/tlssession.c b/crypto/tlssession.c
index 86d407a142..ac38c2121d 100644
--- a/crypto/tlssession.c
+++ b/crypto/tlssession.c
@@ -552,7 +552,6 @@ ssize_t
 qcrypto_tls_session_read(QCryptoTLSSession *session,
                          char *buf,
                          size_t len,
-                         bool gracefulTermination,
                          Error **errp)
 {
     ssize_t ret;
@@ -570,9 +569,8 @@ qcrypto_tls_session_read(QCryptoTLSSession *session,
     if (ret < 0) {
         if (ret == GNUTLS_E_AGAIN) {
             return QCRYPTO_TLS_SESSION_ERR_BLOCK;
-        } else if ((ret == GNUTLS_E_PREMATURE_TERMINATION) &&
-                   gracefulTermination){
-            return 0;
+        } else if (ret == GNUTLS_E_PREMATURE_TERMINATION) {
+            return QCRYPTO_TLS_SESSION_PREMATURE_TERMINATION;
         } else {
             if (session->rerr) {
                 error_propagate(errp, session->rerr);
@@ -789,7 +787,6 @@ ssize_t
 qcrypto_tls_session_read(QCryptoTLSSession *sess,
                          char *buf,
                          size_t len,
-                         bool gracefulTermination,
                          Error **errp)
 {
     error_setg(errp, "TLS requires GNUTLS support");
diff --git a/io/channel-tls.c b/io/channel-tls.c
index 7135896f79..1fbed4be0c 100644
--- a/io/channel-tls.c
+++ b/io/channel-tls.c
@@ -346,6 +346,19 @@ static void qio_channel_tls_finalize(Object *obj)
     qcrypto_tls_session_free(ioc->session);
 }
 
+static bool
+qio_channel_tls_allow_premature_termination(QIOChannelTLS *tioc, int flags)
+{
+    if (flags & QIO_CHANNEL_READ_FLAG_RELAXED_EOF) {
+        return true;
+    }
+
+    if (qatomic_read(&tioc->shutdown) & QIO_CHANNEL_SHUTDOWN_READ) {
+        return true;
+    }
+
+    return false;
+}
 
 static ssize_t qio_channel_tls_readv(QIOChannel *ioc,
                                      const struct iovec *iov,
@@ -364,8 +377,6 @@ static ssize_t qio_channel_tls_readv(QIOChannel *ioc,
             tioc->session,
             iov[i].iov_base,
             iov[i].iov_len,
-            flags & QIO_CHANNEL_READ_FLAG_RELAXED_EOF ||
-            qatomic_load_acquire(&tioc->shutdown) & QIO_CHANNEL_SHUTDOWN_READ,
             errp);
         if (ret == QCRYPTO_TLS_SESSION_ERR_BLOCK) {
             if (got) {
@@ -373,6 +384,12 @@ static ssize_t qio_channel_tls_readv(QIOChannel *ioc,
             } else {
                 return QIO_CHANNEL_ERR_BLOCK;
             }
+        } else if (ret == QCRYPTO_TLS_SESSION_PREMATURE_TERMINATION) {
+            if (qio_channel_tls_allow_premature_termination(tioc, flags)) {
+                ret = 0;
+            } else {
+                return -1;
+            }
         } else if (ret < 0) {
             return -1;
         }
-- 
2.50.1


