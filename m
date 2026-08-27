Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08B27C61DB9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:16:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziNx-0005qZ-SQ; Thu, 27 Aug 2026 18:15:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziNu-0005iT-QH
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:15:46 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziNs-00068B-CJ
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:15:46 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJLlRM125024
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:15:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=jEi7+9wXPIv
 iNeWGzhbSTZK5PZiS+AoE+QzVMs8ON4o=; b=ZmY9I7RXBQVGvZ3CzgBtRp3ySq9
 +xJPy49Ml3ypEdCRUwO7mpPVQTm6kIAKvHdpST2YBvzLXreSNBqlIaDwqc+Fw60n
 oM6EBSftpA0SRt34lJLeVjQiV31J8TOqpJIak/sSO7WkbgZg4dqdeH2He3ifl3Vk
 xyjVNqgGElRoOqwFuSPxJpDiYtAAmrCcJByzM1gXpp68/MEc3NZ+zQb2muKaViCa
 OJiPy8VVK+2aTY4F1x8k/VpexiQS/kLZ2RfLHfdDpYoXza1RsJQepxeVa2N5gEBt
 yrFfe8T1VLf/EGFjqgEtRnW2do5sF2Bv968Nf5Xsi5R5oOhsGc7dao5wXUg==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4game7tvrg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:15:41 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-84842381150so472240b3a.3
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787868940; x=1788473740; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jEi7+9wXPIviNeWGzhbSTZK5PZiS+AoE+QzVMs8ON4o=;
 b=jzMJPnnnJ2YY3/mAZMQzUnvOcgRikEu4npPZnbZdHZXiHxlLl7U1Uc2+Ct08zwxEc2
 9Rk8o/NEumKWK0XVgxY/tooKcR2+z0NR4K26GE0dpMyqWb7Ep6KTACFtduJ58i1ICK9Q
 5t0oQBCMIwmh9cHrVkewqORAkyKDPZQXBHR29zKceujQLUP3FkF5m7FWnMYkh7BZ9HVN
 zslMBkS77vUBsUtE/p+a9GieHsBcf4Jt4opW2HAbT4HvKOAcBM3T7y/HQP+EWhuSxEZp
 aBnvIVx5EcfjUvfq7ak+bS0hCOwWfb03OIsh5e6GpP0l3CkyfNAwNSkw5OVRrieFQdYf
 P+xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787868940; x=1788473740;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=jEi7+9wXPIviNeWGzhbSTZK5PZiS+AoE+QzVMs8ON4o=;
 b=SU1FsKdROw22TU+BfIxBKij/SC0pp/j1wA4rKasT/Qe29+h8/h/VmOghQuGjUwq/5Q
 UezwW7nWa+XhYgFudjuHew837+kOe0NqWXTv5bm2hynH7pmMaC6mhoIDTn+IrmhqRlAv
 ForZzeOxw3DSt1Xb4A0GsQSD/XLjWTD8YWxDd961SwfTHYghbmUf84Jrzj3DwXSXhg6w
 vFDycZcy6kaoVp8N4giK4yOBOL/BQBzuHBx3DM2I3GCEUT9wEV7cAjIFVeV74MRB5ghe
 8j+TdQ3G21DoWM5/W6MFkFQ6Vnzgj3ILQyhNL68iPtA2s4TKYy2mxui44wh96ADux96M
 nxtA==
X-Gm-Message-State: AFuF++nHx37xWGKiJaseGb7ss4fCW+wy18lvyw9O2jZSHMT6qR4NmtD1
 JN8m98W0Q6ACoTUgs1xdhgSUUxlplwouU0aE+ff2wLOj8RmUoWIyhy1EE7V7dALcP/ObzoiXkCC
 RsyOB/ZMfIIxBaIYi73m8Ga6+tTpo2/sRaAGwGYHtT3bRJGmqwt1i2yMJAqLRfmpI9g==
X-Gm-Gg: AR+sD12NDSSwhkgqNnhO0kyLFwrsapEcS8VL1mkj/In/KjuO1M8mulsZBVDYkzVaTa7
 kYn9u61UGOfhHWKdvwo8DfEqb+Atig3jf1xdDaZ/k8ZjP1hNPW87E/P55P+9SdKA2bSuzaRTuqq
 Z5L+SlVKWhgdJKBWfL4H//sd4GGOGptuLB7BGQthJPqK0Ky4WYNHX9oCuH7Sjt8znwGB7lnPB3q
 5h1AANV83MLMeK3erREeOF8gFo5MNjJzAwQ3GagJxWS0psedzjcql9Tb2OaK5zY9aDYnCjST6qC
 MX1WP/3uIKaXIWlK9uL9BD8FXttkSNaaacILy1cptv4x78Pn1PTyO3pcY5S+q2ZgMXAKx9cyGY6
 mXHZ5lw8lI3ctqoFh/ceNeIUz092SxjYYAZwTlV84hMVi5y5r5gU1l2gnPHo=
X-Received: by 2002:a05:6a00:4287:b0:845:bda6:574b with SMTP id
 d2e1a72fcca58-85628b7d701mr5062085b3a.5.1787868940118; 
 Thu, 27 Aug 2026 15:15:40 -0700 (PDT)
X-Received: by 2002:a05:6a00:4287:b0:845:bda6:574b with SMTP id
 d2e1a72fcca58-85628b7d701mr5061999b3a.5.1787868939691; 
 Thu, 27 Aug 2026 15:15:39 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8535cf4b213sm2524104b3a.55.2026.08.27.15.15.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:15:39 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Stafford Horne <shorne@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 pierrick.bouvier@oss.qualcomm.com, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Bibo Mao <maobibo@loongson.cn>, Helge Deller <deller@gmx.de>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Song Gao <17746591750@163.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Laurent Vivier <laurent@vivier.eu>, Nicholas Piggin <npiggin@gmail.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PATCH v8 025/105] tests/tcg/meson.build: let test infrastructure
 detect compiler
Date: Thu, 27 Aug 2026 22:13:46 +0000
Message-ID: <20260827221506.91574-26-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfX0kd06ohDQuYd
 EDr59/G32v6k81CH75Nu5DSR6B7pqSbeAvMlPICHy8LivaxOKtVLXsrbcWx+QpdaubpVIxWbT2W
 x73vnzVpExIS2Rp3biDbxYGaCB2KEDLsPt5nrBUz+R1T2fofZj/p1nmq07jJmQPrm/q4td7Z1Ni
 G36qiuBnHAQFwuCUM5WbERctNUt/N1f5Lpz2xNZSrEneWa1Quhf2CLJOVrJC9HzLiCzRKJDTNmW
 vC/tdGCrw8edqc7VBE4zu5k6F/KcadUerfphZIVqZKJMcCnpAHTq89EwSznU6h3DBnYfII2rnfi
 jl24YVZq+cGDvyG+5pGMXz8kujrekxFzKGJ+CzBRoDqjfnQUXw7oh96uFO4Dsu57AVz+gEpGpAj
 AFhEJKh77qmIUEE8sLMbp1GhbBpPA1GMVOC99HZ4znh6TsKA2URqzBgj1BtiIo4h3jjLbaUtd1D
 kpMmZ88LWXtbhIXDV0A==
X-Proofpoint-GUID: edZKt0HJwoJdvNrUHEEjZ5YTAFsZBF42
X-Authority-Analysis: v=2.4 cv=Yrc/gYYX c=1 sm=1 tr=0 ts=6a90b70d cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=KKAkSRfTAAAA:8
 a=VnNF1IyMAAAA:8 a=EUspDBNiAAAA:8 a=tvGfH4KSH3m2s3Kz7-kA:9
 a=zc0IvFSfCIW2DFIPzwfm:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: edZKt0HJwoJdvNrUHEEjZ5YTAFsZBF42
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfXw+S8JTE8IlvQ
 2owDr/ZByJzfOAC+fF1HPkygBqeWBy0lzpTHSzUHJf8fUlddRXkaQ9yKj9hiDBPYp7jMUPaG7xW
 2Kz8KQAQLS4dHLFrhwIZuqEpDXjJna8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_08,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 spamscore=0 priorityscore=1501 adultscore=0
 impostorscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270188
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Now we moved back flags to tests/tcg/meson.build, we don't need to
expose cc anymore in target files.
This will allow us to easily introduce cross containers.
Also, we can reuse the skip_test logic to gracefully report why tests
don't run.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index c227bb52381..9c00d21f059 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -19,7 +19,7 @@ tcg_tests = {}
 #
 # {
 #   'name_of_target': {
-#     'cc': cross_compiler,
+#     'cc': 'cross_compiler',
 #     'cc_feat_cflags': {
 #       'name': ['feature cflags'],
 #       ...
@@ -96,7 +96,7 @@ foreach target, plan: tcg_tests
     endif
   endforeach
 
-  cc = plan['cc']
+  cc = find_program(plan['cc'], required : false)
   folder = plan['folder']
   gdb_arch = plan['gdb_arch']
   qemu = plan['qemu']
@@ -189,9 +189,13 @@ foreach target, plan: tcg_tests
       if 'cc_feat' in setup
         cc_feat = setup['cc_feat']
         if cc_feat not in cc_has_feat
-          cmd = run_command([cc, cc_check_args, cc_feat_cflags[cc_feat]],
-                            check: false)
-          avail = cmd.returncode() == 0
+          avail = false
+          if cc.found()
+            cmd = run_command([cc, '-xc', '/dev/null', '-o', '/dev/null', '-c',
+                               cc_feat_cflags[cc_feat]],
+                              check: false)
+            avail = cmd.returncode() == 0
+          endif
           cc_has_feat += {cc_feat: avail}
         endif
 
@@ -202,6 +206,11 @@ foreach target, plan: tcg_tests
         cflags += cc_feat_cflags[cc_feat]
       endif
 
+      if not cc.found()
+        skip_test = 'compiler ' + plan['cc'] + ' not available'
+        built_tests += {exe_name: exe_name}
+      endif
+
       # build executable if needed
       if exe_name not in built_tests
         exe = custom_target(exe_name,
-- 
2.43.0


