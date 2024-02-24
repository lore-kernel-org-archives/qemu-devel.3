Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 863E0C48BF6
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Feb 2024 14:38:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdt9R-0007IZ-KA; Sat, 24 Feb 2024 09:37:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rdt9Q-0007HW-HR
 for qemu-devel@nongnu.org; Sat, 24 Feb 2024 09:37:16 -0500
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rdt9O-0000Rz-So
 for qemu-devel@nongnu.org; Sat, 24 Feb 2024 09:37:16 -0500
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-5ce9555d42eso1520159a12.2
 for <qemu-devel@nongnu.org>; Sat, 24 Feb 2024 06:35:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1708785313; x=1709390113;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=48zezHH+9hnySftNNAaUQQGEn4ARZNmiD4t43M3eNPU=;
 b=P5lLp32atcB8dtecUByI4Pv8vFS/zRf6coJQ8al/sWfhvx82bS1vpF27wkBKu8kMhJ
 BH4xTF661POIiex7GDxqmgdHELrxs0ldGz9EOK8M4c4aPe470g3EX28geN2BfHCpmA+2
 FKxUHH7IrgCuovaW3xJnDe3/cJjP2Uf8RhYVlTAcewxeNX+3oTn3dK3yKoy4xaOQnPcq
 FQG90NHzv7ggM+ezWLtHwhUQvOe7Rei8dlicZHx+54c23R0T+mbVc86K7ibOB88gpQQe
 D1w2NlYsXgZCDdhLZXdqe6if8LBmOCreBBW7hsggdYM35QvytEcEIUlpl+qNMfUVNSxA
 Vhwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708785313; x=1709390113;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=48zezHH+9hnySftNNAaUQQGEn4ARZNmiD4t43M3eNPU=;
 b=NPOX+1OJ9Lt4ziayJ2qoL3XhJamgvGhFOzSONTtd70lGcg6UpKS++9QhwcgYr+wWoS
 9L95G0vCbq5hLr6IykFLdhFmQu8WE6ixMl4y0ycpSvvayR+SSWd0Bj5YvVTc8vaYzJDD
 F883G5tdZsD4cRJJwng3O1HUoCsfbzXcIBfs3bH6kGBoIjXc5IDaH/4wWR1Yh+/GJQt4
 kESlFnFe55fPn1Jukd2nTd9biSg+j8UljGMEWML5fAKthuoFI3/4OGEW5JUjRmJxyU5e
 pkWIV+d4/e0b2LI9k7EXH2ufE42vnKJGlJudnaHmHQM6Nmhae/sYt6EJFhbK9Tek0RqJ
 qhIA==
X-Gm-Message-State: AOJu0Yw6iDE/5OptMywZemafBVejAI/GDN5rjsvqwPArdvaMIqXml+Zt
 TBMTh1/SLNIiDiD/AYICUZFi/YP8FPEvnip2epw2vnePJTqoU8BRVSR0DP5dh0xebQVNZxbCljB
 BVJdD6Q==
X-Google-Smtp-Source: AGHT+IFZkGMWYaB4mBNnlGqf22qriXbyaDCH+L+jXVoyPYGvWR0I0GLc+4WKov/+pEG56gJPAAkbdw==
X-Received: by 2002:a05:6a21:8cc9:b0:1a0:60b2:45b with SMTP id
 ta9-20020a056a218cc900b001a060b2045bmr3509147pzb.6.1708785312582; 
 Sat, 24 Feb 2024 06:35:12 -0800 (PST)
Received: from anolis-dev.zelin.local ([221.122.98.162])
 by smtp.gmail.com with ESMTPSA id
 u22-20020a632356000000b005dc49afed53sm1181887pgm.55.2024.02.24.06.35.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Feb 2024 06:35:12 -0800 (PST)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 yong.huang@smartx.com
Subject: [PATCH RFC 3/3] crypto: Allow GM/T 0018-2012 to support SM4 cipher
 algorithm
Date: Sat, 24 Feb 2024 22:34:58 +0800
Message-Id: <0c083b9788580a4e27becf20510d9ba6c9ceb936.1708527979.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1708527979.git.yong.huang@smartx.com>
References: <cover.1708527979.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::52a;
 envelope-from=yong.huang@smartx.com; helo=mail-pg1-x52a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Since GM/T 0018-2012 was probed by SM4 cipher algorithm, allow
it to support SM4 cipher algorithm in block encryption.

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
---
 crypto/block-luks.c | 4 ++--
 crypto/cipher.c     | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/crypto/block-luks.c b/crypto/block-luks.c
index 3ee928fb5a..f4101fd435 100644
--- a/crypto/block-luks.c
+++ b/crypto/block-luks.c
@@ -95,7 +95,7 @@ qcrypto_block_luks_cipher_size_map_twofish[] = {
     { 0, 0 },
 };
 
-#ifdef CONFIG_CRYPTO_SM4
+#if defined CONFIG_CRYPTO_SM4 || defined CONFIG_GMT_0018_2012
 static const QCryptoBlockLUKSCipherSizeMap
 qcrypto_block_luks_cipher_size_map_sm4[] = {
     { 16, QCRYPTO_CIPHER_ALG_SM4},
@@ -109,7 +109,7 @@ qcrypto_block_luks_cipher_name_map[] = {
     { "cast5", qcrypto_block_luks_cipher_size_map_cast5 },
     { "serpent", qcrypto_block_luks_cipher_size_map_serpent },
     { "twofish", qcrypto_block_luks_cipher_size_map_twofish },
-#ifdef CONFIG_CRYPTO_SM4
+#if defined CONFIG_CRYPTO_SM4 || defined CONFIG_GMT_0018_2012
     { "sm4", qcrypto_block_luks_cipher_size_map_sm4},
 #endif
 };
diff --git a/crypto/cipher.c b/crypto/cipher.c
index 785f231948..5c2a620dcf 100644
--- a/crypto/cipher.c
+++ b/crypto/cipher.c
@@ -38,7 +38,7 @@ static const size_t alg_key_len[QCRYPTO_CIPHER_ALG__MAX] = {
     [QCRYPTO_CIPHER_ALG_TWOFISH_128] = 16,
     [QCRYPTO_CIPHER_ALG_TWOFISH_192] = 24,
     [QCRYPTO_CIPHER_ALG_TWOFISH_256] = 32,
-#ifdef CONFIG_CRYPTO_SM4
+#if defined CONFIG_CRYPTO_SM4 || defined CONFIG_GMT_0018_2012
     [QCRYPTO_CIPHER_ALG_SM4] = 16,
 #endif
 };
@@ -56,7 +56,7 @@ static const size_t alg_block_len[QCRYPTO_CIPHER_ALG__MAX] = {
     [QCRYPTO_CIPHER_ALG_TWOFISH_128] = 16,
     [QCRYPTO_CIPHER_ALG_TWOFISH_192] = 16,
     [QCRYPTO_CIPHER_ALG_TWOFISH_256] = 16,
-#ifdef CONFIG_CRYPTO_SM4
+#if defined CONFIG_CRYPTO_SM4 || defined CONFIG_GMT_0018_2012
     [QCRYPTO_CIPHER_ALG_SM4] = 16,
 #endif
 };
-- 
2.39.3


