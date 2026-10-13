Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06840CC6B1A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 19:57:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGibx-0004bS-9U; Tue, 13 Oct 2026 15:56:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xGibl-0004Zj-5v
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 15:56:22 -0400
Received: from mail-dy1-x132e.google.com ([2607:f8b0:4864:20::132e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xGibj-0002Qs-Ab
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 15:56:20 -0400
Received: by mail-dy1-x132e.google.com with SMTP id
 5a478bee46e88-35829219da8so313391eec.0
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 12:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791921377; x=1792526177; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=NKhrMR571H4bPltCPL7J1a17aFUoRYsTRwg05TCF5dk=;
 b=NiGrwhBaxG15U3dHdhcfie4SCtXA5CyOiP9hxjI2u9zMVk/Ktr+DpWrco6T1nJY2oH
 FElUWhmhLRIA12NMOKxp1hzuJabDjNQWavvTrC7i03AgRKX+AzWr8nhp5CysUnN1Ch4m
 jT8wh28d9udbwYH/+61JNOLoI1FMxx1e4GOD2EjSLk4sj9StL7B+o8K9QHplnWjJOKw6
 egHyzJ1nBQKm/2GjpTN6YWXIvCFyFjYUyYS8VWFcRqkb7OHYOCQqG/TqwZq7/+gODCfB
 NIEYhhe/gUCgtXT9MPDBFrfWb8bfGTRAFsEyQo5PyCXeBCdpwGsPlcgTttSrMoQHteHr
 rIHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791921377; x=1792526177;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NKhrMR571H4bPltCPL7J1a17aFUoRYsTRwg05TCF5dk=;
 b=ors1uZD89Hf5K8GJxPYEtcRJLiTkSSTIwq28O+ccXCxzlFojkCqw9Hk+rwZW4Uxp+2
 F8JHJ4QaJxh36EZEOB7t37KS2k7+KSQS7Xbo7X+hZIyEU8m1yZQDF5F6ksFwADsL4DjP
 dCUttSFKVt+s33kudgQ8QQJqTupzjSYNZk7HTKnEx4MaUZMTsydasL7QXSypxbFMcdXw
 DCOcSWR0ND/YeRVjow0Urx/xFTM3hB3eillC8IZw/EvmuIc2cXEcQ3VeM7b/1GDMKYeY
 BcgOlGkU9+22T7uPnsrFD6F5UeYM6aIHP0M6Fu4YBPgLqPFGgP0HH6M03DDIMjil0EBr
 DHtw==
X-Gm-Message-State: AFq9FYI0HNcSs8JfE6BxJ49ehm4nFNLnSEKv2lEzYgqSqKL4HYYQs3SN
 k0NCIYe6+olihCo/OKiuU9fRtI2mNn4/52ZFJCQtK6JJicgLaft/0nEz64NTbM9f
X-Gm-Gg: AYBFou1WTrCUyZDsCwtnmBfb/ZoOkoeE011YG3X7dMFN63kXROQ2UhFTsR6nnDKat5p
 dv7dOXv8W8AtRgi5Tz5As6JenEv/ZaKN4W4MgGl41SAIIdCQc8dW5XbTmAg83+XtV0zM1UFsYtf
 RCjVDU39n/hxtx/DoOTh+DVIseumvNIWAvV4PVEkUkKKxXsblGTaqutnYQ2yE2Yd0wH+9Xb7bTR
 jfLFHw6XL/k6xrtS4sGtQrO/CJEhSyz/DjIPEF7nqC8alrmjQIr36SZgBUfkF8ERZtif152EOJY
 gmpph+4ZE6AP1gxpGC8DvqWOA/iHHpqeegcLJ/de/lS8ijQqliciiHj2GLdNhgmL0hoOESCqbkN
 h2SHkm1tSDWqQYGHqy0rrQcZapLTeYNjmyHBD7Tk19VPvpCK4m7+EaMwpWQw4RKFujedrK8Nhpm
 LpLiTYkI1N8fMOL5BMgxPWb4mU8zW+j9CSff2aILSGmz5m5H96EKzP8qb1D1Z+2bfEaVwKIvBP6
 sQr6WWFeBeD+3GlxA==
X-Received: by 2002:a05:693c:8112:b0:358:6d16:44e2 with SMTP id
 5a478bee46e88-3586d16487fmr16902154eec.22.1791921376943; 
 Tue, 13 Oct 2026 12:56:16 -0700 (PDT)
Received: from DESKTOP-Q716RM7 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-3537ca1b556sm60187998eec.9.2026.10.13.12.56.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 12:56:13 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Philippe Mathieu-Daude <philmd@mailo.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH] target/arm: defer max-v8 initializer selection until CPU
 creation
Date: Wed, 14 Oct 2026 03:56:05 +0800
Message-ID: <20261013195606.152-1-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::132e;
 envelope-from=luoyonggang@gmail.com; helo=mail-dy1-x132e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This is for avoid "max-v8" qom name conflict in multi-target qemu

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 target/arm/tcg/cpu-max-v8.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/target/arm/tcg/cpu-max-v8.c b/target/arm/tcg/cpu-max-v8.c
index 65f851f2006..d7323ab431c 100644
--- a/target/arm/tcg/cpu-max-v8.c
+++ b/target/arm/tcg/cpu-max-v8.c
@@ -119,12 +119,21 @@ void aarch32_max_v8_tcg_initfn(Object *obj)
 #endif
 }
 
+static void max_v8_tcg_initfn(Object *obj)
+{
+    if (target_aarch64()) {
+        aarch64_max_v8_tcg_initfn(obj);
+    } else {
+        aarch32_max_v8_tcg_initfn(obj);
+    }
+}
+
 static void cpu_max_v8_register_type(void)
 {
-    static const ARMCPUInfo max_v8[2] = {
-        { .name = "max-v8", .initfn = aarch32_max_v8_tcg_initfn },
-        { .name = "max-v8", .initfn = aarch64_max_v8_tcg_initfn },
+    static const ARMCPUInfo max_v8 = {
+        .name = "max-v8",
+        .initfn = max_v8_tcg_initfn,
     };
-    arm_cpu_register(&max_v8[target_aarch64()]);
+    arm_cpu_register(&max_v8);
 }
 type_init(cpu_max_v8_register_type)
-- 
2.55.0.windows.3


