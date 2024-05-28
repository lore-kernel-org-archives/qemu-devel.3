Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B18FAC25B74
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 02:47:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBmr7-0008Ni-3O; Mon, 27 May 2024 22:46:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sBmqE-000610-Po; Mon, 27 May 2024 22:45:36 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sBmqB-00043X-8J; Mon, 27 May 2024 22:45:34 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-681bee6bb13so2319631a12.1; 
 Mon, 27 May 2024 19:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716864329; x=1717469129; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J5jhBOyEYmtoTJBDh000o1EH0VVoye2sH2+Q4KCgR/U=;
 b=RAbWoRJHCj95iZgADV193LMOE+7Y8BCIxZaPaW9EXmB9kAPYjNNYVwdv0p4T76zeGz
 XOvYaEfxnl0NO9syjqGIENOI7NC5TXhZfgartWrMr3u/bo/zHYLX3kY/1eyoE35PLFsR
 xtBWjEo70IKR7JYb7h7UQym1w/W2SvBIpLBYwblrZE+A90VcMUzsGQg5vFMawNpRl0SZ
 2z3HtDZSFkyRkNYWw8uSwVT0ux9LoCGe/Gdlax2sKQ7AJpovWFYbOxujr3rgNbNmcS2o
 bCUyPCpc6lDOCb11A66MSZB4Zl6rPRUMpps61O2xWUu5G5tgdchdoVL0wGjnwSfrg7hC
 +A/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716864329; x=1717469129;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J5jhBOyEYmtoTJBDh000o1EH0VVoye2sH2+Q4KCgR/U=;
 b=w8jnEw46/hfwAiNmIxuyV7xuFGLU7ZwSYLjgBC9jxSjYfrDpyIz+uzMhb03hZuxuEt
 +aTdkWzKs3NyNwcPWTU7rzBQNjz4r+XA5qO6O3RPF2c/F0Fl0cNWx2WQ7gzLvoeITd/k
 I+nQYF9PRIbUbRPb0KoMMuCOsv9I8nwPkJaLgyTB1fPnQbZ5LPSuXLzilIYvVqv4gF6K
 Co+lbRGVYt0D5XUuGdhuEgkOsEWPrHa643nyXxoYkUvHrXltLB1X9zVs5o/HK6UPSjls
 3Loozt2bp7dhBqVD5FeSqoIZ/TbujfLLsyD1RYj6CncMwRYgmw327JZ5RlHXhxChyXKU
 HrqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1MZVGqonqod5Z5gTv0xck7aNhLYHnyZK4EZvEvG79rR+ObZUa1/puTMx85B9cGiXzrFp/0sQP18rnSU3Fc5NHlwqBV6mn
X-Gm-Message-State: AOJu0YzecSbqJnJ2YzNpzoGk8HsV3PLeMi95ASLrFCy1WdfTJXrUrTzR
 v/uKhYlRkwyJuGmIRIQDcrDT+o3Amt8r9pM7bTExTaQrMq+zhznglsElOg==
X-Google-Smtp-Source: AGHT+IGMtkHie2+p7yc4Q1tiVjUxxUGzzd2HPR9bp5uQkxDSTAgDpOHkmT8N5DvuF21AuC1VvdYtnA==
X-Received: by 2002:a17:90a:888:b0:2bd:efc4:a9b with SMTP id
 98e67ed59e1d1-2bdefc40ad6mr17075822a91.8.1716864329102; 
 Mon, 27 May 2024 19:45:29 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f44c970ca0sm70733225ad.142.2024.05.27.19.45.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 May 2024 19:45:28 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Eric DeVolder <eric_devolder@yahoo.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 qemu-stable <qemu-stable@nongnu.org>
Subject: [PULL 27/28] disas/riscv: Decode all of the pmpcfg and pmpaddr CSRs
Date: Tue, 28 May 2024 12:43:27 +1000
Message-ID: <20240528024328.246965-28-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240528024328.246965-1-alistair.francis@wdc.com>
References: <20240528024328.246965-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x52b.google.com
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

From: Alistair Francis <alistair23@gmail.com>

Previously we only listed a single pmpcfg CSR and the first 16 pmpaddr
CSRs. This patch fixes this to list all 16 pmpcfg and all 64 pmpaddr
CSRs are part of the disassembly.

Reported-by: Eric DeVolder <eric_devolder@yahoo.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Fixes: ea10325917 ("RISC-V Disassembler")
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-stable <qemu-stable@nongnu.org>
Message-ID: <20240514051615.330979-1-alistair.francis@wdc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 disas/riscv.c | 65 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 64 insertions(+), 1 deletion(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index e236c8b5b7..297cfa2f63 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -2190,7 +2190,22 @@ static const char *csr_name(int csrno)
     case 0x0383: return "mibound";
     case 0x0384: return "mdbase";
     case 0x0385: return "mdbound";
-    case 0x03a0: return "pmpcfg3";
+    case 0x03a0: return "pmpcfg0";
+    case 0x03a1: return "pmpcfg1";
+    case 0x03a2: return "pmpcfg2";
+    case 0x03a3: return "pmpcfg3";
+    case 0x03a4: return "pmpcfg4";
+    case 0x03a5: return "pmpcfg5";
+    case 0x03a6: return "pmpcfg6";
+    case 0x03a7: return "pmpcfg7";
+    case 0x03a8: return "pmpcfg8";
+    case 0x03a9: return "pmpcfg9";
+    case 0x03aa: return "pmpcfg10";
+    case 0x03ab: return "pmpcfg11";
+    case 0x03ac: return "pmpcfg12";
+    case 0x03ad: return "pmpcfg13";
+    case 0x03ae: return "pmpcfg14";
+    case 0x03af: return "pmpcfg15";
     case 0x03b0: return "pmpaddr0";
     case 0x03b1: return "pmpaddr1";
     case 0x03b2: return "pmpaddr2";
@@ -2207,6 +2222,54 @@ static const char *csr_name(int csrno)
     case 0x03bd: return "pmpaddr13";
     case 0x03be: return "pmpaddr14";
     case 0x03bf: return "pmpaddr15";
+    case 0x03c0: return "pmpaddr16";
+    case 0x03c1: return "pmpaddr17";
+    case 0x03c2: return "pmpaddr18";
+    case 0x03c3: return "pmpaddr19";
+    case 0x03c4: return "pmpaddr20";
+    case 0x03c5: return "pmpaddr21";
+    case 0x03c6: return "pmpaddr22";
+    case 0x03c7: return "pmpaddr23";
+    case 0x03c8: return "pmpaddr24";
+    case 0x03c9: return "pmpaddr25";
+    case 0x03ca: return "pmpaddr26";
+    case 0x03cb: return "pmpaddr27";
+    case 0x03cc: return "pmpaddr28";
+    case 0x03cd: return "pmpaddr29";
+    case 0x03ce: return "pmpaddr30";
+    case 0x03cf: return "pmpaddr31";
+    case 0x03d0: return "pmpaddr32";
+    case 0x03d1: return "pmpaddr33";
+    case 0x03d2: return "pmpaddr34";
+    case 0x03d3: return "pmpaddr35";
+    case 0x03d4: return "pmpaddr36";
+    case 0x03d5: return "pmpaddr37";
+    case 0x03d6: return "pmpaddr38";
+    case 0x03d7: return "pmpaddr39";
+    case 0x03d8: return "pmpaddr40";
+    case 0x03d9: return "pmpaddr41";
+    case 0x03da: return "pmpaddr42";
+    case 0x03db: return "pmpaddr43";
+    case 0x03dc: return "pmpaddr44";
+    case 0x03dd: return "pmpaddr45";
+    case 0x03de: return "pmpaddr46";
+    case 0x03df: return "pmpaddr47";
+    case 0x03e0: return "pmpaddr48";
+    case 0x03e1: return "pmpaddr49";
+    case 0x03e2: return "pmpaddr50";
+    case 0x03e3: return "pmpaddr51";
+    case 0x03e4: return "pmpaddr52";
+    case 0x03e5: return "pmpaddr53";
+    case 0x03e6: return "pmpaddr54";
+    case 0x03e7: return "pmpaddr55";
+    case 0x03e8: return "pmpaddr56";
+    case 0x03e9: return "pmpaddr57";
+    case 0x03ea: return "pmpaddr58";
+    case 0x03eb: return "pmpaddr59";
+    case 0x03ec: return "pmpaddr60";
+    case 0x03ed: return "pmpaddr61";
+    case 0x03ee: return "pmpaddr62";
+    case 0x03ef: return "pmpaddr63";
     case 0x0780: return "mtohost";
     case 0x0781: return "mfromhost";
     case 0x0782: return "mreset";
-- 
2.45.1


