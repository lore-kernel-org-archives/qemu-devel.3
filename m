Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2504AC41513
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2024 09:53:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7uGb-00023Q-DA; Fri, 17 May 2024 05:52:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1s7uGW-0001wq-JX
 for qemu-devel@nongnu.org; Fri, 17 May 2024 05:52:41 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1s7uGT-0006M7-8D
 for qemu-devel@nongnu.org; Fri, 17 May 2024 05:52:39 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6f447976de7so1043283b3a.1
 for <qemu-devel@nongnu.org>; Fri, 17 May 2024 02:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1715939556; x=1716544356; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LEuUjUzQAGNW2bFbTYz8h5s7RYYUBYzAO9/VPokyqDk=;
 b=lmhs2XksSqo5gEAeXvu8DM6jgfOsIPNHd48C1p+EDEtlLyM/iVGiw6NcgaLru83OQX
 04QHS7QZI9S1jC4HpRjEs0yqS5KZvY/sHAA1cXnale5ptD5TTr1T3obCPi3Pasy8OECk
 s4zyjHpvwBnwn03PEtkYU9SNMBnTUeE9rkRTgGAzB1ZI2xCWTE9NdAvlGOwPMrImqKXd
 Bxz3qPAmcMzfwalqAX64Vu18GdvUymAFJ7Uwz4M+Dx++vSp1UJKwLuj7nExcFbksKk15
 WF1PxQEUXCPxhr4kg45yptW4KzSF/YNsxTPOFVD5RPQLuvl1MVFp2qr5Og1J/1mr8jsW
 kTbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715939556; x=1716544356;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LEuUjUzQAGNW2bFbTYz8h5s7RYYUBYzAO9/VPokyqDk=;
 b=J/HPhzkHmPYntq8w4EE2sabq36+OudzevLJ82daGQIn2upMAjF4l/ys6Fg34k4gkF3
 iJN19OBpyWYq4X3jubNG4ATx3HIk2/yMo4eCOnPG1ZPi23yzgua0kfbgMnea8yuKrygW
 Uh0aPp6s/f9GN6670GJVL9CIahSZaHohsFCNKtqyElzX0BxE8O8Dk3dk17DcJf0d3zLE
 Y5XBR6j/QVjJClsGY8UFYUv8y+1WGIxtTUMK1UNu2uM1DzWiJM+cPpJJRjydpu3ZD5og
 ZNhUgL+J8FqCXf8QuRULOJAIMChk3mIQfjLueEaLfY9vOGF3nfhSNuRELHWPoUGLZySk
 ZfYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU46+EdzCeD5Az6KBC7fnJq0m6uvb8VEPWxe1clJJZd33fNAPgKonwP/tsnN0apfMaUCSwKCQGdc+6BkSuDjGSUuKGpf70=
X-Gm-Message-State: AOJu0YxXhLQvbyL093HZmaI+8kq57u8SaCtviGSPUuyRqPpkTTl7exYH
 rZR84tck58IA+G755PgGIHHGunOjeLes371+J0W7y1nviypLnoNxvFg5grG6KiA=
X-Google-Smtp-Source: AGHT+IFFP6Dkl3daDDTD4vu6KreT8DUtqQntcnTF/HeSHUIyNjqf9c+VO3FiqA+OFhEOCg90WRXDpg==
X-Received: by 2002:a05:6a20:9c89:b0:1a9:6cdd:6907 with SMTP id
 adf61e73a8af0-1afde10e425mr20880053637.29.1715939555778; 
 Fri, 17 May 2024 02:52:35 -0700 (PDT)
Received: from n37-006-243.byted.org ([180.184.51.134])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2b628ca53cesm16975992a91.44.2024.05.17.02.52.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 May 2024 02:52:35 -0700 (PDT)
From: Changqi Lu <luchangqi.123@bytedance.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, stefanha@redhat.com, fam@euphon.net,
 ronniesahlberg@gmail.com, pbonzini@redhat.com, pl@dlhnet.de,
 kbusch@kernel.org, its@irrelevant.dk, foss@defmacro.it, philmd@linaro.org,
 pizhenwei@bytedance.com, Changqi Lu <luchangqi.123@bytedance.com>
Subject: [PATCH v3 02/11] block/raw: add persistent reservation in/out driver
Date: Fri, 17 May 2024 17:52:09 +0800
Message-Id: <20240517095218.3107672-3-luchangqi.123@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240517095218.3107672-1-luchangqi.123@bytedance.com>
References: <20240517095218.3107672-1-luchangqi.123@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=luchangqi.123@bytedance.com; helo=mail-pf1-x429.google.com
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


