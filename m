Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D154C4829C
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 09:06:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYMpR-0005K0-J7; Fri, 09 Feb 2024 04:05:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rYMpQ-0005Jl-SL
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 04:05:48 -0500
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rYMpJ-0000fR-01
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 04:05:47 -0500
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-51171c9f4c0so836057e87.3
 for <qemu-devel@nongnu.org>; Fri, 09 Feb 2024 01:05:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707469539; x=1708074339; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vBAiggojLFMqRRiAH15aXDVwluwADGNW6uYXJNwpeRo=;
 b=cHdsujh+xZDQKZLmBFmpKhXVVeeDXvJkXzKPuNp4hyCeWVYQUfP+E+R+r7vFJhv9Yg
 sTSezOWYdMH7YIMgimWNdjIncJwkJnG8c5TpkLhP1tX9iBL7gSQpQNPttPtMl00AEmYC
 OH0tsY2UnsOlvs/9IvtTvjc5uR5NC5UM9MfZL9spATEelhE6zATO42DUEMjGcwHgHDsY
 KG8NVs0MXWSXuM4/gQ23iSJdcy/4MbzsAf2WjJZjqEOkJlSVM2xg54OFjUMqPsUqEo7g
 Brwax6SmrTPKm6QRXghnYDvUtOgVxTy1IZVBOzigINEy8906PIxi1fU2S3ZU447+Jp6g
 zWXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707469539; x=1708074339;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vBAiggojLFMqRRiAH15aXDVwluwADGNW6uYXJNwpeRo=;
 b=uDNEAuiL4HpaNRzBidgja1UN57ijcLFB55SLejMKAT1vlQ2vJ+jrA8wmCruDJ9Ngi0
 Y2xw4jHcjpOnj+UW3nGEcRnhCTcFeEyQATEIOVk4OHmJopiK3YYXYkifNxVIkz/fjC9f
 vdB5kxooxjNfc+wHUtnHioIaLWY+PC3hXr36IVrwXB2Ux5r2DVm57JSeH94As8WXXr63
 tziFsoCvXV6KiJUBhI5iZlDuSL0+ATUvkcLVK8TtZjTxd4Jv5Pi4wlE7/sznPv5ngCZL
 QHON+0ya7zYGT00KDL9IK/mSSMYAx/TaDNcWbyvQqSo7KHFXPTLICzuKAl7XNw8c7T2R
 jouA==
X-Gm-Message-State: AOJu0YyRDKipPiV21NGg0saz5gwa8cC3qjDUdmXd9y0qYoywrjPz9/8u
 HAmvCiC+ABYhn7+ODfLYpVkjETz1VAmDxEx8o7SanCHfWOtmbxXu6DFX0UUNv6ExxVXdb+B4jdq
 eBwU=
X-Google-Smtp-Source: AGHT+IGCk9aepGNlXHq7UsXwKELFgRnLJxuY+wBh+GQtx/txlOXs8AtbXwhG6BtHwZAUgwBTBLqrvQ==
X-Received: by 2002:a05:6512:370f:b0:511:642e:de27 with SMTP id
 z15-20020a056512370f00b00511642ede27mr498553lfr.14.1707469538889; 
 Fri, 09 Feb 2024 01:05:38 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCX2cPCzAkO75j+ShUO5/VW+l8xxOQELmK1Pb7nZHVX4cW+FQUapzkqc+2h/aCpzReLhYgVAPmGF8wyYoQteU/jYSVM66Wu3CMcbEYL2lvpQE2Zi9y3l4SFRgmMOMbLga8Z39RTcJG9bMpcikM/dR2p2Hi+GjcPUUTM/5oYQGJWnC8DyXRjF/46/uP7Ni7t+sl6si5KlJHfsEo6PD9NJgSNP9u3Ra8Yb8z48llmp1q6KZOQd8p4XtX0HAMNibyD3/q8ziLKlXIpl5CCealQd6eJCLuXLmnwVcu/iddVaSAdVkrpMy8O4IfDH8LxLLCZkPE+KtedeH/eczuOoYbMISGieL0XNjKo=
Received: from m1x-phil.lan ([176.187.218.105])
 by smtp.gmail.com with ESMTPSA id
 iv12-20020a05600c548c00b004100c0882fdsm1937958wmb.31.2024.02.09.01.05.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 09 Feb 2024 01:05:38 -0800 (PST)
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
Subject: [RFC PATCH 04/11] target/mips: Remove CPUMIPSState::saarp field
Date: Fri,  9 Feb 2024 10:05:05 +0100
Message-ID: <20240209090513.9401-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240209090513.9401-1-philmd@linaro.org>
References: <20240209090513.9401-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x136.google.com
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

This field is never set, so remove the unreachable code.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/cpu.h  | 1 -
 hw/misc/mips_itu.c | 6 ------
 2 files changed, 7 deletions(-)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 6ec2ff4b97..3b93591f7e 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -1174,7 +1174,6 @@ typedef struct CPUArchState {
     uint32_t CP0_Status_rw_bitmask; /* Read/write bits in CP0_Status */
     uint32_t CP0_TCStatus_rw_bitmask; /* Read/write bits in CP0_TCStatus */
     uint64_t insn_flags; /* Supported instruction set */
-    int saarp;
 
     /* Fields up to this point are cleared by a CPU reset */
     struct {} end_reset_fields;
diff --git a/hw/misc/mips_itu.c b/hw/misc/mips_itu.c
index db1220f8e0..d259a88d22 100644
--- a/hw/misc/mips_itu.c
+++ b/hw/misc/mips_itu.c
@@ -516,7 +516,6 @@ static void mips_itu_init(Object *obj)
 static void mips_itu_realize(DeviceState *dev, Error **errp)
 {
     MIPSITUState *s = MIPS_ITU(dev);
-    CPUMIPSState *env;
 
     if (s->num_fifo > ITC_FIFO_NUM_MAX) {
         error_setg(errp, "Exceed maximum number of FIFO cells: %d",
@@ -533,11 +532,6 @@ static void mips_itu_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    env = &MIPS_CPU(s->cpu0)->env;
-    if (env->saarp) {
-        s->saar = env->CP0_SAAR;
-    }
-
     s->cell = g_new(ITCStorageCell, get_num_cells(s));
 }
 
-- 
2.41.0


