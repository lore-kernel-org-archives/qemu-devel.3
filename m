Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AFADC83038
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 17:09:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWeSX-0005dY-LL; Tue, 01 Jul 2025 13:07:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uWeSR-0005Yd-S2
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 13:07:48 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uWeSM-0003Ug-Q3
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 13:07:47 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3a536ecbf6fso3462789f8f.2
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 10:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751389661; x=1751994461; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NhS7RJ8mQtVOq405DbFlZn2gFT3L5NLST1w6BzSpeM4=;
 b=QtSNi3Fd7ethMioIIRsW2LU55TFPaSYJ662TjnUK52/4yh6Aoh4c2gFIpwbGi5HNDx
 4rNHl4Y85/f5EW6BodxTKhmoI7DAMtl+FheVpERoQCKvdPgz4Agqgo6j9hbN3D8AlZz7
 bKgZxSMb5R7RFowbbTe3+lS/9K02vGFER6eFROsoqyw41XhzW8n5cWHRM9L+o5a6ZtBj
 tpyP812a35hsaiR6oWYpm1J/pNnpGIAmZ5MssySe0sUOPyNTp8iGMFJ3KFLFwn8Y0HG0
 jsHKG3JDLHSqIJ422CLx/rP46W0imOdvxGLL0yIN/rB8Jc5gNQWf1EXXgydOSfWnGthz
 Ym1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751389661; x=1751994461;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NhS7RJ8mQtVOq405DbFlZn2gFT3L5NLST1w6BzSpeM4=;
 b=c/7FSqH89mdMGIYFIqdeVlUAwQcL+/oyyryruhIw5dS59tWhpAQkRo3smruleF+41t
 y1mrH/0BRNqkHppZi/qS2uyT8YjpP6SQ+i6jWdE+H1l5FtZUKVszpfvaSnLBTKPVyCTZ
 6wH+LP/KkDqVX2hvxpxEwKYAi95MkzeSezGLYwRNHk3d2iWzZTxaEU1sRdDHZnisYYSn
 FcHvU4LuCdFK1d+r4f1CdlDUzwYWjd8pYSsoKJUs/phpp5WyKLtk/CgtUGmk6MN+tSsS
 xrKENVZQskRGGriMVvik7MbMXoJv3cmTCDer9lQDfOufEkynqt8OOCR5zDlTL/Upzvab
 9LBw==
X-Gm-Message-State: AOJu0YwhstSHjbw3lwVwR80aqY7PndmW9a7J2vnnFty5gp2oJfSf71zp
 IMNxeJXru5D9KTE52EvOT1FoNERezMWqSRA6INjWf+K56JtjdX+j9aLGLQ+bwcjxiTXon447FNb
 sgy50
X-Gm-Gg: ASbGncvR7c2jypBzMcvMxemOtj254BXx1nKLtEp2R0s2B/OPZSPTU1xHtfp6s7FMav4
 G9kgJPM5Ylisof1rtBR0m9j/ECshfA1h3o9gK+YqoRrMaOaIds2jB946N0M7JOp4isfyJSmfWge
 jX4bG7DLrv30rMD8moCV82vsbx2QXXQUcQmzc/eG93to4MgpKb+7LBbC6Vw0anszo8UNkjUZ5iF
 lls2EAyhux3jeHrbeVASxqeYnVFgy6/aWBMQiYD9FtzK7NYqJ9aNmNiqWpLCB88RAvmdXV+mVH1
 jBLbZvBzhkATvgqfeImTZlvJ/cOgWzilvqB+vWE1TsgXADCPo4ntk4meunXNlUvxdp0c
X-Google-Smtp-Source: AGHT+IHw9QqMbYXfKGge+25GwBrikk/VWM/v8O5cp7bW7JnDgXMIaxdFcxVpLpua942u/17G12JkHw==
X-Received: by 2002:a05:6000:4011:b0:3a4:dd8e:e16b with SMTP id
 ffacd0b85a97d-3a8fe2d3c47mr15073529f8f.20.1751389660859; 
 Tue, 01 Jul 2025 10:07:40 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a88c80bb28sm13475658f8f.43.2025.07.01.10.07.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 10:07:40 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 18/43] hw/arm/virt-acpi-build: Improve comment in build_iort
Date: Tue,  1 Jul 2025 18:06:54 +0100
Message-ID: <20250701170720.4072660-19-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250701170720.4072660-1-peter.maydell@linaro.org>
References: <20250701170720.4072660-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Gustavo Romero <gustavo.romero@linaro.org>

When building the Root Complex table, the comment about the code that
maps the RC node to SMMU node is misleading because it reads
"RC -> SMMUv3 -> ITS", but the code is only mapping the RCs IDs to the
SMMUv3 node. The step of mapping from the SMMUv3 IDs to the ITS Group
node is actually defined in another table (in the SMMUv3 node). So
change the comment to read "RC -> SMMUv3" instead.

Signed-off-by Gustavo Romero <gustavo.romero@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Message-id: 20250628195722.977078-5-gustavo.romero@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/virt-acpi-build.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 9eee284c809..e9cd3fb3511 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -370,7 +370,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
         /* DeviceID mapping index (ignored since interrupts are GSIV based) */
         build_append_int_noprefix(table_data, 0, 4);
 
-        /* output IORT node is the ITS group node (the first node) */
+        /* Output IORT node is the ITS Group node (the first node) */
         build_iort_id_mapping(table_data, 0, 0x10000, IORT_NODE_OFFSET);
     }
 
@@ -407,23 +407,36 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     if (vms->iommu == VIRT_IOMMU_SMMUV3) {
         AcpiIortIdMapping *range;
 
-        /* translated RIDs connect to SMMUv3 node: RC -> SMMUv3 -> ITS */
+        /*
+         * Map RIDs (input) from RC to SMMUv3 nodes: RC -> SMMUv3.
+         *
+         * N.B.: The mapping from SMMUv3 to ITS Group node (SMMUv3 -> ITS) is
+         * defined in the SMMUv3 table, where all SMMUv3 IDs are mapped to the
+         * ITS Group node.
+         */
         for (i = 0; i < smmu_idmaps->len; i++) {
             range = &g_array_index(smmu_idmaps, AcpiIortIdMapping, i);
-            /* output IORT node is the smmuv3 node */
+            /* Output IORT node is the SMMUv3 node. */
             build_iort_id_mapping(table_data, range->input_base,
                                   range->id_count, smmu_offset);
         }
 
-        /* bypassed RIDs connect to ITS group node directly: RC -> ITS */
+        /*
+         * Map bypassed (don't go throught the SMMU) RIDs (input) to ITS Group
+         * node directly: RC -> ITS.
+         */
         for (i = 0; i < its_idmaps->len; i++) {
             range = &g_array_index(its_idmaps, AcpiIortIdMapping, i);
-            /* output IORT node is the ITS group node (the first node) */
+            /* Output IORT node is the ITS Group node (the first node). */
             build_iort_id_mapping(table_data, range->input_base,
                                   range->id_count, IORT_NODE_OFFSET);
         }
     } else {
-        /* output IORT node is the ITS group node (the first node) */
+        /*
+         * Map all RIDs (input) to ITS Group node directly, since there is no
+         * SMMU: RC -> ITS.
+         * Output IORT node is the ITS Group node (the first node).
+         */
         build_iort_id_mapping(table_data, 0, 0x10000, IORT_NODE_OFFSET);
     }
 
-- 
2.43.0


