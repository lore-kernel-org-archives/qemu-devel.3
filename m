Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E95C5C5DF94
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 05:55:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyNc3-0007Ur-3y; Mon, 24 Aug 2026 01:52:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNbg-00064W-V0
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:52:28 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNbf-00038R-7Y
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:52:28 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-c9cf07d2df6so1891524a12.2
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2026 22:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787550746; x=1788155546; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sVV9c8S04txxWkCEX8+hRViSARQ6uNL7zv3RnJ4UqLs=;
 b=Uk8baWBXhdA06Bazqz6By/dm/koddKL4GHyjnoSlIBkJkb4L7gLZGPbHT9UeAxawWH
 2XJJDhwopkiyEFrPkrto3T+/RROO2t6rtRxirIKUK6n5mhDcO9UU2tqA7IQdlEmJWBGq
 IGgZ+b+SlrXM9Ps0Yq6Zfowttye7RMlW0CQL1DJi4D7w33GPaIZsla4L9fC7qklNQdtZ
 hydgZFaWLvjg6DgF/5QoWi6d1OGcmh3YwV7cjvAeSDIg+j0j7E+/9gwmKb0q4/AuTRQW
 P7/z0Yx3Hv/iNveOkHCTWPzMjuHiw2V4YlAJoqmNOPT7+lq6OH1WKx7Y2AsKIDnOKFcO
 h0Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787550746; x=1788155546;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=sVV9c8S04txxWkCEX8+hRViSARQ6uNL7zv3RnJ4UqLs=;
 b=FWq+B+Ula7NML68UL0up4zV4RIYWlOSRR2PmuFwc2aRCD9iJU70Rshzvu9yjGZuVtJ
 u3fbWSzkcSaL7eSDVECDflU0Kova3BUvQeFX/PsZH8XpAfox543tIXXginD2mVTx3ZJZ
 RbTX8kEMF2eLArtUFm9rPjDcal8nLXQWNtT6Odc2VS+zRBh7NOyZCBPmBSCWyKSZCdgp
 3D7RESuUJdJGranPCSOsr7WhDDrY+EkrNMhw0sqBj1oJtvYVENlHc1fElJK5DQ/Gnm5I
 6QefnYNplK059kZaUZsNeDkOx+1SNZslB5vBcNZ2/Gue27gYH2BFjAN4X2UkrwPAtyTF
 wiWg==
X-Gm-Message-State: AFuF++mpjQMbRx9dkA1pIjoW815EbYqWyDA1mtF2KoEeBiuTlplVWu97
 CGMg+OIjJkXklpQHznbhEwBeQKQ7psVHOUBk8Ruaww6i21Yr9z8RkOTRd9yMpQ==
X-Gm-Gg: AR+sD1025poRW8K+0NW87+OLY/lDrXddVAckAEL8EEVX1oc9Q2+0DdHtnNHA1v42Alm
 2hDnduAN1UnoRhLiegRmY74t8FNqh3dF6DkSf13yZij2yxWn20NthlbUEF2BrrbEkbPUuE6sCfz
 th15KNvRM41MIiTkvwcmwbRhJyS96U04ZHv5B97zZucri7fMrK0NYc48E+67Dr81jNDvruOv87T
 Ikp5MA05DI45iikibQEYG/NvW11aFFkv6RK0V00P+I7KaBppASg7Da317nKbCByNJN+xGoCzqyq
 L1nCvuvF9eRjbSBK7a91vgqLCFryfZkYHULaQVkx323lakvKPrmTunjhtEn7qLgwBpv+L4PDW8x
 kDjY8NT6qI+YvwWsPjD+4GC00LeI9CohLVl0OpChQV51UGbLteLDPEWkcR0Thp6EVUDsLNnatye
 LGigMaZ/3CS+AbTh41pIHcp2FaOk1wnNad96B9LczAJpsIAdVdGjq7IVzeZ4rNApOqTa6uU5Jnb
 VJtbrk=
X-Received: by 2002:a17:90b:1e0d:b0:395:4e0d:bc60 with SMTP id
 98e67ed59e1d1-395c354d7ebmr36095549a91.9.1787550745830; 
 Sun, 23 Aug 2026 22:52:25 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395c917d2f2sm4046005a91.3.2026.08.23.22.52.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2026 22:52:25 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 82/96] disas/riscv: Tidy decode of c.mop.n
Date: Mon, 24 Aug 2026 15:47:52 +1000
Message-ID: <20260824054806.2790041-83-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260824054806.2790041-1-alistair.francis@wdc.com>
References: <20260824054806.2790041-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x52c.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Merge nested if's.
Reuse operand_cmop_imm for zicfiss decode.
Return pointers directly.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260812223142.349142-50-richard.henderson@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 disas/riscv.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index 39235e5bc7..197eaa43b1 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -1027,18 +1027,17 @@ static const rv_opcode_data *decode_inst_opcode(rv_decode *dec, rv_isa isa)
             break;
         case 2: op = rv_op_c_li; break;
         case 3:
-            if (dec->cfg && dec->cfg->ext_zcmop) {
-                if ((((inst >> 2) & 0b111111) == 0b100000) &&
-                    (((inst >> 11) & 0b11) == 0b0)) {
-                    unsigned int cmop_code = 0;
-                    cmop_code = ((inst >> 8) & 0b111);
-                    op = rv_op_c_mop;
-                    if (dec->cfg->ext_zicfiss) {
-                        op = (cmop_code == 0) ? rv_op_c_sspush : op;
-                        op = (cmop_code == 2) ? rv_op_c_sspopchk : op;
+            if (dec->cfg
+                && dec->cfg->ext_zcmop
+                && ((inst >> 2) & 0b111111) == 0b100000
+                && ((inst >> 11) & 0b11) == 0) {
+                if (dec->cfg->ext_zicfiss) {
+                    switch (operand_cmop_imm(inst)) {
+                    case 1: return &rvi_opcode_data[rv_op_c_sspush];
+                    case 5: return &rvi_opcode_data[rv_op_c_sspopchk];
                     }
-                    break;
                 }
+                return &rvi_opcode_data[rv_op_c_mop];
             }
             if (inst & ((1 << 12) | (0x1f << 2))) {
                 switch ((inst >> 7) & 0b11111) {
-- 
2.54.0


