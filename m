Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA13DD11194
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 00:25:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7krG-0005vB-Lx; Sun, 03 Nov 2024 19:22:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7kr2-0005Mu-0t; Sun, 03 Nov 2024 19:22:02 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7kqy-0002jT-NY; Sun, 03 Nov 2024 19:21:58 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-20cf3e36a76so37722515ad.0; 
 Sun, 03 Nov 2024 16:21:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730679714; x=1731284514; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CcJfhU/kdfOpvzZk2Pu8ysuvtr/X2+No2KDA3lj866Y=;
 b=baoWgxLcJkdePD2Y6e3Pw3g4PU3UE0iCvai0KccXIModoZM/v/pKmSzUQSoQ6M0dBI
 UgEKmv+i98mNNg7Ii5wwDVXg3ZWxfCZh7wwKl5BcgClYEJqn92YfixuSGBt2XdnYb/8g
 Y4isFQ4EOYeoFvEjkHhbOF/BdnJryBfubSp4GSmw7nDW6epJMP1YSxEem+Lx7Bmx0XBr
 EKN+40A0II6YMKHfxpt9r4X5R1Xtax3tdSzDScIfwLD+GqdGaj3jPWh2SxBFbO7CfPYk
 KdE06fgn835/A0UW2Sq+u64Sh7seZooQf3uCTjvGyEWfei0fpPmfcbVlHvd8b6tMRVkM
 uM+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730679714; x=1731284514;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CcJfhU/kdfOpvzZk2Pu8ysuvtr/X2+No2KDA3lj866Y=;
 b=Fn4gUtCQAlb5+zJIvufL72/vxp+1FxY8y72CKhhDuezZpPayD5clG17JSv4lnplzFZ
 PctE3yoK8qhng1iwckTsNd+sZc4jlNlBW4nHm8K09TPx9F3BAcdU98cloQrNdbWhHyns
 wRuKrFZ5YHwMZaRgEpiCu5BilJ4atAXM7w1MOYMYHU1t6Ertrc/XLdsYt208z2aiMw7B
 xAvfYIU5xChz+VQfsLxLTER+t+XhRePUCXmhQNgtLIhMnIqho6h0DRxXQ40XJL2EmvYM
 aKcXDW7tEQWQD3sjUbraBiZjoK29noeyLBoubBNhYMiWg8JTugBwcaII6WwC1jjf6uy/
 TMRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDpTRjN0maltvY4iqyzcovSfl3voWJjEkrsV6WqJtWB3fYeJShHffEikNuP+1gauehsd6Lz3QpjA==@nongnu.org
X-Gm-Message-State: AOJu0YxVVewcAoZ1wjSAb0uB45d4w3S3DCCnKWaNFf4oIYdBWchUg/Fd
 TWNSNMq050WGt7mK0rLXqgLQVbbfJIPN6dBqK27Y/IePk/XtbowKBMc4tQ==
X-Google-Smtp-Source: AGHT+IFLJTsKs5H2153MomdXH25od4HS8DPgc+ZaTG8Bz9bkFvI0CKPtGn6hyRU1Qctk5REOmfA4kw==
X-Received: by 2002:a17:902:f68f:b0:20c:8839:c515 with SMTP id
 d9443c01a7336-21103ca485bmr199758095ad.56.1730679713633; 
 Sun, 03 Nov 2024 16:21:53 -0800 (PST)
Received: from wheely.local0.net (124-171-217-17.tpgi.com.au. [124.171.217.17])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7ee45a0081esm5900648a12.59.2024.11.03.16.21.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Nov 2024 16:21:53 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Amit Machhiwal <amachhiw@linux.ibm.com>
Subject: [PULL 45/67] spapr: nested: Add Power11 capability support for Nested
 PAPR guests in TCG L0
Date: Mon,  4 Nov 2024 10:18:34 +1000
Message-ID: <20241104001900.682660-46-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241104001900.682660-1-npiggin@gmail.com>
References: <20241104001900.682660-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62e.google.com
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

From: Amit Machhiwal <amachhiw@linux.ibm.com>

The Power11 architected and raw mode support in Linux was merged via [1]
and the corresponding support in QEMU is waiting to be added by [2]
which in V6 currently.

Add the Power11 capabilities and the required handling in TCG L0
implementation of the "Nested PAPR API".

Note: This patch is based on [2].

[1] https://lore.kernel.org/all/20240221044623.1598642-1-mpe@ellerman.id.au/
[2] https://lore.kernel.org/all/20240731055022.696051-1-adityag@linux.ibm.com/

Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/spapr_nested.c         | 12 +++++++++++-
 include/hw/ppc/spapr_nested.h |  5 ++++-
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/spapr_nested.c b/hw/ppc/spapr_nested.c
index 1b41c8fb8b..7def8eb73b 100644
--- a/hw/ppc/spapr_nested.c
+++ b/hw/ppc/spapr_nested.c
@@ -771,6 +771,7 @@ static void copy_logical_pvr(void *a, void *b, bool set)
 
     if (*pvr_logical_ptr) {
         switch (*pvr_logical_ptr) {
+        case CPU_POWERPC_LOGICAL_3_10_P11:
         case CPU_POWERPC_LOGICAL_3_10:
             pcr = PCR_COMPAT_3_10 | PCR_COMPAT_3_00;
             break;
@@ -1185,6 +1186,12 @@ static target_ulong h_guest_get_capabilities(PowerPCCPU *cpu,
         return H_PARAMETER;
     }
 
+    /* P11 capabilities */
+    if (ppc_check_compat(cpu, CPU_POWERPC_LOGICAL_3_10_P11, 0,
+        spapr->max_compat_pvr)) {
+        env->gpr[4] |= H_GUEST_CAPABILITIES_P11_MODE;
+    }
+
     /* P10 capabilities */
     if (ppc_check_compat(cpu, CPU_POWERPC_LOGICAL_3_10, 0,
         spapr->max_compat_pvr)) {
@@ -1227,7 +1234,10 @@ static target_ulong h_guest_set_capabilities(PowerPCCPU *cpu,
         env->gpr[4] = 1;
 
         /* set R5 to the first supported Power Processor Mode */
-        if (ppc_check_compat(cpu, CPU_POWERPC_LOGICAL_3_10, 0,
+        if (ppc_check_compat(cpu, CPU_POWERPC_LOGICAL_3_10_P11, 0,
+                             spapr->max_compat_pvr)) {
+            env->gpr[5] = H_GUEST_CAP_P11_MODE_BMAP;
+        } else if (ppc_check_compat(cpu, CPU_POWERPC_LOGICAL_3_10, 0,
                              spapr->max_compat_pvr)) {
             env->gpr[5] = H_GUEST_CAP_P10_MODE_BMAP;
         } else if (ppc_check_compat(cpu, CPU_POWERPC_LOGICAL_3_00, 0,
diff --git a/include/hw/ppc/spapr_nested.h b/include/hw/ppc/spapr_nested.h
index 3b5cd993c2..e420220484 100644
--- a/include/hw/ppc/spapr_nested.h
+++ b/include/hw/ppc/spapr_nested.h
@@ -211,11 +211,14 @@ typedef struct SpaprMachineStateNestedGuest {
 #define H_GUEST_CAPABILITIES_COPY_MEM 0x8000000000000000
 #define H_GUEST_CAPABILITIES_P9_MODE  0x4000000000000000
 #define H_GUEST_CAPABILITIES_P10_MODE 0x2000000000000000
-#define H_GUEST_CAP_VALID_MASK        (H_GUEST_CAPABILITIES_P10_MODE | \
+#define H_GUEST_CAPABILITIES_P11_MODE 0x1000000000000000
+#define H_GUEST_CAP_VALID_MASK        (H_GUEST_CAPABILITIES_P11_MODE | \
+                                       H_GUEST_CAPABILITIES_P10_MODE | \
                                        H_GUEST_CAPABILITIES_P9_MODE)
 #define H_GUEST_CAP_COPY_MEM_BMAP     0
 #define H_GUEST_CAP_P9_MODE_BMAP      1
 #define H_GUEST_CAP_P10_MODE_BMAP     2
+#define H_GUEST_CAP_P11_MODE_BMAP     3
 #define PAPR_NESTED_GUEST_MAX         4096
 #define H_GUEST_DELETE_ALL_FLAG       0x8000000000000000ULL
 #define PAPR_NESTED_GUEST_VCPU_MAX    2048
-- 
2.45.2


