Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7365ECD37AF
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2026 02:16:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLtgI-0006AM-R9; Sat, 09 May 2026 22:14:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wLtgH-0006A7-ET
 for qemu-devel@nongnu.org; Sat, 09 May 2026 22:14:09 -0400
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wLtgF-0002z9-Oh
 for qemu-devel@nongnu.org; Sat, 09 May 2026 22:14:09 -0400
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-479dc6d26e3so1889052b6e.0
 for <qemu-devel@nongnu.org>; Sat, 09 May 2026 19:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778379246; x=1778984046; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jnTxvj2NRvBp/PsYuz9M5M2pWClh5EWOHRLfqtuRYzk=;
 b=oqCOtDgt4dWAH4Tt8LV0X9QvQ099b7uqxRJHjK0LWQOnyVYzxVCoNUIQQCrEoinyVw
 ueJxeu6aUYhgcUyg7bZyQfq3MqstBFtHzePq3DorxWRjFQUbTCgZf/cbgY5xUFWLaLhd
 GIDqNVOOt4+l5KMYnnvw5kKpaQ9VayuQxDHjtERxSU+62mDPs7sN+fyBGm5cPyEZ0nTC
 tQ0v0jKfpEdMI58MysybKxrOmBidRhUoc2yirprMbQtrYhg0mysr7htosK2fzOnGPWT1
 BmlTNlk8FOYNJICFpbslj2l966TzWTqoBHPa/3Q0/Ia5XOvgm1qsbwS7bRJazxpoREpH
 3xOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778379246; x=1778984046;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=jnTxvj2NRvBp/PsYuz9M5M2pWClh5EWOHRLfqtuRYzk=;
 b=q+VcFdbbJpa86Rzb8VNgLL4fWEyB8b+qpuPfi795M8xPDD5hawa73IUg52MsigdTCK
 8/yJfvoRcE5HTgKbYxCZDkNDQIw6Te/PwMbGzq4i9mZcAkJPnZY1DUOsyTbETDrMvgnX
 eXUzofG/24fDu7KgtDTpNr4++4GAhVR+pJ4X5r1t/G4jpb7tfJmcregvLKr+t5jBFS+1
 zvohtCbYLbVvJIoIEbcqkoa7M0z/XawJdF0Ci2R3K7sGiPaYc1u9YbKZZTMc6hRAFKo7
 8SwnljxCEoqoQeHkZw/7McmbynPW1QXXtT4HD2i+zkwC0pbmaqsvNinLXtj3xi+SubiA
 zj3w==
X-Gm-Message-State: AOJu0YxoksLenfiF29/qzYCBEGN9KWFWHzH6xmra1o47DtlSsGxGkHSL
 aPCbQ4+i+oNkKcl7l60KWWIQWbirae9z+h7dVAqDq7TUPFu3vYovyWbo5pTFwk8Q
X-Gm-Gg: Acq92OEa/bXJNOt68WkRPQHb/WltKlYABflapaIUug401Xbe5mI0bDXajMC9HlfmVqR
 sAawxAzaKdC26bhh5nhMcjT1/vbyUhnSyIkHNUHyIxlyp23KhtRsujtzewJmqWJkrWjZfyk7VTS
 nXfW52f7A+FMulwt7lVxf9D+w7f5t4dUwyTtCTtB1a5A98oxqiWwOit7z4sT5OlDxd8fjXKSRpM
 6jpYfyHOH0y7BbqPFaDGvkmUXmRNe49GzA/0jINxszBBRnWgecmomBlae8y346hXTFiqSPzwxyw
 TPV58Cy4yi2qnitdFzM4TxFvBpvJxgLLNuw3sSSsq7G25s9wgkLJTQR6PVs3U7S9YfSXLb4IsxJ
 WNTkt692td/rxQ7CwM5pATXdXDPO49tLG+zP/vDi/2HHkyBT0g52i0Z141mu7RwVNu4I/7jEv0G
 PE24ETUuMNf05cJ9+jO0e8JP+cBEUHj974HpU3slGPeZNTmNHUHMllKOWTuvBQjQe7HyXLp22KH
 +rI6yahoysIVe9Ho2deQFOr4YPVwJLGFRbLN9A9k5vs0GFJehq2ISQhXLSrXE2S9LUb
X-Received: by 2002:a05:6820:f010:b0:696:8ccc:55a0 with SMTP id
 006d021491bc7-69998d22f89mr11372973eaf.42.1778379246197; 
 Sat, 09 May 2026 19:14:06 -0700 (PDT)
Received: from mac.localdomain (71-218-106-55.hlrn.qwest.net. [71.218.106.55])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69b25dbffdbsm3645643eaf.9.2026.05.09.19.14.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 May 2026 19:14:05 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sat, 09 May 2026 20:13:36 -0600
Subject: [PATCH v4 13/32] target/mips: add Octeon ZCB instruction
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260509-mips-octeon-missing-insns-v2-v4-13-d669dcd05c2f@gmail.com>
References: <20260509-mips-octeon-missing-insns-v2-v4-0-d669dcd05c2f@gmail.com>
In-Reply-To: <20260509-mips-octeon-missing-insns-v2-v4-0-d669dcd05c2f@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
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

ZCB zeros the 128-byte cache block containing the base address.

Model the user-mode-visible effect by aligning the address down to a
128-byte line and storing sixteen zero doublewords to guest memory.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v2 -> v3:
  - Split ZCB out of the combined Octeon arithmetic and memory
    instruction patch.  (requested by Richard Henderson)
---
 target/mips/tcg/octeon.decode      |  3 +++
 target/mips/tcg/octeon_translate.c | 24 ++++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index d77717cd50..d8a1bfce77 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -49,6 +49,9 @@ SNEI         011100 rs:5 rt:5 imm:s10 101111 &cmpi
 SAA          011100 ..... ..... 00000 00000 011000 @saa
 SAAD         011100 ..... ..... 00000 00000 011001 @saa
 
+&zcb         base
+ZCB          011100 base:5 00000 00000 11100 011111 &zcb
+
 &lx          base index rd
 @lx          ...... base:5 index:5 rd:5 ...... ..... &lx
 LWX          011111 ..... ..... ..... 00000 001010 @lx
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index 2a3f502e1f..794c8f033b 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -179,6 +179,30 @@ static bool trans_saa(DisasContext *ctx, arg_saa *a, MemOp mop)
     return true;
 }
 
+static bool trans_ZCB(DisasContext *ctx, arg_zcb *a)
+{
+    TCGv_i64 addr = tcg_temp_new_i64();
+    TCGv_i64 line = tcg_temp_new_i64();
+    TCGv_i64 zero = tcg_constant_i64(0);
+
+    gen_base_offset_addr(ctx, addr, a->base, 0);
+
+    /*
+     * QEMU models ZCB/ZCBT as zeroing the containing 128-byte cache line
+     * in guest memory.
+     */
+    tcg_gen_andi_i64(line, addr, ~0x7fULL);
+
+    for (int i = 0; i < 16; i++) {
+        TCGv_i64 slot = tcg_temp_new_i64();
+
+        tcg_gen_addi_i64(slot, line, i * 8);
+        tcg_gen_qemu_st_i64(zero, slot, ctx->mem_idx, mo_endian(ctx) | MO_UQ);
+    }
+
+    return true;
+}
+
 TRANS(SAA,  trans_saa, MO_UL);
 TRANS(SAAD, trans_saa, MO_UQ);
 TRANS(LBX,  trans_lx, MO_SB);

-- 
2.54.0


