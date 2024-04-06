Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D36C9CD1292
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Apr 2024 22:34:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtEan-0003LZ-VS; Sat, 06 Apr 2024 18:32:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rtEam-0003LI-69
 for qemu-devel@nongnu.org; Sat, 06 Apr 2024 18:32:56 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rtEak-0006fD-As
 for qemu-devel@nongnu.org; Sat, 06 Apr 2024 18:32:55 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2a2d248a2e1so2081586a91.0
 for <qemu-devel@nongnu.org>; Sat, 06 Apr 2024 15:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712442772; x=1713047572; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=36ZaUeVzVuWegwno9pEm8v7DMzHgHRm99UuSw/pVQC0=;
 b=bxK+kRaphMMIQW1t+pMtKJjKDW4F4Q8c7Kq2YN4nHv35SQZQ+4vpamRmLaoC9BPjXq
 CLzi4/h0/KI8diaWyHqzSLIaZs8EvXNAjM7uSeiMPurlGw5cJCAbv7SujfYMZiLbSX/S
 avDscMOuGvbL6TUcDDwXqdho1ZFrnF3SNSGL6BGXrrvFOGiY9dIuRoYdsf/1bRY1Ug+j
 MvcJO/ojESHcZKIZPLJ2yygXfx1dThYOCEqW9AUxgNJ0QTb36tx08dAMHSY7pujy6+dl
 xqwCPAjJMOsyKgDMnhLAH8ozp+lYqd5L4s96EWBaJqv338BvPDxxA2Hjs20+7Z4IIwBh
 9PkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712442772; x=1713047572;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=36ZaUeVzVuWegwno9pEm8v7DMzHgHRm99UuSw/pVQC0=;
 b=hSluVJIaZVHAUBXauGQsWQKO0tJYAxrTOtnZUjGFo6idVwNHuJo9u3E38WQjYtZRMO
 PZZLH6INp3jwazfSFFEk+u3bLZ4VZODohGiV+UXbmceIiEz1Urh8Llch3Zte/M6vssLR
 vj12QsNas8hZJq6wovdm008ijM9o3HjlZZrMTeCmQfc2/2DgSFTJcTURozOHAKaN6tpU
 HpN30mIwd0ICmYyBO7zfwr4SrDpJn8hQ5WKS3hSfFU+PczljGo5B0N3v3FhBAIm7tQM1
 Q2xJPP2dGEVxtg4kmr3LI8/Y9oTDriXdM2EzlC0UZMzGRMv8g/BnsNaYjRxFsq6BFRNL
 FwZQ==
X-Gm-Message-State: AOJu0Yzs1HJyzCnQAPvBkzxdf+it/aywYuK9Fbuj9sa+n0bmqi3ZyETW
 NQi70evNFG3sdLpTsK9GGl8YA2NB80hJlvQIU1FF6v9aK9Fz8pfq4EGE23jMXCJvs8fmT/gh+Vw
 F
X-Google-Smtp-Source: AGHT+IHSLaVBjHa45krFIMqCaQ2KOlRgRmkEJyMSJTwP7R/UFHHN+VgqD0DlRzE5sDPE6Hy6GHWEtw==
X-Received: by 2002:a17:90b:1b04:b0:2a0:4a82:5b05 with SMTP id
 nu4-20020a17090b1b0400b002a04a825b05mr8585132pjb.19.1712442772255; 
 Sat, 06 Apr 2024 15:32:52 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 f23-20020a17090ace1700b002a20c0dcebbsm3643279pju.31.2024.04.06.15.32.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Apr 2024 15:32:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Jorgen.Hansen@wdc.com,
 Jonathan.Cameron@huawei.com, linux-cxl@vger.kernel.org
Subject: [PATCH for-9.0? 0/9] accel/tcg: Fix can_do_io vs 2nd page mmio
Date: Sat,  6 Apr 2024 12:32:39 -1000
Message-Id: <20240406223248.502699-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
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

Bug report is
https://lore.kernel.org/qemu-devel/33748BB7-E617-4661-BDE3-5D29780FC9FF@wdc.com

Jørgen properly identified the problem, though calling set_can_do_io
in the middle of translator_access is incorrect.

It forced me to do something that's been in the back of my mind for
a while and track the insns being emitted so that we can go back and
insert the proper store to can_do_io after code for the final insn
has been emitted.

If we decide to take this for 9.0, most of the target changes could
technically be left for 9.1.  With the exception of i386 and its funky
case of "pretend we never started translating the current insn".
But I think the target changes are minor enough to take them anyway.


r~


Richard Henderson (9):
  tcg: Add TCGContext.emit_before_op
  accel/tcg: Add insn_start to DisasContextBase
  target/arm: Use insn_start from DisasContextBase
  target/hppa: Use insn_start from DisasContextBase
  target/i386: Preserve DisasContextBase.insn_start across rewind
  target/microblaze: Use insn_start from DisasContextBase
  target/riscv: Use insn_start from DisasContextBase
  target/s390x: Use insn_start from DisasContextBase
  accel/tcg: Improve can_do_io management

 include/exec/translator.h      |  4 ++-
 include/tcg/tcg.h              |  6 +++++
 target/arm/tcg/translate.h     | 12 ++++-----
 accel/tcg/translator.c         | 47 ++++++++++++++++++----------------
 target/arm/tcg/translate-a64.c |  2 +-
 target/arm/tcg/translate.c     |  2 +-
 target/hppa/translate.c        | 10 ++++----
 target/i386/tcg/translate.c    |  3 +++
 target/microblaze/translate.c  |  8 ++----
 target/riscv/translate.c       | 11 ++++----
 target/s390x/tcg/translate.c   |  4 +--
 tcg/tcg.c                      | 14 ++++++++--
 12 files changed, 70 insertions(+), 53 deletions(-)

-- 
2.34.1


