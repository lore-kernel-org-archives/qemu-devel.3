Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71C8EC54F4C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 04:54:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woZpA-0008CW-P6; Tue, 28 Jul 2026 00:53:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZnv-0005xq-WB
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:52:36 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZnu-0002Wo-8B
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:52:35 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S3ad1r1467233
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:52:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2TBtxI6nRgL0TmSIy8GNaYxkSYPinQu99Yg7xhvszzs=; b=jTpS8tDKNH7OfOue
 T6Mp0kj9rTDZ/s+jbgvIJJKkaq/DfOX89i9FOPuoF/F6O8mirYKyeEgbzVIYQGwt
 pG5AAzqUD9aSeH092O9qFlTD9RbZetUd4Xqt6e1tsDFqfDgoI/NGLRP4e7ynKsne
 U8b+UWvWEIwEcmhxDPcB5/0hT9GTKSkUwmItdn1KySJCawl55fN02XFr7/8/WZ5s
 3OJ4cDFtMSt259SQ/HHQBVy8gEuh9oZD0md5sBcp/lh5X6k9nYkxcbJa2fGJTLBq
 Z+Gn32W7vh3FW4vPEItG97oYU/NATXnPeGo4vP6nmw8+GMPBu3MGhuMVmP9Ytimw
 8E+1bA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fp4nbvhtv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:52:32 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cb835525b13so3893093a12.1
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 21:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785214352; x=1785819152; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2TBtxI6nRgL0TmSIy8GNaYxkSYPinQu99Yg7xhvszzs=;
 b=NycN5dQnohi4uJnXv3QRyqTkQsm5iWDOhHtVv38B8XQuzQvJQCIbH4wnZrOPXQ5BI+
 5GJIVBhD5rSlOOnC28IMF2fFYIwEdCsXDWMQgmeX57wOHZtJfnEIn9QUEN3ViYQ0dduD
 N8pPBvqHhh/eW+O9YtOHoMrA5LiJ0NE+r2xUo6OzMrlxlgxV3rbp4bRFsoTyUwKHLvT5
 +JMjctTqdztxvw5wP9I0sswnuDF+6gb2Sd15bL8YPgybXvJEU6s7si70DzhK1iPwydg6
 odqyd1eq2WMPW+8Al1FdU4LDhdBGo142/JUO70tr0RTUaQZwnDASab5e7MDB5lg8W49I
 mO/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785214352; x=1785819152;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2TBtxI6nRgL0TmSIy8GNaYxkSYPinQu99Yg7xhvszzs=;
 b=ipcvqmruieUSeuPKd+Hz9bGG4ELjqgRng52VzMu8QZhCyxgTidmsZUDVy/Y77Kqgjz
 FyU2w4c+7xTl8ER1qCfMDirpzbi6OniRf9MjKTwZGk3qVqCl6LxppYkFprBeOKVCSHYv
 CorferDaBH97hxemXwSeNC0nVOgQZ3MgCLYxVdaLN9kW7fBv8A5OJ1GevhnZN8FMfGuq
 LIJ7CuXXkNHy0icmNBjCUSRFb7uA4ucAczTw5CtmptMdTyjmHvRGGt46jFQhrrsnZ4LL
 RhH44nFp+lEcmAbPyuGzwHhVWFmIsxa6n3gRlVILW80fLk0Rleks2Tq+kOHghBUvxYM7
 GHvg==
X-Gm-Message-State: AOJu0YzFbHFcpkKwLWXZvQcTpp9P69g82/Pfc3SRqWR4MrxqYn/+maxP
 lAkgmdSX7OC11FMxWiHMHHfat6hA2hzQM3h0KaQD2veytS3DFJ8taXIhExeyCu2KDnB+8j8ayKJ
 Z+8b4Vlv8NEZ7+Ha/A4mn9OC58maenuEURakRjYYDHqTiVOKpVW8YW+ScE7hZ0DkHFQ==
X-Gm-Gg: AR+sD12PCqAusmGhbMsUQx8zSwpzPZMUOwWsjmudPRTA4iNEATBjJ4LqJQF+0GmEz51
 60wTtIZZCoFxFciMCoq1xnMN4FEwOvqHzxhBvuuXNv1rKKlrRPb2LJ0H8EkfQSFgWwa6gUaV7DP
 Jnoof1m9dqqJggZityns45ZwydqbHtAVkIkTeee5bu+OQDW7alUJaaQKKMvGXBp7GgRh9sDbiNb
 8DvbNwRuLV1Bz8YsntsjBsQmorq/ZAm06maJNn1zFTnflDKFou8X7ni3S/fDZmsaubbdHHaVzVG
 z8YQYM3okigKmWoicZk6FFWHGuCRAivg1D91oqj4Fi3gmc60V8qasntY96SnGMzqHyNdkI4wWuS
 loSsup2FI7AK/8w3LBBAfoT55U2XWIHRMr7Adu0cA1+c6MMMckIm0X/Lyk2xzLFZSCs9lcL0=
X-Received: by 2002:a05:6300:670e:b0:3c3:875d:c546 with SMTP id
 adf61e73a8af0-3c8aafa3cb3mr1066527637.7.1785214352198; 
 Mon, 27 Jul 2026 21:52:32 -0700 (PDT)
X-Received: by 2002:a05:6300:670e:b0:3c3:875d:c546 with SMTP id
 adf61e73a8af0-3c8aafa3cb3mr1066498637.7.1785214351797; 
 Mon, 27 Jul 2026 21:52:31 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-314bc3e878esm38900559eec.3.2026.07.27.21.52.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 21:52:31 -0700 (PDT)
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
Subject: [PATCH v6 087/103] tests/tcg/sh4: user tests
Date: Mon, 27 Jul 2026 21:42:31 -0700
Message-ID: <20260728044248.137626-88-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: vjaByuRi--6IGuYaqSoc4aWEMOl53vaO
X-Authority-Analysis: v=2.4 cv=cJjQdFeN c=1 sm=1 tr=0 ts=6a683590 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=oeoYDfJPrL2azRNJ8Y4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA0MiBTYWx0ZWRfX4qjpH8oCitQ+
 yfiZ7rOUg3c/WiHQrLClOKe169r3pePfnhNNnYId9HV6XKKufBjYcxLZhi2ExNnEpX6vgkJmgvw
 9BiSMmJkn7H3tqMGORWvylaoGe24vkw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA0MiBTYWx0ZWRfX0VzkxL5yhg1d
 7Gyj/EanIHMZYlfvawqlylQdjxt4BlKDGAaVDKCHkZ+qd8eBUb/1ZEedVtAuDzX+fNVZ9vNUgRi
 ijA0B+oX3pDb5ZFEuiArJ4tLFE13CB2KHnHj7P7BQVe23Fiq2NwzH67pVLrzwAnS2K6Ygeg6pCz
 WQnTERXdGlz6rd/ygepEZ2wHxm08wB4arBxYuKy/WnYpr+loKa2BnPI/GTZZB0PwaPAVdmBNEvq
 zFTDH1l20udBXIFQaz26HCJmjG+Mp8oh9Iq22k+tBg04Y4geWXENipzf0Z5xXwAre1r93/KsSNa
 W5jRJD7oT8sd6vTqA/MV9K61PSwouf2t/5UkFfJ6RTPzOXSMCciJYkCQ3OE6/EoL8P2iOAqEgj4
 n/CjQf9DBio9gi+si4yFPGqiWSPz6oCvW9Cdx3r8JhXxaUMrRaN9qepgkw0Ypr8BAQBk+NPqDIo
 fZITG1pO3zf1hCcPERw==
X-Proofpoint-GUID: vjaByuRi--6IGuYaqSoc4aWEMOl53vaO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_01,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 spamscore=0 adultscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607280042
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build         |  1 +
 tests/tcg/sh4/Makefile.target | 18 ------------------
 tests/tcg/sh4/meson.build     | 25 +++++++++++++++++++++++++
 3 files changed, 26 insertions(+), 18 deletions(-)
 delete mode 100644 tests/tcg/sh4/Makefile.target
 create mode 100644 tests/tcg/sh4/meson.build

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 16fab0e2c61..5a132d9021e 100644
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
2.47.3


