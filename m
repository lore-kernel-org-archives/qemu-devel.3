Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAFF2F55455
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 11:09:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvClJ-0007v7-HG; Wed, 25 Feb 2026 06:09:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vvClI-0007uD-8T
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 06:09:00 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vvClG-0003gM-Oo
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 06:09:00 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2aad1dc8856so49976215ad.1
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 03:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1772017737; x=1772622537; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gddfzyp6SM5HJwk8s9N36VD15VTno9sNX2Z0ZJUILfE=;
 b=GpeS7qO8uxYls5Fg+8nHnVn0/98nMX0XgHkFJnFB1gPKLLObaFv6Rdm1Qp5ITMUOBn
 oypT1MBqKwTBp+hjbnHdGTmtHhDs2V+JPZ9W7Obrcjy4HtIxgeTL6ILfrDRE25zHDAr3
 wNVqd6zgeInCitFNe34FZ8fHxH65vw1Gd6Qcrb5fqK1NibSUEdUWtVjiB1F2dqDj31Zs
 iuQItU7kXLZ6e0E20GC+ETJ5JllaMuiExT7tHeLaZb3DYc+Eht9JEcWFwB7J4Mi/IS75
 OwCLuQkv327pCC3xy0LVzcTXbgJn5NX2G4Wt9EREXd8TJ48yCrB8xp49Bv9S03vk3cC+
 3sQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772017737; x=1772622537;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Gddfzyp6SM5HJwk8s9N36VD15VTno9sNX2Z0ZJUILfE=;
 b=qtCQOOIsA5ESW1V7ZjQKhzIsmNp2AAG3tQ9q062K9uvsHCZ4/7y4zWptDOclYUR75m
 0dnS++dTJHjlxzLbxN939GAbIQQWMbEW0VV0nJOZokn0Ec5z3lr9+EkV1UExZbAO1Tej
 Sa74XFMMGcfp55DdYCTzOrERClH9lqUp7UAYcoyWFxdLVwka6LNgu06bkTnvtXR4w38d
 ZwvXOSdHVITus/vqWsCLF6cMRKwnV0FPfWkOO7oCtqSNfuCkeuaGlkbXuvnHdJCWIVux
 bNP4rwYR/jaBdb4CAqdVZLSBh09Kfto/Qs+enwNIluFbmRbxBzqvD/7f55X3W+CQRBLj
 y4zw==
X-Gm-Message-State: AOJu0YwDmofn5L6gJ/ZFyjM4qhZI3iSmwGUDtrLw95cg1RDM3Awg36L7
 XK15uadEcxDFHWO1Ohhqfw3salMZmyPTABxvav2BQzRKINACQ2WF88rQzw5Xe8kYbln20GDqi96
 Et6ZjUmFWphZlXFeluZbt3JFMUijr5tk99CfaFbtfzBMawx66S4QpkkBGA1NHLvxhWYMDeT+GwG
 B9QxBtqcYjftO5HboGDBpK5WP+l4vm8oMZll7/ipP8A7b/
X-Gm-Gg: ATEYQzwuSL67wcpN3lDnYEavJWTZrKfdVtLS5ZeSqs21GktY9WrFLVmC9W5upHxOrbl
 Bd/4ky/THrb+4yP3DtBWVbphbSD+tFIH3Gk7yx6IAVnRvHtludIOtdRLE3FuzF0XHz4WV+7pRYU
 DloBUFTalb+df60atkgBtWqK+heiHTiMNP/jj/qOherHx0tFdrcmyueFxsF/lugOymG+DPYkNDj
 muPRz3gi47CAXz/QNUVxwRsmMjAOfS5mmMxBHd43PFOM6OUp0GvmoVrtlK1V0RYY+9MDQ37sEre
 26zwxlxta8S0KqZHgR0QN9kzZJYDjJEqIzfrYsCzLyHoB5B4ZgCC40nhprbdC5IGILm0+bXt7Hv
 DRfiQNxcp1T3Nn6/CyzwTUf1nHBZrtQxa8BCJY82ChRyU/eoCluQHfhSIy8+h4iLlUizbWSsx30
 h/bRwQeYMIRMDLPcZZWtn2IDCUEDIpm8cWiPEtRgdSParUIxoiKZQgH8HfSpbXYfr7ugiaVvztd
 3OoN+e3nSIsq3267svVSj3ssaY=
X-Received: by 2002:a17:902:cccd:b0:2aa:e3d1:1438 with SMTP id
 d9443c01a7336-2add11bb978mr22387405ad.12.1772017736891; 
 Wed, 25 Feb 2026 03:08:56 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ad74e35133sm140452665ad.9.2026.02.25.03.08.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Feb 2026 03:08:56 -0800 (PST)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, Max Chou <max.chou@sifive.com>
Subject: [PATCH 1/3] fpu: Fix repacking issues in the uncanonical step for
 E4M3 overflow
Date: Wed, 25 Feb 2026 19:08:00 +0800
Message-ID: <20260225110802.1217946-2-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260225110802.1217946-1-max.chou@sifive.com>
References: <20260225110802.1217946-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=max.chou@sifive.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

In the uncanonical step, the input FloatParts will be repacked to the
target FloatFmt. This commit fixes following issues after calling
uncanon_e4m3_overflow in the uncanon/uncanon_normal functions.

- Add the local exp update after calling uncanon_e4m3_overflow in the
  parts_uncanon_normal function.
- Add the fraction shift after calling uncanon_e4m3_overflow in the
  parts_uncanon function.

Fixes: 27e989f99c ("fpu: Add conversion routines for OCP FP8 E4M3")
Signed-off-by: Max Chou <max.chou@sifive.com>
---
 fpu/softfloat-parts.c.inc | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index 61b07307bf..a738758aee 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -387,6 +387,7 @@ static void partsN(uncanon_normal)(FloatPartsN *p, float_status *s,
             case float_expmax_e4m3:
                 if (exp > exp_max || p->frac_hi > E4M3_NORMAL_FRAC_MAX) {
                     partsN(uncanon_e4m3_overflow)(p, s, fmt, overflow_norm);
+                    exp = p->exp;
                 }
                 break;
 
@@ -496,6 +497,7 @@ static void partsN(uncanon)(FloatPartsN *p, float_status *s,
                 break;
             case float_expmax_e4m3:
                 partsN(uncanon_e4m3_overflow)(p, s, fmt, saturate);
+                frac_shr(p, fmt->frac_shift);
                 break;
             case float_expmax_normal:
             default:
-- 
2.52.0


