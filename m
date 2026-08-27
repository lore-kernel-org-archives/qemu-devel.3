Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 553DCC61DCD
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:19:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziRi-0003q1-8Y; Thu, 27 Aug 2026 18:19:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziRc-0003DO-Oo
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:19:36 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziRa-0007D0-GG
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:19:36 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJLp2j3848242
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:19:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=DQFHNic8spI
 vrmtK3rav7cniBYL2dwCI/53LhaogpS4=; b=SemlP+fGDn+0fd9K3KpyenN/3Jj
 nNUfp7pgjPvz0fIwOY5DdSabWb96AX+VE0kFf3jh37WqrSNPRGDqtNAEhpelDPAo
 8OGbuavJOD7PQz0rqlNU/RC83QVGyy806RzaUl2SvvbG21/jndQMqXREZE9zsxtZ
 xRN1Wofbvz3IVhpp+zJxmTCS/9MQBRir77qC6aQiCwj2Ylv0OyNcF8cF5MQx0diR
 xPTfYgmFHEuYckZ4CPEUH3I/nJ4ym35EZ/etxrck8MuCZqVg43NCE3DvEbOeYrDW
 F2iwoJvgLd38KjstdN4dgsVY6H31oWVuuhdCjEe4n/LWgnHEUbhSPnTQmSQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gatnc0u9g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:19:32 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-395543dc382so563485a91.0
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787869172; x=1788473972; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DQFHNic8spIvrmtK3rav7cniBYL2dwCI/53LhaogpS4=;
 b=P9uSXmsvr6gSEtbfMuICw0Je/Jn16yfoZJFFDo+9FM3OC/pCu/nnes6cf1+i6g8Ujm
 J/dygfUJscbiRTg6xWB/MCIbVNKSMTq1gPmka/74uxGyZttzzmjC/D37B8NW0nmkLwXn
 ZwkSYaSGeWXM4gmXA4rTX3HnNzrH6abelrEkeDw0g3z6MdCf1Cz+4q65Dz4EpvqaPXxQ
 fyURE1juISwTEdK+mkkx11sV9VzpiA1dTuRVn/ff6XYNtQIIILvFnXlX4kkpWOwvSHuD
 NlHSao88qrZmaZIDxjtXI2JYm46pYzQEd5a/YckH70t8ohDfpyVNx2YZcMU4bWr1pHal
 qiSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787869172; x=1788473972;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=DQFHNic8spIvrmtK3rav7cniBYL2dwCI/53LhaogpS4=;
 b=IirU600NTYCZ/MSGw57HWboq4g9rgjIVoda0WJsVC+7nWTCrk8ZnCN822Q9pbufFzM
 UHqpIjUjgAWYVCAV2D/uo4rMgi4UgBUzC8fRnvF85B5/YXpagraznqJK4poK6epaiX30
 uT13hEtJYbIavDPsCprFYNc3pYaXojFkJe24cNVZvVfaTHvuP6ZLF5HTnK4SBU7tu4Sd
 Uy35N6z+ps/DM4O79lwGXHMl7G6ccsIhkB6l9bT5rwLw9meWewcW2Kd67A2xjU+DPEZV
 eL0avHaf1+8Sf9YfTETNSEuaAI72RePW0ZNY4rWZWWZ4pZ2hLBoNLYO6QmKMY34exEWz
 UNvA==
X-Gm-Message-State: AFuF++nwDZY84KgjplIS+n2B4b6uMmrOapYh2bpldd0Y5oQynZHSJnH/
 zrtjKAFDyWLhl/Sug4HjfXRPM8cn0L3IfA1p0Tx+b+Kkl0ksW1q8I12TrFWK+w6i33B0+OgFUv3
 lHWUFT/LSkpUc4iCgeOh9LBoGD5+ysty2nM2yIHdRauqupMWyH72CnjG/gLfX2wD8ow==
X-Gm-Gg: AR+sD10V4te4KdaVWbdy+hCCNC23ZQsZMvlYcblE4XjuNEHCteu9VdjVQn8lT9lTWTf
 qZrzHs6OIoes0ccsPoH7s4+wnoMwaf9OcZTDDwvbOGJY+MykZ8wQmZ4U/23TbiOEsCu8vfuGZLh
 wynvFrA2Hps0ps6XZwvKUGE+NPNEcgqdViKB+nm1MEQAJ7GyUehzLVsRaneHEKOr1ydBIKcopit
 l/F5YLZK5L+FSALsZ/6BOvAtPHUnguKPsYg+2mJ8+6XNxC57goZr2EJj6YF3kAQ4SrukVUQ5asB
 mzldXCXF++tLANK7LO7EsBu05GY7N/Zgm2A8iz3czL9Z2LPtKh2+7CYPhjrL4pibZMWjXW79BU0
 y1dU9itJsI2s4qhSVzhcozq5MuQJQVANBbbJHsTstbx8dMo9yUfONBD9Yt3Y=
X-Received: by 2002:a17:90b:1fcc:b0:395:4e0d:bc60 with SMTP id
 98e67ed59e1d1-396d0f6efc0mr4437141a91.9.1787869172164; 
 Thu, 27 Aug 2026 15:19:32 -0700 (PDT)
X-Received: by 2002:a17:90b:1fcc:b0:395:4e0d:bc60 with SMTP id
 98e67ed59e1d1-396d0f6efc0mr4437038a91.9.1787869171628; 
 Thu, 27 Aug 2026 15:19:31 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-396b0fd55a4sm4466925a91.7.2026.08.27.15.19.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:19:31 -0700 (PDT)
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
Subject: [PATCH v8 058/105] tests/tcg/loongarch64: system tests
Date: Thu, 27 Aug 2026 22:14:19 +0000
Message-ID: <20260827221506.91574-59-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE4OSBTYWx0ZWRfX3xD42TFeptko
 l77dYHl+oz/Zy0r6hnT6y3CHibxk2QaYplxs0+PwVAVUfrv/pjA3rNhobi/Js2DqwiONJUxViXv
 gxex0FohJZbd147AJGxjnle0+xW+UXnOQsWOSNBGQEWj2mt3Q0d+SONr2ryow2Gcm5DrgFhmBkJ
 lL6lcVdF2CweKEiXmSh9sjdrqadNuOF8OW7jj8hatxgkercxb6SfpFh5ZET2Bpn0DAOE+x6WHS+
 e85Wh5f+aN+Lvyafxg6ZXiLNPjivbz49eAt8MEavKVTXaZoPvo3rCMiVZ+U6OHcLgBa58wdi54l
 UOl6UkDmykG8yiGWoozNAcsNT4Wfg0D9zjYsJOySHafYCJufeAlwk3gGKrCjjX43CikFz547XoT
 kcVxvPGAYBNVTZjhXBD8HCxrCud51/zgtjrWqzZYXUway3s/ksI1slUjxKrabjyovvHYmbgt9gb
 S6BNw0kBaCxxRvNKUZw==
X-Proofpoint-ORIG-GUID: KenIhVjetiryByabrxV808p0zgHUe1Dj
X-Authority-Analysis: v=2.4 cv=HfUkiCE8 c=1 sm=1 tr=0 ts=6a90b7f5 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VnNF1IyMAAAA:8
 a=Byx-y9mGAAAA:8 a=EUspDBNiAAAA:8 a=FVW9kWhLySRIolcT2UUA:9
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE4OSBTYWx0ZWRfXybNMku6JZuPT
 crholBbI6IZmAwHzJLIxYJTDStM9k0miLwHRG1RUUMfl2XcqJr62aV2xQ2JJKTiXU16e+xGDvO/
 uPNexmCrFpKa+TF0FumMk9Zc30x8uIQ=
X-Proofpoint-GUID: KenIhVjetiryByabrxV808p0zgHUe1Dj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_08,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 suspectscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270189
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

Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Reviewed-by: Song Gao <17746591750@163.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/loongarch64/Makefile.softmmu-target | 33 -------------
 tests/tcg/loongarch64/meson.build             |  2 +
 tests/tcg/loongarch64/system/meson.build      | 48 +++++++++++++++++++
 3 files changed, 50 insertions(+), 33 deletions(-)
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
index 00000000000..5bf4c56e385
--- /dev/null
+++ b/tests/tcg/loongarch64/system/meson.build
@@ -0,0 +1,48 @@
+tests = []
+
+minilib_dir = meson.current_source_dir() / '..' / '..' / 'minilib'
+minilib_printf = files(minilib_dir / 'printf.c')[0]
+link_script = files('kernel.ld')[0]
+boot = files('boot.S')[0]
+cflags = ['-nostdlib',
+          '-ffreestanding',
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
2.43.0


