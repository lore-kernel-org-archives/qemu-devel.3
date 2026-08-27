Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEAB4C61DC4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:18:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziOL-00070F-OW; Thu, 27 Aug 2026 18:16:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziO7-000692-7U
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:16:02 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziO5-00069G-EH
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:15:58 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJLckX1358479
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:15:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Bz7B20RD72QpezR1e6/rqmE9F52VLa2IVaFmxlNoH/I=; b=inKvv6yMDZhWT3us
 R8ESaPKgGIfGPUYGK1GTiedtmY1vj1L6jbjJ56Qy5L0U6mHR8kcWTMG8WPaiPhmp
 IwQyhoFt/hqTERxQ3Ah9Y1CUKuPzFqEYvnc0HRosCjkIVwdJftYmuIJTOkTFqybg
 LRekdakt1L6hMSrYXWjY8yWJBQtifN5hEwdJz1ePSGZBYDOKcecARkXa+E86JW4T
 7Irz4pFCHH4HczzIXdUwRMQgDcFl/scr4X3692QGAoduGdE+MRyZXHZ6eDsLnPg0
 2QWSFlFDn1jG2h0DOyIZLVyijOw9fafPeHjm1o0ObLpZpUvJEjmpNr1jmN/rLRJW
 LnPprw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gapgva9uj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:15:46 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cbbb9c9bfc3so320160a12.1
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787868945; x=1788473745; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Bz7B20RD72QpezR1e6/rqmE9F52VLa2IVaFmxlNoH/I=;
 b=NFQBvTYFyHGz2rJVwRtRGmbgwdDAV6sYpxDGfzrjmPtIaPnStSX4kkMiYKB0m28Mpt
 ZL4co2gndQvdHRAet1ZwYpnhXXw15dXpdY/iisrP4alll43xVXt6Ls6bTU8vFyOrAuBJ
 EDbmhAh6OYMddYWuloNJPu8lMjz7ScIoMT5zRoZNwfGqmnkkUaxrI7LDJfN7ihaky1jG
 sSjGzabBmcB7uN/eAxmAEvlIMJ82gr6SbPD15ig6OIr0KRdAzXbk9GvHRcnDPDsDd/CU
 ZZyNJbv2gxLni664CXk5oIu9RegSs5w5azESJtoy6kccvIGeObEORG3M9w8RUZqDAz4E
 60lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787868945; x=1788473745;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Bz7B20RD72QpezR1e6/rqmE9F52VLa2IVaFmxlNoH/I=;
 b=e7FyZ0FXK4FISFGNbTMKl6TAQsMhkPESvGE/SMBTD+nlSCUtAn09AiXU7+uJ551+h5
 /wAdMQjSKDGVCzYWNUU2xk9vXRqmnQAJjC3FP5Q1L4A6izXmO0JgwzaOOl7dh6DGdzIG
 P/T2udvQmbn20+kUAmJSn4X29XuEEE2ntrKEg9hOx9KrGx4nhA1FT+GT1c08dhuZjTG6
 ZwgrfCFzBIvTA6ni6WaxwS03rLPJo8eNTFGHbsmYT5jUJjKcl+Y4W5byBDA45pDRNAw7
 Aq/3SVjt0wyaK/8oAH3EGKqZjirfb0Y4Q5PKTbanoiTfRHX2EmetOyMq9GLPrgLr0EJV
 up7A==
X-Gm-Message-State: AFuF++kk2YStVCvOvWgYP5Z2XCSqHNfK2JLHbvHkQ1VP+dO61BYQaVyH
 nP8fy8bNUUrcH4Xhp7mro417jXhIHi1lu8wRo+UW70ZEbd2e/ToFwjU6ACEZnUwI1twlGVUapRI
 7AhJrhE7JOC1BZ8xwQSzX/P9p8DHRnnLKjJ5/DTqaMpmaZD5PGx4KbHNrtfs+ldB+VQ==
X-Gm-Gg: AR+sD101aOjnTw4dP4EgHRPwuK9ujG60+YClZo9zZ7tSqvTZUd138YleFXaH5GgWpXH
 KdezVe96kRzapNfZqpeHzBJo9tyoSaZBUDAx7kS3qFKlXGvUSvrqgdjAoA+mvnwEuZ/7Zq17tyd
 KqKzMxIe5RqNrBPjjp/49nRPxy0eRlI9s20oJ+emxTCg6WcKW1NBHMXhyfNBk9HYK/bErcCZ/dG
 ej3qK+mpOoIm4KKiI06Wd9D5PrCR/eUwWFm1ohU/iVgWJGltaSFaf/9oaoRvpR7femJU2U86t/p
 PfiG880NIAQl3dj2mTcCUU34D53Sj1Ar1ThrT1aZwoejzor1ob+SF61lidBGErt4vxCiOE31h8G
 fkYtIZ9jsDh388o11OkZa+8oEHiqPBTg0lfDjVyyjCdsTiPUrjHC1+bU+tIY=
X-Received: by 2002:a05:6a00:130d:b0:84e:216d:7e4e with SMTP id
 d2e1a72fcca58-856277db9b0mr4150329b3a.1.1787868945346; 
 Thu, 27 Aug 2026 15:15:45 -0700 (PDT)
X-Received: by 2002:a05:6a00:130d:b0:84e:216d:7e4e with SMTP id
 d2e1a72fcca58-856277db9b0mr4150234b3a.1.1787868944832; 
 Thu, 27 Aug 2026 15:15:44 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8535cf4b213sm2524104b3a.55.2026.08.27.15.15.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:15:44 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Stafford Horne <shorne@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 pierrick.bouvier@oss.qualcomm.com, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Bibo Mao <maobibo@loongson.cn>, Helge Deller <deller@gmx.de>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Song Gao <17746591750@163.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Laurent Vivier <laurent@vivier.eu>, Nicholas Piggin <npiggin@gmail.com>,
 Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PATCH v8 029/105] tests/tcg/meson.build: check host cross cc is
 working
Date: Thu, 27 Aug 2026 22:13:50 +0000
Message-ID: <20260827221506.91574-30-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: lAGAE-hIt33I8NNTPAgzEz1dPBpq5fky
X-Proofpoint-GUID: lAGAE-hIt33I8NNTPAgzEz1dPBpq5fky
X-Authority-Analysis: v=2.4 cv=FpU1OWrq c=1 sm=1 tr=0 ts=6a90b712 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=VnNF1IyMAAAA:8 a=Y7GLNXJ1w4EJNdMAD_QA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfX0+0Dj0H///C+
 bY+k3uYXeg3h5Vj/lppcGIYM1hsGNXhRF43aSQMlis7zvkH3P455fbzm8hoXMoi9141IeZbasZ4
 UBSsd/wCYvrC3PM6jmQ9j1TldxPFprr3zYKcr5XdOSKxNMbx05B6WxUwlXw5vbHTDPMV7RVRnTg
 t0tLDlzqxbnK9bS/rcq6SmQUTNjL4RXNg6s4HAypTeV1qU7lcoQ46gWAGQrXru0eFaUyG213WkQ
 3ua1VORtdr6yqB62bM463sbiyLx1kT2HU8PfzEa3Lw8Awnz6+IJV8CbL6ZwZMbTv1K6U6N644Bq
 ZRiTFJmK2C4mbE/B6xTNarFvG4fx44B7xEqRt+9biOcQInAZWEKFhaesnfSKowiv3oyGaKYAm0z
 onecDi8qPVuEU2d+uoL7U3EJl7bb93CNkwQ7Vrh3y6Ro34GjCI1JkcZca5ZeJoJ8qroBZFrEOZS
 pnrkxOZiEiv49ho0z5A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfX2nWRhiC0dADk
 01Q1HucQjBTlXEXt/7SV7GfTpuLyzmFxFNJsq01Pqej1+/YpIcUiPQE6sRE1atEACbHuOVOa26A
 pBEg25Rf0FFOayAMk6DRoHRUf+wI3D4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_08,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 suspectscore=0 impostorscore=0 phishscore=0
 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270188
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

On Fedora, cross compilers are provided without runtime or header files.
Thus, even if program is present, it can't be used to compile files
directly. Check this, and fallback on docker if not working.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 12 ++++++++++++
 tests/tcg/test_cc.c   |  9 +++++++++
 2 files changed, 21 insertions(+)
 create mode 100644 tests/tcg/test_cc.c

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index ab7090a62fe..9809695f3b8 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -109,6 +109,18 @@ foreach target, plan: tcg_tests
   cc = find_program(plan['cc'], required : false)
   cc_from_system = cc.found()
   has_cc = cc.found()
+  if has_cc
+    check_flags = ['-static']
+    if target.endswith('softmmu')
+      check_flags = ['-nostdlib', '-ffreestanding', '-r']
+    endif
+
+    cmd = run_command([cc, files('test_cc.c'), check_flags, '-o', '/dev/null'],
+                      check: false)
+    has_cc = cmd.returncode() == 0
+    cc_from_system = has_cc
+  endif
+
   build_test_depends = []
   build_test_depend_files = []
 
diff --git a/tests/tcg/test_cc.c b/tests/tcg/test_cc.c
new file mode 100644
index 00000000000..d3614a01fe6
--- /dev/null
+++ b/tests/tcg/test_cc.c
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+/* Include a standard header to make sure cross compiler provides them */
+#include <stdint.h>
+
+int main(void)
+{
+    return 0;
+}
-- 
2.43.0


