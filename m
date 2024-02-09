Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D5B8C48297
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 10:58:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYOaX-0008GT-U7; Fri, 09 Feb 2024 05:58:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rYOaW-0008Fo-Bg
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 05:58:32 -0500
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rYOaU-0000Ai-QD
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 05:58:32 -0500
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3bfd40ff56fso290165b6e.2
 for <qemu-devel@nongnu.org>; Fri, 09 Feb 2024 02:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707476309; x=1708081109; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Iq0LH3PHYyZB1cpshHA/QA9WLsuadbC8shEkZDLm1cY=;
 b=koIKoHJR0LfYQ5ZwBeWOgHL5C8nevoeiXAIh3QCoIrOggqz0Rzo340ZZMMQNc3Tr8H
 9s+TsUjP0x8w9Xocon2P6suBhfrg2+9UNP9pFVMxzGedGc93ny8SyQGm8ZT3j/xWb8g3
 LjISIKrrptjQ6IXt/hIdH97QWLIOg8T0sELhdGpRVOpH908C+7eSSufRRbKFRuJdp9HU
 HTXXb5uW/PMXNyUjL26csgAEIUwKMgYI22NqAPdUk6H6i4mh9onM1cBO7vrU/TDfRVlZ
 DOPqNdP9K3imOP10GutG2V5jQEcHyaDden7i/8S1lZnnbvr26pq1rvY3gAVRznjptZAT
 ZLvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707476309; x=1708081109;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Iq0LH3PHYyZB1cpshHA/QA9WLsuadbC8shEkZDLm1cY=;
 b=JY+IZ4P84VV3i7TrDkO5HMbK0UFtxM2bZp4MidLIO+KOA1VUr+ImfSO/nHlow+mWfZ
 4Htbpke6yj9ncJgWan4dCJnxN5MBFtWFiwg0IGwfWMOiFrTTXI/z47+BSKosQwWQZMhB
 vybsFmg3E8Wg+Lt+u54/9N7l4o2YOus8PzOfUqV+2baFamuF40k7iyTYAX8/rJW/7wBX
 3FSIvclQb/ZHlcNwKLPeM00XW2UeMIInFmLPPwaksVP3BCfNbrlHj4MaaYxv2ws/JWdF
 7njEgwCaNjG434NP230dV1bJXnQOolPC8sGo5CRe1IbKHQxS4F46ZmilJDKtQne2WQF5
 XE2g==
X-Gm-Message-State: AOJu0YzCr40AJ4H8Jg5nCGmFU8CUmPGEdxPxyR6fjhIyEdAOWO60EJq4
 MDvUH7Uu3aainFCAy6YHsYqvCLI8XcPBShN9SpLmyxrZIZAmtoPuV7C5KicQ5H4M4g==
X-Google-Smtp-Source: AGHT+IF/zQTjqfZtv5E1gPPtCkXCsi7yA76Ttt8t6OIUHEC9Z0+sGe2jlTkJw9CGHLFLRvlJiqHYyg==
X-Received: by 2002:a05:6358:33a2:b0:179:24b4:4204 with SMTP id
 i34-20020a05635833a200b0017924b44204mr1160808rwd.2.1707476309162; 
 Fri, 09 Feb 2024 02:58:29 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWqRnPjbgRdqt8EvGkiiBZ3D6BmbkCQYgQr3WfaR78zMPwuvxdbExAeWExGNy84wsOqGmkel9WkH9TsNNFZSkYURffD80U26I/fK+bXZ+stUjwT6gqsVaOVmzgJrPs38XxmQf5ixqwFICFPuEpWaVqT8KCMbzcwQzSmH0c=
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 d20-20020a637354000000b005d3bae243bbsm1473623pgn.4.2024.02.09.02.58.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Feb 2024 02:58:28 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Rob Bradford <rbradford@rivosinc.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PULL 01/61] target/riscv: Check for 'A' extension on all atomic
 instructions
Date: Fri,  9 Feb 2024 20:57:13 +1000
Message-ID: <20240209105813.3590056-2-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240209105813.3590056-1-alistair.francis@wdc.com>
References: <20240209105813.3590056-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22b;
 envelope-from=alistair23@gmail.com; helo=mail-oi1-x22b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Rob Bradford <rbradford@rivosinc.com>

Add requirement that 'A' is enabled for all atomic instructions that
lack the check. This makes the 64-bit versions consistent with the
32-bit versions in the same file.

Signed-off-by: Rob Bradford <rbradford@rivosinc.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20240110163959.31291-1-rbradford@rivosinc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/insn_trans/trans_rva.c.inc | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/target/riscv/insn_trans/trans_rva.c.inc b/target/riscv/insn_trans/trans_rva.c.inc
index 5f194a447b..f0368de3e4 100644
--- a/target/riscv/insn_trans/trans_rva.c.inc
+++ b/target/riscv/insn_trans/trans_rva.c.inc
@@ -163,65 +163,76 @@ static bool trans_amomaxu_w(DisasContext *ctx, arg_amomaxu_w *a)
 static bool trans_lr_d(DisasContext *ctx, arg_lr_d *a)
 {
     REQUIRE_64BIT(ctx);
+    REQUIRE_EXT(ctx, RVA);
     return gen_lr(ctx, a, MO_ALIGN | MO_TEUQ);
 }
 
 static bool trans_sc_d(DisasContext *ctx, arg_sc_d *a)
 {
     REQUIRE_64BIT(ctx);
+    REQUIRE_EXT(ctx, RVA);
     return gen_sc(ctx, a, (MO_ALIGN | MO_TEUQ));
 }
 
 static bool trans_amoswap_d(DisasContext *ctx, arg_amoswap_d *a)
 {
     REQUIRE_64BIT(ctx);
+    REQUIRE_EXT(ctx, RVA);
     return gen_amo(ctx, a, &tcg_gen_atomic_xchg_tl, (MO_ALIGN | MO_TEUQ));
 }
 
 static bool trans_amoadd_d(DisasContext *ctx, arg_amoadd_d *a)
 {
     REQUIRE_64BIT(ctx);
+    REQUIRE_EXT(ctx, RVA);
     return gen_amo(ctx, a, &tcg_gen_atomic_fetch_add_tl, (MO_ALIGN | MO_TEUQ));
 }
 
 static bool trans_amoxor_d(DisasContext *ctx, arg_amoxor_d *a)
 {
     REQUIRE_64BIT(ctx);
+    REQUIRE_EXT(ctx, RVA);
     return gen_amo(ctx, a, &tcg_gen_atomic_fetch_xor_tl, (MO_ALIGN | MO_TEUQ));
 }
 
 static bool trans_amoand_d(DisasContext *ctx, arg_amoand_d *a)
 {
     REQUIRE_64BIT(ctx);
+    REQUIRE_EXT(ctx, RVA);
     return gen_amo(ctx, a, &tcg_gen_atomic_fetch_and_tl, (MO_ALIGN | MO_TEUQ));
 }
 
 static bool trans_amoor_d(DisasContext *ctx, arg_amoor_d *a)
 {
     REQUIRE_64BIT(ctx);
+    REQUIRE_EXT(ctx, RVA);
     return gen_amo(ctx, a, &tcg_gen_atomic_fetch_or_tl, (MO_ALIGN | MO_TEUQ));
 }
 
 static bool trans_amomin_d(DisasContext *ctx, arg_amomin_d *a)
 {
     REQUIRE_64BIT(ctx);
+    REQUIRE_EXT(ctx, RVA);
     return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smin_tl, (MO_ALIGN | MO_TEUQ));
 }
 
 static bool trans_amomax_d(DisasContext *ctx, arg_amomax_d *a)
 {
     REQUIRE_64BIT(ctx);
+    REQUIRE_EXT(ctx, RVA);
     return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smax_tl, (MO_ALIGN | MO_TEUQ));
 }
 
 static bool trans_amominu_d(DisasContext *ctx, arg_amominu_d *a)
 {
     REQUIRE_64BIT(ctx);
+    REQUIRE_EXT(ctx, RVA);
     return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umin_tl, (MO_ALIGN | MO_TEUQ));
 }
 
 static bool trans_amomaxu_d(DisasContext *ctx, arg_amomaxu_d *a)
 {
     REQUIRE_64BIT(ctx);
+    REQUIRE_EXT(ctx, RVA);
     return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umax_tl, (MO_ALIGN | MO_TEUQ));
 }
-- 
2.43.0


