Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03B91C25B74
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 02:46:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBmpg-0004cp-Q6; Mon, 27 May 2024 22:45:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sBmpe-0004Ro-GN; Mon, 27 May 2024 22:44:58 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sBmpc-0003nk-RD; Mon, 27 May 2024 22:44:58 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1f449f09476so20388965ad.1; 
 Mon, 27 May 2024 19:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716864295; x=1717469095; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oUhlj8L9io8L8IzXZjt++oPcFPCpbs/15osdPGsfaYk=;
 b=J6VEwH1tXNMICH7kkpvIyMRrf5z2v06PSYNfjIcc39Q0WJm6A2qRQvdxqvjlyYtg7l
 N4l8MRTW3KADN39i2EIXK6v/rupB2Ph8fgIW7LSw8ZCeuxKPFwb/xl0VDBY68ABczrKG
 m3WKTtlfL/byj/XkL9avzvghhvmmZIn7mGvN6s9kbIDCrR1UUZFG9PhBSNqqyl7RBaIA
 QNf8El1iL09p/wJ5Uztinh9vhncI9wBHhq9XsmiFfilB6Pq0eXE74oRm/GuhCN2NgaOB
 DyiCk2OFPTI8hmEJHJzeFwReUX4n8qvXZS8FUQ9Q87DaCq4Pmq2eiayk0cjLkj9/wMAH
 HtFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716864295; x=1717469095;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oUhlj8L9io8L8IzXZjt++oPcFPCpbs/15osdPGsfaYk=;
 b=E4/6LZAqUiGxasIJzxjOGnB2LRXgYkXE7ok4xLFcXpbY8P8fRrQ4PEsRQ/oAQ6Pzt3
 75inR52U/1ZNYZTcnwqaXgSprkgmJ/ttu/E7sEASqHa25jZwo+5DLWGXhiAaB3MYMe/M
 yotMw5T8pWAUb+fe3BOKCOCO10JIltr692u5SF6meByRsOUN8MI7Qq/BB0tFPDNkNqaW
 v2nUsVr35tldBlUVC47O2VCo/b4SY/JV3wf5hXDUpbpoLqR6+Xb+YblhoDmXFFdieaeg
 XJ6Ij+jOn2/Tw1sG5JBDFsLLe1PKMPFrtAIlY1PSDOwrmM7Np0QjCeg8hi8vVmZNhv9j
 JS6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXj7497d33isGxWZleyL9F/ZTjibwKjtJ9AIiTTkfJIIS8+36riaqwJVz5vjCZhfWBoul0npyjpRZOQutgQI4qv+nlh0Bxc
X-Gm-Message-State: AOJu0YzEHh9kxrdXLA23OL5TUwIhq5sBMakt5tm+ozeAcpNMwBjCdHXG
 rNNnr+homECWhhsJsJuNGfj5bQs3+0IVa3XsDHX1njHL7tfKKuWPDYF5QQ==
X-Google-Smtp-Source: AGHT+IFtuwI0vUERUGblnPGpA6xV+XeJbcgbERG3oYNjIgq5VkM71uWOeaybRTIkQNMakUSNNSS7qw==
X-Received: by 2002:a17:903:24e:b0:1f3:62c:247f with SMTP id
 d9443c01a7336-1f339f0a2afmr176940955ad.11.1716864294837; 
 Mon, 27 May 2024 19:44:54 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f44c970ca0sm70733225ad.142.2024.05.27.19.44.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 May 2024 19:44:54 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Max Chou <max.chou@sifive.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 qemu-stable <qemu-stable@nongnu.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 17/28] target/riscv: rvv: Fix Zvfhmin checking for vfwcvt.f.f.v
 and vfncvt.f.f.w instructions
Date: Tue, 28 May 2024 12:43:17 +1000
Message-ID: <20240528024328.246965-18-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240528024328.246965-1-alistair.francis@wdc.com>
References: <20240528024328.246965-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62e.google.com
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


