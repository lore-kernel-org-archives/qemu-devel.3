Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731A4606A324
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 18:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=S0I8FALe;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=j26prBBE
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM7yA-0006jC-4e; Wed, 28 Oct 2026 14:01:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xM7xl-0006bJ-OX
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 14:01:25 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xM7xk-0000dl-0P
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 14:01:25 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69SFAE0P2001693
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 18:01:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Aftd1+yI16315wh6S08GiKfzU7HWuBjTu2sRfSPXq9I=; b=S0I8FALephDvUQ0L
 gQOIJOos3K3tj2gFwrmJAscbLwBXsrLgT2QrVxpD6zwNgG9XrRtZF8e8xZUExu3q
 aLq3vhikpnKPmttbfThy2nJYA+jLaLaOsjIT3XDvuzdgY9kHjukY6JIrcAS7tBdS
 o3ZzkPjPZgMXOT78zLgICN6UugyveYtjwawctF+f95ZnfLDJbN16lwltNfj7fXqu
 l4zYToWKnB/jZW7f2Y6JgMnpO/7mKn8n3D4Ok+1/xjcGaZIpIXdIpsv9/cb4WeBI
 Lqk/RawHnX/+4Cp9lmYBc3KY6FLFNRi/tXB1CC7L+nCxK/cclvH3TMXeqeoK4/0R
 ClXtUw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hkdf7tcjt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 18:01:18 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-5376f1853bfso28167451cf.0
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 11:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793210476; x=1793815276; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Aftd1+yI16315wh6S08GiKfzU7HWuBjTu2sRfSPXq9I=;
 b=j26prBBE2EtJwdut8m52trR7KxtISfBLnrH8lNOO2/A6lsmId5quNGcfyElA1qa1Es
 r+9/IZ7OIgvr3SDWNUwJYmzQfljHtvTV0OnfmWlS6wIcHYAd+UX/qqX03R/uYGkiCCvz
 Yf2TxdV1Vtbc6nEXcgGl4W1Xw8q4cgQkIb0LEMYphzCgC8JdPhSfDHGph2TTDRJRH6ag
 uAqTnAfq/rsgivxTWTEh5XIgz8v6YbTQ9SRBsyellkeUgX5eHllmf0rl7RQ61oI18SE/
 fIeOQi/9Itx7TrEbBEMQb68wDb85lXoOFiwvjYr0ln6oIOyJ8jxpEJQeiLHNHyo7Tr3Z
 Hr1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793210476; x=1793815276;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Aftd1+yI16315wh6S08GiKfzU7HWuBjTu2sRfSPXq9I=;
 b=K1cLegChtkRn33oylMKu8rRjtVSYE9GIMIKXouLKvc6TTNY+eCaaMt6icu/aJz6uuq
 3lMr3upPphyg36pnzMAVeLjvqKQ3mEnkOcNehVe4onjaqwn1GWccz1CjOyCgTpcGZuku
 rp8nHF6Ubzcs7pISANle0VURlxyzFC03kGdTEbQdzl0eUs/E/3GLG8UJV/FSRZeKuJKp
 GR7gwZSQhi7kPL/p7rn/PosCo6IbaauMBFrkYyz9lNc3TgLaltn/BoqKapURg9ZUX7Im
 9ZJLmpjJEZrJPzhdFSwmp1sQaf71MzrM1slmtVl0tlFbGntSmU4FX0KNH5xGvYRl2ir7
 Xi7g==
X-Gm-Message-State: AFq9FYI7yAK12Rt1UBxirxXi6pvIlFmAU8T4cfbxJgraqWZ3k3HDjtU3
 ineMjqDDdfhd0eIyjeDtKKOJd6/wY2wY18xvaeCUlAxP7gpquCyH/Lls4djCPqcOK22N4453Q09
 FmMgyFwvHI8vL4tfNhOLe3iromHrlp/vX/+YR8vhaPOqytWiTt2eNxDD8/Kf8K3ksF89R
X-Gm-Gg: AYBFou2j+F0SWd5ApVFqKlxILWCWpeCSVe7GSukBjDPubg0Aluc+NY5lyHGr8+C8QmO
 yff8FS9sP2fDLoP897Uyc84ddgWfLxeJDFgAfc/NfafvnfzpWt3BbrbhEdh3SaMvqYU94j5bFX6
 Wa357F/w3T+iIz6vQlkh/XLL8yG6VtXTHbCnvbDm39mRq1y6eVKh9frD37nYXYaYywUjhA5qIjc
 8Ju8mfCIQdD8qSAIUegUsi/uZ6AL7d8KHm/WZ1JGiQeaLE6TSbvW0Vs+uN8LgrdYELwOAVFOOv4
 5WMqAl4owniWdJJsgrUkQXFbtSfSYKtJRSri/8SpEa+v0UrIaYfdgTk62eB5FLLvqQLtpiAcRUJ
 XKvqGJ6ix0xtEZMsSI7mqMGDdy9scRXnmYEDsb6I6LPb3LTTLhgEZvRQgnYlVR1q33GEjmnZ/09
 TTZ69HyUnr4HR6dGZMZDqCAH0n6s8k9Q==
X-Received: by 2002:a05:620a:6f03:b0:93f:216f:f404 with SMTP id
 af79cd13be357-94408a5cc8dmr463090185a.40.1793210475900; 
 Wed, 28 Oct 2026 11:01:15 -0700 (PDT)
X-Received: by 2002:a05:620a:6f03:b0:93f:216f:f404 with SMTP id
 af79cd13be357-94408a5cc8dmr463081285a.40.1793210475174; 
 Wed, 28 Oct 2026 11:01:15 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a96989ab11sm38853365e9.1.2026.10.28.11.01.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 28 Oct 2026 11:01:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH 4/5] target/mips: Do not use TARGET_BIG_ENDIAN in cpu.c
Date: Wed, 28 Oct 2026 19:00:38 +0100
Message-ID: <20261028180040.22848-5-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261028180040.22848-1-philmd@oss.qualcomm.com>
References: <20261028180040.22848-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=M4bYuCws c=1 sm=1 tr=0 ts=6ae2386e cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=1a-ODDeGAYAkkZ1mh-wA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: rPhd522eqZpIGTAGn4RDGaXK_vPUhali
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA3MSBTYWx0ZWRfX2it+A8hIf/AT
 EJ+w4JRgb3KMq1hOJWnef8x1UUVCN3X+v3Fs6WagwclK89xZXda2kcb4iywZqNB4aRoTEX6ajhV
 FQUr4G6QEE9zT7nBm71mPxigq83QvJc=
X-Proofpoint-ORIG-GUID: rPhd522eqZpIGTAGn4RDGaXK_vPUhali
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA3MSBTYWx0ZWRfX+tZJqa3c07js
 hAPDJoESeoT7an5bA/jy0N11ZyMee7Nsi8pIk0mhvJ/RMB2xAA7/QDJcG9QjVlR3HzRWOn0Bneo
 FVkuYohcdvppr3vsTGie9SFNLcragAvUL5rd4KkeN5GAdcYTB09/eorEej2IJ441jH8WB6rtpeS
 L0nIYhintGlpvd2VIs0fKuUOQDOzqt4yx9LFfbjQ/9AkMJELusL34jD0S6xYjDCdO/qMmvDT+Iw
 OA0os5ZhPoi0oN9uL94GlOO4CcM79HK9oOzCaHHwvIUpr/D0uHTgDa6jPChFtJU3FWzS6z+vNeS
 HJCFBBTkx8tENjZDUzcgaygLSG74bIJ2cXGmgALQx0PvF75EOaGsw2fZ8nu+p3J7LdERUjJfpfM
 wIuUeM4cQLxdNeNn4Gd9plpfXGDsiQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2610190000 definitions=main-2610280071
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

Use the vCPU endianness (CP0_Config0.BE) to select the disassembler.
Default the "big-endian" property from target_big_endian() in
instance_init(), as the endianness might only be known at runtime
once user emulation selects it from the guest binary.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/mips/cpu.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index c5193dbc8e35..8ad5e49ade41 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -21,6 +21,7 @@
 #include "qemu/osdep.h"
 #include "qemu/cutils.h"
 #include "qemu/qemu-print.h"
+#include "qemu/target-info.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "cpu.h"
@@ -500,10 +501,11 @@ static void mips_cpu_disas_set_info(const CPUState *cs, disassemble_info *info)
         info->cap_insn_split = 6;
         cap_mode = CS_MODE_NANOMIPS;
     } else {
-        info->endian = TARGET_BIG_ENDIAN ? BFD_ENDIAN_BIG
-                                         : BFD_ENDIAN_LITTLE;
-        info->print_insn = TARGET_BIG_ENDIAN ? print_insn_big_mips
-                                             : print_insn_little_mips;
+        bool big_endian = mips_env_is_bigendian(env);
+
+        info->endian = big_endian ? BFD_ENDIAN_BIG : BFD_ENDIAN_LITTLE;
+        info->print_insn = big_endian ? print_insn_big_mips
+                                      : print_insn_little_mips;
 
         if (env->hflags & MIPS_HFLAG_M16) {
             cap_mode = (env->insn_flags & ASE_MICROMIPS
@@ -636,6 +638,7 @@ static void mips_cpu_initfn(Object *obj)
     cpu->count_div = clock_new(OBJECT(obj), "clk-div-count");
     cpu->count_clock = clock_new(OBJECT(obj), "clk-count");
     env->cpu_model = mcc->cpu_def;
+    cpu->is_big_endian = target_big_endian();
 }
 
 static char *mips_cpu_type_name(const char *cpu_model)
@@ -665,7 +668,7 @@ static const struct SysemuCPUOps mips_sysemu_ops = {
 #endif
 
 static const Property mips_cpu_properties[] = {
-    DEFINE_PROP_BOOL("big-endian", MIPSCPU, is_big_endian, TARGET_BIG_ENDIAN),
+    DEFINE_PROP_BOOL("big-endian", MIPSCPU, is_big_endian, false),
 };
 
 #ifdef CONFIG_TCG
-- 
2.55.0


