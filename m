Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AEDEC3DA5D
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 08:29:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTdXv-0005Sq-0s; Tue, 16 Jul 2024 04:28:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sTdXq-0005Pv-99
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 04:28:22 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sTdXo-0001xQ-Dz
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 04:28:22 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-70af0684c2bso3402557b3a.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 01:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1721118498; x=1721723298;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=nV9f7Z9uo7GcDlW1Lk+YDEAFR+k4t86UdCv3nK4ea5k=;
 b=P4RdhPylTDK0ht42nMLv3Suc7TILkDRjTrs6N7FjYTEWU8SstDhrkQSxoiZDXiS+qg
 Hp1t3yustZmCXpM9Sab3bw5lQKuO2Ge+Zr709H62sWHqPAvI8RqdllO+Vi1ecyGNquzy
 +TmFQ3kwqxfUK7lZedCtL7VFxp50MmT6WWIvB/F7KYBCChoVHlieoLgwmZ1U3RTNUcT1
 P+nr35ghrE5EPEmk23UcR90s2D1YGfkxhv5Unu6qJ70A0ls98/onrfRl7Ov08roDmfK3
 h0debI81iE60m7k5c+4Z/FDcmNfBsZwPpMKPmSBUAZ227Ich4sKAqtZROCNXBDqrdVGC
 nuDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721118498; x=1721723298;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nV9f7Z9uo7GcDlW1Lk+YDEAFR+k4t86UdCv3nK4ea5k=;
 b=kcKxTcoVL/Rt0HpaYTxH28Z8vnvoWMTBi/gaj16f39xD8FndUHp6XeAkcjhSLPhqkH
 C0vwSjz76YkNQPdm8zDLitiZjJr/ni/b6g7FGflYp23DNhLfIVhR6QavLe2/qBaDxx9x
 wa00IktL6f2UkOImNQ/oeecaNATwl7PYI2q8ykAqfYiL0ehFhx7Wv0FZDg5zdNMbAQZt
 5dali0/9sltK5p2IgOoXcWntY4zc91Sg33K5iYDT+e6UK3B+X6BXMxZF/mmlAJNBYb8K
 584GwuZHJv9fL2XRsAPBuVkDhsVNiiTETEOrXp0VuTFrFW97nXCF/4LAA2ODesNIvFlV
 ND7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2vhfcjuhKX3x8xtIDGKaiNLyCPs3PPuKr29jLfwjs6sndnGImUClqkEm/r1pLf5p19b65eBTW4ynjptnBO9JkvQbpKEs=
X-Gm-Message-State: AOJu0YyKeJZ6kL/g6/ucFhoV79qjho+O5muejPEMrVgezmjDQKAB0Ycv
 QYmhCp4d3Y+t7svtzjL3kp0p2zw2wN4jEi/Ridj5Q3wPv/lL3RHG89eG2MkRoa+yZ0m2GIEE/IL
 z9Uk=
X-Google-Smtp-Source: AGHT+IGsZPdOQ4Ab1XYOcZBH+a1KzRN1zlp9N/4LCn0myfcSlM65hfdqg9Q/s4CxqLRSjJl4Tv+tXg==
X-Received: by 2002:a05:6a20:7487:b0:1c1:c3ff:1f43 with SMTP id
 adf61e73a8af0-1c3f12729f3mr1770285637.43.1721118497799; 
 Tue, 16 Jul 2024 01:28:17 -0700 (PDT)
Received: from localhost ([157.82.128.7]) by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-2cacd7037d6sm7693451a91.53.2024.07.16.01.28.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jul 2024 01:28:17 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v2 0/5] target/arm/kvm: Report PMU unavailability
Date: Tue, 16 Jul 2024 17:28:12 +0900
Message-Id: <20240716-pmu-v2-0-f3e3e4b2d3d5@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABwvlmYC/1WMyw6DIBBFf8XMujQwVXys+h+NCwpYZyEYaInG8
 O+l7ro8N/ecA6INZCMM1QHBJorkXQG8VKBn5V6WkSkMyLHmEnu2Lh+mTDPJ1qJuDIfyXIOdaDs
 rj7HwTPHtw35Gk/it/34SjLMWZS/w9uw6Vd+N2h1tV+0XGHPOXxgpFQOXAAAA
To: Peter Maydell <peter.maydell@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kvm@vger.kernel.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::431;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x431.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Changes in v2:
- Restricted writes to 'pmu' to host and max.
- Prohibited writes to 'pmu' for hvf.
- Link to v1: https://lore.kernel.org/r/20240629-pmu-v1-0-7269123b88a4@daynix.com

---
Akihiko Odaki (5):
      tests/arm-cpu-features: Do not assume PMU availability
      target/arm: Allow setting 'pmu' only for host and max
      target/arm: Do not allow setting 'pmu' for hvf
      target/arm: Always add pmu property
      target/arm/kvm: Report PMU unavailability

 target/arm/cpu.c               | 14 +++++++++++++-
 target/arm/kvm.c               |  2 +-
 tests/qtest/arm-cpu-features.c | 13 ++++++++-----
 3 files changed, 22 insertions(+), 7 deletions(-)
---
base-commit: f2cb4026fccfe073f84a4b440e41d3ed0c3134f6
change-id: 20240629-pmu-ad5f67e2c5d0

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


