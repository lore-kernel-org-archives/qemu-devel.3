Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F5BAFF8867
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 04:57:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHwrL-0001co-Nx; Wed, 29 Apr 2026 00:49:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wHwrK-0001Zk-8i
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 00:49:14 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wHwrI-0008N5-Px
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 00:49:14 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2b0afa0210bso55920035ad.2
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 21:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777438151; x=1778042951; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cRThZhlDdYDMRAwOPXW2eKuqfgG85s+OsOROYluam24=;
 b=RGXLiU+QBDaXlxfC2bGxsfDSO5a5beiCKg2ysQr7pv5o6G17kNtB5Brz13WaVea2ON
 GWIOEiJHe3t1koYGltm91nsOOxjW+MxYXtwk+qWFViDyQZ1lOvohiFJ3cgPklmAXIawH
 +sbv9tP656MoFpT+wbB3rOX9WhWjGV4m3ysC5twW54EWxg11xosBmm9IWzado2lwXDpF
 5RA18E8evebyVJf8WAS/0jdTUBZnvFuuLOqhbwp64cRHs/2aBEVkUQ+6VKrS6+Ml+icg
 RxUq6r8ykSDCRjdInIgq0fsgS6ZLe3+Wyj9ct4YvuNveMQg5SQ69x5aWvD5uSszuezJO
 W+IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777438151; x=1778042951;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cRThZhlDdYDMRAwOPXW2eKuqfgG85s+OsOROYluam24=;
 b=Tsi04eNxE3JJ/e9wb9X6aWy+XNn79eNIB+2Wf0ZhqBio7nOscdE7K86ArBnrzT7FGA
 nT5fx/zYianQZH8oampuhoxn1QAFwmHmnahfxKcd8vHyns4ds8pVPVK0liqO5DXn9cXF
 YcFo8tWyXFO42flhedpB6dX0RMxKJVLk4xqhSfX/czDdI7G+2Z7hwvfbTOFqA+OdMxWI
 MB9BU2UlYPLzw1fTywuS1Rr+YZgBbSfxWsgZajGXRYQVhnXGAUcRlp2Sp3bQ3eVP5PPL
 5IVT/6RktCT127osUssvR8TT0rp3RfAggevJ/yaf0XqcNKUHpI42NvryenH2estOzBNA
 ZtyA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9H2lm9fV3blX0eHoJS2bAEQhXHpkli6ic+EstUG42h6j/4Hu9A4BOvvsSvZ8132/acWNfz0ULAyO+3@nongnu.org
X-Gm-Message-State: AOJu0YxAX9/T4qG0fNXOvmnkby+clwdFDr3043Rg5u0lnSZCDClIhQIw
 61MLfGjQsK1V8AMB9uXdnhQ3B2GY90iFnX8wSlo3MO42Pe0zy/BDEbAb
X-Gm-Gg: AeBDieu9z8ntS5QsuXpOFcR6BgJBXOtTkex81gC4p7VjhwddC7n9oJceaIqsGhmW5m7
 Nf5h/Ba/5K0tl3hBkMBA8Le06STNnRLgZJQcdgJmWG3tWkybFz+cUbmohDR3RMJi943wLXwV4Te
 QVlxwOTa4xEl5I1v4BOw/mUmo9BlwGPAMIVZM72J27HrWHhr7bx0YdB4uBPLvBlgF5avft94ewG
 gQLr2FiMyaSKfRinrlaqqyw/G9w0oiW6RSlMFObouDhQvs9pQysqFGbijchKAU60bDt9VFAYkEF
 UfBntUKrFP89Gmjj1bqjTNo4MdZ7oSs+yBtguhSvffYkuc4IH0+DWd7c8A+VLJrTH0pkQ9AAbjO
 Zo+VhSA73bqgMNee18PQ3Fu6HqxWKRRbOg0yotfhVuTnIwuKfaF0lyQTenrCyrAkpQRQllBiDnw
 A2WLGv1RnwLarhE1ltp2X33bGZVK8PkCUjcStIuoY8o5X//G2fFsY4
X-Received: by 2002:a17:902:8b88:b0:2b7:86be:7673 with SMTP id
 d9443c01a7336-2b9872f8691mr15236545ad.6.1777438151302; 
 Tue, 28 Apr 2026 21:49:11 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b988772ae8sm7756145ad.7.2026.04.28.21.49.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 21:49:10 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: palmer@dabbelt.com, liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 12/51] target/riscv: Expose mo_endian_env()
Date: Wed, 29 Apr 2026 14:47:13 +1000
Message-ID: <20260429044752.4176397-13-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260429044752.4176397-1-alistair.francis@wdc.com>
References: <20260429044752.4176397-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x632.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Move mo_endian_env() definition to "internals.h" for re-use.
Do not restrict to system emulation only because this will
also be used by user emulation code.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260318103122.97244-10-philmd@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/internals.h | 12 ++++++++++++
 target/riscv/op_helper.c | 14 --------------
 2 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/target/riscv/internals.h b/target/riscv/internals.h
index 35b923c4bf..860c47732b 100644
--- a/target/riscv/internals.h
+++ b/target/riscv/internals.h
@@ -62,6 +62,18 @@ static inline bool mmuidx_2stage(int mmu_idx)
     return mmu_idx & MMU_2STAGE_BIT;
 }
 
+static inline MemOp mo_endian_env(CPURISCVState *env)
+{
+    /*
+     * A couple of bits in MSTATUS set the endianness:
+     *  - MSTATUS_UBE (User-mode),
+     *  - MSTATUS_SBE (Supervisor-mode),
+     *  - MSTATUS_MBE (Machine-mode)
+     * but we don't implement that yet.
+     */
+    return MO_TE;
+}
+
 /* share data between vector helpers and decode code */
 FIELD(VDATA, VM, 0, 1)
 FIELD(VDATA, LMUL, 1, 3)
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 6ccc127c30..dde40a5549 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -28,20 +28,6 @@
 #include "exec/tlb-flags.h"
 #include "trace.h"
 
-#ifndef CONFIG_USER_ONLY
-static inline MemOp mo_endian_env(CPURISCVState *env)
-{
-    /*
-     * A couple of bits in MSTATUS set the endianness:
-     *  - MSTATUS_UBE (User-mode),
-     *  - MSTATUS_SBE (Supervisor-mode),
-     *  - MSTATUS_MBE (Machine-mode)
-     * but we don't implement that yet.
-     */
-    return MO_TE;
-}
-#endif
-
 /* Exceptions processing helpers */
 G_NORETURN void riscv_raise_exception(CPURISCVState *env,
                                       RISCVException exception,
-- 
2.53.0


