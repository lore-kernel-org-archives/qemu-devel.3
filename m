Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9960C61DB9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:21:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziSN-00078K-SY; Thu, 27 Aug 2026 18:20:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziS0-0004fW-B4
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:20:00 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziRx-0007Mj-V8
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:19:59 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJMEXD1803864
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:19:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 MCllqz1NEssJ+ohs5qNFpMchp7v26zFsVCg5Om93BOU=; b=XCzZMuDX8+g6+na/
 J9kuMyKZbABuUnqbXs8Epcp4GSqftR/bb5UT20DHiRiTlDIwTJwo/Bc3oMHP5AM6
 INjUZ3SAO/Igrabk+YmNBETafPuDFycUXcIPdmbbDZ+KKnupLf9WVLr4eO63eSqV
 GwkgTYhUdDs86WjTHjVMTYYKs++OpiIWVFf8H8SfZ1kqdJaQ88oM4fki45uOyU6D
 FifXbz0FMHgJxhmLfDfM1FhuGMZahxNMenA9HqB4Pn6CscTWQ/SIQL0dfrQoC6Or
 Y9txu8CFwsfHuiQ4mm7jxvgsxdQaTQD++tYCEPLBaTRwNFNAGcrJkjyXWzjm8OaI
 b/6IZg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gatfxgvjn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:19:55 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-388cfc4848dso453177a91.3
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787869195; x=1788473995; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=MCllqz1NEssJ+ohs5qNFpMchp7v26zFsVCg5Om93BOU=;
 b=hMDzc0ZYZ+L6KYGC28BgMxDf68HD41MT3IyG46HntAja1AUz6AL2KcgdtppHsQ3sPU
 HRihbe5jas8jSITCriYUEoIVz5apvdY3OV8RT3cUv/BoZKgN5RFjo3BKYEi07yPKfTbs
 8LgObeQlpc8i4LZSFU6hdK6rXxz9q6DJnhSKCYiccG+u4LO2R+MmBXfg8q9oG+YWSto4
 PNOVmqN1LTJyHRdR3Jfhbq0D9C/y1fi/kdC5pmhfc7SdIHyxYBEBNjOkq8mCYcrTxz27
 8pq3YNWtFKITuPY9pTFpbFKmDJicmeuasMsidQ8mJdsRZ/i4kLQbriYqZIjNon68EWSB
 D6vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787869195; x=1788473995;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MCllqz1NEssJ+ohs5qNFpMchp7v26zFsVCg5Om93BOU=;
 b=avnFzAzL7gr48VZaYBvg7qMcr9VomCC8tj0y+6Af3T9DGls9ikw6kURNx/EBnW8Y0a
 KgSDW9KdOr0C6IDZDHdsEq4BdX30UN5WPjcSXJnon8t7Dl+878I7XWjA08bo1yQQj4ud
 79nNd68aQDtval+EkZGF/hwH/6Ta2I6y+riYy3aHiDiSePnFLSWvSEdQCcOjvwUqAGZ5
 2qw8hTItHo02B3t4hM5cjoAOZ1LQa+iaLz/K+zPbX3SjUS+eX3mWRym55aHK+jR+c/7c
 uNnlIYMqDEKoiE+mKYUAvCjMg+UbEchZS9u79CyIjRPlmV0uCEgm/YXtlNGbhIYt8T1i
 yPsg==
X-Gm-Message-State: AFuF++nVZfAPYzogf2Z8uGtyZpciBOMCfM99UB/WuIKMuwRiOL9d07p5
 cvyq+lM81aKe4XtVxX3AINS5Ml6QV/yWKFMRrEOXqpdSPStvizSF/yI/3LIqFkscA82ZfpWolqS
 R8jsmxxMY7mnkm0jGWHPfbbyyH3lh6OT7lsM7ryxsQCyPuJxj9ii+Te348wgPav3zXA==
X-Gm-Gg: AR+sD13DHiKp+ex3f+7fgv9irIiBcgzFGyzwUMBafiRW8X7qmSaLLk6s4Drc8KbecN4
 p16sWKNrAb8qHhYVmAxWel0W2mmlJtmCU0jZLcGh/0L5OZf3GF0DDWn2D+wn/kajpqKrfcC2rQ1
 SGOJYPk38BAlQQ1gqTdZBZsG+ilnkLVXevuQTaxxNbF8++pfjAGbzPh/IQVnJXzR7XZphkgSYdb
 DtsqYvemOSMNb3AcGj8UhypDhATod8Ved1oHn6ci9V6kkLZ0/wb5rBQiRiuL8PjoZqTs/XDeMo9
 hO7ghpnQiivLfw0dmIX/LYUBtkVzjvID0UH4e28Rdsxpcps+VQw563zAlvIOqFF/Mn+tHNHV2DK
 Ds9UozwuB1zPiiRGtJQkrV32Jk5CT9pxdTw4RMKjeP9evGqlHnIrwwfaGu4w=
X-Received: by 2002:a17:90b:1a8c:b0:366:3517:1aa2 with SMTP id
 98e67ed59e1d1-396d0c0ffb5mr4182489a91.0.1787869193694; 
 Thu, 27 Aug 2026 15:19:53 -0700 (PDT)
X-Received: by 2002:a17:90b:1a8c:b0:366:3517:1aa2 with SMTP id
 98e67ed59e1d1-396d0c0ffb5mr4182421a91.0.1787869193264; 
 Thu, 27 Aug 2026 15:19:53 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-396b0fd55a4sm4466925a91.7.2026.08.27.15.19.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:19:49 -0700 (PDT)
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
Subject: [PATCH v8 067/105] tests/tcg/mips64el: user tests
Date: Thu, 27 Aug 2026 22:14:28 +0000
Message-ID: <20260827221506.91574-68-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=UKLt2ify c=1 sm=1 tr=0 ts=6a90b80b cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=VnNF1IyMAAAA:8 a=MTytrtsdTjBmL2pvzDgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: 2-jPNwv_5pX0r06xNKYOhQPO-M9Q3vw-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE4OSBTYWx0ZWRfXw++iJG/olvc3
 yK+jJpJ3eq8m7BhD5OmLpMmi4pwPq/1RQoG1vAUeVFJADefcnc3xoQR8bLfbUbtfSS9PwQIT0zb
 2sUZCGTYc4KNlxS7LoyCM3kswlx7gI4TYUp13edeMYTzGpKCwEX8a5jfrGBjNm711gE58WGeqzW
 8pg9/vh0WHv7Gn2rSLnvBkrLGk9i/P5VrI2oUkpuUpNp0gpA4UXCmmy3Kib0QgA6QKPhADj+Ctm
 Nzg5WYsQrfvxtN4a7YfpL3eRo1pfKMd28ChxtOk06g7HdFc3btlhyW/JmS2Tow9Are7mECqTpdN
 3lptqB44sR/qQB0Xnb+/a/CDx1a4n8CQsKoov9GRZ+sMk3RE9+RUALfzCYYpEb8BeAGa0EWgWVH
 PpdwaGGqhXJN/TiVVWLQxfFae76XpiJ/endH3a7tt07EfdWCSKY27TzYEft3E1w/iqhEXnzLurg
 gxYkA2TOoA+NqxP3SdQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE4OSBTYWx0ZWRfXyEi/USBo/ztQ
 n4S2qfpr3MHTUV9pGB8kdGuRVQhQ1/ybGkrqQqXtv1XbNJILauf0ZD5KvVaF19SRMjuzP5P3z7h
 lSQXi8IPeoBB8ibHhVq3A+ZHkJ3vf90=
X-Proofpoint-ORIG-GUID: 2-jPNwv_5pX0r06xNKYOhQPO-M9Q3vw-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_08,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 phishscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build              |  1 +
 tests/tcg/mips64el/Makefile.target |  8 --------
 tests/tcg/mips64el/meson.build     | 14 ++++++++++++++
 3 files changed, 15 insertions(+), 8 deletions(-)
 delete mode 100644 tests/tcg/mips64el/Makefile.target
 create mode 100644 tests/tcg/mips64el/meson.build

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 0102e74e8a7..7aca685078f 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -147,6 +147,7 @@ subdir('loongarch64')
 subdir('m68k')
 subdir('mips')
 subdir('mips64')
+subdir('mips64el')
 
 image_targets = {}
 exe_targets = []
diff --git a/tests/tcg/mips64el/Makefile.target b/tests/tcg/mips64el/Makefile.target
deleted file mode 100644
index 78c722a583d..00000000000
--- a/tests/tcg/mips64el/Makefile.target
+++ /dev/null
@@ -1,8 +0,0 @@
-# -*- Mode: makefile -*-
-#
-# SPDX-License-Identifier: GPL-2.0-or-later
-#
-# MIPS64 little-endian - included from tests/tcg/Makefile.target
-#
-
-#include $(SRC_PATH)/tests/tcg/mips64/Makefile.target
diff --git a/tests/tcg/mips64el/meson.build b/tests/tcg/mips64el/meson.build
new file mode 100644
index 00000000000..f6c0fae7981
--- /dev/null
+++ b/tests/tcg/mips64el/meson.build
@@ -0,0 +1,14 @@
+if 'qemu-mips64el' in emulators
+  tcg_tests += {
+    'mips64el-linux-user': {
+      'cc': 'mips64el-linux-gnuabi64-gcc',
+      'cc_dockerfile': 'debian-all-test-cross',
+      'cc_docker_host_arch': ['aarch64', 'x86_64'],
+      'cc_feat_cflags': cc_feat_cflags,
+      'folder': 'mips64el',
+      'gdb_arch': 'mips64el',
+      'qemu': emulators['qemu-mips64el'],
+      'tests': tcg_tests_mips64,
+    }
+  }
+endif
-- 
2.43.0


