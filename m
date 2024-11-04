Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87412D11198
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 00:28:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7kqQ-00036q-Pp; Sun, 03 Nov 2024 19:21:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7kqO-0002uq-ES; Sun, 03 Nov 2024 19:21:20 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7kqM-0002gB-RV; Sun, 03 Nov 2024 19:21:20 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2113da91b53so4803485ad.3; 
 Sun, 03 Nov 2024 16:21:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730679677; x=1731284477; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3rCsO8FJ5YATj1kG2TPiwr4tqEmj8/JXNJYFHfroSY0=;
 b=CJaWLkB84OIize0kGnZuxh0zTZFbWV052eXP97Im0Y4NkNuDqC2sah6Oxe2lDaS6Lz
 mjHQzgm2u+Pv1PrVMDgBhIUbJHjctmYp3P0S9eqocARyWD0m/W9WKhnc0rfPDXkIKea0
 p2FH3fcG+TVzeXvzHkFRiH6LklgW9bDTMYJ5hE1eMaF0e/gTa/h13X2bBlY90VefdGux
 UV0DwkECqwUenrHttuV3lKJuTDsJqeYT8LuLsS7mvT7o5Y43rbcdcuKyGuqQcEhMeHgt
 IZ0iQg3PXAmDODCkSXUGH47Pqe8xZsBYWTQ07uL/HX2Xw2ZHK7MeLsbo2VGpFDZh7dV3
 Bg/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730679677; x=1731284477;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3rCsO8FJ5YATj1kG2TPiwr4tqEmj8/JXNJYFHfroSY0=;
 b=rX4JMJUSHFRC8OexujBcYaGcatJMDtklCbK12Vw87RFwmUC1VdXdeeDOMRXGBvW9Mf
 sqLItnlNEWlbUI4VBz2y+y9f2T6B060N5GSjjHSgBaMN3OVeAU7ZRNcMpAZAK6zTLSyH
 4z1Ixm71WyTLQeVs/NW8YQkFN/KP4Ld/r+ttlkg4qUxdZbfmSdaMmW4VtObkQuL9O5vH
 xtxIyh9ovnD2PMrNgsKR3xm+/3FCFCvnUlVgQisJncJnpGtpXAoaDvfiA0DUZWiIyHYX
 ZCK/4UQiWIOHOa1mXTEpzXtALubPEYYdnbPRkJd+/wCHWB65psYRTjPqNNgd6i/XZNQk
 aTkw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjyZA9e11g+BzVoBqkobFSLutovwOxPSFxIEK5eIQvpxidhcoIyups2cezYjV3ipO64EssWP+c2A==@nongnu.org
X-Gm-Message-State: AOJu0YzuJpi3gkM3jbIVFM4M+jJ6tc9I/Q/SLYNaU5ipkccxZfk/aTZL
 cvfbwlmLGxULmfHkeOESDULCYAjGt0Ny1Gn+xFqmD7REnV9ul9+1BJWYcA==
X-Google-Smtp-Source: AGHT+IEZOEakw6vkbz2ZHuR1LmhNcrBL8rVIgn9ONia0MwvUirurq16xAeuBPvyhVqHQK2zLhBiJQg==
X-Received: by 2002:a17:902:e851:b0:20c:94f6:3e03 with SMTP id
 d9443c01a7336-210c6c6a272mr410061685ad.47.1730679676894; 
 Sun, 03 Nov 2024 16:21:16 -0800 (PST)
Received: from wheely.local0.net (124-171-217-17.tpgi.com.au. [124.171.217.17])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7ee45a0081esm5900648a12.59.2024.11.03.16.21.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Nov 2024 16:21:16 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Aditya Gupta <adityag@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Amit Machhiwal <amachhiw@linux.ibm.com>
Subject: [PULL 34/67] ppc/pseries: Add Power11 cpu type
Date: Mon,  4 Nov 2024 10:18:23 +1000
Message-ID: <20241104001900.682660-35-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241104001900.682660-1-npiggin@gmail.com>
References: <20241104001900.682660-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x629.google.com
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

From: Aditya Gupta <adityag@linux.ibm.com>

Add sPAPR CPU Core definition for Power11

Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
Tested-by: Amit Machhiwal <amachhiw@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 docs/system/ppc/pseries.rst | 17 +++++++++++++----
 hw/ppc/spapr_cpu_core.c     |  1 +
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/docs/system/ppc/pseries.rst b/docs/system/ppc/pseries.rst
index a876d897b6..bbc51aa7fc 100644
--- a/docs/system/ppc/pseries.rst
+++ b/docs/system/ppc/pseries.rst
@@ -14,10 +14,19 @@ virtualization capabilities.
 Supported devices
 =================
 
- * Multi processor support for many Power processors generations: POWER7,
-   POWER7+, POWER8, POWER8NVL, POWER9, and Power10. Support for POWER5+ exists,
-   but its state is unknown.
- * Interrupt Controller, XICS (POWER8) and XIVE (POWER9 and Power10)
+ * Multi processor support for many Power processors generations:
+   - POWER7, POWER7+
+   - POWER8, POWER8NVL
+   - POWER9
+   - Power10
+   - Power11
+   - Support for POWER5+ also exists, works with correct kernel/userspace
+ * Interrupt Controller
+    - XICS (POWER8)
+    - XIVE (Supported by below:)
+        - POWER9
+        - Power10
+        - Power11
  * vPHB PCIe Host bridge.
  * vscsi and vnet devices, compatible with the same devices available on a
    PowerVM hypervisor with VIOS managing LPARs.
diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 1a84345f36..ada439e831 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -405,6 +405,7 @@ static const TypeInfo spapr_cpu_core_type_infos[] = {
     DEFINE_SPAPR_CPU_CORE_TYPE("power9_v2.0"),
     DEFINE_SPAPR_CPU_CORE_TYPE("power9_v2.2"),
     DEFINE_SPAPR_CPU_CORE_TYPE("power10_v2.0"),
+    DEFINE_SPAPR_CPU_CORE_TYPE("power11_v2.0"),
 #ifdef CONFIG_KVM
     DEFINE_SPAPR_CPU_CORE_TYPE("host"),
 #endif
-- 
2.45.2


