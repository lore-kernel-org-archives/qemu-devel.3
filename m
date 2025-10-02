Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74AFACAC5B0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 17:18:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4MuR-0000YA-Se; Thu, 02 Oct 2025 13:16:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v4MuP-0000Xo-LV
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 13:16:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v4MuE-0005bm-5g
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 13:16:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759425342;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=M1t6cDpG0q0fXLpiuoZAIrJ3ccDAeJmSMorWF9+uPOI=;
 b=hpdLXemXpAe7jEojh86XlNyJOjT7OdI3/ZgKRkpLe/X5R+uTIiHRDPZBJ9fF2APzEaCkWv
 Sqr0vIUIpOKECcXMv0efd8PAFD3awQjfsO2VElE4rgHf0DyYYpZypMbVWpgcSwcfOM64gH
 MgathzWH3l7eA55KFsubuCZUbBVMAQg=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-Lkz_c5DuNTS_0ZbzGjXdeg-1; Thu, 02 Oct 2025 13:15:41 -0400
X-MC-Unique: Lkz_c5DuNTS_0ZbzGjXdeg-1
X-Mimecast-MFC-AGG-ID: Lkz_c5DuNTS_0ZbzGjXdeg_1759425340
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-6232f49fc79so1272047a12.2
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 10:15:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759425339; x=1760030139;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=M1t6cDpG0q0fXLpiuoZAIrJ3ccDAeJmSMorWF9+uPOI=;
 b=DNf58hYD3CquU2JjyNMh3UCOOZ2q8nWjq48XawkJTSgk/i//vnBsfGY0ruoR6096hS
 WO7JLrEzkCer2KDZE3TcQYkJqGccxOxyxj5od28cDeqYMD7Pj2xlgGN4WS7w2ZaabLzp
 wCCMZOqVhdWZk5TUGzf1xkvJXMCkZVjm/30q+ngT+tlWcg9KupfTzwBDAgbQ7pAwrO/S
 aiu/5/2mCXsF4rhwG/wtZ4P45497SIPSt1UwEEpvxAtqjf60/VEFVarRGzUSHcsvm1Yv
 Uu2kmZ/uiPkVA2RohcYf7HrN91TDbAhhUVn1EHwh7u99XBqpETF5BMfmHD9E34F9n6+f
 Gzyw==
X-Gm-Message-State: AOJu0YxaLyGyFhyU/XxEBfizLYSYb1G06vKNKdvvww3hSh/hfumw6sxY
 6OBz1tqndGIHW/yasLXRiY4Wof1UtwUrGbBh2qKHH7dR2HAyAzpF6AWmFFOsA9lPoMncE9LzDjA
 voVks/wSogMrPVONwGUljozmAN4pPr+IMc08uNRATpDivGzrbZtL2Ee6LJ8P5RJuu4dwpgDcGJq
 Ug5TweJJ/XQ9h/SD4gNzQgF6vLv4benK4hYDbdt17K
X-Gm-Gg: ASbGncstDex5/wQAetogpsiYaODTWx6KlCWoLX/MW58oQmHloACfTNfUNIHuUOe1yJb
 fgGjqjlDVFFxHmgmytlZF6hZIpo2jzDbg/GU1hbYmlTJS1M5jc2u4I6XhfD9PoKlZHg6T+GUgm+
 mHTs/VRne8a9mul2pgaZux/2jHjMLR3k4+IHXbiGrWIxr99UjeTUYTmkqYcU7hFMpQgcGypRjpo
 vpWtIGpFGxfry2lGueh6titHi/6eKsISWD1ou7LAPSEOSM0WHm/xOvMbHRV2ktE/WU/g//2LXNM
 PaonTzMx2jB/XSJFrm9mzEY4z3pgsQ2krd18x1sH3cFeaHfEnHdJExQrtg2gfxpIGuKJZu1A/v8
 6J/k9ALSgoUKEShyIV8HTC2c/QvvHArFoCV124DI25t1fqQCd
X-Received: by 2002:aa7:c614:0:b0:634:a099:beaf with SMTP id
 4fb4d7f45d1cf-63678c9f526mr6278854a12.38.1759425338918; 
 Thu, 02 Oct 2025 10:15:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGnnX8HAa16hf1TaRqoyWvGhjFhgrZtLzWMdn9Gukn+oqXlPxkZK8qcAh6m71bKhaLtEZRuWg==
X-Received: by 2002:aa7:c614:0:b0:634:a099:beaf with SMTP id
 4fb4d7f45d1cf-63678c9f526mr6278826a12.38.1759425338431; 
 Thu, 02 Oct 2025 10:15:38 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.91.106])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6376b3abcfcsm2193419a12.9.2025.10.02.10.15.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Oct 2025 10:15:37 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, magnus.kulke@linux.microsoft.com, wei.liu@kernel.org
Subject: [PATCH v5 00/27] Implementing a MSHV (Microsoft Hypervisor)
 accelerator
Date: Thu,  2 Oct 2025 19:15:09 +0200
Message-ID: <20251002171536.1460049-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.451,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Hi Magnus,

this is your series with a lot of fixes to make it pass CI.  It's very
much untested but the changes are mostly concentrated in the headers,
where you obviously didn't have great coverage of target systems. :)

So I don't expect any huge issues, but anyway here it is for your testing.

The changes are:
- nits from Daniel's review
- add check for availability with --enable-whpx
- do not use __uN types outside linux-headers/
- add stubs in accel/stubs/mshv-stub.c
- do not include <linux/mshv.h> on files with Linux stubs
- split mshv.h/mshv_int.h to avoid conflicts with other accelerators
  (esp. in the definition of AccelCPUState)
- change first argument of mshv_request_interrupt to MshvState*
  (though it could go away altogether)
- fix double free of cpu->accel [Daniel]
- adjust for rename of qemu_wait_io_event()
- use MAX_CONST instead of MAX_SIZE
- adjust trace-events to use PRIx64

Thanks,

Paolo

Magnus Kulke (26):
  accel: Add Meson and config support for MSHV accelerator
  target/i386/emulate: Allow instruction decoding from stream
  target/i386/mshv: Add x86 decoder/emu implementation
  hw/intc: Generalize APIC helper names from kvm_* to accel_*
  include/hw/hyperv: Add MSHV ABI header definitions
  linux-headers/linux: Add mshv.h headers
  accel/mshv: Add accelerator skeleton
  accel/mshv: Register memory region listeners
  accel/mshv: Initialize VM partition
  accel/mshv: Add vCPU creation and execution loop
  accel/mshv: Add vCPU signal handling
  target/i386/mshv: Add CPU create and remove logic
  target/i386/mshv: Implement mshv_store_regs()
  target/i386/mshv: Implement mshv_get_standard_regs()
  target/i386/mshv: Implement mshv_get_special_regs()
  target/i386/mshv: Implement mshv_arch_put_registers()
  target/i386/mshv: Set local interrupt controller state
  target/i386/mshv: Register CPUID entries with MSHV
  target/i386/mshv: Register MSRs with MSHV
  target/i386/mshv: Integrate x86 instruction decoder/emulator
  target/i386/mshv: Write MSRs to the hypervisor
  target/i386/mshv: Implement mshv_vcpu_run()
  accel/mshv: Handle overlapping mem mappings
  target/i386/mshv: Use preallocated page for hvcall
  docs: Add mshv to documentation
  MAINTAINERS: Add maintainers for mshv accelerator

Praveen K Paladugu (1):
  qapi/accel: Allow to query mshv capabilities

 MAINTAINERS                      |   15 +
 docs/about/build-platforms.rst   |    2 +-
 docs/devel/codebase.rst          |    2 +-
 docs/glossary.rst                |    7 +-
 docs/system/introduction.rst     |    3 +
 meson.build                      |   14 +
 qapi/accelerator.json            |   29 +
 accel/mshv/trace.h               |   14 +
 include/hw/hyperv/hvgdk.h        |   20 +
 include/hw/hyperv/hvgdk_mini.h   |  817 ++++++++++++++
 include/hw/hyperv/hvhdk.h        |  249 +++++
 include/hw/hyperv/hvhdk_mini.h   |  102 ++
 include/monitor/hmp.h            |    1 +
 include/system/accel-irq.h       |   37 +
 include/system/hw_accel.h        |    1 +
 include/system/mshv.h            |   64 ++
 include/system/mshv_int.h        |  155 +++
 linux-headers/linux/mshv.h       |  291 +++++
 target/i386/cpu.h                |    4 +-
 target/i386/emulate/x86_decode.h |    9 +
 target/i386/emulate/x86_emu.h    |    2 +
 accel/accel-irq.c                |  106 ++
 accel/mshv/irq.c                 |  399 +++++++
 accel/mshv/mem.c                 |  563 ++++++++++
 accel/mshv/mshv-all.c            |  727 ++++++++++++
 accel/mshv/msr.c                 |  375 +++++++
 accel/stubs/mshv-stub.c          |   44 +
 hw/core/machine-hmp-cmds.c       |   15 +
 hw/core/machine-qmp-cmds.c       |   14 +
 hw/intc/apic.c                   |    8 +
 hw/intc/ioapic.c                 |   20 +-
 hw/virtio/virtio-pci.c           |   21 +-
 target/i386/emulate/x86_decode.c |   27 +-
 target/i386/emulate/x86_emu.c    |    3 +-
 target/i386/mshv/mshv-cpu.c      | 1763 ++++++++++++++++++++++++++++++
 target/i386/mshv/x86.c           |  297 +++++
 accel/Kconfig                    |    3 +
 accel/meson.build                |    3 +-
 accel/mshv/meson.build           |    9 +
 accel/mshv/trace-events          |   33 +
 accel/stubs/meson.build          |    1 +
 hmp-commands-info.hx             |   13 +
 meson_options.txt                |    2 +
 qemu-options.hx                  |   16 +-
 scripts/meson-buildoptions.sh    |    3 +
 scripts/update-linux-headers.sh  |    2 +-
 target/i386/emulate/meson.build  |    7 +-
 target/i386/meson.build          |    2 +
 target/i386/mshv/meson.build     |    8 +
 49 files changed, 6281 insertions(+), 41 deletions(-)
 create mode 100644 accel/mshv/trace.h
 create mode 100644 include/hw/hyperv/hvgdk.h
 create mode 100644 include/hw/hyperv/hvgdk_mini.h
 create mode 100644 include/hw/hyperv/hvhdk.h
 create mode 100644 include/hw/hyperv/hvhdk_mini.h
 create mode 100644 include/system/accel-irq.h
 create mode 100644 include/system/mshv.h
 create mode 100644 include/system/mshv_int.h
 create mode 100644 linux-headers/linux/mshv.h
 create mode 100644 accel/accel-irq.c
 create mode 100644 accel/mshv/irq.c
 create mode 100644 accel/mshv/mem.c
 create mode 100644 accel/mshv/mshv-all.c
 create mode 100644 accel/mshv/msr.c
 create mode 100644 accel/stubs/mshv-stub.c
 create mode 100644 target/i386/mshv/mshv-cpu.c
 create mode 100644 target/i386/mshv/x86.c
 create mode 100644 accel/mshv/meson.build
 create mode 100644 accel/mshv/trace-events
 create mode 100644 target/i386/mshv/meson.build

-- 
2.51.0


