Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BB7BCA5FDB
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 17:55:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCKxn-00084w-CK; Thu, 01 Oct 2026 13:52:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xCKxk-00083j-EC
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 13:52:56 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xCKxi-0001pz-6V
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 13:52:55 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 691Fsp9x3109777
 for <qemu-devel@nongnu.org>; Thu, 1 Oct 2026 17:52:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 AfEcfmX7ATQx4Q7eFK5jwAu3dcnu/LwODDC7eGvmPwA=; b=hYfktHhk66CgID4g
 G247njl7C4zJtA6MM14Q19nX4uFKneys5Md7mA8haBkbkLuLxcCm+lhr+soTpha8
 X8onVSi0SU98amU73G1nEyZYHo9dztMBIC1TsQVCpjIJBJwEJ6DIOPltt1ghqHIf
 s7aYlXOT753D4U3ZSt4W+BP87KRIZ7EFs01KGO4WteSsW6xJJ2PyYt4UT8QOX54l
 J/IIiVztcij9y5yLjeI4c8f2MTIkPgQq76HV/wrFfD8chjHu42xtRAYXTuQXq3zu
 iptMgpPK5rQMq4HTpr+K2Pp/U7rb7slS0Cxz6goEV/kBxtYiCDL13+70bbsas+7D
 oP0Tww==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h1jcfu0et-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 17:52:43 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-34afa104860so4423961eec.1
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 10:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790877162; x=1791481962; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=AfEcfmX7ATQx4Q7eFK5jwAu3dcnu/LwODDC7eGvmPwA=;
 b=hXHBa2uW7+7FRWmv6mfEEv/RpLe6IvQmoRmKoT8CKWWfRYGTJiz3xCpo7THay5QDU9
 dwp59Q+vljklhuTboMWXX6V/RTZsixpNwbCHaKQqr8CwSsDbdg/RMFfndIl/eVCKCgdx
 +EzYsr59/KeRrRG+SKb92ZrkfRdlE3NS/8PScXye569NLiU5ocMj8OWjf6E/ZUu7S2+X
 rHda1DpBg7MBmhyoiGkWZTmzfBukQV7H3EX3VlTbVptVr7Fe5D3jOE8DPy4IzJkqrK8w
 SxmdvYHbXWn/KU+CwCtXnjlQbamHAhn20q6XM/w5P5gOtIG4/o+pUTXXVPwV/iaFUg2a
 qhMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790877162; x=1791481962;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AfEcfmX7ATQx4Q7eFK5jwAu3dcnu/LwODDC7eGvmPwA=;
 b=HU+7ipXHX91IwzSOO550YogyTgKcDGp5Quw/srqyEOf17GOLncl5OoID3jYyyFCPGA
 0Htxg5twnd3xNPfnpcZ2N443gSaVZpR2H1wgtreBs/N3eKJah5hG4HCXahypJ2VIxTPM
 ct6A9hrfInxUJFFhgHuJaXhh97J2mImrlxZk7xR1CanVZvRXRYSFXTnpDDjo383q/PDr
 6Z5DLXxCn2PLJeyN5oEgWR4+0E0Vk2ekalcODX2Y0rp5DtwFLasYl+AVTMUYxrkbFrze
 xcCpCTPRe5pY6u2wME+XhQeMQRZGp4JzTVig5njtPpK/yExjI/IzLDYMFVk8kll8vTqY
 fXgw==
X-Gm-Message-State: AFuF++lPJdol/1yLQCc9c25A6BnXwYYDm1JK6W8p7HveYczwE8s7W2V+
 9aOHWECRZcImmBDacUU7T3RiPNtlKdfA/nBhD6NhCRnmzJ2o9sJ1wTFGitRabF5kYph4ONZ3mTj
 QT3HBxbki/+SSngpx5E0HAqrE6tCM6SlwxyKzY1NfCDDenAfLZZb+lqN9JRGxtwqq9w==
X-Gm-Gg: AYBFou347QscOiVyr6PAjSJthY5rAlGTWgS0et/IvgslphvzjY71T8SlOXctyw5y7Pn
 Gz0fLQoTwBa1Yby78/lrqhHlTMbuELWtse9fmMuRXkwlze4PAAfK0ZvV2+S7886JQpyPBpbGlc6
 l6ef4u0UkWm7SvnceaqfOBwVRaGCZ3Vd3L8+Hzn4QUq4fAMSn4cx3Ib75by5uZdp/g/A8yj1m6c
 vtSlCWrTXWLeWZ2n4+6UP1Kk5zI+/CLa+DzzgT8WhJN2Ep8/KAMdymmu7usJagC02PUnovzlfbB
 GKJ5EtM08ZuPKcOHno++BQhmyl6ocvoOPAe6q2SGGLK9Dfe3huAYtgmDwaKz+7OGBECNo+g20Ru
 YglCvHUuBGKTW3GSKjaIGs6KKXI85FMlKkbdGu26Oc2m9JuSEAtI/Pr/Iz5Us
X-Received: by 2002:a05:701b:4559:20b0:14b:ff40:af3d with SMTP id
 a92af1059eb24-14d2fbca49fmr5133179c88.2.1790877162023; 
 Thu, 01 Oct 2026 10:52:42 -0700 (PDT)
X-Received: by 2002:a05:701b:4559:20b0:14b:ff40:af3d with SMTP id
 a92af1059eb24-14d2fbca49fmr5133155c88.2.1790877161442; 
 Thu, 01 Oct 2026 10:52:41 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14f43fb3417sm207518c88.1.2026.10.01.10.52.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2026 10:52:40 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 19/27] tests/tcg/mips64: add mips64r6(el) tests
Date: Thu,  1 Oct 2026 17:51:55 +0000
Message-ID: <20261001175203.8673-20-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261001175203.8673-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261001175203.8673-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA3MSBTYWx0ZWRfX54zPVLzZ8V23
 DY2ljQk/INHZ7MWBFip1aUAUhhu8U9y6NIiVAjWRfgv4/ond75Wparc3aFKfLLhm8Zbhta3tXac
 YMlG+1oyzwd7R9cDC6TgjWFDk+d46lI=
X-Proofpoint-GUID: 2ripZKVAkZd2Zs7Zrap0gRqbRTeMuoXC
X-Authority-Analysis: v=2.4 cv=b4YncdGx c=1 sm=1 tr=0 ts=6abe9deb cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=wCgUcsEHi0jYncpm0KkA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: 2ripZKVAkZd2Zs7Zrap0gRqbRTeMuoXC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA3MSBTYWx0ZWRfX8T0UFDKQdSbN
 nExYo4ZGuL/X9ba7OkhqicGO0LzPHPX13KtPngQDHzMwz4c33vJj/J1c+FvbXdc/xiWCKp37tfv
 qqKn7FPY87ZTiN/OX3exyLh5+mDmd3Oc4n4b7lNrPNBmH/a1Mqj3PcBx8I3+pOS5yyh5dOXcgtR
 OwAms18L16p7Gy6WCsPuVu8fcyp+vCtAwBi13jL6jlfO7fT1zDIkMTm/Z2Oc7PZd1qMflpH0Leo
 7S5kaMswPGgv2bATvg3m4aZua/IXf+9zBJrGp3xA0Jw6fuUPqwOQRMDhx9EGlClPZZLbIYrhwkz
 OOH+yRw/BkBp8vgTTW79cgzqhOd8/+OXmqC+GKb24pTH9DAG2CgsfyH2roYnWPfF40/T5/X/UGx
 K0eJBhbHGwICOFu/3Z0WE6VRav/qZQV7nLtiAzWfCk3SIQdDSlnrByTyxgFpuOwVojR+wKgbE+k
 C2bpR6302NhRX3ogzQQ==
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

We need to define two new test suites mips64r6-linux-user and
mips64r6el-linux-user to be able to use a different compiler from
mips64-linux-user, as cc is setup only once per suite.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Link: https://lore.kernel.org/qemu-devel/20260929212439.110454-20-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 meson_options.txt              |  8 +++++
 scripts/meson-buildoptions.sh  |  4 +++
 tests/tcg/mips64/meson.build   | 57 ++++++++++++++++++++++++++++++++++
 tests/tcg/mips64el/meson.build | 11 +++++++
 4 files changed, 80 insertions(+)

diff --git a/meson_options.txt b/meson_options.txt
index e6dd64b5a87..07b016c0fd4 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -445,6 +445,14 @@ option('tcg_tests_cross_cc_mips64', type: 'string',
        description: 'cc for mips64 tcg tests')
 option('tcg_tests_cross_cflags_mips64', type: 'string',
        description: 'cflags for mips64 tcg tests')
+option('tcg_tests_cross_cc_mips64r6', type: 'string',
+       description: 'cc for mips64r6 tcg tests')
+option('tcg_tests_cross_cflags_mips64r6', type: 'string',
+       description: 'cflags for mips64r6 tcg tests')
+option('tcg_tests_cross_cc_mips64r6el', type: 'string',
+       description: 'cc for mips64r6el tcg tests')
+option('tcg_tests_cross_cflags_mips64r6el', type: 'string',
+       description: 'cflags for mips64r6el tcg tests')
 option('tcg_tests_cross_cc_mips64el', type: 'string',
        description: 'cc for mips64el tcg tests')
 option('tcg_tests_cross_cflags_mips64el', type: 'string',
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index b46005ee96c..4076a7f6b59 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -540,6 +540,8 @@ _meson_option_parse() {
     --tcg-tests-cross-cc-mips=*) quote_sh "-Dtcg_tests_cross_cc_mips=$2" ;;
     --tcg-tests-cross-cc-mips64=*) quote_sh "-Dtcg_tests_cross_cc_mips64=$2" ;;
     --tcg-tests-cross-cc-mips64el=*) quote_sh "-Dtcg_tests_cross_cc_mips64el=$2" ;;
+    --tcg-tests-cross-cc-mips64r6=*) quote_sh "-Dtcg_tests_cross_cc_mips64r6=$2" ;;
+    --tcg-tests-cross-cc-mips64r6el=*) quote_sh "-Dtcg_tests_cross_cc_mips64r6el=$2" ;;
     --tcg-tests-cross-cc-mipsel=*) quote_sh "-Dtcg_tests_cross_cc_mipsel=$2" ;;
     --tcg-tests-cross-cc-or1k=*) quote_sh "-Dtcg_tests_cross_cc_or1k=$2" ;;
     --tcg-tests-cross-cc-ppc64=*) quote_sh "-Dtcg_tests_cross_cc_ppc64=$2" ;;
@@ -563,6 +565,8 @@ _meson_option_parse() {
     --tcg-tests-cross-cflags-mips=*) quote_sh "-Dtcg_tests_cross_cflags_mips=$2" ;;
     --tcg-tests-cross-cflags-mips64=*) quote_sh "-Dtcg_tests_cross_cflags_mips64=$2" ;;
     --tcg-tests-cross-cflags-mips64el=*) quote_sh "-Dtcg_tests_cross_cflags_mips64el=$2" ;;
+    --tcg-tests-cross-cflags-mips64r6=*) quote_sh "-Dtcg_tests_cross_cflags_mips64r6=$2" ;;
+    --tcg-tests-cross-cflags-mips64r6el=*) quote_sh "-Dtcg_tests_cross_cflags_mips64r6el=$2" ;;
     --tcg-tests-cross-cflags-mipsel=*) quote_sh "-Dtcg_tests_cross_cflags_mipsel=$2" ;;
     --tcg-tests-cross-cflags-or1k=*) quote_sh "-Dtcg_tests_cross_cflags_or1k=$2" ;;
     --tcg-tests-cross-cflags-ppc64=*) quote_sh "-Dtcg_tests_cross_cflags_ppc64=$2" ;;
diff --git a/tests/tcg/mips64/meson.build b/tests/tcg/mips64/meson.build
index f08d1182576..676a47f5c8f 100644
--- a/tests/tcg/mips64/meson.build
+++ b/tests/tcg/mips64/meson.build
@@ -23,3 +23,60 @@ if 'qemu-mips64' in emulators
     }
   }
 endif
+
+tests = []
+
+tests_mips64r6 = [
+  '../mips64/test_mips64r6_and.c',
+  '../mips64/test_mips64r6_bitswap.c',
+  '../mips64/test_mips64r6_clo.c',
+  '../mips64/test_mips64r6_clz.c',
+  '../mips64/test_mips64r6_crc32b.c',
+  '../mips64/test_mips64r6_crc32cb.c',
+  '../mips64/test_mips64r6_crc32cd.c',
+  '../mips64/test_mips64r6_crc32ch.c',
+  '../mips64/test_mips64r6_crc32cw.c',
+  '../mips64/test_mips64r6_crc32d.c',
+  '../mips64/test_mips64r6_crc32h.c',
+  '../mips64/test_mips64r6_crc32w.c',
+  '../mips64/test_mips64r6_dbitswap.c',
+  '../mips64/test_mips64r6_dclo.c',
+  '../mips64/test_mips64r6_dclz.c',
+  '../mips64/test_mips64r6_dmuh.c',
+  '../mips64/test_mips64r6_dmuhu.c',
+  '../mips64/test_mips64r6_dmul.c',
+  '../mips64/test_mips64r6_dmulu.c',
+  '../mips64/test_mips64r6_dsllv.c',
+  '../mips64/test_mips64r6_dsrav.c',
+  '../mips64/test_mips64r6_dsrlv.c',
+  '../mips64/test_mips64r6_muh.c',
+  '../mips64/test_mips64r6_muhu.c',
+  '../mips64/test_mips64r6_mul.c',
+  '../mips64/test_mips64r6_mulu.c',
+  '../mips64/test_mips64r6_nor.c',
+  '../mips64/test_mips64r6_or.c',
+  '../mips64/test_mips64r6_sllv.c',
+  '../mips64/test_mips64r6_srav.c',
+  '../mips64/test_mips64r6_srlv.c',
+  '../mips64/test_mips64r6_xor.c',
+]
+
+foreach src: tests_mips64r6
+  tests += {src: {'cflags': '-march=mips64r6'}}
+endforeach
+
+# export tests for mips64el
+tcg_tests_mips64r6 = tests
+
+if 'qemu-mips64' in emulators
+  tcg_tests += {
+    'mips64r6-linux-user': {
+      'cc': 'mipsisa64r6-linux-gnuabi64-gcc',
+      'cc_dockerfile': 'debian-all-test-cross',
+      'folder': 'mips64',
+      'gdb_arch': 'mips64',
+      'qemu': emulators['qemu-mips64'],
+      'tests': tcg_tests_mips64r6,
+    }
+  }
+endif
diff --git a/tests/tcg/mips64el/meson.build b/tests/tcg/mips64el/meson.build
index d74c7de9b7a..606f300804a 100644
--- a/tests/tcg/mips64el/meson.build
+++ b/tests/tcg/mips64el/meson.build
@@ -9,4 +9,15 @@ if 'qemu-mips64el' in emulators
       'tests': tcg_tests_mips64,
     }
   }
+
+  tcg_tests += {
+    'mips64r6el-linux-user': {
+      'cc': 'mipsisa64r6el-linux-gnuabi64-gcc',
+      'cc_dockerfile': 'debian-all-test-cross',
+      'folder': 'mips64el',
+      'gdb_arch': 'mips64el',
+      'qemu': emulators['qemu-mips64el'],
+      'tests': tcg_tests_mips64r6,
+    }
+  }
 endif
-- 
2.43.0


