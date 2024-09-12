Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C627AEEB596
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 11:22:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sohra-0006I1-R0; Thu, 12 Sep 2024 07:19:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1sohrV-00067n-Qy
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 07:19:46 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1sohrU-000829-5M
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 07:19:45 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-718d6ad6050so652352b3a.0
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2024 04:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1726139980; x=1726744780; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ROim7xG4VeV7okIeoWk1lldyf4YzP1rLfO+fx4YPjhw=;
 b=bxnmdwahlAaq0hISy/FY/+Ps/iXwWSQg/pShCGSmwTTrHZ9fGnd82ZPD3pFTBYaJ36
 HMH7V10BfjMzUaNGufdDlL/vkwXUOskKxq88rzWNfID3sspTUYGFGNkoIFpdC8H/kkIL
 SDLoRSMYB3m5/uk+UGUT4N2DeHZ+RPzzzq/9QOUTZBhQr335AQ6gWx9442vg7wI7Mzea
 JdGP6sRqgiBAIYsO+yQjBzK+Utz056XZEqSyDTR7L9UAUsvxEnFAxWxfpuWu8iwM4uUv
 Un3uqJoREN7+IsGNeYfiZkoQZQhFvmEzrtMyuoh2J67GRHu+GieCAIdXXkKGw25VG62s
 E+Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726139980; x=1726744780;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ROim7xG4VeV7okIeoWk1lldyf4YzP1rLfO+fx4YPjhw=;
 b=VmBP4N5A7x3ST6SN0IH2NsLG6sqGX3nz/zVxG1lIUD3QIAIF/wa/PN+QkzzWro05aT
 DA7PT4fCWQbGpRwg6+bROKMzrzpGuO4lvPfaTuzdttZYBb8sBfrZfqP7a70kYkjQ9LKH
 wF7yiRW5h+XvtY1ArbDWtNdEfDxwlz9h9G1awbBIcCDE7dGd1Cyps+QF/aNvvKsynu7v
 QULHfPFoOyk5UaXsM35UapdHbisXQeCk2Ye/2jIWhZVQV7CbtrYWgbIU+63iBfTK+ih2
 VbI6kSlROu8AIOqSmrG1aSMEiZokJSwFPPdC+WlVqTImLTuZ2/9fIW4lGXE9gSL9Apam
 nFbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7KJ+pKIPbDSUuYfwaXmFP0afycxEwTpQoIQg7H+RVYCQKwwErSqXCqAUBoodokkYO6qkevIm8Vd7R@nongnu.org
X-Gm-Message-State: AOJu0Yz8E+cvjJyF5Ucewp/JerEuPdXGcRJpynrOzpBG9EzuUOtvwwWf
 KbdjkBsapkEBX4UX2dYaiiE6UDSxKDaosoKd3FutEQMDwQdClEPftHw2NzQoIQw=
X-Google-Smtp-Source: AGHT+IEqbzRpaoAkCdqOkdH1fgk9PkHbgD2DxQoQPYutHWOxSXmQl5Gt/14KlMa6kTgVu0LltWLc9A==
X-Received: by 2002:a05:6a00:228a:b0:717:8e01:c593 with SMTP id
 d2e1a72fcca58-71926063591mr4047480b3a.3.1726139979596; 
 Thu, 12 Sep 2024 04:19:39 -0700 (PDT)
Received: from TF4D9JK212.bytedance.net ([61.213.176.5])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-719090afadasm4552072b3a.177.2024.09.12.04.19.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 12 Sep 2024 04:19:38 -0700 (PDT)
From: Changqi Lu <luchangqi.123@bytedance.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, stefanha@redhat.com, fam@euphon.net,
 ronniesahlberg@gmail.com, pbonzini@redhat.com, pl@dlhnet.de,
 kbusch@kernel.org, its@irrelevant.dk, foss@defmacro.it, philmd@linaro.org,
 pizhenwei@bytedance.com, k.jensen@samsung.com,
 Changqi Lu <luchangqi.123@bytedance.com>
Subject: [PATCH v12 02/10] block/raw: add persistent reservation in/out driver
Date: Thu, 12 Sep 2024 19:19:09 +0800
Message-Id: <20240912111917.81477-3-luchangqi.123@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20240912111917.81477-1-luchangqi.123@bytedance.com>
References: <20240912111917.81477-1-luchangqi.123@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=luchangqi.123@bytedance.com; helo=mail-pf1-x42d.google.com
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


