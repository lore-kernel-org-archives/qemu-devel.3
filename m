Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD8A606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 06:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=h5O21YVW
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLahT-0003sB-7c; Tue, 27 Oct 2026 02:30:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xLah2-0003Z1-V4
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 02:29:59 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xLagr-0008Eo-D2
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 02:29:46 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-cd6a7b62ce8so1135983a12.0
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 23:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793082584; x=1793687384; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=prSJoW7o56XngR0nAmHkQhbkm196zKbIQaVUVG31n4g=;
 b=h5O21YVWR+az1v503DOXNLdTVHox8JnbsSiytTBRG5b2DHmOt6RY6PgekaA0NQ7Hn9
 ldG6IlXaM98pM1ax6BS/BS1Isu/49Jw/s2u9waMPm9XzhzDh4uJpi/XsEDnzKA3TZCEF
 xbxCg+q1A99DTwmfbLwU8axBjLAWie5OHB1tN6+uR8Drs4rBb1uMw6iam9c5coGlsxWx
 l7UR/txaRiuH27h6TAPPEN8luaSNURv3aHN2rHYO5oiBt62IZFqvVpxjXkVymWVOKJfs
 ZYCaJiLQHT3D4937Al6lMyyfVSMao7JGEwc6UMTIGIln7SQ8cJAvGfpIish0/T1oVZoz
 YS7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793082584; x=1793687384;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=prSJoW7o56XngR0nAmHkQhbkm196zKbIQaVUVG31n4g=;
 b=qffHeOoG3cjdFP4/E9Pjgka713E77iLpGsb9wMRIaI5PBEn7h0vRiCUwHpU2RB2riu
 on5qH6QW9y6+3IVhRdYMD4uCXjD7f1dOD88Xfg3uoUiHfe3CIeDJt5o/pLCpK2SQwJNp
 1C/Ie+DI9MbiTQEwO/qP1xFT0zhiRVaxlDRtvNcS7J1/oB7RowIDuS0os9Di1D10O+In
 lrquNDFNMw1HrYf7DbdI7JvZRuo8q5Io4wpnpNMcC4eVGUGnuXHndJQadMOlfQ6Bs2hP
 ImOyHY1YFXmgrWF9jYKDWeDW3EgDGTAQIdKuyMiuckNl2omnh7C498zdfEM/kINnwc8m
 4JBA==
X-Gm-Message-State: AFq9FYIuf5D3nhviOBekWFC3HfYxpETOd4Nmea8sVPPNLm7F6NjHJ9kd
 kd2pWugzyuagAnEeKqkxo9mGDvNMAfXBaEKIMIVw51q8AYUV7jRPzhOp6EcJ2A==
X-Gm-Gg: AYBFou0rAWal+sIoLv0nWMySzb2JAvu6nUFwk/0gHh7tY4crjInU0ZxqVZqI/qinVcK
 rwnPQ8gCbuMbepZ3XE8+8iZ4xWD1eTyW8DxCIiXmjdhfd/tfQPPjdQn2gqc5UTxp/6ffsJa9MkT
 0sVnO9MJBm/KKS3Zv6hVymyDRo7MnqZ3/35nGu4ULoXY4iRMHRglPn3ElmkMP8klpd38trKLpnW
 TxAeL3IN1YNh4lcT6mcYv5YUzjXFXhxJFhbjNP/d3DIFHbQ1R2xSH8X2M93CnBrG8EGBZNSZ9Ft
 1Rcdd/ZXzR5PLSsteKSFuNEcAflC0aa+Aq6fn7WPRoSe7AV2Zdo4mjuwpz5PQSYTEi6HPZZizbv
 fYcxm4uDk5OmkYV5nhTiBCob6O0UmGR3qL5y3404nWBB7iewEpUeCwSfG2Y1BNeZ6LGAs6Al0As
 kJr/c2f5PN9zz3dnkdjaQaVynkdONs9Vm32Af4hIu2bMh86TmtfJd+jJ+enqO/SzKjHUhx5kqWd
 YCJNPXwsYYtPEgc0zBlCEcWbvkEP1XkUe8VYWyEheIwGBlUokF4bChmWbWaE+oSH8cwQdJ2Jw==
X-Received: by 2002:a17:90b:2552:b0:3ab:884b:659e with SMTP id
 98e67ed59e1d1-3adea8984bamr7005936a91.9.1793082583952; 
 Mon, 26 Oct 2026 23:29:43 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae401bf352sm2358541a91.0.2026.10.26.23.29.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 23:29:43 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Chao Liu <chao.liu@processmission.com>
Subject: [PULL 25/29] include/hw/intc/riscv_imsic.h: remove unused macro
Date: Tue, 27 Oct 2026 16:28:04 +1000
Message-ID: <20261027062808.1995205-26-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027062808.1995205-1-alistair.francis@wdc.com>
References: <20261027062808.1995205-1-alistair.francis@wdc.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x529.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

Found while reading IMSIC code.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>
Message-ID: <20261022181957.21760-1-daniel.barboza@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/intc/riscv_imsic.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/hw/intc/riscv_imsic.h b/include/hw/intc/riscv_imsic.h
index 0a1df1c2f8d6..c74483665728 100644
--- a/include/hw/intc/riscv_imsic.h
+++ b/include/hw/intc/riscv_imsic.h
@@ -31,7 +31,6 @@ DECLARE_INSTANCE_CHECKER(RISCVIMSICState, RISCV_IMSIC, TYPE_RISCV_IMSIC)
 #define IMSIC_MMIO_PAGE_SZ             (1UL << IMSIC_MMIO_PAGE_SHIFT)
 #define IMSIC_MMIO_SIZE(__num_pages)   ((__num_pages) * IMSIC_MMIO_PAGE_SZ)
 
-#define IMSIC_MMIO_HART_GUEST_MAX_BTIS 6
 #define IMSIC_MMIO_GROUP_MIN_SHIFT     24
 
 #define IMSIC_HART_NUM_GUESTS(__guest_bits)           \
-- 
2.55.0


