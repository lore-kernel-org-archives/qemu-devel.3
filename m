Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBB9CCD4F26
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2026 03:26:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wb8oS-0002eR-Eo; Sat, 20 Jun 2026 23:25:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <apolivodaa433@gmail.com>)
 id 1wb8oQ-0002eI-Uz
 for qemu-devel@nongnu.org; Sat, 20 Jun 2026 23:25:34 -0400
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <apolivodaa433@gmail.com>)
 id 1wb8oP-0006QO-3p
 for qemu-devel@nongnu.org; Sat, 20 Jun 2026 23:25:34 -0400
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-396775c26e0so31339751fa.2
 for <qemu-devel@nongnu.org>; Sat, 20 Jun 2026 20:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782012331; x=1782617131; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=SSGRwV7Qm1wdTBg0K2WsmwKZJNmRMrJAI8KnlYeSuEM=;
 b=senwjmCc9RRxTxZXOttv2zJr8WHNF4TQc1Cm2NttqTCtrYd3aWsxPxa6ZqjtCZtt3Y
 RiWYGc0VofgLknS+guuBPOceVj6yxo0iYaa7KtWM1i2APqJvs9kUJ3u+K0eHfjWlzgeI
 hdQNqVoTyQE250cucO9zOtd95mffAyKh5mpjPU48a4VBC7XPfKStkt7jQi0f+XbybTmy
 /HIC5bfQo6nOehqX6TjgOvPwUUBE4a3Z/3V32nB0C6fUiRZvWvkzokhuMqmeQZZQu+4b
 Gk8S6K0kvzDgv2TuFt8BosNJOdUMO1pi/Ns7Aef0mmBRoOTCgwRTqESJYa9XOb7pryVL
 /RsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782012331; x=1782617131;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SSGRwV7Qm1wdTBg0K2WsmwKZJNmRMrJAI8KnlYeSuEM=;
 b=CfWLi2Rn7F/ifAz6UZPXE+g0gAg8VU6WWMgkBaP9ypktaFX5iBX83brMTJlAHDZd5/
 zrjLoJ9C0ArNB9ciMZQyH1NaZrmQaWsYczoNorBxn9l7BCF1SevkNsHNkhw0saEqKUEG
 i6lZLE0k67h2pDB06/wb8sesqGEiIb+Te5T+AV/31TRmssV+mWY4bcd+T3gl8rZN8yOJ
 Y32/TZNxeJQ5/DiGDTKmWx2pjXOzyNWkLDADMYbCS8HYtUmjgS9QXMNbIugZVa4l/7up
 1GR9nKN98j+UvPOpY/pJyxLb1ZcHsxFAPNbpEAR9TRU29d31HJ2FQfXwSjOvMqtMEcBc
 GJFQ==
X-Gm-Message-State: AOJu0YytbqVuXAhSjk8fFNfZO9UiiL6eyBSk/Xz7VvhTj/TqIHKjxjmD
 IX4x5ZYUdUzL8RkX/glRiZZz0K5R21fY+7+UgWQ/eluGcGPTR2rLD/KTVloJsKDjIws=
X-Gm-Gg: AfdE7cnC8YcTxGqG2oh+eAJECos5KKfBHaBLOc6U0ceR7kvuulIInyrdMKcgcSPZaBL
 V3xgtLr7/829tT3APs3l8CrmrMy9noG85tazm4HUtgA0cvL+TSryOgpVEP0z6tg03bHymMaYSev
 u6oL1ro+kl0DF7Zi95Mos3/Bg8iQ9UJgkzn7SwOP0jh/8dHi5l0GJIHdpoi8uHYhMTAlp4izh5Y
 OSk+YomdQl/+EvVR6Xc63223bdriQcvc8X0wN1vJxRlOwfNb/j/q+pijBHOEVzG8hA11bQFhqFV
 bL8UKpR4j2hxGyyrWuqhfZbi5UFTR0M93ZB+ytAJ322nnLf/YWt4yxuwlVsPXJ4svI+d/bjHKid
 lxfFzQ+QLPf+HsJHChroj2YNm8aPRenMuhT6nEsZFK0FOR/6coaKD9lB1CtzhcNZC3n8DButuiK
 9uReCmgg==
X-Received: by 2002:a05:651c:199f:b0:399:745a:ff72 with SMTP id
 38308e7fff4ca-3998e4094cbmr19329751fa.9.1782012330646; 
 Sat, 20 Jun 2026 20:25:30 -0700 (PDT)
Received: from kali ([82.162.57.219]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3999b1ad987sm8593971fa.38.2026.06.20.20.25.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jun 2026 20:25:28 -0700 (PDT)
From: Andrey Polivoda <apolivodaa433@gmail.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH] target/i386: decode opcode extensions group 3 /1 as TEST
Date: Sun, 21 Jun 2026 13:25:23 +1000
Message-ID: <20260621032524.1138213-1-apolivodaa433@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=apolivodaa433@gmail.com; helo=mail-lj1-x22b.google.com
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

According to Table A-6 in Volume 3 of AMD64 Architecture Programmer's Manual,
opcodes F6 and F7 (opcode extensions group 3) with ModRM's reg field values
of 0 and 1 can be used to encode a TEST instruction.

Although Intel 64 and IA-32 Architectures Software Developer's Manual leaves
the cell 1 of opcode extensions group 3 blank in the opcode table 
(Table A-6, Volume 2D), the instruction in a group 3 with reg field of ModRM
byte set to 1 actually behaves like TEST instruction on Intel CPUs.

Currently, QEMU decodes group 3 instruction as TEST only if reg field of ModRM
byte is 0. When the reg field is 1, QEMU raises a #UD exception.
This behavior does not match real Intel and AMD hardware.

This patch fixes this issue by duplicating the existing [0x00] and [0x08]
X86_OP_ENTRYrr(AND, ...) entries into slots [0x01] and [0x09] in the
opcodes_grp3 table.

Fixes: d7c41a60d0c5 ("target/i386: move C0-FF opcodes to new decoder (except for x87)")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3580 
Signed-off-by: Andrey Polivoda <apolivodaa433@gmail.com>
Cc: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>
---
Note: checkpatch.pl reports style errors regarding spaces after commas.
These are false positives, as the patch intentionally matches the formatting
of the surrounding macro table.

 target/i386/tcg/decode-new.c.inc | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index ac181308ca..a0bc6d1901 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -1614,6 +1614,7 @@ static void decode_group3(DisasContext *s, CPUX86State *env, X86OpEntry *entry,
     static const X86OpEntry opcodes_grp3[16] = {
         /* 0xf6 */
         [0x00] = X86_OP_ENTRYrr(AND, E,b, I,b),
+        [0x01] = X86_OP_ENTRYrr(AND, E,b, I,b),
         [0x02] = X86_OP_ENTRY1(NOT,  E,b,      lock),
         [0x03] = X86_OP_ENTRY1(NEG,  E,b,      lock),
         [0x04] = X86_OP_ENTRYrr(MUL, E,b, 0,b, zextT0),
@@ -1623,6 +1624,7 @@ static void decode_group3(DisasContext *s, CPUX86State *env, X86OpEntry *entry,
 
         /* 0xf7 */
         [0x08] = X86_OP_ENTRYrr(AND, E,v, I,z),
+        [0x09] = X86_OP_ENTRYrr(AND, E,v, I,z),
         [0x0a] = X86_OP_ENTRY1(NOT,  E,v,      lock),
         [0x0b] = X86_OP_ENTRY1(NEG,  E,v,      lock),
         [0x0c] = X86_OP_ENTRYrr(MUL, E,v, 0,v, zextT0),
-- 
2.53.0


