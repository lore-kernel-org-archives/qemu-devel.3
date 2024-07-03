Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0087C2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 22:50:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sP8mZ-0002L4-4z; Wed, 03 Jul 2024 18:48:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP8mW-0001zF-Km
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 18:48:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP8mT-0005Nc-ES
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 18:48:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720046932;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SUxXXLDnAjmmN0Yi+4nhd+mhBCkrJEwNWiEK8gau7L4=;
 b=da2wTwNDPJqzl07KEHi6mU7b3U3NFxAXamv6JNKvlhLQ80jumT6HJKACnWMhvGn/c1NCMj
 llw4eHv96o3fC8Qzpr1E3xYgLgwS+swT8VISftfPX+xN3pCCIFgtCx+FYrjh9rS6eI99HT
 4Nbye9NeH+YbZMxPseiUuRo8bGSGgPM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-388-hDfBGpSXPzm8HFFD0MPo0w-1; Wed, 03 Jul 2024 18:48:51 -0400
X-MC-Unique: hDfBGpSXPzm8HFFD0MPo0w-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4257dd7d594so62605e9.0
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 15:48:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720046929; x=1720651729;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SUxXXLDnAjmmN0Yi+4nhd+mhBCkrJEwNWiEK8gau7L4=;
 b=TwGMb8fnVmeX3+aIGqKERbk1aCL6dR44JhQX1U3TuOgcPmht8XLg4uZ1UZA+dU+/0l
 Z1q8Ta3CyG92A3oYv633oW4VkXw1T9gK9ikzZ8dfS++CS3Uz4WCMX3zgA2cxsHtMcVIT
 WVcKmywaTlvYZwIEwObQcB78woc4oLDkRCh7zL1kX3ELDLt7Rx840kbtE+h1Yta6vgUA
 1Dq1OMgimj+gKhO0fE5lfsJi9Rx+iEw/HwKTajgIGV2YdzbsCmpWJ4IUS6Is4JuGZ20x
 VlNxHTbMCZo0I5HG8FJXcP9+ySa7A3tKQ1ndx7Z+hbuILkSkbXFrKwlRfliVWoRu2l73
 Ncvg==
X-Gm-Message-State: AOJu0Yyy3tpwb7en+AsxLr6dHTrmGVIkYw9zrgBwNgMdI+4BlFhWq6UY
 N+2glcoMs3hQMht6LOwAVJCykNXDwVZptBpqsdIk04L6QBzfmiMPtmoThfJHrk8ylfvM0r6RxMH
 b1y+7AStqw5Y3KyxpPziemTK1suX1AXYk0pqK0EnPGFYnvSg1XWz9wCbJ4FKDQ/XS3biAeNNVHt
 lrcgjoGlzrHDVAui/tzsp67DEMtIzftw==
X-Received: by 2002:a05:600c:1584:b0:424:90f4:309e with SMTP id
 5b1f17b1804b1-4264a3d83famr342045e9.6.1720046929697; 
 Wed, 03 Jul 2024 15:48:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/rXY0IBdUZd+Gs2Grgok6scRx8soI8zNGjb4IVXH4MiwDUvPEz00YaM8OzBV9Em58di2VCQ==
X-Received: by 2002:a05:600c:1584:b0:424:90f4:309e with SMTP id
 5b1f17b1804b1-4264a3d83famr341895e9.6.1720046929043; 
 Wed, 03 Jul 2024 15:48:49 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:441:91a8:a47d:5a9:c02f:92f2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0cd623sm16964110f8f.16.2024.07.03.15.48.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jul 2024 15:48:47 -0700 (PDT)
Date: Wed, 3 Jul 2024 18:48:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Nicolin Chen <nicolinc@nvidia.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Auger <eric.auger@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org
Subject: [PULL v3 57/85] hw/arm/virt-acpi-build: Drop local iort_node_offset
Message-ID: <e9fd827711ed47edfe8cf23036a56e5a83f2bfda.1720046570.git.mst@redhat.com>
References: <cover.1720046570.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1720046570.git.mst@redhat.com>
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


