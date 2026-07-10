Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF486C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 21:47:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiJ2E-0006uR-DR; Fri, 10 Jul 2026 17:45:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ1w-0005hf-OF
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:45:14 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ1t-0003aF-BH
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:45:07 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66AK3icp1648591
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:44:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gDup/KsI0LJAf0iBzQYFhDAOxBJXh+wxFj2U9fJCszc=; b=UB0XEG1xpACh62En
 oLF6v+mRQ8QgeIUEAPRFREPPmMs+MPJ82mHiqCK5wIiIlv3nHhFKopuaHEXT9HHI
 0n5g7HEiaDF8WhoandEeX5bxlY+0hHfYDPvSpL8nz9Ua20OspUIfLW2QW9MbfB4M
 tik0OX5xkNgVr4fLEK57CiiT1L8fJH5gTzQji873iBkmMoKzeGckAWktYWOWVgbz
 VLXQL713dYuYayOlqLj0wSVVTp7oTE4B8xfufYp3J2pTTe+zqCMc0m071pnAgrbM
 ok2d9O9zEQqkUfdWPRiZbTofu6PEoQUi24zXVzNPW799IupBgS4H1uQwwaifPPx2
 cHY/4A==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fb2txhd3u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:44:54 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c856470fe9fso1223206a12.2
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 14:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783719893; x=1784324693; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=gDup/KsI0LJAf0iBzQYFhDAOxBJXh+wxFj2U9fJCszc=;
 b=GM0Cz50Azq/tI1M858QI+35p/hqmapJ1WCWgmLg1bMHVXn89QOmdyA1PDpPlwtr0MO
 3cHXcrBYKYzfP/83LBPLr9mEZUD03oKO8n7sTEzhRzg1+mAqV3UzSXYUIf/phZ5PKkiG
 7BWPZDehLBbHAEQDzC76HhAg0DoKuvKaFUmCdHRUpnGidyX0lqSHIyf1dL5lDJ7nvBFZ
 iQKAwHjfKMRlMR4ffs9L+68mEYixAEgvcB89Im1af1qvzjwS/aDacekPyOUvoQ2Ism6E
 oWkrHhbT8G6UbU2zmsW9jOxBq3Pz/twR+uGHbNucWk6hbk/ziW1t5i5Mj7XJrCf7hHDF
 6tlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783719893; x=1784324693;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gDup/KsI0LJAf0iBzQYFhDAOxBJXh+wxFj2U9fJCszc=;
 b=B0S3yWcWCtBM02Vq4QfEcRQij8+KsBSN47PuyoNd6WgXky/61NixfLJUUJJUSbcRAQ
 aHGT5s9qQZE41HwQic4ReTURlVCBNYwSu1MhttbCr+xC16Eyg84EW50oHMyW8kuhdDTw
 816FSOBo/3wZjbyij/vvY8BRn/XNJ9rX13bQbJcLDLNhzpPvZ8rAFCBMOyHOqdDB/BJq
 ewWLU0/0FjTNkrDzD+SXRFXwIfIUwVlJWMdmV/EJpyxiPqxzhvzwB1YCRd0msLFzJYTu
 2ovh90LdkS5FMcsY859jKFhHia1iEtKJ/y+9p9k/jmllCxv0uCbyE2GWQu7FwtRsaSgy
 y1gg==
X-Gm-Message-State: AOJu0YxpXYpHGExTM6ErPyclh8ZfcvZlN6OmulpKXvrpMa+aRDT0VXeQ
 37WfFNtwr1QvyaHGlgQmCGqAliHflNa2ThJFc/53HvlUhAKl9272UbqdVnDyvm7Ag+NzN5NVN+z
 in3ZV9rp/wcWUeSrNUKV0ND/OKUIgLpMkMZo29Rozgg1DqQsRX0LHWeJ9eySi/pMIhg==
X-Gm-Gg: AfdE7cmMqSqclgzv2EUvk2FoQCktqjN2iG8mwYIo6wpLYRzydUSNS7vx4vwP9Wuwmcu
 rLKkVvLi5GlEEmMWj9ouSETHF1jGRn1n1Ks2xlq4VzCHWdi0FnS3Kkzt4PmlJxXGvxDYt+pwadN
 4OfKKUpIZtz3uIiuhV421/QOrTwIjL6WQ+LSQ5YmmKOivwih2uG4bnozYFVPZsZv11/hjdV8VNe
 ST9XWSUKIGJES9JiWRDRQik5Y8jf8ZIrlTqU3uwdv4BmlFitZjN2jQT2Vp5DFvQbd7p3q+ncjKh
 mQcssxnm4Ygc2KelLj9sgwioLpaTBcTFux9wUbpA46cJOfOvZtgFnl1hOML8xwDN/UUGoruerkC
 lEU9wPd9jwdvArmKkoTXiqamWb/quxwWrnQe8bqVk8NNS2EK5Qa5KHxWsxwbVEWUZox6yPhPHK0
 XcH0X+ag==
X-Received: by 2002:a05:6300:4046:b0:3c0:eeb7:28b with SMTP id
 adf61e73a8af0-3c1102d7fc8mr689961637.8.1783719893298; 
 Fri, 10 Jul 2026 14:44:53 -0700 (PDT)
X-Received: by 2002:a05:6300:4046:b0:3c0:eeb7:28b with SMTP id
 adf61e73a8af0-3c1102d7fc8mr689940637.8.1783719892840; 
 Fri, 10 Jul 2026 14:44:52 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659c8665sm43539840c88.10.2026.07.10.14.44.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 14:44:52 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>, Helge Deller <deller@gmx.de>
Subject: [PATCH v5 35/98] tests/tcg/multiarch: declare system tests
Date: Fri, 10 Jul 2026 14:42:39 -0700
Message-ID: <20260710214343.2065491-36-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=ELM2FVZC c=1 sm=1 tr=0 ts=6a5167d6 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=8vYM-gic8w0O4C_0kjEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: WZ8F1xCWEflGKZYfvoh1rkuYW_J5F4gg
X-Proofpoint-GUID: WZ8F1xCWEflGKZYfvoh1rkuYW_J5F4gg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIxOCBTYWx0ZWRfXwFDxJcAv74jM
 7fUS2PH2N5YpS4+PXSGBU4aI56ArBtKPnXd+7nI/ywIvRHPVO/Vdb0+E/6E9cwQ6RSuJpKqlF47
 tfNvvASyNWmWFgKjy84OPmPAwMt5ZAIBxyDrMMzPR4eeVAn9jb8eBfdj6RNONFvdxYHz7u1KWAo
 yeSlmVbdGDz9lqGHYakpuRKpvd4ODR7nCaeA44EWRpYfPGA+jyXNKW4stu2q2AWtlw/ccZ8YZAH
 AFxc1MSCC1e9CLBWHMaKb5q7i04jrQMXHv7GtpKrjrLIs3hhaLtsfmcspZh+1J4mqaGK2zkBMxw
 tjLbIoXVRn6gXTKxAYW3mM+unXjBSj4ddqSIUHK43sRQSnDk/vYZDChSZt9Y5srWG2avz4WbqTz
 WeMZgjKnysTNiNNJd1tCsDa5MyxGbwTFZkeh5D5g46tN3bVenRd0IGF8CCuHB5ZdGHrJfzmKGNJ
 o7MPftshkyJIni0cTJA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIxOCBTYWx0ZWRfX79zaqRECL5HF
 FxjPSxVt288eV+Do8Cu3yhKV2bwnyd41JcSpDtRZh9GX2vIzFnRdL3Qzokejcy3GIlTnbb4FQzo
 HDGysA8c5gqPVsMkqhdjKvx6VV7b18E=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 spamscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100218
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

We now declare all multiarch system tests.

Tested-by: Alex Bennée <alex.bennee@linaro.org>
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
2.47.3


