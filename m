Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6E39C61DB9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:09:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziFl-0007DN-3d; Thu, 27 Aug 2026 18:07:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziFj-0007Cz-Ft
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:07:19 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziFh-0003ES-QP
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:07:19 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJLoMe547107
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:07:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1TGLE4RQs0OGV9XCsf3oe5c9HqDogRlZu/fKVEARRAI=; b=Bg57/R3o7fIYYXKa
 KHy7N0/2rQmNztyYuGGoMMXkEp28aO5ezG5SoBId43o0OIkhmSZS12VfsZJrsvTk
 h1mQgV24MkbwPpKZNDY9hBdIpQWimeDPAKCkYDUiUIgMGaVfQ8AQHvFiqTmj76yJ
 2xaMiNEO3fs3TSlIoTsroFT6fTw64CQaoDn7ISJZ6K5CJFB1zFoGCNZ+UIPzYhiU
 CM2ZAsih/zYb/39Ynaohd7vMKHyf/E+eDgENqw5x0gnWht4aWpNWeZGOaqMuRCpl
 B7kUl433NbsPAASx7JJsg3k9W+QfZm+TLzzj13ILGJf22qm6jJLo2DQjQW/EAU4C
 f2OI5g==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gak562sn4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:07:06 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-84842381150so464324b3a.3
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787868426; x=1788473226; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1TGLE4RQs0OGV9XCsf3oe5c9HqDogRlZu/fKVEARRAI=;
 b=WaS6ijrUyoUp3C5GlDe3GtHyFJE3TUd9LDeYLs6pKX/aYoyiOimUc5rrnr4uC6E6pz
 L9rm48x6A+5o9Fsj6rPmtzbQ5mFRi9N7z7lJ5WMrqaPVrej9JMOAV16NGleicGfVbTVW
 yKa7/Nxxn/6g1rQEZW8ARDath120wVQekGsvllNIGom+0CJ7z+RUaFcXGogqj4cReuE3
 gzrBw+r6ybJHNhztxqvj3p4mzKxkQ4SrphD9qK3ORQMWDWcWG2wSYGTDmRcEhsd39pV4
 +1tsmqTJA4J4JYiydnNycx+tPxfD+bQ29DrdgEzM6Is8rMfg5Cne5YJuBT1RG/Ul2iAe
 kMTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787868426; x=1788473226;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1TGLE4RQs0OGV9XCsf3oe5c9HqDogRlZu/fKVEARRAI=;
 b=KVomqeBVozvwvFcy/U9tjOa8dfivGOU/ilIiZlA3Wtv6EqevJ/dOYAFg8yN9DeyL9Z
 YnibCLiJANAH+I2gD5sEPVg3lR6wkj0WMtfDN7NBUoXkHhwDAK5HdUzaqaNRaaNO+RpW
 JcLY+ZS4yjSKjxNO2mUlTxxQboXQz09FNSDPsZDkd6rStnO5mh60dX8pLXfFqme+UyfZ
 m3LgJJrUqpJNngN7RAIMjUIAg49AAf1ZnizcQxxAfogGLQ4RwmvF8t/y6yXwwOOcsU41
 mV+rhctLUMlN/J+yClnEjfYaE5RCSCYbMR5XXxfWhkyKNIlaMsyPuAUNvk2NyqW82QNP
 OG6w==
X-Gm-Message-State: AFuF++nLu+vTQ0oFhAO0SLqA9rIlpVixPB1BpcWm7poF3IgOxThTqsW0
 NuMwUKlPrfYaeXsJtndl2YPOb0iudH/qDar0gfe/L5CZIcYtlHyl+Nq0wdqH5uSpDemK/RKbBPo
 OFLIBe8BOyH6BTaBSFcV0/oTg6Z9yWqpC2hiCxkJRFxgbukkS9YQD4REJLBjKd6Cx0Q==
X-Gm-Gg: AR+sD101QmJEfXGF9ZP/MwZVt30bHjJT1LyyzrS71F3lUjk23yKVD9nnqrxMj1M7HBo
 4qh0Xp7kpeQExx2LmxSqoGvJkFcl6ui66XgX+KrQBvYt4cO+ZayY9yl4t6bzvqCr3JW0kfwefqY
 ya1RpkN1EtC3+DD3Yt2u6UMlcDLefBMf5k/bxqgvYS6yfNNJ+3dMqEQfChtPt4rr3a6s3XTO7HI
 O5N7am/+fCf5/Di0ZdKUkO+wC7Js48aP9q2SwTqTUDb+HeiGEpTd9XSXNCKenA6gya+4g7eISHv
 +UsfWI0Os//UqHKWLh2h2lGm/1e1uKZq/6EG7oV2ia5ETPkfbAyskt6Znn4+cPn2TcEpGiCuNNM
 9n28bnS8KFfRiK+abUTSPY0PZ/EaMpUISDPT4AF3/4cF6eF4DrAococFxra0=
X-Received: by 2002:a05:6a00:909e:b0:848:3fe2:c88b with SMTP id
 d2e1a72fcca58-85628c7d75bmr4752396b3a.6.1787868425881; 
 Thu, 27 Aug 2026 15:07:05 -0700 (PDT)
X-Received: by 2002:a05:6a00:909e:b0:848:3fe2:c88b with SMTP id
 d2e1a72fcca58-85628c7d75bmr4752323b3a.6.1787868425487; 
 Thu, 27 Aug 2026 15:07:05 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8535ced0f99sm2523713b3a.44.2026.08.27.15.07.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:07:04 -0700 (PDT)
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
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PATCH v8 012/105] tests/tcg/meson.build: introduce plugin_test
Date: Thu, 27 Aug 2026 22:05:06 +0000
Message-ID: <20260827220641.84885-13-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827220641.84885-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260827220641.84885-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfX/ik7lyUfjrf5
 /NJisuLnKxpCR1aScam1laIUSKEv8AI02bBF8rnBNuBIdwjnfPYAoNCNHkkIwTp/jb1rioz2Fvi
 TIHmOimGMApsrzsOLnA+50PFr+D24Rs=
X-Proofpoint-ORIG-GUID: 2C3s3GF0D0M7u9M5RaS1JULFE0VcskaU
X-Proofpoint-GUID: 2C3s3GF0D0M7u9M5RaS1JULFE0VcskaU
X-Authority-Analysis: v=2.4 cv=G+Ms1dk5 c=1 sm=1 tr=0 ts=6a90b50a cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=EUspDBNiAAAA:8 a=f31TsGN4npWs9EMxSNoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfXwrDDi0nfYGHw
 lINlkVpjaUAHk/yP11aAOw2hAmAqbS/d2R9q1hEN/IYSnCRlAPOLzn/c7km7wjEbRFIF3+5Hcay
 PzYxRdDKwVzNWsyBG27lu9eEjeonsOFReqsjOOgGjr+aX3S720MTM2A+hjsxFzzTsKFFJx0bPO4
 YpSkbEsSL/m6wbyxPQk6W9L1LdBdQrLDUcNU7NmVgQ/V47NAq+7ACiwZ3QurCygHOBkzCnXOiN2
 8AdB78sHgodlxRXLGWqwqRl3keYhWfXcpWD3A3IwY87RGWeEpNUfio1P8Mbr6ytVPxnr1kgnPTs
 Dy2j/2KeWeHMWzks9MU0HB/gaecxv5COUSqZw/s+oFY2EOeviGYFNbxrlpqwJ+iHD091ku3hgTV
 5kft3iWVvDocYoEkTdIdDsfSy3LVBjvl6h5Eu9CbRdLxSGUnmUzGrMPywokZnyuQ/nUpWJZXf97
 Lb2xT5ys9c/ro4od1Xw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_08,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 clxscore=1015 bulkscore=0
 phishscore=0 spamscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270188
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
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
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
2.43.0


