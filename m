Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12772C83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 10:41:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubd5J-0004RR-Jj; Tue, 15 Jul 2025 06:40:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubd5G-0004Pt-Sz
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 06:40:26 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubd5F-0005lL-Cn
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 06:40:26 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-45629703011so2433645e9.0
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 03:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752576023; x=1753180823; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DUXxa+xP+Ej2YS3GTVa8ELdM0Yk7DkoIG4cYz8Z0G9Q=;
 b=eQ0QZrXXsncpYfCm6Irtxl4kP9mw+mmkzXywdqRmdjrtQPUn9Qsmc6OQiqJ2LbHYVV
 J8HGU7LxDB+2IH5DxLmjDDZYjdD9CJDq0r7+5/rLsD/GIeZzn57o2FODUdzH0jb7m3P3
 pPcOlhcukn340lh8d/sPxJES28bNgVbUFrIWwgcwRgIbwxOSaqMO0fbUN+N/QlN3ouat
 WanseawJPlMbu3C/G7R+l76D6Hp7uI4xh3w6fHZA6BuIrqY7QfGqkZEJwpt/QR5WOlWI
 nEISROua8Cf1m9muNezb/uvj0SJ2lQv8P5BFrc5Vh5Nkk6pFzst3+GHwQWGDSmvH9pCm
 J8Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752576023; x=1753180823;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DUXxa+xP+Ej2YS3GTVa8ELdM0Yk7DkoIG4cYz8Z0G9Q=;
 b=gHK1Hx5+F8sYrNCFBF0f2wEhse9/V+Wnx5UmFcKQ1vREN7RlMHNCKmIi9CJft7t+99
 ysybsx/Is6S8qAHEbmY6nmWFP+klvdnarnPyV52u5ERMpfbFg93Jd9NreNe16yH7G8SJ
 f6FAXw0RMonj2H6mE17nEKTchjE52mBQdnI3T9+pH2lCQ7M2NURKqjiLF2GGYdXK3Cy9
 DAHlOkYmE4vKkOFZNi51zHV9bjBiEWA6tyUDD49jsCCPjYwFGsuVvZRis205z5tYLQBG
 9zcyyeyWPEL+YNDQIUEnnWHOHpCdfEmkIEvtspLBs9iGLgYcgQB5s4YWasmYj5rj977V
 cOXA==
X-Gm-Message-State: AOJu0YwSuska4eZjo2DtcilEPRcjcM7lNLji7tRVWfqR/c+56L5JfX7M
 gZSyt17uthbYKW79mG24w+hIgsxGJ5Nxg9xMvoQ9jHqbJe3RvIpLlMEOxigefzSoX06NYavPeOn
 DgAgZ
X-Gm-Gg: ASbGnctZGlDkQzwk9via/oUZ9qQR9eh43Rn5hs5+D1YpXsxUMKgfzePbY9ajyFjXwXx
 10PbEspgqnAzIwbGN+V7GWMeNTyzACikOfYFWS9TdWVqT8yCfah31ve4/Ogj+qR3NvQmZtMulqu
 zDQBmuTA80y2L+hZ68NM443JcrfmpquaKAnuQ3eVa1WqLXZlgN8eSGrRzQ9xzzA0G6CsU5sqnUb
 9dsAr4GvmtY15mtoI5PVMql+tfQT6WD7RdeP1/nFekBQKAc/Mx9/15Mm9ZmP9yyQrr4MKlrB1Wu
 cH1tyXQgEf9PWENsKXJwg3iwMyv1Srqtx/Q8zgG0dtR1wq7cG8wEoePFX8NwIktQYgo1Q1J5shr
 c4nfDnnQ0sDLSib7q6QxCLE7NmBnTlvTZxQz1r5XXnOSbVsWQtqs9CBQXB/gX+Akj3RkQuQCCbk
 wRsA==
X-Google-Smtp-Source: AGHT+IFaelI3Y/OhaoirXt/g1U6//WLMrAmUFQs26iVTfbxt72am3vV4E2e7/Gk8FjFHwusZI1gS2A==
X-Received: by 2002:a05:6000:23c3:b0:3b5:f7a9:7f5e with SMTP id
 ffacd0b85a97d-3b5f7a97fa4mr8679778f8f.7.1752576022945; 
 Tue, 15 Jul 2025 03:40:22 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8dc1fd7sm14565314f8f.26.2025.07.15.03.40.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 15 Jul 2025 03:40:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Mads Ynddal <mads@ynddal.dk>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Paolo Bonzini <pbonzini@redhat.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH-for-10.1 v5 1/7] Revert "accel/tcg: Unregister the RCU before
 exiting RR thread"
Date: Tue, 15 Jul 2025 12:40:09 +0200
Message-ID: <20250715104015.72663-2-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250715104015.72663-1-philmd@linaro.org>
References: <20250715104015.72663-1-philmd@linaro.org>
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

This reverts commit bc93332fe460211c2d2f4ff50e1a0e030c7b5159,
which was merged prematurely, re-introducing Coverity CID 1547782
(unreachable code).

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/tcg-accel-ops-rr.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/accel/tcg/tcg-accel-ops-rr.c b/accel/tcg/tcg-accel-ops-rr.c
index a578698d071..6eec5c9eee9 100644
--- a/accel/tcg/tcg-accel-ops-rr.c
+++ b/accel/tcg/tcg-accel-ops-rr.c
@@ -302,8 +302,6 @@ static void *rr_cpu_thread_fn(void *arg)
         rr_deal_with_unplugged_cpus();
     }
 
-    rcu_unregister_thread();
-
     g_assert_not_reached();
 }
 
-- 
2.49.0


