Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 604DBCD98E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 10:11:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZQiA-0004Sw-44; Tue, 16 Jun 2026 06:08:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQi8-0004JK-6q
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:08:00 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQi6-0003ZL-8Z
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:07:59 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-36d630c0e35so4254014a91.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 03:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781604477; x=1782209277; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aDCgN8gmkzyX6a1YUeztPsr2d8QBaAYnsnmREj7auDM=;
 b=fQ8CMg8gRd3kHPl4qsTDcQAjx5dpy4oRux0D/ZywMKIIPiFSH5FwaJjQNByDZMTJTU
 jKXoO89JqfgA/LsF+aKUHCUZEfCTfg/WhDT4zLzOu0aUDjBf10+q1D1YyVoEcHi0X3kt
 DP/4It5L5JF8uh2xXQeSDcHEBerRypT3z60Yiuj+TRndSRCk5Fwgvh7GU1dB3y7xwZep
 p7WLFlZBAj8/LgaOOOq94OxXz4IQqzWduOEBvRDSaAFDTXqS0LTzrbPUIAABcGYn8En6
 hVjUcGG5Qi92Um1m/mIFkNHQvZdq0pSez+ruD7sH20MCxkmCtRrhZFKGDZUJqKrz1OP+
 75nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781604477; x=1782209277;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aDCgN8gmkzyX6a1YUeztPsr2d8QBaAYnsnmREj7auDM=;
 b=qAWxU5f8Z9d6JgmpZOlv4+haGOYThg4rRUui7yF3zblKwXRiXdtkkf32f6pUbs95FB
 PPMS4FUD5NHBxb5q0yRywzuF0bAGiNoiNMtTltPjtbsba7qEBJX2qF7s3x0PNrFNCPmq
 cQdLDhvIiZJQ17w6I5IuD2MWmrUuFvURa/8lPBejgwOsy/9mFFQMOzXF282Au6ywkH0L
 VakY18neFWv+3A8ImAt5d6Ht5Hb2/USi3No3zlw6KZmlufePpSm2/KKGK/cU0UL4iaoT
 Mv8/0NpkbNZNMrMrVAF4OzkSAqNp0gLNAByhcEk8SuKIREgrd0srJxp7ZaLNgat3wKhq
 siJg==
X-Gm-Message-State: AOJu0Yx/iv+UG2GyoMLq/hQ8k5e/WLOT/3bcF2V5u7wxSvVZ8IcHB9l6
 Bemk9ZfkYX3Mfd3snmTb3g/kHmDAw+EgLHNBOZDPfhRFpR90EG8shN0D4yHZF+GI
X-Gm-Gg: Acq92OFYWaW0TVe6HhNe701XH9WHKVsO6a/Wrh8q4URczDFMrzH7pswz5QHYgXS+mLw
 gIvajbby2SnYh24qd6iJGlHA1Gj3mJIzLJILaA2HCiNXCOdOv/S08HduJ0ntn48KPYvDMj9devH
 3pFAuQD2/xGV0Vl6zcdOL+w+aMwnpxU7vyGX2CU4g3KPSqJLCkNXi1OshicN2ZC5o/9awNvSSrw
 uWW6nDsnfUJLE8G+m0Uu3Nhi+V+CH+d8Gf6SWV7sR339ZDQKXvyLz4MgGwELQDjB13aSwD2OOzr
 PBf/z0GVNiSUDJSgiKjWB/g/HKV5qLh8UOnK71HEO9YChnRyg7ZUjigg7rSzFgvb/CARuPHWm3b
 ZvB8sEfJCsiw1dkWm3Q5RzYwso0t4PAVgEB9pvy+zF8jyXiAAcff+dkK2vRPG9vb2KmKnBrip8R
 SSleFLGnSl2hy/ujg6GGTIshLl0EHk5M67f8oKrC07
X-Received: by 2002:a17:90b:50cb:b0:36b:a2cc:485b with SMTP id
 98e67ed59e1d1-37c2bd52987mr14313958a91.21.1781604476647; 
 Tue, 16 Jun 2026 03:07:56 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c866519f0a6sm10916735a12.22.2026.06.16.03.07.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 03:07:56 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 41/83] disas/riscv.c: fix inst_length()
Date: Tue, 16 Jun 2026 20:04:44 +1000
Message-ID: <20260616100527.1939565-42-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616100527.1939565-1-alistair.francis@wdc.com>
References: <20260616100527.1939565-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1030.google.com
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

inst_length() can return 0 if 'inst' happens to not match any known
encoding (like [1]).  Returning 0 is not desirable, even for unknown
encodings, given that it will cause a loop in target_disas() later on.

The most recent version of the RISC-V unpriv spec ditched the
sophisticated instruction-length encoding.  We're now supporting only
16-bit and 32-bit length instructions, where:

"All the 32-bit instructions in the base ISA have their lowest two bits
set to 11.  The optional compressed 16-bit instruction-set extensions
have their lowest two bits equal to 00, 01, or 10."

So the code is now simpler, never returning 0, and in fact it's the same
thing we're already doing in insn_len() from target/riscv/internals.h.
Due to include shenarigans we can't use that function in disas/riscv.c,
but I believe we can cut ourselves some slack this time and not lose
sleep over a 1 line of duplicated logic.  We're documenting it though!

[1] https://gitlab.com/qemu-project/qemu/-/work_items/3479

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3479
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260527200355.2068879-2-daniel.barboza@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 disas/riscv.c | 20 ++------------------
 1 file changed, 2 insertions(+), 18 deletions(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index 36609efdf5..b8ec546883 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -5084,26 +5084,10 @@ static bool check_constraints(rv_decode *dec, const rvc_constraint *c)
     return true;
 }
 
-/* instruction length */
-
+/* Same as insn_len() from target/riscv/internals.h */
 static size_t inst_length(rv_inst inst)
 {
-    /* NOTE: supports maximum instruction size of 64-bits */
-
-    /*
-     * instruction length coding
-     *
-     *      aa - 16 bit aa != 11
-     *   bbb11 - 32 bit bbb != 111
-     *  011111 - 48 bit
-     * 0111111 - 64 bit
-     */
-
-    return (inst &      0b11) != 0b11      ? 2
-         : (inst &   0b11100) != 0b11100   ? 4
-         : (inst &  0b111111) == 0b011111  ? 6
-         : (inst & 0b1111111) == 0b0111111 ? 8
-         : 0;
+    return (inst & 3) == 3 ? 4 : 2;
 }
 
 /* format instruction */
-- 
2.54.0


