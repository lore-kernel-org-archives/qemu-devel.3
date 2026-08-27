Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2924CC61DC4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:16:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziNY-0004vi-8o; Thu, 27 Aug 2026 18:15:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziNW-0004ug-Cy
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:15:22 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziNU-000615-M1
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:15:22 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJLd4M1358492
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:15:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7AMl0GUi9+fOtvTKd5eaYWLQivSCE64ZfxEcdg32zeo=; b=WqAEFDQD8cQqcYnm
 WVwpKUQcIdEI8+vl8Dh2Cc+SB1gcjWKg7LD9lI+eS7Tg48fyxnek/jK64jPJWWCR
 OrUsEC71fOiYs19qFSw024zyGIcu1n8M0IGRr+J8vUNhdtQeyhHG1SrEdOMvm67T
 94Bje09M0F4gGkoTNlf/0PcNvdWhefWzEqfKXBAqJhLGCXA0yQ8lu7FyECw8f630
 A2lklTY0AQff6LdJAW9IIPs70NvwDLxxAWbiixvENTbl8FiDe1m9LtKmh3VpKs1P
 Ef9YKEtd+VTSzsJ7ieW2gAxucLIW4Py/8D5ZLl40dRRrYYYwXlBUSjp6r+KMjEhL
 L8ex+A==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gapgva9sm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:15:19 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2cfc52ddc55so5451885ad.3
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787868919; x=1788473719; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7AMl0GUi9+fOtvTKd5eaYWLQivSCE64ZfxEcdg32zeo=;
 b=WewCV13oaLcYPI+d/yQSNDgctdTLGvZQBtqkHx5ZarnUtiYu1TjUXYRYIB4WT4jOSY
 nVO7rHJa2BRMOmBahPeQQsonqQAE0gkaH5EGQtUNwUF3uN61Xgdo68Hn+vUmQhuiNVci
 Yylldbru/oOgGmKfDY4xfEw0S/6omrRXHbxmuB1WiTz6sZV3OX0f1d5ca+sloFj32eRp
 U4AcSTc6fSRxk8CTy77piULbPlzs230L3D9+hAhInOEeg7OAiTxYtKb2m+zbzIjYjEef
 O9T5tp5M4FWNuQ/C4uIlpEFBmO11YfoYfKAwR8+Zhk/QwuUQkW0CREDmqgkxaf+4k8hb
 q05g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787868919; x=1788473719;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7AMl0GUi9+fOtvTKd5eaYWLQivSCE64ZfxEcdg32zeo=;
 b=M3U4zadeY2bPD63rJ+F4TT3OpQLqDijL1/5lRdpedws0BOMQtA1v/FdNZJXWBvIj69
 LvUzY1N3YYzQihaMWyOaYWBYJs3Y4RpNiyh9T4PnKhqdisZ+HW/N7SMA+mSsMjV1ZtsU
 88ODFb7FgAAf8rWn5UWgfD7tI+RpNnn/hTdP+MgPp/RHukkwcOF/F6G7uTRpvKXaf/kK
 C0pafiFW46kk/HrcSTgDUT0TuWBHJ5pId+gUGXw9nlu/BGgauHmTHZuukGNp488+RSHX
 1nymUDiZ1GFjT83mlIFrTzpLYVS/NrVOGc5GZEaqCSuVpM+aAepnXBmj/D/2Chi+NR89
 mPHw==
X-Gm-Message-State: AFuF++mE8bGvmT6K2xOQTrvoTWKrWXmInt0tpiTz3CpCsDqBC+870YKe
 sW7mAO1APZb8SRuisqONlxrRJvXZZmSoOLaGxdr/BG+hgLIDzSATCCkXVb4zXfA/msEu4wRefV+
 jABXh2EG2t0O6Wfh8B7T0z/8KfJiqA6caFukJl2JbeHjNqEi6TOPbuAvnoNhBz4npHg==
X-Gm-Gg: AR+sD13zU6/MpLo4hP1xZxRN5zSO5g8ljlIF5VsJMHmv6ST9hpYUy4JsK1AlnjKiq8o
 meljeN3l6KgQLffI2p05uRaxbeOGI22n52R76pPJH0/Ng0TA7qTfkq5ysFfrofzbcDXDgzkrlRo
 9MmQe4wBTWwD7TBI24mSuf7wr0xsYJseuHRwWqJOKBQho4zBWvuwTFiKdBAJTt2MecuifWy4XzO
 wDXlW8cIfv0BllyCYlb9BUla302yhTMP3n9nLAL1UD4M6I10Pg5tBk7NmZv/bXnnU4UBo630wOW
 4xYRVTqw3AF41gHwIYgf2WROYyHa4IZ0UeJrWdpYvjbgfWnXvWRg1DA3Fl1ftjJvlQtIR15JKUV
 qnbQePWPk/+1L7zCxjjd4u9Xi82vZnExq8wRuk8AqC4jrNaWSgN60ma4Ad04=
X-Received: by 2002:a05:6a00:6c9d:b0:845:c694:5c3d with SMTP id
 d2e1a72fcca58-856297300c3mr4818793b3a.1.1787868918384; 
 Thu, 27 Aug 2026 15:15:18 -0700 (PDT)
X-Received: by 2002:a05:6a00:6c9d:b0:845:c694:5c3d with SMTP id
 d2e1a72fcca58-856297300c3mr4818683b3a.1.1787868917917; 
 Thu, 27 Aug 2026 15:15:17 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8535cf4b213sm2524104b3a.55.2026.08.27.15.15.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:15:17 -0700 (PDT)
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
Subject: [PATCH v8 008/105] tests/tcg/meson.build: introduce cflags
Date: Thu, 27 Aug 2026 22:13:29 +0000
Message-ID: <20260827221506.91574-9-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 0TeMhybvDy2gIirriKIPxwzVb9zJ1-lE
X-Proofpoint-GUID: 0TeMhybvDy2gIirriKIPxwzVb9zJ1-lE
X-Authority-Analysis: v=2.4 cv=FpU1OWrq c=1 sm=1 tr=0 ts=6a90b6f7 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=EUspDBNiAAAA:8 a=_Ry-N6Gx1nrijpWpWVgA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfX8vp7t2ymqBfs
 GfH5QSC842VUNwqw+9Mj8QE6ake+IJEWJokLsjgu/6MPS+TmqCv6PBCowEaPprmAk746xLRM475
 yvqNOiZpp0pnrO7eqyOs6cX04DPLPZLYu4HMTCPRbSvK2ugrzStf4AIpUm5HmA/Wbr1G3MO5JMo
 uGp7YT3VBcbrLwax/En7ZQPKsMSm8SUW0wvULzw/Xos6dQnWMgthMkD2miyhUJzxmSFAseiVEp5
 KzH1t1W8ulN105lD+MY3HcJR6rRFAk15wgzJfRj1klH3Q6eBdVRxL6R7fTFEwX5KwHNKGTxcbEx
 /eCN7frEuqPus6XzZLsHGXJpX0peQNKiIEs4bFq3DwC1X58FwcQ1Ftsct3U0RmcNmcJMH2TANdb
 481rjTQSunLeBikRoFxwdGxuxCGquV+QtSfEHRjifA024nozi6aPI2RFDY6hISZB0piPustnKQG
 BCSTTMXH5stc3TsHaTA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfX2ESet5rW7bfr
 v2g10yBlwSAKk5fjHmAI6Y8KI0oAPbZo6UpTuwLAsZ6apyotfYVBrpgsab0vj4PG7CH/EhYWP9+
 3ZVsdkL6VMYNBFWAHkx/IxvfA1grow0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_08,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 suspectscore=0 impostorscore=0 phishscore=0
 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
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

We add possibility to declare cflags for a given test. Since we want to
preserve the uniqueness of test binaries, we prevent repeating those
cflags later, for an existing binary.

This ensures one executable == one set of cflags, and if dev needs
duplication, they can use a custom 'exe_name' to override this.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index ae7ec998f63..e8d8cfbcf88 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -13,6 +13,7 @@ tcg_tests = {}
 #         'src_file': {
 #           'exe_name': ['provide an alternative binary name'],
 #           'test_name': ['provide an alternative test name'],
+#           'cflags': ['additional cflags to compile test', ...],
 #         }
 #       },
 #       ...
@@ -20,7 +21,8 @@ tcg_tests = {}
 #   }
 # }
 #
-# Every test executable, identified by 'exe_name' is built only once.
+# Every test executable, identified by 'exe_name' is built only once, and we
+# ensure cflags are specified only once, on first declaration.
 # Tests for a given src use the same executable by default, and their definition
 # is guaranteed to be unique also. Several tests for the same executable can
 # declared using 'test_name'.
@@ -54,7 +56,7 @@ foreach target, plan: tcg_tests
     foreach src, setup: t
       # return a clear error if user misspell a setup entry
       foreach key, _ : setup
-        allowed = ['exe_name', 'test_name']
+        allowed = ['exe_name', 'cflags', 'test_name']
         if key not in allowed
           error('unknown tcg setup entry \'' + key + '\' for test ' + src +
                 ' (possible: [' + ', '.join(allowed) + '])')
@@ -82,6 +84,15 @@ foreach target, plan: tcg_tests
               'specify a different \'test_name\'')
       endif
 
+      cflags = []
+      if 'cflags' in setup
+        if exe_name in built_tests
+          error('test ' + exe_name + ' was already built with cflags: ' +
+                'remove cflags or set \'exe_name\' (if cflags are different)')
+        endif
+        cflags = setup['cflags']
+      endif
+
       # build executable if needed
       if exe_name not in built_tests
         exe = custom_target(exe_name,
@@ -91,7 +102,7 @@ foreach target, plan: tcg_tests
                                       '-MMD', '-MF', '@DEPFILE@',
                                       '-Wall', '-Werror',
                                       '-O0', '-g', '-fno-strict-aliasing',
-                                      ],
+                                      cflags],
                             depfile: exe_name + '.d',
                             output: exe_name + '.test',
                             build_by_default: false)
-- 
2.43.0


