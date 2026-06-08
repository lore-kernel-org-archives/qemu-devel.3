Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C166CD6E79
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 19:03:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWfD5-00017E-Pl; Mon, 08 Jun 2026 15:00:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wWfCz-00013E-L7
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 15:00:25 -0400
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wWfCv-0006h8-LH
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 15:00:25 -0400
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-4859b1fc7a8so2458893b6e.0
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2026 12:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780945219; x=1781550019; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BpjNFRkJXDxeJXgFf+peeS1OMxQxnbmGHgcjDSZVnxY=;
 b=cm8eLiHCIgR1t5fGvYCVHBkVkViq8FDpM15hVh+MKY4UoM2Umtg5YYtW/Kqo0rGXhT
 qV6GM5Fi9sVwZLuwrddWZ+sg8ob7nqji85WmHYI/HuR6SO7YCdDXbRB9Jn0U/c7ns2B7
 lZJEK9+K92tdSufXOcGMI0/CPpiK6uq1gJ65U2NZQz327YtCZsah2EWW31b2S4NEdr9q
 r99MxzIoJKcDhqWpCJCZPsn7q0PqNIn1Vv+I5HVEZuPzBk5Ko5G8Gfb9rY8k/tHP3ZRu
 QiDsETLKygJAm9/k3N2E6ifj/fDG/ItHzUyIPk/av4kW57UKmGf/9PQFK1ZhnNG8B5/i
 oX8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780945219; x=1781550019;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=BpjNFRkJXDxeJXgFf+peeS1OMxQxnbmGHgcjDSZVnxY=;
 b=cKYVaVAccguTQLTVMeXsrf37xmSESMEs5eAGXjiD6WTBrVPyMCXdBTZFDDsgHRvQ0V
 MXTDRKVLjlGbCP66H++A25hj3VhrVR8KJLwubjbEY2fSCnGkW69/Ofvb/peLYeQ9t3Gw
 L6T4CfPzxR9bMqp051nwObqMUuF/ARYYwZJnW5Bxb9s+j79D9CoKJD0yVs17L2p7CR2u
 bO1+P230COK6U4uyyeIKOG1fVS4IdovLzhMglL+wcqSlF9vR/B7NY6kVu1HqU0CWEDCJ
 L9vA/88ahd74OjZUWSlUAvkipWVuNFo0BzBcqo3lOPf37zfp+dYBjD0DrVb1GeiFEGLU
 rKIw==
X-Gm-Message-State: AOJu0Ywq+azDONkQiAx2o3JEi37boEBk0jTJ2h74MgOKaP7I/qaxzK6R
 2jgG9doGBHjeLh+vwVed7YwIeatPkIRB777DXF5EDSWakHVD36M16hmrnjJ4S4cZPY4=
X-Gm-Gg: Acq92OEKlWgucptb7tYuR2w4mxSzXoPiCojWyJ0glIBaUk3WQAih8WfzEdcenan48ef
 mfJnTXZ9VUCAh8xVq74+Z5dlhC8RUCViUhKGZKQTzB1r2OX2bJUDhs31PCxiVEt3RfEZRTAjA6M
 pRNyLtYlgHqGXa1HiTC1ksaASZ1/rXlIiQBH688FuKg/2G8OphSlMD4nc0Q40Z2jdS2/daLbd93
 Mz37TMCJtr151H58MmsKjXXkamjyP3pESFjz/tmL/pSF2FoF1kVIeaUi3pgkYFl5VcT6dE4y25v
 fPtM/4tJSAWC2LfnVVkWL3Pn8kqCFW7d/FYPEtiXG7yyKKuNJEmmVdXTtJ8z3pABSHY6jyK1Fxd
 kgvDXVc4HsAEQ51kc1ju0y6COLvqpmeHi6jO2eHZmTgIpi+bTvoV5WNXlwfb23n3o6jOpgS7eRs
 kwxTXtnI9UTz/nSSdYowlDjVj85TxSgzxedos6NrPUPJxFppAgbMHkSFuISILRNzz3VSFPPhucc
 Lwk9ZSG9juTMhJ3XYd6uUlak/n5XOG6tY9hBw03cSkXTN+vsY4FKFX1qInz4yqx39PJK4N468eT
 QrOu/b28OOJerP6Y+QxqyGhOVg4Pbi6z
X-Received: by 2002:a05:6808:4f48:b0:467:27d2:969f with SMTP id
 5614622812f47-4868debbe24mr9802978b6e.17.1780945219161; 
 Mon, 08 Jun 2026 12:00:19 -0700 (PDT)
Received: from mac.localdomain (97-118-5-210.hlrn.qwest.net. [97.118.5.210])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e6e75db138sm12397777a34.11.2026.06.08.12.00.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 12:00:18 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 08 Jun 2026 12:59:41 -0600
Subject: [PATCH v16 16/21] target/mips: decode Octeon HSH and SHA3 COP2
 selectors
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-mips-octeon-missing-insns-v2-v16-16-daef7a0d8b04@gmail.com>
References: <20260608-mips-octeon-missing-insns-v2-v16-0-daef7a0d8b04@gmail.com>
In-Reply-To: <20260608-mips-octeon-missing-insns-v2-v16-0-daef7a0d8b04@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
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


