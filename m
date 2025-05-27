Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D0EAC54F30
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 15:03:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJvpR-0005Rr-Ud; Tue, 27 May 2025 11:02:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uJvpO-0005R6-9c
 for qemu-devel@nongnu.org; Tue, 27 May 2025 11:02:54 -0400
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uJvpK-0006Df-8L
 for qemu-devel@nongnu.org; Tue, 27 May 2025 11:02:53 -0400
Received: by mail-qk1-x742.google.com with SMTP id
 af79cd13be357-7c5e1b40f68so356908185a.1
 for <qemu-devel@nongnu.org>; Tue, 27 May 2025 08:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748358167; x=1748962967; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=VQWVqvC08Xp7zGQnvxpeyUf1DukXF9QgCrg60idivA0=;
 b=C6A/piYsUUuVdCxtuWk1bxnCYX+u6qrGgJd3I+SjYloA65Pkzz3OR/K0OGRJgSeQRq
 bmTI2Rlofsxpukb0/4eX02IFUNQosmRdhF1X2d1LGhW1ucJIle84v8ZxzS3f+DgowDO3
 1D6B5QdJlR+nzYL/yrfBKSh+NzecvUJcS1ZSFE6rZAasX74dQpiU3XWqbKtV9gqbHrep
 kHKdydkybJIzNMhIs1AB4OqLJs1Ds2R9X2l+rCbPA+EE88XH19CMTgPaSKM17L38XCqT
 7DnDi5yxJ69imCfh3zIuSuKZURAGeTGOFlka8QaVlZjTAKQFMK3RySKOk+G05/Glruu+
 qAFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748358167; x=1748962967;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VQWVqvC08Xp7zGQnvxpeyUf1DukXF9QgCrg60idivA0=;
 b=aJZipou1imJyIAkExcK3ZXp6a34LPf13qbQtjrmUcruucqjNBbbSqHSq1tN4WYZpdN
 w/5iaxH+8Z80EZTlPrOSWIoqPNS1f1WWKUlJ9n4Cq+6mSTwdx9ElCqc6alTHj6C8qhXy
 /dnqKD7WOxlIi7cWhkVZTWFE6f6SSzph+0vtbScNEXRSgvVP8V5vVZNTDIMGMqDR2Fg/
 zc4QLIbSj5FnseCA9yVC+dLNw9DktRj264TtTfts0qH8CE8h4fvWE3APoyr7P36CY084
 YrMG46sT1LeTuqVEP4qnSGdsZmIycOUMNVWGlEbYEzK93KkqUbLzsrmg6g/eZC3BdJlh
 ZBaQ==
X-Gm-Message-State: AOJu0YyfFf4PCENXzDfO0xa5c8qMtySXQdjm0iGMO8E43fW7BpjlL4m7
 8wQjXBwJMzQhXzqiyhDNsAR5+h6nen9qKUIGxDHB/kOvOPR1ajyldkbockeL1MP9Dq0YMhXarGq
 jNy5Z5jrcwg==
X-Gm-Gg: ASbGncvNBEOxvWPvRNWm+ScJMQyHzlbop0lkqvuuiVVKuL81CObQEEkudSgPk7VZn3n
 kMxRnxGdf68LSAPO2uYreFHHoQ8tVzqZjnzJb/TW0pMbX/x9Ssq91LQ3mRMQrkSg200BTp86lfC
 OTM/6HoU2k+uHkLLwaG3YTGkLleC5ohwJe1BBHR3q4YKuGykEMxuiEgCFmmcjKV8EOIfsfmrpT/
 b0olVve2RtuqBbCoLGHu4fL88M2dxnP5ZGxO80lGxZvuxzpiieVGkEPl5cWA8dbe2pwdR6TLhcL
 Y+TbIev6XFLGGXM9OOu6ywfU3mY8AcB+nQxGkU2T80GUcA2lbRgSEj3E1xbkPMwVeDBSHik0VE+
 drnIeGlHTMDq3VolGGka/5g==
X-Google-Smtp-Source: AGHT+IH7yldyN879XztzSQmAwIGYPh3TLazr8AFzJHZErAgZJ3c2KXqGc8JALi00JgIokb/BxFkSfg==
X-Received: by 2002:a05:620a:2615:b0:7cc:b4cc:115b with SMTP id
 af79cd13be357-7ceecbd8348mr1786940685a.32.1748358167002; 
 Tue, 27 May 2025 08:02:47 -0700 (PDT)
Received: from gromero0.. (200-100-75-183.dial-up.telesp.net.br.
 [200.100.75.183]) by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-4e51e94c9c2sm2189649137.23.2025.05.27.08.02.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 May 2025 08:02:46 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org,
	eric.auger@redhat.com
Cc: qemu-arm@nongnu.org, thuth@redhat.com, gustavo.romero@linaro.org,
 alex.bennee@linaro.org
Subject: [PATCH 0/2] Add functional test for ACPI PCI hotplug
Date: Tue, 27 May 2025 15:02:27 +0000
Message-Id: <20250527150229.1617074-1-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::742;
 envelope-from=gustavo.romero@linaro.org; helo=mail-qk1-x742.google.com
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

This series update the current functional test for PCI hotplug to
support testing the ACPI PCI hotplug.

The SHAs for the linux and initrd images are also update, but probably
we need to point them to immutable images instead of updating the SHAs.

This series must be applied on top of the ACPI PCI hotplug for ARM64
series (yet under review):

https://lists.nongnu.org/archive/html/qemu-devel/2025-05/msg03487.html


Cheers,
Gustavo


Gustavo Romero (2):
  tests/functional/test_aarch64_hotplug_pci: Update SHA
  tests/functional/test_aarch64_hotplug_pci: Add test for ACPI PCI
    hotplug

 tests/functional/test_aarch64_hotplug_pci.py | 28 +++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

-- 
2.34.1


