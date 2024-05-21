Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 507B0C25B79
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 01:32:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9ELb-0007w4-V0; Mon, 20 May 2024 21:31:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s9ELZ-0007vK-Hf; Mon, 20 May 2024 21:31:21 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s9ELX-0005Nf-PZ; Mon, 20 May 2024 21:31:21 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1edfc57ac0cso94445885ad.3; 
 Mon, 20 May 2024 18:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716255078; x=1716859878; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3M7m5trFhZtr2BOnL6BUkZtoVjgJAKVr9rWvGV0l+Ss=;
 b=Ib2hRZwhqBrVxHzxW1uBzjxh/N3AIot1+IEYu71WFmkCP+i1lm/C6+8Trf5fDA7Ts5
 MYOQDR1F3pYVjBkg6O6vPqXpns5P/AziGc0Qek8BsFzstPJLO+M1UPKd9YnBW1xlPYyS
 bRmoO1VJa91jn93iuidhL9vc5AysmzKmeLF3coIRnTH8rGfPxQPAeq0paI98/AUt1rYL
 kHYblTnjMyN6Dc2J18Us0KgTYxc4RoP4pf/mjWUGd4YHiNXPs31jwtpsebblFUlcX5kE
 m6K1hqz4VS18RgyI2SX/ffKOF+5fdKXO7Nx9pDP7HwBTOwkl7FmqAwYJwVS/0nb9UUd+
 DGQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716255078; x=1716859878;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3M7m5trFhZtr2BOnL6BUkZtoVjgJAKVr9rWvGV0l+Ss=;
 b=roxVwZs0EJWGkfjuHmmh64eUMwt2DM4I2j1JjWBL3KAHdDnfv4hproHEsQVJcXOy9F
 sEEfqJ+z1iks48iZALes5UplkhtyaZard24ALF4bcvsdflJjRffKFwH9G/+AZK7c9VOb
 8+YHP5rgkCS/Vr2hK8snnXj+ol08bkTyEH62ucNcTdC8ombelGIvL4M84cxlmSeHDXTx
 OyOjVr6LWM+SP+B1z8IDsLErwxhK93ahzeEBtfRFq+PUpVmgIqxLWVHA7Ce5LEjeEVEc
 ebAb+FMkQB6IcD01uT5+ZksXH0k+8eEPLHYgTLBL1O7LR+WA8ikkiwMavm+CBmqGpqqD
 yGgA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnmdzq4v8rZxoMlrOTxnLoY6QLQF2wtnUnnzW6K55J9TQJ0Er/F+oGl/WP9TeWyVZbPKttvQuYpt5knjoh+EmATdB071E=
X-Gm-Message-State: AOJu0YwQgyTxUukJXiJkjbw8dmoo4HOxXf+IAyRaxSrPBwQWvBgbcRUo
 hlkW5L47ibvnzqvNmoHUz2szlaTa+wXWd754K0TK25pWS4m0koJ/OAD1pw==
X-Google-Smtp-Source: AGHT+IG/23uwQqUn8GVpGUqtv2fyANvuOcSA61N3zjEUVW0k7HIG/TALEyVK83OJUJw1mIdTqPJaeQ==
X-Received: by 2002:a17:90a:1fcb:b0:2b6:29d3:30b with SMTP id
 98e67ed59e1d1-2b6cc566cd9mr24929387a91.7.1716255077750; 
 Mon, 20 May 2024 18:31:17 -0700 (PDT)
Received: from wheely.local0.net (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2bd7f0cd400sm2514953a91.31.2024.05.20.18.31.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 May 2024 18:31:17 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Glenn Miles <milesg@linux.vnet.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>
Subject: [PATCH v2 10/12] target/ppc: Implement LDBAR, TTR SPRs
Date: Tue, 21 May 2024 11:30:26 +1000
Message-ID: <20240521013029.30082-11-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240521013029.30082-1-npiggin@gmail.com>
References: <20240521013029.30082-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x635.google.com
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
index 141cbefb4c..823be85d03 100644
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
index 023b58a3ac..7f2f8e5a4a 100644
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


