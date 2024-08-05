Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66BF2C3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 20:18:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sb49C-0002Fs-AU; Mon, 05 Aug 2024 16:17:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3WTOxZgUKCsAzg1ovmuumrk.iuswks0-jk1krtutmt0.uxm@flex--tavip.bounces.google.com>)
 id 1sb499-00026I-S5
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 16:17:35 -0400
Received: from mail-pg1-x54a.google.com ([2607:f8b0:4864:20::54a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3WTOxZgUKCsAzg1ovmuumrk.iuswks0-jk1krtutmt0.uxm@flex--tavip.bounces.google.com>)
 id 1sb497-0001Pu-Vn
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 16:17:35 -0400
Received: by mail-pg1-x54a.google.com with SMTP id
 41be03b00d2f7-7b04199911bso5796187a12.1
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2024 13:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1722889050; x=1723493850; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=SynE1NM0itYAW6y78a0dTYINIivdU1VNZIPOm/FZTSQ=;
 b=DCXqC7f9kTxmFQzSruXWMX/P2LgEAcImIH1X0H8wstda6iFSy2GAzeV7FOr0Pq8NiZ
 WpLXEUbDhNbCy/3cgK5BABCuY8WQsVfy82t/MSiOZiLp9PNuP31GU1yuKFsHeji0RFZJ
 1oha8xuehJzM8MjjvKO42mpalPBvvP7SptPJJZaerMzFN0bTQM0nGOwqYxP6I+KTVzUl
 ogzccrMYVMcW0qcb4j0gMMQ6Z5vPa2yet9WGkUNNxLAPO83Gh4KWHoj9+umqohUXB7BW
 mgb/0uPbB3PL+FqRn0opu87fLkgmguSMAF2Otd6Deyd/pP3FrE9zZ3b9VS2FyvF9YqHu
 ThEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722889050; x=1723493850;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SynE1NM0itYAW6y78a0dTYINIivdU1VNZIPOm/FZTSQ=;
 b=YObONFlOHcK0ldqHklxeKKNBqVZbYTYi1wqOAEku6bpvXT4aVOAiIBr01UeZQDPQES
 V0+BimjgXXZjyEhBDqC4sbgV/D6vp3oCJ5F9+gH4g4DNuc8YiFQJtnpWsQVJRF+A6Ryf
 x4rgGZoWZzLVkUl34xf6jRG/BWjTVyuZz4CHobuVjbsogCh8I51iMfzIEYV+p9J/+Cw5
 dUJ1nXlTw5ZlDj1+jMPpnbqeFT3mbZZzrSDW2vokZkxy9YooeDLbSZY3GWiyAHb2+9FQ
 HUeY2wO9qLtmtJ2qKylmHbh+hp714n9EAGn0F+mB1jRcHUzZCkwmfULj9b2tkKAuIJ0p
 AjZw==
X-Gm-Message-State: AOJu0YxsPX5ottniQEDir0mfAwSLDqtPIz0U7MzuvdI31j1SlUKrZXab
 4JwzAbnNnzs2zmgiLPBSCpXXfnYcaooyAUSucWZevSYAW6km+UkgOqQy/ClngAbULkw/qsFUyr9
 wOXOjIAsRWKYUTk1LCjFrpRPTWWjzRgix38/2rko5hr6BHi4hR182NHva18SaFchpgSk/B6hwIH
 GnG8Auul2Y8S+bGkT9sK6dzP8uvg==
X-Google-Smtp-Source: AGHT+IFfBSsEqahvMxIS6/LupdiNY3e6rJCtmeO4bkS0j6KTqHR7pmRUWlSDt8ZH4z2nOAzbSbhP6de15w==
X-Received: from warp10.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:750])
 (user=tavip job=sendgmr) by 2002:a17:90a:1fc9:b0:2c8:632:7efe with
 SMTP id
 98e67ed59e1d1-2cff0c5c916mr186752a91.4.1722889049713; Mon, 05 Aug 2024
 13:17:29 -0700 (PDT)
Date: Mon,  5 Aug 2024 13:17:00 -0700
In-Reply-To: <20240805201719.2345596-1-tavip@google.com>
Mime-Version: 1.0
References: <20240805201719.2345596-1-tavip@google.com>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <20240805201719.2345596-6-tavip@google.com>
Subject: [RFC PATCH 05/23] hw: add register access utility functions
From: Octavian Purdila <tavip@google.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, stefanst@google.com, pbonzini@redhat.com, 
 alex.bennee@linaro.org, thuth@redhat.com, peter.maydell@linaro.org, 
 marcandre.lureau@redhat.com, alistair@alistair23.me, berrange@redhat.com, 
 philmd@linaro.org, jsnow@redhat.com, crosa@redhat.com, bleal@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::54a;
 envelope-from=3WTOxZgUKCsAzg1ovmuumrk.iuswks0-jk1krtutmt0.uxm@flex--tavip.bounces.google.com;
 helo=mail-pg1-x54a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=unavailable autolearn_force=no
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

Add register access utility functions for device models, like checking
aligned access and reading and writing to a register backstore.

Signed-off-by: Octavian Purdila <tavip@google.com>
---
 include/hw/regs.h | 89 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 89 insertions(+)
 create mode 100644 include/hw/regs.h

diff --git a/include/hw/regs.h b/include/hw/regs.h
new file mode 100644
index 0000000000..8d0da0629d
--- /dev/null
+++ b/include/hw/regs.h
@@ -0,0 +1,89 @@
+/*
+ * Useful macros/functions for register handling.
+ *
+ * Copyright (c) 2021 Google LLC
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef HW_REGS_H
+#define HW_REGS_H
+
+#include "exec/hwaddr.h"
+#include "exec/memattrs.h"
+
+#define BITS(hi, lo)       (BIT(hi + 1) - BIT(lo))
+#define BIT_IS_SET(v, b)   (((v) & BIT(b)) != 0)
+
+/*
+ * reg32_aligned_access
+ * @addr: address to check
+ * @size: size of access
+ *
+ * Check if access to a hardware address is 32bit aligned.
+ *
+ * Returns: true if access is 32bit aligned, false otherwise
+ */
+static inline bool reg32_aligned_access(hwaddr addr, unsigned size)
+{
+    if (size != 4 || addr % 4 != 0) {
+        return false;
+    }
+    return true;
+}
+
+/*
+ * reg32_write
+ * @base: base address
+ * @addr: register offset in bytes
+ * @val: value to write
+ * @wr_bits_array: RW bitmask array
+ *
+ * Update the RW/WO bits of a 32bit register backstore with a given value
+ * (discarding updats to the RO bits). The RW/WO bits are encoded in the
+ * @wr_bits_array with bits set being RW and bits unset being RO.
+ *
+ * Usage example:
+ *
+ * wr_bits_array[] = {
+ *    [REG1_ADDR/4] = 0xFF000000, // MSB byte writable
+ *    [REG2_ADDR/4] = 0xFF,       // LSB byte writable
+ *    // all other registers are read-only
+ * };
+ *
+ * // backstore is updated to 0x12000000
+ * reg32_write(&backstore, REG1_ADDR, 0x12345678, wr_bits_array);
+ * // backstore is updated to 0x78
+ * reg32_write(&backstore, REG2_ADDR, 0x12345678, wr_bits_array);
+ */
+static inline uint32_t reg32_write(void *base, uint32_t off, uint32_t val,
+                                   const uint32_t *rw_bits_array)
+{
+    uint32_t *ptr = base + addr;
+    uint32_t old_value = *ptr;
+    uint32_t mask = rw_bits_array ? rw_bits_array[addr / 4] : 0xFFFFFFFF;
+
+    /* set WO/RW bits */
+    *ptr |= val & mask;
+    /* clear RO bits */
+    *ptr &= val | ~mask;
+
+    return old_value;
+}
+
+/*
+ * reg32_read
+ * @base: base address
+ * @addr: register offset in bytes
+ *
+ * Returns: 32bit value from register backstore
+ */
+static inline uint32_t reg32_read(void *base, uint32_t addr)
+{
+    return *(uint32_t *)(base + addr);
+}
+
+#endif /* HW_REGS_H */
-- 
2.46.0.rc2.264.g509ed76dc8-goog


