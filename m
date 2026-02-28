Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55563FEE4F4
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Feb 2026 18:23:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwOy4-0005DX-PF; Sat, 28 Feb 2026 13:23:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <visitorckw@gmail.com>)
 id 1vwOxz-0005D9-AC
 for qemu-devel@nongnu.org; Sat, 28 Feb 2026 13:23:04 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <visitorckw@gmail.com>)
 id 1vwOxx-0002pH-9u
 for qemu-devel@nongnu.org; Sat, 28 Feb 2026 13:23:02 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-824c9da9928so1783437b3a.3
 for <qemu-devel@nongnu.org>; Sat, 28 Feb 2026 10:23:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772302979; x=1772907779; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QgV6ZARykMQbwWvfCLVUKLn5yAr2oZc/px37pTAjLSo=;
 b=gTPKk8qLkHbwyKy6aH5FR0SPUVoXRUBGf9l9bH9WdpMabQq88mp89OKM1ZsYSKH7OR
 jHyp/XqnOEpTO/XFmcTnx30xR6Hno1RXRzq5CYCx4MZhtAA2ETs3KedEBztxTzLsfxUy
 ChByxojbBw9FVef8lFP4Z5olpp1C0gyMw0KpG84qF4edXXAVHIK+FaeuOwpWf75k4OZK
 H/2guUpfxOTIMNOVr3/Cv4+KbJvv60tQSdHTg0a0LzTt0KByWHzGvM1uygS/CHhBTS2B
 2mIbCekK3sisyuX0VlLrMexUy6RS0ZXp26qE9IUEHdYts9clL4xAadNMHvNfMQGzorq/
 I+rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772302979; x=1772907779;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QgV6ZARykMQbwWvfCLVUKLn5yAr2oZc/px37pTAjLSo=;
 b=QRbA+U5OxDVO5OiDkceNz513VRlf1Y07k688JyJxlLkQFWLaxIxJ5xUeB5EcsXV3/D
 BmHZDvs651mhh82jzmmHRFdadYs6Bz15SEOyWzlAty/9BIXDhVVVplMTKwcp8lps+Xdu
 WKbx1XY+d+40yET8PJ/nQawJt9WVHJsFDYL3blGScXNo7OctSKyj0vgumO9LDbfCRzJ5
 CN8w1FGcqoNhmOt8uDLwyXxw8pjmwXGCt3Y+2373sd7EpMvo4HBHUebZgBo6Fb6oju6+
 owmBZ5WPqMdilnPgNAoRneOlkCarjeigtE2sDWmYCo+0Tiz/3lADv+cpl49s/VBzmiVV
 Jynw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3i/KU5cNh+ABHGCF+aJHZSDCqijuLWka7OoQfAU3h9SVx0Cffy7Ckik8xv+UMbBrqzZBR27QxwpUm@nongnu.org
X-Gm-Message-State: AOJu0Yz/0qCHr2mcbDIWnQT3JXJVkneAIN0SHMOId8f9nHSDNP52cEqd
 RUUp6Y6oUMrdIXoPJ8MzlZqz3TYxbS6tWQUk7vTV0vsFkoClrBZ2VXIP
X-Gm-Gg: ATEYQzzfv1TFrSPUZUoXcyDhXtHNIcmQ+8PvCrOa+b5XhbxOTTgnipUdpdX4GHcTQcF
 VtdHXLw3Y1JLrZkL4+41d/YiAW08sh96hpzzTXNzIQ8rsi2Gpze0HmNdXLRbJ3pRV5Q458gEzps
 ekSDvr8JXPToer4mzbZDv1KunwhH/FVQQCZP7wha3JmSNDyTGKdErVdzsOj/13/xrcUvs4eIEsd
 VnDZ6BvOIJN1Xf8ze8ifGqaddYSEmDb3WOB5FEp4xyt2zrKCpKtMekSH8+bY6MwtNBAPM9YvGIN
 rlVoa08O20LujJqwT7JLRp61nSenN2NX+RMOVfrx+qnnAvH2lTQ0HcXHNmAtmBvvycQzDM1C8Mv
 TvTPrVeCYDzKNoIJ3gBQWFOrymyHrXNZcIg9x0alu5MvxxcifzRoZ+a/IYPzHVtF+FLQA6e2QgM
 hy9lMboOkR8cVUbNNtoQhk0vcAY3w1wPnw3PZ07Nq3gj0p/k6tS8c8jkZglsWrteRmmWkyKGw1T
 rTOgzhaFLehsuzWP/8sYLcr84iSqyspXIi8
X-Received: by 2002:a05:6a00:14c9:b0:81f:993e:ecf6 with SMTP id
 d2e1a72fcca58-8274d9e974amr6823284b3a.33.1772302979143; 
 Sat, 28 Feb 2026 10:22:59 -0800 (PST)
Received: from visitorckw-work01.c.googlers.com.com
 (7.162.199.104.bc.googleusercontent.com. [104.199.162.7])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8273a05e831sm8731008b3a.58.2026.02.28.10.22.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Feb 2026 10:22:58 -0800 (PST)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: pbonzini@redhat.com,
	mst@redhat.com,
	cohuck@redhat.com
Cc: eleanor15x@gmail.com, jserv@ccns.ncku.edu.tw, qemu-devel@nongnu.org,
 Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH 0/2] virtio-rtc: Add basic device support
Date: Sat, 28 Feb 2026 18:22:44 +0000
Message-ID: <20260228182246.700714-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=visitorckw@gmail.com; helo=mail-pf1-x432.google.com
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

This patch series introduces initial support for the virtio-rtc device
(VIRTIO_ID_CLOCK), based on the OASIS virtio-rtc specification.

This implementation provides a single read-only clock that returns
the host's QEMU_CLOCK_HOST time in nanoseconds. It handles the
basic control and read requests necessary for the device to be
successfully probed and utilized by the upstream Linux virtio_rtc
driver.

I have verified this implementation using the virtio_rtc driver from
the Linux mainline. The device probes successfully, and the host time
can be correctly read from the guest using the following commands:

  $ cat /sys/class/rtc/rtc0/time
  $ cat /sys/class/rtc/rtc0/date
  $ hwclock -r -f /dev/rtc0

Kuan-Wei Chiu (2):
  standard-headers: Add virtio_rtc.h from Linux 7.0-rc1
  virtio-rtc: Add basic virtio-rtc support

 MAINTAINERS                                 |   7 +
 hw/virtio/Kconfig                           |   5 +
 hw/virtio/meson.build                       |   2 +
 hw/virtio/virtio-rtc-pci.c                  |  65 ++++++
 hw/virtio/virtio-rtc.c                      | 190 ++++++++++++++++
 include/hw/virtio/virtio-rtc.h              |  22 ++
 include/standard-headers/linux/virtio_rtc.h | 237 ++++++++++++++++++++
 7 files changed, 528 insertions(+)
 create mode 100644 hw/virtio/virtio-rtc-pci.c
 create mode 100644 hw/virtio/virtio-rtc.c
 create mode 100644 include/hw/virtio/virtio-rtc.h
 create mode 100644 include/standard-headers/linux/virtio_rtc.h

-- 
2.53.0.473.g4a7958ca14-goog


