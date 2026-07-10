Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61F55C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 21:52:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiJ6a-0001K8-Vq; Fri, 10 Jul 2026 17:49:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ6W-0000oW-Pr
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:49:52 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ6U-0005BJ-PJ
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:49:52 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66AK3BxC1830531
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:49:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=eVO/kLvl0po
 ft9NnFXInklCUvb1//n0VYM7c/eeODCk=; b=ZHb3u9y83OqXyZ8XirFgV468ocv
 RdXmZbcuiAVfbJxrvXO+1oo6teuH9fnpdj9gi+G9prX7IWs0gK7sVL6+UGI+f9pd
 fJQ7UCIDNhea+qE0jNbhQOkxku6T+xVP5AGQDpvXioz70yr0BqoLHjTibVWQDb0Q
 MnWhfIr1AoHi7JQaFI06u+/2CtvZgq6/LZdUutPflD/gYsb16kMxLkKlUmsoCjHz
 tZuIN+N0TliRm54s8S7bPhdU/nSQGYP2wKawaqkLtcrqa8lciG5Bw83TSKrWbkKV
 llaDaMqOUzuGOUhM7k6MTGHmRlHNNCu5n6YNQJ63sMXfuHog8ZpqNcv12lg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fanwece51-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:49:39 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c85a298cd62so1089984a12.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 14:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783720179; x=1784324979; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eVO/kLvl0poft9NnFXInklCUvb1//n0VYM7c/eeODCk=;
 b=ABn/c/L+dX0AS5lcRGoOAV++CKBrYMhRuHip4o8q8V2nDuEgDOe3nw3rzHxwkmrIzg
 3Pev9LsH6rd7XEXIpPGvr2OkhhQDJXzi+lFMJwCKpezydUzu/yXi8aEjDrPKAKbc8xKK
 dmMLEaW89OTLuB9kUjOH++Ghe+Cu271A+6iZHg5SgtiN2sQpc+XzMSAeY2MZ/fhgfODG
 Ny7vdQgM/GKixPUZ6xtVpXa3bIiUQT/u0XTKBGQh7fwKfBkqV15DmrbwjkQ1g+S05Ywm
 Fa6NdjTvttcmw6UqDkgoFW2RQhnVa4Sl6iDpJLFH3yxDOhsnWpHCNoKJcG2RSbRCUdnx
 zPuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783720179; x=1784324979;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=eVO/kLvl0poft9NnFXInklCUvb1//n0VYM7c/eeODCk=;
 b=LONlwI021N4SPKEE/SFWqSJM6mkOVrjugPaEN4CxD5MGEDGDcD3/+GqDQZQjIvOu+C
 zVOunMiXulgpVpMsQmbsMYcsSJ/CdYL/nEQhRTmbvmKu8HFdAOCduqtind6aUvgQLyxO
 5MKGkGsUgxpFwMiTijF9emZWfOyIz0t76L/nRliUI7gWxCut+6xzhIIwLOlAbBI8SKPO
 BuPx9cv70Q+isGgaOAKboiFrtaWN1PKHG2I3yK4GNWwtgn3yfqV6ra8pje2GqxK4Odf5
 c44P11/Ep9JdZ3GB4vlBw1+n9uFOXxiYLygJP4M+dHcJtULSypqjuxie9hZ63rHRmmDv
 j5zw==
X-Gm-Message-State: AOJu0YxBgqOXOBEpv/BSK3yZ71CUNgk1TtlP426X6av1m4UUhUaw44Lk
 lE5dGLGBfEbVke4YNRBrLwHd2W1ZgZBji0kqC70SzqYaR53NJQ4n6dOX5ZNGRCf86Vh2LiH8Aay
 acuDQ5YKF+LlmUZ/bcimGt0bURCeVU4zxaxi5ZN+K7+RS0k9e/xpg58zqMzzk9i9NUg==
X-Gm-Gg: AfdE7cnorOEad3nBOvLbDR86HbzYleXoEhG9fN7BmZGGEqLdLV7nITMYzdJsATLPOx8
 HGcKpLZeoMFlnH0FaNAtoIgzLuj68dc+SMUmLafWa4hIXc62Hu5gPnnChd7Q5z6BjTJFUrgpZa8
 znwoObiiJOl5QIq1wfrBAfSWurHDRPF4b2j3z/N3VgOzEcGRBgjP2oUKjH3AbCoifn6gmBzRA5g
 zuJ9/rOV0AtUxF/nQ9bp9Fsm24ZQkzNwwxdcSDuEbGLUDgERa7xk1WNp4d757wbo2sQYOhDI4cl
 w3R95e4PwnBw4lPBnpEy+v0dT7s3gUQd4DfD7RTZ58NiuMFNyca+LI6EQz6mDY1x5wy5hH55Ix9
 zzxwpboenY4+vv2Mx+TTp4BGtb+HAgnRWE8B2Pg/1KMFiWnOQjSnXsJROaXxFDMne75ozzh077H
 xFcSN8oA==
X-Received: by 2002:a05:6a21:e083:b0:3bf:d62f:44e1 with SMTP id
 adf61e73a8af0-3c110b1e431mr724429637.53.1783720178678; 
 Fri, 10 Jul 2026 14:49:38 -0700 (PDT)
X-Received: by 2002:a05:6a21:e083:b0:3bf:d62f:44e1 with SMTP id
 adf61e73a8af0-3c110b1e431mr724392637.53.1783720178185; 
 Fri, 10 Jul 2026 14:49:38 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-311838c9235sm39886355eec.21.2026.07.10.14.49.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 14:49:33 -0700 (PDT)
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
Subject: [PATCH v5 76/98] tests/tcg/ppc64le: user tests
Date: Fri, 10 Jul 2026 14:43:20 -0700
Message-ID: <20260710214343.2065491-77-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=LbIMLDfi c=1 sm=1 tr=0 ts=6a5168f3 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=29g3_fvkp8nbTr7Nl2YA:9 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIxOSBTYWx0ZWRfX9Tyge+6p8nqe
 Ri3ImQfg+zLm0Phph0wpx0SHpKy2IVZCA44rfhGHcotEvHxAP8aXu2saCMjQe51m4LvHtTZd1Mn
 H6nGHdKk+dIpIz4TY9GWQGPoETfRx+vpCnD8eq3d95OjYa28Pe4SBNJmcr+5X7LXjKJdIkfGbd6
 u9qIoBtsFU1bec/P8KFC2S+jnaYPchAJik5Dv87BwsrFvyHgrsaMhgWRVBzoBTURMTy/0CtR7/S
 iDw2uXGMMMpnmnavLqgu2HybGrj/MtYG8Mu2GEMTUuYJno6m6y4jm7JyMlVhPRhRg96AIX1wAlt
 90ek53ketSghrkyueF0knHBdmu4b8xNGCGWgN6p5/05vH2OphWfu1Q2ns4nQDz1Io3J1hg7CHjl
 GlnFV8G+QcxgWtByoPafpvpL6XlohRebeidXWirSrmdErihaFHAVTXbe0XkxJygOl893Oaobsot
 yVj7WjU/AG3pXcR9QIA==
X-Proofpoint-ORIG-GUID: RFZSdqO_9MxBIbVJovin-Uj71PVvz-ve
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIxOSBTYWx0ZWRfX9TiI0a7yNZcl
 oSSGHmi+YEMjUubKjAdy/kFDbDSxaeSweT/e8AlhZ6ppRA/NvttouitS6WI2oxw3rSGe/K2Hepd
 PhysmDZHeU+6EhYVWPpsToACDhlk078=
X-Proofpoint-GUID: RFZSdqO_9MxBIbVJovin-Uj71PVvz-ve
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 priorityscore=1501 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100219
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
 tests/tcg/meson.build             |  1 +
 tests/tcg/ppc64le/Makefile.target |  7 -------
 tests/tcg/ppc64le/meson.build     | 14 ++++++++++++++
 3 files changed, 15 insertions(+), 7 deletions(-)
 delete mode 100644 tests/tcg/ppc64le/Makefile.target
 create mode 100644 tests/tcg/ppc64le/meson.build

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 0013620c364..36f597a2447 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -147,6 +147,7 @@ subdir('mips64')
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


