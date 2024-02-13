Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E3A7C48260
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 08:40:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZoKW-0003XV-5A; Tue, 13 Feb 2024 03:39:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rZoKS-0003Wq-03; Tue, 13 Feb 2024 03:39:48 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rZoKQ-0005f6-Fz; Tue, 13 Feb 2024 03:39:47 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6e0fc87fc2dso118989b3a.3; 
 Tue, 13 Feb 2024 00:39:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707813583; x=1708418383; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=w9FRJ2ZWIfP9zV5rwAD9pnJwp81GQt2uUL68JC2IbS8=;
 b=S1qYCTgui3lDvCbnMC/WJWn3N5xaEOM4+UYVkbWjBynzFcJ7N3bNidWvVll3pbSgfP
 wqRK+OJ6wd5iPIHO0ak9MO1uM5mIZcZC6CfMO/6xt/dBo5RJXO652UtwAVbB2gBww8NN
 1PpvmviG6qIpgnUpsLKl4IVw5ZC/uCYpArbBibSC86c6GTtpZiSXm1RgfLLMZksiUs1n
 rrfMnJWxfXCEmyQNuTlu8xrMDHMc9uHKomlmByg+OMgILHiozaIthJY8B3aRi1823h/g
 7+3RRbwr8v4K610GKyvkvKfNloe4eRFsmq/PVmtmXxNrFQzT23WuI0LLMRXO7g4IED7j
 1iag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707813583; x=1708418383;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=w9FRJ2ZWIfP9zV5rwAD9pnJwp81GQt2uUL68JC2IbS8=;
 b=e24Rneq9Z1sAHGt8AnpbQdYC/wWNaG7+BzcI43z+A0Kzn/z7vlSQPSb+SH+6PifKne
 xPxF0eKBVPbMmpEQ8+GLDIdIsL4TX4fWDAlBnTmSwvv6ezB3PUrgHpQvYmpzU0CQALdL
 116nJ46922/eqkC8JybARrSkypWLdBKWHlWWxz5kM/6tqmxMZB7HP3U2ww6dtJjd0c2k
 XywxHcaPmBhMKG4s2AmKVV26/RmSDUx5JxRqbuh8Wh2iEhXRbq0mwDzh6tGV1RUT3DAm
 WEiXEQH/dznr3SEq3/Yk03U6BAZ9ZcVpY2hStOs6aAhAhXEB0PQ43iHqvW2rwzdTvUTG
 9TVA==
X-Gm-Message-State: AOJu0YyiaTmglI2I/kT/PBxxHTV3BhRrcbZrA67Ojf8IW+KidA8hXQHm
 c9JPeBopNaicy0/4OzwnQF8zAeMRQLEgmUmRs0ouqw0a8tI4/QBZFYER07yc
X-Google-Smtp-Source: AGHT+IFgAbjriEFXRZQ6kqJWOxpxQWt6/NpqdtiQoElmcc7aXa2FDvWtqoKbGzbKVlDYgHrtPCnL7Q==
X-Received: by 2002:a05:6a00:2d0f:b0:6e0:fa5c:8abd with SMTP id
 fa15-20020a056a002d0f00b006e0fa5c8abdmr1130639pfb.15.1707813582939; 
 Tue, 13 Feb 2024 00:39:42 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWrUf8sMD2UtrXlsNYCS1aWNvrgh/k5NEFjJpBxoJvHNELZDuyvMuhkaP2f8vPvrRvDC3uaWuUWC1djvhgUi5OeDMz8XDUhaAV+dSPYv+RPWa5Uq3kmz769CTbBtrA0TwrwZG1NS4B4fOk0j2e0nQza03+zqxBSBBtTPXWPz5ZSSZR8Et9yc/vbcKrxYYn7yxMRTxuz3JfmA89igNlzW7w3UB1WPY1fBbWvZ4ksrHzG8YO2GMqjpP6Yhp6NJQTSDS1oyg16Hvuf
Received: from wheely.local0.net (193-116-232-205.tpgi.com.au.
 [193.116.232.205]) by smtp.gmail.com with ESMTPSA id
 b18-20020aa78ed2000000b006e0a4022fa2sm5999044pfr.189.2024.02.13.00.39.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Feb 2024 00:39:41 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Lucas Mateus Castro <lucas.castro@eldorado.org.br>, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org, Joel Stanley <joel@jms.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PATCH] target/ppc: Fix lxv/stxv MSR facility check
Date: Tue, 13 Feb 2024 18:39:33 +1000
Message-ID: <20240213083933.718881-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

The move to decodetree flipped the inequality test for the VEC / VSX
MSR facility check.

This caused application crashes under Linux, where these facility
unavailable interrupts are used for lazy-switching of VEC/VSX register
sets. Getting the incorrect interrupt would result in wrong registers
being loaded, potentially overwriting live values and/or exposing
stale ones.

Cc: qemu-stable@nongnu.org
Reported-by: Joel Stanley <joel@jms.id.au>
Fixes: 70426b5bb738 ("target/ppc: moved stxvx and lxvx from legacy to decodtree")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1769
Tested-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/translate/vsx-impl.c.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/ppc/translate/vsx-impl.c.inc b/target/ppc/translate/vsx-impl.c.inc
index 6db87ab336..0266f09119 100644
--- a/target/ppc/translate/vsx-impl.c.inc
+++ b/target/ppc/translate/vsx-impl.c.inc
@@ -2268,7 +2268,7 @@ static bool do_lstxv(DisasContext *ctx, int ra, TCGv displ,
 
 static bool do_lstxv_D(DisasContext *ctx, arg_D *a, bool store, bool paired)
 {
-    if (paired || a->rt >= 32) {
+    if (paired || a->rt < 32) {
         REQUIRE_VSX(ctx);
     } else {
         REQUIRE_VECTOR(ctx);
-- 
2.42.0


