Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD3FECD5BAC
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 18:08:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ7nH-0000Ju-9k; Thu, 21 May 2026 14:06:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wQ7n6-0000HE-9G
 for qemu-devel@nongnu.org; Thu, 21 May 2026 14:06:41 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wQ7n4-000273-I9
 for qemu-devel@nongnu.org; Thu, 21 May 2026 14:06:40 -0400
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7dca4debedaso6647302a34.2
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 11:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779386797; x=1779991597; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fpwiBtNqlipCJe2vzrwxpxXwFsEBVwwe+J4psgPGXeI=;
 b=kAS9qgM0WvqM35qTxSYmktfxRT7D8LJtRWnfIZD9hYV9uZ/u9ay/ltl8N5rYFc1LrM
 VO1MoQq7+4QP95BWfPP3fHZ+K65cCpMwmZdB+6hfc/Z+heVCLfEuhdTv7QK7abceC1+1
 jU/O8RRBdC6cj1fpizgH2tX8cIKfH1Sgm8nF+pHpQH0k0Q8wbBU2HrA4VVyGo2KB/Jdb
 ATFV/6MZtBDA+dNMQ1bOfUiptjXHEm47jEvg4eIiAGr4YFp+UnghriDwscrIK9WF9Wr7
 TdxW/jtEOpFbI/OlsJU7eHsQ99rI+X0KtRww/l5zGZaeyO1MTqGMjKe+1qMUv22KFJlJ
 VQfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779386797; x=1779991597;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=fpwiBtNqlipCJe2vzrwxpxXwFsEBVwwe+J4psgPGXeI=;
 b=Phc6y2mftJXWI6i4+Bjclv6eRvtsnvkcEp3mZumBZbU3SQ+j6RRe6YG+NcwObkd7O0
 ODK0w8pz3PXvxmdm7p8SMy4dV9nXVAYOIJaBYE6yXRs0f3mHP3ymjKcXenXhgQe/ojAT
 us7NJdXwaqPJXGaX0iRh6EVNjM7Mf/IfnCpZGmQ9+rKbsArOTtDbbP7U5TGNqHRId3+A
 c/ExHCuzN1U8+UF+GtJsUcd3KiiC0G83Egj2NDC56MViOtosVJV0ClJnFVE9j6hdEKsR
 xCZ19C/q/ncFN99f1qYgPE0D0p0I34ppnJIRZzpj2lg7H5kMw9MGQcvflPhr7T12GmU5
 d54Q==
X-Gm-Message-State: AOJu0YxrhcS12rznrFkisATFJYDUPuNbIHQZU7fh2C6pwndstEDA0mnc
 xbwH77X8CsQlHxqZ58GdUwDPa0lbozZY64bdHm3JzN4x/2yUGQltRzxW
X-Gm-Gg: Acq92OG2tXcr1k+AL2do6vyzChGUyOFDCLmjl1LLXqfj9NW57IXGU2loEHJxRxl1KvF
 KIhUVAIe4puYSdBToyxeyg1sf+eM9LCwCVIToeca4PSSjyyIUDbZRBoZwP/kG2lUmG7/F1iW2Dk
 kCNncak6Kj1B9FJq7bz2bWnvWIPkpDnPQ9AU+MCEiqN3nb86SIBChJVvxHN3UokHWD1H7dDzYKb
 lk392VxG8+jpCkpUloq17UmURuKm1fDmQJoKSqHrVTEB9sflorekHDZTLL2jQVRqYz/85pZ39Ls
 8b5INzM5NLVDEiAD3kcfNVLBO7553ooTBdY2+0NMNeoAfFbq1cJo9+TTYiyGHrRlucNi9k0cWIC
 XYKMfBZKdEK8SYzBWq5AZAKq8uBkZPAGcjtr9TsTtedkPHfCTiJmJQt3J6TsFP9p6/jS7atzZ1s
 FMcsXjpn2qSNEkADnXTPPFaSTsUrGosmpercyr61WP6kAm+hjBb8qpaibQJJqrvHnUwBolq5iYm
 2tOrcOQ8GYMHuLMPWr0v3lOMN3XQThxnnW3+nm7hu14PTL7ml0imHfnbw4Za+a6sxJUrlniWE/W
 WbE=
X-Received: by 2002:a05:6830:61c6:b0:7d7:f146:8738 with SMTP id
 46e09a7af769-7e5fee5ec6cmr148450a34.12.1779386797317; 
 Thu, 21 May 2026 11:06:37 -0700 (PDT)
Received: from mac.localdomain (184-96-131-78.hlrn.qwest.net. [184.96.131.78])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e5f6ee286fsm903089a34.25.2026.05.21.11.06.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 11:06:36 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 21 May 2026 12:06:13 -0600
Subject: [PATCH v13 20/22] target/mips: decode Octeon CHORD and LLM COP2
 selectors
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-mips-octeon-missing-insns-v2-v13-20-5a4cb8ec9cd3@gmail.com>
References: <20260521-mips-octeon-missing-insns-v2-v13-0-5a4cb8ec9cd3@gmail.com>
In-Reply-To: <20260521-mips-octeon-missing-insns-v2-v13-0-5a4cb8ec9cd3@gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::32e;
 envelope-from=james.hilliard1@gmail.com; helo=mail-ot1-x32e.google.com
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
CHORD and sparse LLM COP2 selectors.  CHORD and LLM use their own COP2
selector window rather than the crypto engine windows covered by the
preceding decode patches.

Finish the explicit COP2 selector decode by adding the CP2_Undef fallback
so unknown Octeon COP2 selectors raise the expected coprocessor-unusable
exception instead of silently taking a generic path.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

---
Changes v9 -> v10:
  - Split CHORD/LLM selector decode out of the monolithic Octeon COP2
    selector decode patch.
  - Kept sparse LLM operations helper-backed and moved the CP2_Undef
    fallback into the final selector-decode patch.
---
 target/mips/tcg/octeon.decode      | 14 ++++++++++++++
 target/mips/tcg/octeon_translate.c | 13 +++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index 9f2905795b..bbe51a10b4 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -160,6 +160,9 @@ LDX          011111 ..... ..... ..... 01000 001010 @lx
     CVM_MF_GFM_RESINP0                   010010 00001 rt:5 0000 0010 0101 1010 &cp2
     CVM_MF_GFM_RESINP1                   010010 00001 rt:5 0000 0010 0101 1011 &cp2
     CVM_MF_GFM_POLY                      010010 00001 rt:5 0000 0010 0101 1110 &cp2
+    CVM_MF_CHORD                         010010 00001 rt:5 0000 0100 0000 0000 &cp2
+    CVM_MF_LLM_DATA0                     010010 00001 rt:5 0000 0100 0000 0010 &cp2
+    CVM_MF_LLM_DATA1                     010010 00001 rt:5 0000 0100 0000 1010 &cp2
     CVM_MT_HSH_DAT0                      010010 00101 rt:5 0000 0000 0100 0000 &cp2
     CVM_MT_HSH_DAT1                      010010 00101 rt:5 0000 0000 0100 0001 &cp2
     CVM_MT_HSH_DAT2                      010010 00101 rt:5 0000 0000 0100 0010 &cp2
@@ -254,6 +257,16 @@ LDX          011111 ..... ..... ..... 01000 001010 @lx
     CVM_MT_SHA3_XORDAT15                 010010 00101 rt:5 0000 0010 1100 1111 &cp2
     CVM_MT_SHA3_XORDAT16                 010010 00101 rt:5 0000 0010 1101 0000 &cp2
     CVM_MT_SHA3_XORDAT17                 010010 00101 rt:5 0000 0010 1101 0001 &cp2
+    CVM_MT_LLM_READ_ADDR0                010010 00101 rt:5 0000 0100 0000 0000 &cp2
+    CVM_MT_LLM_WRITE_ADDR0               010010 00101 rt:5 0000 0100 0000 0001 &cp2
+    CVM_MT_LLM_DATA0                     010010 00101 rt:5 0000 0100 0000 0010 &cp2
+    CVM_MT_LLM_READ64_ADDR0              010010 00101 rt:5 0000 0100 0000 0100 &cp2
+    CVM_MT_LLM_WRITE64_ADDR0             010010 00101 rt:5 0000 0100 0000 0101 &cp2
+    CVM_MT_LLM_READ_ADDR1                010010 00101 rt:5 0000 0100 0000 1000 &cp2
+    CVM_MT_LLM_WRITE_ADDR1               010010 00101 rt:5 0000 0100 0000 1001 &cp2
+    CVM_MT_LLM_DATA1                     010010 00101 rt:5 0000 0100 0000 1010 &cp2
+    CVM_MT_LLM_READ64_ADDR1              010010 00101 rt:5 0000 0100 0000 1100 &cp2
+    CVM_MT_LLM_WRITE64_ADDR1             010010 00101 rt:5 0000 0100 0000 1101 &cp2
     CVM_MT_CRC_LEN                       010010 00101 rt:5 0001 0010 0000 0010 &cp2
     CVM_MT_CRC_DWORD                     010010 00101 rt:5 0001 0010 0000 0111 &cp2
     CVM_MT_CRC_VAR                       010010 00101 rt:5 0001 0010 0000 1000 &cp2
@@ -288,4 +301,5 @@ LDX          011111 ..... ..... ..... 01000 001010 @lx
     CVM_MT_HSH_STARTSHA512               010010 00101 rt:5 0100 0010 0100 1111 &cp2
     CVM_MT_GFM_XORMUL1                   010010 00101 rt:5 0100 0010 0101 1101 &cp2
   ]
+  CP2_Undef                              010010 ----- ----- ---- ---- ---- ----
 }
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index 41bfcc47b3..538c6f71bc 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -179,6 +179,9 @@ CP2_MF_I64(CVM_MF_GFM_MUL1, gfm_mul[1]);
 CP2_MF_I64(CVM_MF_GFM_RESINP0, gfm_resinp[0]);
 CP2_MF_I64(CVM_MF_GFM_RESINP1, gfm_resinp[1]);
 CP2_MF_U16(CVM_MF_GFM_POLY, gfm_poly);
+CP2_MF_I64(CVM_MF_CHORD, chord);
+CP2_MF_I64(CVM_MF_LLM_DATA0, llm_data[0]);
+CP2_MF_I64(CVM_MF_LLM_DATA1, llm_data[1]);
 
 CP2_MF_HELPER(CVM_MF_CRC_IV_REFLECT, crc_iv_reflect);
 CP2_MF_HELPER(CVM_MF_SHA3_DAT24, sha3_dat24);
@@ -250,6 +253,8 @@ CP2_MT_I64(CVM_MT_GFM_RESINP0, gfm_resinp[0]);
 CP2_MT_I64(CVM_MT_GFM_RESINP1, gfm_resinp[1]);
 CP2_MT_HELPER(CVM_MT_GFM_XOR0, gfm_xor0);
 CP2_MT_U16(CVM_MT_GFM_POLY, gfm_poly);
+CP2_MT_I64(CVM_MT_LLM_DATA0, llm_data[0]);
+CP2_MT_I64(CVM_MT_LLM_DATA1, llm_data[1]);
 CP2_MT_U8_MASKED(CVM_MT_CRC_LEN, crc_len, 0xf);
 CP2_MT_U32(CVM_MT_CRC_POLYNOMIAL, crc_poly);
 
@@ -339,6 +344,14 @@ CP2_MT_HELPER(CVM_MT_HSH_STARTMD5, hsh_startmd5);
 CP2_MT_HELPER(CVM_MT_HSH_STARTSHA256, hsh_startsha256);
 CP2_MT_HELPER(CVM_MT_HSH_STARTSHA, hsh_startsha);
 CP2_MT_HELPER(CVM_MT_HSH_STARTSHA512, hsh_startsha512);
+CP2_MT_HELPER(CVM_MT_LLM_READ_ADDR0, llm_read_addr0);
+CP2_MT_HELPER(CVM_MT_LLM_WRITE_ADDR0, llm_write_addr0);
+CP2_MT_HELPER(CVM_MT_LLM_READ64_ADDR0, llm_read64_addr0);
+CP2_MT_HELPER(CVM_MT_LLM_WRITE64_ADDR0, llm_write64_addr0);
+CP2_MT_HELPER(CVM_MT_LLM_READ_ADDR1, llm_read_addr1);
+CP2_MT_HELPER(CVM_MT_LLM_WRITE_ADDR1, llm_write_addr1);
+CP2_MT_HELPER(CVM_MT_LLM_READ64_ADDR1, llm_read64_addr1);
+CP2_MT_HELPER(CVM_MT_LLM_WRITE64_ADDR1, llm_write64_addr1);
 
 static bool trans_BBIT(DisasContext *ctx, arg_BBIT *a)
 {

-- 
2.54.0


