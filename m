Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 077B8CF9C6B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2024 22:24:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stDtn-0008Cm-5J; Tue, 24 Sep 2024 18:20:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1stDtS-0005tA-5I
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 18:20:28 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1stDtQ-0001zE-ME
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 18:20:25 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-7db908c9c83so3414124a12.2
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2024 15:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727216421; x=1727821221; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dJzrLnw/tw/X9NwLT11QXVdxLp5dOjlp6umpF3vna8k=;
 b=EhTVTn9FmmlsF6M+MS3tlvNxBqIejSiDkEpHs0WVGHxw6NqxoP/inru7vDbviVblnZ
 NPJjXFaVEcFuHiJB044GSZKtJiU6nmtJ3tcgsvZkT3n3BkDLHqImqctXec+XqswTBz2U
 kyc1KccvlQn6ddqQZ1avTzvuoZGfG8rds6+K4Z+ABhLG+0diFCKIWKtTKdZ2pmHnmz/D
 BGjTr11FHEGbt2zU5Iq0JoUFk28Y8SdArOsz3OTyYhoJ6vMXOeAZRfkYp1PzwW2ol0Fx
 p7YjBGohI7cFt+6N7XPHENafmwyno2K1smwv46Qo39UWU86JMac0hjqHXmKu/xOA2F5X
 wcGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727216421; x=1727821221;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dJzrLnw/tw/X9NwLT11QXVdxLp5dOjlp6umpF3vna8k=;
 b=u9tnoH2BYKfg2Gib4d1pbREbwS4LG802UHCGlvFsibTi4raIEOjLmiVFuoT6mxlBm6
 pVRofqk7xHeYrb1i37+DtKt6tpg4XYLB2up+wiQpkBRt5mPcesxmMl4QjTiUurOWz/96
 Cis8PD9VODdlUMIm5zCcm0iO+M96L+kBXGjNVWZ4KH8RnqqaQwLS64L8BaFC4z7woP1p
 FWIsqI/v/9xzjZKoQjNYGcU93BUV1xt3oNM10XLiFcWuTJBxkHHGQl2BYI7U2CfCasad
 BjX3Qq8tGeGOpysk7FRIZF2g1JZFL3N6OS50mESNWTBv+sn/GHxXZBuZUm6HdS7wVLX6
 bMwQ==
X-Gm-Message-State: AOJu0YwCAVHvueZK4y2X43jquptAyvGpPdNdi33C6fEzE0MNkCJ0cHgZ
 1Voo9QAaicxg9UfhhizRmFx7uffxvriVLucvh+FMjYIJa3j0x8bH3e0jsQ==
X-Google-Smtp-Source: AGHT+IHN2EY6zf/k/Qlhd/FzVU8jI/xYMqKB/mMTdwoStiLkmpNF0A+kuLa7AeH7BBKt3uBA2U3Xkw==
X-Received: by 2002:a05:6300:668a:b0:1cf:42bf:6af1 with SMTP id
 adf61e73a8af0-1d4c6f3074amr884899637.2.1727216420732; 
 Tue, 24 Sep 2024 15:20:20 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71afc8342easm1665310b3a.11.2024.09.24.15.20.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Sep 2024 15:20:20 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Warner Losh <imp@bsdimp.com>,
 Ajeet Singh <itachis@FreeBSD.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 42/47] bsd-user: Add generic RISC-V64 target definitions
Date: Wed, 25 Sep 2024 08:17:43 +1000
Message-ID: <20240924221751.2688389-43-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240924221751.2688389-1-alistair.francis@wdc.com>
References: <20240924221751.2688389-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x52f.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Warner Losh <imp@bsdimp.com>

Added a generic definition for RISC-V64 target-specific details.
Implemented the 'regpairs_aligned' function,which returns 'false'
to indicate that register pairs are not aligned in the RISC-V64 ABI.

Signed-off-by: Warner Losh <imp@bsdimp.com>
Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20240916155119.14610-13-itachis@FreeBSD.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 bsd-user/riscv/target.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 bsd-user/riscv/target.h

diff --git a/bsd-user/riscv/target.h b/bsd-user/riscv/target.h
new file mode 100644
index 0000000000..036ddd185e
--- /dev/null
+++ b/bsd-user/riscv/target.h
@@ -0,0 +1,20 @@
+/*
+ * Riscv64 general target stuff that's common to all aarch details
+ *
+ * Copyright (c) 2022 M. Warner Losh <imp@bsdimp.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef TARGET_H
+#define TARGET_H
+
+/*
+ * riscv64 ABI does not 'lump' the registers for 64-bit args.
+ */
+static inline bool regpairs_aligned(void *cpu_env)
+{
+    return false;
+}
+
+#endif /* TARGET_H */
-- 
2.46.1


