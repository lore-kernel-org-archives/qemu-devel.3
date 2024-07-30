Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3F76C3DA61
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 09:22:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYj3T-0000Nc-Nd; Tue, 30 Jul 2024 05:22:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sYj3R-0000JC-Vl
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 05:22:01 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sYj3Q-0005kM-EE
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 05:22:01 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-426526d30aaso25457445e9.0
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 02:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722331319; x=1722936119; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fRMGyzp03tYfu+a5mNwyhx3DbvljVjB1l6w81zoWVuY=;
 b=rkLnIo6CLqCFwYqG4JoU6NzcdRAnwSFtqmaTKenoNtyXDWXESUm9902YiuvfbXMU81
 4SO36jzn6O1bjy6pq72/Vb/4ENLAaQtGyeZLay/5ygNyNhB0WYgtrE3jYtGirN0ECmiN
 9wuCW3l7JNRTwc7aAkKnfWgswGyXyrwMtgAaJcc5U/aojI9x/ZMdczsec74xyNBej42w
 h1dHZDYqBWq8wg+zhaEgY7wN1zBXItEEuFDuANUMcdKH0PsKBB3E8FNBWctRPIf533EG
 WoZjUqK0MHwsHm8DWMrh8h3Zs1NziZkGehl34qbA3pfHe5VM9GXffPZu0s01cdSS4wZt
 stEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722331319; x=1722936119;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fRMGyzp03tYfu+a5mNwyhx3DbvljVjB1l6w81zoWVuY=;
 b=YKRVRC7mhGC4d8ZL9xcBU1nMGk1XIcxIGZ+Pk9XyOCEthftCEDLS6B96CIdgHqbhuV
 pids+Qzw5ZV01FuABRwk2uQ1RFRwMb46Ol0bf6WtXKdCfYG2MdcumrOupIqZdpU4HqyP
 67N4lIdqxej0y+SM2Mdid1SwWPDg8OjkzvZX/VQOzumUPb6bavDgJbtx6a49AfRV3x8O
 ydUySDrABrJA/KKNX3UyekdpD7AUzxdVAsxb3zPvMqy2EFZPPo22iSo2kwwIu5cn2574
 VwYduthCFh5FcFbJN7cpy6mO3v2DoOAqCZk/YhdF9DfRVuIjVKnZhXprhSaxSGAvFSY8
 Gv0Q==
X-Gm-Message-State: AOJu0Yyekd+jGj5QF5bZ0OCiwImm5TuWELploABCw1vGmY2pT1Ycy4qj
 pnJ1KztIORK3q17s3Gr6NiKLkM7uip0pUNA708BFNhH2r1Ew8n7VtlPZf/BKSndaJktRcnVbG4B
 uv68=
X-Google-Smtp-Source: AGHT+IEehUY4cPJwEgOJWU5SYmjAo9/YXvfZchEzo4pXMNvpRXEQsZq1r6gd4nidsmcwk7dg9uZYDg==
X-Received: by 2002:a05:600c:6b06:b0:426:6f1e:ce93 with SMTP id
 5b1f17b1804b1-42811dfe3d0mr69752425e9.33.1722331318878; 
 Tue, 30 Jul 2024 02:21:58 -0700 (PDT)
Received: from localhost.localdomain (82.red-88-28-10.dynamicip.rima-tde.net.
 [88.28.10.82]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-428089c28f0sm192352015e9.28.2024.07.30.02.21.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Jul 2024 02:21:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bin Meng <bmeng.cn@gmail.com>, Zheyu Ma <zheyuma97@gmail.com>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-stable@nongnu.org
Subject: [PATCH-for-9.1 2/5] hw/sd/sdcard: Do not abort when reading DAT lines
 on invalid cmd state
Date: Tue, 30 Jul 2024 11:21:35 +0200
Message-ID: <20240730092138.32443-3-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730092138.32443-1-philmd@linaro.org>
References: <20240730092138.32443-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

Guest should not try to read the DAT lines from invalid
command state. If it still insists to do so, return a
dummy value.

Cc: qemu-stable@nongnu.org
Fixes: e2dec2eab0 ("hw/sd/sdcard: Remove default case in read/write on DAT lines")
Reported-by: Zheyu Ma <zheyuma97@gmail.com>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2454
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index c02f04f1ea..b1e6e36b44 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -2540,7 +2540,9 @@ uint8_t sd_read_byte(SDState *sd)
         break;
 
     default:
-        g_assert_not_reached();
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: DAT read illegal for command %s\n",
+                                       __func__, sd->last_cmd_name);
+        return dummy_byte;
     }
 
     return ret;
-- 
2.45.2


