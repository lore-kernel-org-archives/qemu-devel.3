Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FA97C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 23:31:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubSMZ-0003ca-24; Mon, 14 Jul 2025 19:13:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSJA-0004yF-07
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:10:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSJ7-0005yl-2O
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:10:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752534600;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8OnHhOVb5tqwc8LUpUCNfZ9pZdUybn75vZ88Y9oiuFM=;
 b=c6ZUJ0iyOm5uhGWneJLCxL+nGZ+v7nHYwC+Ng6ooXg1jHlUSnyZCZSyL22ru3C+xHH1IIR
 ZMfhRnjq+jftRENUMNohbRyApBhwbRosyZT0lDW2Gdy0hZe7Eeb7Ew5NbqOmrvnvMQKAsn
 Jg/fvSACWWOUrVys2q1xnyNxgHLuPV0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-421-aP64iBliPL6mThD6lFP7FQ-1; Mon, 14 Jul 2025 19:09:59 -0400
X-MC-Unique: aP64iBliPL6mThD6lFP7FQ-1
X-Mimecast-MFC-AGG-ID: aP64iBliPL6mThD6lFP7FQ_1752534598
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a5780e8137so3071261f8f.1
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 16:09:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752534597; x=1753139397;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8OnHhOVb5tqwc8LUpUCNfZ9pZdUybn75vZ88Y9oiuFM=;
 b=P6WfX5Vt92PRxoszjCuZmr5K0IRp1jGXKxzSYPqcCrdrfKYMvbb1+hd+XhAvGXNNOu
 fxpy/XR2mm1wBIrKB2rAqrQN9QB9msPI3rOWPgGYrtaPOLWug1i8Mf0TKOaDGcJW5ofX
 LO1Q2w9lAzBoKQ4YE/dnEYMwbr+klBi5Ieccq7Gr51QG4xMSpMaay2AdUdtMw8i3D8Ow
 JQffJJ3HNvn/8JdQGz+sHSw6us0EyXQqdp1mvCX0tgm/ZKV6Kcw3uC/K38smCmTAAOc3
 0w4Z+yW+UPaJudy5JYXBIzEqJ4lmvFo5A03QaD2Y2LV5ei83ilbuY4/hTXi3cIl2hgmT
 mHpA==
X-Gm-Message-State: AOJu0Ywx9XbbU3xnxflvFhbl0oMvUKEaElG7PiZT4SaCEhIovF/cQW+G
 QACrB1SsMVzzUZK1WHV6Wevq3yRn3UOgD6ReSTN2rUaoCanoPa7xrMafml2Y8h10lsrZV3FiaAE
 7EAUj267e2YTVqDCwlTtAOhvWOB7WoLmmjc/rPk0T3j2Dzdrq/lmYlyGqvEhwDRLq6MObUEPngY
 qQJtAWzBEQ0x2r1p6ku3eijc48Q5TJMbmRcQ==
X-Gm-Gg: ASbGncsitcf+rYf1TJ/2apTaELRJUvVkXh0Q4ToL46yeZae8YaD4wWoEKRsofj9ckN0
 /2Ur/xDwczfId4Fq9Kq84UIDAF4cdjVA8qC8ydxdfAGgVAZ+xoEcCVPPLqFXhZtOcgb2vzjFZxa
 EhWlbsSssJFQ81WSSiiJcQJC2eNbY3pmkFXkS32CNAX/a72MPzGqdNay6lzm2NbEBZ5Rh//OVwB
 XXKBAc5gudlNmh/hkGHMUNCadUIJLltDNAwavE1cwfrkD+Xml2xFzVDiG8acFRbPs2EMcLUG9qu
 /CHHNBSxQn4cesMroKPqXnhJzp3loDAu
X-Received: by 2002:a05:6000:18a5:b0:3a4:f722:a46b with SMTP id
 ffacd0b85a97d-3b60953aaafmr1007904f8f.15.1752534597575; 
 Mon, 14 Jul 2025 16:09:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFUcOnYSLRgT+io9EMLTBjRHzI1gzcjRJswBQgCjKyZ4HtyFTR0fYMGF0BgyF5kIupMV8jnw==
X-Received: by 2002:a05:6000:18a5:b0:3a4:f722:a46b with SMTP id
 ffacd0b85a97d-3b60953aaafmr1007884f8f.15.1752534597138; 
 Mon, 14 Jul 2025 16:09:57 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8dc9298sm13501125f8f.44.2025.07.14.16.09.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 16:09:56 -0700 (PDT)
Date: Mon, 14 Jul 2025 19:09:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Yicong Yang <yangyicong@hisilicon.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Alireza Sanaee <alireza.sanaee@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PULL 84/97] hw/acpi/aml-build: Set identical implementation flag
 for PPTT processor nodes
Message-ID: <95a4795f913ce458c57c06259421c571e489e924.1752534227.git.mst@redhat.com>
References: <cover.1752534227.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1752534227.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Yicong Yang <yangyicong@hisilicon.com>

Per ACPI 6.5 Table 5.158: Processor Structure Flags, the identical
implementation flag indicates whether all the children processors
of this node share the same identical implementation revision.
Currently Linux support parsing this field [1] and maybe used to
identify the heterogeneous platform. Since qemu only support
homogeneous emulation, set this flag for all the processor node
to indicates the facts when building the PPTT table. Node leaf
is an exception since spec says this flag should be ignored
on leaf nodes by OSPM.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/acpi/pptt.c?h=v6.11-rc1#n810

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
Message-Id: <20250714173146.511-3-alireza.sanaee@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/acpi/aml-build.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index cb817a0f31..9b9be4ea0f 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -2172,7 +2172,8 @@ void build_pptt(GArray *table_data, BIOSLinker *linker, MachineState *ms,
             core_id = -1;
             socket_offset = table_data->len - pptt_start;
             build_processor_hierarchy_node(table_data,
-                (1 << 0), /* Physical package */
+                (1 << 0) | /* Physical package */
+                (1 << 4), /* Identical Implementation */
                 0, socket_id, NULL, 0);
         }
 
@@ -2183,7 +2184,8 @@ void build_pptt(GArray *table_data, BIOSLinker *linker, MachineState *ms,
                 core_id = -1;
                 cluster_offset = table_data->len - pptt_start;
                 build_processor_hierarchy_node(table_data,
-                    (0 << 0), /* Not a physical package */
+                    (0 << 0) | /* Not a physical package */
+                    (1 << 4), /* Identical Implementation */
                     socket_offset, cluster_id, NULL, 0);
             }
         } else {
@@ -2201,7 +2203,8 @@ void build_pptt(GArray *table_data, BIOSLinker *linker, MachineState *ms,
                 core_id = cpus->cpus[n].props.core_id;
                 core_offset = table_data->len - pptt_start;
                 build_processor_hierarchy_node(table_data,
-                    (0 << 0), /* Not a physical package */
+                    (0 << 0) | /* Not a physical package */
+                    (1 << 4), /* Identical Implementation */
                     cluster_offset, core_id, NULL, 0);
             }
 
-- 
MST


