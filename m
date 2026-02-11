Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED43BECD6CC
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 17:18:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqDrE-0002tR-Tp; Wed, 11 Feb 2026 12:18:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vqDrC-0002sv-KU
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 12:18:30 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vqDrA-0007v5-AH
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 12:18:30 -0500
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-8249aca0affso535581b3a.3
 for <qemu-devel@nongnu.org>; Wed, 11 Feb 2026 09:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770830306; x=1771435106; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mGotZmyagvhvQbE5YGEMHhJ5IQ2OsCgy2rFMZYxQMCc=;
 b=kwtKurOZGtkqI3jM8GZQbgekDTV9JPDuKo9QG3mVmHQ328VD17TeZUResAIH5HCjfU
 jjN6W/vwMbzZzaGohJ1I9+pLrhjGTgEWtTIlYJ+zKCDjPkYgjAIRj2Sf/CJGz5iEvoo2
 2CzUFkd7s+dwffE3k0divG6uDrVehJh+qFdGnnRG3PIzHC623gE0rN7GPAQ+g3173d/Q
 E2nztvK3SL7OGQi6GH2ovKFjlg2b9/7R4Yrhi+Y770/SAM3n2XSIqR02whXA6qIcQusl
 Z9Ay/TrI2YZEL8HtjnM1vggRgRafDCjRm6Ih3iPIY0KlCip6x6nTBDRTZhQvp60SDKe9
 FKvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770830306; x=1771435106;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mGotZmyagvhvQbE5YGEMHhJ5IQ2OsCgy2rFMZYxQMCc=;
 b=iiJGYfPSRjYlsjpBvizHWQrsXTJM0+d9WLcGPnKPnrqPWe5izERGZabGg2FMLl8Y0x
 x4aldIWrkt6nrPGCol9ypD05PDfmMxE1R1cd5mWy0uRl4qm5msHmHuBt0gWVIVBDT3vP
 xCWL/086avRnqGYHMJnEsxLIarcnVBv+SdEbYsVnr/fkS2Hv3BqYw60INhrJ9eKt+VQK
 Dpcam96d/vzzsypWSmUKWIGDNI5AeONY/kw0b0k1s24A7l8+iVRVm8OcyheJ2EUtsqYQ
 REX6eGnZ54lePTKjsb0GJWgNxVv23cQm3T57fzF1K3EK+5PfjCkQFuwedeSAtPOqZsxR
 D8ew==
X-Gm-Message-State: AOJu0YyU4oxROvzreVaH4sNCojyeLFWYcsczvqel0+iGOf02OsQ7yQmt
 FaKXpPQRmtSRPfzkCgILibvgOVgYvLEwvYNeihBOu1IbGOUFvqkGHWE60Z2w0asBhgvNbOAW2zm
 ifyV2
X-Gm-Gg: AZuq6aKm5weWfjqiW+cdm19Ys37J3E+9D186GrGITn4DymnEe2x2pXY2C8nCvA2Pj0S
 D+vuin4lsFPxn8YezgKCtUevY8Mgy0MyiyrCCRPlvf/XPC4q6e2PC9fJp2/YYdtNBudqtgSyPdN
 4fcJEOwWe5ZgrckLfeW0yhKfRDxJUz8dIyE7TAvXPqFWcDcnUdG45cySxoRTj3nhe48rvhbQJJi
 5UNgtfI1Kn/QbCLA401D3105qgE056SqgZnnDznBJj5n0gfPs8ErwrD5+oIm2m5enmDffRjCH15
 7JPKuptVwec+UtSJw+Cdry/+E/cYo8TH4xcUvaLVHPQL/B644olDCkZRpkqNeTwXkqFGAaPvIsp
 mTsGldoW4UI73ugAmekyi2rFbU4eJ67V2gXjivnJmy9dZ2SrZJ8r7w6D05O9WlsZYnQaH6WqhfK
 hiR4VC/EZfd5rONpJP4IftXEC+WisAU83AXix2EzZWz5Y0IDwojH8owau5knY1ZOnqX5qqSXJU7
 T1JARimBlrYy7E=
X-Received: by 2002:a05:6a21:a343:b0:38e:9e38:5977 with SMTP id
 adf61e73a8af0-3944852b282mr6424637.30.1770830305847; 
 Wed, 11 Feb 2026 09:18:25 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c6e197f5e17sm2730459a12.25.2026.02.11.09.18.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Feb 2026 09:18:25 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@linaro.org
Subject: [PULL 0/2] Docs update for 2026-02-11
Date: Wed, 11 Feb 2026 09:18:15 -0800
Message-ID: <20260211171817.3089906-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42f.google.com
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

The following changes since commit 0b91040d23dc8820724a60c811223b777f3bc6b7:

  Merge tag 'pull-loongarch-20260210' of https://github.com/gaosong715/qemu into staging (2026-02-10 09:12:38 +0000)

are available in the Git repository at:

  https://gitlab.com/pbo-linaro/qemu tags/pr-docs-20260211

for you to fetch changes up to db61fb7a57c79b7450725fa13000c1f6d72ab9ef:

  docs/devel: fix bash-ism warning for configure (2026-02-11 09:15:35 -0800)

----------------------------------------------------------------
Changes:
- docs/devel: s/most/most recent/ ``probe_target_compiler`` call (Alex Bennée <alex.bennee@linaro.org>)
- docs/devel: fix bash-ism warning for configure (Alex Bennée <alex.bennee@linaro.org>)

----------------------------------------------------------------
Alex Bennée (2):
      docs/devel: s/most/most recent/ ``probe_target_compiler`` call
      docs/devel: fix bash-ism warning for configure

 docs/devel/build-system.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

