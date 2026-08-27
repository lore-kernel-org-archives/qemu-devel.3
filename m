Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35343C61DC4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:17:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziOK-0006wD-VZ; Thu, 27 Aug 2026 18:16:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziOH-0006lz-Ux
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:16:10 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziOG-0006Cu-14
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:16:09 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJLeBP778988
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:15:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ClO2Zzt/VXColTDq0F35bZK+5PH4jaSyk4/eYBjQZnw=; b=NxW9cHhNRPCyCunM
 UdinMn+SKPRuXmeINxRcbHKqL6WjZRcVomhYbtPjA3PZ+Hyr+BcddAvmD1hmJuI8
 X3BYzXz7l4WpOAFAgfYiy4iDMPqyVSs7ndDhPeAzEVrh/jKCLHDN07wMFOrqC/7H
 D9N9pNYuK2KAjmSlKsydmVNUOe4RNUQQGOZ7mYRJ4sLvxOY/wRSgxOb8xQKHgOQr
 1+LPUgednj74aYy15FusjqrvsimxT+wpvk/N8+GBtwRwFIShYeCvmFhtrFBzrgVw
 CUQLntECJFm12yCMA16eVb8yBOjMG9wKwCAaUzV7SPoFhIkMtiUzwpDmbZfTqGCs
 9q5laQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4garee1qfm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:15:56 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-848568a6f62so505478b3a.0
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787868956; x=1788473756; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ClO2Zzt/VXColTDq0F35bZK+5PH4jaSyk4/eYBjQZnw=;
 b=huxiGofYzLBLqhia5NOhgMICipxPDZusRVrMmtRVkCwBr+ng0t3rqLW3cHYEoukubo
 zw3sp4GEeqEWfeksgXLkUJGe9Y1JGUy0XLN38pmQpzHDSda+v7czIVdpiqsDoq9/LfIa
 fFe+5m8Q0hRgxYFlvnwf3ZC1EOZtJGx8/mQbCp4wN5pVVkR/OkNxPLzLXtNtkcEbo3ew
 O7f1NKTLac70vRf8yzSMushpVIpT1LjI/zBdHLDHUyWxHRvN6LGyG6UcLPNLxqq9E85T
 qYm8d+vtNnKqM7I/9/7u7odtEbzl/vesZqLH9BYG6qUs6QBnvSd5MG8VoxIiei1dBwCC
 nmyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787868956; x=1788473756;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ClO2Zzt/VXColTDq0F35bZK+5PH4jaSyk4/eYBjQZnw=;
 b=P2ewQmGRXFnzpzWv7mRhS813MdZmq3NRISRPV9MCrv509hHtQlCtD0S2t0wgSLGked
 GOnwtI/GrttV8mwY1j0L1S3TMoH/ycpig+oIodzkHlyLsHaB4ptbTemf8A8vQ8qb+LSj
 1vQNJ21cVMiz8ybFVAL7NRQWMOAZiTo+Jc+qoTj9e2iXur+6O8sV7EM3jk9XmYDY7u1O
 V3dZtLXmedOGWHlC7Nl4Bvz0gFm9VOttvdo9iHcNklUgfEJzfXW1D2dFCKsJAmIiApYr
 pWYcO1kXkM1dqR4l8R69nQUbAX0RgaiR3XIRrWTzBm15XKwZY/0UsN2VsRx5fqkCxK34
 +raA==
X-Gm-Message-State: AFuF++nCcPWJaETvQ45YljjN3QhMnmioOmVmAYnITAyGVWAjz8/fppbI
 zHJN35DKjyaS9uRZQVJobcLFiUqSFgyEQI3P/NHlr+aCWOmtdM22ecyBjlgj1IWQGoludQqCVFh
 FOrSU0zcPqfql3lVDcX4jXTSTDfijcZ4jyOH1XZDPqWmJHnfGcl3g7NYiJDPDvSYhzw==
X-Gm-Gg: AR+sD11bIFBPyG270cD9Lknut93LX0SIhmnKYRKoNCzDQ5m53d6K924eu4ORYPFSKLT
 QMMXjjxNQBgo4iyGSsaVgyBnkL8p8n4HUq3B335b722qqkboyg2IvGteuw8HKPfdOzuUkti4aCu
 mOX5DqnjjOuHmNWXX668vy3sV5e0ZQe0+Ey+Jbv1Ua5wDi6p3vLSUAsEHYgM9r33xNkc58pA6Rj
 Bx/nuw9YKQnnRJdRWLVueYd8AnCovYZV+8b7DYUhgwt0LfXa5XI1rm0u5IcFK5ubHL+kbIK24R1
 6dXrZbjwDTb5uGzohH9JFltcrE2CvkQXQfjXpL97zVdPtTe9I+xATG9YTkSaBdDByzNdOwaLS1N
 64uZRF5l5GXCwXgyXKVEt31giwKPtMEfXgEMRKysAQWpmCJwpb7LRaQ2V1Go=
X-Received: by 2002:a05:6a00:3316:b0:848:2ab3:ddeb with SMTP id
 d2e1a72fcca58-8562b19ef19mr4955552b3a.14.1787868956017; 
 Thu, 27 Aug 2026 15:15:56 -0700 (PDT)
X-Received: by 2002:a05:6a00:3316:b0:848:2ab3:ddeb with SMTP id
 d2e1a72fcca58-8562b19ef19mr4955462b3a.14.1787868955616; 
 Thu, 27 Aug 2026 15:15:55 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8535cf4b213sm2524104b3a.55.2026.08.27.15.15.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:15:54 -0700 (PDT)
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
 Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PATCH v8 037/105] tests/tcg/multiarch: declare system tests
Date: Thu, 27 Aug 2026 22:13:58 +0000
Message-ID: <20260827221506.91574-38-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfX3IzljhwboCGk
 ex7tC0dkoVt+biTy6zUJf4G65PLeoomH9Wq+xgf7zM4L40MHIvQz8VaCBWVTlKa8HrdV2InLwQy
 1bha/8LaPFWV+05QAvBuAqhmp1EZ9iNLIm7p2e0Nxilo8uxW9b51cbhETRYGmeyJNIbA3whtPp2
 MyuUMnFzIo7BWwJOpP3RW0KAB/jiwysw5/3bH4PCWrLpxiVNR4nOBWP7F9PWgNBHduiq1XDpiS7
 9W4S67hD2r/ijc5+LmU2Nt+boeI6whxnP/H1Ct2NAzfbH1CJPU/MdtRacd5G6BFr0yJ6lGNVFSe
 0WL7q/IKJP13w6PijY96W6eVrEbrMjz8BdgeOsTLXZULgWiAEUpcyDW2CO6uF2uH2qtexQChYNo
 oYSPt4zbqPEfSa6De27LqUrXHNU2ckF/yCx5DJ+5gwji76RewUQ+Cb9A5nfYhC+HrqjtD7aZxip
 U+l4GeYb+2kemUhcXHg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfX2S2NDVK7yPEw
 2zrsHNhKlhKa/OueR8cHPUC21JkW6792JrdqpWNyJqXzRD996huqS4P7rC9jJ49DM9x+lq3dhW0
 ak/X07ULwSqupKsohBf7srD5+Tb9Rek=
X-Proofpoint-ORIG-GUID: m8GR4vyaRqCmQvn_Sw5-NSBp60uLbFWG
X-Proofpoint-GUID: m8GR4vyaRqCmQvn_Sw5-NSBp60uLbFWG
X-Authority-Analysis: v=2.4 cv=e8E2j6p/ c=1 sm=1 tr=0 ts=6a90b71c cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=EUspDBNiAAAA:8 a=8vYM-gic8w0O4C_0kjEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_08,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 adultscore=0 priorityscore=1501
 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0 impostorscore=0
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

We now declare all multiarch system tests.

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/multiarch/meson.build        |  2 +
 tests/tcg/multiarch/system/meson.build | 53 ++++++++++++++++++++++++++
 2 files changed, 55 insertions(+)
 create mode 100644 tests/tcg/multiarch/system/meson.build

diff --git a/tests/tcg/multiarch/meson.build b/tests/tcg/multiarch/meson.build
index 99af41b3fcc..508fdb585b7 100644
--- a/tests/tcg/multiarch/meson.build
+++ b/tests/tcg/multiarch/meson.build
@@ -1,3 +1,5 @@
+subdir('system')
+
 tests = []
 
 float_helpers = files('libs/float_helpers.c')[0]
diff --git a/tests/tcg/multiarch/system/meson.build b/tests/tcg/multiarch/system/meson.build
new file mode 100644
index 00000000000..f71c12db38e
--- /dev/null
+++ b/tests/tcg/multiarch/system/meson.build
@@ -0,0 +1,53 @@
+tests = []
+
+# multiarch src path are written to be included from any other arch folder,
+# so all arch can directly add those tests.
+multiarch = meson.current_source_dir()
+
+tests += {
+  multiarch/'hello.c': {},
+  multiarch/'interrupt.c': {},
+  multiarch/'memory.c': {},
+}
+
+tests += {
+  multiarch/'memory.c': {
+    'gdb_test': ['--test', files('../gdbstub/memory.py')]
+  },
+  multiarch/'interrupt.c': {
+    'gdb_test': ['--test', files('../gdbstub/interrupt.py')]
+  },
+  multiarch/'hello.c': {
+    'test_name': 'untimely-packet',
+    'gdb_test': ['--gdb-args',  '-ex \'set debug remote 1\'',
+                 '--output', '/dev/stdout',
+                 '--stderr', '/dev/stdout'],
+    'wrapper': [prog_run_and_check_forbidden_output,
+                'Packet instead of Ack, ignoring it']
+  }
+}
+
+tests += {
+  multiarch/'memory.c': {
+    'test_name': 'registers',
+    'gdb_test': ['--test', files('../gdbstub/registers.py')]
+  }
+}
+
+tests += {
+  multiarch/'memory.c': {
+    'test_name': 'memory-access',
+    'plugin_test': {
+      'plugin': 'mem',
+      'args': ['region-summary=true'],
+    },
+    'wrapper': [prog_check_plugin_output,
+                find_program('./validate-memory-counts.py')]
+  }
+}
+
+tcg_tests += {
+  'multiarch-softmmu': {
+    'tests': tests
+  }
+}
-- 
2.43.0


