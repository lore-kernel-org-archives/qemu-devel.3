Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0B44C28B28
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 18:36:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuFIb-0004Qw-Kv; Mon, 17 Mar 2025 14:34:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tuFIU-0004PD-1H
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 14:34:46 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tuFIG-00068q-MO
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 14:34:44 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-22622ddcc35so20268075ad.2
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 11:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742236465; x=1742841265; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=RPbHwvloYIySCZWmnoL8Q2AUPe8llNmEPWBrsL/waLI=;
 b=vGYbSPI7QPk4hOer0pr3bcrcT7Bb/B/quFzVvsiyEBmHE/Pf2sk/dvbeG+dAYtrGFZ
 TPWwCGOHRbm3TmFab94y1Qz/59HHqI6Hny6dkXugHo8pnCujcYcwUGPLqVBD/Q+U7wRA
 lQ0sdodHSQ/ZtR/Ki6R24S98txQG8rgTcXPrKFNirTqRG0SFbUjNPQFHqqODjDojPTae
 mkydrDbe45/kwOsbWY9ADtlpFitk5DsXFgCHsaKim7OWwIbGfU2DBbJr1/SWoHt7l56E
 07N+fnuSf6KYeaSEzr0PwFkgnuHUX0e0ahisUdcMezzwLvAxCNOyfX07Qrx4lvgrk8hD
 Swlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742236465; x=1742841265;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RPbHwvloYIySCZWmnoL8Q2AUPe8llNmEPWBrsL/waLI=;
 b=FzBHM0o3qeuxFZvFsfj16Z7/9105eDmLf7E8+vsN4K0/MOBjWXyVFc5/tW+vBmDdt6
 K135cucYWxZaSmmBH+olB99Q6w9wEU1yFAENEjDo9fX66STwOUFhgggFSo4PfT7jyTyB
 wCxmPkOvb0JVbmlY1AM1TifQBgkkrBGUMzYMQNK4kAiDy/BSGJsAc62HvjPal7cp8BzQ
 iqK99LHg1GhBmgL1opVPyZbjXXKzGNC1bCv0cq1MP2yqN/MAXR0cLLBNjpg2bPRX2nO7
 VFrkLCODCkoZHF+AQz5abh5JBUnlvfeZH6Eyr3CcTxgqNkN9mauKO++AXMFRBD4mHr0b
 aoWQ==
X-Gm-Message-State: AOJu0YyXYOpCH2FnZQLNECl8+rvXkHuyn3t80NU1+M4AtNgcmsLGxFV+
 JzRwXnNXdEiInbUP6gDx3LdEw2Ym0oBtMc8YFCx/Fh0pzuXPvPN7qzhNHh8+yCmu0mRHdL100J9
 K
X-Gm-Gg: ASbGnct9p3/rQRtbs73e48hjcbHYGcR9QPwnXtLWy0aPvD0nQV10q+z60Upry1mdPna
 wVluuMuATt0so7gXqufNek0ejlepaFOlRH8iDG4y3M6TxTJu/VbGS8E1bzrsQorywtCOo8jn64W
 6JenKR/S4LaSGKu+VtwrBK/ulmbnnL8G1UdLNfFPvdjTiIrCb2aObH8nf7AZz8a3Sw00C2mZPHs
 /4yTBUpI3ETOcQqtfv3D/fc+QQl4wH8f5vZ7buPOc7JS/zUVwKN2lUfSYaxT3UclGIpnWVEzQC0
 zID73+zcYG/0vz8/QAuw8jqYXPmwpqiO115YFRJaSxzK
X-Google-Smtp-Source: AGHT+IHpwrE/9GG9C2SlpcasgbLprVybd7V3qfmK368RSyHmuII8fQHqzJpX5Xu5Sns9RSpMe6xOTQ==
X-Received: by 2002:a05:6a20:6a0c:b0:1f5:8903:860f with SMTP id
 adf61e73a8af0-1fa4428f303mr888720637.14.1742236464910; 
 Mon, 17 Mar 2025 11:34:24 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73711695a2esm8188770b3a.144.2025.03.17.11.34.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Mar 2025 11:34:24 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paul Durrant <paul@xen.org>, xen-devel@lists.xenproject.org,
 David Hildenbrand <david@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-riscv@nongnu.org,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, alex.bennee@linaro.org,
 manos.pitsidianakis@linaro.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>, kvm@vger.kernel.org,
 Palmer Dabbelt <palmer@dabbelt.com>, Peter Xu <peterx@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Anthony PERARD <anthony@xenproject.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 00/18] make system memory API available for common code
Date: Mon, 17 Mar 2025 11:33:59 -0700
Message-Id: <20250317183417.285700-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

The main goal of this series is to be able to call any memory ld/st function
from code that is *not* target dependent. As a positive side effect, we can
turn related system compilation units into common code.

The first 5 patches remove dependency of memory API to cpu headers and remove
dependency to target specific code. This could be a series on its own, but it's
great to be able to turn system memory compilation units into common code to
make sure it can't regress, and prove it achieves the desired result.

The next patches remove more dependencies on cpu headers (exec-all,
memory-internal, ram_addr).
Then, we add access to a needed function from kvm, some xen stubs, and we
finally can turn our compilation units into common code.

Every commit was tested to build correctly for all targets (on windows, linux,
macos), and the series was fully tested by running all tests we have (linux,
x86_64 host).

v2:
- reorder first commits (tswap change first, so memory cached functions can use it)
- move st/ld*_p functions to tswap instead of bswap
- add define for target_words_bigendian when COMPILING_PER_TARGET, equals to
  TARGET_BIG_ENDIAN (avoid overhead in target code)
- rewrite devend_memop
- remove useless exec-all.h in concerned patch
- extract devend_big_endian function to reuse in system/memory.c
- rewrite changes to system/memory.c

v3:
- move devend functions to memory_internal.h
- completed description for commits removing cpu.h dependency

v4:
- rebase on top of master
  * missing include in 'codebase: prepare to remove cpu.h from exec/exec-all.h'
  * meson build conflict

v5:
- remove extra xen stub xen_invalidate_map_cache()
- edit xen stubs commit message

v6:
- remove xen inline stubs from headers

Pierrick Bouvier (18):
  exec/tswap: target code can use TARGET_BIG_ENDIAN instead of
    target_words_bigendian()
  exec/tswap: implement {ld,st}.*_p as functions instead of macros
  exec/memory_ldst: extract memory_ldst declarations from cpu-all.h
  exec/memory_ldst_phys: extract memory_ldst_phys declarations from
    cpu-all.h
  exec/memory.h: make devend_memop "target defines" agnostic
  codebase: prepare to remove cpu.h from exec/exec-all.h
  exec/exec-all: remove dependency on cpu.h
  exec/memory-internal: remove dependency on cpu.h
  exec/ram_addr: remove dependency on cpu.h
  system/kvm: make kvm_flush_coalesced_mmio_buffer() accessible for
    common code
  exec/ram_addr: call xen_hvm_modified_memory only if xen is enabled
  hw/xen: add stubs for various functions
  system/xen: remove inline stubs
  system/physmem: compilation unit is now common to all targets
  include/exec/memory: extract devend_big_endian from devend_memop
  include/exec/memory: move devend functions to memory-internal.h
  system/memory: make compilation unit common
  system/ioport: make compilation unit common

 include/exec/cpu-all.h              | 66 -----------------------
 include/exec/exec-all.h             |  1 -
 include/exec/memory-internal.h      | 21 +++++++-
 include/exec/memory.h               | 30 ++++-------
 include/exec/ram_addr.h             | 11 ++--
 include/exec/tswap.h                | 81 +++++++++++++++++++++++++++--
 include/system/kvm.h                |  6 +--
 include/system/xen-mapcache.h       | 41 ---------------
 include/system/xen.h                | 21 ++------
 include/tcg/tcg-op.h                |  1 +
 target/ppc/helper_regs.h            |  2 +
 include/exec/memory_ldst.h.inc      |  4 --
 include/exec/memory_ldst_phys.h.inc |  5 +-
 cpu-target.c                        |  1 +
 hw/ppc/spapr_nested.c               |  1 +
 hw/sh4/sh7750.c                     |  1 +
 hw/xen/xen_stubs.c                  | 51 ++++++++++++++++++
 page-vary-target.c                  |  2 +-
 system/ioport.c                     |  1 -
 system/memory.c                     | 17 ++----
 target/ppc/tcg-excp_helper.c        |  1 +
 target/riscv/bitmanip_helper.c      |  2 +-
 hw/xen/meson.build                  |  3 ++
 system/meson.build                  |  6 +--
 24 files changed, 191 insertions(+), 185 deletions(-)
 create mode 100644 hw/xen/xen_stubs.c

-- 
2.39.5


