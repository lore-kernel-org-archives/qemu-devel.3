Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A07FC53209
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2026 21:30:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wo6QB-0007x4-HR; Sun, 26 Jul 2026 17:30:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wo6Q5-0007rm-Md
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 17:30:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wo6Q3-0004Lg-U8
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 17:30:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785101399;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+Hp0OLxl0zQZB8EYkfP4LclXhrATBeoc/pZhx+hTGV0=;
 b=DBNmbepbMnIUAZnlUSDQaqVtfXCizgTXe59EItlmdBqgH8F8ArnRxKuhPRssI6HIuyUbUB
 niB+0SM7lRs/xI7hhGYMl24lHvZ7k5Xgda91xn6zYPfURByHOJ7fHqAIQMTCrUyUeWdcs1
 tBxY4hp1Ga9COb+6sZ2NeWW+gNu0jC4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-383-cCtI8yzhOgO1sOod5PIosg-1; Sun, 26 Jul 2026 17:29:57 -0400
X-MC-Unique: cCtI8yzhOgO1sOod5PIosg-1
X-Mimecast-MFC-AGG-ID: cCtI8yzhOgO1sOod5PIosg_1785101396
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-4729d2a64efso1757223f8f.0
 for <qemu-devel@nongnu.org>; Sun, 26 Jul 2026 14:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785101396; x=1785706196; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+Hp0OLxl0zQZB8EYkfP4LclXhrATBeoc/pZhx+hTGV0=;
 b=R8JxkAurGv6QDX6+iSSozN22FsotzfhqIVT972I7OvQDgrdP9mRbWfY92XwOHnKTtM
 yJ5B76V6jtnKDFrUqRZbjoYrvBjVegeSq+cXf+X3and3IPbjbYobgzRbYOHcJ5eO/cAs
 QvHtRdal3j4V9MS5QzQLEyjk81V8RF6E4JLvaklDt1LATNsau8l3L53BqpjzBdMFPHEd
 6RZx5eCTN/rCXo9JWFOLGrYhBJSgrTL3OxVqrBddGTiFzdldZmH6GIg51pBu+sJt+01N
 uZ5fRHsyzb1O+d5phy9TJaYAWfOTjfit7Wwf2/ZXByyL+gWXVDsRPBjSqVlI+ZDW4lL8
 TwEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785101396; x=1785706196;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+Hp0OLxl0zQZB8EYkfP4LclXhrATBeoc/pZhx+hTGV0=;
 b=hlloZKn6JL0IHdUXzuHgvJpMbD+2Ko/aF9n+59nFxrD1N7xxnwDKzn/UFuQx/+hyqE
 LB85zfql/JTKVHBsQK+sLxx00vBlhtQQbCAYFn9wPv+BWSVOEQyis0RaIWQqsjm8DHyo
 3cNYzDzeyR7hRoExfeOBZ8PHjPxKdvb/jXAtv3nYfiHfvMuDgtba4QHoefNlao3rcRAj
 Zm1PkUCe7eny5Djv2fW7AdtDqni4jrncNvAOPTGg0YTf3OTgfAvR1k1UaLxnkKSoAyHp
 j0Rra7h+1WDQ0Mk8WCNRrx3YyyWdcYlU+54irIMLyo3Nwln+ybGWhauOciHp2NBDDVsz
 3iFw==
X-Gm-Message-State: AOJu0Yx11ajULO0r2sCk/luNJ6HzjeVvoGy/jPxHro66mMo5xOQJxct5
 Pz4ELnLoJsWiM0fkRCVgEXCo+m2Zg/J1qWjDCn1m69diybCN2Bz7Mg2Nza1VB5/GHMZTKl62qGP
 InsbPX6QJnQ9DtnCmajIqlj7uGAs/r6Lzl/YDZR6jSZUuvvcQmpjdF18JZ1k7ELKF3mIK47IO5Z
 eidha+fbc5YVEP7ytw6mXNV647u8s7+Ub+3g==
X-Gm-Gg: AR+sD101jhsr8A47ggbdgGgDJbAtCXcu6GB0a6rOeB8nm6sILQFuLVphTG4NdF9lYqU
 XsnkSIcTpHwJz8TTlbQiIT0IFese9wqEY+B6urM4p7AzlLldXYL/rfkHv/7rjLuk/SkUii3JaWD
 ZnYgniQUadhspm79FN0XItidLGFaQdJmqSRzjw97s5MVJmyswqqkxwc3OtZO0lqlJUqEglskzpH
 /EV8jWxlA0AWC7uOJJmNn+HQ76dzLZaA30DttU8q77CdCtxYqp4aKbNGRHty/lD/UYGpneK2LBA
 D1vXSV7VZf91MKLPB2sC52YYA7eJEfimmjO4PRQSDvKwRZae9jMLADvY+pA5B2i596Y7SRPzZu2
 DyeGQjDSVnZChTkvbyRyEaQ==
X-Received: by 2002:a05:600c:4444:b0:495:6b4c:fccc with SMTP id
 5b1f17b1804b1-496b5c7182amr72932475e9.10.1785101396173; 
 Sun, 26 Jul 2026 14:29:56 -0700 (PDT)
X-Received: by 2002:a05:600c:4444:b0:495:6b4c:fccc with SMTP id
 5b1f17b1804b1-496b5c7182amr72932185e9.10.1785101395630; 
 Sun, 26 Jul 2026 14:29:55 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-37-66.inter.net.il. [80.230.37.66])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496b4ed5f93sm272772625e9.1.2026.07.26.14.29.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Jul 2026 14:29:55 -0700 (PDT)
Date: Sun, 26 Jul 2026 17:29:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-stable@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 22/30] hw/pci-host/q35.c: Always initialize smram-region even
 if SMM disabled
Message-ID: <3eeff5c89e0a3618bc9008a35d65fc4810680a8e.1785101237.git.mst@redhat.com>
References: <cover.1785101237.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1785101237.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

From: Peter Maydell <peter.maydell@linaro.org>

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
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260708121011.1653365-2-peter.maydell@linaro.org>
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
MST


