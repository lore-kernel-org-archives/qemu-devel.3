Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F1C606A31E
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 18:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=l7uGevIc;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=h50Ut6hJ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM7xb-0006U3-1L; Wed, 28 Oct 2026 14:01:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xM7xZ-0006Su-71
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 14:01:13 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xM7xX-0000bw-DP
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 14:01:12 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69SFA68Y1471906
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 18:01:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 yIBmzX726skcweEMe4wBEEk4OwOS2iguJf4vAJRMnms=; b=l7uGevIcwUn0lUxy
 lU4bQT4/WZaN03cPTDiKakDDDGr6k34wUefdoGmKrC4jMJdoYe8g+5alB3wJUulY
 HDAG315NALc7R03IdwGLfy1XZv3coaNmh/23YsOVkeGafrU30AGp1kQNijwnA1Br
 qvl0jJpzfxKqO4TGaSrDbiS5obHs3pRdSvWH7r8VqtzdVpa03ZnVYcuAhJiL19d3
 CWZzbBhiTXWLeGXSPEwzGPCdpO4lIiORgm9ifVaMM9Qg5F1ESXYp5W6yu/TLZZIV
 3+gUX8hBRGEL9u4XO2VkdVAQ53NwOI9SgnR/QLxzIrILGlnxwCnj8uwjfDjNZ0/2
 hH+zAw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hkfehhux7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 18:01:09 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93f5844e383so185876385a.1
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 11:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793210469; x=1793815269; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=yIBmzX726skcweEMe4wBEEk4OwOS2iguJf4vAJRMnms=;
 b=h50Ut6hJF4p3WGhYFc6Svk9r2fmmRFN7ceyD0HBX0Tj8Rrd8sy13/Qa7l7Zli7RaF0
 GKF3bcrHmW339ZZy21nQGwnZ0cu8iIHg/6PYAdYALNpsGKWmaoVwxyMqfzLIAom7VXgZ
 KF66p2m/EeCDS60ttCxN1DqKegjQzkBkpaS9bJuHTUYq42x58N7nPkgEwksshyFy6K+j
 sLKwBv6tslPz5QU3l04yrpLw9xr3fmVUyGExm5eSIL7w6OQ09tphJChFq3+dVME4fNLH
 yjsQ/7RzeAjcv+BkPf/thDnCjrBaviahe1JImVRGkSZuedwvBf0b/fat9+ClGm626lph
 NYZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793210469; x=1793815269;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yIBmzX726skcweEMe4wBEEk4OwOS2iguJf4vAJRMnms=;
 b=fw1cLHhxngpG4zHkNujrxaGXyuXTP7JHxdCe0hm/oHqNHiJ8sbVA6ZTgUMRGBNWpze
 6/6TgPFzD58MnWWzLCSL1NroCFi2QtgTrNlWdZ/udJZ5rk5hCt1eT3k5L46pSZaf2DWJ
 C+xrJAnIfAoSGUVbh3YirvXTfaa7amIHC8/idi2cgtSVq5blYCEyFJPY0FPSMwdX3WSF
 PW8z1iBACLjJtESebNz6CNn1re95NG0aGLJONVlNmWUHDm618YHRDpBsa4Wcj0qdZ6L/
 eLVOuCTsjgVvMSdLD8/BM6XORddo2TGPe/qrjZ8YzNg6GUWR8FKC+5448bZbK5OBU87Q
 a7Qw==
X-Gm-Message-State: AFq9FYJ6pQBE1InOnenK4UsRYHt/51bdBu7iBr/8u3vYDaZa34QsO0l2
 9Nc4LRSSSGaSWBRNCvqoHS9oHFMclIkIHB1fCc1EOaSszOVWP0kjZ8fvt3yjsrE1z7feu/P+xjI
 7jdKN9iG6EvECW0Ar9zcw2iKeNkb/WdWtYH7G2dPiaU3Wcfdko630oj/y18gua9Wr5F7L
X-Gm-Gg: AYBFou0YUTBPwMNEqsvtybKUgKbkw4/Jw6Rt8Q/iffA6IAIl3d1fDTYRTNjHriPGo2u
 bp9m93DaXxUVgJG+Y1ZSULyjrybDKUHphDNVF5hMbq+hoGpv6FbDdXsoxGNZ2i1yKy8Jp1d6bgV
 9hKNi1dBRQ6TlxUOJQe4kd7lUBb8IyA2vuEdwa30ASnh9JMsYPpLj8UlxbdgyTlBjIPrvoCGJdA
 2pb3dG69F0Ly4Q/uz3QnphFosnlnlnacvHJNU+IzAptH1bDHIC6hyVuVPaB9nuljD1irxN83NFg
 FQacTAhfZCIfI6Wx2Q9J8Fon6LEkusPVJohu8FAuUHp32oRHVHVyedEZFy0TCce7x+dE/DqrMGn
 kxtZaJxdQUj5ffZqtz9IPVAsTaMreAjVzZwmY6KZ/tIHJ5moK8ynSYH1Kk3rPk1lTfkA7p8/Ry6
 Nh8sp+AHFJB1GeH1/1GF1Kj6wTVWktEA==
X-Received: by 2002:a05:620a:1720:b0:93f:33a8:8e99 with SMTP id
 af79cd13be357-94408a26991mr480992385a.13.1793210468336; 
 Wed, 28 Oct 2026 11:01:08 -0700 (PDT)
X-Received: by 2002:a05:620a:1720:b0:93f:33a8:8e99 with SMTP id
 af79cd13be357-94408a26991mr480984985a.13.1793210467787; 
 Wed, 28 Oct 2026 11:01:07 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa81a896ecsm8415555e9.9.2026.10.28.11.01.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 28 Oct 2026 11:01:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH 3/5] target/mips: Constify read-only CPUMIPSState arguments
Date: Wed, 28 Oct 2026 19:00:37 +0100
Message-ID: <20261028180040.22848-4-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261028180040.22848-1-philmd@oss.qualcomm.com>
References: <20261028180040.22848-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA3MSBTYWx0ZWRfX5CrH7iWj3AJD
 ZrcBu1JRsDhK3nyXwuA5a3bJo+P+UKluI3SLHL6c21JR2z7o9hHA5oDI/xbxV9O1rfZj4kE3a3O
 awXa6IWOGg3Z9mOVdDzNWiow/JsC69gcyOti4ylW9vxqU0bQtP804vlSTa/W9btxjrsA5CCYEvN
 hdL4V/p+bXP0EhiKbN1WLNC6aqrWkviqttG/pE7WTHiDnzClGPU1tJ8zOEWgGUcd8MBOdBuls0f
 cEVQ4LIphz4/qGn86/Y/+qWsOJsq15Z+Ec6z/X6Eu76oogKnB/7eCVS+MgYDmw3mSRKAhGNqsy2
 aS7rPqILH4fnflM0dnOjjM4K7ULwYS92Y1/GN3OGXTsP8I8jIPWTyotVfkH7eMXNsgnCti/faoN
 s9Jx3lPm0PA7MNBEtOPutRQw4vedFHAH11OK0gGCJgZnXAsW51qRN1WeGuMcS4jEnEyIzsU4Wp2
 X9kJI7/URx6Pb0S7xeQ==
X-Authority-Analysis: v=2.4 cv=A/T5rKWG c=1 sm=1 tr=0 ts=6ae23865 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=Mo9p2WT0rmVKOyZZnzoA:9 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: 2u_r4im0j7ScEbaGrTQy3CFskQklsltT
X-Proofpoint-GUID: 2u_r4im0j7ScEbaGrTQy3CFskQklsltT
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA3MSBTYWx0ZWRfX8DPCUd3PsQRI
 ICiXMmnMHdud96lVXn6K0ZlaoBQO+zbEkW1YEX7dIozudGMKMfIBG0FHA76MmjnJKYVVpQeQW+z
 AhGYeEOKIA360okN3Urc3zC82+sThLg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610280071
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

cpu_rddsp(), exception_resume_pc(), cpu_mips_get_random(),
mips_env_is_bigendian(), mo_endian_env() and sync_c0_status()
only read the CPU state passed as CPUMIPSState argument, make
it const.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/mips/cpu.h                   | 4 ++--
 target/mips/internal.h              | 6 +++---
 target/mips/tcg/tcg-internal.h      | 2 +-
 target/mips/system/cp0.c            | 2 +-
 target/mips/tcg/dsp_helper.c        | 2 +-
 target/mips/tcg/exception.c         | 2 +-
 target/mips/tcg/system/cp0_helper.c | 2 +-
 7 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index b080c5de4de8..65d302a06907 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -1281,7 +1281,7 @@ struct MIPSCPUClass {
 };
 
 void cpu_wrdsp(uint32_t rs, uint32_t mask_num, CPUMIPSState *env);
-uint32_t cpu_rddsp(uint32_t mask_num, CPUMIPSState *env);
+uint32_t cpu_rddsp(uint32_t mask_num, const CPUMIPSState *env);
 
 /*
  * MMU modes definitions. We carefully match the indices with our
@@ -1413,7 +1413,7 @@ void cpu_mips_clock_init(MIPSCPU *cpu);
 #endif /* !CONFIG_USER_ONLY */
 
 /* helper.c */
-target_ulong exception_resume_pc(CPUMIPSState *env);
+target_ulong exception_resume_pc(const CPUMIPSState *env);
 
 /* fpu.c */
 void cpu_mips_restore_fp_status(CPUMIPSState *env);
diff --git a/target/mips/internal.h b/target/mips/internal.h
index 2c152e246a24..d4a4fdad9128 100644
--- a/target/mips/internal.h
+++ b/target/mips/internal.h
@@ -160,7 +160,7 @@ struct CPUMIPSTLBContext {
     } mmu;
 };
 
-void sync_c0_status(CPUMIPSState *env, CPUMIPSState *cpu, int tc);
+void sync_c0_status(const CPUMIPSState *env, CPUMIPSState *cpu, int tc);
 void cpu_mips_store_status(CPUMIPSState *env, target_ulong val);
 void cpu_mips_store_cause(CPUMIPSState *env, target_ulong val);
 
@@ -234,12 +234,12 @@ static inline bool mips_env_is_64bit(const CPUMIPSState *env)
     return env->cpu_model->insn_flags & CPU_MIPS64;
 }
 
-static inline bool mips_env_is_bigendian(CPUMIPSState *env)
+static inline bool mips_env_is_bigendian(const CPUMIPSState *env)
 {
     return extract32(env->CP0_Config0, CP0C0_BE, 1);
 }
 
-static inline MemOp mo_endian_env(CPUMIPSState *env)
+static inline MemOp mo_endian_env(const CPUMIPSState *env)
 {
     return mips_env_is_bigendian(env) ? MO_BE : MO_LE;
 }
diff --git a/target/mips/tcg/tcg-internal.h b/target/mips/tcg/tcg-internal.h
index 9f230e757d68..e055040b0955 100644
--- a/target/mips/tcg/tcg-internal.h
+++ b/target/mips/tcg/tcg-internal.h
@@ -48,7 +48,7 @@ void mmu_init(CPUMIPSState *env, const mips_def_t *def);
 uint32_t compute_pagemask(uint32_t val);
 
 void r4k_invalidate_tlb(CPUMIPSState *env, int idx, int use_extra);
-uint32_t cpu_mips_get_random(CPUMIPSState *env);
+uint32_t cpu_mips_get_random(const CPUMIPSState *env);
 
 bool mips_io_recompile_replay_branch(CPUState *cs, const TranslationBlock *tb);
 
diff --git a/target/mips/system/cp0.c b/target/mips/system/cp0.c
index ff7d3db00c73..d946c8fdd995 100644
--- a/target/mips/system/cp0.c
+++ b/target/mips/system/cp0.c
@@ -24,7 +24,7 @@
 #include "exec/cputlb.h"
 
 /* Called for updates to CP0_Status.  */
-void sync_c0_status(CPUMIPSState *env, CPUMIPSState *cpu, int tc)
+void sync_c0_status(const CPUMIPSState *env, CPUMIPSState *cpu, int tc)
 {
     int32_t tcstatus, *tcst;
     uint32_t v = cpu->CP0_Status;
diff --git a/target/mips/tcg/dsp_helper.c b/target/mips/tcg/dsp_helper.c
index 26fcfd5fb358..73934cab7786 100644
--- a/target/mips/tcg/dsp_helper.c
+++ b/target/mips/tcg/dsp_helper.c
@@ -3683,7 +3683,7 @@ void HELPER(wrdsp)(target_ulong rs, target_ulong mask_num, CPUMIPSState *env)
     cpu_wrdsp(rs, mask_num, env);
 }
 
-uint32_t cpu_rddsp(uint32_t mask_num, CPUMIPSState *env)
+uint32_t cpu_rddsp(uint32_t mask_num, const CPUMIPSState *env)
 {
     uint8_t  mask[6];
     uint32_t ruler, i;
diff --git a/target/mips/tcg/exception.c b/target/mips/tcg/exception.c
index 626fb00bc405..68c101a5a53a 100644
--- a/target/mips/tcg/exception.c
+++ b/target/mips/tcg/exception.c
@@ -27,7 +27,7 @@
 #include "exec/translation-block.h"
 #include "accel/tcg/cpu-loop.h"
 
-target_ulong exception_resume_pc(CPUMIPSState *env)
+target_ulong exception_resume_pc(const CPUMIPSState *env)
 {
     target_ulong bad_pc;
     target_ulong isa_mode;
diff --git a/target/mips/tcg/system/cp0_helper.c b/target/mips/tcg/system/cp0_helper.c
index ceffcc37323f..9c2dd1780c61 100644
--- a/target/mips/tcg/system/cp0_helper.c
+++ b/target/mips/tcg/system/cp0_helper.c
@@ -202,7 +202,7 @@ static void sync_c0_entryhi(CPUMIPSState *cpu, int tc)
 }
 
 /* XXX: do not use a global */
-uint32_t cpu_mips_get_random(CPUMIPSState *env)
+uint32_t cpu_mips_get_random(const CPUMIPSState *env)
 {
     static uint32_t seed = 1;
     static uint32_t prev_idx;
-- 
2.55.0


