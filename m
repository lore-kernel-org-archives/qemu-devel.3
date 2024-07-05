Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A45FCC30658
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 10:57:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPgcF-0002C7-4J; Fri, 05 Jul 2024 06:56:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1sPgcD-0002B6-QZ
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 06:56:33 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1sPgcC-0006ar-5L
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 06:56:33 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1fb05ac6b77so8891755ad.0
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 03:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1720176991; x=1720781791; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ROim7xG4VeV7okIeoWk1lldyf4YzP1rLfO+fx4YPjhw=;
 b=Kx44+b9T5AMVtDhiM25kkEDuPNwTzfoj94yX5Ahdx3PuIZ6JIIx0LNRtkZHHA8TBH0
 hiqu0LxhMkBwA7yKkmon/sS90TaKGFYBtBjkUPesaQMEuWd5CV5gXwpHSYSibXV/E8vd
 nlgyWzSnSAVIT7XzukXQYh+KmVUhZgozHs40l/xc+nGJSR3PWxG825BuhMRwQfzQ3e4C
 2J71bVl9adZ2sQ3jhIaES73wCFNE7RWDntkprpkpQ4/DWc1JHPFDJLWs5chaERkxtkb/
 c0n69TxyjXtxsLLNG5uufgekI6lwNJ2Hm/S/7nlBBNstSUP0sEnfdDUD03eMBTO2JD+b
 Prig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720176991; x=1720781791;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ROim7xG4VeV7okIeoWk1lldyf4YzP1rLfO+fx4YPjhw=;
 b=B45Py4fNIB05Ep7MUFx5sk5bIKQJR/bqOpjKWUQt5E+OwFwRqbaSOicfD2sLEpNB2G
 eUcSnMdAlousF8rNEAlQXJyIjV4gYpF3KRwCJocJJ/9Cc6Cr+4EJcFomWJAL8b/tUuIu
 qFVhLwAnU2GjmRD7l81oSvdkvgKXSY4Kpj16XCtNrz6YdvHTVOpm4BIPW4Huoz9WcytC
 CmkOs3ITz7DvYzQJghnbpCKbWxDdrpdbimDcCqBtsPcMlCn9SyryPf4fDIxlY9yC6Wm3
 ebIpRSEnq02UCTybdHhWfjUeC12/1JhXcM57UrgkuSnT5T0lZRBNHG1tRLvWssIOLXAD
 gdyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5eLa49ahYI9x8aDQ6QYSP4oApGfugv3488utbbqFs5JYFji02LgFEgOI2qa/Z0pr0cjdvvWMSzRLxfedQoVg8WpUqlnY=
X-Gm-Message-State: AOJu0YywMEuJJjA3AIb9dSks4Zlans1+N0cdeAj2XYxmtI9tNC1NQOFm
 iJFWQJhVyFNVm8CAgkiW+WTasUHgjCxbffHyFOOPO6oFgB1uM9URVM6yFoUJOgI=
X-Google-Smtp-Source: AGHT+IHdqvZQqbQvouqUnBwhoqH2w60e9fQTBpR4toW0S7MN9G22FzrDAqF6N7Rh/67KMZjsGmVQFg==
X-Received: by 2002:a17:903:2307:b0:1fb:34ef:444b with SMTP id
 d9443c01a7336-1fb34ef4d00mr37181055ad.54.1720176990704; 
 Fri, 05 Jul 2024 03:56:30 -0700 (PDT)
Received: from n37-006-243.byted.org ([180.184.84.173])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fac0ba60a2sm141292125ad.0.2024.07.05.03.56.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jul 2024 03:56:30 -0700 (PDT)
From: Changqi Lu <luchangqi.123@bytedance.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, stefanha@redhat.com, fam@euphon.net,
 ronniesahlberg@gmail.com, pbonzini@redhat.com, pl@dlhnet.de,
 kbusch@kernel.org, its@irrelevant.dk, foss@defmacro.it, philmd@linaro.org,
 pizhenwei@bytedance.com, Changqi Lu <luchangqi.123@bytedance.com>
Subject: [PATCH v7 02/10] block/raw: add persistent reservation in/out driver
Date: Fri,  5 Jul 2024 18:56:06 +0800
Message-Id: <20240705105614.3377694-3-luchangqi.123@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240705105614.3377694-1-luchangqi.123@bytedance.com>
References: <20240705105614.3377694-1-luchangqi.123@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=luchangqi.123@bytedance.com; helo=mail-pl1-x633.google.com
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

Add persistent reservation in/out operations for raw driver.
The following methods are implemented: bdrv_co_pr_read_keys,
bdrv_co_pr_read_reservation, bdrv_co_pr_register, bdrv_co_pr_reserve,
bdrv_co_pr_release, bdrv_co_pr_clear and bdrv_co_pr_preempt.

Signed-off-by: Changqi Lu <luchangqi.123@bytedance.com>
Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
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


