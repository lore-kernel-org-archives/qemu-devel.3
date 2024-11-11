Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 124A4D3ABF4
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2024 22:30:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAcv6-0001Jg-Fc; Mon, 11 Nov 2024 17:30:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tAcv4-0001J1-EC
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 17:30:02 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tAcv2-0006lo-Qj
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 17:30:02 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4315e9e9642so41327745e9.0
 for <qemu-devel@nongnu.org>; Mon, 11 Nov 2024 14:30:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731364199; x=1731968999; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VSttJJCIDI0nTQHLmARnxM4Mg6vxyxH9JmxDQ+jh1mM=;
 b=D2Mn7iSsp0C+ot4drl3B5b1g+76uGKh0HN1h5QUqwlKVOvvmFEfAoYYo2duxEL18hk
 YAp2ebzkCbTTVL7AN625Jxu975xgH4OnELTMCdKBmp8Z2KdShNesUAqMbzc31OAyQWuX
 qwTVhEMBsSjv11wtxRSd1KwpDGioj4qbSdO2L2aXHwTn30Us1SNK2pOoHUOkA5C58Fu1
 kV64Nzm6KbFuSGjYNMsWEi+4V3LmgdewLnZlbNmQ6O1pXMWbD+aQtYmYZvifC3sIllFc
 DjrKokMrvxVozVhQDLhRXZS5HkW6MqSJ08rVLbqgvFRI2P21/l2W6EsaIdhfOwdojuqR
 o19Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731364199; x=1731968999;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VSttJJCIDI0nTQHLmARnxM4Mg6vxyxH9JmxDQ+jh1mM=;
 b=Pm0pwzhBEsZRWs2/p+C4fwjKoLY4+E01aCaTNvmcAd2xv9Xc2QLWd66kkqRUqB3wB/
 V/GKp8HElUDoz/h1nvbPlLvVQUaTmNFrnbAFzM1AnieYFAtQ6c9mrkbTJ4i5MHWVNDug
 A/zd6KB54s2Ab71+1hRWxltAclnBexarNL9Loxj7/5hbJGafMCA07UrseNkHnMem6gbx
 j8vk4V8UGZNEPWdjfsPqkiVDdbOur6eBVMkuAUUJgxyOfp0GjMKI+Inx0ifty05mXbur
 aCwhyMkOjCY8oAP61xfS2GJUElh90wLHAMdMeXcUnglt3xaFbmcTqiNCGcqejfHhp5tJ
 l+ww==
X-Gm-Message-State: AOJu0YzlhbNgqwmddTT9EE5O6iwmkv3hfA93c42B4WyfajHAz+W6Aey8
 AA7dsS5cU9g/8ofbhEF3IRf8eVdIVYIyqeUBVP64Lic1nWLfsKrLyolNFKaaaZ1P7uRKJUQ2hp/
 Y
X-Google-Smtp-Source: AGHT+IEn2pnqAPFycJ4S+WhRfqPpwsKT3K1I7wHp56tm5sznc9wRCTJpraab9LD1mtE99eaMeayLuQ==
X-Received: by 2002:a05:600c:1d20:b0:431:6060:8b16 with SMTP id
 5b1f17b1804b1-432b751ceb4mr115355925e9.30.1731364199046; 
 Mon, 11 Nov 2024 14:29:59 -0800 (PST)
Received: from localhost.localdomain
 (vau06-h02-176-184-43-163.dsl.sta.abo.bbox.fr. [176.184.43.163])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432b04753d5sm196543195e9.0.2024.11.11.14.29.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 11 Nov 2024 14:29:58 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 3/3] target/mips: Convert Octeon LX instructions to decodetree
Date: Mon, 11 Nov 2024 23:29:36 +0100
Message-ID: <20241111222936.59869-4-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241111222936.59869-1-philmd@linaro.org>
References: <20241111222936.59869-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Use Octeon decodetree to call gen_lx() for the LX instructions.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/octeon.decode      |  8 ++++++++
 target/mips/tcg/octeon_translate.c | 12 ++++++++++++
 target/mips/tcg/translate.c        |  4 +---
 3 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index 0c787cb498..102a05860d 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -1,6 +1,7 @@
 # Octeon Architecture Module instruction set
 #
 # Copyright (C) 2022 Pavel Dovgalyuk
+# Copyright (C) 2024 Philippe Mathieu-Daudé
 #
 # SPDX-License-Identifier: LGPL-2.1-or-later
 #
@@ -39,3 +40,10 @@ CINS         011100 ..... ..... ..... ..... 11001 . @bitfield
 POP          011100 rs:5 00000 rd:5 00000 10110 dw:1
 SEQNE        011100 rs:5 rt:5 rd:5 00000 10101 ne:1
 SEQNEI       011100 rs:5 rt:5 imm:s10 10111 ne:1
+
+&lx          base index rd
+@lx          ...... base:5 index:5 rd:5 ...... ..... &lx
+LWX          011111 ..... ..... ..... 00000 001010 @lx
+LHX          011111 ..... ..... ..... 00100 001010 @lx
+LBUX         011111 ..... ..... ..... 00110 001010 @lx
+LDX          011111 ..... ..... ..... 01000 001010 @lx
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index e25c4cbaa0..0e0b00303a 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -174,3 +174,15 @@ static bool trans_SEQNEI(DisasContext *ctx, arg_SEQNEI *a)
     }
     return true;
 }
+
+static bool trans_lx(DisasContext *ctx, arg_lx *a, MemOp mop)
+{
+    gen_lx(ctx, a->rd, a->base, a->index, mop);
+
+    return true;
+}
+
+TRANS(LBUX, trans_lx, MO_UB);
+TRANS(LHX,  trans_lx, MO_SW);
+TRANS(LWX,  trans_lx, MO_SL);
+TRANS(LDX,  trans_lx, MO_UQ);
diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index acadd3d891..6fd5462a24 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -13583,9 +13583,7 @@ static void decode_opc_special3_legacy(CPUMIPSState *env, DisasContext *ctx)
         }
         break;
     case OPC_LX_DSP:
-        if (!(ctx->insn_flags & INSN_OCTEON)) {
-            check_dsp(ctx);
-        }
+        check_dsp(ctx);
         op2 = MASK_LX(ctx->opcode);
         switch (op2) {
 #if defined(TARGET_MIPS64)
-- 
2.45.2


