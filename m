Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6971C44501
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 22:36:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgrtu-0003AF-Jy; Mon, 06 Jul 2026 18:34:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgrtI-0002jM-71
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:34:20 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgrtE-0005Qv-AD
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:34:15 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666KENwn1496094
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 22:34:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=kjEUp/n6jiw
 QfIAf7J3w5FMX3+YrL9zmDf74W9JK5Pg=; b=B5EVE/yxfByMQbagYetJZcVUyMB
 PTM1KP7Oi/q1dMxfdQ3SQhPO/L0STaCDBW1YLXhZpR4H8n18JyF6MWiJ5uTWwhtI
 SQiRIIp6oRCIbFJHURYCIZ26l+mKBT1cx19k5H6ZlXJAcKw0GlVgz5an9P8iwyhU
 x6p0GELxj9khdhMrkPs6A+3Ess8orUthh+bkg6TAYrie0qvSQFudSHk3yqpOjfXB
 ROi3hzP+ifoilBILJPCKFMnLGGcmQJSw4qfUd16bpEalHKAFCCM9t54MUY77NBVl
 akn/SIZOHfA6oVI30fLE0tvW7jftdXzJwXUUqUqwXvix94op4ijdNfgEDng==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88t8bg5s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 22:34:09 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c8620ee0971so4114198a12.0
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 15:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783377249; x=1783982049; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kjEUp/n6jiwQfIAf7J3w5FMX3+YrL9zmDf74W9JK5Pg=;
 b=YY0EOAzItQEZYvdzJz+tOXM3ZawYxV4ajZEgntCV70BRNrmYyRk/ZnFTZQ1Le837ix
 n6Uar3VNnSnHXDiwGiE2Zps1KiF/syor8EW3y4M2FGrINYJijnWGidk/9JhnRTIgycKc
 B1l4B8qx73jvZhOGN7khY6jl7Y8Wvc5uSRoeHfwmYBdO1QwXNHqcZajgiY1b4oeMRaI5
 vaZg2fWGXdOpu1slAFHI88Nxi7q+b3lxrI0Hm8MLiJUPD2P3YPM31zEBNZxcnF0lqKJm
 WNcRMgnuvhQda9MwTM+FgcK9xOCPqmR+dLumu1uD1Tg+2+9jtnnoYddzr2CeUO0lv4e7
 KFWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783377249; x=1783982049;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=kjEUp/n6jiwQfIAf7J3w5FMX3+YrL9zmDf74W9JK5Pg=;
 b=My7kJW3hkI1CEmCtwHW8HsxWth4OZusmT5urFUeF4AQtByUxOi7EWE0DSQevlRigwA
 vN1uy1M1+4AXC7C23DUNn/6x398XqhWZkvHE1n9KhByaQBzWfw7MNJktMAa3QajEkpq8
 uf6ZNKsEKkEZhVFyZpW/ROCWEEOef3V7qKhv7F0zFqZbaDVoUd1/HGfVRuGh7yV8iu9D
 OQ6uIB6OR+ZA6EC+ilcNji83s/6JxKvvr2ZpAfexiDaVn4dNA1htS4HD5VsjdCZtTd+r
 kkouB98XQp74oQxt4UQ3nyv9esKkn8yVsM0FUkLl4VJqLCEZ1bcGy6JJWORfeW1VixwJ
 d0OA==
X-Gm-Message-State: AOJu0Yxqg4+S7lDXnx/xB05PzU1DAPkRZBSRQ9MVS2n0QsVI2VG9YEO+
 4DX7Q9PYtUnGCOlxBH9/oRj6jNbEUeAUhsgSnRxsEEJWDjB+fM/l5UtwRlEX3ZNFQq1qNIW0Ph7
 UjhuV7ZpjHtLIhV1PCRRS6ZrM17GRE9150iCKmYfQFbUobqMY0zRSCR6kWD3VPYCmUg==
X-Gm-Gg: AfdE7cmp1KB6yDnDCY++8FyI+TDJR+cb3WBxnFJV/WZ/zX5SjkLQbYfhER+GRcjITtj
 uZTss9tmIz8+LK6pr3Lcm30MTbNp5spf+2r6xBe4lXGXvktOCB1d5yUNAaZg+bucqsP7+8YzRQ3
 oor/+w3SKwNWhL8kIaSu8usSYF17atFdx5yAxmvKjuQX9t8woN7I2u+JUkTeJJC+SjrPBxA/VH1
 Wj4wxcaNSMU8FfFswG2X9aupuCJJwdw3CVmmqoAVvgHFIINjEoKZR8S6RwX9ffj7qwjPu33ON8d
 vMLuKGOn2rwyogelKi4qFIfCthYKs4+XZOM564AVQ68bqUx1E7poocuyNx0PoLVtBXfaXMS2RAB
 +QqSKaukuhdQUgWTYnJF+NJZTslsLn4edJ7aOmtETxZdL6ZY98cMyEhQypJByImxSkQ8D5NhHdR
 ALeyrQ6g==
X-Received: by 2002:a05:6a21:62c8:b0:3bb:21ad:40d8 with SMTP id
 adf61e73a8af0-3c08ee50357mr2984461637.39.1783377249422; 
 Mon, 06 Jul 2026 15:34:09 -0700 (PDT)
X-Received: by 2002:a05:6a21:62c8:b0:3bb:21ad:40d8 with SMTP id
 adf61e73a8af0-3c08ee50357mr2984424637.39.1783377248989; 
 Mon, 06 Jul 2026 15:34:08 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31174ac0557sm977244eec.26.2026.07.06.15.34.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 15:34:08 -0700 (PDT)
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
Subject: [PATCH v3 11/91] tests/tcg/meson.build: introduce plugin_test
Date: Mon,  6 Jul 2026 15:32:23 -0700
Message-ID: <20260706223343.988769-12-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIyNyBTYWx0ZWRfX95EiVKBySN0K
 Rd5EsFpzqt9sjP2Ozzs51YC4/2Q/DMYvDTTpY0sTxVeY+k4i6QcxxVJFqi33qnOM7s3WWtKlsX8
 SBhhshIlcJjqPPNk10Hxmzs0MDGMxok=
X-Proofpoint-GUID: 0R0EIure6Nr2TfQ5jQsZjYQchAzukpd8
X-Authority-Analysis: v=2.4 cv=C6zZDwP+ c=1 sm=1 tr=0 ts=6a4c2d61 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=FL9xWchk2ML2cDM3uvcA:9 a=bFCP_H2QrGi7Okbo017w:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 0R0EIure6Nr2TfQ5jQsZjYQchAzukpd8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIyNyBTYWx0ZWRfX8HhBv2s5AnEX
 rqmpPqkxBRAvU3N2Oxr5eckPYkD7Sbz79KGxFAOlZX8uzfWdATxm/LwXVdi3zWiB4QHONyjk3Vu
 HGUap40bCN/qRjWAfG2VngzdA0dh6g8SAUlQdcrXWWpY0PQCWA//NXvV67MxlsxBWrul4AB+4ae
 psPni/UGMxYPg8UeN5uw60kmwYHwCqi1ridCJqABSGAWf/p5b0mZFVXPYLFyshUhbceHDo37P31
 Zti3ZOhikAV05rRZ5TbOPb6TjZSqWa7Gnsrx/cwgezKdx86sBv7Y5/zTCV104Q54KiZ5JdcAynE
 7iH51NoyzQzhCN5+hMgDHevHfVT+IlRHwm6c+gYXk5s8KuMm/kH57UZ98Vxqiz8+V5Okll16w6a
 DlB/OnheysFVQizOje0HF9kyu1ddtVWiT6McC7jQnMjXVEO8T6GNiPiM9iBpPRbJm7UDPdjOIOM
 BmF/S3P3uYm6g25FfDw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 clxscore=1015 spamscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060227
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


