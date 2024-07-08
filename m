Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EF01C3271E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 12:20:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQnL5-0001pN-OU; Mon, 08 Jul 2024 08:19:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1sQnKy-0001ef-OP
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 08:19:20 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1sQnKu-0001Uk-HX
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 08:19:19 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1fb3e9e32ffso14057215ad.0
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2024 05:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1720441152; x=1721045952; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ROim7xG4VeV7okIeoWk1lldyf4YzP1rLfO+fx4YPjhw=;
 b=L4Z5o/GlWQmdRCA+B5LdJEXHGQAu+hPnd0owcfTTJDZqO0kFctA2bYaaXCX1zBvlpe
 7OcJwr19/AdNf3/8AvnwXwW/jYTOVJ67ruWwT3Nqkz6o+X7m4TlRYgJ/mBq5oPO4+mrp
 nvQt0fe3b7eqBUSMrRij5hDaUQ7daAtAG43Zm+8Zq/FAMniEq8VtCin3GD2uZFPKKl/M
 illHc96uuPCKzwEd4A0Foc/y5Ao6nqR0gQs838jIG9rMqChvpZ3N3u+72V07QyBC+sgb
 t5qFm/l0wDTm8noAR0AXo6afvwA3xzxrEK9hKNG1so4PMjlXQ1a5qLiN/rvS3FaV3iG7
 s0Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720441152; x=1721045952;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ROim7xG4VeV7okIeoWk1lldyf4YzP1rLfO+fx4YPjhw=;
 b=mNo6/nD9UvE9cRF6UsXFCN3aYbqlOT0dv/xbuVso4S9tbnejdXP6Ef8wAyENROFx3d
 gccpaad9MFwPxH+ze+uI8zyMapQpu4f9JdOYnuUyIR5Qwlb1aUF/3jZYP3K/0lLmpmmr
 K+V6R/yN3R3c/DcdG+Jkre/1ap2wZhccdNy/su7b+e7uF2AVwHtvdqvVIetNO6EOin9e
 LtyHTknTf38adE/aHqLpklw2LgmOZUV7hbwT3QY0HecIakS3PmSuyIWDhehOcUxYnvuN
 rXSwthAN+8JTn71qvziKh7Wyg7q0IrgGBBR9ca4WxAU6eXjTaNJykNkzwX162X50v5U8
 bjEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUARwcW9J9eQe63m+jKeD/3VRu+gqEPN36TtgAKDF4cfMenOC4ArwXa5s/T9FTG0LQA6PBwciOj5gSYH6rvL3hnzZ5AAHo=
X-Gm-Message-State: AOJu0YxyKFrbC8s/kUUKXTlZDUxWFyJ+MHCvvvvbIULePSZnmvUAh7VQ
 wVOnwBv4lelDxCyTj0WnYFLsSgkisuK2iS4MQdLTp3CV0Ha5K1Havt9d1tUn6/k=
X-Google-Smtp-Source: AGHT+IHjrprhjKg/AmwwaeehyukElc2S1mcMQERCtKOkqC3AdyL9qLOxDBj0iCYE06o4V9rc1LxzXQ==
X-Received: by 2002:a17:903:181:b0:1fb:4a68:b7ba with SMTP id
 d9443c01a7336-1fb4a68bd65mr44927025ad.43.1720441151998; 
 Mon, 08 Jul 2024 05:19:11 -0700 (PDT)
Received: from n37-006-243.byted.org ([180.184.49.4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fb4fa258f7sm56587195ad.169.2024.07.08.05.19.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jul 2024 05:19:11 -0700 (PDT)
From: Changqi Lu <luchangqi.123@bytedance.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, stefanha@redhat.com, fam@euphon.net,
 ronniesahlberg@gmail.com, pbonzini@redhat.com, pl@dlhnet.de,
 kbusch@kernel.org, its@irrelevant.dk, foss@defmacro.it, philmd@linaro.org,
 pizhenwei@bytedance.com, Changqi Lu <luchangqi.123@bytedance.com>
Subject: [PATCH v8 02/10] block/raw: add persistent reservation in/out driver
Date: Mon,  8 Jul 2024 20:18:46 +0800
Message-Id: <20240708121854.1318876-3-luchangqi.123@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240708121854.1318876-1-luchangqi.123@bytedance.com>
References: <20240708121854.1318876-1-luchangqi.123@bytedance.com>
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


