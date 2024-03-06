Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63402C54E41
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 17:11:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhuly-0006O6-KI; Wed, 06 Mar 2024 12:09:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1rhulq-0006NF-Fe
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 12:09:34 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1rhuln-0004F4-7r
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 12:09:33 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1dc139ed11fso8272095ad.0
 for <qemu-devel@nongnu.org>; Wed, 06 Mar 2024 09:09:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1709744969; x=1710349769; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JTvIsCuHcJLg34GV3VTBVJWhiBcUvjuqYOwBpB04ACY=;
 b=nwHrcRV+RrZA2cXFRJRuS/ANpmZ0eynbqtuoQKhJrchM5G/p/oyu7eYrVV0vS/4NOm
 fAi4tIBtFRUfit9iymccEQ7XAG9HzwN4d1za0wqxN2YKoBqmqac1mnpfikQ/aX2U8AlK
 Rdo6faAxfeRlU7bGuhL9OlcWScMjyxbEeIgUoaSkNwAKqQZvsGEqz61NoBrFioiSQT0H
 B8gxBUb9BONSBUitXOCb7Bi5LJOQEZMdiVzjG0gIx4BtUPzcXrMmlhdCGAzxct12k1Fz
 OzJi6fNTTGFfK0dMBKQVG4TLA/O0r8Pgy4avMfMcHjmVUQsS6H+GjiEbRAxkjd06SDPc
 Xi/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709744969; x=1710349769;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JTvIsCuHcJLg34GV3VTBVJWhiBcUvjuqYOwBpB04ACY=;
 b=g36MKH65gQJLvEPBeGAlIEKZrDM5i7jkLjkIz6xnenllBHedltqZds9kv0H1FvZen2
 j6BR+F7m2pADYhR6AnP/2YUyXNdVPgodmg2CHcrcTqmUaL4kxFZ19Gz4rAs0hN1V5ruH
 2GYAkkQXG2KRkCXqI8sCso0eEZVIneewgI0JgCNUionmbKvgRt0HuH8n4TP8YpnrX5oA
 iK+ThESpRAWqUC6sHyGx9gdcpsz4s1StECCbE117xb3NwTU409ZOOa9LqzFrLBDp07QJ
 VeFMmY/+A0da3c3NYojT5gvvI5o5QJNLdyNb38xHdDWL4lt4AxPLnZm/8HQek12DMM7j
 x6fg==
X-Gm-Message-State: AOJu0YxNt2QQZmxqen6jJPXCBNwNZaJ9zmwnc1PHbTXv3NdnYMiwhPsF
 cKD5/IIhN2rGva7l0st8NRgOVvQKhdGq2EiIeu2iND0VhCQbl0eFZD6MBEfgRs30UB087nhvPLZ
 RXN3hpGMUlH6jLhMPB6Lm8BhdAgbXrHAhUbzeMkrhym8UUSei1s8uwLOfhdbAEmikd80TzPvr7o
 rjyGHOCy6tnCY8qPBKJcnp6ghtOvZbOC0ZI/Yp1B4=
X-Google-Smtp-Source: AGHT+IGs8nHkDmG1WlZxQ96qkOY5xK/vB6Y6qcUKD9Lbb7I5AbcRPEqeXN2fTH6Ry4gTSstUUQxOQA==
X-Received: by 2002:a17:903:110c:b0:1dc:f964:bfe1 with SMTP id
 n12-20020a170903110c00b001dcf964bfe1mr8271015plh.26.1709744969353; 
 Wed, 06 Mar 2024 09:09:29 -0800 (PST)
Received: from hsinchu16.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 p8-20020a170902e74800b001dd091cbc4esm7230076plf.181.2024.03.06.09.09.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Mar 2024 09:09:28 -0800 (PST)
From: Jason Chien <jason.chien@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Jason Chien <jason.chien@sifive.com>, Frank Chang <frank.chang@sifive.com>,
 Max Chou <max.chou@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH 2/5] target/riscv: Expose Zve32x extension to users
Date: Thu,  7 Mar 2024 01:08:35 +0800
Message-ID: <20240306170855.24341-3-jason.chien@sifive.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240306170855.24341-1-jason.chien@sifive.com>
References: <20240306170855.24341-1-jason.chien@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=jason.chien@sifive.com; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Jason Chien <jason.chien@sifive.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 10ccae3323..37e4557b47 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1469,6 +1469,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     MULTI_EXT_CFG_BOOL("zfh", ext_zfh, false),
     MULTI_EXT_CFG_BOOL("zfhmin", ext_zfhmin, false),
     MULTI_EXT_CFG_BOOL("zve32f", ext_zve32f, false),
+    MULTI_EXT_CFG_BOOL("zve32x", ext_zve32x, false),
     MULTI_EXT_CFG_BOOL("zve64f", ext_zve64f, false),
     MULTI_EXT_CFG_BOOL("zve64d", ext_zve64d, false),
     MULTI_EXT_CFG_BOOL("sstc", ext_sstc, true),
-- 
2.43.2


