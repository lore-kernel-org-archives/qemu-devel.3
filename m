Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A51DC44506
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 06:25:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi4fk-0007Kz-3L; Fri, 10 Jul 2026 02:25:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4fh-0007Fp-9b
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:25:13 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4ff-0005it-JI
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:25:13 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66A3mhtZ3847274
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:25:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=90T+Ona4k+8
 38scY7wdkWOPPqG8TOtC8sMSbp8ZcUbM=; b=QtqkERdz5JLTlweRrrbOxrxiZN4
 5IGOp92W0biaQFuP8sfCkkKKrnzqbNFifOiVcrAsfuEyOsyka06UzNQHSstGhSWq
 8ajzjp1huexmOGQRG39No3pVL0FrEUqSDpbuNa+Lo1yESnVqF/cwtKpxO7XU+itZ
 pXooKvGjWev6n9nkmw/owaKS0YCQmHMj5lPmOWfkG+t/dc63qVtUzOIMwB335VUM
 KWUCb29Vi6zkd/ReRBQ0kmkJx8ibehjq7UI1LxCg31l2V2hGflhU+DOFN6/pqBMN
 YDGuv11fl7OD5o+1JMZE27oeWM5KRYZdbdU0pGfa8Vd9c0Uw6gyyvNEym+A==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fajte1q9n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:25:10 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c889d1eebafso1419955a12.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 23:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783664710; x=1784269510; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=90T+Ona4k+838scY7wdkWOPPqG8TOtC8sMSbp8ZcUbM=;
 b=DesB875G7YEdcMjcx2FHl+KlDXQ5C5awkOElJI+3JuEQyL8Tovvb7Wub5ErxUFAlhv
 tJremfXaH6Uq2NKwWvpdbTiPMCS/Bm1mRNaw5wtkkvV5P9kinrk9d6AkZ8PLmfxxf81m
 kXz98AGWpn8DJOJcqNNhSxcQ5U/NJM8yIVwjcBHrWwqB6IbvYuWKmioNVruzfDN9HWvn
 583YULVx7WHmnKYYH+U9fyLO9GdRGZK/jtRHjLqFapReuSvjuHVwgVjxKVvmkfye+/5M
 BEMAshebz8kVN/CpDB169EpTbe59uNMKC4n0QVyWxE88FhVAznsusAYr4Rgg8IWoPwcC
 Mo+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783664710; x=1784269510;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=90T+Ona4k+838scY7wdkWOPPqG8TOtC8sMSbp8ZcUbM=;
 b=beOzJEAav4MvRNbLHpg50g6O+ef5slmtTt/GNCYa9lBWNSaFr1MzHhsiXXKUZmKHUi
 riPoUgD80WLUptNjKviydH9lBbjJoC0eel022nJo6aRLzJ3Rmo6s7/3sfEZcK8JX0PYa
 Q2Rifm0y/n1hKUkgiT60SH3kykbwBeQ5zKYR6oSdjcOo/40rYP7ZySfgCy37csgt9IlZ
 nFA9aIFmpBS7MMhPg6/+LE7is6xDjX3KiZQgll5sL0JSJcOWWAecpOgRWYLxU0dvOA+y
 17hoJfg8arsAQnXNnSO52E/1Truf+DwFDWMfnZZoCc5oQ1gA9EuhAQEcOwDqMxWQpQ2I
 5xUg==
X-Gm-Message-State: AOJu0YxU/hTNqv01VmSshbRgi9z1SKF9Zk0yIb/jchkf/qTAsYrudpKS
 1jZ4U9I+5egjwa43yAD92ogqYsEukFhE2xrCtUq81E79ttEP36vBnQ3a2tdcdYzCwHmjUgOly/2
 ArpSDxxxtLyp3yNlRogigRMJMMCmGYOotiM6XXx7PRTLJzjwILfUFS7g3iG7rqs+8uQ==
X-Gm-Gg: AfdE7clWKm0AV4P1bTSH+6s+dv3pEU0caT5StyLlVJafrvJJj5PAguJfAn2iQOHY//z
 lhEo+MoREc7Lf6MW3MyIbla/adtNVz2dErI5OjspZv8n70naAIWyOG5nqFMnjkBpAypPfYM5HyQ
 LDx0uFepCH0U0msmimpKh+f3uWiTL/taHWTRUEjXU8fgWikRu1mEWaYX6jgfXJiW6DM5A1qGBqC
 yjWHoO2M0dDCqowajE3FrH7arhFjk6WkFWRV6ND4zS6VHmXrk9uis0C4RPvDGbx/2El4EJb5mnV
 ZZgo1FiHrCfk9XXaDYLgF5iiUc2aaxuS1hgjkWsHZUGs5eamo0zRKr5ip7hfrk2/f3GfuVKdVgD
 GQGkuopSajtRjytramYqkUMvNK8EBZcs3SwhVZwvFqjsvKqUiFjZ1/xNlLk+XbWBvsLZFKFMKD/
 kfTa0M4A==
X-Received: by 2002:a05:6a20:9395:b0:3c0:9c1b:d0b7 with SMTP id
 adf61e73a8af0-3c0bd312fa3mr11321888637.66.1783664709643; 
 Thu, 09 Jul 2026 23:25:09 -0700 (PDT)
X-Received: by 2002:a05:6a20:9395:b0:3c0:9c1b:d0b7 with SMTP id
 adf61e73a8af0-3c0bd312fa3mr11321849637.66.1783664709212; 
 Thu, 09 Jul 2026 23:25:09 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b6593c4ddsm40606060c88.1.2026.07.09.23.25.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 23:25:07 -0700 (PDT)
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
Subject: [PATCH v4 44/97] tests/tcg/arm: user tests
Date: Thu,  9 Jul 2026 23:19:22 -0700
Message-ID: <20260710062016.1818125-45-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: CT9W2ezyRS6_CQm5thqv-3Q4cNrQG2T5
X-Proofpoint-ORIG-GUID: CT9W2ezyRS6_CQm5thqv-3Q4cNrQG2T5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA1OSBTYWx0ZWRfX2Y2AGPMQbQTP
 hsDgZsjrVv8PrwFfqrOpSHhkqR2YLnzCq4AGkNpP0hmkn8JWGtSevtRVpH4GC3tTt7+4zmsp2QK
 oAXQyaf0fVBxbaTspRGikG3Syla+MvDKysDjao7WTF98vOzGoB4yOXsJL57yonO/qaCm7H0uc12
 F1Dm2fa08/icfxjRi6HPKjFRUhb4+zLdGRxsoduhsI3GDnYWvSoxHO3i3SebnWfTSZXt76v47Q2
 J6KVbZgooIjZN/SvSUWLQQ1Uz2TLY5C0kf4eugsbID3OKj5n4l16s2gkPPnDBS7pcfGAgPOErL9
 RKVh2/OxX4v8Aaw8zXUJ16mkW8w7e9fzpgQWkcelCdEFYWmQkYRHRv1eFJ55VUpNgplPpyyabC1
 6to5pPb27sWs8TwBSZlEM8um0BHba63a1X084SngfBzHwtFMiN0xeLElJXhqUhTOLImdUQ1Z2yM
 WaPrG1GTcGCEuOiW7fg==
X-Authority-Analysis: v=2.4 cv=N7MZ0W9B c=1 sm=1 tr=0 ts=6a509046 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=pzxYYK92jXMFS7HPgjMA:9 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA1OSBTYWx0ZWRfX7NwjdCYz76R6
 o/ZtX0xB2zzEc+IlIN/XV4moI6p7Aq8iAPFqotWHIypyQN5cpKSQ4LHuV6Utf2kivJQI2UwmERV
 Vr7L+au6uJwHrxunro2gFBq7g0xmis8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_01,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 suspectscore=0 adultscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100059
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/arm/meson.build | 78 +++++++++++++++++++++++++++++++++++++++
 tests/tcg/meson.build     |  1 +
 2 files changed, 79 insertions(+)
 create mode 100644 tests/tcg/arm/meson.build

diff --git a/tests/tcg/arm/meson.build b/tests/tcg/arm/meson.build
new file mode 100644
index 00000000000..08a863699fb
--- /dev/null
+++ b/tests/tcg/arm/meson.build
@@ -0,0 +1,78 @@
+cc = 'arm-linux-gnueabihf-gcc'
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
+    if fs.stem(src) == 'float_madds'
+      new_cflags += ['-mfpu=neon-vfpv4']
+    elif fs.stem(src) == 'test-plugin-set-pc'
+      # Require emitting arm32 insns, otherwise the vCPU might accidentally
+      # try to execute Thumb insns in arm32 mode after qemu_plugin_set_pc()
+      new_cflags += ['-marm']
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
+  'commpage.c': {},
+  'hello-arm.c': {
+    'cflags': ['-marm', '-nostdlib', '-ffreestanding', '-fno-stack-protector'],
+  },
+  'fcvt.c': {
+    'cflags': ['-lm', '-march=armv8.2-a+fp16', '-mfpu=neon-fp-armv8'],
+    'expected_output': 'fcvt.ref',
+  },
+  'pcalign-a32.c': {'cflags': ['-marm']},
+}
+
+# Vector SHA1
+# Work around compiler false-positive warning, as we do for the 'sha1' test
+tests += {'../multiarch/sha1.c': {
+            'exe_name': 'sha1-vector',
+            'cflags': ['-O3', '-Wno-stringop-overread'],
+            'expected_output': '../multiarch/sha1.ref',
+         }}
+
+# Vector versions of sha512 (-O3 triggers vectorisation)
+tests += {'../multiarch/sha512.c': {
+            'exe_name': 'sha512-vector',
+            'cflags': ['-O3'],
+         }}
+
+# Semihosting tests
+semihosting_cflags = ['-marm', '-mthumb', '-I', meson.current_source_dir()]
+tests += {
+  '../multiarch/arm-compat-semi/semiconsole.c': {
+    'cflags': semihosting_cflags,
+    'wrapper': [prog_run_with_input, 'X'],
+  },
+  '../multiarch/arm-compat-semi/semihosting.c': {'cflags': semihosting_cflags},
+}
+
+if 'qemu-arm' in emulators
+  tcg_tests += {
+    'arm-linux-user': {
+      'cc': cc,
+      'cc_dockerfile': cc_dockerfile,
+      'cc_docker_host_arch': cc_docker_host_arch,
+      'folder': 'arm',
+      'gdb_arch': 'arm',
+      'qemu': emulators['qemu-arm'],
+      'tests': tests,
+    }
+  }
+endif
diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 05e2078505f..8af1352901e 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -136,6 +136,7 @@ endforeach
 subdir('aarch64')
 subdir('aarch64_be')
 subdir('alpha')
+subdir('arm')
 
 image_targets = {}
 exe_targets = []
-- 
2.47.3


