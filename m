Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E43ACA5FD4
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 17:54:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCKy8-0008Pq-Sz; Thu, 01 Oct 2026 13:53:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xCKxp-00085D-NL
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 13:53:06 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xCKxn-0001rA-Sd
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 13:53:01 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 691FssBg3109794
 for <qemu-devel@nongnu.org>; Thu, 1 Oct 2026 17:52:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /CPp8XXOceV7OMgHajENwgri/kLZ5Za9plpl1790h2s=; b=a1a908ZlCIoq9w7I
 tdDPTIjfKZcoAurUGH7lIwhrBN8sPKn17lkynchbFI3gcczKsSWO+JswzFsbEi5U
 prUgyClrHupM/pwLyQe8REU96Ie8IWQ+u1I908kUDXct+R2ryImjol6vWLuMKJ8b
 dNCEWJ4qHmqljrj3I5DRP1tA8PJBaiQ8PNl6SW1yNgEAPBka7s+LSzk7iCOvweec
 /yVhxG3xw+4bfpmK3bHoFDlKOwxgIarb0kHfNqrLWFt86ltoaeWST9CJeIfEP1pX
 geEP8FvP/4l63nRatzguvDEYs+QXu3ttmvSi44jftgwv/Z5AQD3DBffKn5sWU0c0
 ZLjquQ==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h1jcfu0f1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 17:52:48 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-1431ba79941so7872866c88.1
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 10:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790877168; x=1791481968; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/CPp8XXOceV7OMgHajENwgri/kLZ5Za9plpl1790h2s=;
 b=Oov9Mkr4DIRTDS7ABacm8o1E1FXb0HlutaK3CBJggRZlfC5L37dy4reGSKTBUx9fxo
 cUYdsSXt+NWYhz+Mg5Mf7qR2AvdWhQITPgbe5sQ8usfIh2HqBJ7umvzV4t4Q8BK05xiG
 m18eMHnvMpgBwKTUjCzt+iRJ4i9X19Azy4IGBPDAsVUJIeH6NwNYu8+1aiTUnCNAZnLC
 rn9tMFGxGFNz4WsxyuCKfZi7B7B16tHBLsRLxi6Kdqg0AwMKXIBvIbEB4Y3rSGgZb1Ys
 xfg3TcGQpobilb4Ex/G/GoAvLUWx4etK7klkc7TqOPxmbWKpQa0Z77KfkdlsrFn+KsZS
 uaZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790877168; x=1791481968;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/CPp8XXOceV7OMgHajENwgri/kLZ5Za9plpl1790h2s=;
 b=cpie8r2HMspXRLVgQ9mFmnG06pRD4Dzx0Qo1lxLz/Yg3jqcpATf3OUTaQWh+JflobN
 jNAu2jQ7oJ9bLBF8QP/f5bNxjmfPQ20EcrMz2a6Bzg+dI/DJ2mkYH8rnaa2Hhe46xjrL
 gDNBBexBANbHkPKG2HhHWjjOn3e7hjttQHloQugqE0SMuiuy3/h4MED3BfmuCfLFtO64
 gO4y81/obzf6wYXZb7wwG3f+oWquzTwPEm/di8QZAyyQVQ2jC3rmjDgQ0pHfIPS4ARhw
 yDr7+QwQsrqSDVFcA54JpLCDfdR75oXlKZlRot0buZ3VmptpsPJDQkQveMvuraD+ZLPC
 9x+w==
X-Gm-Message-State: AFuF++mD+3sMNnTfbGWz3xsBczXYONq4iKF6AJNhUntoZ0BE5euiCZr0
 GXU7g7Rfa70bpw5yf6sVa8l9+BWjOPeUPZJqQsedhffSKRwyXc7SGyTDFgB6PYeY/cn3PbSkP7b
 jczKcgqL3goQrqBb02oVjEd15T4y0oErjKgs8pP24gTS1hacJcnYJc+MHC+kILUdIig==
X-Gm-Gg: AYBFou0i6Cl6bQE3HnhKc+nH53tPseTfroZ5QkZdRTaFu9yhn8rfEF+IxCzRYp4TlCr
 16RHtfVTxc+T17f3ZQ2jsh7y88+uigocAJsFfO5ZNXFIhRTSrn87YbQpNUF3Vv+OL3fax3derVX
 pa3/wVdZKPcqTmCkgcrjyeOrMv2Fgkw95s/nzDIINbviVEdnovGnRDsJ0HnFBvEaiMcRyX9x1BZ
 FCxjEtYHWQ1fRVm6RhnyDjL6M8FuKQY0E2XCwPSoq14JE4nGj+FxTES6z0l2uUglNgQZ14sQTQc
 eGBHF0xVLZ+5JKsGBl1C6lpcv8XCfYuUteS38p6O2wc5W85mo4qAh1QQaATVUJjlUaAHV5e4tOg
 j7nNWtwx8LXuXEqq48Be/XvtLcb/RCCEmt/2SRP7E+KniZGcZYdcKgPElhkUP
X-Received: by 2002:a05:7023:a4b:10b0:149:2aaf:df53 with SMTP id
 a92af1059eb24-14d31a82149mr5525189c88.16.1790877167754; 
 Thu, 01 Oct 2026 10:52:47 -0700 (PDT)
X-Received: by 2002:a05:7023:a4b:10b0:149:2aaf:df53 with SMTP id
 a92af1059eb24-14d31a82149mr5525155c88.16.1790877167132; 
 Thu, 01 Oct 2026 10:52:47 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14f43fb3417sm207518c88.1.2026.10.01.10.52.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2026 10:52:46 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 23/27] tests/tcg/mipsel/mips32r5el: add msa tests
Date: Thu,  1 Oct 2026 17:51:59 +0000
Message-ID: <20261001175203.8673-24-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261001175203.8673-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261001175203.8673-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA3MSBTYWx0ZWRfX1aQ6w2+n8Neg
 BKpN94d2VmZEFhaDmDMgr4W7DzWJRNNXZOR6gqwOy/FGOIbvRgfbRiTa6qworRsbzzrKS0BNAkl
 ++XSXyskfKinYqGIJ6vav4CorJIliLs=
X-Proofpoint-GUID: 2mIFM5axwnuhLzKhWOjgAFTtfrsUo1TZ
X-Authority-Analysis: v=2.4 cv=b4YncdGx c=1 sm=1 tr=0 ts=6abe9df0 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=9smrWREWR_s8Awy1JTMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-ORIG-GUID: 2mIFM5axwnuhLzKhWOjgAFTtfrsUo1TZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA3MSBTYWx0ZWRfX+fq0jQOXWDFW
 72BKTa7uGcRp7x4Rd9IF/pqjMaG4oKABxVJJFK5J3qc/AKwmbEREmC2IloDdwBYkhwAWf+vTSYd
 +ooZI+0PzjLCYTa/8kRe9OBqIl2lZzlMlSqQZP1nm8BeAEfNif9w5a84KOJqAUoqqm7hPS+AzYQ
 BjE1hmlXnKMwv5+A1nIz1GHbmWQqFtmD8ML8l8wvDgwLleNuhuGlo3fT/r0RiR89+hGZHaTOMg0
 X9UEmya+KODdkDrRap65BNj55uUqEn/hONbHQyMfoZP9YjGWUdvVq35LH/64bk/aIgi/cqpfzxy
 CTVBErDf8baWmnQGwJmeHDqcPMrFsFVnQPiV2I0MpLHfetRWbpktiQKmr82+50R3cD6USOaPgcT
 aXORmVR93nuYnuWmxrVUJ6G0C6/6LEqLiDXMnKdvU94iMsj9hlqVD1o+fvMSw7GvLdLYNpbkOH3
 3L7xuuHJDvs1lMr+zaw==
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

Due to missing toolchain, we don't add those tests for tests/tcg/mips.
Considering this variant is not widely used, it makes sense.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Link: https://lore.kernel.org/qemu-devel/20260929212439.110454-24-pierrick.bouvier@oss.qualcomm.com
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


