Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45E6DD3ABCE
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2024 17:04:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAXpP-0005uG-VS; Mon, 11 Nov 2024 12:03:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tAXpK-0005tP-90
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 12:03:46 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tAXpI-0007hY-MG
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 12:03:46 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4314b316495so38710755e9.2
 for <qemu-devel@nongnu.org>; Mon, 11 Nov 2024 09:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731344623; x=1731949423; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4PxJcypGLJUZeCvO6UFQ988vSD/DmSC0a3FHBYB21+M=;
 b=sM1URRbRB/Y1aL5DoNXuey9khq+if4TKZFpkaGh2StF7JL4u1FcQFxTQaJ5HPDNovg
 +GJNxbmu6cKTGsntGhq3DFVoJcnqNh6BbOnYaE1nxeBm1oxo1C8V5of0oxL38QxC1tRZ
 LcfCG6i2yPm6AtDHfZsNCJTQ8fgR8ZZyPtT+3aUPczLVz5CoFA8lTFQ8if/uPiuqpm5h
 k+jkPs+iqhWG/yixioJiTzjuYoi4LmdjKgOr6W0EkzAr/q3m+vp5XKfizJSkwdJZgW6r
 GRZBBhZySx/BtGoXDLbI9+geSPyL9GG7kCA2k5PcPBYTpyZfcljn1SwL7P57G0z0fuXx
 fjaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731344623; x=1731949423;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4PxJcypGLJUZeCvO6UFQ988vSD/DmSC0a3FHBYB21+M=;
 b=CzrcbzkK1VPn1A5qB03SnQB/MooRoC+4F/oZ60FABhy5JmybiQwKODfg+W9qDArk07
 Hs7dKv2lySaxAMdh3TMPAvv0AooGF23eziYXdJ8E1BFRxRC/986e6sMSu0QQVYZ/SokL
 RZ3ePF2OV1UDm+9QJM0QcyhkaDKeUCRYzgFM4aW16iK9MOhI9xFs2/x0tT3G+HAFPkRT
 ovSAbfIbYd94G5inwQTYGmx/MHqMFniPivh3/jQIBJMx+RTnRWIoX/n4tUP5DrLh8DYl
 NF8YREJlRHiiI0GgisEwcWS8z1TJULlZxtUh0xJ7KNY27eXehGRwCrfA9y+XJuMeP0aH
 CBiw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXfanUVLnFJojMAsXbXDsICHZjQSyFLBnNxmsk5zrEdC/zOFS5ozbEkAzTAna39rz8dYLUgaZgauY7@nongnu.org
X-Gm-Message-State: AOJu0YzQYwa0zJrBm9sq1UXO0+duKcYMccAWUwdU57Xs/WA80Yi+h3vu
 FJDJ+5xdxGYFmXqZf+bYLCeeHSUX/wLyttuhuO1Fq0hBASuKLOnY8mBBK68Tqwc=
X-Google-Smtp-Source: AGHT+IGn0PeJpySm3IEU6/Rh1tulbfSGe2cd/VPOmBaQaP764kqOH+NinLos924OyY9Ym/VWDjatmA==
X-Received: by 2002:a05:600c:4590:b0:430:57f2:bae5 with SMTP id
 5b1f17b1804b1-432b751cc3emr105100205e9.27.1731344623042; 
 Mon, 11 Nov 2024 09:03:43 -0800 (PST)
Received: from localhost.localdomain
 (vau06-h02-176-184-43-163.dsl.sta.abo.bbox.fr. [176.184.43.163])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432b05c18e0sm184802655e9.28.2024.11.11.09.03.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 11 Nov 2024 09:03:41 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Fabiano Rosas <farosas@suse.de>,
	qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 1/2] block: Improve blk_get_attached_dev_id() docstring
Date: Mon, 11 Nov 2024 18:03:32 +0100
Message-ID: <20241111170333.43833-2-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241111170333.43833-1-philmd@linaro.org>
References: <20241111170333.43833-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Expose the method docstring in the header, and mention
returned value must be free'd by caller.

Reported-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/sysemu/block-backend-io.h |  7 +++++++
 block/block-backend.c             | 12 ++++++++----
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/include/sysemu/block-backend-io.h b/include/sysemu/block-backend-io.h
index d174275a5c..ba8dfcc7d0 100644
--- a/include/sysemu/block-backend-io.h
+++ b/include/sysemu/block-backend-io.h
@@ -32,6 +32,13 @@ void blk_set_allow_aio_context_change(BlockBackend *blk, bool allow);
 void blk_set_disable_request_queuing(BlockBackend *blk, bool disable);
 bool blk_iostatus_is_enabled(const BlockBackend *blk);
 
+/*
+ * Return the qdev ID, or if no ID is assigned the QOM path,
+ * of the block device attached to the BlockBackend.
+ *
+ * The caller is responsible for releasing the value returned
+ * with g_free() after use.
+ */
 char *blk_get_attached_dev_id(BlockBackend *blk);
 
 BlockAIOCB *blk_aio_pwrite_zeroes(BlockBackend *blk, int64_t offset,
diff --git a/block/block-backend.c b/block/block-backend.c
index 85bcdedcef..7b329ff194 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -1019,6 +1019,10 @@ DeviceState *blk_get_attached_dev(BlockBackend *blk)
     return blk->dev;
 }
 
+/*
+ * The caller is responsible for releasing the value returned
+ * with g_free() after use.
+ */
 static char *blk_get_attached_dev_id_or_path(BlockBackend *blk, bool want_id)
 {
     DeviceState *dev = blk->dev;
@@ -1033,15 +1037,15 @@ static char *blk_get_attached_dev_id_or_path(BlockBackend *blk, bool want_id)
     return object_get_canonical_path(OBJECT(dev)) ?: g_strdup("");
 }
 
-/*
- * Return the qdev ID, or if no ID is assigned the QOM path, of the block
- * device attached to the BlockBackend.
- */
 char *blk_get_attached_dev_id(BlockBackend *blk)
 {
     return blk_get_attached_dev_id_or_path(blk, true);
 }
 
+/*
+ * The caller is responsible for releasing the value returned
+ * with g_free() after use.
+ */
 static char *blk_get_attached_dev_path(BlockBackend *blk)
 {
     return blk_get_attached_dev_id_or_path(blk, false);
-- 
2.45.2


