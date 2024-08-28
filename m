Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59362C54E62
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 09:53:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjFMo-0003JZ-Mw; Wed, 28 Aug 2024 05:53:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sjFMn-0003Ef-ED
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 05:53:29 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sjFMm-0001qG-0N
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 05:53:29 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-7bb75419123so4141104a12.3
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2024 02:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724838806; x=1725443606; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cjm2NL6Wgqty15f3ap7G8BavBfHkA8e5dbFy1QdhwG4=;
 b=hRiymZlaADkZjhZaEKFtixZjgrkJ8SSf/hhlWnfsyMRzVMvbY6rFjrRQb16B81t+tM
 I4X/EPVxA6DUsz2YTw2ZYFTMzVnFQJqwGiq+YzZXaqMZvQaPVvcLX1apmtlkxfswvswm
 tpdwXRWyYRb7ADj/ojKI79hYxKvZzr3jSmoEWcAx3Yb7Usp+HjyBGC7zHMTJuqX8DKWA
 pr6wn4pCPrwmooodI6nQph1XqihGIaoNkVtDL515KAWZxE6bnKXu7Ei1c9swYdIQ0QJA
 u6/x6CntVcMCqY7j4Vajx213EZNJSWE/FcYSNRjN9ikk/2wQoTXirrs7gAciRCXuiSJS
 Ua4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724838806; x=1725443606;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cjm2NL6Wgqty15f3ap7G8BavBfHkA8e5dbFy1QdhwG4=;
 b=wckLp6jQo1OF0gfrwO1VZul1I8bmmukcYNHoFV1U8u09XLLhbMziGfmBjnpHAF17T9
 i4V0ReqbtCWEbJoA6hiagHUUzyVwXWfdDKJM2qbi6wXm8q6/rNbIjgu4hwjaPbFF5GMt
 9xLuMesrOSoG6SS8cSemlMssCjCKGLOjQGkUtket+EMKBo9GlLKbMEHb4XuLZLcDkotv
 T1nfqwtPKMkXohafClv7e+rdaqRJFqZICrMFrCruCDIS+yrcIQLldYRImJDICQ+5UNq9
 8God9y9rQL+C6hsqioxbUqEU5JBrlEmJa+fFxtOor7FX4oFL6ubT9aIQoWhhVD3twQjJ
 s6Cg==
X-Gm-Message-State: AOJu0Yxr3b4AJWnsxezAfISDVtjpfUeR1qDvoDTVH3YduOFhwL7k2J9h
 cq+kns6xyO3VA1LcYzvWT7A8DLXpNwi8zlnkEkEAgTW/xuCawTceww5MKdZ7
X-Google-Smtp-Source: AGHT+IFfPsDngfLDLrovXM/npkCM4SbchAO1MzqKzMXKjtda1CB5VJC6q2PLu2w7zNi6hV0BSdwtLQ==
X-Received: by 2002:a05:6a21:e8a:b0:1c4:9ef6:499b with SMTP id
 adf61e73a8af0-1cc8b4bc8aemr15433478637.29.1724838806290; 
 Wed, 28 Aug 2024 02:53:26 -0700 (PDT)
Received: from localhost.localdomain ([220.253.126.131])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7143430f6e7sm9787508b3a.160.2024.08.28.02.53.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2024 02:53:26 -0700 (PDT)
From: Ajeet Singh <itachis6234@gmail.com>
X-Google-Original-From: Ajeet Singh <itachis@FreeBSD.org>
To: qemu-devel@nongnu.org
Cc: Mark Corbin <mark@dibsco.co.uk>, Warner Losh <imp@bsdimp.com>,
 Ajeet Singh <itachis@FreeBSD.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v4 12/17] bsd-user: Add generic RISC-V64 target definitions
Date: Wed, 28 Aug 2024 19:52:38 +1000
Message-Id: <20240828095243.90491-13-itachis@FreeBSD.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240828095243.90491-1-itachis@FreeBSD.org>
References: <20240828095243.90491-1-itachis@FreeBSD.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=itachis6234@gmail.com; helo=mail-pg1-x529.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
2.34.1


