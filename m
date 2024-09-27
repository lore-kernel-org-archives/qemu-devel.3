Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66311CF6483
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2024 21:52:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1suIrx-0001h6-3j; Fri, 27 Sep 2024 17:51:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1suIrq-0001CH-Ur
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 17:51:15 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1suIrp-0004XQ-Jj
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 17:51:14 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-5398996acbeso1320321e87.1
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2024 14:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727473871; x=1728078671; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e1vHxexCTLbdRB8r0KvJgoIHaBve1hvZ62MNg9aoNm0=;
 b=oBMIBkWw4/mAGSdEwQB+XCf5Ee2YWdXHuQ7fHkruq7pyb7qBrudcCXSdoCwEOGBC0g
 HA+t1waJj8/pRKEdP/mSSz38+dK+Pt19z4XBFpNERQdiZRGohl+zvYb92QWY+Xb6QReQ
 p3+fGQ5QhSn+99vQHULFdCxxvF4vBeG6HzdjR8DT3d8X2kAyAhAJ26jdH3FYCr+CnIVB
 rsaNMQTjogCULAVUtRr7KGh5oCa+5Feq7EshjVwRTwpXz5D2giDwyRDBkIMt2CoAgkum
 Wnygvd9diFfpiJCPJkHalxOs+X+drIeDw15+D4wkIUMlz+pFomtgCJ3WtS49XNslcEBt
 ae3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727473871; x=1728078671;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e1vHxexCTLbdRB8r0KvJgoIHaBve1hvZ62MNg9aoNm0=;
 b=ZikVl3BM6qkedCCcz/yf3AMYhjuEhzgwaGVgS+Ya0OUm4FyIi3PxD5vwLkRlvaZ7uu
 eaTYkgoMjDkoIYYNszNcuPpTaexGfFzztJYQkINyk9zc6azT5dsK3oFsEdhXQ5/0OFZ8
 Z5LLMOPXaOoeTYZorAPy5lQ/eftlTo5Gh0gFeoGf27PL9BrjRW61rqzwMeivSxJ1FAf1
 tnENnNfzE6mROwxl/dT4cMSquENWHP1Riip9vR55YTZ/uD6bJr6jJy7GtA+paQy1eNuf
 r1rWPHYHfl732bFQVosiidZ+dOlvEM3+h/bRzV0H2VXiAWWaTvnyCNV4+BzMvAzBqPMv
 MLVQ==
X-Gm-Message-State: AOJu0Yy4M2Jv0JJtTEPUDKItMexrZvGrxx3Ut1ihZwRwjE6nWId139EK
 /mPbWWArwH+o65vJa5TKcIfS2U3bP+1x7QiARkg8fJYkmVjZXRBr08X6p+McYB1J0x36XQlEy/8
 l
X-Google-Smtp-Source: AGHT+IGyY1J87woCfyiNgDUY1qadKJHfnYaK5GEM/3dq/7Kt8EFtEtDdrqQle5uUrzCN1adCphqn9w==
X-Received: by 2002:a05:6512:1384:b0:533:4327:b4cc with SMTP id
 2adb3069b0e04-5389fc810ecmr3283260e87.52.1727473871210; 
 Fri, 27 Sep 2024 14:51:11 -0700 (PDT)
Received: from localhost.localdomain ([176.187.217.136])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e90cd8c5asm111112965e9.1.2024.09.27.14.51.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 27 Sep 2024 14:51:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 4/4] net/l2tpv3: Simplify LD/ST API uses
Date: Fri, 27 Sep 2024 23:50:40 +0200
Message-ID: <20240927215040.20552-5-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240927215040.20552-1-philmd@linaro.org>
References: <20240927215040.20552-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x129.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Directly call ldn_be_p once instead of ldl_be_p / ldq_be_p.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 net/l2tpv3.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/net/l2tpv3.c b/net/l2tpv3.c
index b5547cb917..7a0d5dcfe9 100644
--- a/net/l2tpv3.c
+++ b/net/l2tpv3.c
@@ -318,11 +318,7 @@ static int l2tpv3_verify_header(NetL2TPV3State *s, uint8_t *buf)
     */
 
     if (s->cookie) {
-        if (s->cookie_is_64) {
-            cookie = ldq_be_p(buf + s->cookie_offset);
-        } else {
-            cookie = ldl_be_p(buf + s->cookie_offset) & 0xffffffffULL;
-        }
+        cookie = ldn_be_p(buf + s->cookie_offset, s->cookie_is_64 ? 8 : 4);
         if (cookie != s->rx_cookie) {
             if (!s->header_mismatch) {
                 error_report("unknown cookie id");
-- 
2.45.2


