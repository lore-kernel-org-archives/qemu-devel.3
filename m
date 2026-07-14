Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDFAAC43458
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 09:18:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjZHL-0005Xe-83; Tue, 14 Jul 2026 05:18:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wjZHI-0005Ql-2o
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 05:18:12 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wjZHG-0006mH-JY
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 05:18:11 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-493b27c7451so8540035e9.0
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 02:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784020689; x=1784625489; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=2hgfs2y/j+tMQqWxnh31WAyHqY34QBYRvtZUwFbc0xg=;
 b=q7pdJ8bLEsf+rzXFfjudbn5yWDZEdeLFHkXwC1xvW1raapdH+WFzx6dF755wLvM8nX
 0JMxCwfPZifav40tYDbS9vaT02UTzGuoJe2Ng+lXPwuQxxeAk8b+694R5k75RoZI8bFT
 dkXAKp6BA04ToPdZ5aOoB3AJdkOXtlktk3hOaozOxPRwAKu3vizM49ED7Uljl3EDPAB8
 cxgUCxt8LwchM55zkD+YxE8dB0UzgYGpLJxmrDErWibAaRhAFuCAZOamcbb/INv0KBhH
 lZTyxq+WwYk98LvQUDiOb0j4GpPZUe/tWjs0RVfElypaP3PpD6GiZuF349vxSi84xPoi
 FhJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784020689; x=1784625489;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=2hgfs2y/j+tMQqWxnh31WAyHqY34QBYRvtZUwFbc0xg=;
 b=LJyET0VUW967CdkhE5ss3s6C2euK65QGXXdWX+kofmUjN2cKwamNBmKl7CkVi5mKNt
 N9eQIr4UzAf5c6rlREpX9TNUcOXwtRrxsfHqMqOB8Vm3Jh0ZT4bSqCpFHQnzATgB3MqS
 VEoLgQxfC9kiy9BX3zxKs71KAFQQONgrXQicPjJRoxQAx4XdRGY+RAwycns8tVKEY2TK
 G97OsNrimYwep7gi/RoqNe/YP+tbhxhPN93TMnaGlZIgUNSw+QmiYZcE9LVjmsYLCFi2
 jxqOM+JOWyIxQSqRBibI86NMFZsteBKi8kgvLXtMNQzhtB4jHOaXFBJKzcxrdAHf4Rsn
 NlqA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqZsvZtI1H6FsoTpy9MJLNXD53dalCy2tbGLW34bUCeJ6JUsk7GOanRpDBSYzQaDgHRk00JKEVHEaFS@nongnu.org
X-Gm-Message-State: AOJu0Yy8UaLNRi9O59M2Go1c8mtJl9TQA6Do9xoH2eFUkUnYRoAIHGbp
 huFDSzDvjEE2v5M/6zYSuY7cmbGMFlTtToT7FoO9FdszgwnZuFoSFIp0nO41nEJHmjg=
X-Gm-Gg: AfdE7clGht5CtnBWkBl2b1RL2sApucVfflu+KPij28kVGgEpYKEHxU2YZH17k4l5pF6
 D3o/J+BrsoF3gCSTmow+d8sgm/vu/sQan6xWRAn+SdbGtNReBC40g5cUIeOi1GAotUkG1WsrfZr
 2wsvVaxih8k5QdY2/ydy8y6JovUb1OUCwkGfCPx/p84lC2akxIyORuBu0qmPP1Tms37F8O0Nmg3
 GDSPUGv8OtXL6ZcqibaqYFrFyFeP33crlGolY8fQfuY2BJkvvVEBMBAwnpoTWWv7ZTBLxDTcbYm
 wb7ZEQP/AutA5CQDUnE9CAn77cWiGXDr/796u9hXX5ZrKF7qTIZ5PhHZWHRBzb3EcZhCGlZbpY3
 hJr4aE5Cn1gS0oNSSz27dhUWgR2nPjbQyFS95ybmNbh8gi/1mtgxbpGs8q20pfZrozgW7lsgQd1
 vqvxL9V1waadEBIJAu0k4tzSURWToD6c3dzBkxHsnrQMhMixqP9N8YhT+2Sj4m1wh72Q/Ml0JXK
 bMT9vNTOHqVTdkd34j75+hCOHVJABaN
X-Received: by 2002:a05:600c:c8f:b0:493:ee34:d875 with SMTP id
 5b1f17b1804b1-493f88bd7famr121889025e9.10.1784020688923; 
 Tue, 14 Jul 2026 02:18:08 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4950a322bcbsm69927185e9.9.2026.07.14.02.18.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 02:18:07 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 0/2] target/arm: Minor GICv5 cpuif bugfixes
Date: Tue, 14 Jul 2026 10:18:04 +0100
Message-ID: <20260714091806.3568281-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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

This patchset is a couple of fixes for minor bugs in the GICv5
cpu interface code that I noticed while I was working on adding
virtualization support to it.

thanks
-- PMM

Peter Maydell (2):
  target/arm: GICv5 cpuif: gicr_cdia_read() ppibit should be 64 bits
  target/arm: GICv5 cpuif: Writes to ICC_APR_EL1 can change IRQ/FIQ

 target/arm/tcg/gicv5-cpuif.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

-- 
2.43.0


