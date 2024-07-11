Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77BBAC3271E
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 07:40:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRoON-0000D5-CQ; Thu, 11 Jul 2024 03:39:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sRoOL-0000BR-E0
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 03:39:01 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sRoOJ-0007t3-6W
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 03:39:01 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4255fc43f1cso3607045e9.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2024 00:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720683537; x=1721288337; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+NlZe4bII7DiQ3CI3hy2LK493LnlzcQDADbRTBeKV3M=;
 b=TwHybr9Jb4e/j4ry9s2raJYR5kBmUkRvxrAHKUdfo9rG+Fva/5fTjG2NhFzZmgAqSQ
 xLlVFAN4Fe7FmEQ0rkSl1q02PwA+73Fe2djNfk30oTnxUzaVbGB/q6ilYXMeetEzxJKa
 b0KQqDUVOURaKHIum6f6JVHWeb9dCKgvOP71fWJltXpE46iacGneaOeEI80lfNjm1xBZ
 UOsXysel4n4k96hINCs+LsTUThvr6HnE9lp1mNRQRgJ0/jPoG1LcHCrObLsBYU2VYx64
 Ej7UUg4ztz4wqem5WyUsJf/NU/i1ltQpUWa4I4Oq3ECuFQRkpvq2lh2JWIaqL9PEkgcc
 eMrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720683537; x=1721288337;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+NlZe4bII7DiQ3CI3hy2LK493LnlzcQDADbRTBeKV3M=;
 b=Mc/V9E4T62cjEwN3DQiwfv36AA8g3IH6N4UO4IU0fZPIMu23FzvSX3jYOL4IgSpUP5
 YFdIUnSDxxHJPUBj7Uj6e+coFt6a2LXdSW9t52DBeSkwA6ykB2ttIiqt/2+mSxCJC6cj
 wyE3Ag5BmhfyHcyOsRNlcYxHtW54hgeAxUzByDPqqmySRhrhlJcbqwC08+5rPVKX9WgI
 OqRryVua3CQ75FjqSVHeraXEf2wRBlSMY39/gNb6jtcxfiEp0ZDVqhV4uwLN76bk99Dp
 SLqLEv8ZKG9xYznCoikDHtvVKfVRmC7wi37ZYgr9xht9cEqDKrVA/XmVNzxjrFC2hFw4
 cPDg==
X-Gm-Message-State: AOJu0YwkBAM16D8jjwIV7RHoQSpPR+tRDD4NEaKX5sjhjL0nsdKRHhrr
 VMa8YNloXgl7WuqkSPV/0ihdubPqqGFvntpG6IPhkO8wNXyXe46o+IWqfqGfxBLRht4RLWp27tt
 Ro8Q=
X-Google-Smtp-Source: AGHT+IGovxkiC73dcfS9vDZ3pnD3ZqnI6WLHNkpr+TRleYpUB5VgElAYy/F0Kx5ZJtb1PrW7JgWC4Q==
X-Received: by 2002:a05:600c:574a:b0:426:63ff:f763 with SMTP id
 5b1f17b1804b1-426708fa81cmr57158005e9.36.1720683537335; 
 Thu, 11 Jul 2024 00:38:57 -0700 (PDT)
Received: from localhost.localdomain (adsl-231.37.6.1.tellas.gr. [37.6.1.231])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-367cde84655sm7006137f8f.32.2024.07.11.00.38.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jul 2024 00:38:57 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Zheyu Ma <zheyuma97@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v1] virtio-snd: check for invalid param shift operands
Date: Thu, 11 Jul 2024 10:38:49 +0300
Message-ID: <virtio-snd-fuzz-2416-fix-v1-manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x336.google.com
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

When setting the parameters of a PCM stream, we compute the bit flag
with the format and rate values as shift operand to check if they are
set in supported_formats and supported_rates.

If the guest provides a format/rate value which when shifting 1 results
in a value bigger than the number of bits in
supported_formats/supported_rates, we must report an error.

Previously, this ended up triggering the not reached assertions later
when converting to internal QEMU values.

Reported-by: Zheyu Ma <zheyuma97@gmail.com>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2416
Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/audio/virtio-snd.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index 5993f4f040..98a7ef5719 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -282,11 +282,13 @@ uint32_t virtio_snd_set_pcm_params(VirtIOSound *s,
         error_report("Number of channels is not supported.");
         return cpu_to_le32(VIRTIO_SND_S_NOT_SUPP);
     }
-    if (!(supported_formats & BIT(params->format))) {
+    if (BIT(params->format) > sizeof(supported_formats) ||
+        !(supported_formats & BIT(params->format))) {
         error_report("Stream format is not supported.");
         return cpu_to_le32(VIRTIO_SND_S_NOT_SUPP);
     }
-    if (!(supported_rates & BIT(params->rate))) {
+    if (BIT(params->rate) > sizeof(supported_rates) ||
+        !(supported_rates & BIT(params->rate))) {
         error_report("Stream rate is not supported.");
         return cpu_to_le32(VIRTIO_SND_S_NOT_SUPP);
     }

base-commit: 59084feb256c617063e0dbe7e64821ae8852d7cf
-- 
γαῖα πυρί μιχθήτω


