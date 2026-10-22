Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F3A606A334
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 12:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=BBuIIlNZ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJsOB-00017v-2A; Thu, 22 Oct 2026 08:59:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xJsNt-00013J-3I
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 08:59:08 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xJsNq-0007Jp-TJ
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 08:59:04 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4a1e266fca2so12918535e9.3
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 05:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792673940; x=1793278740; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=9J1Rnr8madLdUQh5uJqEdoChoGpByXeOKiumrl0b6ls=;
 b=BBuIIlNZc2UNERCpfd5J5BxT0mhaHk/pIC+4Qv3ObKmSM5/lp9Mh10VuwagmCLkbTQ
 iT5VUV4W0I93X845XWMvbs2iI7aV1oD7lT+yavvT7vA7wyeDV8ReXlzOOfy4ZkdxPDOG
 q3PVTUKG0aZpQrYa1immofLQWvwHdqnklFES1OSzi7Uy6tgAkZn57DEib8CVql3Bl5mk
 z4A98q30Lt9efHG1Mdn/rZkIAxeKyzu9rtMpHdsHD6ZNggnAsUD1Q9R8k2SQigvojdZW
 ZhQeyUVFYHzbgtJ51d6JjWnkj2iFTLlOmo7EQ/Q1colw91zBNCUCR+xMPuFpmKZ4I1SJ
 93sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792673940; x=1793278740;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9J1Rnr8madLdUQh5uJqEdoChoGpByXeOKiumrl0b6ls=;
 b=JVR3lWjWqcTJ58N040gra3chT35eZ1cgCWcR9ArXYvlFWQusZm2WqoZPUitL95jd/T
 gd9horz7mImC03t1GB9Js3PEeYoIchmoy0VRuty/nAia7662vrtoN9aHHU7VRypaTTJh
 GZz0/IU0M8dZiO3XDVDlgyhuuSMm3Vmq7qqnWv2Rufs52mEsgR1cQeQG30raUuydp9PM
 xwsjcV2y2/ohkkKC2qLgrICkrtejNaHHDH/uEFNn0cYTBG4TUFP4KAhVwgluzxer4mLn
 I6qhSXHHPNIMYgKXU2hatcFPhNyk3OGzbqcAi08mtYQjjkMxxt8EeXUFHVytpn81gfhj
 dJzg==
X-Gm-Message-State: AFq9FYKvbQ9dmJm8TgrarYQEN3N9bdnFKqEjl0oA4OEiVnaXJI63iZM/
 2Du+QNJ6NVd3DE6jFmelcjFv1NzsW7ew+SP5zHQKujv0VEayT8KzgPh2dO2gMoXUlZe2DlX0kfz
 4tFlJloA=
X-Gm-Gg: AYBFou1KOwo5K9vtMqvYQscQfoy4yFZasUoHSbrkHPdk0BsX1qBYWGf5eX0Ob0tED6H
 RYl5Y/Xg7lkRdNoMib2AK+aKmIJix3CtyEaCA6KcJLzPf53f7VvSqS/mayGR/owNrasdxdy78C4
 JsVSGRVs65Vp/Cr+whuHPGyXi7k4mP9zfGHYXlJrjRDEYmXYEFTkgdiOA0bIqiZTseFGFwapSWp
 NQUw28bevjYaieKg0oqcJEYXTiVuUMzcPpoJbDRfWJAYPpp03H9pTQ3VI3pAipmhP1Q0Hslo0uY
 7Q0RB7sGMs2Clq2D+eFCwQ9G7I3Ytbig4f8guqfjyjlO4nK4akSfDcJdqKuORcDxE+G1SNbfjS8
 ZHUuzCLZJ+8YoRvRuqRMTgW9VSTsoYk3nbecmffj+a/feHr23afVbCskXyfHGLt8mIZE6WmEHZU
 ZyZWa6kOz+Li6asv6kNDZxnYr7bQeSAJMcWZMu9z9EA2aQxyAb34PMlY0J70riFbXkJqU01ModW
 YcSp5R/WDcduO2Dspd4H2il78mI/wtToQgJ0WTxairLui9YD2j+KnlLzuPR1ASekQWtF8ZU5axO
 NrtnadVir/KDcjK2iH8k7nl4hT95399xFzXYqBloyqGRWpiZ2bPDX67fUHHJ
X-Received: by 2002:a05:600c:628d:b0:49e:6050:9fbe with SMTP id
 5b1f17b1804b1-4a1fdd170f5mr110194555e9.15.1792673940194; 
 Thu, 22 Oct 2026 05:59:00 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a203b439absm79247015e9.9.2026.10.22.05.58.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 05:58:59 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, Song Gao <17746591750@163.com>,
 Bibo Mao <maobibo@loongson.cn>, Xianglai Li <lixianglai@loongson.cn>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>
Subject: [PATCH 0/5] hexagon, hppa, loongarch, m68k,
 mips: Convert to translate_for_debug
Date: Thu, 22 Oct 2026 13:58:53 +0100
Message-ID: <20261022125858.310252-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_SBL=1.623 autolearn=no autolearn_force=no
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

This series does a bit of cleanup by converting another five target
architectures from the legacy method to the new one. Conversion
is straightforward, and matches the set I sent a few days ago
for some other architectures:
https://patchew.org/QEMU/20261020122752.3651914-1-peter.maydell@linaro.org/

thanks
-- PMM

Peter Maydell (5):
  target/hexagon: Convert to translate_for_debug
  target/hppa: Convert to translate_for_debug
  target/loongarch: Convert to translate_for_debug
  target/m68k: Convert to translate_for_debug
  target/mips: Convert to translate_for_debug

 target/hppa/cpu.h             |  3 ++-
 target/loongarch/cpu-mmu.h    |  3 ++-
 target/m68k/cpu.h             |  3 ++-
 target/mips/internal.h        |  3 ++-
 target/hexagon/cpu.c          | 15 +++++++++++----
 target/hppa/cpu.c             |  2 +-
 target/hppa/mem_helper.c      | 21 ++++++++++++++++-----
 target/loongarch/cpu.c        |  2 +-
 target/loongarch/cpu_helper.c | 12 +++++++++---
 target/m68k/cpu.c             |  2 +-
 target/m68k/helper.c          | 16 ++++++++++++----
 target/mips/cpu.c             |  2 +-
 target/mips/system/physaddr.c | 13 ++++++++++---
 13 files changed, 70 insertions(+), 27 deletions(-)

-- 
2.43.0

