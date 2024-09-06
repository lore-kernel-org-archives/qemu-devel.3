Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05BC5CE7B09
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 13:13:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smYlP-0003mE-O8; Fri, 06 Sep 2024 09:12:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1smYlO-0003l3-Dx
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 09:12:34 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1smYlM-0006Wh-V9
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 09:12:34 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a8682bb5e79so276562166b.2
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2024 06:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725628351; x=1726233151; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0Irjp7OCdsQc3Bib9jvUGA7OwDJdphBQq6tqlaHYr+o=;
 b=MY3L1fUy80YXZHUDWmsK8hXO2xQX/xwQyUSvwf56eBZxqYnNpCdlHoxFk3bV9+NdvE
 +Sv6nav+J4EMEi2Y1nS96HFEX2fgWK5yCKxUEcOJxA5YkjpzcTAF9iqODW2Af9d3kaIS
 6iQ+2Y4k7V6b0kVXzcONI6v62Fm7L/bXepz6s2RrjHT8eRSldrM1o3zl51tPvWOn2KMY
 6XJe4purszdK6fj6z03fWVUK7i17BOcNADa/1LqQut5mJeHoIP4y4P0VvFvpovOcawso
 HKneBKxth6Bler5/oEUSC4khAfOiUYGRr2N1WHh8s8yXKfCQrlL/GTcSuBwCKVVoIq3n
 Aycw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725628351; x=1726233151;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0Irjp7OCdsQc3Bib9jvUGA7OwDJdphBQq6tqlaHYr+o=;
 b=rMtrXHw8qg1zfjsvLPLfpqY7Oit53VvEM50f9vxqsgrSF56XNBDcrAX4IoCDhGbCe0
 1N2J8yNlFCBYd9SS1ZOwi+UoYDvnPo0anronMypM5vekR+lUIcsASWQdtMehMSGxAotH
 i+41MaEz00mCKOTZP++rSPwyuQorB8USCgZwuPi7H1iibqFLvr362wedZzJvvIx+8JIg
 zn+KxcxfZleDyBkMkLuGJwzFdNVGKZknJxFkk8p2RmUq4FD+8F2jM+7JDJq4Waoe5nS9
 CGK4ZKEu+tWVmIpTLExjB3KFZlAz2TCq6MMIjgueca0hFu1Rs/g53KpFuCaCZJYVDfHF
 oNBQ==
X-Gm-Message-State: AOJu0YxqWiW1rNDH8jMXRHQXbd6W6v0yXVFJZIriIhzKIhrF49X1CmXs
 PZkebBGKLk0TrJacO81PTlIEZt09oDV5SgwHVmJgu3vTwG9oJyAMMU1vT1I43dk6qHIrfaZE6/6
 l
X-Google-Smtp-Source: AGHT+IHnhtdPxijFzIL+EPvjGh+F4VhLmFYcpdAJkYNuNCnfbSvIYux37zGVsPklyMGXAaYU1waSpQ==
X-Received: by 2002:a17:907:3e88:b0:a77:e48d:bae with SMTP id
 a640c23a62f3a-a8a88667cc2mr224309866b.28.1725628350981; 
 Fri, 06 Sep 2024 06:12:30 -0700 (PDT)
Received: from localhost.localdomain ([80.215.236.92])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8a6236d369sm275343366b.98.2024.09.06.06.12.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 06 Sep 2024 06:12:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Octavian Purdila <tavip@google.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/3] tests/unit: Expand test_fifo8_peek_buf_wrap() coverage
Date: Fri,  6 Sep 2024 15:12:16 +0200
Message-ID: <20240906131217.78159-3-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240906131217.78159-1-philmd@linaro.org>
References: <20240906131217.78159-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62d.google.com
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

Test fifo8_peek_buf() can fill a buffer with wrapped data.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/unit/test-fifo.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tests/unit/test-fifo.c b/tests/unit/test-fifo.c
index 60436a7600..4706bf8708 100644
--- a/tests/unit/test-fifo.c
+++ b/tests/unit/test-fifo.c
@@ -174,6 +174,13 @@ static void test_fifo8_peek_buf_wrap(void)
     g_assert(data_out[0] == 0x5 && data_out[1] == 0x6 &&
              data_out[2] == 0x7 && data_out[3] == 0x8);
 
+    count = fifo8_peek_buf(&fifo, data_out, 8);
+    g_assert(count == 8);
+    g_assert(data_out[0] == 0x5 && data_out[1] == 0x6 &&
+             data_out[2] == 0x7 && data_out[3] == 0x8);
+    g_assert(data_out[4] == 0x9 && data_out[5] == 0xa &&
+             data_out[6] == 0xb && data_out[7] == 0xc);
+
     g_assert(fifo8_num_used(&fifo) == 8);
     fifo8_destroy(&fifo);
 }
-- 
2.45.2


