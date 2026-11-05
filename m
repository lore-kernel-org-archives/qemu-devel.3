Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107D9606A6D0
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 19:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=B2/uH9aW
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xP3Tt-00077w-5P; Thu, 05 Nov 2026 14:50:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xP3Tr-00077K-49
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 14:50:39 -0500
Received: from mail-dl1-x122e.google.com ([2607:f8b0:4864:20::122e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xP3To-00028Q-4k
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 14:50:38 -0500
Received: by mail-dl1-x122e.google.com with SMTP id
 a92af1059eb24-1a3c08d6928so3477917c88.0
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 11:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793908235; x=1794513035; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=IcVukkOhjhrJmjYiZP9Q++vrUopM477cW4C0bRyyBbg=;
 b=B2/uH9aWkkf9K95V1VhQUzvVfsGKUg7I0H4ALFNKd4q/GtoM4PYB1E+5KBAyv+cayi
 A9/aDHrPtu8ZZJeQER5D2b1qPyr5OAvcXgzUJ7xuElrm7aOxeAHWtuVaFOqvOwGqBUIh
 POLVNNWrM90n3OJBEyg1zKB1IWi6SXOP1GUwec3oD78lmvj6zg8M9FHJtup9Q3Zpo6Bl
 O/mUSrVXY0TguHFCRMTAgifDh+K2SbcHEveLX1aMtESmrTznn3HhX4nm32jwPbhl1XOf
 uMjZYgC51NIHMTrn04tOxpj8qbSZ7JEb4y771C/RwQo9qYrix9EnZFYoPvVrHCmHqN0y
 49qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793908235; x=1794513035;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IcVukkOhjhrJmjYiZP9Q++vrUopM477cW4C0bRyyBbg=;
 b=Gw0qsnUWqYgbFwgkaLUlxXOz1MPi+z6FHCOTpnPH+IBmmb34imWqWqTLE9sVgB7+3A
 g5qoTvNpkPcRyq86iBI/bdVYsT3R/WDRthugmVPPLrYpT1HpxWZtZVPQl3bJf/JqIYUI
 35CkNcxjw0axlJZN0gDm7eJtoqvHBbgDiwdbNhgClTMtvqVhU3QOWgRQKvt204sfPhPm
 hsRsTlOTVMD4ACzURctLSvevoGe/Fw6gyMILa7Rclhr8u04cef4axjIMwphKfH1KiOrR
 yz7LzXB77vlxM8HbxHZ47lA/BX2r7r+1MmcZLSkZURKhLCiXzEjCKnLJGjODyvDaDpaa
 q+Gg==
X-Gm-Message-State: APuU4Z9kbypm0rsxaDSe+eZecRyjnLNB4PhQr/ZYKv8HGs92YX+bjW3S
 1KpcLHEV6XQGohetdGFoA8UfMqzkZW1HgPHw4acKXo1uAqdsxMug4s4RbPvJybuIBAA=
X-Gm-Gg: AYBFou03rU75ifmBrE/GMe+sK27tDOTxHzs9X4i+J1elRx5FZe2ocslK3C11Kotmp5J
 OxKD5LKSgmKAJ8Y4nnVXzgZqlC1rwTubGdKnE4amP3wtobQemblMSer3VAu8xbzSFtMAY3iOQDW
 43yHVv/Clx4hQfmAy6yygSLFltbWJMl2XLB+dd62bV8f9MrDfeYYl44XT+r0ah3orNuq1lonHNi
 ZQjUc4fnqQiZTopQk8vRdyu0AEFki88nEiLDnl/17AUFAkf95Z/fHugbqc61RpughBMOrkNdwCo
 jiqrd0OBGRHNAjZ3+4Fvu0N8+mfMv/xbbjaUSNd6bxPfSoko4ymHqI5ghMwLfRUHaU9dyo+0QAF
 zGOKro0rO3c+07Ffdhq7Q4vP5m81lqCYoJMma3kRz04KX7J9y184okGDqvVoYkgyrK3eXki2x/e
 wt+/ohLk9jgzGE+Nts3M/fQLp6aihFDrSnnbdeT8NXTL7Qr67Pz6tqPim/LRFEALjDm1dHCUchq
 ea5Ltvd8E3LRfm8t/Ugzeviop6I6OwtleVF7QEv4ROXrzbpEdfpgtArQENsSlzJfbtAIinYM3T7
 kYurFm7L2N/YP19091ffwQsogM8S6AbdUpSedoqbbYBImd9X
X-Received: by 2002:a05:701b:4515:20b0:1b2:3448:840f with SMTP id
 a92af1059eb24-1b25d31edc9mr24329c88.7.1793908234428; 
 Thu, 05 Nov 2026 11:50:34 -0800 (PST)
Received: from DESKTOP-Q716RM7 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-1b245c1c283sm19459875c88.4.2026.11.05.11.50.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 11:50:33 -0800 (PST)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eric Farman <farman@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 David Hildenbrand <david@kernel.org>, Fam Zheng <fam@euphon.net>,
 qemu-s390x@nongnu.org
Subject: [PATCH v2 3/4] hw/virtio/virtio-mem: Avoid call to target_info() in
 class_init
Date: Fri,  6 Nov 2026 03:49:56 +0800
Message-ID: <20261105194958.1117-4-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
In-Reply-To: <20261105194958.1117-1-luoyonggang@gmail.com>
References: <20261105194958.1117-1-luoyonggang@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::122e;
 envelope-from=luoyonggang@gmail.com; helo=mail-dl1-x122e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

With the multi-target work, the goal is to move to a single
unified QOM tree that applies universally across all targets.
This complements the migration away from instance level
properties to class level properties, which again aims to
ensure a fixed QOM object model for each class.

This requires that properties are either unconditionally
registered in the class, with invalid options rejected
at runtime (for example, during realize()), or that distinct
subclasses are used for specialized use cases that need a
distinct impl for some targets.

It is harmless to have the "unplugged-inaccessible" property registered
unconditionally so take the simple option.

Done by merge virtio_mem_legacy_guests_properties into virtio_mem_properties.
And the rejection handled in virtio_mem_device_realize

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 hw/virtio/virtio-mem.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
index 546ea18b7c..fb02958102 100644
--- a/hw/virtio/virtio-mem.c
+++ b/hw/virtio/virtio-mem.c
@@ -880,7 +880,11 @@ static void virtio_mem_device_realize(DeviceState *dev, Error **errp)
             break;
         }
     } else {
-        vmem->unplugged_inaccessible = ON_OFF_AUTO_ON;
+        if (vmem->unplugged_inaccessible != ON_OFF_AUTO_ON) {
+            error_setg(errp, "'%s' must be 'on' on non-x86 targets",
+                       VIRTIO_MEM_UNPLUGGED_INACCESSIBLE_PROP);
+            return;
+        }
     }
 
     if (vmem->dynamic_memslots &&
@@ -1573,9 +1577,6 @@ static const Property virtio_mem_properties[] = {
                      early_migration, true),
     DEFINE_PROP_BOOL(VIRTIO_MEM_DYNAMIC_MEMSLOTS_PROP, VirtIOMEM,
                      dynamic_memslots, false),
-};
-
-static const Property virtio_mem_legacy_guests_properties[] = {
     DEFINE_PROP_ON_OFF_AUTO(VIRTIO_MEM_UNPLUGGED_INACCESSIBLE_PROP, VirtIOMEM,
                             unplugged_inaccessible, ON_OFF_AUTO_ON),
 };
@@ -1640,9 +1641,6 @@ static void virtio_mem_class_init(ObjectClass *klass, const void *data)
     RamDiscardSourceClass *rdsc = RAM_DISCARD_SOURCE_CLASS(klass);
 
     device_class_set_props(dc, virtio_mem_properties);
-    if (virtio_mem_has_legacy_guests()) {
-        device_class_set_props(dc, virtio_mem_legacy_guests_properties);
-    }
     dc->vmsd = &vmstate_virtio_mem;
 
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
-- 
2.55.0.windows.3


