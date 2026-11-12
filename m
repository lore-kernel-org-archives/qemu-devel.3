Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E75606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 18:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lMmn/cwU;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MdSrcHsf
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRZF1-0000jz-BT; Thu, 12 Nov 2026 13:09:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xRZEv-0000j6-NP
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 13:09:37 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xRZEt-0004jw-Qq
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 13:09:37 -0500
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ACFZahw657060
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 18:09:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 LDt9m4VL31vta49qyUdzCLLxgvh4VaLWpi+uQnOPXoc=; b=lMmn/cwUfRxiEtwC
 kyqr/R6Cc63g5zS5H3OjZFXXa6zopacK1HnJQFaspiZC1IKlXrAknsLfW+oCqhte
 4rwV63ShowTerh5ROwh6BC3URm8ViB+yDCpbN3r4spQRH4Q6nyqSlJOawmeXmHJV
 /rxmnbA3xNLVFRMic3zHDSXWDx8BUBWZFiLh1xLJYnXp6V/DXyFAtKs2+tZGOjZv
 YECaJrcvTdAmnS7ib6VIjdkw4cHuuLJVUwXh4h32E5k5uRYs0G/2WpDUZTc7Rsni
 MZ/gAq31UZuBooSUg5beEmDTKIjKRfxfd86W7hhCvE20fcNLByTmmXwpFHSHqCSK
 Z/eRZQ==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hw6yujvg7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 18:09:34 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-7cc06b9ca9eso6017137.0
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 10:09:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794506973; x=1795111773; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LDt9m4VL31vta49qyUdzCLLxgvh4VaLWpi+uQnOPXoc=;
 b=MdSrcHsfcOGIfkdfRH77jh9MRZuW60BBMwvNuVX4wvw50ZrhEGOiz6JCSOSlix0zUZ
 5Uvx0/f4XZDZGT1/x+rCOHB+pL9vfUl+AT4WOaf/yNa7rIAtAgVciUSy7o8Imu51WLIx
 IPgJxf2ZMLJkaeHbC2f38EgsbHbBHz6IjMs/uYX4BC4Aa1dK4gCREjdSVavmzGFO1bMN
 fxEuF/jr7KPYDpaebnE9a7NDvRh8t0URqX86O1eHLVT47HSWEqTqtsiHkiix4/sBaafF
 AcGxXg4urFf+j9bjHMbpX9EYi3inm+wdAfKslYn/GGscPLKzNn0TAbD7vUZp/U2EFRkw
 NmOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794506973; x=1795111773;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LDt9m4VL31vta49qyUdzCLLxgvh4VaLWpi+uQnOPXoc=;
 b=TRO3rQhme3SmqOw/qS9zvak0HAP5wTPo9d2yijdZX5t8CMx7Ks7O8K+nboSQMOPUZY
 tvs0CQ7ZiNO1m+LUyhfZtPWYaWmznbJeuuA+2RpNnp8NbXHQvhw1tmNpGaT6qdrKM60i
 pcrWXUzFRj2skI2Nis3IlCExd0syeD8F8UvgGZI2lOJpXkPFWeHbSuaAemzkDMwmUVwa
 VnNRyO3YeKq1S8bd4do/9q3X7nBUVmNH5MRGMpuwlVtbazdGx3OzlIVUuylkFKKbA+Bi
 4U+v6iSm91brhco+Dd/XFYhHUZx0P1pfDYTnjx/VUzSxpMCdBDGL4SypaR9TvMdGWDTB
 /sOA==
X-Gm-Message-State: APuU4Z8Rd0o4ulJw4TRQzAGgxNEp5KdOB/1MysCGRkGLRBa+OpvnzG5Q
 oxV3VMZvJVPJ8FEbdCix9Merv/QtvgDI5G0FZQ/uqVwwMlmR7UQUbV7+SUghBteh855suquRLLm
 ty2EtE016C4yM8t6m2NFMAJKdJnJI2ST1+4yQ7Gdd05wDLpg6/QdLH1NeRl3FPA6F2Ytn
X-Gm-Gg: AYBFou1rTTJOYYxxrZQ5FVdravWt9mbZWJVj6+zddtRjTbrWrvo5Xg/MgIvJ+E9VPYC
 G5Vonlbhr0Oz4dJxVBDmzSs7al8caBEeenLUrwUroBYI+kqVTYWdqV15wyFwuezkW5SaOHiyjrk
 lvwal5bF2GKFMsqy90oO4H8S6SVJ6YakyKrrO6dnlrB0CVk+0Q7R64M//GMgdjFvgtyvghtgdmc
 jdNyRDM3AnRHK/Qtl56BlR4MJiu/uyUsGwFEGTDLWzCRIw4bZ6CIujPKqA47BCjhSfdjFhSzhg8
 +P2LLi30HqkCqA7GjybNsJsI0e2GjhkCwBTb/J3s2n4b2L59c3H0GWBPDbVp3ATp0ImJZ8z1JzB
 MYSXal/eqlNYdpXA/XLkHd/0ONrhmA7pR+6K0t9OKOl0/qE6PhN5DjdKLs13ADafevM4A8+Fy6o
 oCohh+E3duQCIugQ==
X-Received: by 2002:a05:6102:5cc8:b0:7cb:288a:b68b with SMTP id
 ada2fe7eead31-7d506146d9amr2328769137.37.1794506973114; 
 Thu, 12 Nov 2026 10:09:33 -0800 (PST)
X-Received: by 2002:a05:6102:5cc8:b0:7cb:288a:b68b with SMTP id
 ada2fe7eead31-7d506146d9amr2328750137.37.1794506972613; 
 Thu, 12 Nov 2026 10:09:32 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c60da11c5sm508143f8f.54.2026.11.12.10.09.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 12 Nov 2026 10:09:31 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 devel@lists.libvirt.org, Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org
Subject: [PATCH-for-12.0 v2 04/12] linux-user/aarch64: Move CPU/signal endian
 checks to runtime
Date: Thu, 12 Nov 2026 19:08:50 +0100
Message-ID: <20261112180859.85380-5-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261112180859.85380-1-philmd@oss.qualcomm.com>
References: <20261112180859.85380-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 8LsETIwIzZvu1sIjH5WwH2V20q6HkGmp
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA3MiBTYWx0ZWRfXxYafh5dV6oB/
 Y/d5bRRy0ePxoiMrpUyVk9OI4BJbGka8ue/YBGfIQB+l1sO/8kmvOgHxdc5ckUK50wlDPHxGDUR
 MGb/phUNLuveFN/oBGCbmMnDJTO1YTQ=
X-Proofpoint-ORIG-GUID: 8LsETIwIzZvu1sIjH5WwH2V20q6HkGmp
X-Authority-Analysis: v=2.4 cv=d49gWhjE c=1 sm=1 tr=0 ts=6af600de cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=vkEjUumcn_Dj4zhYd20A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA3MiBTYWx0ZWRfX586GubyImMX+
 h71phFzrdePrz1EfkZ0ksLrPR1hzeHhVj/rFtvgn9I99duhpbixtDJhUgucaKKs3sBJyyrAo1VY
 puRSHXeHTd66AKo3+eH6IqWymTeWfTZ/Cig7TcUl9ZiGyB+V9lZwSAa98khiv16kHIhU4RliZok
 zsC9KQegPLuzMG6dMGUNlOWxAUKp2+8Ye9cbZnk2PhCfRLcpACf8IBLq/FNCyAUv4d6ce5LADSN
 Ha1gmiGVCIC/aIzbImuTj5H610I4Fuuj1XudmFq1ElqWJkniuIN6grfqXm+ka/I1u9Nd8Canxtj
 3hMInKQfMJN3duFj8WTQSX8OzjhmRHSmhVtaBtShw0ifH8DKGnPA85Rqr7SgbQcBoHts1hYTvdK
 NJ+NJ5U2UpVtZdvLMcRjVa8OY58SEV0UGXh84APwgycJDRD9IPCjf6rv1+RwrF41/UOq4jOMTuv
 vt1y2vcQoCUctn0Dr6w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_02,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 adultscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611120072
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Use target_big_endian() for CPU endian initialization, FPSIMD
signal-frame ordering and CPU-versus-ABI byte-order checks.

Preserve the behavior of the existing fixed-endian targets.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/arm/internals.h         |  2 +-
 linux-user/aarch64/cpu_loop.c  | 12 ++++++------
 linux-user/aarch64/signal.c    | 20 ++++++--------------
 target/arm/gdbstub64.c         |  4 ++--
 target/arm/tcg/translate-sve.c |  2 +-
 5 files changed, 16 insertions(+), 24 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 033d6d66da3a..1381ef9638a3 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -588,7 +588,7 @@ static inline bool arm_cpu_data_is_big_endian(CPUARMState *env)
 #ifdef CONFIG_USER_ONLY
 static inline bool arm_cpu_bswap_data(CPUARMState *env)
 {
-    return TARGET_BIG_ENDIAN ^ arm_cpu_data_is_big_endian(env);
+    return target_big_endian() ^ arm_cpu_data_is_big_endian(env);
 }
 #endif
 
diff --git a/linux-user/aarch64/cpu_loop.c b/linux-user/aarch64/cpu_loop.c
index e7f643d69d56..91ebf4e0778f 100644
--- a/linux-user/aarch64/cpu_loop.c
+++ b/linux-user/aarch64/cpu_loop.c
@@ -242,13 +242,13 @@ void init_main_thread(CPUState *cs, struct image_info *info)
     env->pc = info->entry & ~0x3ULL;
     env->xregs[31] = info->start_stack;
 
-#if TARGET_BIG_ENDIAN
-    env->cp15.sctlr_el[1] |= SCTLR_E0E;
-    for (int i = 1; i < 4; ++i) {
-        env->cp15.sctlr_el[i] |= SCTLR_EE;
+    if (target_big_endian()) {
+        env->cp15.sctlr_el[1] |= SCTLR_E0E;
+        for (int i = 1; i < 4; ++i) {
+            env->cp15.sctlr_el[i] |= SCTLR_EE;
+        }
+        arm_rebuild_hflags(env);
     }
-    arm_rebuild_hflags(env);
-#endif
 
     if (cpu_isar_feature(aa64_pauth, cpu)) {
         qemu_guest_getrandom_nofail(&env->keys, sizeof(env->keys));
diff --git a/linux-user/aarch64/signal.c b/linux-user/aarch64/signal.c
index 899fce76436c..f24fcddfec3e 100644
--- a/linux-user/aarch64/signal.c
+++ b/linux-user/aarch64/signal.c
@@ -208,6 +208,7 @@ static void target_setup_fpsimd_record(struct target_fpsimd_context *fpsimd,
                                        CPUARMState *env)
 {
     int i;
+    int big_endian = target_big_endian();
 
     __put_user(TARGET_FPSIMD_MAGIC, &fpsimd->head.magic);
     __put_user(sizeof(struct target_fpsimd_context), &fpsimd->head.size);
@@ -216,13 +217,8 @@ static void target_setup_fpsimd_record(struct target_fpsimd_context *fpsimd,
 
     for (i = 0; i < 32; i++) {
         uint64_t *q = aa64_vfp_qreg(env, i);
-#if TARGET_BIG_ENDIAN
-        __put_user(q[0], &fpsimd->vregs[i * 2 + 1]);
-        __put_user(q[1], &fpsimd->vregs[i * 2]);
-#else
-        __put_user(q[0], &fpsimd->vregs[i * 2]);
-        __put_user(q[1], &fpsimd->vregs[i * 2 + 1]);
-#endif
+        __put_user(q[0], &fpsimd->vregs[i * 2 + big_endian]);
+        __put_user(q[1], &fpsimd->vregs[i * 2 + !big_endian]);
     }
 }
 
@@ -402,6 +398,7 @@ static void target_restore_fpsimd_record(CPUARMState *env,
 {
     uint32_t fpsr, fpcr;
     int i;
+    int big_endian = target_big_endian();
 
     __get_user(fpsr, &fpsimd->fpsr);
     vfp_set_fpsr(env, fpsr);
@@ -410,13 +407,8 @@ static void target_restore_fpsimd_record(CPUARMState *env,
 
     for (i = 0; i < 32; i++) {
         uint64_t *q = aa64_vfp_qreg(env, i);
-#if TARGET_BIG_ENDIAN
-        __get_user(q[0], &fpsimd->vregs[i * 2 + 1]);
-        __get_user(q[1], &fpsimd->vregs[i * 2]);
-#else
-        __get_user(q[0], &fpsimd->vregs[i * 2]);
-        __get_user(q[1], &fpsimd->vregs[i * 2 + 1]);
-#endif
+        __get_user(q[0], &fpsimd->vregs[i * 2 + big_endian]);
+        __get_user(q[1], &fpsimd->vregs[i * 2 + !big_endian]);
     }
 }
 
diff --git a/target/arm/gdbstub64.c b/target/arm/gdbstub64.c
index 0c3e5b30bd6a..ee6ed8296e33 100644
--- a/target/arm/gdbstub64.c
+++ b/target/arm/gdbstub64.c
@@ -122,8 +122,8 @@ int aarch64_gdb_set_fpu_reg(CPUState *cs, uint8_t *buf, int reg)
              * On the wire these are target-endian 128 bit values.
              * In the CPU state these are host-order uint64_t values
              * with the least-significant one first. This means they're
-             * the other way around for target_big_endian() (which is
-             * only true for us for aarch64_be-linux-user).
+             * the other way around for target_big_endian(), which reflects
+             * the executable's byte order in Linux-user emulation.
              */
             if (target_big_endian()) {
                 q[1] = ldq_p(buf);
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 10375577b1e0..6c4cf29238c6 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -5165,7 +5165,7 @@ void gen_sve_str(DisasContext *s, TCGv_ptr base, int vofs,
     /* Note that unpredicated load/store of vector/predicate registers
      * are defined as a stream of bytes, which equates to little-endian
      * operations on larger quantities.  There is no nice way to force
-     * a little-endian store for aarch64_be-linux-user out of line.
+     * a little-endian store for big-endian Linux-user guests out of line.
      *
      * Attempt to keep code expansion to a minimum by limiting the
      * amount of unrolling done.
-- 
2.55.0


