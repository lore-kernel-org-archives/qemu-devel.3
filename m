Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 101ABCD5BA4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 17:26:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPkg1-000674-4c; Wed, 20 May 2026 13:25:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPkfP-0005Up-AP
 for qemu-devel@nongnu.org; Wed, 20 May 2026 13:25:12 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPkfN-0003z5-J5
 for qemu-devel@nongnu.org; Wed, 20 May 2026 13:25:11 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-43fe608cb92so3240597f8f.2
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 10:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779297907; x=1779902707; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BlLILJuNVzFhKiWonsN2HjkYb3yN+UaikzR8tXjAlhg=;
 b=dzaInAGyon/ByKnrPK6OGgIRl2hoFZ10RgvkuMJB57v0hdDaoj+g3X7uKq4BYcak5w
 gzhpv2Djl9GgTgr06rUoY9nJdMRZceP/VDkuIiSyHvtTkm4czDbLEpHWCi6vCPxsGvIU
 trHg5UiYNMx5YX0wQuR6meQfDA1Zy1rVPWxmlSgCQadpU2NoBSU2HFQdZ3TWUgnoJ1ax
 1eswROTlfj8qKdUD8DWmf1oMlhjfJ4tjsi+Dkd55od5yrBkNYKu5TNhMrXU3Ue4JN0pQ
 X2Q2J6shAMEiYGf74YfntT8sYD3+YBejhmL2wBYDm4pBUIALK2YfugcETBNTkN04cKkW
 UFdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779297907; x=1779902707;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BlLILJuNVzFhKiWonsN2HjkYb3yN+UaikzR8tXjAlhg=;
 b=X2lb1XV/fX0kbH9JBA5/+rQ4BJVGFYMPqE3L61UPkB2i1J1VfZwn+oyxvXOquSTbVS
 836WRPxx/nYg9K7emm+W6FfUFQpwqMgQlBJmuK+Pef/GmFQjw6iu+R5SyGNqv5f/p9hl
 3obQ5yRwmQu+KTHEh8/berKIPixgqpDgKNce1kSORKsHuMVw9emzjSwEV8z6pANr/dB5
 pmb8XczitFwVf8Z1dm11jJY3b0cLW9X7sPnmTWFbkrbld7F+YiDbJRUWH2IziKjNO8Uu
 IghLvEM5naUbiFPzJ5nllhz2A0iO40Sx73/rjmxlIU8koXKOQ27kXqXN3rkiMJOx8iVe
 Tclg==
X-Gm-Message-State: AOJu0YzeHCqJJdKO8KhcmZQ+/PPz8ptDcyiHGYoix7TPNoVvoxG8FL98
 reQJ5gZhEkq90kvPbkPVuux9BSBOX72UU/+6IHrEqvwkN56/bw5ZSr3ytixO2dDK2IXqsj/2bnd
 nPd72s/g=
X-Gm-Gg: Acq92OH7prBwr+2gZ+ZCoLvVAdk0rSSOdZuZbm4NeUPkiXYzMyPL7rw8katIdmQte8Q
 6MpwWfilDbFcb1swk//2/AUN/DtjsSFts+ZHsghKp3G+x4E85JC4hFwYZeAUpydMn+ZK9k4lfOl
 pufOH3BiIQdCft506OxrNlOv/9Uwm6rT0uwcIE8HOqeX3VtRjLS7zuFLYJeBQB4+zzXz7JRqhAo
 qXAhmD3o4imbaH7dxdp7zFqfFWqPAm9E/NWaNSk79/3vXe6JMugG8iRdDDeVud3MaxvzqOE7WAQ
 xfx9KHGgofTPtPWstTsHE7BbcfnajqJaNfjH57DH0kJ1nJDHwkXxEQooD/MlusufhCNu5Z25v6T
 hVTVBNySag4SBzgdZwFBxBqbjil6+emJcx4hm6ktmfldD7ONp7bWUELz3BUpD8QdlvthHeoH0LY
 h2M8dV/ToZ8q8/A5QVWl49rIMSFPT4w2cSY4ubxKkZTPt+Kv2kxXjTvMGb0MtGQNFZNxStXuzu
X-Received: by 2002:a5d:5f44:0:b0:45d:3a84:709c with SMTP id
 ffacd0b85a97d-45e5c5ccac2mr40385971f8f.31.1779297906823; 
 Wed, 20 May 2026 10:25:06 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da0a19b1dsm55057086f8f.17.2026.05.20.10.25.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 20 May 2026 10:25:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: James Hilliard <james.hilliard1@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v12 15/24] target/mips: add Octeon ZCB and ZCBT instructions
Date: Wed, 20 May 2026 19:23:03 +0200
Message-ID: <20260520172313.23777-16-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520172313.23777-1-philmd@linaro.org>
References: <20260520172313.23777-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

From: James Hilliard <james.hilliard1@gmail.com>

ZCB zeros the 128-byte cache block containing the base address. ZCBT has
the same user-mode-visible memory effect for QEMU purposes.

Model both forms with a single decodetree wildcard entry, align the
address down to a 128-byte line, and store eight zero 128-bit chunks to
guest memory.

Acked-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/octeon.decode      |  3 +++
 target/mips/tcg/octeon_translate.c | 25 +++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index d77717cd507..01ed3b50beb 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -49,6 +49,9 @@ SNEI         011100 rs:5 rt:5 imm:s10 101111 &cmpi
 SAA          011100 ..... ..... 00000 00000 011000 @saa
 SAAD         011100 ..... ..... 00000 00000 011001 @saa
 
+&zcb         base
+ZCB          011100 base:5 00000 00000 1110- 011111 &zcb
+
 &lx          base index rd
 @lx          ...... base:5 index:5 rd:5 ...... ..... &lx
 LWX          011111 ..... ..... ..... 00000 001010 @lx
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index 23748695a14..5392fed08a8 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -184,3 +184,28 @@ static bool trans_saa(DisasContext *ctx, arg_saa *a, MemOp mop)
 
 TRANS(SAA,  trans_saa, MO_32);
 TRANS(SAAD, trans_saa, MO_64);
+
+static bool trans_ZCB(DisasContext *ctx, arg_ZCB *a)
+{
+    TCGv_i64 addr = tcg_temp_new_i64();
+    TCGv_i64 line = tcg_temp_new_i64();
+    TCGv_i128 zero128 = tcg_zero_i128();
+    const MemOp mop = mo_endian(ctx) | MO_128 | MO_ATOM_NONE;
+
+    gen_base_offset_addr(ctx, addr, a->base, 0);
+
+    /*
+     * QEMU models ZCB/ZCBT as zeroing the containing 128-byte cache line
+     * in guest memory.
+     */
+    tcg_gen_andi_i64(line, addr, ~0x7fULL);
+
+    for (int i = 0; i < 8; i++) {
+        TCGv_i64 slot = tcg_temp_new_i64();
+
+        tcg_gen_addi_i64(slot, line, i * 16);
+        tcg_gen_qemu_st_i128(zero128, slot, ctx->mem_idx, mop);
+    }
+
+    return true;
+}
-- 
2.53.0


