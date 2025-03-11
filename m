Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4D81C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 09:01:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trvRc-0006QE-SQ; Tue, 11 Mar 2025 04:58:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trvRb-0006P9-Mg
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 04:58:35 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trvRZ-0001Op-R7
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 04:58:35 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-390cf7458f5so4957369f8f.2
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 01:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741683510; x=1742288310; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B+0tgWwdAwpz0uxyNFPOcrNzWIVmRxeEfT3p7qnmkcg=;
 b=zRWeWS3lWjBanQE2IsedAoljfOQOZ+3rxDQGGxgEnXjEEzYanTW2iv8My8HJ5CAVOs
 LW8tTaLnnDbgcsooAfLMZhn1Cu9t05usEQn51IpwUzslzGOli47unujWNvF0oGRf2H89
 44aaM7gqKJuXbaxvDg7q0KZavkGbVnkeYhGoOPx7uiNr8WvtdMXaCioNDHvanqhKraoP
 24tcOXELNoV/oJUg4mj1pA7gAvUin+CRSN27k6jQuPLaNzRxK0evg1B+bPn3yRBooH3f
 NtkG8lpZD7QmqcBn0YS99I04Lyl6kRKGEqwRFtan8hS+Aaspv9rrJISW/LkuhfAsMpuj
 8Wrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741683510; x=1742288310;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B+0tgWwdAwpz0uxyNFPOcrNzWIVmRxeEfT3p7qnmkcg=;
 b=EyVDKcldGQwwyvbEdq5e4P8ql3M0fKVx7nkYkIv0+soydfFep4Zj16j0V3/NuMkxi+
 s4knyXzESHbARtSv0QgDwZIAtocVHUnyxar2Tu7HzNI+LC5CjsI4+bhoY/LOJ4/QsXY5
 sCXP9JgEpkfvFkCG047VV4kPOZfT3Dsj7FEGrbuRSoQ5cg0SU8LqnYCnDYvV+n3VOq1R
 95YfKg8+ops0nntltlswf6QE80Pd2nXhWXYjttCSQUKPKqscmOY0en8MKzQGZ+QTyGBL
 g075GkveksKNZKvhoYW/yTKnFzMjbEY8AuQzkbhxUkgdzgLG50aZyGVccUBbB2ckczjD
 yr6A==
X-Gm-Message-State: AOJu0YzkJTG3NCwlFLwnMnon056RIDSLyQ6t+r6Kasm8cSYqWXiWvedf
 HFgtrDt0qmzxkcTpKgR41x8lsGenyZa4MN8IVCQO6eWanhuzSalqR3oE1qO88m4I2lDcYRHdP7r
 DbCs=
X-Gm-Gg: ASbGncvCX4XbmWSFuFH+QX4TWAYzH0Hhm85cSZ3oWf5J6AYL66Q964Npeoc/JURuqz8
 AynV32tYseqQAUo+riwp9p3FeXrgvB9On5BAhEaN3tIzPDJ0RMOcCrxFgNvNueELbXbP6JXecSR
 PeYyqnJlcwu187Kfs67e3couU6CtdSpOMLazwV8b7Rtgo8L9WWqOSLEDajuUZuuazwBcYuKCAta
 CynHhCRTr/mSRDah+7MOKt3CQg9N80KpHrMgPCS29hQSaFsmlOyobe0WS4ZV30Zv3koQUgOa66k
 pRyHWyoXO81RhMmUcUFLNFXy6b8pZU6joC6ZB/Syw1PPQFvI06iRxO1pPeMuKh1kik3PaDN3qVJ
 oT9B9QvOsgUWQYI/05to=
X-Google-Smtp-Source: AGHT+IHuSDEaxcBmf9TO7/C/9aB2uMVBGBgLIqy9boTJ+UKFbP0qpjTO4XzkR0qV4QuL9bqX0iTqkg==
X-Received: by 2002:a05:6000:1849:b0:391:158f:3d59 with SMTP id
 ffacd0b85a97d-39132d21141mr16525066f8f.15.1741683510140; 
 Tue, 11 Mar 2025 01:58:30 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d025869e7sm21985815e9.7.2025.03.11.01.58.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 11 Mar 2025 01:58:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>, Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Farman <farman@linux.ibm.com>, Peter Xu <peterx@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Eric Auger <eric.auger@redhat.com>
Subject: [PATCH-for-10.0 v3 8/8] hw/vfio: Compile display.c once
Date: Tue, 11 Mar 2025 09:57:43 +0100
Message-ID: <20250311085743.21724-9-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250311085743.21724-1-philmd@linaro.org>
References: <20250311085743.21724-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

display.c doesn't rely on target specific definitions,
move it to system_ss[] to build it once.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Message-Id: <20250308230917.18907-8-philmd@linaro.org>
---
 hw/vfio/meson.build | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
index 5c9ec7e8971..a8939c83865 100644
--- a/hw/vfio/meson.build
+++ b/hw/vfio/meson.build
@@ -5,7 +5,6 @@ vfio_ss.add(files(
 ))
 vfio_ss.add(when: 'CONFIG_PSERIES', if_true: files('spapr.c'))
 vfio_ss.add(when: 'CONFIG_VFIO_PCI', if_true: files(
-  'display.c',
   'pci-quirks.c',
   'pci.c',
 ))
@@ -28,3 +27,6 @@ system_ss.add(when: 'CONFIG_VFIO', if_true: files(
 system_ss.add(when: ['CONFIG_VFIO', 'CONFIG_IOMMUFD'], if_true: files(
   'iommufd.c',
 ))
+system_ss.add(when: 'CONFIG_VFIO_PCI', if_true: files(
+  'display.c',
+))
-- 
2.47.1


