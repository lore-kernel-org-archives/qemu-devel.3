Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8274C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 21:48:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiJ1d-0005Fi-Bf; Fri, 10 Jul 2026 17:44:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ1c-0005BD-HO
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:44:48 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ1a-0003Uv-Or
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:44:48 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66AKtkXn1950649
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:44:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gxvmcb+2DEXpFdcHEYPAvKex0f0zaek+RZkkYIVV6B0=; b=kkDOdo2iEsPjaAK/
 qUxT+LSzBrbsQkdfJCmgo8VP0ESQoSNpCtjOMeide9OlxpQj/Fnk4PwGHFbGrs5C
 BG6WRgsAIVuE9MXZMvPM/vVSeX8k4YTL17lLpD30Y2uw/aduqHcJ4PohpoaG0UTQ
 VfKfa3MkfNDEQZrwoF5n9H3ZgdYdRSvZB+DV2NAKJEQDoTK4V9+kT9gaPT6OZxC9
 Bo4unrNb+o+mON+87yatqOiQyBLGqSrhvpBajdxYpvixI3Jeqa+6lEL3a1FSLiOK
 8yvjauZ+V5x35TLigDuBH3dqdxUYaFY4QoNt2utQSD4u1YyDbe02j1vROxb640/V
 HopxHQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fb86eg45s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:44:35 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c860544c077so359268a12.3
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 14:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783719875; x=1784324675; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=gxvmcb+2DEXpFdcHEYPAvKex0f0zaek+RZkkYIVV6B0=;
 b=GLFjcZOO5xr9wFAGgwwCtWVQ8NknQDWqgOELubEMA03GBGUhiXooZ2vwee9eVqZfap
 HHNCyPr9Tf8ppi1wYByWuUWX4h9ogsxZ/OhWoobSyYvxr/0TCAmQMGXhiw0bHBGF2Igy
 g9LVWjBWzR8aUNhO/PToIG55IqeL1p7B9yXxufI29pHcBhee4kMM+WaYppaa9UH77eC1
 vIJxld24vzpQFFzZXOharCp6R3vbj3nUbrUR3yfox/rEm9V7fZ4TFJjhrnra/t8CQrbr
 PVyxLBYpbx1mvQpvQNN3Mw4YRNdglIAviFmKNZTPgjD7yOIhlZevY1CzmqkgB5OLVCR9
 je2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783719875; x=1784324675;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gxvmcb+2DEXpFdcHEYPAvKex0f0zaek+RZkkYIVV6B0=;
 b=rUTRInLYNJRdHWnm8cZl4IOozJjlP3Drx4X0WntfOEqqRGqTZjhIhBxbujQzivJmVY
 QQF+68ui7mwxTjJpbopwc1bpoG5ulLKt3RzodVj/WxkeB1iQZKis39uZjRGxAHh97WoO
 zY647nNX+HhTW39TmxJsrQOHTGASMwTcl+h95Keo7z9z2aRrnV7vys5/LzZRsi5N5sUK
 InOrc4Ffc3Nss44OJ1loiB7bb5fq5lIUF4+Nyy7JK79MPxZ7J7SI5a12tcOYQ4AuxmNt
 2woY4CWCAX3oHPVU+k/Ee2YtP4sUR3Yr2VmvJu8NtE/UfMCF1d2Lj0fePsG+JeUKPwNy
 ZWEg==
X-Gm-Message-State: AOJu0YzfagHBkm2p5CZMpAAheSJUy6AC1ReWus1nsmr+IloAa3fYFWDJ
 nfBM71Vy0P4DlDf1VZRmLJyeKV7MEwGSt3dKfSxJKp96SPS0A60BY85NHee7fq3lFFagFgf/TLb
 hxHxS07TMFWe/XNZ9YBLMU4Rip4lJVKmNZE9HpKhZzBAXaRppzSmmQ8n1b0OCy26CRQ==
X-Gm-Gg: AfdE7cmZaPysH5tZGyaJUkg6fdGbnggsfOewTXT9suuMY0MwUqzfVRr5syqmrud2Tzb
 7lYJrLLixffjWnhxo54hKnGvXU4tn3kXd2LtSx90XiE86kamH/z7pKefbia04f57a5GxNUGajuw
 +JBwYmIcwfLLM4HyGmVYqY/uxayaYXFZ2VlSokb4trTw1kJt5Lblt30hNktywhcFBGH7QXA5PvB
 GHOT1vFt/L7jPDRE0IRs0qDd4Pu5i/Oq+zz+BlZX6x0jbrmENgmjNt23fPvpPwX1mVtcjXukMbi
 mRzHFz/FrXCg2wkLiobRjFRH8UIZND/Rcu2oisyeO02IeHDJ/Cu/4t6ruaCp2Q7q+VR8jQOHL8/
 PUstsULuFSNEc/26jkAkbF+RcbPsC7F2ZrdR33O8N3kiTyhzMQd6LqaNhQuI3aJePCbExPdL/Bs
 CbKpZzAw==
X-Received: by 2002:a05:6a20:d81b:b0:3bf:7081:934b with SMTP id
 adf61e73a8af0-3c110163ecbmr768544637.26.1783719874964; 
 Fri, 10 Jul 2026 14:44:34 -0700 (PDT)
X-Received: by 2002:a05:6a20:d81b:b0:3bf:7081:934b with SMTP id
 adf61e73a8af0-3c110163ecbmr768513637.26.1783719874521; 
 Fri, 10 Jul 2026 14:44:34 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659c8665sm43539840c88.10.2026.07.10.14.44.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 14:44:34 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>, Helge Deller <deller@gmx.de>
Subject: [PATCH v5 22/98] tests/tcg/meson.build: introduce cc_feat and
 cc_feat_cflags
Date: Fri, 10 Jul 2026 14:42:26 -0700
Message-ID: <20260710214343.2065491-23-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIxOCBTYWx0ZWRfX48aUScb0OTCb
 JVtnfPd8QYvDgxQCfrr8CfzUxdAYurkX8TcdjGRKttvkW0X7nWzQbuCrm0UH4cUUDAb5yFttkCB
 aTFd70L2eRs5xne5QlzMUsnV+fysx+xa5rgHhEY6MOke5+mG7I1xeADM3qByYBkLJWPHk3VePRU
 hPTa9s0eDvuTQDoWMmJmKz+xPU4NExdpH9MbA9m19y2IN6ZXkPdV1oq7mNp3q78sNc+UMaHN1Mo
 9COeV8/YgTOMYbS8cNN5/Tso0DtfqAXl9gw/YwbJqtQEryHIezZ7jAuVmL0QawQ50sHeCNEg8xN
 uspTuCHT4rgf7BfoZTcESXBCIzEGmCLJ9b7YsRh3CQtwVfPH5bOoHLMyVDR2S6T6G9zJ+/9HJE/
 Oim74Y1WyIy22ck/grPnE3RX1NVQtdJPOPM1C8nD25hoeq6XdGWJ/tzSDrU4tA/pZqZKJ7O7tr9
 L///ZoamfK2KKgvTSRA==
X-Proofpoint-ORIG-GUID: k6Q23sE1IBkLx-faeCHl8qSRYktaUcUq
X-Authority-Analysis: v=2.4 cv=IOQyzAvG c=1 sm=1 tr=0 ts=6a5167c3 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=FBTJAdTUffG4L5poSMoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIxOCBTYWx0ZWRfX76zbhO/0SRWW
 BJJ9G+s3CzkmaIYfrLPaHu9uyFI/je+V2AdqCWXTe+ZAscU6Zcb0lTzma/vLi1JdSB2oQAJTLan
 iRHEdoq42NPNTyaJfyiUwEDdG/29wKI=
X-Proofpoint-GUID: k6Q23sE1IBkLx-faeCHl8qSRYktaUcUq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 spamscore=0 clxscore=1015
 bulkscore=0 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100218
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
2.47.3


