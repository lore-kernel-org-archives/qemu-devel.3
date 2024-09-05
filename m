Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1A95CD4F59
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 08:06:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sm7VX-0000uk-9B; Thu, 05 Sep 2024 04:06:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sm7VV-0000uA-AC
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 04:06:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sm7VT-0007or-LW
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 04:06:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725523578;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=pdU+IHEDIMvyhnf/tMoKrcnMlZSr94IODRDTI9so3B8=;
 b=Zhd4XzLkSzvBLd58mpPl2Sjnh5RIPf2ke68PDhFyra2OpSnPF0v7NysgHZgEDcKeU6RAsZ
 r+rNZ7HkfOBt8jmPeIoQ3L1f4g8uDl+JndBA9lYewADKpMnGP+Dp4NeUAx067tIqxqLVuC
 koRvqCGloUTJMN+WYoP7wBMK8y1snXU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-170-s_hJNJ7GMHGpNpiFDT5ZSg-1; Thu, 05 Sep 2024 04:06:16 -0400
X-MC-Unique: s_hJNJ7GMHGpNpiFDT5ZSg-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-42ba94a0555so3928225e9.0
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2024 01:06:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725523575; x=1726128375;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pdU+IHEDIMvyhnf/tMoKrcnMlZSr94IODRDTI9so3B8=;
 b=jqNZpkQrOiiwBEBzXr0HRS9xNDTfQAgSEsulMH/FcCO0MZI9La6gqyli8kY1XV0k64
 s/RcjZrquDyyTeh3Y028a6sgDWcKMPXIzhoKWjgtRdYd64WgkCN8lzwgCx81zA6DLDwJ
 M09dR3ygUFUeLizPH5TaFSyZpMZS3pyoUEJ2kdghcW6mLeqGEgxAXMijTZu1SKasfBSy
 4IN3CmM5WoHgl01RbBpCKkL6DPksLwQvxVBgfCq8ve0iBvtI/+4B17kQ5njn/i+I+nLE
 tixKn07Xs+pSHnmRcEdym5s4N3KTcjk4RlrwJb+RNhBenvlyR/nPoyEN9VCxmfEry+VS
 5zMA==
X-Gm-Message-State: AOJu0YwaMGomjEhQnwi3nhW7YJzxmAdh5t+uBww7/llVVgqbRlkSpBFp
 mX4elYQ6eQB9I9kkZocds8str3wasRTdxeE+GJf96tXq7VBemR50u/+JD6faKMONXMAcKLuWElw
 YV7z7XCwj/LCFwx3BonHkWVWEuwJs78zVzgHMXbyyg6H6jdONHXh9vCsjc08W+eiD1JQhKUKnap
 l5+SxpooVkdK3wNFK8okQXb1YY1tgEehTrug9SrUA=
X-Received: by 2002:a05:600c:3594:b0:42b:8a35:1ade with SMTP id
 5b1f17b1804b1-42c9548cd66mr35027995e9.27.1725523574984; 
 Thu, 05 Sep 2024 01:06:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGcEysafiEYRr7tWp0nTF39c6BhriVhZz2Q+6VgCsJ42+jouIZBEL7rB8+kRu6FvfqlomuNyg==
X-Received: by 2002:a05:600c:3594:b0:42b:8a35:1ade with SMTP id
 5b1f17b1804b1-42c9548cd66mr35027675e9.27.1725523574308; 
 Thu, 05 Sep 2024 01:06:14 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42c800554d6sm143870295e9.43.2024.09.05.01.06.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Sep 2024 01:06:13 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] hw/arm: remove deprecated dtb-kaslr-seed property
Date: Thu,  5 Sep 2024 10:06:11 +0200
Message-ID: <20240905080611.351796-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 WEIRD_QUOTING=0.001 autolearn=ham autolearn_force=no
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

dtb-kaslr-seed is a deprecated alias of dtb-randomness.
After ~two years it is time to remove it.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/about/deprecated.rst       | 8 --------
 docs/about/removed-features.rst | 8 ++++++++
 docs/system/arm/virt.rst        | 3 ---
 hw/arm/virt.c                   | 6 ------
 4 files changed, 8 insertions(+), 17 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 2175d2eb593..3a3a1445a58 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -223,14 +223,6 @@ is a chance the code will bitrot without anyone noticing.
 System emulator machines
 ------------------------
 
-Arm ``virt`` machine ``dtb-kaslr-seed`` property (since 7.1)
-''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
-
-The ``dtb-kaslr-seed`` property on the ``virt`` board has been
-deprecated; use the new name ``dtb-randomness`` instead. The new name
-better reflects the way this property affects all random data within
-the device tree blob, not just the ``kaslr-seed`` node.
-
 ``pc-i440fx-2.4`` up to ``pc-i440fx-2.12`` (since 9.1)
 ''''''''''''''''''''''''''''''''''''''''''''''''''''''
 
diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index fc7b28e6373..5ae730d02ae 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -924,6 +924,14 @@ The m68k ``dummy`` machine (removed in 2.9)
 
 Use the ``none`` machine with the ``loader`` device instead.
 
+Arm ``virt`` machine ``dtb-kaslr-seed`` property (removed in 9.2)
+'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
+
+The ``dtb-kaslr-seed`` property on the ``virt`` board has been
+deprecated; use the new name ``dtb-randomness`` instead. The new name
+better reflects the way this property affects all random data within
+the device tree blob, not just the ``kaslr-seed`` node.
+
 ``xlnx-ep108`` (removed in 3.0)
 '''''''''''''''''''''''''''''''
 
diff --git a/docs/system/arm/virt.rst b/docs/system/arm/virt.rst
index e67e7f0f7c5..446800c6b55 100644
--- a/docs/system/arm/virt.rst
+++ b/docs/system/arm/virt.rst
@@ -181,9 +181,6 @@ dtb-randomness
   DTB to be non-deterministic. It would be the responsibility of
   the firmware to come up with a seed and pass it on if it wants to.
 
-dtb-kaslr-seed
-  A deprecated synonym for dtb-randomness.
-
 Linux guest kernel configuration
 """"""""""""""""""""""""""""""""
 
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 687fe0bb8bc..bc9d3c15b45 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3197,12 +3197,6 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
                                           "Set off to disable passing random or "
                                           "non-deterministic dtb nodes to guest");
 
-    object_class_property_add_bool(oc, "dtb-kaslr-seed",
-                                   virt_get_dtb_randomness,
-                                   virt_set_dtb_randomness);
-    object_class_property_set_description(oc, "dtb-kaslr-seed",
-                                          "Deprecated synonym of dtb-randomness");
-
     object_class_property_add_str(oc, "x-oem-id",
                                   virt_get_oem_id,
                                   virt_set_oem_id);
-- 
2.46.0


