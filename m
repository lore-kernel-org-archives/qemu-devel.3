Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C88FEC27C55
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2024 08:38:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFrWu-0000Sf-7g; Sat, 08 Jun 2024 04:34:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sFrWs-0000SN-A6
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 04:34:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sFrWq-0008F2-9L
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 04:34:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717835663;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:  content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=DnPUGHSIvUF3O0xr1nlthjeGPXLFnE9nFl/zQ9utt1s=;
 b=IjR0Km40ui1y9WhDhHNHFSMJSMJXKBjh2Cgt5nAD/o8A525VDZEgvAxfd95aPJfQJmoxIy
 WX96WitlJ5jOjuVv95ywAFhrilGOZScvNXIJIlETCQM1bLkBPdtk4XYAQ/Dlh7nMDWjfXM
 60MFjcmFc2uyQ/DVo4zaKalBj87gyR8=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-VQcx22zFPkulxYUPNKDj8g-1; Sat, 08 Jun 2024 04:34:21 -0400
X-MC-Unique: VQcx22zFPkulxYUPNKDj8g-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-52c091e4413so570752e87.2
 for <qemu-devel@nongnu.org>; Sat, 08 Jun 2024 01:34:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717835659; x=1718440459;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DnPUGHSIvUF3O0xr1nlthjeGPXLFnE9nFl/zQ9utt1s=;
 b=O5HWx2An51OIOV3YqXBpxgakO4MMp+YCzWvsDmp3ABafIoO3psCPoZlJgr8kVYwXWJ
 hK9xLCDfZOdkZExgCf5siomB3NA2QtK44rBu1OeJrt1nhDS5rCIiQBkm4l8cGEMyJHjj
 4ThoA6H6VmlnmaD0azHiDVDxXUlKVCBRTEQy1baO9HG9q2lv4fOFk3s0vzhKTWmBM8B9
 EaK9jTyuidGQVJJfTCPOLPorAdv54a33vQv4yvxKhC49foL13hX07rcXyK3nkmw8TsLx
 3Ri1mdjAzzx6qXLMLZBx8APvF14/3IU16UuDdjNFgHq2fFLD0pXpT9YJUBMogJ+Hbo9r
 6Zug==
X-Gm-Message-State: AOJu0Yx9Z1CySLNcaDUvIzTYteFiOpzjshV91Gapn94regAlgj/Kh37W
 G5fsJYe+FAF8iCl91lyu9Z+BU58mQ4JgK9pmE98EaEgOMJAncsmPCB74MoXZgKGJIzlB2AiJ5+J
 G68abxyPm4fqZZ8kBlDk4aKL8WBJPIgF+j3XahQixpwhVkItD7sIU1VwQ8WtP3wIoe/D+4CewiT
 QhBS0s+yAShUSAoU7Q5rTnVnfCbqB8mr3YmJXv
X-Received: by 2002:a05:6512:2f1:b0:52b:798f:cd7e with SMTP id
 2adb3069b0e04-52bb9f62696mr3661137e87.12.1717835659144; 
 Sat, 08 Jun 2024 01:34:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7NRz7Trij5Q+lgCj5rpq5Ch5HDdeHSJgAIHJJW4IzYsW82sxMq1QhmnfDTT6IA8uuboqlSQ==
X-Received: by 2002:a05:6512:2f1:b0:52b:798f:cd7e with SMTP id
 2adb3069b0e04-52bb9f62696mr3661121e87.12.1717835658530; 
 Sat, 08 Jun 2024 01:34:18 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6c805c8c09sm355375966b.59.2024.06.08.01.34.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Jun 2024 01:34:17 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/42] i386, scsi. hostmem fixes for 2024-06-08
Date: Sat,  8 Jun 2024 10:33:33 +0200
Message-ID: <20240608083415.2769160-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The following changes since commit f1572ab94738bd5787b7badcd4bd93a3657f0680:

  Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2024-06-05 07:45:23 -0700)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to fc00123f3abeb027cd51eb58ea8845377794b3bc:

  python: mkvenv: remove ensure command (2024-06-08 10:33:39 +0200)

----------------------------------------------------------------
* scsi-disk: Don't silently truncate serial number
* backends/hostmem: Report error on unavailable qemu_madvise() features or unaligned memory sizes
* target/i386: fixes and documentation for INHIBIT_IRQ/TF/RF and debugging
* i386/hvf: Adds support for INVTSC cpuid bit
* i386/hvf: Fixes for dirty memory tracking
* i386/hvf: Use hv_vcpu_interrupt() and hv_vcpu_run_until()
* hvf: Cleanups
* stubs: fixes for --disable-system build
* i386/kvm: support for FRED
* i386/kvm: fix MCE handling on AMD hosts

----------------------------------------------------------------
John Allen (3):
      i386: Fix MCE support for AMD hosts
      i386: Add support for SUCCOR feature
      i386: Add support for overflow recovery

Kevin Wolf (1):
      scsi-disk: Don't silently truncate serial number

Mark Cave-Ayland (4):
      target/i386: use local X86DecodedOp in gen_POP()
      target/i386: use gen_writeback() within gen_POP()
      target/i386: fix SP when taking a memory fault during POP
      target/i386: fix size of EBP writeback in gen_enter()

Michal Privoznik (4):
      meson: Don't even detect posix_madvise() on Darwin
      osdep: Make qemu_madvise() to set errno in all cases
      osdep: Make qemu_madvise() return ENOSYS on unsupported OSes
      backends/hostmem: Report error when memory size is unaligned

Paolo Bonzini (16):
      target/i386: fix pushed value of EFLAGS.RF
      target/i386: fix implementation of ICEBP
      target/i386: cleanup HLT helpers
      target/i386: cleanup PAUSE helpers
      target/i386: implement DR7.GD
      target/i386: disable/enable breakpoints on vmentry/vmexit
      target/i386: fix INHIBIT_IRQ/TF/RF handling for VMRUN
      target/i386: fix INHIBIT_IRQ/TF/RF handling for PAUSE
      target/i386: fix TF/RF handling for HLT
      target/i386: document incorrect semantics of watchpoint following MOV/POP SS
      target/i386: document use of DISAS_NORETURN
      machine: default -M mem-merge to off is QEMU_MADV_MERGEABLE is not available
      machine, hostmem: improve error messages for unsupported features
      hostmem: simplify the code for merge and dump properties
      Revert "python: use vendored tomli"
      python: mkvenv: remove ensure command

Phil Dennis-Jordan (7):
      i386/hvf: Adds support for INVTSC cpuid bit
      i386/hvf: Fixes some compilation warnings
      hvf: Consistent types for vCPU handles
      i386/hvf: Fixes dirty memory tracking by page granularity RX->RWX change
      i386/hvf: In kick_vcpu use hv_vcpu_interrupt to force exit
      i386/hvf: Updates API usage to use modern vCPU run function
      hvf: Makes assert_hvf_ok report failed expression

Xin Li (5):
      target/i386: add support for FRED in CPUID enumeration
      target/i386: mark CR4.FRED not reserved
      vmxcap: add support for VMX FRED controls
      target/i386: enumerate VMX nested-exception support
      target/i386: Add get/set/migrate support for FRED MSRs

Zhao Liu (2):
      stubs/meson: Fix qemuutil build when --disable-system
      docs: i386: pc: Avoid mentioning limit of maximum vCPUs

 docs/devel/build-system.rst                |  13 ++--
 docs/system/target-i386-desc.rst.inc       |   3 +-
 configure                                  |   4 --
 meson.build                                |  14 ++--
 include/sysemu/hostmem.h                   |   2 +-
 include/sysemu/hvf_int.h                   |   9 ++-
 target/i386/cpu.h                          |  53 ++++++++++++++-
 target/i386/helper.h                       |   5 +-
 target/i386/hvf/vmx.h                      |   3 +-
 target/i386/tcg/helper-tcg.h               |  13 +++-
 accel/hvf/hvf-accel-ops.c                  |   2 +-
 accel/hvf/hvf-all.c                        |  51 ++++++--------
 backends/hostmem-epc.c                     |   1 +
 backends/hostmem-file.c                    |   1 +
 backends/hostmem-memfd.c                   |   1 +
 backends/hostmem.c                         |  36 +++++++---
 hw/core/machine.c                          |  11 ++-
 hw/scsi/scsi-disk.c                        |  20 +++++-
 target/i386/cpu.c                          |  33 ++++++++-
 target/i386/helper.c                       |   4 ++
 target/i386/hvf/hvf.c                      |  47 ++++++++++++-
 target/i386/hvf/x86_cpuid.c                |   4 ++
 target/i386/hvf/x86_decode.c               |   2 +-
 target/i386/hvf/x86_emu.c                  |   4 +-
 target/i386/kvm/kvm.c                      |  90 ++++++++++++++++++++++---
 target/i386/machine.c                      |  28 ++++++++
 target/i386/tcg/excp_helper.c              |  20 ++++++
 target/i386/tcg/misc_helper.c              |  14 ++--
 target/i386/tcg/seg_helper.c               |  49 ++++++++++++--
 target/i386/tcg/sysemu/bpt_helper.c        |  18 +++++
 target/i386/tcg/sysemu/misc_helper.c       |  17 ++---
 target/i386/tcg/sysemu/seg_helper.c        |  17 ++++-
 target/i386/tcg/sysemu/svm_helper.c        |  71 ++++++++++++-------
 target/i386/tcg/translate.c                |  39 ++++++++++-
 util/osdep.c                               |   9 ++-
 target/i386/tcg/decode-new.c.inc           |  19 +++++-
 target/i386/tcg/emit.c.inc                 |  37 +++++-----
 python/scripts/mkvenv.py                   | 105 -----------------------------
 python/scripts/vendor.py                   |   3 -
 python/wheels/tomli-2.0.1-py3-none-any.whl | Bin 12757 -> 0 bytes
 scripts/kvm/vmxcap                         |  13 ++++
 stubs/meson.build                          |   8 +--
 42 files changed, 617 insertions(+), 276 deletions(-)
 delete mode 100644 python/wheels/tomli-2.0.1-py3-none-any.whl
-- 
2.45.1


