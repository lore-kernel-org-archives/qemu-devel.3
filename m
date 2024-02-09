Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64554C48297
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 11:11:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYOc5-0005IM-OM; Fri, 09 Feb 2024 06:00:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rYOc1-00059g-Ts
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 06:00:06 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rYObz-0000MG-47
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 06:00:05 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6e09143c7bdso209019b3a.3
 for <qemu-devel@nongnu.org>; Fri, 09 Feb 2024 03:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707476401; x=1708081201; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZlIbY8Nt2DP+zA2T4N56vmjzUwKLbqN1hLnBgrv2Icw=;
 b=OeR6x/ejC8eSVCTm84b+RgPA3lrW7LJzXHeQLhKa51cYJtSwC/6V26oYbfh49vHkWq
 QT5qj/R1EeOB3B0kq0i4JDgXi7E3rQ75RERAT0hYMmuxpaCW4DiGDbFvk8FiD3kptWnc
 chiXF2yYLvXBaJcB5uzdODTfltC0hYMJycJ0W+Qxd7J2TYSu7+gWDsX1XXVzn047imVr
 Vyzhix1saYQpgHCJsw/AOrCbw9QZb8DK+SOg06V8OI/3fRgq+FDJW24wIM0+gMvRZYIL
 EK/Gow/2EGFEy98plszdU/KehL07o6VhX5lVi6gGYtFGx7HNTafxXYjMHrepkO1eJ7Rk
 SZQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707476401; x=1708081201;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZlIbY8Nt2DP+zA2T4N56vmjzUwKLbqN1hLnBgrv2Icw=;
 b=CNnIFepnkyG1l+Z4ybsNPO5HRfSB0SAg3Dd+9Qvts/+lC8mfYaKjzXyuba0+sDBJiC
 tAd2+fBFikNvJF2F8XFRpW49+lNU58ap3bo8sImDGGhrXqVB3vg8UIzek85KTY1DNn84
 symEvy6yZlsHrWE/i2v+wUo3+1iZiLqjgPLPTquit9Sjnz25Rxl+EhsBoXWsBwY9qtIf
 QIneOV0FpRFnnEuXLm8rN1ixhhmopf1C9RdzwwLCz+0wm52siqQMh7EAnGSzlce5mOOP
 W0193Dk0F/0adsFhQd4pRjIOqZZESfDyzgs8tDFpatbw4nUo2CxBBUXEeYTDMXMRdXnd
 2Yzw==
X-Gm-Message-State: AOJu0YzkF1Y1Wppvlhr2K7RidUZmy82GykeDyxQMZzJYgd+nikxtzsiV
 qbcaC7yGP0bHSD3gVsw3P16D1xS1tn0cXZHLnNS76k4acj2EfJK9g8o56sEK9vMSsA==
X-Google-Smtp-Source: AGHT+IH79JpoaybChNdTi/AagADMcstiR+++UWLzOUhPKiMV0auvq/ECdGLPF6+X67OG0DnAQR0rjA==
X-Received: by 2002:a05:6a00:98f:b0:6e0:3cfd:501e with SMTP id
 u15-20020a056a00098f00b006e03cfd501emr1714147pfg.3.1707476401105; 
 Fri, 09 Feb 2024 03:00:01 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUmToKIgoJDMWp/+I06K/a2/xcx1Dvvv1S8m78iDSPFv1pqemu2aSWlQDWEiG71QpcHybBC0asMxLM5dkZu5pqObT5pgE0HnRQEidKP42TzASlWZRxF/39qOlguGcWb7BD1O9mVNCKh6eDXuTwJli5hBkedt1/HnzN9ibHN+bFGwTk=
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 d20-20020a637354000000b005d3bae243bbsm1473623pgn.4.2024.02.09.02.59.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Feb 2024 03:00:00 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 29/61] target/riscv/vector_helper.c: use vlenb in HELPER(vsetvl)
Date: Fri,  9 Feb 2024 20:57:41 +1000
Message-ID: <20240209105813.3590056-30-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240209105813.3590056-1-alistair.francis@wdc.com>
References: <20240209105813.3590056-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Use the new 'vlenb' CPU config to validate fractional LMUL. The original
comparison is done with 'vlen' and 'sew', both in bits. Adjust the shift
to use vlenb.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20240122161107.26737-9-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/vector_helper.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 908e69d073..8ee7717162 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -45,9 +45,16 @@ target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
                                             xlen - 1 - R_VTYPE_RESERVED_SHIFT);
 
     if (lmul & 4) {
-        /* Fractional LMUL - check LMUL * VLEN >= SEW */
+        /*
+         * Fractional LMUL, check:
+         *
+         * VLEN * LMUL >= SEW
+         * VLEN >> (8 - lmul) >= sew
+         * (vlenb << 3) >> (8 - lmul) >= sew
+         * vlenb >> (8 - 3 - lmul) >= sew
+         */
         if (lmul == 4 ||
-            cpu->cfg.vlen >> (8 - lmul) < sew) {
+            cpu->cfg.vlenb >> (8 - 3 - lmul) < sew) {
             vill = true;
         }
     }
-- 
2.43.0


