Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A340C48297
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 11:07:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYOfF-0008Sc-Dy; Fri, 09 Feb 2024 06:03:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rYOdE-00072X-AQ
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 06:01:20 -0500
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rYOdA-0000rb-KV
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 06:01:18 -0500
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-5cedfc32250so604496a12.0
 for <qemu-devel@nongnu.org>; Fri, 09 Feb 2024 03:01:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707476475; x=1708081275; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dmHSNdHnhDq2AJSaiR4KwkctodRIy3iOT2bNdgCNIKY=;
 b=dFQJMgmxb72PV1SPwS/f8AS6AqPtAalCXXf91Sywpg4elJPLPc0eul82m5kglY5D8A
 BD3kGGxof20wQAkPvGslht2qtmUqOCWAHEcurxl5PPKD8LW8mR/P2rK7PdZA5IEtkmrC
 e6RWUwOfkC0LciYSaV7PzWAbXPBvNZXGkWYDc5NV6IytdzdTwJrefbGgOIlQyJpqmSsq
 xSuih7ywsxeLqd1gKGAnq5ixcIkmCObeSHnzBwtipgJxHAG9Uth0DenJ/GLVtLmVYxUA
 xa3oqjVSH0TW9O0Slsr1nG/TrQ9X5QmQzUdRirHy4RXUgh/T4r/7ZFSOyhBFm8vp8Tun
 J2UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707476475; x=1708081275;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dmHSNdHnhDq2AJSaiR4KwkctodRIy3iOT2bNdgCNIKY=;
 b=YXKr3ODC+e7f+ocXCsey2m7AyzY2VFMNFV/RVPQyS9YxyQXCiffqelChq+ujUhz+8v
 8xS5Ggi3o3WO8moH1IQogXMwhsEzk2t0NAdZZYJh15e9u4FKG/EE/LCyl2AKy/6RDhAD
 5wIrW1VQ3ALc+A0VI8ArysgnydIheCOrEJT9Bn4y+oV6M1T2NpZYJ/HiWfdyp+axtbpU
 Jlq989HB9ctrF0jBt/nPy+WX2uyBgc3ZC23JYAPlfUFa43WIdgskpHCNsydKofEojTHe
 3J1D38xpR8CXlRmHNqQWebVE9Uu2077rSQ8Rwcv+5T9OOm+IP/eds3kFUtexn7osbKx2
 k37A==
X-Gm-Message-State: AOJu0YygRB/oxy8R6fJwriYBMnTAe30Af/WQXr7LpO6PblH8a1MhE6Ee
 T7QITJ0goDuKTc+ZJjuSyslUzq5goxelppvm6IoJAbrCYGr7YuKVOVrYnP/gWXpL1g==
X-Google-Smtp-Source: AGHT+IFwKovQTZmUQBtvmCP5TTvQ5GLxEiQJb2REFjbMg/XQgKPHHILdoAzg7t0rhX3KB134nVcmVg==
X-Received: by 2002:a05:6a20:6f07:b0:19e:5fe5:ff98 with SMTP id
 gt7-20020a056a206f0700b0019e5fe5ff98mr1683221pzb.52.1707476474624; 
 Fri, 09 Feb 2024 03:01:14 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCV95rijoMr4d+pA5wKbDKu7eclQwjXJFHTXAMRqcTIma6ai4GQXskGB9J3QwqE+1M3pBNXyZWnSPlrM6uHJVEhJK+6EBkAy4dI81yCRNp/oP8Mj4pDNNa2Ag5D2OsfvgOmejcnz3DVPPpxwETM5l+e9Z9CfyS6dF9dbkRc=
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 d20-20020a637354000000b005d3bae243bbsm1473623pgn.4.2024.02.09.03.01.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Feb 2024 03:01:14 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Rob Bradford <rbradford@rivosinc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 52/61] target/riscv: Expose Zaamo and Zalrsc extensions
Date: Fri,  9 Feb 2024 20:58:04 +1000
Message-ID: <20240209105813.3590056-53-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240209105813.3590056-1-alistair.francis@wdc.com>
References: <20240209105813.3590056-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x52e.google.com
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

From: Rob Bradford <rbradford@rivosinc.com>

Expose the newly added extensions to the guest and allow their control
through the CPU properties.

Signed-off-by: Rob Bradford <rbradford@rivosinc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20240123111030.15074-4-rbradford@rivosinc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index be3ec5a25d..84902be070 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -108,7 +108,9 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zihintpause, PRIV_VERSION_1_10_0, ext_zihintpause),
     ISA_EXT_DATA_ENTRY(zihpm, PRIV_VERSION_1_12_0, ext_zihpm),
     ISA_EXT_DATA_ENTRY(zmmul, PRIV_VERSION_1_12_0, ext_zmmul),
+    ISA_EXT_DATA_ENTRY(zaamo, PRIV_VERSION_1_12_0, ext_zaamo),
     ISA_EXT_DATA_ENTRY(zacas, PRIV_VERSION_1_12_0, ext_zacas),
+    ISA_EXT_DATA_ENTRY(zalrsc, PRIV_VERSION_1_12_0, ext_zalrsc),
     ISA_EXT_DATA_ENTRY(zawrs, PRIV_VERSION_1_12_0, ext_zawrs),
     ISA_EXT_DATA_ENTRY(zfa, PRIV_VERSION_1_12_0, ext_zfa),
     ISA_EXT_DATA_ENTRY(zfbfmin, PRIV_VERSION_1_12_0, ext_zfbfmin),
@@ -1514,6 +1516,9 @@ const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[] = {
     MULTI_EXT_CFG_BOOL("x-smaia", ext_smaia, false),
     MULTI_EXT_CFG_BOOL("x-ssaia", ext_ssaia, false),
 
+    MULTI_EXT_CFG_BOOL("x-zaamo", ext_zaamo, false),
+    MULTI_EXT_CFG_BOOL("x-zalrsc", ext_zalrsc, false),
+
     MULTI_EXT_CFG_BOOL("x-zvfh", ext_zvfh, false),
     MULTI_EXT_CFG_BOOL("x-zvfhmin", ext_zvfhmin, false),
 
-- 
2.43.0


