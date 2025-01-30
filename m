Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7A80C02190
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 18:25:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdZCT-0003zs-KR; Thu, 30 Jan 2025 13:23:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tdZCF-0003ss-2m
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 13:23:24 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tdZCC-0000Vr-Ip
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 13:23:22 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4363ae65100so13351805e9.0
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2025 10:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738261399; x=1738866199; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fMa5YuSy0NDTUYP5ui6N/RSQpdjoNfs7F2yE5YfgTb4=;
 b=QLyXT5avtYHv5+RnaydOyMFPb3tY6Bm6HiR/ActAnDiNW5sbqfSx6PdyT73xCIjTmQ
 +BP11bH6Sg+Yt2gYXF6pMZJgW31ThkuLdNiGmDHhhCYDgyMHaNqveWh0mlRR1ZZ5R29o
 YKEri0ZS7D/3VKkQ0LRikjIvFaH5kyMEk1UXRz76PhR0FXo0I/qt6Adtsb/UBWoK3DDZ
 A+eF1FYHvHZo6T3k2Ph9NUWcCz+VmwifteJQyD5WYPlcTtem4i85DPv4Wt9wMWNTkZOD
 I9BWzu5I1+z0aIRcpZkpJzfGWPW62MDDFZCjb5vgPhooXCbSEp/N35oMACguFUulBeHa
 POMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738261399; x=1738866199;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fMa5YuSy0NDTUYP5ui6N/RSQpdjoNfs7F2yE5YfgTb4=;
 b=tpoI5q3wYQL3mjwl2iblT3jo1duZp9HglkF0GTcDXeLoINFjDXrH7IHdrOABW/3CEr
 4FKQLDFEj1nAbDWAcqHjJe3JIiIQnLGifGkoU3Bh9pmZEKqY5Puf3Dyw96TEnl8/k15N
 Jc94ggRDD9J+IKDbA2Sogdsl8LMibBcXExIB8I0AY0XDr0vfHxJaki1fS8FdB6y9jk29
 w/g9x4jv+15IorZQ8qBVrY9lll5diFpvR9tsWNHTbE9aRSaItSZRutrk/wYblPOwbTZe
 F5kO7dcRfGHYwyXa9YIH7NfVzGvKc1RSpZsYzBWnFN9CY8V2beErJaxiP3r+cCKvoCEs
 AKCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFe08sz41cVESBUleUjDIDXQfPTBYe1maWJijMAfgDqzWQ83nV+4pZIqOIBOhCRGcsbNXqXbxHh872@nongnu.org
X-Gm-Message-State: AOJu0Yx3nlBPDFKDPRoZQNrsTEd3xCJMB9l9NAbfzuGgjjMOgGTuzuJ4
 j/pQDEAsxJQ96n7uY2+nAwL8fs+uncs6l5fjz1CaGn05p3BYVVORAkvnpXzY9fVCQ+tn49vftZt
 U
X-Gm-Gg: ASbGncsTl6fF7JxKsdZXV59+Rc1IBKrjnKj9wP5UgGsgqqRREYmAZA6QHwE+xByMIIM
 4MSZdTda8yntlrm//yZWbM9HS/RlI2B52kBC1zn6eZvtt+8ik++BwiCuGHcSk89AXecqnjX/b9a
 6OmH/+i8+Hy3J48x074T6QQo2hAFHm2n1kuKdmXTv1ZJc7vXV+3FGVlXUmvvYE5QRbpAER6KtiL
 yorlmMtRYQAWbaB1vifRxsvrdr/0cUVtWxlEG7GUVkw6kCj/ccS+R3nxHdmr01okOWPLP2siy2I
 UwI7wQv0dRJ0K28BmrAfiw==
X-Google-Smtp-Source: AGHT+IFxjIh48WU/dSlOaoPrzaGSoSizC3MFT5Mm3SI1EOiyMrYEpqnqyWB8Fb2376SJHBAQgkzR3Q==
X-Received: by 2002:a05:6000:1548:b0:38c:3f12:64be with SMTP id
 ffacd0b85a97d-38c51f8a3camr10044992f8f.35.1738261398740; 
 Thu, 30 Jan 2025 10:23:18 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c5c101599sm2634426f8f.23.2025.01.30.10.23.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jan 2025 10:23:18 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 07/14] target/arm: Honour SDCR.TDCC and SCR.TERR in AArch32
 EL3 non-Monitor modes
Date: Thu, 30 Jan 2025 18:23:02 +0000
Message-Id: <20250130182309.717346-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250130182309.717346-1-peter.maydell@linaro.org>
References: <20250130182309.717346-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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

There are not many traps in AArch32 which should trap to Monitor
mode, but these trap bits should trap not just lower ELs to Monitor
mode but also the non-Monitor modes running at EL3 (i.e.  Secure
System, Secure Undef, etc).

We get this wrong because the relevant access functions implement the
AArch64-style logic of
   if (el < 3 && trap_bit_set) {
       return CP_ACCESS_TRAP_EL3;
   }
which won't trap the non-Monitor modes at EL3.

Correct this error by using arm_is_el3_or_mon() instead, which
returns true when the CPU is at AArch64 EL3 or AArch32 Monitor mode.
(Since the new callsites are compiled also for the linux-user mode,
we need to provide a dummy implementation for CONFIG_USER_ONLY.)

This affects only:
 * trapping of ERRIDR via SCR.TERR
 * trapping of the debug channel registers via SDCR.TDCC
 * trapping of GICv3 registers via SCR.IRQ and SCR.FIQ
   (which we already used arm_is_el3_or_mon() for)

This patch changes the handling of SCR.TERR and SDCR.TDCC. This
patch only changes guest-visible behaviour for "-cpu max" on
the qemu-system-arm binary, because SCR.TERR
and SDCR.TDCC (and indeed the entire SDCR register) only arrived
in Armv8, and the only guest CPU we support which has any v8
features and also starts in AArch32 EL3 is the 32-bit 'max'.

Other uses of CP_ACCESS_TRAP_EL3 don't need changing:

 * uses in code paths that can't happen when EL3 is AArch32:
   access_trap_aa32s_el1, cpacr_access, cptr_access, nsacr_access
 * uses which are in accessfns for AArch64-only registers:
   gt_stimer_access, gt_cntpoff_access, access_hxen, access_tpidr2,
   access_smpri, access_smprimap, access_lor_ns, access_pauth,
   access_mte, access_tfsr_el2, access_scxtnum, access_fgt
 * trap bits which exist only in the AArch64 version of the
   trap register, not the AArch32 one:
   access_tpm, pmreg_access, access_dbgvcr32, access_tdra,
   access_tda, access_tdosa (TPM, TDA and TDOSA exist only in
   MDCR_EL3, not in SDCR, and we enforce this in sdcr_write())

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h          | 5 +++++
 target/arm/debug_helper.c | 3 ++-
 target/arm/helper.c       | 2 +-
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 4cb672c120b..ae1e8b1c779 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2570,6 +2570,11 @@ static inline bool arm_is_secure_below_el3(CPUARMState *env)
     return false;
 }
 
+static inline bool arm_is_el3_or_mon(CPUARMState *env)
+{
+    return false;
+}
+
 static inline ARMSecuritySpace arm_security_space(CPUARMState *env)
 {
     return ARMSS_NonSecure;
diff --git a/target/arm/debug_helper.c b/target/arm/debug_helper.c
index 2212ef4a3b9..c3c1eb5f628 100644
--- a/target/arm/debug_helper.c
+++ b/target/arm/debug_helper.c
@@ -880,7 +880,8 @@ static CPAccessResult access_tdcc(CPUARMState *env, const ARMCPRegInfo *ri,
     if (el < 2 && (mdcr_el2_tda || mdcr_el2_tdcc)) {
         return CP_ACCESS_TRAP_EL2;
     }
-    if (el < 3 && ((env->cp15.mdcr_el3 & MDCR_TDA) || mdcr_el3_tdcc)) {
+    if (!arm_is_el3_or_mon(env) &&
+        ((env->cp15.mdcr_el3 & MDCR_TDA) || mdcr_el3_tdcc)) {
         return CP_ACCESS_TRAP_EL3;
     }
     return CP_ACCESS_OK;
diff --git a/target/arm/helper.c b/target/arm/helper.c
index c5cd27b249f..058a5af3aaf 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6103,7 +6103,7 @@ static CPAccessResult access_terr(CPUARMState *env, const ARMCPRegInfo *ri,
     if (el < 2 && (arm_hcr_el2_eff(env) & HCR_TERR)) {
         return CP_ACCESS_TRAP_EL2;
     }
-    if (el < 3 && (env->cp15.scr_el3 & SCR_TERR)) {
+    if (!arm_is_el3_or_mon(env) && (env->cp15.scr_el3 & SCR_TERR)) {
         return CP_ACCESS_TRAP_EL3;
     }
     return CP_ACCESS_OK;
-- 
2.34.1


