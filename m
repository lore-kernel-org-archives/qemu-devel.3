Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2E80F46C45
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2026 15:06:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9lVS-0002sZ-2z; Mon, 06 Apr 2026 11:04:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w9lVP-0002rv-SQ
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 11:04:48 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w9lVN-0003q9-AP
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 11:04:47 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2aaf59c4f7cso18037105ad.1
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2026 08:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775487883; x=1776092683; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xhWX4LN6/7U+l0GQfGNZYyz9ZAXayPixhHRwsoCZtho=;
 b=qFhypsFrXCREBjfjAdLxtpvu8oLFpSKLvcgHz1RfMYihbWzO2zLpk0Xuryx+Z8VwPY
 sh1fV4EQ+mG8RQ/RAMNhGJQDXkuHvwCU3KH5dSjYwWy8Q/R52G536QDVzpWAnzP2UE7m
 cyr16BFhXuGhFL4AZBwPivo08zzvFDxRwSmWZyNRQ39F1fNUMPGxvz9BflpZh4Qn9+Om
 atNbblG8Yi9Xw2gHTJSJPmt4F67Wv6SCfiUNy517mihFHPVMncVibmU4m/ivxjEYnOCQ
 2NmlpeXQQJe2FpTtjmhXs17gENqPihDCWEkmxZgtxxBWUKIMv8XwVINVXCJ24eCLg70R
 EgOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775487883; x=1776092683;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xhWX4LN6/7U+l0GQfGNZYyz9ZAXayPixhHRwsoCZtho=;
 b=TZpkqwqQ+F+UU63Mc5LbfQpBe4lT4gmMWYucXxLweKKC36VtQvw7wJhR4FgMtltBAm
 d6+dzzCXFj3P5glpgu2AL/weAwssOf6IJX5bo3SD93h2wr1DXdhW4lVGV0zesAYb/r1/
 EWMwbq1QI3/aVj3KpV4DL7blrAQxOfkHgmdaulsMCKb5WKG7qNQpzRdeoaS+u2gw7+SB
 oB0hNpihk5mUlFmCx727PeiyPGWBFqvuvDEJWXilTMiJBZsGjo+e42B1POK6XF2dSMqp
 wfeCBBjFiRBdUb9jA3ZZlDbeqzYzz2/s553sAnZ/Q8ivB+l11XCtL4896+hcM88TMzsj
 xs6A==
X-Gm-Message-State: AOJu0Yz5EvASEe9XnrtnmgZlsDA5WpGWaAQZcVxcw3vmh8h2ssh4HBbH
 HvIKvlyy0p9i7mryOvrBJXx1iTeJbZjCZYbBFjsV1+oRC0JlK4Tt5CbdATKOg6V8w0PnpVQJJFP
 mKbJyooaqZg==
X-Gm-Gg: AeBDieufySBanpwx4v9dfja+c6wxNPv3P6ojAvBQwb5MNqIM348AqS6me/WeWOj6LeJ
 BVE6VoirjQUIkUhdb2txydwUE+UBuEJ3abR7DO1VGljzpuZAp9XUGkvBHnjicC8fUoNuYmlQca4
 zstTYxrHRdkjjkef0zdg37mdLL6UM5iQ6x8MdNQucFY9xn6W4Aol/Q2nuj/jp1U0lj55iMjWyNz
 JkgAY61yTrHS6UUgX2YdprJKsZ2eTmw1BV6mrkDWBXp112Pk2S1yJnKvqrxwuE5SC65jDxqm4z5
 sXo82xHc5B75hzaXvhsyy4cweOiMkCp5s+N/shDAAtG2/DIffXAOy/ErtiqBcz3x/slZZM2NEIv
 8lltGYKVcHpNl0vm0DPZ3y7uyxJkqMRnLpk8jVyrmwaLOyDNuQ1ipgReSxyGo/LQFY/nF+lr0PD
 /fDQp66R4UH+0iovh3VogAaAsVQoZGOvbC286m8T35zXTsuy60aE7PK3vKQMOB+MNqWoKQpeMTY
 q7ZOzNoax/Gvzo=
X-Received: by 2002:a17:903:3804:b0:2b0:59c4:e9dc with SMTP id
 d9443c01a7336-2b28170f376mr139020735ad.22.1775487883264; 
 Mon, 06 Apr 2026 08:04:43 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b274979d72sm137770075ad.51.2026.04.06.08.04.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 08:04:42 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, philmd@linaro.org,
 jim.macarthur@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v7 00/14] target/arm: single-binary
Date: Mon,  6 Apr 2026 08:04:20 -0700
Message-ID: <20260406150434.407201-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x630.google.com
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

Pierrick Bouvier (14):
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

 include/exec/translator.h        |   4 +-
 include/tcg/tcg-op-mem.h         | 126 +++++++++++++++++++++++++++++++
 include/tcg/tcg-op.h             | 100 +-----------------------
 include/tcg/tcg.h                |   5 ++
 target/arm/tcg/translate.h       |  14 +---
 accel/tcg/translator.c           |   4 +-
 target/alpha/translate.c         |   3 +-
 target/arm/tcg/op_helper.c       |   1 -
 target/arm/tcg/stubs32.c         |  17 +++++
 target/arm/tcg/translate-a64.c   |   1 +
 target/arm/tcg/translate-sme.c   |   1 +
 target/arm/tcg/translate-sve.c   |   1 +
 target/arm/tcg/translate.c       |  36 ++++-----
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
 target/arm/tcg/meson.build       |  51 +++++++++----
 31 files changed, 255 insertions(+), 160 deletions(-)
 create mode 100644 include/tcg/tcg-op-mem.h
 create mode 100644 target/arm/tcg/stubs32.c

-- 
2.47.3


