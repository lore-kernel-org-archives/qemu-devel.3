Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5FE606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2026 15:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=treblig.org header.i=@treblig.org header.a=rsa-sha256 header.s=bytemarkmx header.b=qsnK4fTI
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKe26-0000YG-CR; Sat, 24 Oct 2026 11:51:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>)
 id 1xKe1w-0000Wh-42; Sat, 24 Oct 2026 11:51:37 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>)
 id 1xKe1t-0006uJ-QV; Sat, 24 Oct 2026 11:51:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=V4iZYoxy+XBZp3nhXDfm6iYmskBq0641TnPqJV9mKII=; b=qsnK4fTI54UGvy5h
 SVyQCel19WB/uH+ugCafgD1oOx9FcElkHdOU1eIZ9mjNNxk5mA/3j7P5GZF4T3beoBRK5fK5ghWGY
 SArNTN9/pS4E1kGdOzo+d9Rv0d0qjtht2h7xlHWgqy/m3vZolZMi9WVZn/j0YGuNcVNIFEdX7cWe3
 fNlnUg3HvMaYkMb9AkN1F0dlzTiiU9r622oNLXE5ZjGnNT7DR0/SX37ioF5+1/HY7Diuiue0YYGC8
 BRcGhu1Re38gk4erAm/hDe5qGWLzdaY7g11470NYZ4/o+3FWIOr5RkKFLuNrEEHhfz/HTVVLW8JCF
 bpYdLJKvLQ1yziw3lw==;
Received: from dg by mx.treblig.org with local (Exim 4.98.2)
 (envelope-from <dg@treblig.org>) id 1xKe1j-00000002QqZ-1uLX;
 Sat, 24 Oct 2026 15:51:23 +0000
Date: Sat, 24 Oct 2026 15:51:23 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>,
 Zhao Liu <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 Max Filippov <jcmvbkbc@gmail.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>
Subject: Re: [PATCH v3 00/18] monitor/hmp: replace MonitorDef with GDB
 registers
Message-ID: <atzT-0QHYWByMhEg@gallifrey>
References: <20261022-query-reg-v3-0-7ad902b9a7cf@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261022-query-reg-v3-0-7ad902b9a7cf@redhat.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.12.113+deb13-amd64 (x86_64)
X-Uptime: 15:50:55 up 8 days, 1:11, 2 users, load average: 0.11, 0.04, 0.01
User-Agent: Mutt/2.2.13 (2024-03-09)
Received-SPF: pass client-ip=2a00:1098:5b::1; envelope-from=dg@treblig.org;
 helo=mx.treblig.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

* Marc-André Lureau (marcandre.lureau@redhat.com) wrote:
> Hi,
> 
> HMP monitor supports printing $register expression. The lookup
> was done via GDB stub registers, and supplementary MonitorDef
> HMP-specific tables.

Why don't you get the first ~3 of these merged and then you can take the
others through the individual targets at their own pace.

Dave

> Migrate HMP registers to use the GDB infrastructure and remove the
> legacy HMP MonitorDef. Internal registers aren't exposed to GDB.
> This also drops HMP $pc x86 fallback (use $eip/$rip instead).
> 
> Known behavioural changes on RISC-V: CSR lookup is now case-sensitive
> and vector registers now report "unkown register" instead of a
> target-specific message ("Unable to print the value of vector vreg 'v0'
> from this API")
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
> Changes in v3:
> - added x86 GDB register patches
>   - fix the x87 FPU tag word returned by the GDB stub
>   - split SSE registers into a separate org.gnu.gdb.i386.sse feature
>   - expose AVX/AVX-512 registers (ymm/zmm upper halves and opmask)
>   - expose more system registers to HMP
> - renamed i386-segments.xml to i386-system.xml and registered it as an
>   internal feature, like the other targets
> - moved the HMP $pc removal to its own patch and documented it in
>   removed-features.rst
> - moved each target's MonitorDef removal into its target patch; the final
>   patch now only removes the generic MonitorDef infrastructure
> - added MAINTAINERS entries
> - rebased onto current master
> - Link to v2: https://lore.kernel.org/qemu-devel/20261013-query-reg-v2-0-6f95a2e139a9@redhat.com
> 
> Changes in v2:
> - dropped v1 patch 5 (CPUClass::get_pc fallback for $pc)
> - new patch gdb_register_internal_coprocessor() to hide registers from GDB
> - SPARC64, m68k, RISC-V aliases now use internal registration
> - pickup trailer tags
> - Link to v1: https://lore.kernel.org/qemu-devel/20260911-query-reg-v1-0-0c04f0c02cf3@redhat.com
> 
> ---
> Marc-André Lureau (18):
>       hmp: don't crash on invalid register
>       gdbstub: fix next register base after register gaps
>       gdbstub: set feature->base_reg for dynamic features
>       gdbstub: add gdb_register_internal_coprocessor()
>       MAINTAINERS: cover x86 GDB XML files
>       target/i386: expose segment limits register to monitors via gdbstub
>       target/i386: fix FPU tag word in GDB register read
>       target/i386: split SSE registers into separate GDB feature
>       target/i386: expose system registers to monitors via gdbstub
>       target/i386: expose AVX/AVX-512 registers to GDB
>       target/i386: drop HMP $pc
>       MAINTAINERS: cover m68k GDB XML files
>       target/m68k: expose system registers to monitors via gdbstub
>       target/sparc64: expose system registers to monitors via gdbstub
>       target/riscv: bypass smstateen check in debugger mode
>       MAINTAINERS: cover riscv GDB XML files
>       target/riscv: expose register aliases to monitors via gdbstub
>       monitor/hmp: remove legacy MonitorDef infrastructure
> 
>  MAINTAINERS                               |   4 +
>  configs/targets/i386-bsd-user.mak         |   2 +-
>  configs/targets/i386-linux-user.mak       |   2 +-
>  configs/targets/i386-softmmu.mak          |   2 +-
>  configs/targets/m68k-softmmu.mak          |   2 +-
>  configs/targets/riscv32-linux-user.mak    |   2 +-
>  configs/targets/riscv32-softmmu.mak       |   2 +-
>  configs/targets/riscv64-bsd-user.mak      |   2 +-
>  configs/targets/riscv64-linux-user.mak    |   2 +-
>  configs/targets/riscv64-softmmu.mak       |   2 +-
>  configs/targets/sparc64-softmmu.mak       |   2 +-
>  configs/targets/x86_64-bsd-user.mak       |   2 +-
>  configs/targets/x86_64-linux-user.mak     |   2 +-
>  configs/targets/x86_64-softmmu.mak        |   2 +-
>  docs/about/removed-features.rst           |   8 +
>  gdbstub/gdb-xml/i386-32bit-avx.xml        |  20 ++
>  gdbstub/gdb-xml/i386-32bit-avx512.xml     |  31 +++
>  gdbstub/gdb-xml/i386-32bit-sse.xml        |  54 +++++
>  gdbstub/gdb-xml/i386-32bit.xml            |  46 +---
>  gdbstub/gdb-xml/i386-64bit-avx.xml        |  28 +++
>  gdbstub/gdb-xml/i386-64bit-avx512.xml     | 108 +++++++++
>  gdbstub/gdb-xml/i386-64bit-sse.xml        |  62 +++++
>  gdbstub/gdb-xml/i386-64bit.xml            |  50 ----
>  gdbstub/gdb-xml/i386-system.xml           |  53 +++++
>  gdbstub/gdb-xml/m68k-system.xml           |  32 +++
>  gdbstub/gdb-xml/riscv-32bit-alias.xml     | 105 +++++++++
>  gdbstub/gdb-xml/riscv-32bit-fpu-alias.xml |  40 ++++
>  gdbstub/gdb-xml/riscv-64bit-alias.xml     | 105 +++++++++
>  gdbstub/gdb-xml/riscv-64bit-fpu-alias.xml |  46 ++++
>  gdbstub/gdb-xml/sparc64-system.xml        |  22 ++
>  gdbstub/gdbstub.c                         |  85 +++++--
>  include/exec/gdbstub.h                    |  21 ++
>  include/hw/core/cpu.h                     |   5 +-
>  include/hw/core/sysemu-cpu-ops.h          |  16 --
>  include/monitor/hmp.h                     |   6 -
>  include/qemu/typedefs.h                   |   1 -
>  monitor/hmp.c                             |  45 +---
>  target/arm/gdbstub.c                      |   8 +-
>  target/arm/gdbstub64.c                    |  10 +-
>  target/i386/cpu-dump.c                    |   5 +-
>  target/i386/cpu.c                         |  60 +++--
>  target/i386/cpu.h                         |  25 ++
>  target/i386/gdbstub.c                     | 373 +++++++++++++++++++++++++++---
>  target/i386/tcg/fpu_helper.c              |  24 +-
>  target/m68k/cpu.c                         |  22 --
>  target/m68k/helper.c                      |  49 +++-
>  target/ppc/gdbstub.c                      |   2 +-
>  target/riscv/cpu.c                        |   1 -
>  target/riscv/gdbstub.c                    |  57 ++++-
>  target/riscv/internals.h                  |   3 -
>  target/riscv/monitor.c                    | 140 -----------
>  target/riscv/tcg/csr.c                    |   3 +-
>  target/sparc/cpu.c                        |  19 --
>  target/sparc/gdbstub.c                    |  38 +++
>  target/xtensa/cpu.c                       |   2 +-
>  tests/qtest/test-hmp.c                    |   1 -
>  56 files changed, 1383 insertions(+), 478 deletions(-)
> ---
> base-commit: 8967b2fe1b2aaae3c29e207d85fab901d580a2dc
> change-id: 20260910-query-reg-80cd59cf4707
> 
> Best regards,
> --  
> Marc-André Lureau <marcandre.lureau@redhat.com>
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

