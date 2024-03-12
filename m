Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF334C54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 13:15:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk1xs-0007w1-JO; Tue, 12 Mar 2024 09:14:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rk1xm-0007s5-LU; Tue, 12 Mar 2024 09:14:38 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rk1xj-0006nU-8y; Tue, 12 Mar 2024 09:14:38 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-5d3912c9a83so3564549a12.3; 
 Tue, 12 Mar 2024 06:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710249272; x=1710854072; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8CqIF9FP8p96gb/VHbQI13ZloGCTmxSrkNwnf/ohF3E=;
 b=SXrY5xGwhmTQy+jS0QVzUsoXSqYcwc9hrbKrJKslutXhx6kQ659dTnGwtAJnxQi/Sm
 h+C1UrC1XStEtBTHbIMn+qwxwgI6mp9ltqrFuXAqPLsHXzOKjmCLKpU1ZxBHR0QAvx02
 oe44ajczv5dRL7iDJjxPOkJ4Ow6vQkhfoTZkStZbvx/XnKRiy4VoibiEcULGjeviP6Q3
 YlMvixJ5wRjuX4tSXwU8rZIAow08c5AE56b6XQFCYgXfVj5Q53nncIF/MsRK6dxQRKqW
 UNAfNoWkKulpu1LvJFA9cE+D+TbRwvk8371SrtzoAdClDY6fUiHNE4tG3YG/hZzp7HFB
 ji1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710249272; x=1710854072;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8CqIF9FP8p96gb/VHbQI13ZloGCTmxSrkNwnf/ohF3E=;
 b=KwoupgJkGDGQRX8sXADE1iK3m8JIPJyLTf9kj1KvBSGhROUg70CDWhPaMYoqo+kf+0
 exmy5FPyUddKMslBzj2l7hMUV4PwJX8KgeIyNQ0qlkIPSyd11UvMgQiapFWwTVwbvibN
 kVFzB9BlXFm9YrGFbZZBhAOORkMkmGj+h53mECHX1PFAtz0FnjJ1AHmUewpwLa+Kfgfb
 fY14EeY0DC6D7eiCuH72CiqKNlRKS6z1U4gOjR4YEqbZypM0dg5KYp1CHgw7ZeiP7OV8
 jzXFLW9QV3nr1KxowR8RDhsf6w3ITGJVvO9cLh5YcbGfAlsjWo4qiToN/nne/P0+v4bV
 qgvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqY9ALEZ1qnmo7X8ALP4p6GsPkn9cbgYDHBLgqLKlm4WHkZIpZLyngRZKxe04TU1Xg+YBQqfwvt5MS4b4ScAEWgisqh5o=
X-Gm-Message-State: AOJu0YwDodvuqOJJ8G7CIKokdUmBVPcTjT8IZSzVrJsBT6i/nFJzjHPX
 rwJXUIkbBrRUi+3HHc8POvSE8DoNVHoi9tNC88MpXtImnVyoyB1xmKXF8YCSEJA=
X-Google-Smtp-Source: AGHT+IERaEWABXWuzVyVTGPfVXTFhjkWyW/l7+tpsbFO+PL53jiamDSUGyNyMflrfZtzFHACBlu5Eg==
X-Received: by 2002:a05:6a20:8922:b0:1a3:f46:853e with SMTP id
 i34-20020a056a20892200b001a30f46853emr180173pzg.60.1710249272107; 
 Tue, 12 Mar 2024 06:14:32 -0700 (PDT)
Received: from wheely.local0.net ([118.208.155.46])
 by smtp.gmail.com with ESMTPSA id
 r15-20020aa78b8f000000b006e64f75c947sm6066084pfd.46.2024.03.12.06.14.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 06:14:31 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PATCH v2 01/10] ppc: Drop support for POWER9 and POWER10 DD1 chips
Date: Tue, 12 Mar 2024 23:14:10 +1000
Message-ID: <20240312131419.2196845-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240312131419.2196845-1-npiggin@gmail.com>
References: <20240312131419.2196845-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x52e.google.com
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
index 40b7c52f7f..50523ead25 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -394,10 +394,8 @@ static const TypeInfo spapr_cpu_core_type_infos[] = {
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


