Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66BDCC9EC8E
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 13:24:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfHtM-0002RU-Hl; Mon, 12 Jan 2026 08:23:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vfHtK-0002MJ-Ae
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 08:23:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vfHtH-0003fQ-V4
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 08:23:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768224205;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=6kZoGVuiQ9m8xgDcAWMMxXPsJveaJtnkd37WK/Oqs0Q=;
 b=Q/bxUfYN/8TFmz01YASEh0tlRDdUEMOPHwhbogF8KT2iTr6fvdngmU1znGnKsB1R7e6oQv
 Uw6ES7Qe5D1Vh3kjMO+Gt/csYkJScWprN6BE88Iiva6TLGFCc+kPhROqzpToG73TRrXwhS
 zTQYRddflN39DUWPlWzAjOeg8ikl7uU=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-401-PFRTR_90No-ye_1zkdZ2yg-1; Mon, 12 Jan 2026 08:23:24 -0500
X-MC-Unique: PFRTR_90No-ye_1zkdZ2yg-1
X-Mimecast-MFC-AGG-ID: PFRTR_90No-ye_1zkdZ2yg_1768224203
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-34c5d6193daso11983624a91.1
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 05:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768224203; x=1768829003; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6kZoGVuiQ9m8xgDcAWMMxXPsJveaJtnkd37WK/Oqs0Q=;
 b=qQpIkqYEKoKG6m48NyX+HIZ/W07ey8JNKPkhd8RGMLbqrZc0uH2lxTjwmNrbraV6PW
 lmYWVNIzIwPMDt17mFTDdhW6t3Oxs0kzaf5QDAB8IQjmXIPNaIwzmWNH1TEJTrrhGRic
 Fp6OqFsHOppgKYKR0GycXXgcTyOeYayRaAJ7wcLctSrabpbQ+GxcFLqrilwE0woGpNHS
 sDfSdzYsjON4j7CePwXgW0mhER3CuIAAz8mzOmIn86VGc3qesIqzDruJ4u+DPIwcqTOv
 2ve53TZdnutuFrSLzRvXGPi/hgsZM8kyPqUuwqdSuOJu0tyIBOMa1yQeFklafukg1hUF
 rSLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768224203; x=1768829003;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6kZoGVuiQ9m8xgDcAWMMxXPsJveaJtnkd37WK/Oqs0Q=;
 b=wead5UFjAfRXCjIaJXZ6wtC56SQPJZq18Ny21EOH7TTlnvTeB1guYszkzlSVa/4tQ6
 9h7WBNA/WEIDNBVfCNyJQ7nIQnNJ81U2UQNq22ugvY7HGuDzyupiL8rMmOhMn3+foswk
 NHhuKRgbQOrjZq8xn+rg8E3qjjqxxhmT+EWPLYChcz4bPpdeW6SWsf+q6w7S9aeg3EWa
 aqQS669OKFx1O0YJ8kvbDSwsYSX9Ew6yc96dJ6WfWEqE7kSA0QnnpBxIjDdqjE4HNHan
 RmMD5coQQLpQzsMRCcAryh65pYDPYl4z7W3UvDQgjEyk3BpAXC3tuSaLl+Yl1Mgye/x8
 bcGw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjwdxkPAs6wMZcn6N+Ayi27VrbufIIp+15WWwm3YQOPH0CH7wrrHOmapWkjHYKW9qdaNMDLh5dfgcc@nongnu.org
X-Gm-Message-State: AOJu0YyvDxX0JUhHQJTlX+62EXq7dU6qCbQZoxb8RshdobBmBMCFw8az
 uxNW9yZHx/OjxzwKKAk9NQM8sY8GGEa6p40Mp7JCqnxVdiDbmrCYLMQ2d3F8erERMtKPnh1DVgv
 9L4qYnI3OzaoojhmCgebHq5rVT8m/D79tOz1VRoIUBP5IaGbH4MwoYgiK
X-Gm-Gg: AY/fxX7UExzHlD0++bTmQOYyNeu+wQYOT/gQ9qUP3o8f2LfICMq1ZMnLDLzukTrgmWk
 aMkyn5hjNQOJ35i/j6bN4mGq1LQxc5m8pUiIY0ghtm/9lmKUt+2nxZWaawDyCFUElHNXoNggQ+N
 V2d7ZUmex5TXPq/psI6u3GYS/qpfMcmAobQ7ME30KWlwdqwKanhtH5Tbny2xgbdc1IKI9w4KAvh
 tTAV4Wc2baqa3R+7cMcz/uhQxbK5KiPgvqiPqTtKoX5yvkEKyXioWCFCVGRF7ZBcdlQQQhZi49T
 v+Od1DzRyoHvnljw8Zf9FU9sR0eFEQX3hBUNvAFNxo7FEZf50Bf0KlcIuzGBJ4wlCfdCCtRn50s
 uCxtZlk0RtpeS4ghzW6TCg0aE9YJVkB8YhLvmQNDq4ic=
X-Received: by 2002:a05:6a21:32a7:b0:334:a11e:6bed with SMTP id
 adf61e73a8af0-3898f906fd5mr16669833637.29.1768224203169; 
 Mon, 12 Jan 2026 05:23:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHu+5KwknJcex3KlZ3X/YXU7mKrNuthNPxo/orJ0iAvQRTHU+laP0fREBK4cebA2X3veVzL/w==
X-Received: by 2002:a05:6a21:32a7:b0:334:a11e:6bed with SMTP id
 adf61e73a8af0-3898f906fd5mr16669809637.29.1768224202664; 
 Mon, 12 Jan 2026 05:23:22 -0800 (PST)
Received: from rhel9-box.lan ([110.227.88.119])
 by smtp.googlemail.com with ESMTPSA id
 41be03b00d2f7-c4cc05cd87asm17544771a12.15.2026.01.12.05.23.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jan 2026 05:23:22 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: 
Cc: Ani Sinha <anisinha@redhat.com>, qemu-devel@nongnu.org,
 pbonzini@redhat.com, kraxel@redhat.com, vkuznets@redhat.com,
 graf@amazon.com
Subject: [PATCH v2 00/32] Introduce support for confidential guest reset
Date: Mon, 12 Jan 2026 18:52:13 +0530
Message-ID: <20260112132259.76855-1-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This change introduces support for confidential guests
(SEV-ES, SEV-SNP and TDX) to reset/reboot just like other non-confidential
guests. Currently, a reboot intiated from the confidential guest results
in termination of the QEMU hypervisor as the CPUs are not resettable. As the
initial state of the guest including private memory is locked and encrypted,
the contents of that memory will not be accessible post reset. Hence a new
KVM file descriptor must be opened to create a new confidential VM context
closing the old one. All KVM VM specific ioctls must be called again. New
VCPU file descriptors must be created against the new KVM fd and most VCPU
ioctls must be called again as well.

This change perfoms closing of the old KVM fd and creating a new one. After
the new KVM fd is opened, all generic and architecture specific ioctl calls
are issued again. Notifiers are added to notify subsystems that:
- The KVM file fd is about to be changed to state sync-ing from KVM to QEMU
  should be done if required.
- The KVM file fd has changed, so ioctl calls to the new KVM fd has to be
  performed again.
- That new VCPU fds are created so that VCPU ioctl calls must be called again
  where required.

Specific subsystems use these notifiers to re-issue ioctl calls where required.

Changes are made to SEV and TDX modules to reinitialize the confidential guest
state and seal it again. Along the way, some bug fixes are made so that some
initialization functions can be called again. Some refactoring of existing
code is done so that both init and reset paths can use them.

Tested on TDX and SEV-SNP.
CI pipeline passes:
https://gitlab.com/anisinha/qemu/-/commit/eb647d2299ba8aac62a4bffbeb470c665c831421/pipelines?ref=coco-reboot-v2

Please review and test.

Changelog:

v2:
 - Bugfixes.
 - Added a new machine option so that we can exercize most of the non-coco changes
   related to reboot on non-coco platforms.
 - added a new functional test. Currently its skipped on CI pipeline as KVM is not
   enabled (no /dev/kvm on the container)for QEMU CI tests. It can be run manually and it
   passes on those systems where KVM is enabled.
 - Addressed comments from v1 with regards to refactoring of code, code simplication by
   removal of redundant stuff, moved around code
   so that notifiers, migration blockers are added only on one place.
 - Added some tracepoints for future debugging on newly added functions.
 - Rebased.

One thing I have not addressed in v2 is to combine pre and post notifiers into one
with a boolean argument to differentiate them. This will be addressed as a part of
v3 which is here: https://gitlab.com/anisinha/qemu/-/commits/coco-reboot-v3. The change
is getting tested: https://gitlab.com/anisinha/qemu/-/commit/7b3ef489a6d45c0282c851c38c54b6a2c3e2c20d
 
CC: qemu-devel@nongnu.org
CC: pbonzini@redhat.com
CC: kraxel@redhat.com
CC: vkuznets@redhat.com
CC: graf@amazon.com


Ani Sinha (32):
  i386/kvm: avoid installing duplicate msr entries in msr_handlers
  hw/accel: add a per-accelerator callback to change VM accelerator
    handle
  system/physmem: add helper to reattach existing memory after KVM VM fd
    change
  accel/kvm: add changes required to support KVM VM file descriptor
    change
  accel/kvm: mark guest state as unprotected after vm file descriptor
    change
  accel/kvm: add a notifier to indicate KVM VM file descriptor has
    changed
  accel/kvm: add notifier to inform that the KVM VM file fd is about to
    be changed
  i386/kvm: unregister smram listeners prior to vm file descriptor
    change
  kvm/i386: implement architecture support for kvm file descriptor
    change
  hw/i386: refactor x86_bios_rom_init for reuse in confidential guest
    reset
  kvm/i386: reload firmware for confidential guest reset
  accel/kvm: rebind current VCPUs to the new KVM VM file descriptor upon
    reset
  i386/tdx: refactor TDX firmware memory initialization code into a new
    function
  i386/tdx: finalize TDX guest state upon reset
  i386/tdx: add a pre-vmfd change notifier to reset tdx state
  i386/sev: add migration blockers only once
  i386/sev: add notifiers only once
  i386/sev: free existing launch update data and kernel hashes data on
    init
  i386/sev: add support for confidential guest reset
  hw/vfio: generate new file fd for pseudo device and rebind existing
    descriptors
  kvm/i8254: refactor pit initialization into a helper
  kvm/i8254: add support for confidential guest reset
  hw/hyperv/vmbus: add support for confidential guest reset
  accel/kvm: add a per-confidential class callback to unlock guest state
  kvm/xen-emu: re-initialize capabilities during confidential guest
    reset
  kvm/xen_evtchn: add support for confidential guest reset
  ppc/openpic: create a new openpic device and reattach mem region on
    coco reset
  kvm/vcpu: add notifiers to inform vcpu file descriptor change
  kvm/i386/apic: set local apic after vcpu file descriptors changed
  kvm/clock: add support for confidential guest reset
  hw/machine: introduce machine specific option 'x-change-vmfd-on-reset'
  tests/functional/x86_64: add functional test to exercise vm fd change
    on reset

 MAINTAINERS                                   |   6 +
 accel/kvm/kvm-all.c                           | 365 ++++++++++++++++--
 accel/kvm/trace-events                        |   2 +
 accel/stubs/kvm-stub.c                        |  26 ++
 hw/core/machine.c                             |  22 ++
 hw/hyperv/vmbus.c                             |  30 ++
 hw/i386/kvm/apic.c                            |  13 +
 hw/i386/kvm/clock.c                           |  56 +++
 hw/i386/kvm/i8254.c                           |  83 ++--
 hw/i386/kvm/xen_evtchn.c                      | 100 ++++-
 hw/i386/x86-common.c                          |  50 ++-
 hw/intc/openpic_kvm.c                         | 108 ++++--
 hw/vfio/helpers.c                             |  81 +++-
 include/accel/accel-ops.h                     |   1 +
 include/hw/core/boards.h                      |   6 +
 include/hw/i386/apic_internal.h               |   1 +
 include/hw/i386/x86.h                         |   5 +-
 include/system/confidential-guest-support.h   |  27 ++
 include/system/kvm.h                          |  55 +++
 include/system/physmem.h                      |   1 +
 system/physmem.c                              |  28 ++
 system/runstate.c                             |  36 +-
 target/arm/kvm.c                              |  10 +
 target/i386/kvm/kvm.c                         | 209 ++++++++--
 target/i386/kvm/tdx.c                         | 142 +++++--
 target/i386/kvm/tdx.h                         |   1 +
 target/i386/kvm/trace-events                  |   4 +
 target/i386/kvm/xen-emu.c                     |  45 ++-
 target/i386/sev.c                             |  97 ++++-
 target/i386/trace-events                      |   1 +
 target/loongarch/kvm/kvm.c                    |  10 +
 target/mips/kvm.c                             |  10 +
 target/ppc/kvm.c                              |  10 +
 target/riscv/kvm/kvm-cpu.c                    |  10 +
 target/s390x/kvm/kvm.c                        |  10 +
 tests/functional/x86_64/meson.build           |   1 +
 .../x86_64/test_vmfd_change_reboot.py         |  75 ++++
 37 files changed, 1544 insertions(+), 193 deletions(-)
 create mode 100755 tests/functional/x86_64/test_vmfd_change_reboot.py

-- 
2.42.0


