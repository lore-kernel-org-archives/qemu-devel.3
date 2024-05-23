Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18099C25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 16:17:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAB7B-00059x-GB; Thu, 23 May 2024 12:16:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sAB6p-000512-Gf
 for qemu-devel@nongnu.org; Thu, 23 May 2024 12:16:12 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sAB6l-0002YT-IB
 for qemu-devel@nongnu.org; Thu, 23 May 2024 12:16:03 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6f693fb0ad4so2954885b3a.1
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 09:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716480955; x=1717085755; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=jxjK3DkHHHf6Q3bAgJM+eYcdnO2cbviAh8+W/4IvqxA=;
 b=F+Xj03kw3W8wkQ78u10jJOqvtAc4dFMU28razwu2HCTtIEo/jPl5BJwQ4KC5fec0y+
 04y/aK1BHaJKcmv+xHjcLl/0dkY0H+g2/GYPywpOWo+7YR0Vur+vjVdsoAj/4jBj+hPF
 1puCbJRBnFxvnLEW9WxMJbTmu8Sjfn7sEj3kZNtTvIxB8ZUZx9xNUHFX5XmwGv969vFP
 IKohTPB3ymFAq5Ry/b4at1rgRDX0YK990puXIQz8uSdsHpEMJSCsY4eikTKsUdD2nqcp
 2faMcCP4G4oJRysshhgs2RYSH6cv8swVVZdfHxTtGSfG6xiIzc1RR0FWAat0dqiymrJe
 X9yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716480955; x=1717085755;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jxjK3DkHHHf6Q3bAgJM+eYcdnO2cbviAh8+W/4IvqxA=;
 b=InVhcyML5Wfyh2Murr1j8jVJSRokOjGOCvK3zYcwUtRVvX4jOnJQoXvKU6D8UCAc+l
 hFH9b14pcDbPv7tgfixVZ6oxrfBT+A6Jg7jP52YkvrumWBHRSmlyz/WqD+9/wKuEkzgW
 VzXlkTaeHx8RqH24HlW9BankmRP+qYs0sqIsPi0IOzmWMSp+OgkkJkU9/pLb8JolYBvR
 mYkNOVXGh5RO7nQuRaN5OW1paTw7PDDvwv6MgAG8pGYA9tgjZQGupsJ9xjuVuctYZZwT
 iGd3b/RyiONqZjwwsSV4dYeWLGkaQfxtnkTKzECBWEvvYrgpy0sw6hVTgdG6LW+JCkRT
 9XUw==
X-Gm-Message-State: AOJu0Yw1ae+dbayFt2qaq3lSHDx6QuEMG7Uc11lrV9acyrvIzJuPOuGo
 9p4Y1yNPaEGy04iKi4k0TmKT5tXY/g3vmE3rBxkFjVFvAADovx5FWdZPv4VvQhGuGK7H2c0TTgT
 K
X-Google-Smtp-Source: AGHT+IHM+0gB9FTsrSCWpD7ZmmlXDiA4855A6KN+YYd5MduOSWzsMYFjiTuClKe3hIbzmJ+RM1zbHg==
X-Received: by 2002:a05:6a21:7881:b0:1b0:18e6:ac2c with SMTP id
 adf61e73a8af0-1b1f8b2af46mr6052523637.40.1716480954959; 
 Thu, 23 May 2024 09:15:54 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f4d2a9d9acsm24890255b3a.90.2024.05.23.09.15.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 09:15:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 0/5] tcg patch queue
Date: Thu, 23 May 2024 09:15:48 -0700
Message-Id: <20240523161553.774673-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

The following changes since commit 7e1c0047015ffbd408e1aa4a5ec1abe4751dbf7e:

  Merge tag 'migration-20240522-pull-request' of https://gitlab.com/farosas/qemu into staging (2024-05-22 15:32:25 -0700)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20240523

for you to fetch changes up to bfd43cccab9fb77b8405ca556fc2f2ed3b2920a3:

  accel/tcg: Init tb size and icount before plugin_gen_tb_end (2024-05-22 19:05:26 -0700)

----------------------------------------------------------------
tcg: Introduce TCG_TARGET_HAS_tst_vec
accel/tcg: Init tb size and icount before plugin_gen_tb_end

----------------------------------------------------------------
Richard Henderson (5):
      tcg: Introduce TCG_TARGET_HAS_tst_vec
      tcg: Expand TCG_COND_TST* if not TCG_TARGET_HAS_tst_vec
      tcg/aarch64: Support TCG_TARGET_HAS_tst_vec
      tcg/arm: Support TCG_TARGET_HAS_tst_vec
      accel/tcg: Init tb size and icount before plugin_gen_tb_end

 include/tcg/tcg.h            |  1 +
 tcg/aarch64/tcg-target.h     |  1 +
 tcg/arm/tcg-target.h         |  1 +
 tcg/i386/tcg-target.h        |  1 +
 tcg/loongarch64/tcg-target.h |  1 +
 tcg/ppc/tcg-target.h         |  1 +
 tcg/s390x/tcg-target.h       |  1 +
 accel/tcg/translator.c       |  8 ++++----
 tcg/tcg-op-vec.c             | 18 ++++++++++++++++++
 tcg/aarch64/tcg-target.c.inc | 26 ++++++++++++++++++++++++--
 tcg/arm/tcg-target.c.inc     | 23 ++++++++++++++++++++---
 11 files changed, 73 insertions(+), 9 deletions(-)

