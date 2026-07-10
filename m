Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B8EBC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 21:48:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiJ28-0006L2-QH; Fri, 10 Jul 2026 17:45:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ1x-0005hh-Gv
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:45:14 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ1u-0003as-LB
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:45:09 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66AKDptM1812046
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:44:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 MobFM20U5B8VSjNPr43+rhkcxHKF5mKhK38wlqxAKqQ=; b=U85BUG7NX0gFnSTF
 fhCYj+mKn+co9zM03Sma4UYTP9FlLGkgr0Qqk3SzgM3lOA17TwjE9sTWL0or8gZ1
 DkXBugtgb7of9/+pztr/+bU1FyAu/DZGuAPXbqoDArin+92UMFiHO8mX4eLTd3D2
 EJEWIpxs7nTVc6qDHiSmWqKcE9mZeORitT/T4Um+s3ImgVeciBEE8uDCbSTtO0jz
 M+xu8mYpqMfKBuOGPXOQ+OkxhJfyFSXMXE0+0C8iN8DZHhBIqfplcqYV1/ZWDxTE
 /BaTB1fOh8RWjOuuKVPah/ps8YbzDpDwjPi+sMS+Mae2gm49obXEuf97JahEn9fY
 Q8Pe/g==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fax5fahr4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:44:55 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c890bac374eso2577382a12.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 14:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783719895; x=1784324695; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=MobFM20U5B8VSjNPr43+rhkcxHKF5mKhK38wlqxAKqQ=;
 b=aAvR53di1YGdxRcMrjXZCWJ/txmFPycgsj9muJBAyOpSjuo5Td9H7j72UdbZAQibLm
 N98X9d5RZMcRH6uUmlkr70oC6uBHhChXBM7hC9y3oiy4mAEDxA5mf4GO9H0hEaEnYt9H
 WS+AppRCFFR2gdbvjF0IH+5h6mhoW7rto7zvw9IZF6Wc/8DlPA9QFOzAFmbgAfG062j9
 t88yQ6InZyQzi0c5RKhbv+CsqEmuCoGyI+nhZTVN9kvTQwscB56X0Jb9lmW9m+xhuT49
 lVD/BJzkXwAfoCGHKEUKoUewf5wMG96CbB36Gx5wyl32e7O1pFF9NfJRK21WD+Q9Xqdl
 IF1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783719895; x=1784324695;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MobFM20U5B8VSjNPr43+rhkcxHKF5mKhK38wlqxAKqQ=;
 b=s1hL3yMTOSpZzxTKDvEFur5antBo8HgaDZCPf72T8LMyGP1wD1SuZzjYyQ9Dsskj6i
 7wQF7CBwNK3kOoqYrf1StMiSpOD+zXai1dNLyZ//KtV7bFvo5PVJ5wnFkducBa4xGbdu
 xBFrHhOkvQ6WRvc2ZDOj1HyHC1kxm/0SH/yOnOHFyI8pckhQ1MlRN1za7Zd4ywkv9kKZ
 FzufPIgio5VTB8YUfsJgwvaqn2JXIdGVbs3FW41zUdxiEXdMCiwtCJWsUhCO4FVazzfk
 U9LShNNf7d0/llORcHe3+kEmBcfmoclYRpVqn6ml89pazEjepSEyCoS9Tmvj7GeF+Uf8
 b2WQ==
X-Gm-Message-State: AOJu0YxMJNLRbpMCbjp14Vni1cO0Bbl/2V4n90aE/cvCHs35JWyoM9AH
 uvYjhOxUAt4WTaLFFM2NrselxFMbOFn3SK3pwBKjA2s5HbfPkp2QgR3Q423q7Ld2bfd0C01ElLH
 ISNBdNFWSX87OSfsPJKF8GkGcc2+C1OZDtdQaUnwRSusWvdEOQuN7SYHndIJ0E0BrPQ==
X-Gm-Gg: AfdE7clrcxjughYy2hcfu6PfFWL/MgObOAMAcG7LzedMahRC9frfv4Wi+OL2R+5kgIU
 XCE40PP1KRqj8FJwMqNFp+anxy2QnW/5DTrFNge/akRRo/vTUeLruYcZDD4dlnMTNAKQjprsqq/
 XYp2eNUHZTAIHJ3RY9OgyNR9bH5fVmuuLCI4d/bLVVweTXWezhEbVQZfCp9gXJerkR6n82u/TSE
 40EbTLKWLgoXxMCGh0tWWtxh7BvO+VUOqaGWs9FEZWho6coGoeRiITORiI9IeS+m7PWIQ2CsyVU
 gnVYxajiyES7dLuBfWP7OU0C9lL1jRG4bUD+4LEREMFig8gRTYUNaP7F0LXrFDHd7C6B2VH8TCg
 CJigIryWlqnotql179BJORNzHF4Q/+qJGlg1V00jId/SmPF2KF/18Bi7zc1LaVqMOB/JA6RKIVz
 n4bvuUyA==
X-Received: by 2002:a05:6a21:512:b0:3bf:d0c8:2aa7 with SMTP id
 adf61e73a8af0-3c1108c39fdmr679865637.47.1783719894654; 
 Fri, 10 Jul 2026 14:44:54 -0700 (PDT)
X-Received: by 2002:a05:6a21:512:b0:3bf:d0c8:2aa7 with SMTP id
 adf61e73a8af0-3c1108c39fdmr679836637.47.1783719894182; 
 Fri, 10 Jul 2026 14:44:54 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659c8665sm43539840c88.10.2026.07.10.14.44.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 14:44:53 -0700 (PDT)
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
Subject: [PATCH v5 36/98] tests/tcg/meson.build: add generic plugin tests
Date: Fri, 10 Jul 2026 14:42:40 -0700
Message-ID: <20260710214343.2065491-37-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Ab2B2XXG c=1 sm=1 tr=0 ts=6a5167d7 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=aYnuk8odgv7KkBJ7VmgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: jAE4261H9MUSUG6pWwOgxUfJ9XcaBPdr
X-Proofpoint-GUID: jAE4261H9MUSUG6pWwOgxUfJ9XcaBPdr
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIxOCBTYWx0ZWRfX1lKsnMOJsHFg
 cHYzGIDGGy+5U/JpG1nt7YCL/T+3TbDKQyhyrPHJ8YXXylnf+telbPt1dGQW0cDeQpckHNd5ATn
 jlS4l5pXN6oc8nKfruP3WU7whXyuEWc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIxOCBTYWx0ZWRfXxPonoIMRSFvV
 xVTVRFTSDs/WwrkGQQOXkD2Xde3TgMfbn3vhTSqzYsnbt6qE8KmREHGNU9TnQzdRwQL5L707v/g
 f4X0T+qxxVBKpBCd97QbNHU3mBA79X3GSsxKwUcRcRxNJigYIlHozJ7aJUs5mtB+3ZEg+X8Ya6v
 a6afc5TQlx9WvTrzqTy1KLLd6Fbhs4lba4k7JEOtkxP6AFNkAFofW9KqXA9PeUqwYRV9NiO+1Ij
 8iqaMVlj+oYCMr444HECFyMKKxh9rc7hxkBqcTv+EsmukW5QGPq1IVEooukMmR6b6dgOl3KqHT+
 CfDffEk+KZF6925KlF3M0S9EhaBf5KGug06bmiIfnWv9Yjqoaz0/VkMiHxfRSIE3zIwJlrDRAKX
 ac+s//NGHjb0+IDFemvHME71FWeuYGkATKtWi1qO+FJaW8JyGs0WJ/JhUKrn2iPSXFrdjFQQ8hh
 UNkrr3N2Qi+vxbe99RA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 malwarescore=0 phishscore=0 bulkscore=0
 suspectscore=0 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607100218
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

We add one test for each plugin by picking a different user and system
multiarch test.

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 45 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index d3ec735e7c3..48bf747b316 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -87,6 +87,51 @@ subdir('plugins')
 # multiarch comes second, so it can be referenced by other arch after
 subdir('multiarch')
 
+# Generic Plugin tests
+# add a single test for each plugin in user/system multiarch set
+plugin_tests_exclude = ['patch']
+foreach target: ['multiarch-linux-user', 'multiarch-softmmu']
+  plugin_tests = []
+  tests = tcg_tests[target]['tests']
+  normal_tests = []
+
+  # filter tests that are not plugin or gdb tests
+  foreach t: tests
+    foreach src, setup: t
+      if 'plugin_test' in setup or 'gdb_test' in setup
+        continue
+      endif
+      normal_tests += {src: setup}
+    endforeach
+  endforeach
+
+  idx = 0
+  foreach plugin_name, _: test_plugins
+    if plugin_name in plugin_tests_exclude
+      continue
+    endif
+
+    # pick one different test for each plugin
+    foreach src, setup: normal_tests[idx % normal_tests.length()]
+      # copy existing setup and remove existing cflags
+      new_setup = {}
+      foreach key, val: setup
+        if key == 'cflags'
+          continue
+        endif
+        new_setup += {key: val}
+      endforeach
+      new_setup += {'plugin_test': {'plugin': plugin_name}}
+      plugin_tests += {src: new_setup}
+    endforeach
+
+    idx += 1
+  endforeach
+
+  # replace list of tests with old and new ones
+  tcg_tests += {target: {'tests': tests + plugin_tests}}
+endforeach
+
 image_targets = {}
 exe_targets = []
 # Finally, we can create all test executables and test targets
-- 
2.47.3


