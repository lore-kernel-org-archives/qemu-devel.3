Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA59FCA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:53:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNOU-0003YW-I6; Sat, 30 Aug 2025 11:21:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1us12a-0000zv-Oi
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 11:29:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1us12X-0008QK-9Y
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 11:29:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756481357;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=oSaj7LkopQWoJPM6ZoQASZJAf1eQ1iaM4v2fSFrSvao=;
 b=CQcYbfyK6IPzNPKwa+4nsK1CBFbTKrfYw3VcZQRw/yGiLfAlOS8CK4CHSV4YfEIqUoQNPs
 yvLhbA4rH29lSRsLmVZ9evx33SDeVDBO/xst+evu1ABI54UIkVDsg9UNnj56lGjcAoolSe
 AlW6n8CWX1+LHh90r7C8/dXKTOjK7/A=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-rIzarAQ1OPuhBCmeMZXEzg-1; Fri, 29 Aug 2025 11:29:16 -0400
X-MC-Unique: rIzarAQ1OPuhBCmeMZXEzg-1
X-Mimecast-MFC-AGG-ID: rIzarAQ1OPuhBCmeMZXEzg_1756481355
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-45b74ec7cd0so14302455e9.2
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 08:29:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756481353; x=1757086153;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oSaj7LkopQWoJPM6ZoQASZJAf1eQ1iaM4v2fSFrSvao=;
 b=AtaRIv6zwlEyvhx0plH+IPMtyTjKerFjsVVYK6BrqCiZrK1vMSxMzIJ2DQ3o23seLQ
 YhnamHIoOf/2x+T/WvD9Q5ft/36rcG62/aHjtobzQtf3RKc9P5XjNf99srz2ns0v8S4B
 zGQEBxc+sDgRKbojgv8vBuwD28GmdJ5LaUQv0FKNe6zy7Lpl7WsukKuP+6ojUaXfkDWj
 2/csdxyvyZpSqvrVU4RMkHP3c6AZJTzUHVavFeBoBy9z5UDQogu4yxbIUmgYHYqLVvzP
 Sr/WT5H9KMF3R4+JDcGGYbjNPmKDNA62/KXtFrI6QEF0XSfwZ37qCvwvY8JeHhn7WEj8
 z/6A==
X-Gm-Message-State: AOJu0YyuVCpRdXRb8IX3+2PsGZfMQNSciOGDexjxjgdUV7DcyrfNxeRO
 3yIFnBnskxC9QfGkxKlDfzpGyLGx0H3baHa+TX0bifk1PgUmxKqVEtJsZOFm9R0x0COC3bKg5b2
 cSBfrK3YkhvC249DTvBUINeOcBdT8wJppi2KkahnHYcQUwOYN7fvB+0MLsge4u3JWtrto3Xu2NN
 GLtcEWeSBlZy/jDZA3hK41Z+llOkFRBGSTYD1P5bSE
X-Gm-Gg: ASbGnctrcXmLMMOBNrgGIln9msUPD8x9EFmwQLYUY6KhZOQTZ4Y4LmTqWiTsV7JbX4C
 s11itnDhlSDVX2PTqj+4FTeX3i+5ukryx88xx8WTLV3UBdBnUvrmj6ii0vvToPNaGDnTdlgBEqT
 7xipGa7YyMRv21zHAQeud+zdmOjtSuvrvsW51YCj9VZsgB9n9H7k0joyIcXGKBKN/19P5FstmEW
 tjO/6tQcw4iiBmVTWyuYqf3bD6K0DFyOGbTrrw5QQWR13PdHRet7esizAhGQGt9hgGVNXSOAVQf
 4vRHCTr/FjtNIRaxeX+bCihA8O/XONbBDvJ7vvfPkzicBXsl+UluZFHCSXtwvuBFkzordURFwAo
 fSbsvcflS7rCGj6dLwKLag4/i7DIcqh7hmjTXibe65Vw=
X-Received: by 2002:a05:600c:5491:b0:459:db80:c2d0 with SMTP id
 5b1f17b1804b1-45b517954ddmr224449255e9.7.1756481352792; 
 Fri, 29 Aug 2025 08:29:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlNYnU937bM8+S/KH3p6XVtZ3j6CCQWDEek9OgjfUs89ROwXtllFVVs7C6T4YqCbi/c8BHcQ==
X-Received: by 2002:a05:600c:5491:b0:459:db80:c2d0 with SMTP id
 5b1f17b1804b1-45b517954ddmr224448915e9.7.1756481352268; 
 Fri, 29 Aug 2025 08:29:12 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3d12c90a01bsm1325703f8f.31.2025.08.29.08.29.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 08:29:11 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com,
	richard.henderson@linaro.org,
	imammedo@redhat.com
Subject: [PATCH v2 00/18] accel, cpus: clean up cpu->exit_request
Date: Fri, 29 Aug 2025 17:28:51 +0200
Message-ID: <20250829152909.1589668-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

cpu->exit_request is used to kick vCPU threads into qemu_wait_io_event().
The code that handles the signaling of cpu->exit_request is messy, mostly
due to no one ever taking a look at it as a whole.  In fact already in commit
4b8523ee896 ("kvm: First step to push iothread lock out of inner run loop",
2015-07-01), the read of cpu->exit_request was placed outside the BQL
critical section without much attention to ordering; and it only got
worse from that point, in no small part due to a young and naive me.

This series is complementary to the cpu->interrupt_request cleanups
that Igor did in "memory: reintroduce BQL-free fine-grained PIO/MMIO"
(https://lore.kernel.org/qemu-devel/20250808120137.2208800-1-imammedo@redhat.com/T/),
and in fact includes some extra changes to interrupt_request at the
beginning.

v1->v2:
- new patches 1-8, leftovers from Igor's own cleanup
- patch 9: use "true" instead of 1, editorial cleanups
- dropped "accel/hvf: check exit_request before running the vCPU"
- patch 10: add more comments, use "true" instead of 1
- patch 12: use accel/tcg/tcg-accel-ops.h for prototype, split out
  patch 12 ("accel/tcg: inline cpu_exit()"), place user-mode
  emulation version of qemu_cpu_kick() in accel/tcg/user-exec.c
- patch 14: fix compilation errors
- patch 15: new, fixes infinite loops in user-mode emulation
- patches 16-17: split in two parts
- patch 18: improve commit message

Paolo Bonzini (18):
  target/ppc: limit cpu_interrupt_exittb to system emulation
  target/sparc: limit cpu_check_irqs to system emulation
  target/i386: limit a20 to system emulation
  target-arm: remove uses of cpu_interrupt() for user-mode emulation
  user-exec: remove cpu_interrupt() stub
  treewide: clear bits of cs->interrupt_request with
    cpu_reset_interrupt()
  cpu-common: use atomic access for interrupt_request
  cpus: document that qemu_cpu_kick() can be used for BQL-less operation
  accel: use store_release/load_acquire for cross-thread exit_request
  accel: use atomic accesses for exit_request
  accel/tcg: create a thread-kick function for TCG
  accel/tcg: inline cpu_exit()
  cpus: remove TCG-ism from cpu_exit()
  cpus: properly kick CPUs out of inner execution loop
  bsd-user, linux-user: introduce qemu_wait_io_event
  cpus: clear exit_request in qemu_wait_io_event
  accel: make all calls to qemu_wait_io_event look the same
  tcg/user: do not set exit_request gratuitously

 docs/devel/tcg-icount.rst           |   2 +-
 accel/tcg/tcg-accel-ops-mttcg.h     |   3 -
 accel/tcg/tcg-accel-ops.h           |   1 +
 bsd-user/aarch64/target_arch_cpu.h  |   2 +-
 bsd-user/arm/target_arch_cpu.h      |   2 +-
 bsd-user/i386/target_arch_cpu.h     |   2 +-
 bsd-user/riscv/target_arch_cpu.h    |   2 +-
 bsd-user/x86_64/target_arch_cpu.h   |   2 +-
 include/hw/core/cpu.h               |  22 +-
 include/system/cpus.h               |   1 -
 target/arm/internals.h              |   5 +
 accel/dummy-cpus.c                  |   2 +-
 accel/hvf/hvf-accel-ops.c           |   2 +-
 accel/kvm/kvm-accel-ops.c           |   3 +-
 accel/kvm/kvm-all.c                 |  23 +-
 accel/tcg/cpu-exec.c                |  34 ++-
 accel/tcg/tcg-accel-ops-mttcg.c     |  12 +-
 accel/tcg/tcg-accel-ops-rr.c        |  42 +--
 accel/tcg/tcg-accel-ops.c           |   4 +-
 accel/tcg/user-exec.c               |  11 +-
 bsd-user/main.c                     |   5 -
 cpu-common.c                        |   3 +-
 hw/core/cpu-common.c                |  19 +-
 hw/core/cpu-system.c                |   2 +-
 hw/ppc/ppc.c                        |   2 +
 hw/ppc/spapr_hcall.c                |   7 +-
 hw/ppc/spapr_rtas.c                 |   2 +-
 linux-user/aarch64/cpu_loop.c       |   2 +-
 linux-user/alpha/cpu_loop.c         |   2 +-
 linux-user/arm/cpu_loop.c           |   2 +-
 linux-user/hexagon/cpu_loop.c       |   2 +-
 linux-user/hppa/cpu_loop.c          |   2 +-
 linux-user/i386/cpu_loop.c          |   2 +-
 linux-user/loongarch64/cpu_loop.c   |   2 +-
 linux-user/m68k/cpu_loop.c          |   2 +-
 linux-user/main.c                   |   5 -
 linux-user/microblaze/cpu_loop.c    |   2 +-
 linux-user/mips/cpu_loop.c          |   2 +-
 linux-user/openrisc/cpu_loop.c      |   2 +-
 linux-user/ppc/cpu_loop.c           |   2 +-
 linux-user/riscv/cpu_loop.c         |   2 +-
 linux-user/s390x/cpu_loop.c         |   2 +-
 linux-user/sh4/cpu_loop.c           |   2 +-
 linux-user/sparc/cpu_loop.c         |   2 +-
 linux-user/xtensa/cpu_loop.c        |   2 +-
 replay/replay-events.c              |   3 +-
 system/cpu-timers.c                 |   6 +-
 system/cpus.c                       |   9 +-
 target/arm/cpu-irq.c                | 381 ++++++++++++++++++++++++++++
 target/arm/cpu.c                    | 370 ---------------------------
 target/arm/el2-stubs.c              |  37 +++
 target/arm/helper.c                 |   4 +
 target/arm/tcg/mte_helper.c         |   2 +-
 target/avr/helper.c                 |   4 +-
 target/i386/helper.c                |   2 +
 target/i386/hvf/x86hvf.c            |   8 +-
 target/i386/kvm/hyperv.c            |   1 -
 target/i386/kvm/kvm.c               |  20 +-
 target/i386/nvmm/nvmm-accel-ops.c   |   8 +-
 target/i386/nvmm/nvmm-all.c         |  19 +-
 target/i386/tcg/system/seg_helper.c |  13 +-
 target/i386/tcg/system/svm_helper.c |   2 +-
 target/i386/whpx/whpx-accel-ops.c   |   6 +-
 target/i386/whpx/whpx-all.c         |  23 +-
 target/openrisc/sys_helper.c        |   2 +-
 target/ppc/helper_regs.c            |   2 +
 target/rx/helper.c                  |   4 +-
 target/s390x/tcg/excp_helper.c      |   2 +-
 target/sparc/int32_helper.c         |   2 +
 target/sparc/int64_helper.c         |   2 +
 target/arm/meson.build              |   2 +
 71 files changed, 631 insertions(+), 559 deletions(-)
 create mode 100644 target/arm/cpu-irq.c
 create mode 100644 target/arm/el2-stubs.c

-- 
2.51.0


