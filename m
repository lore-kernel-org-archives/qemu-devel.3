Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38DCAC4345F
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2024 13:05:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s29dp-0001zH-NY; Wed, 01 May 2024 09:04:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s29dm-0001xm-H6; Wed, 01 May 2024 09:04:54 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s29dl-0005tB-1X; Wed, 01 May 2024 09:04:54 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1eab16c8d83so54549425ad.3; 
 Wed, 01 May 2024 06:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714568691; x=1715173491; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=il55LV8Hp8PUPNxofA7dxyk3K7ZSDa0WSvCi9I55JJg=;
 b=eM1Qwx2Z9rEDYOADhHSdsHmP9Pjq6ESFuNH1zlt4lOJngVi7QTttuSF+P0+vdgrY4d
 xVvjY3Pu6Xv6bt89vEeL2m8OaI5cdkbCAPyxYmknRyrfQwriJsO6QpES2xiDtRVSQo1P
 fSlZR7SW6f1Wu7GpLN5QGphM7syQBII+5GSZnH4xzb55HID2L63HTGXJmLUPeKwMRNUV
 yUBmUCnEyYSgIaKP0IRU+7MmtpzfxKYzdF56hPobmpPvt9PU3fiu3PDjwuo1fTwOCVUg
 hre52uvRDCCkMNAvvwQ9E7xxQyq3URIvihHkzWwjjdLrM8HgNqVCfOUzTSxpVa7LQXuX
 Jw5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714568691; x=1715173491;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=il55LV8Hp8PUPNxofA7dxyk3K7ZSDa0WSvCi9I55JJg=;
 b=HFJ7ZTXQArrRV506P+KJM2DxOJNbOE9cejgz/val4ZzmHis9R0inEc11u3S99OkUjE
 ginc9fBB21JKMUid7s3g2MLCEaKtVY6Oyomo+NCn4+HaoIPaSws3AeJWWjFgO+xhHksz
 X0YtccXUSnAxkDRSmHjRFWcZm6fp1lS2Qp+Nl7WTYjatLk51KMdujXNNRnk+F0y3vpST
 Ynfij3JebehHvYZsYI3u+6Ab/kg9oX4CO8Nav1Wc6ecB2bntpdYN2+T3NxdZzUH/fie5
 Vcnn1SBjB0Iv+3rl2rrbbM04zfRBrBqWOPmf1c9XY5wx6Qdny0Uyb3D7N7KgtjnXgd7k
 g4/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpg17aWNYliBEnSxmm9u02EY3jj2slMpCvA9Rebln9pbx6uQJaKRVso5mNVILnXYc9be+W+wgrjBp066aFExG0m0wMhcw=
X-Gm-Message-State: AOJu0Yxi0SpuZERdlfI01TEF8ipZolJpDb7C90mPdNc+tXXdRYf4318E
 RU87SpWiofSjjrduiRSiZTrdpgfuu1TklRzcoGJEk5DU4H1sSYjMOCaDMg==
X-Google-Smtp-Source: AGHT+IFGbt/gTCTCxwnSR5bDblRKEmv7SW9LuMR8xShym0BC79u8jSRynRpFAIBwr+r6eUutxCviWQ==
X-Received: by 2002:a17:902:c3c1:b0:1e2:6b5d:5b18 with SMTP id
 j1-20020a170902c3c100b001e26b5d5b18mr2203254plj.51.1714568690984; 
 Wed, 01 May 2024 06:04:50 -0700 (PDT)
Received: from wheely.local0.net ([1.146.40.196])
 by smtp.gmail.com with ESMTPSA id
 j12-20020a17090276cc00b001e41f1dda43sm24064471plt.75.2024.05.01.06.04.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 May 2024 06:04:50 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 "Chinmay Rath" <rathc@linux.ibm.com>
Subject: [PATCH 2/3] target/ppc: Fix embedded memory barriers
Date: Wed,  1 May 2024 23:04:33 +1000
Message-ID: <20240501130435.941189-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240501130435.941189-1-npiggin@gmail.com>
References: <20240501130435.941189-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Memory barriers are supposed to do something on BookE systems, these
were probably just missed during MTTCG enablement, maybe no targets
support SMP. Either way, add proper BookE implementations.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/translate/misc-impl.c.inc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/ppc/translate/misc-impl.c.inc b/target/ppc/translate/misc-impl.c.inc
index f58bf8b848..9226467f81 100644
--- a/target/ppc/translate/misc-impl.c.inc
+++ b/target/ppc/translate/misc-impl.c.inc
@@ -34,8 +34,7 @@ static bool trans_SYNC(DisasContext *ctx, arg_X_sync *a)
      */
     if (!(ctx->insns_flags & PPC_MEM_SYNC)) {
         if (ctx->insns_flags & PPC_BOOKE) {
-            /* msync replaces sync on 440, interpreted as nop */
-            /* XXX: this also catches e200 */
+            tcg_gen_mb(bar | TCG_BAR_SC);
             return true;
         }
 
@@ -80,6 +79,7 @@ static bool trans_EIEIO(DisasContext *ctx, arg_EIEIO *a)
     if (!(ctx->insns_flags & PPC_MEM_EIEIO)) {
         if ((ctx->insns_flags & PPC_BOOKE) ||
             (ctx->insns_flags2 & PPC2_BOOKE206)) {
+            tcg_gen_mb(bar | TCG_BAR_SC);
             return true;
         }
         return false;
-- 
2.43.0


