Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E19DC369D8
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 19:40:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7JMC-0001Mg-9m; Tue, 22 Apr 2025 15:32:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JLX-0000C9-Bw
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:31:55 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JLV-0006bF-5m
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:31:54 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2279915e06eso58608945ad.1
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 12:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745350312; x=1745955112; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wDV12YwNumASN3qNFcyYdusmdSKLuYlMr1apQ66exto=;
 b=xJ+m2JXP7AEJ3J0aMNaTejZYREAdJ3vT5akJpRBTMY5qmLRlY4G/nZ9lGNoK3UaIbP
 eNMHtlvbLV8LGrfUIuy8Hk1Cl970XOOWfDR1Pw4y3tpL0Z3KccvNZBh2gNvHUgEnht6H
 58rVbI5wfgJo/C4uPCeyZASr6n9OSwcB+gPsMAU0lCgXnztj4swOw9zeM6jFzoI+c1BJ
 1hAJtpxo7zF5ukqX9wlpQGRaq+hLvmIQWPX3eMv8EK04wb2A8JYaqMWsTq7/bj/EoPPd
 zxRy1AoNJjasg8h4+ahWJDy05tT4LSqGDqPI3sAL+APeuz9Io3sDTfGhqKHXXWcSh7pD
 9raQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745350312; x=1745955112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wDV12YwNumASN3qNFcyYdusmdSKLuYlMr1apQ66exto=;
 b=rirKcEJsDoSNfOf/DsL6Ad6vfVxeGnntl3KfdowenL/QBVoj0nKdRpIzppqFFQ5x+U
 beEvq32sUomek6amiAKC86oh1tLpMd+qh90/IKCgMrqF2ladhAqPyjhaTSkbgfjOXyuQ
 cAXgjm6H1HuT6ki7MBeR5GFj3FioDw7zp1JqY5HGA6yXdrFfQAOIzEPJJ90r7Y54708V
 KwtheiGlrDAKA6otAVPVud+Ym0tbJ1Ve+Vv13X+xH+CyTFmPbcBaIn+dIpczJXAu3+JE
 cLzSGQ0oGFoxsscTftpJU16aBGmAQhhf7NZMJNVERrCR5U6+Pel7oDsJrl/qv+360xGR
 cj0Q==
X-Gm-Message-State: AOJu0Ywv3orY7emc4O2xnvgODNWMQT+8zCEpcfdSWha/fu4haojHDVkQ
 gvXj+qoY2JfqjlxUPUH1j6Sysqdck5NwKaDhNM/6Voif7Tqjv1cEbEssRD2gLPNtNzLRrI6glpX
 0
X-Gm-Gg: ASbGnctZ8EjGA9+om5VgxUOhloQo+X6cAQqZaRAuZUJc94TDRvEHzQ1SquJPRTsWwrl
 YsCYeKwVF+VSFZ3WIiks77YJRENnU2l/KmigT1HgKmwhg/S7PTfMhHl1PN6GkEVJOQVCdSJfs2H
 HiB1NliTZ5GKhmHvz/Ravv8fHx30+m5S/OeGXovTVNvE7LPpMi22trL7VNRGo4VQ1Uj8e+YPgj8
 eMTyw1y/hlN4RV9D26dXHYnn0oU4FodUeHxs9UWbafVuCFH/UaCpckprFRiBrU8EbiOReoPLG4J
 a8mi338woFBcO/yjyLMsIsBdUC8KY+zGhqQkPdb8sd7j8x3Mi12Orev/oIBeIK36MxLYpbPQlyc
 v6/WqpZPivQ==
X-Google-Smtp-Source: AGHT+IEfk/QW+sByNwFnVfDjNu5mifJGCw2TvYC7ZWysPE9UWSadmYjUchcQaediHJC6WaA7B8YIlQ==
X-Received: by 2002:a17:903:440f:b0:226:4764:1963 with SMTP id
 d9443c01a7336-22c536627dfmr245617175ad.51.1745350311894; 
 Tue, 22 Apr 2025 12:31:51 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50bdda3bsm89312635ad.27.2025.04.22.12.31.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 12:31:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 047/147] semihosting: Assert is_user in user-only
 semihosting_enabled
Date: Tue, 22 Apr 2025 12:26:36 -0700
Message-ID: <20250422192819.302784-48-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422192819.302784-1-richard.henderson@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 semihosting/user.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/semihosting/user.c b/semihosting/user.c
index 515de3d2c0..98c144cb45 100644
--- a/semihosting/user.c
+++ b/semihosting/user.c
@@ -11,6 +11,7 @@
 
 bool semihosting_enabled(bool is_user)
 {
+    assert(is_user);
     return true;
 }
 
-- 
2.43.0


