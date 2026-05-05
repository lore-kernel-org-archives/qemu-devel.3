Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC22DFF885A
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 11:20:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKDp7-0007Ew-UV; Tue, 05 May 2026 07:20:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wKDp6-0007E4-La
 for qemu-devel@nongnu.org; Tue, 05 May 2026 07:20:20 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wKDp4-0005oy-Bh
 for qemu-devel@nongnu.org; Tue, 05 May 2026 07:20:20 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-44985f4ab0fso2309150f8f.0
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 04:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777980016; x=1778584816; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=AoNkPdfNYcUACJXAldjc8yWRMq0hFedw1nCez7xbQqU=;
 b=rGutcQ6rmGVZFhSRuPLO0VEtJrwCeMBJPCFFZZ5kc1SD+0CDWRJuQxqihC2gQKBKqq
 7qSQc79Wd/f46OUYKLwMOpWW1MUyargS0aJ6bL85BD2+u4NEUr4sOq86YU/yRs+uubmr
 Xha0rOwIFDPnO5nMLmmdplqcOI2hj6pJoOuSCXMCmgBCqDHoM+ZgGnlPt8dFJ5hWB9tm
 i7ONxbp5dxU4Ut3HROVQEu6fGqW9CUi+eLoJ5F7aeOhWhrPip4UN9WWwJCeK8l2P9FAS
 7eyBKMMAng60wNj1ewGSWk13uHGrHK2J330JxoOMl9pE7yJ4o3KbJe9A+a6nocbB6oDk
 gJow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777980016; x=1778584816;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AoNkPdfNYcUACJXAldjc8yWRMq0hFedw1nCez7xbQqU=;
 b=k4n9fFRV2LF6i7k5Hc0hB91l0XepK4LGUGn1jgxGlwkDAjplDMYbDCiW6cWK7ZvT9y
 xziHKTXPti682dt6FbyiJCIMKj/XcgBt4AXtwflTIpOOgC/1GQs2FTSyZWqsdOndVIwr
 +er/1s7NPIcjNoxpjbnfMU8sW11CfE7cN2C41T0ZZ+hH0Benr8z6H2Jss0RXTBYKO6Ij
 5lv9G+bZaV5GKVFkE8mFhcTU1IHA2tnmucoZ04c4vniaNDfxpmLJgwKf6V845aMBkrG4
 ZWsD6h6h6DCk9i9glZj1WtHRLh4YjPiTErMalN2r+DsPPO+ReiOjpkXze+7xxJ26SuBg
 ixiw==
X-Gm-Message-State: AOJu0YzNFpNvT3l+eqPZTg7FHxDJEMJ60qLCuY16E9J1MYzgUgI7U8Ul
 P8euNd3Nvv4+cJFUVIntxwBEijqcG1kre7kXeP0uZWdc/9mauAkqSZ8Yi9RN+prfyl8=
X-Gm-Gg: AeBDieuGfln2eUZKpiuO1YqIbO7pxcaetkUywz7eDINHuwoRubkXxDafjJFk940SWq5
 kBx6F6lb5pR8Gp9JpXmfMmI6ZyjGlw4BuDWjPI8mkV/HG6uCCM/5IC+4dfi5GSZNIcwW7uXpPW4
 Zh2qgTFhsrCNvqrkPJX/3Rb/1QUeAz1SEnLP7C9bfaMNbOTY9idXvWkrF4hvbsTkZ4HcO6K60Ym
 wJpKwyXfEPdXB0lRlWSLSFqoE+1/8vXGan0Y7Up1crwTrMB5xsnLILAKPN03sotY7ERPGBotFiA
 Av+GhOlBISxGwenrGr16n6de6PlQsFKzqlJLzH2yyciD7grT10NPpaaTS6wLaRU5lUR+S9pVRgd
 pH/UGufUAA5UKmTzwGgVO4gEOPGNWRfmYJspXeJJyXOHceEqluOU6DqOOb/Y5qIqd25nOkkqmAI
 q1FAKY5krY3sANBQzT7yM7O1of3CG6d96XVA==
X-Received: by 2002:a5d:6a04:0:b0:450:e5fd:e1a1 with SMTP id
 ffacd0b85a97d-450e5fde1cbmr508966f8f.3.1777980016391; 
 Tue, 05 May 2026 04:20:16 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45055d36dacsm3723597f8f.32.2026.05.05.04.20.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 04:20:15 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 497815F8E7;
 Tue, 05 May 2026 12:20:14 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org,
 Alexander Graf <agraf@csgraf.de>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v5 0/7] target/arm: fully model WFxT instructions for A-profile
Date: Tue,  5 May 2026 12:20:06 +0100
Message-ID: <20260505112014.102993-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42a.google.com
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

This series fully models the behaviour of WFxT instructions. We
already had support for WFE for M-profile but we left off A-profile as
it has more potential sources of wake-ups. The main one is the event
stream which includes events from significant bits of the timer
ticking over.

The refactoring from the previous iterations of the patch have now
been merged.

I've dropped trying to fully model the global monitor in favour of
taking advantage of the architectural flexibility to have an IMPDEF
event wake up for any reason. We treat the setting of exclusive_addr
as such a reason because it indicates the current vCPU is in a ldstx
exclusive region and we don't want the guest to deadlock. This does mean
the system won't sleep on WFE enabled locks but people shouldn't be
relying on QEMU to model real world sleep patterns anyway given the
efficiency of emulation compared to real HW.

Only the following patch still need review:

  target/arm: enable event stream on WFE instructions

v5
  - addressed rth's comments
  - all but one patch now reviewed

v4
  - precursor refactor patches now merged
  - dropped global monitor emulation
  - addressed other comments
  - tested with check-tcg and kvm-unit-test wfx tests

v3
  - fixed the WFE exception handling

v2
  - I've kept the tests separate, see:

    Message-ID: <20260417164328.1009132-1-alex.bennee@linaro.org>
    Date: Fri, 17 Apr 2026 17:43:20 +0100
    Subject: [PATCH 0/7] tests/tcg: more capabilities for aarch64-softmmu tests
    From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

  - tweaks to global monitor behaviour
  - STLR/STL will also trigger events to avoid deadlocks
  - see under the --- in the patches for details

Alex.

Alex Bennée (7):
  target/arm: teach arm_cpu_has_work about halting reasons
  target/arm: redefine event stream fields
  target/arm: ensure aarch64 DISAS_WFE will exit
  target/arm: implements SEV/SEVL for all modes
  target/arm: enable event stream on WFE instructions
  target/arm: handle the WFE trap case
  target/arm: implement WFET

 target/arm/cpu.h               |  16 +++
 target/arm/internals.h         |  22 ++-
 target/arm/tcg/helper-defs.h   |   3 +-
 target/arm/tcg/translate.h     |  18 +++
 target/arm/tcg/a32.decode      |   5 +-
 target/arm/tcg/a64.decode      |   5 +-
 target/arm/tcg/t16.decode      |   4 +-
 target/arm/tcg/t32.decode      |   4 +-
 target/arm/arm-powerctl.c      |   6 +-
 target/arm/cpu.c               |  53 +++++--
 target/arm/helper.c            |   8 +-
 target/arm/kvm.c               |   5 +-
 target/arm/machine.c           |   2 +-
 target/arm/tcg/op_helper.c     | 254 ++++++++++++++++++++++++++++++---
 target/arm/tcg/translate-a64.c |  64 +++++----
 target/arm/tcg/translate.c     |  31 ++--
 16 files changed, 395 insertions(+), 105 deletions(-)

-- 
2.47.3


