Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98C0BCD4F3C
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 05:32:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOqYU-00076J-Tx; Mon, 18 May 2026 01:30:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wOqY8-0006vP-S0
 for qemu-devel@nongnu.org; Mon, 18 May 2026 01:30:06 -0400
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wOqY1-0003V6-Sj
 for qemu-devel@nongnu.org; Mon, 18 May 2026 01:29:51 -0400
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-47c35be031dso1372095b6e.3
 for <qemu-devel@nongnu.org>; Sun, 17 May 2026 22:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779082183; x=1779686983; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Txw9wMK7kdKsqQsWB0GJxX9k0kkrLq5ISMljBQ04Ork=;
 b=Mb8s3tcRcAoPJ2YCKPhsmOqdRUWc/7lNP5r3Xx+gqeIzdY+hhHN+O2YcVlp6hT+qda
 A0fthai79pk9NJzY2BCp7A4VdGtk+O3h3jYOC8OdgsfxNZZnspa+4+zIkv+elSoaXRfA
 kQAmnOVs0DdmmLfiACHy5O5pQSHlLXpHJTH34k/ZZvHsKceM7Hf2FTvuFMPiapmjhOuK
 kECZn7X5N7LFt1ROaBrBuk9dd7o0slRktLnwy7vzgQhWJXtoGByxeaqu+Wzq2uFyZ7h8
 oOlBdfIPlN3nKKcEgqJKf0wR9sosi88iUp9N7d7/VlKdOJ2sK44VEZvvmz6yndqd0Tkm
 srKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779082183; x=1779686983;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Txw9wMK7kdKsqQsWB0GJxX9k0kkrLq5ISMljBQ04Ork=;
 b=Df3Mng4kLucC9P7M6Oj1QWcMQ5QZwBJDZz7FbVucaYdSuF6Xr5yp8HbckP+hynF3aw
 czeojNsFvcXCv3VGGTyNnkwjSrRSvIJOR2JMpVtuwPmSB62J1s7WCK6/shNuVzbyZu8t
 FP1dhpZDfnIRlewig7AXaRv2Vgk7FDgchY+3ogSZpGddmLKLOk8F53EOX98d2kPm0mQE
 8/E4RtIxPFtLDNLCfjh3kvvybd3CDT+7lJkNFFIwCoHJ9ufpR0oKvlcVbqItgW+viMOu
 Nlts0RTO/HxRw7q6axVyHPumGZvCo9vG5HYZDgCWXs9Bh3rgV77691oe2CSkFe5/Xznl
 aFzA==
X-Gm-Message-State: AOJu0YwjKrOExIckfm0joajhjQFR8qSPxuOo2Jx6rigr8v9DtjYzTatl
 ilbSIn9WbFgQlQy+/tMQ6FhPlqK81opJmqm+ihCSmm+nOklzkSoHaYyD
X-Gm-Gg: Acq92OFMqt7uoLoD7mnl71kU+wolL8rAuUkVbP2YfoMJIueR6LX/x26TgSx+SvhA/1j
 +pmnQ9b1UpFWvy1AwYs8ingXW9EPLK4aGAfcXxIp4ThY7Pi0gH5mt9LWwFmH01+ulVF9kqDpwCI
 E+jMD4XWpTc5KPWHJWDPjtkQtpl9m2wRZ0eeZOMhdkJoOAdzpkeVvvGUxehTfZKXw3ujdvqUAJv
 rFZnz+i9TWJNhChi8Aa24Suc+PDflMR5UN5iDYYVakgA7DDFtwenRmQHP70/ilK5roDW25xbBFA
 KCzpqf0ADQxiF4pZxV+fFfSGVTlw7Xwe81QQ2eK3SnMLz1v9auRyELLA87Ih+Bi/3EIfe+RJ0bN
 Ce38SmtOi/o/9CzHWpg9yLV6VDLhS+N8+IVf0xudYQqwUVvbA86qzCTneYnK9cQtR0jhy9b46+b
 r+RXCBLtD+hvCGlm9bjuXtfmywHRmIqTcxRGXQJ6MO78ckU4Nad8E7Rqva18XGP2oBcK3Hi8O0F
 NY+eRS19wybLHCIwaW48+1QmGIfgmCCrMB6+/razyV8XBKZwO8XmXeGVJVqgKfBauQHDrc=
X-Received: by 2002:a05:6808:3204:b0:467:13b5:8ae6 with SMTP id
 5614622812f47-482e55af81fmr8980859b6e.4.1779082182765; 
 Sun, 17 May 2026 22:29:42 -0700 (PDT)
Received: from mac.localdomain (71-218-255-245.hlrn.qwest.net.
 [71.218.255.245]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-482ee5349a5sm4628357b6e.15.2026.05.17.22.29.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 May 2026 22:29:42 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 17 May 2026 23:29:16 -0600
Subject: [PATCH v8 19/35] target/mips: add Octeon VMM0 instruction
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260517-mips-octeon-missing-insns-v2-v8-19-206151ee77ec@gmail.com>
References: <20260517-mips-octeon-missing-insns-v2-v8-0-206151ee77ec@gmail.com>
In-Reply-To: <20260517-mips-octeon-missing-insns-v2-v8-0-206151ee77ec@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::22f;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oi1-x22f.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

VMM0 multiplies MPL[0] by rs, adds rt and the queued P[0] partial
product, returns the low result, and feeds that result back into MPL[0].
It sets MPL[1] to zero and clears partial products.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

---
Changes v2 -> v3:
  - Split VMM0 out of the combined Octeon arithmetic and memory
    instruction patch.  (requested by Richard Henderson)

Changes v3 -> v4:
  - Document the Octeon3 chain update behavior.

Changes v5 -> v6:
  - Zero MPL1 after checking the CN71XX VMM0 definition and add
    MPL1 smoke coverage.

Changes v7 -> v8:
  - Use Richard Henderson's v7.5 inline TCG translator, which keeps
    only the architecturally defined MPL1 and partial-product clearing.
---
 target/mips/tcg/octeon.decode      |  1 +
 target/mips/tcg/octeon_translate.c | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index 36ced0bb33..f9c32e1dee 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -56,6 +56,7 @@ MTP1         011100 ..... ..... 00000 00000 001010 @r2
 MTP2         011100 ..... ..... 00000 00000 001011 @r2
 
 VMULU        011100 ..... ..... ..... 00000 001111 @r3
+VMM0         011100 ..... ..... ..... 00000 010000 @r3
 
 &saa         base rt
 @saa         ...... base:5 rt:5 ................ &saa
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index 20ceab68f8..9e3dc24455 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -300,3 +300,21 @@ static bool trans_VMULU(DisasContext *ctx, arg_VMULU *a)
     gen_store_gpr(tmp, a->rd);
     return true;
 }
+
+static bool trans_VMM0(DisasContext *ctx, arg_VMM0 *a)
+{
+    TCGv_i64 tmp = tcg_temp_new_i64();
+
+    gen_load_gpr(tmp, a->rs);
+    tcg_gen_mul_i64(oct_mpl[0], oct_mpl[0], tmp);
+    gen_load_gpr(tmp, a->rt);
+    tcg_gen_add_i64(oct_mpl[0], oct_mpl[0], tmp);
+    tcg_gen_add_i64(oct_mpl[0], oct_mpl[0], oct_p[0]);
+    gen_store_gpr(oct_mpl[0], a->rd);
+
+    tcg_gen_movi_i64(oct_mpl[1], 0);
+    for (int i = 0; i < OCTEON_MULTIPLIER_REGS; i++) {
+        tcg_gen_movi_i64(oct_p[i], 0);
+    }
+    return true;
+}

-- 
2.54.0


