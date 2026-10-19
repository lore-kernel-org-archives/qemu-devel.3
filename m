Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A432606A319
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 21:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HKjIf4ii;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=T2Yp2cDc
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIunf-0001jr-Ew; Mon, 19 Oct 2026 17:21:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIunN-0001h0-Qs
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 17:21:25 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIunL-0005iP-Uh
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 17:21:25 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JJJtkL3672220
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 21:21:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=lEh1QUzVKCU
 McOV2PvW1tMD/ZW6RY1dlfR9D7430TCg=; b=HKjIf4iibBPyua5droseN96Mqwy
 m2+cFabuDdduN94945dOUMg32nIxcnKCNvG3YT4wl+SiresWBd45QQ3hcCqRXe0A
 9QAo0opMmzWyTMEiuJCcPpKq2gSvQ7wQYsQ8VG4V1CTCMdyWUrLyO0+/UAvmnjAG
 NMrQhV+YJj0aalNpVETO2mPZq1l6YfYdBRiImAx83NYqicwZc6s4Xnd4svThjrXd
 Nln/FYzL34b9RNjzhAfblDWowJOUgIVObyOBK3uqie5g0jNdFCZPCn413uXnJvJw
 IR35ufMNJjjecBAXqlQ/w3Lv43O4ANBOCcgkZkHm/7vl4eZlT2od5JLN5Pw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf3xbb2r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 21:21:22 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3ad436a9d00so1185079a91.0
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 14:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792444882; x=1793049682; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lEh1QUzVKCUMcOV2PvW1tMD/ZW6RY1dlfR9D7430TCg=;
 b=T2Yp2cDcuC57/U3ucLJYvDhqSnNW5aRR2hZDVsis4XrCiWBI0xIQfr9GurIw5ouxuv
 3Grl6gI77CI7SUedsQJV8REGppgTtTicIFyHc+hRsE6viQ14UJyNdKMgPGNOeBaLDXkM
 EQdAFKuht2DXxFuJE2rchO4kW22DacWswd15LLXRIP6CIEFRV+0bj15GvwvDxUD95W/+
 ctFoB8eUtkFtaILzBjLgTT749HstoS9hAA1XNpfoGQOx+Y7ipZR96lc2jGK/Rac20OH7
 mnzpd4b0Umx4qoc0VD4B7lTdivZYbBAzquzH0RsGp0B/nDTyFGtR5LN3jVIPFxsH6Ei4
 QWAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792444882; x=1793049682;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=lEh1QUzVKCUMcOV2PvW1tMD/ZW6RY1dlfR9D7430TCg=;
 b=oY2blg3qdPXd1CkBo6nrPTldfZf6fzrc5eHvjWEMZedeh2YvQm0O6UaZUbeA5EaDvv
 OFtCnMMwtoGQ66hyhHDkgxuP+5k6/0PJUgzLDbaMzzwvJuY0rC1nCvalyVMIoekR6DTH
 AFPcvNxuUqVecDLRu677Box/pJaBj2wz6OlvybbthKdTGii3mulVGoiNCBImDUqWWyzB
 Zg5ILSD3QEd7uubNY9hB4HvPRfblpNqu4cejiESHUw4D8hAci+VKOTH20B4CrGMOWRcx
 R9kJi7t5bLIJXSjQpdblvzI0hYZJID74gQZbTl3foT3mGHtlqekCnJjkojiH66/llGt9
 /6Tw==
X-Gm-Message-State: AFq9FYIqxvgoGmoNNw/FukYPGWnaZftVwOXGpsEqdIan0LZ/OS6B1L2G
 MDVsv0m2Ka1Hly+6fYPKuAhWBdQOnnRSwzn9OftlRn4MQNd3jS3hcDY/w3lo9tmYlCxIr3pWWoQ
 G/Ys8U+oK/OUDLHG0EAz6ihx+XysfSigMiB2QkpU6U+ZQYzZ+GS9A1LgTKoQySgIyBg==
X-Gm-Gg: AYBFou2SMd1F0Ylwpe41eAjC2zskqMeBAq8xGfKm7E5Kvnt9W+/ceLww/s6/BJP9Htr
 YY/U3VKBgkNhpx/y2sIxvUU39ppwGWZyXvLiRYWEXueOm53At8rgzbx/kG2d8qMz9IuE03PxhRH
 tkaNDfkXEN2xQz/4rAuX1+ieitfl4ZMnV0s/0RmTn7ePuCqRQRlNnRRYfGsH+IwVfisFrgfJKir
 E+aIjqe7UubDCv6+VtyUHmJxMnJbmH2OyJg6OcxEHqTE6S24i9LMNPU7T9nlX22cRXaUrXrK9jW
 Kr40xQVND0+wXav/WJz7G+2ZtyEWoB+Jewx6r49dPsHtLu9YPlLsBGiayGZI3ljCjDmhwZPalNg
 iqVdRlDxDtllhaP1pcG6hpCBx+9hQLYoJ0v5IfFNw4wtZxkW3pAQeJ/MRrIGaQ88=
X-Received: by 2002:a17:90b:3b91:b0:3a8:32f2:f4a5 with SMTP id
 98e67ed59e1d1-3acef57b3afmr7911620a91.53.1792444881821; 
 Mon, 19 Oct 2026 14:21:21 -0700 (PDT)
X-Received: by 2002:a17:90b:3b91:b0:3a8:32f2:f4a5 with SMTP id
 98e67ed59e1d1-3acef57b3afmr7911600a91.53.1792444881294; 
 Mon, 19 Oct 2026 14:21:21 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ad60ec4457sm863243a91.6.2026.10.19.14.21.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 14:21:20 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 19/26] tcg: prefix helpers with target base architecture
Date: Mon, 19 Oct 2026 21:20:38 +0000
Message-ID: <20261019212046.149572-20-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019212046.149572-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261019212046.149572-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: o9RWSNOvD87w9TBfa1UoIrywFW-cQoXv
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA4NSBTYWx0ZWRfX6kmlbcqpFl7B
 KUPBpoDusWWLbr4GYfGTaNmzuQwP0PsqLyDNpnjWlz98R6oSZwG+xZKI/9uoOrvoC7mKSQjXX78
 s6i+JIuYOdaQDmVAf/+/aa7hP2Vk+40=
X-Authority-Analysis: v=2.4 cv=XPOl2ghE c=1 sm=1 tr=0 ts=6ad689d2 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=OX9GZYkf9iRtFPWvzqIA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: o9RWSNOvD87w9TBfa1UoIrywFW-cQoXv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA4NSBTYWx0ZWRfXwJTtovrT/HyT
 GMsJWer6cuzwRu87zrPf9A7QV5yizhqjS3b1ja62EzIUHFo4HIHhPnM5OZ11hTFkTmsTspegF0u
 5z1XqxYd1zISyJqnTeYLLidTxKJDQPyzKzIrASxpUDNUzLsQTAl/jasTC1N42r/oYlZ52AmZMxr
 3k7WgkxBGRQQiGrugbXTjBGfkGbZeDSyvsvVG/yy1ZvVEIELO4O37k2cARO0phRmXaRi3njJVQ7
 pCbWxXylcbSPFBsTsgZ6kKs0D3k29F21w7OsFWojhhZgOE1wlkmowC4JzNJ673/fA4Hi5qIW5mh
 r0wdtDeTGjEFCt5o5XVdMGBKZrzAKdOot5dpSyFUreZiT3hYwXyaEbBkvHNZiCVUxz2a6oeLhTn
 6cdFrr+ghtb2vlvbsWaEnfpvWCm34eUGWLxdnpuUTxYzrgzsf/4BGQvkRFdRAqKr5qtfd2VTA3E
 CSeNPS2A/XVJuiJcP/A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_05,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 phishscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610190085
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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
index bbef9d9c293..5c8ffa50ad6 100644
--- a/meson.build
+++ b/meson.build
@@ -4161,6 +4161,7 @@ foreach target_base_arch, config_base_arch : config_base_arch_mak
   # prevent common code to access cpu compile time definition,
   # but still allow access to cpu.h
   target_c_args = ['-DCPU_DEFS_H']
+  target_c_args += ['-DTARGET_ARCH_PREFIX=target_' + target_base_arch.to_lower()]
   target_system_c_args = target_c_args + ['-DCOMPILING_SYSTEM_VS_USER', '-DCONFIG_SOFTMMU']
 
   if target_base_arch in target_common_arch
@@ -4284,6 +4285,7 @@ foreach target : target_dirs
   arch_deps = []
   c_args = ['-DCOMPILING_PER_TARGET',
             '-DCONFIG_TARGET="@0@-config-target.h"'.format(target),
+            '-DTARGET_ARCH_PREFIX=target_' + target_base_arch.to_lower(),
   ]
   link_args = emulator_link_args
 
-- 
2.43.0


