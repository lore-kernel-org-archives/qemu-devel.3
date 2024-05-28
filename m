Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9DC9C25B7E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 02:48:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBmpO-0003bw-3i; Mon, 27 May 2024 22:44:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sBmpM-0003TM-Pd
 for qemu-devel@nongnu.org; Mon, 27 May 2024 22:44:40 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sBmpK-0003lx-Vs
 for qemu-devel@nongnu.org; Mon, 27 May 2024 22:44:40 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1f47eb2354bso2403765ad.3
 for <qemu-devel@nongnu.org>; Mon, 27 May 2024 19:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716864277; x=1717469077; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SPVDknq2+BTuhMMVK1D5LD3yvwRgzrMP0W6CSFXWWAk=;
 b=Tbf8r7i4f+sVLcwPLUnSopZeO+dOVcJQ9fRUh6fYbaDn+QWls9KDEEXOZkCUEaM9HC
 6KtDKcgzgEQsOsgweKbFtKV20ACaWGtAtuQkNRoBnXWaGihQ6wCPLV83b+/sJN3rvHPr
 KDMz8dFqijWaPnNp7AqjzFof5yLajld8mSb2lL/JZPhgY65pi4nwx3HgGcl5w+xYph0I
 95/zQudPVAjKinl7fuufCU11eENdcTSqKpMc02/+IsY2pmwiKgGygifAYbiTKOoY2lYB
 LcipLU8uqdwoKodnTKmjtI8ONQi8imURW1bEFNXCbpl+UADGpsKwE5S0wse4OjbAWXSP
 SORQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716864277; x=1717469077;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SPVDknq2+BTuhMMVK1D5LD3yvwRgzrMP0W6CSFXWWAk=;
 b=Ggu/uNoC0+BqX9RZkbBu4h+/0O/VtmPMSuviJy7wDEtQvYZ5VUR17koK1Ah8uc+VJc
 tAaxjpsITjEX5cXya1Bh6n5nlLe24DSt27uOxlOlEMUbQ61c67DdhQe/ARzK7POgm+or
 AFQvHzVOv7COo6uEAjs8vS0PSlncTizNvV9EkmK7vySG3njJvXRcPYxaWD+55TigbtXP
 nCc7ZXdnD+AT4/mdX1cIvQlMdaWx+tFC0zLY2zwW1T8LZtOtAjAKkj0Qu2ZBNuj5PgT2
 TMkM9mvokvdoJ8o+aQRM9aLlEdhVOQDCuvpOhXdm3F6x0xZJES4PnEfE5AUdwPP3toVL
 uIjg==
X-Gm-Message-State: AOJu0YxEDpw7eg006WG5JWuVut3lUl2YNL3tkMV6LZ7iEXD2JZi8bXX1
 EBruhobtU4e5zWBHuEpx7t08F7NC4QW1GMDTyWEMjc6oNWTiwSU0+wV7qg==
X-Google-Smtp-Source: AGHT+IEVb9ZA4kdfJlDalUEeFlTsLUoxfUsQlrQ14j4uSfE9cxbv6bm5QEF+1OmBr73ARiyis1eciQ==
X-Received: by 2002:a17:903:32ce:b0:1f3:488a:bc54 with SMTP id
 d9443c01a7336-1f448d3510bmr134560295ad.36.1716864277071; 
 Mon, 27 May 2024 19:44:37 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f44c970ca0sm70733225ad.142.2024.05.27.19.44.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 May 2024 19:44:36 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Jason Chien <jason.chien@sifive.com>,
 Frank Chang <frank.chang@sifive.com>, Max Chou <max.chou@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 12/28] target/riscv: Relax vector register check in RISCV
 gdbstub
Date: Tue, 28 May 2024 12:43:12 +1000
Message-ID: <20240528024328.246965-13-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240528024328.246965-1-alistair.francis@wdc.com>
References: <20240528024328.246965-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62f.google.com
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

From: Jason Chien <jason.chien@sifive.com>

In current implementation, the gdbstub allows reading vector registers
only if V extension is supported. However, all vector extensions and
vector crypto extensions have the vector registers and they all depend
on Zve32x. The gdbstub should check for Zve32x instead.

Signed-off-by: Jason Chien <jason.chien@sifive.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Max Chou <max.chou@sifive.com>
Message-ID: <20240328022343.6871-4-jason.chien@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/gdbstub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
index be7a02cd90..d0cc5762c2 100644
--- a/target/riscv/gdbstub.c
+++ b/target/riscv/gdbstub.c
@@ -338,7 +338,7 @@ void riscv_cpu_register_gdb_regs_for_features(CPUState *cs)
                                  gdb_find_static_feature("riscv-32bit-fpu.xml"),
                                  0);
     }
-    if (env->misa_ext & RVV) {
+    if (cpu->cfg.ext_zve32x) {
         gdb_register_coprocessor(cs, riscv_gdb_get_vector,
                                  riscv_gdb_set_vector,
                                  ricsv_gen_dynamic_vector_feature(cs, cs->gdb_num_regs),
-- 
2.45.1


