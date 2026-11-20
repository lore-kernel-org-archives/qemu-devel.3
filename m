Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA419606A338
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 10:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=z2OjZuTD
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUM6v-0004FE-CX; Fri, 20 Nov 2026 05:44:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mdspan.github@gmail.com>)
 id 1xUM6n-0004Eg-LY
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 05:44:45 -0500
Received: from mail-pj2-x07.google.com ([2607:f8b0:4864:39::7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mdspan.github@gmail.com>)
 id 1xUM6l-0007ja-In
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 05:44:45 -0500
Received: by mail-pj2-x07.google.com with SMTP id
 98e67ed59e1d1-3b40283c001so179237a91.0
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 02:44:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795171482; x=1795776282; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=RXoESm/uQbpmdyPwe9Xw3GoaJaElSKMNlcqwRuneA08=;
 b=z2OjZuTDpIOZdBgS3JOPBLPw8HwzZN4jnoBvt/VpLgl1xqdJEAW3RotrphGnTw00HN
 JcAM48+P9ZmBdcZSynEkasisNJ5S5R56jbDRGx/Y2DKXyhgd+jIaRHD1oPFjWqTF8KHf
 qiX0TFW89zzuQ72pz9GvuwqUM6NrWv1nko94JFIYPaUijiwoRI5POzdeUCupK/tSy/IX
 pcPg8tF9WdlxNr0lJMA4I+Q+fOXp9xCYinIuP0q1hXcnvjzviqdBggtHG9wXCDq5CaMr
 5huPGMgdJb3W6HgnYIMK3prSmPzzYUde/IRzJ3cyrHnYedMnRn7qd0246MgdGYiVhCfW
 evOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795171482; x=1795776282;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RXoESm/uQbpmdyPwe9Xw3GoaJaElSKMNlcqwRuneA08=;
 b=gQpxeBk4HwYJHuP8Q/aUa/MltgVgdV5kzX5yZPIR0L/ThX8gYFhtyJW4gJC8C8lITo
 fsbE+jipgcdCiuouopelm7U+PG2Uv6fj2YFuYK1rlC+C9L9jAoTuvkBt+Y+uyXqdH6ls
 IWn8HvYEvZrLzAieIr1iTSa8RbeEQCOuZIcHIOfUr6+51ETf5z0EBF7F8fs0QRdrF9g9
 kXo/0Ai7wlC928N4ajxnBp/2JnOZeeXdzX2weTQ3KDKEIXxMLI4vkDvNMv8IpcSd4WYN
 ntW7pP9W5H1gZWFAC/nOrRKc/9zwkTqRR6Evap84HLcQXUiPr8wZqYiitLAjG/YgJZ9x
 LlqQ==
X-Gm-Message-State: APuU4Z8BqeSutJIcfO7R+4gSw7PKOZ2g+r98R/oSK720Izv1MEtqoPox
 lFXrZrWbQ1zz58Q48zZPbroeVdZDFy50PoMqmj/ssQhv6yQcbolnBvMqWjPCvGx5NNE=
X-Gm-Gg: AZFdTZeRam8T7ZypVMM+967kcd7LodW8pC6eOA62oyHaTsX7Gnj4hDph7FSTY2i2UaU
 40fc+31BaP81FKIBQUBc59qw+fASpTvilXKa0HU+eVvKpz7ZRFxJEl6yJs/WuLh18pQWnJSPESD
 RnYufgQxvcB5bk39kW+TB2c5rT7xSMHVJEvTLZjX4nXj5tCbG1QD3GZok3nIfQF0UT09D3dayhY
 CW5XEpxubNEUv13jXsOGB2IUgoU1x+gjIsZdFcuQ92Ro6yjFzKT1YXSAroEsRziv8XwnpKMSYlu
 vg9QCkwg0G1c8o+4xTxDkwuU8tfI3cSryeYtzXzOnX6jD1e+NLf4sum5eW2IdNMwNXq2t2pq+52
 uufkInt4/pnAH5ARuPuiHyJgmHdLfw/8Ad/aulClO1EMYZwyQI5tpVY+QzzEGVzjbroKkVesn4v
 NfSiYsJxGxDJq7fFWeuYAEbh9jFOSLw4FOUecpI31cQ5bHGMw56CssJRwfDwW1ppmZhBvtymDBL
 BiB1g1DADEamlpnN4UyDAXq6Tv397UdCjdaeGLvHOLTHoMJmd9MIohuSv72vOv85fLaYcR5e1Vc
 nrRjFy6blzvJz/N6pDyHnDdhAAFMHmk=
X-Received: by 2002:a17:90b:17cd:b0:3b0:99f8:eba8 with SMTP id
 98e67ed59e1d1-3b41c97c45emr2334999a91.66.1795171481911; 
 Fri, 20 Nov 2026 02:44:41 -0800 (PST)
Received: from computer ([2604:3d09:98d:800:cd94:7b9e:bb89:3491])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cde6cfc80d4sm1151506a12.6.2026.11.20.02.44.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 02:44:41 -0800 (PST)
From: Tim <mdspan.github@gmail.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, zhao1.liu@intel.com,
 Tim <mdspan.github@gmail.com>
Subject: [PATCH v2 0/5] target/i386: emulate LAM in TCG
Date: Fri, 20 Nov 2026 10:44:26 +0000
Message-ID: <20261120104431.733136-1-mdspan.github@gmail.com>
X-Mailer: git-send-email 2.56.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::7;
 envelope-from=mdspan.github@gmail.com; helo=mail-pj2-x07.google.com
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
the flush mask, as agreed in [2]. Patch 3 gives instruction fetches
their own MMU indexes. Patch 4 is the LAM emulation, and patch 5 adds
a system-mode test.

The design follows the RFC thread [1]:

- On a TLB miss, get_physical_address() masks the address and runs
  the canonical check and the page walk on the result. The entry is
  installed under the tagged address, so each tag of a page has its
  own entry. INVLPG and INVLPGA flush every tagged alias with
  tlb_flush_page_bits_by_mmuidx(), and a change of CR4.LAM_SUP
  flushes the TLB.

- Instruction fetches are not masked. They use the fetch MMU indexes
  from patch 3, so fetch and data entries for a tagged address are in
  separate TLBs.

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

v2:
- New patch 3: separate MMU indexes for instruction fetch, as
  Richard suggested [4].
- Patch 4: mask only for non-fetch MMU indexes.
- Patch 5: set exe_name only where it differs from the default, for
  the check added in commit 1138de1d.

v1: https://lore.kernel.org/qemu-devel/20261110130108.706228-1-mdspan.github@gmail.com/

[1] https://lists.nongnu.org/archive/html/qemu-devel/2026-10/msg01840.html
[2] https://lists.nongnu.org/archive/html/qemu-devel/2026-11/msg01599.html
[3] https://lists.nongnu.org/archive/html/qemu-devel/2026-10/msg05620.html
[4] https://lore.kernel.org/qemu-devel/4a2dd42c-fe8e-46ad-a74c-bae94d088be8@linaro.org/

Tim (5):
  target/i386: mask the PML5 table address taken from CR3
  accel/tcg: compare large pages under the flush mask
  target/i386: use separate MMU indexes for instruction fetch
  target/i386: emulate LAM in TCG
  tests/tcg/x86_64: add a LAM system test

 accel/tcg/cputlb.c                   |   4 +-
 target/i386/cpu.c                    |   2 +-
 target/i386/cpu.h                    |  63 ++-
 target/i386/helper.c                 |   8 +-
 target/i386/tcg/system/excp_helper.c |  15 +-
 target/i386/tcg/system/misc_helper.c |  24 +-
 target/i386/tcg/system/svm_helper.c  |   3 +-
 target/i386/tcg/tcg-cpu.c            |   9 +-
 tests/tcg/x86_64/system/boot.S       |  14 +
 tests/tcg/x86_64/system/lam.c        | 797 +++++++++++++++++++++++++++
 tests/tcg/x86_64/system/meson.build  |  16 +
 11 files changed, 940 insertions(+), 15 deletions(-)
 create mode 100644 tests/tcg/x86_64/system/lam.c

base-commit: 45b7c3e45e2b778e560a0734daa6aa0059bc0edc
-- 
2.47.3


