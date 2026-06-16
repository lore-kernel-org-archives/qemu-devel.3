Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71091CD98CF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 10:08:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZQhN-0000S5-5H; Tue, 16 Jun 2026 06:07:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQhL-0000JO-76
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:07:11 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQhJ-0003Mp-GN
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:07:10 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-c85ba774551so1573131a12.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 03:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781604428; x=1782209228; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4TnZbo83Oivu2UJ9QwpQikoITuKpWmQjIVYnelr1oZ8=;
 b=EFKQRcf6rG/KyEMNJ6saeQ9GBWLnzp+ZTmX52fAk0jbJTXfdbX9PCLVnLOrIa7shJW
 m9OF75YCyjoVr7U2siVsf+UY+tbyknJLLIGjY9OFI4YwduEHNP+NfvO9KXEyFjTZE73P
 xfr4odaaHWk7Ys0LOq9I71g2tw4epPGtUlV7NpjBXxuDiEqiiwIap2mLuAJqayucZZdZ
 tkL6JxsGhtzmhdcuyk+vY4DG8ickbVEIty9h5/Daur5Cf5d2ZArsJ7RPAwrH1fplRTrh
 l9EuIlly1GLQPT6uy4VvNonNBb0mqZmE2HPmcWW0XSHe3QvmjNa2VwEzrOsg7/QAHiWU
 t5GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781604428; x=1782209228;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4TnZbo83Oivu2UJ9QwpQikoITuKpWmQjIVYnelr1oZ8=;
 b=Tt4RlkcnKiZBkKSc4mNcaqli7bk5F0wOJLkdGIHYa5bsLkj4JU+9lS1b5VkSfdBdAB
 4zpWKJxfvGW4loW23HEz0JC3KTWAunRT+Tv/b4Tn1PaXBQSRqH/GNi+KXnqsIuj6/EeS
 Jv9c9PswcxcKvZbAydLUZYBNToTCguxS3ruAXjRPUm3Wi8VjV0Cn9ouJd8tTs7Iqs9yf
 TvFB7UcvSVoPuwZHwQ/aZ2O6OUKSAKJS/uU3y6aVkocWwGYdOv47G3I4yILwG5nbvVbY
 kV6aWOdPwLvkHC4FKtPCCr9CfXfxxXJib4tc0SrUee9XwGrqt7S1oQsehW/nGFARSITA
 G4NQ==
X-Gm-Message-State: AOJu0YywRjexUxuwG1r6nKbVDu5lePWuyBN4LZlLN/KhZRPY2vSGrCsm
 Qd4S7iJ8Hm36BHeLZJSyxw9VZRVo9cmwOl9M//61XgXIKk0KcbjY4+lpg2MnlWE3
X-Gm-Gg: Acq92OFqFDJz2m25/zWMc/JQyB9St4DoocNhpMMqLQ1CNaPFs1zb+sVEWmp+cCFcQyY
 J6716otqPybri4gOmgcHCHcvb/FqDB3IAVb8hDW4xPqM4Cp4ZAYNlZYWJ+vh3fd/6iClk3Y6AlN
 uUiYjzuyDvEMKt3Vnn+z1uvxi0kMUBo/B0SzF3+NFh6PYW8LaPW2dc2SuJxZW4fM/LgmsVw/lbV
 wgX2Ow+r/DMn7imOXtnq5BMArn4TSElV7lRQvxwcw4u3MP1iZSykgN/iexxtX87YyeAgdXD+lwx
 r2oWq4aymdQiiA0gKxWos5mIMVCaAoW6Y/vZCFo0r8xpjMIcAMt8cWljPYj3UoyEVEZCxdyRlHs
 /RzTliYLf5xns090shxDfWprOvaKlaoWsWYKN4r0hr7sfSvakkwqp0295jHcr4UQPt3q/uFU/9i
 79fKoHLQoiYxZGHCfvSp5KwTsoBqpTDhVYvSWnQGJD
X-Received: by 2002:a05:6a20:9f48:b0:3b2:86e8:a817 with SMTP id
 adf61e73a8af0-3b796409353mr16761094637.31.1781604428245; 
 Tue, 16 Jun 2026 03:07:08 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c866519f0a6sm10916735a12.22.2026.06.16.03.07.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 03:07:07 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 27/83] target/riscv: Fix size of irq_overflow_left
Date: Tue, 16 Jun 2026 20:04:30 +1000
Message-ID: <20260616100527.1939565-28-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616100527.1939565-1-alistair.francis@wdc.com>
References: <20260616100527.1939565-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x534.google.com
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

From: Anton Johansson <anjo@rev.ng>

Fix to 64 bits to hold all relevant values.  Also update comment to
reflect that irq_overflow_left stores the ns beyond INT64_MAX until the
next overflow, this to account for the uint64_t/int64_t timer value
difference between RISCV/QEMU.

Signed-off-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260520125406.28693-17-anjo@rev.ng>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 380749f9a8..5d01672f12 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -224,8 +224,8 @@ typedef struct PMUCTRState {
     uint64_t mhpmcounter_val;
     /* Snapshot value of a counter */
     uint64_t mhpmcounter_prev;
-    /* Value beyond UINT32_MAX/UINT64_MAX before overflow interrupt trigger */
-    target_ulong irq_overflow_left;
+    /* Value beyond INT64_MAX before overflow interrupt trigger */
+    uint64_t irq_overflow_left;
 } PMUCTRState;
 
 typedef struct PMUFixedCtrState {
-- 
2.54.0


