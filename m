Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9461FC52D7F
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Aug 2024 10:32:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sfGe0-0006QE-4k; Sat, 17 Aug 2024 06:26:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3wXrAZgUKCvQpWrelckkcha.Ykimaiq-Zarahjkjcjq.knc@flex--tavip.bounces.google.com>)
 id 1sfGde-0006Cc-KU
 for qemu-devel@nongnu.org; Sat, 17 Aug 2024 06:26:26 -0400
Received: from mail-yw1-x114a.google.com ([2607:f8b0:4864:20::114a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3wXrAZgUKCvQpWrelckkcha.Ykimaiq-Zarahjkjcjq.knc@flex--tavip.bounces.google.com>)
 id 1sfGdQ-00036j-C4
 for qemu-devel@nongnu.org; Sat, 17 Aug 2024 06:26:22 -0400
Received: by mail-yw1-x114a.google.com with SMTP id
 00721157ae682-6b0f068833bso28572997b3.0
 for <qemu-devel@nongnu.org>; Sat, 17 Aug 2024 03:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1723890370; x=1724495170; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=g0XCLUPYxGQ5i0atXjj8FMDAblhXlT56A5I6yFI98jg=;
 b=Q7x4fsAh9vMLnZpJ7qWruB1NmTkEJRGX10fMr/hge24uMMm3IeWxJiFe6BgAYyPKS3
 P57LBtj1FwqmLUOJFyIqycj+3P+SS8GcaFWhN1/ebnV7lxF2ejzyc1ZK704wqDwM5Y21
 0SZ+lwkDrwqORRvlmXTN92WuYewJYxfqQ5CT9QUaIJxNX2VMl9EEHijslWmvawB5JhDm
 uYGFGbsYFBdtHi9DeV2DkM0kHRczo2WQNDrKtk2yqeYNhjaetM1iq2uF9vq2ZuwBcF6W
 lrcwcyEZFJCm0L2A5MZ7xVRyjSjMeeLxkNrltt69D9nOzzXbsEKM0O/el+xstCQm9POx
 N5TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723890370; x=1724495170;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=g0XCLUPYxGQ5i0atXjj8FMDAblhXlT56A5I6yFI98jg=;
 b=bfRivoQBbEGHZOYcuDw9FpqzzLlz4QwJeuch3wRe83yNVbENKl8JkZ7PZA5FkOMmAs
 wXWpjaTQ8VLHf0188gvQzz6r+FPleAVSnO4ZQuLQqHzfKzD6+OOfUZvfcEFpoSYDI2fG
 74U2blU9u+jtKe179eWAQE6oHNgm5hd3w/V9W+xPkLC4XppT2ok+XkCYzxu+k6RJzW8E
 GOO1WvVHTTJKUgXtA2eEEO824sRHLMbEYQI7q60Qwbk69DGMVIANULAUtaf3/s8jXhNZ
 5Dw9bsovL28fDhMyeYE6Jcoqx5ct96s+6SLH368Wxd3OpfO7RsrTc3YCbdAbPmXVlaSb
 LwVw==
X-Gm-Message-State: AOJu0Yx20Qav3rPA9xHD0eLoA74XbQS02h82lUTKkLGyiSQaS0L71hN3
 JIIO1hURwEZ1SJrjySQ1c6LbOstA2bVMp0M26WjDiTcIr0uWKVWTi39uPzMco7TSDKHrF3y41pn
 3V3S1cbiReF1BXQ/2tCyWRVTXbMsQHsrF80eMrHdW06mAc4QHlmF7w1XK7PBOGpP0MWnO4vOj3x
 /mlyizkiL4OHLiSGl/fS++/0H0Wg==
X-Google-Smtp-Source: AGHT+IEjqPwwlvxkTbqI/APwlgmkxDAH5a+wlakPZeTgxGE/w9Me6YrIxF2K9dgDFS1r1NG59+hJeA4a3A==
X-Received: from warp10.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:750])
 (user=tavip job=sendgmr) by 2002:a25:910e:0:b0:e0b:a34d:f223 with
 SMTP id
 3f1490d57ef6-e116cecab95mr126463276.5.1723890369867; Sat, 17 Aug 2024
 03:26:09 -0700 (PDT)
Date: Sat, 17 Aug 2024 03:25:44 -0700
In-Reply-To: <20240817102606.3996242-1-tavip@google.com>
Mime-Version: 1.0
References: <20240817102606.3996242-1-tavip@google.com>
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
Message-ID: <20240817102606.3996242-2-tavip@google.com>
Subject: [RFC PATCH v2 01/23] fifo32: add peek function
From: Octavian Purdila <tavip@google.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, stefanst@google.com, pbonzini@redhat.com, 
 thuth@redhat.com, peter.maydell@linaro.org, marcandre.lureau@redhat.com, 
 alistair@alistair23.me, berrange@redhat.com, philmd@linaro.org, 
 jsnow@redhat.com, crosa@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::114a;
 envelope-from=3wXrAZgUKCvQpWrelckkcha.Ykimaiq-Zarahjkjcjq.knc@flex--tavip.bounces.google.com;
 helo=mail-yw1-x114a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
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
 include/qemu/fifo32.h | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/include/qemu/fifo32.h b/include/qemu/fifo32.h
index 4e9fd1b5ef..77aab488ae 100644
--- a/include/qemu/fifo32.h
+++ b/include/qemu/fifo32.h
@@ -140,6 +140,34 @@ static inline uint32_t fifo32_pop(Fifo32 *fifo)
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
+
+    buf = fifo8_peek_buf(&fifo->fifo, 4, &num);
+    if (num != 4) {
+        return ret;
+    }
+
+    for (int i = 0; i < sizeof(uint32_t); i++) {
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
2.46.0.184.g6999bdac58-goog


