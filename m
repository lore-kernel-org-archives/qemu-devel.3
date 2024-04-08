Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79828C67861
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 15:54:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtrJh-0001Cj-1Z; Mon, 08 Apr 2024 11:53:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rtrJZ-0001AS-2v
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 11:53:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rtrJS-0001m5-JX
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 11:53:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712591617;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=+mDg/Mrb8+ldQ1J+oBVOKeSkpn7y3AJXhDnTttc/PYw=;
 b=TgG83pnDSPQyU2WO2C2AaZiBoABUftCHwO7y5jYk9QErJZyHYF0kBkkz4MY4OeL3l/nrYt
 MuqnYXAZ4cZ3y2mKet0gMFXTroYAjbE+vPGIURUM11+Cwhf9p8aIvdiyxi4b+NIvLw8x3f
 QXUovt2it8mElQom7N3ivqps/7Ilkyw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-377-6fpJ7n7xOiKmeCNaCjuPqw-1; Mon, 08 Apr 2024 11:53:35 -0400
X-MC-Unique: 6fpJ7n7xOiKmeCNaCjuPqw-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-41481f2d826so23162835e9.1
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 08:53:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712591613; x=1713196413;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+mDg/Mrb8+ldQ1J+oBVOKeSkpn7y3AJXhDnTttc/PYw=;
 b=Wnjd8BTsUpHr2H47n+2AJ/hTOE/bt/sAFPg3K4zW5hkzZ17W6Un5ApCNr2fOrter4L
 uBg03rz2ZHEXcyAGAZrA07M7ird81dgR7fNd+TEQ8hTp2PYuI0Dyaz2rEWzyp3F9PC3K
 y96AOA/Jzk+s1pzQ5yXYgmFUZvZSN92Ln1xoIUwqq40TpTCtdgzh/eWRnd58NHegIpS8
 jmt/a0QUDSClhvOmhCkrblnSnHDHGNY6j6aNpHdjFSgV1CNO7D++Yh9ppVU8nMYixSqZ
 2Cchg5s1KnTSO+3pZo4Bh3prrGtrjzh8Ig7TwKSHt3CExTrXL1wrd2Zh7Nn5vBfvNwkv
 At3w==
X-Gm-Message-State: AOJu0Yxhi+LX6/MhEEatS672P6irbGXOAHkwZPXd4hY4i74jZmUZEDc0
 PL8w5FpV2pMotTn+OmH+g2CZzFumnBx4iY0sq52uAKJcGzFs7/osqRaLL6Yv/eJdg6jJJlv6/95
 EYopdD2gdkS47fY5yrcW6Bgn1+7Y1a7s17WgM75txKzWN4jYsN8m3UEslvZDILGjomiUc5j5lnv
 r11rkSCNdMJLtL5DYS6kqgAI4SVtPOKPkHcIS1
X-Received: by 2002:a05:600c:4fd5:b0:416:2c8f:12e7 with SMTP id
 o21-20020a05600c4fd500b004162c8f12e7mr7227390wmq.1.1712591613421; 
 Mon, 08 Apr 2024 08:53:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzLyhyyyX1Q6kGIlL3LU8eMqM+46Vdm0ARFvxHPAaRZa2rPZmD9MxsuAxzKlglX7NTLvX8ZQ==
X-Received: by 2002:a05:600c:4fd5:b0:416:2c8f:12e7 with SMTP id
 o21-20020a05600c4fd500b004162c8f12e7mr7227375wmq.1.1712591613033; 
 Mon, 08 Apr 2024 08:53:33 -0700 (PDT)
Received: from avogadro.local ([151.95.152.232])
 by smtp.gmail.com with ESMTPSA id
 k16-20020a05600c1c9000b004166a7afd20sm4683198wms.10.2024.04.08.08.53.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Apr 2024 08:53:32 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH v2 0/7] buildsys: Start shrinking qemu-user build process
Date: Mon,  8 Apr 2024 17:53:12 +0200
Message-ID: <20240408155330.522792-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.494,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Some files (especially from hw/core/, stubs/ and util/) are built for
user mode emulation unnecessarily; they are not needed by any code that
is part of qemu-user.

The bulk of the patch (commits 6-17) puts stubs/ on a diet both in
general (moving stubs out into specific subdirectories and away from
libqemuutil.a) and for specific builds, by documenting which parts
of QEMU need the various object files.

Tested by building

   --disable-system --disable-user --disable-tools --disable-guest-agent
   --disable-system --enable-user --disable-tools --disable-guest-agent
   --disable-system --disable-user --enable-tools --disable-guest-agent
   --disable-system --disable-user --disable-tools --enable-guest-agent

as well as regular CI.

Paolo

Paolo Bonzini (15):
  meson: do not link pixman automatically into all targets
  tests: only build plugins if TCG is enabled
  tests/unit: match some unit tests to corresponding feature switches
  yank: only build if needed
  hw/core: Move system emulation files to system_ss
  stubs: remove obsolete stubs
  hw/usb: move stubs out of stubs/
  hw/virtio: move stubs out of stubs/
  semihosting: move stubs out of stubs/
  ramfb: move stubs out of stubs/
  memory-device: move stubs out of stubs/
  colo: move stubs out of stubs/
  stubs: split record/replay stubs further
  stubs: include stubs only if needed
  stubs: move monitor_fdsets_cleanup with other fdset stubs

Philippe Mathieu-Daudé (3):
  ebpf: Restrict to system emulation
  util/qemu-config: Extract QMP commands to qemu-config-qmp.c
  hw: Include minimal source set in user emulation build

 meson.build                                   |   8 +-
 include/qemu/config-file.h                    |   3 +
 include/sysemu/sysemu.h                       |   2 -
 stubs/ramfb.c => hw/display/ramfb-stubs.c     |   0
 .../mem/memory-device-stubs.c                 |   0
 stubs/usb-dev-stub.c => hw/usb/bus-stub.c     |   5 -
 .../virtio/virtio-md-stubs.c                  |   0
 stubs/colo.c => migration/colo-stubs.c        |   0
 monitor/qemu-config-qmp.c                     | 206 ++++++++++++++++++
 stubs/colo-compare.c => net/colo-stubs.c      |   0
 .../semihost-all.c => semihosting/stubs-all.c |   0
 .../semihost.c => semihosting/stubs-system.c  |   0
 stubs/fdset.c                                 |   6 +
 {hw/core => stubs}/hotplug-stubs.c            |   0
 stubs/isa-bus.c                               |   7 -
 stubs/module-opts.c                           |   2 -
 stubs/monitor-core.c                          |   6 -
 stubs/{monitor.c => monitor-internal.c}       |   5 -
 stubs/pci-bus.c                               |   7 -
 stubs/qdev.c                                  |   6 -
 stubs/qtest.c                                 |  10 -
 stubs/replay-mode.c                           |   4 +
 stubs/replay.c                                |   2 -
 util/qemu-config.c                            | 204 +----------------
 ebpf/meson.build                              |   2 +-
 hw/core/meson.build                           |  14 +-
 hw/display/meson.build                        |   2 +-
 hw/mem/meson.build                            |   1 +
 hw/usb/meson.build                            |   2 +-
 hw/virtio/meson.build                         |   3 +-
 migration/meson.build                         |   2 +
 monitor/meson.build                           |   1 +
 net/meson.build                               |   2 +
 semihosting/meson.build                       |   3 +
 stubs/meson.build                             | 133 ++++++-----
 tests/meson.build                             |   2 +-
 tests/unit/meson.build                        |  12 +-
 util/meson.build                              |   2 +-
 38 files changed, 328 insertions(+), 336 deletions(-)
 rename stubs/ramfb.c => hw/display/ramfb-stubs.c (100%)
 rename stubs/memory_device.c => hw/mem/memory-device-stubs.c (100%)
 rename stubs/usb-dev-stub.c => hw/usb/bus-stub.c (83%)
 rename stubs/virtio-md-pci.c => hw/virtio/virtio-md-stubs.c (100%)
 rename stubs/colo.c => migration/colo-stubs.c (100%)
 create mode 100644 monitor/qemu-config-qmp.c
 rename stubs/colo-compare.c => net/colo-stubs.c (100%)
 rename stubs/semihost-all.c => semihosting/stubs-all.c (100%)
 rename stubs/semihost.c => semihosting/stubs-system.c (100%)
 rename {hw/core => stubs}/hotplug-stubs.c (100%)
 delete mode 100644 stubs/isa-bus.c
 delete mode 100644 stubs/module-opts.c
 rename stubs/{monitor.c => monitor-internal.c} (79%)
 delete mode 100644 stubs/pci-bus.c
 create mode 100644 stubs/replay-mode.c

-- 
2.44.0


