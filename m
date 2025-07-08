Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C761C83F0F
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 20:52:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZFFB-0001uD-Iz; Tue, 08 Jul 2025 16:48:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david.milosevic@9elements.com>)
 id 1uZE32-0005yV-38
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:32:17 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <david.milosevic@9elements.com>)
 id 1uZE2v-0003if-EF
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:32:09 -0400
Received: by mail-lj1-x243.google.com with SMTP id
 38308e7fff4ca-32e14ce168eso43478971fa.1
 for <qemu-devel@nongnu.org>; Tue, 08 Jul 2025 12:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1752003121; x=1752607921; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5aSk/AO/sTI8eSneU/X1SshCQUW99idUCChZjHIHGIc=;
 b=b7BQDlUbnTqbfLSNxKOfRqfNWrpImeLxQ/PdD9kGBoyTQiijhIuDbWY7X4GaBI3jMF
 CD69mRo5CW9HwXiEh36QxbipeWclMXgsPTO7lBbgyKAZyR+MIhCUIdFnbXYh7EcH6yxN
 OucjInIuXqZWMgZBw9x6Z+pJ41E5NRovgodxK5taviZvCvG5tDtqFeknl3MBue6RsusK
 eNyBcC+thX4OrIkWPfb4Ny2U9ZRc4AirEfK7gJxbPWw3n+ULQuSwmRFOLIOHkg/A8mfD
 JgSbQnLZ9BBdOAsu62Q0rI5CxvbCtW8Y52CHINxfs6Rr/6SJhrmHfPQ9BsB4pvEqCeDM
 tmQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752003121; x=1752607921;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5aSk/AO/sTI8eSneU/X1SshCQUW99idUCChZjHIHGIc=;
 b=EqypsRPSi62P06xtklI+ppa59sbcKQH+9eyTyF10mX+m7xbdZu8FiZlHm2roSil6fz
 ktbyTk6z4+RjYESIvOTZyABbNJr1SAxQL0LDvJ5Rb8IXUIgOeCHER0RRzowEqlGb0oE3
 XQRIR1bnqSAMuGYIBQIvfN6zgtPeeXGQgg7uGAKmI0nBz34EVLbYP+9OdhwxRTeotg8a
 3ne8HEM4uBYowzuhGamSvBr/33OKo+YHjRWnZicKvzrSVujKZMdueAnlhjlfK7vnxQc8
 kAUh/B9jDWZ9XkzTPzCx94Gqb/e+8nuj1G2AW1z+q/pE/vkPOlC+Jf6YROvjwA9cax36
 dQGw==
X-Gm-Message-State: AOJu0YxtiNgpAqEUeyT8lJbTkzBuQNNNGRk1m+HsZcaj+6V92jBm6BI+
 HrFe3zKcWQrlStAqfXJVsgaZS+LY1G0GHVKCWUUX7ppQC/l/A+nPtCxUGLSfXx6SApuw39cW2MG
 ABPlFM9TVPt5zWUs=
X-Gm-Gg: ASbGncurLgRappndYH6Uvq4bXL1gnzFKHZV9vk59OxE5wY0JZnEfv/Ee0U63hoI2AyL
 1aV6pMaXKg+x4A+6LWlBJTuqjFdUZ4lQiNJwgc1A1Gu77kEC2V7QGlNvRMss3hRCtWOsnbbMDc3
 tz24JgMdAPltT2zgVKI0DyBkxsHEKt3kDe7J/wMUiysQiFqLs+BkGteLxKvf0MKVw74AiZJnmNh
 Zy0+bCnN0ttMybAN7HJ9gXuaN6uoGjJOc1qvnvKxdoBX1lKnHreIbVKIfKBIb8i3/TUg8Tnm6el
 qZsRS9pTgFoIunhHuS7rufr4fRk1z+5YfwYtNf28dj0rjSVHPpaP+knyljkEDWIJ1csDIttWb11
 qQWwgOdChQaTwQ6AbjRIR/nCgGEhOprhyoOP8wTXzHVT//fV6f/L9
X-Google-Smtp-Source: AGHT+IGY0DMXbfm1Bil3ebWbVGBeUC5peDKUvUZgiXljqbyp4YJ2EiMMvy7GfN4eg/P7DpQf9mCWqw==
X-Received: by 2002:a05:600c:8b07:b0:454:aac0:ce1a with SMTP id
 5b1f17b1804b1-454b4e76cf4mr156216525e9.14.1751986711023; 
 Tue, 08 Jul 2025 07:58:31 -0700 (PDT)
Received: from cbox.sec.9e.network
 (p200300f75f10f341000000000000002d.dip0.t-ipconnect.de.
 [2003:f7:5f10:f341::2d]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454cd3d2749sm25445735e9.25.2025.07.08.07.58.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Jul 2025 07:58:30 -0700 (PDT)
From: David Milosevic <david.milosevic@9elements.com>
X-Google-Original-From: David Milosevic <David.Milosevic@9elements.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 pizhenwei@bytedance.com, marcello.bauer@9elements.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 David Milosevic <David.Milosevic@9elements.com>
Subject: [PATCH 0/3] Introduce new video subsystem with multiple backends
Date: Tue,  8 Jul 2025 16:56:47 +0200
Message-ID: <20250708145828.63295-1-David.Milosevic@9elements.com>
X-Mailer: git-send-email 2.47.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::243;
 envelope-from=david.milosevic@9elements.com; helo=mail-lj1-x243.google.com
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

As previously mentioned in our RFC, we at 9elements were working
on a new video subsystem for QEMU.

This subsystem includes a USB Video Class (UVC) frontend that exposes
a virtual camera device to the guest OS, backed by host-side
video sources like v4l2, GStreamer and libcamera.

The patch series is split into three parts

    - the first patch introduces the video subsystem with its
      first backend (v4l2) and implements the UVC device logic
    - the second patch adds the GStreamer backend
    - the third and final patch implements libcamera support

Currently we are able to:

    - stream frames (currently YUYV only)
    - dynamically enumerate supported camera modes (pixelformat, ...)
    - discover and access camera controls (brightness, ...)

The patch series was tested on two different host devices and in
combination with several guests

    1. Fedora39 as host with ubuntu-24.04, Fedora41 and Fedora42 as guests
    2. Fedora42 as host with Fedora42 as guest

Video streaming was successfully tested with, for example guvcview,
v4l2-ctl, gst-launch-1.0 (v4l2src, pipewiresrc), cheese, snapshot, vlc,
and Google Meet (from within Firefox) using the internal camera
and several external USB cameras.

v4l2-ctl and qv4l2 were used to test camera controls.

Known issues:

We currently do not always achieve the target fps. Higher frame resolutions
tend to reduce the fps observed in the guest. The following values were
recorded using the v4l2 backend and guvcview

internal webcam (HP EliteBook):
  640x360@30fps: 17.52fps
  320x180@30fps: 30.00fps
  320x240@30fps: 30.00fps
  424x240@30fps: 30.00fps
  640x480@30fps: 13.14fps

jiga webcam
  1920x1080@5fps: 2.01fps
  800x600@20fps:  8.44fps

I attempted to improve streaming performance by implementing a
producer-consumer model. The idea was for the producer
to fetch frames from the backend and enqueue them, while the
consumer (USBDeviceClass.handle_data) would dequeue and process them.
However, I'm not very familiar with QEMU's threading model, and I likely
didn’t implement it correctly - the producer and consumer are probably
still running in the same event loop

The experimental async version can be found here:
https://github.com/9elements/qemu/tree/nlnet/qemu-video/dev-async

Another issue is that v4l2-ctl fails to stream certain video resolutions,
even though other tools handle the same resolutions without problems. For
some resolutions, v4l2-ctl only receives frames marked with the
V4L2_BUF_FLAG_ERROR flag. This behavior requires further investigation.

Any help is very welcome!

RFC: https://lists.gnu.org/archive/html/qemu-devel/2025-03/msg02804.html
nlnet: https://nlnet.nl/project/Qemu-Camera/

Best regards,
David Milosevic

David Milosevic (3):
  video: introduce video subsystem with inital v4l2 backend
  video: add GStreamer backend
  video: add libcamera backend extension

 hw/core/qdev-properties-system.c    |   52 ++
 hw/usb/Kconfig                      |    5 +
 hw/usb/dev-video.c                  | 1333 +++++++++++++++++++++++++++
 hw/usb/meson.build                  |    1 +
 hw/usb/trace-events                 |   10 +
 include/hw/qdev-properties-system.h |    4 +
 include/hw/usb.h                    |    2 +
 include/hw/usb/video.h              |  322 +++++++
 meson.build                         |   31 +
 meson_options.txt                   |    5 +
 qemu-options.hx                     |    9 +
 scripts/meson-buildoptions.sh       |    6 +
 system/vl.c                         |   39 +-
 video/gstreamer-common.h            |   49 +
 video/gstreamer.c                   |  642 +++++++++++++
 video/libcamera.c                   |  148 +++
 video/meson.build                   |   24 +
 video/v4l2.c                        |  619 +++++++++++++
 video/video.c                       |  450 +++++++++
 video/video.h                       |  298 ++++++
 20 files changed, 4048 insertions(+), 1 deletion(-)
 create mode 100644 hw/usb/dev-video.c
 create mode 100644 include/hw/usb/video.h
 create mode 100644 video/gstreamer-common.h
 create mode 100644 video/gstreamer.c
 create mode 100644 video/libcamera.c
 create mode 100644 video/meson.build
 create mode 100644 video/v4l2.c
 create mode 100644 video/video.c
 create mode 100644 video/video.h

-- 
2.47.0


