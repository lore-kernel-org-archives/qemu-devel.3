Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3132C7115B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 16:43:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSena-0006SW-39; Fri, 20 Jun 2025 12:41:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uSenY-0006SF-R4
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 12:41:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uSenV-0000Dc-0m
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 12:41:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750437659;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=74X/SFDkJU/aMjcEUAksoZmBt6DzYhNI4J9Ot9oNbA8=;
 b=PnOsCueL9fp9jHQVae42uLv37x/K29JBWzgoqTtRhyPm1j7ZLqgIVp855d8+FhT38YyrQC
 ucvgRwXEknhdb+Xh7MePA1m+wJ3J+vlMMcthoC8a7dX2xMRICUjEEIehXQ0NcoOxqpI9Lh
 B6gIpIOYDhcoC/AB3KwiSWFqzMt86tA=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-313-PB-tIzJxMouRQbEmZ0OUFQ-1; Fri, 20 Jun 2025 12:40:57 -0400
X-MC-Unique: PB-tIzJxMouRQbEmZ0OUFQ-1
X-Mimecast-MFC-AGG-ID: PB-tIzJxMouRQbEmZ0OUFQ_1750437656
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-adb33457610so186294366b.3
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 09:40:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750437656; x=1751042456;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=74X/SFDkJU/aMjcEUAksoZmBt6DzYhNI4J9Ot9oNbA8=;
 b=SWlkH6Cl2WlurkSwalljxCOjvVQchCoX++bCeyHy1V9K6AVJkJaS+PtUxE9zpiP3hS
 Bo2p2PKEtpnBZuJra89ur9HhhExbhtPJVH/XRGwGdtzd60qSTswwD1VRZb3Z0I/Sm4xY
 jGoBw9wX00XolS/KHrH4Rr2oUl53bN/xyyfEoQ8nRElXkrXR8Vfond3C0ouXiT5SHPgH
 iveqg/AwO+qFuL6lQceFtDjAUFX8vSmuwvngdkE5qEEAqTEfxehB4xPIhKzYvDKJk4+9
 ETan5PenPjTYBnPCf3IXUb+WykBDmzMG+diwfOUsI5BIf5HGd/uhVBHnQU5XMNFdtY6i
 VQxQ==
X-Gm-Message-State: AOJu0YzVlVQ3y8Au/dB26Bz6FWb0b0UXwfv5BzLIsdQ7Bv5XcuYXKqqj
 vy8SRkq38DUo/uUeI6r4IBF/6EVWkpb0pifdahZt9+rVPiV3WjMXW9CYwm/JKt75+8Mk9JtXWXf
 3sGZ4slkcrxg+bGGzJspGha5A2A0HE5OzeST49s61T60KLpa6Sj1H3I7PKFBnNJ8EA20p25L9KA
 osiBBMkBC6FmA0rE4gnrmFl8JxSABsoerJV+mVW/Ky
X-Gm-Gg: ASbGncs7n7cenuxbrXg9axnXorehNsDtlxcaJLyasXpCWwSbTpqUm3MRrCUxMfTGun2
 5x5IkiP5Ep6WovYn8toMrGNvbiHRlvrAzhNNXR+PnT/k4YCVAiBI/Q7je8gaCYWj0C2x6SqTCwo
 22v/sstpoNkaxPkPdHrR033004BecwjWJNRKAu4R8VGWqeK6hBV6sduVfREWZCu4qIN6DlAEE1A
 1XqQNi+ApD1plnYBP6f3CR2btQ1mkkKSg/5mpKS/Mfwtp9CMhnYWktvQqtaigIcapUdU1iqfnKd
 /5T0Ya5H6wt6ACgT53lbW+mXlw==
X-Received: by 2002:a17:907:6088:b0:ad8:8529:4f9b with SMTP id
 a640c23a62f3a-ae057bc4354mr377984666b.38.1750437655812; 
 Fri, 20 Jun 2025 09:40:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFaBvHkbmK3fXARx+Q6V+nwoxADbkp97Pws/TpVTzMA8nrXVGEk6+SwKr6vB/r6ZtA9NMacKA==
X-Received: by 2002:a17:907:6088:b0:ad8:8529:4f9b with SMTP id
 a640c23a62f3a-ae057bc4354mr377981866b.38.1750437655256; 
 Fri, 20 Jun 2025 09:40:55 -0700 (PDT)
Received: from [192.168.122.1] ([151.62.200.93])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae053e7f2f5sm189623866b.15.2025.06.20.09.40.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Jun 2025 09:40:53 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/24] i386 (TCG, TDX), Rust changes for 2025-06-20
Date: Fri, 20 Jun 2025 18:40:28 +0200
Message-ID: <20250620164053.579416-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.897,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The following changes since commit a6f02277595136832c9e9bcaf447ab574f7b1128:

  Merge tag 'block-pull-request' of https://gitlab.com/stefanha/qemu into staging (2025-06-12 14:16:11 -0400)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 40da501d8989913935660dc24953ece02c9e98b8:

  i386/tdx: handle TDG.VP.VMCALL<GetQuote> (2025-06-20 13:25:59 +0200)

----------------------------------------------------------------
* cleanups for distributed DTB files
* scripts/meson-buildoptions: Sort coroutine_backend choices lexicographically
* rust/qemu-api: Add initial logging support
: rust: pl011: Implement logging
* target/i386: fix Win98
* meson: cleanup win32 library detection
* rust: safe(r) instance_init
* rust: prepare for multiple bindgen invocations
* rust: fix new warning
* target/i386: Warn about why CPUID_EXT_PDCM is not available
* target/i386: small TDX fixes and clarifications
* target/i386: support for TDX quote generation

----------------------------------------------------------------
Bernhard Beschow (5):
      hw: Fix type constant for DTB files
      pc-bios/dtb/meson: Prefer target name to be outfile, not infile
      rust/qemu-api: Add initial logging support based on C API
      rust: pl011: Implement logging
      rust: pl011: Add missing logging to match C version

Binbin Wu (1):
      i386/tdx: handle TDG.VP.VMCALL<GetTdVmCallInfo>

Isaku Yamahata (1):
      i386/tdx: handle TDG.VP.VMCALL<GetQuote>

Mark Cave-Ayland (1):
      target/i386: fix TB exit logic in gen_movl_seg() when writing to SS

Paolo Bonzini (10):
      meson: cleanup win32 library detection
      rust: qemu_api: introduce MaybeUninit field projection
      rust: hpet: fully initialize object during instance_init
      rust: qom: introduce ParentInit
      rust: qom: make ParentInit lifetime-invariant
      rust: qom: change instance_init to take a ParentInit<>
      rust: prepare variable definitions for multiple bindgen invocations
      rust: move rust.bindgen to qemu-api crate
      rust: hpet: fix new warning
      update Linux headers to v6.16-rc3

Xiaoyao Li (6):
      i386/cpu: Move adjustment of CPUID_EXT_PDCM before feature_dependencies[] check
      i386/cpu: Warn about why CPUID_EXT_PDCM is not available
      i386/tdx: Error and exit when named cpu model is requested
      i386/cpu: Rename enable_cpuid_0x1f to force_cpuid_0x1f
      i386/tdx: Fix the typo of the comment of struct TdxGuest
      i386/tdx: Clarify the error message of mrconfigid/mrowner/mrownerconfig

 docs/devel/rust.rst                                |   1 +
 meson.build                                        |  65 +----
 qapi/qom.json                                      |   8 +-
 include/standard-headers/asm-x86/setup_data.h      |  13 +-
 include/standard-headers/drm/drm_fourcc.h          |  45 ++++
 include/standard-headers/linux/ethtool.h           | 124 ++++-----
 include/standard-headers/linux/fuse.h              |   6 +-
 include/standard-headers/linux/input-event-codes.h |   3 +-
 include/standard-headers/linux/pci_regs.h          |  12 +-
 include/standard-headers/linux/virtio_gpu.h        |   3 +-
 include/standard-headers/linux/virtio_pci.h        |   1 +
 linux-headers/asm-arm64/kvm.h                      |   9 +-
 linux-headers/asm-x86/kvm.h                        |   1 +
 linux-headers/linux/bits.h                         |   4 +-
 linux-headers/linux/kvm.h                          |  25 ++
 linux-headers/linux/vhost.h                        |   4 +-
 rust/{ => qemu-api}/wrapper.h                      |   2 +
 target/i386/cpu.h                                  |   4 +-
 target/i386/kvm/tdx-quote-generator.h              |  82 ++++++
 target/i386/kvm/tdx.h                              |  25 +-
 hw/arm/boot.c                                      |   2 +-
 hw/ppc/e500.c                                      |   2 +-
 target/i386/cpu.c                                  |  10 +-
 target/i386/kvm/kvm.c                              |  15 ++
 target/i386/kvm/tdx-quote-generator.c              | 300 +++++++++++++++++++++
 target/i386/kvm/tdx-stub.c                         |   8 +
 target/i386/kvm/tdx.c                              | 206 +++++++++++++-
 target/i386/tcg/translate.c                        |   7 +-
 pc-bios/dtb/meson.build                            |   2 +-
 rust/hw/char/pl011/src/device.rs                   |  52 ++--
 rust/hw/timer/hpet/src/device.rs                   |  58 ++--
 rust/meson.build                                   |   4 +-
 rust/qemu-api/build.rs                             |   2 +-
 rust/qemu-api/meson.build                          |  45 +++-
 rust/qemu-api/src/lib.rs                           |   2 +
 rust/qemu-api/src/log.rs                           |  73 +++++
 rust/qemu-api/src/memory.rs                        |  12 +-
 rust/qemu-api/src/prelude.rs                       |   2 +
 rust/qemu-api/src/qdev.rs                          |  49 ++--
 rust/qemu-api/src/qom.rs                           | 186 ++++++++++++-
 rust/qemu-api/src/uninit.rs                        |  85 ++++++
 target/i386/kvm/meson.build                        |   2 +-
 42 files changed, 1334 insertions(+), 227 deletions(-)
 rename rust/{ => qemu-api}/wrapper.h (97%)
 create mode 100644 target/i386/kvm/tdx-quote-generator.h
 create mode 100644 target/i386/kvm/tdx-quote-generator.c
 create mode 100644 rust/qemu-api/src/log.rs
 create mode 100644 rust/qemu-api/src/uninit.rs
-- 
2.49.0


