Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6947DCA1013
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 20:40:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzLQ0-000664-63; Thu, 18 Sep 2025 16:39:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uzLPx-00065Z-M5
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 16:39:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uzLPu-0005q6-Po
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 16:39:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758227984;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PISZYNwNcqxmRdkv72aYDBIGvVd3XtWjapz0OTY+8IE=;
 b=NCt6t84YdxCBeZGebx4BABSGUuNLfB+m/KYRi/Kb4ROJl7qXdmEdGV46PTjO4z2zteYYoW
 XvmX/MyUIkVOu3s83Wjg2bRH1f95mYRCBTvKn+DxduJj1ZGH5GEHR1qd1pRyw6F0J4HP3H
 6dyGIfdBtGqBDX8udNcCzI33VFDv0PU=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691--q56MP2AMgiVKTmJzMqeww-1; Thu, 18 Sep 2025 16:39:43 -0400
X-MC-Unique: -q56MP2AMgiVKTmJzMqeww-1
X-Mimecast-MFC-AGG-ID: -q56MP2AMgiVKTmJzMqeww_1758227982
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-81312a26ea3so327517985a.0
 for <qemu-devel@nongnu.org>; Thu, 18 Sep 2025 13:39:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758227981; x=1758832781;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PISZYNwNcqxmRdkv72aYDBIGvVd3XtWjapz0OTY+8IE=;
 b=QeZFwSS8bzRHoj2EaIWKi9YpVcRuq8NjsvXLxltGBOVEfG7J0YSpmC7pNPAhVHfHOu
 8ZAVwszk5XSyZ5SOBFNEdzh/zUF4GAftocHxFwB1tySR4nger4PSJKHFjnwq4uJhmOuI
 WRrJx3ufOmpMXBP4oD7mUL2canfjgtrdGleV624Eejf/oQyL4IjAhz+JzPfEhCRAKCTf
 ZlGMxhTm/NjTXQACPcdDytQNTnf3raoIIeRGbwHiZoyeXoicHK3YajN4b0ELwMImQqPP
 VgGGjeTN2KgREU0uwbSNzDMxFEQv9eg3/9P+jHX2Ko81GLoPkNnSiYXWTG9Q9IKu7j2z
 TTLA==
X-Gm-Message-State: AOJu0YwoZ5TVhYctPZC5cWV5Mkchxwl2RreJq4cDTzlNNFccwunATlHB
 MS0af4idF/ZVDjcK6VW1IiBZ5btMpz8ow9dCUDYLcqqKYnHxN0d5ulTwjTo3ifruqChE/nx2rYo
 CLndQ34Mv1Q6Q4DGaukjUo6pAvKJsa/jfpxbdA3LKAQtglJ7EqUcu0ASE82UwkpFdFsYbloHseR
 kjdCDoBR4uBpuRAT9FdqtZQ9yXfYlaeVePtYCxEQ==
X-Gm-Gg: ASbGncsrGi/JgZFCup+YrcHGDtaaP2M0CqRZkEf+SLeLjBvlzLA72h8X+yImjKCc2L+
 2EOPDHKgGVi58Dt7D1Ujm/vVvTvsbWEitIoCRTLpHIX4PoLx8c7yYenr1vBSo6CEKxkByhBxi8j
 n4aAe9CEG9E7nXl9xYoSFaqDHwGm/Rhnfy5QaBb1hVbZZNrh2eWdyXQjHmOgxkJTfNbNrrPzcg6
 Yz4QcON9HSrT/L++ONdDm1zTHtQ5VHUMU0bVc1ZKZU6qWOiWlphGduWMjm13dntTPkiajX5Y10t
 CsYPCsconvh27TzYhJmU8VJACGh6v29D1FO2gdz4j10wL25IR3Rg1wKB2zZAPlzMpd4XY5QKFYh
 HSbpYJ7K8fB3Jhfu1IUE=
X-Received: by 2002:a05:620a:d:b0:80f:d62b:9b71 with SMTP id
 af79cd13be357-83bad30b1f5mr106220985a.75.1758227981432; 
 Thu, 18 Sep 2025 13:39:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFq8SBijXHACg6W+t/CUmcA3c12RQaAXv8flXh9WnF5s9FzbutDIOYItqIc3Je55dAjjSUJZw==
X-Received: by 2002:a05:620a:d:b0:80f:d62b:9b71 with SMTP id
 af79cd13be357-83bad30b1f5mr106218685a.75.1758227980939; 
 Thu, 18 Sep 2025 13:39:40 -0700 (PDT)
Received: from x1.com
 (bras-base-aurron9134w-grc-11-174-89-135-121.dsl.bell.ca. [174.89.135.121])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-836278b8082sm226276285a.22.2025.09.18.13.39.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Sep 2025 13:39:40 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Juraj Marcin <jmarcin@redhat.com>
Subject: [PATCH v3 1/2] io/crypto: Move tls premature termination handling
 into QIO layer
Date: Thu, 18 Sep 2025 16:39:36 -0400
Message-ID: <20250918203937.200833-2-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250918203937.200833-1-peterx@redhat.com>
References: <20250918203937.200833-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.005,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
index a8248a9216..5a2c8188ce 100644
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


