Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 467F8C44508
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 21:49:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiJ5q-0004LZ-FP; Fri, 10 Jul 2026 17:49:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ5f-0003zr-Kk
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:49:00 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ5d-0004xF-9C
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:48:59 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66ALDHt71932812
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:48:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=K6BFDaAeEjx
 uvjRhsU3q8U99hR9TfXAwOCbNG90Zvp8=; b=JS+gZjK2HSr2HaM8B6w8bmwVeF6
 /DXFIvsYjnau6AsuqwD4YJ9IL+3sVOF/skYqzZRFCcq5Nzve8zUyqej40NmbfgEK
 I8Q7DpADyQyuSEfkw/IOJd/rDEbJJfLbmrtLsSu2sv2Q4nKpB/T1Qch9dcEueOAZ
 xEnyS+QM2lwZuZj+/n9/HAvTjXmB44kjDqNwLjidkL3dO0o8H/2dHPxOW71DgoJ0
 NnQmZA1AkgVHlMs5kthQZqQLbDOji+jIftd1FKwEu6qNe7l3m6uIkKDDKXfbPVWg
 I9CEAGwpjDs+MltcuwUa3YcoFDolvXDsg1YPImIQHvCBwfbXinhyXSTDPdg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fb8f2r31y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:48:56 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c8924f4d0a4so1822613a12.2
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 14:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783720135; x=1784324935; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=K6BFDaAeEjxuvjRhsU3q8U99hR9TfXAwOCbNG90Zvp8=;
 b=iKp/dKtSRqTNddy4dTHvpF39ZlZFcleRLFpbSXVAEmGUVBv2ZchFQzTYeo7MKvZl+1
 ilUD7cj4n/bUA4L0WNnTQhpoOD3gD5t1hKuMBNxe5pbEcMLz/lXPtHbLQwMgSXed9Q7R
 9l6JmLktTe3CZFRgeh1XWgUtUpz8OxMv3Qr8xcc6su1eigzu9nkSnruHGn1CGX3n15ai
 36CuutLZPtUUfhnr473zffCdayr4mxynqtIOPX6hmJFdk/juU1zS9YX/HRI9v84QmORF
 LPNBkgpPoTnbQdZ9j4TUnupW3OxWXNSN0h7onOD6ur9PnCWK+bIx2k7sdydln1whwIZ+
 APSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783720135; x=1784324935;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=K6BFDaAeEjxuvjRhsU3q8U99hR9TfXAwOCbNG90Zvp8=;
 b=p9wQ40a7KMAHS4iPHq85Qh3pLsfyNQ1huDnEAh3+PpW12GBoeRUbKqr7En9HCBt9cY
 IVEWmEpWb0bWv48ZC/dasGSEW2m7pbb5+N8Z155i0vdhP37B83wPPvea1y5gkiv7PeTB
 7wV/u5RSt0T43QY6f0a0dSNQTvzJyZIy8VG2Unp4fEyBYloEWBb4G+KVQwWXpjijZngb
 0s5WuQRnbxsmS/B5168zfMGSJAArnJ7h+XejXi2+CVh8yp2PtHsQ1MzUQjrFdIS9jFEc
 zZ+PDI1W73hDKQ2QF0tCnpIcrkKcKMOah2zHpwLtR7T/MzM8WQdVL0Vg4rLnxg2yIuxf
 HeNg==
X-Gm-Message-State: AOJu0Yypi0bmXGbTRibMO/eG6hZuuFTgIFc93Bnq9vKMIUBoxREYl3yO
 lzZaT8EE59sw9yJ1QGb9aL+cFyvTxZhSodbgVNVWbb9doiOLEijpoVUKl9o9Y9JEiZOJzv55WUC
 OFjR3gKU9DRnpw5kpaI7VYEBwDvxlcfrtTI0o0WkNsIbmtPBTTNLTeN//rNo3fMEsgw==
X-Gm-Gg: AfdE7cnr/hUN4E6WQ2UcqOch1xpPiVrKn/pHLf4qrTBaAPR8v4XHDXEaFhGoHKgayNz
 G/sC740E6XhSHeSqqV7YZtKyUj/hm2h0B/sz3/xIdndA74T8OD/SHazCSVY15k9nclurd91XU4H
 MMtEi4KAWikqRujEhFkar9nDU25VlVhwByJ6cu++JD03OpRCxHrVaWPnwUgXeEr5veh+lVV6jv5
 L+DnblVk8cNO/W6T3QqIwZSjHCej4lBAeOYzmyueLhekedNOk5vsdk7E2HGeg2zaHdUFdpNKkQr
 N5n+Ly2l7ZnVvD9zyzSYpkCpiXXlwR234lHQN0ukMtGhAYy+8hnAJoHO0LongACgjrAgwUNe/6a
 CE1DYMIcsnoqmPd6Sq5fdzK08RTwur+KxTqAGuCWSBbhsoY1wv92tdMN9Fx2PjTcbWKRk9Z9zDB
 OIFtzu2Q==
X-Received: by 2002:a05:6a21:682:b0:3c0:b9f6:96c4 with SMTP id
 adf61e73a8af0-3c1108cd47amr757188637.37.1783720135350; 
 Fri, 10 Jul 2026 14:48:55 -0700 (PDT)
X-Received: by 2002:a05:6a21:682:b0:3c0:b9f6:96c4 with SMTP id
 adf61e73a8af0-3c1108cd47amr757155637.37.1783720134959; 
 Fri, 10 Jul 2026 14:48:54 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-311838c9235sm39886355eec.21.2026.07.10.14.48.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 14:48:54 -0700 (PDT)
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
Subject: [PATCH v5 58/98] tests/tcg/m68k: user tests
Date: Fri, 10 Jul 2026 14:43:02 -0700
Message-ID: <20260710214343.2065491-59-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=YLavDxGx c=1 sm=1 tr=0 ts=6a5168c8 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=M3ftf1lNtvFtQ7Cz9QIA:9 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: 2C_KYlF2VmDpVacAd75mHReMr_lRDwQB
X-Proofpoint-ORIG-GUID: 2C_KYlF2VmDpVacAd75mHReMr_lRDwQB
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIxOSBTYWx0ZWRfX29nOqkLGQSEh
 MiTaDG2xAh9YJdKojmWg/0+3mGXxKfr0W5agGM97bZo5dCSunovC0YyE7B5LlQR90JOmsQ5oEbi
 01nknTbVFpKvarOmwX5TaKs9h3PaIjk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIxOSBTYWx0ZWRfX7F7xNFHlB6EL
 76aKW7trDjcGTz0vgSWuTEHXwUb/n5IK/OtCEx/wxBmBJrYUnJ8qXLF7cq2F6uWInugK5+yXtVi
 UQg5lV9V+cHaFpfDMq2OeAzwgbyFSOvvE1WnfZ4EhLzmjDdIRxJxjIR/nThars31/c+oswC8vCM
 0o3H1RM8W+mdGA4/D5uIuKDo9FP3sYK9CrBFNhtasQwy4AqY9fvosmj+er8oCFYBlzEQDq7y5gn
 f2iyLJbTmAynaRhZNjY2QrEdtIY9TjXOIW/L/TENZFsfhJlYKwiEHlgBo/uUFrYOBO01lQCeLEz
 ryi3yHuyClHERbCy8Ua98drYfwjs3mdIQsmGl/H3hoG96NldTgArDjPAMFBsp7xnQD5Vv8h81Ls
 vFhqmv8SJ+ffqNg4rnWXuFqZweKYR5k6KdC6b5e0Iq8hE6UbjBD4PyXJBhSmRatACLyu7i2lM7/
 2lPTaqaesLHPhGjTx/w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 spamscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
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
index 451fe349a3e..48895c7619c 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -141,6 +141,7 @@ subdir('hexagon')
 subdir('hppa')
 subdir('i386')
 subdir('loongarch64')
+subdir('m68k')
 
 image_targets = {}
 exe_targets = []
-- 
2.47.3


