Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9165BC43327
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 23:42:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wdG9Z-0003jI-8d; Fri, 26 Jun 2026 19:40:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wdG9X-0003du-5g
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 19:40:07 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wdG9V-00044w-1b
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 19:40:06 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65QMxYCr2793913
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 23:39:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=7xKKV4cvOHW
 FhO7zahyrrglP7tI70XTwqgQnaYZuO/w=; b=lQbIIqQ7WOfAdywUuHslkVQVzoH
 +2dCjx10fHTH2JsK40bJLsFG8Xn5gi3ih0rMEZqIN8ZbWlWUqaA41v8glD3giguL
 oFmWoAjK4aVLghNnMSCJCVWoWgTEHHv75ZZdNpuPr3hwUY9nn/nHutEWdsdUe9Nu
 HDQth0XH4JXR+xe+tkEhV6B17SG8gYOeHIdsy1BBo0dgrTyuf6zaV8UD9pxXg2rc
 hMVBXFmeSTJcuVqkBAc995GrEIVz8c6yhm2uQSPHYKxrGCans5w4jM1SgOljrXuC
 XiHNe38+G55K8aPTVGgz4qH32oKQOz0/T389uHaPJUUMnhNeTE3H1ht17Pg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f1tc3hyuj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 23:39:54 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-30c95b0e22aso4417548eec.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 16:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782517193; x=1783121993; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7xKKV4cvOHWFhO7zahyrrglP7tI70XTwqgQnaYZuO/w=;
 b=emh3BiKCTdNolfocRCqyHuPZ0QoSQfht+ttVwhC4e94SYGCxHlOsP6+Maod5J9/FW6
 P/AgrLwS5VgMpEpTrJOUtJKrBVsLFs7V2UT4VtfluPIZ/lS1IfA/EmzKc91bf5pBejXh
 x+qKhUwYkEsU+xSsLCHCuv0V0kcBi7R63ymCefowyykpSG8Y5Q+Xy8kA3Iqj8DMblMJA
 oVdGqJCD4EIpLX5BRrpgzteZliJpki1m1Rgkv3rCHYjXMUVglgNv3PwinTOuVITce4O/
 fNP7Aynlx3pe2kJEQSDfxiu8idc4Rn6qxKZzJI9Jy2ARqHRDNt6xPuwpPwrQLPstQcYc
 YA3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782517193; x=1783121993;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7xKKV4cvOHWFhO7zahyrrglP7tI70XTwqgQnaYZuO/w=;
 b=hW3kfBp1sqwmN1guYeYFhpKrUZU11fcvE58oCOrYU2j55Q0THkrLo7RCfPLXk0Y370
 1BKFnWVWhaGNB/49/s9syDgmAfYOm74WYR4xyr1X7QmUEZ46UiZ86qDLIsl8YgA9Ehss
 PVwkWRa9YEvvZlziVGCGiC88182XtKZYX1JHKL+4TWuL398lKYd2MKcLtHNZAUK0+OhV
 dmXyzwD66hKbmZqWxqZ0wMmC3to5VSI9jZo8RDaIBXhQj1ZUiwAn3JV80TCjW19+ASHf
 vjxQD2taepz3k4Tsl1raHco8pwBBQeWVO52iSFHL8F6RsHfarUfH3lRYbxm+REf8ADmw
 1nAA==
X-Gm-Message-State: AOJu0YyEVkvlXSaQgn3egUjjAfu+qgwRXBxtWlIWnEAMF7LZg7VfmNjU
 /0L5ZLTfruNVfPLhxGGhkzv/YKdrib3j2MBYA3Y35XRP9jSub5lbmWPqWZK+d7pAZncJZQICugs
 JzmauFSyRLK2kCbWuQW9eQzhAwR7ZnkwGZPe3uWskNuqnGRH9jBCYVD9XJxS9GXSFFw==
X-Gm-Gg: AfdE7cl5kWefVQueZrU416RrUFtR+e+w4lZQZUfNLyhCkhoYALJBpFuwng5Arw/c5U+
 xAhLzeViHHfetMOW2lxbVBtmu26jk2e1qLeioz6FM2d+VvjHFX6I9S9h9zIyDrTEYXYUJlaf3DY
 NiL6kHn3BaxTZx+mX4RfFWOEn6IW4ZJEipUwOKAikd/+gpLtkNrx+D+zZcyb2tDVSyaGamANIKu
 zYj1y/dWWqR6nir2EK83RoqMiU2lOfNNFA2+09VkGww1phEjYyekihP6a0Z7VGO3FhgYHgWMq8o
 5/F/OTydrlFun8g1uKpjV9z7vZQMkk0cCkMcuRSMGDCiEOD4fT5OFmlPSYITv8jFck+AeBcD7KJ
 KcO+s77KHk6ctOB+h6GuIOv/0EOO45j8B0Ikm8mkoiY6WwiUirATUYbznoGFX2IqnTj9Qwp4tw3
 rPaaBRLw==
X-Received: by 2002:a05:7300:7241:b0:30b:9e57:1e6b with SMTP id
 5a478bee46e88-30c84dad34amr9702444eec.17.1782517193062; 
 Fri, 26 Jun 2026 16:39:53 -0700 (PDT)
X-Received: by 2002:a05:7300:7241:b0:30b:9e57:1e6b with SMTP id
 5a478bee46e88-30c84dad34amr9702410eec.17.1782517192555; 
 Fri, 26 Jun 2026 16:39:52 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c52c591sm29369756eec.7.2026.06.26.16.39.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 16:39:52 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH v2 21/37] tests/tcg/aarch64: add user tests
Date: Fri, 26 Jun 2026 16:39:02 -0700
Message-ID: <20260626233918.158740-22-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260626233918.158740-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260626233918.158740-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: LbG9azZwNafq-suMp9nyxf3_9OrpBNSd
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI2MDE5NyBTYWx0ZWRfX8a+OSYbYuz2x
 2HtwxYKfYQ/7zz3NC86ZmDm0veiKT4zaTwbhzzKjGaNRr+dUI8wKLv5ceww6wcVrNZ6vhybe4lu
 upySMXCWBCIAWoEeO4JtQ0AQH7AcqHo=
X-Proofpoint-ORIG-GUID: LbG9azZwNafq-suMp9nyxf3_9OrpBNSd
X-Authority-Analysis: v=2.4 cv=T4m8ifKQ c=1 sm=1 tr=0 ts=6a3f0dca cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=Se0jXKEZ9Br8DtPn3R0A:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI2MDE5NyBTYWx0ZWRfX3wGigJgdwQB3
 3JR6nyFubiYKPt/gE+TJsk+wbxzYQ6Hn4Pk00hIDctZZE4MgXJhMQ61hrDaDZnOs8WqcEGaFNUj
 +iiScKAb8t57qoMPHcUHmnB/mXidmY+pSxyecZHrnriH5nbvtot/wtMDo6A99VesKoo/Yk6ycB7
 M+/rF/u04Cm3I6kJ3B1vwyU0AJcFx65MVjNym4WBguZUIpTE2AwE/Sw7Vaky9yQhm9r5g8NZG6E
 xkfADb0yi1wbrnm1nle9CS1S7IvJ5pzD/BlKbBsi3avgP7dboCJCtsKbkWqqpkJTOR37TH2XTRJ
 cdunVBmaAfoqbV6EKh4kR7peRIAFcbqFJ5DNIrBhnPdjTcBsBBbntLV1CkR1xe9/nDg1+V8651C
 BEOoDZZq+op4sFaEcBdPWp409VD6y6IXTIqiIuJKSP52HpIhW5QiZpaoTLm8xrYWNmRXpCcTFKf
 MTwR32B/RyBGBEZgeUQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-26_06,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606260197
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

We are finally ready to add tests. Let's start with aarch64 user first.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/aarch64/meson.build | 213 ++++++++++++++++++++++++++++++++++
 tests/tcg/meson.build         |   3 +
 2 files changed, 216 insertions(+)
 create mode 100644 tests/tcg/aarch64/meson.build

diff --git a/tests/tcg/aarch64/meson.build b/tests/tcg/aarch64/meson.build
new file mode 100644
index 00000000000..9c42b129551
--- /dev/null
+++ b/tests/tcg/aarch64/meson.build
@@ -0,0 +1,213 @@
+cc = find_program('aarch64-linux-gnu-gcc', required : false)
+
+if not cc.found()
+  subdir_done()
+endif
+
+feat_cflags = {
+  'aes': '-march=armv8-a+aes',
+  'sve': '-march=armv8.1-a+sve',
+  'sve2': '-march=armv8.1-a+sve2',
+  'v8.2': '-march=armv8.2-a',
+  'v8.3': '-march=armv8.3-a',
+  'v8.5': '-march=armv8.5-a',
+  'bti':  '-mbranch-protection=standard',
+  'mte':  '-march=armv8.5-a+memtag',
+  'sme':  '-Wa,-march=armv9-a+sme',
+}
+cc_has_feat = {}
+
+foreach feat, flags : feat_cflags
+  cmd = run_command([cc, cc_check_args, flags], check: false)
+  avail = cmd.returncode() == 0
+  cc_has_feat += {feat: avail}
+  if not avail
+    warning('aarch64 tcg tests for feature \'' + feat + '\' ' +
+            'disabled: unsupported by cross-compiler')
+  endif
+endforeach
+
+gdb_feat_version = {
+  'sme-tiles': '14.1',
+  'mte': '15.1',
+  'mte-baremetal': '16.0',
+}
+gdb_has_feat = {}
+
+foreach feat, min_ver : gdb_feat_version
+  avail = gdb_version.version_compare('>=' + min_ver)
+  gdb_has_feat += {feat: avail}
+  if not avail
+    warning('aarch64 gdb tests for feature \'' + feat + '\' ' +
+            'disabled: unsupported by gdb')
+  endif
+endforeach
+
+if 'qemu-aarch64' not in emulators
+  subdir_done()
+endif
+
+tests = []
+
+# Base architecture tests
+tests += {
+  '../arm/fcvt.c': {'cflags': '-lm', 'expected_output': 'fcvt.ref'},
+  'pcalign-a64.c': {},
+  'lse2-fault.c': {},
+  'test-2248.c': {},
+  'test-2150.c': {},
+}
+
+if cc_has_feat['v8.2']
+  tests += {'dcpop.c': {'cflags': feat_cflags['v8.2']}}
+endif
+
+if cc_has_feat['v8.5']
+  tests += {'dcpodp.c': {'cflags': feat_cflags['v8.5']}}
+endif
+
+# Pauth Tests
+if cc_has_feat['v8.3']
+  f = feat_cflags['v8.3']
+  cpu_max = ['-cpu', 'max']
+  cpu_neoverse = ['-cpu', 'neoverse-v1']
+  tests += {
+    'test-2375.c': {'cflags': f},
+    'pauth-1.c': {'cflags': f, 'qemu_args': cpu_max},
+    'pauth-2.c': {'cflags': f, 'qemu_args': cpu_max},
+    # Choose a cpu with FEAT_Pauth but without FEAT_FPAC for pauth-[45].
+    'pauth-4.c': {'cflags': f, 'qemu_args': cpu_neoverse},
+    'pauth-5.c': {'cflags': f, 'qemu_args': cpu_neoverse},
+  }
+endif
+
+# BTI Tests
+# bti-1 tests the elf notes, so we require special compiler support.
+if cc_has_feat['bti']
+  f = [feat_cflags['bti'], '-fno-stack-protector', '-nostdlib']
+  tests += {
+    'bti-1.c': {'cflags': f},
+    'bti-3.c': {'cflags': f},
+  }
+endif
+# bti-2 tests PROT_BTI, so no special compiler support required.
+tests += {'bti-2.c': {}}
+
+# MTE Tests
+if cc_has_feat['mte']
+  f = feat_cflags['mte']
+  tests += {
+    'mte-1.c': {'cflags': f},
+    'mte-2.c': {'cflags': f},
+    'mte-3.c': {'cflags': f},
+    'mte-4.c': {'cflags': f},
+    'mte-5.c': {'cflags': f},
+    'mte-6.c': {'cflags': f},
+    'mte-7.c': {'cflags': f},
+    'mte-8.c': {'cflags': f},
+  }
+endif
+
+# SME Tests
+if cc_has_feat['sme']
+  f = feat_cflags['sme']
+  tests += {
+    'sme-outprod1.c': {'cflags': f},
+    'sme-smopa-1.c': {'cflags': f},
+    'sme-smopa-2.c': {'cflags': f},
+    'sme-fmopa-1.c': {'cflags': f},
+    'sme-fmopa-2.c': {'cflags': f},
+    'sme-fmopa-3.c': {'cflags': f},
+  }
+endif
+
+# GCS Tests
+tests += {
+  'gcsstr.c': {},
+  'gcspushm.c': {},
+  'gcsss.c': {},
+}
+
+# System Registers Tests
+tests += {'sysregs.c': {}}
+
+# Crypto Tests
+tests += {'test-aes.c': {'cflags': feat_cflags['aes']}}
+
+# SVE Tests
+if cc_has_feat['sve']
+  f = feat_cflags['sve']
+  tests += {
+    'sve-ioctls.c': {'cflags': f},
+    'sve-str.c': {'cflags': [f, '-O1']},
+  }
+endif
+
+# SVE2 Tests
+if cc_has_feat['sve2']
+  tests += {'test-826.c': {'cflags': feat_cflags['sve2']}}
+endif
+
+# GDB Tests
+if cc_has_feat['sve']
+  f = feat_cflags['sve']
+  tests += {
+    'sysregs.c': {
+      'exe_name': 'sysregs-sve',
+      'cflags': f,
+      'gdb_test': ['--test', files('gdbstub/test-sve.py')],
+    },
+    'sve-ioctls.c': {
+      'gdb_test': ['--test', files('gdbstub/test-sve-ioctl.py')],
+    },
+  }
+endif
+
+if cc_has_feat['sme']
+  f = feat_cflags['sme']
+  sysregs_sme = 'sysregs-sme'
+  tests += {
+    'sysregs.c': {
+      'exe_name': sysregs_sme,
+      'cflags': f,
+      'gdb_test': ['--test', files('gdbstub/test-sme.py'), '--',
+                   'test_sme', '--gdb_basic_za_test'],
+    }
+  }
+  if gdb_has_feat['sme-tiles']
+    tests += {
+      'sysregs.c': {
+        'test_name': 'sysregs-sme-tile-slice',
+        'exe_name': sysregs_sme,
+        'gdb_test': ['--test', files('gdbstub/test-sme.py'), '--',
+                     'test_sme', '--gdb_tile_slice_test'],
+      }
+    }
+  endif
+  tests += {
+    'sysregs.c': {
+      'test_name': 'sysregs-sme2',
+      'exe_name': sysregs_sme,
+      'gdb_test': ['--test', files('gdbstub/test-sme2.py')],
+    }
+  }
+endif
+
+if cc_has_feat['mte'] and gdb_has_feat['mte']
+  f = feat_cflags['mte']
+  tests += {
+    'mte-8.c': {
+      'gdb_test': ['--test', files('gdbstub/test-mte.py'), '--', '--mode=user'],
+    }
+  }
+endif
+
+tcg_tests += {
+  'aarch64-linux-user': {
+    'cc': cc,
+    'folder': 'aarch64',
+    'gdb_arch': 'aarch64',
+    'qemu': emulators['qemu-aarch64'],
+    'tests': tests,
+  }
+}
diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index fbccf72f686..0036203a311 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -69,6 +69,9 @@ endif
 test_plugins = {}
 subdir('plugins')
 
+# Now let's go through all architectures
+subdir('aarch64')
+
 # Finally, we can create all test executables and test targets
 foreach target, plan: tcg_tests
   # Detect duplicated executables/tests, and report an error to force user to
-- 
2.47.3


