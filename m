Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A230CDD552
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 19:26:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sr0Gk-0004Yo-3N; Wed, 18 Sep 2024 15:23:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3kSjrZgUKCswBsD07y66y3w.u648w4C-vwDw3565y5C.69y@flex--tavip.bounces.google.com>)
 id 1sr0GV-0004S4-IC
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 15:23:04 -0400
Received: from mail-pl1-x64a.google.com ([2607:f8b0:4864:20::64a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3kSjrZgUKCswBsD07y66y3w.u648w4C-vwDw3565y5C.69y@flex--tavip.bounces.google.com>)
 id 1sr0GT-0007I0-AR
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 15:23:02 -0400
Received: by mail-pl1-x64a.google.com with SMTP id
 d9443c01a7336-2058456b864so2747935ad.3
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2024 12:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1726687379; x=1727292179; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=0qhLZDHg7NiQXkA2abdR5Jwv1JYEcxWzvNhuxbCREw4=;
 b=lzJlkn3kyUpaFUTeKVL7PMy82fs5jPdTYX0XT1EDVK+2gWxv4a4bItMBMN9xpXHLC8
 TCkJ8Izp4AEfKT6VUf0727khPsQ3YrYcnhCQbXCLYNaQ2zrzjkuOWIKvE2MtrLiG5tcx
 CBlNq+1wilmYRM6m9YygdmGCBft13vvCgSjqV7ReLoLu2tb+xn7E0PvSHnU9Hj1srZeK
 UNODdMyfjcgUED17gP8G/dHTPPEYgmuHJc6XJKQTSz/gjstD+QXv6H82QzDE9V6EBkok
 Q7R/t+gsgp+b3aNwL2JMbJDBXJUDQrkneenvrqwoeooD00+OUfaTx7r2jHpeHQ+w6yxQ
 s4SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726687379; x=1727292179;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0qhLZDHg7NiQXkA2abdR5Jwv1JYEcxWzvNhuxbCREw4=;
 b=prUF3cYtqIDeNHe3EZv26gq3f7RZL50AGS7rf/2VP0sXnezABIwNn8vFlcs8m7xPL5
 sqIFDxJU9CEpygw3avojxT2+sHK0YcnX/kNL9YNVEWyZ+7ebJdJJHfJeXlUEVaPTtoM+
 mjf6PWboeLcHa36wUsSyW1eqbu1zxLlTwNuBRrQ46s/6up5zv7vtXKXCfCQ5Jbe5h2yv
 bL5W1v5c+9L6s1u/t7BZTPzOzXQJuQ7DOCm0++jGuGjlJu/7pj0dE5MF74BXFgvWYPQM
 c24aEcoUnHZb7E3W/3r0KzA+p5uRSQZjWjMN7YjsfhEfEsB4KJ6DtP7+ntvZtzJCfhpY
 USyg==
X-Gm-Message-State: AOJu0YxpDH031Ylwat5bOVOvRNshqbu1oO8xfvRInQusWfjY+eiL6GNX
 h/3k8KBtIKOHNPYszBKLolWbED4YNh7nEFffNbgxR160clpX9mQ1sdPyamozkigjHME4XDEEFbq
 2e+n3lumuB7adhIVsRUatZYz6j7f7+5Thz/fdIHRTQ4PYjEnRcBJT8iAAALeaBD7HyfcULTcrec
 sdU4jMXXLc7ToVuL4uD4s5Gea0Tw==
X-Google-Smtp-Source: AGHT+IFn74F2I+W5pdjmXSv3xKnh6wy/Ob5mCc0z9361se/ceg12NjtuYInIsgZFd385X9SOmLfUq65Lsg==
X-Received: from warp10.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:750])
 (user=tavip job=sendgmr) by 2002:a17:902:db07:b0:206:adb9:a12f
 with SMTP id
 d9443c01a7336-2076e39d640mr14692255ad.5.1726687377663; Wed, 18 Sep 2024
 12:22:57 -0700 (PDT)
Date: Wed, 18 Sep 2024 12:22:29 -0700
In-Reply-To: <20240918192254.3136903-1-tavip@google.com>
Mime-Version: 1.0
References: <20240918192254.3136903-1-tavip@google.com>
X-Mailer: git-send-email 2.46.0.662.g92d0881bb0-goog
Message-ID: <20240918192254.3136903-2-tavip@google.com>
Subject: [PATCH 01/25] fifo32: add peek function
From: Octavian Purdila <tavip@google.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, stefanst@google.com, pbonzini@redhat.com, 
 peter.maydell@linaro.org, marcandre.lureau@redhat.com, berrange@redhat.com, 
 eduardo@habkost.net, luc@lmichel.fr, damien.hedde@dahe.fr, 
 alistair@alistair23.me, thuth@redhat.com, philmd@linaro.org, jsnow@redhat.com, 
 crosa@redhat.com, lvivier@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::64a;
 envelope-from=3kSjrZgUKCswBsD07y66y3w.u648w4C-vwDw3565y5C.69y@flex--tavip.bounces.google.com;
 helo=mail-pl1-x64a.google.com
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
 include/qemu/fifo32.h | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/include/qemu/fifo32.h b/include/qemu/fifo32.h
index 4e9fd1b5ef..9de1807375 100644
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
+    buf = fifo8_peek_bufptr(&fifo->fifo, 4, &num);
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
2.46.0.662.g92d0881bb0-goog


