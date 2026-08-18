Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFEC9C5DF81
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 19:26:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwPPj-0006wr-AY; Tue, 18 Aug 2026 15:23:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPPg-0006kg-Ns
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:23:56 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPPf-0006fY-4V
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:23:56 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IHI1b71872791
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:23:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 i7lOBJmzAhzCql4OqEzwcbVaUI7nsVb0oELiNNb5eQs=; b=gzCmQIGGhWw7u0n+
 bagRE6qDfIIcZlyBtVHs3keVP2LFPk8S8woAK9z6XoNnNKa3qDMcCar3GnDjkTSa
 W9tKXh6rFVH1wo0xTfuoMNfOcLCm59dXvNKq/3Tv8t9tP2mBsaSnQfZl63X6imEE
 kvQiV4LtWvfbu1oHk/UX9W/XEjTj9rZN6pWmBdan+ocVzX3guIa+RS97sx99MGYQ
 shROWrk0yRWvSR+Bzljl810/mOvFjMHovtaE069T+NAEE0D8KlZPZWcBLEYSLeCn
 h1MWxrAGhFGhNimSYZejSBE5lIUOPrNnZ68NuKDnDX1aPhTuuHSHZkMMZXBvK0nL
 tzrXFg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4nb1ag7q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:23:53 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2cc7e86e7c5so2372305ad.3
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 12:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787081033; x=1787685833; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=i7lOBJmzAhzCql4OqEzwcbVaUI7nsVb0oELiNNb5eQs=;
 b=VQMQKKViLEo7RBvly5cArnnR+ElmqBigyrpfVhpclRbL2bJpW7rLuuQbAenYT6s0eg
 5wbudPuKiQKxBdi6cPnhgpNOe3y5lHN2Wd1zhU199PtkEV0uV8+j6ItAt+b352jTjxCl
 0Q/gzkDUE6Bj3D4Lm451d+lXigFZdVeJLGOUOKwKw/GdrEFFoLkyIOq9Cad9Ug0D8Ktq
 N1U3yY9ZnFLyyNYDImZbe22ewnHioFAyBgLZQgXrMaZYkMwF0IiVWL5LaRHbSiaFKffO
 8vMPTWJGt7GNsfqv+/q0tw62qqDNWYkffCZGFVUv7b5NPYbVY0my7NGtd58uxS1Njjie
 XSZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787081033; x=1787685833;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=i7lOBJmzAhzCql4OqEzwcbVaUI7nsVb0oELiNNb5eQs=;
 b=PsKymbsYj3TiBsOANDe8leMzpWUjsS3W/ezwwAURlrPlamoOIqjbNd2d/ZXF22YI44
 grlI/VGYsv4bZYEnNrpaPWcF+Ut31Rdx8Obrs72NSADPkULT1JsKmsVMKxgEZi4YYJaU
 d+pfOenu3w0CJRsqRgZN25hdvXB5RmvylOFERy37F9J63dSP8+zYQDVIoOcBBnIP/JsW
 GGe3/iSQrlwT14GYKR2dNWSx2ydI/7ekbU3ALZWd4b7KDHZG1X6//cmWQIdetZoDioDZ
 QXrWkHDuPNyNG/FTdfDhR4Rh54mjcikKAuGcUrIBjg1vV0pvp+irvIJvjpeVQ5x7W741
 aBug==
X-Gm-Message-State: AOJu0YxXHwzSjv3u+GjN4phd0uxKzs3WcBCRkgfdIgjjJF/5VY3VGIWC
 nfH9Uml4PFNkULXjcsaZB9U+3/pnguzp/mdtu1/vJpLh8Dr5EgAJTYWCZyctUuTAWykMvhpgqXH
 LYGqu40wxysTEbeE/F4cEFE7TZ4Zp8fQDGwI2L8+5AXyiClzyjAoqx/Dd/zuRQUI+AQ==
X-Gm-Gg: AR+sD118vy1nDZYNiGEiocyxZnh/v7wr7a81n6behaxwIZ08PS4pEg4+yTlKUXwdK21
 qUSlQSF1C0yi3HP6BTxA62BZNqQhkemxEi/9apcNt/p8mr5Vp4pvMdK6VYsfT2TfzC3qvlOH7OF
 92TZst14hBj5B3ijWpdGjHLpTmJEqFc5WP6mnryFB/z609gV7+KgjSs58HPQfVC9uHgqDBYZKHo
 sfq/XtyEdqM4KuGtounhap0oBZhSiwW+y78t7jUSOhAI6OPiNEmyXFfSsBGQ5GC8pI35z30BRFR
 Y7T7kc4LDC2oyJus9x71Y7NoqrhV9gS7Z+ffwV2e8xCF/GxZ+tXntr4garHrBTh7X73+1555d4r
 5OAopB10vEzDFJdF0hSjqq657CekBkojkLoqHcQMJ7pmHAXx/CF4o6AlFFOg=
X-Received: by 2002:a17:903:1447:b0:2ce:faa6:7cbb with SMTP id
 d9443c01a7336-2d5f6a5d8demr2758465ad.4.1787081032717; 
 Tue, 18 Aug 2026 12:23:52 -0700 (PDT)
X-Received: by 2002:a17:903:1447:b0:2ce:faa6:7cbb with SMTP id
 d9443c01a7336-2d5f6a5d8demr2757815ad.4.1787081032300; 
 Tue, 18 Aug 2026 12:23:52 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3267c897e37sm21879429eec.28.2026.08.18.12.23.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 12:23:51 -0700 (PDT)
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
Subject: [PATCH v7 024/104] tests/tcg/meson.build: move gdb_arch support check
Date: Tue, 18 Aug 2026 19:21:48 +0000
Message-ID: <20260818192309.22169-25-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfXxAHsJuxeYg6m
 8bv7mQXgdEx2hEHfKvtIXZ9sAM16/ATPTBATVWLgIf2EA/IckYMSEejTQ/HtB+LBCtk+NtncmZU
 YkVCnZyPINPB4+lvJDT2mb4C9cF9qJOvMoiCTcnDnOgkmoZCuUqnYK+MSXk1ulvwvosnmMYsXsk
 0SKzKNgH9fhnOIs2yHAjhA1h+JcUN99sQfLDNlrtYzfcBgBDLpmZbH1i1gYJt0I5G+whoPZhUQb
 mEpfA/p5ByVDrH6hhHRtMLuo3bXatnoDNv8e+ydWF0rmbWCdeKv7IoSvlyTBqr7x2Xdc2hNitgv
 AjfBl2cqibfUK6sPjfZD6ywACe7+JWkONYILthJ++dA46UHzLT6EI3bhPUhtuTb/7ZvvfsdhyZO
 b+Ezsdjgv/3VCBpQl6YxFNtQcniEkh4TOA1uexiJui17wFSZB9ASTBgFjKAPMgYkdFNi+pNg91f
 jkUxZLKspkDkcrXTI9A==
X-Proofpoint-GUID: ycXHkkU8fq1hzw4fZP3jdYxQyVu2U_pa
X-Authority-Analysis: v=2.4 cv=Ze4t8MVA c=1 sm=1 tr=0 ts=6a84b149 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=EUspDBNiAAAA:8 a=XzjeZAZuwW6bxlwlfogA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: ycXHkkU8fq1hzw4fZP3jdYxQyVu2U_pa
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX8xAcvMoTjWbd
 Gk3vP1DkmkBz9bCmbst++anR548mxu2WwUopstpi35ulrVWs/apHh+rmz4IU8eTsG0kX+R9zIX2
 WmX6ZhAcHK0v2zDplsTC90kANWNh+H8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_03,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0
 adultscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
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

This allows to report the correct skip reason instead of saying gdb does
not support a specific feature for some tests.

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 7384786f7f8..c227bb52381 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -138,10 +138,6 @@ foreach target, plan: tcg_tests
       # if set, we'll skip test and print the reason
       skip_test = ''
 
-      if 'gdb_test' in setup and gdb_arch not in gdb_arch_supported
-        continue
-      endif
-
       if 'plugin_test' in setup and not get_option('plugins')
         # do not use the skip_test logic, and simply ignore the test
         continue
@@ -284,6 +280,10 @@ foreach target, plan: tcg_tests
         endif
       endif
 
+      if 'gdb_test' in setup and gdb_arch not in gdb_arch_supported
+        skip_test = 'gdb not available for ' + gdb_arch
+      endif
+
       if skip_test != ''
         # still declare test, but skip it and print reason
         cmd = ['sh', '-c', 'echo "' + skip_test + '" && exit 77']
-- 
2.43.0


