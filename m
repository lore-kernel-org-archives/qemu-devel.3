Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CE4606B2D7
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 13:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gV3Xl+NP
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQlTu-0007sQ-OL; Tue, 10 Nov 2026 08:01:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mdspan.github@gmail.com>)
 id 1xQlTW-0007kS-Pa
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 08:01:24 -0500
Received: from mail-pj2-x09.google.com ([2607:f8b0:4864:39::9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mdspan.github@gmail.com>)
 id 1xQlTU-0001NQ-K6
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 08:01:22 -0500
Received: by mail-pj2-x09.google.com with SMTP id
 98e67ed59e1d1-3b0ae89de91so1176638a91.1
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 05:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794315677; x=1794920477; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=buv1lLG1Unmw0s1ot2142WL2EkX+LdwAbA2NOjBXuKg=;
 b=gV3Xl+NPTWV4TD4SIH9Y4oi4mPXCpcI5xyniKw4HCNBaJvqtyZMsmOO8ODONYZAuy6
 ccY/aeDLCVaCn6Ri1gomNCpcEap4ceS+CZWdqeenhRvmkQF54f/vKesulHdPVHyhERS1
 iRMGQCejpdhDtdpUTvlNGW33yn2D0updgvg7ptFJRDSb7V2go8+9Zg3K8+YApy0jR+ph
 3ECv2aAWtUY6gBaGU4gjqyFTSnEyn3jEGlM06cou4AkiWouJ9+PjCwyzlaVLknLrJY8w
 0qXTUV08tNpHcRsw7/7AI2cA8+D2TjyNlGn9VMeCX8+VydKXox7HfJrV6kFmb1EnCM5B
 myYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794315677; x=1794920477;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=buv1lLG1Unmw0s1ot2142WL2EkX+LdwAbA2NOjBXuKg=;
 b=AvxuNShWHTNRm8Jkuq6eeN3MBTXtMy1pz2AlGjaDypaikQQ7P+ufmy+8GbwnXGzZz7
 zyvOPkXhWtIcQmfXYeHcujqHgRh0vQxOWwGCs2s72lIV+WxMtDTTWHDmG0OiF/W/3agh
 erKxem9HOp2QADouRvFFGZFn2Xy7tWkEX8HzeXmxpSiC8JthSRPQzlNV1DdpfL77eaOC
 9IP7ac/YdsPr6rUH15NbbTRnlx/WvPVx97B03IS/yAeZOItP+Jy1wa1slXY2u6k7gZwc
 5Jce3aw3g8LKMGq147l9ldJ6HZ1RVorsv05yCy4o+Vl10A2mYQ9ctTSpvBaHKhVbHjza
 GtPg==
X-Gm-Message-State: APuU4Z9CqPuI0Cdbbgq4fLThLmr9lTHHGv0Olquin3jSDdYgclF11yAn
 xFnGZK8kXn+OK6m504CEtDFAKwxQwRWu8s9OhiSRrap8L1byzduGbgMmqJDj9XJw
X-Gm-Gg: AYBFou3ybD3hj2NMO0BoTz0GpjDeOhfZOUkxxcARAfprhyO80UYmJ56bYbXFXlLQBwk
 Rs3wA6FzZbCyRqZaQlBdD/l5SNxnnZJc+dfRpW2zyumZoRkewU2FnvxV/S7gAWK0pN97wpl81k/
 xc2nrzJIeaHJke8zdcqyrcvP2DiNTjWPSjtpzLpJgY9f82DxDnO5gAz6vhiw25Lyn9QoLNcuHKi
 HmXot29+0RcG1BI8EXkDOECNjfXdAc40hR7t14OfZagtz8xRuVCAIVMwRfskwdTo9AA/eQQMvkT
 MaSROEwTB/kZMv2YkiVJk6U40qlKR6nicHxoNniEfrP1aaNFYk94P+T5sz8LEyiV5gd2gvivC0m
 PNTKmWiJ+/m5r35z/IazZDUiRSVR1SxVARtVa5Mym49V2LmOId0QYOiNARKrB9oa5hIxnmQ4rBL
 3d9RQRaxECMvLe5NejyUsv3eIh5XLMILB1LviVjruZTV2duZkahVeaDhxG2n2Zts3wFDaxHv3Se
 Kz0J3yT6jcody9A2v3eLeHJen6wD93YEFqV0b8PAzH6trnf1LGCivP+lwJhLSrlR8E3vKIXjJfc
 nCGIfh51zOrzxF2kogb8lxcGRu0nAV6Z2OEKAMWrhxjI4QNxKOny
X-Received: by 2002:a17:90b:3148:b0:3a8:c0cd:57fa with SMTP id
 98e67ed59e1d1-3b166c84a61mr2799666a91.11.1794315676641; 
 Tue, 10 Nov 2026 05:01:16 -0800 (PST)
Received: from computer ([2604:3d09:98d:800:e939:4613:1d28:dfcc])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b16769b589sm3765567a91.5.2026.11.10.05.01.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 05:01:15 -0800 (PST)
From: Tim <mdspan.github@gmail.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, zhao1.liu@intel.com,
 Tim <mdspan.github@gmail.com>
Subject: [PATCH 0/4] target/i386: emulate LAM in TCG
Date: Tue, 10 Nov 2026 13:01:04 +0000
Message-ID: <20261110130108.706228-1-mdspan.github@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::9;
 envelope-from=mdspan.github@gmail.com; helo=mail-pj2-x09.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series emulates LAM in TCG for x86_64 system mode and reports it
in "-cpu max". linux-user support will follow in a separate series.

Patch 1 keeps the CR3 LAM bits out of the PML5 table address. Patch 2
makes the large-page check in tlb_flush_range_locked() compare under
the flush mask, as agreed in [2]. Patch 3 is the LAM emulation, and
patch 4 adds a system-mode test.

The design follows the RFC thread [1]:

- On a TLB miss, get_physical_address() masks the address and runs
  the canonical check and the page walk on the result. The entry is
  installed under the tagged address, so each tag of a page has its
  own entry. INVLPG and INVLPGA flush every tagged alias with
  tlb_flush_page_bits_by_mmuidx(), and a change of CR4.LAM_SUP
  flushes the TLB.

- Instruction fetches are not masked. If masking changes the address,
  an entry filled by a data access is not executable, and an entry filled
  by a fetch is not readable or writable.

- Exceptions do not report the tagged address, which answers
  Richard's question [3]. On #PF, CR2 receives the masked address
  (SDM Vol. 3A, section 4.4.3), and #GP reports no address.

- gdbstub, monitor, and qemu_plugin_translate_vaddr() translate a
  tagged address as a data access does.

Known gaps:

- Data breakpoints on an untagged address do not fire for accesses
  through a tagged alias.

- With LAM_U48 and 5-level paging, gdbstub, monitor, and
  qemu_plugin_translate_vaddr() translate an instruction address at
  or above 2^47 as a data address, not as a fetch does.

[1] https://lists.nongnu.org/archive/html/qemu-devel/2026-10/msg01840.html
[2] https://lists.nongnu.org/archive/html/qemu-devel/2026-11/msg01599.html
[3] https://lists.nongnu.org/archive/html/qemu-devel/2026-10/msg05620.html

Tim (4):
  target/i386: mask the PML5 table address taken from CR3
  accel/tcg: compare large pages under the flush mask
  target/i386: emulate LAM in TCG
  tests/tcg/x86_64: add a LAM system test

 accel/tcg/cputlb.c                   |   4 +-
 target/i386/cpu.c                    |   2 +-
 target/i386/cpu.h                    |  46 ++
 target/i386/helper.c                 |   8 +-
 target/i386/tcg/system/excp_helper.c |  33 +-
 target/i386/tcg/system/misc_helper.c |  24 +-
 target/i386/tcg/system/svm_helper.c  |   3 +-
 tests/tcg/x86_64/system/boot.S       |  14 +
 tests/tcg/x86_64/system/lam.c        | 797 +++++++++++++++++++++++++++
 tests/tcg/x86_64/system/meson.build  |  15 +
 10 files changed, 934 insertions(+), 12 deletions(-)
 create mode 100644 tests/tcg/x86_64/system/lam.c

-- 
2.47.3


