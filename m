Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81D18C3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 20:19:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sb494-0001jj-Bi; Mon, 05 Aug 2024 16:17:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3UjOxZgUKCrksZuhofnnfkd.bnlpdlt-cdudkmnmfmt.nqf@flex--tavip.bounces.google.com>)
 id 1sb493-0001fu-Bf
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 16:17:29 -0400
Received: from mail-pj1-x104a.google.com ([2607:f8b0:4864:20::104a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3UjOxZgUKCrksZuhofnnfkd.bnlpdlt-cdudkmnmfmt.nqf@flex--tavip.bounces.google.com>)
 id 1sb490-0001Nu-Db
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 16:17:29 -0400
Received: by mail-pj1-x104a.google.com with SMTP id
 98e67ed59e1d1-2cb576921b6so23235a91.1
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2024 13:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1722889042; x=1723493842; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=v+XZ2Rl5k5if0oOWfRcW5SGcn2wm2BUtZIoAAUrM80c=;
 b=XvDD8jonemqGJ8R3hMqlTU3FSS8pzrMcSY9fZDzPPLiMqGHXkf+RRpUyKerPjqqBHj
 fh/uw9Xwh26MlYgdwby0DaKDtLpP84hBPzy4uYiDM67nl3G1SPhYodhBqHw9GswFKgNd
 iA5gwHSmxw82pRCIzLNw2w0AF4xsS/6WZ4mcATXtUCA5RViVfrg0cMu1o2JsTJgUalWx
 jRk99qaN3h1XRA6PioBEIlAJm/a6oTwZbRd3Apm3BHlXx4dyNQ8pyn3x77zTRqK4LWiV
 Z2d2eKQ/KROkPEOxRKUcjfDoVQSPiEajw3MQXm4z8y9eQccLx7UQTQ40EVPOhdAKmd6X
 uVkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722889042; x=1723493842;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=v+XZ2Rl5k5if0oOWfRcW5SGcn2wm2BUtZIoAAUrM80c=;
 b=OEWUoxFlL1holtchCe0zW3LET23Rn1arh7jtU/9LLrduiwb4dB/0Q4OG03ezlVTPIj
 LYdUR4Ihd+DHbz5xbsJsaerhr8XpYBFyN9/8n4Nmpum263QTWhPt+OFZXzg/aVOIC1vJ
 IEXYrsKc48KMZnIfTpHoiRUSUya4uycSlpdx8pZJKuzI1rPV8WiebFWZwRnLMax6brE8
 L9WXn5ncML4V4nZq/frlGRcJKY5QfTb/2uLpuUK1+YHSb85SIs8qjYPLlQlhANRwka2o
 F3+MVd1StaUXLfdP0IU1SP8ctbSwnLs+yalyywWGU5tPAUZL9bsgmE7CFyE3Gb6MLmOB
 FMzA==
X-Gm-Message-State: AOJu0YzViGVWCb59B8XSlF4CBqK/wCYyV+/UhYGQiWSeHTqMwolMy/+q
 BC83Cmk3JLKnqjP4/zUDZSfKSnDkKHIt/kMttJ1vIG9RnF9y5enyof0Rp7rJuyEY8/3r6cfXvK1
 t46jm76ibk9EnZTKMugxV38g4pYd1jGKEN9lHnhAGFWjU6jQa26YwPcw/Xi8Z4us+ZXGbQHLb2h
 ZIPPVe58aEvdHBNyUuiEyMy8I+gg==
X-Google-Smtp-Source: AGHT+IGSw77EguaF6TzFUl9hSn+D85XT29tsuj2jEdezd7+A3i+GB6qt6WaOoxbln6W2tkN/LgpP3KwjKQ==
X-Received: from warp10.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:750])
 (user=tavip job=sendgmr) by 2002:a17:90b:3cc7:b0:2c9:81c6:b0ee
 with SMTP id
 98e67ed59e1d1-2cff9520a11mr181407a91.4.1722889042082; Mon, 05 Aug 2024
 13:17:22 -0700 (PDT)
Date: Mon,  5 Aug 2024 13:16:56 -0700
In-Reply-To: <20240805201719.2345596-1-tavip@google.com>
Mime-Version: 1.0
References: <20240805201719.2345596-1-tavip@google.com>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <20240805201719.2345596-2-tavip@google.com>
Subject: [RFC PATCH 01/23] fifo32: add peek function
From: Octavian Purdila <tavip@google.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, stefanst@google.com, pbonzini@redhat.com, 
 alex.bennee@linaro.org, thuth@redhat.com, peter.maydell@linaro.org, 
 marcandre.lureau@redhat.com, alistair@alistair23.me, berrange@redhat.com, 
 philmd@linaro.org, jsnow@redhat.com, crosa@redhat.com, bleal@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::104a;
 envelope-from=3UjOxZgUKCrksZuhofnnfkd.bnlpdlt-cdudkmnmfmt.nqf@flex--tavip.bounces.google.com;
 helo=mail-pj1-x104a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=unavailable autolearn_force=no
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

Add fifo32_peek() that returns the first element from the queue
without popping it.

Signed-off-by: Octavian Purdila <tavip@google.com>
---
 include/qemu/fifo32.h | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/include/qemu/fifo32.h b/include/qemu/fifo32.h
index 4e9fd1b5ef..c9befc47c8 100644
--- a/include/qemu/fifo32.h
+++ b/include/qemu/fifo32.h
@@ -140,6 +140,35 @@ static inline uint32_t fifo32_pop(Fifo32 *fifo)
     return ret;
 }
 
+/**
+ * fifo32_peek:
+ * @fifo: fifo to peek at
+ *
+ * Returns the value from the FIFO's head without poping it. Behaviour
+ * is undefined if the FIFO is empty. Clients are responsible for
+ * checking for emptiness using fifo32_is_empty().
+ *
+ * Returns: the value from the FIFO's head
+ */
+
+static inline uint32_t fifo32_peek(Fifo32 *fifo)
+{
+    uint32_t ret = 0, num;
+    const uint8_t *buf;
+    int i;
+
+    buf = fifo8_peek_buf(&fifo->fifo, 4, &num);
+    if (num != 4) {
+        return ret;
+    }
+
+    for (i = 0; i < sizeof(uint32_t); i++) {
+        ret |= buf[i] << (i * 8);
+    }
+
+    return ret;
+}
+
 /**
  * There is no fifo32_pop_buf() because the data is not stored in the buffer
  * as a set of native-order words.
-- 
2.46.0.rc2.264.g509ed76dc8-goog


