Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48AF3C369D7
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 09:43:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7Wbo-0004R1-7Y; Wed, 23 Apr 2025 05:41:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u7WbV-00046z-QM
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 05:41:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u7WbR-0008JO-RP
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 05:41:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745401270;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ivc3l4r8ljBetXVfBeIVFaZ2YfUZJ+a4jen8xVotUoM=;
 b=c6Nzta4Vi7tO2bdogqVFUtTcIPPlA956jPbGLzAhSX5vRbip2/EDtPMEBxBrpj/4xp1Eao
 El3mnOx3G7mFNOp6x+9VNOJ6ANd3nBTk9FRBOnIS6tJNug0tdjvypKttAgwjPcUZ2op2rY
 yJRB0ECnkKvIjMR+V2uMpiLwUInJcyU=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-186-zCHG8_yFOpafvXljxM9pig-1; Wed, 23 Apr 2025 05:41:09 -0400
X-MC-Unique: zCHG8_yFOpafvXljxM9pig-1
X-Mimecast-MFC-AGG-ID: zCHG8_yFOpafvXljxM9pig_1745401268
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-5f620c5f8e4so5828339a12.1
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 02:41:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745401267; x=1746006067;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ivc3l4r8ljBetXVfBeIVFaZ2YfUZJ+a4jen8xVotUoM=;
 b=jigmzB02d66P/zfuHAVqM0y1x72RKbUhLKZP4okVI65KLDTtO+NX6y/YPf8McabyiQ
 xxSrg5+utBC+K1j26n+BxOlta50dIN6LghaznuImQjuoSUZbPPC2li+hnVbWenUdjX2G
 2bm0BbpN4phfdoayn9r0wnDYLpIrVqKkNceQJsQFpBcrdb6Y2KO814FHxAu375gfqd10
 BpX4IDG+J4LN+FFXapZ/pfRrCO3J9xWAZiUz7eSxv4R2ZfSo657ZX5V76OoPrWFw1u2r
 ZKGRnEK8L1Ud+hTGcqRL5/ARpU8X0dMebGDlffPPbQXNW+CH3CwOtc71SS2gjlgLhMWx
 2Srw==
X-Gm-Message-State: AOJu0YzgN5BvDzrL/DOrwg/QWBP1ndtFuGsKFfQq+U2JoqG4clI/JdjT
 XcmBb7fw4mWPvgrMvod9mLgB1XjcxaXqsm0N+T8U9sqLR47JIo7ikzcwTiE75FLpWVjpBgR3UZi
 BoBoAVJhNftXRQlHEfL61zDnyXujc5rjouiBJFyTw9iykHI7HcBlNBcDgkBe8ioQrpD7D92mf/z
 rVKgQYanYbDiwohE0qoULK/LNZtavQZhh4/8/i
X-Gm-Gg: ASbGncvjT0p9J5Fs1Tk1CjR0T/t3BYZFmciLG1kMiUiUZdAkXtsc1qx+N9ogQ63ysaY
 B6f95ieFv6EI6Gj+lDV89r0wUfQ0DhKn8iDo2F2qoaLf4Qrwc0cK4PGhVtWqvlYqz8xXZDA3T/8
 z5oHYab8FuJK2AEWdqoDZxNw62razBlb+MQgJcmaM5oaF6eMaLt+vckh25G0e7JoAynP5R96h66
 fIRU7zjNZyYHaZhnrwhmcnM7qYCZNIp3eqT4Ujommy0w2hUauoavJUiCdtwcxpFmf8tKdeTTEc7
 i3JmPJqRMjpu7CwE
X-Received: by 2002:a05:6402:270a:b0:5f0:48df:25ae with SMTP id
 4fb4d7f45d1cf-5f628519fb4mr15477492a12.2.1745401267339; 
 Wed, 23 Apr 2025 02:41:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAc3DhJvlj8/NWbE+nPprSEGMHNH2yzXvUNVP9CTLODRHHNIgkgcolqLMrNRHQnAUDl3dVHA==
X-Received: by 2002:a05:6402:270a:b0:5f0:48df:25ae with SMTP id
 4fb4d7f45d1cf-5f628519fb4mr15477474a12.2.1745401266843; 
 Wed, 23 Apr 2025 02:41:06 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.233.241])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5f625549f34sm7126078a12.4.2025.04.23.02.41.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 02:41:06 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/34] i386, Rust, SCSI changes for 2025-04-23
Date: Wed, 23 Apr 2025 11:40:30 +0200
Message-ID: <20250423094105.40692-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.411,
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

The following changes since commit 8bdd3a0308ba8e8d20240ac06de8615959bcf00e:

  tests/functional/test_aarch64_replay: reenable on macos (2025-04-14 11:03:16 -0400)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 6d8c6dee3a767e7650e5d0640e13adb9f01fa37c:

  rust/hw/char/pl011: Extract DR write logic into separate function (2025-04-23 10:35:23 +0200)

----------------------------------------------------------------
* target/i386: Fix model number of Zhaoxin YongFeng vCPU template
* target/i386: Reset parked vCPUs together with the online ones
* scsi: add conversion from ENODEV to sense
* target/i386: tweaks to flag handling
* target/i386: tweaks to SHLD/SHRD code generation
* target/i386: remove some global temporaries from TCG
* target/i386: pull emulator outside target/i386/hvf
* host/i386: consolidate getting host CPU vendor
* rust/hpet: preparation for migration support
* rust/pl011: bring over more commits from C version

----------------------------------------------------------------
Ewan Hai (1):
      target/i386: Fix model number of Zhaoxin YongFeng vCPU template

Maciej S. Szmigiero (1):
      target/i386: Reset parked vCPUs together with the online ones

Paolo Bonzini (11):
      scsi: add conversion from ENODEV to sense
      target/i386/hvf: fix lflags_to_rflags
      target/i386: special case ADC/SBB x,0 and SBB x,x
      target/i386: tcg: remove tmp0 and tmp4 from SHLD/SHRD
      target/i386: tcg: remove subf from SHLD/SHRD expansion
      target/i386: tcg: remove tmp0
      target/i386: tcg: remove some more uses of temporaries
      target/i386: tcg: simplify computation of AF after INC/DEC
      target/i386: emulate: microoptimize and explain ADD_COUT_VEC/SUB_COUT_VEC
      target/i386: tcg: use cout to commonize add/adc/sub/sbb cases
      target/i386/emulate: remove flags_mask

Rakesh Jeyasingh (2):
      rust/hw/char/pl011: Extract extract DR read logic into separate function
      rust/hw/char/pl011: Extract DR write logic into separate function

Wei Liu (14):
      target/i386/hvf: introduce x86_emul_ops
      target/i386/hvf: remove HVF specific calls from x86_decode.c
      target/i386/hvf: provide and use handle_io in emul_ops
      target/i386: rename hvf_mmio_buf to emu_mmio_buf
      target/i386/hvf: use emul_ops->read_mem in x86_emu.c
      target/i386/hvf: provide and use write_mem in emul_ops
      target/i386/hvf: provide and use simulate_{wrmsr, rdmsr} in emul_ops
      target/i386: rename lazy flags field and its type
      target/i386/hvf: drop unused headers
      target/i386/hvf: rename some include guards
      target/i386: add a directory for x86 instruction emulator
      target/i386/emulate: add a panic.h
      target/i386: move x86 instruction emulator out of hvf
      MAINTAINERS: add an entry for the x86 instruction emulator

Zhao Liu (5):
      i386/cpu: Consolidate the helper to get Host's vendor
      rust/hpet: convert num_timers to u8 type
      rust/hpet: convert HPETTimer index to u8 type
      rust/hpet: Fix a clippy error
      rust/vmstate_test: Fix typo in test_vmstate_macro_array_of_pointer_wrapped()

 MAINTAINERS                               |   8 +
 target/i386/cpu.h                         |  33 +-
 target/i386/emulate/panic.h               |  45 ++
 target/i386/{hvf => emulate}/x86.h        |   4 +-
 target/i386/{hvf => emulate}/x86_decode.h |   6 +-
 target/i386/{hvf => emulate}/x86_emu.h    |  15 +-
 target/i386/{hvf => emulate}/x86_flags.h  |   6 +-
 target/i386/hvf/hvf-i386.h                |   4 +-
 target/i386/hvf/vmx.h                     |   2 +-
 target/i386/hvf/x86_descr.h               |   2 +-
 target/i386/tcg/cc_helper_template.h.inc  |  90 +--
 accel/kvm/kvm-all.c                       |   8 +-
 scsi/utils.c                              |  13 +-
 target/i386/cpu.c                         |  12 +
 target/i386/{hvf => emulate}/x86_decode.c | 886 +++++++++++++++---------------
 target/i386/{hvf => emulate}/x86_emu.c    |  62 +--
 target/i386/{hvf => emulate}/x86_flags.c  |  66 +--
 target/i386/host-cpu.c                    |  10 +-
 target/i386/hvf/hvf.c                     |  57 +-
 target/i386/hvf/x86.c                     |   4 +-
 target/i386/hvf/x86_cpuid.c               |   2 +-
 target/i386/hvf/x86_mmu.c                 |   2 +-
 target/i386/hvf/x86_task.c                |   6 +-
 target/i386/hvf/x86hvf.c                  |   2 +-
 target/i386/kvm/vmsr_energy.c             |   3 +-
 target/i386/tcg/translate.c               | 144 +++--
 target/i386/tcg/emit.c.inc                | 180 ++++--
 rust/hw/char/pl011/src/device.rs          |  53 +-
 rust/hw/timer/hpet/src/hpet.rs            |  43 +-
 rust/qemu-api/tests/vmstate_tests.rs      |   4 +-
 target/i386/emulate/meson.build           |   5 +
 target/i386/hvf/meson.build               |   3 -
 target/i386/meson.build                   |   1 +
 33 files changed, 989 insertions(+), 792 deletions(-)
 create mode 100644 target/i386/emulate/panic.h
 rename target/i386/{hvf => emulate}/x86.h (99%)
 rename target/i386/{hvf => emulate}/x86_decode.h (99%)
 rename target/i386/{hvf => emulate}/x86_emu.h (75%)
 rename target/i386/{hvf => emulate}/x86_flags.h (97%)
 rename target/i386/{hvf => emulate}/x86_decode.c (71%)
 rename target/i386/{hvf => emulate}/x86_emu.c (95%)
 rename target/i386/{hvf => emulate}/x86_flags.c (80%)
 create mode 100644 target/i386/emulate/meson.build
-- 
2.49.0


