Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19420CD98CF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 10:07:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZQgZ-0005NB-Ad; Tue, 16 Jun 2026 06:06:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQgR-0005HR-H9
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:06:16 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQgM-00036c-DJ
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:06:15 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-c8584e80bd9so1645149a12.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 03:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781604369; x=1782209169; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2ug30j1QvZy8RVzOFBrm89mLtJIT67kIt1gXjNG6aqQ=;
 b=owMFGCbP/bSBrIeVlFVdQPAS2yP20rQtIO+vgmsTGrMwwUEzkabsHQVbNwbeQ3WQJ9
 enxxP3aiEVaH417i3v5E7LJPKkOd2drwjkcomhw0XwcVbOsX+72afOp2CDW1foxwmfVX
 EOwCeesNTXNozthV1Hl9haUCMzMG/TLu7eyYGwcYG06dfzS2fLtDk3vIRck7s/KGMvJN
 /0HvRZ+owvu0vKDWvnv4iL/Mi4/ZF/aK9NUc3YZssOue5vhyD6/Hqw+iQb2pXt5Mt0yn
 GAc3JEyiNf8fGs0qy0ISBbjXCutArX+Ik59tAZFNEUgDGErNtb4T9hsUIheb3knEvIfw
 IcAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781604369; x=1782209169;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2ug30j1QvZy8RVzOFBrm89mLtJIT67kIt1gXjNG6aqQ=;
 b=lFhCpTep7kQmGd5Vf6Z2IKGXUDcPOWaAD0XD8sDdaD8EU/0AMcpKMAw+kg2AczTdS4
 trdxoR1QF5c7pjqOo7UoKDnXGxz4ILJDaUWytjXNiRj7ugJhNZ0LQoKevBt3GHZ/dptg
 8aaqh4LesqvVDTvYO/maeLl13DMhRXankcB8Dxwu3TN+fdT2buC5aX8UJg+2EAOrBYpv
 bQMJYMDV0tPK0nPe1bN+DJ3E72RuniPZQ6U2d2ti/rf7uhxZoGqJgod/vHr1ypfQUPJk
 KsNTW5FBkmBzT3UHF8xBiSx/UtpdLn+FsRRBnrwoh1SzudXr68uJ3Uo5o5ePfnt1i0g7
 Wkxw==
X-Gm-Message-State: AOJu0YzwcF4rgUuvi9JfUaCxMOdN5eTOsZH0OJrjUlqd6Ki7DY+WaI+x
 MMreD9wNtkEsbzM2CVQy2OmicRqgE58NeUsIYTmp4hDanU1dZVUm0ne6o5OIxdYB
X-Gm-Gg: Acq92OF66cQ+EskKVHOSvIMLgxly/XVjG+2U9Rs/Cb9lAIqy0iCrlGeK+IAV8llXMDz
 ZOhUj/t5OBvgjKYbcVkjXViY8Pkz8yIA7qlQ6Ian8J9m07S6yYhWXOuuS2F25MUkgjsI7g6dFRW
 8AP3JUAV0D8o/J4AGOdux8T7fyAM5QVNtt/5Zsa15OTPszrTXHaIFGzwqbkIZ/DOTlywg8A1xCA
 AORr57j9Kh01q/TPJ4IIp23UGeC1CBxJtEhCJghlKfJ41MwNCjC1zJjWl100C1Sl8oFG1qfTt8d
 Z6f+ENmjAoxCJJeM0bWlNj2SvIoV4vgzdyTepNPhIMFW+AkyfWQq6N8YMdZpda7AZzsbYL/r4YE
 XD90lMP/4q1RVl9GBzHB2yF8wa+JzFeJJUN4UQ52zfQal6Pjg6mdknk36YQysY4G8JijNPx8+Vc
 Ii39upHCSeV+6oK80QWPnRzY85y/egMdC3vjSs3gcX
X-Received: by 2002:a05:6a20:db0c:b0:3b4:b24e:27a2 with SMTP id
 adf61e73a8af0-3b7e4d4dc3emr3315796637.31.1781604369200; 
 Tue, 16 Jun 2026 03:06:09 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c866519f0a6sm10916735a12.22.2026.06.16.03.06.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 03:06:08 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 10/83] target/riscv/cpu_helper.c: fault with reserved PTE.PBMT
 val
Date: Tue, 16 Jun 2026 20:04:13 +1000
Message-ID: <20260616100527.1939565-11-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616100527.1939565-1-alistair.francis@wdc.com>
References: <20260616100527.1939565-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x52a.google.com
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

We need to fault during any access done while PTE bits 62-61 are both
set, according to the RISC-V priv spec.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3494
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260521130727.2311629-1-daniel.barboza@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_helper.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 17305e1bb7..bc63713ddf 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -1446,6 +1446,25 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
                 return TRANSLATE_FAIL;
             }
 
+            /*
+             * priv spec, "Svpbmt" chapter:
+             * "For non-leaf PTEs, bits 62-61 are reserved for future
+             * standard use.  Until their use is defined by a standard
+             * extension, they must be cleared by software for forward
+             * compatibility, or else a page-fault exception is raised."
+             *
+             * For leaf PTEs the same bits are also reserved but in that
+             * case the page-fault is mandatory.  Make both cases consistent
+             * by also page faulting here.
+             */
+            if ((pte & PTE_PBMT) == PTE_PBMT) {
+                qemu_log_mask(LOG_GUEST_ERROR, "%s: PBMT bits 62 and 61 are "
+                        "reserved but are set in PTE: "
+                        "addr: 0x%" HWADDR_PRIx " pte: 0x" TARGET_FMT_lx "\n",
+                        __func__, pte_addr, pte);
+                return TRANSLATE_FAIL;
+            }
+
             if (!riscv_cpu_cfg(env)->ext_svnapot && (pte & PTE_N)) {
                 /* Reserved without Svnapot extension */
                 qemu_log_mask(LOG_GUEST_ERROR, "%s: N bit set in PTE, "
@@ -1498,6 +1517,23 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
         return TRANSLATE_FAIL;
     }
 
+    /*
+     * priv spec, "Svpbmt" chapter:
+     * "For leaf PTEs, setting bits 62-61 to the value 3 is reserved
+     * for future standard use. Until this value is defined by a
+     * standard extension, using this reserved value in a leaf PTE
+     * raises a page-fault exception. "
+     *
+     * Raise a fault if 62-61 (i.e. PTE_PBMT) are set.
+     */
+    if ((pte & PTE_PBMT) == PTE_PBMT) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: PBMT bits 62 and 61 are "
+                      "reserved but are set in leaf PTE: "
+                      "addr: 0x%" HWADDR_PRIx " pte: 0x" TARGET_FMT_lx "\n",
+                      __func__, pte_addr, pte);
+        return TRANSLATE_FAIL;
+    }
+
     target_ulong rwx = pte & (PTE_R | PTE_W | PTE_X);
     /* Check for reserved combinations of RWX flags. */
     switch (rwx) {
-- 
2.54.0


