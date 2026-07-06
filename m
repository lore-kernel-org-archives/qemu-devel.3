Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98453C44500
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 22:35:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgru0-0003a4-Tv; Mon, 06 Jul 2026 18:35:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgrtc-0002q3-Aw
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:34:41 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgrta-0005dU-2q
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:34:35 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666KDqnG1650334
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 22:34:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=7MpNsmSX5PR
 Gztb8o3Y1vbYRSGzlp9rUDgEvemu3lkY=; b=jYjZaTfYfVDetr0lXVFExaVphpT
 z0P6jUEk7V4cT4YWEMeVVK6iPaiBvrgc8ocjMAn13ckQ0AVlzwgZX3weFvwGMZPw
 HADuFLAZbHVgwgRpOflRWtB8vF6hbG3RA0eq8vjJ79vYN0EXvGkJmxEvG7WN5XvB
 83nLc43RF+j4IZTyIPKCvib1wIv+Lt7X2U7Dgh8mfC/SApwQNlS5zI2znJzRasAT
 ZYSVac2XKnFiLe5eIsKGmWyG3zuYfJS3k5VL5r+bmgOtE/Z3+xPk47RjrRmmUXdr
 wv5QuTg3AjBs/ZzlxS1Jgtoa+bLfU7SD/581aHToes2isFiclJ4D6FYhVpw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f89kguan8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 22:34:32 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-385d2703b64so42412a91.1
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 15:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783377272; x=1783982072; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7MpNsmSX5PRGztb8o3Y1vbYRSGzlp9rUDgEvemu3lkY=;
 b=YE9Q2LeaheY5hzSdeUJbkuIs+p7sEMOoZnfm5ZcbY6T4yjd6yUicQwCmEppS7lmGI/
 DsbF3D9762Rv5CG1yiim/rdp6fBbYR/IEVveDyuhJMztdwPbyU5SrSnELJ5rmNC5a3Fx
 VzVC306g1MjkTweQhyysNzIg8j9W0KZ/jWn5qoZKosBAuNuZ4KDR20ljvh2m1YacoWlE
 4i8d3tyj+uphKrXgf8BlrUxT7yzqGQhEvdTTmeT1FPzJ84xF4/gkdPakxaX6t2Tik0o9
 Bzyrav/J7XY2UlbVZD69SqJ9Gb8rLn2j+CVBUJ3pu6aHPFFK91nRIN+floViIYwEz46V
 0OvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783377272; x=1783982072;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7MpNsmSX5PRGztb8o3Y1vbYRSGzlp9rUDgEvemu3lkY=;
 b=CwpEUw98FAbAgt4aeugrsG4jlYqcJqb7EjiZma9vK6HK5wRJa8bMTkG6ha6l6LX/N6
 7r09aXyLCUJ3OT4H+HW2CpJTc+s891SFQEOkmoOWsF/oBryMEN1f9V6HxNfXRDQPkKd6
 sjkUkexHLZM3u7Wpa2rGiBwUrkJiUOW8xmV7Rnvxs5F+28rZ8vyYkPIZTIdY9WZjf88W
 dDUEhc840wsrmKeD0qKIi8sRnhOUiyF5RvhRS2JEE7Ls2DEbsTOfRnQeN8bayZ7K20Zc
 HDlIsqleYWciryp1t+BYKo5Zsjse/tM575yASCn2gBi5DXhxDARTNC987eYo0nkxNR/u
 +3Sw==
X-Gm-Message-State: AOJu0YyGhMK/RsKjBwwuvo5H/Ev0sb8Gt1MInk1prPPhoODNuf7XB78m
 6yVJ71uL0SLtvpbXuu0ixk/wKyBrM7EG1gIWf40zKoEfSNz9ooyeaiROUfWFPGpnZ0LdiFm0mmK
 qMISdqfBV2lB+Va3xYm0fyAFmclKF8ksJPqWEvNtLJHgQCBsBX6xYPNAR4b4IU9qdVw==
X-Gm-Gg: AfdE7cm46PKaR0BH1Zor+ytQ7ovnoioUBkzAqEAhCUhi1gQ9dNBKEsS96e/QUetJwSj
 Qj580k+QlaVByk45m7oD9hZGz0Rt2nvDTCSq+Q9T8pJXZIfHhFAuCAuTd3G8pr/59hwtuwK8Ui/
 LUy0sUQwSkMaqENnlneRMucq8EA4mT0VWEaDPLo8yK1EDOwjm7/SqW4TtYZVjjaw/tKjWufVajj
 uwXSuUO4FDt0oNzyg5ehKFNpkBCPQK/l4Ip/IHvLfmMH8kp88ekdzeOxbznSMH6B/SCM1YT70LP
 JD34mAo8qMVzDglLkL/JGJZCPlcyQ9LlfxpSWfwP8XIb2pBBkHKFxn6Ey9gTAJPe00ZsPBWNFxy
 o0zVRfakz9hyTaOSPftL3AAFmhjTaf4/wG7JD6EriB1/ANmBWcLf7drPIf6D90ZdHNwKO2qw3ij
 JIQd28kw==
X-Received: by 2002:a17:90b:3e46:b0:37c:8df2:9f58 with SMTP id
 98e67ed59e1d1-387d7750f36mr215591a91.7.1783377271911; 
 Mon, 06 Jul 2026 15:34:31 -0700 (PDT)
X-Received: by 2002:a17:90b:3e46:b0:37c:8df2:9f58 with SMTP id
 98e67ed59e1d1-387d7750f36mr215564a91.7.1783377271338; 
 Mon, 06 Jul 2026 15:34:31 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31174ac0557sm977244eec.26.2026.07.06.15.34.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 15:34:30 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 25/91] tests/tcg/meson.build: let test infrastructure
 detect compiler
Date: Mon,  6 Jul 2026 15:32:37 -0700
Message-ID: <20260706223343.988769-26-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: mT6-cX_AuHKikMhgUvW0VLTpqiKgO0_O
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIyNyBTYWx0ZWRfX/kZB5dE4QT3B
 bVJmV0GOujXqxXBiUophnvKFDEpw2/ZPAGIvyf7s6/wu9we2QMKwo1kfuTGi31ecxoWzXRB5ZKJ
 9fe9MlT+EL5CSfqqjLCNYmLgi+qRxVG28paIY1S+vLpxnrqSeX3mlIlmkrOFohg8OZNq+4wGgKe
 o/t3ejw9gwhEVE/Lelvx4RZyb6gmihyWfLMG140r3ai25smMSeXCqd9ZnCjpvotzXrxhoXD2R8a
 uimzz4vue6P30hPJ+GFWwNemIP+NCcvKe9MND9/cVhaBcLfiVIqqxOlB/MqScTx2Dzl7HkWTb2i
 WCyI/a6wVbjD5uBjZ76s6vgKSsuWo5VksLIlT+yn+AmlxuITe5vNazsLYEuek/imGORXi3m55mq
 5dVp2L6yPBGbp8dNvB+GWrHD5JStuBYYeNESYVHarO3MGhMG0B1OoptvB5QH5PwUItojXQn1+aj
 HJadUIm0t0jwpHx9EPg==
X-Proofpoint-ORIG-GUID: mT6-cX_AuHKikMhgUvW0VLTpqiKgO0_O
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIyNyBTYWx0ZWRfX27Tq5xqLymtE
 plf/7EL3JK7zINO0oY/U1e7XT0AdVj6tieOTD4DFIg5qWU/wbE4KDSCtYWNdGVTtsJ3EvrCfFmU
 ZcOfiDimHRlvXsT+4jU+PPgGGmFpUck=
X-Authority-Analysis: v=2.4 cv=c6Sbhx9l c=1 sm=1 tr=0 ts=6a4c2d78 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=w2-p--iVsToKY_bx00cA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 clxscore=1015
 adultscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060227
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index b6b7302ffb6..0d2fefe8f51 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -20,7 +20,7 @@ tcg_tests = {}
 #
 # {
 #   'name_of_target': {
-#     'cc': cross_compiler,
+#     'cc': 'cross_compiler',
 #     'cc_feat_cflags': {
 #       'name': ['feature cflags'],
 #       ...
@@ -97,7 +97,7 @@ foreach target, plan: tcg_tests
     endif
   endforeach
 
-  cc = plan['cc']
+  cc = find_program(plan['cc'], required : false)
   folder = plan['folder']
   gdb_arch = plan['gdb_arch']
   qemu = plan['qemu']
@@ -190,9 +190,12 @@ foreach target, plan: tcg_tests
       if 'cc_feat' in setup
         cc_feat = setup['cc_feat']
         if cc_feat not in cc_has_feat
-          cmd = run_command([cc, cc_check_args, cc_feat_cflags[cc_feat]],
-                            check: false)
-          avail = cmd.returncode() == 0
+          avail = false
+          if cc.found()
+            cmd = run_command([cc, cc_check_args, cc_feat_cflags[cc_feat]],
+                              check: false)
+            avail = cmd.returncode() == 0
+          endif
           cc_has_feat += {cc_feat: avail}
         endif
 
@@ -203,6 +206,11 @@ foreach target, plan: tcg_tests
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
2.47.3


