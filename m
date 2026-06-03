Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E71FCCD6E69
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 07:02:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUfZr-00043L-0d; Wed, 03 Jun 2026 02:59:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wUfZq-00042s-58
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 02:59:46 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wUfZn-0006JG-U1
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 02:59:45 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-c85a2c012e5so1279334a12.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2026 23:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780469982; x=1781074782; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Um1wNfEyOn+CLsAN3bGCGaLdUDTDYM3VplZ4E9baFZ0=;
 b=VOPV2Yc2EDNuYKBnwQyJGEwH9LvDtVF9BOVcLQBpXIMSR3iWGW5wHy8jUGzX1KnPn1
 9P/I1+nXuiH2EPgfQWX8uDiHIlZhRxhl7QRX4jh6MAE3y4GH9aHobZx8H6uywGlBc9/R
 6Xs9pOmtAJKg9ksklvQcELHLqUnA0cUnwPtrcHB2nElBtJnIGPVunojEFGU8J04JW6gN
 r+Z2ETmiI48g6svOVtKQFlX7KyFcH23vrWu2gZ6Muf/kPKP5ACT505LTgXQop0ozo/8n
 8W8JiapXNcVjROQ29Pz9Hd8TkFwBrb3KSDmXbD5ewRT0UpOj/008owAQ+zMZCh0jnu3p
 yQ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780469982; x=1781074782;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Um1wNfEyOn+CLsAN3bGCGaLdUDTDYM3VplZ4E9baFZ0=;
 b=EGb9bBMwCcqsOqz7kjIKaeB2TxzZ/EK/145Jc1/3u7mth0/RIVEKIDDmleGVLykgEP
 hoivllSmNs3CuErnpHJk2pKdnmW0hz1j7lWfMKSbA5gJRTmeJtkwOG3iTSrm7PfamXTP
 hmD3pmDUSPxYJ7vF2EKyRs+jW4xpqD0fYsAjUiC8bMT8RHc0g7qckAezP9d8apNoYzVe
 tgFcOSEcsqKOEMDd3decqdSc640MhaRoHrTpyk3Mcs+P6+5tKU1NslESH4V/EscXAa/+
 yAvqTWESv5hLO5lgoFg4DwJ4cmfgE+/AQgZDcGjS46E02ea251vOfMpBG9ROcPZHy8hN
 197g==
X-Forwarded-Encrypted: i=1;
 AFNElJ8hJifT9TYkA9Bj6uUJeePLfNrHBxBdJKxJWtpHtsERPB2HfyTwwgxaE/lzxlecaH21uA3f4VRGm7Nl@nongnu.org
X-Gm-Message-State: AOJu0Yw1ZDR6tMFDFZbBGZI/IMAdtCLLV3MkyK8ms+ffFXVKOO2IPK8Z
 hxHG4ORZjhe9+cQ1LcA5sr+InFQb72ouY0LFYALHe6vSanPkC7Ggn2WX
X-Gm-Gg: Acq92OHKy2xR1mnnBT5w7abiYEKuaodDD7ORCzmPubaG5QfV/r1Vxs7Fmx7tcQj37bP
 +VHjCmeqjoNU4+oRWhQdp2P1tZR7IvazsZbPh7uX9Ndcy/wu76vcHa6/pr3Mjq2YCkB0DMKBi1o
 F41Ci0og2hiB0tblE4A5WWrfTqPkGySnP6pHyftGW9u0S61ZLq/XwXqKnxyrTgUydcXQ2HN9QPR
 Pd4dJkRZvcQmazJWlrLKNwum8/etEmBEzXvgWcy6d/rKqPopjYaCv+QX1yulZv54+kchstE+zut
 9wJAlOKRLs/tSZdPesT3pIo+BhC1YhEriIYUhsuE2IJ8cKIDXnvNBn6LIFGz2ffTTqjjhUxkbxb
 Ykq+lx6ghg2W3JTrlQUXl+H5J7TGffx9QilmcyE5d7h0WTKqwvBG1m+r2AjixmMneEi0Xn6jNdA
 iJIVwvhdgU/W+gzpK3r5cdOrUBfXlv3BYiw9qF1M6gAhiYfXxIL1OXTQ9CRWEN+KyVPsPvKCMOT
 ww7oY5mxVVad3mituDegu37SLxB/fqLgGqTg0F5adS3oCYo1d/0/kV2I1qPJRKm
X-Received: by 2002:a05:6a21:6b17:b0:398:7ffe:472f with SMTP id
 adf61e73a8af0-3b4976a6c4emr2501132637.2.1780469982314; 
 Tue, 02 Jun 2026 23:59:42 -0700 (PDT)
Received: from donnager-debian.. ([45.124.203.15])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c85df033887sm1283261a12.2.2026.06.02.23.59.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 23:59:41 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: Alistair Francis <alistair.francis@wdc.com>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Andrew Jones <andrew.jones@oss.qualcomm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Michael Ellerman <mpe@kernel.org>,
 Joel Stanley <jms@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Portia Stephens <portias@oss.tenstorrent.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH v8 05/12] hw/riscv/aia: Configure stride for the M-mode IMSIC
Date: Wed,  3 Jun 2026 16:28:49 +0930
Message-ID: <20260603065859.592063-6-joel@jms.id.au>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260603065859.592063-1-joel@jms.id.au>
References: <20260603065859.592063-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=joel.stan@gmail.com; helo=mail-pg1-x530.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

riscv_create_aia() currently hard-codes the M-IMSIC at one 4 KiB page
per hart and gives callers no way to widen it.

Add an m_imsic_stride parameter that supplies the per hart byte
stride directly. The virt machine passes IMSIC_HART_SIZE(0)
(= 4 KiB), preserving its existing compact layout.

The parameter only changes how the slots are spaced, with the rest of
each slot reserved. This allows future platforms that have different
layouts to control the stride.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 hw/riscv/aia.h  | 1 +
 hw/riscv/aia.c  | 3 ++-
 hw/riscv/virt.c | 1 +
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/aia.h b/hw/riscv/aia.h
index 5ad0a902be0d..452e78b9d7ad 100644
--- a/hw/riscv/aia.h
+++ b/hw/riscv/aia.h
@@ -14,6 +14,7 @@
 uint32_t imsic_num_bits(uint32_t count);
 
 DeviceState *riscv_create_aia(bool msimode, int aia_guests,
+                             hwaddr m_imsic_stride,
                              uint16_t num_sources,
                              const MemMapEntry *aplic_m,
                              const MemMapEntry *aplic_s,
diff --git a/hw/riscv/aia.c b/hw/riscv/aia.c
index 82ea9d48ea75..840f84d26b98 100644
--- a/hw/riscv/aia.c
+++ b/hw/riscv/aia.c
@@ -25,6 +25,7 @@ uint32_t imsic_num_bits(uint32_t count)
 }
 
 DeviceState *riscv_create_aia(bool msimode, int aia_guests,
+                             hwaddr m_imsic_stride,
                              uint16_t num_sources,
                              const MemMapEntry *aplic_m,
                              const MemMapEntry *aplic_s,
@@ -47,7 +48,7 @@ DeviceState *riscv_create_aia(bool msimode, int aia_guests,
             /* Per-socket M-level IMSICs */
             addr = imsic_m->base + socket * (1U << IMSIC_MMIO_GROUP_MIN_SHIFT);
             for (i = 0; i < hart_count; i++) {
-                riscv_imsic_create(addr + i * IMSIC_HART_SIZE(0),
+                riscv_imsic_create(addr + i * m_imsic_stride,
                                    base_hartid + i, true, 1,
                                    num_msis);
             }
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 4cd941a6aac6..529bb2fc0132 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -1549,6 +1549,7 @@ static void virt_machine_init(MachineState *machine)
         } else {
             s->irqchip[i] = riscv_create_aia(s->aia_type == VIRT_AIA_TYPE_APLIC_IMSIC,
                                              s->aia_guests,
+                                             IMSIC_HART_SIZE(0),
                                              s->num_sources,
                                              &s->memmap[VIRT_APLIC_M],
                                              &s->memmap[VIRT_APLIC_S],
-- 
2.47.3


