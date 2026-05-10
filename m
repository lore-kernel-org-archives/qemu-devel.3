Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BFEACD37B2
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2026 20:42:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMAwj-00053M-73; Sun, 10 May 2026 16:40:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wMAwh-00052Y-Bu
 for qemu-devel@nongnu.org; Sun, 10 May 2026 16:40:15 -0400
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wMAwf-0003z2-TL
 for qemu-devel@nongnu.org; Sun, 10 May 2026 16:40:15 -0400
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-479d593a0c3so3146406b6e.0
 for <qemu-devel@nongnu.org>; Sun, 10 May 2026 13:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778445613; x=1779050413; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=eUDTt72Dgacal2ShP2KQiQMSCCuoWXPWWX+XyiwnHhY=;
 b=mZGoDFAlvTNv9BMPjZnYFOOZCx6rKA46aq5thBdzSy6S/9pxLrSZpNIZEzEJEg+hpU
 cWQ38Q03TrUu/ByPiyUczcg4AFryXOq8s70WePv34uUEQE0GmzPNvuoxezc0Wd5DyxTS
 WhFOT5OLxMNGznIIL73N9F+5BUGAMZOma/YGcW2SJ9lAYqlHqg8UXAQ0Dh8OXhO9+Ohw
 sqYbcxkmPPfgcFgR+Xh7gXZhnN7GJgmEuAtdYRhny32x1kJ4Zh8lEmmTHLUQEchgLnU4
 r7yzRXeBskrCi3V1eMPwM/MywuufaIJL9UxT5Svi6q2NsssF1hM7nZOCH7stACeuYA9N
 Qyng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778445613; x=1779050413;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=eUDTt72Dgacal2ShP2KQiQMSCCuoWXPWWX+XyiwnHhY=;
 b=iGIA15V0q8z7a16ZO/mYueqvceLpBqhx7X8a9yn88Gsv+8tkTxTM0pC226claDpeRD
 Hv0iRgkn8BYg9vhbCw7RZH0SMF91I7kuQBxpe9B+zHSd733VcCgj0DzlEB6SJqDOp/IV
 1yMrTXLe+gg4Ju498ukNWfGqolnN+TobjhWu5QhUzJGF/kzWAaiE+xK1vLAvN+bJbHe6
 95Cccta9XcL5sSST9Hu9mBxEyHsEGJf4nBuueqDBVsnlf8xJfAGT5c9oZj54AkSZ1qJw
 Buo6UdAokEdi6GoD6oHgepDEcoRks/1J0YGJZ/bwKtxNClXNSyTzQ7SyleRw9Xx4ePnz
 iwAg==
X-Gm-Message-State: AOJu0YzRPiOryeZa8T9pNXKGBLMe4gGAcdqi4ft7MQWtBVpnK+1rEVWg
 LPHmxFOva++flme8rUMLwvHoeO5AI011HXZ5qgDvimEtYi2tnpLpdFoC
X-Gm-Gg: Acq92OGTS390Hs0e0PBjPWZAx81eh6t3YeNgfUj2XS0UcboYt4/4tWIanG+DBljWSje
 lzIXvEsnFoMZUh4jh38IxlQWASu3AjhxwRWL19PNA0PPR10djEa/JW2HEw4Iz+S9o1QpAUvkACC
 coRmqHu26nG3n0DrVb/wK67lAszc2yAUDO064I00YafyIlu7DHu2i6EjbS5Nk2Yh0sYFRLkHmNe
 MQVjWSBtMYbP/2Hzzdc8efsI/iYZZHs1DkpIA93DvLI1mW2t1RPfUPZCOQXxnQDS2JjL9s5XViQ
 i4QijOrV6MSsd7sNDq5e1J/Jho3wpRr+US3RUK9GEp+BXtVnUv0D/fPA1k4rLjCmegSGjjJuEwD
 BiO1/wqjubgsrtOx2FweBJPIIRKfKsRzEiydi1PQQfCpSHNbdA5gQZ0yYwnU3XWOPaGJoJCNCeo
 AJMB/QQ1t2MP7REQUsvGP/VFjXv7wQlngh+5OmHsF7HGFwNGuAkKlgjgk1Slf/T335u753IA1IB
 FifEh0WRQ8AvjuXD1xDOUc8jbO0rV3sMEWG450bKYM=
X-Received: by 2002:a05:6808:3023:b0:479:eead:df9 with SMTP id
 5614622812f47-48061aa54d2mr8239236b6e.4.1778445612863; 
 Sun, 10 May 2026 13:40:12 -0700 (PDT)
Received: from MacBook-Pro.local ([209.245.15.183])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-47c76935637sm18908207b6e.12.2026.05.10.13.40.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 May 2026 13:40:12 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 10 May 2026 14:39:40 -0600
Subject: [PATCH v5 10/32] target/mips: add Octeon LWUX instruction
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260510-mips-octeon-missing-insns-v2-v5-10-d5d2668d15ab@gmail.com>
References: <20260510-mips-octeon-missing-insns-v2-v5-0-d5d2668d15ab@gmail.com>
In-Reply-To: <20260510-mips-octeon-missing-insns-v2-v5-0-d5d2668d15ab@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Richard Henderson <richard.henderson@linaro.org>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::22b;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oi1-x22b.google.com
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

LWUX performs an indexed unsigned word load from base + index and
zero-extends the result into rd.

Add the decode entry and route it through the common indexed-load
translator with MO_UL.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v2 -> v3:
  - Split LWUX out of the combined Octeon arithmetic and memory
    instruction patch.  (requested by Richard Henderson)
---
 target/mips/tcg/octeon.decode      | 1 +
 target/mips/tcg/octeon_translate.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index 8a755075e8..db7d5f55f0 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -50,5 +50,6 @@ LWX          011111 ..... ..... ..... 00000 001010 @lx
 LHX          011111 ..... ..... ..... 00100 001010 @lx
 LHUX         011111 ..... ..... ..... 10100 001010 @lx
 LBUX         011111 ..... ..... ..... 00110 001010 @lx
+LWUX         011111 ..... ..... ..... 10000 001010 @lx
 LBX          011111 ..... ..... ..... 10110 001010 @lx
 LDX          011111 ..... ..... ..... 01000 001010 @lx
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index 5a189c6484..c93eff59a5 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -166,4 +166,5 @@ TRANS(LBUX, trans_lx, MO_UB);
 TRANS(LHX,  trans_lx, MO_SW);
 TRANS(LHUX, trans_lx, MO_UW);
 TRANS(LWX,  trans_lx, MO_SL);
+TRANS(LWUX, trans_lx, MO_UL);
 TRANS(LDX,  trans_lx, MO_UQ);

-- 
2.54.0


