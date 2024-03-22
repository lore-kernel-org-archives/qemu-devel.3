Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E1F5CD11BF
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 18:12:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnjMZ-0006CK-Ni; Fri, 22 Mar 2024 14:11:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rnjMY-0006C5-IG
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 14:11:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rnjMX-0006u2-2t
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 14:11:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711131087;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gr6DvMTBE2B+tdKbPo6SOoHBmsR5QZU2LCb8h2m+93I=;
 b=XZ9glEGAMyAmHEQo+WOJDy2U5H3jSfvKxETTYvc6MpSVzCN8Ipbi7tzBmt9luCTMNQ7vG5
 J55p8ctgOLxVvYQ0fPx5wTMjO3YI8y/SP25uW8OZBvZK/DIECIM10d+wp2VgzwIWrp44OM
 qhIXHd46yNZ+EAwQNSZ9PafSid3y+lA=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-381-ZouAmr8vP2CjstyDfFTsFA-1; Fri, 22 Mar 2024 14:11:25 -0400
X-MC-Unique: ZouAmr8vP2CjstyDfFTsFA-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-5684345c0ebso3809323a12.1
 for <qemu-devel@nongnu.org>; Fri, 22 Mar 2024 11:11:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711131083; x=1711735883;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Gr6DvMTBE2B+tdKbPo6SOoHBmsR5QZU2LCb8h2m+93I=;
 b=FTWumTIi6bOp9HB9MdhO8c5GJ5Y9Fkrfrx6X0Bwo9z1vGjDUg8n/sOR1qWlGz672xT
 mkvSSm0mjajAad0v/3FU4Og+GR+PClH9azUzytoD+wgWy/VmrmbUMofwCgXEbouX0VXp
 ObBCUwhOi0sloymEEjDsF6gQB9JEQW636Y9hL9oqf8B4ilDMm/mpudF/RTutYDMkzjMo
 Gn21l87xzAxo7sa1yBDh1eG/QKaL6lgOLYuluBuVA2em9b6K4mePWFA6Y+4arTiG2g9D
 9ghGIWx3WMvyI5srmwnnoBIB356Jkm1LqdqjGHeHKqejiMCh1xlcdGxmBNyVwyOuOHOZ
 M1Bg==
X-Gm-Message-State: AOJu0YwX5XoMaDIYdG087pdA21xtDp4gn3yt1qol/czz2ErHh6OpEWVQ
 k/A5tj09WneR3+K/Gym5OmSweex7bvhDOaEVi7D5nDL7qOCHwInAoE1vZQt94t/dFQdU4MFjvry
 mXHAKOfwO6If5OBdTreytP7y5fe4VLEDIAN5NT2E/oiJrUlmP/69O7y4IKnDQRzSrr0iTdxdbHH
 4ssilDwAgCEla7g6jwO4/F/OgJGqtRqqR46tjN
X-Received: by 2002:a17:906:19d3:b0:a45:ab98:aec with SMTP id
 h19-20020a17090619d300b00a45ab980aecmr275283ejd.10.1711131082891; 
 Fri, 22 Mar 2024 11:11:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjNy6VyYeVxddMe2k+CEO4oi5BCn1RX4Z3Q2nrstqrxYd2npbm6VCnBxuIEQPL1AZclTUalA==
X-Received: by 2002:a17:906:19d3:b0:a45:ab98:aec with SMTP id
 h19-20020a17090619d300b00a45ab980aecmr275256ejd.10.1711131082517; 
 Fri, 22 Mar 2024 11:11:22 -0700 (PDT)
Received: from [192.168.10.118] ([151.95.49.219])
 by smtp.gmail.com with ESMTPSA id
 d9-20020a1709063ec900b00a4737dbff13sm77565ejj.3.2024.03.22.11.11.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Mar 2024 11:11:19 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: xiaoyao.li@intel.com,
	michael.roth@amd.com,
	david@redhat.com
Subject: [PATCH 01/26] pci-host/q35: Move PAM initialization above SMRAM
 initialization
Date: Fri, 22 Mar 2024 19:10:51 +0100
Message-ID: <20240322181116.1228416-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240322181116.1228416-1-pbonzini@redhat.com>
References: <20240322181116.1228416-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.222,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Isaku Yamahata <isaku.yamahata@intel.com>

In mch_realize(), process PAM initialization before SMRAM initialization so
that later patch can skill all the SMRAM related with a single check.

Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Michael Roth <michael.roth@amd.com>
Message-ID: <20240320083945.991426-18-michael.roth@amd.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/pci-host/q35.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
index 0d7d4e3f086..98d4a7c253a 100644
--- a/hw/pci-host/q35.c
+++ b/hw/pci-host/q35.c
@@ -568,6 +568,16 @@ static void mch_realize(PCIDevice *d, Error **errp)
     /* setup pci memory mapping */
     pc_pci_as_mapping_init(mch->system_memory, mch->pci_address_space);
 
+    /* PAM */
+    init_pam(&mch->pam_regions[0], OBJECT(mch), mch->ram_memory,
+             mch->system_memory, mch->pci_address_space,
+             PAM_BIOS_BASE, PAM_BIOS_SIZE);
+    for (i = 0; i < ARRAY_SIZE(mch->pam_regions) - 1; ++i) {
+        init_pam(&mch->pam_regions[i + 1], OBJECT(mch), mch->ram_memory,
+                 mch->system_memory, mch->pci_address_space,
+                 PAM_EXPAN_BASE + i * PAM_EXPAN_SIZE, PAM_EXPAN_SIZE);
+    }
+
     /* if *disabled* show SMRAM to all CPUs */
     memory_region_init_alias(&mch->smram_region, OBJECT(mch), "smram-region",
                              mch->pci_address_space, MCH_HOST_BRIDGE_SMRAM_C_BASE,
@@ -634,15 +644,6 @@ static void mch_realize(PCIDevice *d, Error **errp)
 
     object_property_add_const_link(qdev_get_machine(), "smram",
                                    OBJECT(&mch->smram));
-
-    init_pam(&mch->pam_regions[0], OBJECT(mch), mch->ram_memory,
-             mch->system_memory, mch->pci_address_space,
-             PAM_BIOS_BASE, PAM_BIOS_SIZE);
-    for (i = 0; i < ARRAY_SIZE(mch->pam_regions) - 1; ++i) {
-        init_pam(&mch->pam_regions[i + 1], OBJECT(mch), mch->ram_memory,
-                 mch->system_memory, mch->pci_address_space,
-                 PAM_EXPAN_BASE + i * PAM_EXPAN_SIZE, PAM_EXPAN_SIZE);
-    }
 }
 
 uint64_t mch_mcfg_base(void)
-- 
2.44.0


