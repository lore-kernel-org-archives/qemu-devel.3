Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E61ECD4846
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Sep 2024 03:26:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smm3A-00049f-07; Fri, 06 Sep 2024 23:23:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1smlzh-0003or-Be
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 23:20:13 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1smlze-00054n-NS
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 23:20:12 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2068bee21d8so28854485ad.2
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2024 20:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725679209; x=1726284009; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cjm2NL6Wgqty15f3ap7G8BavBfHkA8e5dbFy1QdhwG4=;
 b=eF+TAu71Yd3EMtYgov1UpmkBO3EXxsHidxQxBnlnQnVXLe4KTD8FsuuWphlPWcnQ+L
 fGN5MoYMrNZg4LTxxfhrn63GJuLjbUmtQL20iMfWi1jodH5pGrd1A2gLzabChhiJizBZ
 uKnrcKIEugh9xbmA07z2pzEuK2x+RwRmi2f5Uw9uwrYFZ2nc3tG86VgM62secwqmqRLO
 Wa+AkJ6iU/5hEsh4R8f633OKtInpl7vuPUpXhX+bBemprKOlkiNvNcSUMJ93fXMDFcKF
 LyJtUgMk4kvHvZ1p+2LOxGpY30TzmfvsbG917gxc/MXKfl7Q4ESPomLnpmNCXdsscbOJ
 O38w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725679209; x=1726284009;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cjm2NL6Wgqty15f3ap7G8BavBfHkA8e5dbFy1QdhwG4=;
 b=NGzMmnURr5sMLITgKKXRlRsVEFetNu4ASt3JoMan608MdF1cxZDKsJMOcJxT2JkEnc
 naGs6V4OUBw7vPkVdL9OgxU+xNePY0z4TpgdGM8HSy0NW5bp2SHqytelloPWyKxfqmfs
 2SRLSyB+STG8t70zB7ZlF5AGmtIPOAZa8ubqXaTvbV6icsO5VcuZOWMK4Lgb8IvAE8sb
 ZquITnnBpKObLZAtY/cA59LdwrEA7xsf+8yacTLZA076WIiFPvA6U0b2TQcUei77Kd3C
 pfPzpokoyDYKzSrudPkZv+m+gXLvCYDu6dnsjHXUZNwF2o1w6kOBDdLLMkxUjPYLixjX
 5v6g==
X-Gm-Message-State: AOJu0YyEO3tCCINaR3uKDh5NQRaZcQzMPUIVh+w/lD2LyXBZMPG5dvCL
 9KET/YP3XeErp9SzQ0SNI6o9vqLI8Sn7UdVvaDX/bfFM+ApCfVq/qRD+1A==
X-Google-Smtp-Source: AGHT+IFBHWvl1QcceNo5pwo7NXDZ3vu7PzMKIptxtFd572G3+8yQhqRvBeNsCXvlNmn1XacBETvY5Q==
X-Received: by 2002:a17:903:41c4:b0:205:8a25:904b with SMTP id
 d9443c01a7336-2070c1cfed1mr17256495ad.57.1725679209148; 
 Fri, 06 Sep 2024 20:20:09 -0700 (PDT)
Received: from localhost.localdomain (115-64-160-35.tpgi.com.au.
 [115.64.160.35]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20710f1d4c6sm1703745ad.187.2024.09.06.20.20.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Sep 2024 20:20:08 -0700 (PDT)
From: Ajeet Singh <itachis6234@gmail.com>
X-Google-Original-From: Ajeet Singh <itachis@FreeBSD.org>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Mark Corbin <mark@dibsco.co.uk>,
 Ajeet Singh <itachis@FreeBSD.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v5 12/17] bsd-user: Add generic RISC-V64 target definitions
Date: Sat,  7 Sep 2024 13:19:22 +1000
Message-Id: <20240907031927.1908-13-itachis@FreeBSD.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240907031927.1908-1-itachis@FreeBSD.org>
References: <20240907031927.1908-1-itachis@FreeBSD.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=itachis6234@gmail.com; helo=mail-pl1-x62a.google.com
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


