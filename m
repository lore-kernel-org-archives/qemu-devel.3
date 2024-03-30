Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 410BFC6FD1F
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Mar 2024 21:10:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rqfxK-0007fu-1c; Sat, 30 Mar 2024 17:09:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <giacomo.parmeggiani@gmail.com>)
 id 1rqfRM-0003p2-01; Sat, 30 Mar 2024 16:36:36 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <giacomo.parmeggiani@gmail.com>)
 id 1rqfRK-0001Fs-BE; Sat, 30 Mar 2024 16:36:35 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4155f5b8cefso595605e9.1; 
 Sat, 30 Mar 2024 13:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711830992; x=1712435792; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=sRjnZ3gjx+ZJ/Nyk8hURqzpR3uHQ4jTEOFkYyRAgiBw=;
 b=cbH/gkXWWoBLpv6xPPJD5IYmkeo77Xr2x1Nz3wcG1vQaiXNH2NAhYdUDmW3BfjZf7Q
 yCSMHKwNrL4qenDRkP9IGCW82UvACcoMqm1lKH8j8I3CN0dGX7O8z84g3DngNnvjAuGR
 naHiDvbUU2fRjAmp8655sdWReQPpyPAAlcSHi/tTp4P/Wu61c8J+O9AMAEr/1k1ZHwfW
 J5lZfu/X75SRaflRmey+Woij3vOWyl0Ghtdp83ZjUpQTooprkQ3Av69v6MWIGNi8b5PE
 XKBBlWFdS296X4rwhDZuTrqM012q7uFpt5uOyCJn5BAKBATM5lPcFZTvV9PRYxNv7e3S
 TZ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711830992; x=1712435792;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sRjnZ3gjx+ZJ/Nyk8hURqzpR3uHQ4jTEOFkYyRAgiBw=;
 b=oAqimd+PBivRvrcgG5R2My4RUP00AxpVjIom6BjipOEmahdrRPC5K5nvd57wfSQEnZ
 k4xwFzb+NRIXPVnhM+n+W7Iqh6nwxMBHR3sitgvHwQ1n/rLmpt6ogy89CM0nJw7n22Rq
 R1AeJEP/bivSeUjg33qShQfF51MvL9amR1PwlEkyjhozgCFP5O7lUt4ui2O9BE46UhzU
 3fYlAgMXZ85k3Xe3+Tv0eVZhh8vjCOWJPe4p7wJGTdJSGlkXlzl8BxlNmHV2pfBx6iYx
 o73A5aU0YZUD2vYxwLwxO8zX0prqyuNUfIDXfc0TmJaGMnYs4pWDaFExt3LaaoX07OvN
 QrQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxtqGZXKGZSLaq7MoB3ylhDYffGDsKLhvg9FobqQcBQGy8zMEoFPPz52PNEIJ9unuxs0/fVhQ/qzTy5A7DKadP2wNjob8=
X-Gm-Message-State: AOJu0YwJNNivoP/0m4w2h9q+qEuDNf2blhWVaTQYCdijhROKZRGTvKbg
 E0Kh9jCPL9RS3NKy8UPAe2A/XLRfOFizkybMQ2Cl+WEMvD4dPH1JhiGgGlUfG/JxOA==
X-Google-Smtp-Source: AGHT+IHHjcDK+9BrJNKbjgL12XSbA5AXzP1hUEqqHQosoSZcvccRCv9kwvZxz3Dz0vEs3gfXMv9YQQ==
X-Received: by 2002:a05:600c:4fd5:b0:414:4d82:ec01 with SMTP id
 o21-20020a05600c4fd500b004144d82ec01mr4107743wmq.21.1711830991492; 
 Sat, 30 Mar 2024 13:36:31 -0700 (PDT)
Received: from localhost.localdomain ([213.55.241.93])
 by smtp.gmail.com with ESMTPSA id
 o15-20020a05600c4fcf00b0041488895a37sm12624948wmq.33.2024.03.30.13.36.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 30 Mar 2024 13:36:31 -0700 (PDT)
From: Giacomo Parmeggiani <giacomo.parmeggiani@gmail.com>
To: qemu-devel@nongnu.org
Cc: Giacomo Parmeggiani <giacomo.parmeggiani@gmail.com>,
 Alistair Francis <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org (open list:Block layer core)
Subject: [PATCH] m25p80: Add support for the GD25WQ32E flash
Date: Sat, 30 Mar 2024 21:35:20 +0100
Message-Id: <20240330203520.64892-1-giacomo.parmeggiani@gmail.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=giacomo.parmeggiani@gmail.com; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 30 Mar 2024 17:09:35 -0400
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

This introduces the GigaDevice GD25WQ32E flash, including the SFDP table

Signed-off-by: Giacomo Parmeggiani <giacomo.parmeggiani@gmail.com>
---
 hw/block/m25p80.c      |  2 ++
 hw/block/m25p80_sfdp.c | 40 ++++++++++++++++++++++++++++++++++++++++
 hw/block/m25p80_sfdp.h |  2 ++
 3 files changed, 44 insertions(+)

diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
index 8dec134832..6cc05b63e5 100644
--- a/hw/block/m25p80.c
+++ b/hw/block/m25p80.c
@@ -205,6 +205,8 @@ static const FlashPartInfo known_devices[] = {
     /* GigaDevice */
     { INFO("gd25q32",     0xc84016,      0,  64 << 10,  64, ER_4K) },
     { INFO("gd25q64",     0xc84017,      0,  64 << 10, 128, ER_4K) },
+    { INFO("gd25wq32e",   0xc86516,      0,  64 << 10,  64, ER_4K),
+      .sfdp_read = m25p80_sfdp_gd25wq32e },
 
     /* Intel/Numonyx -- xxxs33b */
     { INFO("160s33b",     0x898911,      0,  64 << 10,  32, 0) },
diff --git a/hw/block/m25p80_sfdp.c b/hw/block/m25p80_sfdp.c
index 6ee2cfaf11..cb0963328d 100644
--- a/hw/block/m25p80_sfdp.c
+++ b/hw/block/m25p80_sfdp.c
@@ -406,3 +406,43 @@ static const uint8_t sfdp_is25wp256[] = {
     0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
 };
 define_sfdp_read(is25wp256);
+
+/*
+ * GigaDevice
+ */
+
+static const uint8_t sfdp_gd25wq32e[] = {
+    0x53, 0x46, 0x44, 0x50, 0x06, 0x01, 0x01, 0xff,
+    0x00, 0x06, 0x01, 0x10, 0x30, 0x00, 0x00, 0xff,
+    0xc8, 0x00, 0x01, 0x03, 0x90, 0x00, 0x00, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xe5, 0x20, 0xf1, 0xff, 0xff, 0xff, 0xff, 0x01,
+    0x44, 0xeb, 0x08, 0x6b, 0x08, 0x3b, 0x42, 0xbb,
+    0xee, 0xff, 0xff, 0xff, 0xff, 0xff, 0x00, 0xff,
+    0xff, 0xff, 0x00, 0xff, 0x0c, 0x20, 0x0f, 0x52,
+    0x10, 0xd8, 0x00, 0xff, 0x63, 0x92, 0xfd, 0xfe,
+    0x83, 0x2f, 0x26, 0x46, 0xec, 0x82, 0x18, 0x44,
+    0x7a, 0x75, 0x7a, 0x75, 0x04, 0xbd, 0xd5, 0x5c,
+    0x00, 0x06, 0x64, 0x00, 0x08, 0x10, 0x00, 0x00,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0x00, 0x36, 0x50, 0x16, 0x9e, 0xf9, 0x77, 0x64,
+    0xfc, 0xcb, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff
+};
+define_sfdp_read(gd25wq32e);
diff --git a/hw/block/m25p80_sfdp.h b/hw/block/m25p80_sfdp.h
index 1733b56950..7d1f60f2ee 100644
--- a/hw/block/m25p80_sfdp.h
+++ b/hw/block/m25p80_sfdp.h
@@ -29,4 +29,6 @@ uint8_t m25p80_sfdp_w25q01jvq(uint32_t addr);
 
 uint8_t m25p80_sfdp_is25wp256(uint32_t addr);
 
+uint8_t m25p80_sfdp_gd25wq32e(uint32_t addr);
+
 #endif
-- 
2.32.1 (Apple Git-133)


