Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9A14FA3750
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Jan 2026 13:02:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vc1Gc-000742-Bp; Sat, 03 Jan 2026 08:02:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vc1GI-00072g-3H
 for qemu-devel@nongnu.org; Sat, 03 Jan 2026 08:01:55 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vc1GE-0004mm-8s
 for qemu-devel@nongnu.org; Sat, 03 Jan 2026 08:01:41 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-477619f8ae5so80166385e9.3
 for <qemu-devel@nongnu.org>; Sat, 03 Jan 2026 05:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767445296; x=1768050096; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=9IPLx6CmtkWQSCXuojnIzcpfVqzldTzH9l9G8ubdk7s=;
 b=UO6Ui5+KLJlnC38LzWh2HKYVWIhGRy907tmDUFZEs6ZTHbA6SDGTK1SyyiZBf12N02
 GtkjhClkmHCKw62oX7KeZHkvQQVLPGhkcyeWu+pNr3eGE2yUeyjqyyjTdiYaIuC4kGe7
 kVj0AT/WxovNvi4R42YxuJOZ18VZdvSZTJ7pp9nFwjyjZgCQRRCGhaZG9zRCnoEsKW60
 QX3LPfX5WC+qXIsNv6hjmsdwgw0A75g6OBVhrI8K1flFzb8OiDipbd4adCdHrmnDNwu0
 ceSdrD5ObTRnCwzL6ZeqpfEX+NduwruA8RPpRNBTnn2Osq5j+974R3cSFOBLm9fz/fLn
 nTlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767445296; x=1768050096;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9IPLx6CmtkWQSCXuojnIzcpfVqzldTzH9l9G8ubdk7s=;
 b=G9mWYj1Nnu8oy806R/Q5vBDearadkgAypaGQhc3ZVBhTpJU1ExAzFlHGJpAQamLcAG
 pGzSNTbmLHY2O+hDPxcV2cHIdgTBF4Liavn7+HrGWcmyAGC5aNDHGkzMdzFSkHcGqC6G
 Wk6RamCfvCSnPVl5TSRdhVCveMGmuB4trTx2+CkBYyh5hrpi0XyA9WDQ3hMn7FfYHHvk
 IngdI1r1oXnuDLyLvbMvGKZLBheBQdJqoe5KS/p9NQQnGNtvjKJl4Nm3rWR/eyVTtZ5D
 mV1eU595MhGrX54PEZQvpMcMYRCusow5knDOkFWSV5PAd8fN+fLYsRP095wDZuGcOy+X
 cpdw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDf2ZB3xzKYfMPf5Oa0CybGTK/UP78eK492P1YOEwFMlWzg+xcCXFU5xjhD0mNXJW1ossk4ItHXazD@nongnu.org
X-Gm-Message-State: AOJu0YzpZXFRm6e0RySK01exGEM5cAjXlr7iXpJgJ3Rlmd+yfRqlfsfF
 nWKgYBp5nBThzLukizmtHGLQzidMU35IeCBtt+5PH0phjP55oqwssHzI3Qdz0yhVDnE=
X-Gm-Gg: AY/fxX6JorkSlHxI5e6zjp32W6ScON4b/nZVix7LU4E808E3tlUUoA+X7QMyNXjHCkP
 bSWDbwlp3l2lZ3+4+2mL8XlDaEzt1VeCGs4t6Uq1x7JnCvcTHv575QMXf/uxuI75rENvqDn1VKR
 LZ4hTjZz+bgD6+A1NDdgl8V3Sy2kSVdcoV0ejjNkUKko1XFIQlWTYahHxuYfRkxI7X3vaCazcFQ
 FAdTjtrD/D10jyl8fuR73OtG0drZ80ZtWjNzaVqMjmtoEng5FfRvDdnOadcsFfL6mSobukSEpez
 d4f4XaKDp5+WQztxQi45MIipOPY5cZy987X/xE2vbyt2e6UnFJl70P7A7lQWXwGcJO1Bf/zouRY
 +mu2C044jZOLhvXbo1x1f97tQLwqtJ6jyzjGv7IaxQI3zqghaTcS+CmyaxVmmPQyXwOfqQfHtug
 1wkv1UsZnlB1cHg91ZfzXUD6GtM56K45QHyV5hbZaRyQhKWfg/zjanwMD83CR8uV3gtmBndg==
X-Google-Smtp-Source: AGHT+IGLCUOq4ehE/FEO7HucM9LZMYVrsMvY+uaRXQMGUhi4uUkZEleTPQ4SusCYIF3q7w5vjZZSjg==
X-Received: by 2002:a05:600c:a31c:b0:47d:264e:b435 with SMTP id
 5b1f17b1804b1-47d264eb68dmr388696435e9.22.1767445295924; 
 Sat, 03 Jan 2026 05:01:35 -0800 (PST)
Received: from meli-email.org ([109.178.218.84])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea1aef7sm89437880f8f.7.2026.01.03.05.01.35
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 03 Jan 2026 05:01:35 -0800 (PST)
Date: Sat, 03 Jan 2026 14:54:31 +0200
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Gustavo Bueno Romero <gustavo.romero@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Phil Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Alex Benn=?UTF-8?B?w6k=?=e <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel P . Berrang=?UTF-8?B?w6kg?=<berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: Re: [PATCH v2 07/11] meson: fix supported compiler arguments in other
 languages than C
User-Agent: meli/0.8.12
References: <20260102214724.4128196-1-pierrick.bouvier@linaro.org>
 <20260102214724.4128196-8-pierrick.bouvier@linaro.org>
In-Reply-To: <20260102214724.4128196-8-pierrick.bouvier@linaro.org>
Message-ID: <t8ahil.2ih2pjydhjsas@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x332.google.com
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

On Fri, 02 Jan 2026 23:47, Pierrick Bouvier <pierrick.bouvier@linaro.org> wrote:
>qemu_common_flags are only checked for c compiler, even though they
>are applied to c++ and objc. This is a problem when C compiler is gcc,
>and C++ compiler is clang, creating a possible mismatch.
>
>One concrete example is option -fzero-call-used-regs=used-gpr with
>ubuntu2204 container, which is supported by gcc, but not by clang, thus
>leading to a failure when compiling a C++ TCG plugin.
>
>Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>---
> meson.build | 17 +++++++++--------
> 1 file changed, 9 insertions(+), 8 deletions(-)
>
>diff --git a/meson.build b/meson.build
>index a8fd8e88225..256cc0cdb21 100644
>--- a/meson.build
>+++ b/meson.build
>@@ -709,10 +709,7 @@ if cc.compiles('extern struct { void (*cb)(void); } s; void f(void) { s.cb(); }'
>     hardening_flags += '-fzero-call-used-regs=used-gpr'
> endif
> 
>-qemu_common_flags += cc.get_supported_arguments(hardening_flags)
>-
>-add_global_arguments(qemu_common_flags, native: false, language: all_languages)
>-add_global_link_arguments(qemu_ldflags, native: false, language: all_languages)
>+qemu_common_flags += hardening_flags
> 
> # Collect warning flags we want to set, sorted alphabetically
> warn_flags = [
>@@ -771,15 +768,19 @@ if 'cpp' in all_languages
>   qemu_cxxflags = ['-D__STDC_LIMIT_MACROS', '-D__STDC_CONSTANT_MACROS', '-D__STDC_FORMAT_MACROS'] + qemu_cflags
> endif
> 
>-add_project_arguments(qemu_cflags, native: false, language: 'c')
>-add_project_arguments(cc.get_supported_arguments(warn_flags), native: false, language: 'c')
>+add_project_arguments(cc.get_supported_arguments(qemu_common_flags + qemu_cflags + warn_flags),
>+                      native: false, language: 'c')
>+add_global_link_arguments(qemu_ldflags, native: false, language: all_languages)
>+
> if 'cpp' in all_languages
>-  add_project_arguments(qemu_cxxflags, native: false, language: 'cpp')
>+  add_project_arguments(cxx.get_supported_arguments(qemu_common_flags + qemu_cxxflags),
>+                        native: false, language: 'cpp')

This is a subtle behavior change (qemu_cxxflags wasn't filtered through 
cxx.get_supported_arguments previously). Do we care about this?

>   add_project_arguments(cxx.get_supported_arguments(warn_flags), native: false, language: 'cpp')
> endif
> if 'objc' in all_languages
>   # Note sanitizer flags are not applied to Objective-C sources!
>-  add_project_arguments(objc.get_supported_arguments(warn_flags), native: false, language: 'objc')
>+  add_project_arguments(objc.get_supported_arguments(qemu_common_flags + warn_flags),
>+                        native: false, language: 'objc')
> endif
> if host_os == 'linux'
>   add_project_arguments('-isystem', meson.current_source_dir() / 'linux-headers',
>-- 
>2.47.3
>

