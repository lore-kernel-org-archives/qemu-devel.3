Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FAE4C021A0
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 16:09:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tibey-0000yP-4a; Thu, 13 Feb 2025 11:01:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tibeJ-0000oq-Ja
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 11:01:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tibeC-0005Oj-4y
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 11:01:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739462462;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=zcjBoC1B+j7HYq04KLSZk9SffU753eljHxo8vUNW3qE=;
 b=XgumIok61zEr+rE/McW41bRj+e1CtuD9gbmZgb9o2zwEjp2z8m7/Zb8qTRUkgQKKNiQGnk
 tOWrvP60s6Lq/GhFk+U7TZ1HUCAIA3vkMmQ7j8bP8nfkh53xgEc2LMQPXb/ByVC4TLk194
 8FqXa5AmvmQAPqpF76tgXR2rFqx6GLc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-3Y2G7hTvMOiYg9ys1UOkjA-1; Thu, 13 Feb 2025 11:01:00 -0500
X-MC-Unique: 3Y2G7hTvMOiYg9ys1UOkjA-1
X-Mimecast-MFC-AGG-ID: 3Y2G7hTvMOiYg9ys1UOkjA
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-38de0a98043so613704f8f.3
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2025 08:01:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739462459; x=1740067259;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zcjBoC1B+j7HYq04KLSZk9SffU753eljHxo8vUNW3qE=;
 b=pPvGn0dFwp9XX35E1eoawZ+gi40sg5Okfa5dhx9ZD2NuJ6GRk6HlgDcqG4PPzyQJze
 HvUydITv1aYSudsF1gPz4MpLjX3SXttZP/HzYSsUhRVsPN1tLNEjz7G5jyg44z5eCyZE
 GuqKMvnJkUU//QvhjpTqTvn2eP2jPk6kz4QFat5HzRP4CBd8bD2ZbkIFd51PKeNv94b3
 xpU5HecI0a91jxNy1zTW1PwYI4qOPrhfVMSPVmMosqFYca/7AID5ROwFqcsFdGDsbEPf
 9G1kM7J3bPM8rKRjBi7N5to6jEr0quguYwG9OP3SHuxYOzVgCEU2TVVpMulLNq3APVGY
 krYw==
X-Gm-Message-State: AOJu0Yz0jYCn9dfryouiUp4OdB9n72fh5wf26fNMbUp5akSNhJxdmyO5
 9S0CYX6yp9jkG7BH02T5wya1gKHM+2K9SBUlIMk21psnPRIYOwG/gabWBeKynyI9lLBXP7K4uuD
 2F87kf6j7+GcdvbO5UESOT5+BvgjhkQ19tEl8X+ivEX63fDw2YYcZ9hiIp5iK4haBh6o/m06/yf
 aZiX/HhD4QW2a+XQYOKpqLLLRBI/QYCabTwBbk+QU=
X-Gm-Gg: ASbGnctq1WbA6qQVhtbzR/B3ZnUoBg7iW9ewQNdGzBssqnqJCN3Le1zk9MPaUcSKohG
 8Gg6eexIG1LznWoloTIZguc/2i+Y2+ozpjujT2zPTdIliEes9lnd7D+zO5Dt8LB1BT44B4TSkUl
 vh6CUgqXz8fY6hcHAFddjvIH7lozHkrSBF51dTWYNb0RTXcJ3GX2VUtaichpCneFqGAZlgeMIdP
 owPz3boG4kpwCJk1YKWrDUdfw7kDYjW4Q4p7cBxERLWqmzUeMBmylvAsAljZCB+CvL3yGV0aZta
 fiOlW23BdW1hfi65y9F1yQ9g/D7efK17Oquy2cKVl70qDg==
X-Received: by 2002:a5d:5889:0:b0:38f:24f4:93b9 with SMTP id
 ffacd0b85a97d-38f24f49436mr3758624f8f.28.1739462458860; 
 Thu, 13 Feb 2025 08:00:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHxYpaoSpx8w5fgA+mrSz/ITH9U0Js+Q68cjABmBpGgKhxA6GE4J5H51+Txp99xTs9wlDpTKQ==
X-Received: by 2002:a5d:5889:0:b0:38f:24f4:93b9 with SMTP id
 ffacd0b85a97d-38f24f49436mr3758525f8f.28.1739462457788; 
 Thu, 13 Feb 2025 08:00:57 -0800 (PST)
Received: from [192.168.126.123] (93-38-211-213.ip72.fastwebnet.it.
 [93.38.211.213]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f259d8e62sm2235630f8f.71.2025.02.13.08.00.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2025 08:00:57 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/27] rust, Windows patches for 2025-02-13
Date: Thu, 13 Feb 2025 17:00:27 +0100
Message-ID: <20250213160054.3937012-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

The following changes since commit de278e54aefed143526174335f8286f7437d20be:

  Merge tag 'pull-loongarch-20250212' of https://gitlab.com/bibo-mao/qemu into staging (2025-02-12 09:16:36 -0500)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 4dafba778aa3e5f5fd3b2c6333afd7650dcf54e2:

  ui/sdl2: reenable the SDL2 Windows keyboard hook procedure (2025-02-13 13:50:45 +0100)

----------------------------------------------------------------
* rust: more qdev bindings
* rust: HPET device model with timer and GPIO bindings
* rust: small cleanups and fixes; run doctests during CI
* ui/sdl2: reenable the SDL2 Windows keyboard hook procedure

----------------------------------------------------------------
Paolo Bonzini (16):
      rust: docs: document naming convention
      rust: qom: add reference counting functionality
      rust: qom: add object creation functionality
      rust: callbacks: allow passing optional callbacks as ()
      rust: qdev: add clock creation
      rust: qom: allow initializing interface vtables
      rust: qdev: make ObjectImpl a supertrait of DeviceImpl
      rust: qdev: switch from legacy reset to Resettable
      rust: bindings: add Send and Sync markers for types that have bindings
      rust: bindings for MemoryRegionOps
      rust: irq: define ObjectType for IRQState
      rust: chardev, qdev: add bindings to qdev_prop_set_chr
      rust: pl011: convert pl011_create to safe Rust
      rust: qemu_api: add a documentation header for all modules
      rust: vmstate: remove redundant link targets
      rust: fix doctests

Volker Rümelin (1):
      ui/sdl2: reenable the SDL2 Windows keyboard hook procedure

Zhao Liu (10):
      i386/fw_cfg: move hpet_cfg definition to hpet.c
      rust/qdev: add the macro to define bit property
      rust/irq: Add a helper to convert [InterruptSource] to pointer
      rust: add bindings for gpio_{in|out} initialization
      rust: add bindings for memattrs
      rust: add bindings for timer
      rust/timer/hpet: define hpet_fw_cfg
      rust/timer/hpet: add basic HPET timer and HPETState
      rust/timer/hpet: add qom and qdev APIs support
      i386: enable rust hpet for pc when rust is enabled

 docs/devel/rust.rst                      |  46 ++
 configs/devices/i386-softmmu/default.mak |   1 +
 meson.build                              |   8 +
 include/hw/timer/hpet.h                  |   2 +-
 rust/wrapper.h                           |   3 +
 hw/i386/fw_cfg.c                         |   6 +-
 hw/i386/pc.c                             |   2 +-
 hw/timer/hpet.c                          |  16 +-
 ui/sdl2.c                                |  26 -
 .gitlab-ci.d/buildtest.yml               |   6 +
 hw/timer/Kconfig                         |   2 +-
 rust/Cargo.lock                          |   8 +
 rust/Cargo.toml                          |   1 +
 rust/hw/Kconfig                          |   1 +
 rust/hw/char/pl011/src/device.rs         | 121 +++--
 rust/hw/char/pl011/src/lib.rs            |   1 -
 rust/hw/char/pl011/src/memory_ops.rs     |  34 --
 rust/hw/meson.build                      |   1 +
 rust/hw/timer/Kconfig                    |   2 +
 rust/hw/timer/hpet/Cargo.toml            |  18 +
 rust/hw/timer/hpet/meson.build           |  18 +
 rust/hw/timer/hpet/src/fw_cfg.rs         |  69 +++
 rust/hw/timer/hpet/src/hpet.rs           | 889 +++++++++++++++++++++++++++++++
 rust/hw/timer/hpet/src/lib.rs            |  15 +
 rust/hw/timer/meson.build                |   1 +
 rust/qemu-api/meson.build                |   3 +
 rust/qemu-api/src/assertions.rs          |   4 +
 rust/qemu-api/src/bindings.rs            |  48 ++
 rust/qemu-api/src/c_str.rs               |   8 +
 rust/qemu-api/src/callbacks.rs           |  97 ++++
 rust/qemu-api/src/chardev.rs             |  19 +
 rust/qemu-api/src/irq.rs                 |  23 +-
 rust/qemu-api/src/lib.rs                 |   3 +
 rust/qemu-api/src/memory.rs              | 203 +++++++
 rust/qemu-api/src/offset_of.rs           |   7 +
 rust/qemu-api/src/prelude.rs             |   6 +
 rust/qemu-api/src/qdev.rs                | 276 +++++++++-
 rust/qemu-api/src/qom.rs                 | 226 +++++++-
 rust/qemu-api/src/sysbus.rs              |  41 +-
 rust/qemu-api/src/timer.rs               |  98 ++++
 rust/qemu-api/src/vmstate.rs             |  13 +-
 rust/qemu-api/src/zeroable.rs            |  12 +-
 rust/qemu-api/tests/tests.rs             |  45 +-
 tests/qtest/meson.build                  |   3 +-
 ui/meson.build                           |   4 -
 45 files changed, 2232 insertions(+), 204 deletions(-)
 delete mode 100644 rust/hw/char/pl011/src/memory_ops.rs
 create mode 100644 rust/hw/timer/Kconfig
 create mode 100644 rust/hw/timer/hpet/Cargo.toml
 create mode 100644 rust/hw/timer/hpet/meson.build
 create mode 100644 rust/hw/timer/hpet/src/fw_cfg.rs
 create mode 100644 rust/hw/timer/hpet/src/hpet.rs
 create mode 100644 rust/hw/timer/hpet/src/lib.rs
 create mode 100644 rust/hw/timer/meson.build
 create mode 100644 rust/qemu-api/src/chardev.rs
 create mode 100644 rust/qemu-api/src/memory.rs
 create mode 100644 rust/qemu-api/src/timer.rs
-- 
2.48.1


