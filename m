Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 113FBC48BF0
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 06:21:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raV6h-0002Ey-EU; Thu, 15 Feb 2024 01:20:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1raV6f-0002EH-64
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 01:20:25 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1raV6d-0005Ib-Aj
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 01:20:24 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1d91397bd22so3782575ad.0
 for <qemu-devel@nongnu.org>; Wed, 14 Feb 2024 22:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707978021; x=1708582821; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=bF+j8FzygWmODSNlRiznLtR6VKAc61eo4z7A0gqLfVk=;
 b=q5+ecHf1CTkfy/jBmM+krXs6c78WSjpflxe4gVXzakXG38oKcj+DKV6/YsvGM2jNQI
 K3TDJWc+5LmcyBVSPpYA8gAOyuUP4R4wkMbGjJY8vdlglkGrFELdytO+E1YjyRrtFaGA
 /N1xvWQz6MWAPKHLFdPnscYLM8zc7YxUWOuy3nVOZd/54fvKUorGhkacTvnSvLDWMRbV
 qrDMdh2NrIu1F9xjBK2f3Fj1vK9UdW59ramLe9p49ChcYc89a6IU4/BNK5vZhpMM2/RI
 0lU+uu0jbPxF9mNx5n21BpxgFwQZvobxyaoCl68RIvVWTBZFIJSnjFbTLv3covJydtjG
 +p3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707978021; x=1708582821;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bF+j8FzygWmODSNlRiznLtR6VKAc61eo4z7A0gqLfVk=;
 b=Dar0aKWytIg4icLtNdphQO4ACFt0EHGaGOhKpdQmcyH8/TnpuW77nQjlikFa1EUHqn
 FB1pzhSxeFMIZW+Uf3b5cHDbtB4gTaFH/vUXZK3Ay5pKfYgNpVfFJjkSM0qURSH9F/h8
 1bOtzq0u7e4jb3x+2xDg2qzeKdUmyxxa8IHyFbDnI4ieGeZXvhe884cfl2ZHpoAKCD5t
 /HhvwiV+bORdqu8S9kEyI+VJn7W4jhimrD3tajm+MohT7JDtX3M9Z47Tsogyj4fZbQrM
 NWV1Qsdobbbmu6Llh1o1wz8ZLU71wi98RdYQcvcbK8wPdqSqgKnhHsSyDhakbIs7HMrh
 0Q4A==
X-Gm-Message-State: AOJu0Yygjmo5SXH+IQReRb23gm/jqN1numS0pbZRON3N6Il3dSUMp+DL
 cQFedf2/5AR1sq90PjnUXfX+rSzT8aBTKUxMrrCeeDA1YF0rW2/gnY+bUWV1drnPPpi1qO5K91A
 B
X-Google-Smtp-Source: AGHT+IFMwVwgwP63RgWEALAgZ2+SY+v23lOsp6rtKV4WOzRs8SQvr5whCTsus4ub2QTt9z/8Vi1TUA==
X-Received: by 2002:a17:902:ecc1:b0:1d9:bf01:165d with SMTP id
 a1-20020a170902ecc100b001d9bf01165dmr1053169plh.10.1707978021007; 
 Wed, 14 Feb 2024 22:20:21 -0800 (PST)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 d5-20020a170902b70500b001d6f29c12f7sm464418pls.135.2024.02.14.22.20.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Feb 2024 22:20:20 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 00/36] linux-user: Improve host and guest page size handling
Date: Wed, 14 Feb 2024 20:19:42 -1000
Message-Id: <20240215062018.795056-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Changes for v4:
  * Split out do_munmap.
  * Incorporate review feedback.

Blurb from v1:

While working on mmap issues for 8.1, I noticed a lot of corner
cases of host != guest page size that we implement poorly.
This seems to be particularly visible on Apple M1 with 16k pages,
more so than Power with 64k pages for some reason.

Objective 1 is to deprecate and (essentially) disable the -p option.

The effect of -p is apparently confusing, so much so that our own
testsuite misuses it.  One cannot really change the host page size,
and pretending otherwise means that we don't treat the host memory
system correctly, and stuff breaks.

I have not yet done the same work for bsd-user.

Objective 2 is to allow the guest page size to change to match the host.

There are corner cases of host != guest page size will fail in odd ways.
For case of host > guest page size, the issues could be solved with
softmmu, allowing a non-linear mapping between host and guest addresses
and also disconnecting host and guest page permissions.

However, host < guest page has issues with SIGBUS which I believe to be
totally unfixable.  At minimum one would need to monitor changes to all
files mapped in the address space, but I'm sure there is much more.

But as always the best behaviour is obtained when the host and guest
page sizes match -- there are no corner cases to contend with.

There are a set of guests which can be configured to use multiple page
sizes, and therefore software developed for those guests (usually) does
not hard-code a particular page size.  For those, we can allow the
page size to vary and let the guest match the host.

I have only changed aarch64, alpha and ppc guests so far, as those
are both easy to test and, especially for the case of alpha's default
8k page size, prone to failure.


r~


Richard Henderson (36):
  accel/tcg: Remove qemu_host_page_size from page_protect/page_unprotect
  linux-user: Adjust SVr4 NULL page mapping
  linux-user: Remove qemu_host_page_{size, mask} in probe_guest_base
  linux-user: Remove qemu_host_page_size from create_elf_tables
  linux-user/hppa: Simplify init_guest_commpage
  linux-user/nios2: Remove qemu_host_page_size from init_guest_commpage
  linux-user/arm: Remove qemu_host_page_size from init_guest_commpage
  linux-user: Remove qemu_host_page_{size, mask} from mmap.c
  linux-user: Remove REAL_HOST_PAGE_ALIGN from mmap.c
  linux-user: Remove HOST_PAGE_ALIGN from mmap.c
  migration: Remove qemu_host_page_size
  hw/tpm: Remove HOST_PAGE_ALIGN from tpm_ppi_init
  softmmu/physmem: Remove qemu_host_page_size
  softmmu/physmem: Remove HOST_PAGE_ALIGN
  linux-user: Remove qemu_host_page_size from main
  linux-user: Split out target_mmap__locked
  linux-user: Move some mmap checks outside the lock
  linux-user: Fix sub-host-page mmap
  linux-user: Split out mmap_end
  linux-user: Do early mmap placement only for reserved_va
  linux-user: Split out do_munmap
  linux-user: Use do_munmap for target_mmap failure
  linux-user: Split out mmap_h_eq_g
  linux-user: Split out mmap_h_lt_g
  linux-user: Split out mmap_h_gt_g
  tests/tcg: Remove run-test-mmap-*
  tests/tcg: Extend file in linux-madvise.c
  *-user: Deprecate and disable -p pagesize
  cpu: Remove page_size_init
  accel/tcg: Disconnect TargetPageDataNode from page size
  linux-user: Allow TARGET_PAGE_BITS_VARY
  target/arm: Enable TARGET_PAGE_BITS_VARY for AArch64 user-only
  linux-user: Bound mmap_min_addr by host page size
  target/ppc: Enable TARGET_PAGE_BITS_VARY for user-only
  target/alpha: Enable TARGET_PAGE_BITS_VARY for user-only
  linux-user: Remove pgb_dynamic alignment assertion

 docs/about/deprecated.rst                 |  10 +
 docs/user/main.rst                        |   3 -
 bsd-user/qemu.h                           |   7 +
 include/exec/cpu-common.h                 |   7 -
 include/hw/core/cpu.h                     |   2 -
 target/alpha/cpu-param.h                  |  16 +-
 target/arm/cpu-param.h                    |   6 +-
 target/ppc/cpu-param.h                    |   9 +-
 accel/tcg/translate-all.c                 |   1 -
 accel/tcg/user-exec.c                     |  31 +-
 bsd-user/main.c                           |  22 +-
 cpu-target.c                              |  13 -
 hw/tpm/tpm_ppi.c                          |   3 +-
 linux-user/elfload.c                      |  68 +-
 linux-user/main.c                         |  34 +-
 linux-user/mmap.c                         | 767 +++++++++++++---------
 migration/ram.c                           |  22 +-
 system/physmem.c                          |  17 +-
 system/vl.c                               |   1 -
 target/arm/cpu.c                          |  51 +-
 tests/tcg/multiarch/linux/linux-madvise.c |   2 +
 tests/tcg/alpha/Makefile.target           |   3 -
 tests/tcg/arm/Makefile.target             |   3 -
 tests/tcg/hppa/Makefile.target            |   3 -
 tests/tcg/i386/Makefile.target            |   3 -
 tests/tcg/m68k/Makefile.target            |   3 -
 tests/tcg/multiarch/Makefile.target       |   9 -
 tests/tcg/ppc/Makefile.target             |  12 -
 tests/tcg/sh4/Makefile.target             |   3 -
 tests/tcg/sparc64/Makefile.target         |   6 -
 30 files changed, 674 insertions(+), 463 deletions(-)
 delete mode 100644 tests/tcg/ppc/Makefile.target
 delete mode 100644 tests/tcg/sparc64/Makefile.target

-- 
2.34.1


