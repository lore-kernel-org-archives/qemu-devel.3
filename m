Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47E9ACDD0F4
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 21:15:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3MCp-0000sb-5x; Tue, 22 Oct 2024 17:14:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cp@absolutedigital.net>)
 id 1t3MCl-0000qI-84
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 17:14:16 -0400
Received: from mx2.absolutedigital.net ([50.242.207.105])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cp@absolutedigital.net>)
 id 1t3MCj-0004Ie-Oe
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 17:14:15 -0400
Received: from lancer.cnet.absolutedigital.net
 (lancer.cnet.absolutedigital.net [10.7.5.10])
 by luxor.inet.absolutedigital.net (8.18.1/8.18.1) with ESMTPS id
 49MLG6lD026459
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=FAIL);
 Tue, 22 Oct 2024 17:16:06 -0400
Received: from localhost (localhost [127.0.0.1])
 by lancer.cnet.absolutedigital.net (8.18.1/8.18.1) with ESMTPS id
 49MLED2E023834
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
 Tue, 22 Oct 2024 17:14:13 -0400
Date: Tue, 22 Oct 2024 17:14:13 -0400 (EDT)
From: Cal Peake <cp@absolutedigital.net>
To: qemu-devel@nongnu.org
cc: Markus Armbruster <armbru@redhat.com>,
 =?ISO-8859-15?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: [PATCH] qapi/crypto: Rename QCryptoAFAlg to QCryptoAFAlgo (addtl)
Message-ID: <619777e8-2238-81f-1d61-185dfcd1ac4e@absolutedigital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=50.242.207.105;
 envelope-from=cp@absolutedigital.net; helo=mx2.absolutedigital.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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

Hello,

This is a follow up to commit 8f525028bc6f52e4af3f737928d16c3f39a6ea54 to 
take care of a few remaining QCryptoAFAlg -> QCryptoAFAlgo renames.

Signed-off-by: Cal Peake <cp@absolutedigital.net>

diff --git a/crypto/hash-afalg.c b/crypto/hash-afalg.c
index 06e1e4699c..8c0ce5b520 100644
--- a/crypto/hash-afalg.c
+++ b/crypto/hash-afalg.c
@@ -142,7 +142,7 @@ QCryptoHash *qcrypto_afalg_hash_new(QCryptoHashAlgo alg, Error **errp)
 static
 void qcrypto_afalg_hash_free(QCryptoHash *hash)
 {
-    QCryptoAFAlg *ctx = hash->opaque;
+    QCryptoAFAlgo *ctx = hash->opaque;
 
     if (ctx) {
         qcrypto_afalg_comm_free(ctx);
@@ -159,7 +159,7 @@ void qcrypto_afalg_hash_free(QCryptoHash *hash)
  * be provided to calculate the final hash.
  */
 static
-int qcrypto_afalg_send_to_kernel(QCryptoAFAlg *afalg,
+int qcrypto_afalg_send_to_kernel(QCryptoAFAlgo *afalg,
                                  const struct iovec *iov,
                                  size_t niov,
                                  bool more_data,
@@ -183,7 +183,7 @@ int qcrypto_afalg_send_to_kernel(QCryptoAFAlg *afalg,
 }
 
 static
-int qcrypto_afalg_recv_from_kernel(QCryptoAFAlg *afalg,
+int qcrypto_afalg_recv_from_kernel(QCryptoAFAlgo *afalg,
                                    QCryptoHashAlgo alg,
                                    uint8_t **result,
                                    size_t *result_len,
@@ -222,7 +222,7 @@ int qcrypto_afalg_hash_update(QCryptoHash *hash,
                               size_t niov,
                               Error **errp)
 {
-    return qcrypto_afalg_send_to_kernel((QCryptoAFAlg *) hash->opaque,
+    return qcrypto_afalg_send_to_kernel((QCryptoAFAlgo *) hash->opaque,
                                         iov, niov, true, errp);
 }
 
@@ -232,7 +232,7 @@ int qcrypto_afalg_hash_finalize(QCryptoHash *hash,
                                  size_t *result_len,
                                  Error **errp)
 {
-    return qcrypto_afalg_recv_from_kernel((QCryptoAFAlg *) hash->opaque,
+    return qcrypto_afalg_recv_from_kernel((QCryptoAFAlgo *) hash->opaque,
                                           hash->alg, result, result_len, errp);
 }
 

