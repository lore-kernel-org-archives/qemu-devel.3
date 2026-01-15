Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23DE4D3CCAE
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 04:54:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgFNe-0001td-CD; Wed, 14 Jan 2026 23:54:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1vgFNc-0001si-Fa
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 23:54:44 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1vgFNa-0006v2-Tv
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 23:54:44 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-81f5381d168so479095b3a.2
 for <qemu-devel@nongnu.org>; Wed, 14 Jan 2026 20:54:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768452881; x=1769057681; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YxGpCaEA6E+gJcfxQzza4MUxtSt8D1xK+PctoM3MmKM=;
 b=Aj7yCFZ2VG2slZDOGZTh+68ITkOseAtG5NtfSmZg4z17PRMhCUiJhrB9nroIdnYUPY
 j4gpgxRVinvMIzrpXKGLRVRkMZe+KlYVbyd2lotWZT2nDbRWmg3C4qkl6/QCavTvAvhz
 P1u50aj/B5tVPiYv7HVEVLYHAhHIfhMYhYHTn67zIneGnGeoDRlaU2y9FNx3BmAXWkY5
 Dwg8IlxYi+BaWztc+54xm6yZOmFjblR65db+zPxdqJRpmSkG3RNlVCP/fqp/bU0MLACL
 uQfa6l+Tuf3gYRB45Xx7w+AFs4PTsU6PbzRyeMcRgpCI7mF39jGaviXKPC5ufhBIS3P8
 hC3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768452881; x=1769057681;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YxGpCaEA6E+gJcfxQzza4MUxtSt8D1xK+PctoM3MmKM=;
 b=O5bT7pwQql6mvDlc51jr108c5yVAln4OrssJ38N7M6f1RonLDvDYNXCiXU0YDDaFdd
 Xb+oucn7ysrR3mHi4iksyDLAPOlrrryUW2QFsi0syj1v8llTZJR+1s+JUjaG5zHJy1/+
 gZddBc+Uh2esQi/d/jdhAKcLd0Ylyo396te5caybYKtYS8K4jDflUOst/f9KrFP5HsPT
 GZKWc0U5bQjYYkn++rzVJqU81OEbl1DO5DDhKO+llLdojCTO0A6X55r0XimanOtseoFI
 uSTzX8FcfqFFXTB+xu06mYt8hW2a20l0M26s9AqjlGhg61MOZzjOsPkLgDRzAfW8Cj5z
 TVeA==
X-Gm-Message-State: AOJu0YzxgEJWUTWHAE+wDjyBlMGAdYNSZ/gwEhM7lPBmxXL/hQp1HYwp
 nrKudMkqr2eyID0FzZwBULP/htY+EQnXOfDtBL0VJ4A1tpXS2hPIEd5Wrzg37g==
X-Gm-Gg: AY/fxX78KViX6BjSLh9T0dUFoFoDA0PJkxREYaC5Lyysj0dFo6/AlWZeQRp9CJEp3Vl
 LcB9fp7HQwZZRP8QVWEOSSrf0tsY7/qFK+u62o3y2kEIIWn0WbclBmx1cJHBzZDFd7jJhf5jA3/
 la3er7GXiboKT+3kv1kscnEg9v3lxJBrxoXRFvy6CJs/vc7zMl1ssEdBWS75twU9dQ7Ljkn0vkd
 ld7zgtiEB0GNlniWCVAdHli4SzNMO+8f5kLilmeaQckxt8Sgztdd+MVoFi8SK/js3kHooCpfhrH
 fsfCns+uqvCmZeKXDyr6FSrtZbAE6bpjJbhBmm48tgCcSJ+9fxGDAExm2E9d9v1EFRJBM7IA9bn
 y4c/7owjaUFzdZVKjsybMlJSyy470y0d4ZuGtDtNt5we7p1HqGTVXVxsuggwJzcAoTZLH8UIq21
 bucJ8FAvMqdPpokg==
X-Received: by 2002:a05:6a00:301e:b0:81a:b183:44fc with SMTP id
 d2e1a72fcca58-81f81d1ac72mr5263141b3a.23.1768452881086; 
 Wed, 14 Jan 2026 20:54:41 -0800 (PST)
Received: from jeuk-MS-7D42.. ([175.119.5.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-81f8e4b4110sm1141426b3a.10.2026.01.14.20.54.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 20:54:40 -0800 (PST)
From: Jeuk Kim <jeuk20.kim@gmail.com>
To: qemu-devel@nongnu.org,
	richard.henderson@linaro.org
Cc: pbonzini@redhat.com, qemu-block@nongnu.org, jeuk20.kim@samsung.com,
 j-young.choi@samsung.com
Subject: [PULL 0/3] ufs queue
Date: Thu, 15 Jan 2026 13:53:58 +0900
Message-ID: <cover.1768452598.git.jeuk20.kim@samsung.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pf1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Jeuk Kim <jeuk20.kim@samsung.com>

The following changes since commit d03c3e522eb0696dcfc9c2cf643431eaaf51ca0f:

  Merge tag 'pull-vfio-20260113' of https://github.com/legoater/qemu into staging (2026-01-14 02:37:13 +1100)

are available in the Git repository at:

  https://gitlab.com/jeuk20.kim/qemu.git tags/pull-ufs-20260115

for you to fetch changes up to 0995e513c7c46412ccb5b11a2e71b9c7145997b0:

  tests/qtest/ufs-test: Add test for mcq completion queue wraparound (2026-01-15 13:45:04 +0900)

----------------------------------------------------------------
ufs: MCQ fixes and tests

- Mask PRDT data byte count to 18 bits
- Fix MCQ completion queue wraparound

----------------------------------------------------------------
Ilia Levi (2):
      hw/ufs: Fix mcq completion queue wraparound
      tests/qtest/ufs-test: Add test for mcq completion queue wraparound

Jeuk Kim (1):
      hw/ufs: Ensure DBC of PRDT uses only lower 18 bits

 hw/ufs/ufs.c           |  23 ++++++++-
 hw/ufs/ufs.h           |   9 ++++
 tests/qtest/ufs-test.c | 126 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 156 insertions(+), 2 deletions(-)

