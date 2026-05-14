Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D583CD4F25
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 17:40:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNa2E-0002VK-3f; Thu, 14 May 2026 13:39:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wNa14-0000s1-1o
 for qemu-devel@nongnu.org; Thu, 14 May 2026 13:38:36 -0400
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wNa0z-0003ve-TX
 for qemu-devel@nongnu.org; Thu, 14 May 2026 13:38:33 -0400
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-47cbd444fd0so5301215b6e.2
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 10:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778780291; x=1779385091; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=v2eoUlIfs2CyNozH/5hnGz/btUr0dDiu9hxVMe976wQ=;
 b=HNyPsS/eCcEeceSePTtGqB/dafATSxpwyUJdEuOeFZpzA+D88lrWlMhNX7gD8oj7LO
 FJ3yLJS7BgNP9iw1yGdsEfbpF735d3IrKsT89jsgBC3u8sWCvrKaMK7E6YDIqjOvP4Zn
 euxXsus4AMPyYK/Y+EpbDmtzOCGIa27dSiBTsYzrBVEf8DjKcIbd+MkVDVWqzSSFI0VL
 ip4OUPWE17jrpEIL1aAqn5IzJstZ6hmSTwDO4E7+vMBpw0/0LL8+bl4eLOA+Pr7eVLaS
 9+qVmco3ee2pKqxRdKg6kmV0kjc7yFWAZfO/bEZh/XAqjQ/VQ32S0rseaqsf7Mf1Lr5o
 zwfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778780291; x=1779385091;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=v2eoUlIfs2CyNozH/5hnGz/btUr0dDiu9hxVMe976wQ=;
 b=NLj+keqrnOYSXlfhmy8wGMWFyw0lJUX8vA9Oc/V+RBt99uxUdQkGvk8iX0KHBOB/yG
 1oIfsG4/hpKwfWjYIzw5ps74K4XO4U/0ocp1c0YmrgUjAc8T1Hs+FJw3+OR1elf0dOI6
 Od61804j95n1r0qBLlVmi2iDIVxVhBp5FKW3ej3Zjz58JqYJa8yoMKh7cXwCVtNHr9Yu
 qbgSIBVzUHYeSvU2nw20jNTJLsLtBB7JnHeKFrQIH1+G6/f2lb6h351Joq00HfmesqFz
 QTo40nhJ3IkcCATBbTd5kDQn4/7VMyBUSdfLD7IRsxtcKP174AmGP+MyqeF0vW3xbYoK
 Whqg==
X-Gm-Message-State: AOJu0YxzTPMrdfPQ23ugKvZH5Ru3bPkc6+uQocQjCOJHEdwZ5yh4CJ6y
 TjQuWFNFx7eud/H9V2+5PEriGCVvZAbNxm21KsLHaXEwaoTn4jEVqCt5
X-Gm-Gg: Acq92OFbXb9x8sRwyrZqbhp/8FNQ0Ng81OP7QRr/h/zzp48H+cxkKuv65MqDMIkg2lr
 bJQg08mU7Xng3MGzjTCUZZ+f/nKxJk9go5VdHmTGHa0yVTlFI1qWnrMN0C1bb9P1ea414gN/ypI
 utNM702Zwwv8FQhTwn5VquEU3Odh201ps3QCVIbhQACO2XebYcz2AIQFMhJPfu8lbJLEYsXWbiq
 cOgoJtDi+QlpXy9QoBPSMBjj1grC3Z+DV7IoYfNcReLVSa8Ag75c7d1vMX11FWyk4fLLHHaybVo
 +zew1wNziDK0tc4kqPnaZGpGTO1sdgThYPsdGx1MfmEUq9XAXyh6QzngObLkDctKspBxosjFWE8
 FGhderg1XzlBhshm9vcYoaF7BMP3t9gtX7fnqFEUrzwIsLs4c/S9x//xO/KIZ0bKzgbReLplFQy
 QajDxvYnCcdKIkbwMoA+Nz7cUjPAkNVKqAfqCm6qzBmkwaHXP+D2hM6UhHJe7Xh1CFXkyexuVAi
 vTXIvnhzYJFAoZ5XvejUxj3yd4hf+7rTupk2XWUxEdReIK1z6I9QYcUbVR2zRZFyYtalfsOMdnU
 LSQ=
X-Received: by 2002:a05:6820:809:b0:695:818c:e56c with SMTP id
 006d021491bc7-69c94295ac4mr284605eaf.7.1778780291364; 
 Thu, 14 May 2026 10:38:11 -0700 (PDT)
Received: from mac.localdomain (71-218-106-55.hlrn.qwest.net. [71.218.106.55])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69b8ccdc74esm1687254eaf.13.2026.05.14.10.38.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 10:38:10 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 14 May 2026 11:37:07 -0600
Subject: [PATCH v7 18/35] target/mips: add Octeon MTP2 instruction
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260514-mips-octeon-missing-insns-v2-v7-18-226686be4ce1@gmail.com>
References: <20260514-mips-octeon-missing-insns-v2-v7-0-226686be4ce1@gmail.com>
In-Reply-To: <20260514-mips-octeon-missing-insns-v2-v7-0-226686be4ce1@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::230;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oi1-x230.google.com
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

MTP2 loads the high Octeon3 partial-product pair from rs/rt into P[2]
and P[5].

This exposes the final guest-managed partial-product slot for the
Octeon multiplier operations.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v2 -> v3:
  - Split MTP2 out of the combined Octeon arithmetic and memory
    instruction patch.  (requested by Richard Henderson)

Changes v3 -> v4:
  - Describe the Octeon3 rs/rt P[2]/P[5] pair handled by the shared MTP
    translator.
---
 target/mips/tcg/octeon.decode      | 1 +
 target/mips/tcg/octeon_translate.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index 837c917a0d..bee64c1743 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -47,6 +47,7 @@ SNEI         011100 rs:5 rt:5 imm:s10 101111 &cmpi
 MTM0         011100 rs:5 rt:5 00000 00000 001000 &r2
 MTP0         011100 rs:5 rt:5 00000 00000 001001 &r2
 MTP1         011100 rs:5 rt:5 00000 00000 001010 &r2
+MTP2         011100 rs:5 rt:5 00000 00000 001011 &r2
 
 &saa         base rt
 @saa         ...... base:5 rt:5 ................ &saa
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index 3c727d0b08..9d7fa47636 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -297,3 +297,4 @@ TRANS(LDX,  trans_lx, MO_UQ);
 TRANS(MTM0, trans_mtm, 0);
 TRANS(MTP0, trans_mtp, 0);
 TRANS(MTP1, trans_mtp, 1);
+TRANS(MTP2, trans_mtp, 2);

-- 
2.54.0


