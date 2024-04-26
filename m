Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79E5FC04FFE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 12:30:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0Khf-0003BA-AG; Fri, 26 Apr 2024 08:29:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s0Khd-00039y-QV
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 08:29:21 -0400
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s0Khb-00064e-3e
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 08:29:21 -0400
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2dac77cdf43so25377201fa.2
 for <qemu-devel@nongnu.org>; Fri, 26 Apr 2024 05:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714134555; x=1714739355; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=aWOQg8i3ZSVw9+Yd0IWfmrzoraoNiCmCJ5QlhrxDKfA=;
 b=G4eWA8hodvlsHnthIwlBLH6LuYDDjJb1yxcQY7zLTIS/Wl15h26DNLzX2rmCknLPX5
 F3G6HBVRhs4TirkcBC0PQtPAB0zF6Z8B4N1RKBBrLTiXJEMemr/uN9iO581fQMHJuwUY
 7TtwOKlt/YVvioSL5EcA22r7d1CGBah2QKmYg9hQd3feAqgq/5v8YZzPXTlZbQhL/7/I
 1GbflY6PMYA3VTFjnQ/nXoEgbc76IW8+ooZ+1zKAiKWbAFYMjaoZqcsHazpBqxnoM/dN
 2K+8v6AQhUCjTxjFeytzVvsj2l0hyE2TkCNOEymwagBLZdl4lD+mOEtRbN8VAfjAuySU
 qMkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714134555; x=1714739355;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aWOQg8i3ZSVw9+Yd0IWfmrzoraoNiCmCJ5QlhrxDKfA=;
 b=ZOf9ohYt1V+aCzTptglA5jYvSpstIXsr9FJ3TU+JQsfGsdhOzcCgcxC/KaHslHE/d1
 j4n+2G1AQEG+80+Zy7/v+xMTPraz2Oc35Kz8h/gBfP/RVTk+nCRANGsd44if0w8you+1
 qOcibaHQD7/3z6vKzMzH/j61bmZ0z3fV4kKcp5RSx5hGFkOb6va8n8XW5z9c8A4cs4px
 PHc9M3uF1bnMwv2jbzEToRZLi6an55Q5cOfpm6LVlSa23U5nhR0syqWzqwkX2OSbiK6r
 ZjNrMYDXyb8I35Ztxknh0wZ6mGsNmagm/YxTSMlpKPm8H+DHeyQiO1lQfg7jsIsdvMgx
 dOLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXagevpMFSYQmk/m2/SIXgQqsKeyBTIOlYIVTYJqtbov6KVNeEyxgQp49ilXykoewWzJRcg+zadUQF/sen1BJysLdqVnaI=
X-Gm-Message-State: AOJu0YwGbYQ70eiPyDKoztlREiDa3MTxmhIFKRc9ehrpTEV7uLlU/kwn
 YT63IG+6qv78cNDxqln4R/Xhctx5rrYTL9GYGMZjkN9VDQ42B/KCtYl6TOnLVS8=
X-Google-Smtp-Source: AGHT+IGDRYqsU7V8Bc47EPwXfDT5H8Btm/X4pSTmB9x5ZtXLlYOh8r3rko1sl3vfmtq1FKI+6mOQ5A==
X-Received: by 2002:a2e:7808:0:b0:2de:9fee:40ea with SMTP id
 t8-20020a2e7808000000b002de9fee40eamr1474785ljc.51.1714134555298; 
 Fri, 26 Apr 2024 05:29:15 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 m15-20020a05600c460f00b0041a964b55ddsm1397134wmo.1.2024.04.26.05.29.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Apr 2024 05:29:14 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Radoslaw Biernacki <rad@semihalf.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Subject: [PATCH v2 0/4] target/arm: Make the counter frequency default 1GHz
 for new CPUs, machines
Date: Fri, 26 Apr 2024 13:29:09 +0100
Message-Id: <20240426122913.3427983-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22d.google.com
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

In previous versions of the Arm architecture, the frequency of the
generic timers as reported in CNTFRQ_EL0 could be any IMPDEF value,
and for QEMU we picked 62.5MHz, giving a timer tick period of 16ns.
In Armv8.6, the architecture standardized this frequency to 1GHz.

Because there is no ID register feature field that indicates whether a
CPU is v8.6 or that it ought to have this counter frequency, we
implement this by changing our default CNTFRQ value for all CPUs, with
exceptions for backwards compatibility:

 * CPU types which we already implement will retain the old
   default value. None of these are v8.6 CPUs, so this is
   architecturally OK.
 * CPUs used in versioned machine types with a version of 9.0
   or earlier will retain the old default value.

The upshot is that the only CPU type that changes is 'max'; but any
new type we add in future (whether v8.6 or not) will also get the new
1GHz default (assuming we spot in code review any attempts to set
the ARM_FEATURE_BACKCOMPAT_CNTFRQ flag on new CPU types as a result
of cut-n-paste from an older CPU initfn ;-)).

It remains the case that the machine model can override the default
value via the 'cntfrq' QOM property (regardless of the CPU type).

Unfortunately the TF-A firmware used to hard-code the CPU frequency,
resulting in guest timers not running for the right duration. This
is fixed in TF-A git but not yet in a release, and affects users
running TF-A on either virt or sbsa-ref. For virt I think running
TF-A is not a common setup, and besides we have versioned board
models so users can use virt-9.0 if they want to run older TF-A
binaries. For sbsa-ref the machine isn't versioned and TF-A is
part of the standard guest software stack, so I've opted in this
patchset to have our board model retain the old 62.5MHz clock for
now. We can update that once e.g. TF-A has made a release with
the fix (and we've updated our Avocado test's binaries!). I
plan to leave it up to the sbsa-ref maintainers to decide when
they're happy to make that change.

Patches 1 and 4 are from v1 and have been reviewed.
Patches 2 and 3 are new and together keep sbsa-ref on the old
62.5MHz value, at least for now.

thanks
-- PMM


Peter Maydell (4):
  target/arm: Refactor default generic timer frequency handling
  hw/arm/sbsa-ref: Force CPU generic timer to 62.5MHz
  hw/watchdog/sbsa_gwdt: Make watchdog timer frequency a QOM property
  target/arm: Default to 1GHz cntfrq for 'max' and new CPUs

 include/hw/watchdog/sbsa_gwdt.h |  3 +--
 target/arm/cpu.h                | 11 +++++++++
 target/arm/internals.h          | 15 +++++++++---
 hw/arm/sbsa-ref.c               | 16 +++++++++++++
 hw/core/machine.c               |  4 +++-
 hw/watchdog/sbsa_gwdt.c         | 15 +++++++++++-
 target/arm/cpu.c                | 42 ++++++++++++++++++++++-----------
 target/arm/cpu64.c              |  2 ++
 target/arm/helper.c             | 16 ++++++-------
 target/arm/tcg/cpu32.c          |  4 ++++
 target/arm/tcg/cpu64.c          | 18 ++++++++++++++
 11 files changed, 117 insertions(+), 29 deletions(-)

-- 
2.34.1


