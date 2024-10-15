Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EDC6D216AD
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 14:17:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0iMc-0005VX-Pa; Tue, 15 Oct 2024 10:17:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t0iMa-0005T8-Sm
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 10:17:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t0iMV-0003Hm-2S
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 10:17:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729001842;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Vo8yjtsgZ97vez2MluLSgoN78UNsCfBt3wO1bQ3wpU8=;
 b=LqoWipgJxpTZdSrAGJ38fZ1EltjdZ7EUeLIk0mUncp+0Ich+gpPRr/KP69rJ9OvOSjzCib
 kJfN+fAdCzO7qtvwtpyY5G+mHIKLbkUqIZ0E9XhsPYshVF1nD+7ImrseMrHD1R2+HdSV0k
 md73gQ0AUraxc4HuKjwlne65b7w26Sc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-2VSgT-sUM9uvgiW0mJkufw-1; Tue, 15 Oct 2024 10:17:17 -0400
X-MC-Unique: 2VSgT-sUM9uvgiW0mJkufw-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43124676f8aso21789455e9.0
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 07:17:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729001835; x=1729606635;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Vo8yjtsgZ97vez2MluLSgoN78UNsCfBt3wO1bQ3wpU8=;
 b=gA7cU1OpmijiYeDx9ipV9YUxElPsiONJRXZliYpgaUz8mXdIi3piook2ppv/vWVEy9
 QMMbm59OWgKSR/4OLo6WMJ88wCS/q4jSe3QtbYWtJIwnoOnxXv7ucuSRphYvqrLXuLxr
 5PU0GE39Nwalajx3AZaYzPXsYglo/mVzQc5GSreLPa+uffYzJdkfWlWgqESMFD0TxlAX
 tvGXb9wi82bZa2sCVknM3zqJw9g1sHlVXUbVBatUB0MsuahXh6hl/+/xnmZkXQTpJtms
 4AbLaG7s6GpYrlPLrCfxg6rHInaajvGX0h39L7d0XgSFz/S5zuhgiQ1wi01pA2R/ukIS
 vC5w==
X-Gm-Message-State: AOJu0YxoJMp27KZX7UJ96f/Snd3ACP2mAtsAkUdEpL3X78tGmemPj1bh
 nXaZWr/xOEN87vZG04UVMFd3CzXL6E+tzXjzFJAth8qlSRwR/OY8lRggazWKchHKgnXoQlBInje
 niJXowJNpWY9g1eI1yZ9zD9nN0D5VgA9JGE2ebrtVmKcL3HkIfTCpGrNnUf7koiqP/9IMTPRYNu
 BSgM9NF1kbYf0BUabPIjQCML4O8dJUPFxLmnJRHv0=
X-Received: by 2002:a05:600c:4e45:b0:431:1868:417f with SMTP id
 5b1f17b1804b1-4314a305f95mr7387025e9.17.1729001834883; 
 Tue, 15 Oct 2024 07:17:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6EKpVVBKrn4LLJaxD7w+y2O2+7/gpLFk1ReYYdPgsfSHFfL8+tOT9GL8gM4Qvo04/KyAn6w==
X-Received: by 2002:a05:600c:4e45:b0:431:1868:417f with SMTP id
 5b1f17b1804b1-4314a305f95mr7386705e9.17.1729001834343; 
 Tue, 15 Oct 2024 07:17:14 -0700 (PDT)
Received: from avogadro.local ([151.95.144.54])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4313f6c564csm19141165e9.47.2024.10.15.07.17.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 07:17:13 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/25] x86 and KVM patches for 2024-10-15
Date: Tue, 15 Oct 2024 16:16:46 +0200
Message-ID: <20241015141711.528342-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

The following changes since commit aa54f5be44be786636a5d51cc1612ad208a24849:

  tests: update lcitool to fix freebsd py311-yaml rename (2024-10-14 15:54:24 +0100)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 4bfdcb24fa5dc0844d0e4ab2cebb6687a233c0ff:

  target/i386: Use only 16 and 32-bit operands for IN/OUT (2024-10-15 16:15:47 +0200)

----------------------------------------------------------------
* target/i386: Fixes for IN and OUT with REX prefix
* target/i386: New CPUID features and logic fixes
* target/i386: Add support save/load HWCR MSR
* target/i386: Move more instructions to new decoder; separate decoding
  and IR generation
* target/i386/tcg: Use DPL-level accesses for interrupts and call gates
* accel/kvm: perform capability checks on VM file descriptor when necessary
* accel/kvm: dynamically sized kvm memslots array
* target/i386: fixes for Hyper-V
* docs/system: Add recommendations to Hyper-V enlightenments doc

----------------------------------------------------------------
Chao Gao (1):
      target/i386: Add more features enumerated by CPUID.7.2.EDX

Gao Shiyuan (1):
      target/i386: Add support save/load HWCR MSR

Paolo Bonzini (9):
      target/i386: convert bit test instructions to new decoder
      target/i386: decode address before going back to translate.c
      target/i386: convert CMPXCHG8B/CMPXCHG16B to new decoder
      target/i386: do not check PREFIX_LOCK in old-style decoder
      target/i386: list instructions still in translate.c
      target/i386: assert that cc_op* and pc_save are preserved
      target/i386/tcg: Use DPL-level accesses for interrupts and call gates
      accel/kvm: check for KVM_CAP_MULTI_ADDRESS_SPACE on vm
      accel/kvm: check for KVM_CAP_MEMORY_ATTRIBUTES on vm

Peter Xu (4):
      KVM: Dynamic sized kvm memslots array
      KVM: Define KVM_MEMSLOTS_NUM_MAX_DEFAULT
      KVM: Rename KVMMemoryListener.nr_used_slots to nr_slots_used
      KVM: Rename KVMState->nr_slots to nr_slots_max

Richard Henderson (1):
      target/i386: Use only 16 and 32-bit operands for IN/OUT

Tom Dohrmann (1):
      accel/kvm: check for KVM_CAP_READONLY_MEM on VM

Vitaly Kuznetsov (4):
      target/i386: Fix conditional CONFIG_SYNDBG enablement
      target/i386: Exclude 'hv-syndbg' from 'hv-passthrough'
      target/i386: Make sure SynIC state is really updated before KVM_RUN
      docs/system: Add recommendations to Hyper-V enlightenments doc

Xiaoyao Li (4):
      target/i386: Don't construct a all-zero entry for CPUID[0xD 0x3f]
      target/i386: Enable fdp-excptn-only and zero-fcs-fds
      target/i386: Construct CPUID 2 as stateful iff times > 1
      target/i386: Make invtsc migratable when user sets tsc-khz explicitly

 docs/system/i386/hyperv.rst      |  43 +++-
 include/sysemu/kvm_int.h         |   7 +-
 target/i386/cpu.h                |   9 +
 target/i386/tcg/decode-new.h     |  19 +-
 accel/kvm/kvm-all.c              | 131 ++++++++----
 target/i386/cpu.c                |  21 +-
 target/i386/kvm/hyperv.c         |   1 +
 target/i386/kvm/kvm.c            |  47 +++--
 target/i386/machine.c            |  20 ++
 target/i386/tcg/seg_helper.c     |  17 +-
 target/i386/tcg/translate.c      | 444 ++++++---------------------------------
 target/i386/tcg/decode-new.c.inc | 145 +++++++++----
 target/i386/tcg/emit.c.inc       | 246 +++++++++++++++++++++-
 accel/kvm/trace-events           |   1 +
 14 files changed, 666 insertions(+), 485 deletions(-)
-- 
2.46.2


