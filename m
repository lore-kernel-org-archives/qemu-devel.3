Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 702C6C5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 03:55:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwtim-0007y7-1S; Wed, 19 Aug 2026 23:45:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtij-0007gm-PI
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:45:37 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtii-0003xO-3s
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:45:37 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-38de840f2f0so1561305a91.0
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 20:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787197534; x=1787802334; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bEOIVZvOI6v3LMY4XYw/LCi0puozDvkVflYenuC6IF8=;
 b=N8qniS9hfMjt/5jAf7P23d6qgZKxZ3l0p3lbnY5IZ/fLmKrch1s4SRvkiNCBtHz8D0
 eIEJGBymGBiDwU9vJQN9q/O6VLBpxvfNti38TLlqqiEWiHWX0h2S6JeVrTTybQZK5ngR
 8WNhrrWljhrmPgUijgrpdtM+hbReJuxiac5RFFbxmIIR++ue7CV3yrWuQqmd5ydi1rD+
 XASWwkWHzLPGr+8zqLbjYNjHU95MJDW7pXc0okEP3Uje3uCzAm2h29W1xLkUIAhhesqL
 yg/CGPAtSEPOLZHMZCaGMHw25FfJpZ8ptBHZtE1dt5vc1dusLRamyP2Tq1Cd7rJ/lDx5
 p/Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787197534; x=1787802334;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=bEOIVZvOI6v3LMY4XYw/LCi0puozDvkVflYenuC6IF8=;
 b=RZbjb+FwHIdfTIfRDVv6FPTXJdbB8xilWI2lz4OW+fuhXZ75SZ+YPiTzFw6p5Fc6s2
 rupBV/6RBE6gJoShP4L2ILbCksb3LUuN7f732JyCC8t+v64OJTx3b7O/0mIxY+2oSLrU
 IAoZAtLIWszi3b8nI4Uh282181i4cSBpN9FBoLGavMJBeNjurtD/czaJKI0HPy3UCnbC
 Bv+7fEXWs83dRTzOBxUOgVDcRxF3QQLGE5aigE1vlRe4QxA1YmFRTQAai4rzr03B+MWF
 qH5MwZpPfgIH16ZbgzDNs1rmURem5o7sW4I9mVkcxZHlJBNHdwnnUe55e7PnlBSq/roJ
 gMpA==
X-Gm-Message-State: AFuF++lZvKBhEUcdVAfV3624DQyfuGQpCi4N2zm2W7+/xKP01vfY+/E+
 /iyy9oWKGpJ4d4DKhRVIGonCan4iXbbYW426UR+d89XSwWmbAoHJylzRYVQv7w==
X-Gm-Gg: AR+sD13m8T4p9lEe3Q8OBpquE8AIPo8O8Wb3ozYcFuam24wcyS86iq18jjKWu5gzfCX
 seQbmDxbK/veCd64w2m0vEUcvHpTdtVJs/2J0HECnocbzQUpKx1DzyTPEfZY9Gj+nUy+tev04Zo
 40VFyT3fIiCwuJxh6RqvAMfYv+uh0gCgvhZGM3i/S6Q3XRSHMOoKSBSgELHcmdpwauncvpzBEd8
 G8qo7h0UIea4l1k72gmldyl3SKB3k/FA0FbGS8ZRfCv23fKvqf+w2Zy37aVyPRja6KCmyRLetNG
 kkZIAIjh2l+2kv4tpHp6SmIIaEDh0b+B8SpQMeO26nluI4valYv/SrfhMk5QlTWfK2AYIXh/H2N
 Ie51zf5oVjPFaWhrCYfeYs2PAzHlNfFKFAz94JeYpIXK15Ped00FT/6tsnBkTNvNPMRYtLMcms1
 tSVOrXIZPkeDBpMQp7MonhGWI6NdGXa2H3vLVsgQ3zw6J7Tup6/ULFY1tBWlPEpEeNLpiEEm807
 RECGw==
X-Received: by 2002:a17:90b:3c47:b0:38f:1a2e:6e56 with SMTP id
 98e67ed59e1d1-395813f4f3dmr18627022a91.9.1787197534557; 
 Wed, 19 Aug 2026 20:45:34 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1416ad6060asm19506735c88.6.2026.08.19.20.45.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 20:45:34 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Frank Chang <frank.chang@sifive.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 17/93] hw/riscv: sifive_u: Align ROM reset vector data
Date: Thu, 20 Aug 2026 13:43:14 +1000
Message-ID: <20260820034430.1186695-18-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260820034430.1186695-1-alistair.francis@wdc.com>
References: <20260820034430.1186695-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x102b.google.com
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

From: Frank Chang <frank.chang@sifive.com>

The SiFive U ROM reset vector data needs proper 8-byte alignment for
RV64 ld instructions. The misaligned load will cause exception when
Zicclsm is supported as SiFive U CPU doesn't support hardware misaligned
loads and stores.

Add padding to ensure start_addr and fdt_load_addr are placed at 8-byte
aligned offsets and adjust the load instruction offsets to match the new
data layout.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Message-ID: <20260810055618.1175500-3-frank.chang@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/sifive_u.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 99423ef472..57a57c96e1 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -564,19 +564,20 @@ static void sifive_u_machine_init(MachineState *machine)
         0,
         0,
         0x00028067,                    /*     jr     t0 */
+        0x00000000,                    /* padding for alignment */
         start_addr,                    /* start: .dword */
         start_addr_hi32,
         fdt_load_addr,                 /* fdt_laddr: .dword */
         fdt_load_addr_hi32,
-        0x00000000,
                                        /* fw_dyn: */
     };
+
     if (riscv_is_32bit(&s->soc.u_cpus)) {
-        reset_vec[4] = 0x0202a583;     /*     lw     a1, 32(t0) */
-        reset_vec[5] = 0x0182a283;     /*     lw     t0, 24(t0) */
+        reset_vec[4] = 0x0242a583;     /*     lw     a1, 36(t0) */
+        reset_vec[5] = 0x01c2a283;     /*     lw     t0, 28(t0) */
     } else {
-        reset_vec[4] = 0x0202b583;     /*     ld     a1, 32(t0) */
-        reset_vec[5] = 0x0182b283;     /*     ld     t0, 24(t0) */
+        reset_vec[4] = 0x0242b583;     /*     ld     a1, 36(t0) */
+        reset_vec[5] = 0x01c2b283;     /*     ld     t0, 28(t0) */
     }
 
 
-- 
2.54.0


