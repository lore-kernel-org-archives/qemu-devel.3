Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83B4EC2BA1A
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 18:59:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJHYp-0004NL-FE; Mon, 17 Jun 2024 14:58:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sJHYn-0004BA-0a
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 14:58:33 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sJHYl-0004wq-6Z
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 14:58:32 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-705e9e193caso1749191b3a.2
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 11:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718650709; x=1719255509; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dwK71C7tTjhNtrxFdTarX2bhgrmlVdQhmyIGbCJ+smo=;
 b=A8p3KcKiivlXvSuMdCceRgr/OiUbb/rKjx0CYD4zLmlOtMnwhBQtPbSRCGHZkgReXo
 MIVXbLMkP1mD+WKZ8D0Nol02nUWHORUizYhtxd/WxpyaIFhXPu9zmIBxnHoimGT+1Jn9
 LqJapfBMZCCSMeK/KhIkl44Ho9egd4xhIFNwlOYFw2LnwaXXsZ4PXU9qaxbHouwkapNG
 bBGbJlKnQOmc2re/EhSwp2j1MLjViuPvVqRHPH436teQ1Za3Z5HaM3Aw+k0LLPHmS23/
 fuKinW16K02vJZMq5gVncDZ192Ue6EFriLUze+eh+xopTrXfNP9/L6x1DAp73TLJLyD6
 EUlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718650709; x=1719255509;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dwK71C7tTjhNtrxFdTarX2bhgrmlVdQhmyIGbCJ+smo=;
 b=Gn1ExcUaDa9nyLDf5L3ykwwPzb/0GASO1dCySUWKZUrqUD53sKN4uWt0yx27rVl0FX
 GcelUenhF/KgD33dx1utLOPrN89YHQUzre5ElSE0WjVoVRhVN62GdFunO5i330QKpM/w
 PB+KoPSQFi2NhmyuxY5/0X6dtDse8GkPqKuNoa4JNnnxRw6K5F7aTfGpA+H/Idbkeedw
 Fja5TqRT5wPMJKmE9I4Ud+bIIs1wZ0xJ/y3it9KJbTCoEXqP/XAzvKxfcPhUE6AqzXzI
 Evy9TWKaobFelPEFxAeqqDICVGJ4BX776BarWm7qGFXR4d4jG0nkukQd36K1eoqmUtLy
 u8KQ==
X-Gm-Message-State: AOJu0YxUQvPYtMkZbwKS0+OwqlLnAxjgRIfy74x85v6F2KVy7XJI+BDi
 udft30ujMLxVfZ08RPA4XsuyCKowFAacHx/OU/SB0mpBxaYq/qm9Ctw5zs0GeyU=
X-Google-Smtp-Source: AGHT+IFqgN6h2P/8K0byogXjl41jdzz+l0KsyXEjxQI9vH7AUIwNfcdLQUoHOhAtN3EkOIJFXsHPpg==
X-Received: by 2002:a05:6a00:178e:b0:705:b0c0:d7d7 with SMTP id
 d2e1a72fcca58-705d70e3f01mr15639141b3a.7.1718650709331; 
 Mon, 17 Jun 2024 11:58:29 -0700 (PDT)
Received: from localhost.localdomain ([106.222.222.115])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-705ccb4aa4fsm7660637b3a.131.2024.06.17.11.58.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jun 2024 11:58:29 -0700 (PDT)
From: Ajeet Singh <itachis6234@gmail.com>
X-Google-Original-From: Ajeet Singh <itachis@FreeBSD.org>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Ajeet Singh <itachis@freebsd.org>,
 Stacey Son <sson@FreeBSD.org>, Ajeet Singh <itachis@FreeBSD.org>
Subject: [PATCH 04/23] AArch64 specific CPU for bsd-user
Date: Tue, 18 Jun 2024 00:27:45 +0530
Message-Id: <20240617185804.25075-5-itachis@FreeBSD.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240617185804.25075-1-itachis@FreeBSD.org>
References: <20240617185804.25075-1-itachis@FreeBSD.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=itachis6234@gmail.com; helo=mail-pf1-x430.google.com
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

Function to set and recieve thread-local-storage value
from tpidr_el0 register

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
---
 bsd-user/aarch64/target_arch_cpu.c | 34 ++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 bsd-user/aarch64/target_arch_cpu.c

diff --git a/bsd-user/aarch64/target_arch_cpu.c b/bsd-user/aarch64/target_arch_cpu.c
new file mode 100644
index 0000000000..70ef651827
--- /dev/null
+++ b/bsd-user/aarch64/target_arch_cpu.c
@@ -0,0 +1,34 @@
+/*
+ * ARM AArch64 specific CPU for bsd-user
+ *
+ * Copyright (c) 2015 Stacey Son
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
+#include "qemu/osdep.h"
+
+#include "target_arch.h"
+
+/* See cpu_set_user_tls() in arm64/arm64/vm_machdep.c */
+void target_cpu_set_tls(CPUARMState *env, target_ulong newtls)
+{
+
+    env->cp15.tpidr_el[0] = newtls;
+}
+
+target_ulong target_cpu_get_tls(CPUARMState *env)
+{
+
+    return env->cp15.tpidr_el[0];
+}
-- 
2.34.1


