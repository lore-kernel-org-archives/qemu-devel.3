Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E63AC43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 22:35:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgrtU-0002lx-Lv; Mon, 06 Jul 2026 18:34:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgrt5-0002fQ-2H
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:34:04 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgrt2-0005LL-Hl
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:34:02 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666KENwf1496094
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 22:33:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 sU1ZEpbtsPiTi3Z1jYI9sf2PH/WmQ1kJvaxyrijgup0=; b=mMxP1itifV+KSkKo
 kiXDCGZJoi+dBUQZcOOhPBtT/x0gwAjMpSZ+TRzaUzM1X45J40zo+nWYaoiWoba9
 niiW07jQJsmTI693vh7fvBoEdH5YYpgz1fuZ9CBCHgvRmdJeIWIZAN/LSVU7DnB2
 Fao5IKeMyoJ9ZZoHFDcFnimUEjW9DhqNhC9k2rL8/J1pFg+ZAShQX0nUCDkKeUU7
 jjHEIwBmJ/wsh2Rn5BI+Xvyb8ZRBV8bJhtYmTkNP+V6QxxMBD2s10fKQSh5PWGFf
 wQZ75SwnMI+GjZmUQ2my+IOo/vHMz4qrqkCkNJpJJLi24BVOzjSLKzWMAQp0uwUl
 gQwj7Q==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88t8bg4q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 22:33:57 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c89704da8c7so5664571a12.0
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 15:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783377237; x=1783982037; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sU1ZEpbtsPiTi3Z1jYI9sf2PH/WmQ1kJvaxyrijgup0=;
 b=U5ScaIK9J4gpE3Y8OiXa+rVYHLnYlJ0oTUlXhMzq4KX4BtCPMiCxTib6CvrD/RVeAJ
 /zsv+yiZJugaQ2DYS9IomU/5IRkdeepd18+iSPfbswb6Fma+vvBIMGN9HBBKhbVuETy7
 8mSf7qMoIpKWXawLbx4k3iWpUIH8xGLQDxZ3/X+I30MDVGUMiEyuZRZiq9FMAgcDZxCc
 5VB9tb1jYpMTCnWXai+jsVCNh4rs4zoP3Xg4d2dRoWtjure8MeVA5fsnzxOXTLqdlC5o
 4ejqT8HuRt+a22y/d1ysH4eUXVSQ2oCbbVEk84Y5uZaBsM21XuNC7dALBHZOkRByJD4O
 gvow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783377237; x=1783982037;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sU1ZEpbtsPiTi3Z1jYI9sf2PH/WmQ1kJvaxyrijgup0=;
 b=W0Dh2yKswW0accdMF79CmCpi0nilYoZm7W6AKUqU8RO/6zcmHlXuHAIWW2XT2RJfQ4
 9T5TMmEGO45i3uNq8I+eMH9DTRPasE0nRO7nzSyDnhQZ40iW2iVNWXIwCs8km0E6rxvn
 ifWSEVJ9J1/Ejix3gKce5lhz87kT6mczLJP0pYhYgP5vCT6xY838tB7iOsji02H0DDG/
 IVYJTl7rutN7us2skzqMHI7qHg9NcBo7DZxOahshhInj4BrxpCLrpdC7yznD3edb989+
 4rdH9ZRlTWySBU/7K+4YdFecfqNIm28wjOe7K1PnqVbCBNmCqJmg77i1Iq1e+Y6Z2Q+T
 /r3w==
X-Gm-Message-State: AOJu0YzWTuSTdZGpltYVC9rUhRm3nRlV5wziuKgBt9Mv032sE3GUq9Sx
 w6txKkPkcC22NR0mbSB6lL4AKEPGcUBWTe5ZlVugw+/501UaEijetf6q4+F92tNoZcGMoVBZ+4C
 QOnKobdBd/AB9oppvwOZaz8F5u0uZ1GPzkvY4FGUm9/KeH/f4G5JTsI06fibomnAHxA==
X-Gm-Gg: AfdE7cld0c9cUV3xZg1BLy2qQMx0n0j76qFVvfWPPP7uj/FRbiDaeR6m1gU9/LtFMtm
 GQrODlt+3B8LIu3vBCESDTXWP1gE9wCOMlaizQdp9Hk/qPpJan4dKDPk6t7/+XBqeWJt8fpxmXF
 fj/tLVvghgHOHdnP+4wrP0udV9RebM3bhA8IDjQS7GFzDYfv0f9CstYOHdXHSoZxu9tORldWp05
 6+pm70TjKGsFH1bO1sMXTcyN0w6EF2MYA7Km6t1KGpJZPmYxHesiriQPHwj/mhBIh3oZHvEq1WJ
 xtcabmVBxkR2uVA42BamPAxiMTJtwSJBUvxJrs0FlNukXdUWSOpBnnULeY5oupuVbOkJFQzkmIO
 wOQ9x8CBA0lyCavqS2iwpv+0Dpwb1yAGhYZrpV5gOh+N7D2+wsxN3GzDcFhI2nJn6UthjLdbR6e
 CdiiJcHg==
X-Received: by 2002:a05:6a20:734e:b0:3bf:6c08:fb9e with SMTP id
 adf61e73a8af0-3c08efcda7amr2595865637.50.1783377236912; 
 Mon, 06 Jul 2026 15:33:56 -0700 (PDT)
X-Received: by 2002:a05:6a20:734e:b0:3bf:6c08:fb9e with SMTP id
 adf61e73a8af0-3c08efcda7amr2595842637.50.1783377236368; 
 Mon, 06 Jul 2026 15:33:56 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31174ac0557sm977244eec.26.2026.07.06.15.33.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 15:33:55 -0700 (PDT)
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
Subject: [PATCH v3 02/91] tests/tcg/multiarch/plugin/check-plugin-output.sh:
 take test output as input
Date: Mon,  6 Jul 2026 15:32:14 -0700
Message-ID: <20260706223343.988769-3-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIyNyBTYWx0ZWRfX8aT2EoZPoDcf
 XOfRflK0DLZRtcpGaCLvOsHn6De7e9xhQdeNV3BN+KYxFu3AfUT3Thszuflra+Hw0JjbdqhH4Nr
 IJ6l10COD8ML8v+OUnwLiW6hx3WoB/Y=
X-Proofpoint-GUID: VJwAnWZzBXwkCe9AsEdvo7FrZuYaM7FF
X-Authority-Analysis: v=2.4 cv=C6zZDwP+ c=1 sm=1 tr=0 ts=6a4c2d55 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=BJ7t3AzVVyt49CR6OUkA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: VJwAnWZzBXwkCe9AsEdvo7FrZuYaM7FF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIyNyBTYWx0ZWRfX2Z3wOUuazM1+
 fevA/cZc/SpHFEJg7ZTKJ9Ni2cTQhT5Z/AJU5xVoNyMBFSldtlVRtHhLS31Iyb1ei9+0nmQDYQ4
 RZdwNDAnLpz34Pnn0TmW0idw9xtJbqi526Te6cx8OcG8V5TUfXgcml6/mh/H3+ui4n7lpGE3kkm
 pVe/+PAWFPgLUlc9nY02/17G95fQZF2EVzj985Oud5BLax/Xe0nnWHteSfxp3LdjUEQMtswFOoC
 OfzYc/K0E5A1jxI9/aP/MGSHrKh4bp5Y5bplCqCVQn6LGOWi1JIfbP2tBmMTorv1svN8NIHZ+hf
 hCM1o79vrgJbJkduSakaFgklakC8RY1/5coGq3unpdtkRN4t5padMHNItzTFODgFGLvv85k21sY
 2OvBlrqXXfl/ZiqHNHH7iFW6WgKylKJYok2SLDRQJ+ZwlZSGq/YHBwPOFknBTq/6Dg2FRZ2ltsQ
 JEZ2Hw1l7oFh6uqgusw==
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

Instead of executing test, just read it's output from a file. This
allows to standardize how to call check plugins scripts.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/multiarch/Makefile.target           |  3 +--
 .../multiarch/plugin/check-plugin-output.sh   | 22 ++++++-------------
 2 files changed, 8 insertions(+), 17 deletions(-)

diff --git a/tests/tcg/multiarch/Makefile.target b/tests/tcg/multiarch/Makefile.target
index 508149d57bd..f46983cc76e 100644
--- a/tests/tcg/multiarch/Makefile.target
+++ b/tests/tcg/multiarch/Makefile.target
@@ -211,8 +211,7 @@ run-plugin-test-plugin-mem-access-with-libmem.so: \
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


