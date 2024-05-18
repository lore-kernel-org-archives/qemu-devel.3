Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 265BCC25B74
	for <qemu-devel@archiver.kernel.org>; Sat, 18 May 2024 09:33:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s8GQr-0006ZT-7h; Sat, 18 May 2024 05:32:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s8GQm-0006WC-SQ; Sat, 18 May 2024 05:32:46 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s8GQk-0005yZ-VB; Sat, 18 May 2024 05:32:44 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1eb0e08bfd2so33101465ad.1; 
 Sat, 18 May 2024 02:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716024761; x=1716629561; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o4qQ+pydW7/H/FceYCg6Igyj7xZn2LiKCjn6liCZR3A=;
 b=HzYvvPHMmZj55oYgux75YPxoKQZWB8JYpMaOW1MQsfJXJhsB38dgV02Mu/Kp9kuaiK
 AaCsU5Q0uR948jAfljm3y7lYW1wCFX/sLDUTyZRIXQ7W8yRrACmDGi2MR/d6sN1zRrwu
 pJSAuMH4RarUbDzkpBfzmQ2yx0nufX3oM55/QrSC7V77FbrazCp6ckftP8q1unhMifDn
 ih3S/4KkVyo731ji/94UAhjAOq8ACQJJvmwRcZ4j/hCppJ3J8XB+7+l/gskBY/3YAOxx
 skjGH2Q7T1z9kxarvaa33TRc7Ksp37bWOv0+rtbj0LXQTxVlki25ubPQJjqDRvpWkXzQ
 03Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716024761; x=1716629561;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o4qQ+pydW7/H/FceYCg6Igyj7xZn2LiKCjn6liCZR3A=;
 b=LwmaE802xs3zYYE7GNEAgbxhtGb6bVZ9NEDvbnRttXKiHaFWVFuUawNTDl2hQWVqE7
 Np7zmbJ9D7pihprfwcoXC9wfwBwZWr9rdN2WkgH5ORoOZua9iluyp88nSB9a6o52Aqwt
 kYkwDvSPzsZoJUYZToiJEGCk1b1GHB55+S2FJYYDOhDW+KUjBSkOq3nRWmYyZa2yXXQz
 qp4NFWF0EOFeR1uDlJz4CODlGNLZx1avGrCTjJJ8PWd8hysPeulneagwc+DFk5lucOlQ
 b/wtyqSt17GSiTOYk0D2Cp2s+bLSp1flu7pSTPwqc6b/3RnC2l4NPNnukyHpcGnK8odp
 Z7bg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/ZTyrSu8BcqkDWXfNqz7ORTpReJYWSK9wXcUNnYiyur1K+rxVyJH71tN7t4utZklyEPisTczmZVdusE7ZMP10k7L9TbE=
X-Gm-Message-State: AOJu0YyjIBzNvbrj3ygxdl/uZ+fMHySUIcXcnBsNBwpIS3EUUFW8u1cK
 uixWUTyKPV5vUnvDS3nRphch+pki39hpUcHHgX+rWXgVGrhnKzDTANLHLQ==
X-Google-Smtp-Source: AGHT+IEBx4kaWv+tdOvVNoAg3OPK8Kg+kZJERNqmz2RpwgkiXpMa9vKonTIiOekQsPV31lxyXoNUzQ==
X-Received: by 2002:a17:90a:a395:b0:2b4:a767:193e with SMTP id
 98e67ed59e1d1-2b6ccd6b9c0mr21640233a91.38.1716024760775; 
 Sat, 18 May 2024 02:32:40 -0700 (PDT)
Received: from wheely.local0.net (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2b628ea6a05sm18518901a91.52.2024.05.18.02.32.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 May 2024 02:32:40 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Glenn Miles <milesg@linux.vnet.ibm.com>
Subject: [PATCH 10/14] target/ppc: Add SMT support to simple SPRs
Date: Sat, 18 May 2024 19:31:52 +1000
Message-ID: <20240518093157.407144-11-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240518093157.407144-1-npiggin@gmail.com>
References: <20240518093157.407144-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62e.google.com
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

AMOR, MMCRC, HRMOR, TSCR, HMEER, RPR SPRs are per-core or per-LPAR
registers with simple (generic) implementations.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/cpu_init.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index dd45251d7a..dc6b4fc569 100644
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
@@ -5489,7 +5489,7 @@ static void register_book3s_ids_sprs(CPUPPCState *env)
     spr_register_hv(env, SPR_MMCRC, "MMCRC",
                  SPR_NOACCESS, SPR_NOACCESS,
                  SPR_NOACCESS, SPR_NOACCESS,
-                 &spr_read_generic, &spr_write_generic32,
+                 &spr_read_generic, &spr_core_write_generic32,
                  0x00000000);
     spr_register_hv(env, SPR_MMCRH, "MMCRH",
                  SPR_NOACCESS, SPR_NOACCESS,
@@ -5529,7 +5529,7 @@ static void register_book3s_ids_sprs(CPUPPCState *env)
     spr_register_hv(env, SPR_HRMOR, "HRMOR",
                  SPR_NOACCESS, SPR_NOACCESS,
                  SPR_NOACCESS, SPR_NOACCESS,
-                 &spr_read_generic, &spr_write_generic,
+                 &spr_read_generic, &spr_core_write_generic,
                  0x00000000);
 }
 
@@ -5757,7 +5757,7 @@ static void register_power_common_book4_sprs(CPUPPCState *env)
     spr_register_hv(env, SPR_TSCR, "TSCR",
                  SPR_NOACCESS, SPR_NOACCESS,
                  SPR_NOACCESS, SPR_NOACCESS,
-                 &spr_read_generic, &spr_write_generic32,
+                 &spr_read_generic, &spr_core_write_generic32,
                  0x00000000);
     spr_register_hv(env, SPR_HMER, "HMER",
                  SPR_NOACCESS, SPR_NOACCESS,
@@ -5767,7 +5767,7 @@ static void register_power_common_book4_sprs(CPUPPCState *env)
     spr_register_hv(env, SPR_HMEER, "HMEER",
                  SPR_NOACCESS, SPR_NOACCESS,
                  SPR_NOACCESS, SPR_NOACCESS,
-                 &spr_read_generic, &spr_write_generic,
+                 &spr_read_generic, &spr_core_write_generic,
                  0x00000000);
     spr_register_hv(env, SPR_TFMR, "TFMR",
                  SPR_NOACCESS, SPR_NOACCESS,
@@ -5843,7 +5843,7 @@ static void register_power8_rpr_sprs(CPUPPCState *env)
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


