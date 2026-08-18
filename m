Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6AADC5DF81
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 19:34:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwPY8-0003Qk-MN; Tue, 18 Aug 2026 15:32:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPY2-0003C0-CM
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:32:34 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPY0-0000I1-Lm
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:32:34 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IHIlAv1971884
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:32:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8ZJ6beGopJuhtp2BrCuwv4CRH34ByzTLU4wtxP3A11c=; b=XusgPnSimbjNYgzM
 Xsqhb37udHKogMGHMGriOIXCLJV78t8ujlWL9uY/0h6RYEffsLd57NFXhiweOTKC
 fMowyKwCVPxzP1FvAMK8KoJsgpm4o45xk5Zgsv7/gEp7cNCwIBYTCG0gTljGCO3b
 aw3BXkydUOjYZrcMMh1KvjuvxjYYLVmCgnzHw+rg/pzfDR3xzOO/tDH1LmwT3hPw
 IZRt7mTE4It981je4URsbXDvZQAqIhBiMm2HjhWF5S9fOERDgzYxnYRfahqDg0gc
 w8JTvYtsOR+96xZn20VX+rucNKp+6nsoUF7W5D1GrqGNHgXNLcHx+67x8K66Wqv4
 /iLJhg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4qyx1tdn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:32:31 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-38ecc48b3c2so421463a91.1
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 12:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787081550; x=1787686350; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8ZJ6beGopJuhtp2BrCuwv4CRH34ByzTLU4wtxP3A11c=;
 b=Nj8OPY7bBV9us9TdaTP5qFKvpYdeXqJddJX5JHHH4qyYkABIP6Ki+8uRE4rwhvTAMA
 o3d3zHsEFLlLDFJ68fUPnaqOtZFjADzqTxZ2LxUv45f7PBMCJS0VwUIdEFulS9/kBh81
 4t14T/vNUzWvWmOjjNmNe8u27NUVijETWe4EUhjYr0m7iUCczvzMlluDAQtXFIDCbTOz
 9Q/jUr40bBMg4GgKM/U763NAIcfi01HI9PYeUe6/5VUD3qZAeobOpeB/ECe6fQJIGiiK
 ghyP1RspczwA42pQ+twbi9bKzimT9vqAiYt0X/2lahpPV5IVRXP5prM4kmYpJPiKDGoH
 EQhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787081550; x=1787686350;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8ZJ6beGopJuhtp2BrCuwv4CRH34ByzTLU4wtxP3A11c=;
 b=W+MxTAmWhU430EG+esnIowrYovhdvTLvkhbxlh5SIxYECKLPVU3uU8T02fduiD8Hys
 8D9Rfs+9iQktYg69FM/kOL+ikizEvW92S/EFJT50d7AphEL9SM71ddDPT9ABHt63m3BK
 ysUy3FS381pxdGrgIN7zJ//7hcfkwPaWDCXIQjBE/4u2XDtUGVzASmOzBOdL3RBJSXqK
 /ruVzk+tYXci8wWPWuyhTz/e2W++jhxDaQcnjcQJSpV7mvOR9d1lL9jnnXaEhEIVT3sz
 xegkQgm1g9XdzbgXjRO/VgyVLpDp3YbBPNc2LMjaxmYanxJ2CSL8AX3cW8XxlEpola3W
 Q/iQ==
X-Gm-Message-State: AOJu0YyUOc9sHOwu3F3Rb99SQNa2ZQfGBNoXhr3I7I3CNE+hDBNhz8bv
 xUwXvK/3FCru0d9G4UELSW9zRTS6kdZyqA/IBzHaAVznFlUTrhIbBp6ZV2T5fAV6RGEaRxZrQpj
 +rlKQ0jbp6MiPs5qLE71pp1YmskvDxmmL71Rzr7ZSR/SvbaurPT0+hLhOzt/PZ69Qfw==
X-Gm-Gg: AR+sD11rOSIsUn2LjZskxy+EfowqmxugWuolPFNLLaU+mpwa2N9XpX5Cq/zXgCgywkj
 hPCRp+uEPjIoh7/7ym2/IKoqfBLucOAbcdjAxLLhLawX0r1D9QYX1BSIoARF8t8o4Ca4L5qA5YK
 0zcLa8YbfVAkz58oaw5J4i0U5JWqF28cAbLDisPPQ+5581BdJ3vISRFtzDiuV+BT8mBka6vrMkS
 kdtipEsSdSbq1OAqIuWhPwKG/7aUmQB0WrmlU+jYPMIosq9frCr3zPvz4pGmJOJDj5DNyI0V+NI
 fZnbIyyldJ1bIwOML7yKzS7bge2Ex01WouO+fKUEAIBSDjmoak/EwfEJANP9qIu1kdlGLRIawLz
 0dwAIGmu1h7KSRiCrCD39c+1l5cv0zOC5M4WFV7ksANAld7q/UzgJ56J4XTQ=
X-Received: by 2002:a17:90b:4a0f:b0:38e:bfe:81e9 with SMTP id
 98e67ed59e1d1-3957b331794mr100823a91.1.1787081549647; 
 Tue, 18 Aug 2026 12:32:29 -0700 (PDT)
X-Received: by 2002:a17:90b:4a0f:b0:38e:bfe:81e9 with SMTP id
 98e67ed59e1d1-3957b331794mr100785a91.1.1787081549216; 
 Tue, 18 Aug 2026 12:32:29 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-326798c566asm21877135eec.11.2026.08.18.12.32.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 12:32:28 -0700 (PDT)
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
Subject: [PATCH v7 088/104] tests/tcg/sh4: user tests
Date: Tue, 18 Aug 2026 19:22:52 +0000
Message-ID: <20260818192309.22169-89-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX76B/pt2hmUEo
 97K8JLSm2IJlvauy/fIECGx+2xruTIt/F4dIfrnurFBck3INIntJXyanIRgAI0aauY+uJEGbxXX
 6/c3pseXMT8y8c8gUr1eYs+Tmo4e5vM=
X-Proofpoint-GUID: lobNzpJxr9QgvrvNO54YY1-nMDOGpQhR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX01+XAElkG0U7
 ku86Y23D5VOf7heqdI0zrv+JYPzPaz43dV3DuLFQCk6Q80eM9ncJjq0xO6REH3hU2/E1YhxxdFP
 Wh7Oe/Wyrm65yNxon/ChDQBrpE6zxlkQpgjuzljNILfiZiwQOfDF5fsFziu9pkXPSA9HvXi10W3
 +H02squJ+8MBv0b371RiKrxNAsRGF302MTtRfEnKONczMgsR8FkV8Jg1v5O2wOfSEgPVNBW7klA
 uUlpiNiQvx5ZHA6mqBYPHy/3WJjXISsMChlHbBSm/zg9MDWgTRWnFLp4u+7Yq6U2zGw5RZnE1BH
 qqjt9Rzibl4AY49GFEK4r7BhPimkHMyXyqneQebil4VGCKmtTAldlTawBZFGp/VanpN7bHDXa5R
 8nBVgSvJn2UsNVZ9ngKFZO+FBPWgbT+5Ya2xTRrggxWzGXvEM8JXp9jiuT5d5TETQt4gSzb1ZU8
 jccXxq9+xlCAbA98fgQ==
X-Authority-Analysis: v=2.4 cv=Ad+B2XXG c=1 sm=1 tr=0 ts=6a84b34f cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=VnNF1IyMAAAA:8 a=2nRveiBTxYvp2EUq1skA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: lobNzpJxr9QgvrvNO54YY1-nMDOGpQhR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_03,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0
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
 tests/tcg/meson.build         |  1 +
 tests/tcg/sh4/Makefile.target | 18 ------------------
 tests/tcg/sh4/meson.build     | 25 +++++++++++++++++++++++++
 3 files changed, 26 insertions(+), 18 deletions(-)
 delete mode 100644 tests/tcg/sh4/Makefile.target
 create mode 100644 tests/tcg/sh4/meson.build

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 6bc2829ba92..1c34b8e63c6 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -153,6 +153,7 @@ subdir('ppc64')
 subdir('ppc64le')
 subdir('riscv64')
 subdir('s390x')
+subdir('sh4')
 
 image_targets = {}
 exe_targets = []
diff --git a/tests/tcg/sh4/Makefile.target b/tests/tcg/sh4/Makefile.target
deleted file mode 100644
index b7a8737be0f..00000000000
--- a/tests/tcg/sh4/Makefile.target
+++ /dev/null
@@ -1,18 +0,0 @@
-# -*- Mode: makefile -*-
-#
-# SuperH specific tweaks
-#
-
-VPATH += $(SRC_PATH)/tests/tcg/sh4
-
-test-macl: CFLAGS += -O -g
-TESTS += test-macl
-
-test-macw: CFLAGS += -O -g
-TESTS += test-macw
-
-test-addv: CFLAGS += -O -g
-TESTS += test-addv
-
-test-subv: CFLAGS += -O -g
-TESTS += test-subv
diff --git a/tests/tcg/sh4/meson.build b/tests/tcg/sh4/meson.build
new file mode 100644
index 00000000000..d73df074497
--- /dev/null
+++ b/tests/tcg/sh4/meson.build
@@ -0,0 +1,25 @@
+tests = []
+
+tests += tcg_tests['multiarch-linux-user']['tests']
+
+tests += {
+  'test-addv.c': {},
+  'test-macl.c': {},
+  'test-macw.c': {},
+  'test-subv.c': {},
+}
+
+if 'qemu-sh4' in emulators
+  tcg_tests += {
+    'sh4-linux-user': {
+      'cc': 'sh4-linux-gnu-gcc',
+      'cc_dockerfile': 'debian-all-test-cross',
+      'cc_docker_host_arch': ['aarch64', 'x86_64'],
+      'cc_feat_cflags': cc_feat_cflags,
+      'folder': 'sh4',
+      'gdb_arch': 'sh4',
+      'qemu': emulators['qemu-sh4'],
+      'tests': tests,
+    }
+  }
+endif
-- 
2.43.0


