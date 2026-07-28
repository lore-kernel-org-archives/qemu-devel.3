Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D305CC54F53
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 04:51:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woZlO-0004N1-FL; Tue, 28 Jul 2026 00:49:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZkN-00031O-UH
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:48:56 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZkM-0002BL-4L
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:48:55 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S40dkl1593254
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:48:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=VakQPz9YxU6
 em4iMd+9trlvzEscpK6ZX4ttHvzb9d8M=; b=BIElwnLXHN1JMNIFZrAOzzeCIAK
 IU7MJXUneONHneDpRoGOwAhPZQehgaILIB4/D7Hf2DSzVyxjJ2fcTpDpjz+PgcNs
 SKeIEl1mANQ6sjcAGx+ejulRdY1OjLBV2arcNGQNJMuMRVmyU+fJiL5YyaLDX9I5
 l6HWR+64pyZHw6tcSGyZmR9S1adJzs3MWdxV+wK+f9zX0YYomaxcvQdpV8LSO1o7
 iOcDuMRi4hpluihtYfx1yLO25Qf5j07P2+MTmX7RIGp77ld8pkqryUCFxOeEyFfq
 XOVqm+XjlkkcfPBOfNEUP9WhOkMiCMFBiJrOC9VZw1a4m43nHf7+TiYzpRQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpn19g4nr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:48:43 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-38e54b6556aso4062214a91.2
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 21:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785214122; x=1785818922; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VakQPz9YxU6em4iMd+9trlvzEscpK6ZX4ttHvzb9d8M=;
 b=PH/4JuEuOJ62MKlSAZR1CA4NiNWwmzFW0ct+GeJaJwiQ/Gmzat00JFF+x6r75VdFPe
 kiwGyjDX3wcfRK/DOofxLRLIR2vk5qqlJSc22vx8gseXsQj1sD+VKdj/1b3Y4MsnUhNy
 1d6NxZ+Ipin2EXu0Tvp/UfHOGrxPQAdrlXWzKjNruaVI3p+OPhrcVeBdOHHvpBvu2/HU
 aBok5sduYIn6rK97RgnkSNcetY1vUJpS02Z+MGZ8lLKgU63Lvq32pXqQRPy6KPa6JYKL
 65/J4UNgeigJW1VXrogz9huSn3LxFsta+gkf13aQzLTI1Gmye/79Ec/Z7WBBdqTefnQ2
 KDIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785214122; x=1785818922;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=VakQPz9YxU6em4iMd+9trlvzEscpK6ZX4ttHvzb9d8M=;
 b=E94S0GZ09jtMkbME9qZ/g3Ln0rCv/LlRwOiIR7apQfxlWGsSLwodIjsmGdzwxdMikr
 +fNM8U3fFjbNj90orAa2YopvBoKphXoXgaWRoIglJFBsNZgZfPn45kYsCsDYXqUcvzvW
 jQITe9JAkr8sIKjQd1zGWk3nLEz4gCFYu8L1Sf6nv+eg4zg2f7U6yAuPjHio1eiXHM5e
 4ypCiMYwrpuA7KTnbkIQCsJPISgQuT7zWOoCN+Fl7K4R9o+6H7vFOju8yfooq6fOzGx8
 IOKmFw22jqNGqqv8X8gdMuhbnv1gGE6XOSs5jqGiFVEXMZNrYmJ/hA8bzZC3Mcx6fj6J
 JA9w==
X-Gm-Message-State: AOJu0YwzUwkIMAgxROl0yfZaVdZ5TnUmBVrhkgCEvN7RNTnjy4aH3Ues
 P1VJkjnzT6FTJLVcsy+6dAIwBhzniIdvUU8qvtoUQa4TP/H77OHKQNUqrkrKnHsFIgGu7yz+6nE
 2gCSwZGv6R571yHpPjwvCvtx71FDw4CiI9HLyxnP8qwt+q9MNwTtZZzm80/V4ntHjPA==
X-Gm-Gg: AR+sD10OBq5sQeMm94gF/5GQzOF9JLZLXmTEDbNeXtphqv0v2jWMQOyltlFfWXYpwBi
 cZTDugHwls1ZxRKhX31ZrL/1D1UUC3AlNQ8hkdFiwyWADlvHXl1MdftmwRSf3tUezLuf7NBEUQQ
 e2xw4Wpnjufr6V8/wsdGzyonf5W72KcQKOR7yTkPyxBMuvnZ2R+tZedJ9GN9RNQUbYOeuSMnM9S
 45a+FOGr2nU5bQnljcbOCJiQJ6qHxuCJCo3RGuYWutZbt5qcvhFeEV6ICXLiQxzvy3aJ5/XYKdP
 FUo0poQUXLlhAoLiqtUHXwOUhvABGalNn53ObWA9zd/lF52RMyMiYUJJgDa86pJJVbFApuz0i1U
 9O4S1qf7Os1w3Awg4RAKSI2sg8y1kDpmCd8FofDrBvnEyj+L5GGPDWPpX716t3dXtw4kKDSo=
X-Received: by 2002:a17:90b:3a4c:b0:37f:e326:6559 with SMTP id
 98e67ed59e1d1-38f6a438830mr1027636a91.22.1785214122204; 
 Mon, 27 Jul 2026 21:48:42 -0700 (PDT)
X-Received: by 2002:a17:90b:3a4c:b0:37f:e326:6559 with SMTP id
 98e67ed59e1d1-38f6a438830mr1027608a91.22.1785214121817; 
 Mon, 27 Jul 2026 21:48:41 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13d13003f12sm103090113c88.2.2026.07.27.21.48.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 21:48:41 -0700 (PDT)
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
Subject: [PATCH v6 077/103] tests/tcg/ppc64le: user tests
Date: Mon, 27 Jul 2026 21:42:21 -0700
Message-ID: <20260728044248.137626-78-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=TJV1jVla c=1 sm=1 tr=0 ts=6a6834ab cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=xUnFrxDuBQSFVXqpql0A:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA0MSBTYWx0ZWRfX1a38WTtv3Uw7
 ZtOWu63vtJRHZdNVJnPYo0GxQD6E4WIePYG9ut3de52FetN8Y7xvcEnqi2Nc9Mr3yAI73va3U6K
 3XS/Op5VgylOKeE9G1E1FSQz7Pskdi/z5FhFoTUK+x6fgTnL8cnP40OaAqf9+uWlmY1PiSaVNAV
 0xri0VVlvyFqA7fMlUknxFfyMFNC4mT8CTxZFZtXkfKRNWluonxzmdW7xenLa9AWq9/8FpGkRE0
 CrXGahwXtBtbQliuzJJUubi/5JEc2lcewXn6upinRewNqTtd/yQkxtbqV2Bw5pUnsEKpGI7wb97
 A+s+Fh+J34j1iQ3qkLtHwL1kUwy6up8oiMMIimnb1ewLQ7dfaiABqGtiIPjEnCPARah2i9jhldO
 yYh757KlkH3thT8dqmHgiSxlDeyGEgxL3vnYpEJcgiABrK2t8VogF+LZ6sri0mDZmGz5b5gbKTk
 1wIdTejrhT4UzyOAsQQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA0MSBTYWx0ZWRfX8yQKGtLUqCRk
 Drc4UxCtatRkVI6eyxMOVkojjN6aAhP83opTQv2BTJdk2vhEEBlsGHClB+BKe6rOCxFKT1aqWnq
 Sra8llrV24p0RmeQBCLXQoghgCbhVv8=
X-Proofpoint-GUID: Y7qveZ5HI11nbtF2oRfPs4ArS0xQAsI0
X-Proofpoint-ORIG-GUID: Y7qveZ5HI11nbtF2oRfPs4ArS0xQAsI0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_01,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 spamscore=0 impostorscore=0 bulkscore=0 phishscore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607280041
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
 tests/tcg/meson.build             |  1 +
 tests/tcg/ppc64le/Makefile.target |  7 -------
 tests/tcg/ppc64le/meson.build     | 14 ++++++++++++++
 3 files changed, 15 insertions(+), 7 deletions(-)
 delete mode 100644 tests/tcg/ppc64le/Makefile.target
 create mode 100644 tests/tcg/ppc64le/meson.build

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index f8166615f76..349fd0aabc7 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -150,6 +150,7 @@ subdir('mips64')
 subdir('mips64el')
 subdir('or1k')
 subdir('ppc64')
+subdir('ppc64le')
 
 image_targets = {}
 exe_targets = []
diff --git a/tests/tcg/ppc64le/Makefile.target b/tests/tcg/ppc64le/Makefile.target
deleted file mode 100644
index 00a0cdba295..00000000000
--- a/tests/tcg/ppc64le/Makefile.target
+++ /dev/null
@@ -1,7 +0,0 @@
-# -*- Mode: makefile -*-
-#
-# ppc64le specific tweaks
-
-#VPATH += $(SRC_PATH)/tests/tcg/ppc64le
-
-#include $(SRC_PATH)/tests/tcg/ppc64/Makefile.target
diff --git a/tests/tcg/ppc64le/meson.build b/tests/tcg/ppc64le/meson.build
new file mode 100644
index 00000000000..720aa167f23
--- /dev/null
+++ b/tests/tcg/ppc64le/meson.build
@@ -0,0 +1,14 @@
+if 'qemu-ppc64le' in emulators
+  tcg_tests += {
+    'ppc64le-linux-user': {
+      'cc': 'powerpc64le-linux-gnu-gcc',
+      'cc_dockerfile': 'debian-all-test-cross',
+      'cc_docker_host_arch': ['x86_64'],
+      'cc_feat_cflags': cc_feat_cflags,
+      'folder': 'ppc64le',
+      'gdb_arch': 'ppc64le',
+      'qemu': emulators['qemu-ppc64le'],
+      'tests': tcg_tests_ppc64,
+    }
+  }
+endif
-- 
2.47.3


