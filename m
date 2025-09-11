Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16C61CAC58F
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Sep 2025 21:24:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwomB-0002i3-Ht; Thu, 11 Sep 2025 17:24:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uwom7-0002h0-V5
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 17:24:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uwom5-0008QA-8t
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 17:24:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757625851;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H+wI1mVR1U7NVXhX8RRjgaPpxiSDUV5ckDS1JFuvV3g=;
 b=U/k5IB4aV0jogyqt8zhTjxJKh7tI0NFi4isF/ti4gXd8DWH8uoPqd8MheOCvERqcpq1hRW
 sLt8XzT5Yd2YNcixwlO9PGuqia+05U03AYndGYFrvn7OyKpWxS58sTDNBlZvSLn1kF6llW
 fstBXcax4vlIpNOePSaxJWDC2bOdY0Y=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-232-m1n3ywUoMN6TYYAHyI4SCg-1; Thu, 11 Sep 2025 17:24:10 -0400
X-MC-Unique: m1n3ywUoMN6TYYAHyI4SCg-1
X-Mimecast-MFC-AGG-ID: m1n3ywUoMN6TYYAHyI4SCg_1757625849
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-817ecd47971so569190385a.0
 for <qemu-devel@nongnu.org>; Thu, 11 Sep 2025 14:24:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757625849; x=1758230649;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H+wI1mVR1U7NVXhX8RRjgaPpxiSDUV5ckDS1JFuvV3g=;
 b=nJoM9wiedppZ2mSidEkqccja8SByzTnvqfFvO9ZgQOsvDSP2cqup8WDlE18fwuMgUa
 Ee6woaxQhWfOKEOzeAuu8xa/6r5L/uAT71TgAx7Pae1bfEPT9x6MIFkGbeupQ3c1+0Z7
 wbpRXjQh8nv3xvYfGcTqg2PifntVurtr5ibtDcFimMIUbw3FuimBiBA24p+DVyXIPk+u
 hOQPeZZwjDbmrMdpOq66GPOvh5T8DVlYEo6UQ2ksGgRJjBAo0g1IjaoqCXi103WVtE7G
 8NPceo+X4hffX3xAp7cf69Rff7CtdzesnydOh0c0jxLuFUyO9QzLJF6WyVqjWfCRVtn5
 S7ZA==
X-Gm-Message-State: AOJu0YxvV4GKa335P4ZD+f4Lv8XAqoyJoVOPmAuJ49VNmNMIhpGiJOgM
 J+YONqeYmRWiprrkctt9mA9yB/oKWuXMdYoJENCkFBHKpGORRBBtTanfM8SoYEKUaW8ujhh66mb
 R/d4td4JxGthd/CuSRjl+LgQkBxzCEXWq3Vvpt37afZYhqjaZ7K5iINyu5TFPGPe/YZ2QUcJnho
 BlL9K1mJ4vVmvwYc653HMeFFqHYFSY2N2RsMD8CQ==
X-Gm-Gg: ASbGncsycDqGKoZ6kIrkcu27zwbZdhC3LgSAhEygjzyPyAcgjq2vNDNU7R9jOaoOeYB
 Kmf8cZXhlBFSJH9aHWhNHyGcSGC+u0rSvU9dtuVupjs9K8wneiWNsqj1qdpAKABhCnVhhPnfpw/
 vT6OffUyIQWmMMPt2Gin+yVIjFrA3uRgtBOsKX0waf32BtvTZXd9okaKjZkTbocnbmf4v/zqWQu
 Jpmvz+se8nz0ZBuPIAEqYUm/lbIhaDuF2q/AnqlKxmPkIdk7BEoxRHG+CojjOT0CsWPBWsaS9D6
 urReMr39oI9MG25XTE505qtnx1ugng==
X-Received: by 2002:a05:620a:400a:b0:823:a532:dfd1 with SMTP id
 af79cd13be357-823f8ce1457mr128882185a.9.1757625849207; 
 Thu, 11 Sep 2025 14:24:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHrDl69+D03XH4Br/KujYABHwPemtC1pi8xr4++W+9Kckfdkit+A87wk6CmhVJzS7OiqbJSjA==
X-Received: by 2002:a05:620a:400a:b0:823:a532:dfd1 with SMTP id
 af79cd13be357-823f8ce1457mr128878585a.9.1757625848697; 
 Thu, 11 Sep 2025 14:24:08 -0700 (PDT)
Received: from x1.com ([174.89.135.121]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-820c9845c47sm166032285a.28.2025.09.11.14.24.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Sep 2025 14:24:07 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 peterx@redhat.com, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v2 1/3] io/crypto: Move tls premature termination handling
 into QIO layer
Date: Thu, 11 Sep 2025 17:23:53 -0400
Message-ID: <20250911212355.1943494-2-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250911212355.1943494-1-peterx@redhat.com>
References: <20250911212355.1943494-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
to make the condition checks easier to read.

This patch will fix a qemu qtest warning when running the preempt tls test,
reporting premature termination:

QTEST_QEMU_BINARY=./qemu-system-x86_64 ./tests/qtest/migration-test --full -r /x86_64/migration/postcopy/preempt/tls/psk
...
qemu-kvm: Cannot read from TLS channel: The TLS connection was non-properly terminated.
...

In this specific case, the error was set by postcopy_preempt_thread, which
normally will be concurrently shutdown()ed by the main thread.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/crypto/tlssession.h |  7 +------
 crypto/tlssession.c         |  7 ++-----
 io/channel-tls.c            | 21 +++++++++++++++++++--
 3 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/include/crypto/tlssession.h b/include/crypto/tlssession.h
index 2f62ce2d67..6b4fcadee7 100644
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
@@ -267,10 +267,6 @@ ssize_t qcrypto_tls_session_write(QCryptoTLSSession *sess,
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
@@ -282,7 +278,6 @@ ssize_t qcrypto_tls_session_write(QCryptoTLSSession *sess,
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


