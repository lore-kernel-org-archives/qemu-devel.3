Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4159D26D77
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 16:52:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veFie-0005Mi-3I; Fri, 09 Jan 2026 11:52:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1veFiC-0004Tz-AF
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 11:51:46 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1veFiA-0007Mn-OI
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 11:51:43 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-430f9ffd4e8so1588239f8f.0
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 08:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767977501; x=1768582301; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U+LBKH6mpM3QJZ+LjMWVH1Zu0cPNjKfwSazzmUt2kNQ=;
 b=m4y5G2+ZS4IJhWwwb8YxgesPPKehzwG/mRU/TBCvTqIWl6IiT4EgZN3ikwglskB21a
 cjZd6FFYbEc/N+km1hWQR7a56z/JrYZNlplFyRwBqL5UeqS1T2DoG5u7nrZ/a85CcGCF
 6XWGILPrWZpWC6ImDvBng3GFZorLjlpmFBRgPLizukm28U41WjIMWuhgThBF/nIbLf85
 FcfsLoNUrS3dt0SQ1PrXa9gUYZ8OZCnUCvBNsMZurZwbGIZ4bKxOOlogOHpSxKEsOGWy
 wOex5WU3wvKgEPbm6uDajQNF8EeuJyU9GQIJESiq/VjG8+ZjYhNw0QKp1mMLTTERcOQb
 ZDOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767977501; x=1768582301;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=U+LBKH6mpM3QJZ+LjMWVH1Zu0cPNjKfwSazzmUt2kNQ=;
 b=wt78en3yFXvUsMzwNGSunXQpAEbwHMgXaabEmcy5VofDQ/xFSGh0CX8KNKDU+TWAvn
 x6klD3zlSD0fNSUYAkX22cOSmrOkg0CgFmky6NdV9fs+tbdJeK9h7xHDaP2o4uegSLVq
 DajMiIlEqsN5KBSR5wz4kHJHecd5Z+8qx3Y9EAs4WDWYVQI6ZK6SdXU/eLo2T02WZLl5
 urUSAb9iR/JJ58ii83SCv1ht5wta8pKH6wSnm7tqZMPV1AXdDzy4tYefuRb2zW2DMUar
 4mvF24YYOLtwhXk1YXu2hz+uLfrGSgtoXDsQk0dx0NzTUd0cU1frZ0DjVY+oYsBj4bCR
 uvfw==
X-Gm-Message-State: AOJu0YxKx1HR4unNEgU3rHUCEXtarlLMZsTQdsqYo4RZptoHW3jJ+00m
 JqBf8kcJtAZd/tvNFijDQJrEpClM1CMsr+AK/3p2Go4owl+GdFeV2dAifhF0YgL9fM1BvvDuG2f
 rHIU8tAI=
X-Gm-Gg: AY/fxX7PT3dwV0GO4ssBJQQoJD/9CRZZTFu6s8NPunPM/rwkNb+3LI3aebpWrqogNw2
 cOwax9qWkG8In/fb89VPmG3ZgrfuVBBWJn3o0a/UqmKgsAR52bk5AyKOg/lvi+bKs6w2N/4fXy3
 IcZpitWFuqPSHiff4B+iGUwJQNBgBWSNGKuBseAFZZO1xY779nsduiP7nsGXKWzEOtwOtojOB6d
 hLmvJrTXnao+TQ6r9AHtq0/zz7wB8VU4EFLl9yJmei60IOoRFZOi9ZVfktV5q5GzgckD1CIYfZu
 GasbnR3GOUiJbynAe+AIJqkYUz89aIeJfOqLG7IM7+JnSLuRH2w9MvVnctbjFWiRHIsEtMa/vTh
 6qQF9I3KZ2yhNYsScLJh4/b+22jqs5FJhv5CGBiE7dgrPU4Ewl3Niya2yvWIdYESPPGgbYvWeQr
 ne/YVm+P/bYdB0YAVhjLphdoly19FlAwaCwzXVY5BwQxidqz7HLDS2yMOiib5p
X-Google-Smtp-Source: AGHT+IGoMEq0bX5JvsRzIiHBvXP/6pDml8y49xujT8nIvbda4EFgshuQg2hcGtvAedZSBgdDdvftuw==
X-Received: by 2002:a05:6000:1786:b0:432:84f0:9683 with SMTP id
 ffacd0b85a97d-432bcfde908mr17273245f8f.24.1767977500643; 
 Fri, 09 Jan 2026 08:51:40 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5ee870sm23391308f8f.36.2026.01.09.08.51.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 09 Jan 2026 08:51:40 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Anton Johansson <anjo@rev.ng>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v5 06/22] system/memory: Inline address_space_stq_internal()
Date: Fri,  9 Jan 2026 17:50:42 +0100
Message-ID: <20260109165058.59144-7-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260109165058.59144-1-philmd@linaro.org>
References: <20260109165058.59144-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

As its name suggests, address_space_stq_internal() is an
internal method which can be inlined like all the other
ones in this file.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 system/memory_ldst.c.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/system/memory_ldst.c.inc b/system/memory_ldst.c.inc
index b45bfecd137..d5776678edf 100644
--- a/system/memory_ldst.c.inc
+++ b/system/memory_ldst.c.inc
@@ -422,7 +422,7 @@ void glue(address_space_stw_be, SUFFIX)(ARG1_DECL,
                                DEVICE_BIG_ENDIAN);
 }
 
-static void glue(address_space_stq_internal, SUFFIX)(ARG1_DECL,
+static inline void glue(address_space_stq_internal, SUFFIX)(ARG1_DECL,
     hwaddr addr, uint64_t val, MemTxAttrs attrs,
     MemTxResult *result, enum device_endian endian)
 {
-- 
2.52.0


