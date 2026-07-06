Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03B20C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 22:42:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgs1b-0005da-4T; Mon, 06 Jul 2026 18:42:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgs1Z-0005d2-4b
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:42:49 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgs1X-0000AG-JL
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:42:48 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666KE3qC1478201
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 22:42:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=mZXBAyoT2DU
 yAXF8/440qKoLXPoceAug6XtUnsYv5Jk=; b=JWWfuAZHoucu+6Dw7gSyAshmwO4
 R9gnVoa43CIl8gk25+9yaVfj6jdFG8AgU70+swYsOzR3XKZukPWd58g9wNWdrq7f
 pTzyQsykPkcs4K7G9ze+Yx5Ya/3KOItIGSw75S8APPboaKiGxIF/Sin+gUgCyGx3
 sFonUgAtufIuYlhMTIDfb/RxhL+LOlLklWmw5wGJFb9rf8fnlkoHMc03f3dzsW3j
 DTd9qaIdiWnF/NAXqJ0OLFVsuqfc21AVf27F1HGwn2xuA9XZAl6eFKBwEOO5Y7D3
 1VwHIeoF03rV524z5t/AS2ixI5JUeQMMevWD7qF4TUWglTL1c7232AFbUOg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88hsbmv0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 22:42:46 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2ca5d2474c7so82126645ad.2
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 15:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783377765; x=1783982565; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mZXBAyoT2DUyAXF8/440qKoLXPoceAug6XtUnsYv5Jk=;
 b=ap8uTFaMyCoC8TEoewa7Hy3ZrOhTX7ThZnDa+cRbsrZ8H974ZDDSk3jiqfEBKMSYL+
 z5FBSFzlk3Kxn/MmpndYkVb4lN/rz0loYfTsnJCxoSRwV1+6Sctn7XgcjBn8tZEHDw34
 UgfOv9xyGxAny8ZFqSemeUH35Y92MG60L0/KVonke4m1xDZMG6B0MJ+X0iWa0ygCIUtx
 UhshZ/mEEmJFnMG27F48E4g9ckVO6fkexAUZb3Hz/GC1CLgOCyxTD8RSTtLYo3vVkHzN
 aqJASBlNbPL5XxRP5kdx+aT+9eGGSR8081HgFgYDfXhbDaFf+Ia6Y2TXs+Ym/UiyBYaZ
 zCmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783377765; x=1783982565;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=mZXBAyoT2DUyAXF8/440qKoLXPoceAug6XtUnsYv5Jk=;
 b=pywcEqhXtokwyYBL1KwjfI/3LC7KHhsNa4K1s9ykqRASxQ3HGu4HSf8ASLenOXKq8o
 ifC05U7IqMuU5hUtpUbTY6XwPzUWSIH+M2kgoAGrbEqvKMLPHJQoHy/kjLG70lSE12pq
 ss7T2uy1zJxzkCpv3CnRWmdM/bXM14BlaJYUHMtG6UpH6FViz4ABJOEcpcrqqkuWFAk1
 C48bVwbAKgKnqYkpCM5PhoOLWFXW6VqopJysH6InOeQcKSvtuirS59rEKhaoPfqop7ZD
 qmwtdyQk4h7RA8zUFDH7ZgqSZ7LK8oc3aldYVmbnFPTIOlykXp1khLUedf1pDvuy0gdd
 DNSA==
X-Gm-Message-State: AOJu0YxGTg0UG0hdmaQfBkeAaDiRBVX7NdKMBoCFwaO/hDE7T020dzw3
 LcB9PX7VC0Cvhl1sNPL6Ucu61xdDmhWk9eOvzF5wZffy1JFn9uYPgr8GuTZFPF1g1CiUbevIlNW
 fX3/IEPWWn1y5M8l+zhHVO2Pqpp/+aUR9lvzSY+bCrG64KomTH+VPp/S1r4Y5jju0mg==
X-Gm-Gg: AfdE7cl1AWyK5IGVWP3wf5389NLUsSp5A5Dn83sx9XKvJgWXIqsltp/NjDpCspJ2wQa
 Kb0wjMgT+yKDaK50s9QHO09+OOBMfO12YpY7h3XImHlj0J/o7hABEDU41y+AzP57l1WbDSJ1//H
 2p+Fw2F1BLgFkrDJdF2XxaDxKcaXJmXT+9rwLtS54Ls8o7d4UFu9archYW68VTu90AMpoqA5C8/
 b2OfLWwNRkZfXXmajq37ZY1oQaT8qmasd1wPtGBx77OKr409UQjFsIP9JTEvjXUjs5iSDEKGcMt
 fld0hhapg7+GeCMaekHwq3oTesiTWKMxTR54ajvsGkYVKdAgINlIqmv99RNM7MpQaPICHHv0OFI
 2OIlqdLtDLS0Uf0MZXKbk0GUmqWwTTT1l14Hg6XGgh/JAJ/ET+xAQcQQHb4I/XzgCJ0ZNfGX5tf
 qAJxVLjQ==
X-Received: by 2002:a05:6a20:a120:b0:3b4:65d3:17b1 with SMTP id
 adf61e73a8af0-3c08eeb37c8mr2954429637.43.1783377765074; 
 Mon, 06 Jul 2026 15:42:45 -0700 (PDT)
X-Received: by 2002:a05:6a20:a120:b0:3b4:65d3:17b1 with SMTP id
 adf61e73a8af0-3c08eeb37c8mr2954389637.43.1783377764661; 
 Mon, 06 Jul 2026 15:42:44 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659d8da9sm1439200c88.14.2026.07.06.15.42.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 15:42:44 -0700 (PDT)
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
Subject: [PATCH v3 81/91] tests/tcg/sh4: user tests
Date: Mon,  6 Jul 2026 15:33:33 -0700
Message-ID: <20260706223343.988769-82-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: icBCMChOA1NbyOBUWHzslfH6Vofskutf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIyOSBTYWx0ZWRfX9KS/vUGB4Zgm
 ZrG+GeTbjVBlEPPa2NsDUtAv0hy+rQYG6Cak8tpZeZU/OP5OlkZpJCfEWNpugu3UziDPbYILnEF
 2A/9Egj3rXoK1EbIlLt0yb1vO3PEe2ot8Z8rR1DCChEDGvw9ksCMubcR9YS++9tPZxEuUPjQTUw
 hFhcdxTJ6yijIlg0hloLl3aX0/dnjEs4wMgyi7HC/5dD8pN9YwNaQ5MvMdKQBNEwLFxTr+c75Zt
 1bFhoUeYIYoeZmRG+CnOxDq8AAVbTs+QvQNUk+DCz/I7JBzalamlVU8HOet5avHiO6cCsf2VOJ+
 cSgYd7nfgeNUzLRjLIvaIO+aYXXao9OCepLRbZwkeqaeGd66OowOySMrEA0XjJzKYddu/BftNzP
 57eykgcH7j/yx/EMRZFrtn5sJEty/yBImK7gBC0HpkJQLqVW1UQCtFT/u+HV0dPyVahDO7fiQSL
 M8TJDW7O8gmat+RN+TQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIyOSBTYWx0ZWRfX6+la5ytOK9hL
 iqDtFWn60/b4rvK+Rvqc2re3oC5kGYoQuihCvgchMhWIrSL7tOGz8XRaQkIcRPVUbVD01Lqk3cU
 cOJZR5u5+rlIiv4IKI97UrgWFBVR+xQ=
X-Authority-Analysis: v=2.4 cv=XIwAjwhE c=1 sm=1 tr=0 ts=6a4c2f66 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=W_OYWXfI53B5t9XIIPwA:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: icBCMChOA1NbyOBUWHzslfH6Vofskutf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060229
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
 tests/tcg/meson.build     |  1 +
 tests/tcg/sh4/meson.build | 25 +++++++++++++++++++++++++
 2 files changed, 26 insertions(+)
 create mode 100644 tests/tcg/sh4/meson.build

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 52418b8b72e..59e71d82c99 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -151,6 +151,7 @@ subdir('ppc64')
 subdir('ppc64le')
 subdir('riscv64')
 subdir('s390x')
+subdir('sh4')
 
 image_targets = {}
 exe_targets = []
diff --git a/tests/tcg/sh4/meson.build b/tests/tcg/sh4/meson.build
new file mode 100644
index 00000000000..2d691a1aeca
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
+      'cc_docker_arch': ['aarch64', 'x86_64'],
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


