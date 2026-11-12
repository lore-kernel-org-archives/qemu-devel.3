Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6730F606A331
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 14:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ezJd4Hq7;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=b8oktyha
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRVPY-0006N2-Uk; Thu, 12 Nov 2026 09:04:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xRVPN-0006MN-7e
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 09:04:10 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xRVPL-0007Qx-EL
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 09:04:08 -0500
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ACBDtNk3893693
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 14:04:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 F+yrVZEjze+e/2Of60uDFwn+N5jFGPC6Av8hbHxv1mg=; b=ezJd4Hq7RZJ0kB1Q
 eulr404Yzo1n6m31Ism+k8tBsy9zrPJ7jQ1VOx2DAUkoJj4EBkYdoPl6yEwEPjJA
 u1cG01axESRgok8g1kWcQgDcdYajFb653EfPmv9TkEIrN7EyiguxbJhAZuo6y42H
 nmo0ArGnoYEIXnygM3eURqBRBvKvAlQ4msZfKLddh+qv0YwEPh8B2jjwgs6RKS4j
 ZJu1z0AG091q52MM1UQEfkxyCU2eW52YdSFUlDxUfQVCeOzcV2fGZ3bMuZameeiH
 KP1MwInOb4pF+b8p7pFnyaLnOwvVg+vnyBL3Urypdiye6k9895iY4Sk4OuCz/b0y
 2E9Pog==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hw6re1w36-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 14:04:05 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id
 71dfb90a1353d-5eacc615f73so4583944e0c.1
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 06:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794492244; x=1795097044; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=F+yrVZEjze+e/2Of60uDFwn+N5jFGPC6Av8hbHxv1mg=;
 b=b8oktyhavJdj+gG1o3Jl++joCdyhFtLE79MsqZ9us38p7mBlKC0pMd4cELC+KEplk2
 p2ztg/lDmLtmzPnsdbe/GMo7c9oZ3bpaOo+8zFoTq8V3YyVN0tMDZRLEUpITYY7aGSMK
 kGScGQ8VoTyUfDRcHp00kYVRk5cJPUsPQEjq4zJD5JbMzFdc/rTUunyA6fKqQQ4E9DlB
 i8nZYFSc511Ypq6eBsaGwXpvvuE78YwIDwxD3sNbqT0Tk+3oKSZ3q9PxcKGe1VUjreds
 42dw+1Qva5rRfaIMzvWrflE0yLcCq0OW4MJwOZgtFCXh1om3y+GMoTNxNiJ6UFJojQvJ
 fDlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794492244; x=1795097044;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=F+yrVZEjze+e/2Of60uDFwn+N5jFGPC6Av8hbHxv1mg=;
 b=X+vBD2RgbrQQcmVgcmBbzS4XFGrxXyH1gl1MEAawccgfm3UCZI1iQHCZ8kdo/XWu0x
 exlqCIwCRJqziP4JXrynEHCewrOQCgKXA7jBKvj6X5g7OyUcs9stK0ATC2710+yq5l2J
 E+8oalwPb5V1M8HFH0I3nc0Na5jJEHHq6nU2i4ZKW7Wo00GlkkFH2hv/Sr3FVKJyNhZL
 067ZFuDk2X4AZngBC01RSxAm3QFmuciE/uPOW8CtNUgsGH+ElagJCX6DOa/haMbq1PAT
 zADpgeEcKcMgtVircBH8R0ju7kGakju3RwL1urFir+S4gVX1o1Pi5uVwh7y09vclNYHL
 Kqaw==
X-Gm-Message-State: APuU4Z8HyPzRaSLrsHqgQivE+uMS9xNthK4auH1XAtJC8SWaNHjvTfAz
 pifhCxPVuP8A1zijMUAm0vgD2iEtwVxWF/DRowBySaBzHG6CNuPkJJhdSL6eSBpijX5oo5L5RWI
 amAcRAq30T5Gwphw4cHQPcdx1M/GwN5F+EjB3ZZjFyabJwSa9tvlKnCFtbvZwkD6o2RUp
X-Gm-Gg: AYBFou21g2TDxxrlX3/QFlHokUdMFysc8qOidObpJvBa+JDuAoa8eKxHcZYJ3LxoaRh
 AqlmaigRn6AyGYCoF7mu+jFjaN4y5LFGczxIeV1m+rK+Yp3SevAmw34fByFxs928iZa6UTcuo3A
 qLuAifX7ZkL5Km+WyYU+YulBeMSuox8PalS99/jKHJpQgxIMYyz+/Qf+N19780O7uWDyGyAxAkr
 MchEL00/hrWJXnGjHjsxdaEQRgWeBUM/daEknn1UqtHuis1WGTYFbj+D+U1s0TJ1Ffz30pvU0J1
 VMzotv/UOF27upUAiMCXAK4SReOJ132Yyluz3WFK88hirz5Zkl/bclMTm9OZ36mc2atvn5OgU4B
 smfaa26DvAQHC0GI72DOZn9N/pB5SAD20vI8EHDeLSOQe4qCtbWH5iXJKdKu3dFXNiZewJrI/MA
 o2wvpnmgqGwKL09A==
X-Received: by 2002:a05:6122:4d0b:b0:5e9:721c:72a8 with SMTP id
 71dfb90a1353d-5ee1bf6259amr2502055e0c.0.1794492244204; 
 Thu, 12 Nov 2026 06:04:04 -0800 (PST)
X-Received: by 2002:a05:6122:4d0b:b0:5e9:721c:72a8 with SMTP id
 71dfb90a1353d-5ee1bf6259amr2501981e0c.0.1794492243309; 
 Thu, 12 Nov 2026 06:04:03 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb4e28c882sm75481145e9.6.2026.11.12.06.04.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 12 Nov 2026 06:04:01 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>, devel@lists.libvirt.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH-for-12.0 2/8] linux-user/aarch64: Move ELF/vDSO endian checks
 to runtime
Date: Thu, 12 Nov 2026 15:03:37 +0100
Message-ID: <20261112140343.61634-3-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261112140343.61634-1-philmd@oss.qualcomm.com>
References: <20261112140343.61634-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: fGbhPjNjqGLLrULgEgHo_1ekZO7YQNw6
X-Proofpoint-GUID: fGbhPjNjqGLLrULgEgHo_1ekZO7YQNw6
X-Authority-Analysis: v=2.4 cv=NJhAaE6g c=1 sm=1 tr=0 ts=6af5c755 cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=gRHuWOP3dPFJNPu9TmoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA1NSBTYWx0ZWRfX1x3rT+qUyH8m
 YDSfu4dUzjwRNxljVv5tSnmQxDdv6fqgr2pUkG7BIiq5o0BjSZBuJc3tgl2fRCzv83vWTcp6zkn
 130QhO9IaekO7nA8C7UZM8Pmq4Y/jts=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA1NSBTYWx0ZWRfX5Swomsvc8u0y
 BC4TfZMxUUScs9h2HcAm0vtXw2mWQdgk04GABM04KDr6Ye6xncuTBcYliT+A6dzggfKxu7Rn320
 /1QHI7b2BFGcBHR0UrE6J5nwWqm+SkwqiYfck7+pWyeg69cPxmmCuZSUliK1fJzu4PebpSrhUeY
 SO19CZz5tuGJK3BBrRcX4kvG+Zm4v2DCuNOUHSlZ9j9UikHSBHnPzXPqU3txSAFDJqh9coif7Sn
 TlB6j9dReMbEubh8t6luQxOGQxDb8MOq3E5socANoWSHZHJfuMc2WQssFfFenaO6M6DMmfQJo0f
 u+C8yHgGOSACE54S4B3nlPCoMUl5K5VabU8g5Neu4DMndsJ1AEyjurjvc8yX2ZaQQyx1mC8As/C
 UaiFWU6SBW/zJR2ozw6Fu3s+K/XQrSI/BwweY7zSPRcqQHStGemhlCyq97ODGjNvh5Uxb7FJn9k
 l8vjDSx0S0jvsKFIMjA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 clxscore=1015
 malwarescore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120055
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Use target_big_endian() for the platform name, uname machine,
/proc/cpuinfo suffix and vDSO selection. Give the generated
vDSOs distinct symbols so both can be included.

Preserve the behavior of the existing fixed-endian targets.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 linux-user/aarch64/target_elf.h     |  6 +-----
 linux-user/aarch64/target_syscall.h |  6 +-----
 linux-user/arm/target_proc.h        |  2 +-
 linux-user/aarch64/elfload.c        | 10 +++++++++-
 linux-user/aarch64/meson.build      | 10 ++++------
 5 files changed, 16 insertions(+), 18 deletions(-)

diff --git a/linux-user/aarch64/target_elf.h b/linux-user/aarch64/target_elf.h
index 4cdeb64b0d4e..ebd23cfbceda 100644
--- a/linux-user/aarch64/target_elf.h
+++ b/linux-user/aarch64/target_elf.h
@@ -27,10 +27,6 @@ typedef struct target_elf_gregset_t {
     struct target_user_pt_regs pt;
 } target_elf_gregset_t;
 
-#if TARGET_BIG_ENDIAN
-# define VDSO_HEADER            "vdso-be.c.inc"
-#else
-# define VDSO_HEADER            "vdso-le.c.inc"
-#endif
+#define HAVE_VDSO_IMAGE_INFO    1
 
 #endif
diff --git a/linux-user/aarch64/target_syscall.h b/linux-user/aarch64/target_syscall.h
index bd05f6c7fe5d..f3c570a5b2eb 100644
--- a/linux-user/aarch64/target_syscall.h
+++ b/linux-user/aarch64/target_syscall.h
@@ -1,11 +1,7 @@
 #ifndef AARCH64_TARGET_SYSCALL_H
 #define AARCH64_TARGET_SYSCALL_H
 
-#if TARGET_BIG_ENDIAN
-#define UNAME_MACHINE "aarch64_be"
-#else
-#define UNAME_MACHINE "aarch64"
-#endif
+#define UNAME_MACHINE (target_big_endian() ? "aarch64_be" : "aarch64")
 #define UNAME_MINIMUM_RELEASE "3.8.0"
 #define TARGET_CLONE_BACKWARDS
 #define TARGET_MCL_CURRENT 1
diff --git a/linux-user/arm/target_proc.h b/linux-user/arm/target_proc.h
index 13c33d44d5ed..d3186ca655cf 100644
--- a/linux-user/arm/target_proc.h
+++ b/linux-user/arm/target_proc.h
@@ -25,7 +25,7 @@ static int open_cpuinfo(CPUArchState *cpu_env, int fd)
 #endif
 
     arch = 8;
-    elf_name = "v8" END_SUFFIX;
+    elf_name = target_big_endian() ? "v8b" : "v8l";
     midr_rev = FIELD_EX32(midr, MIDR_EL1, REVISION);
     midr_part = FIELD_EX32(midr, MIDR_EL1, PARTNUM);
     midr_var = FIELD_EX32(midr, MIDR_EL1, VARIANT);
diff --git a/linux-user/aarch64/elfload.c b/linux-user/aarch64/elfload.c
index f87f22f6903a..8e75da826e62 100644
--- a/linux-user/aarch64/elfload.c
+++ b/linux-user/aarch64/elfload.c
@@ -379,7 +379,15 @@ const char *elf_hwcap2_str(uint32_t bit)
 
 const char *get_elf_platform(CPUState *cs)
 {
-    return TARGET_BIG_ENDIAN ? "aarch64_be" : "aarch64";
+    return target_big_endian() ? "aarch64_be" : "aarch64";
+}
+
+#include "vdso-be.c.inc"
+#include "vdso-le.c.inc"
+
+const VdsoImageInfo *get_vdso_image_info(uint32_t elf_flags)
+{
+    return target_big_endian() ? &vdso_be_image_info : &vdso_le_image_info;
 }
 
 bool arch_parse_elf_property(uint32_t pr_type, uint32_t pr_datasz,
diff --git a/linux-user/aarch64/meson.build b/linux-user/aarch64/meson.build
index f25a67a21ef6..a5f9a47a9a27 100644
--- a/linux-user/aarch64/meson.build
+++ b/linux-user/aarch64/meson.build
@@ -1,12 +1,10 @@
-# TARGET_BIG_ENDIAN is defined to 'n' for little-endian; which means it
-# is always true as far as source_set.apply() is concerned.  Always build
-# both header files and include the right one via #if.
-
 vdso_be_inc = gen_vdso.process('vdso-be.so',
-                               extra_args: ['-r', '__kernel_rt_sigreturn'])
+                               extra_args: ['-r', '__kernel_rt_sigreturn',
+                                            '-p', 'vdso_be'])
 
 vdso_le_inc = gen_vdso.process('vdso-le.so',
-                               extra_args: ['-r', '__kernel_rt_sigreturn'])
+                               extra_args: ['-r', '__kernel_rt_sigreturn',
+                                            '-p', 'vdso_le'])
 
 linux_user_ss.add(when: 'TARGET_AARCH64', if_true: [vdso_be_inc, vdso_le_inc])
 
-- 
2.55.0


