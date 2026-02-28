Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 404BCFEE4EE
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Feb 2026 18:23:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwOy6-0005E6-OT; Sat, 28 Feb 2026 13:23:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <visitorckw@gmail.com>)
 id 1vwOy1-0005DI-BD
 for qemu-devel@nongnu.org; Sat, 28 Feb 2026 13:23:05 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <visitorckw@gmail.com>)
 id 1vwOxz-0002pT-E6
 for qemu-devel@nongnu.org; Sat, 28 Feb 2026 13:23:05 -0500
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-824a829f9bbso1460642b3a.0
 for <qemu-devel@nongnu.org>; Sat, 28 Feb 2026 10:23:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772302982; x=1772907782; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=df8v64vKr9GL2MFEEjx8VlY0YbTzSnpQefqjrHPWyJw=;
 b=ZAH4YpG+viR20jNcfmPPcbcRX5q9br2enddmGOyYPk5XQn65RshahBWZAYiWhD1TR7
 awC7+PMkpRwEOU6KKuIvMBTgfHvkr+QFaSfFbCcWo0l/51gytYK0vdJCPhnnBSlKJaCU
 /9funWpv3+RIUhPPxDQFLSawpnkJARh/HJ+UflaqGWwc7PD4jCYMfsXdvldUb/dhAENV
 uU8CdY2s3rWSwnCEgmcsP2uHHlpABLerC1FfOSJUo81yZ9U/vlluU3Te3+CldrDaQh5k
 10T3+NPYimykFNYn2O2g+hYMhtZEKXxESMimf2CcIHNxQpiLNyHUXvYdCiGsLulOL83n
 tAxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772302982; x=1772907782;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=df8v64vKr9GL2MFEEjx8VlY0YbTzSnpQefqjrHPWyJw=;
 b=nvh/ZN+AjXG8WWE/lfhcG45SOHebPLO4xTfRJGX6YVPmPuo6eIBLDMuG4fSoFlHeoo
 BlMiryPniXXcgvEpQR8EKdJNh2lLjGhyHkpruYJ+lPC+draLCHcTlqcfptZ6QNB0uNue
 AqSWTVd+ETZ4yvbt8SR8AWsd3xZ8PNqbwxghNcRVEfm06delHr/gKsmJdY2pWh6bSkZS
 tyIUnplu/vWxa6K4/zMWokI8HpN3zkVlUONpPNnVC6hp6Bp0H+sO8dKFVqN4IaUKrrcu
 y9p+t6gMKhyHX3P2DeAHRw7+GzD6NDPoqPzpEeGmWN1tQeTcx1bO2GpmqQ4Qrg6m+df+
 E8zQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfAqFeQ4djzy9NBJc9SLBE9N2wzjDPv6NFerp/9f/iea5JfykpUxIdS8kzH890wY/VBnVmn1keqSpV@nongnu.org
X-Gm-Message-State: AOJu0YwH/ZMsTS+R8rGH2+72ZZSATPcRllyB2riQYCOsG3OA6+CyFYXh
 eSZWSghyhv3qzDSeo8oWESOlKp2wvZtR1dCr8x9uIWx7092z5GoO15IF
X-Gm-Gg: ATEYQzwSgOqz3GzxFXmsAWVmscDGa5LfuqjKeT6lWyh9no0ZZgCpYzA4+9cuU6EOH8m
 76VvdTTU2S0xuuiO1cVsy8jwCAQ+/ePYyKlf0fUslgWXEYJPtsphx7AyxRtxld+wi2q1SL3n1Dk
 ROZqSJvi+4/ebHM4KHOgwg7SpoZOrg1r4FK2d1PNu/oAysMaIDg/p8sU5ywLeNkbLwTmYztOjau
 b3vazWONlp149kcnRoxFjfqXQM7DhE/wlyFXYymEVGthoJBEcn6eoP2jI9F1FIDo8VYYwwKF1+3
 LFEt0+WVOU+W/XADh2+VW/S3rRo/q8vw+K+vbPV6c+jfB/nwWCSfPL4xbfz0cDC/VKk3JtR276P
 pKbHiHGrVrZjc9x+SNw8IDVEsArLXH/LNK/KpVFzoXvz09N4M02zj3vtNoqqeXRAxTs9kynkqfC
 xbqTZGbGMUNSfUhkh47u3BYeEnRiLUeuUiyWKdbDWBkLagIIMa4pDWQT9cNrS5oQiyoe7Z8B/km
 2l+MZhSMwPnwTBbZshuPQInAg7NyWxlVBJ5
X-Received: by 2002:a05:6a00:4c99:b0:827:37ef:7321 with SMTP id
 d2e1a72fcca58-8274d92e069mr5862902b3a.8.1772302981939; 
 Sat, 28 Feb 2026 10:23:01 -0800 (PST)
Received: from visitorckw-work01.c.googlers.com.com
 (7.162.199.104.bc.googleusercontent.com. [104.199.162.7])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8273a05e831sm8731008b3a.58.2026.02.28.10.23.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Feb 2026 10:23:01 -0800 (PST)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: pbonzini@redhat.com,
	mst@redhat.com,
	cohuck@redhat.com
Cc: eleanor15x@gmail.com, jserv@ccns.ncku.edu.tw, qemu-devel@nongnu.org,
 Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH 1/2] standard-headers: Add virtio_rtc.h from Linux 7.0-rc1
Date: Sat, 28 Feb 2026 18:22:45 +0000
Message-ID: <20260228182246.700714-2-visitorckw@gmail.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
In-Reply-To: <20260228182246.700714-1-visitorckw@gmail.com>
References: <20260228182246.700714-1-visitorckw@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=visitorckw@gmail.com; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add virtio_rtc.h from the upstream Linux kernel using
scripts/update-linux-headers.sh.

Source:
- Linux commit 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f (v7.0-rc1)
- Author: Linus Torvalds <torvalds@linux-foundation.org>
- Date:   Sun Feb 22 13:18:59 2026 -0800

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 include/standard-headers/linux/virtio_rtc.h | 237 ++++++++++++++++++++
 1 file changed, 237 insertions(+)
 create mode 100644 include/standard-headers/linux/virtio_rtc.h

diff --git a/include/standard-headers/linux/virtio_rtc.h b/include/standard-headers/linux/virtio_rtc.h
new file mode 100644
index 0000000000..7e2c21ebff
--- /dev/null
+++ b/include/standard-headers/linux/virtio_rtc.h
@@ -0,0 +1,237 @@
+/* SPDX-License-Identifier: ((GPL-2.0+ WITH Linux-syscall-note) OR BSD-3-Clause) */
+/*
+ * Copyright (C) 2022-2024 OpenSynergy GmbH
+ * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef _LINUX_VIRTIO_RTC_H
+#define _LINUX_VIRTIO_RTC_H
+
+#include "standard-headers/linux/types.h"
+
+/* alarm feature */
+#define VIRTIO_RTC_F_ALARM	0
+
+/* read request message types */
+
+#define VIRTIO_RTC_REQ_READ			0x0001
+#define VIRTIO_RTC_REQ_READ_CROSS		0x0002
+
+/* control request message types */
+
+#define VIRTIO_RTC_REQ_CFG			0x1000
+#define VIRTIO_RTC_REQ_CLOCK_CAP		0x1001
+#define VIRTIO_RTC_REQ_CROSS_CAP		0x1002
+#define VIRTIO_RTC_REQ_READ_ALARM		0x1003
+#define VIRTIO_RTC_REQ_SET_ALARM		0x1004
+#define VIRTIO_RTC_REQ_SET_ALARM_ENABLED	0x1005
+
+/* alarmq message types */
+
+#define VIRTIO_RTC_NOTIF_ALARM			0x2000
+
+/* Message headers */
+
+/** common request header */
+struct virtio_rtc_req_head {
+	uint16_t msg_type;
+	uint8_t reserved[6];
+};
+
+/** common response header */
+struct virtio_rtc_resp_head {
+#define VIRTIO_RTC_S_OK			0
+#define VIRTIO_RTC_S_EOPNOTSUPP		2
+#define VIRTIO_RTC_S_ENODEV		3
+#define VIRTIO_RTC_S_EINVAL		4
+#define VIRTIO_RTC_S_EIO		5
+	uint8_t status;
+	uint8_t reserved[7];
+};
+
+/** common notification header */
+struct virtio_rtc_notif_head {
+	uint16_t msg_type;
+	uint8_t reserved[6];
+};
+
+/* read requests */
+
+/* VIRTIO_RTC_REQ_READ message */
+
+struct virtio_rtc_req_read {
+	struct virtio_rtc_req_head head;
+	uint16_t clock_id;
+	uint8_t reserved[6];
+};
+
+struct virtio_rtc_resp_read {
+	struct virtio_rtc_resp_head head;
+	uint64_t clock_reading;
+};
+
+/* VIRTIO_RTC_REQ_READ_CROSS message */
+
+struct virtio_rtc_req_read_cross {
+	struct virtio_rtc_req_head head;
+	uint16_t clock_id;
+/* Arm Generic Timer Counter-timer Virtual Count Register (CNTVCT_EL0) */
+#define VIRTIO_RTC_COUNTER_ARM_VCT	0
+/* x86 Time-Stamp Counter */
+#define VIRTIO_RTC_COUNTER_X86_TSC	1
+/* Invalid */
+#define VIRTIO_RTC_COUNTER_INVALID	0xFF
+	uint8_t hw_counter;
+	uint8_t reserved[5];
+};
+
+struct virtio_rtc_resp_read_cross {
+	struct virtio_rtc_resp_head head;
+	uint64_t clock_reading;
+	uint64_t counter_cycles;
+};
+
+/* control requests */
+
+/* VIRTIO_RTC_REQ_CFG message */
+
+struct virtio_rtc_req_cfg {
+	struct virtio_rtc_req_head head;
+	/* no request params */
+};
+
+struct virtio_rtc_resp_cfg {
+	struct virtio_rtc_resp_head head;
+	/** # of clocks -> clock ids < num_clocks are valid */
+	uint16_t num_clocks;
+	uint8_t reserved[6];
+};
+
+/* VIRTIO_RTC_REQ_CLOCK_CAP message */
+
+struct virtio_rtc_req_clock_cap {
+	struct virtio_rtc_req_head head;
+	uint16_t clock_id;
+	uint8_t reserved[6];
+};
+
+struct virtio_rtc_resp_clock_cap {
+	struct virtio_rtc_resp_head head;
+#define VIRTIO_RTC_CLOCK_UTC			0
+#define VIRTIO_RTC_CLOCK_TAI			1
+#define VIRTIO_RTC_CLOCK_MONOTONIC		2
+#define VIRTIO_RTC_CLOCK_UTC_SMEARED		3
+#define VIRTIO_RTC_CLOCK_UTC_MAYBE_SMEARED	4
+	uint8_t type;
+#define VIRTIO_RTC_SMEAR_UNSPECIFIED	0
+#define VIRTIO_RTC_SMEAR_NOON_LINEAR	1
+#define VIRTIO_RTC_SMEAR_UTC_SLS	2
+	uint8_t leap_second_smearing;
+#define VIRTIO_RTC_FLAG_ALARM_CAP		(1 << 0)
+	uint8_t flags;
+	uint8_t reserved[5];
+};
+
+/* VIRTIO_RTC_REQ_CROSS_CAP message */
+
+struct virtio_rtc_req_cross_cap {
+	struct virtio_rtc_req_head head;
+	uint16_t clock_id;
+	uint8_t hw_counter;
+	uint8_t reserved[5];
+};
+
+struct virtio_rtc_resp_cross_cap {
+	struct virtio_rtc_resp_head head;
+#define VIRTIO_RTC_FLAG_CROSS_CAP	(1 << 0)
+	uint8_t flags;
+	uint8_t reserved[7];
+};
+
+/* VIRTIO_RTC_REQ_READ_ALARM message */
+
+struct virtio_rtc_req_read_alarm {
+	struct virtio_rtc_req_head head;
+	uint16_t clock_id;
+	uint8_t reserved[6];
+};
+
+struct virtio_rtc_resp_read_alarm {
+	struct virtio_rtc_resp_head head;
+	uint64_t alarm_time;
+#define VIRTIO_RTC_FLAG_ALARM_ENABLED	(1 << 0)
+	uint8_t flags;
+	uint8_t reserved[7];
+};
+
+/* VIRTIO_RTC_REQ_SET_ALARM message */
+
+struct virtio_rtc_req_set_alarm {
+	struct virtio_rtc_req_head head;
+	uint64_t alarm_time;
+	uint16_t clock_id;
+	/* flag VIRTIO_RTC_FLAG_ALARM_ENABLED */
+	uint8_t flags;
+	uint8_t reserved[5];
+};
+
+struct virtio_rtc_resp_set_alarm {
+	struct virtio_rtc_resp_head head;
+	/* no response params */
+};
+
+/* VIRTIO_RTC_REQ_SET_ALARM_ENABLED message */
+
+struct virtio_rtc_req_set_alarm_enabled {
+	struct virtio_rtc_req_head head;
+	uint16_t clock_id;
+	/* flag VIRTIO_RTC_ALARM_ENABLED */
+	uint8_t flags;
+	uint8_t reserved[5];
+};
+
+struct virtio_rtc_resp_set_alarm_enabled {
+	struct virtio_rtc_resp_head head;
+	/* no response params */
+};
+
+/** Union of request types for requestq */
+union virtio_rtc_req_requestq {
+	struct virtio_rtc_req_read read;
+	struct virtio_rtc_req_read_cross read_cross;
+	struct virtio_rtc_req_cfg cfg;
+	struct virtio_rtc_req_clock_cap clock_cap;
+	struct virtio_rtc_req_cross_cap cross_cap;
+	struct virtio_rtc_req_read_alarm read_alarm;
+	struct virtio_rtc_req_set_alarm set_alarm;
+	struct virtio_rtc_req_set_alarm_enabled set_alarm_enabled;
+};
+
+/** Union of response types for requestq */
+union virtio_rtc_resp_requestq {
+	struct virtio_rtc_resp_read read;
+	struct virtio_rtc_resp_read_cross read_cross;
+	struct virtio_rtc_resp_cfg cfg;
+	struct virtio_rtc_resp_clock_cap clock_cap;
+	struct virtio_rtc_resp_cross_cap cross_cap;
+	struct virtio_rtc_resp_read_alarm read_alarm;
+	struct virtio_rtc_resp_set_alarm set_alarm;
+	struct virtio_rtc_resp_set_alarm_enabled set_alarm_enabled;
+};
+
+/* alarmq notifications */
+
+/* VIRTIO_RTC_NOTIF_ALARM notification */
+
+struct virtio_rtc_notif_alarm {
+	struct virtio_rtc_notif_head head;
+	uint16_t clock_id;
+	uint8_t reserved[6];
+};
+
+/** Union of notification types for alarmq */
+union virtio_rtc_notif_alarmq {
+	struct virtio_rtc_notif_alarm alarm;
+};
+
+#endif /* _LINUX_VIRTIO_RTC_H */
-- 
2.53.0.473.g4a7958ca14-goog


