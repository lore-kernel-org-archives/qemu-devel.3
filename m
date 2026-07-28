Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 772FBC54F4C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 04:47:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woZfE-0004dg-0N; Tue, 28 Jul 2026 00:43:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZf2-0004NB-Pf
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:43:24 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZf1-0001aH-1n
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:43:24 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S3aWmi1714726
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:43:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 SJvp+gWG0lccHw0Gtl9HYeD8Iut779BkJs4LnH7izrw=; b=ascrbm+NE06PddZh
 50xNmgKg94NAcqN5MDB34V4aRgA1BXuMlj/0FaVJ0At/606SPgpAEQ+CZvHR1YIR
 YJtNXNOM8PINkIwa0aOzN/OVW6VtbztpdYUjlIqEY7jr1lR9iy1wygZrpvRwLoxz
 gAvm6IFLknxvAJVSiwwEVmgvrLs1t6m80E7eMayYKpQfUAxNJjk7HkV5mTwYiiyO
 B1kFhDx/iSBnDN8c+/0+DKv1xag6HCx1CHNyqKcadRLHkDQF1NtI8/fBfFQrgFZD
 5rwbBEX8vqjgOCbzjGQpx2TKNji5LXeE7S+3vhI7xcRZrZYCfLg2i+FgOC8tzDvC
 ScoVOg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpadkjxx6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:43:21 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c9c26587e67so528033a12.0
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 21:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785213801; x=1785818601; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=SJvp+gWG0lccHw0Gtl9HYeD8Iut779BkJs4LnH7izrw=;
 b=QDpHWrZPbogeP8MXBYcg2nn5Zxg6bdkArR1st49jhTY6gCGMRLN7XfSU8OPO8hqwbQ
 tj0vuWcFaD33dpOT7NecCdwImt5xbOsjT/OGPAAFVyd+74QHRlLzZhf0MH6i9RMUnoI/
 Rl8L00V39JTADQiLdFM8eaZrXhJrnS1Y7hBfGhau+k3fzCADLmnq4VgPdTV+Tu3RBV7D
 M3+poJvsTf8olpmMo4sXO4HFcz8e3h4ZvbFS5Nw768yTa6uV1Bj51xI/vRUzBq99oPx+
 yE/R+m7CDaEIHADqZekpq5ydtugOFkbdmrfvP+EFO81+uy/IBYAGiHufH3By5tGKFpMR
 vBMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785213801; x=1785818601;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SJvp+gWG0lccHw0Gtl9HYeD8Iut779BkJs4LnH7izrw=;
 b=m7ij6BWvRGxZhmxqkqmmiFnOkbvY7VD3LUTLnV1Kyt83UmTHBpKqZuKTbx+OT4kPBa
 inzetHLazHftNlZo64vXlRxf0v5NbXtJI95kJaKi7x0pNZcyxHhwYANGkZ/xeZ+ZUsHf
 Jbq59zS0N3Dt9oQaY/n8jziW6NcEH83z96piaPVg7HXq9E+x3Af2e8gIyXc4Jt9VUBOM
 LvGt6PE47DKCHM1KizytPiUDkg4dCAJ5HgjxuL89mlU5Qx5PKVjZqortFmp03WFo0T4+
 fvvrXPVnCoduZjrqvcDPgUS3k/7UKcDH8B1tl3kYDmOvjdWk7DrTdmihCEuMCu1/KqDV
 gGcw==
X-Gm-Message-State: AOJu0YxfQSsh/bDludr8JQZA4qRqfndxJ9UPFSP3lxSrX4qMKGbW/vxC
 m1xYRIXHJdsrFbS9c43g/hd/MvYg7gvQj/T30DUyCF3lnVNiHRnzCEENePIs29vSPoikqrkhDOc
 rwtBIGcaczOMPt0SkwQCXT0vxCq83Cb6Ulqu527VvlzuEen8BHVmnvUP1cYVyncOPtA==
X-Gm-Gg: AR+sD12kzi40iPc1B5ZUBq+JFipoUI6eZYcQDYtV9OTjNFKNEfcO32+gLfgtmu2FfoI
 Te/fKPQ/kP25dOj5vKiP6Xf62GzGARkUjm06iZCpBZdJi9fIkPficZZmf96CDXTqr3TlpvQgOXZ
 hIwqXi9+y7+551RCorJis5cqWO+AwqMRr4+E+bHDsNiqYaY4OgCXvCIdT3PwWHJchUK6cYsZsNO
 mN3lM95Tn8jkLNLUR573shemhVCOjqfEbGz2ZECbXT/FlL1Stxm/PX9ArhNADyZ2v++CQ11njSU
 D0CZGJdBqmqFHoBIpuMtNooovEUJez7No+I5lb+KRpNmdRShM3HgREMoQongSsWWIVtqHiwi9dd
 wALZCy+uBPnErNU2Cu2Pw4SH8/KPw4uaYRonroCxUZV+OQCbu/yOnCj8p/BeWm9ye5Emfs7Q=
X-Received: by 2002:a05:6a21:9082:b0:3c4:320a:737 with SMTP id
 adf61e73a8af0-3c8ba4742dfmr997798637.16.1785213801068; 
 Mon, 27 Jul 2026 21:43:21 -0700 (PDT)
X-Received: by 2002:a05:6a21:9082:b0:3c4:320a:737 with SMTP id
 adf61e73a8af0-3c8ba4742dfmr997767637.16.1785213800646; 
 Mon, 27 Jul 2026 21:43:20 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-314bc3e878esm38795784eec.3.2026.07.27.21.43.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 21:43:20 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>, Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v6 012/103] tests/tcg/meson.build: introduce plugin_test
Date: Mon, 27 Jul 2026 21:41:16 -0700
Message-ID: <20260728044248.137626-13-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: IHtDx-HrFrLwayyMcs3WaAM49vHgmzPE
X-Proofpoint-GUID: IHtDx-HrFrLwayyMcs3WaAM49vHgmzPE
X-Authority-Analysis: v=2.4 cv=Ns7htcdJ c=1 sm=1 tr=0 ts=6a683369 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=f31TsGN4npWs9EMxSNoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA0MCBTYWx0ZWRfX3P+UcSrYv6AX
 7MVz71LHqUiF/BvSeZkPAIpYQ+l+OYeIjVxCPvVWojLWu7rG1uxOyHf82huLq0E9GQ+0JbjAH86
 l1/ucNA8iRefBQkrKUKKHko24jiKyo0fP8U+HKtMcq8Tjsw7vlsUUQ/Hxr71+RppFv7iaOmzdLE
 xOlj6STT/ZHPisfbW4wpKIyAYkwghNY1pbblL888DNZd3wtfjEdVgU5ArVyocSTZGt/pjQ/EEq6
 SgdJsqa9G0UR8rNmPGN+U588ePUwhO3u+CzJdGlKScksLeCvY9sFLLQSjjfMXFtUDskzrg2QdbA
 CWbkLCPGQ9u0gX4EE93oLoDDNZdDuzL68bJggHRba1OqaPx/N9RbsXca9erNGyYoDgUMEoOE2qo
 ZtqDTxSPwcI6jABnd2VrL3SWxHToFJSiAowVXknu8DzIrZsOi3sKuE70COOhb7kYZfrXlqMLofI
 MEjoKSztmYWh4X+BHKQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA0MCBTYWx0ZWRfX2xTzWI620Z2J
 pwhOAelJW0mq11nwV2ZWGK/gJ201t1hKgKKCRAUZImydo/40O33JP1Dn+i5WOejbpfpnIFYQBS1
 Tf0NctVniCssb/PDQhFBB3lx1kAJpSE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_01,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 impostorscore=0 phishscore=0 spamscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280040
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

We add possibility to declare a test that is based on a plugin.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 43 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 9940bae80a4..7b51750b016 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -16,6 +16,10 @@ tcg_tests = {}
 #           'cflags': ['additional cflags to compile test', ...],
 #           'qemu_args': ['qemu command line flags', ...],
 #           'env_var': ['VAR=value', ...],
+#           'plugin_test': {
+#             'plugin': 'plugin_name',
+#             'args': ['plugin_args', ...],
+#           },
 #         }
 #       },
 #       ...
@@ -59,13 +63,29 @@ foreach target, plan: tcg_tests
     foreach src, setup: t
       # return a clear error if user misspell a setup entry
       foreach key, _ : setup
-        allowed = ['exe_name', 'env_var', 'cflags', 'qemu_args', 'test_name']
+        allowed = ['exe_name', 'env_var', 'cflags', 'plugin_test',
+                   'qemu_args', 'test_name']
         if key not in allowed
           error('unknown tcg setup entry \'' + key + '\' for test ' + src +
                 ' (possible: [' + ', '.join(allowed) + '])')
         endif
       endforeach
 
+      # return a clear error if user misspell a plugin entry
+      if 'plugin_test' in setup
+        foreach key, _ : setup['plugin_test']
+          allowed = ['args', 'plugin']
+          if key not in allowed
+            error('unknown tcg plugin entry \'' + key + '\' for test ' + src +
+                  ' (possible: [' + ', '.join(allowed) + '])')
+          endif
+        endforeach
+      endif
+
+      if 'plugin_test' in setup and not get_option('plugins')
+        continue
+      endif
+
       # meson '/' operator drops left operand if right is an absolute path
       src = folder / src
       file = files(src)
@@ -78,6 +98,12 @@ foreach target, plan: tcg_tests
       if 'test_name' in setup
         test_name = setup['test_name']
       endif
+      if 'plugin_test' in setup
+        plugin = test_plugins[setup['plugin_test']['plugin']]
+        # remove 'lib' prefix
+        plugin_name = fs.stem(plugin).substring(3)
+        test_name = 'plugin-' + plugin_name + '-with-' + test_name
+      endif
 
       exe_name = target + '-' + exe_name
       test_name = target + '-' + test_name
@@ -118,6 +144,21 @@ foreach target, plan: tcg_tests
         qemu_args = setup['qemu_args']
       endif
 
+      if 'plugin_test' in setup
+        plugin_setup = setup['plugin_test']
+        plugin = test_plugins[plugin_setup['plugin']]
+        plugin_args = []
+        if 'args' in plugin_setup
+          # add empty arg to generate an additional comma
+          plugin_args = ['', plugin_setup['args']]
+        endif
+        plugin_args = ','.join(plugin_args)
+
+        # since we turn plugin into a string, add dependency explicitly
+        depends += plugin
+        qemu_args = ['-plugin', plugin.full_path() + plugin_args, qemu_args]
+      endif
+
       exe = built_tests[exe_name]
       cmd = [qemu, qemu_args, exe]
 
-- 
2.47.3


