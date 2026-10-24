Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959E2606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2026 17:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=e2TqKUga;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DSi7UPGV
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKfg6-0003zA-79; Sat, 24 Oct 2026 13:37:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xKfg3-0003yC-2p
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 13:37:08 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xKffz-0008HG-Hj
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 13:37:06 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69OF01kf2370704
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 17:37:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 9ioFvaX2btZ4EWSSISu4iERKkPP8HW5uj3xVW7d+bEM=; b=e2TqKUgaNqwT128d
 ygYSevyupl9jyUm7kQ3pR1RpW7nfbiSdl7OxuyXMmaXIKuWah0jWoRAPwOF1mOQt
 RmXcFhVZ5i1gRHY4dudmItr677xg/BEBdhE93ui29tzQ1CcovYPOfqShS3iUVl5A
 HEBQoXANRsEoGB02Ll+vEOZ0ZxFvjjz2LIi9B2hjzA2jJAxcTLXNMGwzDyHyqApZ
 mfZzdwhbkFyLmDcLzCCFpyyz0Or8nTpfya29m4f65OJXmTH+LmMBizXHHFXhA/oB
 8gaqzdskvj1juoa4n3yFnY7DaSGtsAhYUWabfhxpMTwY09bvhoGhzjyj8PdppEO6
 fkq/gA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgkp6hk4x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 17:37:02 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3ad436a9d00so1611054a91.0
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 10:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792863422; x=1793468222; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9ioFvaX2btZ4EWSSISu4iERKkPP8HW5uj3xVW7d+bEM=;
 b=DSi7UPGVmBAguCFklhUkJxbH4775b4cVmP4jtKkU20GKcWdGkKCwB0ajlp+2BLLkzk
 Iqfe48Rx7cSkB2MPw20aEaO+PUXrWBh2n+G2QZ2z7hAdDnz9jtSX6PR8sYgLEwcebL4p
 Ck4vt3kFy+Lo0LIWu4BAU7MCZ2PaVVvsppzw3tXENsoWyB90ziZCC/dr0pr/pH3WE17b
 bScbtmo2S4ZAvO92pdN7PPF02d9Z5+8hX5uHkKlHcR5ntYRRWBAQkmLlxCo/i4YIQRD8
 ipyyLdvnt7pVEdD0um2TYz3GWuqZ1ublmtrp8r9peETsr94CYFYo7gzDhDD6hR77L6cQ
 eQVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792863422; x=1793468222;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9ioFvaX2btZ4EWSSISu4iERKkPP8HW5uj3xVW7d+bEM=;
 b=ZMierbbFJXWXbWR5C6bguYjQqzCfZ1HEvAob5MeGodw06PJKoTRkMYzqhmDzq//3HS
 YRMt+j5iHOlrSE2vUap3l2pCTKw3aRhLFI+CnTK6hLXrc4oaNJ+jaq8IyIIpAz1n2gim
 zxbqg1tndCVNaFiBPzeKQCMlxrBvrwQkT+bsg3c1Cnbsvs/Qp9hxEsTLHEdx70knxoTW
 resJbM/cJJc6QpqF5sZ7ekAy0z4xl8qnFcLtp4T1WFVGjjb7qjEhSRKyv8Jv9lUzTFYC
 l8Xu+5cnqEAjFZXYZnmGqJyD8hW1MFNTM8UiQIo1auOgf818RnqKPkNYUmWd8KVrCA4i
 UEtw==
X-Gm-Message-State: AFq9FYJc56bOpL+WelJDe0LkgVXGyY3bm5Y47TwGupXo+EX6P+u3J0zq
 LEHAI2BfX5gcumqBNkP6ujdndWNRsS6CPa3gZNhRKxVl7CwyR73eoObdeuDSdDZrxmn4v7r6GCG
 ir3iy7UyczL1g+sFHzms86SZjWkqXxMllmxvjtmDq4In41wQG4+z/74M0g4gALLXjxg==
X-Gm-Gg: AYBFou0ZnIU4dHeMlS/qn1nx2QDKr6PGIJhypR03+tRKGU5HOzd0clO7BmfYolaIZV0
 eej8H0meZNCC+KBbJNeLtnUVkxbDf9JSUCfwcrhoxtzLKIvaWsUhPScRjEll18z4T2n4nxQ4rBA
 Ob29BR6tgWx734fccqlR0WM77EzFjRNJ+VQh67eQkYA78hYL7kbTqdMhCSXujFm7KcO0w8nsizE
 8xAofHbwRoT8xSfcE7LluEQq4e4VbIaSmD8Cd/SaljEW8m9g2iUT9CBHSFvLGgJnT9LYkMEjdaH
 V8gZJ4Gwrhzix26VyEn1QlqJpIlAKaDhIhXjuY+Us3Ed57buWLnwmYTQeDe6NmMevuuJE3T6ABU
 dr6MyBO4mmt/alQ1zfe2/JGKvF9p2uQKw4xtIyE6s4NIF/tGx8inFDJW7Eev07zc=
X-Received: by 2002:a17:90b:3b45:b0:3a8:7096:9b48 with SMTP id
 98e67ed59e1d1-3ade9b2cff5mr2463594a91.1.1792863421513; 
 Sat, 24 Oct 2026 10:37:01 -0700 (PDT)
X-Received: by 2002:a17:90b:3b45:b0:3a8:7096:9b48 with SMTP id
 98e67ed59e1d1-3ade9b2cff5mr2463579a91.1.1792863420970; 
 Sat, 24 Oct 2026 10:37:00 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3adebbb1a13sm3324093a91.2.2026.10.24.10.37.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 10:37:00 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 04/20] tcg: prefix helpers with target base architecture
Date: Sat, 24 Oct 2026 17:36:33 +0000
Message-ID: <20261024173649.7405-5-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261024173649.7405-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261024173649.7405-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 5mBByJcYlXMGmwyBHprXFDYwtGZ0R_GC
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI0MDA3MCBTYWx0ZWRfX/QlhkvRa5/Fc
 qTRvxAyYEzC8NSpM+cOhc6k0Q7MwqpuPSDAFC5nFx4nZ8dyDDpoUi9yWqfK2hzG3gPeVhCykJvA
 QJwvoGcr071knlo1zykPcd6Qi/uWWFk=
X-Proofpoint-GUID: 5mBByJcYlXMGmwyBHprXFDYwtGZ0R_GC
X-Authority-Analysis: v=2.4 cv=bq/Zl0ai c=1 sm=1 tr=0 ts=6adcecbe cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=OX9GZYkf9iRtFPWvzqIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI0MDA3MCBTYWx0ZWRfXwRQ6gyKzjqJ2
 BIEYGPuvz6fU4039X7TOLUJk1cVVsk4sOxfOZw0v8B0RuF+jbA7qGnmKRow4/SM4Sg1ZNSQBTrB
 02QwE5qtV8GBLs5wNRRVCjSsGxGXWU5NDxrPIfa9uwEv6rCfqo0faETCZv9PU8veBxujtxaIA3s
 r0EHixyrebWrSQbXKtAOzdMhmNWDlDIRz46yI838IUryevxjTxhoJv5Xja9XWCn8vWTMa4cqds3
 nKeXzpzALBqSvGwZJ7wUh7RFg9qbAsfKfZiJImiSJ9FYG5k3AIPjIflZ9FUm38W/20dK+c/ZsgP
 X08Inl2sbhefG4QOKdN2PaG7CEZ3npcOPfDMalun9Wwz+DyYFj1msBYU6wyixSrRgHVoCO/KzjN
 Ed+a64ZSJtNcH67aBrTQOIGpwcf634vv+nZ9Tpenv1wQEVPyFCwoDnLZ7EK/qOCGJzj2Fb4ilLl
 YHUSrSht4qnH0cJoWLg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-24_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 bulkscore=0 impostorscore=0 spamscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610240070
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Now we made sure all helpers and helper_info are defined and used using
HELPER/HELPER_INFO macros, we are ready to introduce a target prefix.

We can't reuse TARGET_ARCH since it's not defined for common code, and
it's also poisoned. So introduce a new TARGET_ARCH_PREFIX which is
defined for all target code (whether it's common or target specific),
and use it as prefix.

On some hosts (found it on sparc), predefined macros exist for the base
architecture names we use, and their value is 1. (#define sparc 1). So,
we can't use them directly or it would create a illformed identifier for
function names. So to prevent any problem, use additional "target",
which gives -DTARGET_ARCH_PREFIX=target_<TARGET_ARCH>.

Finally there is one last catch: beyond target helpers, tcg also has
common helpers. For those ones, we want an empty prefix, since they are
defined on tcg side and not target side.

With this, we now have target prefixed helpers, preventing symbol
conflicts when linking targets together.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Acked-by: Yonggang Luo <luoyonggang@gmail.com>
Link: https://lore.kernel.org/qemu-devel/20261024163249.77855-5-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/exec/helper-gen-common.h   | 7 +++++++
 include/exec/helper-head.h.inc     | 9 +++++++--
 include/exec/helper-proto-common.h | 7 +++++++
 meson.build                        | 2 ++
 4 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/include/exec/helper-gen-common.h b/include/exec/helper-gen-common.h
index 834590dc4e5..12e220c8ce9 100644
--- a/include/exec/helper-gen-common.h
+++ b/include/exec/helper-gen-common.h
@@ -7,8 +7,15 @@
 #ifndef HELPER_GEN_COMMON_H
 #define HELPER_GEN_COMMON_H
 
+#include "exec/helper-head.h.inc"
+
+/* Common helpers are built once, without a target prefix. */
+#pragma push_macro("HELPER_PREFIX")
+#undef HELPER_PREFIX
+#define HELPER_PREFIX
 #define HELPER_H "accel/tcg/tcg-runtime.h"
 #include "exec/helper-gen.h.inc"
 #undef  HELPER_H
+#pragma pop_macro("HELPER_PREFIX")
 
 #endif /* HELPER_GEN_COMMON_H */
diff --git a/include/exec/helper-head.h.inc b/include/exec/helper-head.h.inc
index be1d79cf017..fd03b1f1704 100644
--- a/include/exec/helper-head.h.inc
+++ b/include/exec/helper-head.h.inc
@@ -8,8 +8,13 @@
 
 #include "fpu/softfloat-types.h"
 
-#define HELPER(name) glue(helper_, name)
-#define HELPER_INFO(name) glue(helper_info_, name)
+#ifdef TARGET_ARCH_PREFIX
+ #define HELPER_PREFIX glue(TARGET_ARCH_PREFIX, _)
+#else
+ #define HELPER_PREFIX
+#endif
+#define HELPER(name) glue(HELPER_PREFIX, glue(helper_, name))
+#define HELPER_INFO(name) glue(HELPER_PREFIX, glue(helper_info_, name))
 
 /* Some types that make sense in C, but not for TCG.  */
 #define dh_alias_i32 i32
diff --git a/include/exec/helper-proto-common.h b/include/exec/helper-proto-common.h
index 76e6c25becb..4433ba47a82 100644
--- a/include/exec/helper-proto-common.h
+++ b/include/exec/helper-proto-common.h
@@ -9,9 +9,16 @@
 
 #include "qemu/atomic128.h"  /* for HAVE_CMPXCHG128 */
 
+#include "exec/helper-head.h.inc"
+
+/* Common helpers are built once, without a target prefix. */
+#pragma push_macro("HELPER_PREFIX")
+#undef HELPER_PREFIX
+#define HELPER_PREFIX
 #define HELPER_H "accel/tcg/tcg-runtime.h"
 #include "exec/helper-proto.h.inc"
 #undef  HELPER_H
+#pragma pop_macro("HELPER_PREFIX")
 
 #include "accel/tcg/getpc.h"
 
diff --git a/meson.build b/meson.build
index 4f29bc6cc33..ad537e0c18f 100644
--- a/meson.build
+++ b/meson.build
@@ -4167,6 +4167,7 @@ foreach target_base_arch, config_base_arch : config_base_arch_mak
   # prevent common code to access cpu compile time definition,
   # but still allow access to cpu.h
   target_c_args = ['-DCPU_DEFS_H']
+  target_c_args += ['-DTARGET_ARCH_PREFIX=target_' + target_base_arch.to_lower()]
   target_system_c_args = target_c_args + ['-DCOMPILING_SYSTEM_VS_USER', '-DCONFIG_SOFTMMU']
 
   if target_base_arch in target_common_arch
@@ -4290,6 +4291,7 @@ foreach target : target_dirs
   arch_deps = []
   c_args = ['-DCOMPILING_PER_TARGET',
             '-DCONFIG_TARGET="@0@-config-target.h"'.format(target),
+            '-DTARGET_ARCH_PREFIX=target_' + target_base_arch.to_lower(),
   ]
   link_args = emulator_link_args
 
-- 
2.43.0


