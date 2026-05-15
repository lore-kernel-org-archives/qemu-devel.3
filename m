Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36A44CD4F49
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 14:27:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNtUL-0005wW-CG; Fri, 15 May 2026 10:26:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNtU9-0005iz-KD
 for qemu-devel@nongnu.org; Fri, 15 May 2026 10:25:53 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNtU6-0000wQ-Ql
 for qemu-devel@nongnu.org; Fri, 15 May 2026 10:25:52 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-44e1860558fso5989631f8f.0
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 07:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778855149; x=1779459949; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rXHKmMfulXONWFzDkmbeI3DvUTbX1A8YSRTRyTS3EJA=;
 b=GAKPw49bznCkrxuzyZFTNU6FxXHROzkD0/u0mhghf77hnz7DFDTw46XtdIZutCDfVC
 DzM69toIpGFop08ppfN79jU3Tivk0iFpM0LZrup8A6TGWDbiLJcQjc5bjeqSncplt8z+
 nNJN0lLrwadyNJnYumN7U3S67lErgqYCu07eBoz91KGwxFql542fZ+NWvWDJjtn38HqP
 CzLoSNWlk+jUgUVWMW+tp+7TSr3rgAukbswLz7nerzVxAmbJebtY8V4rgnji/U3dEwMJ
 Y2YBP6yzkGRtWOC6IATjudFAQj0LjpdZCStJtc8Y0I54mcGgvg0rxlseIkB6uuYCx5fV
 XN4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778855149; x=1779459949;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=rXHKmMfulXONWFzDkmbeI3DvUTbX1A8YSRTRyTS3EJA=;
 b=eoCMNL9bhqA9PCIFOhguoF1xFblhige7HIc/AX1RpZHNuLOpLYTj+mpKE1akNDfVtR
 pLv8b6xBciZThSbZIHEqWqoD+Rq9Ba4zy732HSA/cSiOgrRMb6g3gjTJRBRWPpbhjEAK
 gq5sPTAyY5KLUnWmxLcNwdnpGVdbIZ6st6+GrofIHa1/PlstCdAig3fZp1GTUAhQbYHn
 V+jnXWly4X+916Hw40CLIN/lKwH2e0A/UMWPuaOiJZlCUyEJAZT+cjiCi512zzskFAQo
 7yJkS59dQzrPSiLnR4HRVQ9AnPOPsyP4Do2zd7OWfuMonuV7dGihWuI/ASNFXSSv0HUi
 93tg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+yKR3mLAP5hGrzkx8djc4CwoBeRE49KUy7FUdYeIzqYCOcilfw8j6c+KZa9p8NOueNPqiUXiT7BsNE@nongnu.org
X-Gm-Message-State: AOJu0YzYs6C+WFnLZMkEyNxqmfqsQyP2THkZqk2Uo1itX5ThyMEoywlE
 l6EtJWly4vRSQjxURm5ZVTzLyJdMLQ0TtbBBcT7myKDQunKQvuRM0mOrjELUBYEB2LZWMqKKLIu
 iNmbL
X-Gm-Gg: Acq92OE8Xo0PUWOIbCWol38XIgfUQD6fe6TyROEAsxvXylUKGeiBgtACPUJjvtx/URB
 cnd42Dlp65D/GKCC08JKTFrPpAdwsDbrPD3RBE1nPrzO2z0xoagRMBJULKGNfv7jAS54jRt6jnN
 i71+ZhqwVEhhLSZweVH+2lKCqLn4L22UsIItI5JfqXYzNBZl6azeitxDWCp0CtPrxcGW9Bw1B1S
 bz9gHBUcxF6Y9oP/6fNWBbzAvx47yy1RLxZkWSIlY5Q0Axe3DBG7LiNcXdinH6gNSG0VAuoWVmj
 yQ3yz62Q1EtJnkJyvtSx9JtIMgwhHy3L2BkocAc0c1zTOCIZ5W0vEXeIrnDt5OezPUH4hsbt0Xr
 8z0hBGkbLwIzAPKmL+PFu6BIPaC5d8dc0HrnKmwRWf7TPIe6667Pk3MlMC33APfxvrwipkRrsiU
 MBTCpMwCk/rYrG9cmTcRLRtLUzDLPOsM8xozMsIZJR8sDN1fizSR61wj6n2DSi4zTOToKXoTi82
 xm4e1y3nXkKfvloHG2j4EjbDEWhxrI=
X-Received: by 2002:a05:6000:2401:b0:43d:7275:c1eb with SMTP id
 ffacd0b85a97d-45e5c5dadeamr5980139f8f.39.1778855148643; 
 Fri, 15 May 2026 07:25:48 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da15a666fsm13560603f8f.36.2026.05.15.07.25.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 07:25:48 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [RFC PATCH 05/14] target/arm/ptw: Flip sense of get_phys_addr_psmav5
 return value
Date: Fri, 15 May 2026 15:25:32 +0100
Message-ID: <20260515142541.571911-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260515142541.571911-1-peter.maydell@linaro.org>
References: <20260515142541.571911-1-peter.maydell@linaro.org>
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/ptw.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 1730caf180..c9563557f9 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -2465,7 +2465,7 @@ static bool get_phys_addr_pmsav5(CPUARMState *env,
         /* MPU disabled.  */
         result->f.phys_addr = address;
         result->f.prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
-        return false;
+        return true;
     }
 
     result->f.phys_addr = address;
@@ -2484,7 +2484,7 @@ static bool get_phys_addr_pmsav5(CPUARMState *env,
     }
     if (n < 0) {
         fi->type = ARMFault_Background;
-        return true;
+        return false;
     }
 
     if (access_type == MMU_INST_FETCH) {
@@ -2497,12 +2497,12 @@ static bool get_phys_addr_pmsav5(CPUARMState *env,
     case 0:
         fi->type = ARMFault_Permission;
         fi->level = 1;
-        return true;
+        return false;
     case 1:
         if (is_user) {
             fi->type = ARMFault_Permission;
             fi->level = 1;
-            return true;
+            return false;
         }
         result->f.prot = PAGE_READ | PAGE_WRITE;
         break;
@@ -2519,7 +2519,7 @@ static bool get_phys_addr_pmsav5(CPUARMState *env,
         if (is_user) {
             fi->type = ARMFault_Permission;
             fi->level = 1;
-            return true;
+            return false;
         }
         result->f.prot = PAGE_READ;
         break;
@@ -2530,10 +2530,10 @@ static bool get_phys_addr_pmsav5(CPUARMState *env,
         /* Bad permission.  */
         fi->type = ARMFault_Permission;
         fi->level = 1;
-        return true;
+        return false;
     }
     result->f.prot |= PAGE_EXEC;
-    return false;
+    return true;
 }
 
 static void get_phys_addr_pmsav7_default(CPUARMState *env, ARMMMUIdx mmu_idx,
@@ -3763,7 +3763,7 @@ static bool get_phys_addr_nogpc(CPUARMState *env, S1Translate *ptw,
                                        result, fi);
         } else {
             /* Pre-v7 MPU */
-            ret = get_phys_addr_pmsav5(env, ptw, address, access_type,
+            ret = !get_phys_addr_pmsav5(env, ptw, address, access_type,
                                        result, fi);
         }
         qemu_log_mask(CPU_LOG_MMU, "PMSA MPU lookup for %s at 0x%08" PRIx32
-- 
2.43.0


