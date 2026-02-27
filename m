Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99782104891A
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 21:41:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vw5ZT-0007KD-Q8; Fri, 27 Feb 2026 16:40:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vw5ZS-0007Jt-GA
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 16:40:26 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vw5ZR-0001bq-1i
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 16:40:26 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4806cc07ce7so27047035e9.1
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 13:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772228423; x=1772833223; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xq9AbVEGMJOUmRpUy7lw08FvOFGT4iR2NVIvt7Ek0VQ=;
 b=nZcY9jq+7YMSQKbCOPoi9Kj65qVmj9c/1XImSVczqaWJ0B7S7CUWpvvKIMbqlfSeyx
 +KZePf4Va44Lr55snUoCrHTxvbABoGuCbYINZN4J7gnQaTYSwjUSVOnWq3mlgpo5b0ec
 MOucoxk70ikcAF++QcS7gcWjW8N9QeM2kdj5Gvfxz/kukGhJwcbXxksr018Fl+GeBS5O
 60b2of6DmjxHNUpKsVDeiBpSyPh/8l62jl5Ij5IrSATrKCbMPozXzoyvh458mhSvAU5M
 hBbrUbDxTURkE2ujCmQmqOHdLOfNwrTqr9XKjwsr1YLdl9lARb/ahg8b+idnLCibnbSg
 DFpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772228423; x=1772833223;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xq9AbVEGMJOUmRpUy7lw08FvOFGT4iR2NVIvt7Ek0VQ=;
 b=e9TYyIE1VzrPLIPuoVWetno/KCnmhpwpRN6ZGU/R+FfYSR1oUMFmMfoIIM45V5XGbU
 dwN13Ewg6t83G8ahL6NxyxD61+DkhiQmlIUdI9/qA+BTWRlXRYJVozuEcOLk0JvsUY9W
 KxWibD6V8mPKllaUeRXajWcsljquLWTHnJXpntsUv37ovau95kaOM+HNrqfjjROuRUn9
 y2VuIoOmBU5sQN/gY+3gBGSht2nNfmsitcM6x3kV/AQarlUE6l1mOfTUUfuVc8dDkGKX
 wBPDpN//XdTOidQEsGOJRaZNkwRl8iEjqzVqzcBu4i54srfUE0fqhe10v2NrrMl0CCaj
 e6Pw==
X-Gm-Message-State: AOJu0YwhI/k9vq2gti9f6Q3Figtr6Ro/rjO8HAPzD+Y3FXJ0DxwfB9a/
 b1pjTEPoYDVyHI/m4o8KqepwCbrPUizJ3/lJTOhkYkL2U4PZIQWvWeefgWK3Wjx4k+irYTMzrTu
 CIM1MQLs=
X-Gm-Gg: ATEYQzzueAdW+Fj6TxTq83sr4BFA7ISbHrVxxK5Jd+sUfDDNh9F75gVu7SKk6e5MXwe
 gmpXeJzJY0Ci42l2xnDaXfwh9oQ+CNZOmOgiAF3lopI9PZhUSn/bYY9E3GiWQ9DwElRyZ6jGkSX
 fQleV6+ZWfExbujSTheQk+Lpve53a+57Bx68FZbgTYR0gThI0HM0j3XjwuKs0tuoDOlcF54eW7K
 Plgh/SWXH3GythOJ+tl3peHXs6llTr1rEB8zUongYUK5yrHfSyN3hraPrx+W9SGwFIVJsm65th7
 EnuAKz2zEKZ96ffwqjg0WAz5TOZi0uU4mDMihJtYBzE+RmST5Tvk9CvQWlOi+9enDqTEZvEBitv
 HQ5j+K6YvMejXiWm9nf+Katnlzk8Kgx1wuA1TuZkF26r2+CLTzBFgKF07bkp48FAPpABu5qxqSw
 d3Eqa10dnxLB7iEoKaUro9cNtAZ84yhdVC22uMCp6gDJXUDXRTzTlszGU+IeTl1lDaizhdjYpmc
 TYYAYnwQJg=
X-Received: by 2002:a05:600c:46c4:b0:483:6bb1:117 with SMTP id
 5b1f17b1804b1-483c9c0fb97mr63753645e9.32.1772228422949; 
 Fri, 27 Feb 2026 13:40:22 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4399c60e404sm10710934f8f.8.2026.02.27.13.40.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 27 Feb 2026 13:40:22 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Florian Hofhammer <florian.hofhammer@fhofhammer.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-ppc@nongnu.org
Subject: [PATCH 3/4] gdbstub: Emit base_register index in GDBFeature entries
Date: Fri, 27 Feb 2026 22:39:57 +0100
Message-ID: <20260227213958.21170-4-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260227213958.21170-1-philmd@linaro.org>
References: <20260227213958.21170-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

Record the base register index in the generated C file.

Check at runtime that either @g_pos argument of
gdb_register_coprocessor() is zero, or it the base register
index.

This change pass 'make check-tcg' test suite, which runs the
tests/tcg/multiarch/gdbstub/registers.py test, itself calling
gdb_register_coprocessor() for each target tested.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/exec/gdbstub.h  | 1 +
 gdbstub/gdbstub.c       | 2 ++
 scripts/feature_to_c.py | 1 +
 3 files changed, 4 insertions(+)

diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
index bd7182c4d32..12e7b5b7282 100644
--- a/include/exec/gdbstub.h
+++ b/include/exec/gdbstub.h
@@ -6,6 +6,7 @@ typedef struct GDBFeature {
     const char *xml;
     const char *name;
     const char * const *regs;
+    int base_reg;
     int num_regs;
 } GDBFeature;
 
diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 90f4b95135b..6eadae3804e 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -610,6 +610,8 @@ void gdb_register_coprocessor(CPUState *cpu,
     guint i;
     int base_reg = cpu->gdb_num_regs;
 
+    assert(!g_pos || g_pos == feature->base_reg);
+
     for (i = 0; i < cpu->gdb_regs->len; i++) {
         /* Check for duplicates.  */
         s = &g_array_index(cpu->gdb_regs, GDBRegisterState, i);
diff --git a/scripts/feature_to_c.py b/scripts/feature_to_c.py
index 1329695ad04..a52cd2e9ec6 100644
--- a/scripts/feature_to_c.py
+++ b/scripts/feature_to_c.py
@@ -102,6 +102,7 @@ def writeliteral(indent, bytes):
         sys.stdout.write(',\n')
 
     sys.stdout.write( '        },\n')
+    sys.stdout.write(f'        .base_reg = {base_reg},\n')
     sys.stdout.write(f'        .num_regs = {num_regs},\n')
     sys.stdout.write( '    },\n')
 
-- 
2.52.0


