Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AA1AC3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2024 15:10:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sh9RN-0007TW-Pz; Thu, 22 Aug 2024 11:09:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1sh9R6-0007Ox-1T
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 11:09:16 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1sh9R4-00050O-7h
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 11:09:15 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2d3b36f5366so698795a91.0
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2024 08:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724339352; x=1724944152; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XK1RrmnAAcLJEruO+a0NiCbV8+je+zVBS/hWa0cHNWg=;
 b=btqkDlnf0pAUI6V5DTSDKLosmiqvUHUhhRF6e/tzn+n6BGkFKuZKhdQufr0rThNWZi
 p7pXI6cIL9bRfeizuXDRbfEwRVVBW/bt5AVOGBLhGXa4Ml1QtuRUVL0NYqI1pYOG4VDz
 CvlDwz20V1NO6loZ1AOxlJY/mLn2h4TMqBTfy7Ex10PbEPwDeXSd+U2EjUXMzfYNd57S
 TNUYaxrWh5BPK7ufA0mXgtTN9wiLp/PivSyiG5YX/UV/CMZ+XmYujMly/F0/9qmDRr0D
 Os7RLebSmDOvTXc0M9ZZvLyEtVHX2hxT6xrwiW3THCJh6/aqsFIv5fjnyzGEilPhQqow
 tpBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724339352; x=1724944152;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XK1RrmnAAcLJEruO+a0NiCbV8+je+zVBS/hWa0cHNWg=;
 b=G8mLjJhwGTVxRYA3ZPZDFxAoabd+arHtlOmmhub8afLWjw30cejf5CtdmwcYpgBzFX
 /4EK7Iqsgco51bdlRVb19e5FSrTnS1xS6SoA4UhKpYM4MMup7zJpCvQIyUeTBlvQ057N
 4/vGS1nuxUmys0QSehjyXsz3LvmbnpFaAja+L24Aax5EU+MrDmXu0J3cqqgLActaUJq0
 Ziqkb6iYWrkKWFpPb4qwFsWydYz8N7jXAletbuTEUk0ej6i1V1v1cv9R+pYFA8xtaL4o
 5h6ZN7An4NYN0aPnBf0EPpJLz2XtqOcIfYTp/VivSNRwwFP4ulZPAS32s2VEZK7ehXBf
 2qgA==
X-Gm-Message-State: AOJu0YxZjgcJjT92KjW6LKtZlXmdu0wd8B5sN17IXOUyv9rxF4ylxxBS
 MJoWe9ajfSNjl/8dHUIw+8nMRz6P5QxDyN/O2eJeDgz4rqSsu1d1Qmq2/vEk
X-Google-Smtp-Source: AGHT+IHG0jXqivqvKmSSe2RzYuqQ5q50Okm/jOt+3NKEUgDMBpJPgHBeJ45sDnyBxSO9n+SwKS9/rA==
X-Received: by 2002:a17:90a:640b:b0:2c9:8105:483 with SMTP id
 98e67ed59e1d1-2d5e9a3fb15mr6482103a91.14.1724339352543; 
 Thu, 22 Aug 2024 08:09:12 -0700 (PDT)
Received: from localhost.localdomain ([103.103.35.175])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d613919fd2sm1991567a91.13.2024.08.22.08.09.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Aug 2024 08:09:12 -0700 (PDT)
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
To: qemu-devel@nongnu.org
Cc: graf@amazon.com, agraf@csgraf.de, stefanha@redhat.com, pbonzini@redhat.com,
 slp@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 mst@redhat.com, marcel.apfelbaum@gmail.com, berrange@redhat.com,
 philmd@linaro.org
Subject: [PATCH v5 1/8] crypto: Define macros for hash algorithm digest lengths
Date: Thu, 22 Aug 2024 21:08:42 +0600
Message-Id: <20240822150849.21759-2-dorjoychy111@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240822150849.21759-1-dorjoychy111@gmail.com>
References: <20240822150849.21759-1-dorjoychy111@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=dorjoychy111@gmail.com; helo=mail-pj1-x102a.google.com
X-Spam_score_int: 15
X-Spam_score: 1.5
X-Spam_bar: +
X-Spam_report: (1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
---
 crypto/hash.c         | 14 +++++++-------
 include/crypto/hash.h |  8 ++++++++
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/crypto/hash.c b/crypto/hash.c
index b0f8228bdc..8087f5dae6 100644
--- a/crypto/hash.c
+++ b/crypto/hash.c
@@ -23,13 +23,13 @@
 #include "hashpriv.h"
 
 static size_t qcrypto_hash_alg_size[QCRYPTO_HASH_ALG__MAX] = {
-    [QCRYPTO_HASH_ALG_MD5] = 16,
-    [QCRYPTO_HASH_ALG_SHA1] = 20,
-    [QCRYPTO_HASH_ALG_SHA224] = 28,
-    [QCRYPTO_HASH_ALG_SHA256] = 32,
-    [QCRYPTO_HASH_ALG_SHA384] = 48,
-    [QCRYPTO_HASH_ALG_SHA512] = 64,
-    [QCRYPTO_HASH_ALG_RIPEMD160] = 20,
+    [QCRYPTO_HASH_ALG_MD5]       = QCRYPTO_HASH_DIGEST_LEN_MD5,
+    [QCRYPTO_HASH_ALG_SHA1]      = QCRYPTO_HASH_DIGEST_LEN_SHA1,
+    [QCRYPTO_HASH_ALG_SHA224]    = QCRYPTO_HASH_DIGEST_LEN_SHA224,
+    [QCRYPTO_HASH_ALG_SHA256]    = QCRYPTO_HASH_DIGEST_LEN_SHA256,
+    [QCRYPTO_HASH_ALG_SHA384]    = QCRYPTO_HASH_DIGEST_LEN_SHA384,
+    [QCRYPTO_HASH_ALG_SHA512]    = QCRYPTO_HASH_DIGEST_LEN_SHA512,
+    [QCRYPTO_HASH_ALG_RIPEMD160] = QCRYPTO_HASH_DIGEST_LEN_RIPEMD160,
 };
 
 size_t qcrypto_hash_digest_len(QCryptoHashAlgorithm alg)
diff --git a/include/crypto/hash.h b/include/crypto/hash.h
index 54d87aa2a1..a113cc3b04 100644
--- a/include/crypto/hash.h
+++ b/include/crypto/hash.h
@@ -23,6 +23,14 @@
 
 #include "qapi/qapi-types-crypto.h"
 
+#define QCRYPTO_HASH_DIGEST_LEN_MD5       16
+#define QCRYPTO_HASH_DIGEST_LEN_SHA1      20
+#define QCRYPTO_HASH_DIGEST_LEN_SHA224    28
+#define QCRYPTO_HASH_DIGEST_LEN_SHA256    32
+#define QCRYPTO_HASH_DIGEST_LEN_SHA384    48
+#define QCRYPTO_HASH_DIGEST_LEN_SHA512    64
+#define QCRYPTO_HASH_DIGEST_LEN_RIPEMD160 20
+
 /* See also "QCryptoHashAlgorithm" defined in qapi/crypto.json */
 
 /**
-- 
2.39.2


