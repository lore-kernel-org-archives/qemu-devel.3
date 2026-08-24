Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E714C5DF94
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 05:53:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyNbr-0006pE-QA; Mon, 24 Aug 2026 01:52:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNbR-0005Ke-Ji
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:52:13 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNbQ-00035I-0I
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:52:13 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-38d489b6b71so3408768a91.0
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2026 22:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787550730; x=1788155530; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ulC44i9a3xhjyvxxC0pEa6jbGi+BnZcRf4JICqyq4rw=;
 b=iIaFAMPOEZLPgOPToy2LU4AdD+IzS730gxv5IauOaW0bK/gPxTxAEsbKLahCgEy6uo
 al7dAnYq0d+v15F3HdR3W4yeAzv+WTH/Q+XPwZAWLcvSLFNn2r0+18rp5fD+Jsll8CnU
 TJldrZm60I7RKDVK4GPWukyg0qaiDnjkedR3Q89rl+dqkUrxnXD1joB7XelxzR4vsqRD
 ZUjZzYCvQ5stxYOI/bVzZuh2fCGyqN+MSIFHWiOxZIG9KdnVJ44TkO/w/4A974daq5/D
 pcq30gUsYcITiFOGyzb2M/0sqaapt8AOMcB0v4ImLOmeJEJfhnpYDJcxVf4Pi364XD4h
 Gvkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787550730; x=1788155530;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ulC44i9a3xhjyvxxC0pEa6jbGi+BnZcRf4JICqyq4rw=;
 b=AtbvLHc8Qvch/7/UX/1wKv5J71cJngjq8Qnix5udzvB/4oXj7VE6lojIwia6yM8R3A
 VBiTVVAlBarrAf09v1agZiIp9+c9xGHd0VEkZFFTLnYBKlXMKs27Qvn/fXYBF5M+yNdF
 r2LVXpzjn1DxzwKWWkO2pd+s1uvCnLQcBs/tKxO1zCGRyxnKqOXV5evLGD7AVdBgb9TG
 IIjIJvkfLdGF62z6BhhQi438vOix0+tIPYtokbyueGksxJyExo+bWhlf9bJvsYnEav4F
 FrgIyX2kU4NRzCZx/mfVeGjy4nqCqttnKyYN2hpkW5VeqOWylj0LA1WBBheG6NQdFbsh
 xmDg==
X-Gm-Message-State: AFuF++lXc/U+dVxVLxgca2WSriIdOGrZikMqRWu1Q4obedDSPcXUV52s
 a4AuxHZZx/S/5naEIWRzmbnQlswj2Pj/F3byxKqbSXfu4StWkDhlA/4AcmZGiA==
X-Gm-Gg: AR+sD10F+I9PIgqwBPJE7ho8JOzx3VPswJ/clnE01i0wkopMoKamBIi+2REa7fgPPE3
 Kqo10F6TRF0I48ahS8TUf8g7HYJFrDcYtAKsw0wVi+jW3vDRQ+4skkQUxApTx6d5iqwPBFW+WvJ
 UIu2gQvzGy33xuAY06DTrWNQ2KAGwt5T2zw/2PyAcl9jpCPDt8B3tqCkbPvAyRhSCJrkwyeprnH
 WOcyexPpHRE0zja1I/F9eGgjGQV1MXEcqS4x/XNZMo0/R5dbywztOAhRL4TvEcrIkEFTqG9p/mO
 alXRw9wWF6cEl14QLXDYW2alCQ4pyBX31VPbwupv3t7ePtb0cqYqrlXIDfH7LxrVYk1IH7/3dcW
 6H1SmoU6tBtZOIXDOGtA4E1X+HvZlAusZl8OAvOmXbA2TXBaUOMzrnzVNRxJ5dxy4K7cr4wcJ15
 kcVz5Xw4MPYf9fugneR7LRPkOFygOdk3G+qLdxDJMc31yho6laFk7qLekq/joYDYgmExx8VpZk2
 z7CVg==
X-Received: by 2002:a17:90b:4c8e:b0:38d:fda6:4873 with SMTP id
 98e67ed59e1d1-395c352aee9mr40874783a91.10.1787550730488; 
 Sun, 23 Aug 2026 22:52:10 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395c917d2f2sm4046005a91.3.2026.08.23.22.52.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2026 22:52:09 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 77/96] disas/riscv: Move rv_op_illegal to riscv.c
Date: Mon, 24 Aug 2026 15:47:47 +1000
Message-ID: <20260824054806.2790041-78-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260824054806.2790041-1-alistair.francis@wdc.com>
References: <20260824054806.2790041-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1036.google.com
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

illegal is no longer used in other files.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260812223142.349142-45-richard.henderson@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 disas/riscv.h | 4 ----
 disas/riscv.c | 2 +-
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/disas/riscv.h b/disas/riscv.h
index 241dd47d7f..5ac8c41616 100644
--- a/disas/riscv.h
+++ b/disas/riscv.h
@@ -200,10 +200,6 @@ typedef struct {
     uint8_t   rlist;
 } rv_decode;
 
-enum {
-    rv_op_illegal = 0
-};
-
 /* instruction formats */
 
 #define rv_fmt_none                   "O\t"
diff --git a/disas/riscv.c b/disas/riscv.c
index 787340e811..c3a8cde37d 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -29,7 +29,7 @@
 #include "disas/riscv-xlrbr.h"
 
 typedef enum {
-    /* 0 is reserved for rv_op_illegal. */
+    rv_op_illegal = 0,
     rv_op_lui = 1,
     rv_op_auipc = 2,
     rv_op_jal = 3,
-- 
2.54.0


