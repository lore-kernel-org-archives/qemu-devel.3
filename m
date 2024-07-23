Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8752FC3DA7E
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 01:07:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW3yc-0001g9-5w; Mon, 22 Jul 2024 21:06:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <porter@cs.unc.edu>) id 1sW3ya-0001cj-8s
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 21:06:00 -0400
Received: from mail-yb1-xb2e.google.com ([2607:f8b0:4864:20::b2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <porter@cs.unc.edu>) id 1sW3yX-0008Ok-0u
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 21:05:59 -0400
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-e05f4c63de6so5070295276.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 18:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cs.unc.edu; s=google; t=1721696754; x=1722301554; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Y/SrHLbpcnausg3tHycjoNPWJL7CYyUj5+62CMEO/OU=;
 b=D9vijxkI4LC8TD9o95DTg1EztQqhz3Ybdg3xk5gHFdZFbQ7M6XL0b7KMYYaglm1hJM
 pYZW6CLIOyEob8Cnq1/rKoKyy0ByMtv+GKc/00LqdwB8lAuhRx3eJRSUBNEaVz48Yowl
 mHEyh4X/VUBLab4oh0fWd1Ci665lQLUWokSJNFWBDU4Fo2QJchmxAxeOemSaHCMAem9Z
 ppaK2K4H2pEoa9HvumJ1Jmx9PJ71hwBPJJYwmsa3aXP7cdhfxRlS1KcW5sHEgQEOZ+Yu
 uxiHwUJ5kogj80ITqBPp5G6GdzNEvDeRN4phYdWxK3oym8SR2tvImoaO3KWIMx+urUCW
 yc1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721696754; x=1722301554;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Y/SrHLbpcnausg3tHycjoNPWJL7CYyUj5+62CMEO/OU=;
 b=lCN7uS5FmrDlIzTorxUEm7zT8dabbYTTIwS7vYuxsdClx3GC881dXzpHFr2zu+d8PU
 9XGF72jhealgHs0Sy+irsQWZuANsaW5ZpJqMuToNxkmr7JvLDpupf+w4zsejwKfDwbcJ
 ioyo2RGSzSOeyKdOy6GTVKKqqFYqD9gTgpqKYDY9l7KVnFdYkkJZEUclT0hJ/hj/wS41
 6ZHTx+hbXW5KBoNdkFQ4s5Jr5AMdaoHGjYuhD71oyDX8Lz38i2ZSWqTTiEuCrsm/552O
 KyVV2Svxkad8FVNts2sRWNx+p0TH2ie+2vrvXOsq0jIltI12Ki2BnjPDXc6MQHlfYEl0
 2rfQ==
X-Gm-Message-State: AOJu0YwU6qmhoMM/K+sN1tVpqa+A5jZT6bA1WTGjctmMMGuJyAf30X2M
 bAScSTUtnXGzSNtBxnN6xOyoA2WqR64sKexCpAip4f51XneJApB/4jUsSOuGzYxZzfixgUuaboZ
 O71Ij1Sd9vu41b4UPfmIx1kohseCB3ulLITuz+77xqyFcNcP2vXFUFa9xK9mTJrKGQMFdf1G3hN
 /R6xc5i10iqORkPGIu2RqaAeG/G6o8
X-Google-Smtp-Source: AGHT+IGy93/9BaR9EMJ1OUzlHCU6ccx4Hri4Vm2Ne+L/7DzbPvovnpQ4OCX/ztAwveFNpX+P/Vf9BQ==
X-Received: by 2002:a05:6902:729:b0:e08:54db:46bf with SMTP id
 3f1490d57ef6-e086fe5daa3mr13695619276.1.1721696753942; 
 Mon, 22 Jul 2024 18:05:53 -0700 (PDT)
Received: from kermit.cs.unc.edu (kermit.cs.unc.edu. [152.2.133.133])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-44f9cdc0cbdsm37953601cf.92.2024.07.22.18.05.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 18:05:53 -0700 (PDT)
From: Don Porter <porter@cs.unc.edu>
To: qemu-devel@nongnu.org
Cc: dave@treblig.org, peter.maydell@linaro.org, nadav.amit@gmail.com,
 richard.henderson@linaro.org, philmd@linaro.org, berrange@redhat.com,
 Don Porter <porter@cs.unc.edu>
Subject: [PATCH v4 0/7] Rework x86 page table walks
Date: Mon, 22 Jul 2024 21:05:38 -0400
Message-Id: <20240723010545.3648706-1-porter@cs.unc.edu>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2e;
 envelope-from=porter@cs.unc.edu; helo=mail-yb1-xb2e.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This version of the 'info pg' command adopts Peter Maydell's request
to write guest-agnostic page table iterator and accessor code, along
with architecture-specific hooks.  The first patch in this series
contributes a generic page table iterator and an x86 instantiation.
As a client, we first introduce an 'info pg' monitor command, as well
as a compressing callback hook for creating succinct page table
representations.

After this, each successive patch replaces an exisitng x86 page table
walker with a use of common iterator code.

I could use advice on how to ensure this is sufficiently well tested.
I used 'make check', 'make check-avocado', and 'make check-tcg' which
all behave comparably to master branch on my test system; what is the
typical standard for testing something like a page table related
change?

As far as generality, I have only attempted this on x86, but I expect
the design would work for any similar radix-tree style page table.

Per David Gilbert's suggestion, I was careful to ensure that monitor
calls do not perturb TLB state (see the read-only flag in some
functions).

Version 3 of this patch series moves 'info pg' into common monitor
code and implements the architecture-specific code hooks.  I did not
do this with the 'info mem' and 'info tlb' commands, since they have
implementations on other ISAs.

Version 4 of this patch series adopts significant feedback on both the
monitor side and the page table hooks.  I believe this addresses all
of the feedback from Richard Henderson on this, and considerably
reworked the code to use fewer hooks, recur on nested paging, and
hoist permission and reserved bit checking into common code.

Unfortunately, this exposes issues with nested paging and internal
virtualization APIs (or lack thereof).  AMD and Intel have some
architectural differences in how VM state is accessed; similarly, each
accelerator backend on qemu stores virtualization state in different
ways.  Since I cannot test the transitive closure of these
configurations, I focused on the test cases I had at hand (tcg and
kvm, with a guest that issues Intel-style EPT pages), and to detect
and warn on an unsupported configuration.

Finally, the only way to reliably get some architectural state from
kvm involved importing the vmcs12 definition from Linux.  I wasn't
sure whether to put this under the linux headers, or somewhere else,
since this definition is not in the standard Linux headers.

Thank you,
Don


Don Porter (7):
  Code motion: expose some TCG definitions for page table walk
    consolidation.
  Import vmcs12 definition from Linux/KVM
  Add an "info pg" command that prints the current page tables
  Convert 'info tlb' to use generic iterator.
  Convert 'info mem' to use generic iterator
  Convert x86_cpu_get_memory_mapping() to use generic iterators
  Convert x86_mmu_translate() to use common code.

 hmp-commands-info.hx                 |   13 +
 hw/core/cpu-sysemu.c                 |  168 +++-
 hw/core/machine-qmp-cmds.c           |  243 ++++++
 include/hw/core/cpu.h                |   78 +-
 include/hw/core/sysemu-cpu-ops.h     |  157 +++-
 include/monitor/hmp-target.h         |    1 +
 qapi/machine.json                    |   17 +
 system/memory_mapping.c              |    2 +-
 target/i386/arch_memory_mapping.c    | 1195 +++++++++++++++++++++-----
 target/i386/cpu.c                    |   25 +-
 target/i386/cpu.h                    |   64 +-
 target/i386/helper.c                 |   36 +
 target/i386/kvm/kvm.c                |   68 ++
 target/i386/kvm/vmcs12.h             |  213 +++++
 target/i386/monitor.c                |  797 +++++++----------
 target/i386/tcg/helper-tcg.h         |   32 +
 target/i386/tcg/seg_helper.c         |   36 -
 target/i386/tcg/sysemu/excp_helper.c |  454 +---------
 18 files changed, 2423 insertions(+), 1176 deletions(-)
 create mode 100644 target/i386/kvm/vmcs12.h

--
2.34.1

