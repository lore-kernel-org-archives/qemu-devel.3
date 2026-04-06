Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 730FAF46C70
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2026 18:27:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9oea-0007L3-Is; Mon, 06 Apr 2026 14:26:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w9oeU-0007IG-FU
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 14:26:22 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w9oeR-0002KQ-Nj
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 14:26:22 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-c76f55b60c9so647532a12.0
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2026 11:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775499977; x=1776104777; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=M97suiVPrp1lyPoQkNqQ+dJH5bK6giyR71NuVAofqHg=;
 b=OxNfHvYfZXxzG+aV9vD7p6arQsibchSxxSo5qLLnunk0SGGffVlo/zz9YeYBxm6WKf
 Jj8TZkxuqWy54y1/8EITCTw9Kq0v5Sl7oV6ZLzpTyUmGh1sp44Ce2kz6CrNF5NzVOVIy
 j3NCtd0Zr/rQi9NMBg85i8KoYvxEJUd9+DYA6AQGw2DCVVjTKWjfoza5KILIUDLJdbWg
 XEtghhV/VoQQFs4qKZT60gHRH+wcQK9qYX/Sm3q5h3ipo8abR9XnxLZyvqSkP+0CPGX1
 qi0sHtZGKEcj1iiK7HKep92JZZzt58BSy3h/uiNsPTQUYpn8ikDbXPVE6KBc1+T7GEfU
 XNgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775499977; x=1776104777;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M97suiVPrp1lyPoQkNqQ+dJH5bK6giyR71NuVAofqHg=;
 b=BnHmW+FwJmFWLqWFPGSLNeCRxFq4YPncXm57daBXf8XyY8gyjz+v/IHEy1r1VtEkvY
 8YbbOTVqYbmwVkmvILQJvqCyzi81gkddDA0/69fcyd/7fXS/kBb6HS+PY1TP3P8nb+MA
 ok7TAZ2Zj35YFdBFWXiEpp0p0PVBYu0EIvkY4aHMxvEcoSgkSoSXcqMAH5EMhp+icg2Y
 CnhDz+DRLjhQYnqJcuAPRWg93Bh9IK3yYNzUitcotFvOVCBFjVYj/YPy9MQbyVq7VuLF
 XdlFRxE9oi7/K9E155g1FnxU1/iYcILMDfr42XOqhjoq9EbYS9kKnpR0ZhvqB5qeD+M/
 ZnFw==
X-Gm-Message-State: AOJu0YxW/9h302e2gZHViFuu4F6sfq+O1nX67/uIM9JouBkNgMqYW1w7
 Mf2/AJWRWCH3R4T0mVPER9Jz/bMxybNDqqcWx9phi4TYyY5dvH6bNKyM4F0D/EyZLphzLJvPPtw
 7x9N0R7RLRg==
X-Gm-Gg: AeBDievpbE9/QONRJ8qzBULecdFbWUXNHt5Mf3KQzISHnFAk0YN0HTX0tiLOmj5Nk3N
 PyP32enGkSMuBpkOix4+xOOLNJk8OIQAhxYNumBqJXVlyGyiOfobt0itcjGXdV8YDVd4hh71eTO
 v/au5cVaCF6qzVs1usW+FNVRL/0uQgeB6GXu/GBsRyG1MuDq/BwqpJ5pT01mpz/Mb90enUy+/E+
 sI/WbRYPGJXagWkqD1VWfypBG2JVqonlvoWigO2DAlcvsUqqQKNSlR8tUUFxfHbYOtLlhvUtNo+
 JfewieyhhsMGLrWCpEcWqHbRlCSnsz3Yfgidm57B40ynlO+bBe4jOgWxomXGqoAcHZihZtUlTWK
 VKnUEU+8XI1ydeEH+svmewZDj0RMYFisUBbG+2SLpbfn61zGBdXKiuFDR67CdsK6LGccM0kg3F0
 lOVykc7l67TUfP2DbkMAdV8qaS+4tI3fSt7WmsIwncXNAmDK/195ocDdFM0miw4Svh0hkSNi695
 KzG0tb8BFmWEME=
X-Received: by 2002:a05:6a20:12c5:b0:39f:24ad:ad00 with SMTP id
 adf61e73a8af0-39f2ed758bamr14155230637.7.1775499976973; 
 Mon, 06 Apr 2026 11:26:16 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c76c6561fe9sm12765080a12.15.2026.04.06.11.26.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 11:26:16 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, jim.macarthur@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, philmd@linaro.org, qemu-arm@nongnu.org
Subject: [PATCH v8 00/20] target/arm: single-binary
Date: Mon,  6 Apr 2026 11:25:49 -0700
Message-ID: <20260406182609.193886-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52b.google.com
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

This series tackles (most of) the rest of target/arm, especially tcg folder.

We extract tcg memory operation in a new header, with a new type representing
virtual addresses.

Initially, I went down the way to have a dynamic definition of TCGv, which
required much more boilerplate and runtime checks. After discussing with
Richard, I realized it was not needed, and that could simply split 32 and 64 bit
properly in different files instead. This approach will not work with other
architectures, requiring something else, but it's enough for target/arm.

Files left are:
- target/arm/tcg/mve_helper.c
- target/arm/tcg/m_helper.c
- target/arm/tcg/cpu32.c

v8
--

- make translate.c compilation unit common.

v7
--

- add parameter to translator_loop to indicate address type for current tb.
- remove TCGv from target/arm/tcg/translate.c

v6
--

- meson.build: extract decode files in separate variables and explicitly include
  them in user and system code. The duplication is now minimized: one instance
  for all system binaries, and one per user binary.

v5
--

- reimplemented what v0 did with new approach defining new tcg-op-mem header
- reapply all straightforward patches from v0
- only translate.c is left, but first want to validate that changes here are ok
  for maintainers before doing more.

v0
--

See original thread:
https://lore.kernel.org/qemu-devel/20260109053158.2800705-1-pierrick.bouvier@linaro.org/#t

Note about v1 -> v4
-------------------

- After v0 which was trying to do too many changes, v1 to v4 focused on smaller
  things, and all patches have been merged already.
  https://patchew.org/QEMU/20260219040150.2098396-1-pierrick.bouvier@linaro.org/

Pierrick Bouvier (20):
  include/tcg/tcg-op: extract memory operations to tcg-op-mem.h
  target/arm/translate.h: remove tcg-op.h include
  target/arm/tcg/translate.h: remove tcg-op-gvec.h include
  target/arm/tcg/translate.h: remove TARGET_AARCH64
  target/arm/tcg/translate-vfp.c: make compilation unit common
  target/arm/tcg/translate-neon.c: make compilation unit common
  target/arm/tcg/translate-mve.c: make compilation unit common
  target/arm/tcg/translate-m-nocp.c: make compilation unit common
  target/arm/tcg/op_helper.c: make compilation unit common
  target/arm/tcg/gengvec.c: make compilation unit common
  target/arm/tcg/translate.c: remove MO_TE usage
  target/arm/tcg/translate.c: replace target_ulong with uint32_t
  tcg/translator: add parameter to translator_loop for current addr type
  target/arm/tcg/translate.c: replace TCGv with TCGv_va
  target/arm/tcg/translate-a64.c: use translator_ldl_end instead of
    arm_ldl_code
  target/arm/tcg/arm_ldst.h: merge in translate.c
  target/arm/tcg/translate.c: replace translator_ldl_swap with
    translator_ldl_end
  target/arm/tcg/translate.c: remove target_ulong
  target/arm/tcg/translate.c: remove TARGET_AARCH64
  target/arm/tcg/translate.c: make compilation unit common

 include/exec/translator.h        |   4 +-
 include/tcg/tcg-op-mem.h         | 126 +++++++++++++++++++++++++++++++
 include/tcg/tcg-op.h             | 100 +-----------------------
 include/tcg/tcg.h                |   5 ++
 target/arm/internals.h           |   2 +
 target/arm/tcg/arm_ldst.h        |  47 ------------
 target/arm/tcg/translate.h       |  14 +---
 accel/tcg/translator.c           |   4 +-
 target/alpha/translate.c         |   3 +-
 target/arm/tcg/op_helper.c       |   1 -
 target/arm/tcg/stubs32.c         |  24 ++++++
 target/arm/tcg/translate-a64.c   |  14 +++-
 target/arm/tcg/translate-sme.c   |   1 +
 target/arm/tcg/translate-sve.c   |   1 +
 target/arm/tcg/translate.c       |  80 +++++++++++++-------
 target/avr/translate.c           |   3 +-
 target/hexagon/translate.c       |   3 +-
 target/hppa/translate.c          |   3 +-
 target/i386/tcg/translate.c      |   3 +-
 target/loongarch/tcg/translate.c |   3 +-
 target/m68k/translate.c          |   3 +-
 target/microblaze/translate.c    |   3 +-
 target/mips/tcg/translate.c      |   3 +-
 target/or1k/translate.c          |   3 +-
 target/ppc/translate.c           |   3 +-
 target/riscv/translate.c         |   3 +-
 target/rx/translate.c            |   3 +-
 target/s390x/tcg/translate.c     |   3 +-
 target/sh4/translate.c           |   3 +-
 target/sparc/translate.c         |   3 +-
 target/tricore/translate.c       |   3 +-
 target/xtensa/translate.c        |   3 +-
 target/arm/tcg/meson.build       |  57 ++++++++++----
 33 files changed, 312 insertions(+), 222 deletions(-)
 create mode 100644 include/tcg/tcg-op-mem.h
 create mode 100644 target/arm/tcg/stubs32.c

-- 
2.47.3


