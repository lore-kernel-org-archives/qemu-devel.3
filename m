Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0AE606C4B2
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 14:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=d1BhGW3p;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=I1dKmjUr
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRVPy-0006jP-B8; Thu, 12 Nov 2026 09:04:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xRVPa-0006Tw-KL
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 09:04:22 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xRVPY-0007T7-Gh
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 09:04:22 -0500
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ACAUnRn1629431
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 14:04:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 T+BUoXt5tn4PGluBlPDbHpmyBXj6a91GEDmrMsa5S2Q=; b=d1BhGW3pLnzHBsb/
 I1gqXd/YJZ9t0Wh3BE9E4fgzOJ3mfOZVaWlFNM2WISOjUfr9EIm0cuhHrkQN28MY
 VdsRu02wE0FrpvgC7Lyuk7CAZBRk59IsspMeGlkqQef078DhOX03KKJm9SOGd1PV
 t7JyL+KBrTja40tnrsbwGBs+Bx7dXElpjSWtChgITJ73InzOikLLDaCteGiWE3r6
 7Er0GqkIxpiFRtfJ9McX7InDvsOZ66hfl9M8iBVHdqDj4+jiNYFDQWvUzaSxygb1
 FclaBXl1aa4gH9p+wIIkJvlq7xU0643fQHAD5TFtIaUodP6hWFej9ihAVC4anBB1
 bfDIBw==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwbs00q61-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 14:04:19 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id
 71dfb90a1353d-5eabb3a1bd8so4053226e0c.0
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 06:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794492259; x=1795097059; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=T+BUoXt5tn4PGluBlPDbHpmyBXj6a91GEDmrMsa5S2Q=;
 b=I1dKmjUrLwi47FzAlZpdWJDXkxxzJWNTWw9AUpep3jBjKMl/aS8iSRMsf1dpM5XcP1
 p1bvXNZOKgV3E0qv45Ic72t59TOFoYqt43N15BUnMomeqyyZElqr5MXcgEIoGKuiJEKQ
 nutlcCHdIR6h4AhvBx0U4F1Z/uEU66At2MrWjrJiIXk96Tz1IdB88S/65PfJPgLoWE5f
 d+PV+b1FHtR8R1JOVI0Ex1TJBK2r8PB6KU3cORfnEmUgHifDSrMoClbkr8HfuAbL7SGp
 /3cTZX0Dm5Uec00+q4ttNoA9/aAmPSl2khWC1IKc/Ty4J9wMaoT2eETxX8/4lyb0GQ2+
 56ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794492259; x=1795097059;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=T+BUoXt5tn4PGluBlPDbHpmyBXj6a91GEDmrMsa5S2Q=;
 b=C4lLqRZU2FyzMATOk6PsrrW/yoI9Vxrle0EG3Jv0QgIIjmUeGrpzrfeAI3Qdv1Mcf1
 hGQtEetPi0HNKzCNt0BiWqLwBxGp3OJBO/lfN+KTBrhIK7CJqKdJ6zvbO83+qwWzsKxn
 m5b52RJ5cfO1KbJyaFOtjL9csvYJRyGlJ3fNNHK12or+SX5SUKe2s9RGVIN9P3mkEsKB
 TIKuTfLMt9AGgSV5JKoQildBwt9NAF5+MS1yRwfTNrdI+Iahaz2+n0b0ET2/ozAeLI2n
 qEGEqqrX0MhYbi/5JOtQDs99fc//zTnKACLDBdnaOpZjbVGLA5EIC6uJ26qfQVEhrjmX
 D03g==
X-Gm-Message-State: APuU4Z+sCDCH9oY3QVa/y8O15bEGiKY7SKXL4pBW0UxvPqT19a7x8dgl
 z9/Ftm7ANWn81OvxkfWPrVGeiROJwYCm53naVHKXN/zvO0XxoIxbRxrK1K8nlolKCLfUwHzUcX7
 w3SfruwBkFWQNk9h5EX8UmFC/czjZkmFMLIN4pPhrrhZdkUWuOpVxweTQ9CIgBBxMMzpd
X-Gm-Gg: AYBFou1Op6ZTduhcx3cbJ2PQmpQ9bSFEMWegKssdboUyDnoajPg4hMg2QB4akLMPoA5
 UI4yZ4xonzn0iYI9IiAg58JNeXR0V4u3nAW3difYI/rZCmnkcioQbLjvM/1fgc93PeHAvxrUFYX
 NTo2L9A3FjQI+Mo1nC50BE6ZgdPQW3Zq+KVKeNtJi/DvTtn1aRkHpWP0YdfClVjsstmRVJb7SoH
 LDyitwq5IdXkYJx/XRVVV1lexUWabJeWbdADgfBSl1Sdu4R+dqLzdzX3L4wq8s0LZc3DfydEADX
 5m2B1o8y9xnIwonYEM9knKzNgZZNSFDfDY6HUCaAkKLlRLiMhCafsdP1bWSmyDzpqdbmTFg6FOl
 UTJmm7V3cZbYGvxrBlNDqoeMYEOY/LRP1w0640zY20JW52Tv6URCx8XhX6CXC1bh1W3JHR5kNv8
 4CRF7thzm9GsyS2g==
X-Received: by 2002:a05:6122:512:b0:5ea:e052:2ef0 with SMTP id
 71dfb90a1353d-5ee1c3ff521mr2403386e0c.9.1794492258752; 
 Thu, 12 Nov 2026 06:04:18 -0800 (PST)
X-Received: by 2002:a05:6122:512:b0:5ea:e052:2ef0 with SMTP id
 71dfb90a1353d-5ee1c3ff521mr2403318e0c.9.1794492258066; 
 Thu, 12 Nov 2026 06:04:18 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb4e271378sm81450395e9.13.2026.11.12.06.04.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 12 Nov 2026 06:04:17 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>, devel@lists.libvirt.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH-for-12.0 4/8] target-info: Support runtime-endian Linux-user
 targets
Date: Thu, 12 Nov 2026 15:03:39 +0100
Message-ID: <20261112140343.61634-5-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261112140343.61634-1-philmd@oss.qualcomm.com>
References: <20261112140343.61634-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA1NSBTYWx0ZWRfXzP/LJmnQkypo
 uiJff3uv20q+6ArfPRXxb32JOBh4h/nbCKkjDVKFTyUUCwumeTdFm8TKMDqE+d8lOMkHIqanCGs
 3e9inKEwfDWsHQM0T9SkXzgR5lKkikXE6qrms4z3QdZIc6aujmFK6f1av3hTX3Wl7TWdTOGtecu
 p6dmFNwe8sN9SQJgkVum2C1OofaW9HlKl7LguaQuobzeoLKSZPLfGkWWvgbQeLf2Az4kKQ3tbM8
 7/Ft5NfpJ7m6u524pi8/wvq3JcJcP+dP7tIGXlIJQdS6CMA+R70lk6XaCF3mYaMi77IiRmItNVh
 mpuazRGtHyHFYDT7mzL6G3IWO37wrxf5BmxdczovW8+1ERTdC9CnLOUih1ng2/dj+r2q2TxSgqD
 39YstHwvluvcvmFxFMYmAZ2FtpYATlf5u4JIXMfCHGkwuaE9rFSgxS5y7/sVa6G6wtOIfZfZCpz
 tXm8ZesQLyqHzn6y6JQ==
X-Authority-Analysis: v=2.4 cv=AsF7T+9P c=1 sm=1 tr=0 ts=6af5c763 cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=oRXqm_aVrHWTxU2XlOwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=tNoRWFLymzeba-QzToBc:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA1NSBTYWx0ZWRfXxudc5btpce0F
 BOvGWCsdiVumAHFjIfTjXvfEaSFengpmoi1btq8Ivgj9VHkfiBzVZh6INSRtDxcOS9T3cPxKLIz
 lPeuVEu7hOPFTKkJF4WcHmJl2JT1GQg=
X-Proofpoint-GUID: otSYAsU8Br7rrlfy2wdx8yHVmAgRkRId
X-Proofpoint-ORIG-GUID: otSYAsU8Br7rrlfy2wdx8yHVmAgRkRId
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 phishscore=0 impostorscore=0 bulkscore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120055
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

Add a write-once ABI byte-order setter for runtime-endian Linux-user
targets.

Expose const data to readers and inline runtime endian checks, keeping
its writable initializer outside LTO.

Retain immutable data and compile-time byte swapping for fixed-endian
targets. Restrict TARGET_RUNTIME_ENDIAN to Linux-user configurations.

Inspired-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 meson.build                    | 26 ++++++++++++++++++++++++--
 include/exec/tswap.h           | 11 +++++++----
 include/qemu/target-info-def.h | 14 ++++++++++++++
 include/qemu/target-info.h     | 20 ++++++++++++++++++++
 target-info-def.c              | 19 +++++++++++++++++++
 5 files changed, 84 insertions(+), 6 deletions(-)

diff --git a/meson.build b/meson.build
index d7bcb581c181..04cf5d77f188 100644
--- a/meson.build
+++ b/meson.build
@@ -3342,6 +3342,11 @@ foreach target : target_dirs
 
   config_target += keyval.load('configs/targets' / target + '.mak')
 
+  if 'TARGET_RUNTIME_ENDIAN' in config_target
+    assert(target.endswith('linux-user'),
+           'Runtime target endianness is only supported for Linux-user')
+  endif
+
   target_kconfig = []
   foreach sym: accelerators
     if sym == 'CONFIG_TCG' or target in accelerator_targets.get(sym, [])
@@ -4400,8 +4405,6 @@ foreach target : target_dirs
     endif
   endif
 
-  arch_srcs += files('target-info-def.c')
-
   if target_base_arch in target_arch
     t = target_arch[target_base_arch].apply(config_target, strict: false)
     arch_srcs += t.sources()
@@ -4470,6 +4473,25 @@ foreach target : target_dirs
     lib_deps += dep.partial_dependency(compile_args: true, includes: true)
   endforeach
 
+  # Keep the writable runtime-endian definition opaque to const readers,
+  # as for page-vary-common.c above.
+  target_info = files('target-info-def.c')
+  if get_option('b_lto') and 'TARGET_RUNTIME_ENDIAN' in config_target
+    target_info_flags = ['-fno-lto']
+    if get_option('cfi')
+      target_info_flags += '-fno-sanitize=cfi-icall'
+    endif
+    target_info = static_library('target-info-' + target,
+                                sources: target_info + genh + config_target_h[target],
+                                dependencies: lib_deps,
+                                include_directories: target_inc,
+                                c_args: c_args + target_info_flags,
+                                build_by_default: false)
+    objects += target_info.extract_all_objects(recursive: false)
+  else
+    arch_srcs += target_info
+  endif
+
   lib = static_library('qemu-' + target,
                  sources: arch_srcs + genh,
                  dependencies: lib_deps,
diff --git a/include/exec/tswap.h b/include/exec/tswap.h
index 17ac5444544d..869619bac314 100644
--- a/include/exec/tswap.h
+++ b/include/exec/tswap.h
@@ -13,14 +13,17 @@
 #include "hw/core/cpu.h"
 
 /*
- * If we're in target-specific code, we can hard-code the swapping
- * condition, otherwise we have to do (slower) run-time checks.
+ * For fixed-endian target-specific code, hard-code the swapping condition.
+ * Otherwise use run-time checks.
  */
 #ifdef COMPILING_PER_TARGET
+#ifndef TARGET_RUNTIME_ENDIAN
 #define target_needs_bswap()  (HOST_BIG_ENDIAN != TARGET_BIG_ENDIAN)
-#else
+#endif
+#endif
+#ifndef target_needs_bswap
 #define target_needs_bswap()  (HOST_BIG_ENDIAN != target_big_endian())
-#endif /* COMPILING_PER_TARGET */
+#endif
 
 #if defined(CONFIG_USER_ONLY) \
     || !defined(TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API)
diff --git a/include/qemu/target-info-def.h b/include/qemu/target-info-def.h
index 8019d2c7196e..34058955edec 100644
--- a/include/qemu/target-info-def.h
+++ b/include/qemu/target-info-def.h
@@ -32,6 +32,20 @@ typedef struct TargetInfo {
     bool page_bits_vary;
 } TargetInfo;
 
+#ifdef COMPILING_PER_TARGET
+#ifdef TARGET_RUNTIME_ENDIAN
+/*
+ * Linux-user selects the ELF byte order before creating CPUs or guest threads.
+ * The data is then immutable; its writable definition must stay outside LTO.
+ */
+#ifdef IN_TARGET_INFO_DEF
+extern TargetInfo target_info_stub;
+#else
+extern const TargetInfo target_info_stub;
+#endif
+#endif
+#endif
+
 /**
  * target_info:
  *
diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
index 2cd4cc5671b5..6ed4cfda8d7b 100644
--- a/include/qemu/target-info.h
+++ b/include/qemu/target-info.h
@@ -9,6 +9,12 @@
 #ifndef QEMU_TARGET_INFO_H
 #define QEMU_TARGET_INFO_H
 
+#ifdef COMPILING_PER_TARGET
+#ifdef TARGET_RUNTIME_ENDIAN
+#include "qemu/target-info-def.h"
+#endif
+#endif
+
 /**
  * target_name:
  *
@@ -40,7 +46,21 @@ const char *target_cpu_type(void);
  * the target, so please do *not* use this function unless you  know very
  * well what you are doing!
  */
+#ifdef COMPILING_PER_TARGET
+#ifdef TARGET_RUNTIME_ENDIAN
+static inline bool target_big_endian(void)
+{
+    return target_info_stub.endianness == ENDIAN_MODE_BIG;
+}
+
+/* Select the Linux-user ABI byte order once, before CPUs or guest threads. */
+void target_set_big_endian(bool big_endian);
+#else
 bool target_big_endian(void);
+#endif
+#else
+bool target_big_endian(void);
+#endif
 
 /**
  * target_heterogeneous:
diff --git a/target-info-def.c b/target-info-def.c
index bcf9cfe1e437..7580993e0bb3 100644
--- a/target-info-def.c
+++ b/target-info-def.c
@@ -6,6 +6,8 @@
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
+#define IN_TARGET_INFO_DEF 1
+
 #include "qemu/osdep.h"
 #include "qemu/target-info.h"
 #include "qemu/target-info-def.h"
@@ -24,7 +26,12 @@ QEMU_BUILD_BUG_ON(offsetof(ArchCPU, env) != sizeof(CPUState));
 QEMU_BUILD_BUG_ON(TARGET_PAGE_BITS < TARGET_PAGE_BITS_MIN);
 #endif
 
+#ifdef TARGET_RUNTIME_ENDIAN
+/* This writable definition must not be compiled with -flto. */
+TargetInfo target_info_stub = {
+#else
 static const TargetInfo target_info_stub = {
+#endif
     .target_name = TARGET_NAME,
     .target_arch = glue(SYS_EMU_TARGET_, TARGET_ARCH_VARIANT),
     .long_bits = TARGET_LONG_BITS,
@@ -42,3 +49,15 @@ static const TargetInfo target_info_stub = {
 };
 
 target_info_init(target_info_stub)
+
+#ifdef TARGET_RUNTIME_ENDIAN
+void target_set_big_endian(bool big_endian)
+{
+    static bool endian_decided;
+
+    assert(!endian_decided);
+    endian_decided = true;
+    target_info_stub.endianness = big_endian ? ENDIAN_MODE_BIG
+                                             : ENDIAN_MODE_LITTLE;
+}
+#endif
-- 
2.55.0


