Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4C29CD8CA8
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 21:49:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wX4JK-00078F-RC; Tue, 09 Jun 2026 17:48:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wX4J7-0006pA-Vf
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 17:48:26 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wX4Iy-00085J-BC
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 17:48:19 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 659K4uiZ1642734
 for <qemu-devel@nongnu.org>; Tue, 9 Jun 2026 21:48:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=TwMTnYSHBtF
 8jxfmTzK4AAEVmJ+eki90A7FeMBV+J1o=; b=Zduai4Lr8iNYeCkYY21fe9BP1ZA
 /CIfiTtHwsuMPr6aV+h1AJxgkL3l16fQLWr5Bad31BQ+d84xuCGquPVSWVK5Rvuq
 lzIfJe5FhwVCCyPGcPHCxWs9FNuyp9udktgWL89GvRz7gG3Vls799VtAcxocVJl7
 po9jQk00kO+0h89Uymlj3xdRhkMsN/rzW2yaIFKiJPvu4MHrlgrHX8lfmsf/Tgsv
 TUElh3fsu14zBROK+Fjx52ZHS7RUsyX4C2slcjwkAR2hOdZ8mnLIDJskyP7w8KZs
 ZOaSWmFUrR7p8nkSFX58KOmsjkzdB3exKpu35AHHJ5I7URn9nkbYPDi88ng==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epf0suvtw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 21:48:04 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-1383678095cso2206113c88.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 14:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781041684; x=1781646484; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TwMTnYSHBtF8jxfmTzK4AAEVmJ+eki90A7FeMBV+J1o=;
 b=XsnmU4KkXjLFOrXX8a55PMYu6RaukW/JS81EBSGOOi0dmdNx5M6W4jMPnrOKTplurZ
 8D2V4y6UX6t3YREARVWL8d4hpvCNxd3sNY4oOU3SUwCu4qF7pF9DxcAvg6jXc7Th1vmk
 sN0h/0UKABr3aQTn5pJFGuAiHtmqpIwXQaD20JuOkqyLslLxlJ+RcbwNgnH6kZHkrrsn
 +S8sHCmfD3M4pA5VyQvhLCX/GJ5gfy/HzHnRW04AsV1KyWeTvPFRaxajbyHs17Suo16M
 btfhveEYbaL71IKehiOPZRcBLdqdFLA4qPIGTLDZKG/jGTaBuA8ZPB3XSM4DNZYQ00kN
 oYVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781041684; x=1781646484;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TwMTnYSHBtF8jxfmTzK4AAEVmJ+eki90A7FeMBV+J1o=;
 b=LpreY5NEP4/SXKmlwsivq/wPBG+eYkPc84ucXnzHhm5d/ETLLIipaacd6cPYtFHsL+
 aGjMASpsAFcOCk9Vf/ShgElwDO1nfJ5S7jjP2aJDPH2JV0k4J3P/rxZyHSL3Fox2qGqz
 g/ObaE0qPbM7Ghu4oA+vrn5gRH5/cECKsoT5HBX+Tc5F40JUOBhYC1Eea+qhCASt7sma
 XBX68uB2MiuzUgj2VDAlybRKs88nUhCGdR3PvEZQ3NntZcuE3e3YoolUPnrvq5qjat4K
 rIZco7RRjOBbpzukzhsazmQi3TQdsyT31W0x2Yrnf3eqMthCbnON9QX2MWWhjE41u+6f
 S8nA==
X-Gm-Message-State: AOJu0YzoSz1WatqCq3DFilf27BrVhazXBfhynu6KujxL4U/WR/CPAYBh
 MKlMxMMS+b0mWx2fl1g1WuB9Br8Rs9JijSDdU6YC+pW03qloVYCh4HNNfNwgmHveCBArJ/CPKPN
 ab25jwn7TC4ZRHlTWzxDWluj61mUClXM1+koX0dsbtUxgICpDD1c5vkRMYkFAbzC+KeAx
X-Gm-Gg: Acq92OE1bw39Tei7oV8LmuJYeyK+vgnfLN5N6OixB9M+PbJN0w6R4q5KUnAxou43HnP
 ggo300Y/ZLRfhcQDQttd0e+563HzE0h03ey4ggYox9MMWpgMryx8ZPnd3yJZRtBUom4CUeXpxQ3
 qbWOP9B6mt7pkjy0e0W0XmfMMXZEn0dXqCe6dpGkDoqLR85iDcqk6wKVN7UtGORwAIZKgsgELNI
 cvMz1+u+YgYQV7EHs80EMERkQ18crjSALS7IeBgCxuPqmuJhf6uEZkqo+Hgu+Y1QnJ7hdCSssUq
 VsoXAvXyz3zPIi19EZVRu1W3rhaqVg3s4gT3n0dqg2JmJiGpSsOKLuY2zxZpAlSbOE8hhYbT77w
 Zx1qUsOcomqV83o9xhf92yPy1uzJHI8VqB5uZXviGd+qNJ+Ak64r8DwxN47rt56hymlM8Iq3R0D
 covveVgMCg4oC128yh
X-Received: by 2002:a05:7022:1005:b0:135:d749:5761 with SMTP id
 a92af1059eb24-1380666a3cfmr11462851c88.8.1781041684235; 
 Tue, 09 Jun 2026 14:48:04 -0700 (PDT)
X-Received: by 2002:a05:7022:1005:b0:135:d749:5761 with SMTP id
 a92af1059eb24-1380666a3cfmr11462819c88.8.1781041683693; 
 Tue, 09 Jun 2026 14:48:03 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-137f5550bcdsm17095895c88.14.2026.06.09.14.48.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 14:48:02 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>
Subject: [PATCH 11/27] tests/tcg/meson.build: introduce plugin_test
Date: Tue,  9 Jun 2026 14:47:29 -0700
Message-ID: <20260609214745.772536-12-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260609214745.772536-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260609214745.772536-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDIwNSBTYWx0ZWRfX+1MV5G3OM95D
 32fkalc4i0QucIhy83cqNvbD+G0E0S4hGxIzrYAPk9fKxzEbnnu7zr36opBFhILJybPjmu50zqe
 kMiQDITzQFNXSn1hfbVxxNwdWRHXJFVEa7nAsp4sXkO4fLfIBx2Qlne5bKtEsOYHXu1Y6IMWVea
 Br2jTJpkOIz6AYNYNJSGz9jLX9PAU55GzyXWWr+mlfRtq7OaF0MvGY8sA+9VmdSOCoDDjfQ1ZJJ
 nlZcQO+65OVpK8IlPeA7NHN7zeRLD2Y7+WqptDS0CaKRkg2veFFuk3+xJmSRg4TySKX4/Y4abon
 3BOD1s9zmj2nB0w+jiu/mJVHcX53IbJU3l2Hjo7822CWwefSh9vAb8RRH9HEOvwTeLh0xVbyf/Z
 B3hvGxxJbrgNSQ5aKk/E2SFdHNsGq0cmm5gzHzzjf0oONxH1e1vgSZjZxMpWd2yLMm633FkGQCv
 bM2jRDGcDnmaFWSaqfQ==
X-Proofpoint-ORIG-GUID: KLqmspU0Zj_M1Sj9MScHR0VCc6fMGvq4
X-Proofpoint-GUID: KLqmspU0Zj_M1Sj9MScHR0VCc6fMGvq4
X-Authority-Analysis: v=2.4 cv=GeonWwXL c=1 sm=1 tr=0 ts=6a288a14 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=IApxms6bzuiUID3tdqAA:9 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_04,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 malwarescore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606090205
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

We add possibility to declare a test that is based on a plugin.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 40 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 5cd80f3c030..a47f1ada779 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -16,6 +16,10 @@ tcg_tests = {}
 #           'cflags': ['cflags to compile test', ...],
 #           'qemu_args': ['qemu command line flags', ...],
 #           'env_var': ['VAR=value', ...],
+#           'plugin_test': {
+#             'plugin': 'plugin_name',
+#             'args': ['plugin_args', ...],
+#           },
 #         }
 #       },
 #       ...
@@ -57,12 +61,25 @@ foreach target, plan: tcg_tests
       # return a clear error if user mispell a setup entry
       foreach key, _ : setup
         if key not in ['cflags', 'qemu_args',
-                       'exe_name', 'test_name', 'env_var',
+                       'exe_name', 'test_name', 'env_var', 'plugin_test',
                        ]
           error('unknown tcg setup entry \'' + key + '\' for test ' + src)
         endif
       endforeach
 
+      # return a clear error if user mispell a plugin entry
+      if 'plugin_test' in setup
+        foreach key, _ : setup['plugin_test']
+          if key not in ['plugin', 'args']
+            error('unknown tcg plugin entry \'' + key + '\' for test ' + src)
+          endif
+        endforeach
+      endif
+
+      if 'plugin_test' in setup and not get_option('plugins')
+        continue
+      endif
+
       # meson '/' operator drops left operand if right is an absolute path
       src = folder / src
       file = files(src)
@@ -76,6 +93,12 @@ foreach target, plan: tcg_tests
       if 'test_name' in setup
         test_name = setup['test_name']
       endif
+      if 'plugin_test' in setup
+        # remove lib prefix
+        plugin = test_plugins[setup['plugin_test']['plugin']]
+        plugin_name = fs.stem(plugin).substring(3)
+        test_name = 'plugin-' + plugin_name + '-with-' + test_name
+      endif
 
       exe_name = target + '-' + exe_name
       test_name = target + '-' + test_name
@@ -116,6 +139,21 @@ foreach target, plan: tcg_tests
         qemu_args = setup['qemu_args']
       endif
 
+      if 'plugin_test' in setup
+        plugin_setup = setup['plugin_test']
+        plugin = test_plugins[plugin_setup['plugin']]
+        plugin_args = []
+        if 'args' in plugin_setup
+          # add empty arg to generate an additional comma
+          plugin_args = ['', plugin_setup['args']]
+        endif
+        plugin_args = ','.join(plugin_args)
+
+        # since we turn plugin into a string, add dependency explicitly
+        depends += plugin
+        qemu_args = ['-plugin', plugin.full_path() + plugin_args, qemu_args]
+      endif
+
       exe = built_tests[exe_name]
       cmd = [qemu, qemu_args, exe]
 
-- 
2.43.0


