Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27607C5DF98
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 05:52:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyNbd-0005mI-Fz; Mon, 24 Aug 2026 01:52:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNbG-00051m-2v
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:52:02 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNbE-0002zc-9a
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:52:01 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-cbee3777e1cso1795273a12.3
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2026 22:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787550719; x=1788155519; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oZV9gDbx+A65MEMcmH9Ce0cuAUaddw6IKp5G5U1reZI=;
 b=pZsfk7+OxCDmMNwvX/fIrNnx/X9z3HhVATSsDWdB7l/TqIAA0Q4mRk6dUVzgSCrOmR
 i2wV+cMf6i+jH1v01WDP+pD4vujD+8n59cCUYhW8X6Pr0RDKxDvTlK/fxunxqMlc/h53
 vO9dvUUDBHI0XM/CKmnr/pljziu0uVIjKk9sreJJ8jQwaiSx1Jnrx8mzfiy2DPSgWe4G
 7JNUWm99JXYe6asS455KIfdLPDqmVwBKYgrQmVLh+v3VxzuZvrCwT7hEWyJq+snch5nm
 obSpHaAxvUgll5ig7oj5wvowk34AH4VmgHFUB1k+96PbNdz52Rl0eLkw35ggaRpvoGor
 /8RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787550719; x=1788155519;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=oZV9gDbx+A65MEMcmH9Ce0cuAUaddw6IKp5G5U1reZI=;
 b=Kka1FW+r1fDL9OvDKjuAyajMK1S9T0QExi2Q+TawynISUtHF87ARBuOFdOg7QaXHFr
 X2olS3UWQ2XjfY4dX1my0gMLbrQExdZsWhkAnddJ8xJMzJKpGJHksMcLxeDNfkhEet5c
 ZxtSwA7/u4pFU0sRAhqAMwzuWIBjcP4rPbAdfQjPdVWzNGPqMVeJFn2WcpLKmTq/Vhma
 m895d+meVxxua1H6PPpjrEBbhPMl3DuPLbRYQNssrCBPhfWspbO8+5Sc7PO0xSchSTks
 GSlYB6cj81Pz9e0uXfCPBGQPThb2w4favnoBV4Dt6ZFBlIDWwIwWdledX6fBTXcwxjhE
 0cBA==
X-Gm-Message-State: AFuF++k37vWb6bfW34gtrponTzmKSJ9/TlZFh9uTDQz9IutgHXT7ywdZ
 UzHnST9IjkS0JIcXhvwx2Oyxm/toPmFGdkdz0JOAPgr+2euYt11EkMtdI1mwwA==
X-Gm-Gg: AR+sD12ED7msMxVMlBuZVDULXyuUsLMWwvAueiH0kR2cHuu0e1ey1FwH1VK+gL3otJi
 G6TdVbvMmOI/T4vSb5uLHYNeX3O3qP8xee5xp/nCElMsfwKI5Y9KEN6tFOdvm2u0GVIkfMawwQW
 Fi96gtjNXi+Fb3jCmpdk5ixqPujouQNQBt1QPuKkPMp/xGBngxzS/K/AZulUrbblMOUpMkPuDl4
 hlB1EfuImwwWBQY/F5msNML7u/YO+8HdvSwoP51Px/a50Jxkjx/3hZeyrfQFbeO82IfNGy6ZvEg
 bETLsvlT+0qhtXQ6fnlmmrqMTriFGL+mPexM1/TSBgOcLknU9SDb2JYVKcPF0qdFe4GuDasW1EC
 VXclzix8A3Ew0aUhYUUJfSkDlS7RkuWOPs/s51I4pUFEPjgDNtN77WZgWXtu0jmSJsU+qENcEly
 A5RSWpwysElP2NmoiUbbtV4c8hQ7Ef2CIb4NG/Ky3jJ0/o75/wvTSwXUGFr4TQ2Dx2hWwaDLKsZ
 QrSMA==
X-Received: by 2002:a17:90a:749:b0:395:f0e8:9e13 with SMTP id
 98e67ed59e1d1-395f0e8a0c0mr16553476a91.7.1787550718777; 
 Sun, 23 Aug 2026 22:51:58 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395c917d2f2sm4046005a91.3.2026.08.23.22.51.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2026 22:51:58 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-stable@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 73/96] disas/riscv: Fix typo in th.lbib format
Date: Mon, 24 Aug 2026 15:47:43 +1000
Message-ID: <20260824054806.2790041-74-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260824054806.2790041-1-alistair.francis@wdc.com>
References: <20260824054806.2790041-1-alistair.francis@wdc.com>
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

From: Richard Henderson <richard.henderson@linaro.org>

th.lbib should format the same as th.lbia, and the other
increment insns, with the address register in parenthesis.

Cc: qemu-stable@nongnu.org
Fixes: 318df7238b9 ("disas/riscv: Add support for XThead* instructions")
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260812223142.349142-41-richard.henderson@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 disas/riscv-xthead.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/disas/riscv-xthead.c b/disas/riscv-xthead.c
index 428a6380e9..fbc96631fd 100644
--- a/disas/riscv-xthead.c
+++ b/disas/riscv-xthead.c
@@ -189,7 +189,7 @@ static const rv_opcode_data xthead_opcode_data[] = {
     { "th.mulsh", rv_codec_r, rv_fmt_rd_rs1_rs2 },
     /* XTheadMemIdx */
     { "th.lbia", rv_codec_r2_imm2_imm5, rv_fmt_rd_rs1_immh_imml_addr },
-    { "th.lbib", rv_codec_r2_imm2_imm5, rv_fmt_rd_rs1_immh_imml },
+    { "th.lbib", rv_codec_r2_imm2_imm5, rv_fmt_rd_rs1_immh_imml_addr },
     { "th.lbuia", rv_codec_r2_imm2_imm5, rv_fmt_rd_rs1_immh_imml_addr },
     { "th.lbuib", rv_codec_r2_imm2_imm5, rv_fmt_rd_rs1_immh_imml_addr },
     { "th.lhia", rv_codec_r2_imm2_imm5, rv_fmt_rd_rs1_immh_imml_addr },
-- 
2.54.0


