Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD1CBD232DF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 05:34:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ve56c-0004Fj-DB; Fri, 09 Jan 2026 00:32:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ve56Z-0004DZ-MA
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 00:32:11 -0500
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ve56X-0003gH-O9
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 00:32:11 -0500
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-34c9edf63a7so3186935a91.1
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 21:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767936727; x=1768541527; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=sL03tGGaESXndm6kUpMn5SgemE/66cdQd8FuB2bxMQw=;
 b=vrYz/new0hHShLCnnRR0jqHJUZoCVWqFWrlPCwrhlI9hEwMGRGoHsuwx1v9he1vqyO
 tyEjb9wKPtAnMpzq1Bc5APi38WTh5Pv2yxDhJPnAr2/wK3SHOpSTGAsY6iz/iDpZPcv0
 kXAZ9gOkB73ZLhp5AG87LfFkxks0mhj2Zzu0v0M3qhT+IabCrCF/Bnb1AVRdIE7qOhOe
 2GnQq+BXZYsiyOUuTjOHAvmQ2UVrFySuFvu4gHw+Pf9N00BKJ8oAFP/1/SeEJu9nctuE
 BuRaRJgMeEnl8bEKfCFyYdlPfvPE/v4E+qr1QwB7/3g+4TxhGcVs6U2Cwe/ghqMk8Scl
 XBOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767936727; x=1768541527;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sL03tGGaESXndm6kUpMn5SgemE/66cdQd8FuB2bxMQw=;
 b=Bd+pKZ0Fml8nKKF++IWGUwFpuaj6HVgM6pDPFGF8gP56ATInC4vXDzVqkSMonsqqRW
 Ynj1tAGQKTbKNKI0aR4VXoPSrCnalbcyyEOZNzptbmqszPtBDJoUje3ptwMMYmT5MSbS
 9POwojZEOYRacShGwaycJqgSecDUaC039SAKDsKDM7yk6CnkybdfiEhOoujfyqLdZPk+
 HOTaPFEJLgyuG2QXlYpdPZ90PKERNpGkJLJujWU19gpsDKEiT+v8nfRYvn9IOKS7DA8p
 SVu3QQNfLUTc36tps0UzKZ48Yxi5vozLP3kwmoal9YwIfK/ZJ+pYBVJJp/RLW+d6wYW7
 tK0Q==
X-Gm-Message-State: AOJu0YxdoqVmngOsq1z7D2VkNh7Fniq6Fxshna2/lbXPslnKeUd27P7T
 N6sqhuVwDrYWDU+xLJEfsBuXMvxBQR+ZQfNBgyUJo6PU22nVWVEldFMvpAwlhkAjfj5baXwXz+t
 UhXF8
X-Gm-Gg: AY/fxX4vZaVtnKXk6Eilfq6aF47zYvnlfsOMv2/WJVd6R+Mwj9Su0XgBmZhSrpV/Ybq
 ahYnNEMauNMCcDlAEQyra9BMh/n+HH7zLYXD5iHdDy/V3omoltvq3pIFnG2XNVVfly7o6J+0DHF
 eojKiFSvwxs2IYw8fxeKJbSWyV8auQiANMY/wtalyBGvoN6eBnKulRzAewbtESERpZ5qFjEdj8u
 Bmu7g+d0M2GnUsRS1HKWFZ9yIc8xadgcYRyJY4OUL35L1rEpxZF8WgcIEkcUxWedvUkmJ9XhBNU
 q86M97vJfRfUtmaQNeGtZZUW4/ETWVSc7ctliihrkyg09u1ebkGr8kB8g7GtDXsCKcgw+eyV6iK
 Vr274A/XS0uQvDziKZ1zzwCLuCAi5/n7OMlgikW3cnRTg+LQ5kOnLh3OEuXr8dRaR835IiLKg6C
 Pj5diViS5bu4kww/HYmhH/sMx1fGI9c+Vfw9e8Y5dTtUZgS5Ez7c0DY5BQLv19xEY+
X-Google-Smtp-Source: AGHT+IF2KSt3SVFJSQHp9q7vQqGPJfeOyrE9UndSC1vi8KYkxCmkrny+xEgXUbF9YHuwWm3lO6OBNA==
X-Received: by 2002:a17:90b:3ecc:b0:340:f009:ca89 with SMTP id
 98e67ed59e1d1-34f68d0bc11mr7461315a91.22.1767936726997; 
 Thu, 08 Jan 2026 21:32:06 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34f5fa93f30sm9260137a91.5.2026.01.08.21.32.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 21:32:06 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jim MacArthur <jim.macarthur@linaro.org>, anjo@rev.ng,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 00/29] target/arm: single-binary
Date: Thu,  8 Jan 2026 21:31:29 -0800
Message-ID: <20260109053158.2800705-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1034.google.com
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

This series tackles (most of) the rest of target/arm, especially tcg folder.

It requires to add some mechanics in tcg-op.h to be able to specify which target
a file is written for, so every definition becomes unique within a given
compilation unit. In general, and as a note for other architectures,
target/X/tcg/* files should be written for a single variant (32 vs 64 bit) only,
which helps to eradicate TCGv usage.

Initially, I went down the way to have a dynamic definition of TCGv, which
required much more boilerplate and runtime checks. After discussing with
Richard, I realized it was not needed, and that could simply split 32 and 64 bit
properly in different files instead. This might be more tricky with other arch,
but it's definitely the best way to deal with this.

CI: https://github.com/pbo-linaro/qemu/actions/runs/20837738026/job/59872847031
CI: https://gitlab.com/pbo-linaro/qemu/-/pipelines/2252803959

Files left are:
- target/arm/tcg/mve_helper.c
- target/arm/tcg/m_helper.c
- target/arm/tcg/cpu32.c
They will be converted in a future series (more endian usages, and a few more
changes required for cpu32).

Pierrick Bouvier (29):
  include/gdbstub/helpers.h: allow header to be called from common code
  target/arm/gdbstub: extract aarch64_cpu_register_gdb_regs_for_features
  target/arm/gdbstub: make compilation unit common
  target/arm/arm-qmp-cmds.c: make compilation unit common
  include/exec/helper-{gen,proto}.h: add conditional HAS_HELPER64 define
  target/arm: extract helper64.h
  target/arm/tcg/psci.c: make compilation unit common
  target/arm/tcg/cpu-v7m.c: make compilation unit common
  target/arm/tcg/vec_helper.c: make compilation unit common
  target/arm/tcg/translate.h: replace target_ulong with uint64_t
  target/arm/tcg/translate.h: replace target_long with int64_t
  include/tcg/tcg-op.h: replace target_ulong with uint64_t
  include/tcg/tcg-op.h: eradicate TARGET_INSN_START_EXTRA_WORDS
  include/tcg/tcg-op.h: introduce TARGET_ADDRESS_BITS
  accel/tcg/translate-all.c: detect addr_type dynamically
  target/arm/tcg/translate.h: remove TARGET_AARCH64
  target/arm/tcg/translate-vfp.c: make compilation unit common
  target/arm/tcg/translate-neon.c: make compilation unit common
  target/arm/tcg/translate-mve.c: make compilation unit common
  target/arm/tcg/translate-m-nocp.c: make compilation unit common
  target/arm/tcg/op_helper.c: make compilation unit common
  target/arm/tcg/gengvec.c: make compilation unit common
  target/arm/tcg/translate: extract helper64 info in translate-a64
  target/arm/tcg/arm_ldst.h: replace target_ulong with uint64_t
  target/arm/tcg/arm_ldst.h: use translator_ld*_end variants
  target/arm/tcg/translate.c: remove MO_TE usage
  target/arm/tcg/translate.c: replace target_ulong with uint64_t
  target/arm/tcg/translate.c: remove TARGET_AARCH64
  target/arm/tcg/translate.c: make compilation unit common

 include/accel/tcg/tb-cpu-state.h  |  12 ++
 include/exec/helper-gen.h         |   6 +
 include/exec/helper-proto.h       |   6 +
 include/gdbstub/helpers.h         |   9 +-
 include/tcg/tcg-op-address-bits.h |  21 +++
 include/tcg/tcg-op-gvec.h         |  11 +-
 include/tcg/tcg-op.h              |  38 ++---
 target/alpha/cpu-param.h          |   2 -
 target/arm/cpu-param.h            |   7 -
 target/arm/helper.h               |   6 -
 target/arm/helper64.h             |   5 +
 target/arm/internals.h            |   1 +
 target/arm/kvm_arm.h              |   3 +
 target/arm/tcg/arm_ldst.h         |  16 ++-
 target/arm/tcg/translate-a32.h    |   2 +-
 target/arm/tcg/translate.h        |  28 ++--
 target/arm/tcg/vec_internal.h     |  49 +++++++
 target/avr/cpu-param.h            |   2 -
 target/hexagon/cpu-param.h        |   2 -
 target/hppa/cpu-param.h           |   2 -
 target/i386/cpu-param.h           |   2 -
 target/loongarch/cpu-param.h      |   2 -
 target/m68k/cpu-param.h           |   2 -
 target/microblaze/cpu-param.h     |   2 -
 target/mips/cpu-param.h           |   2 -
 target/openrisc/cpu-param.h       |   2 -
 target/ppc/cpu-param.h            |   2 -
 target/riscv/cpu-param.h          |   7 -
 target/rx/cpu-param.h             |   2 -
 target/s390x/cpu-param.h          |   2 -
 target/sh4/cpu-param.h            |   2 -
 target/sparc/cpu-param.h          |   2 -
 target/tricore/cpu-param.h        |   2 -
 target/xtensa/cpu-param.h         |   2 -
 accel/tcg/translate-all.c         |  15 +-
 target/alpha/translate.c          |   4 +-
 target/arm/arm-qmp-cmds.c         |  25 +---
 target/arm/cpu32-stubs.c          |  22 +++
 target/arm/gdbstub.c              |  61 +-------
 target/arm/gdbstub64.c            |  57 ++++++++
 target/arm/kvm-stub.c             |   5 +
 target/arm/kvm.c                  |  21 +++
 target/arm/tcg/gengvec.c          |   3 +-
 target/arm/tcg/gengvec64.c        |   1 +
 target/arm/tcg/helper-a64.c       |   1 +
 target/arm/tcg/hflags.c           |   1 +
 target/arm/tcg/mte_helper.c       |   1 +
 target/arm/tcg/op_helper.c        |   1 -
 target/arm/tcg/pauth_helper.c     |   1 +
 target/arm/tcg/psci.c             |   2 +-
 target/arm/tcg/sme_helper.c       |   1 +
 target/arm/tcg/stubs32.c          |  19 +++
 target/arm/tcg/sve_helper.c       |   1 +
 target/arm/tcg/translate-a64.c    |  10 +-
 target/arm/tcg/translate-m-nocp.c |   2 +
 target/arm/tcg/translate-mve.c    |   2 +
 target/arm/tcg/translate-neon.c   |   2 +
 target/arm/tcg/translate-sme.c    |   1 +
 target/arm/tcg/translate-sve.c    |   1 +
 target/arm/tcg/translate-vfp.c    |   2 +
 target/arm/tcg/translate.c        |  28 ++--
 target/arm/tcg/vec_helper.c       | 222 +++---------------------------
 target/arm/tcg/vec_helper64.c     | 140 +++++++++++++++++++
 target/avr/translate.c            |   2 +-
 target/hexagon/translate.c        |   2 +-
 target/hppa/translate.c           |   2 +-
 target/i386/tcg/translate.c       |   2 +-
 target/loongarch/tcg/translate.c  |   2 +-
 target/m68k/translate.c           |   2 +-
 target/microblaze/translate.c     |   2 +-
 target/mips/tcg/translate.c       |   4 +-
 target/openrisc/translate.c       |   4 +-
 target/ppc/translate.c            |   2 +-
 target/riscv/translate.c          |   2 +-
 target/rx/translate.c             |   2 +-
 target/s390x/tcg/translate.c      |   2 +-
 target/sh4/translate.c            |   4 +-
 target/sparc/translate.c          |   2 +-
 target/tricore/translate.c        |   2 +-
 target/xtensa/translate.c         |   2 +-
 target/arm/meson.build            |  14 +-
 target/arm/tcg/meson.build        |  47 +++++--
 82 files changed, 548 insertions(+), 466 deletions(-)
 create mode 100644 include/tcg/tcg-op-address-bits.h
 create mode 100644 target/arm/helper64.h
 create mode 100644 target/arm/tcg/stubs32.c
 create mode 100644 target/arm/tcg/vec_helper64.c

-- 
2.47.3


