Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48985C52D7C
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2024 16:06:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1scS71-0004KF-Tm; Fri, 09 Aug 2024 12:05:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1scS6i-0004Hz-Jg
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 12:04:48 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1scS6W-0005va-41
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 12:04:40 -0400
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2f025b94e07so25270571fa.0
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2024 09:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723219473; x=1723824273; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6V3dVlNNQOB+bbjpB/NlZwsZDkGp55ceS7gvHvrMkjg=;
 b=rhOT1uXFFuNf0x0LP5z/ErJGHsGWJ1/L0wwHMEDr1lx/sMSv7+bCSWYsIMOZCQAlIb
 wVQqKWEfxoe2g3JTgpf21QCZZinKMwlI/s1uLgY4PdiEG818LgrGykYpJaBVF6QTCV4O
 3mphMjZCihVPROVxbLrg2SVDI2XWFVG8HDttmxK1LquIV4nlPWJ6QYW83YY+ywZFe80N
 SdTTOrg7ws3ERnpJThgnKbgBA5HOUR+YEomWROAVhyvE1o+Vp0YyWaPrGxGw31Rb2uig
 5eKX/ZH0+3U5m3NHLRI8sOI/loN2gCgoASsUggXih4eZ2JGkUR3SkT8TqaiLRa5i6T+d
 y5ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723219473; x=1723824273;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6V3dVlNNQOB+bbjpB/NlZwsZDkGp55ceS7gvHvrMkjg=;
 b=NRI0gtXXlsyXFL175k9paJCq7stKZ4zW7K+w7mBnTL9zr4Q/HI4whNSEkpNgbbk50w
 c4LS+WMjJxiYc5CxO2uDhblyjzdG5GHaTk7CX7rIVOiDTnAG+nBQB82WxxkyBz0T3LNU
 xa2mfa5E+7cpKGbYm1pN/xeTVGbWUORd7+Dj97Xg/RWSr3XSirk/cP7V3grBuxJxqosS
 bRhG94309umrpyJzYuTesR9XJab+Z0+zccUqbshUu+rbQzfj2u1xszRfWreHCaPtAYmt
 6O2LyYCJbe+7x+++qcXmuxOwyzN6u/8uAs5dQx/emZoOkSHK/4gqKZf3WXmux0qHnB7H
 olqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVkpWsU48e6VmNXolWAwyZRtX3amzkGcPWZ0eMuOe1xnnl7lDElWXKpF10kdumbIiMvbKhuoYXoohocRVRxl6u9mOkN6A=
X-Gm-Message-State: AOJu0YxZZlQhUiJuRQqXrCZp5oRvpbcTuK/8K1dm7wvGDcFpOgGLV7CO
 lEaBNP8rpgElG+VNBpsk9LIJpxJSsgVaYua4STfhitP2Sg8aRA6Pc/iUAiFX0wU=
X-Google-Smtp-Source: AGHT+IHPUDHP9e+MjgQLPtymj0FTQ5dY3jmPB3Rvt35FAz0SvOwVQ1CMkrnR7Mpqj7bjDC758z7v5w==
X-Received: by 2002:a2e:a549:0:b0:2ef:24a0:c176 with SMTP id
 38308e7fff4ca-2f1a6c6cc9bmr19680931fa.28.1723219472227; 
 Fri, 09 Aug 2024 09:04:32 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-429059714d5sm135171295e9.13.2024.08.09.09.04.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Aug 2024 09:04:31 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
	Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 0/2] target/arm: Fix EL3-is-AArch32 mmu indexes
Date: Fri,  9 Aug 2024 17:04:28 +0100
Message-Id: <20240809160430.1144805-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x234.google.com
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

Our current usage of MMU indexes when EL3 is AArch32 is confused.
Architecturally, when EL3 is AArch32, all Secure code runs under the
Secure PL1&0 translation regime:
 * code at EL3, which might be Mon, or SVC, or any of the
   other privileged modes (PL1)
 * code at EL0 (Secure PL0)

This is different from when EL3 is AArch64, in which case EL3 is its
own translation regime, and EL1 and EL0 (whether AArch32 or AArch64)
have their own regime.

We claimed to be mapping Secure PL1 to our ARMMMUIdx_EL3, but didn't
do anything special about Secure PL0, which meant it used the same
ARMMMUIdx_EL10_0 that NonSecure PL0 does.  This resulted in a bug
where arm_sctlr() incorrectly picked the NonSecure SCTLR as the
controlling register when in Secure PL0, which meant we were
spuriously generating alignment faults because we were looking at the
wrong SCTLR control bits.

The use of ARMMMUIdx_EL3 for Secure PL1 also resulted in the bug that
we wouldn't honour the PAN bit for Secure PL1, because there's no
equivalent _PAN mmu index for it.

We could fix this in one of two ways:
 * The most straightforward is to add new MMU indexes EL30_0,
   EL30_3, EL30_3_PAN to correspond to "Secure PL1&0 at PL0",
   "Secure PL1&0 at PL1", and "Secure PL1&0 at PL1 with PAN".
   This matches how we use indexes for the AArch64 regimes, and
   preserves propirties like being able to determine the privilege
   level from an MMU index without any other information. However
   it would add two MMU indexes (we can share one with ARMMMUIdx_EL3),
   and we are already using 14 of the 16 the core TLB code permits.

 * The more complicated approach is the one we take here. We use
   the same MMU indexes (E10_0, E10_1, E10_1_PAN) for Secure PL1&0
   than we do for NonSecure PL1&0. This saves on MMU indexes, but
   means we need to check in some places whether we're in the
   Secure PL1&0 regime or not before we interpret an MMU index.

Patch 1 cleans up an out of date comment about MMU index
usage; patch 2 is the actual bug fix.

This fixes the bug with the repro case in the bug report, and it
also passes "make check", but I don't have a huge range of
Secure AArch32 test images to test with. I guess it ought to go
into 9.1 as a bugfix, but the nature of the patch means it's
not very easy to be confident it doesn't introduce any new bugs...

Bernhard: I suspect this is the same bug you reported a few months
back in this thread:
https://lore.kernel.org/qemu-devel/C875173E-4B5B-4F71-8CF4-4325F7AB7629@gmail.com/
 -- if you're able to test that this patchset fixes your test
case as well, that would be great.

thanks
-- PMM

Peter Maydell (2):
  target/arm: Update translation regime comment for new features
  target/arm: Fix usage of MMU indexes when EL3 is AArch32

 target/arm/cpu.h               | 50 ++++++++++++++++++++++------------
 target/arm/internals.h         | 27 +++++++++++++++---
 target/arm/tcg/translate.h     |  2 ++
 target/arm/helper.c            | 34 +++++++++++++++--------
 target/arm/ptw.c               |  6 +++-
 target/arm/tcg/hflags.c        |  4 +++
 target/arm/tcg/translate-a64.c |  2 +-
 target/arm/tcg/translate.c     |  9 +++---
 8 files changed, 95 insertions(+), 39 deletions(-)

-- 
2.34.1


