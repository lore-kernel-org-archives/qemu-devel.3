Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 807C6C5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 19:28:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwPTz-000694-QJ; Tue, 18 Aug 2026 15:28:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPTy-00063M-DY
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:28:22 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPTw-0007WN-Kw
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:28:22 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IHI1bX1872791
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:28:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 HEeKaz1/agYI9PlO5+THsBLsrl3JVsDXEOowlbiiAWw=; b=DBGp2V9YQWpDDHDs
 lsnd8N82bxjxUVGxkcIfmiTmFXEkNggePnbyYYq31HCWhtmOiPtTzcrd8l5BQX95
 5pgD8TyXMOhR8Re2N1UVwawESNK6sLSJ3LSEj+7pSGi5vR3y2N4nZ9A7wQZCPkcS
 dt7S7e/LJH8haeC+OQEvrunG0D+GeZRlQ+Rs4ckErOm0AByzWDT6aKpCx9VFTl3v
 /w3G6zQgVin5xMZCnRQcLD6zBcdZoB3U+gdLP888dpBtccEa2ZgCcvDxgbplvJ/Z
 eWzjLGMSatlmj3zjjwUTVBDPz9fOhJksifzOUkwyB6w258zCqvEu/7BhUGXto1hM
 osJAPg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4nb1agrb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:28:19 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-38e11baa66eso361280a91.2
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 12:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787081297; x=1787686097; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=HEeKaz1/agYI9PlO5+THsBLsrl3JVsDXEOowlbiiAWw=;
 b=Jo5t0wkbuJFpTfaWpg70XFgd31BZN5POchMZqHZmgRao67pVWiDk6GpxstxD7CU/IT
 +e6h4AS8BhpKp8izgOBZ++6N0TXPlthdcpWtmA6DaEBto/ONhENy36ocMhlDAFz5Smne
 zXZlOOjXrcXr0bZZL+x1/DvHZajwuY/qX0MpnDUOsi5U6+KEUkGbLY3dJHNs2A6VEJRa
 UxrOWX/U0bPKTDluQOC0FoNs4Jb4CHNKJN7iZ+xO8tjJ/5DYwwXTdHRbUZCHNTWBf3aD
 HLfkDjmKtB+hMPPlpdkHrz1H5OoG/D3DNEYSFabQpUUxcNhfJ7Mo8mYTs1/nMRKvrFXS
 JF8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787081297; x=1787686097;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HEeKaz1/agYI9PlO5+THsBLsrl3JVsDXEOowlbiiAWw=;
 b=GXChN9HS9nWYviyJ8Smxw00QYhq+q52bRV56NmEIsLI3uDbMELROhQXaRCFidHKS88
 PIf7xcgH78fd6865hT9URRU1UcwN0c7Ln+YKVC35yhmhtCEhg5m3PdFGDt2ta3m8PJaO
 LgcLj4K5cMHo5ZzKiX1JJrtNN7REb0Q0GvPIR2vy/ckpa4kAuve4T2K72M7kCNiO4pO2
 V5fUCvrc7fK29UjQMBKHa2Uld7bPMuBcqZtRf5qMeIq6+KnNhURC2Nw6snB/4Vuz8tSp
 8klBkLHyJF7ta2xZ3aAsLW3MMSrOjpF24ZbwAwhJKitskA8spIP+NLK2bT4QBu8znUqt
 lUvg==
X-Gm-Message-State: AOJu0YyyJ9AXPUsmq7mR6lIG0LYTXWyraEHVMAaCaqFwoBhNBGlWFGox
 +CGTEqqF9/+M27L96g3GO7T40YDqjLekC3YN86oamSZKia8jygjEx/QlnPJFX0gAxiNuRrwM6Qa
 mbOUO5yxNOwEScbKu1VHY4DknrtTnvJ6m7fdrQpTZLGWlfvWEEyhRScg4d5Kac3yPXw==
X-Gm-Gg: AR+sD13iUSTSY703zb3GukGCGKyFSEqqxLT7xkDIKjO3HKANm85+hC8rBD0uN0s/MnB
 qydk/rKAiR9vzxCkJlCFz9Av5/C0Qm9jjTDZ7ecvw15N4/9lpNXr4J448C5jmU1kyLEt/3AdEMK
 pWfYJquI4ErgUIS4DESvLX5JQ64c6upbqDDPOBengAb4332LnS8dyEJPonvgaNy/u7piITh8YD7
 RDl8ccQW7k30T0/pN8s5yF7SBtram4Y92qNprkt/tYMcR3aO/HOySNC1AumcMLG9R0rcFCP/1YR
 L57NiQZkTe8NwaWPTRZBYI9TQ5RQ3hw97Y0rmCaeBrZkSQEtpAK/mqFH16GMzx6Yv+mAqfHbyyO
 c52NmeyA4xlwP5/7WJYNRVeKSSjM4DxAncAF4h+CyALDQx2m+AQ/xQJ533FI=
X-Received: by 2002:a17:90b:2d8a:b0:392:7f74:58c9 with SMTP id
 98e67ed59e1d1-3957b36b189mr61134a91.15.1787081297538; 
 Tue, 18 Aug 2026 12:28:17 -0700 (PDT)
X-Received: by 2002:a17:90b:2d8a:b0:392:7f74:58c9 with SMTP id
 98e67ed59e1d1-3957b36b189mr61056a91.15.1787081297072; 
 Tue, 18 Aug 2026 12:28:17 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-326794c0c94sm36782451eec.9.2026.08.18.12.28.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 12:28:16 -0700 (PDT)
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
Subject: [PATCH v7 060/104] tests/tcg/m68k: user tests
Date: Tue, 18 Aug 2026 19:22:24 +0000
Message-ID: <20260818192309.22169-61-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX3dILznZVqHRL
 FPpLh0fqWiofgjyORzVQQqTbmh9xUOTfBEFa4K97gwpS2c9AMILrN7a0CKz+DAC83GR4ByZPzi5
 aDj/9expBKivxJY9VDlQNIV885t8LfWtfz7ijFvO6CPKxeB/p9jfnGm5H2BD+ydnIaLUHBhOKcy
 +n6kaLw1k0UoMDy6d1GTxrdCH8VLxfsyzw3BrfR6rBrH/4YqACGvnYJX3CQptRkxaJ7wpg7LNM3
 fg7pRq97nLCqHr8MqbQgIuiAjzURtRCfdFR/HEorwhEITHwq85dc9C+5vDb7TJVzquhQZWZGwHd
 MZS0koq9eGXKkbG1oootDqC5LQ9ZyWqvXbZLVjP0AhtKrbk6NY26AnM3dX0ZgOkzhpvM/OefvLb
 ke16R4OavKpThp9ION79yhPZWYTXGNu3CbwECN5jM+to2YW4t2yVe3lYHgOGw+pp658rEHAlPzB
 gTiAC8uKpXM77/r7ZdQ==
X-Proofpoint-GUID: osSNzB4urET51bT8Op3MBrBNlZtuz-g5
X-Authority-Analysis: v=2.4 cv=Ze4t8MVA c=1 sm=1 tr=0 ts=6a84b253 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=VnNF1IyMAAAA:8 a=Y7GLNXJ1w4EJNdMAD_QA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: osSNzB4urET51bT8Op3MBrBNlZtuz-g5
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX9hLU1gUs2Ck3
 6urjjmC6AqkHcyp3x8WlsQcKioRANXLQNBvWnAD3M4XsueSj03AFWPoaupMyt+jQF2zAT8dEZDw
 ANYZsoSRLIypm/AmGu9dF278/QYt6O8=
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


