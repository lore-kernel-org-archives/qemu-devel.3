Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 590C6C52D7C
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Aug 2024 11:44:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sfeKB-0003kt-7C; Sun, 18 Aug 2024 07:43:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1sfeK3-0003an-0p
 for qemu-devel@nongnu.org; Sun, 18 Aug 2024 07:43:47 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1sfeJn-0001bE-H9
 for qemu-devel@nongnu.org; Sun, 18 Aug 2024 07:43:46 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-7b594936e9bso2362827a12.1
 for <qemu-devel@nongnu.org>; Sun, 18 Aug 2024 04:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723981410; x=1724586210; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zh0mOHED6gMol1IGMEbgVCYouVK17iJWQeypFUJeFUw=;
 b=Til41XNMcGTnyUpHIWFY1u35VwXkzWMxcBf/rVN9bteVIcalM5/915TiG0V8hccDMt
 3uLx+n5jT5/ZDqpa5s+e6zPANPhs4cPYC0mXGy+Q2ou2/11NfRrEI8lsa3czc01ENOL+
 wHE63xpVlxy3ZUTByytbCnf++uVAlW1vwZGAOvoF4Y2jk2eDPy65i9fi0jp60hYA2rKw
 fpEip7IEKCaKshuEdwDRpYRAnB/1Mb3+pTkqvwznpOm1h+8YSLhYWh0I7PssE5vhYCNu
 z1WojOyYXln8C4xLWfKumx7iVk/JxMxOqI4Xq6qlCmOW5Vju5Wc11Wpfnn33oDB2s4fQ
 W2cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723981410; x=1724586210;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zh0mOHED6gMol1IGMEbgVCYouVK17iJWQeypFUJeFUw=;
 b=qdS0GHbz4kBuHL3iA1BGFi66lr5Wpdv7br4kIeI42GHYfwXLT5oQoBgMzBRqRLCSVo
 in3kkZOSBcmtA01XuW2h36zQXdhF70cq8Z8Piu7/jxDuVAu1YAdVc4ZbRmHR6yjE6gVV
 rtz9QcY1H1eqv67E6nfEsK6p1Gd2NcoHh9p3DUtvyw4FPy//12KAIB6L6UiM1Wesjv2U
 1LOPTGwBzadxPKj1fbW8g/DJmWXGDR+Le5Kr31i1+KB/7FAX2G5Vrbbm6OKVETlxIXsP
 b1wXNOAhRNiS56HHaIF5j4VdUnZBoVPVIrKHILI5BVQ1PvyL9470Sz+clJs0hH0MBqOR
 kldw==
X-Gm-Message-State: AOJu0YyzSOZRt3YLhRhZocaBiEmJUGk/H1A03ta6mSMKu98OuL3tql6q
 N3G6DT8pOk/xqbTkJsnXulHW3Aad4RRGtIg5cgSsYTZ/VBO+RkhPD2p3fQ==
X-Google-Smtp-Source: AGHT+IE3Jqz+cCQoe0dcnz1Y244yyl3aIHJqbvBtB7XKePCtr8MtEHzd9XoHWDe7tqgh34RSIhvWtg==
X-Received: by 2002:a17:90b:1e03:b0:2d3:dca0:89b7 with SMTP id
 98e67ed59e1d1-2d40533a66emr5294810a91.3.1723981409816; 
 Sun, 18 Aug 2024 04:43:29 -0700 (PDT)
Received: from localhost.localdomain ([103.103.35.174])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d3e2c61fe4sm5303617a91.4.2024.08.18.04.43.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Aug 2024 04:43:29 -0700 (PDT)
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
To: qemu-devel@nongnu.org
Cc: graf@amazon.com, agraf@csgraf.de, stefanha@redhat.com, pbonzini@redhat.com,
 slp@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 mst@redhat.com, marcel.apfelbaum@gmail.com, berrange@redhat.com,
 philmd@linaro.org
Subject: [PATCH v4 5/6] crypto: Support SHA384 hash when using glib
Date: Sun, 18 Aug 2024 17:42:56 +0600
Message-Id: <20240818114257.21456-6-dorjoychy111@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240818114257.21456-1-dorjoychy111@gmail.com>
References: <20240818114257.21456-1-dorjoychy111@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=dorjoychy111@gmail.com; helo=mail-pg1-x52b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

QEMU requires minimum glib version 2.66.0 as per the root meson.build
file and per glib documentation[1] G_CHECKSUM_SHA384 is available since
2.51.

[1] https://docs.gtk.org/glib/enum.ChecksumType.html

Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
---
 crypto/hash-glib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/crypto/hash-glib.c b/crypto/hash-glib.c
index 82de9db705..18e64faa9c 100644
--- a/crypto/hash-glib.c
+++ b/crypto/hash-glib.c
@@ -29,7 +29,7 @@ static int qcrypto_hash_alg_map[QCRYPTO_HASH_ALG__MAX] = {
     [QCRYPTO_HASH_ALG_SHA1] = G_CHECKSUM_SHA1,
     [QCRYPTO_HASH_ALG_SHA224] = -1,
     [QCRYPTO_HASH_ALG_SHA256] = G_CHECKSUM_SHA256,
-    [QCRYPTO_HASH_ALG_SHA384] = -1,
+    [QCRYPTO_HASH_ALG_SHA384] = G_CHECKSUM_SHA384,
     [QCRYPTO_HASH_ALG_SHA512] = G_CHECKSUM_SHA512,
     [QCRYPTO_HASH_ALG_RIPEMD160] = -1,
 };
-- 
2.39.2


