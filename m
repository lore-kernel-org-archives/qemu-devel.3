Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D741C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 08:35:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZnkh-0000Uh-IK; Fri, 02 Aug 2024 04:35:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sZnkf-0000NL-P4
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 04:35:05 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sZnkd-0006Wq-So
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 04:35:05 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-7105043330aso2172619b3a.0
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2024 01:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722587702; x=1723192502; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IXOzHuv1KBwhfMLjBnTL63jnN0X+gTMftdAakppgxGM=;
 b=Hyhjder7vum4+kme6hdluG8jzb1CSXXUKIxiiGY7vaAMlITh5TZWj8mlywGaq03ZIu
 WUSa9g6bDkukykVplgp11VP+uwljHu7w3+1YYXuFMYWQTzO/MTPLjde7EXYPuCQqKHaS
 5xJFzIiK2IzWm6POnV6n9ZG2Vos435+69jviGKq8d8oqFORxpA6J9hUWEWPnGubV9lIo
 mGGpOlmUWg6E2oSu4BE2TxhjDCfvSmo5nWrrNKTUvbptDpRNS0CmnfXCfr0B1CiODY9K
 GgFhpttHpyWzZB8gQrqC4xbWQKapOHCJhCQL6y7aLa3Ww1L+psa+GQl4iyNfMWuY3Znr
 GQ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722587702; x=1723192502;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IXOzHuv1KBwhfMLjBnTL63jnN0X+gTMftdAakppgxGM=;
 b=jy31X3lW6RkRzdogbGs15wvS3/55QKMa6p1OViM661J4HGWnZS13Js2NuLGpSVS08m
 lXWdOozXh0R7PeSgivvnfrCDF6lZlOgbLh3TFhk1gjO1kjorzQogEySc2GYGOm4bKnAu
 5QuB6RD3MJir860OTTJmFg3zr351adT2GV1nqufgkB0wALx7eSGgx3biP9h3ySnfAGmG
 Lph3LUJTEi7/meiSBLycIRPsMM4fbyNVIJs4VBp21py/XwstEtbIbixpfWd8BpXLFYtb
 5zRXBJZlthBQ37cygPTjgfT7IEOsyKXnLEHmVKwiRYogVDscHWnbgXnbXewjOhTAHHSg
 aaYg==
X-Gm-Message-State: AOJu0YyqKL8gUW0S5tEW58C5CcyTp+Wu18hfNj/wUfLIccAAYsNgZqUj
 37DiuVSGtWFjUJNoqNS/W/CQ0qIGDChwRcfaQvDXXOX3FH3G8OKWnXZn3h7qh0c=
X-Google-Smtp-Source: AGHT+IGkoihWQrgJou95dzuMHPBiWUfAjA+2xXQr2z9g59U1fu9fJ49fFHn/hhUD6ApQEc62R8AA9w==
X-Received: by 2002:a05:6a00:4f82:b0:70d:2497:383 with SMTP id
 d2e1a72fcca58-7106cfe179cmr3197936b3a.18.1722587702173; 
 Fri, 02 Aug 2024 01:35:02 -0700 (PDT)
Received: from localhost.localdomain ([203.87.101.91])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7106ec06a25sm951673b3a.33.2024.08.02.01.35.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Aug 2024 01:35:01 -0700 (PDT)
From: Ajeet Singh <itachis6234@gmail.com>
X-Google-Original-From: Ajeet Singh <itachis@FreeBSD.org>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Mark Corbin <mark.corbin@embecsom.com>,
 Ajeet Singh <itachis@FreeBSD.org>
Subject: [PATCH 11/18] bsd-user: Define RISC-V VM parameters and helper
 functions
Date: Fri,  2 Aug 2024 18:34:16 +1000
Message-Id: <20240802083423.142365-12-itachis@FreeBSD.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240802083423.142365-1-itachis@FreeBSD.org>
References: <20240802083423.142365-1-itachis@FreeBSD.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=itachis6234@gmail.com; helo=mail-pf1-x42e.google.com
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

Added definitions for RISC-V VM parameters, including maximum and
default sizes for text, data, and stack, as well as address space
limits.
Implemented helper functions for retrieving and setting specific
values in the CPU state, such as stack pointer and return values.

Signed-off-by: Mark Corbin <mark.corbin@embecsom.com>
Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
---
 bsd-user/riscv/target_arch_vmparam.h | 53 ++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 bsd-user/riscv/target_arch_vmparam.h

diff --git a/bsd-user/riscv/target_arch_vmparam.h b/bsd-user/riscv/target_arch_vmparam.h
new file mode 100644
index 0000000000..0f2486def1
--- /dev/null
+++ b/bsd-user/riscv/target_arch_vmparam.h
@@ -0,0 +1,53 @@
+/*
+ *  RISC-V VM parameters definitions
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
+
+#ifndef TARGET_ARCH_VMPARAM_H
+#define TARGET_ARCH_VMPARAM_H
+
+#include "cpu.h"
+
+/* Compare with riscv/include/vmparam.h */
+#define TARGET_MAXTSIZ      (1 * GiB)           /* max text size */
+#define TARGET_DFLDSIZ      (128 * MiB)         /* initial data size limit */
+#define TARGET_MAXDSIZ      (1 * GiB)           /* max data size */
+#define TARGET_DFLSSIZ      (128 * MiB)         /* initial stack size limit */
+#define TARGET_MAXSSIZ      (1 * GiB)           /* max stack size */
+#define TARGET_SGROWSIZ     (128 * KiB)         /* amount to grow stack */
+
+#define TARGET_VM_MINUSER_ADDRESS   (0x0000000000000000UL)
+#define TARGET_VM_MAXUSER_ADDRESS   (0x0000004000000000UL)
+
+#define TARGET_USRSTACK (TARGET_VM_MAXUSER_ADDRESS - TARGET_PAGE_SIZE)
+
+static inline abi_ulong get_sp_from_cpustate(CPURISCVState *state)
+{
+    return state->gpr[xSP];
+}
+
+static inline void set_second_rval(CPURISCVState *state, abi_ulong retval2)
+{
+    state->gpr[xA1] = retval2;
+}
+
+static inline abi_ulong get_second_rval(CPURISCVState *state)
+{
+    return state->gpr[xA1];
+}
+
+#endif /* TARGET_ARCH_VMPARAM_H */
-- 
2.34.1


