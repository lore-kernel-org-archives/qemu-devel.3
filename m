Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C068FCA5FD4
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 17:54:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCKxP-0007wi-32; Thu, 01 Oct 2026 13:52:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xCKxI-0007vv-S5
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 13:52:29 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xCKxF-0001g7-5n
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 13:52:28 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 691FssBf3109794
 for <qemu-devel@nongnu.org>; Thu, 1 Oct 2026 17:52:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 epte0f1aj5wDicnKzG92tOLmHF87VnjPiezpzgTk9lU=; b=DqmG50QSdEpUPImR
 2flkejg9Sjw0p9fV7vZKH5pakyNd9x0u72u1fxHqQk8MhF2+c87oolZ+3Zd7lDXW
 vVIhZEgRZH/K9yqARbhx1GGSCGTRKdroE1jHVoGKRWdr06I68pBl5XutzkACYqPJ
 phh1/DGZ6f7DwH0K7sxYqrU2Tv2ab2uZabQVKFBMoDriNpDz/L6UFjB/3W5yJVnX
 KWihesDw1fY843GdItR7HsFY/Sw6EvxN8GSCsYCOS4zj4j1riDeqdwNWyaeqpk0E
 Kc2hzBrhqoiY1OoVTCjhyewG9asucIB1zOTl78k5tOXkgeatVSl1k75nXguyK/dO
 g32Blw==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h1jcfu0cj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 17:52:23 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-1384427c3efso10237243c88.0
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 10:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790877143; x=1791481943; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=epte0f1aj5wDicnKzG92tOLmHF87VnjPiezpzgTk9lU=;
 b=h9vHdR4NxaTizkrPz/bYysdzCbaLcpU2orqrnrMxWALy+PQ3+2Su9TylfK+AKit80m
 u87Olx7Trp87FiQOrA0bqnMFwutcX83j2Esy450KGLCbfnVH1pwd/YZOqhML0/hfJlCu
 vGNGaHCB/GAjEou6IFrtlPcshuS3M7XKrLBjQ6h6DAfx9Hm4KhhYVUmZYHkc2WCOoM7O
 xnKElXgSOn7OYDfsyycL9uRnVr8s64BNf0hAAMo4WUjYeHxKw/JYAGsh4qaR32goJDFD
 s/sapOZelSLiBggja9UrdHF3rFkizlUwSwhx0Y75PsfIgumGEAGxINIcp3ZoBeZZNBOg
 MGjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790877143; x=1791481943;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=epte0f1aj5wDicnKzG92tOLmHF87VnjPiezpzgTk9lU=;
 b=Hg0EFrex/RwRJ6GG4I5jl4dVNDm41OB+id6CXoHTMQlho1RSVqIQZmMbblZGKFBv16
 kIKBvFTPG2CFcCUDL1olA/wf0korDO61y8H6ruCuCZWGxhvqd9KAVYhCf56bVrxREeOQ
 UX73r6EI1//bivkuVwtShNZbYba0DdJylHhZeGOvFlHqj/IS7B1Kf9v2QkpnlcR0lDzQ
 K5/9aS2YgGopl1Q7CoOugPvi6pYkK6fYhaFC9kXB0ocZbkzKt5Vu+rqhCGXJIxz/R98r
 TaDYWcfpjfQ9xc8nQ5eFyH2DC6ybxXSKElNDhyb0h+CfERq6yUNF0ZtK7utwpx63khOR
 Tigg==
X-Gm-Message-State: AFuF++kkvM8DlXY9/l+5V1hGsWIqkmR5PPs3vOxfDUQEu75zsxOscv7Q
 esFC9jmg4g16+v5nO8l4YXDQIPJRRvHnbTX1DI66uvP561Lcsgt9h3sRtXW75l4rqtR5P3TF+2p
 Tz5XwhK4jbzEhiDN6EvE+ioKPp+Ez4Wk2pqImjSJnX1h7IL1Z3Sc6d2EDk6XnOjbeCg==
X-Gm-Gg: AYBFou16ylohDTmbrb3g38y78D8XgmOFz/H0FbPFCHiHdui82+NIaagLZAFQWrtPTLa
 qM+7AGJFrZoL8U4qD+u2hfHYncHcNy4Cxqiri8eVjhHtsGjkDOcSs34P9FyfZuxZ3mmKrTknoQ9
 ByqskkmMyT+pnsICXu7qrrF2dzLxA64fNo9X1nqkFGFuGRVnmnORtm3h6F9JVp5IeRj84t9XO1f
 nb9zbEok1XJTkXWchukgI9UfQcloN7usQsrlB4uEAuVnXD5KMnjAbpxKEYp+I1/L0p3hh0KPWHx
 PYxn4zxvK6Of7EqUOyWIbYT3EkBbJtaeFLY9eZfFp1+4Mh9dmtu2cvVMvbcT7iWjEiRaRj3uvHs
 UTxgLIFPr3Z3Fbo877TaABObys0KUTF0kChm1ahfdBUU/ETY1tNRt3ekSjyjI
X-Received: by 2002:a05:7022:3a89:b0:14d:b813:852d with SMTP id
 a92af1059eb24-14db822c86emr3714786c88.6.1790877142298; 
 Thu, 01 Oct 2026 10:52:22 -0700 (PDT)
X-Received: by 2002:a05:7022:3a89:b0:14d:b813:852d with SMTP id
 a92af1059eb24-14db822c86emr3714745c88.6.1790877141510; 
 Thu, 01 Oct 2026 10:52:21 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14f43fb3417sm207518c88.1.2026.10.01.10.52.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2026 10:52:20 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 03/27] tests/tcg/mipsel: add dsp tests
Date: Thu,  1 Oct 2026 17:51:39 +0000
Message-ID: <20261001175203.8673-4-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261001175203.8673-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261001175203.8673-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA3MSBTYWx0ZWRfX8fyr/xI4MLU5
 Vop6oZID8wITfmEsg+G63quqTtua2zu3/tihjS/k5gp5ie+QdlO4l1jEwc1/hcbFl4Ui82KToh/
 FBAOX7501DWaK277UJyoVf/E+VfBHqM=
X-Proofpoint-GUID: TBl2gaXHc0NJFu44a_iIiurFsG3npzvZ
X-Authority-Analysis: v=2.4 cv=b4YncdGx c=1 sm=1 tr=0 ts=6abe9dd7 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=pRlodndY1HsGRHD50IkA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-ORIG-GUID: TBl2gaXHc0NJFu44a_iIiurFsG3npzvZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA3MSBTYWx0ZWRfX6xZaF8MYzwuV
 RTNpNV0i61K37GieNQrrO/iS1YxOFgmYcRCeXH+NZKkvn+3ljggPw3AHRrDSG4RD7IsMwS9qKzB
 XQs9suX5LNXozmpNKoyLuncMDtefNyYFsYgRAiwnKP20WJBF9G/qwHh4BtpX3QDGEi34sgxONhy
 RyKSa43xaEZVnWazJYmpAaI6m2ezFJL706SzQq6sfUxBJFMyD3QEsD5XgchI/Znd6NQVkEw0Qlk
 o2NK7OIYLXwyydPswzlWtEyd3iLlBDgcbmBuj+J2O/IiOrKol8mGqE1L9biGwf1jpAVTbaTWOhE
 FD9zxqiSAEq6LIcb4OL4SpMeCQldOw9+5wSlXYAEGxV1eWv/cYfk4m+tMGoLVwgAWcpp40S60+v
 m3reAmB+EZg6iynzbl44wvIF1jZ3kB+ID7+XRivNt83scP+vR+hgBcb7KmUXIJNykz5u6fUyI+3
 k9r+gfU5qlBn2VUM4RQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010071
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Acked-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Tested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Link: https://lore.kernel.org/qemu-devel/20260929212439.110454-4-pierrick.bouvier@oss.qualcomm.com
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


