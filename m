Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B29606AA3E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 12:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZKbM6fsA
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNr4t-00065f-T3; Mon, 02 Nov 2026 07:23:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xNr4r-00064j-Ux
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 07:23:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xNr4q-0001Oq-Em
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 07:23:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793622231;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Uz8Hrgu0Sh2CH2H2mhPX4+rMsFO85y8ygqyZ7xV7v18=;
 b=ZKbM6fsAgJO8YecqNzvzzsKGp32Gg0naXTmjGQ244VaCEYRhZCkoIWWqRAITHISczLCRuz
 U3SxAZKnEaNO794Kd06QwzBTp4ugSue5pI9jnfJ++XWLKTCqgyK7eUVzdZsZgFEFZPsZfc
 qrvx9K5JJBj47EZp1FgLMZiuwwVFUzc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-342-LYCG9YVTO22WlDvfVPP0DA-1; Mon,
 02 Nov 2026 07:23:50 -0500
X-MC-Unique: LYCG9YVTO22WlDvfVPP0DA-1
X-Mimecast-MFC-AGG-ID: LYCG9YVTO22WlDvfVPP0DA_1793622229
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 945221955BEE; Mon,  2 Nov 2026 12:23:49 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id ACA2F1800480; Mon,  2 Nov 2026 12:23:48 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 3/4] tests/unit: drop conditionals for SM3
Date: Mon,  2 Nov 2026 12:23:42 +0000
Message-ID: <20261102122343.3348956-4-berrange@redhat.com>
In-Reply-To: <20261102122343.3348956-1-berrange@redhat.com>
References: <20261102122343.3348956-1-berrange@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

There is no need to conditionalize test data for SM3, since the
test explicitly checks whether each algorithm is supported.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/unit/test-crypto-hash.c | 10 ----------
 tests/unit/test-crypto-hmac.c |  4 +---
 2 files changed, 1 insertion(+), 13 deletions(-)

diff --git a/tests/unit/test-crypto-hash.c b/tests/unit/test-crypto-hash.c
index 8fee1593f94..1813e77b5a5 100644
--- a/tests/unit/test-crypto-hash.c
+++ b/tests/unit/test-crypto-hash.c
@@ -43,9 +43,7 @@
                       "63b54e4cb2d2032b393994aa263c0dbb" \
                       "e00a9f2fe9ef6037352232a1eec55ee7"
 #define OUTPUT_RIPEMD160 "f3d658fad3fdfb2b52c9369cf0d441249ddfa8a0"
-#ifdef CONFIG_CRYPTO_SM3
 #define OUTPUT_SM3 "d4a97db105b477b84c4f20ec9c31a6c814e2705a0b83a5a89748d75f0ef456a1"
-#endif
 
 #define OUTPUT_MD5_B64 "Yo0gY3FWMDWrjvYvSSveyQ=="
 #define OUTPUT_SHA1_B64 "sudPJnWKOkIeUJzuBFJEt4dTzAI="
@@ -58,9 +56,7 @@
                           "7sVe5w=="
 #define OUTPUT_RIPEMD160_B64 "89ZY+tP9+ytSyTac8NRBJJ3fqKA="
 
-#ifdef CONFIG_CRYPTO_SM3
 #define OUTPUT_SM3_B64 "1Kl9sQW0d7hMTyDsnDGmyBTicFoLg6Wol0jXXw70VqE="
-#endif
 
 static const char *expected_outputs[] = {
     [QCRYPTO_HASH_ALGO_MD5] = OUTPUT_MD5,
@@ -70,9 +66,7 @@ static const char *expected_outputs[] = {
     [QCRYPTO_HASH_ALGO_SHA384] = OUTPUT_SHA384,
     [QCRYPTO_HASH_ALGO_SHA512] = OUTPUT_SHA512,
     [QCRYPTO_HASH_ALGO_RIPEMD160] = OUTPUT_RIPEMD160,
-#ifdef CONFIG_CRYPTO_SM3
     [QCRYPTO_HASH_ALGO_SM3] = OUTPUT_SM3,
-#endif
 };
 static const char *expected_outputs_b64[] = {
     [QCRYPTO_HASH_ALGO_MD5] = OUTPUT_MD5_B64,
@@ -82,9 +76,7 @@ static const char *expected_outputs_b64[] = {
     [QCRYPTO_HASH_ALGO_SHA384] = OUTPUT_SHA384_B64,
     [QCRYPTO_HASH_ALGO_SHA512] = OUTPUT_SHA512_B64,
     [QCRYPTO_HASH_ALGO_RIPEMD160] = OUTPUT_RIPEMD160_B64,
-#ifdef CONFIG_CRYPTO_SM3
     [QCRYPTO_HASH_ALGO_SM3] = OUTPUT_SM3_B64,
-#endif
 };
 static const int expected_lens[] = {
     [QCRYPTO_HASH_ALGO_MD5] = 16,
@@ -94,9 +86,7 @@ static const int expected_lens[] = {
     [QCRYPTO_HASH_ALGO_SHA384] = 48,
     [QCRYPTO_HASH_ALGO_SHA512] = 64,
     [QCRYPTO_HASH_ALGO_RIPEMD160] = 20,
-#ifdef CONFIG_CRYPTO_SM3
     [QCRYPTO_HASH_ALGO_SM3] = 32,
-#endif
 };
 
 static const char hex[] = "0123456789abcdef";
diff --git a/tests/unit/test-crypto-hmac.c b/tests/unit/test-crypto-hmac.c
index 20c60eb9d8b..f7158621908 100644
--- a/tests/unit/test-crypto-hmac.c
+++ b/tests/unit/test-crypto-hmac.c
@@ -76,14 +76,12 @@ static QCryptoHmacTestData test_data[] = {
             "94964ed4c1155b62b668c241d67279e5"
             "8a711676",
     },
-#ifdef CONFIG_CRYPTO_SM3
     {
         .alg = QCRYPTO_HASH_ALGO_SM3,
         .hex_digest =
             "760e3799332bc913819b930085360ddb"
-    "c05529261313d5b15b75bab4fd7ae91e",
+            "c05529261313d5b15b75bab4fd7ae91e",
     },
-#endif
 };
 
 static const char hex[] = "0123456789abcdef";
-- 
2.56.0


