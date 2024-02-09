Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5787C4829E
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 11:05:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYOce-0005zM-H0; Fri, 09 Feb 2024 06:00:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rYOcD-0005gy-GV
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 06:00:20 -0500
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rYOcB-0000ZO-Ci
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 06:00:16 -0500
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3be9e11ee59so330929b6e.1
 for <qemu-devel@nongnu.org>; Fri, 09 Feb 2024 03:00:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707476413; x=1708081213; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4G0W0v9r4J8ABl80ZHBwRJa7fTZwomUFMbyTGYeTvbs=;
 b=mfaMi7RrEJqiRZl4hsM8kxE62c8Fx5qtxYQVbmrEtEwvOoX6Os8Yt2OGTS3A9ZLkMr
 3AqIqeHEAHjf/Xah0lShzn0buwxlB7W0cQJzX3ZWuAHPXGCIOfwuqPSw1ZqhjFUXdfIR
 CZK//t8LyRqugxXR7RjGUYuKvlsfhcL86myC6FcOfeZjeZm2cBdCL6Ub4NQyPvuZ5Uyq
 Sg30Cwx0c5MokCurK2LdV16KOzH15Hl7LRFBUe7td/8q1XucxiEj+vh50TASA8AmQxBI
 TjOl+iCPkphlNPHJ0MJk2cFxy+LhsK7a1yzHbCqaGmGKq3iA4IEKN6uT/My+OS9Gaghr
 Yqsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707476413; x=1708081213;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4G0W0v9r4J8ABl80ZHBwRJa7fTZwomUFMbyTGYeTvbs=;
 b=LwCfAvvx/ncVl9bHTjeqeHfPvqGooruQqd2xsduzpLq372xwuEQ4oDfW5hURLcgRBe
 KZ0JdrsxDxrUyh6xrOll0br9sFW/wiWL4sm1UcshEQD/HerNLGSzce3JdnwdTYYf56Ts
 fviv/No5Bm3YEBwx4uTVWf9pLCBFdRb+43Qcrvj53Ppn2mif/Sa9waS8XJyl69MumHLg
 tfM87U5WTFShqANIcFbVIYQS0xvSeBnDJE+IE2+MH5qrre0k5bE/uN2BZOfX5Aj3AoZc
 SifEwLjg3PwqkxcvE8wda2MdU3kIo5czOgC9Xl6WWV/+ed6vPSL7DDcgQQOOPQ9pNXmj
 VH8w==
X-Gm-Message-State: AOJu0YzemR/ynzHHZyzFMUKsikliDqOzenTAQr1k/vZLx69ThvYXQKq5
 /UZmuo1QrOvE6aMVqXm2qgd5SlucEVF/HA6DyWecxA9bXImQBFe/wu119sc9b/CY8g==
X-Google-Smtp-Source: AGHT+IHCyq23y3nD/nWFezNmSVbpefFEQBJrVezamF+JV7wY3e4/CitSQQrL3KzZVspFycKxYh97pw==
X-Received: by 2002:a05:6359:458d:b0:176:bef2:634a with SMTP id
 no13-20020a056359458d00b00176bef2634amr1519760rwb.0.1707476413486; 
 Fri, 09 Feb 2024 03:00:13 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVoFhcldusbfidX0dguT8lTWdjgKKUGps+NcpJuzfzjHPAtbX5Kp9XbKDX4BTYQWVWr1+pZwzhBnkLpJ1R+o+GdhxuzQ3Iz3cz4R7tJ09dOhli6dJXBawzJDKVTtjVbbcnF+Yw=
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 d20-20020a637354000000b005d3bae243bbsm1473623pgn.4.2024.02.09.03.00.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Feb 2024 03:00:13 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 33/61] trans_rvv.c.inc: use vext_get_vlmax() in
 trans_vrgather_v*()
Date: Fri,  9 Feb 2024 20:57:45 +1000
Message-ID: <20240209105813.3590056-34-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240209105813.3590056-1-alistair.francis@wdc.com>
References: <20240209105813.3590056-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22f;
 envelope-from=alistair23@gmail.com; helo=mail-oi1-x22f.google.com
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Use the helper instead of calculating vlmax by hand.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20240122161107.26737-13-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/insn_trans/trans_rvv.c.inc | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index b4663b6e1f..9e101ab434 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -3535,8 +3535,7 @@ static bool trans_vrgather_vx(DisasContext *s, arg_rmrr *a)
     }
 
     if (a->vm && s->vl_eq_vlmax && !(s->vta && s->lmul < 0)) {
-        int scale = s->lmul - (s->sew + 3);
-        int vlmax = s->cfg_ptr->vlen >> -scale;
+        int vlmax = vext_get_vlmax(s->cfg_ptr->vlenb, s->sew, s->lmul);
         TCGv_i64 dest = tcg_temp_new_i64();
 
         if (a->rs1 == 0) {
@@ -3566,8 +3565,7 @@ static bool trans_vrgather_vi(DisasContext *s, arg_rmrr *a)
     }
 
     if (a->vm && s->vl_eq_vlmax && !(s->vta && s->lmul < 0)) {
-        int scale = s->lmul - (s->sew + 3);
-        int vlmax = s->cfg_ptr->vlen >> -scale;
+        int vlmax = vext_get_vlmax(s->cfg_ptr->vlenb, s->sew, s->lmul);
         if (a->rs1 >= vlmax) {
             tcg_gen_gvec_dup_imm(MO_64, vreg_ofs(s, a->rd),
                                  MAXSZ(s), MAXSZ(s), 0);
-- 
2.43.0


