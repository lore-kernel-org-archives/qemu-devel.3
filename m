Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A463606A31B
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2026 16:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dBzyXPsT;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jl/I1QKj
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKegI-0000yj-29; Sat, 24 Oct 2026 12:33:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xKegG-0000xv-1P
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 12:33:16 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xKegE-0002OC-7l
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 12:33:15 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69OF07mw1563523
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 16:33:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 r5HkXPLS8FwYqhVS5d6jorZZ3pKwNDdkYQnJymKqIBM=; b=dBzyXPsTCW7i/q7Y
 8e7Di5/7aaQBMbLqWoIdc2VLbrgvI90RsUgiTbP0Z5GL3CeHjl1R4mA0VKZJ/7Q8
 dReM4ZJ/4sIAy9sdhVrAfHaTovEyg+03c5/LJ/sZuZOV6H+QQMbEyptVLKeUkpKJ
 jF1UrbvIK37GXOfvUjTHuX1sbsTTTqLwg67VRQV+XjO9SqEhLCDMX7LjCEoXahYb
 dKsVEwG+rqGjfhOzBaWDziUuGN6DKItRCXVDG5fjJfSO4/Z4bvPhBoVY4vcywvFW
 pTXrrERj/C6LBvzOyhFmfbq12CKJSuZevdvKlgBY9UdicObQkAGIhCHuVTakSHEt
 8IvfPA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgm0gheyq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 16:33:13 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3adc5b185bfso1955547a91.3
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 09:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792859592; x=1793464392; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=r5HkXPLS8FwYqhVS5d6jorZZ3pKwNDdkYQnJymKqIBM=;
 b=jl/I1QKj0Q7AWDxiOitE3nYDT1BwFxyUWltB+v9wVxuXXETbePljlqoF0NIFOLkISr
 WslM+L+3hEGQ7ArKQHWIjJwCA7eNQhx48T+c5pbC223e9lGwEp0Ur7kQJhTCMbijhWTt
 RdC9AEgxlKqYB483rWXAg8CiQhxN8vO0TV4cR7TwSRQieTghQXJjXwGviLm5Aoqq+Uy0
 LIe1Jr8BY1lvMMgddajXPXwIQWi7aD9xZ5ERgpTXnB0U73pJE9GKQkxjUPC0pKr+OsO+
 rmU8KxrzyFC6tRXTJVQbpww41AJhwZsFMBdsIzd61yLFS2fll3ZM/vhdPTad3tBKVFCm
 UtTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792859592; x=1793464392;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=r5HkXPLS8FwYqhVS5d6jorZZ3pKwNDdkYQnJymKqIBM=;
 b=Hn3HUwmoDVeAqY2jnj44BBQbmKL/Ee015jdBk7kTz4nmp6JTrlFgwD+d3mwLDkhVWb
 oSzXkG0CBaxurN2ZxeeMwa5Pzi/y1voWanb8FeeL0WzheWkPvhVewuurUCzMQiYcw5O5
 CljhZ2ap8ceG9dhp2DQACqiZpNNgusvfLWPTlYKR1kcPPd1MFpvtHVl9dwYYIToMLCrE
 a29cf+fEOFXI03l5bARR2gKnAjuKta2gp8NC5fwpeBCklh9M8Gm8RKG1BwOhfZLcUbBc
 QAEUyYbgRNxplK7xKeiNK6L/c6QTwDl5dzigwwHs+Vids+fwClJyYFZzginTh+qfeGdo
 5Oew==
X-Gm-Message-State: AFq9FYI/9J/fHb9EYx2Ffc7LAQ5uSXA/IqCrc0h4XM3/9WwZ8+iS6Xg9
 ZZSPg8nSuBOpNpeqT+FjXl85+kUi8aDApqh5UEfSTzYB+k2ah08d6y5UAzdSsDGBPYbbAaxFetd
 3wsoh5v1jfLvXMu6hzbUlJuG1Ef1bAwgIAS0O6mP8gV3ZYnuttvFd2GsIi1Zh8yxaDg==
X-Gm-Gg: AYBFou2rvfsnY73IVm+gs3K7yKPhaieC/Gad5ctzSUj4+I/DA66bOgyjOXyzgS+C0h5
 Em2/tOpJVtqlIsM+2q7+WR2Glj0dPe+LFSrWBRDV6BI+Zj6V1jnxL+c39dB3oC0ouxEFlfSlfzG
 DByLFJRA5Y1cAGH4sq1DJayp1c6Lb9/cORHILnZniaiAigWDOplUfShK0QXXa0/UnOjUhleXu71
 XOREDvNtYXHXDqh67Tk1YfNa2G2Tprt91jVurMdmZdkFj9zb2NnKPZxX1rM76Tw8+Sf+RPZ8lN0
 Xhm/lGwvszH9PpB/X/Kw71CDndPqiX4byJ2ym/B9DloCswUSCBLPFSjHaYLFszwEnpmN+kKSw6y
 up9aD5Fwn+WHRajf+PKieo8xUVaPXGzYYa56sOyhlhnzWjH/uNFte8oLG9upvBUM=
X-Received: by 2002:a17:90b:4d06:b0:3ac:7f4c:a68c with SMTP id
 98e67ed59e1d1-3adeb0ff8d0mr2288983a91.49.1792859592206; 
 Sat, 24 Oct 2026 09:33:12 -0700 (PDT)
X-Received: by 2002:a17:90b:4d06:b0:3ac:7f4c:a68c with SMTP id
 98e67ed59e1d1-3adeb0ff8d0mr2288971a91.49.1792859591740; 
 Sat, 24 Oct 2026 09:33:11 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3adebad93c5sm1932270a91.2.2026.10.24.09.33.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 09:33:10 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>, Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yonggang Luo <luoyonggang@gmail.com>
Subject: [PATCH v2 04/11] tcg: prefix helpers with target base architecture
Date: Sat, 24 Oct 2026 16:32:42 +0000
Message-ID: <20261024163249.77855-5-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261024163249.77855-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261024163249.77855-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: TyNp8cd_CAn4y0K1nwxc8JjjheMpsPMM
X-Authority-Analysis: v=2.4 cv=UfTE26SN c=1 sm=1 tr=0 ts=6adcddc9 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=OX9GZYkf9iRtFPWvzqIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: TyNp8cd_CAn4y0K1nwxc8JjjheMpsPMM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI0MDA2NSBTYWx0ZWRfX2WDSWAEMJA2h
 kgm/zNpA5kDDzk5+L63sYjnkyFVNK/aK6ZJg8SIx/ndyMAwc2nacuIgn1tfbwO5Qm12ssDK1AZt
 VTR6DCvFMpsPBFhr5VbgBCdU4WGy7V8FhRKZCfnVkwnHhdL4eXBYvr2/NrFxEkyATU02+jgsYr6
 nKys4oaw+vEtULiHlK0ZVBU1FNAZZjcCSVyHZcYFsjzbZw6Y/rhtmYymL6dFh8FWkD+lihjfZNW
 YuIm2o3ltBS9i0w3r/tClyLX7lifbdhlXLBmG3deUEWk4ar+I9NmKhEQWQYqzfsCjFuWDgp4egR
 MWH/GaojSEGUPe6SjJ7TZjy3FeOWGcGhcr0iuAlGlT/cOLMkZ4mewNHklgDdEcxi3q5z3l3vmcg
 9savpQMHWavYH4tUyaJ9iQZj2Nlkq7mWcfTcvTnjZ1R8NUH4TUUWB4ZpsdFS/ATPg8IsKsmdf0f
 j4Y1NWZPLcK5v4TEu1A==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI0MDA2NSBTYWx0ZWRfX2BNkqlBKLEaO
 X6uxAEavRLbmEcScGGYb6nx3dmDo5hbwzAa20vMjcr6DCCEOH2jKICA+TpL0KGZg0z99mvKKVJZ
 BqLNC1FQ6dgCjUHCyoRudqLczMlTWE0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-24_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 spamscore=0 bulkscore=0
 suspectscore=0 impostorscore=0 phishscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610240065
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


