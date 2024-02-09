Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBEC7C48297
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 11:09:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYOfG-00006A-Hg; Fri, 09 Feb 2024 06:03:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rYOde-0007cD-3k
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 06:01:49 -0500
Received: from mail-oo1-xc32.google.com ([2607:f8b0:4864:20::c32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rYOda-0000vP-B0
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 06:01:43 -0500
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-599fc25071bso524383eaf.3
 for <qemu-devel@nongnu.org>; Fri, 09 Feb 2024 03:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707476498; x=1708081298; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=teOr56nysygkArJLfbemVfbfCqk3Hq8Cj+dj8nqNSbM=;
 b=SIrqIsjhfz531NU1XMgOXAEYPhGDI8/BduxZHixff1FgwX9+QworcnROuvwHX8TLOM
 e/8pVA7elpTxJ4fv0vmHkWz9BlTXiCzNCpKj0A80EkCYEQLukaUCETJiyjdvfLCdr3f+
 lnrhMw/ncNZBb+tjeNUpXHJt2JIp7yD7CCO7xclUYbauDpyrDA1rsDfOWIodi0uzXTfr
 oluD67qw4TQU8CCLaaTXdIEdXi6JRmcCuUUcOVeQICkCEmlajdADc+KdCp1Iq52AGgsB
 nNgpoRtHNqzqnA0Z4TMP2CU6p4RoY9fbqli3ITtQqJ2C5E2lr0zKATVrVeUJZgTQiEKu
 MIIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707476498; x=1708081298;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=teOr56nysygkArJLfbemVfbfCqk3Hq8Cj+dj8nqNSbM=;
 b=R8chAXaEsefvrSKwFrAnLtuEauhcbYqVoDVSOfEePFttwI089kl66CEr1JPUVafHxz
 FRFEvaBHDLpG/CHHoexLVVPSqZ7VKNsk+PriXhKMgYRlcIexF56EBe/OB4ursal6WPZH
 Bk3oBMTcfI2gqQvWRLaf5uVcmMSYcDrUowmzDdEd7WztdU/VPtbE6QvGj3P8dTvpN/q3
 jI91BT5MT/lNLVOn2iAzb5r4p3aeq9RUcMo1h5j1IOMun3VaMFXCri/NOxXTr7mO4q6B
 POvWq6LrKlAPfLBC6nfy/qRl9JMShmrDUMjkXm0f9BZ3xdwgo55may2aIwUjN2xJdCqa
 qCng==
X-Gm-Message-State: AOJu0YzrIW4kO64lncKzokySyxNDDH31rJgJlVYL1rhnSu6sfkckNvTY
 Y3OZBj54HA0KMgCwriHTXrliSMj67dAD8qt45kpS9zwQNxztxJXxV7Sz5APPf1+2nA==
X-Google-Smtp-Source: AGHT+IHaJejPsGG686dYe7cJknD6r3yxvNZyhNpTqqLQzhd8kPwZn3asUhPCrMwR27vka3Um/nDwdQ==
X-Received: by 2002:a05:6358:896:b0:176:3e0d:8a36 with SMTP id
 m22-20020a056358089600b001763e0d8a36mr1387554rwj.0.1707476498383; 
 Fri, 09 Feb 2024 03:01:38 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXvDZnQpNOnDE+4fcoxFXL63zVqiRjVLhNowymYAnJSCHrVVxFqhIom/yTU+gjjF77FDofYJcztoI4O0ljZEmSU018aTWz3Mw2rACBknKwMSBxFNl7aAmEm009t8PRIxJGi0rsX+oY=
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 d20-20020a637354000000b005d3bae243bbsm1473623pgn.4.2024.02.09.03.01.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Feb 2024 03:01:37 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 59/61] target/riscv: Enable xtheadsync under user mode
Date: Fri,  9 Feb 2024 20:58:11 +1000
Message-ID: <20240209105813.3590056-60-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240209105813.3590056-1-alistair.francis@wdc.com>
References: <20240209105813.3590056-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c32;
 envelope-from=alistair23@gmail.com; helo=mail-oo1-xc32.google.com
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

From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>

According to xtheadsync[1][2] documentation, it can be used in user mode and
the behavior is same with other priviledges.

[1]:https://github.com/T-head-Semi/thead-extension-spec/blob/master/xtheadsync/sync.adoc
[2]:https://github.com/T-head-Semi/thead-extension-spec/blob/master/xtheadsync/sync_i.adoc

Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20240204055228.900-1-zhiwei_liu@linux.alibaba.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/insn_trans/trans_xthead.c.inc | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/target/riscv/insn_trans/trans_xthead.c.inc b/target/riscv/insn_trans/trans_xthead.c.inc
index dbb6411239..22488412d4 100644
--- a/target/riscv/insn_trans/trans_xthead.c.inc
+++ b/target/riscv/insn_trans/trans_xthead.c.inc
@@ -992,7 +992,6 @@ static bool trans_th_sfence_vmas(DisasContext *ctx, arg_th_sfence_vmas *a)
 #endif
 }
 
-#ifndef CONFIG_USER_ONLY
 static void gen_th_sync_local(DisasContext *ctx)
 {
     /*
@@ -1003,14 +1002,12 @@ static void gen_th_sync_local(DisasContext *ctx)
     tcg_gen_exit_tb(NULL, 0);
     ctx->base.is_jmp = DISAS_NORETURN;
 }
-#endif
 
 static bool trans_th_sync(DisasContext *ctx, arg_th_sync *a)
 {
     (void) a;
     REQUIRE_XTHEADSYNC(ctx);
 
-#ifndef CONFIG_USER_ONLY
     REQUIRE_PRIV_MSU(ctx);
 
     /*
@@ -1019,9 +1016,6 @@ static bool trans_th_sync(DisasContext *ctx, arg_th_sync *a)
     gen_th_sync_local(ctx);
 
     return true;
-#else
-    return false;
-#endif
 }
 
 static bool trans_th_sync_i(DisasContext *ctx, arg_th_sync_i *a)
@@ -1029,7 +1023,6 @@ static bool trans_th_sync_i(DisasContext *ctx, arg_th_sync_i *a)
     (void) a;
     REQUIRE_XTHEADSYNC(ctx);
 
-#ifndef CONFIG_USER_ONLY
     REQUIRE_PRIV_MSU(ctx);
 
     /*
@@ -1038,9 +1031,6 @@ static bool trans_th_sync_i(DisasContext *ctx, arg_th_sync_i *a)
     gen_th_sync_local(ctx);
 
     return true;
-#else
-    return false;
-#endif
 }
 
 static bool trans_th_sync_is(DisasContext *ctx, arg_th_sync_is *a)
-- 
2.43.0


