Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B95BC61CE8
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Jun 2025 00:08:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPruL-0005rQ-HM; Thu, 12 Jun 2025 20:04:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3BGtLaAcKClE37547w1z77z4x.v759x5D-wxEx4676z6D.7Az@flex--komlodi.bounces.google.com>)
 id 1uPruC-0005oO-6H
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 20:04:24 -0400
Received: from mail-pg1-x549.google.com ([2607:f8b0:4864:20::549])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3BGtLaAcKClE37547w1z77z4x.v759x5D-wxEx4676z6D.7Az@flex--komlodi.bounces.google.com>)
 id 1uPruA-0000Y5-NG
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 20:04:23 -0400
Received: by mail-pg1-x549.google.com with SMTP id
 41be03b00d2f7-b0e0c573531so835849a12.3
 for <qemu-devel@nongnu.org>; Thu, 12 Jun 2025 17:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1749773061; x=1750377861; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=+3D32wRripWDGh37R/51W0a4xFipOjv3ijoy2qH+SOM=;
 b=U9+wVJUn3EXHBhrOR7Qsxnmy9VL3KdOa8UCfJB0Btl16YxtcT9n4keRXA2BQ7ImlDQ
 WI84BvyvpQmw3ywtsmyvYDRLzxCiMMiTLWJp+7FCqobSJ26XkZ+VzgSFN7JqzV5e2wZw
 S1qFqmufdFpoKy8EgJpDxq/IYE934yILnlJLSx7OOfYVFwhmFpy1udfZoABr30RGaB9g
 l/l9Rlb0UX1fM9IJlWb17WsU3R9i2sLI7I1kvC8fBeyk0uEZ7qDh3Y0wAP/WOQa+Pxie
 sz2eKEVrA4saEEdmu+VcA3ApRWCs++cirKF6gHWDwz6tuyfnd2M5N0vlsHU8qh5Vz3t8
 56FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749773061; x=1750377861;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+3D32wRripWDGh37R/51W0a4xFipOjv3ijoy2qH+SOM=;
 b=Jli0sNhV2Pct2f2M32GYqQi+/BSrJKLDlqGHrAi/cMH9RuzqWGMGgIz439S/jhJbZf
 Jj/XwNm4QV/dsH5FIOO2NPReG2EmDP+zzJbY72aHViyA6kcjO18FAYcvPwNDrEe2YJ2v
 rd3b6PH5FrWAFIF7EEbRQ0GX8alE7845EiYnTwQwHWwG75hdQVy8/Jcb/JKbGukf4Ew1
 4EJirCSathGqOz5A9I0IqlU6JYUzCDubv8oD2UP2UFCCO4AUy6EclLqpHVSuphc0Mm0A
 GCfe1lfNnzLh591nNzlqksKNJHdepwI1U+nsKVq/qXFTie4u5DaraqwPMLqe2WTznGVD
 f5cQ==
X-Gm-Message-State: AOJu0YzfHJYXYVOu64wrsXjHbzVa8T2rc2tNWlBFJiRdeyllS2x5oiM6
 lo3qfJDhMYdLFkhTdpoME4JkRYgQoAJABPocqmzn6nZyi47xU5NUHIDFfWhbF0/mS+eZApSxNyL
 caDz/QcpMPGqCnEgfimNahKYgmjd1AZbtdbbq2RNjtinsYeeBetUXYB/hqLvqmcQm6cnMM8/pMq
 OWIYdAEyi3iAXkV1QAMslYK7kLKrIvK/uc8eZkRYIp
X-Google-Smtp-Source: AGHT+IGlnPTM7QeaeaCrToaS2aQ3n7oiYYosCaPN87vXCa/zLMwd/RA/f7cLTESWfAxQGgPJ+kzH8HdYvxnC
X-Received: from pgah7.prod.google.com ([2002:a05:6a02:4e87:b0:b2e:b684:1f9e])
 (user=komlodi job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:6a25:b0:218:96ad:720d
 with SMTP id adf61e73a8af0-21facbba984mr1179219637.1.1749773060836; Thu, 12
 Jun 2025 17:04:20 -0700 (PDT)
Date: Fri, 13 Jun 2025 00:03:58 +0000
In-Reply-To: <20250613000411.1516521-1-komlodi@google.com>
Mime-Version: 1.0
References: <20250613000411.1516521-1-komlodi@google.com>
X-Mailer: git-send-email 2.50.0.rc1.591.g9c95f17f64-goog
Message-ID: <20250613000411.1516521-7-komlodi@google.com>
Subject: [PATCH 06/19] hw/i3c/dw-i3c: Add more reset values
From: Joe Komlodi <komlodi@google.com>
To: qemu-devel@nongnu.org
Cc: venture@google.com, komlodi@google.com, clg@kaod.org, 
 peter.maydell@linaro.org, steven_lee@aspeedtech.com, leetroy@gmail.com, 
 jamin_lin@aspeedtech.com, andrew@codeconstruct.com.au, joel@jms.id.au, 
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::549;
 envelope-from=3BGtLaAcKClE37547w1z77z4x.v759x5D-wxEx4676z6D.7Az@flex--komlodi.bounces.google.com;
 helo=mail-pg1-x549.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

Adds reset values for the new registers added.

Signed-off-by: Joe Komlodi <komlodi@google.com>

Reviewed-by: Patrick Venture <venture@google.com>
---
 hw/i3c/dw-i3c.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/hw/i3c/dw-i3c.c b/hw/i3c/dw-i3c.c
index b252903ea4..845fbd5efd 100644
--- a/hw/i3c/dw-i3c.c
+++ b/hw/i3c/dw-i3c.c
@@ -285,14 +285,32 @@ REG32(DEVICE_ADDR_TABLE_LOC1, 0x280)
     FIELD(DEVICE_ADDR_TABLE_LOC1, LEGACY_I2C_DEVICE, 31, 1)
 
 static const uint32_t dw_i3c_resets[DW_I3C_NR_REGS] = {
-    [R_HW_CAPABILITY]               = 0x000e00bf,
+    /* Target mode is not supported, don't advertise it for now. */
+    [R_HW_CAPABILITY]               = 0x000e00b9,
     [R_QUEUE_THLD_CTRL]             = 0x01000101,
+    [R_DATA_BUFFER_THLD_CTRL]       = 0x01010100,
+    [R_SLV_EVENT_CTRL]              = 0x0000000b,
+    [R_QUEUE_STATUS_LEVEL]          = 0x00000002,
+    [R_DATA_BUFFER_STATUS_LEVEL]    = 0x00000010,
+    [R_PRESENT_STATE]               = 0x00000003,
     [R_I3C_VER_ID]                  = 0x3130302a,
     [R_I3C_VER_TYPE]                = 0x6c633033,
     [R_DEVICE_ADDR_TABLE_POINTER]   = 0x00080280,
     [R_DEV_CHAR_TABLE_POINTER]      = 0x00020200,
+    [R_SLV_CHAR_CTRL]               = 0x00010000,
     [A_VENDOR_SPECIFIC_REG_POINTER] = 0x000000b0,
     [R_SLV_MAX_LEN]                 = 0x00ff00ff,
+    [R_SLV_TSX_SYMBL_TIMING]        = 0x0000003f,
+    [R_SCL_I3C_OD_TIMING]           = 0x000a0010,
+    [R_SCL_I3C_PP_TIMING]           = 0x000a000a,
+    [R_SCL_I2C_FM_TIMING]           = 0x00100010,
+    [R_SCL_I2C_FMP_TIMING]          = 0x00100010,
+    [R_SCL_EXT_LCNT_TIMING]         = 0x20202020,
+    [R_SCL_EXT_TERMN_LCNT_TIMING]   = 0x00300000,
+    [R_BUS_FREE_TIMING]             = 0x00200020,
+    [R_BUS_IDLE_TIMING]             = 0x00000020,
+    [R_EXTENDED_CAPABILITY]         = 0x00000239,
+    [R_SLAVE_CONFIG]                = 0x00000023,
 };
 
 static uint64_t dw_i3c_read(void *opaque, hwaddr offset, unsigned size)
-- 
2.50.0.rc1.591.g9c95f17f64-goog


