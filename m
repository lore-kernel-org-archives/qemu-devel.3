Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22AF0C25B79
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 23:13:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAHZw-0003vA-0O; Thu, 23 May 2024 19:10:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHZI-0001Ut-QK; Thu, 23 May 2024 19:09:53 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHZC-0005qJ-UM; Thu, 23 May 2024 19:09:52 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6f6a045d476so2706986b3a.1; 
 Thu, 23 May 2024 16:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716505784; x=1717110584; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uzMhhwAkh7nUjGFjKdNpEd0P3eWobtNQTn2lU7sMhYQ=;
 b=VeEzRgWFghiZJNPZLthjGmTQzmwHNhKAq68kYfZ7jK8f4e/75UQwTjtEJAgJpmLtHN
 2yWGD2mcUi8jXABZbu/GvjFHMIPbO3VbEkQC2HuJ3AqUb5dx9fowRQjSfGsdC5U6lcfl
 g3MmoiNHCNRlzFIw7rp8kl6nipgNQeYaJM98wkQFH0kDGyNS/Xe9MASo6udynuIFuYvs
 DYBAcqyde4TrqEwVlUXffg7uB8UOnLAfFo3havwz8eTjdmLyd/BXc85P3Po1z0PsGAyp
 E/mYuwxsaMNslK7D3j0Vbc3BgWoRLu8ympBCxO6upCjSpPBFKPu4TdM91gEchWrtiEUe
 7/Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716505784; x=1717110584;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uzMhhwAkh7nUjGFjKdNpEd0P3eWobtNQTn2lU7sMhYQ=;
 b=rV9X8RZqgL/K96/J0byS0DJ9cNzGclNv7sxDMuXV98y386EJDqKb7DV36wrWgK9Viy
 b5HoAyl84pT6/WaqinijS+pgmMh8WYS2DejOnGRWCTLNjmXHgllTqXHopGIlVLgPTvVm
 9ed++MkU4b4ts5q9ca9pibIJPYeHhVkhVHSUtRlG6lCxiLYhzu+00fmmQVLc7OopREZ5
 AzZlFfZblAnFVI4LU9iHMbNzc0wjp7183CWtGBoQEniw4K/SToB53nawsD/D7jq1xlkp
 yMJkdlWcXTfofYsDeY/fS2RoGoMpcPWlSF5UU/W7rIJTQ7Ped9tUMZziEenIIS5wOyVw
 SH2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVkDl15vcMKcH7euTSN+5jMqtrxwYrBcCFb+61qkTDtsroJxp3SUq9AWXfc6/FJAN6vwGLRl2zs1vdsdXqTBrfZRbhv
X-Gm-Message-State: AOJu0YzXH+o5dGAWBUII6Ctny2sJeT67VjNHBqOfzcC+Ezq+OZdVXz7D
 Kbv/i3Gw0kYhHtG2PT58w9GbHtwvhFp9KWsD0sYIp5vSlhb/1ZL8/sMd3A==
X-Google-Smtp-Source: AGHT+IEQ+Cde3Us0igEP8tvdo6N4C67X8RJo/z7eQqm17K5vu7HZSsw4GPXw/USomq5KLC0QrE8Ixg==
X-Received: by 2002:a05:6a20:96d3:b0:1af:a35b:a34f with SMTP id
 adf61e73a8af0-1b212daea01mr947037637.25.1716505783882; 
 Thu, 23 May 2024 16:09:43 -0700 (PDT)
Received: from wheely.local0.net (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-682227f1838sm87041a12.46.2024.05.23.16.09.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 16:09:43 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Glenn Miles <milesg@linux.ibm.com>
Subject: [PULL 34/72] target/ppc: Add SMT support to simple SPRs
Date: Fri, 24 May 2024 09:07:07 +1000
Message-ID: <20240523230747.45703-35-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240523230747.45703-1-npiggin@gmail.com>
References: <20240523230747.45703-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

AMOR, MMCRC, HRMOR, TSCR, HMEER, RPR SPRs are per-core or per-LPAR
registers with simple (generic) implementations.

Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/cpu_init.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 6baf7555a7..415cc7a4e2 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -246,7 +246,7 @@ static void register_amr_sprs(CPUPPCState *env)
     spr_register_hv(env, SPR_AMOR, "AMOR",
                     SPR_NOACCESS, SPR_NOACCESS,
                     SPR_NOACCESS, SPR_NOACCESS,
-                    &spr_read_generic, &spr_write_generic,
+                    &spr_read_generic, &spr_core_lpar_write_generic,
                     0);
 #endif /* !CONFIG_USER_ONLY */
 }
@@ -5472,7 +5472,7 @@ static void register_book3s_ids_sprs(CPUPPCState *env)
     spr_register_hv(env, SPR_MMCRC, "MMCRC",
                  SPR_NOACCESS, SPR_NOACCESS,
                  SPR_NOACCESS, SPR_NOACCESS,
-                 &spr_read_generic, &spr_write_generic32,
+                 &spr_read_generic, &spr_core_write_generic32,
                  0x00000000);
     spr_register_hv(env, SPR_MMCRH, "MMCRH",
                  SPR_NOACCESS, SPR_NOACCESS,
@@ -5512,7 +5512,7 @@ static void register_book3s_ids_sprs(CPUPPCState *env)
     spr_register_hv(env, SPR_HRMOR, "HRMOR",
                  SPR_NOACCESS, SPR_NOACCESS,
                  SPR_NOACCESS, SPR_NOACCESS,
-                 &spr_read_generic, &spr_write_generic,
+                 &spr_read_generic, &spr_core_write_generic,
                  0x00000000);
 }
 
@@ -5740,7 +5740,7 @@ static void register_power_common_book4_sprs(CPUPPCState *env)
     spr_register_hv(env, SPR_TSCR, "TSCR",
                  SPR_NOACCESS, SPR_NOACCESS,
                  SPR_NOACCESS, SPR_NOACCESS,
-                 &spr_read_generic, &spr_write_generic32,
+                 &spr_read_generic, &spr_core_write_generic32,
                  0x00000000);
     spr_register_hv(env, SPR_HMER, "HMER",
                  SPR_NOACCESS, SPR_NOACCESS,
@@ -5750,7 +5750,7 @@ static void register_power_common_book4_sprs(CPUPPCState *env)
     spr_register_hv(env, SPR_HMEER, "HMEER",
                  SPR_NOACCESS, SPR_NOACCESS,
                  SPR_NOACCESS, SPR_NOACCESS,
-                 &spr_read_generic, &spr_write_generic,
+                 &spr_read_generic, &spr_core_write_generic,
                  0x00000000);
     spr_register_hv(env, SPR_TFMR, "TFMR",
                  SPR_NOACCESS, SPR_NOACCESS,
@@ -5826,7 +5826,7 @@ static void register_power8_rpr_sprs(CPUPPCState *env)
     spr_register_hv(env, SPR_RPR, "RPR",
                     SPR_NOACCESS, SPR_NOACCESS,
                     SPR_NOACCESS, SPR_NOACCESS,
-                    &spr_read_generic, &spr_write_generic,
+                    &spr_read_generic, &spr_core_write_generic,
                     0x00000103070F1F3F);
 #endif
 }
-- 
2.43.0


