Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEDE4C2BA1B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 19:58:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts5kC-0000yP-St; Tue, 11 Mar 2025 15:58:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ts5jz-0000qJ-NW
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 15:58:17 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ts5jw-0008UD-S0
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 15:58:15 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-224100e9a5cso113421495ad.2
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 12:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741723091; x=1742327891; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BJxldrM9ls/rNwHOkfKDTsLlkFzxI4z634GC5RzciYk=;
 b=gNt1cvGJuhGpTH3MYysn9HKadCoGMja9x1abNSp/XzBJwNwd4hgRums1DgvkGAmNMW
 D94nau/wtuDmsrlzEppEQI+mMT+83yrHVNIopwH6TuUw1EZWn3bmEqXSEfJ6VPKahHYi
 ylwRWd/Hhpilyvr106HiBZkVG71l1R6JFMrEVDUlOHmKVj/TPm0MoGtc/ZqkcE7Ltvzo
 lHwQZ8Vvg3M/wL69BKvTFEfMPADY6wJ6HNQE5aiT19nDKgLJhI7VegLpzoogvGSvHF2J
 KWilWvKQpW3qk8rvYUeALWz3vAzvo0rFsIy6+v1bYpZBy7QPa1HZz1IGEAYftsz0jDXX
 ZBbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741723091; x=1742327891;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BJxldrM9ls/rNwHOkfKDTsLlkFzxI4z634GC5RzciYk=;
 b=TfKtrQ3nMTEvlHnUn5iGAgG/oKf12lWd4MJaUK7opC+O8QzHQAD+IhSXETBQl1IoB0
 4u/G3bNu1cavH1VFvxtCJUf8XiZC8EBU0Pbrzu80fNhQXv6OqnYQTNDOm6lssdxp+KAJ
 56V9dzr0c7tryPiIKXFi6XmsOqWCblCB4o0rGtd6xePT6pefCmsNrG0AQsHme69DCARZ
 /Yz7xTG1Bv57iQC4Fc5fXn4QMgNIEdGJ1SFEIi6ssogLwpPausc+nvULG7aWfahI4eHT
 M2Q+VV8776tIL+Plz3UD1dPxlgHwadxx0Dav6q1+HGaPMUtXijO+ruAsad7dmNVXEGre
 GrTA==
X-Gm-Message-State: AOJu0YwRgYmtkJDzofOae+BhSrCAvAegDZbhipNYAXTVMuD+JHo8uKAR
 4ifQfyIaXi+RUqV1PSSIVJcRUHN32IkSXaAgRkeKA/I94M7oJ52jte2Ik+bCo733AKBnaAkpSSI
 uOpk=
X-Gm-Gg: ASbGncv6l4KX2OCueKV5hvLAWB7HBpUYolSdDSitIcz0DOZO4PX/WylelqfsUkJVq4s
 iPfTIgftIL3TA8NpH6ObhoZPLIOzzTUK3riJLB/oaBR1jPihhbEjXt7XEn2w8DCZ2F9PKHoE9Ih
 vD7m//xand3BLT2sL0VySWADh/Vf+anALT0UnmJLBqhH3i0NG3f5vyq4ID6f4sHgXzBH7a2rzI0
 +BXOIczV+gsDbANg7QfmedVOED44mUzDgGTuPQ/UQX8RYmmyRk4hoKbhzIRKkcdFkBNl5Lc1L9Q
 nH5EaKn8U0XrYXji8HSt7JOPN2uHnDoUCCo/LoViVvrF
X-Google-Smtp-Source: AGHT+IHOrb1ktHbDIJg0LAeBD9OfAq2o4wANofPbWEj8d4iUXmKit5ZY6qUoI1jOxUcgyXZ2QfV68A==
X-Received: by 2002:a17:903:32ce:b0:223:39ae:a98 with SMTP id
 d9443c01a7336-22428a98102mr318619255ad.22.1741723090697; 
 Tue, 11 Mar 2025 12:58:10 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736a6e5c13asm9646981b3a.157.2025.03.11.12.58.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 12:58:10 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Anthony PERARD <anthony@xenproject.org>, xen-devel@lists.xenproject.org,
 Nicholas Piggin <npiggin@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>, kvm@vger.kernel.org,
 Palmer Dabbelt <palmer@dabbelt.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paul Durrant <paul@xen.org>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 manos.pitsidianakis@linaro.org, Peter Xu <peterx@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alistair Francis <alistair.francis@wdc.com>, alex.bennee@linaro.org,
 Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-riscv@nongnu.org,
 qemu-ppc@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 00/17] make system memory API available for common code
Date: Tue, 11 Mar 2025 12:57:46 -0700
Message-Id: <20250311195803.4115788-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Pierrick Bouvier (17):
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
 include/tcg/tcg-op.h                |  1 +
 target/ppc/helper_regs.h            |  2 +
 include/exec/memory_ldst.h.inc      |  4 --
 include/exec/memory_ldst_phys.h.inc |  5 +-
 cpu-target.c                        |  1 +
 hw/ppc/spapr_nested.c               |  1 +
 hw/sh4/sh7750.c                     |  1 +
 hw/xen/xen_stubs.c                  | 56 ++++++++++++++++++++
 page-vary-target.c                  |  2 +-
 system/ioport.c                     |  1 -
 system/memory.c                     | 17 ++----
 target/riscv/bitmanip_helper.c      |  2 +-
 hw/xen/meson.build                  |  3 ++
 system/meson.build                  |  6 +--
 21 files changed, 192 insertions(+), 126 deletions(-)
 create mode 100644 hw/xen/xen_stubs.c

-- 
2.39.5


