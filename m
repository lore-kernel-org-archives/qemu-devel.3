Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD93EC44501
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 21:49:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiJ5w-0004Wo-B5; Fri, 10 Jul 2026 17:49:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ5c-0003fs-Hl
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:48:56 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ5a-0004wC-Bd
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:48:56 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66AK3UXn1752832
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:48:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=txHnoEcoAuM
 6Kf0+WhkWSCKp/0Z+/busSTuH5fB4+yE=; b=L3JksMDeB+DPA4av6B1FJ+prZlc
 pOb9Xbeg5rCPzd9T+w46vo4pwKDRFg1l0aDd45Nwx3N49WHfULmx6U2ALHHoq7+2
 eF1Nn1ZHB3WArBf8DksvwJCoNOZCZYHD8FJETduhe/SNFoDD6zVq7oATcuwUrQI3
 1ZSGjKUl//E6Cync8fOCkuv3vO8ZShNTJAecQNG3aURfDrlEGxe1JbiwcaEDNhaI
 albXizwfUalKSTo1XYWipGWWpB4tfTKn4vb76hvKS5e5ntQXwy8ZWlqV7cr4UJ4b
 AeXsd5tCaUytJBApA1L1s5QtDrQQuD9/hp026peFyYhT+wpDsLN7t+jLOsg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fb2pc9gxm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:48:53 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-38d7fcd1f66so1704402a91.2
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 14:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783720132; x=1784324932; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=txHnoEcoAuM6Kf0+WhkWSCKp/0Z+/busSTuH5fB4+yE=;
 b=M2RnLPPxDztWNEZfB9SOg7bctJ1Jj7btRTwFgTVzd75G2tD+Yr+DphYhN6RS4qVSCt
 4YMVt13BxUsCXjQC9RXiL+5brSp0k2qzOTZFVpAJiGU3tBoIhHDBuQ23Cjj8xt78uHAr
 mb1gyQZ8smqn0o6iXgXx7xvx7OamoGkH6chXqlK7gDpBc9TCMi1QyLJTaPU79SMc4frX
 41bRyUF0pllWRvBq75Dj/b1VNlbdHD2unm08eGe/tispYfR8vv3KQI6376eV03wpYBfn
 Itt87ch9q4EcmMFACFgIqW68MEEJoTzQoqhJaQBr2k8gSLSGF/Q1nZGwyRbwxrcP9aCR
 jzvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783720132; x=1784324932;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=txHnoEcoAuM6Kf0+WhkWSCKp/0Z+/busSTuH5fB4+yE=;
 b=ijahaPXkC8aXngo0592MDhODJYrj9a6tUiD862yICgbWmm3zC6KQMPhGE8DoOT2nQP
 kOt27DcVY42XnDfE5EeKgRwLGJ/xW/cS64FeVf0cxl69SpDSF7b44uIxj2J6jn51Lblf
 AI+wnrMkxfyD4Evkp/KePvueP+yhDqM799vG4TaxJSgP5TIxFH3MOg0P1vq8yPfbb+X0
 7oPdA069alHQjJBPWspsu21TTNiHPVjkt201tqjIf7vyGq8n4suMeieM5WTuCMlGfBbi
 POhD2dQDhrnTLOcAx5pVHXJWxpTqpALTROGWP9HJws0q2Nbbj8zkMPuLsrngtqS5ZpgK
 R/1Q==
X-Gm-Message-State: AOJu0Yz00cEnqomsca1KKz1vMPvUgSlfck+rXKjU+NqaxgWMQPdVR+d+
 7OifTOEZHHXplA/vs97sty9Uig298gO7WuKthIT6jQvQTlPCjjqewsgyDliP3QoV25l/WJ1MNmD
 9csGe0W5dfJwCYO1fiBQNDij3SD6TyElzy9BI1XzvkK2luf0yuTP4XdaHVkoeatWjhg==
X-Gm-Gg: AfdE7cl6PpW0K2NQu+FWAeSuWy2JaBZ458FeqpuPvotRKaxJyjKgjcEfQSziVp7UWgi
 AzLlSnMNwHerThhAL3kFfflNuk3ni5colfqwBq5vZX+603tHN61jTdKRS31hiCT0VmAqiP7nXda
 ScNayBA0eBfqeNLJZuH0QiVLy3vWwlTJTY72Foyw2sL5vm13vc1yMJdQo6xeLGgHTd2YWdmPuuc
 0VQkGxfOZgdVRCSTFJ4RkkhMXbRrmBpgmiFXAUeZKUKe7cxE9RVVUeWP7gvHcK7NGiUW4SstXKP
 Awm8pF0FX7mvzaleX05bNqGhvmDGrbkTA43M6xDmltdaKVnjmtfsPUrDkQEPy8V6cowmSh2itoP
 ag3ttz7x+/Edu939bss/rq0rQ6wROp62Csctzw9CLCOBOTqhESZXrWEBT2B7unMEkvxHpBAvwDx
 VMY3TVIQ==
X-Received: by 2002:a17:90b:184d:b0:37f:9ce1:736a with SMTP id
 98e67ed59e1d1-38dc77759a8mr612802a91.32.1783720132193; 
 Fri, 10 Jul 2026 14:48:52 -0700 (PDT)
X-Received: by 2002:a17:90b:184d:b0:37f:9ce1:736a with SMTP id
 98e67ed59e1d1-38dc77759a8mr612776a91.32.1783720131712; 
 Fri, 10 Jul 2026 14:48:51 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-311838c9235sm39886355eec.21.2026.07.10.14.48.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 14:48:50 -0700 (PDT)
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
Subject: [PATCH v5 56/98] tests/tcg/loongarch64: system tests
Date: Fri, 10 Jul 2026 14:43:00 -0700
Message-ID: <20260710214343.2065491-57-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIxOSBTYWx0ZWRfX8z+LzByVyzZC
 ySaIH44rOVPvvcw2wTwDiuB2WtLn88LNDpXmyIWHKzKDPyXAHyZQoqBVe1pbOrDWu5/2VxJs/0h
 KJ4DJ+MsOsyWvVRkqz4ajJLi6ode/E2wsF3wWHgbhxBMPLm0i3z5wGkYY6MutWXOpQa1bx+LmC0
 NwsVX9JbPwmIT0SRqLpD51RnzLVIlnj/8eSwewL/3F157RuRDiBnocQr1YMP3z1ONWnEAahULOM
 hwiX92Y6p71jFhGa5NuuovXBFpE2Ohcas1u2ud4t+TIdvq2Ln+HtQ2v8J98TFhrGSrntgAhvs/g
 xjLwqJwGMDiE8PosA5WMVuvkPLtNkbM24uAU8Gq+7f+/g2+M86OLzeb5v5bpvyr7ccZeF1YJUpV
 evCQSVQcWBbSqlGcKH7SHpCZ460e31dJ9fWDXia20JQT/CWpxcMWMsgU8pYUdfB0dl56li0uQz2
 QPIcnAO3TVzyxBC+Zzg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIxOSBTYWx0ZWRfX7ONPC5iflNWj
 NFZ3xUEbPowhZF/nZ/lE4iP2Otxssc3zJ150ejva+Ojfh3QUB6rszgqx/DZbdeLfj1ALeohR8c8
 mvdeqghHUcwXxlqHRisRAqwzFou62ws=
X-Proofpoint-ORIG-GUID: SBz6jwx0nVrw43lvOq7vNRp8wao6juyM
X-Authority-Analysis: v=2.4 cv=J9SaKgnS c=1 sm=1 tr=0 ts=6a5168c5 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=FVW9kWhLySRIolcT2UUA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: SBz6jwx0nVrw43lvOq7vNRp8wao6juyM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0 adultscore=0
 clxscore=1015 suspectscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607100219
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
 tests/tcg/loongarch64/Makefile.softmmu-target | 33 -------------
 tests/tcg/loongarch64/meson.build             |  2 +
 tests/tcg/loongarch64/system/meson.build      | 47 +++++++++++++++++++
 3 files changed, 49 insertions(+), 33 deletions(-)
 delete mode 100644 tests/tcg/loongarch64/Makefile.softmmu-target
 create mode 100644 tests/tcg/loongarch64/system/meson.build

diff --git a/tests/tcg/loongarch64/Makefile.softmmu-target b/tests/tcg/loongarch64/Makefile.softmmu-target
deleted file mode 100644
index 6d4a20fde73..00000000000
--- a/tests/tcg/loongarch64/Makefile.softmmu-target
+++ /dev/null
@@ -1,33 +0,0 @@
-#
-# Loongarch64 system tests
-#
-
-LOONGARCH64_SYSTEM_SRC=$(SRC_PATH)/tests/tcg/loongarch64/system
-VPATH+=$(LOONGARCH64_SYSTEM_SRC)
-
-# These objects provide the basic boot code and helper functions for all tests
-CRT_OBJS=boot.o
-
-LOONGARCH64_TEST_SRCS=$(wildcard $(LOONGARCH64_SYSTEM_SRC)/*.c)
-LOONGARCH64_TESTS = $(patsubst $(LOONGARCH64_SYSTEM_SRC)/%.c, %, $(LOONGARCH64_TEST_SRCS))
-
-CRT_PATH=$(LOONGARCH64_SYSTEM_SRC)
-LINK_SCRIPT=$(LOONGARCH64_SYSTEM_SRC)/kernel.ld
-LDFLAGS=-Wl,-T$(LINK_SCRIPT)
-TESTS+=$(LOONGARCH64_TESTS) $(MULTIARCH_TESTS)
-CFLAGS+=-nostdlib -g -O1 -march=loongarch64 -mabi=lp64d $(MINILIB_INC)
-LDFLAGS+=-static -nostdlib $(CRT_OBJS) $(MINILIB_OBJS) -lgcc -Wl,--no-warn-rwx-segments
-
-# building head blobs
-.PRECIOUS: $(CRT_OBJS)
-
-%.o: $(CRT_PATH)/%.S
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -x assembler-with-cpp -Wa,--noexecstack -c $< -o $@
-
-# Build and link the tests
-%: %.c $(LINK_SCRIPT) $(CRT_OBJS) $(MINILIB_OBJS)
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS)
-
-memory: CFLAGS+=-DCHECK_UNALIGNED=0
-# Running
-QEMU_OPTS+=-serial chardev:output -kernel
diff --git a/tests/tcg/loongarch64/meson.build b/tests/tcg/loongarch64/meson.build
index 209179fd96c..1d62de64ed6 100644
--- a/tests/tcg/loongarch64/meson.build
+++ b/tests/tcg/loongarch64/meson.build
@@ -2,6 +2,8 @@ cc = 'loongarch64-unknown-linux-gnu-gcc'
 cc_dockerfile = 'debian-loongarch-cross'
 cc_docker_host_arch = ['x86_64']
 
+subdir('system')
+
 tests = []
 
 tests += tcg_tests['multiarch-linux-user']['tests']
diff --git a/tests/tcg/loongarch64/system/meson.build b/tests/tcg/loongarch64/system/meson.build
new file mode 100644
index 00000000000..b46d2234032
--- /dev/null
+++ b/tests/tcg/loongarch64/system/meson.build
@@ -0,0 +1,47 @@
+tests = []
+
+minilib_dir = meson.current_source_dir() / '..' / '..' / 'minilib'
+minilib_printf = files(minilib_dir / 'printf.c')[0]
+link_script = files('kernel.ld')[0]
+boot = files('boot.S')[0]
+cflags = ['-nostdlib',
+          '-Wa,--noexecstack',
+          '-I', minilib_dir, minilib_printf, boot,
+          '-Wl,-T', link_script,
+          '-march=loongarch64',
+          '-mabi=lp64d',
+          '-Wl,--no-warn-rwx-segments',
+          '-lgcc']
+qemu_def_args = ['-display', 'none',
+                 '-serial', 'stdio',
+                 '-kernel']
+
+# Multi arch tests
+multi_src = []
+foreach t: tcg_tests['multiarch-softmmu']['tests']
+  foreach src, setup: t
+    new_cflags = cflags
+    if fs.stem(src) == 'memory'
+      new_cflags += '-DCHECK_UNALIGNED=0'
+    endif
+    if src not in multi_src
+      setup += {'cflags': [new_cflags]}
+      multi_src += src
+    endif
+    tests += {src: setup + {'qemu_args': qemu_def_args}}
+  endforeach
+endforeach
+
+if 'qemu-system-loongarch64' in emulators
+  tcg_tests += {
+    'loongarch64-softmmu': {
+      'cc': cc,
+      'cc_dockerfile': cc_dockerfile,
+      'cc_docker_host_arch': cc_docker_host_arch,
+      'folder': 'loongarch64/system',
+      'gdb_arch': 'loongarch64',
+      'qemu': emulators['qemu-system-loongarch64'],
+      'tests': tests,
+    }
+  }
+endif
-- 
2.47.3


