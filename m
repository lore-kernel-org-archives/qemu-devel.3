Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6155C4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 06:25:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raV7W-0003GN-NP; Thu, 15 Feb 2024 01:21:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1raV7V-0003FG-0n
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 01:21:17 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1raV7T-0005dC-5q
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 01:21:16 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1d9b2400910so4243865ad.0
 for <qemu-devel@nongnu.org>; Wed, 14 Feb 2024 22:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707978073; x=1708582873; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lIw0HHLdL2NvcxZjQjlv25wKknGxFlW0JytLKiI4Hg4=;
 b=dH0yOKfydA5ddESUduAoVM7n9d0LlyuJ0nlvDYKueG69KsA2mysm4C+DnRnX2lBe3p
 nHQ+CD5MgW6dRClMjvlYnXWRCs6KMEOavWXp3F6jzE5y9/vNZfX7bWEjbiAQm6l3aMU9
 NCH0nofJg644ohKJ4UumrkgGt/Z7HpR1FYb4n6w0N6j8FzJ+U3djZMf6czSIr+2C4dZK
 l+8BwFt+u9rUl2O+LoLiAETCAIi+2nbSANetiw2bOW6oU0hoFiMUBO37hZkv8uOwG2dd
 GampUL6G929La6FGo2oCorpQ/bb0RAhgYHCI3Gf4q/RUaVIy81bTLbKW0Ogb+HPnzWdU
 wSBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707978073; x=1708582873;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lIw0HHLdL2NvcxZjQjlv25wKknGxFlW0JytLKiI4Hg4=;
 b=woHePOW2YEVh2/qyLkOwKVxZIXgOaLtlHZz6G+wZi9f4fcqijFkwZa1ho3IERNuK5i
 F8N7vn6wfgGtzXeEN4n3o5/fDHJ+cCmD8GGcxQHdHalgRWzDYT4trbvWwXrk4UEqu1F3
 ltLOJG2Ub3/IrxhH1WLVCHWY7ty/1cdx8Hz3FGRJQvmh654Xvv7G7B3oOEJ/P8IRyaGV
 huswzjLrt5KIvHy1IIOwiuRb8QS5BpVF6/qYtItwjKlPw6S46P1Rb+cBG39BbNasYFeu
 iNzR37TftlNZCkX37C8sQBLfddN8OSl/uJkVTUI7mD67dwp93zv5QWK7En2BA1sv4qKk
 gBFw==
X-Gm-Message-State: AOJu0YzN2QnKXepdRT4OmK42Ln4uuKpnCfyJqYS9iK6gjmXcZdnrxWkP
 kBI2VWNBdyxZAd6Ii/ZhEswwJZpj324iEds0yRwmwQXIfHyEr8Wya5FeauPcmtZFOy6ID67QNeP
 1
X-Google-Smtp-Source: AGHT+IHnRA0oQOTYhLHregguDiI7r0MfaCFspINVFDlvaLvChrgbkiEk4WeRq10n0XRPVc6SW9S2FQ==
X-Received: by 2002:a17:902:ec8a:b0:1db:28c0:3ec4 with SMTP id
 x10-20020a170902ec8a00b001db28c03ec4mr1443472plg.7.1707978073608; 
 Wed, 14 Feb 2024 22:21:13 -0800 (PST)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 d5-20020a170902b70500b001d6f29c12f7sm464418pls.135.2024.02.14.22.21.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Feb 2024 22:21:13 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 36/36] linux-user: Remove pgb_dynamic alignment assertion
Date: Wed, 14 Feb 2024 20:20:18 -1000
Message-Id: <20240215062018.795056-37-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240215062018.795056-1-richard.henderson@linaro.org>
References: <20240215062018.795056-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

The assertion was never correct, because the alignment is a composite
of the image alignment and SHMLBA.  Even if the alignment didn't match
the image an assertion would not be correct -- more appropriate would
be an error message about an ill formed image.  But the image cannot
be held to SHMLBA under any circumstances.

Fixes: ee94743034b ("linux-user: completely re-write init_guest_space")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2157
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index f3f1ab4f69..d92d66ca1e 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -3022,8 +3022,6 @@ static void pgb_dynamic(const char *image_name, uintptr_t guest_loaddr,
     uintptr_t brk, ret;
     PGBAddrs ga;
 
-    assert(QEMU_IS_ALIGNED(guest_loaddr, align));
-
     /* Try the identity map first. */
     if (pgb_addr_set(&ga, guest_loaddr, guest_hiaddr, true)) {
         brk = (uintptr_t)sbrk(0);
-- 
2.34.1


