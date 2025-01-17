Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29E8AC02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 08:53:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYi5b-00061W-SI; Fri, 17 Jan 2025 03:52:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tYi5Z-00061E-9J
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 03:52:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tYi5X-0006q4-A0
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 03:52:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737103939;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Zz8oxn9ufOXFW8Yd3sGC3LxL3IdQd/KAiRJk38Hqlsg=;
 b=Kr+dn3jb00yxQbqoMyVdagAEmnIJDmS/FCO7P0OQSSPaJu+07LTAwbB1A0d/uzGkYYNFQp
 xQrRTDivRAfV+7zUC+U7pzCXk5A22w/UYVND7OtEd+0K31E054Kaq6Z+yfBeRPZBltOfcv
 9z4ryEhabNs8JmFdGValbrqFb2gTGrQ=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-246-gln8Vy7cPCmT6wFjAcWWQw-1; Fri, 17 Jan 2025 03:52:16 -0500
X-MC-Unique: gln8Vy7cPCmT6wFjAcWWQw-1
X-Mimecast-MFC-AGG-ID: gln8Vy7cPCmT6wFjAcWWQw
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-5d90a59999aso2041271a12.3
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 00:52:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737103935; x=1737708735;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Zz8oxn9ufOXFW8Yd3sGC3LxL3IdQd/KAiRJk38Hqlsg=;
 b=XD5+I2RUBSl2k8fsH6NdnThH13YMaVGYlbk0mP4xBKwLrRO3KhQ/qFnZuPfcWi6lKR
 hicZJ8IUHXgFHy7C95XCTyYyJ6kKcddtYyvlA18NGystpLMm7d29vep8BBHP+YD2MYLe
 lMyFoauVfgBdlBkovEWxeqBuCzdcrgveuPEF1xApZ1pyktRDkcUWfmvHB0sVGqv52MA+
 vI6gAcUhNPhSiTrSGaS3euV8nNgm2B/E3vCOoMvBeFNOd1ZhZ12w0EbdX67Xubne+poE
 NDzx38k71PcsJgrnDPfxXsDeKFasCXqB1Pz8OBLTWw8Cb97nR+GapyxNG26KZM64PzQS
 eh/A==
X-Gm-Message-State: AOJu0Yx64k1dhncEetiHAMjUSYe7e7Drj9DiqHHpimT/KzeEu03CL/Dh
 yWXxai7/NQJyHS0SKtroEtsIhJ+Ee384sdBhlXN4PB9WXeOE3f0DQ8+OUsFuYIcQql39FTCWh+s
 3Wlzwwdy5XCwxbtXMK+A3MiovUZiM3rLarw2oHfz1q5lFc981dhrlU+VhtKu4OX2UKOKUiPRqvi
 Irhmmjuv3xrJ04iJ4dnP8ynSMZBxMjZu3H+J2I5TQ=
X-Gm-Gg: ASbGncu/0MWaHqiH7Z998a3xRTNafalxyeIAOb9kGnqRYwlSVzZQALcl9/DSg8R2Q4k
 yNQhfXOkIdKz1ha1kCMXwQcEh6WcLHnq2m8RczrwEc0Tbsa5L2iidKRzkrPC+Gp1rAWA0SEen0s
 9TvoseN/fxn4HvIec8pUmGTr3fEASjYlfgC8Cqd4pRLfoU5RvUcSBztG9WrQZYlJADjrlOGRUMm
 9P6noVRJARL11UuGqnkCMlP+WABW+S6JTx3dImOwPz2Ok8lU7nr9fgNtaRX
X-Received: by 2002:a05:6402:278f:b0:5d9:b50e:7008 with SMTP id
 4fb4d7f45d1cf-5db7d2f8c49mr1350496a12.8.1737103935348; 
 Fri, 17 Jan 2025 00:52:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHck5U2w8rE9O/spz8hdUBqgoUhMmqkT5ddfH57YPLNhB07NsCnaxhnXy8iz8cJnXzp67k09g==
X-Received: by 2002:a05:6402:278f:b0:5d9:b50e:7008 with SMTP id
 4fb4d7f45d1cf-5db7d2f8c49mr1350469a12.8.1737103934853; 
 Fri, 17 Jan 2025 00:52:14 -0800 (PST)
Received: from [192.168.10.3] ([176.206.124.70])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5db73edcd02sm1173096a12.78.2025.01.17.00.52.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 00:52:13 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 00/38] Rust, i386 patches for 2024-01-10
Date: Fri, 17 Jan 2025 09:52:11 +0100
Message-ID: <20250117085212.1044392-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.093,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.797,
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

The following changes since commit 6528013b5f5ba6bb3934b7f5fe57a3110680530f:

  Merge tag 'qga-pull-2025-01-06' of https://github.com/kostyanf14/qemu into staging (2025-01-06 09:39:02 -0500)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 99a637a86f55c8486b06c698656befdf012eec4d:

  i386/cpu: Set and track CPUID_EXT3_CMP_LEG in env->features[FEAT_8000_0001_ECX] (2025-01-10 23:34:45 +0100)

----------------------------------------------------------------
* rust: miscellaneous changes
* target/i386: small code generation improvements
* target/i386: various cleanups and fixes
* cpu: remove env->nr_cores

----------------------------------------------------------------
Paolo Bonzini (19):
      rust: fix --enable-debug-mutex
      rust: add --check-cfg test to rustc arguments
      rust: qom: add ParentField
      rust: add a utility module for compile-time type checks
      rust: macros: check that #[derive(Object)] requires #[repr(C)]
      rust: macros: check that the first field of a #[derive(Object)] struct is a ParentField
      rust: qom: automatically use Drop trait to implement instance_finalize
      rust: qom: move device_id to PL011 class side
      rust: pl011: only leave embedded object initialization in instance_init
      rust: qom: make INSTANCE_POST_INIT take a shared reference
      rust: qemu-api-macros: extend error reporting facility to parse errors
      rust: qemu-api-macros: add automatic TryFrom/TryInto derivation
      rust: qdev: expose inherited methods to subclasses of SysBusDevice
      rust: hide warnings for subprojects
      qom: remove unused field
      make-release: only leave tarball of wrap-file subprojects
      target/i386: improve code generation for BT
      target/i386: use shr to load high-byte registers into T0/T1
      target/i386/kvm: Replace ARRAY_SIZE(msr_handlers) with KVM_MSR_FILTER_MAX_RANGES

Xiaoyao Li (10):
      i386/cpu: Extract a common fucntion to setup value of MSR_CORE_THREAD_COUNT
      i386/cpu: Drop the variable smp_cores and smp_threads in x86_cpu_pre_plug()
      i386/cpu: Drop cores_per_pkg in cpu_x86_cpuid()
      i386/topology: Update the comment of x86_apicid_from_topo_ids()
      i386/topology: Introduce helpers for various topology info of different level
      i386/cpu: Track a X86CPUTopoInfo directly in CPUX86State
      i386/cpu: Hoist check of CPUID_EXT3_TOPOEXT against threads_per_core
      cpu: Remove nr_cores from struct CPUState
      i386/cpu: Set up CPUID_HT in x86_cpu_expand_features() instead of cpu_x86_cpuid()
      i386/cpu: Set and track CPUID_EXT3_CMP_LEG in env->features[FEAT_8000_0001_ECX]

Zhao Liu (9):
      i386/cpu: Mark avx10_version filtered when prefix is NULL
      target/i386/kvm: Add feature bit definitions for KVM CPUID
      target/i386/kvm: Remove local MSR_KVM_WALL_CLOCK and MSR_KVM_SYSTEM_TIME definitions
      target/i386/kvm: Only save/load kvmclock MSRs when kvmclock enabled
      target/i386/kvm: Drop workaround for KVM_X86_DISABLE_EXITS_HTL typo
      target/i386/confidential-guest: Fix comment of x86_confidential_guest_kvm_type()
      target/i386/kvm: Clean up return values of MSR filter related functions
      target/i386/kvm: Return -1 when kvm_msr_energy_thread_init() fails
      target/i386/kvm: Clean up error handling in kvm_arch_init()

 include/hw/core/cpu.h                              |   2 -
 include/hw/i386/topology.h                         |  30 +++-
 include/qom/object.h                               |   5 +-
 target/i386/confidential-guest.h                   |   2 +-
 target/i386/cpu.h                                  |  31 +++-
 hw/core/cpu-common.c                               |   1 -
 hw/i386/kvm/clock.c                                |   5 +-
 hw/i386/x86-common.c                               |  22 +--
 qom/object.c                                       |   1 -
 system/cpus.c                                      |   1 -
 target/i386/cpu-system.c                           |  11 ++
 target/i386/cpu.c                                  | 119 ++++++-------
 target/i386/hvf/x86_emu.c                          |   3 +-
 target/i386/kvm/kvm.c                              | 197 ++++++++++-----------
 target/i386/tcg/system/misc_helper.c               |   3 +-
 target/i386/tcg/translate.c                        |   2 +-
 target/i386/tcg/emit.c.inc                         |  59 ++++--
 rust/hw/char/pl011/src/device.rs                   |  79 ++++-----
 rust/hw/char/pl011/src/lib.rs                      |  28 +--
 rust/qemu-api-macros/src/lib.rs                    | 150 ++++++++++++----
 rust/qemu-api-macros/src/utils.rs                  |  26 +++
 rust/qemu-api/meson.build                          |   3 +-
 rust/qemu-api/src/assertions.rs                    |  90 ++++++++++
 rust/qemu-api/src/irq.rs                           |   3 +-
 rust/qemu-api/src/lib.rs                           |   1 +
 rust/qemu-api/src/prelude.rs                       |   2 +
 rust/qemu-api/src/qom.rs                           |  85 +++++++--
 rust/qemu-api/src/sysbus.rs                        |  23 ++-
 rust/qemu-api/tests/tests.rs                       |   4 +-
 scripts/make-release                               |  31 +++-
 scripts/rust/rustc_args.py                         |   2 +
 subprojects/arbitrary-int-1-rs.wrap                |   3 +
 subprojects/bilge-0.2-rs.wrap                      |   3 +
 subprojects/bilge-impl-0.2-rs.wrap                 |   3 +
 subprojects/either-1-rs.wrap                       |   3 +
 subprojects/itertools-0.11-rs.wrap                 |   3 +
 .../packagefiles/arbitrary-int-1-rs/meson.build    |   1 +
 subprojects/packagefiles/bilge-0.2-rs/meson.build  |   1 +
 .../packagefiles/bilge-impl-0.2-rs/meson.build     |   1 +
 subprojects/packagefiles/either-1-rs/meson.build   |   1 +
 .../packagefiles/itertools-0.11-rs/meson.build     |   1 +
 .../packagefiles/proc-macro-error-1-rs/meson.build |   1 +
 .../proc-macro-error-attr-1-rs/meson.build         |   1 +
 .../packagefiles/proc-macro2-1-rs/meson.build      |   1 +
 subprojects/packagefiles/quote-1-rs/meson.build    |   1 +
 subprojects/packagefiles/syn-2-rs/meson.build      |   1 +
 .../packagefiles/unicode-ident-1-rs/meson.build    |   1 +
 subprojects/proc-macro-error-1-rs.wrap             |   3 +
 subprojects/proc-macro-error-attr-1-rs.wrap        |   3 +
 subprojects/proc-macro2-1-rs.wrap                  |   3 +
 subprojects/quote-1-rs.wrap                        |   3 +
 subprojects/syn-2-rs.wrap                          |   3 +
 subprojects/unicode-ident-1-rs.wrap                |   3 +
 subprojects/unicode-ident-1-rs/meson.build         |  20 ---
 54 files changed, 716 insertions(+), 369 deletions(-)
 create mode 100644 rust/qemu-api-macros/src/utils.rs
 create mode 100644 rust/qemu-api/src/assertions.rs
 delete mode 100644 subprojects/unicode-ident-1-rs/meson.build
-- 
2.47.1


