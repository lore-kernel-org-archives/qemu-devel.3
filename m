Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2BAFCD1284
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2024 10:47:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rurur-0003B3-JZ; Thu, 11 Apr 2024 06:44:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruruq-00039P-5G
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 06:44:24 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rurum-0004Mv-9z
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 06:44:23 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4167fce0a41so4154555e9.0
 for <qemu-devel@nongnu.org>; Thu, 11 Apr 2024 03:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712832259; x=1713437059; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=chFRh2l0gcnmg03fCHQ7SXYogZ+gzE1I40m0bX1o6CE=;
 b=c5j3mEqIll58L5zq6hJWJGZLhH1d7hh/36VU6fYKyFvE7mJflDy8Z6/IxZVkoclLC6
 Us8uwAhhcOIjWRB5wKRchzmwBY9E8yf6W7fULJ3Be0ehRRyuTjBJs7WSjbMAS975K7I1
 PnAl+pFAkjmudj99nUZ3jEWvNGzGwp9ZFJi3xAI1T/6HJIcJkRuntvyUWhmoIvfjTisP
 akSmFEtZuSWCMwto/n3+ztSYikX0U5COHsw7i6pKKvHG7ObedGuMRSDVuA/150ek0E8q
 4YLe8V0pNGJw0WHllYGIl96QB5dm81ulpqa5jVyiGSJeSyrl4gIdQ6bbft69/BKMkLCJ
 wjdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712832259; x=1713437059;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=chFRh2l0gcnmg03fCHQ7SXYogZ+gzE1I40m0bX1o6CE=;
 b=xBwPBnCS8oSlEw6+Go7n6x+vOtgtGDmw2RPeOSYx0NwuJkike8DVwlMi+mqN6MLpTB
 sB0cXvN72kI5VwcnmGeOVlNjKIsWgT5221c/TT2YJzjevnwXFqes7lfY2UpXN1eCD1xH
 rl3FBfOy4NgSrIKioMvpPW2+GK6pbdT3TQvpoKsHqqkG+uK5BcaHTzHE5lp+0jzXKwIN
 93di0f0spfNRc7MzUhvA4H8RmHrcDtweDze6QQQc/0jUzv8cPzgL7ClwUq3o+32m5T22
 66grUyMG6w3km1OallKyM/DjV3jhUSSF5vZxalvSOcNhbCnlUKoAYXotlq54OE8uVGJW
 fVpA==
X-Gm-Message-State: AOJu0YyVM7mzIByMp1duwxkLgcjkqgFI5kNcS+SosBt1QFwP5hVT88Bi
 rchMeJzYn5EX+SOhYRxNsRg8Y9BwDkuJ6TsqtgHuA3vM+ZI04LRB2N9exXJCvJ4ZpaK9UTAL2b0
 7QFY=
X-Google-Smtp-Source: AGHT+IFjECzwDpyVWvUJySuSwoGDnBY202ZAAe8bPly8W7j1uYJbgDuXOU1kDaCF/UNyeX5b3pH3Kw==
X-Received: by 2002:a05:600c:4f53:b0:416:89bc:dec6 with SMTP id
 m19-20020a05600c4f5300b0041689bcdec6mr2004919wmq.11.1712832258773; 
 Thu, 11 Apr 2024 03:44:18 -0700 (PDT)
Received: from localhost.localdomain
 (137.red-88-29-174.dynamicip.rima-tde.net. [88.29.174.137])
 by smtp.gmail.com with ESMTPSA id
 he8-20020a05600c540800b00416a08788a5sm5123079wmb.27.2024.04.11.03.44.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 11 Apr 2024 03:44:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiri Pirko <jiri@resnulli.us>, Jason Wang <jasowang@redhat.com>
Subject: [PATCH 6/9] hw/net/rocker: Replace sprintf() by snprintf()
Date: Thu, 11 Apr 2024 12:43:37 +0200
Message-ID: <20240411104340.6617-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240411104340.6617-1-philmd@linaro.org>
References: <20240411104340.6617-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

sprintf() is deprecated on Darwin since macOS 13.0 / XCode 14.1,
resulting in painful developper experience. Use snprintf() instead.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/net/rocker/rocker.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/hw/net/rocker/rocker.c b/hw/net/rocker/rocker.c
index 7ea8eb6ba5..03ac7a7ae9 100644
--- a/hw/net/rocker/rocker.c
+++ b/hw/net/rocker/rocker.c
@@ -915,40 +915,40 @@ static const char *rocker_reg_name(void *opaque, hwaddr addr)
 
         switch (index) {
         case 0:
-            sprintf(ring_name, "cmd");
+            snprintf(ring_name, sizeof(ring_name), "cmd");
             break;
         case 1:
-            sprintf(ring_name, "event");
+            snprintf(ring_name, sizeof(ring_name), "event");
             break;
         default:
-            sprintf(ring_name, "%s-%d", index % 2 ? "rx" : "tx",
-                    (index - 2) / 2);
+            snprintf(ring_name, sizeof(ring_name), "%s-%d",
+                     index % 2 ? "rx" : "tx", (index - 2) / 2);
         }
 
         switch (offset) {
         case ROCKER_DMA_DESC_ADDR_OFFSET:
-            sprintf(buf, "Ring[%s] ADDR", ring_name);
+            snprintf(buf, sizeofbuf), "Ring[%s] ADDR", ring_name);
             return buf;
         case ROCKER_DMA_DESC_ADDR_OFFSET+4:
-            sprintf(buf, "Ring[%s] ADDR+4", ring_name);
+            snprintf(buf, sizeofbuf), "Ring[%s] ADDR+4", ring_name);
             return buf;
         case ROCKER_DMA_DESC_SIZE_OFFSET:
-            sprintf(buf, "Ring[%s] SIZE", ring_name);
+            snprintf(buf, sizeofbuf), "Ring[%s] SIZE", ring_name);
             return buf;
         case ROCKER_DMA_DESC_HEAD_OFFSET:
-            sprintf(buf, "Ring[%s] HEAD", ring_name);
+            snprintf(buf, sizeofbuf), "Ring[%s] HEAD", ring_name);
             return buf;
         case ROCKER_DMA_DESC_TAIL_OFFSET:
-            sprintf(buf, "Ring[%s] TAIL", ring_name);
+            snprintf(buf, sizeofbuf), "Ring[%s] TAIL", ring_name);
             return buf;
         case ROCKER_DMA_DESC_CTRL_OFFSET:
-            sprintf(buf, "Ring[%s] CTRL", ring_name);
+            snprintf(buf, sizeofbuf), "Ring[%s] CTRL", ring_name);
             return buf;
         case ROCKER_DMA_DESC_CREDITS_OFFSET:
-            sprintf(buf, "Ring[%s] CREDITS", ring_name);
+            snprintf(buf, sizeofbuf), "Ring[%s] CREDITS", ring_name);
             return buf;
         default:
-            sprintf(buf, "Ring[%s] ???", ring_name);
+            snprintf(buf, sizeofbuf), "Ring[%s] ???", ring_name);
             return buf;
         }
     } else {
-- 
2.41.0


