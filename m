Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5791DC48297
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 09:06:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYMpo-0005hA-Oz; Fri, 09 Feb 2024 04:06:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rYMpn-0005dk-DV
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 04:06:11 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rYMpl-0000hg-PM
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 04:06:11 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4104ebb050fso5915755e9.2
 for <qemu-devel@nongnu.org>; Fri, 09 Feb 2024 01:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707469568; x=1708074368; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gRuwxY5D1EAUKTX9jFR33otPw/p1Vrj/2Hj0XEkzveY=;
 b=kWP9h7YUXdpnoBQ+3wL2ywDotRo4tb98mDmaP26/qou7O2VlOeiA9NWz5uoJamb8ov
 R9sTUh+0pDTiIUg2b2n30/1WuxMM68aGD48BJgpGR11syANU6PoqNkesZBLhD2AYX43L
 SL9l8vfbTZcgHw9bEffek45103zSh/Y1NPBlWQ19gkuJHwZimZ05RaRKhLrPePrHMPkC
 mpsctCjLQv7AKXiJEbCzHPR6MdPi3cEDiKLy7Gdg+Cr/xnD6SpcH9dbkymwh27DKA0OY
 fM6rHifOd6/KmYBg1FzLehLxtqcFbV4mfySgPk7sGWfZJaJzQIVxNj6BR8CkW683HjPM
 CzyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707469568; x=1708074368;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gRuwxY5D1EAUKTX9jFR33otPw/p1Vrj/2Hj0XEkzveY=;
 b=jnia9hzTWodpQCelmxLn6xffNWRIuP5tVwbQWq+1ZrDSO6dHWBQbX2M/BmO8DvtNkw
 VU/KwPDTmZ0nih8+OiHopaHi8B1UqBBaFQCLdf0RDw86p5OXvuRsWNxkOpavyg0RzpNG
 FHLl1GEqYuMvVyGRrH/c13+GAe2WuDPxhJpnLZHgwfgx+s/CjaQtXHSw1veNohMv31jE
 OKv9cnvb/HRK3mioXigipas07++WDEZIp/jfG0tE/Y0NpfANA4ZqE6muYCaI2163c/ko
 wzV0DQduP5LOXoakDCaeC7PQsjVldEwdxIgSmshljO61t/4M6f+4XVpylF7ROyjWXHgg
 v9hg==
X-Gm-Message-State: AOJu0Yxi80k3R2mdf/Ap1Fl3dT3LJVgeoQlB5DAXiVBbQNwabDdQzCC7
 gWfuRlbUw4tWdlbQZledX+J9mjsSqZ7UWV+ZS588T6I7TpzcP7AWaBb13TG83NqrhICkv8nOKOM
 dtQI=
X-Google-Smtp-Source: AGHT+IHj+KrYyPW0MAJH0BwErwuJy6U+X1GLmvGDm3tCwMALMrLfZqKXPDC98XmIcw/+Wyd56sFKOw==
X-Received: by 2002:a05:600c:198a:b0:40f:b345:6639 with SMTP id
 t10-20020a05600c198a00b0040fb3456639mr842351wmq.27.1707469567975; 
 Fri, 09 Feb 2024 01:06:07 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVIivmQIrlGlHyznRIGFlAhU6xLjrfSnWCe3a5ybvxJ07IFpjR+ZDTxJGp4boitXmIK2lw3M+WFiV/9xIPDPNLMxE+XdTlTawzu0M25uAiTiE35W/Ay5qjd/gJdTOCKSG4c0xvjyLFEQ5ynt++xh+vgt2EYZcrAUxdcZaxXPmCdlIu2P5GtY3duBOPeHYBXv2MOjgQtql+FQCZqE8b6k3VGo36dZO56Mj3yae8iIcW5tp0/Yx+51eTA4bUuyyOYRFRxC3rlPSLCTnvhZILmx7k1F0xYSIHVqo8B3ILyYkk3Vdh9lf4Gl5+3rjaId835am1m9kzFEPy6AylcmOBWUzr0oZOlarc=
Received: from m1x-phil.lan ([176.187.218.105])
 by smtp.gmail.com with ESMTPSA id
 u6-20020a05600c19c600b0040fd1629443sm1950235wmq.18.2024.02.09.01.06.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 09 Feb 2024 01:06:07 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Laurent Vivier <lvivier@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Huacai Chen <chenhuacai@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
Subject: [RFC PATCH 09/11] target/mips: Remove CPUMIPSState::CP0_SAARI field
Date: Fri,  9 Feb 2024 10:05:10 +0100
Message-ID: <20240209090513.9401-10-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240209090513.9401-1-philmd@linaro.org>
References: <20240209090513.9401-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Remove the unused CP0_SAARI register.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/cpu.h            | 1 -
 target/mips/sysemu/machine.c | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index e621196ae1..c65e5fa162 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -747,7 +747,6 @@ typedef struct CPUArchState {
  * CP0 Register 9
  */
     int32_t CP0_Count;
-    uint32_t CP0_SAARI;
 #define CP0SAARI_TARGET 0    /*  5..0  */
 #define CP0SAAR_BASE    12   /* 43..12 */
 #define CP0SAAR_SIZE    1    /*  5..1  */
diff --git a/target/mips/sysemu/machine.c b/target/mips/sysemu/machine.c
index 6d1299a89e..213fd637fc 100644
--- a/target/mips/sysemu/machine.c
+++ b/target/mips/sysemu/machine.c
@@ -281,7 +281,7 @@ const VMStateDescription vmstate_mips_cpu = {
         VMSTATE_UINT32(env.CP0_BadInstrP, MIPSCPU),
         VMSTATE_UINT32(env.CP0_BadInstrX, MIPSCPU),
         VMSTATE_INT32(env.CP0_Count, MIPSCPU),
-        VMSTATE_UINT32(env.CP0_SAARI, MIPSCPU),
+        VMSTATE_UNUSED(sizeof(uint32_t)), /* was CP0_SAARI */
         VMSTATE_UNUSED(2 * sizeof(uint64_t)), /* was CP0_SAAR[2] */
         VMSTATE_UINTTL(env.CP0_EntryHi, MIPSCPU),
         VMSTATE_INT32(env.CP0_Compare, MIPSCPU),
-- 
2.41.0


