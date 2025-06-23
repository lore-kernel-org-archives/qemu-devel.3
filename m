Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6B97C7115B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 14:00:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uThh6-0008Fv-10; Mon, 23 Jun 2025 09:58:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uThh4-0008FS-AY
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 09:58:42 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uThh0-0007Hj-Qw
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 09:58:42 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-7490702fc7cso2138162b3a.1
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 06:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750687117; x=1751291917; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QHmEaaRegYwFGlGoVTGRYvzmrkIrypDwOG7loJLMkas=;
 b=Tv2cBmAONAeOiVmp3jTu7az+lR9QWIVg4qa4HOZ2BxWaiYPgUOLSuXtWpJPvjMp1W4
 JmCBvzCAb1dQocbavhLpZ1/Qh1/3wUBcrXGsU21iahi+lQ3jatDp3bbnx9v9FgT6y773
 FCBiQKe6TBdgEbfmRd6vQAtjRa2TTznDZqrqxPvzc1A7LC8gv27lghtFCr87+DP2ZRZS
 1e0/8CyLH9QADC9xC6ka8oegbYHL+e/MzgFM1aWsozbtq4hi+Mp9r63H19Gq28TCdiCf
 QhvsOqHDXXdkl+8w3Wy2Wz6Jj4uP4Owwnx/2zpJBwxkPYNEJPEMwBv9AIUSQ+IOLb/d7
 7BAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750687117; x=1751291917;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QHmEaaRegYwFGlGoVTGRYvzmrkIrypDwOG7loJLMkas=;
 b=lR7MShJ4rQMqiPnQHPKtHV8Tw0cN/VpQ5QIja+ZPUu1UxRsntGYQsl321d5lsvOMHi
 M2e7h1o2wkrIg01a30zPA3VjCFdZJNYfMDyr4JHc6/wrOTyVGz1kgmLKzm7o7+Oi8vCY
 5Xv2XQB9BkrWLUgD5vuvzCWNPYLdALX9Xow+Eqbm2nfF6mGZeUP/tz8KGL2aksO+x98g
 p60LYxnfRo+opz3QgKPaxRdpadGwypBPFj5OtCzUSEV/oXLlzIDjh0ZoQDa8tmty5Rse
 oykQ7QiV/KgYK0m09wWXbBP9XhBB17T8EL+YrRfygzeE3lzCQ2KzC3WOpiecvMv/OdS1
 RrWg==
X-Gm-Message-State: AOJu0Yw+4HyiFbZPLk8pbvohf70dpCgF8FLZ1qv5rJ9WljEg6m2AM7+W
 9gZkc0h4sN6azmICPMiDr+9sWSZ7BTcwIRQEOnI6AnPL6qIu9HouOIIx0oD9ou4m9WrEB9Bi6I0
 utSrV
X-Gm-Gg: ASbGnctdcMt/PPOnrxuB/Zes+WQMDfibtU1MsYz21UmvIJGI0tIdGvgjgueugsc67cd
 R1FqiUdlG8cwO1r0oU8pNrW/gxaelJnUKFAtopmGh4OhclhzB07CvGELlgoHDlGamd+3wnYbnY5
 aOB6o4mpG7aOrnLec9zjW7br0knmNhRGvlGqwEcoojzcmNGCZGi50jRF5nJ2WFVJANK+qTyr4T1
 vliW/eXjz6o+yYAnmJ/MWw+ZMxS7S0N4BWqnefvy//8KEnmsQsWzNmZJn/6JdZBHakblkHg8mdr
 It/NeR/bhJyvcYXEYw9gstDDOMGt89PDZT7btNxxPCrAH4JQ34mqFN7t2OfiP2/GpXM=
X-Google-Smtp-Source: AGHT+IErWAFwMzcz/MjBmkN38EukFVknW17niV69zGOxvdKP40Jbzg6+ebXlnwGxu8z2XQPLIQXvZw==
X-Received: by 2002:a05:6a21:a342:b0:21f:53a9:b72c with SMTP id
 adf61e73a8af0-22026e9c88cmr19082150637.38.1750687117248; 
 Mon, 23 Jun 2025 06:58:37 -0700 (PDT)
Received: from gromero0.. ([186.215.58.88]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b31f119eb64sm8063490a12.31.2025.06.23.06.58.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Jun 2025 06:58:36 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, eric.auger@redhat.com, philmd@linaro.org,
 mst@redhat.com
Cc: qemu-arm@nongnu.org, alex.bennee@linaro.org, gustavo.romero@linaro.org,
 udo@hypervisor.org, ajones@ventanamicro.com, peter.maydell@linaro.org,
 imammedo@redhat.com, anisinha@redhat.com
Subject: [PATCH v5 4/9] hw/arm/virt-acpi-build: Improve comment in build_iort
Date: Mon, 23 Jun 2025 13:57:44 +0000
Message-Id: <20250623135749.691137-5-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250623135749.691137-1-gustavo.romero@linaro.org>
References: <20250623135749.691137-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

When building the Root Complex table, the comment about the code that
maps the RC node to SMMU node is misleading because it reads
"RC -> SMMUv3 -> ITS", but the code is only mapping the RCs IDs to the
SMMUv3 node. The step of mapping from the SMMUv3 IDs to the ITS Group
node is actually defined in another table (in the SMMUv3 node). So
change the comment to read "RC -> SMMUv3" instead.

Signed-off-by Gustavo Romero <gustavo.romero@linaro.org>
---
 hw/arm/virt-acpi-build.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 9eee284c80..e9cd3fb351 100644
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
2.34.1


