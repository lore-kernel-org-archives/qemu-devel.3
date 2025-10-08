Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F89ECAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 17:16:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6Xji-000142-0U; Wed, 08 Oct 2025 13:13:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1v6Xje-00013s-Gq
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 13:13:54 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1v6XjR-00080T-37
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 13:13:54 -0400
Received: from example.com (unknown [167.220.208.72])
 by linux.microsoft.com (Postfix) with ESMTPSA id 425A02038B69;
 Wed,  8 Oct 2025 10:13:32 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 425A02038B69
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1759943613;
 bh=uKMlFWSrIIcyNpy76i3BC91gGvK9t3fe8XkXjAE3qBI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=EJ46ryi2DlFIixmPRBi9GeGxo8QjC7CHxrlo38OdUBmQGHCgd9zqpqEzkFvgEE9pd
 Jp3NewPCPvfrfuotHUI1F8NSgBiV7eCB9ZLTlLH8BnVJrDShCGFN5EUsg18UlBdnuV
 UO7cHuMuZIdwKJX8wTj6S+gWTdNB0kP35s+sGzoU=
Date: Wed, 8 Oct 2025 19:13:28 +0200
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, wei.liu@kernel.org
Subject: Re: [PATCH v5 00/27] Implementing a MSHV (Microsoft Hypervisor)
 accelerator
Message-ID: <aOabuIpMfmbSGX5i@example.com>
References: <20251002171536.1460049-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251002171536.1460049-1-pbonzini@redhat.com>
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Oct 02, 2025 at 07:15:09PM +0200, Paolo Bonzini wrote:

Hey Paolo,

thank you for the changes! I tested the series and it passed our CI.

I glanced over the changes, and the only thing that popped up would
be a typo in the first commit. (get_option('s/whpx/whpx/')

Best,

magnus

> Hi Magnus,
> 
> this is your series with a lot of fixes to make it pass CI.  It's very
> much untested but the changes are mostly concentrated in the headers,
> where you obviously didn't have great coverage of target systems. :)
> 
> So I don't expect any huge issues, but anyway here it is for your testing.
> 
> The changes are:
> - nits from Daniel's review
> - add check for availability with --enable-whpx
> - do not use __uN types outside linux-headers/
> - add stubs in accel/stubs/mshv-stub.c
> - do not include <linux/mshv.h> on files with Linux stubs
> - split mshv.h/mshv_int.h to avoid conflicts with other accelerators
>   (esp. in the definition of AccelCPUState)
> - change first argument of mshv_request_interrupt to MshvState*
>   (though it could go away altogether)
> - fix double free of cpu->accel [Daniel]
> - adjust for rename of qemu_wait_io_event()
> - use MAX_CONST instead of MAX_SIZE
> - adjust trace-events to use PRIx64
> 
> Thanks,
> 
> Paolo
> 
> Magnus Kulke (26):
>   accel: Add Meson and config support for MSHV accelerator
>   target/i386/emulate: Allow instruction decoding from stream
>   target/i386/mshv: Add x86 decoder/emu implementation
>   hw/intc: Generalize APIC helper names from kvm_* to accel_*
>   include/hw/hyperv: Add MSHV ABI header definitions
>   linux-headers/linux: Add mshv.h headers
>   accel/mshv: Add accelerator skeleton
>   accel/mshv: Register memory region listeners
>   accel/mshv: Initialize VM partition
>   accel/mshv: Add vCPU creation and execution loop
>   accel/mshv: Add vCPU signal handling
>   target/i386/mshv: Add CPU create and remove logic
>   target/i386/mshv: Implement mshv_store_regs()
>   target/i386/mshv: Implement mshv_get_standard_regs()
>   target/i386/mshv: Implement mshv_get_special_regs()
>   target/i386/mshv: Implement mshv_arch_put_registers()
>   target/i386/mshv: Set local interrupt controller state
>   target/i386/mshv: Register CPUID entries with MSHV
>   target/i386/mshv: Register MSRs with MSHV
>   target/i386/mshv: Integrate x86 instruction decoder/emulator
>   target/i386/mshv: Write MSRs to the hypervisor
>   target/i386/mshv: Implement mshv_vcpu_run()
>   accel/mshv: Handle overlapping mem mappings
>   target/i386/mshv: Use preallocated page for hvcall
>   docs: Add mshv to documentation
>   MAINTAINERS: Add maintainers for mshv accelerator
> 
> Praveen K Paladugu (1):
>   qapi/accel: Allow to query mshv capabilities
> 
>  MAINTAINERS                      |   15 +
>  docs/about/build-platforms.rst   |    2 +-
>  docs/devel/codebase.rst          |    2 +-
>  docs/glossary.rst                |    7 +-
>  docs/system/introduction.rst     |    3 +
>  meson.build                      |   14 +
>  qapi/accelerator.json            |   29 +
>  accel/mshv/trace.h               |   14 +
>  include/hw/hyperv/hvgdk.h        |   20 +
>  include/hw/hyperv/hvgdk_mini.h   |  817 ++++++++++++++
>  include/hw/hyperv/hvhdk.h        |  249 +++++
>  include/hw/hyperv/hvhdk_mini.h   |  102 ++
>  include/monitor/hmp.h            |    1 +
>  include/system/accel-irq.h       |   37 +
>  include/system/hw_accel.h        |    1 +
>  include/system/mshv.h            |   64 ++
>  include/system/mshv_int.h        |  155 +++
>  linux-headers/linux/mshv.h       |  291 +++++
>  target/i386/cpu.h                |    4 +-
>  target/i386/emulate/x86_decode.h |    9 +
>  target/i386/emulate/x86_emu.h    |    2 +
>  accel/accel-irq.c                |  106 ++
>  accel/mshv/irq.c                 |  399 +++++++
>  accel/mshv/mem.c                 |  563 ++++++++++
>  accel/mshv/mshv-all.c            |  727 ++++++++++++
>  accel/mshv/msr.c                 |  375 +++++++
>  accel/stubs/mshv-stub.c          |   44 +
>  hw/core/machine-hmp-cmds.c       |   15 +
>  hw/core/machine-qmp-cmds.c       |   14 +
>  hw/intc/apic.c                   |    8 +
>  hw/intc/ioapic.c                 |   20 +-
>  hw/virtio/virtio-pci.c           |   21 +-
>  target/i386/emulate/x86_decode.c |   27 +-
>  target/i386/emulate/x86_emu.c    |    3 +-
>  target/i386/mshv/mshv-cpu.c      | 1763 ++++++++++++++++++++++++++++++
>  target/i386/mshv/x86.c           |  297 +++++
>  accel/Kconfig                    |    3 +
>  accel/meson.build                |    3 +-
>  accel/mshv/meson.build           |    9 +
>  accel/mshv/trace-events          |   33 +
>  accel/stubs/meson.build          |    1 +
>  hmp-commands-info.hx             |   13 +
>  meson_options.txt                |    2 +
>  qemu-options.hx                  |   16 +-
>  scripts/meson-buildoptions.sh    |    3 +
>  scripts/update-linux-headers.sh  |    2 +-
>  target/i386/emulate/meson.build  |    7 +-
>  target/i386/meson.build          |    2 +
>  target/i386/mshv/meson.build     |    8 +
>  49 files changed, 6281 insertions(+), 41 deletions(-)
>  create mode 100644 accel/mshv/trace.h
>  create mode 100644 include/hw/hyperv/hvgdk.h
>  create mode 100644 include/hw/hyperv/hvgdk_mini.h
>  create mode 100644 include/hw/hyperv/hvhdk.h
>  create mode 100644 include/hw/hyperv/hvhdk_mini.h
>  create mode 100644 include/system/accel-irq.h
>  create mode 100644 include/system/mshv.h
>  create mode 100644 include/system/mshv_int.h
>  create mode 100644 linux-headers/linux/mshv.h
>  create mode 100644 accel/accel-irq.c
>  create mode 100644 accel/mshv/irq.c
>  create mode 100644 accel/mshv/mem.c
>  create mode 100644 accel/mshv/mshv-all.c
>  create mode 100644 accel/mshv/msr.c
>  create mode 100644 accel/stubs/mshv-stub.c
>  create mode 100644 target/i386/mshv/mshv-cpu.c
>  create mode 100644 target/i386/mshv/x86.c
>  create mode 100644 accel/mshv/meson.build
>  create mode 100644 accel/mshv/trace-events
>  create mode 100644 target/i386/mshv/meson.build
> 
> -- 
> 2.51.0
> 

