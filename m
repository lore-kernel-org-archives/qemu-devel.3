Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B817C3601A
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 01:09:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0VYz-0008Iw-Pf; Thu, 03 Apr 2025 21:09:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u0VYu-0008Hi-2N
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 21:09:37 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u0VYs-00080r-87
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 21:09:35 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-223f4c06e9fso14349865ad.1
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 18:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743728972; x=1744333772; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=C4xj9W/m0emR2vWhShdJHt3VdmhHRfyY0vRRgxPa7GM=;
 b=j+I6hSXkII/8GcmG7egGNR5ROuZ7M6h+ORlG2lpywad3E9cY1FzAWWDFV8v3F2jfEx
 3juACM5KLJeK9sde1M2x4vgsNGq8Cz9sciTOYwXtUw+e0s3dwiV2bvThoTOqxoeDd9fl
 o8p15I8Ywkbb6+wG9NxPxkXut8ys7R1vfZr4sHIG2gYUf6Hf3nLn5lndY0krxhnRtx7b
 IKI2dux9ydxVWsdMXvnykKTYDVit9LkIYAmicfngBw7LDMzdXDamMKcjfWOfOfR4h/Ia
 oxrDy8RgEBCLA5LBz/Oqp0YNFb/AaSqU+XSFOlU9E051ZqeGu7Jtu4UQJ2uw5g99ukRI
 wjBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743728972; x=1744333772;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=C4xj9W/m0emR2vWhShdJHt3VdmhHRfyY0vRRgxPa7GM=;
 b=NeQMEQIrMU33kte8dO5G+CH3A/79MCAmMCm1r7Se2VDuivnO5jDIfv+5yG4wacPtT/
 xbdSyTAo+LojTXE/va/e1Y9hNM5i2WwrVMwf9ohNRSIN0idxhkLR7g8mqtL9Cp4rBQ/7
 LNGC2zKL1+yhnh0vN2y4DtZhQV09wb3vu2FzNAxH+NCXvbnco+L+cTj2xJjxfSUBZpo4
 ix6f+Zx3L7Wn0mxiSM1m4phbZ5SdlaAihckYPo5cjYTg2rdodCipiWORqOe6kL7za+DG
 JQw1UhGsjqBab1xxhnqNsyezOVTHXP+eJJSJyawE4W73b74bGTSRFUbXLUwAcl525qMt
 DVvg==
X-Gm-Message-State: AOJu0YwLWRBHEUfhwUawkXVyMYNKpUriQjyrozxoK9+tEgRm4NHyskBG
 Nl9HIRKJdcOmpCyThvX/Re9iovTzWLG8UiYGDic/jaD2WPYJ0iQI4HC8Q0akwQ2orunv4FEAOgv
 T
X-Gm-Gg: ASbGncvdT6dUjORbamDVGkjC5lcsaguZh/HKGNiTf1yEIPdlBmpLm6MiuMyQ1lAzWZD
 8nIqsQIGfbbw+pE6EG/if7Y0LmYXGbwqB61Jbaq130vS+nUaHJpCtRAy2YQciAMM/FLiNDS5h7B
 DRH1HBb4BtCHIY6UpuzCwTN1aKKNP7n6TbgqzKeVoo1+f7c62kowZxkprw6WoLiW7cGqIJy40ku
 Bbo0524/5/Ijr2FqWlkLVVGawxt+CmaMP/zaYBijsMIFS0zUrTkA4WnWdgBp9eVGPG49nBtJR8Q
 2m5KS+yLYs68N9yKrvQL8NC+x2F30ejBnhblDubrchK1n+4tmYI=
X-Google-Smtp-Source: AGHT+IFTeV+vn336/jmQlVn5Ol2UXtdoiL3QVbj2cZ72m+OvMqSF3E7/rn6GI8tKg+bYHJHL+5NXWQ==
X-Received: by 2002:a17:902:d2cc:b0:21f:98fc:8414 with SMTP id
 d9443c01a7336-2297673f624mr69883555ad.26.1743728972260; 
 Thu, 03 Apr 2025 18:09:32 -0700 (PDT)
Received: from stoup.. ([75.147.178.105]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-739d97ee2d9sm2171755b3a.39.2025.04.03.18.09.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Apr 2025 18:09:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 0/6] tcg patch queue for 10.0-rc3
Date: Thu,  3 Apr 2025 18:09:24 -0700
Message-ID: <20250404010930.164329-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

The following changes since commit 0adf626718bc0ca9c46550249a76047f8e45da15:

  Update version for v10.0.0-rc2 release (2025-04-01 13:15:45 -0400)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20250403

for you to fetch changes up to 49551752e860f5e403cdacac11ee1d218141fd3d:

  hw/arm: Do not build VMapple machine by default (2025-04-03 16:11:09 -0700)

----------------------------------------------------------------
tcg: Allocate TEMP_VAL_MEM frame in temp_load()
tests/functional: Skip aarch64_replay test on macOS
hw/arm: Do not build VMapple machine by default
tests/functional/test_aarch64_rme_virt: fix sporadic failure

----------------------------------------------------------------
Philippe Mathieu-Daudé (5):
      tcg: Allocate TEMP_VAL_MEM frame in temp_load()
      tests/functional: Add a decorator for skipping tests on particular OS
      tests/functional: Skip aarch64_replay test on macOS
      tests/qtest: Skip Aarch64 VMapple machine
      hw/arm: Do not build VMapple machine by default

Pierrick Bouvier (1):
      tests/functional/test_aarch64_rme_virt: fix sporadic failure

 tcg/tcg.c                                   |  3 +++
 tests/qtest/libqtest.c                      |  1 +
 configs/devices/aarch64-softmmu/default.mak |  1 +
 tests/functional/qemu_test/__init__.py      |  2 +-
 tests/functional/qemu_test/decorators.py    | 15 ++++++++++++++-
 tests/functional/test_aarch64_replay.py     |  4 +++-
 tests/functional/test_aarch64_rme_virt.py   |  4 +++-
 7 files changed, 26 insertions(+), 4 deletions(-)

