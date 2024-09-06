Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59251E6FE2D
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 15:50:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smbDK-0000GR-P9; Fri, 06 Sep 2024 11:49:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1smbDJ-00009G-76
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 11:49:33 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1smbDH-0008BC-JK
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 11:49:32 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5c3ca32971cso2634435a12.0
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2024 08:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725637770; x=1726242570; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=358hg9o1rKr1N4ec0h1JIGJ3AxYmlGZHvU3jCe1X9nY=;
 b=UkEufFv74236FXXzMCR//rNtUxs2Nt+ySOiJdqaKqZ10cA7QaPqul+FntJNh8+bBOF
 Zoo3fB3cdWsKdDUcZO8xCWIH0LLMTkf9e9eN4nptquMCnkUrQWhnVWpICTkTJRtfR5Wh
 rCDp9nOOnvM1WcF4mr8FGsdpnFW/HUtD6JCob22tGUtkyGmg/YmDeEQ0Cx87NZNJ9jMM
 lno8snPXaBDTfq85azzkIgL87jXuChoPgDtkfj24V991kvcFG2S3AK0g+efaQwgBTzxM
 wWUOdDUhpQ84Okz/VhyOb4hrw4g5UPLZikdJnReNL2LBPtVLYHTyEMUwbf6phWLkH8+h
 ++Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725637770; x=1726242570;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=358hg9o1rKr1N4ec0h1JIGJ3AxYmlGZHvU3jCe1X9nY=;
 b=X8LVHr4UFSXmA0rJ0ahAK86fCPegdujQ6aYl7mPoUK/cMJQn6kGaqVeX7lrHfI1Mqr
 3qnwNLLhXYf8l2UuBNepJdmqgNXWicwlStXXU+e5AGwMbw4ukaaXoP2S3FpooIh73EPR
 nn+2S6UAkiHoJ4GUDpNwrDeOFSnhSzoX3dR9333cRrptwHuL5ITZ2MoFR4lzm1bc/XUX
 KVKZKpO3Pl550R07RVXBTxVvI5lmugzARfjJfXV2Yk2whnY5MUrZj5mAyR+VCYXVax98
 q/VVB7RsmInDGqL3ALCk31FoPx+j9hyvjSqUw9TMnXgxaik8gO/whl0EDTYpc7kKDtRa
 ip9g==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6TutpES4HhgTGk6IzNvLDMcUkdCmisLTv2kTOov0mZfTNXLdzX/hA221v6HGizYrCN2kZ8oDOcfY5@nongnu.org
X-Gm-Message-State: AOJu0YxBJxkiIp8CsrW8jD4CCmn12TuCPkj3Q8S7z3NdxDTF2BqFitN4
 NKC56CEZxnQi61VruH3UeBVifxpWcDb3VWbKBB6knn3cwvMo6tilZekm1cVpGlY=
X-Google-Smtp-Source: AGHT+IGo2FKxBgmkLi2SWYKzCibP3pG0nVLsEI9aenBA3pDpkk47O+7fCDUVAPU9w9kx9XqdN/iSdA==
X-Received: by 2002:a17:907:5cb:b0:a86:a73e:7ec9 with SMTP id
 a640c23a62f3a-a8a88843cd4mr262830666b.46.1725637770115; 
 Fri, 06 Sep 2024 08:49:30 -0700 (PDT)
Received: from localhost.localdomain (225.13.23.93.rev.sfr.net. [93.23.13.225])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8a61fba616sm291846566b.40.2024.09.06.08.49.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 06 Sep 2024 08:49:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Guenter Roeck <linux@roeck-us.net>,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v2 3/5] hw/sensor/tmp105: Pass 'oneshot' argument to
 tmp105_alarm_update()
Date: Fri,  6 Sep 2024 17:49:09 +0200
Message-ID: <20240906154911.86803-4-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240906154911.86803-1-philmd@linaro.org>
References: <20240906154911.86803-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The next commit will clear the ONE_SHOT bit in the WRITE
path (to keep the READ path trivial). As a preliminary step,
pass the 'oneshot' value as argument to tmp105_alarm_update().
No logical change intended.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sensor/tmp105.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/sensor/tmp105.c b/hw/sensor/tmp105.c
index 150d09b278..6740200aea 100644
--- a/hw/sensor/tmp105.c
+++ b/hw/sensor/tmp105.c
@@ -40,10 +40,10 @@ static void tmp105_interrupt_update(TMP105State *s)
     qemu_set_irq(s->pin, s->alarm ^ FIELD_EX8(~s->config, CONFIG, POLARITY));
 }
 
-static void tmp105_alarm_update(TMP105State *s)
+static void tmp105_alarm_update(TMP105State *s, bool one_shot)
 {
     if (FIELD_EX8(s->config, CONFIG, SHUTDOWN_MODE)) {
-        if (FIELD_EX8(s->config, CONFIG, ONE_SHOT)) {
+        if (one_shot) {
             s->config = FIELD_DP8(s->config, CONFIG, ONE_SHOT, 0);
         } else {
             return;
@@ -119,7 +119,7 @@ static void tmp105_set_temperature(Object *obj, Visitor *v, const char *name,
 
     s->temperature = (int16_t) (temp * 256 / 1000);
 
-    tmp105_alarm_update(s);
+    tmp105_alarm_update(s, false);
 }
 
 static const int tmp105_faultq[4] = { 1, 2, 4, 6 };
@@ -168,7 +168,7 @@ static void tmp105_write(TMP105State *s)
         }
         s->config = s->buf[0];
         s->faults = tmp105_faultq[FIELD_EX8(s->config, CONFIG, FAULT_QUEUE)];
-        tmp105_alarm_update(s);
+        tmp105_alarm_update(s, FIELD_EX8(s->buf[0], CONFIG, ONE_SHOT));
         break;
 
     case TMP105_REG_T_LOW:
@@ -177,7 +177,7 @@ static void tmp105_write(TMP105State *s)
             s->limit[s->pointer & 1] = (int16_t)
                     ((((uint16_t) s->buf[0]) << 8) | s->buf[1]);
         }
-        tmp105_alarm_update(s);
+        tmp105_alarm_update(s, false);
         break;
     }
 }
-- 
2.45.2


