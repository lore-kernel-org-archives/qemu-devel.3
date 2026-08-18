Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D152C5DF81
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 19:34:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwPYV-0004GU-KJ; Tue, 18 Aug 2026 15:33:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPYF-0003sS-Iv
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:32:50 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPYD-0000Lq-U0
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:32:47 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IHHISG1454934
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:32:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 lTS2GE5Re7lVKW50PR5c27qyec0t3SaHaPOu+r2mSWA=; b=mPbObrbRkjKLmB8q
 gkAVndGmTP3TSswhOND2tHcLNuRFanj4mOJQSP9SBbDvLtgZ0m6H3rZavuLGU0cu
 dAvHP5G5mEDzenBH2OiVln9DjVOmpuHGvTJfQgh91U9/rlgRpOpq3GX6BcOzQ9H5
 4NprwIKC//OtqUeKPSC7YiyLmyEOetncTAAbtDhg3MVokjyfEHqd7siH4HJfbnUU
 s5Vg/TbLn9bHYgic0zTQWUpTz8n3RanAhHa7lRVtQOjTuv1UrdgysokRAy1QX4j2
 CT/x1uJqih3ec8bStwAbLB3P9CTvMNESNs87ScVeIo1x+GYoz2FD8UiU2y+Q4DY5
 kxNgIw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4qxj1vtm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:32:43 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2ce7dff6253so14550185ad.1
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 12:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787081563; x=1787686363; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=lTS2GE5Re7lVKW50PR5c27qyec0t3SaHaPOu+r2mSWA=;
 b=A+PWn+7PE172JPGkY5JetHL6L0aLE4YkdEtpB8CdZU92FIuwTZQTJb/EliZPoOSBD5
 mQoEkPh4th7MYFcCjvKXM+AAzcI7w+smp9N01h03FeOxMAGg4IUUEm8AC5qBB8pKLF7q
 +jSvCkLIbqhoJ8s9Y19XrY6Oc5peLwwrOWrlPgflN59i9fPMLACOlXCUFpC32s7I0n1q
 vAsXpfdWmxfV1xizH9OgDY33TYAUF+zzrrTux6ZlMSxS2Vv9mSTbL7lRR0R2wjgKUzXS
 Fno8AUhh2o0/PvIy61mZXMnmx54kK4ubi7qB6q6G4iYYSTVLPYQD87A/IttC41Me7L3Q
 EapA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787081563; x=1787686363;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lTS2GE5Re7lVKW50PR5c27qyec0t3SaHaPOu+r2mSWA=;
 b=HAPqQHkQQ6H67UhXOcpIBtouS8JUJ0W/R58MB7Kl7QoBja5AkDFqhgbflZV9qV9M3U
 jk4fiZ5R6vBabTvBa2ivyl+o+sxtrAJH3bA8v8N87Mi7i1XO6pXbvPLWlv2Ns/1rq3+G
 sgQGzQd8jPZ8Rcvr3dJymcZp0QptBgFe6HKJjfkjss0WmkYyQTFl23FPfWgPRqrRLXfr
 9gXIcUF5e19FLbgPo4VCJyVylBRNZEfTXSNLLm+FHDZWT1D6C7BFzEeOjqol0O0X5n7g
 s4v/ThEDeigr+m+TlxBJ4c1YUTS1X3yV1Wiu1a6HCZzelverG0ls5veYwLKxTtF580Vg
 Kqjw==
X-Gm-Message-State: AOJu0YzmxRrQ4i9Gba7tgKn5cbOf6xIiY+JMzgmo4utfg5lKaPd0Brqu
 U+Dt2e6zEwdpeGysmca/Z+LYunEz0lVW9D/H59RLbRCkgFMHDKbcw45XGYXgQtMe6oUrqSNJUmg
 9OB5fDl6YYOI9NX/ecgekyNEEx9UgkObAILwTmq7pHWEPP7g1aaQyCMcvWpLyyYQB/A==
X-Gm-Gg: AR+sD10B65z1IKnDUkHQznx68t8kG5XWdYypUAHTpYKYxp5XwiJO/WAT515fIUzwjjJ
 zWnbmUjRexJ5uYrKTSx6+YZDVCv5fodDeaRmll9TtsKbruOjnZtbT4XeTXAdJanoUytgXzZ8yD2
 3NXz/PfkwYKRUNOOMQd8z6EaVUC3x2GJD018KX7Gk1bon8ZaM1Z2RwyClQ0h3RgzHRnzYGkrX6I
 lsxjCoWrZN+Jgx1E2bReEaEnw1WlLTrU9pzQ4MZPqI2gLmVyg+k5WEaQZVrGRj9upCkHi/TW2Sq
 +al0BFuqeMEad2eHYwAIdOKXMlnK/EzVAf77ayhCO62IaEfiZQYtMZkiOB0Kfm7+wf+pxW/AOCd
 GvLhzs4uJ5yYB5FVRIPV2xGEoC+gI0bwch2tSOdBxymG6YZcHD9/y2hE05Xk=
X-Received: by 2002:a17:903:1ac6:b0:2d0:401c:2edc with SMTP id
 d9443c01a7336-2d5cabdec7bmr90851145ad.1.1787081562609; 
 Tue, 18 Aug 2026 12:32:42 -0700 (PDT)
X-Received: by 2002:a17:903:1ac6:b0:2d0:401c:2edc with SMTP id
 d9443c01a7336-2d5cabdec7bmr90850785ad.1.1787081562116; 
 Tue, 18 Aug 2026 12:32:42 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-326798c566asm21877135eec.11.2026.08.18.12.32.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 12:32:41 -0700 (PDT)
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
Subject: [PATCH v7 096/104] tests/tcg/xtensa: xtensaeb system tests
Date: Tue, 18 Aug 2026 19:23:00 +0000
Message-ID: <20260818192309.22169-97-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX8O5Y56R+N6Hk
 Y60njow7sHs2XTr1pMgMGf+9fIisqgab8N7o4OUUYfziMJCSp9EVmOjI515KQPIlY8xLxdEt3GU
 4BjzbcrBG9fW3Ir/UCsWymWcaIfx7Fo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfXyHlcqjTj4gbk
 bU7j+izgjLSYxw66erTjAmx3/XjzoOV4evwAjyfp0sC5EJGX5Ik5+yqjdTEK7YTS3dIinrzwwDX
 i8le4gP5id68MNvdkgD1JIRF/gDFcBwooyseddAJx2v4G2cuMin5ozzGc/eT5w+otP4hu8EbDsD
 HbENY+FgKEkIGkI+7ZMVZea9CBWpsCEF6ngcFLFF9cDtCziOP/Eq23C9Pn/zTZvbcXof0AYtMrz
 awn9W39buiUQV5ncxVjxnFFr1U+U4ONZ2To4Vsd80ia4JTf/bPleVgGFn0npW5HAS6FqOv773l2
 as1p4ZOO3srolrGZw8mF7drqNPVgdSUSQXJfZ5cp5l7rScsSi53giIwLdsJet4vc6VpguaeovsL
 FOno3LPzej6tdSTyF3jBq4VqTSjCxuysXpRgaWJ32sZgy2QdGDs6ch+ai7m9RhyJdJ+ujfYvyr4
 RRWED6hHKD8v3zlzj8A==
X-Proofpoint-ORIG-GUID: Nj0DSxp9CE2FS8W4BtTWvmNeWeqbWL5Z
X-Proofpoint-GUID: Nj0DSxp9CE2FS8W4BtTWvmNeWeqbWL5Z
X-Authority-Analysis: v=2.4 cv=bvB8wkai c=1 sm=1 tr=0 ts=6a84b35b cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=VnNF1IyMAAAA:8 a=Y7GLNXJ1w4EJNdMAD_QA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_03,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 spamscore=0 phishscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180142
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
 tests/tcg/xtensa/meson.build               | 16 +++++++++++++++-
 tests/tcg/xtensaeb/Makefile.softmmu-target |  5 -----
 2 files changed, 15 insertions(+), 6 deletions(-)
 delete mode 100644 tests/tcg/xtensaeb/Makefile.softmmu-target

diff --git a/tests/tcg/xtensa/meson.build b/tests/tcg/xtensa/meson.build
index 339a9a1294e..bb1dd1542e5 100644
--- a/tests/tcg/xtensa/meson.build
+++ b/tests/tcg/xtensa/meson.build
@@ -1,5 +1,5 @@
 tests_per_core = {}
-cores = ['dc232b']
+cores = ['dc232b', 'test_kc705_be']
 
 foreach core: cores
   tests = []
@@ -94,3 +94,17 @@ if 'qemu-system-xtensa' in emulators
     }
   }
 endif
+
+if 'qemu-system-xtensaeb' in emulators
+  tcg_tests += {
+    'xtensaeb-softmmu': {
+      'cc': 'xtensa-test_kc705_be-elf-gcc',
+      'cc_dockerfile': cc_dockerfile,
+      'cc_docker_host_arch': cc_docker_host_arch,
+      'folder': 'xtensa',
+      'gdb_arch': 'xtensaeb',
+      'qemu': emulators['qemu-system-xtensaeb'],
+      'tests': tests_per_core['test_kc705_be'],
+    }
+  }
+endif
diff --git a/tests/tcg/xtensaeb/Makefile.softmmu-target b/tests/tcg/xtensaeb/Makefile.softmmu-target
deleted file mode 100644
index 3df131acea7..00000000000
--- a/tests/tcg/xtensaeb/Makefile.softmmu-target
+++ /dev/null
@@ -1,5 +0,0 @@
-#
-# Xtensa system tests
-#
-
-#include $(SRC_PATH)/tests/tcg/xtensa/Makefile.softmmu-target
-- 
2.43.0


