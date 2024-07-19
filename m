Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88781C3DA59
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 15:17:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUpLj-00075P-1C; Fri, 19 Jul 2024 11:16:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUpLi-00074V-7L
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 11:16:46 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUpLg-0005w7-Kz
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 11:16:45 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-427b9dcbb09so14283095e9.3
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2024 08:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721402202; x=1722007002; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QSgsrmLsVPPMIVwIX59F0oVAQKgoQ9K5XRt0PeEYee4=;
 b=l0ssbj8vvnyciIesIPlHkY9CpyBsvRCIoaE319riiFAnRm9Xc2yAV2jJ6cvgpS7tZR
 4LtzIU9YU0Vi1w4c1dh4ONvh+TYtZJqJ9Dedzog2N+qfdFlV4Kyxj4OVMjEpi40Rzcsp
 eJjl/c3ioDWxdjIxdw33CDJWOWw/5dxU1RobNKaERzWNzhtA/h3Fw5hHFPfBs/ZG4y+L
 OBTeVJtpVswZdZlljTbd7KjZEEI2JxH/2vClE4HQRjXEZlEJoD9cp3WsBfrgykR+3E/S
 Y1nthYqZ6Jny0r7kCoCADNszBVDQY4APlGTUyIpqQjtYMXfwTn4taPd9/sdaTKoc0+wR
 UVkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721402202; x=1722007002;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QSgsrmLsVPPMIVwIX59F0oVAQKgoQ9K5XRt0PeEYee4=;
 b=TQ9gB9HDjXzcdLvohKQb3Hfv7WuJinKaEdPp1FqgghgHvtYCd/lrP9WsqeMQVj3w1+
 0ADxwk0JRxAVnb+ksNWG27jcXxtuIcowcqbJSlctZo6bu4bWgqO36HyW3q6b0oN3uMjA
 5o94uoU7yGeYyTL+NoNy82YxVVEW1nCoO2sCF4UomQ7oKBvGMmYoSRR4TGD81tId0sW2
 XV6+b9yEBcBGLox7RqhK/eL8uy8JI4bpEXqfjomItTdNSBIWEguqBf33XlicC8yF4GCp
 9XigrWaU4h07epnsu8RWlgbv++6XN5Ux7EoNV4FHlF/cqbqWReDKvnqwZP1rO3im7URv
 NHTQ==
X-Gm-Message-State: AOJu0Yyun+rTL5lujaYDYQlOAxeAGx+yDR0mDKta8mMZPvx4Vw2cVq8M
 4ztKk05HkQSs1vQojIQdQtTFRNF0X7C7TpB1y+BPY4jBMM6F0MdSCVU8Th2iqw2najGipFYkVH1
 v
X-Google-Smtp-Source: AGHT+IEdXabXTqPPQAKUbkQhTbG94qkkfX00hoPxxrb5o2Tx0tK4Qua5fKXdpZq3YRQR5ObIR6Haiw==
X-Received: by 2002:a05:600c:4f8a:b0:424:a2be:c161 with SMTP id
 5b1f17b1804b1-427c2cd0996mr53064555e9.20.1721402202305; 
 Fri, 19 Jul 2024 08:16:42 -0700 (PDT)
Received: from localhost.localdomain ([176.187.209.227])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d69019a5sm28001065e9.18.2024.07.19.08.16.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 19 Jul 2024 08:16:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/3] util/fifo8: Use fifo8_reset() in fifo8_create()
Date: Fri, 19 Jul 2024 17:16:27 +0200
Message-ID: <20240719151628.46253-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240719151628.46253-1-philmd@linaro.org>
References: <20240719151628.46253-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

Avoid open-coding fifo8_reset() in fifo8_create().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 util/fifo8.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/util/fifo8.c b/util/fifo8.c
index 4e01b532d9..2925fe5611 100644
--- a/util/fifo8.c
+++ b/util/fifo8.c
@@ -16,12 +16,17 @@
 #include "migration/vmstate.h"
 #include "qemu/fifo8.h"
 
+void fifo8_reset(Fifo8 *fifo)
+{
+    fifo->num = 0;
+    fifo->head = 0;
+}
+
 void fifo8_create(Fifo8 *fifo, uint32_t capacity)
 {
     fifo->data = g_new(uint8_t, capacity);
     fifo->capacity = capacity;
-    fifo->head = 0;
-    fifo->num = 0;
+    fifo8_reset(fifo);
 }
 
 void fifo8_destroy(Fifo8 *fifo)
@@ -97,12 +102,6 @@ const uint8_t *fifo8_pop_buf(Fifo8 *fifo, uint32_t max, uint32_t *numptr)
     return fifo8_peekpop_buf(fifo, max, numptr, true);
 }
 
-void fifo8_reset(Fifo8 *fifo)
-{
-    fifo->num = 0;
-    fifo->head = 0;
-}
-
 bool fifo8_is_empty(Fifo8 *fifo)
 {
     return (fifo->num == 0);
-- 
2.41.0


