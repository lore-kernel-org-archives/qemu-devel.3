Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B72AC54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 17:04:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk5TN-0004ho-3e; Tue, 12 Mar 2024 12:59:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rk5TG-0004ay-HP; Tue, 12 Mar 2024 12:59:23 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rk5TE-0007x6-Sy; Tue, 12 Mar 2024 12:59:22 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6e6afd8da93so496030b3a.3; 
 Tue, 12 Mar 2024 09:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710262758; x=1710867558; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vQN5FrIT5FE3k5QbCnhPfKluszDyxySXf7QR9utsA34=;
 b=jCJSrY+5ahaCxQ/iiVYorUBq2YmXdNPqoGCQQ5P3TUfdhEt60FKrfP3ZpYZMfjTfMO
 axBK1DPCmCaalh7oaZ09A1Yx/GbNMRvHrAWS7ro8L8Un/BC4rXz99Z0qRgkMjJ/2SV15
 xXIBoQK7OrR4ttWpw8dzv33cOOmkEzEXcpxwjy1TwcYbVn/RSytIuAaquRuig1BgissR
 nAKA2EQ3yOMoSvSt5hLCKQVj6uSkAPJp0pBIzAtIW8/EmGd0oobjjO6up7zvAakZPB+I
 Q3YsftwE1cTVZ7qGdDtSrQ+KfurARlCCJ112nz1uSzgYbMMtqhz/lbcD1W9O9iM9l2CG
 5I1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710262758; x=1710867558;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vQN5FrIT5FE3k5QbCnhPfKluszDyxySXf7QR9utsA34=;
 b=CXhEL3g1yPFs9v4kGmK4GvfwGj/RXBtyLoPnK5m54WndGRVUTq0PPRvb06APv7HJMd
 8cNT0JNb75NLglEfLHDqYdqlKv6QBCTnyq+wM3B5ndBCyV3f2u46fsu1uAVFaXy2IFL/
 IrwfkMFhUw2t4NTJXk9o3ceW6RKEYUoeP2p3EOfXW0S+HM8Vtos43eVg8dQCCbwURndj
 miozoxCaoZtrBAJl3iXsUC/6FGq/6iY/mPJSjS9cr50Geyifu1wSmKmzhSxRcoLVBrkU
 QAOiT1+z+oYEM57fnJdR1c41uAy0UGn5RGXAET+YfUVX42H0KrUejxkRKCMdNb3UYFA7
 kiOg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlCpnlQxWYoiCfneS6cxSCCBlSu7TUMTMNThFEwQYJ5x0y9fBsJsaRbbnA3HpQ3rrvVSlNpavbIx+yG1cJWBwy1pez
X-Gm-Message-State: AOJu0YzaXXYFrqyIHRxiKEspUKJzHmMkzyxQXZaH/LiV6Hsj+g/nAGSV
 fMaklidQqwOCF0clg991NxbXTfjqJwEkg0reuW7IAH4dPsyzitlm61kll9uKcXs=
X-Google-Smtp-Source: AGHT+IFK60JQMRYcSX8UFhpY2xqloPriSHO2VH/ub9lJcgSE60yi1Gf0irI01fYPYTfbG0wkZAeRag==
X-Received: by 2002:a05:6a21:3403:b0:1a3:1048:3dfe with SMTP id
 yn3-20020a056a21340300b001a310483dfemr7310687pzb.38.1710262757982; 
 Tue, 12 Mar 2024 09:59:17 -0700 (PDT)
Received: from wheely.local0.net ([118.208.155.46])
 by smtp.gmail.com with ESMTPSA id
 t34-20020a056a0013a200b006e6a684a6ddsm1362330pfg.220.2024.03.12.09.59.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 09:59:17 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PULL 04/38] ppc: Drop support for POWER9 and POWER10 DD1 chips
Date: Wed, 13 Mar 2024 02:58:15 +1000
Message-ID: <20240312165851.2240242-5-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240312165851.2240242-1-npiggin@gmail.com>
References: <20240312165851.2240242-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The POWER9 DD1 and POWER10 DD1 chips are not public and are no longer of
any use in QEMU. Remove them.

Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/spapr_cpu_core.c |  2 --
 target/ppc/cpu-models.c |  4 ----
 target/ppc/cpu_init.c   |  7 ++-----
 target/ppc/kvm.c        | 11 -----------
 4 files changed, 2 insertions(+), 22 deletions(-)

diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 58cb992609..e7c9edd033 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -398,10 +398,8 @@ static const TypeInfo spapr_cpu_core_type_infos[] = {
     DEFINE_SPAPR_CPU_CORE_TYPE("power8_v2.0"),
     DEFINE_SPAPR_CPU_CORE_TYPE("power8e_v2.1"),
     DEFINE_SPAPR_CPU_CORE_TYPE("power8nvl_v1.0"),
-    DEFINE_SPAPR_CPU_CORE_TYPE("power9_v1.0"),
     DEFINE_SPAPR_CPU_CORE_TYPE("power9_v2.0"),
     DEFINE_SPAPR_CPU_CORE_TYPE("power9_v2.2"),
-    DEFINE_SPAPR_CPU_CORE_TYPE("power10_v1.0"),
     DEFINE_SPAPR_CPU_CORE_TYPE("power10_v2.0"),
 #ifdef CONFIG_KVM
     DEFINE_SPAPR_CPU_CORE_TYPE("host"),
diff --git a/target/ppc/cpu-models.c b/target/ppc/cpu-models.c
index 36e465b390..f2301b43f7 100644
--- a/target/ppc/cpu-models.c
+++ b/target/ppc/cpu-models.c
@@ -728,14 +728,10 @@
                 "POWER8 v2.0")
     POWERPC_DEF("power8nvl_v1.0", CPU_POWERPC_POWER8NVL_v10,         POWER8,
                 "POWER8NVL v1.0")
-    POWERPC_DEF("power9_v1.0",   CPU_POWERPC_POWER9_DD1,             POWER9,
-                "POWER9 v1.0")
     POWERPC_DEF("power9_v2.0",   CPU_POWERPC_POWER9_DD20,            POWER9,
                 "POWER9 v2.0")
     POWERPC_DEF("power9_v2.2",   CPU_POWERPC_POWER9_DD22,            POWER9,
                 "POWER9 v2.2")
-    POWERPC_DEF("power10_v1.0",  CPU_POWERPC_POWER10_DD1,            POWER10,
-                "POWER10 v1.0")
     POWERPC_DEF("power10_v2.0",  CPU_POWERPC_POWER10_DD20,           POWER10,
                 "POWER10 v2.0")
 #endif /* defined (TARGET_PPC64) */
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 1d3d1db7c3..572cbdf25f 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -6350,10 +6350,7 @@ static bool ppc_pvr_match_power9(PowerPCCPUClass *pcc, uint32_t pvr, bool best)
         return false;
     }
 
-    if ((pvr & 0x0f00) == 0x100) {
-        /* DD1.x always matches power9_v1.0 */
-        return true;
-    } else if ((pvr & 0x0f00) == 0x200) {
+    if ((pvr & 0x0f00) == 0x200) {
         if ((pvr & 0xf) < 2) {
             /* DD2.0, DD2.1 match power9_v2.0 */
             if ((pcc->pvr & 0xf) == 0) {
@@ -6536,7 +6533,7 @@ static bool ppc_pvr_match_power10(PowerPCCPUClass *pcc, uint32_t pvr, bool best)
     }
 
     if ((pvr & 0x0f00) == (pcc->pvr & 0x0f00)) {
-        /* Major DD version matches to power10_v1.0 and power10_v2.0 */
+        /* Major DD version matches power10_v2.0 */
         return true;
     }
 
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index bcf30a5400..525fbe3892 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -2369,17 +2369,6 @@ static void kvmppc_host_cpu_class_init(ObjectClass *oc, void *data)
 
 #if defined(TARGET_PPC64)
     pcc->radix_page_info = kvmppc_get_radix_page_info();
-
-    if ((pcc->pvr & 0xffffff00) == CPU_POWERPC_POWER9_DD1) {
-        /*
-         * POWER9 DD1 has some bugs which make it not really ISA 3.00
-         * compliant.  More importantly, advertising ISA 3.00
-         * architected mode may prevent guests from activating
-         * necessary DD1 workarounds.
-         */
-        pcc->pcr_supported &= ~(PCR_COMPAT_3_00 | PCR_COMPAT_2_07
-                                | PCR_COMPAT_2_06 | PCR_COMPAT_2_05);
-    }
 #endif /* defined(TARGET_PPC64) */
 }
 
-- 
2.42.0


