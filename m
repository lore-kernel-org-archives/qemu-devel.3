Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DC3DC54F4C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 04:46:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woZfU-0004sW-JI; Tue, 28 Jul 2026 00:43:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZfS-0004rr-QH
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:43:50 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZfR-0001c0-1y
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:43:50 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S40eAP1593338
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:43:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 kQimGDNuKiuhuIEEHQFQxGLGl1a+/tf+bL985DPbqZw=; b=OxyUJRDl9hdDH2H0
 SI7ouDU19hC19Fb0QKdypKWS3aJ/BzKGiAkVhBWpcBQZzYdJgqBx1/baWkGvp9rN
 JUTxptplYR8oCpiXKP8FRNzSsvQyri4AWxRKIvU+xxTsGm1TmNQk1bMRONLakt8u
 +RO9nw2qiGNXcXfKntR/o7yBijcE71xsebEevA8CeW+8+a2cwcaJxtzqKdrwXscv
 xbgKyNclfHy6XkqIar/TEhdz47V/rvVBXb7kdIx1rEz192QpUvcHNv6b/ocAmTiB
 jjWg2BU+7H7Ili3O+EU0698zja1motfcpMOtmSPqxG1/0+hmq9+QBummrOWFUzrl
 CIThHg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpn19g42f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:43:38 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cb11535e6a1so2568851a12.0
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 21:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785213817; x=1785818617; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kQimGDNuKiuhuIEEHQFQxGLGl1a+/tf+bL985DPbqZw=;
 b=GsPc3LoNGypJO3Ck4Q5Fs9XgFeZR7CP9xd6YCNS26vPsjC734uUxBAZvzxikzqaSGB
 7PEPnU1iHpdFHBy19+BwOT4QmrvLhQ3kf9zbF2bys6gLMXseCAUWhIDf7DWcLtmoLLWa
 jj+EB4HbjYLfSem7d45JPP2WZs+RrEQPA3R3Exi42cpmYMiUfmvPkVSHgK0pxI/fwThh
 ZJmnXsnowV/4dJy/S3QCaBLJvLwtaW85JPrKTSxqzCvYDaln9xsWQHdyr1xKpROk+2WA
 M8AtIrR1vQEFhd3ytQRymalQ+tOdF0gODxRPbN2DyD/KQlF3d5LgC+QySyihwlLrlVO6
 CuRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785213817; x=1785818617;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kQimGDNuKiuhuIEEHQFQxGLGl1a+/tf+bL985DPbqZw=;
 b=nDYuNYKmdmD0R5HxsUaAwkYkGLKOkijduCJ+cq1fyDQhZgeY9ztnKb5BbUOsoggCr+
 C/PZlY2Ht/eAUhZNdDJZQd2iP1jFO6BTN2M5++8r6sVAnJUY1ig/Uq65ABkjg5cE61e9
 hfD1zPN78YlTx03yoayknLgemga8A5pKlMySwKh+bIO0MfI6TG8hrTUnNeyPHsExtjCg
 UcVog5XFbgio8guGpcO7fpj4dJBe0EfclixaClp9LNI/Fps/89Eu1iWMRumoCZmTI8TL
 eWslcl6WMjub27guuqAe2WhN74P5mv9+5Rg2XQ8lfbpi2DKomKcbR5yRMQMCHvpCi6ak
 BrDA==
X-Gm-Message-State: AOJu0Yw1j6JhjjeFOX+QRUJ0SVNoHaCwUACbTftSWTL0ePIMKtrkd2ue
 A9wtxdSpXhuMKAkun5etjKJpoF5lwfao6FNXS03WXCFiRm+clryfoIX/rnSXJK3pJt6ZT5YlMn9
 Nj73mJ6fv8yInK6k4kvJOa7ULJPquFyirOVIlZLLfMCUzGCRVN/6De35CNtXiH9ORXw==
X-Gm-Gg: AR+sD136M4m0rqJRqnBopLUosci3thYBb5DHd0tA6ef0khHk8xHZc8K/fHPjKBXKsrz
 4N4guQhpgbqRgUNeTM5CTORX8UoxWz8qUMQ7QLwZi30C30dlH5qKucnybl5ksbTrAQvsq+un1XK
 kuYimJLLMfeIaxJzgcHfjkxJmLuLwuH8GZ1H4gJUzNt+/sZSk11FlRJxIzfOpvtBhODIh19EktW
 c1Pne72v8TDN5V5u7jlFec8/ao3MOObNsUUSH7alst60aTf1y1otj3f9PXwcMtnc76JidFenKts
 ewcW/+tog/thdBqlsAEtGt+H5qjrtHephQbBtmQZbKKZObCuBvr+agDGrV0ahkxBF/uJfhcsB8v
 BSZoUJSOTnqjNUMiG/3sR8sPzZh+yiAcbm1dC7jT1psy8s+akae9ciXtYsuVjsnMuxbS0Ark=
X-Received: by 2002:a05:6300:4083:b0:3c3:90e6:48b9 with SMTP id
 adf61e73a8af0-3c8ba639865mr1096379637.66.1785213816927; 
 Mon, 27 Jul 2026 21:43:36 -0700 (PDT)
X-Received: by 2002:a05:6300:4083:b0:3c3:90e6:48b9 with SMTP id
 adf61e73a8af0-3c8ba639865mr1096352637.66.1785213816438; 
 Mon, 27 Jul 2026 21:43:36 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-314bc3e878esm38795784eec.3.2026.07.27.21.43.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 21:43:36 -0700 (PDT)
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
Subject: [PATCH v6 023/103] tests/tcg/meson.build: introduce gdb_feat and
 gdb_feat_version
Date: Mon, 27 Jul 2026 21:41:27 -0700
Message-ID: <20260728044248.137626-24-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=TJV1jVla c=1 sm=1 tr=0 ts=6a68337a cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=WryKx-XaCgVW6WutTgQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA0MCBTYWx0ZWRfX1TRrnZg+KMtC
 OOMYGmlJbIqwrfHL+FWYtQ/3eOBUjgaJN7nQM7BI5ZL5pcDfpJvUNsk4rIJ6x0wtj+AqJ5t5sn3
 Pr4SH3PbehVjk/c6Du3Ndc6FeTELz9NjbzFBHyDeV4Z5qyqYwKmiKVKRwHt8SOfTCsg8HM9f7v5
 S1liaNL5rxMYdR94OS4ehpWWXWv5YtCeJVjoYnqDf0cV2i3yjsfRAsq38iXpfd2f5+wWtI3Ae1r
 muWWY9vdCF4B/cwiiBxJTIMMeqEpiykX+3fFhrcWxl80JUHcj98LVfmByuIvx8AmPDmYBxPT/75
 WJp6vXFxL+mx8NKh9AWUzqdkk3vOAA5ARtUk6ZAukX5k/cVpD8bbKeIfm7SAGLSniakNKSKeYR+
 +YOP67/AzOxFkhry07/Byvy/yeTSyNV2fEqfNxkt6w0BSS5TCGn3eOVPmwZw7ZG04CJ182F8HYB
 N6QTQ5ZhOc1aqTIAGyA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA0MCBTYWx0ZWRfX6HRIUOl9eMYZ
 cevehfryqK92yfunKPBkV9gLBiwT8/cgGYvL5N8Uvm8txmpFDWx5kWXG0OFL3li0CvCw0gfqN8i
 t9DLMJotkbwGPFM75XI7uzKH62PZQZ0=
X-Proofpoint-GUID: ddHSObFB0iFXEvXxAH3sk5k-s0CYSb26
X-Proofpoint-ORIG-GUID: ddHSObFB0iFXEvXxAH3sk5k-s0CYSb26
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_01,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 spamscore=0 impostorscore=0 bulkscore=0 phishscore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607280040
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

Similar to cc features, we declare the same for gdb. With both
available, we can now declare all tests inconditionally.

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 4487d61ef6c..7384786f7f8 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -26,6 +26,10 @@ tcg_tests = {}
 #     },
 #     'folder': 'folder_for_test_src_files',
 #     'gdb_arch': 'gdb architecture requirement',
+#     'gdb_feat_version': {
+#       'name': ['minimal gdb version supporting feature'],
+#       ...
+#     },
 #     'qemu': emulators['qemu-...'],
 #     'tests': [
 #       {
@@ -37,6 +41,7 @@ tcg_tests = {}
 #           'qemu_args': ['qemu command line flags', ...],
 #           'expected_output': 'file_to_compare_output',
 #           'gdb_test': ['gdb test args'],
+#           'gdb_feat': ['feature name, must be present in gdb_feat_version'],
 #           'env_var': ['VAR=value', ...],
 #           'wrapper': [program_to_launch_test, 'args'...],
 #           'plugin_test': {
@@ -83,7 +88,8 @@ foreach target, plan: tcg_tests
 
   # return a clear error if user misspell a target entry
   foreach key, _ : plan
-    allowed = ['cc', 'cc_feat_cflags', 'folder', 'gdb_arch', 'qemu', 'tests']
+    allowed = ['cc', 'cc_feat_cflags', 'folder', 'gdb_arch', 'gdb_feat_version',
+               'qemu', 'tests']
     if key not in allowed
       error('unknown tcg test plan entry \'' + key + '\' for target ' + target +
             ' (possible: [' + ', '.join(allowed) + '])')
@@ -98,6 +104,11 @@ foreach target, plan: tcg_tests
   if 'cc_feat_cflags' in plan
     cc_feat_cflags = plan['cc_feat_cflags']
   endif
+  gdb_feat_version = {}
+  if 'gdb_feat_version' in plan
+    gdb_feat_version = plan['gdb_feat_version']
+  endif
+
   tests = plan['tests']
 
   foreach t : tests
@@ -105,8 +116,8 @@ foreach target, plan: tcg_tests
       # return a clear error if user misspell a setup entry
       foreach key, _ : setup
         allowed = ['exe_name', 'env_var', 'expected_output', 'cc_feat', 'cflags',
-                   'gdb_test', 'plugin_test', 'qemu_args', 'test_name',
-                   'wrapper']
+                   'gdb_feat', 'gdb_test', 'plugin_test', 'qemu_args',
+                   'test_name', 'wrapper']
         if key not in allowed
           error('unknown tcg setup entry \'' + key + '\' for test ' + src +
                 ' (possible: [' + ', '.join(allowed) + '])')
@@ -261,6 +272,18 @@ foreach target, plan: tcg_tests
         cmd = [setup['env_var'], cmd]
       endif
 
+      if 'gdb_feat' in setup
+        if 'gdb_test' not in setup
+          error('test ' + test_name + ' is not a gdb test, but it requires ' +
+                'a gdb feature')
+        endif
+        gdb_feat = setup['gdb_feat']
+
+        if not gdb_version.version_compare('>=' + gdb_feat_version[gdb_feat])
+          skip_test = 'gdb feature ' + gdb_feat + ' not supported'
+        endif
+      endif
+
       if skip_test != ''
         # still declare test, but skip it and print reason
         cmd = ['sh', '-c', 'echo "' + skip_test + '" && exit 77']
-- 
2.47.3


