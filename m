Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1954BC531DF
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2024 02:27:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgb33-0000rT-Or; Tue, 20 Aug 2024 22:26:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sgb2z-0000ZC-5J
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 22:26:05 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sgb2x-0006Dd-8N
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 22:26:04 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-7141feed424so596650b3a.2
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2024 19:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724207161; x=1724811961; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/AkyOxiQ4TXnW/njwRxZXuZWiuFAeAcYAa7CbQEQtFY=;
 b=klDUVP8eBfq9v2JfJGtK3FMah2hyg1jKq8VX2grggjbkX4/b1xZpBaxkFDqaRbpxSO
 GVcQeZHy8yTg5Q5Vpe7OTqeqpbCcNXUX+hOa1Io1NnDhG4SMVVMzn+Vt6t6tShyeUhE1
 j7Tbw+ZDnDY9XSvbAs4RvC5SY7gQyuhWp41cMCx3UE+AZ7HZS+E7Jixbp7XMJgDrpQ7a
 VIDqWoHx7sKop35HWeBq3eBqpQAfecF02BmXHvZkDv+DNYBflllP/KXTHNJn43RJ/SZ2
 FOxYKhEh1dsPsAWb2Mc0GOMpp75LnP/FQW9bHftDLBVWRZKToS/MDEx8/f+zm21TQ3xG
 sPaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724207161; x=1724811961;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/AkyOxiQ4TXnW/njwRxZXuZWiuFAeAcYAa7CbQEQtFY=;
 b=iS3KOVkf7I/8qXi6N/1pYMVqBsZu99f+u2OYEi8O7LlHnILrYN+G/xx841KqD/C33m
 3dYDZP/IMebWPSgYOnSoXP4B760ujfVYEZvMFaWDiCd1cT8KV1xbLx7ulpr4mYOH3nna
 /TM8q1FBP7Hu94nKWwqj9z9XYf8IdCERNMxf8VgcP7Al8qSx+DG/Lojgzl/ByAnWCXfm
 ugUlsXZeTvwHzypEQqKj6t+hvlqrVWcKAW2b/wftMHGA5ZKBrX8/zeLwxfGMEmH5YW2A
 VsAEcAzl3VcgF4yOm+HaAGZyXIb8xFnHoLhxcRDErPDzAwwWu7CY358zxp/sXwx65Dn5
 xa+A==
X-Gm-Message-State: AOJu0YxyJPFLtKs8bu18sL1/AIF+tvXE9MiIhV7gehXXrMvp5wVdFph8
 LEVybabpDgjkOAfZlJxZQDH5pjXkVgBEB92TzxkyBRE5E5hqAyvHuf6zSVQJ/bOXjelAaEviBxO
 VYhY=
X-Google-Smtp-Source: AGHT+IEqPvyaMfUMiUScTKLqmqWoTARQPmnfxf+B0WuQgPe4ut/Ps2au5QJuCba8i8KtJktXSunx6A==
X-Received: by 2002:a05:6a00:10c4:b0:702:3e36:b7c4 with SMTP id
 d2e1a72fcca58-7142342f6c1mr1358111b3a.5.1724207161207; 
 Tue, 20 Aug 2024 19:26:01 -0700 (PDT)
Received: from stoup.. ([203.56.140.20]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7127af1888esm9210774b3a.149.2024.08.20.19.25.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Aug 2024 19:26:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 3/5] target/i386: Split out gen_prepare_val_nz
Date: Wed, 21 Aug 2024 12:25:46 +1000
Message-ID: <20240821022548.421745-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240821022548.421745-1-richard.henderson@linaro.org>
References: <20240821022548.421745-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Split out the TCG_COND_TSTEQ logic from gen_prepare_eflags_z,
and use it for CC_OP_BMILG* as well.  Prepare for requiring
both zero and non-zero senses.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240801075845.573075-2-richard.henderson@linaro.org>
---
 target/i386/tcg/translate.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index b72864bf01..4af282e626 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -865,6 +865,18 @@ static CCPrepare gen_prepare_sign_nz(TCGv src, MemOp size)
     }
 }
 
+static CCPrepare gen_prepare_val_nz(TCGv src, MemOp size, bool eqz)
+{
+    if (size == MO_TL) {
+        return (CCPrepare) { .cond = eqz ? TCG_COND_EQ : TCG_COND_NE,
+                             .reg = src };
+    } else {
+        return (CCPrepare) { .cond = eqz ? TCG_COND_TSTEQ : TCG_COND_TSTNE,
+                             .imm = MAKE_64BIT_MASK(0, 8 << size),
+                             .reg = src };
+    }
+}
+
 /* compute eflags.C, trying to store it in reg if not NULL */
 static CCPrepare gen_prepare_eflags_c(DisasContext *s, TCGv reg)
 {
@@ -908,8 +920,7 @@ static CCPrepare gen_prepare_eflags_c(DisasContext *s, TCGv reg)
 
     case CC_OP_BMILGB ... CC_OP_BMILGQ:
         size = s->cc_op - CC_OP_BMILGB;
-        gen_ext_tl(cpu_cc_src, cpu_cc_src, size, false);
-        return (CCPrepare) { .cond = TCG_COND_EQ, .reg = cpu_cc_src };
+        return gen_prepare_val_nz(cpu_cc_src, size, true);
 
     case CC_OP_ADCX:
     case CC_OP_ADCOX:
@@ -1006,12 +1017,7 @@ static CCPrepare gen_prepare_eflags_z(DisasContext *s, TCGv reg)
     default:
         {
             MemOp size = (s->cc_op - CC_OP_ADDB) & 3;
-            if (size == MO_TL) {
-                return (CCPrepare) { .cond = TCG_COND_EQ, .reg = cpu_cc_dst };
-            } else {
-                return (CCPrepare) { .cond = TCG_COND_TSTEQ, .reg = cpu_cc_dst,
-                                     .imm = (1ull << (8 << size)) - 1 };
-            }
+            return gen_prepare_val_nz(cpu_cc_dst, size, true);
         }
     }
 }
-- 
2.43.0


