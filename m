Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FBCFC27C54
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 12:26:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFCB3-0005Ax-Kz; Thu, 06 Jun 2024 08:25:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1sFCB2-0005Ab-5L
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 08:25:08 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1sFCB0-0007V8-Ax
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 08:25:07 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-70276322ad8so852075b3a.1
 for <qemu-devel@nongnu.org>; Thu, 06 Jun 2024 05:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1717676705; x=1718281505; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LEuUjUzQAGNW2bFbTYz8h5s7RYYUBYzAO9/VPokyqDk=;
 b=Fxcwev9QLDepR/WrYlhL/3+CaGpJ390op7bN51eMrjWRAFbjoo9ekCVUZKNuTHzlg/
 TGdU29DDd++pV3s8FRyMEhis/90Mb7sb39TjXdkc3lEonE04FrJrfaTiWQId/wa6OhIi
 u3trCq73w7p15oMtD3kEI8x8fqHZs5p3hZYgzJxMVRZEywKcanQKT0GkHgG3xa/VWyjO
 jyjJmISJpu5CertYjlYqzBxb9I6HUyp1KN8RT334EpKGHQmLqpuEPyIDVxzIHobn24YQ
 xKeG8RLdwRd2owppEl2zk533wmZEuxKCW6mgttvFsJuG6stQ/p3SzHYZQ/CG3c55VQ8p
 4IwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717676705; x=1718281505;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LEuUjUzQAGNW2bFbTYz8h5s7RYYUBYzAO9/VPokyqDk=;
 b=g/UW0XCIbYc0WFt/Eu1hlf2iM10OIRKfjWMoHMzPKX1xWwcUEBZeGgbqUk7r6LXQFh
 bfOhJxQZOmRY+khNDrJzdOI7a31ikSgRu0q8Ycnd3cxtoXzKa1CfPECmKt5pmrO6iQ1w
 mGJfUTkX3JL4/SQp1YroK2cx+j5cbLTkolykcmy5vGt9Lo0Xk2T1n+ODpCasNcle6bis
 5Sl3VCAy+mQPHS375313Fe8LCYuI8zwXVhEqrQmLdh1MyxDmfMqYLv1VBfAZIwn4A2QC
 MhGQSVnpLabEJnV37EHisWAoKXSc5jlHI2IWh5NH3tKBXk0KVDhnSxWF5TGxIYUY2/O6
 UrIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwvdRVF0KyDyYsYh43f5+/gmQed4JFJ5zshJNaeV9qbwyKEFwOCj8zmxvxhhL1O7Q/t8mAfPhG/oQEzj9esLcKI+uIe28=
X-Gm-Message-State: AOJu0YyfVLMSyqbwA9prrIvvuBnATzBBJNEZ0eTcrN8btKFJ07FrgGx5
 FXz+Po6cyX/mvDXB8fDrEDbkWOGbBxNNAKElHfCTNZyQ9OdTqx+lbCxEpQTKEY0=
X-Google-Smtp-Source: AGHT+IH5yOwvgRLKXJ7jgGjBJhXdj30xda5l99DJnAuM8C1whcHqu/yBmNOxIc6uU+MZEPNBqsZmgA==
X-Received: by 2002:a05:6a20:394a:b0:1b2:91a0:624a with SMTP id
 adf61e73a8af0-1b2b711fdfdmr6452334637.45.1717676704748; 
 Thu, 06 Jun 2024 05:25:04 -0700 (PDT)
Received: from n37-006-243.byted.org ([180.184.51.142])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c29c20d7adsm1459396a91.9.2024.06.06.05.25.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jun 2024 05:25:04 -0700 (PDT)
From: Changqi Lu <luchangqi.123@bytedance.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, stefanha@redhat.com, fam@euphon.net,
 ronniesahlberg@gmail.com, pbonzini@redhat.com, pl@dlhnet.de,
 kbusch@kernel.org, its@irrelevant.dk, foss@defmacro.it, philmd@linaro.org,
 pizhenwei@bytedance.com, Changqi Lu <luchangqi.123@bytedance.com>
Subject: [PATCH v5 02/10] block/raw: add persistent reservation in/out driver
Date: Thu,  6 Jun 2024 20:24:36 +0800
Message-Id: <20240606122444.2914576-3-luchangqi.123@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240606122444.2914576-1-luchangqi.123@bytedance.com>
References: <20240606122444.2914576-1-luchangqi.123@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=luchangqi.123@bytedance.com; helo=mail-pf1-x436.google.com
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


