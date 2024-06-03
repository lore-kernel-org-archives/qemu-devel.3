Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9FF5C25B76
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 11:22:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE5hT-0006Lj-AL; Mon, 03 Jun 2024 07:18:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sE5hO-0005wH-9y; Mon, 03 Jun 2024 07:17:58 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sE5hL-0006Ov-I3; Mon, 03 Jun 2024 07:17:57 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1f44b594deeso30730745ad.2; 
 Mon, 03 Jun 2024 04:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717413472; x=1718018272; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CrA1yFz/vo6xDp44uAmjkDhM86TQ9bxMrsQw3O2UUX8=;
 b=VuIAVzJeg+KB+VSzEjdKeSh1MhGHuDZ4EdnH0YuQyXOP0EYk5/NegqsN5caY/pIBmd
 Ld/4ngGBz0qDR0qInginHe9eRVUxUsAmdw3ZpkgyNwAVaiOSbf4fHd2iOsu+pqux+IcA
 6mer7IH6WRYLob4Qe9afVvVYh9Q3Bv44sNpD//1ijgMKlKJyUSC+4Q4dzIwgG9LH1wgR
 MURU+YypaapJDSGhtOJ7vm/FCbp4wUVnN6HAixfp8d8ARoAfcr4Xory2i2dQW3V68o5G
 tU4K+NFjBAsAQ6CiY6wOcrCZpBYJsyqsJjwQq4sUfxE9Sgit2fW/5jSd0Frq5wQwIgz2
 524A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717413472; x=1718018272;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CrA1yFz/vo6xDp44uAmjkDhM86TQ9bxMrsQw3O2UUX8=;
 b=mkbFYlIOE3U+VOKhY9ZO/yLx1ctHeSZe09713UZus2qoIBtgOvxmwBfDg7g+83v7NQ
 mGENpN50jAAsRA8IppaAaklpfDs9KbgO3JY6twru1aaTIKvSjg8YX00TRHG7qmepUXuk
 xD+q0S2ER3sgjPCc3O6reLI30HIO8X3Yx80IzkNL/DcmKUsmRZPDUOOinfK80A66Sme6
 IIVVHTKar7puuLJrNcLOjIldyOCevqxOM/M7EiUIc8LXpBwGAm9U5QWcNqG/em+djkL3
 +B3w7k0YLnUT9ciXts/vwE8txScOnfpgh7XN+1U/b2s0vmFwpYHPMYRpBHAk5yuRiNz6
 dAag==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxZ/4Axz+k7QYLr5u0sipNpGUNic1YYjAVhXQe/Efo0jPoDw2ZUKY8iUWzVPrvk73NKmdQ0GLOZ2b5S1c08pNfjzQh2X9e
X-Gm-Message-State: AOJu0YzfoiIBpD5IYZQKyaFT2HEbi/hhq7i1TTUp3HiygA4EmOz8LpZP
 GhWIaM1WFg/YC0DxZzTkjsjgSfqnqejUakO+lAJfUOmNZ9pXstGzZpsv0w==
X-Google-Smtp-Source: AGHT+IHLZdOD6jDKBTKp5CPdBBrkZ/KyevNtMSR8Q2kgcY3Q6SzWuPOJ1apZzGMqSFXipRf326yINg==
X-Received: by 2002:a17:902:e546:b0:1f6:5bba:f134 with SMTP id
 d9443c01a7336-1f65bbaf520mr58365435ad.46.1717413471702; 
 Mon, 03 Jun 2024 04:17:51 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f6323e18c7sm62375435ad.177.2024.06.03.04.17.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 04:17:51 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Max Chou <max.chou@sifive.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 qemu-stable <qemu-stable@nongnu.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 18/27] target/riscv: rvv: Check single width operator for
 vector fp widen instructions
Date: Mon,  3 Jun 2024 21:16:34 +1000
Message-ID: <20240603111643.258712-19-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240603111643.258712-1-alistair.francis@wdc.com>
References: <20240603111643.258712-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x630.google.com
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

The require_scale_rvf function only checks the double width operator for
the vector floating point widen instructions, so most of the widen
checking functions need to add require_rvf for single width operator.

The vfwcvt.f.x.v and vfwcvt.f.xu.v instructions convert single width
integer to double width float, so the opfxv_widen_check function doesn’t
need require_rvf for the single width operator(integer).

Signed-off-by: Max Chou <max.chou@sifive.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-stable <qemu-stable@nongnu.org>
Message-ID: <20240322092600.1198921-3-max.chou@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/insn_trans/trans_rvv.c.inc | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index 678b34b759..a7217aed4e 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -2331,6 +2331,7 @@ GEN_OPFVF_TRANS(vfrsub_vf,  opfvf_check)
 static bool opfvv_widen_check(DisasContext *s, arg_rmrr *a)
 {
     return require_rvv(s) &&
+           require_rvf(s) &&
            require_scale_rvf(s) &&
            (s->sew != MO_8) &&
            vext_check_isa_ill(s) &&
@@ -2370,6 +2371,7 @@ GEN_OPFVV_WIDEN_TRANS(vfwsub_vv, opfvv_widen_check)
 static bool opfvf_widen_check(DisasContext *s, arg_rmrr *a)
 {
     return require_rvv(s) &&
+           require_rvf(s) &&
            require_scale_rvf(s) &&
            (s->sew != MO_8) &&
            vext_check_isa_ill(s) &&
@@ -2402,6 +2404,7 @@ GEN_OPFVF_WIDEN_TRANS(vfwsub_vf)
 static bool opfwv_widen_check(DisasContext *s, arg_rmrr *a)
 {
     return require_rvv(s) &&
+           require_rvf(s) &&
            require_scale_rvf(s) &&
            (s->sew != MO_8) &&
            vext_check_isa_ill(s) &&
@@ -2441,6 +2444,7 @@ GEN_OPFWV_WIDEN_TRANS(vfwsub_wv)
 static bool opfwf_widen_check(DisasContext *s, arg_rmrr *a)
 {
     return require_rvv(s) &&
+           require_rvf(s) &&
            require_scale_rvf(s) &&
            (s->sew != MO_8) &&
            vext_check_isa_ill(s) &&
@@ -2941,6 +2945,7 @@ GEN_OPFVV_TRANS(vfredmin_vs, freduction_check)
 static bool freduction_widen_check(DisasContext *s, arg_rmrr *a)
 {
     return reduction_widen_check(s, a) &&
+           require_rvf(s) &&
            require_scale_rvf(s) &&
            (s->sew != MO_8);
 }
-- 
2.45.1


