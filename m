Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A039CC531F9
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 10:44:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wofGf-0008Ai-1C; Tue, 28 Jul 2026 06:42:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wofGd-00089E-A7
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 06:42:35 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wofGb-0008IX-MW
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 06:42:35 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-698ae09e356so4459565a12.2
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 03:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1785235352; x=1785840152; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yfUxWo9DRfnzypPrGvcp6jHwrWI7DnwyNSb11uKFohg=;
 b=e6pUK5Sjvpg9q0SO8BPdZt/Ild5l5AWmtUPJA1YPItdt5yGbw1JuIt6tKAcaFf3G2w
 rkbiXDQ+s9EqYGDO4gyAnUC6bVu3IJd0YF3ToGM/SS5dPE45wZ5iN4EdL9tzyGdGU7Wc
 nW8z40JRIsC+3LYMoDGFM2jMpwnULpsZWI3a4tIaO01EbloZnEIlh8NGScaVaPaUSM/c
 xL/u25urql4TCyDvivvRZ08NNN2OGdP+FiqDdOIzL0LvG7So84SXONe1Ryqlq9j+U0Pn
 7CYi+nOBFyFeWIJlG6+e7WIzUx7B6a5snLTjhTZ3s11cive74+YJGbin/vEVGhMQ1yV6
 WO/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785235352; x=1785840152;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=yfUxWo9DRfnzypPrGvcp6jHwrWI7DnwyNSb11uKFohg=;
 b=TTUPow1V1Jzkst4lUVBLhHVhn15jxVzeqZjIfRQ+vh7kyJr07uD1p35J2OS8o4XlsA
 CCZ+ygx6Fpy3Q2ewMDlP1vuyjIXFF8ABLdOp6+y1pWc7ry0UiCcai4R38Csm6envHtNb
 S+ZrLFBzaQHQSUkKLIOodipuheyPEwjoYk7uhmuABLeVhWW8fHi7UImZ4xI8be1UH3qM
 NBmffybH20168LzLC1m5Ev++Ufspq7Ywg2tSeF9FEqxeWX/CWIdCHlBBoEF8VeScu6Kx
 DiiudNnGOVrBSPVizrqpzovs6EO/+S8SnTMlGSwf+HENygLGSJ6PJUiajBB/rARowGZp
 YJsA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpAFDQ1ec+s7CxljPLSZrDWDR2JmKKfQUPc/szlYXCirMV6F/EOyPch5NisfuZkYf1TaSnZKUolgotL@nongnu.org
X-Gm-Message-State: AOJu0YxpYcVckiZUQ1d6+szOu4Kmb/WwC5UaZvJA4LLQqz8jnO6Om6yr
 xJCEZsDqwCN/KZZRQ/GlD7XHLMXtmT5eEWRsAuR04HP4f5J2M9DlNcVjzV5z6dqOI9M=
X-Gm-Gg: AR+sD13iUakzlOIQd6jWTfnFwjEYQL5Qv5P7D9aEivG43TxerCDG0rv9yRKa+tT6vpO
 ZL5Pglwp6zM5K2r2uGv5IY/Q3YG4yNw2X/7SehedJdUWYBO2b+toPS9xrE0/iu4FfoUZVRx2/lk
 bvaAbvrFsUtMkWgXoCSfGXFRH5oaP8h/pgQkwziOTf/as6xJpAJt+g0M7aCCOkSEUWXtPEaN2mt
 UcuPMPMful9j2/ZZ+8Tj/03VH3qjCji4aOzwtLevUB4EKWwtItILwxGA03awTYCAqIeiuWuF0P9
 H5dCi3iOjQk/DXfKkgzjOmWlVlzbLvVnyN0UAXG8vOhCZTOVse1JvCbRItJgK9gYAsgVAQktxXS
 Utev8ZMFu6aI5f4JNN/5wtlKq1SjdFr+3GDYchbbvk7Mr5QROrP1bUN2uMM2BYw1AGR+nQqXyxG
 JE
X-Received: by 2002:a17:907:9629:b0:c16:71:d9ce with SMTP id
 a640c23a62f3a-c1f71d57191mr87457166b.8.1785235352278; 
 Tue, 28 Jul 2026 03:42:32 -0700 (PDT)
Received: from athena ([2a06:5b06:b600:300:45be:7876:b62b:ca4])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1c32c90b4dsm745682266b.35.2026.07.28.03.42.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 03:42:31 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: den@openvz.org, Thomas Huth <thuth@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 7/9] parallels: avoid fatal abort on large bitmap L1 table
Date: Tue, 28 Jul 2026 12:42:19 +0200
Message-ID: <20260728104221.3981592-8-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260728104221.3981592-1-den@openvz.org>
References: <20260728104221.3981592-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=den@openvz.org; helo=mail-ed1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

parallels_load_bitmap() allocated the L1 table with g_new(), which
aborts the whole process on allocation failure instead of returning
an error.

Use g_try_new() and fail the open normally.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Thomas Huth <thuth@redhat.com>
CC: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/parallels-ext.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/block/parallels-ext.c b/block/parallels-ext.c
index 704e16e1de..7f6ab6b0d2 100644
--- a/block/parallels-ext.c
+++ b/block/parallels-ext.c
@@ -169,7 +169,13 @@ parallels_load_bitmap(BlockDriverState *bs, uint8_t *data, size_t data_size,
     }
 
     if (bf.l1_size != 0) {
-        l1_table = g_new(uint64_t, bf.l1_size);
+        l1_table = g_try_new(uint64_t, bf.l1_size);
+        if (!l1_table) {
+            error_setg(errp, "Failed to allocate the bitmap L1 table "
+                       "(%" PRIu32 " entries)", bf.l1_size);
+            goto fail;
+        }
+
         for (i = 0; i < bf.l1_size; i++, data += sizeof(uint64_t)) {
             l1_table[i] = ldq_le_p(data);
         }
-- 
2.53.0


