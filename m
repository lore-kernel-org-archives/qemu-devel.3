Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41900C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 15:00:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whTji-0003PH-GA; Wed, 08 Jul 2026 10:58:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1whTjg-0003Ix-UM
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 10:58:52 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1whTjd-0002z6-4o
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 10:58:52 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-472326ca506so560288f8f.2
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 07:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783522727; x=1784127527; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=JIXLaTM0HmixlIx6VEsdYx4/mlSg82al0riON9+dVMU=;
 b=ydtWAc6WKyEHkgBMh5Cfqm7vpC3IARd2g1tvtYQ+wGGobB6xW4dMUT0o2/+L/TvunL
 RW60gzLmuPe6dp3EGBVYfKGycYnwzjKM+3/SaThmKGwLznrGc+qNR6uSasr36BykaCI9
 H/l6Q2kAXhtMRvSc0Mztvgk87i1kqWYG3QupVvsttl9Xw4iLrsAQxc4CLD+lbcnvO/t/
 OUTdZQU4edYFLD1pvqq0sgLsCXf1g6zbdV0CHxGX3M9Luz5iWc8hfhOIzEmoy4v/t6EQ
 wXtKF6gFvpu4M8CGlhINCwtxNK8TpkVuQnkuOAJsg+TbcIlAnnkn8b9+T1khdx95VA9t
 nfog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783522727; x=1784127527;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JIXLaTM0HmixlIx6VEsdYx4/mlSg82al0riON9+dVMU=;
 b=fObHrl4k/ZI8pJ5+9B4KjgSLMMmTHztiFArgdyw8gaHUsrh7Oknl3g1+jnBpBMW+I2
 4u35Y28Usk61gy2hGuVt8fE7R05DUcRuuSV57yeUplE+P9hXqx/fhx+aGM6rs1w+mfxw
 4RVdLZcUHaZN3eutcCFcwjGTmIKZYf+LsL0uOF5fSizhPxNxDF0GsHcdMYfZFCBSLkeN
 qLngwZU0YOgpUiOOrjqQ2yQhH2hlhYNIFjrdggNS9e/24OBjKGfN79cEuhCXXh9A4zmn
 3O2o0x9rP2OiJ5ZR+3G9yv3YTrEXj2G79KXHfjVuyLlZvsSQ+x/SFB6zsLEHuKPNYMpw
 5MFw==
X-Gm-Message-State: AOJu0YwPJIzzIO9qIcf5x90zigYxaNau5fAM+eGmh94ZZ38VyW3kFuuU
 eLT95qafMSZpNMsbdyMZKIaz67+6xeMobKO2VO43+Ql8SkKKr6xxxYm4hYgfu5VC1ws4q9CyC6Y
 3Is94tKQ=
X-Gm-Gg: AfdE7cnv9KfopWQ/Pg7i+byXWGdD6/s3fzd1W+H8E8UGvlBtwf/HXqnbPy5PIyJ7O0o
 q7sFJLK9hC8AL01EPUgetv7Th34JBENjd2AjNDKUvtfMNQQWYXExfuzVYgZeGMFF0kiuX8NeCVo
 oQ1p4bpcOeIM/xBlyvEqhcfjvQl2Re+K6gIUpow/nW6LjcQu9iE7N/fbf+vvmHKqF6auBSUOB6b
 B4mOL9rWpZzTkzKcn7n82w4H/njTBa6KaZ1eplGGsDCxePm8CLD902TQ0GS+7SI2YKDW7MqSW3R
 8+PY1wNXeo73c/gPGFm+AYDqEvpNuKCOMzgW5nsCHsMk1oQ7uhBN6KiwomWdvuGQ5PzQufCLEsA
 no+A7uGUJszOHnor05RzxaIQLfCkIKI0NgVp6yddDxgFJaNCvYNznC8cMavHZB3Av+ZXM9kyRG4
 4ZvyRxrKqBamiAsZqu0LNqUoQ=
X-Received: by 2002:a5d:64e2:0:b0:46d:d5db:98 with SMTP id
 ffacd0b85a97d-47df077544emr3380658f8f.44.1783522727093; 
 Wed, 08 Jul 2026 07:58:47 -0700 (PDT)
Received: from draig.lan ([185.124.0.114]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9de1d905sm45244377f8f.2.2026.07.08.07.58.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 07:58:46 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8E53A60157;
 Wed, 08 Jul 2026 15:58:42 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 8/8] docs/system: add FEAT_HAF
Date: Wed,  8 Jul 2026 15:58:41 +0100
Message-ID: <20260708145841.3032079-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260708145841.3032079-1-alex.bennee@linaro.org>
References: <20260708145841.3032079-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x433.google.com
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

This is a subset of FEAT_HAFDBS which we have already implemented.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 docs/system/arm/emulation.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 903a5f90880..9930974a501 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -95,6 +95,7 @@ the following architecture extensions:
 - FEAT_FlagM2 (Enhancements to flag manipulation instructions)
 - FEAT_GCS (Guarded Control Stack Extension)
 - FEAT_GTG (Guest translation granule size)
+- FEAT_HAF (Hardware management of the Access flag)
 - FEAT_HAFDBS (Hardware management of the access flag and dirty bit state)
 - FEAT_HBC (Hinted conditional branches)
 - FEAT_HCX (Support for the HCRX_EL2 register)
-- 
2.47.3


