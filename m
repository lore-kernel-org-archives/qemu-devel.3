Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5760DCD98E7
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 10:06:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZQg2-00053w-Ls; Tue, 16 Jun 2026 06:05:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQg1-00053l-LC
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:05:49 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQg0-00031g-7G
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:05:49 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-c8857a27041so1310858a12.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 03:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781604347; x=1782209147; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X4B+aHlqcdcQ0gYgRNV2P70NiclZXv+GhgRjLV9/FOQ=;
 b=S4eXBup+ua40ZgjmUnqfrqPBoPyecEsxk1mN/dIuVowkWIJD9AThVf1jgxZe+oLC85
 KnBGTnttcVSzBQsRLGKe3CZKt/mrCtaHsWvJaIIdY2mWCJuKD/w/ZFnALp0uVjCSpjd1
 GFuGWznWPjYfNWCkLMQoZq+9QdlA71UcdyUMt/cmDV9ZKb09Wm/gr/8Ei64FZf+NpR3g
 jvzQC+C1SkO7fHwl87KhYFu/xGVgiW/Gxi3E+y3iTPq84B9OPJ/aMbjmAh1iuDV2X2sW
 fd6TuRzl5jrohs7gQgLci5viRX41BucxzvxeCuGoaAwO5Efx2Slnyqa/ILUSxhc0SHIE
 yi2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781604347; x=1782209147;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=X4B+aHlqcdcQ0gYgRNV2P70NiclZXv+GhgRjLV9/FOQ=;
 b=OjyqPFjrUz5Nx3DYjmSoNknOMS5yJsKZTKCYM4YNjbo3lXmpDqhMLsQGYZKKsWHbWV
 hU8h+w73TzeHeCHcSKrFcYU5mNemr/88esvQoM/JzTDelsk/NQ3uLCC0YasiHFpMGJ1r
 zX/M1h6GBs/5s4WG6WJkmzCSj7J/rzPtOfpRkspyJsErJJ7pqx3g4AbJtm03mxQYlTVB
 dVwZJ6yMp5sRbbgRniXVRBLOBZy7O+vFSh9V9BTS8QUwc0f78U1dZFWrGbuQga3RPQgB
 tVDVm1PxTzR3lCjrA6D/UX7W0p2PqcwGCwoG24wXay+TMy9HRu4ByZ8mFJfRzPGXXZ7l
 XO8w==
X-Gm-Message-State: AOJu0YzQnu7eblGXVb8pcayPy5iBdlvmm1JMBoHRd8xfVidgMM9MTkSw
 Xz4XKjffCS3VQXUOUzFRHoahMPeBD4antGhypQPlDniAgsYF6qMnaiQ1WBYbuSBE
X-Gm-Gg: Acq92OG7eoMcmtJL/6Fmsii+1TEh//OBMGrF5tbeUt4Rs7dVEQhdKfGCN0krP3cyYeS
 U9YY+0gltJLcDWKICNvhgz72rL5nbGJAWiwfy9ts6iBvlDvrTlTWAgDmPpQOfK1pRw3xtpNCXAC
 b3j6cJ8YRlFN5pbpJgQ09UyhMvo/VtcM6LR1autCzFuq4R8MP/xGsrD3PKa77zrTLc6WhqfiW8o
 lcNxF716uSDBjA27dSpIy1uwcx4BMslpe8ij4mzWmXHcOWagi5VI3R27Bo/TWbDeY2oD2OlV0YG
 Xaxo3djO+I40pboR7GeMsUJ5MeJKBobDtwUdR7nUPLYVqV7ZVTwdpwoUVzX4nRVG31biwnRRrRD
 e32ZVuoDbd7qIaHt+T024AzbmDlvBglxjar+0Xu6DEOlPbRhxijKY5kYYsx4fLp/W4Dv655IiDL
 NM+ijpQIvWoy/uTjyvyekisDxo4VMviaPfxoaRry2M
X-Received: by 2002:a05:6a20:734a:b0:3b1:884a:c3d5 with SMTP id
 adf61e73a8af0-3b79637d3c3mr16273420637.24.1781604346770; 
 Tue, 16 Jun 2026 03:05:46 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c866519f0a6sm10916735a12.22.2026.06.16.03.05.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 03:05:46 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Jay Chang <jay.chang@sifive.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 03/83] target/riscv: Improve PMP address alignment readability
Date: Tue, 16 Jun 2026 20:04:06 +1000
Message-ID: <20260616100527.1939565-4-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616100527.1939565-1-alistair.francis@wdc.com>
References: <20260616100527.1939565-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x532.google.com
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

From: Jay Chang <jay.chang@sifive.com>

Replace manual bit manipulation for better readability:

- TOR: Use ROUND_DOWN() to clear lower bits
- NAPOT: Use deposit64() to set lower bits

Signed-off-by: Jay Chang <jay.chang@sifive.com>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Message-ID: <20260520063606.36600-3-jay.chang@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/pmp.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
index 8adf7c9719..58a8923d0d 100644
--- a/target/riscv/pmp.c
+++ b/target/riscv/pmp.c
@@ -247,8 +247,9 @@ void pmp_update_rule_addr(CPURISCVState *env, uint32_t pmp_index)
     case PMP_AMATCH_TOR:
         /* Bits pmpaddr[G-1:0] do not affect the TOR address-matching logic. */
         if (g >= 1) {
-            prev_addr &= ~((1ULL << g) - 1ULL);
-            this_addr &= ~((1ULL << g) - 1ULL);
+            uint64_t granule = 1ULL << g;
+            prev_addr = ROUND_DOWN(prev_addr, granule);
+            this_addr = ROUND_DOWN(this_addr, granule);
         }
         if (prev_addr >= this_addr) {
             sa = ea = 0u;
@@ -641,13 +642,14 @@ target_ulong pmpaddr_csr_read(CPURISCVState *env, uint32_t addr_index)
         case PMP_AMATCH_TOR:
             /* Bit [g-1:0] read all zero */
             if (g >= 1 && g < TARGET_LONG_BITS) {
-                val &= ~((1ULL << g) - 1ULL);
+                uint64_t granule = 1ULL << g;
+                val = ROUND_DOWN(val, granule);
             }
             break;
         case PMP_AMATCH_NAPOT:
             /* Bit [g-2:0] read all one */
             if (g >= 2 && g < TARGET_LONG_BITS) {
-                val |= ((1ULL << (g - 1)) - 1ULL);
+                val = deposit64(val, 0, g - 1, -1ULL);
             }
             break;
         default:
-- 
2.54.0


