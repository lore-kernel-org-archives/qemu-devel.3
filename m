Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9037AC4828F
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Feb 2024 21:46:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWkFG-0002Vq-Hr; Sun, 04 Feb 2024 16:41:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rWkFE-0002Ps-SD
 for qemu-devel@nongnu.org; Sun, 04 Feb 2024 16:41:44 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rWkEz-0003XF-96
 for qemu-devel@nongnu.org; Sun, 04 Feb 2024 16:41:44 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1d93edfa76dso32447215ad.1
 for <qemu-devel@nongnu.org>; Sun, 04 Feb 2024 13:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707082888; x=1707687688; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WG70x2tVTekUt4Dpwv8+YTTzoZtnr5bDrng9DlCBKcQ=;
 b=HmxRKm1/fBW8bpS5NIshhkyMLGl0haMMI+Fv9yWwT7v6HEwYqpVwZ3E4cgBlsIfdzy
 O76TvrzNGAV+Gw1DmZ6owtWlWiD8ktp2RyDtycNLYvv08FAtorhWcoGuQCR1gl1w07xR
 hnUjAO9t3R7bghtB08RmLf3+s/2k8vimhtjGEM9lWi9LzA39kN6aKR6MF/ZZ2LurIXYL
 ayOa04aZvnDPC3jFPTPydCT7RDMPBTg4QllsxE9aqHp1XCXU/y0/y06oZFbrzDkc/+QZ
 mRkZ92FcFgVZ/4OvIUdwX3HJfSbxZrOkuD07WBgvvSQ0WAnWcO3Lr2s5BcVKt6pm3duY
 DdsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707082888; x=1707687688;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WG70x2tVTekUt4Dpwv8+YTTzoZtnr5bDrng9DlCBKcQ=;
 b=Qi/jcXj+WvTfSOiX3PWBgr9lnhKm4crYHcwV4Km5vKXsssIT6ArH50PcsUHnbUzxAz
 rQ5UFmKNGkctIawr4nmD5pIUy8uvNMCJlKPCy4CEu6HGJisO23Vh8ndLFLG41AIoTNVN
 oraYzAudkb5/drT3tltJiVbx+JgtotS/eKvsHS5Cp+VpHRK0Jj8dCHRiTSKXvKu72FGY
 l7CwwYRLaXm/B1nyfSOmZopr2Lvf5NobJDyLdY/9vHL3dyLYOmLuhWJWYMP14LfPuvwB
 JrH5z7UyIn2u/FhHvT8RszYSCCkIHFVkChJ6yexjoA0mowqMG3bI0fVtD8dk0Q+aynHC
 4JPQ==
X-Gm-Message-State: AOJu0YxFmAUfuQGC3ZP1ocgc7c4EsJP4maWVRQn24k1+2NGUQaPuagUC
 nXFtGuhDnQr6u5wpxwD3z/ibuzIzwyreCarDrGx4OJbe+o7lxi4B2exSwEAqXZBhxuZ84XmlzPk
 8g2w=
X-Google-Smtp-Source: AGHT+IF4oP/jLacOp4EtjiAdFpuBZ7yvOgl/wcPM1eX+paeHkRJNH6D09yBtqhv8c05mGa01whrvdw==
X-Received: by 2002:a17:902:a981:b0:1d7:310e:1e0d with SMTP id
 bh1-20020a170902a98100b001d7310e1e0dmr11863765plb.32.1707082888055; 
 Sun, 04 Feb 2024 13:41:28 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCXlcAwujfbiLMTD9rBjzWNCgUIUfXBf82trUPaOWVu4OHMEh6jvKdiFMIGZL6mz0b68XsPDFVaYXvFtfVueo5Tucw==
Received: from stoup.. ([43.252.112.156]) by smtp.gmail.com with ESMTPSA id
 mf11-20020a170902fc8b00b001d8f5560503sm4953670plb.222.2024.02.04.13.41.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Feb 2024 13:41:27 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 15/39] target/s390x: Improve general case of disas_jcc
Date: Mon,  5 Feb 2024 07:40:28 +1000
Message-Id: <20240204214052.5639-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240204214052.5639-1-richard.henderson@linaro.org>
References: <20240204214052.5639-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Avoid code duplication by handling 7 of the 14 cases
by inverting the test for the other 7 cases.

Use TCG_COND_TSTNE for cc in {1,3}.
Use (cc - 1) <= 1 for cc in {1,2}.

Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/tcg/translate.c | 82 +++++++++++++-----------------------
 1 file changed, 30 insertions(+), 52 deletions(-)

diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index 05fd29589c..3d6a9f44a6 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -885,67 +885,45 @@ static void disas_jcc(DisasContext *s, DisasCompare *c, uint32_t mask)
     case CC_OP_STATIC:
         c->is_64 = false;
         c->u.s32.a = cc_op;
-        switch (mask) {
-        case 0x8 | 0x4 | 0x2: /* cc != 3 */
-            cond = TCG_COND_NE;
+
+        /* Fold half of the cases using bit 3 to invert. */
+        switch (mask & 8 ? mask ^ 0xf : mask) {
+        case 0x1: /* cc == 3 */
+            cond = TCG_COND_EQ;
             c->u.s32.b = tcg_constant_i32(3);
             break;
-        case 0x8 | 0x4 | 0x1: /* cc != 2 */
-            cond = TCG_COND_NE;
-            c->u.s32.b = tcg_constant_i32(2);
-            break;
-        case 0x8 | 0x2 | 0x1: /* cc != 1 */
-            cond = TCG_COND_NE;
-            c->u.s32.b = tcg_constant_i32(1);
-            break;
-        case 0x8 | 0x2: /* cc == 0 || cc == 2 => (cc & 1) == 0 */
-            cond = TCG_COND_EQ;
-            c->u.s32.a = tcg_temp_new_i32();
-            c->u.s32.b = tcg_constant_i32(0);
-            tcg_gen_andi_i32(c->u.s32.a, cc_op, 1);
-            break;
-        case 0x8 | 0x4: /* cc < 2 */
-            cond = TCG_COND_LTU;
-            c->u.s32.b = tcg_constant_i32(2);
-            break;
-        case 0x8: /* cc == 0 */
-            cond = TCG_COND_EQ;
-            c->u.s32.b = tcg_constant_i32(0);
-            break;
-        case 0x4 | 0x2 | 0x1: /* cc != 0 */
-            cond = TCG_COND_NE;
-            c->u.s32.b = tcg_constant_i32(0);
-            break;
-        case 0x4 | 0x1: /* cc == 1 || cc == 3 => (cc & 1) != 0 */
-            cond = TCG_COND_NE;
-            c->u.s32.a = tcg_temp_new_i32();
-            c->u.s32.b = tcg_constant_i32(0);
-            tcg_gen_andi_i32(c->u.s32.a, cc_op, 1);
-            break;
-        case 0x4: /* cc == 1 */
-            cond = TCG_COND_EQ;
-            c->u.s32.b = tcg_constant_i32(1);
-            break;
-        case 0x2 | 0x1: /* cc > 1 */
-            cond = TCG_COND_GTU;
-            c->u.s32.b = tcg_constant_i32(1);
-            break;
         case 0x2: /* cc == 2 */
             cond = TCG_COND_EQ;
             c->u.s32.b = tcg_constant_i32(2);
             break;
-        case 0x1: /* cc == 3 */
+        case 0x4: /* cc == 1 */
             cond = TCG_COND_EQ;
-            c->u.s32.b = tcg_constant_i32(3);
+            c->u.s32.b = tcg_constant_i32(1);
+            break;
+        case 0x2 | 0x1: /* cc == 2 || cc == 3 => cc > 1 */
+            cond = TCG_COND_GTU;
+            c->u.s32.b = tcg_constant_i32(1);
+            break;
+        case 0x4 | 0x1: /* cc == 1 || cc == 3 => (cc & 1) != 0 */
+            cond = TCG_COND_TSTNE;
+            c->u.s32.b = tcg_constant_i32(1);
+            break;
+        case 0x4 | 0x2: /* cc == 1 || cc == 2 => (cc - 1) <= 1 */
+            cond = TCG_COND_LEU;
+            c->u.s32.a = tcg_temp_new_i32();
+            c->u.s32.b = tcg_constant_i32(1);
+            tcg_gen_addi_i32(c->u.s32.a, cc_op, -1);
+            break;
+        case 0x4 | 0x2 | 0x1: /* cc != 0 */
+            cond = TCG_COND_NE;
+            c->u.s32.b = tcg_constant_i32(0);
             break;
         default:
-            /* CC is masked by something else: (8 >> cc) & mask.  */
-            cond = TCG_COND_NE;
-            c->u.s32.a = tcg_temp_new_i32();
-            c->u.s32.b = tcg_constant_i32(0);
-            tcg_gen_shr_i32(c->u.s32.a, tcg_constant_i32(8), cc_op);
-            tcg_gen_andi_i32(c->u.s32.a, c->u.s32.a, mask);
-            break;
+            /* case 0: never, handled above. */
+            g_assert_not_reached();
+        }
+        if (mask & 8) {
+            cond = tcg_invert_cond(cond);
         }
         break;
 
-- 
2.34.1


