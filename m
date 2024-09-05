Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40383CE7A91
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 19:58:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smIcI-0006PJ-A5; Thu, 05 Sep 2024 15:58:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1smIcD-0006Bd-EC
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 15:58:02 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1smIcB-0005QI-Nc
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 15:58:01 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-7d666fb3fb9so203012a12.0
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2024 12:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725566276; x=1726171076; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2cUhzbDO1c4TVr/5fHme4bDVdctPUWA406Qmu6O3nZE=;
 b=c8TjuYrJmXx0cnyrqioHdJj8HJhSWLANGgx7IBR/E9CJB08RfgXqqnMASTe4h71wSi
 F3eYvWvgFGxTJOWC2xndGEu/nWmv6O/fX2PbCGW3nFDkMV0BpiUDgCMB9MzEhDHmfZJM
 BkdWgO8x5KuXKL16BrtPwHfF6v5sQPRH8kHWYfZIoQilS/lKLy/3AvG4SjWKYhD6hUHX
 YgfHva6e6uVKl2oXvYDLYigLnm8CBnAsJXeQteE+WGN0bokcfUpvhVbfJwc85y5YfP8o
 SyduD4fuCImQj1IElSgnDXSVTPlkGB+rj9FcjZygmcjiaHd+bGEvZm+Gv38NViIhJ1el
 ds7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725566276; x=1726171076;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2cUhzbDO1c4TVr/5fHme4bDVdctPUWA406Qmu6O3nZE=;
 b=Zzms6K0x8mQJZrHBbCFMybK7ODLj+rRIeAGgy6nN6rFqKI25oxQ/TOixJkVw40OsGI
 3gFoh6mKOu3w4jdRHbFH1ekfYITTGUrmcD4q6EYD7xlxYOg7tbpxgzhfq+PttDDbl7rD
 kLWO7qJF3bq14Otw2yn8ytZYg+KnysChYV0a2SNe43dIplGzpPrZnXuL9Hv57IG6y94K
 udubxS018c3pDw2BNZaINPuqwcv3hr+zYSG5ITQCs40fMJ966TzZVY0CCVk7yKdhMTBJ
 RZqBGTjpK31HnDmAYMxwc0CPdC3p8D71+ZD/ebTldsiSWPFs9sxbbisnXMpt9jakcbBO
 VnuA==
X-Gm-Message-State: AOJu0YwZ45Jp5iDDwCa2CPguhRdMnXVvMaRvCNFwFGyXq6lNB+x473lR
 AS2ubOJ25Q4H46cSzpO0U8vG6RpmdHkjU5CbuBH2NaEFB/rOvhQpnOr84g==
X-Google-Smtp-Source: AGHT+IHPH+NMSopG83F+C7LUKqyL1muBwYkK92W2GGvBm6vcfsSuRQJ6lD3BvXgXHcR0Bdt/NsAZnw==
X-Received: by 2002:a17:902:f54d:b0:206:b618:1d96 with SMTP id
 d9443c01a7336-206ee75720fmr6211435ad.0.1725566275731; 
 Thu, 05 Sep 2024 12:57:55 -0700 (PDT)
Received: from localhost.localdomain ([103.103.35.145])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-206aea5554dsm32031355ad.235.2024.09.05.12.57.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Sep 2024 12:57:55 -0700 (PDT)
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
To: qemu-devel@nongnu.org
Cc: graf@amazon.com, agraf@csgraf.de, stefanha@redhat.com, pbonzini@redhat.com,
 slp@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 mst@redhat.com, marcel.apfelbaum@gmail.com, berrange@redhat.com,
 philmd@linaro.org
Subject: [PATCH v6 2/8] crypto: Support SHA384 hash when using glib
Date: Fri,  6 Sep 2024 01:57:29 +0600
Message-Id: <20240905195735.16911-3-dorjoychy111@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240905195735.16911-1-dorjoychy111@gmail.com>
References: <20240905195735.16911-1-dorjoychy111@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=dorjoychy111@gmail.com; helo=mail-pg1-x536.google.com
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

QEMU requires minimum glib version 2.66.0 as per the root meson.build
file and per glib documentation[1] G_CHECKSUM_SHA384 is available since
2.51.

[1] https://docs.gtk.org/glib/enum.ChecksumType.html

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
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


