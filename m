Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AB48C4829C
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 09:07:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYMpi-0005Z5-2i; Fri, 09 Feb 2024 04:06:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rYMph-0005Yv-3j
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 04:06:05 -0500
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rYMpa-0000gp-6a
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 04:06:04 -0500
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-511531f03f6so773581e87.0
 for <qemu-devel@nongnu.org>; Fri, 09 Feb 2024 01:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707469556; x=1708074356; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y81PALGbwlj4LEixOoZpqNxmKjEUvcPM6tG+ojj/Tqo=;
 b=mZMa+xlH6Qx2ODQA+x5BTdPrSSuztNawoKibzAZGj4bLPD1VerPW0oNsqLGxflge0A
 qLtKh+RsjfiTSr1MuyIoYFmMGhcee29GY7BGmaB10y1ooQIqE10u1kEygNAOxDncyEiq
 IQga6qmuDvoACPun9whh7BRMjxjXmphc+kuq3mtIXB+tSsdcl7qOXvzyR9z4GGcDieQ0
 exxTf3K38o4adflZW+v3HgSOdsj7Gae7D8l952UpGul8tJAryobJxQNyewHVWkj/3+EJ
 vqRCeHnkQXh9nmA0oZ+IpPW6skJeJ2SkPQ+unoQAzoVTMCARirHEbg6RRclp504wrAF+
 4WmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707469556; x=1708074356;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y81PALGbwlj4LEixOoZpqNxmKjEUvcPM6tG+ojj/Tqo=;
 b=tbnRegYsb3e47+LL4oYIOYRnGwu2OrV70/zEmKMKB1aJC0oms2R5IOYVmRNfJPQuFq
 wa1Ev13czWWf52cn+ekY6jfpQiFvB3FZEb+lZKVaRgKBDodX7lsm6iG+iO61cwTrsl/3
 vjMJAib1SBgDZB/07Izld7CETZaj6dN5/EnSjXJ4SjAF/wRWb+WFXyD8MT+9G2YjRqum
 dg6wHZ2ino9IuMj487FkSiuCZd5UhykxilU75FPMg8paD0bzB7LdKgDG913aUT98oKFh
 zsyuKtggdYk8isPqH+y+UeO4NtIB9zNPxzbiFAhsjqhnCTE4P9sqEWyy7AjviJLiOVMT
 PgLg==
X-Gm-Message-State: AOJu0Yzf6cD9TPiGJ7vuobKPJmacldzIKLwmkgSxnMowKVDST24ncMSx
 UUiHPH98fyZWn24z8HEjSZFrHd+K7LIY7levPZIFwR6N2lQHKneKVAnMZljVm628RsyYv4DLh3u
 +fvQ=
X-Google-Smtp-Source: AGHT+IFBuFXpwbtgzFL/ZSi5c5D0ry4wCj30RuC0r4bpYWTUeUPXVQCvcGc5psKBmOzFu279Rqu0Tw==
X-Received: by 2002:a05:6512:404:b0:511:4ff2:ee40 with SMTP id
 u4-20020a056512040400b005114ff2ee40mr666294lfk.2.1707469556462; 
 Fri, 09 Feb 2024 01:05:56 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVt38m0p3DJ0l2NasgWE0AqkuiW4pq80U3G2dLbCONtGfGnaQ97Ck3nNZ6M7DA+4/3ElYE0U5xV1BafjVeIvDVJi+Huql0RzojZgQZyhGS1CLubnoD/lI/0HEnLJThpwMtcQ/S9ksp+Wt82f+Vtm9YV7Sszgb8oPN1bmXbx5NpCgTOALjs2E6PoSYbfvEba3nVKVp1z2wmZDvPXm1zmVo5M/M477gsXBeMEVyrZY48K0m8EUmukbc2KN/ftlrYoVB+5XEWL4V1S/PjiLl6M6RtiRQNjrYYNoBQziyYdObydyfyN6JwethpCaY/Ge59kEQk9tKYd5kr9AWPSEAWCR+L7HIvJhuU=
Received: from m1x-phil.lan ([176.187.218.105])
 by smtp.gmail.com with ESMTPSA id
 t16-20020a05600c451000b0040ecdd672fasm1915559wmo.13.2024.02.09.01.05.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 09 Feb 2024 01:05:56 -0800 (PST)
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
Subject: [RFC PATCH 07/11] target/mips: Remove CPUMIPSState::CP0_SAAR[2] field
Date: Fri,  9 Feb 2024 10:05:08 +0100
Message-ID: <20240209090513.9401-8-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240209090513.9401-1-philmd@linaro.org>
References: <20240209090513.9401-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x130.google.com
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

Remove the unused CP0_SAAR[2] registers.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/cpu.h            | 1 -
 target/mips/sysemu/machine.c | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 3b93591f7e..e621196ae1 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -749,7 +749,6 @@ typedef struct CPUArchState {
     int32_t CP0_Count;
     uint32_t CP0_SAARI;
 #define CP0SAARI_TARGET 0    /*  5..0  */
-    uint64_t CP0_SAAR[2];
 #define CP0SAAR_BASE    12   /* 43..12 */
 #define CP0SAAR_SIZE    1    /*  5..1  */
 #define CP0SAAR_EN      0
diff --git a/target/mips/sysemu/machine.c b/target/mips/sysemu/machine.c
index 218f4c3a67..6d1299a89e 100644
--- a/target/mips/sysemu/machine.c
+++ b/target/mips/sysemu/machine.c
@@ -282,7 +282,7 @@ const VMStateDescription vmstate_mips_cpu = {
         VMSTATE_UINT32(env.CP0_BadInstrX, MIPSCPU),
         VMSTATE_INT32(env.CP0_Count, MIPSCPU),
         VMSTATE_UINT32(env.CP0_SAARI, MIPSCPU),
-        VMSTATE_UINT64_ARRAY(env.CP0_SAAR, MIPSCPU, 2),
+        VMSTATE_UNUSED(2 * sizeof(uint64_t)), /* was CP0_SAAR[2] */
         VMSTATE_UINTTL(env.CP0_EntryHi, MIPSCPU),
         VMSTATE_INT32(env.CP0_Compare, MIPSCPU),
         VMSTATE_INT32(env.CP0_Status, MIPSCPU),
-- 
2.41.0


