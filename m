Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77679C624CF
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 09:56:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1LC1-00020E-2i; Tue, 01 Sep 2026 05:54:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x1LC0-0001yj-4M
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 05:54:12 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x1LBy-0007fc-Ck
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 05:54:11 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68179GlV2561935
 for <qemu-devel@nongnu.org>; Tue, 1 Sep 2026 09:54:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ujtZfmyEeRuspxcgfhS3V2xIrt3RbrmKuzrHykBSXQI=; b=ccn16Hcx1CjwfTnh
 jukcwrF90/I+Pq08vxeEkhaJbogyQMfcciK+7j3eq9MAEuQNapDBPZ+ydinQ+8v2
 GWP8ZO3QAXzMmt3Awhc2kUTRZdAT0uqB2BXVhe0GmENxFFttnmhngIrxnZmxXY47
 1PgH+Ajo3kOuny1BbbZsBi7ze/hapELb6B6e+ZT7HWBc2SeSXhMng6cDcZv671dY
 jk7Dvy+mTXIwIDMdiBLv/1/z3GR/aY4ziRtgbXIGvNRzyI6+mMvGBoMUv/P+b8ZS
 FiZM9aFeQ960r/fa0M7vnoiMCcKxTy36zBYQkutdBVfxga5sPEdfZBaFeiZHPxnf
 HZY49Q==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gdeg3bqr1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 09:54:09 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-9390ca1a9abso116130285a.2
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 02:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788256448; x=1788861248; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ujtZfmyEeRuspxcgfhS3V2xIrt3RbrmKuzrHykBSXQI=;
 b=HnP9slVVZg2CHCHQ8ALdZM7Daslx6FUkYlwqOel0PllvoPnTdMKzTlkXSYM/zm7dsW
 A4ILn+BYhE3c6UmdiYSfeqALuf8i5qjHZsEHgOQmeqjpsgqamrLST4jin4oBXD7SCFRj
 vnok/rjAGXD0yGrnq0JgoxYH027tttc3iY7PUSF1nHuBEPQxwxKBsAu45aE5Dsg8CNJk
 JrteGfVI9AUAMV+PmgQ3ABDgr+fmsFPl9EixoPq+0B7nl4l3+OxIUXj7fd3wk2qspW1m
 SL/ynNBYC7dECDoNSDjlDAOWq3T/KRIB2HQ3FKeSD5ue8kaflL3dbsIukv2G/oqVap/m
 Z+BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788256448; x=1788861248;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ujtZfmyEeRuspxcgfhS3V2xIrt3RbrmKuzrHykBSXQI=;
 b=D7r4RC7TJ2aUynSnbpjXXSOyou16LiBkeogNhv8nKATMRPoE39mTH8e7JeIhQA5DIq
 GJpD12trxoG1j+T5dTDYzxUwzztPmma9PlwHcgNj91/YXFzsO+qQko780672avvWKDZ8
 PEFaw7aCeeYc0FbfFyB2yMKhGcD++UkVOvOKDd0fqMFiHHQocOM1bSHp1KRz5rFLQJy3
 FVuUGq7WaXQYPOjHX2b6BEgMlHtt1fVei93WK7WjUNuq9eTl/LfLzzSdDjLLs2jppklz
 BVJQ3vvThdmwLOyhoSZOTUcbWLUSg2nI8Zb581kgZ6cPSF5NsrSsxMnvpzWYmG/Ae/56
 O0GA==
X-Gm-Message-State: AFuF++kEvGTjzIjFIjyiLob/WVs4zA4IRGx1FP/l7OQ7QSJfOxhUPQd6
 kK740MMZDrfD/QIOwd7WArbHG/HNzhfxr4GGqiZGP/4Xg5ShjFHsltMH+6KYroRGW6Ury9DJsbP
 appcm2Iig5U77E0tv5CvvmX+N7vgertq0ZiKoCdTWxKvpX2hBxONO9uNgV+RVPlW33w==
X-Gm-Gg: AR+sD12hcS4Rlggujjrf4zrjEvqZ5FUvTdWgpUohI+5to0JRyavFE9QOK/A4+TEw3e4
 o6whfmXQRcvDzjwBbMVe5JB3ai7ZWlI6GdLrugO3sbTpAlQDWZBtmMoBlE6q6Sd2ZBB+ZNWjwtn
 ipdGLR+az3mhTJ1COCbvt1cFo5FMOQGQPpi/HvDpc7N8juSu9rrRHwr+I+5OM9HSHJc6ZWxDlex
 bXJtyv6aUkglqiNmJ0stUVx6ZPPi722nudj3SIjYi2NtCFscobnQ3v7S0BkGCuweamnO0YiZa0/
 gHvsJ3PVH4LizYqypfXXcqsFWmoXIIK4lfBcAU1odxIEdaUoEtkCqenVctifz313au3w/rPV2Dx
 dFS6CjX8UmRNVvRaBrWjzPPR6HJuikTvNv2hOO6ba
X-Received: by 2002:a05:620a:458e:b0:939:3cb9:553d with SMTP id
 af79cd13be357-9393cb956bemr1401255985a.38.1788256448134; 
 Tue, 01 Sep 2026 02:54:08 -0700 (PDT)
X-Received: by 2002:a05:620a:458e:b0:939:3cb9:553d with SMTP id
 af79cd13be357-9393cb956bemr1401252985a.38.1788256447715; 
 Tue, 01 Sep 2026 02:54:07 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b9267c369sm237418685e9.3.2026.09.01.02.54.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 01 Sep 2026 02:54:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>
Subject: [PATCH v5 13/21] target/mips: Constify CPUMIPSState for various
 cpu_*() getters
Date: Tue,  1 Sep 2026 11:52:19 +0200
Message-ID: <20260901095229.72018-14-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260901095229.72018-1-philmd@oss.qualcomm.com>
References: <20260901095229.72018-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDA4NyBTYWx0ZWRfXyBtciEt3SWTC
 Q0B5JY95Xj4sopXkZtVamCFOt0mPwN736jRBVqeXj1yRR8kfI9SdV0GCpDx7nJYoR+aPDKLzMrz
 Bqbj1ZvFeXIOD8tJGlajsGz8oSXqkKM8e87niyHiMQxNxHPhRnJ6NkeyhRq/aP6KukL6/yJQ5sQ
 jyF30H4KX4VML+hExRpckzJU3W7xp1iEj73LYeJ/vn+WlIjtJlGlmtlVMGE/175CDaYNMD7fVas
 GvEmm+Ak12+2TKVh75HeZblpAYw2B9LU/m9o2iE8ml6E5EHEGXpK9PwmyLlK97tKNf024FkwEuG
 0ySISzPef1LX0gPlNS0eEOAjsA28Xq1251snKLkmQQ48coxDFUxu1qG9PXln42+mNj2nv9kPKBv
 IIDVMF7atYFvKyKcQeGGqUZvWTEtbDHAmkLsJGQ0z45wYANMU7hZT4091zhnOYqNcus4SPC+t3X
 C0ROClEZz833XHVnWWw==
X-Proofpoint-GUID: p2L7Iiyt1e6O-p4DoBgzOsRkcatU38nY
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDA4NyBTYWx0ZWRfX37D2EaOy4b8u
 Q6QF9TLqj2/9rb6G6tO5ZWbCj9P95C/ZMXLqt76MdMrSB+nBYkez4DmAtaAVZbNK9gyI9Ee78u8
 TSMWoWaevnT7uiB2OUc4536jLnNGZAM=
X-Authority-Analysis: v=2.4 cv=NZnWEWD4 c=1 sm=1 tr=0 ts=6a96a0c1 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=h4i2fRRWLofFFTjKLt8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: p2L7Iiyt1e6O-p4DoBgzOsRkcatU38nY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_02,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609010087
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

Add the const qualifier to CPUMIPSState when
the argument is accessed without modification.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
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


