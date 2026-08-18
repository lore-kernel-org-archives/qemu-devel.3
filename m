Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF3E1C5DF85
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 19:28:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwPU4-0006UA-Kt; Tue, 18 Aug 2026 15:28:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPU3-0006P0-G1
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:28:27 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPU1-0007Xr-QT
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:28:27 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IIaaWw1940450
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:28:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 r0biU8F4qmcwBuL7Wy3Q32DrwQ2FLV40qJgobHvGsRY=; b=U3zzpbYWF5qAwA2f
 6FpgQXsycGgGPDRaujFozUuG3wrE5F2tD2/fLNX7pu2XIw95ej+YLPB0wd+UOicv
 +mkBJOLXKPbhkluQh/KdnbDvKo+YWzucTCGZMf9ujoOlFv7oDB7cSUmfBnudo/44
 5syqq04T68pIi2epFPi3JHMbeDkoosyZsiHYmFO3hxRScTkZNCcOPuTpACXPXiUo
 dg9zY4OiaKD9F0pryeSxyb12yMarRraS8vN0aJz6e0+BjYj6AvXN4WWXZOPizD1/
 IlLAT5Wtc6wUmyW52xHFwXT8+oqPVEJyzNWEJR9PjzTF77pC1BvOCdYXo0x2J0Kc
 0usi4w==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4vtu065n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:28:24 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-38dc085b0a7so476826a91.2
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 12:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787081304; x=1787686104; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=r0biU8F4qmcwBuL7Wy3Q32DrwQ2FLV40qJgobHvGsRY=;
 b=jewo1lPRys4NxgHbJB8l84BB/OwOY2gbm6z2N0uVkiXOxyURkWnK3diM0gd7XULOla
 Q9MXfy0I0rTw4R6bSOIyDQVqfjJ24BgM/0NVmC6+0VYaet4RNN2Ljw5Ko55l7furdAZx
 hitqgZLMICneUsmNGT7+HmGeXnE/HMc5/NIMySyc1fWODCav/BThUA+lMquut4akMDEL
 M3/nR4XX7k1CFeDNBGnbixBC5OgF+R3LVH2sAMUu9e4kaAA59nKCeL1of1MD0ytBBcRt
 xcN0ztuSfdHW4Y7V8W+P76YPmzFqF2Xuq2iDFmwXURllI4MsgEjULOvkRvInsRQH/srq
 2G2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787081304; x=1787686104;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=r0biU8F4qmcwBuL7Wy3Q32DrwQ2FLV40qJgobHvGsRY=;
 b=DEb8imzMY2NIaNB9nDAtm3a6TfXODHNgMy6wPKOnzIEkJeg5tk2dM8jEekE09z/LRI
 DVtbxsMzdfdggfJone3HS78fxPWhqeMSG2Btxt0tDujkYRsLhdt/bAuZEe41GsliaaZr
 /U09jujsT2E8Gp9vt5M/ntEeQVNBBWfrdro69jlEGLm2NkOh55HmABuU5rvaWbqSWUsF
 jvsJKpdBdTm0wLbR20GxbOgIZrYkrC3OLTlNfWdk3p9ov30nt+jVTo6jkOhlf8w6i1gI
 l/DP972reHMtxDqoD3aEVgzhSwGJB4d0LDpZrTT0sTHXblXiO2kgayjxyOxC4EJPq7JH
 BKLg==
X-Gm-Message-State: AOJu0Yz7UVWcmUhUcIvzeqM2kt7vTU6zZdG23Y/UsN4xQIJat4ZORVQV
 TVJrJUNfTm4L2y7Nhx9aPXq2O0iuAoPP0EmeC8MQpChrJJ9bP1l3Nr+D847Wn9c3QLEqPymh9e3
 /O6umZJmDSBItnz8XEMA8SQ/brh9pxnPghmtxyzUPDD2EAYMn1kJQ1EUxORxU3htoyQ==
X-Gm-Gg: AR+sD11uKHMJm711JyqLw5Pw9DK1usk+6g89qZFI1L4SEJdCKiEBEOuO108lUz8DQYK
 1lpBArzFiTGvrRqypeQkwmrWBvKtNgwcegVm9k/ci3Z6oslKL8pR7X82VFnun4fSXf9NFofJxyo
 Sq6mgrYHiVvbAhHLhvx8e014a4DvABtO1R7brAF4JxAgxNaxOtcSGUmfal9eoQLVZdhV8bRxJQ5
 pche2pAhwFnioRwZFK407lFLjBQ428YMcQ1YhpaK9m2gKZRpLaa9KmtM7znEKfancSHdQLJvmCV
 IuXpHkV+ToSnSBYM2L8XWNiQQ+SVQyCBni6r7jcOTUWlZDjvzDySjFvV+l/8/qHje/RBDHz5tKj
 oNmKPN1OqcfW6/2guhWwru0H4u5krP0VuW71yNtS+zRqYqAfBhVGKGD4NqHE=
X-Received: by 2002:a17:90b:50c5:b0:38e:ad9d:1161 with SMTP id
 98e67ed59e1d1-3957af1f231mr307555a91.0.1787081303565; 
 Tue, 18 Aug 2026 12:28:23 -0700 (PDT)
X-Received: by 2002:a17:90b:50c5:b0:38e:ad9d:1161 with SMTP id
 98e67ed59e1d1-3957af1f231mr307475a91.0.1787081303112; 
 Tue, 18 Aug 2026 12:28:23 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-326794c0c94sm36782451eec.9.2026.08.18.12.28.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 12:28:20 -0700 (PDT)
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
Subject: [PATCH v7 063/104] test/tcg/mips: user tests
Date: Tue, 18 Aug 2026 19:22:27 +0000
Message-ID: <20260818192309.22169-64-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: kZIdNwWBG5oWAuJs1fmYld2pdCAEImcJ
X-Proofpoint-GUID: kZIdNwWBG5oWAuJs1fmYld2pdCAEImcJ
X-Authority-Analysis: v=2.4 cv=FeYHAp+6 c=1 sm=1 tr=0 ts=6a84b258 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=VnNF1IyMAAAA:8 a=stLDFHwS15Zl94BXwzUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX6aEuqzoyFsUS
 D/Wfhc48k5skqzYh2OYzgROfvDJ3InRiEaMPNBsnhL2WpFTjrQzXukQCyRZ1Y7Zs5ETxA8/4KuD
 h8nOCwYRyisaYrm9hlXTRL7Gw/84XBjwntCJtk/p3LzbMNKWr1iWgo9TvBv2djCEwr+IKLjLRuS
 dyXD7naU9bbH3DMGkLCoyCIq/jOc9kc8bh92jsYdcxxVUKxKWxUwShbAPpuRozWu2nqgJi/+Kjc
 /da11c4QMLw0zdSVoJMZOUjpg5ROWi+kPZ+LnU1G5tR/p8JSQkaNaelIflnG5Q+zuOx27pW4gRo
 rKTPTIof7P7FwWXS1ouI1PmsRYrlnGYWpQnBNBVOUuMSU0ta4veQxMVDzzD19HKOfV8YHaz4lqK
 KjJ/5rCsgidNa5LGVBAWV2Ou7ZFisJmKCcdJbJBqSwns2G7f4nQxxyAvic0XwW3OmuoJglG/ZJ8
 xUkmklXT1NSgbsI802w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfXxgc7VlrQuXyG
 Fak1xYyjRnNMk+debsHjuyh8vABFc8wU/06tp4MIuzDRI68r+FTI9WvArV4aRLD40kKAOqmI4hf
 VUgZhvxswbvalYq9Ne0ejpuvEYcGvds=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_03,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180142
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build          |  1 +
 tests/tcg/mips/Makefile.target | 19 -------------------
 tests/tcg/mips/meson.build     | 25 +++++++++++++++++++++++++
 3 files changed, 26 insertions(+), 19 deletions(-)
 delete mode 100644 tests/tcg/mips/Makefile.target
 create mode 100644 tests/tcg/mips/meson.build

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index dc83b7447bf..3d7438245dc 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -145,6 +145,7 @@ subdir('hppa')
 subdir('i386')
 subdir('loongarch64')
 subdir('m68k')
+subdir('mips')
 
 image_targets = {}
 exe_targets = []
diff --git a/tests/tcg/mips/Makefile.target b/tests/tcg/mips/Makefile.target
deleted file mode 100644
index 5d17c1706e4..00000000000
--- a/tests/tcg/mips/Makefile.target
+++ /dev/null
@@ -1,19 +0,0 @@
-# -*- Mode: makefile -*-
-#
-# MIPS - included from tests/tcg/Makefile.target
-#
-
-MIPS_SRC=$(SRC_PATH)/tests/tcg/mips
-
-# Set search path for all sources
-VPATH 		+= $(MIPS_SRC)
-
-# hello-mips is 32 bit only
-ifeq ($(findstring 64,$(TARGET_NAME)),)
-MIPS_TESTS=hello-mips
-
-TESTS += $(MIPS_TESTS)
-
-hello-mips: CFLAGS+=-mno-abicalls -fno-PIC -fno-stack-protector -mabi=32
-hello-mips: LDFLAGS+=-nostdlib
-endif
diff --git a/tests/tcg/mips/meson.build b/tests/tcg/mips/meson.build
new file mode 100644
index 00000000000..3c4f6ec482d
--- /dev/null
+++ b/tests/tcg/mips/meson.build
@@ -0,0 +1,25 @@
+tests = []
+
+tests += tcg_tests['multiarch-linux-user']['tests']
+
+tests += {
+  'hello-mips.c': {
+    'cflags': ['-mno-abicalls', '-fno-PIC', '-fno-stack-protector', '-mabi=32',
+               '-nostdlib']
+  }
+}
+
+if 'qemu-mips' in emulators
+  tcg_tests += {
+    'mips-linux-user': {
+      'cc': 'mips-linux-gnu-gcc',
+      'cc_dockerfile': 'debian-all-test-cross',
+      'cc_docker_host_arch': ['aarch64', 'x86_64'],
+      'cc_feat_cflags': cc_feat_cflags,
+      'folder': 'mips',
+      'gdb_arch': 'mips',
+      'qemu': emulators['qemu-mips'],
+      'tests': tests,
+    }
+  }
+endif
-- 
2.43.0


