Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D88FC30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 20:25:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOjyG-0000Cf-QX; Tue, 02 Jul 2024 16:19:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjyE-0008NI-5A
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:19:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjyA-0001En-FY
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:19:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719951557;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SUxXXLDnAjmmN0Yi+4nhd+mhBCkrJEwNWiEK8gau7L4=;
 b=GMLPBotiaqGiNn/+ciz0QGW3SlWXAl4V6V0xDZfjEaQtODECCNrnF9TJRGf882JomAN6cu
 Sv0IyRiQC9LbR/mQXQxG+Ql0UvwQRD18CD3yjBFahz7tBspJTqqR47DM6+qBQTQ4Eh2nem
 xssrMHtt/21X2SUQSvRW4IuzfZdn7B0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-258-MepnCy7eMx2jC2SAoShv-w-1; Tue, 02 Jul 2024 16:19:16 -0400
X-MC-Unique: MepnCy7eMx2jC2SAoShv-w-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3673ce35cc7so2627579f8f.0
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 13:19:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719951555; x=1720556355;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SUxXXLDnAjmmN0Yi+4nhd+mhBCkrJEwNWiEK8gau7L4=;
 b=u+qRc+savLJvIdnLy7L9wzPF5SI51wDsey68fLhKUwt2dv3toCV0csRhrdc6NFfcnu
 c9oEzD7uRv4WltPSfza0QQTj2SWF38Zcfv2qMgts3vCfo8Hue57LVUnlwRYKdg8THJG6
 9Yjhm4tjN+kOtrSGy3dgOMNmzxap6Ltycs3Wt+fb7oX/kf3m5CP+yMkKdp39TT/SZju3
 42Me3OQ3h7L2cA/GmRoXVvfMz14XRGSrkJk2rV5UNOaKiHDW5fVruOnh2oriUrZ0q0eZ
 GQ3X2kCq9gFR8duBDeojaaHOUhoQM7ao7vFncHACsSy0RUzo9ADgAs3/vZPk5XQ9Wtqy
 sDDQ==
X-Gm-Message-State: AOJu0YyUgY+PKRs2SweAuL8D5cfwNcNTqIjB1uYBdSI5J+AMw/YxXO11
 zSnt1McCFsh+6kIouGvI/nfoqLSPyhFVGXy96IZpB8cXVHpm1ixbBriFl9GwSc+FY6nqfLZe5ee
 1ZTTzDTiqbip57dRRzZOHNdLXAZ2n7SOxGFB2NxfVQqECQe+hLxB0ZZNvT0hsbKv/o5P9kKYgdJ
 3i3sngL18BplyPmr8fKCpOBLq1mIW3DQ==
X-Received: by 2002:a05:6000:18ae:b0:367:326b:f257 with SMTP id
 ffacd0b85a97d-367756bb71fmr7021041f8f.33.1719951554916; 
 Tue, 02 Jul 2024 13:19:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHf6z6E4lPyxcsAaxUdsn4mSU0HPwtTfrKRzsqDc1SorrMSaKq9nTfavbAHCNMGjprGbL/lzg==
X-Received: by 2002:a05:6000:18ae:b0:367:326b:f257 with SMTP id
 ffacd0b85a97d-367756bb71fmr7021018f8f.33.1719951554406; 
 Tue, 02 Jul 2024 13:19:14 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0e13d4sm14403760f8f.56.2024.07.02.13.19.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 13:19:13 -0700 (PDT)
Date: Tue, 2 Jul 2024 16:19:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Nicolin Chen <nicolinc@nvidia.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Auger <eric.auger@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org
Subject: [PULL v2 60/88] hw/arm/virt-acpi-build: Drop local iort_node_offset
Message-ID: <2e0246a16374c043852fd168cd9ae1ae5534c678.1719951168.git.mst@redhat.com>
References: <cover.1719951168.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1719951168.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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


