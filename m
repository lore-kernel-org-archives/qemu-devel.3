Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 359FAC43327
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 23:42:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wdG9p-0004lF-A2; Fri, 26 Jun 2026 19:40:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wdG9n-0004e5-Gi
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 19:40:23 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wdG9k-0004ML-TP
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 19:40:23 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65QMx9Pg2206113
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 23:40:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=XIsSvYDB0YF
 joMT3cTFaZ3ZKfXnAINEb6LPUS6LbuJY=; b=dQZIFLGf3MAOUoHU+vbwfJUOioL
 Uq+ECrSUxY8mhpO+FF+e7gKvzmdHOgq/zomnEeZ/ROc8rCYKiVxZY9WbuPA/AWjn
 AJKyKg6R0rUoi2geV8TIwWHFx8Kz5R2m6xhIgbdgoPTdXB7PJDPcIGF7TccAH3KK
 +AO4QEJC9Xx1VP8kwhkCeimMyWhjN0t7jh5ry2eJ0cYn8eeFozzsvL8MMFNd/2eK
 nKePvLtqha5miB1s9huF2y5TCfHzxzDRNQ1fprKTcet0DWbw5qDAefIkWDE+3tRN
 6uFBppdgvD6sCE8qdVRrub2bxX1HkUpSVM1bRO4yWbEaEgOIYlTmsvf4f6g==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f1vm2hcbk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 23:40:09 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-30cb5001ed8so248259eec.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 16:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782517209; x=1783122009; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XIsSvYDB0YFjoMT3cTFaZ3ZKfXnAINEb6LPUS6LbuJY=;
 b=OXTbwmkzwesjq1fFWgdHTLa8V9+yM1FJKpRjK5rIhqMWfdRL9VpPFwfYoqlEpBBcV9
 kCPoYq3jL6LX9OkFDhedPvFOP44nEgXiRxdCpgAW5M2MJEzjABaVFhmsCmUgd3ypPz3J
 Am79INOah0jKu3aNY59/MyLaeCZjzt0BwdWqKkwMf0uP0iTcacj2pixMdKERr5gTCd9d
 zwJ5FEqdFmDLqi7foUGEn5VGAUeIYbEmtoaZrMmvBACQr2WyXKdolz27qPtei+QLmh+o
 abl8IiXCI3pQLssDrue4O18d7rpgWe8DvAhi0lMKRZOTZ21Fx9KEaHs3Kw7+7Tyl8oky
 zuww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782517209; x=1783122009;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XIsSvYDB0YFjoMT3cTFaZ3ZKfXnAINEb6LPUS6LbuJY=;
 b=mDJLjAl69DuC026AzSBQdz1G26L6iiESzMuG0DBexuANrbFKD6Gr/TAdrHCYANIgux
 KB3KLRXv5Uk1gMmlLLeWI9xTimnXKY2lkUP/rw+YujofTVBivN5IifsgpmYn1IpUSuJ8
 09mKYNselkUoJa3UkGX4X3GuAy01XAfKF2CsuCddZv79E2mH0pmPB/TCpQfKYhFSVEYJ
 QUHXtTcdoDSl5vRhqOV8BI9tkjjZm2e9JzwCglDNPg8z5GoxPAmPe5sfzsMcCy37LGvE
 TB0/Zt3+pZWRznnP+c3NTNWg0fqfOZUJEstGjZdWXLVYQfk2E722pTjsrIjIXbvo45ak
 oG9Q==
X-Gm-Message-State: AOJu0YyVAYJIV65mws+cxVfDJhI1Qwc3OjxpsNbEwiBKXTDvS+hsfADx
 PA2XWfRN2q560C5OACTm7BQgLiZPUpiBiNiQlOfNLeqJfdGHYnsyH8Zdj6S405i+xGOBP/G8wba
 FkS7CoCJhIsqlX8wsjbprEmwnZss1T9KXWSo5RE4xYKPl4e5DFnAOXwq5v+RojkiXng==
X-Gm-Gg: AfdE7cm8VYOQzx4GwKt+dlji6im0Q5OhY+yq+5Y91WglQnezovOYDgbA/FOtLGvOmqt
 x3WS5N1sI9aJJ91Mu8xdQ1oKristgX1+kCnrAbfJFvE8dRbuahdn4McpAfjBCcH3zPEWJ+kwVY1
 FqsB4J/UBTSiDUyzFCBjBCZWz+E5Qn8Y7A8kk0EiPac4Ygdvjx39dmQNEfpfMLXvRyp4M7lExtG
 8JYbgaBHQ6mwYChCKRjWXHFMYC41QIwtXTi/CMlLBl7vbRXqyvK+0HIL77HJd707vQb1nZo0MfJ
 NqKQEjEk4lwxFwSlYDjeR6mo8q3NgWXQyRyuCQQcfZ5KT+skQMQSeIg0fMyNQ25x16GSEqmjIOk
 4y/P1Sw/Guiu4vG/miAJZ/nXelKXn7nl/VAJoBxwh8B3orT/bxfHQd7UrxcWkiBur294fVWeNFM
 RuqP4H2g==
X-Received: by 2002:a05:7301:4008:b0:30c:23ab:b7d2 with SMTP id
 5a478bee46e88-30c84db2870mr7350419eec.28.1782517208522; 
 Fri, 26 Jun 2026 16:40:08 -0700 (PDT)
X-Received: by 2002:a05:7301:4008:b0:30c:23ab:b7d2 with SMTP id
 5a478bee46e88-30c84db2870mr7350391eec.28.1782517207921; 
 Fri, 26 Jun 2026 16:40:07 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c52c591sm29369756eec.7.2026.06.26.16.40.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 16:40:07 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH v2 32/37] tests/tcg/aarch64: delegate cc_feat and gdb_feat
Date: Fri, 26 Jun 2026 16:39:13 -0700
Message-ID: <20260626233918.158740-33-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260626233918.158740-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260626233918.158740-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI2MDE5NyBTYWx0ZWRfX1x/vXYxo63lu
 zc624UdtUIEFbOgzQ0Iw0I7MqAaJ6H8d2wA0l7GNVAWKXGDm04wxMfXg4kKUxq/ws3wVoVPwMSf
 cACQowSVGjzu0fyKhsPsej8XtvWksrwi8qzR+As4Sy9WTI0tuFQ8wcxjpW1LnsxM/8tnsLnQxtl
 Bxs0sQj16MyNb90OY9BMUpvoufBflTzkwXnfQojHXf8ECcaSoDm2FovWelFCl+h5O0dA7Oec4S8
 CMW7UZUF/4SP5OHAONv4NbtbZW2g01p23X5cQgBdYtQ4DBhaBP7hBeQ09+aohmodmFH6J7VXLyH
 ZM+XDyCOyBk4YfCLP9EsAwndwb8z2AyGBS3p/iYeqJVPClAU/cO/9TeVWhPgFm/W7eph7aiP1FK
 6M9yRrmuRou+jrCTkEE/Z3eMya411lYkbqYdIas8HG5LZrm65hNvx2Rawng3+foNXTizY3tUbZd
 spkhnnxLPB9PV+TNmfA==
X-Proofpoint-GUID: zjZMZ09hs5_hV-naXtXjasURoVLXP_td
X-Authority-Analysis: v=2.4 cv=UIvt2ify c=1 sm=1 tr=0 ts=6a3f0dd9 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=ReD4dPPu0ofPpr2dz88A:9 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: zjZMZ09hs5_hV-naXtXjasURoVLXP_td
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI2MDE5NyBTYWx0ZWRfX7M1E1dSendZ0
 MjUtlLoq+NQzNQhEKaTrVVhinl511YYAGJDfMZt71NptaE4hzPY+C335Ukm/JzyMOW5wrtQkIw+
 3PrBN/nHhHBId/OUCHmIZ2tEaEJCYQs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-26_06,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 spamscore=0
 phishscore=0 bulkscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606260197
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

We can now declare all tests with their requirements.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/aarch64/meson.build        | 227 ++++++++++-----------------
 tests/tcg/aarch64/system/meson.build |  48 +++---
 2 files changed, 111 insertions(+), 164 deletions(-)

diff --git a/tests/tcg/aarch64/meson.build b/tests/tcg/aarch64/meson.build
index 53085278155..f7c0202ed1b 100644
--- a/tests/tcg/aarch64/meson.build
+++ b/tests/tcg/aarch64/meson.build
@@ -4,7 +4,7 @@ if not cc.found()
   subdir_done()
 endif
 
-feat_cflags = {
+cc_feat_cflags = {
   'aes': '-march=armv8-a+aes',
   'sve': '-march=armv8.1-a+sve',
   'sve2': '-march=armv8.1-a+sve2',
@@ -15,33 +15,12 @@ feat_cflags = {
   'mte':  '-march=armv8.5-a+memtag',
   'sme':  '-Wa,-march=armv9-a+sme',
 }
-cc_has_feat = {}
-
-foreach feat, flags : feat_cflags
-  cmd = run_command([cc, cc_check_args, flags], check: false)
-  avail = cmd.returncode() == 0
-  cc_has_feat += {feat: avail}
-  if not avail
-    warning('aarch64 tcg tests for feature \'' + feat + '\' ' +
-            'disabled: unsupported by cross-compiler')
-  endif
-endforeach
 
 gdb_feat_version = {
   'sme-tiles': '14.1',
   'mte': '15.1',
   'mte-baremetal': '16.0',
 }
-gdb_has_feat = {}
-
-foreach feat, min_ver : gdb_feat_version
-  avail = gdb_version.version_compare('>=' + min_ver)
-  gdb_has_feat += {feat: avail}
-  if not avail
-    warning('aarch64 gdb tests for feature \'' + feat + '\' ' +
-            'disabled: unsupported by gdb')
-  endif
-endforeach
 
 subdir('system')
 
@@ -63,68 +42,83 @@ tests += {
   'test-2150.c': {},
 }
 
-if cc_has_feat['v8.2']
-  tests += {'dcpop.c': {'cflags': feat_cflags['v8.2']}}
-endif
-
-if cc_has_feat['v8.5']
-  tests += {'dcpodp.c': {'cflags': feat_cflags['v8.5']}}
-endif
+tests += {'dcpop.c': {'cc_feat': 'v8.2'}}
+tests += {'dcpodp.c': {'cc_feat': 'v8.5'}}
 
 # Pauth Tests
-if cc_has_feat['v8.3']
-  f = feat_cflags['v8.3']
-  cpu_max = ['-cpu', 'max']
-  cpu_neoverse = ['-cpu', 'neoverse-v1']
-  tests += {
-    'test-2375.c': {'cflags': f},
-    'pauth-1.c': {'cflags': f, 'qemu_args': cpu_max},
-    'pauth-2.c': {'cflags': f, 'qemu_args': cpu_max},
-    # Choose a cpu with FEAT_Pauth but without FEAT_FPAC for pauth-[45].
-    'pauth-4.c': {'cflags': f, 'qemu_args': cpu_neoverse},
-    'pauth-5.c': {'cflags': f, 'qemu_args': cpu_neoverse},
-  }
-endif
+cpu_max = ['-cpu', 'max']
+cpu_neoverse = ['-cpu', 'neoverse-v1']
+tests += {
+  'test-2375.c': {'cc_feat': 'v8.3'},
+  'pauth-1.c': {'cc_feat': 'v8.3', 'qemu_args': cpu_max},
+  'pauth-2.c': {'cc_feat': 'v8.3', 'qemu_args': cpu_max},
+  # Choose a cpu with FEAT_Pauth but without FEAT_FPAC for pauth-[45].
+  'pauth-4.c': {'cc_feat': 'v8.3', 'qemu_args': cpu_neoverse},
+  'pauth-5.c': {'cc_feat': 'v8.3', 'qemu_args': cpu_neoverse},
+}
 
 # BTI Tests
 # bti-1 tests the elf notes, so we require special compiler support.
-if cc_has_feat['bti']
-  f = [feat_cflags['bti'], '-fno-stack-protector', '-nostdlib']
-  tests += {
-    'bti-1.c': {'cflags': f},
-    'bti-3.c': {'cflags': f},
-  }
-endif
+f = ['-fno-stack-protector', '-nostdlib']
+tests += {
+  'bti-1.c': {'cc_feat': 'bti', 'cflags': f},
+  'bti-3.c': {'cc_feat': 'bti', 'cflags': f},
+}
 # bti-2 tests PROT_BTI, so no special compiler support required.
 tests += {'bti-2.c': {}}
 
 # MTE Tests
-if cc_has_feat['mte']
-  f = feat_cflags['mte']
-  tests += {
-    'mte-1.c': {'cflags': f},
-    'mte-2.c': {'cflags': f},
-    'mte-3.c': {'cflags': f},
-    'mte-4.c': {'cflags': f},
-    'mte-5.c': {'cflags': f},
-    'mte-6.c': {'cflags': f},
-    'mte-7.c': {'cflags': f},
-    'mte-8.c': {'cflags': f},
+tests += {
+  'mte-1.c': {'cc_feat': 'mte'},
+  'mte-2.c': {'cc_feat': 'mte'},
+  'mte-3.c': {'cc_feat': 'mte'},
+  'mte-4.c': {'cc_feat': 'mte'},
+  'mte-5.c': {'cc_feat': 'mte'},
+  'mte-6.c': {'cc_feat': 'mte'},
+  'mte-7.c': {'cc_feat': 'mte'},
+  'mte-8.c': {'cc_feat': 'mte'},
+}
+tests += {
+  'mte-8.c': {
+    'gdb_test': ['--test', files('gdbstub/test-mte.py'), '--', '--mode=user'],
+    'gdb_feat': 'mte',
   }
-endif
+}
 
 # SME Tests
-if cc_has_feat['sme']
-  f = feat_cflags['sme']
-  tests += {
-    'sme-outprod1.c': {'cflags': f},
-    'sme-smopa-1.c': {'cflags': f},
-    'sme-smopa-2.c': {'cflags': f},
-    'sme-fmopa-1.c': {'cflags': f},
-    'sme-fmopa-2.c': {'cflags': f},
-    'sme-fmopa-3.c': {'cflags': f},
+tests += {
+  'sme-outprod1.c': {'cc_feat': 'sme'},
+  'sme-smopa-1.c': {'cc_feat': 'sme'},
+  'sme-smopa-2.c': {'cc_feat': 'sme'},
+  'sme-fmopa-1.c': {'cc_feat': 'sme'},
+  'sme-fmopa-2.c': {'cc_feat': 'sme'},
+  'sme-fmopa-3.c': {'cc_feat': 'sme'},
+}
+sysregs_sme = 'sysregs-sme'
+tests += {
+  'sysregs.c': {
+    'exe_name': sysregs_sme,
+    'cc_feat': 'sme',
+    'gdb_test': ['--test', files('gdbstub/test-sme.py'), '--',
+                 'test_sme', '--gdb_basic_za_test'],
   }
-endif
+}
+tests += {
+  'sysregs.c': {
+    'test_name': 'sysregs-sme-tile-slice',
+    'exe_name': sysregs_sme,
+    'gdb_test': ['--test', files('gdbstub/test-sme.py'), '--',
+                 'test_sme', '--gdb_tile_slice_test'],
+    'gdb_feat': 'sme-tiles',
+  }
+}
+tests += {
+  'sysregs.c': {
+    'test_name': 'sysregs-sme2',
+    'exe_name': sysregs_sme,
+    'gdb_test': ['--test', files('gdbstub/test-sme2.py')],
+  }
+}
 
 # GCS Tests
 tests += {
@@ -137,7 +131,7 @@ tests += {
 tests += {'sysregs.c': {}}
 
 # Crypto Tests
-tests += {'test-aes.c': {'cflags': feat_cflags['aes']}}
+tests += {'test-aes.c': {'cc_feat': 'aes'}}
 
 # Vector SHA1
 # Work around compiler false-positive warning, as we do for the 'sha1' test
@@ -154,76 +148,27 @@ tests += {'../multiarch/sha512.c': {
          }}
 
 # SVE Tests
-if cc_has_feat['sve']
-  f = feat_cflags['sve']
-  tests += {
-    'sve-ioctls.c': {'cflags': f},
-    '../multiarch/sha512.c': {
-       'exe_name': 'sha512-sve',
-       'cflags': f,
-    },
-    'sve-str.c': {'cflags': [f, '-O1']},
-  }
-endif
+tests += {
+  'sve-ioctls.c': {'cc_feat': 'sve'},
+  '../multiarch/sha512.c': {
+     'exe_name': 'sha512-sve',
+     'cc_feat': 'sve',
+  },
+  'sve-str.c': {'cc_feat': 'sve', 'cflags': ['-O1']},
+}
+tests += {
+  'sysregs.c': {
+    'exe_name': 'sysregs-sve',
+    'cc_feat': 'sve',
+    'gdb_test': ['--test', files('gdbstub/test-sve.py')],
+  },
+  'sve-ioctls.c': {
+    'gdb_test': ['--test', files('gdbstub/test-sve-ioctl.py')],
+  },
+}
 
 # SVE2 Tests
-if cc_has_feat['sve2']
-  tests += {'test-826.c': {'cflags': feat_cflags['sve2']}}
-endif
-
-# GDB Tests
-if cc_has_feat['sve']
-  f = feat_cflags['sve']
-  tests += {
-    'sysregs.c': {
-      'exe_name': 'sysregs-sve',
-      'cflags': f,
-      'gdb_test': ['--test', files('gdbstub/test-sve.py')],
-    },
-    'sve-ioctls.c': {
-      'gdb_test': ['--test', files('gdbstub/test-sve-ioctl.py')],
-    },
-  }
-endif
-
-if cc_has_feat['sme']
-  f = feat_cflags['sme']
-  sysregs_sme = 'sysregs-sme'
-  tests += {
-    'sysregs.c': {
-      'exe_name': sysregs_sme,
-      'cflags': f,
-      'gdb_test': ['--test', files('gdbstub/test-sme.py'), '--',
-                   'test_sme', '--gdb_basic_za_test'],
-    }
-  }
-  if gdb_has_feat['sme-tiles']
-    tests += {
-      'sysregs.c': {
-        'test_name': 'sysregs-sme-tile-slice',
-        'exe_name': sysregs_sme,
-        'gdb_test': ['--test', files('gdbstub/test-sme.py'), '--',
-                     'test_sme', '--gdb_tile_slice_test'],
-      }
-    }
-  endif
-  tests += {
-    'sysregs.c': {
-      'test_name': 'sysregs-sme2',
-      'exe_name': sysregs_sme,
-      'gdb_test': ['--test', files('gdbstub/test-sme2.py')],
-    }
-  }
-endif
-
-if cc_has_feat['mte'] and gdb_has_feat['mte']
-  f = feat_cflags['mte']
-  tests += {
-    'mte-8.c': {
-      'gdb_test': ['--test', files('gdbstub/test-mte.py'), '--', '--mode=user'],
-    }
-  }
-endif
+tests += {'test-826.c': {'cc_feat': 'sve2'}}
 
 # Semihosting tests
 # Add -I path for semicall.h
@@ -240,8 +185,10 @@ tests += {
 tcg_tests += {
   'aarch64-linux-user': {
     'cc': cc,
+    'cc_feat_cflags': cc_feat_cflags,
     'folder': 'aarch64',
     'gdb_arch': 'aarch64',
+    'gdb_feat_version': gdb_feat_version,
     'qemu': emulators['qemu-aarch64'],
     'tests': tests,
   }
diff --git a/tests/tcg/aarch64/system/meson.build b/tests/tcg/aarch64/system/meson.build
index 2a613cca52d..8242580bf6d 100644
--- a/tests/tcg/aarch64/system/meson.build
+++ b/tests/tcg/aarch64/system/meson.build
@@ -33,15 +33,14 @@ foreach t: tcg_tests['multiarch-softmmu']['tests']
   endforeach
 endforeach
 
-if cc_has_feat['sve']
-  tests += {
-    '../../multiarch/system/memory.c': {
-      'exe_name': 'memory-sve',
-      'cflags': [cflags, feat_cflags['sve'], '-DCHECK_UNALIGNED=1', '-O3'],
-      'qemu_args': qemu_def_args,
-    },
-  }
-endif
+tests += {
+  '../../multiarch/system/memory.c': {
+    'exe_name': 'memory-sve',
+    'cc_feat': 'sve',
+    'cflags': [cflags, '-DCHECK_UNALIGNED=1', '-O3'],
+    'qemu_args': qemu_def_args,
+  },
+}
 
 tests += {
   'asid2.c': {'cflags': cflags, 'qemu_args': qemu_def_args},
@@ -70,30 +69,31 @@ tests += {
   },
 }
 
-if cc_has_feat['v8.3']
-  tests += {
-    'pauth-3.c': {
-      'cflags': [feat_cflags['v8.3'], cflags],
-      'qemu_args': ['-M', 'virt', '-cpu', 'max,pauth-qarma5=on', qemu_base_args],
-    }
+tests += {
+  'pauth-3.c': {
+    'cc_feat': 'v8.3',
+    'cflags': cflags,
+    'qemu_args': ['-M', 'virt', '-cpu', 'max,pauth-qarma5=on', qemu_base_args],
   }
-endif
+}
 
-if cc_has_feat['mte'] and gdb_has_feat['mte-baremetal']
-  tests += {
-    'mte.S': {
-      'cflags': [feat_cflags['mte'], cflags],
-      'qemu_args': ['-M', 'virt,mte=on', '-cpu', 'max', qemu_base_args],
-      'gdb_test': ['--test', files('../gdbstub/test-mte.py'), '--', '--mode=system'],
-    }
+tests += {
+  'mte.S': {
+    'cc_feat': 'mte',
+    'cflags': cflags,
+    'qemu_args': ['-M', 'virt,mte=on', '-cpu', 'max', qemu_base_args],
+    'gdb_test': ['--test', files('../gdbstub/test-mte.py'), '--', '--mode=system'],
+    'gdb_feat': 'mte-baremetal',
   }
-endif
+}
 
 tcg_tests += {
   'aarch64-softmmu': {
     'cc': cc,
+    'cc_feat_cflags': cc_feat_cflags,
     'folder': 'aarch64/system',
     'gdb_arch': 'aarch64',
+    'gdb_feat_version': gdb_feat_version,
     'qemu': emulators['qemu-system-aarch64'],
     'tests': tests,
   }
-- 
2.47.3


