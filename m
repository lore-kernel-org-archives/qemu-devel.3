Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23E53C61DC4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:08:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziG9-0007ZP-5f; Thu, 27 Aug 2026 18:07:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziG6-0007Xl-O3
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:07:42 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziG4-0003cw-RG
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:07:42 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJLp8K3848243
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:07:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ClO2Zzt/VXColTDq0F35bZK+5PH4jaSyk4/eYBjQZnw=; b=IOljR3UGvHV9TgHf
 g/2RTm209AH6roIL/tzCnG74fZsn663yaJfwBkfWU+4PpO5jspqITqu6CrOZs58r
 vB3m3JMe0iBEEDBbouy8wuUBIVX0g2oGiRdMztkIDOqprX0ZVTzDiURhd5xMhL1G
 zjxfDUm1wLTb9Xt2APGQmjOmpFMX/zvZebA/mX++1eYeP2EWEOIavupKGmILnNzc
 2k8yDrL8pFxuk38/9MSMuMIN95WYDisRh1B5EbEa/VMWimcQy732k1i3eQEB5MC2
 E5wKGgtjOaIIoubdRYiXLHvgRyqMQLUVZPrXGLeW5v7A4ybxTHXwjQPiSZ+gn0oG
 S6xo8g==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gatnc0sy9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:07:39 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-85599cf98e5so399363b3a.1
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787868459; x=1788473259; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ClO2Zzt/VXColTDq0F35bZK+5PH4jaSyk4/eYBjQZnw=;
 b=MO6PLaW+4f6UUh0NRcnVBFLrynxNtU+vrD/y6khQ+jp7VC9zczkf/EpuIyBhRyXmXy
 /97QCdBBuKz7Awd8P+EfTJiOSb4G2ArAeHgHFwtFOqWS3gnw2Li8U41A1GvaEothsma4
 PkH8J2vJb7GZjtiwh0gcIaAcPzwi49MNTRl9LMBRTOAq/fXa+zW/Tf5VNalMBDkf4VXe
 LG+1Nz8Q95J39OMR/uWdknNlREGr7KpVRKE8w3ERWeITQ2D7httSx2yjbWHfa3ax81Oy
 KLw/ntZfJX7izSMs8Eu8hU/gMyJzRvlPMuKF3rQcjdnkfJKdT5674nJ6YETMlWFHe80Q
 uYNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787868459; x=1788473259;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ClO2Zzt/VXColTDq0F35bZK+5PH4jaSyk4/eYBjQZnw=;
 b=iXy6wXCCdULn03kczu3qAwnMdoU/KAfI2fTl68OLHVJ1+eJqc1T9C3nUtx9dg9y6R/
 9mCxc/3isfFv6mNVsHU/XMaCxB2Etakp7sUCJTs1W94jwJJBD9pKMb6+YoOPL4yX5xko
 L4R7Mj/yjh03P+BYC+ZOwj5TX3Sj7FNPANHU2LVbJo9hcgNRldpIUYpFkKqJhHP+jb3E
 p1Jub0F0QLhMcsmvNXrzMiDkuKKixL9McBeQBqOn1DTBoW7McV7ZDw/ofoQr044MlTYC
 T/2xGCPqahDoFslvf3ut/V86Kt7zJ4Wxi3PgB/akQPNiY7fu00fraVrBgmC+C4Wh4x6U
 UaKg==
X-Gm-Message-State: AFuF++mseEJnjSRJi6tPyOv6JuwECLtItDBjFKQ9eJDe7hremtjvUqt7
 mH7e+2O1aVdbT9CsSdikTZUOVMJfDUoqccb0sX5/nDoAiA0MkuSUYbM+E4/Ci2PdXFnsbj2DdGc
 SNQ22wEaxLwVrVboqvesv30sG7E2RThHxL2Hz4FBFhVR03C0LReRIG098DAPKNZTaiQ==
X-Gm-Gg: AR+sD10FtCq648X7/+ETS2R6wzlVNxLfZAgbJWr7KLiYcQG5BnIPotYA6MnNOIkIMMg
 fFfAQ6VlHzid6r45yut8O7kmnw6hzidnQWDQ9t23hxkgkBVCmWYLQagiRItX+1eP3bhWgO2bzLG
 tOk5Q4ImrgZ/q0W99Hf22TgEvnjECPzsMiLgpD6JF47n7qSoVRfdNExOKX7R6K5UrPVq2YFOabT
 XBkJJX92POD6LegE6TAIllzMhXmsABm/+YbbfA1d2JbKWpEuoTeClO+hCHX+IU9PEfDfX8E1kol
 ZqsjIvQsWiBr/lzIh4ItIri8F6NkeVJ0asoBAxod0GvY+rS+0HHY8V+HJcd1+9rJt0mB5fu7urk
 pHBLADk5zk2pa42aMQcm0k3I4fgPGj2WXk1gc/2+ch/lmZEh8q3MjS12N8mY=
X-Received: by 2002:a05:6a00:1d8d:b0:84a:29a7:f650 with SMTP id
 d2e1a72fcca58-85625941b16mr4943885b3a.0.1787868458708; 
 Thu, 27 Aug 2026 15:07:38 -0700 (PDT)
X-Received: by 2002:a05:6a00:1d8d:b0:84a:29a7:f650 with SMTP id
 d2e1a72fcca58-85625941b16mr4943758b3a.0.1787868458168; 
 Thu, 27 Aug 2026 15:07:38 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8535ced0f99sm2523713b3a.44.2026.08.27.15.07.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:07:37 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Bibo Mao <maobibo@loongson.cn>, Yoshinori Sato <yoshinori.sato@nifty.com>,
 Laurent Vivier <laurent@vivier.eu>, Stafford Horne <shorne@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Song Gao <17746591750@163.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PATCH v8 037/105] tests/tcg/multiarch: declare system tests
Date: Thu, 27 Aug 2026 22:05:31 +0000
Message-ID: <20260827220641.84885-38-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827220641.84885-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260827220641.84885-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfX8gfTiYfiHhKa
 1PRQ3bX6TRg/2ZTW7w2zzh/lgNJU9rBxqCCI9usasKuZUl9wYLEA8qt23o7npCaoukYPnGtBnXd
 Y5R0lfkdWcYRrjbIe4JmSfmBsMFOT8abRu2n2MIYfV9DyyxnbTUJZsWE1dhvWSOO1dneYBpr3bW
 5c0D4Rv1maNvMvH3iSeYoEYh//5K/IXoCuiiQXDwU/TtCWLdliAbF9lrd3JVx3NTF8Y9cF7oPtQ
 MgXb742b7xhJAR72Ai78sBWe5txB2UfDGOJESiySmJcG1rYvTLPqsE9ESIK2jldipAPlzbda7/c
 URpygYpVjRB3Be3guf0uhIDBWhGGqBHqtwLAmaTFs60j3cc4M5IAu8F2DGU+yMCl33TZETgkqYs
 o0jK7bOn8KFDAbHxKqaYFjvjUFBKEXoU/7NUMb00IiKGYLKSTRbTTVAGG7mAD2u5p59k/XHqL+9
 BFGkT/zXpSC2qNgXViQ==
X-Proofpoint-ORIG-GUID: sDZ1WVmYwpKLcG28KgaU09A7W9Nw8U48
X-Authority-Analysis: v=2.4 cv=HfUkiCE8 c=1 sm=1 tr=0 ts=6a90b52b cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=EUspDBNiAAAA:8 a=8vYM-gic8w0O4C_0kjEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfX5tM2MtmKw52O
 5Pd8oV8OvAE+Je5LQjW85v/+RlU2OoM0klMaF56Vfnh2s+clMM96cIzaWA+34HBY6Z5W0Hzwtmd
 YXg+04VvrQ9LOmQd1R0W5vyt7QQ11U8=
X-Proofpoint-GUID: sDZ1WVmYwpKLcG28KgaU09A7W9Nw8U48
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_08,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 suspectscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
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


