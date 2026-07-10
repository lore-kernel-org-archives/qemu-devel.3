Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2AA4C44506
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 21:48:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiJ1R-0004wq-Th; Fri, 10 Jul 2026 17:44:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ1Q-0004wN-Sk
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:44:36 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ1P-0003SQ-9q
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:44:36 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66ALCwqj1931899
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:44:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 UxpkHnsYG15XIOwt2Igl6sOiUGb8GNbbD8oNvOBguFo=; b=HnSehx8SQC2WStwy
 8cGXxV9CQdTxSVtQjP4T0UB3oJ7nL55l8CqsnHpTjCnsnjQjpcZFlEK1Lkyh58b5
 Trut5zcsHgGWrnfmzPtKElAjnpQ82Nbcx2PgMFdOmuPEjFws5iTeykFqm2j2mxc1
 y1eui2mmURYhF7H/G7SmbCWHXx99vLAi22GzjBdEDvkhR8ogKY2UgB/jjBWGjMQD
 XF62IzecsI77lXZD2C/W49SHLqzmgqm9zoQuZ25twYuaJele4n985FVog18WwbEA
 aGHD0LCu9UfXel1FRZg05hTNyWWc4u8+v4jJ1XkFakko/lIaf+ajC3ynQocqHmkg
 TCdkVw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fb8f2r2jn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:44:24 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c85798977dcso2022640a12.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 14:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783719863; x=1784324663; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=UxpkHnsYG15XIOwt2Igl6sOiUGb8GNbbD8oNvOBguFo=;
 b=H06zkFfqV3vuRi+9ErrVoSqyZKoOqF5ckkHcxvINOc+JtQ0lsqG/hS3mV1YeCX2FIg
 X/KOzwV4rX2B5yeUcX872AtrTrOY0/hpb8rotFzsDd0pfsGockGtN17XFPFq0NTUwHV0
 BqA9nxeZ53phO4cl1S8//F6KPub+flBAmCfw/zdcT5AVOsgmy2CAcl2+LOU4CZPIScgr
 wStIV4W8AZCClUJ55k1YfTXCeezsC+3LZusMDpcg6JCGG31x0tpPo7PwYCXSimQCtzQp
 xiEjw2r61xRMtBcsKKTr0jn+GvRFvmbXu63IeoIV6ZwbhTeYVgXpWA70p6/xtm/ndppg
 Ddpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783719863; x=1784324663;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UxpkHnsYG15XIOwt2Igl6sOiUGb8GNbbD8oNvOBguFo=;
 b=Ynbi5Fel3pMuf4T09dmnUo5L463g2pBNhicZ7mfH/BvHFo98zLyQF9HiLESyEydMx2
 u/gKwzyZJgrCDCYUX591MSxEJWfW8wMxwbjF3hFXBcC0KFLwIE7Y06FVjoCIwPdoCF5q
 FJ4fTXyYWBpjnkspUaXNOEalnaoJwfREab9JbjCaIhez3BgU1VEP/OOfJ3H0E6AOOYxD
 cmmeC725z3xARGi/0TflmbvHnvNxuLXUqswmolOKIhQgHuhA0EgMru3QPUOhr8pCBIUI
 /jbAaI+QzWw1FEtsAU0/8JHYJ5k4WoCV+Rvw2XQ/L5OCbs2C3DJgOaPYNzJYNrN/dXUh
 PtPQ==
X-Gm-Message-State: AOJu0YwQBP5M7D398hsJahH7gYLjHRkaFmUQsXQuyk1nYUGnuNm8fMxf
 VU56ZnSbxWfbkR4EAgaX8XSaVxlnjJSNcvslRieTs3S4iKuz8MGNm1o8sndvmaWgQ4L0wCWjqZr
 LsO5iqEaxLy9/suISq5bahbGYNJ0fGd+cz3bCJVQnmYytZCYU7827IvtsCmvWAikwAA==
X-Gm-Gg: AfdE7clT47a8lESMqn3heNPY9uBODL3Q2UTaQk96zJNrRTaRNRVE8Or4V59NOuyArwa
 FAuS3Y7tU9ogfOqbkg02af4dpuuRRsj4BlDiXblMrTVa/uMqjwrTaVYxCD3NbBKlVqdvyNc+rwr
 gqltW7U1SbC/suy0om4OWz+GbUiYeJ7voAf/wcUT+U4CYGz+eckLkTwm7Ez8eeDjnqQlTsYK6uO
 rIEDdnK4vpauvcVagd6QkaBkQ0oeM6LSpYcoLZLDWP6vhcUjBg95LhTsbqrlUMq5h4HLaTOLx9O
 jY9FUCtfF2Ec9bPmTu2ohUxO0fJSCtYBhjYTtkHWv6oVxnJ7AdvYchaQwW4b3Z7EpOYHdIBBnq9
 vZJIFKNfWLLAMQUbZO/IsMTD7QlJUhZ3XiBYbi38UULNWAjrcCbWtDLVBMtv3jfY+9pLTjlTv4I
 oCCrp6MA==
X-Received: by 2002:a05:6a20:3d07:b0:3b4:b276:3650 with SMTP id
 adf61e73a8af0-3c110289537mr946380637.26.1783719863342; 
 Fri, 10 Jul 2026 14:44:23 -0700 (PDT)
X-Received: by 2002:a05:6a20:3d07:b0:3b4:b276:3650 with SMTP id
 adf61e73a8af0-3c110289537mr946353637.26.1783719862902; 
 Fri, 10 Jul 2026 14:44:22 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659c8665sm43539840c88.10.2026.07.10.14.44.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 14:44:22 -0700 (PDT)
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
Subject: [PATCH v5 14/98] tests/tcg/meson.build: introduce gdb_test
Date: Fri, 10 Jul 2026 14:42:18 -0700
Message-ID: <20260710214343.2065491-15-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=YLavDxGx c=1 sm=1 tr=0 ts=6a5167b8 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=ZkoTrUv0hqWFqrPu6skA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 0TzXxD-QAJgA6UE7HyP9pTh4TTUpfzZI
X-Proofpoint-ORIG-GUID: 0TzXxD-QAJgA6UE7HyP9pTh4TTUpfzZI
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIxOCBTYWx0ZWRfX5gUSi4NcD0F9
 EvINjiNsRJyD35MoSZQznnteh6x6rYsG1M192c4CEuu8RxOHZSruciC5oqelHD9SyRleUXUnX55
 iII3RD3i8Tiah0or4vgmXM4Cfi/sYGM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIxOCBTYWx0ZWRfXxNeW5wytLQq3
 cFGENAJpS7Jcg2FQQ10iHvJOH552A+tqjh7V/0OaZPqlCBtBohADoWiLpHg2XOn5IojHAYb5RHt
 /PCF7wUmlt+esMEs6EhtN9OYAPxmSpvvw5EoZ1qLW20e117o7wIpJjWo/9GQ1s7fHcK/JheEGwM
 D1fLoBdTa2cHAKzpzaxcnBkEBrnphpXGxIo8Q9aI9xZau+ADO/X2sFYDvnfIfa2Zn8vCSqad09e
 +EQIJEg237KVh7w4EOsDDWOgHhxND4CpgaDMfyPzkDocFeREpmUKgr829xNOiY8ZveNRC9CR6xW
 ZRSC0LV4PtRs6p050PJWWx6S7Hlq/nCV8Vf2s/6i/blqU9Ykoi5Rx0R5AUiEV0VWn/NMJrgNWEN
 W+XC3ltm/PvNR+FliIb8CgeJYtsmw5N5M12Bnx8qDci/G8rPTIPyiMcHlnSNZJdhu+iriiRNI/D
 Mm8ogH7FF/7PZoewDYg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 spamscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607100218
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

We can now declare a test requiring gdb interaction, based on
tests/guest-debug/run-test.py.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 3714fe4dc0d..76375615d0b 100644
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


