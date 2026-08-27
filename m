Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5070FC61DCD
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:16:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziO4-0005zo-2T; Thu, 27 Aug 2026 18:15:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziNy-0005r8-2t
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:15:50 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziNw-00066b-4V
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:15:49 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJLwZM795169
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:15:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /s+Mk8furL015lvLqj+bOHWeZcHgkClslOb/k2zsi+k=; b=exNYqjzamZ0d2I+n
 HMDtskfOC97f15bEaIfA2urpr+4p1qOZXH64+cI0wtZSB0eCLig3ROWPOE07GeWZ
 3t7VBxLFcAuoBuFD4Iy1WYBc15pk1xrkmNxV7s0vwSF6/MINuH331cG4A0RTp6A0
 DutCG6qCofGZ213lvFUYJs+TViItpV9S3E3PldFnJqPZhpi9kVsJQk8YezG88jph
 hRDs/4d/IofeOCnPdVSqLto3qSE10cTJdnv+ecKDqMWYPpYvf2JvTCFt9ThA74px
 P1d4EULotXI1PQq1SPcLhG9YfKmdm5OhmC9ZM9QZhUjvljXpIG1kbJPqzDaGssR3
 hxUlhQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gam6fjn57-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:15:37 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cb11535e6a1so259791a12.0
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787868936; x=1788473736; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/s+Mk8furL015lvLqj+bOHWeZcHgkClslOb/k2zsi+k=;
 b=S9lxX6dOfB0hSktakaBXRDPvj9A737VlUrrSv5ZQ4+vPIm2zmTZJcRJTAARnmQkdG4
 zZQViqy3Yr2YZplLhCw1pj6Y0VSmbxFDgsisuov3TYtqpuSSERmOYteAMLyZPMiRpIRd
 kSdv0X1KxgUV+32YDhyzDjrb8wB4wZ+1GmBqmYX18twcObxBSi+6Wqs+S018lN4Xsb47
 877fg+9pprfl/XHbhDgzodJRDxOSEOm4TXcn5T4dONnDLM8uN9CbJWywjI+sIrbaU5g8
 RPpAX1nh+vuPmStNJDw2772Y/xjlz9pg2KzsWXgIJlrl/CqtDuCyVzl26SG2Xc7EzIxM
 yYJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787868936; x=1788473736;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/s+Mk8furL015lvLqj+bOHWeZcHgkClslOb/k2zsi+k=;
 b=X11ccDT8IvC3q8mQvjOOx64FMfkksM+qWUQ4bE9BSdVKvARE0ukqb++qq8zCA1WjEM
 zpz0xEUFiCCzccwWSTO9gC0HUyfRKuN3hLPlOqffG3vmhHjfj5VNHWWWDPKiU5s8l0Pj
 AYpaP39Qr6QiWtmJx9xpxuLJwnjsJ5wmm8HXHteiE+VCAJHLXvQVt+GKhM6XTsaXWCMY
 bHyLrqP45hRDS8rG8A6E8Zs8op7bLeBTuzTF2pKKwzjXHem02bG/duLJNT4IONYoBhts
 xz+qjNB/2QCRDAy3pmmUAekwJ/MKVHEt4lvE9SC1j4ENL4AFxqu5TGPeoPZbwclT2lUz
 cLzg==
X-Gm-Message-State: AFuF++lhP5OTGCyNzvki8LIe9EGyhRcJlxaUHy/7ssu+I9qn5jnELjDR
 h5saikyOXvbQbk7HFS+WGRghqamUX6gGh30u0s301owGeAsvkXE23sXE2/HO8dFwhsZk3Lmv2FO
 935FVoZZivaHg9pl+07cwSKQaWziPtVHhZrniyDWNnQJddpJP011uUnK6Jc9Sk5UiOw==
X-Gm-Gg: AR+sD11kZiX/HWnnR3BrgRjPWhkhUlMQrT0pklBrEHHGrnitQcc5GNBRomLCyOuQNdm
 1c8yAkIX5+IEpKVEvSM3PpEbKDo7gUI4DNv4pST3ozZz7knMrvMuKuJokw6eyrtKcLDDR/bbk1N
 hsP01VMESwzDwyKuApkX43LNGw3UpyZefIFhbHWoCSakobr3u9udptSo7FX3+Erz5gVFuVKNpXx
 +n9T7/1+amNU1++tB3QFhxAyVlghm1xrbmPsccmEdycyiHW/u1vbyyx4hyg3pj3DuJZYffO199/
 ZkiFNDRSSDu9pLKxjVMBG6u+E7EJm4RWBB2RHaF92i+SLSXOgqpcBt0XTlRs5H7e2Kav1qkmiLz
 ZwMqumZws58TCJRYveQvAVoolToPi2zqPdkSysNHbsY0+Qq2EOaqc1SLOQFY=
X-Received: by 2002:a05:6a00:1da4:b0:847:8acd:747c with SMTP id
 d2e1a72fcca58-8562ba7dcb8mr4769236b3a.13.1787868936093; 
 Thu, 27 Aug 2026 15:15:36 -0700 (PDT)
X-Received: by 2002:a05:6a00:1da4:b0:847:8acd:747c with SMTP id
 d2e1a72fcca58-8562ba7dcb8mr4769095b3a.13.1787868935648; 
 Thu, 27 Aug 2026 15:15:35 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8535cf4b213sm2524104b3a.55.2026.08.27.15.15.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:15:35 -0700 (PDT)
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
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PATCH v8 022/105] tests/tcg/meson.build: introduce cc_feat and
 cc_feat_cflags
Date: Thu, 27 Aug 2026 22:13:43 +0000
Message-ID: <20260827221506.91574-23-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfX6vlyF1h7tLTA
 H5X40siDHBCLrJ3yXZbV/rkDwKkxTPHyP1v2arZw6n6Oo3t4MVEGgLwRpHKvS6QxsqzC4L3arQW
 aIUfMloh5/qBA0p1Y4850dR/vn5YFHg=
X-Proofpoint-GUID: TL5h1lF0oqytY7Yo5ejcDHh2fGryDLrm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfX7Yr6XyqpzoZ3
 nKRTuwV2iQvA18TmMpNtHqF8Vp9PFyvROHfvVscioorzxf4xzJswL/Db1/r6VBJWSAd4odTOoHk
 W/LZQMqFFV99HXy0MDb36kNIMPVBsRa5oWRtEn5SE8PC/mkCLsjr8GR2fR9+f7J4xlqO+61muY7
 jymz7FJzx62ccEq/0+FGqx7Z3tbHWHESF0OoW9z0zEEdCM8YQUZKp/lQBh8KwU0PHPCV+3lHQ3m
 SLnj1S0EdPj/FJGQo6c4Ia/9FLJMocTFIk9gRDxzGe1M8lUzla1jmQu9iR+IwCTBgVgvptZHQ1L
 G/KsXSUrfBGKlsyqDGCay6YgI1B8438TgPHs6nG5t/nF8DZeWhjcK1YZzItokdIsRVb7KOTy7gM
 /04GCGGyv5bBgiRuiLpsuCwc1MfH3TEeI0arTszFs2R09OM25Qy2HHeNUCWM+yk+1CZ41rQtKJg
 wduyChNP2f8L2Sta3bw==
X-Authority-Analysis: v=2.4 cv=eIgjSnp1 c=1 sm=1 tr=0 ts=6a90b709 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=EUspDBNiAAAA:8 a=FBTJAdTUffG4L5poSMoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: TL5h1lF0oqytY7Yo5ejcDHh2fGryDLrm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_08,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 bulkscore=0 phishscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270188
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

We directly move compiler requirements in test definition. This allows
to always declare all tests, and let the main loop filter the ones
that will be available.

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 43 +++++++++++++++++++++++++++++++++++++------
 1 file changed, 37 insertions(+), 6 deletions(-)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 7b60ea53825..4487d61ef6c 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -20,6 +20,10 @@ tcg_tests = {}
 # {
 #   'name_of_target': {
 #     'cc': cross_compiler,
+#     'cc_feat_cflags': {
+#       'name': ['feature cflags'],
+#       ...
+#     },
 #     'folder': 'folder_for_test_src_files',
 #     'gdb_arch': 'gdb architecture requirement',
 #     'qemu': emulators['qemu-...'],
@@ -29,6 +33,7 @@ tcg_tests = {}
 #           'exe_name': ['provide an alternative binary name'],
 #           'test_name': ['provide an alternative test name'],
 #           'cflags': ['additional cflags to compile test', ...],
+#           'cc_feat': 'feature name, must be present in cc_feat_cflags',
 #           'qemu_args': ['qemu command line flags', ...],
 #           'expected_output': 'file_to_compare_output',
 #           'gdb_test': ['gdb test args'],
@@ -74,10 +79,11 @@ foreach target, plan: tcg_tests
   # choose how to deal with it.
   built_tests = {}
   added_tests = {}
+  cc_has_feat = {}
 
   # return a clear error if user misspell a target entry
   foreach key, _ : plan
-    allowed = ['cc', 'folder', 'gdb_arch', 'qemu', 'tests']
+    allowed = ['cc', 'cc_feat_cflags', 'folder', 'gdb_arch', 'qemu', 'tests']
     if key not in allowed
       error('unknown tcg test plan entry \'' + key + '\' for target ' + target +
             ' (possible: [' + ', '.join(allowed) + '])')
@@ -88,13 +94,17 @@ foreach target, plan: tcg_tests
   folder = plan['folder']
   gdb_arch = plan['gdb_arch']
   qemu = plan['qemu']
+  cc_feat_cflags = {}
+  if 'cc_feat_cflags' in plan
+    cc_feat_cflags = plan['cc_feat_cflags']
+  endif
   tests = plan['tests']
 
   foreach t : tests
     foreach src, setup: t
       # return a clear error if user misspell a setup entry
       foreach key, _ : setup
-        allowed = ['exe_name', 'env_var', 'expected_output', 'cflags',
+        allowed = ['exe_name', 'env_var', 'expected_output', 'cc_feat', 'cflags',
                    'gdb_test', 'plugin_test', 'qemu_args', 'test_name',
                    'wrapper']
         if key not in allowed
@@ -155,15 +165,36 @@ foreach target, plan: tcg_tests
               'specify a different \'test_name\'')
       endif
 
+      if 'cflags' in setup or 'cc_feat' in setup
+        if exe_name in built_tests
+          error('test ' + exe_name +
+                ' was already built with cflags or cc_feat:' +
+                ' remove cflags, cc_feat, or set \'exe_name\'' +
+                ' (if cflags are different)')
+        endif
+      endif
+
       cflags = []
       if 'cflags' in setup
-        if exe_name in built_tests
-          error('test ' + exe_name + ' was already built with cflags: ' +
-                'remove cflags or set \'exe_name\' (if cflags are different)')
-        endif
         cflags = setup['cflags']
       endif
 
+      if 'cc_feat' in setup
+        cc_feat = setup['cc_feat']
+        if cc_feat not in cc_has_feat
+          cmd = run_command([cc, cc_check_args, cc_feat_cflags[cc_feat]],
+                            check: false)
+          avail = cmd.returncode() == 0
+          cc_has_feat += {cc_feat: avail}
+        endif
+
+        if not cc_has_feat[cc_feat]
+          skip_test = 'compiler feature ' + cc_feat + ' not supported'
+          built_tests += {exe_name: exe_name}
+        endif
+        cflags += cc_feat_cflags[cc_feat]
+      endif
+
       # build executable if needed
       if exe_name not in built_tests
         exe = custom_target(exe_name,
-- 
2.43.0


