Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBC4FC27C4F
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Jun 2024 12:51:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNXXo-0003hS-EL; Sat, 29 Jun 2024 08:51:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sNXXg-0003gg-MP
 for qemu-devel@nongnu.org; Sat, 29 Jun 2024 08:51:03 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sNXXe-0006OR-Kf
 for qemu-devel@nongnu.org; Sat, 29 Jun 2024 08:51:00 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1f9de13d6baso9510035ad.2
 for <qemu-devel@nongnu.org>; Sat, 29 Jun 2024 05:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1719665457; x=1720270257;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=NEVh6tc/8MCebyDPaGT8PrbTdB4/CVWgELlCvYthHz8=;
 b=bWd4LMZVLuTynVSXt5iaLR3+v+SpMkGxBiNI1QAORIN7lW1z04UTIpbYGjMQ8K8Cho
 adHLUYc7kQVaDDCWppXTAd6B1CthlokcNMLOTpitTr2gxuDBq6STs7vFbP3qZiJUGOUj
 Bi6JLpOjSAu/QND4rLavnvemZOcGPtjuShXoQHuf22xzJbeooztpJ1sXLQBnSktKRvVb
 yfQSu9+nhftH4ALy5DU7xsfSkrAsXq+EhC1ao4KObtx7ABlE2KHWdVU7bTXh8qLOYlFe
 x6ff8oj/4uF1Z7r/HXqsehe2t0+6m4NVEkSKIc7L7A1ZRTNqZ4sytxGBJbAxGhyTOJgk
 jW8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719665457; x=1720270257;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NEVh6tc/8MCebyDPaGT8PrbTdB4/CVWgELlCvYthHz8=;
 b=AMNXF2rapuAAuuICoBC1ZBcB2jU7MtsMz+PlAWL2xS8jq8tFBc/f4lWIZ/VreKyfGw
 vjNmh6+exqDvZxf/G/dGV9uFQjd9he4Al0uqQhuGnHMXf8EP6YPBhJdOpM9wdAQfSSmf
 1OVj8YF1fupzVz6XIKIfh4nK+AM6u84MtNbp3vMitjaj3bEKkJnv7aCZ4U/NjAs5C7ob
 lqfe2tf3HGrQdNKdzzqMfeauCEO5vdG+wFC5hQfjm+GEvJbJYFKbBrC6PbcxhXBeRWeK
 FtD/AC+peb3KROJQ9HgQkKO36Zn9c1Yu2uSlnCxte/PfoE5ZvFBqCEuwW/5nqoxPd8u9
 +PEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9C5ign1++HJ4TaEVjrXtcLUKtULZ9F77CtZTpOcWMNDcRtQ+4KU3WJg6kCVRVxFomGFZtV6bbBlLcJdaWjsMXXxzU9Gw=
X-Gm-Message-State: AOJu0YwH7fLwO31DLyTx5LGxV4wIkNXo0E59NWFsV/6ZRiQrkcKu/6PO
 EKMA0HwxZUjav1gAE/V4U9AAqI7vq6JJ5BjiszXAhTWOxnV5xRWvkrLnBXUT8Fw=
X-Google-Smtp-Source: AGHT+IHQCZeDATDIOxBT4heocgBU3MrJ8hkbe6u7b9bRsRm1CsujJG4vYA8jGjTcTXl88JuldNLyXg==
X-Received: by 2002:a17:903:1104:b0:1f7:3fd5:9267 with SMTP id
 d9443c01a7336-1fadbc7503fmr5271805ad.19.1719665456855; 
 Sat, 29 Jun 2024 05:50:56 -0700 (PDT)
Received: from localhost ([157.82.204.135])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-1fac1599c23sm31376085ad.280.2024.06.29.05.50.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 29 Jun 2024 05:50:56 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH 0/3] target/arm/kvm: Report PMU unavailability
Date: Sat, 29 Jun 2024 21:50:31 +0900
Message-Id: <20240629-pmu-v1-0-7269123b88a4@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABcDgGYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDMyNL3YLcUt3EFNM0M/NUo2TTFAMloMqCotS0zAqwKdGxtbUA5VjPjFU
 AAAA=
To: Peter Maydell <peter.maydell@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kvm@vger.kernel.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::634;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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

target/arm/kvm.c checked PMU availability but claimed PMU is
available even if it is not. In fact, Asahi Linux supports KVM but lacks
PMU support. Only advertise PMU availability only when it is really
available.

Fixes: dc40d45ebd8e ("target/arm/kvm: Move kvm_arm_get_host_cpu_features and unexport")

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
Akihiko Odaki (3):
      tests/arm-cpu-features: Do not assume PMU availability
      target/arm: Always add pmu property
      target/arm/kvm: Report PMU unavailability

 target/arm/cpu.c               |  3 ++-
 target/arm/kvm.c               |  2 +-
 tests/qtest/arm-cpu-features.c | 13 ++++++++-----
 3 files changed, 11 insertions(+), 7 deletions(-)
---
base-commit: 046a64b9801343e2e89eef10c7a48eec8d8c0d4f
change-id: 20240629-pmu-ad5f67e2c5d0

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


