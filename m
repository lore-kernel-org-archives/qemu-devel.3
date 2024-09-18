Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB354CCD1BF
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 14:56:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqw64-0004DI-A8; Wed, 18 Sep 2024 10:56:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@treblig.org>) id 1sqw5f-0004Ba-65
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 10:55:36 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@treblig.org>) id 1sqw5b-0001K9-Gr
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 10:55:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
 :Subject; bh=fmyHye/CXY14f9OebJymcWWeWUTF5P44pN60IKtXDaM=; b=WawC5ahre5loMdUz
 rP00yP6R326voYShVrJhnZtdsW5YO4m88omZ0oB02kEDlC1bynAp/xNQPE0iPRlDB3Few3QrY2SMF
 U+MjwhJAA7LUf6NV+V+lZ80+jRMU7/DNIkJEzuFJvuw432CIKfvEQkDlt2NMf/hqkJIPaCE35Ytfg
 Ymj1rILzZVw1t1axYTFgKl0Cl2MEle1KxwYj2fJ++gSy0FuJEtRPcu9yoSE1IYT5gM3bqPtaKh7HU
 SbcdcwiajuB3uoUt5sRC0DHO9MjsPCPvLXZJLa/pgKH4OvSjroCqu/No5G3LQHTM3uul+1f62RhEg
 J8XgLkO1mzy/gAtD4g==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
 by mx.treblig.org with esmtp (Exim 4.96)
 (envelope-from <dave@treblig.org>) id 1sqw5Y-006J9c-3C;
 Wed, 18 Sep 2024 14:55:29 +0000
From: dave@treblig.org
To: berrange@redhat.com
Cc: qemu-devel@nongnu.org,
	"Dr. David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH] crypto: Remove unused DER string functions
Date: Wed, 18 Sep 2024 15:55:28 +0100
Message-ID: <20240918145528.157035-1-dave@treblig.org>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1098:5b::1; envelope-from=dave@treblig.org;
 helo=mx.treblig.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

From: "Dr. David Alan Gilbert" <dave@treblig.org>

qcrypto_der_encode_octet_str_begin and _end have been unused
since they were added in
  3b34ccad66 ("crypto: Support DER encodings")

Remove them.

Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>
---
 crypto/der.c | 13 -------------
 crypto/der.h | 22 ----------------------
 2 files changed, 35 deletions(-)

diff --git a/crypto/der.c b/crypto/der.c
index ebbecfc3fe..81367524c3 100644
--- a/crypto/der.c
+++ b/crypto/der.c
@@ -408,19 +408,6 @@ void qcrypto_der_encode_octet_str(QCryptoEncodeContext *ctx,
     qcrypto_der_encode_prim(ctx, tag, src, src_len);
 }
 
-void qcrypto_der_encode_octet_str_begin(QCryptoEncodeContext *ctx)
-{
-    uint8_t tag = QCRYPTO_DER_TAG(QCRYPTO_DER_TAG_CLASS_UNIV,
-                                  QCRYPTO_DER_TAG_ENC_PRIM,
-                                  QCRYPTO_DER_TYPE_TAG_OCT_STR);
-    qcrypto_der_encode_cons_begin(ctx, tag);
-}
-
-void qcrypto_der_encode_octet_str_end(QCryptoEncodeContext *ctx)
-{
-    qcrypto_der_encode_cons_end(ctx);
-}
-
 size_t qcrypto_der_encode_ctx_buffer_len(QCryptoEncodeContext *ctx)
 {
     return ctx->root.dlen;
diff --git a/crypto/der.h b/crypto/der.h
index f4ba6da28a..bcfa4a2495 100644
--- a/crypto/der.h
+++ b/crypto/der.h
@@ -242,28 +242,6 @@ void qcrypto_der_encode_null(QCryptoEncodeContext *ctx);
 void qcrypto_der_encode_octet_str(QCryptoEncodeContext *ctx,
                                   const uint8_t *src, size_t src_len);
 
-/**
- * qcrypto_der_encode_octet_str_begin:
- * @ctx: the encode context.
- *
- * Start encoding a octet string, All fields between
- * qcrypto_der_encode_octet_str_begin and qcrypto_der_encode_octet_str_end
- * are encoded as an octet string. This is useful when we need to encode a
- * encoded SEQUENCE as OCTET STRING.
- */
-void qcrypto_der_encode_octet_str_begin(QCryptoEncodeContext *ctx);
-
-/**
- * qcrypto_der_encode_octet_str_end:
- * @ctx: the encode context.
- *
- * Finish encoding a octet string, All fields between
- * qcrypto_der_encode_octet_str_begin and qcrypto_der_encode_octet_str_end
- * are encoded as an octet string. This is useful when we need to encode a
- * encoded SEQUENCE as OCTET STRING.
- */
-void qcrypto_der_encode_octet_str_end(QCryptoEncodeContext *ctx);
-
 /**
  * qcrypto_der_encode_ctx_buffer_len:
  * @ctx: the encode context.
-- 
2.46.0


