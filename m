Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98D6AC02194
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 12:51:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfIO5-0000F3-Jd; Tue, 04 Feb 2025 07:50:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tfINj-0008Lw-6e
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 07:50:24 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tfINd-0002A9-QT
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 07:50:19 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-38daa53a296so272520f8f.3
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 04:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738673416; x=1739278216; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZMomNfTKsnHM/3+WLPMScpmOJgfYrLQIKGo4Qy9Se74=;
 b=uwI/jWvqv4T8fiRAK0jbroE+uin/zuR/E36HAVbFAC6dJwLWqUBtYukhuKQCTaNdcG
 8QnXhdlGL1b6GZaXqq8pGgUGmFg6+9K2Qs87S2Zr80Yb5gDlGF8Otv0Flcc1Pg8t8Yty
 145e2dRsoAEXXZddIWZoLrhdJ2Gcy2d7uab9nYaAmlc/WOZaiLHd1e2mGbmE11EM4Cu0
 9oqMIm3F7FuXLIM+WNjr8zgmXg0ESCMmwpmsSMpyaPouNRpE+cixU59DDOwewJFYiVSz
 lYIlMFkstFhcqqCZklY92yriUi59mvMD8SO7MPU0f2JRPnkJLzQdz+U3KwedfKMYhT00
 NIRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738673416; x=1739278216;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZMomNfTKsnHM/3+WLPMScpmOJgfYrLQIKGo4Qy9Se74=;
 b=rU01HtmdNXunzLUvLIGtLiv9vKzXHqhAABZWBnq2lOAsF6l4ncHP1oypgtn5AdENFx
 7t7nj40NBDsHZmq/9gQ9ay8hfUQGpCa1g0pObGD3mmphucAyhEhV2K888ocRcFEdR7dB
 rUf5jik00Ouf9lZ8b2kwXLQd3GMqjpiQxVe3RlNd5d2r8Y33ZVIzg66DrDRFkdbfsddx
 6+MdNVrXtymr1OQ/JFvLsfR9mj+XjL0WAFIX79lo6sdYuR4TbGS5353uRdAKWPZFJMdS
 RHL5ZOg9Fqiy0Dc3nzB6ccw6Bnzyd/ERUg4VN1Nrcxao2hRFOdWo3dfGDjU03gZZF8sw
 u/bw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZj3RunoV8oJ8AqcvwmGKhl16c5aPN4G1L9E3NMfxown6c5re2yV6pMQEgGUibKhnr0vpDS7hSTLoK@nongnu.org
X-Gm-Message-State: AOJu0YxPsmuy+gGK/af6P0QGS1+xwgOwYvPccprOxWt+Ab4o+GXR9CVz
 9khrjBIfVKZdgW4BL/Ek8hegbXR4l5Dlts7qCDri7Kl3E9lBUT3V6HQ+78RiVKpPQjkYSHtaDj7
 Y
X-Gm-Gg: ASbGnctSGFD2dxTpSTGHM9TH90QR6TwEVBk6ox25Fk7y1MsFBKmIxk6TYSywbokJamm
 IGypDACqgykbLqPTe4JisDPNpWc9ZcO7Tf73RhoXZ6ghpZMIXk5nBwFERGrUEeR4TaTOD7yy2fa
 j+c7ekhdjVQtBrlK3h5oCvbGqp6dFQOvljOuHx3yzuhnhA4PP4ZuWHzKNToCaeYjXNTPSw5/aH5
 a/aVLupJGUsu02MedZuDD7wIICUYtpWqe171exZjD5M/fpF3PK7bazDK01EkeNIs/8mHP5gTvQG
 A0QacnrgcslCbn0ayHzGEg==
X-Google-Smtp-Source: AGHT+IH41lar320LQzBf74OfHPI1IKm+o2XdQxdLIEafZ8Oerby+u8AdGTr7nEUfM4oIc5bB9MB/fA==
X-Received: by 2002:a05:6000:2a3:b0:38d:b099:4546 with SMTP id
 ffacd0b85a97d-38db099463bmr739289f8f.54.1738673415946; 
 Tue, 04 Feb 2025 04:50:15 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c5c122465sm15757919f8f.47.2025.02.04.04.50.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 04:50:15 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v3 4/9] target/arm: Always apply CNTVOFF_EL2 for
 CNTV_TVAL_EL02 accesses
Date: Tue,  4 Feb 2025 12:50:04 +0000
Message-Id: <20250204125009.2281315-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250204125009.2281315-1-peter.maydell@linaro.org>
References: <20250204125009.2281315-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Currently we handle CNTV_TVAL_EL02 by calling gt_tval_read() for the
EL1 virt timer.  This is almost correct, but the underlying
CNTV_TVAL_EL0 register behaves slightly differently.  CNTV_TVAL_EL02
always applies the CNTVOFF_EL2 offset; CNTV_TVAL_EL0 doesn't do so if
we're at EL2 and HCR_EL2.E2H is 1.

We were getting this wrong, because we ended up in
gt_virt_cnt_offset() and did the E2H check.

Factor out the tval read/write calculation from the selection of the
offset, so that we can special case gt_virt_tval_read() and
gt_virt_tval_write() to unconditionally pass CNTVOFF_EL2.

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 36 +++++++++++++++++++++++++++---------
 1 file changed, 27 insertions(+), 9 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 7ec1e6cfaab..01ca222903d 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -2600,6 +2600,12 @@ static void gt_cval_write(CPUARMState *env, const ARMCPRegInfo *ri,
     gt_recalc_timer(env_archcpu(env), timeridx);
 }
 
+static uint64_t do_tval_read(CPUARMState *env, int timeridx, uint64_t offset)
+{
+    return (uint32_t)(env->cp15.c14_timer[timeridx].cval -
+                      (gt_get_countervalue(env) - offset));
+}
+
 static uint64_t gt_tval_read(CPUARMState *env, const ARMCPRegInfo *ri,
                              int timeridx)
 {
@@ -2614,8 +2620,16 @@ static uint64_t gt_tval_read(CPUARMState *env, const ARMCPRegInfo *ri,
         break;
     }
 
-    return (uint32_t)(env->cp15.c14_timer[timeridx].cval -
-                      (gt_get_countervalue(env) - offset));
+    return do_tval_read(env, timeridx, offset);
+}
+
+static void do_tval_write(CPUARMState *env, int timeridx, uint64_t value,
+                          uint64_t offset)
+{
+    trace_arm_gt_tval_write(timeridx, value);
+    env->cp15.c14_timer[timeridx].cval = gt_get_countervalue(env) - offset +
+                                         sextract64(value, 0, 32);
+    gt_recalc_timer(env_archcpu(env), timeridx);
 }
 
 static void gt_tval_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -2632,11 +2646,7 @@ static void gt_tval_write(CPUARMState *env, const ARMCPRegInfo *ri,
         offset = gt_phys_cnt_offset(env);
         break;
     }
-
-    trace_arm_gt_tval_write(timeridx, value);
-    env->cp15.c14_timer[timeridx].cval = gt_get_countervalue(env) - offset +
-                                         sextract64(value, 0, 32);
-    gt_recalc_timer(env_archcpu(env), timeridx);
+    do_tval_write(env, timeridx, value, offset);
 }
 
 static void gt_ctl_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -2768,13 +2778,21 @@ static void gt_virt_cval_write(CPUARMState *env, const ARMCPRegInfo *ri,
 
 static uint64_t gt_virt_tval_read(CPUARMState *env, const ARMCPRegInfo *ri)
 {
-    return gt_tval_read(env, ri, GTIMER_VIRT);
+    /*
+     * This is CNTV_TVAL_EL02; unlike the underlying CNTV_TVAL_EL0
+     * we always apply CNTVOFF_EL2. Special case that here rather
+     * than going into the generic gt_tval_read() and then having
+     * to re-detect that it's this register.
+     * Note that the accessfn/perms mean we know we're at EL2 or EL3 here.
+     */
+    return do_tval_read(env, GTIMER_VIRT, env->cp15.cntvoff_el2);
 }
 
 static void gt_virt_tval_write(CPUARMState *env, const ARMCPRegInfo *ri,
                                uint64_t value)
 {
-    gt_tval_write(env, ri, GTIMER_VIRT, value);
+    /* Similarly for writes to CNTV_TVAL_EL02 */
+    do_tval_write(env, GTIMER_VIRT, value, env->cp15.cntvoff_el2);
 }
 
 static void gt_virt_ctl_write(CPUARMState *env, const ARMCPRegInfo *ri,
-- 
2.34.1


