Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C370CD8CAD
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 21:50:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wX4JN-0007DR-4k; Tue, 09 Jun 2026 17:48:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wX4JE-0006z9-Qg
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 17:48:33 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wX4JA-0008Dh-B5
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 17:48:32 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 659K4rBf1642657
 for <qemu-devel@nongnu.org>; Tue, 9 Jun 2026 21:48:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=PRRsbtYUWSI
 VnRDbhujmZtMrle3ERU+uNwL8ZWi14jo=; b=hnmHA7awtdqis2e3XnmTVUMFqXC
 KBdfvkqeM5uhg3JffQp23J/DAtsTVzK6kY8cqhSb/4nWHUg3y1Kx03AdrlM63sIl
 2KLdSx+rbbH6BZfGcp7Q+cR0qjGnexCX713B890ZiCs8bGvsq74U6Twd5TQs/Oxm
 BtEuT6mdc1/XMUCJA3/7sEpaseFs9WpL//2uWGBaZIvQtLUXQ41CJIXK3U2iuJhu
 kcSr5KjXXxgJ8HLfUwAQBQ8khQhPoTzCfCl33DwY6+o7l8gAJQHrexfROZE9Kl8U
 VDQadZXU4P4jw0IE/FIP1ZlFttr1Ghy2ovmK574RQYsPq5RchJs0xGgDOCA==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epf0suvv7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 21:48:15 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-138155294c4so37367c88.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 14:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781041695; x=1781646495; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PRRsbtYUWSIVnRDbhujmZtMrle3ERU+uNwL8ZWi14jo=;
 b=dzZUf0F4/Glrv/eIb7lkWxOZe9vTMP6Fs0GcwTy9bNfZ+igL3TX2sJk0hfk9JretfC
 GHZhfPkzMAnw+NLq75aWKTVJIkwPRZcdut4MwZZ1Cevne6cilp9RnI+11c8emmfSNpNX
 ZBSbz3zfA/pZejpSGsQrb5UT4NJl69JRu7xLrUpRrd1v2vraM9YlhwAUaAlZmlhmkjEB
 nKRNAWL94csMClyGRzkkpqS42ANjgyZvKWZKeWzUWdThGRKSrV0ySm0tMko82q9KuVQ0
 iyjTUju/0GD+XUW/W4eToRIxRmo0ssAPKlaO9xQgQRy1UEfgK8MmfKNUW1IoyoB6s95f
 fMkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781041695; x=1781646495;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PRRsbtYUWSIVnRDbhujmZtMrle3ERU+uNwL8ZWi14jo=;
 b=oJDFb6ApLe2M4l6FvxW0CETPk5TMkIX3yUq0QsyeF0j5cCy2CUO7lbC91ZVlwaa0SD
 0iVF+Ejk+7uDQ24mtlV43j0LY9GOBXyOnkCkgKRsDGBtTajh9gvOj9aw/Ftm7MtAjUVO
 PONjWDNYOTNf5ezRyGH+Nmc8Kj1tK2MblRRrbmE5zMhT4xtqbe+VMPr3oKMT8IuX30vq
 VKmFWcwOppFfMhvnP/tuq1LQcBnNhVu1oHV3EUcqDK4HDhE5uL8TiwCBHcnsg1Rc4lpY
 RQ6NPKauDuLHpDAFkTPHq90qNKWJ1SnKIC6zYL/LDp9t0HdedFXeR5HXBIBXS46cUNxY
 uPSg==
X-Gm-Message-State: AOJu0YyxvHpgkOVaXi1ww6WeCsTWg6SZUg7D0eQ1BPoGXmT6TPolzZ+n
 +GH25IGYbmP7zuuwYGZ+u8JV0mNYO9/i1gBMWHf4dyH5lvZuK4TObAUW8LrU4O/5veHcVGQtB/D
 bapdwqLwhe2/T/9xVgqS743E1/1YAgSMScklYtzvrTtb7ax1y1qbKXBT15gaA0XAar9fl
X-Gm-Gg: Acq92OG3/vBQzNvy5AMzM9wd7miWX63TGZMfvfmbiw9V5cerH0e5CR8pw50rBx9vjL7
 NOFDY1rcIkvfrF+bQ2Pk2NHDgWhsIPfFv6d8d8OLaudKqBj0N3PppDv+TYX8CXuwhCUonxwgbwz
 5o1edIxaupkJlUHABiD2ive/E27rOIXJawMg1FYsfbSePa24tiBncBlWtmZxXD7J+YGe0rO6Qzs
 D/eJvjbPU6znzJFNYd87zsfKQLSlsYZzHGlQ1VzPwalsHrqhFNpCrlpcwRCsJlwVQNuumhL5UMX
 2QljwUwLOpHPmUylP3qLtOHHAfcQqYHdwOxzdycoW/ejATkJsDbjz6cwNny3yKgmqCCs4GYfFXf
 pp7bM/ZrSipg2sO9xNznrc/JompBU9/OvoaNpOJZ09S9R+pnfsA2/5RCHH++93A3dn5J6CiB/dz
 BmCrHhEgtcgFrn9wBi
X-Received: by 2002:a05:7022:5f12:b0:12d:b26f:cafd with SMTP id
 a92af1059eb24-13831a56e5fmr1863131c88.5.1781041695175; 
 Tue, 09 Jun 2026 14:48:15 -0700 (PDT)
X-Received: by 2002:a05:7022:5f12:b0:12d:b26f:cafd with SMTP id
 a92af1059eb24-13831a56e5fmr1863108c88.5.1781041694676; 
 Tue, 09 Jun 2026 14:48:14 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-137f5550bcdsm17095895c88.14.2026.06.09.14.48.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 14:48:13 -0700 (PDT)
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
Subject: [PATCH 21/27] tests/tcg/aarch64: add user tests
Date: Tue,  9 Jun 2026 14:47:39 -0700
Message-ID: <20260609214745.772536-22-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260609214745.772536-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260609214745.772536-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDIwNSBTYWx0ZWRfXxbJDTcZwrl1X
 ua2fq8Ika4DMWFH9PtYntcGu29pDzxLRx2eE8lrrMTpxcMfTf2iK5vcLze7z8qx3gerjjROXl85
 EvMQB7b0Cx1PxUL3AJdV03lmBNeE/MyeKFzL3C9Re+wEZ60OqvTVvslZZfqMrt5aXikqrqKPucB
 +jYdrrUY0cYGrtUIX+JXKBRK8k1UzJdjzEpnQwobd4pPXiNE+HnI3fSDQO8orBwRvPWAN44KmmX
 v21LiBX5T+XZ5UgKZMKuiM5q5O79sCfBPllizYA9HCPZP1m9oLkL+T5QZ132u8M4YNpMKAIL2iK
 Mpdu4L00b7D7Smn4MvlHW29G8Q1wGId6P08VfzJUuE68fsYvRPhzZPHKMi5mBIgTnTrWqQFFFur
 tMU992el8Yibx+ZmvFjLBaaecSETH+6wJavuvEbD/Wyb8Mx9GhmacHPADinkSu77uzO4QAkAs4m
 CmfFh66fAMJ9ddiHw9g==
X-Proofpoint-ORIG-GUID: mwecKebcjeo5uJrMt2htpbN0XXRutNUo
X-Proofpoint-GUID: mwecKebcjeo5uJrMt2htpbN0XXRutNUo
X-Authority-Analysis: v=2.4 cv=GeonWwXL c=1 sm=1 tr=0 ts=6a288a1f cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=Se0jXKEZ9Br8DtPn3R0A:9 a=vBUdepa8ALXHeOFLBtFW:22
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
index 6e46c121fda..8633c58459b 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -68,6 +68,9 @@ endif
 test_plugins = {}
 subdir('plugins')
 
+# Now let's go through all architectures
+subdir('aarch64')
+
 # Finally, we can create all test executables and test targets
 foreach target, plan: tcg_tests
   # Detect duplicated executables/tests, and report an error to force user to
-- 
2.43.0


