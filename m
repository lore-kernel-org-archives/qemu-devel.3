Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E132C606A90F
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 13:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=AYNhszeg
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNsEP-00069f-F7; Mon, 02 Nov 2026 08:37:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNsDD-0003OD-PC
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 08:36:35 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNsDC-0002Kb-0e
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 08:36:35 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-48df54150dfso1386455f8f.0
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2026 05:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793626592; x=1794231392; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=/2SrWZg7LL1ZwpuOyRIqi3zRSq3vmKujN0kG0k7wCts=;
 b=AYNhszegH+o9CnYT9+whuoG1fbxaTnb8dXL6mv1yRiPqvwFF8VqSkTLRHIWiXusIFD
 y3fqbTeWBu+AGX5LQQea3iH7wT9hBR5j4jUgfouD9ERl/l3GANVQYecxds+wJTz/GXJh
 /pOn5BRggqACykKsc+OZRFE14wjQ/GVodE+BLFP4NeAEjAcl/eNVMM7b8GfWc3wji14K
 av9gzvxkB+jXyYqybAAwr7DuWpRvVElpidrwC5eTkYnb8FaKbM/HIJVBkvIaKL7scLxg
 3ZPfG9M+KaDn0VpUf9gpXjALUuB/oHwvgKB+04gcOBFxjw1pwjB/YvbCSV7/rUneNa16
 HvFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793626592; x=1794231392;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=/2SrWZg7LL1ZwpuOyRIqi3zRSq3vmKujN0kG0k7wCts=;
 b=WWk5/FmYFICx4EihRz+r239pe1eR2Tpsy4MQg5/f1mgnmAaivkxqyIFO4o4hiGS67t
 GmoM6yaWBPfcf0NhL5PfewFxFthwD6/uqJo5YOYEGYc01gzBS9/3B9oylbdjIGS7q2G0
 fvpvdg7pj9JwSb/X8aUTjmTugeloH58qd4lFIDnOfuNCfH1X1OXr0cm2/cY8Ppd1Zv3R
 DPvDKMRQgf9p8Ob6g1J736siCSJhuTVc8DA8gXD3gysE2b1qzD4x0YsDfJqpxPNgPwbJ
 0F8FG24ui2+z8BJGSPv71VZ9rPNe+s59NSIkjxqh7xfulSzbrXJFLF/b6JXrLXQjAICC
 8Taw==
X-Gm-Message-State: APuU4Z8aMCDVyVVKzeP34dQsLf+wIhtWXF4scHOobg+cDcZyIe0qxgBd
 K7YB/DHAo4bZ0hV63hsAFEqYtgodV9LTatIAtNjOyjyP9tQml/qjRxK1ifJX5Ghzws3laMs2oXm
 M1XHLKGo=
X-Gm-Gg: AYBFou2sLTrG54Gx2A/8mUW5K+20Zwl1Ad/4qIDGeXLyBNZmqqrmzrc1/YRgzSRLW2B
 OAKC6tgkVjYfUwNsTo2X3WrzpdDCIIa5f8g1/Ky3TNHzKZGna48G/UwUgAYDzp5SVR1SnDraM0Q
 NJtcjgBb6TZxzsYpIUhLGVCwatn271ZjRZYwRhe5PUNxKf0QV8DKb0XY05w4+pFC0PBge2GS3zO
 YJIIyQ0r68PcuaWgOjX/pOiVRHucl7bjNz7AZSjd9A2mmd88EHRlqrngMEdVL0X5nQzwpczignH
 3f1r5C7+rCW1ukypya5xPmsiuevh0Tj59UJjE37RTINqeyOdmvtKR93UHHzjigZfM2gdfhgm8UC
 nz4mCRJFUvNbPLpMMZWVdY5BoOA1OXeQ+57m97/y6IRFtkVDRmJgIjeP4enUy4m6ExcYa0kGRAg
 PjgZjd3iSsdlhrgTqguavb383KWurw72S+zvkK7DVl6a45ZGHhFez8LQxb0xazzs46h4U1R9pD0
 vfdv1xrken8ITvhlABtfOJPmK7yCmcFlmfz6ASEJ9Kb01uV9Ph8zR5Lq3B+3RQ33aYVqullNbBQ
 xWzjGsgVTYR2AINNkFDUwc1uBhM+tvMYAkHtZDbVVCHk2+qaqAKGxyzShVzTZJ+6Nz7cJFct70j
 OVM1rNkZjfxu6nqtMIBMPvCTQYsXBwb1qgA==
X-Received: by 2002:a05:6000:468f:b0:48e:6710:ecd8 with SMTP id
 ffacd0b85a97d-48e6e2fcdb9mr13828226f8f.26.1793626592308; 
 Mon, 02 Nov 2026 05:36:32 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71a4d3e9sm22556760f8f.6.2026.11.02.05.36.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 05:36:31 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 38/47] hw/intc/arm_gicv5: Ignore low bits in IRS_IST_BASER.ADDR
Date: Mon,  2 Nov 2026 13:35:38 +0000
Message-ID: <20261102133547.1375701-39-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102133547.1375701-1-peter.maydell@linaro.org>
References: <20261102133547.1375701-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The IRS_IST_BASER.ADDR documentation says:

For IRS_IST_CFGR.STRUCTURE = 0:
 Bits[N:0] of the resulting address are 0 where N depends on the ISTSZ
 and LPI_ID_BITS fields in IRS_IST_CFGR as follows:
    N = Max(5, (ISTSZ + 1) + LPI_ID_BITS)
For IRS_IST_CFGR.STRUCTURE = 1:

 Bits[N:0] of the resulting address are 0 where N depends on L2SZ,
 ISTSZ, and LPI_ID_BITS in IRS_IST_CFGR as follows:
    N = Max(5, LPI_ID_BITS - ((10 - ISTSZ) + (2 * L2SZ)) + 2)

This enforces that the IST is aligned to the size of the IST table,
or to a 64-byte boundary if the table is smaller than 64 bytes, even
if the guest programs the low bits in the ADDR field to specify an
insufficiently aligned address.

We were missing this check, and instead trusted the guest-provided
address to be sufficiently aligned already; add the alignment
enforcement.

The GICv5 spec defines the masking to be used with the expressions
quoted above, which work with the raw field values from the
IRS_IST_CFGR register; these simplify down to some straightforward
expressions based on the sanitized values we've already extracted
form those fields.  You can get to the expressions we use here either
by working through the simplification of the GIC spec expressions, or
from first principles (the number of bits needed for the size of the
table in bytes is the number of bits that index it plus the number of
bits specifying the size of an individual table entry).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/intc/arm_gicv5.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/hw/intc/arm_gicv5.c b/hw/intc/arm_gicv5.c
index ebfb0878af3..3c50238634e 100644
--- a/hw/intc/arm_gicv5.c
+++ b/hw/intc/arm_gicv5.c
@@ -1313,6 +1313,7 @@ static void irs_ist_baser_write(GICv5 *s, GICv5Domain domain, uint64_t value)
          */
         GICv5ISTConfig *cfg = &s->phys_lpi_config[domain];
         uint8_t istbits, l2bits, l2_idx_bits;
+        int tableszbits;
         uint8_t id_bits = FIELD_EX64(cs->irs_ist_cfgr[domain],
                                      IRS_IST_CFGR, LPI_ID_BITS);
         id_bits = MIN(MAX(id_bits, QEMU_GICV5_MIN_LPI_ID_BITS), QEMU_GICV5_ID_BITS);
@@ -1359,6 +1360,33 @@ static void irs_ist_baser_write(GICv5 *s, GICv5Domain domain, uint64_t value)
         cfg->l2_idx_bits = l2_idx_bits;
         cfg->structure = FIELD_EX64(cs->irs_ist_cfgr[domain],
                                     IRS_IST_CFGR, STRUCTURE);
+
+        /*
+         * Bits [N:0] of the base addr are ignored, to enforce that in a
+         * 1-level IST it is aligned to the size of the ISTE array,
+         * and in a 2-level IST it is aligned to the size of the L1 table.
+         * The spec defines N in terms of the raw L2SZ, ISTSZ and LPI_ID_BITS
+         * fields, but we have already sanitized these to
+         *  istbits = ISTSZ + 2
+         *  l2bits = (L2SZ * 2) + 12
+         *  id_bits = LPI_ID_BITS
+         * We have also already enforced the "bottom 6 bits are 0" via
+         * R_IRS_IST_BASER_ADDR_MASK, so can skip the Max() operation.
+         * We want tableszbits == the number of bits to zero, which is N + 1.
+         */
+        if (cfg->structure) {
+            /*
+             * L1 table is indexed by the (id_bits - l2_idx_bits) bits in
+             * the ID, so has 2^(id_bits - l2_idx_bits) entries, and each
+             * entry is 8 bytes == 2^3.
+             */
+            tableszbits = id_bits - l2_idx_bits + 3;
+        } else {
+            /* table has 2^id_bits entries of 2^istbits size each */
+            tableszbits = id_bits + istbits;
+        }
+        cfg->base &= ~MAKE_64BIT_MASK(0, tableszbits);
+
         if (!cfg->lpi_cache) {
             /*
              * Keys are GINT_TO_POINTER(intid), so we want the g_direct_hash
-- 
2.43.0


