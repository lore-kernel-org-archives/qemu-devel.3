Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0AB606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 18:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=REaHkrgm;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DQOkzYvY
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRZFa-00015k-M7; Thu, 12 Nov 2026 13:10:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xRZF3-0000l4-P1
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 13:09:47 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xRZF1-0005My-He
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 13:09:45 -0500
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ACFZCLm2593494
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 18:09:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 S/l24zL47yoc2vzyA8klzaXqJng2GJFFJTyIwtBzDck=; b=REaHkrgmUheH8oPr
 Zkr8cXX8b9PwOssg1+Fnr/aj9O6P60PZynBaIeuf7lZqDkggAOSzlbW4W8bKPmDG
 ubwUrcMj8FXJYK4Sb2eG8BWPv2RDaJEdgiPbWqmolO5jBUQAqVYU7bIQfobHbZt6
 JqemT+tIiSdcwMkJTXr5ZMLwPt3KcKuIIeHULt8bIKJVSzu3soUeBWyWJRBexHOY
 /e4tDkWfqdntV9ZW+zVND111PzdynAVBltlRGKlGykFf1hf/MFZIv1hxuR88ClM/
 rfFXPK/e8zFVoTOoDJq78UvD/QqoDo0w8K9NzAQ5gTrfvWxA9Y0OF2lBb3MFgXWQ
 6vQnGg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwbx31pks-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 18:09:42 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93f2c0e6653so2547785a.1
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 10:09:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794506981; x=1795111781; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=S/l24zL47yoc2vzyA8klzaXqJng2GJFFJTyIwtBzDck=;
 b=DQOkzYvYa1NCe9L6Vt4devFI2DONUVLgSiiBFMWTa1HcYI1g9KrIpbzlhygfmRpxr5
 +GY2utBPvkg5N93MWIyG4+6nyW/C28IipJUugCOSMskNKo0fDXFjOZymkGAPHlh83klV
 IDQC29RRhKIYLTne7OPPqkotiXtK5OypypMtQ6jduZoweFt7P3p7gbH51dWeerGkXTYW
 5KG8+bBFxy0qYLvZivqmWMVQEvjIl7a/uHVF7xv1D2JitWKfmC2U9sCZB4hSQHiVejaG
 hrYUxkrilPU7YjVvtSjAX6ouIzpYl9xhxsY8GcyznRLdaFGApUeaksZiG6wv4wCYRJBo
 1VbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794506981; x=1795111781;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=S/l24zL47yoc2vzyA8klzaXqJng2GJFFJTyIwtBzDck=;
 b=OP1fzkACX3+xsOVQdkyqJwuPry57fpUhezrsNmCUuiDFdEsCei48fcaPFIUZDvgc3M
 QorcfUEKbnugQtU0+qNtoVK6qnrd64tj4yWeCS+Y7WdXesLbGAJSjcG/Djru+Wq30Row
 7oDnRQPwVLYjW0/Zevq4Rg+7nBlaunKKHD+keGai4npXbrRYQSWzKwRzbslKynm1o1Fk
 ks8mvpJ4YYXkpaSUMzcALLKFxo4d2t+yo99Vo4Ia774lSZj+pnI3mHBozXOfEODnNXbr
 IdYCqgrtBoWGCFRsES8Z5LXjQJwEpNka0Oy0cl8KIn3T5dEHUV5Ep6HyA+wBdAQRlskx
 gb2g==
X-Gm-Message-State: APuU4Z8reXO00hsmooyXkeYEQRnKYPbxZNO8h/oN3cJXQtcs0F2ZTfn7
 fMIQBQjqdS2E3QQPfYN+OuyyzYWZGydrwxlkOrd51bq3qvQaMVRUgi+yLG+i6+6w4mrAWZQ4V17
 pnFKoxIfVjgxPE6Vlh3Bb+L7n1DF16iUsn4dTpXYsTjVbwUFooTJEWIYfb58aTvSlsJlR
X-Gm-Gg: AYBFou3dR0YGQJLru+A6Bb/FuJT1qs0xELSoe32h0bdcHC2Pr2T6QQqcdot0aiIzd1Z
 Ad+K41HnN9ePbXE61wfLaX+2X+fckGoMhtT6dIne+hNkmPELXM5954psfK7ZjLHShG3cpqIuj/C
 +DP8XJyD3MPzSm8/cJ/O6aGXduHAsoMoGkB3tczQ2HSgDO1ytBD0BSgK1ZVVE/XctVAitHUFbOb
 WFHc2rGDjG68gCJ3TaWY+kj6aspFylSzvDi4aUN7nJxR0a/IVbmn57qFi9f3XQhibZn6NefsX0x
 sIxbmQDjXJRcBTuwbbHp8TmrWC0cRGzg2MZ1ZG2Ylf2iJNpL1FGOBNqjyU9bjoYDKLyuK+tc+x5
 lDsN+7fZR+NpvAr8xkehwK+b7AI++I2TELz+HPUGE434kAh/WRMuFP4sxjmXfZWAlXaOY8wNJ+h
 Gj9bu3HpJi0+njTQ==
X-Received: by 2002:a05:620a:454f:b0:93f:e53:a55c with SMTP id
 af79cd13be357-9494bc03f91mr28772085a.78.1794506980903; 
 Thu, 12 Nov 2026 10:09:40 -0800 (PST)
X-Received: by 2002:a05:620a:454f:b0:93f:e53:a55c with SMTP id
 af79cd13be357-9494bc03f91mr28766185a.78.1794506980348; 
 Thu, 12 Nov 2026 10:09:40 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c60f8d66esm490864f8f.57.2026.11.12.10.09.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 12 Nov 2026 10:09:39 -0800 (PST)
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
Subject: [PATCH-for-12.0 v2 05/12] linux-user/arm: Move ELF/vDSO endian checks
 to runtime
Date: Thu, 12 Nov 2026 19:08:51 +0100
Message-ID: <20261112180859.85380-6-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261112180859.85380-1-philmd@oss.qualcomm.com>
References: <20261112180859.85380-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=S+5MU4sP c=1 sm=1 tr=0 ts=6af600e6 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=qCqlQNNpGRuE3uIUgOYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA3MiBTYWx0ZWRfX2qvokvzgWUTh
 G0ty9+RTeraB/kdtoGkZVRucq2Q8PnVQtGQm7SxsJdLh8k5LWkfoFINcl/Gb5vdRcpFcpvlGnjm
 V/GksyUkJBGZKrwP6XjvtVorFv+fkimVrloruviAdxTN1/wbuOOxk7szE7kXCkCC5AtMXy9e1xo
 lfjAtgjb7Os6QE85DVwKJft8tUMOVuDUSS/NuLGspAUQmbnzrq0eMhaaMJn9gXz2H9IlksdA5Yf
 t1qQvz4UaI/1/lvkL2eusP5nm6BPFOYBCVAMTMzqkR4ZvIOVf8YYZcSKhljYpKfcLPQGb0gmenx
 m53yv1tmv2eEYPHznW0xHDL2JAut/LTODleLpcZ+KJDBnuvrfCkFTD2n4IKDHXq6mV7OSL3UAZX
 o3W7zm9/LlW8taoo7zH2E7Kx67OoS1Q1B+5pppXm0mxBbYpcpLb/jbFmmRNnR9yilrFaB2ZUpO9
 R01qkFRlJr4ry9nYQ7g==
X-Proofpoint-ORIG-GUID: Gr14G7jE2KUpOJIGFQU453zuW7db1Ue2
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA3MiBTYWx0ZWRfX1TSS194mstkP
 iFkCsgXHf/VC3wDlbx3K4QQOBNOX1TA6FWwZu+8Lyrhl5HbsWZujry0BEcuhNwBjjn4BpbgJSKB
 CC4kAXdtAIxc3SlCb34Oy666RWbf9uY=
X-Proofpoint-GUID: Gr14G7jE2KUpOJIGFQU453zuW7db1Ue2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_02,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 clxscore=1015 phishscore=0 malwarescore=0
 adultscore=0 spamscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120072
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

Use target_big_endian() for the platform name, uname machine,
/proc/cpuinfo suffix and vDSO selection.

Preserve the behavior of the existing fixed-endian targets.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 linux-user/arm/target_proc.h    | 18 +++++------------
 linux-user/arm/target_syscall.h |  6 +-----
 linux-user/arm/elfload.c        | 36 +++++++++++----------------------
 linux-user/uname.c              | 13 +++---------
 linux-user/arm/meson.build      |  4 ----
 5 files changed, 21 insertions(+), 56 deletions(-)

diff --git a/linux-user/arm/target_proc.h b/linux-user/arm/target_proc.h
index d3186ca655cf..d9e00371a4c7 100644
--- a/linux-user/arm/target_proc.h
+++ b/linux-user/arm/target_proc.h
@@ -18,12 +18,6 @@ static int open_cpuinfo(CPUArchState *cpu_env, int fd)
     const char *elf_name;
     int num_cpus, len_part, len_var;
 
-#if TARGET_BIG_ENDIAN
-# define END_SUFFIX "b"
-#else
-# define END_SUFFIX "l"
-#endif
-
     arch = 8;
     elf_name = target_big_endian() ? "v8b" : "v8l";
     midr_rev = FIELD_EX32(midr, MIDR_EL1, REVISION);
@@ -41,29 +35,27 @@ static int open_cpuinfo(CPUArchState *cpu_env, int fd)
             midr_var = (midr >> 16) & 0x7f;
             len_var = 2;
             if (arm_feature(&cpu->env, ARM_FEATURE_M)) {
-                elf_name = "armv7m" END_SUFFIX;
+                elf_name = target_big_endian() ? "armv7mb" : "armv7ml";
             } else {
-                elf_name = "armv7" END_SUFFIX;
+                elf_name = target_big_endian() ? "armv7b" : "armv7l";
             }
         } else {
             midr_part = midr >> 4;
             len_part = 7;
             if (arm_feature(&cpu->env, ARM_FEATURE_V6)) {
                 arch = 6;
-                elf_name = "armv6" END_SUFFIX;
+                elf_name = target_big_endian() ? "armv6b" : "armv6l";
             } else if (arm_feature(&cpu->env, ARM_FEATURE_V5)) {
                 arch = 5;
-                elf_name = "armv5t" END_SUFFIX;
+                elf_name = target_big_endian() ? "armv5tb" : "armv5tl";
             } else {
                 arch = 4;
-                elf_name = "armv4" END_SUFFIX;
+                elf_name = target_big_endian() ? "armv4b" : "armv4l";
             }
         }
     }
 #endif
 
-#undef END_SUFFIX
-
     num_cpus = sysconf(_SC_NPROCESSORS_ONLN);
     for (int i = 0; i < num_cpus; i++) {
         dprintf(fd,
diff --git a/linux-user/arm/target_syscall.h b/linux-user/arm/target_syscall.h
index 8c4ddba71773..d344f614954c 100644
--- a/linux-user/arm/target_syscall.h
+++ b/linux-user/arm/target_syscall.h
@@ -10,11 +10,7 @@
 #define ARM_NR_set_tls	  (ARM_NR_BASE + 5)
 #define ARM_NR_get_tls    (ARM_NR_BASE + 6)
 
-#if TARGET_BIG_ENDIAN
-#define UNAME_MACHINE "armv5teb"
-#else
-#define UNAME_MACHINE "armv5tel"
-#endif
+#define UNAME_MACHINE (target_big_endian() ? "armv5teb" : "armv5tel")
 #define UNAME_MINIMUM_RELEASE "2.6.32"
 
 #define TARGET_CLONE_BACKWARDS
diff --git a/linux-user/arm/elfload.c b/linux-user/arm/elfload.c
index ce69bf054273..baa04851caf2 100644
--- a/linux-user/arm/elfload.c
+++ b/linux-user/arm/elfload.c
@@ -179,29 +179,21 @@ const char *get_elf_platform(CPUState *cs)
 {
     CPUARMState *env = cpu_env(cs);
 
-#if TARGET_BIG_ENDIAN
-# define END  "b"
-#else
-# define END  "l"
-#endif
-
     if (arm_feature(env, ARM_FEATURE_V8)) {
-        return "v8" END;
+        return target_big_endian() ? "v8b" : "v8l";
     } else if (arm_feature(env, ARM_FEATURE_V7)) {
         if (arm_feature(env, ARM_FEATURE_M)) {
-            return "v7m" END;
+            return target_big_endian() ? "v7mb" : "v7ml";
         } else {
-            return "v7" END;
+            return target_big_endian() ? "v7b" : "v7l";
         }
     } else if (arm_feature(env, ARM_FEATURE_V6)) {
-        return "v6" END;
+        return target_big_endian() ? "v6b" : "v6l";
     } else if (arm_feature(env, ARM_FEATURE_V5)) {
-        return "v5" END;
+        return target_big_endian() ? "v5b" : "v5l";
     } else {
-        return "v4" END;
+        return target_big_endian() ? "v4b" : "v4l";
     }
-
-#undef END
 }
 
 bool init_guest_commpage(void)
@@ -257,21 +249,17 @@ void elf_core_copy_regs(target_elf_gregset_t *r, const CPUARMState *env)
     r->pt.orig_r0 = tswapal(env->regs[0]); /* FIXME */
 }
 
-#if TARGET_BIG_ENDIAN
 # include "vdso-be8.c.inc"
 # include "vdso-be32.c.inc"
-#else
 # include "vdso-le.c.inc"
-#endif
 
 const VdsoImageInfo *get_vdso_image_info(uint32_t elf_flags)
 {
-#if TARGET_BIG_ENDIAN
-    return (EF_ARM_EABI_VERSION(elf_flags) >= EF_ARM_EABI_VER4
-            && (elf_flags & EF_ARM_BE8)
-            ? &vdso_be8_image_info
-            : &vdso_be32_image_info);
-#else
+    if (target_big_endian()) {
+        return (EF_ARM_EABI_VERSION(elf_flags) >= EF_ARM_EABI_VER4
+                && (elf_flags & EF_ARM_BE8)
+                ? &vdso_be8_image_info
+                : &vdso_be32_image_info);
+    }
     return &vdso_image_info;
-#endif
 }
diff --git a/linux-user/uname.c b/linux-user/uname.c
index 32f71f24920d..0f4658bff151 100644
--- a/linux-user/uname.c
+++ b/linux-user/uname.c
@@ -38,20 +38,13 @@ const char *cpu_to_uname_machine(CPUArchState *cpu_env)
      * see arch/arm/kernel/setup.c: setup_processor()
      */
 
-    /* in theory, endianness is configurable on some ARM CPUs, but this isn't
-     * used in user mode emulation */
-#if TARGET_BIG_ENDIAN
-#define utsname_suffix "b"
-#else
-#define utsname_suffix "l"
-#endif
     if (arm_feature(cpu_env, ARM_FEATURE_V7))
-        return "armv7" utsname_suffix;
+        return target_big_endian() ? "armv7b" : "armv7l";
     if (arm_feature(cpu_env, ARM_FEATURE_V6))
-        return "armv6" utsname_suffix;
+        return target_big_endian() ? "armv6b" : "armv6l";
     /* earliest emulated CPU is ARMv5TE; qemu can emulate the 1026, but not its
      * Jazelle support */
-    return "armv5te" utsname_suffix;
+    return target_big_endian() ? "armv5teb" : "armv5tel";
 #elif defined(TARGET_I386) && !defined(TARGET_X86_64)
     /* see arch/x86/kernel/cpu/bugs.c: check_bugs(), 386, 486, 586, 686 */
     CPUState *cpu = env_cpu(cpu_env);
diff --git a/linux-user/arm/meson.build b/linux-user/arm/meson.build
index 348ffb810d7f..47faf42eef6c 100644
--- a/linux-user/arm/meson.build
+++ b/linux-user/arm/meson.build
@@ -6,10 +6,6 @@ syscall_nr_generators += {
                    output: '@BASENAME@_nr.h')
 }
 
-# TARGET_BIG_ENDIAN is defined to 'n' for little-endian; which means it
-# is always true as far as source_set.apply() is concerned.  Always build
-# both header files and include the right one via #if.
-
 vdso_be8_inc = gen_vdso.process('vdso-be8.so',
                                extra_args: ['-s', 'sigreturn_codes',
                                             '-p', 'vdso_be8'])
-- 
2.55.0


