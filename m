Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75CC8C624D7
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 10:43:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x24ub-0005Wq-2E; Thu, 03 Sep 2026 06:43:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x24uZ-0005Tt-Lc
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:43:15 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x24uX-0006wp-Uj
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:43:15 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683AHCs9162798
 for <qemu-devel@nongnu.org>; Thu, 3 Sep 2026 10:43:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7LN5/bTTppSoZfmkwWBxvOGxhVP9lcaCbEvP3eVz2+s=; b=RLzhBv7R5HFDgBU7
 ejLRfWlcs/pYiRkc0yJnlB+ZSVLL1RnFmxSyZx40BUgJMQfRMOFnt+2YfFSaFnmO
 W/RULbhbR/v71tvpkMoHaYDG8n0b4xcjS+llwyLRPGjl7GKWksu7tU2tGPf8LKwe
 ozFCssVWq7LCvDS1nJHre9CUnQYDQw1yxFkiWCc34XdiRBl2UIOupby+IRVgQJ0Y
 xMts89CCKWiePIh4WyQbCdxrMVrpDaLUgGukXazIj/ZewK5hYQFP5JSAr1HGkABj
 vNxPV4cOHqI0h4MfOGP+hpNs5fpnBneQa1wFtySwVyOWey3vlTiQKh5HI0iYYYPJ
 cD9y5w==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf6tx04p4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 10:43:12 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-9393ac4961fso163213785a.2
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 03:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788432192; x=1789036992; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7LN5/bTTppSoZfmkwWBxvOGxhVP9lcaCbEvP3eVz2+s=;
 b=SMRHOwXu6i40ehJZfQsvjqv791qCqW0CLzm3btDmjlDUkRH716uJhjz8v+TZZcJ21n
 wP4URiRucRQTnKoZpRVXlWFNM9vF5bjhE6fymvOhW9V79ndiZhoB01bTk8LRJkXtcxS9
 sHSZkq7SNUcSwIjhvcAc2gGF34uPGkd1wuWR21RpJ2/TJrZ7fGenONupjLyA34PFkqt3
 sOZBg1EzR3BoeamlNh034/zH3F1H3505g7gw1/rrVRHZGIYlcv4o6Cmyx5lv4Z10y+0L
 5l816PUypLhAbooOxTx+TBKFn/PzcY0YttHn9LLHdsyqaSjseGE25SYn3pF4pfsCieM6
 OpBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788432192; x=1789036992;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7LN5/bTTppSoZfmkwWBxvOGxhVP9lcaCbEvP3eVz2+s=;
 b=jSOyL3+1vUKZdFT553XruqP33kHnC5iwWbg09Rwao8EMX5gEZfZAMkqL3gkJRjKMOs
 1w3gTO8s7n/YrTaynbMOa1Q5j27rGjTXWaH+TOl14SMWP7X/yVvX0IfygDakGbGt0qM3
 m+kwfv5JZDYM3JfPx9pfS+2XUXHIV+F159mm/rd6aNFBHlzX4vajfKCOpHoGhgMHedUI
 0E2X9AoAXLzK9EFcA9DD/Jx5gSCmYDRJzO7CTIiq/9LFU4J4t0h0Zdz6yBD5iQEyKWWD
 Du3weMCV40cvJBCFD5rtgp3xVifM/5iRyMBCC6Jsja5DIGhY8H8RPC4+TzihLc0NxmD8
 3WUg==
X-Gm-Message-State: AFuF++mkoCF7narT84MmtPrOwHV/HqLKTjXPI+jI9WKMGLPTXzc6yZE5
 vYyo9OOe8gJq/+vAoRT/kqBiG2GYa+bIAAqXGnyFIiNqkw0X9AGpodgKLRYcsF0m7nrwKXE2W3S
 6totauvQG6j9pPR2wvap45cPokH3R7Q9xPupfssW0bn/K2N7yYxvVEmXPg9+m78YwCw==
X-Gm-Gg: AYBFou1oHM2L+OpqcRAH1V2q3p+xiNoaj5IPHfatwri2DDL5PKAVqRcw1CDrdfJuq0A
 nYEsayl21dL61rrMHKs4Z3xc6oKVWBaflMALNx/FkF/UupYo+vnKm/0Rjbhu9P8uyvzXAr1pusS
 CJHkwvxFiW0QmcQuRuIAANxbbIxK6JNtsey6FkSRIGlh1tb+2soU+j36SpASTmdRMAi6kRGORCF
 KwjTd73F+k5ZJduAWwo2ATVCa3GichcW1Wvy3kHhsuGwfmZLnYSO8hy+SjvJ+gHOnEHllPnqD0N
 dpGE1pXHjB4FI6CSP0OSOD8StDsFAt+P278v9+HWRboub8yZliS11nVx/7DJGc0JcEWUufuKHtC
 rqB0ABq7+UghF33Eet7h2BHaseq4Jgwh1NmkHrp4I
X-Received: by 2002:a05:620a:648a:b0:939:353c:cddd with SMTP id
 af79cd13be357-93960ca2320mr1094233085a.9.1788432192134; 
 Thu, 03 Sep 2026 03:43:12 -0700 (PDT)
X-Received: by 2002:a05:620a:648a:b0:939:353c:cddd with SMTP id
 af79cd13be357-93960ca2320mr1094230285a.9.1788432191557; 
 Thu, 03 Sep 2026 03:43:11 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48448ed2edfsm12619799f8f.23.2026.09.03.03.43.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Sep 2026 03:43:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 29/51] target/mips: Constify CPUMIPSState for various cpu_*()
 getters
Date: Thu,  3 Sep 2026 12:39:13 +0200
Message-ID: <20260903103936.62355-30-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903103936.62355-1-philmd@oss.qualcomm.com>
References: <20260903103936.62355-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Y5GC14r0BrrG4hTbyu-vCgFKtN4pW7IG
X-Authority-Analysis: v=2.4 cv=TqjWQjXh c=1 sm=1 tr=0 ts=6a994f40 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=h4i2fRRWLofFFTjKLt8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: Y5GC14r0BrrG4hTbyu-vCgFKtN4pW7IG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA5MiBTYWx0ZWRfXxV+BHNi3CMrg
 lLS5o3xgE18yG3SW9I3eWiCSq8DYmm3PkD/BspiB5d6eR9V1hIOFvebcxukPtqzLijDFlOT+TZp
 hZHXTQbpiC3d39zeJbhwDmO/641S2alHz/Yc1DPRNM/V3mah/mJGJctj7r7LyuObiCQTWnVEnHk
 WrVLZOuD0HaqVuyeQMjnBYdhAijoluaxiPEztnoo83sWrkzqxGSmlRiCT1xHFLw5099H8/sGjpF
 Nu/wNjdXUc5WVzZ0r8NKlOxQxPlzOInl+1r1zthoLHDEJzRD+wb3teMXNuD01Bo0M0EbsGSvqH1
 Ydx8gW9V/bOfDFqEjqtYYuh55qUdbyD4x96ULUaf+hIDaF8eEPV446PRle9cXNgtsCoFqCQ+9d2
 3mkDr19TGQ5B/378lswY+nMleRGjKd8NKr0uBpGrMlme7K16viE08ZHQoCVtPP62wTv23smlgd4
 xr4CfT6ep79+zx+C9QA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDA5MiBTYWx0ZWRfXwsYKSDq+Hv6q
 +uiJHSJkw6h8jYWCPZ9QXfh4Xf7O+JjNGjExIZE2RpPocjv0FXSwekidiYh7L9i5zyF4gOmnuX9
 mpSe43uTRJ/qcObfhj2NNwsVZB0h6nU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 clxscore=1015 malwarescore=0 spamscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030092
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

Add the const qualifier to CPUMIPSState when
the argument is accessed without modification.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20260901095229.72018-14-philmd@oss.qualcomm.com>
---
 target/mips/cpu.h      |  8 ++++----
 target/mips/internal.h | 10 +++++-----
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 319147a948c..32549791a18 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -1300,7 +1300,7 @@ static inline int hflags_mmu_index(uint32_t hflags)
     }
 }
 
-static inline int mips_env_mmu_index(CPUMIPSState *env)
+static inline int mips_env_mmu_index(const CPUMIPSState *env)
 {
     return hflags_mmu_index(env->hflags);
 }
@@ -1372,19 +1372,19 @@ static inline bool ase_3d_available(const CPUMIPSState *env)
 }
 
 /* Check presence of MSA implementation */
-static inline bool ase_msa_available(CPUMIPSState *env)
+static inline bool ase_msa_available(const CPUMIPSState *env)
 {
     return env->CP0_Config3 & (1 << CP0C3_MSAP);
 }
 
 /* Check presence of Loongson CSR instructions */
-static inline bool ase_lcsr_available(CPUMIPSState *env)
+static inline bool ase_lcsr_available(const CPUMIPSState *env)
 {
     return env->lcsr_cpucfg2 & (1 << CPUCFG2_LCSRP);
 }
 
 /* Check presence of multi-threading ASE implementation */
-static inline bool ase_mt_available(CPUMIPSState *env)
+static inline bool ase_mt_available(const CPUMIPSState *env)
 {
     return env->CP0_Config3 & (1 << CP0C3_MT);
 }
diff --git a/target/mips/internal.h b/target/mips/internal.h
index c5c286872eb..7dba22300b1 100644
--- a/target/mips/internal.h
+++ b/target/mips/internal.h
@@ -165,7 +165,7 @@ void cpu_mips_store_cause(CPUMIPSState *env, target_ulong val);
 
 extern const VMStateDescription vmstate_mips_cpu;
 
-static inline bool cpu_mips_hw_interrupts_enabled(CPUMIPSState *env)
+static inline bool cpu_mips_hw_interrupts_enabled(const CPUMIPSState *env)
 {
     return (env->CP0_Status & (1 << CP0St_IE)) &&
         !(env->CP0_Status & (1 << CP0St_EXL)) &&
@@ -180,7 +180,7 @@ static inline bool cpu_mips_hw_interrupts_enabled(CPUMIPSState *env)
 }
 
 /* Check if there is pending and not masked out interrupt */
-static inline bool cpu_mips_hw_interrupts_pending(CPUMIPSState *env)
+static inline bool cpu_mips_hw_interrupts_pending(const CPUMIPSState *env)
 {
     int32_t pending;
     int32_t status;
@@ -247,9 +247,9 @@ static inline void restore_pamask(CPUMIPSState *env)
     }
 }
 
-static inline int mips_vpe_active(CPUMIPSState *env)
+static inline int mips_vpe_active(const CPUMIPSState *env)
 {
-    MIPSCPU *cpu = env_archcpu(env);
+    const MIPSCPU *cpu = env_archcpu(env);
     int active = 1;
 
     /* Check that the VPE is enabled.  */
@@ -281,7 +281,7 @@ static inline int mips_vpe_active(CPUMIPSState *env)
     return active;
 }
 
-static inline int mips_vp_active(CPUMIPSState *env)
+static inline int mips_vp_active(const CPUMIPSState *env)
 {
     CPUState *cs;
 
-- 
2.53.0


