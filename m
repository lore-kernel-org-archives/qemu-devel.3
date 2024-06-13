Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8655BC27C75
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 07:15:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHeec-0007Tr-VU; Thu, 13 Jun 2024 03:13:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1sHeeZ-0007Rx-J7
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 03:13:47 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1sHeeX-00072x-Ed
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 03:13:47 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1f6da06ba24so6704355ad.2
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2024 00:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1718262824; x=1718867624; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LEuUjUzQAGNW2bFbTYz8h5s7RYYUBYzAO9/VPokyqDk=;
 b=DJOORG46ssDwNyxuW7sG98+Pz1UFwRslqNy3pHhoYbDdTK092bwvbVORosz2HdBJwj
 Vu4iQOUko0B8QEZCC4OdmZh1dBQaWMdjW7PNrCAiLdljYAGe6+fMkPLzw4JFLGstyKXe
 5rw4V9Da072t22bsbrqTjkSs0FSXiY/WPGLWitiy5zSTLqP+1rVA8IBhQtdCf/Dgv9/V
 fLI6i5TgdgAZoW8debg9gReBeJtv8bRwHaYkYOKiNmrmeyDApAdaOzLtn/TXFwbXMj1O
 Zz3RnpbP7QUNuXuifs/ywixHMNFr9dqhtseGMTmVA4fcv8HSXEiiULUvO9t/skMHE2JS
 2slw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718262824; x=1718867624;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LEuUjUzQAGNW2bFbTYz8h5s7RYYUBYzAO9/VPokyqDk=;
 b=dAL23gxLzJ7/vO2R8Oki7WKGeesEK2I0F5yL9MslNHEnimDoMWgTRiGq3STJN4xWBf
 3INQXFlRyDU18zX9q74oKpmTy3GAKqcvG9Cjfqv4/NmQF7yA4NZsyjIF5dg/rAHbaAkG
 j+9BxUvG4X8JD8Do681eTX94kYWXzWSYi5qE1MWY60sW2w/fSew+uIC/yqIhvMbEY2hw
 6/DPJMYtXFBxNd/cj89XDD0ZXlHMEs9/Ab+zsWurnb4J8sLlW16tBxIAXC2AWOyXNXxa
 jT+TpeM4RkV4LhB08ykVpIekvOjRHjuONILsIVFTMJ8+4ZX6M+omFvb1s07/D7s+V5uj
 MJqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1NprjmXdxgrWRZehCLgUuITkewzCe2Mosq/SrVydEXONogeJPII4RMRFuZaQFZVKj32gYbzSWg62tn1mD0OJuz9gAkY0=
X-Gm-Message-State: AOJu0YwHeoQClSmHmW+QbfBYyJMl4PO/UF69oUNDlZ/ZgDmRR91tGEZI
 /VmNnHVXQpEulNYJGOCGt2AazYoWyUq3ArUeCz4AAa9IUCLTnO7Vi8prra6dTpE=
X-Google-Smtp-Source: AGHT+IFawuQXAPHcKSTatwQ7x/cokB3cw2en19qsA2N3N9uCO6XNF+VTTbK/utnasCX2sRXguI18FA==
X-Received: by 2002:a17:902:db02:b0:1f6:ff48:1cdb with SMTP id
 d9443c01a7336-1f83b7002a2mr45163765ad.52.1718262823926; 
 Thu, 13 Jun 2024 00:13:43 -0700 (PDT)
Received: from n37-006-243.byted.org ([180.184.84.173])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f855ee6e7esm6378345ad.139.2024.06.13.00.13.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Jun 2024 00:13:43 -0700 (PDT)
From: Changqi Lu <luchangqi.123@bytedance.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, stefanha@redhat.com, fam@euphon.net,
 ronniesahlberg@gmail.com, pbonzini@redhat.com, pl@dlhnet.de,
 kbusch@kernel.org, its@irrelevant.dk, foss@defmacro.it, philmd@linaro.org,
 pizhenwei@bytedance.com, Changqi Lu <luchangqi.123@bytedance.com>
Subject: [PATCH v6 02/10] block/raw: add persistent reservation in/out driver
Date: Thu, 13 Jun 2024 15:13:19 +0800
Message-Id: <20240613071327.2498953-3-luchangqi.123@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240613071327.2498953-1-luchangqi.123@bytedance.com>
References: <20240613071327.2498953-1-luchangqi.123@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=luchangqi.123@bytedance.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Add persistent reservation in/out operations for raw driver.
The following methods are implemented: bdrv_co_pr_read_keys,
bdrv_co_pr_read_reservation, bdrv_co_pr_register, bdrv_co_pr_reserve,
bdrv_co_pr_release, bdrv_co_pr_clear and bdrv_co_pr_preempt.

Signed-off-by: Changqi Lu <luchangqi.123@bytedance.com>
Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 block/raw-format.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/block/raw-format.c b/block/raw-format.c
index ac7e8495f6..3746bc1bd3 100644
--- a/block/raw-format.c
+++ b/block/raw-format.c
@@ -454,6 +454,55 @@ raw_co_ioctl(BlockDriverState *bs, unsigned long int req, void *buf)
     return bdrv_co_ioctl(bs->file->bs, req, buf);
 }
 
+static int coroutine_fn GRAPH_RDLOCK
+raw_co_pr_read_keys(BlockDriverState *bs, uint32_t *generation,
+                    uint32_t num_keys, uint64_t *keys)
+{
+
+    return bdrv_co_pr_read_keys(bs->file->bs, generation, num_keys, keys);
+}
+
+static int coroutine_fn GRAPH_RDLOCK
+raw_co_pr_read_reservation(BlockDriverState *bs, uint32_t *generation,
+                           uint64_t *key, BlockPrType *type)
+{
+    return bdrv_co_pr_read_reservation(bs->file->bs, generation, key, type);
+}
+
+static int coroutine_fn GRAPH_RDLOCK
+raw_co_pr_register(BlockDriverState *bs, uint64_t old_key,
+                   uint64_t new_key, BlockPrType type,
+                   bool ptpl, bool ignore_key)
+{
+    return bdrv_co_pr_register(bs->file->bs, old_key, new_key,
+                               type, ptpl, ignore_key);
+}
+
+static int coroutine_fn GRAPH_RDLOCK
+raw_co_pr_reserve(BlockDriverState *bs, uint64_t key, BlockPrType type)
+{
+    return bdrv_co_pr_reserve(bs->file->bs, key, type);
+}
+
+static int coroutine_fn GRAPH_RDLOCK
+raw_co_pr_release(BlockDriverState *bs, uint64_t key, BlockPrType type)
+{
+    return bdrv_co_pr_release(bs->file->bs, key, type);
+}
+
+static int coroutine_fn GRAPH_RDLOCK
+raw_co_pr_clear(BlockDriverState *bs, uint64_t key)
+{
+    return bdrv_co_pr_clear(bs->file->bs, key);
+}
+
+static int coroutine_fn GRAPH_RDLOCK
+raw_co_pr_preempt(BlockDriverState *bs, uint64_t old_key,
+                  uint64_t new_key, BlockPrType type, bool abort)
+{
+    return bdrv_co_pr_preempt(bs->file->bs, old_key, new_key, type, abort);
+}
+
 static int GRAPH_RDLOCK raw_has_zero_init(BlockDriverState *bs)
 {
     return bdrv_has_zero_init(bs->file->bs);
@@ -672,6 +721,13 @@ BlockDriver bdrv_raw = {
     .strong_runtime_opts  = raw_strong_runtime_opts,
     .mutable_opts         = mutable_opts,
     .bdrv_cancel_in_flight = raw_cancel_in_flight,
+    .bdrv_co_pr_read_keys    = raw_co_pr_read_keys,
+    .bdrv_co_pr_read_reservation = raw_co_pr_read_reservation,
+    .bdrv_co_pr_register     = raw_co_pr_register,
+    .bdrv_co_pr_reserve      = raw_co_pr_reserve,
+    .bdrv_co_pr_release      = raw_co_pr_release,
+    .bdrv_co_pr_clear        = raw_co_pr_clear,
+    .bdrv_co_pr_preempt      = raw_co_pr_preempt,
 };
 
 static void bdrv_raw_init(void)
-- 
2.20.1


