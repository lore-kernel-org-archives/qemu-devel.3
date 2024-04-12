Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 101CFC4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 07:35:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvBQS-00078V-MV; Fri, 12 Apr 2024 03:34:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rvBQK-00075e-Qr
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 03:34:13 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rvBQH-0007DE-A7
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 03:34:12 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1e2c725e234so12523275ad.1
 for <qemu-devel@nongnu.org>; Fri, 12 Apr 2024 00:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712907247; x=1713512047; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wEe+ZpGNanZOUW1LiPHIpYdRRTuUQOyTjtk3qA26K5Y=;
 b=ju+CyyB8H/xP0uZt1P/D835pJdNc16qzsApQ9QFWceiOsBgAfjxqUgI8qCK1N5/TC+
 idjaYceaQXRjQ1Stf3QLaHhK4OjXmdbwE8Jx+xm3mFhnZvOB8VklnGAplSGiTqR55wON
 9MWVwH7qCf0Y+q2HqeEaTk6sHrmneLuiLbxkfTdvXcZJvk/HyXpgrYcGt9owRWgnSzE7
 kBrHdECCAcQwvJhYkrqvP7zfF9U3FAJElwQhwQS53Ct8FhDbj8Muk5/aWtfSuWO7Zuf9
 vB2LsFL3KWv17dtAZOMo3MF1SN2jJDDHoAzr2iO+xZ9bI7YOJYIFtKAgTnxC6JKXFAO9
 qm7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712907247; x=1713512047;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wEe+ZpGNanZOUW1LiPHIpYdRRTuUQOyTjtk3qA26K5Y=;
 b=RihPQAYOAdCIYXPkHdgJpkr/2x5XTaIH5NOzJiEmw0431EkW9qq/SJkQDIJIX5rXAA
 +yi+llV3lfL8nRnQ7Xndss3afYvlaPpWglXX19Df888iUcmV/Fk1+cSKiWWSbE7SASsB
 kox0NQC6sxrdEaOlcZZhGht4KNbKj20A4b2e5GyDXJfsuSpo0v5mX+g7tXlkqfKQjb2G
 8BHk4QJE/XoJIPF5yMeAet9Mma7fY9Qbl0zOQpBrb5ZtZqTfrusgtHEQyFRgEdaLxwKw
 7NLLrCU/+H2NSLzkdyvYvmPNyQZEIJPsWYdJDsuYlHtt0CCsJNF/tyaXN0+/x/drzPTx
 h2/Q==
X-Gm-Message-State: AOJu0YxQunpUGjeAlRJQwtaZ1uXONBJVxQLlGN6SUrU2PBGFz0mXjNkW
 +UtN0bvDbxq/+c/74SOYpYloQ5BKaSYKB9p4URGYmB9GvvgqN0SugjDYUWMlYLe7kaOhcH5zTbs
 u
X-Google-Smtp-Source: AGHT+IHuhVGrq5n4NjaSxaRQ/0l1Q0QggKAXcrQ88ciRNKUE+1o+eK1PiluK8d47FhBNrnOPAmQ28w==
X-Received: by 2002:a17:902:e542:b0:1e4:320b:4311 with SMTP id
 n2-20020a170902e54200b001e4320b4311mr6221348plf.34.1712907246671; 
 Fri, 12 Apr 2024 00:34:06 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 e5-20020a17090301c500b001e556734814sm2206099plh.134.2024.04.12.00.34.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Apr 2024 00:34:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 24/27] hw/net/rocker: Replace sprintf() by snprintf()
Date: Fri, 12 Apr 2024 00:33:43 -0700
Message-Id: <20240412073346.458116-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240412073346.458116-1-richard.henderson@linaro.org>
References: <20240412073346.458116-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

sprintf() is deprecated on Darwin since macOS 13.0 / XCode 14.1,
resulting in painful developper experience. Use snprintf() instead.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20240411104340.6617-7-philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
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
2.34.1


