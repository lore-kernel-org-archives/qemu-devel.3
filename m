Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB40CC61DD6
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:20:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziS7-0005Bv-JW; Thu, 27 Aug 2026 18:20:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziRf-0003bw-QA
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:19:40 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziRd-0007Dy-IC
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:19:39 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJMGEW1803885
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:19:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 HEeKaz1/agYI9PlO5+THsBLsrl3JVsDXEOowlbiiAWw=; b=FF3VkahGYJIH5vqO
 ycmlxdfPvNe+tE1U/ZbTbUEOybuY8hkjObcZZ8ujx2P6E2YXtVtRICOJ205iNrau
 Hxg2hNQ5rCwOtXX4DlhsbxL5OiITVQ4gtzKroQekKGHM7f0t41H2IqHWQsA4bX0P
 GepSIQU5SU84dDD8v/vlFh93hL8VUnI9sCQ77wbcyg6mDVqvM5nLRXeZ+jUDJX+O
 XHnVOWIjhaN2Jnu8eG7c4e3OIGsLiJiuWufUbcc7KRncStpi/kKCdKju4Nbd/uIt
 LOClTNmXaPEiE79QWeVRVHh2UiiaPRDKZl1eBJ8dwTofCsMB2zOFgYYFP+JkWm9D
 bNXQIg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gatfxgvgw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:19:36 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-ca6bd8a190cso283505a12.0
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787869175; x=1788473975; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=HEeKaz1/agYI9PlO5+THsBLsrl3JVsDXEOowlbiiAWw=;
 b=LfK29q6KrkXcLKLyufgTjhsKpQVLcJkXCB/wLfcIzCLF4U+uCfpKiw2RuL/+nhC1vQ
 UUzJzhN48g3kL8N6i4nUjcUa8IXa0++9R67LLOvZ0ZyKvFr6r9GJ96fqZHpD+jJ/SaxB
 Ua9tPrxEnQV9FIAcmlPtrhk/NGWY2A/gtNEhH8p41jO9CcKmOZ29HvBHjRcXic+gMq3q
 +yEhclWmVbhBvnIwFTXdxfaIZUSiLlAIO9AfJ54PBPVG3UVrGl6VblqNsJ4ZFu4J73tx
 Oo66cbpINJ7PygErv/+iPBceNtGOQJMLbUuA4R3LR55f8p5gI4vYJH88lZ2+qaV2dBJf
 Qb3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787869175; x=1788473975;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HEeKaz1/agYI9PlO5+THsBLsrl3JVsDXEOowlbiiAWw=;
 b=Q/NiPYg6AG6keJzQv5s1CdvJ7Q+Gzyl2HwALznBYmITOpX6lvd9izx8XtsdgPq/8+J
 iX5CrDZd4sQ0N1KrTKZbdUbXQKsJuKf1Ye1nsr3bsYKzbk5IzHk6Hu4zr0BC1uoPpqBp
 rUeMUuYOsNntug1KydUWCXmeapKl8TnKuWU2dCxKnn0utcU3YUgMeO2DYt+NgS1xHkgK
 EwXeFQs/zHDYJT8x+9MDSDVr80wSV9jA69mWyV0yvf7KXeNzFLUtYcV84whJOtI369qk
 QZ/6Qhk3KSwgn2PCULNe5XBGanvdD2rYJ7PBiYzD5H9JXSS2NCAUh7x705NBHUZAVX/p
 tqiA==
X-Gm-Message-State: AFuF++nfwido4iMO2Ak5wt1/gsZEuw9ARnGSKms9YostcQD281D7WZdD
 HnKhwelcLUAdWBbfDWNg0sEvVtB7nCH6cxG2qnd1y1g9ZZb1bks5Umb5EC1IXC1Q6ilS77lHFht
 MWxtBOtjeYO7aUjiJlIFyPdF37/cVke0SxhfrI6cpQt2ZNxrI/GtIHn2quZqlfY6wPg==
X-Gm-Gg: AR+sD11VGJBnY/WhbsmjJoDzPGbomXFZOS6z8vbHZ4pV+1oj+l843jkK8yKbt7djYSG
 XLD2GZaMpNF2T4+ZILgP27UFq1JqKDCSd6J94Oy3ipL2E166FPzUyt7A33zyFRfWfydgwqEkyje
 QTefvf8eM4j07Xu+iH6uoAOhNKtJv8ZAQAkXrOPkpxFcolnQcLLvCdv1kFCweMtjf/iVn+YUZ+g
 fFqhYEPrXpC5x1eY2dT47BZocL/Vy3+lo8vllzEgzy3f843VY/nRGkn0wIOjUWBVcd11NK1vKdV
 ORJLWR/VQqw3NiCaF52LcIffeWxgwthx8YTgy1t++S28hOb2psP4TVF6uIlHB2QCDNhRttjMWIU
 Jua3uoH5SnKkkVYIGvVuKHpITZ7eryQGWKljBRcizh1Y1yYs7PA/D886sNig=
X-Received: by 2002:a17:90a:e7cf:b0:38f:dec8:f7e9 with SMTP id
 98e67ed59e1d1-396d0fccec0mr3971702a91.12.1787869175316; 
 Thu, 27 Aug 2026 15:19:35 -0700 (PDT)
X-Received: by 2002:a17:90a:e7cf:b0:38f:dec8:f7e9 with SMTP id
 98e67ed59e1d1-396d0fccec0mr3971600a91.12.1787869174827; 
 Thu, 27 Aug 2026 15:19:34 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-396b0fd55a4sm4466925a91.7.2026.08.27.15.19.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:19:34 -0700 (PDT)
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
Subject: [PATCH v8 060/105] tests/tcg/m68k: user tests
Date: Thu, 27 Aug 2026 22:14:21 +0000
Message-ID: <20260827221506.91574-61-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=UKLt2ify c=1 sm=1 tr=0 ts=6a90b7f8 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=VnNF1IyMAAAA:8 a=Y7GLNXJ1w4EJNdMAD_QA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: x_6c6VIdQ1sEGcKPt8MExOxjRj2t8oxI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE4OSBTYWx0ZWRfX6IHSxc5HVXhF
 k+kq+W2h9Nj1oY4dXAUlYfPVCooZ5HwZJiMHIPG3JqwDqRFiWRWDhw176JcOZJ+hvl21sAcyYsF
 D8rImk2W/ZCPzpELf3X36mk8+4909NiHPECXOCoIC9HEgR1QddPI04DdXSLwaxNZpf/SytV8HzE
 NfndyELcDmE4cNNYbl27LK2nI8HodGHv9djcJ7523XQzgiSUXuoJc5Mn/Lg9jXCbTLTTJ2Ig2og
 XQk4brexrmjqgj90h8d4iWU9NPyovbRB23xFKTFcj+eY22Ui4BTjRdELpbH3Qkte4BwFwzzQDIo
 HdOGeKRtnppi0+d5sjZbE2H1+KzoW9rhXdlJ6g444y2Fr1dYe2TY2d2V3UW4Vi0hq92lxJjwkbI
 gQz1O6O7MxT2ti+S9z6zBQn61KZiM1lZA8wag/j2g6VZZUkSgLy2ODnd02sZrxlz5SLlFo69/54
 UZYKdXYqRCQYkgak/BQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE4OSBTYWx0ZWRfXz0rxV8ST6MOh
 VXJFAHlsX/GO/A9iIptzYfYzEeBdBjpOz1fcKBMO3rlVXPA2v8WBOOnI5Y/o0Ajc4JD99s+yOJ5
 13R6Nu6kG/hUXvtFTPk7h4ZA9gLitDg=
X-Proofpoint-ORIG-GUID: x_6c6VIdQ1sEGcKPt8MExOxjRj2t8oxI
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
 tests/tcg/m68k/Makefile.target |  7 -------
 tests/tcg/m68k/meson.build     | 23 +++++++++++++++++++++++
 tests/tcg/meson.build          |  1 +
 3 files changed, 24 insertions(+), 7 deletions(-)
 delete mode 100644 tests/tcg/m68k/Makefile.target
 create mode 100644 tests/tcg/m68k/meson.build

diff --git a/tests/tcg/m68k/Makefile.target b/tests/tcg/m68k/Makefile.target
deleted file mode 100644
index 33f7b1b1275..00000000000
--- a/tests/tcg/m68k/Makefile.target
+++ /dev/null
@@ -1,7 +0,0 @@
-# -*- Mode: makefile -*-
-#
-# m68k specific tweaks - specifically masking out broken tests
-#
-
-VPATH += $(SRC_PATH)/tests/tcg/m68k
-TESTS += trap denormal
diff --git a/tests/tcg/m68k/meson.build b/tests/tcg/m68k/meson.build
new file mode 100644
index 00000000000..8ecf450ac68
--- /dev/null
+++ b/tests/tcg/m68k/meson.build
@@ -0,0 +1,23 @@
+tests = []
+
+tests += tcg_tests['multiarch-linux-user']['tests']
+
+tests += {
+  'denormal.c': {},
+  'trap.c': {},
+}
+
+if 'qemu-m68k' in emulators
+  tcg_tests += {
+    'm68k-linux-user': {
+      'cc': 'm68k-linux-gnu-gcc',
+      'cc_dockerfile': 'debian-all-test-cross',
+      'cc_docker_host_arch': ['x86_64'],
+      'cc_feat_cflags': cc_feat_cflags,
+      'folder': 'm68k',
+      'gdb_arch': 'm68k',
+      'qemu': emulators['qemu-m68k'],
+      'tests': tests,
+    }
+  }
+endif
diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 70aaa86afbf..dc83b7447bf 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -144,6 +144,7 @@ subdir('hexagon')
 subdir('hppa')
 subdir('i386')
 subdir('loongarch64')
+subdir('m68k')
 
 image_targets = {}
 exe_targets = []
-- 
2.43.0


