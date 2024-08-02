Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82475C3DA49
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 08:35:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZnkR-0007hv-DC; Fri, 02 Aug 2024 04:34:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sZnkQ-0007dh-AD
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 04:34:50 -0400
Received: from mail-oa1-x30.google.com ([2001:4860:4864:20::30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sZnkO-0006RQ-Pr
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 04:34:50 -0400
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-264545214efso4362441fac.3
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2024 01:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722587687; x=1723192487; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VazBiqHhZAFXJRh0kGe4jPT2Ftyb2VHZzmL3PXBSHfI=;
 b=dUfjgF9bD+he1daPNaXDTFpYU845Me2KJKccV5maDhpzqYWOX+o0a5jE42WeQrbuyE
 XVn/1PGm6BzpeVeVxwBJ6SCqZRYXywJUqi5XmuPHBCJtDZzg4odgauGqd9FfEz70l2UD
 9UyZvrSF7upN2AZaD0YL1YC8rsoFy/uIpcYjVuCKveN5aHbijEkdrgbS1wd5PVerRV5m
 6wOmDPVoFzYE4WoZH0J5Q4zOiplDqOyuuTcMsO3NJjJq8J1LdflvWU7wxea0krinZWBX
 Sk6UMLYbbSFX+Cm8jxKv9H1MvurytP5SAktWvyF0+wWvGae8jyvzcktK0xjmyMUCkZwm
 LBIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722587687; x=1723192487;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VazBiqHhZAFXJRh0kGe4jPT2Ftyb2VHZzmL3PXBSHfI=;
 b=rhK7fPHB13gR1k29wMkH9YFr3hNl0TNwSxzSVdz2Qi9Q+xG31gcmAnK6TYqHDlkCyP
 L5kVyOhpVObQmxQuOsNmYYdcFxDvgye3W5UIGSveLIneaaYYENErMiF0v7vGEPNQOvWC
 i6gkyaS3rydCW0spFpFaxILhMgs1bGt0DZhL6vJd5qzKtBGKn78luM1NRQ2+ToCG/FRY
 gEbBClCO3CnvqB3xoIV69POLfxq7Yi+8yeET+CDVPn9aL86wpF8lDJiJB0YtrX1/isIw
 O7h3k6yG0d5olqteuPIwEQe8S46BC4JU+JXOBY9n75JWVjUPrB5r15JO5dcoDjipDZ2Z
 FbDg==
X-Gm-Message-State: AOJu0Yzf74JTrolIGopGT19+IYVlSGs+XH4Q+rfofvczhfzKvVIxYxhF
 ccSQM40YafMHfESEG534ICOqlKv5RTNJeVXn0YHYJfjcddl5Bwf4FaAzGZ4UkgE=
X-Google-Smtp-Source: AGHT+IEuwSBw4WAiH2ew67G6Hy7fTG3vHUSaj4p4IDz7a4FNNAT+dcsck7En9c8bCJMVZDCp3hyXmw==
X-Received: by 2002:a05:6870:15d5:b0:263:3b45:b7dd with SMTP id
 586e51a60fabf-26891a7f2eemr3155497fac.1.1722587687176; 
 Fri, 02 Aug 2024 01:34:47 -0700 (PDT)
Received: from localhost.localdomain ([203.87.101.91])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7106ec06a25sm951673b3a.33.2024.08.02.01.34.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Aug 2024 01:34:46 -0700 (PDT)
From: Ajeet Singh <itachis6234@gmail.com>
X-Google-Original-From: Ajeet Singh <itachis@FreeBSD.org>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Mark Corbin <mark.corbin@embecsom.com>,
 Ajeet Singh <itachis@FreeBSD.org>
Subject: [PATCH 05/18] bsd-user: Add prototype for RISC-V TLS register setup
Date: Fri,  2 Aug 2024 18:34:10 +1000
Message-Id: <20240802083423.142365-6-itachis@FreeBSD.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240802083423.142365-1-itachis@FreeBSD.org>
References: <20240802083423.142365-1-itachis@FreeBSD.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::30;
 envelope-from=itachis6234@gmail.com; helo=mail-oa1-x30.google.com
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

From: Mark Corbin <mark.corbin@embecsom.com>

Included the prototype for the 'target_cpu_set_tls' function in the
'target_arch.h' header file. This function is responsible for setting
the Thread Local Storage (TLS) register for RISC-V architecture.

Signed-off-by: Mark Corbin <mark.corbin@embecsom.com>
Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
---
 bsd-user/riscv/target_arch.h | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 bsd-user/riscv/target_arch.h

diff --git a/bsd-user/riscv/target_arch.h b/bsd-user/riscv/target_arch.h
new file mode 100644
index 0000000000..26ce07f343
--- /dev/null
+++ b/bsd-user/riscv/target_arch.h
@@ -0,0 +1,27 @@
+/*
+ * RISC-V specific prototypes
+ *
+ * Copyright (c) 2019 Mark Corbin <mark.corbin@embecsom.com>
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
+void target_cpu_set_tls(CPURISCVState *env, target_ulong newtls);
+
+#endif /* TARGET_ARCH_H */
-- 
2.34.1


