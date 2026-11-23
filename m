Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C71606A31E
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 10:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=H65l8f+u
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVRc8-0003pX-NN; Mon, 23 Nov 2026 05:49:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <w1355457260@gmail.com>)
 id 1xVRc5-0003p9-AO
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 05:49:33 -0500
Received: from mail-pj2-x05.google.com ([2607:f8b0:4864:39::5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <w1355457260@gmail.com>)
 id 1xVRc2-0005Ex-Dd
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 05:49:32 -0500
Received: by mail-pj2-x05.google.com with SMTP id
 98e67ed59e1d1-3b468d0dbf2so289667a91.0
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 02:49:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795430968; x=1796035768; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=qF3XjhkZE+S2jWWoYvN1zVrQvwMH4+Iw6ch/wygi1E0=;
 b=H65l8f+uMmdR1bj3ob91crAVtmxQWwIIxJQWuv0mW0NYMX6up0RaktEpyJJHlFH1/F
 vXnjaTBC67M8HscJ9qELEwLhOi9Rn4i/p2nducl5w7Lciosta2X8hcZvXKu+34XHMEav
 /V6LaZl3gJ24Jp4wwZkH96QhWVMDTsaYBf+E63MBoGr28saLwKlIemsMpzmkpmV+XmZU
 sInquf2YCZ7Del7uB0rIcoBO+dFeqmZ23acphwpf1E2NRRXCVTW9NyfXyrn79HnLQJOT
 SY+tZYQnrZ8/cjlaIRasmiJ19gbD52rd0x35XDWFmZFVnstdJDE551fxympapQSlyRXZ
 pQyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795430968; x=1796035768;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qF3XjhkZE+S2jWWoYvN1zVrQvwMH4+Iw6ch/wygi1E0=;
 b=h1OYhuImCFOtrB2zbiR49Fw3sQkVTOMBBcQAKOoy+/MmmMqBO8kXqB0B3HeBVONLsz
 IAXN/2vrT+wJBXDbMFT8WwpjxjLu/s/Woaoful0XUjsfut1ZzlNie9BiC+gHmGmsVZvC
 4t9y8x33wxCqCSL7cfgpBqk2DbrRc8+BrhMtra+wrXtUvpcdoPXjuqsYdKsdUUtauwdY
 Zs88SlrLFhu2o+QcMVe8LiYHveAjFVwSYOkiPQd36r8XJJkYtL7FqAfDKS0Za764q9sc
 CccUIV+3aOYjFgtjL5UXklBkVWUQQE9NuoUU2xIMl/Qec1UFlsZj60A36FMB1tYYFNlm
 yzeA==
X-Gm-Message-State: APuU4Z/nni+YT6fIlxyM7mD8gFt6hbK7QcVqjtq76yNyUV+tD/qbtiPe
 KPeoN+PZ2hKVlhdett0giR4MuM65xz3rlcfWRcm4x+8MCRFp9Xby6zvDKKn32Dl3n5Kzcw==
X-Gm-Gg: AZFdTZdgsdYPVM5tiOMm1Rvs7EPMBvaNsTdRCAOF4dY//resskd7RMZCuFzuEbizpsK
 wG10kSD+lpRhB2xhY8ukyHY3n4+nDxhImTIAInQyRWDNMunPrWXc75BoFCFzgRyE+TqBeVxZUUz
 ySkkKTIsDzXRSY0977eDX2hzQGHPhJDuwrJW+yqFBOkbF+g8wmYxLSJMYiSt22FTLQEem2TV4qE
 5HVadbxYGXX8qVS9jnNRtWbWhOTKLUpkSGl8UyDgxcb4pWm0REmRlm5lSFAK/xfodABmHQTyIXR
 +ZYNroqCaJpHli1PwW2e7AZ4iT0ccCvaxVu1z+mDck7SSGugtf0DzalTc4HkcJi8+w/v28criaU
 bqYfNQhm+eagdw1rxLv4K+49B/k0UXAyR4zpSOl5HUhqcWxbrtF6v2S4zCb4VPLzYkeqgqV7WNR
 B7jGCQ0mC2RjsymtzZi/nSCNK9tp/KWcIAiXWzGxTQwdemFPxQ8PPD1FzlgYF30GAXK3MDtvF60
 gSNisfpWMPDE2URQ3vNtptgfbIBsyAhDmd5TYyW/QCv4F5kY+2uY9w2Cv9xIe+qqbj0t1TQIUTH
 pFOnJ+LZPURNQ0O8+Rea/uOZ
X-Received: by 2002:a17:90b:2c84:b0:3ac:a203:e092 with SMTP id
 98e67ed59e1d1-3b41c7b6864mr9568934a91.1.1795430968212; 
 Mon, 23 Nov 2026 02:49:28 -0800 (PST)
Received: from nixos ([2409:8a28:ae4:7f20:3a71:c3e:fd79:a32f])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b409330ae8sm20343555a91.7.2026.11.23.02.49.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 02:49:27 -0800 (PST)
From: Zixin Wang <w1355457260@gmail.com>
To: qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com, palmer@dabbelt.com,
 daniel.barboza@oss.qualcomm.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 qemu-riscv@nongnu.org, Zixin Wang <w1355457260@gmail.com>
Subject: [PATCH 0/2] target/riscv: preserve interrupt-pending state under qtest
Date: Mon, 23 Nov 2026 10:49:07 +0000
Message-ID: <20261123104909.197758-1-w1355457260@gmail.com>
X-Mailer: git-send-email 2.54.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::5;
 envelope-from=w1355457260@gmail.com; helo=mail-pj2-x05.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Commit 6c91b423a9a4 ("target/riscv: gate riscv_cpu_update_mip with
tcg_enabled()") gated the architectural mip updates with tcg_enabled().
The qtest accelerator is neither TCG nor KVM, so device models still
inject interrupts but mip is never updated.  qtests that drive ACLINT,
APLIC or IMSIC inputs therefore observe stale mip values.

Patch 1/2 updates the call sites in riscv_cpu_set_irq() and
riscv_accel_set_irq() to use "tcg_enabled() || qtest_enabled()", matching
the existing virt_aclint_allowed() logic.  The update blocks are wrapped
in "#ifdef CONFIG_TCG" because riscv_cpu_update_mip() is only built with
TCG; without this compile-time guard, the new qtest_enabled() runtime
check keeps the call in the link and breaks --disable-tcg builds.  In
--disable-tcg builds the update remains compiled out; the qtest "csr"
command is unavailable there as well, so those builds keep their
previous behavior.

Patch 2/2 adds a qtest regression that drives the ACLINT MSIP and MTIMER
inputs and checks mip through the qtest "csr" command.  It fails with
mip == 0 without patch 1/2 and passes with it.  The "csr" command is only
registered in TCG-enabled builds, so the test is only registered when
TCG is enabled.

Validation on 08c9bbb825 (v11.2.0-rc1):

- TCG build, qtest reproducers from the report:
  MSIP: OK / OK / OK 0 8
  MTIP: OK / OK 1000000 / OK 0 80
  (both read mip as 0 without patch 1/2)

- TCG build, new regression test:
  /riscv64/riscv/mip/msip and /riscv64/riscv/mip/mtip pass with
  patch 1/2; without it, the MSIP assertion fails with mip == 0.

- Full riscv64 qtest suite:
  18 tests passed, 1 skipped (cdrom-test, registers no subtests in this
  configuration), 0 failed; 375 subtests passed in total.  This includes
  the K230, MilkV Duo, IOMMU, riscv-csr, ACPI and virt device tests.

- --disable-tcg build:
  without the CONFIG_TCG guard, the link fails with undefined references
  to riscv_cpu_update_mip from target/riscv/cpu.c and
  target/riscv/time_helper.c;
  with the guard, qemu-system-riscv64 links successfully.

  The test host is x86_64, where KVM cannot be enabled for riscv64, so
  the link test used a local no-accelerator configure; the compile-time
  condition (CONFIG_TCG undefined, target/riscv/tcg/ excluded) is the
  same as in a RISC-V KVM-only build.  I can re-test on a RISC-V host if
  that is preferred.

Reported as: https://gitlab.com/qemu-project/qemu/-/issues/4929

Zixin Wang (2):
  target/riscv: preserve interrupt-pending state under qtest
  tests/qtest: add a RISC-V mip regression test

 target/riscv/cpu.c           | 13 +++++--
 target/riscv/time_helper.c   |  5 ++-
 tests/qtest/meson.build      |  1 +
 tests/qtest/riscv-mip-test.c | 71 ++++++++++++++++++++++++++++++++++++
 4 files changed, 86 insertions(+), 4 deletions(-)
 create mode 100644 tests/qtest/riscv-mip-test.c

-- 
2.54.0


