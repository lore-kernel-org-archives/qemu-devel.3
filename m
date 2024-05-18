Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0BE1C25B74
	for <qemu-devel@archiver.kernel.org>; Sat, 18 May 2024 09:34:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s8GQv-0006dr-7o; Sat, 18 May 2024 05:32:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s8GQs-0006c1-UY; Sat, 18 May 2024 05:32:50 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s8GQr-0005zr-CV; Sat, 18 May 2024 05:32:50 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1ed41eb3382so30428795ad.0; 
 Sat, 18 May 2024 02:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716024767; x=1716629567; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dljcz6aaMRzJicXKlp7Qi2MLnj6X3mJ8Z+Z3n8U7SyE=;
 b=jqIWabDnbjkbkuMshXBIUXACRqwfMk111lHC/mNe+WBo2ycU0q0dcIAcTzsyk9fhEh
 qyBCB+gVBpfv5tGDuale/6urLpsTm1VidhspMSAofkdBDE4n2uYJVeNWJa7sk+k9q9Nm
 VD2v+bderYVAvDCKBFug8sdI+slzq0SyODyOOjii7RbVB+zUtJ0nYB+4oTHtQzkvswG2
 Gr2CNYyAm7vYOTr/QxTgV45ib/XpajvoqYKuUXDpH9YhJu2AaZ1pXTTlJKEg2xxhCo1W
 RiBnKuclYiHgW3DKlTtiB523JqH12in0g5Q+DK3lS9yhUanXOm6ymXqhlaFLBu7wZG+I
 x8jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716024767; x=1716629567;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dljcz6aaMRzJicXKlp7Qi2MLnj6X3mJ8Z+Z3n8U7SyE=;
 b=cJyl/r5bUrYejuGE9AFKvhzdQy6Et4GIJuTHKH6/m1h/RLui1iVBGMfyVQhsXm8djI
 j8RzzEuPCJCqnDZ5mrsFeVJxg29lLf5xqGWYR4W6kl9fVIBnK1SdOCib1LpPx3lWATek
 HsLs3GfM8F0h+e0HIQqhZz9WMTII/Mef0N3Y17onYM34enNBkQeM9O2En3O+yuHUefpP
 MY+WQzd4NzmVPWkR1CJ+JgTolGtnRSxLNUCEnGCBXarGWwtzmXFkqbQCnxHtQs28EodH
 6xL1DTXr6ANdtmPFrzYCsP4Pj7BeCNFDtPnBVmOxhUXB3aTCSYDEGgGozvqm1pgH7wLZ
 DJlQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUd4Nz4by55a9zxWitS5Q1UZFRJD7Hy3fdDeegznDo7Kvmk358Oyruzepp3CGB00O4U9/oL4zhI3C1Hn93Qilf0J8m006Y=
X-Gm-Message-State: AOJu0Yzw/SiztUUqziwFay3xZAqHLlsnor4vMqCNd+h143FLoA0tGVIT
 y9ZK3y4CYaf3AiqeFKaeYUDTQYDoHjZ47LgUkihGXrhi8rz4GJQkLj0obg==
X-Google-Smtp-Source: AGHT+IF8CwoOPaL/W3RraOGgNG2IKXgtTFeaGb7HYLuzOfd7AT+w7CBqMGuPU4D56Jm3Aq5kGhgRFg==
X-Received: by 2002:a05:6a20:3d88:b0:1af:cefe:9741 with SMTP id
 adf61e73a8af0-1afde0b6d8dmr35700254637.17.1716024767184; 
 Sat, 18 May 2024 02:32:47 -0700 (PDT)
Received: from wheely.local0.net (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2b628ea6a05sm18518901a91.52.2024.05.18.02.32.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 May 2024 02:32:46 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Glenn Miles <milesg@linux.vnet.ibm.com>
Subject: [PATCH 12/14] target/ppc: Implement LDBAR, TTR SPRs
Date: Sat, 18 May 2024 19:31:54 +1000
Message-ID: <20240518093157.407144-13-npiggin@gmail.com>
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

LDBAR, TTR are a Power-specific SPRs. These simple implementations
are enough for IBM proprietary firmware for now.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/cpu.h      |  2 ++
 target/ppc/cpu_init.c | 10 ++++++++++
 2 files changed, 12 insertions(+)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 9a51e54c1c..a014efc23a 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -2098,6 +2098,7 @@ void ppc_compat_add_property(Object *obj, const char *name,
 #define SPR_DEXCR             (0x33C)
 #define SPR_IC                (0x350)
 #define SPR_VTB               (0x351)
+#define SPR_LDBAR             (0x352)
 #define SPR_MMCRC             (0x353)
 #define SPR_PSSCR             (0x357)
 #define SPR_440_INV0          (0x370)
@@ -2144,6 +2145,7 @@ void ppc_compat_add_property(Object *obj, const char *name,
 #define SPR_440_IVLIM         (0x399)
 #define SPR_TSCR              (0x399)
 #define SPR_750_DMAU          (0x39A)
+#define SPR_POWER_TTR         (0x39A)
 #define SPR_750_DMAL          (0x39B)
 #define SPR_440_RSTCFG        (0x39B)
 #define SPR_BOOKE_DCDBTRL     (0x39C)
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index dc6b4fc569..4591a68cc5 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -5784,6 +5784,16 @@ static void register_power_common_book4_sprs(CPUPPCState *env)
                  &spr_access_nop, &spr_write_generic,
                  &spr_access_nop, &spr_write_generic,
                  0x00000000);
+    spr_register_hv(env, SPR_LDBAR, "LDBAR",
+                 SPR_NOACCESS, SPR_NOACCESS,
+                 SPR_NOACCESS, SPR_NOACCESS,
+                 &spr_read_generic, &spr_core_lpar_write_generic,
+                 0x00000000);
+    spr_register_hv(env, SPR_POWER_TTR, "TTR",
+                 SPR_NOACCESS, SPR_NOACCESS,
+                 SPR_NOACCESS, SPR_NOACCESS,
+                 &spr_read_generic, &spr_core_write_generic,
+                 0x00000000);
 #endif
 }
 
-- 
2.43.0


