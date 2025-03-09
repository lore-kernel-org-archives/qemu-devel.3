Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8FA8C282D1
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 10:34:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trDwW-0007yW-DM; Sun, 09 Mar 2025 06:31:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1trDwS-0007y2-IB
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 06:31:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1trDwO-0003yr-0A
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 06:31:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741516287;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=/3THnVJh1k4LQ9j3TqKulpiNK6DFk5+zZI6dCZ06bvs=;
 b=fnKaIWb5wNs1LPT4+yH8HpLAckKgfvxdAiW0DsuVf80VN1YomabnXoj7QJ4u8hknIh1JC2
 0uqyPyE99T5wGxgnIDWYknq4bgslV9R93E8W1VY2ap8kgsg7EYYRsd32NwAco9JOEFtAbQ
 7tObHiO/ommir1wO6vZTKV121wBfzLM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-384-baK99zCeMrGtL1sIV7JMnQ-1; Sun, 09 Mar 2025 06:31:23 -0400
X-MC-Unique: baK99zCeMrGtL1sIV7JMnQ-1
X-Mimecast-MFC-AGG-ID: baK99zCeMrGtL1sIV7JMnQ_1741516282
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43cf3168b87so1390235e9.2
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 03:31:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741516282; x=1742121082;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/3THnVJh1k4LQ9j3TqKulpiNK6DFk5+zZI6dCZ06bvs=;
 b=k/XRtG5+YBHQvqpCawTSoNb54Y7t26XcJO/R7zz6XdZkJOCRuij4Us2g0Cf68D+i3x
 DjTKIX4MV0shJFkbqVqS9pwA+QP0pf+FObEBMLVQ48ZFT96FsGJRHRfNq3MYs9ggfJiL
 FR7Xy7RNAjUQrlO2uRW+jAYe+Wa+uqS/9VjGcvGVLUqFaE3c+xStOUiKt/yH3d3F9NWJ
 OS4cN0B0SBIpvPxU64tVS5iLz0aZ1wjIt26NBzg6nueGApa1ZtEaqaLQNLAf4Tdwak2a
 DnVrUpe2p2Sw1aQ0bYj72coWJSeEo66g5HDPHVb0aj276xGhrrG1kl6yqTaLHd4CYIRd
 OPbg==
X-Gm-Message-State: AOJu0YzfJ4J7L2aGFDRRfLCXddCEZdYBBhhnwyMVPKKHlzIMhSHXLz/p
 3VPwrgxvvN0HTdMaREk/UBBxFYA80ivWOKMdO0Oi1NdgDETch7INOlYyaH+4FCw5umQW/be6qbE
 SDY+3tMmYRITLgAx0dfyXrIT0GU72FEFUC5ydChG5yYwsnu0vh49daj+hPa+LMy7/60p7uxWYWE
 qLezpShRPcRdAfSZfwImR/X/yNxqAuMjGT8hRj3Xk=
X-Gm-Gg: ASbGnctd6vBBlRBn4P8cXC3lm1FRdyiUaYPvIW3tPl6hYVOMlT6FqHvVbvHdHcFvkV1
 AoXAimvxP7OqzDdadBAVy2AZEMh8XVTNFXf4qPkunTlOqsgs24676oiw30mTjoSPUrd3a2nboTQ
 wrXsywBy4/Rj/3tQC44qvjMo4Q+Gpkp/51Ia+lJ7C425PCuOCed/DOABodE5hK1mI27CfZ4icQj
 zuD4MFQxa19uAr9kCvyIN9HnTAFq3o1PiFTvezOVxHyzfMIYHwwSzNtu6zgOM2Ykq6PnGc2k/5n
 1vpm+ZbnViBeR/1GG4B6EA==
X-Received: by 2002:a05:600c:19cd:b0:43c:f1b8:16ad with SMTP id
 5b1f17b1804b1-43cf1b81b78mr9488595e9.30.1741516282046; 
 Sun, 09 Mar 2025 03:31:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvq4LE6Qch7VWDVpWTwjuQnMQvdlggydvWDGHTAqJpuFYOXkupoW4UCOUiOQg4oXjiOi5cHw==
X-Received: by 2002:a05:600c:19cd:b0:43c:f1b8:16ad with SMTP id
 5b1f17b1804b1-43cf1b81b78mr9488405e9.30.1741516281480; 
 Sun, 09 Mar 2025 03:31:21 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.122.167])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bd42c5b33sm145444665e9.22.2025.03.09.03.31.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Mar 2025 03:31:20 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/25] (Mostly) Rust patches for QEMU 10.0 soft freeze
Date: Sun,  9 Mar 2025 11:30:54 +0100
Message-ID: <20250309103120.1116448-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

The following changes since commit e8a01102936286e012ed0f00bd7f3b7474d415c9:

  Merge tag 'ui-pull-request' of https://gitlab.com/marcandre.lureau/qemu into staging (2025-03-05 21:58:23 +0800)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 816945364f698ae750aa665fce3d121c98e37a6f:

  rust: pl011: Allow NULL chardev argument to pl011_create() (2025-03-09 11:25:10 +0100)

----------------------------------------------------------------
* scripts: dump stdin on meson-buildoptions error
* rust: introduce qemu_api::cell::Opaque<>
* rust: express pinning requirements for timers
* rust: hpet: decode HPET registers into enums
* rust: cell: add full example of declaring a SysBusDevice
* rust: qom: remove operations on &mut

----------------------------------------------------------------
Alex Bennée (1):
      meson.build: default to -gsplit-dwarf for debug info

Nabih Estefan (1):
      scripts: dump stdin on meson-buildoptions error

Paolo Bonzini (22):
      chardev: express dependency on io/
      rust: cell: add wrapper for FFI types
      rust: qemu_api_macros: add Wrapper derive macro
      rust: vmstate: add std::pin::Pin as transparent wrapper
      rust: hpet: embed Timer without the Option and Box indirection
      rust: timer: wrap QEMUTimer with Opaque<> and express pinning requirements
      rust: irq: wrap IRQState with Opaque<>
      rust: qom: wrap Object with Opaque<>
      rust: qdev: wrap Clock and DeviceState with Opaque<>
      rust: hpet: do not access fields of SysBusDevice
      rust: sysbus: wrap SysBusDevice with Opaque<>
      rust: memory: wrap MemoryRegion with Opaque<>
      rust: chardev: wrap Chardev with Opaque<>
      rust: bindings: remove more unnecessary Send/Sync impls
      rust: chardev: provide basic bindings to character devices
      rust: pl011: move register definitions out of lib.rs
      rust: pl011: clean up visibilities of callbacks
      rust: pl011: switch to safe chardev operation
      rust: pl011: pass around registers::Data
      rust: hpet: decode HPET registers into enums
      rust: cell: add full example of declaring a SysBusDevice
      rust: qom: remove operations on &mut

Peter Maydell (1):
      rust: pl011: Allow NULL chardev argument to pl011_create()

 docs/devel/rust.rst                 |  36 ++-
 meson.build                         |  15 +-
 meson_options.txt                   |   2 +
 rust/Cargo.toml                     |   2 +
 rust/hw/char/pl011/src/device.rs    | 155 ++++-------
 rust/hw/char/pl011/src/lib.rs       | 511 +-----------------------------------
 rust/hw/char/pl011/src/registers.rs | 506 +++++++++++++++++++++++++++++++++++
 rust/hw/timer/hpet/src/hpet.rs      | 291 ++++++++++----------
 rust/qemu-api-macros/src/lib.rs     |  90 ++++++-
 rust/qemu-api/meson.build           |  24 +-
 rust/qemu-api/src/bindings.rs       |  26 +-
 rust/qemu-api/src/cell.rs           | 277 ++++++++++++++++++-
 rust/qemu-api/src/chardev.rs        | 248 ++++++++++++++++-
 rust/qemu-api/src/irq.rs            |  15 +-
 rust/qemu-api/src/memory.rs         |  32 +--
 rust/qemu-api/src/prelude.rs        |   1 -
 rust/qemu-api/src/qdev.rs           |  75 ++++--
 rust/qemu-api/src/qom.rs            | 118 ++-------
 rust/qemu-api/src/sysbus.rs         |  40 ++-
 rust/qemu-api/src/timer.rs          |  47 +++-
 rust/qemu-api/src/vmstate.rs        |   3 +-
 rust/qemu-api/src/zeroable.rs       |   1 +
 rust/qemu-api/tests/tests.rs        |  34 +--
 scripts/meson-buildoptions.py       |  10 +-
 scripts/meson-buildoptions.sh       |   2 +
 25 files changed, 1551 insertions(+), 1010 deletions(-)
 create mode 100644 rust/hw/char/pl011/src/registers.rs
-- 
2.48.1


