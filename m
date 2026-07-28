Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36B77C54F51
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 04:51:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woZlM-0004HQ-Rh; Tue, 28 Jul 2026 00:49:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZje-0002L9-TI
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:48:10 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZjc-00027r-Vc
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:48:10 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S46W8e1821206
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:48:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 QKeQxWPWaN/sdg84Ma3dXRdOpC0y3lIUvqCUOahoQVI=; b=h2BpWpCISSrTnyD9
 kTvwAlvbcWOlOHuRCfa4eEdq+t6Y/6iGEau/w+Q5VFUJHoNHTd0VNMsMR+IqPWpb
 hjl/hW2LlByfo/jFXKb22S/VzYrwJOmOGVA442uZJmoRfakZ5FjeVQToY/0i6wEV
 9uttMrXrcVZQBLHGzTgOpL/5zpeZb8MyXzl6W6cCmfhRLawvNi5bTSNvVwe6+pdb
 8/8VyPK3UpN4ogXuosBoeRhy59Wo5Nq1T6gV6lpoBCGY8FwMC0/Lz5oyfECpTIQR
 GxdaJTttVuF2kpS73yNLvxZSOnc6fnqX/Xpv32xCWvNPbspOPQwx5tACT2jF0NNB
 JmEdOA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpn3y03xj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:48:07 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cb7d6ba548eso4325639a12.1
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 21:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785214087; x=1785818887; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=QKeQxWPWaN/sdg84Ma3dXRdOpC0y3lIUvqCUOahoQVI=;
 b=YZDAZdQmEfLir+rUT2eP/WU9xalkyPqbaxfwKPNsX2insSnpNxgfM5HWdqxISLVSWo
 1gljGtC7te15UUisv+yUVEyy2EvUrwmN64b0FZEZ35wM7fTh9cD9J0HDJhj/PKwo/iYw
 k5/5hYT2DbuDG9FxMaEZbLON3YV++RIVTJ1dRKlhs7W6j5BdltatAxlzocFH6r5oqcW8
 RLXiJnR/84Wy6TnCym5whWbaic80zrJf7IXPaySTTOjCd1mI7YlCS+3R3EJG1E6/5JIS
 H7EV9mG0/Ck0B1sRQkQv9FrvK/jg9tW6fMTb80ypGdmm/3xB+IkDRgCM05pIsjLGF0s6
 jRaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785214087; x=1785818887;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QKeQxWPWaN/sdg84Ma3dXRdOpC0y3lIUvqCUOahoQVI=;
 b=bogz3t1ig+odcZbuy4q8yW5yZ5kLZ5wechixoJMcQmXfx9gVUxmKVfjb+Iw371jBZF
 gi9Njl4Qp/hFWlck1jqJPdtce6qjDi7wAokFWxXjpmgzy1xdIG90eKohXSp56df2GA/8
 OLVfTXqz5bt7ALcIsmHJgpuU2FTY5scYVg8Eiyf/Ztx9J2BCIllv2TDf8rX92E3GsB2a
 WQoX75vGWOi754/n3RrvzH6itjcTynzLe0LQ4+JN9E3tnD/6HofuCFsml3CQYu5aJ/Xc
 zj8z+O7c9GUPEzVSFpbbfKeLKlzxNAH9vqnMIOhW6mk3iIEFnHG3VffbdWCTSf8n9GV5
 7qzQ==
X-Gm-Message-State: AOJu0Yx2xKpX9EzLpGKzhziHMjQOyH27HHzf5Cc3lG5FgSR1/kkx1b6T
 IjUEeFktYTm/ljAHvJSW3DD4is5HmUKDej8hwhqObURTmYJfuUcoEpQ/JSi1n9DTH6VbOMgYlFb
 0OFzal8dhLy3MNUNPdwMIvxRePtksgtUW115FXEca30hostN2yY6xT40pL5ogiDkDYw==
X-Gm-Gg: AR+sD11Cb1ObOwY2sxLoBfVsoqu2Pds3mdhXRhZy2a1Qro0emUcPyqWeSVLLICmP2iL
 Et57woKF9eSXH67XDjfvopPq2D+vOxZJsbFSq3JEhXh8/0ZunLnjDID3jS/tVSrAIGrA0Zk1IfR
 2hMfcNJEaN91DoCkVIVv0Y6Tbz2RwddBc1rYl8mOXsGaSWIUYeu5ND/V/PoCsXOEsEJCdnisQFL
 /F4bc88PTs43bxc/cLCj28kx9P+CDjhy2RDyL6dc/DfKfYWk9I8uWFkdI8x/Wki/gBL2CgTjfJ2
 Dylnpi2DAWuLTmEX9jZQOAWwg/EIEbx7XACu3k5ciSI9T75Ong9UX8JTiZQax8K3sbS8Dvh3hUp
 8G0msDwHnQRwTUQgD5BKbeO4hBEV0SDhsHhtoST66nUtot+3yDkzlPZ9iZ1+DSQJ9UIhZaWY=
X-Received: by 2002:a05:6a21:398b:b0:3bf:a0e5:99a0 with SMTP id
 adf61e73a8af0-3c8ba5bab9emr1015963637.47.1785214087015; 
 Mon, 27 Jul 2026 21:48:07 -0700 (PDT)
X-Received: by 2002:a05:6a21:398b:b0:3bf:a0e5:99a0 with SMTP id
 adf61e73a8af0-3c8ba5bab9emr1015925637.47.1785214086624; 
 Mon, 27 Jul 2026 21:48:06 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13d13003f12sm103090113c88.2.2026.07.27.21.48.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 21:48:06 -0700 (PDT)
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
Subject: [PATCH v6 062/103] test/tcg/mips: user tests
Date: Mon, 27 Jul 2026 21:42:06 -0700
Message-ID: <20260728044248.137626-63-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=fbidDUQF c=1 sm=1 tr=0 ts=6a683487 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=stLDFHwS15Zl94BXwzUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA0MSBTYWx0ZWRfX3FP/z5up4yLD
 2kfW6de4tZrCUSioxAAtlruVPHpAr/nHMGe86fnN/sdNIJNCNZglEj3cQf5zZeGKdBvoIaVuSsI
 63i71qusLYiKgRvXDSrPGHh8vhSzI1E=
X-Proofpoint-ORIG-GUID: DMt30k1oIG6tWIWaTmbPbVmWo9v3qcXC
X-Proofpoint-GUID: DMt30k1oIG6tWIWaTmbPbVmWo9v3qcXC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA0MSBTYWx0ZWRfX3uOh8CZzhVYv
 rUbxtOMea5lmAq6TvJQFYHLeOLzaIlCStgrExKn0KAohGNZzspTJtwLPPi0C+LLABbyldiMRbnJ
 og21Px5VZxIZGgTmCFkqBfo8EOzg+M5guwdNY8hAx/hcegd76q5P2NgGa2PjXoylZbRbEmugViN
 9e9pLxDT96Vqxj2t3p0sCixPQCyXk8ri7AtfOxlOaBSokEF4bCguYtnXaehMwHDvh+YS0ogjmu0
 6T29HCl37iEOhZUnzEvXfKQrCYIEvbXMpGh4MXR1gWo15G04RiqvQR/ao4IANXDmn/ymJnE7pEv
 a6rsTbS2LecQ5FhlmRyTQB2f8n4eVNh07CmpB4q2HFnqIb4o5Or52UwDigXrvMQz2HNfzbldvjv
 RhLTVzY2j6aQJCB6VvaV8Gjfu8nuNFXnmk/Zk+ZmiX7DaYtwmJJT9kVYcegNE6mbWMLwQWa3Zxr
 MoIAznXZnWaiQoeLjYQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_01,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build          |  1 +
 tests/tcg/mips/Makefile.target | 19 -------------------
 tests/tcg/mips/meson.build     | 25 +++++++++++++++++++++++++
 3 files changed, 26 insertions(+), 19 deletions(-)
 delete mode 100644 tests/tcg/mips/Makefile.target
 create mode 100644 tests/tcg/mips/meson.build

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 10c7b21e308..57532e2faa6 100644
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
2.47.3


