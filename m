Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07431606A323
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Nov 2026 00:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=t6sIhQAA
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSOQJ-0008S5-NQ; Sat, 14 Nov 2026 19:48:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xSOQH-0008Q0-Fh
 for qemu-devel@nongnu.org; Sat, 14 Nov 2026 19:48:45 -0500
Received: from mail-dy1-x132c.google.com ([2607:f8b0:4864:20::132c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xSOQG-00017N-1T
 for qemu-devel@nongnu.org; Sat, 14 Nov 2026 19:48:45 -0500
Received: by mail-dy1-x132c.google.com with SMTP id
 5a478bee46e88-37d424f1ae8so492288eec.1
 for <qemu-devel@nongnu.org>; Sat, 14 Nov 2026 16:48:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794703723; x=1795308523; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Xjgo6KQJSS+b+bdZzT2EkMy778ORLKBtElCHB3931Zw=;
 b=t6sIhQAAo2FvGLMHSk4SKOy5CoYzVPd/9eyL2yaYFVx4GQci8Zm7Cs9o/DpaV+Cvqr
 ajtjjKuMQbLvm1jljx1SnycsrYfTPL9rL9eU7K1gcKD8iGMOe8nDhABItxcLKhINs61J
 V+Ln0LjD3Z8c3yFcxEyx32iUU0aeGydMYJjNsqjad49+/4H8EIvgMVWBTNHDc1/eeRkk
 4zqLZgBAVZClXurd5Qy1fo4brcW3tYkKLD7iYeng+HPBig/2CBc/K5Xsgb1qoZCV6XW1
 g6L5NgxjMhZFNRGxf26McHeVi1jeGURE3cU6SEFr8DjjxVhRE1MdUbBH1YXU+8KA5tYb
 OQGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794703723; x=1795308523;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Xjgo6KQJSS+b+bdZzT2EkMy778ORLKBtElCHB3931Zw=;
 b=f3C0lw1qpnAJvx2mjY/P8jKCRfe/WuwBtXZCHhBcBX716nDfEJwi/j1/ZGn3Mh9gxP
 Sfd/W8hlhUq/z0pDV5g02xI8sBsvnnJAC5y1AKEeXgBQJyA5i8czUdgiv5o750/iVr/o
 FGsIIMl+aVZWmUj7PpHi5eaWW45A2+QiL0TEwH7pqf2fZ3dyzag2wn4y8zzh8DupDGGB
 ufMYRQFvCP9r+FvTES9B/GX7UyRq+QGlCoU+PIumzIFk+R9GSdwgke9VZR9oKqL3eULX
 lcezdhaX6UGYqONXh7wBYP3XqFA8wwsqN+mx4VR3pRwyyZyxi+O46s7qusD07sCtglGN
 GBUQ==
X-Gm-Message-State: APuU4Z9xIu/2xcEMoh5uYUiD6iaYPHIZShRNpEr7dH7WuxaBxO0uKzRA
 VWWpJdL0LAqpj8C0e9WuRUyVYmCElriEVEiuopSHpqmsGBpgwo5QzSz152ocVA==
X-Gm-Gg: AYBFou19rp1tE7Q+w32ezUlsJEOEc9S+tIlKeyS2RDmmxHd61NLAueU4xYhBzuP81VF
 leKgWW1sc5Gh3tAL0OBMAUw1J6RuO0M38U8WRkLITGfc10E5RmPs0v1yM7zL7mZRK2eTBvjzu+S
 duVEP+ZxNfF/skYKrc5qpiO8Hwp8q/4qcLTNt39C+JR52jmlH79bTfT09bT0Kd7cgrPELk78Qw4
 T8ksGCEEClxyQa1tRODwMyAdx+ADz8/gR7WSkaBvcXtxVsUfpd20AFMR3+d6uIusTg2CpSzL2Xa
 lGmr+gwTq/50lZfRPiT45n8PZoC5Dj2jxQ9DqWXtBOBeT1sxfATB53DinSUw/dg3am4RjsJKkn7
 0oWVFvaN2U5ZHii8ZWHa7tkUiMd0TuGIFTWD8mP9Z3ANP5vKuEUf8nKR/vZ/vP7gMo8wHt0Yr/9
 LcBIxxyWyuaM+xv0lKZj7Dc/qmHRVNe3g/BGKn0JSJWyhW0o+vOxbGKV6633dwcmSB9mRg72Gz5
 qOU+ZzTVtXlXDCwJlmIDFee26/nrvKUnabCtvvK+KD5qtbJqrhCiNGmjvJrcIBPihFnmvO2UBjE
 1MdidAZ0j26BZ9LQ/T00XJ4QeyPyXe4WUYASVVy8pThycRo=
X-Received: by 2002:a05:7301:1705:b0:36e:c9e5:33aa with SMTP id
 5a478bee46e88-37965f9ea5bmr6142125eec.13.1794703722543; 
 Sat, 14 Nov 2026 16:48:42 -0800 (PST)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-379553316f2sm21102926eec.9.2026.11.14.16.48.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Nov 2026 16:48:42 -0800 (PST)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Tan Chi <tanchi25@mails.ucas.ac.cn>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Nutty Liu <nutty.liu@hotmail.com>
Subject: [PULL 5/8] hw/riscv: Select SSI for IBEX
Date: Sun, 15 Nov 2026 10:48:16 +1000
Message-ID: <20261115004819.2586336-6-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261115004819.2586336-1-alistair.francis@wdc.com>
References: <20261115004819.2586336-1-alistair.francis@wdc.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::132c;
 envelope-from=alistair23@gmail.com; helo=mail-dy1-x132c.google.com
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

From: Tan Chi <tanchi25@mails.ucas.ac.cn>

The Ibex SPI host controller uses the SSI bus infrastructure,
but CONFIG_IBEX does not select CONFIG_SSI.

This causes undefined references to SSI functions, including
ssi_transfer(), when building a minimal RV32 OpenTitan target
without default devices.

Select SSI from IBEX to ensure that the required bus
implementation is built.

Signed-off-by: Tan Chi <tanchi25@mails.ucas.ac.cn>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
Message-ID: <20261101031547.125591-6-tanchi25@mails.ucas.ac.cn>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index f3bf8d159cba..807fcaaf280e 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -6,6 +6,7 @@ config RISCV_NUMA
 
 config IBEX
     bool
+    select SSI
 
 config RISCV_DEVICE_COMMON
     bool
-- 
2.55.0


