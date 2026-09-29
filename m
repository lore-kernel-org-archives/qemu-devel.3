Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF6FFCA5FAC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 21:27:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBfKm-00016P-Fy; Tue, 29 Sep 2026 17:25:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBfKb-0000xH-Uy
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 17:25:48 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBfKX-0003uJ-Uy
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 17:25:44 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68TI3Xav1723993
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 21:25:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=yi1Nm6zU7Fd
 KaQa5YTJdeNTcK7x2ObeO40ZfEH3s+Jc=; b=lgA1MzuIy0C/q2L2HyBPhNLjpSQ
 46fpkCYm3CtlbWnGDQK6YLcrm7LlYkW8esdLV4LLfNh8eUJ1vN3uwTn1BX1DiXD+
 3OY2Ec9BiXcd/k2+f8ceLJCra5F/aVHzpK9W6ovo8w80rCQb48V0R+OpIdeTy9vs
 6pnKG8QCFs2oycSWTRfgji8njeXf5kh/v+F5OG2mZbDXcL4iwLKcZnxgMIF4wqUQ
 cGG9rpL+s+1lgmzj1XNDFvDCCAUbdarghO1iJqm3i1uycUzKVge6ZG1H9fGVVBHe
 G2khxo3No0SAycjVcv0aEV+K4iKCZq5wP3YZ6a3OlMx3gmK2oS5E+8TwUjw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0j97rrmp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 21:25:40 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-34344599f01so3499538eec.0
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 14:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790717140; x=1791321940; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yi1Nm6zU7FdKaQa5YTJdeNTcK7x2ObeO40ZfEH3s+Jc=;
 b=A7Ki2Xcx+ouRBgKbT3vwcy9K48UQt+889vE9ZSXE/ayuTVc2z85Ls37S2dqJ+GU0io
 /wNIgzukhDxPvPJyLug2hhyfI5/R+GkptuGMi68i9YCIC9J92Yoc9fb9JOkKGBPXHeSm
 xKbXsVei3P+Tz87M8Du3r0QmsnhWk/WanLraWoM4KTILL9SiWf0GTeqdwRIBGF99o9HC
 s4eDySdpTEG/2SkNA77q4h6o8Opa0Ur8mBso6r1yvxL4SxOaWJOBgK4Ye/tJ5M8QP8j9
 lIu7LH0xtBpip4GStgNZgpgsYODsxk+M6lWvgzFHCmvrFCsTAsk9OcYngUxxolp+4O0v
 UalQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790717140; x=1791321940;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=yi1Nm6zU7FdKaQa5YTJdeNTcK7x2ObeO40ZfEH3s+Jc=;
 b=W22hbC5mXVyYWfEHWDIl+U4rpTopf2kVyf7m4TESNRBF+nsRP1mJmHFn6lALI9NGLA
 7/Ub5PcmJnWSTsZ+sUkUErvw81vbgJu4iaSImP5HV1hHhs4wZVVXeuE6aYCUZI+EMbTJ
 iM5VE1k+4Nn3aQFhGRWKULvXTciDmJfWqzF0xQ2GdrGR9kzww7RS5YU+dh2MPQA5tK0Q
 VUxr0aPvh8FjF9qwkhE1M21z3oZsSeGyNZVFCqDHE2FUoe4qIvXK/ky+9V/iWVMn2AlN
 CbOzbJJlhHA5d4OtE36w9oKLQsp2kYZxYZE6F/Di1SMw5QAUIHDwVQafv7cl9jFq/SmK
 sZQg==
X-Gm-Message-State: AFq9FYL8KA0GWnfLmfcH1+RRghZW+sx2fASPSxb7QFQd5vPc6aLaYAN2
 dhVlVUWitRPF+f1eQxSAy9qxv94ONF8xdRnXUS+Tn6U30uyn+LGZHOhzg5BsR/5y639Tkt2d43h
 MUVaZSFbdMeIXJVd9a7gf1W7/bC9JQcw9dC1S42rKusKoUzw3AqIetPT/l9zn7sEIIA==
X-Gm-Gg: AYBFou0a0EogbUsR7YPWJ5UM9pN9Yf7Z63QBwujNzaBOa7ZnaRuraYVrpX1i4GEJj5q
 uoVaHCRTwRSUKYuTPgktd43L5X3PoZBtvLVgbKqg9XswR3BhCWqddBRVrV0zbfxAN3uBZ91BJ+i
 GBxyQK2bJ20T9IyG/Mn9xUMHFscYA28dVJNYGef5IJS2FDY1FWv5/iYyu/i3Lwt4yFcNUuHxb9l
 34b6uxMo5Pt79v6kSy5xqOSkc/kJpQpk1qpIeKQuaJRojoEmQFiZmI0RtCv8uPuzUaKRX/sKYhW
 d2xmnay+PoqClVp6ZpdD/TKmTs6wYk36sa8mXAslkZZpzpCHSaFfJA1dYPEbwtEjYmlUx8Uwilu
 ZDc3fvRxHfV3OHBbK95+1/ahpjG44aBIjqMsAeYVWoE5xyBS+IckMVPqylCiR
X-Received: by 2002:a05:7301:4208:b0:34c:75d2:b31d with SMTP id
 5a478bee46e88-34c75d2c3d8mr483095eec.16.1790717139716; 
 Tue, 29 Sep 2026 14:25:39 -0700 (PDT)
X-Received: by 2002:a05:7301:4208:b0:34c:75d2:b31d with SMTP id
 5a478bee46e88-34c75d2c3d8mr483036eec.16.1790717138706; 
 Tue, 29 Sep 2026 14:25:38 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34c388d0110sm1415413eec.20.2026.09.29.14.25.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 14:25:37 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v3 23/24] tests/tcg/mipsel/mips32r5el: add msa tests
Date: Tue, 29 Sep 2026 21:24:38 +0000
Message-ID: <20260929212439.110454-24-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929212439.110454-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260929212439.110454-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: FUWOGA325WHOanB8BhxY2tE431S_9QD-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA4NSBTYWx0ZWRfX/xGsEov4sL2W
 D21ZdTN2hZQZ4vnGfLUYgLRoHypQTZF2o88S8iK/wOkNDzLxWi3bAH7Lfbdib/SNpRzII8WpOqC
 YqnOAD5z2a9bW8j3o4Zrt660Bu/WuAI/D3QbuWLYa3VuU0OUu4J6f4jn5iW0FR5/QxMdWyhaD5f
 Yr6pMGYAnHib7mUvvzHzmwrKQgSRzAKywgS0jgYvmiJ3meU2ErKzbfaDldlfRbhyZ7eufuX/3vD
 b5Du3UIbGKkuNWu1mrJQQSgqqiBND9oUIynrJ/jRrHNc3Gm1bIPPqyGFjywwMyol6Q7EfL1fcIS
 gH5pLBoimb36/7hxPy5vITkV+JUGce5uYbYYwYXi7sT2nKitZAkmK0J9bh0fBpwq2tpu7fMIeuf
 I/OkQ4HH6QeeOoPe3NtSQslIUyp0CjUGMyh0LTetmYdjVd23vsZtaNvkuJWBRNqdDH9drw9O3Gl
 mtkD7bR5iCZXeH6G18g==
X-Proofpoint-ORIG-GUID: FUWOGA325WHOanB8BhxY2tE431S_9QD-
X-Authority-Analysis: v=2.4 cv=BPImP1QG c=1 sm=1 tr=0 ts=6abc2cd4 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=3jNhBlG8-6qDjjb9-SEA:9 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA4NSBTYWx0ZWRfX7JPI0ZS0RWLF
 LpBGF48Yg2GBCqzu4oZvJ/YACwPsHvfkj2UxpTa1engjquqVana3dIsq37awDzAdfZk2CI3ouZj
 C2PjzCkLJYm8vHMAN+TYqj5XhdlOOYM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 suspectscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290085
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

Due to missing toolchain, we don't add those tests for tests/tcg/mips.
Considering this variant is not widely used, it makes sense.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 meson_options.txt             |  4 ++++
 scripts/meson-buildoptions.sh |  2 ++
 tests/tcg/mipsel/meson.build  | 26 ++++++++++++++++++++++++++
 3 files changed, 32 insertions(+)

diff --git a/meson_options.txt b/meson_options.txt
index 07b016c0fd4..c9247e9de14 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -457,6 +457,10 @@ option('tcg_tests_cross_cc_mips64el', type: 'string',
        description: 'cc for mips64el tcg tests')
 option('tcg_tests_cross_cflags_mips64el', type: 'string',
        description: 'cflags for mips64el tcg tests')
+option('tcg_tests_cross_cc_mips32r5el', type: 'string',
+       description: 'cc for mips32r5el tcg tests')
+option('tcg_tests_cross_cflags_mips32r5el', type: 'string',
+       description: 'cflags for mips32r5el tcg tests')
 option('tcg_tests_cross_cc_or1k', type: 'string',
        description: 'cc for or1k tcg tests')
 option('tcg_tests_cross_cflags_or1k', type: 'string',
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index 4076a7f6b59..064e1429a4e 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -538,6 +538,7 @@ _meson_option_parse() {
     --tcg-tests-cross-cc-loongarch64=*) quote_sh "-Dtcg_tests_cross_cc_loongarch64=$2" ;;
     --tcg-tests-cross-cc-m68k=*) quote_sh "-Dtcg_tests_cross_cc_m68k=$2" ;;
     --tcg-tests-cross-cc-mips=*) quote_sh "-Dtcg_tests_cross_cc_mips=$2" ;;
+    --tcg-tests-cross-cc-mips32r5el=*) quote_sh "-Dtcg_tests_cross_cc_mips32r5el=$2" ;;
     --tcg-tests-cross-cc-mips64=*) quote_sh "-Dtcg_tests_cross_cc_mips64=$2" ;;
     --tcg-tests-cross-cc-mips64el=*) quote_sh "-Dtcg_tests_cross_cc_mips64el=$2" ;;
     --tcg-tests-cross-cc-mips64r6=*) quote_sh "-Dtcg_tests_cross_cc_mips64r6=$2" ;;
@@ -563,6 +564,7 @@ _meson_option_parse() {
     --tcg-tests-cross-cflags-loongarch64=*) quote_sh "-Dtcg_tests_cross_cflags_loongarch64=$2" ;;
     --tcg-tests-cross-cflags-m68k=*) quote_sh "-Dtcg_tests_cross_cflags_m68k=$2" ;;
     --tcg-tests-cross-cflags-mips=*) quote_sh "-Dtcg_tests_cross_cflags_mips=$2" ;;
+    --tcg-tests-cross-cflags-mips32r5el=*) quote_sh "-Dtcg_tests_cross_cflags_mips32r5el=$2" ;;
     --tcg-tests-cross-cflags-mips64=*) quote_sh "-Dtcg_tests_cross_cflags_mips64=$2" ;;
     --tcg-tests-cross-cflags-mips64el=*) quote_sh "-Dtcg_tests_cross_cflags_mips64el=$2" ;;
     --tcg-tests-cross-cflags-mips64r6=*) quote_sh "-Dtcg_tests_cross_cflags_mips64r6=$2" ;;
diff --git a/tests/tcg/mipsel/meson.build b/tests/tcg/mipsel/meson.build
index a02a4bac289..3ac47117480 100644
--- a/tests/tcg/mipsel/meson.build
+++ b/tests/tcg/mipsel/meson.build
@@ -189,3 +189,29 @@ if 'qemu-mipsel' in emulators
     }
   }
 endif
+
+tests = []
+
+foreach src: tests_mips_msa
+  tests += {
+    src: {
+      'cflags': ['-mabi=32', '-march=mips32r5', '-mmsa', '-mno-odd-spreg',
+                 '-mfp64', '-mnan=2008'],
+      'qemu_args': ['-cpu', 'P5600'],
+    }
+  }
+endforeach
+
+if 'qemu-mipsel' in emulators
+  tcg_tests += {
+    'mips32r5el-linux-user': {
+      'cc': 'mips32r5el-buildroot-linux-gnu-gcc',
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


