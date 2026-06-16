Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D40FCD98CF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 10:06:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZQg9-000553-OJ; Tue, 16 Jun 2026 06:05:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQg7-00054h-Vn
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:05:55 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQg6-00033P-Hz
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:05:55 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-36d98b9aa9aso3623111a91.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 03:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781604353; x=1782209153; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KX7LKRUEmaPWFdqNenUETTxw3hyG38BE2t7qHLxi9u8=;
 b=hMbgnAU6LDg3sa/eFfztUZnkdwjnB2qfpOxkJawkCDAozGL+B8UCCUu4oJqV/ERHCx
 KdwBZbBsPcL03xXp7PobQ/cxGbE1XSapu8CgeE/FdVha7uVkGEB+GiiZmKs2Hv7e/zJu
 tTzFRV/of4M3Fvv4FZTJaxOsXGWp+pGXuApr8jQepdHd2e6L9f9kGHHtwhB2qQSAHFWn
 Bvd0e6HvOJ6c0iqiBZ2Ktt96Xs/SFDXH98ygC2pUOiPKB6ckOjBVKhttkzaOLnKbd7iE
 HzGv0yTnHwwugD6Nvwrl00FzRNS8RgvKcAwcEJZuxejQbvozJBfwDXN+J/ZavIK/MHe8
 G/GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781604353; x=1782209153;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KX7LKRUEmaPWFdqNenUETTxw3hyG38BE2t7qHLxi9u8=;
 b=fZ/+RgqBrgmToUxQ1bPcKCb3mRP6p3+LcJNpU3khV3upfPEoE/BF/ENTM9/SzFjwMh
 LbY6L/B27MbJn/pxK5ob9PsbkzVqNBCduWaBWcq29ZHNbweF40toaRAo6qcekQ4gkMZ9
 QY0KtiUPjJq7LRLBhhthoymjd53nS7G6kRwDBNk9zBlewBp86ZwzzK6mX+vJYrsiiL1B
 sWfbKXobD9KCHjcWTD8PTg8CEUDIb3N2poV1B31O0eGPBhSLUBpb7U0LzkrnMXbwXh2J
 tms0zqSXqwvPxxcPlTOJzVjsJHfFC8oCI2NAWxYBU4Ue3ePQNuscS2iCsVdE3zIAzfGW
 TZ3g==
X-Gm-Message-State: AOJu0YyyoKCgPwtcUZbooDVbmFsnWFeURxbChFSQv1TlZot2VOJqKQYO
 GJZ6UFvdtLmgKGHmfYKrN+Q5xscraHURtQc9puU0RPlE2DSrUuxaNcbokhOet43V
X-Gm-Gg: Acq92OHAAeIQjfnB5qamlZdnBQ4bZ7zqoIhke8PATxVWo/EgQHEK0LFNCksZkiWx3SY
 6UWr5EbM+sckEJ0jOQ7bfBe78f6aWKrPNUypmYi17qoDPIV4T3DEYWJMWnwYiu8nZw8CMKptSke
 kPdJPl24r4tMKoDDQdhO3Ic4/oTXDS13UfnjxTJtwm0bu+h6yRjwopNrvB10xQ2LnZWnAvwwEbL
 5DidWcAEKKRDOHHZ11F8TYoCpCs2QgAK2TnIx4i0jMtKSgBxLaY1+B5MebQyJQZwxDhi13/uYv9
 //OXnUj8N45Lsz/oKXqRT573AscPaGmWbTHmM3stRSZhO8kRglCn7iMtbfJSdCYls1UHEvG5Dr/
 biOBLQ+/eTELj1sH9a3Ju7wDBhIzMRJTOeavHkdAt/9zi185bDhWbKxxgOvGffqxL6AVDV+u3ut
 4K9GUJLmHY5xEwPL77iDSRxgsB1dkGUA5DPmXbTXpd
X-Received: by 2002:a05:6a21:9217:b0:3b4:931c:3c7c with SMTP id
 adf61e73a8af0-3b78420cc3bmr19493874637.44.1781604352784; 
 Tue, 16 Jun 2026 03:05:52 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c866519f0a6sm10916735a12.22.2026.06.16.03.05.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 03:05:52 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 05/83] target/riscv/csr.c: fix mstatus.UXL reserved value
Date: Tue, 16 Jun 2026 20:04:08 +1000
Message-ID: <20260616100527.1939565-6-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616100527.1939565-1-alistair.francis@wdc.com>
References: <20260616100527.1939565-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1035.google.com
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

From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

By the priv spec the value "3" is marked as 'Reserved' for mstatus.UXL.
Handle a mstatus.UXL = 3 write by writing the current 'xl' instead.

Fixes: https://gitlab.com/qemu-project/qemu/-/work_items/3367
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260514194537.2416243-3-daniel.barboza@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/csr.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 83ca354bf0..d004a4bfb4 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -2045,7 +2045,17 @@ static RISCVException write_mstatus(CPURISCVState *env, int csrno,
 
     if (xl != MXL_RV32 || env->debugger) {
         if ((val & MSTATUS64_UXL) != 0) {
+            uint64_t uxl = val & MSTATUS64_UXL >> 32;
             mask |= MSTATUS64_UXL;
+
+            /*
+             * uxl = 3 is reserved so write the current xl instead.
+             * In case xl = MXL_RV128 (3) write MXL_RV64.
+             */
+            if (uxl == 3) {
+                uxl = xl == MXL_RV128 ? MXL_RV64 : xl;
+                val = deposit64(val, 32, 2, uxl);
+            }
         }
     }
 
-- 
2.54.0


