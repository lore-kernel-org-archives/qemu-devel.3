Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A217C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 10:44:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weVwy-00066p-4z; Tue, 30 Jun 2026 06:44:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1weVwe-000652-Rs
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 06:44:00 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1weVwc-0004ng-6Q
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 06:43:59 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-c85c531d4a9so1698838a12.2
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 03:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1782816236; x=1783421036; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=pzi608LaWSUtrWTDOF/FS4C+oHsMg4cdyOtgq8i47qM=;
 b=RPAcC8fyt0ZhZHPDJE2Y3IIhrUaERLyNrOowqZy6mptOtefmv6szjJlQDu6lQO0qMm
 BQteGvN2hVlsFb6eJZSCDU5dMdYfsMsAP+Pi1lj/+AFGNd59p2rP36611+yBs2DvlI3c
 SKwCleBrG79CRQplNC4kPy1ad8v4cyU5bqRjo7YlqrTQvMcB1dbzG0EnilK2A1hTxbV/
 EvG1jVgyfGQo1Fw9jzbI3CExvoL5tNjFjEhuUjJiW6SAkO2dmMYwgFywOKDOvkkOmPWS
 x6SkxBYNl8jOTgCeYRlLOg5ykI+8WZ4pNqv8GLKOrNj06gcVxVkIFSmMIaxHjG5v34kr
 ehbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782816236; x=1783421036;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pzi608LaWSUtrWTDOF/FS4C+oHsMg4cdyOtgq8i47qM=;
 b=Elql+2TngxYqC/KsDRu409kxXwx0K5Ufc6kjFxWHQg9gZgXFOxS0uy64GRJSjM+C3Z
 WPZbXoI0mrGqQ7Uw/ufPwD5ScxYATf4pxD2fm/QSkdGGQuySCO3iYaUFTAcWrvSvKu9v
 weNtaiJ1RuiUzQWEfxr8WSnVLM4NRvT4OeLJhIsmSGHFIXUeB+S9aqOzKW+bmVhw1xrO
 oPI+NMRFJdOLaeRfqaBlNBl++aDS20Znk4KQdAtIAfJ93m0kRUKqgP2pSyErlSIUNuUJ
 jlnyVeHtumJT95Skx5qt7dVmG0bPQ+ayK7HAx99nk05J7VByGttEd6LBo5s6QdQgrOpD
 Hlrg==
X-Gm-Message-State: AOJu0Ywx+kx3A1SKja1wFhUZbxInqqNigjNHJoNk2AYGO6g350CHcycD
 ycQj40dRJXiYrWp+37+5DsuFYd+wMV3ra3RXgp+1mGRwE36wUQ5KIkMKPdMw9BsUC8nbH4mJQ7Z
 k4fG7NYrvTaGXsDmPruSmSK9lrxRpvIG6gZMOvqcpcHJGe7HS30xKjzhrnoNsKdbhoO7UCwbAun
 QPgz0E9HwMZYgs10c64pP7kP0AdvNWfVesH8QlyJwDrpDnifFb
X-Gm-Gg: AfdE7ckGGEo+w6gVA6V7DQkBxDeXTsv8cXarQ77V1hYIEU43YBVF39XrRUctzcZRqxh
 ADRQ16NfTfUU2+ztILZBRava5LapzIcQHdDIExtSgGzj9mAOn1owaAWQT/HY6X8cL+kLZ5O7g3O
 kfekYWz7EYMGTFjKXBPAdrs9gfsFqTKOGtuF/hDEZNLd6W0+Kf1/hqPNLnevIJw8LSiRRb6+ptH
 kkOkMD4B8WjU9gKpbP6HzIipQrWSZLLl7x8cv0v0mRFOU9J3A8oteiV23wNBN+CkiSxEXC8SdKy
 oDHlfw5ZlGIDxtpDbCdLixxgLXLlp2OviaT/ycQmeMTMtSkJB3B7rl0cuBRcQwDtQsS0enxvOpB
 TLwRJ4Jc1ashJnQeQnw7UKG4MPuNkK2SaLAeQgiG5huVXslhgzD+4oDDwgWibO8D92nKgUcodpb
 trf19JXCQ8Kvx3cLaSw9rsNfXezcTMAItzAWFb5cg=
X-Received: by 2002:a05:6a21:495:b0:3bf:9944:a8d8 with SMTP id
 adf61e73a8af0-3bfc527fa3cmr2673472637.34.1782816235431; 
 Tue, 30 Jun 2026 03:43:55 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c9bbf95be56sm1274745a12.16.2026.06.30.03.43.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 03:43:54 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs),
 Frank Chang <frank.chang@sifive.com>
Subject: [PATCH v3 0/5] Support the true Zicclsm extension
Date: Tue, 30 Jun 2026 18:43:45 +0800
Message-ID: <20260630104350.748267-1-frank.chang@sifive.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=frank.chang@sifive.com; helo=mail-pg1-x535.google.com
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
  v3:
    * Enable Zicclsm for the compatible CPUs.
    * Rebase to the latest riscv-to-apply.next.
  v2:
    * Use (size_memop(size) | mo_endian_env(env)) to calculate MemOp.
    * Use (log2_esz << MO_ASHIFT) to calculate aligment MemOp for
      vector load/store whole register instructions.

Frank Chang (5):
  target/riscv: Add Zicclsm CPU option
  target/riscv: Support raising misaligned exceptions for scalar
    loads/stores
  target/riscv: Support raising misaligned exceptions for vector
    loads/stores
  target/riscv: Enable Zicclsm for the compatible CPUs
  target/riscv: Update Zicclsm ISA string and expose it as a CPU
    property

 target/riscv/cpu.c                      |  9 +++-
 target/riscv/cpu_cfg_fields.h.inc       |  2 +
 target/riscv/insn_trans/trans_rvi.c.inc |  6 +++
 target/riscv/insn_trans/trans_rvv.c.inc | 18 +++++--
 target/riscv/vector_helper.c            | 65 +++++++++++++++++++------
 5 files changed, 81 insertions(+), 19 deletions(-)

--
2.43.0


