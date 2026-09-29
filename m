Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2779CA5FA1
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 07:42:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBSSA-00033Q-Bj; Tue, 29 Sep 2026 03:40:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBSS7-00032V-T6
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 03:40:40 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBSS4-0005oD-VB
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 03:40:39 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68T7TtQw3684743
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 07:40:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=CKGIt1Cr+1w
 NJvpY8xyUKtHHtgBUUNlLbhESgU1w2cg=; b=E3rJUNZ4g4B3cY9WDQUqnGT6S1c
 Mm+Zz+xCu4yK9U8jLo4eYLbyBeABtDpsIIAwkjIuCNUd57vOEFgzjBN+AoON0YM0
 2y2dnS0PcZsqKOaAk5eqPgYdEXCm+MGnDCrAd2UwMA/XsRHHh0R4t6vW4+NGzn4q
 7q5dyYD5PdR2XkKMc8wMmAqfAKWQ0XU/6oFVIg0FGCZwUtEDRMMmC7Py5ARajJGE
 qNh5dEHAYxnOm5hgMkqZVDbzAQSXdkloTXe/dwh2fgEPagI6mzdH0L+gXf64pZEO
 zlIwpnfDCLVKhQkFxplzfRRjsXDoxwVxOlONMiXTyRLbEDLt9yNroBQ5L2g==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0144srsv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 07:40:35 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-1438fef603cso8147056c88.0
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 00:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790667635; x=1791272435; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CKGIt1Cr+1wNJvpY8xyUKtHHtgBUUNlLbhESgU1w2cg=;
 b=My0jsfaB7ObiAl5caWhYzlEIaXxHsM4K6o4MAaEmZpOyzdpZOoYdxtS2LlXeweIStE
 /WJ6+t9VE2GnR7VTT/sQEji2oI99EvaRYR/VbILIVXaaZfbWVFFwDxIBqfOLvib5SHK4
 GVgVl+oOkBbfX9hXnN0pyH62R7t+7SKijUgBFg4J4qJc0il3tXO2AzFmSy3itEM6jDeW
 ZmCsSrcbQsF7L9UXDmSgeAMRBrbFZIdy4D5dPYQGwD0oMybV+gjYAPGEMemboOjuOvw1
 OuMkpO4n1t8gyXzGb8a6bWDCfK/Df9RLTz0UN57liHOVdo5hWh3DBdSc6tS+K9VGvcBQ
 a5TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790667635; x=1791272435;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=CKGIt1Cr+1wNJvpY8xyUKtHHtgBUUNlLbhESgU1w2cg=;
 b=kINHWf2EkQp0QLx8wyYE6jr09rOXTl2NZYKeGYy+OS9ZZcRXYVRoVkhYtXQ2sK0Vkd
 QI8SwL5tCOy281pzQs/48DbAg79CoY2csdN3ehrIZ05taBOrOfcsvC0jya2+BMASBhKN
 7+JB0Vv6a0f95Ttuve/iN5aeCEruPOlpTfsapZLmOVeLNAjZ+rgFAViKCz0bFdPioBKS
 HFgQTBp++nmuwlntSI4dUwi4d4BubXombjQkvRrvt7cfHLZS9cm9AQ1y9vZBPWOTxlSb
 wq71WuERpaHJYwTx2t5VJID1joWpIaFF0MVseIZ/HR79Gk/oQVvml6c/RlV+n3ug7Yj4
 NZgw==
X-Gm-Message-State: AFuF++m8BDlakQfDeH7vzUIMRvVkQl4aYqujiHTHTCPo91p5uBdlMNM2
 XR9Krv6Sed7T8/BFDsXcBxRqamyo78OLcRic2Tq393+fMXoMOl9Hv/2AwWRAgQZ1IeoAM3AbtuW
 pJyKdn0IkynVbPCS7Z13YU6lkoFgnPXnXeQo9NOAzybPUlJkZNFwawedSvtBb+YMvxg==
X-Gm-Gg: AYBFou3ZHFrUokMOLXj/4l+Z/EBjN95aAtVBaJE7iEp9fYFjr7xAnoaAs98Fd8avKHu
 3EO2VPYK83oXDp8D/mia/zSvgrvPoUJw9T6LyBsKVl2aapfQyOB5j6H6gq8CMG33pH+5TB/wDy6
 sEwChUD1l2TB3ezll2dReNayWG2/5IGVFf6Dqf25wzebz5y/w7BLS0wfv8hc5I7q5DJYaW5jZS8
 qf4IZJ4HhKY6ZWfJ0vdd6VTTR9+gzfC3pC6MYuggqlSh+h7p/ouiHNW3thnSrzIsbTDL/krJxx+
 7nS3tK7CiCi5CsTExBRb6SE0RYWCObcj6fM7WvgsZUETXZCHZGhPui+FihY/36EDCLmf0h594vO
 injy6ScwxOJ7vZWPotstCyfzy+LP+a1giI0fA0bySuZW19UJ3lae19PLQIg==
X-Received: by 2002:a05:701b:20de:20b0:145:5c7:71bc with SMTP id
 a92af1059eb24-146cddbcfddmr13696031c88.5.1790667634476; 
 Tue, 29 Sep 2026 00:40:34 -0700 (PDT)
X-Received: by 2002:a05:701b:20de:20b0:145:5c7:71bc with SMTP id
 a92af1059eb24-146cddbcfddmr13695997c88.5.1790667633901; 
 Tue, 29 Sep 2026 00:40:33 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3444fd04d93sm14647822eec.12.2026.09.29.00.40.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 00:40:33 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v2 03/19] tests/tcg/mipsel: add dsp tests
Date: Tue, 29 Sep 2026 07:39:51 +0000
Message-ID: <20260929074007.118970-4-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929074007.118970-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260929074007.118970-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAzMCBTYWx0ZWRfXxpbIrkbvx3Jp
 Gu+n23FZUx/GhCIs6PkUYXPjjrXjKKU0vTG3/FAJdjNmp+twc3SJzdY6RXt5tynWTaGOLqouH+K
 px22fADID5Zj7IR9W1XoSqLCdle4eR0ctyueJnEBmj9GH3D2QrA7H/xaQpYl2CuzNn5d1herEfF
 eV94B7Nq7LHsAnSWf0knYdF3yoJtYI8enmZJngzFhZ7KS1VTZa5Riuj859RO509w87RqN0KvvKN
 WCQLiqR17bu79x4L+BWp64Dv/psoS3Sbf2hs2XbR+TQgE/OKXMnhbRPPh4zbyabJbUAbY42d/qT
 0ag/fv1H0dNVUAMEyTNHyalroKOrDd4PNi1vOMn1uU4y1vzDAwXSCRuunAFLJJysZtTOTqSGHf0
 CtOb7HsnCZdVtoIZJuzMmrNn5YnZR9PFpkM/bZn6ObgkPE7UJ7pviVxj0ZoAhDzsjrTWLXwIu4Z
 +XqCeb6211JoqPKCxTg==
X-Authority-Analysis: v=2.4 cv=FJSOVOos c=1 sm=1 tr=0 ts=6abb6b73 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=r08_1JBvSIBucjHlN6MA:9 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-ORIG-GUID: ArCUx6lANd_0POqglzhx4TJ6ldK5atSx
X-Proofpoint-GUID: ArCUx6lANd_0POqglzhx4TJ6ldK5atSx
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAzMCBTYWx0ZWRfXyyuDkbg0mnRa
 or98XZ00z1TKmunm7SmXQbUG556tR7fxphck8WwwuZIOo2m/Js3FVQgxLwFO4jMzA9dRXO+Leqb
 ZiZuH1O9yI8c2w9aB8ptgMGdnK1lKrk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290030
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

Most of tests have unused or unused but set variables. Instead of fixing
all of them, simply silentify those (unconsequential) warnings.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 meson_options.txt             |   4 +
 scripts/meson-buildoptions.sh |   2 +
 tests/tcg/meson.build         |   1 +
 tests/tcg/mipsel/Makefile     | 184 ---------------------------------
 tests/tcg/mipsel/meson.build  | 188 ++++++++++++++++++++++++++++++++++
 5 files changed, 195 insertions(+), 184 deletions(-)
 delete mode 100644 tests/tcg/mipsel/Makefile
 create mode 100644 tests/tcg/mipsel/meson.build

diff --git a/meson_options.txt b/meson_options.txt
index 6c2de6296f7..e6dd64b5a87 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -437,6 +437,10 @@ option('tcg_tests_cross_cc_mips', type: 'string',
        description: 'cc for mips tcg tests')
 option('tcg_tests_cross_cflags_mips', type: 'string',
        description: 'cflags for mips tcg tests')
+option('tcg_tests_cross_cc_mipsel', type: 'string',
+       description: 'cc for mipsel tcg tests')
+option('tcg_tests_cross_cflags_mipsel', type: 'string',
+       description: 'cflags for mipsel tcg tests')
 option('tcg_tests_cross_cc_mips64', type: 'string',
        description: 'cc for mips64 tcg tests')
 option('tcg_tests_cross_cflags_mips64', type: 'string',
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index 08c9fbb62cd..b46005ee96c 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -540,6 +540,7 @@ _meson_option_parse() {
     --tcg-tests-cross-cc-mips=*) quote_sh "-Dtcg_tests_cross_cc_mips=$2" ;;
     --tcg-tests-cross-cc-mips64=*) quote_sh "-Dtcg_tests_cross_cc_mips64=$2" ;;
     --tcg-tests-cross-cc-mips64el=*) quote_sh "-Dtcg_tests_cross_cc_mips64el=$2" ;;
+    --tcg-tests-cross-cc-mipsel=*) quote_sh "-Dtcg_tests_cross_cc_mipsel=$2" ;;
     --tcg-tests-cross-cc-or1k=*) quote_sh "-Dtcg_tests_cross_cc_or1k=$2" ;;
     --tcg-tests-cross-cc-ppc64=*) quote_sh "-Dtcg_tests_cross_cc_ppc64=$2" ;;
     --tcg-tests-cross-cc-ppc64le=*) quote_sh "-Dtcg_tests_cross_cc_ppc64le=$2" ;;
@@ -562,6 +563,7 @@ _meson_option_parse() {
     --tcg-tests-cross-cflags-mips=*) quote_sh "-Dtcg_tests_cross_cflags_mips=$2" ;;
     --tcg-tests-cross-cflags-mips64=*) quote_sh "-Dtcg_tests_cross_cflags_mips64=$2" ;;
     --tcg-tests-cross-cflags-mips64el=*) quote_sh "-Dtcg_tests_cross_cflags_mips64el=$2" ;;
+    --tcg-tests-cross-cflags-mipsel=*) quote_sh "-Dtcg_tests_cross_cflags_mipsel=$2" ;;
     --tcg-tests-cross-cflags-or1k=*) quote_sh "-Dtcg_tests_cross_cflags_or1k=$2" ;;
     --tcg-tests-cross-cflags-ppc64=*) quote_sh "-Dtcg_tests_cross_cflags_ppc64=$2" ;;
     --tcg-tests-cross-cflags-ppc64le=*) quote_sh "-Dtcg_tests_cross_cflags_ppc64le=$2" ;;
diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 96d5d1249f2..4c0e30756d5 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -180,6 +180,7 @@ subdir('i386')
 subdir('loongarch64')
 subdir('m68k')
 subdir('mips')
+subdir('mipsel')
 subdir('mips64')
 subdir('mips64el')
 subdir('or1k')
diff --git a/tests/tcg/mipsel/Makefile b/tests/tcg/mipsel/Makefile
deleted file mode 100644
index 5c6da96870e..00000000000
--- a/tests/tcg/mipsel/Makefile
+++ /dev/null
@@ -1,184 +0,0 @@
--include ../../../../config-host.mak
-
-CROSS=mips64el-unknown-linux-gnu-
-
-SIM=qemu-mipsel
-SIM_FLAGS=-cpu 74Kf
-
-CC      = $(CROSS)gcc
-CFLAGS  = -EL -mabi=32 -march=mips32r2 -mgp32 -mdsp -mdspr2 -static
-
-TESTCASES  = test_dsp_r1_absq_s_ph.tst
-TESTCASES += test_dsp_r1_absq_s_w.tst
-TESTCASES += test_dsp_r1_addq_ph.tst
-TESTCASES += test_dsp_r1_addq_s_ph.tst
-TESTCASES += test_dsp_r1_addq_s_w.tst
-TESTCASES += test_dsp_r1_addsc.tst
-TESTCASES += test_dsp_r1_addu_qb.tst
-TESTCASES += test_dsp_r1_addu_s_qb.tst
-TESTCASES += test_dsp_r1_addwc.tst
-TESTCASES += test_dsp_r1_bitrev.tst
-TESTCASES += test_dsp_r1_bposge32.tst
-TESTCASES += test_dsp_r1_cmp_eq_ph.tst
-TESTCASES += test_dsp_r1_cmpgu_eq_qb.tst
-TESTCASES += test_dsp_r1_cmpgu_le_qb.tst
-TESTCASES += test_dsp_r1_cmpgu_lt_qb.tst
-TESTCASES += test_dsp_r1_cmp_le_ph.tst
-TESTCASES += test_dsp_r1_cmp_lt_ph.tst
-TESTCASES += test_dsp_r1_cmpu_eq_qb.tst
-TESTCASES += test_dsp_r1_cmpu_le_qb.tst
-TESTCASES += test_dsp_r1_cmpu_lt_qb.tst
-TESTCASES += test_dsp_r1_dpaq_sa_l_w.tst
-TESTCASES += test_dsp_r1_dpaq_s_w_ph.tst
-TESTCASES += test_dsp_r1_dpau_h_qbl.tst
-TESTCASES += test_dsp_r1_dpau_h_qbr.tst
-TESTCASES += test_dsp_r1_dpsq_sa_l_w.tst
-TESTCASES += test_dsp_r1_dpsq_s_w_ph.tst
-TESTCASES += test_dsp_r1_dpsu_h_qbl.tst
-TESTCASES += test_dsp_r1_dpsu_h_qbr.tst
-TESTCASES += test_dsp_r1_extp.tst
-TESTCASES += test_dsp_r1_extpdp.tst
-TESTCASES += test_dsp_r1_extpdpv.tst
-TESTCASES += test_dsp_r1_extpv.tst
-TESTCASES += test_dsp_r1_extr_rs_w.tst
-TESTCASES += test_dsp_r1_extr_r_w.tst
-TESTCASES += test_dsp_r1_extr_s_h.tst
-TESTCASES += test_dsp_r1_extrv_rs_w.tst
-TESTCASES += test_dsp_r1_extrv_r_w.tst
-TESTCASES += test_dsp_r1_extrv_s_h.tst
-TESTCASES += test_dsp_r1_extrv_w.tst
-TESTCASES += test_dsp_r1_extr_w.tst
-TESTCASES += test_dsp_r1_insv.tst
-TESTCASES += test_dsp_r1_lbux.tst
-TESTCASES += test_dsp_r1_lhx.tst
-TESTCASES += test_dsp_r1_lwx.tst
-TESTCASES += test_dsp_r1_madd.tst
-TESTCASES += test_dsp_r1_maddu.tst
-TESTCASES += test_dsp_r1_maq_sa_w_phl.tst
-TESTCASES += test_dsp_r1_maq_sa_w_phr.tst
-TESTCASES += test_dsp_r1_maq_s_w_phl.tst
-TESTCASES += test_dsp_r1_maq_s_w_phr.tst
-TESTCASES += test_dsp_r1_mfhi.tst
-TESTCASES += test_dsp_r1_mflo.tst
-TESTCASES += test_dsp_r1_modsub.tst
-TESTCASES += test_dsp_r1_msub.tst
-TESTCASES += test_dsp_r1_msubu.tst
-TESTCASES += test_dsp_r1_mthi.tst
-TESTCASES += test_dsp_r1_mthlip.tst
-TESTCASES += test_dsp_r1_mtlo.tst
-TESTCASES += test_dsp_r1_muleq_s_w_phl.tst
-TESTCASES += test_dsp_r1_muleq_s_w_phr.tst
-TESTCASES += test_dsp_r1_muleu_s_ph_qbl.tst
-TESTCASES += test_dsp_r1_muleu_s_ph_qbr.tst
-TESTCASES += test_dsp_r1_mulq_rs_ph.tst
-TESTCASES += test_dsp_r1_mult.tst
-TESTCASES += test_dsp_r1_multu.tst
-TESTCASES += test_dsp_r1_packrl_ph.tst
-TESTCASES += test_dsp_r1_pick_ph.tst
-TESTCASES += test_dsp_r1_pick_qb.tst
-TESTCASES += test_dsp_r1_precequ_ph_qbla.tst
-TESTCASES += test_dsp_r1_precequ_ph_qbl.tst
-TESTCASES += test_dsp_r1_precequ_ph_qbra.tst
-TESTCASES += test_dsp_r1_precequ_ph_qbr.tst
-TESTCASES += test_dsp_r1_preceq_w_phl.tst
-TESTCASES += test_dsp_r1_preceq_w_phr.tst
-TESTCASES += test_dsp_r1_preceu_ph_qbla.tst
-TESTCASES += test_dsp_r1_preceu_ph_qbl.tst
-TESTCASES += test_dsp_r1_preceu_ph_qbra.tst
-TESTCASES += test_dsp_r1_preceu_ph_qbr.tst
-TESTCASES += test_dsp_r1_precrq_ph_w.tst
-TESTCASES += test_dsp_r1_precrq_qb_ph.tst
-TESTCASES += test_dsp_r1_precrq_rs_ph_w.tst
-TESTCASES += test_dsp_r1_precrqu_s_qb_ph.tst
-TESTCASES += test_dsp_r1_raddu_w_qb.tst
-TESTCASES += test_dsp_r1_rddsp.tst
-TESTCASES += test_dsp_r1_repl_ph.tst
-TESTCASES += test_dsp_r1_repl_qb.tst
-TESTCASES += test_dsp_r1_replv_ph.tst
-TESTCASES += test_dsp_r1_replv_qb.tst
-TESTCASES += test_dsp_r1_shilo.tst
-TESTCASES += test_dsp_r1_shilov.tst
-TESTCASES += test_dsp_r1_shll_ph.tst
-TESTCASES += test_dsp_r1_shll_qb.tst
-TESTCASES += test_dsp_r1_shll_s_ph.tst
-TESTCASES += test_dsp_r1_shll_s_w.tst
-TESTCASES += test_dsp_r1_shllv_ph.tst
-TESTCASES += test_dsp_r1_shllv_qb.tst
-TESTCASES += test_dsp_r1_shllv_s_ph.tst
-TESTCASES += test_dsp_r1_shllv_s_w.tst
-TESTCASES += test_dsp_r1_shra_ph.tst
-TESTCASES += test_dsp_r1_shra_r_ph.tst
-TESTCASES += test_dsp_r1_shra_r_w.tst
-TESTCASES += test_dsp_r1_shrav_ph.tst
-TESTCASES += test_dsp_r1_shrav_r_ph.tst
-TESTCASES += test_dsp_r1_shrav_r_w.tst
-TESTCASES += test_dsp_r1_shrl_qb.tst
-TESTCASES += test_dsp_r1_shrlv_qb.tst
-TESTCASES += test_dsp_r1_subq_ph.tst
-TESTCASES += test_dsp_r1_subq_s_ph.tst
-TESTCASES += test_dsp_r1_subq_s_w.tst
-TESTCASES += test_dsp_r1_subu_qb.tst
-TESTCASES += test_dsp_r1_subu_s_qb.tst
-TESTCASES += test_dsp_r1_wrdsp.tst
-TESTCASES += test_dsp_r2_absq_s_qb.tst
-TESTCASES += test_dsp_r2_addqh_ph.tst
-TESTCASES += test_dsp_r2_addqh_r_ph.tst
-TESTCASES += test_dsp_r2_addqh_r_w.tst
-TESTCASES += test_dsp_r2_addqh_w.tst
-TESTCASES += test_dsp_r2_adduh_qb.tst
-TESTCASES += test_dsp_r2_adduh_r_qb.tst
-TESTCASES += test_dsp_r2_addu_ph.tst
-TESTCASES += test_dsp_r2_addu_s_ph.tst
-TESTCASES += test_dsp_r2_append.tst
-TESTCASES += test_dsp_r2_balign.tst
-TESTCASES += test_dsp_r2_cmpgdu_eq_qb.tst
-TESTCASES += test_dsp_r2_cmpgdu_le_qb.tst
-TESTCASES += test_dsp_r2_cmpgdu_lt_qb.tst
-TESTCASES += test_dsp_r2_dpaqx_sa_w_ph.tst
-TESTCASES += test_dsp_r2_dpa_w_ph.tst
-TESTCASES += test_dsp_r2_dpax_w_ph.tst
-TESTCASES += test_dsp_r2_dpaqx_s_w_ph.tst
-TESTCASES += test_dsp_r2_dpsqx_sa_w_ph.tst
-TESTCASES += test_dsp_r2_dpsqx_s_w_ph.tst
-TESTCASES += test_dsp_r2_dps_w_ph.tst
-TESTCASES += test_dsp_r2_dpsx_w_ph.tst
-TESTCASES += test_dsp_r2_mul_ph.tst
-TESTCASES += test_dsp_r2_mulq_rs_w.tst
-TESTCASES += test_dsp_r2_mulq_s_ph.tst
-TESTCASES += test_dsp_r2_mulq_s_w.tst
-TESTCASES += test_dsp_r2_mulsaq_s_w_ph.tst
-TESTCASES += test_dsp_r2_mulsa_w_ph.tst
-TESTCASES += test_dsp_r2_mul_s_ph.tst
-TESTCASES += test_dsp_r2_precr_qb_ph.tst
-TESTCASES += test_dsp_r2_precr_sra_ph_w.tst
-TESTCASES += test_dsp_r2_precr_sra_r_ph_w.tst
-TESTCASES += test_dsp_r2_prepend.tst
-TESTCASES += test_dsp_r2_shra_qb.tst
-TESTCASES += test_dsp_r2_shra_r_qb.tst
-TESTCASES += test_dsp_r2_shrav_qb.tst
-TESTCASES += test_dsp_r2_shrav_r_qb.tst
-TESTCASES += test_dsp_r2_shrl_ph.tst
-TESTCASES += test_dsp_r2_shrlv_ph.tst
-TESTCASES += test_dsp_r2_subqh_ph.tst
-TESTCASES += test_dsp_r2_subqh_r_ph.tst
-TESTCASES += test_dsp_r2_subqh_r_w.tst
-TESTCASES += test_dsp_r2_subqh_w.tst
-TESTCASES += test_dsp_r2_subuh_qb.tst
-TESTCASES += test_dsp_r2_subuh_r_qb.tst
-TESTCASES += test_dsp_r2_subu_ph.tst
-TESTCASES += test_dsp_r2_subu_s_ph.tst
-
-
-all: $(TESTCASES)
-
-%.tst: %.c
-	$(CC) $(CFLAGS) $< -o $@
-
-check: $(TESTCASES)
-	@for case in $(TESTCASES); do \
-        echo $(SIM) $(SIM_FLAGS) ./$$case;\
-        $(SIM) $(SIM_FLAGS) ./$$case; \
-	done
-
-clean:
-	$(RM) -rf $(TESTCASES)
diff --git a/tests/tcg/mipsel/meson.build b/tests/tcg/mipsel/meson.build
new file mode 100644
index 00000000000..0bf7e840a7d
--- /dev/null
+++ b/tests/tcg/mipsel/meson.build
@@ -0,0 +1,188 @@
+tests = []
+
+tests_dsp = [
+  'test_dsp_r1_absq_s_ph.c',
+  'test_dsp_r1_absq_s_w.c',
+  'test_dsp_r1_addq_ph.c',
+  'test_dsp_r1_addq_s_ph.c',
+  'test_dsp_r1_addq_s_w.c',
+  'test_dsp_r1_addsc.c',
+  'test_dsp_r1_addu_qb.c',
+  'test_dsp_r1_addu_s_qb.c',
+  'test_dsp_r1_addwc.c',
+  'test_dsp_r1_bitrev.c',
+  'test_dsp_r1_bposge32.c',
+  'test_dsp_r1_cmp_eq_ph.c',
+  'test_dsp_r1_cmp_le_ph.c',
+  'test_dsp_r1_cmp_lt_ph.c',
+  'test_dsp_r1_cmpgu_eq_qb.c',
+  'test_dsp_r1_cmpgu_le_qb.c',
+  'test_dsp_r1_cmpgu_lt_qb.c',
+  'test_dsp_r1_cmpu_eq_qb.c',
+  'test_dsp_r1_cmpu_le_qb.c',
+  'test_dsp_r1_cmpu_lt_qb.c',
+  'test_dsp_r1_dpaq_s_w_ph.c',
+  'test_dsp_r1_dpaq_sa_l_w.c',
+  'test_dsp_r1_dpau_h_qbl.c',
+  'test_dsp_r1_dpau_h_qbr.c',
+  'test_dsp_r1_dpsq_s_w_ph.c',
+  'test_dsp_r1_dpsq_sa_l_w.c',
+  'test_dsp_r1_dpsu_h_qbl.c',
+  'test_dsp_r1_dpsu_h_qbr.c',
+  'test_dsp_r1_extp.c',
+  'test_dsp_r1_extpdp.c',
+  'test_dsp_r1_extpdpv.c',
+  'test_dsp_r1_extpv.c',
+  'test_dsp_r1_extr_r_w.c',
+  'test_dsp_r1_extr_rs_w.c',
+  'test_dsp_r1_extr_s_h.c',
+  'test_dsp_r1_extr_w.c',
+  'test_dsp_r1_extrv_r_w.c',
+  'test_dsp_r1_extrv_rs_w.c',
+  'test_dsp_r1_extrv_s_h.c',
+  'test_dsp_r1_extrv_w.c',
+  'test_dsp_r1_insv.c',
+  'test_dsp_r1_lbux.c',
+  'test_dsp_r1_lhx.c',
+  'test_dsp_r1_lwx.c',
+  'test_dsp_r1_madd.c',
+  'test_dsp_r1_maddu.c',
+  'test_dsp_r1_main.c',
+  'test_dsp_r1_maq_s_w_phl.c',
+  'test_dsp_r1_maq_s_w_phr.c',
+  'test_dsp_r1_maq_sa_w_phl.c',
+  'test_dsp_r1_maq_sa_w_phr.c',
+  'test_dsp_r1_mfhi.c',
+  'test_dsp_r1_mflo.c',
+  'test_dsp_r1_modsub.c',
+  'test_dsp_r1_msub.c',
+  'test_dsp_r1_msubu.c',
+  'test_dsp_r1_mthi.c',
+  'test_dsp_r1_mthlip.c',
+  'test_dsp_r1_mtlo.c',
+  'test_dsp_r1_muleq_s_w_phl.c',
+  'test_dsp_r1_muleq_s_w_phr.c',
+  'test_dsp_r1_muleu_s_ph_qbl.c',
+  'test_dsp_r1_muleu_s_ph_qbr.c',
+  'test_dsp_r1_mulq_rs_ph.c',
+  'test_dsp_r1_mult.c',
+  'test_dsp_r1_multu.c',
+  'test_dsp_r1_packrl_ph.c',
+  'test_dsp_r1_pick_ph.c',
+  'test_dsp_r1_pick_qb.c',
+  'test_dsp_r1_preceq_w_phl.c',
+  'test_dsp_r1_preceq_w_phr.c',
+  'test_dsp_r1_precequ_ph_qbl.c',
+  'test_dsp_r1_precequ_ph_qbla.c',
+  'test_dsp_r1_precequ_ph_qbr.c',
+  'test_dsp_r1_precequ_ph_qbra.c',
+  'test_dsp_r1_preceu_ph_qbl.c',
+  'test_dsp_r1_preceu_ph_qbla.c',
+  'test_dsp_r1_preceu_ph_qbr.c',
+  'test_dsp_r1_preceu_ph_qbra.c',
+  'test_dsp_r1_precrq_ph_w.c',
+  'test_dsp_r1_precrq_qb_ph.c',
+  'test_dsp_r1_precrq_rs_ph_w.c',
+  'test_dsp_r1_precrqu_s_qb_ph.c',
+  'test_dsp_r1_raddu_w_qb.c',
+  'test_dsp_r1_rddsp.c',
+  'test_dsp_r1_repl_ph.c',
+  'test_dsp_r1_repl_qb.c',
+  'test_dsp_r1_replv_ph.c',
+  'test_dsp_r1_replv_qb.c',
+  'test_dsp_r1_shilo.c',
+  'test_dsp_r1_shilov.c',
+  'test_dsp_r1_shll_ph.c',
+  'test_dsp_r1_shll_qb.c',
+  'test_dsp_r1_shll_s_ph.c',
+  'test_dsp_r1_shll_s_w.c',
+  'test_dsp_r1_shllv_ph.c',
+  'test_dsp_r1_shllv_qb.c',
+  'test_dsp_r1_shllv_s_ph.c',
+  'test_dsp_r1_shllv_s_w.c',
+  'test_dsp_r1_shra_ph.c',
+  'test_dsp_r1_shra_r_ph.c',
+  'test_dsp_r1_shra_r_w.c',
+  'test_dsp_r1_shrav_ph.c',
+  'test_dsp_r1_shrav_r_ph.c',
+  'test_dsp_r1_shrav_r_w.c',
+  'test_dsp_r1_shrl_qb.c',
+  'test_dsp_r1_shrlv_qb.c',
+  'test_dsp_r1_subq_ph.c',
+  'test_dsp_r1_subq_s_ph.c',
+  'test_dsp_r1_subq_s_w.c',
+  'test_dsp_r1_subu_qb.c',
+  'test_dsp_r1_subu_s_qb.c',
+  'test_dsp_r1_wrdsp.c',
+  'test_dsp_r2_absq_s_qb.c',
+  'test_dsp_r2_addqh_ph.c',
+  'test_dsp_r2_addqh_r_ph.c',
+  'test_dsp_r2_addqh_r_w.c',
+  'test_dsp_r2_addqh_w.c',
+  'test_dsp_r2_addu_ph.c',
+  'test_dsp_r2_addu_s_ph.c',
+  'test_dsp_r2_adduh_qb.c',
+  'test_dsp_r2_adduh_r_qb.c',
+  'test_dsp_r2_append.c',
+  'test_dsp_r2_balign.c',
+  'test_dsp_r2_cmpgdu_eq_qb.c',
+  'test_dsp_r2_cmpgdu_le_qb.c',
+  'test_dsp_r2_cmpgdu_lt_qb.c',
+  'test_dsp_r2_dpa_w_ph.c',
+  'test_dsp_r2_dpaqx_s_w_ph.c',
+  'test_dsp_r2_dpaqx_sa_w_ph.c',
+  'test_dsp_r2_dpax_w_ph.c',
+  'test_dsp_r2_dps_w_ph.c',
+  'test_dsp_r2_dpsqx_s_w_ph.c',
+  'test_dsp_r2_dpsqx_sa_w_ph.c',
+  'test_dsp_r2_dpsx_w_ph.c',
+  'test_dsp_r2_mul_ph.c',
+  'test_dsp_r2_mul_s_ph.c',
+  'test_dsp_r2_mulq_rs_w.c',
+  'test_dsp_r2_mulq_s_ph.c',
+  'test_dsp_r2_mulq_s_w.c',
+  'test_dsp_r2_mulsa_w_ph.c',
+  'test_dsp_r2_mulsaq_s_w_ph.c',
+  'test_dsp_r2_precr_qb_ph.c',
+  'test_dsp_r2_precr_sra_ph_w.c',
+  'test_dsp_r2_precr_sra_r_ph_w.c',
+  'test_dsp_r2_prepend.c',
+  'test_dsp_r2_shra_qb.c',
+  'test_dsp_r2_shra_r_qb.c',
+  'test_dsp_r2_shrav_qb.c',
+  'test_dsp_r2_shrav_r_qb.c',
+  'test_dsp_r2_shrl_ph.c',
+  'test_dsp_r2_shrlv_ph.c',
+  'test_dsp_r2_subqh_ph.c',
+  'test_dsp_r2_subqh_r_ph.c',
+  'test_dsp_r2_subqh_r_w.c',
+  'test_dsp_r2_subqh_w.c',
+  'test_dsp_r2_subu_ph.c',
+  'test_dsp_r2_subu_s_ph.c',
+  'test_dsp_r2_subuh_qb.c',
+  'test_dsp_r2_subuh_r_qb.c',
+]
+
+foreach src: tests_dsp
+  tests += {
+    src: {
+      'cflags': ['-EL', '-mabi=32', '-march=mips32r2', '-mgp32', '-mdsp', '-mdspr2',
+                 '-Wno-unused-but-set-variable', '-Wno-unused-variable'],
+      'qemu_args': ['-cpu', '74Kf'],
+    }
+  }
+endforeach
+
+if 'qemu-mipsel' in emulators
+  tcg_tests += {
+    'mipsel-linux-user': {
+      'cc': 'mipsel-linux-gnu-gcc',
+      'cc_dockerfile': 'debian-all-test-cross',
+      'cc_feat_cflags': cc_feat_cflags,
+      'folder': 'mipsel',
+      'gdb_arch': 'mipsel',
+      'qemu': emulators['qemu-mipsel'],
+      'tests': tests,
+    }
+  }
+endif
-- 
2.43.0


