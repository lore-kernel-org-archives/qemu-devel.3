Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A7A5C3601E
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Apr 2025 21:01:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2z0q-0005wd-Td; Thu, 10 Apr 2025 17:00:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u2z0o-0005vb-OO
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 17:00:38 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u2z0m-0001kz-TC
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 17:00:38 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-22423adf751so13311145ad.2
 for <qemu-devel@nongnu.org>; Thu, 10 Apr 2025 14:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744318835; x=1744923635; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Crgd4oJW950tiGNM6qh+Yr/oflVQVrvIxSMd9pKsNKo=;
 b=KlB01A7MovZs2WFLoy6a/iqh6MjgM3imb/YFXvhL6fYLrx4Be7zVDhBglVrUCzWLH0
 75kX/hUP9vGFxLHs49NY5KNylkFxRW0iLx9puYjjxMFLX4/bkUzqCs3W2FGWFxqF/po0
 aIArRGqm8mA+Lm0LR5h7gRCgbFwj4386tGbmqrfCuU0qhsZ6C+t8Lr1hMQuKsHf6rrNG
 qH+zjAnw+GnZGlM0ErJVWr9/FSOBp6lY+MsValUJpH063dDbeAOkPVxfYIA6qYr2saW4
 MPwIHy3tSWNRJp2NhTSseWr7Ldh/MgeHnQvsPDvbz0vBPhCcLO+M0unAl5uLeLNkLQuq
 2/dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744318835; x=1744923635;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Crgd4oJW950tiGNM6qh+Yr/oflVQVrvIxSMd9pKsNKo=;
 b=bR0mRj+mqbM+Ere42LVpyEinjinhaUjRpq1Xre/qkTJTaSfJL2teoLNVl6/Gc678di
 oHvUkg+FSNbEVKl1rBRaQnkcdmxp4PuIR9JMMaQ3NFXEmsko9kXmy7xGb86vQZEQWNb+
 HvA3oMh1c+rRcBHJ0q4gOyxqUIe+fSHKR18vo6XO6NLSrX9glR1BY0kPjq6MFmon7sfw
 61D+YmyN59sViy+SaBDifHISASyDap7eRwIdI3OQhMczWI7PPTu6qCAsE7IwfI4okik8
 4Trd5R3ZDgYNyU35dno88+MvZPHZOjkdA19U/MS5fnmKi1vLVFock3+qS9A9lVE800cY
 YKmw==
X-Gm-Message-State: AOJu0YwMOM6Ou8I1l1fWoFQJQmJ37rmEEZ2y4kre86LyrNhijarIUaxt
 q3Oj8G+Osz0KMBrbXYhLurR1Guz7EtiTXfXnn6azvo6AJr4UBDwp6gVoIstkMOQjhyyEW8UBvCn
 9
X-Gm-Gg: ASbGncu1HwyJwugPnlS4pPMN9NJq+dICZxVT+THXZaSA/XTBLS3/YIm/UkG8lCle2Vx
 4czgaFq0sZk6iUaqMpCTTKsHzuJUUm7spQPwzjwcHBuss9XMrLbJUPwhlDlRnb1TXj0YUeSi2Xp
 1n/7f88ONNaroVZ66rgQy5IaXkMrRyNB3y/I9/qlNsro3vPBSSPwM0x1PPQX2tp3+lRpxh3I6C0
 aCbrYwwT7wxt5e6d7zvL98yXGfly2EOFZahrHWc9e1u6P36yF9dt7TpBGdDz+MLxgIXT8VIVBdl
 3ahDi2vQyEfn2dI/h2ErtMEYEClg8u3KoSkDesQN
X-Google-Smtp-Source: AGHT+IHimRX9HA5HKHfBTzf3Kyyl80jp2tp137GOOhu4Q2Osxefxa80FYYbOjVJ346zWo8FY1vD98g==
X-Received: by 2002:a17:902:e84e:b0:223:5c77:7ef1 with SMTP id
 d9443c01a7336-22bea4abb22mr2916755ad.21.1744318835308; 
 Thu, 10 Apr 2025 14:00:35 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd22f82a3sm12431b3a.90.2025.04.10.14.00.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Apr 2025 14:00:34 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, philmd@linaro.org,
 alex.bennee@linaro.org, qemu-arm@nongnu.org,
 Yannis Bolliger <yannis.bolliger@protonmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 0/4] target/arm: fix arm_cpu_get_phys_page_attrs_debug
Date: Thu, 10 Apr 2025 14:00:18 -0700
Message-Id: <20250410210022.809905-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x634.google.com
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

It was reported that QEMU monitor command gva2gpa was reporting unmapped
memory for a valid access (qemu-system-aarch64), during a copy from
kernel to user space (__arch_copy_to_user symbol in Linux) [1].
This was affecting cpu_memory_rw_debug also, which
is used in numerous places in our codebase. After investigating, the
problem was specific to arm_cpu_get_phys_page_attrs_debug.

[1] https://lists.nongnu.org/archive/html/qemu-discuss/2025-04/msg00013.html

When performing user access from a privileged space, we need to do a
second lookup for user mmu idx, following what get_a64_user_mem_index is
doing at translation time.

This series first extract some functions, and then perform the second lookup
expected using extracted functions.

Besides running all QEMU tests, it was explicitely checked that during a linux
boot sequence, accesses now report a valid physical address inconditionnally
using this (non sent) patch:

--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -997,9 +997,7 @@ static inline void tlb_set_compare(CPUTLBEntryFull *full, CPUTLBEntry *ent,
     if (enable) {
         address |= flags & TLB_FLAGS_MASK;
         flags &= TLB_SLOW_FLAGS_MASK;
-        if (flags) {
             address |= TLB_FORCE_SLOW;
-        }
     } else {
         address = -1;
         flags = 0;
@@ -1658,6 +1656,10 @@ static bool mmu_lookup1(CPUState *cpu, MMULookupPageData *data, MemOp memop,
         tlb_addr = tlb_read_idx(entry, access_type) & ~TLB_INVALID_MASK;
     }

+    vaddr page = addr & TARGET_PAGE_MASK;
+    hwaddr physaddr = cpu_get_phys_page_debug(cpu, page);
+    g_assert(physaddr != -1);
+
     full = &cpu->neg.tlb.d[mmu_idx].fulltlb[index];
     flags = tlb_addr & (TLB_FLAGS_MASK & ~TLB_FORCE_SLOW);
     flags |= full->slow_flags[access_type];

Pierrick Bouvier (4):
  target/arm/ptw: extract arm_mmu_idx_to_security_space
  target/arm/ptw: get current security_space for current mmu_idx
  target/arm/ptw: extract arm_cpu_get_phys_page
  target/arm/ptw: fix arm_cpu_get_phys_page_attrs_debug

 target/arm/ptw.c | 65 +++++++++++++++++++++++++++++++++++-------------
 1 file changed, 48 insertions(+), 17 deletions(-)

-- 
2.39.5


