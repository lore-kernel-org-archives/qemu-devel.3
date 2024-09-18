Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DEADCDD554
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 19:30:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sr0Gs-00058G-GY; Wed, 18 Sep 2024 15:23:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3nijrZgUKCtkO5QDKBJJBG9.7JHL9HP-89Q9GIJIBIP.JMB@flex--tavip.bounces.google.com>)
 id 1sr0Gm-0004gv-40
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 15:23:20 -0400
Received: from mail-pg1-x549.google.com ([2607:f8b0:4864:20::549])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3nijrZgUKCtkO5QDKBJJBG9.7JHL9HP-89Q9GIJIBIP.JMB@flex--tavip.bounces.google.com>)
 id 1sr0Gf-0007Kj-PN
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 15:23:19 -0400
Received: by mail-pg1-x549.google.com with SMTP id
 41be03b00d2f7-6c8f99fef10so8285210a12.3
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2024 12:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1726687391; x=1727292191; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=CDzav/GoioS247j60FjvTg5BYepYLV8hwnMK+f6n+3s=;
 b=OtlLTctmRfMOKUUBX1VZSfpsJA07gWrODnNA2+Kxe95p34/5HYuksUKQ0DbKsK/hyE
 H0U+jUIVOCTR5vXqGXfj5FYPuQsyBNM72I9O54aXWGM0bZaxor7I5utfhGyeLfzGyX5S
 EXkyCSaK9SBYdLD4Pn2M/rTu5tft9pYKCoTHfPOzthZv1KtcyyJ6ZrDdWK5/veecIhSk
 Upci5x78jcMZc/6uWzg2T/ed0p1w5x4ZUnpq1FCMDbKTHTPfNVNz993tAqjn37M9qqSq
 Cy8gWQRp58TZZ9Bx7SlRaXtaqk7VjSqIpFzfqZqHGYzTrb9YDOa4eRxwFtqVnhXSmtVl
 N5Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726687391; x=1727292191;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CDzav/GoioS247j60FjvTg5BYepYLV8hwnMK+f6n+3s=;
 b=izCKrWhXDGWWx89BIJ3DWSxge7EBPCAq4uHGm2CdlGaqnrXoiXigeZPCnfP+7i/AFT
 V0nj1xmxkmMMoslEnErCVZk0Aq68npvPygXLdoowvID5rnD3RYgOTl/OzI96V780K2xh
 Op2nNScwvTlKJdW9iX69zi+XoWGskl4U5gESnTHnyIZiVW8PfsOjpkdoHr9/vYqLN18V
 zHnNFmiyDYpNy8DFvXozafsUXY47Dnn2II6HnYZco7U9csFdIouoMqGE7UskAt66GsIP
 0USuGu/NltuNe990L8hOnIwU7Xe0okGRwOXKuWTh7GCPIIrAqduO6mtuwXGDVZf3vK3S
 yGgQ==
X-Gm-Message-State: AOJu0YxwyG0NiEQZ9JmYs0h6BOvbSPgKyaAzGJBHaHCzXN5ie4M+Qp2F
 mz0ghS+TSOupjmytu1wBhrAfVhczUFTxJLsnHzwZNqzRO6oHoUmmeNddxopdg3D0un43NHk7eQ5
 0EnSm7fs659R2M+1M/UqH8b9SshOpILhM1QnV0sb7nM4I4i4u1cfhMGOgE+zcW2lZyfN2W7jd8F
 sxffoJh4AfOnGRMH33TDSfLHaalw==
X-Google-Smtp-Source: AGHT+IH29Mb3545/0C6lseOfjIwxKDX1NukEuMi0xqHjwXJNF/kAwUsPVJTezBGsohIGOYS1RcY+dc9Qfg==
X-Received: from warp10.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:750])
 (user=tavip job=sendgmr) by 2002:a17:902:e5c4:b0:205:66a5:5fc0
 with SMTP id
 d9443c01a7336-20781b2fc94mr11273375ad.2.1726687390780; Wed, 18 Sep 2024
 12:23:10 -0700 (PDT)
Date: Wed, 18 Sep 2024 12:22:36 -0700
In-Reply-To: <20240918192254.3136903-1-tavip@google.com>
Mime-Version: 1.0
References: <20240918192254.3136903-1-tavip@google.com>
X-Mailer: git-send-email 2.46.0.662.g92d0881bb0-goog
Message-ID: <20240918192254.3136903-9-tavip@google.com>
Subject: [PATCH 08/25] hw/i2c: add support for flexcomm i2c
From: Octavian Purdila <tavip@google.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, stefanst@google.com, pbonzini@redhat.com, 
 peter.maydell@linaro.org, marcandre.lureau@redhat.com, berrange@redhat.com, 
 eduardo@habkost.net, luc@lmichel.fr, damien.hedde@dahe.fr, 
 alistair@alistair23.me, thuth@redhat.com, philmd@linaro.org, jsnow@redhat.com, 
 crosa@redhat.com, lvivier@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::549;
 envelope-from=3nijrZgUKCtkO5QDKBJJBG9.7JHL9HP-89Q9GIJIBIP.JMB@flex--tavip.bounces.google.com;
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

Add support for NXP's flexcomm i2c. It does not support slave mode or
DMA.

The patch includes an automatically generated header which contains
the register layout and helpers.

The header can be regenerated with the svd-flexcomm-i2c target when
the build is configured with --enable-mcux-soc-svd.

Signed-off-by: Octavian Purdila <tavip@google.com>
---
 include/hw/arm/svd/flexcomm_i2c.h | 1190 +++++++++++++++++++++++++++++
 include/hw/i2c/flexcomm_i2c.h     |   40 +
 include/hw/misc/flexcomm.h        |    2 +
 hw/i2c/flexcomm_i2c.c             |  250 ++++++
 hw/misc/flexcomm.c                |    3 +
 hw/arm/svd/meson.build            |    3 +
 hw/i2c/meson.build                |    1 +
 hw/i2c/trace-events               |   10 +
 hw/misc/Kconfig                   |    1 +
 9 files changed, 1500 insertions(+)
 create mode 100644 include/hw/arm/svd/flexcomm_i2c.h
 create mode 100644 include/hw/i2c/flexcomm_i2c.h
 create mode 100644 hw/i2c/flexcomm_i2c.c

diff --git a/include/hw/arm/svd/flexcomm_i2c.h b/include/hw/arm/svd/flexcomm_i2c.h
new file mode 100644
index 0000000000..9017d48446
--- /dev/null
+++ b/include/hw/arm/svd/flexcomm_i2c.h
@@ -0,0 +1,1190 @@
+/*
+ * Copyright 2016-2023 NXP SPDX-License-Identifier: BSD-3-Clause
+ *
+ * Automatically generated by svd-gen-header.py from MIMXRT595S_cm33.xml
+ */
+#pragma once
+
+#include "hw/register.h"
+
+/* I2C Bus Interface */
+#define FLEXCOMM_I2C_REGS_NO (1024)
+
+/* Configuration Register */
+REG32(FLEXCOMM_I2C_CFG, 2048);
+/* Master Enable */
+FIELD(FLEXCOMM_I2C_CFG, MSTEN, 0, 1);
+/* Slave Enable */
+FIELD(FLEXCOMM_I2C_CFG, SLVEN, 1, 1);
+/* Monitor Enable */
+FIELD(FLEXCOMM_I2C_CFG, MONEN, 2, 1);
+/* I2C bus Time-out Enable */
+FIELD(FLEXCOMM_I2C_CFG, TIMEOUTEN, 3, 1);
+/* Monitor function Clock Stretching */
+FIELD(FLEXCOMM_I2C_CFG, MONCLKSTR, 4, 1);
+/* High Speed mode Capable enable */
+FIELD(FLEXCOMM_I2C_CFG, HSCAPABLE, 5, 1);
+
+/* Status Register */
+REG32(FLEXCOMM_I2C_STAT, 2052);
+/* Master Pending */
+FIELD(FLEXCOMM_I2C_STAT, MSTPENDING, 0, 1);
+/* Master State code */
+FIELD(FLEXCOMM_I2C_STAT, MSTSTATE, 1, 3);
+/* Master Arbitration Loss flag */
+FIELD(FLEXCOMM_I2C_STAT, MSTARBLOSS, 4, 1);
+/* Master Start/Stop Error flag */
+FIELD(FLEXCOMM_I2C_STAT, MSTSTSTPERR, 6, 1);
+/* Slave Pending */
+FIELD(FLEXCOMM_I2C_STAT, SLVPENDING, 8, 1);
+/* Slave State */
+FIELD(FLEXCOMM_I2C_STAT, SLVSTATE, 9, 2);
+/* Slave Not Stretching */
+FIELD(FLEXCOMM_I2C_STAT, SLVNOTSTR, 11, 1);
+/* Slave address match Index T */
+FIELD(FLEXCOMM_I2C_STAT, SLVIDX, 12, 2);
+/* Slave selected flag */
+FIELD(FLEXCOMM_I2C_STAT, SLVSEL, 14, 1);
+/* Slave Deselected flag */
+FIELD(FLEXCOMM_I2C_STAT, SLVDESEL, 15, 1);
+/* Monitor Ready */
+FIELD(FLEXCOMM_I2C_STAT, MONRDY, 16, 1);
+/* Monitor Overflow flag */
+FIELD(FLEXCOMM_I2C_STAT, MONOV, 17, 1);
+/* Monitor Active flag */
+FIELD(FLEXCOMM_I2C_STAT, MONACTIVE, 18, 1);
+/* Monitor Idle flag */
+FIELD(FLEXCOMM_I2C_STAT, MONIDLE, 19, 1);
+/* Event Time-out Interrupt flag */
+FIELD(FLEXCOMM_I2C_STAT, EVENTTIMEOUT, 24, 1);
+/* SCL Time-out Interrupt flag */
+FIELD(FLEXCOMM_I2C_STAT, SCLTIMEOUT, 25, 1);
+
+/* Interrupt Enable Set Register */
+REG32(FLEXCOMM_I2C_INTENSET, 2056);
+/* Master Pending interrupt Enable */
+FIELD(FLEXCOMM_I2C_INTENSET, MSTPENDINGEN, 0, 1);
+/* Master Arbitration Loss interrupt Enable */
+FIELD(FLEXCOMM_I2C_INTENSET, MSTARBLOSSEN, 4, 1);
+/* Master Start/Stop Error interrupt Enable */
+FIELD(FLEXCOMM_I2C_INTENSET, MSTSTSTPERREN, 6, 1);
+/* Slave Pending interrupt Enable */
+FIELD(FLEXCOMM_I2C_INTENSET, SLVPENDINGEN, 8, 1);
+/* Slave Not Stretching interrupt Enable */
+FIELD(FLEXCOMM_I2C_INTENSET, SLVNOTSTREN, 11, 1);
+/* Slave Deselect interrupt Enable */
+FIELD(FLEXCOMM_I2C_INTENSET, SLVDESELEN, 15, 1);
+/* Monitor data Ready interrupt Enable */
+FIELD(FLEXCOMM_I2C_INTENSET, MONRDYEN, 16, 1);
+/* Monitor Overrun interrupt Enable */
+FIELD(FLEXCOMM_I2C_INTENSET, MONOVEN, 17, 1);
+/* Monitor Idle interrupt Enable */
+FIELD(FLEXCOMM_I2C_INTENSET, MONIDLEEN, 19, 1);
+/* Event Time-out interrupt Enable */
+FIELD(FLEXCOMM_I2C_INTENSET, EVENTTIMEOUTEN, 24, 1);
+/* SCL Time-out interrupt Enable */
+FIELD(FLEXCOMM_I2C_INTENSET, SCLTIMEOUTEN, 25, 1);
+
+/* Interrupt Enable Clear Register */
+REG32(FLEXCOMM_I2C_INTENCLR, 2060);
+/* Master Pending interrupt clear */
+FIELD(FLEXCOMM_I2C_INTENCLR, MSTPENDINGCLR, 0, 1);
+/* Master Arbitration Loss interrupt clear */
+FIELD(FLEXCOMM_I2C_INTENCLR, MSTARBLOSSCLR, 4, 1);
+/* Master Start/Stop Error interrupt clear */
+FIELD(FLEXCOMM_I2C_INTENCLR, MSTSTSTPERRCLR, 6, 1);
+/* Slave Pending interrupt clear */
+FIELD(FLEXCOMM_I2C_INTENCLR, SLVPENDINGCLR, 8, 1);
+/* Slave Not Stretching interrupt clear */
+FIELD(FLEXCOMM_I2C_INTENCLR, SLVNOTSTRCLR, 11, 1);
+/* Slave Deselect interrupt clear */
+FIELD(FLEXCOMM_I2C_INTENCLR, SLVDESELCLR, 15, 1);
+/* Monitor data Ready interrupt clear */
+FIELD(FLEXCOMM_I2C_INTENCLR, MONRDYCLR, 16, 1);
+/* Monitor Overrun interrupt clear */
+FIELD(FLEXCOMM_I2C_INTENCLR, MONOVCLR, 17, 1);
+/* Monitor Idle interrupt clear */
+FIELD(FLEXCOMM_I2C_INTENCLR, MONIDLECLR, 19, 1);
+/* Event time-out interrupt clear */
+FIELD(FLEXCOMM_I2C_INTENCLR, EVENTTIMEOUTCLR, 24, 1);
+/* SCL time-out interrupt clear */
+FIELD(FLEXCOMM_I2C_INTENCLR, SCLTIMEOUTCLR, 25, 1);
+
+/* Time-out Register */
+REG32(FLEXCOMM_I2C_TIMEOUT, 2064);
+/* Time-out time value, the bottom 4 bits */
+FIELD(FLEXCOMM_I2C_TIMEOUT, TOMIN, 0, 4);
+/* Time-out time value */
+FIELD(FLEXCOMM_I2C_TIMEOUT, TO, 4, 12);
+
+/* Clock Divider Register */
+REG32(FLEXCOMM_I2C_CLKDIV, 2068);
+/* Divider Value */
+FIELD(FLEXCOMM_I2C_CLKDIV, DIVVAL, 0, 16);
+
+/* Interrupt Status Register */
+REG32(FLEXCOMM_I2C_INTSTAT, 2072);
+/* Master Pending */
+FIELD(FLEXCOMM_I2C_INTSTAT, MSTPENDING, 0, 1);
+/* Master Arbitration Loss flag */
+FIELD(FLEXCOMM_I2C_INTSTAT, MSTARBLOSS, 4, 1);
+/* Master Start/Stop Error flag */
+FIELD(FLEXCOMM_I2C_INTSTAT, MSTSTSTPERR, 6, 1);
+/* Slave Pending */
+FIELD(FLEXCOMM_I2C_INTSTAT, SLVPENDING, 8, 1);
+/* Slave Not Stretching status */
+FIELD(FLEXCOMM_I2C_INTSTAT, SLVNOTSTR, 11, 1);
+/* Slave Deselected flag */
+FIELD(FLEXCOMM_I2C_INTSTAT, SLVDESEL, 15, 1);
+/* Monitor Ready */
+FIELD(FLEXCOMM_I2C_INTSTAT, MONRDY, 16, 1);
+/* Monitor Overflow flag */
+FIELD(FLEXCOMM_I2C_INTSTAT, MONOV, 17, 1);
+/* Monitor Idle flag */
+FIELD(FLEXCOMM_I2C_INTSTAT, MONIDLE, 19, 1);
+/* Event Time-out Interrupt flag */
+FIELD(FLEXCOMM_I2C_INTSTAT, EVENTTIMEOUT, 24, 1);
+/* SCL Time-out Interrupt flag */
+FIELD(FLEXCOMM_I2C_INTSTAT, SCLTIMEOUT, 25, 1);
+
+/* Master Control Register */
+REG32(FLEXCOMM_I2C_MSTCTL, 2080);
+/* Master Continue(write-only) */
+FIELD(FLEXCOMM_I2C_MSTCTL, MSTCONTINUE, 0, 1);
+/* Master Start control(write-only) */
+FIELD(FLEXCOMM_I2C_MSTCTL, MSTSTART, 1, 1);
+/* Master Stop control(write-only) */
+FIELD(FLEXCOMM_I2C_MSTCTL, MSTSTOP, 2, 1);
+/* Master DMA enable */
+FIELD(FLEXCOMM_I2C_MSTCTL, MSTDMA, 3, 1);
+
+/* Master Timing Register */
+REG32(FLEXCOMM_I2C_MSTTIME, 2084);
+/* Master SCL Low time */
+FIELD(FLEXCOMM_I2C_MSTTIME, MSTSCLLOW, 0, 3);
+/* Master SCL High time */
+FIELD(FLEXCOMM_I2C_MSTTIME, MSTSCLHIGH, 4, 3);
+
+/* Master Data Register */
+REG32(FLEXCOMM_I2C_MSTDAT, 2088);
+/* Master function data register */
+FIELD(FLEXCOMM_I2C_MSTDAT, DATA, 0, 8);
+
+/* Slave Control Register */
+REG32(FLEXCOMM_I2C_SLVCTL, 2112);
+/* Slave Continue */
+FIELD(FLEXCOMM_I2C_SLVCTL, SLVCONTINUE, 0, 1);
+/* Slave NACK */
+FIELD(FLEXCOMM_I2C_SLVCTL, SLVNACK, 1, 1);
+/* Slave DMA enable */
+FIELD(FLEXCOMM_I2C_SLVCTL, SLVDMA, 3, 1);
+/* Automatic Acknowledge */
+FIELD(FLEXCOMM_I2C_SLVCTL, AUTOACK, 8, 1);
+/* Automatic Match Read */
+FIELD(FLEXCOMM_I2C_SLVCTL, AUTOMATCHREAD, 9, 1);
+
+/* Slave Data Register */
+REG32(FLEXCOMM_I2C_SLVDAT, 2116);
+/* Slave function data register */
+FIELD(FLEXCOMM_I2C_SLVDAT, DATA, 0, 8);
+
+/* Slave Address Register */
+REG32(FLEXCOMM_I2C_SLVADR0, 2120);
+/* Slave Address n Disable */
+FIELD(FLEXCOMM_I2C_SLVADR0, SADISABLE, 0, 1);
+/* Slave Address. */
+FIELD(FLEXCOMM_I2C_SLVADR0, SLVADR, 1, 7);
+/* Automatic NACK operation */
+FIELD(FLEXCOMM_I2C_SLVADR0, AUTONACK, 15, 1);
+
+/* Slave Address Register */
+REG32(FLEXCOMM_I2C_SLVADR1, 2124);
+/* Slave Address n Disable */
+FIELD(FLEXCOMM_I2C_SLVADR1, SADISABLE, 0, 1);
+/* Slave Address. */
+FIELD(FLEXCOMM_I2C_SLVADR1, SLVADR, 1, 7);
+/* Automatic NACK operation */
+FIELD(FLEXCOMM_I2C_SLVADR1, AUTONACK, 15, 1);
+
+/* Slave Address Register */
+REG32(FLEXCOMM_I2C_SLVADR2, 2128);
+/* Slave Address n Disable */
+FIELD(FLEXCOMM_I2C_SLVADR2, SADISABLE, 0, 1);
+/* Slave Address. */
+FIELD(FLEXCOMM_I2C_SLVADR2, SLVADR, 1, 7);
+/* Automatic NACK operation */
+FIELD(FLEXCOMM_I2C_SLVADR2, AUTONACK, 15, 1);
+
+/* Slave Address Register */
+REG32(FLEXCOMM_I2C_SLVADR3, 2132);
+/* Slave Address n Disable */
+FIELD(FLEXCOMM_I2C_SLVADR3, SADISABLE, 0, 1);
+/* Slave Address. */
+FIELD(FLEXCOMM_I2C_SLVADR3, SLVADR, 1, 7);
+/* Automatic NACK operation */
+FIELD(FLEXCOMM_I2C_SLVADR3, AUTONACK, 15, 1);
+
+/* Slave Qualification for Address 0 Register */
+REG32(FLEXCOMM_I2C_SLVQUAL0, 2136);
+/* Qualify mode for slave address 0 */
+FIELD(FLEXCOMM_I2C_SLVQUAL0, QUALMODE0, 0, 1);
+/* Slave address Qualifier for address 0 */
+FIELD(FLEXCOMM_I2C_SLVQUAL0, SLVQUAL0, 1, 7);
+
+/* Monitor Receiver Data Register */
+REG32(FLEXCOMM_I2C_MONRXDAT, 2176);
+/* Monitor function Receiver Data */
+FIELD(FLEXCOMM_I2C_MONRXDAT, MONRXDAT, 0, 8);
+/* Monitor Received Start */
+FIELD(FLEXCOMM_I2C_MONRXDAT, MONSTART, 8, 1);
+/* Monitor Received Repeated Start */
+FIELD(FLEXCOMM_I2C_MONRXDAT, MONRESTART, 9, 1);
+/* Monitor Received NACK */
+FIELD(FLEXCOMM_I2C_MONRXDAT, MONNACK, 10, 1);
+
+/* Peripheral Identification Register */
+REG32(FLEXCOMM_I2C_ID, 4092);
+/* Aperture */
+FIELD(FLEXCOMM_I2C_ID, APERTURE, 0, 8);
+/* Minor revision of module implementation */
+FIELD(FLEXCOMM_I2C_ID, MINOR_REV, 8, 4);
+/* Major revision of module implementation */
+FIELD(FLEXCOMM_I2C_ID, MAJOR_REV, 12, 4);
+/* Module identifier for the selected function */
+FIELD(FLEXCOMM_I2C_ID, ID, 16, 16);
+
+
+typedef enum {
+    /*
+     * Disabled. The I2C Master function is disabled. When disabled, the Master
+     * configuration settings are not changed, but the Master function is
+     * internally reset.
+     */
+    FLEXCOMM_I2C_CFG_MSTEN_DISABLED = 0,
+    /* Enabled. The I2C Master function is enabled. */
+    FLEXCOMM_I2C_CFG_MSTEN_ENABLED = 1,
+} FLEXCOMM_I2C_CFG_MSTEN_Enum;
+
+typedef enum {
+    /*
+     * Disabled. The I2C slave function is disabled. When disabled, the Slave
+     * configuration settings are not changed, but the Slave function is
+     * internally reset.
+     */
+    FLEXCOMM_I2C_CFG_SLVEN_DISABLED = 0,
+    /* Enabled. The I2C slave function is enabled. */
+    FLEXCOMM_I2C_CFG_SLVEN_ENABLED = 1,
+} FLEXCOMM_I2C_CFG_SLVEN_Enum;
+
+typedef enum {
+    /*
+     * Disabled. The I2C Monitor function is disabled. When disabled, the
+     * Monitor function configuration settings are not changed, but the Monitor
+     * function is internally reset.
+     */
+    FLEXCOMM_I2C_CFG_MONEN_DISABLED = 0,
+    /* Enabled. The I2C Monitor function is enabled. */
+    FLEXCOMM_I2C_CFG_MONEN_ENABLED = 1,
+} FLEXCOMM_I2C_CFG_MONEN_Enum;
+
+typedef enum {
+    /*
+     * Disabled. The time-out function is disabled. When disabled, the time-out
+     * function is internally reset.
+     */
+    FLEXCOMM_I2C_CFG_TIMEOUTEN_DISABLED = 0,
+    /*
+     * Enabled. The time-out function is enabled. Both types of time-out flags
+     * will be generated and will cause interrupts if those flags are enabled.
+     * Typically, only one time-out flag will be used in a system.
+     */
+    FLEXCOMM_I2C_CFG_TIMEOUTEN_ENABLED = 1,
+} FLEXCOMM_I2C_CFG_TIMEOUTEN_Enum;
+
+typedef enum {
+    /*
+     * Disabled. The Monitor function will not perform clock stretching.
+     * Software or DMA may not always be able to read data provided by the
+     * Monitor function before it (the data) is overwritten. This mode can be
+     * used when non-invasive monitoring is critical.
+     */
+    FLEXCOMM_I2C_CFG_MONCLKSTR_DISABLED = 0,
+    /*
+     * Enabled. The Monitor function will perform clock stretching, to ensure
+     * that the software or DMA can read all incoming data supplied by the
+     * Monitor function.
+     */
+    FLEXCOMM_I2C_CFG_MONCLKSTR_ENABLED = 1,
+} FLEXCOMM_I2C_CFG_MONCLKSTR_Enum;
+
+typedef enum {
+    /* Fast mode Plus enable */
+    FLEXCOMM_I2C_CFG_HSCAPABLE_FAST_MODE_PLUS = 0,
+    /* High Speed mode enable */
+    FLEXCOMM_I2C_CFG_HSCAPABLE_HIGH_SPEED = 1,
+} FLEXCOMM_I2C_CFG_HSCAPABLE_Enum;
+
+typedef enum {
+    /*
+     * In progress. Communication is in progress and the Master function is
+     * busy and cannot currently accept a command.
+     */
+    FLEXCOMM_I2C_STAT_MSTPENDING_IN_PROGRESS = 0,
+    /*
+     * Pending. The Master function needs software service or is in the idle
+     * state. If the master is not in the idle state, then the master is
+     * waiting to receive or transmit data, or is waiting for the NACK bit.
+     */
+    FLEXCOMM_I2C_STAT_MSTPENDING_PENDING = 1,
+} FLEXCOMM_I2C_STAT_MSTPENDING_Enum;
+
+typedef enum {
+    /*
+     * Idle. The Master function is available to be used for a new transaction.
+     */
+    FLEXCOMM_I2C_STAT_MSTSTATE_IDLE = 0,
+    /*
+     * Receive ready. Received data is available (in Master Receiver mode).
+     * Address plus Read was previously sent and Acknowledged by a slave.
+     */
+    FLEXCOMM_I2C_STAT_MSTSTATE_RECEIVE_READY = 1,
+    /*
+     * Transmit ready. Data can be transmitted (in Master Transmitter mode).
+     * Address plus Write was previously sent and Acknowledged by a slave.
+     */
+    FLEXCOMM_I2C_STAT_MSTSTATE_TRANSMIT_READY = 2,
+    /* NACK Address. Slave NACKed address. */
+    FLEXCOMM_I2C_STAT_MSTSTATE_NACK_ADDRESS = 3,
+    /* NACK Data. Slave NACKed transmitted data. */
+    FLEXCOMM_I2C_STAT_MSTSTATE_NACK_DATA = 4,
+} FLEXCOMM_I2C_STAT_MSTSTATE_Enum;
+
+typedef enum {
+    /* No Arbitration Loss has occurred */
+    FLEXCOMM_I2C_STAT_MSTARBLOSS_NO_LOSS = 0,
+    /*
+     * Arbitration loss. The Master function has experienced an Arbitration
+     * Loss. At this point, the Master function has already stopped driving the
+     * bus and has gone into an idle state. Software can respond by doing
+     * nothing, or by sending a Start (to attempt to gain control of the bus
+     * when the bus next becomes idle).
+     */
+    FLEXCOMM_I2C_STAT_MSTARBLOSS_ARBITRATION_LOSS = 1,
+} FLEXCOMM_I2C_STAT_MSTARBLOSS_Enum;
+
+typedef enum {
+    /* No Start/Stop Error has occurred. */
+    FLEXCOMM_I2C_STAT_MSTSTSTPERR_NO_ERROR = 0,
+    /*
+     * The Master function has experienced a Start/Stop Error. A Start or Stop
+     * was detected at a time when Start or Stop is not allowed by the I2C
+     * specification. The Master interface has stopped driving the bus and gone
+     * into an idle state; no action is required. A request for a Start could
+     * be made, or software could attempt to make sure that the bus has not
+     * stalled.
+     */
+    FLEXCOMM_I2C_STAT_MSTSTSTPERR_ERROR = 1,
+} FLEXCOMM_I2C_STAT_MSTSTSTPERR_Enum;
+
+typedef enum {
+    /*
+     * In progress. The Slave function does not currently need software
+     * service.
+     */
+    FLEXCOMM_I2C_STAT_SLVPENDING_IN_PROGRESS = 0,
+    /*
+     * Pending. The Slave function needs software service. Information about
+     * what is needed is in the Slave state field (SLVSTATE).
+     */
+    FLEXCOMM_I2C_STAT_SLVPENDING_PENDING = 1,
+} FLEXCOMM_I2C_STAT_SLVPENDING_Enum;
+
+typedef enum {
+    /*
+     * Slave address. Address plus R/W received. At least one of the 4 slave
+     * addresses has been matched by hardware.
+     */
+    FLEXCOMM_I2C_STAT_SLVSTATE_SLAVE_ADDRESS = 0,
+    /* Slave receive. Received data is available (in Slave Receiver mode). */
+    FLEXCOMM_I2C_STAT_SLVSTATE_SLAVE_RECEIVE = 1,
+    /* Slave transmit. Data can be transmitted (in Slave Transmitter mode). */
+    FLEXCOMM_I2C_STAT_SLVSTATE_SLAVE_TRANSMIT = 2,
+} FLEXCOMM_I2C_STAT_SLVSTATE_Enum;
+
+typedef enum {
+    /*
+     * Stretching. The slave function is currently stretching the I2C bus
+     * clock. Deep-Sleepmode cannot be entered at this time.
+     */
+    FLEXCOMM_I2C_STAT_SLVNOTSTR_STRETCHING = 0,
+    /*
+     * Not stretching. The slave function is not currently stretching the I2C
+     * bus clock. Deep-sleep mode can be entered at this time.
+     */
+    FLEXCOMM_I2C_STAT_SLVNOTSTR_NOT_STRETCHING = 1,
+} FLEXCOMM_I2C_STAT_SLVNOTSTR_Enum;
+
+typedef enum {
+    /* Address 0. Slave address 0 was matched. */
+    FLEXCOMM_I2C_STAT_SLVIDX_ADDRESS0 = 0,
+    /* Address 1. Slave address 1 was matched. */
+    FLEXCOMM_I2C_STAT_SLVIDX_ADDRESS1 = 1,
+    /* Address 2. Slave address 2 was matched. */
+    FLEXCOMM_I2C_STAT_SLVIDX_ADDRESS2 = 2,
+    /* Address 3. Slave address 3 was matched. */
+    FLEXCOMM_I2C_STAT_SLVIDX_ADDRESS3 = 3,
+} FLEXCOMM_I2C_STAT_SLVIDX_Enum;
+
+typedef enum {
+    /* Not selected. The Slave function is not currently selected. */
+    FLEXCOMM_I2C_STAT_SLVSEL_NOT_SELECTED = 0,
+    /* Selected. The Slave function is currently selected. */
+    FLEXCOMM_I2C_STAT_SLVSEL_SELECTED = 1,
+} FLEXCOMM_I2C_STAT_SLVSEL_Enum;
+
+typedef enum {
+    /*
+     * Not deselected. The Slave function has not become deselected. This does
+     * not mean that the Slave is currently selected. That information is in
+     * the SLVSEL flag.
+     */
+    FLEXCOMM_I2C_STAT_SLVDESEL_NOT_DESELECTED = 0,
+    /*
+     * Deselected. The Slave function has become deselected. This is
+     * specifically caused by the SLVSEL flag changing from 1 to 0. See SLVSEL
+     * for details about when that event occurs.
+     */
+    FLEXCOMM_I2C_STAT_SLVDESEL_DESELECTED = 1,
+} FLEXCOMM_I2C_STAT_SLVDESEL_Enum;
+
+typedef enum {
+    /* No data. The Monitor function does not currently have data available. */
+    FLEXCOMM_I2C_STAT_MONRDY_NO_DATA = 0,
+    /* Data waiting. The Monitor function has data waiting to be read. */
+    FLEXCOMM_I2C_STAT_MONRDY_DATA_WAITING = 1,
+} FLEXCOMM_I2C_STAT_MONRDY_Enum;
+
+typedef enum {
+    /* No overrun. Monitor data has not overrun. */
+    FLEXCOMM_I2C_STAT_MONOV_NO_OVERRUN = 0,
+    /*
+     * Overrun. A Monitor data overrun has occurred. An overrun can only happen
+     * when Monitor clock stretching not enabled via the CFG[MONCLKSTR] bit.
+     * Writing 1 to MONOV bit clears the MONOV flag.
+     */
+    FLEXCOMM_I2C_STAT_MONOV_OVERRUN = 1,
+} FLEXCOMM_I2C_STAT_MONOV_Enum;
+
+typedef enum {
+    /* Inactive. The Monitor function considers the I2C bus to be inactive. */
+    FLEXCOMM_I2C_STAT_MONACTIVE_INACTIVE = 0,
+    /* Active. The Monitor function considers the I2C bus to be active. */
+    FLEXCOMM_I2C_STAT_MONACTIVE_ACTIVE = 1,
+} FLEXCOMM_I2C_STAT_MONACTIVE_Enum;
+
+typedef enum {
+    /*
+     * Not idle. The I2C bus is not idle, or MONIDLE flag has been cleared by
+     * software.
+     */
+    FLEXCOMM_I2C_STAT_MONIDLE_NOT_IDLE = 0,
+    /*
+     * Idle. The I2C bus has gone idle at least once, since the last time
+     * MONIDLE flag was cleared by software.
+     */
+    FLEXCOMM_I2C_STAT_MONIDLE_IDLE = 1,
+} FLEXCOMM_I2C_STAT_MONIDLE_Enum;
+
+typedef enum {
+    /* No time-out. I2C bus events have not caused a time-out. */
+    FLEXCOMM_I2C_STAT_EVENTTIMEOUT_NO_TIMEOUT = 0,
+    /*
+     * Event time-out. The time between I2C bus events has been longer than the
+     * time specified by the TIMEOUT register.
+     */
+    FLEXCOMM_I2C_STAT_EVENTTIMEOUT_EVEN_TIMEOUT = 1,
+} FLEXCOMM_I2C_STAT_EVENTTIMEOUT_Enum;
+
+typedef enum {
+    /* No time-out. SCL low time has not caused a time-out. */
+    FLEXCOMM_I2C_STAT_SCLTIMEOUT_NO_TIMEOUT = 0,
+    /* Time-out. SCL low time has caused a time-out. */
+    FLEXCOMM_I2C_STAT_SCLTIMEOUT_TIMEOUT = 1,
+} FLEXCOMM_I2C_STAT_SCLTIMEOUT_Enum;
+
+typedef enum {
+    /* Disabled. The MstPending interrupt is disabled. */
+    FLEXCOMM_I2C_INTENSET_MSTPENDINGEN_DISABLED = 0,
+    /* Enabled. The MstPending interrupt is enabled. */
+    FLEXCOMM_I2C_INTENSET_MSTPENDINGEN_ENABLED = 1,
+} FLEXCOMM_I2C_INTENSET_MSTPENDINGEN_Enum;
+
+typedef enum {
+    /* Disabled. The MstArbLoss interrupt is disabled. */
+    FLEXCOMM_I2C_INTENSET_MSTARBLOSSEN_DISABLED = 0,
+    /* Enabled. The MstArbLoss interrupt is enabled. */
+    FLEXCOMM_I2C_INTENSET_MSTARBLOSSEN_ENABLED = 1,
+} FLEXCOMM_I2C_INTENSET_MSTARBLOSSEN_Enum;
+
+typedef enum {
+    /* Disabled. The MstStStpErr interrupt is disabled. */
+    FLEXCOMM_I2C_INTENSET_MSTSTSTPERREN_DISABLED = 0,
+    /* Enabled. The MstStStpErr interrupt is enabled. */
+    FLEXCOMM_I2C_INTENSET_MSTSTSTPERREN_ENABLED = 1,
+} FLEXCOMM_I2C_INTENSET_MSTSTSTPERREN_Enum;
+
+typedef enum {
+    /* Disabled. The SlvPending interrupt is disabled. */
+    FLEXCOMM_I2C_INTENSET_SLVPENDINGEN_DISABLED = 0,
+    /* Enabled. The SlvPending interrupt is enabled. */
+    FLEXCOMM_I2C_INTENSET_SLVPENDINGEN_ENABLED = 1,
+} FLEXCOMM_I2C_INTENSET_SLVPENDINGEN_Enum;
+
+typedef enum {
+    /* Disabled. The SlvNotStr interrupt is disabled. */
+    FLEXCOMM_I2C_INTENSET_SLVNOTSTREN_DISABLED = 0,
+    /* Enabled. The SlvNotStr interrupt is enabled. */
+    FLEXCOMM_I2C_INTENSET_SLVNOTSTREN_ENABLED = 1,
+} FLEXCOMM_I2C_INTENSET_SLVNOTSTREN_Enum;
+
+typedef enum {
+    /* Disabled. The SlvDeSel interrupt is disabled. */
+    FLEXCOMM_I2C_INTENSET_SLVDESELEN_DISABLED = 0,
+    /* Enabled. The SlvDeSel interrupt is enabled. */
+    FLEXCOMM_I2C_INTENSET_SLVDESELEN_ENABLED = 1,
+} FLEXCOMM_I2C_INTENSET_SLVDESELEN_Enum;
+
+typedef enum {
+    /* Disabled. The MonRdy interrupt is disabled. */
+    FLEXCOMM_I2C_INTENSET_MONRDYEN_DISABLED = 0,
+    /* Enabled. The MonRdy interrupt is enabled. */
+    FLEXCOMM_I2C_INTENSET_MONRDYEN_ENABLED = 1,
+} FLEXCOMM_I2C_INTENSET_MONRDYEN_Enum;
+
+typedef enum {
+    /* Disabled. The MonOv interrupt is disabled. */
+    FLEXCOMM_I2C_INTENSET_MONOVEN_DISABLED = 0,
+    /* Enabled. The MonOv interrupt is enabled. */
+    FLEXCOMM_I2C_INTENSET_MONOVEN_ENABLED = 1,
+} FLEXCOMM_I2C_INTENSET_MONOVEN_Enum;
+
+typedef enum {
+    /* Disabled. The MonIdle interrupt is disabled. */
+    FLEXCOMM_I2C_INTENSET_MONIDLEEN_DISABLED = 0,
+    /* Enabled. The MonIdle interrupt is enabled. */
+    FLEXCOMM_I2C_INTENSET_MONIDLEEN_ENABLED = 1,
+} FLEXCOMM_I2C_INTENSET_MONIDLEEN_Enum;
+
+typedef enum {
+    /* Disabled. The Event time-out interrupt is disabled. */
+    FLEXCOMM_I2C_INTENSET_EVENTTIMEOUTEN_DISABLED = 0,
+    /* Enabled. The Event time-out interrupt is enabled. */
+    FLEXCOMM_I2C_INTENSET_EVENTTIMEOUTEN_ENABLED = 1,
+} FLEXCOMM_I2C_INTENSET_EVENTTIMEOUTEN_Enum;
+
+typedef enum {
+    /* Disabled. The SCL time-out interrupt is disabled. */
+    FLEXCOMM_I2C_INTENSET_SCLTIMEOUTEN_DISABLED = 0,
+    /* Enabled. The SCL time-out interrupt is enabled. */
+    FLEXCOMM_I2C_INTENSET_SCLTIMEOUTEN_ENABLED = 1,
+} FLEXCOMM_I2C_INTENSET_SCLTIMEOUTEN_Enum;
+
+typedef enum {
+    /* No effect on interrupt */
+    FLEXCOMM_I2C_INTENCLR_MSTPENDINGCLR_NO_EFFECT = 0,
+    /* Clears the interrupt bit in INTENSET register */
+    FLEXCOMM_I2C_INTENCLR_MSTPENDINGCLR_CLEAR_MSTPENDING = 1,
+} FLEXCOMM_I2C_INTENCLR_MSTPENDINGCLR_Enum;
+
+typedef enum {
+    /* No effect on interrupt */
+    FLEXCOMM_I2C_INTENCLR_MSTARBLOSSCLR_NO_EFFECT = 0,
+    /* Clears the interrupt bit in INTENSET register */
+    FLEXCOMM_I2C_INTENCLR_MSTARBLOSSCLR_CLEAR_MSTARBLOSS = 1,
+} FLEXCOMM_I2C_INTENCLR_MSTARBLOSSCLR_Enum;
+
+typedef enum {
+    /* No effect on interrupt */
+    FLEXCOMM_I2C_INTENCLR_MSTSTSTPERRCLR_NO_EFFECT = 0,
+    /* Clears the interrupt bit in INTENSET register */
+    FLEXCOMM_I2C_INTENCLR_MSTSTSTPERRCLR_CLEAR_MSTSTSTPERR = 1,
+} FLEXCOMM_I2C_INTENCLR_MSTSTSTPERRCLR_Enum;
+
+typedef enum {
+    /* No effect on interrupt */
+    FLEXCOMM_I2C_INTENCLR_SLVPENDINGCLR_NO_EFFECT = 0,
+    /* Clears the interrupt bit in INTENSET register */
+    FLEXCOMM_I2C_INTENCLR_SLVPENDINGCLR_CLEAR_SLVPENDING = 1,
+} FLEXCOMM_I2C_INTENCLR_SLVPENDINGCLR_Enum;
+
+typedef enum {
+    /* No effect on interrupt */
+    FLEXCOMM_I2C_INTENCLR_SLVNOTSTRCLR_NO_EFFECT = 0,
+    /* Clears the interrupt bit in INTENSET register */
+    FLEXCOMM_I2C_INTENCLR_SLVNOTSTRCLR_CLEAR_SLVNOTSTR = 1,
+} FLEXCOMM_I2C_INTENCLR_SLVNOTSTRCLR_Enum;
+
+typedef enum {
+    /* No effect on interrupt */
+    FLEXCOMM_I2C_INTENCLR_SLVDESELCLR_NO_EFFECT = 0,
+    /* Clears the interrupt bit in INTENSET register */
+    FLEXCOMM_I2C_INTENCLR_SLVDESELCLR_CLEAR_SLVDESEL = 1,
+} FLEXCOMM_I2C_INTENCLR_SLVDESELCLR_Enum;
+
+typedef enum {
+    /* No effect on interrupt */
+    FLEXCOMM_I2C_INTENCLR_MONRDYCLR_NO_EFFECT = 0,
+    /* Clears the interrupt bit in INTENSET register */
+    FLEXCOMM_I2C_INTENCLR_MONRDYCLR_CLEAR_MONRDY = 1,
+} FLEXCOMM_I2C_INTENCLR_MONRDYCLR_Enum;
+
+typedef enum {
+    /* No effect on interrupt */
+    FLEXCOMM_I2C_INTENCLR_MONOVCLR_NO_EFFECT = 0,
+    /* Clears the interrupt bit in INTENSET register */
+    FLEXCOMM_I2C_INTENCLR_MONOVCLR_CLEAR_MONOV = 1,
+} FLEXCOMM_I2C_INTENCLR_MONOVCLR_Enum;
+
+typedef enum {
+    /* No effect on interrupt */
+    FLEXCOMM_I2C_INTENCLR_MONIDLECLR_NO_EFFECT = 0,
+    /* Clears the interrupt bit in INTENSET register */
+    FLEXCOMM_I2C_INTENCLR_MONIDLECLR_CLEAR_MONIDLE = 1,
+} FLEXCOMM_I2C_INTENCLR_MONIDLECLR_Enum;
+
+typedef enum {
+    /* No effect on interrupt */
+    FLEXCOMM_I2C_INTENCLR_EVENTTIMEOUTCLR_NO_EFFECT = 0,
+    /* Clears the interrupt bit in INTENSET register */
+    FLEXCOMM_I2C_INTENCLR_EVENTTIMEOUTCLR_CLEAR_EVENTTIMEOUT = 1,
+} FLEXCOMM_I2C_INTENCLR_EVENTTIMEOUTCLR_Enum;
+
+typedef enum {
+    /* No effect on interrupt */
+    FLEXCOMM_I2C_INTENCLR_SCLTIMEOUTCLR_NO_EFFECT = 0,
+    /* Clears the interrupt bit in INTENSET register */
+    FLEXCOMM_I2C_INTENCLR_SCLTIMEOUTCLR_CLEAR_SCLTIMEOUT = 1,
+} FLEXCOMM_I2C_INTENCLR_SCLTIMEOUTCLR_Enum;
+
+typedef enum {
+    /* A time-out will occur after 16 counts of the I2C function clock. */
+    FLEXCOMM_I2C_TIMEOUT_TO_TIMEOUT16 = 0,
+    /* A time-out will occur after 32 counts of the I2C function clock. */
+    FLEXCOMM_I2C_TIMEOUT_TO_TIMEOUT32 = 1,
+    /* A time-out will occur after 65,536 counts of the I2C function clock. */
+    FLEXCOMM_I2C_TIMEOUT_TO_TIMEOUT65K = 4095,
+} FLEXCOMM_I2C_TIMEOUT_TO_Enum;
+
+typedef enum {
+    /* FCLK is used directly by the I2C. */
+    FLEXCOMM_I2C_CLKDIV_DIVVAL_FCLKUNDIVIDED = 0,
+    /* FCLK is divided by 2 before being used by the I2C. */
+    FLEXCOMM_I2C_CLKDIV_DIVVAL_FCLKDIV2 = 1,
+    /* FCLK is divided by 3 before being used by the I2C. */
+    FLEXCOMM_I2C_CLKDIV_DIVVAL_FCLKDIV3 = 2,
+    /* FCLK is divided by 65,536 before being used by the I2C. */
+    FLEXCOMM_I2C_CLKDIV_DIVVAL_FCLKDIV65K = 65535,
+} FLEXCOMM_I2C_CLKDIV_DIVVAL_Enum;
+
+typedef enum {
+    /* Not active */
+    FLEXCOMM_I2C_INTSTAT_MSTPENDING_MSTPENDING_ISNOTACTIVE = 0,
+    /* Active */
+    FLEXCOMM_I2C_INTSTAT_MSTPENDING_MSTPENDING_ISACTIVE = 1,
+} FLEXCOMM_I2C_INTSTAT_MSTPENDING_Enum;
+
+typedef enum {
+    /* Not active */
+    FLEXCOMM_I2C_INTSTAT_MSTARBLOSS_MSTARBLOSS_ISNOTACTIVE = 0,
+    /* Active */
+    FLEXCOMM_I2C_INTSTAT_MSTARBLOSS_MSTARBLOSS_ISACTIVE = 1,
+} FLEXCOMM_I2C_INTSTAT_MSTARBLOSS_Enum;
+
+typedef enum {
+    /* Not active */
+    FLEXCOMM_I2C_INTSTAT_MSTSTSTPERR_MSTSTSTPERR_ISNOTACTIVE = 0,
+    /* Active */
+    FLEXCOMM_I2C_INTSTAT_MSTSTSTPERR_MSTSTSTPERR_ISACTIVE = 1,
+} FLEXCOMM_I2C_INTSTAT_MSTSTSTPERR_Enum;
+
+typedef enum {
+    /* Not active */
+    FLEXCOMM_I2C_INTSTAT_SLVPENDING_SLVPENDING_ISNOTACTIVE = 0,
+    /* Active */
+    FLEXCOMM_I2C_INTSTAT_SLVPENDING_SLVPENDING_ISACTIVE = 1,
+} FLEXCOMM_I2C_INTSTAT_SLVPENDING_Enum;
+
+typedef enum {
+    /* Not active */
+    FLEXCOMM_I2C_INTSTAT_SLVNOTSTR_SLVNOTSTR_ISNOTACTIVE = 0,
+    /* Active */
+    FLEXCOMM_I2C_INTSTAT_SLVNOTSTR_SLVNOTSTR_ISACTIVE = 1,
+} FLEXCOMM_I2C_INTSTAT_SLVNOTSTR_Enum;
+
+typedef enum {
+    /* Not active */
+    FLEXCOMM_I2C_INTSTAT_SLVDESEL_SLVDESEL_ISNOTACTIVE = 0,
+    /* Active */
+    FLEXCOMM_I2C_INTSTAT_SLVDESEL_SLVDESEL_ISACTIVE = 1,
+} FLEXCOMM_I2C_INTSTAT_SLVDESEL_Enum;
+
+typedef enum {
+    /* Not active */
+    FLEXCOMM_I2C_INTSTAT_MONRDY_MONRDY_ISNOTACTIVE = 0,
+    /* Active */
+    FLEXCOMM_I2C_INTSTAT_MONRDY_MONRDY_ISACTIVE = 1,
+} FLEXCOMM_I2C_INTSTAT_MONRDY_Enum;
+
+typedef enum {
+    /* Not active */
+    FLEXCOMM_I2C_INTSTAT_MONOV_MONOV_ISNOTACTIVE = 0,
+    /* Active */
+    FLEXCOMM_I2C_INTSTAT_MONOV_MONOV_ISACTIVE = 1,
+} FLEXCOMM_I2C_INTSTAT_MONOV_Enum;
+
+typedef enum {
+    /* Not active */
+    FLEXCOMM_I2C_INTSTAT_MONIDLE_MONIDLE_ISNOTACTIVE = 0,
+    /* Active */
+    FLEXCOMM_I2C_INTSTAT_MONIDLE_MONIDLE_ISACTIVE = 1,
+} FLEXCOMM_I2C_INTSTAT_MONIDLE_Enum;
+
+typedef enum {
+    /* Not active */
+    FLEXCOMM_I2C_INTSTAT_EVENTTIMEOUT_EVENTTIMEOUT_ISNOTACTIVE = 0,
+    /* Active */
+    FLEXCOMM_I2C_INTSTAT_EVENTTIMEOUT_EVENTTIMEOUT_ISACTIVE = 1,
+} FLEXCOMM_I2C_INTSTAT_EVENTTIMEOUT_Enum;
+
+typedef enum {
+    /* Not active */
+    FLEXCOMM_I2C_INTSTAT_SCLTIMEOUT_SCLTIMEOUT_ISNOTACTIVE = 0,
+    /* Active */
+    FLEXCOMM_I2C_INTSTAT_SCLTIMEOUT_SCLTIMEOUT_ISACTIVE = 1,
+} FLEXCOMM_I2C_INTSTAT_SCLTIMEOUT_Enum;
+
+typedef enum {
+    /* No effect */
+    FLEXCOMM_I2C_MSTCTL_MSTCONTINUE_NO_EFFECT = 0,
+    /*
+     * Continue. Informs the Master function to continue to the next operation.
+     * This action must done after writing transmit data, reading received
+     * data, or any other housekeeping related to the next bus operation.
+     */
+    FLEXCOMM_I2C_MSTCTL_MSTCONTINUE_CONTINUE = 1,
+} FLEXCOMM_I2C_MSTCTL_MSTCONTINUE_Enum;
+
+typedef enum {
+    /* No effect */
+    FLEXCOMM_I2C_MSTCTL_MSTSTART_NO_EFFECT = 0,
+    /*
+     * Start. A Start will be generated on the I2C bus at the next allowed
+     * time.
+     */
+    FLEXCOMM_I2C_MSTCTL_MSTSTART_START = 1,
+} FLEXCOMM_I2C_MSTCTL_MSTSTART_Enum;
+
+typedef enum {
+    /* No effect */
+    FLEXCOMM_I2C_MSTCTL_MSTSTOP_NO_EFFECT = 0,
+    /*
+     * Stop. A Stop will be generated on the I2C bus at the next allowed time,
+     * preceded by a NACK to the slave if the master is receiving data from the
+     * slave (in Master Receiver mode).
+     */
+    FLEXCOMM_I2C_MSTCTL_MSTSTOP_STOP = 1,
+} FLEXCOMM_I2C_MSTCTL_MSTSTOP_Enum;
+
+typedef enum {
+    /* Disable. No DMA requests are generated for master operation. */
+    FLEXCOMM_I2C_MSTCTL_MSTDMA_DISABLED = 0,
+    /*
+     * Enable. A DMA request is generated for I2C master data operations. When
+     * this I2C master is generating Acknowledge bits in Master Receiver mode,
+     * the acknowledge is generated automatically.
+     */
+    FLEXCOMM_I2C_MSTCTL_MSTDMA_ENABLED = 1,
+} FLEXCOMM_I2C_MSTCTL_MSTDMA_Enum;
+
+typedef enum {
+    /*
+     * 2 clocks. Minimum SCL low time is 2 clocks of the I2C clock pre-divider.
+     */
+    FLEXCOMM_I2C_MSTTIME_MSTSCLLOW_MSTSCLLOW_2CLOCKS = 0,
+    /*
+     * 3 clocks. Minimum SCL low time is 3 clocks of the I2C clock pre-divider.
+     */
+    FLEXCOMM_I2C_MSTTIME_MSTSCLLOW_MSTSCLLOW_3CLOCKS = 1,
+    /*
+     * 4 clocks. Minimum SCL low time is 4 clocks of the I2C clock pre-divider.
+     */
+    FLEXCOMM_I2C_MSTTIME_MSTSCLLOW_MSTSCLLOW_4CLOCKS = 2,
+    /*
+     * 5 clocks. Minimum SCL low time is 5 clocks of the I2C clock pre-divider.
+     */
+    FLEXCOMM_I2C_MSTTIME_MSTSCLLOW_MSTSCLLOW_5CLOCKS = 3,
+    /*
+     * 6 clocks. Minimum SCL low time is 6 clocks of the I2C clock pre-divider.
+     */
+    FLEXCOMM_I2C_MSTTIME_MSTSCLLOW_MSTSCLLOW_6CLOCKS = 4,
+    /*
+     * 7 clocks. Minimum SCL low time is 7 clocks of the I2C clock pre-divider.
+     */
+    FLEXCOMM_I2C_MSTTIME_MSTSCLLOW_MSTSCLLOW_7CLOCKS = 5,
+    /*
+     * 8 clocks. Minimum SCL low time is 8 clocks of the I2C clock pre-divider.
+     */
+    FLEXCOMM_I2C_MSTTIME_MSTSCLLOW_MSTSCLLOW_8CLOCKS = 6,
+    /*
+     * 9 clocks. Minimum SCL low time is 9 clocks of the I2C clock pre-divider.
+     */
+    FLEXCOMM_I2C_MSTTIME_MSTSCLLOW_MSTSCLLOW_9CLOCKS = 7,
+} FLEXCOMM_I2C_MSTTIME_MSTSCLLOW_Enum;
+
+typedef enum {
+    /*
+     * 2 clocks. Minimum SCL high time is 2 clocks of the I2C clock
+     * pre-divider.
+     */
+    FLEXCOMM_I2C_MSTTIME_MSTSCLHIGH_MSTSCLHIGH_2CLOCKS = 0,
+    /*
+     * 3 clocks. Minimum SCL high time is 3 clocks of the I2C clock pre-divider
+     * .
+     */
+    FLEXCOMM_I2C_MSTTIME_MSTSCLHIGH_MSTSCLHIGH_3CLOCKS = 1,
+    /*
+     * 4 clocks. Minimum SCL high time is 4 clocks of the I2C clock
+     * pre-divider.
+     */
+    FLEXCOMM_I2C_MSTTIME_MSTSCLHIGH_MSTSCLHIGH_4CLOCKS = 2,
+    /*
+     * 5 clocks. Minimum SCL high time is 5 clocks of the I2C clock
+     * pre-divider.
+     */
+    FLEXCOMM_I2C_MSTTIME_MSTSCLHIGH_MSTSCLHIGH_5CLOCKS = 3,
+    /*
+     * 6 clocks. Minimum SCL high time is 6 clocks of the I2C clock
+     * pre-divider.
+     */
+    FLEXCOMM_I2C_MSTTIME_MSTSCLHIGH_MSTSCLHIGH_6CLOCKS = 4,
+    /*
+     * 7 clocks. Minimum SCL high time is 7 clocks of the I2C clock
+     * pre-divider.
+     */
+    FLEXCOMM_I2C_MSTTIME_MSTSCLHIGH_MSTSCLHIGH_7CLOCKS = 5,
+    /*
+     * 8 clocks. Minimum SCL high time is 8 clocks of the I2C clock
+     * pre-divider.
+     */
+    FLEXCOMM_I2C_MSTTIME_MSTSCLHIGH_MSTSCLHIGH_8CLOCKS = 6,
+    /*
+     * 9 clocks. Minimum SCL high time is 9 clocks of the I2C clock
+     * pre-divider.
+     */
+    FLEXCOMM_I2C_MSTTIME_MSTSCLHIGH_MSTSCLHIGH_9CLOCKS = 7,
+} FLEXCOMM_I2C_MSTTIME_MSTSCLHIGH_Enum;
+
+typedef enum {
+    /* No effect */
+    FLEXCOMM_I2C_SLVCTL_SLVCONTINUE_NO_EFFECT = 0,
+    /*
+     * Continue. Informs the Slave function to continue to the next operation,
+     * by clearing the STAT[SLVPENDING] flag. This must be done after writing
+     * transmit data, reading received data, or any other housekeeping related
+     * to the next bus operation. Automatic Operation has different
+     * requirements. SLVCONTINUE should not be set unless SLVPENDING = 1.
+     */
+    FLEXCOMM_I2C_SLVCTL_SLVCONTINUE_CONTINUE = 1,
+} FLEXCOMM_I2C_SLVCTL_SLVCONTINUE_Enum;
+
+typedef enum {
+    /* No effect */
+    FLEXCOMM_I2C_SLVCTL_SLVNACK_NO_EFFECT = 0,
+    /*
+     * NACK. Causes the Slave function to NACK the master when the slave is
+     * receiving data from the master (in Slave Receiver mode).
+     */
+    FLEXCOMM_I2C_SLVCTL_SLVNACK_NACK = 1,
+} FLEXCOMM_I2C_SLVCTL_SLVNACK_Enum;
+
+typedef enum {
+    /* Disabled. No DMA requests are issued for Slave mode operation. */
+    FLEXCOMM_I2C_SLVCTL_SLVDMA_DISABLED = 0,
+    /*
+     * Enabled. DMA requests are issued for I2C slave data transmission and
+     * reception.
+     */
+    FLEXCOMM_I2C_SLVCTL_SLVDMA_ENABLED = 1,
+} FLEXCOMM_I2C_SLVCTL_SLVDMA_Enum;
+
+typedef enum {
+    /*
+     * Normal, non-automatic operation. If AUTONACK = 0, then a SlvPending
+     * interrupt is generated when a matching address is received. If AUTONACK
+     * = 1, then received addresses are NACKed (ignored).
+     */
+    FLEXCOMM_I2C_SLVCTL_AUTOACK_NORMAL = 0,
+    /*
+     * A header with matching SLVADR0 and matching direction as set by
+     * AUTOMATCHREAD will be ACKed immediately, allowing the master to move on
+     * to the data bytes. If the address matches SLVADR0, but the direction
+     * does not match AUTOMATCHREAD, then the behavior will depend on the
+     * SLVADR0[AUTONACK] bit: if AUTONACK is set, then it will be Nacked; if
+     * AUTONACK is clear, then a SlvPending interrupt is generated.
+     */
+    FLEXCOMM_I2C_SLVCTL_AUTOACK_AUTOMATIC_ACK = 1,
+} FLEXCOMM_I2C_SLVCTL_AUTOACK_Enum;
+
+typedef enum {
+    /* In Automatic Mode, the expected next operation is an I2C write. */
+    FLEXCOMM_I2C_SLVCTL_AUTOMATCHREAD_I2C_WRITE = 0,
+    /* In Automatic Mode, the expected next operation is an I2C read. */
+    FLEXCOMM_I2C_SLVCTL_AUTOMATCHREAD_I2C_READ = 1,
+} FLEXCOMM_I2C_SLVCTL_AUTOMATCHREAD_Enum;
+
+typedef enum {
+    /* Enabled. Slave Address n is enabled. */
+    FLEXCOMM_I2C_SLVADR0_SADISABLE_ENABLED = 0,
+    /* Ignored. Slave Address n is ignored. */
+    FLEXCOMM_I2C_SLVADR0_SADISABLE_DISABLED = 1,
+} FLEXCOMM_I2C_SLVADR0_SADISABLE_Enum;
+
+typedef enum {
+    /* Normal operation, matching I2C addresses are not ignored. */
+    FLEXCOMM_I2C_SLVADR0_AUTONACK_NORMAL = 0,
+    /*
+     * Automatic-only mode. All incoming addresses are ignored (NACKed), unless
+     * AUTOACK is set, and the address matches SLVADRn, and AUTOMATCHREAD
+     * matches the direction.
+     */
+    FLEXCOMM_I2C_SLVADR0_AUTONACK_AUTOMATIC = 1,
+} FLEXCOMM_I2C_SLVADR0_AUTONACK_Enum;
+
+typedef enum {
+    /* Enabled. Slave Address n is enabled. */
+    FLEXCOMM_I2C_SLVADR1_SADISABLE_ENABLED = 0,
+    /* Ignored. Slave Address n is ignored. */
+    FLEXCOMM_I2C_SLVADR1_SADISABLE_DISABLED = 1,
+} FLEXCOMM_I2C_SLVADR1_SADISABLE_Enum;
+
+typedef enum {
+    /* Normal operation, matching I2C addresses are not ignored. */
+    FLEXCOMM_I2C_SLVADR1_AUTONACK_NORMAL = 0,
+    /*
+     * Automatic-only mode. All incoming addresses are ignored (NACKed), unless
+     * AUTOACK is set, and the address matches SLVADRn, and AUTOMATCHREAD
+     * matches the direction.
+     */
+    FLEXCOMM_I2C_SLVADR1_AUTONACK_AUTOMATIC = 1,
+} FLEXCOMM_I2C_SLVADR1_AUTONACK_Enum;
+
+typedef enum {
+    /* Enabled. Slave Address n is enabled. */
+    FLEXCOMM_I2C_SLVADR2_SADISABLE_ENABLED = 0,
+    /* Ignored. Slave Address n is ignored. */
+    FLEXCOMM_I2C_SLVADR2_SADISABLE_DISABLED = 1,
+} FLEXCOMM_I2C_SLVADR2_SADISABLE_Enum;
+
+typedef enum {
+    /* Normal operation, matching I2C addresses are not ignored. */
+    FLEXCOMM_I2C_SLVADR2_AUTONACK_NORMAL = 0,
+    /*
+     * Automatic-only mode. All incoming addresses are ignored (NACKed), unless
+     * AUTOACK is set, and the address matches SLVADRn, and AUTOMATCHREAD
+     * matches the direction.
+     */
+    FLEXCOMM_I2C_SLVADR2_AUTONACK_AUTOMATIC = 1,
+} FLEXCOMM_I2C_SLVADR2_AUTONACK_Enum;
+
+typedef enum {
+    /* Enabled. Slave Address n is enabled. */
+    FLEXCOMM_I2C_SLVADR3_SADISABLE_ENABLED = 0,
+    /* Ignored. Slave Address n is ignored. */
+    FLEXCOMM_I2C_SLVADR3_SADISABLE_DISABLED = 1,
+} FLEXCOMM_I2C_SLVADR3_SADISABLE_Enum;
+
+typedef enum {
+    /* Normal operation, matching I2C addresses are not ignored. */
+    FLEXCOMM_I2C_SLVADR3_AUTONACK_NORMAL = 0,
+    /*
+     * Automatic-only mode. All incoming addresses are ignored (NACKed), unless
+     * AUTOACK is set, and the address matches SLVADRn, and AUTOMATCHREAD
+     * matches the direction.
+     */
+    FLEXCOMM_I2C_SLVADR3_AUTONACK_AUTOMATIC = 1,
+} FLEXCOMM_I2C_SLVADR3_AUTONACK_Enum;
+
+typedef enum {
+    /*
+     * Mask. The SLVQUAL0 field is used as a logical mask for matching address
+     * 0.
+     */
+    FLEXCOMM_I2C_SLVQUAL0_QUALMODE0_MASK = 0,
+    /*
+     * Extend. The SLVQUAL0 field is used to extend address 0 matching in a
+     * range of addresses.
+     */
+    FLEXCOMM_I2C_SLVQUAL0_QUALMODE0_EXTEND = 1,
+} FLEXCOMM_I2C_SLVQUAL0_QUALMODE0_Enum;
+
+typedef enum {
+    /*
+     * No start detected. The Monitor function has not detected a Start event
+     * on the I2C bus.
+     */
+    FLEXCOMM_I2C_MONRXDAT_MONSTART_NO_START_DETECTED = 0,
+    /*
+     * Start detected. The Monitor function has detected a Start event on the
+     * I2C bus.
+     */
+    FLEXCOMM_I2C_MONRXDAT_MONSTART_START_DETECTED = 1,
+} FLEXCOMM_I2C_MONRXDAT_MONSTART_Enum;
+
+typedef enum {
+    /*
+     * No repeated start detected. The Monitor function has not detected a
+     * Repeated Start event on the I2C bus.
+     */
+    FLEXCOMM_I2C_MONRXDAT_MONRESTART_NOT_DETECTED = 0,
+    /*
+     * Repeated start detected. The Monitor function has detected a Repeated
+     * Start event on the I2C bus.
+     */
+    FLEXCOMM_I2C_MONRXDAT_MONRESTART_DETECTED = 1,
+} FLEXCOMM_I2C_MONRXDAT_MONRESTART_Enum;
+
+typedef enum {
+    /*
+     * Acknowledged. The data currently being provided by the Monitor function
+     * was acknowledged by at least one master or slave receiver.
+     */
+    FLEXCOMM_I2C_MONRXDAT_MONNACK_ACKNOWLEDGED = 0,
+    /*
+     * Not acknowledged. The data currently being provided by the Monitor
+     * function was not acknowledged by any receiver.
+     */
+    FLEXCOMM_I2C_MONRXDAT_MONNACK_NOT_ACKNOWLEDGED = 1,
+} FLEXCOMM_I2C_MONRXDAT_MONNACK_Enum;
+
+
+#define FLEXCOMM_I2C_REGISTER_ACCESS_INFO_ARRAY(_name) \
+    struct RegisterAccessInfo _name[FLEXCOMM_I2C_REGS_NO] = { \
+        [0 ... FLEXCOMM_I2C_REGS_NO - 1] = { \
+            .name = "", \
+            .addr = -1, \
+        }, \
+        [R_FLEXCOMM_I2C_CFG] = { \
+            .name = "CFG", \
+            .addr = 0x800, \
+            .ro = 0xFFFFFFC0, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXCOMM_I2C_STAT] = { \
+            .name = "STAT", \
+            .addr = 0x804, \
+            .ro = 0xFCF57FAF, \
+            .reset = 0x801, \
+        }, \
+        [R_FLEXCOMM_I2C_INTENSET] = { \
+            .name = "INTENSET", \
+            .addr = 0x808, \
+            .ro = 0xFCF476AE, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXCOMM_I2C_INTENCLR] = { \
+            .name = "INTENCLR", \
+            .addr = 0x80C, \
+            .ro = 0xFCF476AE, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXCOMM_I2C_TIMEOUT] = { \
+            .name = "TIMEOUT", \
+            .addr = 0x810, \
+            .ro = 0xFFFF0000, \
+            .reset = 0xFFFF, \
+        }, \
+        [R_FLEXCOMM_I2C_CLKDIV] = { \
+            .name = "CLKDIV", \
+            .addr = 0x814, \
+            .ro = 0xFFFF0000, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXCOMM_I2C_INTSTAT] = { \
+            .name = "INTSTAT", \
+            .addr = 0x818, \
+            .ro = 0xFFFFFFFF, \
+            .reset = 0x801, \
+        }, \
+        [R_FLEXCOMM_I2C_MSTCTL] = { \
+            .name = "MSTCTL", \
+            .addr = 0x820, \
+            .ro = 0xFFFFFFF0, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXCOMM_I2C_MSTTIME] = { \
+            .name = "MSTTIME", \
+            .addr = 0x824, \
+            .ro = 0xFFFFFF88, \
+            .reset = 0x77, \
+        }, \
+        [R_FLEXCOMM_I2C_MSTDAT] = { \
+            .name = "MSTDAT", \
+            .addr = 0x828, \
+            .ro = 0xFFFFFF00, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXCOMM_I2C_SLVCTL] = { \
+            .name = "SLVCTL", \
+            .addr = 0x840, \
+            .ro = 0xFFFFFCF4, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXCOMM_I2C_SLVDAT] = { \
+            .name = "SLVDAT", \
+            .addr = 0x844, \
+            .ro = 0xFFFFFF00, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXCOMM_I2C_SLVADR0] = { \
+            .name = "SLVADR0", \
+            .addr = 0x848, \
+            .ro = 0xFFFF7F00, \
+            .reset = 0x1, \
+        }, \
+        [R_FLEXCOMM_I2C_SLVADR1] = { \
+            .name = "SLVADR1", \
+            .addr = 0x84C, \
+            .ro = 0xFFFF7F00, \
+            .reset = 0x1, \
+        }, \
+        [R_FLEXCOMM_I2C_SLVADR2] = { \
+            .name = "SLVADR2", \
+            .addr = 0x850, \
+            .ro = 0xFFFF7F00, \
+            .reset = 0x1, \
+        }, \
+        [R_FLEXCOMM_I2C_SLVADR3] = { \
+            .name = "SLVADR3", \
+            .addr = 0x854, \
+            .ro = 0xFFFF7F00, \
+            .reset = 0x1, \
+        }, \
+        [R_FLEXCOMM_I2C_SLVQUAL0] = { \
+            .name = "SLVQUAL0", \
+            .addr = 0x858, \
+            .ro = 0xFFFFFF00, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXCOMM_I2C_MONRXDAT] = { \
+            .name = "MONRXDAT", \
+            .addr = 0x880, \
+            .ro = 0xFFFFFFFF, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXCOMM_I2C_ID] = { \
+            .name = "ID", \
+            .addr = 0xFFC, \
+            .ro = 0xFFFFFFFF, \
+            .reset = 0xE0301300, \
+        }, \
+    }
diff --git a/include/hw/i2c/flexcomm_i2c.h b/include/hw/i2c/flexcomm_i2c.h
new file mode 100644
index 0000000000..7b27e333d7
--- /dev/null
+++ b/include/hw/i2c/flexcomm_i2c.h
@@ -0,0 +1,40 @@
+/*
+ * QEMU model for NXP's FLEXCOMM I2C
+ *
+ * Copyright (c) 2024 Google LLC
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef HW_FLEXCOMM_I2C_H
+#define HW_FLEXCOMM_I2C_H
+
+#include "hw/i2c/i2c.h"
+#include "hw/misc/flexcomm_function.h"
+
+#define TYPE_FLEXCOMM_I2C "flexcomm-i2c"
+OBJECT_DECLARE_TYPE(FlexcommI2cState, FlexcommI2cClass, FLEXCOMM_I2C);
+
+struct FlexcommI2cState {
+    FlexcommFunction parent_obj;
+
+    I2CBus *bus;
+};
+
+struct FlexcommI2cClass {
+    FlexcommFunctionClass parent_obj;
+
+    FlexcommFunctionSelect select;
+};
+
+#define MSTSTATE_IDLE 0
+#define MSTSTATE_RXRDY 1
+#define MSTSTATE_TXRDY 2
+#define MSTSTATE_NAKADR 3
+#define MSTSTATE_NAKDAT 4
+
+
+#endif /* HW_FLEXCOMM_I2C_H */
diff --git a/include/hw/misc/flexcomm.h b/include/hw/misc/flexcomm.h
index 679b7ea64d..c9f1cd3890 100644
--- a/include/hw/misc/flexcomm.h
+++ b/include/hw/misc/flexcomm.h
@@ -16,6 +16,7 @@
 #include "hw/arm/svd/flexcomm.h"
 #include "qemu/fifo32.h"
 #include "hw/char/flexcomm_usart.h"
+#include "hw/i2c/flexcomm_i2c.h"
 
 #define FLEXCOMM_FUNC_USART     0
 #define FLEXCOMM_FUNC_SPI       1
@@ -48,6 +49,7 @@ struct FlexcommState {
     Fifo32 rx_fifo;
     Fifo32 tx_fifo;
     FlexcommUsartState usart;
+    FlexcommI2cState i2c;
 };
 
 #endif /* HW_FLEXCOMM_H */
diff --git a/hw/i2c/flexcomm_i2c.c b/hw/i2c/flexcomm_i2c.c
new file mode 100644
index 0000000000..e5341ec241
--- /dev/null
+++ b/hw/i2c/flexcomm_i2c.c
@@ -0,0 +1,250 @@
+/*
+ * QEMU model for NXP's FLEXCOMM I2C
+ *
+ * Copyright (c) 2024 Google LLC
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/cutils.h"
+#include "hw/irq.h"
+#include "hw/qdev-properties.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "exec/address-spaces.h"
+#include "qapi/error.h"
+#include "trace.h"
+#include "hw/i2c/flexcomm_i2c.h"
+#include "hw/arm/svd/flexcomm_i2c.h"
+
+#define REG(s, reg) (s->regs[R_FLEXCOMM_I2C_##reg])
+#define RF_WR(s, reg, field, val) \
+    ARRAY_FIELD_DP32(s->regs, FLEXCOMM_I2C_##reg, field, val)
+#define RF_RD(s, reg, field) \
+    ARRAY_FIELD_EX32(s->regs, FLEXCOMM_I2C_##reg, field)
+
+static FLEXCOMM_I2C_REGISTER_ACCESS_INFO_ARRAY(reg_info);
+
+static void flexcomm_i2c_reset(FlexcommFunction *f)
+{
+    for (int i = 0; i < FLEXCOMM_I2C_REGS_NO; i++) {
+        hwaddr addr = reg_info[i].addr;
+
+        if (addr != -1) {
+            struct RegisterInfo ri = {
+                .data = &f->regs[addr / 4],
+                .data_size = 4,
+                .access = &reg_info[i],
+            };
+
+            register_reset(&ri);
+        }
+    }
+}
+
+static void flexcomm_i2c_irq_update(FlexcommFunction *f)
+{
+    bool enabled = RF_RD(f, CFG, MSTEN);
+    bool irq, per_irqs;
+
+    REG(f, INTSTAT) = REG(f, STAT) & REG(f, INTENSET);
+    per_irqs = REG(f, INTSTAT) != 0;
+
+    irq = enabled && per_irqs;
+
+    trace_flexcomm_i2c_irq(DEVICE(f)->id, irq, per_irqs, enabled);
+    flexcomm_set_irq(f, irq);
+}
+
+static MemTxResult flexcomm_i2c_reg_read(void *opaque, hwaddr addr,
+                                         uint64_t *data, unsigned size,
+                                         MemTxAttrs attrs)
+{
+    FlexcommFunction *f = FLEXCOMM_FUNCTION(opaque);
+    MemTxResult ret = MEMTX_OK;
+    const struct RegisterAccessInfo *rai = &reg_info[addr / 4];
+
+    if (size != 4) {
+        ret = MEMTX_ERROR;
+        goto out;
+    }
+
+    *data = f->regs[addr / 4];
+
+    flexcomm_i2c_irq_update(f);
+
+out:
+    trace_flexcomm_i2c_reg_read(DEVICE(f)->id, rai->name, addr, *data);
+    return ret;
+}
+
+static MemTxResult flexcomm_i2c_reg_write(void *opaque, hwaddr addr,
+                                          uint64_t value, unsigned size,
+                                          MemTxAttrs attrs)
+{
+    FlexcommFunction *f = FLEXCOMM_FUNCTION(opaque);
+    FlexcommI2cState *s = FLEXCOMM_I2C(opaque);
+    const struct RegisterAccessInfo *rai = &reg_info[addr / 4];
+    struct RegisterInfo ri = {
+        .data = &f->regs[addr / 4],
+        .data_size = 4,
+        .access = rai,
+    };
+
+    trace_flexcomm_i2c_reg_write(DEVICE(f)->id, rai->name, addr, value);
+
+    if (size != 4) {
+        return MEMTX_ERROR;
+    }
+
+    switch (addr) {
+    case A_FLEXCOMM_I2C_CFG:
+    {
+        register_write(&ri, value, ~0, NULL, false);
+        if (RF_RD(f, CFG, SLVEN)) {
+            qemu_log_mask(LOG_GUEST_ERROR, "I2C slave not supported");
+        }
+        if (RF_RD(f, CFG, MONEN)) {
+            qemu_log_mask(LOG_GUEST_ERROR, "I2C monitoring not supported");
+        }
+        break;
+    }
+    case A_FLEXCOMM_I2C_INTENCLR:
+    {
+        REG(f, INTENSET) &= ~value;
+        break;
+    }
+    case A_FLEXCOMM_I2C_TIMEOUT:
+    {
+        register_write(&ri, value, ~0, NULL, false);
+        /* The bottom 4 bits are hard-wired to 0xF */
+        RF_WR(f, TIMEOUT, TOMIN, 0xf);
+        break;
+    }
+    case A_FLEXCOMM_I2C_MSTCTL:
+    {
+        register_write(&ri, value, ~0, NULL, false);
+        if (RF_RD(f, MSTCTL, MSTSTART)) {
+            uint8_t i2c_addr = RF_RD(f, MSTDAT, DATA);
+            bool recv = i2c_addr & 1;
+
+            trace_flexcomm_i2c_start(DEVICE(s)->id, i2c_addr, recv);
+            if (i2c_start_transfer(s->bus, i2c_addr, recv)) {
+                RF_WR(f, STAT, MSTSTATE, MSTSTATE_NAKADR);
+                trace_flexcomm_i2c_nak(DEVICE(s)->id);
+            } else {
+                if (recv) {
+                    uint8_t data = i2c_recv(s->bus);
+
+                    RF_WR(f, MSTDAT, DATA, data);
+                    trace_flexcomm_i2c_rx(DEVICE(s)->id, data);
+                    RF_WR(f, STAT, MSTSTATE, MSTSTATE_RXRDY);
+                } else {
+                    RF_WR(f, STAT, MSTSTATE, MSTSTATE_TXRDY);
+                }
+            }
+        }
+        if (RF_RD(f, MSTCTL, MSTSTOP)) {
+            RF_WR(f, STAT, MSTSTATE, MSTSTATE_IDLE);
+            i2c_end_transfer(s->bus);
+        }
+        if (RF_RD(f, MSTCTL, MSTCONTINUE)) {
+            if (RF_RD(f, STAT, MSTSTATE) == MSTSTATE_TXRDY) {
+                uint8_t data = RF_RD(f, MSTDAT, DATA);
+
+                trace_flexcomm_i2c_tx(DEVICE(s)->id, data);
+                if (i2c_send(s->bus, data)) {
+                    RF_WR(f, STAT, MSTSTATE, MSTSTATE_NAKDAT);
+                }
+            } else if (RF_RD(f, STAT, MSTSTATE) == MSTSTATE_RXRDY) {
+                uint8_t data = i2c_recv(s->bus);
+
+                RF_WR(f, MSTDAT, DATA, data);
+                trace_flexcomm_i2c_rx(DEVICE(s)->id, data);
+            }
+        }
+        break;
+    }
+    case A_FLEXCOMM_I2C_STAT:
+    {
+        /* write 1 to clear bits */
+        REG(f, STAT) &= ~value;
+        break;
+    }
+    case A_FLEXCOMM_I2C_SLVCTL:
+    case A_FLEXCOMM_I2C_SLVDAT:
+    case A_FLEXCOMM_I2C_SLVADR0:
+    case A_FLEXCOMM_I2C_SLVADR1:
+    case A_FLEXCOMM_I2C_SLVADR2:
+    case A_FLEXCOMM_I2C_SLVADR3:
+    case A_FLEXCOMM_I2C_SLVQUAL0:
+    {
+        qemu_log_mask(LOG_GUEST_ERROR, "I2C slave not supported\n");
+        break;
+    }
+    default:
+        register_write(&ri, value, ~0, NULL, false);
+        break;
+    }
+
+    flexcomm_i2c_irq_update(f);
+
+    return MEMTX_OK;
+}
+
+static void flexcomm_i2c_select(FlexcommFunction *f, bool selected)
+{
+    FlexcommI2cClass *ic = FLEXCOMM_I2C_GET_CLASS(f);
+
+    if (selected) {
+        flexcomm_i2c_reset(f);
+    }
+    ic->select(f, selected);
+}
+
+static const MemoryRegionOps flexcomm_i2c_ops = {
+    .read_with_attrs = flexcomm_i2c_reg_read,
+    .write_with_attrs = flexcomm_i2c_reg_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+        .unaligned = false,
+    },
+};
+
+static void flexcomm_i2c_realize(DeviceState *dev, Error **errp)
+{
+    FlexcommI2cState *s = FLEXCOMM_I2C(dev);
+
+    s->bus = i2c_init_bus(DEVICE(s), "bus");
+}
+
+static void flexcomm_i2c_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    FlexcommFunctionClass *fc = FLEXCOMM_FUNCTION_CLASS(klass);
+    FlexcommI2cClass *ic = FLEXCOMM_I2C_CLASS(klass);
+
+    dc->realize = flexcomm_i2c_realize;
+    ic->select = fc->select;
+    fc->select = flexcomm_i2c_select;
+    fc->name = "i2c";
+    fc->mmio_ops = &flexcomm_i2c_ops;
+}
+
+static const TypeInfo flexcomm_i2c_types[] = {
+    {
+        .name          = TYPE_FLEXCOMM_I2C,
+        .parent        = TYPE_FLEXCOMM_FUNCTION,
+        .instance_size = sizeof(FlexcommI2cState),
+        .class_init    = flexcomm_i2c_class_init,
+        .class_size    = sizeof(FlexcommI2cClass),
+    },
+};
+
+DEFINE_TYPES(flexcomm_i2c_types);
diff --git a/hw/misc/flexcomm.c b/hw/misc/flexcomm.c
index a291148f27..b1a2f01acf 100644
--- a/hw/misc/flexcomm.c
+++ b/hw/misc/flexcomm.c
@@ -24,6 +24,7 @@
 #include "hw/misc/flexcomm.h"
 #include "hw/arm/svd/flexcomm_usart.h"
 #include "hw/char/flexcomm_usart.h"
+#include "hw/i2c/flexcomm_i2c.h"
 
 #define REG(s, reg) (s->regs[R_FLEXCOMM_##reg])
 #define RF_WR(s, reg, field, val) \
@@ -220,6 +221,7 @@ static void flexcomm_init(Object *obj)
     sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->container);
     sysbus_init_irq(sbd, &s->irq);
     object_initialize_child(obj, "usart", &s->usart, TYPE_FLEXCOMM_USART);
+    object_initialize_child(obj, "i2c", &s->i2c, TYPE_FLEXCOMM_I2C);
 }
 
 static void flexcomm_finalize(Object *obj)
@@ -250,6 +252,7 @@ static void flexcomm_realize(DeviceState *dev, Error **errp)
 
     memory_region_add_subregion_overlap(&s->container, 0, &s->mmio, -1);
     flexcomm_func_realize_and_unref(FLEXCOMM_FUNCTION(&s->usart), errp);
+    flexcomm_func_realize_and_unref(FLEXCOMM_FUNCTION(&s->i2c), errp);
 }
 
 static const VMStateDescription vmstate_flexcomm = {
diff --git a/hw/arm/svd/meson.build b/hw/arm/svd/meson.build
index 2bde34d15b..417491cd5c 100644
--- a/hw/arm/svd/meson.build
+++ b/hw/arm/svd/meson.build
@@ -7,4 +7,7 @@ if get_option('mcux-soc-svd')
   run_target('svd-flexcomm-usart', command: svd_gen_header +
     [ '-i', rt595, '-o', '@SOURCE_ROOT@/include/hw/arm/svd/flexcomm_usart.h',
     '-p', 'USART0', '-t', 'FLEXCOMM_USART'])
+  run_target('svd-flexcomm-i2c', command: svd_gen_header +
+    [ '-i', rt595, '-o', '@SOURCE_ROOT@/include/hw/arm/svd/flexcomm_i2c.h',
+      '-p', 'I2C0', '-t', 'FLEXCOMM_I2C'])
 endif
diff --git a/hw/i2c/meson.build b/hw/i2c/meson.build
index c459adcb59..e7d79e6938 100644
--- a/hw/i2c/meson.build
+++ b/hw/i2c/meson.build
@@ -18,4 +18,5 @@ i2c_ss.add(when: 'CONFIG_PPC4XX', if_true: files('ppc4xx_i2c.c'))
 i2c_ss.add(when: 'CONFIG_PCA954X', if_true: files('i2c_mux_pca954x.c'))
 i2c_ss.add(when: 'CONFIG_PMBUS', if_true: files('pmbus_device.c'))
 i2c_ss.add(when: 'CONFIG_BCM2835_I2C', if_true: files('bcm2835_i2c.c'))
+i2c_ss.add(when: 'CONFIG_FLEXCOMM', if_true: files('flexcomm_i2c.c'))
 system_ss.add_all(when: 'CONFIG_I2C', if_true: i2c_ss)
diff --git a/hw/i2c/trace-events b/hw/i2c/trace-events
index 6900e06eda..9f0175fab7 100644
--- a/hw/i2c/trace-events
+++ b/hw/i2c/trace-events
@@ -51,3 +51,13 @@ npcm7xx_smbus_recv_fifo(const char *id, uint8_t received, uint8_t expected) "%s
 
 pca954x_write_bytes(uint8_t value) "PCA954X write data: 0x%02x"
 pca954x_read_data(uint8_t value) "PCA954X read data: 0x%02x"
+
+# flexcomm_i2c.c
+
+flexcomm_i2c_reg_read(const char *id, const char *reg_name, uint32_t addr, uint32_t val) " %s: %s[0x%04x] -> 0x%08x"
+flexcomm_i2c_reg_write(const char *id, const char *reg_name, uint32_t addr, uint32_t val) "%s: %s[0x%04x] <- 0x%08x"
+flexcomm_i2c_start(const char *id, uint8_t addr, uint8_t recv) "%s: 0x%02x %d"
+flexcomm_i2c_rx(const char *id, uint8_t data) "%s: <- 0x%02x"
+flexcomm_i2c_tx(const char *id, uint8_t data) "%s: -> 0x%02x"
+flexcomm_i2c_nak(const char *id) "%s: <- nak"
+flexcomm_i2c_irq(const char *id, bool irq, bool perirqs, bool enabled) "%s: %d %d %d"
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 14167ae9e8..9a244fa01d 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -215,5 +215,6 @@ config XLNX_VERSAL_TRNG
 
 config FLEXCOMM
     bool
+    select I2C
 
 source macio/Kconfig
-- 
2.46.0.662.g92d0881bb0-goog


