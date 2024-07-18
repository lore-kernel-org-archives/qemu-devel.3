Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C90A0C3DA64
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 02:11:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUGbh-0005gF-PE; Wed, 17 Jul 2024 22:10:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sUGbe-0005Xc-D2
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 22:10:55 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sUGbc-0003Q1-Pn
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 22:10:54 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1fc5239faebso2876975ad.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 19:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721268651; x=1721873451; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fXFqzJq5stYikqRA/h94ZxAeb2H3VZp1GZE0eqO7ouA=;
 b=XccpcEFILGchVR2GQtXbhe0Y/HJ++k1wPjyN2CBiyMt6bRkyiVNbiv/XzMSNrz4mcC
 gemMVmyEIJLEWh18cYRt7pdr8JVV8ykANRVQCVq9ERHtyXWcD4bJHmrFtIFeLE0EcHzk
 i3CMn/l6WOWpncjSQuKGWCSEqT3iEpeg4unnhpKhStdGIBRBwlc5DqjxYjO3kdLpnl6+
 bk2w15NLDsVRr9JcL7GxG4AZnCFcIOX+KFqMUa3D29LEyscjGxYchvnahOHpsWwd/YX2
 q9saqzgUg0vIwwBnlQWdXdpDMOPzWCtuj5gMDrrdqaZYB8A3kOajMxL1F3HiSf3p6RL0
 y6Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721268651; x=1721873451;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fXFqzJq5stYikqRA/h94ZxAeb2H3VZp1GZE0eqO7ouA=;
 b=EzSC0yHxTl/vEbYPekJgdIgp9X3rn34OxiViWbclED3EFZxBvICIuZAZiWpyRaX0Z5
 UrlVUlLLKtrGoVH31WpIHkvsMald6dorxGGGNKWKd2ECBQjR3jF2nYWI0bwWbOfunfm8
 p7IKohSQHK6keUjXkWFLCfMiUHKZGYGcwbRF7rT09Nvn6ptk/4mZuqnE/cVu5mx/c+Mv
 rU0TiHQkREM/5ysM6Qul5yXmVol2SG+EjX3ERp8nCXIh1lt0yO8ZQfrFWk3CjpcuBzqg
 mvTGZlIzC0q9lkJCaZ+QLjHbu2qSZ/JQBB0kzjxz35gMcOAjHK4/lxfAYMFq4q+Wdsg+
 6vlA==
X-Gm-Message-State: AOJu0Yw9822zXJds6Nzs9/aT86YzQu0a/GHEDmz36bxH96qspkMYQsHE
 RUuxhMKipC7kcOWT3HSymaoL9m92XTVLZkyuA6bCi/mymik+tdQm4qSt7dHi
X-Google-Smtp-Source: AGHT+IGYwkMAMIJoyCqjHStDY+A5ewrcjwBidCHzCEq+uvyuJc9yE06DvaJEpS8dlgUcEWSzoQdKZA==
X-Received: by 2002:a17:902:ec8d:b0:1fb:7c7f:6458 with SMTP id
 d9443c01a7336-1fc4e15a81bmr30839805ad.32.1721268651051; 
 Wed, 17 Jul 2024 19:10:51 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fc0bba949bsm81999385ad.69.2024.07.17.19.10.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jul 2024 19:10:50 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 09/30] target/riscv: Add amocas.[b|h] for Zabha
Date: Thu, 18 Jul 2024 12:09:51 +1000
Message-ID: <20240718021012.2057986-10-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240718021012.2057986-1-alistair.francis@wdc.com>
References: <20240718021012.2057986-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>

Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20240709113652.1239-10-zhiwei_liu@linux.alibaba.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/insn32.decode                  |  2 ++
 target/riscv/insn_trans/trans_rvzabha.c.inc | 14 ++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 3bad6372f2..c45b8fa1d8 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -1041,3 +1041,5 @@ amomin_h   10000 . . ..... ..... 001 ..... 0101111 @atom_st
 amomax_h   10100 . . ..... ..... 001 ..... 0101111 @atom_st
 amominu_h  11000 . . ..... ..... 001 ..... 0101111 @atom_st
 amomaxu_h  11100 . . ..... ..... 001 ..... 0101111 @atom_st
+amocas_b    00101 . . ..... ..... 000 ..... 0101111 @atom_st
+amocas_h    00101 . . ..... ..... 001 ..... 0101111 @atom_st
diff --git a/target/riscv/insn_trans/trans_rvzabha.c.inc b/target/riscv/insn_trans/trans_rvzabha.c.inc
index 9093a1cfc1..ce8edcba62 100644
--- a/target/riscv/insn_trans/trans_rvzabha.c.inc
+++ b/target/riscv/insn_trans/trans_rvzabha.c.inc
@@ -129,3 +129,17 @@ static bool trans_amomaxu_h(DisasContext *ctx, arg_amomaxu_h *a)
     REQUIRE_ZABHA(ctx);
     return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umax_tl, MO_TESW);
 }
+
+static bool trans_amocas_b(DisasContext *ctx, arg_amocas_b *a)
+{
+    REQUIRE_ZACAS(ctx);
+    REQUIRE_ZABHA(ctx);
+    return gen_cmpxchg(ctx, a, MO_SB);
+}
+
+static bool trans_amocas_h(DisasContext *ctx, arg_amocas_h *a)
+{
+    REQUIRE_ZACAS(ctx);
+    REQUIRE_ZABHA(ctx);
+    return gen_cmpxchg(ctx, a, MO_ALIGN | MO_TESW);
+}
-- 
2.45.2


