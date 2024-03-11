Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1BE1C5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 18:54:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjklE-000569-2j; Mon, 11 Mar 2024 14:52:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rjkl8-00050W-Ee; Mon, 11 Mar 2024 14:52:26 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rjkl6-0004zB-T0; Mon, 11 Mar 2024 14:52:26 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1dc13fb0133so22956155ad.3; 
 Mon, 11 Mar 2024 11:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710183142; x=1710787942; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sjddpjQMRodyz1bme4Hz/UgueNOKq2MtYowaHWD7sjM=;
 b=EvKuwDrM5pnjMbv6JD2s/w+PAPZWJLncgklGi/m4igP8SmnDd99vw39MZI9Vm/YjHX
 DkCC77wZRFDhlVPVy9u3V+idI5Qilx5FFGc8oWxwks4IxbFLk1yG7i13ufSw64ERU7r0
 0puq1qJRgZsfoKNExcbVDSPfSc7WGfjjLN1UMY0c2pVF8da/ZnT7dY8i5bIdizyaKcVG
 VsX6DQJskXLoechSZnTtQEsW3SYARIF7Wh7CRqMw3UbeqUQi2lTVl+uVeSCMhM68tnqc
 vuY2HUu4XwssxtaN4kbmtDf/UZXB2eKImMzHkkRVcvpxpIsIFCA5Qc2MGVSHXJ5WEgxt
 E1gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710183142; x=1710787942;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sjddpjQMRodyz1bme4Hz/UgueNOKq2MtYowaHWD7sjM=;
 b=KIPqjIl6pBq3IXhmZn2bqdsBo0szARvVxoYCqTY52zqcMUQzchKx6T2zrzhDdXSqZV
 idjNsY00yOczw6Li0UsIx6ECS+yU2xycjgByOwL4cC/dX1pECNei0zNa9j52uTb7eX3w
 91Rqny1Ts7hURsFm9NNdkOgvNS3jLDuYe1RlUkcgWOj30x9Jp/Xd40yLucuKeVV0oIDW
 sKlcdWm18XLf1ZU/TPJ/koFZfPluMuWcNpAsB4baQrlYGwqoJuhK870oWWHe/MdBqmne
 iizszJxs8l13osjvTiGOKe2TEafL1qutn4CrJAgBunayfzYhZwHKDfzn+oBAhHwzvd3n
 ZrHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXb6WbFmMMkhxlufeygdx/Gxq+PrwSllth/Hgdi5fyMYkqh6yX2DcyUbMDiy+7urPEDw+nH2GWBr7UKWh/XHRgtWVFJIK4=
X-Gm-Message-State: AOJu0YzJmUsojuA9mwUeJqADuyVk2MsWQ+7e4V0PYX4JmAzxrmXlYWsl
 ikjhjB+Yqrml/0Vae2YvbA9pH81kaZ/SfQxIp9xjzSYYqJIT/qkiixnZSFoiJY4=
X-Google-Smtp-Source: AGHT+IFVBWjV6DiWYepNhx7IKIeHV4GNP70xnPzt96shPQpfBzLSygfQs8aYSZoIFxk6oP76jrjHgA==
X-Received: by 2002:a17:902:ea01:b0:1db:55cc:d226 with SMTP id
 s1-20020a170902ea0100b001db55ccd226mr7000362plg.66.1710183141958; 
 Mon, 11 Mar 2024 11:52:21 -0700 (PDT)
Received: from wheely.local0.net ([118.208.155.46])
 by smtp.gmail.com with ESMTPSA id
 z2-20020a170903018200b001dd7d00f7afsm4843887plg.18.2024.03.11.11.52.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 11:52:21 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PATCH 04/13] ppc/spapr: Remove copy-paste from pa-features
Date: Tue, 12 Mar 2024 04:51:46 +1000
Message-ID: <20240311185200.2185753-5-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240311185200.2185753-1-npiggin@gmail.com>
References: <20240311185200.2185753-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x633.google.com
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

TCG does not support copy/paste instructions. Remove it from
ibm,pa-features. This has never been implemented under TCG or
practically usable under KVM, so it won't be missed.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/spapr.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 5099f12cc6..7d7da30f60 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -254,8 +254,8 @@ static void spapr_dt_pa_features(SpaprMachineState *spapr,
         0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 24 - 29 */
         /* 30: MMR, 32: LE atomic, 34: EBB + ext EBB */
         0x80, 0x00, 0x80, 0x00, 0xC0, 0x00, /* 30 - 35 */
-        /* 36: SPR SO, 38: Copy/Paste, 40: Radix MMU */
-        0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 36 - 41 */
+        /* 36: SPR SO, 40: Radix MMU */
+        0x80, 0x00, 0x00, 0x00, 0x80, 0x00, /* 36 - 41 */
         /* 42: PM, 44: PC RA, 46: SC vec'd */
         0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 42 - 47 */
         /* 48: SIMD, 50: QP BFP, 52: String */
@@ -288,6 +288,10 @@ static void spapr_dt_pa_features(SpaprMachineState *spapr,
      * SSO (SAO) ordering is supported on KVM and thread=single hosts,
      * but not MTTCG, so disable it. To advertise it, a cap would have
      * to be added, or support implemented for MTTCG.
+     *
+     * Copy/paste is not supported by TCG, so it is not advertised. KVM
+     * can execute them but it has no accelerator drivers which are usable,
+     * so there isn't much need for it anyway.
      */
 
     if (ppc_hash64_has(cpu, PPC_HASH64_CI_LARGEPAGE)) {
-- 
2.42.0


