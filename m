Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03949C61DCB
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 23:01:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x05YD-0000ez-B6; Fri, 28 Aug 2026 18:59:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x05Y7-0000YX-Sx
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 18:59:52 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x05Y6-0005li-3V
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 18:59:51 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67SMTCuM3665672
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 22:59:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=tK6xnGFy+65
 sDuPb/j6Sjk/cascMgkkV40PEfapBr3E=; b=K5klsRKXkBPXGTmzs4WlMKw4TyC
 5xSTdCIpePyQELIAHDB8v9J8JeKseambh7xcwS5e4qyXFibwekjKJ9VD8TeYf8nb
 9xvFC5gL/tD3/GZs9ysQxiEVFnAAxvGD6dte1IUGzfMo+bwR/VeVA2ZzzktHnVze
 h0J2Ga6wdQhz0l4kcnIU8HFEPIf+z1RFXOxlS2Rwy1SLRUTtdwFLFJJTH4Eo8onY
 Z/h6X6G8O67uXBOpF5saWnnylP1dsT9zOIHpqzhtvimxkyEgWvdUDHg73WaJ1q5k
 rpbl0N2YTMmzXuYd3yrLF5IM8qgdzNSQjmvxohGONMVz+muaqT6tKxVZjmg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gb3mubswn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 22:59:38 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-39512608fb1so3768389a91.1
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 15:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787957978; x=1788562778; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tK6xnGFy+65sDuPb/j6Sjk/cascMgkkV40PEfapBr3E=;
 b=d6KNFoFyobW/siImSHzgXEQuPy9ix/J4xD+V6zQWbMRTYe97b8rQHxBw/IJO3EQ1eq
 mVgajp1Q2osLppD4zPIyt0Le4+tEUtyGrL7RDpaC9uZ5C4EMyhGnKsCzXVcqry9qnhAY
 DrxZ/ch8NcfkaqnXHXPZg0ExkDgeoLqfut6tJgALfY39Vxg7Ll5PJr53pfL0TExK8y9B
 +bL+4NhKOnr1wWYDXUTT7+keaAvLCwY6PCJ8oGdxiSFpE3SXRCPqU52utusuWhbeVPd/
 zEEBEx2gxC4sRvX3Vssihkb2nnUMBmn0ybJtbg6p1JajoPNlz+TLJ9ThdEMxNNaOtwNz
 VglA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787957978; x=1788562778;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=tK6xnGFy+65sDuPb/j6Sjk/cascMgkkV40PEfapBr3E=;
 b=PPEwJFDx80PisGP6rm7gg+8KE7lfdaHLAAfMcopPtQ/u03M+NRF1siAJRI9u6KonWv
 dVMrX2l18TTD9PlMdgGZjq1jX5QryUG6B9eDqJr5Aqy11wtzA6filJxqvZ2So2jMxGda
 7+UGjnO2HR39tkMH+yWFxJQrcvMJdjBq8n8Ukla8oxrk2nSib0eSVE/J8eioBMcNVVPd
 cDuAOi5McEFWa3IsSnp/ht/xxirwei7eZiUx/OsVRqTky99BC+DFXIBRwoX4JjhQring
 VmMJcIA+CjPumTJldl79MFsM9qUp/XTKRRYM7KLTY1cqIv1txw84rIo/cPKiVQVP9wgO
 aMBg==
X-Gm-Message-State: AFuF++mlbGUgYtSLmEsmkhEHfMeL4zNYg68jmHbXeK0RzAr/PcVxRsor
 XyIPzAsn42jk/sHdPNC2Zo0S+O3gZSWbrEJfOC81aN6ioeJFf3o3uafVGZINJsguzfzJ1B377y8
 MSkLoGUhqScg2t/i5+mdmLnWqLP2ti7hTID7J6njqL+GF8xpx0kdwDCWzvYxlfySPxg==
X-Gm-Gg: AYBFou3b+g64RbbhxkyFHfRvEJcwRGhyFZ5s2ubu299uIkWn/XvPL2X63bEhjEGi+PF
 peLJnKzgWGMhVqie1yRIGajxsvjxWcda3SqZdTspyOrfPu5YOGmyBWjLpOwM+06vKTVsdCvM52Q
 rWtfsjtC5BAW7/PYrtJ1BQlcnHbxHmI0+MprR+z9mOVhLw38wPxxTpGngWjDyurQ05O+KpNYAE6
 nlYPUexyllBzZk1lZEza+J+50t8/6MUePWDIO/uEH4j7SZLO+HO8bGp6V/AsBMaG1ovgkKojbVU
 IQFbcBbC9PuFSiYomqrN0nD5xAaSgzr66aNXqXbywIzdte4u9TZU57A4tjwqgeM/ElrzIH8jgVY
 sZF9LTTkknhbP+Wkx0TnE1DxSD3yeJItpYieFbADiGZEiDFmz7memM/ranl8=
X-Received: by 2002:a17:90b:388c:b0:396:5f7f:52f5 with SMTP id
 98e67ed59e1d1-396d0e2466fmr18886649a91.3.1787957977695; 
 Fri, 28 Aug 2026 15:59:37 -0700 (PDT)
X-Received: by 2002:a17:90b:388c:b0:396:5f7f:52f5 with SMTP id
 98e67ed59e1d1-396d0e2466fmr18886601a91.3.1787957977268; 
 Fri, 28 Aug 2026 15:59:37 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-142e0de4de3sm12862827c88.12.2026.08.28.15.59.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 15:59:36 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: anjo@rev.ng, Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 philmd@oss.qualcomm.com, Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 23/47] target-info: add target_config_multiprocess
Date: Fri, 28 Aug 2026 22:58:37 +0000
Message-ID: <20260828225901.367438-24-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=ZbMt8MVA c=1 sm=1 tr=0 ts=6a9212da cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=RCSUDqgnImT0t8oOcR0A:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: 7yQwCfGiQBNuu0jCh0I7ESoKum4n4HaP
X-Proofpoint-GUID: 7yQwCfGiQBNuu0jCh0I7ESoKum4n4HaP
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDIwMCBTYWx0ZWRfXw/Fv8Au6/7MG
 o/95Xb5LBTjjNr19PdCzFByBEeittxpotXRupJbGRbRNGtvlPnlXh7K+xn48Th3tvXHgMtuX4ea
 D1RDW2EyzeXRjguov5ISOK7kdks3wEU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDIwMCBTYWx0ZWRfXzHXC0SJIFceS
 JN/kT6VMsfMBR9I0/MSt4ZvfU2iTj0dkck1xWfuMmezZ0o5ImrURnhNQKz8b1RtI2yHKfYH4F2p
 SEIej52syujTBtHx3YbedQsK+75dpXJuAcC86Nd8hxHS+7yNhKZFmaipQUlRmZdbzF3FyVvUu+n
 aMLNsxFrEKeuflpN0/2ouMdDu5rlM2KGHUhBYpGBxKEkZUG/5UKHWU6R0Vr2eGBHW6ZduZoa2JS
 bTQxLx0yJ1EagqcusNhCdWw23xNpX8dj03ylwE77nEFQ3a0M9voVC3bKP6asBvtC+crOkK3IFox
 KiunAWFPk6NLg5uY2l3Xx6m7xVmydZiH4kbFGcHtB1IyXeFDp9KN9ha7xP8W5ri7wRzLboeO+sI
 QzaqsBVYFPgstXrzXQE7R2i3cHsD+35rzbenzEwkRzsoqKmqUTGz9EQJLOv3tPrR+Rd2RvZKohk
 EsC0/x38Vu2RCASkziw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_07,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 malwarescore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608280200
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

For some devices/machines, we'll need to access target configuration,
but without relying to target headers. Thus, we add the needed
information in target-info.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/qemu/target-info-impl.h | 3 +++
 include/qemu/target-info.h      | 7 +++++++
 meson.build                     | 1 +
 target-info-def.c               | 7 +++++++
 target-info.c                   | 5 +++++
 5 files changed, 23 insertions(+)

diff --git a/include/qemu/target-info-impl.h b/include/qemu/target-info-impl.h
index cf42aabbc8b..dbd7a5a2071 100644
--- a/include/qemu/target-info-impl.h
+++ b/include/qemu/target-info-impl.h
@@ -30,6 +30,9 @@ typedef struct TargetInfo {
     unsigned page_bits_init;
     /* runtime equivalent of TARGET_PAGE_BITS_VARY definition */
     bool page_bits_vary;
+
+    /* CONFIG_MULTIPROCESS */
+    bool config_multiprocess;
 } TargetInfo;
 
 /**
diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
index b23e5bc5865..579c43332fb 100644
--- a/include/qemu/target-info.h
+++ b/include/qemu/target-info.h
@@ -42,6 +42,13 @@ const char *target_cpu_type(void);
  */
 bool target_big_endian(void);
 
+/**
+ * target_config_multiprocess:
+ *
+ * Returns true if target defines CONFIG_MULTIPROCESS.
+ */
+bool target_config_multiprocess(void);
+
 /**
  * target_base_arm:
  *
diff --git a/meson.build b/meson.build
index 5da6c15551e..8023da4a147 100644
--- a/meson.build
+++ b/meson.build
@@ -4259,6 +4259,7 @@ foreach target : target_dirs
   arch_deps = []
   c_args = ['-DCOMPILING_PER_TARGET',
             '-DCONFIG_TARGET="@0@-config-target.h"'.format(target),
+            '-DCONFIG_DEVICES="@0@-config-devices.h"'.format(target),
   ]
   link_args = emulator_link_args
 
diff --git a/target-info-def.c b/target-info-def.c
index d121b8c0170..9d51371f766 100644
--- a/target-info-def.c
+++ b/target-info-def.c
@@ -15,6 +15,10 @@
 #include "exec/cpu-defs.h"
 #include "exec/page-vary.h"
 
+#ifndef CONFIG_USER_ONLY
+#include CONFIG_DEVICES
+#endif
+
 /* Validate correct placement of CPUArchState. */
 QEMU_BUILD_BUG_ON(offsetof(ArchCPU, parent_obj) != 0);
 QEMU_BUILD_BUG_ON(offsetof(ArchCPU, env) != sizeof(CPUState));
@@ -39,6 +43,9 @@ static const TargetInfo target_info_stub = {
     .page_bits_vary = false,
     .page_bits_init = TARGET_PAGE_BITS,
 #endif
+#ifdef CONFIG_MULTIPROCESS
+    .config_multiprocess = true,
+#endif
 };
 
 target_info_init(target_info_stub)
diff --git a/target-info.c b/target-info.c
index 012b384036d..5db2a6049ac 100644
--- a/target-info.c
+++ b/target-info.c
@@ -42,6 +42,11 @@ bool target_big_endian(void)
     return target_endian_mode() == ENDIAN_MODE_BIG;
 }
 
+bool target_config_multiprocess(void)
+{
+    return target_info()->config_multiprocess;
+}
+
 bool target_base_arm(void)
 {
     switch (target_arch()) {
-- 
2.43.0


