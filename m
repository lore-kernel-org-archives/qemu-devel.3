Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BED7C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 19:50:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0RVg-0001IN-4K; Fri, 26 Apr 2024 15:45:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s0RVV-0000kR-Po
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 15:45:18 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s0RVS-0004Xp-1G
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 15:45:17 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a51a7d4466bso303588766b.2
 for <qemu-devel@nongnu.org>; Fri, 26 Apr 2024 12:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714160712; x=1714765512; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qqr1BfgxtDJCbOWtFyibCNg276fEde+mRkEZWF16SzE=;
 b=acvXJmnQOK26rVxfSyuscFfix4Ox1oR2nmZP9I6LUdrNC33cLp2tathvwzTkZAyNqD
 mq9QZwXMf/YVxBhISNZeG/E1uXYaYVn0BMIR3DuNjgVh5pI0GBYhiRICceKsXGFo+4y4
 Uxvl135LIz/5cvud71JZk1U2/ARrzmG6HOXVK8X7r7wxHn+aCgvo8REhiOgOnEVw9Ald
 LXxoiyRsPuERdTsMIoCNq4BZNYNPr3pRvumTUZk+VxmMoLEJ+1ocdErtofMJEO6oQuO1
 WAA7+og8ONjucTcoN8RazA/bdiJTpU04V8AcHXLElfEWkBGFb85Mx6M0DQRBWmk+5fEb
 7zAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714160712; x=1714765512;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qqr1BfgxtDJCbOWtFyibCNg276fEde+mRkEZWF16SzE=;
 b=c9EFFsWcWgv4/OlqBZTelfg3lyBIhFEgG/FVlJEnnR8Mx+rnathjL7fekxECeWuPaq
 JNzXMs+nnTt0LyX2Gr5ufsOABw2X5z8dlhD12DZdCC3PDet+5fHaXWfQ2ktLubcySfnm
 IBGiw76FvB4LIfeff4FKcVUaefsZqmqo1hz55w1kpLrKXuE9fIpZ03ElLIxEUcPXe8Ef
 c73yARscddcmPhYLQ0B4QNMWxXEtePWJmsQBI/yS7noRgncn2OgIQRWKcgZ+7bzr90FN
 azFv8a7BGqAjQd8PUSVbN0ZUswUTpNrtT5vewXlKlEHFtEzgMfqkn+SEaDONyah2P1Rb
 qMbA==
X-Gm-Message-State: AOJu0YzYX0BOPG14Njxp6zzK1h5YMWAUN4V8AkZRAuFlcxAR6/L6i3jn
 ah/2/xuoAdEVrSjG8EoonZTM/s/LGg3RIFyTRAH0AzlEA/kXWTy+goamlKaAxLDS6OfDIVA42/r
 LMUk=
X-Google-Smtp-Source: AGHT+IFAJR8eHA24IJxjS9GCEnfHyjCs6dEj5XriEYpFsxxBqQNjWE25ztx7AU3YMwEhAlx6khApCQ==
X-Received: by 2002:a17:906:28d9:b0:a55:63de:9aa9 with SMTP id
 p25-20020a17090628d900b00a5563de9aa9mr2583901ejd.49.1714160712302; 
 Fri, 26 Apr 2024 12:45:12 -0700 (PDT)
Received: from m1x-phil.lan (aul93-h02-176-184-11-147.dsl.sta.abo.bbox.fr.
 [176.184.11.147]) by smtp.gmail.com with ESMTPSA id
 jz12-20020a17090775ec00b00a58a9a56c44sm2359531ejc.16.2024.04.26.12.45.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 26 Apr 2024 12:45:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 32/38] exec: Restrict TCG specific declarations of 'cputlb.h'
Date: Fri, 26 Apr 2024 21:41:52 +0200
Message-ID: <20240426194200.43723-33-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240426194200.43723-1-philmd@linaro.org>
References: <20240426194200.43723-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Avoid TCG specific declarations being used from non-TCG accelerators.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240418192525.97451-5-philmd@linaro.org>
---
 include/exec/cputlb.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/exec/cputlb.h b/include/exec/cputlb.h
index 6da1462c4f..ef18642a32 100644
--- a/include/exec/cputlb.h
+++ b/include/exec/cputlb.h
@@ -22,9 +22,14 @@
 
 #include "exec/cpu-common.h"
 
+#ifdef CONFIG_TCG
+
 #if !defined(CONFIG_USER_ONLY)
 /* cputlb.c */
 void tlb_protect_code(ram_addr_t ram_addr);
 void tlb_unprotect_code(ram_addr_t ram_addr);
 #endif
+
+#endif /* CONFIG_TCG */
+
 #endif
-- 
2.41.0


