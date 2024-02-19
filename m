Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 684BDC48260
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 08:35:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbz5H-0006ta-O0; Mon, 19 Feb 2024 03:33:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rbz52-0006Fi-2p; Mon, 19 Feb 2024 03:32:52 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rbz50-0002gj-16; Mon, 19 Feb 2024 03:32:51 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1db562438e0so31308495ad.3; 
 Mon, 19 Feb 2024 00:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708331563; x=1708936363; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G9dQsFszCC0E9Sl3E2+C8E6JRrg7A7/jy0wn4Bw7w60=;
 b=lg1Giwb4YNf9JIIHZOnzHhj2wUK7GSvBhKvP8M5EN0Rfz0NOfGLOJspPL4cnppTykL
 6GtPnD+yx9m077gZzA8Wzw+8gEf1y6/+DL3fXxoraIzc3YFmWsKT5C7L6/I8Sf+SxtHt
 k8YmXLSosWgW2n5PPyUHokXDSGZ0HxCVbThQbu37EJMbdYTfYdQysZ+h86zpGg7xfNF2
 /eJYSw4jvAUbLitXopk8kV7OzsrfWIQbEgP0tmYN7JZScc/6ULPcQCwLAWigxCA8mdwT
 4DIZ+4cTEdI3Gy+FXstQYxa9hScm2UTDmKoiRX/JjbWApiXa/Kc+VhF7/7XaezljslN1
 iZGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708331563; x=1708936363;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G9dQsFszCC0E9Sl3E2+C8E6JRrg7A7/jy0wn4Bw7w60=;
 b=rW5im9pGmDUXbyWdEdepETdAACZGjQreiuYc+4nNlplWPkW5qOt9C2ZJ2a8FhtraaQ
 utn3gvqbZy5Ix+V2uibN/QkynpbN79R2TVpLWy3PVzI64aHK3RA9Tf2yumXxI0Wk39jY
 0HmUsUg83CPuwWTnCg+eSjo30vEHgF3/xrawKJ4koojT3vHmi9BfSlpRKqHn1gqNQdMg
 mEc0sI9z5FP23BqPq73lpBbH5jFI/Kjl6F+Z+Ds6DvFYO0ww6Aj6VDrnxl66fop4H93E
 sle+iXI3HsFBdFHizXV8DjNxFqYaWC6vlNGlvqck2neaXx545/RoKO/LtNvK+tGuD4/R
 NSJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCK/OcHqkwhC+GIyphLJKu8AJkPJJXJAklg8eWVCFSVFbxQLvX0kYQRu4uy3eukhr/tdG+JSHpGYRd5XTb4YE0JXK4
X-Gm-Message-State: AOJu0YxuSfjfbL6vh2bc6N5R7voh9cmTFPK0J280gPr1P1cwwRkFE1xw
 t2EuQqwBsKdd0r+V/QXAFrTT0xotFwMbN+S1/3wO89F01hLCxhIN8ev4GsyL
X-Google-Smtp-Source: AGHT+IFNOfi0CS1XVQrmgymTIJySWTCb7D+Gs8Q0b9A8pTX0nx1fJd968qQBaoAMNIeUf85EZWgGwg==
X-Received: by 2002:a17:903:40ca:b0:1dc:1ef:aeb4 with SMTP id
 t10-20020a17090340ca00b001dc01efaeb4mr875443pld.35.1708331563119; 
 Mon, 19 Feb 2024 00:32:43 -0800 (PST)
Received: from wheely.local0.net ([1.146.38.93])
 by smtp.gmail.com with ESMTPSA id
 mo7-20020a1709030a8700b001db5ecd115bsm3838348plb.276.2024.02.19.00.32.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Feb 2024 00:32:42 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PULL 37/49] target/ppc: Improve timebase register defines naming
Date: Mon, 19 Feb 2024 18:29:26 +1000
Message-ID: <20240219082938.238302-38-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240219082938.238302-1-npiggin@gmail.com>
References: <20240219082938.238302-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62f.google.com
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

The timebase in ppc started out with the mftb instruction which is like
mfspr but addressed timebase registers (TBRs) rather than SPRs. These
instructions could be used to read TB and TBU at 268 and 269. Timebase
could be written via the TBL and TBU SPRs at 284 and 285.

The ISA changed around v2.03 to bring TB and TBU reads into the SPR
space at 268 and 269 (access via mftb TBR-space is still supported
but will be phased out). Later, VTB was added which is an entirely
different register.

The SPR number defines in QEMU are understandably inconsistently named.
Change SPR 268, 269, 284, 285 to TBL, TBU, WR_TBL, WR_TBU, respectively.

Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/cpu.h         |  8 ++++----
 target/ppc/helper_regs.c | 10 +++++-----
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index a44de22ca4..16baea609c 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1750,8 +1750,8 @@ void ppc_compat_add_property(Object *obj, const char *name,
 #define SPR_USPRG5            (0x105)
 #define SPR_USPRG6            (0x106)
 #define SPR_USPRG7            (0x107)
-#define SPR_VTBL              (0x10C)
-#define SPR_VTBU              (0x10D)
+#define SPR_TBL               (0x10C)
+#define SPR_TBU               (0x10D)
 #define SPR_SPRG0             (0x110)
 #define SPR_SPRG1             (0x111)
 #define SPR_SPRG2             (0x112)
@@ -1764,8 +1764,8 @@ void ppc_compat_add_property(Object *obj, const char *name,
 #define SPR_SPRG7             (0x117)
 #define SPR_ASR               (0x118)
 #define SPR_EAR               (0x11A)
-#define SPR_TBL               (0x11C)
-#define SPR_TBU               (0x11D)
+#define SPR_WR_TBL            (0x11C)
+#define SPR_WR_TBU            (0x11D)
 #define SPR_TBU40             (0x11E)
 #define SPR_SVR               (0x11E)
 #define SPR_BOOKE_PIR         (0x11E)
diff --git a/target/ppc/helper_regs.c b/target/ppc/helper_regs.c
index 8f5bd1536e..94c9a5a5c1 100644
--- a/target/ppc/helper_regs.c
+++ b/target/ppc/helper_regs.c
@@ -461,22 +461,22 @@ void register_generic_sprs(PowerPCCPU *cpu)
 
     /* Time base */
 #if defined(TARGET_PPC64)
-    spr_register(env, SPR_VTBL,  "TB",
+    spr_register(env, SPR_TBL, "TB",
 #else
-    spr_register(env, SPR_VTBL,  "TBL",
+    spr_register(env, SPR_TBL, "TBL",
 #endif
                  &spr_read_tbl, SPR_NOACCESS,
                  &spr_read_tbl, SPR_NOACCESS,
                  0x00000000);
-    spr_register(env, SPR_TBL,   "TBL",
+    spr_register(env, SPR_WR_TBL, "TBL",
                  &spr_read_tbl, SPR_NOACCESS,
                  &spr_read_tbl, &spr_write_tbl,
                  0x00000000);
-    spr_register(env, SPR_VTBU,  "TBU",
+    spr_register(env, SPR_TBU, "TBU",
                  &spr_read_tbu, SPR_NOACCESS,
                  &spr_read_tbu, SPR_NOACCESS,
                  0x00000000);
-    spr_register(env, SPR_TBU,   "TBU",
+    spr_register(env, SPR_WR_TBU, "TBU",
                  &spr_read_tbu, SPR_NOACCESS,
                  &spr_read_tbu, &spr_write_tbu,
                  0x00000000);
-- 
2.42.0


