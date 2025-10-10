Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B301CCD187
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 07:08:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v77ES-0001wY-0M; Fri, 10 Oct 2025 03:08:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v77EP-0001sE-H2
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 03:08:01 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v77EN-00080H-GX
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 03:08:01 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-42557c5cedcso1020301f8f.0
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 00:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760080076; x=1760684876; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R/S+AbO3mfIrfPCoYS8ALK2aseZFhvV+JaaLQc6aYmk=;
 b=F0nJQlIPljDbHhPxCggDPi8+A/p/3c8QVg1vLulHOq1kfvEiwTi+4Runfdk3X2d+uj
 LfkEVyRqF83qSjLjmCnX3YI/o4OdhFiE3YSmQSHSdTAqL+6HF3vIh5kqzJOKcRcjzrMa
 flfdaNyML3Rn7qSmMg5us8QGt7MV7uxlbMy18AAXDrhjZnVj/ytUb28MTNLbeOUh2kNg
 OyAUVYn3vcn3ZRz6/cmIB4Nt/7sD9z5RpWVc2bz8I54DgkBvtKsK7DQo0rFk2n+P2dDH
 cT7R4RsiWTScIbHHv3inzAsi5YHfIFz6hpWIZNwQrohprapQ0+VkLTTweGu+DdCs4Z7x
 oHKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760080076; x=1760684876;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R/S+AbO3mfIrfPCoYS8ALK2aseZFhvV+JaaLQc6aYmk=;
 b=AU9J71dKEDimSHY+uRJFHAQ88I5APTKqmmtRsLjIddx+Y+eEOAbWyKD6aHuLrkomJk
 f/D6SQI30q/zcKoErnlEsVdaw7V1rguZVj3jUTNQCE8IqYJ2MzQvxJzXbxtjVWkwVdkk
 VXm+zbBk8Awv59pNRV8HDw4XsvfwUU1Q+PKxa7l8xNu+ckDXYh6ZhQl+v0m73QoO8171
 51m5qqE15qgaPzqTnvFn05igK9t3RFjmTHGoe6G1XZ0pho20SPg5hfNZhddS2Hd0dOHZ
 wH91LZh1825uU885TqvRNc84Xkcaq+5FEtckKK56yd+nvaavlgwT+416Qp498gwvJgfG
 hQww==
X-Gm-Message-State: AOJu0YzuMXI3XVDNnOTMLnmT6e84poWkI8qAuy7vNy1hV9Hn354Z+Zqg
 WsU7i8Unh/40UMeZqKpLaWvd4/B0KjU6SkbRMXZ8+yrxwuRwZhns01FX1o0U9TZpk0roq44NfQE
 eYFRQFv4gcg==
X-Gm-Gg: ASbGncue8StGZCW05u1SPqio0Bx1g46d5Wf2VnsEMUMFVTpiDk3nGoz3/rULIQSlCph
 pOccU4sqUGE2dtDEUD9vwAlEdMAWtPmE5ol+VXWaX4b7HMn1RQWPIgLYkBvrO6ke82SZ1xB95lk
 lgWn4A1kw0Z+Meji1FY8V2ikXJtw5xlS6kx9O/ipJi+Wq3qGy7qEFNjT4WRammne7Z6ItPuCZBZ
 UcnolLR8Nj5JEzr4hB3h7h+ZIXeVQ5YFFJLb9BQqfQGP0OKfonTErzWhs9u8VFgZ1K17LAeiXKj
 9eNO8A2cna/1WvpQ5uIqEW54wy71hAdJ+2g4id537FNvhgOv/kORfSElkx2n0WQnXYY4UGnJORs
 msp0PqS0Lbn60pQk9VplZnZPCFpGUcr7V5lUrsS8kRYVogCb/qKb4433yneqsbpWMSHlyTeSlH+
 krZdOpzREMsqePIGtnlf6uiUWl
X-Google-Smtp-Source: AGHT+IFOdlv+y4H6NqzekUUY53ss87F4JWprk/Z9hxYayAo/wunItkuSlnJlxM5JZRW51pxbluYlRw==
X-Received: by 2002:a5d:64e7:0:b0:425:769d:4426 with SMTP id
 ffacd0b85a97d-4266e7dfff1mr6111004f8f.34.1760080076250; 
 Fri, 10 Oct 2025 00:07:56 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce5e81d2sm2685882f8f.49.2025.10.10.00.07.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 10 Oct 2025 00:07:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Stafford Horne <shorne@gmail.com>, Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 11/13] target/openrisc: Replace MO_TE -> MO_BE
Date: Fri, 10 Oct 2025 09:06:59 +0200
Message-ID: <20251010070702.51484-12-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010070702.51484-1-philmd@linaro.org>
References: <20251010070702.51484-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

We only build the OpenRISC targets using big endianness order:

  $ git grep TARGET_BIG_ENDIAN configs/targets/or1k-*
  configs/targets/or1k-linux-user.mak:2:TARGET_BIG_ENDIAN=y
  configs/targets/or1k-softmmu.mak:2:TARGET_BIG_ENDIAN=y

Therefore the MO_TE definition always expands to MO_BE. Use the
latter to simplify.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/openrisc/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index 6879a0cff80..a626ffaf25b 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -61,7 +61,7 @@ typedef struct DisasContext {
 
 static inline MemOp mo_endian(DisasContext *dc)
 {
-    return MO_TE;
+    return MO_BE;
 }
 
 static inline bool is_user(DisasContext *dc)
-- 
2.51.0


