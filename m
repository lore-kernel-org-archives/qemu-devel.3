Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76A9CC531D0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 19:20:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woQsJ-0000PR-Sl; Mon, 27 Jul 2026 15:20:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1woQsI-0000LB-5H
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 15:20:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1woQsF-0000cs-Lh
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 15:20:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785180027;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+eny6P5tLUQtN84z7M0HhWHftjc2+DzRoUO9tgnIanU=;
 b=PFn38BDdomAcrXoOqwSyn41DAlmF76OkepcsOcC4fwCUDY7bccSbb3OhH6PtaEavBkq0dC
 whgBRrzN/ibNMc9EJiLnplw5FvqfiEA7e8P7K8+DZeVibWJqFahQvA+0nPan34yOjxmu4F
 hQZVOuVWOCqRhTjIhwj8miraAYkmYkk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-J7g7tbBFOp6no4JI3sYBfQ-1; Mon, 27 Jul 2026 15:20:25 -0400
X-MC-Unique: J7g7tbBFOp6no4JI3sYBfQ-1
X-Mimecast-MFC-AGG-ID: J7g7tbBFOp6no4JI3sYBfQ_1785180024
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-493bfc3b84aso17328045e9.0
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 12:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785180024; x=1785784824; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+eny6P5tLUQtN84z7M0HhWHftjc2+DzRoUO9tgnIanU=;
 b=cSIgxlvj5RJwIu3iGi7JVca2YrQEp4bUsfp1tInEOAx5qbppVpZFSxKV6yLb9m4fAS
 8RKjowlgr2bYrgBjks7zr30P4dSNbw4AwbUYjz//IpHn5nmyCJpiZSntUs8ZesFjv5R9
 OS03YNldCYN/0Sy1d0OY3Qj9C4y94Aju47xE9p08rdZCtJvMaLf7a2moxZYbOhOQs+5J
 iYQuBvYKQdzoZPMGfVmTP1/8dky/nlsv4BlYSXo65JCE2E8FxQ8F0DFLSbfp70lxNA/v
 w5pP4XfIdyXmfLjvlb8w5o9/WUR1n3WQ4jDDhJ3Dn4QhyQOPbXLN1CCXpA/69zFK47UF
 E94A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785180024; x=1785784824;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+eny6P5tLUQtN84z7M0HhWHftjc2+DzRoUO9tgnIanU=;
 b=DsHvO6Ewzmjdude8jVLbog9u8OM1vxStXQZ3ghIRiaxoehpXFFELVQFNAhsWj+gWpb
 3R9K+JgBp1WqTKlkU2BbeZ2So0zbmhf9V3YNewq5NT9bVX+1P9lSxOkFjZI9AIkkMAH0
 Gk0LVDxhNipBPAPOogmyDRn8DTrGcjshvZrVHOfbPES4aRD3UXXkBhZAMFZlopEJbiwN
 4Hr84AB0nhegcxYCDslkNvJIC4iSUl26ZF3ymsgCetIP6AqxnEOKcmUAcf7esR9Mo1nQ
 NxkWuTsLJtH9Wt7RMbblFowrMOnFSACo6TeuyiMwHI5qmI/a/MPsKmg6m8rQVQjQCxuQ
 HoWQ==
X-Gm-Message-State: AOJu0YwSzZIgxLYHYal8/GK5qgr2B9xmCBA+zoe/LXGVWMBIM/LMCoq4
 lRiJLaHdhU4FkOS/BLUxmpDbBHPN3r4QfNzd4AWG78aEv1l5zK6g/7Y1V5JVjIw3FWGB0cVlDby
 A1RAQbF19wXDRsgDGJoUWucneQHwfBKfj20LDQVP3Phv72JGcbio31xPRcLcsoI9Nfz/tbOT2Ly
 CVfIv731ldMy6lAxfoX9PqkDdl65ymSIZpKg==
X-Gm-Gg: AR+sD12owjQ+JjDhU2HivBTHeDGAr9IUF6PJKDQrynNxhpJuQrXBaBcXmHoVTfjqkMy
 kDMlGoyk2sMb7OUfkxvnGVIyFOITeYokg3CVPPBABhAyJLxRGkt9QgDuInLB8x7OYL6bYyu0u9/
 3l6c7D/qbdGIL5Yux8jl9+b0cIkfdh4u2ml9H6/XTZrlQIRzj9rWPo0F38yxkwRlETYTGRR5qzu
 QvyDSZRPv1C/Wzjg4I8nAHbGAY2K8RmmD612CyySogeu08WUB+0kEgUiW9QHfylJVxTqk+yLukj
 RlsR7L5Ap44xrDPWSixoO/0lWQplqusfPCp5DMRjMzXp5H9RyYthz8ZGtt6cXo4SHdy0EHgqnFi
 Q4GI6/stb4jhtvCYZTSC4UA==
X-Received: by 2002:a05:600c:c3db:10b0:495:607e:5ed6 with SMTP id
 5b1f17b1804b1-496c4fd965bmr2975285e9.31.1785180024084; 
 Mon, 27 Jul 2026 12:20:24 -0700 (PDT)
X-Received: by 2002:a05:600c:c3db:10b0:495:607e:5ed6 with SMTP id
 5b1f17b1804b1-496c4fd965bmr2974925e9.31.1785180023567; 
 Mon, 27 Jul 2026 12:20:23 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-28-14.inter.net.il. [80.230.28.14])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496c45cb960sm13504705e9.9.2026.07.27.12.20.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 12:20:23 -0700 (PDT)
Date: Mon, 27 Jul 2026 15:20:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-stable@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL v2 21/30] hw/pci-host/q35.c: Always initialize smram-region
 even if SMM disabled
Message-ID: <7ea56dcc9406b1588699e510439f782da7067d3e.1785179875.git.mst@redhat.com>
References: <cover.1785179875.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1785179875.git.mst@redhat.com>
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
Reported-by: Kroese (gitlab @kroese)
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


