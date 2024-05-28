Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31D90C25B74
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 02:45:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBmpk-0004tV-Ob; Mon, 27 May 2024 22:45:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sBmpj-0004m9-9K; Mon, 27 May 2024 22:45:03 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sBmpg-0003o4-De; Mon, 27 May 2024 22:45:02 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1f44b59f8daso2497315ad.2; 
 Mon, 27 May 2024 19:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716864298; x=1717469098; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CrA1yFz/vo6xDp44uAmjkDhM86TQ9bxMrsQw3O2UUX8=;
 b=QCUEvSOdLt0M6r6g0vnyj98ctwiL9mC0p9CtehZjJIBuHeDtK68iS6Zyybo7x2SKUR
 BNhn0LAKU+J6jnHHXafJeICPBjehHeeDdQ51TNj2+NkcwVxwm7RLyztjx4KP0zQfJKbJ
 XAJdCsK/fLsU5YFvXGLmlabzeM35+Trwv5IJW9bZYw+1cq6W9no/bDIwqqMIwtrsI9SM
 yUvPN9uJEeZeF8JLykCoebQixsDEFtyng/jXzt++8OyJOFDl/dj5noNBf/Mg+aQ1B5w8
 VhZb0uX/0f8TEe9fVcJq7IyujCpmxg5mrRsRq+Bz3mSsnvN1Yj1oJxpToyWj5Ahokoww
 +ClQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716864298; x=1717469098;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CrA1yFz/vo6xDp44uAmjkDhM86TQ9bxMrsQw3O2UUX8=;
 b=XzoaER6wbyVocIfpA495fAcdaZkodi/rqIZvyliAuHYKQJVOpXx/AZ9VOVF/0L1Ncn
 1j8HGTv71Tv1G1yHA8TOctfWKqucjRDctlTeUh1VD8ctjBIAhkDPM0nrE64XfjXqvMJx
 phfjSxLZTkNUzCtWrXfXBQ7rfQ0nqRjwtN7hV3NkK2nzuryDIVM5J6f93ZvgDfWvzcx4
 6RhiSO6oRMBNNPctZ9JlQFdxcvz5Zf/UjweT13dNR0TtYHPT6oPGDgI2pkWXdSYV3f8N
 RDvx7S4dh3SyBKCB+79pKYruHCrYeGWzkyD+7k6PdogkgB7eVu5KzQpzjBrHUS8Pqitg
 R3BQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMU07MqCeL+29Z0x4v18l6Z8VVrrWdcdEc7IWe9CCp1Vcg9BKhpo9yzotLaH4Zcx8L+Nl3MQiQRAwRdJsrHP6OMdln7SmK
X-Gm-Message-State: AOJu0Yzp5xamy5EdC0R4+kGiGQ17gul6sO8pEi8nysII78/NbkVPpWO1
 xJ6zNw2doFHRFlclF4RvWrcko6G3KSX0EXLNerw0nAKi4340au+r7wkNQw==
X-Google-Smtp-Source: AGHT+IERtJWplXAkVe42m7eSe91PQx9xAN+0MwaR8Re8rQe9y68HkL6Q1ZZA+HZhxZxC9s7aCPeOHA==
X-Received: by 2002:a17:902:e544:b0:1f4:b702:f12d with SMTP id
 d9443c01a7336-1f4b702f441mr28424865ad.26.1716864298066; 
 Mon, 27 May 2024 19:44:58 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f44c970ca0sm70733225ad.142.2024.05.27.19.44.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 May 2024 19:44:57 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Max Chou <max.chou@sifive.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 qemu-stable <qemu-stable@nongnu.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 18/28] target/riscv: rvv: Check single width operator for
 vector fp widen instructions
Date: Tue, 28 May 2024 12:43:18 +1000
Message-ID: <20240528024328.246965-19-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240528024328.246965-1-alistair.francis@wdc.com>
References: <20240528024328.246965-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62f.google.com
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


