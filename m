Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 648D6C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 12:10:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whR6b-0004Wo-2S; Wed, 08 Jul 2026 08:10:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1whR6Z-0004Vj-NA
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 08:10:19 -0400
Received: from mail-wm2-x02.google.com ([2a00:1450:4864:31::2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1whR6W-0005oh-Dd
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 08:10:19 -0400
Received: by mail-wm2-x02.google.com with SMTP id
 5b1f17b1804b1-493b9643ab5so850955e9.1
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 05:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783512614; x=1784117414; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hl3euWWqIvIwDDEEHL5NykZRL5Wv/p/3R5Er6oJzFyY=;
 b=oxqyH6qAS2ZBN4bxpf1egAO2sWujdFC5Ew9c9KPs2vaR+4NBYk3qTNnpLsdTup2a9y
 Zko+9sPm201vxViEysLCOamr9S4zMeVUBuA6B5bNsNS1ISToHYaKRjB5ZbdOYCRmK1TV
 EpsLwsNzH7djzjfashcdO/3GLyEcsOufo5UoP7e/2bGY0VKhhYUHDwJBQFbMlzYWddus
 GPIH7keZwELd58mM7xNn1e/3pU9tOOoSGmZczAkB8VEpo+6KPOiRNyme5piM9VrVciE2
 LREoKmFvYu+2cJp2ftW9PKeOHt3FrB7YxxNTFu6pdzNw4rJZSJOEyDhzi2iAXQFTR7KZ
 YtXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783512614; x=1784117414;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Hl3euWWqIvIwDDEEHL5NykZRL5Wv/p/3R5Er6oJzFyY=;
 b=ctHOZ5pEMVJuhF4NrmRntE8LQoDOC1K6Fd9PWEwH/w/46kaGpBa6JANZKbEnGxm+0s
 /cOGc7UhtHf8Xikxtw0UEeNm0bG+DcAbv69akHeXHAFtDuv4cPfjNNb52YTISN+j9MII
 KH6F9NxdyZ7WgEy7Zn0bfppGSSWRQPQiWVYWUwFqfIulvq+8Gpzdhc9Xi3rXHK3Hd7qb
 4GfnpRGtOZkk5CRvJA3WeOJ5HJOrV5f5VVH59GX5nXJyAUaKG+Gu344+XahBonNy5l+i
 kFAGEddK4h6NFKZFsEjK1VBMvz684DKXr/d1cURUncYxfrzE+j1280MGoyKQuKmevzBB
 2GSw==
X-Gm-Message-State: AOJu0YzGGCm0KMkMWexRtvlAgEXvgwoju3lMS2toWhnEmG01FHoqA5bJ
 Gn6lfoirLa5fJ157qAb6xq5pMf1tUmMQTlEq1myJ7PdCrMhMlSYUAxXL6R9fwy0yIhp/S8jPErc
 5VPx9Vmc5o7eV
X-Gm-Gg: AfdE7clpS2bJnm8jG04Z3z0+IbaBvQfYdIANr8ww/Uf61Q5PKEJybbDDqDychWeDohF
 aLH/vbFkHW8umXg96q69jZxpHwInG3usi+PWRieSPu4kMOs4U3D2olHv4/dLQWHDqsArJ2KlmhB
 B3kNdHPLmLyu5dqcf4Mhzqw1XTu/EUSmvtnH7INi8FtZB/VGTytBr/+RCTW++ubpsGQ/Z3ZE+VK
 SrHkLgxaPGFwEPaTLYNlWrKWThr/RTYI49mrx9iCqzc0PzeckaQguKjZhr9yhyVJsbci9BcS4DR
 ZvDGhuToOXHcNvW+OFBMMtCDinAO/x8brP5GXFYpVVKihKx8ag1g/e/BYiPjBvXFrAol+bwYkAy
 1CK501pQhGjDRmxfxlNLKmU+uqNwF9x1tQq7b0/KR4xP/XPrIvhcVlkxcKczwTB8W7XlCkdPCZr
 sfq78CI4XCwssLCk3dxOiPWa/mU+C4+bhrcNllnf3+XnuYf1bta8VtIET0lIFw4h/5kKWj2phyf
 h6w99yni77IT1ZiA1A+8Y1cypCMFIh/
X-Received: by 2002:a05:600c:a219:b0:493:df58:42b6 with SMTP id
 5b1f17b1804b1-493e68f6840mr12477655e9.36.1783512614359; 
 Wed, 08 Jul 2026 05:10:14 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9e4d780csm43386298f8f.11.2026.07.08.05.10.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 05:10:13 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Isaku Yamahata <isaku.yamahata@linux.intel.com>,
 Sean Christopherson <seanjc@google.com>
Subject: [PATCH 1/3] hw/pci-host/q35.c: Always initialize smram-region even if
 SMM disabled
Date: Wed,  8 Jul 2026 13:10:09 +0100
Message-ID: <20260708121011.1653365-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260708121011.1653365-1-peter.maydell@linaro.org>
References: <20260708121011.1653365-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::2;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm2-x02.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The MCHPCIState::smram_region looks like it ought to be SMM-specific,
but it isn't, because its behaviour is "alias the PCI address space
into system memory at the SMRAM_C_BASE offset", and it must be
enabled for "hide SMRAM", and disabled for "show SMRAM".  If the
SMRAM regions are disabled, we want "hide SMRAM", so we need to
initialize and place this MR.  Do this in the minimal way, by moving
the "bail out of realize if has_smm_ranges is false" check down below
the initialization code.

This fixes a bug where disabling SMM causes the VGA screen to be
blank during seabios output, until the OS graphics driver is
initialized.  This is most obvious for accelerators which have no SMM
support (e.g.  NVMM, HVF, WHPX) as there smm=off is the default, but
you can also see it on KVM and TCG if you explicitly pass smm=off:
 qemu-system-x86_64 -machine q35,accel=kvm,smm=off

The early return is bug-prone, so we can refactor the code to clean
it up, but this is the minimal bug fix for backports, and is what
Debian used to work around this:
 https://salsa.debian.org/qemu-team/qemu/-/commit/6e0766f0f897dc2b75ab87dd59da0d4639bb37ee

Another proposed fix for this:
 https://patchew.org/QEMU/20260413170407.57574-1-mohamed@unpredictable.fr/
also moves an early return in mch_update-smram() and tweaks
mch_update_smram() accordingly.  This shouldn't be necessary, because
in the no-SMM case smram_region should always be enabled and we don't
want to allow the guest to make it disabled.

NetBSD bug: https://gnats.NetBSD.org/59721

Cc: qemu-stable@nongnu.org
Fixes: b07bf7b7 ("q35: Introduce smm_ranges property for q35-pci-host")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/2608
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/pci-host/q35.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
index 4784b8f59b..47e726c41d 100644
--- a/hw/pci-host/q35.c
+++ b/hw/pci-host/q35.c
@@ -596,11 +596,14 @@ static void mch_realize(PCIDevice *d, Error **errp)
                  PAM_EXPAN_BASE + i * PAM_EXPAN_SIZE, PAM_EXPAN_SIZE);
     }
 
-    if (!mch->has_smm_ranges) {
-        return;
-    }
-
-    /* if *disabled* show SMRAM to all CPUs */
+    /*
+     * This memory region looks like it's SMM specific, but it is not.
+     * It's an alias that makes the pci_address_space appear in system
+     * memory at the SMRAM_C_BASE address. The alias is enabled when the
+     * CPU should not see SMRAM, and *disabled* when the low SMRAM should be
+     * visible. So for non-SMM configs we need to create the alias, and
+     * leave it permanently enabled.
+     */
     memory_region_init_alias(&mch->smram_region, OBJECT(mch), "smram-region",
                              mch->pci_address_space, MCH_HOST_BRIDGE_SMRAM_C_BASE,
                              MCH_HOST_BRIDGE_SMRAM_C_SIZE);
@@ -608,6 +611,10 @@ static void mch_realize(PCIDevice *d, Error **errp)
                                         &mch->smram_region, 1);
     memory_region_set_enabled(&mch->smram_region, true);
 
+    if (!mch->has_smm_ranges) {
+        return;
+    }
+
     memory_region_init_alias(&mch->open_high_smram, OBJECT(mch), "smram-open-high",
                              mch->ram_memory, MCH_HOST_BRIDGE_SMRAM_C_BASE,
                              MCH_HOST_BRIDGE_SMRAM_C_SIZE);
-- 
2.43.0


