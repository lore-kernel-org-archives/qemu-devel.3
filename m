Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79DE0606A320
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 16:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=KZz+ud+X
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIq86-0007Zn-4K; Mon, 19 Oct 2026 12:22:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xIq84-0007ZU-6t
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 12:22:28 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xIq82-0000zc-Ke
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 12:22:27 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4a1e266fca2so9605945e9.3
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 09:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792426945; x=1793031745; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ASvd06Vj/QEZKs5daEjChhsW+tV/2E9ZjYHvF+a12V8=;
 b=KZz+ud+Xy64SaBnJJUcIhBMoBPJ2PI5XFwUMnsBbblX4GFiR1MSdO74xYi7XnV6Q4V
 dCPKoHRCDL/8RlmMo++UOUmhtLuujSybEDaQ3tPvOzRt95g1V6rLfN5sKH1bqa9UPG5B
 lGyCCVy3DIn4fttg66Aykzqi00ABy3EjknQs77n5G7j9xM14rKKidpoUf9zY7EqIxsjS
 RJfMxb5bmlPrKykANyElVa4+VRXWyCyc/J9yjbC1a7+6uvK3aFuAn5SzQ+utAq7U0j/c
 glFvT5WALlGYlYhi2OJSKElfUfj6u4MlmHmOwx4FlnxftCsLzw4vDPLu27Kp/6sRuV2G
 jL7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792426945; x=1793031745;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ASvd06Vj/QEZKs5daEjChhsW+tV/2E9ZjYHvF+a12V8=;
 b=oxm9uHrf/fQYZTI0JFgyfuO+9FvkITuI0hPF+1Vmr9BKGsR2DLDvKfBPxYtIS7KVao
 HVFfPI65/7eeefVxg3U9fxLs5q17up8l23Mj1WHFTrCVOunHV3FLVVvuL9mBz1eenlK7
 mVvUYF9n/NIxc0sIcXAttDzaL1A0Vc2/A+4+h7R1L9CljNmGwYWXQCWaORGjmtIPiVcz
 LlUuoNJpZx86afVcbxjSn7h1xZQFkdASKUFq4vye2JLkPU2WkxD64aTaAgvlWky5/FKk
 LsEJwPtHpVGL/96Vt9RavFBf5denqylMjQztK+HHwsWBfUAePDUyJmd6WuSgHqVdh+gj
 QhCA==
X-Forwarded-Encrypted: i=1;
 AKwUvByUSxxFrgDYKkD6FrLEAbnoA2rh8IelOEzjAXurm7GgWlw9fRU4r5CtOjegxpZgOQQt4FheA/wwQnJ2@nongnu.org
X-Gm-Message-State: AFq9FYLADpdalUQJXW8AH7HLoJeNwovnpiCUbPUZZMw66JzJuBfHSIUL
 fVvrb9EZms4yeHYMul6aCvFCsUlYEg94XRUcHOicciD5szbl7sDtlS0NFInDBBAXLJ4=
X-Gm-Gg: AYBFou072yVUahPGsdmvUT4Mp+t2EoYUguNVFxFVPTLXVAI4OL7vRaYAwD0PefVCE1U
 lAMtX6uKCDhhEQL9erWBPSDvN3tAOhK3kyJK4LXU4DxYmOS9VEF87zSUQ87SNE8qyaTvOKACbLM
 RjycM8iqafvPm6jiSyDqf3kweIhwNPGSrJEwTQP3yspXz0rMN4vutB/MGgCvzGGlNG4RCPuTEG5
 kTFQyk53kLk08H8qy+g5zZuP2cep5fNop45nDIHWl4nDtUMH0XGHB768vFNt5qESwuZ/NTfqLUq
 87ge0xJbqd700xLyvAZDOkXE+e/3T+rZqEWz78nBcVO1hpwa0AlnWXDXwR2YouDLRpNc5gwxWmA
 mP7F5XTK3rQp0DH49z9w1zW+HmQRPtcy2/2V6Th7oFhtpiTwQmTmxY7MHydzJKjISEfY0HaxNHu
 2j3HWwFgw1Oo37C84FfAlJZrAJXqWW0TtXVg9tGu0lgR/vUc0tBJ/K3xwNVb1bXyDDOHoSfZVeD
 03CmuomnI82qQvugyvQVc8GqKfrpwYs1zBvsjxXIuMCDrU5gdbnAbpBf08TbmNmsSM2o8WlW7sN
 1lQ=
X-Received: by 2002:a05:600c:4fce:b0:4a0:1b14:e283 with SMTP id
 5b1f17b1804b1-4a1d75ac25cmr194943135e9.1.1792426943894; 
 Mon, 19 Oct 2026 09:22:23 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1f2cdc342sm3100095e9.13.2026.10.19.09.22.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 09:22:17 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 0/4] hw/intc/exynos4210_combiner: fix misc range check issues
Date: Mon, 19 Oct 2026 17:22:13 +0100
Message-ID: <20261019162217.3272337-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_ZEN_BLOCKED_OPENDNS,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This patchset's meat is patch 1, which fixes an incorrect range check
that allows us to index off the end of an array.  The other three are
cleanups that I noticed while fixing that, where some checks that we
were reporting as LOG_GUEST_ERROR should be "never happens" asserts,
and an array we use for register contents has an extra unreachable
element at the end.

thanks
-- PMM

Peter Maydell (4):
  hw/intc/exynos4210_combiner: Fix group register range check
  hw/intc/exynos4210_combiner: Clean up reg_set[] bounds checks
  hw/intc/exynos4210_combiner: Make reg_set[] only as large as it needs
    to be
  hw/intc/exynos4210_combiner: write default case is unreachable, not
    guest error

 include/hw/intc/exynos4210_combiner.h |  6 +++++-
 hw/intc/exynos4210_combiner.c         | 25 +++++++------------------
 2 files changed, 12 insertions(+), 19 deletions(-)

-- 
2.43.0


