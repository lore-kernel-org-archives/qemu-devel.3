Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83FD5C55174
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 16:45:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wreii-0008GW-5a; Wed, 05 Aug 2026 12:43:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wreig-0008Fm-Lk
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 12:43:54 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wreif-0001ug-1g
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 12:43:54 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2ccf2360620so12940975ad.3
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2026 09:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1785948231; x=1786553031; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=RWMW5Z0wz61EvecLwzrDpaeuUUb1ggzgBEai24i9uCE=;
 b=KUjubjTMwDQryqoCRPk2dIystOLz/ChnPJNGfK2crZ/nDaIS4QdGtWXu9borR4twYc
 4KuvCc+CSUz3nLWej0J9QTn4VoYfG0U4n9jQs1MNoISPcPjVCNFnLDz/vVyb3T20Fe7k
 0FHLbk1t3ckmJ9/JSlwwXKAKcNnjAJR6iMLjRRRMqP6RJ6IcpxiP1KFQyzc6lFOr2/2f
 nTHHxP2tU3YGZsJYq05TPfl74VtEVbLiIj2cfmo0p2PKsw/4WKbOzfKUywxr3PzGzSki
 4lSn0X4QkaDVRW1fUJqOMBj+3YUVZ0hUXUZUXmD7D76dK2o9QbPlqQ3gQb2NU3sFgH4u
 KKtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785948231; x=1786553031;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RWMW5Z0wz61EvecLwzrDpaeuUUb1ggzgBEai24i9uCE=;
 b=jPhnrDrhexcgq+9UI8UeD6gnYVZ2Sop5Y52awQuJEsxQunxohLLhhPfuujJrjWMUMS
 CirTJntxrybgb57gHc/UdEa0MjB6QC/aO8Dxzzvrh8JsvP1b+NuIufhP5Y3Wl8EFUiRA
 CEDGm60ObcFry0gIlUSFatQaTfuaoa6jRmlCDVZpy/MoLt4hRI8uHZ9YJ8OqgMyBqG7/
 WIX311/6gUaKAtk3mzksCRLsdXs0shXzZspF/ARaIBro7b9NlGhERLYWF2ABzEpnVe9d
 n4esJwAYZc9/EFyzFYOQI2lhZ3SUzSrWF8L0tk6m3sHBsa38GBxuc+7TsKfmy2wgUMgY
 d81Q==
X-Gm-Message-State: AOJu0YyuD/UrR1IUGLT4UPqPnj8hz0trT6+Pi81CBpEqnxXv9ib51cEq
 9XXbeXZSrTTHF6/t3i42TVela78oCFzLDk4LYkSrPJEpQOT/AJN7xb/LijSANFy+j30fn7hUR/v
 dbW1BzPMGjXTdpTmmFmLypbeTrmR/SQNto/EFBdtUFNxuST5hkUzD9lAZplS4m1OZ+Lk/NDqYs7
 SA8nbrY+xeWg2J5fCHl8MLGFwg5lZIAPy+eWyZhAs1siQ=
X-Gm-Gg: AR+sD123a0WqaxElsvoxX6WLUOUI4NGNby838l7/MH7ZaADvpSsSNxrw6fpjnPtF85t
 X7Em0hWd69xrj6gRIFyaOQgdiWJNlU2mdONfwI1FhQ7lidih6gJb+0GgPc3FkHnpMBzZKo0F7Sf
 UEk5SY9aQkVJ7X0MA0QWT06B5CE6dRuh9vVpNqZURH90M9a1I4F3DHqPdOtzYBeehfv4yRMmA0S
 tNuCCKISxObtMXB+wCok1i+Q1NyzdmKty3g1siy5aZixFQj0YMLwxyFTdh1c+tDBeXaFg4HJe+n
 q6E+4YqBrxkzQbVM4QHI3ia2WQkvIEaNfLJX6beSFhF/CgJPxPLrxI0ZePbpW/uIUaNxYg4ILC0
 bJuRiNL+B31k+E7FL9yk78AxVJIg/n663jE17ldAYPHoff8ci0BnNVDZvWbsj/2aYgfaNhlEduZ
 NZ+6Qg4B2SKYj+mpZ3KmqBtBYG7Z7+jvuj+oQS/sIKUGwy7I4z3vMZfAuisWaSDekvJYGKDaWso
 nY0KvVwNALZkIkwglBLay93CPyVb3rm43WArg==
X-Received: by 2002:a05:6a20:6a06:b0:3bf:9b61:f7ae with SMTP id
 adf61e73a8af0-3cb85df274emr8460186637.14.1785948230880; 
 Wed, 05 Aug 2026 09:43:50 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3158644a195sm16719065eec.13.2026.08.05.09.43.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 09:43:50 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 qemu-riscv@nongnu.org (open list:SiFive Machines),
 Frank Chang <frank.chang@sifive.com>
Subject: [PATCH v7 0/8] target/riscv: Support the true Zicclsm extension
Date: Thu,  6 Aug 2026 00:43:37 +0800
Message-ID: <20260805164345.698208-1-frank.chang@sifive.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=frank.chang@sifive.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


Frank Chang (8):
  target/riscv: Add Zicclsm CPU option
  target/riscv: Enable Zicclsm for the compatible CPUs
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


