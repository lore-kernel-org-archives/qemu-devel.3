Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F4BAC43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 22:43:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgs1h-0005hw-Fm; Mon, 06 Jul 2026 18:42:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgs1g-0005hJ-E9
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:42:56 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgs1e-0000Cc-Og
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:42:56 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666KEM1Z1613914
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 22:42:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=buTQmP0Gx8b
 zOeVJYAv0xQRYhW/xnyS2bwJgmcWVGb8=; b=K2LgUt1dmhOTLdTrtOelvGwJT7h
 +2eGC2J0iv1dxntvmyTRdD9+oVQhXrWmFLU4yPYCWHZ50/baROCFLC3W7gJ2p6/q
 /z+i6RzkzjXXBY0qhSHJyTaWgWiQ3r29WxBHryJKnmRDex+WNzr0gUE5rvjpbl33
 CmeHGdaZO+ubXKMSEdy4l/us7bg9jOeedW//gIWN0kWBguAPfLC5BvtQW6b9lQ6p
 BkYoTKH5Avwk2AfZR3x0uK256VYgohAps8ZRc8IGZZoZ7IJdeYJpScFGcpNeo7E9
 bYNqzishNSkCC2GxiKzit2fqt9WpqjkjneyF8ka0ZHW7xM+zkZprRUJCFHQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88h53km7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 22:42:53 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c89704da8c7so5677515a12.0
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 15:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783377773; x=1783982573; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=buTQmP0Gx8bzOeVJYAv0xQRYhW/xnyS2bwJgmcWVGb8=;
 b=kpGDv6W3DXyO/0o8I3PBPqTFDP3nRhlTJWLmScZFrg0oaJ9BerVGWWSh+l+ylmL9pp
 ktXUwRy2kJHo27AeEjjynmECOTguUyF1x5AjQOtDG9e1ywL21qyeHe3G+NUoMfJWQc+c
 E+OoX8DGL4kIJ1Y3EjoByvlMY/W+KTnm/MsBsyc/HpxMX9mFjey4HpgtNyr3hq49TUIW
 SGwOBzxv6HuiHBIZTCstz6x4jcuoEJJoYdoCBRpf0GP5cCYKkij3Ha5uFwvdQrQX+Gqj
 2a596mTxk/VtFSj+pdIg6s3eDg7UQ07ZL3ZLbYf/T+j5BfrIWbIHl95D0W0lh/4nyNXq
 BWXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783377773; x=1783982573;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=buTQmP0Gx8bzOeVJYAv0xQRYhW/xnyS2bwJgmcWVGb8=;
 b=QgIg5Xeq3lN2owl3vy6EMOZsbJiOeRWfArU5jBQhWPtdAWdwtJv1EGsEs6tzzc/lbJ
 EuhZSczMJbPbosRhIz8e1t8ajaoNsJ9XTQRmzIAgxkYeXtJARFmfzEy2N6vPY1W71OrA
 RLGUbO/wC7NF52wcczNevy2ruVEC6f0BAgjzRDkNFClxINsKw5c5euzYK2vpmgDrmcZI
 ky0cvtuoa5n8whX2a6byk/d087lMdmaluP40n0yXsM9sz+BfKUpD4pbjPgIyUBY0uGTy
 rfsw1IIzr71KZqm5Jpxr7ZMTSch8pM0TkKAPiYix7+XMGdlsnVBS7vlOg4wgT493hg0l
 solg==
X-Gm-Message-State: AOJu0YzhR/9BaxsiYoCg1ZVPLZStYvHt0QV3P6ca6pNYDZvu56K9UqQb
 niVXZUDf1iliESZyocclGhajZ0SKJVuucCV1ggwmSBYhgVVslfnwFC7YP4zpojfzkdl/N428DEl
 Z7B1KrXw8E7pFEE54RiVAKNzqI7AzERUGUCT8rXx5OEgvnP5AmRsRpkotuB5vzPkzDg==
X-Gm-Gg: AfdE7ckehrCjvQvC3NZ08rx4cjPdFVQVoav8rlTvUdqAGUAK3HU/rY+egJxBThH/4Eq
 xDnc3RNVGBHqIQAGJgtSC3fEvJ+9RrD6JCngWnXEcLBYK0//rAZuZDjT+KnYf+l2XQ+5TELTmlq
 SOVu3QYHGo6hoEoz/clnzKMXITfYJmZ6Kpu2vri/AzlpT7sWXzRxBs7B9crh3/+qIC764wY/ccq
 RkU4+oTLHf4mufywGszNmu9CMzNKdPu+6Y3pSQg+xQRhSXbnP+8Au4tpOCpHwoSUdnWgtaKB2/f
 ruNeIHVk/2WZFSqny/dNnPZOfQ7rEYPl5B3TegTJELYp70fRNqsWygDXl135513MkqDAifRm1Au
 moqenq1aHvlV/6xq5XmK4hTz6zTSyft7DxnDBXHQ8EAfis9ZT0T3fABtCjlf6wbKJ5v4+uD2YE1
 qDVVLabA==
X-Received: by 2002:a05:6a21:7983:b0:3c0:9c19:6592 with SMTP id
 adf61e73a8af0-3c09c1968bcmr79470637.76.1783377772911; 
 Mon, 06 Jul 2026 15:42:52 -0700 (PDT)
X-Received: by 2002:a05:6a21:7983:b0:3c0:9c19:6592 with SMTP id
 adf61e73a8af0-3c09c1968bcmr79451637.76.1783377772518; 
 Mon, 06 Jul 2026 15:42:52 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659d8da9sm1439200c88.14.2026.07.06.15.42.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 15:42:52 -0700 (PDT)
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
Subject: [PATCH v3 85/91] tests/tcg/x86_64: user tests
Date: Mon,  6 Jul 2026 15:33:37 -0700
Message-ID: <20260706223343.988769-86-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: rsdBRvHIcka_8i4ce7Hj5b_Z1qbArVe0
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIyOCBTYWx0ZWRfX9MTNW+LR/JpS
 Ra8JOaSdhkgjrsiXbL/mCwtfEa73INa3qUaXsUpfrB/5GtJ3EgdE2oUp0pSIYK7Yqj99MxvF870
 HV23swWSBb9Pb9WnIbvFda92EFps3oc=
X-Authority-Analysis: v=2.4 cv=EPU2FVZC c=1 sm=1 tr=0 ts=6a4c2f6d cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=kT1Vju3ocbhJYfGA-V8A:9 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIyOCBTYWx0ZWRfX2PnYlA00BLkB
 X56HPEamOZ28NjLH5Bg3HWi/7ePO6Phuu1gfqx9LI1frGgxtjLTO6X1e8b5SCW7g6kzsVDb4GAw
 TZ/dUGAuaVApmLoYiA1uZq4uK592HtjUDlum87gtVagFIi8uqYvjt+5cq3wf87Ig0a4AfQsWBbI
 r5ZtnFGH03FYrTKF/71NsTktHSbw/WJMw6Qs4HZFu5U5zMp47i28fqhEC8NKTzCfmcM/TlAzHcq
 UtFNl457eaXq6y7uBni2gpAIu4ZTTupedsNs77/ceAUnncDjeGzaO+MT3eUpbM0yrVjnM0iwmY9
 2VxZpOS/F459LScN4RkhEvsZMZ5jpz1ziea2c8Gg22bcsY607/6hCGE/QH/BVuPuieG0JxxwhAI
 xT7fQy5Prxs/C8U6F26jju6+xbh9DzPUBKWe569pCMZW4fUZx88g/0jR9m0EoVHcjfMr4DbxRhQ
 l97L8Y05PHzquO1v4DA==
X-Proofpoint-ORIG-GUID: rsdBRvHIcka_8i4ce7Hj5b_Z1qbArVe0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 spamscore=0 adultscore=0 suspectscore=0 phishscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060228
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build        |  1 +
 tests/tcg/x86_64/meson.build | 81 ++++++++++++++++++++++++++++++++++++
 2 files changed, 82 insertions(+)
 create mode 100644 tests/tcg/x86_64/meson.build

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 59e71d82c99..8b3006ad4ad 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -152,6 +152,7 @@ subdir('ppc64le')
 subdir('riscv64')
 subdir('s390x')
 subdir('sh4')
+subdir('x86_64')
 
 image_targets = {}
 exe_targets = []
diff --git a/tests/tcg/x86_64/meson.build b/tests/tcg/x86_64/meson.build
new file mode 100644
index 00000000000..be4672b351e
--- /dev/null
+++ b/tests/tcg/x86_64/meson.build
@@ -0,0 +1,81 @@
+cc = 'x86_64-linux-gnu-gcc'
+cc_dockerfile = 'debian-amd64-cross'
+cc_docker_arch = ['x86_64']
+
+tests = []
+
+tests += tcg_tests['multiarch-linux-user']['tests']
+
+test_3dnow_h = custom_target('test_3dnow_h',
+                             command: [files('../i386/test-mmx.py'),
+                                       files('../i386/x86.csv'),
+                                       '@OUTPUT@',
+                                       '3DNOW'],
+                             output: 'test-3dnow.h')
+
+test_avx_h = custom_target('test_avx_h',
+                           command: [files('../i386/test-avx.py'),
+                                     files('../i386/x86.csv'),
+                                     '@OUTPUT@'],
+                           output: 'test-avx.h')
+
+test_mmx_h = custom_target('test_mmx_h',
+                           command: [files('../i386/test-mmx.py'),
+                                     files('../i386/x86.csv'),
+                                     '@OUTPUT@',
+                                     'MMX', 'SSE', 'SSE2', 'SSE3', 'SSSE3'],
+                           output: 'test-mmx.h')
+
+tests += {
+  '../i386/test-i386-ssse3.c': {},
+  '../i386/test-3dnow.c': {
+    'cflags': ['-I', meson.current_build_dir(),
+               '-masm=intel', '-O'],
+    'depends': [test_3dnow_h],
+  },
+  '../i386/test-avx.c': {
+    'cflags': ['-I', meson.current_build_dir(),
+               '-mavx', '-masm=intel', '-O'],
+    'depends': [test_avx_h],
+  },
+  '../i386/test-flags.c': {},
+  '../i386/test-mmx.c': {
+    'cflags': ['-I', meson.current_build_dir(),
+               '-masm=intel', '-O'],
+    'depends': [test_mmx_h],
+  },
+  '../i386/test-i386.c': {
+    'cflags': ['-lm', '-lc'],
+    'exe_name': 'test-x86_64'
+  },
+  '../i386/test-i386-adcox.c': {'cflags': ['-O2']},
+  '../i386/test-i386-bmi2.c': {'cflags': ['-O2', '-fwrapv']},
+}
+
+tests += {
+  'adox.c': {'cflags': ['-O2']},
+  'cmpxchg.c': {},
+  'cross-modifying-code.c': {
+    'cflags': ['-pthread', '-Wl,--no-warn-rwx-segments']
+  },
+  'fma.c': {},
+  'noexec.c': {},
+  'test-1648.c': {},
+  'test-2175.c': {},
+  'test-2413.c': {},
+  'vsyscall.c': {},
+}
+
+if 'qemu-x86_64' in emulators
+  tcg_tests += {
+    'x86_64-linux-user': {
+      'cc': cc,
+      'cc_dockerfile': cc_dockerfile,
+      'cc_docker_arch': cc_docker_arch,
+      'folder': 'x86_64',
+      'gdb_arch': 'x86_64',
+      'qemu': emulators['qemu-x86_64'],
+      'tests': tests,
+    }
+  }
+endif
-- 
2.47.3


