Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9F2BC3DA41
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 03:31:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRO0M-0008Om-LM; Tue, 09 Jul 2024 23:28:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sRO0G-0008BN-Ra
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 23:28:24 -0400
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sRO0A-0003gU-Vp
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 23:28:24 -0400
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-704473c0698so390856a34.3
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2024 20:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720582096; x=1721186896; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Jw2xHSdX8g/vw1Uzi7zPGtzp+K/GoiaBqk6O2xkkOJQ=;
 b=EcwVgpfnF5JGd0ngl9mrK3Qgk3lXpx9tIy4MaK+5xxb3o5M1vaWDsfG1EU8GZvTp+P
 FJlgGhTpEJb+uJz2ExMA/7bguLA/vUWUc2SLr3SM0yUDuxNZajsOiSbYO8uxnZnjLA06
 iIBMzQztMfohIjUiEVIYgvZfbv+vQSZ93nlnwIoAz8UubctLZOsqRh24uD8F02a/NVQT
 jakL/2mabOlB5aMmI4W8cvue158iy8d4OGJAqdXiJisIhhvI5EOhIFk8fYaKhDd4D6d9
 BqGMPtK/pUmvTrHhY6efnYwn+RON8zwsohCRX27eHHbjMA9GEKHSugTa+RweqOLGUEnz
 Tuzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720582096; x=1721186896;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Jw2xHSdX8g/vw1Uzi7zPGtzp+K/GoiaBqk6O2xkkOJQ=;
 b=rs1SR9pgOQZnJDwyYvxD27iYhCaqkQCimEX817eEC8ZO+YY9CMHewzKgzfqvSwjk0w
 B5kV5ZxnxZXEJzrHW8QErSVsxximn0cHSCH6VUHq5CG1BdNepJdN6W++kthoLonrgwKh
 kOQXQlZVolDd+vyulpgADFYzCuUhfw3Yv5uYO61Ieq3UWxz8pB1dJlvaE/PrH0us4HIu
 PVSJmOJbnHu36fr+f58eluO1HM2v/hArI7qeBlP7YPPpeHuTKSbkXldXS/xAGyPXv6rp
 Ocw1kS8zep6kMlvkFcugcXagXh0RAed6xMJm/0KsyZh2CbtrNqOeKr1moyaqy+Ym/Vqa
 W+MQ==
X-Gm-Message-State: AOJu0Yz3wRimNp+TGzKUEHpbvvvV2Ph2yPTSwtXeJtmDu6sfY0HNdW5b
 etCT0YacbJ+UyUElJp7dP84sCvpo+MMI9+6DjDMtUMKKNk8vtwwIIRMUbdmLXHac4UAtiyt776v
 FZTo=
X-Google-Smtp-Source: AGHT+IE9/zuPBY1pwUrfybYe6eD8MPrGf9/ESBHr5i/GvDjQcLtYMO0f0cYzPXNQoRzsaCr/b78xog==
X-Received: by 2002:a05:6830:1b73:b0:703:5ba3:5806 with SMTP id
 46e09a7af769-70375a131d8mr4441182a34.22.1720582096380; 
 Tue, 09 Jul 2024 20:28:16 -0700 (PDT)
Received: from stoup.. (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70b438f5679sm2687280b3a.90.2024.07.09.20.28.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jul 2024 20:28:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongu.org, qemu-s390x@nongnu.org,
 qemu-riscv@nongnu.org, balaton@eik.bme.hu, max.chou@sifive.com
Subject: [PATCH v2 00/13] Fixes for user-only munmap races
Date: Tue,  9 Jul 2024 20:28:01 -0700
Message-ID: <20240710032814.104643-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::333;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x333.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51 autolearn=no autolearn_force=no
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

Supercedes: 20240702234155.2106399-1-richard.henderson@linaro.org
("[PATCH 0/2] target/arm: Fix unwind from dc zva and FEAT_MOPS")
Supercedes: 20240702234659.2106870-1-richard.henderson@linaro.org
("[PATCH 0/4] target/ppc: Cleanups for dcbz")

After looking at the first dc zva patch set again, I can see no
difference between the memset used by dc dva and the plain memory
accesses used by SVE and SME.  In all cases it's a host memory
access that might fault even after probe_access, due to a race.

So I've dropped memset_ra and memmove_ra, and instead expose the
basic set/clear_helper_retaddr interface.  This allows one set/clear
to cover entire loops, instead of trebling the overhead of each
individual access.

I've included the ppc dcbz cleanups, so that the final improvement
applies cleanly.

I've updated s390x, though it isn't as clean as I would like.

I've tidied the riscv use of tlb_vaddr_to_host, which Peter noticed.
The usage was incorrect in general.  There is no race condition
here because it still uses cpu_ld*_data_ra in the end and not a
bare host memory access.  But the ongoing work to improve riscv
vector memory instructions should take note.


r~


BALATON Zoltan (1):
  target/ppc/mem_helper.c: Remove a conditional from dcbz_common()

Richard Henderson (12):
  accel/tcg: Move {set,clear}_helper_retaddr to cpu_ldst.h
  target/arm: Use cpu_env in cpu_untagged_addr
  target/arm: Use set/clear_helper_retaddr in helper-a64.c
  target/arm: Use set/clear_helper_retaddr in SVE and SME helpers
  target/ppc: Hoist dcbz_size out of dcbz_common
  target/ppc: Split out helper_dbczl for 970
  target/ppc: Merge helper_{dcbz,dcbzep}
  target/ppc: Improve helper_dcbz for user-only
  target/s390x: Use user_or_likely in do_access_memset
  target/s390x: Use user_or_likely in access_memmove
  target/s390x: Use set/clear_helper_retaddr in mem_helper.c
  target/riscv: Simplify probing in vext_ldff

 accel/tcg/user-retaddr.h      |  28 ---------
 include/exec/cpu_ldst.h       |  34 +++++++++++
 target/arm/cpu.h              |   4 +-
 target/ppc/helper.h           |   6 +-
 accel/tcg/cpu-exec.c          |   3 -
 accel/tcg/user-exec.c         |   1 -
 target/arm/tcg/helper-a64.c   |  14 ++++-
 target/arm/tcg/sme_helper.c   |  16 ++++++
 target/arm/tcg/sve_helper.c   |  26 +++++++++
 target/ppc/mem_helper.c       |  51 +++++++++--------
 target/ppc/translate.c        |  24 ++++----
 target/riscv/vector_helper.c  |  34 +++++------
 target/s390x/tcg/mem_helper.c | 103 +++++++++++++++++++++-------------
 13 files changed, 219 insertions(+), 125 deletions(-)
 delete mode 100644 accel/tcg/user-retaddr.h

-- 
2.43.0


