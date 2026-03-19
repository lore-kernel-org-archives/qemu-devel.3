Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2645109190B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 18:52:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3ITb-0003I2-Hy; Thu, 19 Mar 2026 14:52:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3ITZ-0003EJ-VA
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 14:52:09 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3ITY-0000yt-JA
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 14:52:09 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-439b94a19fdso1069587f8f.0
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2026 11:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773946327; x=1774551127; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0KLWHS8OvaRT49d+DXeB6vwyiOk2EHjCXel8JeIPGTI=;
 b=BGdeGMfNLa03eYx/NghaIw6waSXLiAn950weRzTX0wTlCHJ3YVRuWFpgSHTvaYE+XS
 v4e7KyXacV2NrqPA/ucMvsZnuo1UtC1RH/N2pKPmeN379yAkIgDVnoy5+cRD3oOmiDxP
 4qCAORqn6oAccewIz8ymzz7PDzqcMd/OyAYBlDDopmeNN7RhUswvWNLyzPP8a51uj9Vi
 Ug/IGvoD9orI1oTUypcT1HMsuQcFT6RiwGW43oDxYzLo2p5RK8ejLEm2m3+8EO/B98Ff
 Ti9+5Vguh4kOzU2jJWTlQlTC11dM3DRNRq7q4/hlW3or+BuTuDvZz71o+4F2UsUmz9lH
 R1Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773946327; x=1774551127;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0KLWHS8OvaRT49d+DXeB6vwyiOk2EHjCXel8JeIPGTI=;
 b=pwHOFFsuMRYOczgLhWN8mGwK/kvwa+Lf5qVHe/BKjP8rTkl6nbyRexBl7Z1EuJsMqg
 Cnyd2hb9Yd0zRi+tX7MnFz0tMep0S581ZM8AQPPDjSlmtfKEypcvvLF2RhFgvbDY/slT
 pwNTfk2E4+aU2p7ZF0sJCP0LxYf+328QKt6B2GTraUSfrOXPtG9TOD/r7M6AKlO6cl56
 u8iz/Yvuw97CkRwYfl+cqAJH7H/LG2nMLsYnoJedRfQgv+NJ9hGZTYTHtBUQjNx84SDX
 u8mSDQd5f6Eg1L3IwWUwv+vqbYCl7TpfL+DT8o+G+NZIeMAh7PlDPYcKvhNpyWnBcIZ9
 AjYA==
X-Gm-Message-State: AOJu0YwJQ31TRJAN3j8ZzyCp+Zc+11qLe3aTZedbou4TmdbKOkEkJH91
 2Xs+QL5g6Ryr/nE/bZduM77ET9Al9i1J4Dq4HqQIismb2EavxyRiK0x2IYoZHZQbdR7gR0wVnsv
 ihJdCtrY=
X-Gm-Gg: ATEYQzx6HDMq+EY4yXJE2cPEi5r7BFIuc+Zdo/HZZWl9DOpwyC/7ssH9KVTJOh2UNxN
 tEc9L9f68pM4vX5m+OOc+PvguchvLvTzfX2dNQliRtM75I9sbiiZQDSfhlO+kUyEkpXAX8aic8J
 NObVcmBzq2EMAmyUfr3zn/efbu56mSbRYALXlynzCr2+jY8mlYF3hIRFsmOYuW+F7UWWwCHazJ8
 8enKX4asm4A1a/i2/XUnp9Sb1y5AS1ZdxpKRppuA2UsBjr7B6UTPq1NFMbVJiDTGCJw/cgm7SHc
 v8DpH45F5fkhsvVAGsZ+sbtw4wZ9claCPhuAs5xV8WzTwrn+JO8lVzqQfQqiMUgcw1r4656ye6h
 QG462o6f+ZedfzSkN726lgXh6/hs58+73GOlf28ADKI+iLE5YPjknxxOpeJ9ghD60iROCUA8aXZ
 EhNV8mPTkuRGiXJ2Yf3hjUOb9GzZYitiYM/2SrP7FIC/WOafOVEVDI9FIvLKb8+gMuu7jZI5yUo
 KahsbjSyqA=
X-Received: by 2002:a05:6000:2010:b0:43b:4ec7:f924 with SMTP id
 ffacd0b85a97d-43b64264073mr749721f8f.34.1773946326640; 
 Thu, 19 Mar 2026 11:52:06 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b6470c239sm514629f8f.27.2026.03.19.11.52.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Mar 2026 11:52:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Anton Johansson <anjo@rev.ng>,
 Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, qemu-s390x@nongnu.org,
 David Hildenbrand <david@kernel.org>, Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/5] target/s390x: Forbid to use legacy ldst_phys() API
Date: Thu, 19 Mar 2026 19:51:58 +0100
Message-ID: <20260319185203.11799-1-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

Replace legacy ld/st_phys() by address_space_ld/st()
then lock the target again further legacy API uses.

Philippe Mathieu-Daudé (5):
  target/s390x: Replace legacy ld/st_phys -> address_space_ld/st (cpu)
  target/s390x: Replace legacy ld/st_phys -> address_space_ld/st (mmu)
  target/s390x: Replace legacy ld/st_phys -> address_space_ld/st (tcg)
  target/s390x: Replace legacy ld/st_phys -> address_space_ld/st (kvm)
  configs/targets: Restrict the legacy ldst_phys() API on s390x target

 configs/targets/s390x-softmmu.mak |  1 +
 target/s390x/cpu-system.c         |  2 +-
 target/s390x/kvm/kvm.c            | 12 ++++++++----
 target/s390x/mmu_helper.c         |  5 +++--
 target/s390x/tcg/excp_helper.c    | 21 +++++++++++++--------
 target/s390x/tcg/mem_helper.c     | 12 +++++++-----
 6 files changed, 33 insertions(+), 20 deletions(-)

-- 
2.53.0


