Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA7F5CD343F
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 05:30:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOqYM-0006yn-S2; Mon, 18 May 2026 01:30:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wOqXo-0006s5-Op
 for qemu-devel@nongnu.org; Mon, 18 May 2026 01:29:39 -0400
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wOqXf-0003R8-VW
 for qemu-devel@nongnu.org; Mon, 18 May 2026 01:29:32 -0400
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-479d9b155deso467450b6e.3
 for <qemu-devel@nongnu.org>; Sun, 17 May 2026 22:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779082165; x=1779686965; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=a0YJCz/+Op9OtTioAKAD1sf9gr9b0ChAoB2bIjmnyqQ=;
 b=opSy8uZKzjznltWXqRmijR+b/59CSWi1swnluYzyB1PKuOvhlAnT4cfjy3DWXY7Jbv
 UmDH7+d5YfmnvG9cyj3spDWzs+VG5Jig6vAJUXZQpqk3y0hz+tYi5tIVDqSR5Mq2U7QJ
 OOdrG665f2B4e+PUBiQDQovZTSchdJDV8uCcVEjKEOpFQYfa9ICtlNsUayvpwdm0F1z1
 R4F+inFWeG4YRnVKI9iDDKqYTEqiV6DU43QqoIfw9VJ0UvAsy/pRCeGpcVqPW26/+jAE
 CTzsfIYqiROzqjQ1VfWem3lKtTQvN7ao+Av0z+mlFiSKCfrZtUWYaiL+fzcqi0Kcrsv+
 l/eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779082165; x=1779686965;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=a0YJCz/+Op9OtTioAKAD1sf9gr9b0ChAoB2bIjmnyqQ=;
 b=kzKt54bZNZkqwvnErookQDHqv12MaDPq3qbkBuzBaJx9bscHT2Gzpd+Zy4YB9hPeJc
 6MCS8A/igPY1gCFH5GvE63mZdsFkyUFj6NsAAoFiPU6FDBRApImISP3rnLErTbdOCI7G
 8UKtzrzmrYdiCeCRHNtcfLtZkxAHJjtq198QJE/5TWGCarONqUBIurgK7r0hdmfzP3P+
 JRNwu30qencr0eqTpIO1Cg2kBoSo3XsQuDOr7mbnwru7wHLMiR0gSuwP4Kl69An0PDs6
 WIMVSyUoeNp0sb3z2I9Mq/Icm2Bvl64vtLWMxEvHNjIjndHNowji5/VVn14mX2H7C7zD
 rkAg==
X-Gm-Message-State: AOJu0YyDV6k8eevhUfcv6W4LdcFqGOQ8M1VpLei6RNWCBgyu6D0ttUxJ
 MSGWHcwWspXMfOzw7rLDQRDHzcRGKb8/+X9jDEGskY2ljIlHeEK5fwKq
X-Gm-Gg: Acq92OG0ICk0fXnfDWEqR3Uq5D5hwnaXNO4U7r24Lfw6wSQqH9R63Jl3v9coWXs3U7I
 Mqeq/PvuTD5q/VEWS02ny1ZsTjWOA/YTOJP49CJbJF4w6eHw12OHu+vvoeky1/qdTivP6e0uHXp
 mqU2qbRKtHjmz6Lrh/drdRR50J6UlEVA1xjotdDOD/60egpGvTQTlXdFquZKzhjas06t0bDcEV8
 2c7tOBKNt7yGk5ExLmPGbSWB2+TRdaqsdS7ZzjZ8OkF2ztputTAbTc5Gnb3zXe6sPe4OE+vUVrK
 O1kbTDK046KMTYYNxsO+IcYazkBSeBkdd9I56/Mxe64TnABMlZyXcGR9nOvEtInfejml49xdAIH
 L/7CVP2CHv6CKWbtsrQ9lHhUktrKOEMYFol9K3XqStREHfOlYdoDgkBB9w/DgBXnjKI+ocR2A+j
 ufoycHqbVHQhKpLkseUNMmmqn9TNDbOeeLDU/xt5fz9+XeF6/oMxQtpYbgzDs/NRswVerzeVLJ+
 pNXNKFWChM/CIKou8VIqJntKrvH0J3xWSkXRJKtxIHvADplnClvOAHopimScdb9PKZzsUtf8IUc
 xRpD3g==
X-Received: by 2002:a05:6808:50a6:b0:479:fe0e:e83e with SMTP id
 5614622812f47-482e560891emr9482780b6e.14.1779082165062; 
 Sun, 17 May 2026 22:29:25 -0700 (PDT)
Received: from mac.localdomain (71-218-255-245.hlrn.qwest.net.
 [71.218.255.245]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-482ee5349a5sm4628357b6e.15.2026.05.17.22.29.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 May 2026 22:29:24 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 17 May 2026 23:29:01 -0600
Subject: [PATCH v8 04/35] target/mips: fix Octeon arithmetic destination
 handling
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260517-mips-octeon-missing-insns-v2-v8-4-206151ee77ec@gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::22e;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oi1-x22e.google.com
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

BADDU and DMUL write their results to rd, not rt.  Route writes through
gen_store_gpr() so rd == $zero is handled consistently.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v1 -> v2:
  - Split the BADDU/DMUL destination handling fix out of the Octeon
    arithmetic instruction patch.  (suggested by Philippe Mathieu-Daudé)

Changes v2 -> v3:
  - Remove the rd == $zero fast paths and let gen_store_gpr() discard
    writes to $zero.  (suggested by Richard Henderson)
---
 target/mips/tcg/octeon_translate.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index e1f52d444a..4dd7626835 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -45,18 +45,14 @@ static bool trans_BADDU(DisasContext *ctx, arg_BADDU *a)
 {
     TCGv_i64 t0, t1;
 
-    if (a->rt == 0) {
-        /* nop */
-        return true;
-    }
-
     t0 = tcg_temp_new_i64();
     t1 = tcg_temp_new_i64();
     gen_load_gpr(t0, a->rs);
     gen_load_gpr(t1, a->rt);
 
     tcg_gen_add_i64(t0, t0, t1);
-    tcg_gen_andi_i64(cpu_gpr[a->rd], t0, 0xff);
+    tcg_gen_andi_i64(t0, t0, 0xff);
+    gen_store_gpr(t0, a->rd);
     return true;
 }
 
@@ -64,17 +60,13 @@ static bool trans_DMUL(DisasContext *ctx, arg_DMUL *a)
 {
     TCGv_i64 t0, t1;
 
-    if (a->rt == 0) {
-        /* nop */
-        return true;
-    }
-
     t0 = tcg_temp_new_i64();
     t1 = tcg_temp_new_i64();
     gen_load_gpr(t0, a->rs);
     gen_load_gpr(t1, a->rt);
 
-    tcg_gen_mul_i64(cpu_gpr[a->rd], t0, t1);
+    tcg_gen_mul_i64(t0, t0, t1);
+    gen_store_gpr(t0, a->rd);
     return true;
 }
 

-- 
2.54.0


