Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79035C5DF85
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 19:27:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwPPL-0006cF-Ud; Tue, 18 Aug 2026 15:23:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPPK-0006bQ-SP
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:23:34 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPPJ-0006aN-6h
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:23:34 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IHH3Zq1943374
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:23:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7AMl0GUi9+fOtvTKd5eaYWLQivSCE64ZfxEcdg32zeo=; b=Dq3jHp9xDcxGWUYX
 xKvNXV0v4cIfYOUjeIGL1XuoPygQpM3B1QKXIeCRe16rmVNOjR7/SCyGkIfaIMUT
 ObSpr1r+002s8KQNk7yNU2mc/NiI23sudDd5jsVBSbGjZ6DL9XFChZId54lbnVoZ
 Jv7r0fg4S7aN4jVMW0rPAh3xaxkCeO8nE7wwykIaip2otKBJnA7kTl0tHb/v1S6B
 pzr2KAqk25lT3AIRgKb/SQLKT1l2kGJdJDxTlyVOvEqImw3DcJzum5xL+w/fJuSO
 KQOL9IqkhEFRAxn+Z/SYgj62sKIjtuOUbfhYupdrxgJAddL+BTrhrAR1w2XHyvp/
 a4fC9A==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4prn269p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:23:31 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cab048cdb3eso162036a12.0
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 12:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787081011; x=1787685811; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7AMl0GUi9+fOtvTKd5eaYWLQivSCE64ZfxEcdg32zeo=;
 b=JVYD4ecUSa5qWbcNLpzRS4Fsa0PFZORwM3PrRECXaPIj0VRa9gMhkrGDCB7TVBlK0a
 fNKGmmLf4zJnih3r/wVOuek5O4qsSFmLVawT3bv2u2uRveQcQrqQHXoCVTgC2nul26Er
 rg1XU2lASmeBW+mdXVPkS30VxsERMOxVLMfK7q2s8n6+oQ67hvRHBRJ/yW4m2X+yGHN2
 vyNRPzCi2a6dlgMOkpg/fTtQCTd7txVIA3xM4AQQ4z1JlTfLSpgiscsIk0YNrNVRXVWG
 dM5pFlP5HR+v8+mBI8PuIH78UJGF6fGkwrpHOA0W1dTntWl5ClyCQVIw/zr8XBukSFLX
 zaWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787081011; x=1787685811;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7AMl0GUi9+fOtvTKd5eaYWLQivSCE64ZfxEcdg32zeo=;
 b=r7jHF9jisboarm6sypoL54JfL9PK7LDkMSPw1fmqGf1QXfG+uGSNBDdB/2l2KW6B+d
 fOUZzAMFteoLnUq/6p2Fw61XRPTOcVCykAMNzqFiWUigoi20Ph32mhAf9uHMXArvj9mJ
 WVLLLV61h1sU1vX52RKpnbMEBHuTdl4o8Dtv/KOWyzfSR6c/rY0ezxKsDRkRIYGUXrWR
 p2jXAQUWPdMmdg4UfhRtEU26I3s3oxe3oN2VUUVv4bLZWD9d5Fk6zVwdARc0VjDuHOO2
 liNEu2BEhlwXyOMTEXGSi96D5L+VPWmGMBgisuIyUBOTNPfcIKYCOMZ/RhBdCqztMCDf
 yykQ==
X-Gm-Message-State: AOJu0Yw6RRnDO3SUNadvjp9mzSFPf4wAEBNu03j/0hAcxjZwGwPU6JSN
 2zy0tf1/y7NBWIZblNASNbWyz1+8YiaBBlBUsLFnHtmo+/w4EdxWnbWmZdDv8V2ohAOvnTYaroM
 EzZM1FWet3dQju08jyuAKEfno4fGR1m8KinQ7bdvaxipekTiOv5gloZYGm7k/E9uluA==
X-Gm-Gg: AR+sD12wZTcI7PkgERPYzvRPy4GV0mcepL+j98il4JS+n1fkquIbhjlEC3YI5KsYNZK
 YCxca8vUo7f8EEZns9kIrM/+6QhWoi8rID/8JjCRYT5FTSo9BicoyPQ2PgUoARMKnRM1Z1Vyz7i
 tNSWo4RVg2OhW5Oa41gZcQBLu6XsY2/yoBLTeP2PK2bqu8PaXFAXP4/yWeJjYYLkVMsCBZEK1Gj
 SILom+lHsRSpPvqA/skcLbD9JtHcYcAP69Z15VV2EHAMfrl+4LPY4ZN2le/yvlnYt9zYXeXru2G
 qeevgWO/dWBqoQ/dNIM6ZJTEzxZ17peIFFlsdUHqQrEylrKZDuuaeOIw8S9bZVKpb6cnqomUpkm
 rpoer1OBk/0zPdU+6/nywvw1z/FTzbx5idNZ7VK1pkeVLQF5jgyVldHsDjaw=
X-Received: by 2002:a17:90b:1f82:b0:38e:9e9d:9209 with SMTP id
 98e67ed59e1d1-3957b138536mr150366a91.17.1787081010658; 
 Tue, 18 Aug 2026 12:23:30 -0700 (PDT)
X-Received: by 2002:a17:90b:1f82:b0:38e:9e9d:9209 with SMTP id
 98e67ed59e1d1-3957b138536mr150264a91.17.1787081010189; 
 Tue, 18 Aug 2026 12:23:30 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3267c897e37sm21879429eec.28.2026.08.18.12.23.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 12:23:29 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PATCH v7 008/104] tests/tcg/meson.build: introduce cflags
Date: Tue, 18 Aug 2026 19:21:32 +0000
Message-ID: <20260818192309.22169-9-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX8pmEkDTlZKlq
 jAom3/RDCD57ucrL1dsA0Z5qsdRhO3LCilAOXRf5RVIV5kmL0/SNdxtMnOplt/4ocMkEIdh6XDF
 OLdkie+Is/ZBdV5FaTnYAfg+/FJuqC8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX0pCyhXpL73lr
 E7bp9YBF6A0r5X6o5pwWtL9k1wm8e2NqCu5XPad7z2Kamq3xM4rbPwEisFa7j6mrti5PaG3I9OB
 t/bNN7f1nK0PLPAx5acqCdGFNVHFXDQMIKSRNw41QwHyrqyX28e0Kii4Tg69PAWHQaAVEXlEKo/
 aJlKJFM21D+d0O/IVa1A43fQvytuTSqD8B/uFok61ZQb5lfDLHpNLYKwmRYfrQMCbmpErCoWCvD
 MBqEw0ZP5tdTPnCMH4lNde7BDAcYbH5pTCewIFZHjjJ5iVdVGdJ9vhlLjAkhxjYKE9Gm932dvyz
 DF0QJ87kc9MDgrHHYXgG3yUCLGBhNZK6J9GdwaCu//vW5qqh457vWYtZqgnDfC6RCnzyKpi0jPW
 9LczQm5kfJjlepb0iuTsjEzb1Ly8KTjJ7erR5jiEEwYy2+Q+asqzckwMdOg/5CdLwFSosN0ck9+
 T9+nr08McI9zTimj1WQ==
X-Proofpoint-ORIG-GUID: B3BK9ke2Q5Oif3-lBv7DS3br6L4Fy1Jo
X-Authority-Analysis: v=2.4 cv=HNrz0Itv c=1 sm=1 tr=0 ts=6a84b133 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=EUspDBNiAAAA:8 a=_Ry-N6Gx1nrijpWpWVgA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: B3BK9ke2Q5Oif3-lBv7DS3br6L4Fy1Jo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_03,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 malwarescore=0 phishscore=0
 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180142
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

We add possibility to declare cflags for a given test. Since we want to
preserve the uniqueness of test binaries, we prevent repeating those
cflags later, for an existing binary.

This ensures one executable == one set of cflags, and if dev needs
duplication, they can use a custom 'exe_name' to override this.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index ae7ec998f63..e8d8cfbcf88 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -13,6 +13,7 @@ tcg_tests = {}
 #         'src_file': {
 #           'exe_name': ['provide an alternative binary name'],
 #           'test_name': ['provide an alternative test name'],
+#           'cflags': ['additional cflags to compile test', ...],
 #         }
 #       },
 #       ...
@@ -20,7 +21,8 @@ tcg_tests = {}
 #   }
 # }
 #
-# Every test executable, identified by 'exe_name' is built only once.
+# Every test executable, identified by 'exe_name' is built only once, and we
+# ensure cflags are specified only once, on first declaration.
 # Tests for a given src use the same executable by default, and their definition
 # is guaranteed to be unique also. Several tests for the same executable can
 # declared using 'test_name'.
@@ -54,7 +56,7 @@ foreach target, plan: tcg_tests
     foreach src, setup: t
       # return a clear error if user misspell a setup entry
       foreach key, _ : setup
-        allowed = ['exe_name', 'test_name']
+        allowed = ['exe_name', 'cflags', 'test_name']
         if key not in allowed
           error('unknown tcg setup entry \'' + key + '\' for test ' + src +
                 ' (possible: [' + ', '.join(allowed) + '])')
@@ -82,6 +84,15 @@ foreach target, plan: tcg_tests
               'specify a different \'test_name\'')
       endif
 
+      cflags = []
+      if 'cflags' in setup
+        if exe_name in built_tests
+          error('test ' + exe_name + ' was already built with cflags: ' +
+                'remove cflags or set \'exe_name\' (if cflags are different)')
+        endif
+        cflags = setup['cflags']
+      endif
+
       # build executable if needed
       if exe_name not in built_tests
         exe = custom_target(exe_name,
@@ -91,7 +102,7 @@ foreach target, plan: tcg_tests
                                       '-MMD', '-MF', '@DEPFILE@',
                                       '-Wall', '-Werror',
                                       '-O0', '-g', '-fno-strict-aliasing',
-                                      ],
+                                      cflags],
                             depfile: exe_name + '.d',
                             output: exe_name + '.test',
                             build_by_default: false)
-- 
2.43.0


