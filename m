Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23F5DC54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 17:01:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk5TS-0004ln-RK; Tue, 12 Mar 2024 12:59:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rk5TP-0004jZ-Cv; Tue, 12 Mar 2024 12:59:31 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rk5TN-0007yY-LC; Tue, 12 Mar 2024 12:59:30 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6e6ab012eb1so789511b3a.3; 
 Tue, 12 Mar 2024 09:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710262767; x=1710867567; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KRNFEd2YKSH0GA9c/OZVzyVQTq0v73fyutt9t+Ehgsc=;
 b=hc7dq1M/EV5VCGd/tyRWW/ke6HVsBaFvlFLIN2IJ3nUCTjOwl7r8Yll/PQbu+491Bv
 gNPl+RYToH4ikTPHCxEb/3zLmH8c0EZZ91+apmutiKZuoC8w4akn8o3eJ9rTIHGNK5JG
 qFtAweMH47An7SclcJgQkv1gwRZCnD4mpwAlKWN5DbM1EFQFS4Mk22SedgdFO6cmOrwx
 HIIvFt3bDbUurrm5bqp8cCBTL9GGwzKjr0vtxD0ymLhosOAKUYMDg4q+pIUJFp/AOTkl
 JTNb9DoqURbfMEv0jPP832f60skPykXWYGNH0N6Vn46Y8l87GIxqF2CZjRt1gkrZEE8N
 j8Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710262767; x=1710867567;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KRNFEd2YKSH0GA9c/OZVzyVQTq0v73fyutt9t+Ehgsc=;
 b=iZm89YPHCkYOgb2f/cPUqCwAibTRXnJXc9iGDHSjpTZPe3p4rEtYZZsS9ttdhvw1Ub
 atyp1liH887pgKQeCKMQ8nydj7xXkTmtcw2LB81GzqRk/WTvnp00MtSu4HUq/ei5hIyf
 ag9K8RlegeZjKjTn4k8dasCzkdqlK1C+OmaSpq5ecCiR5vE+9Dq9e/B3aM7WEbIJ1XbS
 oxieneZpKtwrVxVR9ECUXGd+ktwUZxSprA7DMY8Q/mk1VxjfLKtl1dcMv+FtvMlJBX1y
 /eYcF9h6PwiNOw3K+TSXurcKaSe6tqpCCXjoyXgiVo89D2hprLrdnlGSVcw412sXvOwk
 HNTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWn+Lh4kTjv6XURD5SafHmUllWbfG0XtgIKsFvOsfl1sAss/vmf91KsX5QXqyIq99u5oEUJy6trYxQApOJUeS0AvImf
X-Gm-Message-State: AOJu0YxhzGmQs85tFUqjp1M1T2wEoKCNzjesTr/l2CDSo//Yxgv7FPN+
 g0xI8to81dGvQEfo7KDlYySyog1VpT7stGPRRh59RJZ8xVfagCzLopNSLp92oMw=
X-Google-Smtp-Source: AGHT+IG28lI/09tFi8g+Up8daFHwEYz6/TUsGvDHno3TwhIpI1pyKc0SgKP5ufOOsFOO6deJWVwwug==
X-Received: by 2002:a05:6a00:22d4:b0:6e4:e43e:dc1f with SMTP id
 f20-20020a056a0022d400b006e4e43edc1fmr12415pfj.32.1710262767620; 
 Tue, 12 Mar 2024 09:59:27 -0700 (PDT)
Received: from wheely.local0.net ([118.208.155.46])
 by smtp.gmail.com with ESMTPSA id
 t34-20020a056a0013a200b006e6a684a6ddsm1362330pfg.220.2024.03.12.09.59.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 09:59:27 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PULL 07/38] ppc/spapr: Remove copy-paste from pa-features
Date: Wed, 13 Mar 2024 02:58:18 +1000
Message-ID: <20240312165851.2240242-8-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240312165851.2240242-1-npiggin@gmail.com>
References: <20240312165851.2240242-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x433.google.com
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

Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/spapr.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 3108d7c532..4192cd8d6c 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -237,6 +237,10 @@ static void spapr_dt_pa_features(SpaprMachineState *spapr,
      * SSO (SAO) ordering is supported on KVM and thread=single hosts,
      * but not MTTCG, so disable it. To advertise it, a cap would have
      * to be added, or support implemented for MTTCG.
+     *
+     * Copy/paste is not supported by TCG, so it is not advertised. KVM
+     * can execute them but it has no accelerator drivers which are usable,
+     * so there isn't much need for it anyway.
      */
 
     uint8_t pa_features_206[] = { 6, 0,
@@ -260,8 +264,8 @@ static void spapr_dt_pa_features(SpaprMachineState *spapr,
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
-- 
2.42.0


