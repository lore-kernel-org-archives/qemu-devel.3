Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4781F606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 12:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=TatQf6bS
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJ8wk-0008Rv-3Z; Tue, 20 Oct 2026 08:28:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xJ8wh-0008RM-O5
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 08:27:59 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xJ8wg-0004Ma-0Z
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 08:27:59 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-48df4e9d2d4so2033291f8f.3
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 05:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792499276; x=1793104076; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=xI7QYaEmFLnNKw2UXjcmJK0MgtYM7cQqcWx20imqHgA=;
 b=TatQf6bSSv/9wNy5OBrsTWk83LhWYEhkhS+YkBtcAVZGRQxTGV7K1QSx0AXyg+bkNH
 SEMmVIzoEcylNdJasAmsCc/ZVUTkIOklVfQzvZIWIaqTPo7Za6K2+dIOAEdOD9atdMD6
 ZR1uRckAFeddALVyNRFnpA4+c4C73kR+7Z0I5ZVv4IcIt3ivn6rasrYegJXPpwpjvI68
 cSYA2Fgp06jYDqGi5Rva+mNvv2HWHXOHDq39yhXls1enktdLNrj8Cy7NNrxmqn4PxDHS
 wYCF1zN46eAdTr53V4mqGMaaOt9XHgBFnlAxaHdR3YL3x8TUveI+yDZRx5f3AbQERAf0
 ufIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792499276; x=1793104076;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xI7QYaEmFLnNKw2UXjcmJK0MgtYM7cQqcWx20imqHgA=;
 b=xMMs6Dtf9E6U58Rq+xfroEXuBvs1n/FRXL8wksXBNbhx7A1tfAsawW3eCzbp/OwXWO
 vRQiRaaEckIzL/a4vAjAYepDrILVNjC1DLJ+vhvOYZ7QBwuhqXqCm3iFJH6Wc3CF8KD1
 a38pgtmQJ8Fc35NWIg5+rEskYhJNBnHVuQmHhN+uSmqI811+597kdAJ/xZ/uv9rtbh6O
 N+I29yUTiCNTZe+AZSHgrp3+UvIfM9dlgvwLw2HO7uaCyLbIbw0ELqdZpQyAKiUGdiEX
 yQZcBgCYcjdCcN8FdzBo1VVCqKPFLJicjY2D1dTdaWExiasJcEsHqnv5fP7jTDMrayzB
 XXeQ==
X-Gm-Message-State: AFq9FYI3rgMpPrVVqf44ysEX4jDM7AAKKXy7N39FvUiFqnqwk8z3ajrU
 wy4GTLNydGtXSljwtfLYOfQG0HzXnW6qRLnPGunzdp6AMSZw6jZKCz8dv55XPrqlRTcDDr3B9HI
 vyQSQSJo=
X-Gm-Gg: AYBFou06kx4YQoppNEfBiULJmreAlSQa0rmCrCMiblAo4aVx78955P5H13Ealmi5YlF
 hkj4I+tadHwreCMiW1bg5elEOaeN5+lRZmChW3W16vOD2W8Rky0gwY7Ewvd//rvo9GlJEUnvzAF
 elx3fQy5LnZmc/ptonFxmgnUwKl1zt4kjtWEgLTxVzebs9joZvhlgU/P2STowwvOF+zYa/MTFvC
 /pG3N48Db7mYunKL1MFvXxdbp0r3KmFVmlUG9odEZkO0cIiayVzEfZv0nqOwIbLeJH74HRtwtgj
 TI2oJkYfy6vh+K2+4cu7RRKSqDiIARGpuBxf5Rq1anRd5wc9e1UNMV5AUk9UrO4MiwBX3YAacR1
 7z3E87X/reMiNNXiPDIKuvL/IprBHTxRikeByj2/3aKnThsoMkMazKKAPBPGKWN5Pij61YjhWHN
 /qxGU/H/wOSC2beHSN+oul2TfK3sZRU9LwyDpwVsnJF3c9L4TfMW04PL8y9Orkp3628RIynDoQX
 6sYXfjukec6UkFZ1NcbPFOw5xD2Iheu6Pu2cqODtuSrw+ytSUBp5XgbEEAr2T8mW1VNRPV8+NTr
 1Lg=
X-Received: by 2002:a05:600c:b86:b0:4a0:1c43:3c04 with SMTP id
 5b1f17b1804b1-4a1d75f8b7cmr211294455e9.13.1792499275948; 
 Tue, 20 Oct 2026 05:27:55 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1f2cd482bsm68899315e9.12.2026.10.20.05.27.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 05:27:54 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Michael Rolnik <mrolnik@gmail.com>, Stafford Horne <shorne@gmail.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>
Subject: [PATCH 0/5] alpha, avr, or1k, rx,
 tricore: Convert to translate_for_debug
Date: Tue, 20 Oct 2026 13:27:47 +0100
Message-ID: <20261020122752.3651914-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Earlier this year I did some work on the API that target CPUs use to
provide "translate this virtual address to physical for a debug
access". We now have a new method, translate_for_debug, but still
support the old get_phys_addr_debug method as well.

This series does a bit of cleanup by converting five target
architectures from the legacy method to the new one. Conversion
is straightforward.

I have opted to follow the riscv translate_for_debug implementation in
having the returned attrs set .debug and not also .unspecified (via
MEMTXATTRS_UNSPECIFIED or otherwise), since on a per-architecture
basis we can see that we don't want to set any of the other attributes
in MemTxAttrs. This is a minor behaviour change from using the
fallback codepath in cpu_translate_for_debug(), which starts with
MEMTXATTRS_UNSPECIFIED and adds .debug, since it can't know whether
the target architecture makes use of the various attribute fields.
The only thing that we use the .unspecified field for is that the
IOMMUs check it to see if they can look at attrs.requester_id etc, and
debug accesses aren't going to be going through an IOMMU anyway, so
this isn't a behaviour change in practice.

(There are another 10 archs still to convert, but I figured I'd just
start with these five and see if there were review comments before
doing the rest of them.)

thanks
--PMM

Peter Maydell (5):
  target/alpha: Convert to translate_for_debug
  target/avr: Convert to translate_for_debug
  target/or1k: Convert to translate_for_debug
  target/rx: Convert to translate_for_debug
  target/tricore: Convert to translate_for_debug

 target/alpha/cpu.h      |  3 ++-
 target/avr/cpu.h        |  3 ++-
 target/or1k/cpu.h       |  3 ++-
 target/rx/cpu.h         |  3 ++-
 target/tricore/cpu.h    |  3 ++-
 target/alpha/cpu.c      |  2 +-
 target/alpha/helper.c   | 15 +++++++++++++--
 target/avr/cpu.c        |  2 +-
 target/avr/helper.c     | 11 +++++++++--
 target/or1k/cpu.c       |  2 +-
 target/or1k/mmu.c       | 21 ++++++++++++++++-----
 target/rx/cpu.c         |  2 +-
 target/rx/helper.c      | 10 ++++++++--
 target/tricore/cpu.c    |  2 +-
 target/tricore/helper.c | 13 ++++++++++---
 15 files changed, 71 insertions(+), 24 deletions(-)

-- 
2.43.0


