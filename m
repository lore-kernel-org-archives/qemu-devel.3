Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 248A3C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 18:46:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxtFZ-00086V-V4; Fri, 19 Apr 2024 14:46:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rxtFX-00085Q-6K
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 14:46:15 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rxtFT-00011c-H1
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 14:46:14 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-344047ac7e4so2125700f8f.0
 for <qemu-devel@nongnu.org>; Fri, 19 Apr 2024 11:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713552370; x=1714157170; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=djhs4NFUqKq4Lo08iH8CrnfsBuX4hY+1rW2X0lQGRRM=;
 b=vqY+95Uoub2w03NMnjQtV/pfUMsdDCnomLESRDt9DWgJsjJDGj69FfajHXsIK/dVSr
 zVNKC3zRzGSVVUG5fPkAXI78r9VTM+OzozajFIJin7G6TuGPzqT5XbDepvKD9vz07jGS
 guW6A9CRsQfgYlXxDWWQBtpzRuKHwybK02PTZLL2zpQtQO3nGXP6T7QE2VAJ3hWP+hfC
 ocAAChqL2ZNrHNdkHVOPakGp019TRhYLC/DE5mp0+XNCxmvZl+Ip5KyL0OlMSwCcazc4
 V3hX/S+UI73t2u+PKO519GsAvm991F4aDdxRax8/hciCzw3J7leOf3jsMtq5FkVuqcjt
 LiaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713552370; x=1714157170;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=djhs4NFUqKq4Lo08iH8CrnfsBuX4hY+1rW2X0lQGRRM=;
 b=uViN6YS15zKGfoQYGuW8twitRx3T7A0fx/xji3UM8OOpHfZtS6a30k7Aae29JVHkYg
 biyX2drMdmV3vj2/ekRc3MUeT0jzYNTut/4Pa8ep5C6Z0p5vBWvIUwTePRQmGS//UwAb
 h+9/lBw6jyuWGsexRIq7X4mq6VrEfv3s0boWrfVN1kkDBM1zAVcX93FwRon4hjhbax5n
 5/jtewPEnJRm8Aw0BPj8bpAOqRxBKpTi+m7eOWO3Yr5DcwBp32qIxPMKuyfE2hYIbE9W
 lsGbvjCLhNVYmaYCrUNUZCBMtabVprZCG+qk0jttqlw5BZ/EnuN6TrexJA7PTVyWpIHR
 Pumg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgmLjwyksY6Y+KgmkIFgBCqQt9IbwWBndZGpOO65wYsybj6W6AquBQAmJddlYjp51TIcoK7YAKnHQO1sdg27j0xqMmfhU=
X-Gm-Message-State: AOJu0YxJLXf8DmNeNeSzJ0oZ1IIym2QypH5XMjM3yrHlAYqvxYlh3HUG
 VWyouSYQ0rS0Ys7mUDNduNFzXtsXJsnk1iZpq0/W87UhfgYR9PeO8hywikk+KnP7iQW+AaFsdFB
 8
X-Google-Smtp-Source: AGHT+IFXopL9amoP5EH0zmuIYgBReT8lnFxUFS7XCbnOMkE5EGQH9tFUYqZTwjquwA3PU+o6OQepyQ==
X-Received: by 2002:a05:6000:156b:b0:347:2b42:a39c with SMTP id
 11-20020a056000156b00b003472b42a39cmr2955387wrz.29.1713552369828; 
 Fri, 19 Apr 2024 11:46:09 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 cs18-20020a056000089200b003437799a373sm5108718wrb.83.2024.04.19.11.46.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Apr 2024 11:46:09 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 0/3] target/arm: Make the counter frequency default 1GHz for
 new CPUs, machines
Date: Fri, 19 Apr 2024 19:46:05 +0100
Message-Id: <20240419184608.2675213-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x433.google.com
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

Patch 1 is Paolo's "add the new versioned machine types" patch that
he sent out last month; patch 2 is some preliminary cleanup so that
we set the default cntfrq value in exactly one place, and patch 3
is the mechanics to set the default appropriately for the two
back-compat scenarios.

thanks
-- PMM

Paolo Bonzini (1):
  hw: Add compat machines for 9.1

Peter Maydell (2):
  target/arm: Refactor default generic timer frequency handling
  target/arm: Default to 1GHz cntfrq for 'max' and new CPUs

 include/hw/boards.h        |  3 +++
 include/hw/i386/pc.h       |  3 +++
 target/arm/cpu.h           | 11 +++++++++
 target/arm/internals.h     | 15 +++++++++---
 hw/arm/virt.c              | 11 +++++++--
 hw/core/machine.c          |  5 ++++
 hw/i386/pc.c               |  3 +++
 hw/i386/pc_piix.c          | 17 +++++++++++---
 hw/i386/pc_q35.c           | 14 ++++++++++--
 hw/m68k/virt.c             | 11 +++++++--
 hw/ppc/spapr.c             | 17 +++++++++++---
 hw/s390x/s390-virtio-ccw.c | 14 +++++++++++-
 target/arm/cpu.c           | 47 ++++++++++++++++++++++++++------------
 target/arm/cpu64.c         |  2 ++
 target/arm/helper.c        | 16 ++++++-------
 target/arm/tcg/cpu32.c     |  4 ++++
 target/arm/tcg/cpu64.c     | 18 +++++++++++++++
 17 files changed, 173 insertions(+), 38 deletions(-)

-- 
2.34.1


