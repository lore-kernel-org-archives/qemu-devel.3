Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FE82C55167
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 00:05:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpakU-0001dT-EK; Thu, 30 Jul 2026 20:05:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wpakR-0001Zz-Fj
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 20:05:11 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wpakM-0001Gp-Vx
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 20:05:08 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-ca12086c06eso302976a12.0
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2026 17:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785456305; x=1786061105; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=M4s43wQWqjMi7QpvQ0agCHumO9YRvt/SOatjgS+qX7A=;
 b=Ph4rBL88hnby65ff5LmDi7OetV8oqqeTK/lr95tUNHKIOijUHwoEflIIZmzDeVXq0h
 uMoSrdA/jmqp11ZRiMTVvYz1tKU6AfRQ5dVTSgwodUkL8yG1FsrvJgyLZR7YlGu13ycX
 QqHGOsPTHX3B3uf2z90LhMZV4nmtw9PkGkKj+E66SyMrnlyRPJYVlIHBpD4IeqXTtQnz
 P6TTsJ4DXttZuM6syYAY+qCqeAPaGib4RCdgned2j9XNTHGzgNi6N+3l0sl9HeWyece5
 6FgYq7ETXo4QVcOsscLE05zCaf6YElwjyGkKDB6wRYqbjU++Lum2VFydAVtuuQLjAuj5
 mTAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785456305; x=1786061105;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=M4s43wQWqjMi7QpvQ0agCHumO9YRvt/SOatjgS+qX7A=;
 b=YWfVJuhbkuEsKJoiPB3WUP6wF4AQKymMIF9hiWzOF80+bF9pBlUhiZUthpraLHqxj/
 YK60PXCJznMCMONRYMZgjf1gb332iXXnLyKdLxnm/83FWrsbzqVBe3b0zVC9Kgxt7Onw
 uw4FfAe0XRpo+GeXJ5dA/YK4SKVvElJagS2qcxWh/xhpM4e1Me0POVIWh9TOOYjPP4UK
 XWx+L2uuvQMmJNBx6RWlQ1taLONcLtq5WTFt55pPs1bZJYyVdhJF7r81Pea6QGml6mId
 Ma2+a+aoMBAQ9oxhmrEGkfsH5X9B5ntTELsfjo0ar0JEdSrcZivNvRJ+M0HXxQW8VACW
 lteg==
X-Gm-Message-State: AOJu0YzNA18ot76MtbkPim2yQ8LEdreRk17r+7ngx88p5a3TEkd+moN8
 4CMYjVP5at4LHDDYHubsHRZL3aBAuy7AxLSW+u27dqcVc4Ja0szuT7hEKvItUn5l1byv45/boap
 aoLnw
X-Gm-Gg: AR+sD10yJGJXJ/u0k5rVN6Fuok3j7eTV3VwzluP3KQ3uy/bEuOV4Lle01Oio6LH86YD
 v5+idLAknysfS8wA8R4V+nyFFv+NIKrjz9RqEnjFQKJjcwrbJRWwTGwVpH3ZJ2gIy5OsndTjaJx
 XC8QixH3EHDxsQEVK+rtFMTRyGIUlYeGoNZhVyWnZ3Hu3anY0QQ4m0H4KK2wm9qrzFYqR5xDo7h
 9RZMCWpVG2sVFO4Ztu59RtvLW2O0jkd/WodfywXPwDlqo+3W9TwkHNn/ceQxKuT/ONEx3DJ3k7y
 0Pl2QjVMpTiD9UTucG0GpqNmvg4XbhZq3S1G8EWmpqtvxKuw+C+Yrr7d9R/M280le//2j0vzu3O
 ZsCzXRSeKfFc8GPVoAtHo8oAqOCHDno6+EqCETV3OlBmcVO7ePp4ugnMBFfLz85xLf1o3TZeYqg
 GbDQeeW2AXlMluh2OdDe1HmHnDRddK/TzvdPIyWYvhKefr1T35ULh2pIGCQX4uW8PJhBVIpHsVc
 +bajDGqZleVPcn70OFW
X-Received: by 2002:a05:6a20:cfa1:b0:3bf:6c08:fb8e with SMTP id
 adf61e73a8af0-3c9008d25b5mr4634370637.48.1785456304493; 
 Thu, 30 Jul 2026 17:05:04 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cbdb7a999ddsm2656460a12.4.2026.07.30.17.05.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 17:05:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: anjo@rev.ng, qemu-arm@nongnu.org, git@xen0n.name, 17746591750@163.com,
 maobibo@loongson.cn, lixianglai@loongson.cn, philmd@mailo.com
Subject: [PATCH 00/11] tcg: Add revbit opcodes
Date: Thu, 30 Jul 2026 17:04:52 -0700
Message-ID: <20260731000503.170446-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
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

Adding these have been at the back of my mind for a while.  Most recently
tickled by the Octeon additions, and Anton's helper-to-tcg work.

I didn't add a 16-bit function or opcode because no host implements it.
The 16-bit reverse that the hexagon target does can be implemented with
a 32-bit reverse plus a shift.


r~


Richard Henderson (11):
  tcg: Fix opcode dump for bswap
  tcg: Add tcg_gen_revbit{32,64}
  target/arm: Use generic tcg_gen_revbit*
  target/loongarch: Use generic tcg_gen_revbit*
  target/loongarch: Expand bitswap inline
  target/mips: Expand octeon reflections inline
  tcg: Add revbit{32,64} opcodes
  tcg/optimize: Handle revbit{32,64}
  tcg/aarch64: Implement revbit{32,64}
  tcg/loongarch64: Import REVBIT insns
  tcg/loongarch64: Implement revbit{32,64}

 include/tcg/tcg-op-common.h                   |   3 +
 include/tcg/tcg-op.h                          |   5 +
 include/tcg/tcg-opc.h                         |   2 +
 target/arm/tcg/helper-a64-defs.h              |   1 -
 target/arm/tcg/helper-defs.h                  |   1 -
 target/loongarch/tcg/helper.h                 |   4 -
 target/mips/helper.h                          |   7 -
 target/arm/tcg/helper-a64.c                   |   5 -
 target/arm/tcg/op_helper.c                    |   5 -
 target/arm/tcg/translate-a64.c                |   4 +-
 target/arm/tcg/translate.c                    |   2 +-
 target/loongarch/tcg/op_helper.c              |  21 -
 target/mips/tcg/octeon_crypto.c               |  35 -
 target/mips/tcg/octeon_translate.c            |  49 +-
 tcg/optimize.c                                |  48 +-
 tcg/tcg-op.c                                  |  78 ++
 tcg/tcg.c                                     |   8 +-
 docs/devel/tcg-ops.rst                        |  11 +
 .../loongarch/tcg/insn_trans/trans_bit.c.inc  |  29 +-
 tcg/aarch64/tcg-target.c.inc                  |  24 +
 tcg/loongarch64/tcg-insn-defs.c.inc           | 944 +++++++++---------
 tcg/loongarch64/tcg-target.c.inc              |  26 +
 tcg/ppc64/tcg-target.c.inc                    |   8 +
 tcg/riscv64/tcg-target.c.inc                  |   8 +
 tcg/s390x/tcg-target.c.inc                    |   8 +
 tcg/sparc64/tcg-target.c.inc                  |   8 +
 tcg/tci/tcg-target.c.inc                      |   8 +
 tcg/x86_64/tcg-target.c.inc                   |   8 +
 28 files changed, 787 insertions(+), 573 deletions(-)

-- 
2.43.0


