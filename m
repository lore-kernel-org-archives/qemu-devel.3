Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D2E606A327
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 14:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AmyWHSzs
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWaXX-0003Qa-M3; Thu, 26 Nov 2026 09:33:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.mehnert@gmail.com>)
 id 1xWaXP-0003Cl-0Y
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 09:33:31 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.mehnert@gmail.com>)
 id 1xWaXI-0001AM-QV
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 09:33:26 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4bb77a462c6so58692925e9.1
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 06:33:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795703583; x=1796308383; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ZGDOqzl05R9gVFs1yGPWuA5HyYBfjyTwYZvYQyYVT6g=;
 b=AmyWHSzsPepTwuwFVkRJblmx+EqdHVj1e9NQLX1rzKST/ZapO+jxp8P6jMyAHaMudC
 Wlg8rwLZlP+LM7nH/lRHTEWB1gMLKgn4sjgEYz6fT5ZJy5dPwHo0MqxfOWeAcwNLY3go
 bV9iP/NWRNr5HSXyIhVPMYWHFd9n33m+a1t4psWumGWtuPT4w2AaOef4SMcs/gOoDC1L
 AEPxfkr0qpusQCNYeFF/DGbbsOeWdvdl1a6n9g5nsaggth6rL39cFGlMViHPGQkZHTvD
 DWoJyyHefUVACDj0PpIVUfgEV2nNoJLRR4/8yiGPzw3OCBFhZ3OvoAHG2oVkbf+9FliS
 W1zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795703583; x=1796308383;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ZGDOqzl05R9gVFs1yGPWuA5HyYBfjyTwYZvYQyYVT6g=;
 b=uWs4/azBoCHpka2c1OJKsAxGljAWFycl8ZpxOtk856ZRTlnrwe6yfP80PYv3DCwU0t
 srbI89txCGD01Cb7gMUjzroQz+V/5ploiiuXFGgY/9qTfjchRlou8f4VGuYuacV2fBoU
 T1HZ4dGQB471sRRNCZzclVhk3fvzDe/ZgF+GK41/a1P0Kx+Fqr6U3QtS7+lIqpHYBzOP
 gb9weRGzDTnYeu1JtgSFArBFEqN0P+AOpDqkl5BU4scU7jH2f+xmfo34a4QAweyl9kdb
 bV/iUiufrPEfLTvr9Cc0K9Hx0ACWrwLQYmHFmWPwQ3MQygQ0PXngn3RkT1i+a3Fn2wz8
 gRdg==
X-Gm-Message-State: APuU4Z959MQEmgWvd0q9yX1klX+aYEg5da+MDbcyn97ijVxLcVpnXfzF
 vTUCu3qEwv5V9sna2IRAiRpc1/45LLFFs361oFs/9KHEuhZjaIKCxpx6AKC09PqB
X-Gm-Gg: AZFdTZd5hfeP88D5yTGRixd+rqGWJNKAdWTppuKnehrfAMdcuEf1omT0elfBmljGkOE
 xMji541Id2MSkPItfqwMn8Pkm4XjDbQ8tXi9Fn5Cpwa0ql+GoU+PPIOXcY05eNEnOEkzE3FARr1
 RMoiqxGQ2eJr0y11XFgpltDsHaBAC40nx70JrokxN8w6C5qMmiZZJZZdU2xAWU6Yt8vtZIjSXUf
 OP2RzRrSumSEc48O84ZTjW8q/VRwZRvWTqsHfWKRmnAhjD5chLyMs7oCHBdoiwQAN/0mfJeEqmf
 URFn/9Dnr63zJG5Xm847UJiVwQ8J2c2PqNEi8IZDcOeiIQDTaDtkfLotQ0yjttDM/0Ng8F1WJMU
 IMu062SdrgaIoSzw3sSInlUhrULclFT57QzVwoLoLZxpXPX/ywlxJ4tsj6TBLYwc79GyMcWhLOm
 ZxOVshd4efSvF0vZJaPVZk+E2STJiLsmi72tsUmtde67vVhwmjjIgtQVV0QYJFaXzwBJw/uGx26
 Jt7ZSinBVJ8O5t9k9rIHnf/JgEcnsv1garB9bKFfYqfpQGQFiYIVOQy4Wr647vSZfLG7LDUgSRz
 hArDHuug79okYaXrPmtUt3fbpYwVPHWCOnF4rKdnSbRJd5LMrM6rtDASPkwaFO4uHU0tNTEyASk
 w/RSRULi/davBtHM/YOwd0uoxIQIs5z4tvHmdN47w
X-Received: by 2002:a05:600c:5303:b0:4ba:4928:8aec with SMTP id
 5b1f17b1804b1-4bb88807d7cmr402995035e9.9.1795703582957; 
 Thu, 26 Nov 2026 06:33:02 -0800 (PST)
Received: from noys4.dd1.int.kernkonzept.com
 (ip-178-026-066-148.vkd85.pools.vodafone-ip.de. [178.26.66.148])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853b2437sm849925415e9.13.2026.11.26.06.33.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 06:33:02 -0800 (PST)
From: Frank Mehnert <frank.mehnert@gmail.com>
X-Google-Original-From: Frank Mehnert <frank.mehnert@kernkonzept.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, alex.bennee@linaro.org,
 Frank Mehnert <frank.mehnert@kernkonzept.com>
Subject: [PATCH for-11.2 v2 0/2] target/arm: WFE wakeup after a failed
 store-exclusive
Date: Thu, 26 Nov 2026 15:32:56 +0100
Message-ID: <20261126143258.1056688-1-frank.mehnert@kernkonzept.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=frank.mehnert@gmail.com; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

A failing store-exclusive means that the global monitor of the PE was
cleared, which generates a WFE wakeup event. QEMU does not set the
event register in this case, so a vCPU spinning in the lock pattern
"WFE, load-exclusive, store-exclusive, on failure back to WFE" can sleep
in WFE forever although the lock is free.

Patch 1 sets the event register on a failed store-exclusive. Patch 2
adds a test case for this lock pattern to the WFxT test.

Changes since v1:
- Add the test case (patch 2).
- Add the Reviewed-by of Alex Bennée to patch 1.

Frank Mehnert (2):
  target/arm: set the event register on a failed store-exclusive
  tests/tcg/aarch64: test WFE after a failed store-exclusive

 target/arm/tcg/translate-a64.c       |   7 +-
 target/arm/tcg/translate.c           |   7 +-
 tests/tcg/aarch64/system/meson.build |   2 +-
 tests/tcg/aarch64/system/wfxt.c      | 103 ++++++++++++++++++++++++++-
 4 files changed, 115 insertions(+), 4 deletions(-)

-- 
2.55.0


