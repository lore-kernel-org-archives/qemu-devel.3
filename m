Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2322C54F53
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 04:51:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woZlJ-00041B-DS; Tue, 28 Jul 2026 00:49:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZjz-0002mX-C5
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:48:41 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZjx-00028u-MU
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:48:31 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S3tp3v1919982
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:48:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 aKCo7/gBa09xq0KaXOtY2n+KfO4wDlVGcMcZesOjEko=; b=ZpwzNesIditClByx
 TSMY314bzXdYjm7qa59j/lqvkF/rwke8TBCXouur5Hij33zhmuxQesaZCCD0h0bS
 0IkG+Trrg8LReJGkbSyh0e3v548yne0+p974NCG0I/vpxy1jINGfhF6OzfvjX1pM
 PKR12MODGplXlIGhXW0jBNIp1uym2YdEn628M1qVblJ+fc5DWsiGDpqhFi/kBNeI
 VDtpTQWXJx9ZgmRPrVCShzdc47Tj3JfFtVRLR7TLkZNi1mpyL5fLo+jO7Ru0AkjS
 9Bs0tMKmjqsZKXbeA52GZyjIYHexgf/dyp+5G/IxKE8DbjczD2h0yuXuh+865s4k
 vD3mpQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpmy104yb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:48:18 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-38e7b87ce77so8351337a91.0
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 21:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785214098; x=1785818898; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=aKCo7/gBa09xq0KaXOtY2n+KfO4wDlVGcMcZesOjEko=;
 b=Kn5pf8HAJzfgMWe84h4kS85c6T/s+uSvCFLxlPtWVm9b5RUFQ3hysE2FVDe0wfMT13
 p6V/mrY0k+/xC5wwSpgq95hyRJk+LoF+DO1dldcKH557sEK/iHWSU1JcPZBxaw98nrIx
 s0yVE7MzHmspd+6dVLsbCLzdfXg95FotFcGpbPFDRTDJ10hk2bWWtonlw9rbpz4F5uxs
 pysTgZTCSiDqtgs3ksQnH4kv1mzfCnGlsHplanYJgPqihj4GqedUkD9/FCGLWBImCsOE
 1or8I6nWRZBK8lI87b4JfXjZXUe26owOGX4dAousXjJZ8wz20YXLlI73e6u5j0Pi7hPx
 sxLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785214098; x=1785818898;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=aKCo7/gBa09xq0KaXOtY2n+KfO4wDlVGcMcZesOjEko=;
 b=jIwBxFPgvH7hpJOREYhNr/STq5+OjH5rCRB2sDxycOsN8xR2cyX3z4IocDIc5BfIue
 QonTA2s8ZpTCB/vAoKxv1FL5VorO43QFJ1O2WoTHRmZN+zOHGZrp14MzkqCPb3SdZVsc
 /pW7WXbU9b9aSn5+eKiEyBZXTjd+lqEQrmHKcaIwvXYbFrC5MmeLIsfs1df3nZCtDgmn
 Sh2G4SirLrNpynRWBZcT2KryREOkzdATONfM4/UGOg4wGcour8POy2QOlcv5AYazkU02
 6cgSXtTIoR3UK+xii8jYW62Zm4V2Hg3oK9zcCUO+FxGn/pF3Q65fPxkJnxMkMBIxP+Wx
 X7Mw==
X-Gm-Message-State: AOJu0YyNyuyFdk4ltwoE9XaHqPqqjpDtPxB0/XD16XJbj53tgZjQjqTL
 rZ0maFL0+n2izmnwW+XoZ3csbBjLrjGOijCubEP0HNI9Ny7bXk4tDREyOdG2w12WmMtCmWcplSO
 9JwerX0q/aothUxqGQYEuUNvitq/mhFuwJV+XYybE9hH4eX3E+JLerzFwhLIIPYGwaA==
X-Gm-Gg: AR+sD10cQamiWo6lRPsFxSZPxZQXZBs3anOJyMany8MNYoAGqmO/H1B9M+jGYWIIu3i
 V4rqA0JLnqDgJNiClGT/2mIgSr7l5b8GLkBXYp+8KO4VlViK2l4sUL9hBk2795dpiM1bfbneysV
 9PlgmEKmIDYP0Pp8GE76s9zmnMf35S4H9YVJ2A61AxYbdhmQYFYYWBpT8BZmbx2RzM8dPQaiHTl
 vniyrsmzCyYg9DexmacpYt5x6/1SWcedG+qdnhe4h7SB53awK5bMkGa81wlZAyjCCuR06sb2qch
 eenvLY2N0cOj71A7NRYyyqXmsYrWMn/8WNbjkyZIaAawDOHOSErh6h5n7xxPI8haGdvidKfq+G7
 hPDQMgzLVE/9Hk5exeZWgUsb2dvIRlJa6GHt5nU/k4GcKzTfTRnXfUL/F19DqV0/WiAYuvuY=
X-Received: by 2002:a05:6a20:b40b:b0:3c3:9a32:70b6 with SMTP id
 adf61e73a8af0-3c8ba5d8fdamr1153528637.44.1785214097825; 
 Mon, 27 Jul 2026 21:48:17 -0700 (PDT)
X-Received: by 2002:a05:6a20:b40b:b0:3c3:9a32:70b6 with SMTP id
 adf61e73a8af0-3c8ba5d8fdamr1153503637.44.1785214097449; 
 Mon, 27 Jul 2026 21:48:17 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13d13003f12sm103090113c88.2.2026.07.27.21.48.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 21:48:16 -0700 (PDT)
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
Subject: [PATCH v6 066/103] tests/tcg/mips64el: user tests
Date: Mon, 27 Jul 2026 21:42:10 -0700
Message-ID: <20260728044248.137626-67-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: cA5yQSVSS3nVDh95595KdqiGf29on2Gr
X-Proofpoint-ORIG-GUID: cA5yQSVSS3nVDh95595KdqiGf29on2Gr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA0MSBTYWx0ZWRfX756SD4URaSDy
 MDjZqdSEVqmZhuQFA0MS3zKEpvj8Xv3v/4idP7yNMePAUoSYSwmsrnTlxS4Bu10YxYLNBbLgEGG
 spte7y87nfQZtPLaxwoHvCLUgrn9QsmNvfEaumZUIVVpTGsODkSXE6WIEmYNi6s1FrJN0d/sie6
 apaE5HRb3rODjfHlO7vvu1CddIICc89QmUGiaLyFGcjfs3wuVtZSNJqT77dIiGXdHbraeSlxPK1
 A5mH3pVKVUlm5YM+x0iLlvQUBSlapWI6lm3YKmPw9hQKZC3/RDha1g///8CWxDqyrz1tW5Zfzqb
 z5WiOP8g8YNhV+2017+2j8PNgp4tFkdqyPreh/IIr3IYWOaS5YEBP7fqIW3e+b84XRFHT2upIb2
 u4EfJfCAtjSK7kQZHp44OObHeAAmdt8JXHQiTUX1icgVQn0IfLjx23lwKKO7CXmvt8InknkWVZk
 V5J3bA0a1LUoxo3lJuw==
X-Authority-Analysis: v=2.4 cv=PJo/P/qC c=1 sm=1 tr=0 ts=6a683492 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=MTytrtsdTjBmL2pvzDgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA0MSBTYWx0ZWRfX2F5Qjicl9jDL
 PlmbbeZJCPMoC1ORFl6ExOAYJbsjSw6OAM7p5WuIrNHdaDK0igkBO++5YsUqvMkUni5W4GUPnje
 Llkfwyz9FXipZkmkaDz4P0uW+9RfIwc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_01,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 adultscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280041
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
 tests/tcg/meson.build              |  1 +
 tests/tcg/mips64el/Makefile.target |  8 --------
 tests/tcg/mips64el/meson.build     | 14 ++++++++++++++
 3 files changed, 15 insertions(+), 8 deletions(-)
 delete mode 100644 tests/tcg/mips64el/Makefile.target
 create mode 100644 tests/tcg/mips64el/meson.build

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 0c3e8b05156..d7a805428be 100644
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
2.47.3


