Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46419C5DF86
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 19:27:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwPQ4-0007mu-81; Tue, 18 Aug 2026 15:24:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPPx-0007ix-KV
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:24:13 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPPs-0006jB-9c
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:24:13 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IHJIcO735707
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:24:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=vu3VFtbXa6q
 qA1P5fBwdwaK04ALrwsOT5VzXt9s0a8s=; b=pF5JKyGqqWBR2IDRx9SXN3LSRQ9
 apuShju6QimGio3fMMfE+Uu4caJdSVoXShBCLr8HXvfRnlj5fTLX0M7t/27RBPeI
 rFudd5fpZXXpZEW/ZxxzzMiVqQBoAZxQv3PBi2Ao8KTZZarw/dKptufT+pcO+Gxn
 I1qG/k58YigqRczgyg+muowpGprx984K6bcI+AorSxD/1N1Ctb0e7CF/B3yG3aNU
 UmDnNyRWlXEcwwaWTnFrITSQeJGqE6kEwSdnrevsDFv9BE9WfdE87kgFARwaleI7
 O/ckg6vmhkIKTmN04j7lbd8PIkNFVEMUI4s5V3kXvSTLdRbss+rQhdsKTkg==
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4reshkv5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:24:07 +0000 (GMT)
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-4a41f46d629so342608b6e.3
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 12:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787081047; x=1787685847; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vu3VFtbXa6qqA1P5fBwdwaK04ALrwsOT5VzXt9s0a8s=;
 b=DDQmMBf4wLrfJUpUpQs/Ha16F+1ehRiRug7fx1MinXSMylLqd3/yp8cKfuwXcW2vlT
 F7iKxfCd4jhHPEx7eWS7YD7wDxvwpoD5zshdSrqc3GGmcR0s4HPnJ12NeepGXOfMWAfN
 igznG5JYqyD2vSjiSnZAEqHpz0IXitIMY0YzLd9qTddmNcdixNo9xOljLzZOFEo6pB8Y
 FAN84olBY+6NteW4NUSkkUnbbR4256VNNgDhjJx7600AuCkHschIL82gCXUbzz+AiGeF
 qdhpfe/d4e57tKXs2tp03NaUploSslYYsrKnL0SX0bR8IwWgz7S3IHGAr3DziL2MXdFg
 DFPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787081047; x=1787685847;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=vu3VFtbXa6qqA1P5fBwdwaK04ALrwsOT5VzXt9s0a8s=;
 b=a0xoNXKlAf+OLiXT0SgvYZA6o5MRiGbGjJWl0RLXVXACdew/tyWzqugo9UzQPPy0A5
 oYGop3gsILoYXyh4nPqIMt71sZrq6v4dowu9XlX3rluxzmSDq9+9WEk9af760bEFPuYm
 vJr9Tq8H45NShpJIPLXvCaI3E5bDRSLoOVBzWeZy/9maZfBPCBMmhtJLvyCeCScRT/PE
 tO8VQobfRX0rzF9dpIHepLaEAf4NXZKkouFKVHvb1oyh8CviOtgXbYl0sYZFEYQpCl3W
 RDl83HIugB5M6AJry+1DMn488Q7KbT8inDMqFTNlsdnwKB/n1SPEbV3MQiWInM2aFfwc
 G3CA==
X-Gm-Message-State: AOJu0YxuD/RkT3viKFgWQ8WM7YJ5ZiZyjwou3YcslstksKmpmkj9MeSr
 hclHdhtQOpnZLKKh6uZldDRT1VyBT6/fIooyvuVG2RomGoLABx2PAa0/TFtL0s9n9C8kWNmHWTg
 jIugapwqj0sOuiuVUearlmRjcz3R6WRla2dvVnEX8/mZaX0gsTueohdg0v/f8lmJ1Ow==
X-Gm-Gg: AR+sD10xQIxjTKXPYWk6kvIQGPjuZWjcIejxpVD7E3tNtHYYo9T0li9jW92m7VJhIMo
 MiJ+mtXuFsjF91T0j3GzJGA8XP+47xli1Ffwnf35Z55ByrrXUa3WQpX9u5yUFCDRaifwzQ2VYGZ
 6AUyhcc+c8OPQ9VdZJ6rz7WyJfhvzR0ei1KSehOmD2YJ89nsYtK76epVIARZ1b09yhj/05EkB8F
 ffdsYy0PkCijgwtF2IGdfsQqxsx3Ghnqe1gZ5ggPq7f9I3eIDzHUXfaG9+1+GihAQDROh3FNLDk
 nTbXLSL/ICgnFDBf3TmoC89zK9a0twbbwz0DssKJ6h92WjrKlX8FGBgXRgILArTmN8BS9BftqxP
 y1R8J6AxACvgzCIgNQJCm1VO3/UVJzry/+Xow4Ko3Xw84cl/aXqnFsKPgL54=
X-Received: by 2002:a05:6808:1916:b0:496:a01:458b with SMTP id
 5614622812f47-4b2412b98bbmr30461839b6e.2.1787081046643; 
 Tue, 18 Aug 2026 12:24:06 -0700 (PDT)
X-Received: by 2002:a05:6808:1916:b0:496:a01:458b with SMTP id
 5614622812f47-4b2412b98bbmr30461756b6e.2.1787081046232; 
 Tue, 18 Aug 2026 12:24:06 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3267c897e37sm21879429eec.28.2026.08.18.12.24.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 12:24:05 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PATCH v7 034/104] tests/tcg/multiarch/gdbstub/prot-none.py:
 deactivate on gitlab CI
Date: Tue, 18 Aug 2026 19:21:58 +0000
Message-ID: <20260818192309.22169-35-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Ne/WEWD4 c=1 sm=1 tr=0 ts=6a84b157 cx=c_pps
 a=4ztaESFFfuz8Af0l9swBwA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=p0WdMEafAAAA:8
 a=VnNF1IyMAAAA:8 a=EUspDBNiAAAA:8 a=3V-_cSConhulDen5wCkA:9 a=O8hF6Hzn-FEA:10
 a=TPnrazJqx2CeVZ-ItzZ-:22
X-Proofpoint-GUID: bXvR20neRw-P9u27P_iQqF7zze9NMNVb
X-Proofpoint-ORIG-GUID: bXvR20neRw-P9u27P_iQqF7zze9NMNVb
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX9yxqd4C7dBv+
 Vwtwv4SkIumKJ5LVw/cV5ay9pqyP84EO4Rm1OHZwn7/9tOsGpvsaK8gyP/xA/Nj2iq3Nq+0FZb/
 zB2HcznvAYlAo81OEAttENu00mij/KQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX2EqrByZKx6dW
 kSbOmrfvBPkZB9Puprj0XQtngefEPbuyxuH5mptB0nUozX1pxQ15bvXp7WmvD9XCIUNafHGPviY
 +++d2shv97/seGGX4L5GBFmDA7YtMoYISy4CfAp1eZK9z8Q+KB23J8UG66TQTeTHI/1IaW2cXpd
 cKgCbcYnIPAr0O740msw/q5PplYraT8Tkl+rh6gs1g2LH54pTiHyDymryEqMQHbv6vtazciSrtS
 LWwMNjEsioJ8JhWFHf5dZuMOhNTb/+owt017I0ZThkYtBdMMFUjv4vzdbGAI/lwgpQtzP43sqRK
 yvZqN32JJSy9Q82BKLpBnxTOre/eZGm/RfPVUlkyZHuxh4sAHnc1xRBMIVFqYDoQAn/sT+feKs1
 svjNey62f8MMsN2+DZqCBYbfEvZ7bY+6J98dbqkmgPa98cK7gkdxv1LZGuImppSp1s5e+mjHmls
 lS6yoCy9EPrrPBHsRWA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_03,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 suspectscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180142
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

This test was disabled on Gitlab CI.
Tracked in https://gitlab.com/qemu-project/qemu/-/issues/3329.

Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/multiarch/gdbstub/prot-none.py | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/tests/tcg/multiarch/gdbstub/prot-none.py b/tests/tcg/multiarch/gdbstub/prot-none.py
index 51082a30e40..e653bc697f6 100644
--- a/tests/tcg/multiarch/gdbstub/prot-none.py
+++ b/tests/tcg/multiarch/gdbstub/prot-none.py
@@ -5,6 +5,7 @@
 SPDX-License-Identifier: GPL-2.0-or-later
 """
 import ctypes
+import os
 from test_gdbstub import gdb_exit, main, report
 
 
@@ -21,8 +22,16 @@ def probe_proc_self_mem():
 def run_test():
     """Run through the tests one by one"""
     if not probe_proc_self_mem():
+        print("----------------------------------")
         print("SKIP: /proc/self/mem is not usable")
-        gdb_exit(0)
+        print("----------------------------------")
+        gdb_exit(77)
+    if "GITLAB_CI" in os.environ:
+        print("----------------------------------")
+        print("SKIP: fail on gitlab - " +
+              "https://gitlab.com/qemu-project/qemu/-/issues/3329")
+        print("----------------------------------")
+        gdb_exit(77)
     gdb.Breakpoint("break_here")
     gdb.execute("continue")
     val = gdb.parse_and_eval("*(char[2] *)q").string()
-- 
2.43.0


