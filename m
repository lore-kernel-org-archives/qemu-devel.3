Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52581C4345F
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Apr 2024 15:59:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0kRC-00033s-3g; Sat, 27 Apr 2024 11:58:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s0kR8-0002zB-HW
 for qemu-devel@nongnu.org; Sat, 27 Apr 2024 11:58:03 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s0kR6-0005SL-TX
 for qemu-devel@nongnu.org; Sat, 27 Apr 2024 11:58:02 -0400
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2d8a2cbe1baso42994871fa.0
 for <qemu-devel@nongnu.org>; Sat, 27 Apr 2024 08:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714233477; x=1714838277; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=msn7De0lOW3avspGXlkpWl0wQtZAqMJHMMhEd4fx2HQ=;
 b=PXiNsoUgSfCCr4aKbxMJ5qVjP+W7Sg1CaUh6FLRuZFQ6sZ0qjpeqkmySfEiLlCC6c2
 tFcSOUwjHLeWsc18aH1xd9KojgmO0IYpyqGr65JqWb3c9vgFhX5K0yBPpUn2+4mA4+B0
 viNAIQJh1TGbbaqFnWIeoqZSTCmV7/g3j2exk4BDFlFCF2kcQu/Wnqxl4OwcvuuD1Zdt
 NYRB4A8q3qgqtSEupvfFe/a1Aa0Vdr3PNTWNefg7aA3q79rysF/kYyXdvChRsVHWL3jZ
 CKS6yKmiFMYZRG2i3w2g33RzndCWoC3PDftQrsZ+UC6iMqtUnAe9zYoEog7/pO5AJQbk
 ih0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714233477; x=1714838277;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=msn7De0lOW3avspGXlkpWl0wQtZAqMJHMMhEd4fx2HQ=;
 b=YMtZAqXEQDO5zgwvK3Sin6ySFj8iL9nPGi2xJzOwNQC59z2rAitqJiMvJmP3s2AUH3
 8Wq0eOAbR07bJ8XPSZC57SYNouDj4eLpNimvrevAfWVrhyBYo9hS6TsGdnmRhKgec92S
 ZiMBenbEMeEujWBGJzlsZ49tKkPNV8elpqh0TcDepjXLRdgADmkAkOuAE8VpycbTGpej
 0F0A7atSaasYxibXuRMN2Og1fAcvQazH44zdIdc5Y+WopOlj5ZL1sJyt1wNWWJsTrptn
 Q8+OqymdVTeTmBORaN4xpyJmwiu5iE23o/rWY6mcKULhiqmmr0r6cy84hEpTuev4hZcm
 xZ3A==
X-Gm-Message-State: AOJu0YzlfBPBQ1dL5bv6lhOEZI9WiH3Lykp+ZN8bdqGQpH80hYnYPUtS
 zPJ1FAnv55S44syTXRuSNG/oQdgIsWGAU2KR/bzO53cLIPtskkvb+GtIyz30KoC68BY9YLQnHyt
 jTHg=
X-Google-Smtp-Source: AGHT+IGi/XUlIE/4uTf+/MRtnb7qvLwCeZGp3FkCpFV32jhADQ/YK9fOKHtNy77Of9qa5gN9LGR/aw==
X-Received: by 2002:a05:651c:10ab:b0:2d9:fde0:86e2 with SMTP id
 k11-20020a05651c10ab00b002d9fde086e2mr4569731ljn.15.1714233476849; 
 Sat, 27 Apr 2024 08:57:56 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.2]) by smtp.gmail.com with ESMTPSA id
 q13-20020a05600c46cd00b0041c02589a7csm377463wmo.40.2024.04.27.08.57.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 27 Apr 2024 08:57:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 07/14] exec/cpu: Remove duplicated PAGE_PASSTHROUGH definition
Date: Sat, 27 Apr 2024 17:57:07 +0200
Message-ID: <20240427155714.53669-8-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240427155714.53669-1-philmd@linaro.org>
References: <20240427155714.53669-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x234.google.com
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

Missed in commit 58771921af ("include/exec: Move PAGE_* macros
to common header"), PAGE_PASSTHROUGH ended being defined twice.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/exec/cpu-all.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 5ea8c4d3ef..8c3ad7153d 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -157,12 +157,6 @@ extern const TargetPageBits target_page;
 
 #define TARGET_PAGE_ALIGN(addr) ROUND_UP((addr), TARGET_PAGE_SIZE)
 
-/*
- * For linux-user, indicates that the page is mapped with the same semantics
- * in both guest and host.
- */
-#define PAGE_PASSTHROUGH 0x0800
-
 #if defined(CONFIG_USER_ONLY)
 void page_dump(FILE *f);
 
-- 
2.41.0


