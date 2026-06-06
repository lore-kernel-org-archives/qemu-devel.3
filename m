Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE16CCD8C8E
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2026 15:32:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVszr-0002Sb-9w; Sat, 06 Jun 2026 11:31:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imaginos32@gmail.com>)
 id 1wVsQy-0006i3-68
 for qemu-devel@nongnu.org; Sat, 06 Jun 2026 10:55:36 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imaginos32@gmail.com>)
 id 1wVsQw-0006GE-IQ
 for qemu-devel@nongnu.org; Sat, 06 Jun 2026 10:55:35 -0400
Received: by mail-wr1-x441.google.com with SMTP id
 ffacd0b85a97d-45ef372c58aso1636421f8f.0
 for <qemu-devel@nongnu.org>; Sat, 06 Jun 2026 07:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780757732; x=1781362532; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=t+vh47h2j5TUhdoXhtY9T38Sxkplcpxvt5wmDbF7qkM=;
 b=RgJ2+y4sjZ/MCOOcHNNuYkfYrf8qV5d9wCzDO4A4KQ3pZAWAOeyAWmBSoHjr8CPZeh
 YOz27rPp4w+Ls1YHALvULZNbSzu7h0rGw25N6kyEBrkiTFB3IILi4hI/yUklEy9uvOwG
 UrESyyH9PHOa0E8FxY4Ya4lnFZkcc+Y1aUfJXB3S6OPpFATGv889HDNYvc6bCGshYNWS
 CUlkCCRVWxMTy+b/gNwAnL53oYvYwxE4LyLreQZnDk9OG4KO69OtzdMvqhy59dUObLWa
 JPhnxn8RbGHGl3NEClHM8NfZayc2wq6GaAwYw+7JilvDEl2KwaiYaq+EIazbblabiKHv
 5nTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780757732; x=1781362532;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t+vh47h2j5TUhdoXhtY9T38Sxkplcpxvt5wmDbF7qkM=;
 b=kOLA7xoV0ogTLK36S/jbJMV7zXcRCKwZmfZDLFX5iqHqfiKoi8GO5LFUjd3YZgVwbQ
 EUKAxBvy7F25xsarH5C1R28zhS2mVf4KnaOffeF0GEKHe2aZ0q9UEThf4LQ+rxF49TN/
 ZMY9JtB0ZJ+LB+Zdn4QX1Jw69dSPd5J6dGFYpNIXbf2LRoyDQILkZOcn/GIUD7e9GX7N
 L4lwaCUZmYoMmdRWbGOXE0IYmIivOAbO0W0NIfZWE+mgw8Pns+PfB1eajj9ugN9q2OPR
 LrHWm4GghDFV+VQZvVk1XvV2acyMAyt/V9KcwtQZeD6VxRBgdfLraY86C6a5ybMbsTnk
 n8Fw==
X-Gm-Message-State: AOJu0Yx6z+hjC/SfKs0PAThackbC1LEEYG7lkUevesdez2ItHbddSCgc
 UGghTG4kLiaZi2VJyjjijwt2NcCox2IMlojaBLoHaMQ8oly8nmP3axCHZPgMR2R69QQD9w==
X-Gm-Gg: Acq92OHkDZnmn37jtkerY/c8Ziw9dn6L0cqrBaGnA6WuBBH74K4aDDHR5mVP4DVNrRI
 hhTVrmIPoayL02tCt6zDA+RiaHRZNEj4KOWmpwnWnV5uT0seE6OaOsK/YDES1G3vF1QepEy3OsI
 cF/6u95Uc0PWjf2uxBh9U6NyGUqkywTwGDdYmb+oSKPX0l+inBxF9H1nxgjcAnwyFDRJUPEdzce
 SW432aTZtgVZ+EYfResX5FCvvg1o9Shgs7HIQIHmA8EBlgEaUYS7sUswh7YNu27BtXT+3kN+wpQ
 vVS0iWAZrtNyzvIwh4s/XjlhCjx/tIvvXLfXRIovjWvpg8bOpYDi1Ki1D9QNm7QwTbt47VIeh5J
 LOx+3zoLZ+io1Ubu6tt1jrdD1zzW5EYKCAPkI9O2pXFFfeL1gSIBXHO8LZJkqNn4dtVPAg5tP3h
 F/60TTFpVDFItII1ttxrjXXYQQXL5zmLcmLlmv/10Tg2yTAYsdPehD6BkP0Nnc6lkoagO4y2XQ2
 oUfTg==
X-Received: by 2002:a05:6000:1288:b0:45e:ed7e:f8f8 with SMTP id
 ffacd0b85a97d-460304f07b8mr9544113f8f.8.1780757731835; 
 Sat, 06 Jun 2026 07:55:31 -0700 (PDT)
Received: from user-Legion-Pro-5-16ARX8..
 (cable-94-189-161-174.dynamic.sbb.rs. [94.189.161.174])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f344148sm34437871f8f.19.2026.06.06.07.55.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Jun 2026 07:55:31 -0700 (PDT)
From: imaginos <imaginos32@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 imaginos <imaginos32@gmail.com>
Subject: [PATCH] disas/riscv: enable `mnret` disassembly
Date: Sat,  6 Jun 2026 16:55:20 +0200
Message-ID: <20260606145520.34152-1-imaginos32@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=imaginos32@gmail.com; helo=mail-wr1-x441.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 06 Jun 2026 11:31:38 -0400
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

The translator has supported mnret since commit 3157a553ec6b9a
("target/riscv: Add Smrnmi mnret instruction"), but the
disassembler still renders it as illegal. Add it unguarded,
since the encoding does not overlap any other extension.

Signed-off-by: imaginos <imaginos32@gmail.com>
---
 disas/riscv.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/disas/riscv.c b/disas/riscv.c
index d416a4d6b3..065985992b 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -985,6 +985,7 @@ typedef enum {
     rv_op_ssamoswap_d = 953,
     rv_op_c_sspush = 954,
     rv_op_c_sspopchk = 955,
+    rv_op_mnret = 956,
 } rv_op;
 
 /* register names */
@@ -2255,6 +2256,7 @@ const rv_opcode_data rvi_opcode_data[] = {
       rv_op_sspush, 0 },
     { "c.sspopchk", rv_codec_cmop_ss, rv_fmt_rs1, NULL, rv_op_sspopchk,
       rv_op_sspopchk, 0 },
+    { "mnret", rv_codec_none, rv_fmt_none, NULL, 0, 0, 0 },
 };
 
 /* CSR names */
@@ -4050,6 +4052,11 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
                     case 64: op = rv_op_mret; break;
                     }
                     break;
+                case 1792:
+                    switch ((inst >> 15) & 0b1111111111) {
+                    case 64: op = rv_op_mnret; break;
+                    }
+                    break;
                 case 1952:
                     switch ((inst >> 15) & 0b1111111111) {
                     case 576: op = rv_op_dret; break;
-- 
2.43.0


