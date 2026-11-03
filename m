Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4BF606A324
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 17:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=T4yY1c5p
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOIH9-00006N-Jm; Tue, 03 Nov 2026 12:26:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xOIH8-00005j-1p
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 12:26:22 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xOIH6-0006Pr-EE
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 12:26:21 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4a20bdaf39cso49594085e9.1
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2026 09:26:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793726778; x=1794331578; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=0i0p7amou0Zd3z9VGv+EcRptK1TJ4cWVBtL7CtmRmrE=;
 b=T4yY1c5prp3+ZB4Y6Shrs8x5zySkriA6tff2L+GPEaK2HrtCeX9/3MBSe1cH0SqhLd
 Agy4m9oz61eIopDLR76786jnHo9ClMaaPo1N2gqvjSHfI3hvfSgxPbh6YJivvaPbxvOw
 Hm8d7JCI6PPomn2Gns/ZOCwk9dQzN54Hz7t4yd44HrJ5t3uuvq4R6zLUVeF96tk00gYq
 0Eih5nZNnai44Ii8XDag2ReNCuT2W2XvYdI5qSpOMtWH6qho5nF677uOkNQaiHI26Fgn
 J/8oaV6+zecmWfwapp8HrklcWXKRXRcw8LRFcX25OcswPq/Fb8vmSsKn45GxhOFr2Iii
 zLtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793726778; x=1794331578;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=0i0p7amou0Zd3z9VGv+EcRptK1TJ4cWVBtL7CtmRmrE=;
 b=ErJuPuertIkkXvNxI4x1h98GnshBtVTjU0HveIsWtyzNdrxE/qfeb8Gyokbn4wOGZb
 +m0/1JNVn7z4gcO3li0G4ICx9qTLdnYbhS8AS565uo/Ng+Ro8VGerHM0jGDTd9EkTFWk
 Nxg/9NgdjDe1iZPlWl7BAOlNbIP2pjmofa+3EAZAEJyzMndXeZayJJbqijyWQXAaFFrX
 yZva434xabrqXk315D6wA+7O3/OQG1sRfydQSQSD9c7k0fTfIBR/GsGyL5GwJ8sDnmR1
 REBcH0dszlGBN+XPSMiQrUpwkgwRSGPoV2ed/PZ4OB/hGQvQf6YoFJr8soKiO8GA5dhd
 Kkug==
X-Forwarded-Encrypted: i=1;
 AKwUvBxNU7RZ3ZMKBRwZwiR4q+15ABzb/FtYnreU21lH0p8zZYzlLB4EKV0q/Z7ohJkIKvzR/82sFpLBYpnU@nongnu.org
X-Gm-Message-State: APuU4Z/HNWjRecY5upwzNWyHIy72m3JBmJ2Hz1fuf6dEI0FysNK2biNz
 IFQGXSFC4wTc49yAyKMbMExSHgcrRydBDzdRINZKghOEfjW5c0pQPXRxSMWVaSXed/Q=
X-Gm-Gg: AYBFou3GemCWAAiTFgEsoAOuiYEnt/fbfKdNyfEPsFWiaYTSJVt2VoBw8pcVC4W6Xi3
 OuUfhGwtAnPrjRZDjyb1pOpdKB6fGomwZhy9i4k8RU7VGM1oHl4n5VaPOSQBqkHtr+LZAKOowts
 gC4XZIGNLu7VOORGrc/J0ErYCRCXFrGVikGpi8PJy+cZzfB3MghF2tbKQecsygQ55tvUWsxAxHP
 GtiX3MrC4x4p3ozMSygtnCqcY8mQUWeLbdS5fN0CmUMPA/DTTPBuI9vyKMtlsmobkgZSPbpE7/d
 iIenwxaxMmAN9cZyjmWNcR5Wi6ysbTHFfzMatzQEuNkw9QXmr4iuGi7nMy2kvitoVXd95HxA3Oz
 vA8GGMHxrC/d6DU5m9NyH+6Tzt9POPtiw7JwQLrOWC2oz/+dvaXETlFYRA3B1jv+XsN1GBiHG08
 87m5csH8ZFcShQ8rAdbPVBHgFQ4yO7xwydH2/U+SJnh4IrapQswkShJ/hc161QgHHRSGPiq/n7k
 Mc6MjjBi4rIQVNzsftEWddmeO7YmoOnxJcUD/vJo79WCrIs8CJ7pBfq7KyADclJ8VK+i8YZ81ag
 gJQQCxkjlS3iySovuLO/YdEr6fOPnwPo/RZrgvXocVIZijRhKu8xLvAs8y1k+m7KYxFLfdHjOWw
 RrFgy3j62JEDOnL3osjkaT5k3q7vW6hYo2Q==
X-Received: by 2002:a05:600c:19c9:b0:4a1:7c7d:8881 with SMTP id
 5b1f17b1804b1-4ac182dcb6fmr311058765e9.13.1793726778183; 
 Tue, 03 Nov 2026 09:26:18 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ac0950d533sm211082605e9.3.2026.11.03.09.26.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 09:26:17 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH for-11.2 0/4] hw/intc/arm_gicv5: Misc minor fixes
Date: Tue,  3 Nov 2026 17:26:12 +0000
Message-ID: <20261103172616.2400758-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This is the handful of patches from the "fixes/tweaks to the existing
code" section at the start of my gicv5 series which didn't get
reviewed and which I think are fixes that we should put into
11.2. (The first one isn't strictly a fix but it's also pretty
simple.) Everything else in the gicv5 series is either already
upstream or else to be deferred to 12.0.

thanks
-- PMM

Peter Maydell (4):
  hw/intc/arm_gicv5: Use cached IRS_IST_BASER.VALID state
  hw/intc/arm_gicv5: Free memory in finalize
  target/arm: Only allow GICv5 on CPUs without AArch32 at EL1..3
  hw/intc/arm_gicv5: Use correct type for value in lpi_cache_get_hppi()

 target/arm/cpu-features.h  |  8 ++++++++
 hw/intc/arm_gicv5.c        | 20 +++++++++++++++-----
 hw/intc/arm_gicv5_common.c |  3 +++
 target/arm/cpu.c           | 37 +++++++------------------------------
 4 files changed, 33 insertions(+), 35 deletions(-)

-- 
2.43.0


