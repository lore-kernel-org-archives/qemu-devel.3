Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11383CD98C5
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2026 19:11:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYqDS-0000NF-0V; Sun, 14 Jun 2026 15:09:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqCr-0007PB-PP
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:09:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqCp-0002Tm-I8
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:09:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781464154;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QZNUnahvC+4HEfCF2Lnl65IlITe2u76Ii/lnMqZAtNU=;
 b=Ay5u/Md9YkSFRxT7gtihn47BnNWJrNz4/aFdvczdiTPyTjQlzOKf/NOxZVRHyaWAw/c2tI
 NblTeveqmmrWi3eUnzj1e8VsyWk3ix2um5IAYiUlwZK8DoUqq74Jo86d9O+Q4l7idkbrKN
 90XguSGxXDwhPr2gu0EvWjL8RJF6hRU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-f0R_O-6AMwKZxDzzCYuPxA-1; Sun, 14 Jun 2026 15:09:13 -0400
X-MC-Unique: f0R_O-6AMwKZxDzzCYuPxA-1
X-Mimecast-MFC-AGG-ID: f0R_O-6AMwKZxDzzCYuPxA_1781464152
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-490b9318944so16621035e9.1
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 12:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781464152; x=1782068952; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=QZNUnahvC+4HEfCF2Lnl65IlITe2u76Ii/lnMqZAtNU=;
 b=XQf/f8lz9mnaXkUsGtfqg+AnHgGVpI+5a1zA5u3S4u0oAW1jWHKrtp4jhlhH/kvbxL
 MZlyi6M9BqGPiRjqkq/HwVCrJsHojfN9/IkSxsRLy2c3aIUiKsOHYOr7kleCctpylpKn
 F6FzMhlQC3sWi5m/eJ6+PDPtoE93i4OAj7dB/z/CaJt+eul9yAzOVRt+vjMkYQcAexPZ
 bqJKTzqXmcCcYC+4Z1FQjJlv1EhGX02FhupRG3G/E+gUsx18X2/YKdgQ7G0uYVkn5HMh
 yOoXLXoa2PsOxVzRlaKzObUc4m33WADkK4u0dzkOlURLpvwuuy+dY+kf5ZITTZkpLHJi
 LrhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781464152; x=1782068952;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QZNUnahvC+4HEfCF2Lnl65IlITe2u76Ii/lnMqZAtNU=;
 b=ZUWksvTfZYLIDmT42c3Dm7T4TmIimB9irF8t8VhhEYYUP8uNUJJzybvmgcLEUGa+ia
 1+HNwlgPGiGk3n3dpQ6JewZwcMGRov7bs7lXc7GVjHR5cJ1kI9+L9SDgPoLTp7d9hLTN
 2MLlhZcSN0hIDyhf15IIJ5pGROQ/fjgRZGvYWxlRe0qpjwgjSiRVnAkAoj7nJCkgvGzI
 UwhVVOB8q3r0lOpvplIt9Ur6/tMG489UIllyQuuHTOebkTUTiGfvGGPt8KfvLBTRVQ+O
 oIlHwRxDesOniSiJTjih5fzcZNkZUmQoAZYjBnM3XsdR0Amnv4cU0wO04cwj4AAsDHVF
 wnMg==
X-Gm-Message-State: AOJu0YwtrItAL3fL8kRlInw57O/8Hr4MGiC3X8GqEzJATo7lw6CGB9ma
 5/YZtjmuzngOzhfiwOspQIjiYr/AoCcruNIUDZtwRFojOk1qGTdPX12PT76vfsiN9fuComNFrNL
 nrds1yMCj3NdVKnMMsDMGXH2X6CzoFXrtQHuHFZyjPTQRCi3X70YZCnT4bgGthdi3AwBLrMi466
 +i/dpjgbw7dAH+GMIBn7eHCk+IQzzPM7pOAw==
X-Gm-Gg: Acq92OEgXVi1ba2xJLZDb1SZg1Z2Z0mlEFSY4Vm5h1gTIW0tfBF0XnbHlMQZAin+UYK
 jmFRMLZ/+TH29J/zTJUeYlGPJH14uwNG190MAiuwcdwVyn/ezKGq7I1CHRCiFxyu1m69Y+d3hZI
 V6tywxkQ+M3Dc7Yoc2uIvNXUvKAN1hgiiqNE5p8r/I1YAoDgjwy+aqALmFSx39tCEN/qO7WCv5G
 on7mV9soSe36kn8/yY83GTtOaNcW/0dSY62tHltEX2sa/RaF2JFr7HssrQ/QjgJNceW5ZsxkuI+
 E1Vyrvn78MNghNmfNZYw3g3MjxzHKNPQxeOcdg53uWib3+6Pt0yvzsyiLDfUKZfHq0jbQoVrS1h
 QsZkb9lFgAQdrKAXX7T+8K+wH75IivOqu8NPCsQIIquA=
X-Received: by 2002:a05:600c:4685:b0:490:9bc2:bf8b with SMTP id
 5b1f17b1804b1-490ec4cd13amr166634435e9.5.1781464152270; 
 Sun, 14 Jun 2026 12:09:12 -0700 (PDT)
X-Received: by 2002:a05:600c:4685:b0:490:9bc2:bf8b with SMTP id
 5b1f17b1804b1-490ec4cd13amr166634045e9.5.1781464151707; 
 Sun, 14 Jun 2026 12:09:11 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4922033156csm174007305e9.7.2026.06.14.12.09.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 12:09:11 -0700 (PDT)
Date: Sun, 14 Jun 2026 15:09:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Kuan-Wei Chiu <visitorckw@gmail.com>, Cornelia Huck <cohuck@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 082/106] standard-headers: Add virtio_rtc.h from Linux 7.0-rc1
Message-ID: <5341284a7cbadb19fa61dadb643475d3aef2f5a3.1781463125.git.mst@redhat.com>
References: <cover.1781463125.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1781463125.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Kuan-Wei Chiu <visitorckw@gmail.com>

Add virtio_rtc.h from the upstream Linux kernel using
scripts/update-linux-headers.sh.

Source:
- Linux commit 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f (v7.0-rc1)
- Author: Linus Torvalds <torvalds@linux-foundation.org>
- Date:   Sun Feb 22 13:18:59 2026 -0800

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260228182246.700714-2-visitorckw@gmail.com>
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
MST


