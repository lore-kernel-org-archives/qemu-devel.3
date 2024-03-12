Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 375E3C54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 13:16:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk1xz-000832-Qi; Tue, 12 Mar 2024 09:14:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rk1xx-00080l-8L; Tue, 12 Mar 2024 09:14:49 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rk1xs-0006pb-EE; Tue, 12 Mar 2024 09:14:48 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6e68bab3e4cso2108295b3a.0; 
 Tue, 12 Mar 2024 06:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710249282; x=1710854082; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KRNFEd2YKSH0GA9c/OZVzyVQTq0v73fyutt9t+Ehgsc=;
 b=ILcSMTkWs2IEqnth5+lQw2LshCCow/9GsCPhN6cjWA3V4V3x+CE1zGtEbg4sXAwFBm
 hdRGoMQcVtEgABJoha0elgOzHk22AIgZpya5C0PkdsE/vJb3Cqzev3vqX1PI9G00shg2
 Yd9ZBdzLCsWd8EewOMNezBxzZlyygxTlN0I5l3gYAzlqH07AOR59DSvCX/zM15PYMRFN
 j1vxPBOPCeAShcOrQUbz5Zfz05uhdVY7VFvkjED3ttPAyv8P8/ttYa2uOY4d3Tfl41q1
 rmXLgudEGX8peNzwxqAkaucz5YA7aXtDekAbMZPqgyPHDqRfwtV1WoK7JbKGf5GcgNqq
 BTWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710249282; x=1710854082;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KRNFEd2YKSH0GA9c/OZVzyVQTq0v73fyutt9t+Ehgsc=;
 b=Ni2F3dPxRflVuTrId5zS5coNY70N83ZpfWV81pGNoxc46hgUst8hImIjgNJ8fdQuaF
 tksV32OjHCXvbb1hk2jw7w1VVB5WOfiXh/IpPjh/TecZSCLyz1jCBs3MVLbBEdQyVYYs
 hqNYp7WOaJQ86RbeVT9VErOgk8tB1dXmoPJTBfZiXD2Ivkz0CufWbajTWBqWMmgpEuTl
 3PsM238lGUmuBMsyxpDrol2d2DfZO3GtTLH/1u2XgsqIg6Zn0WV0sydJ9xAlrasssyCN
 0dYfJuKhqLI7MEU0GbzVmD1BKbQHz3LbpHx23ZLC4LiIpiyc7UxPEVShBPR7IwprXTFu
 yMUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdnkJ5e+DZzCuWgZqzIvE2dXJH7aHUkVGlEJJfjdoI189zImLU1+O2dv0YH06gkGgpO+Jlk/b9SWE3dTWHKohD4Shns3k=
X-Gm-Message-State: AOJu0YyUygeYCeeokn28TkmQP3JmWQN6MWcbJBFIpdVCTWIWPwqVpjeN
 Lz6EtVzX5VWhMh1/T+VbV8VOsArgnv+B4HCGBEnm5fUUUAmBPw/k0kOWDwn+R0g=
X-Google-Smtp-Source: AGHT+IHgx0iX78ZFSAt1Sg8Fi8zv1v5duSMN8J7u8UJXdU/WuVQsExzXkY22D7fzf2KwfDgwEYUb5g==
X-Received: by 2002:a05:6a00:1788:b0:6e6:a0de:563a with SMTP id
 s8-20020a056a00178800b006e6a0de563amr2515115pfg.15.1710249282249; 
 Tue, 12 Mar 2024 06:14:42 -0700 (PDT)
Received: from wheely.local0.net ([118.208.155.46])
 by smtp.gmail.com with ESMTPSA id
 r15-20020aa78b8f000000b006e64f75c947sm6066084pfd.46.2024.03.12.06.14.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 06:14:42 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PATCH v2 04/10] ppc/spapr: Remove copy-paste from pa-features
Date: Tue, 12 Mar 2024 23:14:13 +1000
Message-ID: <20240312131419.2196845-5-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240312131419.2196845-1-npiggin@gmail.com>
References: <20240312131419.2196845-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x435.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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


