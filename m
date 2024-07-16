Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B634DC3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 12:52:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sThdp-0002HZ-7p; Tue, 16 Jul 2024 08:50:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sThdn-0002Fq-K7
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 08:50:47 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sThdl-0004sV-VY
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 08:50:47 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1fb0d7e4ee9so35751455ad.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 05:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1721134244; x=1721739044;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=iU26PLhClMFoNq13xT+fqq7kADjl0F6rGajgxxU34LY=;
 b=fH2JxSsOGZupU/qWwP2RthyLc/CxMsHc5eKMxz4lP8L2shiXcaRRmQX8RR9OSEfaiC
 oYHW636lFx9JrRLF9AdTn3/OCqv/LaggjD+NDstccdnhQrMkcqUuDW+/OiTyV/c7QWTV
 P8Qop5NUWFP3aW98OuqcjfTPqMd3j1EZ4UhH/as4sG7+Dg2kyeA+ohyJrN9HDIFiAZaU
 4sIEvPLa9r5woPuU4mCAFogtFuHVaHD4FGNbE+lilR0l5KmR0rdqCr8BRds9YeaIRMqD
 xFdDqge7pi1COO/OekGdog3X/sRyy2/9/9rmeTDCuxS3yG7ToHEI8hcE6dH9zhuco0SS
 iFYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721134244; x=1721739044;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iU26PLhClMFoNq13xT+fqq7kADjl0F6rGajgxxU34LY=;
 b=UfJYxMDoahnquoW1SVuYLqyZny3IvAmy6dQyXPjDH0uADemSz/27Krkgy5TD7k45HH
 3YAfGM7fvvQvmlmRanqnSQ4KMa2cUOMGHugJmryepwhGqWbHEbQ2F2Z78d09Gn4ap8Yx
 feS94IKoJNFIaA91s9rPZFkO2+ufFNAdSVa6iOUGVaMvUE5Rgxv64/tsbfnIMQVkxksQ
 R54wNUgzkQ/BLE9qohKLLxAFKA6sQXXhnLazhP+vlG5LGKAhvkjOGyW/6BtWdMNWYZS1
 6ELABHGg+BbTAbKNc4xYcyCPpeTz7S5ZqKne/ro9kknkITo4mLO7iiSLOOEW05dVLVtj
 jyWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWnCDfqt1XLJHlGQ1UuSfloiZsPea8KSpPlvejIL6CBRcLUbQa9uTccB44c4aQ7eGkEH+LzvA2Y/cGqgdDFwQLWkYH+F94=
X-Gm-Message-State: AOJu0Yypc5FeofihGxbvpanvyMR9OlaQZA8bXkENaIWuYfUhTGWMG574
 G+OdbPzrA4Eq8gvqGyGQxVn0JJOkEHrAhwND7enn/Fym2w4RzLHdwgHpbIttAyA=
X-Google-Smtp-Source: AGHT+IFYDeKU2qHqSrMcO6aGbc9P8+9s/hK80dXb8ooXK6zyt38hdq2bIecIPsHq8yK58lcuRN0l7A==
X-Received: by 2002:a17:902:d4c6:b0:1fb:4fa4:d24 with SMTP id
 d9443c01a7336-1fc3d9c480amr13270045ad.50.1721134244195; 
 Tue, 16 Jul 2024 05:50:44 -0700 (PDT)
Received: from localhost ([157.82.202.230])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-1fc0eea3cfbsm56005525ad.115.2024.07.16.05.50.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jul 2024 05:50:43 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v3 0/5] target/arm/kvm: Report PMU unavailability
Date: Tue, 16 Jul 2024 21:50:29 +0900
Message-Id: <20240716-pmu-v3-0-8c7c1858a227@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJVslmYC/1WMyw6DIBBFf8WwLg0MitpV/6PpAmGss/ARaInG+
 O9Fu2hcnpt7zsoCesLAbtnKPEYKNA4J1CVjtjPDCzm5xAwE5EJDzaf+w40rWl0i2MIJlp6Tx5b
 mo/J4Ju4ovEe/HNEo9/XsR8kFL0HXElRTVSa/O7MMNF/t2LM9EOEvlVL/JEhSq1Bh3oBTrjhJ2
 7Z9Aei58uDMAAAA
To: Peter Maydell <peter.maydell@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kvm@vger.kernel.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::62b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62b.google.com
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
Changes in v3:
- Dropped patch "target/arm: Do not allow setting 'pmu' for hvf".
- Dropped patch "target/arm: Allow setting 'pmu' only for host and max".
- Dropped patch "target/arm/kvm: Report PMU unavailability".
- Added patch "target/arm/kvm: Fix PMU feature bit early".
- Added patch "hvf: arm: Do not advance PC when raising an exception".
- Added patch "hvf: arm: Properly disable PMU".
- Changed to check for Armv8 before adding PMU property.
- Link to v2: https://lore.kernel.org/r/20240716-pmu-v2-0-f3e3e4b2d3d5@daynix.com

Changes in v2:
- Restricted writes to 'pmu' to host and max.
- Prohibited writes to 'pmu' for hvf.
- Link to v1: https://lore.kernel.org/r/20240629-pmu-v1-0-7269123b88a4@daynix.com

---
Akihiko Odaki (5):
      tests/arm-cpu-features: Do not assume PMU availability
      target/arm/kvm: Fix PMU feature bit early
      target/arm: Always add pmu property for Armv8
      hvf: arm: Do not advance PC when raising an exception
      hvf: arm: Properly disable PMU

 target/arm/cpu.c               |   3 +-
 target/arm/hvf/hvf.c           | 318 +++++++++++++++++++++--------------------
 target/arm/kvm.c               |   7 +-
 tests/qtest/arm-cpu-features.c |  13 +-
 4 files changed, 175 insertions(+), 166 deletions(-)
---
base-commit: f2cb4026fccfe073f84a4b440e41d3ed0c3134f6
change-id: 20240629-pmu-ad5f67e2c5d0

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


