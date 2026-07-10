Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07994C44501
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 06:23:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi4cQ-0003Aj-Fj; Fri, 10 Jul 2026 02:21:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4cJ-0002vw-UZ
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:21:44 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4cH-0004p7-7y
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:21:42 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66A3miTC3847282
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:21:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 u2nzzJHMv60smnpxLhw0FeyaZNsxK3Hss1+7HWLPaWU=; b=MiXdvkhBeBEd3/q8
 9QSWQLecAIUjA8nFSmYBFiwHdctOFdA1j3s49Q91obm7zU3DZl0ehaG/0NjxVT0R
 Me+wCnKfw2CCs6u2gG1PfYRe+pEPQ+jvkIAxvex8JJ0e/TQhSFrA4HsfOMBq9kbG
 EDg253HlVfrhJR2omT0yzG7GIejoGGKQ5GC6WNu25nt3AOIIYcG99W4BwYulNzeB
 Jn3Q6hz0KwDy9hVDRQbwClrCji5UCp3lYKMucLpJWUZatm5BkpbAoeyMU+8g0H0E
 paiOM1JOLLKP7UmZau7wDlpP6NQZAMws1PXS6LcLSNlvbPHsNZAXqhzf6vC/xqAG
 H5kFZQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fajte1ppu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:21:29 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-ca8aee88725so741717a12.3
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 23:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783664489; x=1784269289; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=u2nzzJHMv60smnpxLhw0FeyaZNsxK3Hss1+7HWLPaWU=;
 b=DRAlGviqytPFrEKRKNodfraiRZMnJFDnlgwX7qEXufiNorkAw1tg8IXJ5w0issEzCh
 CWZLUnbbHg/MnsXQNyGXdsjKegzeiBL84A6fQoGc0IMyGE4DqIwj1dvSQfup7bv0uM3Z
 ZNd2XmSBwxvmdTv+y+M792AGCtTOPfbn8plu3plExjobYmUZXIotMmG1TBgrCwqgWMbW
 xQkOhjQSE7vza8TrQqdO/TkDuw6qu+aC1h0j69Eoh5cHDCyCG9HQNsUK76qEZYc+dd0O
 qZc7uwAvPOaeLuu7oYolOLUumraSnfAXsAlhJ4Mc9UwQYNx0/Qvqi86mJ1KFA6+4C4dP
 58jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783664489; x=1784269289;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=u2nzzJHMv60smnpxLhw0FeyaZNsxK3Hss1+7HWLPaWU=;
 b=glrcvUFbaFq7KkJdWR5hd/QwO3ZYAszXnt+3h6wlfu4ooSMbEF9Y5ArjIIk9okTDK9
 LOudXj4tGOplaPDpkoFXuFKZWMkRzDeMXI+1TmfUp7f0oXP0Kj+JtgBp5Swo4fekAfBd
 6ujPhpm27XwidQF7Ygoi2Em3F5qmbGCZCEoQE1y3EobL5f5lxQNz57QJguPevnlWXysv
 apFxdb91/gcso3YoHHC5QuWpieiV9SPl58ZlGkUKbXAbywpzloTus/te4ZusPdOMu0KH
 0XEMTGas6VSbRsFOWw3hJSsoHr5jfcNgrIdU1xTlt9G2IxOS9D9ucX6aVPTPWNS9rU7f
 Rssg==
X-Gm-Message-State: AOJu0YxTJqot3D5bxmBnLhlFGLGGrLJlPL/m1JOTH3gCWKj+o5pew2ZR
 gtdjHK9V+iF63E55QB8iUtPT1r27XSCpPwWHSFZoBJlWMsbkshKJgwFHDNwhVIirGEPvCzOVcJo
 ubSRw+jF8lLrffq5Xk0EkrHYRYo5eXsioEUu3Dyz1A7kwAjtOj9o++c3cCg8693pV2g==
X-Gm-Gg: AfdE7cny9ZF/J0J7XK9evTOVEyASUlxUqXT5xHkhiphyaR7f+I+Aoyogz5hpQ0oGZJ1
 ruutMjrC/WbEyGLL0OrYPA/5oZC8AHJW67rzIWmK+qsSG3ZnkSrBvJ6D4ghTHp6iDYIT/tmNw7q
 Mx+XDEJwcUvuY6VI75ZMDQwpAqjE3fQtk7SaCCNMwfDF4H/RoGBLua2IyEP9umlfJSfUIOgMDxj
 JEAm9mJLXYOMfTKS9nDG15ACSTH0gXhk7J8s6oGSQONX8cTnk8s4abvuBb/pp6fQLWYI4+fW9DF
 IRGkaOkmYLVaY3T/BiUbkB7wtQlHu/1KZ1lMyuLWKaJi2/Aas+xC3wT4j1dhBf17CWgvzm2ur+g
 AxRxJJj8PDT0XH4TteEtls08w0Wq4hnwXkYZ5znFNA3fdm1KAI5fLhAm8VKzKvBGUT/LPxhCF8i
 XM3iLRzg==
X-Received: by 2002:a05:6a20:12cf:b0:3b3:fdb0:2288 with SMTP id
 adf61e73a8af0-3c0bc55cd9amr12750354637.0.1783664488685; 
 Thu, 09 Jul 2026 23:21:28 -0700 (PDT)
X-Received: by 2002:a05:6a20:12cf:b0:3b3:fdb0:2288 with SMTP id
 adf61e73a8af0-3c0bc55cd9amr12750323637.0.1783664488195; 
 Thu, 09 Jul 2026 23:21:28 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659fa13bsm35428126c88.15.2026.07.09.23.21.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 23:21:27 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Gustavo Romero <gustavo.romero@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Helge Deller <deller@gmx.de>, Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v4 35/97] tests/tcg/meson.build: add generic plugin tests
Date: Thu,  9 Jul 2026 23:19:13 -0700
Message-ID: <20260710062016.1818125-36-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: xOQN4xHuRbW_Y6NhemiLjGsA9q6bxuGX
X-Proofpoint-ORIG-GUID: xOQN4xHuRbW_Y6NhemiLjGsA9q6bxuGX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA1OCBTYWx0ZWRfX63rY9basTsz3
 pVeMolBjIUCEGjF4hZg4gQ5Ed7UQdTYXdgmdJPt5bB/lKCeRf0YpBirpc3+Ozg39Rl5r9o4UlQr
 YMJ71i++y6YpeM1WpoFbly5+uot1BGwaUOINrRVXdtLQE5HgOExRYY3QtOocK9EjLgpaeVDkRAS
 FLSjoeG2OJQMIkx1Fs7n6Fa0K0H9QmFg9FsRLg0urZti2hIg8PUI9rJZuVI7rKbokqOlddpO6O0
 YaiiKwEyCUDVmJzp/H+1m/codShFrLie8y3gaut1c9zo2rjQG2dAjtcixspjpicH3pJtLTANI+T
 NNcjjn3HrsRlKyjsWmCDgGq4G64NIxxHvWs030Ta1fY/ut1gNFe3iyNFxGfgseOn6KPInhDFR4+
 l807kTa1uNgEmMgLhicukMgETdkSwiXtPXDv3f13zsyJVsbMgh/AddmkYgDxPM2GkwWNgDwESLP
 /wv+jfF+YYDRbvtw+ZA==
X-Authority-Analysis: v=2.4 cv=N7MZ0W9B c=1 sm=1 tr=0 ts=6a508f69 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=vL3LB450FgUFwDIFpOYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA1OCBTYWx0ZWRfXyFmTbK8iKxBV
 2WDuCaba2ehig2nzwebO6iJeNAixJa50UsAVjGBmAR6hCRmc4pCIWOoMDXL7139KMbdaCFELKjk
 M+G6aLxefJ8UPmpZP5h5G7eq3i+JspA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_01,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 suspectscore=0 adultscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100058
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

We add one test for each plugin by picking a different user and system
multiarch test.

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 45 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index dc488a32e6f..8e07bfca69e 100644
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


