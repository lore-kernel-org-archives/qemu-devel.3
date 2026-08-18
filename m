Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DC97C5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 19:31:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwPUF-0007EP-Bl; Tue, 18 Aug 2026 15:28:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPUD-000756-24
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:28:37 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPUB-0007aK-9c
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:28:36 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IIaaX01940450
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:28:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 MCllqz1NEssJ+ohs5qNFpMchp7v26zFsVCg5Om93BOU=; b=S5Qch8/6aLZjjRV5
 dcaQGOz6/F7HrV3TFlJU1/RsVZG/uR/lQ94KDOT/rqiFT0Wr3vVnaBHRbxVoYVPR
 bn8gXuXqRTlAO3amE+FepNt2F9fvEHQAzCBVIOILKoJlRMknDrb/K1+f9KWWpHJJ
 uN8LmYQCbDczpkaIPqq4gaiOrWiOGm2rOwnFEUDXfnTTJh3DdP3TseAFuTuiI58Z
 hTqWbbv9PnOw3D47WX5vupOfyLK8+UTXgUFuazEjBRW9JhU7h88b1faHkZoHBlSs
 YxuKHzVYtYbJPh0Sr17YZatu8/SVM8UxZqtcSjAXQiK31WoBZqnbCNAShIOaMWmX
 NgGLoA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4vtu0664-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:28:33 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cb7d6ba548eso181052a12.1
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 12:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787081313; x=1787686113; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=MCllqz1NEssJ+ohs5qNFpMchp7v26zFsVCg5Om93BOU=;
 b=YtXPAfWeLNr8CK3WuqYOWEt0eRE3K+9cJ+HivQ1plLn2ujZLb15+2nIeTSdSmZpCEc
 JCusJFpbPdRwITfSmKN95JWdUXAD0sFTIRPl5FsJXPA9IDpmVtq2RDs7Fo/8kaIV49gf
 Hd7z7x9hkVsTp8MLVRP/fybMijTD4XeZE28u1wr+X1slguGw4zNhq9cZou2eggfJ21VJ
 T2HjHJDP7tyI8XfekvWXLp/gIjFykYwBCeGyoyrJYbnYEzSpcVCh6BHf5MvreIoubQUk
 hxKRC4D0hDoNKy1Ho1XS6isFRpev8FI4sMU/W3L+KPAxxoBaTCs3rlxeCNFlaA32gg2A
 btTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787081313; x=1787686113;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MCllqz1NEssJ+ohs5qNFpMchp7v26zFsVCg5Om93BOU=;
 b=SR9BGBHtwZ7JOlD6+vMq0XO1aTWgF0rNiWwd5zurnMEJ2ktmkhsUAh0k1Wbx0vvSVY
 LLH8mtSOitdONPZHw642e6pvvGa7Iwr7rR5cMnO+t7pDOTVyO4DQGUTx3ldrd9ZTy8h2
 BumkvdFgbs1iqXG2lUdPCmqeZptkqA7t0+oQSLe7YRBoLPpjscbeEbJo4NAUjmsdioVq
 XItKv9A/bR0CEGS7aYP45lZFy48tuP5ZlD9rrV0j036BubDiYbXtmvQ+mJ0e55gdMPRb
 9s1SC1VGfQCraktlLRlnGkTwIWI3akiMwIv2DhShsa78JlzuE9/4PrpYi9EefAekZ8pn
 OaIw==
X-Gm-Message-State: AOJu0YxoW45oWcGoWNkBzNKaQ/FljWiV573Xv/zqiPp0HJXCjQ1v61Wz
 /eJePAgRPNhZyXZTlRodK3fl4/xelzdAv6unw7BduA5E1cANsWAOfVikQTVO6BPmSkLa2Lfm7Xj
 e2YwcU5smVaFvPlXLrD0/D0xsSDx5uJ4R6y/E7yy1g0rlv1AshyF0/KNBDAcSAQH9gA==
X-Gm-Gg: AR+sD102sk9234nMH29ij79fR9UmgC8QYUTOLfkWZP5BV1Z+/fv79o8O6MCV70UG/pH
 Qp1SG3wUZPmv+tGPXJPXkVMxaw/VoGaTFLIg7DFRL31mqilHHwzx+bhNmHAwr5MCNLEkniMrBG7
 6cJT+CGxazRZ8xYFdVy0+MZYmMKd8YwQtS8HGBg045BevohlvQcPBmNH5djEhSddC+otnWpLvjS
 bSpoIfULxMiEsiB9f1K76PoVCL3Fef3By6XErvepI4MyMvPWOCufeGyWbzUggj4H/lov2dnME5i
 4oY2l8q7F4tUkxjhNnCizVmFMR0/cV+l82QIFRS6xjjPxjFSu+UdnneYMGytm2jVyE8eM0FmbW5
 cQTZ+Gb6976EPmsA8Ird1iXy0ryVfNz9Flx3rwRuxOUT6XQbHP6RXSzpLlKQ=
X-Received: by 2002:a05:6a21:9995:b0:3c3:b57b:6291 with SMTP id
 adf61e73a8af0-3ccff0ba9aemr155049637.18.1787081312735; 
 Tue, 18 Aug 2026 12:28:32 -0700 (PDT)
X-Received: by 2002:a05:6a21:9995:b0:3c3:b57b:6291 with SMTP id
 adf61e73a8af0-3ccff0ba9aemr154974637.18.1787081312229; 
 Tue, 18 Aug 2026 12:28:32 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-326794c0c94sm36782451eec.9.2026.08.18.12.28.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 12:28:29 -0700 (PDT)
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
Subject: [PATCH v7 067/104] tests/tcg/mips64el: user tests
Date: Tue, 18 Aug 2026 19:22:31 +0000
Message-ID: <20260818192309.22169-68-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: q_iXxvXCnENwN0ZiD5uRWlWtI1b-yGNZ
X-Proofpoint-GUID: q_iXxvXCnENwN0ZiD5uRWlWtI1b-yGNZ
X-Authority-Analysis: v=2.4 cv=FeYHAp+6 c=1 sm=1 tr=0 ts=6a84b261 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=VnNF1IyMAAAA:8 a=MTytrtsdTjBmL2pvzDgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX6jV9FaA/uT+c
 /SsbrdZGVif9WP7K6pM8hs59XOjPvAEFGWMgYz2czeEm3IYpTvlagKZ1i1mO5M0NiVkoG6oKOXE
 QV+Znw0m9D6ZoVkyN6xP3Dhu3as0LavA1J/Vzc40f4eEcZjBX/DUevHgVj0CqURvTy3RU+O5Usw
 6BWTiocr1V3bPy3qpj2M5EME6yGBkLmuIscrHe+DZAdctcPTtnf4TGkS0PV+1zHLyqmzWSqBF1j
 ePcwQR6SYIjn6Z6E67VB4tNQXaoLTC+4oybK7vhj+LHoDRmWj7Vcr5YlM+VBWnCHCf+SM+zOffj
 9RdvwV3CsovzEh2H9sYI93ZzoEenB5de3YwE1e+mlpdFDnbP3/YStjZ4ljjXpuw1Lwzt/9GBbqj
 fbSuI4qAUxFxYDRaT5Sqrz9rodgy5shItXlGEZO9CgaP5N3tHY5rMx/Ghy9l5QhkKZqiYugLo0G
 9W2tdTWFbkqHvpbangA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX9dSWY6Fjleby
 6murKgsx4ziV/7MSBa1d8GC4vk8DpovGMhPjGL9WSvELjY7vPl/0i/S0TMECDoANYGzp0gFTYPP
 biphGYoqkNg4fKvSYjWNzncso2Nl6RE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_03,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 adultscore=0 suspectscore=0
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


