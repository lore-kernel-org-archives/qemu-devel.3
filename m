Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 279B7C54F52
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 04:47:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woZjK-0000lB-Tp; Tue, 28 Jul 2026 00:47:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZj4-0000S6-LL
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:47:35 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZj3-00023t-0M
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:47:34 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S3b26P1424076
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:47:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=GYKxorMATds
 E0nCRGANLt7e8rSz/gPSZ3m87FSX3rxs=; b=kCRCMW0WzUiRyNJ17IGF3ZKE63c
 y/4eOzACEo8uQ6518tBQWE3HpKtcSU46GTsE2TyeTbjduy2LMdGV/lwuJroM+C5h
 z7kMZNnKy//ER9MAiRDOueyp9RDknp/VeOp020zmJ5F5hKlL7sLUdLeF8XrWzDSM
 xZlhAsCwgPxj2GlAV7vh3+KxsoOOiLZMwnHLdQqfiLnQloCj4p9U4HAON3MUujJV
 8TpuUIrssw015jrOcXecuv+2U5li2vGdHPVude4nGZmQKz2nAR35mMfvYw1T7JQf
 scE2V+PZ2rdsZqmHaphLKqWet9aOOxhD8oOKH56soj1HqbIWgskQPwfdTnA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fp3v2mpsh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:47:32 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cb48f41343aso486322a12.1
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 21:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785214051; x=1785818851; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GYKxorMATdsE0nCRGANLt7e8rSz/gPSZ3m87FSX3rxs=;
 b=SgYomVL7Rjyi9gzqKfoN+Fpp9lpDmHbuDWmXmhhRZN16wAu/FGVCnpCQuKNfsEKmuv
 +I7poQ1IAC2TUWt46C6F8FTFRgcBnb6Qqdj2bPSelktr9llOo+TyULKN7XvXkya+PMWV
 eYOeecr3MDpxB0jYKJdSQz8/Hxorjqp1VBdkhqp61hmFwsFSluFgN8iuVe98DtsALrkx
 u3COFXQkdC5f/Y5WPtZsxkpXvleGtA7sCPFXYxnzguxOqepHOpAAWJxQMjaP4m71xKuh
 9b4svmHCWl6g6UbcZ8bzJjgffMjXksJ0RHK8G7FmeUDX00wBdfDxpjoCNkOTiBKXwIom
 8BnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785214051; x=1785818851;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=GYKxorMATdsE0nCRGANLt7e8rSz/gPSZ3m87FSX3rxs=;
 b=f3qzA2OtiwfLGZwTC2MNdCj9iLPblhfhEGgGQnoiF0HYgZJJ2ETjTVquejNDHCvZbf
 qjHAUJycQw2b4gf7UBCgOU9dDv44DpmRDQJ+S9B2y3soKndtbCOeyfTidEIAY+w8iSGt
 XQDAJcQLsGfVy5cvPkrXFqOjiJA5vbpNfz0s0SoQDHPT5Gcn8DjZPFdXKUnqJRWmzOIc
 Y+prKOnU92UiSpESK1saDcOC7SyUUI8Za/txb2tjP30tqtBvZmJuwlyOrLbQzIvO/jc6
 dtrZkJHr9BlelKoI9tWwmmHerxfSDvWG/QEn8izhIID9PBHE4n8gjUeP3GCmg07rls9V
 r0wQ==
X-Gm-Message-State: AOJu0YxoItckIOzj1F9eJ0obk8oZYGrqc0QA79wlEWJMjMPkqzQ+3vX/
 VgRatEXdb198yZAIs9YP3hVxKP3X/eJvJbuEBz5KJhYxRjOVYmu+FER2bZYbKtGIXzP86TWCwkr
 3PITBMMxkXD9mpt7wS41RKHin8deUtsYRXbiymGwZQTc7E/tinzpqA/UFePn/WqOHcw==
X-Gm-Gg: AR+sD13h4svap42YV7h8/lQAG0ffzIen/VKOAzq9Jjs8u86u16YbJOeMZWxeik6eZbb
 VtDf/CBJR+AnGREzMq9znxef6Pp15XFeZbDvBOWHj0H3P0pxsZSuFvR6rV0czA/8YltrNqoHzp3
 hE5LXjOdeIBsp+052lhjn5OZNgWhRkUklyYvaxvBqrpMKLcAL6IRX7fenVsa24AWHRsn5ZMgViQ
 2VNx8PIOPVTJpLLptUYTEn9ipKV2o83G34vcNruDREn4UsuwXLHS33AM+hox9ZIcpnwb7O25nko
 +JMlsoBVkaD2pH9RDk2hpVCkFuNjs/eATciK+I28K46cZ1HMH+bwYr4In6a4B61/E0FTSK29hye
 gpDTSc0BOIqxx/Uj/mtTpifjzSQNnFlVLnqJO4hI5c71mqQTnO9WJt9/61kmYSO13WMci1Mo=
X-Received: by 2002:a05:6a21:a247:b0:3c4:2cd3:f0ba with SMTP id
 adf61e73a8af0-3c8ba639934mr1144513637.31.1785214051102; 
 Mon, 27 Jul 2026 21:47:31 -0700 (PDT)
X-Received: by 2002:a05:6a21:a247:b0:3c4:2cd3:f0ba with SMTP id
 adf61e73a8af0-3c8ba639934mr1144480637.31.1785214050654; 
 Mon, 27 Jul 2026 21:47:30 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13d13003f12sm103090113c88.2.2026.07.27.21.47.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 21:47:30 -0700 (PDT)
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
Subject: [PATCH v6 044/103] tests/tcg/alpha: user tests
Date: Mon, 27 Jul 2026 21:41:48 -0700
Message-ID: <20260728044248.137626-45-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA0MSBTYWx0ZWRfXwtX0QTR6AoQf
 uGxHxZlqmPkEOX4HLGMz2/niqRTlpLtpJFkDO0fCbi5YeWcUMenzvHRmT/Po186sc5awRwq+V70
 Mi/xWq3nlFuNKAiAMSliKhTOG2xFc4k=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA0MSBTYWx0ZWRfX4WqR0be2IavR
 ht/ko2tlWADS9ITkQ9GAB8TAIjz0TwV7uEjAovr2oYqGF2xRk9WwG1acOxVRT+FEpWmvz6f++zQ
 tIOGccdTANlNEyvKqe+Tzcot9+LRLELNGUaQjuptnKjvrohhAoaGFSGUkdplu3QgKfjk+9zLgFE
 8/mWlE8+uvJJGFP6gNONTV5Entm4FcHX+cX4JmBpUDFNOvbjm413iaefs3Lrvb7uhasZ7GjfMS9
 1zSelM4L0GN7PJ/7yWyX+vFvpuCF/1s1ZepJJMyjnqa3iEI6/R+rVNvpTdxqF7lynVWG/gho0eP
 +/Jq4B8Ur4W4gGLnlm4pVpY8dMgoknqHVmEdpAUEiV4Tz2ySQN4Xu1gE5JuypbnSXCjkr28wfLB
 cfEnCuinencwjQ7tNNJdGH8g8Zro1Gwei4R/64Ejm0XZn2bod33hn6oPajv1cxxTQZs3uIPb9VO
 9iFNijENvKCCmVrdWug==
X-Proofpoint-GUID: 52o4ytQTlJlDBuSIfjX_bs_xcEIzzi0Q
X-Authority-Analysis: v=2.4 cv=KJ9qylFo c=1 sm=1 tr=0 ts=6a683464 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=HlkHknZ0qViDtorXcHIA:9 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: 52o4ytQTlJlDBuSIfjX_bs_xcEIzzi0Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_01,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0
 phishscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280041
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/alpha/Makefile.target | 18 -----------
 tests/tcg/alpha/meson.build     | 53 +++++++++++++++++++++++++++++++++
 tests/tcg/meson.build           |  1 +
 3 files changed, 54 insertions(+), 18 deletions(-)
 delete mode 100644 tests/tcg/alpha/Makefile.target
 create mode 100644 tests/tcg/alpha/meson.build

diff --git a/tests/tcg/alpha/Makefile.target b/tests/tcg/alpha/Makefile.target
deleted file mode 100644
index 36d8ed1eaea..00000000000
--- a/tests/tcg/alpha/Makefile.target
+++ /dev/null
@@ -1,18 +0,0 @@
-# -*- Mode: makefile -*-
-#
-# Alpha specific tweaks
-
-ALPHA_SRC=$(SRC_PATH)/tests/tcg/alpha
-VPATH+=$(ALPHA_SRC)
-
-ALPHA_TESTS=hello-alpha test-cond test-cmov test-ovf test-cvttq
-TESTS+=$(ALPHA_TESTS)
-
-test-cmov: EXTRA_CFLAGS=-DTEST_CMOV
-test-cmov: test-cond.c
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS)
-
-# Force generation of byte read/write
-test-plugin-mem-access: CFLAGS+=-mbwx
-
-run-test-cmov: test-cmov
diff --git a/tests/tcg/alpha/meson.build b/tests/tcg/alpha/meson.build
new file mode 100644
index 00000000000..08e371116c3
--- /dev/null
+++ b/tests/tcg/alpha/meson.build
@@ -0,0 +1,53 @@
+cc = 'alpha-linux-gnu-gcc'
+cc_dockerfile = 'debian-all-test-cross'
+cc_docker_host_arch = ['aarch64', 'x86_64']
+
+tests = []
+
+# Multi arch tests
+multi_src = []
+foreach t: tcg_tests['multiarch-linux-user']['tests']
+  foreach src, setup: t
+    new_cflags = []
+    if 'cflags' in setup
+      new_cflags = setup['cflags']
+    endif
+    # Force generation of byte read/write
+    if fs.stem(src) == 'test-plugin-mem-access'
+      new_cflags += ['-mbwx']
+    endif
+    if src not in multi_src
+      setup += {'cflags': new_cflags}
+      multi_src += src
+    endif
+    tests += {src: setup}
+  endforeach
+endforeach
+
+tests += {
+  'hello-alpha.c': {},
+  'test-cond.c': {},
+  'test-cvttq.c': {},
+  'test-ovf.c': {},
+}
+
+tests += {
+  'test-cond.c': {
+    'cflags': ['-DTEST_CMOV'],
+    'exe_name': 'test-cmov'
+  },
+}
+
+if 'qemu-alpha' in emulators
+  tcg_tests += {
+    'alpha-linux-user': {
+      'cc': cc,
+      'cc_dockerfile': cc_dockerfile,
+      'cc_docker_host_arch': cc_docker_host_arch,
+      'folder': 'alpha',
+      'gdb_arch': 'alpha',
+      'qemu': emulators['qemu-alpha'],
+      'tests': tests,
+    }
+  }
+endif
diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 0b1ab5b5921..e0d4e04f974 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -138,6 +138,7 @@ endforeach
 # Now let's go through all architectures
 subdir('aarch64')
 subdir('aarch64_be')
+subdir('alpha')
 
 image_targets = {}
 exe_targets = []
-- 
2.47.3


