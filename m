Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CC25C5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 03:58:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwtlc-0006v6-8g; Wed, 19 Aug 2026 23:48:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtlb-0006uV-Dq
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:48:35 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtla-0004QA-0b
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:48:35 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-38e42560ebcso1543068a91.1
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 20:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787197713; x=1787802513; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ulC44i9a3xhjyvxxC0pEa6jbGi+BnZcRf4JICqyq4rw=;
 b=gosLRZ0L3rH9wuHfgGciHIZO0Of0eEDm9ZqrQEgeVttsXiTdwRQReqSq/HbSlafn4k
 7m2yA69Wfp9EhiQqCdoRhypCXdLzywr9TTXGwD8lxVxOSaJWP5NyGkIjkUagHHECBvzi
 hRFJQu3+mQ1lSEkbiLFIV8mz13jos50fgqv1x6vJyiKXDzPwUAvAZ9Gi0dOuHPewx0uT
 zTGdR0g22ksbqDPb7IMh2nLR9Oir03Rduw8UwNOp7ogT80Pkcb8GIVDiZbBKHcr5RPsw
 q6/cFT2nkd37o6Jz7rDzaggEdzlLvVApJ3MIuDFCvT99z8a2uA4Zk4pWflmhgH65KAiO
 U8FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787197713; x=1787802513;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ulC44i9a3xhjyvxxC0pEa6jbGi+BnZcRf4JICqyq4rw=;
 b=e2AFXA5rD4nv4VeYCpHRDrR+bSeLRj8/I4VTuuVdcZ5/CqyFdyHDe6ntzZVe4helXD
 tm99mVKuPZ9bSWGpQOPT5rdrt+m9RMZcRBEarpn8wvNGgchlM7U5vtUdXI9DSmu+ll7U
 a0cNL3OTzd1TbhsLE3jbM1oBSGlpAdosuFP1aoMyW9cJjv/TUVHcbtVH41yLpKtP++KX
 aMwGNr16Yeu9ekv47n6qLGWROQb9CWTsRzzJSEEIC37Umg2Kx+fo5raN25QOUQNFfgry
 MnOx1peOe0JT21Zcbi8ki8vBXanRyNk+PkfTQuXFLz/Q6Yh7KAil+FzhoYqhyBKdKsIP
 YyTQ==
X-Gm-Message-State: AFuF++lAxMfkANqgrk5ZU/1CkcPVs1yTeOABLMsAFAfXUVCmg7+FGRAq
 EwLLmVgOmbawIqMxhys1d7FlMBZk7n3oMr/SY9cEEnSjVGEiPx1k+jieLB+9ZQ==
X-Gm-Gg: AR+sD10vve9BpAd4rEm7j0/NNKHpHtH1L6luBeuXfiFQaI4NiHROZ2EFKSWYYYtURog
 pO2e9K4H9jw4eNUdifTwPP0segMfd/TuF7an0U4Jt5hSHVz2AvCVuTTqDrZ02YQR+aOmJKUkVtM
 imc8TyGRK7kbuHl7wtrbSHOYLMiQnr4uc7jFwKv9zbNArBeqdtvxzF6S5BlBYXYUKz8xeoI/IK0
 fbWPtsACCkmfFNYNNpYS1edGaes7trEHZeVYR3QOZFmvJCcnaM0USylePNy0h91+mA0C5W6w1Cd
 izPXsxFLcZhCAJeyDoiBa9MGA9eLG9kaG9ido9qLd7mxSLrguxkuit4LjffQ40wQxCSuIRPbF59
 itLzf4aQXQqcGd63HR34FkBp3E2WSExPhZxVE3wcAq58sATqq8vhIrV5X9zBfAJ1lcSvPD9e+UT
 NNxJnkAoXHRKMEh6J5e3ge6q19Ic2mWwJfp1AqZNDd04xcZtcDRB+65NZRvkqiOE7BjLJlJKPY3
 /ixyQ==
X-Received: by 2002:a17:90b:6c6:b0:37f:b0a9:1a68 with SMTP id
 98e67ed59e1d1-395812a8bd9mr18532756a91.7.1787197712716; 
 Wed, 19 Aug 2026 20:48:32 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1416ad6060asm19506735c88.6.2026.08.19.20.48.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 20:48:32 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 80/93] disas/riscv: Move rv_op_illegal to riscv.c
Date: Thu, 20 Aug 2026 13:44:17 +1000
Message-ID: <20260820034430.1186695-81-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260820034430.1186695-1-alistair.francis@wdc.com>
References: <20260820034430.1186695-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1034.google.com
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


