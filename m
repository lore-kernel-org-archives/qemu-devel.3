Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6BE606A31F
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 21:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QKMUS9mK
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLSG0-0001Kn-Va; Mon, 26 Oct 2026 17:29:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gessingate@gmail.com>)
 id 1xLSFp-0001Jx-9c
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 17:29:17 -0400
Received: from mail-qv1-xf2c.google.com ([2607:f8b0:4864:20::f2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gessingate@gmail.com>)
 id 1xLSFn-00076h-II
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 17:29:16 -0400
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-91ba8fcc684so33767886d6.3
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 14:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793050154; x=1793654954; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=umrR5N6op3TzUxoaxinr6ylUSq+sThPpBf14p8okNYA=;
 b=QKMUS9mKh/yIMG40VOJtO4+WcLFT/uZrvhOBudC9OFdADsQx7+r6nkqAb/Zuaa5Kb7
 eGs9Ai2YzQ2/B0hfuncunnU7bl6dLhe2qxKff5h6ZHqSYLMen2f9u7mLp6dsr5UnETGB
 FxwLbsMcuqI0OAgXaNF1wxSn4ZHB54nxlyzJTd/7rZDG23HTO6kiVaOf8HnUdgwbj171
 I70yk/+wXKxXrEpUZtWw8pkEA4tSsSD9gVKRbrpBLQAvl/4RUH1liA2rrHAS1j79JuEa
 bIhJoav+YDwQhJ41ByWKodgULlzzvdhRvM8cJK+7hfA251JFchYeovva6tOGe5VfYP+k
 1lYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793050154; x=1793654954;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=umrR5N6op3TzUxoaxinr6ylUSq+sThPpBf14p8okNYA=;
 b=c1X00yUmeDMNjGO0YqFf5uUB5R2FVpKaiI6hX6fQoYXHDTX0AZ1qqc2Gpq3MDSMOH4
 CQbZsP+eKoXcdxO2fAoc3h5qa72GwMOx84+MPdMpukG5X15MquWrp828uecYzyTcOmJV
 V55KxnoOqXrAed4z5viOZTj39fm4loPR1t3udXD+/SrtTTfvEeeeKykf0NIu0tlbmybm
 uP/keeqxrHoZIizBKwR48psYAGw+j1pG6KHINrHx42qecAnIfyq3RKhT12o5ar5hgYuD
 BuEvecpCd7tEJhHxCHpo1pAQq3g0NuY51EV9KtIlxnJYQ/G66XNzDv/IA+Ruk+oU5rAJ
 Hyrw==
X-Gm-Message-State: AFq9FYJcmVtVDnCU0AtgcmiOXU4EdH4dUYZtbChOkPyCuTqZ0N4KsZMp
 wYAeFnE09VPSbpp/WneD3MkwdYRbpOlgxuQa0Dr13FeaCoOfyD7nRZjg
X-Gm-Gg: AYBFou2Oa2h+vKCjIgzukQHX8BDjeuJxFi/GmZ5bzf8tGCv+SrhIKmfQwW4GD2xLVZe
 mGFlfiocmp+HxTd3JyzSQPtvmQY1jqmdShWHLVaJXg5PxtmQf7XF6u4N5oTjE9EXZnNjJHwcxq1
 pmaOXOHHqODHiH1dctkAeBTiMZnImPPdF7jN4tyMZUyHYLQ1dapAK/DLWoAILyK7qXHshnOsoxB
 c6zCfwb/KfF8O0U94nXg6G+/EjrfIFTq74xdxPMbJLqQbwHxYQ0jwvwlcVZeO5ZDXKpEIoVGSuH
 txhzXXEY9CJIRe9ldKRaF+gYoj9qzxKBU6GK4Wt3qZUN20tu2rBxYz2oXqogQg+mjdmV/iSusN8
 9i2EM0/iBNf1vnjezFRxAHoseCL6/q6+M7jfeySn4NfTGvEAii64cF8j8XwV7zPwNZG3MvPa7WT
 ZVMIzmaeBoEuS+JpEBaw6SH9AxzwgTJiDxPfu9Xp0VwuWTiRHmElRq31k2VuUNubFhEKmxMKLvc
 uUkJQxRz5rxZgDSw4PHBfZx95pn7Bp30i9bmgLTkvv6Z2/FMRCj25jXn7QukJvWaYxRm0f3aJqN
 wO0LclK9rpFNQB0YYQo7pwSSa4bdiaSC+shP
X-Received: by 2002:a05:6214:300c:b0:917:8c86:6608 with SMTP id
 6a1803df08f44-91c48e85ddemr148146836d6.42.1793050154081; 
 Mon, 26 Oct 2026 14:29:14 -0700 (PDT)
Received: from [127.0.1.1] (95-24-99-141.broadband.corbina.ru. [95.24.99.141])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91c47c6f3bcsm85206376d6.29.2026.10.26.14.29.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 14:29:13 -0700 (PDT)
From: Timur Maksimov <gessingate@gmail.com>
Subject: [PATCH 0/6] hw/i2c/aspeed: fix non-packet transfer modes
Date: Tue, 27 Oct 2026 00:28:36 +0300
Message-Id: <20261027-aspeed-i2c-nonpkt-fix-v1-0-076cdde514f8@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MQQqAIBAAvxJ7bsGWDOsr0cFsqyUw0Ygg/HvSc
 QZmXkgchRMM1QuRb0ly+gJNXYHbrd8YZSkMpKhrFGm0KTAvKOTQnz4cF67yoOlno2nWzrQWShs
 iF/1/xynnDyjeKAZnAAAA
X-Change-ID: 20261025-aspeed-i2c-nonpkt-fix-89b852b5c84a
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 qemu-arm@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Timur Maksimov <gessingate@gmail.com>, 
 "Timur Maksimov gessingate"@gmail.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793050151; l=1174;
 i=gessingate@gmail.com; s=20261022; h=from:subject:message-id;
 bh=vQB/m+mwXlfMF6EIdAnPWApC6H43j3gKu4LTgJOq4Qw=;
 b=3vDDVoKFL5ykQBmc1PRHJZENnz18rce9kpPkFwODsOFLONbwBkeSD86SS7zyVMHkU1fEclTJi
 lAn5x8wzk6tCGWcVfSUsBp9zSTJw0SrMfQRgZC5AMPr5o2q61qYot58
X-Developer-Key: i=gessingate@gmail.com; a=ed25519;
 pk=xF4NKIzSbKMdte17nQ66S/q9m/A2gu6GiEWc8ZnyJmo=
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2c;
 envelope-from=gessingate@gmail.com; helo=mail-qv1-xf2c.google.com
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Some Aspeed I2C modes are broken,
probably because no available driver currently uses them.
This patch fixes them, so byte, buffer, and DMA transfer modes
work correctly for both register modes.
Tests are provided to prevent possible regressions.

Signed-off-by: Timur Maksimov <gessingate@gmail.com>
---
Timur Maksimov (6):
      hw/i2c: add dummy device
      hw/i2c/aspeed: fix CMD register reading
      hw/i2c/aspeed: fix buffer transfer in a non-packet mode
      hw/i2c/aspeed: fix DMA transfer in non-packet mode
      hw/i2c/aspeed: fix BUSY status reading in new register mode
      tests/qtest: Add cases for 32-bit Aspeed I2C controllers

 hw/i2c/Kconfig                |   5 +
 hw/i2c/aspeed_i2c.c           |  23 +-
 hw/i2c/i2c-dummy-device.c     | 168 +++++++++
 hw/i2c/meson.build            |   3 +-
 tests/qtest/aspeed_i2c-test.c | 836 ++++++++++++++++++++++++++++++++++++++++++
 tests/qtest/meson.build       |   2 +
 6 files changed, 1029 insertions(+), 8 deletions(-)
---
base-commit: d73149283205645625bfa9fe029cfb68e4c4a9ae
change-id: 20261025-aspeed-i2c-nonpkt-fix-89b852b5c84a

-- 
Timur Maksimov <gessingate@gmail.com>


