Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92725C54F4C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 04:46:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woZfu-0005dY-JJ; Tue, 28 Jul 2026 00:44:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZfc-00054Z-7d
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:44:01 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZfa-0001cx-H6
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:43:59 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S3ak2f1673385
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:43:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fEdiAS4NBxj7M2QM1Fy1MRQvsAZh7AfjK3kUBJB7WZY=; b=R/EXsNFGK3uN4B89
 zMooWmqBPRt3Ll3BfGhd2v6EvRHqHVenTQIzI3whT0sT0o9VPRBzmJ+gwa0ye/qj
 h7XE8VVfFs8s1B7ZLBIQxiKX6utvJWkIK3hH2yEheDNYnS+ZSBIPEdOUL72HGcwz
 xOCkVfbcnrypEnMD7MmaDaYbGNPnps/zpDHp8maeAvgtEWq8pNRUWx01SDEoVgNi
 0ysBTA4vnC0YdUu4v7PfwmU30Enqa9IbVdlQtuxSK+Mk/Gih7IyIJIsIkYQaRuNP
 I2jqyZ/h5x3z9pA4IwwS8DVzxlvEcKYYBXX1u4TBksSFKIRmDUx6sqT6fYN10doj
 o11EDQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpbrstbxh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:43:47 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-38e54b6556aso4058100a91.2
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 21:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785213827; x=1785818627; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fEdiAS4NBxj7M2QM1Fy1MRQvsAZh7AfjK3kUBJB7WZY=;
 b=Ykm/8gRJWw/srRyoeBJMu6/onbpK8p2UeR/GUNDv3JVDrDmZVWQrxART1PkUgAehVY
 vTjZ4lFLELx04u8Garwr+9setLdeSzhj7RfSymQxYfJRAdPig6t3ucT/wyfNQgjS84oN
 VKMWCZwJO/CFhu9azVTZnnMakT1Kzg8Lam48X8mJM4MJ4U/QFVn2Z3XRvW8hTwgOC26S
 PQd75ZpKzRQVvc2LXCYXe8Cqia0BLeRCoHFPA9J3EvS2oSP7+vSQ9AnM/KriBO5eKNqT
 rD7vgPcPXXBDY2K5/k2UkK8O5dEnH6SBdPRFfP/4Ju5yS/CJO5DErj7hYv/8UAqqivM/
 js1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785213827; x=1785818627;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fEdiAS4NBxj7M2QM1Fy1MRQvsAZh7AfjK3kUBJB7WZY=;
 b=PF3UyFfDB7lzedDwvmfVTSpw1sophAOeBFrviVsCE/wEVAlQavcLFme50dtEIQqJ9m
 2YIGLoqe8IUMY3TaIZPZWjTMS5NnshCN3xQ8N+EiNyM6945t3dgRREvN5eTy7hSFosXd
 eviKovZHpKpQiVHdHHG4g4a+ltTnKUFaBsxkn01hRRUzDtXJZkMU3Bc3bmFn4zYeTRqN
 wMDySVQvCndiDjBGRiZOveWMG1ZKDF6eNDUket8oyzM8RMxOsAukiVDySeIMpMi97Hu7
 U6DwhTHf1NR9GGm3JAqVmjqhiK9ZuKdl3SwwSJWsp7q+yWjVbixLhaDPgT+uRemyLDgV
 E+gQ==
X-Gm-Message-State: AOJu0Yy5fxBqjPbyfsOtck76bM5OvOAbCZeascp7pCkYJEcDHevjDs/G
 UC0ZeRqsh8I36AbhGPgKY0a/fglvng8+jKjpcuxQDRzJNvLF2L40Yq4kqFJSUXySBLZnW7Pp51j
 b5lqPfF6Ulzg3uMXOdBHqO+HUW1KixYLL0A5vOTfG4aNuPuA/FhW6dLTwROzGXIqZ8g==
X-Gm-Gg: AR+sD11WIPede8jcR5d/S/V34MDu75SgFg2q63diI9R+H//v1AG69zjFNPNyAbjJRPM
 jGBp6gKgl6ZAt+a3K24Bri9i4p98QU+IUT0bTRwE0cOllDYWUQBh4GbJXZ/58N8/Y2yT9IZc+5n
 SUNGSuk5DpmeGI2HjvC1XBvKdtx9OLtOcQ3wNI0FNGFHoNyp4E+hcCAHqlKYf+xtuSjX/8m0Pv8
 9gTwvayHBIW3NF4V0YS9VxDLEF+3DxRLZlXjCrKhuydUzNFojTOpZsoeQRW2N5k2W6+7UZ7eK6K
 4SPM3UTh7yzeZWJgeflYjM0xDVROyS6ieXCKySOfx+MrYwRECcLzpGYoH6lBwi6e75EZJeNSxRw
 Xb8gllw2LOPCk+Li0YStVafyXmXcPBCZOvUbKU8Pw7hOsqgGZ+NWBDANCSvc1HsB16Icup+U=
X-Received: by 2002:a17:90a:d88d:b0:37d:f983:7b5 with SMTP id
 98e67ed59e1d1-38f6a30eb9emr1063858a91.9.1785213826569; 
 Mon, 27 Jul 2026 21:43:46 -0700 (PDT)
X-Received: by 2002:a17:90a:d88d:b0:37d:f983:7b5 with SMTP id
 98e67ed59e1d1-38f6a30eb9emr1063838a91.9.1785213826132; 
 Mon, 27 Jul 2026 21:43:46 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-314bc3e878esm38795784eec.3.2026.07.27.21.43.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 21:43:45 -0700 (PDT)
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
Subject: [PATCH v6 030/103] tests/tcg/meson.build: introduce depends
Date: Mon, 27 Jul 2026 21:41:34 -0700
Message-ID: <20260728044248.137626-31-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA0MCBTYWx0ZWRfXwNGr6J/rSLFV
 10M3OUjxd7cczAWq7Ayaqewo2bLjGeCVcPr+C4HhMGuXtV0/QyGcl8t01DJZRMmdwXKnAzBvyHF
 vQXFl6ATZiCWGEJmJ6qq8KeEVqwagppvPP4GRT+4RfNUzoGsXlqwqNmPWxSuCi1EYYuhdsSKBYx
 4rczuY4+pFu0pdoLgAOItM2x/2ilov2/QhO8LOSbDeXBN5qkTFBbyAXth0RnzHVCiiRPcGs3ZuC
 C+QbIg07rpaPp1Wv0bqiSX+BZII3IW2IodaqmY/IxqId6rKhN1ZY0+VU59AS+w5BLdE3PutieA9
 I+JlQoQkUBvV+Vcgn264tRG4OVWBBn9XmLjaX1fkemUufsv5mwCZhnMCwU3TxwcNmaLW75RKpSn
 jP1R6y/rKd/BcUeu9VdBamwpCEWEKUd9Lr42ZlpLi1aYqYSbY+6bfC5q5Z0eA1gk7DC5pt/3F54
 qi857Et76cp+04RXQMg==
X-Proofpoint-ORIG-GUID: e4DdiXKzBjDoMkn5FFVdZ9UlbHu19VCY
X-Proofpoint-GUID: e4DdiXKzBjDoMkn5FFVdZ9UlbHu19VCY
X-Authority-Analysis: v=2.4 cv=ALkdLnG8 c=1 sm=1 tr=0 ts=6a683383 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=aZLzzxQjhWCqgOQfChsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA0MCBTYWx0ZWRfX+OdbonigJNqv
 HnBEGbPK9Ba8T8Y2YJbpiCXxqkR5rMJXbSbLtm2DfpSJwIZuMzisU6KVaIL3MFS1X/bg9mjFW/l
 bLcDqP27LflAwgAwxdUg3EeFsnhxsEo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_01,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 phishscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
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

This can be used to declare dependencies for a given test executable.
Useful when generating headers (like x86_64 does).

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 8611a30da6d..c2b29b2a99c 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -40,6 +40,7 @@ tcg_tests = {}
 #           'exe_name': ['provide an alternative binary name'],
 #           'test_name': ['provide an alternative test name'],
 #           'cflags': ['additional cflags to compile test', ...],
+#           'depends': [meson_dependency, ...],
 #           'cc_feat': 'feature name, must be present in cc_feat_cflags',
 #           'qemu_args': ['qemu command line flags', ...],
 #           'expected_output': 'file_to_compare_output',
@@ -178,7 +179,7 @@ foreach target, plan: tcg_tests
       # return a clear error if user misspell a setup entry
       foreach key, _ : setup
         allowed = ['exe_name', 'env_var', 'expected_output', 'cc_feat', 'cflags',
-                   'gdb_feat', 'gdb_test', 'plugin_test', 'qemu_args',
+                   'depends', 'gdb_feat', 'gdb_test', 'plugin_test', 'qemu_args',
                    'test_name', 'wrapper']
         if key not in allowed
           error('unknown tcg setup entry \'' + key + '\' for test ' + src +
@@ -277,6 +278,11 @@ foreach target, plan: tcg_tests
         built_tests += {exe_name: exe_name}
       endif
 
+      exe_depends = build_test_depends
+      if 'depends' in setup
+        exe_depends += setup['depends']
+      endif
+
       # build executable if needed
       if exe_name not in built_tests
         exe = custom_target(exe_name,
@@ -289,13 +295,13 @@ foreach target, plan: tcg_tests
                                       cflags],
                             depfile: exe_name + '.d',
                             output: exe_name + '.test',
-                            depends: build_test_depends,
+                            depends: exe_depends,
                             depend_files: build_test_depend_files,
                             build_by_default: false)
         built_tests += {exe_name: exe}
       endif
 
-      depends = []
+      test_depends = []
       qemu_args = []
       if 'qemu_args' in setup
         qemu_args = setup['qemu_args']
@@ -312,7 +318,7 @@ foreach target, plan: tcg_tests
         plugin_args = ','.join(plugin_args)
 
         # since we turn plugin into a string, add dependency explicitly
-        depends += plugin
+        test_depends += plugin
         qemu_args = ['-plugin', plugin.full_path() + plugin_args, qemu_args]
       endif
 
@@ -367,7 +373,7 @@ foreach target, plan: tcg_tests
       endif
 
       test(test_name, env, args: cmd,
-           depends: depends,
+           depends: test_depends,
            timeout: 120,
            suite: ['tcg', 'tcg-' + target])
       added_tests += {test_name: true}
-- 
2.47.3


