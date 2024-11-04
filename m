Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E84ED1BDF2
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 21:08:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t84HV-0004zi-9B; Mon, 04 Nov 2024 16:06:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t84HT-0004wm-V7
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:06:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t84HS-0005Jw-0k
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:06:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730754392;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dCRrMYXD6Pe/Ubi6i0nnMTLJDmbumZJJyb+bWDGt8WY=;
 b=iIRobordhmQaFOh6vuJ5l3av46B4pIC7holHIY4osSBotAueE/gYdYuZ1JXYFAqbu6BXfN
 sq3u+ng14c8w4iCO91MGwbhlTKdlceTlmw3rKUUcPY0MzzQGEVNByJ2GqIJ0zfs14+zBDD
 QQQ5CNe7WxBMIoiuPXF03H0tF9774gw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-410-757fbEIYPNO_EsmRVpNRWQ-1; Mon, 04 Nov 2024 16:06:30 -0500
X-MC-Unique: 757fbEIYPNO_EsmRVpNRWQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-37d531a19a9so2469287f8f.1
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 13:06:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730754389; x=1731359189;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dCRrMYXD6Pe/Ubi6i0nnMTLJDmbumZJJyb+bWDGt8WY=;
 b=LTFZ/ayhC4N9htgl090UA9iFk3yQIuabdt0N+b7mf1uAELL40eSOUdfT/AbmVuMshZ
 SuXcT0El7vR06lG3+wcu5uThb6DJhzWAwEALASUOTJvSP9MwKQsfmSjDVQN9lXIPHxoG
 Fj0vaqFjgRThj6zvxstzJkLCrysRaAU/Ctscn3djFmpklvhJ3rdBEiXfwRKoWwRcXdNN
 F1BTLVeHYCp5oali9rgrhFlkQLZamCBQ8IObnq6bzec4nfpJcFKuT7mh+0h9EMxsQaEd
 5yQEo0Vr6xFnZdzlb0phWKdjPbPAE77kXGHgN9W+M4XorI1KtVgFPY942zc2/J/lp7Hw
 bXfA==
X-Gm-Message-State: AOJu0YyzznaikwZNSM64ME8eFDD3yNXEaHrNMDdSniggV2UZ0+GOu3cv
 oQpu99KckuEHPHdtgDzymtD3eTO5XduqqaiakU2NcyMl0oVAVOCn57Z8FUIMloJznHz823/iACJ
 I3NIr1g42n7ZyJDKUsuJFM93kO/nDKMHMq2SLm4pKYYv5HpA/2SIbCj31UhhS9jOwVLty9jcU/4
 b5sZAzirNA7WvuEhM1u/W97rxKQOzBwg==
X-Received: by 2002:a5d:5846:0:b0:37d:47b3:7b86 with SMTP id
 ffacd0b85a97d-381be907df1mr12725082f8f.44.1730754388874; 
 Mon, 04 Nov 2024 13:06:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFyaot0ySyGqJIQHM/PQMIiBr+KiNmaRy7e6Zd60Zed3R+ymcV1PrTo/b/4RstJ9i49yxik+g==
X-Received: by 2002:a5d:5846:0:b0:37d:47b3:7b86 with SMTP id
 ffacd0b85a97d-381be907df1mr12725059f8f.44.1730754388483; 
 Mon, 04 Nov 2024 13:06:28 -0800 (PST)
Received: from redhat.com ([2.52.14.134]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c116c13asm14075765f8f.109.2024.11.04.13.06.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 13:06:27 -0800 (PST)
Date: Mon, 4 Nov 2024 16:06:25 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PULL 14/65] hw/acpi: Generic Initiator - add missing object class
 property descriptions.
Message-ID: <df37d496981344c24746be3553d7f6d8a0a9b1b9.1730754238.git.mst@redhat.com>
References: <cover.1730754238.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1730754238.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

>From review of the Generic Ports support.
These properties had no description set so add one.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <20240916174321.1843228-1-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/acpi/pci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/acpi/pci.c b/hw/acpi/pci.c
index a4835ce563..f88f450af3 100644
--- a/hw/acpi/pci.c
+++ b/hw/acpi/pci.c
@@ -137,8 +137,12 @@ static void acpi_generic_initiator_class_init(ObjectClass *oc, void *data)
 {
     object_class_property_add_str(oc, "pci-dev", NULL,
         acpi_generic_initiator_set_pci_device);
+    object_class_property_set_description(oc, "pci-dev",
+        "PCI device to associate with the node");
     object_class_property_add(oc, "node", "int", NULL,
         acpi_generic_initiator_set_node, NULL, NULL);
+    object_class_property_set_description(oc, "node",
+        "NUMA node associated with the PCI device");
 }
 
 static int build_acpi_generic_initiator(Object *obj, void *opaque)
-- 
MST


