Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1389BEA8543
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2026 22:36:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzMj5-0002XU-Nm; Sun, 08 Mar 2026 18:35:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzMj3-0002NX-Nh
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 18:35:53 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzMj2-0003KO-55
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 18:35:53 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-439bcec8613so5456569f8f.3
 for <qemu-devel@nongnu.org>; Sun, 08 Mar 2026 15:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773009350; x=1773614150; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=K5cAnI+aff4g+PK2Wvf2f+7IaZ9nLk9cnyQziXBBI8I=;
 b=IHkzipGDqISPdOGVDuOeg4m1WVv4p5C3IQ9lj8WOK+a+QGckyYuMMZEEJL7/P8TNcQ
 i2iesySfFrYv2vxqweLLwpivWm3xMGtByeNYULeUz0BWjath63sYU0kGxO7DLoEA6oEg
 0lFvTdd1SSvrugu7yYf9h+AqGcAXEJPVeWQ68s7W8JnFPKHkYPGsCGLu9nOxWVid4CEB
 cdb9VoOGpSotoId8d0DKwXImDOFTUrbpFpQX6degAvpgWg5dndoALN7323Glj8+VMD/D
 tB+5gkArEFuZMN2GMhT9QUdCjM2dQxXwCv718HC1vY3RZQCScqhH4wIlrTw+EqyPp1K7
 oVAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773009350; x=1773614150;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=K5cAnI+aff4g+PK2Wvf2f+7IaZ9nLk9cnyQziXBBI8I=;
 b=BwZ2ymgxi24kVkBwmFptXgjNO3FXZS7rybwCXtfGaWFY8bPt/B3GiSmCevps0++V2i
 NsXGEiRFwi5TUbZNw4L7R3Pv6nj32soRWTr0twvem+G3R4AlBD9p7DAT3PihlB+vDqUh
 AI4G9A36RfUuv5xROEM78dy3u2hj6ITT35jqrTzh47GZpW4b4bJB+COjjbF4RFTlyEpI
 TBWxOteks2jAtAlWnslC20r+MntCjE3KaWrBhJakNUShbR8ZITeC1IRMXFwrEdM+VBzc
 PhwzCO8zO3PRIDdbeci3SNvmZOulBFke1EdZzd5Sli4cExTE0L69YBSMoAe9pbzr7nw2
 +azA==
X-Gm-Message-State: AOJu0YzvjpR2XVeqIeyXN7/r0P2D87ZN9BzjSXk4zHbMUHTpwAcooEsr
 Dck1Z7B+h4vgZ9BaySJ3C/rYqW/iYiMxdhsqc3LOlIr0aAg5xXcWwW2isHnWDY1Wc4nsbeJJwR4
 rGSXanbw=
X-Gm-Gg: ATEYQzzGdERjN1qWKv08uEECnEgmtonWwwZc3HfzzO8jw5GACF4zJea/LN6PIRns8ut
 FDAzDgYq+g+eo4ABQAkqXC5B7FNq+cOL37FfXyV72NHYdwKE0yyLtsE26E+qahNZTue/8NPzEEV
 FcVfzP5y+MMwMqQM7aaYtcEPH/950D/vG5ATc9Qv2H5qcV/AinYJkzuWVGco+Hun66ynO+Dal3H
 XexdIAN1aGWEhxeMY+0tp3Yx/w4SSbYviLYtFdJjTHmg9AQKEAkalyc1v13pzX1bpL1T79dOgod
 ScigvkYFb/vFsxYtBdMff0NotoN1ZozwXjguskE8+UFqLBl3VIzyeCCtOuldGNBuN2Gg1Tdv9S9
 ezB6lzk+bdcuWb2FBj+oSUp/PLvee0YeUVOY2WCyZ5J7srS4NvdUBk0K+a28MxHaabPa4Aj7DSW
 eKJwvoMq8dDDtXcpsdRdC15TuS8Xmtzni21qY4nextximvpGGvdU8ntlRWErnwQU70l6o/Ul4E+
 pKr7ROayGLlKiWq
X-Received: by 2002:a05:6000:2c05:b0:439:ad2d:99f7 with SMTP id
 ffacd0b85a97d-439da669111mr16608269f8f.28.1773009350079; 
 Sun, 08 Mar 2026 15:35:50 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dae2ba5bsm19299384f8f.22.2026.03.08.15.35.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 08 Mar 2026 15:35:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/49] hw/net: Build stubs once
Date: Sun,  8 Mar 2026 23:33:55 +0100
Message-ID: <20260308223433.25503-12-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260308223433.25503-1-philmd@linaro.org>
References: <20260308223433.25503-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

Move stubs to the global stub_ss[] source set. These files
are now built once for all binaries, instead of one time
per system binary.

qmp-norocker.c only contains stubs, rename it accordingly.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20260225035739.42848-9-philmd@linaro.org>
---
 hw/net/rocker/{qmp-norocker.c => rocker-stubs.c} | 0
 hw/net/meson.build                               | 3 ++-
 2 files changed, 2 insertions(+), 1 deletion(-)
 rename hw/net/rocker/{qmp-norocker.c => rocker-stubs.c} (100%)

diff --git a/hw/net/rocker/qmp-norocker.c b/hw/net/rocker/rocker-stubs.c
similarity index 100%
rename from hw/net/rocker/qmp-norocker.c
rename to hw/net/rocker/rocker-stubs.c
diff --git a/hw/net/meson.build b/hw/net/meson.build
index bf6a625a92a..31025874699 100644
--- a/hw/net/meson.build
+++ b/hw/net/meson.build
@@ -66,7 +66,8 @@ system_ss.add(when: 'CONFIG_ROCKER', if_true: files(
   'rocker/rocker_fp.c',
   'rocker/rocker_of_dpa.c',
   'rocker/rocker_world.c',
-), if_false: files('rocker/qmp-norocker.c'))
+))
+stub_ss.add(files('rocker/rocker-stubs.c'))
 system_ss.add(files('rocker/rocker-hmp-cmds.c'))
 
 subdir('can')
-- 
2.53.0


