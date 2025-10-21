Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3F2DCCD1AA
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 20:54:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBJJ4-0003oN-UV; Tue, 21 Oct 2025 16:50:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBJIx-00033U-AE
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 16:50:03 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBJIt-0001IQ-CB
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 16:50:01 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4710665e7deso23270075e9.1
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 13:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761079796; x=1761684596; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=E3RZP+uPdi/u4o2bwW6kEbE3vICc4qLss0EKsxFjnU8=;
 b=SL9lA8/cDXs5s6IaEQxVdz0qIIn0EE+NcgJLRGWMnKTNvPDCCVQBKhTz03Gt4t4lZu
 omPncDw0ypdwtTi9sYt5smrs+ZY9vFw1YEitOuGRPAtVzumrtgkaW91p1EEODLZ1accj
 Nnga3Uiosu2zXJ9ol55yL5hNOQYWyB1PDslYznQQvFlr+F7+rpRT6PkzUAuFQGWEdu61
 cOKgVE2ztNwcQA9Dn0qbHgJW2WcHt9R7udd/gKJhEMXbJGNm3b0OjhNkirIthYOU+VWq
 aHe71U2X/5dkZX9xNrBoQJbgK64HhzbgAfmmwEamAI3mBqIj6pvELYzljoBWT8TMdunw
 Kuug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761079796; x=1761684596;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E3RZP+uPdi/u4o2bwW6kEbE3vICc4qLss0EKsxFjnU8=;
 b=hHmNq3pjXTCl9mtSJ2mE3bNUcL3MSHIys02dy3TAvYzzoUHz7Ku4xYH7SX4DHyL7bm
 jgVpvgS8eM/zULRhhFfx5mKsOshihUo5drfPrpeTw/Tz9eRjJ3Nl5e6D3P1KbwOsRukC
 sd+3mAXl9grAlJOncvqvbzqZiLABHBdaW5iH/l+siv97SO24KyRdzos8jfoHTro2oc6m
 BecwZkAzDbCJDcAIw7QZ55f1GTPWnVwSOGMSIBwdOuzGw0MOkgEFxzBGwqdiweM4Wjcn
 aKydHLmDf6i87p087TGjueJCh0M3NiIl1qoEzxz77YTjB1aTfBRd3mkHwkX7MGXblHpo
 5d3w==
X-Gm-Message-State: AOJu0YzTdsClPQWHJzVd54brDP4O4JCSfJoFHddr8K40TWcXe+x5UqYN
 /c+TSrVAuNXFJZgR/QG9Bfj+gxWDBblm1Emq1DT4Pg0NUPkPy4ORPMiJlUCQwRrqvo7UjfKBHVR
 dLnH0nxY=
X-Gm-Gg: ASbGncvFUIGt2AjR3/GQfnFWQ+AGnQZ3loF/Mqeui6sKLMlFS2eoQ4QarAVUqMl2o98
 WdeYTbw9SrmoP9ftL4ms+6nDJ5qlM54dkO6lj5AdF2xW3wLgrDtAuIaLonNWEaahXup945pHJYb
 fkxR2hpaHsZI0Xb0V/Tpl7fl9cqbgLDtC5BhITDXhXigcl1/Loux/ORB3oLQFoot4a6511Z0ZG/
 cKs9Tk7s/6eaDEvWf4CuCwKstpPnTFFuXGBTDntD7rFfX2S9Ypc2f4Cx+Laj1yKLP5HRW4IQLr7
 RGbeP8VlTXuAqxL9DstiGwiS+81MR59Z7XKl6YSDsY/X2yiw0A4+sUd+4jKC40ZawnzE1vSaIoT
 UGW+JIMRZFqJs6Cy6qK2wnUmps53gwwUrQlmhPIr9Qdsd02SXfO3wDx/QNB67I5ltGDNZPPCpeF
 4L/BYkjJQ77uJVXawc7J2c7BEdFvCKxR/4PROEwCBHQm5+9ZcSPkJ1Sa+/i6xe
X-Google-Smtp-Source: AGHT+IHs/8+blCKIUcT171bl2SUi0LuixDfcpAzy8HZtzRCdAy0bihBr8Np6wBz+OV/4DPY5L2Vy8g==
X-Received: by 2002:a05:600c:8b0d:b0:46e:39e1:fc27 with SMTP id
 5b1f17b1804b1-4711787442amr136670605e9.5.1761079796447; 
 Tue, 21 Oct 2025 13:49:56 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427f00ce678sm22286950f8f.51.2025.10.21.13.49.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Oct 2025 13:49:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 37/45] hw/pcspk: use explicitly the required PIT types
Date: Tue, 21 Oct 2025 22:46:51 +0200
Message-ID: <20251021204700.56072-38-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251021204700.56072-1-philmd@linaro.org>
References: <20251021204700.56072-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20251021090317.425409-5-marcandre.lureau@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/timer/i8254.h | 4 ++--
 hw/audio/pcspk.c         | 2 +-
 hw/timer/i8254_common.c  | 6 ++----
 3 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/include/hw/timer/i8254.h b/include/hw/timer/i8254.h
index 8402caad307..f7148d92865 100644
--- a/include/hw/timer/i8254.h
+++ b/include/hw/timer/i8254.h
@@ -75,7 +75,7 @@ static inline ISADevice *kvm_pit_init(ISABus *bus, int base)
     return d;
 }
 
-void pit_set_gate(ISADevice *dev, int channel, int val);
-void pit_get_channel_info(ISADevice *dev, int channel, PITChannelInfo *info);
+void pit_set_gate(PITCommonState *pit, int channel, int val);
+void pit_get_channel_info(PITCommonState *pit, int channel, PITChannelInfo *info);
 
 #endif /* HW_I8254_H */
diff --git a/hw/audio/pcspk.c b/hw/audio/pcspk.c
index 610a5b21626..9cf78ff55fa 100644
--- a/hw/audio/pcspk.c
+++ b/hw/audio/pcspk.c
@@ -51,7 +51,7 @@ struct PCSpkState {
     uint8_t sample_buf[PCSPK_BUF_LEN];
     QEMUSoundCard card;
     SWVoiceOut *voice;
-    void *pit;
+    PITCommonState *pit;
     unsigned int pit_count;
     unsigned int samples;
     unsigned int play_pos;
diff --git a/hw/timer/i8254_common.c b/hw/timer/i8254_common.c
index ad091594cde..419d4cd6e57 100644
--- a/hw/timer/i8254_common.c
+++ b/hw/timer/i8254_common.c
@@ -32,9 +32,8 @@
 #include "migration/vmstate.h"
 
 /* val must be 0 or 1 */
-void pit_set_gate(ISADevice *dev, int channel, int val)
+void pit_set_gate(PITCommonState *pit, int channel, int val)
 {
-    PITCommonState *pit = PIT_COMMON(dev);
     PITChannelState *s = &pit->channels[channel];
     PITCommonClass *c = PIT_COMMON_GET_CLASS(pit);
 
@@ -139,9 +138,8 @@ void pit_get_channel_info_common(PITCommonState *s, PITChannelState *sc,
     info->out = pit_get_out(sc, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL));
 }
 
-void pit_get_channel_info(ISADevice *dev, int channel, PITChannelInfo *info)
+void pit_get_channel_info(PITCommonState *pit, int channel, PITChannelInfo *info)
 {
-    PITCommonState *pit = PIT_COMMON(dev);
     PITChannelState *s = &pit->channels[channel];
     PITCommonClass *c = PIT_COMMON_GET_CLASS(pit);
 
-- 
2.51.0


