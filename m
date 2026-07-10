Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ADAFC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 06:32:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi4lB-0005yn-2v; Fri, 10 Jul 2026 02:30:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4l9-0005wk-9D
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:30:51 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4l7-00073N-74
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:30:50 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66A3nSnN3803848
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:30:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=1ZZytTr1iLY
 z3NnwatuZJtOGUYkJy4Ic3vvnqPl1OJY=; b=nvBtlE187UcqCJ/Aep54Ur5YDg0
 /LBdiV+PHVThV1CqdCxzoZ3E44PRAu/Uuv6lwAiXlrwkIhuaUpQQeOuwIfiYPGWf
 t817CA8BywX5Clp60rt3UUe32uOzsXAKDIabCivA7RJv69NtREubJHKDnWAX2Qq8
 cExqLRZKCfGclWR08w1CqNDm3yP3ar9crt6MFmEmKxeH0MCQSvH80d3HXGNxmxz+
 4LkmackvRgoksDFMwgf5DRWOL52XW84aJcqCovdXJnZ5Eo8fLkOJNMyLpY7CYLQO
 JZQbZv7QR0lFYVas/10h8/LppdZIjKl1s5FR1oEttnSXWyen5+TNuHEXXcQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4faf5mtv8x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:30:47 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c88e0f04e51so546330a12.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 23:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783665047; x=1784269847; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1ZZytTr1iLYz3NnwatuZJtOGUYkJy4Ic3vvnqPl1OJY=;
 b=hPdiThL1jN5yxGihsVUEztAwecaAoNU9kPan30A4dLZ9J9Hnq5zTDUB7bpBLNcbB9n
 1JUTCKtbwGqbze9BQll59rr/K1/wIBskLkbABD7uZrSIDcJObMdUQwKutaHk9UXDekdV
 Orj9qMvmt3NWq22VbA2WEPyPFXLNU9xzsYAyEwjmFGCKmTx3wEw6P5NdTM5z96XGpiAx
 bD2zE3ACWc5MRNZPt1gQ39SlzCo2pmIpJ0W+oPDN3mOr3oUuJsQKW9W+nbWvQuaMvVPe
 BdxWyQ0ZYnKIMvcGbgsCQkOJXR0iQGbaI+MBHLICUjuniqd2bufwXeMoYVc1w7n6hwCJ
 wIFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783665047; x=1784269847;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=1ZZytTr1iLYz3NnwatuZJtOGUYkJy4Ic3vvnqPl1OJY=;
 b=SmQqY+zXPCu8zWfk+5dZtaV31g8IjhFBzO9cdyO8GdQnie0+IIIYJ/vuGvk4pd6S1S
 1LRmfrnRhic4YTSwe0iD4SxbIrc5IjV5zjJv6thFVPacVN8w3/PLV9FrT5ImTAlS68Z0
 RP0+SeNWJuwkY7gJEbCL+tH8BWirzSr3+PCHsVczJesn+JFdxtml5JTyTrmz7QNb6+v6
 lJjcP3itf6jY8d8Lz+23NGdGTnKwXWe8UDJittE7MZb9HObtvfvbjK9Kdq0MZ/ZmppR1
 P003oRJ7E1xBAv44aUPlPHQnOANU4XPoWYie4dErLBjaZ2K39cs2eJRsQR+XaEuNxo4h
 UilA==
X-Gm-Message-State: AOJu0YyAUGKDOSyPbx/1P0Z4SDI+TQLN8KWKNupUZyrX8Yu3PRtnuSOb
 cpMfDm+PRF57rXqDg4czCv7YhupPqe5XMxnIEKygy8elcXi09YolldANkSSDtqBjYlT+PxAvP0Q
 lUFaK4JiKUh5G2LKAf9+GeRl+v4sXpmS54X/qOGVfYRlvuHdTIx4fii2nJ5T+6JtYjA==
X-Gm-Gg: AfdE7cl/x943/O9MdQsDsIT3LOJ5znz3meu3mj3224UAOwkHYRW499N0jdIQfw59L1P
 Q2ieZtFWlVj/zdiClD8vGV8VIWmx6fYToLpjPbbWRghd2CwiWipCF+mpU5Qp5A9YC6v5aYThfpB
 I2Efv7UKsAZ3+8z7BM1LK0SoawjY3OWvS+V9TJ2k/SDWJYUMhdjhuU+GO17XfzImDu0kNLjU9EQ
 jDI1ReBvKo+9YzZx08/tEI6U4wRwelhZ4DcYCHgDxy2K+5H6EP31mkkhXJwQHEkx12Rt5SKvju8
 shbJeLqCP9QXMRISRf6QT9d65HL2oBDkLaQ60skby8h/3QrkS3ztuizF3zwtrmDM4FDOgTbqgMQ
 zN29CQAtBJRAD0KMOqpo+CcgP5UiVc1VFYEhYJ/PaaL3AMlwWw9Lgrys1KOgd/N1BVd457CLvay
 /sN/Go2w==
X-Received: by 2002:a05:6a21:a8a:b0:3b3:4406:202c with SMTP id
 adf61e73a8af0-3c0bceb6daamr12824879637.10.1783665046493; 
 Thu, 09 Jul 2026 23:30:46 -0700 (PDT)
X-Received: by 2002:a05:6a21:a8a:b0:3b3:4406:202c with SMTP id
 adf61e73a8af0-3c0bceb6daamr12824826637.10.1783665045916; 
 Thu, 09 Jul 2026 23:30:45 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3120c8e41fcsm6258960eec.15.2026.07.09.23.30.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 23:30:45 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Gustavo Romero <gustavo.romero@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Helge Deller <deller@gmx.de>, Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v4 81/97] tests/tcg/s390x: user tests
Date: Thu,  9 Jul 2026 23:19:59 -0700
Message-ID: <20260710062016.1818125-82-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: cPoL0zRkSF0hzsu9zB9ASavwFmLf1Ww4
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA2MCBTYWx0ZWRfX0x5JnvaFOnJq
 BHVQ3E3poYhq6PYjUQtzLfdOvx6QJcbaT3LY+to7mhM42Sv2+hr/YCeSyvufh9lS/HBr9HqBI8E
 RMEcGcGFvEJRnmM1hL7Y2Eiy1PmzxMA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA2MCBTYWx0ZWRfX3aQEHCiwgMN0
 NNUikLScxzocmwwDaskyA60claeKRubBrnEMnSAnbTS3Pmu9UrHIde/EEi/6pX1hORdNqjL1QKC
 M8c68jgJMBEV8YYidroclJW8aN+Pdhy9/zrSwDQM1Bsm+ruUyIjd0s5QDDQdOcNgfhj2rrZON99
 sQryaXAlM/pTaWEcj5XUB8IKrQIhBkffv8SZhwB2dKHFGptCnHTsZM/yxKv6GMfkJp6LyuiETdh
 5mq390djG8FAdNNwXuFpsx48COEIDVOJargoBv0B5D4kcfdTrAZur7gt12b8dkZDBk1QwvMbqf7
 g4fIG+1biSGSyEX04C1yXmvNsM0UfawkHAQ/DG/NH05M9JKVjoysOfKu2HyRYDo8jBJ7+FQep0D
 sfzfUDe3oMjoZ9c0jsIZtpSK7Jm9KqmfLKK5+hoSpm6jkKziNeWDuwk124V73/94AL82VDyIcyW
 bQ80kuG2i5Rp6V1Mpew==
X-Proofpoint-GUID: cPoL0zRkSF0hzsu9zB9ASavwFmLf1Ww4
X-Authority-Analysis: v=2.4 cv=N+QZ0W9B c=1 sm=1 tr=0 ts=6a509197 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=9O3JCxMgrmeWcQ73_rkA:9 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_01,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 priorityscore=1501 phishscore=0 adultscore=0
 suspectscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100060
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
 tests/tcg/meson.build       |   1 +
 tests/tcg/s390x/meson.build | 138 ++++++++++++++++++++++++++++++++++++
 2 files changed, 139 insertions(+)
 create mode 100644 tests/tcg/s390x/meson.build

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index bb4b770070f..2e87af4015c 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -149,6 +149,7 @@ subdir('or1k')
 subdir('ppc64')
 subdir('ppc64le')
 subdir('riscv64')
+subdir('s390x')
 
 image_targets = {}
 exe_targets = []
diff --git a/tests/tcg/s390x/meson.build b/tests/tcg/s390x/meson.build
new file mode 100644
index 00000000000..3adb7dc464c
--- /dev/null
+++ b/tests/tcg/s390x/meson.build
@@ -0,0 +1,138 @@
+cc = 's390x-linux-gnu-gcc'
+cc_dockerfile = 'debian-all-test-cross'
+cc_docker_host_arch = ['aarch64', 'x86_64']
+
+cc_feat_cflags = {
+  'z14': '-march=z14',
+  'z15': '-march=z15',
+}
+
+tests_s390x_pgm = [
+  'br-odd.S',
+  'cgrl-unaligned.S',
+  'clrl-unaligned.S',
+  'crl-unaligned.S',
+  'ex-odd.S',
+  'lgrl-unaligned.S',
+  'llgfrl-unaligned.S',
+  'lpswe-unaligned.S',
+  'lrl-unaligned.S',
+  'stgrl-unaligned.S',
+  'strl-unaligned.S',
+]
+
+tests = []
+
+# Multi arch tests
+tests += tcg_tests['multiarch-linux-user']['tests']
+
+tests += {
+  # The following tests contain inline assembly that requires inlining,
+  # and thus cannot be built with -O0.
+  'rxsbg.c': {'cflags': ['-O2']},
+  'divide-to-integer.c': {'cflags': ['-O2', '-lm']},
+
+  'hello-s390x.c': {},
+  'hello-s390x-asm.S': {'cflags': ['-nostdlib']},
+  'csst.c': {},
+  'ipm.c': {},
+  'exrl-trt.c': {},
+  'exrl-trtr.c': {},
+  'pack.c': {},
+  'mie3-compl.c': {},
+  'mie3-mvcrl.c': {},
+  'mie3-sel.c': {},
+  'mvo.c': {},
+  'mvc.c': {},
+  'shift.c': {},
+  'trap.c': {},
+  'signals-s390x.c': {},
+  'branch-relative-long.c': {},
+  'noexec.c': {},
+  'div.c': {},
+  'clst.c': {},
+  'long-double.c': {},
+  'cdsg.c': {},
+  'chrl.c': {},
+  'ex-relative-long.c': {},
+  'ex-branch.c': {},
+  'mxdb.c': {},
+  'epsw.c': {},
+  'larl.c': {},
+  'mdeb.c': {},
+  'cgebra.c': {'cflags': ['-lm']},
+  'clgebr.c': {'cflags': ['-lm']},
+  'clc.c': {},
+  'laalg.c': {},
+  'add-logical-with-carry.c': {},
+  'lae.c': {},
+  'cvd.c': {},
+  'cvb.c': {},
+  'ts.c': {},
+  'ex-smc.c': {'cflags': ['-Wl,--no-warn-rwx-segments']},
+}
+
+foreach src: tests_s390x_pgm
+  tests += {
+    src: {'cflags': [files('pgm-specification-user.c')]}
+  }
+endforeach
+
+setup_z13 = {'cflags': ['-O2', '-march=z13']}
+tests += {
+  'vistr.c': setup_z13,
+  'lcbb.c': setup_z13,
+  'locfhr.c': setup_z13,
+  'vcksm.c': setup_z13,
+  'vstl.c': setup_z13,
+  'vrep.c': setup_z13,
+  'precise-smc-user.c': setup_z13,
+  '../multiarch/sha512.c': {
+    'exe_name': 'sha512-mvx',
+    'cflags': setup_z13['cflags'] + ['-mvx', '-O3'],
+  }
+}
+
+setup_z14 = {
+  'cc_feat': 'z14',
+  'cflags': ['-O2', '-lm', '-Wl,--no-warn-rwx-segments']
+}
+tests += {
+  'fma.c': setup_z14,
+  'vfminmax.c': setup_z14,
+}
+
+setup_z15 = {'cc_feat': 'z15', 'cflags': ['-O2']}
+tests += {
+  'vxeh2_vs.c': setup_z15,
+  'vxeh2_vcvt.c': setup_z15,
+  'vxeh2_vlstr.c': setup_z15,
+  'vxeh2_vstrs.c': setup_z15,
+}
+
+tests += {
+  'signals-s390x.c': {
+    'test_name': 'signals',
+    'gdb_test': ['--test', files('gdbstub/test-signals-s390x.py')],
+  },
+  'hello-s390x-asm.S': {
+    'test_name': 'svc',
+    'gdb_test': ['--test', files('gdbstub/test-svc.py')],
+  },
+}
+
+if 'qemu-s390x' in emulators
+  tcg_tests += {
+    's390x-linux-user': {
+      'cc': cc,
+      'cc_dockerfile': cc_dockerfile,
+      'cc_docker_host_arch': cc_docker_host_arch,
+      'cc_feat_cflags': cc_feat_cflags,
+      'folder': 's390x',
+      'gdb_arch': 's390x',
+      'gdb_feat_version': gdb_feat_version,
+      'qemu': emulators['qemu-s390x'],
+      'tests': tests,
+    }
+  }
+endif
-- 
2.47.3


