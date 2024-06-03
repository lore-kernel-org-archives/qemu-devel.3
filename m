Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 396E5C25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 11:20:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE5hZ-0006pz-9w; Mon, 03 Jun 2024 07:18:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sE5hK-0005jy-Lu; Mon, 03 Jun 2024 07:17:54 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sE5hG-0006Od-J0; Mon, 03 Jun 2024 07:17:52 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1f612d7b0f5so26012085ad.0; 
 Mon, 03 Jun 2024 04:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717413468; x=1718018268; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oUhlj8L9io8L8IzXZjt++oPcFPCpbs/15osdPGsfaYk=;
 b=T+v0mWGRFWDlMYHXYWgsgOI5bGon+HeT4iCfYHNl1VighFqTvG4Mv/c1Dpj3GtIZ4h
 nASneh68cxdqxo1i3eX5seXFkvEp9uhayjH2RdN4RU8Js4iMhOh4PpKyR0OtH/PE5v+I
 u9vcD4sx5Ndwwj8Z2nA2eBNvXeyxN1zHoMe0Eu0jZyK3y72KtGgfrAg8QaplCSCSeVBR
 70bUI7Nkt8W7z8oFy38FG5RHf6R+wvCM3HRQbsCS/gtAFuUGV0Gvo7lJspUZFg7rF9DZ
 xoNOM6wxnRqNAKhUwb7S0xgNeC7s+j2MmtlizWcdDwcW9XjS1wUc+P07h4BS63stPZOX
 Jw4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717413468; x=1718018268;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oUhlj8L9io8L8IzXZjt++oPcFPCpbs/15osdPGsfaYk=;
 b=mXQgXs0nRMLAz75M7ZmcOIna52VKBwejCcPRD6czFTEiTTb8h96GZdMn8aIJJVcvOv
 BIN1wcGWE5e1xAphVOg5BHSQx0Ibgg9TgazGLtNMgQbDaP2qQKagZ9R2edv8gMMeNRRt
 paFNDs8nI7Cpmxlrne4A+rA+5CoIJggS/+OPTXhABqmbGQyMcxsb+7MVEg/wB1Q/IZ9T
 TjWNqh8i/EpcSFT48XFx1rdrxU2EsaJ/PyPnPBblbkLBvnZaXkLU9FuCLuhhUqJJD66c
 kZOPBJscDbpN9UQNlhFqju+B9l/p7JhxKfFtvV8EzvTqvsqN5sYxGBixLfTQQ5ldr2pL
 kKfw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvDLw5i/Dwlp/nGnaKo70GNsKENMNvvZ80+t/HEymfL+GoA4DpF1h5YY51OXE/u8V6uLLpC4pJE6kr1UZTL+m4hNsTEqHd
X-Gm-Message-State: AOJu0YxVnqZosBzSPAPq17gyRhDeQ/Je4oiKBWm0md87fHmMi4UXPYoV
 cjnp+nXZWQP4RE3jEQWOvdD72RnL6iWn6yEeJofIyn9dPns8j6R4M5SFqQ==
X-Google-Smtp-Source: AGHT+IE2m0t4TBzNaM5eTe8xzGM9TqdfFPJ+yJNyzW+RdiAXlVbEIQ6YQSXpDOq76bqGOI61sdUzIw==
X-Received: by 2002:a17:902:ea01:b0:1f6:5e40:6e22 with SMTP id
 d9443c01a7336-1f65e40702cmr64013795ad.9.1717413468472; 
 Mon, 03 Jun 2024 04:17:48 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f6323e18c7sm62375435ad.177.2024.06.03.04.17.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 04:17:48 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Max Chou <max.chou@sifive.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 qemu-stable <qemu-stable@nongnu.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 17/27] target/riscv: rvv: Fix Zvfhmin checking for
 vfwcvt.f.f.v and vfncvt.f.f.w instructions
Date: Mon,  3 Jun 2024 21:16:33 +1000
Message-ID: <20240603111643.258712-18-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240603111643.258712-1-alistair.francis@wdc.com>
References: <20240603111643.258712-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62d.google.com
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

From: Max Chou <max.chou@sifive.com>

According v spec 18.4, only the vfwcvt.f.f.v and vfncvt.f.f.w
instructions will be affected by Zvfhmin extension.
And the vfwcvt.f.f.v and vfncvt.f.f.w instructions only support the
conversions of

* From 1*SEW(16/32) to 2*SEW(32/64)
* From 2*SEW(32/64) to 1*SEW(16/32)

Signed-off-by: Max Chou <max.chou@sifive.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-stable <qemu-stable@nongnu.org>
Message-ID: <20240322092600.1198921-2-max.chou@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/insn_trans/trans_rvv.c.inc | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index eec2939e23..678b34b759 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -50,6 +50,22 @@ static bool require_rvf(DisasContext *s)
     }
 }
 
+static bool require_rvfmin(DisasContext *s)
+{
+    if (s->mstatus_fs == EXT_STATUS_DISABLED) {
+        return false;
+    }
+
+    switch (s->sew) {
+    case MO_16:
+        return s->cfg_ptr->ext_zvfhmin;
+    case MO_32:
+        return s->cfg_ptr->ext_zve32f;
+    default:
+        return false;
+    }
+}
+
 static bool require_scale_rvf(DisasContext *s)
 {
     if (s->mstatus_fs == EXT_STATUS_DISABLED) {
@@ -75,8 +91,6 @@ static bool require_scale_rvfmin(DisasContext *s)
     }
 
     switch (s->sew) {
-    case MO_8:
-        return s->cfg_ptr->ext_zvfhmin;
     case MO_16:
         return s->cfg_ptr->ext_zve32f;
     case MO_32:
@@ -2685,6 +2699,7 @@ static bool opxfv_widen_check(DisasContext *s, arg_rmr *a)
 static bool opffv_widen_check(DisasContext *s, arg_rmr *a)
 {
     return opfv_widen_check(s, a) &&
+           require_rvfmin(s) &&
            require_scale_rvfmin(s) &&
            (s->sew != MO_8);
 }
@@ -2790,6 +2805,7 @@ static bool opfxv_narrow_check(DisasContext *s, arg_rmr *a)
 static bool opffv_narrow_check(DisasContext *s, arg_rmr *a)
 {
     return opfv_narrow_check(s, a) &&
+           require_rvfmin(s) &&
            require_scale_rvfmin(s) &&
            (s->sew != MO_8);
 }
-- 
2.45.1


