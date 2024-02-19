Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01111C48BC3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 08:30:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbz2T-0008TL-RK; Mon, 19 Feb 2024 03:30:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rbz2K-0008Qa-LX; Mon, 19 Feb 2024 03:30:09 -0500
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rbz2I-0001tq-4c; Mon, 19 Feb 2024 03:30:04 -0500
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6e4670921a4so252652b3a.0; 
 Mon, 19 Feb 2024 00:30:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708331399; x=1708936199; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w9FRJ2ZWIfP9zV5rwAD9pnJwp81GQt2uUL68JC2IbS8=;
 b=Ovbj/8Io7at5Md5NY3UdtlqX/lRLU/v4L/+nx4DpkBfEvGCZr0ZC4tTKP+kwXPtHJN
 t+pw24X7Xgg2zNT3e5OBlMLaHa/kxdxePrGmUrhVkh0rj2vxV9yoL6g3HgecKpIAoH6D
 GigVEvk1r07PQurHznEyetH9J1b72/SJZ29cb4QyTNy/A3BALNDimpxtzgEMeuy8S8Pn
 wjdN586uwVPe1xSzdb2NdOyiMuBY8VQFCZiZt5kNRZwUAAQ50Sk2WUjvhsBqsQmtm3aA
 scyp9TG/+HLauNtp6AQ/G0VU9hF4jYhNq86ruU0yALyZkxHx4SboTHolLmsV6gz7BFuc
 DdSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708331399; x=1708936199;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w9FRJ2ZWIfP9zV5rwAD9pnJwp81GQt2uUL68JC2IbS8=;
 b=r/00iajHwz0r+07pT1XjygyHiO3O3muHVmMwR38jFEdl9I3ZoergILIhl7OQ1MOyF1
 VrX6ONDxETqyMLlxWSs5BzYO/NpK4oX1cPQull/P608Hbmr51IHVe3hsYA8gavs/+mpb
 DuPlgCNudR+1t8YL0KH6kSLY/7vV9N4sLLbD0MAz2nAPtTjhUwURGcr1fKLB6q1HZBFs
 8cHoOkddZIZneRKYX5PvvTQMUPK3UoxKDB/RVukl+Mu6z5qRl8icB948ayLoO1DsuZFg
 1F3LVgkKqIOr6UrGeJ/DC1TyGhZIBrSb4c9mv3JDl17s4aamSsu+jgSdivVKeKWLSjXU
 /jcA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6WJNXY5VVCuKNBSARJMdcjAWgNdf7bTZ1lhr3ZWQNob/bcYBo44Cf4qgIkBac5LpFkoLDCUSNGmDNg/fWUfp6EYedeV6E4BBa4DvsWH/YX0pPdxL9q9HksYzQ
X-Gm-Message-State: AOJu0YwzgoFyWJKhjBby0U+UInpwjVQ2FKYRJgBKTNew4NK7H+x3gVfW
 yTG4IHJdRNCSakMI/2SIKYnmg89dznH8NwWvDEJLkJ/7VSBVG1p10zUam5gR
X-Google-Smtp-Source: AGHT+IGUPMasGuH6W2xwoS/4QOj8LGTtxFyONubrnI9V8Vpk2+l/QabO6gX0Oc0Nzmqm7/Zw9BlTrw==
X-Received: by 2002:a05:6a21:1799:b0:1a0:56c9:608e with SMTP id
 nx25-20020a056a21179900b001a056c9608emr16097694pzb.61.1708331399599; 
 Mon, 19 Feb 2024 00:29:59 -0800 (PST)
Received: from wheely.local0.net ([1.146.38.93])
 by smtp.gmail.com with ESMTPSA id
 mo7-20020a1709030a8700b001db5ecd115bsm3838348plb.276.2024.02.19.00.29.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Feb 2024 00:29:59 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-stable@nongnu.org,
 Joel Stanley <joel@jms.id.au>
Subject: [PULL 01/49] target/ppc: Fix lxv/stxv MSR facility check
Date: Mon, 19 Feb 2024 18:28:50 +1000
Message-ID: <20240219082938.238302-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240219082938.238302-1-npiggin@gmail.com>
References: <20240219082938.238302-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x430.google.com
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


