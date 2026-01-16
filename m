Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B99ED4A5F7
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 03:36:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgacH-0001Ko-IR; Thu, 15 Jan 2026 22:35:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vgacF-0001E0-6v
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 22:35:15 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vgacD-0006Cf-Hk
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 22:35:14 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-81f4e136481so759607b3a.3
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 19:35:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768534512; x=1769139312; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E3quorIoavgbRlUqCdA1N/hSlFNVi1G5ba+Ci7qX808=;
 b=pfyU9a21JgUnqLfct2YKiqnaK/0y23xZSXgQMM6jrPW2rMA7QjPqLwvhzfAlITqYRh
 nOnn33BWLhQzLji3oTkVZIMtzTWErbJaDy7XJSaplR3qpI0QUQxlg8wfaFKPPBJcv1+x
 wObn9wmAqlTyC2TW+CloilYdr1Pxw+jcPUgOvFEj14TaZ6dhMSo+lf0hCCrrrAj02QL8
 lQr9FX70DmmlbSqEY0UDYqJbJ0FHyYyacE3euG7zVWvshXQWbxhQs7Te9wOL1eQ4+Tvq
 bLZR8rZvhkXhany/CkcRCRmOtwlcTNbgOC4aFFnIVe481+IgUL7ZW2Q2Qh0WH33Gfm6e
 Jdsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768534512; x=1769139312;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=E3quorIoavgbRlUqCdA1N/hSlFNVi1G5ba+Ci7qX808=;
 b=xLRbT5H6+ramZbmL+YdB5KjytyBvVjNlbbDWYmMSz9GmvM/HMYIrHshPtjPEcq3ByJ
 6Mr1MFQijwxKgbhvrN4APLyyZ7ntlaGcCbrE8llOV0EeFa6sygh7t9+0QjCRJF6TYJWz
 2UB/uqLOP1pmwzmIz13hkHvnrhyj6A2M0gSDLjkb8zw44epnP5R5QG62e/n/C3vHOFSu
 b3bxVYAu3eLRjrqolu5ri0jsTcZtbMqE3WWDnsRh42IZFnmL8gT31OXmiFCQnu7uOBcE
 GL/wdA0QX6FWKA0Q3aYGhyFOXk+uWmnU+g8M3UwrXhXaBxSw8ByjT7YZK7ouavYQCvlF
 HCvQ==
X-Gm-Message-State: AOJu0Yy/9qmNn5YXkbUo/07iLp1ceXsMKmqVH0rJunaJh4Id4VMVt56w
 XoV+B91LpmNv7R33GnV99dv6/Se2MsiLdDo2pEJz/z1Dkv9L59KOwOrNoyC5NGjYxvGPm9dDwPj
 NU9b/ggnC7Q==
X-Gm-Gg: AY/fxX6b9Lz16oa+bqhJ7bUq0yyKJPBLz2sxdCO3BDF9XLXuwvWP1cgMuksA9eqqPle
 TMLyjpC7SJYPJyQnOgxcripHg4TlP+zIdNzKKm5/WU6Vtlpm1h/dn3gOcp5pTGrrQuhBPfsoiol
 FXLxjMgGl3DBuDq1lcBq6FQid4WTkK7WR6ZDp9nUlCAvidP9gTA4EEMSgoWfjge2at4lbrZXliC
 br6WXguS5sS5o8lZBZMxpwi3Hnb/SgGLfm/tUmYfIbmpuQDyxOtQkm6yWdSTMgsEgrpsr29fweK
 ln/f5vkF02LP6pWVQ+L41L/gwU1ZoEwm3oAsRQXXxzaJN12EgZ8VscJnDvZilQyZtrH5gFzpEfs
 z1WLlIqJpgBHnSJ4pi3+I1F59YJVUzNmxPp3GuzIeppy1T68ouCtqcvwSKChqJorUypzYusrbCP
 +oOxJ7EjS/oV1b6KlqTw==
X-Received: by 2002:a05:6a00:3e0e:b0:81f:40e5:34c1 with SMTP id
 d2e1a72fcca58-81fa18820f8mr1177177b3a.64.1768534512078; 
 Thu, 15 Jan 2026 19:35:12 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-81fa12b5c67sm683372b3a.69.2026.01.15.19.35.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 19:35:11 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: ktokunaga.mail@gmail.com, berrange@redhat.com, pierrick.bouvier@linaro.org,
 thuth@redhat.com, pbonzini@redhat.com, philmd@linaro.org
Subject: [PATCH v2 30/58] tcg/tci: Remove glue TCG_TARGET_REG_BITS renames
Date: Fri, 16 Jan 2026 14:32:36 +1100
Message-ID: <20260116033305.51162-31-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260116033305.51162-1-richard.henderson@linaro.org>
References: <20260116033305.51162-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tci.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/tcg/tci.c b/tcg/tci.c
index f71993c287..29ecb39929 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -26,11 +26,6 @@
 #include <ffi.h>
 
 
-#define ctpop_tr    glue(ctpop, TCG_TARGET_REG_BITS)
-#define deposit_tr  glue(deposit, TCG_TARGET_REG_BITS)
-#define extract_tr  glue(extract, TCG_TARGET_REG_BITS)
-#define sextract_tr glue(sextract, TCG_TARGET_REG_BITS)
-
 /*
  * Enable TCI assertions only when debugging TCG (and without NDEBUG defined).
  * Without assertions, the interpreter runs much faster.
@@ -525,7 +520,7 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             break;
         case INDEX_op_ctpop:
             tci_args_rr(insn, &r0, &r1);
-            regs[r0] = ctpop_tr(regs[r1]);
+            regs[r0] = ctpop64(regs[r1]);
             break;
         case INDEX_op_addco:
             tci_args_rrr(insn, &r0, &r1, &r2);
@@ -639,15 +634,15 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             break;
         case INDEX_op_deposit:
             tci_args_rrrbb(insn, &r0, &r1, &r2, &pos, &len);
-            regs[r0] = deposit_tr(regs[r1], pos, len, regs[r2]);
+            regs[r0] = deposit64(regs[r1], pos, len, regs[r2]);
             break;
         case INDEX_op_extract:
             tci_args_rrbb(insn, &r0, &r1, &pos, &len);
-            regs[r0] = extract_tr(regs[r1], pos, len);
+            regs[r0] = extract64(regs[r1], pos, len);
             break;
         case INDEX_op_sextract:
             tci_args_rrbb(insn, &r0, &r1, &pos, &len);
-            regs[r0] = sextract_tr(regs[r1], pos, len);
+            regs[r0] = sextract64(regs[r1], pos, len);
             break;
         case INDEX_op_brcond:
             tci_args_rl(insn, tb_ptr, &r0, &ptr);
-- 
2.43.0


