Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 294C3FED9FE
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 17:52:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2YZ9-0006Hg-FY; Tue, 17 Mar 2026 13:50:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w2YYv-00063s-PL
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 13:50:39 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w2YYt-0007R5-Oz
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 13:50:37 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-48532925a4bso32258865e9.1
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 10:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773769834; x=1774374634; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=OHKiRihP6xzDVsYNkmy0rWSbvzrnBAR3sh6/MMsLTxM=;
 b=z68GJVrL3CBxhl1Gn3+hWSlLDj9Oe1beS5zqV0LcPziLVMXvKUMs1dmPN3+raLo4Zd
 lAXZiwtQbnFEfohY45R3kCrykUTcIqN8DrH51Pz5JzUr4TIv6qwBK5tRSc8kJ+hkMEcn
 SE9bfKbZHtFl9l7KnIW0+tUStNrDXJqmQQkw+pujAcx00ZC1z5jeJOmvild8KtLAbBZy
 t6zyHmw6i6iIKQN1K/Sfr0s1+jn0JB11ACy4HhW+YlM43hh6urvMfXRnNphQTORuhsbY
 GhZbTJCiFQbBT8oHTzDsxq7OqwwOsW3xyUSyj5aTXatjFDaLJ8lLgc9F2G7J161MhMRN
 dlqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773769834; x=1774374634;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OHKiRihP6xzDVsYNkmy0rWSbvzrnBAR3sh6/MMsLTxM=;
 b=MtEn0E/vCf3p3S57AU77Cmc96Mq8LDcbk0Mdlku25vIDKKRorzZvOGrhOPw7CtXaZf
 w80qq6wiGRZZFTdBGIZvcjFHlUJGSZ/4OT0PgoBPduaAAAeDVbvF5FBnHRzJZz2Ln1iU
 19KgSG6Rvs5jPWTAyAFOemRnjSugBXFM5RZGTWQ6YSg8+WU+PWmoG8Gjg/cF6K/8eqn7
 8/QFuW8+DVzW3nxLAbViTgMEco5zEmx/+9XGUcD7y9XXcOJmbAIGY6XAMku+e0ek8lty
 nTTR1bs2RZUIHUQF5FAQV5w3NQ5SFxgdSxrpb+QW5b7xOnASBOFj4Xj73Pud0U9hjEoK
 7WBA==
X-Gm-Message-State: AOJu0Yx0kyr7ru6sLJemLYze3ZB7DmrkksL5L3ZNnL+p+bCoFat3H3Dg
 b/Qu6SjcidxWE0ZuTGi9oLX4NOzdoav58N26Ykje2KOC/ygfqx/m1PGp5JTFGNB0UdGOKne9VNJ
 fjKb+
X-Gm-Gg: ATEYQzzMwGPRquQDgSF+srBbzxgLQSzdm7uqyiZcGq/pzYF9s+tZ/pVI9rooUZg3JZ8
 oaNNGlAQ3VAKp3OJDEA892WDmuGIv8ZL42LsIX0k348lD1LGIYcPROvq1Z0glfoEucq2M+y8pTa
 o3ua0KVAzxYnv78aC0nBSGfpzZwHxD/KPOc7EZb9ekgeZTcLUnhdL+nHExznkE6yOSI4nyHTcdd
 0fNnt2eNHCTb0xY4C3rEPU1KHGn0ZPHJDzro7FMSjDnD7/vAVSpd+c0FPsEuZrUEuOqa3U+u/VO
 fkuK599FaaFqzbe8j58Y5xhAShe4C3LutML9gsfqn1W0G2p4jcWurKGooLmJKLJWaQhTiFXF576
 CLK8xDBnpg88uBb5eeTinXkHXZfwz4AaB7DTWFq83TKEg6Lqq15dO79aOlmOCE06jB4JT9NhHTr
 XJ3Aw52Elwtnr7o1+pmpmQ1GBn2UO9R1l/LxKkbFP1DE1HoB0q8Jtm4eGkrvSqpqG4xS8Edz05o
 lg3BT8fLLiKr6+2A4jz2z8Rodp6bmo=
X-Received: by 2002:a05:600c:c491:b0:485:2fc5:39e with SMTP id
 5b1f17b1804b1-486f44635e2mr7742185e9.27.1773769833421; 
 Tue, 17 Mar 2026 10:50:33 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48557c7220dsm118786995e9.30.2026.03.17.10.50.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 10:50:31 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>
Subject: [PATCH 0/3] target/mips: Move non-shallow-copy fields out of env to
 fix leaks
Date: Tue, 17 Mar 2026 17:50:27 +0000
Message-ID: <20260317175031.3035740-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

At the moment the linux-user cpu_copy() implementation assumes that it
can clone a CPU object for a new guest thread by first creating and
resetting a fresh CPU object and then doing a shallow copy with
memcpy() of the CPU's env struct.  This is obviously a very dubious
assumption, but for the most part it works.

One place where it doesn't currently work is MIPS, where we have a few
pointer fields at the end of the CPU struct.  Currently we don't ever
try to free the objects we point to when the CPU is destroyed, so this
is a leak but not incorrect behaviour. However, we can't fix the leak
by freeing memory in CPU unrealize, because then we would get a
double-free because both old and new thread point to the same memory.

In the long term we should really reimplement cpu_copy by having CPU
objects have a method for doing this, rather than accumulating
architecture-specific hacks. But since in practice I only see leaks in
'make check-tcg' for MIPS, this series takes the simpler approach of
moving the fields of CPUMIPSState that cannot be shallow-copied and
that are used in user-only mode out to the MIPSCPU struct.  There are
only two to move: mvp_init and count_clock.

The remaining pointer fields in CPUMIPSState are:
 * several fields inside the !defined(CONFIG_USER_ONLY) block
 * cpu_model, which is always equal to MIPSCPUClass::cpu_def
   and so can be shallow-copied
 * timer, which is only set in system-emulation and is
   NULL in user-only mode

This patchset does the two moves of fields out of the env
struct, and adds an unrealize method where we can free the
mvp struct that we would otherwise leak.

thanks
-- PMM

Peter Maydell (3):
  target/mips: Move 'mvp' field from CPUMIPSState to MIPSCPU
  target/mips: Free mvp in unrealize
  target/mips: Move count_clock to MIPSCPU struct

 hw/mips/malta.c                     |  4 ++--
 target/mips/cpu-defs.c.inc          | 10 +++++----
 target/mips/cpu.c                   | 18 ++++++++++++---
 target/mips/cpu.h                   |  6 +++--
 target/mips/internal.h              |  3 ++-
 target/mips/system/cp0_timer.c      | 12 ++++++----
 target/mips/system/machine.c        |  2 +-
 target/mips/tcg/system/cp0_helper.c | 35 ++++++++++++++++++-----------
 target/mips/tcg/translate.c         |  6 +++--
 9 files changed, 64 insertions(+), 32 deletions(-)

-- 
2.43.0


