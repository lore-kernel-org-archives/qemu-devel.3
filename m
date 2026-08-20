Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1112CC5DF87
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 03:50:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwtlI-0006af-F3; Wed, 19 Aug 2026 23:48:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtlH-0006YP-51
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:48:15 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtlF-0004NV-Oq
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:48:14 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-38e58034d05so1490141a91.2
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 20:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787197692; x=1787802492; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Yu4ELq3Ofd3UkpQaCSSE8x2tH1NrMj+tlGRK673tC1k=;
 b=LK66okav7RUnYD/13gLrJOYcPDz5itPwIlvFKzkchCqVLo0FtWy2dtHitQbjx0Z16C
 AgrsCGceFoGmyibh/rC3dwl8hGOnbsWlC7rp+od3PpO8wZ0cSOgUxBQIwalSoBswc/UX
 sfaY/ms8vfpWfKrtvevvxHX/nQc35XaTTVw/6z/ayz8GtraQ72FfGrElQRcLBkwIgJl5
 37I2G8lFqwdfkNXBL6WIfqr//tZyTqhFLojmS1ZaXljwCJh5nEzcEZzG/yVUp43HukAh
 MInnPgUMCCJI0L/kTap8829Xprqq6h3bgT5QZme4SxPGwtnX+yyr7hP1bgUnSGHe69mq
 6E3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787197692; x=1787802492;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Yu4ELq3Ofd3UkpQaCSSE8x2tH1NrMj+tlGRK673tC1k=;
 b=B4/0KFJVe+qbF8ZJ1hEenAUtH0e5EGITjoyIeKGNU8o+WAGzr1ReGG24e2YXrfSzKC
 fe8eyJ7tmP7hNUXIj1xWLmFUZjKvkvmyGUnVr2E49Ox4fQYr9SCNDQvwDdg0zQVbifLQ
 +Z/XFlcSqeJHiC9JpbUnONRxvCBfrLETsWNaXteso0tTbv3gwclcpBqbG4dRjCasTODm
 Z5rbswYRJ9O71MX/kd5xzTvayK2MZqLizQI2trbi1dd34M8qVLCE+GmMrKgkXx8iYbtS
 sdp/ElDCwZ7dX8m1Wj1QHF+DUtl7y4F29FaD4msDgF4xrKcRq8HAuV7osCHr01cftlGU
 aKUw==
X-Gm-Message-State: AFuF++lenddVi1cfXAS1V2kQYHsmPAgEa7GBzRjHa8U5rVsWgvrLBY8x
 U+DW6wKvFdSxStSLUc7wppl3veVNtWsnBkUv+7w9eHX6a0iCnaMDUZzXWbOViw==
X-Gm-Gg: AR+sD13lD5fRmVPa/OPWTvT8fR6lct/ozSStTT02w14ZurQ8u/9ltkrqki+mG392mCf
 fDsXVxO9V0CfVWVxhHqWgo8uy6tarhGWqguCuWkyht0YIp25FvqyPKJJG8rYx2ET01Oz43b7aND
 Zg0lMogb/qkNF4tLNkTGIdU5t1n9Epvsb06mZ1Gu6o0a616bCiyc232/fAISTsOMWw9md9oJPIn
 qOUPtN1WdP5VMS5epNo3Iv+fHq50oKgKaJp4Tk19O/qkm1k939NeZAUzeaDKCgEv8ffti6tOu7V
 R4g5AO48GrJBDAn0BTPk6tnf9Rue1XYayOMxYSu5mt3lSdehiAAVwCJx3bQ/ZEGk3iiWY6cVuJi
 AK17h1ohE82kAbl5mVmvbaRHHy3Nb756abQpnpqjhMKl5vdgzZgk8b5USfUPzOVo/BeZ4KDtHzI
 PSXQBI1wdhU01OxVypCa8gHI2AKrFC5psGvCy8pBCSwh+PiPsp6cZ38e/uMh/LYXYh/YMrOCcq0
 uvWBA==
X-Received: by 2002:a17:90b:5624:b0:38e:e9b:ffa4 with SMTP id
 98e67ed59e1d1-39580a7c3dbmr18960897a91.6.1787197692470; 
 Wed, 19 Aug 2026 20:48:12 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1416ad6060asm19506735c88.6.2026.08.19.20.48.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 20:48:11 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 73/93] disas/riscv: Reject all of OP-32 and OP-IMM-32 for RV32
Date: Thu, 20 Aug 2026 13:44:10 +1000
Message-ID: <20260820034430.1186695-74-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260820034430.1186695-1-alistair.francis@wdc.com>
References: <20260820034430.1186695-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x102f.google.com
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

These entire base opcodes are RV64.  Reject them all at once
rather than one at a time.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260812223142.349142-38-richard.henderson@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 disas/riscv.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/disas/riscv.c b/disas/riscv.c
index 75c2fa11e6..e650ad7688 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -3311,6 +3311,10 @@ static const rv_opcode_data *decode_inst_opcode(rv_decode *dec, rv_isa isa)
             }
             break;
         case 6:
+            /* OP-IMM-32 */
+            if (isa == rv32) {
+                break;
+            }
             switch ((inst >> 12) & 0b111) {
             case 0: op = rv_op_addiw; break;
             case 1:
@@ -3557,6 +3561,10 @@ static const rv_opcode_data *decode_inst_opcode(rv_decode *dec, rv_isa isa)
             break;
         case 13: op = rv_op_lui; break;
         case 14:
+            /* OP-32 */
+            if (isa == rv32) {
+                break;
+            }
             switch (((inst >> 22) & 0b1111111000) |
                     ((inst >> 12) & 0b0000000111)) {
             case 0: op = rv_op_addw; break;
-- 
2.54.0


