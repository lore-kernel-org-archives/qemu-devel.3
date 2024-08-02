Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3D82C52D1D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 08:36:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZnkP-0007Zn-C6; Fri, 02 Aug 2024 04:34:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sZnkN-0007To-Sp
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 04:34:47 -0400
Received: from mail-oo1-xc30.google.com ([2607:f8b0:4864:20::c30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sZnkM-0006R4-7q
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 04:34:47 -0400
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-5c669a0b5d1so5328335eaf.3
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2024 01:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722587685; x=1723192485; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QGiV2F6p64OjUB3Dpp7weEVCbu80kzz21BKYIdntjk4=;
 b=L4nrDC4Gc3S4Xbzn/QKG8T28kuk63FoTz6MHKzERaRhuUSxkAa+gGQ/PcKr3T1VtEO
 m8VhmAhU4YXGYVDno2z5vwovNKH4QWSz3o6wRTsC2/7yPZaXTnNsFLcU1hj7jmjn2+oi
 Utj09gM+G5y5vpB9oRYpWgST3OGT7XrJ9v6zjEF7IHqhCPEaa8kzpBnn7WtRPzXF6RrL
 ifJyLsctRDVt2swwN6i5Fu4sz7+katyJpl/FuMmIuohJDGddnylpU0k4k5nD+fCpMd6M
 t72dHNLOIxmgArYCzy3HJr7qyHzKvZ61MV3yuUUCB6rxjXgf0WLI5vOXrlJlxUJmUD9P
 8Tow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722587685; x=1723192485;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QGiV2F6p64OjUB3Dpp7weEVCbu80kzz21BKYIdntjk4=;
 b=BsGr2VA7GMnAP8KEyKLWz5siL4COLuvF0ONBc+We5WYZu8rhd/GgWhCH5FHfboSLkS
 i9+PO552zZy6MBCtSa3BtCvXJ7yZigrlT3Zq0UzsftV5J5pM4LXcKSWvzkG4MBuoD4We
 zkDCD1PRW0gZCWQjGhcjtpEFe3E71PF2x4dtVyGd1nIzy571csb4pxJAaWq40N291B2x
 NfWMaXcGiwXLXbpwW2dFB6RUBGhVScpYKMZ+gR01KrSAu7hfVLMacdYSE9GaeWSVlh84
 Gm+An0KiM+YzSgZ+y8wVjgqXD8D3pyX5igX6akh2kQWNR22mKTC6+kKHdWNPUk9sS4ev
 Es5w==
X-Gm-Message-State: AOJu0Yzq3VMwoirz/3Q0IweztIFqsmwHSwmUSBZf6+M0KkkMk6mKqzuX
 X+OY/wxsahmnEclFNDgElVMbFG2LjOMO5aknf9nLZO4YbN7eJP68oLyiXnm6de0=
X-Google-Smtp-Source: AGHT+IGYFKIvdPIA1A1xmD88IingEBSO9TzArM/7X0nsAyejC3Nrh51SXmdc+KP8LiTAJ74sA1r+Vw==
X-Received: by 2002:a05:6870:c0cd:b0:25e:12b9:be40 with SMTP id
 586e51a60fabf-26891d655c5mr2829755fac.25.1722587684882; 
 Fri, 02 Aug 2024 01:34:44 -0700 (PDT)
Received: from localhost.localdomain ([203.87.101.91])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7106ec06a25sm951673b3a.33.2024.08.02.01.34.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Aug 2024 01:34:44 -0700 (PDT)
From: Ajeet Singh <itachis6234@gmail.com>
X-Google-Original-From: Ajeet Singh <itachis@FreeBSD.org>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Mark Corbin <mark.corbin@embecsom.com>,
 Ajeet Singh <itachis@FreeBSD.org>
Subject: [PATCH 04/18] bsd-user: Implement RISC-V TLS register setup
Date: Fri,  2 Aug 2024 18:34:09 +1000
Message-Id: <20240802083423.142365-5-itachis@FreeBSD.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240802083423.142365-1-itachis@FreeBSD.org>
References: <20240802083423.142365-1-itachis@FreeBSD.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c30;
 envelope-from=itachis6234@gmail.com; helo=mail-oo1-xc30.google.com
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

Added the 'target_cpu_set_tls' function to handle setting the Thread
Local Storage (TLS) register for the RISC-V architecture.

Signed-off-by: Mark Corbin <mark.corbin@embecsom.com>
Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
---
 bsd-user/riscv/target_arch_cpu.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 bsd-user/riscv/target_arch_cpu.c

diff --git a/bsd-user/riscv/target_arch_cpu.c b/bsd-user/riscv/target_arch_cpu.c
new file mode 100644
index 0000000000..44e25d2ddf
--- /dev/null
+++ b/bsd-user/riscv/target_arch_cpu.c
@@ -0,0 +1,29 @@
+/*
+ *  RISC-V CPU related code
+ *
+ *  Copyright (c) 2019 Mark Corbin
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+#include "qemu/osdep.h"
+
+#include "target_arch.h"
+
+#define TP_OFFSET       16
+
+/* Compare with cpu_set_user_tls() in riscv/riscv/vm_machdep.c */
+void target_cpu_set_tls(CPURISCVState *env, target_ulong newtls)
+{
+    env->gpr[xTP] = newtls + TP_OFFSET;
+}
-- 
2.34.1


