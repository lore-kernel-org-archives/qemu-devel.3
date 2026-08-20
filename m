Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68F0EC5DF85
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 03:46:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwtjF-0000oH-Dj; Wed, 19 Aug 2026 23:46:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtjE-0000nY-2X
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:46:08 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtjC-00041d-9M
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:46:07 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-38e08baf860so1864210a91.2
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 20:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787197565; x=1787802365; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qfECYY3QZRTyl/SOMv9+jWU3ydUdOrBVrmpFSQeHgA8=;
 b=cusk8MfEX6WkteZeamb579jqRyUTYXrl3/d/ZMAM2ZHzFhuV1DLPO9ib7LUUoW0cGz
 slo2/AFZEF00Bh6kzKwmYpVYZVy71ZY7LJixp70H3pjSEwOKUAwxpy00nG2X43GEnj1K
 Mbf8Befasn+ThZfPjM6aGigNJ+uub+Tl10y47E3JhlvOJv1fkMmhgIMVScfySRh5QY77
 mg+EbsafJJO4zKsL8b4oTsvbf8ytguZx79fAI1ZjYWT9aXlOwKxnmR9eTDBq15E9H/1d
 4wmOfaLsRrJ5EKJAMMmxdtgcHv+v5LwUq187q+8zSEFCHo/htOXQsIyH2uhGBh13QQRn
 1+WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787197565; x=1787802365;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=qfECYY3QZRTyl/SOMv9+jWU3ydUdOrBVrmpFSQeHgA8=;
 b=QHZSAovni2ZvFicvg4NdCCuXcT9nz07OpX9XGe+wTceb0RI7kym9n9GAtQCQMr8FSl
 qYVm5HtAhQl7NeAxyFMB5CfoBhq4Wue6Di5/bTQfMYygF07oOXSul1GW+ufGzDi3V/ty
 RbRpnAobMCvkihhmr9Z2wrir1ZMPyaoyyPTxNOoOp+nQPzbB4svgVhSyNDzU44klSkjX
 t6qqizGd/2/CopIbrzZak2NfskPoTXh7z1U458Az2OOzNKJLumOwsPKddfsVvGm8UZ5O
 snO4LhRZgq8sWHApnWduBKibDg+C9UTA9JvYbWNxqPBUPqOzD59aIAepX3Wb3PvZnNzL
 uO8g==
X-Gm-Message-State: AFuF++lIzSoyL1NOalXAgmtRtMoYOjQ0x3kPOghp2qy0ai3kv6Skir7V
 3fwC2DEb1sh2mNWhBkwmtPkNHil2DB0LUmKssC6aY+L6PUQebuZgpkelTWqctA==
X-Gm-Gg: AR+sD13d++i0nxIl59FbAbzB1x60XOfQpUgES7GN7sweXc3YNCfEgR7djtCBMLqWYgl
 zjIp6QjqS1q/SzRfdt1o3YlofMLKNH/hRQHtHKjBAZCCtxYZHkkAP07iK2MFOCirio1aRkebso+
 5nffxiUtk+dLBdSonmhPftZeY6DPi3kA0duVFVs3qdIkaQWjx3mL8h9Tq3AeH4jfEQ/SkXk88Bt
 Te1llIRZGx18nfiXlxhu7cXG6YTUDVKvpC4NotKubFPQkdxWalE73nESKMcaJRdWY6Qt1DutfnA
 n50jIDTY+iyWiqpBLEduf706BdwSohkjoflQK4eowmDKr4rOtg29Uda4mb7nWCxddV+Wh5/mBSV
 eJFx1atcg9A/hsekAEE3Nl/Fd1r0aDRefd7PnAyqlsGv3NxvClJZss0GpAiq6R4PUbwrGIPUvAM
 Sijmlmc4HUt/liLFQrnVU2vb7zs5ncAZoYOJOYT++/9jfiMfO+xx7Z5SkFJu34kmRIvrnocQNaQ
 ir7Qw==
X-Received: by 2002:a17:90b:4d0b:b0:38e:2860:253f with SMTP id
 98e67ed59e1d1-39581211d6emr16204730a91.12.1787197564810; 
 Wed, 19 Aug 2026 20:46:04 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1416ad6060asm19506735c88.6.2026.08.19.20.46.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 20:46:04 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Ivan Efremov <nendensu@ispras.ru>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 27/93] target/riscv: Fix seed CSR sign extension
Date: Thu, 20 Aug 2026 13:43:24 +1000
Message-ID: <20260820034430.1186695-28-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260820034430.1186695-1-alistair.francis@wdc.com>
References: <20260820034430.1186695-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1031.google.com
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

From: Ivan Efremov <nendensu@ispras.ru>

The SEED_OPST_* macros expanded to int expressions. When
bit 31 was present, converting a CSR seed value to target_ulong
on RV64 sign extended the value and incorrectly set the upper 32 bits.

Make the SEED_OPST_* constants unsigned so that CSR values are
zero extended on RV64.

Fixes: 77442380ecbe ("target/riscv: rvk: add CSR support for Zkr")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4121
Signed-off-by: Ivan Efremov <nendensu@ispras.ru>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260802113130.7818-2-nendensu@ispras.ru>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_bits.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 3f146a43fe..c01050ce2b 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -1086,11 +1086,11 @@ typedef enum CTRType {
     (HVICTL_VTI | HVICTL_IID | HVICTL_IPRIOM | HVICTL_IPRIO)
 
 /* seed CSR bits */
-#define SEED_OPST                        (0b11 << 30)
-#define SEED_OPST_BIST                   (0b00 << 30)
-#define SEED_OPST_WAIT                   (0b01 << 30)
-#define SEED_OPST_ES16                   (0b10 << 30)
-#define SEED_OPST_DEAD                   (0b11 << 30)
+#define SEED_OPST                        (0b11U << 30)
+#define SEED_OPST_BIST                   (0b00U << 30)
+#define SEED_OPST_WAIT                   (0b01U << 30)
+#define SEED_OPST_ES16                   (0b10U << 30)
+#define SEED_OPST_DEAD                   (0b11U << 30)
 /* PMU related bits */
 #define MIE_LCOFIE                         (1 << IRQ_PMU_OVF)
 
-- 
2.54.0


