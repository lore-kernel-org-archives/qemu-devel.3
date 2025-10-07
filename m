Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3BE1CCA470
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 14:23:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v68R0-00066n-Q2; Tue, 07 Oct 2025 10:12:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v68Qs-0005zQ-EQ
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 10:12:50 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v68Qc-0002O1-7z
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 10:12:50 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-46e33b260b9so60043455e9.2
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 07:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759846347; x=1760451147; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hwPb2YzQ1UwPlk42tppCYJQXDB/lXxWTd86sY0+xMP4=;
 b=N5DPfGcrwPTpfJXq844x4GP6kPQopF/sMQUbu7THtZPybT6cFtsQ4Lr2J6WzRF4VeW
 NajDSWNnjfQRdjenTJbheFlN4xnnemQ8OqXPUUgvDuBmnr6U1mc94DLpQjbo0Vw6GZOf
 2bXjXMPvC7dcR+sRk4jtMPEywDdMXRAH+pjjRbJ8cLy848/McrCtTfxH3UxJe+ToZb3p
 yQ+GKNO0nNFh0IHO1kQ9c7QfOrMSKwqqfcXNN7fEAQdOc6YJqSG1FQi2TTik4lrIyx+g
 9N/lv8zaNrpdVe8QBmbS9ta8YN82M+DQi7OZ1de5l1DlrlplgoKFw5jD/bEZMNgLvATL
 4CjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759846347; x=1760451147;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hwPb2YzQ1UwPlk42tppCYJQXDB/lXxWTd86sY0+xMP4=;
 b=I9/Hz7FLP7UDl1C8pC8Ou5n0YK3pk72JOULL0jgOZ3Na3Mh8kO9Sir9nD5O8+Tc3b0
 LgiaAcfRMlnWrIceeUtcJ6qWK/Fu3OJntQMIy4Re2sWU0oVa6qebvUyZThr25fFPiCk4
 joO1YSr+gQPFwb7neRVHPZvKIj0X2TwqYLA3ilfT0AmXV3y+FmLGDvyul/YBOdu2+e2k
 P636nDMxJg4IXg7w3b/kOpREFcEZlzATwCoQVtR7ZnY63OMikYHZYmle5r7dS9hWiQd/
 jwIrvUMx9WNXYUNcaGaiPwIFByfFzgBoTsVkXTnJ5uY3Owz6/pZscvHusjxZwiq3zg82
 DmYA==
X-Gm-Message-State: AOJu0YzF8kAjJsxK9gI9L04ywTUePdklY50r1bionrIDknaMQNvPG2BY
 nIzQYyb6EHfZlJ77WHcY8fHhhgYIB0kB5LzZqb3SX3MPWyQo6UWtCgmjve1QAvlpTSIrBMIAvWh
 Km+OI
X-Gm-Gg: ASbGncvuHM6Mi8E6YyqBj+/UzTvafjZrK2gENHeUzPh9jAQTI+Z8MjFiFOQVq6AU/yg
 oEEkCBNBBaCgkU3xTPTJ9aLdcwx6y1/eAGEGZQ4rRKz4q+ie2vdr1+riHOgtxMX2ftEHQtFvGe1
 SvqOaioT56j26Vjf7rW3VJI0nmUSoEQkEzuwA0CXXl0Stt9DbixCwcSHEzG4wbmYJu0w+OI57Q7
 DFv5bRn25ZVZ06UtQDOM1QJuS00SXH9beDX0rm2wEvSd6gQvpg53Z7ujsmeBYXse9rjnucVfh00
 s3BSvzerYZC+qIsIMWpP39md5gSY5K4gglBTuePGt2q8wIg7b7K+ZH3BbB98LBJ39cpwLlHUXpX
 rJOWPDQkHNl5cyoqrqJrrOhgIObiEy88ShTI07iMTdq71FjQ9yKAjePmh
X-Google-Smtp-Source: AGHT+IHssEH2IgP411ijaNXMrHo8erzP68f4RvVGSy1HOzF++LqB9AS5oQRyk2p4f58StZbigdNAhA==
X-Received: by 2002:a05:600c:8b22:b0:46e:4937:dd1b with SMTP id
 5b1f17b1804b1-46e7113f670mr144496615e9.17.1759846346857; 
 Tue, 07 Oct 2025 07:12:26 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e78c5d290sm167037135e9.0.2025.10.07.07.12.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Oct 2025 07:12:25 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 56/62] target/arm: Add cur_space to S1Translate
Date: Tue,  7 Oct 2025 15:11:16 +0100
Message-ID: <20251007141123.3239867-57-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251007141123.3239867-1-peter.maydell@linaro.org>
References: <20251007141123.3239867-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

We've been updating in_space and then using hacks to access
the original space.  Instead, update cur_space and leave
in_space unchanged.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-id: 20250926001134.295547-5-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/ptw.c | 37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 6344971fa64..1cafe8f4f7b 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -36,8 +36,6 @@ typedef struct S1Translate {
     /*
      * in_space: the security space for this walk. This plus
      * the in_mmu_idx specify the architectural translation regime.
-     * If a Secure ptw is "downgraded" to NonSecure by an NSTable bit,
-     * this field is updated accordingly.
      *
      * Note that the security space for the in_ptw_idx may be different
      * from that for the in_mmu_idx. We do not need to explicitly track
@@ -52,6 +50,11 @@ typedef struct S1Translate {
      *    value being Stage2 vs Stage2_S distinguishes those.
      */
     ARMSecuritySpace in_space;
+    /*
+     * Like in_space, except this may be "downgraded" to NonSecure
+     * by an NSTable bit.
+     */
+    ARMSecuritySpace cur_space;
     /*
      * in_debug: is this a QEMU debug access (gdbstub, etc)? Debug
      * accesses will not update the guest page table access flags
@@ -587,7 +590,8 @@ static bool S1_ptw_translate(CPUARMState *env, S1Translate *ptw,
          * From gdbstub, do not use softmmu so that we don't modify the
          * state of the cpu at all, including softmmu tlb contents.
          */
-        ARMSecuritySpace s2_space = S2_security_space(ptw->in_space, s2_mmu_idx);
+        ARMSecuritySpace s2_space
+            = S2_security_space(ptw->cur_space, s2_mmu_idx);
         S1Translate s2ptw = {
             .in_mmu_idx = s2_mmu_idx,
             .in_ptw_idx = ptw_idx_for_stage_2(env, s2_mmu_idx),
@@ -630,7 +634,7 @@ static bool S1_ptw_translate(CPUARMState *env, S1Translate *ptw,
     }
 
     if (regime_is_stage2(s2_mmu_idx)) {
-        uint64_t hcr = arm_hcr_el2_eff_secstate(env, ptw->in_space);
+        uint64_t hcr = arm_hcr_el2_eff_secstate(env, ptw->cur_space);
 
         if ((hcr & HCR_PTW) && S2_attrs_are_device(hcr, pte_attrs)) {
             /*
@@ -641,7 +645,7 @@ static bool S1_ptw_translate(CPUARMState *env, S1Translate *ptw,
             fi->s2addr = addr;
             fi->stage2 = true;
             fi->s1ptw = true;
-            fi->s1ns = fault_s1ns(ptw->in_space, s2_mmu_idx);
+            fi->s1ns = fault_s1ns(ptw->cur_space, s2_mmu_idx);
             return false;
         }
     }
@@ -657,7 +661,7 @@ static bool S1_ptw_translate(CPUARMState *env, S1Translate *ptw,
     fi->s2addr = addr;
     fi->stage2 = regime_is_stage2(s2_mmu_idx);
     fi->s1ptw = fi->stage2;
-    fi->s1ns = fault_s1ns(ptw->in_space, s2_mmu_idx);
+    fi->s1ns = fault_s1ns(ptw->cur_space, s2_mmu_idx);
     return false;
 }
 
@@ -844,7 +848,7 @@ static uint64_t arm_casq_ptw(CPUARMState *env, uint64_t old_val,
             fi->s2addr = ptw->out_virt;
             fi->stage2 = true;
             fi->s1ptw = true;
-            fi->s1ns = fault_s1ns(ptw->in_space, ptw->in_ptw_idx);
+            fi->s1ns = fault_s1ns(ptw->cur_space, ptw->in_ptw_idx);
             return 0;
         }
 
@@ -1224,7 +1228,7 @@ static bool get_phys_addr_v6(CPUARMState *env, S1Translate *ptw,
             g_assert_not_reached();
         }
     }
-    out_space = ptw->in_space;
+    out_space = ptw->cur_space;
     if (ns) {
         /*
          * The NS bit will (as required by the architecture) have no effect if
@@ -1254,7 +1258,7 @@ static bool get_phys_addr_v6(CPUARMState *env, S1Translate *ptw,
         }
 
         result->f.prot = get_S1prot(env, mmu_idx, false, user_rw, prot_rw,
-                                    xn, pxn, result->f.attrs.space, out_space);
+                                    xn, pxn, ptw->in_space, out_space);
         if (ptw->in_prot_check & ~result->f.prot) {
             /* Access permission fault.  */
             fi->type = ARMFault_Permission;
@@ -1857,7 +1861,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
      * NonSecure.  With RME, the EL3 translation regime does not change
      * from Root to NonSecure.
      */
-    if (ptw->in_space == ARMSS_Secure
+    if (ptw->cur_space == ARMSS_Secure
         && !regime_is_stage2(mmu_idx)
         && extract32(tableattrs, 4, 1)) {
         /*
@@ -1867,7 +1871,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
         QEMU_BUILD_BUG_ON(ARMMMUIdx_Phys_S + 1 != ARMMMUIdx_Phys_NS);
         QEMU_BUILD_BUG_ON(ARMMMUIdx_Stage2_S + 1 != ARMMMUIdx_Stage2);
         ptw->in_ptw_idx += 1;
-        ptw->in_space = ARMSS_NonSecure;
+        ptw->cur_space = ARMSS_NonSecure;
     }
 
     if (!S1_ptw_translate(env, ptw, descaddr, fi)) {
@@ -1991,7 +1995,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
     }
 
     ap = extract32(attrs, 6, 2);
-    out_space = ptw->in_space;
+    out_space = ptw->cur_space;
     if (regime_is_stage2(mmu_idx)) {
         /*
          * R_GYNXY: For stage2 in Realm security state, bit 55 is NS.
@@ -2089,12 +2093,8 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
 
         user_rw = simple_ap_to_rw_prot_is_user(ap, true);
         prot_rw = simple_ap_to_rw_prot_is_user(ap, false);
-        /*
-         * Note that we modified ptw->in_space earlier for NSTable, but
-         * result->f.attrs retains a copy of the original security space.
-         */
         result->f.prot = get_S1prot(env, mmu_idx, aarch64, user_rw, prot_rw,
-                                    xn, pxn, result->f.attrs.space, out_space);
+                                    xn, pxn, ptw->in_space, out_space);
 
         /* Index into MAIR registers for cache attributes */
         attrindx = extract32(attrs, 2, 3);
@@ -2192,7 +2192,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
         fi->level = level;
         fi->stage2 = regime_is_stage2(mmu_idx);
     }
-    fi->s1ns = fault_s1ns(ptw->in_space, mmu_idx);
+    fi->s1ns = fault_s1ns(ptw->cur_space, mmu_idx);
     return true;
 }
 
@@ -3413,6 +3413,7 @@ static bool get_phys_addr_nogpc(CPUARMState *env, S1Translate *ptw,
      * cannot upgrade a NonSecure translation regime's attributes
      * to Secure or Realm.
      */
+    ptw->cur_space = ptw->in_space;
     result->f.attrs.space = ptw->in_space;
     result->f.attrs.secure = arm_space_is_secure(ptw->in_space);
 
-- 
2.43.0


