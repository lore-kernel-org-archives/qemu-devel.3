Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A81A9C2BD09
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 15:28:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRClF-0003v0-FN; Tue, 09 Jul 2024 11:28:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sRCl8-0003JQ-6N
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 11:28:02 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sRCkx-0006XV-8C
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 11:28:01 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4266edee10cso9947745e9.2
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2024 08:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720538869; x=1721143669; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QXjiHIW2zvTWYZ1fQhAbimXm28ql9EP4J/4/P4b4vws=;
 b=PMjZA2Dy+2ZvgemVNuVYKhGtn2g/XF6fSWTWUY3IbuCvYNFhZdzzHqM/ilkLTX/hA8
 FFQMrhQACG9CTxb0S2orNKqd/AUypt/j46OdPESQWlE36wsksa1tuG1Blt9iV7KCuvks
 Zf2LGGznEpmtVf/hevKaQnbqUDrwUBO2BxWml8cDTY9+thRNUs8wylTs1GKH55PkfOcY
 dKVqMO5nOKnHoDpfsG94A3vtpyOUaNazXIrpgMm/wII2HSohuacUfn9iD25I7p7CzY3J
 uwPBkzpfhCPM1zQQwiKkpSdtTJqENQy4Um3g6a7xAgjsuZjOrNvUiW+2/9RfmxRtayrs
 kMwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720538869; x=1721143669;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QXjiHIW2zvTWYZ1fQhAbimXm28ql9EP4J/4/P4b4vws=;
 b=rSzhkp2AaBaLXfTlEMGlSvRU8YoFYbHFQUAEM/EP2sDVzBD5JHmeNFWKzVe2qQK2Fk
 YWhYU5ICVpB76VwESF5dZLHIuUTf3ckR3ZUJT7sHwbiCFS4VWAdwIo12BpHgiUD44HBd
 vvdajdQJCEXnToB/T4thPGMtU/LFtQ9PpFUCqKcbCg0GTSoGqmgXUSx1F2JiWZAub3uh
 0wUln2J2PpthxN/5c+xu6u+Mw1PoPjVc0XIgC1nbs9KefzKmaPec9uXLJvvWaCG3Hnaw
 hPY3/7lHh//Sdcegh/h8lak7daAS8QcPS5Qa4QhS8uCRF7VB5YOwKkCKvE3lNdb6uxPY
 /Bfw==
X-Gm-Message-State: AOJu0YzaEQGqnNCpPmZkv+i/cVph6OZqjguwRCuxqXZ/BUbYpwzfoBk0
 EzW8pE42wiPpkh07uKTF11WoOV5WGZm3oBqOvyfOW0PNJKvN0tk7UG7ZBgo8x/JLKC8hNMaNKr3
 1
X-Google-Smtp-Source: AGHT+IESpBErcXG6CmgSl5mrCIhPxJp8qzlIiSqngK3cjSobWlNjmMykKo/4JJ0CUn82C/TASH9UKA==
X-Received: by 2002:a05:600c:1592:b0:426:647b:1bfa with SMTP id
 5b1f17b1804b1-426707cd9e2mr21459385e9.8.1720538869497; 
 Tue, 09 Jul 2024 08:27:49 -0700 (PDT)
Received: from m1x-phil.lan (vau06-h02-176-184-43-20.dsl.sta.abo.bbox.fr.
 [176.184.43.20]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4265f84cd44sm138532405e9.18.2024.07.09.08.27.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 09 Jul 2024 08:27:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, qemu-block@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Bin Meng <bmeng.cn@gmail.com>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>
Subject: [Aspeed PATCH v47 18/19] hw/sd/sdcard: Add boot config support
Date: Tue,  9 Jul 2024 17:25:55 +0200
Message-ID: <20240709152556.52896-19-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240709152556.52896-1-philmd@linaro.org>
References: <20240709152556.52896-1-philmd@linaro.org>
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

From: Joel Stanley <joel@jms.id.au>

With this correctly set we can use the enable bit to detect if
partition support is enabled.

Signed-off-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
Also squash?
---
 hw/sd/sd.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 291497468f..6aa83251f7 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1047,6 +1047,12 @@ static uint32_t emmc_bootpart_offset(SDState *sd)
 {
     unsigned int access = sd->ext_csd[EXT_CSD_PART_CONFIG]
                           & EXT_CSD_PART_CONFIG_ACC_MASK;
+    unsigned int enable = sd->ext_csd[EXT_CSD_PART_CONFIG]
+                          & EXT_CSD_PART_CONFIG_EN_MASK;
+
+    if (!enable) {
+        return 0;
+    }
 
     switch (access) {
     case EXT_CSD_PART_CONFIG_ACC_DEFAULT:
-- 
2.41.0


