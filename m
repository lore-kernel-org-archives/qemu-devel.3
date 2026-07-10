Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64CB1C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 06:23:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi4cC-0002Xf-Gt; Fri, 10 Jul 2026 02:21:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4cA-0002TC-Q2
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:21:34 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4c9-0004nn-5q
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:21:34 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66A3mu3Y3629910
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:21:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 raeL0eEUxiWNT1OHBGgfIdE3ODHqjNAMgW2DF0hZ8pw=; b=HF5pvbTy335g37KE
 y4XrXAQUx2cXcDlO2Vx8J8rZmoEVmGgjMnqvoAI4OdWJke0AhLB7etR0DoWOHR23
 XeYDvLoSXSidlbaXnq3gLzD+2/xr8fOo7MHhExW0y3RMEGq9/HXGcIqyc8cEk1Rv
 2n2OoclSBHU8e9Up5dIPMdlFeZ2/DM4Th/JY7BVprmme5z4LW9G10M+vfvLx/Sxw
 mnfsFvq7dVhVCQ2B012QHfxKtPq5kl9tpz/VduQU8jf2v0XhYd+vCbts1XddZ8Af
 Ag4ObnGGZ8u7FNAHPIxqA+0tV7foYJVod+4jhApvTDFwkJXHUUvGb2JBcHJs0i4N
 d0t5Kw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fahv8hwx6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:21:21 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2cca5e0a0c9so9591105ad.1
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 23:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783664481; x=1784269281; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=raeL0eEUxiWNT1OHBGgfIdE3ODHqjNAMgW2DF0hZ8pw=;
 b=Bdns7dqW79mlgxybKVhAXeGNxBjYrU3nccPwh0nQMWcsOkZR5p2jiLw7B8QJKyVJNr
 FgWsRXKrE7WxQorHi2tnwuNnsDDdI8qmUviFvvUnk/TTx//vXvbvzCmqB+EK/bGl70uk
 ymurQ133sWhjqDKWFyeinWK2LZG/M9f8TB5TKpmTNESDeMniyji67sifTuafvfClDSxq
 0MdxQW2sqRoPd2wRN4R2Oi4I1mdU/YX8o6Gmy4ZBgzradPo/H/R1MgUA0jPlZo5m/2GN
 mNTM1bVbtM9Fb61bWU7K6kMeo/DqcQfHgNrTxzmSVnSyQcuA2Hqay+/GX6sDGOElxMDs
 1NkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783664481; x=1784269281;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=raeL0eEUxiWNT1OHBGgfIdE3ODHqjNAMgW2DF0hZ8pw=;
 b=bIZCpB9wLKHZzlCgnC+N0+bNZi98BOeENx31aYt+vC9EdzlaQMPASYMncsdUCghVwK
 ZxdexnI4z3xLAJ3332IO6dcYa/Ljhfei67D/Ij6VgFPJ9st/LgGpxh2XJuQPohtwWhxa
 R68YupluI0j1GxDGa4LaaqsZfeBWbpsCaky3cwbtjFY+PRmSi4l12F56WXUH9RCT1b3s
 2U2sCmts0UGIrRb0AtotYu8LqWWIxMOBMbfdynMqLYjm9l3REpqZ0rknMAAoRz99aRBV
 ryt0XjgqOM+iDFvqrLy5NV6pi6SxB5PpvZHS64HrHQZtOdnz3HPadoFM1v0W53EGWUnG
 tbHA==
X-Gm-Message-State: AOJu0Yz7GsAzajg9UOdS6JCLk/tIY0ubZZqApWfgSjhiqOGt86e8pzwy
 3jpPh/y0JJYJlhQ8wNuoOXI8d2TCvuuQIC5WkTInzotgxGv/X0xTcU43iDxbhZ5+UVqF2QlwGJg
 1MzbdLZcQ4WaAJJdpxbZ9Ao6McWs8Lg/v6Bszq68k0YmUPFpqBVYfarhC6G8+njb3MQ==
X-Gm-Gg: AfdE7clOTeMnFxg82syKusFcg5056uFKe7srLMeKGOG1OzJY3YASlpRCgIbu2DxpJ4r
 SM8khqMWrWH0oTMAcv+w2wysNCgivAAuX2LzBm7bqndwJNn3kHKu83UTVKLUxSBXz6YaNlLlDIa
 AdiI5vGQYZVyF9aDeuAT8Y4Y6VqTmCgKu5vAreZlWttQvo9PHvS26jikmymFZ++033GhZ6C3FVA
 SO9tKfNwNXx1lPMmy0MZiKTE2pQHmZfY2JPg05qTe6DhpAvpuyu+AXlaVHJlrhCGEQ14bjnAQE2
 98bVAHqGVN/oo3+DecnRltS+pm6NU+SfxQk9teRFQEny8U8QYFyuqShZlX6LpjO80pZoioR9CGK
 BZX+usrPUUsbACisHTqwtQ04JMAZXj7Ik0DOQRZoJUmrc7nCaKSrtjMvsIV+dN4Abv3l0MgIiyd
 YMhd5FVQ==
X-Received: by 2002:a17:902:d54f:b0:2cc:9473:97c8 with SMTP id
 d9443c01a7336-2ccea38a498mr103193425ad.15.1783664480921; 
 Thu, 09 Jul 2026 23:21:20 -0700 (PDT)
X-Received: by 2002:a17:902:d54f:b0:2cc:9473:97c8 with SMTP id
 d9443c01a7336-2ccea38a498mr103193125ad.15.1783664480525; 
 Thu, 09 Jul 2026 23:21:20 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659fa13bsm35428126c88.15.2026.07.09.23.21.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 23:21:20 -0700 (PDT)
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
Subject: [PATCH v4 31/97] tests/tcg/meson.build: add top-level 'tcg-tests'
 target
Date: Thu,  9 Jul 2026 23:19:09 -0700
Message-ID: <20260710062016.1818125-32-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: wwuNe8y8hxx8jwlmC1K2zgpE2-IR7z8j
X-Proofpoint-ORIG-GUID: wwuNe8y8hxx8jwlmC1K2zgpE2-IR7z8j
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA1OCBTYWx0ZWRfXyNij4W/5CwcH
 14Ge+lddGlZxaWWATVB8qT69hO6dmnGGcP3UVO7qdHf+0tJ0AC4c8ZuciN47vE6HdX0cxKp62BZ
 bWklv0g0g10ebIDZjtF3K6JfkJ5vpRw=
X-Authority-Analysis: v=2.4 cv=funsol4f c=1 sm=1 tr=0 ts=6a508f61 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=WK-hs4OApzzqMslTwvAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA1OCBTYWx0ZWRfXyaSkpW29rIw3
 4ydTCiO76SzMz6QCmw5CKEIMmYDT0WxLp6js2n0GsNsMBMqhw2jFP03WHiWxaLeSEwIfsUgPxrq
 JiEWfnFbNRwXcQguTCMJ/GjH2P9q36z5gLKxcvB4NC29ToruyWrL7YQXOT8n7yKnYqUhMMtk7ue
 4LotLuFs1t3NTMr6vOrQqcrovo8hV72eY6ej5uZaZw1TDg5uMEirjUpCtmqFuRrMQet5H3m3wX6
 M80USm5aOfkcFiFBHkir+YOmzXg9pyFHE3PfROvWKvgD+Nlx1J3+y+mee9wIHyA3Z4w2JmmeNCS
 esCLuSHCCpdupGPKJKy13zKyOldXtxOq5ZOueivHPJcpjW8gjphjaLGFglpyUvb+LALDFZJTkky
 1m16vwJydBKH1J2Wm6QxUG+G1jtehM4TEelEc4wyp+RIEw7Kvx+jyM5hcuIXz6t2TtBhJ2uf2BJ
 gj/3uVcvkjKu8YNWMvA==
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

Add a target to rebuild all tcg-tests at once.

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index bdb63bd5491..f0a1d9aebef 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -86,6 +86,7 @@ test_plugins = {}
 subdir('plugins')
 
 image_targets = {}
+exe_targets = []
 # Finally, we can create all test executables and test targets
 foreach target, plan: tcg_tests
   # Detect duplicated executables/tests, and report an error to force user to
@@ -296,6 +297,7 @@ foreach target, plan: tcg_tests
                             depends: exe_depends,
                             depend_files: build_test_depend_files,
                             build_by_default: false)
+        exe_targets += exe
         built_tests += {exe_name: exe}
       endif
 
@@ -377,3 +379,8 @@ foreach target, plan: tcg_tests
     endforeach
   endforeach
 endforeach
+
+if exe_targets.length() > 0
+  # finally create a top level target to rebuild all tests
+  alias_target('tcg-tests', exe_targets)
+endif
-- 
2.47.3


