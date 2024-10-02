Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35EA6CF3196
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 05:53:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svsIQ-0000FD-Fh; Wed, 02 Oct 2024 01:53:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1svsHr-00087Z-4v
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 01:52:36 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1svsHp-0004wn-FV
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 01:52:34 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-20b7a4336easo22781995ad.3
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2024 22:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727848352; x=1728453152; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vnlfuKkE3mjHxtW855QtQu3cjtwX4ze7WPpDrASKibs=;
 b=iB+TbKgy6lQJeCDJ+T4dGBtJWMuLwPJK8Cp7It8VFugrBuQi7G+KMNtRvi8w4PXY0M
 3t2a8MJ/xgCaKC2C290Yo1Ugu1fq/Wy/d8z3IMwOT9+2zLEMQci7nZp7FqAymRb023kv
 NKUKgzbXirDYJxbfTyk3Rhwj0P7CMay64dQkZhv8z9nvUK/r0FMAsNtg7KXVgvOfaBBF
 8zvjydv3SuSXxJ9ogWXubflm3QkBcNz+TixDFGHeBmLeHka8DCgpsc/vK8QnJuPMjOg3
 VP9ott+YE4o83bNzfLeznA5OMWaC77j55KTZm7x/I5ktVD2hR/xHghur6NL+55rvI8ds
 p9+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727848352; x=1728453152;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vnlfuKkE3mjHxtW855QtQu3cjtwX4ze7WPpDrASKibs=;
 b=QGprfTlcty4+Am0TWAKMXdYOrDHHDGfK4ow9jV6mc5qc6MjcKm6h+xUXXjH46x8DD0
 q49MqLjIEZSblo0OtGMUp66JqJPyrTABbldm0gWZ0yrvr/u7OLO+dd1NMSfUe3aTe+P+
 c5ehJSbd5UM+kIZWFh4lB4xbgFVJ4KUeYSwFCuzXRQQ5XxqIybqyVpg5J64pyhJZ668X
 6QDtCLqoVhAQufcvAlaxjAJBwuKtSQfznf0w4UfqWxzSEPS6jck+ai10wsvSQO49N5HG
 ULZLdqYnszTSvhm/TcvImAWOYJwDa7qx3EAK9eeAl8vDH9kxJv3Bzs3oVqtcabG2VJQM
 wGVw==
X-Gm-Message-State: AOJu0Yxj7pBfib82rKdg5jMgn4g9IbVJfRbov18ZAkD/N6wwrGyihX8x
 iGH9TUGAC74K5TLusDRfYaR1+hNF1NxRLty6T037XrcReG9lCurWEmYM+phK
X-Google-Smtp-Source: AGHT+IGKtbT/8CemlXCdck0cKADc5yDypVpsy3X41AZJhlzxn6qgCSvSBQW9ArYkrIFfTgtSb5/vBg==
X-Received: by 2002:a17:903:22d2:b0:20b:751f:c9ca with SMTP id
 d9443c01a7336-20bc59ae37emr30579175ad.5.1727848352017; 
 Tue, 01 Oct 2024 22:52:32 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20b37e60c76sm78324235ad.269.2024.10.01.22.52.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2024 22:52:31 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Warner Losh <imp@bsdimp.com>,
 Ajeet Singh <itachis@FreeBSD.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v3 30/35] bsd-user: Add generic RISC-V64 target definitions
Date: Wed,  2 Oct 2024 15:50:43 +1000
Message-ID: <20241002055048.556083-31-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002055048.556083-1-alistair.francis@wdc.com>
References: <20241002055048.556083-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x636.google.com
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
2.46.2


