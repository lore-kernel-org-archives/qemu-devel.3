Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 786E2CD342C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 13:59:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKcmP-0001R5-M1; Wed, 06 May 2026 09:59:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcmF-0001IO-N3
 for qemu-devel@nongnu.org; Wed, 06 May 2026 09:59:07 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcmC-00007z-TY
 for qemu-devel@nongnu.org; Wed, 06 May 2026 09:59:03 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-488a88aeec9so72867475e9.2
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 06:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778075938; x=1778680738; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=C+XEiL09lfmgyHO2Y4EFhGtAKLkwWNf3J69g+kf0h9M=;
 b=kYj8nnrfkZGwR880+Bcv76pvxyl4JLdzjN5mixbCx3Ae8zkAva4bKmnteAPA5E8PWn
 QH42pPHiyNDZntfv2zKKMFEa0+8QZ8Sycmyuj391Y0zxEZCQdk+JKLNFh9+Tdi4qhDQE
 Ef7LasBv1oCvDeo61XZGWB/uoTl3bUkCY3mcfxNa2uRtH/TF7QYR9GhYNuRyVzua9btZ
 QSCi+gPhVKn9zpNpvO6SzRLkTZtngIFMIogtS99h+wqOvyA05JgwLvntKaRXfAAFkLIJ
 a//a7R+afH2s4asgj65YIzOBew4hMKz+Pc9XS71D/a20O3tdY+UzfyyeTz/tTJNA2Erp
 aLjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778075938; x=1778680738;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=C+XEiL09lfmgyHO2Y4EFhGtAKLkwWNf3J69g+kf0h9M=;
 b=kR9xbMt/5zlLBt0MBbC2Sa/yY884+zgKoVoFjFYS/3N/HPDCl16pEGGtUNBWx4m2rg
 tkKDDSv3jaV/DK3sjiUpe/IHA0Ep5zuH4Ry4i7/4VVFPl1QnvCEkaEi4Nrxao3UwHm0q
 pOtnTjztKt0oEVDItsqIxQ493pSKd0mxvxn1Lmzyedhs4ImcGIv2z/UUaGZ8YsgYBfZ3
 DorcjgCP0gyPvUiBOmQr2l2ZMPENFU/3DNHFGFllJobu2572d8fxSW2vuRY3ZXfPMYMl
 O1u6KvpOzO52kXTqCURb/rFhvPsBBer5Dd4k8/ux9QvYSsGlhwt3PsvMjBmYW4wIdJYg
 1tWw==
X-Gm-Message-State: AOJu0YwDIl5r9fCtOwfH8gzE7cmxeudKcrjZn5y/3y3JGZOnFR04xxsi
 Rh08iBJ52A9TRtgMyMisafjfceVnO2rUZ6nQVG5HyWNvUFhln8DNf8y2qzUEPcQh5bntVcu17rP
 auSOL1oI=
X-Gm-Gg: AeBDieu97Aqgeiu91eC/7OtDTB+hJ6P0NFV3y+ooaec8BJXMGYPcDXV3WvrpRup16x4
 JSNRToln4B0N92P6swfusKG+G4dtTduLDTcT3muLcfUPmbaRlFyiXu1Fh0v9gtKFxOZacUJ269f
 wtGPyeiX3wPcUrEFdImaMe3jY+gR+zrxBk5p5CAe9c001xVc2rbvFNNwG5kz5plYCdMnDxhWM8Z
 vihwbnsTuriy73DKOLJG55N6xYv+nCkFBSDvMSHJQUPkPMNk+HmSqchLY3Nys175zQ3ApDPmApD
 /6bV2bZUW1ElWuPBo6Zd+prgeiMqZT9n/0fzDmKV1J9wJs3dV23KBuf4qjGEELJ9BW6DBupOcXy
 rJudxW/EURNPB9VXaAKtJP3e+TxKbwcxj1kDMBg7tfOqfLEtaUgbFNK5eSQ6QHmZzHAbE8tra6C
 vh8Xq5+eJlCQT0uTavpF5Wk6XVchmsGE7v2XvpCYyG6Hl2eznfM1zsHqsv+Kz4cpiTkKy2lp2tY
 KOyMgk7UF8=
X-Received: by 2002:a05:600c:a305:b0:48d:364:6c54 with SMTP id
 5b1f17b1804b1-48e51f4144amr44601345e9.23.1778075938388; 
 Wed, 06 May 2026 06:58:58 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e53895effsm47957805e9.3.2026.05.06.06.58.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 06 May 2026 06:58:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 028/110] target/avr: Avoid target-specific migration headers in
 machine.c
Date: Wed,  6 May 2026 15:54:00 +0200
Message-ID: <20260506135524.20617-29-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506135524.20617-1-philmd@linaro.org>
References: <20260506135524.20617-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

machine.c doesn't use any target-specific macro defined by
the "migration/cpu.h" header. Use the minimum headers required:
"migration/qemu-file-types.h" and "migration/vmstate.h", which
are not target-specific. This allows to build this file as
common object.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20260325211728.89204-2-philmd@linaro.org>
---
 target/avr/machine.c   | 3 ++-
 target/avr/meson.build | 3 +--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/avr/machine.c b/target/avr/machine.c
index 4402862fb96..8064a7214a3 100644
--- a/target/avr/machine.c
+++ b/target/avr/machine.c
@@ -20,7 +20,8 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "migration/cpu.h"
+#include "migration/qemu-file-types.h"
+#include "migration/vmstate.h"
 
 static int get_sreg(QEMUFile *f, void *opaque, size_t size,
                     const VMStateField *field)
diff --git a/target/avr/meson.build b/target/avr/meson.build
index af5e7d63741..39e5eb02c2b 100644
--- a/target/avr/meson.build
+++ b/target/avr/meson.build
@@ -15,8 +15,7 @@ avr_ss.add(files(
 
 avr_common_system_ss = ss.source_set()
 avr_common_system_ss.add(files('gdbstub.c'))
-
-avr_system_ss.add(files('machine.c'))
+avr_common_system_ss.add(files('machine.c'))
 
 target_arch += {'avr': avr_ss}
 target_system_arch += {'avr': avr_system_ss}
-- 
2.53.0


