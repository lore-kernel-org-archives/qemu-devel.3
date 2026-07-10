Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55874C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 06:24:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi4by-0001RI-WE; Fri, 10 Jul 2026 02:21:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4ba-00018Q-Dp
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:20:59 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4bX-0004cB-MB
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:20:58 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66A3mxLw3629952
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:20:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 yCoycqDuPEBhpaZECoOk64BePL4QbbdOMminAIFWLcU=; b=PR4MXhR+ADmLkl/U
 ZtZ8mltQegaHr/iCtGj20nOGP5KBBIhsnjarC47UTUpKbNjwnV6L/tPw+jKx5GDQ
 oCj5Xgyqsn3ysefjUg5m8HTKFHhFqOeCs9WOTvynZRN5EgtJIoJik7zgZLh3swt8
 +Xb3mNDmSZVlXh+5CIlXm3DNQ5CDfXPEOMYRK2hiXx3hvjLS4bJoh0yhvi9g0Fuw
 FGHW34aWKbRnpx4p2pziDwgvvyLajNoP3RRRBryMn6gn9ch3EAh+rCQGy6TPuhZc
 wg1hz2it/4qkIjU2EpzASOLY5+qoPvBbC6GQz6HVbuCoMwYYisPhvO84566VLeNZ
 whg8iA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fahv8hwux-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:20:53 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c88aab7c1fcso1031211a12.3
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 23:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783664453; x=1784269253; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=yCoycqDuPEBhpaZECoOk64BePL4QbbdOMminAIFWLcU=;
 b=P2FWqNYjq7KX2IqAcMCR60rYxG35ARB8S2B+dQLeF7KwnnZC8EjqGTl+brSUuzpnqe
 8h82eioOtDk6/vmtM5qQkJtsTSGYOOWM0gdJKTJqarDLcEY3y1YIxHWliIEMJrHvEgVi
 d2XVJduDiqDZ9odnACZvxwk/WnaBv2nSuJcM/IbmOQEyuXLtA1IVF4OcX+eXdypEmKig
 IaSq7/gX28Ntf80Gm7FNW2VJZtI129DWxdAy6Pl1KJ7fx8bwNr4d7uDdIZG1LKn6dmGW
 17Qt+komG/sxIOklquTBSVJBEhs1W/lejVkv1u2jiV5TZkygulJNgk7dYv5WOpIcgj7Q
 YVaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783664453; x=1784269253;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yCoycqDuPEBhpaZECoOk64BePL4QbbdOMminAIFWLcU=;
 b=Z26T0L1mBA8/a1xSDSY3bUVlZHTIlz4F+HwwCsatjsruuyCjSD8KVoee/waV4mY9fq
 d1vGFdAM1AgGMeKwdjag+THxsGI660RK2T+Mozw2UpnJY+aSGoZRG+GzbylfMwS7VXKg
 bBOaRw+EQ/IoLbOpwn6pTKyiZsQHiy3hfFQ+1u1JkcuK7Sjj+4HUrTN87eaTvl0AHg5V
 6dS+MF/yXTspRLcopBibuXrLKuZ90bOQzKfhbfytXOXlJuR7euyCIfQvSOqunWO9Isvd
 GcP2FpU0uKLl9BsOwSMvX9MGk2nM8oJ40fjZGgYYGbyz8JWJXWxU7NZk2lgGZZkeBlqu
 85Tg==
X-Gm-Message-State: AOJu0Yxz2d3Q6QAESjxqfFr5v4I+ClXlyo30DCyCC3Vk8553uvHDZVKl
 OBYjNalkV8+TBgbLQF9DPYT69usmxTfWKSNmttw91H6sngKkzWXaT7QhOE+m55PAyAo82E1/xoj
 7TTfE5pfAy2B6tfj2gvtioIOyLvmESjbE4d3Bwvvwj4vWV1h48Lbt3xcmJXWKL3IzIw==
X-Gm-Gg: AfdE7cmxi2D3Aoe8Qj8K0UBQvMFBD6Z4V7sCo2LOMytbH4CMSNu1sEzaG7BNOTVa+iJ
 4Ed8+oVjRD977Ues4hbu/BvnSxSqVWMQo3Eu/F47WFzJ5eJN2TJJMxdOgGwTtA1n+vQwUsPO4ve
 y+A38P+bRN9HtCvrTL221wrwf7ZymOhCtTlsyzGaHoIzCsKQ00XMNgWXdgu/5vJSgN4Wne9nFFR
 tX85U56PpC++rfBrWHavr4RFfSFF67fRZud/PPelrOMp8wsFtQPi+UWdPKU90A9uXUFU5zYN2nB
 6CjHfp9/xlI/JYFMNW8YZ/+47QPwA8AI0u5+0+jlMRz1wo2kagwHPPRtGZJACnPszvHY3bAHwSA
 9SY0Xy7a/fpvYOMutIsyiqo3CZBtCpu7/Qi10BpTpf4WQwOu+6il1XJ+9a82UWGBdO/qEYgZ4D0
 tZdCvc+g==
X-Received: by 2002:a05:6a20:7343:b0:3bf:76d5:cc2b with SMTP id
 adf61e73a8af0-3c0bcec1928mr11645782637.22.1783664452722; 
 Thu, 09 Jul 2026 23:20:52 -0700 (PDT)
X-Received: by 2002:a05:6a20:7343:b0:3bf:76d5:cc2b with SMTP id
 adf61e73a8af0-3c0bcec1928mr11645739637.22.1783664452107; 
 Thu, 09 Jul 2026 23:20:52 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659fa13bsm35428126c88.15.2026.07.09.23.20.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 23:20:51 -0700 (PDT)
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
Subject: [PATCH v4 14/97] tests/tcg/meson.build: introduce gdb_test
Date: Thu,  9 Jul 2026 23:18:52 -0700
Message-ID: <20260710062016.1818125-15-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: BF4-OnNDy0L7bLXH3sDbhUlh-V-TdYQA
X-Proofpoint-ORIG-GUID: BF4-OnNDy0L7bLXH3sDbhUlh-V-TdYQA
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA1OCBTYWx0ZWRfX8EhyKGUTtX6K
 ++u36JUQxqCV2IeuIc3P5sHBFVFDkVZ0+bKxhx6sDCcz7JuD9vMK3EhuzTUtx5HbZ9bpeyDUME3
 GmT9Ra1fTIctU0LF8lHdzNscZDIkykk=
X-Authority-Analysis: v=2.4 cv=funsol4f c=1 sm=1 tr=0 ts=6a508f45 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=ZkoTrUv0hqWFqrPu6skA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA1OCBTYWx0ZWRfX3gvB2MbBkFe7
 nvpvme0I8M3A0itWY2imuWR4VUOI7u0nN/7aYQGCKagv8W9SKqjWMGKZ6lu12x3yFZ/ufnHuHfL
 R4MVTWl2SxOSurKebD301pX51T97Wr0hQ6uJ/ccQzn3htY2C02tnUqA6TK93BT2HIPaWRP7bdiO
 2dfBqFlDLFu9scodZlp2dcUXCfuy8UxZUYE4XVNlT61UJ8YfEUM9m8tsK6URJ7hDV08c9FMibfh
 XiWx5cy48r+HQKX1CYL2IS6FG20R93zLTWmcb755bCKqCe9l1/o+06YoY7cxV0D2ZmNHTq4mk0M
 8Jm64Zd8y/9g2FcfZ5/RW/DNYRvEMIQ+36herl/USVurFg6RDVE0Zr7IN9JG3H0WVdh5LOec/wR
 XtaGuAvyp9ZrBP9y1pfVstmaHEsqjE9W9zvxR6kkufaiSzEcAFZthKxLMaSi8vQGQlVehe+xiTt
 yQFcrpTB/rAYbPLmNZQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_01,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100058
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

We can now declare a test requiring gdb interaction, based on
tests/guest-debug/run-test.py.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index b1655f5200b..7b439ee027b 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -5,6 +5,7 @@ if config_host.has_key('GDB')
   gdb_progs = [config_host['GDB'], gdb_progs]
 endif
 gdb = find_program(gdb_progs, required: false)
+prog_gdb_test = find_program('../guest-debug/run-test.py')
 
 tcg_tests = {}
 # tcg_tests is a dictionary with following structure:
@@ -22,6 +23,7 @@ tcg_tests = {}
 #           'test_name': ['provide an alternative test name'],
 #           'cflags': ['additional cflags to compile test', ...],
 #           'qemu_args': ['qemu command line flags', ...],
+#           'gdb_test': ['gdb test args'],
 #           'env_var': ['VAR=value', ...],
 #           'plugin_test': {
 #             'plugin': 'plugin_name',
@@ -83,7 +85,7 @@ foreach target, plan: tcg_tests
     foreach src, setup: t
       # return a clear error if user misspell a setup entry
       foreach key, _ : setup
-        allowed = ['exe_name', 'env_var', 'cflags', 'plugin_test',
+        allowed = ['exe_name', 'env_var', 'cflags', 'gdb_test', 'plugin_test',
                    'qemu_args', 'test_name']
         if key not in allowed
           error('unknown tcg setup entry \'' + key + '\' for test ' + src +
@@ -102,6 +104,10 @@ foreach target, plan: tcg_tests
         endforeach
       endif
 
+      if 'gdb_test' in setup and gdb_arch not in gdb_arch_supported
+        continue
+      endif
+
       if 'plugin_test' in setup and not get_option('plugins')
         continue
       endif
@@ -118,7 +124,9 @@ foreach target, plan: tcg_tests
       if 'test_name' in setup
         test_name = setup['test_name']
       endif
-      if 'plugin_test' in setup
+      if 'gdb_test' in setup
+        test_name = 'gdb-' + test_name
+      elif 'plugin_test' in setup
         plugin = test_plugins[setup['plugin_test']['plugin']]
         # remove 'lib' prefix
         plugin_name = fs.stem(plugin).substring(3)
@@ -182,6 +190,16 @@ foreach target, plan: tcg_tests
       exe = built_tests[exe_name]
       cmd = [qemu, qemu_args, exe]
 
+      if 'gdb_test' in setup
+        cmd = [prog_gdb_test,
+               '--gdb', gdb,
+               '--qemu', qemu,
+               '--qargs', ' '.join(qemu_args),
+               '--bin', exe,
+               setup['gdb_test'],
+              ]
+      endif
+
       # some tests expect QEMU env var to be set
       cmd = ['QEMU=' + qemu.full_path(), cmd]
 
-- 
2.47.3


