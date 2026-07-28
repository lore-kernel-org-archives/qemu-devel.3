Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F14D6C54F4C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 04:43:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woZel-0004Fa-W3; Tue, 28 Jul 2026 00:43:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZei-00049f-RF
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:43:04 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZeh-00018a-15
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:43:04 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S3abKM1527466
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:43:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4zjHMK7zt/kkcT/vDp5YXo7zcENwd1jTzje8Z/8AHWc=; b=UHVeZqLZY7J2c0Yf
 XMud2lwwrXnk4Q1XpjJsXWLZu9rEKajThmK5BI3jlJyMpugyOF95Sj46D6NCdvU3
 PrNOsS83/7gguSNiTqCHFq4etigBE4meel+TxQWNodZkWPNq/kIwAhKu4LbVfJFr
 /2g2uHOJm3oGhul9uA7TRtZw+5VPLxwDaPNhGP7UwdHm0X3nHrO56nUigSurhMoP
 gaxiLqdAerGtoflkYVmUdp5PyOA7e4Nhp/KZC8/LHx2idb0wj4juX0CBmXqKx0sB
 N7uFrEz8DTy/5stbj4uKMxzzbxZO2pBTG29w0aI4Hn38I2bqekL+UeRzMSqOW9ZV
 +xzF7A==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpbn8act6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:43:01 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cb711c88f2eso2183577a12.2
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 21:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785213780; x=1785818580; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4zjHMK7zt/kkcT/vDp5YXo7zcENwd1jTzje8Z/8AHWc=;
 b=ZdpyKWcs576SfVDg7JEGxeK7vIJanUGNMw7lRF+BqPtsOqQ0bx9sDCbCUViMUfpV6E
 tIa4p/u3NXWkKSY0g4NY9BWvi5AXc0KnE6yLLP/FCbkg/B7RDpYdyVJHenQ3KHL5YbJE
 c13NIxdfOnJP99a+WjQBPoqM+PA6Lqb2ZPDgwy43JDfNrLfjD92NIrUX7ZhCgyZ1xqzX
 uF6ctjDX7uZfndFFSI2AF4gvrSa+extwJ94FSfAqaKglwW+TFdhY+Aukgj82xCYUdpcD
 OMS34OHb4n0wlUCTBuES1H/9vMuxZKm8ZzWo8ma/3iUR2ihm8dz7NEj6ewr9xoXwi8C7
 hZ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785213780; x=1785818580;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4zjHMK7zt/kkcT/vDp5YXo7zcENwd1jTzje8Z/8AHWc=;
 b=bhhPhNWbPs8QO8EKoqv94a7uWIdGUUlXvB17FzFwlGXep85weLCzaL5ffYQTXFQHDJ
 gy4knV5s3o6T1dQfmFtqw9CYkCd6Ivx30kThmrQkF8whhsHobu0Xx2K1vDOM7WzjE6Gy
 CjSQ3h6InOQ3N6pDLJQCddG36047bsyJVO84GgTtzyLMjN4yQNJr6nx8AIuRGCRnqcSm
 F0hL9meBgUPZCxwPgy/D5BCODAsgrvAYwugzyYboSz49sOD5y0HBc56b7T4B9H8XWUut
 UoWOUyMm92dSlpovxM7H5U+vGILx/WAO/JIOwK3HgnxViFgzmuLmaoPHgXx5Nl54723T
 e7mQ==
X-Gm-Message-State: AOJu0Yx+BvRoYsA6RwBuRl2bvYZLWoZl0TtkZwOndHOsUfyNr9SE0uSk
 4cYl1/D5MVpdfgp4iP6nHjLYBAKdWb/gS5g7LUZTRWBmxl2LCAw0NUBTSMFpWG/pzVF9lFb3u+z
 FmBnJMB5pTcwchOxxF/GlqRJIRldY2PlzmcmdHbhLgIWRNLUIvRdxaWhO9wKijntGMg==
X-Gm-Gg: AR+sD12P8QptHsK2qmZZJPIBO9bs0biZHMhyff85cedu+sMnOYp66WZdoUuxJefiSCH
 yViCkDKpYA481thOMeCK0a4bIcacpvOMBq3obN41Lj52K4mYBWYrqmhFMykFcS6pfFUt2Wt1Nfj
 JJa0r/kbavXm2Ky0qLOTTBSPREdDJHTmwD00n9w+kSXU7+4NnoFutODBv4KWo10nJzeqPujxIHV
 yLtCasRwiNo0Ccqcakc00mH6VefLiNrkFhWAfsFbUnDstYGmzQCp9iHL8owW68NCvEhPkQRJiIA
 1lDds9J6I/uNzBF4BsfSYHqb24dAtWAxYPZDocrItEwALVtpbJz9xqF1fIFODGDUoBf9q4awRZD
 DjPDDAnLotubYmlbMxmTkroch5tennVGCkWMX1lxqVbkehUMmSf+X+uL/VEwmYi/C9Pi13bk=
X-Received: by 2002:a05:6a21:7489:b0:3c3:bbe6:95de with SMTP id
 adf61e73a8af0-3c8aafa3338mr1063340637.6.1785213780254; 
 Mon, 27 Jul 2026 21:43:00 -0700 (PDT)
X-Received: by 2002:a05:6a21:7489:b0:3c3:bbe6:95de with SMTP id
 adf61e73a8af0-3c8aafa3338mr1063321637.6.1785213779860; 
 Mon, 27 Jul 2026 21:42:59 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-314bc3e878esm38795784eec.3.2026.07.27.21.42.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 21:42:59 -0700 (PDT)
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
Subject: [PATCH v6 002/103] tests/tcg/multiarch/plugin/check-plugin-output.sh:
 take test output as input
Date: Mon, 27 Jul 2026 21:41:06 -0700
Message-ID: <20260728044248.137626-3-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA0MCBTYWx0ZWRfX97kmAJCZigtQ
 KWZT89NWKvJh4qm9m/R15cyHmCyWfsx4Uln8OtPP0isINRWqkCazAsYxjmii+80tg6DXr+X6+TS
 8XNDFXbRX/Tj+KK3iOtqjXDVSBagZ7txmiM85NJa7Poy9tea0eHH1cS+nj1TPRT1ZXPo9hbeXCc
 f7k6OZU+VsKzsHsq/rmRf96zWcWUWtIWDOjImB0wh7Fzf0dMQTzRdKMmvZxiyqajsLri3+yYo2/
 LErR1h9+xyCMuK2PWUF/PHVSsrVU2P6rY+EQvYKFJ1q2hcqswPwxc7Hj5+Hjx1OSDjcUPrQJvtT
 6irDsjSPx0bI5MGzQm9Y/YGS9MLk4eZ5tZdlOkM8fG4FSX3KlM6iyCR4BtYGqY0GhY0L34PbwXO
 XtcHifeSnUSWbF3B/CSlOYDCfhK78bJNIT7hV7ZGBdN5hRh26j5lp2N+BUkJs2F1mSexfdrA77e
 6zug+JtLXSdySB/ffCQ==
X-Authority-Analysis: v=2.4 cv=RO+D2Yi+ c=1 sm=1 tr=0 ts=6a683355 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=BJ7t3AzVVyt49CR6OUkA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: n2qcJHlwCEpTyvPJ4-aPQixMI8mhOltz
X-Proofpoint-GUID: n2qcJHlwCEpTyvPJ4-aPQixMI8mhOltz
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA0MCBTYWx0ZWRfX0p02Q5M6r4My
 i82V9bn1hoA0sDXq2VRh5fZgaIl2H/h1NFuwSRt5+wslRaETpbH2jEJTQSTc7FiEmxPpEvSRdsz
 L4Z3dciUXdeEel2Op0wN/2S5VDk+fRY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_01,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280040
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

Instead of executing test, just read it's output from a file. This
allows to standardize how to call check plugins scripts.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/multiarch/Makefile.target           |  3 +--
 .../multiarch/plugin/check-plugin-output.sh   | 22 ++++++-------------
 2 files changed, 8 insertions(+), 17 deletions(-)

diff --git a/tests/tcg/multiarch/Makefile.target b/tests/tcg/multiarch/Makefile.target
index ab4bf9c5d53..9bcbbb11286 100644
--- a/tests/tcg/multiarch/Makefile.target
+++ b/tests/tcg/multiarch/Makefile.target
@@ -202,8 +202,7 @@ run-plugin-test-plugin-mem-access-with-libmem.so: \
 	PLUGIN_ARGS=$(COMMA)print-accesses=true
 run-plugin-test-plugin-mem-access-with-libmem.so: \
 	CHECK_PLUGIN_OUTPUT_COMMAND= \
-	$(SRC_PATH)/tests/tcg/multiarch/plugin/check-plugin-output.sh \
-	$(QEMU) $<
+	$(SRC_PATH)/tests/tcg/multiarch/plugin/check-plugin-output.sh $@.out
 run-plugin-test-plugin-syscall-filter-with-libsyscall.so:
 run-plugin-test-plugin-set-pc-with-libsetpc.so:
 
diff --git a/tests/tcg/multiarch/plugin/check-plugin-output.sh b/tests/tcg/multiarch/plugin/check-plugin-output.sh
index 80607f04b5d..338c9ced23e 100755
--- a/tests/tcg/multiarch/plugin/check-plugin-output.sh
+++ b/tests/tcg/multiarch/plugin/check-plugin-output.sh
@@ -1,8 +1,7 @@
 #!/usr/bin/env bash
 
-# This script runs a given executable using qemu, and compare its standard
-# output with an expected plugin output.
-# Each line of output is searched (as a regexp) in the expected plugin output.
+# This script checks that plugin_output contains line from test_output.
+# Each line of output is searched (as a regexp) in plugin_output.
 
 set -euo pipefail
 
@@ -19,18 +18,11 @@ check()
     grep "$pattern" "$file" > /dev/null || die "\"$pattern\" not found in $file"
 }
 
-[ $# -eq 3 ] || die "usage: qemu_bin exe plugin_out_file"
+[ $# -eq 2 ] || die "usage: test_output plugin_out"
 
-qemu_bin=$1; shift
-exe=$1;shift
-plugin_out=$1; shift
+test_output=$1;shift
+plugin_output=$1;shift
 
-expected()
-{
-    $qemu_bin $exe ||
-        die "running $exe failed"
-}
-
-expected | while read line; do
-    check "$plugin_out" "$line"
+cat $test_output | while read line; do
+    check "$plugin_output" "$line"
 done
-- 
2.47.3


