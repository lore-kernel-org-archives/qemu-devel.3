Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30F2EC87FD1
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Aug 2025 17:34:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujLWX-000064-Gz; Tue, 05 Aug 2025 13:32:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ujLWK-0008Um-L2
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 13:32:19 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ujLWH-0004wP-Gs
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 13:32:14 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3b792b0b829so4696943f8f.3
 for <qemu-devel@nongnu.org>; Tue, 05 Aug 2025 10:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754415132; x=1755019932; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g6OcEb2hks/LIEU5YwLKgeeiCUmhrk73fC2rYXd9M/I=;
 b=PNqKsLmaCC1mcHIrc5tO4eVt6CL1aaoFyPfhjvcy8xBPt+4utu9ENmSWCHfL5yH8GH
 UcZyT/i8FHOi+mYpS3T48Vr3oBlc+eE9mFPfPzYbzpT+c2UALXRyT3PorOOTpCImKozs
 51zWYIpHKAz/8+E7rGkbYg6A5MGPwCu16bpbpsKvEWW42J4h2Zxxl3lXxDUcXjT09I+o
 SGSRxwu+eNjeRjepR8aVAlatQXc4wSzMvAYYQ2G7oq2QHCZdVUMzM93DIkFG3S//V2o1
 4UkTK+zQy0JN62/p+dFktE50rettuh2oXLUonmc0aSErqOk5p3bsgoUqMkzF6EDw9mQm
 jOKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754415132; x=1755019932;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g6OcEb2hks/LIEU5YwLKgeeiCUmhrk73fC2rYXd9M/I=;
 b=PuYfdHcvvcjW0g7AeJ8mlNVv5XJdEMftXS0QqJuPSxqT1pdGM4yDwgTE4/2Xv/ROYo
 u5J7J6HpNkc9tUZkDr3uu/Ev6Kw9yWpPngN0xrUJNl6MEUJQfNvWR3x0Tzg3Cg4WSyH3
 6Be0Kme6dyK6xAkIrTKbS4oFpK0+EBw3NfqNC4z/b2cWvBXFeoqIfog3gKzrFN4lNQT6
 tOwk1+WJxs39mjcEnF6+DtLJqSAnedFlxgDMGchAqUMzkGaXO0oKMZdSvHjNNcQjQ/5H
 gZ4PiCKuBuSQC2Qv2RY0KE/Z7qW8VZfg+P5ADuhMp6g1uwD/pPSCoh9EyYr58omJNojW
 9Qpg==
X-Gm-Message-State: AOJu0YyeNGIgn9FoC8nXZ5SUBUoCjM5iBNARoVtEzzyBaEY2RYkujYhr
 VDjm/6xw4OEuw/7Y0Itya/lRgQCx4sQiIKzLTPRPJKiR1jm4vW+Kgx50OoJXDhbP0ECK0fK+j7l
 cFG/d
X-Gm-Gg: ASbGnct6OgCyaDfVytpM55/jyKBAq/JrT4M6IWd5iWkljsn+ygRuM+E1JdGX5VQ8yPK
 xKxN07xKrtKVLj7N7erqtQasdg6GtIHGdvApzQbF/iRhdvhIR0TnupXQHFtqRjJyVSwYEoBMDQw
 zMNRL1hRztuTks/UGLkzPGRvf4N7UdAcXi1Yg38fp6HulmFbvx1Sk9YWGhjomIplr0wfp6vPzPE
 dCHo/0K0wuHanx9uHouXJ7ZN08mtEyaQBMS5qS2nt1LbCpBLcvR2v+qL2hlntNovP3dec234n6a
 OclO+m/UKpBRH75UQxO14V6Iq7ET8luuG1at8levq4Ljc1iOd3zdRZScpc1myQRWqhuch6ldctv
 QTZ1lfR0paZoGEe0wp24XZvlOyrhvCATXgjDId/Fu5Pn92IZPQog/wJCKLtW0BwEUMvgWd0+2cn
 V08mLWLB8=
X-Google-Smtp-Source: AGHT+IFzUKSZKW+qVDCPOCN9KEJNfKFDFOBqR1r2sdmykagNj2DyoRtZ68mZxjyoqZMx0NVy1O1yLA==
X-Received: by 2002:a05:6000:2508:b0:3b8:d4ad:6af0 with SMTP id
 ffacd0b85a97d-3b8d94c3c8dmr10411057f8f.40.1754415131662; 
 Tue, 05 Aug 2025 10:32:11 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459dc7e1ddesm83320015e9.27.2025.08.05.10.32.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 05 Aug 2025 10:32:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org
Subject: [PULL 07/13] hw/sd/sdcard: Allow using SWITCH_FUNCTION in more SPI
 states
Date: Tue,  5 Aug 2025 19:31:28 +0200
Message-ID: <20250805173135.38045-8-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250805173135.38045-1-philmd@linaro.org>
References: <20250805173135.38045-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

In SPI mode, SWITCH_FUNCTION is valid in all mode
(except the IDLE one).

Fixes: 775616c3ae8 ("Partial SD card SPI mode support")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250804133406.17456-8-philmd@linaro.org>
---
 hw/sd/sd.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index df2a272c6a2..a9efa158594 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1488,8 +1488,14 @@ static sd_rsp_type_t sd_cmd_SWITCH_FUNCTION(SDState *sd, SDRequest req)
     if (sd->mode != sd_data_transfer_mode) {
         return sd_invalid_mode_for_cmd(sd, req);
     }
-    if (sd->state != sd_transfer_state) {
-        return sd_invalid_state_for_cmd(sd, req);
+    if (sd_is_spi(sd)) {
+        if (sd->state == sd_idle_state) {
+            return sd_invalid_state_for_cmd(sd, req);
+        }
+    } else {
+        if (sd->state != sd_transfer_state) {
+            return sd_invalid_state_for_cmd(sd, req);
+        }
     }
 
     sd_function_switch(sd, req.arg);
-- 
2.49.0


