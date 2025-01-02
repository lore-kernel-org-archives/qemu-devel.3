Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC4E1E7718B
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 15:13:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTMsW-0007Sx-U5; Thu, 02 Jan 2025 10:12:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTMsU-0007Sg-Rz
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 10:12:50 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTMsS-0006Td-Vg
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 10:12:50 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-436ae3e14b4so19474325e9.1
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 07:12:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735830766; x=1736435566; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YDKEqLpmAAdeoEjAfD6jDt2HPzyZ6ohNl8ZwF9QQRwM=;
 b=isff923zr//Ffdkweebpvod1KUfifSRU2BhuT5HDZ6TMRsZjmlHirOzRhX7LEitoxT
 loMveLmlkXC6zRt/zNHi5xp0TLdrMEq7BAqJZD/3aNDnSdCEDLfG8UyMkQ4Lsw2M1dJz
 LfGlPOtdzZ9LnRozOlz2rFHGUK6M95ofBNlklropc+5mKwffU5hhSRNbSMhwC79PuHZg
 ewN7ZHL0szvvhLJiMauzGDE+0D2WbTVP9ujWhThKmxRFttX+GHU0Hg92h9oAQjpk7ORT
 9oa0nZoXzixxvpDaZwFd/Vq3MxN8Fto/AfrUFn2Q7c+OZtl8XDKqo6y2ncrEt9RyXbtU
 mxGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735830766; x=1736435566;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YDKEqLpmAAdeoEjAfD6jDt2HPzyZ6ohNl8ZwF9QQRwM=;
 b=op1jSqaCVtOdSLYZj9e0QECZU/vpSb4ObQo2HfyLwsbDJ4GS+YhGuvMFY0Pjr0e3ih
 IDMl6RMvy0jAINRuW/a9lcXudtmMvPRwvpegvbOAI2rq3CRllCZH9wo5hMD3svSeRftT
 jouvHnQ3mCVnPESflNy6BjeMlPkydHfVCtz8vYEtqf7d6hfOhWQBHR+Fk1OSRZQoz7Rh
 QfFGG98yiKFq8Ju+URHhhx/lVEXOdMw7z4zGw48m4iLbflrsMLaSh6g0HWE/701UB2CM
 sriVDFFstcPs3JHZi101jWQgmFMl2/wsu+tSiaql6o1hNIDPc+hiVfaMoshZX35wT3Rj
 K+jw==
X-Gm-Message-State: AOJu0Yz50ejCAnSi+xjPrp9RQKd3YCCMf7N8ibyjh8gFUZ/Tl7yb6JP+
 VNeEl+tQ+c8dTKJbyyweW+RVQ3HfhpgJFeuh1CjnV3kd40y5iHMWtSbblN6+iWIPzz4aQjqueJp
 n5DrjOA==
X-Gm-Gg: ASbGncuOsavWaNExnnqKirkm5rXjJ2dAUmSQWewQU+/7yzG4ij9G+Z9IHC84zh6FC3O
 uq4ERJ4T11iNFGgHhW09R1z80hR3iF8XDOilEgyFWj37P9rO7G2/ZBKJmbKVLboB/C9G01asrzo
 /UQuHEkKi74XSG0oBQ1xI8IljV3qzELEHYZ2Kdxr06kyRd+1/2XuZCSuft2p/ixxAKoFz+vDDLa
 ChB0Mub9pImmlxIrLg5rJmUppFncS2sUczsdd+cIzPnl16pymopwNm5hJDb5klp9Ll5y2TxraIG
 G149XaaJHo35HovNQdwyfri6wLKQIlY=
X-Google-Smtp-Source: AGHT+IFARPiH84JyNizR22dZxNWSSz7qRoIFxvx34Wjgc5u/om6DGBm0o3K0PsBChhNMI+r/aDbZNg==
X-Received: by 2002:a05:600c:154b:b0:432:d797:404a with SMTP id
 5b1f17b1804b1-43668b49976mr374947885e9.22.1735830766255; 
 Thu, 02 Jan 2025 07:12:46 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656b1143dsm486574975e9.18.2025.01.02.07.12.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 02 Jan 2025 07:12:45 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-block@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 David Hildenbrand <david@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Zhenwei Pi <pizhenwei@bytedance.com>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 00/10] QOM: container_get() removal
Date: Thu,  2 Jan 2025 16:12:34 +0100
Message-ID: <20250102151244.59357-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

Respin of Peter's v2:
https://lore.kernel.org/qemu-devel/20241121192202.4155849-1-peterx@redhat.com/

'The series is about container_get() and its removal.'
(See v2's cover).

Since v2:
- Create fake machine container for user emulation to avoid:

  $ ./qemu-x86_64 /bin/echo foo
  qemu-x86_64: ../../hw/core/qdev.c:825: qdev_get_machine: Assertion `dev' failed.
  Aborted (core dumped)

Peter Xu (6):
  qdev: Make qdev_get_machine() not use container_get()
  qdev: Add machine_get_container()
  qdev: Use machine_get_container()
  qom: Add object_get_container()
  qom: Use object_get_container()
  qom: Remove container_get()

Philippe Mathieu-Daudé (4):
  qdev: Expose qemu_create_machine()
  qdev: Implement qemu_create_machine() for user emulation
  qdev: Call qemu_create_machine() on user emulation
  qdev: Inline machine_containers[] in qemu_create_machine_containers()

 include/hw/qdev-core.h    | 12 ++++++++++++
 include/qom/object.h      | 21 ++++++++++-----------
 accel/tcg/tcg-all.c       |  8 +++++++-
 backends/cryptodev.c      |  4 ++--
 chardev/char.c            |  2 +-
 hw/core/gpio.c            |  3 +--
 hw/core/qdev-user-stubs.c | 11 +++++++++++
 hw/core/qdev.c            | 21 ++++++++++++++++++---
 hw/core/sysbus.c          |  4 ++--
 hw/i386/pc.c              |  4 ++--
 qom/container.c           | 23 -----------------------
 qom/object.c              | 12 +++++++++++-
 scsi/pr-manager.c         |  4 ++--
 system/ioport.c           |  2 +-
 system/memory.c           |  2 +-
 system/qdev-monitor.c     |  6 +++---
 system/vl.c               | 20 +++++++++-----------
 ui/console.c              |  2 +-
 ui/dbus-chardev.c         |  2 +-
 hw/core/meson.build       |  1 +
 20 files changed, 96 insertions(+), 68 deletions(-)
 create mode 100644 hw/core/qdev-user-stubs.c

-- 
2.47.1


