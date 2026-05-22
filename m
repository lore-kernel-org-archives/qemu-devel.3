Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 732A9CD5BB0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 19:39:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQVgP-0001lF-G1; Fri, 22 May 2026 15:37:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wQVgJ-0001jN-De
 for qemu-devel@nongnu.org; Fri, 22 May 2026 15:37:16 -0400
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wQVgE-0000ZB-Hj
 for qemu-devel@nongnu.org; Fri, 22 May 2026 15:37:13 -0400
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-479ef2b7979so6243812b6e.3
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 12:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779478629; x=1780083429; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BpjNFRkJXDxeJXgFf+peeS1OMxQxnbmGHgcjDSZVnxY=;
 b=KOiswolI7yQlR/mhoFsAj9cNpZM2fqbM8m1+Sa3EZPbWnU4LCeQW4cauihTLsCxmqN
 aeW5Zh7F5FoHHn7nQieWF/jsBpqngMT8BGBkD+2ugQuzSs1d4FEBhgUk2ntWLk8IG5SW
 Ae/DZq6kpVpXtsElLCSDzUc+x5+KUL/QUiM/hVVBOUUyi9Hmi0huAwWipzzulK+/b/Hv
 swP8PhHzQN1DCJimExerSz4fjw+POMhuoDocATGd5g5xbcZoy7fwyQP38cr4aty8Y+G6
 rzxQkFjS94L7rwU1cFDfxFdW6oXSaXn3UhMtFneq0k6WtMvs4UzKioc/oD3EgYtoEcLh
 GUeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779478629; x=1780083429;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=BpjNFRkJXDxeJXgFf+peeS1OMxQxnbmGHgcjDSZVnxY=;
 b=BiBdRgSdzg0aixAlyCS9JMS8tvQx/NENrbU5JWQV9TQLms68TsmySqBj+7x1ndGKQf
 RSCVB9/H7cARwBPDRtb8A4pL7+pu/5OAj7pwuf3L/3oUcqsnGRh6nYhRKaRmZf2Cw08/
 mLs0IRjd1ZD4KrBIEHirYYspFTVUNR8y0Kztm+yU6r3lC+zmUg9PNRQb4SQvMi/KbeeT
 kxMA6ScRzZsvvSw10DBaRJqEzHLkRoW4fEEx1C85H1UMfYO81UsxXMXZT71HcfGcTPA+
 tk3uKAbT76x6CIynFnZTIyq81Mm5NX5gkfZGRu8/1+nEjrqLhOyrjzhd5zXF+7jeHvCW
 XOpw==
X-Gm-Message-State: AOJu0YwmtODvAFro3RZKgWDAGkoydkk4EkQiniLJXb4M66BVynQv7EcS
 ktwglv6N/YbeM4J8S3tgMBoM2EYxgzjfOOkUiowcXmX1lDsGCOzNaFaF
X-Gm-Gg: Acq92OGQ4DxlEUA9JnBIY+Yn5dZT/K7IteNmkbHbHgGZJGNGxYLPrgCbFegnAXZFkzW
 UUTCwce7Jak3J0PFO5BK6HcSKZWIbdoQU+YlZaEzxRf+/j5+1URQI9EzxqJxrsS61SK1qEgkiGr
 sC0k+qFqgToZKEslPIOFvstfak7U8vEFQSjVZk4h1aBAU4wlqK/jCCMRZU6r3cIXgos4IAO1Mor
 jcX+/lZcxVtobxbQJ6eUDB9zVesj1I7nPMVMb1LNJxGPnAAJiaUhhca/lS3KY5o+0H03G404spU
 4JlI9s8TUK3PkTw1BjRSrlOukXimBh/WZvkApDd9h0CFo7EM1XTqHCbJnFWSfL8jYdM4PbuvhGL
 ttpFEOdH0hIMxkMilTfpim3Ki5HOwf3hJL9CnlyRCumLQoid+MDl7c8ETcwNxuH/n9FYeHszfoO
 SjHmKQEFD8nt4MC6ZFOAmMNsczaNeh8REgdSBAgBeeLa+ZmsDL5+RL/lalHQ/TEe9uDhbrdU9+A
 jyR3QVAXRpSDsEvR2/wWprDsZCqiv2REhUsn47fz3FqSXEes04TbkWQ2CRjJ/n1eoPj
X-Received: by 2002:a05:6808:f8f:b0:482:6815:9d7 with SMTP id
 5614622812f47-4854a4fe485mr2798085b6e.44.1779478629131; 
 Fri, 22 May 2026 12:37:09 -0700 (PDT)
Received: from mac.localdomain (184-96-131-78.hlrn.qwest.net. [184.96.131.78])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-48554757d5dsm995297b6e.15.2026.05.22.12.37.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 12:37:08 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 22 May 2026 13:36:48 -0600
Subject: [PATCH v15 17/22] target/mips: decode Octeon HSH and SHA3 COP2
 selectors
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260522-mips-octeon-missing-insns-v2-v15-17-f8731a588dc2@gmail.com>
References: <20260522-mips-octeon-missing-insns-v2-v15-0-f8731a588dc2@gmail.com>
In-Reply-To: <20260522-mips-octeon-missing-insns-v2-v15-0-f8731a588dc2@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::236;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oi1-x236.google.com
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

Add explicit decodetree entries and translator bindings for the Octeon
HSH shared-window selectors and SHA3 operation selectors. Simple SHA3 DAT
register moves and XORDAT selectors use direct TCG transfers, while HSH
operation selectors and SHA3 STARTOP remain helper-backed for their
visible side effects.

Keep HSH/SHA3 decode separate from direct register transfers because the
shared hash-window aliases and side-effecting operations need their own
selector coverage.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
Changes v14 -> v15:
  - Use direct TCG moves for SHA3 DAT24 and DAT15 selectors.
  - Use direct TCG XORs for SHA3 XORDAT selectors.
  - Switch SHA3 STARTOP to an env-only helper call.
  - Add Richard Henderson's Reviewed-by tag.

Changes v10 -> v13:
  - Keep this patch limited to HSH/SHA3 selector additions; CRC/GFM
    selector finalization stays in the CRC/GFM selector patch.
  - Name the 0x0057 SDK compatibility selector as STARTSHA1_COMPAT and
    document why it is kept despite not appearing in the public manuals.

Changes v9 -> v10:
  - Split HSH/SHA3 selector decode out of the monolithic Octeon COP2
    selector decode patch.
  - Reworked the shared HSH/SHA3 register-window transfers around the
    architectural hash state instead of DATW/IVW shadow state.
---
 target/mips/tcg/octeon.decode      |  77 ++++++++++++++++++++++++++++
 target/mips/tcg/octeon_translate.c | 102 +++++++++++++++++++++++++++++++++++++
 2 files changed, 179 insertions(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index 70e02d0b0e..b1a63b743f 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -113,6 +113,7 @@ LDX          011111 ..... ..... ..... 01000 001010 @lx
     CVM_MF_HSH_DAT4                      010010 00001 rt:5 0000 0000 0100 0100 &cp2
     CVM_MF_HSH_DAT5                      010010 00001 rt:5 0000 0000 0100 0101 &cp2
     CVM_MF_HSH_DAT6                      010010 00001 rt:5 0000 0000 0100 0110 &cp2
+    CVM_MF_SHA3_DAT24                    010010 00001 rt:5 0000 0000 0101 0000 &cp2
     CVM_MF_3DES_KEY0                     010010 00001 rt:5 0000 0000 1000 0000 &cp2
     CVM_MF_3DES_KEY1                     010010 00001 rt:5 0000 0000 1000 0001 &cp2
     CVM_MF_3DES_KEY2                     010010 00001 rt:5 0000 0000 1000 0010 &cp2
@@ -137,6 +138,30 @@ LDX          011111 ..... ..... ..... 01000 001010 @lx
     CVM_MF_GFM_MUL_REFLECT1              010010 00001 rt:5 0000 0000 0101 1001 &cp2
     CVM_MF_GFM_RESINP_REFLECT0           010010 00001 rt:5 0000 0000 0101 1010 &cp2
     CVM_MF_GFM_RESINP_REFLECT1           010010 00001 rt:5 0000 0000 0101 1011 &cp2
+    CVM_MF_HSH_DATW0                     010010 00001 rt:5 0000 0010 0100 0000 &cp2
+    CVM_MF_HSH_DATW1                     010010 00001 rt:5 0000 0010 0100 0001 &cp2
+    CVM_MF_HSH_DATW2                     010010 00001 rt:5 0000 0010 0100 0010 &cp2
+    CVM_MF_HSH_DATW3                     010010 00001 rt:5 0000 0010 0100 0011 &cp2
+    CVM_MF_HSH_DATW4                     010010 00001 rt:5 0000 0010 0100 0100 &cp2
+    CVM_MF_HSH_DATW5                     010010 00001 rt:5 0000 0010 0100 0101 &cp2
+    CVM_MF_HSH_DATW6                     010010 00001 rt:5 0000 0010 0100 0110 &cp2
+    CVM_MF_HSH_DATW7                     010010 00001 rt:5 0000 0010 0100 0111 &cp2
+    CVM_MF_HSH_DATW8                     010010 00001 rt:5 0000 0010 0100 1000 &cp2
+    CVM_MF_HSH_DATW9                     010010 00001 rt:5 0000 0010 0100 1001 &cp2
+    CVM_MF_HSH_DATW10                    010010 00001 rt:5 0000 0010 0100 1010 &cp2
+    CVM_MF_HSH_DATW11                    010010 00001 rt:5 0000 0010 0100 1011 &cp2
+    CVM_MF_HSH_DATW12                    010010 00001 rt:5 0000 0010 0100 1100 &cp2
+    CVM_MF_HSH_DATW13                    010010 00001 rt:5 0000 0010 0100 1101 &cp2
+    CVM_MF_HSH_DATW14                    010010 00001 rt:5 0000 0010 0100 1110 &cp2
+    CVM_MF_HSH_DATW15                    010010 00001 rt:5 0000 0010 0100 1111 &cp2
+    CVM_MF_HSH_IVW0                      010010 00001 rt:5 0000 0010 0101 0000 &cp2
+    CVM_MF_HSH_IVW1                      010010 00001 rt:5 0000 0010 0101 0001 &cp2
+    CVM_MF_HSH_IVW2                      010010 00001 rt:5 0000 0010 0101 0010 &cp2
+    CVM_MF_HSH_IVW3                      010010 00001 rt:5 0000 0010 0101 0011 &cp2
+    CVM_MF_HSH_IVW4                      010010 00001 rt:5 0000 0010 0101 0100 &cp2
+    CVM_MF_HSH_IVW5                      010010 00001 rt:5 0000 0010 0101 0101 &cp2
+    CVM_MF_HSH_IVW6                      010010 00001 rt:5 0000 0010 0101 0110 &cp2
+    CVM_MF_HSH_IVW7                      010010 00001 rt:5 0000 0010 0101 0111 &cp2
     CVM_MF_GFM_MUL0                      010010 00001 rt:5 0000 0010 0101 1000 &cp2
     CVM_MF_GFM_MUL1                      010010 00001 rt:5 0000 0010 0101 1001 &cp2
     CVM_MF_GFM_RESINP0                   010010 00001 rt:5 0000 0010 0101 1010 &cp2
@@ -153,6 +178,10 @@ LDX          011111 ..... ..... ..... 01000 001010 @lx
     CVM_MT_HSH_IV1                       010010 00101 rt:5 0000 0000 0100 1001 &cp2
     CVM_MT_HSH_IV2                       010010 00101 rt:5 0000 0000 0100 1010 &cp2
     CVM_MT_HSH_IV3                       010010 00101 rt:5 0000 0000 0100 1011 &cp2
+    CVM_MT_SHA3_DAT24                    010010 00101 rt:5 0000 0000 0101 0000 &cp2
+    CVM_MT_SHA3_DAT15                    010010 00101 rt:5 0000 0000 0101 0001 &cp2
+    # Cavium SDK code uses 0x0057 as a STARTSHA1 compatibility alias.
+    CVM_MT_HSH_STARTSHA1_COMPAT          010010 00101 rt:5 0000 0000 0101 0111 &cp2
     CVM_MT_GFM_MUL_REFLECT0              010010 00101 rt:5 0000 0000 0101 1000 &cp2
     CVM_MT_GFM_MUL_REFLECT1              010010 00101 rt:5 0000 0000 0101 1001 &cp2
     CVM_MT_GFM_XOR0_REFLECT              010010 00101 rt:5 0000 0000 0101 1100 &cp2
@@ -182,19 +211,67 @@ LDX          011111 ..... ..... ..... 01000 001010 @lx
     CVM_MT_CRC_BYTE_REFLECT              010010 00101 rt:5 0000 0010 0001 0100 &cp2
     CVM_MT_CRC_HALF_REFLECT              010010 00101 rt:5 0000 0010 0001 0101 &cp2
     CVM_MT_CRC_WORD_REFLECT              010010 00101 rt:5 0000 0010 0001 0110 &cp2
+    CVM_MT_HSH_DATW0                     010010 00101 rt:5 0000 0010 0100 0000 &cp2
+    CVM_MT_HSH_DATW1                     010010 00101 rt:5 0000 0010 0100 0001 &cp2
+    CVM_MT_HSH_DATW2                     010010 00101 rt:5 0000 0010 0100 0010 &cp2
+    CVM_MT_HSH_DATW3                     010010 00101 rt:5 0000 0010 0100 0011 &cp2
+    CVM_MT_HSH_DATW4                     010010 00101 rt:5 0000 0010 0100 0100 &cp2
+    CVM_MT_HSH_DATW5                     010010 00101 rt:5 0000 0010 0100 0101 &cp2
+    CVM_MT_HSH_DATW6                     010010 00101 rt:5 0000 0010 0100 0110 &cp2
+    CVM_MT_HSH_DATW7                     010010 00101 rt:5 0000 0010 0100 0111 &cp2
+    CVM_MT_HSH_DATW8                     010010 00101 rt:5 0000 0010 0100 1000 &cp2
+    CVM_MT_HSH_DATW9                     010010 00101 rt:5 0000 0010 0100 1001 &cp2
+    CVM_MT_HSH_DATW10                    010010 00101 rt:5 0000 0010 0100 1010 &cp2
+    CVM_MT_HSH_DATW11                    010010 00101 rt:5 0000 0010 0100 1011 &cp2
+    CVM_MT_HSH_DATW12                    010010 00101 rt:5 0000 0010 0100 1100 &cp2
+    CVM_MT_HSH_DATW13                    010010 00101 rt:5 0000 0010 0100 1101 &cp2
+    CVM_MT_HSH_DATW14                    010010 00101 rt:5 0000 0010 0100 1110 &cp2
+    CVM_MT_HSH_DATW15                    010010 00101 rt:5 0000 0010 0100 1111 &cp2
+    CVM_MT_HSH_IVW0                      010010 00101 rt:5 0000 0010 0101 0000 &cp2
+    CVM_MT_HSH_IVW1                      010010 00101 rt:5 0000 0010 0101 0001 &cp2
+    CVM_MT_HSH_IVW2                      010010 00101 rt:5 0000 0010 0101 0010 &cp2
+    CVM_MT_HSH_IVW3                      010010 00101 rt:5 0000 0010 0101 0011 &cp2
+    CVM_MT_HSH_IVW4                      010010 00101 rt:5 0000 0010 0101 0100 &cp2
+    CVM_MT_HSH_IVW5                      010010 00101 rt:5 0000 0010 0101 0101 &cp2
+    CVM_MT_HSH_IVW6                      010010 00101 rt:5 0000 0010 0101 0110 &cp2
+    CVM_MT_HSH_IVW7                      010010 00101 rt:5 0000 0010 0101 0111 &cp2
     CVM_MT_GFM_MUL0                      010010 00101 rt:5 0000 0010 0101 1000 &cp2
     CVM_MT_GFM_MUL1                      010010 00101 rt:5 0000 0010 0101 1001 &cp2
     CVM_MT_GFM_RESINP0                   010010 00101 rt:5 0000 0010 0101 1010 &cp2
     CVM_MT_GFM_RESINP1                   010010 00101 rt:5 0000 0010 0101 1011 &cp2
+    CVM_MT_GFM_XOR0                      010010 00101 rt:5 0000 0010 0101 1100 &cp2
     CVM_MT_GFM_POLY                      010010 00101 rt:5 0000 0010 0101 1110 &cp2
+    CVM_MT_SHA3_XORDAT0                  010010 00101 rt:5 0000 0010 1100 0000 &cp2
+    CVM_MT_SHA3_XORDAT1                  010010 00101 rt:5 0000 0010 1100 0001 &cp2
+    CVM_MT_SHA3_XORDAT2                  010010 00101 rt:5 0000 0010 1100 0010 &cp2
+    CVM_MT_SHA3_XORDAT3                  010010 00101 rt:5 0000 0010 1100 0011 &cp2
+    CVM_MT_SHA3_XORDAT4                  010010 00101 rt:5 0000 0010 1100 0100 &cp2
+    CVM_MT_SHA3_XORDAT5                  010010 00101 rt:5 0000 0010 1100 0101 &cp2
+    CVM_MT_SHA3_XORDAT6                  010010 00101 rt:5 0000 0010 1100 0110 &cp2
+    CVM_MT_SHA3_XORDAT7                  010010 00101 rt:5 0000 0010 1100 0111 &cp2
+    CVM_MT_SHA3_XORDAT8                  010010 00101 rt:5 0000 0010 1100 1000 &cp2
+    CVM_MT_SHA3_XORDAT9                  010010 00101 rt:5 0000 0010 1100 1001 &cp2
+    CVM_MT_SHA3_XORDAT10                 010010 00101 rt:5 0000 0010 1100 1010 &cp2
+    CVM_MT_SHA3_XORDAT11                 010010 00101 rt:5 0000 0010 1100 1011 &cp2
+    CVM_MT_SHA3_XORDAT12                 010010 00101 rt:5 0000 0010 1100 1100 &cp2
+    CVM_MT_SHA3_XORDAT13                 010010 00101 rt:5 0000 0010 1100 1101 &cp2
+    CVM_MT_SHA3_XORDAT14                 010010 00101 rt:5 0000 0010 1100 1110 &cp2
+    CVM_MT_SHA3_XORDAT15                 010010 00101 rt:5 0000 0010 1100 1111 &cp2
+    CVM_MT_SHA3_XORDAT16                 010010 00101 rt:5 0000 0010 1101 0000 &cp2
+    CVM_MT_SHA3_XORDAT17                 010010 00101 rt:5 0000 0010 1101 0001 &cp2
     CVM_MT_CRC_LEN                       010010 00101 rt:5 0001 0010 0000 0010 &cp2
     CVM_MT_CRC_DWORD                     010010 00101 rt:5 0001 0010 0000 0111 &cp2
     CVM_MT_CRC_VAR                       010010 00101 rt:5 0001 0010 0000 1000 &cp2
     CVM_MT_CRC_DWORD_REFLECT             010010 00101 rt:5 0001 0010 0001 0111 &cp2
     CVM_MT_CRC_VAR_REFLECT               010010 00101 rt:5 0001 0010 0001 1000 &cp2
+    CVM_MT_HSH_STARTMD5                  010010 00101 rt:5 0100 0000 0100 0111 &cp2
+    CVM_MT_HSH_STARTSHA256               010010 00101 rt:5 0100 0000 0100 1111 &cp2
+    CVM_MT_SHA3_STARTOP                  010010 00101 rt:5 0100 0000 0101 0010 &cp2
+    CVM_MT_HSH_STARTSHA                  010010 00101 rt:5 0100 0000 0101 0111 &cp2
     CVM_MT_GFM_XORMUL1_REFLECT           010010 00101 rt:5 0100 0000 0101 1101 &cp2
     CVM_MT_CRC_POLYNOMIAL                010010 00101 rt:5 0100 0010 0000 0000 &cp2
     CVM_MT_CRC_POLYNOMIAL_REFLECT        010010 00101 rt:5 0100 0010 0001 0000 &cp2
+    CVM_MT_HSH_STARTSHA512               010010 00101 rt:5 0100 0010 0100 1111 &cp2
     CVM_MT_GFM_XORMUL1                   010010 00101 rt:5 0100 0010 0101 1101 &cp2
   ]
   CP2_Undef                              010010 ----- ----- ---- ---- ---- ----
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index ce4cfcb3f3..5497e5a6ce 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -47,6 +47,11 @@
 #define CP2_MT_HELPER(NAME, SUFFIX) \
     TRANS(NAME, trans_octeon_cp2_mt_helper, \
           gen_helper_octeon_cp2_mt_ ## SUFFIX)
+#define CP2_MT_HELPER_ENV(NAME, SUFFIX) \
+    TRANS(NAME, trans_octeon_cp2_mt_helper_env, \
+          gen_helper_octeon_cp2_mt_ ## SUFFIX)
+#define CP2_MT_XOR_I64(NAME, FIELD) \
+    TRANS(NAME, trans_octeon_cp2_mt_xor_i64, OCTEON_CRYPTO_OFFSET(FIELD))
 
 #define OCTEON_LO32_OFFSET (HOST_BIG_ENDIAN ? 4 : 0)
 
@@ -165,6 +170,19 @@ static bool trans_octeon_cp2_mt_hsh_pair(DisasContext *ctx, arg_cp2 *a,
     return true;
 }
 
+static bool trans_octeon_cp2_mt_xor_i64(DisasContext *ctx, arg_cp2 *a,
+                                        int offset)
+{
+    TCGv_i64 value = tcg_temp_new_i64();
+    TCGv_i64 old = tcg_temp_new_i64();
+
+    gen_load_gpr(value, a->rt);
+    tcg_gen_ld_i64(old, tcg_env, offset);
+    tcg_gen_xor_i64(old, old, value);
+    tcg_gen_st_i64(old, tcg_env, offset);
+    return true;
+}
+
 static bool trans_octeon_cp2_mt_helper(DisasContext *ctx, arg_cp2 *a,
                                        void (*gen_helper)(TCGv_env, TCGv_i64))
 {
@@ -175,6 +193,13 @@ static bool trans_octeon_cp2_mt_helper(DisasContext *ctx, arg_cp2 *a,
     return true;
 }
 
+static bool trans_octeon_cp2_mt_helper_env(DisasContext *ctx, arg_cp2 *a,
+                                           void (*gen_helper)(TCGv_env))
+{
+    gen_helper(tcg_env);
+    return true;
+}
+
 CP2_MF_HSH_PAIR(CVM_MF_HSH_DAT0, hsh_dat, 0);
 CP2_MF_HSH_PAIR(CVM_MF_HSH_DAT1, hsh_dat, 1);
 CP2_MF_HSH_PAIR(CVM_MF_HSH_DAT2, hsh_dat, 2);
@@ -212,10 +237,35 @@ CP2_MF_I64(CVM_MF_GFM_RESINP1, gfm_resinp[1]);
 CP2_MF_U16(CVM_MF_GFM_POLY, gfm_poly);
 
 CP2_MF_HELPER(CVM_MF_CRC_IV_REFLECT, crc_iv_reflect);
+CP2_MF_I64(CVM_MF_SHA3_DAT24, sha3_dat24);
 CP2_MF_HELPER(CVM_MF_GFM_MUL_REFLECT0, gfm_mul_reflect0);
 CP2_MF_HELPER(CVM_MF_GFM_MUL_REFLECT1, gfm_mul_reflect1);
 CP2_MF_HELPER(CVM_MF_GFM_RESINP_REFLECT0, gfm_resinp_reflect0);
 CP2_MF_HELPER(CVM_MF_GFM_RESINP_REFLECT1, gfm_resinp_reflect1);
+CP2_MF_I64(CVM_MF_HSH_DATW0, hsh_dat[0]);
+CP2_MF_I64(CVM_MF_HSH_DATW1, hsh_dat[1]);
+CP2_MF_I64(CVM_MF_HSH_DATW2, hsh_dat[2]);
+CP2_MF_I64(CVM_MF_HSH_DATW3, hsh_dat[3]);
+CP2_MF_I64(CVM_MF_HSH_DATW4, hsh_dat[4]);
+CP2_MF_I64(CVM_MF_HSH_DATW5, hsh_dat[5]);
+CP2_MF_I64(CVM_MF_HSH_DATW6, hsh_dat[6]);
+CP2_MF_I64(CVM_MF_HSH_DATW7, hsh_dat[7]);
+CP2_MF_I64(CVM_MF_HSH_DATW8, hsh_dat[8]);
+CP2_MF_I64(CVM_MF_HSH_DATW9, hsh_dat[9]);
+CP2_MF_I64(CVM_MF_HSH_DATW10, hsh_dat[10]);
+CP2_MF_I64(CVM_MF_HSH_DATW11, hsh_dat[11]);
+CP2_MF_I64(CVM_MF_HSH_DATW12, hsh_dat[12]);
+CP2_MF_I64(CVM_MF_HSH_DATW13, hsh_dat[13]);
+CP2_MF_I64(CVM_MF_HSH_DATW14, hsh_dat[14]);
+CP2_MF_I64(CVM_MF_HSH_DATW15, hsh_dat[15]);
+CP2_MF_I64(CVM_MF_HSH_IVW0, hsh_iv[0]);
+CP2_MF_I64(CVM_MF_HSH_IVW1, hsh_iv[1]);
+CP2_MF_I64(CVM_MF_HSH_IVW2, hsh_iv[2]);
+CP2_MF_I64(CVM_MF_HSH_IVW3, hsh_iv[3]);
+CP2_MF_I64(CVM_MF_HSH_IVW4, hsh_iv[4]);
+CP2_MF_I64(CVM_MF_HSH_IVW5, hsh_iv[5]);
+CP2_MF_I64(CVM_MF_HSH_IVW6, hsh_iv[6]);
+CP2_MF_I64(CVM_MF_HSH_IVW7, hsh_iv[7]);
 
 CP2_MT_HSH_PAIR(CVM_MT_HSH_DAT0, hsh_dat, 0);
 CP2_MT_HSH_PAIR(CVM_MT_HSH_DAT1, hsh_dat, 1);
@@ -254,11 +304,13 @@ CP2_MT_I64(CVM_MT_GFM_MUL0, gfm_mul[0]);
 CP2_MT_I64(CVM_MT_GFM_MUL1, gfm_mul[1]);
 CP2_MT_I64(CVM_MT_GFM_RESINP0, gfm_resinp[0]);
 CP2_MT_I64(CVM_MT_GFM_RESINP1, gfm_resinp[1]);
+CP2_MT_XOR_I64(CVM_MT_GFM_XOR0, gfm_resinp[0]);
 CP2_MT_U16(CVM_MT_GFM_POLY, gfm_poly);
 CP2_MT_U8_MASKED(CVM_MT_CRC_LEN, crc_len, 0xf);
 CP2_MT_U32(CVM_MT_CRC_POLYNOMIAL, crc_poly);
 
 CP2_MT_HELPER(CVM_MT_CRC_POLYNOMIAL_REFLECT, crc_write_polynomial_reflect);
+
 CP2_MT_HELPER(CVM_MT_CRC_IV_REFLECT, crc_write_iv_reflect);
 CP2_MT_HELPER(CVM_MT_CRC_BYTE, crc_write_byte);
 CP2_MT_HELPER(CVM_MT_CRC_HALF, crc_write_half);
@@ -272,6 +324,56 @@ CP2_MT_HELPER(CVM_MT_CRC_DWORD_REFLECT, crc_write_dword_reflect);
 CP2_MT_HELPER(CVM_MT_CRC_VAR_REFLECT, crc_write_var_reflect);
 CP2_MT_HELPER(CVM_MT_GFM_XORMUL1_REFLECT, gfm_xormul1_reflect);
 CP2_MT_HELPER(CVM_MT_GFM_XORMUL1, gfm_xormul1);
+CP2_MT_I64(CVM_MT_SHA3_DAT24, sha3_dat24);
+CP2_MT_I64(CVM_MT_SHA3_DAT15, hsh_dat[15]);
+CP2_MT_XOR_I64(CVM_MT_SHA3_XORDAT0, sha3_dat[0]);
+CP2_MT_XOR_I64(CVM_MT_SHA3_XORDAT1, sha3_dat[1]);
+CP2_MT_XOR_I64(CVM_MT_SHA3_XORDAT2, sha3_dat[2]);
+CP2_MT_XOR_I64(CVM_MT_SHA3_XORDAT3, sha3_dat[3]);
+CP2_MT_XOR_I64(CVM_MT_SHA3_XORDAT4, sha3_dat[4]);
+CP2_MT_XOR_I64(CVM_MT_SHA3_XORDAT5, sha3_dat[5]);
+CP2_MT_XOR_I64(CVM_MT_SHA3_XORDAT6, sha3_dat[6]);
+CP2_MT_XOR_I64(CVM_MT_SHA3_XORDAT7, sha3_dat[7]);
+CP2_MT_XOR_I64(CVM_MT_SHA3_XORDAT8, sha3_dat[8]);
+CP2_MT_XOR_I64(CVM_MT_SHA3_XORDAT9, sha3_dat[9]);
+CP2_MT_XOR_I64(CVM_MT_SHA3_XORDAT10, sha3_dat[10]);
+CP2_MT_XOR_I64(CVM_MT_SHA3_XORDAT11, sha3_dat[11]);
+CP2_MT_XOR_I64(CVM_MT_SHA3_XORDAT12, sha3_dat[12]);
+CP2_MT_XOR_I64(CVM_MT_SHA3_XORDAT13, sha3_dat[13]);
+CP2_MT_XOR_I64(CVM_MT_SHA3_XORDAT14, sha3_dat[14]);
+CP2_MT_XOR_I64(CVM_MT_SHA3_XORDAT15, sha3_dat[15]);
+CP2_MT_XOR_I64(CVM_MT_SHA3_XORDAT16, sha3_dat[16]);
+CP2_MT_XOR_I64(CVM_MT_SHA3_XORDAT17, sha3_dat[17]);
+CP2_MT_HELPER_ENV(CVM_MT_SHA3_STARTOP, sha3_startop);
+CP2_MT_HELPER(CVM_MT_HSH_STARTSHA1_COMPAT, hsh_startsha1_compat);
+CP2_MT_I64(CVM_MT_HSH_DATW0, hsh_dat[0]);
+CP2_MT_I64(CVM_MT_HSH_DATW1, hsh_dat[1]);
+CP2_MT_I64(CVM_MT_HSH_DATW2, hsh_dat[2]);
+CP2_MT_I64(CVM_MT_HSH_DATW3, hsh_dat[3]);
+CP2_MT_I64(CVM_MT_HSH_DATW4, hsh_dat[4]);
+CP2_MT_I64(CVM_MT_HSH_DATW5, hsh_dat[5]);
+CP2_MT_I64(CVM_MT_HSH_DATW6, hsh_dat[6]);
+CP2_MT_I64(CVM_MT_HSH_DATW7, hsh_dat[7]);
+CP2_MT_I64(CVM_MT_HSH_DATW8, hsh_dat[8]);
+CP2_MT_I64(CVM_MT_HSH_DATW9, hsh_dat[9]);
+CP2_MT_I64(CVM_MT_HSH_DATW10, hsh_dat[10]);
+CP2_MT_I64(CVM_MT_HSH_DATW11, hsh_dat[11]);
+CP2_MT_I64(CVM_MT_HSH_DATW12, hsh_dat[12]);
+CP2_MT_I64(CVM_MT_HSH_DATW13, hsh_dat[13]);
+CP2_MT_I64(CVM_MT_HSH_DATW14, hsh_dat[14]);
+CP2_MT_I64(CVM_MT_HSH_DATW15, hsh_dat[15]);
+CP2_MT_I64(CVM_MT_HSH_IVW0, hsh_iv[0]);
+CP2_MT_I64(CVM_MT_HSH_IVW1, hsh_iv[1]);
+CP2_MT_I64(CVM_MT_HSH_IVW2, hsh_iv[2]);
+CP2_MT_I64(CVM_MT_HSH_IVW3, hsh_iv[3]);
+CP2_MT_I64(CVM_MT_HSH_IVW4, hsh_iv[4]);
+CP2_MT_I64(CVM_MT_HSH_IVW5, hsh_iv[5]);
+CP2_MT_I64(CVM_MT_HSH_IVW6, hsh_iv[6]);
+CP2_MT_I64(CVM_MT_HSH_IVW7, hsh_iv[7]);
+CP2_MT_HELPER(CVM_MT_HSH_STARTMD5, hsh_startmd5);
+CP2_MT_HELPER(CVM_MT_HSH_STARTSHA256, hsh_startsha256);
+CP2_MT_HELPER(CVM_MT_HSH_STARTSHA, hsh_startsha);
+CP2_MT_HELPER(CVM_MT_HSH_STARTSHA512, hsh_startsha512);
 
 static bool trans_BBIT(DisasContext *ctx, arg_BBIT *a)
 {

-- 
2.54.0


