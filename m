Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D8C1C02185
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2025 21:03:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZyur-0001xU-Ax; Mon, 20 Jan 2025 16:02:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tZyua-0001cK-96
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 16:02:22 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tZyuW-0002wD-Mv
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 16:02:19 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5d9f0a6adb4so9995931a12.1
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2025 13:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737406935; x=1738011735; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oWOWHYCR1Up3N6CQ+zs5ErSlqDqJEtYq0Ac6711jAJE=;
 b=wyWpY3rR9KQYuZUnINPqXmPOQGY2NENLUIlrlJOERruEY2NDcXDuYEWawxhq2pknKm
 DR4TAXIhGhR0BPaEA/LQYr9YnCJEuuV00wU43b85igpxMATgIrGluj0O9FVs7DUX70av
 S7knR0ay/zteYiyIgXBoSBjdJhLPiIFs9f2GemJsjhfgiH+HMqTKO7ZM3aAjsQkj17f1
 3EBwNigUbJZTwljXekud3mRHc8ttm9auq8287BkXULacy5TrymCetjH6hT5sA2EHLNb2
 scNODD6SWpOqNrZLppuZkiM0p9r2aU3b9pImSmOhSSiQ9G7aGFNjjFL/9a79zE/LVk8Y
 r9Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737406935; x=1738011735;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oWOWHYCR1Up3N6CQ+zs5ErSlqDqJEtYq0Ac6711jAJE=;
 b=q9nEN/1SCIwp2D/MI7Jw7js5hzhbnKpHLQY0qCjFhPQCWGud3epX6v1ZXlASc42Ac1
 Vpw/Y1rHvUmwXmhk3vBk1NC+g3lYuk3h+rbGPMAKCCenf2pMSNQ16bWdjrKltf+hnGfz
 B64fobKE8W/0WPKju2WMVfTYGvQ9P93VJpkAWD5ZZB/zYc9CkprCk7Gow2RUavV81eEt
 VDvKu2LpqdS4JHWP6mNdrvnXyl4UZULpUdktgjTuhxNdi7RKDupZSRPagSb1DNJI9C2H
 kT6GhPGjjVYDw8fEARR4EahyUwdMIZGW3DLxdNv4T2NJL2DKxNXMq/MIes8OQ6fR6887
 VXfA==
X-Gm-Message-State: AOJu0YzFRKC616+rM+0eP4Xx1cp0lKUw3ymEpNkqy1c3ey6IQ19hTtOL
 EIkALX3T/m2Nmd6OV+Zm4tfI1sTM5HQe+CMAv3y4d3TiMTbKLFnmKhZqskIlZNpgQS6E9bMFBY9
 AKho=
X-Gm-Gg: ASbGnctKmoBgkm1J4NZEGMqSFKxYpG8525afZ2jsbcxCAjIy5IksExb3BCldu/3LLKX
 1J5yRby15KlRRn9gDJGvYEdS/7/CcpLrXTu87WBViB7MznvnnvStMq987LgPi0QkBMmhQ1ZpOvF
 yT3H7CPAXk9Oa6B6EK3/3o5hmmrMlGzdXYiqIoqD/5UUbllzZLok0aKEkAnwbvRrJJrz26by9L7
 aZnJUmkGmxujS7i5B6C4W50sT3T3NSDerGGftj4/Gqlgvbvqg58t8LKjMX13jn7BFrK
X-Google-Smtp-Source: AGHT+IErDS/5Wt7zJKLNVZ6e9Jeu/zsDBi4d6zj/1XSL66rmmb4TsVnqSJn6Wkx+5YLipE7odzfXkg==
X-Received: by 2002:a05:6402:5194:b0:5d4:3105:c929 with SMTP id
 4fb4d7f45d1cf-5db7db07853mr14025988a12.23.1737406934983; 
 Mon, 20 Jan 2025 13:02:14 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5db73edbaffsm6178874a12.66.2025.01.20.13.02.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2025 13:02:14 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 11BFD5F9D8;
 Mon, 20 Jan 2025 21:02:13 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, qemu-arm@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 2/7] tests/qtest: don't attempt to clock_step while waiting
 for virtio ISR
Date: Mon, 20 Jan 2025 21:02:07 +0000
Message-Id: <20250120210212.3890255-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250120210212.3890255-1-alex.bennee@linaro.org>
References: <20250120210212.3890255-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52e.google.com
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

This replicates the changes from 92cb8f8bf6 (tests/qtest: remove
clock_steps from virtio tests) as there are no timers in the virtio
code. We still busy wait and timeout though.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/qtest/libqos/virtio-pci-modern.c | 6 ++----
 tests/qtest/libqos/virtio-pci.c        | 6 ++----
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/tests/qtest/libqos/virtio-pci-modern.c b/tests/qtest/libqos/virtio-pci-modern.c
index 18d118866f..f6e3e32891 100644
--- a/tests/qtest/libqos/virtio-pci-modern.c
+++ b/tests/qtest/libqos/virtio-pci-modern.c
@@ -173,13 +173,11 @@ static bool get_config_isr_status(QVirtioDevice *d)
 
 static void wait_config_isr_status(QVirtioDevice *d, gint64 timeout_us)
 {
-    QVirtioPCIDevice *dev = container_of(d, QVirtioPCIDevice, vdev);
     gint64 start_time = g_get_monotonic_time();
 
-    do {
+    while (!get_config_isr_status(d)) {
         g_assert(g_get_monotonic_time() - start_time <= timeout_us);
-        qtest_clock_step(dev->pdev->bus->qts, 100);
-    } while (!get_config_isr_status(d));
+    } 
 }
 
 static void queue_select(QVirtioDevice *d, uint16_t index)
diff --git a/tests/qtest/libqos/virtio-pci.c b/tests/qtest/libqos/virtio-pci.c
index 485b8f6b7e..002bf8b8c2 100644
--- a/tests/qtest/libqos/virtio-pci.c
+++ b/tests/qtest/libqos/virtio-pci.c
@@ -171,13 +171,11 @@ static bool qvirtio_pci_get_config_isr_status(QVirtioDevice *d)
 static void qvirtio_pci_wait_config_isr_status(QVirtioDevice *d,
                                                gint64 timeout_us)
 {
-    QVirtioPCIDevice *dev = container_of(d, QVirtioPCIDevice, vdev);
     gint64 start_time = g_get_monotonic_time();
 
-    do {
+    while (!qvirtio_pci_get_config_isr_status(d)) {
         g_assert(g_get_monotonic_time() - start_time <= timeout_us);
-        qtest_clock_step(dev->pdev->bus->qts, 100);
-    } while (!qvirtio_pci_get_config_isr_status(d));
+    }
 }
 
 static void qvirtio_pci_queue_select(QVirtioDevice *d, uint16_t index)
-- 
2.39.5


