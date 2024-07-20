Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90AFBC3DA49
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2024 09:32:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sV6Qv-00087a-22; Sat, 20 Jul 2024 05:31:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sV6Qs-00085f-MK
 for qemu-devel@nongnu.org; Sat, 20 Jul 2024 05:31:14 -0400
Received: from mail-io1-xd32.google.com ([2607:f8b0:4864:20::d32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sV6Qq-0006rN-52
 for qemu-devel@nongnu.org; Sat, 20 Jul 2024 05:31:14 -0400
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-80557928673so112563639f.2
 for <qemu-devel@nongnu.org>; Sat, 20 Jul 2024 02:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1721467871; x=1722072671;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=LDU2Zt8gZBQKmgVee2JKdgi66cDuvrO7hSjjib8H/lk=;
 b=gDLxedGJRL2mp0zXQyMrOKjo209VOlpagT4KGP/XikVCQfaOdubnSrJYxFb/4QbKlo
 LycQHosjSk+oybFMQwDBnU+HUozaTY2/4GbQkpNdZ0OdTO+lagoy59Phu7bMJYoCmOZO
 XuxdTWPSDOF7RGudknS4k5AEIUbromOVPZlUgjB6bf75QTHaaXNGAvcyTvta0NfdLsDI
 JBG1qZZ1CASeEgbrtFOKRDCN2dgY9ujh5BHv7aoDe1BQvzlXlp7IKpzq4kmHKqiR5g7H
 gYKNCdTsH12qFbXn7vmL8EAp/tyWaXwJGL1b+X/vw1Z6DRHX+aLCsmJCDd5Zq+VTH7Zz
 84yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721467871; x=1722072671;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LDU2Zt8gZBQKmgVee2JKdgi66cDuvrO7hSjjib8H/lk=;
 b=NayZpw/2ffWqjGu097oSyzXdz1vl1azKgDiLXX6pcxp0Y1k4u8uh0ySLFCCZezMGiY
 fCrCaL4EqDlccJOTuLOayVtaNYkiU5z2T/4nGX8PtbdlBfJKC3ViOwCTwGtL77kOSApe
 NOSc0Va25NpQpQuZrkuO59KMgchkcobvM/wr9i+uKe1B++91/6e/WWSmZzO34aRbD4mF
 nTGSUka5kYoAyLZkMpz/4OeIZtVPeVQWIPHRrlhybYNeOQZus9qWpPynKVnuGNtz8t7L
 5rNX8A0J3egufcvpfFMtU4VblW2qW3sGxtTIf02zXZWrB0j0QYSZ2tBhy0OuJDlPatuV
 S49g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSQvLGWIwAcjcMPxx/ja3/kFRZdHsuSKmBlZit4hs3CSSoRLy/zT800kk7S4O/C+Z98Hb3cFd7F5ab5y2T84Sm9tGcmwU=
X-Gm-Message-State: AOJu0YwSR8qn0xmb199bTIl2QR8Q0VKHTwS0nM/dc7bqoDSnH5zhu7Jn
 zkQefvG5ARTlkdtIjvi4vyUUGkf8o5aU0b7IFsrOS4klPbyn3mGObhxMWUwUCtHfRomp55zcB12
 gD1s=
X-Google-Smtp-Source: AGHT+IHVPm8t/2gzpEDM1KgANQdKw0h2OLMQUsUVee8JWg0S2UQKWLWHEfSx+ctre7NQWEHi+VEghg==
X-Received: by 2002:a05:6e02:180e:b0:397:584d:9b73 with SMTP id
 e9e14a558f8ab-398e47ef554mr27226765ab.7.1721467870772; 
 Sat, 20 Jul 2024 02:31:10 -0700 (PDT)
Received: from localhost ([157.82.204.122])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-70d0fa125acsm538989b3a.190.2024.07.20.02.31.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 20 Jul 2024 02:31:10 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v4 0/6] target/arm/kvm: Report PMU unavailability
Date: Sat, 20 Jul 2024 18:30:48 +0900
Message-Id: <20240720-pmu-v4-0-2a2b28f6b08f@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMiDm2YC/23MSw6DIBSF4a0YxqWBizzsqPtoOkDAysBHoCUa4
 96LdtCYdnhu7vcvKLrgXUSXYkHBJR/90OdRngpkWt0/HPY2bwQESiKgwmP3wtryRkgHhluC8uc
 YXOOnvXK75936+BzCvEcT3a5HnygmWIKoKLBaKV1erZ57P53N0KEtkOCLJBUfBBk1zDFX1mCZ5
 T+I/UEsI2WkoYorDSAPaF3XNzZ7TOABAQAA
To: Peter Maydell <peter.maydell@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kvm@vger.kernel.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::d32;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-io1-xd32.google.com
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
Changes in v4:
- Split patch "target/arm/kvm: Fix PMU feature bit early" into
  "target/arm/kvm: Set PMU for host only when available" and
  "target/arm/kvm: Do not silently remove PMU".
- Changed to define PMU also for Armv7.
- Changed not to define PMU for M.
- Extracted patch "hvf: arm: Raise an exception for sysreg by default"
  from "hvf: arm: Properly disable PMU".
- Rebased.
- Link to v3: https://lore.kernel.org/r/20240716-pmu-v3-0-8c7c1858a227@daynix.com

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
Akihiko Odaki (6):
      target/arm/kvm: Set PMU for host only when available
      target/arm/kvm: Do not silently remove PMU
      target/arm: Always add pmu property for Armv7-A/R+
      hvf: arm: Raise an exception for sysreg by default
      hvf: arm: Properly disable PMU
      hvf: arm: Do not advance PC when raising an exception

 target/arm/cpu.c     |   5 +-
 target/arm/hvf/hvf.c | 302 ++++++++++++++++++++++++++-------------------------
 target/arm/kvm.c     |   7 +-
 3 files changed, 159 insertions(+), 155 deletions(-)
---
base-commit: a87a7c449e532130d4fa8faa391ff7e1f04ed660
change-id: 20240629-pmu-ad5f67e2c5d0

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


