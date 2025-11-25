Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB07FD10366
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 21:48:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vO0u3-0001nC-K9; Tue, 25 Nov 2025 16:48:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vO0tx-0001hE-5F
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 16:48:46 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vO0tv-0005H9-Hl
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 16:48:44 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-42b3108f41fso3665224f8f.3
 for <qemu-devel@nongnu.org>; Tue, 25 Nov 2025 13:48:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764107322; x=1764712122; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yYI88q2Amny+q3PiM3TiKWYQwpqS2W1DuHTcySN9NwY=;
 b=SmSuNi4vh50TTNX+uoji/rkPQ9sAsDYfG0WCJEzNjMO+tWvBn4a3M6qhT+qWZlutRX
 dxeiQaeUN8uWEIcNAHg0uAoiXV7x2CQ61qXbrhl7aj2/D4P9qNHlJeVbbFcfUmBDv/nf
 dqpOVPpNrCebtfByJZY4AO+TdiM7HsuVN0lEFb2qoOBVIsnv/rxddMH1k5pmxhWFkQw4
 QgM45TrpTFkUFMJ7TKEJDl44VyhwkxOP250TQ1h2GJD26ojAW6nUxKVEynG1VuiMiGI8
 ar0i5XZjtcItJuJCYS3LEo5HKZTbuF2MV1simGbxcXAZGVqK++QmqbxbABnss6BMPXXF
 5rqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764107322; x=1764712122;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=yYI88q2Amny+q3PiM3TiKWYQwpqS2W1DuHTcySN9NwY=;
 b=xSMipOLqmBXFy7Tz0JTDMvNlptp445UewT7cE2Jn2vfzteNBJ+v9FkRgphSWbdA4Ox
 SpaOLUINArrlOQo47EeEp1SwtPlGe06UILRSwriest4kX9K6P9TZ0OFlDHxs43d8tYRv
 UfxTpmXt2lib9/RNuwWqhgncvLQeMl3Tm35RmV3Qiye659jBoLlJhJrvXNc+i1g9wCKY
 LZDQ4CIxmssBX+75LUVzIqa6dWninknXrtk0vGp08JbQ40NTzMKMjVeKU4eahpQacyhA
 7//lv6Vj1xt7rHRbcY0iUXZQQ9tCOXgtmblvg0XQPzqpLbzXJUZqclVJiu/Fz+G2wwqu
 oyXg==
X-Gm-Message-State: AOJu0Yy0OCRkqb3w27B31DNqmkxeHxm6jaqKPdWryrBEuPLvnmyurrbg
 rgxnh2GuQ4jOy6DvXirmZPucw3y+b4Gwm2HFSmQIXyh4JYMjwrSngvJbOE6deyVxNGWZymdLkMh
 d9hdE9K8tzQ==
X-Gm-Gg: ASbGncv5X5zCCbLFT0hHITt9CG5s/0OT9lZxIwXSvWYZu+OjE7KXNSgeJoIKezuslhv
 aR7YyivDC9d4pBFmTvL3lKS+RHci7LhJdsIVH/+Zd/ly9aj2aLiBXJ668zclglHPIObGGWwHEwm
 ksFuGbVPraiTlY1l/XehCyxoMTn9D2zIMjjS0rb1w7I2ZGRe2CvMOAFeSFNBV9HnlV2ms65WCcx
 s1Tb8/Vmo6QbS6JrtGLXtSjxmoSvE901425j0uRBDrpzcdQb+yb4YR+qnDKBJ05H/NNZWS2s8Fo
 AZQCkRUx0g1WWD9VLHR7w6DQOLRMnAzHhkWWYFFGT3EMC+GwzV9z1G9F6eLDLpJ6ae/iBYh0Qn7
 ztnEciZ7YAh4n07v5S9ypWdI63oOHsgP7d79LN1RiRpjgMhFhYE0O9cDrewRaKcGjsKB7bZDN9B
 LqmFx/I2sMcS+88tHlfDQP//28AZ8pGGcJVW5KySruOsMdwamJwWzEx6c3XTO6
X-Google-Smtp-Source: AGHT+IEVsi29xYCDE8Xh1aRgNa1WVxJgBHTr/5YXbcEjTsxY2kkQbjI2VGQBLzHmSKoyt1L/lyMmIg==
X-Received: by 2002:a05:6000:2484:b0:42b:4061:23f3 with SMTP id
 ffacd0b85a97d-42cc1d0cfb8mr17357542f8f.44.1764107321726; 
 Tue, 25 Nov 2025 13:48:41 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7f34ff3sm37401920f8f.16.2025.11.25.13.48.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 25 Nov 2025 13:48:41 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 5/9] hw/scsi: Use error_setg_file_open() for a better error
 message
Date: Tue, 25 Nov 2025 22:47:57 +0100
Message-ID: <20251125214802.1929-6-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251125214802.1929-1-philmd@linaro.org>
References: <20251125214802.1929-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

From: Markus Armbruster <armbru@redhat.com>

The error message changes from

    vhost-scsi: open vhost char device failed: REASON

to

    Could not open '/dev/vhost-scsi': REASON

I think the exact file name is more useful to know than the file's
purpose.

We could put back the "vhost-scsi: " prefix with error_prepend().  Not
worth the bother.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20251121121438.1249498-7-armbru@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/scsi/vhost-scsi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
index cdf405b0f86..239138c9316 100644
--- a/hw/scsi/vhost-scsi.c
+++ b/hw/scsi/vhost-scsi.c
@@ -245,8 +245,7 @@ static void vhost_scsi_realize(DeviceState *dev, Error **errp)
     } else {
         vhostfd = open("/dev/vhost-scsi", O_RDWR);
         if (vhostfd < 0) {
-            error_setg(errp, "vhost-scsi: open vhost char device failed: %s",
-                       strerror(errno));
+            error_setg_file_open(errp, errno, "/dev/vhost-scsi");
             return;
         }
     }
-- 
2.51.0


