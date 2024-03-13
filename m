Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5D36C54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 21:36:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkWFb-0002ny-PG; Wed, 13 Mar 2024 17:35:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rkWFW-0002dk-E7
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 17:34:58 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rkWFU-0007uM-MI
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 17:34:57 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-413eae3e60fso2356565e9.0
 for <qemu-devel@nongnu.org>; Wed, 13 Mar 2024 14:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710365695; x=1710970495; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VjFF/emaV5I47SwmDiH67MtfM0ApKa6V2RibuZZpLqM=;
 b=RmRXLQTh7PjdOFbSwzTizMysQCcL1WlTfo4aT63HDTtcS9vx/dHI8eS/2oggXM8DuG
 GCEN6L4jY/OuaO/6r8FeA3vdIPjleXC/0VioeBOZS/zSO3Ma4SqLEOkTFM4xnQMhAeA+
 ByHK7dm7kd+yauPaM2BXHCPFEFhAX/gfnoR9zI7Pg3wg05YWRbUDcJ6BKLmTGGccvIb2
 bc1G8+KtzSAVvDrC8ZN0SQmoegMCQ8wPaE4rvay6BXU4/AGwUCQ5YwB7aNCiuQWazk76
 YdYnt1FS8LLECtnKkK6xJH8BIPs4x2EWfzBY724pYQDYwAqxLy2iAmp39D1PF6Hm0N5n
 gclQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710365695; x=1710970495;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VjFF/emaV5I47SwmDiH67MtfM0ApKa6V2RibuZZpLqM=;
 b=VpksHky9UQPQywXL6JpQTf3hEaunIOcn16Q4g56z+VxTwEx3olVPSpgdbAHnZiB51J
 StrTL7PrMUlJspnWl4iyPNBPEkeJuHfSEw3wV9080rULzAo0nJYkdJTEBV5Vh61wBOkm
 o0bmNRFiAkk5BN3lOln2OyOlm1lwFx5NfmkmIq2FCSYjYqrgV616sQLo7P/rKhO9Y+I9
 g0aJbTP6O0ncNWIcYNyy4i/RiwSj6klmHoSHX8ZijLHSK3Yhmpj2ZnmP/KapvAfncsP5
 pysLJBgktTJNTJnJdqtAQHEyfxFPZ4Y02t/w8akUy4dJ4pKnhB1IDcgOeRMaWotgkQLY
 MZpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4x7tlW/urF/F4ClZSvqcfbOcq91dnXmYB+T+g+2g+MOtRsvm692CHZRegBdbXDvWQuwLJOhKAJomZnDaPKULd5GYJWEQ=
X-Gm-Message-State: AOJu0YwQJQ1fjcAWBi2KXuOmFKJpF46f7NKxeHbpriVYfkE4qz0NDLGk
 Fj17/f0o/vo6RWRCMADOsZm5e5aH9wmivj5kOsZTRKX6igC2xIz1Niq2EdP8cjQ=
X-Google-Smtp-Source: AGHT+IGvVFnKVB4YCKq5G1BWVXs6q9ctUFuLgTCKoZuwnlwgYiu5x58GIiOvtjK3sfbmDorxEjtz/A==
X-Received: by 2002:a05:600c:3581:b0:413:2fce:3ed2 with SMTP id
 p1-20020a05600c358100b004132fce3ed2mr17746wmq.35.1710365695414; 
 Wed, 13 Mar 2024 14:34:55 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.182.179])
 by smtp.gmail.com with ESMTPSA id
 d20-20020a05600c34d400b00413f175aaabsm140030wmq.5.2024.03.13.14.34.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 13 Mar 2024 14:34:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-ppc@nongnu.org
Subject: [PATCH-for-9.1 11/12] tcg: Remove unused CONFIG_SOFTMMU definition
 from libtcg_system.fa
Date: Wed, 13 Mar 2024 22:33:38 +0100
Message-ID: <20240313213339.82071-12-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240313213339.82071-1-philmd@linaro.org>
References: <20240313213339.82071-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tcg/meson.build | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tcg/meson.build b/tcg/meson.build
index 8251589fd4..b5246676c6 100644
--- a/tcg/meson.build
+++ b/tcg/meson.build
@@ -42,7 +42,6 @@ user_ss.add(tcg_user)
 libtcg_system = static_library('tcg_system',
                                 tcg_ss.sources() + genh,
                                 name_suffix: 'fa',
-                                c_args: '-DCONFIG_SOFTMMU',
                                 build_by_default: false)
 
 tcg_system = declare_dependency(link_with: libtcg_system,
-- 
2.41.0


