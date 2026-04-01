Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4254FD3515C
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 09:50:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7sBy-0008BV-JV; Wed, 01 Apr 2026 05:48:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w7sBx-0008B0-Cc
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 05:48:53 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w7sBv-0000L8-IZ
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 05:48:53 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-488879b2e6aso2577275e9.1
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 02:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775036930; x=1775641730; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=Yb5zEViOUF1RCMDbVLGKMBiHX35KVVSylxNR2VsRzSc=;
 b=bY8pXIbJ7sYBm5r6IbEC1VKsQ/6aWMXK8UzjPQb0p4gGoC9xSRztys4PbaZ1MuI4Pp
 fbihMoY5pH/QlbNn/JkQpDw60SruYsqT9WOEaefXDnNzpy1uVH49WZfxlwUuRozxyTX3
 O4LhTtAo1UZd6AMFc9vDnbrV8zHkZpLNdnsKS3atlt+SRYIgr94rIaNJfyanNZy+m8wv
 nkgaaGsrPeghltxzdz1mAqoAmH4wF07NnxyQ2mhOJjM/646spqEQkk/r/ylBiXkZAzcZ
 44q+xGTatTtVnvtVYhrdz4o0rQhnSl/PxvEyV2fHtjZFmNU9NNijMThklqjwXragG7sM
 ljzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775036930; x=1775641730;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Yb5zEViOUF1RCMDbVLGKMBiHX35KVVSylxNR2VsRzSc=;
 b=CxpgGv8QOTmVtMsJ0cKvocfGt+XO0QfdWoDIg8h2bIohGQlRgLnKw6K01g/eANxjs0
 yMxJn1KkDBWwdmQ+i+j+fT2pRZ1ebAnod7vRdfEYnhkxDq3WQ8mkBW1JaN8f4ZRHQBQ2
 tsAalBhN/NnXEmn1Tuh13U6iE9SdKCMWsFbDeXTVZ947pFnLuEzezXH0S7znEXuZM/MK
 PWG1hrwiqTXqV23zECMB533HizRMcObU5dUesGo2J9xhk12BBgFksrWsAK+PfL2nzymk
 LDdtNqwJzwsUhhou7igxAVKuHCYBY42OK10BG4ds2xGqy77dyfgkVyoEW4mnQogTH54Z
 sFog==
X-Gm-Message-State: AOJu0Yy4HGuQmgPiyEErPnFODDv9U2ZEoDQ42zYCMrzRuLfIO77Z4vDu
 4SGkhmCmJ/24BhfWVmlPPs6JfQFMcExQjoY7pd3CvqwsxS7yS7W7Tk4MUhu/7i1Nao6qhMHoceg
 PMRHyGxA=
X-Gm-Gg: ATEYQzzEeSNdqIUMt5Z/GBTDXX3mpfQi/ix+WnNFrDbqYwn34ZMUxvAnKbY8EhASGdk
 AA/7xXtGqNazsoJG+YYyKYFBPbv28cSQFjATt/qSm/3mhddlHLjZZPhKJR128P/q88J7sjwtRtg
 MSpBydEEN4uqCMRp5wFamvvqaSf2kmq3Bm9VTrisIfQR20cckWSX2dkZS9A3sMEPuylx1u5OuRJ
 lEcLpljzxmH1m85boB6/PqPbvbMmDh/TjpcarzccJ+CQFUFBHtIL9ktJwGVCgSc+Me3pAUzzOAJ
 NDsxzeaP2RgnsuU4CeLb/OW4qbrSyVDdMPPI3pXxjTAfPdYxiGOnt3nXhSe9O8QzSNh+Prrf/9e
 y/3Advn20vepnXSFhhUn9ZZoO8G29wU2FoRSdzEhZ56CZcC80oEc2q6kdTGCrAcPaWOcgPvOASa
 IRX5FPdF4LsrD5tAK0lkJI7CKolcAd6mU2JcvV6oj/zSuibZuSBpbhdepnkv/dkx4xfg10lo2cb
 NuPZdj27/Zhsu1YKAyfJu/6rna0XAU=
X-Received: by 2002:a05:600c:19d0:b0:485:45fb:3472 with SMTP id
 5b1f17b1804b1-48883562172mr43873645e9.7.1775036929699; 
 Wed, 01 Apr 2026 02:48:49 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887eb5aff3sm146945685e9.15.2026.04.01.02.48.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 02:48:48 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 0/6] linux-user queue
Date: Wed,  1 Apr 2026 10:48:42 +0100
Message-ID: <20260401094848.2661985-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

This is a set of linux-user bugfixes that I pulled together
that seemed to me worth getting into rc2. This doesn't
represent any desire on my part to be a maintainer for
linux-user :-)

-- PMM

The following changes since commit 6aeb397debb1c253901bbade8816656c29b63003:

  Merge tag 'for-11.0-rc-pull-request' of https://gitlab.com/marcandre.lureau/qemu into staging (2026-03-31 13:41:29 +0100)

are available in the Git repository at:

  https://gitlab.com/pm215/qemu.git tags/pull-linux-user-20260401

for you to fetch changes up to 7e966ef38f58f91e05a46fdfda4ba63a9a1567d6:

  bsd-user, linux-user: signal: recursive signal delivery fix (2026-03-31 19:13:20 +0100)

----------------------------------------------------------------
linux-user:
 * don't incorrectly sign extend guest addresses from mlock etc
 * fix name_to_handle_at when AT_HANDLE_MNT_ID_UNIQUE flag is set
 * update select timeout writeback
 * make openat2() use -L for absolute paths
 * correctly handle SIGSEGV generated when trying to deliver
   a synchronous signal

----------------------------------------------------------------
Clayton Craft (1):
      linux-user: fix name_to_handle_at when AT_HANDLE_MNT_ID_UNIQUE flag is set

Nicholas Piggin (1):
      bsd-user, linux-user: signal: recursive signal delivery fix

Peter Maydell (2):
      include: Don't include guest-host.h in cpu-ldst.h
      include/user/guest-host.h: Provide g2h etc for both abi_ptr and vaddr

Sun Haoyu (2):
      linux-user: update select timeout writeback
      linux-user: Make openat2() use -L for absolute paths

 accel/tcg/user-exec.c        | 26 +++++++--------
 bsd-user/qemu.h              |  1 +
 bsd-user/signal.c            | 10 +++---
 include/accel/tcg/cpu-ldst.h |  4 ---
 include/user/guest-host.h    | 62 +++++++++++++++++++++++++++++++----
 linux-user/qemu.h            |  1 +
 linux-user/signal.c          |  9 ++++--
 linux-user/syscall.c         | 77 ++++++++++++++++++++++++++++++--------------
 linux-user/syscall_defs.h    |  7 +++-
 9 files changed, 141 insertions(+), 56 deletions(-)

