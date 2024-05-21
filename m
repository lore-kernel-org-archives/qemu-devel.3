Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2030C25B77
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 01:32:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9ELT-0007qr-A6; Mon, 20 May 2024 21:31:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s9ELR-0007oM-Fj; Mon, 20 May 2024 21:31:13 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s9ELP-0005LZ-O6; Mon, 20 May 2024 21:31:13 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1ecc23e6c9dso93376115ad.2; 
 Mon, 20 May 2024 18:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716255069; x=1716859869; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mzfw0EKvyp7V4Mv+crjJx37Vf+DDxSzVKkZLcfZPdSY=;
 b=VdXGj3vZv4H1H+nZRA8wtO1OOVo1x4qEuRCDCwxBwqvVsHNVJfVtgYl64pZ7aOVuJC
 /xl16qj2EqZtQP8HrA5PdW6gqx7/gZErfg/RyUwgJjA8B82X80ofU7F6oEkiUMzZtVV+
 fdChWNG/NE+qcUgdzXJR7kmLBl5z7Fcm5BxFgD+fAOT6ah3CoK7kftsuVXiyRjiTPlgx
 yOrJoALaeYJiNSH+TKQLr4abb+9cQD3DBjBvFYokJvi4OLvuIKHPnhz8xZYpZd8Wcgwb
 MjTfUCWF4Zli5C5RLu4qeM0CK4hSODudLfI6VNWFq0FqxpQqrIcsiMsQWz4ji9ulOZ2L
 fPeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716255069; x=1716859869;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Mzfw0EKvyp7V4Mv+crjJx37Vf+DDxSzVKkZLcfZPdSY=;
 b=ZelC8pIQqu2VMXqgpndoEeuhdbTSWluhILuHuwKYHIXppXQf24+dhtD5Tdl1cR337i
 ITCvxYSgKWFHQT85aAzR6b/k78QkxOlEJ+PDj9cG03jg8t35idTeWNq3B0HzjvrRWrok
 v9NuEIHhjW6b0GV8tvhUCzoAQEP6uXGuWQHNDzFKxfa8ut/Qq+nn6Le/1EN+HmaSIwhM
 OIuZQyWhn38b4NObQRWDY6J7kEQpJRJ+sU0V8CQgBubGdNlCaCd0s2aXdLM84s+hYbpU
 32ZnTcZzSG60/pFBX9/wMZ1xB5xg/VKYNOabqRXkUSlnHncL5GQtpNHPf16pXe9sFM4n
 3sZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGq8dACOWFAwX56/u++5wTPdPfTFmza+0cEN+3mB//4DceUxgzLXywOZqDGltV+lgvqc/4ueFs80h4nC3zJ9P34J0F3zI=
X-Gm-Message-State: AOJu0YyrXXiiiElB45XRU7jPY3x4G4dwdi6iKzOMMhO7Yo20vB05AkN4
 SCe7a2WYc0k4CJN1xQLbHgLC4HKB6freVPZDzOEGQ5b316DGQYQ38D085Q==
X-Google-Smtp-Source: AGHT+IFHjGj6Cho4o2IaXtwWuBc+YXHxkTSoL6ro8glBDRHFYuKaxszitf2HxY1d/MDI5HriSZWJJA==
X-Received: by 2002:a17:90a:fb96:b0:2b9:dd9c:34cb with SMTP id
 98e67ed59e1d1-2b9dd9c350amr13459408a91.27.1716255069351; 
 Mon, 20 May 2024 18:31:09 -0700 (PDT)
Received: from wheely.local0.net (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2bd7f0cd400sm2514953a91.31.2024.05.20.18.31.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 May 2024 18:31:09 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Glenn Miles <milesg@linux.vnet.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>
Subject: [PATCH v2 08/12] target/ppc: Add SMT support to simple SPRs
Date: Tue, 21 May 2024 11:30:24 +1000
Message-ID: <20240521013029.30082-9-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240521013029.30082-1-npiggin@gmail.com>
References: <20240521013029.30082-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x629.google.com
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
index 7684a59d75..023b58a3ac 100644
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


