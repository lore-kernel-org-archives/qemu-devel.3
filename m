Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 887F3C2BA1A
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 19:02:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJHZ3-0004jv-R5; Mon, 17 Jun 2024 14:58:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sJHYt-0004RN-1Q
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 14:58:39 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sJHYr-0004yQ-B9
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 14:58:38 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-705b9a89e08so4054948b3a.1
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 11:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718650716; x=1719255516; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BKxS0/De0h1OuVT3aoFJuagPA3gXdMM1tQtaPW9ssyc=;
 b=DWl1C3y7+cJD2iq0nAY8eXr8cymqcRF06S3OxfL4Y8Muym2pCXbm4NGRZyvQVBIPvN
 rxR5fNhII6yqybwoFonpwko2J2jUgbDwPkY3ikO7POkg+bHEgdr/MsDH0rzw5v1YVTxW
 RnI6tJYPxfDDUz1g36s3/l3yzBOT34Ek/RVpCJ/5VRtoBTdSWYSFiLb7h0o12FmRbimy
 zejsmW9C/1D7UepvnvZeVs6qWcwS+szdPxSyf9S0Mshs9ZuJwataR5RY8XFtzk8TLNHW
 cW0sFjvpTd4MGxk8aY/rZTOyArxWYaswYhQRck9QX3R/+x1AOXuK3KMFiuPclm8/ie5C
 MC5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718650716; x=1719255516;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BKxS0/De0h1OuVT3aoFJuagPA3gXdMM1tQtaPW9ssyc=;
 b=NtqbQF9K1i6CRtF7NnIQis2utIt+15VLsYGZv9gGfUwj7PmCQchailyAav/a2L761K
 aokIZlvb2aSm2oqt93DL7zuxriqZxIZ9gRVs+dU21ClivZ8pF8SVpFWik6A6FhN9GFuu
 yPtOBEerZMi2BHCq6M7hSVHbeZzdEj71Exq7CMU6MA7g5ja2ycPiGiehdYJVWJ+8oukS
 rSvksUR2PQRs8EOYvyA3YaiQ1yZ3IV0XhdwN+ev2pu75v6795thU3IJqvFKN5SpYI4ck
 LWTwy0O8bAuJ4SmoQfYHS3Rh1B2VYZvmqWnPT2t9ve56CCz12sSMSdc6LEq47lJtU/nM
 7Bvw==
X-Gm-Message-State: AOJu0YzbOSQ6JjngDIEcas/4d6YRyEpOut3IFpOe0P+e4COVRwYDTZCz
 DQ1xS6GrWZ5MVfrIE/Es/zn4gFhON9kt1XH9ii1Bcq0rmE/XScqfH29WmMOBs0M=
X-Google-Smtp-Source: AGHT+IFXPx9+NnaJ12o3LRv0Xz/+IIYcKeMMRBkz8ZkjeebPlQdTK5wiL/yH2MRlsiT/OSRULEb2cw==
X-Received: by 2002:aa7:91cc:0:b0:705:c310:60b0 with SMTP id
 d2e1a72fcca58-705d719331cmr10467354b3a.25.1718650715747; 
 Mon, 17 Jun 2024 11:58:35 -0700 (PDT)
Received: from localhost.localdomain ([106.222.222.115])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-705ccb4aa4fsm7660637b3a.131.2024.06.17.11.58.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jun 2024 11:58:35 -0700 (PDT)
From: Ajeet Singh <itachis6234@gmail.com>
X-Google-Original-From: Ajeet Singh <itachis@FreeBSD.org>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Ajeet Singh <itachis@freebsd.org>,
 Stacey Son <sson@FreeBSD.org>, Ajeet Singh <itachis@FreeBSD.org>
Subject: [PATCH 07/23] Add ARM AArch64 TLS Management Prototypes for BSD-User
Date: Tue, 18 Jun 2024 00:27:48 +0530
Message-Id: <20240617185804.25075-8-itachis@FreeBSD.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240617185804.25075-1-itachis@FreeBSD.org>
References: <20240617185804.25075-1-itachis@FreeBSD.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=itachis6234@gmail.com; helo=mail-pf1-x42e.google.com
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

From: Stacey Son <sson@FreeBSD.org>

Prototypes for setting and getting TLS( thread local storage)

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
---
 bsd-user/aarch64/target_arch.h | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 bsd-user/aarch64/target_arch.h

diff --git a/bsd-user/aarch64/target_arch.h b/bsd-user/aarch64/target_arch.h
new file mode 100644
index 0000000000..27f47de8eb
--- /dev/null
+++ b/bsd-user/aarch64/target_arch.h
@@ -0,0 +1,28 @@
+/*
+ * ARM AArch64 specific prototypes for bsd-user
+ *
+ * Copyright (c) 2015 Stacey D. Son <sson at FreeBSD>
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef TARGET_ARCH_H
+#define TARGET_ARCH_H
+
+#include "qemu.h"
+
+void target_cpu_set_tls(CPUARMState *env, target_ulong newtls);
+target_ulong target_cpu_get_tls(CPUARMState *env);
+
+#endif /* TARGET_ARCH_H */
-- 
2.34.1


