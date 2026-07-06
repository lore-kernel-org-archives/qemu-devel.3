Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 350A6C44501
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 22:38:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgrxI-0007TX-SQ; Mon, 06 Jul 2026 18:38:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgrxF-0006qd-9j
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:38:21 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgrxD-0006oe-Ek
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:38:20 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666KDuJI1495414
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 22:38:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=tV1th1eZwZD
 Z+NThyeGGjUBbcZ9B9ivdTw4eL0/YQks=; b=a2UQPsELqFBHBsTHnkCF1X2BVvd
 TccuwoRoNu2g/EkrGyrzoWYdP01BwpSDRGiX528bWgoFdTvx/b+Cy4Np/3rBoCdA
 8EUMLRyxfsHV+C8K/JeJo7YCeJ3iyUVd/SP2N1qh8kgGMkoZRytNjVyS8aFa2EZS
 U/JPXKwZ9gqECPm4fDQynh10Nx5Vw3S7f85/xTLQnPLb4FFzRum4Fyz1e/ewWRgf
 oScyPodGiweD/prvEBCs82zTkvUZm20E5f4u0Z6zkd5GwstF/cUDesHrdy8JRx9i
 splOo2SJzLnYUd1hojpzvfL71HTHXJlXTWWRQGwCKSJjuf31SfvVrueNGHQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88t8bgq4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 22:38:17 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c916d17dd43so5549488a12.3
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 15:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783377497; x=1783982297; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tV1th1eZwZDZ+NThyeGGjUBbcZ9B9ivdTw4eL0/YQks=;
 b=gjTDRWzcjYwYUx+LVFFI0D6w/lE5CXWelOxBijlunrHdcmyYjMFnhSNbZrHKw7mzyU
 kGcOfiP6ed1a+FqNvy08eLrko3I2KlNCeN9sDuXiHfJJpX6LoGAsWg93nfmSy6qNSCNF
 kEDRkYyHF661nIdortU629ae8NO7zHGTDa1YaTZJsgxeKIgMIp0ya0Eg79xeElbdOcmI
 cFgBDJ8/zaPAUIvVBzqnzU0DQxhizrm140Ducy/SfdpqxwSK76GkVoxK2xV/7GOyB+NU
 AUjwarDlneWjTiDTztYwEUtXRT6IUZHtPKKnX8DZEF5G5VFdXjK5Ngd6DXrkPEtKfRXH
 lh9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783377497; x=1783982297;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=tV1th1eZwZDZ+NThyeGGjUBbcZ9B9ivdTw4eL0/YQks=;
 b=jqs3SgoTSbDN2Jc4b5ah7ZG6EUGX/GlrB8awkqZBRZStw6U9ztre+EOs+KnHxmPEl5
 jG4pS+x4RwXAAG0SG/M7FmznzWlILCwzvpGtB0NEQ9awpliJaCIPR9KTpWHedJFS7CYS
 jB8KfO0IuNbgCvV7X+qMIH5kG9fkYr757Tlh2wYmeZP1JVfTd8/+G1Ipyw+kU6YRp5SZ
 HR3mN52RBNc51L55xTo7wOgjrirxNgJH7lkurbMUsg1FO3tZwgS/SoE5RcUaE9+Qjm+H
 VIp1v0qAp3udFNWSyvDPp8k+Ogp0YqzDw3uJTZJPdDL+iQelH7afV8OXQTL12eElHsao
 xK8Q==
X-Gm-Message-State: AOJu0YyluWiKzHu7KaRRCGakmIDKZv1fToCePbEJ/if/mMvmfSOeTjia
 rNXj7Jo/EFi7EY/Jwzl7l1n2Uyj8eOjn5g8hHqofOmZWPq9jtSpN2mzWf90eaXrOTLIkNbZD/Xe
 aFRvBq7KsG1N9gSXiF2n8ofRc1Z0Vq36Oy/sGLKKg1hMjOvwKMWetnqO6X1UHmw5Aqw==
X-Gm-Gg: AfdE7cmXkkhjAS9FMUNmCFt3D6VRv2VnvAU6zf1z8QmFnCos3SFsB1bb+7q8YDFgUE5
 1mEkDhyxqS/Rm1MxdLOMgpAIGQE4o0ajNgZKQYUPmHBZMJkEIpoxpXV++JJbviqm1bt5m+UPal3
 VYy6esrTKoWdWyfy7gaDxXM50cGZoMsl382xE+dHQ5pfkewFGthzUPM3FExzNCCUEbaRFB4TI/D
 g38BiGRSBEc/NkeG6/X+osE/35h47dLSp849C46JSgApnC56EW07eSBERuXtkJEBjMq85eJh0eH
 6DWkrKuvJBICzkF1kMwTB2BaaR7xoAn+RCvFgp39rTZSY9c6cLIu5PcHhJenQaOjZ/0KnIJn4wn
 nrnDfwX7mSIVFRyhuilNul8Sxr6yPmPzYQbSqzrqX4kh6KGAA/qQAZNAg+t041roEnGI0csSDOx
 Y7WqwKog==
X-Received: by 2002:a05:6a20:9151:b0:3bc:5284:5445 with SMTP id
 adf61e73a8af0-3c08ed07f2cmr2946966637.21.1783377497393; 
 Mon, 06 Jul 2026 15:38:17 -0700 (PDT)
X-Received: by 2002:a05:6a20:9151:b0:3bc:5284:5445 with SMTP id
 adf61e73a8af0-3c08ed07f2cmr2946937637.21.1783377496955; 
 Mon, 06 Jul 2026 15:38:16 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659d8da9sm1399484c88.14.2026.07.06.15.38.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 15:38:16 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 47/91] tests/tcg/hppa: user tests
Date: Mon,  6 Jul 2026 15:32:59 -0700
Message-ID: <20260706223343.988769-48-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIyOCBTYWx0ZWRfXwkX58PdP8+7Q
 eCaluLFWPAm+DyU/iuEGDwdiz04W8eMyWF3bo5zsfaGzhA6uXdNqFUQp9mVfL0X6r+xGo7hBM19
 u/mRCy0U0ngnv/IeuEinlDRGzetsBSI=
X-Proofpoint-GUID: -r4r2P4vpFIV7iojzcJ3h7rw6mIwFN6P
X-Authority-Analysis: v=2.4 cv=C6zZDwP+ c=1 sm=1 tr=0 ts=6a4c2e5a cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=1o_546PwXJxQqFFEpCwA:9 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: -r4r2P4vpFIV7iojzcJ3h7rw6mIwFN6P
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIyOCBTYWx0ZWRfX9x7anssTFwF4
 ObyRiSiLhcFoF+je7xIcwK068ReXRy5WNNQi+gXzBkcabcSyEDYSZkyItR32tj6IwPwxUIc0jwr
 IAEbVILqpR59ACWc8OH4jzvp9x2pG8xISkrCPnHygATLElooyFvtkPLIVrJDpf3t4Lp7tEcWvIT
 bErC0oRvwrzLm7BHDsJnBrjp5eQ60umKxMYtwBBkWwqHffiQKMbqC+CNfDC0qJ9Woh+gKm/Gity
 50zlNc5lq/o95ZMzWtqfzahDW9Vn6U4fzUM7/khP1rXlkluX3AHEmCPdgXAwAh8WNEVemP1z8i1
 /PM0KpfGmBZYyqzaEGXGSuCkd+6S3NewBql+heDABoJJpzg2TxrY+tgSjRiEIRN2sdEb9cR0MYk
 nylm1Wp9getlECsA0y0gykudHX1q9Zdt0tNpi+C7G3Dkp+Xy15MuSAFkoGi3DFAZed2j8W2zxdA
 C9fdvt+upwnEnvpXPkA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 clxscore=1015 spamscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060228
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
 tests/tcg/hppa/meson.build | 22 ++++++++++++++++++++++
 tests/tcg/meson.build      |  1 +
 2 files changed, 23 insertions(+)
 create mode 100644 tests/tcg/hppa/meson.build

diff --git a/tests/tcg/hppa/meson.build b/tests/tcg/hppa/meson.build
new file mode 100644
index 00000000000..368457ce936
--- /dev/null
+++ b/tests/tcg/hppa/meson.build
@@ -0,0 +1,22 @@
+tests = []
+
+tests += tcg_tests['multiarch-linux-user']['tests']
+
+tests += {
+  'stby.c': {'cflags': ['-pthread']},
+}
+
+if 'qemu-hppa' in emulators
+  tcg_tests += {
+    'hppa-linux-user': {
+      'cc': 'hppa-linux-gnu-gcc',
+      'cc_dockerfile': 'debian-all-test-cross',
+      'cc_docker_arch': ['x86_64'],
+      'cc_feat_cflags': cc_feat_cflags,
+      'folder': 'hppa',
+      'gdb_arch': 'hppa',
+      'qemu': emulators['qemu-hppa'],
+      'tests': tests,
+    }
+  }
+endif
diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index c4b35161686..1eb887a8e3b 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -139,6 +139,7 @@ subdir('aarch64_be')
 subdir('alpha')
 subdir('arm')
 subdir('hexagon')
+subdir('hppa')
 
 image_targets = {}
 exe_targets = []
-- 
2.47.3


