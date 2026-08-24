Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76CEEC61CE2
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 11:19:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wySh9-0002LU-6l; Mon, 24 Aug 2026 07:18:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wySh7-0002AL-Bm
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 07:18:25 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wySh1-0005GL-PS
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 07:18:24 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67O992RI2448604
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 11:18:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2WepINnXmaxOkQ484qL+qWUuvf8iF72UUKwEnRlH+ek=; b=SDUlxF9vcExADUAO
 QHSBMXk1E1oO3kmrlEi5Gh0TO6etqBr/gZ8M1WJhwnswBs6ylZymS42xDWMdqeO1
 EX3M0c3WuLwi3upDgv7dnXNu5sqp7fTljvq1hW7vVwM+J5ak/00bon833JzuFZk4
 6H5mQ/GbRYMGtBEeULWt8O5j+RnFMhZtFq074zpfmdMz3c84i5B0AibdUvqEgxPh
 hXB64lifzPcVpv0latY/oFOP1ClU02GUxlsVxhq3Os75uOF+AP5aNMQu8yQUkh5+
 F0k7tCdvXtxf1wXPN3+uBuF7e9AnZLgBnXrcaAgaryNqamjWIE/r8cWjvvlU87NB
 aVNFmg==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8j7r0stj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 11:18:18 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-969275401c6so2976126241.1
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 04:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787570298; x=1788175098; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2WepINnXmaxOkQ484qL+qWUuvf8iF72UUKwEnRlH+ek=;
 b=HYbaJmm8UURxXHjBzrb0ujXypR7qsRJfzwOgwKC4MHPaLQtfY+HtitZo8WjUy+uI94
 osLQcFqY3CzsxfrOKhPyuO5/4ShOdBg11oW1CzZ9zzRIpSlfnHqYfSnWu1H7s+iF5NCo
 a3+6TjYKur/Fn3LJ2QHw14LemGW6xYAy2rCb/O6OPicZQmBQnpPZCrO60HYyltrKaquT
 rY2VA+KbnD1DVsZthBmn6sT0OlAdlukXxIZDMGkG9Oeh94BPECcD+NWTO+HRiC4PHUL3
 wBSsmrPHMMzw52pblU/dEX6f4aCMFUCX5oyHtxlwvzXvwGdyG9lwgINOJFU2QZ4OyjxR
 Qbrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787570298; x=1788175098;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2WepINnXmaxOkQ484qL+qWUuvf8iF72UUKwEnRlH+ek=;
 b=Cj+WbsdQNklaIF7X7MiCVVjmhHcRRgx21m5aPWoRWEtkDa3B1xYTgy+PgELTHnDPml
 72ynskqGFjKmps/x/3at7Z4Z8TEhirXp+35qgzpOLE4sro3Ig7tPVe+NcRW1QTTQEP44
 cRrG219raJbaE9aKELmI9Sx86LSRGuMkwj/370B+Ia3ndyS6YvgzyUeeAG8U1cuzdbjt
 IqI9Hblpv5HKupdYhAB3LlF9fZKmVRXpaSAgGbMTalI/3uCCe91M7i/0lKMQWe0n+5Ub
 mCLIPMj9xYTTqEmJukJKy4covdHpsNac81GBW4Cuq9n176QY/UpC0vINiIq4dU9rfK1A
 uLDw==
X-Gm-Message-State: AFuF++mHLCt3HvGLyOb+hfrtJwSlX1uY1dWPxkIdPITzeuXlPgv3xiET
 90Yfm8YkBoQTh/664L8jqMjgITiB9tTZKrQkzrZtRMlShTTV0mk8LqrMezDvydiJBD74Ydsdzgu
 5imotO1fidhJjWot4JRhewR90SsxiTkGLiqFWcBS3Vo/X9V6im6Mw+2C5fPEIAlRWRQ==
X-Gm-Gg: AR+sD1274+Gnho2xcCrEHJ2mNB24c/FiN981XILpT+7JphQkJ8fEBN9Z8vcJg8kkBqG
 HMgPPF5wQ7n9BNdKFAJQ2bRmcrTB/hDSYt7PXrnC4710TIzV4GDZZ/hD8KiTteLUhOYBpLTD2Dk
 IoyQMTOKPyNh0y/l5JkclMTyA9KxS4/7I1V09ijU/mp8x70McMrhkxSpKfWBUpFka9vyGTkhPoM
 47LRfJrhVRxnpJmzOoxaXk503o5XRune/shrjKVnP6wEbRviLN8CYvJsC3uBrZSrWcj8sAsTMEj
 Fv9i6zKaeqgqawyOdQP276vVnNNMypULK/yWqK2NLHmaYWNABppfNzxZ/qEPYibJwkLyghcT6Ml
 uShuDhe9LhLl/H0mS7BJTXhPNzHPd/DzA13aiNH50c2OFew81QA==
X-Received: by 2002:a05:6102:2c88:b0:772:5acc:b849 with SMTP id
 ada2fe7eead31-77a636413f6mr9946321137.5.1787570297635; 
 Mon, 24 Aug 2026 04:18:17 -0700 (PDT)
X-Received: by 2002:a05:6102:2c88:b0:772:5acc:b849 with SMTP id
 ada2fe7eead31-77a636413f6mr9946294137.5.1787570296699; 
 Mon, 24 Aug 2026 04:18:16 -0700 (PDT)
Received: from localhost.localdomain (44.170.88.92.rev.sfr.net. [92.88.170.44])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a59e0190d3sm8044033a12.9.2026.08.24.04.18.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 24 Aug 2026 04:18:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v4 06/20] target/arm: Constify CPUARMState for various cpu_*()
 getters
Date: Mon, 24 Aug 2026 13:16:55 +0200
Message-ID: <20260824111711.26297-7-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260824111711.26297-1-philmd@oss.qualcomm.com>
References: <20260824111711.26297-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDA5NCBTYWx0ZWRfX91h4z6JSW+rV
 yGxm9S3XfS/ggrx4/tgmDBF51by7nc+Dht2uhxRHcVopznHBscDdcBc1CKiUpfhZ7NqvoQq2vG8
 FE/zJRI8RfaLe63owbKQGo4GeU/t4MzNIiMQLY4upt4TdodvCSLYq6EYlWoRTUhs6K9+td+Y9ld
 cwpumjoF79arYRJyvkbXJSKlgf4obbxmmM4vHjoXoATBZMAofmL8XUJa/AeqS9rchKCBxwgle11
 TpPlrLPDeSwHxH6txhj5ildIatibMegbusGZbvsond/0KBec1GgVCg7yKrIf/OTaraMlavD0YC6
 XIIeP7nXlAZqY3k7dam+VrLQMSin8c+pOP1/4fF4Mb7Ni+LNdrK0AfcdslTsa2gQFj+ZALbtDgc
 MZ0aciQmKtuOHOjaxZgKCbMF8YxCaRQz6Xwj/Qjqd12lJ+bR0OLQtpmBKtyXeDOG4vfnH/P9Mqg
 1Z3dDfhSpYlZt9J7+yw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDA5NCBTYWx0ZWRfX/U9QgaN3sxQP
 pHhhPsN2kzJIBEWvKDqe79UBCfPDH1KurW3niYOzowpeNDTyKqrtSmkaR3ZRwcXENIb0lK9FIOA
 THYAMs6Etf2sLlDbgQ7ZWMZWT0JDsAo=
X-Proofpoint-GUID: D9PZmknUp70d425SLgMPnLxNJkS4Idhb
X-Authority-Analysis: v=2.4 cv=IL8yzAvG c=1 sm=1 tr=0 ts=6a8c287a cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=s1NLoHz9uzatdv2VNqxUSg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=nSereqFst1siMyaUd8AA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-ORIG-GUID: D9PZmknUp70d425SLgMPnLxNJkS4Idhb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_03,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 phishscore=0 priorityscore=1501 suspectscore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240094
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Add the const qualifier to CPUARMState when the
argument is accessed without modification.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
Ignoring one checkpatch.pl warning:

  WARNING: line over 80 characters
  #116: FILE: target/arm/cpu.h:2277:
  +static inline ARMSecuritySpace arm_security_space_below_el3(const CPUARMState *env)

  total: 0 errors, 1 warnings, 789 lines checked
---
 target/arm/cpu.h           | 55 ++++++++++++++++----------------
 target/arm/internals.h     | 65 +++++++++++++++++++-------------------
 target/arm/helper.c        | 41 ++++++++++++------------
 target/arm/tcg/debug.c     | 18 +++++------
 target/arm/tcg/hflags.c    | 35 ++++++++++----------
 target/arm/tcg/m_helper.c  |  8 ++---
 target/arm/tcg/op_helper.c |  2 +-
 7 files changed, 114 insertions(+), 110 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index e8dfc3179f2..8fc72e1c1aa 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1342,9 +1342,9 @@ static inline uint64_t *sve_bswap64(uint64_t *dst, uint64_t *src, int nr)
 void aarch64_sync_32_to_64(CPUARMState *env);
 void aarch64_sync_64_to_32(CPUARMState *env);
 
-int fp_exception_el(CPUARMState *env, int cur_el);
-int sve_exception_el(CPUARMState *env, int cur_el);
-int sme_exception_el(CPUARMState *env, int cur_el);
+int fp_exception_el(const CPUARMState *env, int cur_el);
+int sve_exception_el(const CPUARMState *env, int cur_el);
+int sme_exception_el(const CPUARMState *env, int cur_el);
 
 /**
  * sve_vqm1_for_el_sm:
@@ -1356,10 +1356,10 @@ int sme_exception_el(CPUARMState *env, int cur_el);
  * Quadwords Minus 1 -- the same scale used for ZCR_ELx.LEN.
  * If @sm, compute for SVL, otherwise NVL.
  */
-uint32_t sve_vqm1_for_el_sm(CPUARMState *env, int el, bool sm);
+uint32_t sve_vqm1_for_el_sm(const CPUARMState *env, int el, bool sm);
 
 /* Likewise, but using @sm = PSTATE.SM. */
-uint32_t sve_vqm1_for_el(CPUARMState *env, int el);
+uint32_t sve_vqm1_for_el(const CPUARMState *env, int el);
 
 static inline bool is_a64(const CPUARMState *env)
 {
@@ -2205,7 +2205,7 @@ void arm_cpu_finalize_features(ARMCPU *cpu, Error **errp);
  * an exception return to those levels.  Unlike arm_security_space,
  * this doesn't care about the current EL.
  */
-ARMSecuritySpace arm_security_space_below_el3(CPUARMState *env);
+ARMSecuritySpace arm_security_space_below_el3(const CPUARMState *env);
 
 /**
  * arm_is_secure_below_el3:
@@ -2214,14 +2214,14 @@ ARMSecuritySpace arm_security_space_below_el3(CPUARMState *env);
  * Return true if exception levels below EL3 are in secure state,
  * or would be following an exception return to those levels.
  */
-static inline bool arm_is_secure_below_el3(CPUARMState *env)
+static inline bool arm_is_secure_below_el3(const CPUARMState *env)
 {
     ARMSecuritySpace ss = arm_security_space_below_el3(env);
     return ss == ARMSS_Secure;
 }
 
 /* Return true if the CPU is AArch64 EL3 or AArch32 Mon */
-static inline bool arm_is_el3_or_mon(CPUARMState *env)
+static inline bool arm_is_el3_or_mon(const CPUARMState *env)
 {
     assert(!arm_feature(env, ARM_FEATURE_M));
     if (arm_feature(env, ARM_FEATURE_EL3)) {
@@ -2243,7 +2243,7 @@ static inline bool arm_is_el3_or_mon(CPUARMState *env)
  *
  * Return the current security space of the cpu.
  */
-ARMSecuritySpace arm_security_space(CPUARMState *env);
+ARMSecuritySpace arm_security_space(const CPUARMState *env);
 
 /**
  * arm_is_secure:
@@ -2251,7 +2251,7 @@ ARMSecuritySpace arm_security_space(CPUARMState *env);
  *
  * Return true if the processor is in secure state.
  */
-static inline bool arm_is_secure(CPUARMState *env)
+static inline bool arm_is_secure(const CPUARMState *env)
 {
     return arm_space_is_secure(arm_security_space(env));
 }
@@ -2260,7 +2260,7 @@ static inline bool arm_is_secure(CPUARMState *env)
  * Return true if the current security state has AArch64 EL2 or AArch32 Hyp.
  * This corresponds to the pseudocode EL2Enabled().
  */
-static inline bool arm_is_el2_enabled_secstate(CPUARMState *env,
+static inline bool arm_is_el2_enabled_secstate(const CPUARMState *env,
                                                ARMSecuritySpace space)
 {
     assert(space != ARMSS_Root);
@@ -2268,44 +2268,44 @@ static inline bool arm_is_el2_enabled_secstate(CPUARMState *env,
            && (space != ARMSS_Secure || (env->cp15.scr_el3 & SCR_EEL2));
 }
 
-static inline bool arm_is_el2_enabled(CPUARMState *env)
+static inline bool arm_is_el2_enabled(const CPUARMState *env)
 {
     return arm_is_el2_enabled_secstate(env, arm_security_space_below_el3(env));
 }
 
 #else
-static inline ARMSecuritySpace arm_security_space_below_el3(CPUARMState *env)
+static inline ARMSecuritySpace arm_security_space_below_el3(const CPUARMState *env)
 {
     return ARMSS_NonSecure;
 }
 
-static inline bool arm_is_secure_below_el3(CPUARMState *env)
+static inline bool arm_is_secure_below_el3(const CPUARMState *env)
 {
     return false;
 }
 
-static inline bool arm_is_el3_or_mon(CPUARMState *env)
+static inline bool arm_is_el3_or_mon(const CPUARMState *env)
 {
     return false;
 }
 
-static inline ARMSecuritySpace arm_security_space(CPUARMState *env)
+static inline ARMSecuritySpace arm_security_space(const CPUARMState *env)
 {
     return ARMSS_NonSecure;
 }
 
-static inline bool arm_is_secure(CPUARMState *env)
+static inline bool arm_is_secure(const CPUARMState *env)
 {
     return false;
 }
 
-static inline bool arm_is_el2_enabled_secstate(CPUARMState *env,
+static inline bool arm_is_el2_enabled_secstate(const CPUARMState *env,
                                                ARMSecuritySpace space)
 {
     return false;
 }
 
-static inline bool arm_is_el2_enabled(CPUARMState *env)
+static inline bool arm_is_el2_enabled(const CPUARMState *env)
 {
     return false;
 }
@@ -2317,10 +2317,11 @@ static inline bool arm_is_el2_enabled(CPUARMState *env)
  * "for all purposes other than a direct read or write access of HCR_EL2."
  * Not included here is HCR_RW.
  */
-uint64_t arm_hcr_el2_eff_secstate(CPUARMState *env, ARMSecuritySpace space);
-uint64_t arm_hcr_el2_eff(CPUARMState *env);
-uint64_t arm_hcr_el2_nvx_eff(CPUARMState *env);
-uint64_t arm_hcrx_el2_eff(CPUARMState *env);
+uint64_t arm_hcr_el2_eff_secstate(const CPUARMState *env,
+                                  ARMSecuritySpace space);
+uint64_t arm_hcr_el2_eff(const CPUARMState *env);
+uint64_t arm_hcr_el2_nvx_eff(const CPUARMState *env);
+uint64_t arm_hcrx_el2_eff(const CPUARMState *env);
 
 /*
  * Function for determining whether guest cp register reads and writes should
@@ -2330,13 +2331,13 @@ uint64_t arm_hcrx_el2_eff(CPUARMState *env);
  * it doesn't exist at all) then there is no register banking, and all
  * accesses are to the non-secure version.
  */
-bool access_secure_reg(CPUARMState *env);
+bool access_secure_reg(const CPUARMState *env);
 
 uint32_t arm_phys_excp_target_el(CPUState *cs, uint32_t excp_idx,
                                  uint32_t cur_el, bool secure);
 
 /* Return the highest implemented Exception Level */
-static inline int arm_highest_el(CPUARMState *env)
+static inline int arm_highest_el(const CPUARMState *env)
 {
     if (arm_feature(env, ARM_FEATURE_EL3)) {
         return 3;
@@ -2348,7 +2349,7 @@ static inline int arm_highest_el(CPUARMState *env)
 }
 
 /* Return true if a v7M CPU is in Handler mode */
-static inline bool arm_v7m_is_handler_mode(CPUARMState *env)
+static inline bool arm_v7m_is_handler_mode(const CPUARMState *env)
 {
     return env->v7m.exception != 0;
 }
@@ -2446,7 +2447,7 @@ static inline bool arm_sctlr_b(const CPUARMState *env)
         (env->cp15.sctlr_el[1] & SCTLR_B) != 0;
 }
 
-uint64_t arm_sctlr(CPUARMState *env, int el);
+uint64_t arm_sctlr(const CPUARMState *env, int el);
 
 /*
  * We have more than 32-bits worth of state per TB, so we split the data
diff --git a/target/arm/internals.h b/target/arm/internals.h
index 8f44906a3be..f1a80c890ee 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -50,7 +50,7 @@
 #define BANK_HYP    6
 #define BANK_MON    7
 
-static inline MemOp mo_endian(CPUARMState *env)
+static inline MemOp mo_endian(const CPUARMState *env)
 {
     return EX_TBFLAG_ANY(env->hflags, BE_DATA) ? MO_BE : MO_LE;
 }
@@ -452,14 +452,14 @@ static inline FloatRoundMode arm_rmode_to_sf(ARMFPRounding rmode)
 }
 
 /* Return the effective value of SCR_EL3.RW */
-static inline bool arm_scr_rw_eff(CPUARMState *env)
+static inline bool arm_scr_rw_eff(const CPUARMState *env)
 {
     /*
      * SCR_EL3.RW has an effective value of 1 if:
      *  - we are NS and EL2 is implemented but doesn't support AArch32
      *  - we are S and EL2 is enabled (in which case it must be AArch64)
      */
-    ARMCPU *cpu = env_archcpu(env);
+    const ARMCPU *cpu = env_archcpu(env);
 
     if (env->cp15.scr_el3 & SCR_RW) {
         return true;
@@ -473,7 +473,7 @@ static inline bool arm_scr_rw_eff(CPUARMState *env)
 }
 
 /* Return true if the specified exception level is running in AArch64 state. */
-static inline bool arm_el_is_aa64(CPUARMState *env, int el)
+static inline bool arm_el_is_aa64(const CPUARMState *env, int el)
 {
     /*
      * This isn't valid for EL0 (if we're in EL0, is_a64() is what you want,
@@ -510,7 +510,7 @@ static inline bool arm_el_is_aa64(CPUARMState *env, int el)
  * Return the current Exception Level (as per ARMv8; note that this differs
  * from the ARMv7 Privilege Level).
  */
-static inline int arm_current_el(CPUARMState *env)
+static inline int arm_current_el(const CPUARMState *env)
 {
     if (arm_feature(env, ARM_FEATURE_M)) {
         return arm_v7m_is_handler_mode(env) ||
@@ -538,7 +538,7 @@ static inline int arm_current_el(CPUARMState *env)
     }
 }
 
-static inline bool arm_cpu_data_is_big_endian_a32(CPUARMState *env,
+static inline bool arm_cpu_data_is_big_endian_a32(const CPUARMState *env,
                                                   bool sctlr_b)
 {
 #ifdef CONFIG_USER_ONLY
@@ -568,7 +568,7 @@ static inline bool arm_cpu_data_is_big_endian_a64(int el, uint64_t sctlr)
 }
 
 /* Return true if the processor is in big-endian mode. */
-static inline bool arm_cpu_data_is_big_endian(CPUARMState *env)
+static inline bool arm_cpu_data_is_big_endian(const CPUARMState *env)
 {
     if (!is_a64(env)) {
         return arm_cpu_data_is_big_endian_a32(env, arm_sctlr_b(env));
@@ -580,7 +580,7 @@ static inline bool arm_cpu_data_is_big_endian(CPUARMState *env)
 }
 
 #ifdef CONFIG_USER_ONLY
-static inline bool arm_cpu_bswap_data(CPUARMState *env)
+static inline bool arm_cpu_bswap_data(const CPUARMState *env)
 {
     return TARGET_BIG_ENDIAN ^ arm_cpu_data_is_big_endian(env);
 }
@@ -1036,7 +1036,7 @@ static inline ARMMMUIdx core_to_aa64_mmu_idx(int mmu_idx)
 }
 
 /* Return the MMU index for a v7M CPU in the specified security state */
-ARMMMUIdx arm_v7m_mmu_idx_for_secstate(CPUARMState *env, bool secstate);
+ARMMMUIdx arm_v7m_mmu_idx_for_secstate(const CPUARMState *env, bool secstate);
 
 /*
  * Return true if the stage 1 translation regime is using LPAE
@@ -1078,7 +1078,7 @@ static inline void arm_call_el_change_hook(ARMCPU *cpu)
 }
 
 /* Return the SCTLR value which controls this address translation regime */
-static inline uint64_t regime_sctlr(CPUARMState *env, ARMMMUIdx mmu_idx)
+static inline uint64_t regime_sctlr(const CPUARMState *env, ARMMMUIdx mmu_idx)
 {
     return env->cp15.sctlr_el[regime_el(mmu_idx)];
 }
@@ -1094,7 +1094,7 @@ static inline uint64_t regime_sctlr(CPUARMState *env, ARMMMUIdx mmu_idx)
      R_VTCR_DS_MASK)
 
 /* Return the value of the TCR controlling this translation regime */
-static inline uint64_t regime_tcr(CPUARMState *env, ARMMMUIdx mmu_idx)
+static inline uint64_t regime_tcr(const CPUARMState *env, ARMMMUIdx mmu_idx)
 {
     if (mmu_idx == ARMMMUIdx_Stage2) {
         return env->cp15.vtcr_el2;
@@ -1116,7 +1116,8 @@ static inline uint64_t regime_tcr(CPUARMState *env, ARMMMUIdx mmu_idx)
 }
 
 /* Return true if the translation regime is using LPAE format page tables */
-static inline bool regime_using_lpae_format(CPUARMState *env, ARMMMUIdx mmu_idx)
+static inline bool regime_using_lpae_format(const CPUARMState *env,
+                                            ARMMMUIdx mmu_idx)
 {
     int el = regime_el(mmu_idx);
     if (el == 2 || arm_el_is_aa64(env, el)) {
@@ -1138,7 +1139,7 @@ static inline bool regime_using_lpae_format(CPUARMState *env, ARMMMUIdx mmu_idx)
  * Note that the ID register BRPS field is "number of bps - 1",
  * and we return the actual number of breakpoints.
  */
-static inline int arm_num_brps(ARMCPU *cpu)
+static inline int arm_num_brps(const ARMCPU *cpu)
 {
     if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
         return FIELD_EX64_IDREG(&cpu->isar, ID_AA64DFR0, BRPS) + 1;
@@ -1152,7 +1153,7 @@ static inline int arm_num_brps(ARMCPU *cpu)
  * Note that the ID register WRPS field is "number of wps - 1",
  * and we return the actual number of watchpoints.
  */
-static inline int arm_num_wrps(ARMCPU *cpu)
+static inline int arm_num_wrps(const ARMCPU *cpu)
 {
     if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
         return FIELD_EX64_IDREG(&cpu->isar, ID_AA64DFR0, WRPS) + 1;
@@ -1166,7 +1167,7 @@ static inline int arm_num_wrps(ARMCPU *cpu)
  * Note that the ID register CTX_CMPS field is "number of cmps - 1",
  * and we return the actual number of comparators.
  */
-static inline int arm_num_ctx_cmps(ARMCPU *cpu)
+static inline int arm_num_ctx_cmps(const ARMCPU *cpu)
 {
     if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
         return FIELD_EX64_IDREG(&cpu->isar, ID_AA64DFR0, CTX_CMPS) + 1;
@@ -1180,7 +1181,7 @@ static inline int arm_num_ctx_cmps(ARMCPU *cpu)
  * Return true if the CPU is currently using the process stack
  * pointer, or false if it is using the main stack pointer.
  */
-static inline bool v7m_using_psp(CPUARMState *env)
+static inline bool v7m_using_psp(const CPUARMState *env)
 {
     /* Handler mode always uses the main stack; for thread mode
      * the CONTROL.SPSEL bit determines the answer.
@@ -1196,7 +1197,7 @@ static inline bool v7m_using_psp(CPUARMState *env)
  * Return the SP limit value for the current CPU security state
  * and stack pointer.
  */
-static inline uint32_t v7m_sp_limit(CPUARMState *env)
+static inline uint32_t v7m_sp_limit(const CPUARMState *env)
 {
     if (v7m_using_psp(env)) {
         return env->v7m.psplim[env->v7m.secure];
@@ -1210,7 +1211,7 @@ static inline uint32_t v7m_sp_limit(CPUARMState *env)
  * Return true if the v7M CPACR permits access to the FPU for the specified
  * security state and privilege level.
  */
-static inline bool v7m_cpacr_pass(CPUARMState *env,
+static inline bool v7m_cpacr_pass(const CPUARMState *env,
                                   bool is_secure, bool is_priv)
 {
     switch (extract32(env->v7m.cpacr[is_secure], 20, 2)) {
@@ -1300,7 +1301,7 @@ void arm_cpu_update_vserr(ARMCPU *cpu);
  *
  * Return the full ARMMMUIdx for the translation regime for EL.
  */
-ARMMMUIdx arm_mmu_idx_el(CPUARMState *env, int el);
+ARMMMUIdx arm_mmu_idx_el(const CPUARMState *env, int el);
 
 /**
  * arm_mmu_idx:
@@ -1308,7 +1309,7 @@ ARMMMUIdx arm_mmu_idx_el(CPUARMState *env, int el);
  *
  * Return the full ARMMMUIdx for the current translation regime.
  */
-ARMMMUIdx arm_mmu_idx(CPUARMState *env);
+ARMMMUIdx arm_mmu_idx(const CPUARMState *env);
 
 /**
  * arm_stage1_mmu_idx:
@@ -1463,7 +1464,7 @@ int aa64_va_parameter_tbid(uint64_t tcr, ARMMMUIdx mmu_idx);
 int aa64_va_parameter_tcma(uint64_t tcr, ARMMMUIdx mmu_idx);
 
 /* Determine if allocation tags are available.  */
-static inline bool allocation_tag_access_enabled(CPUARMState *env, int el,
+static inline bool allocation_tag_access_enabled(const CPUARMState *env, int el,
                                                  uint64_t sctlr)
 {
     if (el < 3
@@ -1772,9 +1773,9 @@ enum MVEECIState {
 #define PMCCFILTR_M           PMXEVTYPER_M
 #define PMCCFILTR_EL0         (PMCCFILTR | PMCCFILTR_M)
 
-static inline uint32_t pmu_num_counters(CPUARMState *env)
+static inline uint32_t pmu_num_counters(const CPUARMState *env)
 {
-    ARMCPU *cpu = env_archcpu(env);
+    const ARMCPU *cpu = env_archcpu(env);
 
     return (cpu->isar.reset_pmcr_el0 & PMCRN_MASK) >> PMCRN_SHIFT;
 }
@@ -1814,7 +1815,7 @@ void aarch64_aa32_a57_init(ARMCPU *cpu, bool aa64_enabled);
 void aarch64_host_initfn(Object *obj);
 
 /* Return true if the gdbstub is presenting an AArch64 CPU */
-static inline bool arm_gdbstub_is_aarch64(ARMCPU *cpu)
+static inline bool arm_gdbstub_is_aarch64(const ARMCPU *cpu)
 {
     return arm_feature(&cpu->env, ARM_FEATURE_AARCH64);
 }
@@ -1832,13 +1833,13 @@ uint32_t arm_v7m_mrs_control(CPUARMState *env, uint32_t secure);
 uint32_t *arm_v7m_get_sp_ptr(CPUARMState *env, bool secure,
                              bool threadmode, bool spsel);
 
-bool el_is_in_host(CPUARMState *env, int el);
+bool el_is_in_host(const CPUARMState *env, int el);
 
 void aa32_max_features(ARMCPU *cpu);
 void aarch32_max_tcg_init(ARMCPU *cpu);
-int exception_target_el(CPUARMState *env);
-bool arm_singlestep_active(CPUARMState *env);
-bool arm_generate_debug_exceptions(CPUARMState *env);
+int exception_target_el(const CPUARMState *env);
+bool arm_singlestep_active(const CPUARMState *env);
+bool arm_generate_debug_exceptions(const CPUARMState *env);
 
 /**
  * pauth_ptr_mask:
@@ -1847,7 +1848,7 @@ bool arm_generate_debug_exceptions(CPUARMState *env);
  * Return a mask of the address bits that contain the authentication code,
  * given the MMU config defined by @param.
  */
-static inline uint64_t pauth_ptr_mask(ARMVAParameters param)
+static inline uint64_t pauth_ptr_mask(const ARMVAParameters param)
 {
     int bot_pac_bit = 64 - param.tsz;
     int top_pac_bit = 64 - 8 * param.tbi;
@@ -1903,7 +1904,7 @@ static inline uint64_t arm_mdcr_el2_eff(CPUARMState *env)
  * Return the maximum SVE/SME VQ for this CPU. This defines
  * the maximum possible size of the Zn vector registers.
  */
-static inline int arm_max_vq(ARMCPU *cpu)
+static inline int arm_max_vq(const ARMCPU *cpu)
 {
     return MAX(cpu->sve_max_vq, cpu->sme_max_vq);
 }
@@ -1911,7 +1912,7 @@ static inline int arm_max_vq(ARMCPU *cpu)
 /*
  * Return true if it is possible to take a fine-grained-trap to EL2.
  */
-static inline bool arm_fgt_active(CPUARMState *env, int el)
+static inline bool arm_fgt_active(const CPUARMState *env, int el)
 {
     /*
      * The Arm ARM only requires the "{E2H,TGE} != {1,1}" test for traps
@@ -2011,7 +2012,7 @@ void vfp_clear_float_status_exc_flags(CPUARMState *env);
  * specified by mask changing to the values in val.
  */
 void vfp_set_fpcr_to_host(CPUARMState *env, uint32_t val, uint32_t mask);
-bool arm_pan_enabled(CPUARMState *env);
+bool arm_pan_enabled(const CPUARMState *env);
 uint32_t cpsr_read_for_spsr_elx(CPUARMState *env);
 void cpsr_write_from_spsr_elx(CPUARMState *env, uint32_t val);
 
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 4f30a94ecd3..0b7cf021e47 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -283,7 +283,7 @@ void arm_init_cpreg_list(ARMCPU *cpu)
     }
 }
 
-bool arm_pan_enabled(CPUARMState *env)
+bool arm_pan_enabled(const CPUARMState *env)
 {
     if (is_a64(env)) {
         if ((arm_hcr_el2_eff(env) & (HCR_NV | HCR_NV1)) == (HCR_NV | HCR_NV1)) {
@@ -3915,7 +3915,8 @@ static void hcr_reset(CPUARMState *env, const ARMCPRegInfo *ri)
  * Bits that are not included here:
  * RW       (read from SCR_EL3.RW as needed)
  */
-uint64_t arm_hcr_el2_eff_secstate(CPUARMState *env, ARMSecuritySpace space)
+uint64_t arm_hcr_el2_eff_secstate(const CPUARMState *env,
+                                  ARMSecuritySpace space)
 {
     uint64_t ret = env->cp15.hcr_el2;
 
@@ -3980,7 +3981,7 @@ uint64_t arm_hcr_el2_eff_secstate(CPUARMState *env, ARMSecuritySpace space)
     return ret;
 }
 
-uint64_t arm_hcr_el2_eff(CPUARMState *env)
+uint64_t arm_hcr_el2_eff(const CPUARMState *env)
 {
     if (arm_feature(env, ARM_FEATURE_M)) {
         return 0;
@@ -3988,7 +3989,7 @@ uint64_t arm_hcr_el2_eff(CPUARMState *env)
     return arm_hcr_el2_eff_secstate(env, arm_security_space_below_el3(env));
 }
 
-uint64_t arm_hcr_el2_nvx_eff(CPUARMState *env)
+uint64_t arm_hcr_el2_nvx_eff(const CPUARMState *env)
 {
     uint64_t hcr = arm_hcr_el2_eff(env);
 
@@ -4001,7 +4002,7 @@ uint64_t arm_hcr_el2_nvx_eff(CPUARMState *env)
 /*
  * Corresponds to ARM pseudocode function ELIsInHost().
  */
-bool el_is_in_host(CPUARMState *env, int el)
+bool el_is_in_host(const CPUARMState *env, int el)
 {
     uint64_t mask;
 
@@ -4099,7 +4100,7 @@ static const ARMCPRegInfo hcrx_el2_reginfo = {
 };
 
 /* Return the effective value of HCRX_EL2.  */
-uint64_t arm_hcrx_el2_eff(CPUARMState *env)
+uint64_t arm_hcrx_el2_eff(const CPUARMState *env)
 {
     /*
      * The bits in this register behave as 0 for all purposes other than
@@ -4113,7 +4114,7 @@ uint64_t arm_hcrx_el2_eff(CPUARMState *env)
      * This may need to be revisited for future bits.
      */
     if (!arm_is_el2_enabled(env)) {
-        ARMCPU *cpu = env_archcpu(env);
+        const ARMCPU *cpu = env_archcpu(env);
         uint64_t hcrx = 0;
 
         /* Bits which whose effective value is 1 if el2 not enabled. */
@@ -4721,7 +4722,7 @@ static const ARMCPRegInfo minimal_ras_reginfo[] = {
  * pseudocode does *not* separate out the FP trap checks, but has them
  * all in one function.
  */
-int sve_exception_el(CPUARMState *env, int el)
+int sve_exception_el(const CPUARMState *env, int el)
 {
 #ifndef CONFIG_USER_ONLY
     if (el <= 1 && !el_is_in_host(env, el)) {
@@ -4770,7 +4771,7 @@ int sve_exception_el(CPUARMState *env, int el)
  * Return the exception level to which exceptions should be taken for SME.
  * C.f. the ARM pseudocode function CheckSMEAccess.
  */
-int sme_exception_el(CPUARMState *env, int el)
+int sme_exception_el(const CPUARMState *env, int el)
 {
 #ifndef CONFIG_USER_ONLY
     if (el <= 1 && !el_is_in_host(env, el)) {
@@ -4818,10 +4819,10 @@ int sme_exception_el(CPUARMState *env, int el)
 /*
  * Given that SVE or SME is enabled, return the vector length for EL.
  */
-uint32_t sve_vqm1_for_el_sm(CPUARMState *env, int el, bool sm)
+uint32_t sve_vqm1_for_el_sm(const CPUARMState *env, int el, bool sm)
 {
-    ARMCPU *cpu = env_archcpu(env);
-    uint64_t *cr = env->vfp.zcr_el;
+    const ARMCPU *cpu = env_archcpu(env);
+    const uint64_t *cr = env->vfp.zcr_el;
     uint32_t map = cpu->sve_vq.map;
     uint32_t len = ARM_MAX_VQ - 1;
 
@@ -4856,7 +4857,7 @@ uint32_t sve_vqm1_for_el_sm(CPUARMState *env, int el, bool sm)
     return ctz32(cpu->sme_vq.map);
 }
 
-uint32_t sve_vqm1_for_el(CPUARMState *env, int el)
+uint32_t sve_vqm1_for_el(const CPUARMState *env, int el)
 {
     return sve_vqm1_for_el_sm(env, el, FIELD_EX64(env->svcr, SVCR, SM));
 }
@@ -9748,7 +9749,7 @@ void arm_cpu_do_interrupt(CPUState *cs)
 }
 #endif /* !CONFIG_USER_ONLY */
 
-uint64_t arm_sctlr(CPUARMState *env, int el)
+uint64_t arm_sctlr(const CPUARMState *env, int el)
 {
     /* Only EL0 needs to be adjusted for EL1&0 or EL2&0 or EL3&0 */
     if (el == 0) {
@@ -10072,7 +10073,7 @@ ARMVAParameters aa64_va_parameters(CPUARMState *env, uint64_t va,
  * Return the exception level to which FP-disabled exceptions should
  * be taken, or 0 if FP is enabled.
  */
-int fp_exception_el(CPUARMState *env, int cur_el)
+int fp_exception_el(const CPUARMState *env, int cur_el)
 {
 #ifndef CONFIG_USER_ONLY
     uint64_t hcr_el2;
@@ -10179,13 +10180,13 @@ int fp_exception_el(CPUARMState *env, int cur_el)
 }
 
 #ifndef CONFIG_TCG
-ARMMMUIdx arm_v7m_mmu_idx_for_secstate(CPUARMState *env, bool secstate)
+ARMMMUIdx arm_v7m_mmu_idx_for_secstate(const CPUARMState *env, bool secstate)
 {
     g_assert_not_reached();
 }
 #endif
 
-ARMMMUIdx arm_mmu_idx_el(CPUARMState *env, int el)
+ARMMMUIdx arm_mmu_idx_el(const CPUARMState *env, int el)
 {
     ARMMMUIdx idx;
     uint64_t hcr;
@@ -10238,7 +10239,7 @@ ARMMMUIdx arm_mmu_idx_el(CPUARMState *env, int el)
     return idx;
 }
 
-ARMMMUIdx arm_mmu_idx(CPUARMState *env)
+ARMMMUIdx arm_mmu_idx(const CPUARMState *env)
 {
     return arm_mmu_idx_el(env, arm_current_el(env));
 }
@@ -10359,7 +10360,7 @@ void aarch64_sve_change_el(CPUARMState *env, int old_el,
 }
 
 #ifndef CONFIG_USER_ONLY
-ARMSecuritySpace arm_security_space(CPUARMState *env)
+ARMSecuritySpace arm_security_space(const CPUARMState *env)
 {
     if (arm_feature(env, ARM_FEATURE_M)) {
         return arm_secure_to_space(env->v7m.secure);
@@ -10391,7 +10392,7 @@ ARMSecuritySpace arm_security_space(CPUARMState *env)
     return arm_security_space_below_el3(env);
 }
 
-ARMSecuritySpace arm_security_space_below_el3(CPUARMState *env)
+ARMSecuritySpace arm_security_space_below_el3(const CPUARMState *env)
 {
     assert(!arm_feature(env, ARM_FEATURE_M));
 
diff --git a/target/arm/tcg/debug.c b/target/arm/tcg/debug.c
index 528d2889c3a..af800917dea 100644
--- a/target/arm/tcg/debug.c
+++ b/target/arm/tcg/debug.c
@@ -16,7 +16,7 @@
 #include "system/tcg.h"
 
 /* Return the Exception Level targeted by debug exceptions. */
-static int arm_debug_target_el(CPUARMState *env)
+static int arm_debug_target_el(const CPUARMState *env)
 {
     bool secure = arm_is_secure(env);
     bool route_to_el2 = false;
@@ -61,7 +61,7 @@ raise_exception_debug(CPUARMState *env, uint32_t excp, uint32_t syndrome)
 }
 
 /* See AArch64.GenerateDebugExceptionsFrom() in ARM ARM pseudocode */
-static bool aa64_generate_debug_exceptions(CPUARMState *env)
+static bool aa64_generate_debug_exceptions(const CPUARMState *env)
 {
     int cur_el = arm_current_el(env);
     int debug_el;
@@ -91,7 +91,7 @@ static bool aa64_generate_debug_exceptions(CPUARMState *env)
     return debug_el > cur_el;
 }
 
-static bool aa32_generate_debug_exceptions(CPUARMState *env)
+static bool aa32_generate_debug_exceptions(const CPUARMState *env)
 {
     int el = arm_current_el(env);
 
@@ -145,7 +145,7 @@ static bool aa32_generate_debug_exceptions(CPUARMState *env)
  * CheckSoftwareStep(), where it is elided because both branches would
  * always return the same value.
  */
-bool arm_generate_debug_exceptions(CPUARMState *env)
+bool arm_generate_debug_exceptions(const CPUARMState *env)
 {
     if ((env->cp15.oslsr_el1 & 1) || (env->cp15.osdlr_el1 & 1)) {
         return false;
@@ -161,7 +161,7 @@ bool arm_generate_debug_exceptions(CPUARMState *env)
  * Is single-stepping active? (Note that the "is EL_D AArch64?" check
  * implicitly means this always returns false in pre-v8 CPUs.)
  */
-bool arm_singlestep_active(CPUARMState *env)
+bool arm_singlestep_active(const CPUARMState *env)
 {
     return extract32(env->cp15.mdscr_el1, 0, 1)
         && arm_el_is_aa64(env, arm_debug_target_el(env))
@@ -169,9 +169,9 @@ bool arm_singlestep_active(CPUARMState *env)
 }
 
 /* Return true if the linked breakpoint entry lbn passes its checks */
-static bool linked_bp_matches(ARMCPU *cpu, int lbn)
+static bool linked_bp_matches(const ARMCPU *cpu, int lbn)
 {
-    CPUARMState *env = &cpu->env;
+    const CPUARMState *env = &cpu->env;
     uint64_t bcr = env->cp15.dbgbcr[lbn];
     int brps = arm_num_brps(cpu);
     int ctx_cmps = arm_num_ctx_cmps(cpu);
@@ -252,9 +252,9 @@ static bool linked_bp_matches(ARMCPU *cpu, int lbn)
     return contextidr == (uint32_t)env->cp15.dbgbvr[lbn];
 }
 
-static bool bp_wp_matches(ARMCPU *cpu, int n, bool is_wp)
+static bool bp_wp_matches(const ARMCPU *cpu, int n, bool is_wp)
 {
-    CPUARMState *env = &cpu->env;
+    const CPUARMState *env = &cpu->env;
     uint64_t cr;
     int pac, hmc, ssc, wt, lbn;
     /*
diff --git a/target/arm/tcg/hflags.c b/target/arm/tcg/hflags.c
index 296ec8101ab..ec837794287 100644
--- a/target/arm/tcg/hflags.c
+++ b/target/arm/tcg/hflags.c
@@ -14,7 +14,7 @@
 #include "accel/tcg/cpu-ops.h"
 #include "cpregs.h"
 
-static inline bool fgt_svc(CPUARMState *env, int el)
+static inline bool fgt_svc(const CPUARMState *env, int el)
 {
     /*
      * Assuming fine-grained-traps are active, return true if we
@@ -29,7 +29,8 @@ static inline bool fgt_svc(CPUARMState *env, int el)
 }
 
 /* Return true if memory alignment should be enforced. */
-static bool aprofile_require_alignment(CPUARMState *env, int el, uint64_t sctlr)
+static bool aprofile_require_alignment(const CPUARMState *env,
+                                       int el, uint64_t sctlr)
 {
 #ifdef CONFIG_USER_ONLY
     return false;
@@ -65,7 +66,7 @@ static bool aprofile_require_alignment(CPUARMState *env, int el, uint64_t sctlr)
 #endif
 }
 
-bool access_secure_reg(CPUARMState *env)
+bool access_secure_reg(const CPUARMState *env)
 {
     bool ret = (arm_feature(env, ARM_FEATURE_EL3) &&
                 !arm_el_is_aa64(env, 3) &&
@@ -74,7 +75,7 @@ bool access_secure_reg(CPUARMState *env)
     return ret;
 }
 
-static CPUARMTBFlags rebuild_hflags_common(CPUARMState *env, int fp_el,
+static CPUARMTBFlags rebuild_hflags_common(const CPUARMState *env, int fp_el,
                                            ARMMMUIdx mmu_idx,
                                            CPUARMTBFlags flags)
 {
@@ -88,7 +89,7 @@ static CPUARMTBFlags rebuild_hflags_common(CPUARMState *env, int fp_el,
     return flags;
 }
 
-static CPUARMTBFlags rebuild_hflags_common_32(CPUARMState *env, int fp_el,
+static CPUARMTBFlags rebuild_hflags_common_32(const CPUARMState *env, int fp_el,
                                               ARMMMUIdx mmu_idx,
                                               CPUARMTBFlags flags)
 {
@@ -105,7 +106,7 @@ static CPUARMTBFlags rebuild_hflags_common_32(CPUARMState *env, int fp_el,
     return rebuild_hflags_common(env, fp_el, mmu_idx, flags);
 }
 
-static CPUARMTBFlags rebuild_hflags_m32(CPUARMState *env, int fp_el,
+static CPUARMTBFlags rebuild_hflags_m32(const CPUARMState *env, int fp_el,
                                         ARMMMUIdx mmu_idx)
 {
     CPUARMTBFlags flags = {};
@@ -139,7 +140,7 @@ static CPUARMTBFlags rebuild_hflags_m32(CPUARMState *env, int fp_el,
 }
 
 /* This corresponds to the ARM pseudocode function IsFullA64Enabled(). */
-static bool sme_fa64(CPUARMState *env, int el)
+static bool sme_fa64(const CPUARMState *env, int el)
 {
     if (!cpu_isar_feature(aa64_sme_fa64, env_archcpu(env))) {
         return false;
@@ -164,7 +165,7 @@ static bool sme_fa64(CPUARMState *env, int el)
     return true;
 }
 
-static int neon_exception_el(CPUARMState *env, int cur_el)
+static int neon_exception_el(const CPUARMState *env, int cur_el)
 {
     /*
      * Return the EL to trap to for A32 Neon specific traps
@@ -244,7 +245,7 @@ static int neon_exception_el(CPUARMState *env, int cur_el)
     return 0;
 }
 
-static bool arm_d32dis(CPUARMState *env, int cur_el)
+static bool arm_d32dis(const CPUARMState *env, int cur_el)
 {
     bool cpacr_d32dis = FIELD_EX64(env->cp15.cpacr_el1, CPACR, D32DIS);
 
@@ -262,7 +263,7 @@ static bool arm_d32dis(CPUARMState *env, int cur_el)
     return cpacr_d32dis;
 }
 
-static CPUARMTBFlags rebuild_hflags_a32(CPUARMState *env, int fp_el,
+static CPUARMTBFlags rebuild_hflags_a32(const CPUARMState *env, int fp_el,
                                         ARMMMUIdx mmu_idx)
 {
     CPUARMTBFlags flags = {};
@@ -318,7 +319,7 @@ static CPUARMTBFlags rebuild_hflags_a32(CPUARMState *env, int fp_el,
  * Return the exception level to which exceptions should be taken for ZT0.
  * C.f. the ARM pseudocode function CheckSMEZT0Enabled, after the ZA check.
  */
-static int zt0_exception_el(CPUARMState *env, int el)
+static int zt0_exception_el(const CPUARMState *env, int el)
 {
 #ifndef CONFIG_USER_ONLY
     if (el <= 1
@@ -344,7 +345,7 @@ static int zt0_exception_el(CPUARMState *env, int el)
  * Compare the EnFPM bits in the "Accessing FPMR" pseudocode.  Note that
  * the floating-point enabled check will be handled separately.
  */
-static int fpmr_exception_el(CPUARMState *env, int el)
+static int fpmr_exception_el(const CPUARMState *env, int el)
 {
     switch (el) {
     case 0:
@@ -377,8 +378,8 @@ static int fpmr_exception_el(CPUARMState *env, int el)
     return 0;
 }
 
-static CPUARMTBFlags rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
-                                        ARMMMUIdx mmu_idx)
+static CPUARMTBFlags rebuild_hflags_a64(const CPUARMState *env, int el,
+                                        int fp_el, ARMMMUIdx mmu_idx)
 {
     CPUARMTBFlags flags = {};
     ARMMMUIdx stage1 = stage_1_mmu_idx(mmu_idx);
@@ -664,7 +665,7 @@ static CPUARMTBFlags rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
     return rebuild_hflags_common(env, fp_el, mmu_idx, flags);
 }
 
-static CPUARMTBFlags rebuild_hflags_internal(CPUARMState *env)
+static CPUARMTBFlags rebuild_hflags_internal(const CPUARMState *env)
 {
     int el = arm_current_el(env);
     int fp_el = fp_exception_el(env, el);
@@ -733,7 +734,7 @@ void HELPER(rebuild_hflags_a64)(CPUARMState *env, int el)
     env->hflags = rebuild_hflags_a64(env, el, fp_el, mmu_idx);
 }
 
-static void assert_hflags_rebuild_correctly(CPUARMState *env)
+static void assert_hflags_rebuild_correctly(const CPUARMState *env)
 {
 #ifdef CONFIG_DEBUG_TCG
     CPUARMTBFlags c = env->hflags;
@@ -749,7 +750,7 @@ static void assert_hflags_rebuild_correctly(CPUARMState *env)
 #endif
 }
 
-static bool mve_no_pred(CPUARMState *env)
+static bool mve_no_pred(const CPUARMState *env)
 {
     /*
      * Return true if there is definitely no predication of MVE
diff --git a/target/arm/tcg/m_helper.c b/target/arm/tcg/m_helper.c
index f4ba93b291b..09084154bdd 100644
--- a/target/arm/tcg/m_helper.c
+++ b/target/arm/tcg/m_helper.c
@@ -156,14 +156,14 @@ uint32_t HELPER(v7m_tt)(CPUARMState *env, uint32_t addr, uint32_t op)
     return 0;
 }
 
-ARMMMUIdx arm_v7m_mmu_idx_for_secstate(CPUARMState *env, bool secstate)
+ARMMMUIdx arm_v7m_mmu_idx_for_secstate(const CPUARMState *env, bool secstate)
 {
     return ARMMMUIdx_MUser;
 }
 
 #else /* !CONFIG_USER_ONLY */
 
-static ARMMMUIdx arm_v7m_mmu_idx_all(CPUARMState *env,
+static ARMMMUIdx arm_v7m_mmu_idx_all(const CPUARMState *env,
                                      bool secstate, bool priv, bool negpri)
 {
     ARMMMUIdx mmu_idx = ARM_MMU_IDX_M;
@@ -183,7 +183,7 @@ static ARMMMUIdx arm_v7m_mmu_idx_all(CPUARMState *env,
     return mmu_idx;
 }
 
-static ARMMMUIdx arm_v7m_mmu_idx_for_secstate_and_priv(CPUARMState *env,
+static ARMMMUIdx arm_v7m_mmu_idx_for_secstate_and_priv(const CPUARMState *env,
                                                        bool secstate, bool priv)
 {
     bool negpri = armv7m_nvic_neg_prio_requested(env->nvic, secstate);
@@ -192,7 +192,7 @@ static ARMMMUIdx arm_v7m_mmu_idx_for_secstate_and_priv(CPUARMState *env,
 }
 
 /* Return the MMU index for a v7M CPU in the specified security state */
-ARMMMUIdx arm_v7m_mmu_idx_for_secstate(CPUARMState *env, bool secstate)
+ARMMMUIdx arm_v7m_mmu_idx_for_secstate(const CPUARMState *env, bool secstate)
 {
     bool priv = arm_v7m_is_handler_mode(env) ||
         !(env->v7m.control[secstate] & 1);
diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
index 857e897a48d..8de3a6fdad5 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -30,7 +30,7 @@
 #define SIGNBIT (uint32_t)0x80000000
 #define SIGNBIT64 ((uint64_t)1 << 63)
 
-int exception_target_el(CPUARMState *env)
+int exception_target_el(const CPUARMState *env)
 {
     int target_el = MAX(1, arm_current_el(env));
 
-- 
2.53.0


