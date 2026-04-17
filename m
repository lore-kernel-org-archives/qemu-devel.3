Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A2F2FA0C5E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 19:47:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDp8y-0005ap-0e; Fri, 17 Apr 2026 15:46:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wDp8v-0005a8-6D
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 15:46:21 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wDp8s-0000YR-FL
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 15:46:20 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63HG4SJq2945226
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2026 19:46:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=t/IaNMz0/ou
 P9Lh56eKStXQsx4b7fRQ1h6cw0izNVyc=; b=g5MBlvAYFHRq/MT4ljo0XObFDq8
 WNlPRKp/rBSF9G/3m57Dxem/lcdGRs4Jt0Arj6L/pKzf7shyvyRnnxl1DoiXV0jO
 +uLZk4IqQHSxZmRFJuu6QYp8ot+TtuL+sr5v5weZc2qVf5gdCpHjGPozK0HwvDvu
 3on0mBQVYKPuw6Vz5VSPMAE2EYa1F7fD6XGRCD1TzScjOlfPYJWbS6/oP0dRsLu0
 KS3a7HkZAv72dyN0r3aRragGi+F/whQ0ZrLt9gxFx6BJoom3vpqX9mnbLBCgnQwr
 moEvhwi8/+BE7boY2QIzMb5qVaUIu0kos7+ZN7uVdYLT4MQrQHDs3cUZ4sA==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dkdgy33q9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2026 19:46:16 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-12bf921cf49so1174810c88.1
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2026 12:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776455176; x=1777059976; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t/IaNMz0/ouP9Lh56eKStXQsx4b7fRQ1h6cw0izNVyc=;
 b=Ocl65r4thph00i8FJkryAtIHUtDHW7KA1IpNA7tiZUKzdzNs6knN3jzebnqhUYa7jV
 ayKLRfiEBGwDyoHEE7n0gXU8LkS5KXHp1MCvFjtJsze2i4yELt0CmeMjX8SdMv7Cr2px
 iApq89GGJsKyZFn9aYDUkkmQUYSAfJ6AKaAv20m2POfUn96dzdIYG8dd8tITvpdncNh3
 M8P7P45B+xTzal/xxTOH9v0rj5vimN3JmVQbxRyDm3GuD4m4IKZxV2Oi+0Yb4OAyYNNH
 nlXf5LVbRKiOHCzZ43mbFFNLxkOnZMHV96oG9Dclh8630gajoM6CSBioRFkx+SOYODQ5
 C1DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776455176; x=1777059976;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=t/IaNMz0/ouP9Lh56eKStXQsx4b7fRQ1h6cw0izNVyc=;
 b=Y5eFgjExmOvohD0uZ47IJCS7m2qn+T36CJFd7MWhnhk85sniRPuTpJ1JwAh+PKVo2L
 r2BXQ1y/mD8J6nHdbOsO+wTY2/oCMZjh6VpDgH6RzHTVyGIsLPNwHI6WjQhJJdnOyxdB
 LYCqBZe8iOVKFyYJaqBCPSzSeNVIgUvV2VZh7AKCtHHQqZ86WfJQIeB4DOLp2ipA6nSN
 oQ39hLVIhDsomczzCt5xtJh3tExuXnTKK88euLbXG61WagbCDb7sjX6OI9q2WP/T3gvN
 DFBvJHZL/eaKpSsmYr8P56D7NFARMV6kZp9i4TlJi3oum4DZqZCgF3FBtr+YnNs0Ihe7
 umiQ==
X-Gm-Message-State: AOJu0YwU2DCxKBKKUuxi4MCVRZP/p5+xIi8GcoP/ZS7cMHphPD08273p
 3COzfglvXFRABbI5y5QSZ9/Wbpvz7LbGBv7FGbELH2lXf1JQ9CducuPXr0sFwFO1QLQqG5maNqd
 M3/pvNhnQkY77VuVA4/HUOCh5zX6ShzK2PFWx+fmrntDTbflgXyPGerWzvFY5kKREFw==
X-Gm-Gg: AeBDievRQtdFgkTW/+IX+zlZyCJLPjziBU2mxwDo4hVee5ODxw/DmioiyGt7+L6GOkT
 LhC9/xmTPTbXI20dyIFx3IJGpBwghWsH0I/WXPlJDyYr4egwds5jQA7C1Yrg6EGegITMt2jkfqB
 rto7JKK/Q96qKhL/zmxFB0TcnJwcJ6+EFUIeT9x9w5Fo7SX0kU+yMqd/a0NyHe1prVAoLSiug4j
 Sb6weHcu+HDYADfPsgqhkU83KKIg6UJhYJwlskDGCE/8+HoJLPmdIQfAaflaToNP/SjCeEr5A5e
 V/uXngE5NGs8gQqfVvXFJ9vnHIhqYVhYWKmm6JcXkEykfNDqeC0etJN8wus8bEQJWCS/EBYmz6f
 jmNRkNdqlTk0aqHl18JKEeJrGAu4YfQez591iOxIxitOE7QNEl/1KyWQ+a2gvNU4chlnDx/X1mm
 A0x4DMSldOSx/rE9IbRowv4JWj7FE=
X-Received: by 2002:a05:7022:60f:b0:12b:ed30:5a32 with SMTP id
 a92af1059eb24-12c73f6e183mr1917089c88.5.1776455175443; 
 Fri, 17 Apr 2026 12:46:15 -0700 (PDT)
X-Received: by 2002:a05:7022:60f:b0:12b:ed30:5a32 with SMTP id
 a92af1059eb24-12c73f6e183mr1917059c88.5.1776455174624; 
 Fri, 17 Apr 2026 12:46:14 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12c749d29f3sm4634325c88.5.2026.04.17.12.46.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 12:46:14 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 matheus.bernardino@oss.qualcomm.com,
 Marco Liebel <marco.liebel@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 1/2] target/hexagon/meson.build: simplify decodetree file
 generation
Date: Fri, 17 Apr 2026 12:46:05 -0700
Message-ID: <20260417194606.39997-2-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260417194606.39997-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260417194606.39997-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 7j91LSiK0LTMoWglQ7IoStI5bGPHsY2n
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE3MDE5OSBTYWx0ZWRfXzd5jPfrZ/Qtx
 JILT/JQOZv8BFDSIqQqhTxw1OOw3JqrZVLNPCssJ7op/l6gcPglsjY7A0bjoHxhZQ7fBC5ZHkv5
 CbzDuW/8Y69yyz/lo4wgUEHm6mC8BeJ4oH9RUVxdkxt09G68Xkb4G6dWQsS+F0gfVjBQ+a3BR0I
 fIyPa50WhxzWnLb8eM+kZ3VZac6s4UB+oNIv3bNEqmokfUbrMK/MkgEFojaQrIw7mT9N6nxBBW/
 5mOKkYjXdLTQT8OQ/n06i9jZlT0XsFnY+ZxKCuA9WQC2R8/pFy0q8ZA9veAyoebRXjVtVhVuh1q
 +Te3reTRWHKDfg7vcit/3AYA+aGjBHKgU8S+rdiXzINw2lcC0s5GnF2dgkOXXZqT053cG/wLvW0
 qdfPqoO6ttByocUSm1lHQ9V5Oiy3tiXAsnJeETfW8S/D6DWPiRDxCjGn4O4BW2iRkluWiTnsBLB
 pUpI5Xu2BW5p+6zCXGw==
X-Authority-Analysis: v=2.4 cv=GN041ONK c=1 sm=1 tr=0 ts=69e28e08 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=0OY9Ckch0cO6u8H8HYMA:9 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-GUID: 7j91LSiK0LTMoWglQ7IoStI5bGPHsY2n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-17_02,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604170199
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Use a loop over instructions sets and decodetree generator instead of
manual custom targets repeated.
Modify included files accordingly in target/hexagon/decode.c.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/hexagon/decode.c    |  14 ++--
 target/hexagon/meson.build | 145 +++++--------------------------------
 2 files changed, 26 insertions(+), 133 deletions(-)

diff --git a/target/hexagon/decode.c b/target/hexagon/decode.c
index dbc9c630e8..4de0541536 100644
--- a/target/hexagon/decode.c
+++ b/target/hexagon/decode.c
@@ -67,15 +67,15 @@ static int shift_left(DisasContext *ctx, int x, int n, int immno)
 }
 
 /* Include the generated decoder for 32 bit insn */
-#include "decode_normal_generated.c.inc"
-#include "decode_hvx_generated.c.inc"
+#include "decode-normal.c.inc"
+#include "decode-ext_mmvec.c.inc"
 
 /* Include the generated decoder for 16 bit insn */
-#include "decode_subinsn_a_generated.c.inc"
-#include "decode_subinsn_l1_generated.c.inc"
-#include "decode_subinsn_l2_generated.c.inc"
-#include "decode_subinsn_s1_generated.c.inc"
-#include "decode_subinsn_s2_generated.c.inc"
+#include "decode-subinsn_a.c.inc"
+#include "decode-subinsn_l1.c.inc"
+#include "decode-subinsn_l2.c.inc"
+#include "decode-subinsn_s1.c.inc"
+#include "decode-subinsn_s2.c.inc"
 
 /* Include the generated helpers for the decoder */
 #include "decodetree_trans_funcs_generated.c.inc"
diff --git a/target/hexagon/meson.build b/target/hexagon/meson.build
index d169cf71b2..d993e1b520 100644
--- a/target/hexagon/meson.build
+++ b/target/hexagon/meson.build
@@ -93,135 +93,28 @@ hexagon_ss.add(iset_py)
 # Step 4
 # Generate the input to the QEMU decodetree.py script
 #
-normal_decode_generated = custom_target(
-    'normal_decode_generated',
-    output: 'normal_decode_generated',
+insn_sets = {
+'NORMAL':     ['--static-decode=decode_normal'],
+'EXT_mmvec':  ['--static-decode=decode_hvx'],
+'SUBINSN_A':  ['--static-decode=decode_subinsn_a', '--insnwidth=16'],
+'SUBINSN_L1': ['--static-decode=decode_subinsn_l1', '--insnwidth=16'],
+'SUBINSN_L2': ['--static-decode=decode_subinsn_l2', '--insnwidth=16'],
+'SUBINSN_S1': ['--static-decode=decode_subinsn_s1', '--insnwidth=16'],
+'SUBINSN_S2': ['--static-decode=decode_subinsn_s2', '--insnwidth=16'],
+}
+
+foreach insn_set, decodetree_options : insn_sets
+  decodetree_file_name = insn_set.to_lower() + '.decode'
+  # generate decodetree file
+  decodetree_file = custom_target(
+    output: decodetree_file_name,
     depends: [iset_py, semantics_generated],
     env: {'PYTHONPATH': meson.current_build_dir()},
-    command: [python, files('gen_decodetree.py'), semantics_generated, 'NORMAL', '@OUTPUT@'],
-)
-hexagon_ss.add(normal_decode_generated)
+    command: [python, files('gen_decodetree.py'), semantics_generated, insn_set, '@OUTPUT@'])
 
-hvx_decode_generated = custom_target(
-    'hvx_decode_generated',
-    output: 'hvx_decode_generated',
-    depends: [iset_py, semantics_generated],
-    env: {'PYTHONPATH': meson.current_build_dir()},
-    command: [python, files('gen_decodetree.py'), semantics_generated, 'EXT_mmvec', '@OUTPUT@'],
-)
-hexagon_ss.add(hvx_decode_generated)
-
-subinsn_a_decode_generated = custom_target(
-    'subinsn_a_decode_generated',
-    output: 'subinsn_a_decode_generated',
-    depends: [iset_py, semantics_generated],
-    env: {'PYTHONPATH': meson.current_build_dir()},
-    command: [python, files('gen_decodetree.py'), semantics_generated, 'SUBINSN_A', '@OUTPUT@'],
-)
-hexagon_ss.add(subinsn_a_decode_generated)
-
-subinsn_l1_decode_generated = custom_target(
-    'subinsn_l1_decode_generated',
-    output: 'subinsn_l1_decode_generated',
-    depends: [iset_py, semantics_generated],
-    env: {'PYTHONPATH': meson.current_build_dir()},
-    command: [python, files('gen_decodetree.py'), semantics_generated, 'SUBINSN_L1', '@OUTPUT@'],
-)
-hexagon_ss.add(subinsn_l1_decode_generated)
-
-subinsn_l2_decode_generated = custom_target(
-    'subinsn_l2_decode_generated',
-    output: 'subinsn_l2_decode_generated',
-    depends: [iset_py, semantics_generated],
-    env: {'PYTHONPATH': meson.current_build_dir()},
-    command: [python, files('gen_decodetree.py'), semantics_generated, 'SUBINSN_L2', '@OUTPUT@'],
-)
-hexagon_ss.add(subinsn_l2_decode_generated)
-
-subinsn_s1_decode_generated = custom_target(
-    'subinsn_s1_decode_generated',
-    output: 'subinsn_s1_decode_generated',
-    depends: [iset_py, semantics_generated],
-    env: {'PYTHONPATH': meson.current_build_dir()},
-    command: [python, files('gen_decodetree.py'), semantics_generated, 'SUBINSN_S1', '@OUTPUT@'],
-)
-hexagon_ss.add(subinsn_s1_decode_generated)
-
-subinsn_s2_decode_generated = custom_target(
-    'subinsn_s2_decode_generated',
-    output: 'subinsn_s2_decode_generated',
-    depends: [iset_py, semantics_generated],
-    env: {'PYTHONPATH': meson.current_build_dir()},
-    command: [python, files('gen_decodetree.py'), semantics_generated, 'SUBINSN_S2', '@OUTPUT@'],
-)
-hexagon_ss.add(subinsn_s2_decode_generated)
-
-#
-# Run the QEMU decodetree.py script to produce the instruction decoder
-#
-decodetree_py = meson.current_source_dir() / '../../scripts/decodetree.py'
-decode_normal_generated = custom_target(
-    'decode_normal_generated.c.inc',
-    output: 'decode_normal_generated.c.inc',
-    input: normal_decode_generated,
-    env: {'PYTHONPATH': meson.current_build_dir()},
-    command: [python, files(decodetree_py), normal_decode_generated, '--static-decode=decode_normal', '-o', '@OUTPUT@'],
-)
-hexagon_ss.add(decode_normal_generated)
-
-decode_hvx_generated = custom_target(
-    'decode_hvx_generated.c.inc',
-    output: 'decode_hvx_generated.c.inc',
-    input: hvx_decode_generated,
-    env: {'PYTHONPATH': meson.current_build_dir()},
-    command: [python, files(decodetree_py), hvx_decode_generated, '--static-decode=decode_hvx', '-o', '@OUTPUT@'],
-)
-hexagon_ss.add(decode_hvx_generated)
-
-decode_subinsn_a_generated = custom_target(
-    'decode_subinsn_a_generated.c.inc',
-    output: 'decode_subinsn_a_generated.c.inc',
-    input: subinsn_a_decode_generated,
-    env: {'PYTHONPATH': meson.current_build_dir()},
-    command: [python, files(decodetree_py), subinsn_a_decode_generated, ['--static-decode=decode_subinsn_a', '--insnwidth=16'], '-o', '@OUTPUT@'],
-)
-hexagon_ss.add(decode_subinsn_a_generated)
-
-decode_subinsn_l1_generated = custom_target(
-    'decode_subinsn_l1_generated.c.inc',
-    output: 'decode_subinsn_l1_generated.c.inc',
-    input: subinsn_l1_decode_generated,
-    env: {'PYTHONPATH': meson.current_build_dir()},
-    command: [python, files(decodetree_py), subinsn_l1_decode_generated, ['--static-decode=decode_subinsn_l1', '--insnwidth=16'], '-o', '@OUTPUT@'],
-)
-hexagon_ss.add(decode_subinsn_l1_generated)
-
-decode_subinsn_l2_generated = custom_target(
-    'decode_subinsn_l2_generated.c.inc',
-    output: 'decode_subinsn_l2_generated.c.inc',
-    input: subinsn_l2_decode_generated,
-    env: {'PYTHONPATH': meson.current_build_dir()},
-    command: [python, files(decodetree_py), subinsn_l2_decode_generated, ['--static-decode=decode_subinsn_l2', '--insnwidth=16'], '-o', '@OUTPUT@'],
-)
-hexagon_ss.add(decode_subinsn_l2_generated)
-
-decode_subinsn_s1_generated = custom_target(
-    'decode_subinsn_s1_generated.c.inc',
-    output: 'decode_subinsn_s1_generated.c.inc',
-    input: subinsn_s1_decode_generated,
-    env: {'PYTHONPATH': meson.current_build_dir()},
-    command: [python, files(decodetree_py), subinsn_s1_decode_generated, ['--static-decode=decode_subinsn_s1', '--insnwidth=16'], '-o', '@OUTPUT@'],
-)
-hexagon_ss.add(decode_subinsn_s1_generated)
-
-decode_subinsn_s2_generated = custom_target(
-    'decode_subinsn_s2_generated.c.inc',
-    output: 'decode_subinsn_s2_generated.c.inc',
-    input: subinsn_s2_decode_generated,
-    env: {'PYTHONPATH': meson.current_build_dir()},
-    command: [python, files(decodetree_py), subinsn_s2_decode_generated, ['--static-decode=decode_subinsn_s2', '--insnwidth=16'], '-o', '@OUTPUT@'],
-)
-hexagon_ss.add(decode_subinsn_s2_generated)
+  # Run the QEMU decodetree.py script to produce the instruction decoder
+  hexagon_ss.add(decodetree.process(decodetree_file, extra_args: decodetree_options))
+endforeach
 
 #
 # Generate the trans_* functions that the decoder will use
-- 
2.47.3


