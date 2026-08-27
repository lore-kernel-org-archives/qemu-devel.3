Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0566C61DCD
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:19:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziRK-0002IH-Cq; Thu, 27 Aug 2026 18:19:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziRB-00025i-2f
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:19:09 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziR8-00074E-Aq
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:19:08 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJM578219015
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:19:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 p1tF2BXkL8d3GdBpXJrb6vLO0JrmxMQXVL4plOEG8fw=; b=ZBCYb6pxUqekWRSU
 9zALCSVk6uyBY/L/0+f5GD/sgJEhwTzjM7aIUCQSKLfY9KQptef5EuiPlZVN4ssj
 8RdsjNIX1O5vBP4eVwakjaRQ2CtzqOka7Tkq3dEhtP6w1TNcCQpXX5IJUL4gf1Kh
 B0l/5/c+l0D67lTt9gWFHer7uHAivodEqZdtRwRWv9Wqw87uCZWcPWSvLWNgFe/C
 s/6Zm2RVb1KP51AE9wtOz5+OJhqz/woxllNTUwpf98T3hX1zsu6ByYTJj+maEb+G
 Wi1XCcU+If/gpxAL3l49lRFFhahy3XZc+wCMMFR+h8jT0vMHc+vvz6C0AEmR6FpA
 Y2sF0Q==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gaphw22k8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:19:05 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-38f57e31b6eso216129a91.1
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787869144; x=1788473944; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=p1tF2BXkL8d3GdBpXJrb6vLO0JrmxMQXVL4plOEG8fw=;
 b=buVGyKplOcQRuqeD4ZqVIs5b3bzsSwDxVENqzY8U7VuZXbPRdlVD0QY3wtJlPiR99h
 ktxV5YOErfLYBHJMp7ponl99DVmyypg7ZkCyKlvl0EFKhld+tgm5sRGxGdH2DluL3+5m
 5PZCSB+n7BpKt3zv8iofFM//Z+pgysTaU3DjMGxSJB21EucZq5fIJKwMLZQP6CI86P4D
 tT6Ysi1AJgWc5tluunF3t8FbFa59SW99TkXvX/8vYpIzsM7gTK6AiPX2YE3CQpm6bQ/i
 bOAevFyvW9ZPAwerlB94DjLTo/psEMWQoAV3jjlWlHGtt25vTiDqcSN/Kl+eB7rwdjuM
 JDnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787869144; x=1788473944;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=p1tF2BXkL8d3GdBpXJrb6vLO0JrmxMQXVL4plOEG8fw=;
 b=qTNieElvcoisuJ3LPKJx7ULHSwTg7GsJIHlohoTSpb7uydehdvp/rsO6S99jzKL+9Z
 +Pea4Tzb3ZBpH871Zbh7w1P39kedz6Ig2k3H9SlxO7g38WwS2gGJzg9bNOHKONW/QxEy
 7rsevVW2JIjWfiDElPy9rbZejxvVDQS21/3V/UYEi5X//xlLrjzgwX9mKNIjJby/5Q9j
 pkHbOEnL3WqQnUqNVpmsqFfIHH9kKwwObMff1lphTKqcca3ldgwMEjJiBqtdgjIPQ3mM
 KxR3YXI5P2mNoGe6j4shKKptm8hT89q6QCXnQi/tFsjNwIdrKTqTgEjP04UPjgfulT0l
 OrHQ==
X-Gm-Message-State: AFuF++lPPP2Asf50QKjL4CNKYLcQaK38drhLygshkuZ6r7D4lQttNmRc
 BI/lk7L+F7okMClJNj1aM493gc9CxDZ2ysJdh+0WsqmTUYWN2QsOsRYheUXTRTFJ5t4DbuewGVK
 NNgEmtsF9hPfnNpWBuf76jLdk+lqBb8ThAXINB87G34Y0qBqOZ750LGGSNv1NjkJakg==
X-Gm-Gg: AR+sD12U3NUQ+Z5QG4YQwSWxNVj7ZT3OfA16sdytTq0AiNonMUWp1CCbA3hvfsbBx+q
 YqsDAC4rCjQR85j2SfUM8zBItbwyigWrnDWL7R+/lJB1qDSn1LplnrPDMN12v+RtFdtJDnGuxP4
 WiZKiHcJzzN6NQD1Y36v8Ed3sx7w+esUFAURfnk0REbgAgiqYor1xcq3KM7zl3TopTxVWGc/QjS
 JoWHXhKZrlSsyImdFrCcZ3rO3Rug8J3QOUZw5phAZM1+Lp9g7j5/6sXdGwmDo9HRd3gqRmAs9JF
 2+TEqOR+y4WVqDIkuLh1WKDhnxd+JFHj2lQIYOOTuXV/lx+Pc6iXUdlj38L7WE9uHM1VbTdF3JS
 jHJWaSWKk166Mb8kLK2FrPUvAvM+7l/Q7fAo7TJDiQEW6ARdS7x8L7qUboHk=
X-Received: by 2002:a17:90b:574b:b0:385:393e:7124 with SMTP id
 98e67ed59e1d1-396d10178d6mr4644326a91.14.1787869144158; 
 Thu, 27 Aug 2026 15:19:04 -0700 (PDT)
X-Received: by 2002:a17:90b:574b:b0:385:393e:7124 with SMTP id
 98e67ed59e1d1-396d10178d6mr4644222a91.14.1787869143736; 
 Thu, 27 Aug 2026 15:19:03 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-396b0fd55a4sm4466925a91.7.2026.08.27.15.19.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:19:02 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Stafford Horne <shorne@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 pierrick.bouvier@oss.qualcomm.com, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Bibo Mao <maobibo@loongson.cn>, Helge Deller <deller@gmx.de>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Song Gao <17746591750@163.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Laurent Vivier <laurent@vivier.eu>, Nicholas Piggin <npiggin@gmail.com>,
 Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PATCH v8 043/105] tests/tcg/aarch64_be: user tests
Date: Thu, 27 Aug 2026 22:14:04 +0000
Message-ID: <20260827221506.91574-44-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: D-P0EVgUYFUin587e-FjZnOmNKtsexqs
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE4OSBTYWx0ZWRfX7PWxom4Tuir1
 i9SCtKB6LVtbD/4ZOwn0ql11Sw2pfzui7zW+qYlkCLVus1i0ycmCwveXgJ5Tr570t4Jfvxfo9z5
 YgNT0yni3/WBWhf/gyqzQtujJFXRTg4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE4OSBTYWx0ZWRfXyV50XapmDRn+
 kFMCcPMOmedGW5x+Zcj0G6K4gNn50HPCqyO00kNtL77C1qIRRWf0Ec5P/GQShIRwZwkhUM4HiJg
 CShsUIXqEpquL+5Js7oD4L2kFDfkoWKH16Bw00bceuES9TPnH995krFWrkHJimv+EdpaM43sf9Q
 gRJ7b1mB5BaLO/4gZWzmfYSKQJo5wDajZv3wgWyUZNnsCfoAIuQwS4mK4D1qU2R1ZDxuQPneZ+4
 BH6AutjmrmQxRlXpVIN4yXludM3EeQTSQwBIyOozvcEksQMDmPB2wyjlVvhhYsmWqC43p1nu9oS
 sUM0t95iZmNHPdXah+b3yZlrcCshwA0wOEFArwO5e3OLFQL9neCdytkNkZtA6uYRn6lz7gypsFM
 KL30Gi6T/I7QuTYooWWu5hM2lKYTeorjAX3DnnK8e9sAD943mpfqQJMD/qpPx4xn62loBm4FVIN
 rOSJjeNHUa7x4TjbMaw==
X-Proofpoint-ORIG-GUID: D-P0EVgUYFUin587e-FjZnOmNKtsexqs
X-Authority-Analysis: v=2.4 cv=E8b9Y6dl c=1 sm=1 tr=0 ts=6a90b7d9 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=VnNF1IyMAAAA:8 a=KKAkSRfTAAAA:8 a=cU6hyqZTfTbaeHUSQJ8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_08,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270189
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/aarch64_be/Makefile.target | 17 -----------------
 tests/tcg/aarch64_be/meson.build     | 22 ++++++++++++++++++++++
 tests/tcg/meson.build                |  1 +
 3 files changed, 23 insertions(+), 17 deletions(-)
 delete mode 100644 tests/tcg/aarch64_be/Makefile.target
 create mode 100644 tests/tcg/aarch64_be/meson.build

diff --git a/tests/tcg/aarch64_be/Makefile.target b/tests/tcg/aarch64_be/Makefile.target
deleted file mode 100644
index cbe5fa0b2db..00000000000
--- a/tests/tcg/aarch64_be/Makefile.target
+++ /dev/null
@@ -1,17 +0,0 @@
-# -*- Mode: makefile -*-
-#
-# A super basic AArch64 BE makefile. As we don't have any big-endian
-# libc available the best we can do is a basic Hello World.
-
-AARCH64BE_SRC=$(SRC_PATH)/tests/tcg/aarch64_be
-VPATH += $(AARCH64BE_SRC)
-
-AARCH64BE_TEST_SRCS=$(notdir $(wildcard $(AARCH64BE_SRC)/*.c))
-AARCH64BE_TESTS=$(AARCH64BE_TEST_SRCS:.c=)
-#MULTIARCH_TESTS = $(MULTIARCH_SRCS:.c=)
-
-# We need to specify big-endian cflags
-CFLAGS +=-mbig-endian -ffreestanding
-LDFLAGS +=-nostdlib
-
-TESTS += $(AARCH64BE_TESTS)
diff --git a/tests/tcg/aarch64_be/meson.build b/tests/tcg/aarch64_be/meson.build
new file mode 100644
index 00000000000..9ea111f9885
--- /dev/null
+++ b/tests/tcg/aarch64_be/meson.build
@@ -0,0 +1,22 @@
+tests = []
+
+# As we don't have any big-endian libc available,
+# the best we can do is a basic Hello World.
+tests += {
+  'hello.c': {'cflags': ['-mbig-endian', '-ffreestanding', '-nostdlib']},
+}
+
+if 'qemu-aarch64_be' in emulators
+  tcg_tests += {
+    'aarch64_be-linux-user': {
+      'cc': 'aarch64-linux-gnu-gcc',
+      'cc_dockerfile': 'debian-all-test-cross',
+      'cc_docker_host_arch': ['aarch64', 'x86_64'],
+      'cc_feat_cflags': cc_feat_cflags,
+      'folder': 'aarch64_be',
+      'gdb_arch': 'aarch64_be',
+      'qemu': emulators['qemu-aarch64_be'],
+      'tests': tests,
+    }
+  }
+endif
diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 76d7dbe045b..d878581b660 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -137,6 +137,7 @@ endforeach
 
 # Now let's go through all architectures
 subdir('aarch64')
+subdir('aarch64_be')
 
 image_targets = {}
 exe_targets = []
-- 
2.43.0


