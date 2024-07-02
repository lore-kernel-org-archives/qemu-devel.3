Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64458C3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 14:13:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOeD4-0003U8-59; Tue, 02 Jul 2024 10:10:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOeCy-00035W-Qn
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:10:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOeCw-0000H5-SX
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:10:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719929410;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SUxXXLDnAjmmN0Yi+4nhd+mhBCkrJEwNWiEK8gau7L4=;
 b=g9QFwDEFaRh+R/WykTlie0CjcwXyBMxtOx+sOxSnqingws+2u81SfXE3ydj2g9YPnAXESq
 cYnEvxflLhwC7GuQgbgvw1KPaa3OAtAKhHjBXSKMBQ5FDd0KJa4sg+Gs0MVupuQsaZ+pxE
 nJbRVdWSNLfxGZ1ZadaZHIPWOrRMxHw=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-601-XoqE_xaUMr6hKXaV3lPEAg-1; Tue, 02 Jul 2024 10:10:08 -0400
X-MC-Unique: XoqE_xaUMr6hKXaV3lPEAg-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2ec55065e52so38904251fa.2
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 07:10:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719929407; x=1720534207;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SUxXXLDnAjmmN0Yi+4nhd+mhBCkrJEwNWiEK8gau7L4=;
 b=L18Ab5u7xZMNHC2PIDM7BJGhz7VOeb0ENPGeYc18Q2nftmGiHuasUDkfeQmDAfmQuc
 5skAEuucpsVofR0nS1g/zbz1OlKTV/5zWUurJ06q+E1hUzr1zqaDD6RCi40T/fdv+eKn
 ZO+wKf118VZVEsir4AMWCh0hBT/ft1t2Ru7j1rkksREv/wBzutRwFIrp1mZpXUZ5tIxM
 6vQsgMUqmzSG/5jVd2KInAu6/PFr5KC5m6j6FSHpJL5TR6uoa3V2fuYFBrTu1jR40ww1
 9NMuLpjFvPxG21RlgY/h5QOqtqL4uvU8cBEDkeuE2fTw6eT6jgjhGZDH2RovHMOihtAQ
 Fwqw==
X-Gm-Message-State: AOJu0YyUajnf9vIZfijoxaJRMBL2WcCcfX5gDWsbjyReHXw90aJMMXza
 K5qXEdQPcFncesMibW+YnS9ofZ92awzJIo+Ei5TrRh5KeZbN1ShGkQISJkfnxSAkzC7uIEjowf9
 bTp5akCkW7lUkPQsYOtCrpqghhAr2ShMc8DP7fRWAxi5FiWeaLaY4W9qjQvJGTRXBcgjt9BoQOX
 f0O8+Jruy9VbT/nFT5tf+vwHLYWG/EuQ==
X-Received: by 2002:a05:6512:33cd:b0:52c:e1e1:ae91 with SMTP id
 2adb3069b0e04-52e8264be16mr6461259e87.11.1719929407029; 
 Tue, 02 Jul 2024 07:10:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5HGFD8Gtl1xhibEEU4DuyU74dPhGRwW3+0HCQ5rRmx1zTOaVGlux2qXBFPeZaNzPYhEArKQ==
X-Received: by 2002:a05:6512:33cd:b0:52c:e1e1:ae91 with SMTP id
 2adb3069b0e04-52e8264be16mr6461215e87.11.1719929405946; 
 Tue, 02 Jul 2024 07:10:05 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0fba0bsm13305331f8f.69.2024.07.02.07.10.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 07:10:05 -0700 (PDT)
Date: Tue, 2 Jul 2024 10:10:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Nicolin Chen <nicolinc@nvidia.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Auger <eric.auger@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org
Subject: [PULL 60/91] hw/arm/virt-acpi-build: Drop local iort_node_offset
Message-ID: <f5b7c97cbf3562a2d52337c6ccba8a73e9dc0c11.1719929191.git.mst@redhat.com>
References: <cover.1719929191.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1719929191.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Nicolin Chen <nicolinc@nvidia.com>

Both the other two callers of build_iort_id_mapping() just directly pass
in the IORT_NODE_OFFSET macro. Keeping a "const uint32_t" local variable
storing the same value doesn't have any gain.

Simplify this by replacing the only place using this local variable with
the macro directly.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Message-Id: <20240619001708.926511-1-nicolinc@nvidia.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/arm/virt-acpi-build.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index b2366f24f9..102e2da934 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -269,7 +269,6 @@ static void
 build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
 {
     int i, nb_nodes, rc_mapping_count;
-    const uint32_t iort_node_offset = IORT_NODE_OFFSET;
     size_t node_size, smmu_offset = 0;
     AcpiIortIdMapping *idmap;
     uint32_t id = 0;
@@ -415,7 +414,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
             range = &g_array_index(its_idmaps, AcpiIortIdMapping, i);
             /* output IORT node is the ITS group node (the first node) */
             build_iort_id_mapping(table_data, range->input_base,
-                                  range->id_count, iort_node_offset);
+                                  range->id_count, IORT_NODE_OFFSET);
         }
     } else {
         /* output IORT node is the ITS group node (the first node) */
-- 
MST


