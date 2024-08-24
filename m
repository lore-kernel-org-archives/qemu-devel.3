Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0EA3C5472C
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Aug 2024 04:58:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shiq6-0007jl-2P; Sat, 24 Aug 2024 00:57:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1shiq5-0007dw-0W
 for qemu-devel@nongnu.org; Sat, 24 Aug 2024 00:57:25 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1shiq2-0002Ha-Fb
 for qemu-devel@nongnu.org; Sat, 24 Aug 2024 00:57:24 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-71446fefddfso998588b3a.0
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2024 21:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724475441; x=1725080241; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cjm2NL6Wgqty15f3ap7G8BavBfHkA8e5dbFy1QdhwG4=;
 b=j4e1LQlPWJElDKbNFPcgDbWaactb1mwdfTC1Ak5q2t9b4IAs5cqJw1T6uWRO3Ke+U9
 ttShE8aBFwEcCYtzmqPg5CuR0pTIcYzSkSu16Jy+Us95/iCleOp9s647uVY2CNS+QbYG
 VxiZvDkRgNdb4O5nU4N9mx9ksTB1QAclOM0pqXP3j4fVeMOQ5gUIz4txVMFMctAy8WOy
 fEEDbvlkt+pmOxipySo00l5cAEd8nM4kTBiQmIuVPIQcKs1zWaFdZOCSerHSBAMwPS3p
 BkKVZY2OT3FlXDTTSotqHmymOMlUfY1QXONrpiC/+EFiv1VtSxcQqMUanrXxyB6v27kU
 +AWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724475441; x=1725080241;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cjm2NL6Wgqty15f3ap7G8BavBfHkA8e5dbFy1QdhwG4=;
 b=quwh6pP7mv0/DRqXAv1MTWFCy1c3MopEYipnoW7l054FW9438p94kfHIxp91azjzfV
 F/byTXF/Uzf32hpRrkRP7+qGuayH4WMMji5b3eYjHCQzgfz2btFHbY9PASjpPJB3TlGC
 n7rzuaomw6rlfqbKrdJVIo4AN3yqk7giqwsDOl5JKJ3SGFpU5ykpsfXVRpfxQtcuPYp1
 Ibgrz+wHfM3eo8BvFucgRqQigFHQElKjY0K+8wPs2mzCoVqpRRJYpsO6M8jS7nSQTaNY
 YJFFuHoQrH+yWSDgFWN3C6hJqOdiRKziNvT77viiYAQ24DWlW/5BrtjbHCb8Mgs/BiFr
 AI1w==
X-Gm-Message-State: AOJu0Yy0yJQTP1LqeNdYt1YL59InfxDqb/cEDrFfgU3adGEYMjO5ZOIi
 nlqkKPUCEIo9dPD0MhTSkbrPIlSrmj+x/tVwQMkuuSIR4zidE7OHOaO3XykcPQA=
X-Google-Smtp-Source: AGHT+IHfVAB2t3Mj2+tavke9V4E+h8VwIRn8eoD+rx0IBp3tDmhUmYWZaffkopxKAzOkp009QPrOaQ==
X-Received: by 2002:a05:6a00:18a3:b0:706:34f3:7b60 with SMTP id
 d2e1a72fcca58-714458acb5cmr5310024b3a.23.1724475440812; 
 Fri, 23 Aug 2024 21:57:20 -0700 (PDT)
Received: from localhost.localdomain ([220.253.126.131])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7143422ecedsm3805934b3a.25.2024.08.23.21.57.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Aug 2024 21:57:20 -0700 (PDT)
From: Ajeet Singh <itachis6234@gmail.com>
X-Google-Original-From: Ajeet Singh <itachis@FreeBSD.org>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Mark Corbin <mark@dibsco.co.uk>,
 Ajeet Singh <itachis@FreeBSD.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 12/17] bsd-user: Add generic RISC-V64 target definitions
Date: Sat, 24 Aug 2024 14:56:30 +1000
Message-Id: <20240824045635.8978-13-itachis@FreeBSD.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240824045635.8978-1-itachis@FreeBSD.org>
References: <20240824045635.8978-1-itachis@FreeBSD.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=itachis6234@gmail.com; helo=mail-pf1-x42b.google.com
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


