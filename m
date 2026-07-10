Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71D3EC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 06:23:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi4bQ-00015p-7a; Fri, 10 Jul 2026 02:20:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4bP-00015R-6A
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:20:47 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4bN-0004W4-DM
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:20:46 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66A3mWBk3838001
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:20:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 quULRrdPR2IvUZJn9BGimXoJ90Ft+lAt5A43AFfgK1k=; b=G/rC8APf10khg6p5
 cioL3jSJmOJ3ejiOG694329bv//MsiU600eHpMvfDXdKrQJ9Mqs+M1+Zv3MJOoye
 DIq0M2RVmFE3lHy+viDhRr2yUGr01TZGx8wWdwgN1AmyNayQ0lsrSABglfKiLiCm
 VivZDGy7rxAf6XgSz5OF3BdoGUKJEypKOafrt1t4tEbiXukKPjc0ck65G8RkovXU
 Y/xxJifFVSUE0Q50ctOxUj439AnkLbkzEEspnCpBKmnPEUpvSZjX0crfFUHDUwKR
 da9Mlff67FvkkW+/h0EuobTkvXRHLQx5FqSiJCa4/aMGMnqlT+nnYRZtCtQ+sbRc
 gUkwBA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fanwe93vw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:20:43 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c88d7a75507so965656a12.1
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 23:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783664443; x=1784269243; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=quULRrdPR2IvUZJn9BGimXoJ90Ft+lAt5A43AFfgK1k=;
 b=UyK9iacQDqOfKjP0Urt/pzkJ23UvWR3EJHxN5o3Z4zZRml08TpSf/zOLl0pIa6lx/d
 BSQtM0AjPcgBnoS7y9fyo445H9lkrNdgduZ8D5Xg1/rJuWWHfV+WUYJDR3KVJEqO4yMU
 XeF7aLFJeHHFQG5Z0npTq+H5yj9TUN3UDBpzULwGeB4c7xSxfXMTS1m+nrJYQcwRWTBu
 HTFrLdctvttJdHoaYyqtucIHZ1lSFFQKm9mF0OJC1AiPqFZqIa3Gs65bvVzxEJpkxAPB
 QykRq2LTwJIPhwZPq35TGWsJPr0OzDKFF5AsNWi8YJ3+e3YA8gw6/Un3JCSRLHHqttbX
 89Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783664443; x=1784269243;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=quULRrdPR2IvUZJn9BGimXoJ90Ft+lAt5A43AFfgK1k=;
 b=VS2wNjJVJo/zGGGiC0IyKo224RiwoW5oKsm1uivtETYQ7cZDiuYRmb7oOCrSA4+Mgf
 3huv+P1JEDAa91h1IGRvPvnPho9OeK1HuXxSScV6jYZaRmQcFqvds9cqI9Eu2qZdHdKt
 qjy1W5JbLl/ToWBvOVsPuLFFnwqJcZFBeVMHkRkou4p7Wpk8bDoXvmOqWYisEEreQtPZ
 6YuTf22mH9XFvoKYSJ7YzW+6vJc6ISENU1w5pP/IKAdh91klbMJ3cr62MnFzudoTAhWd
 IAjvlmblPRvlYVBtzOH3n+lq7747rhJhFo3QotWZI9KVLTy5I0KCuLmia1oS+78+VxYm
 csQA==
X-Gm-Message-State: AOJu0YziUsuel/PcPalN5dzlLEL9Pj9H3PNyvA+0GXcgG6b2j6BKx6W8
 pCn2KvgTRC9XgzvbcI68VyGR5R8qiUCrX11pRVrDefkjq3D7w0sT780tr8XeSbLk5ueNvdNgTAw
 vZasWUtRe7HoRKPVSGVMgvqg5TOjN5mxuSHlO4AnQtejefUf6qh1O5GcAad+t4xuVdw==
X-Gm-Gg: AfdE7ckm4F3tgv2cSch4kIpDViR/pCxnXEGy5qB6ntja/bS2j83puNyuiH3msSfe/r7
 4GbFV3Zg8a7lepAst8U34cvbAft2MAsKASaffmmp2UHnymEOMcqd8VbxUHhi+OzT4Aw6MC7qj7y
 D9gFUFeCBHaZDbA8m3rlp8CIg0PIJkOyo0khkp1/jN+gB7N3GecNmYtKVnweWTgQSaxQqxiO2Oe
 JhBf4VkzC7UbDu01oCXtpEu6J4879rqMWrD6SrYLqhB3ZP++j0bgK0Zl4DOBtEF0Mtmc9Ua3fP8
 wbMSeJ92Qmpc5FbrY0QbGKKvTG2Ff4nWe/XFZZ7CaUV5lX3MIqoJD557OY8SeRR/uasCcLMBh1B
 GacCsAdoSihnj8bnM5Ex6vYW377tPIvqAfzOxzbineDf2LZJ7/IWqOaiM3Id2hj4PrGVvlwgbqG
 /YfNjRKw==
X-Received: by 2002:a05:6a21:4cc3:b0:3bd:3a53:c147 with SMTP id
 adf61e73a8af0-3c0bce9cab1mr12794290637.45.1783664443307; 
 Thu, 09 Jul 2026 23:20:43 -0700 (PDT)
X-Received: by 2002:a05:6a21:4cc3:b0:3bd:3a53:c147 with SMTP id
 adf61e73a8af0-3c0bce9cab1mr12794246637.45.1783664442870; 
 Thu, 09 Jul 2026 23:20:42 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659fa13bsm35428126c88.15.2026.07.09.23.20.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 23:20:42 -0700 (PDT)
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
Subject: [PATCH v4 09/97] tests/tcg/meson.build: introduce qemu_args
Date: Thu,  9 Jul 2026 23:18:47 -0700
Message-ID: <20260710062016.1818125-10-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=LbIMLDfi c=1 sm=1 tr=0 ts=6a508f3c cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=BgapuaGD2VAwZ5NCc8gA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA1OCBTYWx0ZWRfX3ZPNqflU2zcp
 xmO29qciO/7rUm9sNXtP2Ig7d67TKgqc9AD9uGicfNLySxn5Sd88UTTEeSyaXhA9lQPtloL8STy
 oJrh1ztj0g8cl/mh936YbbpTHzRJyE5bQ3SoJ7eXQPPZ0e/kc/kFB/c3/ImTcHfNSWTpYZYFPcN
 7mSrARldInaeXLg2ybs7Ux5EW9Br4Fvj0N5ZQ8KSfFE0n9vwfr/xKKtYhh4PJHW33pXc4F58BNh
 ZZBQ3kDDxQqnUtcK/O38gwgzUi7x9KgjOLrXaNwULK9B40BqP+fGijVEtS5UNBkUUZajd7siL45
 JYPzcXSQZ1tq0q4J+7c+7zd8tubUQSc3Exc7yIjAN5N99VEePkKdVPT8+ha6d+NUfuBIZFXwReX
 uRj8N7c99X8lYBxioRqvGL5cNvTd06CMECdtnOS4tVmereHt63DW4ANxz3tKqlUOTpqkBk0/b3h
 l+/wQmtyW9Wdyi15TYQ==
X-Proofpoint-ORIG-GUID: WSjUt6eMKn9_kF0cWpVVqrKxGoUJubmp
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA1OCBTYWx0ZWRfX5JBUZzREO5Z0
 2pZKtn+Y+/PDAu5HYK0hMqoImLckjq0S8c1RMozurZs8V295jAo7Pbug9Mauf9LGnZV9/laGq+v
 aJw5YIN/Mqb5EQhvSPyfCaNc8EA57YI=
X-Proofpoint-GUID: WSjUt6eMKn9_kF0cWpVVqrKxGoUJubmp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_01,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 priorityscore=1501 phishscore=0 adultscore=0
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

We add possibility to use custom arguments when calling qemu for a test.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 495c1d672f0..8c82a49b3ec 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -14,6 +14,7 @@ tcg_tests = {}
 #           'exe_name': ['provide an alternative binary name'],
 #           'test_name': ['provide an alternative test name'],
 #           'cflags': ['additional cflags to compile test', ...],
+#           'qemu_args': ['qemu command line flags', ...],
 #         }
 #       },
 #       ...
@@ -56,7 +57,7 @@ foreach target, plan: tcg_tests
     foreach src, setup: t
       # return a clear error if user misspell a setup entry
       foreach key, _ : setup
-        allowed = ['exe_name', 'cflags', 'test_name']
+        allowed = ['exe_name', 'cflags', 'qemu_args', 'test_name']
         if key not in allowed
           error('unknown tcg setup entry \'' + key + '\' for test ' + src +
                 ' (possible: [' + ', '.join(allowed) + '])')
@@ -110,9 +111,13 @@ foreach target, plan: tcg_tests
       endif
 
       depends = []
+      qemu_args = []
+      if 'qemu_args' in setup
+        qemu_args = setup['qemu_args']
+      endif
 
       exe = built_tests[exe_name]
-      cmd = [qemu, exe]
+      cmd = [qemu, qemu_args, exe]
 
       # some tests expect QEMU env var to be set
       cmd = ['QEMU=' + qemu.full_path(), cmd]
-- 
2.47.3


