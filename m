Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C527606A32F
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 07:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=theorem-dev.20260707.gappssmtp.com header.i=@theorem-dev.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=d2YVZn2P
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xO8y7-0002vG-Ic; Tue, 03 Nov 2026 02:30:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tewaro@theorem.dev>)
 id 1xO8y5-0002t3-8S
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 02:30:05 -0500
Received: from mail-dl2-x03.google.com ([2607:f8b0:4864:38::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tewaro@theorem.dev>)
 id 1xO8y3-0005w9-99
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 02:30:04 -0500
Received: by mail-dl2-x03.google.com with SMTP id
 a92af1059eb24-1b23f91cd75so109122c88.1
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2026 23:30:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=theorem-dev.20260707.gappssmtp.com; s=20260707; t=1793691001; x=1794295801;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=++6hJaWXCRLEkTN2wB57dMWrwits/t08kW9/eicTCHw=;
 b=d2YVZn2PDBcjli4g0fwPM456mYovcZKPUeQzYIuD0ufxAM+8EPQiHhmSYmtuvxv7wD
 /LLyFk9UkRpqeyjm95T4fsp/HV5ZJYo0zhENRTgzAbUCWNT9Nj2t9qKWFA43KYwHHZwh
 TvoqQNENwk8vS4wAEIMj3L5zEmDMTvM8nS5cU3T11Cl9FVswW+Iqy72Abz9D9iiJHml3
 9sDpi1hk6BucbnEdmaN1Fuov8Fz6nDPA04foJtvYRpNWwKXjVjAtz8GPh4XGO3B9Mv10
 DRZhrB+sJsLrQL696iIz9bizMRYSKXP6PgJ+SuLYoVehneN5Xh5qGm2aAmmlHBXOK/yc
 +gMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793691001; x=1794295801;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=++6hJaWXCRLEkTN2wB57dMWrwits/t08kW9/eicTCHw=;
 b=MpuQE8aG2RpV8AJ2jbbNDqab7GMRPR1shqh2MbY/818JGkjL3+XeRryGPRpsxInUbO
 gClTAv5EbKAt15glnecj1dZoGXjNiDc81oJjHVx1FTLAYouG/eGmxIXmvaQFiVwtZV76
 5a4HZTNOAn7o4KL83PtW/AEGDHCuKdEmVy/wqEKMJ0BB2gywlfYuJDZrCsrmD8zS+z+i
 IyjzR3AYNExBnzf7/enMhDwM/oDVLqmSLt0UR0NhU6A4ebwL3PR+th0gpzahKc/EjlCM
 CBDiO1k708l73mOtvxqaWMNsIkCTq7qAT0gpO6148k2e9vQBdy1/og9L2D0nTfht2MC5
 EyLA==
X-Gm-Message-State: APuU4Z/CjWin8ecTGSZQZ7+cSx5zlyc2bnlcsR6d6lo6eY+9MqewCS5a
 Fk/t3eoSwtQnhHeJ1cAveQqZdi2hHqGc0kP3unGb+hag9y8FKu2GKVPEDFPzuf3DohbWunQd1OG
 2itRsUvr8N5vF
X-Gm-Gg: AYBFou2EvRGB8h8SM7tg9H44zrh31VyufrNLS58+LzSJ7+QJjJ2xtJWqECy5/sUIGr5
 1rAFW4t2TXFil524Ed67J+XqqpWqCDhWKk/d+qXMYI5VIx9qoLNtOXvlKg5kA8WjREluIiMzxDf
 aYSMg8pwLB9+YKyykN8XWqhIjIQxGf9kkBl3rDtIMh9XruxiCN6IM8n/nNPZodcWhW0PgVFXiCH
 cjCWCzv5ugcwUICLQlgqW69jhvzkprwvkOC4UxaMTynZMJimH5Vl38DZe5FhvobMvzfMxUe6WQ9
 9LwSgKwDEDPQGavGMFJ6prAWYjAqNFOYqDcPQS/jb3S2hKhv79odFXjFlf8ihUCopLhcflIhEka
 s/OGH8BYYbh4fiqHsL5vvCoBTRjYUXPj7itj0pfcJbwG2eCWaM4GFJBLY8G1lp27afhBmg7G2E4
 FGskQd9+T93gI8/TJ1i8pORn/BrkgUuzFBq8DAIQLcqic6hBHihUhww3CAC0hLC1InlmjBvWTBx
 pwr/l4Ff/1V7KnPonh3K4tF1lzg0R/M76yM1ZcWny2jZy80DRiN1myhEhXWo+POClKHKHQ43mgd
 EI/1mfyYuQwPZ2lja2P+Idb+S43rdvYuEa9YExnSpvyjH5I1F61vzzhr8UgkwqW2A9KJpzk=
X-Received: by 2002:a05:7023:90c:b0:16e:c820:b20d with SMTP id
 a92af1059eb24-1ac56ca0005mr19871623c88.5.1793691000922; 
 Mon, 02 Nov 2026 23:30:00 -0800 (PST)
Received: from tewaros-MacBook-Pro.local
 ([2601:647:6300:1230:9da3:3d82:7292:c937])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1ac1a13652csm45557678c88.17.2026.11.02.23.29.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 23:30:00 -0800 (PST)
From: tewaro <tewaro@theorem.dev>
To: qemu-devel@nongnu.org
Cc: disclosures@theorem.dev, tewaro <tewaro@tewaro.org>, imaginos32@gmail.com
Subject: [PATCH 0/2] target/riscv: fix mtinst/htinst for G-stage faults on
 VS-stage A/D updates
Date: Mon,  2 Nov 2026 23:29:51 -0800
Message-ID: <cover.1793677944.git.tewaro@theorem.dev>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260705140508.17692-1-imaginos32@gmail.com>
References: <20260705140508.17692-1-imaginos32@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:38::3;
 envelope-from=tewaro@theorem.dev; helo=mail-dl2-x03.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

This series is about the traps taken when the G-stage refuses one of the
implicit accesses that VS-stage address translation makes. It follows up on
commit 366b4fba0fae ("target/riscv: check G-stage write permission for
VS-stage A/D updates"), which made the A/D write respect G-stage permission,
and fixes what is still reported wrong on such a trap.

Patch 2 adds a test, test-gstage-tinst (19 cases), master fails 8. Built for
Spike's HTIF console instead of semihosting, all 19 cases pass on upstream
Spike.

Patch 1 fixes the read/write pseudoinstruction in mtinst/htinst (0x3000 or
0x3020) [1]. 366b4fba0fae sets the write bit when the trap cause is a store
guest-page fault, but the cause is the original access type [2], while the
pseudoinstruction describes the implicit access that failed:

  original access, what failed       Spike      master
  load or fetch, A/D write           0x3020     0x3000
  store, A/D write                   0x3020     0x3020
  store, read of a non-leaf PTE      0x3000     0x3020

The commit was checked against Spike for the store case, where both agree.
Patch 1 fixes all 8 failures of test-gstage-tinst.

Results on master (1c1f512972), with make check-tcg for riscv64-softmmu:

  applied        test-gstage-tinst   check-tcg
  patch 2 only   8 of 19 fail        29/37
  patches 1-2    all pass            37/37

The test is last so that every commit passes check-tcg.

This bug was found during formal verification of a sandbox on top of the xv6
OS where tests passed on qemu but verification against Sail failed. Claude
was used to diagnose the issue. All commits were human written.

[1] Privileged ISA v1.12, 8.6.3, Table 8.12
[2] Privileged ISA v1.12, 8.5.1 "Guest Physical Address Translation"
https://github.com/riscv/riscv-isa-manual/releases/tag/Priv-v1.12

tewaro (2):
  target/riscv: report the write pseudoinstruction for a failed VS-stage
    A/D update
  tests/tcg/riscv64: test faults on implicit VS-stage page-table
    accesses

 target/riscv/cpu.h                    |   1 +
 target/riscv/tcg/cpu_helper.c         |   8 +-
 tests/tcg/riscv64/hyp-guest.S         | 110 +++++++++++++++++++++
 tests/tcg/riscv64/hyp-guest.h         |  71 ++++++++++++++
 tests/tcg/riscv64/system/meson.build  |  77 +++++++++++++++
 tests/tcg/riscv64/test-gstage-tinst.S | 135 ++++++++++++++++++++++++++
 6 files changed, 401 insertions(+), 1 deletion(-)
 create mode 100644 tests/tcg/riscv64/hyp-guest.S
 create mode 100644 tests/tcg/riscv64/hyp-guest.h
 create mode 100644 tests/tcg/riscv64/test-gstage-tinst.S

-- 
2.54.0 (Apple Git-157)


