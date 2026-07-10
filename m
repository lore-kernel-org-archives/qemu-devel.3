Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C74DEC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 06:22:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi4bd-00018M-0n; Fri, 10 Jul 2026 02:21:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4bX-00017n-TZ
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:20:56 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4bT-0004aG-7L
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:20:52 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66A3nS4p3848786
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:20:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 T/FAm1ugWwtG4w0qfTtU/pGJUoDQeE0ss46D7FsSX5o=; b=lza32kHDddMAoiFz
 kFIsfgh8q2zqE3+XhutN2tAiaZ38l4Frm04nKT0rovNo0qzmlYs/D/8ujv2ga+up
 jmmVWg2oEQbXV18aUdVyiWldHHrb2PEOgxJbasXtUUx+/Siin5DWxFnlXJGeDLYk
 44Fr58DwGaVmTgn4ePfmHBa69dE48fsv1s5gHp5iLpdFc7U1kTV7pXPTvif9U08H
 sRTVwEga6U/b5IxTL7DxSLbDubqu4a6SqTE3h0ycREqU+N7OCdNfeaVdxzP0IrRG
 P3IrMNv229hAjxvkXRlV6R4B0oozVW1gq9Qvfi+yBKmPRLCKdX5HJvnLHDtdsMBj
 c8f/9w==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4faeesu28v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:20:50 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c85798977dcso937397a12.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 23:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783664449; x=1784269249; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=T/FAm1ugWwtG4w0qfTtU/pGJUoDQeE0ss46D7FsSX5o=;
 b=P7iQtYVmGw6JeYBxzczmubdDCXXfKmkc99fBKsqkrhYMWPzHb1ARmTWgRXbrumMA87
 ADVJTw837TjLEFDn7kEgmiJiVO1zk0gwOmqdNnCex891NVX6fsuYDZUBaptJyEuNYs5d
 mNAfMlpR+Zj5Fa3fYqAyqoyALdLyo4GSpJkUPMx8s4Ye71M9VWrOtRxj/WjQwIWk0LAO
 4CTGcCaBuQMNuqOL/6STVAYQZdqcuaH3vyEW+sV9VidlZsvNynItR898Fv1dhRy4WelT
 6zPRozz7ykXPUi8y8O7ZEhHS+EONKJALN1h13mmQjH/KEp6lFwnrsdNChrPUOclezmin
 3+kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783664449; x=1784269249;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=T/FAm1ugWwtG4w0qfTtU/pGJUoDQeE0ss46D7FsSX5o=;
 b=gDeivCaGa5ZPfFEgfMusbI2M+ntHIZuEHvlPMUCJ+SZTVaN4GaV9yo0NUYqtNE5efc
 GEQHeXnVXmz8ESo1/w6Cuv2MsujxqH1kzSftwnbrjnsd3NlxZGBRRqyy2z4p4gMzdhQn
 X9kgecgzc/Pk8SQlrNX0T8/I+cH9qRLSgSDbbivYWAEIYIHzTM3Z0HOi38SxdQjRPdmg
 FFaatVwV+YzXy3s3ENMCXg2Paxqqd4aYOvBt4RGNEBH81pFoYq1Xch0ZmPazGTzcn0VE
 b8ggHXEOQM+Oe4BTcm6xUKcZifNRSaX22J6bBfJ+QMWR0CBycm7hLYnWd+MiL3GiCM6C
 lTHA==
X-Gm-Message-State: AOJu0Yw3tg/dU5Kr5upl7hy+UoQMtW0aXIz9PXeQzut7/EDnHoFbwsev
 DUQEgf28H2SSIwzdsTwhY6ELk/UlQzXFWJ/Jgbi2/Cz64xtCOmGaCB3zvt7ZpQ28BdX53q9F6+W
 Ze6a9QWg+G5ZyTDaIo70p9pRDmSuG9hIzl/5559lle2fwvcfBSIABTgb17x4dZE6sqA==
X-Gm-Gg: AfdE7cnnJkscQ98MSo6f8Ex2d993FIg92f0TtWt8mrWcu7GriNlv2XuNnF7dqJh0490
 8mYF3rDOEk9lIru6npdzJ2S2W926+SmSvdAueZfC5FeXi2C9r+KOsiSz47YkyXElYXLxI9aNwgo
 BJFOUV4/TcV3sOy13MtAXYf/KQK1k5RHzHXHU4LgTuHrhvA34c3ChhaNzqwBTv5e4Wr4rrIwKUo
 +bY/OxBtQK1v2Zl4qt0e2UCX4dvcN8znlliAYRG/rpC8/oZxtA5magb5sA2xF8s6VJHVM+0sPhi
 ZZCHNY9QwXCnCzIsBkBshNaa9Abg95OWyv9ABbq540GGZwC3iu+l6pt82kfpxx3tif8Ub/xvhxw
 EWrUGryX9d5i3Z1ZMHZI7gKZrW8xRPWIf60IfoMhI6IVlrDKCJIrWiKPEzYqfo1st/uDprCkxQi
 tZ0G9N9Q==
X-Received: by 2002:a05:6a21:7a43:b0:3c0:9c19:65b3 with SMTP id
 adf61e73a8af0-3c0bd3a358bmr12544144637.75.1783664449251; 
 Thu, 09 Jul 2026 23:20:49 -0700 (PDT)
X-Received: by 2002:a05:6a21:7a43:b0:3c0:9c19:65b3 with SMTP id
 adf61e73a8af0-3c0bd3a358bmr12544111637.75.1783664448788; 
 Thu, 09 Jul 2026 23:20:48 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659fa13bsm35428126c88.15.2026.07.09.23.20.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 23:20:47 -0700 (PDT)
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
Subject: [PATCH v4 12/97] tests/tcg/meson.build: introduce plugin_test
Date: Thu,  9 Jul 2026 23:18:50 -0700
Message-ID: <20260710062016.1818125-13-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: P7CRiPscIV_6CF6qCMbAR1Zk7p_JZSJB
X-Authority-Analysis: v=2.4 cv=bbpbluPB c=1 sm=1 tr=0 ts=6a508f42 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=FL9xWchk2ML2cDM3uvcA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA1OCBTYWx0ZWRfX/X5N6F8VBhEF
 +/wJF0JpBfxHt159wUqRC/5G1afPjGYRb69ARTehpmnoLxU/svzmPb3lpapE+EqxrsTBxvGjcV/
 53z5Jb+cSj1SDhtL2m44/9CQBpvSe0M=
X-Proofpoint-ORIG-GUID: P7CRiPscIV_6CF6qCMbAR1Zk7p_JZSJB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA1OCBTYWx0ZWRfX+s2vpd+8zrvS
 DfgrJCM8TsSgAmSqn9NswUf8V0uGxfpxL0Rv1nJcjfIhkvqHxNW1dzoMJicSHkuJQNIrcVf3Qx/
 MSUagHz6WMOBpCoOdfKKNL8mwoNjNgZAug0Nb81uPyAhLYqZatc237eqZh4LIMLbumM69rfejbO
 3kybLnpzZy6AsfFAVkv8ANXeIca3+47wValPny0IDqfmMN8491Qale5GtUiqb6l3cyQPoCzypRm
 AwrIWt5EsAN8URUQI7kjWG+Reh9USJ95LZju357xWUCTIuZioj+OgSQtxPaH4zgdgov525A4hZv
 vZTe/enilquDcKRqLBgK6iBhOg9/sAPpNbk8qxvdKQuinEekwHgUmh4xFj7UI7Wrks72h0H03ba
 vbM/UB3YGZAaVfMqhpfzukGFHMpRA56BclmaVJD8xzLhtstawKn2V6VHCQoUTyvh8endC2Fej4u
 X2yYqOwQtQTryu+Fsow==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_01,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 bulkscore=0 suspectscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100058
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

We add possibility to declare a test that is based on a plugin.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 43 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 3edb525dd12..9b29669977f 100644
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


