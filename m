Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38325C02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 16:49:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbMhM-0007m8-Fq; Fri, 24 Jan 2025 11:38:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tbMZh-0006BB-NV
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:30:32 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tbMZZ-00062T-RX
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:30:27 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4361dc6322fso15854535e9.3
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 08:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737736209; x=1738341009; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lA6x5OsofqZFLGhXUxXjPh4lmTqYPUIQ861yE8d4HvY=;
 b=F0uuLkrhRCUmYBjk8PmKKFNE5XFPsRUxziw4jPaCl52HmJn0AnpONVp/zxEzSThYJ0
 3fPCnsQh6XTSCDCNp8qR8zYt4EOkawy08X1h2zqw5sC10grHUI9c0zuLkXs6FstYNdsQ
 XDvgqTpELPxlQU7VkF6BCXQwv/Y2i4Nsc6hvAgiK5M2wG/6pgVYHqf+oB9v7Laujwiks
 46gI96cOt8bIYG9OK5vxnuXS9qbJC0GtFquhRhr2/fNlyd4BCw2rIYwi+qyaIymKp1zs
 udBd3WDGJ9S/U3rY0Vq8LqqsFSo+5oZG/w+3Ero1aUt3qedFHi6ZGq+J4QN1bc86M+x1
 BpuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737736209; x=1738341009;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lA6x5OsofqZFLGhXUxXjPh4lmTqYPUIQ861yE8d4HvY=;
 b=XqsMqJoz6YtHzzPdH/nn6wkHtnXGHYYoBiVrzUWNje5VrzsRkVuruwxv7QO0/tWrgM
 IvIcoyKPUa/yUHAHNco2xVNrPTEL9hFWL07TLUvNLAhtEKthW6Y+G4F9oWOHHpKiJghw
 preDkOJPtKj1MEkB7QlqEOMCiNVIV4zJ8iz80M/LXYUTygZePmGM7yiDiCManlz7eekT
 UJtFxIlw+heJUIBouh81llhqbVudUU0SJjZ0SvyaxucfhPP8X2lBcgHPXkVr9tEBAiXY
 uPW5QWvgUQy7hlX1SSnfU3662bv17hEjBGg0HazXz3h3I5bTjzzb4K0EI0JptT6PcXPg
 FnfQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+Lzc9fbATr8rvn2oryL/FGXDyFgcotCQgK8GruHEGd/yrvCbJ8lmGdWypakt/iHmiest1BVajxwkQ@nongnu.org
X-Gm-Message-State: AOJu0Yw5SJK84uTBsnNJxHtA5bEXsSZy7ifJ3RngNeVNRINt66K/u8Xp
 d17Fufj1mEXfYv1ZAbgpNyZCvqjsFzco1iuhnZhvSTQl/uCg6x8Vjru/OMty1VU=
X-Gm-Gg: ASbGncsbPZ4ZD9BqLq2Pou/zXOVif+3GVMmSW7UqZFwdzYiroaWgsj7mk4soA77Aey7
 LVSLtvX7uWciB8C3zflrZiB63Pbauhy2mMvknpOXHBaICuFesfObz+6lwYVroKHDQqsE7QGZLoe
 lnQHT8fXWTVmxWpTIjg7vjfgmuImE0t97tzIOMDB0N92kJ/NmJqXHvPZPp4pqmq7h3u6+MshFID
 l4Faa1Z4rbaechfsSUA9IpDw1o+49mHuv239KxBV4iOVWBQ4rxe8UBeO6N4QxP4SaIOmaRpvEd4
 lQpguaEskWg=
X-Google-Smtp-Source: AGHT+IGQSmzdZS5hJF+2PN65wGr9Zv9UU+QsAw47e7GAn0g3SX9h2Krvg7dzXajkKd7sWnPsY+wHaA==
X-Received: by 2002:a05:600c:3149:b0:434:f270:a513 with SMTP id
 5b1f17b1804b1-4389144e70fmr297782605e9.29.1737736209377; 
 Fri, 24 Jan 2025 08:30:09 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd47eecasm31683025e9.6.2025.01.24.08.30.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 08:30:08 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 72/76] target/arm: Enable FEAT_RPRES for -cpu max
Date: Fri, 24 Jan 2025 16:28:32 +0000
Message-Id: <20250124162836.2332150-73-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250124162836.2332150-1-peter.maydell@linaro.org>
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Now the emulation is complete, we can enable FEAT_RPRES for the 'max'
CPU type.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/emulation.rst | 1 +
 target/arm/tcg/cpu64.c        | 1 +
 2 files changed, 2 insertions(+)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 63b4cdf5fb1..78c2fd2113c 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -118,6 +118,7 @@ the following architecture extensions:
 - FEAT_RDM (Advanced SIMD rounding double multiply accumulate instructions)
 - FEAT_RME (Realm Management Extension) (NB: support status in QEMU is experimental)
 - FEAT_RNG (Random number generator)
+- FEAT_RPRES (Increased precision of FRECPE and FRSQRTE)
 - FEAT_S2FWB (Stage 2 forced Write-Back)
 - FEAT_SB (Speculation Barrier)
 - FEAT_SEL2 (Secure EL2)
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 0bc68aac177..29ab0ac79da 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1167,6 +1167,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     cpu->isar.id_aa64isar1 = t;
 
     t = cpu->isar.id_aa64isar2;
+    t = FIELD_DP64(t, ID_AA64ISAR2, RPRES, 1);    /* FEAT_RPRES */
     t = FIELD_DP64(t, ID_AA64ISAR2, MOPS, 1);     /* FEAT_MOPS */
     t = FIELD_DP64(t, ID_AA64ISAR2, BC, 1);       /* FEAT_HBC */
     t = FIELD_DP64(t, ID_AA64ISAR2, WFXT, 2);     /* FEAT_WFxT */
-- 
2.34.1


