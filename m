Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E146AC5AC82
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 05:57:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtIzw-0003y8-Sh; Mon, 10 Aug 2026 01:56:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wtIzs-0003xG-QV
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 01:56:30 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wtIzq-0007lG-SM
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 01:56:28 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-c9b373d5af0so1080001a12.2
 for <qemu-devel@nongnu.org>; Sun, 09 Aug 2026 22:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1786341385; x=1786946185; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=g84DKJWv2zeuG9SPGPyMXWExhH1sgpKAugBZFzJmFbo=;
 b=D+RcVXpml8vH+P7+j5SF6mx+IEnNInnris7G3NNi3siehixilJkZJn/0HSDlTvPY9q
 glW2eBnpIYV/8hkVK1k+LUwOBjjsHfG3q5DQKhbiCDbfceda+vqDEY+/74TFcrrAcbgE
 l7CCTwFEizvRi44YcolOGIpXR4JDmiqFyme4LC/SJWyUUBO9+gVTXI7RjLaNc+z2KpCR
 j+uum7sOCNuN6VWLaCWbEIk+uHR/NCPL1RSYKdzHHGWPCP0+n87Ko1baJau4uDxvQViz
 E0bA774cwfEB2AXQTBNg/j6E7Ra/kjsQC5vmM/Mb3SlSnO1iieabedjYUgd+8rElpKhZ
 rBrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786341385; x=1786946185;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=g84DKJWv2zeuG9SPGPyMXWExhH1sgpKAugBZFzJmFbo=;
 b=mFha1g4CvGZ01QBDzqQAX8cVJUtGaokPrdyXn0qXUWRoAr/c2ljAskW8sv3+bAAanL
 slmJXq0zGe59CQkryFcD9XdA117/NTdoV+x0EB9sf0YenEi8mJkK5zFJ2nBdFdwM4cv7
 gPUhIVfwnz2ydn1vcU/TZFLtNDAbXi8EYTPJBxDFmjV656LBoB44jz5amt01jYv/x9NK
 H5vUYSVSU8vcTyLXjs0aVSLZVG6+IxfV/HMxdz1n3SZXlMbt2WCNhA9Kj7OCCxTZOngg
 J/bE/zMKW0MrHYVaFno207KOkHQjeLLg7ZYB03b7czgelkHfY+BdusHRjZrCaWe8A5zA
 SrFw==
X-Gm-Message-State: AOJu0YyCgb5YIYszF72CvHnOn+8Apffu5rL8fzEZY8ZtgFxTEQ5iEbKQ
 xO8FprEIDKaKk/9/CEKd5IHooB/mJDajDvdIs9eIHnK3nxWKBrgfOlpK7kOaQZNXjZ1QjFUwzwE
 vkdng5P83DaGrzPNX+SRNm8AV0Khya/dTy4/5Gro8EsFmkEi38HPS//26umV1Wq6Ja1v86ilDC0
 hD/nX05mXmcadF44HicPp29KPStkMh+qhknd8fY4P0w4nb+UxE
X-Gm-Gg: AR+sD10YrtMYlN5YyPP74jxHBbBJGMa9REHsvuJ9ajkHpMPEsanSagL856r1Jr4G/Yw
 4gti7lbdO68Il9nSamOsfBMR/6cO2A5DEYpGGheC7F3D1m9P8miklwzVQkeSq3fa6Hbc+28+pSs
 JE7G9di0YMnxEJKZEwpNxaJ+z3szna7EDbDjVjMd0+VMppfu8dVC5MLC7el2AmHqjogsqx2BjRD
 7eiF4QjNJIsbU4baA8ci1gsT5p37rY4Mwo+NU5bZ8Qg5i5TpByVPjig//O5wTIY5qGG2xSyjT2s
 vJvZhnE2n3qxtGBB5KRbzc51jQKIGDfBB5ywg3af8SntFMV6TvyH6VpZCe5EVXBmbJ/KdyigwVr
 PC5irrXBewGhyvuTJZ/KA1XOgEqGyjxqcm6nnqdPU5sPZGKVHmA/+kLobT9EKn26mAo8vdFzmlS
 5/UlnUY0x2tuv4gpI5pM8MQlfaY5Oy8HF+q0ygIrT/fMS0uGDTr0D5zEgec+mNjtiEFBDbE47N5
 xtRTeyg+lxeC3c=
X-Received: by 2002:a05:6a21:99a3:b0:3b4:7b3d:179b with SMTP id
 adf61e73a8af0-3cbce751791mr18842585637.12.1786341384690; 
 Sun, 09 Aug 2026 22:56:24 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315be86fc7bsm39172122eec.1.2026.08.09.22.56.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Aug 2026 22:56:23 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 qemu-riscv@nongnu.org (open list:SiFive Machines),
 Frank Chang <frank.chang@sifive.com>
Subject: [PATCH v8 0/7] target/riscv: Support the true Zicclsm extension
Date: Mon, 10 Aug 2026 13:56:11 +0800
Message-ID: <20260810055618.1175500-1-frank.chang@sifive.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=frank.chang@sifive.com; helo=mail-pg1-x531.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Frank Chang <frank.chang@sifive.com>

Support the true Zicclsm extension so that we can trap misaligned accesses
when Zicclsm is disabled.

To enable/disable Zicclsm, simply set zicclsm=[true|false], e.g.:
  -cpu rv64,zicclsm=[true|false]

QEMU will raise a misaligned load/store exception when executing misaligned
load/store instructions if Zicclsm is disabled.

Changelog:
  v8:
    * Squash patch#1 into patch#2.
  v7:
    * Raise the misaligned exceptions for floating-point instructions
      (RVF, RVD, Zfh) when Zicclsm is disabled.
    * Add Zicclsm unit tests.
  v6:
    * Reorder and squash Zicclsm CPU property and RVA22U64 profile patches to
      make every single commit to pass `make check`.
  v5:
    * Add Zicclsm to RVA22U64 profile explicitly.
    * Rebase to the latest riscv-to-apply.next.
  v4:
    * Align ROM reset vector data at 8-byte aligned offsets.
  v3:
    * Enable Zicclsm for the compatible CPUs.
    * Rebase to the latest riscv-to-apply.next.
  v2:
    * Use (size_memop(size) | mo_endian_env(env)) to calculate MemOp.
    * Use (log2_esz << MO_ASHIFT) to calculate aligment MemOp for
      vector load/store whole register instructions.

Frank Chang (7):
  target/riscv: Add Zicclsm CPU option and enable it for the eligible
    CPUs
  hw/riscv: sifive_u: Align ROM reset vector data
  target/riscv: Support raising misaligned exceptions for scalar
    loads/stores
  target/riscv: Support raising misaligned exceptions for floating-point
    loads/stores
  target/riscv: Support raising misaligned exceptions for vector
    loads/stores
  target/riscv: Expose Zicclsm as a CPU property and update RVA22U64
    profile
  tests/tcg/riscv64: Add test for Zicclsm

 hw/riscv/sifive_u.c                           |  11 +-
 target/riscv/cpu.c                            |  10 +-
 target/riscv/cpu_cfg_fields.h.inc             |   2 +
 target/riscv/tcg/insn_trans/trans_rvd.c.inc   |   6 +
 target/riscv/tcg/insn_trans/trans_rvf.c.inc   |   6 +
 target/riscv/tcg/insn_trans/trans_rvi.c.inc   |   6 +
 target/riscv/tcg/insn_trans/trans_rvv.c.inc   |  18 +-
 target/riscv/tcg/insn_trans/trans_rvzfh.c.inc |   6 +
 target/riscv/tcg/vector_helper.c              |  65 +++-
 tests/tcg/riscv64/Makefile.softmmu-target     |  22 ++
 tests/tcg/riscv64/test-zicclsm.S              | 368 ++++++++++++++++++
 11 files changed, 496 insertions(+), 24 deletions(-)
 create mode 100644 tests/tcg/riscv64/test-zicclsm.S

--
2.43.0


