Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84562C30653
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 07:36:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sM0hh-0004XB-71; Tue, 25 Jun 2024 03:35:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sM0hf-0004Wp-Jm
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 03:34:59 -0400
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sM0hd-0003kj-V1
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 03:34:59 -0400
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2eaa89464a3so60313641fa.3
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2024 00:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719300896; x=1719905696; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MFRKHAqO647KOdwqqDJufJ/DZoqjTVohRrJvslLGVMw=;
 b=JaFdkVuNjkwxcVhuSofUzbSLP6bLTa8eUJp3tAzdIHzh7VjidthKPCzWVYLr+ACLGt
 jvEWyLVon0Bb20iCgH20QYWuX0pzvcS67tg4tIh1cjQIXSD/+oof2q4u1qKEnBCm1V6Q
 vip0msazKJBcfJYLbc84wJdbZhJUCILy8elPALQ3SLnQ0EPJRnLWlULIrFUukfaN+dVG
 og2kDzyRGfuH+zUVu9I4NpDMN3Ix9k4/VaBhAFVHaJen/hBvnla2d+/S4gUA0xEjWxzl
 mY+y9Y3Rro0IkTmhZC/y+iJ0G1yTueyrc2o42zrzKUwwfy2l/bUOVdS9Gyj4pGQVVaS0
 gurw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719300896; x=1719905696;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MFRKHAqO647KOdwqqDJufJ/DZoqjTVohRrJvslLGVMw=;
 b=KQ4dqdaoeyy+B8aMfSX/LgShTDKjvu5LCcDinoce3eGMXY4O7IF+n78aiYWEVefBIv
 1xPlQmqjgS5D2KNKOWK7QaxzRo2uAgoz/bdl/myNaUZNCgubcoDQJsVVuL3+fFMr4uGF
 EQnCrWdk0TaPBXMs9He2DGCPhfCnzwQYA99HGv+fMifp3hz0ZpdFzb+yX+x7y1agfX7y
 4RULhMVAvo08JIaHMKynmoQ/qXeIjTgcB+qBdSzKE2N4m6mtiGz5gfF8pbCPoBcqwxZk
 rzrt/HfUobZR3wOLHL3LflyZyjNhpXxnTcrAsQdjY2+sB7Nday7Elg+tE1TaU/7TArIE
 E3hg==
X-Gm-Message-State: AOJu0YwQtvBqVkyPrnD4kbcOKUY4vIKTjuZKlnEp5KKvxGqP9D0nqWLL
 f3p59Tyvcs70Q6ubdCv89D+WrunZcyvpQ8vfuYf5hg5Yf2ipXcTWRww9cEdlx6tHmpJEuKb1W1y
 E
X-Google-Smtp-Source: AGHT+IHzyoKWzlJJfBt6rltmTYltKRM5OwQibKHRgMKwPABjCmCOuXhxLCWaYBJ/i4H4up1u4JzwNQ==
X-Received: by 2002:a2e:8617:0:b0:2ec:561d:dee1 with SMTP id
 38308e7fff4ca-2ec57967b7fmr46632371fa.8.1719300895562; 
 Tue, 25 Jun 2024 00:34:55 -0700 (PDT)
Received: from m1x-phil.lan (mau49-h01-176-184-41-129.dsl.sta.abo.bbox.fr.
 [176.184.41.129]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4247d0be818sm200163415e9.15.2024.06.25.00.34.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 25 Jun 2024 00:34:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH 2/7] hw/sd/sdcard: Duplicate WRITE_SINGLE_BLOCK /
 WRITE_MULTIPLE_BLOCK cases
Date: Tue, 25 Jun 2024 09:34:36 +0200
Message-ID: <20240625073441.34203-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240625073441.34203-1-philmd@linaro.org>
References: <20240625073441.34203-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x231.google.com
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

In order to modify the WRITE_SINGLE_BLOCK case in the
next commit, duplicate it first.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 7fea0afb62..8c30826754 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1437,6 +1437,35 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
 
     /* Block write commands (Class 4) */
     case 24:  /* CMD24:  WRITE_SINGLE_BLOCK */
+        addr = sd_req_get_address(sd, req);
+        switch (sd->state) {
+        case sd_transfer_state:
+
+            if (!address_in_range(sd, "WRITE_SINGLE_BLOCK", addr,
+                                  sd->blk_len)) {
+                return sd_r1;
+            }
+
+            sd->state = sd_receivingdata_state;
+            sd->data_start = addr;
+            sd->data_offset = 0;
+
+            if (sd->size <= SDSC_MAX_CAPACITY) {
+                if (sd_wp_addr(sd, sd->data_start)) {
+                    sd->card_status |= WP_VIOLATION;
+                }
+            }
+            if (sd->csd[14] & 0x30) {
+                sd->card_status |= WP_VIOLATION;
+            }
+            sd->blk_written = 0;
+            return sd_r1;
+
+        default:
+            break;
+        }
+        break;
+
     case 25:  /* CMD25:  WRITE_MULTIPLE_BLOCK */
         addr = sd_req_get_address(sd, req);
         switch (sd->state) {
-- 
2.41.0


