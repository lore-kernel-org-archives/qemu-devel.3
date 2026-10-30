Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F42C606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 14:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Y/dRej7R
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMnJu-0006Km-H4; Fri, 30 Oct 2026 10:11:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xMnJn-00069H-HL
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 10:10:56 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xMnJl-0002DD-Oj
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 10:10:55 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-48df4f540ebso374775f8f.3
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 07:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793369452; x=1793974252; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nUiRTSaU1NPVMMFHoiQHThk5jM4+SyPW56vy2Xn7Qco=;
 b=Y/dRej7RrmQg2NH+BWvb3PqtRBCfL/xQGZSoy/QVNHix+rwBWXdYh8B0oGo73JjBBH
 cIk8ukc9NGoPZx5Q/V25d15veSbFdP+MW1Ye9JDV8zMrDs6QC8vRZmJKIuKEx1iQT5BI
 d5fDwwbu50t0uvjypM1CMK6nE/BmfN0LgF6bDYxtq4/DV9pr98LGUHj9jU8rU98KRxPV
 dB/xSZkY3c1xa1KnDUofz1w63LROeJpT7S1np1NEQW1j6PgpPX562AwWKk/aglERIFQ/
 O/3mD6AqL+Bkj9O9qQ7+YWaYe2KVh7x6lHHMLoEq4Uah1Z/TnnwTKxz8I4f3p3m3rs54
 VMmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793369452; x=1793974252;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nUiRTSaU1NPVMMFHoiQHThk5jM4+SyPW56vy2Xn7Qco=;
 b=XTMUjcYn0YB8Xy0EXfGpyhht67Em4l4zCIPHogfvn08z1m4z4zoxGYkXefYTODcmrM
 jA03lXB0KByznNl6qwqQY2GxZUmrz7M9HqLaYaA9tQyr+MihlyQ8kMPD0Ycxx6dO6BIz
 XWNRF6svkJqGEi+MjkpHkzG5vw1wMVK5y5e2qMSFsHT1fPx2go7SOal4ZNuYWgySULSq
 mfXzeEKPj0cdYjtAswT46zUI+3QW7WvwkIsVzrvpDQvCFQaBf2+sYNXbZ9K6hDwlDJEF
 pocJREmFmSPcCLR1ctxrL6HaTBmuqkTUKNV3snlPn0kMr8+rDwix1ACGEGuAdrbzUrBr
 DjvA==
X-Gm-Message-State: AFq9FYK/FgiiAtO4JLa8Y/xaBJnRGaS0n3v8ZMdtqVAr9J5iqhFx33Y7
 +wVt5Qn/VSdUqWVFWxmotzWD8TEDsNv0jAL21QP3jz4L49KG8RT5qfcbMSoT205aABY=
X-Gm-Gg: AYBFou1Fkm2fB2qScv6mVK8F64xshx9zc4ZeY5MBRwvJGL+2OW/wYG54DYr3tdRyzhv
 oVDoK1qxeHfZs3fMu4EAnig/LymR0tbMgsM03y4w9YKfRp8njaS5S7Ee0HNarWWCcMFFBPVXpuq
 7CmfHaibkvmi9NGZ4Io1NXL0KTkb0df2TKquoCTEWM+8tr4lZFUdTpDHqq12XexM56qAmg3VXUl
 56zOVeiWjc6ZFTkIq/KBL1Jpe7gbAWjcKbCGGjguY0qren1NshjUQr6/kU+Z6vi1Ist0fR1LSGf
 JPrqhMzP+hJdcLSriXHRVqi3DzLKMFbTtDhOlGv5jz5GLoyu7PLCuUGT+gPpgyj1c8k0mWls8Yf
 YL7Asm/2N1Oo26+/R/BDRl3oVnYUlcjVW2zCEDZAaiVWA8cxIKn3Q3kMunAZd6NARpMDJQm6tig
 pkQbf7bXHFGH1Ne2DtmiG3Xt7BQ+qHZiOtCsfJoUVg4ksHuAorcu3ruVGhgnpUgowqSVbl2klEC
 0uZL9W2K/yxV80/wtlXuihRTt3T5z2ZPs+6RNQbM5qrGtUX1J8qkE2AdxMH0JQU9N0Ga+Gui45m
 hq9z/SoWZKdKxyqRarvmlY62+z5141HNUuSUhmdIMxYgB0+/8Q==
X-Received: by 2002:a05:6000:cc8:b0:48a:fa0a:34d8 with SMTP id
 ffacd0b85a97d-48e6e50a10dmr4203645f8f.38.1793369451824; 
 Fri, 30 Oct 2026 07:10:51 -0700 (PDT)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71a4d404sm3965685f8f.5.2026.10.30.07.10.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 07:10:47 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 18BDA5F7FD;
 Fri, 30 Oct 2026 14:10:47 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 0/4] arm fixes (WxFT, bcm2835_fb)
Date: Fri, 30 Oct 2026 14:10:42 +0000
Message-ID: <20261030141046.2710206-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x430.google.com
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

These are the arm specific fixes from my last series. All reviewed and
ready to pull.

Alex.

Alex Bennée (4):
  target/arm: hold bql when SEV sets the event_register
  target/arm: don't pass env to the sev helper
  target/arm: simplify wfxt_timer_cb to only trigger cpu_interrupt
  target/arm: fix bcm2835 migration issue

 target/arm/tcg/helper-defs.h   |  2 +-
 hw/display/bcm2835_fb.c        | 11 +++++++++++
 system/cpus.c                  |  2 +-
 target/arm/cpu.c               | 20 +++-----------------
 target/arm/tcg/op_helper.c     |  7 +++++--
 target/arm/tcg/translate-a64.c |  2 +-
 target/arm/tcg/translate.c     |  2 +-
 7 files changed, 23 insertions(+), 23 deletions(-)

-- 
2.47.3


