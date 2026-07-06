Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEE3FC43602
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 22:41:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgryT-0005pZ-SO; Mon, 06 Jul 2026 18:39:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgryS-0005ms-Sx
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:39:36 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgryR-0007Oe-1r
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:39:36 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666KE6fu1626343
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 22:39:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=tMspx/Ibkns
 55WpBZdMf8NNDB97YoGOU1i+OhkFI/E4=; b=Rb1rw55W4s4OD2jDnMUopqt9WuE
 JvO19G1n6no2KkLlEJBtLsIgEhnctyH+zpTqyruqdn1/UTz9A6IcttBQlzLJoGDM
 78QTB4rUwSfA4WoEWScAAeXNLTVxo5KCl00RRT/DncZa0Ll3QWDJ1+w9FErsus6g
 9CnsqE/dg/YlxoBhR55FGDqQsX5Qh3xVAXbjwr4g2jO+kdGGujb+SuekKRNLA+jM
 AP01tdh/HjlkMoglcvSFB+omAv08YfMU1VSXQMRyV/SA+7QyGN8uQHRsZyNVWXY4
 e88/n0F+WNAx+WsxZmhN7iDwNAXr03utnHQ59IsuxcqY/duBqQvwB6WJwDQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88h9bns1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 22:39:23 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c88ad1558f4so5887556a12.2
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 15:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783377563; x=1783982363; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tMspx/Ibkns55WpBZdMf8NNDB97YoGOU1i+OhkFI/E4=;
 b=X86D0O0DcCI9qSn0F4VXJE3J4ww8UAs40hcf+vyZDvY0sp4pZOtIBQ520tXHpTDN0o
 FI00DPKSkVUpulPWE9pyUQQPiQaJb3onlDznz9wiKrME9BKIn/r9tp/8jwm1wXKIZKQ8
 GdYU+XJ9sSiudG/PDzOAJ/1HxW53B8i4ul59ioZ1c55UYaBD/DmRe8YEnbyJpDH6daKG
 5SfFfa3IOTn7Bs5Rivd76VpGYWScwzyClx2gK7LrqRpP4mNmNYKZ/FhaupbRKsuAoRYV
 ePB9XXiOqXSX8XvjYBQFowukTnGV8pbmKnu2lNNYDUP/dufoN1YjG/Zd88GBcyKI3lqo
 oyHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783377563; x=1783982363;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tMspx/Ibkns55WpBZdMf8NNDB97YoGOU1i+OhkFI/E4=;
 b=HxxZysvn/nMnIEKu/0UBTHrFJ+2xwr/BnpJTIgXwWZeutfeiayHqCmunrCQ49JL0uV
 KaxlhpcJFOw1R0hAHppG/8ptqqhU9K+A3biK1JylV01vhUCjv3NcF1E10Cj4dWtZlrnC
 z30GRHcj0mnwtwH0PxreliSzqFvmW2rIMozQsloeK6Hbz2StzVBYkdKS0X9DFbVL4jM6
 Go6kxRvfpmx504sCb7iEi2Xl3/0CeUyFEpmN18LXalDpbzaCXj7ngSXWR4owV8W22iqH
 9Hw+PXZqdQ7lcU/9bHK6MEnxGYYvpIPARZkpkEZ3NRvWeuKZUO9p/6HStD+qUo2VoaD6
 1iAA==
X-Gm-Message-State: AOJu0YzC4TdSZLq/fq406oQ9ICXIPhLZn65aCMvjxK8D8Ls3ukJ4p97E
 eUGtEqIi4+B8w/w1gWyDziWfCiyjY7zAnixicaFKrao9Mj4EJRVQ0q0HZZZjZOKv1+BwVg11KLm
 B0MTd7eylMY0mSZ0VGLScxhZOBFb6nVpgkOlLbS7lwpZ1cJK4QjIKoHYndQL1saXSsw==
X-Gm-Gg: AfdE7ckWwIbPstMR5ke+O55MbstFRMPJGiqchZT1I6LKTjSBTXPhNn6raW2WxmNh9hH
 5rsGqFr05iXBfeKlhBu59f8Nor/jy9Hwbxo3qQNaQhXVRbfVuU+1QgM8MVrGT7dzB9Sqtfp0uW5
 1TiJwy6izecDxSjtRfFdkQSHRZcQ951mftBJxYiabLK6TxkxTWQpuX1hmgf/wrB5CzoUa7FM/wO
 qrV+YE6Um0Mh+l7MxEdCBLTO8sR5UPH0xm8p16Wex2fmtCXWuuFUddx+V8JXwHeEnCr+seV0lPT
 SFzVDW0iP4UGHhGX41kpYCRartgitNl+m9ibIJ7s+O+HFqUL2i/itCNaU6hRX8mBMCnuTkOLN+b
 DtpBvA1iwt3/UJN3XkRg6iBUwXJa6LBy67h2SLdwFg5BV48uAAo77XmcpbnRcu6ARy7CG2kMfQ6
 ddK5vBeg==
X-Received: by 2002:a05:6a20:4327:b0:3bf:b3d5:ce1b with SMTP id
 adf61e73a8af0-3c08ed71926mr3007063637.12.1783377562864; 
 Mon, 06 Jul 2026 15:39:22 -0700 (PDT)
X-Received: by 2002:a05:6a20:4327:b0:3bf:b3d5:ce1b with SMTP id
 adf61e73a8af0-3c08ed71926mr3007038637.12.1783377562451; 
 Mon, 06 Jul 2026 15:39:22 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659d8da9sm1399484c88.14.2026.07.06.15.39.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 15:39:22 -0700 (PDT)
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
Subject: [PATCH v3 78/91] tests/tcg/s390x: user tests
Date: Mon,  6 Jul 2026 15:33:30 -0700
Message-ID: <20260706223343.988769-79-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: QZD9MQmzzXEkB50nwplX7fVhdTYQ8KkZ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIyOCBTYWx0ZWRfX5mAFZdjuBtda
 JogGqNpAoCKsfs8yIl5yNyFoVj9drNfCEdPbOxR9hc8WJElW2ZKSTTIfsLjmjYF7cYWcSzvhLid
 Sg7Js52y65RK+aBBFP6W6R+qqRUUYXU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIyOCBTYWx0ZWRfX2r3x+T/lLnF1
 oEyjnYbgJ9yXhMYDGB68n9+khStFI8BEIHHvbf6RgrXOk4NlUyH1rIZ02qzQy508bLIuxe+Yew7
 DOZBA+QkiMygERkFj7fIizVH8SLWw5ZeO2YL2EH0DFPYafJhwSUNgl3PJBhr5Hjm4knwIjBanX8
 hJngUh3EqhQnKKr5Sjtke0atP3LqHy3FDExlBDBdh5Q8Tu8F6oQiPnYco8jqD03AJ2iF4YPZ+n7
 OCgUKkhZ1Ve8593TroPFikUX+DuxChwyE6NzQl+aJJi3g6E/n1E8jK7WOxJCV0lkkjsgnIO2Xpn
 IoTvqrssYKO/mUuE9jfMQ8LKnxgzVDKuBqYInPbO9nq+A+4jZcbVDTViWHWfvjM98q+UPJkqNcS
 qpQ8hoAFAZgAnHoerpxfOEP1n4XcUYdI4eXUI9xKfqwiUZ0IzGUEtw+9XFpZsn/FzZBUWHxSZKP
 HpoHtXEo9/zwMX/Rdaw==
X-Proofpoint-GUID: QZD9MQmzzXEkB50nwplX7fVhdTYQ8KkZ
X-Authority-Analysis: v=2.4 cv=GulyPE1C c=1 sm=1 tr=0 ts=6a4c2e9b cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=9O3JCxMgrmeWcQ73_rkA:9 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060228
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
index 5e82784d318..52418b8b72e 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -150,6 +150,7 @@ subdir('or1k')
 subdir('ppc64')
 subdir('ppc64le')
 subdir('riscv64')
+subdir('s390x')
 
 image_targets = {}
 exe_targets = []
diff --git a/tests/tcg/s390x/meson.build b/tests/tcg/s390x/meson.build
new file mode 100644
index 00000000000..295d24f0e19
--- /dev/null
+++ b/tests/tcg/s390x/meson.build
@@ -0,0 +1,138 @@
+cc = 's390x-linux-gnu-gcc'
+cc_dockerfile = 'debian-all-test-cross'
+cc_docker_arch = ['aarch64', 'x86_64']
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
+      'cc_docker_arch': cc_docker_arch,
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


