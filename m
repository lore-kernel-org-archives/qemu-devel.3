Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF23DCA0FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 06:55:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usyRr-0002CJ-BD; Mon, 01 Sep 2025 02:55:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1usyRp-0002Be-83
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 02:55:25 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1usyRl-0004i7-U5
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 02:55:24 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-b0415e03e25so120158566b.0
 for <qemu-devel@nongnu.org>; Sun, 31 Aug 2025 23:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756709718; x=1757314518; darn=nongnu.org;
 h=mime-version:message-id:in-reply-to:references:user-agent:subject
 :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0xWX6XMK1RH4GwJTomShFt84b8vw11zBJnho3OvRg3Y=;
 b=OLRPRrxzZkgtoFlhbTA6/1V9ULHWbJMI4bUmus+TvIQGSEHESdpi1XDlBv7AjIxYaH
 wfzmnubDdJOxONnZ91jT8pwERAtICWPsIc4g69Sm+r9wtRgm8k/b93oS0An9o1DMiCDc
 W7RzTusvKWxDrriILsji6PA6HNnaI82JFgwVc+rXYzjoFs+zw9XNkn6bYhfbIeykQXsP
 q0oUrUSOxeLBB59kOUm6CmmJqn5emxkcmO7dS8/OPrTAMNAEKXfoR109hRW1chtPzF54
 gx+RHWK63krJUcE5tr813A2hBDKrCzHwo6xR+e7mJ5btiMD9BhJsaa29IT3TVH43qF+k
 12MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756709718; x=1757314518;
 h=mime-version:message-id:in-reply-to:references:user-agent:subject
 :cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0xWX6XMK1RH4GwJTomShFt84b8vw11zBJnho3OvRg3Y=;
 b=ENUBjGn5XLMCZ9wKij8FvzS30PboFiwGevO1ktOIA9LPzGzhTYJYze5YfY2/88HT/h
 E9N9kIWqFfCBdb8PNKLVuiP8jnfXlx4Uoi4lkKpn8khZQrYrxadB/Yymn4Scjpda6tqO
 i3fYrLLZA90l+DmncDEwJdqAy4XytVC8CoUyD8/D37frNQZBpDogh8XrDXYT73iltjI9
 fvcGdYnJb+it+fv2BDhw3y73mzeuV5rqWrdxprciwnKLX9BDX5gBnTLufPAgbWjXsYRB
 AubW2hJYkKynXi1XnD0eKR3lCAew4iVDrxzFtrh35JpLs9jaXo0Po2qpIGksG67O4wzX
 HhZg==
X-Gm-Message-State: AOJu0YwM1Xml153R5fbNkms8edpIcTgqTnDRsFermaIexdY4e9KLjAkP
 rjtOCczc9mdjyWsxJBHHU9FhG2/FqzfFW2SCCHGw/Rk4WUGvjRo9EUpvXVJRUumK8WN+Eh1/tQS
 BTfU1
X-Gm-Gg: ASbGncuQOyHCnWn4kghYZCcyA6ofY6Oi34iCYddM/IFM2HAiGlizYn1uxzeacnNEdoZ
 +ikQxYqsRSpakbe8VBg6Y1nB3oAuO7pSDanJk1nhewlj3mDmWRYYvPN5AE5xu7X5tTFzZnycSX7
 aHmWVNB5DcpGfOCzRZh49kmm4NDuKSCbHB5/pcZT3uUzjEj+4YgFpwjAbZhuBgX76Xkp8wS4xg+
 N0pvWmntv1d/9YrqYo8/2T9PI9HD6hSrbDZ5q1RLNAeNrYiTDH4Q1BlVf1CYrZOH90LLGd2dloP
 bNfg3QJPpVDpeLAkKcnDvor9G17yrpYaIX1mnyt3NQR9KrqPmgaNr+uGjPDWTd3qg9w2gyiuFg2
 MYXEaPQWGPp1zS0F9k4lm0r5PwXOiNfQFFKmmukKT9Boe1wGYQqhQ6zGpixfXiFD5RhI6A/OIYL
 ahRwHonhM=
X-Google-Smtp-Source: AGHT+IFAp+leh+xUu+VPGxOcyugwdkp6l1Nr4jErPzJQvNmiWrlHU+UC6K+QFiCET656s7UZEdjFIw==
X-Received: by 2002:a17:907:2d06:b0:afe:b781:e89f with SMTP id
 a640c23a62f3a-b01d8a70a40mr692042166b.17.1756709718059; 
 Sun, 31 Aug 2025 23:55:18 -0700 (PDT)
Received: from meli-email.org (athedsl-4441256.home.otenet.gr.
 [79.129.180.152]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b0410138d0asm392137366b.53.2025.08.31.23.55.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 Aug 2025 23:55:17 -0700 (PDT)
Date: Mon, 01 Sep 2025 09:55:02 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-arm@nongnu.org
Subject: Re: [PATCH 37/61] target/arm: Implement isar tests for FEAT_SYSREG128,
 FEAT_SYSINSTR128
User-Agent: meli/0.8.12
References: <20250827010453.4059782-1-richard.henderson@linaro.org>
 <20250827010453.4059782-42-richard.henderson@linaro.org>
In-Reply-To: <20250827010453.4059782-42-richard.henderson@linaro.org>
Message-ID: <t1wdw4.2uz7xzahoegpk@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x629.google.com
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

On Wed, 27 Aug 2025 04:04, Richard Henderson <richard.henderson@linaro.org> wrote:
>Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

> target/arm/cpu-features.h | 10 ++++++++++
> 1 file changed, 10 insertions(+)
>
>diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
>index 5876162428..7a0e515aeb 100644
>--- a/target/arm/cpu-features.h
>+++ b/target/arm/cpu-features.h
>@@ -599,6 +599,16 @@ static inline bool isar_feature_aa64_mops(const ARMISARegisters *id)
>     return FIELD_EX64_IDREG(id, ID_AA64ISAR2, MOPS);
> }
> 
>+static inline bool isar_feature_aa64_sysreg128(const ARMISARegisters *id)
>+{
>+    return FIELD_EX64_IDREG(id, ID_AA64ISAR2, SYSREG_128) != 0;
>+}
>+
>+static inline bool isar_feature_aa64_sysinstr128(const ARMISARegisters *id)
>+{
>+    return FIELD_EX64_IDREG(id, ID_AA64ISAR2, SYSINSTR_128) != 0;
>+}
>+
> static inline bool isar_feature_aa64_rpres(const ARMISARegisters *id)
> {
>     return FIELD_EX64_IDREG(id, ID_AA64ISAR2, RPRES);
>-- 
>2.43.0
>
>

