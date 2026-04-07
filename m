Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 628C5FB5184
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 02:28:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9wAd-0007Sj-O6; Mon, 06 Apr 2026 22:28:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w9wAb-0007RL-44
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 22:28:01 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w9wAY-0006vu-KB
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 22:28:00 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2addb31945aso33035755ad.1
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2026 19:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775528877; x=1776133677; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=t9H+9lo8IRpq9cVLuFBMQzOze2N+c/IFOo/ETmEeXHU=;
 b=k2LXgFnvpxNH+CT8D85mFc9/uRDhrbT4z2p1MyAnRkELcwzvM5sYR1NxI4avtM0TZS
 KujlPwAAcLzOQEfptWSxs72u2Y/Le8pqIpIiZIqUqMvoXKogZnQ5sevBcooR0QQbxENj
 SRou+gnbROcAaTKdTnAvrcPliojOqgDPsfEesnKxPzCYwNHV9CHojf+h/M8iLigGBHtg
 Yhg/BknefNxEen24KSBTt6xuywtFtXxAibRLjSEC+oZw9529WV5whpdGKKi9fV8YVrEy
 r1XbIBN5FPqdHYMuFleF93auGjkoN3WvhhmUfXrKVJqlOS7d3rQBK+QNIZbAHvjYJCEG
 BIBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775528877; x=1776133677;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t9H+9lo8IRpq9cVLuFBMQzOze2N+c/IFOo/ETmEeXHU=;
 b=Xn+SdyeH4zLbepgzANaHS3+vtSes5YDmCaB4MYAoWbyayFmdjqvQsbkzldvWdaFlKr
 TQ+0+gEUfPhutI377AufmxwOpj/5sXnIMb6/sNPgOAsiUY5Udz0bqMbLkRetQuA32QrO
 lKdD0ujqyMwHkImx0XlP+G6cy8JywjHSC96VK8Ed22EyeK90+n39d/2EA9sW551wIgsf
 tLc1tV4DfgQEJnUMQ0lS1Ulwdi2tJ1NHvxUOkAFC+9zg4BUO9Z7LCbS9Kv4RGVBkzRXp
 stZRgtURRABmFx+MeBFQVVIvrJKxT5CdhQoNxAnaLINhR5fVS/A+cGl5BhVG5clCVyIm
 COcw==
X-Gm-Message-State: AOJu0YxcCMoMG/VamY5FG5Bn0PceNGMuO2lWnxkWLaY37gnviZgM2OYJ
 4YWHGNsHpW/V3nmORuA09AoTw52XM//6mACg3QReXWCcGU54o2M4UsdUOcwqhG0HKEOr1/CqUhV
 lIqtLf+Pquw==
X-Gm-Gg: AeBDieunovfXvqF3tj/zx7zI6LdnE/ZrOFKqFAWydHbUFYvB5nmVTsLvjyoZX/lqFW3
 E1SE83KGUyUPyg2P4hy0JoChcHfQWk70S3yBUb6XmOyXLqKOC9ALb/M9of91A8nW284AvBCKExw
 iAW5ssLNC06FsynnGe6VnQkSsge5czUZZN50Py4q0H5v8wZXnYBKS2vMK9LuVm4eWpM1NwpYSoT
 gws881H0DKIuu7xIdPKlZ01TP9vZtkMp02MtsfgCJrpm12z8mloqWytzUGm/n3KIXj3clkT22cz
 TRWcAg3OUHyJsWWUHhEFPKfhdOg7y5ceViwMkyY8pnXWQWhGJREfbYeX4rSXoBslH3ToL6EWy6g
 twEQX3SLfIRzb2roWfZTruQjZ7v/rgRJK7aowwjrDtDCf8ndVjXro4QLM64LyNxknPKiM5u8uBO
 1DAFLMSa1NhjTHKlRhvS6/4jnoQiSwtdTupR1j3Eca3qUI0wES4TUS3tGEK8rt6SvAJG+Go3hUQ
 wBh1FRdzqaHvds=
X-Received: by 2002:a17:903:b0e:b0:2b2:52af:52b8 with SMTP id
 d9443c01a7336-2b28184a5cfmr154050765ad.11.1775528876813; 
 Mon, 06 Apr 2026 19:27:56 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b2749794e8sm161423685ad.53.2026.04.06.19.27.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 19:27:56 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, jim.macarthur@linaro.org,
 qemu-arm@nongnu.org
Subject: [PATCH v9 00/20] target/arm: single-binary
Date: Mon,  6 Apr 2026 19:27:28 -0700
Message-ID: <20260407022748.57629-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62b.google.com
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

v9
--

- introduce aarch64_translate_code *before* adding parameter to translator_loop
- use TCG_TYPE_VA as address type for translator_loop
- remove inline marker on functions merged from arm_ldst.h to translate.c
- refactor arm_ldl_code/arm_lduw_code

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
  target/arm/tcg/translate.c: extract aarch64_translate_code()
  tcg/translator: add parameter to translator_loop for current addr type
  target/arm/tcg/translate.c: replace TCGv with TCGv_va
  target/arm/tcg/translate-a64.c: use translator_ldl_end instead of
    arm_ldl_code
  target/arm/tcg/arm_ldst.h: merge in translate.c
  target/arm/tcg/translate.c: replace translator_ldl_swap with
    translator_ldl_end
  target/arm/tcg/translate.c: remove target_ulong
  target/arm/tcg/translate.c: make compilation unit common

 include/exec/translator.h        |   4 +-
 include/tcg/tcg-op-mem.h         | 126 +++++++++++++++++++++++++++++++
 include/tcg/tcg-op.h             | 100 +-----------------------
 target/arm/internals.h           |   2 +
 target/arm/tcg/arm_ldst.h        |  47 ------------
 target/arm/tcg/translate.h       |  14 +---
 accel/tcg/translate-all.c        |   1 -
 accel/tcg/translator.c           |   4 +-
 target/alpha/translate.c         |   3 +-
 target/arm/cpu.c                 |   6 +-
 target/arm/tcg/op_helper.c       |   1 -
 target/arm/tcg/stubs32.c         |  24 ++++++
 target/arm/tcg/translate-a64.c   |  15 +++-
 target/arm/tcg/translate-sme.c   |   1 +
 target/arm/tcg/translate-sve.c   |   1 +
 target/arm/tcg/translate.c       |  72 +++++++++++-------
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
 34 files changed, 301 insertions(+), 228 deletions(-)
 create mode 100644 include/tcg/tcg-op-mem.h
 create mode 100644 target/arm/tcg/stubs32.c

-- 
2.47.3


