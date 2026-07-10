Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85B83C44508
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 21:44:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiJ17-0004so-FA; Fri, 10 Jul 2026 17:44:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ15-0004sV-Jr
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:44:15 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ13-0003Pg-NM
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:44:15 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66AK3eio1846381
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:44:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +p2lVbeMsthflMXIZbMTGvzqk+OnL4gslwFpdsGG3zk=; b=nPi5bNAwiWgQSu9l
 SRD8kMNgEOE3KjiMC0EFDUG75B7p+5yySJvMj7eIyw/acUXZv38vlLFgVuMeJ6NI
 pfWIsYHBc9Qf8P8POcmdbX0POp0B5L3NZNHtjeBjutjrOIYh4joTokp0ouLWpaMf
 xFhTgWU4BFIMGJkKZynpCNKWP97DkV6OHZJzHqCavWXUwxzcG8q9xcr+yLCb3hun
 Qt/nPH5bSYVYaPj2CjtWNnBkWW7W6Cvx4hwqXAfIPIJNDrgMQ3di0PDk2CZOVjxa
 f9ssaSKcMYgKwqe5zFrgEXWSAKJA31YKpV2kzMAn6IQibmx/GUwLNxA6lUxS6GRQ
 1D3wNA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fb649rj82-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:44:12 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c9c26587e67so1389255a12.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 14:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783719852; x=1784324652; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+p2lVbeMsthflMXIZbMTGvzqk+OnL4gslwFpdsGG3zk=;
 b=jOhIVdTtSivegrHBmjKOnTUsb4+RKBk95juDIvCeBfK8cLyHtXnA58uTu5jGw61WY0
 m0+OywzTxK9sT/MTQWIVCmJSLWzC+IYPtmGeMMJ/Fq6pRFHVMbESLp5ycU4MSf64+xo0
 QM0Upy5aZwOK2x8h+cSEXUiCXVdgRvurdMnTjb/+OgsME1JEJjE1wAGr3+Q0h7BaZIif
 O/5LMjkinkyiNDjK8K9NTG668izond+sSfaVusq8Z51ugcm406IRs9fn5yjUhbXqU8G1
 X33wdUtGu8uOmxj1QYh2G5/2k35uLQzLbmj3r9iWP96sYXqtWSt5XwrAtLkT9jbBdn1c
 zD1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783719852; x=1784324652;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+p2lVbeMsthflMXIZbMTGvzqk+OnL4gslwFpdsGG3zk=;
 b=gVYVXCPuE3qNQZslb9ZDwV7T/YNRgBwhlZWz2we/kHaaviCEmnj7nCQYeoAvr3Y4o1
 bUHnIik4HbyBQ4SVXisB0wfio0J5CTPcpnwh4qOpgbb/1izLVjfaDmyV3AdH1M2yLs0x
 NDjVCi1Jv3Dg9HIG91nRWZUymVLskcUFo55BqKhQ013x9EIWdHBVgidMHAXCzaPqu7hP
 IgutuuK81wWk/6tEv2FBTYgL+hN4l3i/lWUpZ6DlyOL2UhxJwTizLP87dJ4bXBjDpqDu
 57gAvomj8sY/v/oBYyaWxMYXQ/4kovj3egWQ4dZJQVGFVvWOMewQOFzWiilLZoWyQSjR
 d7og==
X-Gm-Message-State: AOJu0YxodjzwvLw+R5SFFaHJ1npqCcNS8faCdN3M6dI4FOBRAXwB05MI
 8wgEhn2DvYN+yPxn0yt4kjU33ShX0OQYGf5SRI6QDQtRCfY2KIrhzu8btvzq7YcaQHxbST9pJXE
 VNwmzPtCfGNEzgHVyiCMlYBagO+dlaUevP+6gWZIXR7WB09I1RDedCh/bsplCMEPDCQ==
X-Gm-Gg: AfdE7cm1hezGJiY4C68dJrjvCeLQ5UC/0KCup9kBoDDeYTIklb74UuHy9QnTFY1eztP
 eGiY7pgLD9smxeTMj10V2ecFW0CndKNwEYUmJrBd1+NbJi4zZSBsnilvXN2YJYCTZ/BBrs3vfKp
 LlRzywAE3Uyh8uPH0VBuGmTsQ51R2nYPJC6+76oH6PKHJznDZxMUDuP0lmxwXGSE+2CBjjSSKhB
 HwFwEM03JSqfraWbyjkS7+S2MXYKLesDZtopRLEC+hBE+HopVlWsA+RJ8XhlUBXUTLwKwS/vbiK
 Hxk5dYaIalCJUM2GmYMEjaR88vAe/vtGIsaI2rNuM4yTnXo7iZ2vYnVaZgy435miZdgvTyEKqt/
 0GWOv2wFpcnNRKkvfBvgrDUyDUiI7c3gGuuqTnxfmfoczOT2aWRj+aUHMpaSYcIKkterGklHE3L
 /yePrrMA==
X-Received: by 2002:a05:6a20:244b:b0:3a0:c246:bb98 with SMTP id
 adf61e73a8af0-3c0f0b9158emr6187836637.29.1783719851714; 
 Fri, 10 Jul 2026 14:44:11 -0700 (PDT)
X-Received: by 2002:a05:6a20:244b:b0:3a0:c246:bb98 with SMTP id
 adf61e73a8af0-3c0f0b9158emr6187817637.29.1783719851206; 
 Fri, 10 Jul 2026 14:44:11 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659c8665sm43539840c88.10.2026.07.10.14.44.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 14:44:07 -0700 (PDT)
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
Subject: [PATCH v5 06/98] tests/tcg/meson.build: introduce exe_name
Date: Fri, 10 Jul 2026 14:42:10 -0700
Message-ID: <20260710214343.2065491-7-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 3MMhjFbIxDdrW-0IBxt7ibS51TYwp5XD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIxOCBTYWx0ZWRfXyzuMk09+uRZi
 6+cBWSlozgzpJDJ90dyrC6C7HUS/bEvLf8EwHUbigzcabt797puPaFuFgFJrWd4MVAgnoaoS2Hu
 6+gTK6q7F5Hxh6e3GCBpK+EMqGDaftywYnrVjovOWNZPwLwedF3FnfvQeLW5bWL3YUNjImJ8kQk
 tKuyB/1LAkurR+xtsgsmPa5Bn8NPkl+hx/3wduombagWAv+BdSFC1bzNPtG1Dz/lORKNtopd1fB
 9wfaLwJCEiiHBdd1iubi8FRZg97ox832wglqIIJfyNtBOFED9NMdLtVDyUsbIPB1pDdHhTOokjU
 ROxwWklEDkbH29lsd8QiK3SZRRxdLnAl3ePlOBovDhk83nHzm7co2AT/IXzC7S/cy4MqwGj3sgj
 L96nuibdx1OdicI1sDodiJs2yPcF1bVVj3YdSt3UaagNuY9MubIS6xzmPzq/7ma0xA1k5nBJhng
 IYH2T1TXPTGo3e5smmQ==
X-Proofpoint-GUID: 3MMhjFbIxDdrW-0IBxt7ibS51TYwp5XD
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIxOCBTYWx0ZWRfX44QXlSBG8JoS
 ud65izPDhZeZ9ddDvgoxgdkSOg9XE/OP1MCbrFSrqAH6yop5oqJ5FXHQpefQ+64Ptmoary5iZHs
 3vU9Tx3qef2fwGQ2fSvCzDk8uA7ExPs=
X-Authority-Analysis: v=2.4 cv=VZfH+lp9 c=1 sm=1 tr=0 ts=6a5167ac cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=xYeKZKBo3MRtsS0M5EUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 impostorscore=0 phishscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
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

We add possibility to duplicate a test executable for a given source
file. This is needed when different cflags need to be used (like
vectorized vs non-vectorized for instance, like sve tests in aarch64).

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 5758c7cc0b7..697b826a382 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -11,6 +11,7 @@ tcg_tests = {}
 #     'tests': [
 #       {
 #         'src_file': {
+#           'exe_name': ['provide an alternative binary name'],
 #         }
 #       },
 #       ...
@@ -18,10 +19,10 @@ tcg_tests = {}
 #   }
 # }
 #
-# Every test executable, is built only once.
+# Every test executable, identified by 'exe_name' is built only once.
 # Tests for a given src use the same executable by default, and their definition
 # is guaranteed to be unique also.
-# Default name is derived from src.
+# Default name is derived from src if 'exe_name' is omitted.
 
 # plugins come first, as we need to build the list
 subdir('plugins')
@@ -49,10 +50,22 @@ foreach target, plan: tcg_tests
 
   foreach t : tests
     foreach src, setup: t
+      # return a clear error if user misspell a setup entry
+      foreach key, _ : setup
+        allowed = ['exe_name']
+        if key not in allowed
+          error('unknown tcg setup entry \'' + key + '\' for test ' + src +
+                ' (possible: [' + ', '.join(allowed) + '])')
+        endif
+      endforeach
+
       # meson '/' operator drops left operand if right is an absolute path
       src = folder / src
       file = files(src)
       exe_name = fs.stem(src)
+      if 'exe_name' in setup
+        exe_name = setup['exe_name']
+      endif
 
       exe_name = target + '-' + exe_name
       test_name = exe_name
-- 
2.47.3


